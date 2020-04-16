Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8AA6D1AB489
	for <lists+linux-nfs@lfdr.de>; Thu, 16 Apr 2020 02:00:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730297AbgDPAAQ (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 15 Apr 2020 20:00:16 -0400
Received: from fieldses.org ([173.255.197.46]:50612 "EHLO fieldses.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730005AbgDPAAM (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Wed, 15 Apr 2020 20:00:12 -0400
Received: by fieldses.org (Postfix, from userid 2815)
        id A2AFBC51; Wed, 15 Apr 2020 20:00:09 -0400 (EDT)
Date:   Wed, 15 Apr 2020 20:00:09 -0400
From:   Bruce Fields <bfields@fieldses.org>
To:     Chuck Lever <chuck.lever@oracle.com>
Cc:     Jeff Layton <jlayton@kernel.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: GSS unwrapping breaks the DRC
Message-ID: <20200416000009.GA13083@fieldses.org>
References: <DAED9EC8-7461-48FF-AD6C-C85FB968F8A6@oracle.com>
 <20200415192542.GA6466@fieldses.org>
 <0775FBE7-C2DD-4ED6-955D-22B944F302E0@oracle.com>
 <20200415215823.GB6466@fieldses.org>
 <39815C35-EAD8-4B2E-B48F-88F3D5B10C57@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <39815C35-EAD8-4B2E-B48F-88F3D5B10C57@oracle.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Wed, Apr 15, 2020 at 06:23:57PM -0400, Chuck Lever wrote:
> 
> 
> > On Apr 15, 2020, at 5:58 PM, Bruce Fields <bfields@fieldses.org> wrote:
> > 
> > On Wed, Apr 15, 2020 at 04:06:17PM -0400, Chuck Lever wrote:
> >> 
> >> 
> >>> On Apr 15, 2020, at 3:25 PM, Bruce Fields <bfields@fieldses.org> wrote:
> >>> 
> >>> On Wed, Apr 15, 2020 at 01:05:11PM -0400, Chuck Lever wrote:
> >>>> Hi Bruce and Jeff:
> >>>> 
> >>>> Testing intensive workloads with NFSv3 and NFSv4.0 on NFS/RDMA with krb5i
> >>>> or krb5p results in a pretty quick workload failure. Closer examination
> >>>> shows that the client is able to overrun the GSS sequence window with
> >>>> some regularity. When that happens, the server drops the connection.
> >>>> 
> >>>> However, when the client retransmits requests with lost replies, they
> >>>> never hit in the DRC, and that results in unexpected failures of non-
> >>>> idempotent requests.
> >>>> 
> >>>> The retransmitted XIDs are found in the DRC, but the retransmitted request
> >>>> has a different checksum than the original. We're hitting the "mismatch"
> >>>> case in nfsd_cache_key_cmp for these requests.
> >>>> 
> >>>> I tracked down the problem to the way the DRC computes the length of the
> >>>> part of the buffer it wants to checksum. nfsd_cache_csum uses
> >>>> 
> >>>> head.iov_len + page_len
> >>>> 
> >>>> and then caps that at RC_CSUMLEN.
> >>>> 
> >>>> That works fine for krb5 and sys, but the GSS unwrap functions
> >>>> (integ_unwrap_data and priv_unwrap_data) don't appear to update head.iov_len
> >>>> properly. So nfsd_cache_csum's length computation is significantly larger
> >>>> than the clear-text message, and that allows stale parts of the xdr_buf
> >>>> to be included in the checksum.
> >>>> 
> >>>> Using xdr_buf_subsegment() at the end of integ_unwrap_data sets the xdr_buf
> >>>> lengths properly and fixes the situation for krb5i.
> >>>> 
> >>>> I don't see a similar solution for priv_unwrap_data: there's no MIC len
> >>>> available, and priv_len is not the actual length of the clear-text message.
> >>>> 
> >>>> Moreover, the comment in fix_priv_head() is disturbing. I don't see anywhere
> >>>> where the relationship between the buf's head/len and how svc_defer works is
> >>>> authoritatively documented. It's not clear exactly how priv_unwrap_data is
> >>>> supposed to accommodate svc_defer, or whether integ_unwrap_data also needs
> >>>> to accommodate it.
> >>>> 
> >>>> So I can't tell if the GSS unwrap functions are wrong or if there's a more
> >>>> accurate way to compute the message length in nfsd_cache_csum. I suspect
> >>>> both could use some improvement, but I'm not certain exactly what that
> >>>> might be.
> >>> 
> >>> I don't know, I tried looking through that code and didn't get any
> >>> further than you.  The gss unwrap code does look suspect to me.  It
> >>> needs some kind of proper design, as it stands it's just an accumulation
> >>> of fixes.
> >> 
> >> Having recently completed overhauling the client-side equivalents, I
> >> agree with you there.
> >> 
> >> I've now convinced myself that because nfsd_cache_csum might need to
> >> advance into the first page of the Call message, rq_arg.head.iov_len
> >> must contain an accurate length so that csum_partial is applied
> >> correctly to the head buffer.
> >> 
> >> Therefore it is the preceding code that needs to set up rq_arg.head.iov_len
> >> correctly. The GSS unwrap functions have to do this, and therefore these
> >> must be fixed. I would theorize that svc_defer also depends on head.iov_len
> >> being set correctly.
> >> 
> >> As far as how rq_arg.len needs to be set for svc_defer, I think I need
> >> to have some kind of test case to examine how that path is triggered. Any
> >> advice appreciated.
> > 
> > It's triggered on upcalls, so for example if you flush the export caches
> > with exports -f and then send an rpc with a filehandle, it should call
> > svc_defer on that request.
> 
> /me puts a brown paper bag over his head
> 
> Reverting 241b1f419f0e ("SUNRPC: Remove xdr_buf_trim()") seems to fix both
> krb5i and krb5p.

Well, it has my ack too....

> I'll post an official patch once I've done a little more testing. I promise
> to get the Fixes: tag right :-)

I did have it in the back of my mind that one of us had fixed a similar
bug before.  Indeed, Jeff's:

	4c190e2f913f "sunrpc: trim off trailing checksum before
		returning decrypted or integrity authenticated buffer"

explains exactly the bug you saw.

Maybe some of that changelog should move into a code comment instead.

And I still think the code is more accidents waiting to happen.

--b.

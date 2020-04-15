Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6879D1AB191
	for <lists+linux-nfs@lfdr.de>; Wed, 15 Apr 2020 21:27:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405375AbgDOT1K (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 15 Apr 2020 15:27:10 -0400
Received: from fieldses.org ([173.255.197.46]:50512 "EHLO fieldses.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729378AbgDOTZn (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Wed, 15 Apr 2020 15:25:43 -0400
Received: by fieldses.org (Postfix, from userid 2815)
        id 64C941C89; Wed, 15 Apr 2020 15:25:42 -0400 (EDT)
Date:   Wed, 15 Apr 2020 15:25:42 -0400
From:   Bruce Fields <bfields@fieldses.org>
To:     Chuck Lever <chuck.lever@oracle.com>
Cc:     Jeff Layton <jlayton@kernel.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: GSS unwrapping breaks the DRC
Message-ID: <20200415192542.GA6466@fieldses.org>
References: <DAED9EC8-7461-48FF-AD6C-C85FB968F8A6@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DAED9EC8-7461-48FF-AD6C-C85FB968F8A6@oracle.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Wed, Apr 15, 2020 at 01:05:11PM -0400, Chuck Lever wrote:
> Hi Bruce and Jeff:
> 
> Testing intensive workloads with NFSv3 and NFSv4.0 on NFS/RDMA with krb5i
> or krb5p results in a pretty quick workload failure. Closer examination
> shows that the client is able to overrun the GSS sequence window with
> some regularity. When that happens, the server drops the connection.
> 
> However, when the client retransmits requests with lost replies, they
> never hit in the DRC, and that results in unexpected failures of non-
> idempotent requests.
> 
> The retransmitted XIDs are found in the DRC, but the retransmitted request
> has a different checksum than the original. We're hitting the "mismatch"
> case in nfsd_cache_key_cmp for these requests.
> 
> I tracked down the problem to the way the DRC computes the length of the
> part of the buffer it wants to checksum. nfsd_cache_csum uses
> 
>   head.iov_len + page_len
> 
> and then caps that at RC_CSUMLEN.
> 
> That works fine for krb5 and sys, but the GSS unwrap functions
> (integ_unwrap_data and priv_unwrap_data) don't appear to update head.iov_len
> properly. So nfsd_cache_csum's length computation is significantly larger
> than the clear-text message, and that allows stale parts of the xdr_buf
> to be included in the checksum.
> 
> Using xdr_buf_subsegment() at the end of integ_unwrap_data sets the xdr_buf
> lengths properly and fixes the situation for krb5i.
> 
> I don't see a similar solution for priv_unwrap_data: there's no MIC len
> available, and priv_len is not the actual length of the clear-text message.
> 
> Moreover, the comment in fix_priv_head() is disturbing. I don't see anywhere
> where the relationship between the buf's head/len and how svc_defer works is
> authoritatively documented. It's not clear exactly how priv_unwrap_data is
> supposed to accommodate svc_defer, or whether integ_unwrap_data also needs
> to accommodate it.
> 
> So I can't tell if the GSS unwrap functions are wrong or if there's a more
> accurate way to compute the message length in nfsd_cache_csum. I suspect
> both could use some improvement, but I'm not certain exactly what that
> might be.

I don't know, I tried looking through that code and didn't get any
further than you.  The gss unwrap code does look suspect to me.  It
needs some kind of proper design, as it stands it's just an accumulation
of fixes.

--b.

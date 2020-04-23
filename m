Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5FF9E1B6483
	for <lists+linux-nfs@lfdr.de>; Thu, 23 Apr 2020 21:34:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728782AbgDWTeG (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 23 Apr 2020 15:34:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728308AbgDWTeG (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 23 Apr 2020 15:34:06 -0400
Received: from fieldses.org (fieldses.org [IPv6:2600:3c00::f03c:91ff:fe50:41d6])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E81FC09B042
        for <linux-nfs@vger.kernel.org>; Thu, 23 Apr 2020 12:34:06 -0700 (PDT)
Received: by fieldses.org (Postfix, from userid 2815)
        id 757D414DC; Thu, 23 Apr 2020 15:34:05 -0400 (EDT)
Date:   Thu, 23 Apr 2020 15:34:05 -0400
From:   Bruce Fields <bfields@fieldses.org>
To:     Chuck Lever <chuck.lever@oracle.com>
Cc:     Trond Myklebust <trondmy@hammerspace.com>,
        Jeff Layton <jlayton@kernel.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: GSS unwrapping breaks the DRC
Message-ID: <20200423193405.GB4561@fieldses.org>
References: <DAED9EC8-7461-48FF-AD6C-C85FB968F8A6@oracle.com>
 <20200415192542.GA6466@fieldses.org>
 <0775FBE7-C2DD-4ED6-955D-22B944F302E0@oracle.com>
 <20200415215823.GB6466@fieldses.org>
 <39815C35-EAD8-4B2E-B48F-88F3D5B10C57@oracle.com>
 <AA069628-0668-4F15-8C29-23997D04185B@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <AA069628-0668-4F15-8C29-23997D04185B@oracle.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Fri, Apr 17, 2020 at 05:48:35PM -0400, Chuck Lever wrote:
> I've hit a snag here.
> 
> I reverted 241b1f419f0e on my server, and all tests completed
> successfully.
> 
> I reverted 241b1f419f0e on my client, and now krb5p is failing. Using
> xdr_buf_trim does the right thing on the server, but on the client it
> has exposed a latent bug in gss_unwrap_resp_priv() (ie, the bug does
> not appear to be harmful until 241b1f419f0e has been reverted).
> 
> The calculation of au_ralign in that function is wrong, and that forces
> rpc_prepare_reply_pages to allocate a zero-length tail. xdr_buf_trim()
> then lops off the end of each subsequent clear-text RPC message, and
> eventually a short READ results in test failures.
> 
> After experimenting with this for a day, I don't see any way for
> gss_unwrap_resp_priv() to estimate au_ralign based on what gss_unwrap()
> has done to the xdr_buf. The kerberos_v1 unwrap method does not appear
> to have any trailing checksum, for example, but v2 does.
> 
> The best approach for now seems to be to have the pseudoflavor-specific
> unwrap methods return the correct ralign value. A straightforward way
> to do this would be to add a *int parameter to ->gss_unwrap that would
> be set to the proper value; or hide that value somewhere in the xdr_buf.
> 
> Any other thoughts or random bits of inspiration?

No.  Among other things, a quick skim wasn't enough to remind me what
au_ralign is and why we have both that and au_rslack....  Sorry!  I've
got not much to offer but sympathy.

...

I have a random thought out of left field: after the xdr_stream
conversion, fs/nfs/nfs4xdr.c mostly doesn't deal directly with the reply
buffer any more.  It calls xdr_inline_decode(xdr, n) and gets back a
pointer to the next n bytes of rpc data.  Or it calls xdr_read_pages()
after which read data's supposed to be moved to the right place.

Would it be possible to delay rpcsec_gss decoding until then?  Would
that make things simpler or more complicated?

Eh, I think the answer is probably "more complicated".

--b.

Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 76AA630795C
	for <lists+linux-nfs@lfdr.de>; Thu, 28 Jan 2021 16:18:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231236AbhA1PSF (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 28 Jan 2021 10:18:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229728AbhA1PR5 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 28 Jan 2021 10:17:57 -0500
Received: from fieldses.org (fieldses.org [IPv6:2600:3c00:e000:2f7::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40C17C061574;
        Thu, 28 Jan 2021 07:17:17 -0800 (PST)
Received: by fieldses.org (Postfix, from userid 2815)
        id C826B4599; Thu, 28 Jan 2021 10:17:15 -0500 (EST)
DKIM-Filter: OpenDKIM Filter v2.11.0 fieldses.org C826B4599
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fieldses.org;
        s=default; t=1611847035;
        bh=FZYksZ+xxCQyFfy7d8pSVmgkeucghwwUsQVzWsdSYDw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=RkrJOVeDVcr67fOmQOYN6RgMZE178IyjlZRHLXjOQf33ge9YxdTmt9DFxdziNSU4y
         0KbQjAnUL2xtLIBAsnYDU7ZeMv8DpRgAPHvaVQ79qw0QuiQ6PIG42ouVkhpKZ2m/uB
         1n8jrGc4MBBqX1L4LdilAQMmR4yz/L1DSXFVxkzI=
Date:   Thu, 28 Jan 2021 10:17:15 -0500
From:   Bruce Fields <bfields@fieldses.org>
To:     Chuck Lever <chuck.lever@oracle.com>
Cc:     Colin King <colin.king@canonical.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH][next] nfsd: fix check of statid returned from call to
 find_stateid_by_type
Message-ID: <20210128151715.GA29887@fieldses.org>
References: <20210128144935.640026-1-colin.king@canonical.com>
 <793C88A3-B117-4138-B74A-845E0BD383C9@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <793C88A3-B117-4138-B74A-845E0BD383C9@oracle.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Thu, Jan 28, 2021 at 03:05:06PM +0000, Chuck Lever wrote:
> Hi Colin-
> 
> > On Jan 28, 2021, at 9:49 AM, Colin King <colin.king@canonical.com> wrote:
> > 
> > From: Colin Ian King <colin.king@canonical.com>
> > 
> > The call to find_stateid_by_type is setting the return value in *stid
> > yet the NULL check of the return is checking stid instead of *stid.
> > Fix this by adding in the missing pointer * operator.
> > 
> > Addresses-Coverity: ("Dereference before null check")
> > Fixes: 6cdaa72d4dde ("nfsd: find_cpntf_state cleanup")
> > Signed-off-by: Colin Ian King <colin.king@canonical.com>
> 
> Thanks for your patch. I've committed it to the for-next branch at
> 
> git://git.kernel.org/pub/scm/linux/kernel/git/cel/linux.git
> 
> in preparation for the v5.12 merge window, with the following changes:
> 
> - ^statid^stateid
> - Fixes: tag removed, since no stable backport is necessary

Please keep the "Fixes:" tag!  It's still very useful information.  For
example, if someone needs to backport the original patch, this is a
reminder they'll want this one as well.

(Of course, if you fold this patch into the earlier one instead, that's
a different situation.)

--b.

> The commit you are fixing has not been merged upstream yet.
> 
> 
> > ---
> > fs/nfsd/nfs4state.c | 2 +-
> > 1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
> > index f554e3480bb1..423fd6683f3a 100644
> > --- a/fs/nfsd/nfs4state.c
> > +++ b/fs/nfsd/nfs4state.c
> > @@ -5824,7 +5824,7 @@ static __be32 find_cpntf_state(struct nfsd_net *nn, stateid_t *st,
> > 
> > 	*stid = find_stateid_by_type(found, &cps->cp_p_stateid,
> > 			NFS4_DELEG_STID|NFS4_OPEN_STID|NFS4_LOCK_STID);
> > -	if (stid)
> > +	if (*stid)
> > 		status = nfs_ok;
> > 	else
> > 		status = nfserr_bad_stateid;
> > -- 
> > 2.29.2
> > 
> 
> --
> Chuck Lever
> 
> 

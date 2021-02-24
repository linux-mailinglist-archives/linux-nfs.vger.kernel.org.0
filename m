Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 421B2324586
	for <lists+linux-nfs@lfdr.de>; Wed, 24 Feb 2021 22:00:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232290AbhBXVAS (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 24 Feb 2021 16:00:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232058AbhBXVAR (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 24 Feb 2021 16:00:17 -0500
Received: from fieldses.org (fieldses.org [IPv6:2600:3c00:e000:2f7::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F21D9C061574
        for <linux-nfs@vger.kernel.org>; Wed, 24 Feb 2021 12:59:37 -0800 (PST)
Received: by fieldses.org (Postfix, from userid 2815)
        id 6C4BA21DD; Wed, 24 Feb 2021 15:59:37 -0500 (EST)
DKIM-Filter: OpenDKIM Filter v2.11.0 fieldses.org 6C4BA21DD
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fieldses.org;
        s=default; t=1614200377;
        bh=KmcGi/MpXXC2Of0/17qM/ZYTO/w0JvJzW19zUXFGk0I=;
        h=Date:To:Cc:Subject:References:In-Reply-To:From:From;
        b=HfWt9tpOIxdlxHFV8C1VCNH8D21m3/FkTv6YZxd4UymKEpoXuNlVeeYE0qE+WxdVF
         wchT8l69i/XCHoGctPJ2kJsaE9jo2CpvIB+OhzbHVnTgD+i2N5GYN+WCSUIKF7YxQs
         ket8/FhQ8O+ZDA44KGdJ0XCcBBpQha7J1qU6sa9g=
Date:   Wed, 24 Feb 2021 15:59:37 -0500
To:     trondmy@kernel.org
Cc:     "J. Bruce Fields" <bfields@redhat.com>,
        Chuck Lever <chuck.lever@oracle.com>, linux-nfs@vger.kernel.org
Subject: Re: [PATCH] nfsd: Don't keep looking up unhashed files in the nfsd
 file cache
Message-ID: <20210224205937.GH11591@fieldses.org>
References: <20210219020207.688592-1-trondmy@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210219020207.688592-1-trondmy@kernel.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
From:   bfields@fieldses.org (J. Bruce Fields)
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Thu, Feb 18, 2021 at 09:02:07PM -0500, trondmy@kernel.org wrote:
> From: Trond Myklebust <trond.myklebust@hammerspace.com>
> 
> If a file is unhashed, then we're going to reject it anyway and retry,
> so make sure we skip it when we're doing the RCU lockless lookup.
> This avoids a number of unnecessary nfserr_jukebox returns from
> nfsd_file_acquire()

Looks good to me.--b.

> 
> Fixes: 65294c1f2c5e ("nfsd: add a new struct file caching facility to nfsd")
> Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
> ---
>  fs/nfsd/filecache.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/fs/nfsd/filecache.c b/fs/nfsd/filecache.c
> index 53fcbf79bdca..7629248fdd53 100644
> --- a/fs/nfsd/filecache.c
> +++ b/fs/nfsd/filecache.c
> @@ -898,6 +898,8 @@ nfsd_file_find_locked(struct inode *inode, unsigned int may_flags,
>  			continue;
>  		if (!nfsd_match_cred(nf->nf_cred, current_cred()))
>  			continue;
> +		if (!test_bit(NFSD_FILE_HASHED, &nf->nf_flags))
> +			continue;
>  		if (nfsd_file_get(nf) != NULL)
>  			return nf;
>  	}
> -- 
> 2.29.2

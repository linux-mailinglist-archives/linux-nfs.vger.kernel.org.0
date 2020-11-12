Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0FEFB2B0736
	for <lists+linux-nfs@lfdr.de>; Thu, 12 Nov 2020 15:03:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728089AbgKLODl (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 12 Nov 2020 09:03:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727646AbgKLODl (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 12 Nov 2020 09:03:41 -0500
Received: from fieldses.org (fieldses.org [IPv6:2600:3c00:e000:2f7::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46BB2C0613D1
        for <linux-nfs@vger.kernel.org>; Thu, 12 Nov 2020 06:03:41 -0800 (PST)
Received: by fieldses.org (Postfix, from userid 2815)
        id B1ECF200D; Thu, 12 Nov 2020 09:03:40 -0500 (EST)
DKIM-Filter: OpenDKIM Filter v2.11.0 fieldses.org B1ECF200D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fieldses.org;
        s=default; t=1605189820;
        bh=2WIRvPt7Vxd+c58TxlOYQDoAfAYi3ZLfBSJaYTEfQkQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=vg29WQ88y7/pUFkIEvrlm7tFZX1/ZWC1Brp50/qFublVnVUo0Wkc0heNs0jKESm/n
         WRFuz3rfKH0xhAINZrDt7hcxydAPPSdDNi75XHiqG7IbCjlwC/oBulqLpqjIctwZ+6
         Fh+KCX3GJyQ9QVn4ltEHEMvrRnfY9IT7We32ogR8=
Date:   Thu, 12 Nov 2020 09:03:40 -0500
From:   "J. Bruce Fields" <bfields@fieldses.org>
To:     Trond Myklebust <trondmy@hammerspace.com>,
        Anna Schumaker <schumakeranna@gmail.com>
Cc:     linux-nfs@vger.kernel.org
Subject: Re: [PATCH] NFSv4.2: fix failure to unregister shrinker
Message-ID: <20201112140340.GB9243@fieldses.org>
References: <20201021143415.GA27122@fieldses.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201021143415.GA27122@fieldses.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Looks like this patch got lost, do you need me to resend?

I should also have added a stable cc and a

	Fixes: 95ad37f90c33 "NFSv4.2: add client side xattr caching."

--b.

On Wed, Oct 21, 2020 at 10:34:15AM -0400, bfields wrote:
> From: "J. Bruce Fields" <bfields@redhat.com>
> 
> We forgot to unregister the nfs4_xattr_large_entry_shrinker.
> 
> That leaves the global list of shrinkers corrupted after unload of the
> nfs module, after which possibly unrelated code that calls
> register_shrinker() or unregister_shrinker() gets a BUG() with
> "supervisor write access in kernel mode".
> 
> And similarly for the nfs4_xattr_large_entry_lru.
> 
> Reported-by: Kris Karas <bugs-a17@moonlit-rail.com>
> Tested-By: Kris Karas <bugs-a17@moonlit-rail.com>
> Signed-off-by: J. Bruce Fields <bfields@redhat.com>
> ---
>  fs/nfs/nfs42xattr.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/fs/nfs/nfs42xattr.c b/fs/nfs/nfs42xattr.c
> index 86777996cfec..55b44a42d625 100644
> --- a/fs/nfs/nfs42xattr.c
> +++ b/fs/nfs/nfs42xattr.c
> @@ -1048,8 +1048,10 @@ int __init nfs4_xattr_cache_init(void)
>  
>  void nfs4_xattr_cache_exit(void)
>  {
> +	unregister_shrinker(&nfs4_xattr_large_entry_shrinker);
>  	unregister_shrinker(&nfs4_xattr_entry_shrinker);
>  	unregister_shrinker(&nfs4_xattr_cache_shrinker);
> +	list_lru_destroy(&nfs4_xattr_large_entry_lru);
>  	list_lru_destroy(&nfs4_xattr_entry_lru);
>  	list_lru_destroy(&nfs4_xattr_cache_lru);
>  	kmem_cache_destroy(nfs4_xattr_cache_cachep);
> -- 
> 2.26.2
> 

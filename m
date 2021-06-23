Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F4053B229E
	for <lists+linux-nfs@lfdr.de>; Wed, 23 Jun 2021 23:41:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229726AbhFWVnd (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 23 Jun 2021 17:43:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229688AbhFWVnd (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 23 Jun 2021 17:43:33 -0400
Received: from fieldses.org (fieldses.org [IPv6:2600:3c00:e000:2f7::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA0FEC061574
        for <linux-nfs@vger.kernel.org>; Wed, 23 Jun 2021 14:41:15 -0700 (PDT)
Received: by fieldses.org (Postfix, from userid 2815)
        id 48DB46208; Wed, 23 Jun 2021 17:41:15 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 fieldses.org 48DB46208
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fieldses.org;
        s=default; t=1624484475;
        bh=9sNeFpKJd7lYHINt2UUVPhtvYks6akRRTWuCtfQ9E6k=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Nl4cfpn7co0gTgLAmnu7ZPCGzfjQ14TtJPxcgxjIWHdMJQ3pfus69iy7dg4eGo6B3
         Jv36/hh4PR4v51NYLlQhNxdRLhDPULGMOSnVMwBh4hRCuDh5hU5cwNnBfAafr6W2f4
         5EhSRl/DzuU5wY35pRAHigD79VatwII1t0rdiZSM=
Date:   Wed, 23 Jun 2021 17:41:15 -0400
From:   "J . Bruce Fields" <bfields@fieldses.org>
To:     Zhen Lei <thunder.leizhen@huawei.com>
Cc:     Chuck Lever <chuck.lever@oracle.com>,
        linux-nfs <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH 1/1] nfsd: remove unnecessary oom message
Message-ID: <20210623214115.GH20232@fieldses.org>
References: <20210617090458.1491-1-thunder.leizhen@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210617090458.1491-1-thunder.leizhen@huawei.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Thu, Jun 17, 2021 at 05:04:57PM +0800, Zhen Lei wrote:
> Fixes scripts/checkpatch.pl warning:
> WARNING: Possible unnecessary 'out of memory' message
> 
> Remove it can help us save a bit of memory.

On a quick check, I think the other 6 pr_err()s in here also (pretty
unlikely) allocation failures, may as well remove those too?

--b.

> Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
> ---
>  fs/nfsd/filecache.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/fs/nfsd/filecache.c b/fs/nfsd/filecache.c
> index 7629248fdd53..76d68b2b4ba2 100644
> --- a/fs/nfsd/filecache.c
> +++ b/fs/nfsd/filecache.c
> @@ -643,10 +643,8 @@ nfsd_file_cache_init(void)
>  
>  	nfsd_file_hashtbl = kcalloc(NFSD_FILE_HASH_SIZE,
>  				sizeof(*nfsd_file_hashtbl), GFP_KERNEL);
> -	if (!nfsd_file_hashtbl) {
> -		pr_err("nfsd: unable to allocate nfsd_file_hashtbl\n");
> +	if (!nfsd_file_hashtbl)
>  		goto out_err;
> -	}
>  
>  	nfsd_file_slab = kmem_cache_create("nfsd_file",
>  				sizeof(struct nfsd_file), 0, 0, NULL);
> -- 
> 2.25.1
> 

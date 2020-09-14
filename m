Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E7FCD2696CC
	for <lists+linux-nfs@lfdr.de>; Mon, 14 Sep 2020 22:36:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726031AbgINUgi (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 14 Sep 2020 16:36:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725979AbgINUga (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 14 Sep 2020 16:36:30 -0400
Received: from fieldses.org (fieldses.org [IPv6:2600:3c00:e000:2f7::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06375C06174A;
        Mon, 14 Sep 2020 13:36:29 -0700 (PDT)
Received: by fieldses.org (Postfix, from userid 2815)
        id 2712BBC3; Mon, 14 Sep 2020 16:36:28 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 fieldses.org 2712BBC3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fieldses.org;
        s=default; t=1600115788;
        bh=XmXX13dDwCtwDS9GIOR/1zXwwSIFQOW0jwJ0UAz4XIY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mz7fO1v5YhmRe+BgXn04HmtMBy9NFm6g0zQAJT8IGhfUNT+sXmTOcrP5aIugGx/k2
         QpuKHh/K5YwNUWP4ABOEKnrD8OCg9+s1PHFNwUCG92ii1bAcbvnUgtUNDavrUwtZSN
         f+q4nKjP98/l/lk49jD3NtEH6vXLl8/2rLfAZIko=
Date:   Mon, 14 Sep 2020 16:36:28 -0400
From:   "J. Bruce Fields" <bfields@fieldses.org>
To:     Rik van Riel <riel@surriel.com>
Cc:     Chuck Lever <chuck.lever@oracle.com>, linux-nfs@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH] silence nfscache allocation warnings with kvzalloc
Message-ID: <20200914203628.GC30007@fieldses.org>
References: <20200914130719.247cccb0@imladris.surriel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200914130719.247cccb0@imladris.surriel.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Applying, thanks.--b.

On Mon, Sep 14, 2020 at 01:07:19PM -0400, Rik van Riel wrote:
> silence nfscache allocation warnings with kvzalloc
> 
> Currently nfsd_reply_cache_init attempts hash table allocation through
> kmalloc, and manually falls back to vzalloc if that fails. This makes
> the code a little larger than needed, and creates a significant amount
> of serial console spam if you have enough systems.
> 
> Switching to kvzalloc gets rid of the allocation warnings, and makes
> the code a little cleaner too as a side effect.
> 
> Freeing of nn->drc_hashtbl is already done using kvfree currently.
> 
> Signed-off-by: Rik van Riel <riel@surriel.com>
> ---
> diff --git a/fs/nfsd/nfscache.c b/fs/nfsd/nfscache.c
> index 96352ab7bd81..5125b5ef25b6 100644
> --- a/fs/nfsd/nfscache.c
> +++ b/fs/nfsd/nfscache.c
> @@ -164,14 +164,10 @@ int nfsd_reply_cache_init(struct nfsd_net *nn)
>  	if (!nn->drc_slab)
>  		goto out_shrinker;
>  
> -	nn->drc_hashtbl = kcalloc(hashsize,
> -				sizeof(*nn->drc_hashtbl), GFP_KERNEL);
> -	if (!nn->drc_hashtbl) {
> -		nn->drc_hashtbl = vzalloc(array_size(hashsize,
> -						 sizeof(*nn->drc_hashtbl)));
> -		if (!nn->drc_hashtbl)
> -			goto out_slab;
> -	}
> +	nn->drc_hashtbl = kvzalloc(array_size(hashsize,
> +				   sizeof(*nn->drc_hashtbl)), GFP_KERNEL);
> +	if (!nn->drc_hashtbl)
> +		goto out_slab;
>  
>  	for (i = 0; i < hashsize; i++) {
>  		INIT_LIST_HEAD(&nn->drc_hashtbl[i].lru_head);

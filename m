Return-Path: <linux-nfs+bounces-4510-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C13BA91F08D
	for <lists+linux-nfs@lfdr.de>; Tue,  2 Jul 2024 09:54:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7CEBD283F8B
	for <lists+linux-nfs@lfdr.de>; Tue,  2 Jul 2024 07:54:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3704B7829C;
	Tue,  2 Jul 2024 07:54:22 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8185C14D2B2
	for <linux-nfs@vger.kernel.org>; Tue,  2 Jul 2024 07:54:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719906862; cv=none; b=jl5QXf8Co6PuLHdD01Z8V79gy7DO4u1y/UEUyY5dlx3/BVJhSakawmhDLbRyuHeDRKUJ7r+uXda2FBot/NCJgZCylM0B1d5+1gShYkHpu9syP3s+9IXQFJBxXgFuOXLXYO621Hj2YFsiLpzAGJW3hiYWcTpghxUTEb5R4w+VOsQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719906862; c=relaxed/simple;
	bh=KhBR6Ps9M+0gsmPBwV/JWzjarNDhpu9dxvQ8ZHOXwlQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=L4e6gVcuUVh9AMDDJKf8rw/r/070PR/NuckIUq+mWI2QHxAnQmeqHvAXTFljsCgOT8hdHqMOK2V7uSi6LBotE9bwmyJ9dE4OHgJB8CA5fHL79r6OpyCk3vDh9mJBQk41v676BUjy2qdbXcRvRhpTMFy4NZBQ1ETbEmusIsm4uRE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-363ba6070b1so228323f8f.0
        for <linux-nfs@vger.kernel.org>; Tue, 02 Jul 2024 00:54:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719906859; x=1720511659;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6vVNaif7G6tItNNzLkdUqMGc81zoI9dMTYEZYmXjbCU=;
        b=Y5R2adxkFrXBFbbQNmdJV3rL94yYlUc7ksPayuyT2lgJk/kJhrYM+1E/cWlX7w8BPF
         GiXLTmrX1t5FBkWMxdGNGBTuqskLI9ocAxn10e6rhG4lFexk5y18Yzc2O0RqmyUVmE/G
         nP8iVY5yx2+MOOG2qAG8MMkB6MSF29aomWVEfvpMELyEFGeWehpPELHOJlJs7mRwmnFh
         +subdgrcrZKmo9achPJTdO4AYqrL4g3b9sxVAp5EuP/mL14p+qlaNrt1foVRN+xEHPTl
         hhdTRIiW+UFvmKp6ekl0W7QwVtYAKGpLGzVUwNxHxMeyV5X0OtdU8H2F+O4sQuX3Z+rw
         jPBA==
X-Gm-Message-State: AOJu0Yw/E+q4BUJ8KtHfl4BEz9lkbkYO/K3ocETMKN1TWHCzxIXWqQeH
	fZtLKJzHZ01FCFMjK1L8uHISEC/h+WM5UqBTwmJR+hLTng+1lwygZcURGg==
X-Google-Smtp-Source: AGHT+IEplgAEl6b/YX6INxGxGi6tATyKmYdfhZQV10ZCC03qloHgGnQtl59jRMWpANwL2E0rjBWL2g==
X-Received: by 2002:a5d:5f56:0:b0:366:e496:1caa with SMTP id ffacd0b85a97d-36775729105mr4975649f8f.5.1719906858705;
        Tue, 02 Jul 2024 00:54:18 -0700 (PDT)
Received: from [10.50.4.180] (bzq-84-110-32-226.static-ip.bezeqint.net. [84.110.32.226])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4257dee5f2asm97457265e9.22.2024.07.02.00.54.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Jul 2024 00:54:18 -0700 (PDT)
Message-ID: <e00e5ffc-8724-4dcb-868e-2a9d23531648@grimberg.me>
Date: Tue, 2 Jul 2024 10:54:17 +0300
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/7] nfs: simplify nfs_folio_find_and_lock_request
To: Christoph Hellwig <hch@lst.de>, Trond Myklebust <trondmy@kernel.org>,
 Anna Schumaker <anna@kernel.org>
Cc: linux-nfs@vger.kernel.org
References: <20240701052707.1246254-1-hch@lst.de>
 <20240701052707.1246254-4-hch@lst.de>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20240701052707.1246254-4-hch@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 01/07/2024 8:26, Christoph Hellwig wrote:
> nfs_folio_find_and_lock_request and the nfs_page_group_lock_head helper
> called by it spend quite some effort to deal with head vs subrequests.
> But given that only the head request can be stashed in the folio private
> data, non of that is required.
>
> Fold the locking logic from nfs_page_group_lock_head into
> nfs_folio_find_and_lock_request and simplify the result based on the
> invariant that we always find the head request in the folio private data.
>
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>   fs/nfs/pagelist.c        | 19 -------------------
>   fs/nfs/write.c           | 38 +++++++++++++++++++++-----------------
>   include/linux/nfs_page.h |  1 -
>   3 files changed, 21 insertions(+), 37 deletions(-)
>
> diff --git a/fs/nfs/pagelist.c b/fs/nfs/pagelist.c
> index 3b006bcbcc87a2..e48cc69a2361aa 100644
> --- a/fs/nfs/pagelist.c
> +++ b/fs/nfs/pagelist.c
> @@ -187,25 +187,6 @@ nfs_async_iocounter_wait(struct rpc_task *task, struct nfs_lock_context *l_ctx)
>   }
>   EXPORT_SYMBOL_GPL(nfs_async_iocounter_wait);
>   
> -/*
> - * nfs_page_lock_head_request - page lock the head of the page group
> - * @req: any member of the page group
> - */
> -struct nfs_page *
> -nfs_page_group_lock_head(struct nfs_page *req)
> -{
> -	struct nfs_page *head = req->wb_head;
> -
> -	while (!nfs_lock_request(head)) {
> -		int ret = nfs_wait_on_request(head);
> -		if (ret < 0)
> -			return ERR_PTR(ret);
> -	}
> -	if (head != req)
> -		kref_get(&head->wb_kref);
> -	return head;
> -}
> -
>   /*
>    * nfs_unroll_locks -  unlock all newly locked reqs and wait on @req
>    * @head: head request of page group, must be holding head lock
> diff --git a/fs/nfs/write.c b/fs/nfs/write.c
> index 5410c18a006937..58e5b78ff436b9 100644
> --- a/fs/nfs/write.c
> +++ b/fs/nfs/write.c
> @@ -197,28 +197,32 @@ static struct nfs_page *nfs_folio_find_head_request(struct folio *folio)
>   static struct nfs_page *nfs_folio_find_and_lock_request(struct folio *folio)
>   {
>   	struct inode *inode = folio->mapping->host;
> -	struct nfs_page *req, *head;
> +	struct nfs_page *head;
>   	int ret;
>   
> -	for (;;) {
> -		req = nfs_folio_find_head_request(folio);
> -		if (!req)
> -			return req;
> -		head = nfs_page_group_lock_head(req);
> -		if (head != req)
> -			nfs_release_request(req);
> -		if (IS_ERR(head))
> -			return head;
> -		ret = nfs_cancel_remove_inode(head, inode);
> -		if (ret < 0) {
> -			nfs_unlock_and_release_request(head);
> +retry:
> +	head = nfs_folio_find_head_request(folio);

Is nfs_folio_find_head_reques() an appropriate name here? it doesn't 
search and find afaict (aside from internally the pnfs commits search). 
Anyways, Reviewed-by: Sagi Grimberg <sagi@grimberg.me>


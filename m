Return-Path: <linux-nfs+bounces-4514-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CF2791F0CB
	for <lists+linux-nfs@lfdr.de>; Tue,  2 Jul 2024 10:07:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0028C1F24257
	for <lists+linux-nfs@lfdr.de>; Tue,  2 Jul 2024 08:07:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD1B5146D57;
	Tue,  2 Jul 2024 08:07:18 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CACB2148311
	for <linux-nfs@vger.kernel.org>; Tue,  2 Jul 2024 08:07:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719907638; cv=none; b=FfV/DokdLxu7dgZpsgFz498xNI0AaPYfN0fB2fv74Zvhzt2NBq4p9O1zbJhKuXA2VY3As6xT2Mkv9itzlf0B0cgpJdu9IeNB0xSk3CCMPAOFcRXeMZRzyVLTD40nNLlrvhHObVsSPa3DaBGDICjIz97bYUpgf4xBvzSoXkoCyvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719907638; c=relaxed/simple;
	bh=DHDMeGk7CKAv2xEibhHmjZVYxisXlw4XGiZvo4Snnh8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=goZ2boy7d0GVwe7r3/ou2NyIP0INKYBhgHBp9Gg5ivxKjwp/501BnlEgRtaVSoP0j8ttV4GtVSuuyD2JhNRt/Ev8gcwXJzMgD+1h0j8b7+sbAJ+Xac52niTwZM1W19oj8aN/WL1NhiiS3O/00fxCRbUw4xr4GE22G6nUu8BX92w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-52ce17f6835so492983e87.1
        for <linux-nfs@vger.kernel.org>; Tue, 02 Jul 2024 01:07:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719907635; x=1720512435;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dehv0x3eY1bdZWkhi0nIANJIVOuT4A2UeSHT60eGVQU=;
        b=nCkYJzFy9vYhsbAoDQkvIdsxMx7+O/kF1c+iVZgKTvnEJsw9X0u2rC4ovjhGR3Nzwd
         O5+W2Tw46Wm4y8meFicxpYnj56X8uwwcyztTvEEynwsXZdNr08TTSworB8U3C7H7cRVY
         j0i40dQR+ND9QPYu/K6+KcvSqZS1aZ0aidOx1aEmNoTqo/8zY3jitFwi+QYOND/sW8s6
         BkPgcM8RRwcDGPXmKf0/UTJQXyM1EU43fARIIqEzrEabovq6hOE1MemtPd+Kas9f8Svo
         6llHB5gjj26lVM5Vds0m9L8AcMf1kiyyIkQAW6YRXE60kKHgmQN2A+kB/kbNx6tyrKor
         QTRg==
X-Gm-Message-State: AOJu0Yz4YgmzlUeo1o0XKN6sF3tesmRZ6q8ISFAE/aXgGSx+BH237jUE
	XvMrfVITiCXnJTgdI8NMDH22lx9DCrFieFGERo8RNbaK5fPLTlNV
X-Google-Smtp-Source: AGHT+IEgnUsnCj32P7eKPvUKLe/J0FTSi+yIJZbhNzAyhHcjIldWG0BL0CAcGvrlPTcjAnsVVjLFbg==
X-Received: by 2002:a05:6512:3b82:b0:52c:d7cc:33da with SMTP id 2adb3069b0e04-52e82781728mr4412992e87.5.1719907634298;
        Tue, 02 Jul 2024 01:07:14 -0700 (PDT)
Received: from [10.50.4.180] (bzq-84-110-32-226.static-ip.bezeqint.net. [84.110.32.226])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4256b097c2asm187137995e9.38.2024.07.02.01.07.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Jul 2024 01:07:14 -0700 (PDT)
Message-ID: <1bae89b5-0f11-4417-81f3-8fce05a9c751@grimberg.me>
Date: Tue, 2 Jul 2024 11:07:13 +0300
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 7/7] nfs: don't reuse partially completed requests in
 nfs_lock_and_join_requests
To: Christoph Hellwig <hch@lst.de>, Trond Myklebust <trondmy@kernel.org>,
 Anna Schumaker <anna@kernel.org>
Cc: linux-nfs@vger.kernel.org
References: <20240701052707.1246254-1-hch@lst.de>
 <20240701052707.1246254-8-hch@lst.de>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20240701052707.1246254-8-hch@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 01/07/2024 8:26, Christoph Hellwig wrote:
> When NFS requests are split into sub-requests, nfs_inode_remove_request
> calls nfs_page_group_sync_on_bit to set PG_REMOVE on this sub-request and
> only completes the head requests once PG_REMOVE is set on all requests.
> This means that when nfs_lock_and_join_requests sees a PG_REMOVE bit, I/O
> on the request is in progress and has partially completed.   If such a
> request is returned to nfs_try_to_update_request, it could be extended
> with the newly dirtied region and I/O for the combined range will be
> re-scheduled, leading to extra I/O.

Probably worth noting in the change log that large folios makes this 
potentially much
worse?

>
> Change the logic to instead restart the search for a request when any
> PG_REMOVE bit is set, as the completion handler will remove the request
> as soon as it can take the page group lock.  This not only avoid
> extending the I/O but also does the right thing for the callers that
> want to cancel or flush the request.
>
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>   fs/nfs/write.c | 49 ++++++++++++++++++++-----------------------------
>   1 file changed, 20 insertions(+), 29 deletions(-)
>
> diff --git a/fs/nfs/write.c b/fs/nfs/write.c
> index 2c089444303982..4dffdc5aadb2e2 100644
> --- a/fs/nfs/write.c
> +++ b/fs/nfs/write.c
> @@ -144,31 +144,6 @@ static void nfs_io_completion_put(struct nfs_io_completion *ioc)
>   		kref_put(&ioc->refcount, nfs_io_completion_release);
>   }
>   
> -static void
> -nfs_page_set_inode_ref(struct nfs_page *req, struct inode *inode)
> -{
> -	if (!test_and_set_bit(PG_INODE_REF, &req->wb_flags)) {
> -		kref_get(&req->wb_kref);
> -		atomic_long_inc(&NFS_I(inode)->nrequests);
> -	}
> -}
> -
> -static int
> -nfs_cancel_remove_inode(struct nfs_page *req, struct inode *inode)
> -{
> -	int ret;
> -
> -	if (!test_bit(PG_REMOVE, &req->wb_flags))
> -		return 0;
> -	ret = nfs_page_group_lock(req);
> -	if (ret)
> -		return ret;
> -	if (test_and_clear_bit(PG_REMOVE, &req->wb_flags))
> -		nfs_page_set_inode_ref(req, inode);
> -	nfs_page_group_unlock(req);
> -	return 0;
> -}
> -
>   /**
>    * nfs_folio_find_head_request - find head request associated with a folio
>    * @folio: pointer to folio
> @@ -564,6 +539,7 @@ static struct nfs_page *nfs_lock_and_join_requests(struct folio *folio)
>   	struct inode *inode = folio->mapping->host;
>   	struct nfs_page *head, *subreq;
>   	struct nfs_commit_info cinfo;
> +	bool removed;
>   	int ret;
>   
>   	/*
> @@ -588,18 +564,18 @@ static struct nfs_page *nfs_lock_and_join_requests(struct folio *folio)
>   		goto retry;
>   	}
>   
> -	ret = nfs_cancel_remove_inode(head, inode);
> -	if (ret < 0)
> -		goto out_unlock;
> -
>   	ret = nfs_page_group_lock(head);
>   	if (ret < 0)
>   		goto out_unlock;
>   
> +	removed = test_bit(PG_REMOVE, &head->wb_flags);
> +
>   	/* lock each request in the page group */
>   	for (subreq = head->wb_this_page;
>   	     subreq != head;
>   	     subreq = subreq->wb_this_page) {
> +		if (test_bit(PG_REMOVE, &subreq->wb_flags))
> +			removed = true;
>   		ret = nfs_page_group_lock_subreq(head, subreq);
>   		if (ret < 0)
>   			goto out_unlock;
> @@ -607,6 +583,21 @@ static struct nfs_page *nfs_lock_and_join_requests(struct folio *folio)
>   
>   	nfs_page_group_unlock(head);
>   
> +	/*
> +	 * If PG_REMOVE is set on any request, I/O on that request has
> +	 * completed, but some requests were still under I/O at the time
> +	 * we locked the head request.
> +	 *
> +	 * In that case the above wait for all requests means that all I/O
> +	 * has now finished, and we can restart from a clean slate.  Let the
> +	 * old requests go away and start from scratch instead.
> +	 */
> +	if (removed) {
> +		nfs_unroll_locks(head, head);
> +		nfs_unlock_and_release_request(head);
> +		goto retry;
> +	}

Don't you need a waitqueue or something to avoid excessive restarts 
until the
IO completes?


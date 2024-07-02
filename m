Return-Path: <linux-nfs+bounces-4511-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6968C91F098
	for <lists+linux-nfs@lfdr.de>; Tue,  2 Jul 2024 09:57:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 23D632819F2
	for <lists+linux-nfs@lfdr.de>; Tue,  2 Jul 2024 07:57:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C29AB12FF71;
	Tue,  2 Jul 2024 07:57:41 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B583144D36
	for <linux-nfs@vger.kernel.org>; Tue,  2 Jul 2024 07:57:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719907061; cv=none; b=B7dVWPI5nmuaYg4O+lY8gkAdv8FZJnqJpNVra6OFkfG23VpLWA6JniV02Sy7UrFYBv9A5Wnx5/j6XQ+6zPkfKj3eQDkPRheugNf8nxw4z653eS2lUtXlV/WMVmGpMD9MKaLohFhV+bTVO7BXgns4M8LS0pB+jZ4iDqUeG1S7FzA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719907061; c=relaxed/simple;
	bh=Ysdx2+WY1pSubB3dtoRiLdDshr1HSn4D1I/lnzXM0co=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ks4JJD0Grz3bzRvzXeQXfnDohaD81KseQvzu0xZGzVUSO+WdRwRos6m6snl1X6my/WaxusnuU1hTzFHi1soJQ5HGw2sEEX6PVF/bP+JxraXPxkoN7I6RzMox7Dc20yCRKhaVc8V2cjrmgouetQppwzpcGbWGloKEVk08U+mXT+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-366dcd38e6fso134230f8f.3
        for <linux-nfs@vger.kernel.org>; Tue, 02 Jul 2024 00:57:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719907058; x=1720511858;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HgDdFdnMdKu3Q3K3pj20MqbNjRnut1nB8dX6RK9GAgo=;
        b=r6CPXP+5VkPugZ4dwP4383nv6H0s77Kdi+YyWEYRnCd43tuB9nkJQ0bdauu0RmNjPD
         sI770zkKtS5rgFO1ulf5UQJ+4+StQR4J882TcCPogNvUen2RJNEyDGBP2SR6WmzOjvJ0
         bnG9XjGIQppNzSqfduNN3lgOKBpVtoPMy8kyiJhO29GguaHbgZdhtZ+yTp2U1znjoMUy
         4909QOCgyALGRJmPZ8NRrI9/sI0b8mvlEZDc20ohDrwURvJSy+ycP0CiEZ9aY4xfPZae
         yn2RIwpfwL2rd+SDcQFpgg2LZrhLAflkHag9s9/tQJba9H1+AuYqyMouEgzj4vwS3mMt
         jr2g==
X-Gm-Message-State: AOJu0YzIEK6qadNuxoeBrnuO15ovICDB5u3lWObAPWbxNKCATVgCHiUl
	IhpwPBXI7PnZPqyuUPvUqfp5fiwnnGa55FMurei7gCxo4jD22L8kMXI82g==
X-Google-Smtp-Source: AGHT+IGkyL3uTbbZsjUNRHCNgSHdQhHmGqk55YHYkYbC/ReMJSX7POrdXdrqVJZ7C2yGRljSPcvJMg==
X-Received: by 2002:a5d:64e2:0:b0:360:8490:74d with SMTP id ffacd0b85a97d-36775730a14mr5587041f8f.5.1719907058197;
        Tue, 02 Jul 2024 00:57:38 -0700 (PDT)
Received: from [10.50.4.180] (bzq-84-110-32-226.static-ip.bezeqint.net. [84.110.32.226])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3675a0e1345sm12328650f8f.54.2024.07.02.00.57.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Jul 2024 00:57:37 -0700 (PDT)
Message-ID: <60f735e9-b1c9-499e-9282-5172643f19ae@grimberg.me>
Date: Tue, 2 Jul 2024 10:57:36 +0300
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/7] nfs: fold nfs_folio_find_and_lock_request into
 nfs_lock_and_join_requests
To: Christoph Hellwig <hch@lst.de>, Trond Myklebust <trondmy@kernel.org>,
 Anna Schumaker <anna@kernel.org>
Cc: linux-nfs@vger.kernel.org
References: <20240701052707.1246254-1-hch@lst.de>
 <20240701052707.1246254-5-hch@lst.de>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20240701052707.1246254-5-hch@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 01/07/2024 8:26, Christoph Hellwig wrote:
> Fold nfs_folio_find_and_lock_request into the only caller to prepare
> for changes to this code.
>
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>   fs/nfs/write.c | 68 ++++++++++++++++++++------------------------------
>   1 file changed, 27 insertions(+), 41 deletions(-)
>
> diff --git a/fs/nfs/write.c b/fs/nfs/write.c
> index 58e5b78ff436b9..2b139493168d87 100644
> --- a/fs/nfs/write.c
> +++ b/fs/nfs/write.c
> @@ -194,38 +194,6 @@ static struct nfs_page *nfs_folio_find_head_request(struct folio *folio)
>   	return req;
>   }
>   
> -static struct nfs_page *nfs_folio_find_and_lock_request(struct folio *folio)
> -{
> -	struct inode *inode = folio->mapping->host;
> -	struct nfs_page *head;
> -	int ret;
> -
> -retry:
> -	head = nfs_folio_find_head_request(folio);
> -	if (!head)
> -		return NULL;
> -
> -	while (!nfs_lock_request(head)) {
> -		ret = nfs_wait_on_request(head);
> -		if (ret < 0)
> -			return ERR_PTR(ret);
> -	}
> -
> -	/* Ensure that nobody removed the request before we locked it */
> -	if (head != folio->private) {
> -		nfs_unlock_and_release_request(head);
> -		goto retry;
> -	}
> -
> -	ret = nfs_cancel_remove_inode(head, inode);
> -	if (ret < 0) {
> -		nfs_unlock_and_release_request(head);
> -		return ERR_PTR(ret);
> -	}
> -
> -	return head;
> -}
> -
>   /* Adjust the file length if we're writing beyond the end */
>   static void nfs_grow_file(struct folio *folio, unsigned int offset,
>   			  unsigned int count)
> @@ -530,26 +498,44 @@ static struct nfs_page *nfs_lock_and_join_requests(struct folio *folio)
>   	struct nfs_commit_info cinfo;
>   	int ret;
>   
> -	nfs_init_cinfo_from_inode(&cinfo, inode);
>   	/*
>   	 * A reference is taken only on the head request which acts as a
>   	 * reference to the whole page group - the group will not be destroyed
>   	 * until the head reference is released.
>   	 */
> -	head = nfs_folio_find_and_lock_request(folio);
> -	if (IS_ERR_OR_NULL(head))
> -		return head;
> +retry:
> +	head = nfs_folio_find_head_request(folio);
> +	if (!head)
> +		return NULL;
>   
> -	/* lock each request in the page group */
> -	ret = nfs_page_group_lock_subrequests(head);
> -	if (ret < 0) {
> +	while (!nfs_lock_request(head)) {
> +		ret = nfs_wait_on_request(head);
> +		if (ret < 0)
> +			return ERR_PTR(ret);
> +	}
> +
> +	/* Ensure that nobody removed the request before we locked it */
> +	if (head != folio->private) {
>   		nfs_unlock_and_release_request(head);
> -		return ERR_PTR(ret);
> +		goto retry;
>   	}
>   
> -	nfs_join_page_group(head, &cinfo, inode);
> +	ret = nfs_cancel_remove_inode(head, inode);
> +	if (ret < 0)
> +		goto out_unlock;
>   
> +	/* lock each request in the page group */
> +	ret = nfs_page_group_lock_subrequests(head);
> +	if (ret < 0)
> +		goto out_unlock;
> +
> +	nfs_init_cinfo_from_inode(&cinfo, inode);

Any reason why nfs_init_cinfo_from_inode() changed location?

Otherwise,
Reviewed-by: Sagi Grimberg <sagi@grimberg.me>


Return-Path: <linux-nfs+bounces-7815-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B96D9C297A
	for <lists+linux-nfs@lfdr.de>; Sat,  9 Nov 2024 03:24:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B4AAE1C213E4
	for <lists+linux-nfs@lfdr.de>; Sat,  9 Nov 2024 02:24:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B786E2E628;
	Sat,  9 Nov 2024 02:24:29 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A2AD26281
	for <linux-nfs@vger.kernel.org>; Sat,  9 Nov 2024 02:24:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.255
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731119069; cv=none; b=mGcVutCAjo+c3FsDNdMIz7iagZb/XuNXdFF1TPoI/9lkKcIeDoRGhfkgEnSrFK/3sZIlbWjkWMMiBwuyv9SVZHtHF4V+wQgky3lOn1saUqKcXY/RbE7i6FrSwB14P3pdnjWWVfBTGiwa6XA9r8RzItxIW1EM/rAY8t+0blJ783A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731119069; c=relaxed/simple;
	bh=sGe4ZoP2Wt08txJuPr3JAiq6fBB0+eEXzc+w4IIwZeI=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=NHX5OoFFKj1keGyyCtAEoRphc6s8fdvApLR+ILdWABCQvBLw4ayMZM7OPHBQMR86gcZgRITBdiSPS6r9/4HZzXrs+bhevJRK/oXCZqQG7ggMS/GdSbjtVjQvY0prSJ0GesV5k66Hu1djJ7NYun4CDRe4zLM5y7UtArr9lztKEf8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.255
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.48])
	by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4XlfhL4Dc6z1T9xH;
	Sat,  9 Nov 2024 10:21:54 +0800 (CST)
Received: from kwepemf100006.china.huawei.com (unknown [7.202.181.220])
	by mail.maildlp.com (Postfix) with ESMTPS id 08D72180064;
	Sat,  9 Nov 2024 10:24:18 +0800 (CST)
Received: from [10.174.177.210] (10.174.177.210) by
 kwepemf100006.china.huawei.com (7.202.181.220) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Sat, 9 Nov 2024 10:24:17 +0800
Message-ID: <5e01cd93-d3fa-d27f-842d-b1861cbed2d3@huawei.com>
Date: Sat, 9 Nov 2024 10:24:16 +0800
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH 1/2] NFSv4.0: Fix the wake up of the next waiter in
 nfs_release_seqid()
To: <trondmy@kernel.org>
CC: <linux-nfs@vger.kernel.org>
References: <5527548df9be8ce76ed31ad0ea6520908533b4fe.1731103952.git.trond.myklebust@hammerspace.com>
From: yangerkun <yangerkun@huawei.com>
In-Reply-To: <5527548df9be8ce76ed31ad0ea6520908533b4fe.1731103952.git.trond.myklebust@hammerspace.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemf100006.china.huawei.com (7.202.181.220)

LGTM

Reviewed-by: Yang Erkun <yangerkun@huawei.com>

在 2024/11/9 6:13, trondmy@kernel.org 写道:
> From: Trond Myklebust <trond.myklebust@hammerspace.com>
> 
> There is no need to wake up another waiter on the seqid list unless the
> seqid being removed is at the head of the list, and so is relinquishing
> control of the sequence counter to the next entry.
> 
> Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
> ---
>   fs/nfs/nfs4state.c | 10 ++++------
>   1 file changed, 4 insertions(+), 6 deletions(-)
> 
> diff --git a/fs/nfs/nfs4state.c b/fs/nfs/nfs4state.c
> index dafd61186557..9a9f60a2291b 100644
> --- a/fs/nfs/nfs4state.c
> +++ b/fs/nfs/nfs4state.c
> @@ -1083,14 +1083,12 @@ void nfs_release_seqid(struct nfs_seqid *seqid)
>   		return;
>   	sequence = seqid->sequence;
>   	spin_lock(&sequence->lock);
> -	list_del_init(&seqid->list);
> -	if (!list_empty(&sequence->list)) {
> -		struct nfs_seqid *next;
> -
> -		next = list_first_entry(&sequence->list,
> -				struct nfs_seqid, list);
> +	if (list_is_first(&seqid->list, &sequence->list) &&
> +	    !list_is_singular(&sequence->list)) {
> +		struct nfs_seqid *next = list_next_entry(seqid, list);
>   		rpc_wake_up_queued_task(&sequence->wait, next->task);
>   	}
> +	list_del_init(&seqid->list);
>   	spin_unlock(&sequence->lock);
>   }
>   


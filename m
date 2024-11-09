Return-Path: <linux-nfs+bounces-7816-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 313B89C297C
	for <lists+linux-nfs@lfdr.de>; Sat,  9 Nov 2024 03:25:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 62C941C213DC
	for <lists+linux-nfs@lfdr.de>; Sat,  9 Nov 2024 02:25:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DE4F2E628;
	Sat,  9 Nov 2024 02:25:15 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24BB726281
	for <linux-nfs@vger.kernel.org>; Sat,  9 Nov 2024 02:25:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731119114; cv=none; b=aJB8cnxL7L2w4XcZT2Zrpbw3XpH2PJxOviomSfYyXNg2w3LXUmJe2o5b2KduuhUIqHN99rlBi8o18pn0gfAbOmQr8+izPN5mlA+HePVJe9ogXfZodW4KDOudzvZ2nsiW7t3WNdhHyFugqILVK6UtNJ+EdN6ffjM14FvTbtfoZLI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731119114; c=relaxed/simple;
	bh=WlNPV6gNw6FPylFWgzC8ZcilAbloln9sj5PVTG0BBY0=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=JJ8SM/8bQ619CI9fzGOrPTapObjDz6gmHbwWHOCGngAobqVsyPzU7kGCJOWLIhZWaT41bR7AliPm5tg46qCqFZ7jU88ATSXzQeZGWMtlAFH51T9ZhUFTwu6iuC8pTpC0xIaFkDxMbuBmL7oNYcg285UaEolhWEy+80htqa37cg8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.252])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4XlfjF5Chxz10Mdn;
	Sat,  9 Nov 2024 10:22:41 +0800 (CST)
Received: from kwepemf100006.china.huawei.com (unknown [7.202.181.220])
	by mail.maildlp.com (Postfix) with ESMTPS id 704001800A7;
	Sat,  9 Nov 2024 10:25:05 +0800 (CST)
Received: from [10.174.177.210] (10.174.177.210) by
 kwepemf100006.china.huawei.com (7.202.181.220) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Sat, 9 Nov 2024 10:25:04 +0800
Message-ID: <69134750-3d64-1d3b-ff35-599437552889@huawei.com>
Date: Sat, 9 Nov 2024 10:25:04 +0800
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH 2/2] NFSv4.0: Fix a use-after-free problem in the
 asynchronous open()
To: <trondmy@kernel.org>
CC: <linux-nfs@vger.kernel.org>
References: <5527548df9be8ce76ed31ad0ea6520908533b4fe.1731103952.git.trond.myklebust@hammerspace.com>
 <e82e8f89d5449c947c7e81e2bfe9c7c4a980c0d8.1731103952.git.trond.myklebust@hammerspace.com>
From: yangerkun <yangerkun@huawei.com>
In-Reply-To: <e82e8f89d5449c947c7e81e2bfe9c7c4a980c0d8.1731103952.git.trond.myklebust@hammerspace.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemf100006.china.huawei.com (7.202.181.220)

LGTM

Reviewed-by: Yang Erkun <yangerkun@huawei.com>

在 2024/11/9 6:13, trondmy@kernel.org 写道:
> From: Trond Myklebust <trond.myklebust@hammerspace.com>
> 
> Yang Erkun reports that when two threads are opening files at the same
> time, and are forced to abort before a reply is seen, then the call to
> nfs_release_seqid() in nfs4_opendata_free() can result in a
> use-after-free of the pointer to the defunct rpc task of the other
> thread.
> The fix is to ensure that if the RPC call is aborted before the call to
> nfs_wait_on_sequence() is complete, then we must call nfs_release_seqid()
> in nfs4_open_release() before the rpc_task is freed.
> 
> Reported-by: Yang Erkun <yangerkun@huawei.com>
> Fixes: 24ac23ab88df ("NFSv4: Convert open() into an asynchronous RPC call")
> Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
> ---
>   fs/nfs/nfs4proc.c | 8 +++++---
>   1 file changed, 5 insertions(+), 3 deletions(-)
> 
> diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
> index 9d40319e063d..405f17e6e0b4 100644
> --- a/fs/nfs/nfs4proc.c
> +++ b/fs/nfs/nfs4proc.c
> @@ -2603,12 +2603,14 @@ static void nfs4_open_release(void *calldata)
>   	struct nfs4_opendata *data = calldata;
>   	struct nfs4_state *state = NULL;
>   
> +	/* In case of error, no cleanup! */
> +	if (data->rpc_status != 0 || !data->rpc_done) {
> +		nfs_release_seqid(data->o_arg.seqid);
> +		goto out_free;
> +	}
>   	/* If this request hasn't been cancelled, do nothing */
>   	if (!data->cancelled)
>   		goto out_free;
> -	/* In case of error, no cleanup! */
> -	if (data->rpc_status != 0 || !data->rpc_done)
> -		goto out_free;
>   	/* In case we need an open_confirm, no cleanup! */
>   	if (data->o_res.rflags & NFS4_OPEN_RESULT_CONFIRM)
>   		goto out_free;


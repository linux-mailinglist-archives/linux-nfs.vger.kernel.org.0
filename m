Return-Path: <linux-nfs+bounces-8769-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CFC849FC366
	for <lists+linux-nfs@lfdr.de>; Wed, 25 Dec 2024 03:50:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6425B164E53
	for <lists+linux-nfs@lfdr.de>; Wed, 25 Dec 2024 02:50:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76E65D2FB;
	Wed, 25 Dec 2024 02:50:10 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D2ED125D5
	for <linux-nfs@vger.kernel.org>; Wed, 25 Dec 2024 02:50:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735095010; cv=none; b=lQmCcuvaF3yefUZjlOsUDeo9FPTUrtvEQoUo3DChbNIEMO9hPuwvMsfvht0TeiAGKiNz+1bONR03xou1P3wGXRRYElVdHl7fcFtEf0PZ39QvCZzEf2IiDqU/aGpPsUvJXd3WWZWAYal9mfHsuLcOYfSJyAFh7j3YojIVbvx+Gpk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735095010; c=relaxed/simple;
	bh=lg9Lv2qHL1LFR2blzbDd/jeFZlMMYUKGLMVPcIvRoDQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=rC1pL3Q3ib0tc7cMiDprf2Xrd6cij/+qBRzps49VbS6xQf655TbwN+vmvBHA88K7gZPbl06x0K5s7ScveRTnsRzTcN/X4JiG8YLRbntpTdlEgdq/v3opABaWmYy+NpolcIAmfdQ3aMOcdWUJzqIPUME3cKq8FJ/lGpER5q6s/1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.17])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4YHx4S3j8bz2DjVB;
	Wed, 25 Dec 2024 10:47:20 +0800 (CST)
Received: from kwepemg500017.china.huawei.com (unknown [7.202.181.81])
	by mail.maildlp.com (Postfix) with ESMTPS id ABB8B1A0188;
	Wed, 25 Dec 2024 10:50:03 +0800 (CST)
Received: from [10.174.179.155] (10.174.179.155) by
 kwepemg500017.china.huawei.com (7.202.181.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 25 Dec 2024 10:50:03 +0800
Message-ID: <0cf3c4a6-082a-4ee7-91bf-13cb98138879@huawei.com>
Date: Wed, 25 Dec 2024 10:50:02 +0800
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: =?UTF-8?B?TW96aWxsYSBUaHVuZGVyYmlyZCDmtYvor5XniYg=?=
Subject: Re: [PATCH 1/2] NFSv4.0: Fix the wake up of the next waiter in
 nfs_release_seqid()
To: <trondmy@kernel.org>, Yang Erkun <yangerkun@huawei.com>
CC: <linux-nfs@vger.kernel.org>
References: <5527548df9be8ce76ed31ad0ea6520908533b4fe.1731103952.git.trond.myklebust@hammerspace.com>
From: Li Lingfeng <lilingfeng3@huawei.com>
In-Reply-To: <5527548df9be8ce76ed31ad0ea6520908533b4fe.1731103952.git.trond.myklebust@hammerspace.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemg500017.china.huawei.com (7.202.181.81)

Hi, I noticed that [PATCH 2] has been applied to the stable, but [PATCH 1]
has not.
Based on 6.6 where [PATCH 2] was merged, I can still reproduce the
original issue, and [PATCH 1] needs to be applied as well to resolve it.
It may be better to push [PATCH 1] to the stable as well.
Thanks.

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


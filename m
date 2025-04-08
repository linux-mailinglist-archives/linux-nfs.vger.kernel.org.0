Return-Path: <linux-nfs+bounces-11036-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C464A7F300
	for <lists+linux-nfs@lfdr.de>; Tue,  8 Apr 2025 05:05:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7F990178146
	for <lists+linux-nfs@lfdr.de>; Tue,  8 Apr 2025 03:05:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B1811A8407;
	Tue,  8 Apr 2025 03:05:51 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57F144A1E;
	Tue,  8 Apr 2025 03:05:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744081551; cv=none; b=csTmQHqQTYsfX91PB9Wd6VMajzRJZgbWa/ovTGZswHUiDymIpQ4goARRjEAqozJ4mpBhLjZx0LPUJR2W1W1t4UdLIhRkCayd78XgReYuDBnTV5ZCIU8bdFUD0rCZTuMI+7JMBzYDLYWZ+tlkGNFh356cHqbWtV+Cvymuki6WClQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744081551; c=relaxed/simple;
	bh=+OfUjsJBQabSjooMQL6PzbbhgU44fkkXgVOC11aFAvQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=qs0+68MdnWm9lO0rkSO63AEr+V4wiZIAnmJOMf0GhSsL2QdQ6esQC+ApJyWSPYstc2yZou2V8h7av21mGD23KKvJxR/o+cNPB2l46n9S9+693gkZR4yPLGk9fNyiNb33WoVhPRnqfeJUNxBWoi3tj0B6OsaSUftmg5q3Do24jCQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.48])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4ZWrSf20XXzCsXq;
	Tue,  8 Apr 2025 11:01:22 +0800 (CST)
Received: from kwepemg500010.china.huawei.com (unknown [7.202.181.71])
	by mail.maildlp.com (Postfix) with ESMTPS id CC4C31800B1;
	Tue,  8 Apr 2025 11:05:06 +0800 (CST)
Received: from [10.174.178.209] (10.174.178.209) by
 kwepemg500010.china.huawei.com (7.202.181.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 8 Apr 2025 11:05:05 +0800
Message-ID: <7a462cee-bf09-4ff3-a047-198b4790fa31@huawei.com>
Date: Tue, 8 Apr 2025 11:05:05 +0800
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] NFS: Fix shift-out-of-bounds UBSAN warning with negative
 retrans
To: <trondmy@kernel.org>, <anna@kernel.org>, <dhowells@redhat.com>,
	<viro@zeniv.linux.org.uk>
CC: <linux-nfs@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<yi.zhang@huawei.com>, <yangerkun@huawei.com>
References: <20250407134850.2484368-1-wangzhaolong1@huawei.com>
From: Wang Zhaolong <wangzhaolong1@huawei.com>
In-Reply-To: <20250407134850.2484368-1-wangzhaolong1@huawei.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 kwepemg500010.china.huawei.com (7.202.181.71)

Hello,

I noticed an issue with the Fixes tag in my original patch. The current tag
refers to commit 9954bf92c0cd ("NFS: Move mount parameterisation bits into their
own file"), which is not directly related to the issue being fixed.

While investigating further, I discovered this problem actually traces back to
much earlier kernel versions (as far back as 2.6.x). The shift-out-of-bounds
issue has been present for a very long time.

Commit c09f11ef3595 ("NFS: fs_context: validate UDP retrans to prevent shift
out-of-bounds") attempted to fix part of this issue by checking for values that
are too large, but it didn't account for negative values. My patch completes
this fix by also checking for negative values.

Given this history, I believe the proper Fixes tag should point to c09f11ef3595
as my patch is completing an incomplete fix, while also mentioning the long-term
existence of this issue in the commit message.

I will send a v2 patch with this clarification.

Thanks,
Wang Zhaolong

> The previous commit c09f11ef3595 ("NFS: fs_context: validate UDP retrans
> to prevent shift out-of-bounds") added a check to prevent shift values
> that are too large, but it fails to account for negative retrans values.
> When data->retrans is negative, the condition `data->retrans >= 64` is
> skipped, allowing negative values to be copied to context->retrans,
> which is unsigned. This results in a large positive number that can
> trigger the original UBSAN issue[1].
> 
> This patch modifies the check to explicitly handle both negative values
> and values that are too large.
> 
> [1] https://bugzilla.kernel.org/show_bug.cgi?id=219988
> Fixes: 9954bf92c0cd ("NFS: Move mount parameterisation bits into their own file")
> Signed-off-by: Wang Zhaolong <wangzhaolong1@huawei.com>
> ---
>   fs/nfs/fs_context.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/nfs/fs_context.c b/fs/nfs/fs_context.c
> index 13f71ca8c974..0703ac0349cb 100644
> --- a/fs/nfs/fs_context.c
> +++ b/fs/nfs/fs_context.c
> @@ -1161,11 +1161,12 @@ static int nfs23_parse_monolithic(struct fs_context *fc,
>   		 * for proto == XPRT_TRANSPORT_UDP, which is what uses
>   		 * to_exponential, implying shift: limit the shift value
>   		 * to BITS_PER_LONG (majortimeo is unsigned long)
>   		 */
>   		if (!(data->flags & NFS_MOUNT_TCP)) /* this will be UDP */
> -			if (data->retrans >= 64) /* shift value is too large */
> +			/* Reject invalid retrans values (negative or too large) */
> +			if (data->retrans < 0 || data->retrans >= 64)
>   				goto out_invalid_data;
>   
>   		/*
>   		 * Translate to nfs_fs_context, which nfs_fill_super
>   		 * can deal with.



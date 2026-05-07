Return-Path: <linux-nfs+bounces-21435-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gPlIFZ93/Gm3QQAAu9opvQ
	(envelope-from <linux-nfs+bounces-21435-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Thu, 07 May 2026 13:29:35 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C3EA34E77B5
	for <lists+linux-nfs@lfdr.de>; Thu, 07 May 2026 13:29:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id EDAF23043D75
	for <lists+linux-nfs@lfdr.de>; Thu,  7 May 2026 11:29:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 627903CF69F;
	Thu,  7 May 2026 11:29:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="caq5uwqz"
X-Original-To: linux-nfs@vger.kernel.org
Received: from canpmsgout12.his.huawei.com (canpmsgout12.his.huawei.com [113.46.200.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26BCB3CFF58;
	Thu,  7 May 2026 11:29:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778153347; cv=none; b=BYDInu5bDxMqBYRdaODQMoG9osV0zbkuqEe2v2r2Qk4EX7ORh3amIBccMqeJ5XfZw/Lhs9KHqzFIHyhgX/1p2PzwexMpfdsmLXThoX5Ic2iVu6KIrfAAoBK9h4u8zm0Wv8GbNCV5u5HAy8rEYp2NeKwz4NwgGNwqAkAU3IrbpIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778153347; c=relaxed/simple;
	bh=Q517F6Uy3MLTmNCd0zXvFOW1dkgaW5XtTdMQDoqfd1o=;
	h=Subject:To:CC:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=oxZ7MDQA2cpyD39ognTCo+WXvxSwh6Jmggj+xhUQravN6ktUj8dzpDOMHWdOehsvMf/V72nq4PscW8bmbCFDQiKzCldGRYE+exK8d7HSVa3KOZ4F4GLvXqpCPxDGL+flVrMWcdGneEpd2L5E5QNd4AJ3fVFtYb32mKOEIUcJb70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=caq5uwqz; arc=none smtp.client-ip=113.46.200.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=IPaxjuxkQFaT7VyixKL22XhRyUNa15W2RvMeOdRAjbI=;
	b=caq5uwqzWjdXpTJpPYaA96n5WVL/UjFTh5cYCI8uXed4+HBaSqQwwY3Zs12pqMNrQBpSU1tZi
	xTIGuWlm9+JbqaE7lLPCvF7yuIg2pXNARZfCNYvCoNPFMHfrnQaeJduoTV59rv6Jw7HR3eZYatZ
	s6ApXQr095yPv1DjTWKkJUU=
Received: from mail.maildlp.com (unknown [172.19.163.127])
	by canpmsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4gB8wM2LcjznTZq;
	Thu,  7 May 2026 19:21:55 +0800 (CST)
Received: from kwepemk500005.china.huawei.com (unknown [7.202.194.90])
	by mail.maildlp.com (Postfix) with ESMTPS id 80CB3402AB;
	Thu,  7 May 2026 19:29:01 +0800 (CST)
Received: from [10.174.178.46] (10.174.178.46) by
 kwepemk500005.china.huawei.com (7.202.194.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 7 May 2026 19:29:00 +0800
Subject: Re: [PATCH] nsfs: fix wrong error code returned for pidns ioctls
To: <trondmy@kernel.org>, <anna@kernel.org>, <viro@zeniv.linux.org.uk>,
	<brauner@kernel.org>, <jlayton@kernel.org>, <josef@toxicpanda.com>
CC: <linux-nfs@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-fsdevel@vger.kernel.org>, <yangerkun@huawei.com>,
	<yi.zhang@huawei.com>, <changdiankang@huawei.com>
References: <20260507111404.638608-1-chengzhihao1@huawei.com>
From: Zhihao Cheng <chengzhihao1@huawei.com>
Message-ID: <bc06e923-1189-4251-42dd-5215b9f9b7d3@huawei.com>
Date: Thu, 7 May 2026 19:29:00 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20260507111404.638608-1-chengzhihao1@huawei.com>
Content-Type: text/plain; charset="gbk"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: kwepems100002.china.huawei.com (7.221.188.206) To
 kwepemk500005.china.huawei.com (7.202.194.90)
X-Rspamd-Queue-Id: C3EA34E77B5
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[huawei.com,quarantine];
	R_DKIM_ALLOW(-0.20)[huawei.com:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[huawei.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-21435-lists,linux-nfs=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FROM_HAS_DN(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[chengzhihao1@huawei.com,linux-nfs@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[12];
	RCVD_COUNT_FIVE(0.00)[6];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[huawei.com:email,huawei.com:mid,huawei.com:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Action: no action

ÔÚ 2026/5/7 19:14, Zhihao Cheng Ð´µÀ:
> When executing NS_GET_PID_FROM_PIDNS (or similar pidns ioctls), if the
> target task cannot be found in the corresponding pid_ns, the error code
> should be ESRCH instead of ENOTTY.
> 
> This bug was introduced when the extensible ioctl handling was added.
> Without proper return, ret would be overwritten by the default case in
> the extensible ioctl switch statement.
> 
> Fixes: a1d220d9dafa8 ("nsfs: iterate through mount namespaces")
> Signed-off-by: Zhihao Cheng <chengzhihao1@huawei.com>
> ---
>   fs/nfs/nfs4state.c | 1 +
>   fs/nsfs.c          | 2 +-
>   2 files changed, 2 insertions(+), 1 deletion(-)
Ignore this patch, see v2. 
https://lore.kernel.org/linux-fsdevel/20260507112301.1042757-1-chengzhihao1@huawei.com/T/#u> 

> diff --git a/fs/nfs/nfs4state.c b/fs/nfs/nfs4state.c
> index 305a772e5497..5044bb4c870f 100644
> --- a/fs/nfs/nfs4state.c
> +++ b/fs/nfs/nfs4state.c
> @@ -2039,6 +2039,7 @@ static int nfs4_purge_lease(struct nfs_client *clp)
>    *
>    * Returns zero or a negative NFS4ERR status code.
>    */
> +
>   static int nfs4_try_migration(struct nfs_server *server, const struct cred *cred)
>   {
>   	struct nfs_client *clp = server->nfs_client;
> diff --git a/fs/nsfs.c b/fs/nsfs.c
> index 51e8c9430477..160018c4fb36 100644
> --- a/fs/nsfs.c
> +++ b/fs/nsfs.c
> @@ -266,7 +266,7 @@ static long ns_ioctl(struct file *filp, unsigned int ioctl,
>   		else
>   			tsk = find_task_by_pid_ns(arg, pid_ns);
>   		if (!tsk)
> -			break;
> +			return ret;
>   
>   		switch (ioctl) {
>   		case NS_GET_PID_FROM_PIDNS:
> 



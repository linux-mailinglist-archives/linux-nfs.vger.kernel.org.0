Return-Path: <linux-nfs+bounces-17095-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B5A3ACBCE54
	for <lists+linux-nfs@lfdr.de>; Mon, 15 Dec 2025 09:01:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 294E43004A4E
	for <lists+linux-nfs@lfdr.de>; Mon, 15 Dec 2025 08:01:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E013F32AAB1;
	Mon, 15 Dec 2025 08:01:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="Y5z1es5v"
X-Original-To: linux-nfs@vger.kernel.org
Received: from canpmsgout01.his.huawei.com (canpmsgout01.his.huawei.com [113.46.200.216])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC3E4329E75
	for <linux-nfs@vger.kernel.org>; Mon, 15 Dec 2025 08:00:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.216
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765785661; cv=none; b=esCH103q3xKR8SDB0dgYUexyiqL/APa6xZ9mF35ic8WuLY0V7O3wuCpTJLUuqnWjyrcX9uh8WJkh5woSWAKmAm+5k/s6KzYFyhxgeZ7GTYuv3+G1rN8zygHtytdnXG7zrhd1umwMv0Wujuv6ebScWNcZUnbDZZf4NKWjBfhTEBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765785661; c=relaxed/simple;
	bh=rySWtdaQny03fdDNmLYV1w3DcXRkwlJiQomORfGk3hE=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=kdr9gfptPXOYTM6gkNH5DX6foQ/8XtmwrhklVMVxw/e/XdCAFxsDlPO73CCC4sq28VR/12S+lP5II9Qx1Z9xzrgB/knEZAAXWkZeqzwU3htdDz2JGipDkZSwWlmpFLLHttS9KkQ/aof/14ssFSFEAZPxGja5GoLuNycFGZTCl6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=Y5z1es5v; arc=none smtp.client-ip=113.46.200.216
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=/nFDwFRuPTKS1EcOSE603SrdWQ7kk0hlq9QhABkgRvk=;
	b=Y5z1es5v6+50I8PbX+XPb63xFj6vWUHFw1HIuizqCU9jcXmxyMw1qF0s6SR+v3PEFWBYod4g6
	yPZ9RkYU+M5lpNKn8HIS6lraOA3r3iFVGlBFphuLzWZ4Zn+g7HgNcKWHLF/avMuf7h6tLfB5D3a
	wVXiFnfv4K+zuHR0M6WHdPk=
Received: from mail.maildlp.com (unknown [172.19.163.48])
	by canpmsgout01.his.huawei.com (SkyGuard) with ESMTPS id 4dVC9v59Rjz1T4JP;
	Mon, 15 Dec 2025 15:58:43 +0800 (CST)
Received: from kwepemj200013.china.huawei.com (unknown [7.202.194.25])
	by mail.maildlp.com (Postfix) with ESMTPS id EF540180478;
	Mon, 15 Dec 2025 16:00:52 +0800 (CST)
Received: from [10.174.179.155] (10.174.179.155) by
 kwepemj200013.china.huawei.com (7.202.194.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 15 Dec 2025 16:00:52 +0800
Message-ID: <fb5babed-cdaa-41a9-8024-0601e59ab4c2@huawei.com>
Date: Mon, 15 Dec 2025 16:00:51 +0800
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: =?UTF-8?B?TW96aWxsYSBUaHVuZGVyYmlyZCDmtYvor5XniYg=?=
Subject: Re: [PATCH v3 2/2] nfsd: use workqueue enable/disable APIs for
 v4_end_grace sync
To: Chuck Lever <cel@kernel.org>, NeilBrown <neil@brown.name>, Jeff Layton
	<jlayton@kernel.org>, Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo
	<dai.ngo@oracle.com>, Tom Talpey <tom@talpey.com>
CC: <linux-nfs@vger.kernel.org>, <yangerkun@huawei.com>,
	<yi.zhang@huawei.com>, <houtao1@huawei.com>, <chengzhihao1@huawei.com>
References: <20251213184200.585652-1-cel@kernel.org>
 <20251213184200.585652-3-cel@kernel.org>
From: Li Lingfeng <lilingfeng3@huawei.com>
In-Reply-To: <20251213184200.585652-3-cel@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: kwepems500001.china.huawei.com (7.221.188.70) To
 kwepemj200013.china.huawei.com (7.202.194.25)

Hi,

在 2025/12/14 2:42, Chuck Lever 写道:
> From: NeilBrown <neil@brown.name>
>
> "nfsd: provide locking for v4_end_grace" introduced a
> client_tracking_active flag protected by nn->client_lock to prevent
> the laundromat from being scheduled before client tracking
> initialization or after shutdown begins. That commit is suitable for
> backporting to LTS kernels that predate commit 86898fa6b8cd
> ("workqueue: Implement disable/enable for (delayed) work items").
>
> However, the workqueue subsystem in recent kernels provides
> enable_delayed_work() and disable_delayed_work_sync() for this
> purpose. Using this mechanism enable us to remove the
> client_tracking_active flag and associated spinlock operations
> while preserving the same synchronization guarantees, which is
> a cleaner long-term approach.
>
> Signed-off-by: NeilBrown <neil@brown.name>
> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
> ---
>   fs/nfsd/netns.h     |  1 -
>   fs/nfsd/nfs4state.c | 22 +++++++++-------------
>   2 files changed, 9 insertions(+), 14 deletions(-)
>
> diff --git a/fs/nfsd/netns.h b/fs/nfsd/netns.h
> index fe8338735e7c..d83c68872c4c 100644
> --- a/fs/nfsd/netns.h
> +++ b/fs/nfsd/netns.h
> @@ -67,7 +67,6 @@ struct nfsd_net {
>   	struct lock_manager nfsd4_manager;
>   	bool grace_ended;
>   	bool grace_end_forced;
> -	bool client_tracking_active;
>   	time64_t boot_time;
>   
>   	struct dentry *nfsd_client_dir;
> diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
> index 1d307cc533d9..c9be724c48d0 100644
> --- a/fs/nfsd/nfs4state.c
> +++ b/fs/nfsd/nfs4state.c
> @@ -6619,14 +6619,14 @@ bool nfsd4_force_end_grace(struct nfsd_net *nn)
>   {
>   	if (!nn->client_tracking_ops)
>   		return false;
> -	spin_lock(&nn->client_lock);
> -	if (nn->grace_ended || !nn->client_tracking_active) {
> -		spin_unlock(&nn->client_lock);
> +	if (READ_ONCE(nn->grace_ended))
>   		return false;
> -	}
> +	/* laundromat_work must be initialised now, though it might be disabled */
>   	WRITE_ONCE(nn->grace_end_forced, true);
> +	/* mod_delayed_work() doesn't queue work after
> +	 * nfs4_state_shutdown_net() has called disable_delayed_work_sync()
> +	 */
>   	mod_delayed_work(laundry_wq, &nn->laundromat_work, 0);
> -	spin_unlock(&nn->client_lock);
>   	return true;
>   }
>   
> @@ -8962,7 +8962,6 @@ static int nfs4_state_create_net(struct net *net)
>   	nn->boot_time = ktime_get_real_seconds();
>   	nn->grace_ended = false;
>   	nn->grace_end_forced = false;
> -	nn->client_tracking_active = false;
>   	nn->nfsd4_manager.block_opens = true;
>   	INIT_LIST_HEAD(&nn->nfsd4_manager.list);
>   	INIT_LIST_HEAD(&nn->client_lru);
> @@ -8977,6 +8976,8 @@ static int nfs4_state_create_net(struct net *net)
>   	INIT_LIST_HEAD(&nn->blocked_locks_lru);
>   
>   	INIT_DELAYED_WORK(&nn->laundromat_work, laundromat_main);
> +	/* Make sure this cannot run until client tracking is initialised */
> +	disable_delayed_work(&nn->laundromat_work);
>   	INIT_WORK(&nn->nfsd_shrinker_work, nfsd4_state_shrinker_worker);
>   	get_net(net);
>   
> @@ -9044,9 +9045,7 @@ nfs4_state_start_net(struct net *net)
>   	locks_start_grace(net, &nn->nfsd4_manager);
>   	nfsd4_client_tracking_init(net);
>   	/* safe for laundromat to run now */
> -	spin_lock(&nn->client_lock);
> -	nn->client_tracking_active = true;
> -	spin_unlock(&nn->client_lock);
> +	enable_delayed_work(&nn->laundromat_work);
>   	if (nn->track_reclaim_completes && nn->reclaim_str_hashtbl_size == 0)
>   		goto skip_grace;
>   	printk(KERN_INFO "NFSD: starting %lld-second grace period (net %x)\n",
> @@ -9095,10 +9094,7 @@ nfs4_state_shutdown_net(struct net *net)
>   
>   	shrinker_free(nn->nfsd_client_shrinker);
>   	cancel_work_sync(&nn->nfsd_shrinker_work);
> -	spin_lock(&nn->client_lock);
> -	nn->client_tracking_active = false;
> -	spin_unlock(&nn->client_lock);
> -	cancel_delayed_work_sync(&nn->laundromat_work);
> +	disable_delayed_work_sync(&nn->laundromat_work);
>   	locks_end_grace(&nn->nfsd4_manager);
>   
>   	INIT_LIST_HEAD(&reaplist);
I've also tested the second patch. After applying both patches, I was no
longer able to reproduce the issue, and everything looks fine from my
testing.

Tested-by: Li Lingfeng <lilingfeng3@huawei.com>



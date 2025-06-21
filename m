Return-Path: <linux-nfs+bounces-12605-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D68FFAE2816
	for <lists+linux-nfs@lfdr.de>; Sat, 21 Jun 2025 10:51:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D9BFB17C94E
	for <lists+linux-nfs@lfdr.de>; Sat, 21 Jun 2025 08:51:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EEE61EDA2F;
	Sat, 21 Jun 2025 08:50:55 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 111521A8F60
	for <linux-nfs@vger.kernel.org>; Sat, 21 Jun 2025 08:50:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750495855; cv=none; b=uQb52u7V/mxrMwuLkUZTZ+FPxXXlc5KHhY6d1VVx0Nt3PdDGgElAJCmC2u1/KNl6GjUp4QBKQpo9+QaCqOt55YO4jRwK4R8/mUuOW6ob3USpYRG0ygvq3L0S0A6SFL/v+NCcGJI7q6XecLzA3bDolZf6DWNZhUMer1rtXZCC+jU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750495855; c=relaxed/simple;
	bh=QILFgDQhIFR2LUPHJCsiIGu7ZOyc1iLHISeYxgSX6PQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=tu4Cr2ZqKg9ROeFyKcgqJ5f7fNPR5IQZsXUDSl5iXG9fMAj8ViYL+hHAEMnUkybBv9s2mPKid1M7f78sB/evqdjCyFt8g+h3AtLD8V2ZEAvK3VMyhsOHplyOxarC1feIGuYKRWcWWgZYMrBIWZMoAWp8KBA8/0OQ4hhqx9M+x/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.48])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4bPSg52s4qz13MS0;
	Sat, 21 Jun 2025 16:48:33 +0800 (CST)
Received: from kwepemg500017.china.huawei.com (unknown [7.202.181.81])
	by mail.maildlp.com (Postfix) with ESMTPS id CF6C81800B2;
	Sat, 21 Jun 2025 16:50:48 +0800 (CST)
Received: from [10.174.179.155] (10.174.179.155) by
 kwepemg500017.china.huawei.com (7.202.181.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Sat, 21 Jun 2025 16:50:48 +0800
Message-ID: <fa6fc07f-e56e-42de-9dd6-0ed4d9c32027@huawei.com>
Date: Sat, 21 Jun 2025 16:50:47 +0800
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: =?UTF-8?B?TW96aWxsYSBUaHVuZGVyYmlyZCDmtYvor5XniYg=?=
Subject: Re: [PATCH 1/3] nfsd: provide proper locking for all write_ function
To: NeilBrown <neil@brown.name>, Chuck Lever <chuck.lever@oracle.com>, Jeff
 Layton <jlayton@kernel.org>
CC: <linux-nfs@vger.kernel.org>, Olga Kornievskaia <okorniev@redhat.com>, Dai
 Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>, yangerkun
	<yangerkun@huawei.com>
References: <20250620233802.1453016-1-neil@brown.name>
 <20250620233802.1453016-2-neil@brown.name>
From: Li Lingfeng <lilingfeng3@huawei.com>
In-Reply-To: <20250620233802.1453016-2-neil@brown.name>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: kwepems500001.china.huawei.com (7.221.188.70) To
 kwepemg500017.china.huawei.com (7.202.181.81)

Thank you for the patch, it did fix the issue.

在 2025/6/21 7:33, NeilBrown 写道:
> write_foo functions are called to handle IO to files in /proc/fs/nfsd/.
> They can be called at any time and so generally need locking to ensure
> they don't happen at an awkward time.
>
> Many already take nfsd_mutex and check if nfsd_serv has been set.  This
> ensures they only run when the server is fully configured.
>
> write_filehandle() does *not* need locking.  It interacts with the
> export table which is set up when the netns is set up, so it is always
> valid and it has its own locking.  write_filehandle() is needed before
> the nfs server is started so checking nfsd_serv would be wrong.
>
> The remaining files which do not have any locking are
> write_v4_end_grace(), write_unlock_ip(), and write_unlock_fs().
> None of these make sense when the nfs server is not running and there is
> evidence that write_v4_end_grace() can race with ->client_tracking_op
> setup/shutdown and cause problems.
>
> This patch adds locking to these three and ensures the "unlock"
> functions abort if ->nfsd_serv is not set.  It uses
>      guard(mutex)(&nfsd_mutex);
> so there is no need to ensure we unlock on every patch.
>
> Reported-by: Li Lingfeng <lilingfeng3@huawei.com>
> Signed-off-by: NeilBrown <neil@brown.name>
> ---
>   fs/nfsd/nfsctl.c | 14 ++++++++++++++
>   1 file changed, 14 insertions(+)
>
> diff --git a/fs/nfsd/nfsctl.c b/fs/nfsd/nfsctl.c
> index 3f3e9f6c4250..0e7e89dc730b 100644
> --- a/fs/nfsd/nfsctl.c
> +++ b/fs/nfsd/nfsctl.c
> @@ -221,6 +221,12 @@ static ssize_t write_unlock_ip(struct file *file, char *buf, size_t size)
>   	size_t salen = sizeof(address);
>   	char *fo_path;
>   	struct net *net = netns(file);
> +	struct nfsd_net *nn = net_generic(net, nfsd_net_id);
> +
> +	guard(mutex)(&nfsd_mutex);
> +	if (!nn->nfsd_serv)
> +		/* There cannot be any files to unlock */
> +		return -EINVAL;
>   
>   	/* sanity check */
>   	if (size == 0)
> @@ -259,6 +265,12 @@ static ssize_t write_unlock_fs(struct file *file, char *buf, size_t size)
>   	struct path path;
>   	char *fo_path;
>   	int error;
> +	struct nfsd_net *nn = net_generic(netns(file), nfsd_net_id);
> +
> +	guard(mutex)(&nfsd_mutex);
> +	if (!nn->nfsd_serv)
> +		/* There cannot be any files to unlock */
> +		return -EINVAL;
>   
>   	/* sanity check */
>   	if (size == 0)
> @@ -1053,6 +1065,7 @@ static ssize_t write_recoverydir(struct file *file, char *buf, size_t size)
>   }
>   #endif
>   
> +
>   /*
>    * write_v4_end_grace - release grace period for nfsd's v4.x lock manager
>    *
> @@ -1077,6 +1090,7 @@ static ssize_t write_v4_end_grace(struct file *file, char *buf, size_t size)
>   {
>   	struct nfsd_net *nn = net_generic(netns(file), nfsd_net_id);
>   
> +	guard(mutex)(&nfsd_mutex);
>   	if (size > 0) {
>   		switch(buf[0]) {
>   		case 'Y':
Tested-by: Li Lingfeng <lilingfeng3@huawei.com>


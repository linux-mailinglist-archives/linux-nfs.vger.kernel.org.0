Return-Path: <linux-nfs+bounces-17094-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id B8BC8CBCC45
	for <lists+linux-nfs@lfdr.de>; Mon, 15 Dec 2025 08:29:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id AF1BE300768D
	for <lists+linux-nfs@lfdr.de>; Mon, 15 Dec 2025 07:29:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C775231352C;
	Mon, 15 Dec 2025 07:29:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="hg4FllG2";
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="hg4FllG2"
X-Original-To: linux-nfs@vger.kernel.org
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C21A8634F
	for <linux-nfs@vger.kernel.org>; Mon, 15 Dec 2025 07:29:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765783750; cv=none; b=BrXgJDbVYqVyagyuMyyj25Nb9DmFzkm+mBSmrSfeXTps+pbxtfurb4YfjE/AWM3xiF/lMhb+9mxLnxrntG4hZdXBbghDIfEMzogwVo6ZbGtrMWQyxywvEGgNKyMfkuLIWRt8Qthws/ZL6R1wIK61x9tAppOvV5EU+lqXdHT9DZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765783750; c=relaxed/simple;
	bh=C7HO80YdBoLKJVXCeK3/Xp/0czYhsFLEm7W3PGMoi0c=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=Mwpg8l6qMyi9qpymxNsxJToGjQZ3pxSbHl4/gP9LLFZqMkBbE8Ms1W3tHY9Rh6C4uThR4Q2U4WigYo/vrMrOsOPQgnzUKOqdmA2FWacKwvVRwcPDY1iC2jeBxkq/CDfvqSsswZZSZRCj+tFxaKeO31ZkLeSgnPYDUofqJQys4O8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=hg4FllG2; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=hg4FllG2; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=TaubI+cI/z4TLOPQSd4XPIeMAisMipZHGJaCasfqrEQ=;
	b=hg4FllG2DfzTCA8POlkXc1r75XKpSmJs+HiCRzYocQioXqVKBDbhJ2zmtGKx1tZk4xXgg1QW4
	9U8LOqQYbTnif3KYITAJOo70TN97oPplRSr0v4KOsKtms9ufOCCJ5i743U3aCW8eyqMTvs/wMvE
	gPoriSSqU3rnqPfdiFF8fnE=
Received: from canpmsgout12.his.huawei.com (unknown [172.19.92.144])
	by szxga01-in.huawei.com (SkyGuard) with ESMTPS id 4dVBW902Ztz1BG05
	for <linux-nfs@vger.kernel.org>; Mon, 15 Dec 2025 15:28:37 +0800 (CST)
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=TaubI+cI/z4TLOPQSd4XPIeMAisMipZHGJaCasfqrEQ=;
	b=hg4FllG2DfzTCA8POlkXc1r75XKpSmJs+HiCRzYocQioXqVKBDbhJ2zmtGKx1tZk4xXgg1QW4
	9U8LOqQYbTnif3KYITAJOo70TN97oPplRSr0v4KOsKtms9ufOCCJ5i743U3aCW8eyqMTvs/wMvE
	gPoriSSqU3rnqPfdiFF8fnE=
Received: from mail.maildlp.com (unknown [172.19.163.44])
	by canpmsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4dVBSm2KzbznTV6;
	Mon, 15 Dec 2025 15:26:32 +0800 (CST)
Received: from kwepemj200013.china.huawei.com (unknown [7.202.194.25])
	by mail.maildlp.com (Postfix) with ESMTPS id ED93714027A;
	Mon, 15 Dec 2025 15:28:46 +0800 (CST)
Received: from [10.174.179.155] (10.174.179.155) by
 kwepemj200013.china.huawei.com (7.202.194.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 15 Dec 2025 15:28:46 +0800
Message-ID: <569d5af7-1f1b-4bd6-b056-4760b6fe9e32@huawei.com>
Date: Mon, 15 Dec 2025 15:28:45 +0800
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: =?UTF-8?B?TW96aWxsYSBUaHVuZGVyYmlyZCDmtYvor5XniYg=?=
Subject: Re: [PATCH v3 1/2] nfsd: provide locking for v4_end_grace
To: Chuck Lever <cel@kernel.org>, NeilBrown <neil@brown.name>, Jeff Layton
	<jlayton@kernel.org>, Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo
	<dai.ngo@oracle.com>, Tom Talpey <tom@talpey.com>
CC: <linux-nfs@vger.kernel.org>, <yangerkun@huawei.com>,
	<yi.zhang@huawei.com>, <houtao1@huawei.com>, <chengzhihao1@huawei.com>
References: <20251213184200.585652-1-cel@kernel.org>
 <20251213184200.585652-2-cel@kernel.org>
From: Li Lingfeng <lilingfeng3@huawei.com>
In-Reply-To: <20251213184200.585652-2-cel@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: kwepems500001.china.huawei.com (7.221.188.70) To
 kwepemj200013.china.huawei.com (7.202.194.25)

Hi,

在 2025/12/14 2:41, Chuck Lever 写道:
> From: NeilBrown <neil@brown.name>
>
> Writing to v4_end_grace can race with server shutdown and result in
> memory being accessed after it was freed - reclaim_str_hashtbl in
> particularly.
>
> We cannot hold nfsd_mutex across the nfsd4_end_grace() call as that is
> held while client_tracking_op->init() is called and that can wait for
> an upcall to nfsdcltrack which can write to v4_end_grace, resulting in a
> deadlock.
>
> nfsd4_end_grace() is also called by the landromat work queue and this
> doesn't require locking as server shutdown will stop the work and wait
> for it before freeing anything that nfsd4_end_grace() might access.
>
> However, we must be sure that writing to v4_end_grace doesn't restart
> the work item after shutdown has already waited for it.  For this we
> add a new flag protected with nn->client_lock.  It is set only while it
> is safe to make client tracking calls, and v4_end_grace only schedules
> work while the flag is set with the spinlock held.
>
> So this patch adds a nfsd_net field "client_tracking_active" which is
> set as described.  Another field "grace_end_forced", is set when
> v4_end_grace is written.  After this is set, and providing
> client_tracking_active is set, the laundromat is scheduled.
> This "grace_end_forced" field bypasses other checks for whether the
> grace period has finished.
>
> This resolves a race which can result in use-after-free.
>
> Reported-by: Li Lingfeng <lilingfeng3@huawei.com>
> Closes: https://lore.kernel.org/linux-nfs/20250623030015.2353515-1-neil@brown.name/T/#t
> Fixes: 7f5ef2e900d9 ("nfsd: add a v4_end_grace file to /proc/fs/nfsd")
> X-Cc: stable@vger.kernel.org
> Signed-off-by: NeilBrown <neil@brown.name>
> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
> ---
>   fs/nfsd/netns.h     |  2 ++
>   fs/nfsd/nfs4state.c | 42 ++++++++++++++++++++++++++++++++++++++++--
>   fs/nfsd/nfsctl.c    |  3 +--
>   fs/nfsd/state.h     |  2 +-
>   4 files changed, 44 insertions(+), 5 deletions(-)
>
> diff --git a/fs/nfsd/netns.h b/fs/nfsd/netns.h
> index 3e2d0fde80a7..fe8338735e7c 100644
> --- a/fs/nfsd/netns.h
> +++ b/fs/nfsd/netns.h
> @@ -66,6 +66,8 @@ struct nfsd_net {
>   
>   	struct lock_manager nfsd4_manager;
>   	bool grace_ended;
> +	bool grace_end_forced;
> +	bool client_tracking_active;
>   	time64_t boot_time;
>   
>   	struct dentry *nfsd_client_dir;
> diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
> index d0efa3e0965f..1d307cc533d9 100644
> --- a/fs/nfsd/nfs4state.c
> +++ b/fs/nfsd/nfs4state.c
> @@ -84,7 +84,7 @@ static u64 current_sessionid = 1;
>   /* forward declarations */
>   static bool check_for_locks(struct nfs4_file *fp, struct nfs4_lockowner *lowner);
>   static void nfs4_free_ol_stateid(struct nfs4_stid *stid);
> -void nfsd4_end_grace(struct nfsd_net *nn);
> +static void nfsd4_end_grace(struct nfsd_net *nn);
>   static void _free_cpntf_state_locked(struct nfsd_net *nn, struct nfs4_cpntf_state *cps);
>   static void nfsd4_file_hash_remove(struct nfs4_file *fi);
>   static void deleg_reaper(struct nfsd_net *nn);
> @@ -6570,7 +6570,7 @@ nfsd4_renew(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
>   	return nfs_ok;
>   }
>   
> -void
> +static void
>   nfsd4_end_grace(struct nfsd_net *nn)
>   {
>   	/* do nothing if grace period already ended */
> @@ -6603,6 +6603,33 @@ nfsd4_end_grace(struct nfsd_net *nn)
>   	 */
>   }
>   
> +/**
> + * nfsd4_force_end_grace - forcibly end the NFSv4 grace period
> + * @nn: network namespace for the server instance to be updated
> + *
> + * Forces bypass of normal grace period completion, then schedules
> + * the laundromat to end the grace period immediately. Does not wait
> + * for the grace period to fully terminate before returning.
> + *
> + * Return values:
> + *   %true: Grace termination schedule
> + *   %false: No action was taken
> + */
> +bool nfsd4_force_end_grace(struct nfsd_net *nn)
> +{
> +	if (!nn->client_tracking_ops)
> +		return false;
> +	spin_lock(&nn->client_lock);
> +	if (nn->grace_ended || !nn->client_tracking_active) {
> +		spin_unlock(&nn->client_lock);
> +		return false;
> +	}
> +	WRITE_ONCE(nn->grace_end_forced, true);
> +	mod_delayed_work(laundry_wq, &nn->laundromat_work, 0);
> +	spin_unlock(&nn->client_lock);
> +	return true;
> +}
> +
>   /*
>    * If we've waited a lease period but there are still clients trying to
>    * reclaim, wait a little longer to give them a chance to finish.
> @@ -6612,6 +6639,8 @@ static bool clients_still_reclaiming(struct nfsd_net *nn)
>   	time64_t double_grace_period_end = nn->boot_time +
>   					   2 * nn->nfsd4_lease;
>   
> +	if (READ_ONCE(nn->grace_end_forced))
> +		return false;
>   	if (nn->track_reclaim_completes &&
>   			atomic_read(&nn->nr_reclaim_complete) ==
>   			nn->reclaim_str_hashtbl_size)
> @@ -8932,6 +8961,8 @@ static int nfs4_state_create_net(struct net *net)
>   	nn->unconf_name_tree = RB_ROOT;
>   	nn->boot_time = ktime_get_real_seconds();
>   	nn->grace_ended = false;
> +	nn->grace_end_forced = false;
> +	nn->client_tracking_active = false;
>   	nn->nfsd4_manager.block_opens = true;
>   	INIT_LIST_HEAD(&nn->nfsd4_manager.list);
>   	INIT_LIST_HEAD(&nn->client_lru);
> @@ -9012,6 +9043,10 @@ nfs4_state_start_net(struct net *net)
>   		return ret;
>   	locks_start_grace(net, &nn->nfsd4_manager);
>   	nfsd4_client_tracking_init(net);
> +	/* safe for laundromat to run now */
> +	spin_lock(&nn->client_lock);
> +	nn->client_tracking_active = true;
> +	spin_unlock(&nn->client_lock);
>   	if (nn->track_reclaim_completes && nn->reclaim_str_hashtbl_size == 0)
>   		goto skip_grace;
>   	printk(KERN_INFO "NFSD: starting %lld-second grace period (net %x)\n",
> @@ -9060,6 +9095,9 @@ nfs4_state_shutdown_net(struct net *net)
>   
>   	shrinker_free(nn->nfsd_client_shrinker);
>   	cancel_work_sync(&nn->nfsd_shrinker_work);
> +	spin_lock(&nn->client_lock);
> +	nn->client_tracking_active = false;
> +	spin_unlock(&nn->client_lock);
>   	cancel_delayed_work_sync(&nn->laundromat_work);
>   	locks_end_grace(&nn->nfsd4_manager);
>   
> diff --git a/fs/nfsd/nfsctl.c b/fs/nfsd/nfsctl.c
> index 5ce9a49e76ba..242fcbd958f1 100644
> --- a/fs/nfsd/nfsctl.c
> +++ b/fs/nfsd/nfsctl.c
> @@ -1082,10 +1082,9 @@ static ssize_t write_v4_end_grace(struct file *file, char *buf, size_t size)
>   		case 'Y':
>   		case 'y':
>   		case '1':
> -			if (!nn->nfsd_serv)
> +			if (!nfsd4_force_end_grace(nn))
>   				return -EBUSY;
>   			trace_nfsd_end_grace(netns(file));
> -			nfsd4_end_grace(nn);
>   			break;
>   		default:
>   			return -EINVAL;
> diff --git a/fs/nfsd/state.h b/fs/nfsd/state.h
> index b052c1effdc5..848c5383d782 100644
> --- a/fs/nfsd/state.h
> +++ b/fs/nfsd/state.h
> @@ -849,7 +849,7 @@ static inline void nfsd4_revoke_states(struct net *net, struct super_block *sb)
>   #endif
>   
>   /* grace period management */
> -void nfsd4_end_grace(struct nfsd_net *nn);
> +bool nfsd4_force_end_grace(struct nfsd_net *nn);
>   
>   /* nfs4recover operations */
>   extern int nfsd4_client_tracking_init(struct net *net);
Thank you for your patch. I reproduced and verified the issue using the
following steps:
mkfs.ext4 -F /dev/sdb
mount /dev/sdb /mnt/sdb
echo "/mnt *(rw,no_root_squash,fsid=0)" > /etc/exports
echo "/mnt/sdb *(rw,no_root_squash,fsid=1)" >> /etc/exports
systemctl restart nfs-server
mount -t nfs -o rw,vers=4.2 127.0.0.1:/sdb /mnt/sdbb
systemctl restart nfs-server
echo 1 > /proc/fs/nfsd/v4_end_grace &
echo 0 > /proc/fs/nfsd/threads


based: master-416f99c3b16f582a3fc6d64a1f77f39d94b76de5


diff:
diff --git a/fs/nfsd/nfs4recover.c b/fs/nfsd/nfs4recover.c
index b39d4cbdfd35..339718af9be3 100644
--- a/fs/nfsd/nfs4recover.c
+++ b/fs/nfsd/nfs4recover.c
@@ -1421,6 +1421,10 @@ nfsd4_cld_grace_done(struct nfsd_net *nn)

         free_cld_upcall(cup);
  out_err:
+       printk("%s %d\n", __func__, __LINE__);
+       printk("%s sleep before release reclaim...\n", __func__);
+       msleep(5 * 1000);
+       printk("%s sleep before release reclaim done\n", __func__);
         nfs4_release_reclaim(nn);
         if (ret)
                 printk(KERN_ERR "NFSD: Unable to end grace period: 
%d\n", ret);
@@ -1454,6 +1458,10 @@ nfs4_cld_state_shutdown(struct net *net)

         nn->track_reclaim_completes = false;
         kfree(nn->reclaim_str_hashtbl);
+       printk("%s free nn->reclaim_str_hashtbl %px done\n", __func__, 
nn->reclaim_str_hashtbl);
+       printk("%s sleep after free...\n", __func__);
+       msleep(10 * 1000);
+       printk("%s sleep done\n", __func__);
  }

  static bool


The original problematic execution flow looks like this:
                 T1                            T2
// echo 1 > /proc/fs/nfsd/v4_end_grace
write_v4_end_grace
  nfsd4_end_grace
   nfsd4_record_grace_done
    nfsd4_cld_grace_done
                                 // echo 0 > /proc/fs/nfsd/threads
                                 write_threads
                                  nfsd_svc
                                   nfsd_destroy_serv
                                    nfsd_shutdown_net
                                     nfs4_state_shutdown_net
                                      nfsd4_client_tracking_exit
                                       nfsd4_cld_tracking_exit
                                        nfs4_cld_state_shutdown
                                         kfree // nn->reclaim_str_hashtbl
     nfs4_release_reclaim
      &nn->reclaim_str_hashtbl[i] // UAF


This patch moves the handling of nfsd4_end_grace() triggered by writing to
v4_end_grace into laundromat_work. As a result, the concurrently executing
T2 path will be blocked by cancel_delayed_work_sync() in
nfs4_state_shutdown_net(), preventing T2 from freeing reclaim_str_hashtbl
while laundromat_work is still running.

Tested-by: Li Lingfeng <lilingfeng3@huawei.com>


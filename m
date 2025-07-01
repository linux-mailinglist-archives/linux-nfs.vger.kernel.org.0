Return-Path: <linux-nfs+bounces-12831-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DC68DAEEF1B
	for <lists+linux-nfs@lfdr.de>; Tue,  1 Jul 2025 08:45:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9A8163BB12E
	for <lists+linux-nfs@lfdr.de>; Tue,  1 Jul 2025 06:44:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 180BD25DCE0;
	Tue,  1 Jul 2025 06:45:08 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5132B25BF0E
	for <linux-nfs@vger.kernel.org>; Tue,  1 Jul 2025 06:45:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751352308; cv=none; b=vBqlX5G5AJOTPh0e5G7O5eSq+wMlgXYjh9zqVG796ZPFSFRe5MXix/U0QEho6aOhz+nVo+kCg4HNXAeA6o2eey5KXSneUcUUogvm4QGHftEuTymuRDoUfj5LxLFkuH2+mHjBIhZcQaWFikhG0IV1TKbI6pQ7gz43TceJe/twhM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751352308; c=relaxed/simple;
	bh=mY98Jos3YEOtg8QmlHLKe+9VGubkbanQ+Kc0gpbSemw=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=B2jn7PiqErmxu53/nyHaUFt8MNGGLmR8tpX0FlgJA3AUW9XVGRuZVz1ISiqO9B8dpMNVuCDSHuFG+Z8TdYs5LkhRRbVM7w8ApLrmLczTBxzXWFFjfSjGSvpLejTO9eHD1yP/rS8t8baRluupw6Jq8vjNKn7wpPGWN2+6lvXqkak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.194])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4bWYLW2K9tz14Lsn;
	Tue,  1 Jul 2025 14:40:19 +0800 (CST)
Received: from kwepemg500017.china.huawei.com (unknown [7.202.181.81])
	by mail.maildlp.com (Postfix) with ESMTPS id 439AD140159;
	Tue,  1 Jul 2025 14:44:59 +0800 (CST)
Received: from [10.174.179.155] (10.174.179.155) by
 kwepemg500017.china.huawei.com (7.202.181.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 1 Jul 2025 14:44:58 +0800
Message-ID: <e7ccd4fc-484d-4402-a245-7019e08b90fc@huawei.com>
Date: Tue, 1 Jul 2025 14:44:57 +0800
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: =?UTF-8?B?TW96aWxsYSBUaHVuZGVyYmlyZCDmtYvor5XniYg=?=
Subject: Re: [PATCH RFT] nfsd: provide locking for v4_end_grace
To: NeilBrown <neil@brown.name>
CC: <linux-nfs@vger.kernel.org>, Olga Kornievskaia <okorniev@redhat.com>, Dai
 Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>, yangerkun
	<yangerkun@huawei.com>, "zhangyi (F)" <yi.zhang@huawei.com>, Hou Tao
	<houtao1@huawei.com>, "yukuai (C)" <yukuai3@huawei.com>,
	"chengzhihao1@huawei.com" <chengzhihao1@huawei.com>, Chuck Lever
	<chuck.lever@oracle.com>, Jeff Layton <jlayton@kernel.org>
References: <175133604142.565058.11913456377522907637@noble.neil.brown.name>
From: Li Lingfeng <lilingfeng3@huawei.com>
In-Reply-To: <175133604142.565058.11913456377522907637@noble.neil.brown.name>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: kwepems200001.china.huawei.com (7.221.188.67) To
 kwepemg500017.china.huawei.com (7.202.181.81)

Hi, Neil
I tested this patch, but unfortunately it did not resolve the issue.

I think the concurrency situation should be like this:
nfsd_svc
  nfsd_startup_net
   nfs4_state_start_net
    nfs4_state_create_net
     INIT_DELAYED_WORK
     // nn->laundromat_work has been initialized
    nfsd4_client_tracking_init
     nfsd4_cld_tracking_init
                                                 write_v4_end_grace
                                                  nfsd4_end_grace
nfsd4_record_grace_done
  nfsd4_cld_grace_done
alloc_cld_upcall
                                                      cn = nn->cld_net
                                                      spin_lock // 
cn->cn_lock
                                                      // null-ptr-deref
      __nfsd4_init_cld_pipe
       cn = kzalloc
       nn->cld_net = cn

The problem I encountered is writing v4_end_grace and service startup 
concurrency.
This patch moves the immediate tasks of write_v4_end_grace to 
laundromat_work.
I believe it can prevent deadlock issues, but it does not actually 
address the
null pointer dereferences caused by concurrency.

Thanks,
Lingfeng.

Base:
commit 86731a2a651e58953fc949573895f2fa6d456841 (tag: v6.16-rc3,
origin/master, origin/HEAD)
Author: Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun Jun 22 13:30:08 2025 -0700

      Linux 6.16-rc3

Diff:
diff --git a/fs/nfsd/nfs4recover.c b/fs/nfsd/nfs4recover.c
index 82785db730d9..0c6f0fbecc02 100644
--- a/fs/nfsd/nfs4recover.c
+++ b/fs/nfsd/nfs4recover.c
@@ -1008,7 +1008,8 @@ __nfsd4_init_cld_pipe(struct net *net)
         if (nn->cld_net)
                 return 0;

-       cn = kzalloc(sizeof(*cn), GFP_KERNEL);
+       cn = NULL;//kzalloc(sizeof(*cn), GFP_KERNEL);
+       printk("%s force err inject\n", __func__);
         if (!cn) {
                 ret = -ENOMEM;
                 goto err;
@@ -1478,6 +1479,7 @@ nfs4_cld_state_init(struct net *net)
         nn->reclaim_str_hashtbl = kmalloc_array(CLIENT_HASH_SIZE,
                                                 sizeof(struct list_head),
                                                 GFP_KERNEL);
+       printk("%s get nn->reclaim_str_hashtbl %px\n", __func__, 
nn->reclaim_str_hashtbl);
         if (!nn->reclaim_str_hashtbl)
                 return -ENOMEM;

@@ -1496,7 +1498,12 @@ nfs4_cld_state_shutdown(struct net *net)
         struct nfsd_net *nn = net_generic(net, nfsd_net_id);

         nn->track_reclaim_completes = false;
+       printk("%s free nn->reclaim_str_hashtbl %px\n", __func__, 
nn->reclaim_str_hashtbl);
         kfree(nn->reclaim_str_hashtbl);
+       printk("%s free nn->reclaim_str_hashtbl %px done\n", __func__, 
nn->reclaim_str_hashtbl);
+       printk("%s sleep after free...\n", __func__);
+       msleep(10 * 1000);
+       printk("%s sleep done\n", __func__);
  }

  static bool

CLIENT A:
[root@nfs_test3 ~]# mount /dev/sdb /mnt/sdb
[root@nfs_test3 ~]# echo "/mnt *(rw,no_root_squash,fsid=0)" > /etc/exports
[root@nfs_test3 ~]# echo "/mnt/sdb *(rw,no_root_squash,fsid=1)" >> 
/etc/exports
[root@nfs_test3 ~]# systemctl restart nfs-server
[  142.103887][ T2762] nfs4_cld_state_init get nn->reclaim_str_hashtbl 
ffff88819366f000
[  142.104971][ T2762] __nfsd4_init_cld_pipe force err inject
[  142.105631][ T2762] NFSD: unable to create nfsdcld upcall pipe (-12)
[  142.106384][ T2762] nfs4_cld_state_shutdown free 
nn->reclaim_str_hashtbl ffff88819366f000
[  142.107366][ T2762] nfs4_cld_state_shutdown free 
nn->reclaim_str_hashtbl ffff88819366f000 done
[  142.108373][ T2762] nfs4_cld_state_shutdown sleep after free...
[  142.872490][  T149] Oops: general protection fault, probably for 
non-canonical address 0xdffffc0000000004: 0000 [#1] SMP KASAN PTI
[  142.874022][  T149] KASAN: null-ptr-deref in range 
[0x0000000000000020-0x0000000000000027]
[  142.875066][  T149] CPU: 10 UID: 0 PID: 149 Comm: kworker/u64:4 Not 
tainted 6.16.0-rc3-00001-g4c30cab673ec-dirty #87 PREEMPT(undef)
[  142.876545][  T149] Hardware name: QEMU Standard PC (i440FX + PIIX, 
1996), BIOS 1.16.3-2.fc40 04/01/2014
[  142.877725][  T149] Workqueue: nfsd4 laundromat_main
[  142.878381][  T149] RIP: 0010:kasan_byte_accessible+0x15/0x30
[  142.879112][  T149] Code: 00 00 0f 1f 00 90 90 90 90 90 90 90 90 90 
90 90 90 90 90 90 90 66 0f 1f 00 48 b8 00 00 00 00 00 fc ff df 48 c1 ef 
03 48 01 c7 <0f> b6 07 3c 07 0f 96 c00
[  142.881501][  T149] RSP: 0018:ffffc900015d7968 EFLAGS: 00010282
[  142.882251][  T149] RAX: dffffc0000000000 RBX: 0000000000000020 RCX: 
0000000000000000
[  142.883229][  T149] RDX: 0000000000000000 RSI: ffffffffa27a4620 RDI: 
dffffc0000000004
[  142.884216][  T149] RBP: 0000000000000020 R08: 0000000000000001 R09: 
0000000000000000
[  142.885195][  T149] R10: ffffffffa17ffd3a R11: ffffffffa0d66dbe R12: 
ffffffffa27a4620
[  142.886176][  T149] R13: 0000000000000001 R14: 0000000000000000 R15: 
0000000000000000
[  142.887150][  T149] FS:  0000000000000000(0000) 
GS:ffff888e52e1b000(0000) knlGS:0000000000000000
[  142.888246][  T149] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  142.889059][  T149] CR2: 0000557d474b9308 CR3: 0000000f2408e000 CR4: 
00000000000006f0
[  142.890029][  T149] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 
0000000000000000
[  142.891008][  T149] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 
0000000000000400
[  142.891977][  T149] Call Trace:
[  142.892390][  T149]  <TASK>
[  142.892753][  T149]  __kasan_check_byte+0x13/0x50
[  142.893363][  T149]  lock_acquire.part.0+0x36/0x220
[  142.893990][  T149]  ? rcu_is_watching+0x20/0x50
[  142.894592][  T149]  ? lock_acquire+0xf2/0x140
[  142.895162][  T149]  ? alloc_cld_upcall+0x6a/0x1e0
[  142.895776][  T149]  _raw_spin_lock+0x30/0x40
[  142.896339][  T149]  ? alloc_cld_upcall+0x6a/0x1e0
[  142.896948][  T149]  alloc_cld_upcall+0x6a/0x1e0
[  142.897543][  T149]  nfsd4_cld_grace_done+0x93/0x270
[  142.898174][  T149]  ? __pfx_nfsd4_cld_grace_done+0x10/0x10
[  142.898889][  T149]  ? find_held_lock+0x2b/0x80
[  142.899473][  T149]  ? nfs4_laundromat+0x8e/0xc30
[  142.900071][  T149]  ? nfs4_laundromat+0x8e/0xc30
[  142.900660][  T149]  ? mark_held_locks+0x40/0x70
[  142.901259][  T149]  nfsd4_end_grace.part.0+0x51/0x120
[  142.901913][  T149]  nfs4_laundromat+0x29a/0xc30
[  142.902519][  T149]  ? __pfx_nfs4_laundromat+0x10/0x10
[  142.903173][  T149]  ? __lock_release.isra.0+0x5f/0x180
[  142.903850][  T149]  ? lock_acquire.part.0+0xac/0x220
[  142.904493][  T149]  ? process_one_work+0x72b/0x8a0
[  142.905112][  T149]  ? rcu_is_watching+0x20/0x50
[  142.905708][  T149]  ? process_one_work+0x72b/0x8a0
[  142.906336][  T149]  laundromat_main+0x19/0x40
[  142.906903][  T149]  process_one_work+0x7ab/0x8a0
[  142.907509][  T149]  ? process_one_work+0x72b/0x8a0
[  142.908130][  T149]  ? process_one_work+0x72b/0x8a0
[  142.908764][  T149]  ? __pfx_process_one_work+0x10/0x10
[  142.909433][  T149]  ? __list_add_valid_or_report+0x37/0x100
[  142.910160][  T149]  worker_thread+0x390/0x690
[  142.910738][  T149]  ? __kthread_parkme+0xe8/0x110
[  142.911355][  T149]  ? __pfx_worker_thread+0x10/0x10
[  142.911990][  T149]  kthread+0x23c/0x3d0
[  142.912499][  T149]  ? kthread+0x12d/0x3d0
[  142.913024][  T149]  ? __pfx_kthread+0x10/0x10
[  142.913601][  T149]  ? ret_from_fork+0x1d/0x2b0
[  142.914180][  T149]  ? __lock_release.isra.0+0x5f/0x180
[  142.914853][  T149]  ? rcu_is_watching+0x20/0x50
[  142.915450][  T149]  ? __pfx_kthread+0x10/0x10
[  142.916018][  T149]  ret_from_fork+0x21e/0x2b0
[  142.916588][  T149]  ? __pfx_kthread+0x10/0x10
[  142.917167][  T149]  ret_from_fork_asm+0x1a/0x30
[  142.917766][  T149]  </TASK>
[  142.918146][  T149] Modules linked in:
[  142.918674][  T149] ---[ end trace 0000000000000000 ]---
[  142.919360][  T149] RIP: 0010:kasan_byte_accessible+0x15/0x30
[  142.920099][  T149] Code: 00 00 0f 1f 00 90 90 90 90 90 90 90 90 90 
90 90 90 90 90 90 90 66 0f 1f 00 48 b8 00 00 00 00 00 fc ff df 48 c1 ef 
03 48 01 c7 <0f> b6 07 3c 07 0f 96 c00
[  142.922522][  T149] RSP: 0018:ffffc900015d7968 EFLAGS: 00010282
[  142.923276][  T149] RAX: dffffc0000000000 RBX: 0000000000000020 RCX: 
0000000000000000
[  142.924271][  T149] RDX: 0000000000000000 RSI: ffffffffa27a4620 RDI: 
dffffc0000000004
[  142.925297][  T149] RBP: 0000000000000020 R08: 0000000000000001 R09: 
0000000000000000
[  142.926282][  T149] R10: ffffffffa17ffd3a R11: ffffffffa0d66dbe R12: 
ffffffffa27a4620
[  142.927280][  T149] R13: 0000000000000001 R14: 0000000000000000 R15: 
0000000000000000
[  142.928259][  T149] FS:  0000000000000000(0000) 
GS:ffff888e52e1b000(0000) knlGS:0000000000000000
[  142.929382][  T149] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  142.930198][  T149] CR2: 0000557d474b9308 CR3: 0000000f2408e000 CR4: 
00000000000006f0
[  142.931185][  T149] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 
0000000000000000
[  142.932173][  T149] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 
0000000000000400
[  142.933175][  T149] Kernel panic - not syncing: Fatal exception
[  142.934551][  T149] Kernel Offset: 0x1fa00000 from 0xffffffff81000000 
(relocation range: 0xffffffff80000000-0xffffffffbfffffff)
[  142.935979][  T149] ---[ end Kernel panic - not syncing: Fatal 
exception ]---

CLIENT B:
write /proc/fs/nfsd/v4_end_grace between "nfs4_cld_state_shutdown sleep
after free..." and "nfs4_cld_state_shutdown sleep done"
[root@nfs_test3 ~]# echo 1 > /proc/fs/nfsd/v4_end_grace

在 2025/7/1 10:14, NeilBrown 写道:
> Writing to v4_end_grace can race with server shutdown and result in
> memory being accessed after it was freed - reclaim_str_hashtbl in
> particular.
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
> the work item after shutdown has already waited for it.  For this we can
> use disable_delayed_work_sync() instead of cancel_delayed_work_sync().
>
> So this patch adds a nfsd_net field "grace_end_forced", sets that when
> v4_end_grace is written, and schedules the laundromat (providing it
> hasn't been disabled).  This field bypasses other checks for whether the
> grace period has finished.  The delayed work is disabled before
> nfsd4_client_tracking_exit() is call to shutdown client tracking.
>
> This resolves a race which can result in use-after-free.
>
> Note that disable_delayed_work_sync() was added in v6.10.  To backport
> to an earlier kernel without that interface the exclusion could be
> provided by some spinlock that was released in the shutdown path
> after ->nfsd_serv is set to NULL.  It would need to be taken before
> the test on nfsd_serv in write_v4_end_grace() and released after
> nfsd4_force_end_grace() is called.
>
> Reported-by: Li Lingfeng <lilingfeng3@huawei.com>
> Cc: stable@vger.kernel.org
> Signed-off-by: NeilBrown <neil@brown.name>
> ---
>   fs/nfsd/netns.h     |  1 +
>   fs/nfsd/nfs4state.c | 19 ++++++++++++++++---
>   fs/nfsd/nfsctl.c    |  7 ++++++-
>   fs/nfsd/state.h     |  2 +-
>   4 files changed, 24 insertions(+), 5 deletions(-)
>
> diff --git a/fs/nfsd/netns.h b/fs/nfsd/netns.h
> index 3e2d0fde80a7..d83c68872c4c 100644
> --- a/fs/nfsd/netns.h
> +++ b/fs/nfsd/netns.h
> @@ -66,6 +66,7 @@ struct nfsd_net {
>   
>   	struct lock_manager nfsd4_manager;
>   	bool grace_ended;
> +	bool grace_end_forced;
>   	time64_t boot_time;
>   
>   	struct dentry *nfsd_client_dir;
> diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
> index d5694987f86f..b34f157334e6 100644
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
> @@ -6458,7 +6458,7 @@ nfsd4_renew(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
>   	return nfs_ok;
>   }
>   
> -void
> +static void
>   nfsd4_end_grace(struct nfsd_net *nn)
>   {
>   	/* do nothing if grace period already ended */
> @@ -6491,6 +6491,16 @@ nfsd4_end_grace(struct nfsd_net *nn)
>   	 */
>   }
>   
> +void
> +nfsd4_force_end_grace(struct nfsd_net *nn)
> +{
> +	nn->grace_end_forced = true;
> +	/* This is a no-op after nfs4_state_shutdown_net() has called
> +	 * disable_delayed_work_sync()
> +	 */
> +	mod_delayed_work(laundry_wq, &nn->laundromat_work, 0);
> +}
> +
>   /*
>    * If we've waited a lease period but there are still clients trying to
>    * reclaim, wait a little longer to give them a chance to finish.
> @@ -6500,6 +6510,8 @@ static bool clients_still_reclaiming(struct nfsd_net *nn)
>   	time64_t double_grace_period_end = nn->boot_time +
>   					   2 * nn->nfsd4_lease;
>   
> +	if (nn->grace_end_forced)
> +		return false;
>   	if (nn->track_reclaim_completes &&
>   			atomic_read(&nn->nr_reclaim_complete) ==
>   			nn->reclaim_str_hashtbl_size)
> @@ -8807,6 +8819,7 @@ static int nfs4_state_create_net(struct net *net)
>   	nn->unconf_name_tree = RB_ROOT;
>   	nn->boot_time = ktime_get_real_seconds();
>   	nn->grace_ended = false;
> +	nn->grace_end_forced = false;
>   	nn->nfsd4_manager.block_opens = true;
>   	INIT_LIST_HEAD(&nn->nfsd4_manager.list);
>   	INIT_LIST_HEAD(&nn->client_lru);
> @@ -8935,7 +8948,7 @@ nfs4_state_shutdown_net(struct net *net)
>   
>   	shrinker_free(nn->nfsd_client_shrinker);
>   	cancel_work_sync(&nn->nfsd_shrinker_work);
> -	cancel_delayed_work_sync(&nn->laundromat_work);
> +	disable_delayed_work_sync(&nn->laundromat_work);
>   	locks_end_grace(&nn->nfsd4_manager);
>   
>   	INIT_LIST_HEAD(&reaplist);
> diff --git a/fs/nfsd/nfsctl.c b/fs/nfsd/nfsctl.c
> index 3f3e9f6c4250..a9e6c2a155da 100644
> --- a/fs/nfsd/nfsctl.c
> +++ b/fs/nfsd/nfsctl.c
> @@ -1082,10 +1082,15 @@ static ssize_t write_v4_end_grace(struct file *file, char *buf, size_t size)
>   		case 'Y':
>   		case 'y':
>   		case '1':
> +			/* This test ensures we don't try to
> +			 * end grace before the server has been started,
> +			 * but doesn't guarantee we don't end grace
> +			 * while the server is being shut down.
> +			 */
>   			if (!nn->nfsd_serv)
>   				return -EBUSY;
>   			trace_nfsd_end_grace(netns(file));
> -			nfsd4_end_grace(nn);
> +			nfsd4_force_end_grace(nn);
>   			break;
>   		default:
>   			return -EINVAL;
> diff --git a/fs/nfsd/state.h b/fs/nfsd/state.h
> index 1995bca158b8..e2bea9908fa8 100644
> --- a/fs/nfsd/state.h
> +++ b/fs/nfsd/state.h
> @@ -836,7 +836,7 @@ static inline void nfsd4_revoke_states(struct net *net, struct super_block *sb)
>   #endif
>   
>   /* grace period management */
> -void nfsd4_end_grace(struct nfsd_net *nn);
> +void nfsd4_force_end_grace(struct nfsd_net *nn);
>   
>   /* nfs4recover operations */
>   extern int nfsd4_client_tracking_init(struct net *net);


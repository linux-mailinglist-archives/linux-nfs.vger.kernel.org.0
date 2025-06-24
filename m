Return-Path: <linux-nfs+bounces-12681-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C7109AE5A45
	for <lists+linux-nfs@lfdr.de>; Tue, 24 Jun 2025 04:52:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D75624432C4
	for <lists+linux-nfs@lfdr.de>; Tue, 24 Jun 2025 02:52:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46F4D18859B;
	Tue, 24 Jun 2025 02:52:23 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from szxga07-in.huawei.com (szxga07-in.huawei.com [45.249.212.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AB325680
	for <linux-nfs@vger.kernel.org>; Tue, 24 Jun 2025 02:52:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750733543; cv=none; b=igdssNUOJblnLSt5ax3IHNRCPjnBZXVN4dwMuXvBIiSaBbZbJIcJ9XdG5xzKnHEZGkNLwKNDNVizDElC1gkTAYagDvdHljojhjcK/HYej+/+h46DyiTPypkH4iIJJWZOOvbBs36BJU/CfNOe9fu+jWw3SYuNvk3MWQG1+OUuWCU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750733543; c=relaxed/simple;
	bh=gkc8qaTKEoTMeBbX/uGfbSy7mKunqTLDM7BXe+y17T8=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=CZYVEHShswizLR1gi6QndOs+y5iBaxorGaE8wLkj/BcOuoDzLzLVVpcsZ2DQ0YswM0PNnA9j/PA+H+7CfsTOsv4r4Fk2lCy9+AjoFj23YGqDRTK5khCFf8xTBVkL+fGDu/p1g7VHKvK5j+oDag1M3LQIY6P+RU2Ft1nDSTKI6Fg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.17])
	by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4bR8Zd0n3mz29dn4;
	Tue, 24 Jun 2025 10:50:33 +0800 (CST)
Received: from kwepemg500017.china.huawei.com (unknown [7.202.181.81])
	by mail.maildlp.com (Postfix) with ESMTPS id 68D251A0188;
	Tue, 24 Jun 2025 10:52:09 +0800 (CST)
Received: from [10.174.179.155] (10.174.179.155) by
 kwepemg500017.china.huawei.com (7.202.181.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 24 Jun 2025 10:52:08 +0800
Message-ID: <87302f1a-8313-4dd7-919e-849291efece2@huawei.com>
Date: Tue, 24 Jun 2025 10:52:08 +0800
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: =?UTF-8?B?TW96aWxsYSBUaHVuZGVyYmlyZCDmtYvor5XniYg=?=
Subject: Re: [PATCH 1/4] nfsd: provide proper locking for all write_ function
To: NeilBrown <neil@brown.name>, Chuck Lever <chuck.lever@oracle.com>, Jeff
 Layton <jlayton@kernel.org>
CC: <linux-nfs@vger.kernel.org>, Olga Kornievskaia <okorniev@redhat.com>, Dai
 Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>, yangerkun
	<yangerkun@huawei.com>, "zhangyi (F)" <yi.zhang@huawei.com>, Hou Tao
	<houtao1@huawei.com>, "yukuai (C)" <yukuai3@huawei.com>,
	<libaokun1@huawei.com>
References: <20250623030015.2353515-1-neil@brown.name>
 <20250623030015.2353515-2-neil@brown.name>
From: Li Lingfeng <lilingfeng3@huawei.com>
In-Reply-To: <20250623030015.2353515-2-neil@brown.name>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: kwepems500002.china.huawei.com (7.221.188.17) To
 kwepemg500017.china.huawei.com (7.202.181.81)

Hi,

During my validation of this fix patch, I encountered a deadlock issue
that wasn't present during last Saturday's verification.
Process 2761 holds the nfsd_mutex while sending an upcall request,
triggering process 2776.
This process must complete writing to end_grace before responding to the
upcall, but it gets blocked while attempting to acquire the nfsd_mutex,
causing a deadlock.
I revalidated the previous solution and found the same issue.
I'm unsure what changed between validations.
Additionally, why was the locking mechanism changed from guard(mutex) in
the previous version to explicit mutex_lock/mutex_unlock in this version?

Thanks.

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
[  229.107168][ T2761] nfs4_cld_state_init get nn->reclaim_str_hashtbl 
ffff88810e20ba00
[  229.108175][ T2761] __nfsd4_init_cld_pipe force err inject
[  229.108819][ T2761] NFSD: unable to create nfsdcld upcall pipe (-12)
[  229.109568][ T2761] nfs4_cld_state_shutdown free 
nn->reclaim_str_hashtbl ffff88810e20ba00
[  229.110601][ T2761] nfs4_cld_state_shutdown free 
nn->reclaim_str_hashtbl ffff88810e20ba00 done
[  229.111599][ T2761] nfs4_cld_state_shutdown sleep after free...
[  239.282399][ T2761] nfs4_cld_state_shutdown sleep done
[  239.283083][ T2761] __nfsd4_init_cld_pipe force err inject
[  239.283734][ T2761] NFSD: unable to create nfsdcld upcall pipe (-12)
[  453.554502][  T101] INFO: task bash:2644 blocked for more than 147 
seconds.
[  453.555494][  T101]       Not tainted 
6.16.0-rc3-00001-g4e8c356736df-dirty #84
[  453.556408][  T101] "echo 0 > 
/proc/sys/kernel/hung_task_timeout_secs" disables this message.
[  453.558022][  T101] INFO: task bash:2644 is blocked on a mutex likely 
owned by task rpc.nfsd:2761.
[  453.559949][  T101] INFO: task rpc.nfsd:2761 blocked for more than 
147 seconds.
[  453.560868][  T101]       Not tainted 
6.16.0-rc3-00001-g4e8c356736df-dirty #84
[  453.561770][  T101] "echo 0 > 
/proc/sys/kernel/hung_task_timeout_secs" disables this message.
[  453.563573][  T101] INFO: task nfsdcltrack:2776 blocked for more than 
147 seconds.
[  453.564516][  T101]       Not tainted 
6.16.0-rc3-00001-g4e8c356736df-dirty #84
[  453.565431][  T101] "echo 0 > 
/proc/sys/kernel/hung_task_timeout_secs" disables this message.
[  453.566945][  T101] INFO: task nfsdcltrack:2776 is blocked on a mutex 
likely owned by task rpc.nfsd:2761.
[  453.568860][  T101]
[  453.568860][  T101] Showing all locks held in the system:
[  453.569816][  T101] 1 lock held by khungtaskd/101:
[  453.570469][  T101]  #0: ffffffffa6f66120 
(rcu_read_lock){....}-{1:3}, at: rcu_lock_acquire.constprop.0+0x7/0x30
[  453.571753][  T101] 2 locks held by kworker/u64:4/149:
[  453.572402][  T101]  #0: ffff8881001a5948 
((wq_completion)events_unbound){+.+.}-{0:0}, at: 
process_one_work+0x72b/0x8a0
[  453.573758][  T101]  #1: ffffc90000bcfd60 
((work_completion)(&sub_info->work)){+.+.}-{0:0}, at: 
process_one_work+0x72b/0x8a0
[  453.575172][  T101] 2 locks held by bash/2644:
[  453.575742][  T101]  #0: ffff88810e204400 
(sb_writers#12){.+.+}-{0:0}, at: ksys_write+0xc9/0x160
[  453.576856][  T101]  #1: ffffffffa738e508 (nfsd_mutex){+.+.}-{4:4}, 
at: write_v4_end_grace+0x94/0x160
[  453.578005][  T101] 2 locks held by rpc.nfsd/2761:
[  453.578644][  T101]  #0: ffff88810e204400 
(sb_writers#12){.+.+}-{0:0}, at: ksys_write+0xc9/0x160
[  453.579750][  T101]  #1: ffffffffa738e508 (nfsd_mutex){+.+.}-{4:4}, 
at: write_threads+0x14e/0x210
[  453.580871][  T101] 2 locks held by nfsdcltrack/2776:
[  453.581511][  T101]  #0: ffff88810e204400 
(sb_writers#12){.+.+}-{0:0}, at: ksys_write+0xc9/0x160
[  453.582644][  T101]  #1: ffffffffa738e508 (nfsd_mutex){+.+.}-{4:4}, 
at: write_v4_end_grace+0x94/0x160
[  453.583793][  T101]
[  453.584085][  T101] =============================================
[  453.584085][  T101]

CLIENT B:
write /proc/fs/nfsd/v4_end_grace between "nfs4_cld_state_shutdown sleep 
after free..." and "nfs4_cld_state_shutdown sleep done"
[root@nfs_test3 ~]# echo 1 > /proc/fs/nfsd/v4_end_grace

Processes:
[root@nfs_test3 ~]# ps aux | grep D
USER       PID %CPU %MEM    VSZ   RSS TTY      STAT START   TIME COMMAND
root       378  0.1  0.0  97948  7008 ?        Ss   10:04   0:00 
/usr/sbin/sshd -D
root      2644  1.3  0.0 127676  8656 pts/0    Ds+  10:06   0:00 -bash
root      2745  0.5  0.0 270324  3356 ?        Ssl  10:06   0:00 
/usr/sbin/gssproxy -D
root      2761  0.9  0.0  33740  2808 ?        Ds   10:06   0:00 
/usr/sbin/rpc.nfsd -V 2 8
root      2776  0.0  0.0  19272  3076 ?        D    10:06   0:00 
/sbin/nfsdcltrack init
root      2885  0.0  0.0 119476  2320 pts/1    S+   10:07   0:00 grep 
--color=auto D
[root@nfs_test3 ~]# cat /proc/2644/stack
[<0>] write_v4_end_grace+0x94/0x160
[<0>] nfsctl_transaction_write+0x8b/0xf0
[<0>] vfs_write+0x160/0x7f0
[<0>] ksys_write+0xc9/0x160
[<0>] do_syscall_64+0x72/0x390
[<0>] entry_SYSCALL_64_after_hwframe+0x76/0x7e
[root@nfs_test3 ~]# cat /proc/2761/stack
[<0>] call_usermodehelper_exec+0x283/0x2d0
[<0>] nfsd4_umh_cltrack_upcall+0xfc/0x1a0
[<0>] nfsd4_umh_cltrack_init+0x60/0x80
[<0>] nfsd4_client_tracking_init+0x1a7/0x260
[<0>] nfs4_state_start_net+0x63/0x90
[<0>] nfsd_startup_net+0x261/0x320
[<0>] nfsd_svc+0x103/0x1a0
[<0>] write_threads+0x170/0x210
[<0>] nfsctl_transaction_write+0x8b/0xf0
[<0>] vfs_write+0x160/0x7f0
[<0>] ksys_write+0xc9/0x160
[<0>] do_syscall_64+0x72/0x390
[<0>] entry_SYSCALL_64_after_hwframe+0x76/0x7e
[root@nfs_test3 ~]# cat /proc/2776/stack
[<0>] write_v4_end_grace+0x94/0x160
[<0>] nfsctl_transaction_write+0x8b/0xf0
[<0>] vfs_write+0x160/0x7f0
[<0>] ksys_write+0xc9/0x160
[<0>] do_syscall_64+0x72/0x390
[<0>] entry_SYSCALL_64_after_hwframe+0x76/0x7e
[root@nfs_test3 ~]#


在 2025/6/23 10:47, NeilBrown 写道:
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
> functions abort if ->nfsd_serv is not set.
>
> Reported-and-tested-by: Li Lingfeng <lilingfeng3@huawei.com>
> Signed-off-by: NeilBrown <neil@brown.name>
> ---
>   fs/nfsd/nfsctl.c | 40 +++++++++++++++++++++++++++++++++++++---
>   1 file changed, 37 insertions(+), 3 deletions(-)
>
> diff --git a/fs/nfsd/nfsctl.c b/fs/nfsd/nfsctl.c
> index 3f3e9f6c4250..6b0cad81b5fa 100644
> --- a/fs/nfsd/nfsctl.c
> +++ b/fs/nfsd/nfsctl.c
> @@ -214,13 +214,18 @@ static inline struct net *netns(struct file *file)
>    *			returns one if one or more locks were not released
>    *	On error:	return code is negative errno value
>    */
> -static ssize_t write_unlock_ip(struct file *file, char *buf, size_t size)
> +static ssize_t __write_unlock_ip(struct file *file, char *buf, size_t size)
>   {
>   	struct sockaddr_storage address;
>   	struct sockaddr *sap = (struct sockaddr *)&address;
>   	size_t salen = sizeof(address);
>   	char *fo_path;
>   	struct net *net = netns(file);
> +	struct nfsd_net *nn = net_generic(net, nfsd_net_id);
> +
> +	if (!nn->nfsd_serv)
> +		/* There cannot be any files to unlock */
> +		return -EINVAL;
>   
>   	/* sanity check */
>   	if (size == 0)
> @@ -240,6 +245,16 @@ static ssize_t write_unlock_ip(struct file *file, char *buf, size_t size)
>   	return nlmsvc_unlock_all_by_ip(sap);
>   }
>   
> +static ssize_t write_unlock_ip(struct file *file, char *buf, size_t size)
> +{
> +	ssize_t ret;
> +
> +	mutex_lock(&nfsd_mutex);
> +	ret = __write_unlock_ip(file, buf, size);
> +	mutex_unlock(&nfsd_mutex);
> +	return ret;
> +}
> +
>   /*
>    * write_unlock_fs - Release all locks on a local file system
>    *
> @@ -254,11 +269,16 @@ static ssize_t write_unlock_ip(struct file *file, char *buf, size_t size)
>    *			returns one if one or more locks were not released
>    *	On error:	return code is negative errno value
>    */
> -static ssize_t write_unlock_fs(struct file *file, char *buf, size_t size)
> +static ssize_t __write_unlock_fs(struct file *file, char *buf, size_t size)
>   {
>   	struct path path;
>   	char *fo_path;
>   	int error;
> +	struct nfsd_net *nn = net_generic(netns(file), nfsd_net_id);
> +
> +	if (!nn->nfsd_serv)
> +		/* There cannot be any files to unlock */
> +		return -EINVAL;
>   
>   	/* sanity check */
>   	if (size == 0)
> @@ -291,6 +311,16 @@ static ssize_t write_unlock_fs(struct file *file, char *buf, size_t size)
>   	return error;
>   }
>   
> +static ssize_t write_unlock_fs(struct file *file, char *buf, size_t size)
> +{
> +	ssize_t ret;
> +
> +	mutex_lock(&nfsd_mutex);
> +	ret = __write_unlock_fs(file, buf, size);
> +	mutex_unlock(&nfsd_mutex);
> +	return ret;
> +}
> +
>   /*
>    * write_filehandle - Get a variable-length NFS file handle by path
>    *
> @@ -1082,10 +1112,14 @@ static ssize_t write_v4_end_grace(struct file *file, char *buf, size_t size)
>   		case 'Y':
>   		case 'y':
>   		case '1':
> -			if (!nn->nfsd_serv)
> +			mutex_lock(&nfsd_mutex);
> +			if (!nn->nfsd_serv) {
> +				mutex_unlock(&nfsd_mutex);
>   				return -EBUSY;
> +			}
>   			trace_nfsd_end_grace(netns(file));
>   			nfsd4_end_grace(nn);
> +			mutex_unlock(&nfsd_mutex);
>   			break;
>   		default:
>   			return -EINVAL;


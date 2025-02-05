Return-Path: <linux-nfs+bounces-9873-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 562C4A284D6
	for <lists+linux-nfs@lfdr.de>; Wed,  5 Feb 2025 08:12:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C395C16725B
	for <lists+linux-nfs@lfdr.de>; Wed,  5 Feb 2025 07:12:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42C9D221D90;
	Wed,  5 Feb 2025 07:12:17 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E107679FE
	for <linux-nfs@vger.kernel.org>; Wed,  5 Feb 2025 07:12:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738739537; cv=none; b=lEjdI9LC8wRzc5GT+QO8Rc8GW0Mow0DtwF0dwiplXpApdNE4MbUClwLD3X5nYlGDOHOi86zQ29lDVT6QKe1oPsGrboCGZ/WsNwZq/uSOVt1GAkjgmTO9iolmN5wq0RsvffK1a0ttGQ4tEqe3A62klgK0itFwjXdqIZVeelgRmfM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738739537; c=relaxed/simple;
	bh=FZXBrSmF2KeRRFo5aqdVnnbKdlRX2HAt7oyFddg180Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:CC:From:
	 In-Reply-To:Content-Type; b=qogtrKSKBy3lvKAsHQ17xICYTJZCMYqO0RZbTCbhYEyudhDAGML2c9V8hbz07KeQgZOAZpZJw24XDy9OJz7IDKvneKsk3ovpe537lwvMABxZvAcc9NyHCVLA8VE9clOB8CRY0Ka6zcRHsDGx0llqSDeX/9Vj2CRCivWhbpSCMJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.105])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4Ynrsh3yNHz11MS8;
	Wed,  5 Feb 2025 15:07:52 +0800 (CST)
Received: from kwepemg500017.china.huawei.com (unknown [7.202.181.81])
	by mail.maildlp.com (Postfix) with ESMTPS id 9794F140159;
	Wed,  5 Feb 2025 15:12:10 +0800 (CST)
Received: from [10.174.179.155] (10.174.179.155) by
 kwepemg500017.china.huawei.com (7.202.181.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 5 Feb 2025 15:12:09 +0800
Message-ID: <ce61054d-d465-4b50-b88a-75ed92165b6e@huawei.com>
Date: Wed, 5 Feb 2025 15:12:09 +0800
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: =?UTF-8?B?TW96aWxsYSBUaHVuZGVyYmlyZCDmtYvor5XniYg=?=
Subject: Re: [PATCH] SUNRPC: Prevent looping due to rpc_signal_task() races
To: <trondmy@kernel.org>, <linux-nfs@vger.kernel.org>
References: <69b6cd8f9689e84e1db8eb7e5da46946015dd1b5.1738439878.git.trond.myklebust@hammerspace.com>
CC: yangerkun <yangerkun@huawei.com>, "zhangyi (F)" <yi.zhang@huawei.com>,
	"yukuai (C)" <yukuai3@huawei.com>, Hou Tao <houtao1@huawei.com>
From: Li Lingfeng <lilingfeng3@huawei.com>
In-Reply-To: <69b6cd8f9689e84e1db8eb7e5da46946015dd1b5.1738439878.git.trond.myklebust@hammerspace.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 kwepemg500017.china.huawei.com (7.202.181.81)

Hi
Thanks for your patch. I've tested it and confirmed it solves the problem
we found.
This is how I reproduce the problem and verify whether the problem is
solved.

diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
index df9669d4ded7..7d9fd0166f91 100644
--- a/fs/nfs/nfs4proc.c
+++ b/fs/nfs/nfs4proc.c
@@ -3642,6 +3642,7 @@ static void nfs4_close_done(struct rpc_task *task, 
void *data)
                 .inode = calldata->inode,
                 .stateid = &calldata->arg.stateid,
         };
+       static int fault_inject = 1;

         if (!nfs4_sequence_done(task, &calldata->res.seq_res))
                 return;
@@ -3655,6 +3656,11 @@ static void nfs4_close_done(struct rpc_task 
*task, void *data)
         /* hmm. we are done with the inode, and in the process of freeing
          * the state_owner. we keep this around to process errors
          */
+       if (fault_inject) {
+               fault_inject = 0;
+               printk("%s %d inject err to tk_status\n", __func__, 
__LINE__);
+               task->tk_status = -NFS4ERR_OLD_STATEID;
+       }
         switch (task->tk_status) {
                 case 0:
                         res_stateid = &calldata->res.stateid;
@@ -3701,6 +3707,9 @@ static void nfs4_close_done(struct rpc_task *task, 
void *data)
         return;
  out_restart:
         task->tk_status = 0;
+       printk("%s %d sleep before restart task %px(tk_rpc_status 
%d)...\n", __func__, __LINE__, task, task->tk_rpc_status);
+       msleep(10 * 1000);
+       printk("%s %d sleep done\n", __func__, __LINE__);
         rpc_restart_call_prepare(task);
         goto out_release;
  }
diff --git a/net/sunrpc/clnt.c b/net/sunrpc/clnt.c
index 2fe88ea79a70..78bc9739df82 100644
--- a/net/sunrpc/clnt.c
+++ b/net/sunrpc/clnt.c
@@ -1968,6 +1968,11 @@ rpc_xdr_encode(struct rpc_task *task)
  static void
  call_encode(struct rpc_task *task)
  {
+       static int count = 0;
+       if (count++ > 10000) {
+               count = 0;
+               printk("call encode for task %px 10000 times\n", task);
+       }
         if (!rpc_task_need_encode(task))
                 goto out;

1) reproduce the problem -- get an rpc_task that keeps looping.
[2025-02-05 14:19:50]  Fedora 26 (Twenty Six)
[2025-02-05 14:19:50]  Kernel 6.14.0-rc1-00028-g5c8c229261f1-dirty on an 
x86_64 (ttyS0)
[2025-02-05 14:19:50]
[2025-02-05 14:19:50]  nfs_test2 login: root
[2025-02-05 14:28:28]  Password:
[2025-02-05 14:28:31]  Last login: Wed Feb  5 14:01:32 from 192.168.240.1
[2025-02-05 14:28:33]  [root@nfs_test2 ~]# mkfs.ext4 -F /dev/sdb
[2025-02-05 14:30:56]  mke2fs 1.46.5 (30-Dec-2021)
[2025-02-05 14:30:56]  /dev/sdb contains a ext4 file system
[2025-02-05 14:30:56]      last mounted on /mnt/sdb on Wed Feb  5 
11:23:04 2025
[2025-02-05 14:30:56]  Discarding device blocks: 0/5242880               
done
[2025-02-05 14:30:56]  Creating filesystem with 5242880 4k blocks and 
1310720 inodes
[2025-02-05 14:30:56]  Filesystem UUID: 5acab554-5ba5-4ad4-a449-8cc69b69bcf1
[2025-02-05 14:30:56]  Superblock backups stored on blocks:
[2025-02-05 14:30:56]      32768, 98304, 163840, 229376, 294912, 819200, 
884736, 1605632, 2654208,
[2025-02-05 14:30:56]      4096000
[2025-02-05 14:30:56]
[2025-02-05 14:30:56]  Allocating group tables:   0/160 done
[2025-02-05 14:30:56]  Writing inode tables:   0/160 done
[2025-02-05 14:30:56]  Creating journal (32768 blocks): done
[2025-02-05 14:30:56]  Writing superblocks and filesystem accounting 
information:   0/160       done
[2025-02-05 14:30:57]
[2025-02-05 14:30:57]  [root@nfs_test2 ~]# mount /dev/sdb /mnt/sdb
[2025-02-05 14:30:57]  [root@nfs_test2 ~]# echo 123 > 
/mnt/sdb/nfs_testfile1209
[2025-02-05 14:30:57]  [root@nfs_test2 ~]# echo "/mnt 
*(rw,no_root_squash,fsid=0)" > /etc/exports
[2025-02-05 14:30:57]  [root@nfs_test2 ~]# echo "/mnt/sdb 
*(rw,no_root_squash,fsid=1)" >> /etc/exports
[2025-02-05 14:30:57]  [root@nfs_test2 ~]# systemctl restart nfs-server
[2025-02-05 14:31:00]  [root@nfs_test2 ~]# mount -t nfs -o 
rw,soft,vers=4.1 127.0.0.1:/sdb /mnt/sdbb
[2025-02-05 14:31:08]  [root@nfs_test2 ~]# cat /mnt/sdbb/nfs_testfile1209 &
[2025-02-05 14:31:11]  [1] 2815
[2025-02-05 14:31:11]  [root@nfs_test2 ~]# 123
[2025-02-05 14:31:11]  [  744.234368][  T121] nfs4_close_done 3661 
inject err to tk_status
[2025-02-05 14:31:16]
[2025-02-05 14:31:16]  [root@nfs_test2 ~]# [  749.297829][  T121] 
nfs4_close_done 3710 sleep before restart task 
ffff88812718b080(tk_rpc_status 0)...
[2025-02-05 14:31:18]
[2025-02-05 14:31:18]  [root@nfs_test2 ~]# umount -f /mnt/sdbb
[2025-02-05 14:31:19]  umount.nfs4: /mnt/sdbb: device is busy
[2025-02-05 14:31:19]  [root@nfs_test2 ~]# [  759.537900][  T121] 
nfs4_close_done 3712 sleep done
[2025-02-05 14:31:27]  [  759.610608][  T121] call encode for task 
ffff88812718b080 10000 times
[2025-02-05 14:31:27]  [  759.671807][  T121] call encode for task 
ffff88812718b080 10000 times
[2025-02-05 14:31:27]  [  759.733124][  T121] call encode for task 
ffff88812718b080 10000 times
[2025-02-05 14:31:27]  [  759.794334][  T121] call encode for task 
ffff88812718b080 10000 times
[2025-02-05 14:31:27]  [  759.855741][  T121] call encode for task 
ffff88812718b080 10000 times
[2025-02-05 14:31:27]  [  759.917215][  T121] call encode for task 
ffff88812718b080 10000 times
[2025-02-05 14:31:27]  [  759.978567][  T121] call encode for task 
ffff88812718b080 10000 times
[2025-02-05 14:31:27]  [  760.039793][  T121] call encode for task 
ffff88812718b080 10000 times
[2025-02-05 14:31:27]  [  760.101126][  T121] call encode for task 
ffff88812718b080 10000 times
[2025-02-05 14:31:27]  [  760.162415][  T121] call encode for task 
ffff88812718b080 10000 times
[2025-02-05 14:31:27]  [  760.223674][  T121] call encode for task 
ffff88812718b080 10000 times
[2025-02-05 14:31:27]  [  760.284931][  T121] call encode for task 
ffff88812718b080 10000 times
[2025-02-05 14:31:28]  [  760.346262][  T121] call encode for task 
ffff88812718b080 10000 times
[2025-02-05 14:31:28]  [  760.407437][  T121] call encode for task 
ffff88812718b080 10000 times
[2025-02-05 14:31:28]  [  760.468764][  T121] call encode for task 
ffff88812718b080 10000 times
[2025-02-05 14:31:28]  [  760.530053][  T121] call encode for task 
ffff88812718b080 10000 times
[2025-02-05 14:31:28]  [  760.591361][  T121] call encode for task 
ffff88812718b080 10000 times
[2025-02-05 14:31:28]  [  760.652477][  T121] call encode for task 
ffff88812718b080 10000 times
[2025-02-05 14:31:28]  [  760.713855][  T121] call encode for task 
ffff88812718b080 10000 times
[2025-02-05 14:31:28]  [  760.775173][  T121] call encode for task 
ffff88812718b080 10000 times
[2025-02-05 14:31:28]  [  760.836712][  T121] call encode for task 
ffff88812718b080 10000 times
[2025-02-05 14:31:28]  [  760.897993][  T121] call encode for task 
ffff88812718b080 10000 times
[2025-02-05 14:31:28]  [  760.959219][  T121] call encode for task 
ffff88812718b080 10000 times
[2025-02-05 14:31:28]  [  761.020468][  T121] call encode for task 
ffff88812718b080 10000 times
[2025-02-05 14:31:28]  [  761.081690][  T121] call encode for task 
ffff88812718b080 10000 times
[2025-02-05 14:31:28]  [  761.142917][  T121] call encode for task 
ffff88812718b080 10000 times
[2025-02-05 14:31:28]  [  761.204055][  T121] call encode for task 
ffff88812718b080 10000 times
[2025-02-05 14:31:28]  [  761.265389][  T121] call encode for task 
ffff88812718b080 10000 times
[2025-02-05 14:31:29]  [  761.326620][  T121] call encode for task 
ffff88812718b080 10000 times
[2025-02-05 14:31:29]  [  761.387846][  T121] call encode for task 
ffff88812718b080 10000 times
[2025-02-05 14:31:29]  [  761.449004][  T121] call encode for task 
ffff88812718b080 10000 times
[2025-02-05 14:31:29]  [  761.510219][  T121] call encode for task 
ffff88812718b080 10000 times
[2025-02-05 14:31:29]  [  761.571452][  T121] call encode for task 
ffff88812718b080 10000 times
[2025-02-05 14:31:29]  [  761.632751][  T121] call encode for task 
ffff88812718b080 10000 times

2) verify whether the problem has been solved -- no rpc_task is looping
[2025-02-05 14:51:38]  Fedora 26 (Twenty Six)
[2025-02-05 14:51:38]  Kernel 6.14.0-rc1-00028-g5c8c229261f1-dirty on an 
x86_64 (ttyS0)
[2025-02-05 14:51:38]
[2025-02-05 14:51:38]  nfs_test2 login: root
[2025-02-05 15:01:15]  Password:
[2025-02-05 15:01:17]  Last login: Wed Feb  5 14:22:35 on ttyS0
[2025-02-05 15:01:20]  [root@nfs_test2 ~]# mkfs.ext4 -F /dev/sdb
[2025-02-05 15:01:25]  mke2fs 1.46.5 (30-Dec-2021)
[2025-02-05 15:01:25]  /dev/sdb contains a ext4 file system
[2025-02-05 15:01:25]      last mounted on /mnt/sdb on Wed Feb  5 
14:25:01 2025
[2025-02-05 15:01:25]  Discarding device blocks: 0/5242880               
done
[2025-02-05 15:01:25]  Creating filesystem with 5242880 4k blocks and 
1310720 inodes
[2025-02-05 15:01:25]  Filesystem UUID: ba1443f4-2501-4002-b860-95480332c82a
[2025-02-05 15:01:25]  Superblock backups stored on blocks:
[2025-02-05 15:01:25]      32768, 98304, 163840, 229376, 294912, 819200, 
884736, 1605632, 2654208,
[2025-02-05 15:01:25]      4096000
[2025-02-05 15:01:25]
[2025-02-05 15:01:25]  Allocating group tables:   0/160 done
[2025-02-05 15:01:25]  Writing inode tables:   0/160 done
[2025-02-05 15:01:25]  Creating journal (32768 blocks): done
[2025-02-05 15:01:25]  Writing superblocks and filesystem accounting 
information:   0/160       done
[2025-02-05 15:01:25]
[2025-02-05 15:01:25]  [root@nfs_test2 ~]# mount /dev/sdb /mnt/sdb
[2025-02-05 15:01:25]  [root@nfs_test2 ~]# echo 123 > 
/mnt/sdb/nfs_testfile1209
[2025-02-05 15:01:25]  [root@nfs_test2 ~]# echo "/mnt 
*(rw,no_root_squash,fsid=0)" > /etc/exports
[2025-02-05 15:01:25]  [root@nfs_test2 ~]# echo "/mnt/sdb 
*(rw,no_root_squash,fsid=1)" >> /etc/exports
[2025-02-05 15:01:25]  [root@nfs_test2 ~]# systemctl restart nfs-server
[2025-02-05 15:01:29]  [root@nfs_test2 ~]#
[2025-02-05 15:01:31]  [root@nfs_test2 ~]# mount -t nfs -o 
rw,soft,vers=4.1 127.0.0.1:/sdb /mnt/sdbb
[2025-02-05 15:01:37]  [root@nfs_test2 ~]# cat /mnt/sdbb/nfs_testfile1209 &
[2025-02-05 15:01:44]  [1] 2818
[2025-02-05 15:01:44]  [root@nfs_test2 ~]# 123
[2025-02-05 15:01:44]  [  668.110248][  T115] nfs4_close_done 3661 
inject err to tk_status
[2025-02-05 15:01:44]
[2025-02-05 15:01:44]  [root@nfs_test2 ~]# [  673.366194][  T115] 
nfs4_close_done 3710 sleep before restart task 
ffff88811d5d1080(tk_rpc_status 0)...
[2025-02-05 15:01:50]
[2025-02-05 15:01:50]  [root@nfs_test2 ~]#
[2025-02-05 15:01:50]  [root@nfs_test2 ~]# umount -f /mnt/sdbb
[2025-02-05 15:01:51]  umount.nfs4: /mnt/sdbb: device is busy
[2025-02-05 15:01:51]  [root@nfs_test2 ~]#
[2025-02-05 15:01:53]  [root@nfs_test2 ~]# [  683.606203][  T115] 
nfs4_close_done 3712 sleep done
[2025-02-05 15:02:02]
[2025-02-05 15:02:02]  [1]+  Done                    cat 
/mnt/sdbb/nfs_testfile1209
[2025-02-05 15:02:02]  [root@nfs_test2 ~]#
[2025-02-05 15:02:28]  [root@nfs_test2 ~]#
[2025-02-05 15:02:29]  [root@nfs_test2 ~]#
[2025-02-05 15:02:29]  [root@nfs_test2 ~]#

在 2025/2/2 4:00, trondmy@kernel.org 写道:
> From: Trond Myklebust <trond.myklebust@hammerspace.com>
>
> If rpc_signal_task() is called while a task is in an rpc_call_done()
> callback function, and the latter calls rpc_restart_call(), the task can
> end up looping due to the RPC_TASK_SIGNALLED flag being set without the
> tk_rpc_status being set.
> Removing the redundant mechanism for signalling the task fixes the
> looping behaviour.
>
> Reported-by: Li Lingfeng <lilingfeng3@huawei.com>
> Fixes: 39494194f93b ("SUNRPC: Fix races with rpc_killall_tasks()")
> Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
> ---
>   include/linux/sunrpc/sched.h  | 3 +--
>   include/trace/events/sunrpc.h | 3 +--
>   net/sunrpc/sched.c            | 2 --
>   3 files changed, 2 insertions(+), 6 deletions(-)
>
> diff --git a/include/linux/sunrpc/sched.h b/include/linux/sunrpc/sched.h
> index fec1e8a1570c..eac57914dcf3 100644
> --- a/include/linux/sunrpc/sched.h
> +++ b/include/linux/sunrpc/sched.h
> @@ -158,7 +158,6 @@ enum {
>   	RPC_TASK_NEED_XMIT,
>   	RPC_TASK_NEED_RECV,
>   	RPC_TASK_MSG_PIN_WAIT,
> -	RPC_TASK_SIGNALLED,
>   };
>   
>   #define rpc_test_and_set_running(t) \
> @@ -171,7 +170,7 @@ enum {
>   
>   #define RPC_IS_ACTIVATED(t)	test_bit(RPC_TASK_ACTIVE, &(t)->tk_runstate)
>   
> -#define RPC_SIGNALLED(t)	test_bit(RPC_TASK_SIGNALLED, &(t)->tk_runstate)
> +#define RPC_SIGNALLED(t)	(READ_ONCE(task->tk_rpc_status) == -ERESTARTSYS)
>   
>   /*
>    * Task priorities.
> diff --git a/include/trace/events/sunrpc.h b/include/trace/events/sunrpc.h
> index b13dc275ef4a..851841336ee6 100644
> --- a/include/trace/events/sunrpc.h
> +++ b/include/trace/events/sunrpc.h
> @@ -360,8 +360,7 @@ TRACE_EVENT(rpc_request,
>   		{ (1UL << RPC_TASK_ACTIVE), "ACTIVE" },			\
>   		{ (1UL << RPC_TASK_NEED_XMIT), "NEED_XMIT" },		\
>   		{ (1UL << RPC_TASK_NEED_RECV), "NEED_RECV" },		\
> -		{ (1UL << RPC_TASK_MSG_PIN_WAIT), "MSG_PIN_WAIT" },	\
> -		{ (1UL << RPC_TASK_SIGNALLED), "SIGNALLED" })
> +		{ (1UL << RPC_TASK_MSG_PIN_WAIT), "MSG_PIN_WAIT" })
>   
>   DECLARE_EVENT_CLASS(rpc_task_running,
>   
> diff --git a/net/sunrpc/sched.c b/net/sunrpc/sched.c
> index cef623ea1506..9b45fbdc90ca 100644
> --- a/net/sunrpc/sched.c
> +++ b/net/sunrpc/sched.c
> @@ -864,8 +864,6 @@ void rpc_signal_task(struct rpc_task *task)
>   	if (!rpc_task_set_rpc_status(task, -ERESTARTSYS))
>   		return;
>   	trace_rpc_task_signalled(task, task->tk_action);
> -	set_bit(RPC_TASK_SIGNALLED, &task->tk_runstate);
> -	smp_mb__after_atomic();
>   	queue = READ_ONCE(task->tk_waitqueue);
>   	if (queue)
>   		rpc_wake_up_queued_task(queue, task);


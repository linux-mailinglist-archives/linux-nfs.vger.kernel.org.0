Return-Path: <linux-nfs+bounces-9874-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C328A2853A
	for <lists+linux-nfs@lfdr.de>; Wed,  5 Feb 2025 09:03:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5481B161C7E
	for <lists+linux-nfs@lfdr.de>; Wed,  5 Feb 2025 08:03:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB9F5229B03;
	Wed,  5 Feb 2025 08:03:30 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 414E9229B0E
	for <linux-nfs@vger.kernel.org>; Wed,  5 Feb 2025 08:03:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738742610; cv=none; b=M9EmdcD0p9v6kbW5Ika4Dnk/QmSpDg1Ls/v2vgL7oKWnKrvh8/x95uyxVZV2n+2yejB32tc8CJnxOIuMDQjNpzAKjLLKhGvf4rUpiFq3TsoyKNhpM7lBOUgQPZbfaEuuxXOCmp7u+1bn0RwiIYnj+iZ2r3S7/JOTVspGTbpeWPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738742610; c=relaxed/simple;
	bh=dtsRkB5WZ2yh55Ciz58XyfuHJSl2pKbJL6CWfTM56Vk=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:CC:From:
	 In-Reply-To:Content-Type; b=uiB4NXWAJJozZ5q+Rx2TyEd1uiqZdDvWn1otWUTjOXmTvuDI6j/tGfwpmjg7AUbTO5gVv4fInbaquUmqqnOtv0gKRV89n8pqF0SUZNzux2jmVhsj4WK6/6eVUSTPSTymcOGdcOQV0OJxD+XCTdF/8jvRUgzZm9RZoHCAUjDRE14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.48])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4Ynt1y5zfhzgcVC;
	Wed,  5 Feb 2025 16:00:06 +0800 (CST)
Received: from kwepemg500017.china.huawei.com (unknown [7.202.181.81])
	by mail.maildlp.com (Postfix) with ESMTPS id 40F56180064;
	Wed,  5 Feb 2025 16:03:24 +0800 (CST)
Received: from [10.174.179.155] (10.174.179.155) by
 kwepemg500017.china.huawei.com (7.202.181.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 5 Feb 2025 16:03:23 +0800
Message-ID: <df85d3a4-f665-478d-b744-9ec66950ee2d@huawei.com>
Date: Wed, 5 Feb 2025 16:03:22 +0800
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: =?UTF-8?B?TW96aWxsYSBUaHVuZGVyYmlyZCDmtYvor5XniYg=?=
Subject: Re: [PATCH] NFSv4: Fix a deadlock when recovering state on a
 sillyrenamed file
To: <trondmy@kernel.org>, <linux-nfs@vger.kernel.org>
References: <859589e08b72ae716e0ea2b54de43abc20782b5b.1738439884.git.trond.myklebust@hammerspace.com>
CC: yangerkun <yangerkun@huawei.com>, "zhangyi (F)" <yi.zhang@huawei.com>,
	"yukuai (C)" <yukuai3@huawei.com>, Hou Tao <houtao1@huawei.com>
From: Li Lingfeng <lilingfeng3@huawei.com>
In-Reply-To: <859589e08b72ae716e0ea2b54de43abc20782b5b.1738439884.git.trond.myklebust@hammerspace.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemg500017.china.huawei.com (7.202.181.81)

Hi
Thanks for your patch. I've tested it and confirmed it solves the problem
we found.
It might be helpful to add the link of the original patch, as that could
better illustrate the issue.
(Link: 
https://lore.kernel.org/all/20241213035908.1789132-1-lilingfeng3@huawei.com/)
This is how I reproduce the problem and verify whether the problem is
solved.

diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
index df9669d4ded7..c19b1b66708c 100644
--- a/fs/nfs/nfs4proc.c
+++ b/fs/nfs/nfs4proc.c
@@ -2326,6 +2326,9 @@ static int nfs4_open_reclaim(struct 
nfs4_state_owner *sp, struct nfs4_state *sta
         clear_bit(NFS_DELEGATED_STATE, &state->flags);
         nfs_state_clear_open_state_flags(state);
         ret = nfs4_do_open_reclaim(ctx, state);
+       printk("first will sleep 20s\n");
+       msleep(20 * 1000);
+       printk("first sleep 20s ok\n");
         put_nfs_open_context(ctx);
         return ret;
  }
diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
index e67420729ecd..679e1201734f 100644
--- a/fs/nfsd/nfs4xdr.c
+++ b/fs/nfsd/nfs4xdr.c
@@ -4312,6 +4312,9 @@ nfsd4_encode_open_delegation4(struct xdr_stream 
*xdr, struct nfsd4_open *open)
         /* delegation_type */
         if (xdr_stream_encode_u32(xdr, open->op_delegate_type) != XDR_UNIT)
                 return nfserr_resource;
+       printk("%s %d open->op_delegate_type %d\n", __func__, __LINE__, 
open->op_delegate_type);
+       printk("%s %d force to write\n", __func__, __LINE__);
+       open->op_delegate_type = OPEN_DELEGATE_WRITE;
         switch (open->op_delegate_type) {
         case OPEN_DELEGATE_NONE:
                 status = nfs_ok;

[root@nfs_test2 test]# cat unlink_test.c
#include<stdio.h>
#include<sys/types.h>
#include<sys/stat.h>
#include<fcntl.h>
#include<unistd.h>
int main()
{
     int fd;

     if(unlink("/mnt/sdbb/nfs_testfile1209")<0){
         printf("unlink error !\n");
     }
     printf("unlink done\n");
     return 0;
}
[root@nfs_test2 test]#

1) reproduce the problem -- state manager is blocked
[2025-02-05 15:26:35]  Fedora 26 (Twenty Six)
[2025-02-05 15:26:35]  Kernel 6.14.0-rc1-00028-g5c8c229261f1-dirty on an 
x86_64 (ttyS0)
[2025-02-05 15:26:35]
[2025-02-05 15:26:35]  nfs_test2 login: root
[2025-02-05 15:26:59]  Password:
[2025-02-05 15:27:01]  Last login: Wed Feb  5 14:55:23 on ttyS0
[2025-02-05 15:27:04]  [root@nfs_test2 ~]# mkfs.ext4 -F /dev/sdb
[2025-02-05 15:27:30]  mke2fs 1.46.5 (30-Dec-2021)
[2025-02-05 15:27:30]  /dev/sdb contains a ext4 file system
[2025-02-05 15:27:30]      last mounted on /mnt/sdb on Wed Feb  5 
14:55:30 2025
[2025-02-05 15:27:30]  Discarding device blocks: 0/5242880               
done
[2025-02-05 15:27:30]  Creating filesystem with 5242880 4k blocks and 
1310720 inodes
[2025-02-05 15:27:30]  Filesystem UUID: 4cf675ad-dc35-41e4-beb4-a8cd3c996d09
[2025-02-05 15:27:30]  Superblock backups stored on blocks:
[2025-02-05 15:27:30]      32768, 98304, 163840, 229376, 294912, 819200, 
884736, 1605632, 2654208,
[2025-02-05 15:27:30]      4096000
[2025-02-05 15:27:30]
[2025-02-05 15:27:30]  Allocating group tables:   0/160 done
[2025-02-05 15:27:30]  Writing inode tables:   0/160 done
[2025-02-05 15:27:30]  Creating journal (32768 blocks): done
[2025-02-05 15:27:30]  Writing superblocks and filesystem accounting 
information:   0/160       done
[2025-02-05 15:27:30]
[2025-02-05 15:27:30]  [root@nfs_test2 ~]# mount /dev/sdb /mnt/sdb
[2025-02-05 15:27:30]  [root@nfs_test2 ~]# touch /mnt/sdb/nfs_testfile1209
[2025-02-05 15:27:30]  [root@nfs_test2 ~]# echo "/mnt 
*(rw,no_root_squash,fsid=0)" > /etc/exports
[2025-02-05 15:27:30]  [root@nfs_test2 ~]# echo "/mnt/sdb 
*(rw,no_root_squash,fsid=1)" >> /etc/exports
[2025-02-05 15:27:30]  [root@nfs_test2 ~]# systemctl restart nfs-server
[2025-02-05 15:27:35]  [root@nfs_test2 ~]# mount -t nfs -o rw,vers=4.1 
127.0.0.1:/sdb /mnt/sdbb
[2025-02-05 15:27:38]  [root@nfs_test2 ~]# exec 4<> 
/mnt/sdbb/nfs_testfile1209
[2025-02-05 15:27:43]  [  130.524039][ T2885] 
nfsd4_encode_open_delegation4 4315 open->op_delegate_type 0
[2025-02-05 15:27:43]  [  130.525002][ T2885] 
nfsd4_encode_open_delegation4 4316 force to write
[2025-02-05 15:27:43]  -bash: /mnt/sdbb/nfs_testfile1209: Remote I/O error
[2025-02-05 15:27:43]  [root@nfs_test2 ~]#
[2025-02-05 15:28:46]  [root@nfs_test2 ~]# exec 4<> 
/mnt/sdbb/nfs_testfile1209
[2025-02-05 15:28:46]  [  193.806267][ T2885] 
nfsd4_encode_open_delegation4 4315 open->op_delegate_type 2
[2025-02-05 15:28:46]  [  193.807239][ T2885] 
nfsd4_encode_open_delegation4 4316 force to write
[2025-02-05 15:28:50]
[2025-02-05 15:28:52]  [root@nfs_test2 ~]#
[2025-02-05 15:28:52]  [root@nfs_test2 ~]# cd test/
[2025-02-05 15:29:02]  [root@nfs_test2 test]# ./unlink_test
[2025-02-05 15:29:20]  unlink done
[2025-02-05 15:29:20]  [root@nfs_test2 test]# systemctl restart nfs-server
[2025-02-05 15:29:25]  [root@nfs_test2 test]#
[2025-02-05 15:29:28]  [root@nfs_test2 test]# [  287.897206][ T2961] 
nfsd4_encode_open_delegation4 4315 open->op_delegate_type 2
[2025-02-05 15:30:20]  [  287.898198][ T2961] 
nfsd4_encode_open_delegation4 4316 force to write
[2025-02-05 15:30:20]  [  287.899477][ T2976] first will sleep 20s
[2025-02-05 15:30:22]
[2025-02-05 15:30:22]  [root@nfs_test2 test]# exec 4<&-
[2025-02-05 15:30:23]  [root@nfs_test2 test]# [  308.308973][ T2976] 
first sleep 20s ok
[2025-02-05 15:30:43]
[2025-02-05 15:30:43]  [root@nfs_test2 test]#  ps aux | grep D
[2025-02-05 15:30:52]  USER       PID %CPU %MEM    VSZ   RSS TTY      
STAT START   TIME COMMAND
[2025-02-05 15:30:52]  root       489  0.0  0.0  97940  7352 ?        
Ss   15:20   0:00 /usr/sbin/sshd -D
[2025-02-05 15:30:52]  root      2966  0.1  0.0 270316  3384 ?        
Ssl  15:23   0:00 /usr/sbin/gssproxy -D
[2025-02-05 15:30:52]  root      2976  0.0  0.0      0     0 ?        
D    15:24   0:00 [127.0.0.1-manag]
[2025-02-05 15:30:52]  root      2981  0.0  0.0 119468  2356 ttyS0    
S+   15:24   0:00 grep --color=auto D
[2025-02-05 15:30:52]  [root@nfs_test2 test]# cat /proc/2976/stack
[2025-02-05 15:30:58]  [<0>] rpc_wait_bit_killable+0xd/0x90
[2025-02-05 15:30:58]  [<0>] _nfs4_proc_delegreturn+0x4f6/0x6b0
[2025-02-05 15:30:58]  [<0>] nfs4_proc_delegreturn+0x136/0x280
[2025-02-05 15:30:58]  [<0>] nfs_do_return_delegation+0xaa/0x100
[2025-02-05 15:30:58]  [<0>] nfs_end_delegation_return+0x11e/0x1e0
[2025-02-05 15:30:58]  [<0>] nfs_complete_unlink+0xb4/0x150
[2025-02-05 15:30:58]  [<0>] nfs_dentry_iput+0x37/0xa0
[2025-02-05 15:30:58]  [<0>] __dentry_kill+0xc3/0x280
[2025-02-05 15:30:58]  [<0>] dput.part.0+0x26c/0x4e0
[2025-02-05 15:30:58]  [<0>] __put_nfs_open_context+0x1c8/0x250
[2025-02-05 15:30:58]  [<0>] nfs4_open_reclaim+0x73/0xc0
[2025-02-05 15:30:58]  [<0>] __nfs4_reclaim_open_state+0x32/0x150
[2025-02-05 15:30:58]  [<0>] nfs4_reclaim_open_state+0x154/0x3a0
[2025-02-05 15:30:58]  [<0>] nfs4_do_reclaim+0x217/0x4a0
[2025-02-05 15:30:58]  [<0>] nfs4_state_manager+0x5ff/0xa80
[2025-02-05 15:30:58]  [<0>] nfs4_run_state_manager+0x164/0x320
[2025-02-05 15:30:58]  [<0>] kthread+0x20a/0x3d0
[2025-02-05 15:30:58]  [<0>] ret_from_fork+0x2f/0x50
[2025-02-05 15:30:58]  [<0>] ret_from_fork_asm+0x1a/0x30
[2025-02-05 15:30:58]  [root@nfs_test2 test]#

2) verify whether the problem has been solved -- state manager is not 
blocked
[2025-02-05 15:52:15]  Fedora 26 (Twenty Six)
[2025-02-05 15:52:15]  Kernel 6.14.0-rc1-00028-g5c8c229261f1-dirty on an 
x86_64 (ttyS0)
[2025-02-05 15:52:15]
[2025-02-05 15:52:15]  nfs_test2 login: root
[2025-02-05 15:52:48]  Password:
[2025-02-05 15:52:50]  Last login: Wed Feb  5 15:21:14 from 192.168.240.1
[2025-02-05 15:52:53]  [root@nfs_test2 ~]# mkfs.ext4 -F /dev/sdb
[2025-02-05 15:55:16]  mke2fs 1.46.5 (30-Dec-2021)
[2025-02-05 15:55:16]  /dev/sdb contains a ext4 file system
[2025-02-05 15:55:16]      last mounted on /mnt/sdb on Wed Feb  5 
15:21:36 2025
[2025-02-05 15:55:16]  Discarding device blocks: 0/5242880               
done
[2025-02-05 15:55:16]  Creating filesystem with 5242880 4k blocks and 
1310720 inodes
[2025-02-05 15:55:16]  Filesystem UUID: 018cc6a0-605e-4741-881b-947f381f5e6a
[2025-02-05 15:55:16]  Superblock backups stored on blocks:
[2025-02-05 15:55:16]      32768, 98304, 163840, 229376, 294912, 819200, 
884736, 1605632, 2654208,
[2025-02-05 15:55:16]      4096000
[2025-02-05 15:55:16]
[2025-02-05 15:55:16]  Allocating group tables:   0/160 done
[2025-02-05 15:55:16]  Writing inode tables:   0/160 done
[2025-02-05 15:55:16]  Creating journal (32768 blocks): done
[2025-02-05 15:55:16]  Writing superblocks and filesystem accounting 
information:   0/160       done
[2025-02-05 15:55:16]
[2025-02-05 15:55:16]  [root@nfs_test2 ~]# mount /dev/sdb /mnt/sdb
[2025-02-05 15:55:17]  [root@nfs_test2 ~]# touch /mnt/sdb/nfs_testfile1209
[2025-02-05 15:55:17]  [root@nfs_test2 ~]# echo "/mnt 
*(rw,no_root_squash,fsid=0)" > /etc/exports
[2025-02-05 15:55:17]  [root@nfs_test2 ~]# echo "/mnt/sdb 
*(rw,no_root_squash,fsid=1)" >> /etc/exports
[2025-02-05 15:55:17]  [root@nfs_test2 ~]# systemctl restart nfs-server
[2025-02-05 15:55:20]  [root@nfs_test2 ~]# mount -t nfs -o rw,vers=4.1 
127.0.0.1:/sdb /mnt/sdbb
[2025-02-05 15:56:40]  [root@nfs_test2 ~]# cat /mnt/sdbb/nfs_testfile1209
[2025-02-05 15:56:46]  ls /mnt/sdbbexec 4<> /mnt/sdbb/nfs_testfile1209
[2025-02-05 15:56:48]  [  335.367080][ T2772] 
nfsd4_encode_open_delegation4 4315 open->op_delegate_type 2
[2025-02-05 15:56:48]  [  335.368033][ T2772] 
nfsd4_encode_open_delegation4 4316 force to write
[2025-02-05 15:56:48]  [root@nfs_test2 ~]# cd test/
[2025-02-05 15:57:14]  [root@nfs_test2 test]# ./unlink_test
[2025-02-05 15:57:15]  unlink done
[2025-02-05 15:57:15]  [root@nfs_test2 test]# systemctl restart nfs-server
[2025-02-05 15:57:23]  [root@nfs_test2 test]#
[2025-02-05 15:57:25]  [root@nfs_test2 test]# [  423.194508][ T2856] 
nfsd4_encode_open_delegation4 4315 open->op_delegate_type 2
[2025-02-05 15:58:15]  [  423.195470][ T2856] 
nfsd4_encode_open_delegation4 4316 force to write
[2025-02-05 15:58:15]  [  423.196712][ T2872] first will sleep 20s
[2025-02-05 15:58:17]
[2025-02-05 15:58:17]  [root@nfs_test2 test]# exec 4<&-
[2025-02-05 15:58:18]  [root@nfs_test2 test]# [  443.570528][ T2872] 
first sleep 20s ok
[2025-02-05 15:58:39]
[2025-02-05 15:58:39]  [root@nfs_test2 test]# ps aux | grep D
[2025-02-05 15:58:43]  USER       PID %CPU %MEM    VSZ   RSS TTY      
STAT START   TIME COMMAND
[2025-02-05 15:58:43]  root       483  0.0  0.0  97940  7336 ?        
Ss   15:46   0:00 /usr/sbin/sshd -D
[2025-02-05 15:58:43]  root      2861  0.1  0.0 270316  3492 ?        
Ssl  15:51   0:00 /usr/sbin/gssproxy -D
[2025-02-05 15:58:43]  root      2879  0.0  0.0 119468  2356 ttyS0    
S+   15:52   0:00 grep --color=auto D
[2025-02-05 15:58:43]  [root@nfs_test2 test]#

在 2025/2/2 4:00, trondmy@kernel.org 写道:
> From: Trond Myklebust <trond.myklebust@hammerspace.com>
>
> If the file is sillyrenamed, and slated for delete on close, it is
> possible for a server reboot to triggeer an open reclaim, with can again
> race with the application call to close(). When that happens, the call
> to put_nfs_open_context() can trigger a synchronous delegreturn call
> which deadlocks because it is not marked as privileged.
>
> Instead, ensure that the call to nfs4_inode_return_delegation_on_close()
> catches the delegreturn, and schedules it asynchronously.
>
> Reported-by: Li Lingfeng <lilingfeng3@huawei.com>
> Fixes: adb4b42d19ae ("Return the delegation when deleting sillyrenamed files")
> Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
> ---
>   fs/nfs/delegation.c | 37 +++++++++++++++++++++++++++++++++++++
>   fs/nfs/delegation.h |  1 +
>   fs/nfs/nfs4proc.c   |  3 +++
>   3 files changed, 41 insertions(+)
>
> diff --git a/fs/nfs/delegation.c b/fs/nfs/delegation.c
> index 035ba52742a5..4db912f56230 100644
> --- a/fs/nfs/delegation.c
> +++ b/fs/nfs/delegation.c
> @@ -780,6 +780,43 @@ int nfs4_inode_return_delegation(struct inode *inode)
>   	return 0;
>   }
>   
> +/**
> + * nfs4_inode_set_return_delegation_on_close - asynchronously return a delegation
> + * @inode: inode to process
> + *
> + * This routine is called to request that the delegation be returned as soon
> + * as the file is closed. If the file is already closed, the delegation is
> + * immediately returned.
> + */
> +void nfs4_inode_set_return_delegation_on_close(struct inode *inode)
> +{
> +	struct nfs_delegation *delegation;
> +	struct nfs_delegation *ret = NULL;
> +
> +	if (!inode)
> +		return;
> +	rcu_read_lock();
> +	delegation = nfs4_get_valid_delegation(inode);
> +	if (!delegation)
> +		goto out;
> +	spin_lock(&delegation->lock);
> +	if (!delegation->inode)
> +		goto out_unlock;
> +	if (list_empty(&NFS_I(inode)->open_files) &&
> +	    !test_and_set_bit(NFS_DELEGATION_RETURNING, &delegation->flags)) {
> +		/* Refcount matched in nfs_end_delegation_return() */
> +		ret = nfs_get_delegation(delegation);
> +	} else
> +		set_bit(NFS_DELEGATION_RETURN_IF_CLOSED, &delegation->flags);
> +out_unlock:
> +	spin_unlock(&delegation->lock);
> +	if (ret)
> +		nfs_clear_verifier_delegated(inode);
> +out:
> +	rcu_read_unlock();
> +	nfs_end_delegation_return(inode, ret, 0);
> +}
> +
>   /**
>    * nfs4_inode_return_delegation_on_close - asynchronously return a delegation
>    * @inode: inode to process
> diff --git a/fs/nfs/delegation.h b/fs/nfs/delegation.h
> index 71524d34ed20..8ff5ab9c5c25 100644
> --- a/fs/nfs/delegation.h
> +++ b/fs/nfs/delegation.h
> @@ -49,6 +49,7 @@ void nfs_inode_reclaim_delegation(struct inode *inode, const struct cred *cred,
>   				  unsigned long pagemod_limit, u32 deleg_type);
>   int nfs4_inode_return_delegation(struct inode *inode);
>   void nfs4_inode_return_delegation_on_close(struct inode *inode);
> +void nfs4_inode_set_return_delegation_on_close(struct inode *inode);
>   int nfs_async_inode_return_delegation(struct inode *inode, const nfs4_stateid *stateid);
>   void nfs_inode_evict_delegation(struct inode *inode);
>   
> diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
> index df9669d4ded7..c25ecdb76d30 100644
> --- a/fs/nfs/nfs4proc.c
> +++ b/fs/nfs/nfs4proc.c
> @@ -3906,8 +3906,11 @@ nfs4_atomic_open(struct inode *dir, struct nfs_open_context *ctx,
>   
>   static void nfs4_close_context(struct nfs_open_context *ctx, int is_sync)
>   {
> +	struct dentry *dentry = ctx->dentry;
>   	if (ctx->state == NULL)
>   		return;
> +	if (dentry->d_flags & DCACHE_NFSFS_RENAMED)
> +		nfs4_inode_set_return_delegation_on_close(d_inode(dentry));
>   	if (is_sync)
>   		nfs4_close_sync(ctx->state, _nfs4_ctx_to_openmode(ctx));
>   	else


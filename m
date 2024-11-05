Return-Path: <linux-nfs+bounces-7667-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DE3C9BCB42
	for <lists+linux-nfs@lfdr.de>; Tue,  5 Nov 2024 12:06:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 936331F22F44
	for <lists+linux-nfs@lfdr.de>; Tue,  5 Nov 2024 11:06:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A68D1D2F64;
	Tue,  5 Nov 2024 11:06:51 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7CE21C07D9
	for <linux-nfs@vger.kernel.org>; Tue,  5 Nov 2024 11:06:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730804811; cv=none; b=rIt9NTkfNCUCqIB1BrFOG1GJqCkJVTfAK1SeSJR4TSvOPaIxPtu69i7oz1z0ihZGK1Z1P9FDQQp8W8ID9Q/eeRyW/Bq5g1QdCxgURXmVDmoydovzsU4TEZD0PSCrCNLCS3O2juszJTahc0/DpjUDrqT2tkU73/aURWJ7Uh1+XLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730804811; c=relaxed/simple;
	bh=mHDK2dxECmPTHHF0R6F9A0vcZsULViLQWjtJCZT81bc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=JlQnzkR5FNvXgyI2/2ntZ3262VupjUdoMkSfwuw/1Mm1uzhBPBy0yzy3j4zZeLx0Vn/sJ9NR8I+LYy3X5wSOYeHek5H4dPXzX0yoCPUnkXWoti4v2tiDKSj1Yv7nbMNqH3UC/Rt1jxpVPPdJEXpOg0/yBbffQJ+T/iirT/VwJaw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4XjQWV2gc7z4f3mWM
	for <linux-nfs@vger.kernel.org>; Tue,  5 Nov 2024 19:06:30 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 36FC01A0359
	for <linux-nfs@vger.kernel.org>; Tue,  5 Nov 2024 19:06:43 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP4 (Coremail) with SMTP id gCh0CgCXc4c9_Cln3_WrAw--.64498S4;
	Tue, 05 Nov 2024 19:06:42 +0800 (CST)
From: Yang Erkun <yangerkun@huaweicloud.com>
To: chuck.lever@oracle.com,
	jlayton@kernel.org,
	neilb@suse.de,
	okorniev@redhat.com,
	Dai.Ngo@oracle.com,
	tom@talpey.com,
	trondmy@kernel.org
Cc: linux-nfs@vger.kernel.org,
	yangerkun@huawei.com,
	yangerkun@huaweicloud.com,
	yi.zhang@huawei.com
Subject: [PATCH v3] nfsd: fix nfs4_openowner leak when concurrent nfsd4_open occur
Date: Tue,  5 Nov 2024 19:03:14 +0800
Message-Id: <20241105110314.2122967-1-yangerkun@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgCXc4c9_Cln3_WrAw--.64498S4
X-Coremail-Antispam: 1UD129KBjvJXoWxtr1DWF1kGw1rKr45Ww18AFb_yoW7ur1fpF
	Z3JFyfJr1rXa4qqrW7Ca10kFyUKwsYvry7Xr9akrWSvr42vrn5XF1jg34SvrWUG395Z3yU
	XFn8ta1UWw4rAFUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9014x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4j
	6r4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
	Cq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
	I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r
	4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628v
	n2kIc2xKxwCY1x0262kKe7AKxVWUtVW8ZwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7x
	kEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E
	67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCw
	CI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1x
	MIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIda
	VFxhVjvjDU0xZFpf9x0JUd-B_UUUUU=
X-CM-SenderInfo: 51dqwvhunx0q5kxd4v5lfo033gof0z/

From: Yang Erkun <yangerkun@huawei.com>

The action force umount(umount -f) will attempt to kill all rpc_task even
umount operation may ultimately fail if some files remain open.
Consequently, if an action attempts to open a file, it can potentially
send two rpc_task to nfs server.

                   NFS CLIENT
thread1                             thread2
open("file")
...
nfs4_do_open
 _nfs4_do_open
  _nfs4_open_and_get_state
   _nfs4_proc_open
    nfs4_run_open_task
     /* rpc_task1 */
     rpc_run_task
     rpc_wait_for_completion_task

                                    umount -f
                                    nfs_umount_begin
                                     rpc_killall_tasks
                                      rpc_signal_task
     rpc_task1 been wakeup
     and return -512
 _nfs4_do_open // while loop
    ...
    nfs4_run_open_task
     /* rpc_task2 */
     rpc_run_task
     rpc_wait_for_completion_task

While processing an open request, nfsd will first attempt to find or
allocate an nfs4_openowner. If it finds an nfs4_openowner that is not
marked as NFS4_OO_CONFIRMED, this nfs4_openowner will released. Since
two rpc_task can attempt to open the same file simultaneously from the
client to server, and because two instances of nfsd can run
concurrently, this situation can lead to lots of memory leak.
Additionally, when we echo 0 to /proc/fs/nfsd/threads, warning will be
triggered.

                    NFS SERVER
nfsd1                  nfsd2       echo 0 > /proc/fs/nfsd/threads

nfsd4_open
 nfsd4_process_open1
  find_or_alloc_open_stateowner
   // alloc oo1, stateid1
                       nfsd4_open
                        nfsd4_process_open1
                        find_or_alloc_open_stateowner
                        // find oo1, without NFS4_OO_CONFIRMED
                         release_openowner
                          unhash_openowner_locked
                          list_del_init(&oo->oo_perclient)
                          // cannot find this oo
                          // from client, LEAK!!!
                         alloc_stateowner // alloc oo2

 nfsd4_process_open2
  init_open_stateid
  // associate oo1
  // with stateid1, stateid1 LEAK!!!
  nfs4_get_vfs_file
  // alloc nfsd_file1 and nfsd_file_mark1
  // all LEAK!!!

                         nfsd4_process_open2
                         ...

                                    write_threads
                                     ...
                                     nfsd_destroy_serv
                                      nfsd_shutdown_net
                                       nfs4_state_shutdown_net
                                        nfs4_state_destroy_net
                                         destroy_client
                                          __destroy_client
                                          // won't find oo1!!!
                                     nfsd_shutdown_generic
                                      nfsd_file_cache_shutdown
                                       kmem_cache_destroy
                                       for nfsd_file_slab
                                       and nfsd_file_mark_slab
                                       // bark since nfsd_file1
                                       // and nfsd_file_mark1
                                       // still alive

=======================================================================
BUG nfsd_file (Not tainted): Objects remaining in nfsd_file on
__kmem_cache_shutdown()
-----------------------------------------------------------------------

Slab 0xffd4000004438a80 objects=34 used=1 fp=0xff11000110e2ad28
flags=0x17ffffc0000240(workingset|head|node=0|zone=2|lastcpupid=0x1fffff)
CPU: 4 UID: 0 PID: 757 Comm: sh Not tainted 6.12.0-rc6+ #19
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS
1.16.1-2.fc37 04/01/2014
Call Trace:
 <TASK>
 dump_stack_lvl+0x53/0x70
 slab_err+0xb0/0xf0
 __kmem_cache_shutdown+0x15c/0x310
 kmem_cache_destroy+0x66/0x160
 nfsd_file_cache_shutdown+0xac/0x210 [nfsd]
 nfsd_destroy_serv+0x251/0x2a0 [nfsd]
 nfsd_svc+0x125/0x1e0 [nfsd]
 write_threads+0x16a/0x2a0 [nfsd]
 nfsctl_transaction_write+0x74/0xa0 [nfsd]
 vfs_write+0x1ae/0x6d0
 ksys_write+0xc1/0x160
 do_syscall_64+0x5f/0x170
 entry_SYSCALL_64_after_hwframe+0x76/0x7e

Disabling lock debugging due to kernel taint
Object 0xff11000110e2ac38 @offset=3128
Allocated in nfsd_file_do_acquire+0x20f/0xa30 [nfsd] age=1635 cpu=3
pid=800
 nfsd_file_do_acquire+0x20f/0xa30 [nfsd]
 nfsd_file_acquire_opened+0x5f/0x90 [nfsd]
 nfs4_get_vfs_file+0x4c9/0x570 [nfsd]
 nfsd4_process_open2+0x713/0x1070 [nfsd]
 nfsd4_open+0x74b/0x8b0 [nfsd]
 nfsd4_proc_compound+0x70b/0xc20 [nfsd]
 nfsd_dispatch+0x1b4/0x3a0 [nfsd]
 svc_process_common+0x5b8/0xc50 [sunrpc]
 svc_process+0x2ab/0x3b0 [sunrpc]
 svc_handle_xprt+0x681/0xa20 [sunrpc]
 nfsd+0x183/0x220 [nfsd]
 kthread+0x199/0x1e0
 ret_from_fork+0x31/0x60
 ret_from_fork_asm+0x1a/0x30

Add nfs4_openowner_unhashed to help found unhashed nfs4_openowner, and
break nfsd4_open process to fix this problem.

Cc: stable@vger.kernel.org # 2.6
Reviewed-by: Jeff Layton <jlayton@kernel.org>
Signed-off-by: Yang Erkun <yangerkun@huawei.com>
---
 fs/nfsd/nfs4state.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

v2->v3:
1. add reviewed-by
2. add lockdep_assert_held in nfs4_openowner_unhashed

diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index 9ddb91d088ae..37888562b436 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -1660,6 +1660,14 @@ static void release_open_stateid(struct nfs4_ol_stateid *stp)
 	free_ol_stateid_reaplist(&reaplist);
 }
 
+static bool nfs4_openowner_unhashed(struct nfs4_openowner *oo)
+{
+	lockdep_assert_held(&oo->oo_owner.so_client->cl_lock);
+
+	return list_empty(&oo->oo_owner.so_strhash) &&
+		list_empty(&oo->oo_perclient);
+}
+
 static void unhash_openowner_locked(struct nfs4_openowner *oo)
 {
 	struct nfs4_client *clp = oo->oo_owner.so_client;
@@ -4979,6 +4987,12 @@ init_open_stateid(struct nfs4_file *fp, struct nfsd4_open *open)
 	spin_lock(&oo->oo_owner.so_client->cl_lock);
 	spin_lock(&fp->fi_lock);
 
+	if (nfs4_openowner_unhashed(oo)) {
+		mutex_unlock(&stp->st_mutex);
+		stp = NULL;
+		goto out_unlock;
+	}
+
 	retstp = nfsd4_find_existing_open(fp, open);
 	if (retstp)
 		goto out_unlock;
@@ -6131,6 +6145,11 @@ nfsd4_process_open2(struct svc_rqst *rqstp, struct svc_fh *current_fh, struct nf
 
 	if (!stp) {
 		stp = init_open_stateid(fp, open);
+		if (!stp) {
+			status = nfserr_jukebox;
+			goto out;
+		}
+
 		if (!open->op_stp)
 			new_stp = true;
 	}
-- 
2.39.2



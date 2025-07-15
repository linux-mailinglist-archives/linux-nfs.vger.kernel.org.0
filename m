Return-Path: <linux-nfs+bounces-13066-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 09FBAB04EA3
	for <lists+linux-nfs@lfdr.de>; Tue, 15 Jul 2025 05:21:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4C91B4A4478
	for <lists+linux-nfs@lfdr.de>; Tue, 15 Jul 2025 03:21:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E9C72D12F6;
	Tue, 15 Jul 2025 03:21:05 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30B092D12F7;
	Tue, 15 Jul 2025 03:21:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752549665; cv=none; b=VNTbRMKjGh+gzW+rPTomwm/3XiTEbeG+dPcVcFT2LqM8XVjcRMJNCBKrrvbwppV9qsa1Gs8XiiaziQMWlgl4RqBt9uz34xNqT5PAMY4LiZBL5oRAZFztrjc5n+4UoaLhIh9dkaTHRLz0HG18r1M+8ir8uncQxJEkSQQQPF9LApk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752549665; c=relaxed/simple;
	bh=K16IjaHGe10kPjgGhO4z45Q2o9d0dTons/e7T89ALZU=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=UbdT6nYyu4ojcMzCsn1EV7pUNNqxmunc3rR9yC7wruXCc2DxGcA9HWE+mf06n+8DHs49F63tcn4uRhJ9iikctNFcT2yoaNjItNs+2S0EtICss/O7RmiKEHfkpYl0CFxWQWmfKon2jKBaioRL5Jam1UOo1WKW/fPKxd+gZMs8OOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.105])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4bh4Dm6G69ztSqB;
	Tue, 15 Jul 2025 11:19:52 +0800 (CST)
Received: from kwepemg500017.china.huawei.com (unknown [7.202.181.81])
	by mail.maildlp.com (Postfix) with ESMTPS id 5C6241401F3;
	Tue, 15 Jul 2025 11:20:58 +0800 (CST)
Received: from huawei.com (10.175.112.188) by kwepemg500017.china.huawei.com
 (7.202.181.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Tue, 15 Jul
 2025 11:20:57 +0800
From: Li Lingfeng <lilingfeng3@huawei.com>
To: <trondmy@kernel.org>, <anna@kernel.org>, <jlayton@kernel.org>,
	<bcodding@redhat.com>
CC: <linux-nfs@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<yukuai1@huaweicloud.com>, <houtao1@huawei.com>, <yi.zhang@huawei.com>,
	<yangerkun@huawei.com>, <zhangjian496@h-partners.com>,
	<lilingfeng@huaweicloud.com>, <lilingfeng3@huawei.com>
Subject: [PATCH v2] nfs: fix the race of lock/unlock and open
Date: Tue, 15 Jul 2025 11:05:59 +0800
Message-ID: <20250715030559.2906634-1-lilingfeng3@huawei.com>
X-Mailer: git-send-email 2.46.1
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: kwepems200002.china.huawei.com (7.221.188.68) To
 kwepemg500017.china.huawei.com (7.202.181.81)

LOCK may extend an existing lock and release another one and UNLOCK may
also release an existing lock.
When opening a file, there may be access to file locks that have been
concurrently released by lock/unlock operations, potentially triggering
UAF.
While certain concurrent scenarios involving lock/unlock and open
operations have been safeguarded with locks – for example,
nfs4_proc_unlckz() acquires the so_delegreturn_mutex prior to invoking
locks_lock_inode_wait() – there remain cases where such protection is not
yet implemented.

The issue can be reproduced through the following steps:
T1: open in read-only mode with three consecutive lock operations applied
    lock1(0~100) --> add lock1 to file
    lock2(120~200) --> add lock2 to file
    lock3(50~150) --> extend lock1 to cover range 0~200 and release lock2
T2: restart nfs-server and run state manager
T3: open in write-only mode
    T1                            T2                                T3
                            start recover
lock1
lock2
                            nfs4_open_reclaim
                            clear_bit // NFS_DELEGATED_STATE
lock3
 _nfs4_proc_setlk
  lock so_delegreturn_mutex
  unlock so_delegreturn_mutex
  _nfs4_do_setlk
                            recover done
                                                lock so_delegreturn_mutex
                                                nfs_delegation_claim_locks
                                                get lock2
   rpc_run_task
   ...
   nfs4_lock_done
    locks_lock_inode_wait
    ...
     locks_dispose_list
     free lock2
                                                use lock2
                                                // UAF
                                                unlock so_delegreturn_mutex

Protect file lock by nfsi->rwsem to fix this issue.

Fixes: c69899a17ca4 ("NFSv4: Update of VFS byte range lock must be atomic with the stateid update")
Reported-by: zhangjian (CG) <zhangjian496@huawei.com>
Suggested-by: yangerkun <yangerkun@huawei.com>
Signed-off-by: Li Lingfeng <lilingfeng3@huawei.com>
---
Changes in v2:
  Use nfsi->rwsem instead of sp->so_delegreturn_mutex to prevent concurrency. 

 fs/nfs/delegation.c | 5 ++++-
 fs/nfs/nfs4proc.c   | 8 +++++++-
 2 files changed, 11 insertions(+), 2 deletions(-)

diff --git a/fs/nfs/delegation.c b/fs/nfs/delegation.c
index 10ef46e29b25..4467b4f61905 100644
--- a/fs/nfs/delegation.c
+++ b/fs/nfs/delegation.c
@@ -149,15 +149,17 @@ int nfs4_check_delegation(struct inode *inode, fmode_t type)
 static int nfs_delegation_claim_locks(struct nfs4_state *state, const nfs4_stateid *stateid)
 {
 	struct inode *inode = state->inode;
+	struct nfs_inode *nfsi = NFS_I(inode);
 	struct file_lock *fl;
 	struct file_lock_context *flctx = locks_inode_context(inode);
 	struct list_head *list;
 	int status = 0;
 
 	if (flctx == NULL)
-		goto out;
+		return status;
 
 	list = &flctx->flc_posix;
+	down_write(&nfsi->rwsem);
 	spin_lock(&flctx->flc_lock);
 restart:
 	for_each_file_lock(fl, list) {
@@ -175,6 +177,7 @@ static int nfs_delegation_claim_locks(struct nfs4_state *state, const nfs4_state
 	}
 	spin_unlock(&flctx->flc_lock);
 out:
+	up_write(&nfsi->rwsem);
 	return status;
 }
 
diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
index 341740fa293d..06f109c7eb2e 100644
--- a/fs/nfs/nfs4proc.c
+++ b/fs/nfs/nfs4proc.c
@@ -7294,14 +7294,18 @@ static int nfs4_proc_unlck(struct nfs4_state *state, int cmd, struct file_lock *
 	status = -ENOMEM;
 	if (IS_ERR(seqid))
 		goto out;
+	down_read(&nfsi->rwsem);
 	task = nfs4_do_unlck(request,
 			     nfs_file_open_context(request->c.flc_file),
 			     lsp, seqid);
 	status = PTR_ERR(task);
-	if (IS_ERR(task))
+	if (IS_ERR(task)) {
+		up_read(&nfsi->rwsem);
 		goto out;
+	}
 	status = rpc_wait_for_completion_task(task);
 	rpc_put_task(task);
+	up_read(&nfsi->rwsem);
 out:
 	request->c.flc_flags = saved_flags;
 	trace_nfs4_unlock(request, state, F_SETLK, status);
@@ -7642,7 +7646,9 @@ static int _nfs4_proc_setlk(struct nfs4_state *state, int cmd, struct file_lock
 	}
 	up_read(&nfsi->rwsem);
 	mutex_unlock(&sp->so_delegreturn_mutex);
+	down_read(&nfsi->rwsem);
 	status = _nfs4_do_setlk(state, cmd, request, NFS_LOCK_NEW);
+	up_read(&nfsi->rwsem);
 out:
 	request->c.flc_flags = flags;
 	return status;
-- 
2.31.1



Return-Path: <linux-nfs+bounces-19264-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CO8LIIOin2lfdAQAu9opvQ
	(envelope-from <linux-nfs+bounces-19264-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Thu, 26 Feb 2026 02:31:47 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id EE8CF19FD0C
	for <lists+linux-nfs@lfdr.de>; Thu, 26 Feb 2026 02:31:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 92C7B305A2E8
	for <lists+linux-nfs@lfdr.de>; Thu, 26 Feb 2026 01:31:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80BB036F43F;
	Thu, 26 Feb 2026 01:31:30 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AACB933A9F7;
	Thu, 26 Feb 2026 01:31:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772069490; cv=none; b=tWvUz4rIpuHAV5R/THulKvToNjWOIQGbo80Daga7y1LYNlZau6TbEQrMW/bil3TlG7Y1Y41IwOkHz26j1yEwR4M8AcUHsSr+L+YsXTltWSxHeOFdckk0uGcvtle3CAkfq6QGSGv7Xl5b8iJ9qtWArS/ZObGK7VxqYTMjidyqXaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772069490; c=relaxed/simple;
	bh=b7uVmWBfVO3PDe/y8dTwG68BBjml6XL4rjWBKeGbn48=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=pXwcUEbY8i5LADgsZyTEVFHKwwwUo+ev1Et8sNoDxkTHNgH1BDbjO1ZFPRYEFgctrtqLrJBYUmMrzPQXEpH2Gs+rTgzF2D8BUUWTYQwRS9hyOOP9rxGYRXkayUQZhi5Pe64NcHsV9OnmoZRF5vTR3Z57vMJOWJldJIuAQl2iygw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.198])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4fLv6B4PmgzKHLyY;
	Thu, 26 Feb 2026 09:30:26 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 31EE940578;
	Thu, 26 Feb 2026 09:31:23 +0800 (CST)
Received: from huaweicloud.com (unknown [10.50.87.129])
	by APP4 (Coremail) with SMTP id gCh0CgBH8_Npop9pjJ8bIw--.60484S4;
	Thu, 26 Feb 2026 09:31:21 +0800 (CST)
From: Yang Erkun <yangerkun@huawei.com>
To: trondmy@kernel.org,
	anna@kernel.org,
	jlayton@kernel.org,
	chuck.lever@oracle.com
Cc: linux-nfs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	yangerkun@huawei.com,
	yangerkun@huaweicloud.com,
	lilingfeng3@huawei.com,
	zhangjian496@h-partners.com,
	yi.zhang@huawei.com
Subject: [RFC PATCH] nfs: use nfsi->rwsem to protect traversal of the file lock list
Date: Thu, 26 Feb 2026 09:22:03 +0800
Message-Id: <20260226012203.3962997-1-yangerkun@huawei.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgBH8_Npop9pjJ8bIw--.60484S4
X-Coremail-Antispam: 1UD129KBjvJXoWxtF4rZFyrCFykJr4xWw1DGFg_yoWxXFWUpF
	Z7ZF4YgFWrXr4xZr97Ca1DZF1Y9w48Kw4UJrZxW34IyFn8trnYgF4vkry2vFWYqrZ7JF4U
	WF1DGrW5W3yqvrUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUPIb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUXVWUAwAv7VC2z280aVAFwI0_Gr1j6F4UJwAm72CE4I
	kC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lF7Iv64x0x7Aq67IIx4CEVc8vx2IErcIF
	xwACI402YVCY1x02628vn2kIc2xKxwCY1x0262kKe7AKxVWUtVW8ZwCF04k20xvY0x0EwI
	xGrwCF04k20xvEw4C26cxK6c8Ij28IcwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02
	F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GF
	ylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7Cj
	xVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r
	1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07UL
	AwxUUUUU=
Sender: yangerkun@huaweicloud.com
X-CM-SenderInfo: 51dqwvhunx0q5kxd4v5lfo033gof0z/
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.54 / 15.00];
	DMARC_POLICY_QUARANTINE(1.50)[huawei.com : SPF not aligned (relaxed), No valid DKIM,quarantine];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-19264-lists,linux-nfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[yangerkun@huawei.com,linux-nfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	RCVD_COUNT_FIVE(0.00)[6];
	NEURAL_HAM(-0.00)[-0.998];
	TO_DN_NONE(0.00)[];
	R_DKIM_NA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,huawei.com:mid,huawei.com:email]
X-Rspamd-Queue-Id: EE8CF19FD0C
X-Rspamd-Action: no action

Lingfeng identified a bug and suggested two solutions, but both appear
to have issues.

Generally, we cannot release flc_lock while iterating over the file lock
list to avoid use-after-free (UAF) problems with file locks. However,
functions like nfs_delegation_claim_locks and nfs4_reclaim_locks cannot
adhere to this rule because recover_lock or nfs4_lock_delegation_recall
may take a long time. To resolve this, NFS switches to using nfsi->rwsem
for the same protection, and nfs_reclaim_locks follows this approach.
Although nfs_delegation_claim_locks uses so_delegreturn_mutex instead,
this is inadequate since a single inode can have multiple nfs4_state
instances. Therefore, the fix is to also use nfsi->rwsem in this case.

Furthermore, after commit c69899a17ca4 ("NFSv4: Update of VFS byte range
lock must be atomic with the stateid update"), the functions
nfs4_locku_done and nfs4_lock_done also break this rule because they
call locks_lock_inode_wait without holding nfsi->rwsem. Simply adding
this protection could cause many deadlocks, so instead, the call to
locks_lock_inode_wait is moved into _nfs4_proc_setlk. Regarding the bug
fixed by commit c69899a17ca4 ("NFSv4: Update of VFS byte range
lock must be atomic with the stateid update"), it has been resolved
after commit 0460253913e5 ("NFSv4: nfs4_do_open() is incorrectly triggering
state recovery") because all slots are drained before calling
nfs4_do_reclaim, which prevents concurrent stateid changes along this path.
Also, nfs_delegation_claim_locks does not cause this concurrency either
since when _nfs4_proc_setlk is called with NFS_DELEGATED_STATE, no RPC is
sent, so nfs4_lock_done is not called. Therefore,
nfs4_lock_delegation_recall from nfs_delegation_claim_locks is the first
time the stateid is set.

Reported-by: Li Lingfeng <lilingfeng3@huawei.com>
Closes: https://lore.kernel.org/all/20250419085709.1452492-1-lilingfeng3@huawei.com/
Closes: https://lore.kernel.org/all/20250715030559.2906634-1-lilingfeng3@huawei.com/
Fixes: c69899a17ca4 ("NFSv4: Update of VFS byte range lock must be atomic with the stateid update")
Signed-off-by: Yang Erkun <yangerkun@huawei.com>
---
 fs/nfs/delegation.c     |  9 ++++++++-
 fs/nfs/nfs4proc.c       | 22 +++++++++++-----------
 include/linux/nfs_xdr.h |  1 -
 3 files changed, 19 insertions(+), 13 deletions(-)

diff --git a/fs/nfs/delegation.c b/fs/nfs/delegation.c
index 122fb3f14ffb..9546d2195c25 100644
--- a/fs/nfs/delegation.c
+++ b/fs/nfs/delegation.c
@@ -173,6 +173,7 @@ int nfs4_check_delegation(struct inode *inode, fmode_t type)
 static int nfs_delegation_claim_locks(struct nfs4_state *state, const nfs4_stateid *stateid)
 {
 	struct inode *inode = state->inode;
+	struct nfs_inode *nfsi = NFS_I(inode);
 	struct file_lock *fl;
 	struct file_lock_context *flctx = locks_inode_context(inode);
 	struct list_head *list;
@@ -182,6 +183,9 @@ static int nfs_delegation_claim_locks(struct nfs4_state *state, const nfs4_state
 		goto out;
 
 	list = &flctx->flc_posix;
+
+	/* Guard against reclaim and new lock/unlock calls */
+	down_write(&nfsi->rwsem);
 	spin_lock(&flctx->flc_lock);
 restart:
 	for_each_file_lock(fl, list) {
@@ -189,8 +193,10 @@ static int nfs_delegation_claim_locks(struct nfs4_state *state, const nfs4_state
 			continue;
 		spin_unlock(&flctx->flc_lock);
 		status = nfs4_lock_delegation_recall(fl, state, stateid);
-		if (status < 0)
+		if (status < 0) {
+			up_write(&nfsi->rwsem);
 			goto out;
+		}
 		spin_lock(&flctx->flc_lock);
 	}
 	if (list == &flctx->flc_posix) {
@@ -198,6 +204,7 @@ static int nfs_delegation_claim_locks(struct nfs4_state *state, const nfs4_state
 		goto restart;
 	}
 	spin_unlock(&flctx->flc_lock);
+	up_write(&nfsi->rwsem);
 out:
 	return status;
 }
diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
index 91bcf67bd743..9d6fbca8798b 100644
--- a/fs/nfs/nfs4proc.c
+++ b/fs/nfs/nfs4proc.c
@@ -7076,7 +7076,6 @@ static void nfs4_locku_done(struct rpc_task *task, void *data)
 	switch (task->tk_status) {
 		case 0:
 			renew_lease(calldata->server, calldata->timestamp);
-			locks_lock_inode_wait(calldata->lsp->ls_state->inode, &calldata->fl);
 			if (nfs4_update_lock_stateid(calldata->lsp,
 					&calldata->res.stateid))
 				break;
@@ -7344,11 +7343,6 @@ static void nfs4_lock_done(struct rpc_task *task, void *calldata)
 	case 0:
 		renew_lease(NFS_SERVER(d_inode(data->ctx->dentry)),
 				data->timestamp);
-		if (data->arg.new_lock && !data->cancelled) {
-			data->fl.c.flc_flags &= ~(FL_SLEEP | FL_ACCESS);
-			if (locks_lock_inode_wait(lsp->ls_state->inode, &data->fl) < 0)
-				goto out_restart;
-		}
 		if (data->arg.new_lock_owner != 0) {
 			nfs_confirm_seqid(&lsp->ls_seqid, 0);
 			nfs4_stateid_copy(&lsp->ls_stateid, &data->res.stateid);
@@ -7459,11 +7453,10 @@ static int _nfs4_do_setlk(struct nfs4_state *state, int cmd, struct file_lock *f
 	msg.rpc_argp = &data->arg;
 	msg.rpc_resp = &data->res;
 	task_setup_data.callback_data = data;
-	if (recovery_type > NFS_LOCK_NEW) {
-		if (recovery_type == NFS_LOCK_RECLAIM)
-			data->arg.reclaim = NFS_LOCK_RECLAIM;
-	} else
-		data->arg.new_lock = 1;
+
+	if (recovery_type == NFS_LOCK_RECLAIM)
+		data->arg.reclaim = NFS_LOCK_RECLAIM;
+
 	task = rpc_run_task(&task_setup_data);
 	if (IS_ERR(task))
 		return PTR_ERR(task);
@@ -7573,6 +7566,13 @@ static int _nfs4_proc_setlk(struct nfs4_state *state, int cmd, struct file_lock
 	up_read(&nfsi->rwsem);
 	mutex_unlock(&sp->so_delegreturn_mutex);
 	status = _nfs4_do_setlk(state, cmd, request, NFS_LOCK_NEW);
+	if (status)
+		goto out;
+
+	down_read(&nfsi->rwsem);
+	request->c.flc_flags &= ~(FL_SLEEP | FL_ACCESS);
+	status = locks_lock_inode_wait(state->inode, request);
+	up_read(&nfsi->rwsem);
 out:
 	request->c.flc_flags = flags;
 	return status;
diff --git a/include/linux/nfs_xdr.h b/include/linux/nfs_xdr.h
index ff1f12aa73d2..9599ad15c3ad 100644
--- a/include/linux/nfs_xdr.h
+++ b/include/linux/nfs_xdr.h
@@ -580,7 +580,6 @@ struct nfs_lock_args {
 	struct nfs_lowner	lock_owner;
 	unsigned char		block : 1;
 	unsigned char		reclaim : 1;
-	unsigned char		new_lock : 1;
 	unsigned char		new_lock_owner : 1;
 };
 
-- 
2.39.2



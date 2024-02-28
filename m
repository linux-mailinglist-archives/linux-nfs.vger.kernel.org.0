Return-Path: <linux-nfs+bounces-2115-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6ADC286B9D1
	for <lists+linux-nfs@lfdr.de>; Wed, 28 Feb 2024 22:26:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C0B13B26CE4
	for <lists+linux-nfs@lfdr.de>; Wed, 28 Feb 2024 21:26:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E69F7002B;
	Wed, 28 Feb 2024 21:26:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eLFILlKd"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0980986250
	for <linux-nfs@vger.kernel.org>; Wed, 28 Feb 2024 21:26:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709155598; cv=none; b=YTOtpq2HumfbmOKEQ/TZDlBpbYSziH2+iKocGf+H43OpyIH2kUko6uV3dAYLKdh2Gl0p8mvZd8pmp6s89QZz9MA3dCsM+JY9MmVmN5gp6qwWYwuku5pawg4gHUeBDO/NEqdCqWDP+3QMg5kmcJB47wkG1KKqVUVJUt/3cbC9lgw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709155598; c=relaxed/simple;
	bh=i5MiVwwLaaxdrH68L3m6kiu2bGy9ddtuCLiiHbXI7cA=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=tAbb5/eYJevtXQG00hW8wga2mQeoMisDF0fGTvNtM4+NVtuGpNj7t/8Jvcuq+5TtuK/mL2G+PHK5WX5ctYsmUH7KIzpLtkCSuuauf+OyohGVVBJoqJbq8jylqf3pe4QIbgfn4afW/rtn9IVmM8n4+UTS3MwYh9u9a9j4Y1lyRUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eLFILlKd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8EDD7C433C7
	for <linux-nfs@vger.kernel.org>; Wed, 28 Feb 2024 21:26:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709155596;
	bh=i5MiVwwLaaxdrH68L3m6kiu2bGy9ddtuCLiiHbXI7cA=;
	h=From:To:Subject:Date:From;
	b=eLFILlKdUefZL++VtukKpJV1gmweGaNwL1V+paNJv4NvIbHCN0u0nlxjAW4FYP7Sr
	 PgisJcz/FfUtJiF1/vgykOV6O8gNY/AuFDadKUz4SFy+IPErpL+CIOy4N1/FgtPyXz
	 c5Kz8suvIfOIPFLn9sDheh3qUoIYCdnwKJvv4vVPbCCHxagLO61qe7saZL4XyqOu0p
	 pdVgmMrSRwl/hXrVeHZYQnGz1n4CEOLBNKm3Z7OeMtW7lFRCVhREwmvGoXJSCCIRp8
	 GCgl3QUmqZyHxCTJH5zhbnZaAlGy1p9x0K3dKJ8V1FWblp3xIFSxd43uciV9sjggyS
	 S/e0/4mLgbL4w==
From: trondmy@kernel.org
To: linux-nfs@vger.kernel.org
Subject: [PATCH] NFSv4: nfs4_do_open() is incorrectly triggering state recovery
Date: Wed, 28 Feb 2024 16:20:09 -0500
Message-ID: <20240228212009.35138-1-trondmy@kernel.org>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Trond Myklebust <trond.myklebust@hammerspace.com>

We're seeing spurious calls to nfs4_schedule_stateid_recovery() from
nfs4_do_open() in situations where there is no trigger coming from the
server.
In theory the code path being triggered is supposed to notice that state
recovery happened while we were processing the open call result from the
server, before the open stateid is published. However in the years since
that code was added, we've also added the 'session draining' mechanism,
which ensures that the state recovery will wait until all the session
slots have been returned. In nfs4_do_open() the session slot is only
returned on exit of the function, so we don't need the legacy mechanism.

Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 fs/nfs/delegation.c |  4 ----
 fs/nfs/nfs4_fs.h    |  1 -
 fs/nfs/nfs4proc.c   |  7 +------
 fs/nfs/nfs4state.c  | 12 +++++++-----
 4 files changed, 8 insertions(+), 16 deletions(-)

diff --git a/fs/nfs/delegation.c b/fs/nfs/delegation.c
index fa1a14def45c..4ba612e78da8 100644
--- a/fs/nfs/delegation.c
+++ b/fs/nfs/delegation.c
@@ -181,7 +181,6 @@ static int nfs_delegation_claim_opens(struct inode *inode,
 	struct nfs_open_context *ctx;
 	struct nfs4_state_owner *sp;
 	struct nfs4_state *state;
-	unsigned int seq;
 	int err;
 
 again:
@@ -202,12 +201,9 @@ static int nfs_delegation_claim_opens(struct inode *inode,
 		sp = state->owner;
 		/* Block nfs4_proc_unlck */
 		mutex_lock(&sp->so_delegreturn_mutex);
-		seq = raw_seqcount_begin(&sp->so_reclaim_seqcount);
 		err = nfs4_open_delegation_recall(ctx, state, stateid);
 		if (!err)
 			err = nfs_delegation_claim_locks(state, stateid);
-		if (!err && read_seqcount_retry(&sp->so_reclaim_seqcount, seq))
-			err = -EAGAIN;
 		mutex_unlock(&sp->so_delegreturn_mutex);
 		put_nfs_open_context(ctx);
 		if (err != 0)
diff --git a/fs/nfs/nfs4_fs.h b/fs/nfs/nfs4_fs.h
index 581698f1b7b2..cf17f4bc9815 100644
--- a/fs/nfs/nfs4_fs.h
+++ b/fs/nfs/nfs4_fs.h
@@ -120,7 +120,6 @@ struct nfs4_state_owner {
 	unsigned long	     so_flags;
 	struct list_head     so_states;
 	struct nfs_seqid_counter so_seqid;
-	seqcount_spinlock_t  so_reclaim_seqcount;
 	struct mutex	     so_delegreturn_mutex;
 };
 
diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
index 206b4607b29a..e9c4f7b9d44e 100644
--- a/fs/nfs/nfs4proc.c
+++ b/fs/nfs/nfs4proc.c
@@ -3069,10 +3069,8 @@ static int _nfs4_open_and_get_state(struct nfs4_opendata *opendata,
 	fmode_t acc_mode = _nfs4_ctx_to_accessmode(ctx);
 	struct inode *dir = d_inode(opendata->dir);
 	unsigned long dir_verifier;
-	unsigned int seq;
 	int ret;
 
-	seq = raw_seqcount_begin(&sp->so_reclaim_seqcount);
 	dir_verifier = nfs_save_change_attribute(dir);
 
 	ret = _nfs4_proc_open(opendata, ctx);
@@ -3125,11 +3123,8 @@ static int _nfs4_open_and_get_state(struct nfs4_opendata *opendata,
 	if (ret != 0)
 		goto out;
 
-	if (d_inode(dentry) == state->inode) {
+	if (d_inode(dentry) == state->inode)
 		nfs_inode_attach_open_context(ctx);
-		if (read_seqcount_retry(&sp->so_reclaim_seqcount, seq))
-			nfs4_schedule_stateid_recovery(server, state);
-	}
 
 out:
 	if (!opendata->cancelled) {
diff --git a/fs/nfs/nfs4state.c b/fs/nfs/nfs4state.c
index 9a5d911a7edc..8486230d99e1 100644
--- a/fs/nfs/nfs4state.c
+++ b/fs/nfs/nfs4state.c
@@ -513,7 +513,6 @@ nfs4_alloc_state_owner(struct nfs_server *server,
 	nfs4_init_seqid_counter(&sp->so_seqid);
 	atomic_set(&sp->so_count, 1);
 	INIT_LIST_HEAD(&sp->so_lru);
-	seqcount_spinlock_init(&sp->so_reclaim_seqcount, &sp->so_lock);
 	mutex_init(&sp->so_delegreturn_mutex);
 	return sp;
 }
@@ -1667,7 +1666,6 @@ static int nfs4_reclaim_open_state(struct nfs4_state_owner *sp,
 	 * server that doesn't support a grace period.
 	 */
 	spin_lock(&sp->so_lock);
-	raw_write_seqcount_begin(&sp->so_reclaim_seqcount);
 restart:
 	list_for_each_entry(state, &sp->so_states, open_states) {
 		if (!test_and_clear_bit(ops->state_flag_bit, &state->flags))
@@ -1735,7 +1733,6 @@ static int nfs4_reclaim_open_state(struct nfs4_state_owner *sp,
 		spin_lock(&sp->so_lock);
 		goto restart;
 	}
-	raw_write_seqcount_end(&sp->so_reclaim_seqcount);
 	spin_unlock(&sp->so_lock);
 #ifdef CONFIG_NFS_V4_2
 	if (found_ssc_copy_state)
@@ -1745,7 +1742,6 @@ static int nfs4_reclaim_open_state(struct nfs4_state_owner *sp,
 out_err:
 	nfs4_put_open_state(state);
 	spin_lock(&sp->so_lock);
-	raw_write_seqcount_end(&sp->so_reclaim_seqcount);
 	spin_unlock(&sp->so_lock);
 	return status;
 }
@@ -1928,9 +1924,12 @@ static int nfs4_do_reclaim(struct nfs_client *clp, const struct nfs4_state_recov
 	struct nfs_server *server;
 	struct rb_node *pos;
 	LIST_HEAD(freeme);
-	int status = 0;
 	int lost_locks = 0;
+	int status;
 
+	status = nfs4_begin_drain_session(clp);
+	if (status < 0)
+		return status;
 restart:
 	rcu_read_lock();
 	list_for_each_entry_rcu(server, &clp->cl_superblocks, client_link) {
@@ -2694,6 +2693,9 @@ static void nfs4_state_manager(struct nfs_client *clp)
 		/* Detect expired delegations... */
 		if (test_and_clear_bit(NFS4CLNT_DELEGATION_EXPIRED, &clp->cl_state)) {
 			section = "detect expired delegations";
+			status = nfs4_begin_drain_session(clp);
+			if (status < 0)
+				goto out_error;
 			nfs_reap_expired_delegations(clp);
 			continue;
 		}
-- 
2.44.0



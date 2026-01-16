Return-Path: <linux-nfs+bounces-18061-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BEE6D38902
	for <lists+linux-nfs@lfdr.de>; Fri, 16 Jan 2026 22:53:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9F46330FD2E2
	for <lists+linux-nfs@lfdr.de>; Fri, 16 Jan 2026 21:51:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E4EE3064AF;
	Fri, 16 Jan 2026 21:51:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MrLZDDzQ"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF3742FDC3D
	for <linux-nfs@vger.kernel.org>; Fri, 16 Jan 2026 21:51:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768600302; cv=none; b=pJhVIVt7paUCtFzbIW7J4UuKsNXYFqsrsHVFJtj7qRC9u9KubEkTXX1Hpc98Kmsl8uMyg1oHM7USciKNCg+VPTbcODWzneUR5m9e1BMWEs/2BO2kTbtI8SQQExPmySuu2HfPnpwx3PblxJXfbPqeD1lc84Rijwz4Ht055ugNkzg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768600302; c=relaxed/simple;
	bh=2TUvtcuaXkieoqrgHhlug8jvBOMQkvMwydzWcJwk/eA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=L9iWCPeK8ZybrgGL+CQACocCJg5MPyh1pW0pFZQtxFDMGCBc7Yd9UN/xHcprFRvCbBby40kRT7Gmb77aL1GJ15k7mSvGO3s0nA/XuEHBUIMGS/g0IE+YHHndelVJTelsyL984/ylWwsSOkT4NLOM97IPWK+y+t+T52RpGtc+gWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MrLZDDzQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84414C19424;
	Fri, 16 Jan 2026 21:51:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768600302;
	bh=2TUvtcuaXkieoqrgHhlug8jvBOMQkvMwydzWcJwk/eA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=MrLZDDzQZwRht0AODt6lN4TawsArCWMHgXElMJCy+3fp+WRjAFxFbX7JBYKI/gmEp
	 0YSIOXh71VLuK7TcofXsIO7FQ6vyrY5rc0CugkVsa26RTeMDS99oC6bwX8qXGYn7ay
	 Y3z7wumMxNBzb/Rka3I9Ki7b+hWpdY3mw0U5x7yJ9mJ9H7toEEKKKQtQLWxNvp3SM4
	 esSzYXWI9OjUO7A5nRk5f32vg0ma3ZXPaAATrN46hdNqXX1y9o52w1adQTimQleWGN
	 J7AZOwcPNhOFtTk+KbVQwz+CZUMjTe1hcnJbDAeSk0K/jHJhgb9gBZN+WFDATObP8K
	 NefYo0ZnEfFYg==
From: Anna Schumaker <anna@kernel.org>
To: linux-nfs@vger.kernel.org,
	trond.myklebust@hammerspace.com
Cc: anna@kernel.org
Subject: [PATCH v1 12/14] NFS: Move sequence slot operations into minorversion operations
Date: Fri, 16 Jan 2026 16:51:33 -0500
Message-ID: <20260116215135.846062-13-anna@kernel.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260116215135.846062-1-anna@kernel.org>
References: <20260116215135.846062-1-anna@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Anna Schumaker <anna.schumaker@oracle.com>

At the same time, I move the NFS v4.0 functions into nfs40proc.c to keep
v4.0 features together in their own files.

Signed-off-by: Anna Schumaker <anna.schumaker@oracle.com>
---
 fs/nfs/nfs40proc.c      |  30 ++++++++++++
 fs/nfs/nfs4_fs.h        |   8 +++-
 fs/nfs/nfs4proc.c       | 103 +++++++++++++---------------------------
 include/linux/nfs_xdr.h |   1 +
 4 files changed, 70 insertions(+), 72 deletions(-)

diff --git a/fs/nfs/nfs40proc.c b/fs/nfs/nfs40proc.c
index 9b5b57170471..32a2a1a2b216 100644
--- a/fs/nfs/nfs40proc.c
+++ b/fs/nfs/nfs40proc.c
@@ -6,6 +6,7 @@
 #include "internal.h"
 #include "nfs4_fs.h"
 #include "nfs40.h"
+#include "nfs4session.h"
 #include "nfs4trace.h"
 
 static void nfs40_call_sync_prepare(struct rpc_task *task, void *calldata)
@@ -21,6 +22,28 @@ static void nfs40_call_sync_done(struct rpc_task *task, void *calldata)
 	nfs4_sequence_done(task, data->seq_res);
 }
 
+static void nfs40_sequence_free_slot(struct nfs4_sequence_res *res)
+{
+	struct nfs4_slot *slot = res->sr_slot;
+	struct nfs4_slot_table *tbl;
+
+	tbl = slot->table;
+	spin_lock(&tbl->slot_tbl_lock);
+	if (!nfs41_wake_and_assign_slot(tbl, slot))
+		nfs4_free_slot(tbl, slot);
+	spin_unlock(&tbl->slot_tbl_lock);
+
+	res->sr_slot = NULL;
+}
+
+static int nfs40_sequence_done(struct rpc_task *task,
+			       struct nfs4_sequence_res *res)
+{
+	if (res->sr_slot != NULL)
+		nfs40_sequence_free_slot(res);
+	return 1;
+}
+
 static void nfs40_clear_delegation_stateid(struct nfs4_state *state)
 {
 	if (rcu_access_pointer(NFS_I(state->inode)->delegation) != NULL)
@@ -317,6 +340,12 @@ static const struct rpc_call_ops nfs40_call_sync_ops = {
 	.rpc_call_done = nfs40_call_sync_done,
 };
 
+static const struct nfs4_sequence_slot_ops nfs40_sequence_slot_ops = {
+	.process = nfs40_sequence_done,
+	.done = nfs40_sequence_done,
+	.free_slot = nfs40_sequence_free_slot,
+};
+
 static const struct nfs4_state_recovery_ops nfs40_reboot_recovery_ops = {
 	.owner_flag_bit = NFS_OWNER_RECLAIM_REBOOT,
 	.state_flag_bit	= NFS_STATE_RECLAIM_REBOOT,
@@ -358,6 +387,7 @@ const struct nfs4_minor_version_ops nfs_v4_0_minor_ops = {
 	.test_and_free_expired = nfs40_test_and_free_expired_stateid,
 	.alloc_seqid = nfs_alloc_seqid,
 	.call_sync_ops = &nfs40_call_sync_ops,
+	.sequence_slot_ops = &nfs40_sequence_slot_ops,
 	.reboot_recovery_ops = &nfs40_reboot_recovery_ops,
 	.nograce_recovery_ops = &nfs40_nograce_recovery_ops,
 	.state_renewal_ops = &nfs40_state_renewal_ops,
diff --git a/fs/nfs/nfs4_fs.h b/fs/nfs/nfs4_fs.h
index 34cdbf42b865..a5dd4a837769 100644
--- a/fs/nfs/nfs4_fs.h
+++ b/fs/nfs/nfs4_fs.h
@@ -73,6 +73,7 @@ struct nfs4_minor_version_ops {
 	void	(*session_trunk)(struct rpc_clnt *clnt,
 			struct rpc_xprt *xprt, void *data);
 	const struct rpc_call_ops *call_sync_ops;
+	const struct nfs4_sequence_slot_ops *sequence_slot_ops;
 	const struct nfs4_state_recovery_ops *reboot_recovery_ops;
 	const struct nfs4_state_recovery_ops *nograce_recovery_ops;
 	const struct nfs4_state_maintenance_ops *state_renewal_ops;
@@ -256,6 +257,12 @@ struct nfs4_add_xprt_data {
 	const struct cred	*cred;
 };
 
+struct nfs4_sequence_slot_ops {
+	int (*process)(struct rpc_task *, struct nfs4_sequence_res *);
+	int (*done)(struct rpc_task *, struct nfs4_sequence_res *);
+	void (*free_slot)(struct nfs4_sequence_res *);
+};
+
 struct nfs4_state_maintenance_ops {
 	int (*sched_state_renewal)(struct nfs_client *, const struct cred *, unsigned);
 	const struct cred * (*get_state_renewal_cred)(struct nfs_client *);
@@ -311,7 +318,6 @@ extern int nfs4_call_sync_sequence(struct rpc_clnt *clnt,
 				   struct nfs4_sequence_res *res);
 extern void nfs4_init_sequence(struct nfs_client *clp, struct nfs4_sequence_args *,
 			       struct nfs4_sequence_res *, int, int);
-extern int nfs40_sequence_done(struct rpc_task *task, struct nfs4_sequence_res *res);
 extern int nfs4_proc_setclientid(struct nfs_client *, u32, unsigned short, const struct cred *, struct nfs4_setclientid_res *);
 extern int nfs4_proc_setclientid_confirm(struct nfs_client *, struct nfs4_setclientid_res *arg, const struct cred *);
 extern void renew_lease(const struct nfs_server *server, unsigned long timestamp);
diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
index 27ed07c5f669..ae14e9d65e1b 100644
--- a/fs/nfs/nfs4proc.c
+++ b/fs/nfs/nfs4proc.c
@@ -780,28 +780,7 @@ void nfs4_init_sequence(struct nfs_client *clp,
 	args->sa_privileged = privileged;
 
 	res->sr_slot = NULL;
-}
-
-static void nfs40_sequence_free_slot(struct nfs4_sequence_res *res)
-{
-	struct nfs4_slot *slot = res->sr_slot;
-	struct nfs4_slot_table *tbl;
-
-	tbl = slot->table;
-	spin_lock(&tbl->slot_tbl_lock);
-	if (!nfs41_wake_and_assign_slot(tbl, slot))
-		nfs4_free_slot(tbl, slot);
-	spin_unlock(&tbl->slot_tbl_lock);
-
-	res->sr_slot = NULL;
-}
-
-int nfs40_sequence_done(struct rpc_task *task,
-			struct nfs4_sequence_res *res)
-{
-	if (res->sr_slot != NULL)
-		nfs40_sequence_free_slot(res);
-	return 1;
+	res->sr_slot_ops = clp->cl_mvops->sequence_slot_ops;
 }
 
 #if defined(CONFIG_NFS_V4_1)
@@ -1020,35 +999,6 @@ int nfs41_sequence_done(struct rpc_task *task, struct nfs4_sequence_res *res)
 }
 EXPORT_SYMBOL_GPL(nfs41_sequence_done);
 
-static int nfs4_sequence_process(struct rpc_task *task, struct nfs4_sequence_res *res)
-{
-	if (res->sr_slot == NULL)
-		return 1;
-	if (res->sr_slot->table->session != NULL)
-		return nfs41_sequence_process(task, res);
-	return nfs40_sequence_done(task, res);
-}
-
-static void nfs4_sequence_free_slot(struct nfs4_sequence_res *res)
-{
-	if (res->sr_slot != NULL) {
-		if (res->sr_slot->table->session != NULL)
-			nfs41_sequence_free_slot(res);
-		else
-			nfs40_sequence_free_slot(res);
-	}
-}
-
-int nfs4_sequence_done(struct rpc_task *task, struct nfs4_sequence_res *res)
-{
-	if (res->sr_slot == NULL)
-		return 1;
-	if (!res->sr_slot->table->session)
-		return nfs40_sequence_done(task, res);
-	return nfs41_sequence_done(task, res);
-}
-EXPORT_SYMBOL_GPL(nfs4_sequence_done);
-
 static void nfs41_call_sync_prepare(struct rpc_task *task, void *calldata)
 {
 	struct nfs4_call_sync_data *data = calldata;
@@ -1071,25 +1021,6 @@ static const struct rpc_call_ops nfs41_call_sync_ops = {
 	.rpc_call_done = nfs41_call_sync_done,
 };
 
-#else	/* !CONFIG_NFS_V4_1 */
-
-static int nfs4_sequence_process(struct rpc_task *task, struct nfs4_sequence_res *res)
-{
-	return nfs40_sequence_done(task, res);
-}
-
-static void nfs4_sequence_free_slot(struct nfs4_sequence_res *res)
-{
-	if (res->sr_slot != NULL)
-		nfs40_sequence_free_slot(res);
-}
-
-int nfs4_sequence_done(struct rpc_task *task,
-		       struct nfs4_sequence_res *res)
-{
-	return nfs40_sequence_done(task, res);
-}
-EXPORT_SYMBOL_GPL(nfs4_sequence_done);
 
 #endif	/* !CONFIG_NFS_V4_1 */
 
@@ -1113,6 +1044,28 @@ void nfs4_sequence_attach_slot(struct nfs4_sequence_args *args,
 	res->sr_slot = slot;
 }
 
+static void nfs4_sequence_free_slot(struct nfs4_sequence_res *res)
+{
+	if (res->sr_slot != NULL)
+		res->sr_slot_ops->free_slot(res);
+}
+
+static int nfs4_sequence_process(struct rpc_task *task, struct nfs4_sequence_res *res)
+{
+	if (res->sr_slot == NULL)
+		return 1;
+	return res->sr_slot_ops->process(task, res);
+}
+
+int nfs4_sequence_done(struct rpc_task *task, struct nfs4_sequence_res *res)
+{
+	if (res->sr_slot == NULL)
+		return 1;
+	return res->sr_slot_ops->done(task, res);
+}
+EXPORT_SYMBOL_GPL(nfs4_sequence_done);
+
+
 int nfs4_setup_sequence(struct nfs_client *client,
 			struct nfs4_sequence_args *args,
 			struct nfs4_sequence_res *res,
@@ -2443,7 +2396,7 @@ static void nfs4_open_confirm_done(struct rpc_task *task, void *calldata)
 {
 	struct nfs4_opendata *data = calldata;
 
-	nfs40_sequence_done(task, &data->c_res.seq_res);
+	data->c_res.seq_res.sr_slot_ops->done(task, &data->c_res.seq_res);
 
 	data->rpc_status = task->tk_status;
 	if (data->rpc_status == 0) {
@@ -10498,6 +10451,12 @@ bool nfs4_match_stateid(const nfs4_stateid *s1,
 
 
 #if defined(CONFIG_NFS_V4_1)
+static const struct nfs4_sequence_slot_ops nfs41_sequence_slot_ops = {
+	.process = nfs41_sequence_process,
+	.done = nfs41_sequence_done,
+	.free_slot = nfs41_sequence_free_slot,
+};
+
 static const struct nfs4_state_recovery_ops nfs41_reboot_recovery_ops = {
 	.owner_flag_bit = NFS_OWNER_RECLAIM_REBOOT,
 	.state_flag_bit	= NFS_STATE_RECLAIM_REBOOT,
@@ -10552,6 +10511,7 @@ static const struct nfs4_minor_version_ops nfs_v4_1_minor_ops = {
 	.alloc_seqid = nfs_alloc_no_seqid,
 	.session_trunk = nfs4_test_session_trunk,
 	.call_sync_ops = &nfs41_call_sync_ops,
+	.sequence_slot_ops = &nfs41_sequence_slot_ops,
 	.reboot_recovery_ops = &nfs41_reboot_recovery_ops,
 	.nograce_recovery_ops = &nfs41_nograce_recovery_ops,
 	.state_renewal_ops = &nfs41_state_renewal_ops,
@@ -10588,6 +10548,7 @@ static const struct nfs4_minor_version_ops nfs_v4_2_minor_ops = {
 	.find_root_sec = nfs41_find_root_sec,
 	.free_lock_state = nfs41_free_lock_state,
 	.call_sync_ops = &nfs41_call_sync_ops,
+	.sequence_slot_ops = &nfs41_sequence_slot_ops,
 	.test_and_free_expired = nfs41_test_and_free_expired_stateid,
 	.alloc_seqid = nfs_alloc_no_seqid,
 	.session_trunk = nfs4_test_session_trunk,
diff --git a/include/linux/nfs_xdr.h b/include/linux/nfs_xdr.h
index 79fe2dfb470f..2aa4e38af57a 100644
--- a/include/linux/nfs_xdr.h
+++ b/include/linux/nfs_xdr.h
@@ -209,6 +209,7 @@ struct nfs4_sequence_args {
 };
 
 struct nfs4_sequence_res {
+	const struct nfs4_sequence_slot_ops *sr_slot_ops;
 	struct nfs4_slot	*sr_slot;	/* slot used to send request */
 	unsigned long		sr_timestamp;
 	int			sr_status;	/* sequence operation status */
-- 
2.52.0



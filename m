Return-Path: <linux-nfs+bounces-18523-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +Mj2H37Rd2mxlQEAu9opvQ
	(envelope-from <linux-nfs+bounces-18523-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Mon, 26 Jan 2026 21:41:34 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CEC3D8D307
	for <lists+linux-nfs@lfdr.de>; Mon, 26 Jan 2026 21:41:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6EB2E3055112
	for <lists+linux-nfs@lfdr.de>; Mon, 26 Jan 2026 20:39:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E8B72D73BD;
	Mon, 26 Jan 2026 20:39:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FVh1DrUS"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEAAF2D73AD
	for <linux-nfs@vger.kernel.org>; Mon, 26 Jan 2026 20:39:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769459985; cv=none; b=Ifsc9ag426llWO5+eFQyb5SqPOAjzNTs2NdIJqPpIHO5uAqwLWIuaP56EL6aQ6N3tQgd5NEecoJXOazfsi55Gojgdie0V16qG2xBOke1Y21AO/AfpY9itjUTYkhhVnhvM/0Q2TKySX36nWvXKhwqM/bI74kNILe5ecRFbfxCKWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769459985; c=relaxed/simple;
	bh=y95hMhv4cq+AVPNHXcym9DPgqekc2VcOM1GehYp2ZUg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZSCw1dDpDooxxQ1HpfGe1+lXoTU90v8GIO952V4CZnGKzu/tihu67YosKLzUK0PnCkAVN2AY7aSTfxSKymn1cUu+L+7mN07zNvg9C2zyNaLG8JXaT43oMl8fTQP0JT3wobFNuh+2PJlO7+hb++fMg+33p5grw/1ufHRq1WeXWHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FVh1DrUS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 743F6C2BC86;
	Mon, 26 Jan 2026 20:39:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769459985;
	bh=y95hMhv4cq+AVPNHXcym9DPgqekc2VcOM1GehYp2ZUg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=FVh1DrUSLKulR7nnqXgrEx1fdsx5/a4XNvgZVTIfu6f0dI+9l3AjM4lSBuSGwTYf5
	 VSc9llil/MCQ/yXXQfO5vMZLZ805/6okGSWGUOGWGWMarycWA/xEmdweM7F9D6XjqH
	 NxJaL4n9zRxG6Js7D2EHKSEoMJexUrdaR/YY7YHIm5Bt6dTahK2zNBqTPgl7lbjbpS
	 /+ncA7n3/gT2PeGHFRghaspycA2yiu5tGKZynuUcYg8ErK0stdMsmiE3dfOfdcSF/7
	 L5OxcM61/2344FI/W9fW2akzqv8uv1b9y0/tWqkhA24/nbRZZ1WeVflxvyQXkhdavR
	 gSvelKg3VT+tQ==
From: Anna Schumaker <anna@kernel.org>
To: linux-nfs@vger.kernel.org,
	trond.myklebust@hammerspace.com
Cc: anna@kernel.org
Subject: [PATCH v2 12/14] NFS: Move sequence slot operations into minorversion operations
Date: Mon, 26 Jan 2026 15:39:36 -0500
Message-ID: <20260126203938.450304-13-anna@kernel.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260126203938.450304-1-anna@kernel.org>
References: <20260126203938.450304-1-anna@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-18523-lists,linux-nfs=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[anna@kernel.org,linux-nfs@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[3];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,oracle.com:email]
X-Rspamd-Queue-Id: CEC3D8D307
X-Rspamd-Action: no action

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
index c7c466fa5434..6cb2c1d9d691 100644
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
index a8cc3d1b9416..eaf2e5f5cf55 100644
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
@@ -2447,7 +2400,7 @@ static void nfs4_open_confirm_done(struct rpc_task *task, void *calldata)
 {
 	struct nfs4_opendata *data = calldata;
 
-	nfs40_sequence_done(task, &data->c_res.seq_res);
+	data->c_res.seq_res.sr_slot_ops->done(task, &data->c_res.seq_res);
 
 	data->rpc_status = task->tk_status;
 	if (data->rpc_status == 0) {
@@ -10508,6 +10461,12 @@ bool nfs4_match_stateid(const nfs4_stateid *s1,
 
 
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
@@ -10562,6 +10521,7 @@ static const struct nfs4_minor_version_ops nfs_v4_1_minor_ops = {
 	.alloc_seqid = nfs_alloc_no_seqid,
 	.session_trunk = nfs4_test_session_trunk,
 	.call_sync_ops = &nfs41_call_sync_ops,
+	.sequence_slot_ops = &nfs41_sequence_slot_ops,
 	.reboot_recovery_ops = &nfs41_reboot_recovery_ops,
 	.nograce_recovery_ops = &nfs41_nograce_recovery_ops,
 	.state_renewal_ops = &nfs41_state_renewal_ops,
@@ -10598,6 +10558,7 @@ static const struct nfs4_minor_version_ops nfs_v4_2_minor_ops = {
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



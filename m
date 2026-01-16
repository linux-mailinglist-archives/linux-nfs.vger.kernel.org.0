Return-Path: <linux-nfs+bounces-18054-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BE822D388FD
	for <lists+linux-nfs@lfdr.de>; Fri, 16 Jan 2026 22:52:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E749430BB66E
	for <lists+linux-nfs@lfdr.de>; Fri, 16 Jan 2026 21:51:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADF8130DEB0;
	Fri, 16 Jan 2026 21:51:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CAh9h0Sy"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3653930CDBB
	for <linux-nfs@vger.kernel.org>; Fri, 16 Jan 2026 21:51:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768600299; cv=none; b=BPgTos2sgBmkzLCVQpt8Eb7tj4cNLvY0zPu4DmAHfK2bPnSb59L/FmZIJUSXZNiIOBbqBecqoazN6/gR/7eLEPTxfLTahUSJ2a/OCPei9I/7zXfyM2CgaTA4mtSFPX/vbflc8KR9guQ20jL0PLQM+eZExXT03fqCFiEBPro+Jfo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768600299; c=relaxed/simple;
	bh=D9JV9znj02oe0X75Qjt10LqJiHhiT/LAnH7VlYaqNQI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ekJlP6S+rEFct6r3K6RNQeBiESjD+ikrp/tLSrFfTT54uxpnULYxF+P1kidv0+DIKMIc0K/pKIHZSRG0PZpjH8vSG+lB/HqqNwn3TvZEZYlm2e2RogOeG552mP3kFsHHZJa9Lway9aZ8BoDooPwGeJOVa8tC6FST01sTuECjH5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CAh9h0Sy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B49BDC19423;
	Fri, 16 Jan 2026 21:51:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768600299;
	bh=D9JV9znj02oe0X75Qjt10LqJiHhiT/LAnH7VlYaqNQI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=CAh9h0SymfOszB+n3m7zZpKPZEpuavXIyVpfy51YfZdffqCMEw+t6t6P32Rp8PGqO
	 4az3FQdBApBK7IupzU1utMD4foJJoXiE4PSCnEtDUpKDjWZWHD91uuFbsk7yHqz1Cd
	 OVcxWeNQG1k9CJTqfLQG953AAUkPYdjqtEoGW2UqQMj7KI69PHIHxkwGaA3NNnRGMc
	 HY6vic664tfq397GfmlKszWra3ltSIAHRZIG4BkWvI8DrdJzvluJrhUoD9PL7g9StL
	 dOFWddvutWWdEpD4yzSzjBoUV2uLfHgpdsS3W0znxpWbi608fJeeGOVRuWq0t2Su0T
	 THvTPxBs9/zWw==
From: Anna Schumaker <anna@kernel.org>
To: linux-nfs@vger.kernel.org,
	trond.myklebust@hammerspace.com
Cc: anna@kernel.org
Subject: [PATCH v1 04/14] NFS: Split out the nfs40_state_renewal_ops into nfs40proc.c
Date: Fri, 16 Jan 2026 16:51:25 -0500
Message-ID: <20260116215135.846062-5-anna@kernel.org>
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

Signed-off-by: Anna Schumaker <anna.schumaker@oracle.com>
---
 fs/nfs/nfs40.h     |   1 +
 fs/nfs/nfs40proc.c | 100 ++++++++++++++++++++++++++++++++++++++++++++
 fs/nfs/nfs4_fs.h   |   1 +
 fs/nfs/nfs4proc.c  | 102 +--------------------------------------------
 4 files changed, 103 insertions(+), 101 deletions(-)

diff --git a/fs/nfs/nfs40.h b/fs/nfs/nfs40.h
index c64e5ff6c9ff..fd606b4a044a 100644
--- a/fs/nfs/nfs40.h
+++ b/fs/nfs/nfs40.h
@@ -7,6 +7,7 @@
 extern const struct rpc_call_ops nfs40_call_sync_ops;
 extern const struct nfs4_state_recovery_ops nfs40_reboot_recovery_ops;
 extern const struct nfs4_state_recovery_ops nfs40_nograce_recovery_ops;
+extern const struct nfs4_state_maintenance_ops nfs40_state_renewal_ops;
 
 /* nfs40state.c */
 int nfs40_discover_server_trunking(struct nfs_client *clp,
diff --git a/fs/nfs/nfs40proc.c b/fs/nfs/nfs40proc.c
index 867afdf4ecf4..96ce463c951b 100644
--- a/fs/nfs/nfs40proc.c
+++ b/fs/nfs/nfs40proc.c
@@ -3,7 +3,9 @@
 #include <linux/nfs.h>
 #include <linux/sunrpc/sched.h>
 #include <linux/nfs_fs.h>
+#include "internal.h"
 #include "nfs4_fs.h"
+#include "nfs4trace.h"
 
 static void nfs40_call_sync_prepare(struct rpc_task *task, void *calldata)
 {
@@ -32,6 +34,98 @@ static int nfs40_open_expired(struct nfs4_state_owner *sp, struct nfs4_state *st
 	return nfs4_open_expired(sp, state);
 }
 
+struct nfs4_renewdata {
+	struct nfs_client	*client;
+	unsigned long		timestamp;
+};
+
+/*
+ * nfs4_proc_async_renew(): This is not one of the nfs_rpc_ops; it is a special
+ * standalone procedure for queueing an asynchronous RENEW.
+ */
+static void nfs4_renew_release(void *calldata)
+{
+	struct nfs4_renewdata *data = calldata;
+	struct nfs_client *clp = data->client;
+
+	if (refcount_read(&clp->cl_count) > 1)
+		nfs4_schedule_state_renewal(clp);
+	nfs_put_client(clp);
+	kfree(data);
+}
+
+static void nfs4_renew_done(struct rpc_task *task, void *calldata)
+{
+	struct nfs4_renewdata *data = calldata;
+	struct nfs_client *clp = data->client;
+	unsigned long timestamp = data->timestamp;
+
+	trace_nfs4_renew_async(clp, task->tk_status);
+	switch (task->tk_status) {
+	case 0:
+		break;
+	case -NFS4ERR_LEASE_MOVED:
+		nfs4_schedule_lease_moved_recovery(clp);
+		break;
+	default:
+		/* Unless we're shutting down, schedule state recovery! */
+		if (test_bit(NFS_CS_RENEWD, &clp->cl_res_state) == 0)
+			return;
+		if (task->tk_status != NFS4ERR_CB_PATH_DOWN) {
+			nfs4_schedule_lease_recovery(clp);
+			return;
+		}
+		nfs4_schedule_path_down_recovery(clp);
+	}
+	do_renew_lease(clp, timestamp);
+}
+
+static const struct rpc_call_ops nfs4_renew_ops = {
+	.rpc_call_done = nfs4_renew_done,
+	.rpc_release = nfs4_renew_release,
+};
+
+static int nfs4_proc_async_renew(struct nfs_client *clp, const struct cred *cred, unsigned renew_flags)
+{
+	struct rpc_message msg = {
+		.rpc_proc	= &nfs4_procedures[NFSPROC4_CLNT_RENEW],
+		.rpc_argp	= clp,
+		.rpc_cred	= cred,
+	};
+	struct nfs4_renewdata *data;
+
+	if (renew_flags == 0)
+		return 0;
+	if (!refcount_inc_not_zero(&clp->cl_count))
+		return -EIO;
+	data = kmalloc(sizeof(*data), GFP_NOFS);
+	if (data == NULL) {
+		nfs_put_client(clp);
+		return -ENOMEM;
+	}
+	data->client = clp;
+	data->timestamp = jiffies;
+	return rpc_call_async(clp->cl_rpcclient, &msg, RPC_TASK_TIMEOUT,
+			&nfs4_renew_ops, data);
+}
+
+static int nfs4_proc_renew(struct nfs_client *clp, const struct cred *cred)
+{
+	struct rpc_message msg = {
+		.rpc_proc	= &nfs4_procedures[NFSPROC4_CLNT_RENEW],
+		.rpc_argp	= clp,
+		.rpc_cred	= cred,
+	};
+	unsigned long now = jiffies;
+	int status;
+
+	status = rpc_call_sync(clp->cl_rpcclient, &msg, RPC_TASK_TIMEOUT);
+	if (status < 0)
+		return status;
+	do_renew_lease(clp, now);
+	return 0;
+}
+
 const struct rpc_call_ops nfs40_call_sync_ops = {
 	.rpc_call_prepare = nfs40_call_sync_prepare,
 	.rpc_call_done = nfs40_call_sync_done,
@@ -53,3 +147,9 @@ const struct nfs4_state_recovery_ops nfs40_nograce_recovery_ops = {
 	.recover_lock	= nfs4_lock_expired,
 	.establish_clid = nfs4_init_clientid,
 };
+
+const struct nfs4_state_maintenance_ops nfs40_state_renewal_ops = {
+	.sched_state_renewal = nfs4_proc_async_renew,
+	.get_state_renewal_cred = nfs4_get_renew_cred,
+	.renew_lease = nfs4_proc_renew,
+};
diff --git a/fs/nfs/nfs4_fs.h b/fs/nfs/nfs4_fs.h
index 885a78a3c22c..b43fb84145e0 100644
--- a/fs/nfs/nfs4_fs.h
+++ b/fs/nfs/nfs4_fs.h
@@ -358,6 +358,7 @@ extern void nfs_state_clear_delegation(struct nfs4_state *state);
 extern void nfs_finish_clear_delegation_stateid(struct nfs4_state *state,
 						const nfs4_stateid *stateid);
 extern void nfs_state_clear_open_state_flags(struct nfs4_state *state);
+extern void do_renew_lease(struct nfs_client *clp, unsigned long timestamp);
 
 #if defined(CONFIG_NFS_V4_1)
 extern int nfs41_sequence_done(struct rpc_task *, struct nfs4_sequence_res *);
diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
index 29105262d22a..235078a3529e 100644
--- a/fs/nfs/nfs4proc.c
+++ b/fs/nfs/nfs4proc.c
@@ -754,7 +754,7 @@ static bool _nfs4_is_integrity_protected(struct nfs_client *clp)
 	return (flavor == RPC_AUTH_GSS_KRB5I) || (flavor == RPC_AUTH_GSS_KRB5P);
 }
 
-static void do_renew_lease(struct nfs_client *clp, unsigned long timestamp)
+void do_renew_lease(struct nfs_client *clp, unsigned long timestamp)
 {
 	spin_lock(&clp->cl_lock);
 	if (time_before(clp->cl_last_renewal,timestamp))
@@ -5940,98 +5940,6 @@ int nfs4_proc_commit(struct file *dst, __u64 offset, __u32 count, struct nfs_com
 	return status;
 }
 
-struct nfs4_renewdata {
-	struct nfs_client	*client;
-	unsigned long		timestamp;
-};
-
-/*
- * nfs4_proc_async_renew(): This is not one of the nfs_rpc_ops; it is a special
- * standalone procedure for queueing an asynchronous RENEW.
- */
-static void nfs4_renew_release(void *calldata)
-{
-	struct nfs4_renewdata *data = calldata;
-	struct nfs_client *clp = data->client;
-
-	if (refcount_read(&clp->cl_count) > 1)
-		nfs4_schedule_state_renewal(clp);
-	nfs_put_client(clp);
-	kfree(data);
-}
-
-static void nfs4_renew_done(struct rpc_task *task, void *calldata)
-{
-	struct nfs4_renewdata *data = calldata;
-	struct nfs_client *clp = data->client;
-	unsigned long timestamp = data->timestamp;
-
-	trace_nfs4_renew_async(clp, task->tk_status);
-	switch (task->tk_status) {
-	case 0:
-		break;
-	case -NFS4ERR_LEASE_MOVED:
-		nfs4_schedule_lease_moved_recovery(clp);
-		break;
-	default:
-		/* Unless we're shutting down, schedule state recovery! */
-		if (test_bit(NFS_CS_RENEWD, &clp->cl_res_state) == 0)
-			return;
-		if (task->tk_status != NFS4ERR_CB_PATH_DOWN) {
-			nfs4_schedule_lease_recovery(clp);
-			return;
-		}
-		nfs4_schedule_path_down_recovery(clp);
-	}
-	do_renew_lease(clp, timestamp);
-}
-
-static const struct rpc_call_ops nfs4_renew_ops = {
-	.rpc_call_done = nfs4_renew_done,
-	.rpc_release = nfs4_renew_release,
-};
-
-static int nfs4_proc_async_renew(struct nfs_client *clp, const struct cred *cred, unsigned renew_flags)
-{
-	struct rpc_message msg = {
-		.rpc_proc	= &nfs4_procedures[NFSPROC4_CLNT_RENEW],
-		.rpc_argp	= clp,
-		.rpc_cred	= cred,
-	};
-	struct nfs4_renewdata *data;
-
-	if (renew_flags == 0)
-		return 0;
-	if (!refcount_inc_not_zero(&clp->cl_count))
-		return -EIO;
-	data = kmalloc(sizeof(*data), GFP_NOFS);
-	if (data == NULL) {
-		nfs_put_client(clp);
-		return -ENOMEM;
-	}
-	data->client = clp;
-	data->timestamp = jiffies;
-	return rpc_call_async(clp->cl_rpcclient, &msg, RPC_TASK_TIMEOUT,
-			&nfs4_renew_ops, data);
-}
-
-static int nfs4_proc_renew(struct nfs_client *clp, const struct cred *cred)
-{
-	struct rpc_message msg = {
-		.rpc_proc	= &nfs4_procedures[NFSPROC4_CLNT_RENEW],
-		.rpc_argp	= clp,
-		.rpc_cred	= cred,
-	};
-	unsigned long now = jiffies;
-	int status;
-
-	status = rpc_call_sync(clp->cl_rpcclient, &msg, RPC_TASK_TIMEOUT);
-	if (status < 0)
-		return status;
-	do_renew_lease(clp, now);
-	return 0;
-}
-
 static bool nfs4_server_supports_acls(const struct nfs_server *server,
 				      enum nfs4_acl_type type)
 {
@@ -10777,15 +10685,7 @@ static const struct nfs4_state_recovery_ops nfs41_nograce_recovery_ops = {
 	.recover_lock	= nfs41_lock_expired,
 	.establish_clid = nfs41_init_clientid,
 };
-#endif /* CONFIG_NFS_V4_1 */
 
-static const struct nfs4_state_maintenance_ops nfs40_state_renewal_ops = {
-	.sched_state_renewal = nfs4_proc_async_renew,
-	.get_state_renewal_cred = nfs4_get_renew_cred,
-	.renew_lease = nfs4_proc_renew,
-};
-
-#if defined(CONFIG_NFS_V4_1)
 static const struct nfs4_state_maintenance_ops nfs41_state_renewal_ops = {
 	.sched_state_renewal = nfs41_proc_async_sequence,
 	.get_state_renewal_cred = nfs4_get_machine_cred,
-- 
2.52.0



Return-Path: <linux-nfs+bounces-18515-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2Kb7FmDRd2mxlQEAu9opvQ
	(envelope-from <linux-nfs+bounces-18515-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Mon, 26 Jan 2026 21:41:04 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D94E28D2CD
	for <lists+linux-nfs@lfdr.de>; Mon, 26 Jan 2026 21:41:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 54B87303E487
	for <lists+linux-nfs@lfdr.de>; Mon, 26 Jan 2026 20:39:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA20C1DDC07;
	Mon, 26 Jan 2026 20:39:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ggaGIBxU"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7FEC2D6E74
	for <linux-nfs@vger.kernel.org>; Mon, 26 Jan 2026 20:39:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769459981; cv=none; b=UDZvhMvgNsBF9xgEFQWgvPuGnNiKrjM/jLCU+Vuvjd2X0ObdrIcFGJP15t+aus10irCoo2ea2B598+7t6rBpDNhpGdWjmbBIizHVuMJWCZHtuvrPWCxXEjRbNbGpVLUE/Ld3FE5vvyO4QPQ5h7tYRHb3YcQY0AXvjqPuu1cT8Lk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769459981; c=relaxed/simple;
	bh=yrT0FKcm4SESNS8y/mPWIwWKmTTgo2tBmyzMy5Qg2kg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=k7jqzPxh+FVBM+eLxYtTAQilAlAGlNku06gHNsYP92rvCc0KjsZvDBF4z6ACJiEhhqnQIdO2KC9kAEpdBU9P5i3qLI5zG7pO75C6OAZIqtjIL4dU24wKuOoOCzXVzoBgrge2IWN6xT601GRi5n+S9lqDX8GjDCZBQIYhmKP3Cq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ggaGIBxU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45B97C19425;
	Mon, 26 Jan 2026 20:39:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769459981;
	bh=yrT0FKcm4SESNS8y/mPWIwWKmTTgo2tBmyzMy5Qg2kg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ggaGIBxUO4poCm/b7EwbXxR82N7SbtICwoCdQmn0yETyUcpuD+EdDk+lCCB7A5hNE
	 i1iwHfY+6mQrPd7ndh3JV9hAbUi1S9SY/S5Sl2/PZyTWWbZBWGoPoVghQEQvZj9If+
	 2JbSEWMMSNgo4Q8A93iluwu8CKYcgiPLesMLbX/4vvy9e49fj7JckYDLBqWQFOhAz+
	 f1jURTWtSG1CLdDwAyGUlGzV15JJBob7/a7QtcjUvpTmSoOkqGqdjC/27arPCh8h5R
	 eypKM8QZWDlo5X7TQNdb39s4SXM0fd/LH5RwmgXwAPZR7BwM67sdNDOMSEOb9ljOUV
	 fRF7wdu2jhDJQ==
From: Anna Schumaker <anna@kernel.org>
To: linux-nfs@vger.kernel.org,
	trond.myklebust@hammerspace.com
Cc: anna@kernel.org
Subject: [PATCH v2 04/14] NFS: Split out the nfs40_state_renewal_ops into nfs40proc.c
Date: Mon, 26 Jan 2026 15:39:28 -0500
Message-ID: <20260126203938.450304-5-anna@kernel.org>
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
	TAGGED_FROM(0.00)[bounces-18515-lists,linux-nfs=lfdr.de];
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
X-Rspamd-Queue-Id: D94E28D2CD
X-Rspamd-Action: no action

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
index b56113b70d88..eb89d57a9289 100644
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
index 00a92e6653a1..a52e985149bf 100644
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
@@ -5971,98 +5971,6 @@ int nfs4_proc_commit(struct file *dst, __u64 offset, __u32 count, struct nfs_com
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
@@ -10787,15 +10695,7 @@ static const struct nfs4_state_recovery_ops nfs41_nograce_recovery_ops = {
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



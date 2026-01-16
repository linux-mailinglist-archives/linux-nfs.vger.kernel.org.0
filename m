Return-Path: <linux-nfs+bounces-18052-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E2DED388F3
	for <lists+linux-nfs@lfdr.de>; Fri, 16 Jan 2026 22:51:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 852B8300FEEF
	for <lists+linux-nfs@lfdr.de>; Fri, 16 Jan 2026 21:51:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2E3B306B0A;
	Fri, 16 Jan 2026 21:51:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sg6TWR6j"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E23030AD00
	for <linux-nfs@vger.kernel.org>; Fri, 16 Jan 2026 21:51:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768600298; cv=none; b=XZTOj1ZJ5IuNbLqmmPLxmmn8UfawiBb6v189lhmHndzTe0FSww53TBAb4WKFkmWbdY7bWzaTFez7coqDsDV6VuBtiC7oxYu9YfUayDGqV+B4A2UYe1hacjrmclj+eSp4pmasFo4Ajq82yNtli8yUaOS+gdRN0S9DH1fm3xjSpsI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768600298; c=relaxed/simple;
	bh=jwaLzM4z4gJ6H95CKXEQypFMOHQU1ucrxmDCxGrv8Pw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sezZO7x7EId+vGPuf6vxpGncQvh6SgcZ0jsVzHmZombbhb7iDOvQCe08KZ3zeDsoc73HzG6tKJFDNRW1WH5V/UKsaXy+LDTkIoweunfWu3SxvcChgmmzYxPpIiIB134qTfc9nDsLI9JbeTSX+o0CBigwzgHRUbcjI2jJkEpROKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sg6TWR6j; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C06E9C116C6;
	Fri, 16 Jan 2026 21:51:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768600298;
	bh=jwaLzM4z4gJ6H95CKXEQypFMOHQU1ucrxmDCxGrv8Pw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=sg6TWR6j2KmCB4OuW0yWiview2HcMyS/AqMP+bTnrosCknCbSUCRx2gkjcoSAD/0c
	 NBkSR0ku3OjSMSn4UNaJIgW2bBXDqVEunBbJk9AzWBmB/2L04LoCjen6vmEyRbfWcJ
	 0/EFo+eTWMEDg8HuZk+4JD6yVzrOQgQJHbxqCSfLGkppWqgJcMnO4YAVVUxMJ1Sq8C
	 j5vLm1WeFW9XrWODSQMd/jMaUctOjpuCPOtUQUBks2ZFyurKMttWAQnG7Y+/vDyAMJ
	 znbFPfWWDasmFelcSj7D42VM/ifB4XyQczPzbecnEODp4prsA/r7udRXvzSowhkjC3
	 Rz3T+MN/RTpnQ==
From: Anna Schumaker <anna@kernel.org>
To: linux-nfs@vger.kernel.org,
	trond.myklebust@hammerspace.com
Cc: anna@kernel.org
Subject: [PATCH v1 02/14] NFS: Split out the nfs40_reboot_recovery_ops into nfs40client.c
Date: Fri, 16 Jan 2026 16:51:23 -0500
Message-ID: <20260116215135.846062-3-anna@kernel.org>
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
 fs/nfs/Makefile      |   2 +-
 fs/nfs/internal.h    |   3 -
 fs/nfs/nfs40.h       |   7 ++
 fs/nfs/nfs40client.c | 188 +++++++++++++++++++++++++++++++++++++++++++
 fs/nfs/nfs40proc.c   |   9 +++
 fs/nfs/nfs4_fs.h     |   7 ++
 fs/nfs/nfs4client.c  | 132 +-----------------------------
 fs/nfs/nfs4proc.c    |  13 +--
 fs/nfs/nfs4state.c   |  49 -----------
 9 files changed, 216 insertions(+), 194 deletions(-)
 create mode 100644 fs/nfs/nfs40client.c

diff --git a/fs/nfs/Makefile b/fs/nfs/Makefile
index 937c775a04a3..d05e69c00fe1 100644
--- a/fs/nfs/Makefile
+++ b/fs/nfs/Makefile
@@ -27,7 +27,7 @@ CFLAGS_nfs4trace.o += -I$(src)
 nfsv4-y := nfs4proc.o nfs4xdr.o nfs4state.o nfs4renewd.o nfs4super.o nfs4file.o \
 	  delegation.o nfs4idmap.o callback.o callback_xdr.o callback_proc.o \
 	  nfs4namespace.o nfs4getroot.o nfs4client.o nfs4session.o \
-	  dns_resolve.o nfs4trace.o nfs40proc.o
+	  dns_resolve.o nfs4trace.o nfs40proc.o nfs40client.o
 nfsv4-$(CONFIG_NFS_USE_LEGACY_DNS) += cache_lib.o
 nfsv4-$(CONFIG_SYSCTL)	+= nfs4sysctl.o
 nfsv4-$(CONFIG_NFS_V4_1)	+= pnfs.o pnfs_dev.o pnfs_nfs.o
diff --git a/fs/nfs/internal.h b/fs/nfs/internal.h
index 2e596244799f..e99998e515c0 100644
--- a/fs/nfs/internal.h
+++ b/fs/nfs/internal.h
@@ -739,9 +739,6 @@ extern ssize_t nfs_dreq_bytes_left(struct nfs_direct_req *dreq, loff_t offset);
 /* nfs4proc.c */
 extern struct nfs_client *nfs4_init_client(struct nfs_client *clp,
 			    const struct nfs_client_initdata *);
-extern int nfs40_walk_client_list(struct nfs_client *clp,
-				struct nfs_client **result,
-				const struct cred *cred);
 extern int nfs41_walk_client_list(struct nfs_client *clp,
 				struct nfs_client **result,
 				const struct cred *cred);
diff --git a/fs/nfs/nfs40.h b/fs/nfs/nfs40.h
index 58a59109987a..ad57172b49a3 100644
--- a/fs/nfs/nfs40.h
+++ b/fs/nfs/nfs40.h
@@ -3,6 +3,13 @@
 #define __LINUX_FS_NFS_NFS4_0_H
 
 
+/* nfs40proc.c */
 extern const struct rpc_call_ops nfs40_call_sync_ops;
+extern const struct nfs4_state_recovery_ops nfs40_reboot_recovery_ops;
+
+/* nfs40state.c */
+int nfs40_discover_server_trunking(struct nfs_client *clp,
+				   struct nfs_client **result,
+				   const struct cred *cred);
 
 #endif /* __LINUX_FS_NFS_NFS4_0_H */
diff --git a/fs/nfs/nfs40client.c b/fs/nfs/nfs40client.c
new file mode 100644
index 000000000000..bab073b6506b
--- /dev/null
+++ b/fs/nfs/nfs40client.c
@@ -0,0 +1,188 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#include <linux/nfs_fs.h>
+#include "nfs4_fs.h"
+#include "callback.h"
+#include "internal.h"
+#include "netns.h"
+#include "nfs40.h"
+
+#define NFSDBG_FACILITY		NFSDBG_CLIENT
+
+/*
+ * SETCLIENTID just did a callback update with the callback ident in
+ * "drop," but server trunking discovery claims "drop" and "keep" are
+ * actually the same server.  Swap the callback IDs so that "keep"
+ * will continue to use the callback ident the server now knows about,
+ * and so that "keep"'s original callback ident is destroyed when
+ * "drop" is freed.
+ */
+static void nfs4_swap_callback_idents(struct nfs_client *keep,
+				      struct nfs_client *drop)
+{
+	struct nfs_net *nn = net_generic(keep->cl_net, nfs_net_id);
+	unsigned int save = keep->cl_cb_ident;
+
+	if (keep->cl_cb_ident == drop->cl_cb_ident)
+		return;
+
+	dprintk("%s: keeping callback ident %u and dropping ident %u\n",
+		__func__, keep->cl_cb_ident, drop->cl_cb_ident);
+
+	spin_lock(&nn->nfs_client_lock);
+
+	idr_replace(&nn->cb_ident_idr, keep, drop->cl_cb_ident);
+	keep->cl_cb_ident = drop->cl_cb_ident;
+
+	idr_replace(&nn->cb_ident_idr, drop, save);
+	drop->cl_cb_ident = save;
+
+	spin_unlock(&nn->nfs_client_lock);
+}
+
+static bool nfs4_same_verifier(nfs4_verifier *v1, nfs4_verifier *v2)
+{
+	return memcmp(v1->data, v2->data, sizeof(v1->data)) == 0;
+}
+
+/**
+ * nfs40_walk_client_list - Find server that recognizes a client ID
+ *
+ * @new: nfs_client with client ID to test
+ * @result: OUT: found nfs_client, or new
+ * @cred: credential to use for trunking test
+ *
+ * Returns zero, a negative errno, or a negative NFS4ERR status.
+ * If zero is returned, an nfs_client pointer is planted in "result."
+ *
+ * NB: nfs40_walk_client_list() relies on the new nfs_client being
+ *     the last nfs_client on the list.
+ */
+static int nfs40_walk_client_list(struct nfs_client *new,
+				  struct nfs_client **result,
+				  const struct cred *cred)
+{
+	struct nfs_net *nn = net_generic(new->cl_net, nfs_net_id);
+	struct nfs_client *pos, *prev = NULL;
+	struct nfs4_setclientid_res clid = {
+		.clientid	= new->cl_clientid,
+		.confirm	= new->cl_confirm,
+	};
+	int status = -NFS4ERR_STALE_CLIENTID;
+
+	spin_lock(&nn->nfs_client_lock);
+	list_for_each_entry(pos, &nn->nfs_client_list, cl_share_link) {
+
+		if (pos == new)
+			goto found;
+
+		status = nfs4_match_client(pos, new, &prev, nn);
+		if (status < 0)
+			goto out_unlock;
+		if (status != 0)
+			continue;
+		/*
+		 * We just sent a new SETCLIENTID, which should have
+		 * caused the server to return a new cl_confirm.  So if
+		 * cl_confirm is the same, then this is a different
+		 * server that just returned the same cl_confirm by
+		 * coincidence:
+		 */
+		if ((new != pos) && nfs4_same_verifier(&pos->cl_confirm,
+						       &new->cl_confirm))
+			continue;
+		/*
+		 * But if the cl_confirm's are different, then the only
+		 * way that a SETCLIENTID_CONFIRM to pos can succeed is
+		 * if new and pos point to the same server:
+		 */
+found:
+		refcount_inc(&pos->cl_count);
+		spin_unlock(&nn->nfs_client_lock);
+
+		nfs_put_client(prev);
+		prev = pos;
+
+		status = nfs4_proc_setclientid_confirm(pos, &clid, cred);
+		switch (status) {
+		case -NFS4ERR_STALE_CLIENTID:
+			break;
+		case 0:
+			nfs4_swap_callback_idents(pos, new);
+			pos->cl_confirm = new->cl_confirm;
+			nfs_mark_client_ready(pos, NFS_CS_READY);
+
+			prev = NULL;
+			*result = pos;
+			goto out;
+		case -ERESTARTSYS:
+		case -ETIMEDOUT:
+			/* The callback path may have been inadvertently
+			 * changed. Schedule recovery!
+			 */
+			nfs4_schedule_path_down_recovery(pos);
+			goto out;
+		default:
+			goto out;
+		}
+
+		spin_lock(&nn->nfs_client_lock);
+	}
+out_unlock:
+	spin_unlock(&nn->nfs_client_lock);
+
+	/* No match found. The server lost our clientid */
+out:
+	nfs_put_client(prev);
+	return status;
+}
+
+/**
+ * nfs40_discover_server_trunking - Detect server IP address trunking (mv0)
+ *
+ * @clp: nfs_client under test
+ * @result: OUT: found nfs_client, or clp
+ * @cred: credential to use for trunking test
+ *
+ * Returns zero, a negative errno, or a negative NFS4ERR status.
+ * If zero is returned, an nfs_client pointer is planted in
+ * "result".
+ *
+ * Note: The returned client may not yet be marked ready.
+ */
+int nfs40_discover_server_trunking(struct nfs_client *clp,
+				   struct nfs_client **result,
+				   const struct cred *cred)
+{
+	struct nfs4_setclientid_res clid = {
+		.clientid = clp->cl_clientid,
+		.confirm = clp->cl_confirm,
+	};
+	struct nfs_net *nn = net_generic(clp->cl_net, nfs_net_id);
+	unsigned short port;
+	int status;
+
+	port = nn->nfs_callback_tcpport;
+	if (clp->cl_addr.ss_family == AF_INET6)
+		port = nn->nfs_callback_tcpport6;
+
+	status = nfs4_proc_setclientid(clp, NFS4_CALLBACK, port, cred, &clid);
+	if (status != 0)
+		goto out;
+	clp->cl_clientid = clid.clientid;
+	clp->cl_confirm = clid.confirm;
+
+	status = nfs40_walk_client_list(clp, result, cred);
+	if (status == 0) {
+		/* Sustain the lease, even if it's empty.  If the clientid4
+		 * goes stale it's of no use for trunking discovery. */
+		nfs4_schedule_state_renewal(*result);
+
+		/* If the client state need to recover, do it. */
+		if (clp->cl_state)
+			nfs4_schedule_state_manager(clp);
+	}
+out:
+	return status;
+}
+
+
diff --git a/fs/nfs/nfs40proc.c b/fs/nfs/nfs40proc.c
index 6d27dedad055..b2cc7519b226 100644
--- a/fs/nfs/nfs40proc.c
+++ b/fs/nfs/nfs40proc.c
@@ -22,3 +22,12 @@ const struct rpc_call_ops nfs40_call_sync_ops = {
 	.rpc_call_prepare = nfs40_call_sync_prepare,
 	.rpc_call_done = nfs40_call_sync_done,
 };
+
+const struct nfs4_state_recovery_ops nfs40_reboot_recovery_ops = {
+	.owner_flag_bit = NFS_OWNER_RECLAIM_REBOOT,
+	.state_flag_bit	= NFS_STATE_RECLAIM_REBOOT,
+	.recover_open	= nfs4_open_reclaim,
+	.recover_lock	= nfs4_lock_reclaim,
+	.establish_clid = nfs4_init_clientid,
+	.detect_trunking = nfs40_discover_server_trunking,
+};
diff --git a/fs/nfs/nfs4_fs.h b/fs/nfs/nfs4_fs.h
index 575343261c9a..246a43d172f9 100644
--- a/fs/nfs/nfs4_fs.h
+++ b/fs/nfs/nfs4_fs.h
@@ -277,6 +277,11 @@ int nfs_atomic_open(struct inode *, struct dentry *, struct file *,
 /* fs_context.c */
 extern struct file_system_type nfs4_fs_type;
 
+/* nfs4client.c */
+struct nfs_net;
+int nfs4_match_client(struct nfs_client *pos, struct nfs_client *new,
+		      struct nfs_client **prev, struct nfs_net *nn);
+
 /* nfs4namespace.c */
 struct rpc_clnt *nfs4_negotiate_security(struct rpc_clnt *, struct inode *,
 					 const struct qstr *);
@@ -345,6 +350,8 @@ extern void nfs4_update_changeattr(struct inode *dir,
 				   unsigned long cache_validity);
 extern int nfs4_buf_to_pages_noslab(const void *buf, size_t buflen,
 				    struct page **pages);
+extern int nfs4_open_reclaim(struct nfs4_state_owner *, struct nfs4_state *);
+extern int nfs4_lock_reclaim(struct nfs4_state *state, struct file_lock *request);
 
 #if defined(CONFIG_NFS_V4_1)
 extern int nfs41_sequence_done(struct rpc_task *, struct nfs4_sequence_res *);
diff --git a/fs/nfs/nfs4client.c b/fs/nfs/nfs4client.c
index 96bccefbe2cb..517cf8af2943 100644
--- a/fs/nfs/nfs4client.c
+++ b/fs/nfs/nfs4client.c
@@ -490,37 +490,6 @@ struct nfs_client *nfs4_init_client(struct nfs_client *clp,
 	return ERR_PTR(error);
 }
 
-/*
- * SETCLIENTID just did a callback update with the callback ident in
- * "drop," but server trunking discovery claims "drop" and "keep" are
- * actually the same server.  Swap the callback IDs so that "keep"
- * will continue to use the callback ident the server now knows about,
- * and so that "keep"'s original callback ident is destroyed when
- * "drop" is freed.
- */
-static void nfs4_swap_callback_idents(struct nfs_client *keep,
-				      struct nfs_client *drop)
-{
-	struct nfs_net *nn = net_generic(keep->cl_net, nfs_net_id);
-	unsigned int save = keep->cl_cb_ident;
-
-	if (keep->cl_cb_ident == drop->cl_cb_ident)
-		return;
-
-	dprintk("%s: keeping callback ident %u and dropping ident %u\n",
-		__func__, keep->cl_cb_ident, drop->cl_cb_ident);
-
-	spin_lock(&nn->nfs_client_lock);
-
-	idr_replace(&nn->cb_ident_idr, keep, drop->cl_cb_ident);
-	keep->cl_cb_ident = drop->cl_cb_ident;
-
-	idr_replace(&nn->cb_ident_idr, drop, save);
-	drop->cl_cb_ident = save;
-
-	spin_unlock(&nn->nfs_client_lock);
-}
-
 static bool nfs4_match_client_owner_id(const struct nfs_client *clp1,
 		const struct nfs_client *clp2)
 {
@@ -529,13 +498,8 @@ static bool nfs4_match_client_owner_id(const struct nfs_client *clp1,
 	return strcmp(clp1->cl_owner_id, clp2->cl_owner_id) == 0;
 }
 
-static bool nfs4_same_verifier(nfs4_verifier *v1, nfs4_verifier *v2)
-{
-	return memcmp(v1->data, v2->data, sizeof(v1->data)) == 0;
-}
-
-static int nfs4_match_client(struct nfs_client  *pos,  struct nfs_client *new,
-			     struct nfs_client **prev, struct nfs_net *nn)
+int nfs4_match_client(struct nfs_client  *pos,  struct nfs_client *new,
+		      struct nfs_client **prev, struct nfs_net *nn)
 {
 	int status;
 
@@ -578,98 +542,6 @@ static int nfs4_match_client(struct nfs_client  *pos,  struct nfs_client *new,
 	return 0;
 }
 
-/**
- * nfs40_walk_client_list - Find server that recognizes a client ID
- *
- * @new: nfs_client with client ID to test
- * @result: OUT: found nfs_client, or new
- * @cred: credential to use for trunking test
- *
- * Returns zero, a negative errno, or a negative NFS4ERR status.
- * If zero is returned, an nfs_client pointer is planted in "result."
- *
- * NB: nfs40_walk_client_list() relies on the new nfs_client being
- *     the last nfs_client on the list.
- */
-int nfs40_walk_client_list(struct nfs_client *new,
-			   struct nfs_client **result,
-			   const struct cred *cred)
-{
-	struct nfs_net *nn = net_generic(new->cl_net, nfs_net_id);
-	struct nfs_client *pos, *prev = NULL;
-	struct nfs4_setclientid_res clid = {
-		.clientid	= new->cl_clientid,
-		.confirm	= new->cl_confirm,
-	};
-	int status = -NFS4ERR_STALE_CLIENTID;
-
-	spin_lock(&nn->nfs_client_lock);
-	list_for_each_entry(pos, &nn->nfs_client_list, cl_share_link) {
-
-		if (pos == new)
-			goto found;
-
-		status = nfs4_match_client(pos, new, &prev, nn);
-		if (status < 0)
-			goto out_unlock;
-		if (status != 0)
-			continue;
-		/*
-		 * We just sent a new SETCLIENTID, which should have
-		 * caused the server to return a new cl_confirm.  So if
-		 * cl_confirm is the same, then this is a different
-		 * server that just returned the same cl_confirm by
-		 * coincidence:
-		 */
-		if ((new != pos) && nfs4_same_verifier(&pos->cl_confirm,
-						       &new->cl_confirm))
-			continue;
-		/*
-		 * But if the cl_confirm's are different, then the only
-		 * way that a SETCLIENTID_CONFIRM to pos can succeed is
-		 * if new and pos point to the same server:
-		 */
-found:
-		refcount_inc(&pos->cl_count);
-		spin_unlock(&nn->nfs_client_lock);
-
-		nfs_put_client(prev);
-		prev = pos;
-
-		status = nfs4_proc_setclientid_confirm(pos, &clid, cred);
-		switch (status) {
-		case -NFS4ERR_STALE_CLIENTID:
-			break;
-		case 0:
-			nfs4_swap_callback_idents(pos, new);
-			pos->cl_confirm = new->cl_confirm;
-			nfs_mark_client_ready(pos, NFS_CS_READY);
-
-			prev = NULL;
-			*result = pos;
-			goto out;
-		case -ERESTARTSYS:
-		case -ETIMEDOUT:
-			/* The callback path may have been inadvertently
-			 * changed. Schedule recovery!
-			 */
-			nfs4_schedule_path_down_recovery(pos);
-			goto out;
-		default:
-			goto out;
-		}
-
-		spin_lock(&nn->nfs_client_lock);
-	}
-out_unlock:
-	spin_unlock(&nn->nfs_client_lock);
-
-	/* No match found. The server lost our clientid */
-out:
-	nfs_put_client(prev);
-	return status;
-}
-
 #ifdef CONFIG_NFS_V4_1
 /*
  * Returns true if the server major ids match
diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
index 18f24b9c1dfe..a1a8ee28f26d 100644
--- a/fs/nfs/nfs4proc.c
+++ b/fs/nfs/nfs4proc.c
@@ -2327,7 +2327,7 @@ static int nfs4_do_open_reclaim(struct nfs_open_context *ctx, struct nfs4_state
 	return err;
 }
 
-static int nfs4_open_reclaim(struct nfs4_state_owner *sp, struct nfs4_state *state)
+int nfs4_open_reclaim(struct nfs4_state_owner *sp, struct nfs4_state *state)
 {
 	struct nfs_open_context *ctx;
 	int ret;
@@ -7618,7 +7618,7 @@ static int _nfs4_do_setlk(struct nfs4_state *state, int cmd, struct file_lock *f
 	return ret;
 }
 
-static int nfs4_lock_reclaim(struct nfs4_state *state, struct file_lock *request)
+int nfs4_lock_reclaim(struct nfs4_state *state, struct file_lock *request)
 {
 	struct nfs_server *server = NFS_SERVER(state->inode);
 	struct nfs4_exception exception = {
@@ -10773,15 +10773,6 @@ static bool nfs4_match_stateid(const nfs4_stateid *s1,
 }
 
 
-static const struct nfs4_state_recovery_ops nfs40_reboot_recovery_ops = {
-	.owner_flag_bit = NFS_OWNER_RECLAIM_REBOOT,
-	.state_flag_bit	= NFS_STATE_RECLAIM_REBOOT,
-	.recover_open	= nfs4_open_reclaim,
-	.recover_lock	= nfs4_lock_reclaim,
-	.establish_clid = nfs4_init_clientid,
-	.detect_trunking = nfs40_discover_server_trunking,
-};
-
 #if defined(CONFIG_NFS_V4_1)
 static const struct nfs4_state_recovery_ops nfs41_reboot_recovery_ops = {
 	.owner_flag_bit = NFS_OWNER_RECLAIM_REBOOT,
diff --git a/fs/nfs/nfs4state.c b/fs/nfs/nfs4state.c
index 01179f7de322..5eaa45fd69ea 100644
--- a/fs/nfs/nfs4state.c
+++ b/fs/nfs/nfs4state.c
@@ -142,55 +142,6 @@ int nfs4_init_clientid(struct nfs_client *clp, const struct cred *cred)
 	return status;
 }
 
-/**
- * nfs40_discover_server_trunking - Detect server IP address trunking (mv0)
- *
- * @clp: nfs_client under test
- * @result: OUT: found nfs_client, or clp
- * @cred: credential to use for trunking test
- *
- * Returns zero, a negative errno, or a negative NFS4ERR status.
- * If zero is returned, an nfs_client pointer is planted in
- * "result".
- *
- * Note: The returned client may not yet be marked ready.
- */
-int nfs40_discover_server_trunking(struct nfs_client *clp,
-				   struct nfs_client **result,
-				   const struct cred *cred)
-{
-	struct nfs4_setclientid_res clid = {
-		.clientid = clp->cl_clientid,
-		.confirm = clp->cl_confirm,
-	};
-	struct nfs_net *nn = net_generic(clp->cl_net, nfs_net_id);
-	unsigned short port;
-	int status;
-
-	port = nn->nfs_callback_tcpport;
-	if (clp->cl_addr.ss_family == AF_INET6)
-		port = nn->nfs_callback_tcpport6;
-
-	status = nfs4_proc_setclientid(clp, NFS4_CALLBACK, port, cred, &clid);
-	if (status != 0)
-		goto out;
-	clp->cl_clientid = clid.clientid;
-	clp->cl_confirm = clid.confirm;
-
-	status = nfs40_walk_client_list(clp, result, cred);
-	if (status == 0) {
-		/* Sustain the lease, even if it's empty.  If the clientid4
-		 * goes stale it's of no use for trunking discovery. */
-		nfs4_schedule_state_renewal(*result);
-
-		/* If the client state need to recover, do it. */
-		if (clp->cl_state)
-			nfs4_schedule_state_manager(clp);
-	}
-out:
-	return status;
-}
-
 const struct cred *nfs4_get_machine_cred(struct nfs_client *clp)
 {
 	return get_cred(rpc_machine_cred());
-- 
2.52.0



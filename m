Return-Path: <linux-nfs+bounces-18055-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F1D8BD388FE
	for <lists+linux-nfs@lfdr.de>; Fri, 16 Jan 2026 22:52:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6A2E430C759B
	for <lists+linux-nfs@lfdr.de>; Fri, 16 Jan 2026 21:51:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2596730E0C2;
	Fri, 16 Jan 2026 21:51:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EEMuLMLw"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA52630BB9B
	for <linux-nfs@vger.kernel.org>; Fri, 16 Jan 2026 21:51:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768600299; cv=none; b=fuTf5Lb2AlpXJdSNczqNZBHXA4K8SBl/a/0M8Otbwa8MAoG+a/kTttsQWda2JPrPkhxpcUvMQsSe6LEcIrKozFwmU7vOLwXHTnXUx0siwlGj99Xz4Uhs3vdDvCQbThn1NRn+rQbdsVS4frA6DfyiB7AGjQpDLCWltN2ekZTXWMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768600299; c=relaxed/simple;
	bh=I3fzHtQ3kchRuanTPv7k1cNQXvfPZT9B2chGTcE2ZK8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=t8LGGxXrQ9zFshgSyLWIDdZiMJDua3rngS00gH6HTcU7dnWN7BlmqM2NXITxAXGjn5XEa3y9teVYPN3xmkAozQegKQeHYB7pTPIT3VlYXgSIWk3xueyYG+AqVq3UiLe/8DSFM0Vkb7CaiZxOVZw6R1vpnqzwUAtC936043fg8E8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EEMuLMLw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 328A6C19422;
	Fri, 16 Jan 2026 21:51:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768600299;
	bh=I3fzHtQ3kchRuanTPv7k1cNQXvfPZT9B2chGTcE2ZK8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=EEMuLMLwdwSKfEaMqKN2H+soOUKgp5IuRh2/zSiX71dBum8GcT9dKF1FZkXSzV1qD
	 7z7GQXsllc2iGAU6fvnBcfk7/4MfclD7gcW1CwfVZPtgNdOK8CDiiF8kM6JpTCrGfi
	 WNwZ+Q4BH6132fquw792gbasJ+BHAB6AyYtT0Aigbu9A1Ek6zpibkllgUbPbLikR2K
	 yl+nNr31jTOuRrLlqxFbAdlYgIaKj3SYpo6YRh2IaykH03cmRI/gv7RekqH8mQkvYE
	 n1y8zNcOj0FfL42VV7ezZNnvQkVHxV5QL+TB7oCbkzNemBlERtR7McxCSqx8qjsLBZ
	 9GpTm/zqD7xLw==
From: Anna Schumaker <anna@kernel.org>
To: linux-nfs@vger.kernel.org,
	trond.myklebust@hammerspace.com
Cc: anna@kernel.org
Subject: [PATCH v1 05/14] NFS: Split out the nfs40_mig_recovery_ops to nfs40proc.c
Date: Fri, 16 Jan 2026 16:51:26 -0500
Message-ID: <20260116215135.846062-6-anna@kernel.org>
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
 fs/nfs/nfs40proc.c | 101 +++++++++++++++++++++++++++++++++++++++
 fs/nfs/nfs4_fs.h   |   6 +++
 fs/nfs/nfs4proc.c  | 115 +++------------------------------------------
 4 files changed, 114 insertions(+), 109 deletions(-)

diff --git a/fs/nfs/nfs40.h b/fs/nfs/nfs40.h
index fd606b4a044a..a04fb2390fa7 100644
--- a/fs/nfs/nfs40.h
+++ b/fs/nfs/nfs40.h
@@ -8,6 +8,7 @@ extern const struct rpc_call_ops nfs40_call_sync_ops;
 extern const struct nfs4_state_recovery_ops nfs40_reboot_recovery_ops;
 extern const struct nfs4_state_recovery_ops nfs40_nograce_recovery_ops;
 extern const struct nfs4_state_maintenance_ops nfs40_state_renewal_ops;
+extern const struct nfs4_mig_recovery_ops nfs40_mig_recovery_ops;
 
 /* nfs40state.c */
 int nfs40_discover_server_trunking(struct nfs_client *clp,
diff --git a/fs/nfs/nfs40proc.c b/fs/nfs/nfs40proc.c
index 96ce463c951b..736e782a27e1 100644
--- a/fs/nfs/nfs40proc.c
+++ b/fs/nfs/nfs40proc.c
@@ -126,6 +126,102 @@ static int nfs4_proc_renew(struct nfs_client *clp, const struct cred *cred)
 	return 0;
 }
 
+/*
+ * This operation also signals the server that this client is
+ * performing migration recovery.  The server can stop returning
+ * NFS4ERR_LEASE_MOVED to this client.  A RENEW operation is
+ * appended to this compound to identify the client ID which is
+ * performing recovery.
+ */
+static int _nfs40_proc_get_locations(struct nfs_server *server,
+				     struct nfs_fh *fhandle,
+				     struct nfs4_fs_locations *locations,
+				     struct page *page, const struct cred *cred)
+{
+	struct rpc_clnt *clnt = server->client;
+	u32 bitmask[2] = {
+		[0] = FATTR4_WORD0_FSID | FATTR4_WORD0_FS_LOCATIONS,
+	};
+	struct nfs4_fs_locations_arg args = {
+		.clientid	= server->nfs_client->cl_clientid,
+		.fh		= fhandle,
+		.page		= page,
+		.bitmask	= bitmask,
+		.migration	= 1,		/* skip LOOKUP */
+		.renew		= 1,		/* append RENEW */
+	};
+	struct nfs4_fs_locations_res res = {
+		.fs_locations	= locations,
+		.migration	= 1,
+		.renew		= 1,
+	};
+	struct rpc_message msg = {
+		.rpc_proc	= &nfs4_procedures[NFSPROC4_CLNT_FS_LOCATIONS],
+		.rpc_argp	= &args,
+		.rpc_resp	= &res,
+		.rpc_cred	= cred,
+	};
+	unsigned long now = jiffies;
+	int status;
+
+	nfs_fattr_init(locations->fattr);
+	locations->server = server;
+	locations->nlocations = 0;
+
+	nfs4_init_sequence(&args.seq_args, &res.seq_res, 0, 1);
+	status = nfs4_call_sync_sequence(clnt, server, &msg,
+					&args.seq_args, &res.seq_res);
+	if (status)
+		return status;
+
+	renew_lease(server, now);
+	return 0;
+}
+
+/*
+ * This operation also signals the server that this client is
+ * performing "lease moved" recovery.  The server can stop
+ * returning NFS4ERR_LEASE_MOVED to this client.  A RENEW operation
+ * is appended to this compound to identify the client ID which is
+ * performing recovery.
+ */
+static int _nfs40_proc_fsid_present(struct inode *inode, const struct cred *cred)
+{
+	struct nfs_server *server = NFS_SERVER(inode);
+	struct nfs_client *clp = NFS_SERVER(inode)->nfs_client;
+	struct rpc_clnt *clnt = server->client;
+	struct nfs4_fsid_present_arg args = {
+		.fh		= NFS_FH(inode),
+		.clientid	= clp->cl_clientid,
+		.renew		= 1,		/* append RENEW */
+	};
+	struct nfs4_fsid_present_res res = {
+		.renew		= 1,
+	};
+	struct rpc_message msg = {
+		.rpc_proc	= &nfs4_procedures[NFSPROC4_CLNT_FSID_PRESENT],
+		.rpc_argp	= &args,
+		.rpc_resp	= &res,
+		.rpc_cred	= cred,
+	};
+	unsigned long now = jiffies;
+	int status;
+
+	res.fh = nfs_alloc_fhandle();
+	if (res.fh == NULL)
+		return -ENOMEM;
+
+	nfs4_init_sequence(&args.seq_args, &res.seq_res, 0, 1);
+	status = nfs4_call_sync_sequence(clnt, server, &msg,
+						&args.seq_args, &res.seq_res);
+	nfs_free_fhandle(res.fh);
+	if (status)
+		return status;
+
+	do_renew_lease(clp, now);
+	return 0;
+}
+
 const struct rpc_call_ops nfs40_call_sync_ops = {
 	.rpc_call_prepare = nfs40_call_sync_prepare,
 	.rpc_call_done = nfs40_call_sync_done,
@@ -153,3 +249,8 @@ const struct nfs4_state_maintenance_ops nfs40_state_renewal_ops = {
 	.get_state_renewal_cred = nfs4_get_renew_cred,
 	.renew_lease = nfs4_proc_renew,
 };
+
+const struct nfs4_mig_recovery_ops nfs40_mig_recovery_ops = {
+	.get_locations = _nfs40_proc_get_locations,
+	.fsid_present = _nfs40_proc_fsid_present,
+};
diff --git a/fs/nfs/nfs4_fs.h b/fs/nfs/nfs4_fs.h
index b43fb84145e0..7fcab74f01fb 100644
--- a/fs/nfs/nfs4_fs.h
+++ b/fs/nfs/nfs4_fs.h
@@ -304,9 +304,15 @@ extern int nfs4_async_handle_error(struct rpc_task *task,
 extern int nfs4_call_sync(struct rpc_clnt *, struct nfs_server *,
 			  struct rpc_message *, struct nfs4_sequence_args *,
 			  struct nfs4_sequence_res *, int);
+extern int nfs4_call_sync_sequence(struct rpc_clnt *clnt,
+				   struct nfs_server *server,
+				   struct rpc_message *msg,
+				   struct nfs4_sequence_args *args,
+				   struct nfs4_sequence_res *res);
 extern void nfs4_init_sequence(struct nfs4_sequence_args *, struct nfs4_sequence_res *, int, int);
 extern int nfs4_proc_setclientid(struct nfs_client *, u32, unsigned short, const struct cred *, struct nfs4_setclientid_res *);
 extern int nfs4_proc_setclientid_confirm(struct nfs_client *, struct nfs4_setclientid_res *arg, const struct cred *);
+extern void renew_lease(const struct nfs_server *server, unsigned long timestamp);
 extern int nfs4_proc_get_rootfh(struct nfs_server *, struct nfs_fh *,
 				struct nfs_fattr *, bool);
 extern int nfs4_proc_bind_conn_to_session(struct nfs_client *, const struct cred *cred);
diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
index 235078a3529e..5a7f3068d5f7 100644
--- a/fs/nfs/nfs4proc.c
+++ b/fs/nfs/nfs4proc.c
@@ -762,7 +762,7 @@ void do_renew_lease(struct nfs_client *clp, unsigned long timestamp)
 	spin_unlock(&clp->cl_lock);
 }
 
-static void renew_lease(const struct nfs_server *server, unsigned long timestamp)
+void renew_lease(const struct nfs_server *server, unsigned long timestamp)
 {
 	struct nfs_client *clp = server->nfs_client;
 
@@ -1207,11 +1207,11 @@ static int nfs4_do_call_sync(struct rpc_clnt *clnt,
 	return nfs4_call_sync_custom(&task_setup);
 }
 
-static int nfs4_call_sync_sequence(struct rpc_clnt *clnt,
-				   struct nfs_server *server,
-				   struct rpc_message *msg,
-				   struct nfs4_sequence_args *args,
-				   struct nfs4_sequence_res *res)
+int nfs4_call_sync_sequence(struct rpc_clnt *clnt,
+			    struct nfs_server *server,
+			    struct rpc_message *msg,
+			    struct nfs4_sequence_args *args,
+			    struct nfs4_sequence_res *res)
 {
 	unsigned short task_flags = 0;
 
@@ -8248,58 +8248,6 @@ int nfs4_proc_fs_locations(struct rpc_clnt *client, struct inode *dir,
 	return err;
 }
 
-/*
- * This operation also signals the server that this client is
- * performing migration recovery.  The server can stop returning
- * NFS4ERR_LEASE_MOVED to this client.  A RENEW operation is
- * appended to this compound to identify the client ID which is
- * performing recovery.
- */
-static int _nfs40_proc_get_locations(struct nfs_server *server,
-				     struct nfs_fh *fhandle,
-				     struct nfs4_fs_locations *locations,
-				     struct page *page, const struct cred *cred)
-{
-	struct rpc_clnt *clnt = server->client;
-	u32 bitmask[2] = {
-		[0] = FATTR4_WORD0_FSID | FATTR4_WORD0_FS_LOCATIONS,
-	};
-	struct nfs4_fs_locations_arg args = {
-		.clientid	= server->nfs_client->cl_clientid,
-		.fh		= fhandle,
-		.page		= page,
-		.bitmask	= bitmask,
-		.migration	= 1,		/* skip LOOKUP */
-		.renew		= 1,		/* append RENEW */
-	};
-	struct nfs4_fs_locations_res res = {
-		.fs_locations	= locations,
-		.migration	= 1,
-		.renew		= 1,
-	};
-	struct rpc_message msg = {
-		.rpc_proc	= &nfs4_procedures[NFSPROC4_CLNT_FS_LOCATIONS],
-		.rpc_argp	= &args,
-		.rpc_resp	= &res,
-		.rpc_cred	= cred,
-	};
-	unsigned long now = jiffies;
-	int status;
-
-	nfs_fattr_init(locations->fattr);
-	locations->server = server;
-	locations->nlocations = 0;
-
-	nfs4_init_sequence(&args.seq_args, &res.seq_res, 0, 1);
-	status = nfs4_call_sync_sequence(clnt, server, &msg,
-					&args.seq_args, &res.seq_res);
-	if (status)
-		return status;
-
-	renew_lease(server, now);
-	return 0;
-}
-
 #ifdef CONFIG_NFS_V4_1
 
 /*
@@ -8412,50 +8360,6 @@ int nfs4_proc_get_locations(struct nfs_server *server,
 	return status;
 }
 
-/*
- * This operation also signals the server that this client is
- * performing "lease moved" recovery.  The server can stop
- * returning NFS4ERR_LEASE_MOVED to this client.  A RENEW operation
- * is appended to this compound to identify the client ID which is
- * performing recovery.
- */
-static int _nfs40_proc_fsid_present(struct inode *inode, const struct cred *cred)
-{
-	struct nfs_server *server = NFS_SERVER(inode);
-	struct nfs_client *clp = NFS_SERVER(inode)->nfs_client;
-	struct rpc_clnt *clnt = server->client;
-	struct nfs4_fsid_present_arg args = {
-		.fh		= NFS_FH(inode),
-		.clientid	= clp->cl_clientid,
-		.renew		= 1,		/* append RENEW */
-	};
-	struct nfs4_fsid_present_res res = {
-		.renew		= 1,
-	};
-	struct rpc_message msg = {
-		.rpc_proc	= &nfs4_procedures[NFSPROC4_CLNT_FSID_PRESENT],
-		.rpc_argp	= &args,
-		.rpc_resp	= &res,
-		.rpc_cred	= cred,
-	};
-	unsigned long now = jiffies;
-	int status;
-
-	res.fh = nfs_alloc_fhandle();
-	if (res.fh == NULL)
-		return -ENOMEM;
-
-	nfs4_init_sequence(&args.seq_args, &res.seq_res, 0, 1);
-	status = nfs4_call_sync_sequence(clnt, server, &msg,
-						&args.seq_args, &res.seq_res);
-	nfs_free_fhandle(res.fh);
-	if (status)
-		return status;
-
-	do_renew_lease(clp, now);
-	return 0;
-}
-
 #ifdef CONFIG_NFS_V4_1
 
 /*
@@ -10691,14 +10595,7 @@ static const struct nfs4_state_maintenance_ops nfs41_state_renewal_ops = {
 	.get_state_renewal_cred = nfs4_get_machine_cred,
 	.renew_lease = nfs4_proc_sequence,
 };
-#endif
 
-static const struct nfs4_mig_recovery_ops nfs40_mig_recovery_ops = {
-	.get_locations = _nfs40_proc_get_locations,
-	.fsid_present = _nfs40_proc_fsid_present,
-};
-
-#if defined(CONFIG_NFS_V4_1)
 static const struct nfs4_mig_recovery_ops nfs41_mig_recovery_ops = {
 	.get_locations = _nfs41_proc_get_locations,
 	.fsid_present = _nfs41_proc_fsid_present,
-- 
2.52.0



Return-Path: <linux-nfs+bounces-18516-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OMQ5AWXRd2mFlwEAu9opvQ
	(envelope-from <linux-nfs+bounces-18516-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Mon, 26 Jan 2026 21:41:09 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A19248D2D4
	for <lists+linux-nfs@lfdr.de>; Mon, 26 Jan 2026 21:41:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A1375304B4D5
	for <lists+linux-nfs@lfdr.de>; Mon, 26 Jan 2026 20:39:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 585D22D6E74;
	Mon, 26 Jan 2026 20:39:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EYI8Qg+t"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35EC528468E
	for <linux-nfs@vger.kernel.org>; Mon, 26 Jan 2026 20:39:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769459982; cv=none; b=VJSCJlQ3dcyFpBlv6b0LLHRJgiFxjWFVWRwKlMVsWP+4/XKGOFn12asl3VgBaa+icXt3vqcOGbCBdGclLTFPX9epq2z/dn+bVYLWlhi3DritBRKkeicD6C6d0FUuwoq3XYShSw4RwjAuLP/QUYzz5/jPXnJeqWBn84Truk+YyP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769459982; c=relaxed/simple;
	bh=iF1uj3GsQmN9LkIE+OkgoRYuzy3HdgOgyL1WTecATeg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=W9YTt+Wo+lBWs9RRWnb/M1KNe75vq7wT/bprXak2NIRKSkI/2zZdhv4qmzSmg+eaeZulbNBbrcT3uG0qtAsT2ko8xpUxdOWAy8dfop/NChMPicGX9rjexiHglrrVNmdex40e1KaAVBl+U4sC/P34q2O240w6Vn1qO3+Z1NcEFvs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EYI8Qg+t; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2B85C2BC86;
	Mon, 26 Jan 2026 20:39:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769459982;
	bh=iF1uj3GsQmN9LkIE+OkgoRYuzy3HdgOgyL1WTecATeg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=EYI8Qg+tOpPwFDIYFgFjFlgX5567FtNcQ1Xjjkfkayp2mZYe1LTPp0gJp99oiqBwG
	 0f04sqnPbHSuHWOex6BiPkNo6dM84EoonnS1h0nCOIQhwFQ4T8w9T5tMLgrprcK8gC
	 GYI4b33nG9/2B0va0HIgLSSExfwq9l5k1OAiVqSP22oHn0rlKvgkroktafSgDkhgMt
	 j8BhBVJkXpKmzMVn4Mc0ILedF2YpFsYVx+uiNfWPQoVVMe9XrIGaCEtmEzDkQn5Vjd
	 TZ/ZiSRm7Dv73fMag23sZ3zg9X3tVtNdHJTfT+4beE1ZWx0ZTKkw8C3WF7ytJeZYkv
	 s4jsmLJ1e3osg==
From: Anna Schumaker <anna@kernel.org>
To: linux-nfs@vger.kernel.org,
	trond.myklebust@hammerspace.com
Cc: anna@kernel.org
Subject: [PATCH v2 05/14] NFS: Split out the nfs40_mig_recovery_ops to nfs40proc.c
Date: Mon, 26 Jan 2026 15:39:29 -0500
Message-ID: <20260126203938.450304-6-anna@kernel.org>
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
	TAGGED_FROM(0.00)[bounces-18516-lists,linux-nfs=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[oracle.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: A19248D2D4
X-Rspamd-Action: no action

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
index eb89d57a9289..7f1fde3023a5 100644
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
index a52e985149bf..68c2925c404f 100644
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
 
@@ -8258,58 +8258,6 @@ int nfs4_proc_fs_locations(struct rpc_clnt *client, struct inode *dir,
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
@@ -8422,50 +8370,6 @@ int nfs4_proc_get_locations(struct nfs_server *server,
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
@@ -10701,14 +10605,7 @@ static const struct nfs4_state_maintenance_ops nfs41_state_renewal_ops = {
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



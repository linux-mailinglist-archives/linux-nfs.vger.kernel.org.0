Return-Path: <linux-nfs+bounces-18517-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mPIDK2jRd2mxlQEAu9opvQ
	(envelope-from <linux-nfs+bounces-18517-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Mon, 26 Jan 2026 21:41:12 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B2F68D2DB
	for <lists+linux-nfs@lfdr.de>; Mon, 26 Jan 2026 21:41:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0094D304C636
	for <lists+linux-nfs@lfdr.de>; Mon, 26 Jan 2026 20:39:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D137D28468E;
	Mon, 26 Jan 2026 20:39:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KcAljuG/"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF6062D73AD
	for <linux-nfs@vger.kernel.org>; Mon, 26 Jan 2026 20:39:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769459982; cv=none; b=GdeOjVMczcOMeWSvgo2wgmdVKzQd9//NHz3ItPUr8Y6+I6OCWBrUsxbgxP9dSdhaBZWOJQvvDolufGp9fKHkWV7UGZuF8uvRm93v1tSzFjIf1FaMW2WUEuIaE270R+bMlbLVspV1mvkzu0ZK2iFAqGcYm4wDjHkyiSB1iqHh3UI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769459982; c=relaxed/simple;
	bh=RFyVefNIGkmZ8P9N13Vo9YJpv3AWz25TXyQq2vY9IP8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OtIGRV/j6lhFVqcrwUKVJjy+Usp/v9W0LBzGvbkUSkTKvwah1FzmRL6tP/gF2hSYfFGA0iSpBiBOAaYOp6nzCx3RxF12kXvOgQaHvbKpkHC5RL/uqZGaq9LsFIPtlHgcnP6f2YilxC5tXipw0K8/7KoC7q3aKHYudN2pFHHsvKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KcAljuG/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C6A1C19422;
	Mon, 26 Jan 2026 20:39:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769459982;
	bh=RFyVefNIGkmZ8P9N13Vo9YJpv3AWz25TXyQq2vY9IP8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KcAljuG/DzA1e58euEg2Ulml/52XYAo3YpBYjrYt/o4kB7Ced3X2/ivNLSF25RPqH
	 pBS4aTydcuOH/SpXeSa9rDwknPkjT8lskWB9NLK0/JVdGYv2B8Byp1OPZTr30ePlFM
	 lj/skiMYiuO9/gNKeCURvu4pya7iLdzCbEK3MwGDF1yZsNRzD23fa1+IMr1mAt9zIx
	 qef+Qt3n3BEv1bl9fEk3tYBikJYHWQiBsdaOkpLKIYgC0fMh8pfMjgJLeZYT6Ga5xt
	 1JuZK6fmF8/afdBejI3hrV/1MbUm8ro+5LDfqhvPUpHbBe1gAeoJAECe86DcB2XAky
	 2Mg5w4N3LFu1g==
From: Anna Schumaker <anna@kernel.org>
To: linux-nfs@vger.kernel.org,
	trond.myklebust@hammerspace.com
Cc: anna@kernel.org
Subject: [PATCH v2 06/14] NFS: Move the NFS v4.0 minor version ops into nfs40proc.c
Date: Mon, 26 Jan 2026 15:39:30 -0500
Message-ID: <20260126203938.450304-7-anna@kernel.org>
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
	TAGGED_FROM(0.00)[bounces-18517-lists,linux-nfs=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[anna@kernel.org,linux-nfs@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[3];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	NEURAL_HAM(-0.00)[-0.999];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,oracle.com:email]
X-Rspamd-Queue-Id: 4B2F68D2DB
X-Rspamd-Action: no action

From: Anna Schumaker <anna.schumaker@oracle.com>

Signed-off-by: Anna Schumaker <anna.schumaker@oracle.com>
---
 fs/nfs/nfs40.h     |   1 +
 fs/nfs/nfs40proc.c | 106 +++++++++++++++++++++++++++++++++++++++++
 fs/nfs/nfs4_fs.h   |   4 ++
 fs/nfs/nfs4proc.c  | 115 ++-------------------------------------------
 4 files changed, 115 insertions(+), 111 deletions(-)

diff --git a/fs/nfs/nfs40.h b/fs/nfs/nfs40.h
index a04fb2390fa7..05ba9f1afe7c 100644
--- a/fs/nfs/nfs40.h
+++ b/fs/nfs/nfs40.h
@@ -9,6 +9,7 @@ extern const struct nfs4_state_recovery_ops nfs40_reboot_recovery_ops;
 extern const struct nfs4_state_recovery_ops nfs40_nograce_recovery_ops;
 extern const struct nfs4_state_maintenance_ops nfs40_state_renewal_ops;
 extern const struct nfs4_mig_recovery_ops nfs40_mig_recovery_ops;
+extern const struct nfs4_minor_version_ops nfs_v4_0_minor_ops;
 
 /* nfs40state.c */
 int nfs40_discover_server_trunking(struct nfs_client *clp,
diff --git a/fs/nfs/nfs40proc.c b/fs/nfs/nfs40proc.c
index 736e782a27e1..36802f9b94b5 100644
--- a/fs/nfs/nfs40proc.c
+++ b/fs/nfs/nfs40proc.c
@@ -126,6 +126,13 @@ static int nfs4_proc_renew(struct nfs_client *clp, const struct cred *cred)
 	return 0;
 }
 
+static int nfs40_test_and_free_expired_stateid(struct nfs_server *server,
+					       nfs4_stateid *stateid,
+					       const struct cred *cred)
+{
+	return -NFS4ERR_BAD_STATEID;
+}
+
 /*
  * This operation also signals the server that this client is
  * performing migration recovery.  The server can stop returning
@@ -222,6 +229,86 @@ static int _nfs40_proc_fsid_present(struct inode *inode, const struct cred *cred
 	return 0;
 }
 
+struct nfs_release_lockowner_data {
+	struct nfs4_lock_state *lsp;
+	struct nfs_server *server;
+	struct nfs_release_lockowner_args args;
+	struct nfs_release_lockowner_res res;
+	unsigned long timestamp;
+};
+
+static void nfs4_release_lockowner_prepare(struct rpc_task *task, void *calldata)
+{
+	struct nfs_release_lockowner_data *data = calldata;
+	struct nfs_server *server = data->server;
+	nfs4_setup_sequence(server->nfs_client, &data->args.seq_args,
+			   &data->res.seq_res, task);
+	data->args.lock_owner.clientid = server->nfs_client->cl_clientid;
+	data->timestamp = jiffies;
+}
+
+static void nfs4_release_lockowner_done(struct rpc_task *task, void *calldata)
+{
+	struct nfs_release_lockowner_data *data = calldata;
+	struct nfs_server *server = data->server;
+
+	nfs40_sequence_done(task, &data->res.seq_res);
+
+	switch (task->tk_status) {
+	case 0:
+		renew_lease(server, data->timestamp);
+		break;
+	case -NFS4ERR_STALE_CLIENTID:
+	case -NFS4ERR_EXPIRED:
+		nfs4_schedule_lease_recovery(server->nfs_client);
+		break;
+	case -NFS4ERR_LEASE_MOVED:
+	case -NFS4ERR_DELAY:
+		if (nfs4_async_handle_error(task, server,
+					    NULL, NULL) == -EAGAIN)
+			rpc_restart_call_prepare(task);
+	}
+}
+
+static void nfs4_release_lockowner_release(void *calldata)
+{
+	struct nfs_release_lockowner_data *data = calldata;
+	nfs4_free_lock_state(data->server, data->lsp);
+	kfree(calldata);
+}
+
+static const struct rpc_call_ops nfs4_release_lockowner_ops = {
+	.rpc_call_prepare = nfs4_release_lockowner_prepare,
+	.rpc_call_done = nfs4_release_lockowner_done,
+	.rpc_release = nfs4_release_lockowner_release,
+};
+
+static void
+nfs4_release_lockowner(struct nfs_server *server, struct nfs4_lock_state *lsp)
+{
+	struct nfs_release_lockowner_data *data;
+	struct rpc_message msg = {
+		.rpc_proc = &nfs4_procedures[NFSPROC4_CLNT_RELEASE_LOCKOWNER],
+	};
+
+	if (server->nfs_client->cl_mvops->minor_version != 0)
+		return;
+
+	data = kmalloc(sizeof(*data), GFP_KERNEL);
+	if (!data)
+		return;
+	data->lsp = lsp;
+	data->server = server;
+	data->args.lock_owner.clientid = server->nfs_client->cl_clientid;
+	data->args.lock_owner.id = lsp->ls_seqid.owner_id;
+	data->args.lock_owner.s_dev = server->s_dev;
+
+	msg.rpc_argp = &data->args;
+	msg.rpc_resp = &data->res;
+	nfs4_init_sequence(&data->args.seq_args, &data->res.seq_res, 0, 0);
+	rpc_call_async(server->client, &msg, 0, &nfs4_release_lockowner_ops, data);
+}
+
 const struct rpc_call_ops nfs40_call_sync_ops = {
 	.rpc_call_prepare = nfs40_call_sync_prepare,
 	.rpc_call_done = nfs40_call_sync_done,
@@ -254,3 +341,22 @@ const struct nfs4_mig_recovery_ops nfs40_mig_recovery_ops = {
 	.get_locations = _nfs40_proc_get_locations,
 	.fsid_present = _nfs40_proc_fsid_present,
 };
+
+const struct nfs4_minor_version_ops nfs_v4_0_minor_ops = {
+	.minor_version = 0,
+	.init_caps = NFS_CAP_READDIRPLUS
+		| NFS_CAP_ATOMIC_OPEN
+		| NFS_CAP_POSIX_LOCK,
+	.init_client = nfs40_init_client,
+	.shutdown_client = nfs40_shutdown_client,
+	.match_stateid = nfs4_match_stateid,
+	.find_root_sec = nfs4_find_root_sec,
+	.free_lock_state = nfs4_release_lockowner,
+	.test_and_free_expired = nfs40_test_and_free_expired_stateid,
+	.alloc_seqid = nfs_alloc_seqid,
+	.call_sync_ops = &nfs40_call_sync_ops,
+	.reboot_recovery_ops = &nfs40_reboot_recovery_ops,
+	.nograce_recovery_ops = &nfs40_nograce_recovery_ops,
+	.state_renewal_ops = &nfs40_state_renewal_ops,
+	.mig_recovery_ops = &nfs40_mig_recovery_ops,
+};
diff --git a/fs/nfs/nfs4_fs.h b/fs/nfs/nfs4_fs.h
index 7f1fde3023a5..333dd0774517 100644
--- a/fs/nfs/nfs4_fs.h
+++ b/fs/nfs/nfs4_fs.h
@@ -310,6 +310,7 @@ extern int nfs4_call_sync_sequence(struct rpc_clnt *clnt,
 				   struct nfs4_sequence_args *args,
 				   struct nfs4_sequence_res *res);
 extern void nfs4_init_sequence(struct nfs4_sequence_args *, struct nfs4_sequence_res *, int, int);
+extern int nfs40_sequence_done(struct rpc_task *task, struct nfs4_sequence_res *res);
 extern int nfs4_proc_setclientid(struct nfs_client *, u32, unsigned short, const struct cred *, struct nfs4_setclientid_res *);
 extern int nfs4_proc_setclientid_confirm(struct nfs_client *, struct nfs4_setclientid_res *arg, const struct cred *);
 extern void renew_lease(const struct nfs_server *server, unsigned long timestamp);
@@ -365,6 +366,9 @@ extern void nfs_finish_clear_delegation_stateid(struct nfs4_state *state,
 						const nfs4_stateid *stateid);
 extern void nfs_state_clear_open_state_flags(struct nfs4_state *state);
 extern void do_renew_lease(struct nfs_client *clp, unsigned long timestamp);
+extern bool nfs4_match_stateid(const nfs4_stateid *s1, const nfs4_stateid *s2);
+extern int nfs4_find_root_sec(struct nfs_server *server, struct nfs_fh *fhandle,
+			      struct nfs_fattr *fattr);
 
 #if defined(CONFIG_NFS_V4_1)
 extern int nfs41_sequence_done(struct rpc_task *, struct nfs4_sequence_res *);
diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
index 68c2925c404f..86ab868a6422 100644
--- a/fs/nfs/nfs4proc.c
+++ b/fs/nfs/nfs4proc.c
@@ -795,8 +795,8 @@ static void nfs40_sequence_free_slot(struct nfs4_sequence_res *res)
 	res->sr_slot = NULL;
 }
 
-static int nfs40_sequence_done(struct rpc_task *task,
-			       struct nfs4_sequence_res *res)
+int nfs40_sequence_done(struct rpc_task *task,
+			struct nfs4_sequence_res *res)
 {
 	if (res->sr_slot != NULL)
 		nfs40_sequence_free_slot(res);
@@ -2882,12 +2882,6 @@ void nfs_finish_clear_delegation_stateid(struct nfs4_state *state,
 	nfs_state_clear_delegation(state);
 }
 
-static int nfs40_test_and_free_expired_stateid(struct nfs_server *server,
-					       nfs4_stateid *stateid, const struct cred *cred)
-{
-	return -NFS4ERR_BAD_STATEID;
-}
-
 #if defined(CONFIG_NFS_V4_1)
 static int nfs41_test_and_free_expired_stateid(struct nfs_server *server,
 					       nfs4_stateid *stateid, const struct cred *cred)
@@ -4289,7 +4283,7 @@ static int nfs4_lookup_root_sec(struct nfs_server *server,
  * Returns zero on success, or a negative NFS4ERR value, or a
  * negative errno value.
  */
-static int nfs4_find_root_sec(struct nfs_server *server, struct nfs_fh *fhandle,
+int nfs4_find_root_sec(struct nfs_server *server, struct nfs_fh *fhandle,
 			      struct nfs_fattr *fattr)
 {
 	/* Per 3530bis 15.33.5 */
@@ -7868,86 +7862,6 @@ int nfs4_lock_delegation_recall(struct file_lock *fl, struct nfs4_state *state,
 	return nfs4_handle_delegation_recall_error(server, state, stateid, fl, err);
 }
 
-struct nfs_release_lockowner_data {
-	struct nfs4_lock_state *lsp;
-	struct nfs_server *server;
-	struct nfs_release_lockowner_args args;
-	struct nfs_release_lockowner_res res;
-	unsigned long timestamp;
-};
-
-static void nfs4_release_lockowner_prepare(struct rpc_task *task, void *calldata)
-{
-	struct nfs_release_lockowner_data *data = calldata;
-	struct nfs_server *server = data->server;
-	nfs4_setup_sequence(server->nfs_client, &data->args.seq_args,
-			   &data->res.seq_res, task);
-	data->args.lock_owner.clientid = server->nfs_client->cl_clientid;
-	data->timestamp = jiffies;
-}
-
-static void nfs4_release_lockowner_done(struct rpc_task *task, void *calldata)
-{
-	struct nfs_release_lockowner_data *data = calldata;
-	struct nfs_server *server = data->server;
-
-	nfs40_sequence_done(task, &data->res.seq_res);
-
-	switch (task->tk_status) {
-	case 0:
-		renew_lease(server, data->timestamp);
-		break;
-	case -NFS4ERR_STALE_CLIENTID:
-	case -NFS4ERR_EXPIRED:
-		nfs4_schedule_lease_recovery(server->nfs_client);
-		break;
-	case -NFS4ERR_LEASE_MOVED:
-	case -NFS4ERR_DELAY:
-		if (nfs4_async_handle_error(task, server,
-					    NULL, NULL) == -EAGAIN)
-			rpc_restart_call_prepare(task);
-	}
-}
-
-static void nfs4_release_lockowner_release(void *calldata)
-{
-	struct nfs_release_lockowner_data *data = calldata;
-	nfs4_free_lock_state(data->server, data->lsp);
-	kfree(calldata);
-}
-
-static const struct rpc_call_ops nfs4_release_lockowner_ops = {
-	.rpc_call_prepare = nfs4_release_lockowner_prepare,
-	.rpc_call_done = nfs4_release_lockowner_done,
-	.rpc_release = nfs4_release_lockowner_release,
-};
-
-static void
-nfs4_release_lockowner(struct nfs_server *server, struct nfs4_lock_state *lsp)
-{
-	struct nfs_release_lockowner_data *data;
-	struct rpc_message msg = {
-		.rpc_proc = &nfs4_procedures[NFSPROC4_CLNT_RELEASE_LOCKOWNER],
-	};
-
-	if (server->nfs_client->cl_mvops->minor_version != 0)
-		return;
-
-	data = kmalloc(sizeof(*data), GFP_KERNEL);
-	if (!data)
-		return;
-	data->lsp = lsp;
-	data->server = server;
-	data->args.lock_owner.clientid = server->nfs_client->cl_clientid;
-	data->args.lock_owner.id = lsp->ls_seqid.owner_id;
-	data->args.lock_owner.s_dev = server->s_dev;
-
-	msg.rpc_argp = &data->args;
-	msg.rpc_resp = &data->res;
-	nfs4_init_sequence(&data->args.seq_args, &data->res.seq_res, 0, 0);
-	rpc_call_async(server->client, &msg, 0, &nfs4_release_lockowner_ops, data);
-}
-
 #define XATTR_NAME_NFSV4_ACL "system.nfs4_acl"
 
 static int nfs4_xattr_set_nfs4_acl(const struct xattr_handler *handler,
@@ -10572,7 +10486,7 @@ static bool nfs41_match_stateid(const nfs4_stateid *s1,
 
 #endif /* CONFIG_NFS_V4_1 */
 
-static bool nfs4_match_stateid(const nfs4_stateid *s1,
+bool nfs4_match_stateid(const nfs4_stateid *s1,
 		const nfs4_stateid *s2)
 {
 	trace_nfs4_match_stateid(s1, s2);
@@ -10610,28 +10524,7 @@ static const struct nfs4_mig_recovery_ops nfs41_mig_recovery_ops = {
 	.get_locations = _nfs41_proc_get_locations,
 	.fsid_present = _nfs41_proc_fsid_present,
 };
-#endif	/* CONFIG_NFS_V4_1 */
 
-static const struct nfs4_minor_version_ops nfs_v4_0_minor_ops = {
-	.minor_version = 0,
-	.init_caps = NFS_CAP_READDIRPLUS
-		| NFS_CAP_ATOMIC_OPEN
-		| NFS_CAP_POSIX_LOCK,
-	.init_client = nfs40_init_client,
-	.shutdown_client = nfs40_shutdown_client,
-	.match_stateid = nfs4_match_stateid,
-	.find_root_sec = nfs4_find_root_sec,
-	.free_lock_state = nfs4_release_lockowner,
-	.test_and_free_expired = nfs40_test_and_free_expired_stateid,
-	.alloc_seqid = nfs_alloc_seqid,
-	.call_sync_ops = &nfs40_call_sync_ops,
-	.reboot_recovery_ops = &nfs40_reboot_recovery_ops,
-	.nograce_recovery_ops = &nfs40_nograce_recovery_ops,
-	.state_renewal_ops = &nfs40_state_renewal_ops,
-	.mig_recovery_ops = &nfs40_mig_recovery_ops,
-};
-
-#if defined(CONFIG_NFS_V4_1)
 static struct nfs_seqid *
 nfs_alloc_no_seqid(struct nfs_seqid_counter *arg1, gfp_t arg2)
 {
-- 
2.52.0



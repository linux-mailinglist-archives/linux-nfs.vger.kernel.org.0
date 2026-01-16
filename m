Return-Path: <linux-nfs+bounces-18062-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EF56D38903
	for <lists+linux-nfs@lfdr.de>; Fri, 16 Jan 2026 22:53:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 142213103C1B
	for <lists+linux-nfs@lfdr.de>; Fri, 16 Jan 2026 21:51:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E2BA301004;
	Fri, 16 Jan 2026 21:51:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kYjCkaNe"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B6542FD69D
	for <linux-nfs@vger.kernel.org>; Fri, 16 Jan 2026 21:51:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768600303; cv=none; b=Ojrk2CLMRrk40LDCa0dIkanlxKdwU1wXVTSDY4vUHdvOGH9uiHDS2DFKaLkeyfM08nzHwX3mvEb1QAqvQ5Agq/jT8hLjGKi9HHAh3n/p8HEygmEPDmIE2vNQIvfVXtSLAiUOHQsj/Gxdz0QS9Tc0bviQUJwiqfMXR11AdB7SWDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768600303; c=relaxed/simple;
	bh=A6laMAZzc4SEeXIZaqG9l8Q//ak6Beqf6eYDjPlvGMc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dleg1lv7xZgcHri30qg0qexzgeRtiq/uDn7ISg+uNOmWYeVaxfh0g870yyT+TO7AXEOLLYyHos9+nAuThgI+/ZfGQV4CLXsuaekUi8F+fsCmMy/gd6PKlUtHExJsq1RnFG8oEFYK9LPvEpZcXoPWJg4l0hRRn7VjV8tuex3SvxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kYjCkaNe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 041EEC19422;
	Fri, 16 Jan 2026 21:51:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768600302;
	bh=A6laMAZzc4SEeXIZaqG9l8Q//ak6Beqf6eYDjPlvGMc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kYjCkaNebPOm3riyT+6/6mGJbthTYPfhO3dC5CWiLQbUT26dX+zDhqwiZjXYKyW4X
	 OIfd2nLS5gjMif0eNLGK+3H20mbEF7Lw4nlZZ1W2BRyR5R/6WaY9C/r0qUgM9j1Tu0
	 l9K+W8nG7Jho+LqJl+UBHcZ5XAlP6dHbukiJaWMVvPTAJEfK62rQg6L3bE5zNFag8u
	 oAmJ6TUqNeABpRfrh3LzrXXiK5k5I6G28aOLS4SSdrbAploSoPqJqbmnXfkPjxiREq
	 e4UpKP+agmb187JuVQ4l7OgXSG9P6Ih3ttlDbQhkMPtsbbVrFL4tFsCjZ0mNJk5Y9J
	 on4j6lFMqBnSQ==
From: Anna Schumaker <anna@kernel.org>
To: linux-nfs@vger.kernel.org,
	trond.myklebust@hammerspace.com
Cc: anna@kernel.org
Subject: [PATCH v1 11/14] NFS: Pass a struct nfs_client to nfs4_init_sequence()
Date: Fri, 16 Jan 2026 16:51:32 -0500
Message-ID: <20260116215135.846062-12-anna@kernel.org>
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

No functional change in this patch. This just makes the next patch where
I introduce "sequence slot operations" simpler.

Signed-off-by: Anna Schumaker <anna.schumaker@oracle.com>
---
 fs/nfs/nfs40proc.c |  14 ++---
 fs/nfs/nfs42proc.c |  13 +++--
 fs/nfs/nfs4_fs.h   |   3 +-
 fs/nfs/nfs4proc.c  | 126 +++++++++++++++++++++++++--------------------
 4 files changed, 87 insertions(+), 69 deletions(-)

diff --git a/fs/nfs/nfs40proc.c b/fs/nfs/nfs40proc.c
index 0399e2e68c6b..9b5b57170471 100644
--- a/fs/nfs/nfs40proc.c
+++ b/fs/nfs/nfs40proc.c
@@ -147,11 +147,12 @@ static int _nfs40_proc_get_locations(struct nfs_server *server,
 				     struct page *page, const struct cred *cred)
 {
 	struct rpc_clnt *clnt = server->client;
+	struct nfs_client *clp = server->nfs_client;
 	u32 bitmask[2] = {
 		[0] = FATTR4_WORD0_FSID | FATTR4_WORD0_FS_LOCATIONS,
 	};
 	struct nfs4_fs_locations_arg args = {
-		.clientid	= server->nfs_client->cl_clientid,
+		.clientid	= clp->cl_clientid,
 		.fh		= fhandle,
 		.page		= page,
 		.bitmask	= bitmask,
@@ -176,7 +177,7 @@ static int _nfs40_proc_get_locations(struct nfs_server *server,
 	locations->server = server;
 	locations->nlocations = 0;
 
-	nfs4_init_sequence(&args.seq_args, &res.seq_res, 0, 1);
+	nfs4_init_sequence(clp, &args.seq_args, &res.seq_res, 0, 1);
 	status = nfs4_call_sync_sequence(clnt, server, &msg,
 					&args.seq_args, &res.seq_res);
 	if (status)
@@ -219,7 +220,7 @@ static int _nfs40_proc_fsid_present(struct inode *inode, const struct cred *cred
 	if (res.fh == NULL)
 		return -ENOMEM;
 
-	nfs4_init_sequence(&args.seq_args, &res.seq_res, 0, 1);
+	nfs4_init_sequence(clp, &args.seq_args, &res.seq_res, 0, 1);
 	status = nfs4_call_sync_sequence(clnt, server, &msg,
 						&args.seq_args, &res.seq_res);
 	nfs_free_fhandle(res.fh);
@@ -288,11 +289,12 @@ static void
 nfs4_release_lockowner(struct nfs_server *server, struct nfs4_lock_state *lsp)
 {
 	struct nfs_release_lockowner_data *data;
+	struct nfs_client *clp = server->nfs_client;
 	struct rpc_message msg = {
 		.rpc_proc = &nfs4_procedures[NFSPROC4_CLNT_RELEASE_LOCKOWNER],
 	};
 
-	if (server->nfs_client->cl_mvops->minor_version != 0)
+	if (clp->cl_mvops->minor_version != 0)
 		return;
 
 	data = kmalloc(sizeof(*data), GFP_KERNEL);
@@ -300,13 +302,13 @@ nfs4_release_lockowner(struct nfs_server *server, struct nfs4_lock_state *lsp)
 		return;
 	data->lsp = lsp;
 	data->server = server;
-	data->args.lock_owner.clientid = server->nfs_client->cl_clientid;
+	data->args.lock_owner.clientid = clp->cl_clientid;
 	data->args.lock_owner.id = lsp->ls_seqid.owner_id;
 	data->args.lock_owner.s_dev = server->s_dev;
 
 	msg.rpc_argp = &data->args;
 	msg.rpc_resp = &data->res;
-	nfs4_init_sequence(&data->args.seq_args, &data->res.seq_res, 0, 0);
+	nfs4_init_sequence(clp, &data->args.seq_args, &data->res.seq_res, 0, 0);
 	rpc_call_async(server->client, &msg, 0, &nfs4_release_lockowner_ops, data);
 }
 
diff --git a/fs/nfs/nfs42proc.c b/fs/nfs/nfs42proc.c
index d537fb0c230e..d5b20dfe1cbf 100644
--- a/fs/nfs/nfs42proc.c
+++ b/fs/nfs/nfs42proc.c
@@ -661,8 +661,8 @@ static int nfs42_do_offload_cancel_async(struct file *dst,
 	msg.rpc_argp = &data->args;
 	msg.rpc_resp = &data->res;
 	task_setup_data.callback_data = data;
-	nfs4_init_sequence(&data->args.osa_seq_args, &data->res.osr_seq_res,
-			   1, 0);
+	nfs4_init_sequence(dst_server->nfs_client, &data->args.osa_seq_args,
+			   &data->res.osr_seq_res, 1, 0);
 	task = rpc_run_task(&task_setup_data);
 	if (IS_ERR(task))
 		return PTR_ERR(task);
@@ -1063,7 +1063,8 @@ int nfs42_proc_layoutstats_generic(struct nfs_server *server,
 		nfs42_layoutstat_release(data);
 		return -EAGAIN;
 	}
-	nfs4_init_sequence(&data->args.seq_args, &data->res.seq_res, 0, 0);
+	nfs4_init_sequence(server->nfs_client, &data->args.seq_args,
+			   &data->res.seq_res, 0, 0);
 	task = rpc_run_task(&task_setup);
 	if (IS_ERR(task))
 		return PTR_ERR(task);
@@ -1201,6 +1202,7 @@ int nfs42_proc_layouterror(struct pnfs_layout_segment *lseg,
 		const struct nfs42_layout_error *errors, size_t n)
 {
 	struct inode *inode = lseg->pls_layout->plh_inode;
+	struct nfs_server *server = NFS_SERVER(inode);
 	struct nfs42_layouterror_data *data;
 	struct rpc_task *task;
 	struct rpc_message msg = {
@@ -1228,8 +1230,9 @@ int nfs42_proc_layouterror(struct pnfs_layout_segment *lseg,
 	msg.rpc_argp = &data->args;
 	msg.rpc_resp = &data->res;
 	task_setup.callback_data = data;
-	task_setup.rpc_client = NFS_SERVER(inode)->client;
-	nfs4_init_sequence(&data->args.seq_args, &data->res.seq_res, 0, 0);
+	task_setup.rpc_client = server->client;
+	nfs4_init_sequence(server->nfs_client, &data->args.seq_args,
+			   &data->res.seq_res, 0, 0);
 	task = rpc_run_task(&task_setup);
 	if (IS_ERR(task))
 		return PTR_ERR(task);
diff --git a/fs/nfs/nfs4_fs.h b/fs/nfs/nfs4_fs.h
index 9d0bec3a23f3..34cdbf42b865 100644
--- a/fs/nfs/nfs4_fs.h
+++ b/fs/nfs/nfs4_fs.h
@@ -309,7 +309,8 @@ extern int nfs4_call_sync_sequence(struct rpc_clnt *clnt,
 				   struct rpc_message *msg,
 				   struct nfs4_sequence_args *args,
 				   struct nfs4_sequence_res *res);
-extern void nfs4_init_sequence(struct nfs4_sequence_args *, struct nfs4_sequence_res *, int, int);
+extern void nfs4_init_sequence(struct nfs_client *clp, struct nfs4_sequence_args *,
+			       struct nfs4_sequence_res *, int, int);
 extern int nfs40_sequence_done(struct rpc_task *task, struct nfs4_sequence_res *res);
 extern int nfs4_proc_setclientid(struct nfs_client *, u32, unsigned short, const struct cred *, struct nfs4_setclientid_res *);
 extern int nfs4_proc_setclientid_confirm(struct nfs_client *, struct nfs4_setclientid_res *arg, const struct cred *);
diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
index 755bb26a98f9..27ed07c5f669 100644
--- a/fs/nfs/nfs4proc.c
+++ b/fs/nfs/nfs4proc.c
@@ -770,7 +770,8 @@ void renew_lease(const struct nfs_server *server, unsigned long timestamp)
 		do_renew_lease(clp, timestamp);
 }
 
-void nfs4_init_sequence(struct nfs4_sequence_args *args,
+void nfs4_init_sequence(struct nfs_client *clp,
+			struct nfs4_sequence_args *args,
 			struct nfs4_sequence_res *res, int cache_reply,
 			int privileged)
 {
@@ -1228,7 +1229,7 @@ int nfs4_call_sync(struct rpc_clnt *clnt,
 		   struct nfs4_sequence_res *res,
 		   int cache_reply)
 {
-	nfs4_init_sequence(args, res, cache_reply, 0);
+	nfs4_init_sequence(server->nfs_client, args, res, cache_reply, 0);
 	return nfs4_call_sync_sequence(clnt, server, msg, args, res);
 }
 
@@ -2500,8 +2501,8 @@ static int _nfs4_proc_open_confirm(struct nfs4_opendata *data)
 	};
 	int status;
 
-	nfs4_init_sequence(&data->c_arg.seq_args, &data->c_res.seq_res, 1,
-				data->is_recover);
+	nfs4_init_sequence(server->nfs_client, &data->c_arg.seq_args,
+			   &data->c_res.seq_res, 1, data->is_recover);
 	kref_get(&data->kref);
 	data->rpc_done = false;
 	data->rpc_status = 0;
@@ -2652,6 +2653,7 @@ static int nfs4_run_open_task(struct nfs4_opendata *data,
 {
 	struct inode *dir = d_inode(data->dir);
 	struct nfs_server *server = NFS_SERVER(dir);
+	struct nfs_client *clp = server->nfs_client;
 	struct nfs_openargs *o_arg = &data->o_arg;
 	struct nfs_openres *o_res = &data->o_res;
 	struct rpc_task *task;
@@ -2680,11 +2682,11 @@ static int nfs4_run_open_task(struct nfs4_opendata *data,
 	data->cancelled = false;
 	data->is_recover = false;
 	if (!ctx) {
-		nfs4_init_sequence(&o_arg->seq_args, &o_res->seq_res, 1, 1);
+		nfs4_init_sequence(clp, &o_arg->seq_args, &o_res->seq_res, 1, 1);
 		data->is_recover = true;
 		task_setup_data.flags |= RPC_TASK_TIMEOUT;
 	} else {
-		nfs4_init_sequence(&o_arg->seq_args, &o_res->seq_res, 1, 0);
+		nfs4_init_sequence(clp, &o_arg->seq_args, &o_res->seq_res, 1, 0);
 		pnfs_lgopen_prepare(data, ctx);
 	}
 	task = rpc_run_task(&task_setup_data);
@@ -3807,6 +3809,7 @@ static const struct rpc_call_ops nfs4_close_ops = {
 int nfs4_do_close(struct nfs4_state *state, gfp_t gfp_mask, int wait)
 {
 	struct nfs_server *server = NFS_SERVER(state->inode);
+	struct nfs_client *clp = server->nfs_client;
 	struct nfs_seqid *(*alloc_seqid)(struct nfs_seqid_counter *, gfp_t);
 	struct nfs4_closedata *calldata;
 	struct nfs4_state_owner *sp = state->owner;
@@ -3827,20 +3830,21 @@ int nfs4_do_close(struct nfs4_state *state, gfp_t gfp_mask, int wait)
 	if (nfs_server_capable(state->inode, NFS_CAP_MOVEABLE))
 		task_setup_data.flags |= RPC_TASK_MOVEABLE;
 
-	nfs4_state_protect(server->nfs_client, NFS_SP4_MACH_CRED_CLEANUP,
+	nfs4_state_protect(clp, NFS_SP4_MACH_CRED_CLEANUP,
 		&task_setup_data.rpc_client, &msg);
 
 	calldata = kzalloc(sizeof(*calldata), gfp_mask);
 	if (calldata == NULL)
 		goto out;
-	nfs4_init_sequence(&calldata->arg.seq_args, &calldata->res.seq_res, 1, 0);
+	nfs4_init_sequence(clp, &calldata->arg.seq_args,
+			   &calldata->res.seq_res, 1, 0);
 	calldata->inode = state->inode;
 	calldata->state = state;
 	calldata->arg.fh = NFS_FH(state->inode);
 	if (!nfs4_copy_open_stateid(&calldata->arg.stateid, state))
 		goto out_free_calldata;
 	/* Serialization for the sequence id */
-	alloc_seqid = server->nfs_client->cl_mvops->alloc_seqid;
+	alloc_seqid = clp->cl_mvops->alloc_seqid;
 	calldata->arg.seqid = alloc_seqid(&state->owner->so_seqid, gfp_mask);
 	if (IS_ERR(calldata->arg.seqid))
 		goto out_free_calldata;
@@ -4468,11 +4472,12 @@ static int _nfs4_proc_getattr(struct nfs_server *server, struct nfs_fh *fhandle,
 		.rpc_argp = &args,
 		.rpc_resp = &res,
 	};
+	struct nfs_client *clp = server->nfs_client;
 	struct nfs4_gdd_res gdd_res;
 	unsigned short task_flags = 0;
 	int status;
 
-	if (nfs4_has_session(server->nfs_client))
+	if (nfs4_has_session(clp))
 		task_flags = RPC_TASK_MOVEABLE;
 
 	/* Is this is an attribute revalidation, subject to softreval? */
@@ -4485,7 +4490,7 @@ static int _nfs4_proc_getattr(struct nfs_server *server, struct nfs_fh *fhandle,
 
 	nfs4_bitmap_copy_adjust(bitmask, nfs4_bitmask(server, fattr->label), inode, 0);
 	nfs_fattr_init(fattr);
-	nfs4_init_sequence(&args.seq_args, &res.seq_res, 0, 0);
+	nfs4_init_sequence(clp, &args.seq_args, &res.seq_res, 0, 0);
 
 	status = nfs4_do_call_sync(server->client, server, &msg,
 				   &args.seq_args, &res.seq_res, task_flags);
@@ -4624,7 +4629,7 @@ static int _nfs4_proc_lookup(struct rpc_clnt *clnt, struct inode *dir,
 	nfs_fattr_init(fattr);
 
 	dprintk("NFS call  lookup %pd2\n", dentry);
-	nfs4_init_sequence(&args.seq_args, &res.seq_res, 0, 0);
+	nfs4_init_sequence(server->nfs_client, &args.seq_args, &res.seq_res, 0, 0);
 	status = nfs4_do_call_sync(clnt, server, &msg,
 			&args.seq_args, &res.seq_res, task_flags);
 	dprintk("NFS reply lookup: %d\n", status);
@@ -4742,7 +4747,7 @@ static int _nfs4_proc_lookupp(struct inode *inode,
 	args.bitmask = nfs4_bitmask(server, fattr->label);
 
 	nfs_fattr_init(fattr);
-	nfs4_init_sequence(&args.seq_args, &res.seq_res, 0, 0);
+	nfs4_init_sequence(server->nfs_client, &args.seq_args, &res.seq_res, 0, 0);
 
 	dprintk("NFS call  lookupp ino=0x%lx\n", inode->i_ino);
 	status = nfs4_do_call_sync(clnt, server, &msg, &args.seq_args,
@@ -4987,10 +4992,12 @@ static void nfs4_proc_unlink_setup(struct rpc_message *msg,
 {
 	struct nfs_removeargs *args = msg->rpc_argp;
 	struct nfs_removeres *res = msg->rpc_resp;
+	struct nfs_server *server = NFS_SB(dentry->d_sb);
 
-	res->server = NFS_SB(dentry->d_sb);
+	res->server = server;
 	msg->rpc_proc = &nfs4_procedures[NFSPROC4_CLNT_REMOVE];
-	nfs4_init_sequence(&args->seq_args, &res->seq_res, 1, 0);
+	nfs4_init_sequence(server->nfs_client, &args->seq_args,
+			   &res->seq_res, 1, 0);
 
 	nfs_fattr_init(res->dir_attr);
 	nfs_request_directory_delegation(d_inode(dentry->d_parent));
@@ -5031,6 +5038,7 @@ static void nfs4_proc_rename_setup(struct rpc_message *msg,
 		struct dentry *new_dentry,
 		struct inode *same_parent)
 {
+	struct nfs_server *server = NFS_SB(old_dentry->d_sb);
 	struct nfs_renameargs *arg = msg->rpc_argp;
 	struct nfs_renameres *res = msg->rpc_resp;
 	struct inode *old_inode = d_inode(old_dentry);
@@ -5043,8 +5051,9 @@ static void nfs4_proc_rename_setup(struct rpc_message *msg,
 	if (same_parent)
 		nfs_request_directory_delegation(same_parent);
 	msg->rpc_proc = &nfs4_procedures[NFSPROC4_CLNT_RENAME];
-	res->server = NFS_SB(old_dentry->d_sb);
-	nfs4_init_sequence(&arg->seq_args, &res->seq_res, 1, 0);
+	res->server = server,
+	nfs4_init_sequence(server->nfs_client, &arg->seq_args,
+			   &res->seq_res, 1, 0);
 }
 
 static void nfs4_proc_rename_rpc_prepare(struct rpc_task *task, struct nfs_renamedata *data)
@@ -5712,7 +5721,8 @@ static void nfs4_proc_read_setup(struct nfs_pgio_header *hdr,
 		hdr->pgio_done_cb = nfs4_read_done_cb;
 	if (!nfs42_read_plus_support(hdr, msg))
 		msg->rpc_proc = &nfs4_procedures[NFSPROC4_CLNT_READ];
-	nfs4_init_sequence(&hdr->args.seq_args, &hdr->res.seq_res, 0, 0);
+	nfs4_init_sequence(NFS_SERVER(hdr->inode)->nfs_client,
+			   &hdr->args.seq_args, &hdr->res.seq_res, 0, 0);
 }
 
 static int nfs4_proc_pgio_rpc_prepare(struct rpc_task *task,
@@ -5854,7 +5864,8 @@ static void nfs4_proc_write_setup(struct nfs_pgio_header *hdr,
 	hdr->timestamp   = jiffies;
 
 	msg->rpc_proc = &nfs4_procedures[NFSPROC4_CLNT_WRITE];
-	nfs4_init_sequence(&hdr->args.seq_args, &hdr->res.seq_res, 0, 0);
+	nfs4_init_sequence(server->nfs_client, &hdr->args.seq_args,
+			   &hdr->res.seq_res, 0, 0);
 	nfs4_state_protect_write(hdr->ds_clp ? hdr->ds_clp : server->nfs_client, clnt, msg, hdr);
 }
 
@@ -5895,7 +5906,8 @@ static void nfs4_proc_commit_setup(struct nfs_commit_data *data, struct rpc_mess
 		data->commit_done_cb = nfs4_commit_done_cb;
 	data->res.server = server;
 	msg->rpc_proc = &nfs4_procedures[NFSPROC4_CLNT_COMMIT];
-	nfs4_init_sequence(&data->args.seq_args, &data->res.seq_res, 1, 0);
+	nfs4_init_sequence(server->nfs_client, &data->args.seq_args,
+			   &data->res.seq_res, 1, 0);
 	nfs4_state_protect(data->ds_clp ? data->ds_clp : server->nfs_client,
 			NFS_SP4_MACH_CRED_COMMIT, clnt, msg);
 }
@@ -6891,12 +6903,8 @@ static int _nfs4_proc_delegreturn(struct inode *inode, const struct cred *cred,
 		data->res.sattr_res = true;
 	}
 
-	if (!data->inode)
-		nfs4_init_sequence(&data->args.seq_args, &data->res.seq_res, 1,
-				   1);
-	else
-		nfs4_init_sequence(&data->args.seq_args, &data->res.seq_res, 1,
-				   0);
+	nfs4_init_sequence(server->nfs_client, &data->args.seq_args,
+			   &data->res.seq_res, 1, !data->inode ? 1 : 0);
 
 	task_setup_data.callback_data = data;
 	msg.rpc_argp = &data->args;
@@ -7175,6 +7183,7 @@ static struct rpc_task *nfs4_do_unlck(struct file_lock *fl,
 		struct nfs_seqid *seqid)
 {
 	struct nfs4_unlockdata *data;
+	struct nfs_client *clp = NFS_SERVER(lsp->ls_state->inode)->nfs_client;
 	struct rpc_message msg = {
 		.rpc_proc = &nfs4_procedures[NFSPROC4_CLNT_LOCKU],
 		.rpc_cred = ctx->cred,
@@ -7190,8 +7199,8 @@ static struct rpc_task *nfs4_do_unlck(struct file_lock *fl,
 	if (nfs_server_capable(lsp->ls_state->inode, NFS_CAP_MOVEABLE))
 		task_setup_data.flags |= RPC_TASK_MOVEABLE;
 
-	nfs4_state_protect(NFS_SERVER(lsp->ls_state->inode)->nfs_client,
-		NFS_SP4_MACH_CRED_CLEANUP, &task_setup_data.rpc_client, &msg);
+	nfs4_state_protect(clp, NFS_SP4_MACH_CRED_CLEANUP,
+			   &task_setup_data.rpc_client, &msg);
 
 	/* Ensure this is an unlock - when canceling a lock, the
 	 * canceled lock is passed in, and it won't be an unlock.
@@ -7206,7 +7215,7 @@ static struct rpc_task *nfs4_do_unlck(struct file_lock *fl,
 		return ERR_PTR(-ENOMEM);
 	}
 
-	nfs4_init_sequence(&data->arg.seq_args, &data->res.seq_res, 1, 0);
+	nfs4_init_sequence(clp, &data->arg.seq_args, &data->res.seq_res, 1, 0);
 	msg.rpc_argp = &data->arg;
 	msg.rpc_resp = &data->res;
 	task_setup_data.callback_data = data;
@@ -7456,6 +7465,7 @@ static int _nfs4_do_setlk(struct nfs4_state *state, int cmd, struct file_lock *f
 {
 	struct nfs4_lockdata *data;
 	struct rpc_task *task;
+	struct nfs_client *clp = NFS_SERVER(state->inode)->nfs_client;
 	struct rpc_message msg = {
 		.rpc_proc = &nfs4_procedures[NFSPROC4_CLNT_LOCK],
 		.rpc_cred = state->owner->so_cred,
@@ -7479,7 +7489,7 @@ static int _nfs4_do_setlk(struct nfs4_state *state, int cmd, struct file_lock *f
 		return -ENOMEM;
 	if (IS_SETLKW(cmd))
 		data->arg.block = 1;
-	nfs4_init_sequence(&data->arg.seq_args, &data->res.seq_res, 1,
+	nfs4_init_sequence(clp, &data->arg.seq_args, &data->res.seq_res, 1,
 				recovery_type > NFS_LOCK_NEW);
 	msg.rpc_argp = &data->arg;
 	msg.rpc_resp = &data->res;
@@ -8180,6 +8190,7 @@ static int _nfs41_proc_get_locations(struct nfs_server *server,
 				     struct page *page, const struct cred *cred)
 {
 	struct rpc_clnt *clnt = server->client;
+	struct nfs_client *clp = server->nfs_client;
 	u32 bitmask[2] = {
 		[0] = FATTR4_WORD0_FSID | FATTR4_WORD0_FS_LOCATIONS,
 	};
@@ -8207,7 +8218,7 @@ static int _nfs41_proc_get_locations(struct nfs_server *server,
 	struct rpc_task_setup task_setup_data = {
 		.rpc_client = clnt,
 		.rpc_message = &msg,
-		.callback_ops = server->nfs_client->cl_mvops->call_sync_ops,
+		.callback_ops = clp->cl_mvops->call_sync_ops,
 		.callback_data = &data,
 		.flags = RPC_TASK_NO_ROUND_ROBIN,
 	};
@@ -8217,7 +8228,7 @@ static int _nfs41_proc_get_locations(struct nfs_server *server,
 	locations->server = server;
 	locations->nlocations = 0;
 
-	nfs4_init_sequence(&args.seq_args, &res.seq_res, 0, 1);
+	nfs4_init_sequence(clp, &args.seq_args, &res.seq_res, 0, 1);
 	status = nfs4_call_sync_custom(&task_setup_data);
 	if (status == NFS4_OK &&
 	    res.seq_res.sr_status_flags & SEQ4_STATUS_LEASE_MOVED)
@@ -8304,7 +8315,7 @@ static int _nfs41_proc_fsid_present(struct inode *inode, const struct cred *cred
 	if (res.fh == NULL)
 		return -ENOMEM;
 
-	nfs4_init_sequence(&args.seq_args, &res.seq_res, 0, 1);
+	nfs4_init_sequence(server->nfs_client, &args.seq_args, &res.seq_res, 0, 1);
 	status = nfs4_call_sync_sequence(clnt, server, &msg,
 						&args.seq_args, &res.seq_res);
 	nfs_free_fhandle(res.fh);
@@ -8405,7 +8416,7 @@ static int _nfs4_proc_secinfo(struct inode *dir, const struct qstr *name, struct
 	dprintk("NFS call  secinfo %s\n", name->name);
 
 	nfs4_state_protect(clp, NFS_SP4_MACH_CRED_SECINFO, &clnt, &msg);
-	nfs4_init_sequence(&args.seq_args, &res.seq_res, 0, 0);
+	nfs4_init_sequence(clp, &args.seq_args, &res.seq_res, 0, 0);
 	status = nfs4_call_sync_custom(&task_setup);
 
 	dprintk("NFS reply  secinfo: %d\n", status);
@@ -9131,7 +9142,7 @@ int nfs4_proc_get_lease_time(struct nfs_client *clp, struct nfs_fsinfo *fsinfo)
 		.flags = RPC_TASK_TIMEOUT,
 	};
 
-	nfs4_init_sequence(&args.la_seq_args, &res.lr_seq_res, 0, 1);
+	nfs4_init_sequence(clp, &args.la_seq_args, &res.lr_seq_res, 0, 1);
 	return nfs4_call_sync_custom(&task_setup);
 }
 
@@ -9470,7 +9481,7 @@ static struct rpc_task *_nfs41_proc_sequence(struct nfs_client *clp,
 	calldata = kzalloc(sizeof(*calldata), GFP_KERNEL);
 	if (calldata == NULL)
 		goto out_put_clp;
-	nfs4_init_sequence(&calldata->args, &calldata->res, 0, is_privileged);
+	nfs4_init_sequence(clp, &calldata->args, &calldata->res, 0, is_privileged);
 	nfs4_sequence_attach_slot(&calldata->args, &calldata->res, slot);
 	msg.rpc_argp = &calldata->args;
 	msg.rpc_resp = &calldata->res;
@@ -9620,7 +9631,7 @@ static int nfs41_proc_reclaim_complete(struct nfs_client *clp,
 	calldata->clp = clp;
 	calldata->arg.one_fs = 0;
 
-	nfs4_init_sequence(&calldata->arg.seq_args, &calldata->res.seq_res, 0, 1);
+	nfs4_init_sequence(clp, &calldata->arg.seq_args, &calldata->res.seq_res, 0, 1);
 	msg.rpc_argp = &calldata->arg;
 	msg.rpc_resp = &calldata->res;
 	task_setup_data.callback_data = calldata;
@@ -9784,7 +9795,8 @@ nfs4_proc_layoutget(struct nfs4_layoutget *lgp,
 	struct pnfs_layout_segment *lseg = NULL;
 	int status = 0;
 
-	nfs4_init_sequence(&lgp->args.seq_args, &lgp->res.seq_res, 0, 0);
+	nfs4_init_sequence(server->nfs_client, &lgp->args.seq_args,
+			   &lgp->res.seq_res, 0, 0);
 	exception->retry = 0;
 
 	task = rpc_run_task(&task_setup_data);
@@ -9919,6 +9931,7 @@ static const struct rpc_call_ops nfs4_layoutreturn_call_ops = {
 
 int nfs4_proc_layoutreturn(struct nfs4_layoutreturn *lrp, unsigned int flags)
 {
+	struct nfs_client *clp = NFS_SERVER(lrp->args.inode)->nfs_client;
 	struct rpc_task *task;
 	struct rpc_message msg = {
 		.rpc_proc = &nfs4_procedures[NFSPROC4_CLNT_LAYOUTRETURN],
@@ -9935,9 +9948,8 @@ int nfs4_proc_layoutreturn(struct nfs4_layoutreturn *lrp, unsigned int flags)
 	};
 	int status = 0;
 
-	nfs4_state_protect(NFS_SERVER(lrp->args.inode)->nfs_client,
-			NFS_SP4_MACH_CRED_PNFS_CLEANUP,
-			&task_setup_data.rpc_client, &msg);
+	nfs4_state_protect(clp, NFS_SP4_MACH_CRED_PNFS_CLEANUP,
+			   &task_setup_data.rpc_client, &msg);
 
 	lrp->inode = nfs_igrab_and_active(lrp->args.inode);
 	if (flags & PNFS_FL_LAYOUTRETURN_ASYNC) {
@@ -9949,12 +9961,9 @@ int nfs4_proc_layoutreturn(struct nfs4_layoutreturn *lrp, unsigned int flags)
 	}
 	if (!lrp->inode)
 		flags |= PNFS_FL_LAYOUTRETURN_PRIVILEGED;
-	if (flags & PNFS_FL_LAYOUTRETURN_PRIVILEGED)
-		nfs4_init_sequence(&lrp->args.seq_args, &lrp->res.seq_res, 1,
-				   1);
-	else
-		nfs4_init_sequence(&lrp->args.seq_args, &lrp->res.seq_res, 1,
-				   0);
+
+	nfs4_init_sequence(clp, &lrp->args.seq_args, &lrp->res.seq_res, 1,
+			   flags & PNFS_FL_LAYOUTRETURN_PRIVILEGED ? 1 : 0);
 	task = rpc_run_task(&task_setup_data);
 	if (IS_ERR(task))
 		return PTR_ERR(task);
@@ -10104,7 +10113,8 @@ nfs4_proc_layoutcommit(struct nfs4_layoutcommit_data *data, bool sync)
 		}
 		task_setup_data.flags = RPC_TASK_ASYNC;
 	}
-	nfs4_init_sequence(&data->args.seq_args, &data->res.seq_res, 1, 0);
+	nfs4_init_sequence(NFS_SERVER(data->args.inode)->nfs_client,
+			   &data->args.seq_args, &data->res.seq_res, 1, 0);
 	task = rpc_run_task(&task_setup_data);
 	if (IS_ERR(task))
 		return PTR_ERR(task);
@@ -10125,6 +10135,7 @@ static int _nfs41_proc_secinfo_no_name(struct nfs_server *server,
 				       struct nfs4_secinfo_flavors *flavors,
 				       bool use_integrity)
 {
+	struct nfs_client *clp = server->nfs_client;
 	struct nfs41_secinfo_no_name_args args = {
 		.style = SECINFO_STYLE_CURRENT_FH,
 	};
@@ -10144,7 +10155,7 @@ static int _nfs41_proc_secinfo_no_name(struct nfs_server *server,
 	struct rpc_task_setup task_setup = {
 		.rpc_client = server->client,
 		.rpc_message = &msg,
-		.callback_ops = server->nfs_client->cl_mvops->call_sync_ops,
+		.callback_ops = clp->cl_mvops->call_sync_ops,
 		.callback_data = &data,
 		.flags = RPC_TASK_NO_ROUND_ROBIN,
 	};
@@ -10152,13 +10163,13 @@ static int _nfs41_proc_secinfo_no_name(struct nfs_server *server,
 	int status;
 
 	if (use_integrity) {
-		task_setup.rpc_client = server->nfs_client->cl_rpcclient;
+		task_setup.rpc_client = clp->cl_rpcclient;
 
-		cred = nfs4_get_clid_cred(server->nfs_client);
+		cred = nfs4_get_clid_cred(clp);
 		msg.rpc_cred = cred;
 	}
 
-	nfs4_init_sequence(&args.seq_args, &res.seq_res, 0, 0);
+	nfs4_init_sequence(clp, &args.seq_args, &res.seq_res, 0, 0);
 	status = nfs4_call_sync_custom(&task_setup);
 	dprintk("<-- %s status=%d\n", __func__, status);
 
@@ -10290,12 +10301,12 @@ static int _nfs41_test_stateid(struct nfs_server *server,
 		.rpc_cred = cred,
 	};
 	struct rpc_clnt *rpc_client = server->client;
+	struct nfs_client *clp = server->nfs_client;
 
-	nfs4_state_protect(server->nfs_client, NFS_SP4_MACH_CRED_STATEID,
-		&rpc_client, &msg);
+	nfs4_state_protect(clp, NFS_SP4_MACH_CRED_STATEID, &rpc_client, &msg);
 
 	dprintk("NFS call  test_stateid %p\n", stateid);
-	nfs4_init_sequence(&args.seq_args, &res.seq_res, 0, 1);
+	nfs4_init_sequence(clp, &args.seq_args, &res.seq_res, 0, 1);
 	status = nfs4_call_sync_sequence(rpc_client, server, &msg,
 			&args.seq_args, &res.seq_res);
 	if (status != NFS_OK) {
@@ -10425,7 +10436,7 @@ static int nfs41_free_stateid(struct nfs_server *server,
 	if (!refcount_inc_not_zero(&clp->cl_count))
 		return -EIO;
 
-	nfs4_state_protect(server->nfs_client, NFS_SP4_MACH_CRED_STATEID,
+	nfs4_state_protect(clp, NFS_SP4_MACH_CRED_STATEID,
 		&task_setup.rpc_client, &msg);
 
 	dprintk("NFS call  free_stateid %p\n", stateid);
@@ -10439,7 +10450,8 @@ static int nfs41_free_stateid(struct nfs_server *server,
 
 	msg.rpc_argp = &data->args;
 	msg.rpc_resp = &data->res;
-	nfs4_init_sequence(&data->args.seq_args, &data->res.seq_res, 1, privileged);
+	nfs4_init_sequence(clp, &data->args.seq_args, &data->res.seq_res, 1,
+			   privileged);
 	task = rpc_run_task(&task_setup);
 	if (IS_ERR(task))
 		return PTR_ERR(task);
-- 
2.52.0



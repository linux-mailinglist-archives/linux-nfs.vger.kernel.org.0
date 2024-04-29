Return-Path: <linux-nfs+bounces-3058-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E38538B5DC1
	for <lists+linux-nfs@lfdr.de>; Mon, 29 Apr 2024 17:31:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 97003B24AEB
	for <lists+linux-nfs@lfdr.de>; Mon, 29 Apr 2024 15:22:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5188D85C69;
	Mon, 29 Apr 2024 15:17:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jFwk+VGa"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B58684FB1
	for <linux-nfs@vger.kernel.org>; Mon, 29 Apr 2024 15:17:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714403823; cv=none; b=jCgvvHWBLCuX1mh/7ma4DZzOsJgII3jJwMwU3CPLFDHekSLEW6qGoPyJWEua4aQGKjaWSQOWA76Q/e44cz4tfTTHU/JdoPipSE8n0f6MB9demRebPctuwR1RegCYCxIpPKIkfpDdW98rQFoXQoQhbDnrQVW7K5o+xKqG3CFwn6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714403823; c=relaxed/simple;
	bh=IYhiips++FpHj6Fd+k1IWsopC0vjCx4Hibz25uAKhAQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Px0DWwo9Y01Onwd0cDUtvw2ue2xcJlXE1akRe0Ubslx1IOwkQ6gnqVFL6gSiehkO4WbQZ3+8y1ageeQ+Y4YUg8WHY6iIr0+iez1m/3ACWkWcvXKX45U39Figpdu+Iku9q3bDf187z95tKSyVeGovDXnYpz1F6by93v6zkSjK5LA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jFwk+VGa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2B2FC113CD;
	Mon, 29 Apr 2024 15:17:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714403823;
	bh=IYhiips++FpHj6Fd+k1IWsopC0vjCx4Hibz25uAKhAQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jFwk+VGa7Sxh0KsDIzim51QCBi1aJq3VpVIkIYllk7AMrCKR4o28/944SvCqWywzy
	 nBmR91gomEJK/T2LqOf/tLAXZzIGpNJ0vtitDWEIbmFiQhF/HYowc25XDczWO0d5Q7
	 AVm89yYQmgQcMhzqu7u3SKrGDe6jxZXQYNoOve4rfMTKxkUdiuj8GvP51lik8bNGZJ
	 zcLPYAVSsk4dAXUG0FQsZcTZK1jAfUc/jWZHiddAzqDrSqIux3FZ7/Wz86D7TVu7QM
	 ugfCWd8Zr3C8lUDCNCk16eiNaUHmkeMNLGj+DemiBsAl7MfkvK71YRu7Vmf8tPzNoT
	 lxTG3O2KqLVCQ==
From: cel@kernel.org
To: Olga Kornievskaia <kolga@netapp.com>,
	Dai Ngo <dai.ngo@oracle.com>
Cc: <linux-nfs@vger.kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>
Subject: [RFC PATCH 4/4] NFS: Implement NFSv4.2's OFFLOAD_STATUS operation
Date: Mon, 29 Apr 2024 11:16:37 -0400
Message-ID: <20240429151632.212571-10-cel@kernel.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240429151632.212571-6-cel@kernel.org>
References: <20240429151632.212571-6-cel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=6806; i=chuck.lever@oracle.com; h=from:subject; bh=nZ5zM7+VewkFNxzsu9wMz5nLhLUmTnfxmT5JeugnHmA=; b=owEBbQKS/ZANAwAIATNqszNvZn+XAcsmYgBmL7nWGoyQKT14FrG4YPbpUvHehFRb5Zu4+5Zo2 SonOkHzeAiJAjMEAAEIAB0WIQQosuWwEobfJDzyPv4zarMzb2Z/lwUCZi+51gAKCRAzarMzb2Z/ l6wJEACRDu7EPRVFYYRNE/ZOmi7kL9/NvrnicfzOyB2Wql+2WL7Mu7vAjVweZ8TsWI1a9wleQfM H+dTTtnoUopyKKwf+6lMHdVJF30uXf5umOxQZcOWxQ/U33vMOgcmjA7fO3I23u1DWp/xKliCwPY 79xaPbdyWflxfSybaQWgCh9LOXM00IlFpSasGiU79abP2VtKhFRpAyK+XHWGTbABe6kGSxeniRk XUKscYz2/fthMDVzEo5oUff27RaQJKBblytj9UYcAVjWXPAxW3R9P0KncQBmNXG7gI/vxboVTgZ niEynZEpmVck1WW3m8cbV3IsdbT0un2bRdrdMyaCTOLSN7EOerd0RqpzeIwYtHSDNuazcL0bAkp bQ204C1XeJnOi5xPSCn0zF8GzBA5cyyTKjDKX+jkrUvYnNRIVQdZOU+iVGRreExWYei7An+sHgw 7Yj5EFUOu44ze3RNqTb+KJ8zD5AbxtmUk8iE6hV667upD420tEWAYFSeWLZqI93zHM6QfKmNCLd IVUN49m4emyEKGixA9l+KBvYjwZPoGNEjiF8Fp0enGG99yh8+ev42IpcHNGQNSJ6JaO42RloJFz jnaQo8mwHam1OsTKIgirQIhFydo1/GqA+idGGFM5cCQkVoKlV5cxojEkNnwWZQxLsm4K3ivp4tu nTwXbgXOdj00ZSQ==
X-Developer-Key: i=chuck.lever@oracle.com; a=openpgp; fpr=28B2E5B01286DF243CF23EFE336AB3336F667F97
Content-Transfer-Encoding: 8bit

From: Chuck Lever <chuck.lever@oracle.com>

We've found that there are cases where a transport disconnection
results in the loss of callback RPCs. NFS servers typically do not
retransmit callback operations after a disconnect.

This can be a problem for the Linux NFS client's implementation of
asynchronous COPY, which waits indefinitely for a CB_OFFLOAD
callback. If a transport disconnect occurs while an async COPY is
running, there's a good chance the client will never get the
matching CB_OFFLOAD.

Fix this by implementing the OFFLOAD_STATUS operation so that the
Linux NFS client can probe the NFS server if it doesn't see a
CB_OFFLOAD in a reasonable amount of time.

This patch implements a simplistic check. As future work, the client
might also be able to detect whether there is no forward progress on
the request asynchronous COPY operation, and CANCEL it.

Suggested-by: Olga Kornievskaia <kolga@netapp.com>
Link: https://bugzilla.kernel.org/show_bug.cgi?id=218735
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfs/nfs42proc.c        | 100 +++++++++++++++++++++++++++++++++++---
 fs/nfs/nfs4trace.h        |   1 +
 include/linux/nfs_fs_sb.h |   1 +
 3 files changed, 96 insertions(+), 6 deletions(-)

diff --git a/fs/nfs/nfs42proc.c b/fs/nfs/nfs42proc.c
index 7656d7c103fa..224fb3b8696a 100644
--- a/fs/nfs/nfs42proc.c
+++ b/fs/nfs/nfs42proc.c
@@ -21,6 +21,7 @@
 
 #define NFSDBG_FACILITY NFSDBG_PROC
 static int nfs42_do_offload_cancel_async(struct file *dst, nfs4_stateid *std);
+static int nfs42_proc_offload_status(struct file *file, nfs4_stateid *stateid);
 
 static void nfs42_set_netaddr(struct file *filep, struct nfs42_netaddr *naddr)
 {
@@ -173,6 +174,9 @@ int nfs42_proc_deallocate(struct file *filep, loff_t offset, loff_t len)
 	return err;
 }
 
+/* Wait this long before checking progress on a COPY operation */
+#define NFS42_COPY_TIMEOUT	(7 * HZ)
+
 static int handle_async_copy(struct nfs42_copy_res *res,
 			     struct nfs_server *dst_server,
 			     struct nfs_server *src_server,
@@ -222,7 +226,9 @@ static int handle_async_copy(struct nfs42_copy_res *res,
 		spin_unlock(&src_server->nfs_client->cl_lock);
 	}
 
-	status = wait_for_completion_interruptible(&copy->completion);
+wait:
+	status = wait_for_completion_interruptible_timeout(&copy->completion,
+							   NFS42_COPY_TIMEOUT);
 	spin_lock(&dst_server->nfs_client->cl_lock);
 	list_del_init(&copy->copies);
 	spin_unlock(&dst_server->nfs_client->cl_lock);
@@ -231,12 +237,20 @@ static int handle_async_copy(struct nfs42_copy_res *res,
 		list_del_init(&copy->src_copies);
 		spin_unlock(&src_server->nfs_client->cl_lock);
 	}
-	if (status == -ERESTARTSYS) {
-		goto out_cancel;
-	} else if (copy->flags || copy->error == NFS4ERR_PARTNER_NO_AUTH) {
-		status = -EAGAIN;
-		*restart = true;
+	switch (status) {
+	case 0:
+		status = nfs42_proc_offload_status(src, src_stateid);
+		if (status && status != -EOPNOTSUPP)
+			goto wait;
+		break;
+	case -ERESTARTSYS:
 		goto out_cancel;
+	default:
+		if (copy->flags || copy->error == NFS4ERR_PARTNER_NO_AUTH) {
+			status = -EAGAIN;
+			*restart = true;
+			goto out_cancel;
+		}
 	}
 out:
 	res->write_res.count = copy->count;
@@ -582,6 +596,80 @@ static int nfs42_do_offload_cancel_async(struct file *dst,
 	return status;
 }
 
+static void nfs42_offload_status_prepare(struct rpc_task *task, void *calldata)
+{
+	struct nfs42_offload_data *data = calldata;
+
+	nfs4_setup_sequence(data->seq_server->nfs_client,
+				&data->args.osa_seq_args,
+				&data->res.osr_seq_res, task);
+}
+
+static void nfs42_offload_status_done(struct rpc_task *task, void *calldata)
+{
+	struct nfs42_offload_data *data = calldata;
+
+	trace_nfs4_offload_status(&data->args, task->tk_status);
+	nfs41_sequence_done(task, &data->res.osr_seq_res);
+	if (task->tk_status &&
+		nfs4_async_handle_error(task, data->seq_server, NULL,
+			NULL) == -EAGAIN)
+		rpc_restart_call_prepare(task);
+}
+
+static const struct rpc_call_ops nfs42_offload_status_ops = {
+	.rpc_call_prepare = nfs42_offload_status_prepare,
+	.rpc_call_done = nfs42_offload_status_done,
+	.rpc_release = nfs42_free_offload_data,
+};
+
+static int nfs42_proc_offload_status(struct file *file, nfs4_stateid *stateid)
+{
+	struct nfs_open_context *ctx = nfs_file_open_context(file);
+	struct nfs_server *server = NFS_SERVER(file_inode(file));
+	struct nfs42_offload_data *data = NULL;
+	struct rpc_task *task;
+	struct rpc_message msg = {
+		.rpc_proc	= &nfs4_procedures[NFSPROC4_CLNT_OFFLOAD_STATUS],
+		.rpc_cred	= ctx->cred,
+	};
+	struct rpc_task_setup task_setup_data = {
+		.rpc_client	= server->client,
+		.rpc_message	= &msg,
+		.callback_ops	= &nfs42_offload_status_ops,
+		.workqueue	= nfsiod_workqueue,
+		.flags		= RPC_TASK_ASYNC | RPC_TASK_SOFTCONN,
+	};
+	int status;
+
+	if (!(server->caps & NFS_CAP_OFFLOAD_STATUS))
+		return -EOPNOTSUPP;
+
+	data = kzalloc(sizeof(struct nfs42_offload_data), GFP_KERNEL);
+	if (data == NULL)
+		return -ENOMEM;
+
+	data->seq_server = server;
+	data->args.osa_src_fh = NFS_FH(file_inode(file));
+	memcpy(&data->args.osa_stateid, stateid,
+		sizeof(data->args.osa_stateid));
+	msg.rpc_argp = &data->args;
+	msg.rpc_resp = &data->res;
+	task_setup_data.callback_data = data;
+	nfs4_init_sequence(&data->args.osa_seq_args, &data->res.osr_seq_res,
+			   1, 0);
+	task = rpc_run_task(&task_setup_data);
+	if (IS_ERR(task)) {
+		nfs42_free_offload_data(data);
+		return PTR_ERR(task);
+	}
+	status = rpc_wait_for_completion_task(task);
+	if (status == -ENOTSUPP)
+		server->caps &= ~NFS_CAP_OFFLOAD_STATUS;
+	rpc_put_task(task);
+	return status;
+}
+
 static int _nfs42_proc_copy_notify(struct file *src, struct file *dst,
 				   struct nfs42_copy_notify_args *args,
 				   struct nfs42_copy_notify_res *res)
diff --git a/fs/nfs/nfs4trace.h b/fs/nfs/nfs4trace.h
index 8f32dbf9c91d..9bcc525c71d1 100644
--- a/fs/nfs/nfs4trace.h
+++ b/fs/nfs/nfs4trace.h
@@ -2564,6 +2564,7 @@ DECLARE_EVENT_CLASS(nfs4_offload_class,
 			), \
 			TP_ARGS(args, error))
 DEFINE_NFS4_OFFLOAD_EVENT(nfs4_offload_cancel);
+DEFINE_NFS4_OFFLOAD_EVENT(nfs4_offload_status);
 
 DECLARE_EVENT_CLASS(nfs4_xattr_event,
 		TP_PROTO(
diff --git a/include/linux/nfs_fs_sb.h b/include/linux/nfs_fs_sb.h
index 92de074e63b9..0937e73c4767 100644
--- a/include/linux/nfs_fs_sb.h
+++ b/include/linux/nfs_fs_sb.h
@@ -278,6 +278,7 @@ struct nfs_server {
 #define NFS_CAP_LGOPEN		(1U << 5)
 #define NFS_CAP_CASE_INSENSITIVE	(1U << 6)
 #define NFS_CAP_CASE_PRESERVING	(1U << 7)
+#define NFS_CAP_OFFLOAD_STATUS	(1U << 8)
 #define NFS_CAP_POSIX_LOCK	(1U << 14)
 #define NFS_CAP_UIDGID_NOMAP	(1U << 15)
 #define NFS_CAP_STATEID_NFSV41	(1U << 16)
-- 
2.44.0



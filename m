Return-Path: <linux-nfs+bounces-8336-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A54E09E276D
	for <lists+linux-nfs@lfdr.de>; Tue,  3 Dec 2024 17:29:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6DA721645FF
	for <lists+linux-nfs@lfdr.de>; Tue,  3 Dec 2024 16:29:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16A271F8AF9;
	Tue,  3 Dec 2024 16:29:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RbK18aJv"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E63211F8AE4
	for <linux-nfs@vger.kernel.org>; Tue,  3 Dec 2024 16:29:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733243362; cv=none; b=pTsWNnVd3cDycKdna59MTRWHLb3rZAeXUFzjL571m5HC8IZ0cqoDNAzOlzn3hzznj+YQOC395D2Yy38TSQfHEFClvyiBXW11NWpYUukHkFXrU89gV1Ng3pVThvbNtEkvYOtKv40XWnTr9fggNR9K9Jpjib37zHuCjAGs4+rbqYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733243362; c=relaxed/simple;
	bh=Ad1wxUut4XVotie1gU3Nou6N3wMEFKd1vQkJIi2vu7A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=k10w//7GFbXRMZ3ZG3HtkLbPd7GkrRqhKogtYVAmW22b+zh4kq20QcfcSnkdyLqJcnG33H1uRcokIQMHthXgpFgEuVXJE8/GbIHOzDfqmpWdyxRGGF5rjtx2jkGhXlUijmprjCCieXBfnISAo48N0Eh8cwKXeNvwZ8GZI1crsaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RbK18aJv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5CD35C4CED6;
	Tue,  3 Dec 2024 16:29:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733243361;
	bh=Ad1wxUut4XVotie1gU3Nou6N3wMEFKd1vQkJIi2vu7A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=RbK18aJvRfG8wbuXSDo0gQlCCuaEDC8S0GMROrM9FaQceKEwUTrhPZejbi9Rjrp+C
	 UL8zda2OztWyw3Ro/xZ+L0ZW5E5U8Y0P/LifTe/TS2+U7zsBI6ij8vlHiaywAEzUS/
	 jomHwck+QryYTcmIFRxUYqWExFNYnhUZADAKKaJtFzkApTWnnEiQLf3NHnhjz0mqYJ
	 +DG9eIj/7yjMCAnpYEI3HRELGv46KixWpFKi0eHLGJcYtFW6wmQ3Wn8m/GueEpc3oS
	 K0IcTCZcDUHKdETe8/QCzWb7gMce1SNtzqJPcYqcaVqIfx+cFwbrhKm5R8qP5yTosp
	 ZXHUWVNh6x/iQ==
From: cel@kernel.org
To: Olga Kornievskaia <okorniev@redhat.com>,
	Anna Schumaker <anna@kernel.org>
Cc: <linux-nfs@vger.kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>
Subject: [PATCH v1 5/7] NFS: Implement NFSv4.2's OFFLOAD_STATUS operation
Date: Tue,  3 Dec 2024 11:29:14 -0500
Message-ID: <20241203162908.302354-14-cel@kernel.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241203162908.302354-9-cel@kernel.org>
References: <20241203162908.302354-9-cel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=5790; i=chuck.lever@oracle.com; h=from:subject; bh=LYTOve5p/LmEGFffPsOkYr53z7Z574x7V88ig6cV6Zs=; b=owEBbQKS/ZANAwAIATNqszNvZn+XAcsmYgBnTzHbflTLzvKZqyWYgS38lOi3qW/U0Je3rCgnt 4xvZxtyhISJAjMEAAEIAB0WIQQosuWwEobfJDzyPv4zarMzb2Z/lwUCZ08x2wAKCRAzarMzb2Z/ l3ZLD/9a+b2io958B4+MJINID9WM1jQ1nXW/TwaQgwPUvDEK/nfTDPW2NISRlHQ0tOqsCCani+Q yM4Sz+d4QinpMdg8P4ydUmVgSbzVP7MOxJwD+WQRKCRIVABHxbH0zHRJoVSzatJzwC6rRAXTwAH +4kqQb+1qDdILpp3ydK8hQUhGsdYyN5kZSSE3FN/9Mikx63mAf6ZP7LcqjEsIwFZCMEC8TNV3z8 Uvm/4ncJSGBOR0jjEzJTwWfhFKznvfff4zKcBCsipTyTkgnlr7MQZjdFL4DZU7iGBjEw9rU8PDp NEE1EwjRoThDwpPffhzgNG3wwjrYaz5jMeRtw+Kh5qgxYBZc0b5vQUEYyYgAdpbXxqTFNbuo0AP jJzbVqMVnXg1X1/OfNXqIwbWhadPu+9WxBETb2EAZq4lykgs9TK0XKAzK1KRtq+JYKXX3a7q/4W J60LJn4G8juAXAUX8cmdtrQx2CQIzn+Q+1cABav0epVhpLdUKEPt1kAg3KijKVclTrXClCHzApM z56JQdt9t5luxP8N23l/k5nCvw416YcGR2amFqPPuUtaoodYsmHyvCKx4tAtE4c5TWd6HWzmlT+ 4zCYlQFUdQMykR3vKeeCgkWBCxPmII7KFbfo6n27SP3QWSM1RkNOW1gejCBZ2ZnuuOVCU0gWRHB d89p7HG5HISkAbg==
X-Developer-Key: i=chuck.lever@oracle.com; a=openpgp; fpr=28B2E5B01286DF243CF23EFE336AB3336F667F97
Content-Transfer-Encoding: 8bit

From: Chuck Lever <chuck.lever@oracle.com>

Enable the Linux NFS client to observe the progress of an offloaded
asynchronous COPY operation. This new operation will be put to use
in a subsequent patch.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfs/nfs42proc.c        | 117 ++++++++++++++++++++++++++++++++++++++
 fs/nfs/nfs4proc.c         |   3 +-
 include/linux/nfs_fs_sb.h |   1 +
 3 files changed, 120 insertions(+), 1 deletion(-)

diff --git a/fs/nfs/nfs42proc.c b/fs/nfs/nfs42proc.c
index 9d716907cf30..fa180ce7c803 100644
--- a/fs/nfs/nfs42proc.c
+++ b/fs/nfs/nfs42proc.c
@@ -21,6 +21,8 @@
 
 #define NFSDBG_FACILITY NFSDBG_PROC
 static int nfs42_do_offload_cancel_async(struct file *dst, nfs4_stateid *std);
+static int nfs42_proc_offload_status(struct file *file, nfs4_stateid *stateid,
+				     u64 *copied);
 
 static void nfs42_set_netaddr(struct file *filep, struct nfs42_netaddr *naddr)
 {
@@ -582,6 +584,121 @@ static int nfs42_do_offload_cancel_async(struct file *dst,
 	return status;
 }
 
+static void nfs42_offload_status_done(struct rpc_task *task, void *calldata)
+{
+	struct nfs42_offload_data *data = calldata;
+
+	nfs41_sequence_done(task, &data->res.osr_seq_res);
+	switch (task->tk_status) {
+	case 0:
+		return;
+	case -NFS4ERR_ADMIN_REVOKED:
+	case -NFS4ERR_BAD_STATEID:
+	case -NFS4ERR_OLD_STATEID:
+		/*
+		 * Server does not recognize the COPY stateid. CB_OFFLOAD
+		 * could have purged it, or server might have rebooted.
+		 * Since COPY stateids don't have an associated inode,
+		 * avoid triggering state recovery.
+		 */
+		task->tk_status = -EBADF;
+		break;
+	case -NFS4ERR_NOTSUPP:
+	case -ENOTSUPP:
+	case -EOPNOTSUPP:
+		data->seq_server->caps &= ~NFS_CAP_OFFLOAD_STATUS;
+		task->tk_status = -EOPNOTSUPP;
+		break;
+	default:
+		if (nfs4_async_handle_error(task, data->seq_server,
+					    NULL, NULL) == -EAGAIN)
+			rpc_restart_call_prepare(task);
+		else
+			task->tk_status = -EIO;
+	}
+}
+
+static const struct rpc_call_ops nfs42_offload_status_ops = {
+	.rpc_call_prepare = nfs42_offload_prepare,
+	.rpc_call_done = nfs42_offload_status_done,
+	.rpc_release = nfs42_offload_release
+};
+
+/**
+ * nfs42_proc_offload_status - Poll completion status of an async copy operation
+ * @file: handle of file being copied
+ * @stateid: copy stateid (from async COPY result)
+ * @copied: OUT: number of bytes copied so far
+ *
+ * Return values:
+ *   %0: Server returned an NFS4_OK completion status
+ *   %-EINPROGRESS: Server returned no completion status
+ *   %-EREMOTEIO: Server returned an error completion status
+ *   %-EBADF: Server did not recognize the copy stateid
+ *   %-EOPNOTSUPP: Server does not support OFFLOAD_STATUS
+ *   %-ERESTARTSYS: Wait interrupted by signal
+ *
+ * Other negative errnos indicate the client could not complete the
+ * request.
+ */
+static int nfs42_proc_offload_status(struct file *file, nfs4_stateid *stateid,
+				     u64 *copied)
+{
+	struct nfs_open_context *ctx = nfs_file_open_context(file);
+	struct nfs_server *server = NFS_SERVER(file_inode(file));
+	struct nfs42_offload_data *data = NULL;
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
+	struct rpc_task *task;
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
+		nfs42_offload_release(data);
+		return PTR_ERR(task);
+	}
+	status = rpc_wait_for_completion_task(task);
+	if (status)
+		goto out;
+
+	*copied = data->res.osr_count;
+	if (task->tk_status)
+		status = task->tk_status;
+	else if (!data->res.complete_count)
+		status = -EINPROGRESS;
+	else if (data->res.osr_complete != NFS_OK)
+		status = -EREMOTEIO;
+
+out:
+	rpc_put_task(task);
+	return status;
+}
+
 static int _nfs42_proc_copy_notify(struct file *src, struct file *dst,
 				   struct nfs42_copy_notify_args *args,
 				   struct nfs42_copy_notify_res *res)
diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
index 405f17e6e0b4..973b8d8fa98b 100644
--- a/fs/nfs/nfs4proc.c
+++ b/fs/nfs/nfs4proc.c
@@ -10769,7 +10769,8 @@ static const struct nfs4_minor_version_ops nfs_v4_2_minor_ops = {
 		| NFS_CAP_CLONE
 		| NFS_CAP_LAYOUTERROR
 		| NFS_CAP_READ_PLUS
-		| NFS_CAP_MOVEABLE,
+		| NFS_CAP_MOVEABLE
+		| NFS_CAP_OFFLOAD_STATUS,
 	.init_client = nfs41_init_client,
 	.shutdown_client = nfs41_shutdown_client,
 	.match_stateid = nfs41_match_stateid,
diff --git a/include/linux/nfs_fs_sb.h b/include/linux/nfs_fs_sb.h
index b804346a9741..946ca1c28773 100644
--- a/include/linux/nfs_fs_sb.h
+++ b/include/linux/nfs_fs_sb.h
@@ -290,6 +290,7 @@ struct nfs_server {
 #define NFS_CAP_CASE_INSENSITIVE	(1U << 6)
 #define NFS_CAP_CASE_PRESERVING	(1U << 7)
 #define NFS_CAP_REBOOT_LAYOUTRETURN	(1U << 8)
+#define NFS_CAP_OFFLOAD_STATUS	(1U << 9)
 #define NFS_CAP_OPEN_XOR	(1U << 12)
 #define NFS_CAP_DELEGTIME	(1U << 13)
 #define NFS_CAP_POSIX_LOCK	(1U << 14)
-- 
2.47.0



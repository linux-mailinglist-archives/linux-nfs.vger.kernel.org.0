Return-Path: <linux-nfs+bounces-6935-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BEA2995097
	for <lists+linux-nfs@lfdr.de>; Tue,  8 Oct 2024 15:47:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AF89B1F254CD
	for <lists+linux-nfs@lfdr.de>; Tue,  8 Oct 2024 13:47:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0668E1DF977;
	Tue,  8 Oct 2024 13:47:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J/waiCXf"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6C5C13959D
	for <linux-nfs@vger.kernel.org>; Tue,  8 Oct 2024 13:47:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728395263; cv=none; b=Yq4yKYL/XAlZ/wiObN8kZ7HKnHhb7pNY23L794ylquhlPZQpXoji12oyNXaeI6Ip/a5twfrb0OPrTNV1d5KQzNhsHU+h8bk67QgpMZ5NOrp4/dLjC55wat+Jh/e84bPAqY2Rg5dDo6U70muKt5/K9lyGDKesRzzYohqMjbUTaXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728395263; c=relaxed/simple;
	bh=9CI8yTRHsiTkk+aPc/E1JM77Dh59f8kecEQpR3DPgYE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nyYgYLxYHhT6zMgqtETc6aYUq9KYhZE5wxJrlhRfMUFeIH+W36vqMitOC5c4cfJVmfozvQIbA2l28vwHHn3L4vY4c1tyg7QvBlgPiM9PUmXPqF5tJxmCN1+2h5GsQCMhiU7+hzySNTfJPVFCi3WxnMPAn++Hd+fQ+D3muiF3KeY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J/waiCXf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16D2AC4CED1;
	Tue,  8 Oct 2024 13:47:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728395263;
	bh=9CI8yTRHsiTkk+aPc/E1JM77Dh59f8kecEQpR3DPgYE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=J/waiCXfSnbhbP7W53KghpNEcP1q83g1fYENpeyQPqU7PGQGzgySDZat2y2dJtfvN
	 zDSz4FeMyzAmnx+YrZ3vd7TkDHjgcP36/07PnswFjxHpGPV1+CjwgzuUT9GMi4ro7H
	 2w8VCQcDGRDwjpxd5XxUkc0aiV3g5pkUj6YcXnBESYZjeeB/43/owbSd4GU+DV0/MN
	 l/Ao4s+n87Wk/GjAA8BifrWmSfG++5t7qPyqLzgU75exBc0DadA7Gt9xdU2TI8A5fY
	 WUktFe2iVXw+OsnWG+X7lwFIW76GnetrhoCWkh/Kp8QxJPEj/49Sdmr4NnPFc8kp+h
	 KbBWnMc+JzdSw==
From: cel@kernel.org
To: Neil Brown <neilb@suse.de>,
	Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>
Cc: <linux-nfs@vger.kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>
Subject: [RFC PATCH 7/9] NFS: Implement NFSv4.2's OFFLOAD_STATUS operation
Date: Tue,  8 Oct 2024 09:47:26 -0400
Message-ID: <20241008134719.116825-18-cel@kernel.org>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241008134719.116825-11-cel@kernel.org>
References: <20241008134719.116825-11-cel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=5850; i=chuck.lever@oracle.com; h=from:subject; bh=n80RJYvY1xtKahZ9ZDtUSeGPcfI9YfevHhzr4FdxMB8=; b=owEBbQKS/ZANAwAIATNqszNvZn+XAcsmYgBnBTfzd3OrFO8ZSVey/oyupzlPaHzcXMjPlHy+f lIdJy4pSGSJAjMEAAEIAB0WIQQosuWwEobfJDzyPv4zarMzb2Z/lwUCZwU38wAKCRAzarMzb2Z/ l49KEAC5zejXDt/MFXTyoevly09AiTk45biFgU/fixLJAcXeH5KTowc1iZrea/PhOOfCtfwYsDo CRQilQ9c/caoxHarP039BJvu0XMEDjQTm7yZTY2pUGgxq9pzNxEXUA2Y00LDVBHl8Oaxq/i7bGa 5tYCwTP3Gr8CRZ5po4JUw22u8azUxdsQ2xGyWlJnOOzuJmek182CGGwafsuRyMC3Y/Sz/aFqKx6 OHVa50ZApuGepWV37XxA2zR8nZ3CE0gWRaysZP3Bzn6eg2o+NslZ0Z8I7lmzRnMMQESFr+Mdvwm bAq1GfCjWvOtl+JxpwEGP3/bJqdKcMCi0OgtYAs5Bx79/5i7veYMJIFEjQ5e0yhBIp8sxaoBOkY ck3xBdgGQSMPW9z7x2lm6ZQitfkrCQFo5LOPbAy34w+VoOeH2n+7YdalWFTJLz3TqgKWeFoNbBT P6ILeWdjFn5pY7a4rIpPmqmd2nscYhj4rLEZHiNI6zH5eMsWfP8ThNuwGSC9Ffnx/bf2myrHSUB oHfzZdwSsZASRp93PaCE2AhF8wyYeO9cLNJHJogKYw02L1xpGJlXzF4uKvSTKoFbAmvT3Ntw1LO 78OO4id6YuLYi0C2kXE1OM6/YiOEiT76z9hRnyGhO56XgrUGBXdvS87PcW/vz8SyZ0kaBzagPA4 FHlIX3UwDtCVA9g==
X-Developer-Key: i=chuck.lever@oracle.com; a=openpgp; fpr=28B2E5B01286DF243CF23EFE336AB3336F667F97
Content-Transfer-Encoding: 8bit

From: Chuck Lever <chuck.lever@oracle.com>

Enable the Linux NFS client to observe the progress of an offloaded
asynchronous COPY operation. This new operation will be put to use
in a subsequent patch.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfs/nfs42proc.c        | 122 ++++++++++++++++++++++++++++++++++++++
 fs/nfs/nfs4proc.c         |   3 +-
 include/linux/nfs_fs_sb.h |   1 +
 3 files changed, 125 insertions(+), 1 deletion(-)

diff --git a/fs/nfs/nfs42proc.c b/fs/nfs/nfs42proc.c
index 869605a0a9d5..175330843558 100644
--- a/fs/nfs/nfs42proc.c
+++ b/fs/nfs/nfs42proc.c
@@ -21,6 +21,8 @@
 
 #define NFSDBG_FACILITY NFSDBG_PROC
 static int nfs42_do_offload_cancel_async(struct file *dst, nfs4_stateid *std);
+static int nfs42_proc_offload_status(struct file *file, nfs4_stateid *stateid,
+				     u64 *copied);
 
 static void nfs42_set_netaddr(struct file *filep, struct nfs42_netaddr *naddr)
 {
@@ -582,6 +584,126 @@ static int nfs42_do_offload_cancel_async(struct file *dst,
 	return status;
 }
 
+static void nfs42_offload_status_done(struct rpc_task *task, void *calldata)
+{
+	struct nfs42_offload_data *data = calldata;
+
+	if (!nfs4_sequence_done(task, &data->res.osr_seq_res))
+		return;
+
+	switch (task->tk_status) {
+	case 0:
+		return;
+	case -NFS4ERR_DELAY:
+		if (nfs4_async_handle_error(task, data->seq_server,
+					    NULL, NULL) == -EAGAIN)
+			rpc_restart_call_prepare(task);
+		else
+			task->tk_status = -EIO;
+		break;
+	case -NFS4ERR_GRACE:
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
+		task->tk_status = -EIO;
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
+	else if (data->res.osr_complete[0] != NFS_OK)
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
index cd2fbde2e6d7..324e38b70b9f 100644
--- a/fs/nfs/nfs4proc.c
+++ b/fs/nfs/nfs4proc.c
@@ -10763,7 +10763,8 @@ static const struct nfs4_minor_version_ops nfs_v4_2_minor_ops = {
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
index 853df3fcd4c2..05b8deadd3b1 100644
--- a/include/linux/nfs_fs_sb.h
+++ b/include/linux/nfs_fs_sb.h
@@ -289,6 +289,7 @@ struct nfs_server {
 #define NFS_CAP_CASE_INSENSITIVE	(1U << 6)
 #define NFS_CAP_CASE_PRESERVING	(1U << 7)
 #define NFS_CAP_REBOOT_LAYOUTRETURN	(1U << 8)
+#define NFS_CAP_OFFLOAD_STATUS	(1U << 9)
 #define NFS_CAP_OPEN_XOR	(1U << 12)
 #define NFS_CAP_DELEGTIME	(1U << 13)
 #define NFS_CAP_POSIX_LOCK	(1U << 14)
-- 
2.46.2



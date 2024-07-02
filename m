Return-Path: <linux-nfs+bounces-4532-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BBE7F92423B
	for <lists+linux-nfs@lfdr.de>; Tue,  2 Jul 2024 17:21:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 71FB02895E3
	for <lists+linux-nfs@lfdr.de>; Tue,  2 Jul 2024 15:21:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 826AE1B47AC;
	Tue,  2 Jul 2024 15:20:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jzpv2qsu"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F0AE1AD9E7
	for <linux-nfs@vger.kernel.org>; Tue,  2 Jul 2024 15:20:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719933658; cv=none; b=TblQui/Owt/7ayb8cuzFaKW228qyXUAylshGX9S0YHSFsUc8XcMXxfkroVP/gOpSfbhYpkPb6KMSZBccdNT/QbYIVbvKBZpiwf13TB0RDCfGE+TSkkOWhQn82d1KsFlgJFID9RDwxZlNGQqxoYVZf8M9RyGxeFEULTYgQ7yR2P0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719933658; c=relaxed/simple;
	bh=2QfSfREv7XsLiYzVIDPiC88C7bCowAudVtuQMvAvPic=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fu+a8zmW/eSQ0TnUrZTlEsfbdD42PFPSGJdRrX5UVb7g7/ZAtfxi6TRE9x2OiWS5NniruWL4pYArDncc4K/Dpy1YD0pI/4LB9QpXzq59Ex8F+2dQFxexhBNVBumPxxYmKy3KkYaUX83zV9MIc2EVdab6lUYui4GF5KsXExwFvaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jzpv2qsu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86AE8C4AF0C;
	Tue,  2 Jul 2024 15:20:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719933658;
	bh=2QfSfREv7XsLiYzVIDPiC88C7bCowAudVtuQMvAvPic=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jzpv2qsu5sTwriWMJvGzkOAdDiMb4aGIO5eDm3Bwj14GurHgGGDCn+OhvCR0vhLy5
	 RoOrJikWXyp8CSEXuF7anQhe+ggo5D1Dv/A0zniJHUUygoL+kB7S/xlm9ECm1b0F8T
	 TAiXyHOTR+yKaKo8tQNIW80hiP4LfyFM6r56CJF0v/76kET81/hk7tvQzPjkM45AxM
	 nDpG1Jq+5/YDmUnJSJ1YrZtl6suL1t/ZVKzn4XoGqFFdcKloRD3TEpRNN1OKebmQki
	 bMZxXPBXkOaYJytosZD1pTq3Uvokm+YqDiq6ZAZan4TwA8XT+KlhP4yb5r1kdvz6WG
	 yolLjzpSRleJQ==
From: cel@kernel.org
To: <linux-nfs@vger.kernel.org>
Cc: Olga Kornievskaia <kolga@netapp.com>,
	Dai Ngo <dai.ngo@oracle.com>,
	Chuck Lever <chuck.lever@oracle.com>
Subject: [RFC PATCH 4/6] NFS: Implement NFSv4.2's OFFLOAD_STATUS operation
Date: Tue,  2 Jul 2024 11:19:52 -0400
Message-ID: <20240702151947.549814-12-cel@kernel.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240702151947.549814-8-cel@kernel.org>
References: <20240702151947.549814-8-cel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4802; i=chuck.lever@oracle.com; h=from:subject; bh=7xMXUEeia+4iJBPnT1BQ6xl/jRDx8k+7VEvXenSB2HI=; b=owEBbQKS/ZANAwAIATNqszNvZn+XAcsmYgBmhBqZQiItdu/AwuC4UP4QXECenZ3wn22XzaB3R LqhEtPtJ8OJAjMEAAEIAB0WIQQosuWwEobfJDzyPv4zarMzb2Z/lwUCZoQamQAKCRAzarMzb2Z/ l9C2D/9Vpt0FhWV+OSFXzftGRE5dkq8giU69P5fmcaUredNaW3ycYR+yFy/50qxzi4zxY7/Ni+E fVLbCm11hO2F/lNA+YdGyyFdA7zzfjSu+4gA5wNBedcpvXbX+3hyRLoxCgBf6STB1gaPjTho9s8 cPUF+lCHphalwGpiKv2KjVUafrIgXDdoIDF3Oz2a4HeYawrok5wD3DXSr2xxo+7McliDMkHhBYy hAEObfk4havibagkbcaiI5+i285XZjpeIa5MImW2rkvniyvLRyb08/DUXiOXxQchZC7V09kftLL o2aJSfrahTBo0jjrDZNulgz7creiEkL3MTr8CCL0Sfi9jIlVzvOYxaL71pKS7Ts3ql60LqEXMIU RuG548NOKyPOzNhzOsU6wFXMR2zgKCD8qqPDU3MOphGUpx6c9B7dWET5tnkO4fnSXoJ06Suc01m W3IhoYYIOQPv55uB201MaZl748SChcTFwjmBLXXJd5zt/865MOpa24EaFsTP3H4Ypuy9nAnB52a q3tBVWdutl6QZbbdZKwR0Wu4M2V6/2t/PF6qarHOBdAieX5kweHLRhPuCLjxWRUseUrN6NApOCI LyfAkT2zm9jOCToaWFwVu224SC2Y7e5Q3vKCntR9w3v9HN0aQvPhA7CT+gADi5RWw4IjFQ+Oz/B UvwRoHgPGoLcICQ==
X-Developer-Key: i=chuck.lever@oracle.com; a=openpgp; fpr=28B2E5B01286DF243CF23EFE336AB3336F667F97
Content-Transfer-Encoding: 8bit

From: Chuck Lever <chuck.lever@oracle.com>

Enable the Linux NFS client to observe the progress of an offloaded
asynchronous COPY operation. This new operation will be put to use
in a subsequent patch.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfs/nfs42proc.c        | 113 ++++++++++++++++++++++++++++++++++++++
 include/linux/nfs_fs_sb.h |   1 +
 2 files changed, 114 insertions(+)

diff --git a/fs/nfs/nfs42proc.c b/fs/nfs/nfs42proc.c
index 869605a0a9d5..c55247da8e49 100644
--- a/fs/nfs/nfs42proc.c
+++ b/fs/nfs/nfs42proc.c
@@ -21,6 +21,8 @@
 
 #define NFSDBG_FACILITY NFSDBG_PROC
 static int nfs42_do_offload_cancel_async(struct file *dst, nfs4_stateid *std);
+static int nfs42_proc_offload_status(struct file *file, nfs4_stateid *stateid,
+				     u64 *copied);
 
 static void nfs42_set_netaddr(struct file *filep, struct nfs42_netaddr *naddr)
 {
@@ -582,6 +584,117 @@ static int nfs42_do_offload_cancel_async(struct file *dst,
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
+	case -NFS4ERR_GRACE:
+		if (nfs4_async_handle_error(task, data->seq_server,
+					    NULL, NULL) == -EAGAIN)
+			rpc_restart_call_prepare(task);
+		else
+			task->tk_status = -EIO;
+		break;
+	case -NFS4ERR_ADMIN_REVOKED:
+	case -NFS4ERR_BAD_STATEID:
+	case -NFS4ERR_OLD_STATEID:
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
+/*
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
+	if (!data->res.complete_count) {
+		status = -EINPROGRESS;
+		goto out;
+	}
+	if (data->res.osr_complete[0] != NFS_OK) {
+		status = -EREMOTEIO;
+		goto out;
+	}
+
+out:
+	rpc_put_task(task);
+	return status;
+}
+
 static int _nfs42_proc_copy_notify(struct file *src, struct file *dst,
 				   struct nfs42_copy_notify_args *args,
 				   struct nfs42_copy_notify_res *res)
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
2.45.2



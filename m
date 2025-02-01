Return-Path: <linux-nfs+bounces-9821-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A5F29A245F6
	for <lists+linux-nfs@lfdr.de>; Sat,  1 Feb 2025 01:35:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5013A3A87E8
	for <lists+linux-nfs@lfdr.de>; Sat,  1 Feb 2025 00:35:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD94C35957;
	Sat,  1 Feb 2025 00:34:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eKQCmomx"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89FCE35953
	for <linux-nfs@vger.kernel.org>; Sat,  1 Feb 2025 00:34:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738370095; cv=none; b=Q+iNfsGBKSSt4spOAMM16ysmNBU5TlIA3VK7biJBXJwISqZOACdO7O+mn17hRg5/a06FxsOio8BwopHU6g6PORZ+BjMskUspfTIW9KWAU8zEDYmVzeDgxSO+V8l+kARgMaDXI6Jz8uXs80WG6Krht7GUSHZ5r8KYNKvlLR53WxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738370095; c=relaxed/simple;
	bh=MHGuVLz9VxHkBAxBM7GbE5N2RvoQrav56x72QdK5EbU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JYu62F0k7WDrFIshhwPVSBteEaNxQog5YcrqYYum3Tb63sjrZAWhSN8XLKEO5/fBodOZR5yk9Yo1XaFK158/6dmbcgOofHqVJaeKWfWvSDbMrDzpQliKX1M/5IJD8mhkn+Inwi6Oer3yUEPZ7mJeAUEY7EIOhleV0pIzp4987LY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eKQCmomx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53EFFC4CED1;
	Sat,  1 Feb 2025 00:34:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738370095;
	bh=MHGuVLz9VxHkBAxBM7GbE5N2RvoQrav56x72QdK5EbU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=eKQCmomxmv/Ht+s01CtlaHTgfTIyAzNvIzgzyflHY16F06ASWjk3frVW2PzkFCz//
	 29bpCWQQCniMbfII5HRnQvT4jAmIA614+7JzoSRC35Z395+HFxCMkj/I5736Tl26nx
	 tCaI1L5tDTCL0tQxZK0Y26GwFuXagkVCD9cSnc5EB6jnXg/gGqUlcY1hVFni+x6rZk
	 aPqzupUEc5qaTllNYYQqoII5MxfFDvk8et94lVw2OQbuk2UmfY5PXLvClWIOO0N/+X
	 LEwqWKac8EEd9rjMbGOfmgsrASyAiEV99seQ8EssA40WkHYmLAOaUQRXzfYPuyP/5i
	 zGKnnsQJ0K96A==
From: cel@kernel.org
To: Trond Myklebust <trond.myklebust@hammerspace.com>,
	Anna Schumaker <anna@kernel.org>
Cc: <linux-nfs@vger.kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>,
	Benjamin Coddington <bcodding@redhat.com>,
	Olga Kornievskaia <okorniev@redhat.com>
Subject: [PATCH v4 5/7] NFS: Implement NFSv4.2's OFFLOAD_STATUS operation
Date: Fri, 31 Jan 2025 19:34:45 -0500
Message-ID: <20250201003447.54614-6-cel@kernel.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20250201003447.54614-1-cel@kernel.org>
References: <20250201003447.54614-1-cel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chuck Lever <chuck.lever@oracle.com>

Enable the Linux NFS client to observe the progress of an offloaded
asynchronous COPY operation. This new operation will be put to use
in a subsequent patch.

Reviewed-by: Jeff Layton <jlayton@kernel.org>
Reviewed-by: Benjamin Coddington <bcodding@redhat.com>
Reviewed-by: Olga Kornievskaia <okorniev@redhat.com>
Tested-by: Olga Kornievskaia <okorniev@redhat.com>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfs/nfs42proc.c        | 105 ++++++++++++++++++++++++++++++++++++++
 fs/nfs/nfs4proc.c         |   3 +-
 include/linux/nfs_fs_sb.h |   1 +
 3 files changed, 108 insertions(+), 1 deletion(-)

diff --git a/fs/nfs/nfs42proc.c b/fs/nfs/nfs42proc.c
index 9d716907cf30..c560801aae96 100644
--- a/fs/nfs/nfs42proc.c
+++ b/fs/nfs/nfs42proc.c
@@ -21,6 +21,8 @@
 
 #define NFSDBG_FACILITY NFSDBG_PROC
 static int nfs42_do_offload_cancel_async(struct file *dst, nfs4_stateid *std);
+static int nfs42_proc_offload_status(struct file *file, nfs4_stateid *stateid,
+				     u64 *copied);
 
 static void nfs42_set_netaddr(struct file *filep, struct nfs42_netaddr *naddr)
 {
@@ -582,6 +584,109 @@ static int nfs42_do_offload_cancel_async(struct file *dst,
 	return status;
 }
 
+static int
+_nfs42_proc_offload_status(struct nfs_server *server, struct file *file,
+			   struct nfs42_offload_data *data)
+{
+	struct nfs_open_context *ctx = nfs_file_open_context(file);
+	struct rpc_message msg = {
+		.rpc_proc	= &nfs4_procedures[NFSPROC4_CLNT_OFFLOAD_STATUS],
+		.rpc_argp	= &data->args,
+		.rpc_resp	= &data->res,
+		.rpc_cred	= ctx->cred,
+	};
+	int status;
+
+	status = nfs4_call_sync(server->client, server, &msg,
+				&data->args.osa_seq_args,
+				&data->res.osr_seq_res, 1);
+	switch (status) {
+	case 0:
+		break;
+
+	case -NFS4ERR_ADMIN_REVOKED:
+	case -NFS4ERR_BAD_STATEID:
+	case -NFS4ERR_OLD_STATEID:
+		/*
+		 * Server does not recognize the COPY stateid. CB_OFFLOAD
+		 * could have purged it, or server might have rebooted.
+		 * Since COPY stateids don't have an associated inode,
+		 * avoid triggering state recovery.
+		 */
+		status = -EBADF;
+		break;
+	case -NFS4ERR_NOTSUPP:
+	case -ENOTSUPP:
+	case -EOPNOTSUPP:
+		server->caps &= ~NFS_CAP_OFFLOAD_STATUS;
+		status = -EOPNOTSUPP;
+		break;
+	}
+
+	return status;
+}
+
+/**
+ * nfs42_proc_offload_status - Poll completion status of an async copy operation
+ * @dst: handle of file being copied into
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
+static int __maybe_unused
+nfs42_proc_offload_status(struct file *dst, nfs4_stateid *stateid, u64 *copied)
+{
+	struct inode *inode = file_inode(dst);
+	struct nfs_server *server = NFS_SERVER(inode);
+	struct nfs4_exception exception = {
+		.inode = inode,
+	};
+	struct nfs42_offload_data *data;
+	int status;
+
+	*copied = 0;
+
+	if (!(server->caps & NFS_CAP_OFFLOAD_STATUS))
+		return -EOPNOTSUPP;
+
+	data = kzalloc(sizeof(*data), GFP_KERNEL);
+	if (!data)
+		return -ENOMEM;
+	data->seq_server = server;
+	data->args.osa_src_fh = NFS_FH(inode);
+	memcpy(&data->args.osa_stateid, stateid,
+		sizeof(data->args.osa_stateid));
+	exception.stateid = &data->args.osa_stateid;
+	do {
+		status = _nfs42_proc_offload_status(server, dst, data);
+		if (status == -EOPNOTSUPP)
+			goto out;
+		status = nfs4_handle_exception(server, status, &exception);
+	} while (exception.retry);
+	if (status)
+		goto out;
+
+	*copied = data->res.osr_count;
+	if (!data->res.complete_count)
+		status = -EINPROGRESS;
+	else if (data->res.osr_complete != NFS_OK)
+		status = -EREMOTEIO;
+
+out:
+	kfree(data);
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



Return-Path: <linux-nfs+bounces-8691-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 919629F95AB
	for <lists+linux-nfs@lfdr.de>; Fri, 20 Dec 2024 16:45:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C0FEE7A1764
	for <lists+linux-nfs@lfdr.de>; Fri, 20 Dec 2024 15:45:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50EC6218EA8;
	Fri, 20 Dec 2024 15:42:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m78cC58A"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2118221A428
	for <linux-nfs@vger.kernel.org>; Fri, 20 Dec 2024 15:42:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734709363; cv=none; b=CNkpyVRD7NA+QQLbpN4k9BXTtV7ML37hUzIIdNbLDEKr2ji+y1FYom8A6meZNSX22tScHI7P9enRMLOVrMvXzY+vTcsv9pVK8Q3ETU8sfp+SKt09DLP4s2G++EUi81ep2ObWdd02XIVkIOHqF3V281mkMYrqbqqClbjWWH+06SE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734709363; c=relaxed/simple;
	bh=ISlhW1IQuYeNtxVL0g4+pSklooPJq00V6urddc4CUfM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GzmN44LUx8R0yX5c4Du/X7CIXXxO51vtv1pjhxkYCcExBWlVUq9HO0rWmYYa/dx3VruVaI+rkH2F6cN+8J/NmY4/Ym8KxB0yxPCFfr99BsOLJn6wLSlQC6HoBAuKUwvm3APKK+4AN43vJM35vUnDsrE3NXx4mkoku/S7zae2+no=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m78cC58A; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B392C4CECD;
	Fri, 20 Dec 2024 15:42:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734709363;
	bh=ISlhW1IQuYeNtxVL0g4+pSklooPJq00V6urddc4CUfM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=m78cC58AI8VTnUARpFJU85XtUDKOYWtA9NggSuu1YCtDym85fa1oN32GzfVh4Wvra
	 eMAS1G1XNxOc87A3nc7xzB6RvBAsR+3pr4Ng4K+7Ppwu8/XwwrmIcQ2L7P45CTOSR7
	 6CF7Cw7A2DPin2SM19yjti7+ymd4TTrUbWV5Gfv8WbOYeIV17Z4phlGxOQSeqt1cTH
	 B9XQYsaXAGT/2ih/HPiO/vOS/YithbbJ/C77sDfFqSmvaYRP5Qr/VhFOirVPHg8fYv
	 moPTNjImo9hyuTCwVZfIAuNq/LhB2p8E1umEv6bEkcjFMVRgbnmqURR/wy+dt6/n8A
	 VbId3qH1X1flg==
From: cel@kernel.org
To: Olga Kornievskaia <okorniev@redhat.com>,
	Trond Myklebust <trond.myklebust@hammerspace.com>,
	Anna Schumaker <anna@kernel.org>
Cc: <linux-nfs@vger.kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>
Subject: [PATCH v2 5/7] NFS: Implement NFSv4.2's OFFLOAD_STATUS operation
Date: Fri, 20 Dec 2024 10:42:33 -0500
Message-ID: <20241220154227.16873-14-cel@kernel.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241220154227.16873-9-cel@kernel.org>
References: <20241220154227.16873-9-cel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=5121; i=chuck.lever@oracle.com; h=from:subject; bh=2535XkMAeW/LrAT13jLC3R047rB1D+11KdwMAV8JhqI=; b=owEBbQKS/ZANAwAIATNqszNvZn+XAcsmYgBnZZBq2/C5379WGghjLDmJrcKaIoQ9sXl8u1ij3 cHcKfTGcW6JAjMEAAEIAB0WIQQosuWwEobfJDzyPv4zarMzb2Z/lwUCZ2WQagAKCRAzarMzb2Z/ l7taEACUY+0UEUOeAXsa09jIVe+Ah2RWElouG+4ubs4xu6W05K+KofpDBtgt34DBu5AxkWWewaU RbOQd/DKV8qcS25AwLgvypWwn36lKyBxv5dK8Q9lvzyXREVYeDbEu9mMHgxRLpkwui/PkZ8u2nV bzKVjrzqroxt/xKawDMEobCmsA4HVqBnaNusxTKh1Txt4Z8e7wRmyqbAtr46MY+8C6xkAqxstcA KoNYrx0ZDQEHC15ZlhMwfcdP6GFDvo649Qi9eNcdgXlHJto4fI+NaEwjWMIDvmFkrQpSmjS1oFI wb1N118P7vcXXeSSrcQnJo34zQrIVZJnXzhaN7IbxbAESMfzuppvkG4TCaFc0Okbzmu5/vzmVRy J/6rzqprbIQX7x0xDowv59XYcY+u3wyglOYznOeMX3cebYq8A6f0VYo98rmiP2Ke+2APLVn5A4R 3dNgKmiUXoRJDWKgHKcywcGyqzrD0XZ7B/8D3SgsOPejPpdvoJ0VAXQ9rbCZ/FtduVpUE9KqQlv e8Oqv/g6IOXjek0Py/YYgZibIvtoh3joUTdZqvrUOIyoalyHeccDjW+ZZzI0AWaFniDHTVtTQOD uw+PhRYoLLPKMiA8VZy2XvekzR2S35FWS0wB2cvb0ze1Cl/m9tiinp/6qUFUNH+M79HRVbIneL+ f5JmzBnwxS7Xu+Q==
X-Developer-Key: i=chuck.lever@oracle.com; a=openpgp; fpr=28B2E5B01286DF243CF23EFE336AB3336F667F97
Content-Transfer-Encoding: 8bit

From: Chuck Lever <chuck.lever@oracle.com>

Enable the Linux NFS client to observe the progress of an offloaded
asynchronous COPY operation. This new operation will be put to use
in a subsequent patch.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfs/nfs42proc.c        | 101 ++++++++++++++++++++++++++++++++++++++
 fs/nfs/nfs4proc.c         |   3 +-
 include/linux/nfs_fs_sb.h |   1 +
 3 files changed, 104 insertions(+), 1 deletion(-)

diff --git a/fs/nfs/nfs42proc.c b/fs/nfs/nfs42proc.c
index 9d716907cf30..7fd0f2aa42d4 100644
--- a/fs/nfs/nfs42proc.c
+++ b/fs/nfs/nfs42proc.c
@@ -21,6 +21,8 @@
 
 #define NFSDBG_FACILITY NFSDBG_PROC
 static int nfs42_do_offload_cancel_async(struct file *dst, nfs4_stateid *std);
+static int nfs42_proc_offload_status(struct file *file, nfs4_stateid *stateid,
+				     u64 *copied);
 
 static void nfs42_set_netaddr(struct file *filep, struct nfs42_netaddr *naddr)
 {
@@ -582,6 +584,105 @@ static int nfs42_do_offload_cancel_async(struct file *dst,
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



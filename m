Return-Path: <linux-nfs+bounces-9168-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FA25A0BC15
	for <lists+linux-nfs@lfdr.de>; Mon, 13 Jan 2025 16:33:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2F1E03A1704
	for <lists+linux-nfs@lfdr.de>; Mon, 13 Jan 2025 15:32:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DB1A1FBBD6;
	Mon, 13 Jan 2025 15:32:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AedY1A27"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 286AA1FBBD4
	for <linux-nfs@vger.kernel.org>; Mon, 13 Jan 2025 15:32:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736782371; cv=none; b=XbGWoL2k0XP0PuHJ6wvyWAqTXPfGb+Atmn8iwsZmAjy03GROYPu09jd5ba7iv8dAI2MaxiINDXUEGAVBTJKHBoT6cu7gs8fYb0JFt0tv8/OiX7ykT/jn0JXS5y4oL28MmFB2u2XOnELdq5w9ASc7BoSG2YyT1epn7RYPOGidsGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736782371; c=relaxed/simple;
	bh=NpDrhUg13464ShKgMBnN+WPef70qhHI11+pKs7Vicaw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JhZ6FcXRJzOBMBvzuNJp/44MAOUZDNy5EvvpgwsdmXjOlFnhxMoOLAcyxesnOykZ0Z0KcIOnC9KxWS7oQBofnpGltmI89Ygsy30m88tiTf8pzJ3NYCDt556oib97egc9vfh6hpRca40dKoiyqIbXF6G1XoMv0I6UTcz8bUxX+S8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AedY1A27; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13E18C4CEE4;
	Mon, 13 Jan 2025 15:32:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736782370;
	bh=NpDrhUg13464ShKgMBnN+WPef70qhHI11+pKs7Vicaw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=AedY1A27l1HyOHdpogX8PGYq6bhbMQM0ptR4Bapvs26pyKrDWb3fJOl6duj16fKUH
	 MOgpFj4RqmZngOrxGSKhK2lY7G/IzVfr7nh8OyAE6MQ5a9SdRMLgrGWSR/0UREd8Hl
	 /qWza2sHRb01qXVCAxhTUj+J+D+gSefgbL683Tc0oYUqqGUsXayXynTKnk9Zy86eWs
	 rpSpMZowDKmHK8i7zB7+tCEpAIpeW3E3nmEZURyhMIf54Y3BCXCI3F3aJSkhwWZJKG
	 1VFs6/Blj/O0at6p550XMGuY9kNEmNOLrLUt+8QAqt5WZH+Jud7daQBFq+ScUuuo98
	 uDgRvsm4o3NpA==
From: cel@kernel.org
To: Neil Brown <neilb@suse.de>,
	Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>
Cc: <linux-nfs@vger.kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>
Subject: [PATCH v3 5/7] NFS: Implement NFSv4.2's OFFLOAD_STATUS operation
Date: Mon, 13 Jan 2025 10:32:40 -0500
Message-ID: <20250113153235.48706-14-cel@kernel.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20250113153235.48706-9-cel@kernel.org>
References: <20250113153235.48706-9-cel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=5197; i=chuck.lever@oracle.com; h=from:subject; bh=U6fUcIARHwP9x5OsVme1NO6lN3U1mXLsRB7y4MhNakQ=; b=owEBbQKS/ZANAwAIATNqszNvZn+XAcsmYgBnhTIaaggv//8U3uVi0am6kr3wH4n8Q6SgUFLsd nx3QYg9c/KJAjMEAAEIAB0WIQQosuWwEobfJDzyPv4zarMzb2Z/lwUCZ4UyGgAKCRAzarMzb2Z/ l3JMD/9Gshp4D03JiX6AgWsHkFA3V3XEbwPaWvJfnHWZ8T18PhfmIXwjudEJsfoHzp3p6Bsn/dt VxEDDx9uLPZTXcchsgQVmi+P1V2fOrxTqoDV48qRXx+4ZaiLxen8KcevvoYxL85oerOQppFIwTo IjjqhQeYB0Sb+8Hq2PY6pd8JlSgxfoyTijyvPZuHaF0TnWTYU+3pcida7DpEDqsKORDbKuZVy+O cYxbMObbeBc1sge9lJxFvkQXymZRKqBbJzbQtB+vA18QsSOety5KsMHGHcdSWFN7JPj6yooWsBD zgnKt53Qr+kUfObBkoUGIfVyeqY3Q4eSnhBCR+ZrGnPMlhXaIUaI3Lp/ZZ3J5hSdAC6JoTiWVwN DstIbmmpg+2+vJw1h3FL2lbxWab1p/mJMpEqWPEkeVS/1wc0aT/1rQ0oG3mNWk+ToRQoEKqT0iK Ta0P5FMt3Hih8zbPud7cu1ViBzGwDHWBg1r1jo7Bjdty3X2ulPC5SmOj0iAOEV5cEHrK//DKlKb pg7r55ucdTi4N7CxMa/hOiyJjWLLxiB0BmCFZJvauMqMqI5D6fHJUkR6vsRlIKKZUmvh0PD+rfM 9iLoeNrMDMtzxiSoFFFq8Sb8YnrW/QUw0bseloC8+asjO4G51Ft0I5WbO5wM0L/e5Elf1n8cRzT 3XNs8jTaEK1kaxA==
X-Developer-Key: i=chuck.lever@oracle.com; a=openpgp; fpr=28B2E5B01286DF243CF23EFE336AB3336F667F97
Content-Transfer-Encoding: 8bit

From: Chuck Lever <chuck.lever@oracle.com>

Enable the Linux NFS client to observe the progress of an offloaded
asynchronous COPY operation. This new operation will be put to use
in a subsequent patch.

Reviewed-by: Jeff Layton <jlayton@kernel.org>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfs/nfs42proc.c        | 103 ++++++++++++++++++++++++++++++++++++++
 fs/nfs/nfs4proc.c         |   3 +-
 include/linux/nfs_fs_sb.h |   1 +
 3 files changed, 106 insertions(+), 1 deletion(-)

diff --git a/fs/nfs/nfs42proc.c b/fs/nfs/nfs42proc.c
index 9d716907cf30..23508669d051 100644
--- a/fs/nfs/nfs42proc.c
+++ b/fs/nfs/nfs42proc.c
@@ -21,6 +21,8 @@
 
 #define NFSDBG_FACILITY NFSDBG_PROC
 static int nfs42_do_offload_cancel_async(struct file *dst, nfs4_stateid *std);
+static int nfs42_proc_offload_status(struct file *file, nfs4_stateid *stateid,
+				     u64 *copied);
 
 static void nfs42_set_netaddr(struct file *filep, struct nfs42_netaddr *naddr)
 {
@@ -582,6 +584,107 @@ static int nfs42_do_offload_cancel_async(struct file *dst,
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



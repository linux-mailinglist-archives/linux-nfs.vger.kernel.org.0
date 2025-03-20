Return-Path: <linux-nfs+bounces-10732-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E47FEA6AF48
	for <lists+linux-nfs@lfdr.de>; Thu, 20 Mar 2025 21:40:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3BEF67AB866
	for <lists+linux-nfs@lfdr.de>; Thu, 20 Mar 2025 20:39:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41AB5229B1F;
	Thu, 20 Mar 2025 20:40:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OZqNrEoP"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CC3B1DDA39
	for <linux-nfs@vger.kernel.org>; Thu, 20 Mar 2025 20:40:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742503225; cv=none; b=oKsBzcNvta7u17zrJDlDu6Zeuvg6balaHksKQpATb7+WA83CL+ahQzrwcqsDMkudeDBUIZ8EvESlUkroeY+msjDktKVJpU1p8Xay7pqaInCf+gLKsFQbZfTpYrarkMGHqXqwISeTJUTxOPbIDHD4HUq+URYnLL32dyBaZCfKgTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742503225; c=relaxed/simple;
	bh=7YDEWvF0IRqbiFzELvgHT411W1AWdHXOPf/VBvNw018=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BqpNHwI0BSBdRZQZcVeScBPzkXJS0z0JKHRjc87EtEmWEDSeKWlmQQ6FfCql2+NTJ8Z/4mtfe+VJXIcFxGCN52CKGZK6PUyzcUwFx9VvywezxS1q+nsL0EIMiXoK0bVxp99lbSw0M0GvD0QM6wKIy0QSCSeU413/MBxB0DrkYuc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OZqNrEoP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A63DFC4CEE8;
	Thu, 20 Mar 2025 20:40:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742503225;
	bh=7YDEWvF0IRqbiFzELvgHT411W1AWdHXOPf/VBvNw018=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=OZqNrEoPehMIttlO5wIC2OgKfipsy9lhD4Zm5ZuHSuw3RHjlFz9gvZFN+anFm6jCr
	 bwd4zf73caAgrAUPRUQ71fih6n49ogUNPqXRdyf6H4O1mPEGmlCfUP7QAqOuIaOwBz
	 3mXDsqGELmRC8dcDsDKB3/Udr/9w8qxuUk6bpQRQ6zRoHixk7L9IqQvqQ8mfuOvFTx
	 1jPlWH6mzQiGVXpFBsqUAgA2/ES4EyRYIWTNJ1UfwQdocXZ/f3IyxGCWprEfZIa/DN
	 C1nEHoIUYnk0Zob31WE7xUY9qilZC/gREBQN+A0nN8iTOaG9SGRYsu8Cxil8qRLXK6
	 KGt1nLgISxnxg==
From: trondmy@kernel.org
To: linux-nfs@vger.kernel.org
Cc: Jeff Layton <jlayton@kernel.org>,
	Josef Bacik <josef@toxicpanda.com>
Subject: [PATCH RFC v2 3/4] pNFS/flexfiles: Treat ENETUNREACH errors as fatal in containers
Date: Thu, 20 Mar 2025 16:40:20 -0400
Message-ID: <ec593b842e52f0b3966b8a2073ea3fb3f9666fd6.1742502819.git.trond.myklebust@hammerspace.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <cover.1742502819.git.trond.myklebust@hammerspace.com>
References: <cover.1742502819.git.trond.myklebust@hammerspace.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Trond Myklebust <trond.myklebust@hammerspace.com>

Propagate the NFS_MOUNT_NETUNREACH_FATAL flag to work with the pNFS
flexfiles client. In these circumstances, the client needs to treat the
ENETDOWN and ENETUNREACH errors as fatal, and should abandon the
attempted I/O.

Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 fs/nfs/flexfilelayout/flexfilelayout.c | 23 +++++++++++++++++++++--
 fs/nfs/nfs3client.c                    |  2 ++
 fs/nfs/nfs4client.c                    |  5 +++++
 include/linux/nfs4.h                   |  1 +
 4 files changed, 29 insertions(+), 2 deletions(-)

diff --git a/fs/nfs/flexfilelayout/flexfilelayout.c b/fs/nfs/flexfilelayout/flexfilelayout.c
index 98b45b636be3..f89fdba7289d 100644
--- a/fs/nfs/flexfilelayout/flexfilelayout.c
+++ b/fs/nfs/flexfilelayout/flexfilelayout.c
@@ -1154,10 +1154,14 @@ static int ff_layout_async_handle_error_v4(struct rpc_task *task,
 		rpc_wake_up(&tbl->slot_tbl_waitq);
 		goto reset;
 	/* RPC connection errors */
+	case -ENETDOWN:
+	case -ENETUNREACH:
+		if (test_bit(NFS_CS_NETUNREACH_FATAL, &clp->cl_flags))
+			return -NFS4ERR_FATAL_IOERROR;
+		fallthrough;
 	case -ECONNREFUSED:
 	case -EHOSTDOWN:
 	case -EHOSTUNREACH:
-	case -ENETUNREACH:
 	case -EIO:
 	case -ETIMEDOUT:
 	case -EPIPE:
@@ -1183,6 +1187,7 @@ static int ff_layout_async_handle_error_v4(struct rpc_task *task,
 
 /* Retry all errors through either pNFS or MDS except for -EJUKEBOX */
 static int ff_layout_async_handle_error_v3(struct rpc_task *task,
+					   struct nfs_client *clp,
 					   struct pnfs_layout_segment *lseg,
 					   u32 idx)
 {
@@ -1200,6 +1205,11 @@ static int ff_layout_async_handle_error_v3(struct rpc_task *task,
 	case -EJUKEBOX:
 		nfs_inc_stats(lseg->pls_layout->plh_inode, NFSIOS_DELAY);
 		goto out_retry;
+	case -ENETDOWN:
+	case -ENETUNREACH:
+		if (test_bit(NFS_CS_NETUNREACH_FATAL, &clp->cl_flags))
+			return -NFS4ERR_FATAL_IOERROR;
+		fallthrough;
 	default:
 		dprintk("%s DS connection error %d\n", __func__,
 			task->tk_status);
@@ -1234,7 +1244,7 @@ static int ff_layout_async_handle_error(struct rpc_task *task,
 
 	switch (vers) {
 	case 3:
-		return ff_layout_async_handle_error_v3(task, lseg, idx);
+		return ff_layout_async_handle_error_v3(task, clp, lseg, idx);
 	case 4:
 		return ff_layout_async_handle_error_v4(task, state, clp,
 						       lseg, idx);
@@ -1337,6 +1347,9 @@ static int ff_layout_read_done_cb(struct rpc_task *task,
 		return task->tk_status;
 	case -EAGAIN:
 		goto out_eagain;
+	case -NFS4ERR_FATAL_IOERROR:
+		task->tk_status = -EIO;
+		return 0;
 	}
 
 	return 0;
@@ -1507,6 +1520,9 @@ static int ff_layout_write_done_cb(struct rpc_task *task,
 		return task->tk_status;
 	case -EAGAIN:
 		return -EAGAIN;
+	case -NFS4ERR_FATAL_IOERROR:
+		task->tk_status = -EIO;
+		return 0;
 	}
 
 	if (hdr->res.verf->committed == NFS_FILE_SYNC ||
@@ -1551,6 +1567,9 @@ static int ff_layout_commit_done_cb(struct rpc_task *task,
 	case -EAGAIN:
 		rpc_restart_call_prepare(task);
 		return -EAGAIN;
+	case -NFS4ERR_FATAL_IOERROR:
+		task->tk_status = -EIO;
+		return 0;
 	}
 
 	ff_layout_set_layoutcommit(data->inode, data->lseg, data->lwb);
diff --git a/fs/nfs/nfs3client.c b/fs/nfs/nfs3client.c
index b0c8a39c2bbd..0d7310c1ee0c 100644
--- a/fs/nfs/nfs3client.c
+++ b/fs/nfs/nfs3client.c
@@ -120,6 +120,8 @@ struct nfs_client *nfs3_set_ds_client(struct nfs_server *mds_srv,
 
 	if (mds_srv->flags & NFS_MOUNT_NORESVPORT)
 		__set_bit(NFS_CS_NORESVPORT, &cl_init.init_flags);
+	if (test_bit(NFS_CS_NETUNREACH_FATAL, &mds_clp->cl_flags))
+		__set_bit(NFS_CS_NETUNREACH_FATAL, &cl_init.init_flags);
 
 	__set_bit(NFS_CS_DS, &cl_init.init_flags);
 
diff --git a/fs/nfs/nfs4client.c b/fs/nfs/nfs4client.c
index 8f7d40844cdc..9bfb88d791ab 100644
--- a/fs/nfs/nfs4client.c
+++ b/fs/nfs/nfs4client.c
@@ -939,6 +939,9 @@ static int nfs4_set_client(struct nfs_server *server,
 		__set_bit(NFS_CS_TSM_POSSIBLE, &cl_init.init_flags);
 	server->port = rpc_get_port((struct sockaddr *)addr);
 
+	if (server->options & NFS_MOUNT_NETUNREACH_FATAL)
+		__set_bit(NFS_CS_NETUNREACH_FATAL, &cl_init.init_flags);
+
 	/* Allocate or find a client reference we can use */
 	clp = nfs_get_client(&cl_init);
 	if (IS_ERR(clp))
@@ -1013,6 +1016,8 @@ struct nfs_client *nfs4_set_ds_client(struct nfs_server *mds_srv,
 
 	if (mds_srv->flags & NFS_MOUNT_NORESVPORT)
 		__set_bit(NFS_CS_NORESVPORT, &cl_init.init_flags);
+	if (test_bit(NFS_CS_NETUNREACH_FATAL, &mds_clp->cl_flags))
+		__set_bit(NFS_CS_NETUNREACH_FATAL, &cl_init.init_flags);
 
 	__set_bit(NFS_CS_PNFS, &cl_init.init_flags);
 	cl_init.max_connect = NFS_MAX_TRANSPORTS;
diff --git a/include/linux/nfs4.h b/include/linux/nfs4.h
index 5fa60fe441b5..d8cad844870a 100644
--- a/include/linux/nfs4.h
+++ b/include/linux/nfs4.h
@@ -300,6 +300,7 @@ enum nfsstat4 {
 /* error codes for internal client use */
 #define NFS4ERR_RESET_TO_MDS   12001
 #define NFS4ERR_RESET_TO_PNFS  12002
+#define NFS4ERR_FATAL_IOERROR  12003
 
 static inline bool seqid_mutating_err(u32 err)
 {
-- 
2.48.1



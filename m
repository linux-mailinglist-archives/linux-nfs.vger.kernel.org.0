Return-Path: <linux-nfs+bounces-7966-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B49519C81A5
	for <lists+linux-nfs@lfdr.de>; Thu, 14 Nov 2024 05:00:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C281BB247D2
	for <lists+linux-nfs@lfdr.de>; Thu, 14 Nov 2024 04:00:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 256B91E908A;
	Thu, 14 Nov 2024 04:00:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qHFH52/T"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 011A81E9076
	for <linux-nfs@vger.kernel.org>; Thu, 14 Nov 2024 04:00:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731556814; cv=none; b=nifbB5J19YZGVwiQjQImE59ZfVFe//Kikc9ZCPhGLr1BTQKSbvHIniQICms9qD5uO6ISNcXV0jCbQJatEP0Y+bSjDSeGxxh7gDnyBgerLcHyNI3V8C5Jyk5wdlUEydL6VBcY9wGbJ5MqOQ0PthCaD8kmnEu+lB5x3nNN3nrfKkw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731556814; c=relaxed/simple;
	bh=KyC2LAmrc9W9cAAgfHsl2reBdD/tZ2y7y0h1wnrUNRo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uc1JR+IJCut3IpMOLYhZGXvSJ3cqGcqR+UpOvU2BKnt1JCJMXiQ7l75f9KVgqA4wqJAPyu7ZSWqgEzusUVFPPAnVpjrxS7qUvzzKNRtz3UH5u3ZlKA6c5cERV+uTxwWfBm/M+mXR/Qh5aYLAALa5/YO6K0W+Q2YK413U20hjRNg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qHFH52/T; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59C4FC4CED0;
	Thu, 14 Nov 2024 04:00:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731556813;
	bh=KyC2LAmrc9W9cAAgfHsl2reBdD/tZ2y7y0h1wnrUNRo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qHFH52/TIkU4tap9Qb9e3b5Kkc3dmunZ01B2rk15obQaIMtbYB+sLinUGr89fSbBf
	 hTebJryJlWLnK1LfJyB+rROGu617uqQOLGWFHuZWIcgEr4GMQSDX2nH1dn154oCTJR
	 GwVqcJR5UkTLVTRTiQtaN+JGFvl80h7f0VFi03p2Rk+qSGcHAexx/Adl9sDPe1gmv6
	 w6HPkW5hvyb8pt2h7q7XT3DlmGs5GoCUU7wul5ryL6SpKZJSy1IjHxE8xUsIxCdh2f
	 H2xEla5YG5t9ZGZqEKJrnkeoLl5jfQcG4SjWA19qI230bmuhCyrdNCcQbKNrOikZO2
	 S4N7GUiuH5R1g==
From: Mike Snitzer <snitzer@kernel.org>
To: linux-nfs@vger.kernel.org
Cc: Anna Schumaker <anna@kernel.org>,
	Trond Myklebust <trondmy@hammerspace.com>,
	Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>,
	NeilBrown <neilb@suse.de>
Subject: [for-6.13 PATCH v2 15/15] nfs: probe for LOCALIO when v3 client reconnects to server
Date: Wed, 13 Nov 2024 22:59:52 -0500
Message-ID: <20241114035952.13889-16-snitzer@kernel.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20241114035952.13889-1-snitzer@kernel.org>
References: <20241114035952.13889-1-snitzer@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Re-enabling NFSv3 LOCALIO is made more complex (than NFSv4) because v3
is stateless.  As such, the hueristic used to identify a LOCALIO probe
point is more adhoc by nature: if/when NFSv3 client IO begins to
complete again in terms of normal RPC-based NFSv3 server IO, attempt
nfs_local_probe_async().

Care is taken to throttle the frequency of nfs_local_probe_async(),
otherwise there could be a flood of repeat calls to
nfs_local_probe_async().

This approach works for most use-cases but it doesn't handle the
possibility of using HA to migrate an NFS server local to the same
host as an NFS client that is actively connected to the migrated NFS
server. NFSv3 LOCALIO won't handle this case given it relies on the
client having been flagged with NFS_CS_LOCAL_IO when the client was
created on the host (e.g. mount time).

Alternatve approaches have been discussed but there isn't clear
consensus yet.

Signed-off-by: Mike Snitzer <snitzer@kernel.org>
---
 fs/nfs/internal.h          |  5 +++++
 fs/nfs/localio.c           | 18 +++++++++++++++++-
 fs/nfs/nfs3proc.c          | 32 +++++++++++++++++++++++++++++---
 fs/nfs_common/nfslocalio.c |  1 +
 include/linux/nfslocalio.h |  3 ++-
 5 files changed, 54 insertions(+), 5 deletions(-)

diff --git a/fs/nfs/internal.h b/fs/nfs/internal.h
index ad9c56bc977bf..14f4d871b6a30 100644
--- a/fs/nfs/internal.h
+++ b/fs/nfs/internal.h
@@ -470,6 +470,7 @@ extern int nfs_local_commit(struct nfsd_file *,
 			    struct nfs_commit_data *,
 			    const struct rpc_call_ops *, int);
 extern bool nfs_server_is_local(const struct nfs_client *clp);
+extern bool nfs_server_was_local(const struct nfs_client *clp);
 
 #else /* CONFIG_NFS_LOCALIO */
 static inline void nfs_local_probe(struct nfs_client *clp) {}
@@ -498,6 +499,10 @@ static inline bool nfs_server_is_local(const struct nfs_client *clp)
 {
 	return false;
 }
+static inline bool nfs_server_was_local(const struct nfs_client *clp)
+{
+	return false;
+}
 #endif /* CONFIG_NFS_LOCALIO */
 
 /* super.c */
diff --git a/fs/nfs/localio.c b/fs/nfs/localio.c
index 1eee5aac28843..d5152aa46813c 100644
--- a/fs/nfs/localio.c
+++ b/fs/nfs/localio.c
@@ -65,6 +65,17 @@ bool nfs_server_is_local(const struct nfs_client *clp)
 }
 EXPORT_SYMBOL_GPL(nfs_server_is_local);
 
+static inline bool nfs_client_was_local(const struct nfs_client *clp)
+{
+	return !!test_bit(NFS_CS_LOCAL_IO, &clp->cl_flags);
+}
+
+bool nfs_server_was_local(const struct nfs_client *clp)
+{
+	return nfs_client_was_local(clp) && localio_enabled;
+}
+EXPORT_SYMBOL_GPL(nfs_server_was_local);
+
 /*
  * UUID_IS_LOCAL XDR functions
  */
@@ -187,8 +198,13 @@ void nfs_local_probe(struct nfs_client *clp)
 
 	if (!nfs_uuid_begin(&clp->cl_uuid))
 		return;
-	if (nfs_server_uuid_is_local(clp))
+	if (nfs_server_uuid_is_local(clp)) {
 		nfs_localio_enable_client(clp);
+		/* Set hint that client and server are LOCALIO capable */
+		spin_lock(&clp->cl_uuid.lock);
+		set_bit(NFS_CS_LOCAL_IO, &clp->cl_flags);
+		spin_unlock(&clp->cl_uuid.lock);
+	}
 	nfs_uuid_end(&clp->cl_uuid);
 }
 EXPORT_SYMBOL_GPL(nfs_local_probe);
diff --git a/fs/nfs/nfs3proc.c b/fs/nfs/nfs3proc.c
index 1566163c6d85b..6ed2e4466002d 100644
--- a/fs/nfs/nfs3proc.c
+++ b/fs/nfs/nfs3proc.c
@@ -844,6 +844,27 @@ nfs3_proc_pathconf(struct nfs_server *server, struct nfs_fh *fhandle,
 	return status;
 }
 
+static void nfs3_local_probe(struct nfs_server *server)
+{
+#if IS_ENABLED(CONFIG_NFS_LOCALIO)
+	struct nfs_client *clp = server->nfs_client;
+	nfs_uuid_t *nfs_uuid = &clp->cl_uuid;
+
+	if (likely(!nfs_server_was_local(clp)))
+		return;
+	/*
+	 * Try re-enabling LOCALIO if it was previously enabled, but
+	 * was disabled due to server restart, and IO has successfully
+	 * completed in terms of normal RPC.
+	 */
+	/* Arbitrary throttle to reduce nfs_local_probe_async() frequency */
+	if ((nfs_uuid->local_probe_count++ & 511) == 0) {
+		if (unlikely(!nfs_server_is_local(clp) && nfs_server_was_local(clp)))
+			nfs_local_probe_async(clp);
+	}
+#endif
+}
+
 static int nfs3_read_done(struct rpc_task *task, struct nfs_pgio_header *hdr)
 {
 	struct inode *inode = hdr->inode;
@@ -855,8 +876,11 @@ static int nfs3_read_done(struct rpc_task *task, struct nfs_pgio_header *hdr)
 	if (nfs3_async_handle_jukebox(task, inode))
 		return -EAGAIN;
 
-	if (task->tk_status >= 0 && !server->read_hdrsize)
-		cmpxchg(&server->read_hdrsize, 0, hdr->res.replen);
+	if (task->tk_status >= 0) {
+		if (!server->read_hdrsize)
+			cmpxchg(&server->read_hdrsize, 0, hdr->res.replen);
+		nfs3_local_probe(server);
+	}
 
 	nfs_invalidate_atime(inode);
 	nfs_refresh_inode(inode, &hdr->fattr);
@@ -886,8 +910,10 @@ static int nfs3_write_done(struct rpc_task *task, struct nfs_pgio_header *hdr)
 
 	if (nfs3_async_handle_jukebox(task, inode))
 		return -EAGAIN;
-	if (task->tk_status >= 0)
+	if (task->tk_status >= 0) {
 		nfs_writeback_update_inode(hdr);
+		nfs3_local_probe(NFS_SERVER(inode));
+	}
 	return 0;
 }
 
diff --git a/fs/nfs_common/nfslocalio.c b/fs/nfs_common/nfslocalio.c
index 0a26c0ca99c21..41c0077ead721 100644
--- a/fs/nfs_common/nfslocalio.c
+++ b/fs/nfs_common/nfslocalio.c
@@ -43,6 +43,7 @@ void nfs_uuid_init(nfs_uuid_t *nfs_uuid)
 	INIT_LIST_HEAD(&nfs_uuid->list);
 	INIT_LIST_HEAD(&nfs_uuid->files);
 	spin_lock_init(&nfs_uuid->lock);
+	nfs_uuid->local_probe_count = 0;
 }
 EXPORT_SYMBOL_GPL(nfs_uuid_init);
 
diff --git a/include/linux/nfslocalio.h b/include/linux/nfslocalio.h
index c68a529230c14..e05f1cf3cf476 100644
--- a/include/linux/nfslocalio.h
+++ b/include/linux/nfslocalio.h
@@ -27,7 +27,8 @@ struct nfs_file_localio;
  */
 typedef struct {
 	uuid_t uuid;
-	/* sadly this struct is just over a cacheline, avoid bouncing */
+	unsigned local_probe_count;
+	/* sadly this struct is over a cacheline, avoid bouncing */
 	spinlock_t ____cacheline_aligned lock;
 	struct list_head list;
 	spinlock_t *list_lock; /* nn->local_clients_lock */
-- 
2.44.0



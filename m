Return-Path: <linux-nfs+bounces-8031-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B607C9CFC48
	for <lists+linux-nfs@lfdr.de>; Sat, 16 Nov 2024 02:41:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3AB821F24D8B
	for <lists+linux-nfs@lfdr.de>; Sat, 16 Nov 2024 01:41:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEBFE1922D8;
	Sat, 16 Nov 2024 01:41:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kKU5QPxR"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAE701917E6
	for <linux-nfs@vger.kernel.org>; Sat, 16 Nov 2024 01:41:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731721288; cv=none; b=SvofjXD6F4jrwEUlIPFoShRylWmRPzfap/XwYMONkZTxBdCmm3Zg8P83wQBKbKZy3N45+JuJEfhWZk3bx90mhsy4JaFzw3fM0x9xZqYmG+MRjzPqbqzc7yEQ5gwmaS5NRZ9ro4jKlukJ4xh0IhNm3O9/pdRNntGoXKITmxVfU0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731721288; c=relaxed/simple;
	bh=lnXNwNkFU2bT0e9oCp81FeHjsajSiRWL8FUsGkfOq48=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VZBWFaB3yOX3hIWzwo/VIdp77z7vckqX7JfoeQ1FyaohZEy9iGvY0018RKvS2aoYCOlRZ2AAoLEkm16HYCwmYqj6ASTRDzb/6fGDHk3AKzIc/aeHsbt3R9tM5xQwXD3qN8FgpQUTQFl8I8uJW84xAke8+z7xRCQxWksNskr4opI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kKU5QPxR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31A27C4CECF;
	Sat, 16 Nov 2024 01:41:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731721287;
	bh=lnXNwNkFU2bT0e9oCp81FeHjsajSiRWL8FUsGkfOq48=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kKU5QPxRLOky+SeujfitzyH84xZ1zb+IWW0XMPEF/9lz/RcKHyF7doomAIGvs5imp
	 fpWRorcetIgpUbXsOJhTe750p9PVylwubb7UZxLnltY1PChDrDfoTh0CHzeQxsKmNZ
	 6PdJBo0DNs1A6E02DdcHMG2BqbNVj3K+78ylYkMug8FXwTxJbKnGLcfOJsZ7QGtiUp
	 iVRXIcJbqEJH2WFG/PQZRY0LTYGPHlrqeDHyd3aRLCxttaNUZwlVp4o9bDxIbbKVxh
	 /DX53U1mWVW+q5/rCl8atpctDnIRjCFtIW9AY59sXEP1WTlvwJo9GZmxq+i/4pSSvc
	 vuucbVb99JMcg==
From: Mike Snitzer <snitzer@kernel.org>
To: linux-nfs@vger.kernel.org
Cc: Anna Schumaker <anna@kernel.org>,
	Trond Myklebust <trondmy@hammerspace.com>,
	Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>,
	NeilBrown <neilb@suse.de>
Subject: [for-6.13 PATCH v3 14/14] nfs: probe for LOCALIO when v3 client reconnects to server
Date: Fri, 15 Nov 2024 20:41:06 -0500
Message-ID: <20241116014106.25456-15-snitzer@kernel.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20241116014106.25456-1-snitzer@kernel.org>
References: <20241116014106.25456-1-snitzer@kernel.org>
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

The throttle is admin controlled using a new module parameter for
nfsv3, e.g.:
  echo 512 > /sys/module/nfsv3/parameters/nfs3_localio_probe_throttle

Probe for NFSv3 LOCALIO every N IO requests (512 in this case). Must
be power-of-2, defaults to 0 (probing disabled).

On systems that expect to use LOCALIO with NFSv3 the admin should
configure the 'nfs3_localio_probe_throttle' module parameter.

This commit backfills module parameter documentation in localio.rst

Signed-off-by: Mike Snitzer <snitzer@kernel.org>
---
 Documentation/filesystems/nfs/localio.rst | 20 +++++++++-
 fs/nfs/nfs3proc.c                         | 46 +++++++++++++++++++++--
 fs/nfs_common/nfslocalio.c                |  1 +
 include/linux/nfslocalio.h                |  3 +-
 4 files changed, 65 insertions(+), 5 deletions(-)

diff --git a/Documentation/filesystems/nfs/localio.rst b/Documentation/filesystems/nfs/localio.rst
index 9d991a958c81c..4b14c1e326731 100644
--- a/Documentation/filesystems/nfs/localio.rst
+++ b/Documentation/filesystems/nfs/localio.rst
@@ -289,7 +289,7 @@ align their IO).
 Security
 ========
 
-Localio is only supported when UNIX-style authentication (AUTH_UNIX, aka
+LOCALIO is only supported when UNIX-style authentication (AUTH_UNIX, aka
 AUTH_SYS) is used.
 
 Care is taken to ensure the same NFS security mechanisms are used
@@ -304,6 +304,24 @@ client is afforded this same level of access (albeit in terms of the NFS
 protocol via SUNRPC). No other namespaces (user, mount, etc) have been
 altered or purposely extended from the server to the client.
 
+Module Parameters
+=================
+
+/sys/module/nfs/parameters/localio_enabled (bool)
+controls if LOCALIO is enabled, defaults to Y. If client and server are
+local but 'localio_enabled' is set to N then LOCALIO will not be used.
+
+/sys/module/nfs/parameters/localio_O_DIRECT_semantics (bool)
+controls if O_DIRECT extends down to the underlying filesystem, defaults
+to N. Application IO must be logical blocksize aligned, otherwise
+O_DIRECT will fail.
+
+/sys/module/nfsv3/parameters/nfs3_localio_probe_throttle (uint)
+controls if NFSv3 read and write IOs will trigger (re)enabling of
+LOCALIO every N (nfs3_localio_probe_throttle) IOs, defaults to 0
+(disabled). Must be power-of-2, admin keeps all the pieces if they
+misconfigure (too low a value or non-power-of-2).
+
 Testing
 =======
 
diff --git a/fs/nfs/nfs3proc.c b/fs/nfs/nfs3proc.c
index 1566163c6d85b..7359e1a3bd84c 100644
--- a/fs/nfs/nfs3proc.c
+++ b/fs/nfs/nfs3proc.c
@@ -844,6 +844,41 @@ nfs3_proc_pathconf(struct nfs_server *server, struct nfs_fh *fhandle,
 	return status;
 }
 
+#if IS_ENABLED(CONFIG_NFS_LOCALIO)
+
+static unsigned nfs3_localio_probe_throttle __read_mostly = 0;
+module_param(nfs3_localio_probe_throttle, uint, 0644);
+MODULE_PARM_DESC(nfs3_localio_probe_throttle,
+		 "Probe for NFSv3 LOCALIO every N IO requests. Must be power-of-2, defaults to 0 (probing disabled).");
+
+static void nfs3_localio_probe(struct nfs_server *server)
+{
+	struct nfs_client *clp = server->nfs_client;
+
+	/* Throttled to reduce nfs_local_probe_async() frequency */
+	if (!nfs3_localio_probe_throttle || nfs_server_is_local(clp))
+		return;
+
+	/*
+	 * Try (re)enabling LOCALIO if isn't enabled -- admin deems
+	 * it worthwhile to periodically check if LOCALIO possible by
+	 * setting the 'nfs3_localio_probe_throttle' module parameter.
+	 *
+	 * This is useful if LOCALIO was previously enabled, but was
+	 * disabled due to server restart, and IO has successfully
+	 * completed in terms of normal RPC.
+	 */
+	if ((clp->cl_uuid.nfs3_localio_probe_count++ &
+	     (nfs3_localio_probe_throttle - 1)) == 0) {
+		if (!nfs_server_is_local(clp))
+			nfs_local_probe_async(clp);
+	}
+}
+
+#else
+static void nfs3_localio_probe(struct nfs_server *server) {}
+#endif
+
 static int nfs3_read_done(struct rpc_task *task, struct nfs_pgio_header *hdr)
 {
 	struct inode *inode = hdr->inode;
@@ -855,8 +890,11 @@ static int nfs3_read_done(struct rpc_task *task, struct nfs_pgio_header *hdr)
 	if (nfs3_async_handle_jukebox(task, inode))
 		return -EAGAIN;
 
-	if (task->tk_status >= 0 && !server->read_hdrsize)
-		cmpxchg(&server->read_hdrsize, 0, hdr->res.replen);
+	if (task->tk_status >= 0) {
+		if (!server->read_hdrsize)
+			cmpxchg(&server->read_hdrsize, 0, hdr->res.replen);
+		nfs3_localio_probe(server);
+	}
 
 	nfs_invalidate_atime(inode);
 	nfs_refresh_inode(inode, &hdr->fattr);
@@ -886,8 +924,10 @@ static int nfs3_write_done(struct rpc_task *task, struct nfs_pgio_header *hdr)
 
 	if (nfs3_async_handle_jukebox(task, inode))
 		return -EAGAIN;
-	if (task->tk_status >= 0)
+	if (task->tk_status >= 0) {
 		nfs_writeback_update_inode(hdr);
+		nfs3_localio_probe(NFS_SERVER(inode));
+	}
 	return 0;
 }
 
diff --git a/fs/nfs_common/nfslocalio.c b/fs/nfs_common/nfslocalio.c
index bad7691e32b94..6a0bdea6d6449 100644
--- a/fs/nfs_common/nfslocalio.c
+++ b/fs/nfs_common/nfslocalio.c
@@ -43,6 +43,7 @@ void nfs_uuid_init(nfs_uuid_t *nfs_uuid)
 	INIT_LIST_HEAD(&nfs_uuid->list);
 	INIT_LIST_HEAD(&nfs_uuid->files);
 	spin_lock_init(&nfs_uuid->lock);
+	nfs_uuid->nfs3_localio_probe_count = 0;
 }
 EXPORT_SYMBOL_GPL(nfs_uuid_init);
 
diff --git a/include/linux/nfslocalio.h b/include/linux/nfslocalio.h
index 05817d6ef3d1e..9aa8a43843d71 100644
--- a/include/linux/nfslocalio.h
+++ b/include/linux/nfslocalio.h
@@ -27,7 +27,8 @@ struct nfs_file_localio;
  */
 typedef struct {
 	uuid_t uuid;
-	/* sadly this struct is just over a cacheline, avoid bouncing */
+	unsigned nfs3_localio_probe_count;
+	/* this struct is over a cacheline, avoid bouncing */
 	spinlock_t ____cacheline_aligned lock;
 	struct list_head list;
 	spinlock_t *list_lock; /* nn->local_clients_lock */
-- 
2.44.0



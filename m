Return-Path: <linux-nfs+bounces-7811-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EF9F19C2836
	for <lists+linux-nfs@lfdr.de>; Sat,  9 Nov 2024 00:40:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1ACC81C21C5C
	for <lists+linux-nfs@lfdr.de>; Fri,  8 Nov 2024 23:40:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D3E51E3DC8;
	Fri,  8 Nov 2024 23:40:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RBQR+cy+"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 187531E1C07
	for <linux-nfs@vger.kernel.org>; Fri,  8 Nov 2024 23:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731109230; cv=none; b=B2B9yZDFYfpDHsNB4SkfOZAyPR3DFXvZaEHk8IfTPX6IJ4IgICSQHUThHJ/Ms4cMFkM93aNFI5kRZY/6Du77G/quhDcC6shcZnsH3iHRNgdqoREpq+D1Uc63MC9RDjGM2g6L6NzClsxmkryLXdj5f4w3UY05sCwjejqpKu+v1nE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731109230; c=relaxed/simple;
	bh=mm1+iCta5fSPnpTxY2nr6E1fk0ZpDMRlX1+NogjX0vw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DP3jT114MCMf2L61UXMkcV6+W75fh+4peDUUL0H+cqL0PsivrkNDe2WU63bUPERI1BahuV6gMKrJPmWsr+5tG/EAEFfkWdbLp6+6otHymzpjdTwUu0+TJB8OM1Y/d5dBc2LBu38a2S+wxvRqMD3g22MrC8uX08U2kibBSdIP9tk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RBQR+cy+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C0F0C4CECE;
	Fri,  8 Nov 2024 23:40:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731109229;
	bh=mm1+iCta5fSPnpTxY2nr6E1fk0ZpDMRlX1+NogjX0vw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=RBQR+cy+njgK/vi0c228rrJ054OdVsVTpi4crJwral8kmi9bkRnp4tB72Sooi6vpQ
	 OKpxPAhiRlLOXiFEF1u/JXT55WtkY7Z7w/t1u3gYyNq5wtpq+4L8fgtVoH+KXgybYn
	 ighuTheMUuvJWvsESrKCBngpmZcXQlq9xo0EvmNyDmyUYGeVa72aYUt0ur7k765AfU
	 vkE5MqxRArGnBVzhZggUF+Cy2mcLIlmshDoPjjaugr4TefrZz1TXhzmKtD5hr15Spw
	 EhrnS6xZypUvC7QltRZcMPZfe6F9DmSo7Ye46EXQ5foh+Qdk0GA4csRyahvzaECwko
	 DajRx+YpJwbQQ==
From: Mike Snitzer <snitzer@kernel.org>
To: linux-nfs@vger.kernel.org
Cc: Anna Schumaker <anna@kernel.org>,
	Trond Myklebust <trondmy@hammerspace.com>,
	Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>,
	NeilBrown <neilb@suse.de>
Subject: [for-6.13 PATCH 19/19] nfs: probe for LOCALIO when v3 client reconnects to server
Date: Fri,  8 Nov 2024 18:40:02 -0500
Message-ID: <20241108234002.16392-20-snitzer@kernel.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20241108234002.16392-1-snitzer@kernel.org>
References: <20241108234002.16392-1-snitzer@kernel.org>
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

Signed-off-by: Mike Snitzer <snitzer@kernel.org>
---
 fs/nfs/internal.h          |  5 +++++
 fs/nfs/localio.c           | 11 +++++++++++
 fs/nfs/nfs3proc.c          | 34 +++++++++++++++++++++++++++++++---
 fs/nfs_common/nfslocalio.c |  4 ++++
 include/linux/nfs_fs_sb.h  |  1 +
 include/linux/nfslocalio.h |  4 +++-
 6 files changed, 55 insertions(+), 4 deletions(-)

diff --git a/fs/nfs/internal.h b/fs/nfs/internal.h
index efd42efd9405..fb1ab7cee6b9 100644
--- a/fs/nfs/internal.h
+++ b/fs/nfs/internal.h
@@ -470,6 +470,7 @@ extern int nfs_local_commit(struct nfsd_file *,
 			    struct nfs_commit_data *,
 			    const struct rpc_call_ops *, int);
 extern bool nfs_server_is_local(const struct nfs_client *clp);
+extern bool nfs_server_was_local(const struct nfs_client *clp);
 
 #else /* CONFIG_NFS_LOCALIO */
 static inline void nfs_local_disable(struct nfs_client *clp) {}
@@ -499,6 +500,10 @@ static inline bool nfs_server_is_local(const struct nfs_client *clp)
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
index 710e537b3402..1559dc2f1850 100644
--- a/fs/nfs/localio.c
+++ b/fs/nfs/localio.c
@@ -64,6 +64,17 @@ bool nfs_server_is_local(const struct nfs_client *clp)
 }
 EXPORT_SYMBOL_GPL(nfs_server_is_local);
 
+static inline bool nfs_client_was_local(const struct nfs_client *clp)
+{
+	return !!test_bit(NFS_CS_LOCAL_IO_CAPABLE, &clp->cl_flags);
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
diff --git a/fs/nfs/nfs3proc.c b/fs/nfs/nfs3proc.c
index 1566163c6d85..4d2018760e9b 100644
--- a/fs/nfs/nfs3proc.c
+++ b/fs/nfs/nfs3proc.c
@@ -844,6 +844,29 @@ nfs3_proc_pathconf(struct nfs_server *server, struct nfs_fh *fhandle,
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
+	mutex_lock(&nfs_uuid->local_probe_mutex);
+	/* Arbitrary throttle to reduce nfs_local_probe_async() frequency */
+	if ((nfs_uuid->local_probe_count++ & 255) == 0) {
+		if (unlikely(!nfs_server_is_local(clp) && nfs_server_was_local(clp)))
+			nfs_local_probe_async(clp);
+	}
+	mutex_unlock(&nfs_uuid->local_probe_mutex);
+#endif
+}
+
 static int nfs3_read_done(struct rpc_task *task, struct nfs_pgio_header *hdr)
 {
 	struct inode *inode = hdr->inode;
@@ -855,8 +878,11 @@ static int nfs3_read_done(struct rpc_task *task, struct nfs_pgio_header *hdr)
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
@@ -886,8 +912,10 @@ static int nfs3_write_done(struct rpc_task *task, struct nfs_pgio_header *hdr)
 
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
index fb376d38ac9a..852ba8fd73f3 100644
--- a/fs/nfs_common/nfslocalio.c
+++ b/fs/nfs_common/nfslocalio.c
@@ -43,6 +43,8 @@ void nfs_uuid_init(nfs_uuid_t *nfs_uuid)
 	INIT_LIST_HEAD(&nfs_uuid->list);
 	INIT_LIST_HEAD(&nfs_uuid->files);
 	spin_lock_init(&nfs_uuid->lock);
+	mutex_init(&nfs_uuid->local_probe_mutex);
+	nfs_uuid->local_probe_count = 0;
 }
 EXPORT_SYMBOL_GPL(nfs_uuid_init);
 
@@ -143,6 +145,8 @@ void nfs_localio_enable_client(struct nfs_client *clp)
 
 	spin_lock(&nfs_uuid->lock);
 	set_bit(NFS_CS_LOCAL_IO, &clp->cl_flags);
+	/* Also set hint that client and server are LOCALIO capable */
+	set_bit(NFS_CS_LOCAL_IO_CAPABLE, &clp->cl_flags);
 	trace_nfs_localio_enable_client(clp);
 	spin_unlock(&nfs_uuid->lock);
 }
diff --git a/include/linux/nfs_fs_sb.h b/include/linux/nfs_fs_sb.h
index 63d7e0f478d8..45906c402c98 100644
--- a/include/linux/nfs_fs_sb.h
+++ b/include/linux/nfs_fs_sb.h
@@ -51,6 +51,7 @@ struct nfs_client {
 #define NFS_CS_REUSEPORT	8		/* - reuse src port on reconnect */
 #define NFS_CS_PNFS		9		/* - Server used for pnfs */
 #define NFS_CS_LOCAL_IO		10		/* - client is local */
+#define NFS_CS_LOCAL_IO_CAPABLE		11	/* - client was previously local */
 	struct sockaddr_storage	cl_addr;	/* server identifier */
 	size_t			cl_addrlen;
 	char *			cl_hostname;	/* hostname of server */
diff --git a/include/linux/nfslocalio.h b/include/linux/nfslocalio.h
index c68a529230c1..3dfef0bb18fe 100644
--- a/include/linux/nfslocalio.h
+++ b/include/linux/nfslocalio.h
@@ -27,7 +27,9 @@ struct nfs_file_localio;
  */
 typedef struct {
 	uuid_t uuid;
-	/* sadly this struct is just over a cacheline, avoid bouncing */
+	struct mutex local_probe_mutex;
+	unsigned local_probe_count;
+	/* sadly this struct is over a cacheline, avoid bouncing */
 	spinlock_t ____cacheline_aligned lock;
 	struct list_head list;
 	spinlock_t *list_lock; /* nn->local_clients_lock */
-- 
2.44.0



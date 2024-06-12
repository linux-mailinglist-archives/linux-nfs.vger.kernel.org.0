Return-Path: <linux-nfs+bounces-3670-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D221A904960
	for <lists+linux-nfs@lfdr.de>; Wed, 12 Jun 2024 05:08:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 852F1282E4A
	for <lists+linux-nfs@lfdr.de>; Wed, 12 Jun 2024 03:08:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AFEB2AF04;
	Wed, 12 Jun 2024 03:08:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HEMzWQ+g"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26FC42A1C6
	for <linux-nfs@vger.kernel.org>; Wed, 12 Jun 2024 03:08:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718161694; cv=none; b=Sy8lvQ1ghiArSRDs/bOOapENRUhv/hgfO74gHHaUXWm/s/Tr+6xHn79kN/Faj+sn28R09eg5MtrdghHh4h0odb3z/ztDX/lHLk5FLYav1NEDb+oLqUr1EHB80hNH3QGg4EW3pb/PXxT5NM+2nzUkk0d4QAfI/Mh4dXGoHuEf/p0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718161694; c=relaxed/simple;
	bh=UYIXAxV0jt6ix2w7zCixEcHRDldMrbGdj06xUd6/Omo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GXmoed5vyHDBDMINRCiWSFEaaSYPBqHKoZYgr36v/BHZzFulze9mH9ZgsS8dSlg/7nUvo25A3Af1DI5xz8f8P5AFMQdfUxy+fBAtXWtJZmXVfGCXU0QvcXXJwUtT09ZO0JEE+i0S4uLKzI5QJTOSbetT7T8G2M+PiyOJVBI9X0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HEMzWQ+g; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4790C2BD10;
	Wed, 12 Jun 2024 03:08:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718161694;
	bh=UYIXAxV0jt6ix2w7zCixEcHRDldMrbGdj06xUd6/Omo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HEMzWQ+gQCLXAvFLdtraFecWk9nYzwM1Hl9pWtOca0t0EVWkHWJPoCooOSWSubbOg
	 NjqD6/ZVueBGbTa8AwrK9faasTb+cRhx4aNFvGoqs2ZoDeId1Q2mLHIgYeWAjd82x0
	 0s6Pzly6afYBtrPh5SUd9YFiF/pPGeH6o70pawRyvZSbQ8Sq7DOyGYIJdUbCtH5c2r
	 qiKI/I+MWKN0k408rqH+a9YJL4uybIcBFQMeWCPDRxgNpjgm/rNdttxGZJUN2xtb7L
	 oCSy4tHWFbyCptdD+t62gbszXg3LXQZSKV/aWA/sJe2JF6Rah6qCcaVKbGNis0XoP0
	 ydNMZW4fGXqpQ==
From: Mike Snitzer <snitzer@kernel.org>
To: linux-nfs@vger.kernel.org
Cc: Jeff Layton <jlayton@kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>,
	Trond Myklebust <trondmy@hammerspace.com>,
	NeilBrown <neilb@suse.de>,
	snitzer@hammerspace.com
Subject: [RFC PATCH v2 14/15] nfs/localio: move managing nfsd_open_local_fh symbol to nfs_common
Date: Tue, 11 Jun 2024 23:07:51 -0400
Message-ID: <20240612030752.31754-15-snitzer@kernel.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240612030752.31754-1-snitzer@kernel.org>
References: <20240612030752.31754-1-snitzer@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Get nfsd_open_local_fh and store it in rpc_client during client
creation, put the symbol during nfs_local_disable -- which is also
called during client destruction.

Eliminates the need for nfs_local_open_ctx and extra locking and
refcounting work in fs/nfs/localio.c

Also makes it so the reference to the nfsd_open_local_fh symbol is
managed by the nfs_common module instead of the nfs client modules.

Signed-off-by: Mike Snitzer <snitzer@kernel.org>
---
 fs/nfs/client.c            |  1 +
 fs/nfs/inode.c             |  1 -
 fs/nfs/internal.h          | 13 ++++--
 fs/nfs/localio.c           | 89 +++-----------------------------------
 fs/nfs_common/nfslocalio.c | 26 +++++++++++
 include/linux/nfs.h        |  4 --
 include/linux/nfs_fs_sb.h  |  2 +
 include/linux/nfslocalio.h |  8 ++++
 8 files changed, 53 insertions(+), 91 deletions(-)

diff --git a/fs/nfs/client.c b/fs/nfs/client.c
index 3341707e3c2f..00044d7eda48 100644
--- a/fs/nfs/client.c
+++ b/fs/nfs/client.c
@@ -171,6 +171,7 @@ struct nfs_client *nfs_alloc_client(const struct nfs_client_initdata *cl_init)
 
 	INIT_LIST_HEAD(&clp->cl_superblocks);
 	clp->cl_rpcclient = clp->cl_rpcclient_localio = ERR_PTR(-EINVAL);
+	clp->nfsd_open_local_fh = NULL;
 
 	clp->cl_flags = cl_init->init_flags;
 	clp->cl_proto = cl_init->proto;
diff --git a/fs/nfs/inode.c b/fs/nfs/inode.c
index f5a618887c6f..c7fe49555596 100644
--- a/fs/nfs/inode.c
+++ b/fs/nfs/inode.c
@@ -2518,7 +2518,6 @@ static int __init init_nfs_fs(void)
 	if (err)
 		goto out1;
 
-	nfs_local_init();
 	err = register_nfs_fs();
 	if (err)
 		goto out0;
diff --git a/fs/nfs/internal.h b/fs/nfs/internal.h
index ebcc98a56567..c4b5b7fd80bf 100644
--- a/fs/nfs/internal.h
+++ b/fs/nfs/internal.h
@@ -470,11 +470,18 @@ nfs_init_localioclient(struct nfs_client *clp,
 	if (IS_ERR(clp->cl_rpcclient_localio))
 		goto out;
 	/* No errors! Assume that localio is supported */
+	clp->nfsd_open_local_fh = get_nfsd_open_local_fh();
+	if (!clp->nfsd_open_local_fh) {
+		rpc_shutdown_client(clp->cl_rpcclient_localio);
+		clp->cl_rpcclient_localio = ERR_PTR(-EINVAL);
+		goto out;
+	}
 	supported = true;
 out:
-	dfprintk_rcu(CLIENT, "%s: server (%s) %s NFS v%u LOCALIO\n", __func__,
-		rpc_peeraddr2str(clp->cl_rpcclient_localio, RPC_DISPLAY_ADDR),
-		(supported ? "supports" : "does not support"), vers);
+	dfprintk_rcu(CLIENT, "%s: server (%s) %s NFS v%u LOCALIO, nfsd_open_local_fh is %s.\n",
+		__func__, rpc_peeraddr2str(clp->cl_rpcclient_localio, RPC_DISPLAY_ADDR),
+		(supported ? "supports" : "does not support"), vers,
+		(clp->nfsd_open_local_fh ? "set" : "not set"));
 }
 
 /* localio.c */
diff --git a/fs/nfs/localio.c b/fs/nfs/localio.c
index cce6b8917e90..bd81b0afdbda 100644
--- a/fs/nfs/localio.c
+++ b/fs/nfs/localio.c
@@ -29,26 +29,6 @@
 
 #define NFSDBG_FACILITY		NFSDBG_VFS
 
-extern int nfsd_open_local_fh(struct rpc_clnt *rpc_clnt,
-			      const struct cred *cred,
-			      const struct nfs_fh *nfs_fh, const fmode_t fmode,
-			      struct file **pfilp);
-/*
- * The localio code needs to call into nfsd to do the filehandle -> struct path
- * mapping, but cannot be statically linked, because that will make the nfs
- * module depend on the nfsd module.
- *
- * Instead, do dynamic linking to the nfsd module. This way the nfs module
- * will only hold a reference on nfsd when it's actually in use. This also
- * allows some sanity checking, like giving up on localio if nfsd isn't loaded.
- */
-
-struct nfs_local_open_ctx {
-	spinlock_t lock;
-	nfs_to_nfsd_open_t open_f;
-	atomic_t refcount;
-};
-
 struct nfs_local_kiocb {
 	struct kiocb		kiocb;
 	struct bio_vec		*bvec;
@@ -141,8 +121,6 @@ nfs4errno(int errno)
 	return NFS4ERR_SERVERFAULT;
 }
 
-static struct nfs_local_open_ctx __local_open_ctx __read_mostly;
-
 static bool localio_enabled __read_mostly = true;
 module_param(localio_enabled, bool, 0644);
 
@@ -153,66 +131,12 @@ bool nfs_server_is_local(const struct nfs_client *clp)
 }
 EXPORT_SYMBOL_GPL(nfs_server_is_local);
 
-void
-nfs_local_init(void)
-{
-	struct nfs_local_open_ctx *ctx = &__local_open_ctx;
-
-	ctx->open_f = NULL;
-	spin_lock_init(&ctx->lock);
-	atomic_set(&ctx->refcount, 0);
-}
-
-static bool
-nfs_local_get_lookup_ctx(void)
-{
-	struct nfs_local_open_ctx *ctx = &__local_open_ctx;
-	nfs_to_nfsd_open_t fn = NULL;
-
-	spin_lock(&ctx->lock);
-	if (ctx->open_f == NULL) {
-		spin_unlock(&ctx->lock);
-
-		fn = symbol_request(nfsd_open_local_fh);
-		if (!fn)
-			return false;
-
-		spin_lock(&ctx->lock);
-		/* catch race */
-		if (ctx->open_f == NULL) {
-			ctx->open_f = fn;
-			fn = NULL;
-		}
-	}
-	atomic_inc(&ctx->refcount);
-	spin_unlock(&ctx->lock);
-	if (fn)
-		symbol_put(nfsd_open_local_fh);
-	return true;
-}
-
-static void
-nfs_local_put_lookup_ctx(void)
-{
-	struct nfs_local_open_ctx *ctx = &__local_open_ctx;
-	nfs_to_nfsd_open_t fn;
-
-	if (atomic_dec_and_lock(&ctx->refcount, &ctx->lock)) {
-		fn = ctx->open_f;
-		ctx->open_f = NULL;
-		spin_unlock(&ctx->lock);
-		if (fn)
-			symbol_put(nfsd_open_local_fh);
-	}
-}
-
 /*
  * nfs_local_enable - attempt to enable local i/o for an nfs_client
  */
-void
-nfs_local_enable(struct nfs_client *clp)
+void nfs_local_enable(struct nfs_client *clp)
 {
-	if (nfs_local_get_lookup_ctx()) {
+	if (READ_ONCE(clp->nfsd_open_local_fh)) {
 		set_bit(NFS_CS_LOCAL_IO, &clp->cl_flags);
 		trace_nfs_local_enable(clp);
 	}
@@ -221,12 +145,12 @@ nfs_local_enable(struct nfs_client *clp)
 /*
  * nfs_local_disable - disable local i/o for an nfs_client
  */
-void
-nfs_local_disable(struct nfs_client *clp)
+void nfs_local_disable(struct nfs_client *clp)
 {
 	if (test_and_clear_bit(NFS_CS_LOCAL_IO, &clp->cl_flags)) {
 		trace_nfs_local_disable(clp);
-		nfs_local_put_lookup_ctx();
+		put_nfsd_open_local_fh();
+		clp->nfsd_open_local_fh = NULL;
 	}
 }
 
@@ -301,14 +225,13 @@ struct file *
 nfs_local_open_fh(struct nfs_client *clp, const struct cred *cred,
 		  struct nfs_fh *fh, const fmode_t mode)
 {
-	struct nfs_local_open_ctx *ctx = &__local_open_ctx;
 	struct file *filp;
 	int status;
 
 	if (mode & ~(FMODE_READ | FMODE_WRITE))
 		return ERR_PTR(-EINVAL);
 
-	status = ctx->open_f(clp->cl_rpcclient, cred, fh, mode, &filp);
+	status = clp->nfsd_open_local_fh(clp->cl_rpcclient, cred, fh, mode, &filp);
 	if (status < 0) {
 		dprintk("%s: open local file failed error=%d\n",
 				__func__, status);
diff --git a/fs/nfs_common/nfslocalio.c b/fs/nfs_common/nfslocalio.c
index f214cc6754a1..c454c4100976 100644
--- a/fs/nfs_common/nfslocalio.c
+++ b/fs/nfs_common/nfslocalio.c
@@ -40,3 +40,29 @@ bool nfsd_uuid_is_local(const uuid_t *uuid)
 	return !uuid_is_null(nfsd_uuid);
 }
 EXPORT_SYMBOL_GPL(nfsd_uuid_is_local);
+
+/*
+ * The nfs localio code needs to call into nfsd to do the filehandle -> struct path
+ * mapping, but cannot be statically linked, because that will make the nfs module
+ * depend on the nfsd module.
+ *
+ * Instead, do dynamic linking to the nfsd module (via nfs_common module). The
+ * nfs_common module will only hold a reference on nfsd when localio is in use.
+ * This allows some sanity checking, like giving up on localio if nfsd isn't loaded.
+ */
+
+extern int nfsd_open_local_fh(struct rpc_clnt *rpc_clnt,
+			const struct cred *cred, const struct nfs_fh *nfs_fh,
+			const fmode_t fmode, struct file **pfilp);
+
+nfs_to_nfsd_open_t get_nfsd_open_local_fh(void)
+{
+	return symbol_request(nfsd_open_local_fh);
+}
+EXPORT_SYMBOL_GPL(get_nfsd_open_local_fh);
+
+void put_nfsd_open_local_fh(void)
+{
+	symbol_put(nfsd_open_local_fh);
+}
+EXPORT_SYMBOL_GPL(put_nfsd_open_local_fh);
diff --git a/include/linux/nfs.h b/include/linux/nfs.h
index 80843764fad3..755944b562e9 100644
--- a/include/linux/nfs.h
+++ b/include/linux/nfs.h
@@ -111,10 +111,6 @@ static inline int nfs_stat_to_errno(enum nfs_stat status)
 	return nfs_common_errtbl[i].errno;
 }
 
-typedef int (*nfs_to_nfsd_open_t)(struct rpc_clnt *, const struct cred *,
-				  const struct nfs_fh *, const fmode_t,
-				  struct file **);
-
 #ifdef CONFIG_CRC32
 /**
  * nfs_fhandle_hash - calculate the crc32 hash for the filehandle
diff --git a/include/linux/nfs_fs_sb.h b/include/linux/nfs_fs_sb.h
index efcdb4d8e9de..f5760b05ec87 100644
--- a/include/linux/nfs_fs_sb.h
+++ b/include/linux/nfs_fs_sb.h
@@ -8,6 +8,7 @@
 #include <linux/wait.h>
 #include <linux/nfs_xdr.h>
 #include <linux/sunrpc/xprt.h>
+#include <linux/nfslocalio.h>
 
 #include <linux/atomic.h>
 #include <linux/refcount.h>
@@ -131,6 +132,7 @@ struct nfs_client {
 	struct timespec64	cl_nfssvc_boot;
 	seqlock_t		cl_boot_lock;
 	struct rpc_clnt *	cl_rpcclient_localio;	/* localio RPC client handle */
+	nfs_to_nfsd_open_t	nfsd_open_local_fh;
 };
 
 /*
diff --git a/include/linux/nfslocalio.h b/include/linux/nfslocalio.h
index d0bbacd0adcf..b8df1b9f248d 100644
--- a/include/linux/nfslocalio.h
+++ b/include/linux/nfslocalio.h
@@ -7,6 +7,7 @@
 
 #include <linux/list.h>
 #include <linux/uuid.h>
+#include <linux/nfs.h>
 
 /*
  * Global list of nfsd_uuid_t instances, add/remove
@@ -26,4 +27,11 @@ typedef struct {
 
 bool nfsd_uuid_is_local(const uuid_t *uuid);
 
+typedef int (*nfs_to_nfsd_open_t)(struct rpc_clnt *, const struct cred *,
+				  const struct nfs_fh *, const fmode_t,
+				  struct file **);
+
+nfs_to_nfsd_open_t get_nfsd_open_local_fh(void);
+void put_nfsd_open_local_fh(void);
+
 #endif  /* __LINUX_NFSLOCALIO_H */
-- 
2.44.0



Return-Path: <linux-nfs+bounces-3614-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C3ED59006A6
	for <lists+linux-nfs@lfdr.de>; Fri,  7 Jun 2024 16:28:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B8D131C230A7
	for <lists+linux-nfs@lfdr.de>; Fri,  7 Jun 2024 14:28:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B902199EB0;
	Fri,  7 Jun 2024 14:27:36 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A606919753B
	for <linux-nfs@vger.kernel.org>; Fri,  7 Jun 2024 14:27:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717770456; cv=none; b=R5MAfu8mxYDf2tP+6nV4/9smunNpILSyuLVp3p8yCgcfMnuDA6gA7T5LrxR4rwx6jf1M/51NeFR6x3vByI+VkV6mFfBlmWXvjbk9//wm2mQIo7mTsBFrBwkVli3INxnPGQnF8n+IKOwI01mHmzJGu4o66ZsUbimhfrHcrBbQgJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717770456; c=relaxed/simple;
	bh=j6vuOT/yGClPGfCJO8Xjm7D1aJqpOJfnQd6+HojMkEw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NYeploolRncsMOi5+HI8HsRLiIxAyuxEUTGoQrBbKPIV1WBtE9Xy5icfyrMInHak/lRdQ2+NdgWkcEEsWoDD0WYI1wGQQK56e+pSjnPex7EZTBuPeIcgAlPcY5caTpPO7Oy0iBwKEL46Bo4NlOvXUW4Sz7hEiDbL4MXutqHzV+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=none smtp.mailfrom=snitzer.net; arc=none smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=snitzer.net
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-7954852d3bbso30800085a.0
        for <linux-nfs@vger.kernel.org>; Fri, 07 Jun 2024 07:27:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717770453; x=1718375253;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MxE2p0psvFDzNR+zpaftCzt996ur/YeGKQGdaTDW4WY=;
        b=Ds7hLCuELQorejK2hHYErYFuv5ftwugH+SeMx2xh4zm+V+aJmCnzBlzwjgsj0z8k8+
         XD5EbPhoKCktzsPwl8CDlUMmaH+CKORCV8EHejvo7bHEXpouwv273fpTy4UuXLYGKzcm
         i/y6esycZacr0PgZoGe/gWXWSSgfv4jIKmZQYL4psRtLg08y0yNdHH7So27vDEnIFaEK
         clwQEtwuQDN/0vDOeaOqn0hUQOSFQ9RT5PswSv75UpCOwzR4zb1Vv8uaYR0dENPFlldv
         5GU4ikwuBej//JwPC/7PU2YWuWnu+r+3ZuH1Pa+PCPCBBMgPigenBpsghEHTWytYdnb2
         lKTg==
X-Gm-Message-State: AOJu0YzwdMWOgWtWzstJmPfqxyVeQaiz5R7ZlJR3OUzgJHzYPHabZ/WM
	b70d1aVDPLcBHR77eZvej/JSQ3UBrMXX3xptlOBBTBN+Nj1gQGMUiLJ7HIMJp+G7rvVJntG5y+a
	llxA=
X-Google-Smtp-Source: AGHT+IHUfYwmv0DWmaDQDd9bar0kzp3Cui15100oDqAL3zBPo5ndT2xzzX14PKjFbE0fYostSYTVWQ==
X-Received: by 2002:a05:620a:29c2:b0:794:ec0a:95e5 with SMTP id af79cd13be357-7953c434d61mr331150285a.37.1717770453239;
        Fri, 07 Jun 2024 07:27:33 -0700 (PDT)
Received: from localhost (pool-68-160-141-91.bstnma.fios.verizon.net. [68.160.141.91])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-795330b2426sm171629785a.73.2024.06.07.07.27.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Jun 2024 07:27:32 -0700 (PDT)
From: Mike Snitzer <snitzer@kernel.org>
To: linux-nfs@vger.kernel.org
Cc: Jeff Layton <jlayton@kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>,
	Trond Myklebust <trondmy@hammerspace.com>,
	snitzer@hammerspace.com
Subject: [for-6.11 PATCH 29/29] nfs/localio: move managing nfsd_open_local_fh symbol to nfs_common
Date: Fri,  7 Jun 2024 10:26:46 -0400
Message-ID: <20240607142646.20924-30-snitzer@kernel.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240607142646.20924-1-snitzer@kernel.org>
References: <20240607142646.20924-1-snitzer@kernel.org>
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
index 589aeba8ccbb..3d356fb05aee 100644
--- a/fs/nfs/client.c
+++ b/fs/nfs/client.c
@@ -171,6 +171,7 @@ struct nfs_client *nfs_alloc_client(const struct nfs_client_initdata *cl_init)
 
 	INIT_LIST_HEAD(&clp->cl_superblocks);
 	clp->cl_rpcclient = clp->cl_rpcclient_localio = ERR_PTR(-EINVAL);
+	clp->nfsd_open_local_fh = NULL;
 
 	clp->cl_flags = cl_init->init_flags;
 	clp->cl_proto = cl_init->proto;
diff --git a/fs/nfs/inode.c b/fs/nfs/inode.c
index b80469bce8df..811c99e65a02 100644
--- a/fs/nfs/inode.c
+++ b/fs/nfs/inode.c
@@ -2513,7 +2513,6 @@ static int __init init_nfs_fs(void)
 	if (err)
 		goto out1;
 
-	nfs_local_init();
 	err = register_nfs_fs();
 	if (err)
 		goto out0;
diff --git a/fs/nfs/internal.h b/fs/nfs/internal.h
index 1b2adca930fa..e82bdc579589 100644
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
index ff28a7315470..fb1ebc9715ff 100644
--- a/fs/nfs/localio.c
+++ b/fs/nfs/localio.c
@@ -27,26 +27,6 @@
 
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
@@ -139,8 +119,6 @@ nfs4errno(int errno)
 	return NFS4ERR_SERVERFAULT;
 }
 
-static struct nfs_local_open_ctx __local_open_ctx __read_mostly;
-
 static bool localio_enabled __read_mostly = true;
 module_param(localio_enabled, bool, 0644);
 
@@ -151,66 +129,12 @@ bool nfs_server_is_local(const struct nfs_client *clp)
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
@@ -219,12 +143,12 @@ nfs_local_enable(struct nfs_client *clp)
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
 
@@ -299,14 +223,13 @@ struct file *
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



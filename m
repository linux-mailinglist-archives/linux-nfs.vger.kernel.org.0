Return-Path: <linux-nfs+bounces-7803-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8627A9C282F
	for <lists+linux-nfs@lfdr.de>; Sat,  9 Nov 2024 00:40:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DC221B2231E
	for <lists+linux-nfs@lfdr.de>; Fri,  8 Nov 2024 23:40:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BF801A9B53;
	Fri,  8 Nov 2024 23:40:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KBXOaMhb"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33FB5610D
	for <linux-nfs@vger.kernel.org>; Fri,  8 Nov 2024 23:40:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731109219; cv=none; b=IKoOIUN/rG14ACFBN9pU3dZxO9i9U0ithaV7hdPQSEKlwUx/62u24QiPgBUt7f/rp1fELYzCGtYnD8wxjcw2vhsHje8YG0MTfLcwEOgjGyJoZmJRw08iMUrDGSLD8xm0gjvUJkfwjHSRSUMykgZLbEK2XPaDptq5BNBFTODMuaA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731109219; c=relaxed/simple;
	bh=oUPZ+eI0ubYRl6T/HkBJD/KJBXOCJbUamsOVEfdrxq8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SDPsZ8QOEKSaCRYXftJPIR84avaUaodMroLPGhr50nl2QcaJL7ed+mhH+j6906Xfwu1nkb68RA+UHBFNiRsXDGqEw/LcyWjXfcimcyM0IY9IOyb0hEVvzDYHn93wusz4aNWUvQb6iZxGY9cOduF6UT2O85aNZcNsCjZRmUXAH38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KBXOaMhb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D337DC4CED2;
	Fri,  8 Nov 2024 23:40:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731109219;
	bh=oUPZ+eI0ubYRl6T/HkBJD/KJBXOCJbUamsOVEfdrxq8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KBXOaMhbxFJ4adJxBjqDhIhBBkz5aWIqryII5NhP0fy2kbhTtNdd1cUl5TWVs3Pj2
	 YcNkdfouXScrul4HeG2vAyZtH7C4kEiHwJdE7uGpAfwVb9Rfm/Q5+/GwJ4OEz9zMmh
	 BBdZSSS3sO02LsJnIR2lSTwQjnNKZpe3D6HA5h2SEZe/bR9FJ9xKNSD3UD/I5ccsKZ
	 0NUBmKGMDXrbVJgb9ZfpzeO18CBjRcvZA5NbqkH+og6qiuf1ajCKzdQLxFp/B2Txr6
	 ZJSENr/5huf5na0IXmdsX0R/kNSXbKLGwF+tITgGjfR/4MRBMQw0srd2/tj5D+BLa0
	 xMiLCZq5tl78g==
From: Mike Snitzer <snitzer@kernel.org>
To: linux-nfs@vger.kernel.org
Cc: Anna Schumaker <anna@kernel.org>,
	Trond Myklebust <trondmy@hammerspace.com>,
	Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>,
	NeilBrown <neilb@suse.de>
Subject: [for-6.13 PATCH 11/19] nfs: cache all open LOCALIO nfsd_file(s) in client
Date: Fri,  8 Nov 2024 18:39:54 -0500
Message-ID: <20241108234002.16392-12-snitzer@kernel.org>
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

This commit switches from leaning heavily on NFSD's filecache (in
terms of GC'd nfsd_files) back to caching nfsd_files in the
client. A later commit will add the callback mechanism needed to
allow NFSD to force the NFS client to cleanup all caches files.

Add nfs_fh_localio_init() and 'struct nfs_fh_localio' to cache opened
nfsd_file(s) (both a RO and RW nfsd_file is able to be opened and
cached for a given nfs_fh).

Update nfs_local_open_fh() to cache the nfsd_file once it is opened
using __nfs_local_open_fh().

Introduce nfs_close_local_fh() to clear the cached open nfsd_files and
call nfs_to_nfsd_file_put_local().

Refcounting is such that:
- nfs_local_open_fh() is paired with nfs_close_local_fh().
- __nfs_local_open_fh() is paired with nfs_to_nfsd_file_put_local().
- nfs_local_file_get() is paired with nfs_local_file_put().

Signed-off-by: Mike Snitzer <snitzer@kernel.org>
---
 fs/nfs/flexfilelayout/flexfilelayout.c | 29 +++++----
 fs/nfs/flexfilelayout/flexfilelayout.h |  1 +
 fs/nfs/inode.c                         |  3 +
 fs/nfs/internal.h                      |  4 +-
 fs/nfs/localio.c                       | 89 +++++++++++++++++++++-----
 fs/nfs/pagelist.c                      |  5 +-
 fs/nfs/write.c                         |  3 +-
 fs/nfs_common/nfslocalio.c             | 52 ++++++++++++++-
 include/linux/nfs_fs.h                 | 22 ++++++-
 include/linux/nfslocalio.h             | 18 +++---
 10 files changed, 181 insertions(+), 45 deletions(-)

diff --git a/fs/nfs/flexfilelayout/flexfilelayout.c b/fs/nfs/flexfilelayout/flexfilelayout.c
index f78115c6c2c1..451f168d882b 100644
--- a/fs/nfs/flexfilelayout/flexfilelayout.c
+++ b/fs/nfs/flexfilelayout/flexfilelayout.c
@@ -164,18 +164,17 @@ decode_name(struct xdr_stream *xdr, u32 *id)
 }
 
 static struct nfsd_file *
-ff_local_open_fh(struct nfs_client *clp, const struct cred *cred,
+ff_local_open_fh(struct pnfs_layout_segment *lseg, u32 ds_idx,
+		 struct nfs_client *clp, const struct cred *cred,
 		 struct nfs_fh *fh, fmode_t mode)
 {
-	if (mode & FMODE_WRITE) {
-		/*
-		 * Always request read and write access since this corresponds
-		 * to a rw layout.
-		 */
-		mode |= FMODE_READ;
-	}
+#if IS_ENABLED(CONFIG_NFS_LOCALIO)
+	struct nfs4_ff_layout_mirror *mirror = FF_LAYOUT_COMP(lseg, ds_idx);
 
-	return nfs_local_open_fh(clp, cred, fh, mode);
+	return nfs_local_open_fh(clp, cred, fh, &mirror->nfl, mode);
+#else
+	return NULL;
+#endif
 }
 
 static bool ff_mirror_match_fh(const struct nfs4_ff_layout_mirror *m1,
@@ -247,6 +246,9 @@ static struct nfs4_ff_layout_mirror *ff_layout_alloc_mirror(gfp_t gfp_flags)
 		spin_lock_init(&mirror->lock);
 		refcount_set(&mirror->ref, 1);
 		INIT_LIST_HEAD(&mirror->mirrors);
+#if IS_ENABLED(CONFIG_NFS_LOCALIO)
+		nfs_localio_file_init(&mirror->nfl);
+#endif
 	}
 	return mirror;
 }
@@ -257,6 +259,9 @@ static void ff_layout_free_mirror(struct nfs4_ff_layout_mirror *mirror)
 
 	ff_layout_remove_mirror(mirror);
 	kfree(mirror->fh_versions);
+#if IS_ENABLED(CONFIG_NFS_LOCALIO)
+	nfs_close_local_fh(&mirror->nfl);
+#endif
 	cred = rcu_access_pointer(mirror->ro_cred);
 	put_cred(cred);
 	cred = rcu_access_pointer(mirror->rw_cred);
@@ -1820,7 +1825,7 @@ ff_layout_read_pagelist(struct nfs_pgio_header *hdr)
 	hdr->mds_offset = offset;
 
 	/* Start IO accounting for local read */
-	localio = ff_local_open_fh(ds->ds_clp, ds_cred, fh, FMODE_READ);
+	localio = ff_local_open_fh(lseg, idx, ds->ds_clp, ds_cred, fh, FMODE_READ);
 	if (localio) {
 		hdr->task.tk_start = ktime_get();
 		ff_layout_read_record_layoutstats_start(&hdr->task, hdr);
@@ -1896,7 +1901,7 @@ ff_layout_write_pagelist(struct nfs_pgio_header *hdr, int sync)
 	hdr->args.offset = offset;
 
 	/* Start IO accounting for local write */
-	localio = ff_local_open_fh(ds->ds_clp, ds_cred, fh,
+	localio = ff_local_open_fh(lseg, idx, ds->ds_clp, ds_cred, fh,
 				   FMODE_READ|FMODE_WRITE);
 	if (localio) {
 		hdr->task.tk_start = ktime_get();
@@ -1981,7 +1986,7 @@ static int ff_layout_initiate_commit(struct nfs_commit_data *data, int how)
 		data->args.fh = fh;
 
 	/* Start IO accounting for local commit */
-	localio = ff_local_open_fh(ds->ds_clp, ds_cred, fh,
+	localio = ff_local_open_fh(lseg, idx, ds->ds_clp, ds_cred, fh,
 				   FMODE_READ|FMODE_WRITE);
 	if (localio) {
 		data->task.tk_start = ktime_get();
diff --git a/fs/nfs/flexfilelayout/flexfilelayout.h b/fs/nfs/flexfilelayout/flexfilelayout.h
index f84b3fb0dddd..095df09017a5 100644
--- a/fs/nfs/flexfilelayout/flexfilelayout.h
+++ b/fs/nfs/flexfilelayout/flexfilelayout.h
@@ -83,6 +83,7 @@ struct nfs4_ff_layout_mirror {
 	nfs4_stateid			stateid;
 	const struct cred __rcu		*ro_cred;
 	const struct cred __rcu		*rw_cred;
+	struct nfs_file_localio		nfl;
 	refcount_t			ref;
 	spinlock_t			lock;
 	unsigned long			flags;
diff --git a/fs/nfs/inode.c b/fs/nfs/inode.c
index 596f35170137..1aa67fca69b2 100644
--- a/fs/nfs/inode.c
+++ b/fs/nfs/inode.c
@@ -1137,6 +1137,8 @@ struct nfs_open_context *alloc_nfs_open_context(struct dentry *dentry,
 	ctx->lock_context.open_context = ctx;
 	INIT_LIST_HEAD(&ctx->list);
 	ctx->mdsthreshold = NULL;
+	nfs_localio_file_init(&ctx->nfl);
+
 	return ctx;
 }
 EXPORT_SYMBOL_GPL(alloc_nfs_open_context);
@@ -1168,6 +1170,7 @@ static void __put_nfs_open_context(struct nfs_open_context *ctx, int is_sync)
 	nfs_sb_deactive(sb);
 	put_rpccred(rcu_dereference_protected(ctx->ll_cred, 1));
 	kfree(ctx->mdsthreshold);
+	nfs_close_local_fh(&ctx->nfl);
 	kfree_rcu(ctx, rcu_head);
 }
 
diff --git a/fs/nfs/internal.h b/fs/nfs/internal.h
index 430733e3eff2..57af3ab3adbe 100644
--- a/fs/nfs/internal.h
+++ b/fs/nfs/internal.h
@@ -459,6 +459,7 @@ extern void nfs_local_probe(struct nfs_client *);
 extern struct nfsd_file *nfs_local_open_fh(struct nfs_client *,
 					   const struct cred *,
 					   struct nfs_fh *,
+					   struct nfs_file_localio *,
 					   const fmode_t);
 extern int nfs_local_doio(struct nfs_client *,
 			  struct nfsd_file *,
@@ -474,7 +475,8 @@ static inline void nfs_local_disable(struct nfs_client *clp) {}
 static inline void nfs_local_probe(struct nfs_client *clp) {}
 static inline struct nfsd_file *
 nfs_local_open_fh(struct nfs_client *clp, const struct cred *cred,
-		  struct nfs_fh *fh, const fmode_t mode)
+		  struct nfs_fh *fh, struct nfs_file_localio *nfl,
+		  const fmode_t mode)
 {
 	return NULL;
 }
diff --git a/fs/nfs/localio.c b/fs/nfs/localio.c
index 4c75ffc5efa2..d10d863aaf23 100644
--- a/fs/nfs/localio.c
+++ b/fs/nfs/localio.c
@@ -214,27 +214,33 @@ void nfs_local_probe(struct nfs_client *clp)
 }
 EXPORT_SYMBOL_GPL(nfs_local_probe);
 
+static inline struct nfsd_file *nfs_local_file_get(struct nfsd_file *nf)
+{
+	return nfs_to->nfsd_file_get(nf);
+}
+
+static inline void nfs_local_file_put(struct nfsd_file *nf)
+{
+	nfs_to->nfsd_file_put(nf);
+}
+
 /*
- * nfs_local_open_fh - open a local filehandle in terms of nfsd_file
+ * __nfs_local_open_fh - open a local filehandle in terms of nfsd_file.
  *
- * Returns a pointer to a struct nfsd_file or NULL
+ * Returns a pointer to a struct nfsd_file or ERR_PTR.
+ * Caller must release returned nfsd_file with nfs_to_nfsd_file_put_local().
  */
-struct nfsd_file *
-nfs_local_open_fh(struct nfs_client *clp, const struct cred *cred,
-		  struct nfs_fh *fh, const fmode_t mode)
+static struct nfsd_file *
+__nfs_local_open_fh(struct nfs_client *clp, const struct cred *cred,
+		    struct nfs_fh *fh, struct nfs_file_localio *nfl,
+		    const fmode_t mode)
 {
 	struct nfsd_file *localio;
-	int status;
-
-	if (!nfs_server_is_local(clp))
-		return NULL;
-	if (mode & ~(FMODE_READ | FMODE_WRITE))
-		return NULL;
 
 	localio = nfs_open_local_fh(&clp->cl_uuid, clp->cl_rpcclient,
-				    cred, fh, mode);
+				    cred, fh, nfl, mode);
 	if (IS_ERR(localio)) {
-		status = PTR_ERR(localio);
+		int status = PTR_ERR(localio);
 		trace_nfs_local_open_fh(fh, mode, status);
 		switch (status) {
 		case -ENOMEM:
@@ -243,10 +249,59 @@ nfs_local_open_fh(struct nfs_client *clp, const struct cred *cred,
 			/* Revalidate localio, will disable if unsupported */
 			nfs_local_probe(clp);
 		}
-		return NULL;
 	}
 	return localio;
 }
+
+/*
+ * nfs_local_open_fh - open a local filehandle in terms of nfsd_file.
+ * First checking if the open nfsd_file is already cached, otherwise
+ * must __nfs_local_open_fh and insert the nfsd_file in nfs_file_localio.
+ *
+ * Returns a pointer to a struct nfsd_file or NULL.
+ */
+struct nfsd_file *
+nfs_local_open_fh(struct nfs_client *clp, const struct cred *cred,
+		  struct nfs_fh *fh, struct nfs_file_localio *nfl,
+		  const fmode_t mode)
+{
+	struct nfsd_file *nf, *new, __rcu **pnf;
+
+	if (!nfs_server_is_local(clp))
+		return NULL;
+	if (mode & ~(FMODE_READ | FMODE_WRITE))
+		return NULL;
+
+	if (mode & FMODE_WRITE)
+		pnf = &nfl->rw_file;
+	else
+		pnf = &nfl->ro_file;
+
+	new = NULL;
+	rcu_read_lock();
+	nf = rcu_dereference(*pnf);
+	if (!nf) {
+		rcu_read_unlock();
+		new = __nfs_local_open_fh(clp, cred, fh, nfl, mode);
+		if (IS_ERR(new))
+			return NULL;
+		/* try to swap in the pointer */
+		spin_lock(&clp->cl_uuid.lock);
+		nf = rcu_dereference_protected(*pnf, 1);
+		if (!nf) {
+			nf = new;
+			new = NULL;
+			rcu_assign_pointer(*pnf, nf);
+		}
+		spin_unlock(&clp->cl_uuid.lock);
+		rcu_read_lock();
+	}
+	nf = nfs_local_file_get(nf);
+	rcu_read_unlock();
+	if (new)
+		nfs_to_nfsd_file_put_local(new);
+	return nf;
+}
 EXPORT_SYMBOL_GPL(nfs_local_open_fh);
 
 static struct bio_vec *
@@ -350,7 +405,7 @@ nfs_local_pgio_release(struct nfs_local_kiocb *iocb)
 {
 	struct nfs_pgio_header *hdr = iocb->hdr;
 
-	nfs_to_nfsd_file_put_local(iocb->localio);
+	nfs_local_file_put(iocb->localio);
 	nfs_local_iocb_free(iocb);
 	nfs_local_hdr_release(hdr, hdr->task.tk_ops);
 }
@@ -697,7 +752,7 @@ int nfs_local_doio(struct nfs_client *clp, struct nfsd_file *localio,
 	if (status != 0) {
 		if (status == -EAGAIN)
 			nfs_local_disable(clp);
-		nfs_to_nfsd_file_put_local(localio);
+		nfs_local_file_put(localio);
 		hdr->task.tk_status = status;
 		nfs_local_hdr_release(hdr, call_ops);
 	}
@@ -748,7 +803,7 @@ nfs_local_release_commit_data(struct nfsd_file *localio,
 		struct nfs_commit_data *data,
 		const struct rpc_call_ops *call_ops)
 {
-	nfs_to_nfsd_file_put_local(localio);
+	nfs_local_file_put(localio);
 	call_ops->rpc_call_done(&data->task, data);
 	call_ops->rpc_release(data);
 }
diff --git a/fs/nfs/pagelist.c b/fs/nfs/pagelist.c
index e27c07bd8929..11968dcb7243 100644
--- a/fs/nfs/pagelist.c
+++ b/fs/nfs/pagelist.c
@@ -961,8 +961,9 @@ static int nfs_generic_pg_pgios(struct nfs_pageio_descriptor *desc)
 		struct nfs_client *clp = NFS_SERVER(hdr->inode)->nfs_client;
 
 		struct nfsd_file *localio =
-			nfs_local_open_fh(clp, hdr->cred,
-					  hdr->args.fh, hdr->args.context->mode);
+			nfs_local_open_fh(clp, hdr->cred, hdr->args.fh,
+					  &hdr->args.context->nfl,
+					  hdr->args.context->mode);
 
 		if (NFS_SERVER(hdr->inode)->nfs_client->cl_minorversion)
 			task_flags = RPC_TASK_MOVEABLE;
diff --git a/fs/nfs/write.c b/fs/nfs/write.c
index ead2dc55952d..8d4dbb69b7c0 100644
--- a/fs/nfs/write.c
+++ b/fs/nfs/write.c
@@ -1815,7 +1815,8 @@ nfs_commit_list(struct inode *inode, struct list_head *head, int how,
 		task_flags = RPC_TASK_MOVEABLE;
 
 	localio = nfs_local_open_fh(NFS_SERVER(inode)->nfs_client, data->cred,
-				    data->args.fh, data->context->mode);
+				    data->args.fh, &data->context->nfl,
+				    data->context->mode);
 	return nfs_initiate_commit(NFS_CLIENT(inode), data, NFS_PROTO(inode),
 				   data->mds_ops, how,
 				   RPC_TASK_CRED_NOREF | task_flags, localio);
diff --git a/fs/nfs_common/nfslocalio.c b/fs/nfs_common/nfslocalio.c
index cf2f47ea4f8d..345f3c55aa9c 100644
--- a/fs/nfs_common/nfslocalio.c
+++ b/fs/nfs_common/nfslocalio.c
@@ -9,7 +9,7 @@
 #include <linux/nfslocalio.h>
 #include <linux/nfs3.h>
 #include <linux/nfs4.h>
-#include <linux/nfs_fs_sb.h>
+#include <linux/nfs_fs.h>
 #include <net/netns/generic.h>
 
 MODULE_LICENSE("GPL");
@@ -151,9 +151,18 @@ void nfs_localio_invalidate_clients(struct list_head *cl_uuid_list)
 }
 EXPORT_SYMBOL_GPL(nfs_localio_invalidate_clients);
 
+static void nfs_uuid_add_file(nfs_uuid_t *nfs_uuid, struct nfs_file_localio *nfl)
+{
+	spin_lock(&nfs_uuid_lock);
+	if (!nfl->nfs_uuid)
+		rcu_assign_pointer(nfl->nfs_uuid, nfs_uuid);
+	spin_unlock(&nfs_uuid_lock);
+}
+
 struct nfsd_file *nfs_open_local_fh(nfs_uuid_t *uuid,
 		   struct rpc_clnt *rpc_clnt, const struct cred *cred,
-		   const struct nfs_fh *nfs_fh, const fmode_t fmode)
+		   const struct nfs_fh *nfs_fh, struct nfs_file_localio *nfl,
+		   const fmode_t fmode)
 {
 	struct net *net;
 	struct nfsd_file *localio;
@@ -180,11 +189,50 @@ struct nfsd_file *nfs_open_local_fh(nfs_uuid_t *uuid,
 					     cred, nfs_fh, fmode);
 	if (IS_ERR(localio))
 		nfs_to_nfsd_net_put(net);
+	else
+		nfs_uuid_add_file(uuid, nfl);
 
 	return localio;
 }
 EXPORT_SYMBOL_GPL(nfs_open_local_fh);
 
+void nfs_close_local_fh(struct nfs_file_localio *nfl)
+{
+	struct nfsd_file *ro_nf = NULL;
+	struct nfsd_file *rw_nf = NULL;
+	nfs_uuid_t *nfs_uuid;
+
+	rcu_read_lock();
+	nfs_uuid = rcu_dereference(nfl->nfs_uuid);
+	if (!nfs_uuid) {
+		/* regular (non-LOCALIO) NFS will hammer this */
+		rcu_read_unlock();
+		return;
+	}
+
+	ro_nf = rcu_access_pointer(nfl->ro_file);
+	rw_nf = rcu_access_pointer(nfl->rw_file);
+	if (ro_nf || rw_nf) {
+		spin_lock(&nfs_uuid_lock);
+		if (ro_nf)
+			ro_nf = rcu_dereference_protected(xchg(&nfl->ro_file, NULL), 1);
+		if (rw_nf)
+			rw_nf = rcu_dereference_protected(xchg(&nfl->rw_file, NULL), 1);
+
+		rcu_assign_pointer(nfl->nfs_uuid, NULL);
+		spin_unlock(&nfs_uuid_lock);
+		rcu_read_unlock();
+
+		if (ro_nf)
+			nfs_to_nfsd_file_put_local(ro_nf);
+		if (rw_nf)
+			nfs_to_nfsd_file_put_local(rw_nf);
+		return;
+	}
+	rcu_read_unlock();
+}
+EXPORT_SYMBOL_GPL(nfs_close_local_fh);
+
 /*
  * The NFS LOCALIO code needs to call into NFSD using various symbols,
  * but cannot be statically linked, because that will make the NFS
diff --git a/include/linux/nfs_fs.h b/include/linux/nfs_fs.h
index 039898d70954..67ae2c3f41d2 100644
--- a/include/linux/nfs_fs.h
+++ b/include/linux/nfs_fs.h
@@ -77,6 +77,23 @@ struct nfs_lock_context {
 	struct rcu_head	rcu_head;
 };
 
+struct nfs_file_localio {
+	struct nfsd_file __rcu *ro_file;
+	struct nfsd_file __rcu *rw_file;
+	struct list_head list;
+	void __rcu *nfs_uuid; /* opaque pointer to 'nfs_uuid_t' */
+};
+
+static inline void nfs_localio_file_init(struct nfs_file_localio *nfl)
+{
+#if IS_ENABLED(CONFIG_NFS_LOCALIO)
+	nfl->ro_file = NULL;
+	nfl->rw_file = NULL;
+	INIT_LIST_HEAD(&nfl->list);
+	nfl->nfs_uuid = NULL;
+#endif
+}
+
 struct nfs4_state;
 struct nfs_open_context {
 	struct nfs_lock_context lock_context;
@@ -87,15 +104,16 @@ struct nfs_open_context {
 	struct nfs4_state *state;
 	fmode_t mode;
 
+	int error;
 	unsigned long flags;
 #define NFS_CONTEXT_BAD			(2)
 #define NFS_CONTEXT_UNLOCK	(3)
 #define NFS_CONTEXT_FILE_OPEN		(4)
-	int error;
 
-	struct list_head list;
 	struct nfs4_threshold	*mdsthreshold;
+	struct list_head list;
 	struct rcu_head	rcu_head;
+	struct nfs_file_localio nfl;
 };
 
 struct nfs_open_dir_context {
diff --git a/include/linux/nfslocalio.h b/include/linux/nfslocalio.h
index 4d5583873f41..7cfc6720ed26 100644
--- a/include/linux/nfslocalio.h
+++ b/include/linux/nfslocalio.h
@@ -6,10 +6,6 @@
 #ifndef __LINUX_NFSLOCALIO_H
 #define __LINUX_NFSLOCALIO_H
 
-
-/* nfsd_file structure is purposely kept opaque to NFS client */
-struct nfsd_file;
-
 #if IS_ENABLED(CONFIG_NFS_LOCALIO)
 
 #include <linux/module.h>
@@ -21,6 +17,7 @@ struct nfsd_file;
 #include <net/net_namespace.h>
 
 struct nfs_client;
+struct nfs_file_localio;
 
 /*
  * Useful to allow a client to negotiate if localio
@@ -52,6 +49,7 @@ extern struct nfsd_file *
 nfsd_open_local_fh(struct net *, struct auth_domain *, struct rpc_clnt *,
 		   const struct cred *, const struct nfs_fh *,
 		   const fmode_t) __must_hold(rcu);
+void nfs_close_local_fh(struct nfs_file_localio *);
 
 struct nfsd_localio_operations {
 	bool (*nfsd_serv_try_get)(struct net *);
@@ -73,7 +71,8 @@ extern const struct nfsd_localio_operations *nfs_to;
 
 struct nfsd_file *nfs_open_local_fh(nfs_uuid_t *,
 		   struct rpc_clnt *, const struct cred *,
-		   const struct nfs_fh *, const fmode_t);
+		   const struct nfs_fh *, struct nfs_file_localio *,
+		   const fmode_t);
 
 static inline void nfs_to_nfsd_net_put(struct net *net)
 {
@@ -100,12 +99,15 @@ static inline void nfs_to_nfsd_file_put_local(struct nfsd_file *localio)
 }
 
 #else   /* CONFIG_NFS_LOCALIO */
+
+struct nfs_file_localio;
+static inline void nfs_close_local_fh(struct nfs_file_localio *nfl)
+{
+}
 static inline void nfsd_localio_ops_init(void)
 {
 }
-static inline void nfs_to_nfsd_file_put_local(struct nfsd_file *localio)
-{
-}
+
 #endif  /* CONFIG_NFS_LOCALIO */
 
 #endif  /* __LINUX_NFSLOCALIO_H */
-- 
2.44.0



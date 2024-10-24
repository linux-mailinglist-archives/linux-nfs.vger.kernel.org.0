Return-Path: <linux-nfs+bounces-7459-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 748EE9AF032
	for <lists+linux-nfs@lfdr.de>; Thu, 24 Oct 2024 20:55:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F2B0E1F22361
	for <lists+linux-nfs@lfdr.de>; Thu, 24 Oct 2024 18:55:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8875B1F81AB;
	Thu, 24 Oct 2024 18:55:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VTIR5mEG"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62C2F7641E
	for <linux-nfs@vger.kernel.org>; Thu, 24 Oct 2024 18:55:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729796128; cv=none; b=ruqbtil5+O8nEtSTyyuMfXbJ8/0xL5Uj2o4W3qtd3eCoTwV7iOq6MRKtIDrj5hnzGuzuh4Rhm5dt88e71u1kBycJ8G0/ro9RJpBi3FtnbZz5LirOyCBsMFyboyID7zqVZxuvO4euwF9DJwz/ptcBUhWUYmdBs2i47IE6IvmEFcM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729796128; c=relaxed/simple;
	bh=wngHuNMQSw0uLd06Nt3/OZUQCa0HdeBG0OoGh0JwIr8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=UcRi4JIq4W3zKWif1kQKijkkq6W4/HYdmRdpJGRISooQKS6/121bxnXzBLa0hvzwJxgRjz6VAUxHCplBqn3TOYIlN2O/prG33mjq72lMJ/c8iMDvRa1bfGvQzTSXLxHq48EvLkjR9ZxXW04SNzccLGJ2UTUYoYJmkyT1PAmCeZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VTIR5mEG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84928C4CEC7;
	Thu, 24 Oct 2024 18:55:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729796127;
	bh=wngHuNMQSw0uLd06Nt3/OZUQCa0HdeBG0OoGh0JwIr8=;
	h=From:To:Cc:Subject:Date:From;
	b=VTIR5mEGvKhLBOMeYdYe5FRfp5Szny6zeP+EQJ/g7CdKMUYAktT5KcWGJRT5E/ie0
	 QvgH2/8jWOxoM05Cgs63czxIS0dGwU2StaSd139ITCueAzYJNe1DiyAi8CTLNgwpB+
	 DtsxhfQJKwpKnKHE913Xw9rNiqWZC8pd4gl2syEXA52WRDaBE7sB+gY2h36QzS5R/D
	 eJRk7Dka89P9LNHYGxHS6JqSky4Ie0ArAalAtAhmS6xRHbn2hh0Y7Ont/QjtCHttMD
	 BgH0tDlVLcMMFDEduvvGU4+KtmkKc8iPLE3pAY91mvAcJjtaFDANLtyktV4Hi2SjGC
	 D09Eyz2rkWTEw==
From: Mike Snitzer <snitzer@kernel.org>
To: linux-nfs@vger.kernel.org
Cc: Anna Schumaker <anna@kernel.org>,
	Trond Myklebust <trondmy@hammerspace.com>,
	Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>,
	NeilBrown <neilb@suse.de>
Subject: [PATCH] nfsd/filecache: add nfsd_file_acquire_gc_cached
Date: Thu, 24 Oct 2024 14:55:26 -0400
Message-ID: <20241024185526.76146-1-snitzer@kernel.org>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Rather than make nfsd_file_do_acquire() more complex (by training
it to conditionally skip both fh_verify() and nfsd_file allocation
and contruction) introduce nfsd_file_acquire_gc_cached() -- which
duplicates the minimalist subset of nfsd_file_do_acquire() needed to
achieve nfsd_file lookup using an opaque @inode_key.

nfsd_file_acquire_gc_cached() only returns a cached and GC'd nfsd_file
obtained using the opaque @inode_key, established from a previous call
to nfsd_file_do_acquire_local() that originally added the GC'd
nfsd_file to the filecache.

Update nfsd_open_local_fh to store @inode_key in @nfs_fh so later
calls can check if it maps to an open GC'd nfsd_file in the filecache
using nfsd_file_acquire_gc_cached().  Its nfsd_file_lookup_locked()
call will only find a match if @cred matches the nfsd_file's nf_cred.

And care is taken to clear the inode_key in nfsd_file_free() if the
nfsd_file has a non-NULL nf_inodep (which is a pointer to the address
of the opaque inode_key stored in the nfs_fh).  This avoids any risk
of re-using the old inode_key for a different nfsd_file.

This commit's cached nfsd_file lookup dramatically speeds up LOCALIO
performance, especially for small 4K O_DIRECT IO, e.g.:

before: read: IOPS=376k,  BW=1469MiB/s (1541MB/s)(28.7GiB/20001msec)
after:  read: IOPS=1037k, BW=4050MiB/s (4247MB/s)(79.1GiB/20002msec)

Note that LOCALIO calls nfsd_open_local_fh() for every IO it issues to
the underlying filesystem using the returned nfsd_file.  This is why
caching the opaque 'inode_key' in 'struct nfs_fh' is so helpful for
LOCALIO to quickly return the cached nfsd_file.  Whereas regular NFS
avoids fh_verify()'s costly duplicate lookups of the underlying
filesystem's dentry by caching it in 'fh_dentry' of 'struct svc_fh'.
LOCALIO cannot take the same approach, of storing the dentry, without
creating object lifetime issues associated with dentry references
holding server mounts open and preventing unmounts.

Signed-off-by: Mike Snitzer <snitzer@kernel.org>
---
 fs/nfs/inode.c             |  3 ++
 fs/nfs_common/nfslocalio.c |  2 +-
 fs/nfsd/filecache.c        | 78 ++++++++++++++++++++++++++++++++++++++
 fs/nfsd/filecache.h        |  7 ++++
 fs/nfsd/localio.c          | 46 +++++++++++++++++++---
 include/linux/nfs.h        |  4 ++
 include/linux/nfslocalio.h |  6 +--
 7 files changed, 136 insertions(+), 10 deletions(-)

diff --git a/fs/nfs/inode.c b/fs/nfs/inode.c
index cc7a32b32676..3051d65e3a89 100644
--- a/fs/nfs/inode.c
+++ b/fs/nfs/inode.c
@@ -2413,6 +2413,9 @@ struct inode *nfs_alloc_inode(struct super_block *sb)
 #endif /* CONFIG_NFS_V4 */
 #ifdef CONFIG_NFS_V4_2
 	nfsi->xattr_cache = NULL;
+#endif
+#if IS_ENABLED(CONFIG_NFS_LOCALIO)
+	nfsi->fh.inode_key = NULL;
 #endif
 	nfs_netfs_inode_init(nfsi);
 
diff --git a/fs/nfs_common/nfslocalio.c b/fs/nfs_common/nfslocalio.c
index 09404d142d1a..bacebaa1e15c 100644
--- a/fs/nfs_common/nfslocalio.c
+++ b/fs/nfs_common/nfslocalio.c
@@ -130,7 +130,7 @@ EXPORT_SYMBOL_GPL(nfs_uuid_invalidate_one_client);
 
 struct nfsd_file *nfs_open_local_fh(nfs_uuid_t *uuid,
 		   struct rpc_clnt *rpc_clnt, const struct cred *cred,
-		   const struct nfs_fh *nfs_fh, const fmode_t fmode)
+		   struct nfs_fh *nfs_fh, const fmode_t fmode)
 {
 	struct net *net;
 	struct nfsd_file *localio;
diff --git a/fs/nfsd/filecache.c b/fs/nfsd/filecache.c
index 1408166222c5..5ab978ac3555 100644
--- a/fs/nfsd/filecache.c
+++ b/fs/nfsd/filecache.c
@@ -221,6 +221,9 @@ nfsd_file_alloc(struct net *net, struct inode *inode, unsigned char need,
 	INIT_LIST_HEAD(&nf->nf_gc);
 	nf->nf_birthtime = ktime_get();
 	nf->nf_file = NULL;
+#if IS_ENABLED(CONFIG_NFS_LOCALIO)
+	nf->nf_inodep = NULL;
+#endif
 	nf->nf_cred = get_current_cred();
 	nf->nf_net = net;
 	nf->nf_flags = want_gc ?
@@ -285,6 +288,12 @@ nfsd_file_free(struct nfsd_file *nf)
 		nfsd_file_check_write_error(nf);
 		nfsd_filp_close(nf->nf_file);
 	}
+#if IS_ENABLED(CONFIG_NFS_LOCALIO)
+	if (nf->nf_inodep) {
+		*(nf->nf_inodep) = NULL;
+		nf->nf_inodep = NULL;
+	}
+#endif
 
 	/*
 	 * If this item is still linked via nf_lru, that's a bug.
@@ -1255,6 +1264,75 @@ nfsd_file_acquire_local(struct net *net, struct svc_cred *cred,
 	return beres;
 }
 
+/**
+ * nfsd_file_acquire_cached - Get cached GC'd open file using inode
+ * @net: The network namespace in which to perform a lookup
+ * @cred: the user credential with which to validate access
+ * @inode_key: inode to use as opaque lookup key
+ * @may_flags: NFSD_MAY_ settings for the file
+ * @pnf: OUT: found cached GC'd "struct nfsd_file" object
+ *
+ * Rather than make nfsd_file_do_acquire more complex (by training
+ * it to conditionally skip fh_verify(), nfsd_file allocation and
+ * contruction) duplicate the minimalist subset of it that is
+ * needed to achieve nfsd_file lookup using the opaque @inode_key.
+ *
+ * The nfsd_file object returned by this API is reference-counted
+ * and garbage-collected. The object is retained for a few
+ * seconds after the final nfsd_file_put() in case the caller
+ * wants to re-use it.
+ *
+ * Return values:
+ *   %nfs_ok - @pnf points to an nfsd_file with its reference
+ *   count boosted.
+ *
+ * On error, an nfsstat value in network byte order is returned.
+ */
+__be32
+nfsd_file_acquire_cached(struct net *net, const struct cred *cred,
+			 void *inode_key, unsigned int may_flags,
+			 struct nfsd_file **pnf)
+{
+	unsigned char need = may_flags & NFSD_FILE_MAY_MASK;
+	struct nfsd_file *nf;
+	__be32 status;
+
+	rcu_read_lock();
+	nf = nfsd_file_lookup_locked(net, cred, inode_key, need, true);
+	rcu_read_unlock();
+
+	if (unlikely(!nf))
+		return nfserr_noent;
+
+	/*
+	 * If the nf is on the LRU then it holds an extra reference
+	 * that must be put if it's removed. It had better not be
+	 * the last one however, since we should hold another.
+	 */
+	if (nfsd_file_lru_remove(nf))
+		WARN_ON_ONCE(refcount_dec_and_test(&nf->nf_ref));
+
+	if (WARN_ON_ONCE(test_bit(NFSD_FILE_PENDING, &nf->nf_flags) ||
+			 !test_bit(NFSD_FILE_HASHED, &nf->nf_flags))) {
+		status = nfserr_inval;
+		goto error;
+	}
+	this_cpu_inc(nfsd_file_cache_hits);
+
+	status = nfserrno(nfsd_open_break_lease(file_inode(nf->nf_file), may_flags));
+	if (status != nfs_ok) {
+error:
+		nfsd_file_put(nf);
+		nf = NULL;
+	} else {
+		this_cpu_inc(nfsd_file_acquisitions);
+		nfsd_file_check_write_error(nf);
+		*pnf = nf;
+	}
+	trace_nfsd_file_acquire(NULL, inode_key, may_flags, nf, status);
+	return status;
+}
+
 /**
  * nfsd_file_acquire_opened - Get a struct nfsd_file using existing open file
  * @rqstp: the RPC transaction being executed
diff --git a/fs/nfsd/filecache.h b/fs/nfsd/filecache.h
index cadf3c2689c4..e000f6988dc8 100644
--- a/fs/nfsd/filecache.h
+++ b/fs/nfsd/filecache.h
@@ -47,6 +47,10 @@ struct nfsd_file {
 	struct list_head	nf_gc;
 	struct rcu_head		nf_rcu;
 	ktime_t			nf_birthtime;
+
+#if IS_ENABLED(CONFIG_NFS_LOCALIO)
+	void **			nf_inodep;
+#endif
 };
 
 int nfsd_file_cache_init(void);
@@ -71,5 +75,8 @@ __be32 nfsd_file_acquire_opened(struct svc_rqst *rqstp, struct svc_fh *fhp,
 __be32 nfsd_file_acquire_local(struct net *net, struct svc_cred *cred,
 			       struct auth_domain *client, struct svc_fh *fhp,
 			       unsigned int may_flags, struct nfsd_file **pnf);
+__be32 nfsd_file_acquire_cached(struct net *net, const struct cred *cred,
+			       void *inode_key, unsigned int may_flags,
+			       struct nfsd_file **pnf);
 int nfsd_file_cache_stats_show(struct seq_file *m, void *v);
 #endif /* _FS_NFSD_FILECACHE_H */
diff --git a/fs/nfsd/localio.c b/fs/nfsd/localio.c
index f441cb9f74d5..34a229409117 100644
--- a/fs/nfsd/localio.c
+++ b/fs/nfsd/localio.c
@@ -58,33 +58,67 @@ void nfsd_localio_ops_init(void)
 struct nfsd_file *
 nfsd_open_local_fh(struct net *net, struct auth_domain *dom,
 		   struct rpc_clnt *rpc_clnt, const struct cred *cred,
-		   const struct nfs_fh *nfs_fh, const fmode_t fmode)
+		   struct nfs_fh *nfs_fh, const fmode_t fmode)
 {
 	int mayflags = NFSD_MAY_LOCALIO;
 	struct svc_cred rq_cred;
 	struct svc_fh fh;
 	struct nfsd_file *localio;
+	void *nf_inode_key;
 	__be32 beres;
 
 	if (nfs_fh->size > NFS4_FHSIZE)
 		return ERR_PTR(-EINVAL);
 
-	/* nfs_fh -> svc_fh */
-	fh_init(&fh, NFS4_FHSIZE);
-	fh.fh_handle.fh_size = nfs_fh->size;
-	memcpy(fh.fh_handle.fh_raw, nfs_fh->data, nfs_fh->size);
-
 	if (fmode & FMODE_READ)
 		mayflags |= NFSD_MAY_READ;
 	if (fmode & FMODE_WRITE)
 		mayflags |= NFSD_MAY_WRITE;
 
+	/*
+	 * Check if 'inode_key' stored in @nfs_fh maps to an
+	 * open nfsd_file in the filecache (from a previous
+	 * nfsd_open_local_fh).
+	 *
+	 * The 'inode_key' may have become stale (due to nfsd_file
+	 * being free'd by filecache GC) so the lookup will fail
+	 * gracefully by falling back to using nfsd_file_acquire_local().
+	 */
+	nf_inode_key = READ_ONCE(nfs_fh->inode_key);
+	if (nf_inode_key) {
+		beres = nfsd_file_acquire_cached(net, cred,
+						 nf_inode_key,
+						 mayflags, &localio);
+		if (beres == nfs_ok)
+			return localio;
+		/*
+		 * reset stale nfs_fh->inode_key and fallthru
+		 * to use normal nfsd_file_acquire_local().
+		 */
+		nfs_fh->inode_key = NULL;
+	}
+
+	/* nfs_fh -> svc_fh */
+	fh_init(&fh, NFS4_FHSIZE);
+	fh.fh_handle.fh_size = nfs_fh->size;
+	memcpy(fh.fh_handle.fh_raw, nfs_fh->data, nfs_fh->size);
+
 	svcauth_map_clnt_to_svc_cred_local(rpc_clnt, cred, &rq_cred);
 
 	beres = nfsd_file_acquire_local(net, &rq_cred, dom,
 					&fh, mayflags, &localio);
 	if (beres)
 		localio = ERR_PTR(nfs_stat_to_errno(be32_to_cpu(beres)));
+	else {
+		/*
+		 * opaque 'inode_key' has a 1:1 mapping to both an
+		 * nfsd_file and nfs_fh struct (And the nfs_fh is shared
+		 * by all NFS client threads. So there is no risk of
+		 * storing competing addresses in nfsd_file->nf_inodep
+		 */
+		localio->nf_inodep = (void **) &nfs_fh->inode_key;
+		nfs_fh->inode_key = localio->nf_inode;
+	}
 
 	fh_put(&fh);
 	if (rq_cred.cr_group_info)
diff --git a/include/linux/nfs.h b/include/linux/nfs.h
index 9ad727ddfedb..56c894575c70 100644
--- a/include/linux/nfs.h
+++ b/include/linux/nfs.h
@@ -29,6 +29,10 @@
 struct nfs_fh {
 	unsigned short		size;
 	unsigned char		data[NFS_MAXFHSIZE];
+#if IS_ENABLED(CONFIG_NFS_LOCALIO)
+	/* 'inode_key' is an opaque key used for nfsd_file hash lookups */
+	void *			inode_key;
+#endif
 };
 
 /*
diff --git a/include/linux/nfslocalio.h b/include/linux/nfslocalio.h
index 3982fea79919..619eb1961ed6 100644
--- a/include/linux/nfslocalio.h
+++ b/include/linux/nfslocalio.h
@@ -43,7 +43,7 @@ void nfs_uuid_invalidate_one_client(nfs_uuid_t *nfs_uuid);
 /* localio needs to map filehandle -> struct nfsd_file */
 extern struct nfsd_file *
 nfsd_open_local_fh(struct net *, struct auth_domain *, struct rpc_clnt *,
-		   const struct cred *, const struct nfs_fh *,
+		   const struct cred *, struct nfs_fh *,
 		   const fmode_t) __must_hold(rcu);
 
 struct nfsd_localio_operations {
@@ -53,7 +53,7 @@ struct nfsd_localio_operations {
 						struct auth_domain *,
 						struct rpc_clnt *,
 						const struct cred *,
-						const struct nfs_fh *,
+						struct nfs_fh *,
 						const fmode_t);
 	void (*nfsd_file_put_local)(struct nfsd_file *);
 	struct file *(*nfsd_file_file)(struct nfsd_file *);
@@ -64,7 +64,7 @@ extern const struct nfsd_localio_operations *nfs_to;
 
 struct nfsd_file *nfs_open_local_fh(nfs_uuid_t *,
 		   struct rpc_clnt *, const struct cred *,
-		   const struct nfs_fh *, const fmode_t);
+		   struct nfs_fh *, const fmode_t);
 
 static inline void nfs_to_nfsd_file_put_local(struct nfsd_file *localio)
 {
-- 
2.44.0



Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 161E16183FF
	for <lists+linux-nfs@lfdr.de>; Thu,  3 Nov 2022 17:17:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230348AbiKCQRt (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 3 Nov 2022 12:17:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230513AbiKCQRs (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 3 Nov 2022 12:17:48 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3487418B32
        for <linux-nfs@vger.kernel.org>; Thu,  3 Nov 2022 09:16:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1667492207;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4pyduKvLmAMWKOF+/gvQTaHpJgex5vFf4njDiX0p3LA=;
        b=csuEYcDykCRYBJ99zL1X04YiA/82oX1AxPVa+guds8+cmmR7l/aZOjE1DTq0rPpSbWP9Fy
        xOT5l67BzoEjgeDNPNt6gF5KA/U6cGtxFHuT7NkKY66q522MZm6XclfwAoLihc458OsJ8q
        xQZFdeeRrdTnXeeh8E/jCmmCi5OguHw=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-450-bkXc6VRSMbiV--9CmRoErA-1; Thu, 03 Nov 2022 12:16:44 -0400
X-MC-Unique: bkXc6VRSMbiV--9CmRoErA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 302461064A5B;
        Thu,  3 Nov 2022 16:16:42 +0000 (UTC)
Received: from dwysocha.rdu.csb (unknown [10.22.10.74])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id E38F61402BDA;
        Thu,  3 Nov 2022 16:16:41 +0000 (UTC)
From:   Dave Wysochanski <dwysocha@redhat.com>
To:     Anna Schumaker <anna.schumaker@netapp.com>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        David Howells <dhowells@redhat.com>
Cc:     linux-nfs@vger.kernel.org, linux-cachefs@redhat.com,
        Benjamin Maynard <benmaynard@google.com>,
        Daire Byrne <daire.byrne@gmail.com>
Subject: [RFC PATCH v10 6/6] netfs: Change netfs_inode_init to allocate memory to allow opt-in
Date:   Thu,  3 Nov 2022 12:16:37 -0400
Message-Id: <20221103161637.1725471-7-dwysocha@redhat.com>
In-Reply-To: <20221103161637.1725471-1-dwysocha@redhat.com>
References: <20221103161637.1725471-1-dwysocha@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.7
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Reduce the memory footprint for non-netfs enabled mounts by changing
the netfs_inode structure to contain a "struct inode" and a pointer
to the rest of the netfs data, which is now inside a new structure
"netfs_info".

This keeps the memory footprint equal to the previous footprint
inside a network filesystems inode structure when fscache was
enabled (a struct inode, plus a pointer).

This saves memory for network filesystems inode that would build
in netfs support, but like to opt-in to netfs on some mounts while
opting-out of netfs on other mounts.

FIXME: call netfs_inode_free() as needed (afs, ceph, etc)
FIXME: Check setting of remote_i_size

Signed-off-by: Dave Wysochanski <dwysocha@redhat.com>
---
 fs/9p/cache.c            |  2 +-
 fs/9p/vfs_inode.c        | 17 +++++++----------
 fs/afs/dynroot.c         |  7 ++++++-
 fs/afs/inode.c           | 14 ++------------
 fs/afs/internal.h        |  2 +-
 fs/afs/super.c           |  7 +++++++
 fs/afs/write.c           |  2 +-
 fs/ceph/inode.c          |  6 +++++-
 fs/netfs/buffered_read.c | 16 ++++++++--------
 fs/netfs/internal.h      |  2 +-
 fs/netfs/objects.c       |  2 +-
 fs/nfs/fscache.c         | 12 ++++++------
 fs/nfs/fscache.h         | 11 ++++++++---
 fs/nfs/inode.c           |  9 ++++++++-
 include/linux/netfs.h    | 41 +++++++++++++++++++++++++++++-----------
 15 files changed, 92 insertions(+), 58 deletions(-)

diff --git a/fs/9p/cache.c b/fs/9p/cache.c
index cebba4eaa0b5..9940ab8383c9 100644
--- a/fs/9p/cache.c
+++ b/fs/9p/cache.c
@@ -62,7 +62,7 @@ void v9fs_cache_inode_get_cookie(struct inode *inode)
 	version = cpu_to_le32(v9inode->qid.version);
 	path = cpu_to_le64(v9inode->qid.path);
 	v9ses = v9fs_inode2v9ses(inode);
-	v9inode->netfs.cache =
+	v9inode->netfs.info->cache =
 		fscache_acquire_cookie(v9fs_session_cache(v9ses),
 				       0,
 				       &path, sizeof(path),
diff --git a/fs/9p/vfs_inode.c b/fs/9p/vfs_inode.c
index 4d1a4a8d9277..4219882d58eb 100644
--- a/fs/9p/vfs_inode.c
+++ b/fs/9p/vfs_inode.c
@@ -227,10 +227,16 @@ v9fs_blank_wstat(struct p9_wstat *wstat)
 struct inode *v9fs_alloc_inode(struct super_block *sb)
 {
 	struct v9fs_inode *v9inode;
+	int ret;
 
 	v9inode = alloc_inode_sb(sb, v9fs_inode_cache, GFP_KERNEL);
 	if (!v9inode)
 		return NULL;
+	ret = netfs_inode_init(&v9inode->netfs, &v9fs_req_ops);
+	if (ret) {
+		kmem_cache_free(v9fs_inode_cache, v9inode);
+		return NULL;
+	}
 	v9inode->writeback_fid = NULL;
 	v9inode->cache_validity = 0;
 	mutex_init(&v9inode->v_mutex);
@@ -244,18 +250,10 @@ struct inode *v9fs_alloc_inode(struct super_block *sb)
 
 void v9fs_free_inode(struct inode *inode)
 {
+	netfs_inode_free(&V9FS_I(inode)->netfs);
 	kmem_cache_free(v9fs_inode_cache, V9FS_I(inode));
 }
 
-/*
- * Set parameters for the netfs library
- */
-static void v9fs_set_netfs_context(struct inode *inode)
-{
-	struct v9fs_inode *v9inode = V9FS_I(inode);
-	netfs_inode_init(&v9inode->netfs, &v9fs_req_ops);
-}
-
 int v9fs_init_inode(struct v9fs_session_info *v9ses,
 		    struct inode *inode, umode_t mode, dev_t rdev)
 {
@@ -345,7 +343,6 @@ int v9fs_init_inode(struct v9fs_session_info *v9ses,
 		goto error;
 	}
 
-	v9fs_set_netfs_context(inode);
 error:
 	return err;
 
diff --git a/fs/afs/dynroot.c b/fs/afs/dynroot.c
index d7d9402ff718..6006c1210d47 100644
--- a/fs/afs/dynroot.c
+++ b/fs/afs/dynroot.c
@@ -48,6 +48,7 @@ struct inode *afs_iget_pseudo_dir(struct super_block *sb, bool root)
 	struct afs_vnode *vnode;
 	struct inode *inode;
 	struct afs_fid fid = {};
+	int ret;
 
 	_enter("");
 
@@ -76,7 +77,11 @@ struct inode *afs_iget_pseudo_dir(struct super_block *sb, bool root)
 	/* there shouldn't be an existing inode */
 	BUG_ON(!(inode->i_state & I_NEW));
 
-	netfs_inode_init(&vnode->netfs, NULL);
+	ret = netfs_inode_init(&vnode->netfs, NULL);
+	if (ret) {
+		_leave("= %d", ret);
+		return ERR_PTR(ret);
+	}
 	inode->i_size		= 0;
 	inode->i_mode		= S_IFDIR | S_IRUGO | S_IXUGO;
 	if (root) {
diff --git a/fs/afs/inode.c b/fs/afs/inode.c
index 6d3a3dbe4928..a69683f1c213 100644
--- a/fs/afs/inode.c
+++ b/fs/afs/inode.c
@@ -53,14 +53,6 @@ static noinline void dump_vnode(struct afs_vnode *vnode, struct afs_vnode *paren
 		dump_stack();
 }
 
-/*
- * Set parameters for the netfs library
- */
-static void afs_set_netfs_context(struct afs_vnode *vnode)
-{
-	netfs_inode_init(&vnode->netfs, &afs_req_ops);
-}
-
 /*
  * Initialise an inode from the vnode status.
  */
@@ -138,7 +130,6 @@ static int afs_inode_init_from_status(struct afs_operation *op,
 	}
 
 	afs_set_i_size(vnode, status->size);
-	afs_set_netfs_context(vnode);
 
 	vnode->invalid_before	= status->data_version;
 	inode_set_iversion_raw(&vnode->netfs.inode, status->data_version);
@@ -248,7 +239,7 @@ static void afs_apply_status(struct afs_operation *op,
 		 * idea of what the size should be that's not the same as
 		 * what's on the server.
 		 */
-		vnode->netfs.remote_i_size = status->size;
+		vnode->netfs.info->remote_i_size = status->size;
 		if (change_size) {
 			afs_set_i_size(vnode, status->size);
 			inode->i_ctime = t;
@@ -432,7 +423,7 @@ static void afs_get_inode_cache(struct afs_vnode *vnode)
 	struct afs_vnode_cache_aux aux;
 
 	if (vnode->status.type != AFS_FTYPE_FILE) {
-		vnode->netfs.cache = NULL;
+		vnode->netfs.info->cache = NULL;
 		return;
 	}
 
@@ -542,7 +533,6 @@ struct inode *afs_root_iget(struct super_block *sb, struct key *key)
 
 	vnode = AFS_FS_I(inode);
 	vnode->cb_v_break = as->volume->cb_v_break,
-	afs_set_netfs_context(vnode);
 
 	op = afs_alloc_operation(key, as->volume);
 	if (IS_ERR(op)) {
diff --git a/fs/afs/internal.h b/fs/afs/internal.h
index 723d162078a3..141b8458d989 100644
--- a/fs/afs/internal.h
+++ b/fs/afs/internal.h
@@ -679,7 +679,7 @@ static inline void afs_vnode_set_cache(struct afs_vnode *vnode,
 				       struct fscache_cookie *cookie)
 {
 #ifdef CONFIG_AFS_FSCACHE
-	vnode->netfs.cache = cookie;
+	vnode->netfs.info->cache = cookie;
 #endif
 }
 
diff --git a/fs/afs/super.c b/fs/afs/super.c
index 95d713074dc8..d0ff1349a17e 100644
--- a/fs/afs/super.c
+++ b/fs/afs/super.c
@@ -678,11 +678,17 @@ static void afs_i_init_once(void *_vnode)
 static struct inode *afs_alloc_inode(struct super_block *sb)
 {
 	struct afs_vnode *vnode;
+	int	ret;
 
 	vnode = alloc_inode_sb(sb, afs_inode_cachep, GFP_KERNEL);
 	if (!vnode)
 		return NULL;
 
+	ret = netfs_inode_init(&vnode->netfs, &afs_req_ops);
+	if (ret) {
+		afs_free_inode(AFS_VNODE_TO_I(vnode));
+		return NULL;
+	}
 	atomic_inc(&afs_count_active_inodes);
 
 	/* Reset anything that shouldn't leak from one inode to the next. */
@@ -706,6 +712,7 @@ static struct inode *afs_alloc_inode(struct super_block *sb)
 
 static void afs_free_inode(struct inode *inode)
 {
+	netfs_inode_free(&AFS_FS_I(inode)->netfs);
 	kmem_cache_free(afs_inode_cachep, AFS_FS_I(inode));
 }
 
diff --git a/fs/afs/write.c b/fs/afs/write.c
index 9ebdd36eaf2f..983924427edf 100644
--- a/fs/afs/write.c
+++ b/fs/afs/write.c
@@ -384,7 +384,7 @@ static int afs_store_data(struct afs_vnode *vnode, struct iov_iter *iter, loff_t
 	op->store.write_iter = iter;
 	op->store.pos = pos;
 	op->store.size = size;
-	op->store.i_size = max(pos + size, vnode->netfs.remote_i_size);
+	op->store.i_size = max(pos + size, vnode->netfs.info->remote_i_size);
 	op->store.laundering = laundering;
 	op->mtime = vnode->netfs.inode.i_mtime;
 	op->flags |= AFS_OPERATION_UNINTR;
diff --git a/fs/ceph/inode.c b/fs/ceph/inode.c
index 4af5e55abc15..a6ca69591c93 100644
--- a/fs/ceph/inode.c
+++ b/fs/ceph/inode.c
@@ -452,6 +452,7 @@ struct inode *ceph_alloc_inode(struct super_block *sb)
 {
 	struct ceph_inode_info *ci;
 	int i;
+	int ret;
 
 	ci = alloc_inode_sb(sb, ceph_inode_cachep, GFP_NOFS);
 	if (!ci)
@@ -460,7 +461,9 @@ struct inode *ceph_alloc_inode(struct super_block *sb)
 	dout("alloc_inode %p\n", &ci->netfs.inode);
 
 	/* Set parameters for the netfs library */
-	netfs_inode_init(&ci->netfs, &ceph_netfs_ops);
+	ret = netfs_inode_init(&ci->netfs, &ceph_netfs_ops);
+	if (ret)
+		return NULL;
 
 	spin_lock_init(&ci->i_ceph_lock);
 
@@ -554,6 +557,7 @@ void ceph_free_inode(struct inode *inode)
 {
 	struct ceph_inode_info *ci = ceph_inode(inode);
 
+	netfs_inode_free(&ceph_inode(inode)->netfs);
 	kfree(ci->i_symlink);
 	kmem_cache_free(ceph_inode_cachep, ci);
 }
diff --git a/fs/netfs/buffered_read.c b/fs/netfs/buffered_read.c
index 0ce535852151..3a75d3784adc 100644
--- a/fs/netfs/buffered_read.c
+++ b/fs/netfs/buffered_read.c
@@ -170,8 +170,8 @@ void netfs_readahead(struct readahead_control *ractl)
 	if (IS_ERR(rreq))
 		return;
 
-	if (ctx->ops->begin_cache_operation) {
-		ret = ctx->ops->begin_cache_operation(rreq);
+	if (ctx->info->ops->begin_cache_operation) {
+		ret = ctx->info->ops->begin_cache_operation(rreq);
 		if (ret == -ENOMEM || ret == -EINTR || ret == -ERESTARTSYS)
 			goto cleanup_free;
 	}
@@ -228,8 +228,8 @@ int netfs_read_folio(struct file *file, struct folio *folio)
 		goto alloc_error;
 	}
 
-	if (ctx->ops->begin_cache_operation) {
-		ret = ctx->ops->begin_cache_operation(rreq);
+	if (ctx->info->ops->begin_cache_operation) {
+		ret = ctx->info->ops->begin_cache_operation(rreq);
 		if (ret == -ENOMEM || ret == -EINTR || ret == -ERESTARTSYS)
 			goto discard;
 	}
@@ -347,9 +347,9 @@ int netfs_write_begin(struct netfs_inode *ctx,
 	if (!folio)
 		return -ENOMEM;
 
-	if (ctx->ops->check_write_begin) {
+	if (ctx->info->ops->check_write_begin) {
 		/* Allow the netfs (eg. ceph) to flush conflicts. */
-		ret = ctx->ops->check_write_begin(file, pos, len, &folio, _fsdata);
+		ret = ctx->info->ops->check_write_begin(file, pos, len, &folio, _fsdata);
 		if (ret < 0) {
 			trace_netfs_failure(NULL, NULL, ret, netfs_fail_check_write_begin);
 			goto error;
@@ -381,8 +381,8 @@ int netfs_write_begin(struct netfs_inode *ctx,
 	rreq->no_unlock_folio	= folio_index(folio);
 	__set_bit(NETFS_RREQ_NO_UNLOCK_FOLIO, &rreq->flags);
 
-	if (ctx->ops->begin_cache_operation) {
-		ret = ctx->ops->begin_cache_operation(rreq);
+	if (ctx->info->ops->begin_cache_operation) {
+		ret = ctx->info->ops->begin_cache_operation(rreq);
 		if (ret == -ENOMEM || ret == -EINTR || ret == -ERESTARTSYS)
 			goto error_put;
 	}
diff --git a/fs/netfs/internal.h b/fs/netfs/internal.h
index 43fac1b14e40..be3c8388812d 100644
--- a/fs/netfs/internal.h
+++ b/fs/netfs/internal.h
@@ -94,7 +94,7 @@ static inline void netfs_stat_d(atomic_t *stat)
 static inline bool netfs_is_cache_enabled(struct netfs_inode *ctx)
 {
 #if IS_ENABLED(CONFIG_FSCACHE)
-	struct fscache_cookie *cookie = ctx->cache;
+	struct fscache_cookie *cookie = ctx->info->cache;
 
 	return fscache_cookie_valid(cookie) && cookie->cache_priv &&
 		fscache_cookie_enabled(cookie);
diff --git a/fs/netfs/objects.c b/fs/netfs/objects.c
index e17cdf53f6a7..a1bcec71686f 100644
--- a/fs/netfs/objects.c
+++ b/fs/netfs/objects.c
@@ -29,7 +29,7 @@ struct netfs_io_request *netfs_alloc_request(struct address_space *mapping,
 	rreq->start	= start;
 	rreq->len	= len;
 	rreq->origin	= origin;
-	rreq->netfs_ops	= ctx->ops;
+	rreq->netfs_ops	= ctx->info->ops;
 	rreq->mapping	= mapping;
 	rreq->inode	= inode;
 	rreq->i_size	= i_size_read(inode);
diff --git a/fs/nfs/fscache.c b/fs/nfs/fscache.c
index 8dac02d05f70..e873332a9e43 100644
--- a/fs/nfs/fscache.c
+++ b/fs/nfs/fscache.c
@@ -166,13 +166,13 @@ void nfs_fscache_init_inode(struct inode *inode)
 	struct nfs_server *nfss = NFS_SERVER(inode);
 	struct nfs_inode *nfsi = NFS_I(inode);
 
-	netfs_inode(inode)->cache = NULL;
+	netfs_inode(inode)->info->cache = NULL;
 	if (!(nfss->fscache && S_ISREG(inode->i_mode)))
 		return;
 
 	nfs_fscache_update_auxdata(&auxdata, inode);
 
-	netfs_inode(inode)->cache = fscache_acquire_cookie(
+	netfs_inode(inode)->info->cache = fscache_acquire_cookie(
 					       nfss->fscache,
 					       0,
 					       nfsi->fh.data, /* index_key */
@@ -188,7 +188,7 @@ void nfs_fscache_init_inode(struct inode *inode)
 void nfs_fscache_clear_inode(struct inode *inode)
 {
 	fscache_relinquish_cookie(netfs_i_cookie(netfs_inode(inode)), false);
-	netfs_inode(inode)->cache = NULL;
+	netfs_inode(inode)->info->cache = NULL;
 }
 
 /*
@@ -240,7 +240,7 @@ void nfs_fscache_release_file(struct inode *inode, struct file *filp)
 
 int nfs_netfs_read_folio(struct file *file, struct folio *folio)
 {
-	if (!netfs_inode(folio_inode(folio))->cache)
+	if (!netfs_inode(folio_inode(folio))->info->cache)
 		return -ENOBUFS;
 
 	return netfs_read_folio(file, folio);
@@ -250,7 +250,7 @@ int nfs_netfs_readahead(struct readahead_control *ractl)
 {
 	struct inode *inode = ractl->mapping->host;
 
-	if (!netfs_inode(inode)->cache)
+	if (!netfs_inode(inode)->info->cache)
 		return -ENOBUFS;
 
 	netfs_readahead(ractl);
@@ -354,7 +354,7 @@ void nfs_netfs_readpage_release(struct nfs_page *req)
 	/*
 	 * If fscache is enabled, netfs will unlock pages.
 	 */
-	if (netfs_inode(inode)->cache)
+	if (netfs_inode(inode)->info->cache)
 		return;
 
 	unlock_page(req->wb_page);
diff --git a/fs/nfs/fscache.h b/fs/nfs/fscache.h
index 18da26157fda..23c9412a671e 100644
--- a/fs/nfs/fscache.h
+++ b/fs/nfs/fscache.h
@@ -78,9 +78,13 @@ static inline void nfs_netfs_put(struct nfs_netfs_io_data *netfs)
 	netfs_subreq_terminated(netfs->sreq, netfs->error ?: final_len, false);
 	kfree(netfs);
 }
-static inline void nfs_netfs_inode_init(struct nfs_inode *nfsi)
+static inline int nfs_netfs_inode_init(struct nfs_inode *nfsi)
 {
-	netfs_inode_init(&nfsi->netfs, &nfs_netfs_ops);
+	return netfs_inode_init(&nfsi->netfs, &nfs_netfs_ops);
+}
+static inline void nfs_netfs_inode_free(struct nfs_inode *nfsi)
+{
+	netfs_inode_free(&nfsi->netfs);
 }
 extern void nfs_netfs_initiate_read(struct nfs_pgio_header *hdr);
 extern void nfs_netfs_read_completion(struct nfs_pgio_header *hdr);
@@ -160,7 +164,8 @@ static inline void nfs_netfs_reset_pageio_descriptor(struct nfs_pageio_descripto
 	desc->pg_netfs = NULL;
 }
 #else /* CONFIG_NFS_FSCACHE */
-static inline void nfs_netfs_inode_init(struct nfs_inode *nfsi) {}
+static inline int nfs_netfs_inode_init(struct nfs_inode *nfsi) { return 0; }
+static inline void nfs_netfs_inode_free(struct nfs_inode *nfsi) { }
 static inline void nfs_netfs_initiate_read(struct nfs_pgio_header *hdr) {}
 static inline void nfs_netfs_read_completion(struct nfs_pgio_header *hdr) {}
 static inline void nfs_netfs_readpage_release(struct nfs_page *req)
diff --git a/fs/nfs/inode.c b/fs/nfs/inode.c
index 116ae689a490..ba7a0f3167b6 100644
--- a/fs/nfs/inode.c
+++ b/fs/nfs/inode.c
@@ -2234,6 +2234,8 @@ static int nfs_update_inode(struct inode *inode, struct nfs_fattr *fattr)
 struct inode *nfs_alloc_inode(struct super_block *sb)
 {
 	struct nfs_inode *nfsi;
+	int ret;
+
 	nfsi = alloc_inode_sb(sb, nfs_inode_cachep, GFP_KERNEL);
 	if (!nfsi)
 		return NULL;
@@ -2245,7 +2247,11 @@ struct inode *nfs_alloc_inode(struct super_block *sb)
 #ifdef CONFIG_NFS_V4_2
 	nfsi->xattr_cache = NULL;
 #endif
-	nfs_netfs_inode_init(nfsi);
+	ret = nfs_netfs_inode_init(nfsi);
+	if (ret) {
+		kmem_cache_free(nfs_inode_cachep, nfsi);
+		return NULL;
+	}
 
 	return VFS_I(nfsi);
 }
@@ -2253,6 +2259,7 @@ EXPORT_SYMBOL_GPL(nfs_alloc_inode);
 
 void nfs_free_inode(struct inode *inode)
 {
+	nfs_netfs_inode_free(NFS_I(inode));
 	kmem_cache_free(nfs_inode_cachep, NFS_I(inode));
 }
 EXPORT_SYMBOL_GPL(nfs_free_inode);
diff --git a/include/linux/netfs.h b/include/linux/netfs.h
index f2402ddeafbf..4b4ddafab5e3 100644
--- a/include/linux/netfs.h
+++ b/include/linux/netfs.h
@@ -118,11 +118,7 @@ enum netfs_io_source {
 typedef void (*netfs_io_terminated_t)(void *priv, ssize_t transferred_or_error,
 				      bool was_async);
 
-/*
- * Per-inode context.  This wraps the VFS inode.
- */
-struct netfs_inode {
-	struct inode		inode;		/* The VFS inode */
+struct netfs_info {
 	const struct netfs_request_ops *ops;
 #if IS_ENABLED(CONFIG_FSCACHE)
 	struct fscache_cookie	*cache;
@@ -130,6 +126,14 @@ struct netfs_inode {
 	loff_t			remote_i_size;	/* Size of the remote file */
 };
 
+/*
+ * Per-inode context.  This wraps the VFS inode.
+ */
+struct netfs_inode {
+	struct inode		inode;		/* The VFS inode */
+	struct netfs_info	*info;		/* Rest of netfs data */
+};
+
 /*
  * Resources required to do operations on a cache.
  */
@@ -309,14 +313,29 @@ static inline struct netfs_inode *netfs_inode(struct inode *inode)
  * Initialise the netfs library context struct.  This is expected to follow on
  * directly from the VFS inode struct.
  */
-static inline void netfs_inode_init(struct netfs_inode *ctx,
+static inline int netfs_inode_init(struct netfs_inode *ctx,
 				    const struct netfs_request_ops *ops)
 {
-	ctx->ops = ops;
-	ctx->remote_i_size = i_size_read(&ctx->inode);
+	ctx->info = kzalloc(sizeof(struct netfs_info), GFP_KERNEL);
+	if (!ctx->info )
+		return -ENOMEM;
+	ctx->info->ops = ops;
+	ctx->info->remote_i_size = i_size_read(&ctx->inode);
 #if IS_ENABLED(CONFIG_FSCACHE)
-	ctx->cache = NULL;
+	ctx->info->cache = NULL;
 #endif
+	return 0;
+}
+
+/**
+ * netfs_inode_free - Free a netfslib inode context
+ * @ctx: The netfs inode to free
+ *
+ * Free the netfs library info struct.
+ */
+static inline void netfs_inode_free(struct netfs_inode *ctx)
+{
+	kfree(ctx->info);
 }
 
 /**
@@ -328,7 +347,7 @@ static inline void netfs_inode_init(struct netfs_inode *ctx,
  */
 static inline void netfs_resize_file(struct netfs_inode *ctx, loff_t new_i_size)
 {
-	ctx->remote_i_size = new_i_size;
+	ctx->info->remote_i_size = new_i_size;
 }
 
 /**
@@ -340,7 +359,7 @@ static inline void netfs_resize_file(struct netfs_inode *ctx, loff_t new_i_size)
 static inline struct fscache_cookie *netfs_i_cookie(struct netfs_inode *ctx)
 {
 #if IS_ENABLED(CONFIG_FSCACHE)
-	return ctx->cache;
+	return ctx->info->cache;
 #else
 	return NULL;
 #endif
-- 
2.31.1


Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 874EE5A89F9
	for <lists+linux-nfs@lfdr.de>; Thu,  1 Sep 2022 02:49:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230436AbiIAAtE (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 31 Aug 2022 20:49:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231700AbiIAAtD (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 31 Aug 2022 20:49:03 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19FD6FE837
        for <linux-nfs@vger.kernel.org>; Wed, 31 Aug 2022 17:49:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1661993340;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=BkQun7K9r6dzPnZyZvfG5k4TITClpjqtB3tEDuwVlAk=;
        b=bP07Cn/h+OgrQQapCajuXC+XQK6vU5z/LUvjNRTICcmwx67dv/8S0+FvbTYlP9NO3ev3k7
        0sIyrOXZjeppxAdq1cm12RUgLIK9UfsxzYAzej/i4nTy6TmEgndFjnjqJ4ZSKH2y9iM3AP
        8+YDwLs3JcPvh3Kl4ZdVCmAGHrJdOlo=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-317-1038Gzp0P6S8wuvZYXUmbQ-1; Wed, 31 Aug 2022 20:48:56 -0400
X-MC-Unique: 1038Gzp0P6S8wuvZYXUmbQ-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 4FD9C811E76;
        Thu,  1 Sep 2022 00:48:56 +0000 (UTC)
Received: from dwysocha.rdu.csb (unknown [10.22.8.98])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id CB2D2492C3B;
        Thu,  1 Sep 2022 00:48:54 +0000 (UTC)
From:   Dave Wysochanski <dwysocha@redhat.com>
To:     Anna Schumaker <anna.schumaker@netapp.com>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        David Howells <dhowells@redhat.com>
Cc:     linux-nfs@vger.kernel.org, linux-cachefs@redhat.com,
        Benjamin Maynard <benmaynard@google.com>,
        Daire Byrne <daire.byrne@gmail.com>
Subject: [PATCH v4 3/3] NFS: Convert buffered read paths to use netfs when fscache is enabled
Date:   Wed, 31 Aug 2022 20:48:50 -0400
Message-Id: <20220901004850.1431412-4-dwysocha@redhat.com>
In-Reply-To: <20220901004850.1431412-1-dwysocha@redhat.com>
References: <20220901004850.1431412-1-dwysocha@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.10
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Convert the NFS buffered read code paths to corresponding netfs APIs,
but only when fscache is configured and enabled.

The netfs API defines struct netfs_request_ops which must be filled
in by the network filesystem.  For NFS, we only need to define 5 of
the functions, the main one being the issue_read() function.
The issue_read() function is called by the netfs layer when a read
cannot be fulfilled locally, and must be sent to the server (either
the cache is not active, or it is active but the data is not available).
Once the read from the server is complete, netfs requires a call to
netfs_subreq_terminated() which conveys either how many bytes were read
successfully, or an error.  Note that issue_read() is called with a
structure, netfs_io_subrequest, which defines the IO requested, and
contains a start and a length (both in bytes), and assumes the underlying
netfs will return a either an error on the whole region, or the number
of bytes successfully read.

The NFS IO path is page based and the main APIs are the pgio APIs defined
in pagelist.c.  For the pgio APIs, there is no way for the caller to
know how many RPCs will be sent and how the pages will be broken up
into underlying RPCs, each of which will have their own return code.
Thus, NFS needs some way to accommodate the netfs API requirement on
the single response to the whole request, while also minimizing
disruptive changes to the NFS pgio layer.  The approach taken with this
patch is to allocate a small structure for each call to nfs_issue_read()
to keep some accounting information for the outstanding RPCs, as well as
the final error value or the number of bytes successfully read.  The
accounting data is updated inside nfs_netfs_read_initiate(), and
nfs_netfs_read_done(), when a nfs_pgio_header contains a valid pointer
to the data.  Then finally in nfs_read_completion(), call into
nfs_netfs_read_completion() to update the final error value and bytes
read, and check the accounting data to determine whether this is the
final RPC completion.  If this is the last RPC, then call into
netfs_subreq_terminated() with the final error value or the number
of bytes transferred.

Link: https://lore.kernel.org/linux-nfs/9cfd5bc3cfc6abc2d3316b0387222e708d67f595.camel@hammerspace.com/

Signed-off-by: Dave Wysochanski <dwysocha@redhat.com>
---
 fs/nfs/fscache.c         | 219 +++++++++++++++++++++++----------------
 fs/nfs/fscache.h         |  71 +++++++------
 fs/nfs/inode.c           |   3 +
 fs/nfs/internal.h        |   9 ++
 fs/nfs/pagelist.c        |  14 +++
 fs/nfs/read.c            |  68 ++++++++----
 include/linux/nfs_page.h |   3 +
 include/linux/nfs_xdr.h  |   3 +
 8 files changed, 245 insertions(+), 145 deletions(-)

diff --git a/fs/nfs/fscache.c b/fs/nfs/fscache.c
index a6fc1c8b6644..85f8251a608a 100644
--- a/fs/nfs/fscache.c
+++ b/fs/nfs/fscache.c
@@ -15,6 +15,9 @@
 #include <linux/seq_file.h>
 #include <linux/slab.h>
 #include <linux/iversion.h>
+#include <linux/xarray.h>
+#include <linux/fscache.h>
+#include <linux/netfs.h>
 
 #include "internal.h"
 #include "iostat.h"
@@ -235,112 +238,148 @@ void nfs_fscache_release_file(struct inode *inode, struct file *filp)
 	fscache_unuse_cookie(cookie, &auxdata, &i_size);
 }
 
-/*
- * Fallback page reading interface.
- */
-static int fscache_fallback_read_page(struct inode *inode, struct page *page)
+
+atomic_t nfs_netfs_debug_id;
+static int nfs_netfs_init_request(struct netfs_io_request *rreq, struct file *file)
 {
-	struct netfs_cache_resources cres;
-	struct fscache_cookie *cookie = netfs_i_cookie(&NFS_I(inode)->netfs);
-	struct iov_iter iter;
-	struct bio_vec bvec[1];
-	int ret;
-
-	memset(&cres, 0, sizeof(cres));
-	bvec[0].bv_page		= page;
-	bvec[0].bv_offset	= 0;
-	bvec[0].bv_len		= PAGE_SIZE;
-	iov_iter_bvec(&iter, READ, bvec, ARRAY_SIZE(bvec), PAGE_SIZE);
-
-	ret = fscache_begin_read_operation(&cres, cookie);
-	if (ret < 0)
-		return ret;
-
-	ret = fscache_read(&cres, page_offset(page), &iter, NETFS_READ_HOLE_FAIL,
-			   NULL, NULL);
-	fscache_end_operation(&cres);
-	return ret;
+	rreq->netfs_priv = get_nfs_open_context(nfs_file_open_context(file));
+
+	if (netfs_i_cookie(&NFS_I(rreq->inode)->netfs))
+		rreq->debug_id = atomic_inc_return(&nfs_netfs_debug_id);
+
+	return 0;
 }
 
-/*
- * Fallback page writing interface.
- */
-static int fscache_fallback_write_page(struct inode *inode, struct page *page,
-				       bool no_space_allocated_yet)
+static void nfs_netfs_free_request(struct netfs_io_request *rreq)
 {
-	struct netfs_cache_resources cres;
-	struct fscache_cookie *cookie = netfs_i_cookie(&NFS_I(inode)->netfs);
-	struct iov_iter iter;
-	struct bio_vec bvec[1];
-	loff_t start = page_offset(page);
-	size_t len = PAGE_SIZE;
-	int ret;
-
-	memset(&cres, 0, sizeof(cres));
-	bvec[0].bv_page		= page;
-	bvec[0].bv_offset	= 0;
-	bvec[0].bv_len		= PAGE_SIZE;
-	iov_iter_bvec(&iter, WRITE, bvec, ARRAY_SIZE(bvec), PAGE_SIZE);
-
-	ret = fscache_begin_write_operation(&cres, cookie);
-	if (ret < 0)
-		return ret;
-
-	ret = cres.ops->prepare_write(&cres, &start, &len, i_size_read(inode),
-				      no_space_allocated_yet);
-	if (ret == 0)
-		ret = fscache_write(&cres, page_offset(page), &iter, NULL, NULL);
-	fscache_end_operation(&cres);
-	return ret;
+	put_nfs_open_context(rreq->netfs_priv);
 }
 
-/*
- * Retrieve a page from fscache
- */
-int __nfs_fscache_read_page(struct inode *inode, struct page *page)
+static inline int nfs_netfs_begin_cache_operation(struct netfs_io_request *rreq)
 {
-	int ret;
+	return fscache_begin_read_operation(&rreq->cache_resources,
+					    netfs_i_cookie(&NFS_I(rreq->inode)->netfs));
+}
 
-	trace_nfs_fscache_read_page(inode, page);
-	if (PageChecked(page)) {
-		ClearPageChecked(page);
-		ret = 1;
-		goto out;
-	}
+static struct nfs_netfs_io_data *nfs_netfs_alloc(struct netfs_io_subrequest *sreq)
+{
+	struct nfs_netfs_io_data *netfs;
+
+	netfs = kzalloc(sizeof(*netfs), GFP_KERNEL_ACCOUNT);
+	if (!netfs)
+		return NULL;
+	netfs->sreq = sreq;
+	refcount_set(&netfs->refcount, 1);
+	spin_lock_init(&netfs->lock);
+	return netfs;
+}
 
-	ret = fscache_fallback_read_page(inode, page);
-	if (ret < 0) {
-		nfs_inc_fscache_stats(inode, NFSIOS_FSCACHE_PAGES_READ_FAIL);
-		SetPageChecked(page);
-		goto out;
+static bool nfs_netfs_clamp_length(struct netfs_io_subrequest *sreq)
+{
+	size_t	rsize = NFS_SB(sreq->rreq->inode->i_sb)->rsize;
+
+	sreq->len = min(sreq->len, rsize);
+	return true;
+}
+
+static void nfs_netfs_issue_read(struct netfs_io_subrequest *sreq)
+{
+	struct nfs_pageio_descriptor pgio;
+	struct inode *inode = sreq->rreq->inode;
+	struct nfs_open_context *ctx = sreq->rreq->netfs_priv;
+	struct page *page;
+	int err;
+	pgoff_t start = (sreq->start + sreq->transferred) >> PAGE_SHIFT;
+	pgoff_t last = ((sreq->start + sreq->len -
+			 sreq->transferred - 1) >> PAGE_SHIFT);
+	XA_STATE(xas, &sreq->rreq->mapping->i_pages, start);
+
+	nfs_pageio_init_read(&pgio, inode, false,
+			     &nfs_async_read_completion_ops);
+
+	pgio.pg_netfs = nfs_netfs_alloc(sreq); /* used in completion */
+	if (!pgio.pg_netfs)
+		return netfs_subreq_terminated(sreq, -ENOMEM, false);
+
+	xas_lock(&xas);
+	xas_for_each(&xas, page, last) {
+		/* nfs_pageio_add_page() may schedule() due to pNFS layout and other RPCs  */
+		xas_pause(&xas);
+		xas_unlock(&xas);
+		err = nfs_pageio_add_page(&pgio, ctx, page);
+		if (err < 0)
+			return netfs_subreq_terminated(sreq, err, false);
+		xas_lock(&xas);
 	}
+	xas_unlock(&xas);
+	nfs_pageio_complete_read(&pgio);
+	nfs_netfs_put(pgio.pg_netfs);
+}
 
-	/* Read completed synchronously */
-	nfs_inc_fscache_stats(inode, NFSIOS_FSCACHE_PAGES_READ_OK);
-	SetPageUptodate(page);
-	ret = 0;
-out:
-	trace_nfs_fscache_read_page_exit(inode, page, ret);
-	return ret;
+void nfs_netfs_read_initiate(struct nfs_pgio_header *hdr)
+{
+	struct nfs_netfs_io_data        *netfs = hdr->netfs;
+
+	if (!netfs)
+		return;
+
+	spin_lock(&netfs->lock);
+	atomic_inc(&netfs->rpcs);
+	netfs->rpc_byte_count += hdr->args.count;
+	spin_unlock(&netfs->lock);
 }
 
-/*
- * Store a newly fetched page in fscache.  We can be certain there's no page
- * stored in the cache as yet otherwise we would've read it from there.
- */
-void __nfs_fscache_write_page(struct inode *inode, struct page *page)
+void nfs_netfs_read_done(struct nfs_pgio_header *hdr)
 {
-	int ret;
+	struct nfs_netfs_io_data        *netfs = hdr->netfs;
 
-	trace_nfs_fscache_write_page(inode, page);
+	if (!netfs)
+		return;
+
+	spin_lock(&netfs->lock);
+	if (hdr->res.op_status) {
+		/*
+		 * Retryable errors such as BAD_STATEID will be re-issued,
+		 * so reduce the bytes and the RPC counts.
+		 */
+		netfs->rpc_byte_count -= hdr->args.count;
+		atomic_dec(&netfs->rpcs);
+	}
+	spin_unlock(&netfs->lock);
+}
+
+void nfs_netfs_read_completion(struct nfs_pgio_header *hdr)
+{
+	struct nfs_netfs_io_data        *netfs = hdr->netfs;
+	struct netfs_io_subrequest      *sreq;
+
+	if (!netfs)
+		return;
 
-	ret = fscache_fallback_write_page(inode, page, true);
+	sreq = netfs->sreq;
+	if (test_bit(NFS_IOHDR_EOF, &hdr->flags))
+		__set_bit(NETFS_SREQ_CLEAR_TAIL, &sreq->flags);
 
-	if (ret != 0) {
-		nfs_inc_fscache_stats(inode, NFSIOS_FSCACHE_PAGES_WRITTEN_FAIL);
-		nfs_inc_fscache_stats(inode, NFSIOS_FSCACHE_PAGES_UNCACHED);
-	} else {
-		nfs_inc_fscache_stats(inode, NFSIOS_FSCACHE_PAGES_WRITTEN_OK);
+	spin_lock(&netfs->lock);
+	if (hdr->error)
+		netfs->error = hdr->error;
+	else
+		netfs->transferred += hdr->res.count;
+	spin_unlock(&netfs->lock);
+
+	/* Only the last RPC completion should call netfs_subreq_terminated() */
+	if (atomic_dec_and_test(&netfs->rpcs) &&
+	    (netfs->rpc_byte_count >= sreq->len)) {
+		netfs_subreq_terminated(sreq, netfs->error ?: netfs->transferred, false);
+		nfs_netfs_put(netfs);
+		hdr->netfs = NULL;
 	}
-	trace_nfs_fscache_write_page_exit(inode, page, ret);
 }
+
+const struct netfs_request_ops nfs_netfs_ops = {
+	.init_request		= nfs_netfs_init_request,
+	.free_request		= nfs_netfs_free_request,
+	.begin_cache_operation	= nfs_netfs_begin_cache_operation,
+	.issue_read		= nfs_netfs_issue_read,
+	.clamp_length		= nfs_netfs_clamp_length
+};
diff --git a/fs/nfs/fscache.h b/fs/nfs/fscache.h
index 38614ed8f951..c59a82a7d4a8 100644
--- a/fs/nfs/fscache.h
+++ b/fs/nfs/fscache.h
@@ -34,6 +34,44 @@ struct nfs_fscache_inode_auxdata {
 	u64	change_attr;
 };
 
+struct nfs_netfs_io_data {
+	refcount_t			refcount;
+	struct netfs_io_subrequest	*sreq;
+
+	/*
+	 * NFS may split a netfs_io_subrequest into multiple RPCs, each
+	 * with their own read completion.  In netfs, we can only call
+	 * netfs_subreq_terminated() once for each subrequest.  So we
+	 * must keep track of the rpcs and rpc_byte_count for what has
+	 * been submitted, and only call netfs via netfs_subreq_terminated()
+	 * when the final RPC has completed.
+	 */
+	atomic_t	rpcs;
+	unsigned long	rpc_byte_count;
+
+	/*
+	 * Final dispostion of the netfs_io_subrequest, sent in
+	 * netfs_subreq_terminated()
+	 */
+	spinlock_t	lock;
+	ssize_t		transferred;
+	int		error;
+};
+
+static inline void nfs_netfs_get(struct nfs_netfs_io_data *netfs)
+{
+	refcount_inc(&netfs->refcount);
+}
+
+static inline void nfs_netfs_put(struct nfs_netfs_io_data *netfs)
+{
+	if (refcount_dec_and_test(&netfs->refcount))
+		kfree(netfs);
+}
+extern void nfs_netfs_read_initiate(struct nfs_pgio_header *hdr);
+extern void nfs_netfs_read_done(struct nfs_pgio_header *hdr);
+extern void nfs_netfs_read_completion(struct nfs_pgio_header *hdr);
+
 /*
  * fscache.c
  */
@@ -45,43 +83,17 @@ extern void nfs_fscache_clear_inode(struct inode *);
 extern void nfs_fscache_open_file(struct inode *, struct file *);
 extern void nfs_fscache_release_file(struct inode *, struct file *);
 
-extern int __nfs_fscache_read_page(struct inode *, struct page *);
-extern void __nfs_fscache_write_page(struct inode *, struct page *);
-
 static inline bool nfs_fscache_release_folio(struct folio *folio, gfp_t gfp)
 {
 	if (folio_test_fscache(folio)) {
 		if (current_is_kswapd() || !(gfp & __GFP_FS))
 			return false;
 		folio_wait_fscache(folio);
-		fscache_note_page_release(netfs_i_cookie(&NFS_I(folio->mapping->host)->netfs));
-		nfs_inc_fscache_stats(folio->mapping->host,
-				      NFSIOS_FSCACHE_PAGES_UNCACHED);
 	}
+	fscache_note_page_release(netfs_i_cookie(&NFS_I(folio->mapping->host)->netfs));
 	return true;
 }
 
-/*
- * Retrieve a page from an inode data storage object.
- */
-static inline int nfs_fscache_read_page(struct inode *inode, struct page *page)
-{
-	if (netfs_inode(inode)->cache)
-		return __nfs_fscache_read_page(inode, page);
-	return -ENOBUFS;
-}
-
-/*
- * Store a page newly fetched from the server in an inode data storage object
- * in the cache.
- */
-static inline void nfs_fscache_write_page(struct inode *inode,
-					   struct page *page)
-{
-	if (netfs_inode(inode)->cache)
-		__nfs_fscache_write_page(inode, page);
-}
-
 static inline void nfs_fscache_update_auxdata(struct nfs_fscache_inode_auxdata *auxdata,
 					      struct inode *inode)
 {
@@ -130,11 +142,6 @@ static inline bool nfs_fscache_release_folio(struct folio *folio, gfp_t gfp)
 {
 	return true; /* may release folio */
 }
-static inline int nfs_fscache_read_page(struct inode *inode, struct page *page)
-{
-	return -ENOBUFS;
-}
-static inline void nfs_fscache_write_page(struct inode *inode, struct page *page) {}
 static inline void nfs_fscache_invalidate(struct inode *inode, int flags) {}
 
 static inline const char *nfs_server_fscache_state(struct nfs_server *server)
diff --git a/fs/nfs/inode.c b/fs/nfs/inode.c
index aa2aec785ab5..a0af3518d8db 100644
--- a/fs/nfs/inode.c
+++ b/fs/nfs/inode.c
@@ -2248,6 +2248,9 @@ struct inode *nfs_alloc_inode(struct super_block *sb)
 #endif /* CONFIG_NFS_V4 */
 #ifdef CONFIG_NFS_V4_2
 	nfsi->xattr_cache = NULL;
+#endif
+#ifdef CONFIG_NFS_FSCACHE
+	netfs_inode_init(&nfsi->netfs, &nfs_netfs_ops);
 #endif
 	return VFS_I(nfsi);
 }
diff --git a/fs/nfs/internal.h b/fs/nfs/internal.h
index 273687082992..e5589036c1f8 100644
--- a/fs/nfs/internal.h
+++ b/fs/nfs/internal.h
@@ -453,6 +453,10 @@ extern void nfs_sb_deactive(struct super_block *sb);
 extern int nfs_client_for_each_server(struct nfs_client *clp,
 				      int (*fn)(struct nfs_server *, void *),
 				      void *data);
+#ifdef CONFIG_NFS_FSCACHE
+extern const struct netfs_request_ops nfs_netfs_ops;
+#endif
+
 /* io.c */
 extern void nfs_start_io_read(struct inode *inode);
 extern void nfs_end_io_read(struct inode *inode);
@@ -482,9 +486,14 @@ extern int nfs4_get_rootfh(struct nfs_server *server, struct nfs_fh *mntfh, bool
 
 struct nfs_pgio_completion_ops;
 /* read.c */
+extern const struct nfs_pgio_completion_ops nfs_async_read_completion_ops;
 extern void nfs_pageio_init_read(struct nfs_pageio_descriptor *pgio,
 			struct inode *inode, bool force_mds,
 			const struct nfs_pgio_completion_ops *compl_ops);
+extern int nfs_pageio_add_page(struct nfs_pageio_descriptor *pgio,
+			       struct nfs_open_context *ctx,
+			       struct page *page);
+extern void nfs_pageio_complete_read(struct nfs_pageio_descriptor *pgio);
 extern void nfs_read_prepare(struct rpc_task *task, void *calldata);
 extern void nfs_pageio_reset_read_mds(struct nfs_pageio_descriptor *pgio);
 
diff --git a/fs/nfs/pagelist.c b/fs/nfs/pagelist.c
index 317cedfa52bf..600989332a6f 100644
--- a/fs/nfs/pagelist.c
+++ b/fs/nfs/pagelist.c
@@ -25,6 +25,7 @@
 #include "internal.h"
 #include "pnfs.h"
 #include "nfstrace.h"
+#include "fscache.h"
 
 #define NFSDBG_FACILITY		NFSDBG_PAGECACHE
 
@@ -68,6 +69,12 @@ void nfs_pgheader_init(struct nfs_pageio_descriptor *desc,
 	hdr->good_bytes = mirror->pg_count;
 	hdr->io_completion = desc->pg_io_completion;
 	hdr->dreq = desc->pg_dreq;
+#ifdef CONFIG_NFS_FSCACHE
+	if (desc->pg_netfs) {
+		hdr->netfs = desc->pg_netfs;
+		nfs_netfs_get(desc->pg_netfs);
+	}
+#endif
 	hdr->release = release;
 	hdr->completion_ops = desc->pg_completion_ops;
 	if (hdr->completion_ops->init_hdr)
@@ -846,6 +853,9 @@ void nfs_pageio_init(struct nfs_pageio_descriptor *desc,
 	desc->pg_lseg = NULL;
 	desc->pg_io_completion = NULL;
 	desc->pg_dreq = NULL;
+#ifdef CONFIG_NFS_FSCACHE
+	desc->pg_netfs = NULL;
+#endif
 	desc->pg_bsize = bsize;
 
 	desc->pg_mirror_count = 1;
@@ -940,6 +950,7 @@ int nfs_generic_pgio(struct nfs_pageio_descriptor *desc,
 	/* Set up the argument struct */
 	nfs_pgio_rpcsetup(hdr, mirror->pg_count, desc->pg_ioflags, &cinfo);
 	desc->pg_rpc_callops = &nfs_pgio_common_ops;
+
 	return 0;
 }
 EXPORT_SYMBOL_GPL(nfs_generic_pgio);
@@ -1360,6 +1371,9 @@ int nfs_pageio_resend(struct nfs_pageio_descriptor *desc,
 
 	desc->pg_io_completion = hdr->io_completion;
 	desc->pg_dreq = hdr->dreq;
+#ifdef CONFIG_NFS_FSCACHE
+	desc->pg_netfs = hdr->netfs;
+#endif
 	list_splice_init(&hdr->pages, &pages);
 	while (!list_empty(&pages)) {
 		struct nfs_page *req = nfs_list_entry(pages.next);
diff --git a/fs/nfs/read.c b/fs/nfs/read.c
index 525e82ea9a9e..3bc48472f207 100644
--- a/fs/nfs/read.c
+++ b/fs/nfs/read.c
@@ -30,7 +30,7 @@
 
 #define NFSDBG_FACILITY		NFSDBG_PAGECACHE
 
-static const struct nfs_pgio_completion_ops nfs_async_read_completion_ops;
+const struct nfs_pgio_completion_ops nfs_async_read_completion_ops;
 static const struct nfs_rw_ops nfs_rw_read_ops;
 
 static struct kmem_cache *nfs_rdata_cachep;
@@ -74,7 +74,7 @@ void nfs_pageio_init_read(struct nfs_pageio_descriptor *pgio,
 }
 EXPORT_SYMBOL_GPL(nfs_pageio_init_read);
 
-static void nfs_pageio_complete_read(struct nfs_pageio_descriptor *pgio)
+void nfs_pageio_complete_read(struct nfs_pageio_descriptor *pgio)
 {
 	struct nfs_pgio_mirror *pgm;
 	unsigned long npages;
@@ -110,20 +110,25 @@ EXPORT_SYMBOL_GPL(nfs_pageio_reset_read_mds);
 
 static void nfs_readpage_release(struct nfs_page *req, int error)
 {
-	struct inode *inode = d_inode(nfs_req_openctx(req)->dentry);
 	struct page *page = req->wb_page;
 
-	dprintk("NFS: read done (%s/%llu %d@%lld)\n", inode->i_sb->s_id,
-		(unsigned long long)NFS_FILEID(inode), req->wb_bytes,
-		(long long)req_offset(req));
-
 	if (nfs_error_is_fatal_on_server(error) && error != -ETIMEDOUT)
 		SetPageError(page);
 	if (nfs_page_group_sync_on_bit(req, PG_UNLOCKPAGE)) {
-		if (PageUptodate(page))
-			nfs_fscache_write_page(inode, page);
+#ifdef CONFIG_NFS_FSCACHE
+		struct inode *inode = d_inode(nfs_req_openctx(req)->dentry);
+
+		/*
+		 * If fscache is enabled, netfs will unlock pages.
+		 * Otherwise, we have to unlock the page here
+		 */
+		if (!netfs_inode(inode)->cache)
+			unlock_page(page);
+#else
 		unlock_page(page);
+#endif
 	}
+
 	nfs_release_request(req);
 }
 
@@ -177,6 +182,10 @@ static void nfs_read_completion(struct nfs_pgio_header *hdr)
 		nfs_list_remove_request(req);
 		nfs_readpage_release(req, error);
 	}
+#ifdef CONFIG_NFS_FSCACHE
+	nfs_netfs_read_completion(hdr);
+#endif
+
 out:
 	hdr->release(hdr);
 }
@@ -187,6 +196,9 @@ static void nfs_initiate_read(struct nfs_pgio_header *hdr,
 			      struct rpc_task_setup *task_setup_data, int how)
 {
 	rpc_ops->read_setup(hdr, msg);
+#ifdef CONFIG_NFS_FSCACHE
+	nfs_netfs_read_initiate(hdr);
+#endif
 	trace_nfs_initiate_read(hdr);
 }
 
@@ -202,7 +214,7 @@ nfs_async_read_error(struct list_head *head, int error)
 	}
 }
 
-static const struct nfs_pgio_completion_ops nfs_async_read_completion_ops = {
+const struct nfs_pgio_completion_ops nfs_async_read_completion_ops = {
 	.error_cleanup = nfs_async_read_error,
 	.completion = nfs_read_completion,
 };
@@ -219,6 +231,9 @@ static int nfs_readpage_done(struct rpc_task *task,
 	if (status != 0)
 		return status;
 
+#ifdef CONFIG_NFS_FSCACHE
+	nfs_netfs_read_done(hdr);
+#endif
 	nfs_add_stats(inode, NFSIOS_SERVERREADBYTES, hdr->res.count);
 	trace_nfs_readpage_done(task, hdr);
 
@@ -294,12 +309,6 @@ nfs_pageio_add_page(struct nfs_pageio_descriptor *pgio,
 
 	aligned_len = min_t(unsigned int, ALIGN(len, rsize), PAGE_SIZE);
 
-	if (!IS_SYNC(page->mapping->host)) {
-		error = nfs_fscache_read_page(page->mapping->host, page);
-		if (error == 0)
-			goto out_unlock;
-	}
-
 	new = nfs_create_request(ctx, page, 0, aligned_len);
 	if (IS_ERR(new))
 		goto out_error;
@@ -315,8 +324,6 @@ nfs_pageio_add_page(struct nfs_pageio_descriptor *pgio,
 	return 0;
 out_error:
 	error = PTR_ERR(new);
-out_unlock:
-	unlock_page(page);
 out:
 	return error;
 }
@@ -355,6 +362,12 @@ int nfs_read_folio(struct file *file, struct folio *folio)
 	if (NFS_STALE(inode))
 		goto out_unlock;
 
+#ifdef CONFIG_NFS_FSCACHE
+	if (netfs_inode(inode)->cache) {
+		ret = netfs_read_folio(file, folio);
+		goto out;
+	}
+#endif
 	if (file == NULL) {
 		ret = -EBADF;
 		ctx = nfs_find_open_context(inode, NULL, FMODE_READ);
@@ -368,8 +381,10 @@ int nfs_read_folio(struct file *file, struct folio *folio)
 			     &nfs_async_read_completion_ops);
 
 	ret = nfs_pageio_add_page(&pgio, ctx, page);
-	if (ret)
-		goto out;
+	if (ret) {
+		put_nfs_open_context(ctx);
+		goto out_unlock;
+	}
 
 	nfs_pageio_complete_read(&pgio);
 	ret = pgio.pg_error < 0 ? pgio.pg_error : 0;
@@ -378,12 +393,12 @@ int nfs_read_folio(struct file *file, struct folio *folio)
 		if (!PageUptodate(page) && !ret)
 			ret = xchg(&ctx->error, 0);
 	}
-out:
 	put_nfs_open_context(ctx);
-	trace_nfs_aop_readpage_done(inode, page, ret);
-	return ret;
+	goto out;
+
 out_unlock:
 	unlock_page(page);
+out:
 	trace_nfs_aop_readpage_done(inode, page, ret);
 	return ret;
 }
@@ -405,6 +420,13 @@ void nfs_readahead(struct readahead_control *ractl)
 	if (NFS_STALE(inode))
 		goto out;
 
+#ifdef CONFIG_NFS_FSCACHE
+	if (netfs_inode(inode)->cache) {
+		netfs_readahead(ractl);
+		ret = 0;
+		goto out;
+	}
+#endif
 	if (file == NULL) {
 		ret = -EBADF;
 		ctx = nfs_find_open_context(inode, NULL, FMODE_READ);
diff --git a/include/linux/nfs_page.h b/include/linux/nfs_page.h
index ba7e2e4b0926..8eeb16d9bacd 100644
--- a/include/linux/nfs_page.h
+++ b/include/linux/nfs_page.h
@@ -101,6 +101,9 @@ struct nfs_pageio_descriptor {
 	struct pnfs_layout_segment *pg_lseg;
 	struct nfs_io_completion *pg_io_completion;
 	struct nfs_direct_req	*pg_dreq;
+#ifdef CONFIG_NFS_FSCACHE
+	void			*pg_netfs;
+#endif
 	unsigned int		pg_bsize;	/* default bsize for mirrors */
 
 	u32			pg_mirror_count;
diff --git a/include/linux/nfs_xdr.h b/include/linux/nfs_xdr.h
index e86cf6642d21..e196ef595908 100644
--- a/include/linux/nfs_xdr.h
+++ b/include/linux/nfs_xdr.h
@@ -1619,6 +1619,9 @@ struct nfs_pgio_header {
 	const struct nfs_rw_ops	*rw_ops;
 	struct nfs_io_completion *io_completion;
 	struct nfs_direct_req	*dreq;
+#ifdef CONFIG_NFS_FSCACHE
+	void			*netfs;
+#endif
 
 	int			pnfs_error;
 	int			error;		/* merge with pnfs_error */
-- 
2.31.1


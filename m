Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7298B305545
	for <lists+linux-nfs@lfdr.de>; Wed, 27 Jan 2021 09:09:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232134AbhA0IIH (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 27 Jan 2021 03:08:07 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:52343 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234627AbhA0IFE (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 27 Jan 2021 03:05:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1611734615;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:in-reply-to:in-reply-to:references:references;
        bh=twVXUEhHd2JO+Bi7/xAnfSJFvhLX7mWhR/JSfp3lgYE=;
        b=RVdrcrgeUghcEsyCiQaMQna2aCIYKBC5ClSeenDQSnp7PSn+CX4PAKQXTWH/rbIFYQNMvd
        iUCajtXRLPSdYXctQ49iCmr6VuOfFqrx8WMFTCBci1WLmfEW2UXeAGnNIh/0Isd/nF9sUz
        aXZoTMJ48iudbXdM/hRnEJEdE0D2D0k=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-135-6yEP5xGbPu23VniJn6-xWw-1; Wed, 27 Jan 2021 03:03:33 -0500
X-MC-Unique: 6yEP5xGbPu23VniJn6-xWw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 85F6C180A099;
        Wed, 27 Jan 2021 08:03:32 +0000 (UTC)
Received: from dwysocha.rdu.csb (ovpn-112-111.rdu2.redhat.com [10.10.112.111])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 11A3B72163;
        Wed, 27 Jan 2021 08:03:31 +0000 (UTC)
From:   Dave Wysochanski <dwysocha@redhat.com>
To:     Trond Myklebust <trondmy@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH 7/8] NFS: Convert to the netfs API and nfs_readpage to use netfs_readpage
Date:   Wed, 27 Jan 2021 03:03:16 -0500
Message-Id: <1611734597-14754-8-git-send-email-dwysocha@redhat.com>
In-Reply-To: <1611734597-14754-2-git-send-email-dwysocha@redhat.com>
References: <1611734597-14754-2-git-send-email-dwysocha@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

This patch converts the main NFS read paths to the new netfs API,
when fscache is enabled, and converts readpage while minimizing
changes to the existing NFS read code paths.

The netfs API requires a few functions to be provided by the
netfs:
- init_rreq: allows netfs to allocate resources prior to IO
- is_cache_enabled: allows netfs to disable fscache
- begin_cache_operation: signals the start of an fscache IO
- issue_op: called when netfs should issue read to server
- clamp_length: allows netfs to limit size of IO
- cleanup: allows netfs to cleanup after an IO is complete

The new netfs_readpage() API is called when fscache is enabled.
If a read cannot be satisfied from fscache, the netfs is called
back via issue_op() to obtain the data from the server.  Once
the read completes, the netfs must call netfs_subreq_terminated()
which then may write the data to fscache.  In order to call back
into fscache via netfs_subreq_terminated(), we must save the
netfs_read_subrequest* as a field in the nfs_pgio_header, similar
to nfs_direct_req.

If the netfs has a read IO limit (for example, NFS 'rsize' mount
options) the clamp_length() function is called.

Signed-off-by: Dave Wysochanski <dwysocha@redhat.com>
---
 fs/nfs/fscache.c         | 158 ++++++++++++++++++++++++++++++++---------------
 fs/nfs/fscache.h         |  44 +++----------
 fs/nfs/pagelist.c        |   2 +
 fs/nfs/read.c            |   9 ++-
 include/linux/nfs_page.h |   1 +
 include/linux/nfs_xdr.h  |   1 +
 6 files changed, 127 insertions(+), 88 deletions(-)

diff --git a/fs/nfs/fscache.c b/fs/nfs/fscache.c
index c4c021c6ebbd..fede075209f5 100644
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
@@ -373,62 +376,126 @@ void __nfs_fscache_invalidate_page(struct page *page, struct inode *inode)
 			      NFSIOS_FSCACHE_PAGES_UNCACHED);
 }
 
-/*
- * Handle completion of a page being read from the cache.
- * - Called in process (keventd) context.
- */
-static void nfs_readpage_from_fscache_complete(struct page *page,
-					       void *context,
-					       int error)
+static void nfs_issue_op(struct netfs_read_subrequest *subreq)
 {
-	dfprintk(FSCACHE,
-		 "NFS: readpage_from_fscache_complete (0x%p/0x%p/%d)\n",
-		 page, context, error);
-
-	/* if the read completes with an error, we just unlock the page and let
-	 * the VM reissue the readpage */
-	if (!error) {
-		SetPageUptodate(page);
-		unlock_page(page);
+	struct inode *inode = subreq->rreq->inode;
+	struct nfs_readdesc *desc = subreq->rreq->netfs_priv;
+	struct page *page;
+	pgoff_t start = (subreq->start + subreq->transferred) >> PAGE_SHIFT;
+	pgoff_t last = ((subreq->start + subreq->len -
+			 subreq->transferred - 1) >> PAGE_SHIFT);
+	XA_STATE(xas, &subreq->rreq->mapping->i_pages, start);
+
+	dfprintk(FSCACHE, "NFS: %s(fsc:%p s:%lu l:%lu) subreq->start: %lld "
+		 "subreq->len: %ld subreq->transferred: %ld\n",
+		 __func__, nfs_i_fscache(inode), start, last, subreq->start,
+		 subreq->len, subreq->transferred);
+
+	nfs_add_fscache_stats(inode, NFSIOS_FSCACHE_PAGES_READ_FAIL,
+			      last - start + 1);
+	nfs_pageio_init_read(&desc->pgio, inode, false,
+			     &nfs_async_read_completion_ops);
+
+	desc->pgio.pg_fsc = subreq; /* used in completion */
+
+	rcu_read_lock();
+	xas_for_each(&xas, page, last) {
+		subreq->error = readpage_async_filler(desc, page);
+		if (subreq->error < 0)
+			break;
+	}
+	rcu_read_unlock();
+	nfs_pageio_complete_read(&desc->pgio, inode);
+}
+
+static bool nfs_clamp_length(struct netfs_read_subrequest *subreq)
+{
+	struct inode *inode = subreq->rreq->mapping->host;
+	unsigned int rsize = NFS_SB(inode->i_sb)->rsize;
+
+	if (subreq->len > rsize) {
+		dfprintk(FSCACHE,
+			 "NFS: %s(fsc:%p slen:%lu rsize: %u)\n",
+			 __func__, nfs_i_fscache(inode), subreq->len, rsize);
+		subreq->len = rsize;
 	}
+
+	return true;
+}
+
+static void nfs_cleanup(struct address_space *mapping, void *netfs_priv)
+{
+	; /* fscache assumes if netfs_priv is given we have cleanup */
+}
+
+atomic_t nfs_fscache_debug_id;
+static void nfs_init_rreq(struct netfs_read_request *rreq, struct file *file)
+{
+	struct nfs_inode *nfsi = NFS_I(rreq->inode);
+
+	if (nfsi->fscache && test_bit(NFS_INO_FSCACHE, &nfsi->flags))
+		rreq->cookie_debug_id = atomic_inc_return(&nfs_fscache_debug_id);
+}
+
+static bool nfs_is_cache_enabled(struct inode *inode)
+{
+	struct nfs_inode *nfsi = NFS_I(inode);
+
+	return nfsi->fscache && test_bit(NFS_INO_FSCACHE, &nfsi->flags);
+}
+
+static int nfs_begin_cache_operation(struct netfs_read_request *rreq)
+{
+	struct fscache_cookie *cookie = NFS_I(rreq->inode)->fscache;
+
+	return fscache_begin_read_operation(rreq, cookie);
 }
 
+static struct netfs_read_request_ops nfs_fscache_req_ops = {
+	.init_rreq		= nfs_init_rreq,
+	.is_cache_enabled	= nfs_is_cache_enabled,
+	.begin_cache_operation	= nfs_begin_cache_operation,
+	.issue_op		= nfs_issue_op,
+	.clamp_length		= nfs_clamp_length,
+	.cleanup		= nfs_cleanup
+};
+
 /*
  * Retrieve a page from fscache
  */
-int __nfs_readpage_from_fscache(struct nfs_open_context *ctx,
-				struct inode *inode, struct page *page)
+int nfs_readpage_from_fscache(struct file *file,
+			      struct page *page,
+			      struct nfs_readdesc *desc)
 {
 	int ret;
+	struct inode *inode = file_inode(file);
+
+	if (!NFS_I(file_inode(file))->fscache)
+		return -ENOBUFS;
 
 	dfprintk(FSCACHE,
 		 "NFS: readpage_from_fscache(fsc:%p/p:%p(i:%lx f:%lx)/0x%p)\n",
 		 nfs_i_fscache(inode), page, page->index, page->flags, inode);
 
-	ret = fscache_read_or_alloc_page(nfs_i_fscache(inode),
-					 page,
-					 nfs_readpage_from_fscache_complete,
-					 ctx,
-					 GFP_KERNEL);
+	ret = netfs_readpage(file, page, &nfs_fscache_req_ops, desc);
 
 	switch (ret) {
-	case 0: /* read BIO submitted (page in fscache) */
-		dfprintk(FSCACHE,
-			 "NFS:    readpage_from_fscache: BIO submitted\n");
+	case 0: /* read submitted */
+		dfprintk(FSCACHE, "NFS:    readpage_from_fscache: submitted\n");
 		nfs_inc_fscache_stats(inode, NFSIOS_FSCACHE_PAGES_READ_OK);
 		return ret;
 
 	case -ENOBUFS: /* inode not in cache */
 	case -ENODATA: /* page not in cache */
 		nfs_inc_fscache_stats(inode, NFSIOS_FSCACHE_PAGES_READ_FAIL);
-		dfprintk(FSCACHE,
-			 "NFS:    readpage_from_fscache %d\n", ret);
+		dfprintk(FSCACHE, "NFS:    readpage_from_fscache %d\n", ret);
 		return 1;
 
 	default:
 		dfprintk(FSCACHE, "NFS:    readpage_from_fscache %d\n", ret);
 		nfs_inc_fscache_stats(inode, NFSIOS_FSCACHE_PAGES_READ_FAIL);
 	}
+
 	return ret;
 }
 
@@ -449,7 +516,7 @@ int __nfs_readpages_from_fscache(struct nfs_open_context *ctx,
 
 	ret = fscache_read_or_alloc_pages(nfs_i_fscache(inode),
 					  mapping, pages, nr_pages,
-					  nfs_readpage_from_fscache_complete,
+					  NULL,
 					  ctx,
 					  mapping_gfp_mask(mapping));
 	if (*nr_pages < npages)
@@ -483,30 +550,19 @@ int __nfs_readpages_from_fscache(struct nfs_open_context *ctx,
 }
 
 /*
- * Store a newly fetched page in fscache
- * - PG_fscache must be set on the page
+ * Store a newly fetched data in fscache
  */
-void __nfs_readpage_to_fscache(struct inode *inode, struct page *page, int sync)
+void nfs_read_completion_to_fscache(struct nfs_pgio_header *hdr,
+				    unsigned long bytes)
 {
-	int ret;
+	struct netfs_read_subrequest *subreq = hdr->fsc;
 
-	dfprintk(FSCACHE,
-		 "NFS: readpage_to_fscache(fsc:%p/p:%p(i:%lx f:%lx)/%d)\n",
-		 nfs_i_fscache(inode), page, page->index, page->flags, sync);
-
-	ret = fscache_write_page(nfs_i_fscache(inode), page,
-				 inode->i_size, GFP_KERNEL);
-	dfprintk(FSCACHE,
-		 "NFS:     readpage_to_fscache: p:%p(i:%lu f:%lx) ret %d\n",
-		 page, page->index, page->flags, ret);
-
-	if (ret != 0) {
-		fscache_uncache_page(nfs_i_fscache(inode), page);
-		nfs_inc_fscache_stats(inode,
-				      NFSIOS_FSCACHE_PAGES_WRITTEN_FAIL);
-		nfs_inc_fscache_stats(inode, NFSIOS_FSCACHE_PAGES_UNCACHED);
-	} else {
-		nfs_inc_fscache_stats(inode,
-				      NFSIOS_FSCACHE_PAGES_WRITTEN_OK);
+	if (NFS_I(hdr->inode)->fscache && subreq) {
+		dfprintk(FSCACHE,
+			 "NFS: read_completion_to_fscache(fsc:%p err:%d bytes:%lu subreq->len:%lu\n",
+			 NFS_I(hdr->inode)->fscache, hdr->error, bytes, subreq->len);
+		__set_bit(NETFS_SREQ_CLEAR_TAIL, &subreq->flags);
+		netfs_subreq_terminated(subreq, hdr->error ?: bytes);
+		hdr->fsc = NULL;
 	}
 }
diff --git a/fs/nfs/fscache.h b/fs/nfs/fscache.h
index 6754c8607230..858f28b1ce03 100644
--- a/fs/nfs/fscache.h
+++ b/fs/nfs/fscache.h
@@ -95,13 +95,14 @@ struct nfs_fscache_inode_auxdata {
 
 extern void __nfs_fscache_invalidate_page(struct page *, struct inode *);
 extern int nfs_fscache_release_page(struct page *, gfp_t);
-
-extern int __nfs_readpage_from_fscache(struct nfs_open_context *,
-				       struct inode *, struct page *);
+extern int nfs_readpage_from_fscache(struct file *file,
+				     struct page *page,
+				     struct nfs_readdesc *desc);
 extern int __nfs_readpages_from_fscache(struct nfs_open_context *,
 					struct inode *, struct address_space *,
 					struct list_head *, unsigned *);
-extern void __nfs_readpage_to_fscache(struct inode *, struct page *, int);
+extern void nfs_read_completion_to_fscache(struct nfs_pgio_header *hdr,
+					   unsigned long bytes);
 
 /*
  * wait for a page to complete writing to the cache
@@ -125,18 +126,6 @@ static inline void nfs_fscache_invalidate_page(struct page *page,
 }
 
 /*
- * Retrieve a page from an inode data storage object.
- */
-static inline int nfs_readpage_from_fscache(struct nfs_open_context *ctx,
-					    struct inode *inode,
-					    struct page *page)
-{
-	if (NFS_I(inode)->fscache)
-		return __nfs_readpage_from_fscache(ctx, inode, page);
-	return -ENOBUFS;
-}
-
-/*
  * Retrieve a set of pages from an inode data storage object.
  */
 static inline int nfs_readpages_from_fscache(struct nfs_open_context *ctx,
@@ -152,18 +141,6 @@ static inline int nfs_readpages_from_fscache(struct nfs_open_context *ctx,
 }
 
 /*
- * Store a page newly fetched from the server in an inode data storage object
- * in the cache.
- */
-static inline void nfs_readpage_to_fscache(struct inode *inode,
-					   struct page *page,
-					   int sync)
-{
-	if (PageFsCache(page))
-		__nfs_readpage_to_fscache(inode, page, sync);
-}
-
-/*
  * Invalidate the contents of fscache for this inode.  This will not sleep.
  */
 static inline void nfs_fscache_invalidate(struct inode *inode)
@@ -212,9 +189,9 @@ static inline void nfs_fscache_invalidate_page(struct page *page,
 static inline void nfs_fscache_wait_on_page_write(struct nfs_inode *nfsi,
 						  struct page *page) {}
 
-static inline int nfs_readpage_from_fscache(struct nfs_open_context *ctx,
-					    struct inode *inode,
-					    struct page *page)
+static inline int nfs_readpage_from_fscache(struct file *file,
+					    struct page *page,
+					    struct nfs_readdesc *desc)
 {
 	return -ENOBUFS;
 }
@@ -226,9 +203,8 @@ static inline int nfs_readpages_from_fscache(struct nfs_open_context *ctx,
 {
 	return -ENOBUFS;
 }
-static inline void nfs_readpage_to_fscache(struct inode *inode,
-					   struct page *page, int sync) {}
-
+static inline void nfs_read_completion_to_fscache(struct nfs_pgio_header *hdr,
+						  unsigned long bytes) {}
 
 static inline void nfs_fscache_invalidate(struct inode *inode) {}
 static inline void nfs_fscache_wait_on_invalidate(struct inode *inode) {}
diff --git a/fs/nfs/pagelist.c b/fs/nfs/pagelist.c
index 78c9c4bdef2b..2e21e6c4023a 100644
--- a/fs/nfs/pagelist.c
+++ b/fs/nfs/pagelist.c
@@ -68,6 +68,7 @@ void nfs_pgheader_init(struct nfs_pageio_descriptor *desc,
 	hdr->good_bytes = mirror->pg_count;
 	hdr->io_completion = desc->pg_io_completion;
 	hdr->dreq = desc->pg_dreq;
+	hdr->fsc = desc->pg_fsc;
 	hdr->release = release;
 	hdr->completion_ops = desc->pg_completion_ops;
 	if (hdr->completion_ops->init_hdr)
@@ -849,6 +850,7 @@ void nfs_pageio_init(struct nfs_pageio_descriptor *desc,
 	desc->pg_lseg = NULL;
 	desc->pg_io_completion = NULL;
 	desc->pg_dreq = NULL;
+	desc->pg_fsc = NULL;
 	desc->pg_bsize = bsize;
 
 	desc->pg_mirror_count = 1;
diff --git a/fs/nfs/read.c b/fs/nfs/read.c
index 9618abf01136..b47e4f38539b 100644
--- a/fs/nfs/read.c
+++ b/fs/nfs/read.c
@@ -124,10 +124,11 @@ static void nfs_readpage_release(struct nfs_page *req, int error)
 		struct address_space *mapping = page_file_mapping(page);
 
 		if (PageUptodate(page))
-			nfs_readpage_to_fscache(inode, page, 0);
+			; /* FIXME: review fscache page error handling */
 		else if (!PageError(page) && !PagePrivate(page))
 			generic_error_remove_page(mapping, page);
-		unlock_page(page);
+		if (!nfs_i_fscache(inode))
+			unlock_page(page);
 	}
 	nfs_release_request(req);
 }
@@ -181,6 +182,8 @@ static void nfs_read_completion(struct nfs_pgio_header *hdr)
 		nfs_list_remove_request(req);
 		nfs_readpage_release(req, error);
 	}
+	/* FIXME: NFS_IOHDR_ERROR and NFS_IOHDR_EOF handled per-page */
+	nfs_read_completion_to_fscache(hdr, bytes);
 out:
 	hdr->release(hdr);
 }
@@ -359,7 +362,7 @@ int nfs_readpage(struct file *file, struct page *page)
 		desc.ctx = get_nfs_open_context(nfs_file_open_context(file));
 
 	if (!IS_SYNC(inode)) {
-		ret = nfs_readpage_from_fscache(desc.ctx, inode, page);
+		ret = nfs_readpage_from_fscache(file, page, &desc);
 		if (ret == 0)
 			goto out;
 	}
diff --git a/include/linux/nfs_page.h b/include/linux/nfs_page.h
index f0373a6cb5fb..b45570bcde91 100644
--- a/include/linux/nfs_page.h
+++ b/include/linux/nfs_page.h
@@ -101,6 +101,7 @@ struct nfs_pageio_descriptor {
 	struct pnfs_layout_segment *pg_lseg;
 	struct nfs_io_completion *pg_io_completion;
 	struct nfs_direct_req	*pg_dreq;
+	void			*pg_fsc;
 	unsigned int		pg_bsize;	/* default bsize for mirrors */
 
 	u32			pg_mirror_count;
diff --git a/include/linux/nfs_xdr.h b/include/linux/nfs_xdr.h
index 3327239fa2f9..95423d3d9d98 100644
--- a/include/linux/nfs_xdr.h
+++ b/include/linux/nfs_xdr.h
@@ -1607,6 +1607,7 @@ struct nfs_pgio_header {
 	const struct nfs_rw_ops	*rw_ops;
 	struct nfs_io_completion *io_completion;
 	struct nfs_direct_req	*dreq;
+	void			*fsc;
 
 	int			pnfs_error;
 	int			error;		/* merge with pnfs_error */
-- 
1.8.3.1


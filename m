Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 01223305544
	for <lists+linux-nfs@lfdr.de>; Wed, 27 Jan 2021 09:09:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231596AbhA0IHy (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 27 Jan 2021 03:07:54 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:32668 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233251AbhA0IFG (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 27 Jan 2021 03:05:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1611734618;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:in-reply-to:in-reply-to:references:references;
        bh=aI2TDwdVfTv3v88QZGZF9mT9GyXjf3ibMfEDal66bTo=;
        b=L+bKEfCzvYYiKEHuvG1BSsOG7r6swPNU5+z86WlSWX/BjI0VocKiZSoqsZMoIgiPhmhhSW
        1vbOzQl62HztXX0ZdAXet16X3nrTPtJa5l/16BZa5ULCzjosb3toVtVzhjKAbeN8Y94hs4
        wb3O/gdNTC4CAGJBp8hKzLGlLcUHVFY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-558-OBL8t7tbOWalKP0pjZMCaw-1; Wed, 27 Jan 2021 03:03:34 -0500
X-MC-Unique: OBL8t7tbOWalKP0pjZMCaw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 257BB9CDA0;
        Wed, 27 Jan 2021 08:03:33 +0000 (UTC)
Received: from dwysocha.rdu.csb (ovpn-112-111.rdu2.redhat.com [10.10.112.111])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id AB1451F0;
        Wed, 27 Jan 2021 08:03:32 +0000 (UTC)
From:   Dave Wysochanski <dwysocha@redhat.com>
To:     Trond Myklebust <trondmy@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH 8/8] NFS: Convert readpages to readahead and use netfs_readahead for fscache
Date:   Wed, 27 Jan 2021 03:03:17 -0500
Message-Id: <1611734597-14754-9-git-send-email-dwysocha@redhat.com>
In-Reply-To: <1611734597-14754-2-git-send-email-dwysocha@redhat.com>
References: <1611734597-14754-2-git-send-email-dwysocha@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

The new FS-Cache API does not have a readpages equivalent function,
and instead of fscache_read_or_alloc_pages() it implements a readahead
function, netfs_readahead().  Call netfs_readahead() if fscache is
enabled, and if not, utilize readahead_page() to run through the
pages needed calling readpage_async_filler().  If we get an error
on any page, then exit the loop, which matches the behavior of
previously called read_cache_pages() when 'filler' returns an error.

Signed-off-by: Dave Wysochanski <dwysocha@redhat.com>
---
 fs/nfs/file.c              |  2 +-
 fs/nfs/fscache.c           | 50 ++++++++++------------------------------------
 fs/nfs/fscache.h           | 28 ++++----------------------
 fs/nfs/read.c              | 36 ++++++++++++++++-----------------
 include/linux/nfs_fs.h     |  3 +--
 include/linux/nfs_iostat.h |  2 +-
 6 files changed, 35 insertions(+), 86 deletions(-)

diff --git a/fs/nfs/file.c b/fs/nfs/file.c
index 63940a7a70be..ebcaa164db5f 100644
--- a/fs/nfs/file.c
+++ b/fs/nfs/file.c
@@ -515,7 +515,7 @@ static void nfs_swap_deactivate(struct file *file)
 
 const struct address_space_operations nfs_file_aops = {
 	.readpage = nfs_readpage,
-	.readpages = nfs_readpages,
+	.readahead = nfs_readahead,
 	.set_page_dirty = __set_page_dirty_nobuffers,
 	.writepage = nfs_writepage,
 	.writepages = nfs_writepages,
diff --git a/fs/nfs/fscache.c b/fs/nfs/fscache.c
index fede075209f5..65fb9065a70c 100644
--- a/fs/nfs/fscache.c
+++ b/fs/nfs/fscache.c
@@ -502,51 +502,21 @@ int nfs_readpage_from_fscache(struct file *file,
 /*
  * Retrieve a set of pages from fscache
  */
-int __nfs_readpages_from_fscache(struct nfs_open_context *ctx,
-				 struct inode *inode,
-				 struct address_space *mapping,
-				 struct list_head *pages,
-				 unsigned *nr_pages)
+int nfs_readahead_from_fscache(struct nfs_readdesc *desc,
+				 struct readahead_control *ractl)
 {
-	unsigned npages = *nr_pages;
-	int ret;
+	struct inode *inode = ractl->mapping->host;
 
-	dfprintk(FSCACHE, "NFS: nfs_getpages_from_fscache (0x%p/%u/0x%p)\n",
-		 nfs_i_fscache(inode), npages, inode);
-
-	ret = fscache_read_or_alloc_pages(nfs_i_fscache(inode),
-					  mapping, pages, nr_pages,
-					  NULL,
-					  ctx,
-					  mapping_gfp_mask(mapping));
-	if (*nr_pages < npages)
-		nfs_add_fscache_stats(inode, NFSIOS_FSCACHE_PAGES_READ_OK,
-				      npages);
-	if (*nr_pages > 0)
-		nfs_add_fscache_stats(inode, NFSIOS_FSCACHE_PAGES_READ_FAIL,
-				      *nr_pages);
+	if (!NFS_I(ractl->mapping->host)->fscache)
+		return -ENOBUFS;
 
-	switch (ret) {
-	case 0: /* read submitted to the cache for all pages */
-		BUG_ON(!list_empty(pages));
-		BUG_ON(*nr_pages != 0);
-		dfprintk(FSCACHE,
-			 "NFS: nfs_getpages_from_fscache: submitted\n");
+	dfprintk(FSCACHE, "NFS: nfs_readahead_from_fscache (0x%p/%u/0x%p)\n",
+		 nfs_i_fscache(inode), readahead_count(ractl), inode);
 
-		return ret;
+	netfs_readahead(ractl, &nfs_fscache_req_ops, desc);
 
-	case -ENOBUFS: /* some pages aren't cached and can't be */
-	case -ENODATA: /* some pages aren't cached */
-		dfprintk(FSCACHE,
-			 "NFS: nfs_getpages_from_fscache: no page: %d\n", ret);
-		return 1;
-
-	default:
-		dfprintk(FSCACHE,
-			 "NFS: nfs_getpages_from_fscache: ret  %d\n", ret);
-	}
-
-	return ret;
+	/* FIXME: NFSIOS_NFSIOS_FSCACHE_ stats */
+	return 0;
 }
 
 /*
diff --git a/fs/nfs/fscache.h b/fs/nfs/fscache.h
index 858f28b1ce03..faccf4549d55 100644
--- a/fs/nfs/fscache.h
+++ b/fs/nfs/fscache.h
@@ -98,12 +98,10 @@ struct nfs_fscache_inode_auxdata {
 extern int nfs_readpage_from_fscache(struct file *file,
 				     struct page *page,
 				     struct nfs_readdesc *desc);
-extern int __nfs_readpages_from_fscache(struct nfs_open_context *,
-					struct inode *, struct address_space *,
-					struct list_head *, unsigned *);
+extern int nfs_readahead_from_fscache(struct nfs_readdesc *desc,
+				      struct readahead_control *ractl);
 extern void nfs_read_completion_to_fscache(struct nfs_pgio_header *hdr,
 					   unsigned long bytes);
-
 /*
  * wait for a page to complete writing to the cache
  */
@@ -126,21 +124,6 @@ static inline void nfs_fscache_invalidate_page(struct page *page,
 }
 
 /*
- * Retrieve a set of pages from an inode data storage object.
- */
-static inline int nfs_readpages_from_fscache(struct nfs_open_context *ctx,
-					     struct inode *inode,
-					     struct address_space *mapping,
-					     struct list_head *pages,
-					     unsigned *nr_pages)
-{
-	if (NFS_I(inode)->fscache)
-		return __nfs_readpages_from_fscache(ctx, inode, mapping, pages,
-						    nr_pages);
-	return -ENOBUFS;
-}
-
-/*
  * Invalidate the contents of fscache for this inode.  This will not sleep.
  */
 static inline void nfs_fscache_invalidate(struct inode *inode)
@@ -195,11 +178,8 @@ static inline int nfs_readpage_from_fscache(struct file *file,
 {
 	return -ENOBUFS;
 }
-static inline int nfs_readpages_from_fscache(struct nfs_open_context *ctx,
-					     struct inode *inode,
-					     struct address_space *mapping,
-					     struct list_head *pages,
-					     unsigned *nr_pages)
+static inline int nfs_readahead_from_fscache(struct nfs_readdesc *desc,
+					     struct readahead_control *ractl)
 {
 	return -ENOBUFS;
 }
diff --git a/fs/nfs/read.c b/fs/nfs/read.c
index b47e4f38539b..8be4f179a371 100644
--- a/fs/nfs/read.c
+++ b/fs/nfs/read.c
@@ -390,50 +390,50 @@ int nfs_readpage(struct file *file, struct page *page)
 	return ret;
 }
 
-int nfs_readpages(struct file *file, struct address_space *mapping,
-		struct list_head *pages, unsigned nr_pages)
+void nfs_readahead(struct readahead_control *ractl)
 {
 	struct nfs_readdesc desc;
-	struct inode *inode = mapping->host;
+	struct inode *inode = ractl->mapping->host;
+	struct page *page;
 	int ret;
 
-	dprintk("NFS: nfs_readpages (%s/%Lu %d)\n",
-			inode->i_sb->s_id,
-			(unsigned long long)NFS_FILEID(inode),
-			nr_pages);
+	dprintk("NFS: %s (%s/%llu %lld)\n", __func__,
+		inode->i_sb->s_id,
+		(unsigned long long)NFS_FILEID(inode),
+		readahead_length(ractl));
 	nfs_inc_stats(inode, NFSIOS_VFSREADPAGES);
 
-	ret = -ESTALE;
 	if (NFS_STALE(inode))
-		goto out;
+		return;
 
-	if (file == NULL) {
-		ret = -EBADF;
+	if (ractl->file == NULL) {
 		desc.ctx = nfs_find_open_context(inode, NULL, FMODE_READ);
 		if (desc.ctx == NULL)
-			goto out;
+			return;
 	} else
-		desc.ctx = get_nfs_open_context(nfs_file_open_context(file));
+		desc.ctx = get_nfs_open_context(nfs_file_open_context(ractl->file));
 
 	/* attempt to read as many of the pages as possible from the cache
 	 * - this returns -ENOBUFS immediately if the cookie is negative
 	 */
-	ret = nfs_readpages_from_fscache(desc.ctx, inode, mapping,
-					 pages, &nr_pages);
+	ret = nfs_readahead_from_fscache(&desc, ractl);
 	if (ret == 0)
 		goto read_complete; /* all pages were read */
 
 	nfs_pageio_init_read(&desc.pgio, inode, false,
 			     &nfs_async_read_completion_ops);
 
-	ret = read_cache_pages(mapping, pages, readpage_async_filler, &desc);
+	while ((page = readahead_page(ractl))) {
+		ret = readpage_async_filler(&desc, page);
+		put_page(page);
+		if (unlikely(ret))
+			break;
+	}
 
 	nfs_pageio_complete_read(&desc.pgio, inode);
 
 read_complete:
 	put_nfs_open_context(desc.ctx);
-out:
-	return ret;
 }
 
 int __init nfs_init_readpagecache(void)
diff --git a/include/linux/nfs_fs.h b/include/linux/nfs_fs.h
index 3cfcf219e96b..968c79b1b09b 100644
--- a/include/linux/nfs_fs.h
+++ b/include/linux/nfs_fs.h
@@ -568,8 +568,7 @@ extern int nfs_access_get_cached(struct inode *inode, const struct cred *cred, s
  * linux/fs/nfs/read.c
  */
 extern int  nfs_readpage(struct file *, struct page *);
-extern int  nfs_readpages(struct file *, struct address_space *,
-		struct list_head *, unsigned);
+extern void nfs_readahead(struct readahead_control *rac);
 
 /*
  * inline functions
diff --git a/include/linux/nfs_iostat.h b/include/linux/nfs_iostat.h
index 027874c36c88..8baf8fb7551d 100644
--- a/include/linux/nfs_iostat.h
+++ b/include/linux/nfs_iostat.h
@@ -53,7 +53,7 @@
  * NFS page counters
  *
  * These count the number of pages read or written via nfs_readpage(),
- * nfs_readpages(), or their write equivalents.
+ * nfs_readahead(), or their write equivalents.
  *
  * NB: When adding new byte counters, please include the measured
  * units in the name of each byte counter to help users of this
-- 
1.8.3.1


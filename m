Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F6AE232006
	for <lists+linux-nfs@lfdr.de>; Wed, 29 Jul 2020 16:12:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726365AbgG2OMx (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 29 Jul 2020 10:12:53 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:30911 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726588AbgG2OMw (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 29 Jul 2020 10:12:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1596031970;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:in-reply-to:in-reply-to:references:references;
        bh=aCR2asmQ8XzAtoIUfU/U5xhUzggr6MGGB88A+RWEK78=;
        b=Q26wZAnILqVcRXHC1lTI2RQfLPxJeJRFGwISkc/2BtHDbdyxmPVYuVyRs/Buaysu2YxSrl
        HfJqPx4VGGcx3M8vpsL6FOGkVl54GN0kGGDYgftZpsyDDVBueNPyhLtsyq7A9wIbMS5XU0
        9ByNhYBFVzj08gaTeWgP1IX20ZKSJ7Q=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-392-zLM5fY_tMqiCfyIHsGC7Rw-1; Wed, 29 Jul 2020 10:12:48 -0400
X-MC-Unique: zLM5fY_tMqiCfyIHsGC7Rw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A4AAB106B243;
        Wed, 29 Jul 2020 14:12:47 +0000 (UTC)
Received: from dwysocha.rdu.csb (ovpn-113-23.rdu2.redhat.com [10.10.113.23])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 2AB6F71906;
        Wed, 29 Jul 2020 14:12:47 +0000 (UTC)
From:   Dave Wysochanski <dwysocha@redhat.com>
To:     Trond Myklebust <trondmy@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>
Cc:     linux-nfs@vger.kernel.org, linux-cachefs@redhat.com
Subject: [RFC PATCH v2 10/14] NFS: Convert fscache invalidation and update aux_data and i_size
Date:   Wed, 29 Jul 2020 10:12:25 -0400
Message-Id: <1596031949-26793-11-git-send-email-dwysocha@redhat.com>
In-Reply-To: <1596031949-26793-1-git-send-email-dwysocha@redhat.com>
References: <1596031949-26793-1-git-send-email-dwysocha@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Convert nfs_fscache_invalidate to the new FS-Cache API.  Also,
now when invalidating an fscache cookie, be sure to pass the latest
i_size as well as aux_data to fscache.

A few APIs no longer exist so remove them.  We can call directly to
wait_on_page_fscache() because it checks whether a page is an fscache
page before waiting on it.

Signed-off-by: Dave Wysochanski <dwysocha@redhat.com>
---
 fs/nfs/file.c    | 20 +++++++++++-------
 fs/nfs/fscache.c | 21 -------------------
 fs/nfs/fscache.h | 64 +++++++++++++++++++-------------------------------------
 fs/nfs/inode.c   |  1 -
 fs/nfs/write.c   |  2 +-
 5 files changed, 35 insertions(+), 73 deletions(-)

diff --git a/fs/nfs/file.c b/fs/nfs/file.c
index ccd6c1637b27..7af528c423c0 100644
--- a/fs/nfs/file.c
+++ b/fs/nfs/file.c
@@ -413,8 +413,8 @@ static void nfs_invalidate_page(struct page *page, unsigned int offset,
 		return;
 	/* Cancel any unstarted writes on this page */
 	nfs_wb_page_cancel(page_file_mapping(page)->host, page);
-
-	nfs_fscache_invalidate_page(page, page->mapping->host);
+	wait_on_page_fscache(page);
+	nfs_fscache_invalidate(page_file_mapping(page)->host);
 }
 
 /*
@@ -429,8 +429,13 @@ static int nfs_release_page(struct page *page, gfp_t gfp)
 
 	/* If PagePrivate() is set, then the page is not freeable */
 	if (PagePrivate(page))
-		return 0;
-	return nfs_fscache_release_page(page, gfp);
+		return false;
+	if (PageFsCache(page)) {
+		if (!(gfp & __GFP_DIRECT_RECLAIM) || !(gfp & __GFP_FS))
+			return false;
+		wait_on_page_fscache(page);
+	}
+	return true;
 }
 
 static void nfs_check_dirty_writeback(struct page *page,
@@ -473,12 +478,11 @@ static void nfs_check_dirty_writeback(struct page *page,
 static int nfs_launder_page(struct page *page)
 {
 	struct inode *inode = page_file_mapping(page)->host;
-	struct nfs_inode *nfsi = NFS_I(inode);
 
 	dfprintk(PAGECACHE, "NFS: launder_page(%ld, %llu)\n",
 		inode->i_ino, (long long)page_offset(page));
 
-	nfs_fscache_wait_on_page_write(nfsi, page);
+	wait_on_page_fscache(page);
 	return nfs_wb_page(inode, page);
 }
 
@@ -553,7 +557,9 @@ static vm_fault_t nfs_vm_page_mkwrite(struct vm_fault *vmf)
 	sb_start_pagefault(inode->i_sb);
 
 	/* make sure the cache has finished storing the page */
-	nfs_fscache_wait_on_page_write(NFS_I(inode), page);
+	if (PageFsCache(vmf->page) &&
+	    wait_on_page_bit_killable(vmf->page, PG_fscache) < 0)
+		return VM_FAULT_RETRY;
 
 	wait_on_bit_action(&NFS_I(inode)->flags, NFS_INO_INVALIDATING,
 			nfs_wait_bit_killable, TASK_KILLABLE);
diff --git a/fs/nfs/fscache.c b/fs/nfs/fscache.c
index 00bb720cccfa..08cdc78410d5 100644
--- a/fs/nfs/fscache.c
+++ b/fs/nfs/fscache.c
@@ -14,7 +14,6 @@
 #include <linux/in6.h>
 #include <linux/seq_file.h>
 #include <linux/slab.h>
-#include <linux/iversion.h>
 
 #include "internal.h"
 #include "iostat.h"
@@ -234,19 +233,6 @@ void nfs_fscache_release_super_cookie(struct super_block *sb)
 	}
 }
 
-static void nfs_fscache_update_auxdata(struct nfs_fscache_inode_auxdata *auxdata,
-				  struct nfs_inode *nfsi)
-{
-	memset(auxdata, 0, sizeof(*auxdata));
-	auxdata->mtime_sec  = nfsi->vfs_inode.i_mtime.tv_sec;
-	auxdata->mtime_nsec = nfsi->vfs_inode.i_mtime.tv_nsec;
-	auxdata->ctime_sec  = nfsi->vfs_inode.i_ctime.tv_sec;
-	auxdata->ctime_nsec = nfsi->vfs_inode.i_ctime.tv_nsec;
-
-	if (NFS_SERVER(&nfsi->vfs_inode)->nfs_client->rpc_ops->version == 4)
-		auxdata->change_attr = inode_peek_iversion_raw(&nfsi->vfs_inode);
-}
-
 /*
  * Initialise the per-inode cache cookie pointer for an NFS inode.
  */
@@ -293,13 +279,6 @@ void nfs_fscache_clear_inode(struct inode *inode)
 	nfsi->fscache = NULL;
 }
 
-static bool nfs_fscache_can_enable(void *data)
-{
-	struct inode *inode = data;
-
-	return !inode_is_open_for_write(inode);
-}
-
 /*
  * Enable or disable caching for a file that is being opened as appropriate.
  * The cookie is allocated when the inode is initialised, but is not enabled at
diff --git a/fs/nfs/fscache.h b/fs/nfs/fscache.h
index 95a1b29946a0..de060f61cadd 100644
--- a/fs/nfs/fscache.h
+++ b/fs/nfs/fscache.h
@@ -12,6 +12,7 @@
 #include <linux/nfs_mount.h>
 #include <linux/nfs4_mount.h>
 #include <linux/fscache.h>
+#include <linux/iversion.h>
 
 #ifdef CONFIG_NFS_FSCACHE
 
@@ -90,9 +91,6 @@ struct nfs_fscache_inode_auxdata {
 extern void nfs_fscache_clear_inode(struct inode *);
 extern void nfs_fscache_open_file(struct inode *, struct file *);
 
-extern void __nfs_fscache_invalidate_page(struct page *, struct inode *);
-extern int nfs_fscache_release_page(struct page *, gfp_t);
-
 extern int __nfs_readpage_from_fscache(struct nfs_open_context *,
 				       struct inode *, struct page *);
 extern int __nfs_readpages_from_fscache(struct nfs_open_context *,
@@ -100,28 +98,6 @@ extern int __nfs_readpages_from_fscache(struct nfs_open_context *,
 					struct list_head *);
 extern void __nfs_read_completion_to_fscache(struct nfs_pgio_header *hdr,
 					     unsigned long bytes);
-
-/*
- * wait for a page to complete writing to the cache
- */
-static inline void nfs_fscache_wait_on_page_write(struct nfs_inode *nfsi,
-						  struct page *page)
-{
-	if (PageFsCache(page))
-		fscache_wait_on_page_write(nfsi->fscache, page);
-}
-
-/*
- * release the caching state associated with a page if undergoing complete page
- * invalidation
- */
-static inline void nfs_fscache_invalidate_page(struct page *page,
-					       struct inode *inode)
-{
-	if (PageFsCache(page))
-		__nfs_fscache_invalidate_page(page, inode);
-}
-
 /*
  * Retrieve a page from an inode data storage object.
  */
@@ -158,20 +134,32 @@ static inline void nfs_read_completion_to_fscache(struct nfs_pgio_header *hdr,
 		__nfs_read_completion_to_fscache(hdr, bytes);
 }
 
-/*
- * Invalidate the contents of fscache for this inode.  This will not sleep.
- */
-static inline void nfs_fscache_invalidate(struct inode *inode)
+static inline void nfs_fscache_update_auxdata(struct nfs_fscache_inode_auxdata *auxdata,
+				  struct nfs_inode *nfsi)
 {
-	fscache_invalidate(NFS_I(inode)->fscache);
+	memset(auxdata, 0, sizeof(*auxdata));
+	auxdata->mtime_sec  = nfsi->vfs_inode.i_mtime.tv_sec;
+	auxdata->mtime_nsec = nfsi->vfs_inode.i_mtime.tv_nsec;
+	auxdata->ctime_sec  = nfsi->vfs_inode.i_ctime.tv_sec;
+	auxdata->ctime_nsec = nfsi->vfs_inode.i_ctime.tv_nsec;
+
+	if (NFS_SERVER(&nfsi->vfs_inode)->nfs_client->rpc_ops->version == 4)
+		auxdata->change_attr = inode_peek_iversion_raw(&nfsi->vfs_inode);
 }
 
 /*
- * Wait for an object to finish being invalidated.
+ * Invalidate the contents of fscache for this inode.  This will not sleep.
  */
-static inline void nfs_fscache_wait_on_invalidate(struct inode *inode)
+static inline void nfs_fscache_invalidate(struct inode *inode)
 {
-	fscache_wait_on_invalidate(NFS_I(inode)->fscache);
+	struct nfs_fscache_inode_auxdata auxdata;
+	struct nfs_inode *nfsi = NFS_I(inode);
+
+	if (nfsi->fscache) {
+		nfs_fscache_update_auxdata(&auxdata, nfsi);
+		fscache_invalidate(nfsi->fscache, &auxdata,
+				   i_size_read(&nfsi->vfs_inode), 0);
+	}
 }
 
 /*
@@ -198,15 +186,6 @@ static inline void nfs_fscache_clear_inode(struct inode *inode) {}
 static inline void nfs_fscache_open_file(struct inode *inode,
 					 struct file *filp) {}
 
-static inline int nfs_fscache_release_page(struct page *page, gfp_t gfp)
-{
-	return 1; /* True: may release page */
-}
-static inline void nfs_fscache_invalidate_page(struct page *page,
-					       struct inode *inode) {}
-static inline void nfs_fscache_wait_on_page_write(struct nfs_inode *nfsi,
-						  struct page *page) {}
-
 static inline int nfs_readpage_from_fscache(struct nfs_open_context *ctx,
 					    struct inode *inode,
 					    struct page *page)
@@ -224,7 +203,6 @@ static inline void nfs_read_completion_to_fscache(struct nfs_pgio_header *hdr,
 						  unsigned long bytes) {}
 
 static inline void nfs_fscache_invalidate(struct inode *inode) {}
-static inline void nfs_fscache_wait_on_invalidate(struct inode *inode) {}
 
 static inline const char *nfs_server_fscache_state(struct nfs_server *server)
 {
diff --git a/fs/nfs/inode.c b/fs/nfs/inode.c
index 0bf1f835de01..b9a84f1c1a5c 100644
--- a/fs/nfs/inode.c
+++ b/fs/nfs/inode.c
@@ -1248,7 +1248,6 @@ static int nfs_invalidate_mapping(struct inode *inode, struct address_space *map
 		spin_unlock(&inode->i_lock);
 	}
 	nfs_inc_stats(inode, NFSIOS_DATAINVALIDATE);
-	nfs_fscache_wait_on_invalidate(inode);
 
 	dfprintk(PAGECACHE, "NFS: (%s/%Lu) data cache invalidated\n",
 			inode->i_sb->s_id,
diff --git a/fs/nfs/write.c b/fs/nfs/write.c
index 639c34fec04a..005eea29e0ec 100644
--- a/fs/nfs/write.c
+++ b/fs/nfs/write.c
@@ -2112,7 +2112,7 @@ int nfs_migrate_page(struct address_space *mapping, struct page *newpage,
 	if (PagePrivate(page))
 		return -EBUSY;
 
-	if (!nfs_fscache_release_page(page, GFP_KERNEL))
+	if (PageFsCache(page))
 		return -EBUSY;
 
 	return migrate_page(mapping, newpage, page, mode);
-- 
1.8.3.1


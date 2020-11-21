Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2AE4B2BBF3C
	for <lists+linux-nfs@lfdr.de>; Sat, 21 Nov 2020 14:29:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727823AbgKUN3h (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sat, 21 Nov 2020 08:29:37 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:59251 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727827AbgKUN3g (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sat, 21 Nov 2020 08:29:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1605965374;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc; bh=aIhNDUGmnqR3uHiXMsSBbOvLJ1UnCFBC9WvzLh9SNrg=;
        b=WB8ceDoX9xiA2PAQxGrgkI+fETyzNLuU9ph4ldUgckAk3/6NCB2shinTDnvqhMPZezCnEV
        F3d17m3u2CKMDJbcDSZJjTNzh81Ap08Yt+mfTKA0cUo1F6nWdqBy89vvXTdcbGJeLwf6mO
        dEKGtBYIA41rl91BJsDSZhA/S4Acx+I=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-447-7sDlgxUVOASMjZbuuWp4dQ-1; Sat, 21 Nov 2020 08:29:32 -0500
X-MC-Unique: 7sDlgxUVOASMjZbuuWp4dQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1B4A61005D69;
        Sat, 21 Nov 2020 13:29:31 +0000 (UTC)
Received: from dwysocha.rdu.csb (ovpn-112-41.rdu2.redhat.com [10.10.112.41])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 90A585D6BA;
        Sat, 21 Nov 2020 13:29:30 +0000 (UTC)
From:   Dave Wysochanski <dwysocha@redhat.com>
To:     Trond Myklebust <trondmy@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>
Cc:     linux-nfs@vger.kernel.org, dhowells@redhat.com
Subject: [PATCH v1 09/13] NFS: Convert fscache invalidation and update aux_data and i_size
Date:   Sat, 21 Nov 2020 08:29:29 -0500
Message-Id: <1605965369-24781-1-git-send-email-dwysocha@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Convert nfs_fscache_invalidate to the new FS-Cache API.  Also,
now when invalidating an fscache cookie, be sure to pass the latest
i_size as well as aux_data to fscache.

A few APIs no longer exist so remove them.  We can call directly to
wait_on_page_fscache() because it checks whether a page is an fscache
page before waiting on it.

Since the current NFS fscache implementation is only enabled when a
file is open for read, handle writes with invalidation.  If a write
extends the size of the file and fscache is enabled, we must invalidate
the object with the new size.

We must also invalidate fscache when doing a direct write to avoid
issues seen specifically with NFSv4.x when direct writes are followed
by non-direct (buffered) reads.  Note that we cannot call
fscache_invalidate() while holding inode->i_lock.

Signed-off-by: Dave Wysochanski <dwysocha@redhat.com>
---
 fs/nfs/direct.c   |  2 ++
 fs/nfs/file.c     | 20 ++++++++++------
 fs/nfs/fscache.c  | 20 ----------------
 fs/nfs/fscache.h  | 69 +++++++++++++++++++------------------------------------
 fs/nfs/inode.c    |  4 ++--
 fs/nfs/nfs4proc.c |  2 +-
 fs/nfs/write.c    |  3 ++-
 7 files changed, 44 insertions(+), 76 deletions(-)

diff --git a/fs/nfs/direct.c b/fs/nfs/direct.c
index 2d30a4da49fa..8f920c1ad522 100644
--- a/fs/nfs/direct.c
+++ b/fs/nfs/direct.c
@@ -59,6 +59,7 @@
 #include "internal.h"
 #include "iostat.h"
 #include "pnfs.h"
+#include "fscache.h"
 
 #define NFSDBG_FACILITY		NFSDBG_VFS
 
@@ -962,6 +963,7 @@ ssize_t nfs_file_direct_write(struct kiocb *iocb, struct iov_iter *iter)
 	} else {
 		result = requested;
 	}
+	nfs_fscache_invalidate(inode, FSCACHE_INVAL_DIO_WRITE);
 out_release:
 	nfs_direct_req_release(dreq);
 out:
diff --git a/fs/nfs/file.c b/fs/nfs/file.c
index 63940a7a70be..ba988e639037 100644
--- a/fs/nfs/file.c
+++ b/fs/nfs/file.c
@@ -415,8 +415,8 @@ static void nfs_invalidate_page(struct page *page, unsigned int offset,
 		return;
 	/* Cancel any unstarted writes on this page */
 	nfs_wb_page_cancel(page_file_mapping(page)->host, page);
-
-	nfs_fscache_invalidate_page(page, page->mapping->host);
+	wait_on_page_fscache(page);
+	nfs_fscache_invalidate(page_file_mapping(page)->host, 0);
 }
 
 /*
@@ -431,8 +431,13 @@ static int nfs_release_page(struct page *page, gfp_t gfp)
 
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
@@ -475,12 +480,11 @@ static void nfs_check_dirty_writeback(struct page *page,
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
 
@@ -555,7 +559,9 @@ static vm_fault_t nfs_vm_page_mkwrite(struct vm_fault *vmf)
 	sb_start_pagefault(inode->i_sb);
 
 	/* make sure the cache has finished storing the page */
-	nfs_fscache_wait_on_page_write(NFS_I(inode), page);
+	if (PageFsCache(vmf->page) &&
+	    wait_on_page_bit_killable(vmf->page, PG_fscache) < 0)
+		return VM_FAULT_RETRY;
 
 	wait_on_bit_action(&NFS_I(inode)->flags, NFS_INO_INVALIDATING,
 			nfs_wait_bit_killable, TASK_KILLABLE);
diff --git a/fs/nfs/fscache.c b/fs/nfs/fscache.c
index d0477e40aa32..c1ca241381cb 100644
--- a/fs/nfs/fscache.c
+++ b/fs/nfs/fscache.c
@@ -234,19 +234,6 @@ void nfs_fscache_release_super_cookie(struct super_block *sb)
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
@@ -293,13 +280,6 @@ void nfs_fscache_clear_inode(struct inode *inode)
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
index 6e6d9971244a..9fcaa17584b6 100644
--- a/fs/nfs/fscache.h
+++ b/fs/nfs/fscache.h
@@ -12,6 +12,7 @@
 #include <linux/nfs_mount.h>
 #include <linux/nfs4_mount.h>
 #include <linux/fscache.h>
+#include <linux/iversion.h>
 
 #ifdef CONFIG_NFS_FSCACHE
 
@@ -90,37 +91,13 @@ struct nfs_fscache_inode_auxdata {
 extern void nfs_fscache_clear_inode(struct inode *);
 extern void nfs_fscache_open_file(struct inode *, struct file *);
 
-extern void __nfs_fscache_invalidate_page(struct page *, struct inode *);
-extern int nfs_fscache_release_page(struct page *, gfp_t);
-
 extern int __nfs_readpage_from_fscache(struct nfs_open_context *,
 				       struct inode *, struct page *);
 extern int __nfs_readpages_from_fscache(struct nfs_open_context *,
 					struct inode *, struct address_space *,
 					struct list_head *, unsigned *);
-extern void __nfs_readpage_to_fscache(struct inode *, struct page *, int);
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
+extern void __nfs_read_completion_to_fscache(struct nfs_pgio_header *hdr,
+					     unsigned long bytes);
 /*
  * Retrieve a page from an inode data storage object.
  */
@@ -160,20 +137,32 @@ static inline void nfs_readpage_to_fscache(struct inode *inode,
 		__nfs_readpage_to_fscache(inode, page, sync);
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
+static inline void nfs_fscache_invalidate(struct inode *inode, int flags)
 {
-	fscache_wait_on_invalidate(NFS_I(inode)->fscache);
+	struct nfs_fscache_inode_auxdata auxdata;
+	struct nfs_inode *nfsi = NFS_I(inode);
+
+	if (nfsi->fscache) {
+		nfs_fscache_update_auxdata(&auxdata, nfsi);
+		fscache_invalidate(nfsi->fscache, &auxdata,
+				   i_size_read(&nfsi->vfs_inode), flags);
+	}
 }
 
 /*
@@ -200,15 +189,6 @@ static inline void nfs_fscache_clear_inode(struct inode *inode) {}
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
@@ -227,8 +207,7 @@ static inline void nfs_readpage_to_fscache(struct inode *inode,
 					   struct page *page, int sync) {}
 
 
-static inline void nfs_fscache_invalidate(struct inode *inode) {}
-static inline void nfs_fscache_wait_on_invalidate(struct inode *inode) {}
+static inline void nfs_fscache_invalidate(struct inode *inode, int flags) {}
 
 static inline const char *nfs_server_fscache_state(struct nfs_server *server)
 {
diff --git a/fs/nfs/inode.c b/fs/nfs/inode.c
index aa6493905bbe..c525dea851c8 100644
--- a/fs/nfs/inode.c
+++ b/fs/nfs/inode.c
@@ -213,7 +213,7 @@ static void nfs_set_cache_invalid(struct inode *inode, unsigned long flags)
 		flags &= ~(NFS_INO_INVALID_DATA|NFS_INO_DATA_INVAL_DEFER);
 	nfsi->cache_validity |= flags;
 	if (flags & NFS_INO_INVALID_DATA)
-		nfs_fscache_invalidate(inode);
+		nfs_fscache_invalidate(inode, 0);
 }
 
 /*
@@ -1240,6 +1240,7 @@ static int nfs_invalidate_mapping(struct inode *inode, struct address_space *map
 	struct nfs_inode *nfsi = NFS_I(inode);
 	int ret;
 
+	nfs_fscache_invalidate(inode, 0);
 	if (mapping->nrpages != 0) {
 		if (S_ISREG(inode->i_mode)) {
 			ret = nfs_sync_mapping(mapping);
@@ -1256,7 +1257,6 @@ static int nfs_invalidate_mapping(struct inode *inode, struct address_space *map
 		spin_unlock(&inode->i_lock);
 	}
 	nfs_inc_stats(inode, NFSIOS_DATAINVALIDATE);
-	nfs_fscache_wait_on_invalidate(inode);
 
 	dfprintk(PAGECACHE, "NFS: (%s/%Lu) data cache invalidated\n",
 			inode->i_sb->s_id,
diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
index 9e0ca9b2b210..9799f09f1540 100644
--- a/fs/nfs/nfs4proc.c
+++ b/fs/nfs/nfs4proc.c
@@ -1217,7 +1217,7 @@ int nfs4_call_sync(struct rpc_clnt *clnt,
 	nfsi->cache_validity &= ~NFS_INO_INVALID_CHANGE;
 
 	if (nfsi->cache_validity & NFS_INO_INVALID_DATA)
-		nfs_fscache_invalidate(inode);
+		nfs_fscache_invalidate(inode, 0);
 }
 
 void
diff --git a/fs/nfs/write.c b/fs/nfs/write.c
index 639c34fec04a..4657ac0c68ac 100644
--- a/fs/nfs/write.c
+++ b/fs/nfs/write.c
@@ -293,6 +293,7 @@ static void nfs_grow_file(struct page *page, unsigned int offset, unsigned int c
 	nfs_inc_stats(inode, NFSIOS_EXTENDWRITE);
 out:
 	spin_unlock(&inode->i_lock);
+	nfs_fscache_invalidate(inode, 0);
 }
 
 /* A writeback failed: mark the page as bad, and invalidate the page cache */
@@ -2112,7 +2113,7 @@ int nfs_migrate_page(struct address_space *mapping, struct page *newpage,
 	if (PagePrivate(page))
 		return -EBUSY;
 
-	if (!nfs_fscache_release_page(page, GFP_KERNEL))
+	if (PageFsCache(page))
 		return -EBUSY;
 
 	return migrate_page(mapping, newpage, page, mode);
-- 
1.8.3.1


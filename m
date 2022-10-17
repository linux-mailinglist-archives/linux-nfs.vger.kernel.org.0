Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F706600CE5
	for <lists+linux-nfs@lfdr.de>; Mon, 17 Oct 2022 12:52:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229897AbiJQKwa (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 17 Oct 2022 06:52:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229887AbiJQKw3 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 17 Oct 2022 06:52:29 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DB0F6053C
        for <linux-nfs@vger.kernel.org>; Mon, 17 Oct 2022 03:52:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1666003947;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4H79BdHtaKPWzY/xY4aqmK2MMltcn0yPoNPDRxm9lxY=;
        b=MXxJyAgzW+FVS3qm1A1qZU22S4Tadpnj0ks9909cZanHkIJgy+/Ob6lUXFK3jic7r6pJRz
        vRAQA6KKrQsNKMdKDGW0VnB1pvnM0bBXKEqvPe2U8J4Y+FX1llz5P6tKbYl/MgPnSWQs4j
        IaZtoglwjjiAxF0n45mVNa2KWidXaaQ=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-629-aBDI2wQQPDCU71scOc1j5g-1; Mon, 17 Oct 2022 06:52:26 -0400
X-MC-Unique: aBDI2wQQPDCU71scOc1j5g-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 2554F3815D20;
        Mon, 17 Oct 2022 10:52:26 +0000 (UTC)
Received: from dwysocha.rdu.csb (unknown [10.22.8.42])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id D340A1121319;
        Mon, 17 Oct 2022 10:52:25 +0000 (UTC)
From:   Dave Wysochanski <dwysocha@redhat.com>
To:     Anna Schumaker <anna.schumaker@netapp.com>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        David Howells <dhowells@redhat.com>
Cc:     linux-nfs@vger.kernel.org, linux-cachefs@redhat.com,
        Benjamin Maynard <benmaynard@google.com>,
        Daire Byrne <daire.byrne@gmail.com>
Subject: [PATCH v9 2/5] NFS: Configure support for netfs when NFS fscache is configured
Date:   Mon, 17 Oct 2022 06:52:09 -0400
Message-Id: <20221017105212.77588-3-dwysocha@redhat.com>
In-Reply-To: <20221017105212.77588-1-dwysocha@redhat.com>
References: <20221017105212.77588-1-dwysocha@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

As first steps for support of the netfs library when NFS_FSCACHE is
configured, add NETFS_SUPPORT to Kconfig and add the required netfs_inode
into struct nfs_inode.

Using netfs requires we move the VFS inode structure to be stored
inside struct netfs_inode, along with the fscache_cookie.
Thus, create a new helper, VFS_I(), which is defined
differently depending on whether NFS_FSCACHE is configured.
In addition, use the netfs_inode() and netfs_i_cookie() helpers,
and remove our own helper, nfs_i_fscache().

Later patches will convert NFS fscache to fully use netfs.

Signed-off-by: Dave Wysochanski <dwysocha@redhat.com>
Reviewed-by: Jeff Layton <jlayton@kernel.org>
---
 fs/nfs/Kconfig         |  1 +
 fs/nfs/delegation.c    |  2 +-
 fs/nfs/dir.c           |  2 +-
 fs/nfs/fscache.c       | 20 +++++++++-----------
 fs/nfs/fscache.h       | 15 ++++++---------
 fs/nfs/inode.c         |  6 +++---
 fs/nfs/internal.h      |  2 +-
 fs/nfs/pnfs.c          | 12 ++++++------
 fs/nfs/write.c         |  2 +-
 include/linux/nfs_fs.h | 34 +++++++++++++++++++++++-----------
 10 files changed, 52 insertions(+), 44 deletions(-)

diff --git a/fs/nfs/Kconfig b/fs/nfs/Kconfig
index 14a72224b657..8fbb6caf3481 100644
--- a/fs/nfs/Kconfig
+++ b/fs/nfs/Kconfig
@@ -171,6 +171,7 @@ config ROOT_NFS
 config NFS_FSCACHE
 	bool "Provide NFS client caching support"
 	depends on NFS_FS=m && FSCACHE || NFS_FS=y && FSCACHE=y
+	select NETFS_SUPPORT
 	help
 	  Say Y here if you want NFS data to be cached locally on disc through
 	  the general filesystem cache manager
diff --git a/fs/nfs/delegation.c b/fs/nfs/delegation.c
index 5c97cad741a7..b5c492d40367 100644
--- a/fs/nfs/delegation.c
+++ b/fs/nfs/delegation.c
@@ -306,7 +306,7 @@ nfs_start_delegation_return_locked(struct nfs_inode *nfsi)
 	}
 	spin_unlock(&delegation->lock);
 	if (ret)
-		nfs_clear_verifier_delegated(&nfsi->vfs_inode);
+		nfs_clear_verifier_delegated(VFS_I(nfsi));
 out:
 	return ret;
 }
diff --git a/fs/nfs/dir.c b/fs/nfs/dir.c
index 5d6c2ddc7ea6..b63c624cea6d 100644
--- a/fs/nfs/dir.c
+++ b/fs/nfs/dir.c
@@ -2799,7 +2799,7 @@ nfs_do_access_cache_scan(unsigned int nr_to_scan)
 
 		if (nr_to_scan-- == 0)
 			break;
-		inode = &nfsi->vfs_inode;
+		inode = VFS_I(nfsi);
 		spin_lock(&inode->i_lock);
 		if (list_empty(&nfsi->access_cache_entry_lru))
 			goto remove_lru_entry;
diff --git a/fs/nfs/fscache.c b/fs/nfs/fscache.c
index e861d7bae305..a6fc1c8b6644 100644
--- a/fs/nfs/fscache.c
+++ b/fs/nfs/fscache.c
@@ -163,13 +163,14 @@ void nfs_fscache_init_inode(struct inode *inode)
 	struct nfs_server *nfss = NFS_SERVER(inode);
 	struct nfs_inode *nfsi = NFS_I(inode);
 
-	nfsi->fscache = NULL;
+	netfs_inode(inode)->cache = NULL;
 	if (!(nfss->fscache && S_ISREG(inode->i_mode)))
 		return;
 
 	nfs_fscache_update_auxdata(&auxdata, inode);
 
-	nfsi->fscache = fscache_acquire_cookie(NFS_SB(inode->i_sb)->fscache,
+	netfs_inode(inode)->cache = fscache_acquire_cookie(
+					       nfss->fscache,
 					       0,
 					       nfsi->fh.data, /* index_key */
 					       nfsi->fh.size,
@@ -183,11 +184,8 @@ void nfs_fscache_init_inode(struct inode *inode)
  */
 void nfs_fscache_clear_inode(struct inode *inode)
 {
-	struct nfs_inode *nfsi = NFS_I(inode);
-	struct fscache_cookie *cookie = nfs_i_fscache(inode);
-
-	fscache_relinquish_cookie(cookie, false);
-	nfsi->fscache = NULL;
+	fscache_relinquish_cookie(netfs_i_cookie(&NFS_I(inode)->netfs), false);
+	netfs_inode(inode)->cache = NULL;
 }
 
 /*
@@ -212,7 +210,7 @@ void nfs_fscache_clear_inode(struct inode *inode)
 void nfs_fscache_open_file(struct inode *inode, struct file *filp)
 {
 	struct nfs_fscache_inode_auxdata auxdata;
-	struct fscache_cookie *cookie = nfs_i_fscache(inode);
+	struct fscache_cookie *cookie = netfs_i_cookie(&NFS_I(inode)->netfs);
 	bool open_for_write = inode_is_open_for_write(inode);
 
 	if (!fscache_cookie_valid(cookie))
@@ -230,7 +228,7 @@ EXPORT_SYMBOL_GPL(nfs_fscache_open_file);
 void nfs_fscache_release_file(struct inode *inode, struct file *filp)
 {
 	struct nfs_fscache_inode_auxdata auxdata;
-	struct fscache_cookie *cookie = nfs_i_fscache(inode);
+	struct fscache_cookie *cookie = netfs_i_cookie(&NFS_I(inode)->netfs);
 	loff_t i_size = i_size_read(inode);
 
 	nfs_fscache_update_auxdata(&auxdata, inode);
@@ -243,7 +241,7 @@ void nfs_fscache_release_file(struct inode *inode, struct file *filp)
 static int fscache_fallback_read_page(struct inode *inode, struct page *page)
 {
 	struct netfs_cache_resources cres;
-	struct fscache_cookie *cookie = nfs_i_fscache(inode);
+	struct fscache_cookie *cookie = netfs_i_cookie(&NFS_I(inode)->netfs);
 	struct iov_iter iter;
 	struct bio_vec bvec[1];
 	int ret;
@@ -271,7 +269,7 @@ static int fscache_fallback_write_page(struct inode *inode, struct page *page,
 				       bool no_space_allocated_yet)
 {
 	struct netfs_cache_resources cres;
-	struct fscache_cookie *cookie = nfs_i_fscache(inode);
+	struct fscache_cookie *cookie = netfs_i_cookie(&NFS_I(inode)->netfs);
 	struct iov_iter iter;
 	struct bio_vec bvec[1];
 	loff_t start = page_offset(page);
diff --git a/fs/nfs/fscache.h b/fs/nfs/fscache.h
index 2a37af880978..38614ed8f951 100644
--- a/fs/nfs/fscache.h
+++ b/fs/nfs/fscache.h
@@ -54,7 +54,7 @@ static inline bool nfs_fscache_release_folio(struct folio *folio, gfp_t gfp)
 		if (current_is_kswapd() || !(gfp & __GFP_FS))
 			return false;
 		folio_wait_fscache(folio);
-		fscache_note_page_release(nfs_i_fscache(folio->mapping->host));
+		fscache_note_page_release(netfs_i_cookie(&NFS_I(folio->mapping->host)->netfs));
 		nfs_inc_fscache_stats(folio->mapping->host,
 				      NFSIOS_FSCACHE_PAGES_UNCACHED);
 	}
@@ -66,7 +66,7 @@ static inline bool nfs_fscache_release_folio(struct folio *folio, gfp_t gfp)
  */
 static inline int nfs_fscache_read_page(struct inode *inode, struct page *page)
 {
-	if (nfs_i_fscache(inode))
+	if (netfs_inode(inode)->cache)
 		return __nfs_fscache_read_page(inode, page);
 	return -ENOBUFS;
 }
@@ -78,7 +78,7 @@ static inline int nfs_fscache_read_page(struct inode *inode, struct page *page)
 static inline void nfs_fscache_write_page(struct inode *inode,
 					   struct page *page)
 {
-	if (nfs_i_fscache(inode))
+	if (netfs_inode(inode)->cache)
 		__nfs_fscache_write_page(inode, page);
 }
 
@@ -101,13 +101,10 @@ static inline void nfs_fscache_update_auxdata(struct nfs_fscache_inode_auxdata *
 static inline void nfs_fscache_invalidate(struct inode *inode, int flags)
 {
 	struct nfs_fscache_inode_auxdata auxdata;
-	struct nfs_inode *nfsi = NFS_I(inode);
+	struct fscache_cookie *cookie =  netfs_i_cookie(&NFS_I(inode)->netfs);
 
-	if (nfsi->fscache) {
-		nfs_fscache_update_auxdata(&auxdata, inode);
-		fscache_invalidate(nfsi->fscache, &auxdata,
-				   i_size_read(inode), flags);
-	}
+	nfs_fscache_update_auxdata(&auxdata, inode);
+	fscache_invalidate(cookie, &auxdata, i_size_read(inode), flags);
 }
 
 /*
diff --git a/fs/nfs/inode.c b/fs/nfs/inode.c
index bea7c005119c..aa2aec785ab5 100644
--- a/fs/nfs/inode.c
+++ b/fs/nfs/inode.c
@@ -1411,7 +1411,7 @@ int nfs_revalidate_mapping(struct inode *inode, struct address_space *mapping)
 
 static bool nfs_file_has_writers(struct nfs_inode *nfsi)
 {
-	struct inode *inode = &nfsi->vfs_inode;
+	struct inode *inode = VFS_I(nfsi);
 
 	if (!S_ISREG(inode->i_mode))
 		return false;
@@ -2249,7 +2249,7 @@ struct inode *nfs_alloc_inode(struct super_block *sb)
 #ifdef CONFIG_NFS_V4_2
 	nfsi->xattr_cache = NULL;
 #endif
-	return &nfsi->vfs_inode;
+	return VFS_I(nfsi);
 }
 EXPORT_SYMBOL_GPL(nfs_alloc_inode);
 
@@ -2273,7 +2273,7 @@ static void init_once(void *foo)
 {
 	struct nfs_inode *nfsi = (struct nfs_inode *) foo;
 
-	inode_init_once(&nfsi->vfs_inode);
+	inode_init_once(VFS_I(nfsi));
 	INIT_LIST_HEAD(&nfsi->open_files);
 	INIT_LIST_HEAD(&nfsi->access_cache_entry_lru);
 	INIT_LIST_HEAD(&nfsi->access_cache_inode_lru);
diff --git a/fs/nfs/internal.h b/fs/nfs/internal.h
index 898dd95bc7a7..4d240ac4430f 100644
--- a/fs/nfs/internal.h
+++ b/fs/nfs/internal.h
@@ -355,7 +355,7 @@ nfs4_label_copy(struct nfs4_label *dst, struct nfs4_label *src)
 
 static inline void nfs_zap_label_cache_locked(struct nfs_inode *nfsi)
 {
-	if (nfs_server_capable(&nfsi->vfs_inode, NFS_CAP_SECURITY_LABEL))
+	if (nfs_server_capable(VFS_I(nfsi), NFS_CAP_SECURITY_LABEL))
 		nfsi->cache_validity |= NFS_INO_INVALID_LABEL;
 }
 #else
diff --git a/fs/nfs/pnfs.c b/fs/nfs/pnfs.c
index 2613b7e36eb9..035bf2eac2cf 100644
--- a/fs/nfs/pnfs.c
+++ b/fs/nfs/pnfs.c
@@ -763,19 +763,19 @@ static struct pnfs_layout_hdr *__pnfs_destroy_layout(struct nfs_inode *nfsi)
 	struct pnfs_layout_hdr *lo;
 	LIST_HEAD(tmp_list);
 
-	spin_lock(&nfsi->vfs_inode.i_lock);
+	spin_lock(&VFS_I(nfsi)->i_lock);
 	lo = nfsi->layout;
 	if (lo) {
 		pnfs_get_layout_hdr(lo);
 		pnfs_mark_layout_stateid_invalid(lo, &tmp_list);
 		pnfs_layout_clear_fail_bit(lo, NFS_LAYOUT_RO_FAILED);
 		pnfs_layout_clear_fail_bit(lo, NFS_LAYOUT_RW_FAILED);
-		spin_unlock(&nfsi->vfs_inode.i_lock);
+		spin_unlock(&VFS_I(nfsi)->i_lock);
 		pnfs_free_lseg_list(&tmp_list);
-		nfs_commit_inode(&nfsi->vfs_inode, 0);
+		nfs_commit_inode(VFS_I(nfsi), 0);
 		pnfs_put_layout_hdr(lo);
 	} else
-		spin_unlock(&nfsi->vfs_inode.i_lock);
+		spin_unlock(&VFS_I(nfsi)->i_lock);
 	return lo;
 }
 
@@ -790,9 +790,9 @@ static bool pnfs_layout_removed(struct nfs_inode *nfsi,
 {
 	bool ret;
 
-	spin_lock(&nfsi->vfs_inode.i_lock);
+	spin_lock(&VFS_I(nfsi)->i_lock);
 	ret = nfsi->layout != lo;
-	spin_unlock(&nfsi->vfs_inode.i_lock);
+	spin_unlock(&VFS_I(nfsi)->i_lock);
 	return ret;
 }
 
diff --git a/fs/nfs/write.c b/fs/nfs/write.c
index f41d24b54fd1..911569022036 100644
--- a/fs/nfs/write.c
+++ b/fs/nfs/write.c
@@ -828,7 +828,7 @@ nfs_page_search_commits_for_head_request_locked(struct nfs_inode *nfsi,
 {
 	struct nfs_page *freq, *t;
 	struct nfs_commit_info cinfo;
-	struct inode *inode = &nfsi->vfs_inode;
+	struct inode *inode = VFS_I(nfsi);
 
 	nfs_init_cinfo_from_inode(&cinfo, inode);
 
diff --git a/include/linux/nfs_fs.h b/include/linux/nfs_fs.h
index 7931fa472561..a1c402e26abf 100644
--- a/include/linux/nfs_fs.h
+++ b/include/linux/nfs_fs.h
@@ -31,6 +31,10 @@
 #include <linux/sunrpc/auth.h>
 #include <linux/sunrpc/clnt.h>
 
+#ifdef CONFIG_NFS_FSCACHE
+#include <linux/netfs.h>
+#endif
+
 #include <linux/nfs.h>
 #include <linux/nfs2.h>
 #include <linux/nfs3.h>
@@ -204,9 +208,11 @@ struct nfs_inode {
 	__u64 write_io;
 	__u64 read_io;
 #ifdef CONFIG_NFS_FSCACHE
-	struct fscache_cookie	*fscache;
-#endif
+	struct netfs_inode	netfs; /* netfs context and VFS inode */
+#else
 	struct inode		vfs_inode;
+#endif
+
 
 #ifdef CONFIG_NFS_V4_2
 	struct nfs4_xattr_cache *xattr_cache;
@@ -281,10 +287,25 @@ struct nfs4_copy_state {
 #define NFS_INO_LAYOUTSTATS	(11)		/* layoutstats inflight */
 #define NFS_INO_ODIRECT		(12)		/* I/O setting is O_DIRECT */
 
+#ifdef CONFIG_NFS_FSCACHE
+static inline struct inode *VFS_I(struct nfs_inode *nfsi)
+{
+	return &nfsi->netfs.inode;
+}
+static inline struct nfs_inode *NFS_I(const struct inode *inode)
+{
+	return container_of(inode, struct nfs_inode, netfs.inode);
+}
+#else
+static inline struct inode *VFS_I(struct nfs_inode *nfsi)
+{
+	return &nfsi->vfs_inode;
+}
 static inline struct nfs_inode *NFS_I(const struct inode *inode)
 {
 	return container_of(inode, struct nfs_inode, vfs_inode);
 }
+#endif
 
 static inline struct nfs_server *NFS_SB(const struct super_block *s)
 {
@@ -328,15 +349,6 @@ static inline int NFS_STALE(const struct inode *inode)
 	return test_bit(NFS_INO_STALE, &NFS_I(inode)->flags);
 }
 
-static inline struct fscache_cookie *nfs_i_fscache(struct inode *inode)
-{
-#ifdef CONFIG_NFS_FSCACHE
-	return NFS_I(inode)->fscache;
-#else
-	return NULL;
-#endif
-}
-
 static inline __u64 NFS_FILEID(const struct inode *inode)
 {
 	return NFS_I(inode)->fileid;
-- 
2.31.1


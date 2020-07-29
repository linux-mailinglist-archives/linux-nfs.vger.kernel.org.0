Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C267232009
	for <lists+linux-nfs@lfdr.de>; Wed, 29 Jul 2020 16:12:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726588AbgG2OMy (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 29 Jul 2020 10:12:54 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:39524 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726645AbgG2OMx (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 29 Jul 2020 10:12:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1596031971;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:in-reply-to:in-reply-to:references:references;
        bh=OEvXUB7+nnqY6Bf6r/qAtTnRx+9OfM/BWyZCP5Z9p1c=;
        b=FuQH/u9VtsojIi/xO3qVHSkU4JRF/a+gGh6qxJe7hWRlyzUQk5/WrQ0ztYVo7v1X3ZriKU
        5n+62avT/QtZBCB8yD3RSXiMyoHDFbvPthxS5TXJwT7WLgn9vopFdluZnb3940aqxFMAwA
        V3RGhuPOTBmNwS4S2hKVXrCgpHVOsE4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-229-ocyx5_FzPbyX7ouvMJA_bA-1; Wed, 29 Jul 2020 10:12:50 -0400
X-MC-Unique: ocyx5_FzPbyX7ouvMJA_bA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E593A18C63C1;
        Wed, 29 Jul 2020 14:12:48 +0000 (UTC)
Received: from dwysocha.rdu.csb (ovpn-113-23.rdu2.redhat.com [10.10.113.23])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 6C90371927;
        Wed, 29 Jul 2020 14:12:48 +0000 (UTC)
From:   Dave Wysochanski <dwysocha@redhat.com>
To:     Trond Myklebust <trondmy@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>
Cc:     linux-nfs@vger.kernel.org, linux-cachefs@redhat.com
Subject: [RFC PATCH v2 12/14] NFS: Invalidate fscache for direct writes
Date:   Wed, 29 Jul 2020 10:12:27 -0400
Message-Id: <1596031949-26793-13-git-send-email-dwysocha@redhat.com>
In-Reply-To: <1596031949-26793-1-git-send-email-dwysocha@redhat.com>
References: <1596031949-26793-1-git-send-email-dwysocha@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

We must call into fscache to invalidate when doing a direct write.
This fixes issues seen with NFSv4.x when direct writes are
followed by non-direct (buffered) reads.

Signed-off-by: Dave Wysochanski <dwysocha@redhat.com>
---
 fs/nfs/direct.c   | 2 ++
 fs/nfs/file.c     | 2 +-
 fs/nfs/fscache.h  | 6 +++---
 fs/nfs/inode.c    | 2 +-
 fs/nfs/nfs4proc.c | 2 +-
 fs/nfs/write.c    | 2 +-
 6 files changed, 9 insertions(+), 7 deletions(-)

diff --git a/fs/nfs/direct.c b/fs/nfs/direct.c
index 3d113cf8908a..3360e161dbf1 100644
--- a/fs/nfs/direct.c
+++ b/fs/nfs/direct.c
@@ -59,6 +59,7 @@
 #include "internal.h"
 #include "iostat.h"
 #include "pnfs.h"
+#include "fscache.h"
 
 #define NFSDBG_FACILITY		NFSDBG_VFS
 
@@ -967,6 +968,7 @@ ssize_t nfs_file_direct_write(struct kiocb *iocb, struct iov_iter *iter)
 	} else {
 		result = requested;
 	}
+	nfs_fscache_invalidate(inode, FSCACHE_INVAL_DIO_WRITE);
 out_release:
 	nfs_direct_req_release(dreq);
 out:
diff --git a/fs/nfs/file.c b/fs/nfs/file.c
index 7af528c423c0..0f65617f84c9 100644
--- a/fs/nfs/file.c
+++ b/fs/nfs/file.c
@@ -414,7 +414,7 @@ static void nfs_invalidate_page(struct page *page, unsigned int offset,
 	/* Cancel any unstarted writes on this page */
 	nfs_wb_page_cancel(page_file_mapping(page)->host, page);
 	wait_on_page_fscache(page);
-	nfs_fscache_invalidate(page_file_mapping(page)->host);
+	nfs_fscache_invalidate(page_file_mapping(page)->host, 0);
 }
 
 /*
diff --git a/fs/nfs/fscache.h b/fs/nfs/fscache.h
index de060f61cadd..7bc2f364a931 100644
--- a/fs/nfs/fscache.h
+++ b/fs/nfs/fscache.h
@@ -150,7 +150,7 @@ static inline void nfs_fscache_update_auxdata(struct nfs_fscache_inode_auxdata *
 /*
  * Invalidate the contents of fscache for this inode.  This will not sleep.
  */
-static inline void nfs_fscache_invalidate(struct inode *inode)
+static inline void nfs_fscache_invalidate(struct inode *inode, int flags)
 {
 	struct nfs_fscache_inode_auxdata auxdata;
 	struct nfs_inode *nfsi = NFS_I(inode);
@@ -158,7 +158,7 @@ static inline void nfs_fscache_invalidate(struct inode *inode)
 	if (nfsi->fscache) {
 		nfs_fscache_update_auxdata(&auxdata, nfsi);
 		fscache_invalidate(nfsi->fscache, &auxdata,
-				   i_size_read(&nfsi->vfs_inode), 0);
+				   i_size_read(&nfsi->vfs_inode), flags);
 	}
 }
 
@@ -202,7 +202,7 @@ static inline int nfs_readpages_from_fscache(struct nfs_open_context *ctx,
 static inline void nfs_read_completion_to_fscache(struct nfs_pgio_header *hdr,
 						  unsigned long bytes) {}
 
-static inline void nfs_fscache_invalidate(struct inode *inode) {}
+static inline void nfs_fscache_invalidate(struct inode *inode, int flags) {}
 
 static inline const char *nfs_server_fscache_state(struct nfs_server *server)
 {
diff --git a/fs/nfs/inode.c b/fs/nfs/inode.c
index b9a84f1c1a5c..45067303348c 100644
--- a/fs/nfs/inode.c
+++ b/fs/nfs/inode.c
@@ -211,7 +211,7 @@ static void nfs_set_cache_invalid(struct inode *inode, unsigned long flags)
 		flags &= ~(NFS_INO_INVALID_DATA|NFS_INO_DATA_INVAL_DEFER);
 	nfsi->cache_validity |= flags;
 	if (flags & NFS_INO_INVALID_DATA)
-		nfs_fscache_invalidate(inode);
+		nfs_fscache_invalidate(inode, 0);
 }
 
 /*
diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
index e32717fd1169..2602fd633e56 100644
--- a/fs/nfs/nfs4proc.c
+++ b/fs/nfs/nfs4proc.c
@@ -1179,7 +1179,7 @@ int nfs4_call_sync(struct rpc_clnt *clnt,
 	nfsi->read_cache_jiffies = timestamp;
 	nfsi->attr_gencount = nfs_inc_attr_generation_counter();
 	nfsi->cache_validity &= ~NFS_INO_INVALID_CHANGE;
-	nfs_fscache_invalidate(dir);
+	nfs_fscache_invalidate(dir, 0);
 }
 
 static void
diff --git a/fs/nfs/write.c b/fs/nfs/write.c
index 2da99814da51..0de914a581d2 100644
--- a/fs/nfs/write.c
+++ b/fs/nfs/write.c
@@ -290,7 +290,7 @@ static void nfs_grow_file(struct page *page, unsigned int offset, unsigned int c
 		goto out;
 	i_size_write(inode, end);
 	NFS_I(inode)->cache_validity &= ~NFS_INO_INVALID_SIZE;
-	nfs_fscache_invalidate(inode);
+	nfs_fscache_invalidate(inode, 0);
 	nfs_inc_stats(inode, NFSIOS_EXTENDWRITE);
 out:
 	spin_unlock(&inode->i_lock);
-- 
1.8.3.1


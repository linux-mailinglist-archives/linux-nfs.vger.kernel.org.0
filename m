Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0837D455042
	for <lists+linux-nfs@lfdr.de>; Wed, 17 Nov 2021 23:17:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241122AbhKQWUh (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 17 Nov 2021 17:20:37 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:20373 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S241100AbhKQWUb (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 17 Nov 2021 17:20:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1637187451;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:in-reply-to:in-reply-to:references:references;
        bh=xQ6iKQZQtc7CTqbxnTiODglbU3U62vLPUGjbNOBca1c=;
        b=QGhbB54QShZzl0eTLpTtOoBYf6DmGCEId/pNgcRxBcH8VOu0udpK6YYppVUmncE9q7+DnP
        6lwa/AN9nHgcyCLUMGtcNLZyBz8Usj3y6AhSXaUZsAt7jQ71lFCXDseNnylqITNmeWrFhB
        eh/lRn4dXsKi8AUFywwVbSSsuSa4RlM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-561-rNo1vwZ4NLWH8BmzqH4XvA-1; Wed, 17 Nov 2021 17:17:30 -0500
X-MC-Unique: rNo1vwZ4NLWH8BmzqH4XvA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id F2ECF101796A;
        Wed, 17 Nov 2021 22:17:28 +0000 (UTC)
Received: from dwysocha.rdu.csb (unknown [10.22.32.4])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 7255C604CC;
        Wed, 17 Nov 2021 22:17:28 +0000 (UTC)
From:   Dave Wysochanski <dwysocha@redhat.com>
To:     Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>
Cc:     linux-nfs@vger.kernel.org, linux-cachefs@redhat.com
Subject: [PATCH 6/7] NFS: Remove remaining dfprintks related to fscache cookies
Date:   Wed, 17 Nov 2021 17:17:17 -0500
Message-Id: <1637187438-18858-7-git-send-email-dwysocha@redhat.com>
In-Reply-To: <1637187438-18858-1-git-send-email-dwysocha@redhat.com>
References: <1637187438-18858-1-git-send-email-dwysocha@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

The fscache cookie APIs including fscache_acquire_cookie() and
fscache_relinquish_cookie() now have very good tracing.  Thus,
there is no real need for dfprintks in the NFS fscache interface.

Signed-off-by: Dave Wysochanski <dwysocha@redhat.com>
---
 fs/nfs/fscache.c | 14 +-------------
 1 file changed, 1 insertion(+), 13 deletions(-)

diff --git a/fs/nfs/fscache.c b/fs/nfs/fscache.c
index f4147a7915bd..e62629feeebf 100644
--- a/fs/nfs/fscache.c
+++ b/fs/nfs/fscache.c
@@ -21,7 +21,7 @@
 #include "fscache.h"
 #include "nfstrace.h"
 
-#define NFSDBG_FACILITY		NFSDBG_FSCACHE
+#define NFSDBG_FACILITY                NFSDBG_FSCACHE
 
 static struct rb_root nfs_fscache_keys = RB_ROOT;
 static DEFINE_SPINLOCK(nfs_fscache_keys_lock);
@@ -86,8 +86,6 @@ void nfs_fscache_get_client_cookie(struct nfs_client *clp)
 					      &key, len,
 					      NULL, 0,
 					      clp, 0, true);
-	dfprintk(FSCACHE, "NFS: get client cookie (0x%p/0x%p)\n",
-		 clp, clp->fscache);
 }
 
 /*
@@ -95,9 +93,6 @@ void nfs_fscache_get_client_cookie(struct nfs_client *clp)
  */
 void nfs_fscache_release_client_cookie(struct nfs_client *clp)
 {
-	dfprintk(FSCACHE, "NFS: releasing client cookie (0x%p/0x%p)\n",
-		 clp, clp->fscache);
-
 	fscache_relinquish_cookie(clp->fscache, NULL, false);
 	clp->fscache = NULL;
 }
@@ -191,8 +186,6 @@ void nfs_fscache_get_super_cookie(struct super_block *sb, const char *uniq, int
 					       sizeof(key->key) + ulen,
 					       NULL, 0,
 					       nfss, 0, true);
-	dfprintk(FSCACHE, "NFS: get superblock cookie (0x%p/0x%p)\n",
-		 nfss, nfss->fscache);
 	return;
 
 non_unique:
@@ -211,9 +204,6 @@ void nfs_fscache_release_super_cookie(struct super_block *sb)
 {
 	struct nfs_server *nfss = NFS_SB(sb);
 
-	dfprintk(FSCACHE, "NFS: releasing superblock cookie (0x%p/0x%p)\n",
-		 nfss, nfss->fscache);
-
 	fscache_relinquish_cookie(nfss->fscache, NULL, false);
 	nfss->fscache = NULL;
 
@@ -270,8 +260,6 @@ void nfs_fscache_clear_inode(struct inode *inode)
 	struct nfs_inode *nfsi = NFS_I(inode);
 	struct fscache_cookie *cookie = nfs_i_fscache(inode);
 
-	dfprintk(FSCACHE, "NFS: clear cookie (0x%p/0x%p)\n", nfsi, cookie);
-
 	nfs_fscache_update_auxdata(&auxdata, inode);
 	fscache_relinquish_cookie(cookie, &auxdata, false);
 	nfsi->fscache = NULL;
-- 
1.8.3.1


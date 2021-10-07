Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE16B425FE0
	for <lists+linux-nfs@lfdr.de>; Fri,  8 Oct 2021 00:30:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237789AbhJGWcm (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 7 Oct 2021 18:32:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:57239 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237851AbhJGWcm (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 7 Oct 2021 18:32:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1633645847;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:in-reply-to:in-reply-to:references:references;
        bh=VwP53MOpEB/A+FJpyjVAhqtYpx2FWz2rkQMWE88KFTw=;
        b=VCdAn4nGbN0ODOQHvT2hXNZjgT+kvSYy8p/8txed+nbPkWYiTjMjeaCLmsUvPA7L18XC1/
        yYfkxGEr+9ElNnTgBt/nhuW++w9zSjTn0bJ0GeWpaqGDwQD9K8EnxsWNx6aWGs+CsKS8zA
        +GpeakMqk8QWRjBZlHxrDbHb15bNOIw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-380-moFmOo0lMDGtz7gnWylcfA-1; Thu, 07 Oct 2021 18:30:46 -0400
X-MC-Unique: moFmOo0lMDGtz7gnWylcfA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 527D91005E53;
        Thu,  7 Oct 2021 22:30:45 +0000 (UTC)
Received: from dwysocha.rdu.csb (unknown [10.22.8.139])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id B59155D9C6;
        Thu,  7 Oct 2021 22:30:44 +0000 (UTC)
From:   Dave Wysochanski <dwysocha@redhat.com>
To:     Trond Myklebust <trondmy@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        David Howells <dhowells@redhat.com>
Cc:     linux-cachefs@redhat.com, linux-nfs@vger.kernel.org
Subject: [PATCH v2  2/7] NFS: Cleanup usage of nfs_inode in fscache interface and handle i_size properly
Date:   Thu,  7 Oct 2021 18:30:18 -0400
Message-Id: <1633645823-31235-3-git-send-email-dwysocha@redhat.com>
In-Reply-To: <1633645823-31235-1-git-send-email-dwysocha@redhat.com>
References: <1633645823-31235-1-git-send-email-dwysocha@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

A number of places in the fscache interface used nfs_inode when inode could
be used, simplifying the code.  Also, handle the read of i_size properly by
utilizing the i_size_read() interface.

Signed-off-by: Dave Wysochanski <dwysocha@redhat.com>
---
 fs/nfs/fscache.c | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/fs/nfs/fscache.c b/fs/nfs/fscache.c
index 68e266a37675..6764938eca2d 100644
--- a/fs/nfs/fscache.c
+++ b/fs/nfs/fscache.c
@@ -226,16 +226,16 @@ void nfs_fscache_release_super_cookie(struct super_block *sb)
 }
 
 static void nfs_fscache_update_auxdata(struct nfs_fscache_inode_auxdata *auxdata,
-				  struct nfs_inode *nfsi)
+				  struct inode *inode)
 {
 	memset(auxdata, 0, sizeof(*auxdata));
-	auxdata->mtime_sec  = nfsi->vfs_inode.i_mtime.tv_sec;
-	auxdata->mtime_nsec = nfsi->vfs_inode.i_mtime.tv_nsec;
-	auxdata->ctime_sec  = nfsi->vfs_inode.i_ctime.tv_sec;
-	auxdata->ctime_nsec = nfsi->vfs_inode.i_ctime.tv_nsec;
+	auxdata->mtime_sec  = inode->i_mtime.tv_sec;
+	auxdata->mtime_nsec = inode->i_mtime.tv_nsec;
+	auxdata->ctime_sec  = inode->i_ctime.tv_sec;
+	auxdata->ctime_nsec = inode->i_ctime.tv_nsec;
 
-	if (NFS_SERVER(&nfsi->vfs_inode)->nfs_client->rpc_ops->version == 4)
-		auxdata->change_attr = inode_peek_iversion_raw(&nfsi->vfs_inode);
+	if (NFS_SERVER(inode)->nfs_client->rpc_ops->version == 4)
+		auxdata->change_attr = inode_peek_iversion_raw(inode);
 }
 
 /*
@@ -251,13 +251,13 @@ void nfs_fscache_init_inode(struct inode *inode)
 	if (!(nfss->fscache && S_ISREG(inode->i_mode)))
 		return;
 
-	nfs_fscache_update_auxdata(&auxdata, nfsi);
+	nfs_fscache_update_auxdata(&auxdata, inode);
 
 	nfsi->fscache = fscache_acquire_cookie(NFS_SB(inode->i_sb)->fscache,
 					       &nfs_fscache_inode_object_def,
 					       nfsi->fh.data, nfsi->fh.size,
 					       &auxdata, sizeof(auxdata),
-					       nfsi, nfsi->vfs_inode.i_size, false);
+					       nfsi, i_size_read(inode), false);
 }
 
 /*
@@ -271,7 +271,7 @@ void nfs_fscache_clear_inode(struct inode *inode)
 
 	dfprintk(FSCACHE, "NFS: clear cookie (0x%p/0x%p)\n", nfsi, cookie);
 
-	nfs_fscache_update_auxdata(&auxdata, nfsi);
+	nfs_fscache_update_auxdata(&auxdata, inode);
 	fscache_relinquish_cookie(cookie, &auxdata, false);
 	nfsi->fscache = NULL;
 }
@@ -311,7 +311,7 @@ void nfs_fscache_open_file(struct inode *inode, struct file *filp)
 	if (!fscache_cookie_valid(cookie))
 		return;
 
-	nfs_fscache_update_auxdata(&auxdata, nfsi);
+	nfs_fscache_update_auxdata(&auxdata, inode);
 
 	if (inode_is_open_for_write(inode)) {
 		dfprintk(FSCACHE, "NFS: nfsi 0x%p disabling cache\n", nfsi);
@@ -319,7 +319,7 @@ void nfs_fscache_open_file(struct inode *inode, struct file *filp)
 		fscache_disable_cookie(cookie, &auxdata, true);
 	} else {
 		dfprintk(FSCACHE, "NFS: nfsi 0x%p enabling cache\n", nfsi);
-		fscache_enable_cookie(cookie, &auxdata, nfsi->vfs_inode.i_size,
+		fscache_enable_cookie(cookie, &auxdata, i_size_read(inode),
 				      nfs_fscache_can_enable, inode);
 		if (fscache_cookie_enabled(cookie))
 			set_bit(NFS_INO_FSCACHE, &NFS_I(inode)->flags);
-- 
1.8.3.1


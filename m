Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE1924C947D
	for <lists+linux-nfs@lfdr.de>; Tue,  1 Mar 2022 20:39:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233997AbiCATkT (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 1 Mar 2022 14:40:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232698AbiCATkS (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 1 Mar 2022 14:40:18 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 991876548D
        for <linux-nfs@vger.kernel.org>; Tue,  1 Mar 2022 11:39:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1646163576;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=e0KgLgtwFr3FN/v3VNOvDtoqjUN4st8DSRar4DJnQMc=;
        b=DGUDpwx1RkidQZt6D4by2I2hB7uT5x6j9Rye6TZ6NGi/ALy3KD/AX0mnJiIR4fuWVJLOEO
        ZQDGqtw3tdi/qw1lEp1N341/HRdCxV6GWgOor/bqpVzXhtQm4ENofBAlU79fKGA9oGwTAO
        GuzlW8Nt1/d6IimGoZ6kRO0xNW4XDPQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-436-mVFVv3otOTqOhyEs-HY66g-1; Tue, 01 Mar 2022 14:38:32 -0500
X-MC-Unique: mVFVv3otOTqOhyEs-HY66g-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B523051DF;
        Tue,  1 Mar 2022 19:38:31 +0000 (UTC)
Received: from dwysocha.rdu.csb (unknown [10.22.9.75])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 293825DF5F;
        Tue,  1 Mar 2022 19:38:21 +0000 (UTC)
From:   Dave Wysochanski <dwysocha@redhat.com>
To:     Anna Schumaker <anna.schumaker@netapp.com>,
        Trond Myklebust <trond.myklebust@hammerspace.com>
Cc:     linux-nfs@vger.kernel.org, linux-cachefs@redhat.com,
        David Howells <dhowells@redhat.com>
Subject: [PATCH 1/4] NFS: Cleanup usage of nfs_inode in fscache interface
Date:   Tue,  1 Mar 2022 14:37:24 -0500
Message-Id: <20220301193727.18847-2-dwysocha@redhat.com>
In-Reply-To: <20220301193727.18847-1-dwysocha@redhat.com>
References: <20220301193727.18847-1-dwysocha@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

A number of places in the fscache interface used nfs_inode when inode could
be used, simplifying the code.

Signed-off-by: Dave Wysochanski <dwysocha@redhat.com>
---
 fs/nfs/fscache.c | 10 ++++------
 fs/nfs/fscache.h | 18 +++++++++---------
 2 files changed, 13 insertions(+), 15 deletions(-)

diff --git a/fs/nfs/fscache.c b/fs/nfs/fscache.c
index cfe901650ab0..81bd2770e640 100644
--- a/fs/nfs/fscache.c
+++ b/fs/nfs/fscache.c
@@ -173,7 +173,7 @@ void nfs_fscache_init_inode(struct inode *inode)
 	if (!(nfss->fscache && S_ISREG(inode->i_mode)))
 		return;
 
-	nfs_fscache_update_auxdata(&auxdata, nfsi);
+	nfs_fscache_update_auxdata(&auxdata, inode);
 
 	nfsi->fscache = fscache_acquire_cookie(NFS_SB(inode->i_sb)->fscache,
 					       0,
@@ -181,7 +181,7 @@ void nfs_fscache_init_inode(struct inode *inode)
 					       nfsi->fh.size,
 					       &auxdata,      /* aux_data */
 					       sizeof(auxdata),
-					       i_size_read(&nfsi->vfs_inode));
+					       i_size_read(inode));
 }
 
 /*
@@ -220,7 +220,6 @@ void nfs_fscache_clear_inode(struct inode *inode)
 void nfs_fscache_open_file(struct inode *inode, struct file *filp)
 {
 	struct nfs_fscache_inode_auxdata auxdata;
-	struct nfs_inode *nfsi = NFS_I(inode);
 	struct fscache_cookie *cookie = nfs_i_fscache(inode);
 	bool open_for_write = inode_is_open_for_write(inode);
 
@@ -230,7 +229,7 @@ void nfs_fscache_open_file(struct inode *inode, struct file *filp)
 	fscache_use_cookie(cookie, open_for_write);
 	if (open_for_write) {
 		dfprintk(FSCACHE, "NFS: nfsi 0x%p disabling cache\n", nfsi);
-		nfs_fscache_update_auxdata(&auxdata, nfsi);
+		nfs_fscache_update_auxdata(&auxdata, inode);
 		fscache_invalidate(cookie, &auxdata, i_size_read(inode),
 				   FSCACHE_INVAL_DIO_WRITE);
 	}
@@ -240,11 +239,10 @@ EXPORT_SYMBOL_GPL(nfs_fscache_open_file);
 void nfs_fscache_release_file(struct inode *inode, struct file *filp)
 {
 	struct nfs_fscache_inode_auxdata auxdata;
-	struct nfs_inode *nfsi = NFS_I(inode);
 	struct fscache_cookie *cookie = nfs_i_fscache(inode);
 
 	if (fscache_cookie_valid(cookie)) {
-		nfs_fscache_update_auxdata(&auxdata, nfsi);
+		nfs_fscache_update_auxdata(&auxdata, inode);
 		fscache_unuse_cookie(cookie, &auxdata, NULL);
 	}
 }
diff --git a/fs/nfs/fscache.h b/fs/nfs/fscache.h
index 25a5c0f82392..4c7afaabbf9f 100644
--- a/fs/nfs/fscache.h
+++ b/fs/nfs/fscache.h
@@ -86,16 +86,16 @@ static inline void nfs_readpage_to_fscache(struct inode *inode,
 }
 
 static inline void nfs_fscache_update_auxdata(struct nfs_fscache_inode_auxdata *auxdata,
-					      struct nfs_inode *nfsi)
+					      struct inode *inode)
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
@@ -107,9 +107,9 @@ static inline void nfs_fscache_invalidate(struct inode *inode, int flags)
 	struct nfs_inode *nfsi = NFS_I(inode);
 
 	if (nfsi->fscache) {
-		nfs_fscache_update_auxdata(&auxdata, nfsi);
+		nfs_fscache_update_auxdata(&auxdata, inode);
 		fscache_invalidate(nfsi->fscache, &auxdata,
-				   i_size_read(&nfsi->vfs_inode), flags);
+				   i_size_read(inode), flags);
 	}
 }
 
-- 
2.27.1


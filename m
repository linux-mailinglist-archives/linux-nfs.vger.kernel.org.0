Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F379479321
	for <lists+linux-nfs@lfdr.de>; Fri, 17 Dec 2021 18:54:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236385AbhLQRyf (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 17 Dec 2021 12:54:35 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:40678 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231992AbhLQRyf (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 17 Dec 2021 12:54:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1639763674;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:in-reply-to:in-reply-to:references:references;
        bh=n56siCSCuZNu29/l9NA7eBhaGmxhQZok8r+y2KxWe2U=;
        b=jDNqZo5S7XKOB1UAiTtUN2qKbR++lOX1sdRCzOfwZuUajvGG55V6RJiIsEgxiRWRVm8kdC
        DTghSyEPkMvqoap6vcrO9AEA7es2aVDuc4hPmPCQZ/VdDGOlLVBZtx+r3GXwE9GUsgqeMw
        4a77uCm7Tb7MHHVGc/sxgQp4Ya9OfgE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-31-aNKVcbF_MXemHELMBY17dA-1; Fri, 17 Dec 2021 12:54:33 -0500
X-MC-Unique: aNKVcbF_MXemHELMBY17dA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D55D71018720;
        Fri, 17 Dec 2021 17:54:31 +0000 (UTC)
Received: from dwysocha.rdu.csb (unknown [10.22.8.133])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 671E41037F39;
        Fri, 17 Dec 2021 17:54:31 +0000 (UTC)
From:   Dave Wysochanski <dwysocha@redhat.com>
To:     Anna Schumaker <anna.schumaker@netapp.com>,
        David Howells <dhowells@redhat.com>
Cc:     linux-nfs@vger.kernel.org, linux-cachefs@redhat.com
Subject: [PATCH v2 1/4] NFS: Cleanup usage of nfs_inode in fscache interface and handle i_size properly
Date:   Fri, 17 Dec 2021 12:54:22 -0500
Message-Id: <1639763665-4917-2-git-send-email-dwysocha@redhat.com>
In-Reply-To: <1639763665-4917-1-git-send-email-dwysocha@redhat.com>
References: <1639763665-4917-1-git-send-email-dwysocha@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

A number of places in the fscache interface used nfs_inode when inode could
be used, simplifying the code.  Also, handle the read of i_size properly by
utilizing the i_size_read() interface.

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
@@ -240,11 +239,10 @@ void nfs_fscache_open_file(struct inode *inode, struct file *filp)
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
index e0220fc40366..5cf7238e4886 100644
--- a/fs/nfs/fscache.h
+++ b/fs/nfs/fscache.h
@@ -85,16 +85,16 @@ static inline void nfs_readpage_to_fscache(struct inode *inode,
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
@@ -106,9 +106,9 @@ static inline void nfs_fscache_invalidate(struct inode *inode, int flags)
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
1.8.3.1


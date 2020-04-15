Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1444A1AB261
	for <lists+linux-nfs@lfdr.de>; Wed, 15 Apr 2020 22:17:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2441993AbgDOUOw (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 15 Apr 2020 16:14:52 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:23766 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S2436830AbgDOUOv (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 15 Apr 2020 16:14:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1586981689;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:in-reply-to:in-reply-to:references:references;
        bh=U5T9k80rrJDjitBUyKTVAYoM2U+n8HqD4IGf0Foilmw=;
        b=Uk5C/Cz49512Jri995DVexntaf2lT9VWzWGrCQXwdhGSU+9bzi6rkIDLiQEgbs+Z4/FsJi
        sRD6xSBvOXPI1NctA9pqR/iyOkuKPb1pvS9XX08SU4ZRA6L3gQMVWIuydmyl3yPt6ieboD
        Mlb3XxMMNkuzpCf9tXmO0ZkqhCDWKiY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-99-s_O79nprNeK-UhnpE2T-0w-1; Wed, 15 Apr 2020 16:14:47 -0400
X-MC-Unique: s_O79nprNeK-UhnpE2T-0w-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id BFE761005513
        for <linux-nfs@vger.kernel.org>; Wed, 15 Apr 2020 20:14:46 +0000 (UTC)
Received: from dwysocha.rdu.csb (ovpn-112-216.rdu2.redhat.com [10.10.112.216])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 6D842A63D6;
        Wed, 15 Apr 2020 20:14:46 +0000 (UTC)
From:   Dave Wysochanski <dwysocha@redhat.com>
To:     dhowells@redhat.com, linux-nfs@vger.kernel.org
Subject: [PATCH 3/3] NFSv4: Fix fscache cookie aux_data to ensure change_attr is included
Date:   Wed, 15 Apr 2020 16:14:43 -0400
Message-Id: <1586981683-3077-3-git-send-email-dwysocha@redhat.com>
In-Reply-To: <1586981683-3077-1-git-send-email-dwysocha@redhat.com>
References: <1586981683-3077-1-git-send-email-dwysocha@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Commit 402cb8dda949 ("fscache: Attach the index key and aux data to
the cookie") added the aux_data and aux_data_len to parameters to
fscache_acquire_cookie(), and updated the callers in the NFS client.
In the process it modified the aux_data to include the change_attr,
but missed adding change_attr to a couple places where aux_data was
used.  Specifically, when opening a file and the change_attr is not
added, the following attempt to lookup an object will fail inside
cachefiles_check_object_xattr() = -116 due to
nfs_fscache_inode_check_aux() failing memcmp on auxdata and returning
FSCACHE_CHECKAUX_OBSOLETE.

Fix this by adding nfs_fscache_update_auxdata() to set the auxdata
from all relevant fields in the inode, including the change_attr.

Fixes: 402cb8dda949 ("fscache: Attach the index key and aux data to the cookie")
Signed-off-by: Dave Wysochanski <dwysocha@redhat.com>
---
 fs/nfs/fscache.c | 34 ++++++++++++++++------------------
 1 file changed, 16 insertions(+), 18 deletions(-)

diff --git a/fs/nfs/fscache.c b/fs/nfs/fscache.c
index f51718415606..e3240f9f9570 100644
--- a/fs/nfs/fscache.c
+++ b/fs/nfs/fscache.c
@@ -225,6 +225,19 @@ void nfs_fscache_release_super_cookie(struct super_block *sb)
 	}
 }
 
+static nfs_fscache_update_auxdata(struct nfs_fscache_inode_auxdata *auxdata,
+				  struct nfs_inode *nfsi)
+{
+	memset(auxdata, 0, sizeof(*auxdata));
+	auxdata->mtime_sec  = nfsi->vfs_inode.i_mtime.tv_sec;
+	auxdata->mtime_nsec = nfsi->vfs_inode.i_mtime.tv_nsec;
+	auxdata->ctime_sec  = nfsi->vfs_inode.i_ctime.tv_sec;
+	auxdata->ctime_nsec = nfsi->vfs_inode.i_ctime.tv_nsec;
+
+	if (NFS_SERVER(&nfsi->vfs_inode)->nfs_client->rpc_ops->version == 4)
+		auxdata->change_attr = inode_peek_iversion_raw(&nfsi->vfs_inode);
+}
+
 /*
  * Initialise the per-inode cache cookie pointer for an NFS inode.
  */
@@ -238,14 +251,7 @@ void nfs_fscache_init_inode(struct inode *inode)
 	if (!(nfss->fscache && S_ISREG(inode->i_mode)))
 		return;
 
-	memset(&auxdata, 0, sizeof(auxdata));
-	auxdata.mtime_sec  = nfsi->vfs_inode.i_mtime.tv_sec;
-	auxdata.mtime_nsec = nfsi->vfs_inode.i_mtime.tv_nsec;
-	auxdata.ctime_sec  = nfsi->vfs_inode.i_ctime.tv_sec;
-	auxdata.ctime_nsec = nfsi->vfs_inode.i_ctime.tv_nsec;
-
-	if (NFS_SERVER(&nfsi->vfs_inode)->nfs_client->rpc_ops->version == 4)
-		auxdata.change_attr = inode_peek_iversion_raw(&nfsi->vfs_inode);
+	nfs_fscache_update_auxdata(&auxdata, nfsi);
 
 	nfsi->fscache = fscache_acquire_cookie(NFS_SB(inode->i_sb)->fscache,
 					       &nfs_fscache_inode_object_def,
@@ -265,11 +271,7 @@ void nfs_fscache_clear_inode(struct inode *inode)
 
 	dfprintk(FSCACHE, "NFS: clear cookie (0x%p/0x%p)\n", nfsi, cookie);
 
-	memset(&auxdata, 0, sizeof(auxdata));
-	auxdata.mtime_sec  = nfsi->vfs_inode.i_mtime.tv_sec;
-	auxdata.mtime_nsec = nfsi->vfs_inode.i_mtime.tv_nsec;
-	auxdata.ctime_sec  = nfsi->vfs_inode.i_ctime.tv_sec;
-	auxdata.ctime_nsec = nfsi->vfs_inode.i_ctime.tv_nsec;
+	nfs_fscache_update_auxdata(&auxdata, nfsi);
 	fscache_relinquish_cookie(cookie, &auxdata, false);
 	nfsi->fscache = NULL;
 }
@@ -309,11 +311,7 @@ void nfs_fscache_open_file(struct inode *inode, struct file *filp)
 	if (!fscache_cookie_valid(cookie))
 		return;
 
-	memset(&auxdata, 0, sizeof(auxdata));
-	auxdata.mtime_sec  = nfsi->vfs_inode.i_mtime.tv_sec;
-	auxdata.mtime_nsec = nfsi->vfs_inode.i_mtime.tv_nsec;
-	auxdata.ctime_sec  = nfsi->vfs_inode.i_ctime.tv_sec;
-	auxdata.ctime_nsec = nfsi->vfs_inode.i_ctime.tv_nsec;
+	nfs_fscache_update_auxdata(&auxdata, nfsi);
 
 	if (inode_is_open_for_write(inode)) {
 		dfprintk(FSCACHE, "NFS: nfsi 0x%p disabling cache\n", nfsi);
-- 
1.8.3.1


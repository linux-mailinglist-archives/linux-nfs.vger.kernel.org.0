Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3013C1ABD8E
	for <lists+linux-nfs@lfdr.de>; Thu, 16 Apr 2020 12:06:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2504704AbgDPKGV (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 16 Apr 2020 06:06:21 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:31810 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2504706AbgDPKGQ (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 16 Apr 2020 06:06:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1587031573;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc; bh=ATfoQl4JvbUU7lHAEAmxYMWCFvGqdCs55ii+BLfprRc=;
        b=b912E6MeGsO3eQgx38oHjYLMXjWSEakGfgdFRQMhboGTEpQ28WshD7T2uk7aNDhjuxepq+
        HYFX+0w2UgzYHaqyMfZRiFPS97egngdL7o2U7nCKG5BnvoARwMKZ+bnZ0TcaGb04skx0eg
        NNqnmUr5l4MHrN4DZup1wEDRmsh1Sv0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-67-ZLOG4qF0OG6Cdf_mmu6tcA-1; Thu, 16 Apr 2020 06:06:12 -0400
X-MC-Unique: ZLOG4qF0OG6Cdf_mmu6tcA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 47227802561
        for <linux-nfs@vger.kernel.org>; Thu, 16 Apr 2020 10:06:10 +0000 (UTC)
Received: from dwysocha.rdu.csb (ovpn-113-89.rdu2.redhat.com [10.10.113.89])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id D9212272A0;
        Thu, 16 Apr 2020 10:06:09 +0000 (UTC)
From:   Dave Wysochanski <dwysocha@redhat.com>
To:     linux-nfs@vger.kernel.org
Cc:     dhowells@redhat.com
Subject: [PATCH v2 3/3] NFSv4: Fix fscache cookie aux_data to ensure change_attr is included
Date:   Thu, 16 Apr 2020 06:06:08 -0400
Message-Id: <1587031568-32604-1-git-send-email-dwysocha@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
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
index f51718415606..a60df88efc40 100644
--- a/fs/nfs/fscache.c
+++ b/fs/nfs/fscache.c
@@ -225,6 +225,19 @@ void nfs_fscache_release_super_cookie(struct super_block *sb)
 	}
 }
 
+static void nfs_fscache_update_auxdata(struct nfs_fscache_inode_auxdata *auxdata,
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


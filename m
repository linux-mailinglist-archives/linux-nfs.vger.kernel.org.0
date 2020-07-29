Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B39123200B
	for <lists+linux-nfs@lfdr.de>; Wed, 29 Jul 2020 16:12:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726645AbgG2OMy (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 29 Jul 2020 10:12:54 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:42594 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726709AbgG2OMw (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 29 Jul 2020 10:12:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1596031970;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:in-reply-to:in-reply-to:references:references;
        bh=JL86MRqbOhkSNC37WeqtZR+WxVEMOY86ANujSLh0r0c=;
        b=KICnoZ2JkiFdp5xDn1sxZb1jCZ77dPRAPcBAt01YasU7JVhfXcXMJGi5wYQkzII7Ev777n
        vPJw36CLiPPebcdWtp/to5bmLK2e4iPTBqYmKjZxGLazXGJIIH9uByCsjHMzMfZXBQHpjq
        1TAXBODW8lAgnEUyGq3IlZTA8QjertY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-129-uXQBHt3nODqw4pjwgjqcSA-1; Wed, 29 Jul 2020 10:12:47 -0400
X-MC-Unique: uXQBHt3nODqw4pjwgjqcSA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4CD2218C63C1;
        Wed, 29 Jul 2020 14:12:46 +0000 (UTC)
Received: from dwysocha.rdu.csb (ovpn-113-23.rdu2.redhat.com [10.10.113.23])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id C682A71920;
        Wed, 29 Jul 2020 14:12:45 +0000 (UTC)
From:   Dave Wysochanski <dwysocha@redhat.com>
To:     Trond Myklebust <trondmy@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>
Cc:     linux-nfs@vger.kernel.org, linux-cachefs@redhat.com
Subject: [RFC PATCH v2 08/14] NFS: Convert fscache_acquire_cookie and fscache_relinquish_cookie
Date:   Wed, 29 Jul 2020 10:12:23 -0400
Message-Id: <1596031949-26793-9-git-send-email-dwysocha@redhat.com>
In-Reply-To: <1596031949-26793-1-git-send-email-dwysocha@redhat.com>
References: <1596031949-26793-1-git-send-email-dwysocha@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

The new FS-Cache netfs API changes the cookie API slightly.

The changes to fscache_acquire_cookie are:
* remove struct fscache_cookie_def
* add 'type' of cookie (was member of fscache_cookie_def)
* add 'name' of cookie (was member of fscache_cookie_def)
* add 'advice' flags (tells cache how to handle object); set to 0
* add 'preferred_cache' tag (if NULL, derive from parent)
* remove 'netfs_data'
* remove 'enable' (See fscache_use_cookie())

The changes to fscache_relinquish_cookie are:
* remove 'aux_data'

Signed-off-by: Dave Wysochanski <dwysocha@redhat.com>
---
 fs/nfs/fscache-index.c | 94 --------------------------------------------------
 fs/nfs/fscache.c       | 56 +++++++++++++++++-------------
 fs/nfs/fscache.h       |  3 --
 3 files changed, 32 insertions(+), 121 deletions(-)

diff --git a/fs/nfs/fscache-index.c b/fs/nfs/fscache-index.c
index b1049815729e..b4fdacd955f3 100644
--- a/fs/nfs/fscache-index.c
+++ b/fs/nfs/fscache-index.c
@@ -44,97 +44,3 @@ void nfs_fscache_unregister(void)
 {
 	fscache_unregister_netfs(&nfs_fscache_netfs);
 }
-
-/*
- * Define the server object for FS-Cache.  This is used to describe a server
- * object to fscache_acquire_cookie().  It is keyed by the NFS protocol and
- * server address parameters.
- */
-const struct fscache_cookie_def nfs_fscache_server_index_def = {
-	.name		= "NFS.server",
-	.type 		= FSCACHE_COOKIE_TYPE_INDEX,
-};
-
-/*
- * Define the superblock object for FS-Cache.  This is used to describe a
- * superblock object to fscache_acquire_cookie().  It is keyed by all the NFS
- * parameters that might cause a separate superblock.
- */
-const struct fscache_cookie_def nfs_fscache_super_index_def = {
-	.name		= "NFS.super",
-	.type 		= FSCACHE_COOKIE_TYPE_INDEX,
-};
-
-/*
- * Consult the netfs about the state of an object
- * - This function can be absent if the index carries no state data
- * - The netfs data from the cookie being used as the target is
- *   presented, as is the auxiliary data
- */
-static
-enum fscache_checkaux nfs_fscache_inode_check_aux(void *cookie_netfs_data,
-						  const void *data,
-						  uint16_t datalen,
-						  loff_t object_size)
-{
-	struct nfs_fscache_inode_auxdata auxdata;
-	struct nfs_inode *nfsi = cookie_netfs_data;
-
-	if (datalen != sizeof(auxdata))
-		return FSCACHE_CHECKAUX_OBSOLETE;
-
-	memset(&auxdata, 0, sizeof(auxdata));
-	auxdata.mtime_sec  = nfsi->vfs_inode.i_mtime.tv_sec;
-	auxdata.mtime_nsec = nfsi->vfs_inode.i_mtime.tv_nsec;
-	auxdata.ctime_sec  = nfsi->vfs_inode.i_ctime.tv_sec;
-	auxdata.ctime_nsec = nfsi->vfs_inode.i_ctime.tv_nsec;
-
-	if (NFS_SERVER(&nfsi->vfs_inode)->nfs_client->rpc_ops->version == 4)
-		auxdata.change_attr = inode_peek_iversion_raw(&nfsi->vfs_inode);
-
-	if (memcmp(data, &auxdata, datalen) != 0)
-		return FSCACHE_CHECKAUX_OBSOLETE;
-
-	return FSCACHE_CHECKAUX_OKAY;
-}
-
-/*
- * Get an extra reference on a read context.
- * - This function can be absent if the completion function doesn't require a
- *   context.
- * - The read context is passed back to NFS in the event that a data read on the
- *   cache fails with EIO - in which case the server must be contacted to
- *   retrieve the data, which requires the read context for security.
- */
-static void nfs_fh_get_context(void *context)
-{
-	get_nfs_open_context(context);
-}
-
-/*
- * Release an extra reference on a read context.
- * - This function can be absent if the completion function doesn't require a
- *   context.
- */
-static void nfs_fh_put_context(void *context)
-{
-	if (context)
-		put_nfs_open_context(context);
-}
-
-/*
- * Define the inode object for FS-Cache.  This is used to describe an inode
- * object to fscache_acquire_cookie().  It is keyed by the NFS file handle for
- * an inode.
- *
- * Coherency is managed by comparing the copies of i_size, i_mtime and i_ctime
- * held in the cache auxiliary data for the data storage object with those in
- * the inode struct in memory.
- */
-const struct fscache_cookie_def nfs_fscache_inode_object_def = {
-	.name		= "NFS.fh",
-	.type		= FSCACHE_COOKIE_TYPE_DATAFILE,
-	.check_aux	= nfs_fscache_inode_check_aux,
-	.get_context	= nfs_fh_get_context,
-	.put_context	= nfs_fh_put_context,
-};
diff --git a/fs/nfs/fscache.c b/fs/nfs/fscache.c
index f641f33fa632..1c4ced273fb7 100644
--- a/fs/nfs/fscache.c
+++ b/fs/nfs/fscache.c
@@ -81,10 +81,15 @@ void nfs_fscache_get_client_cookie(struct nfs_client *clp)
 
 	/* create a cache index for looking up filehandles */
 	clp->fscache = fscache_acquire_cookie(nfs_fscache_netfs.primary_index,
-					      &nfs_fscache_server_index_def,
-					      &key, len,
-					      NULL, 0,
-					      clp, 0, true);
+					      FSCACHE_COOKIE_TYPE_INDEX,
+					      "NFS.server",
+					      0,    /* advice */
+					      NULL, /* preferred_cache */
+					      &key, /* index_key */
+					      len,
+					      NULL, /* aux_data */
+					      0,
+					      0);
 	dfprintk(FSCACHE, "NFS: get client cookie (0x%p/0x%p)\n",
 		 clp, clp->fscache);
 }
@@ -97,7 +102,7 @@ void nfs_fscache_release_client_cookie(struct nfs_client *clp)
 	dfprintk(FSCACHE, "NFS: releasing client cookie (0x%p/0x%p)\n",
 		 clp, clp->fscache);
 
-	fscache_relinquish_cookie(clp->fscache, NULL, false);
+	fscache_relinquish_cookie(clp->fscache, false);
 	clp->fscache = NULL;
 }
 
@@ -185,11 +190,15 @@ void nfs_fscache_get_super_cookie(struct super_block *sb, const char *uniq, int
 
 	/* create a cache index for looking up filehandles */
 	nfss->fscache = fscache_acquire_cookie(nfss->nfs_client->fscache,
-					       &nfs_fscache_super_index_def,
-					       &key->key,
+					       FSCACHE_COOKIE_TYPE_INDEX,
+					       "NFS.super",
+					       0,    /* advice */
+					       NULL, /* preferred_cache */
+					       &key->key,  /* index_key */
 					       sizeof(key->key) + ulen,
-					       NULL, 0,
-					       nfss, 0, true);
+					       NULL, /* aux_data */
+					       0,
+					       0);
 	dfprintk(FSCACHE, "NFS: get superblock cookie (0x%p/0x%p)\n",
 		 nfss, nfss->fscache);
 	return;
@@ -213,7 +222,7 @@ void nfs_fscache_release_super_cookie(struct super_block *sb)
 	dfprintk(FSCACHE, "NFS: releasing superblock cookie (0x%p/0x%p)\n",
 		 nfss, nfss->fscache);
 
-	fscache_relinquish_cookie(nfss->fscache, NULL, false);
+	fscache_relinquish_cookie(nfss->fscache, false);
 	nfss->fscache = NULL;
 
 	if (nfss->fscache_key) {
@@ -254,10 +263,15 @@ void nfs_fscache_init_inode(struct inode *inode)
 	nfs_fscache_update_auxdata(&auxdata, nfsi);
 
 	nfsi->fscache = fscache_acquire_cookie(NFS_SB(inode->i_sb)->fscache,
-					       &nfs_fscache_inode_object_def,
-					       nfsi->fh.data, nfsi->fh.size,
-					       &auxdata, sizeof(auxdata),
-					       nfsi, nfsi->vfs_inode.i_size, false);
+					       FSCACHE_COOKIE_TYPE_DATAFILE,
+					       "NFS.fh",
+					       0,             /* advice */
+					       NULL, /* preferred_cache */
+					       nfsi->fh.data, /* index_key */
+					       nfsi->fh.size,
+					       &auxdata,      /* aux_data */
+					       sizeof(auxdata),
+					       i_size_read(&nfsi->vfs_inode));
 }
 
 /*
@@ -272,7 +286,8 @@ void nfs_fscache_clear_inode(struct inode *inode)
 	dfprintk(FSCACHE, "NFS: clear cookie (0x%p/0x%p)\n", nfsi, cookie);
 
 	nfs_fscache_update_auxdata(&auxdata, nfsi);
-	fscache_relinquish_cookie(cookie, &auxdata, false);
+	fscache_unuse_cookie(cookie, &auxdata, NULL);
+	fscache_relinquish_cookie(cookie, false);
 	nfsi->fscache = NULL;
 }
 
@@ -304,27 +319,20 @@ static bool nfs_fscache_can_enable(void *data)
  */
 void nfs_fscache_open_file(struct inode *inode, struct file *filp)
 {
-	struct nfs_fscache_inode_auxdata auxdata;
 	struct nfs_inode *nfsi = NFS_I(inode);
 	struct fscache_cookie *cookie = nfs_i_fscache(inode);
 
 	if (!fscache_cookie_valid(cookie))
 		return;
 
-	nfs_fscache_update_auxdata(&auxdata, nfsi);
-
 	if (inode_is_open_for_write(inode)) {
 		dfprintk(FSCACHE, "NFS: nfsi 0x%p disabling cache\n", nfsi);
 		clear_bit(NFS_INO_FSCACHE, &nfsi->flags);
-		fscache_disable_cookie(cookie, &auxdata, true);
-		fscache_uncache_all_inode_pages(cookie, inode);
 	} else {
 		dfprintk(FSCACHE, "NFS: nfsi 0x%p enabling cache\n", nfsi);
-		fscache_enable_cookie(cookie, &auxdata, nfsi->vfs_inode.i_size,
-				      nfs_fscache_can_enable, inode);
-		if (fscache_cookie_enabled(cookie))
-			set_bit(NFS_INO_FSCACHE, &NFS_I(inode)->flags);
+		set_bit(NFS_INO_FSCACHE, &NFS_I(inode)->flags);
 	}
+	fscache_use_cookie(cookie, false);
 }
 EXPORT_SYMBOL_GPL(nfs_fscache_open_file);
 
diff --git a/fs/nfs/fscache.h b/fs/nfs/fscache.h
index d61721832838..95a1b29946a0 100644
--- a/fs/nfs/fscache.h
+++ b/fs/nfs/fscache.h
@@ -73,9 +73,6 @@ struct nfs_fscache_inode_auxdata {
  * fscache-index.c
  */
 extern struct fscache_netfs nfs_fscache_netfs;
-extern const struct fscache_cookie_def nfs_fscache_server_index_def;
-extern const struct fscache_cookie_def nfs_fscache_super_index_def;
-extern const struct fscache_cookie_def nfs_fscache_inode_object_def;
 
 extern int nfs_fscache_register(void);
 extern void nfs_fscache_unregister(void);
-- 
1.8.3.1


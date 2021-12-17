Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ECA51479322
	for <lists+linux-nfs@lfdr.de>; Fri, 17 Dec 2021 18:54:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231992AbhLQRyg (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 17 Dec 2021 12:54:36 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:23759 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S239469AbhLQRyg (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 17 Dec 2021 12:54:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1639763675;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:in-reply-to:in-reply-to:references:references;
        bh=d6m0f5PInfp/LFKopMFyKi/+OjEfN3a4miJD/pgiaEY=;
        b=GmP+zmC6hPWF1h3io/Ls6yanbxX28Rr0OO7fu9cTrtTByRzB+q+UpAtQl6a0lnCavCsa42
        OkHl5x8OsujjSvUHcQaF5aLv3MkGnaR6i3biZWSaAECDH0GEOxLUa9/gXnVoOgleREQqzl
        FRNTnDR1eqVcr440lqC35+P/bV3BI30=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-482-6MzjahqEM-K-UI-erCjDag-1; Fri, 17 Dec 2021 12:54:34 -0500
X-MC-Unique: 6MzjahqEM-K-UI-erCjDag-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 97D5A192AB6E;
        Fri, 17 Dec 2021 17:54:33 +0000 (UTC)
Received: from dwysocha.rdu.csb (unknown [10.22.8.133])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 283831037F39;
        Fri, 17 Dec 2021 17:54:33 +0000 (UTC)
From:   Dave Wysochanski <dwysocha@redhat.com>
To:     Anna Schumaker <anna.schumaker@netapp.com>,
        David Howells <dhowells@redhat.com>
Cc:     linux-nfs@vger.kernel.org, linux-cachefs@redhat.com
Subject: [PATCH v2 4/4] NFS: Remove remaining dfprintks related to fscache and remove NFSDBG_FSCACHE
Date:   Fri, 17 Dec 2021 12:54:25 -0500
Message-Id: <1639763665-4917-5-git-send-email-dwysocha@redhat.com>
In-Reply-To: <1639763665-4917-1-git-send-email-dwysocha@redhat.com>
References: <1639763665-4917-1-git-send-email-dwysocha@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

The fscache cookie APIs including fscache_acquire_cookie() and
fscache_relinquish_cookie() now have very good tracing.  Thus,
there is no real need for dfprintks in the NFS fscache interface.

The NFS fscache interface has removed all dfprintks so remove the
NFSDBG_FSCACHE defines.

Signed-off-by: Dave Wysochanski <dwysocha@redhat.com>
---
 fs/nfs/fscache.c            | 10 ----------
 include/uapi/linux/nfs_fs.h |  2 +-
 2 files changed, 1 insertion(+), 11 deletions(-)

diff --git a/fs/nfs/fscache.c b/fs/nfs/fscache.c
index 841b69aef189..4dee53ceb941 100644
--- a/fs/nfs/fscache.c
+++ b/fs/nfs/fscache.c
@@ -21,8 +21,6 @@
 #include "fscache.h"
 #include "nfstrace.h"
 
-#define NFSDBG_FACILITY		NFSDBG_FSCACHE
-
 #define NFS_MAX_KEY_LEN 1000
 
 static bool nfs_append_int(char *key, int *_len, unsigned long long x)
@@ -129,8 +127,6 @@ int nfs_fscache_get_super_cookie(struct super_block *sb, const char *uniq, int u
 	vcookie = fscache_acquire_volume(key,
 					 NULL, /* preferred_cache */
 					 NULL, 0 /* coherency_data */);
-	dfprintk(FSCACHE, "NFS: get superblock cookie (0x%p/0x%p)\n",
-		 nfss, vcookie);
 	if (IS_ERR(vcookie)) {
 		if (vcookie != ERR_PTR(-EBUSY)) {
 			kfree(key);
@@ -153,9 +149,6 @@ void nfs_fscache_release_super_cookie(struct super_block *sb)
 {
 	struct nfs_server *nfss = NFS_SB(sb);
 
-	dfprintk(FSCACHE, "NFS: releasing superblock cookie (0x%p/0x%p)\n",
-		 nfss, nfss->fscache);
-
 	fscache_relinquish_volume(nfss->fscache, NULL, false);
 	nfss->fscache = NULL;
 	kfree(nfss->fscache_uniq);
@@ -193,8 +186,6 @@ void nfs_fscache_clear_inode(struct inode *inode)
 	struct nfs_inode *nfsi = NFS_I(inode);
 	struct fscache_cookie *cookie = nfs_i_fscache(inode);
 
-	dfprintk(FSCACHE, "NFS: clear cookie (0x%p/0x%p)\n", nfsi, cookie);
-
 	fscache_relinquish_cookie(cookie, false);
 	nfsi->fscache = NULL;
 }
@@ -229,7 +220,6 @@ void nfs_fscache_open_file(struct inode *inode, struct file *filp)
 
 	fscache_use_cookie(cookie, open_for_write);
 	if (open_for_write) {
-		dfprintk(FSCACHE, "NFS: nfsi 0x%p disabling cache\n", nfsi);
 		nfs_fscache_update_auxdata(&auxdata, inode);
 		fscache_invalidate(cookie, &auxdata, i_size_read(inode),
 				   FSCACHE_INVAL_DIO_WRITE);
diff --git a/include/uapi/linux/nfs_fs.h b/include/uapi/linux/nfs_fs.h
index 3afe3767c55d..ae0de165c014 100644
--- a/include/uapi/linux/nfs_fs.h
+++ b/include/uapi/linux/nfs_fs.h
@@ -52,7 +52,7 @@
 #define NFSDBG_CALLBACK		0x0100
 #define NFSDBG_CLIENT		0x0200
 #define NFSDBG_MOUNT		0x0400
-#define NFSDBG_FSCACHE		0x0800
+#define NFSDBG_FSCACHE		0x0800 /* unused */
 #define NFSDBG_PNFS		0x1000
 #define NFSDBG_PNFS_LD		0x2000
 #define NFSDBG_STATE		0x4000
-- 
1.8.3.1


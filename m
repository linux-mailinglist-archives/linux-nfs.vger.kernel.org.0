Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A9296455039
	for <lists+linux-nfs@lfdr.de>; Wed, 17 Nov 2021 23:17:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235740AbhKQWUc (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 17 Nov 2021 17:20:32 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:42946 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S241114AbhKQWU3 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 17 Nov 2021 17:20:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1637187450;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:in-reply-to:in-reply-to:references:references;
        bh=V3xk2uMkZUHA6BFszuCc/n5rTazQuUPLq0prC5wwXdQ=;
        b=LEbwmG8Val7pLaJHsQZP3egqgbDug+2cv/VG5GGmeQR4h6TbHN+R+GeXJG2UtRAfiKNPWP
        GEtXUIPsPBB2r+mFbtrKpdWMFanJEhJy4DRx59F0I4ExM3yZ4EpAanF/rMbdfsLltH7fGu
        v4wZJwOQ+Z/1Or3+2jDnS23xYdwZt1w=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-92-jzDaRRx5NyyIDANdpfp_7A-1; Wed, 17 Nov 2021 17:17:28 -0500
X-MC-Unique: jzDaRRx5NyyIDANdpfp_7A-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9A8DA180832A;
        Wed, 17 Nov 2021 22:17:27 +0000 (UTC)
Received: from dwysocha.rdu.csb (unknown [10.22.32.4])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 1B6D160657;
        Wed, 17 Nov 2021 22:17:27 +0000 (UTC)
From:   Dave Wysochanski <dwysocha@redhat.com>
To:     Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>
Cc:     linux-nfs@vger.kernel.org, linux-cachefs@redhat.com
Subject: [PATCH 4/7] NFS: Convert NFS fscache enable/disable dfprintks to tracepoints
Date:   Wed, 17 Nov 2021 17:17:15 -0500
Message-Id: <1637187438-18858-5-git-send-email-dwysocha@redhat.com>
In-Reply-To: <1637187438-18858-1-git-send-email-dwysocha@redhat.com>
References: <1637187438-18858-1-git-send-email-dwysocha@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Convert the enable / disable NFS fscache dfprintks to tracepoints.
Utilize the existing NFS inode trace event class, which allows us
to keep the same output format to other NFS inode tracepoints.

Signed-off-by: Dave Wysochanski <dwysocha@redhat.com>
---
 fs/nfs/fscache.c  | 5 +++--
 fs/nfs/nfstrace.h | 2 ++
 2 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/fs/nfs/fscache.c b/fs/nfs/fscache.c
index cb701d9c4e47..913a29f2b9e4 100644
--- a/fs/nfs/fscache.c
+++ b/fs/nfs/fscache.c
@@ -19,6 +19,7 @@
 #include "internal.h"
 #include "iostat.h"
 #include "fscache.h"
+#include "nfstrace.h"
 
 #define NFSDBG_FACILITY		NFSDBG_FSCACHE
 
@@ -314,12 +315,12 @@ void nfs_fscache_open_file(struct inode *inode, struct file *filp)
 	nfs_fscache_update_auxdata(&auxdata, inode);
 
 	if (inode_is_open_for_write(inode)) {
-		dfprintk(FSCACHE, "NFS: nfsi 0x%p disabling cache\n", nfsi);
+		trace_nfs_fscache_disable_inode(inode);
 		clear_bit(NFS_INO_FSCACHE, &nfsi->flags);
 		fscache_disable_cookie(cookie, &auxdata, true);
 		fscache_uncache_all_inode_pages(cookie, inode);
 	} else {
-		dfprintk(FSCACHE, "NFS: nfsi 0x%p enabling cache\n", nfsi);
+		trace_nfs_fscache_enable_inode(inode);
 		fscache_enable_cookie(cookie, &auxdata, i_size_read(inode),
 				      nfs_fscache_can_enable, inode);
 		if (fscache_cookie_enabled(cookie))
diff --git a/fs/nfs/nfstrace.h b/fs/nfs/nfstrace.h
index 21dac847f1e4..2da68adda88f 100644
--- a/fs/nfs/nfstrace.h
+++ b/fs/nfs/nfstrace.h
@@ -144,6 +144,8 @@
 				int error \
 			), \
 			TP_ARGS(inode, error))
+DEFINE_NFS_INODE_EVENT(nfs_fscache_enable_inode);
+DEFINE_NFS_INODE_EVENT(nfs_fscache_disable_inode);
 DEFINE_NFS_INODE_EVENT(nfs_set_inode_stale);
 DEFINE_NFS_INODE_EVENT(nfs_refresh_inode_enter);
 DEFINE_NFS_INODE_EVENT_DONE(nfs_refresh_inode_exit);
-- 
1.8.3.1


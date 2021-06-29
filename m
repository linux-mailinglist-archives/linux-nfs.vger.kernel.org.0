Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A0013B76FC
	for <lists+linux-nfs@lfdr.de>; Tue, 29 Jun 2021 19:14:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232257AbhF2RQc (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 29 Jun 2021 13:16:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:53721 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232235AbhF2RQc (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 29 Jun 2021 13:16:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1624986844;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc; bh=U0jqB/CqSbq3scsWM4pYXIbTpsUMBS/luX6jycl5qp4=;
        b=PsTNmlLiCicnOmVESiEFsOm3rbuE03qpOw7U2CSamp/efAPAJuujQH2+dtOrvx0cA7IljR
        84z5XYCQLbNqBi47niM5rBdxB9mUxtfGFwXd6/Tx3ci2IxHa952MAtX+bYgXJyGzXe0PpE
        bw3/VJM71UxD3gDaRl9yt+SqlMzuYxw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-485-mXG8vKRtNeCbgcCPbGeSMQ-1; Tue, 29 Jun 2021 13:14:02 -0400
X-MC-Unique: mXG8vKRtNeCbgcCPbGeSMQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 578B8802CB4;
        Tue, 29 Jun 2021 17:14:01 +0000 (UTC)
Received: from dwysocha.rdu.csb (unknown [10.22.8.151])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id A64905C1D0;
        Tue, 29 Jun 2021 17:13:59 +0000 (UTC)
From:   Dave Wysochanski <dwysocha@redhat.com>
To:     Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH v3] NFS: Fix fscache read from NFS after cache error
Date:   Tue, 29 Jun 2021 13:13:57 -0400
Message-Id: <1624986837-17880-1-git-send-email-dwysocha@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Earlier commits refactored some NFS read code and removed
nfs_readpage_async(), but neglected to properly fixup
nfs_readpage_from_fscache_complete().  The code path is
only hit when something unusual occurs with the cachefiles
backing filesystem, such as an IO error or while a cookie
is being invalidated.

Mark page with PG_checked if fscache IO completes in error,
unlock the page, and let the VM decide to re-issue based on
PG_uptodate.  When the VM reissues the readpage, PG_checked
allows us to skip over fscache and read from the server.

Link: https://marc.info/?l=linux-nfs&m=162498209518739
Fixes: 1e83b173b266 ("NFS: Add nfs_pageio_complete_read() and remove nfs_readpage_async()")
Signed-off-by: Dave Wysochanski <dwysocha@redhat.com>
---
 fs/nfs/fscache.c | 18 +++++++++++++-----
 fs/nfs/read.c    |  5 +++--
 2 files changed, 16 insertions(+), 7 deletions(-)

diff --git a/fs/nfs/fscache.c b/fs/nfs/fscache.c
index c4c021c6ebbd..d743629e05e1 100644
--- a/fs/nfs/fscache.c
+++ b/fs/nfs/fscache.c
@@ -385,12 +385,15 @@ static void nfs_readpage_from_fscache_complete(struct page *page,
 		 "NFS: readpage_from_fscache_complete (0x%p/0x%p/%d)\n",
 		 page, context, error);
 
-	/* if the read completes with an error, we just unlock the page and let
-	 * the VM reissue the readpage */
-	if (!error) {
+	/*
+	 * If the read completes with an error, mark the page with PG_checked,
+	 * unlock the page, and let the VM reissue the readpage.
+	 */
+	if (!error)
 		SetPageUptodate(page);
-		unlock_page(page);
-	}
+	else
+		SetPageChecked(page);
+	unlock_page(page);
 }
 
 /*
@@ -405,6 +408,11 @@ int __nfs_readpage_from_fscache(struct nfs_open_context *ctx,
 		 "NFS: readpage_from_fscache(fsc:%p/p:%p(i:%lx f:%lx)/0x%p)\n",
 		 nfs_i_fscache(inode), page, page->index, page->flags, inode);
 
+	if (PageChecked(page)) {
+		ClearPageChecked(page);
+		return 1;
+	}
+
 	ret = fscache_read_or_alloc_page(nfs_i_fscache(inode),
 					 page,
 					 nfs_readpage_from_fscache_complete,
diff --git a/fs/nfs/read.c b/fs/nfs/read.c
index eb390eb618b3..9f39e0a1a38b 100644
--- a/fs/nfs/read.c
+++ b/fs/nfs/read.c
@@ -362,13 +362,13 @@ int nfs_readpage(struct file *file, struct page *page)
 	} else
 		desc.ctx = get_nfs_open_context(nfs_file_open_context(file));
 
+	xchg(&desc.ctx->error, 0);
 	if (!IS_SYNC(inode)) {
 		ret = nfs_readpage_from_fscache(desc.ctx, inode, page);
 		if (ret == 0)
-			goto out;
+			goto out_wait;
 	}
 
-	xchg(&desc.ctx->error, 0);
 	nfs_pageio_init_read(&desc.pgio, inode, false,
 			     &nfs_async_read_completion_ops);
 
@@ -378,6 +378,7 @@ int nfs_readpage(struct file *file, struct page *page)
 
 	nfs_pageio_complete_read(&desc.pgio);
 	ret = desc.pgio.pg_error < 0 ? desc.pgio.pg_error : 0;
+out_wait:
 	if (!ret) {
 		ret = wait_on_page_locked_killable(page);
 		if (!PageUptodate(page) && !ret)
-- 
1.8.3.1


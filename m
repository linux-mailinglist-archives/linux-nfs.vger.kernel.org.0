Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9257B3B32A1
	for <lists+linux-nfs@lfdr.de>; Thu, 24 Jun 2021 17:34:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230087AbhFXPgp (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 24 Jun 2021 11:36:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:34098 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230008AbhFXPgo (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 24 Jun 2021 11:36:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1624548864;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc; bh=N1DIPxBge5DzT9XOd3tf+JmPdFZAHy3tRkvWC+ztfC4=;
        b=ZGWATdgLmpN0HWEP3NBoQ3W8GEhWHuUebDkIYwAN/lQjzzns58IE59XTFkHsCrFiy0JQFx
        TuGncYvp/LqGItgpMnIjyr3CvtTikI7of29qOE8unG4xT3/UakVadt5HESgcIsAZB+67du
        bhWoSuoKILSZTeotjm/9pRdY9t/lf1E=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-115-RIxrYCiSNJiiKaedC3YssQ-1; Thu, 24 Jun 2021 11:34:23 -0400
X-MC-Unique: RIxrYCiSNJiiKaedC3YssQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1DE5A801596;
        Thu, 24 Jun 2021 15:34:22 +0000 (UTC)
Received: from dwysocha.rdu.csb (unknown [10.22.8.151])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 7EBF719D7C;
        Thu, 24 Jun 2021 15:34:21 +0000 (UTC)
From:   Dave Wysochanski <dwysocha@redhat.com>
To:     Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH] NFS: Remove unnecessary inode parameter from nfs_pageio_complete_read()
Date:   Thu, 24 Jun 2021 11:34:18 -0400
Message-Id: <1624548858-29971-1-git-send-email-dwysocha@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Simplify nfs_pageio_complete_read() by using the inode pointer saved
inside nfs_pageio_descriptor.

Signed-off-by: Dave Wysochanski <dwysocha@redhat.com>
---
 fs/nfs/read.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/fs/nfs/read.c b/fs/nfs/read.c
index d2b6dce1f99f..684a730f6670 100644
--- a/fs/nfs/read.c
+++ b/fs/nfs/read.c
@@ -74,8 +74,7 @@ void nfs_pageio_init_read(struct nfs_pageio_descriptor *pgio,
 }
 EXPORT_SYMBOL_GPL(nfs_pageio_init_read);
 
-static void nfs_pageio_complete_read(struct nfs_pageio_descriptor *pgio,
-				     struct inode *inode)
+static void nfs_pageio_complete_read(struct nfs_pageio_descriptor *pgio)
 {
 	struct nfs_pgio_mirror *pgm;
 	unsigned long npages;
@@ -86,9 +85,9 @@ static void nfs_pageio_complete_read(struct nfs_pageio_descriptor *pgio,
 	WARN_ON_ONCE(pgio->pg_mirror_count != 1);
 
 	pgm = &pgio->pg_mirrors[0];
-	NFS_I(inode)->read_io += pgm->pg_bytes_written;
+	NFS_I(pgio->pg_inode)->read_io += pgm->pg_bytes_written;
 	npages = (pgm->pg_bytes_written + PAGE_SIZE - 1) >> PAGE_SHIFT;
-	nfs_add_stats(inode, NFSIOS_READPAGES, npages);
+	nfs_add_stats(pgio->pg_inode, NFSIOS_READPAGES, npages);
 }
 
 
@@ -376,7 +375,7 @@ int nfs_readpage(struct file *file, struct page *page)
 	ret = readpage_async_filler(&desc, page);
 
 	if (!ret)
-		nfs_pageio_complete_read(&desc.pgio, inode);
+		nfs_pageio_complete_read(&desc.pgio);
 
 	ret = desc.pgio.pg_error < 0 ? desc.pgio.pg_error : 0;
 	if (!ret) {
@@ -430,7 +429,7 @@ int nfs_readpages(struct file *file, struct address_space *mapping,
 
 	ret = read_cache_pages(mapping, pages, readpage_async_filler, &desc);
 
-	nfs_pageio_complete_read(&desc.pgio, inode);
+	nfs_pageio_complete_read(&desc.pgio);
 
 read_complete:
 	put_nfs_open_context(desc.ctx);
-- 
1.8.3.1


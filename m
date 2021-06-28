Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E27AB3B67C8
	for <lists+linux-nfs@lfdr.de>; Mon, 28 Jun 2021 19:39:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232709AbhF1Rlh (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 28 Jun 2021 13:41:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:35883 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232662AbhF1Rlg (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 28 Jun 2021 13:41:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1624901950;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:in-reply-to:in-reply-to:references:references;
        bh=N1DIPxBge5DzT9XOd3tf+JmPdFZAHy3tRkvWC+ztfC4=;
        b=MdiwJu/hj1lRfbJie6HX7+7sJYCVMZimI7zKIY9UGBv3gEmDCuVfa2SjEMrk++oOALGrsC
        cG4rM7ZRwpt5EPtOiu1PLufVhaf0QGHffvUUvUmX8dybCSvT6qExROD9Z4bTUlbd8ByWsi
        23mF1LkOyWlYTxD3DDVl9SMA9ib17lU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-572-dudhmtLxPMuLn19O2HVfiw-1; Mon, 28 Jun 2021 13:39:08 -0400
X-MC-Unique: dudhmtLxPMuLn19O2HVfiw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 861B11084F4B;
        Mon, 28 Jun 2021 17:39:07 +0000 (UTC)
Received: from dwysocha.rdu.csb (unknown [10.22.8.151])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 24E465DAA5;
        Mon, 28 Jun 2021 17:39:07 +0000 (UTC)
From:   Dave Wysochanski <dwysocha@redhat.com>
To:     Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH 1/4] NFS: Remove unnecessary inode parameter from nfs_pageio_complete_read()
Date:   Mon, 28 Jun 2021 13:39:00 -0400
Message-Id: <1624901943-20027-2-git-send-email-dwysocha@redhat.com>
In-Reply-To: <1624901943-20027-1-git-send-email-dwysocha@redhat.com>
References: <1624901943-20027-1-git-send-email-dwysocha@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
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


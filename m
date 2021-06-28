Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8945A3B67C7
	for <lists+linux-nfs@lfdr.de>; Mon, 28 Jun 2021 19:39:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229504AbhF1Rlh (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 28 Jun 2021 13:41:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:48191 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232853AbhF1Rlg (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 28 Jun 2021 13:41:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1624901950;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:in-reply-to:in-reply-to:references:references;
        bh=L227fX867HimSWRKqswjnRmPzv/ja3nLFneELtM3x1k=;
        b=bOiz+fWZt43p/0Nc9WvSnjhRufP5sjCzmzoxM8SjwL6l47e5b/6kyTrlDC1G6avaTcdKWL
        6gVR24rhZvmF0SpX6Oo2losK5SyaEH+zp9mGTdB7Ot8hxC14pyGTf/eWJypvTxBtATQE/C
        JBOGrf7j62YRPvSQSLbqBpmwGKIPd30=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-207-Xta5zbSdMzSccciLvdXGBQ-1; Mon, 28 Jun 2021 13:39:09 -0400
X-MC-Unique: Xta5zbSdMzSccciLvdXGBQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 15F54804141;
        Mon, 28 Jun 2021 17:39:08 +0000 (UTC)
Received: from dwysocha.rdu.csb (unknown [10.22.8.151])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id A817D5D9FC;
        Mon, 28 Jun 2021 17:39:07 +0000 (UTC)
From:   Dave Wysochanski <dwysocha@redhat.com>
To:     Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH 2/4] NFS: Ensure nfs_readpage returns promptly when internal error occurs
Date:   Mon, 28 Jun 2021 13:39:01 -0400
Message-Id: <1624901943-20027-3-git-send-email-dwysocha@redhat.com>
In-Reply-To: <1624901943-20027-1-git-send-email-dwysocha@redhat.com>
References: <1624901943-20027-1-git-send-email-dwysocha@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

A previous refactoring of nfs_readpage() might end up calling
wait_on_page_locked_killable() even if readpage_async_filler() failed
with an internal error and pg_error was non-zero (for example, if
nfs_create_request() failed).  In the case of an internal error,
skip over wait_on_page_locked_killable() as this is only needed
when the read is sent and an error occurs during completion handling.

Signed-off-by: Dave Wysochanski <dwysocha@redhat.com>
---
 fs/nfs/read.c | 21 ++++++++++++---------
 1 file changed, 12 insertions(+), 9 deletions(-)

diff --git a/fs/nfs/read.c b/fs/nfs/read.c
index 684a730f6670..b0680351df23 100644
--- a/fs/nfs/read.c
+++ b/fs/nfs/read.c
@@ -74,7 +74,7 @@ void nfs_pageio_init_read(struct nfs_pageio_descriptor *pgio,
 }
 EXPORT_SYMBOL_GPL(nfs_pageio_init_read);
 
-static void nfs_pageio_complete_read(struct nfs_pageio_descriptor *pgio)
+static int nfs_pageio_complete_read(struct nfs_pageio_descriptor *pgio)
 {
 	struct nfs_pgio_mirror *pgm;
 	unsigned long npages;
@@ -88,6 +88,8 @@ static void nfs_pageio_complete_read(struct nfs_pageio_descriptor *pgio)
 	NFS_I(pgio->pg_inode)->read_io += pgm->pg_bytes_written;
 	npages = (pgm->pg_bytes_written + PAGE_SIZE - 1) >> PAGE_SHIFT;
 	nfs_add_stats(pgio->pg_inode, NFSIOS_READPAGES, npages);
+
+	return pgio->pg_error < 0 ? pgio->pg_error : 0;
 }
 
 
@@ -373,16 +375,17 @@ int nfs_readpage(struct file *file, struct page *page)
 			     &nfs_async_read_completion_ops);
 
 	ret = readpage_async_filler(&desc, page);
+	if (ret)
+		goto out;
 
-	if (!ret)
-		nfs_pageio_complete_read(&desc.pgio);
+	ret = nfs_pageio_complete_read(&desc.pgio);
+	if (ret)
+		goto out;
+
+	ret = wait_on_page_locked_killable(page);
+	if (!PageUptodate(page) && !ret)
+		ret = xchg(&desc.ctx->error, 0);
 
-	ret = desc.pgio.pg_error < 0 ? desc.pgio.pg_error : 0;
-	if (!ret) {
-		ret = wait_on_page_locked_killable(page);
-		if (!PageUptodate(page) && !ret)
-			ret = xchg(&desc.ctx->error, 0);
-	}
 out:
 	put_nfs_open_context(desc.ctx);
 	return ret;
-- 
1.8.3.1


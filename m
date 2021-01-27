Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9DB69305548
	for <lists+linux-nfs@lfdr.de>; Wed, 27 Jan 2021 09:09:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234469AbhA0IJG (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 27 Jan 2021 03:09:06 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:30434 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234617AbhA0IE7 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 27 Jan 2021 03:04:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1611734613;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:in-reply-to:in-reply-to:references:references;
        bh=0bjdnswoGpW7h5fO2+La1vj2ABJF/GMGpdlerYTu6Pk=;
        b=XMT0SfaD6su8/VZ5fXeGSttv+mjBeGiKpKu448jSlwsTZoR+xc5HDzkBfNmQUZzkobn/p3
        tq0F7c6HU2fWF3b+ssYWpRa0bLHoZAufKZwYjS2LPu7ifEIhSo75sonWzAgbhd+55FZzX3
        j/cYHk8eW1dJSytqrYGzp3mKxLyJTcM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-547-ta6FO6xiNtiW3tv44e0HEA-1; Wed, 27 Jan 2021 03:03:31 -0500
X-MC-Unique: ta6FO6xiNtiW3tv44e0HEA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A6A4B180A094;
        Wed, 27 Jan 2021 08:03:30 +0000 (UTC)
Received: from dwysocha.rdu.csb (ovpn-112-111.rdu2.redhat.com [10.10.112.111])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 375391F0;
        Wed, 27 Jan 2021 08:03:30 +0000 (UTC)
From:   Dave Wysochanski <dwysocha@redhat.com>
To:     Trond Myklebust <trondmy@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH 4/8] NFS: Call readpage_async_filler() from nfs_readpage_async()
Date:   Wed, 27 Jan 2021 03:03:13 -0500
Message-Id: <1611734597-14754-5-git-send-email-dwysocha@redhat.com>
In-Reply-To: <1611734597-14754-2-git-send-email-dwysocha@redhat.com>
References: <1611734597-14754-2-git-send-email-dwysocha@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Refactor slightly so nfs_readpage_async() calls into
readpage_async_filler().

Signed-off-by: Dave Wysochanski <dwysocha@redhat.com>
---
 fs/nfs/read.c | 28 +++++++++++-----------------
 1 file changed, 11 insertions(+), 17 deletions(-)

diff --git a/fs/nfs/read.c b/fs/nfs/read.c
index 8c05e56dab65..0ed79e6bc486 100644
--- a/fs/nfs/read.c
+++ b/fs/nfs/read.c
@@ -119,31 +119,22 @@ struct nfs_readdesc {
 	struct nfs_open_context *ctx;
 };
 
+static int readpage_async_filler(void *data, struct page *page);
+
 int nfs_readpage_async(void *data, struct inode *inode,
 		       struct page *page)
 {
 	struct nfs_readdesc *desc = data;
-	struct nfs_page	*new;
-	unsigned int len;
 	struct nfs_pgio_mirror *pgm;
-
-	len = nfs_page_length(page);
-	if (len == 0)
-		return nfs_return_empty_page(page);
-	new = nfs_create_request(desc->ctx, page, 0, len);
-	if (IS_ERR(new)) {
-		unlock_page(page);
-		return PTR_ERR(new);
-	}
-	if (len < PAGE_SIZE)
-		zero_user_segment(page, len, PAGE_SIZE);
+	int error;
 
 	nfs_pageio_init_read(&desc->pgio, inode, false,
 			     &nfs_async_read_completion_ops);
-	if (!nfs_pageio_add_request(&desc->pgio, new)) {
-		nfs_list_remove_request(new);
-		nfs_readpage_release(new, desc->pgio.pg_error);
-	}
+
+	error = readpage_async_filler(desc, page);
+	if (error)
+		goto out;
+
 	nfs_pageio_complete(&desc->pgio);
 
 	/* It doesn't make sense to do mirrored reads! */
@@ -153,6 +144,9 @@ int nfs_readpage_async(void *data, struct inode *inode,
 	NFS_I(inode)->read_io += pgm->pg_bytes_written;
 
 	return desc->pgio.pg_error < 0 ? desc->pgio.pg_error : 0;
+
+out:
+	return error;
 }
 
 static void nfs_page_group_set_uptodate(struct nfs_page *req)
-- 
1.8.3.1


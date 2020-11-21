Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD00C2BBF37
	for <lists+linux-nfs@lfdr.de>; Sat, 21 Nov 2020 14:29:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727807AbgKUN30 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sat, 21 Nov 2020 08:29:26 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:22205 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726175AbgKUN30 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sat, 21 Nov 2020 08:29:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1605965365;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc; bh=+Om3M0BIxbSuF3ZOTs6rshwBCB7b8mi5Pxx0b5la7A4=;
        b=ikOqzvQ7cdOtC3N6wKGcv4sH0W5tMU9zDZ2Jvs7K6coMDDRZm4iMAmd3sSIyHU/exG3g49
        r689uczevoxD9KCjCwIAEn1mZyNsjtrRjom+UjSWzax4LqObqfCClrjeoQX3+wPG8zoX22
        tGJg8tML/BvR90XRhzcQTD+UTjtIypw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-464-puEb43ZsP8aFux_UD7fq3w-1; Sat, 21 Nov 2020 08:29:21 -0500
X-MC-Unique: puEb43ZsP8aFux_UD7fq3w-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3ECD780EDAA;
        Sat, 21 Nov 2020 13:29:20 +0000 (UTC)
Received: from dwysocha.rdu.csb (ovpn-112-41.rdu2.redhat.com [10.10.112.41])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id BB9196085D;
        Sat, 21 Nov 2020 13:29:19 +0000 (UTC)
From:   Dave Wysochanski <dwysocha@redhat.com>
To:     Trond Myklebust <trondmy@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>
Cc:     linux-nfs@vger.kernel.org, dhowells@redhat.com
Subject: [PATCH v1 04/13] NFS: Call readpage_async_filler() from nfs_readpage_async()
Date:   Sat, 21 Nov 2020 08:29:18 -0500
Message-Id: <1605965358-24607-1-git-send-email-dwysocha@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
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
index 5fda30742a32..1401f1c734c0 100644
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
 	struct nfs_readdesc *desc = (struct nfs_readdesc *)data;
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


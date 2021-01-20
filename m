Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 587E72FD66B
	for <lists+linux-nfs@lfdr.de>; Wed, 20 Jan 2021 18:05:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391612AbhATRFQ (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 20 Jan 2021 12:05:16 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:22916 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2391623AbhATRBf (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 20 Jan 2021 12:01:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1611161998;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xgc4giKWv6c746qHQMzY1X+v3rzPUg34NpKkwQbpZuU=;
        b=FQFWMGpokjc8vzQt72bc/RIXHy8OajB6S6DcRCkC+/VT9aLl17uraZNrVenYfMpnNBPRmS
        U7GeBo7IE8VdADr/dhi8lCqOOe/apmw2/J5vxSRzyHkle0hzyIMfVfPHtjf+Q0oCvFHOly
        trlQvw2359W8W/SaSuT8xK97r7Vsgto=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-421-2pSIUINSN1mM_8kVR_1ToQ-1; Wed, 20 Jan 2021 11:59:56 -0500
X-MC-Unique: 2pSIUINSN1mM_8kVR_1ToQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9FE6A192CC42
        for <linux-nfs@vger.kernel.org>; Wed, 20 Jan 2021 16:59:55 +0000 (UTC)
Received: from bcodding.csb (ovpn-64-66.rdu2.redhat.com [10.10.64.66])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 6CB2B5D6DC
        for <linux-nfs@vger.kernel.org>; Wed, 20 Jan 2021 16:59:55 +0000 (UTC)
Received: by bcodding.csb (Postfix, from userid 24008)
        id B98D210E5BC8; Wed, 20 Jan 2021 11:59:54 -0500 (EST)
From:   Benjamin Coddington <bcodding@redhat.com>
To:     linux-nfs@vger.kernel.org
Subject: [PATCH v1 06/10] NFS: stash the readdir pagecache cursor on the open directory context
Date:   Wed, 20 Jan 2021 11:59:50 -0500
Message-Id: <27179777ef614728c54d76f6588567598eaf4057.1611160121.git.bcodding@redhat.com>
In-Reply-To: <cover.1611160120.git.bcodding@redhat.com>
References: <cover.1611160120.git.bcodding@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Now that we have per-page cache validation, we can allow filling of the
pagecache from arbitrary offsets.  Store the pagecache cursor on the open
directory context so it can be used to validate our entries the next time
we enter nfs_readdir() without having to fill the pagecache from the
beginning.

The open_directory_context's dir_cookie and index_cookie will store the
same value between calls to nfs_readdir(), so we can save a little room in
the struct by dropping dir_cookie.

Signed-off-by: Benjamin Coddington <bcodding@redhat.com>
---
 fs/nfs/dir.c           | 15 ++++++++-------
 include/linux/nfs_fs.h |  2 +-
 2 files changed, 9 insertions(+), 8 deletions(-)

diff --git a/fs/nfs/dir.c b/fs/nfs/dir.c
index 5fc22d97054a..4e21b21c75d0 100644
--- a/fs/nfs/dir.c
+++ b/fs/nfs/dir.c
@@ -81,7 +81,7 @@ static struct nfs_open_dir_context *alloc_nfs_open_dir_context(struct inode *dir
 	if (ctx != NULL) {
 		ctx->duped = 0;
 		ctx->attr_gencount = nfsi->attr_gencount;
-		ctx->dir_cookie = 0;
+		memset(&ctx->pgc, 0, sizeof(struct nfs_dir_page_cursor));
 		ctx->dup_cookie = 0;
 		spin_lock(&dir->i_lock);
 		if (list_empty(&nfsi->open_files) &&
@@ -365,7 +365,8 @@ nfs_readdir_page_valid(struct page *page, unsigned int entry_index, u64 index_co
 	ret = true;
 	array = kmap_atomic(page);
 
-	if (array->size == 0 && array->last_cookie == index_cookie)
+	if ((array->size == 0 || array->size == entry_index)
+		&& array->last_cookie == index_cookie)
 		goto out_unmap;
 
 	if (array->size > entry_index &&
@@ -1054,7 +1055,6 @@ static int readdir_search_pagecache(struct nfs_readdir_descriptor *desc)
 		if (desc->pgc.page_index == 0) {
 			desc->current_index = 0;
 			desc->prev_index = 0;
-			desc->pgc.index_cookie = 0;
 		}
 		res = find_and_lock_cache_page(desc);
 	} while (res == -EAGAIN);
@@ -1192,7 +1192,8 @@ static int nfs_readdir(struct file *file, struct dir_context *ctx)
 	desc->plus = nfs_use_readdirplus(inode, ctx);
 
 	spin_lock(&file->f_lock);
-	desc->dir_cookie = dir_ctx->dir_cookie;
+	desc->dir_cookie = dir_ctx->pgc.index_cookie;
+	desc->pgc = dir_ctx->pgc;
 	desc->dup_cookie = dir_ctx->dup_cookie;
 	desc->duped = dir_ctx->duped;
 	desc->attr_gencount = dir_ctx->attr_gencount;
@@ -1231,7 +1232,7 @@ static int nfs_readdir(struct file *file, struct dir_context *ctx)
 	} while (!desc->eof);
 
 	spin_lock(&file->f_lock);
-	dir_ctx->dir_cookie = desc->dir_cookie;
+	dir_ctx->pgc = desc->pgc;
 	dir_ctx->dup_cookie = desc->dup_cookie;
 	dir_ctx->duped = desc->duped;
 	dir_ctx->attr_gencount = desc->attr_gencount;
@@ -1273,9 +1274,9 @@ static loff_t nfs_llseek_dir(struct file *filp, loff_t offset, int whence)
 	if (offset != filp->f_pos) {
 		filp->f_pos = offset;
 		if (nfs_readdir_use_cookie(filp))
-			dir_ctx->dir_cookie = offset;
+			dir_ctx->pgc.index_cookie = offset;
 		else
-			dir_ctx->dir_cookie = 0;
+			dir_ctx->pgc.index_cookie = 0;
 		if (offset == 0)
 			memset(dir_ctx->verf, 0, sizeof(dir_ctx->verf));
 		dir_ctx->duped = 0;
diff --git a/include/linux/nfs_fs.h b/include/linux/nfs_fs.h
index 557e54b7d555..cd35137a935b 100644
--- a/include/linux/nfs_fs.h
+++ b/include/linux/nfs_fs.h
@@ -101,7 +101,7 @@ struct nfs_open_dir_context {
 	struct list_head list;
 	unsigned long attr_gencount;
 	__be32	verf[NFS_DIR_VERIFIER_SIZE];
-	__u64 dir_cookie;
+	struct nfs_dir_page_cursor pgc;
 	__u64 dup_cookie;
 	signed char duped;
 };
-- 
2.25.4


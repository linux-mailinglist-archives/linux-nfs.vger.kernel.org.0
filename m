Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B04B4C1473
	for <lists+linux-nfs@lfdr.de>; Wed, 23 Feb 2022 14:43:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238752AbiBWNlL (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 23 Feb 2022 08:41:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241002AbiBWNlI (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 23 Feb 2022 08:41:08 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6E501AC06C
        for <linux-nfs@vger.kernel.org>; Wed, 23 Feb 2022 05:40:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1645623639;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=R7pcIYBVZDzX8FW4mHNWhR8zvOrbLMd2XRXa9PZHwAQ=;
        b=e7KfF7Zf4/6BGrGagZP0XLNeAQqLY0L61Rf1mui6v6Uy8kagtlZc8HIlK/XY9HpD3Nrapa
        28anrXXFbwOv3LllLFEJJJs1eJdB8d32+hTSaY3jn1OLZSK0xR+WiY8B/QCqZoViUjnQIw
        Geu7F5rb+Wfuf6/7XNXizkmDuADZq0Q=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-391-H4tNlG6AMXiold9NcqtIkQ-1; Wed, 23 Feb 2022 08:40:37 -0500
X-MC-Unique: H4tNlG6AMXiold9NcqtIkQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0628F804312
        for <linux-nfs@vger.kernel.org>; Wed, 23 Feb 2022 13:40:37 +0000 (UTC)
Received: from bcodding.csb (ovpn-64-2.rdu2.redhat.com [10.10.64.2])
        by smtp.corp.redhat.com (Postfix) with ESMTP id CD660106F97E
        for <linux-nfs@vger.kernel.org>; Wed, 23 Feb 2022 13:40:36 +0000 (UTC)
Received: by bcodding.csb (Postfix, from userid 24008)
        id 0C96010C3108; Wed, 23 Feb 2022 08:40:36 -0500 (EST)
From:   Benjamin Coddington <bcodding@redhat.com>
To:     linux-nfs@vger.kernel.org
Subject: [PATCH v3 6/8] NFS: stash the readdir pagecache cursor on the open directory context
Date:   Wed, 23 Feb 2022 08:40:33 -0500
Message-Id: <19ef38cda6b0eb6548c65c2bff7a4d4dd1baa122.1645623510.git.bcodding@redhat.com>
In-Reply-To: <c597a8ae5ea99de277b3f2e6486fe3bde1c5f64a.1645623510.git.bcodding@redhat.com>
References: <d759b6df8acd82b8d44e2afcf11a7a94dcf85ba6.1645623510.git.bcodding@redhat.com> <eedb07d14a96caef1de663a436a326b2c5012ab4.1645623510.git.bcodding@redhat.com> <aaedb2e378800a5cdb7071d65690b981274f2c22.1645623510.git.bcodding@redhat.com> <5479c8c5be9cf3f387edac54f170461f8f7b89e2.1645623510.git.bcodding@redhat.com> <c597a8ae5ea99de277b3f2e6486fe3bde1c5f64a.1645623510.git.bcodding@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
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
 fs/nfs/dir.c           | 13 +++++++------
 include/linux/nfs_fs.h |  2 +-
 2 files changed, 8 insertions(+), 7 deletions(-)

diff --git a/fs/nfs/dir.c b/fs/nfs/dir.c
index ba75a9593dae..4f4a139f3181 100644
--- a/fs/nfs/dir.c
+++ b/fs/nfs/dir.c
@@ -395,7 +395,8 @@ nfs_readdir_page_valid(struct page *page, unsigned int entry_index, u64 index_co
 	ret = true;
 	array = kmap_atomic(page);
 
-	if (array->size == 0 && array->last_cookie == index_cookie)
+	if ((array->size == 0 || array->size == entry_index)
+		&& array->last_cookie == index_cookie)
 		goto out_unmap;
 
 	if (array->size > entry_index &&
@@ -1102,7 +1103,6 @@ static int readdir_search_pagecache(struct nfs_readdir_descriptor *desc)
 		if (desc->pgc.page_index == 0) {
 			desc->current_index = 0;
 			desc->prev_index = 0;
-			desc->pgc.index_cookie = 0;
 		}
 		res = find_and_lock_cache_page(desc);
 	} while (res == -EAGAIN);
@@ -1279,7 +1279,8 @@ static int nfs_readdir(struct file *file, struct dir_context *ctx)
 	desc->page_index_max = -1;
 
 	spin_lock(&file->f_lock);
-	desc->dir_cookie = dir_ctx->dir_cookie;
+	desc->dir_cookie = dir_ctx->pgc.index_cookie;
+	desc->pgc = dir_ctx->pgc;
 	desc->dup_cookie = dir_ctx->dup_cookie;
 	desc->duped = dir_ctx->duped;
 	page_index = dir_ctx->page_index;
@@ -1336,7 +1337,7 @@ static int nfs_readdir(struct file *file, struct dir_context *ctx)
 	} while (!desc->eob && !desc->eof);
 
 	spin_lock(&file->f_lock);
-	dir_ctx->dir_cookie = desc->dir_cookie;
+	dir_ctx->pgc = desc->pgc;
 	dir_ctx->dup_cookie = desc->dup_cookie;
 	dir_ctx->duped = desc->duped;
 	dir_ctx->attr_gencount = desc->attr_gencount;
@@ -1382,9 +1383,9 @@ static loff_t nfs_llseek_dir(struct file *filp, loff_t offset, int whence)
 	if (offset != filp->f_pos) {
 		filp->f_pos = offset;
 		if (nfs_readdir_use_cookie(filp))
-			dir_ctx->dir_cookie = offset;
+			dir_ctx->pgc.index_cookie = offset;
 		else
-			dir_ctx->dir_cookie = 0;
+			dir_ctx->pgc.index_cookie = 0;
 		dir_ctx->page_fill_misses = 0;
 		if (offset == 0)
 			memset(dir_ctx->verf, 0, sizeof(dir_ctx->verf));
diff --git a/include/linux/nfs_fs.h b/include/linux/nfs_fs.h
index 2f5ded282477..aaeaad4006a4 100644
--- a/include/linux/nfs_fs.h
+++ b/include/linux/nfs_fs.h
@@ -111,7 +111,7 @@ struct nfs_open_dir_context {
 	atomic_t cache_misses;
 	unsigned long attr_gencount;
 	__be32	verf[NFS_DIR_VERIFIER_SIZE];
-	__u64 dir_cookie;
+	struct nfs_dir_page_cursor pgc;
 	__u64 dup_cookie;
 	pgoff_t page_index;
 	unsigned int page_fill_misses;
-- 
2.31.1


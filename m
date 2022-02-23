Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F9874C1472
	for <lists+linux-nfs@lfdr.de>; Wed, 23 Feb 2022 14:42:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240976AbiBWNlK (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 23 Feb 2022 08:41:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238752AbiBWNlH (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 23 Feb 2022 08:41:07 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C7D94AC05F
        for <linux-nfs@vger.kernel.org>; Wed, 23 Feb 2022 05:40:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1645623639;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=boVjQySP0bow3lHCS1C6zSDqVgfR35bAsnNUPhH4nmY=;
        b=Xg72O65iTYYitB0Wjy1KnF9unj6bjhTpvoAZHar1llrP5sX0e9QyOjEL870E3z2/0GRi03
        TBIdQ4OaZE7Es0KOcs1s20VFDcOEV9E5+4i0/wMHvaOm6pl64FWn472Q9bUF7cGYF0LTtX
        4Mi3GwqYbHXxGWlF9qDdlpfclyjoMOE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-377-dwOF8fY8P_SryZCTWCz-gw-1; Wed, 23 Feb 2022 08:40:37 -0500
X-MC-Unique: dwOF8fY8P_SryZCTWCz-gw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A01A01091DA1
        for <linux-nfs@vger.kernel.org>; Wed, 23 Feb 2022 13:40:36 +0000 (UTC)
Received: from bcodding.csb (ovpn-64-2.rdu2.redhat.com [10.10.64.2])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 528B67C03E
        for <linux-nfs@vger.kernel.org>; Wed, 23 Feb 2022 13:40:36 +0000 (UTC)
Received: by bcodding.csb (Postfix, from userid 24008)
        id F1C5D10C30F7; Wed, 23 Feb 2022 08:40:35 -0500 (EST)
From:   Benjamin Coddington <bcodding@redhat.com>
To:     linux-nfs@vger.kernel.org
Subject: [PATCH v3 3/8] NFS: Add a struct to track readdir pagecache location
Date:   Wed, 23 Feb 2022 08:40:30 -0500
Message-Id: <aaedb2e378800a5cdb7071d65690b981274f2c22.1645623510.git.bcodding@redhat.com>
In-Reply-To: <eedb07d14a96caef1de663a436a326b2c5012ab4.1645623510.git.bcodding@redhat.com>
References: <d759b6df8acd82b8d44e2afcf11a7a94dcf85ba6.1645623510.git.bcodding@redhat.com> <eedb07d14a96caef1de663a436a326b2c5012ab4.1645623510.git.bcodding@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Directory entries in the NFS readdir pagecache are referenced by their
cookie value and offset.  By defining a structure to group these values,
we'll simplify changes to validate pagecache pages in patches that follow.

Signed-off-by: Benjamin Coddington <bcodding@redhat.com>
---
 fs/nfs/dir.c           | 46 ++++++++++++++++++++----------------------
 include/linux/nfs_fs.h |  6 ++++++
 2 files changed, 28 insertions(+), 24 deletions(-)

diff --git a/fs/nfs/dir.c b/fs/nfs/dir.c
index 79bdcedc0cad..009187c0ae0f 100644
--- a/fs/nfs/dir.c
+++ b/fs/nfs/dir.c
@@ -158,11 +158,10 @@ struct nfs_readdir_descriptor {
 	struct file	*file;
 	struct page	*page;
 	struct dir_context *ctx;
-	pgoff_t		page_index;
 	pgoff_t		page_index_max;
 	u64		dir_cookie;
-	u64		last_cookie;
 	u64		dup_cookie;
+	struct nfs_dir_page_cursor pgc;
 	loff_t		current_index;
 	loff_t		prev_index;
 
@@ -172,7 +171,6 @@ struct nfs_readdir_descriptor {
 	unsigned long	gencount;
 	unsigned long	attr_gencount;
 	unsigned int	page_fill_misses;
-	unsigned int	cache_entry_index;
 	unsigned int	buffer_fills;
 	unsigned int	dtsize;
 	signed char duped;
@@ -457,7 +455,7 @@ static int nfs_readdir_search_for_pos(struct nfs_cache_array *array,
 
 	index = (unsigned int)diff;
 	desc->dir_cookie = array->array[index].cookie;
-	desc->cache_entry_index = index;
+	desc->pgc.entry_index = index;
 	return 0;
 out_eof:
 	desc->eof = true;
@@ -526,7 +524,7 @@ static int nfs_readdir_search_for_cookie(struct nfs_cache_array *array,
 			else
 				desc->ctx->pos = new_pos;
 			desc->prev_index = new_pos;
-			desc->cache_entry_index = i;
+			desc->pgc.entry_index = i;
 			return 0;
 		}
 	}
@@ -553,9 +551,9 @@ static int nfs_readdir_search_array(struct nfs_readdir_descriptor *desc)
 		status = nfs_readdir_search_for_cookie(array, desc);
 
 	if (status == -EAGAIN) {
-		desc->last_cookie = array->last_cookie;
+		desc->pgc.index_cookie = array->last_cookie;
 		desc->current_index += array->size;
-		desc->page_index++;
+		desc->pgc.page_index++;
 	}
 	kunmap_atomic(array);
 	return status;
@@ -968,8 +966,8 @@ static struct page *
 nfs_readdir_page_get_cached(struct nfs_readdir_descriptor *desc)
 {
 	return nfs_readdir_page_get_locked(desc->file->f_mapping,
-					   desc->page_index,
-					   desc->last_cookie);
+					   desc->pgc.page_index,
+					   desc->pgc.index_cookie);
 }
 
 #define NFS_READDIR_PAGE_FILL_MISS_MAX 5
@@ -1001,10 +999,10 @@ static int find_and_lock_cache_page(struct nfs_readdir_descriptor *desc)
 	if (nfs_readdir_page_needs_filling(desc->page)) {
 		if (!nfs_readdir_may_fill_pagecache(desc))
 			return -EBADCOOKIE;
-		desc->page_index_max = desc->page_index;
+		desc->page_index_max = desc->pgc.page_index;
 		trace_nfs_readdir_cache_fill(desc->file, nfsi->cookieverf,
-					     desc->last_cookie,
-					     desc->page_index, desc->dtsize);
+					     desc->pgc.index_cookie,
+					     desc->pgc.page_index, desc->dtsize);
 		res = nfs_readdir_xdr_to_array(desc, nfsi->cookieverf, verf,
 					       &desc->page, 1);
 		if (res < 0) {
@@ -1012,7 +1010,7 @@ static int find_and_lock_cache_page(struct nfs_readdir_descriptor *desc)
 			trace_nfs_readdir_cache_fill_done(inode, res);
 			if (res == -EBADCOOKIE || res == -ENOTSYNC) {
 				invalidate_inode_pages2(desc->file->f_mapping);
-				desc->page_index = 0;
+				desc->pgc.page_index = 0;
 				return -EAGAIN;
 			}
 			return res;
@@ -1020,7 +1018,7 @@ static int find_and_lock_cache_page(struct nfs_readdir_descriptor *desc)
 		/*
 		 * Set the cookie verifier if the page cache was empty
 		 */
-		if (desc->page_index == 0)
+		if (desc->pgc.page_index == 0)
 			memcpy(nfsi->cookieverf, verf,
 			       sizeof(nfsi->cookieverf));
 		desc->page_fill_misses++;
@@ -1040,10 +1038,10 @@ static int readdir_search_pagecache(struct nfs_readdir_descriptor *desc)
 	int res;
 
 	do {
-		if (desc->page_index == 0) {
+		if (desc->pgc.page_index == 0) {
 			desc->current_index = 0;
 			desc->prev_index = 0;
-			desc->last_cookie = 0;
+			desc->pgc.index_cookie = 0;
 		}
 		res = find_and_lock_cache_page(desc);
 	} while (res == -EAGAIN);
@@ -1061,7 +1059,7 @@ static void nfs_do_filldir(struct nfs_readdir_descriptor *desc,
 	unsigned int i = 0;
 
 	array = kmap(desc->page);
-	for (i = desc->cache_entry_index; i < array->size; i++) {
+	for (i = desc->pgc.entry_index; i < array->size; i++) {
 		struct nfs_cache_array_entry *ent;
 
 		ent = &array->array[i];
@@ -1119,13 +1117,13 @@ static int uncached_readdir(struct nfs_readdir_descriptor *desc)
 	if (!arrays[0])
 		goto out;
 
-	desc->page_index = 0;
-	desc->cache_entry_index = 0;
-	desc->last_cookie = desc->dir_cookie;
+	desc->pgc.page_index = 0;
+	desc->pgc.entry_index = 0;
+	desc->pgc.index_cookie = desc->dir_cookie;
 	desc->duped = 0;
 	desc->page_index_max = 0;
 
-	trace_nfs_readdir_uncached(desc->file, desc->verf, desc->last_cookie,
+	trace_nfs_readdir_uncached(desc->file, desc->verf, desc->pgc.index_cookie,
 				   -1, desc->dtsize);
 
 	status = nfs_readdir_xdr_to_array(desc, desc->verf, verf, arrays, sz);
@@ -1258,7 +1256,7 @@ static int nfs_readdir(struct file *file, struct dir_context *ctx)
 		}
 		if (res == -ETOOSMALL && desc->plus) {
 			nfs_zap_caches(inode);
-			desc->page_index = 0;
+			desc->pgc.page_index = 0;
 			desc->plus = false;
 			desc->eof = false;
 			continue;
@@ -1271,7 +1269,7 @@ static int nfs_readdir(struct file *file, struct dir_context *ctx)
 		if (desc->eob || desc->eof)
 			break;
 		/* Grow the dtsize if we have to go back for more pages */
-		if (desc->page_index == desc->page_index_max)
+		if (desc->pgc.page_index == desc->page_index_max)
 			nfs_grow_dtsize(desc);
 	} while (!desc->eob && !desc->eof);
 
@@ -1280,7 +1278,7 @@ static int nfs_readdir(struct file *file, struct dir_context *ctx)
 	dir_ctx->dup_cookie = desc->dup_cookie;
 	dir_ctx->duped = desc->duped;
 	dir_ctx->attr_gencount = desc->attr_gencount;
-	dir_ctx->page_index = desc->page_index;
+	dir_ctx->page_index = desc->pgc.page_index;
 	dir_ctx->page_fill_misses = desc->page_fill_misses;
 	dir_ctx->eof = desc->eof;
 	dir_ctx->dtsize = desc->dtsize;
diff --git a/include/linux/nfs_fs.h b/include/linux/nfs_fs.h
index 0a5425a58bbd..2f5ded282477 100644
--- a/include/linux/nfs_fs.h
+++ b/include/linux/nfs_fs.h
@@ -99,6 +99,12 @@ struct nfs_open_context {
 	struct rcu_head	rcu_head;
 };
 
+struct nfs_dir_page_cursor {
+	__u64 index_cookie;
+	pgoff_t page_index;
+	unsigned int entry_index;
+};
+
 struct nfs_open_dir_context {
 	struct list_head list;
 	atomic_t cache_hits;
-- 
2.31.1


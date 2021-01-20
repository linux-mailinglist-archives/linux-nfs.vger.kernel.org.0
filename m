Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D8CA2FD65A
	for <lists+linux-nfs@lfdr.de>; Wed, 20 Jan 2021 18:02:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391718AbhATRCw (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 20 Jan 2021 12:02:52 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:22727 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2391570AbhATRBf (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 20 Jan 2021 12:01:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1611161998;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hrYfo5cLa5+fzVKRk2737HUhIfYeK9iKxnyK0YA++cU=;
        b=OuOdndnnrwZ2uBb99t6J4FNqad/S6+rQHf/8L3GdRoZT0L0ZP+mDqoc4AhkotENI7FB1mF
        yZXeBOSAhde8lYToYVOWHQeMKW+COvxan0wUH+fWyRYnewJVgVexn+CqKEVv+JZq3kmY8K
        jWpVfW24K5YHBBbZk10HkA2gMuLE9X4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-355-q2OSQLxGMayz6iMCbA698A-1; Wed, 20 Jan 2021 11:59:56 -0500
X-MC-Unique: q2OSQLxGMayz6iMCbA698A-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 338478030A5
        for <linux-nfs@vger.kernel.org>; Wed, 20 Jan 2021 16:59:55 +0000 (UTC)
Received: from bcodding.csb (ovpn-64-66.rdu2.redhat.com [10.10.64.66])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 02CD210023B9
        for <linux-nfs@vger.kernel.org>; Wed, 20 Jan 2021 16:59:55 +0000 (UTC)
Received: by bcodding.csb (Postfix, from userid 24008)
        id 92A1910E3EF2; Wed, 20 Jan 2021 11:59:54 -0500 (EST)
From:   Benjamin Coddington <bcodding@redhat.com>
To:     linux-nfs@vger.kernel.org
Subject: [PATCH v1 03/10] NFS: Add a struct to track readdir pagecache location
Date:   Wed, 20 Jan 2021 11:59:47 -0500
Message-Id: <e78ca3502aeaea97d85e5ea2beff775946cc7a3f.1611160121.git.bcodding@redhat.com>
In-Reply-To: <cover.1611160120.git.bcodding@redhat.com>
References: <cover.1611160120.git.bcodding@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Directory entries in the NFS readdir pagecache are referenced by their
cookie value and offset.  By defining a structure to group these values,
we'll simplify changes to validate pagecache pages in patches that follow.

Signed-off-by: Benjamin Coddington <bcodding@redhat.com>
---
 fs/nfs/dir.c           | 34 +++++++++++++++++-----------------
 include/linux/nfs_fs.h |  6 ++++++
 2 files changed, 23 insertions(+), 17 deletions(-)

diff --git a/fs/nfs/dir.c b/fs/nfs/dir.c
index ade73ca42a52..6626aff9f54d 100644
--- a/fs/nfs/dir.c
+++ b/fs/nfs/dir.c
@@ -154,10 +154,9 @@ struct nfs_readdir_descriptor {
 	struct file	*file;
 	struct page	*page;
 	struct dir_context *ctx;
-	pgoff_t		page_index;
 	u64		dir_cookie;
-	u64		last_cookie;
 	u64		dup_cookie;
+	struct nfs_dir_page_cursor pgc;
 	loff_t		current_index;
 	loff_t		prev_index;
 
@@ -166,7 +165,6 @@ struct nfs_readdir_descriptor {
 	unsigned long	timestamp;
 	unsigned long	gencount;
 	unsigned long	attr_gencount;
-	unsigned int	cache_entry_index;
 	signed char duped;
 	bool plus;
 	bool eof;
@@ -426,7 +424,7 @@ static int nfs_readdir_search_for_pos(struct nfs_cache_array *array,
 
 	index = (unsigned int)diff;
 	desc->dir_cookie = array->array[index].cookie;
-	desc->cache_entry_index = index;
+	desc->pgc.entry_index = index;
 	return 0;
 out_eof:
 	desc->eof = true;
@@ -494,7 +492,7 @@ static int nfs_readdir_search_for_cookie(struct nfs_cache_array *array,
 			else
 				desc->ctx->pos = new_pos;
 			desc->prev_index = new_pos;
-			desc->cache_entry_index = i;
+			desc->pgc.entry_index = i;
 			return 0;
 		}
 	}
@@ -521,9 +519,9 @@ static int nfs_readdir_search_array(struct nfs_readdir_descriptor *desc)
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
@@ -927,8 +925,8 @@ static struct page *
 nfs_readdir_page_get_cached(struct nfs_readdir_descriptor *desc)
 {
 	return nfs_readdir_page_get_locked(desc->file->f_mapping,
-					   desc->page_index,
-					   desc->last_cookie);
+					   desc->pgc.page_index,
+					   desc->pgc.index_cookie);
 }
 
 /*
@@ -952,7 +950,7 @@ static int find_and_lock_cache_page(struct nfs_readdir_descriptor *desc)
 			nfs_readdir_page_unlock_and_put_cached(desc);
 			if (res == -EBADCOOKIE || res == -ENOTSYNC) {
 				invalidate_inode_pages2(desc->file->f_mapping);
-				desc->page_index = 0;
+				desc->pgc.page_index = 0;
 				return -EAGAIN;
 			}
 			return res;
@@ -961,7 +959,7 @@ static int find_and_lock_cache_page(struct nfs_readdir_descriptor *desc)
 	}
 	res = nfs_readdir_search_array(desc);
 	if (res == 0) {
-		nfsi->page_index = desc->page_index;
+		nfsi->page_index = desc->pgc.page_index;
 		return 0;
 	}
 	nfs_readdir_page_unlock_and_put_cached(desc);
@@ -991,10 +989,10 @@ static int readdir_search_pagecache(struct nfs_readdir_descriptor *desc)
 		return -EBADCOOKIE;
 
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
@@ -1012,7 +1010,7 @@ static void nfs_do_filldir(struct nfs_readdir_descriptor *desc)
 	unsigned int i = 0;
 
 	array = kmap(desc->page);
-	for (i = desc->cache_entry_index; i < array->size; i++) {
+	for (i = desc->pgc.entry_index; i < array->size; i++) {
 		struct nfs_cache_array_entry *ent;
 
 		ent = &array->array[i];
@@ -1070,8 +1068,10 @@ static int uncached_readdir(struct nfs_readdir_descriptor *desc)
 	if (!arrays[0])
 		goto out;
 
-	desc->page_index = 0;
-	desc->last_cookie = desc->dir_cookie;
+	/* These values aren't referenced until we return, move/remove? */
+	desc->pgc.page_index = 0;
+	desc->pgc.index_cookie = desc->dir_cookie;
+
 	desc->duped = 0;
 
 	status = nfs_readdir_xdr_to_array(desc, desc->verf, verf, arrays, sz);
@@ -1154,7 +1154,7 @@ static int nfs_readdir(struct file *file, struct dir_context *ctx)
 		if (res == -ETOOSMALL && desc->plus) {
 			clear_bit(NFS_INO_ADVISE_RDPLUS, &NFS_I(inode)->flags);
 			nfs_zap_caches(inode);
-			desc->page_index = 0;
+			desc->pgc.page_index = 0;
 			desc->plus = false;
 			desc->eof = false;
 			continue;
diff --git a/include/linux/nfs_fs.h b/include/linux/nfs_fs.h
index 681ed98e4ba8..557e54b7d555 100644
--- a/include/linux/nfs_fs.h
+++ b/include/linux/nfs_fs.h
@@ -91,6 +91,12 @@ struct nfs_open_context {
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
 	unsigned long attr_gencount;
-- 
2.25.4


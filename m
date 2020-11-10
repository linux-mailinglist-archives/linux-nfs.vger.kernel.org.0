Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E8542AE216
	for <lists+linux-nfs@lfdr.de>; Tue, 10 Nov 2020 22:48:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731910AbgKJVsF (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 10 Nov 2020 16:48:05 -0500
Received: from mail.kernel.org ([198.145.29.99]:43188 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731985AbgKJVsE (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Tue, 10 Nov 2020 16:48:04 -0500
Received: from localhost.localdomain (c-68-36-133-222.hsd1.mi.comcast.net [68.36.133.222])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D891E20797
        for <linux-nfs@vger.kernel.org>; Tue, 10 Nov 2020 21:48:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605044883;
        bh=Dv3p0VH/Q/wawpd5nxhWQO1H7aHmqx16Dr0Zk0sTKDw=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=iF6tFE/A/Hua+SKs1pB/umVW8MRXyjuULBVUNp7rlUWQW7kKjlRrIsYsvOxDrg9fx
         axBeDRepdilJtEOqfEUVdRODK6YzunvRevqGvbHO3czMKzhUzCFyNSTXzKZMEJ2PfZ
         DDpZuaTgTOVTMeP2G0ffWDcV2U8pgAwbcfI2pJpo=
From:   trondmy@kernel.org
To:     linux-nfs@vger.kernel.org
Subject: [PATCH v5 20/22] NFS: Optimisations for monotonically increasing readdir cookies
Date:   Tue, 10 Nov 2020 16:37:39 -0500
Message-Id: <20201110213741.860745-21-trondmy@kernel.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201110213741.860745-20-trondmy@kernel.org>
References: <20201110213741.860745-1-trondmy@kernel.org>
 <20201110213741.860745-2-trondmy@kernel.org>
 <20201110213741.860745-3-trondmy@kernel.org>
 <20201110213741.860745-4-trondmy@kernel.org>
 <20201110213741.860745-5-trondmy@kernel.org>
 <20201110213741.860745-6-trondmy@kernel.org>
 <20201110213741.860745-7-trondmy@kernel.org>
 <20201110213741.860745-8-trondmy@kernel.org>
 <20201110213741.860745-9-trondmy@kernel.org>
 <20201110213741.860745-10-trondmy@kernel.org>
 <20201110213741.860745-11-trondmy@kernel.org>
 <20201110213741.860745-12-trondmy@kernel.org>
 <20201110213741.860745-13-trondmy@kernel.org>
 <20201110213741.860745-14-trondmy@kernel.org>
 <20201110213741.860745-15-trondmy@kernel.org>
 <20201110213741.860745-16-trondmy@kernel.org>
 <20201110213741.860745-17-trondmy@kernel.org>
 <20201110213741.860745-18-trondmy@kernel.org>
 <20201110213741.860745-19-trondmy@kernel.org>
 <20201110213741.860745-20-trondmy@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Trond Myklebust <trond.myklebust@hammerspace.com>

If the server is handing out monotonically increasing readdir cookie values,
then we can optimise away searches through pages that contain cookies that
lie outside our search range.

Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
Reviewed-by: Benjamin Coddington <bcodding@redhat.com>
Tested-by: Benjamin Coddington <bcodding@redhat.com>
---
 fs/nfs/dir.c | 23 ++++++++++++++++++++++-
 1 file changed, 22 insertions(+), 1 deletion(-)

diff --git a/fs/nfs/dir.c b/fs/nfs/dir.c
index 454377228167..b6c3501e8f61 100644
--- a/fs/nfs/dir.c
+++ b/fs/nfs/dir.c
@@ -140,7 +140,8 @@ struct nfs_cache_array {
 	u64 last_cookie;
 	unsigned int size;
 	unsigned char page_full : 1,
-		      page_is_eof : 1;
+		      page_is_eof : 1,
+		      cookies_are_ordered : 1;
 	struct nfs_cache_array_entry array[];
 };
 
@@ -178,6 +179,7 @@ static void nfs_readdir_page_init_array(struct page *page, u64 last_cookie)
 	array = kmap_atomic(page);
 	nfs_readdir_array_init(array);
 	array->last_cookie = last_cookie;
+	array->cookies_are_ordered = 1;
 	kunmap_atomic(array);
 }
 
@@ -269,6 +271,8 @@ int nfs_readdir_add_to_array(struct nfs_entry *entry, struct page *page)
 	cache_entry->name_len = entry->len;
 	cache_entry->name = name;
 	array->last_cookie = entry->cookie;
+	if (array->last_cookie <= cache_entry->cookie)
+		array->cookies_are_ordered = 0;
 	array->size++;
 	if (entry->eof != 0)
 		nfs_readdir_array_set_eof(array);
@@ -395,6 +399,19 @@ nfs_readdir_inode_mapping_valid(struct nfs_inode *nfsi)
 	return !test_bit(NFS_INO_INVALIDATING, &nfsi->flags);
 }
 
+static bool nfs_readdir_array_cookie_in_range(struct nfs_cache_array *array,
+					      u64 cookie)
+{
+	if (!array->cookies_are_ordered)
+		return true;
+	/* Optimisation for monotonically increasing cookies */
+	if (cookie >= array->last_cookie)
+		return false;
+	if (array->size && cookie < array->array[0].cookie)
+		return false;
+	return true;
+}
+
 static int nfs_readdir_search_for_cookie(struct nfs_cache_array *array,
 					 struct nfs_readdir_descriptor *desc)
 {
@@ -402,6 +419,9 @@ static int nfs_readdir_search_for_cookie(struct nfs_cache_array *array,
 	loff_t new_pos;
 	int status = -EAGAIN;
 
+	if (!nfs_readdir_array_cookie_in_range(array, desc->dir_cookie))
+		goto check_eof;
+
 	for (i = 0; i < array->size; i++) {
 		if (array->array[i].cookie == desc->dir_cookie) {
 			struct nfs_inode *nfsi = NFS_I(file_inode(desc->file));
@@ -435,6 +455,7 @@ static int nfs_readdir_search_for_cookie(struct nfs_cache_array *array,
 			return 0;
 		}
 	}
+check_eof:
 	if (array->page_is_eof) {
 		status = -EBADCOOKIE;
 		if (desc->dir_cookie == array->last_cookie)
-- 
2.28.0


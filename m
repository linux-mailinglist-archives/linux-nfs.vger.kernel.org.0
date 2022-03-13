Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B52E64D772C
	for <lists+linux-nfs@lfdr.de>; Sun, 13 Mar 2022 18:12:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235110AbiCMRNZ (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sun, 13 Mar 2022 13:13:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235115AbiCMRNW (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sun, 13 Mar 2022 13:13:22 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDB73139CE2
        for <linux-nfs@vger.kernel.org>; Sun, 13 Mar 2022 10:12:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7B61360FCF
        for <linux-nfs@vger.kernel.org>; Sun, 13 Mar 2022 17:12:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B26F1C340EE
        for <linux-nfs@vger.kernel.org>; Sun, 13 Mar 2022 17:12:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647191533;
        bh=YWoUlfmjnDv4EbaU0tvzdRuS4toRNHEBoKcFuYIxzBo=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=hUKEJ7b6/eELS09jpfikiySNAFGwZq65Mynt58tmjbf2UxE3YKYHgcsEeJh+0IewM
         DeJRSg1uBW2qd6VQ55q3HxvXLVTaU8N/miamVTIWGDEZuATYxbj3hK3++GrgjgzTR9
         WmrGo+JvRl+L8cKikzSB0scQNFYNM/Sik+58Lyio97yGXBgfdiGndHatGm9PFY/+Zl
         TJ7GuFi4XUHG7SXxt/aWsPjOiIj8UdoZz+j3VBLOLMqB4NHWOX/pE7B/RyZnNRPhDC
         EOYSjE2diN7L7X1xaCCHCHxvbeP0DnoPkM+VSbjrieSLcSwPT8gQjx4mAQyzeusbW6
         42JtAinb1UwdA==
From:   trondmy@kernel.org
To:     linux-nfs@vger.kernel.org
Subject: [PATCH v10 25/26] NFS: Optimise away the previous cookie field
Date:   Sun, 13 Mar 2022 13:05:56 -0400
Message-Id: <20220313170557.5940-26-trondmy@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220313170557.5940-25-trondmy@kernel.org>
References: <20220313170557.5940-1-trondmy@kernel.org>
 <20220313170557.5940-2-trondmy@kernel.org>
 <20220313170557.5940-3-trondmy@kernel.org>
 <20220313170557.5940-4-trondmy@kernel.org>
 <20220313170557.5940-5-trondmy@kernel.org>
 <20220313170557.5940-6-trondmy@kernel.org>
 <20220313170557.5940-7-trondmy@kernel.org>
 <20220313170557.5940-8-trondmy@kernel.org>
 <20220313170557.5940-9-trondmy@kernel.org>
 <20220313170557.5940-10-trondmy@kernel.org>
 <20220313170557.5940-11-trondmy@kernel.org>
 <20220313170557.5940-12-trondmy@kernel.org>
 <20220313170557.5940-13-trondmy@kernel.org>
 <20220313170557.5940-14-trondmy@kernel.org>
 <20220313170557.5940-15-trondmy@kernel.org>
 <20220313170557.5940-16-trondmy@kernel.org>
 <20220313170557.5940-17-trondmy@kernel.org>
 <20220313170557.5940-18-trondmy@kernel.org>
 <20220313170557.5940-19-trondmy@kernel.org>
 <20220313170557.5940-20-trondmy@kernel.org>
 <20220313170557.5940-21-trondmy@kernel.org>
 <20220313170557.5940-22-trondmy@kernel.org>
 <20220313170557.5940-23-trondmy@kernel.org>
 <20220313170557.5940-24-trondmy@kernel.org>
 <20220313170557.5940-25-trondmy@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-8.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Trond Myklebust <trond.myklebust@hammerspace.com>

Replace the 'previous cookie' field in struct nfs_entry with the
array->last_cookie.

Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 fs/nfs/dir.c            | 26 ++++++++++++++------------
 fs/nfs/nfs2xdr.c        |  1 -
 fs/nfs/nfs3xdr.c        |  1 -
 fs/nfs/nfs4xdr.c        |  1 -
 include/linux/nfs_xdr.h |  3 +--
 5 files changed, 15 insertions(+), 17 deletions(-)

diff --git a/fs/nfs/dir.c b/fs/nfs/dir.c
index f6aac1e8a8b9..033249a72e92 100644
--- a/fs/nfs/dir.c
+++ b/fs/nfs/dir.c
@@ -301,19 +301,20 @@ static int nfs_readdir_array_can_expand(struct nfs_cache_array *array)
 	return 0;
 }
 
-static
-int nfs_readdir_add_to_array(struct nfs_entry *entry, struct page *page)
+static int nfs_readdir_page_array_append(struct page *page,
+					 const struct nfs_entry *entry,
+					 u64 *cookie)
 {
 	struct nfs_cache_array *array;
 	struct nfs_cache_array_entry *cache_entry;
 	const char *name;
-	int ret;
+	int ret = -ENOMEM;
 
 	name = nfs_readdir_copy_name(entry->name, entry->len);
-	if (!name)
-		return -ENOMEM;
 
 	array = kmap_atomic(page);
+	if (!name)
+		goto out;
 	ret = nfs_readdir_array_can_expand(array);
 	if (ret) {
 		kfree(name);
@@ -321,7 +322,7 @@ int nfs_readdir_add_to_array(struct nfs_entry *entry, struct page *page)
 	}
 
 	cache_entry = &array->array[array->size];
-	cache_entry->cookie = entry->prev_cookie;
+	cache_entry->cookie = array->last_cookie;
 	cache_entry->ino = entry->ino;
 	cache_entry->d_type = entry->d_type;
 	cache_entry->name_len = entry->len;
@@ -333,6 +334,7 @@ int nfs_readdir_add_to_array(struct nfs_entry *entry, struct page *page)
 	if (entry->eof != 0)
 		nfs_readdir_array_set_eof(array);
 out:
+	*cookie = array->last_cookie;
 	kunmap_atomic(array);
 	return ret;
 }
@@ -798,6 +800,7 @@ static int nfs_readdir_page_filler(struct nfs_readdir_descriptor *desc,
 	struct xdr_stream stream;
 	struct xdr_buf buf;
 	struct page *scratch, *new, *page = *arrays;
+	u64 cookie;
 	int status;
 
 	scratch = alloc_page(GFP_KERNEL);
@@ -819,22 +822,21 @@ static int nfs_readdir_page_filler(struct nfs_readdir_descriptor *desc,
 			nfs_prime_dcache(file_dentry(desc->file), entry,
 					desc->dir_verifier);
 
-		status = nfs_readdir_add_to_array(entry, page);
+		status = nfs_readdir_page_array_append(page, entry, &cookie);
 		if (status != -ENOSPC)
 			continue;
 
 		if (page->mapping != mapping) {
 			if (!--narrays)
 				break;
-			new = nfs_readdir_page_array_alloc(entry->prev_cookie,
-							   GFP_KERNEL);
+			new = nfs_readdir_page_array_alloc(cookie, GFP_KERNEL);
 			if (!new)
 				break;
 			arrays++;
 			*arrays = page = new;
 		} else {
-			new = nfs_readdir_page_get_next(
-				mapping, entry->prev_cookie, change_attr);
+			new = nfs_readdir_page_get_next(mapping, cookie,
+							change_attr);
 			if (!new)
 				break;
 			if (page != *arrays)
@@ -842,7 +844,7 @@ static int nfs_readdir_page_filler(struct nfs_readdir_descriptor *desc,
 			page = new;
 		}
 		desc->page_index_max++;
-		status = nfs_readdir_add_to_array(entry, page);
+		status = nfs_readdir_page_array_append(page, entry, &cookie);
 	} while (!status && !entry->eof);
 
 	switch (status) {
diff --git a/fs/nfs/nfs2xdr.c b/fs/nfs/nfs2xdr.c
index 3d5ba43f44bb..05c3b4b2b3dd 100644
--- a/fs/nfs/nfs2xdr.c
+++ b/fs/nfs/nfs2xdr.c
@@ -955,7 +955,6 @@ int nfs2_decode_dirent(struct xdr_stream *xdr, struct nfs_entry *entry,
 	 * The type (size and byte order) of nfscookie isn't defined in
 	 * RFC 1094.  This implementation assumes that it's an XDR uint32.
 	 */
-	entry->prev_cookie = entry->cookie;
 	p = xdr_inline_decode(xdr, 4);
 	if (unlikely(!p))
 		return -EAGAIN;
diff --git a/fs/nfs/nfs3xdr.c b/fs/nfs/nfs3xdr.c
index d6779ceeb39e..3b0b650c9c5a 100644
--- a/fs/nfs/nfs3xdr.c
+++ b/fs/nfs/nfs3xdr.c
@@ -2024,7 +2024,6 @@ int nfs3_decode_dirent(struct xdr_stream *xdr, struct nfs_entry *entry,
 			zero_nfs_fh3(entry->fh);
 	}
 
-	entry->prev_cookie = entry->cookie;
 	entry->cookie = new_cookie;
 
 	return 0;
diff --git a/fs/nfs/nfs4xdr.c b/fs/nfs/nfs4xdr.c
index b7780b97dc4d..86a5f6516928 100644
--- a/fs/nfs/nfs4xdr.c
+++ b/fs/nfs/nfs4xdr.c
@@ -7508,7 +7508,6 @@ int nfs4_decode_dirent(struct xdr_stream *xdr, struct nfs_entry *entry,
 	if (entry->fattr->valid & NFS_ATTR_FATTR_TYPE)
 		entry->d_type = nfs_umode_to_dtype(entry->fattr->mode);
 
-	entry->prev_cookie = entry->cookie;
 	entry->cookie = new_cookie;
 
 	return 0;
diff --git a/include/linux/nfs_xdr.h b/include/linux/nfs_xdr.h
index 728cb0c1f0b6..82f7c2730b9a 100644
--- a/include/linux/nfs_xdr.h
+++ b/include/linux/nfs_xdr.h
@@ -745,8 +745,7 @@ struct nfs_auth_info {
  */
 struct nfs_entry {
 	__u64			ino;
-	__u64			cookie,
-				prev_cookie;
+	__u64			cookie;
 	const char *		name;
 	unsigned int		len;
 	int			eof;
-- 
2.35.1


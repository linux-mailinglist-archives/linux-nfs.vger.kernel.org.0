Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 84CA22A69B1
	for <lists+linux-nfs@lfdr.de>; Wed,  4 Nov 2020 17:27:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731221AbgKDQ1T (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 4 Nov 2020 11:27:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728999AbgKDQ1R (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 4 Nov 2020 11:27:17 -0500
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com [IPv6:2607:f8b0:4864:20::742])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E47F7C0613D3
        for <linux-nfs@vger.kernel.org>; Wed,  4 Nov 2020 08:27:16 -0800 (PST)
Received: by mail-qk1-x742.google.com with SMTP id i21so19073529qka.12
        for <linux-nfs@vger.kernel.org>; Wed, 04 Nov 2020 08:27:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=cZM9YC5VCcFCPCuH5Bz4/PhkiBSQ+y7wr39iOdBSmjo=;
        b=Ckzl4S2c/jN/UGwqkpsuaUKKdXj48WVKEMVbaKqCMr4Ajm624BVrt5h2g9qy0U8TzL
         Q3uxSE0TV81SBuFFdnmIk41w0wht0Ckl41WZ1QzBsfaVqVH59i0eU3brZ3TD9z43PU6o
         kN8NwnLY+mffbCo5rzTdK62UCBxRmGl88yCd1zp05b2OpftQpfMYvpay0U7+WxYOwHWJ
         ZglG19v5bEliR3uRj1tEvEbQg0lJMLghZWL91wCFEAvN0Ndz/OIgra+YJchpHj/5jhoh
         rLMEn9F50HzYhjEzOxrkGpzNA4n5JZUaV3IZBTtTC0SWTVtO0SaRrsr8S7bqoPrxgo8i
         XmTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=cZM9YC5VCcFCPCuH5Bz4/PhkiBSQ+y7wr39iOdBSmjo=;
        b=W1OrgfQeXWPERd/KIi92PiPT1Vw09juoJGiFPvPBh9JD9Lf3IfdKnXoazRDTz9itF/
         Q7ixT6LXcChK4N2POxNmuYvhZY7NK9rgnSUr/NlLMKi9YeYtSwUD9h8xxTjYgnN+d0mo
         3ef04waPppD2SkUSIHrOJ19cRh6OHm12L8PxoNJ4cdMd+KFWlCYtFKovFHHiQtNdYiIK
         X+0v3VY00hGbFyr2TZ8jZJCgihZalhpsV5LyjAf5JY05/xbi16hve2lOpbKnPGpFlnSC
         pG9Txq7GeL6wO2RsLH5V4Yi55JQ4AVvYbwRodIwuZdlOa7DtYjxp6NKd01oIMt8Lz7z/
         79Bw==
X-Gm-Message-State: AOAM5323GHq48jlCUlBn+v8l6Zu9u6+9HYiOYmPAtqJmOjTb20q5czKm
        02fT2yggkBosnAHgBmljdVyRM/JqxVjr
X-Google-Smtp-Source: ABdhPJyVE8/9mGRTKWT89bzSZ7kZqgkGTYiJQSnQlgSguTRsmW4CqSpz9WeWmRHkXJpS1CH9YeJWLA==
X-Received: by 2002:a37:76c7:: with SMTP id r190mr25676564qkc.416.1604507235852;
        Wed, 04 Nov 2020 08:27:15 -0800 (PST)
Received: from localhost.localdomain (c-68-36-133-222.hsd1.mi.comcast.net. [68.36.133.222])
        by smtp.gmail.com with ESMTPSA id g78sm2896924qke.88.2020.11.04.08.27.14
        for <linux-nfs@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2020 08:27:15 -0800 (PST)
From:   trondmy@gmail.com
X-Google-Original-From: trond.myklebust@hammerspace.com
To:     linux-nfs@vger.kernel.org
Subject: [PATCH v3 13/17] NFS: Cleanup to remove nfs_readdir_descriptor_t typedef
Date:   Wed,  4 Nov 2020 11:16:34 -0500
Message-Id: <20201104161638.300324-14-trond.myklebust@hammerspace.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201104161638.300324-13-trond.myklebust@hammerspace.com>
References: <20201104161638.300324-1-trond.myklebust@hammerspace.com>
 <20201104161638.300324-2-trond.myklebust@hammerspace.com>
 <20201104161638.300324-3-trond.myklebust@hammerspace.com>
 <20201104161638.300324-4-trond.myklebust@hammerspace.com>
 <20201104161638.300324-5-trond.myklebust@hammerspace.com>
 <20201104161638.300324-6-trond.myklebust@hammerspace.com>
 <20201104161638.300324-7-trond.myklebust@hammerspace.com>
 <20201104161638.300324-8-trond.myklebust@hammerspace.com>
 <20201104161638.300324-9-trond.myklebust@hammerspace.com>
 <20201104161638.300324-10-trond.myklebust@hammerspace.com>
 <20201104161638.300324-11-trond.myklebust@hammerspace.com>
 <20201104161638.300324-12-trond.myklebust@hammerspace.com>
 <20201104161638.300324-13-trond.myklebust@hammerspace.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Trond Myklebust <trond.myklebust@hammerspace.com>

Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 fs/nfs/dir.c | 30 +++++++++++++-----------------
 1 file changed, 13 insertions(+), 17 deletions(-)

diff --git a/fs/nfs/dir.c b/fs/nfs/dir.c
index c3af54640f6c..b226f6f3ae96 100644
--- a/fs/nfs/dir.c
+++ b/fs/nfs/dir.c
@@ -144,7 +144,7 @@ struct nfs_cache_array {
 	struct nfs_cache_array_entry array[];
 };
 
-typedef struct nfs_readdir_descriptor {
+struct nfs_readdir_descriptor {
 	struct file	*file;
 	struct page	*page;
 	struct dir_context *ctx;
@@ -163,7 +163,7 @@ typedef struct nfs_readdir_descriptor {
 	signed char duped;
 	bool plus;
 	bool eof;
-} nfs_readdir_descriptor_t;
+};
 
 static void nfs_readdir_array_init(struct nfs_cache_array *array)
 {
@@ -362,8 +362,8 @@ bool nfs_readdir_use_cookie(const struct file *filp)
 	return true;
 }
 
-static
-int nfs_readdir_search_for_pos(struct nfs_cache_array *array, nfs_readdir_descriptor_t *desc)
+static int nfs_readdir_search_for_pos(struct nfs_cache_array *array,
+				      struct nfs_readdir_descriptor *desc)
 {
 	loff_t diff = desc->ctx->pos - desc->current_index;
 	unsigned int index;
@@ -394,8 +394,8 @@ nfs_readdir_inode_mapping_valid(struct nfs_inode *nfsi)
 	return !test_bit(NFS_INO_INVALIDATING, &nfsi->flags);
 }
 
-static
-int nfs_readdir_search_for_cookie(struct nfs_cache_array *array, nfs_readdir_descriptor_t *desc)
+static int nfs_readdir_search_for_cookie(struct nfs_cache_array *array,
+					 struct nfs_readdir_descriptor *desc)
 {
 	int i;
 	loff_t new_pos;
@@ -443,8 +443,7 @@ int nfs_readdir_search_for_cookie(struct nfs_cache_array *array, nfs_readdir_des
 	return status;
 }
 
-static
-int nfs_readdir_search_array(nfs_readdir_descriptor_t *desc)
+static int nfs_readdir_search_array(struct nfs_readdir_descriptor *desc)
 {
 	struct nfs_cache_array *array;
 	int status;
@@ -497,7 +496,7 @@ static int nfs_readdir_xdr_filler(struct nfs_readdir_descriptor *desc,
 	return error;
 }
 
-static int xdr_decode(nfs_readdir_descriptor_t *desc,
+static int xdr_decode(struct nfs_readdir_descriptor *desc,
 		      struct nfs_entry *entry, struct xdr_stream *xdr)
 {
 	struct inode *inode = file_inode(desc->file);
@@ -757,8 +756,8 @@ static struct page **nfs_readdir_alloc_pages(size_t npages)
 	return NULL;
 }
 
-static
-int nfs_readdir_xdr_to_array(nfs_readdir_descriptor_t *desc, struct page *page, struct inode *inode)
+static int nfs_readdir_xdr_to_array(struct nfs_readdir_descriptor *desc,
+				    struct page *page, struct inode *inode)
 {
 	struct page **pages;
 	struct nfs_entry *entry;
@@ -838,8 +837,7 @@ nfs_readdir_page_get_cached(struct nfs_readdir_descriptor *desc)
  * Returns 0 if desc->dir_cookie was found on page desc->page_index
  * and locks the page to prevent removal from the page cache.
  */
-static
-int find_and_lock_cache_page(nfs_readdir_descriptor_t *desc)
+static int find_and_lock_cache_page(struct nfs_readdir_descriptor *desc)
 {
 	struct inode *inode = file_inode(desc->file);
 	struct nfs_inode *nfsi = NFS_I(inode);
@@ -864,8 +862,7 @@ int find_and_lock_cache_page(nfs_readdir_descriptor_t *desc)
 }
 
 /* Search for desc->dir_cookie from the beginning of the page cache */
-static inline
-int readdir_search_pagecache(nfs_readdir_descriptor_t *desc)
+static int readdir_search_pagecache(struct nfs_readdir_descriptor *desc)
 {
 	int res;
 
@@ -930,8 +927,7 @@ static void nfs_do_filldir(struct nfs_readdir_descriptor *desc)
  *	 we should already have a complete representation of the
  *	 directory in the page cache by the time we get here.
  */
-static inline
-int uncached_readdir(nfs_readdir_descriptor_t *desc)
+static int uncached_readdir(struct nfs_readdir_descriptor *desc)
 {
 	struct page	*page = NULL;
 	int		status;
-- 
2.28.0


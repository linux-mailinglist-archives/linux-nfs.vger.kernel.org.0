Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D50A84C4DD4
	for <lists+linux-nfs@lfdr.de>; Fri, 25 Feb 2022 19:36:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233367AbiBYSfU (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 25 Feb 2022 13:35:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233363AbiBYSfQ (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 25 Feb 2022 13:35:16 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E3161A9069
        for <linux-nfs@vger.kernel.org>; Fri, 25 Feb 2022 10:34:41 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 9E118B8330E
        for <linux-nfs@vger.kernel.org>; Fri, 25 Feb 2022 18:34:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 172D1C340F1
        for <linux-nfs@vger.kernel.org>; Fri, 25 Feb 2022 18:34:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645814078;
        bh=zYhvub24lZwHSGJubm8T+/Fb/2omFYNma1blsw8u/iU=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=dcLkRgFDY6MYPHiOTyEd4QsvSlUxrN7+Nwdte1VIrmh4Sxe/YkwLjCK27w6YB+sno
         C3JVw2n2X7dtWvxyfpUXaapDie1WScFyuRbTGsK9h3wEESASgULXiwDhFhBQRUTq+o
         K8jYAQFMEMToIelxbObjbMe0s1mGOsCMtrZyQY85KM+qtrtCR0H0O97mBXXeXyQarI
         WuoQUcSvrRUQtuZC38/+382YLqur2NTgpVUd6hHql5dRzBWev6iOOpLBDbodhQTFbv
         FxnPvPe8w3f4LyALSELCJgRPz0Nn3fxGyhU1cdHHpT36CS214X+4UzZk5JJ9lp2jU6
         UVb/S1XX3ZtUA==
From:   trondmy@kernel.org
To:     linux-nfs@vger.kernel.org
Subject: [PATCH v8 06/24] NFS: Calculate page offsets algorithmically
Date:   Fri, 25 Feb 2022 13:28:11 -0500
Message-Id: <20220225182829.1236093-7-trondmy@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220225182829.1236093-6-trondmy@kernel.org>
References: <20220225182829.1236093-1-trondmy@kernel.org>
 <20220225182829.1236093-2-trondmy@kernel.org>
 <20220225182829.1236093-3-trondmy@kernel.org>
 <20220225182829.1236093-4-trondmy@kernel.org>
 <20220225182829.1236093-5-trondmy@kernel.org>
 <20220225182829.1236093-6-trondmy@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Trond Myklebust <trond.myklebust@hammerspace.com>

Instead of relying on counting the page offsets as we walk through the
page cache, switch to calculating them algorithmically.

Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 fs/nfs/dir.c | 18 +++++++++++++-----
 1 file changed, 13 insertions(+), 5 deletions(-)

diff --git a/fs/nfs/dir.c b/fs/nfs/dir.c
index 379f88b158fb..6f0a38db6c37 100644
--- a/fs/nfs/dir.c
+++ b/fs/nfs/dir.c
@@ -249,17 +249,20 @@ static const char *nfs_readdir_copy_name(const char *name, unsigned int len)
 	return ret;
 }
 
+static size_t nfs_readdir_array_maxentries(void)
+{
+	return (PAGE_SIZE - sizeof(struct nfs_cache_array)) /
+	       sizeof(struct nfs_cache_array_entry);
+}
+
 /*
  * Check that the next array entry lies entirely within the page bounds
  */
 static int nfs_readdir_array_can_expand(struct nfs_cache_array *array)
 {
-	struct nfs_cache_array_entry *cache_entry;
-
 	if (array->page_full)
 		return -ENOSPC;
-	cache_entry = &array->array[array->size + 1];
-	if ((char *)cache_entry - (char *)array > PAGE_SIZE) {
+	if (array->size == nfs_readdir_array_maxentries()) {
 		array->page_full = 1;
 		return -ENOSPC;
 	}
@@ -318,6 +321,11 @@ static struct page *nfs_readdir_page_get_locked(struct address_space *mapping,
 	return page;
 }
 
+static loff_t nfs_readdir_page_offset(struct page *page)
+{
+	return (loff_t)page->index * (loff_t)nfs_readdir_array_maxentries();
+}
+
 static u64 nfs_readdir_page_last_cookie(struct page *page)
 {
 	struct nfs_cache_array *array;
@@ -448,7 +456,7 @@ static int nfs_readdir_search_for_cookie(struct nfs_cache_array *array,
 		if (array->array[i].cookie == desc->dir_cookie) {
 			struct nfs_inode *nfsi = NFS_I(file_inode(desc->file));
 
-			new_pos = desc->current_index + i;
+			new_pos = nfs_readdir_page_offset(desc->page) + i;
 			if (desc->attr_gencount != nfsi->attr_gencount ||
 			    !nfs_readdir_inode_mapping_valid(nfsi)) {
 				desc->duped = 0;
-- 
2.35.1


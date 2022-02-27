Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CC554C5FD3
	for <lists+linux-nfs@lfdr.de>; Mon, 28 Feb 2022 00:18:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232200AbiB0XTT (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sun, 27 Feb 2022 18:19:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232190AbiB0XTR (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sun, 27 Feb 2022 18:19:17 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A44022504
        for <linux-nfs@vger.kernel.org>; Sun, 27 Feb 2022 15:18:40 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C6B2BB80B9D
        for <linux-nfs@vger.kernel.org>; Sun, 27 Feb 2022 23:18:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4543BC340E9
        for <linux-nfs@vger.kernel.org>; Sun, 27 Feb 2022 23:18:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646003917;
        bh=hxke4oEQ5V2eoqm1zKSZkP5YTLZewRZn8run3leV5e0=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=c53w0LVvFJdU3k7KoSxq/MgcpitgTwvXF1oZ0iZfw1IQ2D+CIL4L0SBfBULhCZrV/
         rTVWGveBX1walk3OKvh1LnfbUS3bQWWZ/kmP31yb9Bbi3+E2N7Ql1W3L+DrQWP2Nqm
         K3e7aRiLRK8AVe4TG6cqwrAtDoKOeLfrnZz+HjjgcC2dj9eZgHEDdN6jWASxvBtiq4
         eT4G5da7ygcCgr0S5yIvTKJL2J+/0J4GmU0bOq4wvh2CnCZfLr0S7btfvO6vpa5aSm
         nE0F9HZRi55lr+Av+/NxXVMGp7T/TqyP9dPzJKFAUwWSuPQHiEskZSHD86HfIUXqLh
         po7R3O7FR5KXg==
From:   trondmy@kernel.org
To:     linux-nfs@vger.kernel.org
Subject: [PATCH v9 09/27] NFS: Don't advance the page pointer unless the page is full
Date:   Sun, 27 Feb 2022 18:12:09 -0500
Message-Id: <20220227231227.9038-10-trondmy@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220227231227.9038-9-trondmy@kernel.org>
References: <20220227231227.9038-1-trondmy@kernel.org>
 <20220227231227.9038-2-trondmy@kernel.org>
 <20220227231227.9038-3-trondmy@kernel.org>
 <20220227231227.9038-4-trondmy@kernel.org>
 <20220227231227.9038-5-trondmy@kernel.org>
 <20220227231227.9038-6-trondmy@kernel.org>
 <20220227231227.9038-7-trondmy@kernel.org>
 <20220227231227.9038-8-trondmy@kernel.org>
 <20220227231227.9038-9-trondmy@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Trond Myklebust <trond.myklebust@hammerspace.com>

When we hit the end of the data in the readdir page, we don't want to
start filling a new page, unless this one is full.

Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 fs/nfs/dir.c | 32 ++++++++++++++++++++++----------
 1 file changed, 22 insertions(+), 10 deletions(-)

diff --git a/fs/nfs/dir.c b/fs/nfs/dir.c
index 37f78b0ebc40..e2aafc7263d5 100644
--- a/fs/nfs/dir.c
+++ b/fs/nfs/dir.c
@@ -417,6 +417,18 @@ bool nfs_readdir_use_cookie(const struct file *filp)
 	return true;
 }
 
+static void nfs_readdir_seek_next_array(struct nfs_cache_array *array,
+					struct nfs_readdir_descriptor *desc)
+{
+	if (array->page_full) {
+		desc->last_cookie = array->last_cookie;
+		desc->current_index += array->size;
+		desc->cache_entry_index = 0;
+		desc->page_index++;
+	} else
+		desc->last_cookie = array->array[0].cookie;
+}
+
 static int nfs_readdir_search_for_pos(struct nfs_cache_array *array,
 				      struct nfs_readdir_descriptor *desc)
 {
@@ -428,6 +440,7 @@ static int nfs_readdir_search_for_pos(struct nfs_cache_array *array,
 	if (diff >= array->size) {
 		if (array->page_is_eof)
 			goto out_eof;
+		nfs_readdir_seek_next_array(array, desc);
 		return -EAGAIN;
 	}
 
@@ -500,7 +513,8 @@ static int nfs_readdir_search_for_cookie(struct nfs_cache_array *array,
 		status = -EBADCOOKIE;
 		if (desc->dir_cookie == array->last_cookie)
 			desc->eof = true;
-	}
+	} else
+		nfs_readdir_seek_next_array(array, desc);
 out:
 	return status;
 }
@@ -517,11 +531,6 @@ static int nfs_readdir_search_array(struct nfs_readdir_descriptor *desc)
 	else
 		status = nfs_readdir_search_for_cookie(array, desc);
 
-	if (status == -EAGAIN) {
-		desc->last_cookie = array->last_cookie;
-		desc->current_index += array->size;
-		desc->page_index++;
-	}
 	kunmap_atomic(array);
 	return status;
 }
@@ -998,7 +1007,7 @@ static void nfs_do_filldir(struct nfs_readdir_descriptor *desc,
 {
 	struct file	*file = desc->file;
 	struct nfs_cache_array *array;
-	unsigned int i = 0;
+	unsigned int i;
 
 	array = kmap(desc->page);
 	for (i = desc->cache_entry_index; i < array->size; i++) {
@@ -1011,10 +1020,13 @@ static void nfs_do_filldir(struct nfs_readdir_descriptor *desc,
 			break;
 		}
 		memcpy(desc->verf, verf, sizeof(desc->verf));
-		if (i < (array->size-1))
-			desc->dir_cookie = array->array[i+1].cookie;
-		else
+		if (i == array->size - 1) {
 			desc->dir_cookie = array->last_cookie;
+			nfs_readdir_seek_next_array(array, desc);
+		} else {
+			desc->dir_cookie = array->array[i + 1].cookie;
+			desc->last_cookie = array->array[0].cookie;
+		}
 		if (nfs_readdir_use_cookie(file))
 			desc->ctx->pos = desc->dir_cookie;
 		else
-- 
2.35.1


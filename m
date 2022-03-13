Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4CC84D7727
	for <lists+linux-nfs@lfdr.de>; Sun, 13 Mar 2022 18:12:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235114AbiCMRNZ (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sun, 13 Mar 2022 13:13:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235110AbiCMRNV (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sun, 13 Mar 2022 13:13:21 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E0CE139CDD
        for <linux-nfs@vger.kernel.org>; Sun, 13 Mar 2022 10:12:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D8A8FB80CAD
        for <linux-nfs@vger.kernel.org>; Sun, 13 Mar 2022 17:12:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 737ECC36AE2
        for <linux-nfs@vger.kernel.org>; Sun, 13 Mar 2022 17:12:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647191532;
        bh=BYlwUn6az1+bsg3Myp7WHMGA2p94bD+ZYtxYgI2JZjQ=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=YoxtoBsMscWSZmwwstJaZaCl9gS5S3Mku7er4gZfNN2NkK8rWwbsbUelgpZVaCcAi
         tfRBUhI49JKZyI7Eu2piZ7nbfq8/A5iUmFvco8LdrUm8b35VG5p/q0RhXSGpNt2AmP
         0FFVd4fuz5F4ucKq+OgR3rtA/S2JWIRD/FgVL6CSo9crkyUxjerKifueQUQQk0XxGO
         7vhGMKiOh5L2C+Z+h3i6At62dlU+jbkEACPRlbgGHKEp6VEtUcnFjXhG1CIRmKDcuw
         xxkuvgh+lY9jAy4weRPL1K7StX9b9N/ITtD7XjrsVx7ISMAVbK4YMU7Xot4Xh7XUPo
         nXxJzZ9hY2/yw==
From:   trondmy@kernel.org
To:     linux-nfs@vger.kernel.org
Subject: [PATCH v10 22/26] NFS: Clean up page array initialisation/free
Date:   Sun, 13 Mar 2022 13:05:53 -0400
Message-Id: <20220313170557.5940-23-trondmy@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220313170557.5940-22-trondmy@kernel.org>
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

Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 fs/nfs/dir.c | 16 ++++++----------
 1 file changed, 6 insertions(+), 10 deletions(-)

diff --git a/fs/nfs/dir.c b/fs/nfs/dir.c
index 8a246df98db5..4983950de2ad 100644
--- a/fs/nfs/dir.c
+++ b/fs/nfs/dir.c
@@ -199,20 +199,17 @@ static void nfs_grow_dtsize(struct nfs_readdir_descriptor *desc)
 	nfs_set_dtsize(desc, desc->dtsize << 1);
 }
 
-static void nfs_readdir_array_init(struct nfs_cache_array *array)
-{
-	memset(array, 0, sizeof(struct nfs_cache_array));
-}
-
 static void nfs_readdir_page_init_array(struct page *page, u64 last_cookie,
 					u64 change_attr)
 {
 	struct nfs_cache_array *array;
 
 	array = kmap_atomic(page);
-	nfs_readdir_array_init(array);
 	array->change_attr = change_attr;
 	array->last_cookie = last_cookie;
+	array->size = 0;
+	array->page_full = 0;
+	array->page_is_eof = 0;
 	array->cookies_are_ordered = 1;
 	kunmap_atomic(array);
 }
@@ -220,16 +217,15 @@ static void nfs_readdir_page_init_array(struct page *page, u64 last_cookie,
 /*
  * we are freeing strings created by nfs_add_to_readdir_array()
  */
-static
-void nfs_readdir_clear_array(struct page *page)
+static void nfs_readdir_clear_array(struct page *page)
 {
 	struct nfs_cache_array *array;
-	int i;
+	unsigned int i;
 
 	array = kmap_atomic(page);
 	for (i = 0; i < array->size; i++)
 		kfree(array->array[i].name);
-	nfs_readdir_array_init(array);
+	array->size = 0;
 	kunmap_atomic(array);
 }
 
-- 
2.35.1


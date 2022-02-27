Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12E904C5FDB
	for <lists+linux-nfs@lfdr.de>; Mon, 28 Feb 2022 00:18:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232212AbiB0XTW (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sun, 27 Feb 2022 18:19:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232201AbiB0XTV (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sun, 27 Feb 2022 18:19:21 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0991822502
        for <linux-nfs@vger.kernel.org>; Sun, 27 Feb 2022 15:18:43 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DEACA611D7
        for <linux-nfs@vger.kernel.org>; Sun, 27 Feb 2022 23:18:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84EF1C340F2
        for <linux-nfs@vger.kernel.org>; Sun, 27 Feb 2022 23:18:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646003922;
        bh=wTKbrsWXYsWLXdci+cjvw5WSje4bJ4LWqMPOwfCWTdU=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=aRk6WdTIPUk9tmONUGpd7LNMcRnBhPpTJXp8Y6uPWcmPy4wnTGPwFYbW9H0PJULp/
         w2HN38SPxiV2gqxH5NUwHLxwWWvyP1I5Z5vAFcaijqbYbav7Jj10H9KYM7dO3iljir
         fQ4QTM2w4brog06Tp4Jd8o+Porl1GbjIlxq4rqj4TYe2k9apPNov9lr8E2qguQACbq
         OcEgB/jX2RmTw2UCgQc3lvABDH7qa/030km7+40buJ7eWmwUGZRdDcFi6uqzUu586Y
         HBPnhzR2cwoY9DtmAztj6ryXY5sJVDK3an9UjuC7sVxvd3zGCgRx6eqstt+n/Q8Not
         uIvZotcfUxUWA==
From:   trondmy@kernel.org
To:     linux-nfs@vger.kernel.org
Subject: [PATCH v9 22/27] NFS: Clean up page array initialisation/free
Date:   Sun, 27 Feb 2022 18:12:22 -0500
Message-Id: <20220227231227.9038-23-trondmy@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220227231227.9038-22-trondmy@kernel.org>
References: <20220227231227.9038-1-trondmy@kernel.org>
 <20220227231227.9038-2-trondmy@kernel.org>
 <20220227231227.9038-3-trondmy@kernel.org>
 <20220227231227.9038-4-trondmy@kernel.org>
 <20220227231227.9038-5-trondmy@kernel.org>
 <20220227231227.9038-6-trondmy@kernel.org>
 <20220227231227.9038-7-trondmy@kernel.org>
 <20220227231227.9038-8-trondmy@kernel.org>
 <20220227231227.9038-9-trondmy@kernel.org>
 <20220227231227.9038-10-trondmy@kernel.org>
 <20220227231227.9038-11-trondmy@kernel.org>
 <20220227231227.9038-12-trondmy@kernel.org>
 <20220227231227.9038-13-trondmy@kernel.org>
 <20220227231227.9038-14-trondmy@kernel.org>
 <20220227231227.9038-15-trondmy@kernel.org>
 <20220227231227.9038-16-trondmy@kernel.org>
 <20220227231227.9038-17-trondmy@kernel.org>
 <20220227231227.9038-18-trondmy@kernel.org>
 <20220227231227.9038-19-trondmy@kernel.org>
 <20220227231227.9038-20-trondmy@kernel.org>
 <20220227231227.9038-21-trondmy@kernel.org>
 <20220227231227.9038-22-trondmy@kernel.org>
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

Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 fs/nfs/dir.c | 16 ++++++----------
 1 file changed, 6 insertions(+), 10 deletions(-)

diff --git a/fs/nfs/dir.c b/fs/nfs/dir.c
index 483bb67d2ace..95a29a973dc8 100644
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


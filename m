Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F5CA4E47FF
	for <lists+linux-nfs@lfdr.de>; Tue, 22 Mar 2022 22:00:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229977AbiCVVCX (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 22 Mar 2022 17:02:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235125AbiCVVCT (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 22 Mar 2022 17:02:19 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51ACA4CD5F
        for <linux-nfs@vger.kernel.org>; Tue, 22 Mar 2022 14:00:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 4C8DEB81D5F
        for <linux-nfs@vger.kernel.org>; Tue, 22 Mar 2022 21:00:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB904C340EE
        for <linux-nfs@vger.kernel.org>; Tue, 22 Mar 2022 21:00:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647982847;
        bh=0SVr2ufzeeyl33sw+TQu6hZD79b6u1aRfo44EvssCjA=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=o3wmiVCo8A6ZwvZB5O1wWAKyKllaWy06VzMtbxB5coG4jezwqV69exZfyWhecQJBh
         vFqxfVDC5bx6r2ecuE/p2q4Fv1Ig0qwEUFuu0MgOFStxxF8OCfH7izWUC776AKuxUg
         XFnXdSxVKViBnZOF+rfy9ScT57qs9LGnyw8940CFZLLuI4KYTwP3hRZANnMW4HqlOk
         Ncc4gp6mT17PyWpve/nOhEz/r1+GKI/+/OFUAw13LcjB1snIBPxnMAIwy0wdqGy6F9
         GY/KXx1xXE9AVMr0QZ6bMbjIhrKv56TyxLfFtUwTf00dMXPI59ETfjtmr8j9ZFrSI2
         IQAQZPxhGajdg==
From:   trondmy@kernel.org
To:     linux-nfs@vger.kernel.org
Subject: [PATCH 1/2] NFS: Don't deadlock when cookie hashes collide
Date:   Tue, 22 Mar 2022 16:54:20 -0400
Message-Id: <20220322205421.726627-2-trondmy@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220322205421.726627-1-trondmy@kernel.org>
References: <20220322205421.726627-1-trondmy@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Trond Myklebust <trond.myklebust@hammerspace.com>

In the very rare case where the readdir reply contains multiple cookies
that map to the same hash value, we can end up deadlocking waiting for a
page lock that we already hold. In this case we should fail the page
lock by using grab_cache_page_nowait().

Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 fs/nfs/dir.c | 29 ++++++++++++++++++-----------
 1 file changed, 18 insertions(+), 11 deletions(-)

diff --git a/fs/nfs/dir.c b/fs/nfs/dir.c
index 7e12102b29e7..17986c0019d4 100644
--- a/fs/nfs/dir.c
+++ b/fs/nfs/dir.c
@@ -381,23 +381,28 @@ static void nfs_readdir_page_unlock_and_put(struct page *page)
 	put_page(page);
 }
 
+static void nfs_readdir_page_init_and_validate(struct page *page, u64 cookie,
+					       u64 change_attr)
+{
+	if (PageUptodate(page)) {
+		if (nfs_readdir_page_validate(page, cookie, change_attr))
+			return;
+		nfs_readdir_clear_array(page);
+	}
+	nfs_readdir_page_init_array(page, cookie, change_attr);
+	SetPageUptodate(page);
+}
+
 static struct page *nfs_readdir_page_get_locked(struct address_space *mapping,
-						u64 last_cookie,
-						u64 change_attr)
+						u64 cookie, u64 change_attr)
 {
-	pgoff_t index = nfs_readdir_page_cookie_hash(last_cookie);
+	pgoff_t index = nfs_readdir_page_cookie_hash(cookie);
 	struct page *page;
 
 	page = grab_cache_page(mapping, index);
 	if (!page)
 		return NULL;
-	if (PageUptodate(page)) {
-		if (nfs_readdir_page_validate(page, last_cookie, change_attr))
-			return page;
-		nfs_readdir_clear_array(page);
-	}
-	nfs_readdir_page_init_array(page, last_cookie, change_attr);
-	SetPageUptodate(page);
+	nfs_readdir_page_init_and_validate(page, cookie, change_attr);
 	return page;
 }
 
@@ -435,11 +440,13 @@ static void nfs_readdir_page_set_eof(struct page *page)
 static struct page *nfs_readdir_page_get_next(struct address_space *mapping,
 					      u64 cookie, u64 change_attr)
 {
+	pgoff_t index = nfs_readdir_page_cookie_hash(cookie);
 	struct page *page;
 
-	page = nfs_readdir_page_get_locked(mapping, cookie, change_attr);
+	page = grab_cache_page_nowait(mapping, index);
 	if (!page)
 		return NULL;
+	nfs_readdir_page_init_and_validate(page, cookie, change_attr);
 	if (nfs_readdir_page_last_cookie(page) != cookie)
 		nfs_readdir_page_reinit_array(page, cookie, change_attr);
 	return page;
-- 
2.35.1


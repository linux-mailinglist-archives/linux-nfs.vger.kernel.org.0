Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 524D04E4800
	for <lists+linux-nfs@lfdr.de>; Tue, 22 Mar 2022 22:00:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230209AbiCVVCX (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 22 Mar 2022 17:02:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235077AbiCVVCR (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 22 Mar 2022 17:02:17 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC4694C436
        for <linux-nfs@vger.kernel.org>; Tue, 22 Mar 2022 14:00:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 014D5616F7
        for <linux-nfs@vger.kernel.org>; Tue, 22 Mar 2022 21:00:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2EA7DC340F2
        for <linux-nfs@vger.kernel.org>; Tue, 22 Mar 2022 21:00:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647982848;
        bh=XZQUWqlAGaEFOuQqdyl/isTRI/AEmaFpMhfuF3pkcjg=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=P+VgKOGgUxDNyeLtZxMVF4QcnXPPNEbS0RbgictvgxcER7D4Uo+QQGzXZIj/9mzg3
         XupnD8hfb+AlbitOCtn8gVBGeujGRUAfM1YKkq1J6EedL3FWF/kSFSfaKdg+fyw960
         vJGYP7NEZciG7NyLgYbif9NESfocwfD6Lsw6m/slaYJh1r07c0CtCxbMI3B8VLvDgt
         sOQrtyyUb8qmsEHtzNVUlNLJ7ncDZbPpIs/RFk6pM0F1hMI9zmXYPQ8gN9C64fUIja
         0gljU5ITi1FUOhQSpCaUoKGBRnF4pgb36vkVnq16Os0uhDisZ59wRDAy0FTACehc2U
         jvJivhk4cungQ==
From:   trondmy@kernel.org
To:     linux-nfs@vger.kernel.org
Subject: [PATCH 2/2] NFS: Fix revalidation of empty readdir pages
Date:   Tue, 22 Mar 2022 16:54:21 -0400
Message-Id: <20220322205421.726627-3-trondmy@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220322205421.726627-2-trondmy@kernel.org>
References: <20220322205421.726627-1-trondmy@kernel.org>
 <20220322205421.726627-2-trondmy@kernel.org>
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

If the page is empty, we need to check the array->last_cookie instead of
the first entry. Add a helper for the cases where we care.

Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 fs/nfs/dir.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/fs/nfs/dir.c b/fs/nfs/dir.c
index 17986c0019d4..bac4cf1a308e 100644
--- a/fs/nfs/dir.c
+++ b/fs/nfs/dir.c
@@ -252,6 +252,11 @@ static void nfs_readdir_page_array_free(struct page *page)
 	}
 }
 
+static u64 nfs_readdir_array_index_cookie(struct nfs_cache_array *array)
+{
+	return array->size == 0 ? array->last_cookie : array->array[0].cookie;
+}
+
 static void nfs_readdir_array_set_eof(struct nfs_cache_array *array)
 {
 	array->page_is_eof = 1;
@@ -369,7 +374,7 @@ static bool nfs_readdir_page_validate(struct page *page, u64 last_cookie,
 
 	if (array->change_attr != change_attr)
 		ret = false;
-	if (array->size > 0 && array->array[0].cookie != last_cookie)
+	if (nfs_readdir_array_index_cookie(array) != last_cookie)
 		ret = false;
 	kunmap_atomic(array);
 	return ret;
@@ -480,7 +485,7 @@ static void nfs_readdir_seek_next_array(struct nfs_cache_array *array,
 		desc->cache_entry_index = 0;
 		desc->page_index++;
 	} else
-		desc->last_cookie = array->array[0].cookie;
+		desc->last_cookie = nfs_readdir_array_index_cookie(array);
 }
 
 static void nfs_readdir_rewind_search(struct nfs_readdir_descriptor *desc)
-- 
2.35.1


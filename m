Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7193B4C4DDF
	for <lists+linux-nfs@lfdr.de>; Fri, 25 Feb 2022 19:36:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233300AbiBYSfZ (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 25 Feb 2022 13:35:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233345AbiBYSfT (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 25 Feb 2022 13:35:19 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EA051B01B0
        for <linux-nfs@vger.kernel.org>; Fri, 25 Feb 2022 10:34:46 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 1F807B83309
        for <linux-nfs@vger.kernel.org>; Fri, 25 Feb 2022 18:34:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92139C340F0
        for <linux-nfs@vger.kernel.org>; Fri, 25 Feb 2022 18:34:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645814085;
        bh=zTUh0Tk58PHGBP7SmvW1skLQZqy/LTcWWM0mY1cHiPQ=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=UDtikHMgv1FsSloHRa5WOWoIOtK/enQxUB700qG5EJYT1HZtJ5sumsAUBL3axa9aS
         TSvow3FgxDdKzVtcxLMhWMYa4WTlJExccxwF2DzNJwHqt8XwWlEjX75RNDs0wxzDQF
         mUed6GgJ5Nr8Le6XMUkVwRkHoscOZLmlSI3MjgRUj5qIBOgmir/px9SPqaJsU/ilD+
         hTn3dcw45g1dIK2aPLuCsEg04AL96AKJuJWUUH9HlpzcW/+FS4Ps6+OQG/f3OJiKNY
         eFTPhhCjcKSBrgAZ3+j4EaV1eJW8hTcx14ChP671u+xPPsTqPQ6IeBjkMMGhs74V8e
         lBTL6xYNZo/ew==
From:   trondmy@kernel.org
To:     linux-nfs@vger.kernel.org
Subject: [PATCH v8 24/24] NFS: Cache all entries in the readdirplus reply
Date:   Fri, 25 Feb 2022 13:28:29 -0500
Message-Id: <20220225182829.1236093-25-trondmy@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220225182829.1236093-24-trondmy@kernel.org>
References: <20220225182829.1236093-1-trondmy@kernel.org>
 <20220225182829.1236093-2-trondmy@kernel.org>
 <20220225182829.1236093-3-trondmy@kernel.org>
 <20220225182829.1236093-4-trondmy@kernel.org>
 <20220225182829.1236093-5-trondmy@kernel.org>
 <20220225182829.1236093-6-trondmy@kernel.org>
 <20220225182829.1236093-7-trondmy@kernel.org>
 <20220225182829.1236093-8-trondmy@kernel.org>
 <20220225182829.1236093-9-trondmy@kernel.org>
 <20220225182829.1236093-10-trondmy@kernel.org>
 <20220225182829.1236093-11-trondmy@kernel.org>
 <20220225182829.1236093-12-trondmy@kernel.org>
 <20220225182829.1236093-13-trondmy@kernel.org>
 <20220225182829.1236093-14-trondmy@kernel.org>
 <20220225182829.1236093-15-trondmy@kernel.org>
 <20220225182829.1236093-16-trondmy@kernel.org>
 <20220225182829.1236093-17-trondmy@kernel.org>
 <20220225182829.1236093-18-trondmy@kernel.org>
 <20220225182829.1236093-19-trondmy@kernel.org>
 <20220225182829.1236093-20-trondmy@kernel.org>
 <20220225182829.1236093-21-trondmy@kernel.org>
 <20220225182829.1236093-22-trondmy@kernel.org>
 <20220225182829.1236093-23-trondmy@kernel.org>
 <20220225182829.1236093-24-trondmy@kernel.org>
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

Even if we're not able to cache all the entries in the readdir buffer,
let's ensure that we do prime the dcache.

Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 fs/nfs/dir.c | 27 +++++++++++++++++----------
 1 file changed, 17 insertions(+), 10 deletions(-)

diff --git a/fs/nfs/dir.c b/fs/nfs/dir.c
index 71f61565c72c..5e9c25a562bf 100644
--- a/fs/nfs/dir.c
+++ b/fs/nfs/dir.c
@@ -789,7 +789,7 @@ static int nfs_readdir_page_filler(struct nfs_readdir_descriptor *desc,
 	struct xdr_stream stream;
 	struct xdr_buf buf;
 	struct page *scratch, *new, *page = *arrays;
-	int status;
+	int err, status = 0;
 
 	scratch = alloc_page(GFP_KERNEL);
 	if (scratch == NULL)
@@ -802,25 +802,32 @@ static int nfs_readdir_page_filler(struct nfs_readdir_descriptor *desc,
 		if (entry->fattr->label)
 			entry->fattr->label->len = NFS4_MAXLABELLEN;
 
-		status = xdr_decode(desc, entry, &stream);
-		if (status != 0)
+		err = xdr_decode(desc, entry, &stream);
+		if (err != 0) {
+			if (!status)
+				status = err;
 			break;
+		}
 
-		if (desc->plus)
+		if (desc->plus) {
 			nfs_prime_dcache(file_dentry(desc->file), entry,
-					desc->dir_verifier);
+					 desc->dir_verifier);
+			if (status == -ENOSPC)
+				continue;
+		}
 
 		status = nfs_readdir_add_to_array(entry, page);
 		if (status != -ENOSPC)
 			continue;
 
 		if (page->mapping != mapping) {
-			if (!--narrays)
-				break;
+			if (narrays <= 1)
+				continue;
 			new = nfs_readdir_page_array_alloc(entry->prev_cookie,
 							   GFP_KERNEL);
 			if (!new)
-				break;
+				continue;
+			narrays--;
 			arrays++;
 			*arrays = page = new;
 		} else {
@@ -829,14 +836,14 @@ static int nfs_readdir_page_filler(struct nfs_readdir_descriptor *desc,
 							change_attr,
 							desc->clear_cache);
 			if (!new)
-				break;
+				continue;
 			if (page != *arrays)
 				nfs_readdir_page_unlock_and_put(page);
 			page = new;
 		}
 		desc->page_index_max++;
 		status = nfs_readdir_add_to_array(entry, page);
-	} while (!status && !entry->eof);
+	} while ((!status || (status == -ENOSPC && desc->plus)) && !entry->eof);
 
 	switch (status) {
 	case -EBADCOOKIE:
-- 
2.35.1


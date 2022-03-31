Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0D304ED29D
	for <lists+linux-nfs@lfdr.de>; Thu, 31 Mar 2022 06:35:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229441AbiCaDs7 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 30 Mar 2022 23:48:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229463AbiCaDs6 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 30 Mar 2022 23:48:58 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A6D1C60
        for <linux-nfs@vger.kernel.org>; Wed, 30 Mar 2022 20:42:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id AA5C2B81EBF
        for <linux-nfs@vger.kernel.org>; Thu, 31 Mar 2022 03:36:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D25C1C340EE
        for <linux-nfs@vger.kernel.org>; Thu, 31 Mar 2022 03:36:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648697810;
        bh=2E1w0gMxAp1swUpkCMOhkLBA/iQpJu3ZHzi3KIm9H9Q=;
        h=From:To:Subject:Date:From;
        b=Cp1AElicMT9JJN+HhxPQy/2BbmU58DUgwzb/piW/HK20lDQCeCqijpfySqdCWyI+D
         Ku7P0tzKUAvdEru+sdoeujgr2HIInBKIYkZE5AlpsJpO4A9EJFGPZHFgT/nSqi9wAO
         hiDEIjti0bUFnrLZJ/zTmiY0GFH2LME9l6voQddicSc2GzRcUYseRAu+lbyRDUCnPb
         yR0X79ESIf8Trb+7/4NS7qPMwIFbsrM0AGZxSJTtoi2yVFvP+P1UTtYek7fglVRknJ
         Qv/wz5eHkGSHbxP3I01NEgpFNeIAFnNaMdQvIsuUiNYGk/wtuKo93xaq1mjRxDtUki
         1LPjY5l4vxaag==
From:   trondmy@kernel.org
To:     linux-nfs@vger.kernel.org
Subject: [PATCH] NFS: Replace readdir's use of xxhash() with hash_64()
Date:   Wed, 30 Mar 2022 23:30:23 -0400
Message-Id: <20220331033023.718688-1-trondmy@kernel.org>
X-Mailer: git-send-email 2.35.1
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

Both xxhash() and hash_64() appear to give similarly low collision
rates with a standard linearly increasing readdir offset. They both give
similarly higher collision rates when applied to ext4's offsets.

So switch to using the standard hash_64().

Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 fs/nfs/Kconfig | 4 ----
 fs/nfs/dir.c   | 9 +++------
 2 files changed, 3 insertions(+), 10 deletions(-)

diff --git a/fs/nfs/Kconfig b/fs/nfs/Kconfig
index 47a53b3362b6..14a72224b657 100644
--- a/fs/nfs/Kconfig
+++ b/fs/nfs/Kconfig
@@ -4,10 +4,6 @@ config NFS_FS
 	depends on INET && FILE_LOCKING && MULTIUSER
 	select LOCKD
 	select SUNRPC
-	select CRYPTO
-	select CRYPTO_HASH
-	select XXHASH
-	select CRYPTO_XXHASH
 	select NFS_ACL_SUPPORT if NFS_V3_ACL
 	help
 	  Choose Y here if you want to access files residing on other
diff --git a/fs/nfs/dir.c b/fs/nfs/dir.c
index 0365063b85a2..c6b263b5faf1 100644
--- a/fs/nfs/dir.c
+++ b/fs/nfs/dir.c
@@ -39,7 +39,7 @@
 #include <linux/sched.h>
 #include <linux/kmemleak.h>
 #include <linux/xattr.h>
-#include <linux/xxhash.h>
+#include <linux/hash.h>
 
 #include "delegation.h"
 #include "iostat.h"
@@ -350,10 +350,7 @@ static int nfs_readdir_page_array_append(struct page *page,
  * of directory cookies. Content is addressed by the value of the
  * cookie index of the first readdir entry in a page.
  *
- * The xxhash algorithm is chosen because it is fast, and is supposed
- * to result in a decent flat distribution of hashes.
- *
- * We then select only the first 18 bits to avoid issues with excessive
+ * We select only the first 18 bits to avoid issues with excessive
  * memory use for the page cache XArray. 18 bits should allow the caching
  * of 262144 pages of sequences of readdir entries. Since each page holds
  * 127 readdir entries for a typical 64-bit system, that works out to a
@@ -363,7 +360,7 @@ static pgoff_t nfs_readdir_page_cookie_hash(u64 cookie)
 {
 	if (cookie == 0)
 		return 0;
-	return xxhash(&cookie, sizeof(cookie), 0) & NFS_READDIR_COOKIE_MASK;
+	return hash_64(cookie, 18);
 }
 
 static bool nfs_readdir_page_validate(struct page *page, u64 last_cookie,
-- 
2.35.1


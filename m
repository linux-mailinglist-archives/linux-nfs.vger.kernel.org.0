Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F421073165C
	for <lists+linux-nfs@lfdr.de>; Thu, 15 Jun 2023 13:20:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244783AbjFOLUZ (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 15 Jun 2023 07:20:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237768AbjFOLUY (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 15 Jun 2023 07:20:24 -0400
Received: from out-35.mta0.migadu.com (out-35.mta0.migadu.com [IPv6:2001:41d0:1004:224b::23])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2531E2705
        for <linux-nfs@vger.kernel.org>; Thu, 15 Jun 2023 04:20:23 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1686828021;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=nIxdhPGdAgLyMLxuVgcyuLg/UnjLIh4DAJ6AXRw1tR4=;
        b=AAr4/F3Nn3QI2UKEhNZ4fz50qOboCA054aB1Zc3zs166eJpYzUls65WVhLwG28nrTMbfnF
        WaD4WQ9EaswJeoKuYKn7aqc4LL4nJskEbfPSFNGJFuxDTw5+/yeQ215D9lrRjKsaavJtqA
        Uxy24aRqOdo2ls08qpPqkzaJGzN+q0o=
From:   Qi Zheng <qi.zheng@linux.dev>
To:     trond.myklebust@hammerspace.com, anna@kernel.org,
        fllinden@amazon.com
Cc:     linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        Qi Zheng <zhengqi.arch@bytedance.com>
Subject: [PATCH v2] NFSv4.2: fix wrong shrinker_id
Date:   Thu, 15 Jun 2023 11:19:46 +0000
Message-Id: <20230615111946.3376012-1-qi.zheng@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Qi Zheng <zhengqi.arch@bytedance.com>

Currently, the list_lru::shrinker_id corresponding to the nfs4_xattr
shrinkers is wrong:

>>> prog["nfs4_xattr_cache_lru"].shrinker_id
(int)0
>>> prog["nfs4_xattr_entry_lru"].shrinker_id
(int)0
>>> prog["nfs4_xattr_large_entry_lru"].shrinker_id
(int)0
>>> prog["nfs4_xattr_cache_shrinker"].id
(int)18
>>> prog["nfs4_xattr_entry_shrinker"].id
(int)19
>>> prog["nfs4_xattr_large_entry_shrinker"].id
(int)20

This is not what we expect, which will cause these shrinkers
not to be found in shrink_slab_memcg().

We should assign shrinker::id before calling list_lru_init_memcg(),
so that the corresponding list_lru::shrinker_id will be assigned
the correct value like below:

>>> prog["nfs4_xattr_cache_lru"].shrinker_id
(int)16
>>> prog["nfs4_xattr_entry_lru"].shrinker_id
(int)17
>>> prog["nfs4_xattr_large_entry_lru"].shrinker_id
(int)18
>>> prog["nfs4_xattr_cache_shrinker"].id
(int)16
>>> prog["nfs4_xattr_entry_shrinker"].id
(int)17
>>> prog["nfs4_xattr_large_entry_shrinker"].id
(int)18

So just do it.

Fixes: 95ad37f90c33 ("NFSv4.2: add client side xattr caching.")
Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
---
Changlog in v1 -> v2:
 - To avoid exporting more symblos, use register_shrinker() instead of
   prealloc_shrinker() and register_shrinker_prepared().

 fs/nfs/nfs42xattr.c | 79 +++++++++++++++++++++++++--------------------
 1 file changed, 44 insertions(+), 35 deletions(-)

diff --git a/fs/nfs/nfs42xattr.c b/fs/nfs/nfs42xattr.c
index 76ae11834206..911f634ba3da 100644
--- a/fs/nfs/nfs42xattr.c
+++ b/fs/nfs/nfs42xattr.c
@@ -991,6 +991,29 @@ static void nfs4_xattr_cache_init_once(void *p)
 	INIT_LIST_HEAD(&cache->dispose);
 }
 
+static int nfs4_xattr_shrinker_init(struct shrinker *shrinker,
+				    struct list_lru *lru, const char *name)
+{
+	int ret = 0;
+
+	ret = register_shrinker(shrinker, name);
+	if (ret)
+		return ret;
+
+	ret = list_lru_init_memcg(lru, shrinker);
+	if (ret)
+		unregister_shrinker(shrinker);
+
+	return ret;
+}
+
+static void nfs4_xattr_shrinker_destroy(struct shrinker *shrinker,
+					struct list_lru *lru)
+{
+	unregister_shrinker(shrinker);
+	list_lru_destroy(lru);
+}
+
 int __init nfs4_xattr_cache_init(void)
 {
 	int ret = 0;
@@ -1002,44 +1025,30 @@ int __init nfs4_xattr_cache_init(void)
 	if (nfs4_xattr_cache_cachep == NULL)
 		return -ENOMEM;
 
-	ret = list_lru_init_memcg(&nfs4_xattr_large_entry_lru,
-	    &nfs4_xattr_large_entry_shrinker);
-	if (ret)
-		goto out4;
-
-	ret = list_lru_init_memcg(&nfs4_xattr_entry_lru,
-	    &nfs4_xattr_entry_shrinker);
-	if (ret)
-		goto out3;
-
-	ret = list_lru_init_memcg(&nfs4_xattr_cache_lru,
-	    &nfs4_xattr_cache_shrinker);
-	if (ret)
-		goto out2;
-
-	ret = register_shrinker(&nfs4_xattr_cache_shrinker, "nfs-xattr_cache");
+	ret = nfs4_xattr_shrinker_init(&nfs4_xattr_cache_shrinker,
+				       &nfs4_xattr_cache_lru,
+				       "nfs-xattr_cache");
 	if (ret)
 		goto out1;
 
-	ret = register_shrinker(&nfs4_xattr_entry_shrinker, "nfs-xattr_entry");
+	ret = nfs4_xattr_shrinker_init(&nfs4_xattr_entry_shrinker,
+				       &nfs4_xattr_entry_lru,
+				       "nfs-xattr_entry");
 	if (ret)
-		goto out;
+		goto out2;
 
-	ret = register_shrinker(&nfs4_xattr_large_entry_shrinker,
-				"nfs-xattr_large_entry");
+	ret = nfs4_xattr_shrinker_init(&nfs4_xattr_large_entry_shrinker,
+				       &nfs4_xattr_large_entry_lru,
+				       "nfs-xattr_large_entry");
 	if (!ret)
 		return 0;
 
-	unregister_shrinker(&nfs4_xattr_entry_shrinker);
-out:
-	unregister_shrinker(&nfs4_xattr_cache_shrinker);
-out1:
-	list_lru_destroy(&nfs4_xattr_cache_lru);
+	nfs4_xattr_shrinker_destroy(&nfs4_xattr_entry_shrinker,
+				    &nfs4_xattr_entry_lru);
 out2:
-	list_lru_destroy(&nfs4_xattr_entry_lru);
-out3:
-	list_lru_destroy(&nfs4_xattr_large_entry_lru);
-out4:
+	nfs4_xattr_shrinker_destroy(&nfs4_xattr_cache_shrinker,
+				    &nfs4_xattr_cache_lru);
+out1:
 	kmem_cache_destroy(nfs4_xattr_cache_cachep);
 
 	return ret;
@@ -1047,11 +1056,11 @@ int __init nfs4_xattr_cache_init(void)
 
 void nfs4_xattr_cache_exit(void)
 {
-	unregister_shrinker(&nfs4_xattr_large_entry_shrinker);
-	unregister_shrinker(&nfs4_xattr_entry_shrinker);
-	unregister_shrinker(&nfs4_xattr_cache_shrinker);
-	list_lru_destroy(&nfs4_xattr_large_entry_lru);
-	list_lru_destroy(&nfs4_xattr_entry_lru);
-	list_lru_destroy(&nfs4_xattr_cache_lru);
+	nfs4_xattr_shrinker_destroy(&nfs4_xattr_large_entry_shrinker,
+				    &nfs4_xattr_large_entry_lru);
+	nfs4_xattr_shrinker_destroy(&nfs4_xattr_entry_shrinker,
+				    &nfs4_xattr_entry_lru);
+	nfs4_xattr_shrinker_destroy(&nfs4_xattr_cache_shrinker,
+				    &nfs4_xattr_cache_lru);
 	kmem_cache_destroy(nfs4_xattr_cache_cachep);
 }
-- 
2.30.2


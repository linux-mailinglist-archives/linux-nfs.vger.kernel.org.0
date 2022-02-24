Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C04014C3161
	for <lists+linux-nfs@lfdr.de>; Thu, 24 Feb 2022 17:32:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229798AbiBXQbX (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 24 Feb 2022 11:31:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229674AbiBXQbX (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 24 Feb 2022 11:31:23 -0500
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14C1E1F6377
        for <linux-nfs@vger.kernel.org>; Thu, 24 Feb 2022 08:30:44 -0800 (PST)
Received: by mail-ed1-x530.google.com with SMTP id bq11so3665205edb.2
        for <linux-nfs@vger.kernel.org>; Thu, 24 Feb 2022 08:30:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xCDVviS1rWKTyTmf8XJHHf/Z/m+RW3azVtKj4v7AQgY=;
        b=OSrQGbh1Bi5kgw2ugjnmX6C/DRnjH3ZOSsHOtHQ6rDHMa7wUDLCptYK0KxlQ8/D3N8
         igc1yTfjmCc9EDhUCd4dMW3eDyxI7P97GL3n4MoyAXZQPZauigE+RpcX/UKKrEd3kYXA
         UfbBHZV4pAnJJSsfn9CMy0vbmrIQxAv8eDZ/KYMQzOyDMHGNzXDcDWtU5KtgGgLJ3bjT
         /UlN7XlLSgfpyMaCE+Yf57jyWBkXY7+6Iz9jZ/tCE4aWTW/r1foJ8/qTP9SSYUJFMu2u
         //Jn47v5Cqk+HjBiyeTgicPxdXjkbW6QaHPfYd+LA2HfqJua4JpHHnRhVWBKLKHp2FC5
         hepA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xCDVviS1rWKTyTmf8XJHHf/Z/m+RW3azVtKj4v7AQgY=;
        b=CSGz7c64gQdF8Kj+Tnwq2IKZQHBmUiP0/RCyaqzuG39QLclOEiDyvkU57VPvh8ul3g
         ETt9mxMwrnkUzuWW7EBpZSiD8ON33vtWdtHB6r+K+0jxMGe1VO+wIau8anrlW/Z9sBaE
         +VMnKPz4e+YobjGDDjnfVIav87mzhvY48y7duzm9O1Z/Ow42YJEaXCuj7Dkyy5DoqlfM
         zwO6HsCqDXi4jxNRWtytf5LTDYkn3HXjyCFJbdAeRiqPZ2GBMrenIzz7A8Orx3QJpEJe
         SGnN/0DeKkdF8dVS/H4qd1YQX9orxSEhHN4iFVtXOxI7ZV6p7yXubDOiTcNJ7bZNxPH6
         VZWQ==
X-Gm-Message-State: AOAM531ZCIN34LAj6B0gy9IfskQyl+U7+turBVtL1prugCS5c0oM9i3z
        uVi93mlnVgSom+dgIsa1SEF+0eKdl6w=
X-Google-Smtp-Source: ABdhPJxE9nAx6DTzQ9EA24Nqi5F49tAYA8mqbXzGs9JMs+N1PstzLF9PKWHsbVVt317mNspCSC2Hlw==
X-Received: by 2002:a5d:544d:0:b0:1ee:880d:3391 with SMTP id w13-20020a5d544d000000b001ee880d3391mr1597679wrv.72.1645719443475;
        Thu, 24 Feb 2022 08:17:23 -0800 (PST)
Received: from localhost.localdomain ([5.29.13.154])
        by smtp.gmail.com with ESMTPSA id l26sm978851wmi.30.2022.02.24.08.17.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Feb 2022 08:17:22 -0800 (PST)
From:   Amir Goldstein <amir73il@gmail.com>
To:     Chuck Lever <chuck.lever@oracle.com>
Cc:     Jeff Layton <jlayton@kernel.org>, linux-nfs@vger.kernel.org
Subject: [PATCH v2] nfsd: more robust allocation failure handling in nfsd_file_cache_init
Date:   Thu, 24 Feb 2022 18:17:05 +0200
Message-Id: <20220224161705.1041788-1-amir73il@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

The nfsd file cache table can be pretty large and its allocation
may require as many as 80 contigious pages.

Employ the same fix that was employed for similar issue that was
reported for the reply cache hash table allocation several years ago
by commit 8f97514b423a ("nfsd: more robust allocation failure handling
in nfsd_reply_cache_init").

Fixes: 65294c1f2c5e ("nfsd: add a new struct file caching facility to nfsd")
Link: https://lore.kernel.org/linux-nfs/e3cdaeec85a6cfec980e87fc294327c0381c1778.camel@kernel.org/
Suggested-by: Jeff Layton <jlayton@kernel.org>
Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---

Since v1:
- Use kvcalloc()
- Use kvfree()

 fs/nfsd/filecache.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/nfsd/filecache.c b/fs/nfsd/filecache.c
index 8bc807c5fea4..cc2831cec669 100644
--- a/fs/nfsd/filecache.c
+++ b/fs/nfsd/filecache.c
@@ -632,7 +632,7 @@ nfsd_file_cache_init(void)
 	if (!nfsd_filecache_wq)
 		goto out;
 
-	nfsd_file_hashtbl = kcalloc(NFSD_FILE_HASH_SIZE,
+	nfsd_file_hashtbl = kvcalloc(NFSD_FILE_HASH_SIZE,
 				sizeof(*nfsd_file_hashtbl), GFP_KERNEL);
 	if (!nfsd_file_hashtbl) {
 		pr_err("nfsd: unable to allocate nfsd_file_hashtbl\n");
@@ -700,7 +700,7 @@ nfsd_file_cache_init(void)
 	nfsd_file_slab = NULL;
 	kmem_cache_destroy(nfsd_file_mark_slab);
 	nfsd_file_mark_slab = NULL;
-	kfree(nfsd_file_hashtbl);
+	kvfree(nfsd_file_hashtbl);
 	nfsd_file_hashtbl = NULL;
 	destroy_workqueue(nfsd_filecache_wq);
 	nfsd_filecache_wq = NULL;
@@ -811,7 +811,7 @@ nfsd_file_cache_shutdown(void)
 	fsnotify_wait_marks_destroyed();
 	kmem_cache_destroy(nfsd_file_mark_slab);
 	nfsd_file_mark_slab = NULL;
-	kfree(nfsd_file_hashtbl);
+	kvfree(nfsd_file_hashtbl);
 	nfsd_file_hashtbl = NULL;
 	destroy_workqueue(nfsd_filecache_wq);
 	nfsd_filecache_wq = NULL;
-- 
2.25.1


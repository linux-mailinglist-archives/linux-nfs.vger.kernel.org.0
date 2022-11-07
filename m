Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1BFC861FADF
	for <lists+linux-nfs@lfdr.de>; Mon,  7 Nov 2022 18:11:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231580AbiKGRLD (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 7 Nov 2022 12:11:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232321AbiKGRLC (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 7 Nov 2022 12:11:02 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64CF418B24
        for <linux-nfs@vger.kernel.org>; Mon,  7 Nov 2022 09:11:01 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id D2C27CE16E0
        for <linux-nfs@vger.kernel.org>; Mon,  7 Nov 2022 17:10:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE3F2C433D6;
        Mon,  7 Nov 2022 17:10:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667841058;
        bh=dJFoWtIeLHyZSa7aW4VsmQnvBQAGKyIlllWDUjAl95I=;
        h=From:To:Cc:Subject:Date:From;
        b=n4hSTKWo/9JMP6F68mb5EPz2QVxZ+d0yGwUE3KB+xRcr06sowmGUlBc9XNLUl5mJi
         H0UMAexrJF7wXhXlNI0oQ4AyyOfe9YCkD5c+z2dGuEc9XG5yPKBM492Q5iFG3hYqkv
         +v1NuR/Y6RGjv/pM2U2qoK5/iHzNRYa+RdYvLfJXnRbCVqYtCkJv77pfQyJGKLtCgx
         5CmM+XRLb2FNlsXQwqciErU7jV6YSvjR76UCm1cKm5rREQMXp3l/khbgydk4VVbaNe
         j+Jg1CTSg6uPARTK+xiVrdz2f0JbxD2G0YUukbvQmQ4m9Xcdt5u3nO2M2YULAEjhw1
         bXzj6PdD1llow==
From:   Jeff Layton <jlayton@kernel.org>
To:     chuck.lever@oracle.com
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH] nfsd: remove dedicated nfsd_filecache_wq
Date:   Mon,  7 Nov 2022 12:10:56 -0500
Message-Id: <20221107171056.64564-1-jlayton@kernel.org>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

There's no clear benefit to allocating our own over just using the
system_wq. This also fixes a minor bug in nfsd_file_cache_init(). In the
current code, if allocating the wq fails, then the nfsd_file_rhash_tbl
is leaked.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/nfsd/filecache.c | 13 +------------
 1 file changed, 1 insertion(+), 12 deletions(-)

diff --git a/fs/nfsd/filecache.c b/fs/nfsd/filecache.c
index 1e76b0d3b83a..59e06d68d20c 100644
--- a/fs/nfsd/filecache.c
+++ b/fs/nfsd/filecache.c
@@ -66,8 +66,6 @@ struct nfsd_fcache_disposal {
 	struct list_head freeme;
 };
 
-static struct workqueue_struct *nfsd_filecache_wq __read_mostly;
-
 static struct kmem_cache		*nfsd_file_slab;
 static struct kmem_cache		*nfsd_file_mark_slab;
 static struct list_lru			nfsd_file_lru;
@@ -564,7 +562,7 @@ nfsd_file_list_add_disposal(struct list_head *files, struct net *net)
 	spin_lock(&l->lock);
 	list_splice_tail_init(files, &l->freeme);
 	spin_unlock(&l->lock);
-	queue_work(nfsd_filecache_wq, &l->work);
+	queue_work(system_wq, &l->work);
 }
 
 static void
@@ -855,11 +853,6 @@ nfsd_file_cache_init(void)
 	if (ret)
 		return ret;
 
-	ret = -ENOMEM;
-	nfsd_filecache_wq = alloc_workqueue("nfsd_filecache", 0, 0);
-	if (!nfsd_filecache_wq)
-		goto out;
-
 	nfsd_file_slab = kmem_cache_create("nfsd_file",
 				sizeof(struct nfsd_file), 0, 0, NULL);
 	if (!nfsd_file_slab) {
@@ -917,8 +910,6 @@ nfsd_file_cache_init(void)
 	nfsd_file_slab = NULL;
 	kmem_cache_destroy(nfsd_file_mark_slab);
 	nfsd_file_mark_slab = NULL;
-	destroy_workqueue(nfsd_filecache_wq);
-	nfsd_filecache_wq = NULL;
 	rhashtable_destroy(&nfsd_file_rhash_tbl);
 	goto out;
 }
@@ -1034,8 +1025,6 @@ nfsd_file_cache_shutdown(void)
 	fsnotify_wait_marks_destroyed();
 	kmem_cache_destroy(nfsd_file_mark_slab);
 	nfsd_file_mark_slab = NULL;
-	destroy_workqueue(nfsd_filecache_wq);
-	nfsd_filecache_wq = NULL;
 	rhashtable_destroy(&nfsd_file_rhash_tbl);
 
 	for_each_possible_cpu(i) {
-- 
2.38.1


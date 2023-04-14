Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3ECA76E2BC5
	for <lists+linux-nfs@lfdr.de>; Fri, 14 Apr 2023 23:31:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229615AbjDNVbs (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 14 Apr 2023 17:31:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229491AbjDNVbr (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 14 Apr 2023 17:31:47 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 094A65BB0
        for <linux-nfs@vger.kernel.org>; Fri, 14 Apr 2023 14:31:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9973964A77
        for <linux-nfs@vger.kernel.org>; Fri, 14 Apr 2023 21:31:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD7C4C433EF;
        Fri, 14 Apr 2023 21:31:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681507906;
        bh=KlMvfEv7IU9wuQz8LbWuQCuJ+B2EHj3SbLkbz+GQBuA=;
        h=From:To:Cc:Subject:Date:From;
        b=stRXtGMyFbKcYmUNqRRtpgI2S4+8+QYSaJCN2g6EXBVn7Q7AOGr8OoAjEBy3eMJmN
         rhgEWKpdiFhAKk9BQRR2MsFo/sWLknZ1zbk+8ZtywtOaKbHytAekOckRfFldRKsmOk
         wYN2ozTUAsdQnAI8M85gaw7lSFQrBvng7UYJy1Wms74THZ7T6DwJuvHMOtx2UnbzeB
         Fb/I8PSADrXy6BIqFcbzf4NBC55qHxDQKjqAthaAup2fXsP9GyTmnVxqOv1PegI7qS
         fOfM7hsi5A+jE1y+tv6qQ0k838blK+bj0u9oS5vo6iNtoZ2/kBwvLD3drAm1L51rCl
         p/PiOwRiTgz2g==
From:   Jeff Layton <jlayton@kernel.org>
To:     chuck.lever@oracle.com
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH v2] nfsd: simplify the delayed disposal list code
Date:   Fri, 14 Apr 2023 17:31:44 -0400
Message-Id: <20230414213144.385947-1-jlayton@kernel.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

When queueing a dispose list to the appropriate "freeme" lists, it
pointlessly queues the objects one at a time to an intermediate list.

Remove a few helpers and just open code a list_move to make it more
clear and efficient. Better document the resulting functions with
kerneldoc comments.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/filecache.c | 64 ++++++++++++++++-----------------------------
 1 file changed, 22 insertions(+), 42 deletions(-)

v2: add back missing queue_work call

diff --git a/fs/nfsd/filecache.c b/fs/nfsd/filecache.c
index 2f0b2d964cbb..f40d8f3b35a4 100644
--- a/fs/nfsd/filecache.c
+++ b/fs/nfsd/filecache.c
@@ -402,49 +402,26 @@ nfsd_file_dispose_list(struct list_head *dispose)
 	}
 }
 
-static void
-nfsd_file_list_remove_disposal(struct list_head *dst,
-		struct nfsd_fcache_disposal *l)
-{
-	spin_lock(&l->lock);
-	list_splice_init(&l->freeme, dst);
-	spin_unlock(&l->lock);
-}
-
-static void
-nfsd_file_list_add_disposal(struct list_head *files, struct net *net)
-{
-	struct nfsd_net *nn = net_generic(net, nfsd_net_id);
-	struct nfsd_fcache_disposal *l = nn->fcache_disposal;
-
-	spin_lock(&l->lock);
-	list_splice_tail_init(files, &l->freeme);
-	spin_unlock(&l->lock);
-	queue_work(nfsd_filecache_wq, &l->work);
-}
-
-static void
-nfsd_file_list_add_pernet(struct list_head *dst, struct list_head *src,
-		struct net *net)
-{
-	struct nfsd_file *nf, *tmp;
-
-	list_for_each_entry_safe(nf, tmp, src, nf_lru) {
-		if (nf->nf_net == net)
-			list_move_tail(&nf->nf_lru, dst);
-	}
-}
-
+/**
+ * nfsd_file_dispose_list_delayed - move list of dead files to net's freeme list
+ * @dispose: list of nfsd_files to be disposed
+ *
+ * Transfers each file to the "freeme" list for its nfsd_net, to eventually
+ * be disposed of by the per-net garbage collector.
+ */
 static void
 nfsd_file_dispose_list_delayed(struct list_head *dispose)
 {
-	LIST_HEAD(list);
-	struct nfsd_file *nf;
-
 	while(!list_empty(dispose)) {
-		nf = list_first_entry(dispose, struct nfsd_file, nf_lru);
-		nfsd_file_list_add_pernet(&list, dispose, nf->nf_net);
-		nfsd_file_list_add_disposal(&list, nf->nf_net);
+		struct nfsd_file *nf = list_first_entry(dispose,
+						struct nfsd_file, nf_lru);
+		struct nfsd_net *nn = net_generic(nf->nf_net, nfsd_net_id);
+		struct nfsd_fcache_disposal *l = nn->fcache_disposal;
+
+		spin_lock(&l->lock);
+		list_move_tail(&nf->nf_lru, &l->freeme);
+		spin_unlock(&l->lock);
+		queue_work(nfsd_filecache_wq, &l->work);
 	}
 }
 
@@ -665,8 +642,8 @@ nfsd_file_close_inode_sync(struct inode *inode)
  * nfsd_file_delayed_close - close unused nfsd_files
  * @work: dummy
  *
- * Walk the LRU list and destroy any entries that have not been used since
- * the last scan.
+ * Scrape the freeme list for this nfsd_net, and then dispose of them
+ * all.
  */
 static void
 nfsd_file_delayed_close(struct work_struct *work)
@@ -675,7 +652,10 @@ nfsd_file_delayed_close(struct work_struct *work)
 	struct nfsd_fcache_disposal *l = container_of(work,
 			struct nfsd_fcache_disposal, work);
 
-	nfsd_file_list_remove_disposal(&head, l);
+	spin_lock(&l->lock);
+	list_splice_init(&l->freeme, &head);
+	spin_unlock(&l->lock);
+
 	nfsd_file_dispose_list(&head);
 }
 
-- 
2.39.2


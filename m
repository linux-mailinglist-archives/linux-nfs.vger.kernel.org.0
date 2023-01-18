Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1E7C672500
	for <lists+linux-nfs@lfdr.de>; Wed, 18 Jan 2023 18:32:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230032AbjARRcW (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 18 Jan 2023 12:32:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230434AbjARRcF (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 18 Jan 2023 12:32:05 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 313E359B4B
        for <linux-nfs@vger.kernel.org>; Wed, 18 Jan 2023 09:31:43 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BFB246194A
        for <linux-nfs@vger.kernel.org>; Wed, 18 Jan 2023 17:31:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42B3CC433F2;
        Wed, 18 Jan 2023 17:31:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674063102;
        bh=vxQxIGJj2mtOgx+ZLWjaxruc0XAFN+T/yKwcGmDuHgE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Pm7wiUEhs0mq5G5aqHdHEsgnLdA1bXq3qCfJ8cE8tYLaV9p6vLWS9yJOcxn6cZbsO
         873GClIqpk8HDhlKk4Yi5/wbrthd/JOnZMq9HLhSpQkb4EFSSyv++IW+RDC55pY0lF
         a7DMILXHFgtjEXvuhe1cBZ+sh4mnkbxtNmEh/6O9yUWT5sm+nNmbNmy1h5kV3H2Ct9
         hAPMT/Jwyh5Kr03AXCbIuRD7jA33sn+xiQW8N8eoSFIceaIDEqyA+IxMYXliXZUJQP
         TcXZu7iwObKdQ00N+cZcaxjtHt4Fj9MzggnOTlFHu/r+d8WZ/egthclC7Cs4HOPRsd
         YrGyDvyZxyJdw==
From:   Jeff Layton <jlayton@kernel.org>
To:     chuck.lever@oracle.com
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH 3/6] nfsd: simplify the delayed disposal list code
Date:   Wed, 18 Jan 2023 12:31:36 -0500
Message-Id: <20230118173139.71846-4-jlayton@kernel.org>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230118173139.71846-1-jlayton@kernel.org>
References: <20230118173139.71846-1-jlayton@kernel.org>
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

When queueing a dispose list to the appropriate "freeme" lists, it
pointlessly queues the objects one at a time to an intermediate list.

Remove a few helpers and just open code a list_move to make it more
clear and efficient. Better document the resulting functions with
kerneldoc comments.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/nfsd/filecache.c | 63 +++++++++++++++------------------------------
 1 file changed, 21 insertions(+), 42 deletions(-)

diff --git a/fs/nfsd/filecache.c b/fs/nfsd/filecache.c
index 58ac93e7e680..a2bc4bd90b9a 100644
--- a/fs/nfsd/filecache.c
+++ b/fs/nfsd/filecache.c
@@ -513,49 +513,25 @@ nfsd_file_dispose_list(struct list_head *dispose)
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
 	}
 }
 
@@ -765,8 +741,8 @@ nfsd_file_close_inode_sync(struct inode *inode)
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
@@ -775,7 +751,10 @@ nfsd_file_delayed_close(struct work_struct *work)
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
2.39.0


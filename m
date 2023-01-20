Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6488675E6D
	for <lists+linux-nfs@lfdr.de>; Fri, 20 Jan 2023 20:52:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229746AbjATTwU (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 20 Jan 2023 14:52:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229645AbjATTwT (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 20 Jan 2023 14:52:19 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 543E8BB96;
        Fri, 20 Jan 2023 11:52:18 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E006D6206D;
        Fri, 20 Jan 2023 19:52:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A029CC433EF;
        Fri, 20 Jan 2023 19:52:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674244337;
        bh=6jPk4/xopHMScMSF0b0LFfVr32gVbdEpBA+awgkZELo=;
        h=From:To:Cc:Subject:Date:From;
        b=jMBjJPTKclEPTTQKAp4VCZr3bgTnKC4OuMDd0uIzEIiB82PH2+ossDtRZRHOGTmVr
         L0+/iouxOH07R9zP7rBrptUhD82E0Yqn1EwrKjjcrmqWk3lIw+HQzvtQiUBPwNuleN
         icBgcQRsggoh0eqket2S67OQcpA672u0mEwOzr69Xc2vSv6zA+U7+cMPzG7kN78ALy
         dgzVEALHVFz34A1VdkHWuR71/SnXGu5Pn9wily6zYwh7v5PtX2MwqdJ+M7hNFghX2S
         7hqunNs9hEV/rKaU33c6sPAGcpSKreZkDx2alyMN34/2urwFOavcqXaT23d8jpYzda
         BXJ7WXFUl+MUQ==
From:   Jeff Layton <jlayton@kernel.org>
To:     Chuck Lever <chuck.lever@oracle.com>
Cc:     Ruben Vestergaard <rubenv@drcmr.dk>,
        Torkil Svensgaard <torkil@drcmr.dk>,
        Shachar Kagan <skagan@nvidia.com>, linux-nfs@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] nfsd: don't free files unconditionally in __nfsd_file_cache_purge
Date:   Fri, 20 Jan 2023 14:52:14 -0500
Message-Id: <20230120195215.42243-1-jlayton@kernel.org>
X-Mailer: git-send-email 2.39.0
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

nfsd_file_cache_purge is called when the server is shutting down, in
which case, tearing things down is generally fine, but it also gets
called when the exports cache is flushed.

Instead of walking the cache and freeing everything unconditionally,
handle it the same as when we have a notification of conflicting access.

Fixes: ac3a2585f018 ("nfsd: rework refcounting in filecache")
Reported-by: Ruben Vestergaard <rubenv@drcmr.dk>
Reported-by: Torkil Svensgaard <torkil@drcmr.dk>
Reported-by: Shachar Kagan <skagan@nvidia.com>
Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/nfsd/filecache.c | 61 +++++++++++++++++++++++++++------------------
 1 file changed, 37 insertions(+), 24 deletions(-)

v2: use the same method to purge entries from the cache as we do when
    there is a notification of conflicting access.

diff --git a/fs/nfsd/filecache.c b/fs/nfsd/filecache.c
index 58ac93e7e680..397ae212b98d 100644
--- a/fs/nfsd/filecache.c
+++ b/fs/nfsd/filecache.c
@@ -661,6 +661,40 @@ static struct shrinker	nfsd_file_shrinker = {
 	.seeks = 1,
 };
 
+/**
+ * maybe_queue_nfsd_file - try to unhash and queue a nfsd_file to be freed
+ * @nf: nfsd_file to attempt to queue
+ * @dispose: private list to queue successfully-put objects
+ *
+ * Unhash an nfsd_file, try to get a reference to it, and then put that
+ * reference. If it's the last reference, queue it to the dispose list.
+ *
+ * The caller MUST hold the rcu_read_lock() !
+ */
+static void
+maybe_queue_nfsd_file(struct nfsd_file *nf, struct list_head *dispose)
+{
+	int decrement = 1;
+
+	/* If we raced with someone else unhashing, ignore it */
+	if (!nfsd_file_unhash(nf))
+		return;
+
+	/* If we can't get a reference, ignore it */
+	if (!nfsd_file_get(nf))
+		return;
+
+	/* Extra decrement if we remove from the LRU */
+	if (nfsd_file_lru_remove(nf))
+		++decrement;
+
+	/* If refcount goes to 0, then put on the dispose list */
+	if (refcount_sub_and_test(decrement, &nf->nf_ref)) {
+		list_add(&nf->nf_lru, dispose);
+		trace_nfsd_file_closing(nf);
+	}
+}
+
 /**
  * nfsd_file_queue_for_close: try to close out any open nfsd_files for an inode
  * @inode:   inode on which to close out nfsd_files
@@ -688,30 +722,12 @@ nfsd_file_queue_for_close(struct inode *inode, struct list_head *dispose)
 
 	rcu_read_lock();
 	do {
-		int decrement = 1;
-
 		nf = rhashtable_lookup(&nfsd_file_rhash_tbl, &key,
 				       nfsd_file_rhash_params);
 		if (!nf)
 			break;
 
-		/* If we raced with someone else unhashing, ignore it */
-		if (!nfsd_file_unhash(nf))
-			continue;
-
-		/* If we can't get a reference, ignore it */
-		if (!nfsd_file_get(nf))
-			continue;
-
-		/* Extra decrement if we remove from the LRU */
-		if (nfsd_file_lru_remove(nf))
-			++decrement;
-
-		/* If refcount goes to 0, then put on the dispose list */
-		if (refcount_sub_and_test(decrement, &nf->nf_ref)) {
-			list_add(&nf->nf_lru, dispose);
-			trace_nfsd_file_closing(nf);
-		}
+		maybe_queue_nfsd_file(nf, dispose);
 	} while (1);
 	rcu_read_unlock();
 }
@@ -928,11 +944,8 @@ __nfsd_file_cache_purge(struct net *net)
 
 		nf = rhashtable_walk_next(&iter);
 		while (!IS_ERR_OR_NULL(nf)) {
-			if (!net || nf->nf_net == net) {
-				nfsd_file_unhash(nf);
-				nfsd_file_lru_remove(nf);
-				list_add(&nf->nf_lru, &dispose);
-			}
+			if (!net || nf->nf_net == net)
+				maybe_queue_nfsd_file(nf, &dispose);
 			nf = rhashtable_walk_next(&iter);
 		}
 
-- 
2.39.0


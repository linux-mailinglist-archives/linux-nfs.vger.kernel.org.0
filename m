Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 581585F123F
	for <lists+linux-nfs@lfdr.de>; Fri, 30 Sep 2022 21:15:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230378AbiI3TP5 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 30 Sep 2022 15:15:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229594AbiI3TPz (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 30 Sep 2022 15:15:55 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3FBD156FA4
        for <linux-nfs@vger.kernel.org>; Fri, 30 Sep 2022 12:15:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4C70062402
        for <linux-nfs@vger.kernel.org>; Fri, 30 Sep 2022 19:15:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6AFF0C433D7;
        Fri, 30 Sep 2022 19:15:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664565353;
        bh=mmEhW4HUdcoctlbmIXqvjeTkFOe307mvMkIbIf+PRpE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ts4P59ACseCen4g68pQzViJoK0hzU87hWm9ORtgv0s0CMq25h7aFXTHWKc2G+XUxI
         hwWVgr3r3uDMIHZ4lJSxWFPwSj9VLTAtCXQRNRIPRxwWOvB2KIGW2yPxWETiZ329pD
         4pSjiQdl5UN3lFpVZnCCeke/x9sANQ96k+DDTsWYR9pg8r/YI6qOCMwfjbC9eqsJZt
         2DzNmK+gBJRbgNo7hS3Se4m8+mil++3rF0LkGl7o8Dd8/8VM59NG2NWQpmRKL1PVzg
         PHPUsl9ui8tb2m056zskoy232bfvj+NUkj/w2SrohvdRdVmMYWKyHvyabUscw0gNJK
         52e25Jdunkjng==
From:   Jeff Layton <jlayton@kernel.org>
To:     chuck.lever@oracle.com
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH 3/3] nfsd: fix nfsd_file_unhash_and_dispose
Date:   Fri, 30 Sep 2022 15:15:50 -0400
Message-Id: <20220930191550.172087-4-jlayton@kernel.org>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20220930191550.172087-1-jlayton@kernel.org>
References: <20220930191550.172087-1-jlayton@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

This function is called two reasons:

We're either shutting down and purging the filecache, or we've gotten a
notification about a file delete, so we want to go ahead and unhash it
so that it'll get cleaned up when we close.

We're either walking the hashtable or doing a lookup in it and we
don't take a reference in either case. What we want to do in both cases
is to try and unhash the object and put it on the dispose list if that
was successful. If it's no longer hashed, then we don't want to touch
it, with the assumption being that something else is already cleaning
up the sentinel reference.

Instead of trying to selectively decrement the refcount in this
function, just unhash it, and if that was successful, move it to the
dispose list. Then, the disposal routine will just clean that up as
usual.

Also, just make this a void function, drop the WARN_ON_ONCE, and the
comments about deadlocking since the nature of the purported deadlock
is no longer clear.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/nfsd/filecache.c | 32 ++++++--------------------------
 1 file changed, 6 insertions(+), 26 deletions(-)

diff --git a/fs/nfsd/filecache.c b/fs/nfsd/filecache.c
index 58f4d9267f4a..16bd71a3894e 100644
--- a/fs/nfsd/filecache.c
+++ b/fs/nfsd/filecache.c
@@ -408,19 +408,14 @@ nfsd_file_unhash(struct nfsd_file *nf)
 /*
  * Return true if the file was unhashed.
  */
-static bool
+static void
 nfsd_file_unhash_and_dispose(struct nfsd_file *nf, struct list_head *dispose)
 {
 	trace_nfsd_file_unhash_and_dispose(nf);
-	if (!nfsd_file_unhash(nf))
-		return false;
-	/* keep final reference for nfsd_file_lru_dispose */
-	if (refcount_dec_not_one(&nf->nf_ref))
-		return true;
-
-	nfsd_file_lru_remove(nf);
-	list_add(&nf->nf_lru, dispose);
-	return true;
+	if (nfsd_file_unhash(nf)) {
+		nfsd_file_lru_remove(nf);
+		list_add(&nf->nf_lru, dispose);
+	}
 }
 
 static void
@@ -564,8 +559,6 @@ nfsd_file_dispose_list_delayed(struct list_head *dispose)
  * @lock: LRU list lock (unused)
  * @arg: dispose list
  *
- * Note this can deadlock with nfsd_file_cache_purge.
- *
  * Return values:
  *   %LRU_REMOVED: @item was removed from the LRU
  *   %LRU_ROTATE: @item is to be moved to the LRU tail
@@ -750,8 +743,6 @@ nfsd_file_close_inode(struct inode *inode)
  *
  * Walk the LRU list and close any entries that have not been used since
  * the last scan.
- *
- * Note this can deadlock with nfsd_file_cache_purge.
  */
 static void
 nfsd_file_delayed_close(struct work_struct *work)
@@ -893,16 +884,12 @@ nfsd_file_cache_init(void)
 	goto out;
 }
 
-/*
- * Note this can deadlock with nfsd_file_lru_cb.
- */
 static void
 __nfsd_file_cache_purge(struct net *net)
 {
 	struct rhashtable_iter iter;
 	struct nfsd_file *nf;
 	LIST_HEAD(dispose);
-	bool del;
 
 	rhashtable_walk_enter(&nfsd_file_rhash_tbl, &iter);
 	do {
@@ -912,14 +899,7 @@ __nfsd_file_cache_purge(struct net *net)
 		while (!IS_ERR_OR_NULL(nf)) {
 			if (net && nf->nf_net != net)
 				continue;
-			del = nfsd_file_unhash_and_dispose(nf, &dispose);
-
-			/*
-			 * Deadlock detected! Something marked this entry as
-			 * unhased, but hasn't removed it from the hash list.
-			 */
-			WARN_ON_ONCE(!del);
-
+			nfsd_file_unhash_and_dispose(nf, &dispose);
 			nf = rhashtable_walk_next(&iter);
 		}
 
-- 
2.37.3


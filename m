Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8305613A23
	for <lists+linux-nfs@lfdr.de>; Mon, 31 Oct 2022 16:36:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229787AbiJaPgC (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 31 Oct 2022 11:36:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231888AbiJaPgA (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 31 Oct 2022 11:36:00 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEC416575
        for <linux-nfs@vger.kernel.org>; Mon, 31 Oct 2022 08:35:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7A506612AE
        for <linux-nfs@vger.kernel.org>; Mon, 31 Oct 2022 15:35:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B6ABC433D7;
        Mon, 31 Oct 2022 15:35:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667230556;
        bh=7Cimu96ndPeJ50Hetw9q5aYq10IbyynP4U+H5c2Y8C4=;
        h=From:To:Cc:Subject:Date:From;
        b=oVvdeWPxC8hDpxSnqgrAaD98Wy0VPJPGPHXXiXH8Fgs/DlwLK0NvX+JwFaZajYRVc
         AkiQ+w5tXExkpdV2VKkpWqX5rC3vuYCg8wE1HUaeYADpOm/QhAQLiIB+kptWXd1jwi
         CGti90HUUCN9yVuvI/q9BY8UpTr9Hf/3SKRMMctjzPcYwoTAyYDaU4F2dHz9xyVJpM
         RPS16LaJzCIxnGGVU0waLXB+DUtPrx/5m92FezZLCGCCRXuNpZuwTuMJ0bhxWw7NsU
         CuhWKcwPSDUkV8cQFYFp1BgiqwFQ+rPTBrCiz2RKBhQQJvTUzhArUzi+JAZcnMj/zv
         Gcj3lUxif0sFQ==
From:   Jeff Layton <jlayton@kernel.org>
To:     chuck.lever@oracle.com
Cc:     linux-nfs@vger.kernel.org, Petr Vorel <pvorel@suse.cz>
Subject: [PATCH] nfsd: fix net-namespace logic in __nfsd_file_cache_purge
Date:   Mon, 31 Oct 2022 11:35:54 -0400
Message-Id: <20221031153554.498442-1-jlayton@kernel.org>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-8.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

If the namespace doesn't match the one in "net", then we'll continue,
but that doesn't cause another rhashtable_walk_next call, so it will
loop infinitely.

Fixes: ce502f81ba88 ("NFSD: Convert the filecache to use rhashtable")
Reported-by: Petr Vorel <pvorel@suse.cz>
Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/nfsd/filecache.c | 20 +++++++++-----------
 1 file changed, 9 insertions(+), 11 deletions(-)

This should probably go to stable too.

diff --git a/fs/nfsd/filecache.c b/fs/nfsd/filecache.c
index eeed4ae5b4ad..f9ea89057ae8 100644
--- a/fs/nfsd/filecache.c
+++ b/fs/nfsd/filecache.c
@@ -908,19 +908,17 @@ __nfsd_file_cache_purge(struct net *net)
 
 		nf = rhashtable_walk_next(&iter);
 		while (!IS_ERR_OR_NULL(nf)) {
-			if (net && nf->nf_net != net)
-				continue;
-			del = nfsd_file_unhash_and_dispose(nf, &dispose);
-
-			/*
-			 * Deadlock detected! Something marked this entry as
-			 * unhased, but hasn't removed it from the hash list.
-			 */
-			WARN_ON_ONCE(!del);
-
+			if (!net || nf->nf_net == net) {
+				del = nfsd_file_unhash_and_dispose(nf, &dispose);
+
+				/*
+				 * Deadlock detected! Something marked this entry as
+				 * unhased, but hasn't removed it from the hash list.
+				 */
+				WARN_ON_ONCE(!del);
+			}
 			nf = rhashtable_walk_next(&iter);
 		}
-
 		rhashtable_walk_stop(&iter);
 	} while (nf == ERR_PTR(-EAGAIN));
 	rhashtable_walk_exit(&iter);
-- 
2.38.1


Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED279616CDF
	for <lists+linux-nfs@lfdr.de>; Wed,  2 Nov 2022 19:44:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231519AbiKBSo5 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 2 Nov 2022 14:44:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231508AbiKBSo4 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 2 Nov 2022 14:44:56 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04B092D76A
        for <linux-nfs@vger.kernel.org>; Wed,  2 Nov 2022 11:44:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9449761B4D
        for <linux-nfs@vger.kernel.org>; Wed,  2 Nov 2022 18:44:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C8F8C433C1;
        Wed,  2 Nov 2022 18:44:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667414695;
        bh=QVYNvjzI/NnAQ0HFG37aWUwUKq1W9OoUog3ckUaq3IY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=b4NgYx+kJcmMOvg3nFT2nSqsf8PwE/PTy3yQJCFGOLgXf2jFbYkGRNE/fK3LRis/+
         f5tbPNcqNjYhXwbv+6eZfOY6di5PiEZ4a9ZVCKjtPv5lsRv+JxNKyHFdu/OxkMrv8X
         mM398HxqFG5/A7TYNkq0Y/BOzlRufHeNiXku1LD3y7CfffTWaWY0bctqwPY8MG6B5w
         HrV3zikVGDRolCfuZFdkVUbqoTXfRpcUe5USLARm9yCmR+cFqJirw2vwKI7pMfubZY
         BqbCXi7R7X3VCfeECeaX/K0P1+3hJ4xBnhHUWdmKdd4JzWL9QjJL62lmnQSOTSCzKO
         Kr51JoP/Fjkww==
From:   Jeff Layton <jlayton@kernel.org>
To:     chuck.lever@oracle.com
Cc:     linux-nfs@vger.kernel.org, neilb@suse.de
Subject: [PATCH v6 4/4] nfsd: fix up the filecache laundrette scheduling
Date:   Wed,  2 Nov 2022 14:44:50 -0400
Message-Id: <20221102184450.130397-5-jlayton@kernel.org>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221102184450.130397-1-jlayton@kernel.org>
References: <20221102184450.130397-1-jlayton@kernel.org>
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

We don't really care whether there are hashed entries when it comes to
scheduling the laundrette. They might all be non-gc entries, after all.
We only want to schedule it if there are entries on the LRU.

Switch to using list_lru_count, and move the check into
nfsd_file_gc_worker. The other callsite in nfsd_file_put doesn't need to
count entries, since it only schedules the laundrette after adding an
entry to the LRU.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/nfsd/filecache.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/fs/nfsd/filecache.c b/fs/nfsd/filecache.c
index d8f9430d29e4..29b216b1d15c 100644
--- a/fs/nfsd/filecache.c
+++ b/fs/nfsd/filecache.c
@@ -211,12 +211,9 @@ static const struct rhashtable_params nfsd_file_rhash_params = {
 static void
 nfsd_file_schedule_laundrette(void)
 {
-	if ((atomic_read(&nfsd_file_rhash_tbl.nelems) == 0) ||
-	    test_bit(NFSD_FILE_CACHE_UP, &nfsd_file_flags) == 0)
-		return;
-
-	queue_delayed_work(system_wq, &nfsd_filecache_laundrette,
-			NFSD_LAUNDRETTE_DELAY);
+	if (test_bit(NFSD_FILE_CACHE_UP, &nfsd_file_flags))
+		queue_delayed_work(system_wq, &nfsd_filecache_laundrette,
+				   NFSD_LAUNDRETTE_DELAY);
 }
 
 static void
@@ -671,7 +668,8 @@ static void
 nfsd_file_gc_worker(struct work_struct *work)
 {
 	nfsd_file_gc();
-	nfsd_file_schedule_laundrette();
+	if (list_lru_count(&nfsd_file_lru))
+		nfsd_file_schedule_laundrette();
 }
 
 static unsigned long
-- 
2.38.1


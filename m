Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4CA48614D01
	for <lists+linux-nfs@lfdr.de>; Tue,  1 Nov 2022 15:46:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230355AbiKAOqz (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 1 Nov 2022 10:46:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230358AbiKAOqy (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 1 Nov 2022 10:46:54 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDF181BEA4
        for <linux-nfs@vger.kernel.org>; Tue,  1 Nov 2022 07:46:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7DA7E615F5
        for <linux-nfs@vger.kernel.org>; Tue,  1 Nov 2022 14:46:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85A1EC433D6;
        Tue,  1 Nov 2022 14:46:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667314012;
        bh=3xbsnDoLxPF9K/ZVhMDTIHTZ4995bSqZvh7/BGqAvPI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=E5HXDTsdjJPd+rmRqJIosAj9y7RgT5GDLYwqpdtvY6I0nHGKU+wBAJGYiIvYdg3UR
         BHNAnBsoimgrTmDTubVoPVf0uIxGtbnuN6zYXYWy51Wi3Rz/l7xdzrJ68fgz1sf4vu
         Tz0gaUX2x8VCoTQ5KA7g4NOVnNIdsCOEXJKxcjb3pnBPm84lL9dJgMgKCCc9/FDxuD
         68fZpnMUJYgvag7JBBE8w0fubkYO5NSBqNz7UYHr52AHST5wAFzC5v/RzdqY1EQePt
         5/2+lV91USJd+QyM6XMYsboJbmFJtwsLbeNkSXMIUJAwy/+RElPQRU8AOaDM/gB6+E
         XBsO3Ynufi/nA==
From:   Jeff Layton <jlayton@kernel.org>
To:     chuck.lever@oracle.com
Cc:     neilb@suse.de, linux-nfs@vger.kernel.org
Subject: [PATCH v5 5/5] nfsd: fix up the filecache laundrette scheduling
Date:   Tue,  1 Nov 2022 10:46:47 -0400
Message-Id: <20221101144647.136696-6-jlayton@kernel.org>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221101144647.136696-1-jlayton@kernel.org>
References: <20221101144647.136696-1-jlayton@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-8.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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
index bcea201d79c3..a47b5b39111a 100644
--- a/fs/nfsd/filecache.c
+++ b/fs/nfsd/filecache.c
@@ -187,12 +187,9 @@ static const struct rhashtable_params nfsd_file_rhash_params = {
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
@@ -646,7 +643,8 @@ static void
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


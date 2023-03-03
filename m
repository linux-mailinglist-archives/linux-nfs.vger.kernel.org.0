Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4EC6F6A9712
	for <lists+linux-nfs@lfdr.de>; Fri,  3 Mar 2023 13:16:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230101AbjCCMQL (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 3 Mar 2023 07:16:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229923AbjCCMQL (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 3 Mar 2023 07:16:11 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F36495F538
        for <linux-nfs@vger.kernel.org>; Fri,  3 Mar 2023 04:16:09 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B2F30B8169D
        for <linux-nfs@vger.kernel.org>; Fri,  3 Mar 2023 12:16:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9806C433D2;
        Fri,  3 Mar 2023 12:16:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677845767;
        bh=MMLePmlYh4JxBRFilffhWlmx/o7CitlmkzbfIDVauk0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lihkOPkuXq3oO6HXlw3tkKESMZRwGg5fumfVfGfFeqzRf9d7o8gvGkV+ZZz7lR19K
         puO0eMULy0ErmFnJipw69WEHBfqAmQCIGzvvG0kUoc6oGt6lIfTDCID1JT/gpbtRoF
         Tnia0QDXjKD5SQ8B1+cZ5KudL6u+HTB5gdwyqHicr4gHy88DYzW1WS1H07T/61S4Qv
         vpNpPdOUDHDOj+DwLIetiECdEU02Zm4dVhs0f0ScSNHigP/2exr2J1iKLn4uL8NxCD
         oZhvzJCgqFvb+tDRNF+7cfRXlrwgLpHuWX0XkUuWOcFf3p2PQJyQf4AkJA5t7wLTJ1
         OMs0CFHV7LfrQ==
From:   Jeff Layton <jlayton@kernel.org>
To:     trond.myklebust@hammerspace.com, anna@kernel.org,
        chuck.lever@oracle.com
Cc:     linux-nfs@vger.kernel.org, yoyang@redhat.com
Subject: [PATCH 3/7] lockd: move struct nlm_wait to lockd.h
Date:   Fri,  3 Mar 2023 07:15:59 -0500
Message-Id: <20230303121603.132103-4-jlayton@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230303121603.132103-1-jlayton@kernel.org>
References: <20230303121603.132103-1-jlayton@kernel.org>
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

...and drop the unused b_reclaim field.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/lockd/clntlock.c         | 12 ------------
 include/linux/lockd/lockd.h | 11 ++++++++++-
 2 files changed, 10 insertions(+), 13 deletions(-)

diff --git a/fs/lockd/clntlock.c b/fs/lockd/clntlock.c
index 82b19a30e0f0..464cb15c1a06 100644
--- a/fs/lockd/clntlock.c
+++ b/fs/lockd/clntlock.c
@@ -29,18 +29,6 @@ static int			reclaimer(void *ptr);
  * client perspective.
  */
 
-/*
- * This is the representation of a blocked client lock.
- */
-struct nlm_wait {
-	struct list_head	b_list;		/* linked list */
-	wait_queue_head_t	b_wait;		/* where to wait on */
-	struct nlm_host *	b_host;
-	struct file_lock *	b_lock;		/* local file lock */
-	unsigned short		b_reclaim;	/* got to reclaim lock */
-	__be32			b_status;	/* grant callback status */
-};
-
 static LIST_HEAD(nlm_blocked);
 static DEFINE_SPINLOCK(nlm_blocked_lock);
 
diff --git a/include/linux/lockd/lockd.h b/include/linux/lockd/lockd.h
index 26c2aed31a0c..0eec760fcc05 100644
--- a/include/linux/lockd/lockd.h
+++ b/include/linux/lockd/lockd.h
@@ -121,7 +121,16 @@ struct nlm_lockowner {
 	uint32_t pid;
 };
 
-struct nlm_wait;
+/*
+ * This is the representation of a blocked client lock.
+ */
+struct nlm_wait {
+	struct list_head	b_list;		/* linked list */
+	wait_queue_head_t	b_wait;		/* where to wait on */
+	struct nlm_host *	b_host;
+	struct file_lock *	b_lock;		/* local file lock */
+	__be32			b_status;	/* grant callback status */
+};
 
 /*
  * Memory chunk for NLM client RPC request.
-- 
2.39.2


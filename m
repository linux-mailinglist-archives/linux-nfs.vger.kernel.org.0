Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80B0062621B
	for <lists+linux-nfs@lfdr.de>; Fri, 11 Nov 2022 20:36:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234125AbiKKTgq (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 11 Nov 2022 14:36:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233965AbiKKTgo (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 11 Nov 2022 14:36:44 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CE2076F94
        for <linux-nfs@vger.kernel.org>; Fri, 11 Nov 2022 11:36:44 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E39C6620C4
        for <linux-nfs@vger.kernel.org>; Fri, 11 Nov 2022 19:36:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DBACAC433B5;
        Fri, 11 Nov 2022 19:36:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668195403;
        bh=1rcvbrbA3THdU1VqcIfDEEvLecK4QAEHnEMXZ5CEGCo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=azcWdi9WnJed0dTCJ+hyHWDypkk9PKqWSulnoi0hgXg9onuEIsfgsfebhJb5CSVJf
         2eyUKLIM3T4clnXgik5iRP7ner8CF0WCxZ70yhOEKry0Na0nG0ovabmiI+xop5sg6M
         aiV+wMiPFht5TPsIzMyPnp2O/3ammqSL3n9Tna6KEc56GbFxC1kvEM+xoxMNc+05Oi
         kxIbCxwFCGoUY849lYeym2b1u3hdlorOpdsijxHk+zFGajMeuGPSlnSgObpko4MVRo
         TX8ukBC7Oh6bM2JIbiLetMb/O1sCLzPSo8/F4FlIb8RAovRNOkabQM/b9n+AJ6Er62
         4ktyXXoco+dsQ==
From:   Jeff Layton <jlayton@kernel.org>
To:     chuck.lever@oracle.com
Cc:     trond.myklebust@hammerspace.com, linux-nfs@vger.kernel.org
Subject: [PATCH 3/4] lockd: fix file selection in nlmsvc_cancel_blocked
Date:   Fri, 11 Nov 2022 14:36:38 -0500
Message-Id: <20221111193639.346992-4-jlayton@kernel.org>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221111193639.346992-1-jlayton@kernel.org>
References: <20221111193639.346992-1-jlayton@kernel.org>
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

We currently do a lock_to_openmode call based on the arguments from the
NLM_UNLOCK call, but that will always set the fl_type of the lock to
F_UNLCK, the the O_RDONLY descriptor is always chosen.

Fix it to use the file_lock from the block instead.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/lockd/svclock.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/fs/lockd/svclock.c b/fs/lockd/svclock.c
index 9eae99e08e69..4e30f3c50970 100644
--- a/fs/lockd/svclock.c
+++ b/fs/lockd/svclock.c
@@ -699,9 +699,10 @@ nlmsvc_cancel_blocked(struct net *net, struct nlm_file *file, struct nlm_lock *l
 	block = nlmsvc_lookup_block(file, lock);
 	mutex_unlock(&file->f_mutex);
 	if (block != NULL) {
-		mode = lock_to_openmode(&lock->fl);
-		vfs_cancel_lock(block->b_file->f_file[mode],
-				&block->b_call->a_args.lock.fl);
+		struct file_lock *fl = &block->b_call->a_args.lock.fl;
+
+		mode = lock_to_openmode(fl);
+		vfs_cancel_lock(block->b_file->f_file[mode], fl);
 		status = nlmsvc_unlink_block(block);
 		nlmsvc_release_block(block);
 	}
-- 
2.38.1


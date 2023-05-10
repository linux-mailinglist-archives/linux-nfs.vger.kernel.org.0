Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0D7F6FE28E
	for <lists+linux-nfs@lfdr.de>; Wed, 10 May 2023 18:34:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229468AbjEJQec (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 10 May 2023 12:34:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235571AbjEJQea (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 10 May 2023 12:34:30 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AFD87EE6
        for <linux-nfs@vger.kernel.org>; Wed, 10 May 2023 09:34:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A8F1F649CF
        for <linux-nfs@vger.kernel.org>; Wed, 10 May 2023 16:34:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5248C433EF;
        Wed, 10 May 2023 16:34:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683736467;
        bh=m38iE512Bp6EMTVdU69benLJi4T5hYsmaBjnWPlZ/n0=;
        h=From:To:Cc:Subject:Date:From;
        b=NEcfqKgbYBDcwRom9ae6hew2ejhPxT0vdtwZGZ2u6yC7Yc9UcJwrkaW7SDPVWv52i
         PsnY02Qg+WJL3fXCuJpOjiv/KUG4VqNZx4auUQUJBZQczaFpmtKAUYQuZtZI4nU0Fc
         EGDN09S6peKuHytJP7V26CquBy8JgQ1Jh+ECSBb9Sbbyumemq3N2g29PegDscEPDKp
         LhHAPJLzF2wsVGQqEJ7jz/QNWB/Nl2dTwSg4PUIdEPXDMFaMApjE0oZgBOBbej0JT8
         Wj540cpfr+GpY9dderPyx4MDpYggCJKZfgeER8jgfSHYy7GqwcKB4e1LDmpegVRLPI
         dVFQvejO8ExVQ==
From:   trondmy@kernel.org
To:     Anna Schumaker <Anna.Schumaker@netapp.com>
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH] SUNRPC: Don't change task->tk_status after the call to rpc_exit_task
Date:   Wed, 10 May 2023 12:28:00 -0400
Message-Id: <20230510162800.11298-1-trondmy@kernel.org>
X-Mailer: git-send-email 2.40.1
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

From: Trond Myklebust <trond.myklebust@hammerspace.com>

Some calls to rpc_exit_task() may deliberately change the value of
task->tk_status, for instance because it gets checked by the RPC call's
rpc_release() callback. That makes it wrong to reset the value to
task->tk_rpc_status.
In particular this causes a bug where the rpc_call_done() callback tries
to fail over a set of pNFS/flexfiles writes to a different IP address,
but the reset of task->tk_status causes nfs_commit_release_pages() to
immediately mark the file as having a fatal error.

Fixes: 39494194f93b ("SUNRPC: Fix races with rpc_killall_tasks()")
Cc: stable@vger.kernel.org # 6.1.x
Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 net/sunrpc/sched.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/net/sunrpc/sched.c b/net/sunrpc/sched.c
index c8321de341ee..6debf4fd42d4 100644
--- a/net/sunrpc/sched.c
+++ b/net/sunrpc/sched.c
@@ -927,11 +927,10 @@ static void __rpc_execute(struct rpc_task *task)
 		 */
 		do_action = task->tk_action;
 		/* Tasks with an RPC error status should exit */
-		if (do_action != rpc_exit_task &&
+		if (do_action && do_action != rpc_exit_task &&
 		    (status = READ_ONCE(task->tk_rpc_status)) != 0) {
 			task->tk_status = status;
-			if (do_action != NULL)
-				do_action = rpc_exit_task;
+			do_action = rpc_exit_task;
 		}
 		/* Callbacks override all actions */
 		if (task->tk_callback) {
-- 
2.40.1


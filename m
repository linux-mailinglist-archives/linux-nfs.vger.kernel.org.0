Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19A7279B828
	for <lists+linux-nfs@lfdr.de>; Tue, 12 Sep 2023 02:08:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355476AbjIKWAB (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 11 Sep 2023 18:00:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240251AbjIKOj4 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 11 Sep 2023 10:39:56 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7268F2
        for <linux-nfs@vger.kernel.org>; Mon, 11 Sep 2023 07:39:51 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23B35C433CD;
        Mon, 11 Sep 2023 14:39:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694443191;
        bh=chbm0DfounBtuwJAmzZUyiaQgHBDMnrVNllDMv0PGi0=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=S1rG4NRrUitKwolgAERYZxdC0slA+gQd8KTSeBscVqZn0tdUGJrQSGF2n4wf/Rtk+
         pJJavZpgb+KfUKAaCgqAMZCmXuF7RL+8zVQ9ApX+xZWV/VHxBnDACLYEGTEEgPuajG
         qXgmzkAiwCpg9FY30+Cw+tosjTdhl1ODi8wB+3I8zjtgw9IjWnwBrQ7M47l4wQtP9o
         slj6c3bG5Ert7Ww9a/YpfGcsyIgJ+DtnBsCn44yBJmawfYDdRoTyyD2Z7GzVEEdFG2
         9eV5GiUb1l5+LGwwSGVFeImlMd9moVtUKuSqMiWPTQ7qxRtuAmGLe/55JaKxn5PXs4
         EmCCuGN4WqMCw==
Subject: [PATCH v1 12/17] SUNRPC: rename some functions from rqst_ to
 svc_thread_
From:   Chuck Lever <cel@kernel.org>
To:     linux-nfs@vger.kernel.org
Cc:     NeilBrown <neilb@suse.de>, Chuck Lever <chuck.lever@oracle.com>
Date:   Mon, 11 Sep 2023 10:39:50 -0400
Message-ID: <169444319021.4327.4057172101389832628.stgit@bazille.1015granger.net>
In-Reply-To: <169444233785.4327.4365499966926096681.stgit@bazille.1015granger.net>
References: <169444233785.4327.4365499966926096681.stgit@bazille.1015granger.net>
User-Agent: StGit/1.5
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: NeilBrown <neilb@suse.de>

Functions which directly manipulate a 'struct rqst', such as
svc_rqst_alloc() or svc_rqst_release_pages(), can reasonably
have "rqst" in there name.
However functions that act on the running thread, such as
XX_should_sleep() or XX_wait_for_work() should seem more
natural with a "svc_thread_" prefix.

So make those changes.

Signed-off-by: NeilBrown <neilb@suse.de>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 net/sunrpc/svc_xprt.c |   10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/net/sunrpc/svc_xprt.c b/net/sunrpc/svc_xprt.c
index 17c43bde35c9..1b300a7889eb 100644
--- a/net/sunrpc/svc_xprt.c
+++ b/net/sunrpc/svc_xprt.c
@@ -699,7 +699,7 @@ static bool svc_alloc_arg(struct svc_rqst *rqstp)
 }
 
 static bool
-rqst_should_sleep(struct svc_rqst *rqstp)
+svc_thread_should_sleep(struct svc_rqst *rqstp)
 {
 	struct svc_pool		*pool = rqstp->rq_pool;
 
@@ -725,15 +725,15 @@ rqst_should_sleep(struct svc_rqst *rqstp)
 	return true;
 }
 
-static void svc_rqst_wait_for_work(struct svc_rqst *rqstp)
+static void svc_thread_wait_for_work(struct svc_rqst *rqstp)
 {
 	struct svc_pool *pool = rqstp->rq_pool;
 
-	if (rqst_should_sleep(rqstp)) {
+	if (svc_thread_should_sleep(rqstp)) {
 		set_current_state(TASK_IDLE | TASK_FREEZABLE);
 		llist_add(&rqstp->rq_idle, &pool->sp_idle_threads);
 
-		if (unlikely(!rqst_should_sleep(rqstp)))
+		if (unlikely(!svc_thread_should_sleep(rqstp)))
 			/* Work just became available.  This thread cannot simply
 			 * choose not to sleep as it *must* wait until removed.
 			 * So wake the first waiter - whether it is this
@@ -850,7 +850,7 @@ void svc_recv(struct svc_rqst *rqstp)
 	if (!svc_alloc_arg(rqstp))
 		return;
 
-	svc_rqst_wait_for_work(rqstp);
+	svc_thread_wait_for_work(rqstp);
 
 	clear_bit(SP_TASK_PENDING, &pool->sp_flags);
 



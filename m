Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70FED4DA002
	for <lists+linux-nfs@lfdr.de>; Tue, 15 Mar 2022 17:27:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241810AbiCOQ2e (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 15 Mar 2022 12:28:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241023AbiCOQ2d (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 15 Mar 2022 12:28:33 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5ED3056C07
        for <linux-nfs@vger.kernel.org>; Tue, 15 Mar 2022 09:27:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0313061478
        for <linux-nfs@vger.kernel.org>; Tue, 15 Mar 2022 16:27:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E9D1C340E8
        for <linux-nfs@vger.kernel.org>; Tue, 15 Mar 2022 16:27:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647361640;
        bh=LJGKS8YVRr2Wfr6Fi2nX8NOxhr6HXNOjzyrtXMP0Y/M=;
        h=From:To:Subject:Date:From;
        b=CTnklopFV7w4+pxcdREnvr6qpzmD6W/bQHSdit7No28SQ0cvYUiFKsBLnBLqREl+6
         Mf0jW1N5RWFnrGB6S+3O22Z3NsYjs8aJaYXscgz/tHDK83+Eq49zaO8IH1dQZ37/6D
         VRhvn76RkQgk9hYNE2eL4jSrELIpmx1SkegEcnr8sbivrLbIA1ALwNrCczU7MVQFwz
         wTLE+DHYOvhH77uKsjZ8T2IbsKzpqGjUhjCZ1uV52ySYt9DVEd/iQOrB2wQW65LTtN
         zKqHFSgu734U5YXzbUlR/6McbPCa301F/QKmIRXZigg7xdij90f1lwSRl1pct/uuLu
         +YqiJ+JUGf2Zw==
From:   trondmy@kernel.org
To:     linux-nfs@vger.kernel.org
Subject: [PATCH] NFS: Fix memory allocation in rpc_malloc()
Date:   Tue, 15 Mar 2022 12:20:52 -0400
Message-Id: <20220315162052.570677-1-trondmy@kernel.org>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-8.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Trond Myklebust <trond.myklebust@hammerspace.com>

When allocating memory, it should be safe to always use GFP_KERNEL,
since both swap tasks and asynchronous tasks will regulate the
allocation mode through the struct task flags.

Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 net/sunrpc/sched.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/net/sunrpc/sched.c b/net/sunrpc/sched.c
index 7c8f87ebdbc0..c62fcacf7366 100644
--- a/net/sunrpc/sched.c
+++ b/net/sunrpc/sched.c
@@ -1030,16 +1030,12 @@ int rpc_malloc(struct rpc_task *task)
 	struct rpc_rqst *rqst = task->tk_rqstp;
 	size_t size = rqst->rq_callsize + rqst->rq_rcvsize;
 	struct rpc_buffer *buf;
-	gfp_t gfp = GFP_KERNEL;
-
-	if (RPC_IS_ASYNC(task))
-		gfp = GFP_NOWAIT | __GFP_NOWARN;
 
 	size += sizeof(struct rpc_buffer);
 	if (size <= RPC_BUFFER_MAXSIZE)
-		buf = mempool_alloc(rpc_buffer_mempool, gfp);
+		buf = mempool_alloc(rpc_buffer_mempool, GFP_KERNEL);
 	else
-		buf = kmalloc(size, gfp);
+		buf = kmalloc(size, GFP_KERNEL);
 
 	if (!buf)
 		return -ENOMEM;
-- 
2.35.1


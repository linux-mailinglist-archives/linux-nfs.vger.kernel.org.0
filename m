Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E4255A9622
	for <lists+linux-nfs@lfdr.de>; Thu,  1 Sep 2022 14:00:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232821AbiIAMAJ (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 1 Sep 2022 08:00:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232786AbiIAMAE (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 1 Sep 2022 08:00:04 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A16E4B98
        for <linux-nfs@vger.kernel.org>; Thu,  1 Sep 2022 05:00:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 369BF61E01
        for <linux-nfs@vger.kernel.org>; Thu,  1 Sep 2022 12:00:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E94DC433D6;
        Thu,  1 Sep 2022 12:00:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662033601;
        bh=bn5HYpZj4UXUAbm8QXyKVzmQ17u6WXWf92KLIJD+P1k=;
        h=From:To:Cc:Subject:Date:From;
        b=N9qw93Tg0+7DbtWBB2VNzuTRmiJC0QZ143Mi3rwUmHFk+YcWq866WWNcjMjPlK5tc
         P/prn9cFsUrt+Elq6mU9+4iEhAfHpEW/S7L22U4qepmpFR1iuFz6RLe3Bb3uFhDlxz
         U9ItbrXBPPG+6X6/RxgQc9cDqVkKS1SbDKz+MQSThKOiSiG+SdEoxlU2Cp55vhNXZz
         JWu7S/uUEeGlmbw3nKMfKqIhV0pan8v1UOF1xQLCsPOlPk0e6ME9i1+owb15C8/BCO
         VnWM8loXf33GvDd1xtmTsyHE7XyjGd7EWN5RonFpbxWITle/iDGXNdw8EM87hPLbuv
         eAtdqPc1i5ouw==
From:   trondmy@kernel.org
To:     linux-nfs@vger.kernel.org
Cc:     Benjamin Coddington <bcodding@redhat.com>
Subject: [PATCH v2] SUNRPC: Fix call completion races with call_decode()
Date:   Thu,  1 Sep 2022 07:53:55 -0400
Message-Id: <20220901115355.35339-1-trondmy@kernel.org>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Trond Myklebust <trond.myklebust@hammerspace.com>

We need to make sure that the req->rq_private_buf is completely up to
date before we make req->rq_reply_bytes_recvd visible to the
call_decode() routine in order to avoid triggering the WARN_ON().

Reported-by: Benjamin Coddington <bcodding@redhat.com>
Fixes: 72691a269f0b ("SUNRPC: Don't reuse bvec on retransmission of the request")
Tested-by: Benjamin Coddington <bcodding@redhat.com>
Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 net/sunrpc/xprt.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/net/sunrpc/xprt.c b/net/sunrpc/xprt.c
index d71eec494826..f8fae7815649 100644
--- a/net/sunrpc/xprt.c
+++ b/net/sunrpc/xprt.c
@@ -1179,11 +1179,8 @@ xprt_request_dequeue_receive_locked(struct rpc_task *task)
 {
 	struct rpc_rqst *req = task->tk_rqstp;
 
-	if (test_and_clear_bit(RPC_TASK_NEED_RECV, &task->tk_runstate)) {
+	if (test_and_clear_bit(RPC_TASK_NEED_RECV, &task->tk_runstate))
 		xprt_request_rb_remove(req->rq_xprt, req);
-		xdr_free_bvec(&req->rq_rcv_buf);
-		req->rq_private_buf.bvec = NULL;
-	}
 }
 
 /**
@@ -1221,6 +1218,8 @@ void xprt_complete_rqst(struct rpc_task *task, int copied)
 
 	xprt->stat.recvs++;
 
+	xdr_free_bvec(&req->rq_rcv_buf);
+	req->rq_private_buf.bvec = NULL;
 	req->rq_private_buf.len = copied;
 	/* Ensure all writes are done before we update */
 	/* req->rq_reply_bytes_recvd */
@@ -1453,6 +1452,7 @@ xprt_request_dequeue_xprt(struct rpc_task *task)
 		xprt_request_dequeue_transmit_locked(task);
 		xprt_request_dequeue_receive_locked(task);
 		spin_unlock(&xprt->queue_lock);
+		xdr_free_bvec(&req->rq_rcv_buf);
 	}
 }
 
-- 
2.37.2


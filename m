Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5138F7E9D77
	for <lists+linux-nfs@lfdr.de>; Mon, 13 Nov 2023 14:43:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231367AbjKMNna (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 13 Nov 2023 08:43:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231428AbjKMNn3 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 13 Nov 2023 08:43:29 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D183D44;
        Mon, 13 Nov 2023 05:43:26 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7D00C433C8;
        Mon, 13 Nov 2023 13:43:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699883006;
        bh=PurKU7DUZBXlrLeL6TOir/sVXXCMmw1iVaKDt3IC0HE=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=F4/JS151Vc7xp092MthnmPNmDlw/3oURplg7TbgiHTW2WrSfBF/Qmzm9NCWlPENBq
         TZaeTIC8Iz8huUJpWyNIqDkQUh3zvTA/eGd5Tz/ImLL+YXNnXX1Necla3oqIOdmeOr
         z+jgrg3phsu6EeEwZU4ghhPQDFL+CPTZRjf7Z6qkVNYgsGCGpsn+RVCujyfoYcBI52
         w/uJOE7eULNJ3O0JF/5rFKOMGJ7r4jqSNnqgfXb+gip6QBcQJ+0UObmFLHrX5WhGr0
         MqVxdzDOiKxwcnlI6bjH2dMQ4tDQf05PKeWqleXPoXHoeEziHGa3ECc5u+vfc/up0T
         AcNxoiiIg8QFQ==
Subject: [PATCH v1 4/7] svcrdma: Switch Receive CQ to soft IRQ
From:   Chuck Lever <cel@kernel.org>
To:     linux-nfs@vger.kernel.org, linux-rdma@vger.kernel.org
Cc:     tom@talpey.com
Date:   Mon, 13 Nov 2023 08:43:24 -0500
Message-ID: <169988300485.6417.15944939065289556526.stgit@bazille.1015granger.net>
In-Reply-To: <169988267843.6417.17927133323277523958.stgit@bazille.1015granger.net>
References: <169988267843.6417.17927133323277523958.stgit@bazille.1015granger.net>
User-Agent: StGit/1.5
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Chuck Lever <chuck.lever@oracle.com>

The original rationale for handling Receive completions in process
context was to eliminate the use of a bottom-half-disabled spin
lock. This was intended to simplify assumptions made in the Receive
code paths and reduce lock contention.

However, a completion handled during soft IRQ is considerably lower
in average latency than taking a spin lock that disables bottom
halves, since with soft IRQ, the completion interrupt no longer has
to get scheduled onto a workqueue.

Now that Receive contexts are pre-allocated and the RPC service
thread scheduler is constant time, moving Receive completion
processing to soft IRQ is safe and simple.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 net/sunrpc/xprtrdma/svc_rdma_recvfrom.c  |    4 ++--
 net/sunrpc/xprtrdma/svc_rdma_transport.c |    4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/net/sunrpc/xprtrdma/svc_rdma_recvfrom.c b/net/sunrpc/xprtrdma/svc_rdma_recvfrom.c
index 6191ce20f89e..4ee219924433 100644
--- a/net/sunrpc/xprtrdma/svc_rdma_recvfrom.c
+++ b/net/sunrpc/xprtrdma/svc_rdma_recvfrom.c
@@ -810,14 +810,14 @@ int svc_rdma_recvfrom(struct svc_rqst *rqstp)
 	rqstp->rq_xprt_ctxt = NULL;
 
 	ctxt = NULL;
-	spin_lock(&rdma_xprt->sc_rq_dto_lock);
+	spin_lock_bh(&rdma_xprt->sc_rq_dto_lock);
 	ctxt = svc_rdma_next_recv_ctxt(&rdma_xprt->sc_rq_dto_q);
 	if (ctxt)
 		list_del(&ctxt->rc_list);
 	else
 		/* No new incoming requests, terminate the loop */
 		clear_bit(XPT_DATA, &xprt->xpt_flags);
-	spin_unlock(&rdma_xprt->sc_rq_dto_lock);
+	spin_unlock_bh(&rdma_xprt->sc_rq_dto_lock);
 
 	/* Unblock the transport for the next receive */
 	svc_xprt_received(xprt);
diff --git a/net/sunrpc/xprtrdma/svc_rdma_transport.c b/net/sunrpc/xprtrdma/svc_rdma_transport.c
index 2abd895046ee..7bd50efeeb4e 100644
--- a/net/sunrpc/xprtrdma/svc_rdma_transport.c
+++ b/net/sunrpc/xprtrdma/svc_rdma_transport.c
@@ -433,8 +433,8 @@ static struct svc_xprt *svc_rdma_accept(struct svc_xprt *xprt)
 					    IB_POLL_WORKQUEUE);
 	if (IS_ERR(newxprt->sc_sq_cq))
 		goto errout;
-	newxprt->sc_rq_cq =
-		ib_alloc_cq_any(dev, newxprt, rq_depth, IB_POLL_WORKQUEUE);
+	newxprt->sc_rq_cq = ib_alloc_cq_any(dev, newxprt, rq_depth,
+					    IB_POLL_SOFTIRQ);
 	if (IS_ERR(newxprt->sc_rq_cq))
 		goto errout;
 



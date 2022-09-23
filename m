Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92A165E7B50
	for <lists+linux-nfs@lfdr.de>; Fri, 23 Sep 2022 15:06:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231533AbiIWNGe (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 23 Sep 2022 09:06:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229833AbiIWNGe (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 23 Sep 2022 09:06:34 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C46B713A38E
        for <linux-nfs@vger.kernel.org>; Fri, 23 Sep 2022 06:06:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 615C861B83
        for <linux-nfs@vger.kernel.org>; Fri, 23 Sep 2022 13:06:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA256C433C1;
        Fri, 23 Sep 2022 13:06:31 +0000 (UTC)
Subject: [PATCH v1 5/6] xprtrdma: Memory allocation should be allowed to fail
 during connect
From:   Chuck Lever <chuck.lever@oracle.com>
To:     anna.schumaker@netapp.com
Cc:     linux-nfs@vger.kernel.org
Date:   Fri, 23 Sep 2022 09:06:30 -0400
Message-ID: <166393839078.1029362.125219349582981782.stgit@morisot.1015granger.net>
In-Reply-To: <166393821144.1029362.9036806277307694311.stgit@morisot.1015granger.net>
References: <166393821144.1029362.9036806277307694311.stgit@morisot.1015granger.net>
User-Agent: StGit/1.5
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

An attempt to establish a connection can always fail and then be
retried. GFP_KERNEL allocation is not necessary here.

Like MR allocation, establishing a connection is always done in a
worker thread. The new GFP flags align with the flags that would
be returned by rpc_task_gfp_mask() in this case.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 net/sunrpc/xprtrdma/verbs.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/net/sunrpc/xprtrdma/verbs.c b/net/sunrpc/xprtrdma/verbs.c
index 4a7b87e9e47c..7ca58cb65e27 100644
--- a/net/sunrpc/xprtrdma/verbs.c
+++ b/net/sunrpc/xprtrdma/verbs.c
@@ -372,7 +372,7 @@ static int rpcrdma_ep_create(struct rpcrdma_xprt *r_xprt)
 	struct rpcrdma_ep *ep;
 	int rc;
 
-	ep = kzalloc(sizeof(*ep), GFP_KERNEL);
+	ep = kzalloc(sizeof(*ep), XPRTRDMA_GFP_FLAGS);
 	if (!ep)
 		return -ENOTCONN;
 	ep->re_xprt = &r_xprt->rx_xprt;
@@ -605,7 +605,7 @@ static struct rpcrdma_sendctx *rpcrdma_sendctx_create(struct rpcrdma_ep *ep)
 	struct rpcrdma_sendctx *sc;
 
 	sc = kzalloc(struct_size(sc, sc_sges, ep->re_attr.cap.max_send_sge),
-		     GFP_KERNEL);
+		     XPRTRDMA_GFP_FLAGS);
 	if (!sc)
 		return NULL;
 
@@ -628,7 +628,7 @@ static int rpcrdma_sendctxs_create(struct rpcrdma_xprt *r_xprt)
 	 * Sends are posted.
 	 */
 	i = r_xprt->rx_ep->re_max_requests + RPCRDMA_MAX_BC_REQUESTS;
-	buf->rb_sc_ctxs = kcalloc(i, sizeof(sc), GFP_KERNEL);
+	buf->rb_sc_ctxs = kcalloc(i, sizeof(sc), XPRTRDMA_GFP_FLAGS);
 	if (!buf->rb_sc_ctxs)
 		return -ENOMEM;
 



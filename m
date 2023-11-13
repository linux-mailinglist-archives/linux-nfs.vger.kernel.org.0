Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3ACC7E9D76
	for <lists+linux-nfs@lfdr.de>; Mon, 13 Nov 2023 14:43:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231373AbjKMNnY (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 13 Nov 2023 08:43:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231403AbjKMNnX (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 13 Nov 2023 08:43:23 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03607172D;
        Mon, 13 Nov 2023 05:43:20 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 637C0C433C8;
        Mon, 13 Nov 2023 13:43:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699882999;
        bh=L0+/Y1s58E7taTPmGhQUW6KQj36XTxPHjKVh6Tjle54=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=XiE7s8NYLU4G0H68fgYBAXKdQPxuMuRNMD3Dbc3Utz/Ph7wCp0JZcKR+00oqJpVgm
         GIpISjIE4TLQN2/HNXV1AQVbBgkRDvLipWf1+KwYDgsLwPW4hpYiIbXAvaUa/urSCR
         AGzdSPaedtWzAsUFvm2jKR+k5+B2zCG2bJtCb+A1DqN8E/djlypX+KJ7pHlliKq+Er
         rf08QMWLJnjv9V0yX5H+LcsMeA6o4ZnH9HENN7zgij2k7CiRlmncy1vag4HXjATM7t
         CbGNeU+riQ31urXeOT/ccs/9bjTgOD8QeJsiLQ0SXbGKfQW3oICbdDnBCGns2aK31X
         02DD+P03lwriA==
Subject: [PATCH v1 3/7] svcrdma: Pre-allocate svc_rdma_recv_ctxt objects
From:   Chuck Lever <cel@kernel.org>
To:     linux-nfs@vger.kernel.org, linux-rdma@vger.kernel.org
Cc:     tom@talpey.com
Date:   Mon, 13 Nov 2023 08:43:18 -0500
Message-ID: <169988299839.6417.8336988845874237584.stgit@bazille.1015granger.net>
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

The original reason for allocating svc_rdma_recv_ctxt objects during
Receive completion was to ensure the objects were allocated on the
NUMA node closest to the underlying IB device.

Since commit c5d68d25bd6b ("svcrdma: Clean up allocation of
svc_rdma_recv_ctxt"), however, the device's favored node is
explicitly passed to the memory allocator.

To enable switching Receive completion to soft IRQ context, move
memory allocation out of completion handling, since it can be
costly, and it can sleep.

A limited number of objects is now allocated at "accept" time.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 net/sunrpc/xprtrdma/svc_rdma_recvfrom.c |   32 ++++++++++++++++++++-----------
 1 file changed, 21 insertions(+), 11 deletions(-)

diff --git a/net/sunrpc/xprtrdma/svc_rdma_recvfrom.c b/net/sunrpc/xprtrdma/svc_rdma_recvfrom.c
index 69cc21654365..6191ce20f89e 100644
--- a/net/sunrpc/xprtrdma/svc_rdma_recvfrom.c
+++ b/net/sunrpc/xprtrdma/svc_rdma_recvfrom.c
@@ -205,18 +205,11 @@ struct svc_rdma_recv_ctxt *svc_rdma_recv_ctxt_get(struct svcxprt_rdma *rdma)
 
 	node = llist_del_first(&rdma->sc_recv_ctxts);
 	if (!node)
-		goto out_empty;
-	ctxt = llist_entry(node, struct svc_rdma_recv_ctxt, rc_node);
+		return NULL;
 
-out:
+	ctxt = llist_entry(node, struct svc_rdma_recv_ctxt, rc_node);
 	ctxt->rc_page_count = 0;
 	return ctxt;
-
-out_empty:
-	ctxt = svc_rdma_recv_ctxt_alloc(rdma);
-	if (!ctxt)
-		return NULL;
-	goto out;
 }
 
 /**
@@ -278,7 +271,7 @@ static bool svc_rdma_refresh_recvs(struct svcxprt_rdma *rdma,
 		rdma->sc_pending_recvs++;
 	}
 	if (!recv_chain)
-		return false;
+		return true;
 
 	ret = ib_post_recv(rdma->sc_qp, recv_chain, &bad_wr);
 	if (ret)
@@ -302,10 +295,27 @@ static bool svc_rdma_refresh_recvs(struct svcxprt_rdma *rdma,
  * svc_rdma_post_recvs - Post initial set of Recv WRs
  * @rdma: fresh svcxprt_rdma
  *
- * Returns true if successful, otherwise false.
+ * Return values:
+ *   %true: Receive Queue initialization successful
+ *   %false: memory allocation or DMA error
  */
 bool svc_rdma_post_recvs(struct svcxprt_rdma *rdma)
 {
+	unsigned int total;
+
+	/* For each credit, allocate enough recv_ctxts for one
+	 * posted Receive and one RPC in process.
+	 */
+	total = (rdma->sc_max_requests * 2) + rdma->sc_recv_batch;
+	while (total--) {
+		struct svc_rdma_recv_ctxt *ctxt;
+
+		ctxt = svc_rdma_recv_ctxt_alloc(rdma);
+		if (!ctxt)
+			return false;
+		llist_add(&ctxt->rc_node, &rdma->sc_recv_ctxts);
+	}
+
 	return svc_rdma_refresh_recvs(rdma, rdma->sc_max_requests);
 }
 



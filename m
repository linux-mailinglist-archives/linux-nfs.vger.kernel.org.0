Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 518647E9D7E
	for <lists+linux-nfs@lfdr.de>; Mon, 13 Nov 2023 14:43:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231436AbjKMNnt (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 13 Nov 2023 08:43:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231440AbjKMNns (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 13 Nov 2023 08:43:48 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6C0D132;
        Mon, 13 Nov 2023 05:43:45 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1591DC433C9;
        Mon, 13 Nov 2023 13:43:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699883025;
        bh=zNd+G+1IihzPTwhS+TvIhUCeqzB2pnsHXfpvmHRUUfw=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=k2KRH7Kg/+ShKnngqSKXVdUQdUAZmpdX0EN55yMkX/2bsPqwQ6Ca94s/rvnBuFvi8
         U9YKDUuSHtTuZTRykQTLOZ8Ugcifa9P7NXtNOMb+WzfktDqI5Cpz1NIQwloBPZBpCd
         mBslipUCaAFqFIiPN6mxWxEz5K8gY49TXhepJQX5Qs/bPblZiVx9RWn8mYL/e654No
         IziDiJTr1YwzaYeEePZGJxzBWKkpUedzuzEZ8t4J25121keHmjFgKT7bPn0xHkATGl
         KGNMI0t9axO1jrCOaLUsziiB8GLQgTH94Wqb+v2nSJuUGCsj9cHMsun/yqRLys+Hc1
         /h/6ALNYPOhTQ==
Subject: [PATCH v1 7/7] svcrdma: Move Send CQ to SOFTIRQ context
From:   Chuck Lever <cel@kernel.org>
To:     linux-nfs@vger.kernel.org, linux-rdma@vger.kernel.org
Cc:     tom@talpey.com
Date:   Mon, 13 Nov 2023 08:43:44 -0500
Message-ID: <169988302403.6417.12005628146945923629.stgit@bazille.1015granger.net>
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

I've noticed that using the ib-comp-wq workqueue delays Send
Completions anywhere between 5us and 3 or more milliseconds.

For RDMA Write and Send completions, this is not a terribly
significant issue, since these just release resources. They do not
contribute to RPC round-trip time.

However, for RDMA Read completions, it delays the start of NFS
WRITE operations, adding round-trip latency.

For small to moderate NFS WRITEs, using soft IRQ completion means
up to 5us better latency per NFS WRITE -- this is a significant
portion of average RTT for small NFS WRITEs, which is 40-75us.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 net/sunrpc/xprtrdma/svc_rdma_rw.c        |    4 ++--
 net/sunrpc/xprtrdma/svc_rdma_sendto.c    |    6 +++---
 net/sunrpc/xprtrdma/svc_rdma_transport.c |    2 +-
 3 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/net/sunrpc/xprtrdma/svc_rdma_rw.c b/net/sunrpc/xprtrdma/svc_rdma_rw.c
index e460e25a1d6d..ada164c027bc 100644
--- a/net/sunrpc/xprtrdma/svc_rdma_rw.c
+++ b/net/sunrpc/xprtrdma/svc_rdma_rw.c
@@ -56,9 +56,9 @@ svc_rdma_get_rw_ctxt(struct svcxprt_rdma *rdma, unsigned int sges)
 	struct svc_rdma_rw_ctxt *ctxt;
 	struct llist_node *node;
 
-	spin_lock(&rdma->sc_rw_ctxt_lock);
+	spin_lock_bh(&rdma->sc_rw_ctxt_lock);
 	node = llist_del_first(&rdma->sc_rw_ctxts);
-	spin_unlock(&rdma->sc_rw_ctxt_lock);
+	spin_unlock_bh(&rdma->sc_rw_ctxt_lock);
 	if (node) {
 		ctxt = llist_entry(node, struct svc_rdma_rw_ctxt, rw_node);
 	} else {
diff --git a/net/sunrpc/xprtrdma/svc_rdma_sendto.c b/net/sunrpc/xprtrdma/svc_rdma_sendto.c
index e27345af6289..49a9f409bc8e 100644
--- a/net/sunrpc/xprtrdma/svc_rdma_sendto.c
+++ b/net/sunrpc/xprtrdma/svc_rdma_sendto.c
@@ -198,12 +198,13 @@ struct svc_rdma_send_ctxt *svc_rdma_send_ctxt_get(struct svcxprt_rdma *rdma)
 	struct svc_rdma_send_ctxt *ctxt;
 	struct llist_node *node;
 
-	spin_lock(&rdma->sc_send_lock);
+	spin_lock_bh(&rdma->sc_send_lock);
 	node = llist_del_first(&rdma->sc_send_ctxts);
+	spin_unlock_bh(&rdma->sc_send_lock);
 	if (!node)
 		goto out_empty;
+
 	ctxt = llist_entry(node, struct svc_rdma_send_ctxt, sc_node);
-	spin_unlock(&rdma->sc_send_lock);
 
 out:
 	rpcrdma_set_xdrlen(&ctxt->sc_hdrbuf, 0);
@@ -216,7 +217,6 @@ struct svc_rdma_send_ctxt *svc_rdma_send_ctxt_get(struct svcxprt_rdma *rdma)
 	return ctxt;
 
 out_empty:
-	spin_unlock(&rdma->sc_send_lock);
 	ctxt = svc_rdma_send_ctxt_alloc(rdma);
 	if (!ctxt)
 		return NULL;
diff --git a/net/sunrpc/xprtrdma/svc_rdma_transport.c b/net/sunrpc/xprtrdma/svc_rdma_transport.c
index 7bd50efeeb4e..8de32927cd7d 100644
--- a/net/sunrpc/xprtrdma/svc_rdma_transport.c
+++ b/net/sunrpc/xprtrdma/svc_rdma_transport.c
@@ -430,7 +430,7 @@ static struct svc_xprt *svc_rdma_accept(struct svc_xprt *xprt)
 		goto errout;
 	}
 	newxprt->sc_sq_cq = ib_alloc_cq_any(dev, newxprt, newxprt->sc_sq_depth,
-					    IB_POLL_WORKQUEUE);
+					    IB_POLL_SOFTIRQ);
 	if (IS_ERR(newxprt->sc_sq_cq))
 		goto errout;
 	newxprt->sc_rq_cq = ib_alloc_cq_any(dev, newxprt, rq_depth,



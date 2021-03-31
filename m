Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 19D65350783
	for <lists+linux-nfs@lfdr.de>; Wed, 31 Mar 2021 21:37:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236282AbhCaThA (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 31 Mar 2021 15:37:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:44526 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236268AbhCaTga (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Wed, 31 Mar 2021 15:36:30 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 480F761029;
        Wed, 31 Mar 2021 19:36:30 +0000 (UTC)
Subject: [PATCH v1 5/8] xprtrdma: Improve commentary around
 rpcrdma_reps_unmap()
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-rdma@vger.kernel.org, linux-nfs@vger.kernel.org
Date:   Wed, 31 Mar 2021 15:36:29 -0400
Message-ID: <161721938951.515226.17560651611000798100.stgit@manet.1015granger.net>
In-Reply-To: <161721926778.515226.9805598788670386587.stgit@manet.1015granger.net>
References: <161721926778.515226.9805598788670386587.stgit@manet.1015granger.net>
User-Agent: StGit/0.23-29-ga622f1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 net/sunrpc/xprtrdma/verbs.c |    6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/net/sunrpc/xprtrdma/verbs.c b/net/sunrpc/xprtrdma/verbs.c
index fe250d554695..b68fc81a78fb 100644
--- a/net/sunrpc/xprtrdma/verbs.c
+++ b/net/sunrpc/xprtrdma/verbs.c
@@ -1034,6 +1034,10 @@ static void rpcrdma_rep_put(struct rpcrdma_buffer *buf,
 	llist_add(&rep->rr_node, &buf->rb_free_reps);
 }
 
+/* Caller must ensure the QP is quiescent (RQ is drained) before
+ * invoking this function, to guarantee rb_all_reps is not
+ * changing.
+ */
 static void rpcrdma_reps_unmap(struct rpcrdma_xprt *r_xprt)
 {
 	struct rpcrdma_buffer *buf = &r_xprt->rx_buf;
@@ -1041,7 +1045,7 @@ static void rpcrdma_reps_unmap(struct rpcrdma_xprt *r_xprt)
 
 	list_for_each_entry(rep, &buf->rb_all_reps, rr_all) {
 		rpcrdma_regbuf_dma_unmap(rep->rr_rdmabuf);
-		rep->rr_temp = true;
+		rep->rr_temp = true;	/* Mark this rep for destruction */
 	}
 }
 



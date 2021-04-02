Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C86DF352D87
	for <lists+linux-nfs@lfdr.de>; Fri,  2 Apr 2021 18:10:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236041AbhDBPar (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 2 Apr 2021 11:30:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:39400 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236043AbhDBPap (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Fri, 2 Apr 2021 11:30:45 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3EBA961179;
        Fri,  2 Apr 2021 15:30:44 +0000 (UTC)
Subject: [PATCH v2 5/8] xprtrdma: Improve commentary around
 rpcrdma_reps_unmap()
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org, linux-rdma@vger.kernel.org
Date:   Fri, 02 Apr 2021 11:30:43 -0400
Message-ID: <161737744332.2012531.12297020793967436935.stgit@manet.1015granger.net>
In-Reply-To: <161737723751.2012531.17740046594972271239.stgit@manet.1015granger.net>
References: <161737723751.2012531.17740046594972271239.stgit@manet.1015granger.net>
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
index 482fdc9e25c2..f3482fd67ec2 100644
--- a/net/sunrpc/xprtrdma/verbs.c
+++ b/net/sunrpc/xprtrdma/verbs.c
@@ -1041,6 +1041,10 @@ static void rpcrdma_rep_put(struct rpcrdma_buffer *buf,
 	llist_add(&rep->rr_node, &buf->rb_free_reps);
 }
 
+/* Caller must ensure the QP is quiescent (RQ is drained) before
+ * invoking this function, to guarantee rb_all_reps is not
+ * changing.
+ */
 static void rpcrdma_reps_unmap(struct rpcrdma_xprt *r_xprt)
 {
 	struct rpcrdma_buffer *buf = &r_xprt->rx_buf;
@@ -1048,7 +1052,7 @@ static void rpcrdma_reps_unmap(struct rpcrdma_xprt *r_xprt)
 
 	list_for_each_entry(rep, &buf->rb_all_reps, rr_all) {
 		rpcrdma_regbuf_dma_unmap(rep->rr_rdmabuf);
-		rep->rr_temp = true;
+		rep->rr_temp = true;	/* Mark this rep for destruction */
 	}
 }
 



Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C4582354545
	for <lists+linux-nfs@lfdr.de>; Mon,  5 Apr 2021 18:35:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242438AbhDEQfN (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 5 Apr 2021 12:35:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:40804 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238877AbhDEQfM (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Mon, 5 Apr 2021 12:35:12 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6B3FE613A0;
        Mon,  5 Apr 2021 16:35:06 +0000 (UTC)
Subject: [PATCH v1 3/6] xprtrdma: Clarify use of barrier in
 frwr_wc_localinv_done()
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-rdma@vger.kernel.org, linux-nfs@vger.kernel.org
Date:   Mon, 05 Apr 2021 12:35:05 -0400
Message-ID: <161764050565.29855.12756886215434593857.stgit@manet.1015granger.net>
In-Reply-To: <161764034907.29855.614994107807503843.stgit@manet.1015granger.net>
References: <161764034907.29855.614994107807503843.stgit@manet.1015granger.net>
User-Agent: StGit/0.23-29-ga622f1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Clean up: The comment and the placement of the memory barrier is
confusing. Humans want to read the function statements from head
to tail.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 net/sunrpc/xprtrdma/frwr_ops.c |    8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/net/sunrpc/xprtrdma/frwr_ops.c b/net/sunrpc/xprtrdma/frwr_ops.c
index bfc057fdb75f..af85cec0ce31 100644
--- a/net/sunrpc/xprtrdma/frwr_ops.c
+++ b/net/sunrpc/xprtrdma/frwr_ops.c
@@ -592,14 +592,16 @@ static void frwr_wc_localinv_done(struct ib_cq *cq, struct ib_wc *wc)
 	struct rpcrdma_frwr *frwr =
 		container_of(cqe, struct rpcrdma_frwr, fr_cqe);
 	struct rpcrdma_mr *mr = container_of(frwr, struct rpcrdma_mr, frwr);
-	struct rpcrdma_rep *rep = mr->mr_req->rl_reply;
+	struct rpcrdma_rep *rep;
 
 	/* WARNING: Only wr_cqe and status are reliable at this point */
 	trace_xprtrdma_wc_li_done(wc, &frwr->fr_cid);
-	frwr_mr_done(wc, mr);
 
-	/* Ensure @rep is generated before frwr_mr_done */
+	/* Ensure that @rep is generated before the MR is released */
+	rep = mr->mr_req->rl_reply;
 	smp_rmb();
+
+	frwr_mr_done(wc, mr);
 	rpcrdma_complete_rqst(rep);
 
 	rpcrdma_flush_disconnect(cq->cq_context, wc);



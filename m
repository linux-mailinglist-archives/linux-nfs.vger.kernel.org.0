Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 451DF352D88
	for <lists+linux-nfs@lfdr.de>; Fri,  2 Apr 2021 18:10:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235904AbhDBPaw (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 2 Apr 2021 11:30:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:39432 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235248AbhDBPav (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Fri, 2 Apr 2021 11:30:51 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 76E7F60FF0;
        Fri,  2 Apr 2021 15:30:50 +0000 (UTC)
Subject: [PATCH v2 6/8] xprtrdma: Improve locking around rpcrdma_rep creation
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org, linux-rdma@vger.kernel.org
Date:   Fri, 02 Apr 2021 11:30:49 -0400
Message-ID: <161737744965.2012531.7439307241507111514.stgit@manet.1015granger.net>
In-Reply-To: <161737723751.2012531.17740046594972271239.stgit@manet.1015granger.net>
References: <161737723751.2012531.17740046594972271239.stgit@manet.1015granger.net>
User-Agent: StGit/0.23-29-ga622f1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Defensive clean up: Protect the rb_all_reps list during rep
creation.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 net/sunrpc/xprtrdma/verbs.c |    9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/net/sunrpc/xprtrdma/verbs.c b/net/sunrpc/xprtrdma/verbs.c
index f3482fd67ec2..0ade69501061 100644
--- a/net/sunrpc/xprtrdma/verbs.c
+++ b/net/sunrpc/xprtrdma/verbs.c
@@ -963,13 +963,11 @@ static void rpcrdma_reqs_reset(struct rpcrdma_xprt *r_xprt)
 		rpcrdma_req_reset(req);
 }
 
-/* No locking needed here. This function is called only by the
- * Receive completion handler.
- */
 static noinline
 struct rpcrdma_rep *rpcrdma_rep_create(struct rpcrdma_xprt *r_xprt,
 				       bool temp)
 {
+	struct rpcrdma_buffer *buf = &r_xprt->rx_buf;
 	struct rpcrdma_rep *rep;
 
 	rep = kzalloc(sizeof(*rep), GFP_KERNEL);
@@ -996,7 +994,10 @@ struct rpcrdma_rep *rpcrdma_rep_create(struct rpcrdma_xprt *r_xprt,
 	rep->rr_recv_wr.sg_list = &rep->rr_rdmabuf->rg_iov;
 	rep->rr_recv_wr.num_sge = 1;
 	rep->rr_temp = temp;
-	list_add(&rep->rr_all, &r_xprt->rx_buf.rb_all_reps);
+
+	spin_lock(&buf->rb_lock);
+	list_add(&rep->rr_all, &buf->rb_all_reps);
+	spin_unlock(&buf->rb_lock);
 	return rep;
 
 out_free_regbuf:



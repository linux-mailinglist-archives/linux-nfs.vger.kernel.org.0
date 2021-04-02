Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 614D5352D7F
	for <lists+linux-nfs@lfdr.de>; Fri,  2 Apr 2021 18:10:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235441AbhDBPai (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 2 Apr 2021 11:30:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:39282 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235343AbhDBPad (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Fri, 2 Apr 2021 11:30:33 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id C3D0260FF0;
        Fri,  2 Apr 2021 15:30:31 +0000 (UTC)
Subject: [PATCH v2 3/8] xprtrdma: Put flushed Receives on free list instead of
 destroying them
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org, linux-rdma@vger.kernel.org
Date:   Fri, 02 Apr 2021 11:30:31 -0400
Message-ID: <161737743099.2012531.1841242459992882071.stgit@manet.1015granger.net>
In-Reply-To: <161737723751.2012531.17740046594972271239.stgit@manet.1015granger.net>
References: <161737723751.2012531.17740046594972271239.stgit@manet.1015granger.net>
User-Agent: StGit/0.23-29-ga622f1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Defer destruction of an rpcrdma_rep until transport tear-down to
preserve the rb_all_reps list while Receives flush.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
Reviewed-by: Tom Talpey <tom@talpey.com>
---
 net/sunrpc/xprtrdma/verbs.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/net/sunrpc/xprtrdma/verbs.c b/net/sunrpc/xprtrdma/verbs.c
index d8ed69442219..1b599a623eea 100644
--- a/net/sunrpc/xprtrdma/verbs.c
+++ b/net/sunrpc/xprtrdma/verbs.c
@@ -80,6 +80,8 @@ static void rpcrdma_sendctx_put_locked(struct rpcrdma_xprt *r_xprt,
 				       struct rpcrdma_sendctx *sc);
 static int rpcrdma_reqs_setup(struct rpcrdma_xprt *r_xprt);
 static void rpcrdma_reqs_reset(struct rpcrdma_xprt *r_xprt);
+static void rpcrdma_rep_put(struct rpcrdma_buffer *buf,
+			    struct rpcrdma_rep *rep);
 static void rpcrdma_rep_destroy(struct rpcrdma_rep *rep);
 static void rpcrdma_reps_unmap(struct rpcrdma_xprt *r_xprt);
 static void rpcrdma_mrs_create(struct rpcrdma_xprt *r_xprt);
@@ -211,7 +213,7 @@ static void rpcrdma_wc_receive(struct ib_cq *cq, struct ib_wc *wc)
 
 out_flushed:
 	rpcrdma_flush_disconnect(r_xprt, wc);
-	rpcrdma_rep_destroy(rep);
+	rpcrdma_rep_put(&r_xprt->rx_buf, rep);
 }
 
 static void rpcrdma_update_cm_private(struct rpcrdma_ep *ep,



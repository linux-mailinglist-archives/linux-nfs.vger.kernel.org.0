Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 44324350772
	for <lists+linux-nfs@lfdr.de>; Wed, 31 Mar 2021 21:37:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236210AbhCaTg2 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 31 Mar 2021 15:36:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:44464 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236012AbhCaTgS (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Wed, 31 Mar 2021 15:36:18 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 196426100C;
        Wed, 31 Mar 2021 19:36:18 +0000 (UTC)
Subject: [PATCH v1 3/8] xprtrdma: Put flushed Receives on free list instead of
 destroying them
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-rdma@vger.kernel.org, linux-nfs@vger.kernel.org
Date:   Wed, 31 Mar 2021 15:36:17 -0400
Message-ID: <161721937732.515226.2170674299158077377.stgit@manet.1015granger.net>
In-Reply-To: <161721926778.515226.9805598788670386587.stgit@manet.1015granger.net>
References: <161721926778.515226.9805598788670386587.stgit@manet.1015granger.net>
User-Agent: StGit/0.23-29-ga622f1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Defer destruction of an rpcrdma_rep until transport tear-down to
avoid races between Receive completion and rpcrdma_reps_unmap().

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 net/sunrpc/xprtrdma/verbs.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/net/sunrpc/xprtrdma/verbs.c b/net/sunrpc/xprtrdma/verbs.c
index 1d88685badbe..92af272f9cc9 100644
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
@@ -205,7 +207,7 @@ static void rpcrdma_wc_receive(struct ib_cq *cq, struct ib_wc *wc)
 
 out_flushed:
 	rpcrdma_flush_disconnect(r_xprt, wc);
-	rpcrdma_rep_destroy(rep);
+	rpcrdma_rep_put(&r_xprt->rx_buf, rep);
 }
 
 static void rpcrdma_update_cm_private(struct rpcrdma_ep *ep,



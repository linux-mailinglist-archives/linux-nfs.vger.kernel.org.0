Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B183364972
	for <lists+linux-nfs@lfdr.de>; Mon, 19 Apr 2021 20:02:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240487AbhDSSCs (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 19 Apr 2021 14:02:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:40922 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240433AbhDSSCr (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Mon, 19 Apr 2021 14:02:47 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1849061107;
        Mon, 19 Apr 2021 18:02:17 +0000 (UTC)
Subject: [PATCH v3 06/26] xprtrdma: Put flushed Receives on free list instead
 of destroying them
From:   Chuck Lever <chuck.lever@oracle.com>
To:     trondmy@hammerspace.com
Cc:     linux-nfs@vger.kernel.org, linux-rdma@vger.kernel.org
Date:   Mon, 19 Apr 2021 14:02:16 -0400
Message-ID: <161885533627.38598.12133596202333658270.stgit@manet.1015granger.net>
In-Reply-To: <161885481568.38598.16682844600209775665.stgit@manet.1015granger.net>
References: <161885481568.38598.16682844600209775665.stgit@manet.1015granger.net>
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



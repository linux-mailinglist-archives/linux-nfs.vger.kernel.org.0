Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3CE863DDF85
	for <lists+linux-nfs@lfdr.de>; Mon,  2 Aug 2021 20:44:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229880AbhHBSox (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 2 Aug 2021 14:44:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:58740 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229847AbhHBSox (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Mon, 2 Aug 2021 14:44:53 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 649FB60F6E;
        Mon,  2 Aug 2021 18:44:43 +0000 (UTC)
Subject: [PATCH v1 5/5] xprtrdma: Eliminate rpcrdma_post_sends()
From:   Chuck Lever <chuck.lever@oracle.com>
To:     trondmy@hammerspace.com, anna.schumaker@netapp.com
Cc:     linux-rdma@vger.kernel.org, linux-nfs@vger.kernel.org
Date:   Mon, 02 Aug 2021 14:44:42 -0400
Message-ID: <162792988270.3902.15378426204950453026.stgit@manet.1015granger.net>
In-Reply-To: <162792979429.3902.11831790821518477892.stgit@manet.1015granger.net>
References: <162792979429.3902.11831790821518477892.stgit@manet.1015granger.net>
User-Agent: StGit/1.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Clean up.

Now that there is only one registration mode, there is only one
target "post_send" method: frwr_send(). rpcrdma_post_sends() no
longer adds much value, especially since all of its call sites
ignore the return code value except to check if it's non-zero.

Just have them call frwr_send() directly instead.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 net/sunrpc/xprtrdma/backchannel.c |    2 +-
 net/sunrpc/xprtrdma/transport.c   |    2 +-
 net/sunrpc/xprtrdma/verbs.c       |   15 ---------------
 net/sunrpc/xprtrdma/xprt_rdma.h   |    1 -
 4 files changed, 2 insertions(+), 18 deletions(-)

diff --git a/net/sunrpc/xprtrdma/backchannel.c b/net/sunrpc/xprtrdma/backchannel.c
index 1151efd09b27..17f174d6ea3b 100644
--- a/net/sunrpc/xprtrdma/backchannel.c
+++ b/net/sunrpc/xprtrdma/backchannel.c
@@ -115,7 +115,7 @@ int xprt_rdma_bc_send_reply(struct rpc_rqst *rqst)
 	if (rc < 0)
 		goto failed_marshal;
 
-	if (rpcrdma_post_sends(r_xprt, req))
+	if (frwr_send(r_xprt, req))
 		goto drop_connection;
 	return 0;
 
diff --git a/net/sunrpc/xprtrdma/transport.c b/net/sunrpc/xprtrdma/transport.c
index 9c2ffc67c0fd..a463400ed5a3 100644
--- a/net/sunrpc/xprtrdma/transport.c
+++ b/net/sunrpc/xprtrdma/transport.c
@@ -661,7 +661,7 @@ xprt_rdma_send_request(struct rpc_rqst *rqst)
 		goto drop_connection;
 	rqst->rq_xtime = ktime_get();
 
-	if (rpcrdma_post_sends(r_xprt, req))
+	if (frwr_send(r_xprt, req))
 		goto drop_connection;
 
 	rqst->rq_xmit_bytes_sent += rqst->rq_snd_buf.len;
diff --git a/net/sunrpc/xprtrdma/verbs.c b/net/sunrpc/xprtrdma/verbs.c
index 1e9041c022b6..aaec3c9be8db 100644
--- a/net/sunrpc/xprtrdma/verbs.c
+++ b/net/sunrpc/xprtrdma/verbs.c
@@ -1349,21 +1349,6 @@ static void rpcrdma_regbuf_free(struct rpcrdma_regbuf *rb)
 	kfree(rb);
 }
 
-/**
- * rpcrdma_post_sends - Post WRs to a transport's Send Queue
- * @r_xprt: controlling transport instance
- * @req: rpcrdma_req containing the Send WR to post
- *
- * Returns 0 if the post was successful, otherwise -ENOTCONN
- * is returned.
- */
-int rpcrdma_post_sends(struct rpcrdma_xprt *r_xprt, struct rpcrdma_req *req)
-{
-	if (frwr_send(r_xprt, req))
-		return -ENOTCONN;
-	return 0;
-}
-
 /**
  * rpcrdma_post_recvs - Refill the Receive Queue
  * @r_xprt: controlling transport instance
diff --git a/net/sunrpc/xprtrdma/xprt_rdma.h b/net/sunrpc/xprtrdma/xprt_rdma.h
index 927e20a2c04e..d91f54eae00b 100644
--- a/net/sunrpc/xprtrdma/xprt_rdma.h
+++ b/net/sunrpc/xprtrdma/xprt_rdma.h
@@ -459,7 +459,6 @@ void rpcrdma_flush_disconnect(struct rpcrdma_xprt *r_xprt, struct ib_wc *wc);
 int rpcrdma_xprt_connect(struct rpcrdma_xprt *r_xprt);
 void rpcrdma_xprt_disconnect(struct rpcrdma_xprt *r_xprt);
 
-int rpcrdma_post_sends(struct rpcrdma_xprt *r_xprt, struct rpcrdma_req *req);
 void rpcrdma_post_recvs(struct rpcrdma_xprt *r_xprt, int needed, bool temp);
 
 /*



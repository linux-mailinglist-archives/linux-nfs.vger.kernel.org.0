Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A519364981
	for <lists+linux-nfs@lfdr.de>; Mon, 19 Apr 2021 20:03:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240547AbhDSSDc (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 19 Apr 2021 14:03:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:41192 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240553AbhDSSDb (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Mon, 19 Apr 2021 14:03:31 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 19C0861107;
        Mon, 19 Apr 2021 18:03:01 +0000 (UTC)
Subject: [PATCH v3 13/26] xprtrdma: Rename frwr_release_mr()
From:   Chuck Lever <chuck.lever@oracle.com>
To:     trondmy@hammerspace.com
Cc:     linux-nfs@vger.kernel.org, linux-rdma@vger.kernel.org
Date:   Mon, 19 Apr 2021 14:03:00 -0400
Message-ID: <161885538028.38598.6546480161907588794.stgit@manet.1015granger.net>
In-Reply-To: <161885481568.38598.16682844600209775665.stgit@manet.1015granger.net>
References: <161885481568.38598.16682844600209775665.stgit@manet.1015granger.net>
User-Agent: StGit/0.23-29-ga622f1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Clean up: To be consistent with other functions in this source file,
follow the naming convention of putting the object being acted upon
before the action itself.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 net/sunrpc/xprtrdma/frwr_ops.c  |    6 +++---
 net/sunrpc/xprtrdma/verbs.c     |    4 ++--
 net/sunrpc/xprtrdma/xprt_rdma.h |    2 +-
 3 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/net/sunrpc/xprtrdma/frwr_ops.c b/net/sunrpc/xprtrdma/frwr_ops.c
index aca2228095db..bfc057fdb75f 100644
--- a/net/sunrpc/xprtrdma/frwr_ops.c
+++ b/net/sunrpc/xprtrdma/frwr_ops.c
@@ -50,11 +50,11 @@
 #endif
 
 /**
- * frwr_release_mr - Destroy one MR
+ * frwr_mr_release - Destroy one MR
  * @mr: MR allocated by frwr_mr_init
  *
  */
-void frwr_release_mr(struct rpcrdma_mr *mr)
+void frwr_mr_release(struct rpcrdma_mr *mr)
 {
 	int rc;
 
@@ -88,7 +88,7 @@ static void frwr_mr_recycle(struct rpcrdma_mr *mr)
 	r_xprt->rx_stats.mrs_recycled++;
 	spin_unlock(&r_xprt->rx_buf.rb_lock);
 
-	frwr_release_mr(mr);
+	frwr_mr_release(mr);
 }
 
 static void frwr_mr_put(struct rpcrdma_mr *mr)
diff --git a/net/sunrpc/xprtrdma/verbs.c b/net/sunrpc/xprtrdma/verbs.c
index 098d5c550e9b..d4e573eef416 100644
--- a/net/sunrpc/xprtrdma/verbs.c
+++ b/net/sunrpc/xprtrdma/verbs.c
@@ -1138,7 +1138,7 @@ void rpcrdma_req_destroy(struct rpcrdma_req *req)
 		list_del(&mr->mr_all);
 		spin_unlock(&buf->rb_lock);
 
-		frwr_release_mr(mr);
+		frwr_mr_release(mr);
 	}
 
 	rpcrdma_regbuf_free(req->rl_recvbuf);
@@ -1169,7 +1169,7 @@ static void rpcrdma_mrs_destroy(struct rpcrdma_xprt *r_xprt)
 		list_del(&mr->mr_all);
 		spin_unlock(&buf->rb_lock);
 
-		frwr_release_mr(mr);
+		frwr_mr_release(mr);
 
 		spin_lock(&buf->rb_lock);
 	}
diff --git a/net/sunrpc/xprtrdma/xprt_rdma.h b/net/sunrpc/xprtrdma/xprt_rdma.h
index 9c5039d4634a..1b187d1dee8a 100644
--- a/net/sunrpc/xprtrdma/xprt_rdma.h
+++ b/net/sunrpc/xprtrdma/xprt_rdma.h
@@ -528,7 +528,7 @@ rpcrdma_data_dir(bool writing)
 void frwr_reset(struct rpcrdma_req *req);
 int frwr_query_device(struct rpcrdma_ep *ep, const struct ib_device *device);
 int frwr_mr_init(struct rpcrdma_xprt *r_xprt, struct rpcrdma_mr *mr);
-void frwr_release_mr(struct rpcrdma_mr *mr);
+void frwr_mr_release(struct rpcrdma_mr *mr);
 struct rpcrdma_mr_seg *frwr_map(struct rpcrdma_xprt *r_xprt,
 				struct rpcrdma_mr_seg *seg,
 				int nsegs, bool writing, __be32 xid,



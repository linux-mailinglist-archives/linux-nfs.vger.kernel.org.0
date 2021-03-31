Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D2E52350776
	for <lists+linux-nfs@lfdr.de>; Wed, 31 Mar 2021 21:37:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236228AbhCaTg2 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 31 Mar 2021 15:36:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:44502 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236084AbhCaTgY (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Wed, 31 Mar 2021 15:36:24 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2EC1C61056;
        Wed, 31 Mar 2021 19:36:24 +0000 (UTC)
Subject: [PATCH v1 4/8] xprtrdma: Improve locking around rpcrdma_rep
 destruction
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-rdma@vger.kernel.org, linux-nfs@vger.kernel.org
Date:   Wed, 31 Mar 2021 15:36:23 -0400
Message-ID: <161721938342.515226.14847295549827213112.stgit@manet.1015granger.net>
In-Reply-To: <161721926778.515226.9805598788670386587.stgit@manet.1015granger.net>
References: <161721926778.515226.9805598788670386587.stgit@manet.1015granger.net>
User-Agent: StGit/0.23-29-ga622f1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Currently rpcrdma_reps_destroy() assumes that, at transport
tear-down, the content of the rb_free_reps list is the same as the
content of the rb_all_reps list. Although that is usually true,
using the rb_all_reps list should be more reliable because of
the way it's managed. And, rpcrdma_reps_unmap() uses rb_all_reps;
these two should both traverse the "all" list.

Instead, ensure that all rpcrdma_reps are always destroyed whether
they are on the rep free list or not. Also ensure that rpcrdma_rep
destruction logic is protected by the rb_lock.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 net/sunrpc/xprtrdma/verbs.c |   31 ++++++++++++++++++++++++-------
 1 file changed, 24 insertions(+), 7 deletions(-)

diff --git a/net/sunrpc/xprtrdma/verbs.c b/net/sunrpc/xprtrdma/verbs.c
index 92af272f9cc9..fe250d554695 100644
--- a/net/sunrpc/xprtrdma/verbs.c
+++ b/net/sunrpc/xprtrdma/verbs.c
@@ -1000,16 +1000,23 @@ struct rpcrdma_rep *rpcrdma_rep_create(struct rpcrdma_xprt *r_xprt,
 	return NULL;
 }
 
-/* No locking needed here. This function is invoked only by the
- * Receive completion handler, or during transport shutdown.
- */
-static void rpcrdma_rep_destroy(struct rpcrdma_rep *rep)
+static void rpcrdma_rep_destroy_locked(struct rpcrdma_rep *rep)
 {
-	list_del(&rep->rr_all);
 	rpcrdma_regbuf_free(rep->rr_rdmabuf);
 	kfree(rep);
 }
 
+static void rpcrdma_rep_destroy(struct rpcrdma_rep *rep)
+{
+	struct rpcrdma_buffer *buf = &rep->rr_rxprt->rx_buf;
+
+	spin_lock(&buf->rb_lock);
+	list_del(&rep->rr_all);
+	spin_unlock(&buf->rb_lock);
+
+	rpcrdma_rep_destroy_locked(rep);
+}
+
 static struct rpcrdma_rep *rpcrdma_rep_get_locked(struct rpcrdma_buffer *buf)
 {
 	struct llist_node *node;
@@ -1042,8 +1049,18 @@ static void rpcrdma_reps_destroy(struct rpcrdma_buffer *buf)
 {
 	struct rpcrdma_rep *rep;
 
-	while ((rep = rpcrdma_rep_get_locked(buf)) != NULL)
-		rpcrdma_rep_destroy(rep);
+	spin_lock(&buf->rb_lock);
+	while ((rep = list_first_entry_or_null(&buf->rb_all_reps,
+					       struct rpcrdma_rep,
+					       rr_all)) != NULL) {
+		list_del(&rep->rr_all);
+		spin_unlock(&buf->rb_lock);
+
+		rpcrdma_rep_destroy_locked(rep);
+
+		spin_lock(&buf->rb_lock);
+	}
+	spin_unlock(&buf->rb_lock);
 }
 
 /**



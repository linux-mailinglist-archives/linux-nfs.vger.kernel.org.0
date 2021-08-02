Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 82D843DDF7D
	for <lists+linux-nfs@lfdr.de>; Mon,  2 Aug 2021 20:44:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231273AbhHBSog (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 2 Aug 2021 14:44:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:58496 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229677AbhHBSoe (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Mon, 2 Aug 2021 14:44:34 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id D5F6E60EC0;
        Mon,  2 Aug 2021 18:44:24 +0000 (UTC)
Subject: [PATCH v1 2/5] xprtrdma: Put rpcrdma_reps before waking the tear-down
 completion
From:   Chuck Lever <chuck.lever@oracle.com>
To:     trondmy@hammerspace.com, anna.schumaker@netapp.com
Cc:     linux-rdma@vger.kernel.org, linux-nfs@vger.kernel.org
Date:   Mon, 02 Aug 2021 14:44:24 -0400
Message-ID: <162792986415.3902.15504693027425496524.stgit@manet.1015granger.net>
In-Reply-To: <162792979429.3902.11831790821518477892.stgit@manet.1015granger.net>
References: <162792979429.3902.11831790821518477892.stgit@manet.1015granger.net>
User-Agent: StGit/1.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Ensure the tear-down completion is awoken only /after/ we've stopped
fiddling with rpcrdma_rep objects in rpcrdma_post_recvs().

Fixes: 15788d1d1077 ("xprtrdma: Do not refresh Receive Queue while it is draining")
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 net/sunrpc/xprtrdma/verbs.c |   10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/net/sunrpc/xprtrdma/verbs.c b/net/sunrpc/xprtrdma/verbs.c
index c1797ea19418..016f10a781b4 100644
--- a/net/sunrpc/xprtrdma/verbs.c
+++ b/net/sunrpc/xprtrdma/verbs.c
@@ -1416,11 +1416,6 @@ void rpcrdma_post_recvs(struct rpcrdma_xprt *r_xprt, int needed, bool temp)
 
 	rc = ib_post_recv(ep->re_id->qp, wr,
 			  (const struct ib_recv_wr **)&bad_wr);
-	if (atomic_dec_return(&ep->re_receiving) > 0)
-		complete(&ep->re_done);
-
-out:
-	trace_xprtrdma_post_recvs(r_xprt, count, rc);
 	if (rc) {
 		for (wr = bad_wr; wr;) {
 			struct rpcrdma_rep *rep;
@@ -1431,6 +1426,11 @@ void rpcrdma_post_recvs(struct rpcrdma_xprt *r_xprt, int needed, bool temp)
 			--count;
 		}
 	}
+	if (atomic_dec_return(&ep->re_receiving) > 0)
+		complete(&ep->re_done);
+
+out:
+	trace_xprtrdma_post_recvs(r_xprt, count, rc);
 	ep->re_receive_count += count;
 	return;
 }



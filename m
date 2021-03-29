Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A7FEF34D28D
	for <lists+linux-nfs@lfdr.de>; Mon, 29 Mar 2021 16:40:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230503AbhC2OkP (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 29 Mar 2021 10:40:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:40476 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230504AbhC2OkM (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Mon, 29 Mar 2021 10:40:12 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2378A61933;
        Mon, 29 Mar 2021 14:40:12 +0000 (UTC)
Subject: [PATCH v1 4/6] svcrdma: Remove sc_read_complete_q
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org, linux-rdma@vger.kernel.org
Date:   Mon, 29 Mar 2021 10:40:11 -0400
Message-ID: <161702881132.5937.1618694752019390220.stgit@klimt.1015granger.net>
In-Reply-To: <161702808762.5937.3596341039481819410.stgit@klimt.1015granger.net>
References: <161702808762.5937.3596341039481819410.stgit@klimt.1015granger.net>
User-Agent: StGit/1.0-5-g755c
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Now that svc_rdma_recvfrom() waits for Read completion,
sc_read_complete_q is no longer used.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 include/linux/sunrpc/svc_rdma.h          |    2 -
 net/sunrpc/xprtrdma/svc_rdma_recvfrom.c  |   57 +++---------------------------
 net/sunrpc/xprtrdma/svc_rdma_transport.c |    1 -
 3 files changed, 6 insertions(+), 54 deletions(-)

diff --git a/include/linux/sunrpc/svc_rdma.h b/include/linux/sunrpc/svc_rdma.h
index 6e621e1f56b8..b72f75091404 100644
--- a/include/linux/sunrpc/svc_rdma.h
+++ b/include/linux/sunrpc/svc_rdma.h
@@ -106,7 +106,6 @@ struct svcxprt_rdma {
 
 	wait_queue_head_t    sc_send_wait;	/* SQ exhaustion waitlist */
 	unsigned long	     sc_flags;
-	struct list_head     sc_read_complete_q;
 	struct work_struct   sc_work;
 
 	struct llist_head    sc_recv_ctxts;
@@ -140,7 +139,6 @@ struct svc_rdma_recv_ctxt {
 	bool			rc_temp;
 	u32			rc_byte_len;
 	unsigned int		rc_page_count;
-	unsigned int		rc_hdr_count;
 	u32			rc_inv_rkey;
 	__be32			rc_msgtype;
 
diff --git a/net/sunrpc/xprtrdma/svc_rdma_recvfrom.c b/net/sunrpc/xprtrdma/svc_rdma_recvfrom.c
index b857a6805e95..7c7eca07b965 100644
--- a/net/sunrpc/xprtrdma/svc_rdma_recvfrom.c
+++ b/net/sunrpc/xprtrdma/svc_rdma_recvfrom.c
@@ -89,8 +89,7 @@
  * svc_rdma_recvfrom call returns.
  *
  * During the second svc_rdma_recvfrom call, RDMA Read sink pages
- * are transferred from the svc_rdma_recv_ctxt to the second svc_rqst
- * (see rdma_read_complete() below).
+ * are transferred from the svc_rdma_recv_ctxt to the second svc_rqst.
  */
 
 #include <linux/slab.h>
@@ -379,10 +378,6 @@ void svc_rdma_flush_recv_queues(struct svcxprt_rdma *rdma)
 {
 	struct svc_rdma_recv_ctxt *ctxt;
 
-	while ((ctxt = svc_rdma_next_recv_ctxt(&rdma->sc_read_complete_q))) {
-		list_del(&ctxt->rc_list);
-		svc_rdma_recv_ctxt_put(rdma, ctxt);
-	}
 	while ((ctxt = svc_rdma_next_recv_ctxt(&rdma->sc_rq_dto_q))) {
 		list_del(&ctxt->rc_list);
 		svc_rdma_recv_ctxt_put(rdma, ctxt);
@@ -720,35 +715,6 @@ static int svc_rdma_xdr_decode_req(struct xdr_buf *rq_arg,
 	return -EINVAL;
 }
 
-static void rdma_read_complete(struct svc_rqst *rqstp,
-			       struct svc_rdma_recv_ctxt *head)
-{
-	int page_no;
-
-	/* Move Read chunk pages to rqstp so that they will be released
-	 * when svc_process is done with them.
-	 */
-	for (page_no = 0; page_no < head->rc_page_count; page_no++) {
-		put_page(rqstp->rq_pages[page_no]);
-		rqstp->rq_pages[page_no] = head->rc_pages[page_no];
-	}
-	head->rc_page_count = 0;
-
-	/* Point rq_arg.pages past header */
-	rqstp->rq_arg.pages = &rqstp->rq_pages[head->rc_hdr_count];
-	rqstp->rq_arg.page_len = head->rc_arg.page_len;
-
-	/* rq_respages starts after the last arg page */
-	rqstp->rq_respages = &rqstp->rq_pages[page_no];
-	rqstp->rq_next_page = rqstp->rq_respages + 1;
-
-	/* Rebuild rq_arg head and tail. */
-	rqstp->rq_arg.head[0] = head->rc_arg.head[0];
-	rqstp->rq_arg.tail[0] = head->rc_arg.tail[0];
-	rqstp->rq_arg.len = head->rc_arg.len;
-	rqstp->rq_arg.buflen = head->rc_arg.buflen;
-}
-
 static void svc_rdma_send_error(struct svcxprt_rdma *rdma,
 				struct svc_rdma_recv_ctxt *rctxt,
 				int status)
@@ -834,13 +800,6 @@ int svc_rdma_recvfrom(struct svc_rqst *rqstp)
 	rqstp->rq_xprt_ctxt = NULL;
 
 	spin_lock(&rdma_xprt->sc_rq_dto_lock);
-	ctxt = svc_rdma_next_recv_ctxt(&rdma_xprt->sc_read_complete_q);
-	if (ctxt) {
-		list_del(&ctxt->rc_list);
-		spin_unlock(&rdma_xprt->sc_rq_dto_lock);
-		rdma_read_complete(rqstp, ctxt);
-		goto complete;
-	}
 	ctxt = svc_rdma_next_recv_ctxt(&rdma_xprt->sc_rq_dto_q);
 	if (!ctxt) {
 		/* No new incoming requests, terminate the loop */
@@ -880,21 +839,17 @@ int svc_rdma_recvfrom(struct svc_rqst *rqstp)
 	svc_rdma_get_inv_rkey(rdma_xprt, ctxt);
 
 	if (!pcl_is_empty(&ctxt->rc_read_pcl) ||
-	    !pcl_is_empty(&ctxt->rc_call_pcl))
-		goto out_readlist;
+	    !pcl_is_empty(&ctxt->rc_call_pcl)) {
+		ret = svc_rdma_process_read_list(rdma_xprt, rqstp, ctxt);
+		if (ret < 0)
+			goto out_readfail;
+	}
 
-complete:
 	rqstp->rq_xprt_ctxt = ctxt;
 	rqstp->rq_prot = IPPROTO_MAX;
 	svc_xprt_copy_addrs(rqstp, xprt);
 	return rqstp->rq_arg.len;
 
-out_readlist:
-	ret = svc_rdma_process_read_list(rdma_xprt, rqstp, ctxt);
-	if (ret < 0)
-		goto out_readfail;
-	goto complete;
-
 out_err:
 	svc_rdma_send_error(rdma_xprt, ctxt, ret);
 	svc_rdma_recv_ctxt_put(rdma_xprt, ctxt);
diff --git a/net/sunrpc/xprtrdma/svc_rdma_transport.c b/net/sunrpc/xprtrdma/svc_rdma_transport.c
index 3646216211c5..d94b7759ada1 100644
--- a/net/sunrpc/xprtrdma/svc_rdma_transport.c
+++ b/net/sunrpc/xprtrdma/svc_rdma_transport.c
@@ -136,7 +136,6 @@ static struct svcxprt_rdma *svc_rdma_create_xprt(struct svc_serv *serv,
 	svc_xprt_init(net, &svc_rdma_class, &cma_xprt->sc_xprt, serv);
 	INIT_LIST_HEAD(&cma_xprt->sc_accept_q);
 	INIT_LIST_HEAD(&cma_xprt->sc_rq_dto_q);
-	INIT_LIST_HEAD(&cma_xprt->sc_read_complete_q);
 	INIT_LIST_HEAD(&cma_xprt->sc_send_ctxts);
 	init_llist_head(&cma_xprt->sc_recv_ctxts);
 	INIT_LIST_HEAD(&cma_xprt->sc_rw_ctxts);



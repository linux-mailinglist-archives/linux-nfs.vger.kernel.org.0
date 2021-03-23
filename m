Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 314423469F4
	for <lists+linux-nfs@lfdr.de>; Tue, 23 Mar 2021 21:38:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233383AbhCWUhu (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 23 Mar 2021 16:37:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:49172 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233231AbhCWUhW (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Tue, 23 Mar 2021 16:37:22 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id BD2F9619CB;
        Tue, 23 Mar 2021 20:37:21 +0000 (UTC)
Subject: [PATCH 1 3/4] svcrdma: Remove unused sc_pages field
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org, linux-rdma@vger.kernel.org
Date:   Tue, 23 Mar 2021 16:37:21 -0400
Message-ID: <161653184101.1499.4809246769074235203.stgit@klimt.1015granger.net>
In-Reply-To: <161653161669.1499.11923816743962834540.stgit@klimt.1015granger.net>
References: <161653161669.1499.11923816743962834540.stgit@klimt.1015granger.net>
User-Agent: StGit/1.0-5-g755c
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Clean up. This significantly reduces the size of struct
svc_rdma_send_ctxt.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 include/linux/sunrpc/svc_rdma.h       |    3 +--
 net/sunrpc/xprtrdma/svc_rdma_sendto.c |   25 -------------------------
 2 files changed, 1 insertion(+), 27 deletions(-)

diff --git a/include/linux/sunrpc/svc_rdma.h b/include/linux/sunrpc/svc_rdma.h
index 5841978550c6..6e621e1f56b8 100644
--- a/include/linux/sunrpc/svc_rdma.h
+++ b/include/linux/sunrpc/svc_rdma.h
@@ -164,9 +164,8 @@ struct svc_rdma_send_ctxt {
 	struct xdr_buf		sc_hdrbuf;
 	struct xdr_stream	sc_stream;
 	void			*sc_xprt_buf;
-	int			sc_page_count;
 	int			sc_cur_sge_no;
-	struct page		*sc_pages[RPCSVC_MAXPAGES];
+
 	struct ib_sge		sc_sges[];
 };
 
diff --git a/net/sunrpc/xprtrdma/svc_rdma_sendto.c b/net/sunrpc/xprtrdma/svc_rdma_sendto.c
index 62d55850ca54..f093c9b536ff 100644
--- a/net/sunrpc/xprtrdma/svc_rdma_sendto.c
+++ b/net/sunrpc/xprtrdma/svc_rdma_sendto.c
@@ -219,7 +219,6 @@ struct svc_rdma_send_ctxt *svc_rdma_send_ctxt_get(struct svcxprt_rdma *rdma)
 
 	ctxt->sc_send_wr.num_sge = 0;
 	ctxt->sc_cur_sge_no = 0;
-	ctxt->sc_page_count = 0;
 	return ctxt;
 
 out_empty:
@@ -234,8 +233,6 @@ struct svc_rdma_send_ctxt *svc_rdma_send_ctxt_get(struct svcxprt_rdma *rdma)
  * svc_rdma_send_ctxt_put - Return send_ctxt to free list
  * @rdma: controlling svcxprt_rdma
  * @ctxt: object to return to the free list
- *
- * Pages left in sc_pages are DMA unmapped and released.
  */
 void svc_rdma_send_ctxt_put(struct svcxprt_rdma *rdma,
 			    struct svc_rdma_send_ctxt *ctxt)
@@ -256,9 +253,6 @@ void svc_rdma_send_ctxt_put(struct svcxprt_rdma *rdma,
 					     ctxt->sc_sges[i].length);
 	}
 
-	for (i = 0; i < ctxt->sc_page_count; ++i)
-		put_page(ctxt->sc_pages[i]);
-
 	spin_lock(&rdma->sc_send_lock);
 	list_add(&ctxt->sc_list, &rdma->sc_send_ctxts);
 	spin_unlock(&rdma->sc_send_lock);
@@ -792,25 +786,6 @@ int svc_rdma_map_reply_msg(struct svcxprt_rdma *rdma,
 				       svc_rdma_xb_dma_map, &args);
 }
 
-/* The svc_rqst and all resources it owns are released as soon as
- * svc_rdma_sendto returns. Transfer pages under I/O to the ctxt
- * so they are released by the Send completion handler.
- */
-static inline void svc_rdma_save_io_pages(struct svc_rqst *rqstp,
-				   struct svc_rdma_send_ctxt *ctxt)
-{
-	int i, pages = rqstp->rq_next_page - rqstp->rq_respages;
-
-	ctxt->sc_page_count += pages;
-	for (i = 0; i < pages; i++) {
-		ctxt->sc_pages[i] = rqstp->rq_respages[i];
-		rqstp->rq_respages[i] = NULL;
-	}
-
-	/* Prevent svc_xprt_release from releasing pages in rq_pages */
-	rqstp->rq_next_page = rqstp->rq_respages;
-}
-
 /* Prepare the portion of the RPC Reply that will be transmitted
  * via RDMA Send. The RPC-over-RDMA transport header is prepared
  * in sc_sges[0], and the RPC xdr_buf is prepared in following sges.



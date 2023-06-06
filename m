Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9AB47724A57
	for <lists+linux-nfs@lfdr.de>; Tue,  6 Jun 2023 19:33:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237447AbjFFRdu (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 6 Jun 2023 13:33:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238806AbjFFRdd (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 6 Jun 2023 13:33:33 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B488C1705;
        Tue,  6 Jun 2023 10:33:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 231966305C;
        Tue,  6 Jun 2023 17:33:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D2ACC433EF;
        Tue,  6 Jun 2023 17:33:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686072811;
        bh=UpXOOvsn5wQY9HQgBgMPhKKi5IeBhkq0JbPhinW+NfM=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=GRNXooSYH+UZil6RkLMYymYNx5NWL6tWm758xHx2goibO+mKX7N0tcmiKPaBfnvp2
         0lxPVdThRFsMKMO1ePMCOIMMvHpjsLmQ3kjbv2cmmMcsJD9kbTlTXy9cyaWuKwITjR
         QbSkIK4wUa2uD/Ja1GXrLRujy50loiS1/4MN6bBQfOKHba4MeWbXRIMKCraLPJZDqU
         Xr4XbD3t/806ADtD2k0Dq4JPZxRxuWSuFeLNJRhrFXrzLWXjIuC6DcyNnA78GzxgwG
         ripsAVJuETsQ3n3gQhbygfWPAx79ia4hVQJ1Yvrt3J0Xtr1l8x5VR14xX63YjduXdm
         WGqJwNzLBEWHg==
Subject: [PATCH v1 2/4] SUNRPC: Revert 579900670ac7
From:   Chuck Lever <cel@kernel.org>
To:     linux-nfs@vger.kernel.org
Cc:     Chuck Lever <chuck.lever@oracle.com>, linux-rdma@vger.kernel.org,
        tom@talpey.com
Date:   Tue, 06 Jun 2023 13:33:30 -0400
Message-ID: <168607281028.2076.11971808021420433856.stgit@manet.1015granger.net>
In-Reply-To: <168607259937.2076.15447551371235387735.stgit@manet.1015granger.net>
References: <168607259937.2076.15447551371235387735.stgit@manet.1015granger.net>
User-Agent: StGit/1.5
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Chuck Lever <chuck.lever@oracle.com>

Pre-requisite for releasing pages in the send completion handler.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 include/linux/sunrpc/svc_rdma.h       |    3 ++-
 net/sunrpc/xprtrdma/svc_rdma_sendto.c |   25 +++++++++++++++++++++++++
 2 files changed, 27 insertions(+), 1 deletion(-)

diff --git a/include/linux/sunrpc/svc_rdma.h b/include/linux/sunrpc/svc_rdma.h
index a0f3ea357977..8e654da55170 100644
--- a/include/linux/sunrpc/svc_rdma.h
+++ b/include/linux/sunrpc/svc_rdma.h
@@ -158,8 +158,9 @@ struct svc_rdma_send_ctxt {
 	struct xdr_buf		sc_hdrbuf;
 	struct xdr_stream	sc_stream;
 	void			*sc_xprt_buf;
+	int			sc_page_count;
 	int			sc_cur_sge_no;
-
+	struct page		*sc_pages[RPCSVC_MAXPAGES];
 	struct ib_sge		sc_sges[];
 };
 
diff --git a/net/sunrpc/xprtrdma/svc_rdma_sendto.c b/net/sunrpc/xprtrdma/svc_rdma_sendto.c
index 8e7ccef74207..4c62bc41ea40 100644
--- a/net/sunrpc/xprtrdma/svc_rdma_sendto.c
+++ b/net/sunrpc/xprtrdma/svc_rdma_sendto.c
@@ -213,6 +213,7 @@ struct svc_rdma_send_ctxt *svc_rdma_send_ctxt_get(struct svcxprt_rdma *rdma)
 
 	ctxt->sc_send_wr.num_sge = 0;
 	ctxt->sc_cur_sge_no = 0;
+	ctxt->sc_page_count = 0;
 	return ctxt;
 
 out_empty:
@@ -227,6 +228,8 @@ struct svc_rdma_send_ctxt *svc_rdma_send_ctxt_get(struct svcxprt_rdma *rdma)
  * svc_rdma_send_ctxt_put - Return send_ctxt to free list
  * @rdma: controlling svcxprt_rdma
  * @ctxt: object to return to the free list
+ *
+ * Pages left in sc_pages are DMA unmapped and released.
  */
 void svc_rdma_send_ctxt_put(struct svcxprt_rdma *rdma,
 			    struct svc_rdma_send_ctxt *ctxt)
@@ -234,6 +237,9 @@ void svc_rdma_send_ctxt_put(struct svcxprt_rdma *rdma,
 	struct ib_device *device = rdma->sc_cm_id->device;
 	unsigned int i;
 
+	for (i = 0; i < ctxt->sc_page_count; ++i)
+		put_page(ctxt->sc_pages[i]);
+
 	/* The first SGE contains the transport header, which
 	 * remains mapped until @ctxt is destroyed.
 	 */
@@ -798,6 +804,25 @@ int svc_rdma_map_reply_msg(struct svcxprt_rdma *rdma,
 				       svc_rdma_xb_dma_map, &args);
 }
 
+/* The svc_rqst and all resources it owns are released as soon as
+ * svc_rdma_sendto returns. Transfer pages under I/O to the ctxt
+ * so they are released by the Send completion handler.
+ */
+static inline void svc_rdma_save_io_pages(struct svc_rqst *rqstp,
+					  struct svc_rdma_send_ctxt *ctxt)
+{
+	int i, pages = rqstp->rq_next_page - rqstp->rq_respages;
+
+	ctxt->sc_page_count += pages;
+	for (i = 0; i < pages; i++) {
+		ctxt->sc_pages[i] = rqstp->rq_respages[i];
+		rqstp->rq_respages[i] = NULL;
+	}
+
+	/* Prevent svc_xprt_release from releasing pages in rq_pages */
+	rqstp->rq_next_page = rqstp->rq_respages;
+}
+
 /* Prepare the portion of the RPC Reply that will be transmitted
  * via RDMA Send. The RPC-over-RDMA transport header is prepared
  * in sc_sges[0], and the RPC xdr_buf is prepared in following sges.



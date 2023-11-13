Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 880B57E9D7A
	for <lists+linux-nfs@lfdr.de>; Mon, 13 Nov 2023 14:43:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231435AbjKMNng (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 13 Nov 2023 08:43:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231403AbjKMNnf (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 13 Nov 2023 08:43:35 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D49E81A2;
        Mon, 13 Nov 2023 05:43:32 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30954C433C8;
        Mon, 13 Nov 2023 13:43:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699883012;
        bh=VHoqppGnHdOrBVYCSsM3iJLIfCpyjVwwtWSf802otXc=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=j/1EQgiDtldKkAwRJpl05JsccGyyvmKsB9Ss61OVnOStMq/VR08njwRIStV37nJeF
         rMrpRemrecCPWInO8QIkh7TJlpTbr3dqaopsF4BuZZ8+1ha8b+CDI1UDI3p8pEmGHD
         EAOGZNlsZoGlOucbQb3ci2BmK9k5a6I9mIc9nFfcDs9ESu8IkTLMs+s/KPwtzKmVh5
         JkOJRjDdfSDn74PiRvLYea0xi+eLCyLoJKV982UymO4hOtcfNcIkHKdbksLCPs3Mk3
         YkUHjUkjGMUJdnIyIl5tFyuLZJDysgjgA1jJxaCzDo+J85mVQoZBmEJ3hE+tIMisti
         2EqlnF5bgjtyw==
Subject: [PATCH v1 5/7] svcrdma: Clean up use of rdma->sc_pd->device
From:   Chuck Lever <cel@kernel.org>
To:     linux-nfs@vger.kernel.org, linux-rdma@vger.kernel.org
Cc:     tom@talpey.com
Date:   Mon, 13 Nov 2023 08:43:31 -0500
Message-ID: <169988301128.6417.2640827711073808511.stgit@bazille.1015granger.net>
In-Reply-To: <169988267843.6417.17927133323277523958.stgit@bazille.1015granger.net>
References: <169988267843.6417.17927133323277523958.stgit@bazille.1015granger.net>
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

I can't think of a reason why svcrdma is using the PD's device. Most
other consumers of the IB DMA API use the ib_device pointer from the
connection's rdma_cm_id.

I don't think there's any functional difference between the two, but
it is a little confusing to see some uses of rdma_cm_id and some of
ib_pd.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 net/sunrpc/xprtrdma/svc_rdma_sendto.c |   22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/net/sunrpc/xprtrdma/svc_rdma_sendto.c b/net/sunrpc/xprtrdma/svc_rdma_sendto.c
index 45735f74eb86..e27345af6289 100644
--- a/net/sunrpc/xprtrdma/svc_rdma_sendto.c
+++ b/net/sunrpc/xprtrdma/svc_rdma_sendto.c
@@ -123,22 +123,23 @@ static void svc_rdma_send_cid_init(struct svcxprt_rdma *rdma,
 static struct svc_rdma_send_ctxt *
 svc_rdma_send_ctxt_alloc(struct svcxprt_rdma *rdma)
 {
-	int node = ibdev_to_node(rdma->sc_cm_id->device);
+	struct ib_device *device = rdma->sc_cm_id->device;
 	struct svc_rdma_send_ctxt *ctxt;
 	dma_addr_t addr;
 	void *buffer;
 	int i;
 
 	ctxt = kmalloc_node(struct_size(ctxt, sc_sges, rdma->sc_max_send_sges),
-			    GFP_KERNEL, node);
+			    GFP_KERNEL, ibdev_to_node(device));
 	if (!ctxt)
 		goto fail0;
-	buffer = kmalloc_node(rdma->sc_max_req_size, GFP_KERNEL, node);
+	buffer = kmalloc_node(rdma->sc_max_req_size, GFP_KERNEL,
+			      ibdev_to_node(device));
 	if (!buffer)
 		goto fail1;
-	addr = ib_dma_map_single(rdma->sc_pd->device, buffer,
-				 rdma->sc_max_req_size, DMA_TO_DEVICE);
-	if (ib_dma_mapping_error(rdma->sc_pd->device, addr))
+	addr = ib_dma_map_single(device, buffer, rdma->sc_max_req_size,
+				 DMA_TO_DEVICE);
+	if (ib_dma_mapping_error(device, addr))
 		goto fail2;
 
 	svc_rdma_send_cid_init(rdma, &ctxt->sc_cid);
@@ -172,15 +173,14 @@ svc_rdma_send_ctxt_alloc(struct svcxprt_rdma *rdma)
  */
 void svc_rdma_send_ctxts_destroy(struct svcxprt_rdma *rdma)
 {
+	struct ib_device *device = rdma->sc_cm_id->device;
 	struct svc_rdma_send_ctxt *ctxt;
 	struct llist_node *node;
 
 	while ((node = llist_del_first(&rdma->sc_send_ctxts)) != NULL) {
 		ctxt = llist_entry(node, struct svc_rdma_send_ctxt, sc_node);
-		ib_dma_unmap_single(rdma->sc_pd->device,
-				    ctxt->sc_sges[0].addr,
-				    rdma->sc_max_req_size,
-				    DMA_TO_DEVICE);
+		ib_dma_unmap_single(device, ctxt->sc_sges[0].addr,
+				    rdma->sc_max_req_size, DMA_TO_DEVICE);
 		kfree(ctxt->sc_xprt_buf);
 		kfree(ctxt);
 	}
@@ -318,7 +318,7 @@ int svc_rdma_send(struct svcxprt_rdma *rdma, struct svc_rdma_send_ctxt *ctxt)
 	might_sleep();
 
 	/* Sync the transport header buffer */
-	ib_dma_sync_single_for_device(rdma->sc_pd->device,
+	ib_dma_sync_single_for_device(rdma->sc_cm_id->device,
 				      wr->sg_list[0].addr,
 				      wr->sg_list[0].length,
 				      DMA_TO_DEVICE);



Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 418D67E9D73
	for <lists+linux-nfs@lfdr.de>; Mon, 13 Nov 2023 14:43:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231423AbjKMNnR (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 13 Nov 2023 08:43:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231389AbjKMNnQ (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 13 Nov 2023 08:43:16 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83247D51;
        Mon, 13 Nov 2023 05:43:13 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5CB1C433C7;
        Mon, 13 Nov 2023 13:43:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699882993;
        bh=8/KpESZhH8UUTgiENVB0Cw+EDjoA/5tTwqj4bDbduF0=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=kfdAAHii3Ht7fPYes3OEbir4ajZ1mH5aqZ0DB6X3Ctp3+ihgxnIzqPalaaUc02Re6
         p6CUINrSKmh879ZyBNZx2chJ3BNFzpfHHpnWlOONpkHlGa7tkn2c5zHfHdsS75plNH
         hT7jyKMg2KEUdtqlT+La9brlpUB00h8nc3aOYBDKbKFvsOPmf4AZj9aqo9RMZnKxb1
         OGJa/1SXAg2rKJTaNvY8ElbVBmm6us0lg8IoQvHCW/9Zs63XmVbtcPFpNB4/fmc4OY
         txu/EBCMv2RRka1P+XAw7khITFYr01mOx0kDS5jrpLhc2OhCwjzJes2JNx2R3n6e9f
         JoPVIfLI7ZxSw==
Subject: [PATCH v1 2/7] svcrdma: Clean up use of rdma->sc_pd->device in
 Receive paths
From:   Chuck Lever <cel@kernel.org>
To:     linux-nfs@vger.kernel.org, linux-rdma@vger.kernel.org
Cc:     tom@talpey.com
Date:   Mon, 13 Nov 2023 08:43:12 -0500
Message-ID: <169988299199.6417.2235443204829287810.stgit@bazille.1015granger.net>
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

I don't belive there's any functional difference between the two,
but it is a little confusing to see some uses of rdma_cm_id->device
and some of ib_pd->device.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 net/sunrpc/xprtrdma/svc_rdma_recvfrom.c |   17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/net/sunrpc/xprtrdma/svc_rdma_recvfrom.c b/net/sunrpc/xprtrdma/svc_rdma_recvfrom.c
index 3b05f90a3e50..69cc21654365 100644
--- a/net/sunrpc/xprtrdma/svc_rdma_recvfrom.c
+++ b/net/sunrpc/xprtrdma/svc_rdma_recvfrom.c
@@ -125,20 +125,21 @@ static void svc_rdma_recv_cid_init(struct svcxprt_rdma *rdma,
 static struct svc_rdma_recv_ctxt *
 svc_rdma_recv_ctxt_alloc(struct svcxprt_rdma *rdma)
 {
-	int node = ibdev_to_node(rdma->sc_cm_id->device);
+	struct ib_device *device = rdma->sc_cm_id->device;
 	struct svc_rdma_recv_ctxt *ctxt;
 	dma_addr_t addr;
 	void *buffer;
 
-	ctxt = kmalloc_node(sizeof(*ctxt), GFP_KERNEL, node);
+	ctxt = kmalloc_node(sizeof(*ctxt), GFP_KERNEL, ibdev_to_node(device));
 	if (!ctxt)
 		goto fail0;
-	buffer = kmalloc_node(rdma->sc_max_req_size, GFP_KERNEL, node);
+	buffer = kmalloc_node(rdma->sc_max_req_size, GFP_KERNEL,
+			      ibdev_to_node(device));
 	if (!buffer)
 		goto fail1;
-	addr = ib_dma_map_single(rdma->sc_pd->device, buffer,
-				 rdma->sc_max_req_size, DMA_FROM_DEVICE);
-	if (ib_dma_mapping_error(rdma->sc_pd->device, addr))
+	addr = ib_dma_map_single(device, buffer, rdma->sc_max_req_size,
+				 DMA_FROM_DEVICE);
+	if (ib_dma_mapping_error(device, addr))
 		goto fail2;
 
 	svc_rdma_recv_cid_init(rdma, &ctxt->rc_cid);
@@ -169,7 +170,7 @@ svc_rdma_recv_ctxt_alloc(struct svcxprt_rdma *rdma)
 static void svc_rdma_recv_ctxt_destroy(struct svcxprt_rdma *rdma,
 				       struct svc_rdma_recv_ctxt *ctxt)
 {
-	ib_dma_unmap_single(rdma->sc_pd->device, ctxt->rc_recv_sge.addr,
+	ib_dma_unmap_single(rdma->sc_cm_id->device, ctxt->rc_recv_sge.addr,
 			    ctxt->rc_recv_sge.length, DMA_FROM_DEVICE);
 	kfree(ctxt->rc_recv_buf);
 	kfree(ctxt);
@@ -814,7 +815,7 @@ int svc_rdma_recvfrom(struct svc_rqst *rqstp)
 		return 0;
 
 	percpu_counter_inc(&svcrdma_stat_recv);
-	ib_dma_sync_single_for_cpu(rdma_xprt->sc_pd->device,
+	ib_dma_sync_single_for_cpu(rdma_xprt->sc_cm_id->device,
 				   ctxt->rc_recv_sge.addr, ctxt->rc_byte_len,
 				   DMA_FROM_DEVICE);
 	svc_rdma_build_arg_xdr(rqstp, ctxt);



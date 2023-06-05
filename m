Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8BD86722707
	for <lists+linux-nfs@lfdr.de>; Mon,  5 Jun 2023 15:11:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232828AbjFENLr (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 5 Jun 2023 09:11:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233942AbjFENLl (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 5 Jun 2023 09:11:41 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A049197;
        Mon,  5 Jun 2023 06:11:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9FB52614AD;
        Mon,  5 Jun 2023 13:11:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C127BC433EF;
        Mon,  5 Jun 2023 13:11:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685970692;
        bh=6TSwjCLgzvNx/2L0igWS/k2nUWhVO7QFDvfC1T2mUYE=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=Zw0eEjQk2arI7zRozGL6CEMVloY+iEvSYuwvf2Nx7uwSp4wvrdiH1p9k+B+YA/SFW
         tKoY8YklKy2vYQpasAyJgqP0gsZTm/B9GskvO0afshNkeFvjqXlLTn5yijlubV7etT
         8hOmx7Sgn0yyuLZTdk9Pf+9zJb9LNCXkjgQVXuE12/QnqjNdkS1vqpy0eW7i3jWlBM
         60Lt+R8/DSiOPpXD/lNWykrF2/N+6AxaYyEiWngkLqG+VNWTUpTdMip9Qnh1Sxf6Li
         S6Fulbkty0LN8GPRbzr2BMMcprLFeHZzdBG8sOfJsQcmDJfRHeHkoGxTunEbqXvtTb
         2lf/RFstVZd2g==
Subject: [PATCH v1 2/4] svcrdma: Clean up allocation of svc_rdma_recv_ctxt
From:   Chuck Lever <cel@kernel.org>
To:     linux-nfs@vger.kernel.org
Cc:     Chuck Lever <chuck.lever@oracle.com>, linux-rdma@vger.kernel.org,
        tom@talpey.com
Date:   Mon, 05 Jun 2023 09:11:30 -0400
Message-ID: <168597069088.7694.3096274041268666449.stgit@manet.1015granger.net>
In-Reply-To: <168597050247.7694.8719658227499409307.stgit@manet.1015granger.net>
References: <168597050247.7694.8719658227499409307.stgit@manet.1015granger.net>
User-Agent: StGit/1.5
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Chuck Lever <chuck.lever@oracle.com>

The physical device's favored NUMA node ID is available when
allocating a recv_ctxt. Use that value instead of relying on the
assumption that the memory allocation happens to be running on a
node close to the device.

This clean up eliminates the hack of destroying recv_ctxts that
were not created by the receive CQ thread -- recv_ctxts are now
always allocated on a "good" node.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 include/linux/sunrpc/svc_rdma.h         |    1 -
 net/sunrpc/xprtrdma/svc_rdma_recvfrom.c |   18 +++++++-----------
 2 files changed, 7 insertions(+), 12 deletions(-)

diff --git a/include/linux/sunrpc/svc_rdma.h b/include/linux/sunrpc/svc_rdma.h
index fbc4bd423b35..a0f3ea357977 100644
--- a/include/linux/sunrpc/svc_rdma.h
+++ b/include/linux/sunrpc/svc_rdma.h
@@ -135,7 +135,6 @@ struct svc_rdma_recv_ctxt {
 	struct ib_sge		rc_recv_sge;
 	void			*rc_recv_buf;
 	struct xdr_stream	rc_stream;
-	bool			rc_temp;
 	u32			rc_byte_len;
 	unsigned int		rc_page_count;
 	u32			rc_inv_rkey;
diff --git a/net/sunrpc/xprtrdma/svc_rdma_recvfrom.c b/net/sunrpc/xprtrdma/svc_rdma_recvfrom.c
index a22fe7587fa6..46a719ba4917 100644
--- a/net/sunrpc/xprtrdma/svc_rdma_recvfrom.c
+++ b/net/sunrpc/xprtrdma/svc_rdma_recvfrom.c
@@ -125,14 +125,15 @@ static void svc_rdma_recv_cid_init(struct svcxprt_rdma *rdma,
 static struct svc_rdma_recv_ctxt *
 svc_rdma_recv_ctxt_alloc(struct svcxprt_rdma *rdma)
 {
+	int node = ibdev_to_node(rdma->sc_cm_id->device);
 	struct svc_rdma_recv_ctxt *ctxt;
 	dma_addr_t addr;
 	void *buffer;
 
-	ctxt = kmalloc(sizeof(*ctxt), GFP_KERNEL);
+	ctxt = kmalloc_node(sizeof(*ctxt), GFP_KERNEL, node);
 	if (!ctxt)
 		goto fail0;
-	buffer = kmalloc(rdma->sc_max_req_size, GFP_KERNEL);
+	buffer = kmalloc_node(rdma->sc_max_req_size, GFP_KERNEL, node);
 	if (!buffer)
 		goto fail1;
 	addr = ib_dma_map_single(rdma->sc_pd->device, buffer,
@@ -155,7 +156,6 @@ svc_rdma_recv_ctxt_alloc(struct svcxprt_rdma *rdma)
 	ctxt->rc_recv_sge.length = rdma->sc_max_req_size;
 	ctxt->rc_recv_sge.lkey = rdma->sc_pd->local_dma_lkey;
 	ctxt->rc_recv_buf = buffer;
-	ctxt->rc_temp = false;
 	return ctxt;
 
 fail2:
@@ -232,10 +232,7 @@ void svc_rdma_recv_ctxt_put(struct svcxprt_rdma *rdma,
 	pcl_free(&ctxt->rc_write_pcl);
 	pcl_free(&ctxt->rc_reply_pcl);
 
-	if (!ctxt->rc_temp)
-		llist_add(&ctxt->rc_node, &rdma->sc_recv_ctxts);
-	else
-		svc_rdma_recv_ctxt_destroy(rdma, ctxt);
+	llist_add(&ctxt->rc_node, &rdma->sc_recv_ctxts);
 }
 
 /**
@@ -258,7 +255,7 @@ void svc_rdma_release_ctxt(struct svc_xprt *xprt, void *vctxt)
 }
 
 static bool svc_rdma_refresh_recvs(struct svcxprt_rdma *rdma,
-				   unsigned int wanted, bool temp)
+				   unsigned int wanted)
 {
 	const struct ib_recv_wr *bad_wr = NULL;
 	struct svc_rdma_recv_ctxt *ctxt;
@@ -275,7 +272,6 @@ static bool svc_rdma_refresh_recvs(struct svcxprt_rdma *rdma,
 			break;
 
 		trace_svcrdma_post_recv(ctxt);
-		ctxt->rc_temp = temp;
 		ctxt->rc_recv_wr.next = recv_chain;
 		recv_chain = &ctxt->rc_recv_wr;
 		rdma->sc_pending_recvs++;
@@ -309,7 +305,7 @@ static bool svc_rdma_refresh_recvs(struct svcxprt_rdma *rdma,
  */
 bool svc_rdma_post_recvs(struct svcxprt_rdma *rdma)
 {
-	return svc_rdma_refresh_recvs(rdma, rdma->sc_max_requests, true);
+	return svc_rdma_refresh_recvs(rdma, rdma->sc_max_requests);
 }
 
 /**
@@ -343,7 +339,7 @@ static void svc_rdma_wc_receive(struct ib_cq *cq, struct ib_wc *wc)
 	 * client reconnects.
 	 */
 	if (rdma->sc_pending_recvs < rdma->sc_max_requests)
-		if (!svc_rdma_refresh_recvs(rdma, rdma->sc_recv_batch, false))
+		if (!svc_rdma_refresh_recvs(rdma, rdma->sc_recv_batch))
 			goto dropped;
 
 	/* All wc fields are now known to be valid */



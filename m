Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6B547E9D72
	for <lists+linux-nfs@lfdr.de>; Mon, 13 Nov 2023 14:43:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231400AbjKMNnM (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 13 Nov 2023 08:43:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231428AbjKMNnL (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 13 Nov 2023 08:43:11 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34799D44;
        Mon, 13 Nov 2023 05:43:07 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82CAAC433C9;
        Mon, 13 Nov 2023 13:43:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699882986;
        bh=gP95Sc36yJ8h7pqWWj5NO6WoubKWQ2vmxgltLbLReaI=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=JoNqYE9X8ZIJnF+JKB/mYrzcWHJVi9UcXKayLMgqqZqCcjDUuIWLlDaSazQyJSMap
         MjkuD3ks91F50jHwEPxhC++riPjXOKFhYf738X4vJdgn8K4q47oIuZgpr57rV+tfXk
         zgFyxlFQzE53lndWN+jG9nRDpSn/pt4QhmxlZ+2Z48KpTCkVAmiswRgl2VzKTJlCEX
         XsYrYwf/owFxzXp6PcdcYFgh3ZYk31iYBToZYHp7xLx2RJnB/LODi4IxIaXzIM65U6
         5Q7TKOqaPlMGkdO2jGsF2pjjcPxRFzSq1LU5VANDk2HV949dU49/hG4Ak1DDO7K3np
         F+UXvUUral+PA==
Subject: [PATCH v1 1/7] svcrdma: Eliminate allocation of recv_ctxt objects in
 backchannel
From:   Chuck Lever <cel@kernel.org>
To:     linux-nfs@vger.kernel.org, linux-rdma@vger.kernel.org
Cc:     tom@talpey.com
Date:   Mon, 13 Nov 2023 08:43:05 -0500
Message-ID: <169988298547.6417.6947965014611566854.stgit@bazille.1015granger.net>
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

The svc_rdma_recv_ctxt free list uses a lockless list to avoid the
need for a spin lock in the fast path. llist_del_first(), which is
used by svc_rdma_recv_ctxt_get(), requires serialization, however,
when there are multiple list producers that are unserialized.

I mistakenly thought there was only one caller of
svc_rdma_recv_ctxt_get() (svc_rdma_refresh_recvs()), thus explicit
serialization would not be necessary. But there is another caller:
svc_rdma_bc_sendto(), and these two are not serialized against each
other. I haven't seen ill effects that I could directly ascribe to
a lack of serialization. It's just an observation based on code
audit.

When DMA-mapping before sending a Reply, the passed-in struct
svc_rdma_recv_ctxt is used only for its write and reply PCLs. These
are currently always empty in the backchannel case. So, instead of
passing a full svc_rdma_recv_ctxt object to
svc_rdma_map_reply_msg(), let's pass in just the Write and Reply
PCLs.

This change makes it unnecessary for the backchannel to acquire a
dummy svc_rdma_recv_ctxt object when sending an RPC Call. The need
for svc_rdma_recv_ctxt free list serialization is now completely
avoided.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 include/linux/sunrpc/svc_rdma.h            |    3 ++-
 net/sunrpc/xprtrdma/svc_rdma_backchannel.c |   11 ++++------
 net/sunrpc/xprtrdma/svc_rdma_sendto.c      |   31 +++++++++++++++-------------
 3 files changed, 23 insertions(+), 22 deletions(-)

diff --git a/include/linux/sunrpc/svc_rdma.h b/include/linux/sunrpc/svc_rdma.h
index a5ee0af2a310..4ac32895a058 100644
--- a/include/linux/sunrpc/svc_rdma.h
+++ b/include/linux/sunrpc/svc_rdma.h
@@ -200,7 +200,8 @@ extern int svc_rdma_send(struct svcxprt_rdma *rdma,
 			 struct svc_rdma_send_ctxt *ctxt);
 extern int svc_rdma_map_reply_msg(struct svcxprt_rdma *rdma,
 				  struct svc_rdma_send_ctxt *sctxt,
-				  const struct svc_rdma_recv_ctxt *rctxt,
+				  const struct svc_rdma_pcl *write_pcl,
+				  const struct svc_rdma_pcl *reply_pcl,
 				  const struct xdr_buf *xdr);
 extern void svc_rdma_send_error_msg(struct svcxprt_rdma *rdma,
 				    struct svc_rdma_send_ctxt *sctxt,
diff --git a/net/sunrpc/xprtrdma/svc_rdma_backchannel.c b/net/sunrpc/xprtrdma/svc_rdma_backchannel.c
index 7420a2c990c7..c9be6778643b 100644
--- a/net/sunrpc/xprtrdma/svc_rdma_backchannel.c
+++ b/net/sunrpc/xprtrdma/svc_rdma_backchannel.c
@@ -76,15 +76,12 @@ static int svc_rdma_bc_sendto(struct svcxprt_rdma *rdma,
 			      struct rpc_rqst *rqst,
 			      struct svc_rdma_send_ctxt *sctxt)
 {
-	struct svc_rdma_recv_ctxt *rctxt;
+	struct svc_rdma_pcl empty_pcl;
 	int ret;
 
-	rctxt = svc_rdma_recv_ctxt_get(rdma);
-	if (!rctxt)
-		return -EIO;
-
-	ret = svc_rdma_map_reply_msg(rdma, sctxt, rctxt, &rqst->rq_snd_buf);
-	svc_rdma_recv_ctxt_put(rdma, rctxt);
+	pcl_init(&empty_pcl);
+	ret = svc_rdma_map_reply_msg(rdma, sctxt, &empty_pcl, &empty_pcl,
+				     &rqst->rq_snd_buf);
 	if (ret < 0)
 		return -EIO;
 
diff --git a/net/sunrpc/xprtrdma/svc_rdma_sendto.c b/net/sunrpc/xprtrdma/svc_rdma_sendto.c
index c6644cca52c5..45735f74eb86 100644
--- a/net/sunrpc/xprtrdma/svc_rdma_sendto.c
+++ b/net/sunrpc/xprtrdma/svc_rdma_sendto.c
@@ -653,7 +653,7 @@ static int svc_rdma_xb_count_sges(const struct xdr_buf *xdr,
  * svc_rdma_pull_up_needed - Determine whether to use pull-up
  * @rdma: controlling transport
  * @sctxt: send_ctxt for the Send WR
- * @rctxt: Write and Reply chunks provided by client
+ * @write_pcl: Write chunk list provided by client
  * @xdr: xdr_buf containing RPC message to transmit
  *
  * Returns:
@@ -662,7 +662,7 @@ static int svc_rdma_xb_count_sges(const struct xdr_buf *xdr,
  */
 static bool svc_rdma_pull_up_needed(const struct svcxprt_rdma *rdma,
 				    const struct svc_rdma_send_ctxt *sctxt,
-				    const struct svc_rdma_recv_ctxt *rctxt,
+				    const struct svc_rdma_pcl *write_pcl,
 				    const struct xdr_buf *xdr)
 {
 	/* Resources needed for the transport header */
@@ -672,7 +672,7 @@ static bool svc_rdma_pull_up_needed(const struct svcxprt_rdma *rdma,
 	};
 	int ret;
 
-	ret = pcl_process_nonpayloads(&rctxt->rc_write_pcl, xdr,
+	ret = pcl_process_nonpayloads(write_pcl, xdr,
 				      svc_rdma_xb_count_sges, &args);
 	if (ret < 0)
 		return false;
@@ -728,7 +728,7 @@ static int svc_rdma_xb_linearize(const struct xdr_buf *xdr,
  * svc_rdma_pull_up_reply_msg - Copy Reply into a single buffer
  * @rdma: controlling transport
  * @sctxt: send_ctxt for the Send WR; xprt hdr is already prepared
- * @rctxt: Write and Reply chunks provided by client
+ * @write_pcl: Write chunk list provided by client
  * @xdr: prepared xdr_buf containing RPC message
  *
  * The device is not capable of sending the reply directly.
@@ -743,7 +743,7 @@ static int svc_rdma_xb_linearize(const struct xdr_buf *xdr,
  */
 static int svc_rdma_pull_up_reply_msg(const struct svcxprt_rdma *rdma,
 				      struct svc_rdma_send_ctxt *sctxt,
-				      const struct svc_rdma_recv_ctxt *rctxt,
+				      const struct svc_rdma_pcl *write_pcl,
 				      const struct xdr_buf *xdr)
 {
 	struct svc_rdma_pullup_data args = {
@@ -751,7 +751,7 @@ static int svc_rdma_pull_up_reply_msg(const struct svcxprt_rdma *rdma,
 	};
 	int ret;
 
-	ret = pcl_process_nonpayloads(&rctxt->rc_write_pcl, xdr,
+	ret = pcl_process_nonpayloads(write_pcl, xdr,
 				      svc_rdma_xb_linearize, &args);
 	if (ret < 0)
 		return ret;
@@ -764,7 +764,8 @@ static int svc_rdma_pull_up_reply_msg(const struct svcxprt_rdma *rdma,
 /* svc_rdma_map_reply_msg - DMA map the buffer holding RPC message
  * @rdma: controlling transport
  * @sctxt: send_ctxt for the Send WR
- * @rctxt: Write and Reply chunks provided by client
+ * @write_pcl: Write chunk list provided by client
+ * @reply_pcl: Reply chunk provided by client
  * @xdr: prepared xdr_buf containing RPC message
  *
  * Returns:
@@ -776,7 +777,8 @@ static int svc_rdma_pull_up_reply_msg(const struct svcxprt_rdma *rdma,
  */
 int svc_rdma_map_reply_msg(struct svcxprt_rdma *rdma,
 			   struct svc_rdma_send_ctxt *sctxt,
-			   const struct svc_rdma_recv_ctxt *rctxt,
+			   const struct svc_rdma_pcl *write_pcl,
+			   const struct svc_rdma_pcl *reply_pcl,
 			   const struct xdr_buf *xdr)
 {
 	struct svc_rdma_map_data args = {
@@ -789,18 +791,18 @@ int svc_rdma_map_reply_msg(struct svcxprt_rdma *rdma,
 	sctxt->sc_sges[0].length = sctxt->sc_hdrbuf.len;
 
 	/* If there is a Reply chunk, nothing follows the transport
-	 * header, and we're done here.
+	 * header, so there is nothing to map.
 	 */
-	if (!pcl_is_empty(&rctxt->rc_reply_pcl))
+	if (!pcl_is_empty(reply_pcl))
 		return 0;
 
 	/* For pull-up, svc_rdma_send() will sync the transport header.
 	 * No additional DMA mapping is necessary.
 	 */
-	if (svc_rdma_pull_up_needed(rdma, sctxt, rctxt, xdr))
-		return svc_rdma_pull_up_reply_msg(rdma, sctxt, rctxt, xdr);
+	if (svc_rdma_pull_up_needed(rdma, sctxt, write_pcl, xdr))
+		return svc_rdma_pull_up_reply_msg(rdma, sctxt, write_pcl, xdr);
 
-	return pcl_process_nonpayloads(&rctxt->rc_write_pcl, xdr,
+	return pcl_process_nonpayloads(write_pcl, xdr,
 				       svc_rdma_xb_dma_map, &args);
 }
 
@@ -848,7 +850,8 @@ static int svc_rdma_send_reply_msg(struct svcxprt_rdma *rdma,
 {
 	int ret;
 
-	ret = svc_rdma_map_reply_msg(rdma, sctxt, rctxt, &rqstp->rq_res);
+	ret = svc_rdma_map_reply_msg(rdma, sctxt, &rctxt->rc_write_pcl,
+				     &rctxt->rc_reply_pcl, &rqstp->rq_res);
 	if (ret < 0)
 		return ret;
 



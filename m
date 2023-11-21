Return-Path: <linux-nfs+bounces-12-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D3117F33FD
	for <lists+linux-nfs@lfdr.de>; Tue, 21 Nov 2023 17:40:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8FAB81C21C68
	for <lists+linux-nfs@lfdr.de>; Tue, 21 Nov 2023 16:40:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9BAE53813;
	Tue, 21 Nov 2023 16:40:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LYbiUqgp"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D89D524C3;
	Tue, 21 Nov 2023 16:40:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BCDC8C433C8;
	Tue, 21 Nov 2023 16:40:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700584815;
	bh=gP95Sc36yJ8h7pqWWj5NO6WoubKWQ2vmxgltLbLReaI=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=LYbiUqgpso/5kmAF68ShtQDFmGyJtimri5KjFrgXYcH+NkvDjfvepWp968oMC4svB
	 itbBdDYBcjif0ylS0NxnCF71ceMYibXK2zzNYaGpXYhI9PEWk2T8K9RpoSEGRGJb79
	 71/FyfdnoTVI30fZhhTdpAOPl/YX0SuCrqE7QtsdD4994eYoEaAOZ4QuhW1f+H/I0k
	 dBINkG6ZttNeHuSqHmlKfOHQtqxx45m5jmdJUhsjAHVq6uje8HND67Dq6xfuGrw/Bw
	 v290ZbSGQB7mvntHL1wgMZLIlmDEcI7m8PNudIJvUurKXIG5uB3labWWl0H/MnptYh
	 Kg1jPI+4Qbm9A==
Subject: [PATCH v2 1/6] svcrdma: Eliminate allocation of recv_ctxt objects in
 backchannel
From: Chuck Lever <cel@kernel.org>
To: linux-nfs@vger.kernel.org, linux-rdma@vger.kernel.org
Cc: Chuck Lever <chuck.lever@oracle.com>, tom@talpey.com
Date: Tue, 21 Nov 2023 11:40:13 -0500
Message-ID: 
 <170058481371.4504.14920658261286422958.stgit@bazille.1015granger.net>
In-Reply-To: 
 <170058462629.4504.17663192195815644972.stgit@bazille.1015granger.net>
References: 
 <170058462629.4504.17663192195815644972.stgit@bazille.1015granger.net>
User-Agent: StGit/1.5
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

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
 




Return-Path: <linux-nfs+bounces-287-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 44C838037D3
	for <lists+linux-nfs@lfdr.de>; Mon,  4 Dec 2023 15:57:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F3FEA2811B7
	for <lists+linux-nfs@lfdr.de>; Mon,  4 Dec 2023 14:57:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2E6928E07;
	Mon,  4 Dec 2023 14:57:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ddFK3h9J"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D235928DDB;
	Mon,  4 Dec 2023 14:57:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A87CC433C7;
	Mon,  4 Dec 2023 14:57:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701701856;
	bh=ia7c8/XwFMAy4mWmZtWGCaZtfQ8Fp86zYAXrXvgeZYI=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=ddFK3h9JTyqD7vdPDZUR/LQ3HiOZQgSs6lbRqWhAFy8zJIjTX2lB5Gkd3CwRlkxlR
	 vSxxZuibY0Lp3T3Kivvriu4HO4NtjwrrghduQ89x46A9hACkVlgee4/4/Ntt4VfVZP
	 fo1y4yUn2jjrNQ2q0VuRzzw6/RRhkxiQGGQA3MSbutC487AYr7tyqJRkDPO0dbRSMW
	 K9MZewbADVFK5q8pk+oLAeP2IIh9qdaiZ0MukLanKRAs+F/LIQM0r55MX5SktOfGLc
	 P8hmb6UE1n6bbGwjaQzsofuK2S9EJOFSaut6vbSd5w3N/J7KpIlnw1+FIwJw8+k83a
	 HtGbQT1G59cbQ==
Subject: [PATCH v1 12/21] svcrdma: Update synopsis of
 svc_rdma_build_read_segment()
From: Chuck Lever <cel@kernel.org>
To: linux-nfs@vger.kernel.org, linux-rdma@vger.kernel.org
Cc: tom@talpey.com
Date: Mon, 04 Dec 2023 09:57:35 -0500
Message-ID: 
 <170170185537.54779.16989421003163033569.stgit@bazille.1015granger.net>
In-Reply-To: 
 <170170144201.54779.9877683240030806819.stgit@bazille.1015granger.net>
References: 
 <170170144201.54779.9877683240030806819.stgit@bazille.1015granger.net>
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

Since the RDMA Read I/O state is now contained in the recv_ctxt,
svc_rdma_build_read_segment() can use the recv_ctxt to derive that
information rather than the other way around. This removes one usage
of the ri_readctxt field, enabling its removal in a subsequent
patch.

At the same time, the use of ri_rqst can similarly be replaced with
a passed-in function parameter.

Start with build_read_segment() because it is a common utility
function at the bottom of the Read chunk path.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 include/linux/sunrpc/svc_rdma.h   |    7 +++++++
 net/sunrpc/xprtrdma/svc_rdma_rw.c |   17 +++++++++--------
 2 files changed, 16 insertions(+), 8 deletions(-)

diff --git a/include/linux/sunrpc/svc_rdma.h b/include/linux/sunrpc/svc_rdma.h
index 44a14eaf8c40..f03f9909fb97 100644
--- a/include/linux/sunrpc/svc_rdma.h
+++ b/include/linux/sunrpc/svc_rdma.h
@@ -116,6 +116,13 @@ struct svcxprt_rdma {
 /* sc_flags */
 #define RDMAXPRT_CONN_PENDING	3
 
+static inline struct svcxprt_rdma *svc_rdma_rqst_rdma(struct svc_rqst *rqstp)
+{
+	struct svc_xprt *xprt = rqstp->rq_xprt;
+
+	return container_of(xprt, struct svcxprt_rdma, sc_xprt);
+}
+
 /*
  * Default connection parameters
  */
diff --git a/net/sunrpc/xprtrdma/svc_rdma_rw.c b/net/sunrpc/xprtrdma/svc_rdma_rw.c
index dbced8970779..c2d0e4bb454e 100644
--- a/net/sunrpc/xprtrdma/svc_rdma_rw.c
+++ b/net/sunrpc/xprtrdma/svc_rdma_rw.c
@@ -681,8 +681,8 @@ int svc_rdma_send_reply_chunk(struct svcxprt_rdma *rdma,
 
 /**
  * svc_rdma_build_read_segment - Build RDMA Read WQEs to pull one RDMA segment
- * @rdma: controlling transport
- * @info: context for ongoing I/O
+ * @rqstp: RPC transaction context
+ * @head: context for ongoing I/O
  * @segment: co-ordinates of remote memory to be read
  *
  * Returns:
@@ -691,13 +691,12 @@ int svc_rdma_send_reply_chunk(struct svcxprt_rdma *rdma,
  *   %-ENOMEM: allocating a local resources failed
  *   %-EIO: a DMA mapping error occurred
  */
-static int svc_rdma_build_read_segment(struct svcxprt_rdma *rdma,
-				       struct svc_rdma_read_info *info,
+static int svc_rdma_build_read_segment(struct svc_rqst *rqstp,
+				       struct svc_rdma_recv_ctxt *head,
 				       const struct svc_rdma_segment *segment)
 {
-	struct svc_rdma_recv_ctxt *head = info->ri_readctxt;
+	struct svcxprt_rdma *rdma = svc_rdma_rqst_rdma(rqstp);
 	struct svc_rdma_chunk_ctxt *cc = &head->rc_cc;
-	struct svc_rqst *rqstp = info->ri_rqst;
 	unsigned int sge_no, seg_len, len;
 	struct svc_rdma_rw_ctxt *ctxt;
 	struct scatterlist *sg;
@@ -770,7 +769,8 @@ static int svc_rdma_build_read_chunk(struct svcxprt_rdma *rdma,
 
 	ret = -EINVAL;
 	pcl_for_each_segment(segment, chunk) {
-		ret = svc_rdma_build_read_segment(rdma, info, segment);
+		ret = svc_rdma_build_read_segment(info->ri_rqst,
+						  info->ri_readctxt, segment);
 		if (ret < 0)
 			break;
 		head->rc_readbytes += segment->rs_length;
@@ -989,7 +989,8 @@ static int svc_rdma_read_chunk_range(struct svcxprt_rdma *rdma,
 		dummy.rs_length = min_t(u32, length, segment->rs_length) - offset;
 		dummy.rs_offset = segment->rs_offset + offset;
 
-		ret = svc_rdma_build_read_segment(rdma, info, &dummy);
+		ret = svc_rdma_build_read_segment(info->ri_rqst,
+						  info->ri_readctxt, &dummy);
 		if (ret < 0)
 			break;
 




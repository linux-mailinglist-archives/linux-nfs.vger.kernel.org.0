Return-Path: <linux-nfs+bounces-295-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 41F578037E8
	for <lists+linux-nfs@lfdr.de>; Mon,  4 Dec 2023 15:58:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 72D721C20A37
	for <lists+linux-nfs@lfdr.de>; Mon,  4 Dec 2023 14:58:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DB7728E1F;
	Mon,  4 Dec 2023 14:58:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Nsu5i2Oi"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E38728DD7;
	Mon,  4 Dec 2023 14:58:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB254C433C8;
	Mon,  4 Dec 2023 14:58:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701701908;
	bh=2L76mplY80DLWCf4bPGxzP+lyPyCrwDI53bdxXSivOg=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=Nsu5i2Oisx56RJpHvSGUtcDywWJMAAeyeOCwJR3NhXl/O0JeiDUtme4qlOSienMU5
	 vkGpgyWuBh0RMpW0/8KTsIe24lUqtDs0afpNEhItl3bk6Ra7BQm9LOj7Pu4gn3Z6QF
	 uPdQPh3Myn+CaEqEC7H/XS2kqnIraXyKURDboJj4sK63NzkR3oDq+yBbcyiP31yWLv
	 FtiHzdv2ASiLzeqvIKTGJcqoUunQOCYzNLT9Y8PBremnHJF0UZ454+mXt68a7HAjT3
	 gXWTYqO86pUIhMfUDi2EGNIdNZn8y6DcOz0O1gT/XWKs+T5uT6ThY/80ORu8f4L2+t
	 LDECf7fPtRTqg==
Subject: [PATCH v1 20/21] svcrdma: Remove struct svc_rdma_read_info
From: Chuck Lever <cel@kernel.org>
To: linux-nfs@vger.kernel.org, linux-rdma@vger.kernel.org
Cc: tom@talpey.com
Date: Mon, 04 Dec 2023 09:58:26 -0500
Message-ID: 
 <170170190672.54779.14081619193481067719.stgit@bazille.1015granger.net>
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

The remaining fields of struct svc_rdma_read_info are no longer
referenced.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 net/sunrpc/xprtrdma/svc_rdma_rw.c |   29 -----------------------------
 1 file changed, 29 deletions(-)

diff --git a/net/sunrpc/xprtrdma/svc_rdma_rw.c b/net/sunrpc/xprtrdma/svc_rdma_rw.c
index a3003c2dc0a2..0ccb21f1089e 100644
--- a/net/sunrpc/xprtrdma/svc_rdma_rw.c
+++ b/net/sunrpc/xprtrdma/svc_rdma_rw.c
@@ -287,28 +287,6 @@ static void svc_rdma_write_done(struct ib_cq *cq, struct ib_wc *wc)
 	svc_rdma_write_info_free(info);
 }
 
-/* State for pulling a Read chunk.
- */
-struct svc_rdma_read_info {
-	struct svc_rqst			*ri_rqst;
-	struct svc_rdma_recv_ctxt	*ri_readctxt;
-};
-
-static struct svc_rdma_read_info *
-svc_rdma_read_info_alloc(struct svcxprt_rdma *rdma)
-{
-	struct svc_rdma_read_info *info;
-
-	return kmalloc_node(sizeof(*info), GFP_KERNEL,
-			    ibdev_to_node(rdma->sc_cm_id->device));
-}
-
-static void svc_rdma_read_info_free(struct svcxprt_rdma *rdma,
-				    struct svc_rdma_read_info *info)
-{
-	kfree(info);
-}
-
 /**
  * svc_rdma_wc_read_done - Handle completion of an RDMA Read ctx
  * @cq: controlling Completion Queue
@@ -1121,14 +1099,8 @@ int svc_rdma_process_read_list(struct svcxprt_rdma *rdma,
 			       struct svc_rdma_recv_ctxt *head)
 {
 	struct svc_rdma_chunk_ctxt *cc = &head->rc_cc;
-	struct svc_rdma_read_info *info;
 	int ret;
 
-	info = svc_rdma_read_info_alloc(rdma);
-	if (!info)
-		return -ENOMEM;
-	info->ri_rqst = rqstp;
-	info->ri_readctxt = head;
 	svc_rdma_cc_init(rdma, cc);
 	cc->cc_cqe.done = svc_rdma_wc_read_done;
 	head->rc_pageoff = 0;
@@ -1165,6 +1137,5 @@ int svc_rdma_process_read_list(struct svcxprt_rdma *rdma,
 
 out_err:
 	svc_rdma_cc_release(rdma, cc, DMA_FROM_DEVICE);
-	svc_rdma_read_info_free(rdma, info);
 	return ret;
 }




Return-Path: <linux-nfs+bounces-11243-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A37CFA992A5
	for <lists+linux-nfs@lfdr.de>; Wed, 23 Apr 2025 17:47:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6D3B01BA06FC
	for <lists+linux-nfs@lfdr.de>; Wed, 23 Apr 2025 15:32:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 717A5288CAD;
	Wed, 23 Apr 2025 15:21:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EwE1PZID"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D7C72857FD
	for <linux-nfs@vger.kernel.org>; Wed, 23 Apr 2025 15:21:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745421688; cv=none; b=SGiuqYn9nKpgIF2/nY1E4U81xzmC2HEZsA5UY0RS+R5wv1lmZ/yCtZZAZoCpmmdzrcwOt0OPvFaTBIqgeBsZ9RB7iFimF2BZSg4l5paU/MfMSNJWz/sD6/wsgpRSF2MJXAidGOyqC+/14uJYRfmKZIGmn8bEoetMVTrNCyvyU6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745421688; c=relaxed/simple;
	bh=T4zwhb8s1Gh6sSl1ewC9XNq+lNCNMEa/AoUsRYEhkL4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gdXWuENY9SWUXrlMdPIPTBeu+OldOnZd5h61kezVuALXxuoNsXl33LxI7SkejDk2LLFd/CJUQHqtVKKJEgPUZ0g/zhryw2AQp/EYYaxImPQCrL4ILpCA/OvybHm3VHTi5oHOpvWMPueP24mXfLMiooiRkPW9x0GmnXyXXueOelA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EwE1PZID; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D759C4CEE2;
	Wed, 23 Apr 2025 15:21:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745421687;
	bh=T4zwhb8s1Gh6sSl1ewC9XNq+lNCNMEa/AoUsRYEhkL4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=EwE1PZIDdx/+GKsZO8iYZTYJZDWcTyroOUEQ0Sumd+uWlJGA1MgqvRTfPTxHFtD/n
	 dNXRlr69jPlDUXRTvzj+C4tQ2+nEJC7csMwXC+Z0xFOAwAr2tYsaX6V6fR2y16PYNf
	 liJkxCfD8bP86E4xYsFo/BctnzJ2yT5x2QdSDUVu/13YIu2ZNaxB25UKAWvcapUyI8
	 xrgd8q6Cs70tpFOFFbBD6hz0eI35lTBlMp9Z85xtrKe9y3WogwEmY1vyw38Ci6nWcD
	 n5xi1hjXICXjKFx1t9ywdxL2FicZ4kwzoC4zdoOVRGDR5W5hYwoP7++wbmxyGSuuZU
	 eHLBKGfQSPqPA==
From: cel@kernel.org
To: NeilBrown <neil@brown.name>,
	Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>
Cc: <linux-nfs@vger.kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>
Subject: [PATCH v3 08/11] svcrdma: Adjust the number of entries in svc_rdma_recv_ctxt::rc_pages
Date: Wed, 23 Apr 2025 11:21:14 -0400
Message-ID: <20250423152117.5418-9-cel@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250423152117.5418-1-cel@kernel.org>
References: <20250423152117.5418-1-cel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chuck Lever <chuck.lever@oracle.com>

Allow allocation of more entries in the rc_pages[] array when the
maximum size of an RPC message is increased.

Reviewed-by: Jeff Layton <jlayton@kernel.org>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 include/linux/sunrpc/svc_rdma.h         | 3 ++-
 net/sunrpc/xprtrdma/svc_rdma_recvfrom.c | 8 ++++++--
 2 files changed, 8 insertions(+), 3 deletions(-)

diff --git a/include/linux/sunrpc/svc_rdma.h b/include/linux/sunrpc/svc_rdma.h
index 619fc0bd837a..1016f2feddc4 100644
--- a/include/linux/sunrpc/svc_rdma.h
+++ b/include/linux/sunrpc/svc_rdma.h
@@ -202,7 +202,8 @@ struct svc_rdma_recv_ctxt {
 	struct svc_rdma_pcl	rc_reply_pcl;
 
 	unsigned int		rc_page_count;
-	struct page		*rc_pages[RPCSVC_MAXPAGES];
+	unsigned long		rc_maxpages;
+	struct page		*rc_pages[] __counted_by(rc_maxpages);
 };
 
 /*
diff --git a/net/sunrpc/xprtrdma/svc_rdma_recvfrom.c b/net/sunrpc/xprtrdma/svc_rdma_recvfrom.c
index 292022f0976e..e7e4a39ca6c6 100644
--- a/net/sunrpc/xprtrdma/svc_rdma_recvfrom.c
+++ b/net/sunrpc/xprtrdma/svc_rdma_recvfrom.c
@@ -120,12 +120,16 @@ svc_rdma_recv_ctxt_alloc(struct svcxprt_rdma *rdma)
 {
 	int node = ibdev_to_node(rdma->sc_cm_id->device);
 	struct svc_rdma_recv_ctxt *ctxt;
+	unsigned long pages;
 	dma_addr_t addr;
 	void *buffer;
 
-	ctxt = kzalloc_node(sizeof(*ctxt), GFP_KERNEL, node);
+	pages = svc_serv_maxpages(rdma->sc_xprt.xpt_server);
+	ctxt = kzalloc_node(struct_size(ctxt, rc_pages, pages),
+			    GFP_KERNEL, node);
 	if (!ctxt)
 		goto fail0;
+	ctxt->rc_maxpages = pages;
 	buffer = kmalloc_node(rdma->sc_max_req_size, GFP_KERNEL, node);
 	if (!buffer)
 		goto fail1;
@@ -497,7 +501,7 @@ static bool xdr_check_write_chunk(struct svc_rdma_recv_ctxt *rctxt)
 	 * a computation, perform a simple range check. This is an
 	 * arbitrary but sensible limit (ie, not architectural).
 	 */
-	if (unlikely(segcount > RPCSVC_MAXPAGES))
+	if (unlikely(segcount > rctxt->rc_maxpages))
 		return false;
 
 	p = xdr_inline_decode(&rctxt->rc_stream,
-- 
2.49.0



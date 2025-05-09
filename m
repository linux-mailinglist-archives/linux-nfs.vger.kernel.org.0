Return-Path: <linux-nfs+bounces-11636-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C93DAB1D18
	for <lists+linux-nfs@lfdr.de>; Fri,  9 May 2025 21:05:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A5A524C1AD9
	for <lists+linux-nfs@lfdr.de>; Fri,  9 May 2025 19:04:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 493D1244684;
	Fri,  9 May 2025 19:04:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E0XC8Lp1"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 221472417EF;
	Fri,  9 May 2025 19:04:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746817449; cv=none; b=ASsqQ11wWu0/zng+6qUzM1H9s3CnRglf8fAYZ4vu/8QheYd+e+4Y4Z5LVe29WgY2pvhiERSriCqNlXLAGQyRFc4mGYGpY+yMwtv14PfmASOJ0tTYC1gInbp/KnYVrCzmKcEX9zrDP3iPOuxftyggaia0upv4KOKhE+Bdo8NuaX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746817449; c=relaxed/simple;
	bh=YKGKC7JXDv1Dk3EoPPKhIm+toh0199UMijj8dd4O5BM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qakak3FNDkiK1e1APm2ITLts2N86p0aGeSlgy5xIUMJi1LMyn+NTPZxWn6dFImbhZAtx9q3b9V4mUJv7xBMHQ4tLrU3ZnK3I19aKq6X49O0UxXAv7WiftopMJQmUAW/0BYAIQMOtCYbcFOPlWKBr/Q40AX8AWocVJvJehaSUHc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E0XC8Lp1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0FE7AC4CEF0;
	Fri,  9 May 2025 19:04:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746817449;
	bh=YKGKC7JXDv1Dk3EoPPKhIm+toh0199UMijj8dd4O5BM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=E0XC8Lp1HLZUMySjjU0p8mBqEpWpTXRrU/VK+zYiKatWlOjAHdGBHIe/sued1Skok
	 Jc8qD6IDbv5Q2ZIarkq76DQb4Wdph8GvRadNrNYz4yUzxWHuryGm8q2HemcaDkR/SN
	 mHW1yVoDt2IiFewRvx8VF+9LjWlVbqYh5AeEHnonvthnEtIMHt7++RsIiTGXAStbER
	 ovQGZev8BddVF4EwZh3Zm/I931Qaf9Z8eNIXrks/oUDxGrWV0StTFaJS9YP35bUqhL
	 y0VPJ9jAaeaJtCCCtAqizdGWhA30CcRTqGZh5YphV5+idGvK1Ij2z5i5R8Cv2uLizS
	 o65vGDf/rALhA==
From: cel@kernel.org
To: NeilBrown <neil@brown.name>,
	Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>
Cc: <linux-nfs@vger.kernel.org>,
	<linux-rdma@vger.kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>
Subject: [PATCH v5 14/19] svcrdma: Adjust the number of entries in svc_rdma_send_ctxt::sc_pages
Date: Fri,  9 May 2025 15:03:48 -0400
Message-ID: <20250509190354.5393-15-cel@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250509190354.5393-1-cel@kernel.org>
References: <20250509190354.5393-1-cel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chuck Lever <chuck.lever@oracle.com>

Allow allocation of more entries in the sc_pages[] array when the
maximum size of an RPC message is increased.

Reviewed-by: Jeff Layton <jlayton@kernel.org>
Reviewed-by: NeilBrown <neil@brown.name>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 include/linux/sunrpc/svc_rdma.h       |  3 ++-
 net/sunrpc/xprtrdma/svc_rdma_sendto.c | 16 +++++++++++++---
 2 files changed, 15 insertions(+), 4 deletions(-)

diff --git a/include/linux/sunrpc/svc_rdma.h b/include/linux/sunrpc/svc_rdma.h
index 1016f2feddc4..22704c2e5b9b 100644
--- a/include/linux/sunrpc/svc_rdma.h
+++ b/include/linux/sunrpc/svc_rdma.h
@@ -245,7 +245,8 @@ struct svc_rdma_send_ctxt {
 	void			*sc_xprt_buf;
 	int			sc_page_count;
 	int			sc_cur_sge_no;
-	struct page		*sc_pages[RPCSVC_MAXPAGES];
+	unsigned long		sc_maxpages;
+	struct page		**sc_pages;
 	struct ib_sge		sc_sges[];
 };
 
diff --git a/net/sunrpc/xprtrdma/svc_rdma_sendto.c b/net/sunrpc/xprtrdma/svc_rdma_sendto.c
index 96154a2367a1..914cd263c2f1 100644
--- a/net/sunrpc/xprtrdma/svc_rdma_sendto.c
+++ b/net/sunrpc/xprtrdma/svc_rdma_sendto.c
@@ -118,6 +118,7 @@ svc_rdma_send_ctxt_alloc(struct svcxprt_rdma *rdma)
 {
 	int node = ibdev_to_node(rdma->sc_cm_id->device);
 	struct svc_rdma_send_ctxt *ctxt;
+	unsigned long pages;
 	dma_addr_t addr;
 	void *buffer;
 	int i;
@@ -126,13 +127,19 @@ svc_rdma_send_ctxt_alloc(struct svcxprt_rdma *rdma)
 			    GFP_KERNEL, node);
 	if (!ctxt)
 		goto fail0;
+	pages = svc_serv_maxpages(rdma->sc_xprt.xpt_server);
+	ctxt->sc_pages = kcalloc_node(pages, sizeof(struct page *),
+				      GFP_KERNEL, node);
+	if (!ctxt->sc_pages)
+		goto fail1;
+	ctxt->sc_maxpages = pages;
 	buffer = kmalloc_node(rdma->sc_max_req_size, GFP_KERNEL, node);
 	if (!buffer)
-		goto fail1;
+		goto fail2;
 	addr = ib_dma_map_single(rdma->sc_pd->device, buffer,
 				 rdma->sc_max_req_size, DMA_TO_DEVICE);
 	if (ib_dma_mapping_error(rdma->sc_pd->device, addr))
-		goto fail2;
+		goto fail3;
 
 	svc_rdma_send_cid_init(rdma, &ctxt->sc_cid);
 
@@ -151,8 +158,10 @@ svc_rdma_send_ctxt_alloc(struct svcxprt_rdma *rdma)
 		ctxt->sc_sges[i].lkey = rdma->sc_pd->local_dma_lkey;
 	return ctxt;
 
-fail2:
+fail3:
 	kfree(buffer);
+fail2:
+	kfree(ctxt->sc_pages);
 fail1:
 	kfree(ctxt);
 fail0:
@@ -176,6 +185,7 @@ void svc_rdma_send_ctxts_destroy(struct svcxprt_rdma *rdma)
 				    rdma->sc_max_req_size,
 				    DMA_TO_DEVICE);
 		kfree(ctxt->sc_xprt_buf);
+		kfree(ctxt->sc_pages);
 		kfree(ctxt);
 	}
 }
-- 
2.49.0



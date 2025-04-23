Return-Path: <linux-nfs+bounces-11244-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EFC60A99227
	for <lists+linux-nfs@lfdr.de>; Wed, 23 Apr 2025 17:40:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 90EA05A6784
	for <lists+linux-nfs@lfdr.de>; Wed, 23 Apr 2025 15:31:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDD0E2857FD;
	Wed, 23 Apr 2025 15:21:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h9DwHzck"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA1582BE11D
	for <linux-nfs@vger.kernel.org>; Wed, 23 Apr 2025 15:21:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745421688; cv=none; b=ps4Yyxnb2yUeJH+k5NJEOGyFQ+zAKrI/UqYAO2vqPCWabNQgMatgyL07XWHx3SJ9FWkYTDTwfMVO095mR8qru1IS7JGx2H4wBFkakBi8Fqt1bNXs+wvWu8A6zGttJgJd8VIWW37aYbV/8bxGkNDsmRWJXXdXsDZdxYPbK254xW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745421688; c=relaxed/simple;
	bh=sIEp16TybPi+T7fXe/5w3BJ+wmnlibBJ3f7H1rrkcnM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=seugCvvLNDuBE6zy1sC934CtQ0go65GY73A84wrid5Dyfwko4wLnIDu8V58QSXc0lO6Cccd2uAZwtrhj/bgEVi04iXwJdJHDYYOby0414NcTP9CGYcbFsxVqUkVbTrVYpVeW5e7bJM26YawmKkD2QhOf6Pnh1X/XOAyCKyVitQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h9DwHzck; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06142C4CEE3;
	Wed, 23 Apr 2025 15:21:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745421688;
	bh=sIEp16TybPi+T7fXe/5w3BJ+wmnlibBJ3f7H1rrkcnM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=h9DwHzckMd3k5DBCWjW/zDZOBH/8hmtgV5SN9BiZXtLGhdvCrNy76PCOdf00tsrP9
	 5Pq+4uCEpEa9wZSFma/VhFQ5k2fMpHmN10w9xIhGd6pnIv8BTkfrkNN4MzsqWOr0pB
	 85oVJP4M0FHhMFc9AE/I1lsQGkupVKaFweI/08/3tAGkugQBCtWkmS49QOgZgg9LWv
	 HA+XDXeOITCqu4F5onDIS1Y0Vch1ozYia2AmVSDS0pW3tozpHuEACca7/P9+1kUpkt
	 eUJd8L7mmlBGLvLdiP21jF1+GPZtzmbJJIXqMDyaDVfFhrz6slo2mkwBs0juVIRQQU
	 iJlxSwuVkut3Q==
From: cel@kernel.org
To: NeilBrown <neil@brown.name>,
	Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>
Cc: <linux-nfs@vger.kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>
Subject: [PATCH v3 09/11] svcrdma: Adjust the number of entries in svc_rdma_send_ctxt::sc_pages
Date: Wed, 23 Apr 2025 11:21:15 -0400
Message-ID: <20250423152117.5418-10-cel@kernel.org>
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

Allow allocation of more entries in the sc_pages[] array when the
maximum size of an RPC message is increased.

Reviewed-by: Jeff Layton <jlayton@kernel.org>
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



Return-Path: <linux-nfs+bounces-11323-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 03C26A9F9B1
	for <lists+linux-nfs@lfdr.de>; Mon, 28 Apr 2025 21:37:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 96AE11A85DB0
	for <lists+linux-nfs@lfdr.de>; Mon, 28 Apr 2025 19:37:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89E972973CE;
	Mon, 28 Apr 2025 19:37:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cAZGyZxP"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61B7D2973C7;
	Mon, 28 Apr 2025 19:37:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745869035; cv=none; b=iZCy8hieBT2PkEkoF8kQDKcG4TVOASSyRMNWb5lC5gXXaQGIMvWbJOVMI/MMX+oOr3L0nAJ2hhfBVMQNc4hr4sPoE38/9uAuWT6YZZ5EFyZV/OjddoWTJQZCk9ERZPYbznQScZ1432SXF4YnlQj5LN1PyQPu3djOYo4Za2ZZ8Gw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745869035; c=relaxed/simple;
	bh=sIEp16TybPi+T7fXe/5w3BJ+wmnlibBJ3f7H1rrkcnM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=e6P2v49KXIx7IzMN71hrYg7lGCcjxeVCmzY2O7voX6o2HROGjpKzcjUCzP0i/A0cXGPupH4tF+fMsqZ4sk48Bj+vcOzHbXkLiKCIbNIMX1HlDObcVQr+F42iceFH7b5kGMhEVNNnxXNSraWTthNUE//BRS01QiNaGgaV4g2VyQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cAZGyZxP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6FDDDC4CEEE;
	Mon, 28 Apr 2025 19:37:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745869035;
	bh=sIEp16TybPi+T7fXe/5w3BJ+wmnlibBJ3f7H1rrkcnM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=cAZGyZxPmg9rGs/fsfNrJIFtKfv6zWE5OPQtoIKkO6pXqYiJYbdU0Qw3ItPaMtuSJ
	 DwCF8NzvY2gZKf9NVQ6vPzrRAjpqHXOe3RjpKU0Hn36eSD2ZSqMC11JM0NGL6ousyZ
	 1rLN3p0DMfQBiRWMaLbAm6aFKv1JBbNMfuYdzeruI27+w+btjWzVyJRwMjKWDRMm1g
	 p30YVpFXrQ/i2viG0iZd59Ho/SHEbw5E//sS0+BVHZsIVEP/LzQm1bmxPggznI1+Mb
	 cK1nDtY0KYDycTiuboDyeBFgLUdztAbRmM+0NVB3xpIjOxREhE3ej0erIs/WyycS8f
	 Fbyn6kyjLCItg==
From: cel@kernel.org
To: NeilBrown <neil@brown.name>,
	Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>,
	Anna Schumaker <anna@kernel.org>
Cc: <linux-nfs@vger.kernel.org>,
	<linux-rdma@vger.kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>
Subject: [PATCH v4 09/14] svcrdma: Adjust the number of entries in svc_rdma_send_ctxt::sc_pages
Date: Mon, 28 Apr 2025 15:36:57 -0400
Message-ID: <20250428193702.5186-10-cel@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250428193702.5186-1-cel@kernel.org>
References: <20250428193702.5186-1-cel@kernel.org>
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



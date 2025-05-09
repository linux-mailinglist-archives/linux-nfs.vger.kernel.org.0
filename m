Return-Path: <linux-nfs+bounces-11635-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 529F5AB1D0F
	for <lists+linux-nfs@lfdr.de>; Fri,  9 May 2025 21:04:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EBFD4A01925
	for <lists+linux-nfs@lfdr.de>; Fri,  9 May 2025 19:04:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20F05244695;
	Fri,  9 May 2025 19:04:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O2TT1D2G"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECF292417C4;
	Fri,  9 May 2025 19:04:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746817448; cv=none; b=nivRLP37J3391Ym0ikwev1k/RT2QVVDayme8b8szL9UuJ6aXKwM24dIVG6vC8wIOlByGGBnf0qw7IzZKbsCA3iYnflRQfju5KPzsVElSklPE1Kr1Id4wk8S+W4LDGfpD6yVmws+NxW8SZqNoXyXS3nshlE3bU6T+Qcm1IDhYc3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746817448; c=relaxed/simple;
	bh=gRaLpRdAScElEFLMLaM+16b1VGOSS/OsyZkZ0GTBOL0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=g2CdmD3wAiynu1zYT4TiGW/KPtz+9Nm4Y3Jn3r8jnDswSZCrgAo3SrcRJGaBtEEgHpRg/ODbijcoXIZVlgmDzjkouvYjSH9KIO37te2DdsA/Hz2YcxmG21LuCeJ8a3vTO2BODjJjBUP77IHKVaVZga0SfYW6sPfPRRmGkcJJfMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O2TT1D2G; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F287C4CEE4;
	Fri,  9 May 2025 19:04:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746817447;
	bh=gRaLpRdAScElEFLMLaM+16b1VGOSS/OsyZkZ0GTBOL0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=O2TT1D2Gp2dOthU5td6giGFvLQ6F1C2Fn8lcyrlVvCHRZ23QRk5LwYe7Vp9PEpizG
	 LFAByRHydHlQDGA7BTRWlq3vk7KvAr4EtcPQgAhPsLyuGR8M9jViSZueRVkMfGXNKS
	 5fJPinTY35r5C8uQnOJXGSNy4dbENr7bdpDG9sADvz/X+Hi8xlsGBK/tJmzI46ySyC
	 QJiJ6xE9vyeVzaXE7ssX66x2THRbHUQPkKxYVnsqLeHQa6z/ASH1ElrsiFf+hGxUaS
	 46Ypjv7/PJI0NeRa1DdgCE+HEz4Bsi13omL08au8OVzU+gwKXHG5l1oN3ua8n/vVwB
	 PwhOZCTX+Kbpg==
From: cel@kernel.org
To: NeilBrown <neil@brown.name>,
	Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>
Cc: <linux-nfs@vger.kernel.org>,
	<linux-rdma@vger.kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>
Subject: [PATCH v5 13/19] svcrdma: Adjust the number of entries in svc_rdma_recv_ctxt::rc_pages
Date: Fri,  9 May 2025 15:03:47 -0400
Message-ID: <20250509190354.5393-14-cel@kernel.org>
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

Allow allocation of more entries in the rc_pages[] array when the
maximum size of an RPC message is increased.

Reviewed-by: Jeff Layton <jlayton@kernel.org>
Reviewed-by: NeilBrown <neil@brown.name>
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



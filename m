Return-Path: <linux-nfs+bounces-11186-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B500AA944D9
	for <lists+linux-nfs@lfdr.de>; Sat, 19 Apr 2025 19:28:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 816031893CE0
	for <lists+linux-nfs@lfdr.de>; Sat, 19 Apr 2025 17:28:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE2C5153836;
	Sat, 19 Apr 2025 17:28:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qreZeVWj"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA9771DC992
	for <linux-nfs@vger.kernel.org>; Sat, 19 Apr 2025 17:28:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745083708; cv=none; b=qiATfDSqz3qVd9AnPTcJbdh9SvAPTiA7Gz/3+oB74oG1QS3dFMi3RnVv+jPsRA7bUq9/BWUnFmWYJMR6lJZ/1iS9veaAgb5CA+PMYle+hE2yJOrFCajmyzHneHzEuHecvksG156CXiO64GrjCvDKCOnVVutiKSntduSCtHBDq3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745083708; c=relaxed/simple;
	bh=enJKDBS7N5CV3CAIUm0HHYeUGs0DDO7cCwedsIgae7o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZndkPslYJVTwGik0X1Z+NmR8jqS1O4afY0BV8HnPmulkvZ9kMHFgVa8nU2vXsO7tXryCVJU1joa2+DjYp5tep3Kmzk8vYWdyBZZvK2PWAMiWXYXS0+HFaBOHZ+HCWWqtMMjGdcCrS66KpqNHvtBgMahM9tgj/M8lRySyxSPGRrg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qreZeVWj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03C59C4CEEF;
	Sat, 19 Apr 2025 17:28:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745083708;
	bh=enJKDBS7N5CV3CAIUm0HHYeUGs0DDO7cCwedsIgae7o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qreZeVWjcGXfex9FpIWva2sbs+pQZnvaEWFQbYyxfOrw3CvIlIh1VXLJ9yPQHKDX4
	 GjsIdXoAnyaRgaRAkPOukvVRrPOxOemE9e9Nzws0xCsv52zWqGGPGTp0ruvKiN3gbV
	 1RIX81PCFqhOJBA09AQ8Eo5DTO7wZXFCewdratQRHLYD3xVUrqHk3VzSg0BPl6zccf
	 2d/Ig0X/Ryr9O/thUf8GrFyCmNWIJzs2XL03SLCdAkyD70kect+mlKJ/Ehm30n2yBP
	 GsUgKMzmNz5wX52n+pj0d5g/UGHw192PgaJeXlvztoqTrC7sWNcP8qP8qYTuFHFdTN
	 Xx53RcnwPHkHw==
From: cel@kernel.org
To: NeilBrown <neil@brown.name>,
	Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>
Cc: <linux-nfs@vger.kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>
Subject: [PATCH v2 08/10] svcrdma: Adjust the number of entries in svc_rdma_recv_ctxt::rc_pages
Date: Sat, 19 Apr 2025 13:28:16 -0400
Message-ID: <20250419172818.6945-9-cel@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250419172818.6945-1-cel@kernel.org>
References: <20250419172818.6945-1-cel@kernel.org>
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



Return-Path: <linux-nfs+bounces-11187-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id ED277A944DA
	for <lists+linux-nfs@lfdr.de>; Sat, 19 Apr 2025 19:28:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 23E49176D15
	for <lists+linux-nfs@lfdr.de>; Sat, 19 Apr 2025 17:28:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D301D1DE2C4;
	Sat, 19 Apr 2025 17:28:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tIb21S7z"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF1F91DC992
	for <linux-nfs@vger.kernel.org>; Sat, 19 Apr 2025 17:28:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745083709; cv=none; b=V9u+A4XMdWPF78LsgeY5v9Ypy74A8sld7osDOAy5veLqbl+CRayMRSQZEzYdEWL9Ql9Yk+oRnAT1OnyRmSFDOaQBs9HHxfuioYt+DY64WehpcPXYjqwNwSPZOmK2tX4jAbgy98LgQ/MGRlIDyMzbgj/GpjNuvemTbipdRAl5n5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745083709; c=relaxed/simple;
	bh=KAiT/Ic7fQO9UlQZ73W8ATtWXi1hNAo0BKvWRhRmWGg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ftU1EoHTZZ/NLQoC/buMZKxEdMslRJNBoLiYlsQNUg/FmcnNNJB4Ia4/4ARiYQw98grYTxoBs2W1Ods2z1+Lw5rdi9icS3uAHhKx0RQUmsp02c50qJAM8PLc9f1aSumjvCUAp0QV89Tjmh5wC+EX7pHimsTfO7yQkcUguICo70Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tIb21S7z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD0ECC4CEEE;
	Sat, 19 Apr 2025 17:28:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745083709;
	bh=KAiT/Ic7fQO9UlQZ73W8ATtWXi1hNAo0BKvWRhRmWGg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=tIb21S7zjdKvi60V5hfaNKolpIBh9f7zQZLuSk2mDaBPGzR6HsxAVmxWNw9vMQJ0p
	 DS8kHUWiQt5NlvLIXAh4yIK+BjjhTOTdCkVjA8VCWLnL0SDTPVEzLXQpX5WD1hT6yv
	 ppIWeMCn3hVMsi6UfO71Dnw8Dr1ujkP7kZTTf9C1k3ldIGs7J3P+SOAR75fEqHCbOP
	 KKpdgW/+ec3nSQBix5aMlZLbiKx6MVtV5jyy/ZGX5MkzjQdmbPar1uNQnC0mm2LyCV
	 z/lBxaBI1qRA/goo5HhoXvLWYszMo+CeN9cvH8nO9vgI9A1BWq3zE7/AzXwh/+R2iP
	 BB8oDYkf+DtqA==
From: cel@kernel.org
To: NeilBrown <neil@brown.name>,
	Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>
Cc: <linux-nfs@vger.kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>
Subject: [PATCH v2 09/10] svcrdma: Adjust the number of entries in svc_rdma_send_ctxt::sc_pages
Date: Sat, 19 Apr 2025 13:28:17 -0400
Message-ID: <20250419172818.6945-10-cel@kernel.org>
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

Allow allocation of more entries in the sc_pages[] array when the
maximum size of an RPC message is increased.

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



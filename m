Return-Path: <linux-nfs+bounces-283-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 93F948037CB
	for <lists+linux-nfs@lfdr.de>; Mon,  4 Dec 2023 15:57:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C4EA51C20AEE
	for <lists+linux-nfs@lfdr.de>; Mon,  4 Dec 2023 14:57:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F64028DD8;
	Mon,  4 Dec 2023 14:57:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tX54iEa7"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FCEA28DB6;
	Mon,  4 Dec 2023 14:57:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B230EC433C7;
	Mon,  4 Dec 2023 14:57:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701701831;
	bh=wQ6NrISmagwxT6V5dl9+HXSmlG7NNLKGd1IIYiRUCL0=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=tX54iEa7E2eTwKGDmmrhyL7tGqXJsiIkewT2lAfLlXxLIpQgw2Lgaa8199g1nj2v1
	 JNZ1HjnYCo98tehVAisUDIshIhaJVgvUslrRS9EZOJyD5+m0b875Ya4OtYbPCvxzNQ
	 JvRBnHd0Ik2BooG46GoT1cfCQsKXLZ/jfymB1Y2aKX4PVM2farupJBjkCau60s3Jiu
	 7256pe9LDAcD5YLLm8V716Cz6I355sQjI8dhaZzLlQilceOZWplyCBiDuEe22SPH50
	 t4T4inys8RTF6pESwoXXSD7XaqkaeFCVQMRfrH1s9rYbN/asW8EVAOBWt8edB+SoX/
	 DTr0oUSPweaRQ==
Subject: [PATCH v1 08/21] svcrdma: Move struct svc_rdma_chunk_ctxt to
 svc_rdma.h
From: Chuck Lever <cel@kernel.org>
To: linux-nfs@vger.kernel.org, linux-rdma@vger.kernel.org
Cc: tom@talpey.com
Date: Mon, 04 Dec 2023 09:57:09 -0500
Message-ID: 
 <170170182981.54779.5136505018669156060.stgit@bazille.1015granger.net>
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

Prepare for nestling these into the send and recv ctxts so they
no longer have to be allocated dynamically.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 include/linux/sunrpc/svc_rdma.h   |   15 +++++++++++++++
 net/sunrpc/xprtrdma/svc_rdma_rw.c |   18 ------------------
 2 files changed, 15 insertions(+), 18 deletions(-)

diff --git a/include/linux/sunrpc/svc_rdma.h b/include/linux/sunrpc/svc_rdma.h
index ab250017b99f..50c4f18a9b7f 100644
--- a/include/linux/sunrpc/svc_rdma.h
+++ b/include/linux/sunrpc/svc_rdma.h
@@ -127,6 +127,21 @@ enum {
 
 #define RPCSVC_MAXPAYLOAD_RDMA	RPCSVC_MAXPAYLOAD
 
+/*
+ * A chunk context tracks all I/O for moving one Read or Write
+ * chunk. This is a set of rdma_rw's that handle data movement
+ * for all segments of one chunk.
+ */
+struct svc_rdma_chunk_ctxt {
+	struct rpc_rdma_cid	cc_cid;
+	struct ib_cqe		cc_cqe;
+	struct list_head	cc_rwctxts;
+	ktime_t			cc_posttime;
+	int			cc_sqecount;
+	enum ib_wc_status	cc_status;
+	struct completion	cc_done;
+};
+
 struct svc_rdma_recv_ctxt {
 	struct llist_node	rc_node;
 	struct list_head	rc_list;
diff --git a/net/sunrpc/xprtrdma/svc_rdma_rw.c b/net/sunrpc/xprtrdma/svc_rdma_rw.c
index cfa5973c9277..1de56e9fea91 100644
--- a/net/sunrpc/xprtrdma/svc_rdma_rw.c
+++ b/net/sunrpc/xprtrdma/svc_rdma_rw.c
@@ -146,24 +146,6 @@ static int svc_rdma_rw_ctx_init(struct svcxprt_rdma *rdma,
 	return ret;
 }
 
-/* A chunk context tracks all I/O for moving one Read or Write
- * chunk. This is a set of rdma_rw's that handle data movement
- * for all segments of one chunk.
- *
- * These are small, acquired with a single allocator call, and
- * no more than one is needed per chunk. They are allocated on
- * demand, and not cached.
- */
-struct svc_rdma_chunk_ctxt {
-	struct rpc_rdma_cid	cc_cid;
-	struct ib_cqe		cc_cqe;
-	struct list_head	cc_rwctxts;
-	ktime_t			cc_posttime;
-	int			cc_sqecount;
-	enum ib_wc_status	cc_status;
-	struct completion	cc_done;
-};
-
 static void svc_rdma_cc_cid_init(struct svcxprt_rdma *rdma,
 				 struct rpc_rdma_cid *cid)
 {




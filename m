Return-Path: <linux-nfs+bounces-484-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 359C380CF63
	for <lists+linux-nfs@lfdr.de>; Mon, 11 Dec 2023 16:24:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 64CF21C21290
	for <lists+linux-nfs@lfdr.de>; Mon, 11 Dec 2023 15:24:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08E594AF7B;
	Mon, 11 Dec 2023 15:24:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FSiLGxrK"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF2A33B184;
	Mon, 11 Dec 2023 15:24:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22501C433C7;
	Mon, 11 Dec 2023 15:24:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702308256;
	bh=Azc8E1z0nSScQA4Ka3Ad03FQroG23ikvDXFi+W7NPPc=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=FSiLGxrK8TSlNmNwfeivh5gcZ+ZS811VsnkjTRL5vhKn1q/I8aCJDD3f/H+jkqPSc
	 HgMngoR0EwdeeHe6A54iHF+rX6UkwQ0/TmhJwWtaK9EhwoA5hEP9/r3/y0Eq5O2Dcq
	 KCIeiEFjXkYrZ1qKlSM0uSMiJVlEQ+pA1WXpLsIHUnf4q8p0WPszTmKNz5CnN7J9Iu
	 7jCIfgqZcnzHZUXZx5hcgLUtr+qsnHKP60WbuZM1JovIfLCl2i86W5pcoLxR7s9V5a
	 aWN2g/RfXRnLvzNFN2HaBFnqy0LKpDPioqj+PGvpj/PunfhbjhBPzSYifvaQPVWqnZ
	 wlKpCKUvGc5Vw==
Subject: [PATCH v1 2/8] svcrdma: Optimize svc_rdma_cc_init()
From: Chuck Lever <cel@kernel.org>
To: linux-nfs@vger.kernel.org, linux-rdma@vger.kernel.org
Cc: tom@talpey.com
Date: Mon, 11 Dec 2023 10:24:15 -0500
Message-ID: 
 <170230825516.90242.7046834370878992757.stgit@bazille.1015granger.net>
In-Reply-To: 
 <170230788373.90242.9421368360904462120.stgit@bazille.1015granger.net>
References: 
 <170230788373.90242.9421368360904462120.stgit@bazille.1015granger.net>
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

The atomic_inc_return() in svc_rdma_send_cid_init() is expensive.

Some svc_rdma_chunk_ctxt's now reside in long-lived container
structures. They don't need a fresh completion ID for every I/O
operation.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 net/sunrpc/xprtrdma/svc_rdma_recvfrom.c |    2 +-
 net/sunrpc/xprtrdma/svc_rdma_rw.c       |    9 +++++----
 net/sunrpc/xprtrdma/svc_rdma_sendto.c   |    2 +-
 3 files changed, 7 insertions(+), 6 deletions(-)

diff --git a/net/sunrpc/xprtrdma/svc_rdma_recvfrom.c b/net/sunrpc/xprtrdma/svc_rdma_recvfrom.c
index ac6351e292c5..38f01652dc6d 100644
--- a/net/sunrpc/xprtrdma/svc_rdma_recvfrom.c
+++ b/net/sunrpc/xprtrdma/svc_rdma_recvfrom.c
@@ -123,7 +123,7 @@ svc_rdma_recv_ctxt_alloc(struct svcxprt_rdma *rdma)
 	dma_addr_t addr;
 	void *buffer;
 
-	ctxt = kmalloc_node(sizeof(*ctxt), GFP_KERNEL, node);
+	ctxt = kzalloc_node(sizeof(*ctxt), GFP_KERNEL, node);
 	if (!ctxt)
 		goto fail0;
 	buffer = kmalloc_node(rdma->sc_max_req_size, GFP_KERNEL, node);
diff --git a/net/sunrpc/xprtrdma/svc_rdma_rw.c b/net/sunrpc/xprtrdma/svc_rdma_rw.c
index eab71f3867fa..ff54bb268b7d 100644
--- a/net/sunrpc/xprtrdma/svc_rdma_rw.c
+++ b/net/sunrpc/xprtrdma/svc_rdma_rw.c
@@ -154,7 +154,10 @@ static int svc_rdma_rw_ctx_init(struct svcxprt_rdma *rdma,
 void svc_rdma_cc_init(struct svcxprt_rdma *rdma,
 		      struct svc_rdma_chunk_ctxt *cc)
 {
-	svc_rdma_send_cid_init(rdma, &cc->cc_cid);
+	struct rpc_rdma_cid *cid = &cc->cc_cid;
+
+	if (unlikely(!cid->ci_completion_id))
+		svc_rdma_send_cid_init(rdma, cid);
 
 	INIT_LIST_HEAD(&cc->cc_rwctxts);
 	cc->cc_sqecount = 0;
@@ -221,15 +224,13 @@ svc_rdma_write_info_alloc(struct svcxprt_rdma *rdma,
 {
 	struct svc_rdma_write_info *info;
 
-	info = kmalloc_node(sizeof(*info), GFP_KERNEL,
+	info = kzalloc_node(sizeof(*info), GFP_KERNEL,
 			    ibdev_to_node(rdma->sc_cm_id->device));
 	if (!info)
 		return info;
 
 	info->wi_rdma = rdma;
 	info->wi_chunk = chunk;
-	info->wi_seg_off = 0;
-	info->wi_seg_no = 0;
 	svc_rdma_cc_init(rdma, &info->wi_cc);
 	info->wi_cc.cc_cqe.done = svc_rdma_write_done;
 	return info;
diff --git a/net/sunrpc/xprtrdma/svc_rdma_sendto.c b/net/sunrpc/xprtrdma/svc_rdma_sendto.c
index c9585e469ca8..1a49b7f02041 100644
--- a/net/sunrpc/xprtrdma/svc_rdma_sendto.c
+++ b/net/sunrpc/xprtrdma/svc_rdma_sendto.c
@@ -122,7 +122,7 @@ svc_rdma_send_ctxt_alloc(struct svcxprt_rdma *rdma)
 	void *buffer;
 	int i;
 
-	ctxt = kmalloc_node(struct_size(ctxt, sc_sges, rdma->sc_max_send_sges),
+	ctxt = kzalloc_node(struct_size(ctxt, sc_sges, rdma->sc_max_send_sges),
 			    GFP_KERNEL, node);
 	if (!ctxt)
 		goto fail0;




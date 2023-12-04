Return-Path: <linux-nfs+bounces-296-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6124D8037EA
	for <lists+linux-nfs@lfdr.de>; Mon,  4 Dec 2023 15:58:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 125A71F211D3
	for <lists+linux-nfs@lfdr.de>; Mon,  4 Dec 2023 14:58:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B520928E27;
	Mon,  4 Dec 2023 14:58:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nLK7F3lx"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D7E028E1B;
	Mon,  4 Dec 2023 14:58:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24195C433C8;
	Mon,  4 Dec 2023 14:58:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701701914;
	bh=l4Ok7jDU6/ZybkCXXya+CbIAt244V/lkw2fwF+PLuO8=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=nLK7F3lxptX8p7hg0NieTRjHSi8HrGrCaGqg5VuybQyIzNSl9gOqVXCajxhgTkig7
	 irCseVZtiYRy9rcJTdv1zinMjKeoA1/fNZcmnHBBGfAIP1ZCab36axYguWd25eqDKF
	 pUp34JYSdFo72fu/ZF2N+o7wmfStRVcoPbMI7LJyRRE5kguAKXoijgw1vja3QR0dOM
	 trYFs+DaEHcr4JHS3/h0P4LCtYjBMv2lMQPjO0E79YPEZWOWEuQJpDDLwH7GZ7Cc8j
	 1fUxE4n7nYUh/6uIapDwfkyiUnYd8ASJpDALD4CvRCqhDGwzgOZCi6wiFZse6eyVNb
	 /TDNdVYL+FSFg==
Subject: [PATCH v1 21/21] svcrdma: Move the svc_rdma_cc_init() call
From: Chuck Lever <cel@kernel.org>
To: linux-nfs@vger.kernel.org, linux-rdma@vger.kernel.org
Cc: tom@talpey.com
Date: Mon, 04 Dec 2023 09:58:33 -0500
Message-ID: 
 <170170191315.54779.12414207929658084722.stgit@bazille.1015granger.net>
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

Now that the chunk_ctxt for Reads is no longer dynamically allocated
it can be initialized once for the life of the object that contains
it (struct svc_rdma_recv_ctxt).

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 include/linux/sunrpc/svc_rdma.h         |    2 ++
 net/sunrpc/xprtrdma/svc_rdma_recvfrom.c |    1 +
 net/sunrpc/xprtrdma/svc_rdma_rw.c       |   11 ++++++++---
 3 files changed, 11 insertions(+), 3 deletions(-)

diff --git a/include/linux/sunrpc/svc_rdma.h b/include/linux/sunrpc/svc_rdma.h
index f03f9909fb97..051fefde8d51 100644
--- a/include/linux/sunrpc/svc_rdma.h
+++ b/include/linux/sunrpc/svc_rdma.h
@@ -211,6 +211,8 @@ extern int svc_rdma_recvfrom(struct svc_rqst *);
 
 /* svc_rdma_rw.c */
 extern void svc_rdma_destroy_rw_ctxts(struct svcxprt_rdma *rdma);
+extern void svc_rdma_cc_init(struct svcxprt_rdma *rdma,
+			     struct svc_rdma_chunk_ctxt *cc);
 extern int svc_rdma_send_write_chunk(struct svcxprt_rdma *rdma,
 				     const struct svc_rdma_chunk *chunk,
 				     const struct xdr_buf *xdr);
diff --git a/net/sunrpc/xprtrdma/svc_rdma_recvfrom.c b/net/sunrpc/xprtrdma/svc_rdma_recvfrom.c
index 72374033bb2b..392a91dc8a99 100644
--- a/net/sunrpc/xprtrdma/svc_rdma_recvfrom.c
+++ b/net/sunrpc/xprtrdma/svc_rdma_recvfrom.c
@@ -156,6 +156,7 @@ svc_rdma_recv_ctxt_alloc(struct svcxprt_rdma *rdma)
 	ctxt->rc_recv_sge.length = rdma->sc_max_req_size;
 	ctxt->rc_recv_sge.lkey = rdma->sc_pd->local_dma_lkey;
 	ctxt->rc_recv_buf = buffer;
+	svc_rdma_cc_init(rdma, &ctxt->rc_cc);
 	return ctxt;
 
 fail2:
diff --git a/net/sunrpc/xprtrdma/svc_rdma_rw.c b/net/sunrpc/xprtrdma/svc_rdma_rw.c
index 0ccb21f1089e..4d2db06ccfd2 100644
--- a/net/sunrpc/xprtrdma/svc_rdma_rw.c
+++ b/net/sunrpc/xprtrdma/svc_rdma_rw.c
@@ -153,8 +153,13 @@ static void svc_rdma_cc_cid_init(struct svcxprt_rdma *rdma,
 	cid->ci_completion_id = atomic_inc_return(&rdma->sc_completion_ids);
 }
 
-static void svc_rdma_cc_init(struct svcxprt_rdma *rdma,
-			     struct svc_rdma_chunk_ctxt *cc)
+/**
+ * svc_rdma_cc_init - Initialize an svc_rdma_chunk_ctxt
+ * @rdma: controlling transport instance
+ * @cc: svc_rdma_chunk_ctxt to be initialized
+ */
+void svc_rdma_cc_init(struct svcxprt_rdma *rdma,
+		      struct svc_rdma_chunk_ctxt *cc)
 {
 	svc_rdma_cc_cid_init(rdma, &cc->cc_cid);
 
@@ -1101,8 +1106,8 @@ int svc_rdma_process_read_list(struct svcxprt_rdma *rdma,
 	struct svc_rdma_chunk_ctxt *cc = &head->rc_cc;
 	int ret;
 
-	svc_rdma_cc_init(rdma, cc);
 	cc->cc_cqe.done = svc_rdma_wc_read_done;
+	cc->cc_sqecount = 0;
 	head->rc_pageoff = 0;
 	head->rc_curpage = 0;
 	head->rc_readbytes = 0;




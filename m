Return-Path: <linux-nfs+bounces-280-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DBFB68037BE
	for <lists+linux-nfs@lfdr.de>; Mon,  4 Dec 2023 15:56:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 93B4628118A
	for <lists+linux-nfs@lfdr.de>; Mon,  4 Dec 2023 14:56:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D7C328DD7;
	Mon,  4 Dec 2023 14:56:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Be+OnbLN"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F10A128DB9;
	Mon,  4 Dec 2023 14:56:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 883C0C433C8;
	Mon,  4 Dec 2023 14:56:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701701811;
	bh=lLNQdtjNiMSDjE5o4ogCva/n1UAzdGY6lT0SdSU9FpQ=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=Be+OnbLNPsQCY1nPCAEL0T0PT/ppuOGFRKTkbKBCKFDjRl/FsqIVtr7GLK0XTG9y+
	 epVj6r73Wn3X6kHxuDAM71IJtF3mlDIAw+rOtw35y/27TXuXL1IiDcVANuDpq4oPzU
	 9P7lLX1rYR4R6ZOedclBbh0hVAhwQPPEU4YWP32bvHzsNLqTM2IzRGRrU3OdFVmj6N
	 +6/ph8wwx7nHfsUm4wOmra6u6Ajltxx2udcBweMh4qGkTCHfOEZXPOphDchrRPVVtF
	 MgFkG4cVvbDVm+OybY4tFr4BaE5uDJQgSdUnFqz5787gjYWLbyx2Nx8MYgCFcQlyID
	 oROjJLX2MwmKQ==
Subject: [PATCH v1 05/21] svcrdma: Explicitly pass the transport to
 svc_rdma_post_chunk_ctxt()
From: Chuck Lever <cel@kernel.org>
To: linux-nfs@vger.kernel.org, linux-rdma@vger.kernel.org
Cc: tom@talpey.com
Date: Mon, 04 Dec 2023 09:56:50 -0500
Message-ID: 
 <170170181064.54779.7136970912837343952.stgit@bazille.1015granger.net>
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

Enable the eventual removal of the svc_rdma_chunk_ctxt::cc_rdma
field.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 net/sunrpc/xprtrdma/svc_rdma_rw.c |   10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/net/sunrpc/xprtrdma/svc_rdma_rw.c b/net/sunrpc/xprtrdma/svc_rdma_rw.c
index cda57a5f8ba0..c0b64a79197e 100644
--- a/net/sunrpc/xprtrdma/svc_rdma_rw.c
+++ b/net/sunrpc/xprtrdma/svc_rdma_rw.c
@@ -379,9 +379,9 @@ static void svc_rdma_wc_read_done(struct ib_cq *cq, struct ib_wc *wc)
  *   even if one or more WRs are flushed. This is true when posting
  *   an rdma_rw_ctx or when posting a single signaled WR.
  */
-static int svc_rdma_post_chunk_ctxt(struct svc_rdma_chunk_ctxt *cc)
+static int svc_rdma_post_chunk_ctxt(struct svcxprt_rdma *rdma,
+				    struct svc_rdma_chunk_ctxt *cc)
 {
-	struct svcxprt_rdma *rdma = cc->cc_rdma;
 	struct ib_send_wr *first_wr;
 	const struct ib_send_wr *bad_wr;
 	struct list_head *tmp;
@@ -652,7 +652,7 @@ int svc_rdma_send_write_chunk(struct svcxprt_rdma *rdma,
 		goto out_err;
 
 	trace_svcrdma_post_write_chunk(&cc->cc_cid, cc->cc_sqecount);
-	ret = svc_rdma_post_chunk_ctxt(cc);
+	ret = svc_rdma_post_chunk_ctxt(rdma, cc);
 	if (ret < 0)
 		goto out_err;
 	return xdr->len;
@@ -699,7 +699,7 @@ int svc_rdma_send_reply_chunk(struct svcxprt_rdma *rdma,
 		goto out_err;
 
 	trace_svcrdma_post_reply_chunk(&cc->cc_cid, cc->cc_sqecount);
-	ret = svc_rdma_post_chunk_ctxt(cc);
+	ret = svc_rdma_post_chunk_ctxt(rdma, cc);
 	if (ret < 0)
 		goto out_err;
 
@@ -1180,7 +1180,7 @@ int svc_rdma_process_read_list(struct svcxprt_rdma *rdma,
 
 	trace_svcrdma_post_read_chunk(&cc->cc_cid, cc->cc_sqecount);
 	init_completion(&cc->cc_done);
-	ret = svc_rdma_post_chunk_ctxt(cc);
+	ret = svc_rdma_post_chunk_ctxt(rdma, cc);
 	if (ret < 0)
 		goto out_err;
 




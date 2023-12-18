Return-Path: <linux-nfs+bounces-700-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 05643817D44
	for <lists+linux-nfs@lfdr.de>; Mon, 18 Dec 2023 23:32:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 925081F2313C
	for <lists+linux-nfs@lfdr.de>; Mon, 18 Dec 2023 22:32:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0560F760AD;
	Mon, 18 Dec 2023 22:31:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fOPVDpx6"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC8981DA28;
	Mon, 18 Dec 2023 22:31:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17D9BC433CB;
	Mon, 18 Dec 2023 22:31:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702938709;
	bh=eYSMCXEWCP5bh3BeAGAIeQYc5eJ8cHs4zKGVtJ4qhxA=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=fOPVDpx68Vbz4gRtIX+fkT5OAIqC92X2VrDHRt2nBMxXUOQslOID929sXylMXuodA
	 9FJGesLqk9A9OcQg+sCvYqdhC3ufoBrmJzjiPFwD16rNrhQdgRIl91QSxilN9BWo0v
	 2nOyLUhXVhJxKltqOQyWyvulgUkDRPtq49FgZ6HyTvzu5X95LwrY55fEtuVs2Eon1n
	 TpRaTNqMQIB1VGaUY9PAt7XbmGR7N9ijyjqbZ1Q8dmpMcvj7YQixDgk0oClnVkzVwF
	 PF2t2PcjJZDI9533nLcKJLWpSfNNUoeuYAAbTgVtQVKr2/z2LReo4HIauTT7mT8BH8
	 6vGghqVhOuu8w==
Subject: [PATCH v1 1/4] svcrdma: Add back svc_rdma_recv_ctxt::rc_pages
From: Chuck Lever <cel@kernel.org>
To: linux-nfs@vger.kernel.org, linux-rdma@vger.kernel.org
Cc: tom@talpey.com
Date: Mon, 18 Dec 2023 17:31:48 -0500
Message-ID: 
 <170293870808.4604.205731294518425415.stgit@bazille.1015granger.net>
In-Reply-To: 
 <170293795877.4604.12721267378032407419.stgit@bazille.1015granger.net>
References: 
 <170293795877.4604.12721267378032407419.stgit@bazille.1015granger.net>
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

Having an nfsd thread waiting for an RDMA Read completion is
problematic if the Read responder (the client) stops responding. We
need to go back to handling RDMA Reads by allowing the nfsd thread
to return to the svc scheduler, then waking a second thread finish
the RPC message once the Read completion fires.

To start with, restore the rc_pages field so that RDMA Read pages
can be managed across calls to svc_rdma_recvfrom().

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 include/linux/sunrpc/svc_rdma.h         |    4 +++-
 net/sunrpc/xprtrdma/svc_rdma_recvfrom.c |    5 +++++
 net/sunrpc/xprtrdma/svc_rdma_rw.c       |    4 +++-
 3 files changed, 11 insertions(+), 2 deletions(-)

diff --git a/include/linux/sunrpc/svc_rdma.h b/include/linux/sunrpc/svc_rdma.h
index 46f2ce9f810b..0f2d7f68ef5d 100644
--- a/include/linux/sunrpc/svc_rdma.h
+++ b/include/linux/sunrpc/svc_rdma.h
@@ -183,7 +183,6 @@ struct svc_rdma_recv_ctxt {
 	void			*rc_recv_buf;
 	struct xdr_stream	rc_stream;
 	u32			rc_byte_len;
-	unsigned int		rc_page_count;
 	u32			rc_inv_rkey;
 	__be32			rc_msgtype;
 
@@ -199,6 +198,9 @@ struct svc_rdma_recv_ctxt {
 	struct svc_rdma_chunk	*rc_cur_result_payload;
 	struct svc_rdma_pcl	rc_write_pcl;
 	struct svc_rdma_pcl	rc_reply_pcl;
+
+	unsigned int		rc_page_count;
+	struct page		*rc_pages[RPCSVC_MAXPAGES];
 };
 
 struct svc_rdma_send_ctxt {
diff --git a/net/sunrpc/xprtrdma/svc_rdma_recvfrom.c b/net/sunrpc/xprtrdma/svc_rdma_recvfrom.c
index 38f01652dc6d..e363cb1bdbc4 100644
--- a/net/sunrpc/xprtrdma/svc_rdma_recvfrom.c
+++ b/net/sunrpc/xprtrdma/svc_rdma_recvfrom.c
@@ -214,6 +214,11 @@ struct svc_rdma_recv_ctxt *svc_rdma_recv_ctxt_get(struct svcxprt_rdma *rdma)
 void svc_rdma_recv_ctxt_put(struct svcxprt_rdma *rdma,
 			    struct svc_rdma_recv_ctxt *ctxt)
 {
+	/* @rc_page_count is normally zero here, but error flows
+	 * can leave pages in @rc_pages.
+	 */
+	release_pages(ctxt->rc_pages, ctxt->rc_page_count);
+
 	pcl_free(&ctxt->rc_call_pcl);
 	pcl_free(&ctxt->rc_read_pcl);
 	pcl_free(&ctxt->rc_write_pcl);
diff --git a/net/sunrpc/xprtrdma/svc_rdma_rw.c b/net/sunrpc/xprtrdma/svc_rdma_rw.c
index ff54bb268b7d..28a34718dee5 100644
--- a/net/sunrpc/xprtrdma/svc_rdma_rw.c
+++ b/net/sunrpc/xprtrdma/svc_rdma_rw.c
@@ -1131,7 +1131,9 @@ int svc_rdma_process_read_list(struct svcxprt_rdma *rdma,
 	rqstp->rq_respages = &rqstp->rq_pages[head->rc_page_count];
 	rqstp->rq_next_page = rqstp->rq_respages + 1;
 
-	/* Ensure svc_rdma_recv_ctxt_put() does not try to release pages */
+	/* Ensure svc_rdma_recv_ctxt_put() does not release pages
+	 * left in @rc_pages while I/O proceeds.
+	 */
 	head->rc_page_count = 0;
 
 out_err:




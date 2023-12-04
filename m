Return-Path: <linux-nfs+bounces-276-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C0018037AE
	for <lists+linux-nfs@lfdr.de>; Mon,  4 Dec 2023 15:56:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B4CAB1F21236
	for <lists+linux-nfs@lfdr.de>; Mon,  4 Dec 2023 14:56:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB680286B3;
	Mon,  4 Dec 2023 14:56:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gXvI/0pQ"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AADE422EEE;
	Mon,  4 Dec 2023 14:56:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB3E9C433C7;
	Mon,  4 Dec 2023 14:56:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701701786;
	bh=hOWTxUDjA+zelWg+rXMPFmZj3aTXBB7jCFyHmHc2LFQ=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=gXvI/0pQRwvNR8oq2oAeYR0JWT+U213ehTldb0foyrsW6+vANphRKJmtJVi5mNvig
	 GVCXrxOEnDb7YiQrXmHZTNDj/PrfEsKKBgGKEc7Oalgz7/xYJphZ3+Ob1g3hj1L1lg
	 8FAonkJjSD5qnpYmoVZYZpq9cNOaGpjzygVXk2rmb7laM43uaaqkzUXnD6J7/NaggX
	 ywlSysJJ1vbtCTWGhNh8s5bNKoYoOQm10Me14hYP6B0auaKb0gknqT5rk4huudAVSC
	 GRWDI7uJ6okDFTa80O0vnEaLsJ5KQvdIiTzXWK62tgGJ3XpksPTias/P0qf3AIuwji
	 /f5lrVNs5G35Q==
Subject: [PATCH v1 01/21] svcrdma: Reduce size of struct svc_rdma_rw_ctxt
From: Chuck Lever <cel@kernel.org>
To: linux-nfs@vger.kernel.org, linux-rdma@vger.kernel.org
Cc: tom@talpey.com
Date: Mon, 04 Dec 2023 09:56:24 -0500
Message-ID: 
 <170170178494.54779.7160706939335739704.stgit@bazille.1015granger.net>
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

SG_CHUNK_SIZE is 128, making struct svc_rdma_rw_ctxt + the first
SGL array more than 4200 bytes in length, pushing the memory
allocation well into order 1.

Even so, the RDMA rw core doesn't seem to use more than max_send_sge
entries in that array (typically 32 or less), so that is all wasted
space.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 net/sunrpc/xprtrdma/svc_rdma_rw.c |   12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/net/sunrpc/xprtrdma/svc_rdma_rw.c b/net/sunrpc/xprtrdma/svc_rdma_rw.c
index c06676714417..69010ab7f0c3 100644
--- a/net/sunrpc/xprtrdma/svc_rdma_rw.c
+++ b/net/sunrpc/xprtrdma/svc_rdma_rw.c
@@ -39,6 +39,7 @@ struct svc_rdma_rw_ctxt {
 	struct list_head	rw_list;
 	struct rdma_rw_ctx	rw_ctx;
 	unsigned int		rw_nents;
+	unsigned int		rw_first_sgl_nents;
 	struct sg_table		rw_sg_table;
 	struct scatterlist	rw_first_sgl[];
 };
@@ -53,6 +54,8 @@ svc_rdma_next_ctxt(struct list_head *list)
 static struct svc_rdma_rw_ctxt *
 svc_rdma_get_rw_ctxt(struct svcxprt_rdma *rdma, unsigned int sges)
 {
+	struct ib_device *dev = rdma->sc_cm_id->device;
+	unsigned int first_sgl_nents = dev->attrs.max_send_sge;
 	struct svc_rdma_rw_ctxt *ctxt;
 	struct llist_node *node;
 
@@ -62,18 +65,19 @@ svc_rdma_get_rw_ctxt(struct svcxprt_rdma *rdma, unsigned int sges)
 	if (node) {
 		ctxt = llist_entry(node, struct svc_rdma_rw_ctxt, rw_node);
 	} else {
-		ctxt = kmalloc_node(struct_size(ctxt, rw_first_sgl, SG_CHUNK_SIZE),
-				    GFP_KERNEL, ibdev_to_node(rdma->sc_cm_id->device));
+		ctxt = kmalloc_node(struct_size(ctxt, rw_first_sgl, first_sgl_nents),
+				    GFP_KERNEL, ibdev_to_node(dev));
 		if (!ctxt)
 			goto out_noctx;
 
 		INIT_LIST_HEAD(&ctxt->rw_list);
+		ctxt->rw_first_sgl_nents = first_sgl_nents;
 	}
 
 	ctxt->rw_sg_table.sgl = ctxt->rw_first_sgl;
 	if (sg_alloc_table_chained(&ctxt->rw_sg_table, sges,
 				   ctxt->rw_sg_table.sgl,
-				   SG_CHUNK_SIZE))
+				   first_sgl_nents))
 		goto out_free;
 	return ctxt;
 
@@ -87,7 +91,7 @@ svc_rdma_get_rw_ctxt(struct svcxprt_rdma *rdma, unsigned int sges)
 static void __svc_rdma_put_rw_ctxt(struct svc_rdma_rw_ctxt *ctxt,
 				   struct llist_head *list)
 {
-	sg_free_table_chained(&ctxt->rw_sg_table, SG_CHUNK_SIZE);
+	sg_free_table_chained(&ctxt->rw_sg_table, ctxt->rw_first_sgl_nents);
 	llist_add(&ctxt->rw_node, list);
 }
 




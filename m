Return-Path: <linux-nfs+bounces-294-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D090F8037E7
	for <lists+linux-nfs@lfdr.de>; Mon,  4 Dec 2023 15:58:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 736F3B20A88
	for <lists+linux-nfs@lfdr.de>; Mon,  4 Dec 2023 14:58:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6C3128E1F;
	Mon,  4 Dec 2023 14:58:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kNUeJoPI"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7C2528DD7;
	Mon,  4 Dec 2023 14:58:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 432CEC433C7;
	Mon,  4 Dec 2023 14:58:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701701901;
	bh=woHSLUIDXPWenqv8VoyQP+GxisT4jOzpskvsGkDI57U=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=kNUeJoPIbG0Qv2R99+q+E7oVefzLvTm4S8xoxUJhUPJtQ3oxsO8I5Kdshdy6RzpDw
	 uMNEzHwyEClYxqxp+/hXCI622TZ0FUE93uY0Nt8ti+89focSny1jCQrVQh6pKPIm2G
	 0WtOuG8gl8QQLxln6bZW0hiAxjUxrjsafzPBsvdUMha8DJQf5w/GDd1dSCqP0Ql0ba
	 27xzws4OoH90E6ultxThaLK9Y74Y5rENnEaaATGWuN5aPTeSlVKKPgaAG7p1pcs4ze
	 97GI+/HqZnKwsPvCq4t92nRYI0zs8W5CUXt0C65UZCzICq9p3odaVF8DCX+OLLjWRJ
	 UPX/DnMWehnTw==
Subject: [PATCH v1 19/21] svcrdma: Update the synopsis of
 svc_rdma_read_special()
From: Chuck Lever <cel@kernel.org>
To: linux-nfs@vger.kernel.org, linux-rdma@vger.kernel.org
Cc: tom@talpey.com
Date: Mon, 04 Dec 2023 09:58:20 -0500
Message-ID: 
 <170170190032.54779.14702452194868869890.stgit@bazille.1015granger.net>
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

Since the RDMA Read I/O state is now contained in the recv_ctxt,
svc_rdma_read_special() can use that recv_ctxt to derive the
read_info rather than the other way around. This removes another
usage of the ri_readctxt field, enabling its removal in a
subsequent patch.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 net/sunrpc/xprtrdma/svc_rdma_rw.c |   19 +++++++++----------
 1 file changed, 9 insertions(+), 10 deletions(-)

diff --git a/net/sunrpc/xprtrdma/svc_rdma_rw.c b/net/sunrpc/xprtrdma/svc_rdma_rw.c
index f9d1b0463282..a3003c2dc0a2 100644
--- a/net/sunrpc/xprtrdma/svc_rdma_rw.c
+++ b/net/sunrpc/xprtrdma/svc_rdma_rw.c
@@ -1054,8 +1054,8 @@ static int svc_rdma_read_call_chunk(struct svc_rqst *rqstp,
 
 /**
  * svc_rdma_read_special - Build RDMA Read WQEs to pull a Long Message
- * @rdma: controlling transport
- * @info: context for RDMA Reads
+ * @rqstp: RPC transaction context
+ * @head: context for ongoing I/O
  *
  * The start of the data lands in the first page just after the
  * Transport header, and the rest lands in rqstp->rq_arg.pages.
@@ -1071,23 +1071,22 @@ static int svc_rdma_read_call_chunk(struct svc_rqst *rqstp,
  *   %-ENOTCONN: posting failed (connection is lost),
  *   %-EIO: rdma_rw initialization failed (DMA mapping, etc).
  */
-static noinline int svc_rdma_read_special(struct svcxprt_rdma *rdma,
-					  struct svc_rdma_read_info *info)
+static noinline int svc_rdma_read_special(struct svc_rqst *rqstp,
+					  struct svc_rdma_recv_ctxt *head)
 {
-	struct svc_rdma_recv_ctxt *head = info->ri_readctxt;
-	struct xdr_buf *buf = &info->ri_rqst->rq_arg;
+	struct xdr_buf *buf = &rqstp->rq_arg;
 	int ret;
 
-	ret = svc_rdma_read_call_chunk(info->ri_rqst, info->ri_readctxt);
+	ret = svc_rdma_read_call_chunk(rqstp, head);
 	if (ret < 0)
 		goto out;
 
 	buf->len += head->rc_readbytes;
 	buf->buflen += head->rc_readbytes;
 
-	buf->head[0].iov_base = page_address(info->ri_rqst->rq_pages[0]);
+	buf->head[0].iov_base = page_address(rqstp->rq_pages[0]);
 	buf->head[0].iov_len = min_t(size_t, PAGE_SIZE, head->rc_readbytes);
-	buf->pages = &info->ri_rqst->rq_pages[1];
+	buf->pages = &rqstp->rq_pages[1];
 	buf->page_len = head->rc_readbytes - buf->head[0].iov_len;
 
 out:
@@ -1142,7 +1141,7 @@ int svc_rdma_process_read_list(struct svcxprt_rdma *rdma,
 		else
 			ret = svc_rdma_read_multiple_chunks(rqstp, head);
 	} else
-		ret = svc_rdma_read_special(rdma, info);
+		ret = svc_rdma_read_special(rqstp, head);
 	if (ret < 0)
 		goto out_err;
 




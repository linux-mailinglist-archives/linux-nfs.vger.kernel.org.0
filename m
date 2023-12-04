Return-Path: <linux-nfs+bounces-281-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 739F28037C4
	for <lists+linux-nfs@lfdr.de>; Mon,  4 Dec 2023 15:57:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2F585281137
	for <lists+linux-nfs@lfdr.de>; Mon,  4 Dec 2023 14:57:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D64E228DD8;
	Mon,  4 Dec 2023 14:56:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fD5ZkKs2"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B696628DB6;
	Mon,  4 Dec 2023 14:56:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0A7EC433C8;
	Mon,  4 Dec 2023 14:56:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701701818;
	bh=fHIjcO5K+bWRNVdkbSUDNozsj/t7D5bxIXHwZHgZTic=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=fD5ZkKs2ZNB8A6YBl7XQ8lJcL1oNFYsG7DWCVfjHF74NEFIxfGrMnFAobkjfumFTW
	 +HNnphtHGByquyESlPPyTlwgv1Ba6yg9RD45oo6Mgw5HliZ+MDM0iJQZyqrR4WYbNK
	 ++YwKCl1iRH1lw10PG0mr7FjjLEO4T8XL9dDZ/KdtVkIep/dS36dhTvp79h8VQVnIx
	 3oM+9y+HEgq5ULbUMgvF9k91u5nqUhOBpBRyWld4hHFs3lP1UzuYIl016iFX5ucVqb
	 ceetesvXs7rQThGZr2+UVX+mFDsP9vcLT63kW0CrXkP/+uk5kISDnPCt5tCaR7yqrn
	 1ZH5zSFO5v0WA==
Subject: [PATCH v1 06/21] svcrdma: Pass a pointer to the transport to
 svc_rdma_cc_release()
From: Chuck Lever <cel@kernel.org>
To: linux-nfs@vger.kernel.org, linux-rdma@vger.kernel.org
Cc: tom@talpey.com
Date: Mon, 04 Dec 2023 09:56:57 -0500
Message-ID: 
 <170170181700.54779.12821389893583498120.stgit@bazille.1015granger.net>
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
 net/sunrpc/xprtrdma/svc_rdma_rw.c |   13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/net/sunrpc/xprtrdma/svc_rdma_rw.c b/net/sunrpc/xprtrdma/svc_rdma_rw.c
index c0b64a79197e..7676b9df024b 100644
--- a/net/sunrpc/xprtrdma/svc_rdma_rw.c
+++ b/net/sunrpc/xprtrdma/svc_rdma_rw.c
@@ -187,10 +187,10 @@ static void svc_rdma_cc_init(struct svcxprt_rdma *rdma,
  * that only one atomic llist operation is needed to put them all
  * back on the free list.
  */
-static void svc_rdma_cc_release(struct svc_rdma_chunk_ctxt *cc,
+static void svc_rdma_cc_release(struct svcxprt_rdma *rdma,
+				struct svc_rdma_chunk_ctxt *cc,
 				enum dma_data_direction dir)
 {
-	struct svcxprt_rdma *rdma = cc->cc_rdma;
 	struct llist_node *first, *last;
 	struct svc_rdma_rw_ctxt *ctxt;
 	LLIST_HEAD(free);
@@ -262,7 +262,7 @@ static void svc_rdma_write_info_free_async(struct work_struct *work)
 	struct svc_rdma_write_info *info;
 
 	info = container_of(work, struct svc_rdma_write_info, wi_work);
-	svc_rdma_cc_release(&info->wi_cc, DMA_TO_DEVICE);
+	svc_rdma_cc_release(info->wi_rdma, &info->wi_cc, DMA_TO_DEVICE);
 	kfree(info);
 }
 
@@ -334,9 +334,10 @@ svc_rdma_read_info_alloc(struct svcxprt_rdma *rdma)
 	return info;
 }
 
-static void svc_rdma_read_info_free(struct svc_rdma_read_info *info)
+static void svc_rdma_read_info_free(struct svcxprt_rdma *rdma,
+				    struct svc_rdma_read_info *info)
 {
-	svc_rdma_cc_release(&info->ri_cc, DMA_FROM_DEVICE);
+	svc_rdma_cc_release(rdma, &info->ri_cc, DMA_FROM_DEVICE);
 	kfree(info);
 }
 
@@ -1197,6 +1198,6 @@ int svc_rdma_process_read_list(struct svcxprt_rdma *rdma,
 	head->rc_page_count = 0;
 
 out_err:
-	svc_rdma_read_info_free(info);
+	svc_rdma_read_info_free(rdma, info);
 	return ret;
 }




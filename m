Return-Path: <linux-nfs+bounces-286-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 06DE68037D2
	for <lists+linux-nfs@lfdr.de>; Mon,  4 Dec 2023 15:57:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8AB86B20A93
	for <lists+linux-nfs@lfdr.de>; Mon,  4 Dec 2023 14:57:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74C5828E17;
	Mon,  4 Dec 2023 14:57:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TTZ1fDED"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5439D28DDB;
	Mon,  4 Dec 2023 14:57:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DED55C433C8;
	Mon,  4 Dec 2023 14:57:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701701850;
	bh=k9UbttEcCLXOID4VqV0oxADiwsPFk/Mm2tumAEJ3v3g=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=TTZ1fDED/vxMxNEwk/5ziWNlTGDSm4BiAOzcEv1CgpM/UNQMQT+LThFx/c+FN08hD
	 +dW2B7/4UPFsskCGS9shTEYRZBzSlzecZ26k66dNDsQz1/ZtV4W56yaxmhvNw1zUr8
	 +vcr90nJWscTgl/O4pxFfdaTjmHhs0OK01oOjClfyoZu0pV4fwIfNT02Vruq0xK/ew
	 xE9CzASMGHC3M9vQ46o9Evn15PT1kilbBGIpG3cjyt2KTLEiO4u7kUhdsMZDvLPgZS
	 lQE5zrzetAta8Y/iAX+KiZqzdImr7isqlYt1E1p6Rae2Dmhxj0ndhU8ak9IDdR5Cdi
	 HOSA1zzbzjFrQ==
Subject: [PATCH v1 11/21] svcrdma: Move read_info::ri_pageoff into struct
 svc_rdma_recv_ctxt
From: Chuck Lever <cel@kernel.org>
To: linux-nfs@vger.kernel.org, linux-rdma@vger.kernel.org
Cc: tom@talpey.com
Date: Mon, 04 Dec 2023 09:57:28 -0500
Message-ID: 
 <170170184893.54779.2758740657461762143.stgit@bazille.1015granger.net>
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

Further clean up: move the starting byte offset field into
svc_rdma_recv_ctxt.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 include/linux/sunrpc/svc_rdma.h   |    1 +
 net/sunrpc/xprtrdma/svc_rdma_rw.c |   31 +++++++++++++++----------------
 2 files changed, 16 insertions(+), 16 deletions(-)

diff --git a/include/linux/sunrpc/svc_rdma.h b/include/linux/sunrpc/svc_rdma.h
index 0ea66f73bec2..44a14eaf8c40 100644
--- a/include/linux/sunrpc/svc_rdma.h
+++ b/include/linux/sunrpc/svc_rdma.h
@@ -157,6 +157,7 @@ struct svc_rdma_recv_ctxt {
 	__be32			rc_msgtype;
 
 	/* State for pulling a Read chunk */
+	unsigned int		rc_pageoff;
 	unsigned int		rc_curpage;
 	unsigned int		rc_readbytes;
 	struct svc_rdma_chunk_ctxt	rc_cc;
diff --git a/net/sunrpc/xprtrdma/svc_rdma_rw.c b/net/sunrpc/xprtrdma/svc_rdma_rw.c
index 487acb192558..dbced8970779 100644
--- a/net/sunrpc/xprtrdma/svc_rdma_rw.c
+++ b/net/sunrpc/xprtrdma/svc_rdma_rw.c
@@ -292,7 +292,6 @@ static void svc_rdma_write_done(struct ib_cq *cq, struct ib_wc *wc)
 struct svc_rdma_read_info {
 	struct svc_rqst			*ri_rqst;
 	struct svc_rdma_recv_ctxt	*ri_readctxt;
-	unsigned int			ri_pageoff;
 };
 
 static struct svc_rdma_read_info *
@@ -705,7 +704,7 @@ static int svc_rdma_build_read_segment(struct svcxprt_rdma *rdma,
 	int ret;
 
 	len = segment->rs_length;
-	sge_no = PAGE_ALIGN(info->ri_pageoff + len) >> PAGE_SHIFT;
+	sge_no = PAGE_ALIGN(head->rc_pageoff + len) >> PAGE_SHIFT;
 	ctxt = svc_rdma_get_rw_ctxt(rdma, sge_no);
 	if (!ctxt)
 		return -ENOMEM;
@@ -714,19 +713,19 @@ static int svc_rdma_build_read_segment(struct svcxprt_rdma *rdma,
 	sg = ctxt->rw_sg_table.sgl;
 	for (sge_no = 0; sge_no < ctxt->rw_nents; sge_no++) {
 		seg_len = min_t(unsigned int, len,
-				PAGE_SIZE - info->ri_pageoff);
+				PAGE_SIZE - head->rc_pageoff);
 
-		if (!info->ri_pageoff)
+		if (!head->rc_pageoff)
 			head->rc_page_count++;
 
 		sg_set_page(sg, rqstp->rq_pages[head->rc_curpage],
-			    seg_len, info->ri_pageoff);
+			    seg_len, head->rc_pageoff);
 		sg = sg_next(sg);
 
-		info->ri_pageoff += seg_len;
-		if (info->ri_pageoff == PAGE_SIZE) {
+		head->rc_pageoff += seg_len;
+		if (head->rc_pageoff == PAGE_SIZE) {
 			head->rc_curpage++;
-			info->ri_pageoff = 0;
+			head->rc_pageoff = 0;
 		}
 		len -= seg_len;
 
@@ -787,7 +786,7 @@ static int svc_rdma_build_read_chunk(struct svcxprt_rdma *rdma,
  *
  * Take a page at a time from rqstp->rq_pages and copy the inline
  * content from the Receive buffer into that page. Update
- * head->rc_curpage and info->ri_pageoff so that the next RDMA Read
+ * head->rc_curpage and head->rc_pageoff so that the next RDMA Read
  * result will land contiguously with the copied content.
  *
  * Return values:
@@ -803,24 +802,24 @@ static int svc_rdma_copy_inline_range(struct svc_rdma_read_info *info,
 	struct svc_rqst *rqstp = info->ri_rqst;
 	unsigned int page_no, numpages;
 
-	numpages = PAGE_ALIGN(info->ri_pageoff + remaining) >> PAGE_SHIFT;
+	numpages = PAGE_ALIGN(head->rc_pageoff + remaining) >> PAGE_SHIFT;
 	for (page_no = 0; page_no < numpages; page_no++) {
 		unsigned int page_len;
 
 		page_len = min_t(unsigned int, remaining,
-				 PAGE_SIZE - info->ri_pageoff);
+				 PAGE_SIZE - head->rc_pageoff);
 
-		if (!info->ri_pageoff)
+		if (!head->rc_pageoff)
 			head->rc_page_count++;
 
 		dst = page_address(rqstp->rq_pages[head->rc_curpage]);
 		memcpy(dst + head->rc_curpage, src + offset, page_len);
 
 		head->rc_readbytes += page_len;
-		info->ri_pageoff += page_len;
-		if (info->ri_pageoff == PAGE_SIZE) {
+		head->rc_pageoff += page_len;
+		if (head->rc_pageoff == PAGE_SIZE) {
 			head->rc_curpage++;
-			info->ri_pageoff = 0;
+			head->rc_pageoff = 0;
 		}
 		remaining -= page_len;
 		offset += page_len;
@@ -1134,9 +1133,9 @@ int svc_rdma_process_read_list(struct svcxprt_rdma *rdma,
 		return -ENOMEM;
 	info->ri_rqst = rqstp;
 	info->ri_readctxt = head;
-	info->ri_pageoff = 0;
 	svc_rdma_cc_init(rdma, cc);
 	cc->cc_cqe.done = svc_rdma_wc_read_done;
+	head->rc_pageoff = 0;
 	head->rc_curpage = 0;
 	head->rc_readbytes = 0;
 




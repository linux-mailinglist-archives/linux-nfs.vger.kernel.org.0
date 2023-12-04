Return-Path: <linux-nfs+bounces-285-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BE3E8037CF
	for <lists+linux-nfs@lfdr.de>; Mon,  4 Dec 2023 15:57:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EA7761F211EB
	for <lists+linux-nfs@lfdr.de>; Mon,  4 Dec 2023 14:57:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66C8828E07;
	Mon,  4 Dec 2023 14:57:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RMr7iLNm"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4379A28DB6;
	Mon,  4 Dec 2023 14:57:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73BF2C433C8;
	Mon,  4 Dec 2023 14:57:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701701843;
	bh=fPwU/ey4ZZiR7AlTk8tV5eZLWybtFxR0P0I2YfbZ7XA=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=RMr7iLNmbUi7HSf1s92+8k+DRzfyxafCi22W69zlPYcTl2/PVdWJ9QHojS3319evT
	 w6auOLEo7Fz0BCLxvsxsDZODu7kv/JDS8JAjXgJ4I4dTP5Uljs0C9uyQJAqIebi71+
	 t1+GHtFiQqRUyhB0gUl8neS+hDNzYSISImJjTdloSZsaCbfclxf2IGyO1+8CLsEHT9
	 UnBsT0fyZd72clDQxukNLPZjcpHYbwt6cegnhkEMqfhfTYpWzIuhzYC2YQzqM3JFWd
	 13c1E0rTGSbx70Uszt59sAZQKJw5zAyA+G3jEtqh1c4gyxRDuuYpwRKudvskAAoCzG
	 RfST+FDYIWM6Q==
Subject: [PATCH v1 10/21] svcrdma: Move svc_rdma_read_info::ri_pageno to
 struct svc_rdma_recv_ctxt
From: Chuck Lever <cel@kernel.org>
To: linux-nfs@vger.kernel.org, linux-rdma@vger.kernel.org
Cc: tom@talpey.com
Date: Mon, 04 Dec 2023 09:57:22 -0500
Message-ID: 
 <170170184250.54779.8437537335627107281.stgit@bazille.1015granger.net>
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

Further clean up: move the page index field into svc_rdma_recv_ctxt.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 include/linux/sunrpc/svc_rdma.h   |    1 +
 net/sunrpc/xprtrdma/svc_rdma_rw.c |   21 +++++++++------------
 2 files changed, 10 insertions(+), 12 deletions(-)

diff --git a/include/linux/sunrpc/svc_rdma.h b/include/linux/sunrpc/svc_rdma.h
index 6c7501ae4e29..0ea66f73bec2 100644
--- a/include/linux/sunrpc/svc_rdma.h
+++ b/include/linux/sunrpc/svc_rdma.h
@@ -157,6 +157,7 @@ struct svc_rdma_recv_ctxt {
 	__be32			rc_msgtype;
 
 	/* State for pulling a Read chunk */
+	unsigned int		rc_curpage;
 	unsigned int		rc_readbytes;
 	struct svc_rdma_chunk_ctxt	rc_cc;
 
diff --git a/net/sunrpc/xprtrdma/svc_rdma_rw.c b/net/sunrpc/xprtrdma/svc_rdma_rw.c
index a27b8f338ae5..487acb192558 100644
--- a/net/sunrpc/xprtrdma/svc_rdma_rw.c
+++ b/net/sunrpc/xprtrdma/svc_rdma_rw.c
@@ -292,7 +292,6 @@ static void svc_rdma_write_done(struct ib_cq *cq, struct ib_wc *wc)
 struct svc_rdma_read_info {
 	struct svc_rqst			*ri_rqst;
 	struct svc_rdma_recv_ctxt	*ri_readctxt;
-	unsigned int			ri_pageno;
 	unsigned int			ri_pageoff;
 };
 
@@ -720,20 +719,18 @@ static int svc_rdma_build_read_segment(struct svcxprt_rdma *rdma,
 		if (!info->ri_pageoff)
 			head->rc_page_count++;
 
-		sg_set_page(sg, rqstp->rq_pages[info->ri_pageno],
+		sg_set_page(sg, rqstp->rq_pages[head->rc_curpage],
 			    seg_len, info->ri_pageoff);
 		sg = sg_next(sg);
 
 		info->ri_pageoff += seg_len;
 		if (info->ri_pageoff == PAGE_SIZE) {
-			info->ri_pageno++;
+			head->rc_curpage++;
 			info->ri_pageoff = 0;
 		}
 		len -= seg_len;
 
-		/* Safety check */
-		if (len &&
-		    &rqstp->rq_pages[info->ri_pageno + 1] > rqstp->rq_page_end)
+		if (len && ((head->rc_curpage + 1) > ARRAY_SIZE(rqstp->rq_pages)))
 			goto out_overrun;
 	}
 
@@ -748,7 +745,7 @@ static int svc_rdma_build_read_segment(struct svcxprt_rdma *rdma,
 	return 0;
 
 out_overrun:
-	trace_svcrdma_page_overrun_err(&cc->cc_cid, info->ri_pageno);
+	trace_svcrdma_page_overrun_err(&cc->cc_cid, head->rc_curpage);
 	return -EINVAL;
 }
 
@@ -790,7 +787,7 @@ static int svc_rdma_build_read_chunk(struct svcxprt_rdma *rdma,
  *
  * Take a page at a time from rqstp->rq_pages and copy the inline
  * content from the Receive buffer into that page. Update
- * info->ri_pageno and info->ri_pageoff so that the next RDMA Read
+ * head->rc_curpage and info->ri_pageoff so that the next RDMA Read
  * result will land contiguously with the copied content.
  *
  * Return values:
@@ -816,13 +813,13 @@ static int svc_rdma_copy_inline_range(struct svc_rdma_read_info *info,
 		if (!info->ri_pageoff)
 			head->rc_page_count++;
 
-		dst = page_address(rqstp->rq_pages[info->ri_pageno]);
-		memcpy(dst + info->ri_pageno, src + offset, page_len);
+		dst = page_address(rqstp->rq_pages[head->rc_curpage]);
+		memcpy(dst + head->rc_curpage, src + offset, page_len);
 
 		head->rc_readbytes += page_len;
 		info->ri_pageoff += page_len;
 		if (info->ri_pageoff == PAGE_SIZE) {
-			info->ri_pageno++;
+			head->rc_curpage++;
 			info->ri_pageoff = 0;
 		}
 		remaining -= page_len;
@@ -1137,10 +1134,10 @@ int svc_rdma_process_read_list(struct svcxprt_rdma *rdma,
 		return -ENOMEM;
 	info->ri_rqst = rqstp;
 	info->ri_readctxt = head;
-	info->ri_pageno = 0;
 	info->ri_pageoff = 0;
 	svc_rdma_cc_init(rdma, cc);
 	cc->cc_cqe.done = svc_rdma_wc_read_done;
+	head->rc_curpage = 0;
 	head->rc_readbytes = 0;
 
 	if (pcl_is_empty(&head->rc_call_pcl)) {




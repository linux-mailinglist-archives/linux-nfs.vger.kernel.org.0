Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2164734D295
	for <lists+linux-nfs@lfdr.de>; Mon, 29 Mar 2021 16:41:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231184AbhC2Okp (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 29 Mar 2021 10:40:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:40492 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230424AbhC2OkS (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Mon, 29 Mar 2021 10:40:18 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 457E461933;
        Mon, 29 Mar 2021 14:40:18 +0000 (UTC)
Subject: [PATCH v1 5/6] svcrdma: Remove svc_rdma_recv_ctxt::rc_pages and
 ::rc_arg
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org, linux-rdma@vger.kernel.org
Date:   Mon, 29 Mar 2021 10:40:17 -0400
Message-ID: <161702881750.5937.13910113536504150681.stgit@klimt.1015granger.net>
In-Reply-To: <161702808762.5937.3596341039481819410.stgit@klimt.1015granger.net>
References: <161702808762.5937.3596341039481819410.stgit@klimt.1015granger.net>
User-Agent: StGit/1.0-5-g755c
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

These fields are no longer used.

The size of struct svc_rdma_recv_ctxt is now less than 300 bytes on
x86_64, down from 2440 bytes.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 include/linux/sunrpc/svc_rdma.h         |    3 ---
 net/sunrpc/xprtrdma/svc_rdma_recvfrom.c |    5 -----
 net/sunrpc/xprtrdma/svc_rdma_rw.c       |   12 ------------
 3 files changed, 20 deletions(-)

diff --git a/include/linux/sunrpc/svc_rdma.h b/include/linux/sunrpc/svc_rdma.h
index b72f75091404..3184465de3a0 100644
--- a/include/linux/sunrpc/svc_rdma.h
+++ b/include/linux/sunrpc/svc_rdma.h
@@ -134,7 +134,6 @@ struct svc_rdma_recv_ctxt {
 	struct rpc_rdma_cid	rc_cid;
 	struct ib_sge		rc_recv_sge;
 	void			*rc_recv_buf;
-	struct xdr_buf		rc_arg;
 	struct xdr_stream	rc_stream;
 	bool			rc_temp;
 	u32			rc_byte_len;
@@ -148,8 +147,6 @@ struct svc_rdma_recv_ctxt {
 	struct svc_rdma_chunk	*rc_cur_result_payload;
 	struct svc_rdma_pcl	rc_write_pcl;
 	struct svc_rdma_pcl	rc_reply_pcl;
-
-	struct page		*rc_pages[RPCSVC_MAXPAGES];
 };
 
 struct svc_rdma_send_ctxt {
diff --git a/net/sunrpc/xprtrdma/svc_rdma_recvfrom.c b/net/sunrpc/xprtrdma/svc_rdma_recvfrom.c
index 7c7eca07b965..357e3ae01991 100644
--- a/net/sunrpc/xprtrdma/svc_rdma_recvfrom.c
+++ b/net/sunrpc/xprtrdma/svc_rdma_recvfrom.c
@@ -227,11 +227,6 @@ struct svc_rdma_recv_ctxt *svc_rdma_recv_ctxt_get(struct svcxprt_rdma *rdma)
 void svc_rdma_recv_ctxt_put(struct svcxprt_rdma *rdma,
 			    struct svc_rdma_recv_ctxt *ctxt)
 {
-	unsigned int i;
-
-	for (i = 0; i < ctxt->rc_page_count; i++)
-		put_page(ctxt->rc_pages[i]);
-
 	pcl_free(&ctxt->rc_call_pcl);
 	pcl_free(&ctxt->rc_read_pcl);
 	pcl_free(&ctxt->rc_write_pcl);
diff --git a/net/sunrpc/xprtrdma/svc_rdma_rw.c b/net/sunrpc/xprtrdma/svc_rdma_rw.c
index 9163ab690288..11a7d4b6209e 100644
--- a/net/sunrpc/xprtrdma/svc_rdma_rw.c
+++ b/net/sunrpc/xprtrdma/svc_rdma_rw.c
@@ -1083,18 +1083,6 @@ int svc_rdma_process_read_list(struct svcxprt_rdma *rdma,
 	struct svc_rdma_chunk_ctxt *cc;
 	int ret;
 
-	/* The request (with page list) is constructed in
-	 * head->rc_arg. Pages involved with RDMA Read I/O are
-	 * transferred there.
-	 */
-	head->rc_arg.head[0] = rqstp->rq_arg.head[0];
-	head->rc_arg.tail[0] = rqstp->rq_arg.tail[0];
-	head->rc_arg.pages = head->rc_pages;
-	head->rc_arg.page_base = 0;
-	head->rc_arg.page_len = 0;
-	head->rc_arg.len = rqstp->rq_arg.len;
-	head->rc_arg.buflen = rqstp->rq_arg.buflen;
-
 	info = svc_rdma_read_info_alloc(rdma);
 	if (!info)
 		return -ENOMEM;



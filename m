Return-Path: <linux-nfs+bounces-11626-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 107D2AB1CFF
	for <lists+linux-nfs@lfdr.de>; Fri,  9 May 2025 21:04:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D5FD83BD538
	for <lists+linux-nfs@lfdr.de>; Fri,  9 May 2025 19:03:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDD34242D7B;
	Fri,  9 May 2025 19:04:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="orSrkBGk"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A581A24290C;
	Fri,  9 May 2025 19:04:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746817440; cv=none; b=RKoqAmzLM0DWRmT+OaD4PqtzxrC9e1h/esPOsQLdLbNEQRA8EwwleAxthU7nXsqcXVxdarK21TaLhG2HYOv2p4fmbT1hxN/EytPlwR4HEPjc6rri6z7jGIJPqGWd5Mvhm+/KNKsQSzxOVrCVH+JrOMqCmgUDqv9IOY+uhD7/WdQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746817440; c=relaxed/simple;
	bh=ZItcwgnBYLvGr2l5WjWrRX0djA+UuiM59+++SRMNyj4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IYRdbqH2a+jO1HJl22o3rHlY6LJc9GnGJagrcLkEvbM9F1BXR8qBwYXXI/taUEGzzutzbonWwrPxTjhslmU14k7DmXVAmQzVNIaouaAWXt7qMxtE5Gq00x73GzK7ac1xsoKOpqCVq3tR200Ypx+hQheESHVeVqNyA/YPgdo9RsA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=orSrkBGk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E8BDC4CEE9;
	Fri,  9 May 2025 19:03:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746817440;
	bh=ZItcwgnBYLvGr2l5WjWrRX0djA+UuiM59+++SRMNyj4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=orSrkBGk+D1ooMfQLtsfhFK2uPd4pMa/10sTe92TlkuGsW9M2H/xHFeooDfPu6zld
	 HQO9Id8W5WhGNBbl1MQIVbd5a2xBtz6MDQGM50jz/UjGcip8gD1rDJvTrwIi2DpBCt
	 BHWMkncxYkSnxRqahfBPmC+9ukDJY7eWPmA0pFgIIpEKH+Z18JmFOP6QO0DY7kOLWG
	 ZJt/Yj3t45X9zHi4dPGujLlM+Yc+aMB5jwP7bI7YqNNf3JHrOQZyfgTp6hJiefKeXS
	 1PjFhBgiBTL5u479ISH46YgpuKHw6hnC1pp0ZyI2EZaGxthdct4ejLt429g1QbRxK7
	 nEjvMASsy6xNw==
From: cel@kernel.org
To: NeilBrown <neil@brown.name>,
	Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>
Cc: <linux-nfs@vger.kernel.org>,
	<linux-rdma@vger.kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>
Subject: [PATCH v5 04/19] sunrpc: Replace the rq_pages array with dynamically-allocated memory
Date: Fri,  9 May 2025 15:03:38 -0400
Message-ID: <20250509190354.5393-5-cel@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250509190354.5393-1-cel@kernel.org>
References: <20250509190354.5393-1-cel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chuck Lever <chuck.lever@oracle.com>

As a step towards making NFSD's maximum rsize and wsize variable at
run-time, replace the fixed-size rq_vec[] array in struct svc_rqst
with a chunk of dynamically-allocated memory.

On a system with 8-byte pointers and 4KB pages, pahole reports that
the rq_pages[] array is 2080 bytes. This patch replaces that with
a single 8-byte pointer field.

Reviewed-by: Jeff Layton <jlayton@kernel.org>
Reviewed-by: NeilBrown <neil@brown.name>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 include/linux/sunrpc/svc.h        |  3 ++-
 net/sunrpc/svc.c                  | 31 +++++++++++++++++--------------
 net/sunrpc/svc_xprt.c             | 10 +---------
 net/sunrpc/xprtrdma/svc_rdma_rw.c |  2 +-
 4 files changed, 21 insertions(+), 25 deletions(-)

diff --git a/include/linux/sunrpc/svc.h b/include/linux/sunrpc/svc.h
index 749f8e53e8a6..57be69539888 100644
--- a/include/linux/sunrpc/svc.h
+++ b/include/linux/sunrpc/svc.h
@@ -205,7 +205,8 @@ struct svc_rqst {
 	struct xdr_stream	rq_res_stream;
 	struct page		*rq_scratch_page;
 	struct xdr_buf		rq_res;
-	struct page		*rq_pages[RPCSVC_MAXPAGES + 1];
+	unsigned long		rq_maxpages;	/* num of entries in rq_pages */
+	struct page *		*rq_pages;
 	struct page *		*rq_respages;	/* points into rq_pages */
 	struct page *		*rq_next_page; /* next reply page to use */
 	struct page *		*rq_page_end;  /* one past the last page */
diff --git a/net/sunrpc/svc.c b/net/sunrpc/svc.c
index 8ce3e6b3df6a..d320837e09f0 100644
--- a/net/sunrpc/svc.c
+++ b/net/sunrpc/svc.c
@@ -636,20 +636,22 @@ svc_destroy(struct svc_serv **servp)
 EXPORT_SYMBOL_GPL(svc_destroy);
 
 static bool
-svc_init_buffer(struct svc_rqst *rqstp, unsigned int size, int node)
+svc_init_buffer(struct svc_rqst *rqstp, const struct svc_serv *serv, int node)
 {
-	unsigned long pages, ret;
+	unsigned long ret;
 
-	pages = size / PAGE_SIZE + 1; /* extra page as we hold both request and reply.
-				       * We assume one is at most one page
-				       */
-	WARN_ON_ONCE(pages > RPCSVC_MAXPAGES);
-	if (pages > RPCSVC_MAXPAGES)
-		pages = RPCSVC_MAXPAGES;
+	rqstp->rq_maxpages = svc_serv_maxpages(serv);
 
-	ret = alloc_pages_bulk_node(GFP_KERNEL, node, pages,
+	/* rq_pages' last entry is NULL for historical reasons. */
+	rqstp->rq_pages = kcalloc_node(rqstp->rq_maxpages + 1,
+				       sizeof(struct page *),
+				       GFP_KERNEL, node);
+	if (!rqstp->rq_pages)
+		return false;
+
+	ret = alloc_pages_bulk_node(GFP_KERNEL, node, rqstp->rq_maxpages,
 				    rqstp->rq_pages);
-	return ret == pages;
+	return ret == rqstp->rq_maxpages;
 }
 
 /*
@@ -658,11 +660,12 @@ svc_init_buffer(struct svc_rqst *rqstp, unsigned int size, int node)
 static void
 svc_release_buffer(struct svc_rqst *rqstp)
 {
-	unsigned int i;
+	unsigned long i;
 
-	for (i = 0; i < ARRAY_SIZE(rqstp->rq_pages); i++)
+	for (i = 0; i < rqstp->rq_maxpages; i++)
 		if (rqstp->rq_pages[i])
 			put_page(rqstp->rq_pages[i]);
+	kfree(rqstp->rq_pages);
 }
 
 static void
@@ -704,7 +707,7 @@ svc_prepare_thread(struct svc_serv *serv, struct svc_pool *pool, int node)
 	if (!rqstp->rq_resp)
 		goto out_enomem;
 
-	if (!svc_init_buffer(rqstp, serv->sv_max_mesg, node))
+	if (!svc_init_buffer(rqstp, serv, node))
 		goto out_enomem;
 
 	rqstp->rq_err = -EAGAIN; /* No error yet */
@@ -896,7 +899,7 @@ EXPORT_SYMBOL_GPL(svc_set_num_threads);
 bool svc_rqst_replace_page(struct svc_rqst *rqstp, struct page *page)
 {
 	struct page **begin = rqstp->rq_pages;
-	struct page **end = &rqstp->rq_pages[RPCSVC_MAXPAGES];
+	struct page **end = &rqstp->rq_pages[rqstp->rq_maxpages];
 
 	if (unlikely(rqstp->rq_next_page < begin || rqstp->rq_next_page > end)) {
 		trace_svc_replace_page_err(rqstp);
diff --git a/net/sunrpc/svc_xprt.c b/net/sunrpc/svc_xprt.c
index 32018557797b..cb14d6ddac6c 100644
--- a/net/sunrpc/svc_xprt.c
+++ b/net/sunrpc/svc_xprt.c
@@ -652,18 +652,10 @@ static void svc_check_conn_limits(struct svc_serv *serv)
 
 static bool svc_alloc_arg(struct svc_rqst *rqstp)
 {
-	struct svc_serv *serv = rqstp->rq_server;
 	struct xdr_buf *arg = &rqstp->rq_arg;
 	unsigned long pages, filled, ret;
 
-	pages = (serv->sv_max_mesg + 2 * PAGE_SIZE) >> PAGE_SHIFT;
-	if (pages > RPCSVC_MAXPAGES) {
-		pr_warn_once("svc: warning: pages=%lu > RPCSVC_MAXPAGES=%lu\n",
-			     pages, RPCSVC_MAXPAGES);
-		/* use as many pages as possible */
-		pages = RPCSVC_MAXPAGES;
-	}
-
+	pages = rqstp->rq_maxpages;
 	for (filled = 0; filled < pages; filled = ret) {
 		ret = alloc_pages_bulk(GFP_KERNEL, pages, rqstp->rq_pages);
 		if (ret > filled)
diff --git a/net/sunrpc/xprtrdma/svc_rdma_rw.c b/net/sunrpc/xprtrdma/svc_rdma_rw.c
index 40797114d50a..661b3fe2779f 100644
--- a/net/sunrpc/xprtrdma/svc_rdma_rw.c
+++ b/net/sunrpc/xprtrdma/svc_rdma_rw.c
@@ -765,7 +765,7 @@ static int svc_rdma_build_read_segment(struct svc_rqst *rqstp,
 		}
 		len -= seg_len;
 
-		if (len && ((head->rc_curpage + 1) > ARRAY_SIZE(rqstp->rq_pages)))
+		if (len && ((head->rc_curpage + 1) > rqstp->rq_maxpages))
 			goto out_overrun;
 	}
 
-- 
2.49.0



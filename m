Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 50A703C6309
	for <lists+linux-nfs@lfdr.de>; Mon, 12 Jul 2021 20:58:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235253AbhGLTAs (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 12 Jul 2021 15:00:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:54486 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230409AbhGLTAs (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Mon, 12 Jul 2021 15:00:48 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2CAA16120A;
        Mon, 12 Jul 2021 18:57:59 +0000 (UTC)
Subject: [PATCH v4 2/3] SUNRPC: Add svc_rqst_replace_page() API
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org, linux-mm@kvack.org
Cc:     neilb@suse.de
Date:   Mon, 12 Jul 2021 14:57:58 -0400
Message-ID: <162611627845.1416.14661720296610549505.stgit@klimt.1015granger.net>
In-Reply-To: <162611520339.1416.14646909890289253420.stgit@klimt.1015granger.net>
References: <162611520339.1416.14646909890289253420.stgit@klimt.1015granger.net>
User-Agent: StGit/1.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Replacing a page in rq_pages[] requires a get_page(), which is a
bus-locked operation, and a put_page(), which can be even more
costly.

To reduce the cost of replacing a page in rq_pages[], batch the
put_page() operations by collecting "freed" pages in a pagevec,
and then release those pages when the pagevec is full. This
pagevec is also emptied when each RPC completes.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 include/linux/sunrpc/svc.h |    4 ++++
 net/sunrpc/svc.c           |   21 +++++++++++++++++++++
 net/sunrpc/svc_xprt.c      |    3 +++
 3 files changed, 28 insertions(+)

diff --git a/include/linux/sunrpc/svc.h b/include/linux/sunrpc/svc.h
index e91d51ea028b..ab9afbf0a0d8 100644
--- a/include/linux/sunrpc/svc.h
+++ b/include/linux/sunrpc/svc.h
@@ -19,6 +19,7 @@
 #include <linux/sunrpc/svcauth.h>
 #include <linux/wait.h>
 #include <linux/mm.h>
+#include <linux/pagevec.h>
 
 /* statistics for svc_pool structures */
 struct svc_pool_stats {
@@ -256,6 +257,7 @@ struct svc_rqst {
 	struct page *		*rq_next_page; /* next reply page to use */
 	struct page *		*rq_page_end;  /* one past the last page */
 
+	struct pagevec		rq_pvec;
 	struct kvec		rq_vec[RPCSVC_MAXPAGES]; /* generally useful.. */
 	struct bio_vec		rq_bvec[RPCSVC_MAXPAGES];
 
@@ -502,6 +504,8 @@ struct svc_rqst *svc_rqst_alloc(struct svc_serv *serv,
 					struct svc_pool *pool, int node);
 struct svc_rqst *svc_prepare_thread(struct svc_serv *serv,
 					struct svc_pool *pool, int node);
+void		   svc_rqst_replace_page(struct svc_rqst *rqstp,
+					 struct page *page);
 void		   svc_rqst_free(struct svc_rqst *);
 void		   svc_exit_thread(struct svc_rqst *);
 unsigned int	   svc_pool_map_get(void);
diff --git a/net/sunrpc/svc.c b/net/sunrpc/svc.c
index 0de918cb3d90..d2d412d43827 100644
--- a/net/sunrpc/svc.c
+++ b/net/sunrpc/svc.c
@@ -838,6 +838,27 @@ svc_set_num_threads_sync(struct svc_serv *serv, struct svc_pool *pool, int nrser
 }
 EXPORT_SYMBOL_GPL(svc_set_num_threads_sync);
 
+/**
+ * svc_rqst_replace_page - Replace one page in rq_pages[]
+ * @rqstp: svc_rqst with pages to replace
+ * @page: replacement page
+ *
+ * When replacing a page in rq_pages, batch the release of the
+ * replaced pages to avoid hammering the page allocator.
+ */
+void svc_rqst_replace_page(struct svc_rqst *rqstp, struct page *page)
+{
+	if (*rqstp->rq_next_page) {
+		if (!pagevec_space(&rqstp->rq_pvec))
+			__pagevec_release(&rqstp->rq_pvec);
+		pagevec_add(&rqstp->rq_pvec, *rqstp->rq_next_page);
+	}
+
+	get_page(page);
+	*(rqstp->rq_next_page++) = page;
+}
+EXPORT_SYMBOL_GPL(svc_rqst_replace_page);
+
 /*
  * Called from a server thread as it's exiting. Caller must hold the "service
  * mutex" for the service.
diff --git a/net/sunrpc/svc_xprt.c b/net/sunrpc/svc_xprt.c
index d66a8e44a1ae..682058a5ec13 100644
--- a/net/sunrpc/svc_xprt.c
+++ b/net/sunrpc/svc_xprt.c
@@ -539,6 +539,7 @@ static void svc_xprt_release(struct svc_rqst *rqstp)
 	kfree(rqstp->rq_deferred);
 	rqstp->rq_deferred = NULL;
 
+	pagevec_release(&rqstp->rq_pvec);
 	svc_free_res_pages(rqstp);
 	rqstp->rq_res.page_len = 0;
 	rqstp->rq_res.page_base = 0;
@@ -664,6 +665,8 @@ static int svc_alloc_arg(struct svc_rqst *rqstp)
 	struct xdr_buf *arg = &rqstp->rq_arg;
 	unsigned long pages, filled;
 
+	pagevec_init(&rqstp->rq_pvec);
+
 	pages = (serv->sv_max_mesg + 2 * PAGE_SIZE) >> PAGE_SHIFT;
 	if (pages > RPCSVC_MAXPAGES) {
 		pr_warn_once("svc: warning: pages=%lu > RPCSVC_MAXPAGES=%lu\n",



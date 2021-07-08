Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9EA433C15EC
	for <lists+linux-nfs@lfdr.de>; Thu,  8 Jul 2021 17:26:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231910AbhGHP3M (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 8 Jul 2021 11:29:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:51144 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231990AbhGHP3M (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Thu, 8 Jul 2021 11:29:12 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id D6AF361450;
        Thu,  8 Jul 2021 15:26:29 +0000 (UTC)
Subject: [PATCH v3 2/3] SUNRPC: Add svc_rqst_replace_page() API
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org, linux-mm@kvack.org
Cc:     neilb@suse.de
Date:   Thu, 08 Jul 2021 11:26:29 -0400
Message-ID: <162575798916.2532.6898942885852856593.stgit@klimt.1015granger.net>
In-Reply-To: <162575623717.2532.8517369487503961860.stgit@klimt.1015granger.net>
References: <162575623717.2532.8517369487503961860.stgit@klimt.1015granger.net>
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

To reduce the cost of replacing a page, batch the put_page()
operations by collecting "free" pages in an array, and then
passing them to release_pages() when the array becomes full.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 include/linux/sunrpc/svc.h |    5 +++++
 net/sunrpc/svc.c           |   29 +++++++++++++++++++++++++++++
 2 files changed, 34 insertions(+)

diff --git a/include/linux/sunrpc/svc.h b/include/linux/sunrpc/svc.h
index e91d51ea028b..68a9f51e2624 100644
--- a/include/linux/sunrpc/svc.h
+++ b/include/linux/sunrpc/svc.h
@@ -256,6 +256,9 @@ struct svc_rqst {
 	struct page *		*rq_next_page; /* next reply page to use */
 	struct page *		*rq_page_end;  /* one past the last page */
 
+	struct page		*rq_relpages[16];
+	int			rq_numrelpages;
+
 	struct kvec		rq_vec[RPCSVC_MAXPAGES]; /* generally useful.. */
 	struct bio_vec		rq_bvec[RPCSVC_MAXPAGES];
 
@@ -502,6 +505,8 @@ struct svc_rqst *svc_rqst_alloc(struct svc_serv *serv,
 					struct svc_pool *pool, int node);
 struct svc_rqst *svc_prepare_thread(struct svc_serv *serv,
 					struct svc_pool *pool, int node);
+void		   svc_rqst_replace_page(struct svc_rqst *rqstp,
+					 struct page *page);
 void		   svc_rqst_free(struct svc_rqst *);
 void		   svc_exit_thread(struct svc_rqst *);
 unsigned int	   svc_pool_map_get(void);
diff --git a/net/sunrpc/svc.c b/net/sunrpc/svc.c
index 0de918cb3d90..3679830cf123 100644
--- a/net/sunrpc/svc.c
+++ b/net/sunrpc/svc.c
@@ -21,6 +21,7 @@
 #include <linux/module.h>
 #include <linux/kthread.h>
 #include <linux/slab.h>
+#include <linux/pagemap.h>
 
 #include <linux/sunrpc/types.h>
 #include <linux/sunrpc/xdr.h>
@@ -838,6 +839,33 @@ svc_set_num_threads_sync(struct svc_serv *serv, struct svc_pool *pool, int nrser
 }
 EXPORT_SYMBOL_GPL(svc_set_num_threads_sync);
 
+static void svc_rqst_release_replaced_pages(struct svc_rqst *rqstp)
+{
+	release_pages(rqstp->rq_relpages, rqstp->rq_numrelpages);
+	rqstp->rq_numrelpages = 0;
+}
+
+/**
+ * svc_rqst_replace_page - Replace one page in rq_pages[]
+ * @rqstp: svc_rqst with pages to replace
+ * @page: replacement page
+ *
+ * When replacing a page in rq_pages, batch the release of the
+ * replaced pages to avoid hammering put_page().
+ */
+void svc_rqst_replace_page(struct svc_rqst *rqstp, struct page *page)
+{
+	if (*rqstp->rq_next_page) {
+		if (rqstp->rq_numrelpages >= ARRAY_SIZE(rqstp->rq_relpages))
+			svc_rqst_release_replaced_pages(rqstp);
+		rqstp->rq_relpages[rqstp->rq_numrelpages++] = *rqstp->rq_next_page;
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
@@ -846,6 +874,7 @@ void
 svc_rqst_free(struct svc_rqst *rqstp)
 {
 	svc_release_buffer(rqstp);
+	svc_rqst_release_replaced_pages(rqstp);
 	if (rqstp->rq_scratch_page)
 		put_page(rqstp->rq_scratch_page);
 	kfree(rqstp->rq_resp);



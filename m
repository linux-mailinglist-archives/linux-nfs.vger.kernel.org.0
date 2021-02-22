Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A94E321B5F
	for <lists+linux-nfs@lfdr.de>; Mon, 22 Feb 2021 16:27:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230071AbhBVP0U (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 22 Feb 2021 10:26:20 -0500
Received: from mail.kernel.org ([198.145.29.99]:56790 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230084AbhBVPYL (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Mon, 22 Feb 2021 10:24:11 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 287FD64E61;
        Mon, 22 Feb 2021 15:23:28 +0000 (UTC)
Subject: [PATCH v2 4/4] SUNRPC: Cache pages that were replaced during a read
 splice
From:   Chuck Lever <chuck.lever@oracle.com>
To:     mgorman@techsingularity.net
Cc:     linux-nfs@vger.kernel.org, linux-mm@kvack.org, kuba@kernel.org
Date:   Mon, 22 Feb 2021 10:23:27 -0500
Message-ID: <161400740732.195066.3792261943053910900.stgit@klimt.1015granger.net>
In-Reply-To: <161400722731.195066.9584156841718557193.stgit@klimt.1015granger.net>
References: <161400722731.195066.9584156841718557193.stgit@klimt.1015granger.net>
User-Agent: StGit/1.0-5-g755c
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

To avoid extra trips to the page allocator, don't free unused pages
in nfsd_splice_actor(), but instead place them in a local cache.
That cache is then used first when refilling rq_pages.

On workloads that perform large NFS READs on splice-capable file
systems, this saves a considerable amount of work.

Suggested-by: NeilBrown <neilb@suse.de>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/vfs.c                   |    4 ++--
 include/linux/sunrpc/svc.h      |    1 +
 include/linux/sunrpc/svc_xprt.h |   28 ++++++++++++++++++++++++++++
 net/sunrpc/svc.c                |    7 +++++++
 net/sunrpc/svc_xprt.c           |   12 ++++++++++++
 5 files changed, 50 insertions(+), 2 deletions(-)

diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
index d316e11923c5..25cf41eaf3c4 100644
--- a/fs/nfsd/vfs.c
+++ b/fs/nfsd/vfs.c
@@ -852,14 +852,14 @@ nfsd_splice_actor(struct pipe_inode_info *pipe, struct pipe_buffer *buf,
 
 	if (rqstp->rq_res.page_len == 0) {
 		get_page(page);
-		put_page(*rqstp->rq_next_page);
+		svc_rqst_put_unused_page(rqstp, *rqstp->rq_next_page);
 		*(rqstp->rq_next_page++) = page;
 		rqstp->rq_res.page_base = buf->offset;
 		rqstp->rq_res.page_len = size;
 	} else if (page != pp[-1]) {
 		get_page(page);
 		if (*rqstp->rq_next_page)
-			put_page(*rqstp->rq_next_page);
+			svc_rqst_put_unused_page(rqstp, *rqstp->rq_next_page);
 		*(rqstp->rq_next_page++) = page;
 		rqstp->rq_res.page_len += size;
 	} else
diff --git a/include/linux/sunrpc/svc.h b/include/linux/sunrpc/svc.h
index 31ee3b6047c3..340f4f3989c0 100644
--- a/include/linux/sunrpc/svc.h
+++ b/include/linux/sunrpc/svc.h
@@ -250,6 +250,7 @@ struct svc_rqst {
 	struct xdr_stream	rq_arg_stream;
 	struct page		*rq_scratch_page;
 	struct xdr_buf		rq_res;
+	struct list_head	rq_unused_pages;
 	struct page		*rq_pages[RPCSVC_MAXPAGES + 1];
 	struct page *		*rq_respages;	/* points into rq_pages */
 	struct page *		*rq_next_page; /* next reply page to use */
diff --git a/include/linux/sunrpc/svc_xprt.h b/include/linux/sunrpc/svc_xprt.h
index 571f605bc91e..49ef86499876 100644
--- a/include/linux/sunrpc/svc_xprt.h
+++ b/include/linux/sunrpc/svc_xprt.h
@@ -150,6 +150,34 @@ static inline void svc_xprt_get(struct svc_xprt *xprt)
 {
 	kref_get(&xprt->xpt_ref);
 }
+
+/**
+ * svc_rqst_get_unused_page - Tap a page from the local cache
+ * @rqstp: svc_rqst with cached unused pages
+ *
+ * To save an allocator round trip, pages can be added to a
+ * local cache and re-used later by svc_alloc_arg().
+ *
+ * Returns an unused page, or NULL if the cache is empty.
+ */
+static inline struct page *svc_rqst_get_unused_page(struct svc_rqst *rqstp)
+{
+	return list_first_entry_or_null(&rqstp->rq_unused_pages,
+					struct page, lru);
+}
+
+/**
+ * svc_rqst_put_unused_page - Stash a page in the local cache
+ * @rqstp: svc_rqst with cached unused pages
+ * @page: page to cache
+ *
+ */
+static inline void svc_rqst_put_unused_page(struct svc_rqst *rqstp,
+					    struct page *page)
+{
+	list_add(&page->lru, &rqstp->rq_unused_pages);
+}
+
 static inline void svc_xprt_set_local(struct svc_xprt *xprt,
 				      const struct sockaddr *sa,
 				      const size_t salen)
diff --git a/net/sunrpc/svc.c b/net/sunrpc/svc.c
index 61fb8a18552c..3920fa8f1146 100644
--- a/net/sunrpc/svc.c
+++ b/net/sunrpc/svc.c
@@ -570,6 +570,8 @@ svc_init_buffer(struct svc_rqst *rqstp, unsigned int size, int node)
 	if (svc_is_backchannel(rqstp))
 		return 1;
 
+	INIT_LIST_HEAD(&rqstp->rq_unused_pages);
+
 	pages = size / PAGE_SIZE + 1; /* extra page as we hold both request and reply.
 				       * We assume one is at most one page
 				       */
@@ -593,8 +595,13 @@ svc_init_buffer(struct svc_rqst *rqstp, unsigned int size, int node)
 static void
 svc_release_buffer(struct svc_rqst *rqstp)
 {
+	struct page *page;
 	unsigned int i;
 
+	while ((page = svc_rqst_get_unused_page(rqstp))) {
+		list_del(&page->lru);
+		put_page(page);
+	}
 	for (i = 0; i < ARRAY_SIZE(rqstp->rq_pages); i++)
 		if (rqstp->rq_pages[i])
 			put_page(rqstp->rq_pages[i]);
diff --git a/net/sunrpc/svc_xprt.c b/net/sunrpc/svc_xprt.c
index 15aacfa5ca21..84210e546a66 100644
--- a/net/sunrpc/svc_xprt.c
+++ b/net/sunrpc/svc_xprt.c
@@ -678,6 +678,18 @@ static int svc_alloc_arg(struct svc_rqst *rqstp)
 	for (needed = 0, i = 0; i < pages ; i++)
 		if (!rqstp->rq_pages[i])
 			needed++;
+	if (needed) {
+		for (i = 0; i < pages; i++) {
+			if (!rqstp->rq_pages[i]) {
+				page = svc_rqst_get_unused_page(rqstp);
+				if (!page)
+					break;
+				list_del(&page->lru);
+				rqstp->rq_pages[i] = page;
+				needed--;
+			}
+		}
+	}
 	if (needed) {
 		LIST_HEAD(list);
 



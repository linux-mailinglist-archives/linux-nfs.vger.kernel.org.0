Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 46634321B5E
	for <lists+linux-nfs@lfdr.de>; Mon, 22 Feb 2021 16:27:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231667AbhBVP0K (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 22 Feb 2021 10:26:10 -0500
Received: from mail.kernel.org ([198.145.29.99]:56732 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230512AbhBVPYE (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Mon, 22 Feb 2021 10:24:04 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id B5AAC64EDB;
        Mon, 22 Feb 2021 15:23:21 +0000 (UTC)
Subject: [PATCH v2 3/4] SUNRPC: Refresh rq_pages using a bulk page allocator
From:   Chuck Lever <chuck.lever@oracle.com>
To:     mgorman@techsingularity.net
Cc:     linux-nfs@vger.kernel.org, linux-mm@kvack.org, kuba@kernel.org
Date:   Mon, 22 Feb 2021 10:23:20 -0500
Message-ID: <161400740085.195066.4366772800812293165.stgit@klimt.1015granger.net>
In-Reply-To: <161400722731.195066.9584156841718557193.stgit@klimt.1015granger.net>
References: <161400722731.195066.9584156841718557193.stgit@klimt.1015granger.net>
User-Agent: StGit/1.0-5-g755c
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Reduce the rate at which nfsd threads hammer on the page allocator.
This improve throughput scalability by enabling the threads to run
more independently of each other.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 net/sunrpc/svc_xprt.c |   43 +++++++++++++++++++++++++++++++------------
 1 file changed, 31 insertions(+), 12 deletions(-)

diff --git a/net/sunrpc/svc_xprt.c b/net/sunrpc/svc_xprt.c
index 819e46ab0a4a..15aacfa5ca21 100644
--- a/net/sunrpc/svc_xprt.c
+++ b/net/sunrpc/svc_xprt.c
@@ -661,11 +661,12 @@ static void svc_check_conn_limits(struct svc_serv *serv)
 static int svc_alloc_arg(struct svc_rqst *rqstp)
 {
 	struct svc_serv *serv = rqstp->rq_server;
+	unsigned long needed;
 	struct xdr_buf *arg;
+	struct page *page;
 	int pages;
 	int i;
 
-	/* now allocate needed pages.  If we get a failure, sleep briefly */
 	pages = (serv->sv_max_mesg + 2 * PAGE_SIZE) >> PAGE_SHIFT;
 	if (pages > RPCSVC_MAXPAGES) {
 		pr_warn_once("svc: warning: pages=%u > RPCSVC_MAXPAGES=%lu\n",
@@ -673,19 +674,28 @@ static int svc_alloc_arg(struct svc_rqst *rqstp)
 		/* use as many pages as possible */
 		pages = RPCSVC_MAXPAGES;
 	}
-	for (i = 0; i < pages ; i++)
-		while (rqstp->rq_pages[i] == NULL) {
-			struct page *p = alloc_page(GFP_KERNEL);
-			if (!p) {
-				set_current_state(TASK_INTERRUPTIBLE);
-				if (signalled() || kthread_should_stop()) {
-					set_current_state(TASK_RUNNING);
-					return -EINTR;
-				}
-				schedule_timeout(msecs_to_jiffies(500));
+
+	for (needed = 0, i = 0; i < pages ; i++)
+		if (!rqstp->rq_pages[i])
+			needed++;
+	if (needed) {
+		LIST_HEAD(list);
+
+retry:
+		alloc_pages_bulk(GFP_KERNEL, 0, needed, &list);
+		for (i = 0; i < pages; i++) {
+			if (!rqstp->rq_pages[i]) {
+				page = list_first_entry_or_null(&list,
+								struct page,
+								lru);
+				if (unlikely(!page))
+					goto empty_list;
+				list_del(&page->lru);
+				rqstp->rq_pages[i] = page;
+				needed--;
 			}
-			rqstp->rq_pages[i] = p;
 		}
+	}
 	rqstp->rq_page_end = &rqstp->rq_pages[pages];
 	rqstp->rq_pages[pages] = NULL; /* this might be seen in nfsd_splice_actor() */
 
@@ -700,6 +710,15 @@ static int svc_alloc_arg(struct svc_rqst *rqstp)
 	arg->len = (pages-1)*PAGE_SIZE;
 	arg->tail[0].iov_len = 0;
 	return 0;
+
+empty_list:
+	set_current_state(TASK_INTERRUPTIBLE);
+	if (signalled() || kthread_should_stop()) {
+		set_current_state(TASK_RUNNING);
+		return -EINTR;
+	}
+	schedule_timeout(msecs_to_jiffies(500));
+	goto retry;
 }
 
 static bool



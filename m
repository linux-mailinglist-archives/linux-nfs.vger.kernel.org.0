Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A11236BF5F7
	for <lists+linux-nfs@lfdr.de>; Sat, 18 Mar 2023 00:06:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229601AbjCQXGx (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 17 Mar 2023 19:06:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229590AbjCQXGw (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 17 Mar 2023 19:06:52 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1786FBBAD
        for <linux-nfs@vger.kernel.org>; Fri, 17 Mar 2023 16:06:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 73D73B826F3
        for <linux-nfs@vger.kernel.org>; Fri, 17 Mar 2023 23:01:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE202C433D2;
        Fri, 17 Mar 2023 23:01:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679094093;
        bh=FqDfDULg+rObi6ppG11Q+pma/ZaLD8W3624yYDaRCT8=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=tu4CcCqnPonqFIKRa116H9tUOM88frUIWoo4g1aZEirWuS/gXRt+cBfQQUBGMwTJd
         EXwPMQDtlJQgeGcqnPHWn79XcxALeiN/rainot7j5EUP6mm5mk6f5Tis+xaqfBiXW9
         IW16PDxXZhw3Gjx8CohHm+L0uoBjuvRnPEkPOyU2N4Mc947j5WlcW/46Lshm7WEWIE
         zSDt/sLgjhNrAMCMPTu0hP0tC2Q+wmrxU2zyKnVauxLYWzymMm6GimPti0ATV8MAh6
         m5v+spBazEyTtUFwKh/y6Sz3kihowpWvaGnfEQg7+w5kFG+F7I3vJTCBhW73HmAgVo
         CGqUv7axB1yDQ==
Subject: [PATCH v1 2/3] SUNRPC: add bounds checking to svc_rqst_replace_page
From:   Chuck Lever <cel@kernel.org>
To:     linux-nfs@vger.kernel.org
Cc:     viro@zeniv.linux.org.uk, dcritch@redhat.com, d.lesca@solinos.it
Date:   Fri, 17 Mar 2023 19:01:31 -0400
Message-ID: <167909409175.1672.9527418654666808791.stgit@klimt.1015granger.net>
In-Reply-To: <167909365790.1672.13118429954916842449.stgit@klimt.1015granger.net>
References: <167909365790.1672.13118429954916842449.stgit@klimt.1015granger.net>
User-Agent: StGit/1.5
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Chuck Lever <chuck.lever@oracle.com>

There have been several bugs over the years where the NFSD splice
actor has attempted to write outside the rq_pages array.

Suggested-by: Jeff Layton <jlayton@kernel.org>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 include/linux/sunrpc/svc.h    |    2 +-
 include/trace/events/sunrpc.h |   25 +++++++++++++++++++++++++
 net/sunrpc/svc.c              |   15 ++++++++++++++-
 3 files changed, 40 insertions(+), 2 deletions(-)

diff --git a/include/linux/sunrpc/svc.h b/include/linux/sunrpc/svc.h
index 877891536c2f..f5af055280ff 100644
--- a/include/linux/sunrpc/svc.h
+++ b/include/linux/sunrpc/svc.h
@@ -422,7 +422,7 @@ struct svc_serv *svc_create(struct svc_program *, unsigned int,
 			    int (*threadfn)(void *data));
 struct svc_rqst *svc_rqst_alloc(struct svc_serv *serv,
 					struct svc_pool *pool, int node);
-void		   svc_rqst_replace_page(struct svc_rqst *rqstp,
+bool		   svc_rqst_replace_page(struct svc_rqst *rqstp,
 					 struct page *page);
 void		   svc_rqst_free(struct svc_rqst *);
 void		   svc_exit_thread(struct svc_rqst *);
diff --git a/include/trace/events/sunrpc.h b/include/trace/events/sunrpc.h
index 3ca54536f8f7..5a3bb42e1f50 100644
--- a/include/trace/events/sunrpc.h
+++ b/include/trace/events/sunrpc.h
@@ -1790,6 +1790,31 @@ DEFINE_EVENT(svc_rqst_status, svc_send,
 	TP_PROTO(const struct svc_rqst *rqst, int status),
 	TP_ARGS(rqst, status));
 
+TRACE_EVENT(svc_replace_page_err,
+	TP_PROTO(const struct svc_rqst *rqst),
+
+	TP_ARGS(rqst),
+	TP_STRUCT__entry(
+		SVC_RQST_ENDPOINT_FIELDS(rqst)
+
+		__field(const void *, begin)
+		__field(const void *, respages)
+		__field(const void *, nextpage)
+	),
+
+	TP_fast_assign(
+		SVC_RQST_ENDPOINT_ASSIGNMENTS(rqst);
+
+		__entry->begin = rqst->rq_pages;
+		__entry->respages = rqst->rq_respages;
+		__entry->nextpage = rqst->rq_next_page;
+	),
+
+	TP_printk(SVC_RQST_ENDPOINT_FORMAT " begin=%p respages=%p nextpage=%p",
+		SVC_RQST_ENDPOINT_VARARGS,
+		__entry->begin, __entry->respages, __entry->nextpage)
+);
+
 TRACE_EVENT(svc_stats_latency,
 	TP_PROTO(
 		const struct svc_rqst *rqst
diff --git a/net/sunrpc/svc.c b/net/sunrpc/svc.c
index fea7ce8fba14..633aa1eb476b 100644
--- a/net/sunrpc/svc.c
+++ b/net/sunrpc/svc.c
@@ -842,9 +842,21 @@ EXPORT_SYMBOL_GPL(svc_set_num_threads);
  *
  * When replacing a page in rq_pages, batch the release of the
  * replaced pages to avoid hammering the page allocator.
+ *
+ * Return values:
+ *   %true: page replaced
+ *   %false: array bounds checking failed
  */
-void svc_rqst_replace_page(struct svc_rqst *rqstp, struct page *page)
+bool svc_rqst_replace_page(struct svc_rqst *rqstp, struct page *page)
 {
+	struct page **begin = rqstp->rq_pages;
+	struct page **end = &rqstp->rq_pages[RPCSVC_MAXPAGES];
+
+	if (unlikely(rqstp->rq_next_page < begin || rqstp->rq_next_page > end)) {
+		trace_svc_replace_page_err(rqstp);
+		return false;
+	}
+
 	if (*rqstp->rq_next_page) {
 		if (!pagevec_space(&rqstp->rq_pvec))
 			__pagevec_release(&rqstp->rq_pvec);
@@ -853,6 +865,7 @@ void svc_rqst_replace_page(struct svc_rqst *rqstp, struct page *page)
 
 	get_page(page);
 	*(rqstp->rq_next_page++) = page;
+	return true;
 }
 EXPORT_SYMBOL_GPL(svc_rqst_replace_page);
 



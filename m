Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 663A86E2DDE
	for <lists+linux-nfs@lfdr.de>; Sat, 15 Apr 2023 02:18:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229643AbjDOASB (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 14 Apr 2023 20:18:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbjDOASA (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 14 Apr 2023 20:18:00 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA1DC40FB
        for <linux-nfs@vger.kernel.org>; Fri, 14 Apr 2023 17:17:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4470F63856
        for <linux-nfs@vger.kernel.org>; Sat, 15 Apr 2023 00:17:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A180C433A0;
        Sat, 15 Apr 2023 00:17:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681517877;
        bh=w0AGIKncJ+aMWbYsTzdaumoT4rTj66CdiASkX6lZ4UU=;
        h=Subject:From:To:Date:In-Reply-To:References:From;
        b=hXfE/aAz5R89eQvCA4gEJ1LT2dArTmazeb+qhr8Mtd66M5OTM+PGTvU9rdnSeR6Vg
         074TTlq2rc4bDFuQK7AqzwnV8Zl5ifmGeJe/TPUUWrotsP4PD2QuLYXTI9saUYiYjt
         wSjljvZ3yk5NpYqS1z4iRE7Ks4rnxK0Myvax2Zh380qVjPqBqyQTxOKU7xP8Ur2zrs
         IWBmKDIXIWAZJAqA3pmiSo13JBhPGxHGHZoCnjGeg2uV4skBFbMuw6BLbB13t1iNlV
         ja9fRCsIDDXwBVt+1usSOEjYbiY9VX328hIVzOHLo7/PIxsJYooPL/nGq1s8tpQkr0
         ip9uTDQcWasOA==
Subject: [PATCH v1 1/4] SUNRPC: Relocate svc_free_res_pages()
From:   Chuck Lever <cel@kernel.org>
To:     linux-nfs@vger.kernel.org, linux-mm@kvack.org
Date:   Fri, 14 Apr 2023 20:17:56 -0400
Message-ID: <168151787655.1588.13024575588334839763.stgit@klimt.1015granger.net>
In-Reply-To: <168151777579.1588.7882383278745556830.stgit@klimt.1015granger.net>
References: <168151777579.1588.7882383278745556830.stgit@klimt.1015granger.net>
User-Agent: StGit/1.5
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Chuck Lever <chuck.lever@oracle.com>

Clean-up: There doesn't seem to be a reason why this function is
stuck in a header. One thing it prevents is the convenient addition
of tracing. Moving it to a source file also makes the rq_respages
clean-up logic easier to find.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 include/linux/sunrpc/svc.h |   12 +-----------
 net/sunrpc/svc.c           |   19 +++++++++++++++++++
 net/sunrpc/svc_xprt.c      |    2 +-
 3 files changed, 21 insertions(+), 12 deletions(-)

diff --git a/include/linux/sunrpc/svc.h b/include/linux/sunrpc/svc.h
index 2d31121fc2e6..762d7231e574 100644
--- a/include/linux/sunrpc/svc.h
+++ b/include/linux/sunrpc/svc.h
@@ -309,17 +309,6 @@ static inline struct sockaddr *svc_daddr(const struct svc_rqst *rqst)
 	return (struct sockaddr *) &rqst->rq_daddr;
 }
 
-static inline void svc_free_res_pages(struct svc_rqst *rqstp)
-{
-	while (rqstp->rq_next_page != rqstp->rq_respages) {
-		struct page **pp = --rqstp->rq_next_page;
-		if (*pp) {
-			put_page(*pp);
-			*pp = NULL;
-		}
-	}
-}
-
 struct svc_deferred_req {
 	u32			prot;	/* protocol (UDP or TCP) */
 	struct svc_xprt		*xprt;
@@ -424,6 +413,7 @@ struct svc_rqst *svc_rqst_alloc(struct svc_serv *serv,
 					struct svc_pool *pool, int node);
 bool		   svc_rqst_replace_page(struct svc_rqst *rqstp,
 					 struct page *page);
+void		   svc_rqst_release_pages(struct svc_rqst *rqstp);
 void		   svc_rqst_free(struct svc_rqst *);
 void		   svc_exit_thread(struct svc_rqst *);
 struct svc_serv *  svc_create_pooled(struct svc_program *, unsigned int,
diff --git a/net/sunrpc/svc.c b/net/sunrpc/svc.c
index 0aa8892fad63..0fc70cc405b2 100644
--- a/net/sunrpc/svc.c
+++ b/net/sunrpc/svc.c
@@ -869,6 +869,25 @@ bool svc_rqst_replace_page(struct svc_rqst *rqstp, struct page *page)
 }
 EXPORT_SYMBOL_GPL(svc_rqst_replace_page);
 
+/**
+ * svc_rqst_release_pages - Release Reply buffer pages
+ * @rqstp: RPC transaction context
+ *
+ * Release response pages that might still be in flight after
+ * svc_send, and any spliced filesystem-owned pages.
+ */
+void svc_rqst_release_pages(struct svc_rqst *rqstp)
+{
+	while (rqstp->rq_next_page != rqstp->rq_respages) {
+		struct page **pp = --rqstp->rq_next_page;
+
+		if (*pp) {
+			put_page(*pp);
+			*pp = NULL;
+		}
+	}
+}
+
 /*
  * Called from a server thread as it's exiting. Caller must hold the "service
  * mutex" for the service.
diff --git a/net/sunrpc/svc_xprt.c b/net/sunrpc/svc_xprt.c
index 36c79b718323..533e08c4f319 100644
--- a/net/sunrpc/svc_xprt.c
+++ b/net/sunrpc/svc_xprt.c
@@ -542,7 +542,7 @@ static void svc_xprt_release(struct svc_rqst *rqstp)
 	rqstp->rq_deferred = NULL;
 
 	pagevec_release(&rqstp->rq_pvec);
-	svc_free_res_pages(rqstp);
+	svc_rqst_release_pages(rqstp);
 	rqstp->rq_res.page_len = 0;
 	rqstp->rq_res.page_base = 0;
 



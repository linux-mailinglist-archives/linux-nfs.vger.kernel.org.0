Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8EDF4BA55A
	for <lists+linux-nfs@lfdr.de>; Thu, 17 Feb 2022 17:05:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236532AbiBQQGB (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 17 Feb 2022 11:06:01 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:37550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232981AbiBQQFr (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 17 Feb 2022 11:05:47 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBA1C29C124
        for <linux-nfs@vger.kernel.org>; Thu, 17 Feb 2022 08:05:32 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7B9A860B9C
        for <linux-nfs@vger.kernel.org>; Thu, 17 Feb 2022 16:05:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1894C340E9;
        Thu, 17 Feb 2022 16:05:31 +0000 (UTC)
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org
Cc:     neilb@suse.de
Subject: [PATCH v2 2/8] SUNRPC: Merge svc_do_enqueue_xprt() into svc_enqueue_xprt()
Date:   Thu, 17 Feb 2022 11:05:30 -0500
Message-Id:  <164511393035.1361.2516348633484305530.stgit@klimt.1015granger.net>
X-Mailer: git-send-email 2.35.0
In-Reply-To:  <164511349417.1361.12607852846407534019.stgit@klimt.1015granger.net>
References:  <164511349417.1361.12607852846407534019.stgit@klimt.1015granger.net>
User-Agent: StGit/1.5
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=2823; h=from:subject:message-id; bh=WJNTzfojeJSJcbhRdjc7VQTWg8Jof7nqoVyj+XAbljI=; b=owEBbQKS/ZANAwAIATNqszNvZn+XAcsmYgBiDnJK6Tl7y8tb1EenA6a91UGb8P0gHVFmRVNPaUBB Qn6QKCeJAjMEAAEIAB0WIQQosuWwEobfJDzyPv4zarMzb2Z/lwUCYg5ySgAKCRAzarMzb2Z/l7BYD/ wJxpyGFprYHlc9fT/5K7wGgEz003ifgXYpbuxP+Uy+yJly7e5xGmQa6WeOZ/E8d2pExzBh5/OsFStj erDUNmuk3ljpr5W5cqIiDMsfx9f35DNck77+42z61Zw7BnfJ+/FHJnTY1OkUAIVr2qq1IdwUpYcZoL TM3eivyFBjauEi0hhIjNB4a1EwSnslbUi+0LNOgpBVPvQBRhgv7b2WWo2Cr9Rul+Ny15DVqgdzPtTI AgOTT1jxAT/H0Br3C/t/JF2hZIqk3h4G7kDnXP5aoSOo05EjaZHZdmhdm6sWOE5ig7M9KUW0wgTeDx lnx6PjMFzaIpJRXdEqgzDq5Vgk5oINB5oMNzr58pDRv/2wmKg65AyOP3/6vFupGn0jNaZmdbx2bGN5 EAXgVHAPldKCMTFCxYR2ZY26gPf5VWSZI5zGO9K0vLZ71hdntjWPAkCVX4GxqczU7FRXgTLes839tC Ahu+s0PJhgx4/jCR0bcLmb6H9QvdtTNfxM3cxB2SDxBV0iX+Th/8rAe4nbfb4BAwtsv2oQB15Tn2iX fYlSEk2xeL/+lXNQzVbhu4Qzjroq/0VrffmKFyWPYGz/CwXuHVx9/Z8qPiOwJi5C7T+I4ItZIP4lT3 aZVmY/vtGoPxhSpskjxprwZkoOGKGvuUmaNi623dU9/j21/6/EPgrI6iN+Iw==
X-Developer-Key: i=chuck.lever@oracle.com; a=openpgp; fpr=28B2E5B01286DF243CF23EFE336AB3336F667F97
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Neil says:
"These functions were separated in commit 0971374e2818 ("SUNRPC:
Reduce contention in svc_xprt_enqueue()") so that the XPT_BUSY check
happened before taking any spinlocks.

We have since moved or removed the spinlocks so the extra test is
fairly pointless."

I've made this a separate patch in case the XPT_BUSY change has
unexpected consequences and needs to be reverted.

Suggested-by: Neil Brown <neilb@suse.de>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 net/sunrpc/svc_xprt.c |   26 ++++++++++----------------
 1 file changed, 10 insertions(+), 16 deletions(-)

diff --git a/net/sunrpc/svc_xprt.c b/net/sunrpc/svc_xprt.c
index 9fce4f7774bb..1c2295209d08 100644
--- a/net/sunrpc/svc_xprt.c
+++ b/net/sunrpc/svc_xprt.c
@@ -32,7 +32,6 @@ static int svc_deferred_recv(struct svc_rqst *rqstp);
 static struct cache_deferred_req *svc_defer(struct cache_req *req);
 static void svc_age_temp_xprts(struct timer_list *t);
 static void svc_delete_xprt(struct svc_xprt *xprt);
-static void svc_xprt_do_enqueue(struct svc_xprt *xprt);
 
 /* apparently the "standard" is that clients close
  * idle connections after 5 minutes, servers after
@@ -267,12 +266,12 @@ void svc_xprt_received(struct svc_xprt *xprt)
 	}
 
 	/* As soon as we clear busy, the xprt could be closed and
-	 * 'put', so we need a reference to call svc_xprt_do_enqueue with:
+	 * 'put', so we need a reference to call svc_xprt_enqueue with:
 	 */
 	svc_xprt_get(xprt);
 	smp_mb__before_atomic();
 	clear_bit(XPT_BUSY, &xprt->xpt_flags);
-	svc_xprt_do_enqueue(xprt);
+	svc_xprt_enqueue(xprt);
 	svc_xprt_put(xprt);
 }
 EXPORT_SYMBOL_GPL(svc_xprt_received);
@@ -412,6 +411,8 @@ static bool svc_xprt_ready(struct svc_xprt *xprt)
 	smp_rmb();
 	xpt_flags = READ_ONCE(xprt->xpt_flags);
 
+	if (xpt_flags & BIT(XPT_BUSY))
+		return false;
 	if (xpt_flags & (BIT(XPT_CONN) | BIT(XPT_CLOSE)))
 		return true;
 	if (xpt_flags & (BIT(XPT_DATA) | BIT(XPT_DEFERRED))) {
@@ -424,7 +425,12 @@ static bool svc_xprt_ready(struct svc_xprt *xprt)
 	return false;
 }
 
-static void svc_xprt_do_enqueue(struct svc_xprt *xprt)
+/**
+ * svc_xprt_enqueue - Queue a transport on an idle nfsd thread
+ * @xprt: transport with data pending
+ *
+ */
+void svc_xprt_enqueue(struct svc_xprt *xprt)
 {
 	struct svc_pool *pool;
 	struct svc_rqst	*rqstp = NULL;
@@ -468,18 +474,6 @@ static void svc_xprt_do_enqueue(struct svc_xprt *xprt)
 	put_cpu();
 	trace_svc_xprt_enqueue(xprt, rqstp);
 }
-
-/*
- * Queue up a transport with data pending. If there are idle nfsd
- * processes, wake 'em up.
- *
- */
-void svc_xprt_enqueue(struct svc_xprt *xprt)
-{
-	if (test_bit(XPT_BUSY, &xprt->xpt_flags))
-		return;
-	svc_xprt_do_enqueue(xprt);
-}
 EXPORT_SYMBOL_GPL(svc_xprt_enqueue);
 
 /*


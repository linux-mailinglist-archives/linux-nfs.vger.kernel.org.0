Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D36C1425D14
	for <lists+linux-nfs@lfdr.de>; Thu,  7 Oct 2021 22:17:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233953AbhJGUTU (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 7 Oct 2021 16:19:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:49828 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233019AbhJGUTT (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Thu, 7 Oct 2021 16:19:19 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6273560EE0;
        Thu,  7 Oct 2021 20:17:25 +0000 (UTC)
From:   Chuck Lever <chuck.lever@oracle.com>
To:     bfields@redhat.com
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH v2 1/2] SUNRPC: Simplify the SVC dispatch code path
Date:   Thu,  7 Oct 2021 16:17:24 -0400
Message-Id:  <163363784431.2295.7425775268719807693.stgit@bazille.1015granger.net>
X-Mailer: git-send-email 2.33.0.113.g6c40894d24
In-Reply-To:  <163363775944.2295.17512762002999927909.stgit@bazille.1015granger.net>
References:  <163363775944.2295.17512762002999927909.stgit@bazille.1015granger.net>
User-Agent: StGit/1.1+62.ged16
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=3093; h=from:subject:message-id; bh=Bx8EQHVcgEBG6BuCql7S9QqyZaix7P2xw6xFkJjz8YE=; b=owEBbQKS/ZANAwAIATNqszNvZn+XAcsmYgBhX1XUTL0Tob/8SVrwYTSO9tci1tb+ImrGFrF+MQNF zw8t3aqJAjMEAAEIAB0WIQQosuWwEobfJDzyPv4zarMzb2Z/lwUCYV9V1AAKCRAzarMzb2Z/l2QJEA CjT4UZ95+k9QCBohVPChOo27QMlrQMLvWf4UO/BxxL0T3cawmwyjGS32ftK9yjR5EDJzWfy3IF0cIQ h/YGiRRodQkIebwHDRDNvEMQMaphXfu4nmmlhLEYrNHf++l0idQkXiUIUYft/qYWOrEDvI/OAs/1HG Q+II1JBynl4uAyGoflj058hCLIi+/iuVOiONitq5UG9jYqD4jBMH78qEcmFDXrrnbL78CDc0dzUWKX eUfTAbplhZ5hQO8UnZDiRHy8kLaDKjjM6tMxdNAcTwI7XWAM7TFPhgUgNjnUY1V+g/Ua5ybFSpm5K2 NiFpO+gBBW3spaeNfdvfhuNSYnWUG/PHJ8zn+LxTLx9M39pseywRCISckHqM/DEtTpWPDZTOMAMRV7 u+gPtl1heM7xcxmvkV5pYtWB7qud2zhHha/FJDx6OQKQ/Yfw7wOm2kl6H0iYYD3JzHnziSV6ILkuAU zMl6KpctiAcBTYXqDxTGHjqmsSeK2TcYjUygAHSP03yvwIqOyz4pxpu30om4WrYE5tfI9sxvkULEgQ 6ROc02Du0tosZD5RKVfLH4FWLUvolkAw/6OiQgd0sMt7atxrSPaEjNnKvqj+C796UuXgksTL4kPfkk hWzLlqF/MLtJd0/Wfs8IYEa/CajTJD03dpui0wAlM6ExenWtuEultSDK2/sg==
X-Developer-Key: i=chuck.lever@oracle.com; a=openpgp; fpr=28B2E5B01286DF243CF23EFE336AB3336F667F97
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Micro-optimization: The last user of the generic SVC dispatch code
path has been removed, so svc_process_common() can be simplified.
This declutters the hot path so that the by-far most common case
(a dispatch function exists) is made the /only/ path.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 include/linux/sunrpc/svc.h |    5 +---
 net/sunrpc/svc.c           |   51 ++------------------------------------------
 2 files changed, 3 insertions(+), 53 deletions(-)

diff --git a/include/linux/sunrpc/svc.h b/include/linux/sunrpc/svc.h
index 6263410c948a..4205a6ef4770 100644
--- a/include/linux/sunrpc/svc.h
+++ b/include/linux/sunrpc/svc.h
@@ -443,10 +443,7 @@ struct svc_version {
 	/* Need xprt with congestion control */
 	bool			vs_need_cong_ctrl;
 
-	/* Override dispatch function (e.g. when caching replies).
-	 * A return value of 0 means drop the request. 
-	 * vs_dispatch == NULL means use default dispatcher.
-	 */
+	/* Dispatch function */
 	int			(*vs_dispatch)(struct svc_rqst *, __be32 *);
 };
 
diff --git a/net/sunrpc/svc.c b/net/sunrpc/svc.c
index 08ca797bb8a4..e0dd6e6a4602 100644
--- a/net/sunrpc/svc.c
+++ b/net/sunrpc/svc.c
@@ -1186,45 +1186,6 @@ void svc_printk(struct svc_rqst *rqstp, const char *fmt, ...)
 static __printf(2,3) void svc_printk(struct svc_rqst *rqstp, const char *fmt, ...) {}
 #endif
 
-static int
-svc_generic_dispatch(struct svc_rqst *rqstp, __be32 *statp)
-{
-	struct kvec *argv = &rqstp->rq_arg.head[0];
-	struct kvec *resv = &rqstp->rq_res.head[0];
-	const struct svc_procedure *procp = rqstp->rq_procinfo;
-
-	/*
-	 * Decode arguments
-	 * XXX: why do we ignore the return value?
-	 */
-	if (procp->pc_decode &&
-	    !procp->pc_decode(rqstp, argv->iov_base)) {
-		*statp = rpc_garbage_args;
-		return 1;
-	}
-
-	*statp = procp->pc_func(rqstp);
-
-	if (*statp == rpc_drop_reply ||
-	    test_bit(RQ_DROPME, &rqstp->rq_flags))
-		return 0;
-
-	if (rqstp->rq_auth_stat != rpc_auth_ok)
-		return 1;
-
-	if (*statp != rpc_success)
-		return 1;
-
-	/* Encode reply */
-	if (procp->pc_encode &&
-	    !procp->pc_encode(rqstp, resv->iov_base + resv->iov_len)) {
-		dprintk("svc: failed to encode reply\n");
-		/* serv->sv_stats->rpcsystemerr++; */
-		*statp = rpc_system_err;
-	}
-	return 1;
-}
-
 __be32
 svc_generic_init_request(struct svc_rqst *rqstp,
 		const struct svc_program *progp,
@@ -1392,16 +1353,8 @@ svc_process_common(struct svc_rqst *rqstp, struct kvec *argv, struct kvec *resv)
 		svc_reserve_auth(rqstp, procp->pc_xdrressize<<2);
 
 	/* Call the function that processes the request. */
-	if (!process.dispatch) {
-		if (!svc_generic_dispatch(rqstp, statp))
-			goto release_dropit;
-		if (*statp == rpc_garbage_args)
-			goto err_garbage;
-	} else {
-		dprintk("svc: calling dispatcher\n");
-		if (!process.dispatch(rqstp, statp))
-			goto release_dropit; /* Release reply info */
-	}
+	if (!process.dispatch(rqstp, statp))
+		goto release_dropit;
 
 	if (rqstp->rq_auth_stat != rpc_auth_ok)
 		goto err_release_bad_auth;


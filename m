Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F56F425D15
	for <lists+linux-nfs@lfdr.de>; Thu,  7 Oct 2021 22:17:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233974AbhJGUT0 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 7 Oct 2021 16:19:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:49860 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233019AbhJGUT0 (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Thu, 7 Oct 2021 16:19:26 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id CF0D261074;
        Thu,  7 Oct 2021 20:17:31 +0000 (UTC)
From:   Chuck Lever <chuck.lever@oracle.com>
To:     bfields@redhat.com
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH v2 2/2] SUNRPC: De-duplicate .pc_release() call sites
Date:   Thu,  7 Oct 2021 16:17:31 -0400
Message-Id:  <163363785080.2295.1236904079555867824.stgit@bazille.1015granger.net>
X-Mailer: git-send-email 2.33.0.113.g6c40894d24
In-Reply-To:  <163363775944.2295.17512762002999927909.stgit@bazille.1015granger.net>
References:  <163363775944.2295.17512762002999927909.stgit@bazille.1015granger.net>
User-Agent: StGit/1.1+62.ged16
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=2404; h=from:subject:message-id; bh=cm7bsZ4bTu8ZJeV9zTive1b1gCyHFamI2siqYqJZ83Y=; b=owEBbQKS/ZANAwAIATNqszNvZn+XAcsmYgBhX1XaJOgfUnwKCWkd/p8V9msPtNoTPeQRvaTZiMT4 xbCHlZKJAjMEAAEIAB0WIQQosuWwEobfJDzyPv4zarMzb2Z/lwUCYV9V2gAKCRAzarMzb2Z/l904D/ 4iIqXC5FcIYV/+wv+wGgtoK4DuskgyXtzwe6hCb5rohP8TZ3vckS5mGCp/kUzNDp0+s/+dMls2i6F1 70vbFuAUtFOiZr6/YEhaK4J4exipxIFOA1iKu8ckDk8hx2Wwt4fWMXx8fMrJqB2gQLj/i9Vi4ko7Yv soh65DqovAS6XR4Rtk8mDh/Gjeq/o/4WFc/kPtPDoYwVe02ZFCmGG+3IGERWxYLxwwRz5MebJZkiRM JF3+pqd3wKuZrYEBTpwPvd+MIMw143W6IBWDWtIFxfqdeVjlD0YmleVBwksNgoQh2OiurdMp4Rlj7D XnnKGRPjaRBj/jPzYN7Uu5/hgOQWdsL7IP7vYCogMS7JYmynQNPZuoZBkKyapcApYrBEycGNXyEFoU xDaUb3Hc6487qeP+4U6ldzfBJ89yBIppFV17Uub8y3OCKGcGOd0ZLjAFMoJgS1OWFfRLrg0oDE/tAC egVfdOeIn+9N2gP452bVUByK/BjMCEd8n5ZLFZArIDTs5ajH66VREVHAdFMTBQRBv67/tr1Ealhg8l GY15AVsX5BYf284QUbwp3w+9lbThmo3VOUlEUBPkmUkZjfudvdoGDCfx4vEw3k9O2IZquh9UBxKXC2 P6aiEOpfZuzJCBH9D10sSwGgzfxkc3x0ASHRkcnpCols3id4Vj1phTsCuEig==
X-Developer-Key: i=chuck.lever@oracle.com; a=openpgp; fpr=28B2E5B01286DF243CF23EFE336AB3336F667F97
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

There was some spaghetti in svc_process_common() that had evolved
over time such that there was still one case that needed a call
to .pc_release() but never made it. That issue was removed in
the previous patch.

As additional insurance against missing this important callout,
ensure that the .pc_release() method is always called, no matter
what the reply_stat is.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 net/sunrpc/svc.c |   22 +++++++---------------
 1 file changed, 7 insertions(+), 15 deletions(-)

diff --git a/net/sunrpc/svc.c b/net/sunrpc/svc.c
index e0dd6e6a4602..4292278a9552 100644
--- a/net/sunrpc/svc.c
+++ b/net/sunrpc/svc.c
@@ -1252,7 +1252,7 @@ svc_process_common(struct svc_rqst *rqstp, struct kvec *argv, struct kvec *resv)
 	__be32			*statp;
 	u32			prog, vers;
 	__be32			rpc_stat;
-	int			auth_res;
+	int			auth_res, rc;
 	__be32			*reply_statp;
 
 	rpc_stat = rpc_success;
@@ -1353,20 +1353,18 @@ svc_process_common(struct svc_rqst *rqstp, struct kvec *argv, struct kvec *resv)
 		svc_reserve_auth(rqstp, procp->pc_xdrressize<<2);
 
 	/* Call the function that processes the request. */
-	if (!process.dispatch(rqstp, statp))
-		goto release_dropit;
-
+	rc = process.dispatch(rqstp, statp);
+	if (procp->pc_release)
+		procp->pc_release(rqstp);
+	if (!rc)
+		goto dropit;
 	if (rqstp->rq_auth_stat != rpc_auth_ok)
-		goto err_release_bad_auth;
+		goto err_bad_auth;
 
 	/* Check RPC status result */
 	if (*statp != rpc_success)
 		resv->iov_len = ((void*)statp)  - resv->iov_base + 4;
 
-	/* Release reply info */
-	if (procp->pc_release)
-		procp->pc_release(rqstp);
-
 	if (procp->pc_encode == NULL)
 		goto dropit;
 
@@ -1375,9 +1373,6 @@ svc_process_common(struct svc_rqst *rqstp, struct kvec *argv, struct kvec *resv)
 		goto close_xprt;
 	return 1;		/* Caller can now send it */
 
-release_dropit:
-	if (procp->pc_release)
-		procp->pc_release(rqstp);
  dropit:
 	svc_authorise(rqstp);	/* doesn't hurt to call this twice */
 	dprintk("svc: svc_process dropit\n");
@@ -1404,9 +1399,6 @@ svc_process_common(struct svc_rqst *rqstp, struct kvec *argv, struct kvec *resv)
 	svc_putnl(resv, 2);
 	goto sendit;
 
-err_release_bad_auth:
-	if (procp->pc_release)
-		procp->pc_release(rqstp);
 err_bad_auth:
 	dprintk("svc: authentication failed (%d)\n",
 		be32_to_cpu(rqstp->rq_auth_stat));


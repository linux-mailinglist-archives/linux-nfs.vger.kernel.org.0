Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D976339AC10
	for <lists+linux-nfs@lfdr.de>; Thu,  3 Jun 2021 22:52:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230039AbhFCUyO (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 3 Jun 2021 16:54:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:44988 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230036AbhFCUyO (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Thu, 3 Jun 2021 16:54:14 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6E566613E4;
        Thu,  3 Jun 2021 20:52:29 +0000 (UTC)
Subject: [PATCH 19/29] lockd: Update the NLMv4 LOCK arguments decoder to use
 struct xdr_stream
From:   Chuck Lever <chuck.lever@oracle.com>
To:     bfields@fieldses.org
Cc:     linux-nfs@vger.kernel.org
Date:   Thu, 03 Jun 2021 16:52:28 -0400
Message-ID: <162275354874.32691.14207239978946311999.stgit@klimt.1015granger.net>
In-Reply-To: <162275337584.32691.3943139351165347555.stgit@klimt.1015granger.net>
References: <162275337584.32691.3943139351165347555.stgit@klimt.1015granger.net>
User-Agent: StGit/1.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/lockd/xdr4.c |   41 +++++++++++++++++++++++------------------
 1 file changed, 23 insertions(+), 18 deletions(-)

diff --git a/fs/lockd/xdr4.c b/fs/lockd/xdr4.c
index cf64794fdc1f..1d3e780c25fd 100644
--- a/fs/lockd/xdr4.c
+++ b/fs/lockd/xdr4.c
@@ -264,35 +264,40 @@ nlm4svc_decode_testargs(struct svc_rqst *rqstp, __be32 *p)
 	return 1;
 }
 
-int
-nlm4svc_encode_testres(struct svc_rqst *rqstp, __be32 *p)
-{
-	struct nlm_res *resp = rqstp->rq_resp;
-
-	if (!(p = nlm4_encode_testres(p, resp)))
-		return 0;
-	return xdr_ressize_check(rqstp, p);
-}
-
 int
 nlm4svc_decode_lockargs(struct svc_rqst *rqstp, __be32 *p)
 {
+	struct xdr_stream *xdr = &rqstp->rq_arg_stream;
 	struct nlm_args *argp = rqstp->rq_argp;
-	u32	exclusive;
+	u32 exclusive;
 
-	if (!(p = nlm4_decode_cookie(p, &argp->cookie)))
+	if (!svcxdr_decode_cookie(xdr, &argp->cookie))
 		return 0;
-	argp->block  = ntohl(*p++);
-	exclusive    = ntohl(*p++);
-	if (!(p = nlm4_decode_lock(p, &argp->lock)))
+	if (xdr_stream_decode_bool(xdr, &argp->block) < 0)
+		return 0;
+	if (xdr_stream_decode_bool(xdr, &exclusive) < 0)
+		return 0;
+	if (!svcxdr_decode_lock(xdr, &argp->lock))
 		return 0;
 	if (exclusive)
 		argp->lock.fl.fl_type = F_WRLCK;
-	argp->reclaim = ntohl(*p++);
-	argp->state   = ntohl(*p++);
+	if (xdr_stream_decode_bool(xdr, &argp->reclaim) < 0)
+		return 0;
+	if (xdr_stream_decode_u32(xdr, &argp->state) < 0)
+		return 0;
 	argp->monitor = 1;		/* monitor client by default */
 
-	return xdr_argsize_check(rqstp, p);
+	return 1;
+}
+
+int
+nlm4svc_encode_testres(struct svc_rqst *rqstp, __be32 *p)
+{
+	struct nlm_res *resp = rqstp->rq_resp;
+
+	if (!(p = nlm4_encode_testres(p, resp)))
+		return 0;
+	return xdr_ressize_check(rqstp, p);
 }
 
 int



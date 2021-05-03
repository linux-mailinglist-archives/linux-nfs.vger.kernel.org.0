Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0CADD3717DE
	for <lists+linux-nfs@lfdr.de>; Mon,  3 May 2021 17:24:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230291AbhECPZp (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 3 May 2021 11:25:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:41262 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230122AbhECPZp (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Mon, 3 May 2021 11:25:45 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id BF3EA61176
        for <linux-nfs@vger.kernel.org>; Mon,  3 May 2021 15:24:51 +0000 (UTC)
Subject: [PATCH v1 20/29] lockd: Update the NLMv4 CANCEL arguments decoder to
 use struct xdr_stream
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org
Date:   Mon, 03 May 2021 11:24:50 -0400
Message-ID: <162005549089.23028.1570135970984941556.stgit@klimt.1015granger.net>
In-Reply-To: <162005520101.23028.15766816408658851498.stgit@klimt.1015granger.net>
References: <162005520101.23028.15766816408658851498.stgit@klimt.1015granger.net>
User-Agent: StGit/1.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/lockd/xdr4.c |   33 ++++++++++++++++++---------------
 1 file changed, 18 insertions(+), 15 deletions(-)

diff --git a/fs/lockd/xdr4.c b/fs/lockd/xdr4.c
index 1d3e780c25fd..37d45f1d7199 100644
--- a/fs/lockd/xdr4.c
+++ b/fs/lockd/xdr4.c
@@ -291,30 +291,33 @@ nlm4svc_decode_lockargs(struct svc_rqst *rqstp, __be32 *p)
 }
 
 int
-nlm4svc_encode_testres(struct svc_rqst *rqstp, __be32 *p)
+nlm4svc_decode_cancargs(struct svc_rqst *rqstp, __be32 *p)
 {
-	struct nlm_res *resp = rqstp->rq_resp;
+	struct xdr_stream *xdr = &rqstp->rq_arg_stream;
+	struct nlm_args *argp = rqstp->rq_argp;
+	u32 exclusive;
 
-	if (!(p = nlm4_encode_testres(p, resp)))
+	if (!svcxdr_decode_cookie(xdr, &argp->cookie))
 		return 0;
-	return xdr_ressize_check(rqstp, p);
+	if (xdr_stream_decode_bool(xdr, &argp->block) < 0)
+		return 0;
+	if (xdr_stream_decode_bool(xdr, &exclusive) < 0)
+		return 0;
+	if (!svcxdr_decode_lock(xdr, &argp->lock))
+		return 0;
+	if (exclusive)
+		argp->lock.fl.fl_type = F_WRLCK;
+	return 1;
 }
 
 int
-nlm4svc_decode_cancargs(struct svc_rqst *rqstp, __be32 *p)
+nlm4svc_encode_testres(struct svc_rqst *rqstp, __be32 *p)
 {
-	struct nlm_args *argp = rqstp->rq_argp;
-	u32	exclusive;
+	struct nlm_res *resp = rqstp->rq_resp;
 
-	if (!(p = nlm4_decode_cookie(p, &argp->cookie)))
-		return 0;
-	argp->block = ntohl(*p++);
-	exclusive = ntohl(*p++);
-	if (!(p = nlm4_decode_lock(p, &argp->lock)))
+	if (!(p = nlm4_encode_testres(p, resp)))
 		return 0;
-	if (exclusive)
-		argp->lock.fl.fl_type = F_WRLCK;
-	return xdr_argsize_check(rqstp, p);
+	return xdr_ressize_check(rqstp, p);
 }
 
 int



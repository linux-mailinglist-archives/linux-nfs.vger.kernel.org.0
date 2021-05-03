Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A7EA3717CE
	for <lists+linux-nfs@lfdr.de>; Mon,  3 May 2021 17:23:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230366AbhECPYT (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 3 May 2021 11:24:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:39132 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230283AbhECPYS (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Mon, 3 May 2021 11:24:18 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6319E61176
        for <linux-nfs@vger.kernel.org>; Mon,  3 May 2021 15:23:25 +0000 (UTC)
Subject: [PATCH v1 06/29] lockd: Update the NLMv1 LOCK arguments decoder to
 use struct xdr_stream
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org
Date:   Mon, 03 May 2021 11:23:24 -0400
Message-ID: <162005540446.23028.10792744663010217300.stgit@klimt.1015granger.net>
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
 fs/lockd/xdr.c |   41 +++++++++++++++++++++++------------------
 1 file changed, 23 insertions(+), 18 deletions(-)

diff --git a/fs/lockd/xdr.c b/fs/lockd/xdr.c
index 56982edd4766..8a9f02e45df2 100644
--- a/fs/lockd/xdr.c
+++ b/fs/lockd/xdr.c
@@ -267,35 +267,40 @@ nlmsvc_decode_testargs(struct svc_rqst *rqstp, __be32 *p)
 	return 1;
 }
 
-int
-nlmsvc_encode_testres(struct svc_rqst *rqstp, __be32 *p)
-{
-	struct nlm_res *resp = rqstp->rq_resp;
-
-	if (!(p = nlm_encode_testres(p, resp)))
-		return 0;
-	return xdr_ressize_check(rqstp, p);
-}
-
 int
 nlmsvc_decode_lockargs(struct svc_rqst *rqstp, __be32 *p)
 {
+	struct xdr_stream *xdr = &rqstp->rq_arg_stream;
 	struct nlm_args *argp = rqstp->rq_argp;
-	u32	exclusive;
+	u32 exclusive;
 
-	if (!(p = nlm_decode_cookie(p, &argp->cookie)))
+	if (!svcxdr_decode_cookie(xdr, &argp->cookie))
 		return 0;
-	argp->block  = ntohl(*p++);
-	exclusive    = ntohl(*p++);
-	if (!(p = nlm_decode_lock(p, &argp->lock)))
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
+nlmsvc_encode_testres(struct svc_rqst *rqstp, __be32 *p)
+{
+	struct nlm_res *resp = rqstp->rq_resp;
+
+	if (!(p = nlm_encode_testres(p, resp)))
+		return 0;
+	return xdr_ressize_check(rqstp, p);
 }
 
 int



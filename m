Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6CAFF39AC05
	for <lists+linux-nfs@lfdr.de>; Thu,  3 Jun 2021 22:51:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229790AbhFCUxO (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 3 Jun 2021 16:53:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:44760 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229576AbhFCUxO (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Thu, 3 Jun 2021 16:53:14 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 140D361263;
        Thu,  3 Jun 2021 20:51:29 +0000 (UTC)
Subject: [PATCH 09/29] lockd: Update the NLMv1 nlm_res arguments decoder to
 use struct xdr_stream
From:   Chuck Lever <chuck.lever@oracle.com>
To:     bfields@fieldses.org
Cc:     linux-nfs@vger.kernel.org
Date:   Thu, 03 Jun 2021 16:51:28 -0400
Message-ID: <162275348837.32691.4312188122466636960.stgit@klimt.1015granger.net>
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
 fs/lockd/xdr.c |   25 ++++++++++++++-----------
 1 file changed, 14 insertions(+), 11 deletions(-)

diff --git a/fs/lockd/xdr.c b/fs/lockd/xdr.c
index b59e02b4417c..911b6377a6da 100644
--- a/fs/lockd/xdr.c
+++ b/fs/lockd/xdr.c
@@ -299,6 +299,20 @@ nlmsvc_decode_unlockargs(struct svc_rqst *rqstp, __be32 *p)
 	return 1;
 }
 
+int
+nlmsvc_decode_res(struct svc_rqst *rqstp, __be32 *p)
+{
+	struct xdr_stream *xdr = &rqstp->rq_arg_stream;
+	struct nlm_res *resp = rqstp->rq_argp;
+
+	if (!svcxdr_decode_cookie(xdr, &resp->cookie))
+		return 0;
+	if (!svcxdr_decode_stats(xdr, &resp->status))
+		return 0;
+
+	return 1;
+}
+
 int
 nlmsvc_encode_testres(struct svc_rqst *rqstp, __be32 *p)
 {
@@ -379,17 +393,6 @@ nlmsvc_decode_reboot(struct svc_rqst *rqstp, __be32 *p)
 	return xdr_argsize_check(rqstp, p);
 }
 
-int
-nlmsvc_decode_res(struct svc_rqst *rqstp, __be32 *p)
-{
-	struct nlm_res *resp = rqstp->rq_argp;
-
-	if (!(p = nlm_decode_cookie(p, &resp->cookie)))
-		return 0;
-	resp->status = *p++;
-	return xdr_argsize_check(rqstp, p);
-}
-
 int
 nlmsvc_encode_void(struct svc_rqst *rqstp, __be32 *p)
 {



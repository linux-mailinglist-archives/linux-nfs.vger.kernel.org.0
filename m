Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 464D139AC19
	for <lists+linux-nfs@lfdr.de>; Thu,  3 Jun 2021 22:53:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230081AbhFCUyv (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 3 Jun 2021 16:54:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:45220 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229852AbhFCUyu (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Thu, 3 Jun 2021 16:54:50 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id A9170613F1;
        Thu,  3 Jun 2021 20:53:05 +0000 (UTC)
Subject: [PATCH 25/29] lockd: Update the NLMv4 FREE_ALL arguments decoder to
 use struct xdr_stream
From:   Chuck Lever <chuck.lever@oracle.com>
To:     bfields@fieldses.org
Cc:     linux-nfs@vger.kernel.org
Date:   Thu, 03 Jun 2021 16:53:04 -0400
Message-ID: <162275358498.32691.16098108993604000915.stgit@klimt.1015granger.net>
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
 fs/lockd/xdr4.c |   28 +++++++++++++++-------------
 1 file changed, 15 insertions(+), 13 deletions(-)

diff --git a/fs/lockd/xdr4.c b/fs/lockd/xdr4.c
index e6bab1d1e41f..6c5383bef2bf 100644
--- a/fs/lockd/xdr4.c
+++ b/fs/lockd/xdr4.c
@@ -309,6 +309,21 @@ nlm4svc_decode_shareargs(struct svc_rqst *rqstp, __be32 *p)
 	return 1;
 }
 
+int
+nlm4svc_decode_notify(struct svc_rqst *rqstp, __be32 *p)
+{
+	struct xdr_stream *xdr = &rqstp->rq_arg_stream;
+	struct nlm_args *argp = rqstp->rq_argp;
+	struct nlm_lock	*lock = &argp->lock;
+
+	if (!svcxdr_decode_string(xdr, &lock->caller, &lock->len))
+		return 0;
+	if (xdr_stream_decode_u32(xdr, &argp->state) < 0)
+		return 0;
+
+	return 1;
+}
+
 int
 nlm4svc_encode_testres(struct svc_rqst *rqstp, __be32 *p)
 {
@@ -342,19 +357,6 @@ nlm4svc_encode_res(struct svc_rqst *rqstp, __be32 *p)
 	return xdr_ressize_check(rqstp, p);
 }
 
-int
-nlm4svc_decode_notify(struct svc_rqst *rqstp, __be32 *p)
-{
-	struct nlm_args *argp = rqstp->rq_argp;
-	struct nlm_lock	*lock = &argp->lock;
-
-	if (!(p = xdr_decode_string_inplace(p, &lock->caller,
-					    &lock->len, NLM_MAXSTRLEN)))
-		return 0;
-	argp->state = ntohl(*p++);
-	return xdr_argsize_check(rqstp, p);
-}
-
 int
 nlm4svc_encode_void(struct svc_rqst *rqstp, __be32 *p)
 {



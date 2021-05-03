Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DCCCE3717E0
	for <lists+linux-nfs@lfdr.de>; Mon,  3 May 2021 17:25:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230335AbhECPZ5 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 3 May 2021 11:25:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:41596 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230122AbhECPZ5 (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Mon, 3 May 2021 11:25:57 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 04B9761208
        for <linux-nfs@vger.kernel.org>; Mon,  3 May 2021 15:25:03 +0000 (UTC)
Subject: [PATCH v1 22/29] lockd: Update the NLMv4 nlm_res arguments decoder to
 use struct xdr_stream
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org
Date:   Mon, 03 May 2021 11:25:03 -0400
Message-ID: <162005550315.23028.13042310781769702330.stgit@klimt.1015granger.net>
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
 fs/lockd/xdr4.c |   25 ++++++++++++++-----------
 1 file changed, 14 insertions(+), 11 deletions(-)

diff --git a/fs/lockd/xdr4.c b/fs/lockd/xdr4.c
index 47a87ea4a99b..6bd3bfb69ed7 100644
--- a/fs/lockd/xdr4.c
+++ b/fs/lockd/xdr4.c
@@ -295,6 +295,20 @@ nlm4svc_decode_unlockargs(struct svc_rqst *rqstp, __be32 *p)
 	return 1;
 }
 
+int
+nlm4svc_decode_res(struct svc_rqst *rqstp, __be32 *p)
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
 nlm4svc_encode_testres(struct svc_rqst *rqstp, __be32 *p)
 {
@@ -375,17 +389,6 @@ nlm4svc_decode_reboot(struct svc_rqst *rqstp, __be32 *p)
 	return xdr_argsize_check(rqstp, p);
 }
 
-int
-nlm4svc_decode_res(struct svc_rqst *rqstp, __be32 *p)
-{
-	struct nlm_res *resp = rqstp->rq_argp;
-
-	if (!(p = nlm4_decode_cookie(p, &resp->cookie)))
-		return 0;
-	resp->status = *p++;
-	return xdr_argsize_check(rqstp, p);
-}
-
 int
 nlm4svc_encode_void(struct svc_rqst *rqstp, __be32 *p)
 {



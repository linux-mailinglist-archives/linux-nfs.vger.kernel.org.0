Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AFBBC3717D3
	for <lists+linux-nfs@lfdr.de>; Mon,  3 May 2021 17:23:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230379AbhECPYj (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 3 May 2021 11:24:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:39586 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230291AbhECPYh (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Mon, 3 May 2021 11:24:37 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id F1F6461176
        for <linux-nfs@vger.kernel.org>; Mon,  3 May 2021 15:23:43 +0000 (UTC)
Subject: [PATCH v1 09/29] lockd: Update the NLMv1 nlm_res arguments decoder to
 use struct xdr_stream
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org
Date:   Mon, 03 May 2021 11:23:43 -0400
Message-ID: <162005542311.23028.6408439856726703721.stgit@klimt.1015granger.net>
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



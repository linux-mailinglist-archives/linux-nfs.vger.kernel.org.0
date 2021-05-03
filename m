Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 996513717D6
	for <lists+linux-nfs@lfdr.de>; Mon,  3 May 2021 17:24:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230291AbhECPY4 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 3 May 2021 11:24:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:40038 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230122AbhECPYz (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Mon, 3 May 2021 11:24:55 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 654B4611CE
        for <linux-nfs@vger.kernel.org>; Mon,  3 May 2021 15:24:02 +0000 (UTC)
Subject: [PATCH v1 12/29] lockd: Update the NLMv1 FREE_ALL arguments decoder
 to use struct xdr_stream
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org
Date:   Mon, 03 May 2021 11:24:01 -0400
Message-ID: <162005544156.23028.9936340930354797929.stgit@klimt.1015granger.net>
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
 fs/lockd/xdr.c |   28 +++++++++++++++-------------
 1 file changed, 15 insertions(+), 13 deletions(-)

diff --git a/fs/lockd/xdr.c b/fs/lockd/xdr.c
index c496f18eff06..091c8c463ab4 100644
--- a/fs/lockd/xdr.c
+++ b/fs/lockd/xdr.c
@@ -316,6 +316,21 @@ nlmsvc_decode_shareargs(struct svc_rqst *rqstp, __be32 *p)
 	return 1;
 }
 
+int
+nlmsvc_decode_notify(struct svc_rqst *rqstp, __be32 *p)
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
 nlmsvc_encode_testres(struct svc_rqst *rqstp, __be32 *p)
 {
@@ -349,19 +364,6 @@ nlmsvc_encode_res(struct svc_rqst *rqstp, __be32 *p)
 	return xdr_ressize_check(rqstp, p);
 }
 
-int
-nlmsvc_decode_notify(struct svc_rqst *rqstp, __be32 *p)
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
 nlmsvc_encode_void(struct svc_rqst *rqstp, __be32 *p)
 {



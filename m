Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD65239AC1C
	for <lists+linux-nfs@lfdr.de>; Thu,  3 Jun 2021 22:53:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229736AbhFCUzJ (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 3 Jun 2021 16:55:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:45284 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229617AbhFCUzI (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Thu, 3 Jun 2021 16:55:08 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id C8530613E7;
        Thu,  3 Jun 2021 20:53:23 +0000 (UTC)
Subject: [PATCH 28/29] lockd: Update the NLMv4 nlm_res results encoder to use
 struct xdr_stream
From:   Chuck Lever <chuck.lever@oracle.com>
To:     bfields@fieldses.org
Cc:     linux-nfs@vger.kernel.org
Date:   Thu, 03 Jun 2021 16:53:23 -0400
Message-ID: <162275360310.32691.13313649648887407036.stgit@klimt.1015granger.net>
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
 fs/lockd/xdr4.c |   13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/fs/lockd/xdr4.c b/fs/lockd/xdr4.c
index 9b8a7afb935c..efdede71b951 100644
--- a/fs/lockd/xdr4.c
+++ b/fs/lockd/xdr4.c
@@ -344,24 +344,23 @@ nlm4svc_encode_testres(struct svc_rqst *rqstp, __be32 *p)
 }
 
 int
-nlm4svc_encode_shareres(struct svc_rqst *rqstp, __be32 *p)
+nlm4svc_encode_res(struct svc_rqst *rqstp, __be32 *p)
 {
+	struct xdr_stream *xdr = &rqstp->rq_res_stream;
 	struct nlm_res *resp = rqstp->rq_resp;
 
-	if (!(p = nlm4_encode_cookie(p, &resp->cookie)))
-		return 0;
-	*p++ = resp->status;
-	*p++ = xdr_zero;		/* sequence argument */
-	return xdr_ressize_check(rqstp, p);
+	return svcxdr_encode_cookie(xdr, &resp->cookie) &&
+		svcxdr_encode_stats(xdr, resp->status);
 }
 
 int
-nlm4svc_encode_res(struct svc_rqst *rqstp, __be32 *p)
+nlm4svc_encode_shareres(struct svc_rqst *rqstp, __be32 *p)
 {
 	struct nlm_res *resp = rqstp->rq_resp;
 
 	if (!(p = nlm4_encode_cookie(p, &resp->cookie)))
 		return 0;
 	*p++ = resp->status;
+	*p++ = xdr_zero;		/* sequence argument */
 	return xdr_ressize_check(rqstp, p);
 }



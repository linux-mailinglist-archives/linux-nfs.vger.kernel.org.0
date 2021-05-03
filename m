Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 958E43717DA
	for <lists+linux-nfs@lfdr.de>; Mon,  3 May 2021 17:24:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230364AbhECPZV (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 3 May 2021 11:25:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:40628 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230122AbhECPZU (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Mon, 3 May 2021 11:25:20 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 17690611CE
        for <linux-nfs@vger.kernel.org>; Mon,  3 May 2021 15:24:27 +0000 (UTC)
Subject: [PATCH v1 16/29] lockd: Update the NLMv1 SHARE results encoder to use
 struct xdr_stream
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org
Date:   Mon, 03 May 2021 11:24:26 -0400
Message-ID: <162005546620.23028.11408078612987288149.stgit@klimt.1015granger.net>
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
 fs/lockd/xdr.c |   25 +++++++++----------------
 1 file changed, 9 insertions(+), 16 deletions(-)

diff --git a/fs/lockd/xdr.c b/fs/lockd/xdr.c
index 4fb6090bc915..9235e60b1769 100644
--- a/fs/lockd/xdr.c
+++ b/fs/lockd/xdr.c
@@ -41,18 +41,6 @@ loff_t_to_s32(loff_t offset)
 	return res;
 }
 
-/*
- * XDR functions for basic NLM types
- */
-static inline __be32 *
-nlm_encode_cookie(__be32 *p, struct nlm_cookie *c)
-{
-	*p++ = htonl(c->len);
-	memcpy(p, c->data, c->len);
-	p+=XDR_QUADLEN(c->len);
-	return p;
-}
-
 /*
  * NLM file handles are defined by specification to be a variable-length
  * XDR opaque no longer than 1024 bytes. However, this implementation
@@ -361,11 +349,16 @@ nlmsvc_encode_res(struct svc_rqst *rqstp, __be32 *p)
 int
 nlmsvc_encode_shareres(struct svc_rqst *rqstp, __be32 *p)
 {
+	struct xdr_stream *xdr = &rqstp->rq_res_stream;
 	struct nlm_res *resp = rqstp->rq_resp;
 
-	if (!(p = nlm_encode_cookie(p, &resp->cookie)))
+	if (!svcxdr_encode_cookie(xdr, &resp->cookie))
 		return 0;
-	*p++ = resp->status;
-	*p++ = xdr_zero;		/* sequence argument */
-	return xdr_ressize_check(rqstp, p);
+	if (!svcxdr_encode_stats(xdr, resp->status))
+		return 0;
+	/* sequence */
+	if (xdr_stream_encode_u32(xdr, 0) < 0)
+		return 0;
+
+	return 1;
 }



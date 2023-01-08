Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC687661697
	for <lists+linux-nfs@lfdr.de>; Sun,  8 Jan 2023 17:29:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234737AbjAHQ3H (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sun, 8 Jan 2023 11:29:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234724AbjAHQ3G (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sun, 8 Jan 2023 11:29:06 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 425CE3889
        for <linux-nfs@vger.kernel.org>; Sun,  8 Jan 2023 08:29:05 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id EF0AEB80B36
        for <linux-nfs@vger.kernel.org>; Sun,  8 Jan 2023 16:29:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8BC15C433D2
        for <linux-nfs@vger.kernel.org>; Sun,  8 Jan 2023 16:29:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673195342;
        bh=98aoESdPw0HdeCTXa5CJNdW5D+rs0Hty61qBU7rUXn8=;
        h=Subject:From:To:Date:In-Reply-To:References:From;
        b=DnHMKKwRMdEdd+jyg/KKHBBRt8Kv/NZJzv6le0fOUDZF858VW9s4d7Na9wI7yrKAy
         +uLwUxN/Km3CVHFN8StBGKU9nKeXDGG9qKltv4cqfn7HbBgaW8j+5O45GfPqTttOR7
         auUWIdT4xywo1eFBnxCF5GlruRCJorvN7joQc2W95s40U/uof6V65twbEqcHexHXCC
         Df+U0zbNLmsPWcpF5Tvn7goKS/TefHr07cCKh38vyikqtRfBn/Ca9kcCtcJbxjGS7H
         0GjmwVvBGmsBwtwTWv1Z2WFkiYeBgf2DTAmJGsC5xTluf9uPlzi4HIMfbz5x3YOlqJ
         b8ETMxyHQ13bQ==
Subject: [PATCH v1 06/27] SUNRPC: Rename automatic variables in
 svcauth_gss_wrap_resp_priv()
From:   Chuck Lever <cel@kernel.org>
To:     linux-nfs@vger.kernel.org
Date:   Sun, 08 Jan 2023 11:29:01 -0500
Message-ID: <167319534163.7490.5386134241125006813.stgit@bazille.1015granger.net>
In-Reply-To: <167319499150.7490.2294168831574653380.stgit@bazille.1015granger.net>
References: <167319499150.7490.2294168831574653380.stgit@bazille.1015granger.net>
User-Agent: StGit/1.5
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Chuck Lever <chuck.lever@oracle.com>

Clean up variable names to match the other unwrap and wrap
functions.

Additionally, the explicit type cast on @gsd in unnecessary; and
@resbuf is renamed to match the variable naming in the unwrap
functions.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 net/sunrpc/auth_gss/svcauth_gss.c |   72 ++++++++++++++++++++++---------------
 1 file changed, 42 insertions(+), 30 deletions(-)

diff --git a/net/sunrpc/auth_gss/svcauth_gss.c b/net/sunrpc/auth_gss/svcauth_gss.c
index 3715ff842ca1..f0cd89f201bc 100644
--- a/net/sunrpc/auth_gss/svcauth_gss.c
+++ b/net/sunrpc/auth_gss/svcauth_gss.c
@@ -1817,24 +1817,35 @@ static int svcauth_gss_wrap_integ(struct svc_rqst *rqstp)
 	return -EINVAL;
 }
 
-static inline int
-svcauth_gss_wrap_resp_priv(struct svc_rqst *rqstp)
+/*
+ * RFC 2203, Section 5.3.2.3
+ *
+ *	struct rpc_gss_priv_data {
+ *		opaque databody_priv<>
+ *	};
+ *
+ *	struct rpc_gss_data_t {
+ *		unsigned int seq_num;
+ *		proc_req_arg_t arg;
+ *	};
+ */
+static int svcauth_gss_wrap_priv(struct svc_rqst *rqstp)
 {
-	struct gss_svc_data *gsd = (struct gss_svc_data *)rqstp->rq_auth_data;
+	struct gss_svc_data *gsd = rqstp->rq_auth_data;
 	struct rpc_gss_wire_cred *gc = &gsd->clcred;
-	struct xdr_buf *resbuf = &rqstp->rq_res;
+	struct xdr_buf *buf = &rqstp->rq_res;
 	struct page **inpages = NULL;
-	__be32 *p, *len;
+	__be32 *p, *lenp;
 	int offset;
 	int pad;
 
-	p = svcauth_gss_prepare_to_wrap(resbuf, gsd);
+	p = svcauth_gss_prepare_to_wrap(buf, gsd);
 	if (p == NULL)
 		return 0;
-	len = p++;
-	offset = (u8 *)p - (u8 *)resbuf->head[0].iov_base;
+	lenp = p++;
+	offset = (u8 *)p - (u8 *)buf->head[0].iov_base;
 	*p++ = htonl(gc->gc_seq);
-	inpages = resbuf->pages;
+	inpages = buf->pages;
 	/* XXX: Would be better to write some xdr helper functions for
 	 * nfs{2,3,4}xdr.c that place the data right, instead of copying: */
 
@@ -1845,19 +1856,19 @@ svcauth_gss_wrap_resp_priv(struct svc_rqst *rqstp)
 	 * there is RPC_MAX_AUTH_SIZE slack space available in
 	 * both the head and tail.
 	 */
-	if (resbuf->tail[0].iov_base) {
-		if (resbuf->tail[0].iov_base >=
-			resbuf->head[0].iov_base + PAGE_SIZE)
+	if (buf->tail[0].iov_base) {
+		if (buf->tail[0].iov_base >=
+			buf->head[0].iov_base + PAGE_SIZE)
 			return -EINVAL;
-		if (resbuf->tail[0].iov_base < resbuf->head[0].iov_base)
+		if (buf->tail[0].iov_base < buf->head[0].iov_base)
 			return -EINVAL;
-		if (resbuf->tail[0].iov_len + resbuf->head[0].iov_len
+		if (buf->tail[0].iov_len + buf->head[0].iov_len
 				+ 2 * RPC_MAX_AUTH_SIZE > PAGE_SIZE)
 			return -ENOMEM;
-		memmove(resbuf->tail[0].iov_base + RPC_MAX_AUTH_SIZE,
-			resbuf->tail[0].iov_base,
-			resbuf->tail[0].iov_len);
-		resbuf->tail[0].iov_base += RPC_MAX_AUTH_SIZE;
+		memmove(buf->tail[0].iov_base + RPC_MAX_AUTH_SIZE,
+			buf->tail[0].iov_base,
+			buf->tail[0].iov_len);
+		buf->tail[0].iov_base += RPC_MAX_AUTH_SIZE;
 	}
 	/*
 	 * If there is no current tail data, make sure there is
@@ -1866,21 +1877,22 @@ svcauth_gss_wrap_resp_priv(struct svc_rqst *rqstp)
 	 * is RPC_MAX_AUTH_SIZE slack space available in both the
 	 * head and tail.
 	 */
-	if (resbuf->tail[0].iov_base == NULL) {
-		if (resbuf->head[0].iov_len + 2*RPC_MAX_AUTH_SIZE > PAGE_SIZE)
+	if (!buf->tail[0].iov_base) {
+		if (buf->head[0].iov_len + 2 * RPC_MAX_AUTH_SIZE > PAGE_SIZE)
 			return -ENOMEM;
-		resbuf->tail[0].iov_base = resbuf->head[0].iov_base
-			+ resbuf->head[0].iov_len + RPC_MAX_AUTH_SIZE;
-		resbuf->tail[0].iov_len = 0;
+		buf->tail[0].iov_base = buf->head[0].iov_base
+			+ buf->head[0].iov_len + RPC_MAX_AUTH_SIZE;
+		buf->tail[0].iov_len = 0;
 	}
-	if (gss_wrap(gsd->rsci->mechctx, offset, resbuf, inpages))
+	if (gss_wrap(gsd->rsci->mechctx, offset, buf, inpages))
 		return -ENOMEM;
-	*len = htonl(resbuf->len - offset);
-	pad = 3 - ((resbuf->len - offset - 1)&3);
-	p = (__be32 *)(resbuf->tail[0].iov_base + resbuf->tail[0].iov_len);
+	*lenp = htonl(buf->len - offset);
+	pad = 3 - ((buf->len - offset - 1) & 3);
+	p = (__be32 *)(buf->tail[0].iov_base + buf->tail[0].iov_len);
 	memset(p, 0, pad);
-	resbuf->tail[0].iov_len += pad;
-	resbuf->len += pad;
+	buf->tail[0].iov_len += pad;
+	buf->len += pad;
+
 	return 0;
 }
 
@@ -1922,7 +1934,7 @@ svcauth_gss_release(struct svc_rqst *rqstp)
 			goto out_err;
 		break;
 	case RPC_GSS_SVC_PRIVACY:
-		stat = svcauth_gss_wrap_resp_priv(rqstp);
+		stat = svcauth_gss_wrap_priv(rqstp);
 		if (stat)
 			goto out_err;
 		break;



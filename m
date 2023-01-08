Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 435E66616BB
	for <lists+linux-nfs@lfdr.de>; Sun,  8 Jan 2023 17:32:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230323AbjAHQc4 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sun, 8 Jan 2023 11:32:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236174AbjAHQ2n (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sun, 8 Jan 2023 11:28:43 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25D5BD2FC
        for <linux-nfs@vger.kernel.org>; Sun,  8 Jan 2023 08:28:41 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 17C28B801C1
        for <linux-nfs@vger.kernel.org>; Sun,  8 Jan 2023 16:28:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A87ABC433D2
        for <linux-nfs@vger.kernel.org>; Sun,  8 Jan 2023 16:28:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673195317;
        bh=QJuJWSyOSQRwAyRn2YOsINULzLUYJplZ8WlDYg5Qhrs=;
        h=Subject:From:To:Date:In-Reply-To:References:From;
        b=OnnZGh/0pyCunuWghP5WnFk3E0Gez22Aa55OgzpA13MRTyxSTLB2BL2jFbWlUAzN1
         LLsgBRb/8jD+o0gSl9X2hjrGmlptY1fEalqTRLHCShxtHiuKz4S/42TEQRJOXMghEh
         gLrD36MjRlBkC9hDidoY1NxRsXKdDrjM3KskyAfvPYQ+YVFVkLV5gV/dV3FFZ14tXM
         lP0ESMtZ2qV5P4IjX021NPkKM1C4fPLIxngtAOjn6z/YGDUfH86wUK5VEbr5rtN2b+
         9PHNks9FHMYjpYRDe9rrWdXsLzoSmS5ninVYaBbg49OnOYcDckKCIl+p47Qa9/Brr1
         WDogwvr14hC4A==
Subject: [PATCH v1 02/27] SUNRPC: Rename automatic variables in
 svcauth_gss_wrap_resp_integ()
From:   Chuck Lever <cel@kernel.org>
To:     linux-nfs@vger.kernel.org
Date:   Sun, 08 Jan 2023 11:28:36 -0500
Message-ID: <167319531676.7490.8981785713795990569.stgit@bazille.1015granger.net>
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

Clean up: To help orient readers, name the stack variables to match
the XDR field names.

Additionally, the explicit type cast on @gsd is unnecessary; and
@resbuf is renamed to match the variable naming in the unwrap
functions.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 net/sunrpc/auth_gss/svcauth_gss.c |   70 +++++++++++++++++++++++--------------
 1 file changed, 43 insertions(+), 27 deletions(-)

diff --git a/net/sunrpc/auth_gss/svcauth_gss.c b/net/sunrpc/auth_gss/svcauth_gss.c
index 4a576ed7aa32..fe0bd0ad8ace 100644
--- a/net/sunrpc/auth_gss/svcauth_gss.c
+++ b/net/sunrpc/auth_gss/svcauth_gss.c
@@ -1758,49 +1758,65 @@ svcauth_gss_prepare_to_wrap(struct xdr_buf *resbuf, struct gss_svc_data *gsd)
 	return p;
 }
 
-static inline int
-svcauth_gss_wrap_resp_integ(struct svc_rqst *rqstp)
+/*
+ * RFC 2203, Section 5.3.2.2
+ *
+ *	struct rpc_gss_integ_data {
+ *		opaque databody_integ<>;
+ *		opaque checksum<>;
+ *	};
+ *
+ *	struct rpc_gss_data_t {
+ *		unsigned int seq_num;
+ *		proc_req_arg_t arg;
+ *	};
+ *
+ * The RPC Reply message has already been XDR-encoded. rq_res_stream
+ * is now positioned so that the checksum can be written just past
+ * the RPC Reply message.
+ */
+static int svcauth_gss_wrap_integ(struct svc_rqst *rqstp)
 {
-	struct gss_svc_data *gsd = (struct gss_svc_data *)rqstp->rq_auth_data;
+	struct gss_svc_data *gsd = rqstp->rq_auth_data;
 	struct rpc_gss_wire_cred *gc = &gsd->clcred;
-	struct xdr_buf *resbuf = &rqstp->rq_res;
-	struct xdr_buf integ_buf;
-	struct xdr_netobj mic;
+	struct xdr_buf *buf = &rqstp->rq_res;
+	struct xdr_buf databody_integ;
+	struct xdr_netobj checksum;
 	struct kvec *resv;
+	u32 offset, len;
 	__be32 *p;
-	int integ_offset, integ_len;
 	int stat = -EINVAL;
 
-	p = svcauth_gss_prepare_to_wrap(resbuf, gsd);
+	p = svcauth_gss_prepare_to_wrap(buf, gsd);
 	if (p == NULL)
 		goto out;
-	integ_offset = (u8 *)(p + 1) - (u8 *)resbuf->head[0].iov_base;
-	integ_len = resbuf->len - integ_offset;
-	if (integ_len & 3)
+	offset = (u8 *)(p + 1) - (u8 *)buf->head[0].iov_base;
+	len = buf->len - offset;
+	if (len & 3)
 		goto out;
-	*p++ = htonl(integ_len);
+	*p++ = htonl(len);
 	*p++ = htonl(gc->gc_seq);
-	if (xdr_buf_subsegment(resbuf, &integ_buf, integ_offset, integ_len)) {
+	if (xdr_buf_subsegment(buf, &databody_integ, offset, len)) {
 		WARN_ON_ONCE(1);
 		goto out_err;
 	}
-	if (resbuf->tail[0].iov_base == NULL) {
-		if (resbuf->head[0].iov_len + RPC_MAX_AUTH_SIZE > PAGE_SIZE)
+	if (!buf->tail[0].iov_base) {
+		if (buf->head[0].iov_len + RPC_MAX_AUTH_SIZE > PAGE_SIZE)
 			goto out_err;
-		resbuf->tail[0].iov_base = resbuf->head[0].iov_base
-						+ resbuf->head[0].iov_len;
-		resbuf->tail[0].iov_len = 0;
+		buf->tail[0].iov_base = buf->head[0].iov_base
+						+ buf->head[0].iov_len;
+		buf->tail[0].iov_len = 0;
 	}
-	resv = &resbuf->tail[0];
-	mic.data = (u8 *)resv->iov_base + resv->iov_len + 4;
-	if (gss_get_mic(gsd->rsci->mechctx, &integ_buf, &mic))
+	resv = &buf->tail[0];
+	checksum.data = (u8 *)resv->iov_base + resv->iov_len + 4;
+	if (gss_get_mic(gsd->rsci->mechctx, &databody_integ, &checksum))
 		goto out_err;
-	svc_putnl(resv, mic.len);
-	memset(mic.data + mic.len, 0,
-			round_up_to_quad(mic.len) - mic.len);
-	resv->iov_len += XDR_QUADLEN(mic.len) << 2;
+	svc_putnl(resv, checksum.len);
+	memset(checksum.data + checksum.len, 0,
+	       round_up_to_quad(checksum.len) - checksum.len);
+	resv->iov_len += XDR_QUADLEN(checksum.len) << 2;
 	/* not strictly required: */
-	resbuf->len += XDR_QUADLEN(mic.len) << 2;
+	buf->len += XDR_QUADLEN(checksum.len) << 2;
 	if (resv->iov_len > PAGE_SIZE)
 		goto out_err;
 out:
@@ -1909,7 +1925,7 @@ svcauth_gss_release(struct svc_rqst *rqstp)
 	case RPC_GSS_SVC_NONE:
 		break;
 	case RPC_GSS_SVC_INTEGRITY:
-		stat = svcauth_gss_wrap_resp_integ(rqstp);
+		stat = svcauth_gss_wrap_integ(rqstp);
 		if (stat)
 			goto out_err;
 		break;



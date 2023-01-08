Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EAFCD6616AC
	for <lists+linux-nfs@lfdr.de>; Sun,  8 Jan 2023 17:30:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233213AbjAHQas (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sun, 8 Jan 2023 11:30:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236241AbjAHQaa (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sun, 8 Jan 2023 11:30:30 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F542DF08
        for <linux-nfs@vger.kernel.org>; Sun,  8 Jan 2023 08:30:25 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 51A80B80B36
        for <linux-nfs@vger.kernel.org>; Sun,  8 Jan 2023 16:30:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5C91C433F0
        for <linux-nfs@vger.kernel.org>; Sun,  8 Jan 2023 16:30:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673195423;
        bh=INNCOm/g3LiZmDobA6j++20wBCKNLNFkWa8CN7nJwCU=;
        h=Subject:From:To:Date:In-Reply-To:References:From;
        b=bDCg4joVhnQkLiTBIxkI5TLKjPz+y2rYJZIxCWW2ihQVwEfyZfxykKSwOcABpDwTW
         LwJB2WQsxlJfgGF9KLXC/S9uQanAIK+SwK9XjNGWNyP91awi/r+QajSnpF2Oy/Qve9
         PD2bqKAEYZvNsK2xwfL1iGgaK73u/uAprPJpKXvM8WzOpypSKtmAalK7yQhPE8m1Ei
         EPQx5sVi4I8z7H59ak8mDRb+ltPojqTcGS2f+De4Vh/B9nkXHjKNGvm9eQMa3Zg6rB
         qvY2LyeOkAaG1nTB/FtSWqjcSLaiTrYCdWG0S/ko5PZ0EMJTwWz+r2SAHgMYgY7Dgq
         n0QYrOaq+7bFA==
Subject: [PATCH v1 19/27] SUNRPC: Use xdr_stream to encode replies in
 server-side GSS upcall helpers
From:   Chuck Lever <cel@kernel.org>
To:     linux-nfs@vger.kernel.org
Date:   Sun, 08 Jan 2023 11:30:22 -0500
Message-ID: <167319542203.7490.329164343640966404.stgit@bazille.1015granger.net>
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

This code constructs replies to the decorated NULL procedure calls
that establish GSS contexts. Convert this code path to use struct
xdr_stream to encode such responses.

Done as part of hardening the server-side RPC header encoding path.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 net/sunrpc/auth_gss/svcauth_gss.c |  144 +++++++++++++++++++++++--------------
 1 file changed, 90 insertions(+), 54 deletions(-)

diff --git a/net/sunrpc/auth_gss/svcauth_gss.c b/net/sunrpc/auth_gss/svcauth_gss.c
index fd1fd4143a8e..9f3633c42ebd 100644
--- a/net/sunrpc/auth_gss/svcauth_gss.c
+++ b/net/sunrpc/auth_gss/svcauth_gss.c
@@ -77,6 +77,7 @@ struct gss_svc_data {
 	struct rsc			*rsci;
 
 	/* for temporary results */
+	__be32				gsd_seq_num;
 	u8				gsd_scratch[GSS_SCRATCH_SIZE];
 };
 
@@ -771,20 +772,6 @@ svcauth_gss_verify_header(struct svc_rqst *rqstp, struct rsc *rsci,
 	return SVC_OK;
 }
 
-static int
-gss_write_null_verf(struct svc_rqst *rqstp)
-{
-	__be32     *p;
-
-	svc_putnl(rqstp->rq_res.head, RPC_AUTH_NULL);
-	p = rqstp->rq_res.head->iov_base + rqstp->rq_res.head->iov_len;
-	/* don't really need to check if head->iov_len > PAGE_SIZE ... */
-	*p++ = 0;
-	if (!xdr_ressize_check(rqstp, p))
-		return -1;
-	return 0;
-}
-
 static int
 gss_write_verf(struct svc_rqst *rqstp, struct gss_ctx *ctx_id, u32 seq)
 {
@@ -821,6 +808,38 @@ gss_write_verf(struct svc_rqst *rqstp, struct gss_ctx *ctx_id, u32 seq)
 	return err;
 }
 
+/*
+ * Construct and encode a Reply's verifier field. The verifier's body
+ * field contains a variable-length checksum of the GSS sequence
+ * number.
+ */
+static bool
+svcauth_gss_encode_verf(struct svc_rqst *rqstp, struct gss_ctx *ctx_id, u32 seq)
+{
+	struct gss_svc_data	*gsd = rqstp->rq_auth_data;
+	u32			maj_stat;
+	struct xdr_buf		verf_data;
+	struct xdr_netobj	checksum;
+	struct kvec		iov;
+
+	gsd->gsd_seq_num = cpu_to_be32(seq);
+	iov.iov_base = &gsd->gsd_seq_num;
+	iov.iov_len = XDR_UNIT;
+	xdr_buf_from_iov(&iov, &verf_data);
+
+	checksum.data = gsd->gsd_scratch;
+	maj_stat = gss_get_mic(ctx_id, &verf_data, &checksum);
+	if (maj_stat != GSS_S_COMPLETE)
+		goto bad_mic;
+
+	return xdr_stream_encode_opaque_auth(&rqstp->rq_res_stream, RPC_AUTH_GSS,
+					     checksum.data, checksum.len) > 0;
+
+bad_mic:
+	trace_rpcgss_svc_get_mic(rqstp, maj_stat);
+	return false;
+}
+
 struct gss_domain {
 	struct auth_domain	h;
 	u32			pseudoflavor;
@@ -1057,23 +1076,29 @@ svcauth_gss_set_client(struct svc_rqst *rqstp)
 	return SVC_OK;
 }
 
-static inline int
-gss_write_init_verf(struct cache_detail *cd, struct svc_rqst *rqstp,
-		struct xdr_netobj *out_handle, int *major_status)
+static bool
+svcauth_gss_proc_init_verf(struct cache_detail *cd, struct svc_rqst *rqstp,
+			   struct xdr_netobj *out_handle, int *major_status,
+			   u32 seq_num)
 {
+	struct xdr_stream *xdr = &rqstp->rq_res_stream;
 	struct rsc *rsci;
-	int        rc;
+	bool rc;
 
 	if (*major_status != GSS_S_COMPLETE)
-		return gss_write_null_verf(rqstp);
+		goto null_verifier;
 	rsci = gss_svc_searchbyctx(cd, out_handle);
 	if (rsci == NULL) {
 		*major_status = GSS_S_NO_CONTEXT;
-		return gss_write_null_verf(rqstp);
+		goto null_verifier;
 	}
-	rc = gss_write_verf(rqstp, rsci->mechctx, GSS_SEQ_WIN);
+
+	rc = svcauth_gss_encode_verf(rqstp, rsci->mechctx, seq_num);
 	cache_put(&rsci->h, cd);
 	return rc;
+
+null_verifier:
+	return xdr_stream_encode_opaque_auth(xdr, RPC_AUTH_NULL, NULL, 0) > 0;
 }
 
 static void gss_free_in_token_pages(struct gssp_in_token *in_token)
@@ -1163,24 +1188,35 @@ static int gss_read_proxy_verf(struct svc_rqst *rqstp,
 	return SVC_DENIED;
 }
 
-static inline int
-gss_write_resv(struct kvec *resv, size_t size_limit,
-	       struct xdr_netobj *out_handle, struct xdr_netobj *out_token,
-	       int major_status, int minor_status)
+/*
+ * RFC 2203, Section 5.2.3.1.
+ *
+ *	struct rpc_gss_init_res {
+ *		opaque handle<>;
+ *		unsigned int gss_major;
+ *		unsigned int gss_minor;
+ *		unsigned int seq_window;
+ *		opaque gss_token<>;
+ *	};
+ */
+static bool
+svcxdr_encode_gss_init_res(struct xdr_stream *xdr,
+			   struct xdr_netobj *handle,
+			   struct xdr_netobj *gss_token,
+			   unsigned int major_status,
+			   unsigned int minor_status, u32 seq_num)
 {
-	if (resv->iov_len + 4 > size_limit)
-		return -1;
-	svc_putnl(resv, RPC_SUCCESS);
-	if (svc_safe_putnetobj(resv, out_handle))
-		return -1;
-	if (resv->iov_len + 3 * 4 > size_limit)
-		return -1;
-	svc_putnl(resv, major_status);
-	svc_putnl(resv, minor_status);
-	svc_putnl(resv, GSS_SEQ_WIN);
-	if (svc_safe_putnetobj(resv, out_token))
-		return -1;
-	return 0;
+	if (xdr_stream_encode_opaque(xdr, handle->data, handle->len) < 0)
+		return false;
+	if (xdr_stream_encode_u32(xdr, major_status) < 0)
+		return false;
+	if (xdr_stream_encode_u32(xdr, minor_status) < 0)
+		return false;
+	if (xdr_stream_encode_u32(xdr, seq_num) < 0)
+		return false;
+	if (xdr_stream_encode_opaque(xdr, gss_token->data, gss_token->len) < 0)
+		return false;
+	return true;
 }
 
 /*
@@ -1195,7 +1231,6 @@ svcauth_gss_legacy_init(struct svc_rqst *rqstp,
 			struct rpc_gss_wire_cred *gc)
 {
 	struct xdr_stream *xdr = &rqstp->rq_arg_stream;
-	struct kvec *resv = &rqstp->rq_res.head[0];
 	struct rsi *rsip, rsikey;
 	__be32 *p;
 	u32 len;
@@ -1240,17 +1275,17 @@ svcauth_gss_legacy_init(struct svc_rqst *rqstp,
 		return SVC_CLOSE;
 
 	ret = SVC_CLOSE;
-	/* Got an answer to the upcall; use it: */
-	if (gss_write_init_verf(sn->rsc_cache, rqstp,
-				&rsip->out_handle, &rsip->major_status))
+	if (!svcauth_gss_proc_init_verf(sn->rsc_cache, rqstp, &rsip->out_handle,
+					&rsip->major_status, GSS_SEQ_WIN))
+		goto out;
+	if (xdr_stream_encode_u32(&rqstp->rq_res_stream, RPC_SUCCESS) < 0)
 		goto out;
-	if (gss_write_resv(resv, PAGE_SIZE,
-			   &rsip->out_handle, &rsip->out_token,
-			   rsip->major_status, rsip->minor_status))
+	if (!svcxdr_encode_gss_init_res(&rqstp->rq_res_stream, &rsip->out_handle,
+					&rsip->out_token, rsip->major_status,
+					rsip->minor_status, GSS_SEQ_WIN))
 		goto out;
 
 	ret = SVC_COMPLETE;
-	svcxdr_init_encode(rqstp);
 out:
 	cache_put(&rsip->h, sn->rsi_cache);
 	return ret;
@@ -1331,7 +1366,6 @@ static int gss_proxy_save_rsc(struct cache_detail *cd,
 static int svcauth_gss_proxy_init(struct svc_rqst *rqstp,
 				  struct rpc_gss_wire_cred *gc)
 {
-	struct kvec *resv = &rqstp->rq_res.head[0];
 	struct xdr_netobj cli_handle;
 	struct gssp_upcall_data ud;
 	uint64_t handle;
@@ -1369,17 +1403,17 @@ static int svcauth_gss_proxy_init(struct svc_rqst *rqstp,
 		goto out;
 	}
 
-	/* Got an answer to the upcall; use it: */
-	if (gss_write_init_verf(sn->rsc_cache, rqstp,
-				&cli_handle, &ud.major_status))
+	if (!svcauth_gss_proc_init_verf(sn->rsc_cache, rqstp, &cli_handle,
+					&ud.major_status, GSS_SEQ_WIN))
+		goto out;
+	if (xdr_stream_encode_u32(&rqstp->rq_res_stream, RPC_SUCCESS) < 0)
 		goto out;
-	if (gss_write_resv(resv, PAGE_SIZE,
-			   &cli_handle, &ud.out_token,
-			   ud.major_status, ud.minor_status))
+	if (!svcxdr_encode_gss_init_res(&rqstp->rq_res_stream, &cli_handle,
+					&ud.out_token, ud.major_status,
+					ud.minor_status, GSS_SEQ_WIN))
 		goto out;
 
 	ret = SVC_COMPLETE;
-	svcxdr_init_encode(rqstp);
 out:
 	gss_free_in_token_pages(&ud.in_token);
 	gssp_free_upcall_data(&ud);
@@ -1420,6 +1454,8 @@ svcauth_gss_proc_init(struct svc_rqst *rqstp, struct rpc_gss_wire_cred *gc)
 	u32 flavor, len;
 	void *body;
 
+	svcxdr_init_encode(rqstp);
+
 	/* Call's verf field: */
 	if (xdr_stream_decode_opaque_auth(xdr, &flavor, &body, &len) < 0)
 		return SVC_GARBAGE;



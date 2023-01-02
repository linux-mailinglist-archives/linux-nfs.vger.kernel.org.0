Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C06865B58E
	for <lists+linux-nfs@lfdr.de>; Mon,  2 Jan 2023 18:07:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236371AbjABRHX (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 2 Jan 2023 12:07:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236579AbjABRHT (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 2 Jan 2023 12:07:19 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 295B564DB
        for <linux-nfs@vger.kernel.org>; Mon,  2 Jan 2023 09:07:18 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 93F37CE0F52
        for <linux-nfs@vger.kernel.org>; Mon,  2 Jan 2023 17:07:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B51E9C433F0
        for <linux-nfs@vger.kernel.org>; Mon,  2 Jan 2023 17:07:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672679234;
        bh=GcyTyOggW3Fr6yVBAW6VbjE6w9pB151Ht/6VDGX9cpk=;
        h=Subject:From:To:Date:In-Reply-To:References:From;
        b=kRhYq0Rm4zRFvivcnKWj44MGUyg+7aKwuVbMTlZQxQPvql0jbJs0/fWM8sLOPg/eZ
         834+7EV4SC2PDkUeojA1Wy69Bn1KpUFa6McL7oMAhYRUgMTZbMFX0/lBFMW9S5brmE
         jOzafdc9Tjd3xxbTxk7pn2tPXOhASSApWpaz4usJBeH5oLlMPhiCZihzkDb2xjt9SR
         DMBoWYrRdA+AtekRR+qn4crDx0SRncP5A8YlPeV6cBKHI3OtRYRd60vlj7mEonoOOu
         dmdKcJwXfluR5f4xeNhfVH10cJ9oybWvHi+d8kWOWnkT+08yHSSXCVaSFCSQVKROeU
         cue7IYWP/11zA==
Subject: [PATCH v1 17/25] SUNRPC: Convert gss_verify_header() to use
 xdr_stream
From:   Chuck Lever <cel@kernel.org>
To:     linux-nfs@vger.kernel.org
Date:   Mon, 02 Jan 2023 12:07:13 -0500
Message-ID: <167267923366.112521.15506615282501947073.stgit@manet.1015granger.net>
In-Reply-To: <167267753484.112521.4826748148788735127.stgit@manet.1015granger.net>
References: <167267753484.112521.4826748148788735127.stgit@manet.1015granger.net>
User-Agent: StGit/1.5.dev2+g9ce680a5
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

Done as part of hardening the server-side RPC header decoding path.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 net/sunrpc/auth_gss/svcauth_gss.c |   52 +++++++++++++++++++++----------------
 1 file changed, 29 insertions(+), 23 deletions(-)

diff --git a/net/sunrpc/auth_gss/svcauth_gss.c b/net/sunrpc/auth_gss/svcauth_gss.c
index 074bfe9fb838..8362fc143754 100644
--- a/net/sunrpc/auth_gss/svcauth_gss.c
+++ b/net/sunrpc/auth_gss/svcauth_gss.c
@@ -732,38 +732,48 @@ svc_safe_putnetobj(struct kvec *resv, struct xdr_netobj *o)
 }
 
 /*
- * Verify the checksum on the header and return SVC_OK on success.
- * Otherwise, return SVC_DROP (in the case of a bad sequence number)
- * or return SVC_DENIED and indicate error in rqstp->rq_auth_stat.
+ * Decode and verify a Call's verifier field. For RPC_AUTH_GSS Calls,
+ * the body of this field contains a variable length checksum.
+ *
+ * GSS-specific auth_stat values are mandated by RFC 2203 Section
+ * 5.3.3.3.
  */
 static int
-gss_verify_header(struct svc_rqst *rqstp, struct rsc *rsci,
-		  __be32 *rpcstart, struct rpc_gss_wire_cred *gc)
+svcauth_gss_verify_header(struct svc_rqst *rqstp, struct rsc *rsci,
+			  __be32 *rpcstart, struct rpc_gss_wire_cred *gc)
 {
+	struct xdr_stream	*xdr = &rqstp->rq_arg_stream;
 	struct gss_ctx		*ctx_id = rsci->mechctx;
+	u32			flavor, maj_stat;
 	struct xdr_buf		rpchdr;
 	struct xdr_netobj	checksum;
-	u32			flavor = 0;
-	struct kvec		*argv = &rqstp->rq_arg.head[0];
 	struct kvec		iov;
 
-	/* data to compute the checksum over: */
+	/*
+	 * Compute the checksum of the incoming Call from the
+	 * XID field to credential field:
+	 */
 	iov.iov_base = rpcstart;
-	iov.iov_len = (u8 *)argv->iov_base - (u8 *)rpcstart;
+	iov.iov_len = (u8 *)xdr->p - (u8 *)rpcstart;
 	xdr_buf_from_iov(&iov, &rpchdr);
 
-	rqstp->rq_auth_stat = rpc_autherr_badverf;
-	if (argv->iov_len < 4)
-		return SVC_DENIED;
-	flavor = svc_getnl(argv);
-	if (flavor != RPC_AUTH_GSS)
+	/* Call's verf field: */
+	if (xdr_stream_decode_opaque_auth(xdr, &flavor,
+					  (void **)&checksum.data,
+					  &checksum.len) < 0) {
+		rqstp->rq_auth_stat = rpc_autherr_badverf;
 		return SVC_DENIED;
-	if (svc_safe_getnetobj(argv, &checksum))
+	}
+	if (flavor != RPC_AUTH_GSS) {
+		rqstp->rq_auth_stat = rpc_autherr_badverf;
 		return SVC_DENIED;
+	}
 
-	if (rqstp->rq_deferred) /* skip verification of revisited request */
+	if (rqstp->rq_deferred)
 		return SVC_OK;
-	if (gss_verify_mic(ctx_id, &rpchdr, &checksum) != GSS_S_COMPLETE) {
+	maj_stat = gss_verify_mic(ctx_id, &rpchdr, &checksum);
+	if (maj_stat != GSS_S_COMPLETE) {
+		trace_rpcgss_svc_mic(rqstp, maj_stat);
 		rqstp->rq_auth_stat = rpcsec_gsserr_credproblem;
 		return SVC_DENIED;
 	}
@@ -1431,8 +1441,6 @@ svcauth_gss_proc_init(struct svc_rqst *rqstp, struct rpc_gss_wire_cred *gc)
 	u32 flavor, len;
 	void *body;
 
-	svcxdr_init_decode(rqstp);
-
 	/* Call's verf field: */
 	if (xdr_stream_decode_opaque_auth(xdr, &flavor, &body, &len) < 0)
 		return SVC_GARBAGE;
@@ -1603,6 +1611,7 @@ svcauth_gss_accept(struct svc_rqst *rqstp)
 	if ((gc->gc_proc != RPC_GSS_PROC_DATA) && (rqstp->rq_proc != 0))
 		goto auth_err;
 
+	svcxdr_init_decode(rqstp);
 	rqstp->rq_auth_stat = rpc_autherr_badverf;
 	switch (gc->gc_proc) {
 	case RPC_GSS_PROC_INIT:
@@ -1615,7 +1624,7 @@ svcauth_gss_accept(struct svc_rqst *rqstp)
 		rsci = gss_svc_searchbyctx(sn->rsc_cache, &gc->gc_ctx);
 		if (!rsci)
 			goto auth_err;
-		switch (gss_verify_header(rqstp, rsci, rpcstart, gc)) {
+		switch (svcauth_gss_verify_header(rqstp, rsci, rpcstart, gc)) {
 		case SVC_OK:
 			break;
 		case SVC_DENIED:
@@ -1650,13 +1659,11 @@ svcauth_gss_accept(struct svc_rqst *rqstp)
 		rqstp->rq_auth_stat = rpc_autherr_badcred;
 		switch (gc->gc_svc) {
 		case RPC_GSS_SVC_NONE:
-			svcxdr_init_decode(rqstp);
 			break;
 		case RPC_GSS_SVC_INTEGRITY:
 			/* placeholders for length and seq. number: */
 			svc_putnl(resv, 0);
 			svc_putnl(resv, 0);
-			svcxdr_init_decode(rqstp);
 			if (svcauth_gss_unwrap_integ(rqstp, gc->gc_seq,
 						     rsci->mechctx))
 				goto garbage_args;
@@ -1666,7 +1673,6 @@ svcauth_gss_accept(struct svc_rqst *rqstp)
 			/* placeholders for length and seq. number: */
 			svc_putnl(resv, 0);
 			svc_putnl(resv, 0);
-			svcxdr_init_decode(rqstp);
 			if (svcauth_gss_unwrap_priv(rqstp, gc->gc_seq,
 						    rsci->mechctx))
 				goto garbage_args;



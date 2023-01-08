Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A08EB6616AB
	for <lists+linux-nfs@lfdr.de>; Sun,  8 Jan 2023 17:30:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233340AbjAHQat (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sun, 8 Jan 2023 11:30:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236283AbjAHQae (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sun, 8 Jan 2023 11:30:34 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD26B3889
        for <linux-nfs@vger.kernel.org>; Sun,  8 Jan 2023 08:30:31 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 819A1B801C1
        for <linux-nfs@vger.kernel.org>; Sun,  8 Jan 2023 16:30:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19594C433D2
        for <linux-nfs@vger.kernel.org>; Sun,  8 Jan 2023 16:30:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673195429;
        bh=ZQtoZtpcqBotzMxf+p0JnDbZAqwIG6/NqjwEfdrNiFk=;
        h=Subject:From:To:Date:In-Reply-To:References:From;
        b=oeHX1FGJYS6Xj55Xm+86rjJYTyHQvu3SBYOuHqssTB8fC/e31Ytc2B7Hk7gI1C6HK
         hAtziFrys2/e7ZTM5CI3hy0DApLwYmCtnE9CYREEt1fzN7nlzJ6tW77aVb9O7+RL6L
         ScTVtbqOXxPQiG3Jj19nDw6bch3ZSMMxY+Hcfwdefi95sp9qWieQ4pEHItujEasTuR
         yIIxJvD/ej1T8CtGPTdHo6R01dgU+Dp5c8HV/ecZkZOdVb68FcbCvTdAGAmI8krg1E
         vS3PEb5wBsukAao3QbCcjRTmgQN+o1nd6RTpd6p8QUZhzzt7R0CtFSwodn8+aB1eVH
         WOyTIDYbN3oAw==
Subject: [PATCH v1 20/27] SUNRPC: Use xdr_stream for encoding GSS reply
 verifiers
From:   Chuck Lever <cel@kernel.org>
To:     linux-nfs@vger.kernel.org
Date:   Sun, 08 Jan 2023 11:30:28 -0500
Message-ID: <167319542822.7490.6255372906469543368.stgit@bazille.1015granger.net>
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

Done as part of hardening the server-side RPC header encoding path.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 net/sunrpc/auth_gss/svcauth_gss.c |   81 ++++---------------------------------
 1 file changed, 8 insertions(+), 73 deletions(-)

diff --git a/net/sunrpc/auth_gss/svcauth_gss.c b/net/sunrpc/auth_gss/svcauth_gss.c
index 9f3633c42ebd..89333669af26 100644
--- a/net/sunrpc/auth_gss/svcauth_gss.c
+++ b/net/sunrpc/auth_gss/svcauth_gss.c
@@ -693,28 +693,6 @@ static bool gss_check_seq_num(const struct svc_rqst *rqstp, struct rsc *rsci,
 	goto out;
 }
 
-static inline u32 round_up_to_quad(u32 i)
-{
-	return (i + 3 ) & ~3;
-}
-
-static inline int
-svc_safe_putnetobj(struct kvec *resv, struct xdr_netobj *o)
-{
-	u8 *p;
-
-	if (resv->iov_len + 4 > PAGE_SIZE)
-		return -1;
-	svc_putnl(resv, o->len);
-	p = resv->iov_base + resv->iov_len;
-	resv->iov_len += round_up_to_quad(o->len);
-	if (resv->iov_len > PAGE_SIZE)
-		return -1;
-	memcpy(p, o->data, o->len);
-	memset(p + o->len, 0, round_up_to_quad(o->len) - o->len);
-	return 0;
-}
-
 /*
  * Decode and verify a Call's verifier field. For RPC_AUTH_GSS Calls,
  * the body of this field contains a variable length checksum.
@@ -772,42 +750,6 @@ svcauth_gss_verify_header(struct svc_rqst *rqstp, struct rsc *rsci,
 	return SVC_OK;
 }
 
-static int
-gss_write_verf(struct svc_rqst *rqstp, struct gss_ctx *ctx_id, u32 seq)
-{
-	__be32			*xdr_seq;
-	u32			maj_stat;
-	struct xdr_buf		verf_data;
-	struct xdr_netobj	mic;
-	__be32			*p;
-	struct kvec		iov;
-	int err = -1;
-
-	svc_putnl(rqstp->rq_res.head, RPC_AUTH_GSS);
-	xdr_seq = kmalloc(4, GFP_KERNEL);
-	if (!xdr_seq)
-		return -ENOMEM;
-	*xdr_seq = htonl(seq);
-
-	iov.iov_base = xdr_seq;
-	iov.iov_len = 4;
-	xdr_buf_from_iov(&iov, &verf_data);
-	p = rqstp->rq_res.head->iov_base + rqstp->rq_res.head->iov_len;
-	mic.data = (u8 *)(p + 1);
-	maj_stat = gss_get_mic(ctx_id, &verf_data, &mic);
-	if (maj_stat != GSS_S_COMPLETE)
-		goto out;
-	*p++ = htonl(mic.len);
-	memset((u8 *)p + mic.len, 0, round_up_to_quad(mic.len) - mic.len);
-	p += XDR_QUADLEN(mic.len);
-	if (!xdr_ressize_check(rqstp, p))
-		goto out;
-	err = 0;
-out:
-	kfree(xdr_seq);
-	return err;
-}
-
 /*
  * Construct and encode a Reply's verifier field. The verifier's body
  * field contains a variable-length checksum of the GSS sequence
@@ -1454,8 +1396,6 @@ svcauth_gss_proc_init(struct svc_rqst *rqstp, struct rpc_gss_wire_cred *gc)
 	u32 flavor, len;
 	void *body;
 
-	svcxdr_init_encode(rqstp);
-
 	/* Call's verf field: */
 	if (xdr_stream_decode_opaque_auth(xdr, &flavor, &body, &len) < 0)
 		return SVC_GARBAGE;
@@ -1642,15 +1582,15 @@ svcauth_gss_decode_credbody(struct xdr_stream *xdr,
 static int
 svcauth_gss_accept(struct svc_rqst *rqstp)
 {
-	struct kvec	*resv = &rqstp->rq_res.head[0];
 	struct gss_svc_data *svcdata = rqstp->rq_auth_data;
 	__be32		*rpcstart;
 	struct rpc_gss_wire_cred *gc;
 	struct rsc	*rsci = NULL;
-	__be32		*reject_stat = resv->iov_base + resv->iov_len;
 	int		ret;
 	struct sunrpc_net *sn = net_generic(SVC_NET(rqstp), sunrpc_net_id);
 
+	svcxdr_init_encode(rqstp);
+
 	rqstp->rq_auth_stat = rpc_autherr_badcred;
 	if (!svcdata)
 		svcdata = kmalloc(sizeof(*svcdata), GFP_KERNEL);
@@ -1700,28 +1640,25 @@ svcauth_gss_accept(struct svc_rqst *rqstp)
 	/* now act upon the command: */
 	switch (gc->gc_proc) {
 	case RPC_GSS_PROC_DESTROY:
-		if (gss_write_verf(rqstp, rsci->mechctx, gc->gc_seq))
+		if (!svcauth_gss_encode_verf(rqstp, rsci->mechctx, gc->gc_seq))
 			goto auth_err;
 		/* Delete the entry from the cache_list and call cache_put */
 		sunrpc_cache_unhash(sn->rsc_cache, &rsci->h);
-		if (resv->iov_len + 4 > PAGE_SIZE)
-			goto drop;
-		svc_putnl(resv, RPC_SUCCESS);
+		if (xdr_stream_encode_u32(&rqstp->rq_res_stream, RPC_SUCCESS) < 0)
+			goto auth_err;
 		goto complete;
 	case RPC_GSS_PROC_DATA:
 		rqstp->rq_auth_stat = rpcsec_gsserr_ctxproblem;
-		svcdata->verf_start = resv->iov_base + resv->iov_len;
-		if (gss_write_verf(rqstp, rsci->mechctx, gc->gc_seq))
+		svcdata->verf_start = xdr_reserve_space(&rqstp->rq_res_stream, 0);
+		if (!svcauth_gss_encode_verf(rqstp, rsci->mechctx, gc->gc_seq))
 			goto auth_err;
 		rqstp->rq_cred = rsci->cred;
 		get_group_info(rsci->cred.cr_group_info);
 		rqstp->rq_auth_stat = rpc_autherr_badcred;
 		switch (gc->gc_svc) {
 		case RPC_GSS_SVC_NONE:
-			svcxdr_init_encode(rqstp);
 			break;
 		case RPC_GSS_SVC_INTEGRITY:
-			svcxdr_init_encode(rqstp);
 			/* placeholders for body length and seq. number: */
 			xdr_reserve_space(&rqstp->rq_res_stream, XDR_UNIT * 2);
 			if (svcauth_gss_unwrap_integ(rqstp, gc->gc_seq,
@@ -1730,7 +1667,6 @@ svcauth_gss_accept(struct svc_rqst *rqstp)
 			svcxdr_set_auth_slack(rqstp, RPC_MAX_AUTH_SIZE);
 			break;
 		case RPC_GSS_SVC_PRIVACY:
-			svcxdr_init_encode(rqstp);
 			/* placeholders for body length and seq. number: */
 			xdr_reserve_space(&rqstp->rq_res_stream, XDR_UNIT * 2);
 			if (svcauth_gss_unwrap_priv(rqstp, gc->gc_seq,
@@ -1755,8 +1691,7 @@ svcauth_gss_accept(struct svc_rqst *rqstp)
 	ret = SVC_GARBAGE;
 	goto out;
 auth_err:
-	/* Restore write pointer to its original value: */
-	xdr_ressize_check(rqstp, reject_stat);
+	xdr_truncate_encode(&rqstp->rq_res_stream, XDR_UNIT * 2);
 	ret = SVC_DENIED;
 	goto out;
 complete:



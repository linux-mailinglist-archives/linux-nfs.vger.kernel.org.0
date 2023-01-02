Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4324C65B590
	for <lists+linux-nfs@lfdr.de>; Mon,  2 Jan 2023 18:07:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236065AbjABRHc (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 2 Jan 2023 12:07:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232151AbjABRHb (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 2 Jan 2023 12:07:31 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5320F64DB
        for <linux-nfs@vger.kernel.org>; Mon,  2 Jan 2023 09:07:30 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 11A34B80D0D
        for <linux-nfs@vger.kernel.org>; Mon,  2 Jan 2023 17:07:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9BC20C433EF
        for <linux-nfs@vger.kernel.org>; Mon,  2 Jan 2023 17:07:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672679247;
        bh=xFr1Et4mmc2ivYMZ0b2ZdzB+80toJWODP1P3NDbymjE=;
        h=Subject:From:To:Date:In-Reply-To:References:From;
        b=oVjmhqKW7HDgB/Q81R4BvavJFjaAfoFIX6ogkjlupjwx6cdo4fjoMqHR3d/zAunzw
         /0hz5mFVVAlrJWpvL56sC+ugvN7tA5zqlE6PvDa3rcKvtpIaFlcQQl1hUoR+rxyeox
         CMc2u8KRbY9ZS5YM9MivQ+DhfFUBWvaU/xqOoBpcGtqP4odxzUYLpYxOwDs5KnKoWA
         mFyWAhAsH8SHSE7i8Pygt9XqfGUt8eClgkY+vcwYXtJ+RKtKKvzcEWGTecX9FJmqck
         SCG6LPLzO7SVa8XHaJF7uAdjM6fWXKroNp1I9VfEnBoEv8+Y6aaxYqxv6TRkrk5U30
         gyfnFVPXpN96g==
Subject: [PATCH v1 19/25] SUNRPC: Convert the svcauth_gss_accept() pre-amble
 to use xdr_stream
From:   Chuck Lever <cel@kernel.org>
To:     linux-nfs@vger.kernel.org
Date:   Mon, 02 Jan 2023 12:07:26 -0500
Message-ID: <167267924653.112521.14232339859977885172.stgit@manet.1015granger.net>
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
 net/sunrpc/auth_gss/svcauth_gss.c |  125 ++++++++++++++++++++++---------------
 1 file changed, 75 insertions(+), 50 deletions(-)

diff --git a/net/sunrpc/auth_gss/svcauth_gss.c b/net/sunrpc/auth_gss/svcauth_gss.c
index 363c25198547..557de28127fe 100644
--- a/net/sunrpc/auth_gss/svcauth_gss.c
+++ b/net/sunrpc/auth_gss/svcauth_gss.c
@@ -697,23 +697,6 @@ static inline u32 round_up_to_quad(u32 i)
 	return (i + 3 ) & ~3;
 }
 
-static inline int
-svc_safe_getnetobj(struct kvec *argv, struct xdr_netobj *o)
-{
-	int l;
-
-	if (argv->iov_len < 4)
-		return -1;
-	o->len = svc_getnl(argv);
-	l = round_up_to_quad(o->len);
-	if (argv->iov_len < l)
-		return -1;
-	o->data = argv->iov_base;
-	argv->iov_base += l;
-	argv->iov_len -= l;
-	return 0;
-}
-
 static inline int
 svc_safe_putnetobj(struct kvec *resv, struct xdr_netobj *o)
 {
@@ -1553,27 +1536,91 @@ static void destroy_use_gss_proxy_proc_entry(struct net *net) {}
 #endif /* CONFIG_PROC_FS */
 
 /*
- * Accept an rpcsec packet.
- * If context establishment, punt to user space
- * If data exchange, verify/decrypt
- * If context destruction, handle here
- * In the context establishment and destruction case we encode
- * response here and return SVC_COMPLETE.
+ * The Call's credential body should contain a struct rpc_gss_cred_t.
+ *
+ * RFC 2203 Section 5
+ *
+ *	struct rpc_gss_cred_t {
+ *		union switch (unsigned int version) {
+ *		case RPCSEC_GSS_VERS_1:
+ *			struct {
+ *				rpc_gss_proc_t gss_proc;
+ *				unsigned int seq_num;
+ *				rpc_gss_service_t service;
+ *				opaque handle<>;
+ *			} rpc_gss_cred_vers_1_t;
+ *		}
+ *	};
+ */
+static bool
+svcauth_gss_decode_credbody(struct xdr_stream *xdr,
+			    struct rpc_gss_wire_cred *gc,
+			    __be32 **rpcstart)
+{
+	ssize_t handle_len;
+	u32 body_len;
+	__be32 *p;
+
+	p = xdr_inline_decode(xdr, XDR_UNIT);
+	if (!p)
+		return false;
+	/*
+	 * start of rpc packet is 7 u32's back from here:
+	 * xid direction rpcversion prog vers proc flavour
+	 */
+	*rpcstart = p - 7;
+	body_len = be32_to_cpup(p);
+	if (body_len > RPC_MAX_AUTH_SIZE)
+		return false;
+
+	/* struct rpc_gss_cred_t */
+	if (xdr_stream_decode_u32(xdr, &gc->gc_v) < 0)
+		return false;
+	if (xdr_stream_decode_u32(xdr, &gc->gc_proc) < 0)
+		return false;
+	if (xdr_stream_decode_u32(xdr, &gc->gc_seq) < 0)
+		return false;
+	if (xdr_stream_decode_u32(xdr, &gc->gc_svc) < 0)
+		return false;
+	handle_len = xdr_stream_decode_opaque_inline(xdr,
+						     (void **)&gc->gc_ctx.data,
+						     body_len);
+	if (handle_len < 0)
+		return false;
+	if (body_len != XDR_UNIT * 5 + xdr_align_size(handle_len))
+		return false;
+
+	gc->gc_ctx.len = handle_len;
+	return true;
+}
+
+/**
+ * svcauth_gss_accept - Decode and validate incoming RPC_AUTH_GSS credential
+ * @rqstp: RPC transaction
+ *
+ * Return values:
+ *   %SVC_OK: Success
+ *   %SVC_COMPLETE: GSS context lifetime event
+ *   %SVC_DENIED: Credential or verifier is not valid
+ *   %SVC_GARBAGE: Failed to decode credential or verifier
+ *   %SVC_CLOSE: Temporary failure
+ *
+ * The rqstp->rq_auth_stat field is also set (see RFCs 2203 and 5531).
  */
 static int
 svcauth_gss_accept(struct svc_rqst *rqstp)
 {
-	struct kvec	*argv = &rqstp->rq_arg.head[0];
 	struct kvec	*resv = &rqstp->rq_res.head[0];
-	u32		crlen;
 	struct gss_svc_data *svcdata = rqstp->rq_auth_data;
+	__be32		*rpcstart;
 	struct rpc_gss_wire_cred *gc;
 	struct rsc	*rsci = NULL;
-	__be32		*rpcstart;
 	__be32		*reject_stat = resv->iov_base + resv->iov_len;
 	int		ret;
 	struct sunrpc_net *sn = net_generic(SVC_NET(rqstp), sunrpc_net_id);
 
+	svcxdr_init_decode(rqstp);
+
 	rqstp->rq_auth_stat = rpc_autherr_badcred;
 	if (!svcdata)
 		svcdata = kmalloc(sizeof(*svcdata), GFP_KERNEL);
@@ -1584,31 +1631,10 @@ svcauth_gss_accept(struct svc_rqst *rqstp)
 	svcdata->rsci = NULL;
 	gc = &svcdata->clcred;
 
-	/* start of rpc packet is 7 u32's back from here:
-	 * xid direction rpcversion prog vers proc flavour
-	 */
-	rpcstart = argv->iov_base;
-	rpcstart -= 7;
-
-	/* credential is:
-	 *   version(==1), proc(0,1,2,3), seq, service (1,2,3), handle
-	 * at least 5 u32s, and is preceded by length, so that makes 6.
-	 */
-
-	if (argv->iov_len < 5 * 4)
+	if (!svcauth_gss_decode_credbody(&rqstp->rq_arg_stream, gc, &rpcstart))
 		goto auth_err;
-	crlen = svc_getnl(argv);
-	if (svc_getnl(argv) != RPC_GSS_VERSION)
+	if (gc->gc_v != RPC_GSS_VERSION)
 		goto auth_err;
-	gc->gc_proc = svc_getnl(argv);
-	gc->gc_seq = svc_getnl(argv);
-	gc->gc_svc = svc_getnl(argv);
-	if (svc_safe_getnetobj(argv, &gc->gc_ctx))
-		goto auth_err;
-	if (crlen != round_up_to_quad(gc->gc_ctx.len) + 5 * 4)
-		goto auth_err;
-
-	svcxdr_init_decode(rqstp);
 
 	switch (gc->gc_proc) {
 	case RPC_GSS_PROC_INIT:
@@ -1621,7 +1647,6 @@ svcauth_gss_accept(struct svc_rqst *rqstp)
 			goto auth_err;
 		fallthrough;
 	case RPC_GSS_PROC_DATA:
-		/* Look up the context, and check the verifier: */
 		rqstp->rq_auth_stat = rpcsec_gsserr_credproblem;
 		rsci = gss_svc_searchbyctx(sn->rsc_cache, &gc->gc_ctx);
 		if (!rsci)



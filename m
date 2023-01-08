Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C12706616B5
	for <lists+linux-nfs@lfdr.de>; Sun,  8 Jan 2023 17:31:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236166AbjAHQb0 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sun, 8 Jan 2023 11:31:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236336AbjAHQbI (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sun, 8 Jan 2023 11:31:08 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34CA5DF55
        for <linux-nfs@vger.kernel.org>; Sun,  8 Jan 2023 08:31:07 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C5F6E60C58
        for <linux-nfs@vger.kernel.org>; Sun,  8 Jan 2023 16:31:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D584C433EF
        for <linux-nfs@vger.kernel.org>; Sun,  8 Jan 2023 16:31:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673195466;
        bh=PxTLXEJNoYHcXloJXnqiHXoEapJ2V/lwU9gMk4LPwLw=;
        h=Subject:From:To:Date:In-Reply-To:References:From;
        b=bM8Y16JIQgaiklUOrM4XuSDpvJSuW9NMdxi51AL0jWBq/X0/enn1Dd9rtXEySi8+t
         uNZK3y2MuhhpQra+NFwPuDVIaYkp3bHLctrDi7o+bCcY37++74/cuwN/PI0xHIXl8C
         9I7kgVkB1L4IkiagUXJuYUKHLeGxqTogxQ8koY7h5lgEQ11uj2WzaTRoxY5p4lD0oL
         iZ2ocbWbBc1QbQTsqcTiH3jxPxODnKQGuV2HrflMhv+40+hxDPH1hRLMJvdhzj/yqv
         z/0kx8pxu07EEODemPyEraXhavY1lx6Hwcx56CyuZE9Ok25Q/2kuOhBAd4nCYCCmFK
         G30AFgAP+iAEw==
Subject: [PATCH v1 26/27] SUNRPC: Set rq_accept_statp inside ->accept methods
From:   Chuck Lever <cel@kernel.org>
To:     linux-nfs@vger.kernel.org
Date:   Sun, 08 Jan 2023 11:31:05 -0500
Message-ID: <167319546521.7490.43383592461162363.stgit@bazille.1015granger.net>
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

To navigate around the space that svcauth_gss_accept() reserves
for the RPC payload body length and sequence number fields,
svcauth_gss_release() does a little dance with the reply's
accept_stat, moving the accept_stat value in the response buffer
down by two words.

Instead, let's have the ->accept() methods each set the proper
final location of the accept_stat to avoid having to move
things.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 include/linux/sunrpc/svc.h        |   19 +++++++++++++++++++
 net/sunrpc/auth_gss/svcauth_gss.c |   21 ++++++++++-----------
 net/sunrpc/svc.c                  |    2 --
 net/sunrpc/svcauth_unix.c         |    6 ++++++
 4 files changed, 35 insertions(+), 13 deletions(-)

diff --git a/include/linux/sunrpc/svc.h b/include/linux/sunrpc/svc.h
index f40a90ca5de6..392d2d2620fa 100644
--- a/include/linux/sunrpc/svc.h
+++ b/include/linux/sunrpc/svc.h
@@ -544,4 +544,23 @@ static inline void svcxdr_set_auth_slack(struct svc_rqst *rqstp, int slack)
 	WARN_ON(xdr->p > xdr->end);
 }
 
+/**
+ * svcxdr_set_accept_stat - Reserve space for the accept_stat field
+ * @rqstp: RPC transaction context
+ *
+ * Return values:
+ *   %true: Success
+ *   %false: No response buffer space was available
+ */
+static inline bool svcxdr_set_accept_stat(struct svc_rqst *rqstp)
+{
+	struct xdr_stream *xdr = &rqstp->rq_res_stream;
+
+	rqstp->rq_accept_statp = xdr_reserve_space(xdr, XDR_UNIT);
+	if (unlikely(!rqstp->rq_accept_statp))
+		return false;
+	*rqstp->rq_accept_statp = rpc_success;
+	return true;
+}
+
 #endif /* SUNRPC_SVC_H */
diff --git a/net/sunrpc/auth_gss/svcauth_gss.c b/net/sunrpc/auth_gss/svcauth_gss.c
index 560fb8a2803d..333873abb7d9 100644
--- a/net/sunrpc/auth_gss/svcauth_gss.c
+++ b/net/sunrpc/auth_gss/svcauth_gss.c
@@ -1220,7 +1220,7 @@ svcauth_gss_legacy_init(struct svc_rqst *rqstp,
 	if (!svcauth_gss_proc_init_verf(sn->rsc_cache, rqstp, &rsip->out_handle,
 					&rsip->major_status, GSS_SEQ_WIN))
 		goto out;
-	if (xdr_stream_encode_u32(&rqstp->rq_res_stream, RPC_SUCCESS) < 0)
+	if (!svcxdr_set_accept_stat(rqstp))
 		goto out;
 	if (!svcxdr_encode_gss_init_res(&rqstp->rq_res_stream, &rsip->out_handle,
 					&rsip->out_token, rsip->major_status,
@@ -1348,7 +1348,7 @@ static int svcauth_gss_proxy_init(struct svc_rqst *rqstp,
 	if (!svcauth_gss_proc_init_verf(sn->rsc_cache, rqstp, &cli_handle,
 					&ud.major_status, GSS_SEQ_WIN))
 		goto out;
-	if (xdr_stream_encode_u32(&rqstp->rq_res_stream, RPC_SUCCESS) < 0)
+	if (!svcxdr_set_accept_stat(rqstp))
 		goto out;
 	if (!svcxdr_encode_gss_init_res(&rqstp->rq_res_stream, &cli_handle,
 					&ud.out_token, ud.major_status,
@@ -1640,16 +1640,18 @@ svcauth_gss_accept(struct svc_rqst *rqstp)
 	case RPC_GSS_PROC_DESTROY:
 		if (!svcauth_gss_encode_verf(rqstp, rsci->mechctx, gc->gc_seq))
 			goto auth_err;
+		if (!svcxdr_set_accept_stat(rqstp))
+			goto auth_err;
 		/* Delete the entry from the cache_list and call cache_put */
 		sunrpc_cache_unhash(sn->rsc_cache, &rsci->h);
-		if (xdr_stream_encode_u32(&rqstp->rq_res_stream, RPC_SUCCESS) < 0)
-			goto auth_err;
 		goto complete;
 	case RPC_GSS_PROC_DATA:
 		rqstp->rq_auth_stat = rpcsec_gsserr_ctxproblem;
 		svcdata->verf_start = xdr_reserve_space(&rqstp->rq_res_stream, 0);
 		if (!svcauth_gss_encode_verf(rqstp, rsci->mechctx, gc->gc_seq))
 			goto auth_err;
+		if (!svcxdr_set_accept_stat(rqstp))
+			goto auth_err;
 		rqstp->rq_cred = rsci->cred;
 		get_group_info(rsci->cred.cr_group_info);
 		rqstp->rq_auth_stat = rpc_autherr_badcred;
@@ -1706,7 +1708,6 @@ svcauth_gss_accept(struct svc_rqst *rqstp)
 static __be32 *
 svcauth_gss_prepare_to_wrap(struct svc_rqst *rqstp, struct gss_svc_data *gsd)
 {
-	struct xdr_buf *resbuf = &rqstp->rq_res;
 	__be32 *p;
 	u32 verf_len;
 
@@ -1721,13 +1722,11 @@ svcauth_gss_prepare_to_wrap(struct svc_rqst *rqstp, struct gss_svc_data *gsd)
 	p += 1;
 	verf_len = ntohl(*p++);
 	p += XDR_QUADLEN(verf_len);
-	/* move accept_stat to right place: */
-	memcpy(p, p + 2, 4);
-	/* Also don't wrap if the accept stat is nonzero: */
-	if (*p != rpc_success) {
-		resbuf->head[0].iov_len -= 2 * 4;
+
+	/* Also don't wrap if the accept_stat is nonzero: */
+	if (*rqstp->rq_accept_statp != rpc_success)
 		return NULL;
-	}
+
 	p++;
 	return p;
 }
diff --git a/net/sunrpc/svc.c b/net/sunrpc/svc.c
index 3c194e6f8f5e..c2ed8b06fadb 100644
--- a/net/sunrpc/svc.c
+++ b/net/sunrpc/svc.c
@@ -1314,8 +1314,6 @@ svc_process_common(struct svc_rqst *rqstp)
 	trace_svc_process(rqstp, progp->pg_name);
 
 	aoffset = xdr_stream_pos(xdr);
-	rqstp->rq_accept_statp = xdr_reserve_space(&rqstp->rq_res_stream, XDR_UNIT);
-	*rqstp->rq_accept_statp = rpc_success;
 
 	/* un-reserve some of the out-queue now that we have a
 	 * better idea of reply size
diff --git a/net/sunrpc/svcauth_unix.c b/net/sunrpc/svcauth_unix.c
index b101700d155c..62dfc8cdf8c5 100644
--- a/net/sunrpc/svcauth_unix.c
+++ b/net/sunrpc/svcauth_unix.c
@@ -775,6 +775,8 @@ svcauth_null_accept(struct svc_rqst *rqstp)
 	if (xdr_stream_encode_opaque_auth(&rqstp->rq_res_stream,
 					  RPC_AUTH_NULL, NULL, 0) < 0)
 		return SVC_CLOSE;
+	if (!svcxdr_set_accept_stat(rqstp))
+		return SVC_CLOSE;
 
 	rqstp->rq_cred.cr_flavor = RPC_AUTH_NULL;
 	return SVC_OK;
@@ -866,6 +868,8 @@ svcauth_tls_accept(struct svc_rqst *rqstp)
 						  RPC_AUTH_NULL, NULL, 0) < 0)
 			return SVC_CLOSE;
 	}
+	if (!svcxdr_set_accept_stat(rqstp))
+		return SVC_CLOSE;
 
 	rqstp->rq_cred.cr_flavor = RPC_AUTH_TLS;
 	return SVC_OK;
@@ -960,6 +964,8 @@ svcauth_unix_accept(struct svc_rqst *rqstp)
 	if (xdr_stream_encode_opaque_auth(&rqstp->rq_res_stream,
 					  RPC_AUTH_NULL, NULL, 0) < 0)
 		return SVC_CLOSE;
+	if (!svcxdr_set_accept_stat(rqstp))
+		return SVC_CLOSE;
 
 	rqstp->rq_cred.cr_flavor = RPC_AUTH_UNIX;
 	return SVC_OK;



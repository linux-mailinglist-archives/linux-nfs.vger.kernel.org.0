Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8061165B580
	for <lists+linux-nfs@lfdr.de>; Mon,  2 Jan 2023 18:05:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236184AbjABRFy (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 2 Jan 2023 12:05:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235326AbjABRFx (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 2 Jan 2023 12:05:53 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E40764DB
        for <linux-nfs@vger.kernel.org>; Mon,  2 Jan 2023 09:05:52 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0A35A60F79
        for <linux-nfs@vger.kernel.org>; Mon,  2 Jan 2023 17:05:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4FB09C433D2
        for <linux-nfs@vger.kernel.org>; Mon,  2 Jan 2023 17:05:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672679151;
        bh=inBKDKa4LwR9s/SIGB4BaRB/RX/Enhy7lUxl9r5CM3k=;
        h=Subject:From:To:Date:In-Reply-To:References:From;
        b=n3Tf58zHx/yyh1g09DAy7p1G1DOttMR9mJxVxfJatcNH5BkRKG/s+GqPwbEXXMhop
         QsnrcM15EXWhfqBDwKm14vgIa870Ooaru1Y8D5EQZsVc6IylWtaBCy/No+aSjo23+f
         AHyM8833nlRk0d3MZ/uHQ6rMbdWIpMETAllhJ2sNlWtOSUU2IKklt1fN3+8r8EsWIM
         yYOwIhJS0VQ3Bih2HqKaRN+iaAn5SSvDxRQmYzyO27rttw2utP9yEX1tlb9/9Wuv5v
         zMDfIju5F4eaHpjUgtMbhzpZyBvqfMrbJxufN1iTZQqbev5Z1ElWSj795IIdtit487
         pBzyTv/lgPkHQ==
Subject: [PATCH v1 04/25] SUNRPC: Convert svcauth_null_accept() to use
 xdr_stream
From:   Chuck Lever <cel@kernel.org>
To:     linux-nfs@vger.kernel.org
Date:   Mon, 02 Jan 2023 12:05:50 -0500
Message-ID: <167267915027.112521.7425741327046408212.stgit@manet.1015granger.net>
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
 net/sunrpc/svcauth_unix.c |   33 +++++++++++++++++++++++++--------
 1 file changed, 25 insertions(+), 8 deletions(-)

diff --git a/net/sunrpc/svcauth_unix.c b/net/sunrpc/svcauth_unix.c
index 3a77f3be2cf0..95354f03bb05 100644
--- a/net/sunrpc/svcauth_unix.c
+++ b/net/sunrpc/svcauth_unix.c
@@ -729,23 +729,41 @@ svcauth_unix_set_client(struct svc_rqst *rqstp)
 
 EXPORT_SYMBOL_GPL(svcauth_unix_set_client);
 
+/**
+ * svcauth_null_accept - Decode and validate incoming RPC_AUTH_NULL credential
+ * @rqstp: RPC transaction
+ *
+ * Return values:
+ *   %SVC_OK: Both credential and verifier are valid
+ *   %SVC_DENIED: Credential or verifier is not valid
+ *   %SVC_GARBAGE: Failed to decode credential or verifier
+ *   %SVC_CLOSE: Temporary failure
+ *
+ * rqstp->rq_auth_stat is set as mandated by RFC 5531.
+ */
 static int
 svcauth_null_accept(struct svc_rqst *rqstp)
 {
-	struct kvec	*argv = &rqstp->rq_arg.head[0];
 	struct kvec	*resv = &rqstp->rq_res.head[0];
+	struct xdr_stream *xdr = &rqstp->rq_arg_stream;
 	struct svc_cred	*cred = &rqstp->rq_cred;
+	u32 flavor, len;
+	void *body;
 
-	if (argv->iov_len < 3*4)
-		return SVC_GARBAGE;
+	svcxdr_init_decode(rqstp);
 
-	if (svc_getu32(argv) != 0) {
-		dprintk("svc: bad null cred\n");
+	/* Length of Call's credential body field: */
+	if (xdr_stream_decode_u32(xdr, &len) < 0)
+		return SVC_GARBAGE;
+	if (len != 0) {
 		rqstp->rq_auth_stat = rpc_autherr_badcred;
 		return SVC_DENIED;
 	}
-	if (svc_getu32(argv) != htonl(RPC_AUTH_NULL) || svc_getu32(argv) != 0) {
-		dprintk("svc: bad null verf\n");
+
+	/* Call's verf field: */
+	if (xdr_stream_decode_opaque_auth(xdr, &flavor, &body, &len) < 0)
+		return SVC_GARBAGE;
+	if (flavor != RPC_AUTH_NULL || len != 0) {
 		rqstp->rq_auth_stat = rpc_autherr_badverf;
 		return SVC_DENIED;
 	}
@@ -762,7 +780,6 @@ svcauth_null_accept(struct svc_rqst *rqstp)
 	svc_putnl(resv, 0);
 
 	rqstp->rq_cred.cr_flavor = RPC_AUTH_NULL;
-	svcxdr_init_decode(rqstp);
 	return SVC_OK;
 }
 



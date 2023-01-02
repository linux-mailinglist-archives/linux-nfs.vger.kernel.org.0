Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83CD165B582
	for <lists+linux-nfs@lfdr.de>; Mon,  2 Jan 2023 18:06:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236188AbjABRGI (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 2 Jan 2023 12:06:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236182AbjABRGH (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 2 Jan 2023 12:06:07 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFBBD64DE
        for <linux-nfs@vger.kernel.org>; Mon,  2 Jan 2023 09:06:06 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 91AABB80D0A
        for <linux-nfs@vger.kernel.org>; Mon,  2 Jan 2023 17:06:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B059C433D2
        for <linux-nfs@vger.kernel.org>; Mon,  2 Jan 2023 17:06:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672679164;
        bh=deKo7xKBXd1+851snGqVAeCc1jQOGV7cZQKXoFMdifo=;
        h=Subject:From:To:Date:In-Reply-To:References:From;
        b=vJ0V8cEOI2zAqpkxYE6kiBMWfFMTr3IQarkdfJiRUpC3PS+/MoTNqzRrYokdNqdFq
         iItxAGRPiAltL10Bw7g7Pu0z9URlZO+qvp21fgyh3nCvCVwkn+OlUao+Nhwn5Q1m7U
         f9javRkzOuA713F0Izy5g0DkUtQx/pLrbCdDa2gYNVDRe3v8LMN0RnjliVr1kiarhA
         WA/ovtklbh9ZyBcf+Ea2nkc2vPIFA48iW8VomXlimK0Vjlsp7/FruG6L6DpbMkS4Vy
         /7NxI1QBIvRKdU+Smdn09cMc07ReBBvtobQzda3Oo5vYg4Q38aU5ATratxxLiI1SCY
         sMwKnUEeK0bWQ==
Subject: [PATCH v1 06/25] SUNRPC: Convert svcauth_tls_accept() to use
 xdr_stream
From:   Chuck Lever <cel@kernel.org>
To:     linux-nfs@vger.kernel.org
Date:   Mon, 02 Jan 2023 12:06:03 -0500
Message-ID: <167267916310.112521.3610150780550171360.stgit@manet.1015granger.net>
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
 net/sunrpc/svcauth_unix.c |   37 ++++++++++++++++++++++++++-----------
 1 file changed, 26 insertions(+), 11 deletions(-)

diff --git a/net/sunrpc/svcauth_unix.c b/net/sunrpc/svcauth_unix.c
index b6aef9c5113b..168e12137754 100644
--- a/net/sunrpc/svcauth_unix.c
+++ b/net/sunrpc/svcauth_unix.c
@@ -807,25 +807,41 @@ struct auth_ops svcauth_null = {
 };
 
 
+/**
+ * svcauth_tls_accept - Decode and validate incoming RPC_AUTH_TLS credential
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
 svcauth_tls_accept(struct svc_rqst *rqstp)
 {
+	struct xdr_stream *xdr = &rqstp->rq_arg_stream;
 	struct svc_cred	*cred = &rqstp->rq_cred;
-	struct kvec *argv = rqstp->rq_arg.head;
 	struct kvec *resv = rqstp->rq_res.head;
+	u32 flavor, len;
+	void *body;
 
-	if (argv->iov_len < XDR_UNIT * 3)
-		return SVC_GARBAGE;
+	svcxdr_init_decode(rqstp);
 
-	/* Call's cred length */
-	if (svc_getu32(argv) != xdr_zero) {
+	/* Length of Call's credential body field: */
+	if (xdr_stream_decode_u32(xdr, &len) < 0)
+		return SVC_GARBAGE;
+	if (len != 0) {
 		rqstp->rq_auth_stat = rpc_autherr_badcred;
 		return SVC_DENIED;
 	}
 
-	/* Call's verifier flavor and its length */
-	if (svc_getu32(argv) != rpc_auth_null ||
-	    svc_getu32(argv) != xdr_zero) {
+	/* Call's verf field: */
+	if (xdr_stream_decode_opaque_auth(xdr, &flavor, &body, &len) < 0)
+		return SVC_GARBAGE;
+	if (flavor != RPC_AUTH_NULL || len != 0) {
 		rqstp->rq_auth_stat = rpc_autherr_badverf;
 		return SVC_DENIED;
 	}
@@ -836,12 +852,12 @@ svcauth_tls_accept(struct svc_rqst *rqstp)
 		return SVC_DENIED;
 	}
 
-	/* Mapping to nobody uid/gid is required */
+	/* Signal that mapping to nobody uid/gid is required */
 	cred->cr_uid = INVALID_UID;
 	cred->cr_gid = INVALID_GID;
 	cred->cr_group_info = groups_alloc(0);
 	if (cred->cr_group_info == NULL)
-		return SVC_CLOSE; /* kmalloc failure - client must retry */
+		return SVC_CLOSE;
 
 	/* Reply's verifier */
 	svc_putnl(resv, RPC_AUTH_NULL);
@@ -853,7 +869,6 @@ svcauth_tls_accept(struct svc_rqst *rqstp)
 		svc_putnl(resv, 0);
 
 	rqstp->rq_cred.cr_flavor = RPC_AUTH_TLS;
-	svcxdr_init_decode(rqstp);
 	return SVC_OK;
 }
 



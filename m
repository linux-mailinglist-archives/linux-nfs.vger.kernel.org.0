Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E41806616A6
	for <lists+linux-nfs@lfdr.de>; Sun,  8 Jan 2023 17:30:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236108AbjAHQaR (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sun, 8 Jan 2023 11:30:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236196AbjAHQaM (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sun, 8 Jan 2023 11:30:12 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C7371E1
        for <linux-nfs@vger.kernel.org>; Sun,  8 Jan 2023 08:30:11 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 397B460C58
        for <linux-nfs@vger.kernel.org>; Sun,  8 Jan 2023 16:30:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A16BC433EF
        for <linux-nfs@vger.kernel.org>; Sun,  8 Jan 2023 16:30:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673195410;
        bh=hZN1FGfGFWv0uDeKk/7cYFtwpnzzfQgHp0lcODtUiYk=;
        h=Subject:From:To:Date:In-Reply-To:References:From;
        b=ehzwhOtmKrlkPppNS8NdTND2YGE7TX1c1HaqPy/+Cln+CH8Jnfn3Im7vYY6qqcWP8
         rKLUF0nsRecI5R0MxG+GQ6A9qT7nsom29SgSQT/lL8rAqaQ3jpw/DdkxhTJLkkLYrI
         KXgWpm0eXfWsFsCC8gueifnKWcQc+jEdgTqDjk+xdMy1ouCeH8Hxanwit40IwBNime
         FuYRwf90xC0obS6fbr+NkQTQp5cEnhHv4d4nsFWCVFf036A8SYSX/L9Poe3zhYoaUR
         OpK9pecv0ILI7tb11XjdFZYeGzTjd5dcYmhrntYnqprXdusfpkJG0n1m4RKf4MVcwf
         7PZBC1DUPJQZQ==
Subject: [PATCH v1 17/27] SUNRPC: Use xdr_stream to encode Reply verifier in
 svcauth_tls_accept()
From:   Chuck Lever <cel@kernel.org>
To:     linux-nfs@vger.kernel.org
Date:   Sun, 08 Jan 2023 11:30:09 -0500
Message-ID: <167319540967.7490.13888556503546252318.stgit@bazille.1015granger.net>
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
 net/sunrpc/svcauth_unix.c |   22 +++++++++++++---------
 1 file changed, 13 insertions(+), 9 deletions(-)

diff --git a/net/sunrpc/svcauth_unix.c b/net/sunrpc/svcauth_unix.c
index e3981e124042..632150a6b947 100644
--- a/net/sunrpc/svcauth_unix.c
+++ b/net/sunrpc/svcauth_unix.c
@@ -822,9 +822,9 @@ svcauth_tls_accept(struct svc_rqst *rqstp)
 {
 	struct xdr_stream *xdr = &rqstp->rq_arg_stream;
 	struct svc_cred	*cred = &rqstp->rq_cred;
-	struct kvec *resv = rqstp->rq_res.head;
 	u32 flavor, len;
 	void *body;
+	__be32 *p;
 
 	/* Length of Call's credential body field: */
 	if (xdr_stream_decode_u32(xdr, &len) < 0)
@@ -855,17 +855,21 @@ svcauth_tls_accept(struct svc_rqst *rqstp)
 	if (cred->cr_group_info == NULL)
 		return SVC_CLOSE;
 
-	/* Reply's verifier */
-	svc_putnl(resv, RPC_AUTH_NULL);
+	svcxdr_init_encode(rqstp);
 	if (rqstp->rq_xprt->xpt_ops->xpo_start_tls) {
-		svc_putnl(resv, 8);
-		memcpy(resv->iov_base + resv->iov_len, "STARTTLS", 8);
-		resv->iov_len += 8;
-	} else
-		svc_putnl(resv, 0);
+		p = xdr_reserve_space(&rqstp->rq_res_stream, XDR_UNIT * 2 + 8);
+		if (!p)
+			return SVC_CLOSE;
+		*p++ = rpc_auth_null;
+		*p++ = cpu_to_be32(8);
+		memcpy(p, "STARTTLS", 8);
+	} else {
+		if (xdr_stream_encode_opaque_auth(&rqstp->rq_res_stream,
+						  RPC_AUTH_NULL, NULL, 0) < 0)
+			return SVC_CLOSE;
+	}
 
 	rqstp->rq_cred.cr_flavor = RPC_AUTH_TLS;
-	svcxdr_init_encode(rqstp);
 	return SVC_OK;
 }
 



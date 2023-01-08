Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E7B16616A7
	for <lists+linux-nfs@lfdr.de>; Sun,  8 Jan 2023 17:30:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233451AbjAHQaQ (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sun, 8 Jan 2023 11:30:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236108AbjAHQaH (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sun, 8 Jan 2023 11:30:07 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1856B3889
        for <linux-nfs@vger.kernel.org>; Sun,  8 Jan 2023 08:30:07 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id BF12FB801C1
        for <linux-nfs@vger.kernel.org>; Sun,  8 Jan 2023 16:30:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D011C433D2
        for <linux-nfs@vger.kernel.org>; Sun,  8 Jan 2023 16:30:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673195404;
        bh=gvzRoP3m0yyKE9mvSvyx11q9Oms3Z4Vd15Er4glKHsA=;
        h=Subject:From:To:Date:In-Reply-To:References:From;
        b=qQOdhXTBxBKDMmsIo7iv9IG88w5MpieKeYQWVLyKWzQ+zLedfeRos9Ze5qYYQm7qq
         mwx8L/pHFPPISqZjQx+y0SCbamsEucKpgT2J2ZIuieE6VhgbKDzpOCi6JfV/4LZspH
         R/Ol7Pm8MLwGN3yb8D09lGL+FytKapfjYU2yYGxSK56Gy74IMuvMPgGgJ7haplagzM
         Gc3XzhlSP8lTcVDWkbozOJi8fCvtg0OcvGC8Uzk/8CPxcmysN56iUjAD2cxjkSLUhV
         RLUSxWFnJS/gwHp8q4MV3TVSVsYA/Fsc1RXxK+CUkHnxgYqMjzwhnrsUT9dG5gGUxi
         PTJWNX0/aMV7A==
Subject: [PATCH v1 16/27] SUNRPC: Use xdr_stream to encode Reply verifier in
 svcauth_unix_accept()
From:   Chuck Lever <cel@kernel.org>
To:     linux-nfs@vger.kernel.org
Date:   Sun, 08 Jan 2023 11:30:03 -0500
Message-ID: <167319540345.7490.5719470568781058899.stgit@bazille.1015granger.net>
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
 net/sunrpc/svcauth_unix.c |    9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/net/sunrpc/svcauth_unix.c b/net/sunrpc/svcauth_unix.c
index b24d6c75588f..e3981e124042 100644
--- a/net/sunrpc/svcauth_unix.c
+++ b/net/sunrpc/svcauth_unix.c
@@ -894,7 +894,6 @@ struct auth_ops svcauth_tls = {
 static int
 svcauth_unix_accept(struct svc_rqst *rqstp)
 {
-	struct kvec	*resv = &rqstp->rq_res.head[0];
 	struct xdr_stream *xdr = &rqstp->rq_arg_stream;
 	struct svc_cred	*cred = &rqstp->rq_cred;
 	struct user_namespace *userns;
@@ -956,12 +955,12 @@ svcauth_unix_accept(struct svc_rqst *rqstp)
 		return SVC_DENIED;
 	}
 
-	/* Put NULL verifier */
-	svc_putnl(resv, RPC_AUTH_NULL);
-	svc_putnl(resv, 0);
+	svcxdr_init_encode(rqstp);
+	if (xdr_stream_encode_opaque_auth(&rqstp->rq_res_stream,
+					  RPC_AUTH_NULL, NULL, 0) < 0)
+		return SVC_CLOSE;
 
 	rqstp->rq_cred.cr_flavor = RPC_AUTH_UNIX;
-	svcxdr_init_encode(rqstp);
 	return SVC_OK;
 
 badcred:



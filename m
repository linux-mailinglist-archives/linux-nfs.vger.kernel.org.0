Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FD5765B584
	for <lists+linux-nfs@lfdr.de>; Mon,  2 Jan 2023 18:06:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232934AbjABRGW (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 2 Jan 2023 12:06:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236275AbjABRGS (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 2 Jan 2023 12:06:18 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E44A64DB
        for <linux-nfs@vger.kernel.org>; Mon,  2 Jan 2023 09:06:18 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9EF3960F79
        for <linux-nfs@vger.kernel.org>; Mon,  2 Jan 2023 17:06:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E08DBC433D2
        for <linux-nfs@vger.kernel.org>; Mon,  2 Jan 2023 17:06:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672679177;
        bh=u50HbFcZnEztOGWeJ7xlCiX+upXz2PlDpb2h14CNejY=;
        h=Subject:From:To:Date:In-Reply-To:References:From;
        b=XX1T2ell3+62rdEhPKqFnh15FmExnjVvMCqjX8xHB1DpqdL2vFBUauostbRSGnRL8
         cJjDOqJGPiRm/QkXpP50HHWtTLOa4A/F88aHQIHw4cr/iYvAwcdnOno3RNKAHvRf/B
         qVqQcXbcjGKYn+mW/Nreck2iNzWN6U6YMy6yBJsveYXStdSs80+vVtDZhggBtV260m
         9/Qc+MRT/CD4TOOmU3Qscm1SU4fVpm4L4iGVc9BpFenI+Zq6T6vtHPA2SvePufwf4z
         CeZMi7alEhwffcUmVexWTZXI2G4jbiIXn9YcUjus3mgq1r6oE6UDy9pPIYG1PyAWKn
         akY0go6p9ZJIQ==
Subject: [PATCH v1 08/25] SUNRPC: Hoist common verifier decoding code into
 svcauth_gss_proc_init()
From:   Chuck Lever <cel@kernel.org>
To:     linux-nfs@vger.kernel.org
Date:   Mon, 02 Jan 2023 12:06:15 -0500
Message-ID: <167267917591.112521.1790517196389298337.stgit@manet.1015granger.net>
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

Pre-requisite to replacing gss_read_common_verf().

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 net/sunrpc/auth_gss/svcauth_gss.c |   26 ++++++++++++++------------
 1 file changed, 14 insertions(+), 12 deletions(-)

diff --git a/net/sunrpc/auth_gss/svcauth_gss.c b/net/sunrpc/auth_gss/svcauth_gss.c
index 2a11721dd5c4..ba32c05f0258 100644
--- a/net/sunrpc/auth_gss/svcauth_gss.c
+++ b/net/sunrpc/auth_gss/svcauth_gss.c
@@ -1095,18 +1095,6 @@ gss_read_common_verf(struct rpc_gss_wire_cred *gc,
 		     struct kvec *argv, __be32 *authp,
 		     struct xdr_netobj *in_handle)
 {
-	/* Read the verifier; should be NULL: */
-	*authp = rpc_autherr_badverf;
-	if (argv->iov_len < 2 * 4)
-		return SVC_DENIED;
-	if (svc_getnl(argv) != RPC_AUTH_NULL)
-		return SVC_DENIED;
-	if (svc_getnl(argv) != 0)
-		return SVC_DENIED;
-	/* Martial context handle and token for upcall: */
-	*authp = rpc_autherr_badcred;
-	if (gc->gc_proc == RPC_GSS_PROC_INIT && gc->gc_ctx.len != 0)
-		return SVC_DENIED;
 	if (dup_netobj(in_handle, &gc->gc_ctx))
 		return SVC_CLOSE;
 	*authp = rpc_autherr_badverf;
@@ -1447,6 +1435,20 @@ static bool use_gss_proxy(struct net *net)
 static noinline_for_stack int
 svcauth_gss_proc_init(struct svc_rqst *rqstp, struct rpc_gss_wire_cred *gc)
 {
+	struct kvec *argv = rqstp->rq_arg.head;
+
+	if (argv->iov_len < 2 * 4)
+		return SVC_DENIED;
+	if (svc_getnl(argv) != RPC_AUTH_NULL)
+		return SVC_DENIED;
+	if (svc_getnl(argv) != 0)
+		return SVC_DENIED;
+
+	if (gc->gc_proc == RPC_GSS_PROC_INIT && gc->gc_ctx.len != 0) {
+		rqstp->rq_auth_stat = rpc_autherr_badcred;
+		return SVC_DENIED;
+	}
+
 	if (!use_gss_proxy(SVC_NET(rqstp)))
 		return svcauth_gss_legacy_init(rqstp, gc);
 	return svcauth_gss_proxy_init(rqstp, gc);



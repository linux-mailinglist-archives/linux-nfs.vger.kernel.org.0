Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CF926616A1
	for <lists+linux-nfs@lfdr.de>; Sun,  8 Jan 2023 17:29:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236101AbjAHQ3y (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sun, 8 Jan 2023 11:29:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236098AbjAHQ3x (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sun, 8 Jan 2023 11:29:53 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 152771E1
        for <linux-nfs@vger.kernel.org>; Sun,  8 Jan 2023 08:29:53 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A317B60C8C
        for <linux-nfs@vger.kernel.org>; Sun,  8 Jan 2023 16:29:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1A6FC433EF
        for <linux-nfs@vger.kernel.org>; Sun,  8 Jan 2023 16:29:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673195392;
        bh=Rvh99QF+FTkIBz73eDgIXWqlQdlPOHGsXOTisCDx47o=;
        h=Subject:From:To:Date:In-Reply-To:References:From;
        b=rH7JDHIhExTpPpwUDksm0AMhZEPH8eixp93b5LC/IJ2F6AsLbdqCX1ZqgxUOh7fBn
         VdWorKfNtVYa6Y+WeAZEojplMWQzIS0MQYQ1WwfhCaUQSdfkgOrE/escV/XJRek/XW
         d4ZbJSp+zT2ZBc+b6b9wB05h8TJHMPCFvKU0b/hC7CHANwb17u+9zCGgW3Jze6FNKD
         Cdbd1zW2+AjCYoOgDQjs5dwnb6qyj/ZeQqgx/f58EsV420c3BEVijHXq6HwJnGZoop
         y2rCtRvQ0lGlO0mao1cKEd4N3/IYis/OgNgRHCoXrRjmoftnFdmfN6RKmIY8D+IYY/
         bfUJ2x+WL/pSQ==
Subject: [PATCH v1 14/27] SUNRPC: Move svcxdr_init_encode() into ->accept
 methods
From:   Chuck Lever <cel@kernel.org>
To:     linux-nfs@vger.kernel.org
Date:   Sun, 08 Jan 2023 11:29:51 -0500
Message-ID: <167319539113.7490.9989691159064949552.stgit@bazille.1015granger.net>
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

Refactor: So that the overhaul of each ->accept method can be done
in separate smaller patches, temporarily move the
svcxdr_init_encode() call into those methods.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 net/sunrpc/auth_gss/svcauth_gss.c |    5 +++++
 net/sunrpc/svc.c                  |    6 ++----
 net/sunrpc/svcauth_unix.c         |    3 +++
 3 files changed, 10 insertions(+), 4 deletions(-)

diff --git a/net/sunrpc/auth_gss/svcauth_gss.c b/net/sunrpc/auth_gss/svcauth_gss.c
index 71a147b0f90b..759169baa52f 100644
--- a/net/sunrpc/auth_gss/svcauth_gss.c
+++ b/net/sunrpc/auth_gss/svcauth_gss.c
@@ -1250,6 +1250,7 @@ svcauth_gss_legacy_init(struct svc_rqst *rqstp,
 		goto out;
 
 	ret = SVC_COMPLETE;
+	svcxdr_init_encode(rqstp);
 out:
 	cache_put(&rsip->h, sn->rsi_cache);
 	return ret;
@@ -1378,6 +1379,7 @@ static int svcauth_gss_proxy_init(struct svc_rqst *rqstp,
 		goto out;
 
 	ret = SVC_COMPLETE;
+	svcxdr_init_encode(rqstp);
 out:
 	gss_free_in_token_pages(&ud.in_token);
 	gssp_free_upcall_data(&ud);
@@ -1680,6 +1682,7 @@ svcauth_gss_accept(struct svc_rqst *rqstp)
 		rqstp->rq_auth_stat = rpc_autherr_badcred;
 		switch (gc->gc_svc) {
 		case RPC_GSS_SVC_NONE:
+			svcxdr_init_encode(rqstp);
 			break;
 		case RPC_GSS_SVC_INTEGRITY:
 			/* placeholders for length and seq. number: */
@@ -1689,6 +1692,7 @@ svcauth_gss_accept(struct svc_rqst *rqstp)
 						     rsci->mechctx))
 				goto garbage_args;
 			rqstp->rq_auth_slack = RPC_MAX_AUTH_SIZE;
+			svcxdr_init_encode(rqstp);
 			break;
 		case RPC_GSS_SVC_PRIVACY:
 			/* placeholders for length and seq. number: */
@@ -1698,6 +1702,7 @@ svcauth_gss_accept(struct svc_rqst *rqstp)
 						    rsci->mechctx))
 				goto garbage_args;
 			rqstp->rq_auth_slack = RPC_MAX_AUTH_SIZE * 2;
+			svcxdr_init_encode(rqstp);
 			break;
 		default:
 			goto auth_err;
diff --git a/net/sunrpc/svc.c b/net/sunrpc/svc.c
index 1cdf68fda3f8..9951311790bf 100644
--- a/net/sunrpc/svc.c
+++ b/net/sunrpc/svc.c
@@ -1312,16 +1312,14 @@ svc_process_common(struct svc_rqst *rqstp, struct kvec *resv)
 	serv->sv_stats->rpccnt++;
 	trace_svc_process(rqstp, progp->pg_name);
 
-	/* Build the reply header. */
-	statp = resv->iov_base +resv->iov_len;
-	svc_putnl(resv, RPC_SUCCESS);
+	statp = xdr_reserve_space(&rqstp->rq_res_stream, XDR_UNIT);
+	*statp = rpc_success;
 
 	/* un-reserve some of the out-queue now that we have a
 	 * better idea of reply size
 	 */
 	if (procp->pc_xdrressize)
 		svc_reserve_auth(rqstp, procp->pc_xdrressize<<2);
-	svcxdr_init_encode(rqstp);
 
 	/* Call the function that processes the request. */
 	rc = process.dispatch(rqstp, statp);
diff --git a/net/sunrpc/svcauth_unix.c b/net/sunrpc/svcauth_unix.c
index f09a148aa0c1..6281d23f98bf 100644
--- a/net/sunrpc/svcauth_unix.c
+++ b/net/sunrpc/svcauth_unix.c
@@ -778,6 +778,7 @@ svcauth_null_accept(struct svc_rqst *rqstp)
 	svc_putnl(resv, 0);
 
 	rqstp->rq_cred.cr_flavor = RPC_AUTH_NULL;
+	svcxdr_init_encode(rqstp);
 	return SVC_OK;
 }
 
@@ -865,6 +866,7 @@ svcauth_tls_accept(struct svc_rqst *rqstp)
 		svc_putnl(resv, 0);
 
 	rqstp->rq_cred.cr_flavor = RPC_AUTH_TLS;
+	svcxdr_init_encode(rqstp);
 	return SVC_OK;
 }
 
@@ -960,6 +962,7 @@ svcauth_unix_accept(struct svc_rqst *rqstp)
 	svc_putnl(resv, 0);
 
 	rqstp->rq_cred.cr_flavor = RPC_AUTH_UNIX;
+	svcxdr_init_encode(rqstp);
 	return SVC_OK;
 
 badcred:



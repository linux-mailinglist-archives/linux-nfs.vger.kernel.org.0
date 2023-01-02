Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1445665B57D
	for <lists+linux-nfs@lfdr.de>; Mon,  2 Jan 2023 18:05:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236195AbjABRFl (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 2 Jan 2023 12:05:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236188AbjABRFk (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 2 Jan 2023 12:05:40 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DDE6B868
        for <linux-nfs@vger.kernel.org>; Mon,  2 Jan 2023 09:05:39 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 276B160018
        for <linux-nfs@vger.kernel.org>; Mon,  2 Jan 2023 17:05:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 685C9C433EF
        for <linux-nfs@vger.kernel.org>; Mon,  2 Jan 2023 17:05:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672679138;
        bh=CAqR91ZZqJiea4VtS4jacZI1WZSs3WowwzpY+6785Jk=;
        h=Subject:From:To:Date:In-Reply-To:References:From;
        b=tzzNPu3UMA2d+dcFoIc79K8AIAsjmyfqyjpV52b4Z7sIA7Tf6X+Ew+ZhzJcSrs9Bc
         w37k4DgiHtoH3KV59wNj9pfCwkW6gsd1PHr6Daqq759RsN1cooy4i75xGHOGMuPzyD
         yeuMNpD50JlcdyXlqzfxC1zTYSIXN94AR74Ksn8AcacSrlv1fGacvEMWV+18khSrk3
         MsEnH6aNW6p2x8RtTqFs1Jf4n7F2HDdhpORphlP5/L621rY4EgyWXZ341gtEH6N+rC
         hUgNJC6Nl5dti8n4c2jP3iJqtjZ4WO2Uidb7foRqYTVXz+T2nwXlfAX3xEnU+fFhJt
         VelTaMEPL/Iig==
Subject: [PATCH v1 02/25] SUNRPC: Move svcxdr_init_decode() into ->accept
 methods
From:   Chuck Lever <cel@kernel.org>
To:     linux-nfs@vger.kernel.org
Date:   Mon, 02 Jan 2023 12:05:37 -0500
Message-ID: <167267913732.112521.7315896235237537841.stgit@manet.1015granger.net>
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

Refactor: So that the overhaul of each ->accept method can be done
in separate smaller patches, temporarily move the
svcxdr_init_decode() call into those methods.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 net/sunrpc/auth_gss/svcauth_gss.c |    5 +++++
 net/sunrpc/svc.c                  |    1 -
 net/sunrpc/svcauth_unix.c         |    3 +++
 3 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/net/sunrpc/auth_gss/svcauth_gss.c b/net/sunrpc/auth_gss/svcauth_gss.c
index 148bb0a7fa5b..8ebc06bebbec 100644
--- a/net/sunrpc/auth_gss/svcauth_gss.c
+++ b/net/sunrpc/auth_gss/svcauth_gss.c
@@ -1280,6 +1280,7 @@ static int svcauth_gss_legacy_init(struct svc_rqst *rqstp,
 			   rsip->major_status, rsip->minor_status))
 		goto out;
 
+	svcxdr_init_decode(rqstp);
 	ret = SVC_COMPLETE;
 out:
 	cache_put(&rsip->h, sn->rsi_cache);
@@ -1408,6 +1409,7 @@ static int svcauth_gss_proxy_init(struct svc_rqst *rqstp,
 			   ud.major_status, ud.minor_status))
 		goto out;
 
+	svcxdr_init_decode(rqstp);
 	ret = SVC_COMPLETE;
 out:
 	gss_free_in_token_pages(&ud.in_token);
@@ -1644,6 +1646,7 @@ svcauth_gss_accept(struct svc_rqst *rqstp)
 		rqstp->rq_auth_stat = rpc_autherr_badcred;
 		switch (gc->gc_svc) {
 		case RPC_GSS_SVC_NONE:
+			svcxdr_init_decode(rqstp);
 			break;
 		case RPC_GSS_SVC_INTEGRITY:
 			/* placeholders for length and seq. number: */
@@ -1653,6 +1656,7 @@ svcauth_gss_accept(struct svc_rqst *rqstp)
 					gc->gc_seq, rsci->mechctx))
 				goto garbage_args;
 			rqstp->rq_auth_slack = RPC_MAX_AUTH_SIZE;
+			svcxdr_init_decode(rqstp);
 			break;
 		case RPC_GSS_SVC_PRIVACY:
 			/* placeholders for length and seq. number: */
@@ -1662,6 +1666,7 @@ svcauth_gss_accept(struct svc_rqst *rqstp)
 					gc->gc_seq, rsci->mechctx))
 				goto garbage_args;
 			rqstp->rq_auth_slack = RPC_MAX_AUTH_SIZE * 2;
+			svcxdr_init_decode(rqstp);
 			break;
 		default:
 			goto auth_err;
diff --git a/net/sunrpc/svc.c b/net/sunrpc/svc.c
index 96806c3c61a5..85f0c3cfc877 100644
--- a/net/sunrpc/svc.c
+++ b/net/sunrpc/svc.c
@@ -1302,7 +1302,6 @@ svc_process_common(struct svc_rqst *rqstp, struct kvec *argv, struct kvec *resv)
 	if (progp == NULL)
 		goto err_bad_prog;
 
-	svcxdr_init_decode(rqstp);
 	rpc_stat = progp->pg_init_request(rqstp, progp, &process);
 	switch (rpc_stat) {
 	case rpc_success:
diff --git a/net/sunrpc/svcauth_unix.c b/net/sunrpc/svcauth_unix.c
index b1efc34db6ed..3a77f3be2cf0 100644
--- a/net/sunrpc/svcauth_unix.c
+++ b/net/sunrpc/svcauth_unix.c
@@ -762,6 +762,7 @@ svcauth_null_accept(struct svc_rqst *rqstp)
 	svc_putnl(resv, 0);
 
 	rqstp->rq_cred.cr_flavor = RPC_AUTH_NULL;
+	svcxdr_init_decode(rqstp);
 	return SVC_OK;
 }
 
@@ -835,6 +836,7 @@ svcauth_tls_accept(struct svc_rqst *rqstp)
 		svc_putnl(resv, 0);
 
 	rqstp->rq_cred.cr_flavor = RPC_AUTH_TLS;
+	svcxdr_init_decode(rqstp);
 	return SVC_OK;
 }
 
@@ -900,6 +902,7 @@ svcauth_unix_accept(struct svc_rqst *rqstp)
 	svc_putnl(resv, 0);
 
 	rqstp->rq_cred.cr_flavor = RPC_AUTH_UNIX;
+	svcxdr_init_decode(rqstp);
 	return SVC_OK;
 
 badcred:



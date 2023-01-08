Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E5FB6616AD
	for <lists+linux-nfs@lfdr.de>; Sun,  8 Jan 2023 17:30:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233542AbjAHQau (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sun, 8 Jan 2023 11:30:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236195AbjAHQag (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sun, 8 Jan 2023 11:30:36 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57075D10B
        for <linux-nfs@vger.kernel.org>; Sun,  8 Jan 2023 08:30:36 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E7BF260CA4
        for <linux-nfs@vger.kernel.org>; Sun,  8 Jan 2023 16:30:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43BDDC433EF
        for <linux-nfs@vger.kernel.org>; Sun,  8 Jan 2023 16:30:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673195435;
        bh=u9DYwf7CA8XuMgYmvtC4bPAvv6xzFBFcq7dZkbMKh+Y=;
        h=Subject:From:To:Date:In-Reply-To:References:From;
        b=og4WZce32B3pOD24Vc6X5cl41sw90C8EA1dM9rXq4jXKVmmAiTo7fwtE6zfELc3q4
         o2OfxEzvWBDWkxWx4UYPy0TQ1UAgeyO5IHd1PeF8YKj6Ilf/hp+UJ9E9rO4euOdNr/
         TwOs/gKKX+fXptFHMP5RYnj98/IbaMFZi7+qO9sDUDWOuxY/HgU8baHP+TkP1f68s9
         wUvqwn3wrBuGnqv7MdllQ65fOgzkpMIg4qKh7YHHZHSTdA9nf514dQyflaq+J4p0Z7
         NHco4eoNixDyRR0UALugbf/I0SPC7e5rPEK5JKP94y/1J0fc50tHrM59cAjIfqUzen
         VWa+H1aHC4uyw==
Subject: [PATCH v1 21/27] SUNRPC: Hoist init_encode out of svc_authenticate()
From:   Chuck Lever <cel@kernel.org>
To:     linux-nfs@vger.kernel.org
Date:   Sun, 08 Jan 2023 11:30:34 -0500
Message-ID: <167319543438.7490.15983256373144808077.stgit@bazille.1015granger.net>
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

Now that each ->accept method has been converted, the
svcxdr_init_encode() calls can be hoisted back up into the generic
RPC server code.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 net/sunrpc/auth_gss/svcauth_gss.c |    2 --
 net/sunrpc/svc.c                  |    2 ++
 net/sunrpc/svcauth_unix.c         |    3 ---
 3 files changed, 2 insertions(+), 5 deletions(-)

diff --git a/net/sunrpc/auth_gss/svcauth_gss.c b/net/sunrpc/auth_gss/svcauth_gss.c
index 89333669af26..560fb8a2803d 100644
--- a/net/sunrpc/auth_gss/svcauth_gss.c
+++ b/net/sunrpc/auth_gss/svcauth_gss.c
@@ -1589,8 +1589,6 @@ svcauth_gss_accept(struct svc_rqst *rqstp)
 	int		ret;
 	struct sunrpc_net *sn = net_generic(SVC_NET(rqstp), sunrpc_net_id);
 
-	svcxdr_init_encode(rqstp);
-
 	rqstp->rq_auth_stat = rpc_autherr_badcred;
 	if (!svcdata)
 		svcdata = kmalloc(sizeof(*svcdata), GFP_KERNEL);
diff --git a/net/sunrpc/svc.c b/net/sunrpc/svc.c
index 9951311790bf..393eebd1f6fe 100644
--- a/net/sunrpc/svc.c
+++ b/net/sunrpc/svc.c
@@ -1262,6 +1262,8 @@ svc_process_common(struct svc_rqst *rqstp, struct kvec *resv)
 		if (rqstp->rq_prog == progp->pg_prog)
 			break;
 
+	svcxdr_init_encode(rqstp);
+
 	/*
 	 * Decode auth data, and add verifier to reply buffer.
 	 * We do this before anything else in order to get a decent
diff --git a/net/sunrpc/svcauth_unix.c b/net/sunrpc/svcauth_unix.c
index 632150a6b947..b101700d155c 100644
--- a/net/sunrpc/svcauth_unix.c
+++ b/net/sunrpc/svcauth_unix.c
@@ -772,7 +772,6 @@ svcauth_null_accept(struct svc_rqst *rqstp)
 	if (cred->cr_group_info == NULL)
 		return SVC_CLOSE; /* kmalloc failure - client must retry */
 
-	svcxdr_init_encode(rqstp);
 	if (xdr_stream_encode_opaque_auth(&rqstp->rq_res_stream,
 					  RPC_AUTH_NULL, NULL, 0) < 0)
 		return SVC_CLOSE;
@@ -855,7 +854,6 @@ svcauth_tls_accept(struct svc_rqst *rqstp)
 	if (cred->cr_group_info == NULL)
 		return SVC_CLOSE;
 
-	svcxdr_init_encode(rqstp);
 	if (rqstp->rq_xprt->xpt_ops->xpo_start_tls) {
 		p = xdr_reserve_space(&rqstp->rq_res_stream, XDR_UNIT * 2 + 8);
 		if (!p)
@@ -959,7 +957,6 @@ svcauth_unix_accept(struct svc_rqst *rqstp)
 		return SVC_DENIED;
 	}
 
-	svcxdr_init_encode(rqstp);
 	if (xdr_stream_encode_opaque_auth(&rqstp->rq_res_stream,
 					  RPC_AUTH_NULL, NULL, 0) < 0)
 		return SVC_CLOSE;



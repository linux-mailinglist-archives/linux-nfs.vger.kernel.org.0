Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 304A965B591
	for <lists+linux-nfs@lfdr.de>; Mon,  2 Jan 2023 18:07:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232847AbjABRHk (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 2 Jan 2023 12:07:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232151AbjABRHh (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 2 Jan 2023 12:07:37 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C73C7BC03
        for <linux-nfs@vger.kernel.org>; Mon,  2 Jan 2023 09:07:36 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 6D91FB80D0A
        for <linux-nfs@vger.kernel.org>; Mon,  2 Jan 2023 17:07:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03BE1C433D2
        for <linux-nfs@vger.kernel.org>; Mon,  2 Jan 2023 17:07:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672679254;
        bh=eAEDI42eIZ/uO7rj5qpM/FDpNMw79LDZDRh29eCqoDo=;
        h=Subject:From:To:Date:In-Reply-To:References:From;
        b=X9z8CGYFmzd6bjMS/gKX6fbPiUSfmLT9OYW0uldUBkij5N9UWqluDDph9E5b7hweu
         3IZJl2uvU+ECStpGT1Gc95DMRAI843/uNtHrSY9iyZ8VagnupufL5Qj9W/fuf4LfP9
         x8FhhVrzNe1yL3XwKZlP9ISwfS6m4lCYha/HyWLJ0nkgYnfwmYnPuL6nqb9LVS7Sr2
         DzeuRJTOT5YnB6ew16HjmE1eoe8wkgRkqHMCQQo5JMYtY0Q3SDhFqccoI+1uKvzn8M
         lHrBNeL4gZChroS/f4CEyzELb+iuVEDXvrbnhNqQuHcSz9imxHlQcfdvZpSKnhrUsp
         RHgqpMD8BM4Lw==
Subject: [PATCH v1 20/25] SUNRPC: Hoist init_decode out of svc_authenticate()
From:   Chuck Lever <cel@kernel.org>
To:     linux-nfs@vger.kernel.org
Date:   Mon, 02 Jan 2023 12:07:32 -0500
Message-ID: <167267925297.112521.5839833053792070108.stgit@manet.1015granger.net>
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

Now that each ->accept method has been converted to use xdr_stream,
the svcxdr_init_decode() calls can be hoisted back up into the
generic RPC server code.

The dprintk in svc_authenticate() is removed, since
trace_svc_authenticate() reports the same information.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 net/sunrpc/auth_gss/svcauth_gss.c |    2 --
 net/sunrpc/svc.c                  |    1 +
 net/sunrpc/svcauth.c              |   13 ++++++++-----
 net/sunrpc/svcauth_unix.c         |    6 ------
 4 files changed, 9 insertions(+), 13 deletions(-)

diff --git a/net/sunrpc/auth_gss/svcauth_gss.c b/net/sunrpc/auth_gss/svcauth_gss.c
index 557de28127fe..2e603358fae1 100644
--- a/net/sunrpc/auth_gss/svcauth_gss.c
+++ b/net/sunrpc/auth_gss/svcauth_gss.c
@@ -1619,8 +1619,6 @@ svcauth_gss_accept(struct svc_rqst *rqstp)
 	int		ret;
 	struct sunrpc_net *sn = net_generic(SVC_NET(rqstp), sunrpc_net_id);
 
-	svcxdr_init_decode(rqstp);
-
 	rqstp->rq_auth_stat = rpc_autherr_badcred;
 	if (!svcdata)
 		svcdata = kmalloc(sizeof(*svcdata), GFP_KERNEL);
diff --git a/net/sunrpc/svc.c b/net/sunrpc/svc.c
index 85f0c3cfc877..e4f8a177763e 100644
--- a/net/sunrpc/svc.c
+++ b/net/sunrpc/svc.c
@@ -1276,6 +1276,7 @@ svc_process_common(struct svc_rqst *rqstp, struct kvec *argv, struct kvec *resv)
 	 * We do this before anything else in order to get a decent
 	 * auth verifier.
 	 */
+	svcxdr_init_decode(rqstp);
 	auth_res = svc_authenticate(rqstp);
 	/* Also give the program a chance to reject this call: */
 	if (auth_res == SVC_OK && progp)
diff --git a/net/sunrpc/svcauth.c b/net/sunrpc/svcauth.c
index e72ba2f13f6c..67d8245a08af 100644
--- a/net/sunrpc/svcauth.c
+++ b/net/sunrpc/svcauth.c
@@ -63,14 +63,17 @@ svc_put_auth_ops(struct auth_ops *aops)
 int
 svc_authenticate(struct svc_rqst *rqstp)
 {
-	rpc_authflavor_t	flavor;
-	struct auth_ops		*aops;
+	struct auth_ops *aops;
+	u32 flavor;
 
 	rqstp->rq_auth_stat = rpc_auth_ok;
 
-	flavor = svc_getnl(&rqstp->rq_arg.head[0]);
-
-	dprintk("svc: svc_authenticate (%d)\n", flavor);
+	/*
+	 * Decode the Call credential's flavor field. The credential's
+	 * body field is decoded in the chosen ->accept method below.
+	 */
+	if (xdr_stream_decode_u32(&rqstp->rq_arg_stream, &flavor) < 0)
+		return SVC_GARBAGE;
 
 	aops = svc_get_auth_ops(flavor);
 	if (aops == NULL) {
diff --git a/net/sunrpc/svcauth_unix.c b/net/sunrpc/svcauth_unix.c
index 168e12137754..f09a148aa0c1 100644
--- a/net/sunrpc/svcauth_unix.c
+++ b/net/sunrpc/svcauth_unix.c
@@ -750,8 +750,6 @@ svcauth_null_accept(struct svc_rqst *rqstp)
 	u32 flavor, len;
 	void *body;
 
-	svcxdr_init_decode(rqstp);
-
 	/* Length of Call's credential body field: */
 	if (xdr_stream_decode_u32(xdr, &len) < 0)
 		return SVC_GARBAGE;
@@ -828,8 +826,6 @@ svcauth_tls_accept(struct svc_rqst *rqstp)
 	u32 flavor, len;
 	void *body;
 
-	svcxdr_init_decode(rqstp);
-
 	/* Length of Call's credential body field: */
 	if (xdr_stream_decode_u32(xdr, &len) < 0)
 		return SVC_GARBAGE;
@@ -905,8 +901,6 @@ svcauth_unix_accept(struct svc_rqst *rqstp)
 	void *body;
 	__be32 *p;
 
-	svcxdr_init_decode(rqstp);
-
 	/*
 	 * This implementation ignores the length of the Call's
 	 * credential body field and the timestamp and machinename



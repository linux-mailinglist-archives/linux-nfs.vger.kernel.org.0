Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77F5765B587
	for <lists+linux-nfs@lfdr.de>; Mon,  2 Jan 2023 18:07:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236275AbjABRG5 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 2 Jan 2023 12:06:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236531AbjABRGf (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 2 Jan 2023 12:06:35 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FE8DB1D0
        for <linux-nfs@vger.kernel.org>; Mon,  2 Jan 2023 09:06:32 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 1C1B2B80D0A
        for <linux-nfs@vger.kernel.org>; Mon,  2 Jan 2023 17:06:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4DF1C433D2
        for <linux-nfs@vger.kernel.org>; Mon,  2 Jan 2023 17:06:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672679189;
        bh=kB2hAJOunsEd5s46hWFVDrdezEPJ+AQQ84smv3NKUOc=;
        h=Subject:From:To:Date:In-Reply-To:References:From;
        b=tSEN9fyepj5ONcU6RRc95QIXrAHdJVOeu8d6dKgZSsYwkpij19qdUBOXn98lMe3Pg
         B8jBM6Itn+TW777+mrv/b92rIpffZKO6UcMOq53xk2r9dIPRhbcGTqNyAFVWbc2DqC
         2oq3gR9DycdsLgtWnvWe1QoQXxd4aKtFtxrrNoPNgDQIMUT0+Q75o9bLwN5SajclB+
         ziH+h6zrFN2plePeU05tsdH7IRtnz2VNiCNhDsPetAcseZX4yu3XmPvHopSx+cUZPf
         czNFWTEPTooyavplZNjQRbDljUmVXmRATL5WxVboP8AHGXRJbQVSwk6WdzqTyrpYWP
         MSajb9RSXcSeQ==
Subject: [PATCH v1 10/25] SUNRPC: Remove gss_read_verf()
From:   Chuck Lever <cel@kernel.org>
To:     linux-nfs@vger.kernel.org
Date:   Mon, 02 Jan 2023 12:06:28 -0500
Message-ID: <167267918869.112521.1785190769332169802.stgit@manet.1015granger.net>
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

gss_read_verf() is already short. Fold it into its only caller.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 net/sunrpc/auth_gss/svcauth_gss.c |   37 +++++++++++--------------------------
 1 file changed, 11 insertions(+), 26 deletions(-)

diff --git a/net/sunrpc/auth_gss/svcauth_gss.c b/net/sunrpc/auth_gss/svcauth_gss.c
index 5da4a3d48a7d..5b03a97e32b7 100644
--- a/net/sunrpc/auth_gss/svcauth_gss.c
+++ b/net/sunrpc/auth_gss/svcauth_gss.c
@@ -1090,28 +1090,6 @@ gss_write_init_verf(struct cache_detail *cd, struct svc_rqst *rqstp,
 	return rc;
 }
 
-static inline int
-gss_read_verf(struct rpc_gss_wire_cred *gc,
-	      struct kvec *argv, __be32 *authp,
-	      struct xdr_netobj *in_handle,
-	      struct xdr_netobj *in_token)
-{
-	struct xdr_netobj tmpobj;
-
-	if (dup_netobj(in_handle, &gc->gc_ctx))
-		return SVC_CLOSE;
-	if (svc_safe_getnetobj(argv, &tmpobj)) {
-		kfree(in_handle->data);
-		return SVC_DENIED;
-	}
-	if (dup_netobj(in_token, &tmpobj)) {
-		kfree(in_handle->data);
-		return SVC_CLOSE;
-	}
-
-	return 0;
-}
-
 static void gss_free_in_token_pages(struct gssp_in_token *in_token)
 {
 	u32 inlen;
@@ -1224,14 +1202,21 @@ static int svcauth_gss_legacy_init(struct svc_rqst *rqstp,
 	struct kvec *argv = &rqstp->rq_arg.head[0];
 	struct kvec *resv = &rqstp->rq_res.head[0];
 	struct rsi *rsip, rsikey;
+	struct xdr_netobj tmpobj;
 	int ret;
 	struct sunrpc_net *sn = net_generic(SVC_NET(rqstp), sunrpc_net_id);
 
 	memset(&rsikey, 0, sizeof(rsikey));
-	ret = gss_read_verf(gc, argv, &rqstp->rq_auth_stat,
-			    &rsikey.in_handle, &rsikey.in_token);
-	if (ret)
-		return ret;
+	if (dup_netobj(&rsikey.in_handle, &gc->gc_ctx))
+		return SVC_CLOSE;
+	if (svc_safe_getnetobj(argv, &tmpobj)) {
+		kfree(rsikey.in_handle.data);
+		return SVC_DENIED;
+	}
+	if (dup_netobj(&rsikey.in_token, &tmpobj)) {
+		kfree(rsikey.in_handle.data);
+		return SVC_CLOSE;
+	}
 
 	/* Perform upcall, or find upcall result: */
 	rsip = rsi_lookup(sn->rsi_cache, &rsikey);



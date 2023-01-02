Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D07F865B594
	for <lists+linux-nfs@lfdr.de>; Mon,  2 Jan 2023 18:07:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236193AbjABRHz (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 2 Jan 2023 12:07:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236372AbjABRHy (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 2 Jan 2023 12:07:54 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57DEDB86B
        for <linux-nfs@vger.kernel.org>; Mon,  2 Jan 2023 09:07:54 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E49C460F79
        for <linux-nfs@vger.kernel.org>; Mon,  2 Jan 2023 17:07:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 356FDC433D2
        for <linux-nfs@vger.kernel.org>; Mon,  2 Jan 2023 17:07:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672679273;
        bh=v4egk5KKdX12WmYMlpz77pidUcJxH1jW+68P2KQV/Lo=;
        h=Subject:From:To:Date:In-Reply-To:References:From;
        b=S9Gj3dTc/IQ+Vfc0OC4FsXH40GJ8mHnMVt/xairXGxDKIRg5F8zCS8ZCS5tvwzNeL
         6ii5qfVOZy+C3RWls8cscSVi42DfSwqEP1PC8OQq3gqcgXx7pVyMnin8haj7OmpJvM
         FICnHp/I9+9JRk9i+Ky4Jwt+JkNAb5lBA8/V1MsdzF3UymsOkJuBgeYFwOlGb4bi6q
         yJkYjgvSTAfdk5PgGUpECuwsis9PzI4/fCnLobxYCc4j6Ktn/yILcqxfjvRFndM3JJ
         3zrD6mFgMQDDPGNy0EqMPvmGaMc5Ch5VyM/sGWsfaZi2yVU5uvsgdt2QVxJLFwkejK
         sODlYSXr5xveA==
Subject: [PATCH v1 23/25] SUNRPC: Decode most of RPC header with xdr_stream
From:   Chuck Lever <cel@kernel.org>
To:     linux-nfs@vger.kernel.org
Date:   Mon, 02 Jan 2023 12:07:52 -0500
Message-ID: <167267927221.112521.10253110100876084263.stgit@manet.1015granger.net>
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
 net/sunrpc/svc.c |   20 +++++++++-----------
 1 file changed, 9 insertions(+), 11 deletions(-)

diff --git a/net/sunrpc/svc.c b/net/sunrpc/svc.c
index 3c1574f362fe..f292b898f200 100644
--- a/net/sunrpc/svc.c
+++ b/net/sunrpc/svc.c
@@ -1231,17 +1231,13 @@ svc_process_common(struct svc_rqst *rqstp, struct kvec *argv, struct kvec *resv)
 	const struct svc_procedure *procp = NULL;
 	struct svc_serv		*serv = rqstp->rq_server;
 	struct svc_process_info process;
-	__be32			*statp;
-	u32			vers;
+	__be32			*p, *statp;
 	__be32			rpc_stat;
 	int			auth_res, rc;
 	__be32			*reply_statp;
 
 	rpc_stat = rpc_success;
 
-	if (argv->iov_len < 6*4)
-		goto err_short_len;
-
 	/* Will be turned off by GSS integrity and privacy services */
 	__set_bit(RQ_SPLICE_OK, &rqstp->rq_flags);
 	/* Will be turned off only when NFSv4 Sessions are used */
@@ -1253,15 +1249,18 @@ svc_process_common(struct svc_rqst *rqstp, struct kvec *argv, struct kvec *resv)
 	svc_putnl(resv, RPC_REPLY);
 	reply_statp = resv->iov_base + resv->iov_len;
 
-	vers = svc_getnl(argv);
-	if (vers != 2)		/* RPC version number */
+	svcxdr_init_decode(rqstp);
+	p = xdr_inline_decode(&rqstp->rq_arg_stream, XDR_UNIT * 4);
+	if (unlikely(!p))
+		goto err_short_len;
+	if (*p++ != cpu_to_be32(RPC_VERSION))
 		goto err_bad_rpc;
 
 	svc_putnl(resv, 0);		/* ACCEPT */
 
-	rqstp->rq_prog = svc_getnl(argv);	/* program number */
-	rqstp->rq_vers = svc_getnl(argv);	/* version number */
-	rqstp->rq_proc = svc_getnl(argv);	/* procedure number */
+	rqstp->rq_prog = be32_to_cpup(p++);
+	rqstp->rq_vers = be32_to_cpup(p++);
+	rqstp->rq_proc = be32_to_cpup(p);
 
 	for (progp = serv->sv_program; progp; progp = progp->pg_next)
 		if (rqstp->rq_prog == progp->pg_prog)
@@ -1272,7 +1271,6 @@ svc_process_common(struct svc_rqst *rqstp, struct kvec *argv, struct kvec *resv)
 	 * We do this before anything else in order to get a decent
 	 * auth verifier.
 	 */
-	svcxdr_init_decode(rqstp);
 	auth_res = svc_authenticate(rqstp);
 	/* Also give the program a chance to reject this call: */
 	if (auth_res == SVC_OK && progp)



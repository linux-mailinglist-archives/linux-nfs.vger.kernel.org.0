Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D6D06616AE
	for <lists+linux-nfs@lfdr.de>; Sun,  8 Jan 2023 17:30:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236195AbjAHQax (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sun, 8 Jan 2023 11:30:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236167AbjAHQan (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sun, 8 Jan 2023 11:30:43 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A06A1E1
        for <linux-nfs@vger.kernel.org>; Sun,  8 Jan 2023 08:30:42 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 27DBA60CA4
        for <linux-nfs@vger.kernel.org>; Sun,  8 Jan 2023 16:30:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 718AEC433F0
        for <linux-nfs@vger.kernel.org>; Sun,  8 Jan 2023 16:30:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673195441;
        bh=33QsprfYNWjDopL//M9suYmrYsCuunMToFxdGtLaWis=;
        h=Subject:From:To:Date:In-Reply-To:References:From;
        b=B8SHGToFDU6R6PyHGD9J2fMf2LHVDrADHfB+GR7RAv1de7ONZDGEM7BTg8wtYhRUw
         Hl/3qCAheiZilxwIsmzmAigmC8R0VnFc0pJuG4N8zhsjlVVtCEEwOFoP3ei1JYKcpI
         vh+jlCyqEFCe/5CeeXDvdijpcpKXFdTRCL/nC1UrtgWzKwQyWtUOQ8vVR/ByjhEbcn
         XKaAjjjYzbFVjXghLrPumDdYqIPuMLDqwlOF81IJuYAupiLP0tgTWcWEkH/mXfxni9
         N4xkjy3yEaw6l9VyMQovBWC1mCF2ZZ1Y+uMJtFdUUiEdc5YAFs9I9t1hVo7XaJZLBz
         kwoYpCEhW8Qbw==
Subject: [PATCH v1 22/27] SUNRPC: Convert RPC Reply header encoding to use
 xdr_stream
From:   Chuck Lever <cel@kernel.org>
To:     linux-nfs@vger.kernel.org
Date:   Sun, 08 Jan 2023 11:30:40 -0500
Message-ID: <167319544056.7490.15568010792301695670.stgit@bazille.1015granger.net>
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

The main part of RPC header encoding and the formation of error
responses are now done using the xdr_stream helpers. Bounds checking
before each XDR data item is encoded makes the server's encoding
path safer against accidental buffer overflows.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 net/sunrpc/svc.c |   50 +++++++++++++++++++++++++-------------------------
 1 file changed, 25 insertions(+), 25 deletions(-)

diff --git a/net/sunrpc/svc.c b/net/sunrpc/svc.c
index 393eebd1f6fe..bcca1553c75a 100644
--- a/net/sunrpc/svc.c
+++ b/net/sunrpc/svc.c
@@ -1227,13 +1227,14 @@ EXPORT_SYMBOL_GPL(svc_generic_init_request);
 static int
 svc_process_common(struct svc_rqst *rqstp, struct kvec *resv)
 {
+	struct xdr_stream	*xdr = &rqstp->rq_res_stream;
 	struct svc_program	*progp;
 	const struct svc_procedure *procp = NULL;
 	struct svc_serv		*serv = rqstp->rq_server;
 	struct svc_process_info process;
 	__be32			*p, *statp;
 	int			auth_res, rc;
-	__be32			*reply_statp;
+	unsigned int		aoffset;
 
 	/* Will be turned off by GSS integrity and privacy services */
 	__set_bit(RQ_SPLICE_OK, &rqstp->rq_flags);
@@ -1242,9 +1243,9 @@ svc_process_common(struct svc_rqst *rqstp, struct kvec *resv)
 	__clear_bit(RQ_DROPME, &rqstp->rq_flags);
 
 	/* Construct the first words of the reply: */
-	svc_putu32(resv, rqstp->rq_xid);
-	svc_putnl(resv, RPC_REPLY);
-	reply_statp = resv->iov_base + resv->iov_len;
+	svcxdr_init_encode(rqstp);
+	xdr_stream_encode_be32(xdr, rqstp->rq_xid);
+	xdr_stream_encode_be32(xdr, rpc_reply);
 
 	p = xdr_inline_decode(&rqstp->rq_arg_stream, XDR_UNIT * 4);
 	if (unlikely(!p))
@@ -1252,7 +1253,7 @@ svc_process_common(struct svc_rqst *rqstp, struct kvec *resv)
 	if (*p++ != cpu_to_be32(RPC_VERSION))
 		goto err_bad_rpc;
 
-	svc_putnl(resv, 0);		/* ACCEPT */
+	xdr_stream_encode_be32(xdr, rpc_msg_accepted);
 
 	rqstp->rq_prog = be32_to_cpup(p++);
 	rqstp->rq_vers = be32_to_cpup(p++);
@@ -1262,8 +1263,6 @@ svc_process_common(struct svc_rqst *rqstp, struct kvec *resv)
 		if (rqstp->rq_prog == progp->pg_prog)
 			break;
 
-	svcxdr_init_encode(rqstp);
-
 	/*
 	 * Decode auth data, and add verifier to reply buffer.
 	 * We do this before anything else in order to get a decent
@@ -1314,6 +1313,7 @@ svc_process_common(struct svc_rqst *rqstp, struct kvec *resv)
 	serv->sv_stats->rpccnt++;
 	trace_svc_process(rqstp, progp->pg_name);
 
+	aoffset = xdr_stream_pos(xdr);
 	statp = xdr_reserve_space(&rqstp->rq_res_stream, XDR_UNIT);
 	*statp = rpc_success;
 
@@ -1332,9 +1332,8 @@ svc_process_common(struct svc_rqst *rqstp, struct kvec *resv)
 	if (rqstp->rq_auth_stat != rpc_auth_ok)
 		goto err_bad_auth;
 
-	/* Check RPC status result */
 	if (*statp != rpc_success)
-		resv->iov_len = ((void*)statp)  - resv->iov_base + 4;
+		xdr_truncate_encode(xdr, aoffset);
 
 	if (procp->pc_encode == NULL)
 		goto dropit;
@@ -1364,27 +1363,28 @@ svc_process_common(struct svc_rqst *rqstp, struct kvec *resv)
 
 err_bad_rpc:
 	serv->sv_stats->rpcbadfmt++;
-	svc_putnl(resv, 1);	/* REJECT */
-	svc_putnl(resv, 0);	/* RPC_MISMATCH */
-	svc_putnl(resv, 2);	/* Only RPCv2 supported */
-	svc_putnl(resv, 2);
+	xdr_stream_encode_u32(xdr, RPC_MSG_DENIED);
+	xdr_stream_encode_u32(xdr, RPC_MISMATCH);
+	/* Only RPCv2 supported */
+	xdr_stream_encode_u32(xdr, RPC_VERSION);
+	xdr_stream_encode_u32(xdr, RPC_VERSION);
 	goto sendit;
 
 err_bad_auth:
 	dprintk("svc: authentication failed (%d)\n",
 		be32_to_cpu(rqstp->rq_auth_stat));
 	serv->sv_stats->rpcbadauth++;
-	/* Restore write pointer to location of accept status: */
-	xdr_ressize_check(rqstp, reply_statp);
-	svc_putnl(resv, 1);	/* REJECT */
-	svc_putnl(resv, 1);	/* AUTH_ERROR */
-	svc_putu32(resv, rqstp->rq_auth_stat);	/* status */
+	/* Restore write pointer to location of reply status: */
+	xdr_truncate_encode(xdr, XDR_UNIT * 2);
+	xdr_stream_encode_u32(xdr, RPC_MSG_DENIED);
+	xdr_stream_encode_u32(xdr, RPC_AUTH_ERROR);
+	xdr_stream_encode_be32(xdr, rqstp->rq_auth_stat);
 	goto sendit;
 
 err_bad_prog:
 	dprintk("svc: unknown program %d\n", rqstp->rq_prog);
 	serv->sv_stats->rpcbadfmt++;
-	svc_putnl(resv, RPC_PROG_UNAVAIL);
+	xdr_stream_encode_u32(xdr, RPC_PROG_UNAVAIL);
 	goto sendit;
 
 err_bad_vers:
@@ -1392,28 +1392,28 @@ svc_process_common(struct svc_rqst *rqstp, struct kvec *resv)
 		       rqstp->rq_vers, rqstp->rq_prog, progp->pg_name);
 
 	serv->sv_stats->rpcbadfmt++;
-	svc_putnl(resv, RPC_PROG_MISMATCH);
-	svc_putnl(resv, process.mismatch.lovers);
-	svc_putnl(resv, process.mismatch.hivers);
+	xdr_stream_encode_u32(xdr, RPC_PROG_MISMATCH);
+	xdr_stream_encode_u32(xdr, process.mismatch.lovers);
+	xdr_stream_encode_u32(xdr, process.mismatch.hivers);
 	goto sendit;
 
 err_bad_proc:
 	svc_printk(rqstp, "unknown procedure (%d)\n", rqstp->rq_proc);
 
 	serv->sv_stats->rpcbadfmt++;
-	svc_putnl(resv, RPC_PROC_UNAVAIL);
+	xdr_stream_encode_u32(xdr, RPC_PROC_UNAVAIL);
 	goto sendit;
 
 err_garbage_args:
 	svc_printk(rqstp, "failed to decode RPC header\n");
 
 	serv->sv_stats->rpcbadfmt++;
-	svc_putnl(resv, RPC_GARBAGE_ARGS);
+	xdr_stream_encode_u32(xdr, RPC_GARBAGE_ARGS);
 	goto sendit;
 
 err_system_err:
 	serv->sv_stats->rpcbadfmt++;
-	svc_putnl(resv, RPC_SYSTEM_ERR);
+	xdr_stream_encode_u32(xdr, RPC_SYSTEM_ERR);
 	goto sendit;
 }
 



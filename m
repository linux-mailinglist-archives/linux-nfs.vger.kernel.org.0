Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A826E65B596
	for <lists+linux-nfs@lfdr.de>; Mon,  2 Jan 2023 18:08:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236216AbjABRIK (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 2 Jan 2023 12:08:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236372AbjABRII (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 2 Jan 2023 12:08:08 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26F49B86C
        for <linux-nfs@vger.kernel.org>; Mon,  2 Jan 2023 09:08:07 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B791660F79
        for <linux-nfs@vger.kernel.org>; Mon,  2 Jan 2023 17:08:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07C4FC433EF
        for <linux-nfs@vger.kernel.org>; Mon,  2 Jan 2023 17:08:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672679286;
        bh=Py6h5ak1AG9lYvrfG/onDBtJzcGwNR6UjZlWwjVpRFA=;
        h=Subject:From:To:Date:In-Reply-To:References:From;
        b=KltpcWt4BqsHRFDCNDLH1mt0+XPpRUAFt/YQsrJIVmzNP80LOQp/uxBNhmTskIc6w
         3QlA4/Omv9yoDwCACPDXm+fO7Lp6Iecxrup7wSH6E4qaYbw0n0pE7Uz5Z4RnBh6iTD
         uHPye6zxaTIRlln0oN4xdmnETQjrhTobZtoBH2uuY+l7iYFFlL3siGNO3hzvW/n2NP
         Z144GCZT9KMLBxX3xmuinp0oV7dVoQuBD23YpYt1/H3x9r9kRQg5dxEYc0FXWccIXP
         +eXc0WVTWbomfKuL9HhZMVquFnlIDyDhqDTF+8Hs1EpqZ5JHmDf9+8sCPV6poX1831
         W9N2E4L1VuW6A==
Subject: [PATCH v1 25/25] SUNRPC: Hoist svcxdr_init_decode() into
 svc_process()
From:   Chuck Lever <cel@kernel.org>
To:     linux-nfs@vger.kernel.org
Date:   Mon, 02 Jan 2023 12:08:04 -0500
Message-ID: <167267928498.112521.12308342986603858400.stgit@manet.1015granger.net>
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

Now the entire RPC Call header parsing path is handled via struct
xdr_stream-based decoders.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 net/sunrpc/svc.c      |   28 +++++++++++++++++-----------
 net/sunrpc/svc_xprt.c |    1 -
 2 files changed, 17 insertions(+), 12 deletions(-)

diff --git a/net/sunrpc/svc.c b/net/sunrpc/svc.c
index 571151a17e87..94f7efca60fc 100644
--- a/net/sunrpc/svc.c
+++ b/net/sunrpc/svc.c
@@ -1249,7 +1249,6 @@ svc_process_common(struct svc_rqst *rqstp, struct kvec *resv)
 	svc_putnl(resv, RPC_REPLY);
 	reply_statp = resv->iov_base + resv->iov_len;
 
-	svcxdr_init_decode(rqstp);
 	p = xdr_inline_decode(&rqstp->rq_arg_stream, XDR_UNIT * 4);
 	if (unlikely(!p))
 		goto err_short_len;
@@ -1425,9 +1424,8 @@ svc_process_common(struct svc_rqst *rqstp, struct kvec *resv)
 int
 svc_process(struct svc_rqst *rqstp)
 {
-	struct kvec		*argv = &rqstp->rq_arg.head[0];
 	struct kvec		*resv = &rqstp->rq_res.head[0];
-	__be32			dir;
+	__be32 *p;
 
 #if IS_ENABLED(CONFIG_FAIL_SUNRPC)
 	if (!fail_sunrpc.ignore_server_disconnect &&
@@ -1450,16 +1448,21 @@ svc_process(struct svc_rqst *rqstp)
 	rqstp->rq_res.tail[0].iov_base = NULL;
 	rqstp->rq_res.tail[0].iov_len = 0;
 
-	dir = svc_getu32(argv);
-	if (dir != rpc_call)
+	svcxdr_init_decode(rqstp);
+	p = xdr_inline_decode(&rqstp->rq_arg_stream, XDR_UNIT * 2);
+	if (unlikely(!p))
+		goto out_drop;
+	rqstp->rq_xid = *p++;
+	if (unlikely(*p != rpc_call))
 		goto out_baddir;
+
 	if (!svc_process_common(rqstp, resv))
 		goto out_drop;
 	return svc_send(rqstp);
 
 out_baddir:
 	svc_printk(rqstp, "bad direction 0x%08x, dropping request\n",
-		   be32_to_cpu(dir));
+		   be32_to_cpu(*p));
 	rqstp->rq_server->sv_stats->rpcbadfmt++;
 out_drop:
 	svc_drop(rqstp);
@@ -1476,7 +1479,6 @@ int
 bc_svc_process(struct svc_serv *serv, struct rpc_rqst *req,
 	       struct svc_rqst *rqstp)
 {
-	struct kvec	*argv = &rqstp->rq_arg.head[0];
 	struct kvec	*resv = &rqstp->rq_res.head[0];
 	struct rpc_task *task;
 	int proc_error;
@@ -1511,12 +1513,16 @@ bc_svc_process(struct svc_serv *serv, struct rpc_rqst *req,
 	/* reset result send buffer "put" position */
 	resv->iov_len = 0;
 
+	svcxdr_init_decode(rqstp);
+
 	/*
-	 * Skip the next two words because they've already been
-	 * processed in the transport
+	 * Skip the XID and calldir fields because they've already
+	 * been processed by the caller.
 	 */
-	svc_getu32(argv);	/* XID */
-	svc_getnl(argv);	/* CALLDIR */
+	if (!xdr_inline_decode(&rqstp->rq_arg_stream, XDR_UNIT * 2)) {
+		error = -EINVAL;
+		goto out;
+	}
 
 	/* Parse and execute the bc call */
 	proc_error = svc_process_common(rqstp, resv);
diff --git a/net/sunrpc/svc_xprt.c b/net/sunrpc/svc_xprt.c
index 2106003645a7..b4697984b4b2 100644
--- a/net/sunrpc/svc_xprt.c
+++ b/net/sunrpc/svc_xprt.c
@@ -890,7 +890,6 @@ int svc_recv(struct svc_rqst *rqstp, long timeout)
 
 	xprt->xpt_ops->xpo_secure_port(rqstp);
 	rqstp->rq_chandle.defer = svc_defer;
-	rqstp->rq_xid = svc_getu32(&rqstp->rq_arg.head[0]);
 
 	if (serv->sv_stats)
 		serv->sv_stats->netcnt++;



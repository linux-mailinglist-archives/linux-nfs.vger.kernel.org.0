Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2315F5B62A3
	for <lists+linux-nfs@lfdr.de>; Mon, 12 Sep 2022 23:22:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229700AbiILVWi (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 12 Sep 2022 17:22:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229724AbiILVWh (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 12 Sep 2022 17:22:37 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B83A4B0E7
        for <linux-nfs@vger.kernel.org>; Mon, 12 Sep 2022 14:22:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 561846124A
        for <linux-nfs@vger.kernel.org>; Mon, 12 Sep 2022 21:22:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB65EC433D7
        for <linux-nfs@vger.kernel.org>; Mon, 12 Sep 2022 21:22:33 +0000 (UTC)
Subject: [PATCH v1 01/12] SUNRPC: Optimize svc_process()
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org
Date:   Mon, 12 Sep 2022 17:22:33 -0400
Message-ID: <166301775296.89884.6944917394566836389.stgit@oracle-102.nfsv4.dev>
In-Reply-To: <166301759113.89884.7985359396842428444.stgit@oracle-102.nfsv4.dev>
References: <166301759113.89884.7985359396842428444.stgit@oracle-102.nfsv4.dev>
User-Agent: StGit/1.5
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Move exception handling code out of the hot path, and avoid the need
for a bswap of a non-constant.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 net/sunrpc/svc.c |   24 +++++++++++-------------
 1 file changed, 11 insertions(+), 13 deletions(-)

diff --git a/net/sunrpc/svc.c b/net/sunrpc/svc.c
index 7c9a0d0b1230..4268145490a4 100644
--- a/net/sunrpc/svc.c
+++ b/net/sunrpc/svc.c
@@ -1434,8 +1434,7 @@ svc_process(struct svc_rqst *rqstp)
 {
 	struct kvec		*argv = &rqstp->rq_arg.head[0];
 	struct kvec		*resv = &rqstp->rq_res.head[0];
-	struct svc_serv		*serv = rqstp->rq_server;
-	u32			dir;
+	__be32			dir;
 
 #if IS_ENABLED(CONFIG_FAIL_SUNRPC)
 	if (!fail_sunrpc.ignore_server_disconnect &&
@@ -1450,7 +1449,7 @@ svc_process(struct svc_rqst *rqstp)
 	rqstp->rq_next_page = &rqstp->rq_respages[1];
 	resv->iov_base = page_address(rqstp->rq_respages[0]);
 	resv->iov_len = 0;
-	rqstp->rq_res.pages = rqstp->rq_respages + 1;
+	rqstp->rq_res.pages = rqstp->rq_next_page;
 	rqstp->rq_res.len = 0;
 	rqstp->rq_res.page_base = 0;
 	rqstp->rq_res.page_len = 0;
@@ -1458,18 +1457,17 @@ svc_process(struct svc_rqst *rqstp)
 	rqstp->rq_res.tail[0].iov_base = NULL;
 	rqstp->rq_res.tail[0].iov_len = 0;
 
-	dir  = svc_getnl(argv);
-	if (dir != 0) {
-		/* direction != CALL */
-		svc_printk(rqstp, "bad direction %d, dropping request\n", dir);
-		serv->sv_stats->rpcbadfmt++;
+	dir = svc_getu32(argv);
+	if (dir != rpc_call)
+		goto out_baddir;
+	if (!svc_process_common(rqstp, argv, resv))
 		goto out_drop;
-	}
-
-	/* Returns 1 for send, 0 for drop */
-	if (likely(svc_process_common(rqstp, argv, resv)))
-		return svc_send(rqstp);
+	return svc_send(rqstp);
 
+out_baddir:
+	svc_printk(rqstp, "bad direction 0x%08x, dropping request\n",
+		   be32_to_cpu(dir));
+	rqstp->rq_server->sv_stats->rpcbadfmt++;
 out_drop:
 	svc_drop(rqstp);
 	return 0;



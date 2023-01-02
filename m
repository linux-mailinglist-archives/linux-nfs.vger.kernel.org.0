Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 184EB65B595
	for <lists+linux-nfs@lfdr.de>; Mon,  2 Jan 2023 18:08:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236147AbjABRID (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 2 Jan 2023 12:08:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236202AbjABRIC (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 2 Jan 2023 12:08:02 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B399864DB
        for <linux-nfs@vger.kernel.org>; Mon,  2 Jan 2023 09:08:00 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5135B60F79
        for <linux-nfs@vger.kernel.org>; Mon,  2 Jan 2023 17:08:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B6F8C433D2
        for <linux-nfs@vger.kernel.org>; Mon,  2 Jan 2023 17:07:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672679279;
        bh=uZoBRUQ42c5ysnALy31peiDJKRWwcagd71/KKJOgRAM=;
        h=Subject:From:To:Date:In-Reply-To:References:From;
        b=b0UmdEFAFWgAk4xubM3spVXPw7f97PPo30inSEnmv57MVZbDgKX9uLaXt0fgvMiku
         gZEcFtxf06s4rx3jd34T0xerxFHxNtHSw/uuIjL3/ZwOEAb8l7Dh5yK2qpgdt1l+td
         246ffH3H6hkYjQ6KPeAIa2kisgE8raqCbvMUIJ/xahgJQOKIpVsPHLkrAzKM5Ry9F6
         toHgAmpU4wFdXNwTcBqJMmA2ruOKFtQw/TDaw03lxzHlmzJLn/LxuiF3L6JzmofLzQ
         Es6+SBsSJurArPG1y2O7dMNUOudEE8yDlAO4t8MQfarFasHB+MFY7ivd63qEFKeKLx
         ftAPgXP2EvJMw==
Subject: [PATCH v1 24/25] SUNRPC: Remove svc_process_common's argv parameter
From:   Chuck Lever <cel@kernel.org>
To:     linux-nfs@vger.kernel.org
Date:   Mon, 02 Jan 2023 12:07:58 -0500
Message-ID: <167267927856.112521.12923547853480719674.stgit@manet.1015granger.net>
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

Clean up: With xdr_stream decoding, the @argv parameter is no longer
used.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 net/sunrpc/svc.c |   10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/net/sunrpc/svc.c b/net/sunrpc/svc.c
index f292b898f200..571151a17e87 100644
--- a/net/sunrpc/svc.c
+++ b/net/sunrpc/svc.c
@@ -1225,7 +1225,7 @@ EXPORT_SYMBOL_GPL(svc_generic_init_request);
  * Common routine for processing the RPC request.
  */
 static int
-svc_process_common(struct svc_rqst *rqstp, struct kvec *argv, struct kvec *resv)
+svc_process_common(struct svc_rqst *rqstp, struct kvec *resv)
 {
 	struct svc_program	*progp;
 	const struct svc_procedure *procp = NULL;
@@ -1363,8 +1363,8 @@ svc_process_common(struct svc_rqst *rqstp, struct kvec *argv, struct kvec *resv)
 	return 0;
 
 err_short_len:
-	svc_printk(rqstp, "short len %zd, dropping request\n",
-			argv->iov_len);
+	svc_printk(rqstp, "short len %u, dropping request\n",
+		   rqstp->rq_arg.len);
 	goto close_xprt;
 
 err_bad_rpc:
@@ -1453,7 +1453,7 @@ svc_process(struct svc_rqst *rqstp)
 	dir = svc_getu32(argv);
 	if (dir != rpc_call)
 		goto out_baddir;
-	if (!svc_process_common(rqstp, argv, resv))
+	if (!svc_process_common(rqstp, resv))
 		goto out_drop;
 	return svc_send(rqstp);
 
@@ -1519,7 +1519,7 @@ bc_svc_process(struct svc_serv *serv, struct rpc_rqst *req,
 	svc_getnl(argv);	/* CALLDIR */
 
 	/* Parse and execute the bc call */
-	proc_error = svc_process_common(rqstp, argv, resv);
+	proc_error = svc_process_common(rqstp, resv);
 
 	atomic_dec(&req->rq_xprt->bc_slot_count);
 	if (!proc_error) {



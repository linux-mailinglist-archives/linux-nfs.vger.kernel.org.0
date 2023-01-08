Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33CC666169E
	for <lists+linux-nfs@lfdr.de>; Sun,  8 Jan 2023 17:29:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234916AbjAHQ3k (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sun, 8 Jan 2023 11:29:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236098AbjAHQ3f (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sun, 8 Jan 2023 11:29:35 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 873E360CD
        for <linux-nfs@vger.kernel.org>; Sun,  8 Jan 2023 08:29:34 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2283360C8C
        for <linux-nfs@vger.kernel.org>; Sun,  8 Jan 2023 16:29:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6FA0EC433D2
        for <linux-nfs@vger.kernel.org>; Sun,  8 Jan 2023 16:29:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673195373;
        bh=+V1BJJF/5pa4hW5EKyheq6lEDttHVTrhXTIkOdLucdc=;
        h=Subject:From:To:Date:In-Reply-To:References:From;
        b=iNIleci4GrgMtudslV+cc2Uo2BFvLF6BwkFDHydBal1nCN1D1tMmhpe0EnxHqoy9R
         depCGfQq9FBbTTImmuPX3Ivb/pf/uZ6t2NrN666raerzPmUzI3rMxA76vgwlzExf6t
         fr1nmy9IXy3u2WBFq6MwxR+vQTXJrHJ+s0NK0lQpr57hUfpbc5OOa9/gbWAqVchTlm
         Ny9H1whI1ZtTNltPf/wlAXQA+xWttoKalv6VsuAn/LiDQeLUXn2TErJqXjHvdg9Qrh
         ROck351FnbCFv7hoews2ZheS1G8yEKJIk1AgFuqfQA3a1Diql2TfHYpV053iqN/r66
         ZI0p7WRrR2giA==
Subject: [PATCH v1 11/27] SUNRPC: Remove the rpc_stat variable in
 svc_process_common()
From:   Chuck Lever <cel@kernel.org>
To:     linux-nfs@vger.kernel.org
Date:   Sun, 08 Jan 2023 11:29:32 -0500
Message-ID: <167319537254.7490.13683547890552781753.stgit@bazille.1015granger.net>
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

There's no RPC header field called rpc_stat; more precisely, the
variable appears to be recording an accept_stat value. But it looks
like we don't need to preserve this value at all, actually, so
simply remove the variable.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 net/sunrpc/svc.c |   24 +++++++++++-------------
 1 file changed, 11 insertions(+), 13 deletions(-)

diff --git a/net/sunrpc/svc.c b/net/sunrpc/svc.c
index 94f7efca60fc..489c5d1b67f9 100644
--- a/net/sunrpc/svc.c
+++ b/net/sunrpc/svc.c
@@ -1232,12 +1232,9 @@ svc_process_common(struct svc_rqst *rqstp, struct kvec *resv)
 	struct svc_serv		*serv = rqstp->rq_server;
 	struct svc_process_info process;
 	__be32			*p, *statp;
-	__be32			rpc_stat;
 	int			auth_res, rc;
 	__be32			*reply_statp;
 
-	rpc_stat = rpc_success;
-
 	/* Will be turned off by GSS integrity and privacy services */
 	__set_bit(RQ_SPLICE_OK, &rqstp->rq_flags);
 	/* Will be turned off only when NFSv4 Sessions are used */
@@ -1279,10 +1276,9 @@ svc_process_common(struct svc_rqst *rqstp, struct kvec *resv)
 	case SVC_OK:
 		break;
 	case SVC_GARBAGE:
-		goto err_garbage;
+		goto err_garbage_args;
 	case SVC_SYSERR:
-		rpc_stat = rpc_system_err;
-		goto err_bad;
+		goto err_system_err;
 	case SVC_DENIED:
 		goto err_bad_auth;
 	case SVC_CLOSE:
@@ -1296,8 +1292,7 @@ svc_process_common(struct svc_rqst *rqstp, struct kvec *resv)
 	if (progp == NULL)
 		goto err_bad_prog;
 
-	rpc_stat = progp->pg_init_request(rqstp, progp, &process);
-	switch (rpc_stat) {
+	switch (progp->pg_init_request(rqstp, progp, &process)) {
 	case rpc_success:
 		break;
 	case rpc_prog_unavail:
@@ -1408,13 +1403,16 @@ svc_process_common(struct svc_rqst *rqstp, struct kvec *resv)
 	svc_putnl(resv, RPC_PROC_UNAVAIL);
 	goto sendit;
 
-err_garbage:
-	svc_printk(rqstp, "failed to decode args\n");
+err_garbage_args:
+	svc_printk(rqstp, "failed to decode RPC header\n");
+
+	serv->sv_stats->rpcbadfmt++;
+	svc_putnl(resv, RPC_GARBAGE_ARGS);
+	goto sendit;
 
-	rpc_stat = rpc_garbage_args;
-err_bad:
+err_system_err:
 	serv->sv_stats->rpcbadfmt++;
-	svc_putnl(resv, ntohl(rpc_stat));
+	svc_putnl(resv, RPC_SYSTEM_ERR);
 	goto sendit;
 }
 



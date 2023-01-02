Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5480265B593
	for <lists+linux-nfs@lfdr.de>; Mon,  2 Jan 2023 18:07:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232796AbjABRHx (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 2 Jan 2023 12:07:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236485AbjABRHv (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 2 Jan 2023 12:07:51 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 756D2BC09
        for <linux-nfs@vger.kernel.org>; Mon,  2 Jan 2023 09:07:49 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 3979DB80D0D
        for <linux-nfs@vger.kernel.org>; Mon,  2 Jan 2023 17:07:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D57C9C433EF
        for <linux-nfs@vger.kernel.org>; Mon,  2 Jan 2023 17:07:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672679267;
        bh=Czc27/R8QuGddTFQdY9wbQyJ9XqVCjHMxtOnOjEbXiQ=;
        h=Subject:From:To:Date:In-Reply-To:References:From;
        b=mc89q7BZFdbvcYEEuSCrb4bhwOCOPN9mxwlKLipw3Odhdxj9VYYa4bOCISsAGmSaB
         t1iM2GZxaIKec0kwDC3tJ9yOc/JllLhP3/mxcsDhQov582ObnZSoCjKvw9pEPjUAWs
         lSlBqYslPDzrbtYfrekxa7K5VB37PQbfgh39NMIoG7gopm3fNq711e5QLDcIS1hD0T
         UGpLz6fa7yuhABzait1zdnX6q/5kNBSxFTTF6DfE3aDOg0Sh6X+u9NvXUlm7GmQvdW
         4nWhaFskS5sXsAbIVXGug6Z9BeZFMcw5u7X4f2sdwCYJwll4ok2TiooeJXy84A0sRs
         WkOPUvMGtxaaQ==
Subject: [PATCH v1 22/25] SUNRPC: Eliminate unneeded variable
From:   Chuck Lever <cel@kernel.org>
To:     linux-nfs@vger.kernel.org
Date:   Mon, 02 Jan 2023 12:07:45 -0500
Message-ID: <167267926581.112521.16946881347611603048.stgit@manet.1015granger.net>
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

Clean up: Saving the RPC program number in two places is
unnecessary.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 net/sunrpc/svc.c |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/net/sunrpc/svc.c b/net/sunrpc/svc.c
index e473c19b2f8d..3c1574f362fe 100644
--- a/net/sunrpc/svc.c
+++ b/net/sunrpc/svc.c
@@ -1232,7 +1232,7 @@ svc_process_common(struct svc_rqst *rqstp, struct kvec *argv, struct kvec *resv)
 	struct svc_serv		*serv = rqstp->rq_server;
 	struct svc_process_info process;
 	__be32			*statp;
-	u32			prog, vers;
+	u32			vers;
 	__be32			rpc_stat;
 	int			auth_res, rc;
 	__be32			*reply_statp;
@@ -1259,12 +1259,12 @@ svc_process_common(struct svc_rqst *rqstp, struct kvec *argv, struct kvec *resv)
 
 	svc_putnl(resv, 0);		/* ACCEPT */
 
-	rqstp->rq_prog = prog = svc_getnl(argv);	/* program number */
+	rqstp->rq_prog = svc_getnl(argv);	/* program number */
 	rqstp->rq_vers = svc_getnl(argv);	/* version number */
 	rqstp->rq_proc = svc_getnl(argv);	/* procedure number */
 
 	for (progp = serv->sv_program; progp; progp = progp->pg_next)
-		if (prog == progp->pg_prog)
+		if (rqstp->rq_prog == progp->pg_prog)
 			break;
 
 	/*
@@ -1389,7 +1389,7 @@ svc_process_common(struct svc_rqst *rqstp, struct kvec *argv, struct kvec *resv)
 	goto sendit;
 
 err_bad_prog:
-	dprintk("svc: unknown program %d\n", prog);
+	dprintk("svc: unknown program %d\n", rqstp->rq_prog);
 	serv->sv_stats->rpcbadfmt++;
 	svc_putnl(resv, RPC_PROG_UNAVAIL);
 	goto sendit;



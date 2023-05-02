Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70C2F6F4A01
	for <lists+linux-nfs@lfdr.de>; Tue,  2 May 2023 20:59:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229565AbjEBS7P (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 2 May 2023 14:59:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229562AbjEBS7O (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 2 May 2023 14:59:14 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32645DC
        for <linux-nfs@vger.kernel.org>; Tue,  2 May 2023 11:59:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C42B2627F9
        for <linux-nfs@vger.kernel.org>; Tue,  2 May 2023 18:59:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2686C433EF;
        Tue,  2 May 2023 18:59:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683053952;
        bh=WdWWgcBJqJX2GgNPGQRYjftsKD60gJEMecvwekuyDxU=;
        h=Subject:From:To:Cc:Date:From;
        b=BchWBkc50NCAhmRjfEx1r0DzvMr0T9/xLEdhsQfy4+hd+4X2AK2lgocsNJTBnl4ty
         edx+Bs6nPLIiw3qhz7vwFfNZMC5R3IdV0tnRSDKNSCivL+O3oz0ZYSaI7LBIp+WxpM
         IexgDRsF+a74uEYikiM2AfszOiPKO3m9xFdsOGCQJet42yqztdyHYboRSPvWvkQ8Jy
         HWp1D27A56HBm1T0qMFQWOxfjEeBQY9Ij63vvJIcp2sK3FMvjGnph5LsqZBDhBRKci
         /UCC85ojAO/eZdLGwdLJvHrrWVur5QT+OEjZyMYkUMAwY36sFp6I+2RT67CCafgjjL
         EIp55X3tGrJQQ==
Subject: [PATCH] SUNRPC: Fix encoding of rejected RPCs
From:   Chuck Lever <cel@kernel.org>
To:     jirislaby@kernel.org
Cc:     linux-nfs@vger.kernel.org
Date:   Tue, 02 May 2023 14:59:10 -0400
Message-ID: <168305395091.2266.16355121702708383278.stgit@bazille.1015granger.net>
User-Agent: StGit/1.5
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Chuck Lever <chuck.lever@oracle.com>

Jiri Slaby says:
> I bisected to this ... as it breaks nfs3-only servers in 6.3.
> I.e. /etc/nfs.conf containing:
> [nfsd]
> vers4=no
>
> The client sees:
>  mount("10.0.2.15:/tmp", "/mnt", "nfs", 0, "vers=4.2,addr=10.0.2.15,clientad"...) = -1 EIO (Input/output error)
>  write(2, "mount.nfs: mount system call fai"..., 45
>  mount.nfs: mount system call failed for /mnt
>
> And the kernel says:
>  nfs4_discover_server_trunking unhandled error -5. Exiting with error EIO

Reported-by: Jiri Slaby <jirislaby@kernel.org>
Link: https://bugzilla.suse.com/show_bug.cgi?id=1210995
Fixes: 4bcf0343e8a6 ("SUNRPC: Set rq_accept_statp inside ->accept methods")
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 net/sunrpc/svc.c |   17 +++++++++++------
 1 file changed, 11 insertions(+), 6 deletions(-)

diff --git a/net/sunrpc/svc.c b/net/sunrpc/svc.c
index fea7ce8fba14..9874a6de1de3 100644
--- a/net/sunrpc/svc.c
+++ b/net/sunrpc/svc.c
@@ -1382,7 +1382,7 @@ svc_process_common(struct svc_rqst *rqstp)
 	/* Only RPCv2 supported */
 	xdr_stream_encode_u32(xdr, RPC_VERSION);
 	xdr_stream_encode_u32(xdr, RPC_VERSION);
-	goto sendit;
+	return 1;	/* don't wrap */
 
 err_bad_auth:
 	dprintk("svc: authentication failed (%d)\n",
@@ -1398,7 +1398,7 @@ svc_process_common(struct svc_rqst *rqstp)
 err_bad_prog:
 	dprintk("svc: unknown program %d\n", rqstp->rq_prog);
 	serv->sv_stats->rpcbadfmt++;
-	xdr_stream_encode_u32(xdr, RPC_PROG_UNAVAIL);
+	*rqstp->rq_accept_statp = rpc_prog_unavail;
 	goto sendit;
 
 err_bad_vers:
@@ -1406,7 +1406,12 @@ svc_process_common(struct svc_rqst *rqstp)
 		       rqstp->rq_vers, rqstp->rq_prog, progp->pg_name);
 
 	serv->sv_stats->rpcbadfmt++;
-	xdr_stream_encode_u32(xdr, RPC_PROG_MISMATCH);
+	*rqstp->rq_accept_statp = rpc_prog_mismatch;
+
+	/*
+	 * svc_authenticate() has already added the verifier and
+	 * advanced the stream just past rq_accept_statp.
+	 */
 	xdr_stream_encode_u32(xdr, process.mismatch.lovers);
 	xdr_stream_encode_u32(xdr, process.mismatch.hivers);
 	goto sendit;
@@ -1415,19 +1420,19 @@ svc_process_common(struct svc_rqst *rqstp)
 	svc_printk(rqstp, "unknown procedure (%d)\n", rqstp->rq_proc);
 
 	serv->sv_stats->rpcbadfmt++;
-	xdr_stream_encode_u32(xdr, RPC_PROC_UNAVAIL);
+	*rqstp->rq_accept_statp = rpc_proc_unavail;
 	goto sendit;
 
 err_garbage_args:
 	svc_printk(rqstp, "failed to decode RPC header\n");
 
 	serv->sv_stats->rpcbadfmt++;
-	xdr_stream_encode_u32(xdr, RPC_GARBAGE_ARGS);
+	*rqstp->rq_accept_statp = rpc_garbage_args;
 	goto sendit;
 
 err_system_err:
 	serv->sv_stats->rpcbadfmt++;
-	xdr_stream_encode_u32(xdr, RPC_SYSTEM_ERR);
+	*rqstp->rq_accept_statp = rpc_system_err;
 	goto sendit;
 }
 



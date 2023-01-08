Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EFC8C6616A3
	for <lists+linux-nfs@lfdr.de>; Sun,  8 Jan 2023 17:30:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236098AbjAHQaC (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sun, 8 Jan 2023 11:30:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236106AbjAHQaB (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sun, 8 Jan 2023 11:30:01 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA4D13889
        for <linux-nfs@vger.kernel.org>; Sun,  8 Jan 2023 08:30:00 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 8214DB801C1
        for <linux-nfs@vger.kernel.org>; Sun,  8 Jan 2023 16:29:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A8E9C433D2
        for <linux-nfs@vger.kernel.org>; Sun,  8 Jan 2023 16:29:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673195398;
        bh=T0t5gAk7FsIRyQ1OhhP35VCh7QUY/eTz7668FImmvtU=;
        h=Subject:From:To:Date:In-Reply-To:References:From;
        b=IVEnwOTkLRIHTyqBWaCh01OstZJsW1WzdspwOK40FlnmHcaJf3s/hsRf7SzMU0EyW
         XkfWMdv5ARN6vCEztrJ6Arf3k6BxJzDeVgcTHn8wOWyREb7la0ehrrSlZhIrvh9R6j
         0OOGGzaPqGGyXXG6QvsWCwPlM8bgPVGVD1A3Y9F7kmZn0ptxvYM77femlcFpqLKGEr
         I9R6gIU8Xxza+Kk879AeyKCB8I4cbOyEV54cyIr0xOGcFSVi+rO3v8VtU0JN/mAx2S
         nhUEhN9p44A+4T3gPJydrDkqldWdvvl6/ZrV6ACqqkyjgz3DP2jQEnqf8xo6FCUCuG
         9TnS/yEnwfv0w==
Subject: [PATCH v1 15/27] SUNRPC: Use xdr_stream to encode Reply verifier in
 svcauth_null_accept()
From:   Chuck Lever <cel@kernel.org>
To:     linux-nfs@vger.kernel.org
Date:   Sun, 08 Jan 2023 11:29:57 -0500
Message-ID: <167319539727.7490.8201680952185298779.stgit@bazille.1015granger.net>
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

Done as part of hardening the server-side RPC header encoding path.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 net/sunrpc/svcauth_unix.c |    9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/net/sunrpc/svcauth_unix.c b/net/sunrpc/svcauth_unix.c
index 6281d23f98bf..b24d6c75588f 100644
--- a/net/sunrpc/svcauth_unix.c
+++ b/net/sunrpc/svcauth_unix.c
@@ -744,7 +744,6 @@ EXPORT_SYMBOL_GPL(svcauth_unix_set_client);
 static int
 svcauth_null_accept(struct svc_rqst *rqstp)
 {
-	struct kvec	*resv = &rqstp->rq_res.head[0];
 	struct xdr_stream *xdr = &rqstp->rq_arg_stream;
 	struct svc_cred	*cred = &rqstp->rq_cred;
 	u32 flavor, len;
@@ -773,12 +772,12 @@ svcauth_null_accept(struct svc_rqst *rqstp)
 	if (cred->cr_group_info == NULL)
 		return SVC_CLOSE; /* kmalloc failure - client must retry */
 
-	/* Put NULL verifier */
-	svc_putnl(resv, RPC_AUTH_NULL);
-	svc_putnl(resv, 0);
+	svcxdr_init_encode(rqstp);
+	if (xdr_stream_encode_opaque_auth(&rqstp->rq_res_stream,
+					  RPC_AUTH_NULL, NULL, 0) < 0)
+		return SVC_CLOSE;
 
 	rqstp->rq_cred.cr_flavor = RPC_AUTH_NULL;
-	svcxdr_init_encode(rqstp);
 	return SVC_OK;
 }
 



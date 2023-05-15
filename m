Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5954702E2A
	for <lists+linux-nfs@lfdr.de>; Mon, 15 May 2023 15:32:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241579AbjEONcw (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 15 May 2023 09:32:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240863AbjEONcw (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 15 May 2023 09:32:52 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B44CCE69
        for <linux-nfs@vger.kernel.org>; Mon, 15 May 2023 06:32:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4E66F6249A
        for <linux-nfs@vger.kernel.org>; Mon, 15 May 2023 13:32:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8CB1FC433EF;
        Mon, 15 May 2023 13:32:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684157568;
        bh=OS26ygfCmeKYk5UMOdH88S37nToFGs1y0OBxzzMrPUU=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=tVzf0y2HXpbm46gIpliFC6CX5nA+QXHMZVa+WraWQkq2Fx6tn/O+yZqqG+nN1rPPt
         gVL769dE8KC8pUyeFVvH0btOgOtAGOJNaGjoWZK1qUU+SbAqc0cdE52WxvPJLPOiAV
         oSDmPy2RtfHQamDmOAXy716CrLWCuvMTIj6d2/ZNE5rvmosH+CThEuS5SavsNmbM3N
         ra4k8pkb2Xgq97JE7s4zPQVen3HYRhWxIxTSN0LMc2INSD9uYyMdC9Ys9AZ2AULbHR
         sk+JhuyEy31f1Fiq42N5pGRTMNm8X6aH1KyRl9Kk9zGKFvdxiMsZsqAHrLoiS16Hg0
         M8bxwrLjxbbSQ==
Subject: [PATCH 2/4] SUNRPC: Remove dprintk() in svc_handle_xprt()
From:   Chuck Lever <cel@kernel.org>
To:     linux-nfs@vger.kernel.org
Cc:     Chuck Lever <chuck.lever@oracle.com>
Date:   Mon, 15 May 2023 09:32:47 -0400
Message-ID: <168415756766.9504.10410580688428555837.stgit@manet.1015granger.net>
In-Reply-To: <168415745478.9504.1882537002036193828.stgit@manet.1015granger.net>
References: <168415745478.9504.1882537002036193828.stgit@manet.1015granger.net>
User-Agent: StGit/1.5
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Chuck Lever <chuck.lever@oracle.com>

When enabled, this dprintk() fires for every incoming RPC, which is
an enormous amount of log traffic. These days, after the first few
hundred log messages, the system journald is just going to mute it,
along with all other NFSD debug output.

Let's rely on trace points for this high-traffic information
instead.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 net/sunrpc/svc_xprt.c |    3 ---
 1 file changed, 3 deletions(-)

diff --git a/net/sunrpc/svc_xprt.c b/net/sunrpc/svc_xprt.c
index 84e5d7d31481..b3564afc53b7 100644
--- a/net/sunrpc/svc_xprt.c
+++ b/net/sunrpc/svc_xprt.c
@@ -833,9 +833,6 @@ static int svc_handle_xprt(struct svc_rqst *rqstp, struct svc_xprt *xprt)
 		svc_xprt_received(xprt);
 	} else if (svc_xprt_reserve_slot(rqstp, xprt)) {
 		/* XPT_DATA|XPT_DEFERRED case: */
-		dprintk("svc: server %p, pool %u, transport %p, inuse=%d\n",
-			rqstp, rqstp->rq_pool->sp_id, xprt,
-			kref_read(&xprt->xpt_ref));
 		rqstp->rq_deferred = svc_deferred_dequeue(xprt);
 		if (rqstp->rq_deferred)
 			len = svc_deferred_recv(rqstp);



Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A603872C720
	for <lists+linux-nfs@lfdr.de>; Mon, 12 Jun 2023 16:13:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237233AbjFLONi (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 12 Jun 2023 10:13:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235611AbjFLONf (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 12 Jun 2023 10:13:35 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33C58F0
        for <linux-nfs@vger.kernel.org>; Mon, 12 Jun 2023 07:13:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BCD1860D2B
        for <linux-nfs@vger.kernel.org>; Mon, 12 Jun 2023 14:13:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02F91C4339E;
        Mon, 12 Jun 2023 14:13:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686579214;
        bh=RLCI3f5juRGrnRLCVXUBLGHr06RYCTJ4vc07IPRPL2w=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=b5yMNvmadmAJ5IHLKvAu2w6yOSiy8sj384F6kvBpRGiFabCa4m1eDCPaQndQWfhJM
         hxau6Ugx3wNUTku4o5/ptnoe4qm/nE8RMO11cWaAUmog8hoJJW2QJ35Gcz/kcVReB1
         sgIeKaMEv7Q9dXrniT/bEF30X0P60btbuum3fki5dhP/rQVzbLb9UEYXbPKEGjeXb+
         /NezSrH+R62jY82FneIyULqKNk9fb7VBe5pgziKtsr/wOs3zE8Hy/Lb9a2O8dDvCE5
         VH9l011B+lQYAahFp5EWNIuZUyiOYAbCHXiIWqFK2nXC63iJQiTlBrB1Ce5MS2IBMi
         kqXmN09q4Ackw==
Subject: [PATCH v1 1/7] SUNRPC: Move initialization of rq_stime
From:   Chuck Lever <cel@kernel.org>
To:     linux-nfs@vger.kernel.org
Cc:     Chuck Lever <chuck.lever@oracle.com>
Date:   Mon, 12 Jun 2023 10:13:33 -0400
Message-ID: <168657921305.5674.11399334151508322408.stgit@manet.1015granger.net>
In-Reply-To: <168657912781.5674.12501431304770900992.stgit@manet.1015granger.net>
References: <168657912781.5674.12501431304770900992.stgit@manet.1015granger.net>
User-Agent: StGit/1.5
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Chuck Lever <chuck.lever@oracle.com>

Micro-optimization: Call ktime_get() only when ->xpo_recvfrom() has
given us a full RPC message to process. rq_stime isn't used
otherwise, so this avoids pointless work.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 net/sunrpc/svc_xprt.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/sunrpc/svc_xprt.c b/net/sunrpc/svc_xprt.c
index 45bdc2e38631..4af83a0fd395 100644
--- a/net/sunrpc/svc_xprt.c
+++ b/net/sunrpc/svc_xprt.c
@@ -852,7 +852,6 @@ static int svc_handle_xprt(struct svc_rqst *rqstp, struct svc_xprt *xprt)
 			len = svc_deferred_recv(rqstp);
 		else
 			len = xprt->xpt_ops->xpo_recvfrom(rqstp);
-		rqstp->rq_stime = ktime_get();
 		rqstp->rq_reserved = serv->sv_max_mesg;
 		atomic_add(rqstp->rq_reserved, &xprt->xpt_reserved);
 	} else
@@ -895,6 +894,7 @@ int svc_recv(struct svc_rqst *rqstp, long timeout)
 	err = -EAGAIN;
 	if (len <= 0)
 		goto out_release;
+
 	trace_svc_xdr_recvfrom(&rqstp->rq_arg);
 
 	clear_bit(XPT_OLD, &xprt->xpt_flags);
@@ -903,6 +903,7 @@ int svc_recv(struct svc_rqst *rqstp, long timeout)
 
 	if (serv->sv_stats)
 		serv->sv_stats->netcnt++;
+	rqstp->rq_stime = ktime_get();
 	return len;
 out_release:
 	rqstp->rq_res.len = 0;



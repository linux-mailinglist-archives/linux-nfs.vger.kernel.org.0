Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B74572C6F9
	for <lists+linux-nfs@lfdr.de>; Mon, 12 Jun 2023 16:10:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237342AbjFLOKR (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 12 Jun 2023 10:10:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237154AbjFLOKE (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 12 Jun 2023 10:10:04 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9375010C4;
        Mon, 12 Jun 2023 07:10:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2EBFE629A1;
        Mon, 12 Jun 2023 14:10:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48BC2C4339B;
        Mon, 12 Jun 2023 14:10:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686579002;
        bh=MiP1czKYRYivAwfgCIWihLzXQRc2PLrqklSil8z8u5E=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=puFId1sMd+4LMQ6PVCtR0+9WWZfLNlx0Hx89KKYiC4H4REQp/oggAbog7ko0wvG2m
         3IjR736zedRiZGG2OUo+Du/jh4rUbEFzcaf0uOxXt6zL+xpF5lYQh6QsUPKUuc4LBh
         S3pKid1WYR6ht1XvmDHnXTY6ZEc7ofKE+bdACmHc3FmWqmnjZQa8vLP6yTGm3uRJbd
         PzqoHDlt4tVt7MIS5f6HIYPu8fN8i9565OeUs+7jNBgGLpA08F/MGVehAB4UuZQVGs
         SXYaKPfJHShpAKC3jcVonvpTeXOKQAdqGOPQSiC2ZLQPF8gSL+1gryx4cdixgW0jFT
         T61qsVl8YnO5A==
Subject: [PATCH v2 1/5] SUNRPC: Revert cc93ce9529a6 ("svcrdma: Retain the page
 backing rq_res.head[0].iov_base")
From:   Chuck Lever <cel@kernel.org>
To:     linux-nfs@vger.kernel.org
Cc:     Chuck Lever <chuck.lever@oracle.com>, linux-rdma@vger.kernel.org,
        tom@talpey.com
Date:   Mon, 12 Jun 2023 10:10:01 -0400
Message-ID: <168657900128.5619.7769165526407423007.stgit@manet.1015granger.net>
In-Reply-To: <168657879115.5619.5573632864481586166.stgit@manet.1015granger.net>
References: <168657879115.5619.5573632864481586166.stgit@manet.1015granger.net>
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

Pre-requisite for releasing pages in the send completion handler.
Reverted by hand: patch -R would not apply cleanly.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 net/sunrpc/xprtrdma/svc_rdma_sendto.c |    5 -----
 1 file changed, 5 deletions(-)

diff --git a/net/sunrpc/xprtrdma/svc_rdma_sendto.c b/net/sunrpc/xprtrdma/svc_rdma_sendto.c
index a35d1e055b1a..8e7ccef74207 100644
--- a/net/sunrpc/xprtrdma/svc_rdma_sendto.c
+++ b/net/sunrpc/xprtrdma/svc_rdma_sendto.c
@@ -975,11 +975,6 @@ int svc_rdma_sendto(struct svc_rqst *rqstp)
 	ret = svc_rdma_send_reply_msg(rdma, sctxt, rctxt, rqstp);
 	if (ret < 0)
 		goto put_ctxt;
-
-	/* Prevent svc_xprt_release() from releasing the page backing
-	 * rq_res.head[0].iov_base. It's no longer being accessed by
-	 * the I/O device. */
-	rqstp->rq_respages++;
 	return 0;
 
 reply_chunk:



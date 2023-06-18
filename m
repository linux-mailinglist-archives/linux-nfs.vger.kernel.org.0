Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BEBDB7346EA
	for <lists+linux-nfs@lfdr.de>; Sun, 18 Jun 2023 18:04:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229491AbjFRQEF (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sun, 18 Jun 2023 12:04:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229488AbjFRQEF (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sun, 18 Jun 2023 12:04:05 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D2C5E54
        for <linux-nfs@vger.kernel.org>; Sun, 18 Jun 2023 09:04:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A560760E8A
        for <linux-nfs@vger.kernel.org>; Sun, 18 Jun 2023 16:04:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE9E4C433C0;
        Sun, 18 Jun 2023 16:04:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687104243;
        bh=lzfxGqdan5/SECjWFbZmNeKth42BVbmqY+8NJ9uCbxw=;
        h=Subject:From:To:Cc:Date:From;
        b=nZugZbwQwmX/jZp40Y2gT2eWg0ER8Jw7PHMuqQXlZ6FeHxyIJIYziKgHVWzoUmPZ6
         v1YN9UxAk/5c3RGQbRv/WvU/kbUgKqpVodUd7hqbDMbOKoFeLhrEVCCWiMTkot/kAL
         SNL+M2BT0qH2xokHUBAZp8IVWUf6lFT37NOPMvbFUoPdeQcJ8TwyQg5Y7UCYUoOHH7
         cxA3yvqioNXaP/88NbnG7guoohDMoJ68lyED+N80JM2v4U/r2sRM0VoCgRbpksLQdd
         uVgNtJc9Slqg8QVBj/TnqW/KoFlW/+fWQHvOTPCScxaWKKTKwGVYRThlevX5b5Xlfv
         1X0JO3NALtgIg==
Subject: [PATCH] svcrdma: Fix stale comment
From:   Chuck Lever <cel@kernel.org>
To:     linux-nfs@vger.kernel.org
Cc:     Chuck Lever <chuck.lever@oracle.com>
Date:   Sun, 18 Jun 2023 12:04:01 -0400
Message-ID: <168710424182.1590.8714219997914041582.stgit@manet.1015granger.net>
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

Commit 7d81ee8722d6 ("svcrdma: Single-stage RDMA Read") changed the
behavior of svc_rdma_recvfrom() but neglected to update the
documenting comment.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 net/sunrpc/xprtrdma/svc_rdma_recvfrom.c |    6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/net/sunrpc/xprtrdma/svc_rdma_recvfrom.c b/net/sunrpc/xprtrdma/svc_rdma_recvfrom.c
index a22fe7587fa6..aa839db7a34b 100644
--- a/net/sunrpc/xprtrdma/svc_rdma_recvfrom.c
+++ b/net/sunrpc/xprtrdma/svc_rdma_recvfrom.c
@@ -775,9 +775,6 @@ static bool svc_rdma_is_reverse_direction_reply(struct svc_xprt *xprt,
  *
  * The next ctxt is removed from the "receive" lists.
  *
- * - If the ctxt completes a Read, then finish assembling the Call
- *   message and return the number of bytes in the message.
- *
  * - If the ctxt completes a Receive, then construct the Call
  *   message from the contents of the Receive buffer.
  *
@@ -786,7 +783,8 @@ static bool svc_rdma_is_reverse_direction_reply(struct svc_xprt *xprt,
  *     in the message.
  *
  *   - If there are Read chunks in this message, post Read WRs to
- *     pull that payload and return 0.
+ *     pull that payload. When the Read WRs complete, build the
+ *     full message and return the number of bytes in it.
  */
 int svc_rdma_recvfrom(struct svc_rqst *rqstp)
 {



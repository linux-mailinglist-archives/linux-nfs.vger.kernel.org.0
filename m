Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 729EC724A5B
	for <lists+linux-nfs@lfdr.de>; Tue,  6 Jun 2023 19:34:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237818AbjFFRdv (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 6 Jun 2023 13:33:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238832AbjFFRdq (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 6 Jun 2023 13:33:46 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71C9112D;
        Tue,  6 Jun 2023 10:33:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0D27D63041;
        Tue,  6 Jun 2023 17:33:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24C8BC433EF;
        Tue,  6 Jun 2023 17:33:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686072824;
        bh=EKTSa+v5GbZS0K05Nc2fWCEetJaTwG5m3sEiNCmIIiY=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=Px71UESCyD75jMRhSX3GGlUIgeRDpdeGowk3hwCAOp9uGzRj7EhMEuFSeue5uYNHH
         yqny4Y4REbo89G6XUuGQNnj8qKH1bR6n1ylBF4CS2YT8mVscPc6WhpzpOhWnO4ydJt
         a4qHDO4pnrod0F4T+wXIGFvpIfSDT4cscMygBZ0L6cnsMVE/jMOOld6Slzad0B3SGU
         wdrhVuJfOMT4930ZufnsKYJz5H2kCOoddCUkyGPtCw46TN+HECmsc7yTGOGLpyiTco
         JLZ0vs4I5ATBYyrnjJf0ZQibgEQUutHOo0OTS9aE0zhllWOxZn1VXlCHLk4lEEt3s7
         BjQ2DWYHaV7Yw==
Subject: [PATCH v1 4/4] SUNRPC: Optimize page release in svc_rdma_sendto()
From:   Chuck Lever <cel@kernel.org>
To:     linux-nfs@vger.kernel.org
Cc:     Chuck Lever <chuck.lever@oracle.com>, linux-rdma@vger.kernel.org,
        tom@talpey.com
Date:   Tue, 06 Jun 2023 13:33:43 -0400
Message-ID: <168607282316.2076.15999420482159168604.stgit@manet.1015granger.net>
In-Reply-To: <168607259937.2076.15447551371235387735.stgit@manet.1015granger.net>
References: <168607259937.2076.15447551371235387735.stgit@manet.1015granger.net>
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

Now that we have bulk page allocation and release APIs, it's more
efficient to use those than it is for nfsd threads to wait for send
completions. Previous patches have eliminated the calls to
wait_for_completion() and complete(), in order to avoid scheduler
overhead.

Now release pages-under-I/O in the send completion handler using
the efficient bulk release API.

I've measured a 7% reduction in cumulative CPU utilization in
svc_rdma_sendto(), svc_rdma_wc_send(), and svc_xprt_release(). In
particular, using release_pages() instead of complete() cuts the
time per svc_rdma_wc_send() call by two-thirds. This helps improve
scalability because svc_rdma_wc_send() is single-threaded per
connection.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 net/sunrpc/xprtrdma/svc_rdma_sendto.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/sunrpc/xprtrdma/svc_rdma_sendto.c b/net/sunrpc/xprtrdma/svc_rdma_sendto.c
index 1ae4236d04a3..24228f3611e8 100644
--- a/net/sunrpc/xprtrdma/svc_rdma_sendto.c
+++ b/net/sunrpc/xprtrdma/svc_rdma_sendto.c
@@ -236,8 +236,8 @@ void svc_rdma_send_ctxt_put(struct svcxprt_rdma *rdma,
 	struct ib_device *device = rdma->sc_cm_id->device;
 	unsigned int i;
 
-	for (i = 0; i < ctxt->sc_page_count; ++i)
-		put_page(ctxt->sc_pages[i]);
+	if (ctxt->sc_page_count)
+		release_pages(ctxt->sc_pages, ctxt->sc_page_count);
 
 	/* The first SGE contains the transport header, which
 	 * remains mapped until @ctxt is destroyed.



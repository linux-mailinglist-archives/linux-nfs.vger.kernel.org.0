Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19F1172C701
	for <lists+linux-nfs@lfdr.de>; Mon, 12 Jun 2023 16:10:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237039AbjFLOKe (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 12 Jun 2023 10:10:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237044AbjFLOKc (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 12 Jun 2023 10:10:32 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5173410FF;
        Mon, 12 Jun 2023 07:10:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DAA62629A1;
        Mon, 12 Jun 2023 14:10:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F051AC433D2;
        Mon, 12 Jun 2023 14:10:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686579028;
        bh=X0+nBclNyvOxNp4D2C4RvpHhcmAZyrcuNkgUbCgAI30=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=sajRYHN37jBk3vRmdTN0BNS+U1wG6gAtrvC+Hjhsnu3XwNR6BB2CVMNS5ETPNvWXU
         jUrEpraGlv+rjNHeXBAtweVFw+KFDJdUKQ+HwiUMn4pGZPjt1DySg9QI/bvr1o3hpe
         7QeLBbcR0z/PfAMjmPeThXGx6FIT/1oAuIB0gMY82lKcHXCMDZy5SRG75rqa+m3PeL
         rr5bGWFunVmDGOhqup9AKUWu4lpL0wkoQ92uU2bnEB5dzfpUoELiLyvn0ONQ4OEHBC
         DCRUvf7OUL3AolTs+/R3fLJxKdG147ZZoDtPrFNl7H3Idv3xhnkVsFUjaE90cDAHa/
         itWTAwaXA0PPg==
Subject: [PATCH v2 5/5] SUNRPC: Optimize page release in svc_rdma_sendto()
From:   Chuck Lever <cel@kernel.org>
To:     linux-nfs@vger.kernel.org
Cc:     Chuck Lever <chuck.lever@oracle.com>, Tom Talpey <tom@talpey.com>,
        linux-rdma@vger.kernel.org, tom@talpey.com
Date:   Mon, 12 Jun 2023 10:10:27 -0400
Message-ID: <168657902707.5619.1368921836287929972.stgit@manet.1015granger.net>
In-Reply-To: <168657879115.5619.5573632864481586166.stgit@manet.1015granger.net>
References: <168657879115.5619.5573632864481586166.stgit@manet.1015granger.net>
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
Reviewed-by: Tom Talpey <tom@talpey.com>
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



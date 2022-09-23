Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BEDA45E7B4C
	for <lists+linux-nfs@lfdr.de>; Fri, 23 Sep 2022 15:06:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230113AbiIWNGM (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 23 Sep 2022 09:06:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231235AbiIWNGL (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 23 Sep 2022 09:06:11 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46A5613A393
        for <linux-nfs@vger.kernel.org>; Fri, 23 Sep 2022 06:06:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id F253CB82538
        for <linux-nfs@vger.kernel.org>; Fri, 23 Sep 2022 13:06:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98DD9C433D7;
        Fri, 23 Sep 2022 13:06:06 +0000 (UTC)
Subject: [PATCH v1 1/6] svcrdma: Clean up RPCRDMA_DEF_GFP
From:   Chuck Lever <chuck.lever@oracle.com>
To:     anna.schumaker@netapp.com
Cc:     linux-nfs@vger.kernel.org
Date:   Fri, 23 Sep 2022 09:06:05 -0400
Message-ID: <166393836562.1029362.1049888762792503024.stgit@morisot.1015granger.net>
In-Reply-To: <166393821144.1029362.9036806277307694311.stgit@morisot.1015granger.net>
References: <166393821144.1029362.9036806277307694311.stgit@morisot.1015granger.net>
User-Agent: StGit/1.5
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

xprt_rdma_bc_allocate() is now the only user of RPCRDMA_DEF_GFP.
Replace that macro with the raw flags.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 net/sunrpc/xprtrdma/svc_rdma_backchannel.c |    4 ++--
 net/sunrpc/xprtrdma/xprt_rdma.h            |    2 --
 2 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/net/sunrpc/xprtrdma/svc_rdma_backchannel.c b/net/sunrpc/xprtrdma/svc_rdma_backchannel.c
index 85c8cdda98b1..aa2227a7e552 100644
--- a/net/sunrpc/xprtrdma/svc_rdma_backchannel.c
+++ b/net/sunrpc/xprtrdma/svc_rdma_backchannel.c
@@ -119,12 +119,12 @@ xprt_rdma_bc_allocate(struct rpc_task *task)
 		return -EINVAL;
 	}
 
-	page = alloc_page(RPCRDMA_DEF_GFP);
+	page = alloc_page(GFP_NOIO | __GFP_NOWARN);
 	if (!page)
 		return -ENOMEM;
 	rqst->rq_buffer = page_address(page);
 
-	rqst->rq_rbuffer = kmalloc(rqst->rq_rcvsize, RPCRDMA_DEF_GFP);
+	rqst->rq_rbuffer = kmalloc(rqst->rq_rcvsize, GFP_NOIO | __GFP_NOWARN);
 	if (!rqst->rq_rbuffer) {
 		put_page(page);
 		return -ENOMEM;
diff --git a/net/sunrpc/xprtrdma/xprt_rdma.h b/net/sunrpc/xprtrdma/xprt_rdma.h
index c79f92eeda76..84b685c45555 100644
--- a/net/sunrpc/xprtrdma/xprt_rdma.h
+++ b/net/sunrpc/xprtrdma/xprt_rdma.h
@@ -149,8 +149,6 @@ static inline void *rdmab_data(const struct rpcrdma_regbuf *rb)
 	return rb->rg_data;
 }
 
-#define RPCRDMA_DEF_GFP		(GFP_NOIO | __GFP_NOWARN)
-
 /* To ensure a transport can always make forward progress,
  * the number of RDMA segments allowed in header chunk lists
  * is capped at 16. This prevents less-capable devices from



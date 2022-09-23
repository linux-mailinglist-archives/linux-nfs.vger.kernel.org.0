Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 251D65E7B51
	for <lists+linux-nfs@lfdr.de>; Fri, 23 Sep 2022 15:06:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230079AbiIWNGp (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 23 Sep 2022 09:06:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229833AbiIWNGo (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 23 Sep 2022 09:06:44 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C73013A38E
        for <linux-nfs@vger.kernel.org>; Fri, 23 Sep 2022 06:06:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 4B8ADCE1CA5
        for <linux-nfs@vger.kernel.org>; Fri, 23 Sep 2022 13:06:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B6EAC433D6;
        Fri, 23 Sep 2022 13:06:37 +0000 (UTC)
Subject: [PATCH v1 6/6] xprtrdma: Prevent memory allocations from driving a
 reclaim
From:   Chuck Lever <chuck.lever@oracle.com>
To:     anna.schumaker@netapp.com
Cc:     linux-nfs@vger.kernel.org
Date:   Fri, 23 Sep 2022 09:06:37 -0400
Message-ID: <166393839700.1029362.13683786521054731422.stgit@morisot.1015granger.net>
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

Many memory allocations that xprtrdma does can fail safely. Let's
use this fact to avoid some potential deadlocks: Replace GFP_KERNEL
with GFP flags that do not try hard to acquire memory.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 net/sunrpc/xprtrdma/verbs.c |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/net/sunrpc/xprtrdma/verbs.c b/net/sunrpc/xprtrdma/verbs.c
index 7ca58cb65e27..44b87e4274b4 100644
--- a/net/sunrpc/xprtrdma/verbs.c
+++ b/net/sunrpc/xprtrdma/verbs.c
@@ -811,7 +811,7 @@ struct rpcrdma_req *rpcrdma_req_create(struct rpcrdma_xprt *r_xprt,
 	struct rpcrdma_buffer *buffer = &r_xprt->rx_buf;
 	struct rpcrdma_req *req;
 
-	req = kzalloc(sizeof(*req), GFP_KERNEL);
+	req = kzalloc(sizeof(*req), XPRTRDMA_GFP_FLAGS);
 	if (req == NULL)
 		goto out1;
 
@@ -926,7 +926,7 @@ struct rpcrdma_rep *rpcrdma_rep_create(struct rpcrdma_xprt *r_xprt,
 	struct rpcrdma_buffer *buf = &r_xprt->rx_buf;
 	struct rpcrdma_rep *rep;
 
-	rep = kzalloc(sizeof(*rep), GFP_KERNEL);
+	rep = kzalloc(sizeof(*rep), XPRTRDMA_GFP_FLAGS);
 	if (rep == NULL)
 		goto out;
 
@@ -1236,10 +1236,10 @@ rpcrdma_regbuf_alloc(size_t size, enum dma_data_direction direction)
 {
 	struct rpcrdma_regbuf *rb;
 
-	rb = kmalloc(sizeof(*rb), GFP_KERNEL);
+	rb = kmalloc(sizeof(*rb), XPRTRDMA_GFP_FLAGS);
 	if (!rb)
 		return NULL;
-	rb->rg_data = kmalloc(size, GFP_KERNEL);
+	rb->rg_data = kmalloc(size, XPRTRDMA_GFP_FLAGS);
 	if (!rb->rg_data) {
 		kfree(rb);
 		return NULL;



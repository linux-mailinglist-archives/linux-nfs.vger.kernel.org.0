Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9B33702EA1
	for <lists+linux-nfs@lfdr.de>; Mon, 15 May 2023 15:47:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229765AbjEONrj (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 15 May 2023 09:47:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229590AbjEONri (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 15 May 2023 09:47:38 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3ACA31BC
        for <linux-nfs@vger.kernel.org>; Mon, 15 May 2023 06:47:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CC1E560AFA
        for <linux-nfs@vger.kernel.org>; Mon, 15 May 2023 13:47:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A180C433D2;
        Mon, 15 May 2023 13:47:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684158457;
        bh=xIWmzGB/IVAQl668I8IPnyK12ZDC226nIOQPFdJtCjY=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=iUkPol+p9ugpJDDWB0D2DxCljBylH64j+DDxKolqw8t7iPTimleiyu/I18ZROR9oF
         LbTiqHf7DOUTzjDNdJNMbafFf0UD0sunDAxa06XLj99S0ul9GxVz6JtnbSq4fnXx0S
         fSX+3sMM0DW0+PjXYknAMnCS3hG2n3Q6JI6Jol4Y8T0nqNI7WN7KajLk2kRPAN7/gq
         SIzHmuZuhryxRFIZOqRb7/uxbhO8NIogNyxns6z6GNeh58yrM8W0q7PGp/as+IZz9+
         LsW7ym3EMKKJOApAL3gtBMtyqAHFQCyxt2WxlAAarNdLxyVTZ9qWzCeeVhhm8YdA3S
         ghfUu2k19ARbw==
Subject: [PATCH 2/2] SUNRPC: Use __alloc_bulk_pages() in svc_init_buffer()
From:   Chuck Lever <cel@kernel.org>
To:     linux-nfs@vger.kernel.org
Cc:     Chuck Lever <chuck.lever@oracle.com>, david@fromorbit.com
Date:   Mon, 15 May 2023 09:47:36 -0400
Message-ID: <168415845608.42590.17685546576606273627.stgit@manet.1015granger.net>
In-Reply-To: <168415819504.42590.1664088679943725261.stgit@manet.1015granger.net>
References: <168415819504.42590.1664088679943725261.stgit@manet.1015granger.net>
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

Clean up: Use the bulk page allocator when filling a server thread's
buffer page array.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 net/sunrpc/svc.c |   23 +++++++----------------
 1 file changed, 7 insertions(+), 16 deletions(-)

diff --git a/net/sunrpc/svc.c b/net/sunrpc/svc.c
index 26367cf4c17a..0668242cbbb3 100644
--- a/net/sunrpc/svc.c
+++ b/net/sunrpc/svc.c
@@ -597,34 +597,25 @@ svc_destroy(struct kref *ref)
 }
 EXPORT_SYMBOL_GPL(svc_destroy);
 
-/*
- * Allocate an RPC server's buffer space.
- * We allocate pages and place them in rq_pages.
- */
-static int
+static bool
 svc_init_buffer(struct svc_rqst *rqstp, unsigned int size, int node)
 {
-	unsigned int pages, arghi;
+	unsigned long pages, ret;
 
 	/* bc_xprt uses fore channel allocated buffers */
 	if (svc_is_backchannel(rqstp))
-		return 1;
+		return true;
 
 	pages = size / PAGE_SIZE + 1; /* extra page as we hold both request and reply.
 				       * We assume one is at most one page
 				       */
-	arghi = 0;
 	WARN_ON_ONCE(pages > RPCSVC_MAXPAGES);
 	if (pages > RPCSVC_MAXPAGES)
 		pages = RPCSVC_MAXPAGES;
-	while (pages) {
-		struct page *p = alloc_pages_node(node, GFP_KERNEL, 0);
-		if (!p)
-			break;
-		rqstp->rq_pages[arghi++] = p;
-		pages--;
-	}
-	return pages == 0;
+
+	ret = alloc_pages_bulk_array_node(GFP_KERNEL, node, pages,
+					  rqstp->rq_pages);
+	return ret == pages;
 }
 
 /*



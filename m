Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63096702EA0
	for <lists+linux-nfs@lfdr.de>; Mon, 15 May 2023 15:47:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229648AbjEONrd (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 15 May 2023 09:47:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229590AbjEONrc (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 15 May 2023 09:47:32 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30FF01BC
        for <linux-nfs@vger.kernel.org>; Mon, 15 May 2023 06:47:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 75A65617E0
        for <linux-nfs@vger.kernel.org>; Mon, 15 May 2023 13:47:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A262CC433EF;
        Mon, 15 May 2023 13:47:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684158450;
        bh=xeeNd+NSQtaLxHkrEXVy4DCaQOa1N5fNzRKBtznGVGY=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=bNo204jsNKuJSmXzvbsWtRHvjBQ+Xw+bsA9R9Ry4W5vf2WcXAlVgd2ahQgXwnHBHb
         p6Xk/Te/JEYUJow11acLTrvnezPhJYQnUX8rjHDSxNMOKxtpn7MaKZaDOu1jGGBA05
         MZD7HsgnYOU+HuBoOASY7PNZ3ZtcHHk/dBs/4tlEXxnHRQYonb8LZfcWYzd00z8BEL
         KpwvwZzjQrSgFPr9Dh+A/tlHa6hhi4FgLAxcg7WfUZlU7lifDNUCybw0qCtSs2+SsT
         P7Rxan2hfY+lNFAPlrqNrLs8YY/wld7y6tQAQZDdCL97So9vft59zK6OkdFcbqvDPL
         bF8JBKOWleOJg==
Subject: [PATCH 1/2] SUNRPC: Resupply rq_pages from node-local memory
From:   Chuck Lever <cel@kernel.org>
To:     linux-nfs@vger.kernel.org
Cc:     Chuck Lever <chuck.lever@oracle.com>, david@fromorbit.com
Date:   Mon, 15 May 2023 09:47:29 -0400
Message-ID: <168415844956.42590.13195598260550904994.stgit@manet.1015granger.net>
In-Reply-To: <168415819504.42590.1664088679943725261.stgit@manet.1015granger.net>
References: <168415819504.42590.1664088679943725261.stgit@manet.1015granger.net>
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

svc_init_buffer() is careful to allocate the initial set of server
thread buffer pages from memory on the local NUMA node.
svc_alloc_arg() should also be that careful.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 net/sunrpc/svc_xprt.c |    5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/net/sunrpc/svc_xprt.c b/net/sunrpc/svc_xprt.c
index b3564afc53b7..dcb8b098c6d2 100644
--- a/net/sunrpc/svc_xprt.c
+++ b/net/sunrpc/svc_xprt.c
@@ -675,8 +675,9 @@ static int svc_alloc_arg(struct svc_rqst *rqstp)
 	}
 
 	for (filled = 0; filled < pages; filled = ret) {
-		ret = alloc_pages_bulk_array(GFP_KERNEL, pages,
-					     rqstp->rq_pages);
+		ret = alloc_pages_bulk_array_node(GFP_KERNEL,
+						  rqstp->rq_pool->sp_id,
+						  pages, rqstp->rq_pages);
 		if (ret > filled)
 			/* Made progress, don't sleep yet */
 			continue;



Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FA496E2DDF
	for <lists+linux-nfs@lfdr.de>; Sat, 15 Apr 2023 02:18:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229760AbjDOASG (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 14 Apr 2023 20:18:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbjDOASF (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 14 Apr 2023 20:18:05 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E997540FB
        for <linux-nfs@vger.kernel.org>; Fri, 14 Apr 2023 17:18:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 84BDC64632
        for <linux-nfs@vger.kernel.org>; Sat, 15 Apr 2023 00:18:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C42B6C4339E;
        Sat, 15 Apr 2023 00:18:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681517883;
        bh=RshTAt8N1txg6TF0maDP8tdDMDzPklBfrU/3+g+KeB8=;
        h=Subject:From:To:Date:In-Reply-To:References:From;
        b=jYSxYefrqfWu1kEKIKaipUqoEVNeS1w6Bew7vDGwis67wzwDtoDRpSup7gSR+lyhS
         3o24x6abUfaF6oJH9e9zRDr/EucGPFxwfFnj6xwyJFgbNDDpCU5Y8S1hnbiVph2FDu
         k/iVHF6mKtq4B2eJdfBOZJomYCHedALLd0xFWnwyF9Z7VTN9YR9iy2DyMTSojnT7Gm
         mluQbC38LoNAC+bN8BgR53VzYVoDCbVzD2Yh23wE11YLdcK4pwjN0P/5sbT5OnFaaM
         a25PnOzBTCKvasRQP1BOitBiHL0JfByCoxIfCSfI14P4xAkpNJ2WU4QRySiSZWYrkr
         xhcHRqTR5aaDQ==
Subject: [PATCH v1 2/4] SUNRPC: Convert svc_xprt_release() to the
 release_pages() API
From:   Chuck Lever <cel@kernel.org>
To:     linux-nfs@vger.kernel.org, linux-mm@kvack.org
Date:   Fri, 14 Apr 2023 20:18:02 -0400
Message-ID: <168151788284.1588.1198570306681230834.stgit@klimt.1015granger.net>
In-Reply-To: <168151777579.1588.7882383278745556830.stgit@klimt.1015granger.net>
References: <168151777579.1588.7882383278745556830.stgit@klimt.1015granger.net>
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

Instead of invoking put_page() one-at-a-time, pass the "response"
portion of rq_pages directly to release_pages() to reduce the number
of times each nfsd thread invokes a page allocator API.

Since svc_xprt_release() is not invoked while a client is waiting
for an RPC Reply, this is not expected to directly impact mean
request latencies on a lightly or moderately loaded server. However
as workload intensity increases, I expect somewhat better
scalability: the same number of server threads should be able to
handle more work.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 net/sunrpc/svc.c |   11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/net/sunrpc/svc.c b/net/sunrpc/svc.c
index 0fc70cc405b2..b982f802f2a0 100644
--- a/net/sunrpc/svc.c
+++ b/net/sunrpc/svc.c
@@ -878,13 +878,12 @@ EXPORT_SYMBOL_GPL(svc_rqst_replace_page);
  */
 void svc_rqst_release_pages(struct svc_rqst *rqstp)
 {
-	while (rqstp->rq_next_page != rqstp->rq_respages) {
-		struct page **pp = --rqstp->rq_next_page;
+	int i, count = rqstp->rq_next_page - rqstp->rq_respages;
 
-		if (*pp) {
-			put_page(*pp);
-			*pp = NULL;
-		}
+	if (count) {
+		release_pages(rqstp->rq_respages, count);
+		for (i = 0; i < count; i++)
+			rqstp->rq_respages[i] = NULL;
 	}
 }
 



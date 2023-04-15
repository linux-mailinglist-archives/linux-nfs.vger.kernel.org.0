Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2B406E2DE0
	for <lists+linux-nfs@lfdr.de>; Sat, 15 Apr 2023 02:18:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229822AbjDOASM (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 14 Apr 2023 20:18:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbjDOASL (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 14 Apr 2023 20:18:11 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3614E40FB
        for <linux-nfs@vger.kernel.org>; Fri, 14 Apr 2023 17:18:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C9E5A645C6
        for <linux-nfs@vger.kernel.org>; Sat, 15 Apr 2023 00:18:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18C2EC433D2;
        Sat, 15 Apr 2023 00:18:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681517890;
        bh=sTDSRZds3I5VoEZES7MzTU1WmuMqkd/9J180VGx4J2Y=;
        h=Subject:From:To:Date:In-Reply-To:References:From;
        b=AJ6awgWMSm3B3TfX59IIKRBUQuR6yBd3AA4wftjj7YJ+BvQMnJ0ebiRpshGEI4TnY
         RSUWdgYCu156/OJ1DjxyI11+KFeDIgxUPn2eC2s7bxqBHyla3bWJVJnkcRzWwy2zNc
         Ok0LfTV38XgpG/5m6JrR1SXv3emuat0CRFGdGkV2wxM/uIco8zBy+QIyuZBcN8HG2P
         3InJk3jD8BqyeUP0+Qjo+z5hSOksJ86V+31kERTdQw8brsCHHmSccZKdyHJcP0m94i
         DxpFmg+fAMe3tn4H5Knu9gj6TXpJco+RSV1CSlD/V7aSnGckIt083n3wSk3uo4Mv3f
         P70g1Rjnh911w==
Subject: [PATCH v1 3/4] SUNRPC: Convert svc_tcp_restore_pages() to the
 release_pages() API
From:   Chuck Lever <cel@kernel.org>
To:     linux-nfs@vger.kernel.org, linux-mm@kvack.org
Date:   Fri, 14 Apr 2023 20:18:09 -0400
Message-ID: <168151788914.1588.17896994938586012232.stgit@klimt.1015granger.net>
In-Reply-To: <168151777579.1588.7882383278745556830.stgit@klimt.1015granger.net>
References: <168151777579.1588.7882383278745556830.stgit@klimt.1015granger.net>
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

Instead of invoking put_page() one-at-a-time, pass the portion of
rq_pages to be released directly to release_pages() to reduce the
number of times each server thread invokes a page allocator API.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 net/sunrpc/svcsock.c |   12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/net/sunrpc/svcsock.c b/net/sunrpc/svcsock.c
index 302a14dd7882..44f72b558a1c 100644
--- a/net/sunrpc/svcsock.c
+++ b/net/sunrpc/svcsock.c
@@ -812,12 +812,12 @@ static size_t svc_tcp_restore_pages(struct svc_sock *svsk,
 	if (!len)
 		return 0;
 	npages = (len + PAGE_SIZE - 1) >> PAGE_SHIFT;
-	for (i = 0; i < npages; i++) {
-		if (rqstp->rq_pages[i] != NULL)
-			put_page(rqstp->rq_pages[i]);
-		BUG_ON(svsk->sk_pages[i] == NULL);
-		rqstp->rq_pages[i] = svsk->sk_pages[i];
-		svsk->sk_pages[i] = NULL;
+	if (npages) {
+		release_pages(rqstp->rq_pages, npages);
+		for (i = 0; i < npages; i++) {
+			rqstp->rq_pages[i] = svsk->sk_pages[i];
+			svsk->sk_pages[i] = NULL;
+		}
 	}
 	rqstp->rq_arg.head[0].iov_base = page_address(rqstp->rq_pages[0]);
 	return len;



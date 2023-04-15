Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F5706E2DE1
	for <lists+linux-nfs@lfdr.de>; Sat, 15 Apr 2023 02:18:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229841AbjDOASU (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 14 Apr 2023 20:18:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbjDOASS (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 14 Apr 2023 20:18:18 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C33340F8
        for <linux-nfs@vger.kernel.org>; Fri, 14 Apr 2023 17:18:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 18E1063856
        for <linux-nfs@vger.kernel.org>; Sat, 15 Apr 2023 00:18:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5AFF5C433EF;
        Sat, 15 Apr 2023 00:18:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681517896;
        bh=gwoDKthJAF1WHfbGuiCRuLpxNhrgjIi9oMkJ9fM63b0=;
        h=Subject:From:To:Date:In-Reply-To:References:From;
        b=q30o4mYFhbelsQ8SGE1YZKn7WuVdtBSkF/hM8jmtBXkBFL3iTHEyl/yOTRJojvgFL
         HtRjb1M2zuyVP9HdYzisBRXDr7Nudgn6kl8Sfkd6Wk5RiNo0Awfxy9tR01XCJdY+vN
         ztCNBwS4uIFBTzJzqXnDdlzU7Z+Pbk+zEUIZH+dmsfxnAMXQpeOg8MMG+e9ilf85Lq
         MK0S+fv153+w9uV3dASWZ/ekqK5L93DeDpcoPINWbGQmkp5OkG2brxO0k+oH/22SMe
         +XlBeo3arby3UnHwREkIDVlkbDJfJ+dOYot8uc+M3lMHXMV6OqcBkP5MVFIGHjG+1V
         EAIAoVm5G/SeQ==
Subject: [PATCH v1 4/4] SUNRPC: Be even lazier about releasing pages
From:   Chuck Lever <cel@kernel.org>
To:     linux-nfs@vger.kernel.org, linux-mm@kvack.org
Date:   Fri, 14 Apr 2023 20:18:15 -0400
Message-ID: <168151789543.1588.6591139655130358318.stgit@klimt.1015granger.net>
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

A single RPC transaction that touches only a couple of pages means
rq_pvec will not be even close to full in svc_xpt_release(). This is
a common case.

Instead, just leave the pages in rq_pvec until it is completely
full. This improves the efficiency of the batch release mechanism
on workloads that involve small RPC messages.

The rq_pvec is also fully emptied just before thread exit.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 net/sunrpc/svc.c      |    3 +++
 net/sunrpc/svc_xprt.c |    3 ---
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/net/sunrpc/svc.c b/net/sunrpc/svc.c
index b982f802f2a0..26367cf4c17a 100644
--- a/net/sunrpc/svc.c
+++ b/net/sunrpc/svc.c
@@ -649,6 +649,8 @@ svc_rqst_alloc(struct svc_serv *serv, struct svc_pool *pool, int node)
 	if (!rqstp)
 		return rqstp;
 
+	pagevec_init(&rqstp->rq_pvec);
+
 	__set_bit(RQ_BUSY, &rqstp->rq_flags);
 	rqstp->rq_server = serv;
 	rqstp->rq_pool = pool;
@@ -894,6 +896,7 @@ void svc_rqst_release_pages(struct svc_rqst *rqstp)
 void
 svc_rqst_free(struct svc_rqst *rqstp)
 {
+	pagevec_release(&rqstp->rq_pvec);
 	svc_release_buffer(rqstp);
 	if (rqstp->rq_scratch_page)
 		put_page(rqstp->rq_scratch_page);
diff --git a/net/sunrpc/svc_xprt.c b/net/sunrpc/svc_xprt.c
index 533e08c4f319..e3952b690f54 100644
--- a/net/sunrpc/svc_xprt.c
+++ b/net/sunrpc/svc_xprt.c
@@ -541,7 +541,6 @@ static void svc_xprt_release(struct svc_rqst *rqstp)
 	kfree(rqstp->rq_deferred);
 	rqstp->rq_deferred = NULL;
 
-	pagevec_release(&rqstp->rq_pvec);
 	svc_rqst_release_pages(rqstp);
 	rqstp->rq_res.page_len = 0;
 	rqstp->rq_res.page_base = 0;
@@ -667,8 +666,6 @@ static int svc_alloc_arg(struct svc_rqst *rqstp)
 	struct xdr_buf *arg = &rqstp->rq_arg;
 	unsigned long pages, filled, ret;
 
-	pagevec_init(&rqstp->rq_pvec);
-
 	pages = (serv->sv_max_mesg + 2 * PAGE_SIZE) >> PAGE_SHIFT;
 	if (pages > RPCSVC_MAXPAGES) {
 		pr_warn_once("svc: warning: pages=%lu > RPCSVC_MAXPAGES=%lu\n",



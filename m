Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C116872C700
	for <lists+linux-nfs@lfdr.de>; Mon, 12 Jun 2023 16:10:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236861AbjFLOK1 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 12 Jun 2023 10:10:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236919AbjFLOK0 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 12 Jun 2023 10:10:26 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19CF910FE;
        Mon, 12 Jun 2023 07:10:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7767C629A1;
        Mon, 12 Jun 2023 14:10:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9062AC433EF;
        Mon, 12 Jun 2023 14:10:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686579021;
        bh=HDTW0GgJCQOTBs0V+gahHpF2WL4jQpJxgOJw45fgDwE=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=fRuNnYozSLdVPorIE0Yi9C4RpKlo70TALnB+QA8bk4vTJ8sM8OT1OFq5iitkxWOoc
         hHmVky/P8rSeUHgmPqnM9oTSy9O9Nwu0zrjNYjjRQeYzCNN9DRPxsqBSvgjojvnRYd
         V3KTUBR7/ojOXK5+DO/JNxs4VRZiMZSdck4bZG0pSf7Pr/YflpU6eKCl2RPTytZZSQ
         nj9FDYbYlmFWkibNi90yQO0+9MI/tq32V86r1mNarq6fOzpsoQAOSWKB4jhz4xcG3x
         +urlOpzc5JbZHky2l9QtXQGMUYQzyGEKrBSE/mglZIj7LXO35rwUookNIfICHdRNwa
         Z7+uHHAx2MZGQ==
Subject: [PATCH v2 4/5] svcrdma: Prevent page release when nothing was
 received
From:   Chuck Lever <cel@kernel.org>
To:     linux-nfs@vger.kernel.org
Cc:     Chuck Lever <chuck.lever@oracle.com>, linux-rdma@vger.kernel.org,
        tom@talpey.com
Date:   Mon, 12 Jun 2023 10:10:20 -0400
Message-ID: <168657902069.5619.1670908567999246810.stgit@manet.1015granger.net>
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

I noticed that svc_rqst_release_pages() was still unnecessarily
releasing a page when svc_rdma_recvfrom() returns zero.

Fixes: a53d5cb0646a ("svcrdma: Avoid releasing a page in svc_xprt_release()")
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 net/sunrpc/xprtrdma/svc_rdma_recvfrom.c |   12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/net/sunrpc/xprtrdma/svc_rdma_recvfrom.c b/net/sunrpc/xprtrdma/svc_rdma_recvfrom.c
index 46a719ba4917..5bd16d19b16e 100644
--- a/net/sunrpc/xprtrdma/svc_rdma_recvfrom.c
+++ b/net/sunrpc/xprtrdma/svc_rdma_recvfrom.c
@@ -804,6 +804,12 @@ int svc_rdma_recvfrom(struct svc_rqst *rqstp)
 		clear_bit(XPT_DATA, &xprt->xpt_flags);
 	spin_unlock(&rdma_xprt->sc_rq_dto_lock);
 
+	/* Prevent svc_xprt_release() from releasing pages in rq_pages
+	 * when returning 0 or an error.
+	 */
+	rqstp->rq_respages = rqstp->rq_pages;
+	rqstp->rq_next_page = rqstp->rq_respages;
+
 	/* Unblock the transport for the next receive */
 	svc_xprt_received(xprt);
 	if (!ctxt)
@@ -815,12 +821,6 @@ int svc_rdma_recvfrom(struct svc_rqst *rqstp)
 				   DMA_FROM_DEVICE);
 	svc_rdma_build_arg_xdr(rqstp, ctxt);
 
-	/* Prevent svc_xprt_release from releasing pages in rq_pages
-	 * if we return 0 or an error.
-	 */
-	rqstp->rq_respages = rqstp->rq_pages;
-	rqstp->rq_next_page = rqstp->rq_respages;
-
 	ret = svc_rdma_xdr_decode_req(&rqstp->rq_arg, ctxt);
 	if (ret < 0)
 		goto out_err;



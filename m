Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26EEB72C722
	for <lists+linux-nfs@lfdr.de>; Mon, 12 Jun 2023 16:13:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237222AbjFLONu (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 12 Jun 2023 10:13:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237238AbjFLONt (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 12 Jun 2023 10:13:49 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAB33F0
        for <linux-nfs@vger.kernel.org>; Mon, 12 Jun 2023 07:13:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4068A60D2B
        for <linux-nfs@vger.kernel.org>; Mon, 12 Jun 2023 14:13:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C783C433EF;
        Mon, 12 Jun 2023 14:13:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686579226;
        bh=KbE6zoLfCQAGiG0WVqH141hCVf5ursX0NM7hQsxSJxI=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=buv70rQB+IyufdHwVC04Lq6jkBs9sKBA56veituAtTaF7pLK9BPKSYH8lFMszRcLh
         pA0DKMKLg6foLOr8pecy+3MyZoeNcD21TaM+ov/2pECB248Kvlt544Uvf39JEpxFG6
         6DlddxBI2yfhODuH5dy7AeGYClEc6n7iT7ss1SY9j0XzCyVhxXbfRI1CX6YRbaaX7z
         MfN4v4rvXITRFPDS/OKCNjbE8h0PDsoZpxqPy0XWLKfL5YTLSQEHL131GK8jGZgndI
         EFeygu4cbA3V6Our9/XAatDwB3ZjIQpbxjBygkCyfMxxQ2XDuUjf4U3GdiffE9ODGI
         HB39PvueuW97g==
Subject: [PATCH v1 3/7] svcrdma: Convert "might sleep" comment into a code
 annotation
From:   Chuck Lever <cel@kernel.org>
To:     linux-nfs@vger.kernel.org
Cc:     Chuck Lever <chuck.lever@oracle.com>
Date:   Mon, 12 Jun 2023 10:13:45 -0400
Message-ID: <168657922560.5674.338395614409259561.stgit@manet.1015granger.net>
In-Reply-To: <168657912781.5674.12501431304770900992.stgit@manet.1015granger.net>
References: <168657912781.5674.12501431304770900992.stgit@manet.1015granger.net>
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

Try to catch incorrect calling contexts mechanically rather than by
code review.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 net/sunrpc/xprtrdma/svc_rdma_rw.c     |    5 +++--
 net/sunrpc/xprtrdma/svc_rdma_sendto.c |    2 ++
 2 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/net/sunrpc/xprtrdma/svc_rdma_rw.c b/net/sunrpc/xprtrdma/svc_rdma_rw.c
index 068c365e7812..59ea87b5f458 100644
--- a/net/sunrpc/xprtrdma/svc_rdma_rw.c
+++ b/net/sunrpc/xprtrdma/svc_rdma_rw.c
@@ -353,8 +353,7 @@ static void svc_rdma_wc_read_done(struct ib_cq *cq, struct ib_wc *wc)
 	return;
 }
 
-/* This function sleeps when the transport's Send Queue is congested.
- *
+/*
  * Assumptions:
  * - If ib_post_send() succeeds, only one completion is expected,
  *   even if one or more WRs are flushed. This is true when posting
@@ -369,6 +368,8 @@ static int svc_rdma_post_chunk_ctxt(struct svc_rdma_chunk_ctxt *cc)
 	struct ib_cqe *cqe;
 	int ret;
 
+	might_sleep();
+
 	if (cc->cc_sqecount > rdma->sc_sq_depth)
 		return -EINVAL;
 
diff --git a/net/sunrpc/xprtrdma/svc_rdma_sendto.c b/net/sunrpc/xprtrdma/svc_rdma_sendto.c
index 24228f3611e8..c6644cca52c5 100644
--- a/net/sunrpc/xprtrdma/svc_rdma_sendto.c
+++ b/net/sunrpc/xprtrdma/svc_rdma_sendto.c
@@ -315,6 +315,8 @@ int svc_rdma_send(struct svcxprt_rdma *rdma, struct svc_rdma_send_ctxt *ctxt)
 	struct ib_send_wr *wr = &ctxt->sc_send_wr;
 	int ret;
 
+	might_sleep();
+
 	/* Sync the transport header buffer */
 	ib_dma_sync_single_for_device(rdma->sc_pd->device,
 				      wr->sg_list[0].addr,



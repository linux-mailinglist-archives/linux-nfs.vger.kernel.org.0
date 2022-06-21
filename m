Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8CA31553429
	for <lists+linux-nfs@lfdr.de>; Tue, 21 Jun 2022 16:06:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350516AbiFUOGV (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 21 Jun 2022 10:06:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350518AbiFUOGU (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 21 Jun 2022 10:06:20 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1761186E2
        for <linux-nfs@vger.kernel.org>; Tue, 21 Jun 2022 07:06:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6A1A761632
        for <linux-nfs@vger.kernel.org>; Tue, 21 Jun 2022 14:06:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6466C3411C
        for <linux-nfs@vger.kernel.org>; Tue, 21 Jun 2022 14:06:17 +0000 (UTC)
Subject: [PATCH 1/2] SUNRPC: Expand the svc_alloc_arg_err tracepoint
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org
Date:   Tue, 21 Jun 2022 10:06:16 -0400
Message-ID: <165582037674.1716.6493233261080715169.stgit@klimt.1015granger.net>
In-Reply-To: <165582017204.1716.2642742597692008742.stgit@klimt.1015granger.net>
References: <165582017204.1716.2642742597692008742.stgit@klimt.1015granger.net>
User-Agent: StGit/1.5.dev3+g9561319
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Record not only the number of pages requested, but the number of
pages that were actually allocated, to get an measure of progress
(or lack thereof).

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 include/trace/events/sunrpc.h |   14 +++++++++-----
 net/sunrpc/svc_xprt.c         |    2 +-
 2 files changed, 10 insertions(+), 6 deletions(-)

diff --git a/include/trace/events/sunrpc.h b/include/trace/events/sunrpc.h
index b61d9c90fa26..5c48be033cc7 100644
--- a/include/trace/events/sunrpc.h
+++ b/include/trace/events/sunrpc.h
@@ -1989,20 +1989,24 @@ TRACE_EVENT(svc_wake_up,
 
 TRACE_EVENT(svc_alloc_arg_err,
 	TP_PROTO(
-		unsigned int pages
+		unsigned int requested,
+		unsigned int allocated
 	),
 
-	TP_ARGS(pages),
+	TP_ARGS(requested, allocated),
 
 	TP_STRUCT__entry(
-		__field(unsigned int, pages)
+		__field(unsigned int, requested)
+		__field(unsigned int, allocated)
 	),
 
 	TP_fast_assign(
-		__entry->pages = pages;
+		__entry->requested = requested;
+		__entry->allocated = allocated;
 	),
 
-	TP_printk("pages=%u", __entry->pages)
+	TP_printk("requested=%u allocated=%u",
+		__entry->requested, __entry->allocated)
 );
 
 DECLARE_EVENT_CLASS(svc_deferred_event,
diff --git a/net/sunrpc/svc_xprt.c b/net/sunrpc/svc_xprt.c
index 2c4dd7ca95b0..2106003645a7 100644
--- a/net/sunrpc/svc_xprt.c
+++ b/net/sunrpc/svc_xprt.c
@@ -691,7 +691,7 @@ static int svc_alloc_arg(struct svc_rqst *rqstp)
 			set_current_state(TASK_RUNNING);
 			return -EINTR;
 		}
-		trace_svc_alloc_arg_err(pages);
+		trace_svc_alloc_arg_err(pages, ret);
 		memalloc_retry_wait(GFP_KERNEL);
 	}
 	rqstp->rq_page_end = &rqstp->rq_pages[pages];



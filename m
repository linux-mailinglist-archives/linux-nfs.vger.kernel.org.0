Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D2D34F866F
	for <lists+linux-nfs@lfdr.de>; Thu,  7 Apr 2022 19:43:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346528AbiDGRpi (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 7 Apr 2022 13:45:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346519AbiDGRph (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 7 Apr 2022 13:45:37 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D4E122C1E9
        for <linux-nfs@vger.kernel.org>; Thu,  7 Apr 2022 10:43:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E7D77B82795
        for <linux-nfs@vger.kernel.org>; Thu,  7 Apr 2022 17:43:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38B4EC385A4;
        Thu,  7 Apr 2022 17:43:30 +0000 (UTC)
Subject: [PATCH v3 2/2] SUNRPC: Fix the svc_deferred_event trace class
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org
Cc:     rostedt@goodmis.org
Date:   Thu, 07 Apr 2022 13:43:29 -0400
Message-ID: <164935340926.76813.4345516465286175319.stgit@klimt.1015granger.net>
In-Reply-To: <164935330144.76813.17862521591948764594.stgit@klimt.1015granger.net>
References: <164935330144.76813.17862521591948764594.stgit@klimt.1015granger.net>
User-Agent: StGit/1.5.dev1+g8516920
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

Fix a NULL deref crash that occurs when an svc_rqst is deferred
while the sunrpc tracing subsystem is enabled. svc_revisit() sets
dr->xprt to NULL, so it can't be relied upon in the tracepoint to
provide the remote's address.

Unfortunately we can't revert the "svc_deferred_class" hunk in
commit ece200ddd54b ("sunrpc: Save remote presentation address in
svc_xprt for trace events") because there is now a specific check
of event format specifiers for unsafe dereferences. The warning
that check emits is:

  event svc_defer_recv has unsafe dereference of argument 1

A "%pISpc" format specifier with a "struct sockaddr *" is indeed
flagged by this check.

Instead, take the brute-force approach used by the svcrdma_qp_error
tracepoint. Convert the dr::addr field into a presentation address
in the TP_fast_assign() arm of the trace event, and store that as
a string. This fix can be backported to -stable kernels.

In the meantime, commit c6ced22997ad ("tracing: Update print fmt
check to handle new __get_sockaddr() macro") is now in v5.18, so
this wonky fix can be replaced with __sockaddr() and friends
properly during the v5.19 merge window.

Fixes: ece200ddd54b ("sunrpc: Save remote presentation address in svc_xprt for trace events")
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 include/trace/events/sunrpc.h |    7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/include/trace/events/sunrpc.h b/include/trace/events/sunrpc.h
index ab8ae1f6ba84..4eb706fa5825 100644
--- a/include/trace/events/sunrpc.h
+++ b/include/trace/events/sunrpc.h
@@ -2017,17 +2017,18 @@ DECLARE_EVENT_CLASS(svc_deferred_event,
 	TP_STRUCT__entry(
 		__field(const void *, dr)
 		__field(u32, xid)
-		__string(addr, dr->xprt->xpt_remotebuf)
+		__array(__u8, addr, INET6_ADDRSTRLEN + 10)
 	),
 
 	TP_fast_assign(
 		__entry->dr = dr;
 		__entry->xid = be32_to_cpu(*(__be32 *)(dr->args +
 						       (dr->xprt_hlen>>2)));
-		__assign_str(addr, dr->xprt->xpt_remotebuf);
+		snprintf(__entry->addr, sizeof(__entry->addr) - 1,
+			 "%pISpc", (struct sockaddr *)&dr->addr);
 	),
 
-	TP_printk("addr=%s dr=%p xid=0x%08x", __get_str(addr), __entry->dr,
+	TP_printk("addr=%s dr=%p xid=0x%08x", __entry->addr, __entry->dr,
 		__entry->xid)
 );
 



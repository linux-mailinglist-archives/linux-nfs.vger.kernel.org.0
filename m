Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4EB9235AFB3
	for <lists+linux-nfs@lfdr.de>; Sat, 10 Apr 2021 20:52:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234948AbhDJSwQ (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sat, 10 Apr 2021 14:52:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:41766 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234903AbhDJSwQ (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Sat, 10 Apr 2021 14:52:16 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 403536113A;
        Sat, 10 Apr 2021 18:52:01 +0000 (UTC)
Subject: [PATCH v1 2/4] xprtrdma: Add an rpcrdma_mr_completion_class
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org, linux-rdma@vger.kernel.org
Date:   Sat, 10 Apr 2021 14:52:00 -0400
Message-ID: <161808072053.21449.6217607386159505930.stgit@manet.1015granger.net>
In-Reply-To: <161808067409.21449.15778528150201556096.stgit@manet.1015granger.net>
References: <161808067409.21449.15778528150201556096.stgit@manet.1015granger.net>
User-Agent: StGit/0.23-29-ga622f1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

I found it confusing that the MR_EVENT class displays the mr.id but
the associated COMPLETION_EVENT class displays a cid (that happens
to contain the mr.id!). To make it a little easier on humans who
have to read and interpret these events, create an MR_COMPLETION
class that displays the mr.id in the same way as the MR_EVENT class.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 include/trace/events/rpcrdma.h |   48 +++++++++++++++++++++++++++++++++++++---
 1 file changed, 44 insertions(+), 4 deletions(-)

diff --git a/include/trace/events/rpcrdma.h b/include/trace/events/rpcrdma.h
index 9462326b3535..3e6e4c69b533 100644
--- a/include/trace/events/rpcrdma.h
+++ b/include/trace/events/rpcrdma.h
@@ -60,6 +60,46 @@ DECLARE_EVENT_CLASS(rpcrdma_completion_class,
 				),					\
 				TP_ARGS(wc, cid))
 
+DECLARE_EVENT_CLASS(rpcrdma_mr_completion_class,
+	TP_PROTO(
+		const struct ib_wc *wc,
+		const struct rpc_rdma_cid *cid
+	),
+
+	TP_ARGS(wc, cid),
+
+	TP_STRUCT__entry(
+		__field(u32, cq_id)
+		__field(int, completion_id)
+		__field(unsigned long, status)
+		__field(unsigned int, vendor_err)
+	),
+
+	TP_fast_assign(
+		__entry->cq_id = cid->ci_queue_id;
+		__entry->completion_id = cid->ci_completion_id;
+		__entry->status = wc->status;
+		if (wc->status)
+			__entry->vendor_err = wc->vendor_err;
+		else
+			__entry->vendor_err = 0;
+	),
+
+	TP_printk("cq.id=%u mr.id=%d status=%s (%lu/0x%x)",
+		__entry->cq_id, __entry->completion_id,
+		rdma_show_wc_status(__entry->status),
+		__entry->status, __entry->vendor_err
+	)
+);
+
+#define DEFINE_MR_COMPLETION_EVENT(name)				\
+		DEFINE_EVENT(rpcrdma_mr_completion_class, name,		\
+				TP_PROTO(				\
+					const struct ib_wc *wc,		\
+					const struct rpc_rdma_cid *cid	\
+				),					\
+				TP_ARGS(wc, cid))
+
 DECLARE_EVENT_CLASS(rpcrdma_receive_completion_class,
 	TP_PROTO(
 		const struct ib_wc *wc,
@@ -886,10 +926,10 @@ TRACE_EVENT(xprtrdma_post_linv_err,
 DEFINE_RECEIVE_COMPLETION_EVENT(xprtrdma_wc_receive);
 
 DEFINE_COMPLETION_EVENT(xprtrdma_wc_send);
-DEFINE_COMPLETION_EVENT(xprtrdma_wc_fastreg);
-DEFINE_COMPLETION_EVENT(xprtrdma_wc_li);
-DEFINE_COMPLETION_EVENT(xprtrdma_wc_li_wake);
-DEFINE_COMPLETION_EVENT(xprtrdma_wc_li_done);
+DEFINE_MR_COMPLETION_EVENT(xprtrdma_wc_fastreg);
+DEFINE_MR_COMPLETION_EVENT(xprtrdma_wc_li);
+DEFINE_MR_COMPLETION_EVENT(xprtrdma_wc_li_wake);
+DEFINE_MR_COMPLETION_EVENT(xprtrdma_wc_li_done);
 
 TRACE_EVENT(xprtrdma_frwr_alloc,
 	TP_PROTO(



Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8484030FC95
	for <lists+linux-nfs@lfdr.de>; Thu,  4 Feb 2021 20:27:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237089AbhBDRHm (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 4 Feb 2021 12:07:42 -0500
Received: from mail.kernel.org ([198.145.29.99]:54496 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238204AbhBDRAN (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Thu, 4 Feb 2021 12:00:13 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 054E064F3C;
        Thu,  4 Feb 2021 16:59:32 +0000 (UTC)
Subject: [PATCH v4 6/6] rpcrdma: Capture bytes received in Receive completion
 tracepoints
From:   Chuck Lever <chuck.lever@oracle.com>
To:     anna.schumaker@netapp.com
Cc:     linux-nfs@vger.kernel.org, linux-rdma@vger.kernel.org
Date:   Thu, 04 Feb 2021 11:59:32 -0500
Message-ID: <161245797223.737759.5121223683890760045.stgit@manet.1015granger.net>
In-Reply-To: <161245786674.737759.8361822825753388908.stgit@manet.1015granger.net>
References: <161245786674.737759.8361822825753388908.stgit@manet.1015granger.net>
User-Agent: StGit/0.23-29-ga622f1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Make it easier to spot messages of an unusual size.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
Acked-by: Tom Talpey <tom@talpey.com>
---
 include/trace/events/rpcrdma.h |   50 ++++++++++++++++++++++++++++++++++++++--
 1 file changed, 48 insertions(+), 2 deletions(-)

diff --git a/include/trace/events/rpcrdma.h b/include/trace/events/rpcrdma.h
index 76e85e16854b..c838e7ac1c2d 100644
--- a/include/trace/events/rpcrdma.h
+++ b/include/trace/events/rpcrdma.h
@@ -60,6 +60,51 @@ DECLARE_EVENT_CLASS(rpcrdma_completion_class,
 				),					\
 				TP_ARGS(wc, cid))
 
+DECLARE_EVENT_CLASS(rpcrdma_receive_completion_class,
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
+		__field(u32, received)
+		__field(unsigned long, status)
+		__field(unsigned int, vendor_err)
+	),
+
+	TP_fast_assign(
+		__entry->cq_id = cid->ci_queue_id;
+		__entry->completion_id = cid->ci_completion_id;
+		__entry->status = wc->status;
+		if (wc->status) {
+			__entry->received = 0;
+			__entry->vendor_err = wc->vendor_err;
+		} else {
+			__entry->received = wc->byte_len;
+			__entry->vendor_err = 0;
+		}
+	),
+
+	TP_printk("cq.id=%u cid=%d status=%s (%lu/0x%x) received=%u",
+		__entry->cq_id, __entry->completion_id,
+		rdma_show_wc_status(__entry->status),
+		__entry->status, __entry->vendor_err,
+		__entry->received
+	)
+);
+
+#define DEFINE_RECEIVE_COMPLETION_EVENT(name)				\
+		DEFINE_EVENT(rpcrdma_receive_completion_class, name,	\
+				TP_PROTO(				\
+					const struct ib_wc *wc,		\
+					const struct rpc_rdma_cid *cid	\
+				),					\
+				TP_ARGS(wc, cid))
+
 DECLARE_EVENT_CLASS(xprtrdma_reply_class,
 	TP_PROTO(
 		const struct rpcrdma_rep *rep
@@ -838,7 +883,8 @@ TRACE_EVENT(xprtrdma_post_linv_err,
  ** Completion events
  **/
 
-DEFINE_COMPLETION_EVENT(xprtrdma_wc_receive);
+DEFINE_RECEIVE_COMPLETION_EVENT(xprtrdma_wc_receive);
+
 DEFINE_COMPLETION_EVENT(xprtrdma_wc_send);
 DEFINE_COMPLETION_EVENT(xprtrdma_wc_fastreg);
 DEFINE_COMPLETION_EVENT(xprtrdma_wc_li);
@@ -1790,7 +1836,7 @@ TRACE_EVENT(svcrdma_post_recv,
 	)
 );
 
-DEFINE_COMPLETION_EVENT(svcrdma_wc_receive);
+DEFINE_RECEIVE_COMPLETION_EVENT(svcrdma_wc_receive);
 
 TRACE_EVENT(svcrdma_rq_post_err,
 	TP_PROTO(



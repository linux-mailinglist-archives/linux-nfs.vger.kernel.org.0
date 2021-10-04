Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA47F42112D
	for <lists+linux-nfs@lfdr.de>; Mon,  4 Oct 2021 16:16:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233188AbhJDOS1 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 4 Oct 2021 10:18:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:47580 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233671AbhJDOSQ (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Mon, 4 Oct 2021 10:18:16 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 310F5611C1;
        Mon,  4 Oct 2021 14:16:27 +0000 (UTC)
Subject: [PATCH 4/5] SUNRPC: Add trace event when alloc_pages_bulk() makes no
 progress
From:   Chuck Lever <chuck.lever@oracle.com>
To:     bfields@fieldses.org
Cc:     linux-nfs@vger.kernel.org, linux-rdma@vger.kernel.org
Date:   Mon, 04 Oct 2021 10:16:26 -0400
Message-ID: <163335698647.3921.16691202918962654108.stgit@klimt.1015granger.net>
In-Reply-To: <163335690747.3921.13072315880207206379.stgit@klimt.1015granger.net>
References: <163335690747.3921.13072315880207206379.stgit@klimt.1015granger.net>
User-Agent: StGit/1.3
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

This is an operational low memory situation that needs to be
flagged. The new tracepoint records a timestamp and the nfsd thread
that failed to allocate pages.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 include/trace/events/sunrpc.h |   18 ++++++++++++++++++
 net/sunrpc/svc_xprt.c         |    1 +
 2 files changed, 19 insertions(+)

diff --git a/include/trace/events/sunrpc.h b/include/trace/events/sunrpc.h
index 2d04eb96d418..fb016308c185 100644
--- a/include/trace/events/sunrpc.h
+++ b/include/trace/events/sunrpc.h
@@ -1859,6 +1859,24 @@ TRACE_EVENT(svc_wake_up,
 	TP_printk("pid=%d", __entry->pid)
 );
 
+TRACE_EVENT(svc_alloc_arg_err,
+	TP_PROTO(
+		unsigned int pages
+	),
+
+	TP_ARGS(pages),
+
+	TP_STRUCT__entry(
+		__field(unsigned int, pages)
+	),
+
+	TP_fast_assign(
+		__entry->pages = pages;
+	),
+
+	TP_printk("pages=%u", __entry->pages)
+);
+
 TRACE_EVENT(svc_handle_xprt,
 	TP_PROTO(struct svc_xprt *xprt, int len),
 
diff --git a/net/sunrpc/svc_xprt.c b/net/sunrpc/svc_xprt.c
index 6316bd2b8f37..1e99ba1b9d72 100644
--- a/net/sunrpc/svc_xprt.c
+++ b/net/sunrpc/svc_xprt.c
@@ -687,6 +687,7 @@ static int svc_alloc_arg(struct svc_rqst *rqstp)
 			set_current_state(TASK_RUNNING);
 			return -EINTR;
 		}
+		trace_svc_alloc_arg_err(pages);
 		schedule_timeout(msecs_to_jiffies(500));
 	}
 	rqstp->rq_page_end = &rqstp->rq_pages[pages];



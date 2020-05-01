Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7958C1C1BC3
	for <lists+linux-nfs@lfdr.de>; Fri,  1 May 2020 19:33:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730130AbgEARdq (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 1 May 2020 13:33:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729744AbgEARdp (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 1 May 2020 13:33:45 -0400
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com [IPv6:2607:f8b0:4864:20::742])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A47CC08E859;
        Fri,  1 May 2020 10:33:45 -0700 (PDT)
Received: by mail-qk1-x742.google.com with SMTP id t3so9949456qkg.1;
        Fri, 01 May 2020 10:33:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=ZIrrhhCkTF8/0jA7qBhHVLSGfrWSKZiFnqX6JC1kv/k=;
        b=r+hcyevnr2KJ/MCTEhpA5q4b/zsLQvou4u9nzR1ay8qFbI5meskRV+wAWsY4m6YJ/U
         N2gJT77YCAUF5dwPKg9f/JQzOJ1ruOMw8UhDz00L23UOueNZyfswdo/HUmfxSFfC6wPC
         Bg61UgqtxhuoiCjS1pw0c9nASsUnATQNP4X4ua067ie3RJwEIhLXqDOF2uDWYf0xstuT
         VwX5Img2V7lh5hvD8UdH5xKa4uTCgQ+ypEW7irjGnmyhkSRC1iTvrunOFpRdrk6qi1Tr
         gGY6+2MvLLy/MCwjLEpVQi+GiFQZd8bNMLb2hZcjx1eR0Og16E9ZJm0V8cH5ubz5hsnx
         Hm+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:date:message-id
         :in-reply-to:references:user-agent:mime-version
         :content-transfer-encoding;
        bh=ZIrrhhCkTF8/0jA7qBhHVLSGfrWSKZiFnqX6JC1kv/k=;
        b=R/SQnOwI5u62/t+6qTh9SJEOXxBc+tqOWbyThScDRPMn+yBNpzRT4D25XQZyDebCvt
         jEMRiuEEu/VCPyKOhVaM9L4OiRuozsGzBHi+x4coc1gMdyVDcGgNUmiHa3/3DOvO3s40
         jVN3GWbUKD7unLSv1pvpJsZdRtoreureMzpupGYOKg3j9SIqIlqPTiP7pGT3IJJKCxDA
         4L2XnGJOfO4asvXIOTjxkG3fFQ6i8EzQOQBpcyPptXAwV5bpl7rgYuBBrG1yfJVCaeqx
         8uTeXdKgE07TsvvuL6pN2ywPXN/UQfL8GcD95LHmFhkeK9HdFGeLA6mmHf7iK+SkNsnJ
         fzOw==
X-Gm-Message-State: AGi0Pua4Kd+W4um7jCz35rAPQ2AP0JxnVMcQtOupNsq//Bw99J5r3sF3
        119BtTUVvZ86UDqDd6MP25vJFLSI
X-Google-Smtp-Source: APiQypLI5RpFp09nQROihB2kgcUmYVJU5ssRqNDPbdefdL8tfIdhjoQfWOHezGTe0ymC1MXG4Ab0NQ==
X-Received: by 2002:a37:b105:: with SMTP id a5mr4735183qkf.308.1588354424453;
        Fri, 01 May 2020 10:33:44 -0700 (PDT)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id q57sm3112805qtj.55.2020.05.01.10.33.43
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 01 May 2020 10:33:44 -0700 (PDT)
Received: from klimt.1015granger.net (klimt.1015granger.net [192.168.1.55])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id 041HXgZI026712;
        Fri, 1 May 2020 17:33:42 GMT
Subject: [PATCH v1 4/7] SUNRPC: Remove kernel memory address from svc_xprt
 tracepoints
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org, linux-rdma@vger.kernel.org
Date:   Fri, 01 May 2020 13:33:42 -0400
Message-ID: <20200501173342.3798.60366.stgit@klimt.1015granger.net>
In-Reply-To: <20200501172849.3798.75190.stgit@klimt.1015granger.net>
References: <20200501172849.3798.75190.stgit@klimt.1015granger.net>
User-Agent: StGit/0.22-20-geafe
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

The xprt=%p was meant to distinguish events from different transports,
but the addr=%s does that just as well and does not expose kernel
memory addresses.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 include/trace/events/sunrpc.h |   27 +++++++--------------------
 1 file changed, 7 insertions(+), 20 deletions(-)

diff --git a/include/trace/events/sunrpc.h b/include/trace/events/sunrpc.h
index 287011041e92..282f703b3976 100644
--- a/include/trace/events/sunrpc.h
+++ b/include/trace/events/sunrpc.h
@@ -1184,22 +1184,19 @@ TRACE_EVENT(svc_xprt_do_enqueue,
 	TP_ARGS(xprt, rqst),
 
 	TP_STRUCT__entry(
-		__field(struct svc_xprt *, xprt)
 		__field(int, pid)
 		__field(unsigned long, flags)
 		__string(addr, xprt->xpt_remotebuf)
 	),
 
 	TP_fast_assign(
-		__entry->xprt = xprt;
 		__entry->pid = rqst? rqst->rq_task->pid : 0;
 		__entry->flags = xprt->xpt_flags;
 		__assign_str(addr, xprt->xpt_remotebuf);
 	),
 
-	TP_printk("xprt=%p addr=%s pid=%d flags=%s",
-			__entry->xprt, __get_str(addr),
-			__entry->pid, show_svc_xprt_flags(__entry->flags))
+	TP_printk("addr=%s pid=%d flags=%s", __get_str(addr),
+		__entry->pid, show_svc_xprt_flags(__entry->flags))
 );
 
 DECLARE_EVENT_CLASS(svc_xprt_event,
@@ -1208,20 +1205,17 @@ DECLARE_EVENT_CLASS(svc_xprt_event,
 	TP_ARGS(xprt),
 
 	TP_STRUCT__entry(
-		__field(struct svc_xprt *, xprt)
 		__field(unsigned long, flags)
 		__string(addr, xprt->xpt_remotebuf)
 	),
 
 	TP_fast_assign(
-		__entry->xprt = xprt;
 		__entry->flags = xprt->xpt_flags;
 		__assign_str(addr, xprt->xpt_remotebuf);
 	),
 
-	TP_printk("xprt=%p addr=%s flags=%s",
-			__entry->xprt, __get_str(addr),
-			show_svc_xprt_flags(__entry->flags))
+	TP_printk("addr=%s flags=%s", __get_str(addr),
+		show_svc_xprt_flags(__entry->flags))
 );
 
 DEFINE_EVENT(svc_xprt_event, svc_xprt_no_write_space,
@@ -1234,24 +1228,20 @@ TRACE_EVENT(svc_xprt_dequeue,
 	TP_ARGS(rqst),
 
 	TP_STRUCT__entry(
-		__field(struct svc_xprt *, xprt)
 		__field(unsigned long, flags)
 		__field(unsigned long, wakeup)
 		__string(addr, rqst->rq_xprt->xpt_remotebuf)
 	),
 
 	TP_fast_assign(
-		__entry->xprt = rqst->rq_xprt;
 		__entry->flags = rqst->rq_xprt->xpt_flags;
 		__entry->wakeup = ktime_to_us(ktime_sub(ktime_get(),
 							rqst->rq_qtime));
 		__assign_str(addr, rqst->rq_xprt->xpt_remotebuf);
 	),
 
-	TP_printk("xprt=%p addr=%s flags=%s wakeup-us=%lu",
-			__entry->xprt, __get_str(addr),
-			show_svc_xprt_flags(__entry->flags),
-			__entry->wakeup)
+	TP_printk("addr=%s flags=%s wakeup-us=%lu", __get_str(addr),
+		show_svc_xprt_flags(__entry->flags), __entry->wakeup)
 );
 
 TRACE_EVENT(svc_wake_up,
@@ -1276,21 +1266,18 @@ TRACE_EVENT(svc_handle_xprt,
 	TP_ARGS(xprt, len),
 
 	TP_STRUCT__entry(
-		__field(struct svc_xprt *, xprt)
 		__field(int, len)
 		__field(unsigned long, flags)
 		__string(addr, xprt->xpt_remotebuf)
 	),
 
 	TP_fast_assign(
-		__entry->xprt = xprt;
 		__entry->len = len;
 		__entry->flags = xprt->xpt_flags;
 		__assign_str(addr, xprt->xpt_remotebuf);
 	),
 
-	TP_printk("xprt=%p addr=%s len=%d flags=%s",
-		__entry->xprt, __get_str(addr),
+	TP_printk("addr=%s len=%d flags=%s", __get_str(addr),
 		__entry->len, show_svc_xprt_flags(__entry->flags))
 );
 


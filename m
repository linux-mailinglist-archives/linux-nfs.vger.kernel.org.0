Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B4681E9190
	for <lists+linux-nfs@lfdr.de>; Sat, 30 May 2020 15:29:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729063AbgE3N3P (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sat, 30 May 2020 09:29:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729055AbgE3N3O (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sat, 30 May 2020 09:29:14 -0400
Received: from mail-il1-x141.google.com (mail-il1-x141.google.com [IPv6:2607:f8b0:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A52B3C03E969;
        Sat, 30 May 2020 06:29:14 -0700 (PDT)
Received: by mail-il1-x141.google.com with SMTP id h3so5166235ilh.13;
        Sat, 30 May 2020 06:29:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:cc:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=jnvUwfF7CI1PmTmGW4MKtq9oRVlHeBucxTLJ5+HqSZ4=;
        b=TFEwym2KJIINCzWK0sNQuzZ9Gl3GGr9ibwO967Du24N3N3CwUqAiPJJlKh7rXkfAhd
         sfI1dvTRvpCqFO/RmYiJ1aHVSb0BXDOqigiSkMy2SQgXDpCyAL/0ycNUDrQyD+dq4qGL
         CCI7mojP3tj+XLnb1LjE3WvMVTxmn4P2TCJPnxNCUYfrr1A23yMtkXBV3LnhJiaFNZiz
         cyWjSvxlngwHNOpUWufR4PAuD2k50PUTy/b2EvQOquEMGDGGQ+n9VyJS0l4rBNzOHXjk
         nuE+rV1AvupuBgMZV8dihfL5iJXWfz9tCt5JZQpHIXXCDMpjMoGUNIao1a4oYqNNCG09
         znTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:cc:date:message-id
         :in-reply-to:references:user-agent:mime-version
         :content-transfer-encoding;
        bh=jnvUwfF7CI1PmTmGW4MKtq9oRVlHeBucxTLJ5+HqSZ4=;
        b=JrjSr36hU5aQZNDTiRSwAA4tLViIBlXMetWbrJl9nXTlo/U7quw22Xcvdr3OtbH79J
         TQNKTIgmbdfUSNbgCB98pkotTLhT4kT2Yt1q5+xPOiWF3gbI5+pty3C4kD3zaUMtkBYy
         6hESBLo+B8nkzlBkfRqTLjMkD5iZnjn/9++wKatBMwTkamhWUFNcHtMlfPE7wHrMu/fP
         dzldwPa4seclKFN/NX4e3ncbx537RuWu+s2jIWmuWEuT91dxTMbx2u9tSO9fJn6VrUoM
         ewXtSmy9pMCWYKVEgP7Mo9EQ1LJeiKs9M3k2VEIPz7AzDOb9G/p4deNZPPyFtrjjmIbS
         n0xg==
X-Gm-Message-State: AOAM533e0hMAuz1CPc4jXEdoBWYPYEmg3hYp23sp370BVG4fFVC5NOn2
        l4xqlGbV2Zo26ywRbXDrBCJIf5zA
X-Google-Smtp-Source: ABdhPJz79hyXMOa95mG5b1jnWGbhK6DrW5KgfaHoz1CtlQOs+cQvSi9twHbGWR5ZiApQlQqNxdLPmQ==
X-Received: by 2002:a05:6e02:4c8:: with SMTP id f8mr11170051ils.174.1590845353790;
        Sat, 30 May 2020 06:29:13 -0700 (PDT)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id z13sm6576237ilh.82.2020.05.30.06.29.13
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 30 May 2020 06:29:13 -0700 (PDT)
Received: from klimt.1015granger.net (klimt.1015granger.net [192.168.1.55])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id 04UDTCcZ001423;
        Sat, 30 May 2020 13:29:12 GMT
Subject: [PATCH v4 13/33] SUNRPC: Remove kernel memory address from svc_xprt
 tracepoints
From:   Chuck Lever <chuck.lever@oracle.com>
To:     bfields@fieldses.org
Cc:     linux-nfs@vger.kernel.org, linux-rdma@vger.kernel.org
Date:   Sat, 30 May 2020 09:29:12 -0400
Message-ID: <20200530132912.10117.12705.stgit@klimt.1015granger.net>
In-Reply-To: <20200530131711.10117.74063.stgit@klimt.1015granger.net>
References: <20200530131711.10117.74063.stgit@klimt.1015granger.net>
User-Agent: StGit/0.22-31-g4b47
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Clean up: The xprt=%p was meant to distinguish events from different
transports, but the addr=%s does that just as well and does not
expose kernel memory addresses.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 include/trace/events/sunrpc.h |   27 +++++++--------------------
 1 file changed, 7 insertions(+), 20 deletions(-)

diff --git a/include/trace/events/sunrpc.h b/include/trace/events/sunrpc.h
index 1d53b77dd3e8..9b5a36422141 100644
--- a/include/trace/events/sunrpc.h
+++ b/include/trace/events/sunrpc.h
@@ -1192,22 +1192,19 @@ TRACE_EVENT(svc_xprt_do_enqueue,
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
@@ -1216,20 +1213,17 @@ DECLARE_EVENT_CLASS(svc_xprt_event,
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
@@ -1242,24 +1236,20 @@ TRACE_EVENT(svc_xprt_dequeue,
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
@@ -1284,21 +1274,18 @@ TRACE_EVENT(svc_handle_xprt,
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
 


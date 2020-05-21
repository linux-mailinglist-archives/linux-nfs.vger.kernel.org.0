Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C1CA31DCFE3
	for <lists+linux-nfs@lfdr.de>; Thu, 21 May 2020 16:34:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729598AbgEUOet (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 21 May 2020 10:34:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729169AbgEUOet (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 21 May 2020 10:34:49 -0400
Received: from mail-il1-x142.google.com (mail-il1-x142.google.com [IPv6:2607:f8b0:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D63FEC061A0E;
        Thu, 21 May 2020 07:34:48 -0700 (PDT)
Received: by mail-il1-x142.google.com with SMTP id b15so7239440ilq.12;
        Thu, 21 May 2020 07:34:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:cc:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=hra1t6ZMjxlnkAjll6l3Ni1WveftdJxGwRCSmO0AxDM=;
        b=UtiQbWLsDqtZOitZeCeaMtX9RlQDstqVjfP4tQNNyGKmvYAgQSn+R4SzmANiPBHyru
         CQoc7ZGns4UiWfSqt0fYeu7OADEhMDvbRo9qu1yTP2E1OEUTAVOAYY6BEVsS+FKfvQGr
         P5U9UNl0r8xHR+vC1tLDqP4EQTyCPq0HQDwpRy/sZx8HtZTMAXsRBzOpM0dcGHJ4p/YU
         abDXK1YPdINfp9i71cH+JS6yJTL72FMHPpeW0Ycgmk7rXIwzjc2QUPZqiJE3SooYh8m9
         39ezhx66y8/GAJe89BQIIi1uKG/nkrxkOPNfm4MmrIVUR+6j1qvlTkdS4iYHwykHQ30S
         ISKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:cc:date:message-id
         :in-reply-to:references:user-agent:mime-version
         :content-transfer-encoding;
        bh=hra1t6ZMjxlnkAjll6l3Ni1WveftdJxGwRCSmO0AxDM=;
        b=mobqT4OMz9z9jP+p5kQk7nH0TnRkqC/RgIDWSkEe5ts3HcWjCfROlsco5zEfqD1lfy
         bowY0H7YZKboYyGMk6GDE2P+yy4UCiSVrye3Iz6eWgMAYDhnrKKqHTkV7wdvVROczkDA
         Afwm7/JXONifuTr51E3u84To1iGoQCnCkr0RRULrwNi2raFFG0tUKGMpac34zVeEXhNC
         BXMoLaWbD95QHRPYwHzRqpsUqenzYEewsAKTS84e45Gn9SHjB4ntWDQ1HdsdQS/7Vf0P
         AM5N1rSnFoKnjqg1oswUuIZcYbNWanPNrWXDGa0aX2ruOVoOUXNvYRUOrHl6yfn2vJUj
         mTMA==
X-Gm-Message-State: AOAM5304JYDj22sgOQw4LT1o/FzU7jKZPAmAc9hkENWRT1s79OEvpXk7
        lvF+AOxClk3/WXXpAe0gxxH+fBTo
X-Google-Smtp-Source: ABdhPJwu0dq/P1cPcDw08BKl5kntS5HeObQkEzqSyRADM4FGFsighRQybNm9RmCv/nXJFhWr6J1ISw==
X-Received: by 2002:a92:c6c7:: with SMTP id v7mr6574276ilm.277.1590071688001;
        Thu, 21 May 2020 07:34:48 -0700 (PDT)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id l7sm3245295ilh.54.2020.05.21.07.34.47
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 21 May 2020 07:34:47 -0700 (PDT)
Received: from klimt.1015granger.net (klimt.1015granger.net [192.168.1.55])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id 04LEYkfb000856;
        Thu, 21 May 2020 14:34:46 GMT
Subject: [PATCH v3 12/32] SUNRPC: Remove kernel memory address from svc_xprt
 tracepoints
From:   Chuck Lever <chuck.lever@oracle.com>
To:     bfields@fieldses.org
Cc:     linux-nfs@vger.kernel.org, linux-rdma@vger.kernel.org
Date:   Thu, 21 May 2020 10:34:46 -0400
Message-ID: <20200521143446.3557.52142.stgit@klimt.1015granger.net>
In-Reply-To: <20200521141100.3557.17098.stgit@klimt.1015granger.net>
References: <20200521141100.3557.17098.stgit@klimt.1015granger.net>
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
index ffd2215950dc..53f2461cf552 100644
--- a/include/trace/events/sunrpc.h
+++ b/include/trace/events/sunrpc.h
@@ -1173,22 +1173,19 @@ TRACE_EVENT(svc_xprt_do_enqueue,
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
@@ -1197,20 +1194,17 @@ DECLARE_EVENT_CLASS(svc_xprt_event,
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
@@ -1223,24 +1217,20 @@ TRACE_EVENT(svc_xprt_dequeue,
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
@@ -1265,21 +1255,18 @@ TRACE_EVENT(svc_handle_xprt,
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
 


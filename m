Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3CF321D00B2
	for <lists+linux-nfs@lfdr.de>; Tue, 12 May 2020 23:23:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731293AbgELVXM (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 12 May 2020 17:23:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728220AbgELVXM (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 12 May 2020 17:23:12 -0400
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com [IPv6:2607:f8b0:4864:20::742])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92ACAC061A0C;
        Tue, 12 May 2020 14:23:10 -0700 (PDT)
Received: by mail-qk1-x742.google.com with SMTP id g185so15249518qke.7;
        Tue, 12 May 2020 14:23:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:cc:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=hra1t6ZMjxlnkAjll6l3Ni1WveftdJxGwRCSmO0AxDM=;
        b=WOFIHh2AlKs7JLT9QnyycKbX36KQlvHRIENVADLL6wX6GQWQ2vV5/4NGOjz8VUI27i
         bM090+eSF1JmfLNK/YhCBQ24dLc89w1BwR7QBo4THcW7PLhqrQ7uzzehpnZ8nK9WoiPI
         slo3txMxT0OGK8JlEm5XcdPPCkbjxSLv0e5/u7QYQ+NXVmU/e6keWxqtIAhQNNelqWvD
         Aac/Tm7ApfAlEte3H/7Bccw5Aoyvi0LBeWdFkZ3SPgEBHQIpTfS0X7K2XWelFVFLs6rs
         YrdIJwYbLyshPZlKaInSEHX7Bz94JKsA8sp0Ixm/z3olXyTgZuGL4Rvy+zbXmZwel9CW
         N+2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:cc:date:message-id
         :in-reply-to:references:user-agent:mime-version
         :content-transfer-encoding;
        bh=hra1t6ZMjxlnkAjll6l3Ni1WveftdJxGwRCSmO0AxDM=;
        b=kKgxOBJvPr+PBFVkLw8sEBiZht1LFoDNyhIvxs/Fl6vE/UZO2roj9Kigex1ONTNShO
         T/zpChyhQzxFGwjrwerlnaVqOP8GdYgug12HzEHTOvNPw2IX54KN2gv1Nby66Q/RZxsV
         2ncTp15eipsExsMlfvef5nAyVQg/Khn8A/925vaF0s4rJdrLPJKkUCDl/yfYvQC7g53u
         fCvHUI0Up5dB2yCYf4PXHJ25e6/oi4YkWrd/Z9w9TUMkjhUjNMMSHZW7e45P5u7CLOkg
         rmTBod0x0pyg8sb33iJzudUEDuLB/IDZGWoiftednMRcsZ5z2bG9GdTW4G0TYUccLxTe
         YJ0w==
X-Gm-Message-State: AGi0PuYeSKGTx1/AEfbWWMVItaNKfvp+EwSzjh+8m+bOpCYo+yrOAcbO
        FEO75qe3xJbQlmK7JbThWE1Nr+qT
X-Google-Smtp-Source: APiQypJkj6Q0H8xWjg8PC+C0XnFaJX2+KXWjWeXspC2AqlmixqvmzL8huMhxN7ZzfLHEw5QZ5TEsBg==
X-Received: by 2002:a05:620a:55b:: with SMTP id o27mr24819214qko.161.1589318589657;
        Tue, 12 May 2020 14:23:09 -0700 (PDT)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id c68sm12191243qke.129.2020.05.12.14.23.08
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 12 May 2020 14:23:09 -0700 (PDT)
Received: from klimt.1015granger.net (klimt.1015granger.net [192.168.1.55])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id 04CLN83s009910;
        Tue, 12 May 2020 21:23:08 GMT
Subject: [PATCH v2 12/29] SUNRPC: Remove kernel memory address from svc_xprt
 tracepoints
From:   Chuck Lever <chuck.lever@oracle.com>
To:     bfields@fieldses.org
Cc:     linux-nfs@vger.kernel.org, linux-rdma@vger.kernel.org
Date:   Tue, 12 May 2020 17:23:08 -0400
Message-ID: <20200512212308.5826.1735.stgit@klimt.1015granger.net>
In-Reply-To: <20200512211640.5826.77139.stgit@klimt.1015granger.net>
References: <20200512211640.5826.77139.stgit@klimt.1015granger.net>
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
 


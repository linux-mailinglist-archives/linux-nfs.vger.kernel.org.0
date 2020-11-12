Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6721B2B0801
	for <lists+linux-nfs@lfdr.de>; Thu, 12 Nov 2020 16:01:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728198AbgKLPBF (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 12 Nov 2020 10:01:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728274AbgKLPBF (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 12 Nov 2020 10:01:05 -0500
Received: from mail-qv1-xf43.google.com (mail-qv1-xf43.google.com [IPv6:2607:f8b0:4864:20::f43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DB67C0613D1
        for <linux-nfs@vger.kernel.org>; Thu, 12 Nov 2020 07:01:05 -0800 (PST)
Received: by mail-qv1-xf43.google.com with SMTP id g19so2884218qvy.2
        for <linux-nfs@vger.kernel.org>; Thu, 12 Nov 2020 07:01:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=qDpdIOLrhjTQrpzsl9wBdkjFgzhReC0zwz+qtwetabI=;
        b=GUpvl3K87H3A2GRTDo/YoqpbdGvk4dVQfBLRV8xWRmqgmZ/4DhrU0mPLITqopHJ886
         +0cuRNEcmfBFpbI13XI9ewpBb99oG55RFAOthQ3SEsKp9RuYm/2ITJIaJ8O4VewwoQ0w
         CaU4DVOMnuG5+9MUxrqoNRhhi53Fgrpgc1OrIJ7pglgpUQAa5UsDo7g/VBW6DJFxHLnc
         GVOPS7WO2kQc+B1Van/QsNXuZJxoq81QC9cedUEj2OZrUSdNVGVo6RaPtYO+m/CXXhQV
         lohpQrxMAhGHb/QxIafadDEv+2gne7DPOnzr0N/9zbE3akvlACjdSZE7NsnrORJCE4B3
         hyaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:date:message-id
         :in-reply-to:references:user-agent:mime-version
         :content-transfer-encoding;
        bh=qDpdIOLrhjTQrpzsl9wBdkjFgzhReC0zwz+qtwetabI=;
        b=behQ49Ms9GUv4sWdoitbmlkGhedkoDbEBXzIYAhoNp6z22Bx0rw+LanrsaeKgM0RqU
         /NXWNt3xS5OZe9v8el+EcW/O+An/wUcEubO/sGitx6iIZDHIwFvAA4AAg5JrLK/cPb2v
         GFAaagTVU7SYoysqGP3pA/Pjz3K4UwOwSu0MtcSsb8t/gZHLm+Aq15E22SjGR7byZXxO
         iU++WwIskUOB6e5v1IpRU8PAwX8SNdXH8bUDKkXMB2m7S6BtbaHxNEuPqIQD1kw48Lc6
         gm+14BG3tu3sc6vN16OjsN2ABuiAzJF0euqHESOe1T3zh88xyIbwNkffMQLdXF/2r50l
         qaOA==
X-Gm-Message-State: AOAM532CDzIchg4o8zaMazv/Wo79chrTX0uahjxeNCOR4A4bGaW1Bm3h
        dfIRjMvo7kOKs2QhR9H8uAXQxrrR2Fs=
X-Google-Smtp-Source: ABdhPJwkPfbS+LJLckeNYq/pkbXkxNfXCbRg4Q+mX+4HqQwYD34zosN+Q6N62Yii3hLsK30SWvJIog==
X-Received: by 2002:a0c:a8e4:: with SMTP id h36mr149152qvc.24.1605193263951;
        Thu, 12 Nov 2020 07:01:03 -0800 (PST)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id b4sm4653773qtt.52.2020.11.12.07.01.02
        for <linux-nfs@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 12 Nov 2020 07:01:02 -0800 (PST)
Sender: Chuck Lever <chucklever@gmail.com>
Received: from klimt.1015granger.net (klimt.1015granger.net [192.168.1.55])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id 0ACF11Dg029783
        for <linux-nfs@vger.kernel.org>; Thu, 12 Nov 2020 15:01:01 GMT
Subject: [PATCH v1 1/4] SUNRPC: Move the svc_xdr_recvfrom() tracepoint
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org
Date:   Thu, 12 Nov 2020 10:01:01 -0500
Message-ID: <160519326129.1658.2735413211078662133.stgit@klimt.1015granger.net>
In-Reply-To: <160519319763.1658.12613346131541001302.stgit@klimt.1015granger.net>
References: <160519319763.1658.12613346131541001302.stgit@klimt.1015granger.net>
User-Agent: StGit/0.23-29-ga622f1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Commit c509f15a5801 ("SUNRPC: Split the xdr_buf event class") added
display of the rqst's XID to the svc_xdr_buf_class. However, when
the recvfrom tracepoint fires, rq_xid has yet to be filled in with
the current XID. So it ends up recording the last XID that was
handled by that svc_rqst.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 include/trace/events/sunrpc.h |   24 ------------------------
 net/sunrpc/svc_xprt.c         |    4 +---
 2 files changed, 1 insertion(+), 27 deletions(-)

diff --git a/include/trace/events/sunrpc.h b/include/trace/events/sunrpc.h
index 2477014e3fa6..065f39056e87 100644
--- a/include/trace/events/sunrpc.h
+++ b/include/trace/events/sunrpc.h
@@ -1499,30 +1499,6 @@ SVC_RQST_FLAG_LIST
 #define show_rqstp_flags(flags)						\
 		__print_flags(flags, "|", SVC_RQST_FLAG_LIST)
 
-TRACE_EVENT(svc_recv,
-	TP_PROTO(struct svc_rqst *rqst, int len),
-
-	TP_ARGS(rqst, len),
-
-	TP_STRUCT__entry(
-		__field(u32, xid)
-		__field(int, len)
-		__field(unsigned long, flags)
-		__string(addr, rqst->rq_xprt->xpt_remotebuf)
-	),
-
-	TP_fast_assign(
-		__entry->xid = be32_to_cpu(rqst->rq_xid);
-		__entry->len = len;
-		__entry->flags = rqst->rq_flags;
-		__assign_str(addr, rqst->rq_xprt->xpt_remotebuf);
-	),
-
-	TP_printk("addr=%s xid=0x%08x len=%d flags=%s",
-			__get_str(addr), __entry->xid, __entry->len,
-			show_rqstp_flags(__entry->flags))
-);
-
 TRACE_DEFINE_ENUM(SVC_GARBAGE);
 TRACE_DEFINE_ENUM(SVC_SYSERR);
 TRACE_DEFINE_ENUM(SVC_VALID);
diff --git a/net/sunrpc/svc_xprt.c b/net/sunrpc/svc_xprt.c
index 43cf8dbde898..5fb9164aa690 100644
--- a/net/sunrpc/svc_xprt.c
+++ b/net/sunrpc/svc_xprt.c
@@ -813,8 +813,6 @@ static int svc_handle_xprt(struct svc_rqst *rqstp, struct svc_xprt *xprt)
 			len = svc_deferred_recv(rqstp);
 		else
 			len = xprt->xpt_ops->xpo_recvfrom(rqstp);
-		if (len > 0)
-			trace_svc_xdr_recvfrom(rqstp, &rqstp->rq_arg);
 		rqstp->rq_stime = ktime_get();
 		rqstp->rq_reserved = serv->sv_max_mesg;
 		atomic_add(rqstp->rq_reserved, &xprt->xpt_reserved);
@@ -868,7 +866,7 @@ int svc_recv(struct svc_rqst *rqstp, long timeout)
 
 	if (serv->sv_stats)
 		serv->sv_stats->netcnt++;
-	trace_svc_recv(rqstp, len);
+	trace_svc_xdr_recvfrom(rqstp, &rqstp->rq_arg);
 	return len;
 out_release:
 	rqstp->rq_res.len = 0;



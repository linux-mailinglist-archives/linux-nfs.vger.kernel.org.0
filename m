Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 071AF26CE90
	for <lists+linux-nfs@lfdr.de>; Thu, 17 Sep 2020 00:18:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726441AbgIPWSX (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 16 Sep 2020 18:18:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726436AbgIPWR5 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 16 Sep 2020 18:17:57 -0400
Received: from mail-il1-x142.google.com (mail-il1-x142.google.com [IPv6:2607:f8b0:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2356C061A28
        for <linux-nfs@vger.kernel.org>; Wed, 16 Sep 2020 14:42:26 -0700 (PDT)
Received: by mail-il1-x142.google.com with SMTP id y9so293913ilq.2
        for <linux-nfs@vger.kernel.org>; Wed, 16 Sep 2020 14:42:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:cc:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=eZsJrS5RIkpBLpJ5cvtnOC7i1FNw4orc+FZSFyzk3fU=;
        b=Tix2bEKSbJ6oblpHOsPuvYoSJU/1Sl7n4BeI7p2nf0AwljfTwMXWdHqf+iqED259NJ
         q4TU3OAQdSfAt/5arc+3Oaspd10co1JO0oH9rf2knmvlAHZKa7JOU35JFICZR4DYKTwG
         c0Ax5I1C4kroJ04QJvwr6xbhgricW8M50NPk67APgDZxahCunH8+LkWKIJP2ynhbFDpl
         QSUrbeRA0ibmELWZ9BM6j7MB0A/ApGAR3jvHJwu7fpuisst7z0m9il4M/XA+RpnM3Nsw
         LWhbJ8PRE0ojtWUnGoDSNSjVUX5w+aJ37yiJdrS89YbI9YMNaPHSOzZiSzrN7gMnow/h
         dPwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:cc:date:message-id
         :in-reply-to:references:user-agent:mime-version
         :content-transfer-encoding;
        bh=eZsJrS5RIkpBLpJ5cvtnOC7i1FNw4orc+FZSFyzk3fU=;
        b=BdaHQX7r+CZRH1Blu6f2ZXBe+VEVI9Y/JX+wmBSkQZKQPdeR8Is4O7OR6aovt3nO4F
         zwn+l13pfy2Yi4ItbrFQDgmCKwO+C6q3SC9ONoZoCeHmrPo3IGmn1UJUYIgIqIrR7r0z
         rubyOvPqrfUU5J2Cas5ZkdqWOkhO/KyB0vZvqxwpr1yEUjPc9cawy8dgMqsO/fixluOK
         pmOf4qfaARSupjfZW+rWDuxMyZqdw6IZJCpy37ZmA+TAI9HeBLscwNDhFa9r6XgPUpHe
         b7F1hdJVVbYlPxbBOEyEEqLY3bTZ5ArMxrRbcl1+eyYy2jWNcbGCV19zvVf3RqhH7XAC
         9gqQ==
X-Gm-Message-State: AOAM532J7SopPYm1o99HR8tqrYF4ZbX8dRF7GSC+w2CEP+PNrBkjMZ2d
        DLDuoLEqASPmax8EH7lFPmRq6Rpe9kc=
X-Google-Smtp-Source: ABdhPJxDkdg1vaUkje/n2XgoRjjvAIMKvvz6p4Pp4ihJ8drr7COMDkgUbn+ufwcaK26IACEJjlUGjw==
X-Received: by 2002:a92:c847:: with SMTP id b7mr10373381ilq.35.1600292545246;
        Wed, 16 Sep 2020 14:42:25 -0700 (PDT)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id o8sm11807154ilb.64.2020.09.16.14.42.24
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 16 Sep 2020 14:42:24 -0700 (PDT)
Received: from klimt.1015granger.net (klimt.1015granger.net [192.168.1.55])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id 08GLgNBm022984;
        Wed, 16 Sep 2020 21:42:23 GMT
Subject: [PATCH RFC 02/21] SUNRPC: Move the svc_xdr_recvfrom() tracepoint
From:   Chuck Lever <chuck.lever@oracle.com>
To:     bfields@fieldses.org, Bill.Baker@oracle.com
Cc:     linux-nfs@vger.kernel.org
Date:   Wed, 16 Sep 2020 17:42:23 -0400
Message-ID: <160029254350.29208.3186375071514902812.stgit@klimt.1015granger.net>
In-Reply-To: <160029169954.29208.8757662600714736320.stgit@klimt.1015granger.net>
References: <160029169954.29208.8757662600714736320.stgit@klimt.1015granger.net>
User-Agent: StGit/0.23
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
index 65d7dfbbc9cd..6afd39572dcd 100644
--- a/include/trace/events/sunrpc.h
+++ b/include/trace/events/sunrpc.h
@@ -1279,30 +1279,6 @@ SVC_RQST_FLAG_LIST
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



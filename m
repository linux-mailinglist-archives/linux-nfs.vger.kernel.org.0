Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 22A1027318F
	for <lists+linux-nfs@lfdr.de>; Mon, 21 Sep 2020 20:11:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727707AbgIUSLN (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 21 Sep 2020 14:11:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726436AbgIUSLN (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 21 Sep 2020 14:11:13 -0400
Received: from mail-il1-x144.google.com (mail-il1-x144.google.com [IPv6:2607:f8b0:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 481AAC0613CF
        for <linux-nfs@vger.kernel.org>; Mon, 21 Sep 2020 11:11:13 -0700 (PDT)
Received: by mail-il1-x144.google.com with SMTP id h2so14689681ilo.12
        for <linux-nfs@vger.kernel.org>; Mon, 21 Sep 2020 11:11:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:cc:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=eZsJrS5RIkpBLpJ5cvtnOC7i1FNw4orc+FZSFyzk3fU=;
        b=c81+G1dQ0pEaL4kiGwCBUopbLdrCieRkQwdWVAzCPdYTvwXSLhQpu7v4034HmEr0OM
         kq9xa67crMEstS5Cz2Csg45DgQ9cnflZGX+buePGkv1SNIivzFyoLJNZ9uFREkeJLWmC
         6Cga1UCgdrWHHJdoxFRY2pvPeTs0JisegDbtXosKCfa3tLbOnyhTJd+Ay/28+ZA6qs1c
         QJymEwSiNsalcrs4Ou03GCiltSc6Reey+jlvFQzW5snTJNHKtWQNLiKsIjD5czc1RlQ8
         eBqf1QU7kBDkc5ScHrZLpXO45VSK392j4v1E6HxED/Gh3OgaeV+fPQxetcfY9eaYsbW4
         NYYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:cc:date:message-id
         :in-reply-to:references:user-agent:mime-version
         :content-transfer-encoding;
        bh=eZsJrS5RIkpBLpJ5cvtnOC7i1FNw4orc+FZSFyzk3fU=;
        b=lzSaXS26i4p/1FKMusaypFbDaOrXSNZ8MYoC2PMsbLfNkxZ7lyeWxcmlWQKgHbCT0Y
         4ixnsSv6/iOdzfI6cKX2zyxQhCdbzn9729/DroODy19AufEwUJ+gYHMxStZFGW4w2hSV
         mEOIRd3yr1Hce+vgzQdUIUeFro1JXfy0L2XcttPQDcTWcq5TfzukEDIGDKAFmePNng1t
         Li5Eu/nDwpVmcP7ULGAuH3cMvYwppVt2VpWgxGlomHaQ5fvw1tHiyCjY9TMRRwDqHUac
         n3XSNjjdoM1BD73ulOFJPl5bW57LY68AC58KlL4FV0xJOnM8SfqevGqATf42KxAQOK5s
         fFwg==
X-Gm-Message-State: AOAM533nt0uXWlkOKnMbSV3eeD0DoRqTKaa+4j61uPnimXg6xCeNwjoe
        cDAyCe3yMGV2sj/D44Hs01M7SLGSYiM=
X-Google-Smtp-Source: ABdhPJzx5qUq0wxv9zb0XrB2pacMQsg7KsnPwC3izfY73brWc5y3+4fJLvgkTC/58/8n90HZff0KPg==
X-Received: by 2002:a92:d645:: with SMTP id x5mr1092323ilp.79.1600711872724;
        Mon, 21 Sep 2020 11:11:12 -0700 (PDT)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id p8sm3539632ilj.36.2020.09.21.11.11.11
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 21 Sep 2020 11:11:12 -0700 (PDT)
Sender: Chuck Lever <chucklever@gmail.com>
Received: from klimt.1015granger.net (klimt.1015granger.net [192.168.1.55])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id 08LIBBIt003854;
        Mon, 21 Sep 2020 18:11:11 GMT
Subject: [PATCH v2 04/27] SUNRPC: Move the svc_xdr_recvfrom() tracepoint
From:   Chuck Lever <chuck.lever@oracle.com>
To:     bfields@fieldses.org, Bill.Baker@oracle.com
Cc:     linux-nfs@vger.kernel.org
Date:   Mon, 21 Sep 2020 14:11:11 -0400
Message-ID: <160071187104.1468.4754888533074770999.stgit@klimt.1015granger.net>
In-Reply-To: <160071167664.1468.1365570508917640511.stgit@klimt.1015granger.net>
References: <160071167664.1468.1365570508917640511.stgit@klimt.1015granger.net>
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



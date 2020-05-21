Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5FA5B1DD01B
	for <lists+linux-nfs@lfdr.de>; Thu, 21 May 2020 16:36:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729833AbgEUOgY (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 21 May 2020 10:36:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729821AbgEUOgX (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 21 May 2020 10:36:23 -0400
Received: from mail-io1-xd43.google.com (mail-io1-xd43.google.com [IPv6:2607:f8b0:4864:20::d43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3694C061A0E;
        Thu, 21 May 2020 07:36:23 -0700 (PDT)
Received: by mail-io1-xd43.google.com with SMTP id f4so7622077iov.11;
        Thu, 21 May 2020 07:36:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:cc:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=WDzvGv6KwxQF5UtWa+LPQG8gCo9BoEft+lgJ/tR8onc=;
        b=IRSS0Vy2tagHNypL5dXGIJItBoDfmZ6pDNk3SA20yWcFCmZkYkSSgtE/jVK7G0/WvP
         a3k7vKrPhM/Xz35M+kKrJFHKG+LEqgGvguY8TaRJp//16TlRQym/bRq9zwfkUboagbs8
         TNH0owyGzmQYg6laTh131+ZUDEFnD9gb8VaruCFwkwOz2wkLWGhEeu3QNqXbbe7ikyUg
         YTPb6dXWk8IvxLcyhInNYo70YPAJthPd/g/aE42r06yCW5ocw5Cu8wF2xnnO9MwNPwQl
         YhSreqFxjjUzUN1CA+833cFtxyoMmyzBm687Bt0ZxcDJSG61KXw02Lm9d6K3KOZ3D/Wy
         clBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:cc:date:message-id
         :in-reply-to:references:user-agent:mime-version
         :content-transfer-encoding;
        bh=WDzvGv6KwxQF5UtWa+LPQG8gCo9BoEft+lgJ/tR8onc=;
        b=ok7FIMeJStuLZgn2JIphqG/7Muy/GoNY2O0ZmazgdJGdIzSNmYHj6jReTj3xIUPukR
         KkukVLQ1XXBosrAx4H06ZMmq9YQ2WHDmSIkRscvsdR10aZhNCTNJ/EmwgsWG1evqsmwd
         anOMqzA8aBYHHfb3oXBMpIlm/w+PytWk44VGzbd0HAoLkCPRoHeOcGB1JaVCK3oIEF3t
         WjHLjNOW4efCXHBmuHE/F4HfLcdtn3B94qNlP62hz91pcfwAz6/4j95BldzkOlIz9oQo
         ErXLhh5wQGGrA85BcZI8xR17OaklasvlZ4yZia3ePeqQa6iU3zXhljTmFlx5MX8BAHKK
         laEA==
X-Gm-Message-State: AOAM533NZiw+LdR+nZcaD0yfJi5bR1s01E6yFY19tYrepM7LFLYB7Zzw
        R2/g9DYkgldtKm83GJ8duHmLN892
X-Google-Smtp-Source: ABdhPJygy1Dth/s6J0ZF5XOwsz1LR47OwIAIFShsemiVW0lnQL3y2nBioWj0y2th23JMR6CCxx4lDg==
X-Received: by 2002:a05:6602:cd:: with SMTP id z13mr6455952ioe.109.1590071782896;
        Thu, 21 May 2020 07:36:22 -0700 (PDT)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id j2sm2511575ioo.8.2020.05.21.07.36.22
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 21 May 2020 07:36:22 -0700 (PDT)
Received: from klimt.1015granger.net (klimt.1015granger.net [192.168.1.55])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id 04LEaLtA000929;
        Thu, 21 May 2020 14:36:21 GMT
Subject: [PATCH v3 30/32] SUNRPC: Clean up request deferral tracepoints
From:   Chuck Lever <chuck.lever@oracle.com>
To:     bfields@fieldses.org
Cc:     linux-nfs@vger.kernel.org, linux-rdma@vger.kernel.org
Date:   Thu, 21 May 2020 10:36:21 -0400
Message-ID: <20200521143621.3557.75072.stgit@klimt.1015granger.net>
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

- Rename these so they are easy to enable and search for as a set
- Move the tracepoints to get a more accurate sense of control flow
- Tracepoints should not fire on xprt shutdown
- Display memory address in case data structure had been corrupted
- Abandon dprintk in these paths

I haven't ever gotten one of these tracepoints to trigger. I wonder
if we should simply remove them.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 include/trace/events/sunrpc.h |   11 ++++++++---
 net/sunrpc/svc_xprt.c         |   12 ++++++------
 2 files changed, 14 insertions(+), 9 deletions(-)

diff --git a/include/trace/events/sunrpc.h b/include/trace/events/sunrpc.h
index 2a7f6f83341f..852413cbb7d9 100644
--- a/include/trace/events/sunrpc.h
+++ b/include/trace/events/sunrpc.h
@@ -1406,27 +1406,32 @@ DECLARE_EVENT_CLASS(svc_deferred_event,
 	TP_ARGS(dr),
 
 	TP_STRUCT__entry(
+		__field(const void *, dr)
 		__field(u32, xid)
 		__string(addr, dr->xprt->xpt_remotebuf)
 	),
 
 	TP_fast_assign(
+		__entry->dr = dr;
 		__entry->xid = be32_to_cpu(*(__be32 *)(dr->args +
 						       (dr->xprt_hlen>>2)));
 		__assign_str(addr, dr->xprt->xpt_remotebuf);
 	),
 
-	TP_printk("addr=%s xid=0x%08x", __get_str(addr), __entry->xid)
+	TP_printk("addr=%s dr=%p xid=0x%08x", __get_str(addr), __entry->dr,
+		__entry->xid)
 );
+
 #define DEFINE_SVC_DEFERRED_EVENT(name) \
-	DEFINE_EVENT(svc_deferred_event, svc_##name##_deferred, \
+	DEFINE_EVENT(svc_deferred_event, svc_defer_##name, \
 			TP_PROTO( \
 				const struct svc_deferred_req *dr \
 			), \
 			TP_ARGS(dr))
 
 DEFINE_SVC_DEFERRED_EVENT(drop);
-DEFINE_SVC_DEFERRED_EVENT(revisit);
+DEFINE_SVC_DEFERRED_EVENT(queue);
+DEFINE_SVC_DEFERRED_EVENT(recv);
 
 TRACE_EVENT(svcsock_new_socket,
 	TP_PROTO(
diff --git a/net/sunrpc/svc_xprt.c b/net/sunrpc/svc_xprt.c
index 0a546ef02dde..c1ff8cdb5b2b 100644
--- a/net/sunrpc/svc_xprt.c
+++ b/net/sunrpc/svc_xprt.c
@@ -1145,16 +1145,15 @@ static void svc_revisit(struct cache_deferred_req *dreq, int too_many)
 	set_bit(XPT_DEFERRED, &xprt->xpt_flags);
 	if (too_many || test_bit(XPT_DEAD, &xprt->xpt_flags)) {
 		spin_unlock(&xprt->xpt_lock);
-		dprintk("revisit canceled\n");
+		trace_svc_defer_drop(dr);
 		svc_xprt_put(xprt);
-		trace_svc_drop_deferred(dr);
 		kfree(dr);
 		return;
 	}
-	dprintk("revisit queued\n");
 	dr->xprt = NULL;
 	list_add(&dr->handle.recent, &xprt->xpt_deferred);
 	spin_unlock(&xprt->xpt_lock);
+	trace_svc_defer_queue(dr);
 	svc_xprt_enqueue(xprt);
 	svc_xprt_put(xprt);
 }
@@ -1200,22 +1199,24 @@ static struct cache_deferred_req *svc_defer(struct cache_req *req)
 		memcpy(dr->args, rqstp->rq_arg.head[0].iov_base - skip,
 		       dr->argslen << 2);
 	}
+	trace_svc_defer(rqstp);
 	svc_xprt_get(rqstp->rq_xprt);
 	dr->xprt = rqstp->rq_xprt;
 	set_bit(RQ_DROPME, &rqstp->rq_flags);
 
 	dr->handle.revisit = svc_revisit;
-	trace_svc_defer(rqstp);
 	return &dr->handle;
 }
 
 /*
  * recv data from a deferred request into an active one
  */
-static int svc_deferred_recv(struct svc_rqst *rqstp)
+static noinline int svc_deferred_recv(struct svc_rqst *rqstp)
 {
 	struct svc_deferred_req *dr = rqstp->rq_deferred;
 
+	trace_svc_defer_recv(dr);
+
 	/* setup iov_base past transport header */
 	rqstp->rq_arg.head[0].iov_base = dr->args + (dr->xprt_hlen>>2);
 	/* The iov_len does not include the transport header bytes */
@@ -1246,7 +1247,6 @@ static struct svc_deferred_req *svc_deferred_dequeue(struct svc_xprt *xprt)
 				struct svc_deferred_req,
 				handle.recent);
 		list_del_init(&dr->handle.recent);
-		trace_svc_revisit_deferred(dr);
 	} else
 		clear_bit(XPT_DEFERRED, &xprt->xpt_flags);
 	spin_unlock(&xprt->xpt_lock);


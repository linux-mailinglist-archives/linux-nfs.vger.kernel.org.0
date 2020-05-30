Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 770131E91B5
	for <lists+linux-nfs@lfdr.de>; Sat, 30 May 2020 15:30:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729120AbgE3Nau (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sat, 30 May 2020 09:30:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728802AbgE3Nat (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sat, 30 May 2020 09:30:49 -0400
Received: from mail-io1-xd43.google.com (mail-io1-xd43.google.com [IPv6:2607:f8b0:4864:20::d43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7FCFC03E969;
        Sat, 30 May 2020 06:30:49 -0700 (PDT)
Received: by mail-io1-xd43.google.com with SMTP id p20so2259667iop.11;
        Sat, 30 May 2020 06:30:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:cc:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=MKpioeUZcZVuMJ2yK8qMS0UnrJsjAOD0yQIMi7bNI+I=;
        b=jkgRu3hvnrQVwyqzQ8ox33kiwpJyN0t7p/vHvNdt1f7lV5C6hOVRJFIUVy5FCGUVEw
         UzUqPJERB9l/xyV36bvkawka+qmz4kWgoqXYvcmLS1itn+hc3V7lKbWZAFt3ZdPrpFf9
         HppO1qz3bbTzg98ynB4Et6mo3bS9jpk+vHb4EKnoj4Q5aDy8L43pgdRS7lKF6x/tsEah
         40axVjdNc21AhKlB25Qt8H2oTRJek7PjgKbCykk4yxsDODkG1Vvvl0AHyV6CclN4dxW1
         7lB4dq7TqLLC4fITnhf8+hPxgQKu7VFWRMbZevLNyCY8lMd1oKjT9SmSLMksNTcbdHzr
         vbBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:cc:date:message-id
         :in-reply-to:references:user-agent:mime-version
         :content-transfer-encoding;
        bh=MKpioeUZcZVuMJ2yK8qMS0UnrJsjAOD0yQIMi7bNI+I=;
        b=SPYpRCMhHhdtgDrIbgDjWpTLoclravK1knwlKDdKFEOHP0tydby9WpKeEFD3wzL55D
         Yt87v9hwe+Ty8+bvzRSzcxWn3cJYH7GT6E0n9daXnQ9FZT64QWfYyv6jL1PJoO/wHsFi
         8S0BQSn0723VOxCpAK3k1JBAZuAR9V3tj4ecxAWroKcHAFLwWmWRMAUdTMMeihmrgMcP
         BrHISNr5yomkwOhhFKXDgOgJY+tzcXrccB45p1omqieSfj2rkbyZqqkuRdspl+9Hwk0/
         z6R0w7yKrtCwrN4SXX26KJcm8Iw0STRo/HmMv5K5Y4Nzd8cnNQXdZnyvTn5FMxND1EPK
         Mnqw==
X-Gm-Message-State: AOAM533KLxlzfGrO9rOVC47QeYGNoaWNBXzC++5VCh7w2wxIbjULzG9j
        qEOF+Ngrn2Bl66HP7x9JeMculWKB
X-Google-Smtp-Source: ABdhPJyLAJnqtFkgVLvPdD9iVzYNxRj97W0Uybjcs8cWy7QCJXoko28zZAdVNlLesztWYzMPl6cycw==
X-Received: by 2002:a02:cce1:: with SMTP id l1mr11569396jaq.89.1590845449050;
        Sat, 30 May 2020 06:30:49 -0700 (PDT)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id t63sm3201593ill.54.2020.05.30.06.30.48
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 30 May 2020 06:30:48 -0700 (PDT)
Received: from klimt.1015granger.net (klimt.1015granger.net [192.168.1.55])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id 04UDUlIW001486;
        Sat, 30 May 2020 13:30:47 GMT
Subject: [PATCH v4 31/33] SUNRPC: Clean up request deferral tracepoints
From:   Chuck Lever <chuck.lever@oracle.com>
To:     bfields@fieldses.org
Cc:     linux-nfs@vger.kernel.org, linux-rdma@vger.kernel.org
Date:   Sat, 30 May 2020 09:30:47 -0400
Message-ID: <20200530133047.10117.81130.stgit@klimt.1015granger.net>
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
index e24a8b0cc4bc..dc8c6b4e1342 100644
--- a/include/trace/events/sunrpc.h
+++ b/include/trace/events/sunrpc.h
@@ -1425,27 +1425,32 @@ DECLARE_EVENT_CLASS(svc_deferred_event,
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
index 9a17ddfdabeb..54703d902c69 100644
--- a/net/sunrpc/svc_xprt.c
+++ b/net/sunrpc/svc_xprt.c
@@ -1146,16 +1146,15 @@ static void svc_revisit(struct cache_deferred_req *dreq, int too_many)
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
@@ -1201,22 +1200,24 @@ static struct cache_deferred_req *svc_defer(struct cache_req *req)
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
@@ -1247,7 +1248,6 @@ static struct svc_deferred_req *svc_deferred_dequeue(struct svc_xprt *xprt)
 				struct svc_deferred_req,
 				handle.recent);
 		list_del_init(&dr->handle.recent);
-		trace_svc_revisit_deferred(dr);
 	} else
 		clear_bit(XPT_DEFERRED, &xprt->xpt_flags);
 	spin_unlock(&xprt->xpt_lock);


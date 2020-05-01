Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 48AAA1C1B96
	for <lists+linux-nfs@lfdr.de>; Fri,  1 May 2020 19:22:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729025AbgEARWa (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 1 May 2020 13:22:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729018AbgEARWa (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 1 May 2020 13:22:30 -0400
Received: from mail-qt1-x841.google.com (mail-qt1-x841.google.com [IPv6:2607:f8b0:4864:20::841])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F702C061A0C
        for <linux-nfs@vger.kernel.org>; Fri,  1 May 2020 10:22:30 -0700 (PDT)
Received: by mail-qt1-x841.google.com with SMTP id v26so8468359qto.0
        for <linux-nfs@vger.kernel.org>; Fri, 01 May 2020 10:22:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=Xx6aePajrSChOzS2BStsb/09hbemezLlSo9xeJrjiQw=;
        b=V4Tpud/645pePoUfudBGF8Gh9cVSToRMz+ugg8TdDPbXqLcY9jCDB8iOyLCcgTqKjf
         EUC96H4l0aINXAI/MhYdjqNI53MBGc7U3UCPeTf/BIOENDeXIN9XSCXz4ipLht+/PqAM
         Vfmcmhh4oUobVxj/sznRqgInl0XUNOUmwhKlZfuv/L46VXiR728TBp6N+bdjcGgJw4TG
         XhXtO3mTxePL7hGGuZKovEmrr4p7BwmLwiVYFEyGh9apIEzi3WpFwfVwqgcf+dkny9Vq
         U4QFsIwiC/ddkpxznbHVnWzlw4bQ0CK3iuY8B/Cx+FB3yFFK1vUBJyHtuHC0266/CVwE
         dKsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:date:message-id
         :in-reply-to:references:user-agent:mime-version
         :content-transfer-encoding;
        bh=Xx6aePajrSChOzS2BStsb/09hbemezLlSo9xeJrjiQw=;
        b=LZfsxlOCHGUySVogXas9+r7wRxTj1jUhY8nH659Ht7pFu6ghJemPB1lTFAfP9DN/iw
         pkPxHHSUpmrZH20z7WRDBoBroopEwJITKkokV39iF8dStWPsIRtvJrjyU2ltPSGHH8uY
         Lu0uyy67fGp3nQ87qpJmMdIpfOU9PhI/r/BQ3HoW02k98Ncyv7Ozav+uWvTDtnt5ttpb
         08+xeNdiNaO8s1wmguQx2MnqY7JK2uafD4fx6v75DhCYkKdtyhEYJlwpaynC0gP5clUH
         vNeWto2f2POyYC+RcNFbuusq4b33VOo2uqF1RVXe1t04ZjwAfGEDW6LRxA3Wkj7nLIQY
         jMSg==
X-Gm-Message-State: AGi0PuaGWd0B4ANX/QdW4dgiLHwyqgt2RTVFp/0B4WlbsDedXRYWK0aB
        X/yEc0qC8oZ09xGo9nn6Y2jbB5Zm
X-Google-Smtp-Source: APiQypLxJgLtRFtpXmbe+ume4gVI2A2CS6m428uYqtG2OS1Qrju3C14Az7sixnVXRl1C4NYv/oKCHw==
X-Received: by 2002:ac8:3a83:: with SMTP id x3mr4747817qte.44.1588353749121;
        Fri, 01 May 2020 10:22:29 -0700 (PDT)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id g6sm3124808qtc.52.2020.05.01.10.22.28
        for <linux-nfs@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 01 May 2020 10:22:28 -0700 (PDT)
Received: from klimt.1015granger.net (klimt.1015granger.net [192.168.1.55])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id 041HMRoP026684
        for <linux-nfs@vger.kernel.org>; Fri, 1 May 2020 17:22:27 GMT
Subject: [PATCH v1 4/4] SUNRPC: Clean up request deferral tracepoints
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org
Date:   Fri, 01 May 2020 13:22:27 -0400
Message-ID: <20200501172227.3764.74938.stgit@klimt.1015granger.net>
In-Reply-To: <20200501171750.3764.7676.stgit@klimt.1015granger.net>
References: <20200501171750.3764.7676.stgit@klimt.1015granger.net>
User-Agent: StGit/0.22-20-geafe
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
index ffd2215950dc..3158b3f7e01e 100644
--- a/include/trace/events/sunrpc.h
+++ b/include/trace/events/sunrpc.h
@@ -1313,27 +1313,32 @@ DECLARE_EVENT_CLASS(svc_deferred_event,
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
 
 DECLARE_EVENT_CLASS(cache_event,
 	TP_PROTO(
diff --git a/net/sunrpc/svc_xprt.c b/net/sunrpc/svc_xprt.c
index 2284ff038dad..e12ec68cd0ff 100644
--- a/net/sunrpc/svc_xprt.c
+++ b/net/sunrpc/svc_xprt.c
@@ -1158,16 +1158,15 @@ static void svc_revisit(struct cache_deferred_req *dreq, int too_many)
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
@@ -1213,22 +1212,24 @@ static struct cache_deferred_req *svc_defer(struct cache_req *req)
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
@@ -1259,7 +1260,6 @@ static struct svc_deferred_req *svc_deferred_dequeue(struct svc_xprt *xprt)
 				struct svc_deferred_req,
 				handle.recent);
 		list_del_init(&dr->handle.recent);
-		trace_svc_revisit_deferred(dr);
 	} else
 		clear_bit(XPT_DEFERRED, &xprt->xpt_flags);
 	spin_unlock(&xprt->xpt_lock);


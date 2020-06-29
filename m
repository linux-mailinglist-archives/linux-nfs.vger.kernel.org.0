Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E15320E611
	for <lists+linux-nfs@lfdr.de>; Tue, 30 Jun 2020 00:08:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391433AbgF2VoL (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 29 Jun 2020 17:44:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727821AbgF2Shq (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 29 Jun 2020 14:37:46 -0400
Received: from mail-qv1-xf42.google.com (mail-qv1-xf42.google.com [IPv6:2607:f8b0:4864:20::f42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00AFEC02F02C;
        Mon, 29 Jun 2020 07:58:52 -0700 (PDT)
Received: by mail-qv1-xf42.google.com with SMTP id t11so5708440qvk.1;
        Mon, 29 Jun 2020 07:58:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=XGYBF9d0NMNgFRYH2j0kotT08cb3FOmrKANM3LBvM7A=;
        b=TeJDpamrf4akv3XbcConNYXcRmHpL4E4OUauv3drtbro1lw3sjZiiM88fcqZ18M5tG
         EMQ4KYvFuo4H63Y++RLprQDRWM1UOiWX2C/a0YbtEy5kEenNBFDOgPAzLqX50f88WhFO
         HF7gKaUkU1D+JE845nGYQCCFQFphwdBL9YKDpXIDKhi9kaBudWx1ymDEJTHrPyFGoEBM
         jNTo14yn2s3ZDMah9cha4eQ/p1LcYEDD3jlFIur7PhguVpZroUWjEVBv6fg5bEzaPa0w
         1bOOnJY8eWXwAYKowmbVJldQMXuqVVXZQzAtAkLqM8hLgYFnyXSvSJnXD888cD9kmStn
         V1AQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:date:message-id
         :in-reply-to:references:user-agent:mime-version
         :content-transfer-encoding;
        bh=XGYBF9d0NMNgFRYH2j0kotT08cb3FOmrKANM3LBvM7A=;
        b=TQvClnztfBedR8/DcX3to+S2V8fLX1OIWeVm+c+r6jroS+pyTrXXRerNQUWSg1Bml+
         CZVmn4dz8AdEoYXUwE5oIkRVZx85JenZIHFdIN8kmGXSrlrjOC8axlxe0iOc56Nr1CjN
         lP1lGmVx+JR64UTbNsxbI2GSFAzHLFuPFeZvgLsQX0GPCHkXMYoLXdEORcoONcxsRvZV
         WeOdRuqNgM8qnsAp9tZoAXHvA6cvLoh0Mk40T/Hb5L98Glhdp28q16WUlEZYNqc2P6sJ
         AtCvjhjslje7XPUYnswNnQCWtRTodqYopr5rN8drVf0ZuU4tc6AFwU5FKfRI7VEqQ2xC
         xIIw==
X-Gm-Message-State: AOAM531MadEL7Ia0mJ8wfd7NTTfNHDvB1Z5aazGL9Vopk2/aRZQPsVRo
        NiEj1NuxNxA80GfqKdXCEfT/YviA
X-Google-Smtp-Source: ABdhPJwj5cddcJE7MCLFuLFFNZFL2yyUsg7X7NxowUxx0RGpw6mOKx0bcasRWUxE/+92JuoNPy+IhA==
X-Received: by 2002:a0c:e710:: with SMTP id d16mr15970070qvn.158.1593442731072;
        Mon, 29 Jun 2020 07:58:51 -0700 (PDT)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id d19sm24418qko.114.2020.06.29.07.58.50
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 29 Jun 2020 07:58:50 -0700 (PDT)
Received: from klimt.1015granger.net (klimt.1015granger.net [192.168.1.55])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id 05TEwnBH006248;
        Mon, 29 Jun 2020 14:58:49 GMT
Subject: [PATCH v1 3/6] svcrdma: Record Receive completion ID in
 svc_rdma_decode_rqst
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org, linux-rdma@vger.kernel.org
Date:   Mon, 29 Jun 2020 10:58:49 -0400
Message-ID: <20200629145849.15100.44302.stgit@klimt.1015granger.net>
In-Reply-To: <20200629145528.15100.77805.stgit@klimt.1015granger.net>
References: <20200629145528.15100.77805.stgit@klimt.1015granger.net>
User-Agent: StGit/0.22-31-g4b47
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

When recording a trace event in the Receive path, tie decoding
results and errors to an incoming Receive completion.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 include/trace/events/rpcrdma.h          |   34 +++++++++++++++++++++++++------
 net/sunrpc/xprtrdma/svc_rdma_recvfrom.c |   12 +++++------
 2 files changed, 33 insertions(+), 13 deletions(-)

diff --git a/include/trace/events/rpcrdma.h b/include/trace/events/rpcrdma.h
index a0330a557e34..df49ae5d447b 100644
--- a/include/trace/events/rpcrdma.h
+++ b/include/trace/events/rpcrdma.h
@@ -1369,13 +1369,16 @@ TRACE_DEFINE_ENUM(RDMA_ERROR);
 
 TRACE_EVENT(svcrdma_decode_rqst,
 	TP_PROTO(
+		const struct svc_rdma_recv_ctxt *ctxt,
 		__be32 *p,
 		unsigned int hdrlen
 	),
 
-	TP_ARGS(p, hdrlen),
+	TP_ARGS(ctxt, p, hdrlen),
 
 	TP_STRUCT__entry(
+		__field(u32, cq_id)
+		__field(int, completion_id)
 		__field(u32, xid)
 		__field(u32, vers)
 		__field(u32, proc)
@@ -1384,6 +1387,8 @@ TRACE_EVENT(svcrdma_decode_rqst,
 	),
 
 	TP_fast_assign(
+		__entry->cq_id = ctxt->rc_cid.ci_queue_id;
+		__entry->completion_id = ctxt->rc_cid.ci_completion_id;
 		__entry->xid = be32_to_cpup(p++);
 		__entry->vers = be32_to_cpup(p++);
 		__entry->credits = be32_to_cpup(p++);
@@ -1391,37 +1396,48 @@ TRACE_EVENT(svcrdma_decode_rqst,
 		__entry->hdrlen = hdrlen;
 	),
 
-	TP_printk("xid=0x%08x vers=%u credits=%u proc=%s hdrlen=%u",
+	TP_printk("cq.id=%u cid=%d xid=0x%08x vers=%u credits=%u proc=%s hdrlen=%u",
+		__entry->cq_id, __entry->completion_id,
 		__entry->xid, __entry->vers, __entry->credits,
 		show_rpcrdma_proc(__entry->proc), __entry->hdrlen)
 );
 
 TRACE_EVENT(svcrdma_decode_short_err,
 	TP_PROTO(
+		const struct svc_rdma_recv_ctxt *ctxt,
 		unsigned int hdrlen
 	),
 
-	TP_ARGS(hdrlen),
+	TP_ARGS(ctxt, hdrlen),
 
 	TP_STRUCT__entry(
+		__field(u32, cq_id)
+		__field(int, completion_id)
 		__field(unsigned int, hdrlen)
 	),
 
 	TP_fast_assign(
+		__entry->cq_id = ctxt->rc_cid.ci_queue_id;
+		__entry->completion_id = ctxt->rc_cid.ci_completion_id;
 		__entry->hdrlen = hdrlen;
 	),
 
-	TP_printk("hdrlen=%u", __entry->hdrlen)
+	TP_printk("cq.id=%u cid=%d hdrlen=%u",
+		__entry->cq_id, __entry->completion_id,
+		__entry->hdrlen)
 );
 
 DECLARE_EVENT_CLASS(svcrdma_badreq_event,
 	TP_PROTO(
+		const struct svc_rdma_recv_ctxt *ctxt,
 		__be32 *p
 	),
 
-	TP_ARGS(p),
+	TP_ARGS(ctxt, p),
 
 	TP_STRUCT__entry(
+		__field(u32, cq_id)
+		__field(int, completion_id)
 		__field(u32, xid)
 		__field(u32, vers)
 		__field(u32, proc)
@@ -1429,13 +1445,16 @@ DECLARE_EVENT_CLASS(svcrdma_badreq_event,
 	),
 
 	TP_fast_assign(
+		__entry->cq_id = ctxt->rc_cid.ci_queue_id;
+		__entry->completion_id = ctxt->rc_cid.ci_completion_id;
 		__entry->xid = be32_to_cpup(p++);
 		__entry->vers = be32_to_cpup(p++);
 		__entry->credits = be32_to_cpup(p++);
 		__entry->proc = be32_to_cpup(p);
 	),
 
-	TP_printk("xid=0x%08x vers=%u credits=%u proc=%u",
+	TP_printk("cq.id=%u cid=%d xid=0x%08x vers=%u credits=%u proc=%u",
+		__entry->cq_id, __entry->completion_id,
 		__entry->xid, __entry->vers, __entry->credits, __entry->proc)
 );
 
@@ -1443,9 +1462,10 @@ DECLARE_EVENT_CLASS(svcrdma_badreq_event,
 		DEFINE_EVENT(svcrdma_badreq_event,			\
 			     svcrdma_decode_##name##_err,		\
 				TP_PROTO(				\
+					const struct svc_rdma_recv_ctxt *ctxt,	\
 					__be32 *p			\
 				),					\
-				TP_ARGS(p))
+				TP_ARGS(ctxt, p))
 
 DEFINE_BADREQ_EVENT(badvers);
 DEFINE_BADREQ_EVENT(drop);
diff --git a/net/sunrpc/xprtrdma/svc_rdma_recvfrom.c b/net/sunrpc/xprtrdma/svc_rdma_recvfrom.c
index e6d7401232d2..d5ec85cb652c 100644
--- a/net/sunrpc/xprtrdma/svc_rdma_recvfrom.c
+++ b/net/sunrpc/xprtrdma/svc_rdma_recvfrom.c
@@ -667,27 +667,27 @@ static int svc_rdma_xdr_decode_req(struct xdr_buf *rq_arg,
 	hdr_len = xdr_stream_pos(&rctxt->rc_stream);
 	rq_arg->head[0].iov_len -= hdr_len;
 	rq_arg->len -= hdr_len;
-	trace_svcrdma_decode_rqst(rdma_argp, hdr_len);
+	trace_svcrdma_decode_rqst(rctxt, rdma_argp, hdr_len);
 	return hdr_len;
 
 out_short:
-	trace_svcrdma_decode_short_err(rq_arg->len);
+	trace_svcrdma_decode_short_err(rctxt, rq_arg->len);
 	return -EINVAL;
 
 out_version:
-	trace_svcrdma_decode_badvers_err(rdma_argp);
+	trace_svcrdma_decode_badvers_err(rctxt, rdma_argp);
 	return -EPROTONOSUPPORT;
 
 out_drop:
-	trace_svcrdma_decode_drop_err(rdma_argp);
+	trace_svcrdma_decode_drop_err(rctxt, rdma_argp);
 	return 0;
 
 out_proc:
-	trace_svcrdma_decode_badproc_err(rdma_argp);
+	trace_svcrdma_decode_badproc_err(rctxt, rdma_argp);
 	return -EINVAL;
 
 out_inval:
-	trace_svcrdma_decode_parse_err(rdma_argp);
+	trace_svcrdma_decode_parse_err(rctxt, rdma_argp);
 	return -EINVAL;
 }
 


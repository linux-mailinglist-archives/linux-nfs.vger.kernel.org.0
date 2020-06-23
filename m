Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C357B2055AF
	for <lists+linux-nfs@lfdr.de>; Tue, 23 Jun 2020 17:19:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732913AbgFWPTc (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 23 Jun 2020 11:19:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732781AbgFWPTc (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 23 Jun 2020 11:19:32 -0400
Received: from mail-qv1-xf34.google.com (mail-qv1-xf34.google.com [IPv6:2607:f8b0:4864:20::f34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57263C061573
        for <linux-nfs@vger.kernel.org>; Tue, 23 Jun 2020 08:19:32 -0700 (PDT)
Received: by mail-qv1-xf34.google.com with SMTP id dp10so9794603qvb.10
        for <linux-nfs@vger.kernel.org>; Tue, 23 Jun 2020 08:19:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:date:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=aJP1shiNaDaZmFylB1TCScf/aFrofBjOwWcaEza9ias=;
        b=dnv9aynubLshLfUqOSw/uvbMTDVOfly7GLkmr3JI3FjmQtdxIjr0XODFMtEMYxaFD9
         cDSe0wGBfhbE4S8axeHwaIV9Jh0HwRIEuoZLRgBg82sT6VGoVdPhdfCvDuopXy53pnug
         8tJXjqKuJbQBVePPN4z5PNDLdQ2C1pUfpPHxxayFnJ0XsiN3Gae3cQmtTA/7gfqgkTeq
         Z8XxSgWbyomsXcLgK8dXARUqMxTGPBBdm4JxWllrim8kWHBbIWYbQ25GC4h315rFEHZ4
         Mrnw6VEwL5iIdhB7r8ErLus5R8dSwXEXUCil1L1I/DmW/yLuETkUrFOS3EdEIvEX6uTX
         7eRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:date:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=aJP1shiNaDaZmFylB1TCScf/aFrofBjOwWcaEza9ias=;
        b=IVd+gy7wlX/Pn4U8JU/LL+tK57Zo/NI5wS1SUM2B74flw0UCmbgtMhnx+4ju3ncIj2
         6dWdvt4o9XywRVmCgyXKVwg/I3V2JFjxnlEPFL4IYGYQHR5f59CwD/TZvuOiiA6HgUMo
         Xnai5iZHz3qGHvK15ocwlPl8yBEhSu4x911+f1VJ1ZePs9oMODBU2+KhFZtqssvNZxip
         hcK6keSHbZjkD3ugHvzJEWhP7eIb0pEjGCRrZlcJh00d2pPeKa7klZl52tPlH5tbQzfP
         aF6i/bMwjE56zdK4+QEBSVr7v55AHTldM11fo2I4Yy2DjFAWFYmFcqxDoCwZwAPGlZEK
         HG7A==
X-Gm-Message-State: AOAM530qvemV/SjCXvFW5jkBQ1C3pan8RWGOkQJccxQSPmSIzL+ZFea/
        FeEafTCAG+oFbjAqQwO9Z0AqCqiI
X-Google-Smtp-Source: ABdhPJz7geYuTi+7qR7QJff8Do8/V5ojzAKpK6+b35W7GafA7f/pw1DRPWQRZ+NPspZ/4fZKWECmiQ==
X-Received: by 2002:a0c:e941:: with SMTP id n1mr27252323qvo.105.1592925570651;
        Tue, 23 Jun 2020 08:19:30 -0700 (PDT)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id s52sm926547qtj.52.2020.06.23.08.19.30
        for <linux-nfs@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 23 Jun 2020 08:19:30 -0700 (PDT)
Received: from klimt.1015granger.net (klimt.1015granger.net [192.168.1.55])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id 05NFJSDh021674
        for <linux-nfs@vger.kernel.org>; Tue, 23 Jun 2020 15:19:28 GMT
Subject: [PATCH v2] SUNRPC: Augment server-side rpcgss tracepoints
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org
Date:   Tue, 23 Jun 2020 11:19:28 -0400
Message-ID: <20200623151754.4995.83489.stgit@klimt.1015granger.net>
User-Agent: StGit/0.22-31-g4b47
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Add similar tracepoints to those that were recently added on the
client side to track failures in the integ and priv unwrap paths.

And, let's collect the seqno-specific tracepoints together with a
common naming convention.

Regarding the gss_check_seq_num() changes: everywhere else treats
the GSS sequence number as an unsigned 32-bit integer. As far back
as 2.6.12, I couldn't find a compelling reason to do things
differently here. As a defensive change it's better to eliminate
needless implicit sign conversions.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
Changes since v1:
- Address a smatch "uninitialized symbol" warning

 include/trace/events/rpcgss.h     |  168 +++++++++++++++++++++++++++++++------
 net/sunrpc/auth_gss/svcauth_gss.c |  117 +++++++++++++++++---------
 net/sunrpc/auth_gss/trace.c       |    3 +
 3 files changed, 224 insertions(+), 64 deletions(-)

diff --git a/include/trace/events/rpcgss.h b/include/trace/events/rpcgss.h
index b9b51a4b1db1..ffdbe6f85da8 100644
--- a/include/trace/events/rpcgss.h
+++ b/include/trace/events/rpcgss.h
@@ -170,55 +170,144 @@ DECLARE_EVENT_CLASS(rpcgss_ctx_class,
 DEFINE_CTX_EVENT(init);
 DEFINE_CTX_EVENT(destroy);
 
+DECLARE_EVENT_CLASS(rpcgss_svc_gssapi_class,
+	TP_PROTO(
+		const struct svc_rqst *rqstp,
+		u32 maj_stat
+	),
+
+	TP_ARGS(rqstp, maj_stat),
+
+	TP_STRUCT__entry(
+		__field(u32, xid)
+		__field(u32, maj_stat)
+		__string(addr, rqstp->rq_xprt->xpt_remotebuf)
+	),
+
+	TP_fast_assign(
+		__entry->xid = __be32_to_cpu(rqstp->rq_xid);
+		__entry->maj_stat = maj_stat;
+		__assign_str(addr, rqstp->rq_xprt->xpt_remotebuf);
+	),
+
+	TP_printk("addr=%s xid=0x%08x maj_stat=%s",
+		__get_str(addr), __entry->xid,
+		__entry->maj_stat == 0 ?
+		"GSS_S_COMPLETE" : show_gss_status(__entry->maj_stat))
+);
+
+#define DEFINE_SVC_GSSAPI_EVENT(name)					\
+	DEFINE_EVENT(rpcgss_svc_gssapi_class, rpcgss_svc_##name,	\
+			TP_PROTO(					\
+				const struct svc_rqst *rqstp,		\
+				u32 maj_stat				\
+			),						\
+			TP_ARGS(rqstp, maj_stat))
+
+DEFINE_SVC_GSSAPI_EVENT(unwrap);
+DEFINE_SVC_GSSAPI_EVENT(mic);
+
+TRACE_EVENT(rpcgss_svc_unwrap_failed,
+	TP_PROTO(
+		const struct svc_rqst *rqstp
+	),
+
+	TP_ARGS(rqstp),
+
+	TP_STRUCT__entry(
+		__field(u32, xid)
+		__string(addr, rqstp->rq_xprt->xpt_remotebuf)
+	),
+
+	TP_fast_assign(
+		__entry->xid = be32_to_cpu(rqstp->rq_xid);
+		__assign_str(addr, rqstp->rq_xprt->xpt_remotebuf);
+	),
+
+	TP_printk("addr=%s xid=0x%08x", __get_str(addr), __entry->xid)
+);
+
+TRACE_EVENT(rpcgss_svc_seqno_bad,
+	TP_PROTO(
+		const struct svc_rqst *rqstp,
+		u32 expected,
+		u32 received
+	),
+
+	TP_ARGS(rqstp, expected, received),
+
+	TP_STRUCT__entry(
+		__field(u32, expected)
+		__field(u32, received)
+		__field(u32, xid)
+		__string(addr, rqstp->rq_xprt->xpt_remotebuf)
+	),
+
+	TP_fast_assign(
+		__entry->expected = expected;
+		__entry->received = received;
+		__entry->xid = __be32_to_cpu(rqstp->rq_xid);
+		__assign_str(addr, rqstp->rq_xprt->xpt_remotebuf);
+	),
+
+	TP_printk("addr=%s xid=0x%08x expected seqno %u, received seqno %u",
+		__get_str(addr), __entry->xid,
+		__entry->expected, __entry->received)
+);
+
 TRACE_EVENT(rpcgss_svc_accept_upcall,
 	TP_PROTO(
-		__be32 xid,
+		const struct svc_rqst *rqstp,
 		u32 major_status,
 		u32 minor_status
 	),
 
-	TP_ARGS(xid, major_status, minor_status),
+	TP_ARGS(rqstp, major_status, minor_status),
 
 	TP_STRUCT__entry(
-		__field(u32, xid)
 		__field(u32, minor_status)
 		__field(unsigned long, major_status)
+		__field(u32, xid)
+		__string(addr, rqstp->rq_xprt->xpt_remotebuf)
 	),
 
 	TP_fast_assign(
-		__entry->xid = be32_to_cpu(xid);
 		__entry->minor_status = minor_status;
 		__entry->major_status = major_status;
+		__entry->xid = be32_to_cpu(rqstp->rq_xid);
+		__assign_str(addr, rqstp->rq_xprt->xpt_remotebuf);
 	),
 
-	TP_printk("xid=0x%08x major_status=%s (0x%08lx) minor_status=%u",
-		__entry->xid, __entry->major_status == 0 ? "GSS_S_COMPLETE" :
-				show_gss_status(__entry->major_status),
+	TP_printk("addr=%s xid=0x%08x major_status=%s (0x%08lx) minor_status=%u",
+		__get_str(addr), __entry->xid,
+		(__entry->major_status == 0) ? "GSS_S_COMPLETE" :
+			show_gss_status(__entry->major_status),
 		__entry->major_status, __entry->minor_status
 	)
 );
 
-TRACE_EVENT(rpcgss_svc_accept,
+TRACE_EVENT(rpcgss_svc_authenticate,
 	TP_PROTO(
-		__be32 xid,
-		size_t len
+		const struct svc_rqst *rqstp,
+		const struct rpc_gss_wire_cred *gc
 	),
 
-	TP_ARGS(xid, len),
+	TP_ARGS(rqstp, gc),
 
 	TP_STRUCT__entry(
+		__field(u32, seqno)
 		__field(u32, xid)
-		__field(size_t, len)
+		__string(addr, rqstp->rq_xprt->xpt_remotebuf)
 	),
 
 	TP_fast_assign(
-		__entry->xid = be32_to_cpu(xid);
-		__entry->len = len;
+		__entry->xid = be32_to_cpu(rqstp->rq_xid);
+		__entry->seqno = gc->gc_seq;
+		__assign_str(addr, rqstp->rq_xprt->xpt_remotebuf);
 	),
 
-	TP_printk("xid=0x%08x len=%zu",
-		__entry->xid, __entry->len
-	)
+	TP_printk("addr=%s xid=0x%08x seqno=%u", __get_str(addr),
+		__entry->xid, __entry->seqno)
 );
 
 
@@ -371,11 +460,11 @@ TRACE_EVENT(rpcgss_update_slack,
 
 DECLARE_EVENT_CLASS(rpcgss_svc_seqno_class,
 	TP_PROTO(
-		__be32 xid,
+		const struct svc_rqst *rqstp,
 		u32 seqno
 	),
 
-	TP_ARGS(xid, seqno),
+	TP_ARGS(rqstp, seqno),
 
 	TP_STRUCT__entry(
 		__field(u32, xid)
@@ -383,25 +472,52 @@ DECLARE_EVENT_CLASS(rpcgss_svc_seqno_class,
 	),
 
 	TP_fast_assign(
-		__entry->xid = be32_to_cpu(xid);
+		__entry->xid = be32_to_cpu(rqstp->rq_xid);
 		__entry->seqno = seqno;
 	),
 
-	TP_printk("xid=0x%08x seqno=%u, request discarded",
+	TP_printk("xid=0x%08x seqno=%u",
 		__entry->xid, __entry->seqno)
 );
 
 #define DEFINE_SVC_SEQNO_EVENT(name)					\
-	DEFINE_EVENT(rpcgss_svc_seqno_class, rpcgss_svc_##name,		\
+	DEFINE_EVENT(rpcgss_svc_seqno_class, rpcgss_svc_seqno_##name,	\
 			TP_PROTO(					\
-				__be32 xid,				\
+				const struct svc_rqst *rqstp,		\
 				u32 seqno				\
 			),						\
-			TP_ARGS(xid, seqno))
+			TP_ARGS(rqstp, seqno))
 
-DEFINE_SVC_SEQNO_EVENT(large_seqno);
-DEFINE_SVC_SEQNO_EVENT(old_seqno);
+DEFINE_SVC_SEQNO_EVENT(large);
+DEFINE_SVC_SEQNO_EVENT(seen);
 
+TRACE_EVENT(rpcgss_svc_seqno_low,
+	TP_PROTO(
+		const struct svc_rqst *rqstp,
+		u32 seqno,
+		u32 min,
+		u32 max
+	),
+
+	TP_ARGS(rqstp, seqno, min, max),
+
+	TP_STRUCT__entry(
+		__field(u32, xid)
+		__field(u32, seqno)
+		__field(u32, min)
+		__field(u32, max)
+	),
+
+	TP_fast_assign(
+		__entry->xid = be32_to_cpu(rqstp->rq_xid);
+		__entry->seqno = seqno;
+		__entry->min = min;
+		__entry->max = max;
+	),
+
+	TP_printk("xid=0x%08x seqno=%u window=[%u..%u]",
+		__entry->xid, __entry->seqno, __entry->min, __entry->max)
+);
 
 /**
  ** gssd upcall related trace events
diff --git a/net/sunrpc/auth_gss/svcauth_gss.c b/net/sunrpc/auth_gss/svcauth_gss.c
index 46027d0c903f..7d83f54aaaa6 100644
--- a/net/sunrpc/auth_gss/svcauth_gss.c
+++ b/net/sunrpc/auth_gss/svcauth_gss.c
@@ -332,7 +332,7 @@ static struct rsi *rsi_update(struct cache_detail *cd, struct rsi *new, struct r
 
 struct gss_svc_seq_data {
 	/* highest seq number seen so far: */
-	int			sd_max;
+	u32			sd_max;
 	/* for i such that sd_max-GSS_SEQ_WIN < i <= sd_max, the i-th bit of
 	 * sd_win is nonzero iff sequence number i has been seen already: */
 	unsigned long		sd_win[GSS_SEQ_WIN/BITS_PER_LONG];
@@ -613,16 +613,29 @@ gss_svc_searchbyctx(struct cache_detail *cd, struct xdr_netobj *handle)
 	return found;
 }
 
-/* Implements sequence number algorithm as specified in RFC 2203. */
-static int
-gss_check_seq_num(struct rsc *rsci, int seq_num)
+/**
+ * gss_check_seq_num - GSS sequence number window check
+ * @rqstp: RPC Call to use when reporting errors
+ * @rsci: cached GSS context state (updated on return)
+ * @seq_num: sequence number to check
+ *
+ * Implements sequence number algorithm as specified in
+ * RFC 2203, Section 5.3.3.1. "Context Management".
+ *
+ * Return values:
+ *   %true: @rqstp's GSS sequence number is inside the window
+ *   %false: @rqstp's GSS sequence number is outside the window
+ */
+static bool gss_check_seq_num(const struct svc_rqst *rqstp, struct rsc *rsci,
+			      u32 seq_num)
 {
 	struct gss_svc_seq_data *sd = &rsci->seqdata;
+	bool result = false;
 
 	spin_lock(&sd->sd_lock);
 	if (seq_num > sd->sd_max) {
 		if (seq_num >= sd->sd_max + GSS_SEQ_WIN) {
-			memset(sd->sd_win,0,sizeof(sd->sd_win));
+			memset(sd->sd_win, 0, sizeof(sd->sd_win));
 			sd->sd_max = seq_num;
 		} else while (sd->sd_max < seq_num) {
 			sd->sd_max++;
@@ -631,17 +644,25 @@ gss_check_seq_num(struct rsc *rsci, int seq_num)
 		__set_bit(seq_num % GSS_SEQ_WIN, sd->sd_win);
 		goto ok;
 	} else if (seq_num <= sd->sd_max - GSS_SEQ_WIN) {
-		goto drop;
+		goto toolow;
 	}
-	/* sd_max - GSS_SEQ_WIN < seq_num <= sd_max */
 	if (__test_and_set_bit(seq_num % GSS_SEQ_WIN, sd->sd_win))
-		goto drop;
+		goto alreadyseen;
+
 ok:
+	result = true;
+out:
 	spin_unlock(&sd->sd_lock);
-	return 1;
-drop:
-	spin_unlock(&sd->sd_lock);
-	return 0;
+	return result;
+
+toolow:
+	trace_rpcgss_svc_seqno_low(rqstp, seq_num,
+				   sd->sd_max - GSS_SEQ_WIN,
+				   sd->sd_max);
+	goto out;
+alreadyseen:
+	trace_rpcgss_svc_seqno_seen(rqstp, seq_num);
+	goto out;
 }
 
 static inline u32 round_up_to_quad(u32 i)
@@ -721,14 +742,12 @@ gss_verify_header(struct svc_rqst *rqstp, struct rsc *rsci,
 	}
 
 	if (gc->gc_seq > MAXSEQ) {
-		trace_rpcgss_svc_large_seqno(rqstp->rq_xid, gc->gc_seq);
+		trace_rpcgss_svc_seqno_large(rqstp, gc->gc_seq);
 		*authp = rpcsec_gsserr_ctxproblem;
 		return SVC_DENIED;
 	}
-	if (!gss_check_seq_num(rsci, gc->gc_seq)) {
-		trace_rpcgss_svc_old_seqno(rqstp->rq_xid, gc->gc_seq);
+	if (!gss_check_seq_num(rqstp, rsci, gc->gc_seq))
 		return SVC_DROP;
-	}
 	return SVC_OK;
 }
 
@@ -866,11 +885,13 @@ read_u32_from_xdr_buf(struct xdr_buf *buf, int base, u32 *obj)
 static int
 unwrap_integ_data(struct svc_rqst *rqstp, struct xdr_buf *buf, u32 seq, struct gss_ctx *ctx)
 {
+	u32 integ_len, rseqno, maj_stat;
 	int stat = -EINVAL;
-	u32 integ_len, maj_stat;
 	struct xdr_netobj mic;
 	struct xdr_buf integ_buf;
 
+	mic.data = NULL;
+
 	/* NFS READ normally uses splice to send data in-place. However
 	 * the data in cache can change after the reply's MIC is computed
 	 * but before the RPC reply is sent. To prevent the client from
@@ -885,34 +906,44 @@ unwrap_integ_data(struct svc_rqst *rqstp, struct xdr_buf *buf, u32 seq, struct g
 
 	integ_len = svc_getnl(&buf->head[0]);
 	if (integ_len & 3)
-		return stat;
+		goto unwrap_failed;
 	if (integ_len > buf->len)
-		return stat;
-	if (xdr_buf_subsegment(buf, &integ_buf, 0, integ_len)) {
-		WARN_ON_ONCE(1);
-		return stat;
-	}
+		goto unwrap_failed;
+	if (xdr_buf_subsegment(buf, &integ_buf, 0, integ_len))
+		goto unwrap_failed;
+
 	/* copy out mic... */
 	if (read_u32_from_xdr_buf(buf, integ_len, &mic.len))
-		return stat;
+		goto unwrap_failed;
 	if (mic.len > RPC_MAX_AUTH_SIZE)
-		return stat;
+		goto unwrap_failed;
 	mic.data = kmalloc(mic.len, GFP_KERNEL);
 	if (!mic.data)
-		return stat;
+		goto unwrap_failed;
 	if (read_bytes_from_xdr_buf(buf, integ_len + 4, mic.data, mic.len))
-		goto out;
+		goto unwrap_failed;
 	maj_stat = gss_verify_mic(ctx, &integ_buf, &mic);
 	if (maj_stat != GSS_S_COMPLETE)
-		goto out;
-	if (svc_getnl(&buf->head[0]) != seq)
-		goto out;
+		goto bad_mic;
+	rseqno = svc_getnl(&buf->head[0]);
+	if (rseqno != seq)
+		goto bad_seqno;
 	/* trim off the mic and padding at the end before returning */
 	xdr_buf_trim(buf, round_up_to_quad(mic.len) + 4);
 	stat = 0;
 out:
 	kfree(mic.data);
 	return stat;
+
+unwrap_failed:
+	trace_rpcgss_svc_unwrap_failed(rqstp);
+	goto out;
+bad_seqno:
+	trace_rpcgss_svc_seqno_bad(rqstp, seq, rseqno);
+	goto out;
+bad_mic:
+	trace_rpcgss_svc_mic(rqstp, maj_stat);
+	goto out;
 }
 
 static inline int
@@ -937,6 +968,7 @@ unwrap_priv_data(struct svc_rqst *rqstp, struct xdr_buf *buf, u32 seq, struct gs
 {
 	u32 priv_len, maj_stat;
 	int pad, remaining_len, offset;
+	u32 rseqno;
 
 	clear_bit(RQ_SPLICE_OK, &rqstp->rq_flags);
 
@@ -951,7 +983,7 @@ unwrap_priv_data(struct svc_rqst *rqstp, struct xdr_buf *buf, u32 seq, struct gs
 	 * not yet read from the head, so these two values are different: */
 	remaining_len = total_buf_len(buf);
 	if (priv_len > remaining_len)
-		return -EINVAL;
+		goto unwrap_failed;
 	pad = remaining_len - priv_len;
 	buf->len -= pad;
 	fix_priv_head(buf, pad);
@@ -972,11 +1004,22 @@ unwrap_priv_data(struct svc_rqst *rqstp, struct xdr_buf *buf, u32 seq, struct gs
 		fix_priv_head(buf, pad);
 	}
 	if (maj_stat != GSS_S_COMPLETE)
-		return -EINVAL;
+		goto bad_unwrap;
 out_seq:
-	if (svc_getnl(&buf->head[0]) != seq)
-		return -EINVAL;
+	rseqno = svc_getnl(&buf->head[0]);
+	if (rseqno != seq)
+		goto bad_seqno;
 	return 0;
+
+unwrap_failed:
+	trace_rpcgss_svc_unwrap_failed(rqstp);
+	return -EINVAL;
+bad_seqno:
+	trace_rpcgss_svc_seqno_bad(rqstp, seq, rseqno);
+	return -EINVAL;
+bad_unwrap:
+	trace_rpcgss_svc_unwrap(rqstp, maj_stat);
+	return -EINVAL;
 }
 
 struct gss_svc_data {
@@ -1314,8 +1357,7 @@ static int svcauth_gss_proxy_init(struct svc_rqst *rqstp,
 	if (status)
 		goto out;
 
-	trace_rpcgss_svc_accept_upcall(rqstp->rq_xid, ud.major_status,
-				       ud.minor_status);
+	trace_rpcgss_svc_accept_upcall(rqstp, ud.major_status, ud.minor_status);
 
 	switch (ud.major_status) {
 	case GSS_S_CONTINUE_NEEDED:
@@ -1490,8 +1532,6 @@ svcauth_gss_accept(struct svc_rqst *rqstp, __be32 *authp)
 	int		ret;
 	struct sunrpc_net *sn = net_generic(SVC_NET(rqstp), sunrpc_net_id);
 
-	trace_rpcgss_svc_accept(rqstp->rq_xid, argv->iov_len);
-
 	*authp = rpc_autherr_badcred;
 	if (!svcdata)
 		svcdata = kmalloc(sizeof(*svcdata), GFP_KERNEL);
@@ -1608,6 +1648,7 @@ svcauth_gss_accept(struct svc_rqst *rqstp, __be32 *authp)
 					GSS_C_QOP_DEFAULT,
 					gc->gc_svc);
 		ret = SVC_OK;
+		trace_rpcgss_svc_authenticate(rqstp, gc);
 		goto out;
 	}
 garbage_args:
diff --git a/net/sunrpc/auth_gss/trace.c b/net/sunrpc/auth_gss/trace.c
index 49fa583d7f91..d26036a57443 100644
--- a/net/sunrpc/auth_gss/trace.c
+++ b/net/sunrpc/auth_gss/trace.c
@@ -5,6 +5,9 @@
 
 #include <linux/sunrpc/clnt.h>
 #include <linux/sunrpc/sched.h>
+#include <linux/sunrpc/svc.h>
+#include <linux/sunrpc/svc_xprt.h>
+#include <linux/sunrpc/auth_gss.h>
 #include <linux/sunrpc/gss_err.h>
 #include <linux/sunrpc/auth_gss.h>
 


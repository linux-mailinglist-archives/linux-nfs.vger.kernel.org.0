Return-Path: <linux-nfs+bounces-10692-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B312A695BF
	for <lists+linux-nfs@lfdr.de>; Wed, 19 Mar 2025 18:05:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 51CC48A13F9
	for <lists+linux-nfs@lfdr.de>; Wed, 19 Mar 2025 17:03:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C61951FC7D9;
	Wed, 19 Mar 2025 17:03:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QGiVpRW0"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 940E31F0988;
	Wed, 19 Mar 2025 17:03:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742403795; cv=none; b=pXIcGhHlB+vwzpSfqp4eMbot1Kgrx4sCukA1T7F+/HHeaM9IkL1i3YLCaMP5z6grjcdaT6xVDkl5sHmOTPCbX5XACxxYpqbHUJ6DJmU9NfX9ERaxjmZW3gn3Df92V+JhklnBp2jBY555470UbwCvxpwYY/80ATNGSUc2n5j9xM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742403795; c=relaxed/simple;
	bh=piqvvSFhPTUeHNVZEppHC6lSuIoy/6aG/BL2sFc+4uI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=WX3xIXLPhD1G5hqFfqEL3Cp2/7DG5QrgV3COXwNCPElModliRalpaARZxmb1UX6CRHKO0Yfdp4PSKrfnbpS+/ct+OFF7JjW9lx+/19TK7DO1iFQyODU9gdGhEZwM8jy6rpytkD0qG+Sl+vxeiIx6CWCmuU7XZwE4nrWynTPjF2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QGiVpRW0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 08AB2C4CEE9;
	Wed, 19 Mar 2025 17:03:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742403795;
	bh=piqvvSFhPTUeHNVZEppHC6lSuIoy/6aG/BL2sFc+4uI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=QGiVpRW0B4NW9GlmltLDnvYuybsachrQD2Gvbem5RA9cTQ1AMceKGE2g3rIjhv60G
	 RzKa8JE1UvzPp8pVaAZYeC3jprU10iixrx3qkmLvYbNJEDPaTgl53X+ua8qY/O2NBf
	 HKDJUq+iy7MtKs708vvI0KSD5vzXIorWdFUDzDTXqMmn5e+yY0lpBPIeL4L6atkc4r
	 7VUEiXvolOng7sUPAAmx7vIc49xhKsiUJH/ia7JeEr3VuavLnpxPqS1I7Dq3U+xwlk
	 t4aulvyuKbd0na3BM7vgG5W1tcWyNzqCO99+ist3yUIkzSv2KCyOewlGeUCksTYGiJ
	 6PjXwM5YLKYpA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED11DC36000;
	Wed, 19 Mar 2025 17:03:14 +0000 (UTC)
From: Nikhil Jha via B4 Relay <devnull+njha.janestreet.com@kernel.org>
Date: Wed, 19 Mar 2025 13:02:39 -0400
Subject: [PATCH v2 1/2] sunrpc: implement rfc2203 rpcsec_gss seqnum cache
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250319-rfc2203-seqnum-cache-v2-1-2c98b859f2dd@janestreet.com>
References: <20250319-rfc2203-seqnum-cache-v2-0-2c98b859f2dd@janestreet.com>
In-Reply-To: <20250319-rfc2203-seqnum-cache-v2-0-2c98b859f2dd@janestreet.com>
To: Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>, 
 Chuck Lever <chuck.lever@oracle.com>, Jeff Layton <jlayton@kernel.org>, 
 Neil Brown <neilb@suse.de>, Olga Kornievskaia <okorniev@redhat.com>, 
 Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, Steven Rostedt <rostedt@goodmis.org>, 
 Masami Hiramatsu <mhiramat@kernel.org>, 
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
 netdev@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
 Nikhil Jha <njha@janestreet.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1742403794; l=11122;
 i=njha@janestreet.com; s=20250314; h=from:subject:message-id;
 bh=wnNrKiNzXXoyX4j3lxcMJOW3I2Fvt7gwTBW4nuDAdVo=;
 b=h/EXiI1s+SIj7RWtUnZKeIe2aa3haJ3Gs0Vt5M2OCmUrcdlMip0Yw4MLDE1vwDau0DPQwiRen
 Y4axgXdzRugDIctQbvkOih3ernKyN20DZGHLTitXejACpxAV0A8PliS
X-Developer-Key: i=njha@janestreet.com; a=ed25519;
 pk=92gWYi0ImmcatlW+pFEFh9viqpRf/PE8phYeWuNeGaA=
X-Endpoint-Received: by B4 Relay for njha@janestreet.com/20250314 with
 auth_id=360
X-Original-From: Nikhil Jha <njha@janestreet.com>
Reply-To: njha@janestreet.com

From: Nikhil Jha <njha@janestreet.com>

This implements a sequence number cache of the last three (right now
hardcoded) sent sequence numbers for a given XID, as suggested by the
RFC.

From RFC2203 5.3.3.1:

"Note that the sequence number algorithm requires that the client
increment the sequence number even if it is retrying a request with
the same RPC transaction identifier.  It is not infrequent for
clients to get into a situation where they send two or more attempts
and a slow server sends the reply for the first attempt. With
RPCSEC_GSS, each request and reply will have a unique sequence
number. If the client wishes to improve turn around time on the RPC
call, it can cache the RPCSEC_GSS sequence number of each request it
sends. Then when it receives a response with a matching RPC
transaction identifier, it can compute the checksum of each sequence
number in the cache to try to match the checksum in the reply's
verifier."

Signed-off-by: Nikhil Jha <njha@janestreet.com>
---
 include/linux/sunrpc/xprt.h    | 17 +++++++++++-
 include/trace/events/rpcgss.h  |  4 +--
 include/trace/events/sunrpc.h  |  2 +-
 net/sunrpc/auth_gss/auth_gss.c | 59 ++++++++++++++++++++++++++----------------
 net/sunrpc/xprt.c              |  3 ++-
 5 files changed, 57 insertions(+), 28 deletions(-)

diff --git a/include/linux/sunrpc/xprt.h b/include/linux/sunrpc/xprt.h
index 81b952649d35e3ad4fa8c7e77388ac2ceb44ce60..f46d1fb8f71ae22233f15691b2cf312f73656d9d 100644
--- a/include/linux/sunrpc/xprt.h
+++ b/include/linux/sunrpc/xprt.h
@@ -30,6 +30,8 @@
 #define RPC_MAXCWND(xprt)	((xprt)->max_reqs << RPC_CWNDSHIFT)
 #define RPCXPRT_CONGESTED(xprt) ((xprt)->cong >= (xprt)->cwnd)
 
+#define RPC_GSS_SEQNO_ARRAY_SIZE 3U
+
 enum rpc_display_format_t {
 	RPC_DISPLAY_ADDR = 0,
 	RPC_DISPLAY_PORT,
@@ -66,7 +68,8 @@ struct rpc_rqst {
 	struct rpc_cred *	rq_cred;	/* Bound cred */
 	__be32			rq_xid;		/* request XID */
 	int			rq_cong;	/* has incremented xprt->cong */
-	u32			rq_seqno;	/* gss seq no. used on req. */
+	u32			rq_seqnos[RPC_GSS_SEQNO_ARRAY_SIZE];	/* past gss req seq nos. */
+	unsigned int		rq_seqno_count;	/* number of entries in rq_seqnos */
 	int			rq_enc_pages_num;
 	struct page		**rq_enc_pages;	/* scratch pages for use by
 						   gss privacy code */
@@ -119,6 +122,18 @@ struct rpc_rqst {
 #define rq_svec			rq_snd_buf.head
 #define rq_slen			rq_snd_buf.len
 
+static inline int xprt_rqst_add_seqno(struct rpc_rqst *req, u32 seqno)
+{
+	if (likely(req->rq_seqno_count < RPC_GSS_SEQNO_ARRAY_SIZE))
+		req->rq_seqno_count++;
+
+	/* Shift array to make room for the newest element at the beginning */
+	memmove(&req->rq_seqnos[1], &req->rq_seqnos[0],
+		(RPC_GSS_SEQNO_ARRAY_SIZE - 1) * sizeof(req->rq_seqnos[0]));
+	req->rq_seqnos[0] = seqno;
+	return 0;
+}
+
 /* RPC transport layer security policies */
 enum xprtsec_policies {
 	RPC_XPRTSEC_NONE = 0,
diff --git a/include/trace/events/rpcgss.h b/include/trace/events/rpcgss.h
index b0b6300a0cabdbaf1c08460a474aaf092b548e53..8aeae06cf434d05547b4cffb14f01901cfba4142 100644
--- a/include/trace/events/rpcgss.h
+++ b/include/trace/events/rpcgss.h
@@ -409,7 +409,7 @@ TRACE_EVENT(rpcgss_seqno,
 		__entry->task_id = task->tk_pid;
 		__entry->client_id = task->tk_client->cl_clid;
 		__entry->xid = be32_to_cpu(rqst->rq_xid);
-		__entry->seqno = rqst->rq_seqno;
+		__entry->seqno = *rqst->rq_seqnos;
 	),
 
 	TP_printk(SUNRPC_TRACE_TASK_SPECIFIER " xid=0x%08x seqno=%u",
@@ -440,7 +440,7 @@ TRACE_EVENT(rpcgss_need_reencode,
 		__entry->client_id = task->tk_client->cl_clid;
 		__entry->xid = be32_to_cpu(task->tk_rqstp->rq_xid);
 		__entry->seq_xmit = seq_xmit;
-		__entry->seqno = task->tk_rqstp->rq_seqno;
+		__entry->seqno = *task->tk_rqstp->rq_seqnos;
 		__entry->ret = ret;
 	),
 
diff --git a/include/trace/events/sunrpc.h b/include/trace/events/sunrpc.h
index 851841336ee65c1d03fc3565a96f5dbe409c1d64..bb01a0ca93aa72a310146bba97ca58b851a85653 100644
--- a/include/trace/events/sunrpc.h
+++ b/include/trace/events/sunrpc.h
@@ -1099,7 +1099,7 @@ TRACE_EVENT(xprt_transmit,
 		__entry->client_id = rqst->rq_task->tk_client ?
 			rqst->rq_task->tk_client->cl_clid : -1;
 		__entry->xid = be32_to_cpu(rqst->rq_xid);
-		__entry->seqno = rqst->rq_seqno;
+		__entry->seqno = *rqst->rq_seqnos;
 		__entry->status = status;
 	),
 
diff --git a/net/sunrpc/auth_gss/auth_gss.c b/net/sunrpc/auth_gss/auth_gss.c
index 369310909fc98596c8a06db8ac3c976a719ca7b2..0fa244f16876f3c434fd507b4d53c5eefd748ce4 100644
--- a/net/sunrpc/auth_gss/auth_gss.c
+++ b/net/sunrpc/auth_gss/auth_gss.c
@@ -1545,6 +1545,7 @@ static int gss_marshal(struct rpc_task *task, struct xdr_stream *xdr)
 	struct kvec	iov;
 	struct xdr_buf	verf_buf;
 	int status;
+	u32 seqno;
 
 	/* Credential */
 
@@ -1556,15 +1557,16 @@ static int gss_marshal(struct rpc_task *task, struct xdr_stream *xdr)
 	cred_len = p++;
 
 	spin_lock(&ctx->gc_seq_lock);
-	req->rq_seqno = (ctx->gc_seq < MAXSEQ) ? ctx->gc_seq++ : MAXSEQ;
+	seqno = (ctx->gc_seq < MAXSEQ) ? ctx->gc_seq++ : MAXSEQ;
+	xprt_rqst_add_seqno(req, seqno);
 	spin_unlock(&ctx->gc_seq_lock);
-	if (req->rq_seqno == MAXSEQ)
+	if (*req->rq_seqnos == MAXSEQ)
 		goto expired;
 	trace_rpcgss_seqno(task);
 
 	*p++ = cpu_to_be32(RPC_GSS_VERSION);
 	*p++ = cpu_to_be32(ctx->gc_proc);
-	*p++ = cpu_to_be32(req->rq_seqno);
+	*p++ = cpu_to_be32(*req->rq_seqnos);
 	*p++ = cpu_to_be32(gss_cred->gc_service);
 	p = xdr_encode_netobj(p, &ctx->gc_wire_ctx);
 	*cred_len = cpu_to_be32((p - (cred_len + 1)) << 2);
@@ -1678,17 +1680,31 @@ gss_refresh_null(struct rpc_task *task)
 	return 0;
 }
 
+static u32
+gss_validate_seqno_mic(struct gss_cl_ctx *ctx, u32 seqno, __be32 *seq, __be32 *p, u32 len)
+{
+	struct kvec iov;
+	struct xdr_buf verf_buf;
+	struct xdr_netobj mic;
+
+	*seq = cpu_to_be32(seqno);
+	iov.iov_base = seq;
+	iov.iov_len = 4;
+	xdr_buf_from_iov(&iov, &verf_buf);
+	mic.data = (u8 *)p;
+	mic.len = len;
+	return gss_verify_mic(ctx->gc_gss_ctx, &verf_buf, &mic);
+}
+
 static int
 gss_validate(struct rpc_task *task, struct xdr_stream *xdr)
 {
 	struct rpc_cred *cred = task->tk_rqstp->rq_cred;
 	struct gss_cl_ctx *ctx = gss_cred_get_ctx(cred);
 	__be32		*p, *seq = NULL;
-	struct kvec	iov;
-	struct xdr_buf	verf_buf;
-	struct xdr_netobj mic;
 	u32		len, maj_stat;
 	int		status;
+	int		i = 1; /* don't recheck the first item */
 
 	p = xdr_inline_decode(xdr, 2 * sizeof(*p));
 	if (!p)
@@ -1705,13 +1721,10 @@ gss_validate(struct rpc_task *task, struct xdr_stream *xdr)
 	seq = kmalloc(4, GFP_KERNEL);
 	if (!seq)
 		goto validate_failed;
-	*seq = cpu_to_be32(task->tk_rqstp->rq_seqno);
-	iov.iov_base = seq;
-	iov.iov_len = 4;
-	xdr_buf_from_iov(&iov, &verf_buf);
-	mic.data = (u8 *)p;
-	mic.len = len;
-	maj_stat = gss_verify_mic(ctx->gc_gss_ctx, &verf_buf, &mic);
+	maj_stat = gss_validate_seqno_mic(ctx, task->tk_rqstp->rq_seqnos[0], seq, p, len);
+	/* RFC 2203 5.3.3.1 - compute the checksum of each sequence number in the cache */
+	while (unlikely(maj_stat == GSS_S_BAD_SIG && i < task->tk_rqstp->rq_seqno_count))
+		maj_stat = gss_validate_seqno_mic(ctx, task->tk_rqstp->rq_seqnos[i], seq, p, len);
 	if (maj_stat == GSS_S_CONTEXT_EXPIRED)
 		clear_bit(RPCAUTH_CRED_UPTODATE, &cred->cr_flags);
 	if (maj_stat)
@@ -1750,7 +1763,7 @@ gss_wrap_req_integ(struct rpc_cred *cred, struct gss_cl_ctx *ctx,
 	if (!p)
 		goto wrap_failed;
 	integ_len = p++;
-	*p = cpu_to_be32(rqstp->rq_seqno);
+	*p = cpu_to_be32(*rqstp->rq_seqnos);
 
 	if (rpcauth_wrap_req_encode(task, xdr))
 		goto wrap_failed;
@@ -1847,7 +1860,7 @@ gss_wrap_req_priv(struct rpc_cred *cred, struct gss_cl_ctx *ctx,
 	if (!p)
 		goto wrap_failed;
 	opaque_len = p++;
-	*p = cpu_to_be32(rqstp->rq_seqno);
+	*p = cpu_to_be32(*rqstp->rq_seqnos);
 
 	if (rpcauth_wrap_req_encode(task, xdr))
 		goto wrap_failed;
@@ -2001,7 +2014,7 @@ gss_unwrap_resp_integ(struct rpc_task *task, struct rpc_cred *cred,
 	offset = rcv_buf->len - xdr_stream_remaining(xdr);
 	if (xdr_stream_decode_u32(xdr, &seqno))
 		goto unwrap_failed;
-	if (seqno != rqstp->rq_seqno)
+	if (seqno != *rqstp->rq_seqnos)
 		goto bad_seqno;
 	if (xdr_buf_subsegment(rcv_buf, &gss_data, offset, len))
 		goto unwrap_failed;
@@ -2045,7 +2058,7 @@ gss_unwrap_resp_integ(struct rpc_task *task, struct rpc_cred *cred,
 	trace_rpcgss_unwrap_failed(task);
 	goto out;
 bad_seqno:
-	trace_rpcgss_bad_seqno(task, rqstp->rq_seqno, seqno);
+	trace_rpcgss_bad_seqno(task, *rqstp->rq_seqnos, seqno);
 	goto out;
 bad_mic:
 	trace_rpcgss_verify_mic(task, maj_stat);
@@ -2077,7 +2090,7 @@ gss_unwrap_resp_priv(struct rpc_task *task, struct rpc_cred *cred,
 	if (maj_stat != GSS_S_COMPLETE)
 		goto bad_unwrap;
 	/* gss_unwrap decrypted the sequence number */
-	if (be32_to_cpup(p++) != rqstp->rq_seqno)
+	if (be32_to_cpup(p++) != *rqstp->rq_seqnos)
 		goto bad_seqno;
 
 	/* gss_unwrap redacts the opaque blob from the head iovec.
@@ -2093,7 +2106,7 @@ gss_unwrap_resp_priv(struct rpc_task *task, struct rpc_cred *cred,
 	trace_rpcgss_unwrap_failed(task);
 	return -EIO;
 bad_seqno:
-	trace_rpcgss_bad_seqno(task, rqstp->rq_seqno, be32_to_cpup(--p));
+	trace_rpcgss_bad_seqno(task, *rqstp->rq_seqnos, be32_to_cpup(--p));
 	return -EIO;
 bad_unwrap:
 	trace_rpcgss_unwrap(task, maj_stat);
@@ -2118,14 +2131,14 @@ gss_xmit_need_reencode(struct rpc_task *task)
 	if (!ctx)
 		goto out;
 
-	if (gss_seq_is_newer(req->rq_seqno, READ_ONCE(ctx->gc_seq)))
+	if (gss_seq_is_newer(*req->rq_seqnos, READ_ONCE(ctx->gc_seq)))
 		goto out_ctx;
 
 	seq_xmit = READ_ONCE(ctx->gc_seq_xmit);
-	while (gss_seq_is_newer(req->rq_seqno, seq_xmit)) {
+	while (gss_seq_is_newer(*req->rq_seqnos, seq_xmit)) {
 		u32 tmp = seq_xmit;
 
-		seq_xmit = cmpxchg(&ctx->gc_seq_xmit, tmp, req->rq_seqno);
+		seq_xmit = cmpxchg(&ctx->gc_seq_xmit, tmp, *req->rq_seqnos);
 		if (seq_xmit == tmp) {
 			ret = false;
 			goto out_ctx;
@@ -2134,7 +2147,7 @@ gss_xmit_need_reencode(struct rpc_task *task)
 
 	win = ctx->gc_win;
 	if (win > 0)
-		ret = !gss_seq_is_newer(req->rq_seqno, seq_xmit - win);
+		ret = !gss_seq_is_newer(*req->rq_seqnos, seq_xmit - win);
 
 out_ctx:
 	gss_put_ctx(ctx);
diff --git a/net/sunrpc/xprt.c b/net/sunrpc/xprt.c
index 09f245cda5262a572c450237419c80b183a83568..395bdfdaf4313eb85292f5a99bba818bbb268a76 100644
--- a/net/sunrpc/xprt.c
+++ b/net/sunrpc/xprt.c
@@ -1365,7 +1365,7 @@ xprt_request_enqueue_transmit(struct rpc_task *task)
 				INIT_LIST_HEAD(&req->rq_xmit2);
 				goto out;
 			}
-		} else if (!req->rq_seqno) {
+		} else if (req->rq_seqno_count == 0) {
 			list_for_each_entry(pos, &xprt->xmit_queue, rq_xmit) {
 				if (pos->rq_task->tk_owner != task->tk_owner)
 					continue;
@@ -1898,6 +1898,7 @@ xprt_request_init(struct rpc_task *task)
 	req->rq_snd_buf.bvec = NULL;
 	req->rq_rcv_buf.bvec = NULL;
 	req->rq_release_snd_buf = NULL;
+	req->rq_seqno_count = 0;
 	xprt_init_majortimeo(task, req, task->tk_client->cl_timeout);
 
 	trace_xprt_reserve(req);

-- 
2.43.5




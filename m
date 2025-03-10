Return-Path: <linux-nfs+bounces-10548-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E981DA59940
	for <lists+linux-nfs@lfdr.de>; Mon, 10 Mar 2025 16:12:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2C18116DE79
	for <lists+linux-nfs@lfdr.de>; Mon, 10 Mar 2025 15:12:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3837222D4D4;
	Mon, 10 Mar 2025 15:11:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=janestreet.com header.i=@janestreet.com header.b="hr1Ohe45"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mxout5.mail.janestreet.com (mxout5.mail.janestreet.com [64.215.233.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8028D22D4CF
	for <linux-nfs@vger.kernel.org>; Mon, 10 Mar 2025 15:11:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.215.233.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741619493; cv=none; b=MHrWPvHVk0uPi0Ae8BiMtC4pBLAnd7nVbMW/RJP/M4rQevZKjZX2IOrl7obz455f08FzMIdVXGqf/jaPCHiZE1tMZIO8b5uLrJGynpISlG+zeV69eghf3BeMLIi0iMZ0VMKCNW+jAfx6mnDcavv4v6xZBaMyMakgMsAKXEYa9dc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741619493; c=relaxed/simple;
	bh=n4CB51vKHwyuFqNcXzUAX7PS596NEfnq5KAc1iqpvMI=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=lXLGwEK/xBVINArScxvilEyBspxC6Xr+lEntAQ25s0Fjx9SHQERYX9nFMgux+hq6lCJwQtvZuPKPs2UiOBu8UKyPDda9QUKX0AIqfsqUvS7Nf02kkXnoG1P5/ugsosY+2BN+JHKHHyPB9O+n5usz6N4IP/j/IzKZWmgQMmo5Wvw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=janestreet.com; spf=pass smtp.mailfrom=janestreet.com; dkim=pass (2048-bit key) header.d=janestreet.com header.i=@janestreet.com header.b=hr1Ohe45; arc=none smtp.client-ip=64.215.233.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=janestreet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=janestreet.com
Date: Mon, 10 Mar 2025 11:11:30 -0400
From: Nikhil Jha <njha@janestreet.com>
To: njha@janestreet.com
Cc: Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>,
 	Chuck Lever <chuck.lever@oracle.com>,
 	Jeff Layton <jlayton@kernel.org>, Neil Brown <neilb@suse.de>,
 	Olga Kornievskaia <okorniev@redhat.com>,
 	Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>,
 	linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] sunrpc: implement rfc2203 rpcsec_gss seqnum cache
Message-ID: <20250310A151130a3b13064.njha@janestreet.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=janestreet.com;
  s=waixah; t=1741619490;
  bh=2vCrVBe73/FtaNWIvYfhPUf51t1swy31fQkJF8XPZRY=;
  h=Date:From:To:Cc:Subject;
  b=hr1Ohe45MWmS7HLUttEcGZLbmjJv5Qcpjc4xKYM/3t8OCQIYXWjx/EAO66ICe253U
  vSU6VxXT9S2TPJDxyzAVY6eJVbL09pQLeEAsEbechtZO3LiIuWEyGMToFILwqL/H41
  fj/Xv3Vo7SdYwCCgMlPeIBRlKDDlkSHORYFgWBIJ9HmgWEeyiydOhuiUX7no7HK6SI
  mL4bPhzui6fdoNXmhrhYwyRF102XmNoDfInr0RC0p9lxQXhcfSz/GZ6lSjOfeBhHZL
  mxVj7osgjsLfOMMZk7rM7yqde2FqCzOHWbsWcyH3A929AfYxMS5jA9STik3mid5wp8
  Z+hQUQTqsnTGQ==

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
 include/linux/sunrpc/xprt.h    | 31 +++++++++++++++++++++++++++++-
 net/sunrpc/auth_gss/auth_gss.c | 35 +++++++++++++++++++++++-----------
 net/sunrpc/xprt.c              |  1 +
 3 files changed, 55 insertions(+), 12 deletions(-)

diff --git a/include/linux/sunrpc/xprt.h b/include/linux/sunrpc/xprt.h
index 81b952649d35..023cebacea37 100644
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
@@ -66,7 +68,9 @@ struct rpc_rqst {
 	struct rpc_cred *	rq_cred;	/* Bound cred */
 	__be32			rq_xid;		/* request XID */
 	int			rq_cong;	/* has incremented xprt->cong */
-	u32			rq_seqno;	/* gss seq no. used on req. */
+	u32			rq_seqno;	/* latest gss seq no. used on req. */
+	u32			rq_seqnos[RPC_GSS_SEQNO_ARRAY_SIZE];	/* past req seqnos */
+	unsigned int		rq_seqno_count;	/* number of entries in the array */
 	int			rq_enc_pages_num;
 	struct page		**rq_enc_pages;	/* scratch pages for use by
 						   gss privacy code */
@@ -119,6 +123,31 @@ struct rpc_rqst {
 #define rq_svec			rq_snd_buf.head
 #define rq_slen			rq_snd_buf.len
 
+static inline void xdr_init_gss_seqnos(struct rpc_rqst *req)
+{
+	req->rq_seqno = 0;
+	req->rq_seqno_count = 0;
+}
+
+static inline int xdr_add_gss_seqno(struct rpc_rqst *req, u32 seqno)
+{
+	if (likely(req->rq_seqno_count < RPC_GSS_SEQNO_ARRAY_SIZE)) {
+		req->rq_seqnos[req->rq_seqno_count++] = req->rq_seqno;
+	} else {
+		/* Shift array to make room for the most recent one */
+		memmove(&req->rq_seqnos[0], &req->rq_seqnos[1],
+			(RPC_GSS_SEQNO_ARRAY_SIZE - 1) * sizeof(req->rq_seqnos[0]));
+		req->rq_seqnos[RPC_GSS_SEQNO_ARRAY_SIZE - 1] = req->rq_seqno;
+	}
+	req->rq_seqno = seqno;
+	return 0;
+}
+
+static inline bool xdr_gss_seqnos_empty(struct rpc_rqst *req)
+{
+	return req->rq_seqno == 0 && req->rq_seqno_count == 0;
+}
+
 /* RPC transport layer security policies */
 enum xprtsec_policies {
 	RPC_XPRTSEC_NONE = 0,
diff --git a/net/sunrpc/auth_gss/auth_gss.c b/net/sunrpc/auth_gss/auth_gss.c
index 369310909fc9..c79300965391 100644
--- a/net/sunrpc/auth_gss/auth_gss.c
+++ b/net/sunrpc/auth_gss/auth_gss.c
@@ -1545,6 +1545,7 @@ static int gss_marshal(struct rpc_task *task, struct xdr_stream *xdr)
 	struct kvec	iov;
 	struct xdr_buf	verf_buf;
 	int status;
+	u32 seqno;
 
 	/* Credential */
 
@@ -1556,7 +1557,8 @@ static int gss_marshal(struct rpc_task *task, struct xdr_stream *xdr)
 	cred_len = p++;
 
 	spin_lock(&ctx->gc_seq_lock);
-	req->rq_seqno = (ctx->gc_seq < MAXSEQ) ? ctx->gc_seq++ : MAXSEQ;
+	seqno = (ctx->gc_seq < MAXSEQ) ? ctx->gc_seq++ : MAXSEQ;
+	xdr_add_gss_seqno(req, seqno);
 	spin_unlock(&ctx->gc_seq_lock);
 	if (req->rq_seqno == MAXSEQ)
 		goto expired;
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
+	maj_stat = gss_validate_seqno_mic(ctx, task->tk_rqstp->rq_seqno, seq, p, len);
+	/* RFC 2203 5.3.3.1 - compute the checksum of each sequence number in the cache */
+	while (unlikely(maj_stat == GSS_S_BAD_SIG && i < task->tk_rqstp->rq_seqno_count))
+		maj_stat = gss_validate_seqno_mic(ctx, task->tk_rqstp->rq_seqnos[i], seq, p, len);
 	if (maj_stat == GSS_S_CONTEXT_EXPIRED)
 		clear_bit(RPCAUTH_CRED_UPTODATE, &cred->cr_flags);
 	if (maj_stat)
diff --git a/net/sunrpc/xprt.c b/net/sunrpc/xprt.c
index 09f245cda526..7da7d0b0a018 100644
--- a/net/sunrpc/xprt.c
+++ b/net/sunrpc/xprt.c
@@ -1898,6 +1898,7 @@ xprt_request_init(struct rpc_task *task)
 	req->rq_snd_buf.bvec = NULL;
 	req->rq_rcv_buf.bvec = NULL;
 	req->rq_release_snd_buf = NULL;
+	xdr_init_gss_seqnos(req);
 	xprt_init_majortimeo(task, req, task->tk_client->cl_timeout);
 
 	trace_xprt_reserve(req);
-- 
2.39.3



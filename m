Return-Path: <linux-nfs+bounces-2200-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 863EA871163
	for <lists+linux-nfs@lfdr.de>; Tue,  5 Mar 2024 01:02:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2E18AB21A1E
	for <lists+linux-nfs@lfdr.de>; Tue,  5 Mar 2024 00:02:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F108017EF;
	Tue,  5 Mar 2024 00:02:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sDUCR1c6"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD6032C9E
	for <linux-nfs@vger.kernel.org>; Tue,  5 Mar 2024 00:02:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709596951; cv=none; b=YZeJqYxGvwOn6oR632fLxdeMt/ffs8dvkHMH3dD7BBZPNWF/25MSCqZzcmtxDLXi6vkg5Y4/X/UmP+tiN3et8ksFfVupijdgfj6xuy5k3TEdX00e0wFR/jpVoOEliVZlT5vMa6yTtsfmhRTT4n76qaiblkICbdi9PJyJgPTHGzo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709596951; c=relaxed/simple;
	bh=pqSpbF4yohp8MiEta4HTgVBGWFcdMgGwpzsrtt3vas8=;
	h=Subject:From:To:Date:Message-ID:MIME-Version:Content-Type; b=LN+/DqraWCo9NHSWKvTbgITttiGbv9yV/A6E30fLQxdehfiOYfKS6Gra90vrx0a9jBV9Id93/Ae+Qu1g52nNTh9QVTXybM3uJLhd77owFVr9IiqotBfOxOfBjxSHNdMwm5dMUy2wUNtmSsq6hJ3blEFhOlDBAp34s5xMue2SFZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sDUCR1c6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5506FC433C7
	for <linux-nfs@vger.kernel.org>; Tue,  5 Mar 2024 00:02:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709596951;
	bh=pqSpbF4yohp8MiEta4HTgVBGWFcdMgGwpzsrtt3vas8=;
	h=Subject:From:To:Date:From;
	b=sDUCR1c6+2KeQfp1MOhDyBU/DK55mYyS5kuy98qAGtt1rpEk/N+4EiCqdKRNWEcou
	 ke1BQfuHZzGnc9GBE+Ky3HFvVSsvORUJ+SE5yA97ME/PBSXT/wqLvn8DTyPTrrIL8E
	 QB2FTILFpbOI+LuIL1uIbVsdqk5725xewgJ9dW2gdjisjyZsVBRpE92eMMyCyeg2LM
	 PF6NMQLqjJthMc5MilbWq8bfkRCWX8g8FP2HM7LZ/nWurIgnJvuOHwVo8WFnNvBbMs
	 fK+sNJCdQrtlYUPM5OlE8uZnuBtUvvh/x8rj3StVMdiVaLjnqKaYI50lNyCZi6I0Gn
	 f9X9QebQtKKAA==
Subject: [PATCH v1] NFSD: Clean up nfsd4_encode_replay()
From: Chuck Lever <cel@kernel.org>
To: linux-nfs@vger.kernel.org
Date: Mon, 04 Mar 2024 19:02:30 -0500
Message-ID: 
 <170959689952.51683.12823644619633192452.stgit@klimt.1015granger.net>
User-Agent: StGit/1.5
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

From: Chuck Lever <chuck.lever@oracle.com>

Replace open-coded encoding logic with the use of conventional XDR
utility functions. Add a tracepoint to make replays observable in
field troubleshooting situations.

The WARN_ON is removed. A stack trace is of little use, as there is
only one call site for nfsd4_encode_replay(), and a buffer length
shortage here is nearly impossible.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/nfs4xdr.c |   29 +++++++++++++----------------
 fs/nfsd/trace.h   |   18 ++++++++++++++++++
 2 files changed, 31 insertions(+), 16 deletions(-)


Neil and Jeff have now done the hard part. Here's a simple clean up
for the NFSv4 stateowner replay code path.


diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
index 9e8f230fc96e..fac938f563ad 100644
--- a/fs/nfsd/nfs4xdr.c
+++ b/fs/nfsd/nfs4xdr.c
@@ -5732,27 +5732,24 @@ nfsd4_encode_operation(struct nfsd4_compoundres *resp, struct nfsd4_op *op)
 	rqstp->rq_next_page = xdr->page_ptr + 1;
 }
 
-/* 
- * Encode the reply stored in the stateowner reply cache 
- * 
- * XDR note: do not encode rp->rp_buflen: the buffer contains the
- * previously sent already encoded operation.
+/**
+ * nfsd4_encode_replay - encode a result stored in the stateowner reply cache
+ * @xdr: send buffer's XDR stream
+ * @op: operation being replayed
+ *
+ * @op->replay->rp_buf contains the previously-sent already-encoded result.
  */
-void
-nfsd4_encode_replay(struct xdr_stream *xdr, struct nfsd4_op *op)
+void nfsd4_encode_replay(struct xdr_stream *xdr, struct nfsd4_op *op)
 {
-	__be32 *p;
 	struct nfs4_replay *rp = op->replay;
 
-	p = xdr_reserve_space(xdr, 8 + rp->rp_buflen);
-	if (!p) {
-		WARN_ON_ONCE(1);
-		return;
-	}
-	*p++ = cpu_to_be32(op->opnum);
-	*p++ = rp->rp_status;  /* already xdr'ed */
+	trace_nfsd_stateowner_replay(op->opnum, rp);
 
-	p = xdr_encode_opaque_fixed(p, rp->rp_buf, rp->rp_buflen);
+	if (xdr_stream_encode_u32(xdr, op->opnum) != XDR_UNIT)
+		return;
+	if (xdr_stream_encode_be32(xdr, rp->rp_status) != XDR_UNIT)
+		return;
+	xdr_stream_encode_opaque_fixed(xdr, rp->rp_buf, rp->rp_buflen);
 }
 
 void nfsd4_release_compoundargs(struct svc_rqst *rqstp)
diff --git a/fs/nfsd/trace.h b/fs/nfsd/trace.h
index d8e56268a250..e545e92c4408 100644
--- a/fs/nfsd/trace.h
+++ b/fs/nfsd/trace.h
@@ -696,6 +696,24 @@ DEFINE_EVENT(nfsd_stid_class, nfsd_stid_##name,			\
 
 DEFINE_STID_EVENT(revoke);
 
+TRACE_EVENT(nfsd_stateowner_replay,
+	TP_PROTO(
+		u32 opnum,
+		const struct nfs4_replay *rp
+	),
+	TP_ARGS(opnum, rp),
+	TP_STRUCT__entry(
+		__field(unsigned long, status)
+		__field(u32, opnum)
+	),
+	TP_fast_assign(
+		__entry->status = be32_to_cpu(rp->rp_status);
+		__entry->opnum = opnum;
+	),
+	TP_printk("opnum=%u status=%lu",
+		__entry->opnum, __entry->status)
+);
+
 TRACE_EVENT_CONDITION(nfsd_seq4_status,
 	TP_PROTO(
 		const struct svc_rqst *rqstp,




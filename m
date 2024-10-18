Return-Path: <linux-nfs+bounces-7289-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A67F69A4636
	for <lists+linux-nfs@lfdr.de>; Fri, 18 Oct 2024 20:47:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CBEE01C24220
	for <lists+linux-nfs@lfdr.de>; Fri, 18 Oct 2024 18:47:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AA4520ADDB;
	Fri, 18 Oct 2024 18:45:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bOjCSpXh"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BB4020A5FE;
	Fri, 18 Oct 2024 18:45:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729277122; cv=none; b=nZw+6bapt5XBJ1B6fX8teqbXDNpeyEdTgJ0gYGujT7e9/Io8OgfqSJ1txs1O3ba7k7lukHMjnoNXhsQaOgjZv6qnPzlDlG5iteX9bnzrUgxagRlPcW5Zj9xyrws3bYYpaIXSXOf6YtW08Q8zY2z8tVvEaqqlj9pg5fMRozXGL70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729277122; c=relaxed/simple;
	bh=6oJn2aEEoutWeHcGojFh5Y9xnA+CV3CIgh0ADvK8SbI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=osHNrDy3M+5hoMx1JHpNGyMU73gMachgRb0qwOczuqk6X6kteFgmelNvs1cbA+0jjD7kM9NtaY1Q+c9C69BZqjigbt94ND7ZGCy7fVDa6xTfUxtsFdJKylJUEx4nuJWTmAqimthoVUohxpjL12QslY37J/NAoz511YjGNGBtxBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bOjCSpXh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40A20C4CEC3;
	Fri, 18 Oct 2024 18:45:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729277121;
	bh=6oJn2aEEoutWeHcGojFh5Y9xnA+CV3CIgh0ADvK8SbI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=bOjCSpXhYZmKceQfrnIjGoY2F7OHIEiarJGRV19YncaYB8VfGfgg7vRFPLTsDYt8p
	 yv1Pat7dzZfCund5EbXbiH6gdxZjd1o98JrvGTVOYYV5CjNDx6mO7H1Y5aV3wzo8PS
	 OQMMPWwOlQET4qoccf/8040BE8XCCYbkUUHe36P5Nn4jpJWEgm4xklyDQ04ThBBNKF
	 6DxRWjGTvwEKjg6tGu4Zei+WBFEcPUGuWn6dH4Q2dtNz5CsNkcRBl/1Q7R/BBdrs0h
	 SsioKJ0FTclCGJ+PIWQZ8aV6uFGFoFjz5RK4r4B1iMC7LkK0gKCuk7eTX0AAUiQha9
	 XraJOK58W+0XA==
From: Jeff Layton <jlayton@kernel.org>
Date: Fri, 18 Oct 2024 14:45:01 -0400
Subject: [PATCH 3/3] nfsd: new tracepoint for after op_func in compound
 processing
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241018-delstid-v1-3-c6021b75ff3e@kernel.org>
References: <20241018-delstid-v1-0-c6021b75ff3e@kernel.org>
In-Reply-To: <20241018-delstid-v1-0-c6021b75ff3e@kernel.org>
To: Chuck Lever <chuck.lever@oracle.com>, Neil Brown <neilb@suse.de>, 
 Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, 
 Tom Talpey <tom@talpey.com>
Cc: linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1867; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=6oJn2aEEoutWeHcGojFh5Y9xnA+CV3CIgh0ADvK8SbI=;
 b=owEBbQKS/ZANAwAIAQAOaEEZVoIVAcsmYgBnEqy9wflP1CQIC7cX6DSGGQc+XzV630kZBJul9
 LL84qXi1LOJAjMEAAEIAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCZxKsvQAKCRAADmhBGVaC
 FWKcD/46AUcKyRSKR8Ae0V2xDCSeaR0eJaBzN4y2/39a63tgtR+iSC86Crzmi+L2CRRIL8c2I6r
 SfdblavHuTVusJ19sX0Xd3/N/dsU5LpK0VZxBySMQyy9DBQa48aB++i1ks6AR3LhPES95GqJ/yb
 D+LReTiy+1arPoqXX37iHbSSR2mtHwgAKnG8Z0c1TX6q/d2k3+WiO8CMR9NA9qx8C2a+/ebxlFe
 0ZNbsXLCjU40K02GCT65ao7ZpYbDez5xAOev/+eDr0yzGievHzX/vk2teKFN+HSWWtUkfNbqyhH
 HnxvefnrefZP/ttFa59pzREJDDEA9ILe7FuHfepDVcKbiOF54nYPD3FihPRh97u0F7cDBLwvXn8
 NhSQd812LSkQpMXUqRKDUe5PlSdSEBU0PY5pHB6Vyk7/HHZDkx1CO5KU+D3t06i4DSAtVtObI4F
 WoyxMvkMKhkJf3wdM4tZhY8ggycGYRYeXjDG0uO+WPzCtLIY/FAQguvqrivIk+s3YU4NGSHLkDq
 2Po3lwRc3lq2tlFHw1Fifw5c8pR7GC9Bu69CuBSl13u5BPPHbUM7oP6PNOOBrsgxFQfnIP9L8ew
 L0W520o7jVTBQPQrto5FZZsfm+0xEMkQP7NniF//FnrauCTvnDHwh5vryY2GJM5smPi8QjbHf6u
 +5x33S26H3S2lww==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

Turn nfsd_compound_encode_err tracepoint into a class and add a new
nfsd_compound_op_err tracepoint.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/nfsd/nfs4proc.c |  1 +
 fs/nfsd/trace.h    | 14 +++++++++++++-
 2 files changed, 14 insertions(+), 1 deletion(-)

diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
index f843b56b7b2056cbb69669e50c9ca9797cb91f0f..a7912c53f3ca2ecf3e3ad7a93ff9c44507037595 100644
--- a/fs/nfsd/nfs4proc.c
+++ b/fs/nfsd/nfs4proc.c
@@ -2807,6 +2807,7 @@ nfsd4_proc_compound(struct svc_rqst *rqstp)
 		if (op->opdesc->op_get_currentstateid)
 			op->opdesc->op_get_currentstateid(cstate, &op->u);
 		op->status = op->opdesc->op_func(rqstp, cstate, &op->u);
+		trace_nfsd_compound_op_err(rqstp, op->opnum, op->status);
 
 		/* Only from SEQUENCE */
 		if (cstate->status == nfserr_replay_cache) {
diff --git a/fs/nfsd/trace.h b/fs/nfsd/trace.h
index 3448e444d4100f8f4ce98189d8f605066aa10f49..f318898cfc31614b5a84a4867e18c2b3a07122c9 100644
--- a/fs/nfsd/trace.h
+++ b/fs/nfsd/trace.h
@@ -163,7 +163,7 @@ TRACE_EVENT(nfsd_compound_decode_err,
 		__entry->opnum, __entry->status)
 );
 
-TRACE_EVENT(nfsd_compound_encode_err,
+DECLARE_EVENT_CLASS(nfsd_compound_err_class,
 	TP_PROTO(
 		const struct svc_rqst *rqstp,
 		u32 opnum,
@@ -184,6 +184,18 @@ TRACE_EVENT(nfsd_compound_encode_err,
 		__entry->opnum, __entry->status)
 );
 
+#define DEFINE_NFSD_COMPOUND_ERR_EVENT(name)				\
+DEFINE_EVENT(nfsd_compound_err_class, nfsd_compound_##name##_err,	\
+	TP_PROTO(							\
+		const struct svc_rqst *rqstp,				\
+		u32 opnum,						\
+		__be32 status						\
+	),								\
+	TP_ARGS(rqstp, opnum, status))
+
+DEFINE_NFSD_COMPOUND_ERR_EVENT(op);
+DEFINE_NFSD_COMPOUND_ERR_EVENT(encode);
+
 #define show_fs_file_type(x) \
 	__print_symbolic(x, \
 		{ S_IFLNK,		"LNK" }, \

-- 
2.47.0



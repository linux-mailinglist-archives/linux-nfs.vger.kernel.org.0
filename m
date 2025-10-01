Return-Path: <linux-nfs+bounces-14837-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BDE37BB0813
	for <lists+linux-nfs@lfdr.de>; Wed, 01 Oct 2025 15:28:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5363D1882E61
	for <lists+linux-nfs@lfdr.de>; Wed,  1 Oct 2025 13:29:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65B0F2ED166;
	Wed,  1 Oct 2025 13:28:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lkqykZFj"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F9082ED15F
	for <linux-nfs@vger.kernel.org>; Wed,  1 Oct 2025 13:28:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759325315; cv=none; b=gWTKWUVu1SDPrIyM1m1VqjaoXURvKfacLiuCaeU+A55ynZryD2tEYFHkRp7UA73PCBfQkmBKsBc59CYpMvFRbqdn8ni8yPOwtBXvpViclc2n06nUwEhbG3zfG5NSLqxcOjHg4OvpvmyBt0E9PlkgfuTkgXPe2y1G7W/bbMVUkJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759325315; c=relaxed/simple;
	bh=blWojFXgXaGL7A7PdQEC+wTLorIuDeFo0Yed0DUWm9w=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Lzd2Znvizuqm3+oVUwyjjl/wb0ic9Q/QbzPIjPjpNkrYIYc6k7B1ffsfUTfJr4RR6zG7aspkD/aOzMf74DahPyGw0qjS8CQ3e60K1XJ5T49h0fNDFJNMe/Z3hUthnERSymgDAv+KbE0W4GPWwDyZcE04ActKgTlYTdaVUf5/hYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lkqykZFj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21B3EC4CEF4;
	Wed,  1 Oct 2025 13:28:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759325314;
	bh=blWojFXgXaGL7A7PdQEC+wTLorIuDeFo0Yed0DUWm9w=;
	h=From:To:Cc:Subject:Date:From;
	b=lkqykZFjQIgonL12FyjE40mjEDK06b1lfer3ptUJ7NcZ+jeSqlSw1zb4yvNiz3b8e
	 lhgMhxs4Nio0dl3CSQHI6APtFBirsVwTB5zUrOq3ODvwJNBXKV0jyB1Ef1KFkmvLp+
	 iBMy6zk+IwhiU5gwq6PtbsUAng3UT1V+br8VNF0jonhq1L9tqB9YaVahLbPuvOZlG1
	 CFa/kAnIK4tdvx4ryRNdQiKhTTrZ5x718FFcsx9RV7DuiLX2zJNuSMuMnbHAKNxVCD
	 W7wRPL6WHv70xO8hW+2M8RAnhdssYbOOf3SclRLMbk27a8rBmGRP4QOO1xSYIxxQNe
	 TG7R5H90d5zwQ==
From: Chuck Lever <cel@kernel.org>
To: NeilBrown <neil@brown.name>,
	Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>
Cc: <linux-nfs@vger.kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>
Subject: [PATCH v1] Revert "NFSD: Remove the cap on number of operations per NFSv4 COMPOUND"
Date: Wed,  1 Oct 2025 09:28:32 -0400
Message-ID: <20251001132832.9990-1-cel@kernel.org>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chuck Lever <chuck.lever@oracle.com>

I've found that pynfs COMP6 leaves the connection or lease in a
strange state, which causes CLOSE9 to hang indefinitely. I've dug
into it a little, but I haven't been able to root-cause it yet.

Let's restore a 200 operation-per-COMPOUND limit. NFSD CI will pass,
and I can continue debugging.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/nfs4proc.c  | 14 ++++++++++++--
 fs/nfsd/nfs4state.c |  1 +
 fs/nfsd/nfs4xdr.c   |  4 +++-
 fs/nfsd/nfsd.h      |  3 +++
 fs/nfsd/xdr4.h      |  1 +
 5 files changed, 20 insertions(+), 3 deletions(-)

diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
index f9aeefc0da73..7f7e6bb23a90 100644
--- a/fs/nfsd/nfs4proc.c
+++ b/fs/nfsd/nfs4proc.c
@@ -2893,10 +2893,20 @@ nfsd4_proc_compound(struct svc_rqst *rqstp)
 
 	rqstp->rq_lease_breaker = (void **)&cstate->clp;
 
-	trace_nfsd_compound(rqstp, args->tag, args->taglen, args->opcnt);
+	trace_nfsd_compound(rqstp, args->tag, args->taglen, args->client_opcnt);
 	while (!status && resp->opcnt < args->opcnt) {
 		op = &args->ops[resp->opcnt++];
 
+		if (unlikely(resp->opcnt == NFSD_MAX_OPS_PER_COMPOUND)) {
+			/* If there are still more operations to process,
+			 * stop here and report NFS4ERR_RESOURCE. */
+			if (cstate->minorversion == 0 &&
+			    args->client_opcnt > resp->opcnt) {
+				op->status = nfserr_resource;
+				goto encode_op;
+			}
+		}
+
 		/*
 		 * The XDR decode routines may have pre-set op->status;
 		 * for example, if there is a miscellaneous XDR error
@@ -2973,7 +2983,7 @@ nfsd4_proc_compound(struct svc_rqst *rqstp)
 			status = op->status;
 		}
 
-		trace_nfsd_compound_status(args->opcnt, resp->opcnt,
+		trace_nfsd_compound_status(args->client_opcnt, resp->opcnt,
 					   status, nfsd4_op_name(op->opnum));
 
 		nfsd4_cstate_clear_replay(cstate);
diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index 7c60d2ffe21c..0de9ee8df7ce 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -3907,6 +3907,7 @@ static __be32 check_forechannel_attrs(struct nfsd4_channel_attrs *ca, struct nfs
 	ca->headerpadsz = 0;
 	ca->maxreq_sz = min_t(u32, ca->maxreq_sz, maxrpc);
 	ca->maxresp_sz = min_t(u32, ca->maxresp_sz, maxrpc);
+	ca->maxops = min_t(u32, ca->maxops, NFSD_MAX_OPS_PER_COMPOUND);
 	ca->maxresp_cached = min_t(u32, ca->maxresp_cached,
 			NFSD_SLOT_CACHE_SIZE + NFSD_MIN_HDR_SEQ_SZ);
 	ca->maxreqs = min_t(u32, ca->maxreqs, NFSD_MAX_SLOTS_PER_SESSION);
diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
index 6a56dca6fb04..230bf53e39f7 100644
--- a/fs/nfsd/nfs4xdr.c
+++ b/fs/nfsd/nfs4xdr.c
@@ -2488,8 +2488,10 @@ nfsd4_decode_compound(struct nfsd4_compoundargs *argp)
 
 	if (xdr_stream_decode_u32(argp->xdr, &argp->minorversion) < 0)
 		return false;
-	if (xdr_stream_decode_u32(argp->xdr, &argp->opcnt) < 0)
+	if (xdr_stream_decode_u32(argp->xdr, &argp->client_opcnt) < 0)
 		return false;
+	argp->opcnt = min_t(u32, argp->client_opcnt,
+			    NFSD_MAX_OPS_PER_COMPOUND);
 
 	if (argp->opcnt > ARRAY_SIZE(argp->iops)) {
 		argp->ops = vcalloc(argp->opcnt, sizeof(*argp->ops));
diff --git a/fs/nfsd/nfsd.h b/fs/nfsd/nfsd.h
index 6812cd231b1d..8ffed4f0b95f 100644
--- a/fs/nfsd/nfsd.h
+++ b/fs/nfsd/nfsd.h
@@ -57,6 +57,9 @@ struct readdir_cd {
 	__be32			err;	/* 0, nfserr, or nfserr_eof */
 };
 
+/* Maximum number of operations per session compound */
+#define NFSD_MAX_OPS_PER_COMPOUND	200
+
 struct nfsd_genl_rqstp {
 	struct sockaddr		rq_daddr;
 	struct sockaddr		rq_saddr;
diff --git a/fs/nfsd/xdr4.h b/fs/nfsd/xdr4.h
index d4b48602b2b0..ee0570cbdd9e 100644
--- a/fs/nfsd/xdr4.h
+++ b/fs/nfsd/xdr4.h
@@ -903,6 +903,7 @@ struct nfsd4_compoundargs {
 	char *				tag;
 	u32				taglen;
 	u32				minorversion;
+	u32				client_opcnt;
 	u32				opcnt;
 	bool				splice_ok;
 	struct nfsd4_op			*ops;
-- 
2.51.0



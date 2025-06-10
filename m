Return-Path: <linux-nfs+bounces-12278-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D89F2AD3E38
	for <lists+linux-nfs@lfdr.de>; Tue, 10 Jun 2025 18:05:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 83477162915
	for <lists+linux-nfs@lfdr.de>; Tue, 10 Jun 2025 16:05:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D167323C505;
	Tue, 10 Jun 2025 16:05:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NUy7ObFK"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C1F523C4F9
	for <linux-nfs@vger.kernel.org>; Tue, 10 Jun 2025 16:05:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749571518; cv=none; b=lYbeY6kC1apB1F4edoAKPN837GY2lcBtzy6TM8DGHQZN9fkBBF7BfkNkC1hfiwUmqWVCEQBF5BCeRtJBjCot9zoZLSbfCOa52xloRUJxH7Vi3Zdz1TOQWgLW5sW87T+PDYexTYYQkteCwrTITEDgAJXj0khOVoPkXTrYfCO9hm8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749571518; c=relaxed/simple;
	bh=wPoZi0fDbOkeGyDFCjaEI2O7G4M87hD+ozaM/bV3aRI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gLWoI/p5+TvRkEiR+s/19euUZH7gcdGg0idbEcnDMsTL7os3GjTpS7Fa96ln28+m/8qRlDbAm5nyezN2NdNPjN+mlWEr+BRCxzHJA1YHiglyoXddj8bhHzZQ/butr4i1E1Bf2Ldsr4XAYBZj/l9ZYyX0Bgm9eVtnSBK3JLUb3xY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NUy7ObFK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C863C4CEF5;
	Tue, 10 Jun 2025 16:05:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749571515;
	bh=wPoZi0fDbOkeGyDFCjaEI2O7G4M87hD+ozaM/bV3aRI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=NUy7ObFK5Yg7IV4LssaZe+rgzUL9+O2aN9UX37nRekMWcTM8kQh6fmR2SYYt/1iaN
	 WKu6ysgbLaFNrw0oN3cEvjLQOnxUGhEipBYUx+dnTujuA/KHKFRZUUQ3F1Bs5d6dDt
	 hgHExnfNZJ375DpFUCNCSSFVKUOall8rhBVeOmPyYm1hZOi16f0Q9ToFrjfrn/3t5u
	 qkK1ND4yBdSmtVkWSakL92zGd0Iz208INSYCEiz6W4JvkJMKhXV75B7uepmxGzv1sl
	 82tEk6t2HaLPMQovL4NK/gSNpRdvCn9HWvsDbDwsbk3903vQ/BuEN7n9pd81OdAEw3
	 geIpePuQY3sXg==
From: Chuck Lever <cel@kernel.org>
To: NeilBrown <neil@brown.name>,
	Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>
Cc: <linux-nfs@vger.kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>
Subject: [RFC PATCH 3/3] NFSD: Remove the cap on number of operations per NFSv4 COMPOUND
Date: Tue, 10 Jun 2025 12:05:09 -0400
Message-ID: <20250610160509.97599-4-cel@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250610160509.97599-1-cel@kernel.org>
References: <20250610160509.97599-1-cel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chuck Lever <chuck.lever@oracle.com>

This limit has always been a sanity check; in nearly all cases a
large COMPOUND is a sign of a malfunctioning client. The only real
limit on COMPOUND size and complexity is the size of NFSD's send
and receive buffers.

However, there are a few cases where a large COMPOUND is sane. For
example, when a client implementation wants to walk down a long file
pathname in a single round trip.

A small risk is that now a client can construct a COMPOUND request
that can keep a single nfsd thread busy for quite some time.

Suggested-by: Jeff Layton <jlayton@kernel.org>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/nfs4proc.c  | 14 ++------------
 fs/nfsd/nfs4state.c |  1 -
 fs/nfsd/nfs4xdr.c   |  4 +---
 fs/nfsd/nfsd.h      |  3 ---
 fs/nfsd/xdr4.h      |  1 -
 5 files changed, 3 insertions(+), 20 deletions(-)

diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
index f13abbb13b38..f4edf222e00e 100644
--- a/fs/nfsd/nfs4proc.c
+++ b/fs/nfsd/nfs4proc.c
@@ -2842,20 +2842,10 @@ nfsd4_proc_compound(struct svc_rqst *rqstp)
 
 	rqstp->rq_lease_breaker = (void **)&cstate->clp;
 
-	trace_nfsd_compound(rqstp, args->tag, args->taglen, args->client_opcnt);
+	trace_nfsd_compound(rqstp, args->tag, args->taglen, args->opcnt);
 	while (!status && resp->opcnt < args->opcnt) {
 		op = &args->ops[resp->opcnt++];
 
-		if (unlikely(resp->opcnt == NFSD_MAX_OPS_PER_COMPOUND)) {
-			/* If there are still more operations to process,
-			 * stop here and report NFS4ERR_RESOURCE. */
-			if (cstate->minorversion == 0 &&
-			    args->client_opcnt > resp->opcnt) {
-				op->status = nfserr_resource;
-				goto encode_op;
-			}
-		}
-
 		/*
 		 * The XDR decode routines may have pre-set op->status;
 		 * for example, if there is a miscellaneous XDR error
@@ -2932,7 +2922,7 @@ nfsd4_proc_compound(struct svc_rqst *rqstp)
 			status = op->status;
 		}
 
-		trace_nfsd_compound_status(args->client_opcnt, resp->opcnt,
+		trace_nfsd_compound_status(args->opcnt, resp->opcnt,
 					   status, nfsd4_op_name(op->opnum));
 
 		nfsd4_cstate_clear_replay(cstate);
diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index d5694987f86f..4b6ae8e54cd2 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -3872,7 +3872,6 @@ static __be32 check_forechannel_attrs(struct nfsd4_channel_attrs *ca, struct nfs
 	ca->headerpadsz = 0;
 	ca->maxreq_sz = min_t(u32, ca->maxreq_sz, maxrpc);
 	ca->maxresp_sz = min_t(u32, ca->maxresp_sz, maxrpc);
-	ca->maxops = min_t(u32, ca->maxops, NFSD_MAX_OPS_PER_COMPOUND);
 	ca->maxresp_cached = min_t(u32, ca->maxresp_cached,
 			NFSD_SLOT_CACHE_SIZE + NFSD_MIN_HDR_SEQ_SZ);
 	ca->maxreqs = min_t(u32, ca->maxreqs, NFSD_MAX_SLOTS_PER_SESSION);
diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
index 3afcdbed6e14..ea91bad4eee2 100644
--- a/fs/nfsd/nfs4xdr.c
+++ b/fs/nfsd/nfs4xdr.c
@@ -2500,10 +2500,8 @@ nfsd4_decode_compound(struct nfsd4_compoundargs *argp)
 
 	if (xdr_stream_decode_u32(argp->xdr, &argp->minorversion) < 0)
 		return false;
-	if (xdr_stream_decode_u32(argp->xdr, &argp->client_opcnt) < 0)
+	if (xdr_stream_decode_u32(argp->xdr, &argp->opcnt) < 0)
 		return false;
-	argp->opcnt = min_t(u32, argp->client_opcnt,
-			    NFSD_MAX_OPS_PER_COMPOUND);
 
 	if (argp->opcnt > ARRAY_SIZE(argp->iops)) {
 		argp->ops = vcalloc(argp->opcnt, sizeof(*argp->ops));
diff --git a/fs/nfsd/nfsd.h b/fs/nfsd/nfsd.h
index 570065285e67..54a96042f5ac 100644
--- a/fs/nfsd/nfsd.h
+++ b/fs/nfsd/nfsd.h
@@ -57,9 +57,6 @@ struct readdir_cd {
 	__be32			err;	/* 0, nfserr, or nfserr_eof */
 };
 
-/* Maximum number of operations per session compound */
-#define NFSD_MAX_OPS_PER_COMPOUND	50
-
 struct nfsd_genl_rqstp {
 	struct sockaddr		rq_daddr;
 	struct sockaddr		rq_saddr;
diff --git a/fs/nfsd/xdr4.h b/fs/nfsd/xdr4.h
index aa2a356da784..a23bc56051ca 100644
--- a/fs/nfsd/xdr4.h
+++ b/fs/nfsd/xdr4.h
@@ -870,7 +870,6 @@ struct nfsd4_compoundargs {
 	char *				tag;
 	u32				taglen;
 	u32				minorversion;
-	u32				client_opcnt;
 	u32				opcnt;
 	bool				splice_ok;
 	struct nfsd4_op			*ops;
-- 
2.49.0



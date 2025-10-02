Return-Path: <linux-nfs+bounces-14910-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D7C2DBB41D7
	for <lists+linux-nfs@lfdr.de>; Thu, 02 Oct 2025 16:00:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 943F5178E22
	for <lists+linux-nfs@lfdr.de>; Thu,  2 Oct 2025 14:00:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF19317736;
	Thu,  2 Oct 2025 14:00:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FpkWl+91"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9920C139E
	for <linux-nfs@vger.kernel.org>; Thu,  2 Oct 2025 14:00:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759413655; cv=none; b=XbA8WY+WIP7NQ67jbUH+GC8SPAxsRmmhXeMc+uThL+r08w9Iqrtim24IP+Pwh8bd6vIDDhcSLvLE1xx+LwLpGH7qFE1nASSRvSJ1pcEXTc6ubt2Ze7ylx/8FjwhSbc2JUZ8RqypPraU/qr1XQ62PomPuGdgC1cj4gIQEp+ZD6ok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759413655; c=relaxed/simple;
	bh=iDVpUc56dY5pcPJGDK8AFAH/mvlzG/53raVVsyR+l5E=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bBHe9iFwpDMt7XQKEDC1HKPgdmrV6CVZvY5xWYlbk0mAlqzLTJixq7Fx9Elx4hPZroOnGZdkhk0eGgtFUpPPAIIvUgI02PpKLRYiJhAw3Tz7qbv6qZhcnSSQRSOIJ51TknGXUsHqr6AejzlRf4tXk+RAC/mbu6Bzd0bNh0RqRts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FpkWl+91; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 938E9C4CEF4;
	Thu,  2 Oct 2025 14:00:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759413655;
	bh=iDVpUc56dY5pcPJGDK8AFAH/mvlzG/53raVVsyR+l5E=;
	h=From:To:Cc:Subject:Date:From;
	b=FpkWl+913FG2FLL2RLS+Tsscf+PDf68e8Egq0EMRo4XURCjlac9+hnH3YvcKrztTa
	 8Eg7WvXpxQ+m4Ca0VLYOybb+kfN9qDa/r6mZ+2v35/ZocZr2qldHOou2Om940Gi7Xz
	 M4J+iDHUFYb0e24b64PvTmpKlzLGXV8iQKDtW9b6I2XnRPqZTY66NzBHM+Tw4qk4vx
	 wpbOpb7cZvv+KSqiTotRbm/BvYgRlaf/UbkW/9pBOVBhgRAJ/9+T09SDopb51+x7fn
	 4BCqYZp2l1Dj3cDtkiYMk05ApYZLDppOBMSmRPkUc/LjOeX7rKWzuhK/CGRBq6e7oX
	 Pds9kiCmx39/g==
From: Chuck Lever <cel@kernel.org>
To: NeilBrown <neil@brown.name>,
	Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>
Cc: <linux-nfs@vger.kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>,
	tianshuo han <hantianshuo233@gmail.com>
Subject: [PATCH v2] Revert "NFSD: Remove the cap on number of operations per NFSv4 COMPOUND"
Date: Thu,  2 Oct 2025 10:00:51 -0400
Message-ID: <20251002140052.15502-1-cel@kernel.org>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chuck Lever <chuck.lever@oracle.com>

I've found that pynfs COMP6 now leaves the connection or lease in a
strange state, which causes CLOSE9 to hang indefinitely. I've dug
into it a little, but I haven't been able to root-cause it yet.
However, I bisected to commit 48aab1606fa8 ("NFSD: Remove the cap on
number of operations per NFSv4 COMPOUND").

Tianshuo Han also reports a potential vulnerability when decoding
an NFSv4 COMPOUND. An attacker can place an arbitrarily large op
count in the COMPOUND header, which results in:

[   51.410584] nfsd: vmalloc error: size 1209533382144, exceeds total
pages, mode:0xdc0(GFP_KERNEL|__GFP_ZERO),
nodemask=(null),cpuset=/,mems_allowed=0

when NFSD attempts to allocate the COMPOUND op array.

Let's restore the per operation-per-COMPOUND limit, but increased to
200 for now.

Reported-by: tianshuo han <hantianshuo233@gmail.com>
Reviewed-by: Jeff Layton <jlayton@kernel.org>
X-Cc: stable@vger.kernel.org
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/nfs4proc.c  | 14 ++++++++++++--
 fs/nfsd/nfs4state.c |  1 +
 fs/nfsd/nfs4xdr.c   |  4 +++-
 fs/nfsd/nfsd.h      |  3 +++
 fs/nfsd/xdr4.h      |  1 +
 5 files changed, 20 insertions(+), 3 deletions(-)

Changes since v1:
* Patch description updates

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
index ad2c45658c46..c9053ef4d79f 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -3902,6 +3902,7 @@ static __be32 check_forechannel_attrs(struct nfsd4_channel_attrs *ca, struct nfs
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



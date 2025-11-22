Return-Path: <linux-nfs+bounces-16652-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 375ECC7C08E
	for <lists+linux-nfs@lfdr.de>; Sat, 22 Nov 2025 01:53:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id EA8224E3469
	for <lists+linux-nfs@lfdr.de>; Sat, 22 Nov 2025 00:53:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 460FB23ABAA;
	Sat, 22 Nov 2025 00:53:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b="X8RpeM6b";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Gj86OSIr"
X-Original-To: linux-nfs@vger.kernel.org
Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58C551F09AD
	for <linux-nfs@vger.kernel.org>; Sat, 22 Nov 2025 00:53:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763772782; cv=none; b=Nr5qvND5e9BvvdsuNt1tX5i5XwJOLl7sFDI7W+orZStm4IvpeDQDtGm/qmt01WJsI2UbUat9ZspNe/9j9zABkuhryMmehULuxaiqO54MJ84OJqot/0ob90vHRvBbAB4Z8AD4s+vtDi85sseNlTurHEaDzsUf6cNBwmtZSpYjo7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763772782; c=relaxed/simple;
	bh=+PgfKCJxmeSMHqUHmFrF1xsSIGyHkGdHteHooxgXCXM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=V4nieH2squPL4zOcMQ8Xbk+ggeczqTRjeKxPgKn5JQcCtOQuSg6Js2jDFMHzva2Cbkl3LlaerV15iBWCAEdKxaU2dIgCYEsFFifXXzWMIFr8kJsBx3I9DeqA7bgKWuJMrbGZf5yzAyIEuoFNOoBrAsPkQiq1Y0k04Z2An6xvTCE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=X8RpeM6b; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Gj86OSIr; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id A7A4714000B6;
	Fri, 21 Nov 2025 19:52:59 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Fri, 21 Nov 2025 19:52:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to; s=fm3; t=1763772779;
	 x=1763859179; bh=g5SHLCf12fR8ymj2BhkBbR9VNNmbNfwEG8uwVfX3bow=; b=
	X8RpeM6bZjeQ5PODHxlmQPoaFPO0lsv+evUIpfm1jaNsOPxYwHq6LN/dE+eECHuP
	og9UktE223v1ppeEmzzRN0CSNivZu+cwXXdEQCSiJRWyqwj2ExyVedvKOAlelD54
	34h4v3yoR80wQXiSNf3E+FKSerODZ9LQEDgFE9mWlcZdO0BNDEPD/NPJltogIXWA
	ye0U8Avh1NbxLZaz+ub1lwn5f5A0pDUCGNwDBILGTuJ4+9bSL3lLeg9iLEfoHyVI
	VXHKP9fMgXSuGMYmtmpf2Mal1FmCtTILG5shaXpuG1G0e64HacTP11WdCFYTvGkJ
	viVgfvCMQ9p6vZ7AiGRZiQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm3; t=1763772779; x=1763859179; bh=g
	5SHLCf12fR8ymj2BhkBbR9VNNmbNfwEG8uwVfX3bow=; b=Gj86OSIrNtz9cNWVX
	7amRoJftcDj3lJxl58vRaD0gZejOS+j9/F7RpmW0QhvNV+WcsHv9PIeF4RV+uuDL
	fQRnCNZX9PCCep1bpb5NTsLJVqZ+su/6zdHtNFZxAlQPMaqatdrYVO8ozyLCBWDt
	umqhVipvgmh3rbmx8ZzXJTtMRXD564yXDVSuxnUIxg41JxCtNY6P/C/5AaulYgs/
	cZR7Mxtn8gR5DPetVR3wipDgagCnVIb2PIN5xuHP2jbCj6als2KgPBJAB8WEm2QA
	OAHuB751FLVJbRnnW+kbMwro6K2dXQvfcpQuLF0d2fEWKbeIjcG8F1G1uf5Ps3C2
	hx0KQ==
X-ME-Sender: <xms:awkhaSetVJJ1WmWUgbk15EJriKjIEnavknxTrRNt4cmhiaLhuQ6RbQ>
    <xme:awkhaf4EBMv9gZNSTNcuts2SOJk6JcNAOTRBwGXCXd0z9iyOQYLysdEGglp_7PyLl
    DKbi-zUQfnZZhWkzZFX3sHYkUhCWlQJ2tyaShvUlS5gXP33UQ>
X-ME-Received: <xmr:awkhadWuHTTIoLUqpfhgmZf3tecWLeIEI9hp-gNM0tRJ1dCayc5CeT9dN0fwLYQiaThrjQ0qj7jl6yE6ZFEpa2Ck2NQkRzVxXVv5on_kfiyD>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvfedugeehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefufffkofgjfhhrggfgsedtkeertdertddtnecuhfhrohhmpefpvghilheu
    rhhofihnuceonhgvihhlsgesohifnhhmrghilhdrnhgvtheqnecuggftrfgrthhtvghrnh
    epveevkeffudeuvefhieeghffgudektdelkeejiedtjedugfeukedvkeffvdefvddunecu
    vehluhhsthgvrhfuihiivgepudenucfrrghrrghmpehmrghilhhfrhhomhepnhgvihhlsg
    esohifnhhmrghilhdrnhgvthdpnhgspghrtghpthhtohepiedpmhhouggvpehsmhhtphho
    uhhtpdhrtghpthhtoheplhhinhhugidqnhhfshesvhhgvghrrdhkvghrnhgvlhdrohhrgh
    dprhgtphhtthhopehtohhmsehtrghlphgvhidrtghomhdprhgtphhtthhopehokhhorhhn
    ihgvvhesrhgvughhrghtrdgtohhmpdhrtghpthhtoheptghhuhgtkhdrlhgvvhgvrhesoh
    hrrggtlhgvrdgtohhmpdhrtghpthhtohepuggrihdrnhhgohesohhrrggtlhgvrdgtohhm
    pdhrtghpthhtohepjhhlrgihthhonheskhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:awkhaW4-AKKUxqIzpY0RyjJo581wFvje75LUU2ZDVfrS387GWEZwOw>
    <xmx:awkhaQo4D4pGfWwkSFd0Wi9agRPCBemeARBB55UjxO1BHiq8RVOZdA>
    <xmx:awkhaRn3O1kNeOC6HIas9pWj7DWfx5i0lJ5ViL5A72T94xdsQYYiaQ>
    <xmx:awkhaUMinWW8uPkZp-thIQO-LD9Z9Q4jVAfgraiRq6TIZZuSIWL5kQ>
    <xmx:awkhaf_U4rXSEtgzixKlhMGjq45zZ499YcnHxQ87c_WNbqVY30pHxkhR>
Feedback-ID: iab3e480c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 21 Nov 2025 19:52:57 -0500 (EST)
From: NeilBrown <neilb@ownmail.net>
To: Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>
Cc: Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <Dai.Ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>,
	linux-nfs@vger.kernel.org
Subject: [PATCH v6 03/14] nfsd: simplify foreign-filehandle handling to better match RFC-7862
Date: Sat, 22 Nov 2025 11:47:01 +1100
Message-ID: <20251122005236.3440177-4-neilb@ownmail.net>
X-Mailer: git-send-email 2.50.0.107.gf914562f5916.dirty
In-Reply-To: <20251122005236.3440177-1-neilb@ownmail.net>
References: <20251122005236.3440177-1-neilb@ownmail.net>
Reply-To: NeilBrown <neil@brown.name>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: NeilBrown <neil@brown.name>

When the COPY v4.2 op is used in the inter-server copy mode, the file
handle of the source file (presented as the saved filehandle to COPY) is
for a different ("foreign") file server which would not be expected to
be understood by this server.  fh_verify() is likely to return
nfserr_stale.

In order of this filehandle to still be available to COPY, both PUTFH
and SAVEFH must not trigger an error.

RFC 7862 section 15.2.3 says:

   If the request is for an inter-server copy, the source-fh is a
   filehandle from the source server and the COMPOUND procedure is being
   executed on the destination server.  In this case, the source-fh is a
   foreign filehandle on the server receiving the COPY request.  If
   either PUTFH or SAVEFH checked the validity of the filehandle, the
   operation would likely fail and return NFS4ERR_STALE.

   If a server supports the inter-server copy feature, a PUTFH followed
   by a SAVEFH MUST NOT return NFS4ERR_STALE for either operation.
   These restrictions do not pose substantial difficulties for servers.
   CURRENT_FH and SAVED_FH may be validated in the context of the
   operation referencing them and an NFS4ERR_STALE error returned for an
   invalid filehandle at that point.

Linux nfsd currently takes a different approach.  Rather than just
checking for "a PUTFH followed by a SAVEFH", it goes further to consider
only that case when this filehandle is then used for COPY, and allows
that it might have been subject of RESTOREFH and SAVEFH in between.

This is not a problem in itself except for the extra code with little
benefit.  This analysis of the COMPOUND to detect PUTFH ops which need
care is performed on every COMPOUND request, which is an unwanted cost.

It is sufficient to check if the relevant conditions are met only when a
PUTFH op actually receives an error from fh_verify().

This patch removes the checking code from common paths and places it in
nfsd4_putfh() only when fh_verify() returns a relevant error.

Rather than scanning ahead for a COPY, this patch notes (in
nfsd4_compoundargs) when an inter-server COPY is decoded, and in that
case only checks the next op to see if it is SAVEFH as this is what the
RFC requires.

A test on "inter_copy_offload_enable" is also added to be completely
consistent with the "If a server supports the inter-server copy feature"
precondition.

As we do this test in nfsd4_putfh() there is no now need to mark the
putfh op as "no_verify".

Reviewed-by: Jeff Layton <jlayton@kernel.org>
Signed-off-by: NeilBrown <neil@brown.name>

---
Changes since v5:
- drop nextop variable - only used once.
- add comment clarifying role of resp->opcnt and args->opcnt
- fix comparison between these two
- Move handling of BADHANDLE to a separate patch
---
 fs/nfsd/nfs4proc.c | 67 +++++++++++++++++-----------------------------
 fs/nfsd/nfs4xdr.c  |  2 +-
 fs/nfsd/xdr4.h     |  2 +-
 3 files changed, 27 insertions(+), 44 deletions(-)

diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
index cbf66091b0e4..112e62b6b9c6 100644
--- a/fs/nfsd/nfs4proc.c
+++ b/fs/nfsd/nfs4proc.c
@@ -693,8 +693,31 @@ nfsd4_putfh(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 	       putfh->pf_fhlen);
 	ret = fh_verify(rqstp, &cstate->current_fh, 0, NFSD_MAY_BYPASS_GSS);
 #ifdef CONFIG_NFSD_V4_2_INTER_SSC
-	if (ret == nfserr_stale && putfh->no_verify)
-		ret = 0;
+	if (ret == nfserr_stale && inter_copy_offload_enable) {
+		struct nfsd4_compoundargs *args = rqstp->rq_argp;
+		struct nfsd4_compoundres *resp = rqstp->rq_resp;
+
+		/*
+		 * args->opcnt is the number of ops in the request.
+		 * resp->opcnt is the number of ops, including this
+		 * one, that have been processed, so it points
+		 * to the next op.
+		 */
+		if (resp->opcnt < args->opcnt &&
+		    args->ops[resp->opcnt].opnum == OP_SAVEFH &&
+		    args->is_inter_server_copy) {
+			/*
+			 * RFC 7862 section 15.2.3 says:
+			 *  If a server supports the inter-server copy
+			 *  feature, a PUTFH followed by a SAVEFH MUST
+			 *  NOT return NFS4ERR_STALE for either
+			 *  operation.
+			 * We limit this to when there is a COPY
+			 * in the COMPOUND.
+			 */
+			ret = 0;
+		}
+	}
 #endif
 	return ret;
 }
@@ -2810,45 +2833,6 @@ static bool need_wrongsec_check(struct svc_rqst *rqstp)
 	return !(nextd->op_flags & OP_HANDLES_WRONGSEC);
 }
 
-#ifdef CONFIG_NFSD_V4_2_INTER_SSC
-static void
-check_if_stalefh_allowed(struct nfsd4_compoundargs *args)
-{
-	struct nfsd4_op	*op, *current_op = NULL, *saved_op = NULL;
-	struct nfsd4_copy *copy;
-	struct nfsd4_putfh *putfh;
-	int i;
-
-	/* traverse all operation and if it's a COPY compound, mark the
-	 * source filehandle to skip verification
-	 */
-	for (i = 0; i < args->opcnt; i++) {
-		op = &args->ops[i];
-		if (op->opnum == OP_PUTFH)
-			current_op = op;
-		else if (op->opnum == OP_SAVEFH)
-			saved_op = current_op;
-		else if (op->opnum == OP_RESTOREFH)
-			current_op = saved_op;
-		else if (op->opnum == OP_COPY) {
-			copy = (struct nfsd4_copy *)&op->u;
-			if (!saved_op) {
-				op->status = nfserr_nofilehandle;
-				return;
-			}
-			putfh = (struct nfsd4_putfh *)&saved_op->u;
-			if (nfsd4_ssc_is_inter(copy))
-				putfh->no_verify = true;
-		}
-	}
-}
-#else
-static void
-check_if_stalefh_allowed(struct nfsd4_compoundargs *args)
-{
-}
-#endif
-
 /*
  * COMPOUND call.
  */
@@ -2898,7 +2882,6 @@ nfsd4_proc_compound(struct svc_rqst *rqstp)
 		resp->opcnt = 1;
 		goto encode_op;
 	}
-	check_if_stalefh_allowed(args);
 
 	rqstp->rq_lease_breaker = (void **)&cstate->clp;
 
diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
index 51ef97c25456..7e44af3d10b9 100644
--- a/fs/nfsd/nfs4xdr.c
+++ b/fs/nfsd/nfs4xdr.c
@@ -1250,7 +1250,6 @@ nfsd4_decode_putfh(struct nfsd4_compoundargs *argp, union nfsd4_op_u *u)
 	if (!putfh->pf_fhval)
 		return nfserr_jukebox;
 
-	putfh->no_verify = false;
 	return nfs_ok;
 }
 
@@ -2047,6 +2046,7 @@ nfsd4_decode_copy(struct nfsd4_compoundargs *argp, union nfsd4_op_u *u)
 	if (status)
 		return status;
 
+	argp->is_inter_server_copy = true;
 	ns_dummy = kmalloc(sizeof(struct nl4_server), GFP_KERNEL);
 	if (ns_dummy == NULL)
 		return nfserr_jukebox;
diff --git a/fs/nfsd/xdr4.h b/fs/nfsd/xdr4.h
index e27258e694a9..cf2355ceb1ff 100644
--- a/fs/nfsd/xdr4.h
+++ b/fs/nfsd/xdr4.h
@@ -335,7 +335,6 @@ struct nfsd4_lookup {
 struct nfsd4_putfh {
 	u32		pf_fhlen;           /* request */
 	char		*pf_fhval;          /* request */
-	bool		no_verify;	    /* represents foreigh fh */
 };
 
 struct nfsd4_getxattr {
@@ -907,6 +906,7 @@ struct nfsd4_compoundargs {
 	u32				client_opcnt;
 	u32				opcnt;
 	bool				splice_ok;
+	bool				is_inter_server_copy;
 	struct nfsd4_op			*ops;
 	struct nfsd4_op			iops[8];
 };
-- 
2.50.0.107.gf914562f5916.dirty



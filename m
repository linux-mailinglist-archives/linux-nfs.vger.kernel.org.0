Return-Path: <linux-nfs+bounces-16510-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id B4A0AC6CA01
	for <lists+linux-nfs@lfdr.de>; Wed, 19 Nov 2025 04:35:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B9FB64EEBF3
	for <lists+linux-nfs@lfdr.de>; Wed, 19 Nov 2025 03:32:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 153C52ECD32;
	Wed, 19 Nov 2025 03:32:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b="JMAu3OZT";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="psiXUmrH"
X-Original-To: linux-nfs@vger.kernel.org
Received: from fout-b1-smtp.messagingengine.com (fout-b1-smtp.messagingengine.com [202.12.124.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CC5D2E9EC7
	for <linux-nfs@vger.kernel.org>; Wed, 19 Nov 2025 03:32:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763523152; cv=none; b=G9qoyMD+wN72PAltTp/fT6I/LoVjwrGaI9zxhJUP9EXb35y8X4+Rje4XeUCST66QgLaoDm3vwaZUzYrNrg4UZgz//Lm/yD3iK3TycjoEKtWIwoPezTf0RPb+wC0xkulYAUa1yjUXRx0Tj9rFvbmziLYXTqP7re6h85e8Wq6Ept0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763523152; c=relaxed/simple;
	bh=e3sTHoS4Bd9mzYFWV8j5ZYiWxwECpPLVb+rE5JvYF1Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=g+i51g5ocKeEQ47Mi+VjQmMWybAFhRADjLhHSU8ww5GAby613Z3BimwHLKcudsRk3TqBK3mIyGLL9B7hOH/NYkDH4wQ6VmNZpAFsw9cZo4O2DQ8V9zb7AAE+J1SjVZvO0eG7FVm8/8K9syct5PW5LpGsgkjT5C4vI4MNAbw5wXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=JMAu3OZT; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=psiXUmrH; arc=none smtp.client-ip=202.12.124.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.stl.internal (Postfix) with ESMTP id 213181D00158;
	Tue, 18 Nov 2025 22:32:29 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Tue, 18 Nov 2025 22:32:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to; s=fm3; t=1763523148;
	 x=1763609548; bh=DTnSh109Ga/gaoJ/5cfiusC2w3rK4cfim8feEOp0o2I=; b=
	JMAu3OZTHRHGL1Lt03sYOxL+qtKeYHRth11SHKPJelrHJ8UwCX/rNOP5HMHO/I7O
	Og5v0cMKK0Zbdyvxvrd4LU40uPBjUwXx/BUGSwnt9WwfRqFqP8Irzyigxgva0Sk7
	LNCgZDDTEnqqBUKPp2zNkQ/B7r5Nd+hfJyljARFX/pxMi3yExE7FUJS4ui7e6BZo
	vL3ia0h/zGxjPkzoCxfsA0kD5UYVvI+Z0gX7aL4DOMmUwtOUaw/tHc8ADMqqF+ZS
	F3Oc5s1c2vS3vWmBJbkHmK+UPgm72lysYLta/BdIl+0+I6IlFrcA7g6J0GUT5Obo
	uztf3EvonlGR8vcZB2oq5Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm3; t=1763523148; x=1763609548; bh=D
	TnSh109Ga/gaoJ/5cfiusC2w3rK4cfim8feEOp0o2I=; b=psiXUmrHEsk9T+7Y5
	IoH3e1dfxDNjti5IzRW3i8FWN3LSLSuE9MNQcpivRDjGbOJG668LA/xcXMBcRTk+
	Y5sQ7VDcdN/SBk+X+jf3s3jHrQeuIgJT+LjjbqUEmLJic4GN1S9lniCOcsOJBYG6
	3r5hB00jPmg43usgbNYgFT/zJ6bPTSmEd7dkqPMl8bX8hyc2BnJLiYap7ARGbnJH
	8YXlJVGMEpE3MUiXKe8mPS9k9cWcPY3YN9Hqe+nhjpCeF0qlN3SwjM3XCTUxFYyX
	n3PltfZBLxtAlPW9Yl9tvRlFPMs660YgZwjzZu0wZjCCMgtwGqlKTIRiPg8iUQtP
	+KySA==
X-ME-Sender: <xms:TDodactlozH5vk9EKUmuEqlp0QZhvY4Dt52KHs42HBAOsMQf8W4ZHQ>
    <xme:TDodadL6m8j82Fq1Y6_Wpv-o4444pcBjiqeQGjo4DgApBmAw4ZoMzgpG2joV56M7J
    y8Bv3vIp37MJYXYhjr0NZ-e2fe0uMSSMIJvDXfmmMPB4Fh0xQ>
X-ME-Received: <xmr:TDodaRnSHSw_P9mzmLpf8vdwpNdRvxGtXcBUl2mQXo5vrdJuaOqCgOxRVbkFhZr5DqZSNCwdxqVho-I98_rsTrBBEeZggAda5CUw2UXf6DPn>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvvdefudefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefufffkofgjfhhrggfgsedtkeertdertddtnecuhfhrohhmpefpvghilheu
    rhhofihnuceonhgvihhlsgesohifnhhmrghilhdrnhgvtheqnecuggftrfgrthhtvghrnh
    epveevkeffudeuvefhieeghffgudektdelkeejiedtjedugfeukedvkeffvdefvddunecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepnhgvihhlsg
    esohifnhhmrghilhdrnhgvthdpnhgspghrtghpthhtohepiedpmhhouggvpehsmhhtphho
    uhhtpdhrtghpthhtoheplhhinhhugidqnhhfshesvhhgvghrrdhkvghrnhgvlhdrohhrgh
    dprhgtphhtthhopehtohhmsehtrghlphgvhidrtghomhdprhgtphhtthhopehokhhorhhn
    ihgvvhesrhgvughhrghtrdgtohhmpdhrtghpthhtoheptghhuhgtkhdrlhgvvhgvrhesoh
    hrrggtlhgvrdgtohhmpdhrtghpthhtohepuggrihdrnhhgohesohhrrggtlhgvrdgtohhm
    pdhrtghpthhtohepjhhlrgihthhonheskhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:TDodaWJabtQu4L_wWuxIO-hRmQGRFW9CulcYu5v-4QEGlxvgsQ9Y5Q>
    <xmx:TDodae5W_kyb3qu1XFFUrbyyHuI5A5gIt8Q8MFoGAm-FCTnAmYWCRw>
    <xmx:TDodaS32_GCWMw-927A1QKSgGpDV7vSyGTwd1b_ztnu---zZ7ZMlkw>
    <xmx:TDodace1ZZZNxHSuxMNcJrpGs37YhBMSUJWhQCdvsQU5MOiY98I3rw>
    <xmx:TDodaaNCbR7waoGcrhiOKdQCF6IMPrRZaGddA7v8nTPqLNDYIWqylBTl>
Feedback-ID: iab3e480c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 18 Nov 2025 22:32:26 -0500 (EST)
From: NeilBrown <neilb@ownmail.net>
To: Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>
Cc: Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <Dai.Ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>,
	linux-nfs@vger.kernel.org
Subject: [PATCH v5 03/11] nfsd: simplify foreign-filehandle handling to better match RFC-7862
Date: Wed, 19 Nov 2025 14:28:49 +1100
Message-ID: <20251119033204.360415-4-neilb@ownmail.net>
X-Mailer: git-send-email 2.50.0.107.gf914562f5916.dirty
In-Reply-To: <20251119033204.360415-1-neilb@ownmail.net>
References: <20251119033204.360415-1-neilb@ownmail.net>
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
handle of the source file (presented as the saved filehandle to COPY)
is for a different ("foreign") file server which would not be expected
to be understood by this server.  fh_verify() might return nfserr_stale
or nfserr_badhandle.

In order of this filehandle to still be available to COPY, both PUTFH
and SAVEFH much not trigger an error.

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

[The RFC neglects the possibility of NFS4ERR_BADHANDLE]

Linux nfsd currently takes a different approach.  Rather than just
checking for "a PUTFH followed by a SAVEFH", it goes further to consider
only that case when this filehandle is then used for COPY, and allows
that it might have been subject of RESTOREFH and SAVEFH in between.

This is not a problem in itself except for the extra code with little
benefit.  This analysis of the COMPOUND to detect PUTFH ops which need
care is performed on every COMPOUND request, which is not necessary.

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

Signed-off-by: NeilBrown <neil@brown.name>
---
 fs/nfsd/nfs4proc.c | 64 ++++++++++++++++------------------------------
 fs/nfsd/nfs4xdr.c  |  2 +-
 fs/nfsd/xdr4.h     |  2 +-
 3 files changed, 24 insertions(+), 44 deletions(-)

diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
index 3160e899a5da..e6f8b5b907a9 100644
--- a/fs/nfsd/nfs4proc.c
+++ b/fs/nfsd/nfs4proc.c
@@ -693,8 +693,28 @@ nfsd4_putfh(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 	       putfh->pf_fhlen);
 	ret = fh_verify(rqstp, &cstate->current_fh, 0, NFSD_MAY_BYPASS_GSS);
 #ifdef CONFIG_NFSD_V4_2_INTER_SSC
-	if (ret == nfserr_stale && putfh->no_verify)
-		ret = 0;
+	if ((ret == nfserr_badhandle || ret == nfserr_stale) &&
+	    inter_copy_offload_enable) {
+		struct nfsd4_compoundargs *args = rqstp->rq_argp;
+		struct nfsd4_compoundres *resp = rqstp->rq_resp;
+		struct nfsd4_op	*next_op = &args->ops[resp->opcnt];
+
+		if (resp->opcnt <= args->opcnt &&
+		    next_op->opnum == OP_SAVEFH &&
+		    args->is_inter_server_copy) {
+			/*
+			 * RFC 7862 section 15.2.3 says:
+			 *  If a server supports the inter-server copy
+			 *  feature, a PUTFH followed by a SAVEFH MUST
+			 *  NOT return NFS4ERR_STALE for either
+			 *  operation.
+			 * We limit this to when there is a COPY
+			 * in the COMPOUND, and extend it to
+			 * NFS4ERR_BADHANDLE.
+			 */
+			ret = 0;
+		}
+	}
 #endif
 	return ret;
 }
@@ -2809,45 +2829,6 @@ static bool need_wrongsec_check(struct svc_rqst *rqstp)
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
@@ -2897,7 +2878,6 @@ nfsd4_proc_compound(struct svc_rqst *rqstp)
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
index 1f0967236cc2..3de8f4e07c49 100644
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



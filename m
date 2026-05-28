Return-Path: <linux-nfs+bounces-22054-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kFEUGQS7GGoOmwgAu9opvQ
	(envelope-from <linux-nfs+bounces-22054-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Fri, 29 May 2026 00:00:36 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 77D8B5FAB3A
	for <lists+linux-nfs@lfdr.de>; Fri, 29 May 2026 00:00:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 14D1F31B94B0
	for <lists+linux-nfs@lfdr.de>; Thu, 28 May 2026 21:55:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E30B367B7C;
	Thu, 28 May 2026 21:55:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dcvsohaE"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CB8B36493E;
	Thu, 28 May 2026 21:55:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780005333; cv=none; b=PUlohuCmxDFSnbfx2UGJWXih0JoVcMr/vlrTLGOKdz4ZGZVZ4iimopus5pLSY0ACSJK3SNbK0dtZIT3sZOKrZ+ElHXM7f/vb1VFNmRsy9M6vGCQ/PkxIPIdtdLiLma3RTbmcY10lGRHam6toM47eUuQbZzZNzKQaMKXLxeBfdR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780005333; c=relaxed/simple;
	bh=NTxvBikEtOWE6eoBgtuqv2QDtEqrRU/9xyko/1B/ClQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=g0LIgHcGYuctHWsLwLGsaNecrNjjpuieji+cVLbaWe3ZneZCYAs6M71w9MfDDFlxWJMsoTkh3OadJx1KIPyBj2raMRUfmmwWTdNot8owdKOHkmX7f8aoikm5UyjJ8kvl4XWmCet+7fDeDDOBYPxRyBxWRq5zwj3TwpkZ8+s3SEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dcvsohaE; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C4641F00A3A;
	Thu, 28 May 2026 21:55:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780005331;
	bh=dE1rjKPKQe+XjshW5SwZJ20tfVteIu00jKY4gIg77rk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=dcvsohaE9Xx/Oc+57UYR7kUrkEEcaHmBV8mz0zh+EYcvEIVaCpl+D1/E5xQFgO+GD
	 LsMH+LbKeSqfS53WtrVPPxmFFSvEke+TXqQFRgJXCvlavuX+fGT0zgLr2HEUmOWJbv
	 fRI+gSbYfPj6a8dzyg/3I1EqU7ysl1Y8pJM1KHrZeQvbCBpcnywY/mDhw3q/EO64SI
	 bhHGYTyN6Kz4ctYgT9bFvB79DmdToErSmWFiCflWCBXzH8zuwU5d5BOt8S9FntrGmW
	 fPWLf27WxYUeNgH+pUELkCqT61S3/FNdT0hsZH4H2/3u2ozV6BXpvxgx2rBRy+ijkO
	 ZLpwaWazoAuUA==
From: Jeff Layton <jlayton@kernel.org>
Date: Thu, 28 May 2026 17:55:15 -0400
Subject: [PATCH 04/10] nfsd: dedup nfs4_client_to_reclaim inserts
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260528-nfsd-fixes-v1-4-e78708eff77d@kernel.org>
References: <20260528-nfsd-fixes-v1-0-e78708eff77d@kernel.org>
In-Reply-To: <20260528-nfsd-fixes-v1-0-e78708eff77d@kernel.org>
To: Chuck Lever <chuck.lever@oracle.com>, NeilBrown <neil@brown.name>, 
 Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, 
 Tom Talpey <tom@talpey.com>, "J. Bruce Fields" <bfields@fieldses.org>, 
 Scott Mayhew <smayhew@redhat.com>, 
 Trond Myklebust <Trond.Myklebust@netapp.com>, 
 Andreas Gruenbacher <agruen@suse.de>, Mike Snitzer <snitzer@kernel.org>, 
 Rick Macklem <rmacklem@uoguelph.ca>
Cc: Chris Mason <clm@meta.com>, linux-nfs@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=5436; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=SoCWNwxU7epGWy7WggaAHHHC1Dyj0mj3LwA/2kXoKzk=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBqGLnKXEL4+gmztbEaIk9X1hLy1jUTVqOFqIsfx
 eL+C2sgG+OJAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCahi5ygAKCRAADmhBGVaC
 FSrOD/9TDFAeKF1CCHcgEU2Z3+fjfRAdcIkYwTA1B1zFMOWGs2s0g8uDvSPef9hoyEWBotCO3rw
 KvGSeTgC0JP38u+wJy44oJzR1A0awHgS3coCN3Yg2g6mz5Q2huvPOe1w26lFAjvPo386YUnbYi5
 2775Y8o6aIbKKqnNuMtAFjdOP5ii6NOvktRIwyaA7GShj8zQfMvjEuNfCHw9fVCdBab4rg0E88x
 Ane/UHLXqanJI/K+5TZbZzRLSEUq9EryV6X6JK/uLP1NG3RiIxgs7TGH4KL1qlDJlOAP8ykrO28
 PGUu5R+BrPQO4/FciisC1XtCb/OprdJwm0JVoCI7JbF7fcRYTPWuUWEtV/JOPc4i1mQyH9dWIqj
 45cv87n4ZVNid/LpqKCWHMgoOKuhuhnEyKPgzYaCGhoQrrshjfiNnnxYmh1sp9m7t78ghsTPXGI
 yGi9huwUXk/w1cgApnyFwlBAUXSs3L1OUUsCB+8lbG5HEKUBv8baPvHwhxxlSMLvjlqk2akorRQ
 OpLuyrSR4oicjcmhjLKvQh6EDPPKiKxu3NnYLZhNUVf4FEfG2yZrRBu5UpXHzwL3JsCYai3tG3g
 7g5QgrljZlnyjGSv8Y7Y1R3tsFKTAZIUU1ThGouXJD1n0rvPAHt5I4dZgUpmi9DnXGKCPUcmK5G
 VyFS6gEHGCX/8AQ==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-22054-lists,linux-nfs=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jlayton@kernel.org,linux-nfs@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-nfs];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[meta.com:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 77D8B5FAB3A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Chris Mason <clm@meta.com>

nfs4_client_to_reclaim() unconditionally allocates a new
nfs4_client_reclaim, prepends it to reclaim_str_hashtbl[], and bumps
reclaim_str_hashtbl_size with no check for an existing entry for the
same client name.  After a reboot with a populated recovery directory
that inflates the counter by one for every client that reclaims:

    boot:    load_recdir()
               nfs4_client_to_reclaim(name)   /* entry #1, size++ */

    grace:   RECLAIM_COMPLETE
               __nfsd4_create_reclaim_record_grace()
                 nfs4_client_to_reclaim(name) /* entry #2, size++ */

inc_reclaim_complete() ends the grace period early only when

    atomic_inc_return(&nn->nr_reclaim_complete) ==
        nn->reclaim_str_hashtbl_size

With reclaim_str_hashtbl_size at 2N and nr_reclaim_complete capped at
N, the equality never holds and the fast end-of-grace path is dead.
The grace period always runs out the full 90-second laundromat timer,
and the shadow entry left in the hash table carries a dangling cr_clp
for any reader that walks it.

Fix nfs4_client_to_reclaim() to compute strhashval first, look the
name up with nfsd4_find_reclaim_client(), and on a hit fold the new
princhash into the existing record (if it lacks one) and return that
record without allocating or touching reclaim_str_hashtbl_size.  On
kmemdup() failure during the fold-in, return NULL so
__cld_pipe_inprogress_downcall() surfaces -EFAULT to nfsdcld, matching
the miss-path contract.

Because the fold-in writes cr_princhash.data and cr_princhash.len on
a record that is already linked into reclaim_str_hashtbl[], pair the
two stores with smp_store_release() on .len after WRITE_ONCE() on
.data, and have nfsd4_cld_check_v2() read .len with smp_load_acquire()
before READ_ONCE() on .data, so a concurrent principal-hash check
cannot observe a torn (data, len) pair.

Fixes: 362063a595be ("nfsd: keep a tally of RECLAIM_COMPLETE operations when using nfsdcld")
Assisted-by: kres:claude-opus-4-7
Signed-off-by: Chris Mason <clm@meta.com>
---
 fs/nfsd/nfs4recover.c | 16 +++++++++++++---
 fs/nfsd/nfs4state.c   | 35 +++++++++++++++++++++++++++++++++++
 2 files changed, 48 insertions(+), 3 deletions(-)

diff --git a/fs/nfsd/nfs4recover.c b/fs/nfsd/nfs4recover.c
index 6ea25a52d2f4..f7905aa9fdce 100644
--- a/fs/nfsd/nfs4recover.c
+++ b/fs/nfsd/nfs4recover.c
@@ -1215,6 +1215,7 @@ nfsd4_cld_check_v2(struct nfs4_client *clp)
 	struct cld_net *cn = nn->cld_net;
 #endif
 	struct nfs4_client_reclaim *crp;
+	unsigned int princhashlen;
 	char *principal = NULL;
 
 	/* did we already find that this client is stable? */
@@ -1249,8 +1250,17 @@ nfsd4_cld_check_v2(struct nfs4_client *clp)
 #endif
 	return -ENOENT;
 found:
-	if (crp->cr_princhash.len) {
+	/*
+	 * nfs4_client_to_reclaim() may fold a princhash into an
+	 * already-listed reclaim record concurrently with this read.
+	 * Pair with the smp_store_release() on cr_princhash.len there:
+	 * if we observe a non-zero len we must also observe the
+	 * matching .data pointer.
+	 */
+	princhashlen = smp_load_acquire(&crp->cr_princhash.len);
+	if (princhashlen) {
 		u8 digest[SHA256_DIGEST_SIZE];
+		u8 *pdata;
 
 		if (clp->cl_cred.cr_raw_principal)
 			principal = clp->cl_cred.cr_raw_principal;
@@ -1259,8 +1269,8 @@ nfsd4_cld_check_v2(struct nfs4_client *clp)
 		if (principal == NULL)
 			return -ENOENT;
 		sha256(principal, strlen(principal), digest);
-		if (memcmp(crp->cr_princhash.data, digest,
-				crp->cr_princhash.len))
+		pdata = READ_ONCE(crp->cr_princhash.data);
+		if (memcmp(pdata, digest, princhashlen))
 			return -ENOENT;
 	}
 	crp->cr_clp = clp;
diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index dc4ac541436f..3709d0ebcd99 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -9289,6 +9289,41 @@ nfs4_client_to_reclaim(struct xdr_netobj name, struct xdr_netobj princhash,
 	unsigned int strhashval;
 	struct nfs4_client_reclaim *crp;
 
+	/*
+	 * A reclaim record for this client name may already exist (for
+	 * example, populated at boot from the recovery directory before
+	 * an in-grace RECLAIM_COMPLETE or an nfsdcld downcall delivers
+	 * the same name). Dedup here so reclaim_str_hashtbl_size stays
+	 * equal to the number of distinct client names; inc_reclaim_complete
+	 * relies on that equality to end the grace period via the fast path.
+	 */
+	crp = nfsd4_find_reclaim_client(name, nn);
+	if (crp) {
+		if (princhash.len && crp->cr_princhash.len == 0) {
+			void *pdata = kmemdup(princhash.data, princhash.len,
+					      GFP_KERNEL);
+			if (pdata) {
+				/*
+				 * crp is already linked into reclaim_str_hashtbl[]
+				 * and may be examined concurrently by
+				 * nfsd4_cld_check_v2(). Publish .data before .len
+				 * with release semantics so any reader that
+				 * observes a non-zero len via the paired
+				 * smp_load_acquire() also observes the new
+				 * data pointer.
+				 */
+				WRITE_ONCE(crp->cr_princhash.data, pdata);
+				smp_store_release(&crp->cr_princhash.len,
+						  princhash.len);
+			} else {
+				dprintk("%s: failed to allocate memory for princhash.data!\n",
+					__func__);
+				return NULL;
+			}
+		}
+		return crp;
+	}
+
 	name.data = kmemdup(name.data, name.len, GFP_KERNEL);
 	if (!name.data) {
 		dprintk("%s: failed to allocate memory for name.data!\n",

-- 
2.54.0



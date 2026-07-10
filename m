Return-Path: <linux-nfs+bounces-23237-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id vf1cK4b7UGoC9gIAu9opvQ
	(envelope-from <linux-nfs+bounces-23237-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Fri, 10 Jul 2026 16:02:46 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1886D73B8EC
	for <lists+linux-nfs@lfdr.de>; Fri, 10 Jul 2026 16:02:46 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=VljXjmGI;
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "linux-nfs+bounces-23237-lists+linux-nfs=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="linux-nfs+bounces-23237-lists+linux-nfs=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 333D8306A632
	for <lists+linux-nfs@lfdr.de>; Fri, 10 Jul 2026 14:00:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F0D03368A5;
	Fri, 10 Jul 2026 14:00:29 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B04CF2EC08C;
	Fri, 10 Jul 2026 14:00:27 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783692029; cv=none; b=bjCwBWhSzww5nIXj5DOknnKeIkw2Ubbd5SPwV98qgT/jSmy5Qit9wcTZU+dU3JgWGVsEILvow4Y6k9z5kLlUhTh2j3QR8ee+oAlAty6Cax9CCsqVdM/8R5B8q7wh4hPeTnHzJQL6FT0/UX1WObda0xWhcg+mO/E6n3cE+ClPOHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783692029; c=relaxed/simple;
	bh=EGqffs5sSmgt98DGFjwNiCWDe/cDvNCCX6tZtZoEnqk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Ej1+N+4NzR5yBt5K09qq90qKpq5aYr3unk+K4bd54siengsWsCzXSIpr68dH66MhsWb4tUsNmZbC4ECyq5Gj6IA83emqLdL/Eb3+8OJdf47tInz+Q5TB/R0QXF/GDGdZNqaGGPlWBbb1Vh61iepd9Dz/q02VW2XmEvYZcjh8d74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VljXjmGI; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9D471F00A3A;
	Fri, 10 Jul 2026 14:00:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783692027;
	bh=cCTPWZ5XejwaD5KQauVjFf9airp2G9+4vd7t/4p1S+M=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=VljXjmGIMMLGcE+QOhscacAcLwzj27+9/o+hwluVdLxifrQD9XpjimrK9dEedM1VF
	 dtGmmFGIM0YRiQh69Pt1Apn43dPjQuNDanHdNCGTPZ/JJ0C/kS6mgFPdRjd+ikmV2S
	 wufDu9kjbmZS4vkkVcZ7Rnor9ZMhXNC0zwR+GP5FHPZCAJvgAIAms3aZi2tJUIpLHZ
	 LeazZ93dr0aDgJrA9Z0jm7/14QIlauqy/PJ+tTutAP/xDttxSLayYsph9ORIGZGJL1
	 Pifho6Hiq9D+YaooIT435V7Z7pWcw3dQnDWX1UQXoI3UHlVSlmFb8viMfex/5F1Vuw
	 F+TEpgTYgk+Ag==
From: Jeff Layton <jlayton@kernel.org>
Date: Fri, 10 Jul 2026 10:00:10 -0400
Subject: [PATCH v3 06/10] nfsd: revoke copy-notify stateids before dropping
 their reference
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260710-nfsd-testing-v3-6-a0ff7db6aa3e@kernel.org>
References: <20260710-nfsd-testing-v3-0-a0ff7db6aa3e@kernel.org>
In-Reply-To: <20260710-nfsd-testing-v3-0-a0ff7db6aa3e@kernel.org>
To: Chuck Lever <cel@kernel.org>, NeilBrown <neil@brown.name>, 
 Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, 
 Tom Talpey <tom@talpey.com>
Cc: Chris Mason <clm@meta.com>, linux-nfs@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=6115; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=EGqffs5sSmgt98DGFjwNiCWDe/cDvNCCX6tZtZoEnqk=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBqUPr0T/sWt67y60BhSDgMN3WsbHPDC8LujnOjD
 ZOI6p4fhpiJAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCalD69AAKCRAADmhBGVaC
 FdyLEADRu7CBGrdIP0hJW86CG8PGYLJWpESZgVJX416isaktLr88o+BARgT5rb9q9CF+PBWOuYl
 XoW76Z3y3WIrSYiToYAFKgA2Z2bppsBFV7LIZ/8HlRpXIAbBdXNdAuq5lOEKtv7fMfU1pxynfW3
 qO15byMGwtiCn8XwimAcWRyRl4eC6nEvSnY+jWCYzPg1G7CRBmc4sa2zIVVytGJabq7L5TY4Okx
 Z6xW1Ix0pYE6sOMTr0U07PlGFJ0fNyJzSrvDTS654wn+WFMha53QbNfvcbC/yiMImomzc0hpWve
 jYSPDQkB7a9BV6FBlcSFQsIR5H3nELdEpkjjnQoPmWymKfTS3F1RTTd1XvoOAOdHvjkUt/XMYl1
 oCBAYHOa7gw6RNXBpCavfV7YdniYq1KnKFinB44gpqgXcVdbNGaBUf5bndlSJ5w+1ltQq+GxlhF
 aV+T3ANOmg1ZnLajKcCHO3tRaKfaggqGhBlnlw21en9s6zZwMnDQ2w7Spk2lcvZYnwRbXwDtUWu
 4ar8EbChVy3ycDxR1Fmg7bGHnnEawlykAxr3AGxZ5u0LFlbaE4lj93kQvQ/KgB4RSFzdvTsJHRI
 wed14d8n2ojUzsqytAwceCTBi25Y4Ltz53mI5twXjm7XJvyYXsdyUGz83t8T15nNAky/CF7sxb1
 afZjolM9C+QOIRw==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-23237-lists,linux-nfs=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:cel@kernel.org,m:neil@brown.name,m:okorniev@redhat.com,m:Dai.Ngo@oracle.com,m:tom@talpey.com,m:clm@meta.com,m:linux-nfs@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:jlayton@kernel.org,s:lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[jlayton@kernel.org,linux-nfs@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jlayton@kernel.org,linux-nfs@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	TAGGED_RCPT(0.00)[linux-nfs];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 1886D73B8EC

Copy-notify stateids live in the s2s_cp_stateids IDR and on their parent
stid's sc_cp_list, pinned by a single membership reference.
_free_cpntf_state_locked() only unlinks an entry once its refcount reaches
zero, so any revoke path that runs while a concurrent
find_cpntf_state()/manage_cpntf_state() holder has elevated cs_count drops
the reference without unlinking, leaving the entry discoverable with its
membership reference already consumed. A second revoke or a laundromat tick
then frees it while the reader still holds the pointer -- a
KASAN-detectable use-after-free at the reader's nfs4_put_cpntf_state().

This affected all three revoke paths:

  - The parent-stid drain (nfs4_free_cpntf_statelist()) repeatedly called
    _free_cpntf_state_locked() on the first list entry; a holder that had
    bumped cs_count made it return early, so the next iteration
    re-decremented and burned the holder's reference.

  - OFFLOAD_CANCEL (manage_cpntf_state()) and laundromat expiry likewise
    used _free_cpntf_state_locked() and could drop 2->1 without unlinking.

Add revoke_cpntf_state_locked(), which unhashes the entry from the IDR and
sc_cp_list first (deferring the final free to any holder), and use it from
all three revoke paths. The drain now walks with list_for_each_entry_safe()
and revokes each entry unconditionally, so it terminates in one pass per
entry regardless of cs_count. The unhash is gated on
!list_empty(&cps->cp_list); the idr_remove() gate matters because
idr_alloc_cyclic() may have recycled the so_id by then. Keep
_free_cpntf_state_locked() for the reference-holder put path only, where a
concurrent revoke may already have unlinked the entry (its list_del_init()
then a no-op).

Fixes: 624322f1adc5 ("NFSD add COPY_NOTIFY operation")
Assisted-by: Claude:claude-opus-4-7
Assisted-by: Claude:claude-opus-4-8
Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/nfsd/nfs4state.c | 78 ++++++++++++++++++++++++++++++++++++++++++-----------
 1 file changed, 62 insertions(+), 16 deletions(-)

diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index b3fe163a148d..99f450f292a0 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -1026,18 +1026,66 @@ void nfs4_free_copy_state(struct nfsd4_copy *copy)
 	spin_unlock(&nn->s2s_cp_lock);
 }
 
+/*
+ * Drop the parent's reference on an already-unlinked cpntf entry. If a
+ * concurrent holder still owns a reference, its nfs4_put_cpntf_state() does
+ * the final free.
+ *
+ * nn->s2s_cp_lock must be held.
+ */
+static void put_cpntf_state_unlinked_locked(struct nfs4_cpntf_state *cps)
+{
+	WARN_ON_ONCE(cps->cp_stateid.cs_type != NFS4_COPYNOTIFY_STID);
+	WARN_ON_ONCE(!list_empty(&cps->cp_list));
+
+	if (refcount_dec_and_test(&cps->cp_stateid.cs_count))
+		kfree(cps);
+}
+
+/*
+ * Unhash from the IDR and sc_cp_list. Gated on list_empty() to avoid
+ * evicting a recycled so_id.
+ */
+static void nfsd4_unhash_cpntf_state(struct nfsd_net *nn, struct nfs4_cpntf_state *cps)
+{
+	lockdep_assert_held(&nn->s2s_cp_lock);
+
+	if (!list_empty(&cps->cp_list)) {
+		list_del_init(&cps->cp_list);
+		idr_remove(&nn->s2s_cp_stateids, cps->cp_stateid.cs_stid.si_opaque.so_id);
+	}
+}
+
+/*
+ * Revoke a copy-notify stateid: unlink it from the IDR and sc_cp_list first
+ * so no new finder can discover it, then drop the membership reference. Every
+ * revoke path (cancel, laundromat, drain) must use this rather than
+ * _free_cpntf_state_locked(), which unlinks only at refcount zero and so could
+ * let a second revoke free the entry under a concurrent reader.
+ *
+ * nn->s2s_cp_lock must be held.
+ */
+static void revoke_cpntf_state_locked(struct nfsd_net *nn,
+				      struct nfs4_cpntf_state *cps)
+{
+	nfsd4_unhash_cpntf_state(nn, cps);
+	put_cpntf_state_unlinked_locked(cps);
+}
+
 static void nfs4_free_cpntf_statelist(struct net *net, struct nfs4_stid *stid)
 {
-	struct nfs4_cpntf_state *cps;
+	struct nfs4_cpntf_state *cps, *tmp;
 	struct nfsd_net *nn;
 
 	nn = net_generic(net, nfsd_net_id);
 	spin_lock(&nn->s2s_cp_lock);
-	while (!list_empty(&stid->sc_cp_list)) {
-		cps = list_first_entry(&stid->sc_cp_list,
-				       struct nfs4_cpntf_state, cp_list);
-		_free_cpntf_state_locked(nn, cps);
-	}
+	/*
+	 * Revoke unlinks each entry before dropping the parent's reference, so
+	 * the drain terminates in one pass per entry regardless of cs_count; a
+	 * concurrent holder does the final kfree via nfs4_put_cpntf_state().
+	 */
+	list_for_each_entry_safe(cps, tmp, &stid->sc_cp_list, cp_list)
+		revoke_cpntf_state_locked(nn, cps);
 	spin_unlock(&nn->s2s_cp_lock);
 }
 
@@ -7484,7 +7532,7 @@ nfs4_laundromat(struct nfsd_net *nn)
 		cps = container_of(cps_t, struct nfs4_cpntf_state, cp_stateid);
 		if (cps->cp_stateid.cs_type == NFS4_COPYNOTIFY_STID &&
 				state_expired(&lt, cps->cpntf_time))
-			_free_cpntf_state_locked(nn, cps);
+			revoke_cpntf_state_locked(nn, cps);
 	}
 	spin_unlock(&nn->s2s_cp_lock);
 	nfsd4_async_copy_reaper(nn);
@@ -7871,16 +7919,14 @@ nfs4_check_file(struct svc_rqst *rqstp, struct svc_fh *fhp, struct nfs4_stid *s,
 out:
 	return status;
 }
-static void
-_free_cpntf_state_locked(struct nfsd_net *nn, struct nfs4_cpntf_state *cps)
+
+static void _free_cpntf_state_locked(struct nfsd_net *nn, struct nfs4_cpntf_state *cps)
 {
 	WARN_ON_ONCE(cps->cp_stateid.cs_type != NFS4_COPYNOTIFY_STID);
-	if (!refcount_dec_and_test(&cps->cp_stateid.cs_count))
-		return;
-	list_del_init(&cps->cp_list);
-	idr_remove(&nn->s2s_cp_stateids,
-		   cps->cp_stateid.cs_stid.si_opaque.so_id);
-	kfree(cps);
+	if (refcount_dec_and_test(&cps->cp_stateid.cs_count)) {
+		nfsd4_unhash_cpntf_state(nn, cps);
+		kfree(cps);
+	}
 }
 /*
  * A READ from an inter server to server COPY will have a
@@ -7917,7 +7963,7 @@ __be32 manage_cpntf_state(struct nfsd_net *nn, stateid_t *st,
 			state = NULL;
 			goto unlock;
 		} else {
-			_free_cpntf_state_locked(nn, state);
+			revoke_cpntf_state_locked(nn, state);
 		}
 	}
 unlock:

-- 
2.55.0



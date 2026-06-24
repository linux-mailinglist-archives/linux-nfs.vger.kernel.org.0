Return-Path: <linux-nfs+bounces-22810-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 7o6kNWsZPGpfjwgAu9opvQ
	(envelope-from <linux-nfs+bounces-22810-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Wed, 24 Jun 2026 19:52:43 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BA4F6C0805
	for <lists+linux-nfs@lfdr.de>; Wed, 24 Jun 2026 19:52:43 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b="nJVNkHe/";
	spf=pass (mail.lfdr.de: domain of "linux-nfs+bounces-22810-lists+linux-nfs=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-nfs+bounces-22810-lists+linux-nfs=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 561303037D6E
	for <lists+linux-nfs@lfdr.de>; Wed, 24 Jun 2026 17:52:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69B3A3DD85C;
	Wed, 24 Jun 2026 17:52:01 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 209703DD858;
	Wed, 24 Jun 2026 17:52:00 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782323521; cv=none; b=aRffbu6/rwhfXkeFI6whJaoeW/N/QAo4ylyvPX3vcQKAD3d7w9eo8dKiDDjQaOw3KUezrrmZIXwL2VxFRQyHIIyMXGFZ+D2M93Ao9RDbBs8NLGtzL0FK4Ho1Pg0CLp5yBvSfJqQ0RVZCtS8GGyV34WvIA57L2Bvhya+zfexewXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782323521; c=relaxed/simple;
	bh=cf9nSb2sAXwkYEu6C61WzcGtrfGnoFe/QXWoePYN9Qc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=DIjzu+dw2csTrzk9uGjp3IbV0XsdaWhktHNQiryIOcFo521mHEHouj5Y2KMLqHhZKu8Q0Z4iVRM09U8zyKYG6irITAQba2r2fET4eDNBDWMTi0EEiInedycLr9zh5dBPi6uNebmddMCtWJ/seshZ7bZy66GKMvzGVtgapJ+o/ao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nJVNkHe/; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F4D41F000E9;
	Wed, 24 Jun 2026 17:51:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782323520;
	bh=0HLJNmpwhhxCnQ06zRTInz6ycwN0yBtCHVIe/Ud86fs=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=nJVNkHe/UCx1Myy8YtBUeXDd6KO1no9vSlvx+xMuDfDPCA8TLSo1icKYTz5mUOFdT
	 7s3Hg8mxjVP6vwaM6tYb8jdRgOZFMIFBwGk/PduFfnlMQl8LmaYczKsrguH8u18uf5
	 q9rUI2HTKw9ukje+a98Lc7gzm6tbPnIW7G37iPifKISPm9ufM2yiLHSbo60GF68p0A
	 8eJKTmdkzjNh+eO4SZ/yEJPoCmGt2ApoAr+CK38wEpXUD1hm3H9nk3DkvxBxfa13MA
	 TvVJVgbdz01XX4lZ0+8A99aMJ87rJiSlANEU1cBcRRZ81dbEmqQksoyFfUaeRy1xmK
	 Be81lYHHlEYoA==
From: Jeff Layton <jlayton@kernel.org>
Date: Wed, 24 Jun 2026 13:51:44 -0400
Subject: [PATCH 2/3] nfsd: fix UAF in cpntf statelist drain
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260624-nfsd-testing-v1-2-b8853eb22e45@kernel.org>
References: <20260624-nfsd-testing-v1-0-b8853eb22e45@kernel.org>
In-Reply-To: <20260624-nfsd-testing-v1-0-b8853eb22e45@kernel.org>
To: Chuck Lever <cel@kernel.org>, NeilBrown <neil@brown.name>, 
 Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, 
 Tom Talpey <tom@talpey.com>, Andy Adamson <andros@netapp.com>
Cc: Chris Mason <clm@meta.com>, linux-nfs@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=6352; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=mG2uaO35XhSsvsCasaK6PTB7uBt7lZtUP6d23x+kqaM=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBqPBk72oWTdhg0Mkfc3OkG4nldDJLR0pqwBlfHL
 rCCaya+T4SJAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCajwZOwAKCRAADmhBGVaC
 FRwID/9xvWl31+Lq4TYoyzNWCNVvfoM0MD2+byGJdqrAfxj5UA5m3I7yVJiYD+fwUlwIGsqSQsc
 03hJs81dvJD4FGAXH/YdS80nsMGjK7KZ7ueUaN7fLbf0ow9F5ouwu15c8H/eaY/sLc1VB2nxtrc
 OIIqJDkKIbMeUsChX/QXrawU9xbiXS+6YSj4f2kIrTFHWU/GtkuIm0jGQZp3YUN6UUK6J9ydxZa
 jiysj1V2HGpokwDJ7e9jU78PRBOn+cwzhvr3p3WuPvGaHZdYosNt9JkhHncVYUXi4RAFHp1hJb1
 Nr5sHJa5lA2IPPIKOWN3RsjNorQU2/yfo7N4FA8vP+2LUvApgDAA2JTIIPSKsHGwS3gcg5tdOFY
 Go8/dWsPKIahQEPdIlheRqnBwD5iqqaAkcmupv1GUwwi8C5a1w9Pr3zfwBfXdkFkP1qucicGEvY
 1t2jarMZma432Q2ceCY66mXrNmZsicpNEkjgUkkYOGyxrBfXMG2qxsCg8qC+fvPbDZ5g7GDXSSN
 3JDrSUeLE1Sp7JczXPhWjChk8WlZTDc8vD00RoCHzMTsSJ82NO/FflVUYY1CNX0O/+hcdtzLjrh
 clmi7QxaIQM3kQmrHSmoZh26/NUYcR31zWmVrevmuHmRtgJazFnGqYc/X/rjp54FMhrzBf2ob59
 Ki/TTj04dNAssVg==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-22810-lists,linux-nfs=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:cel@kernel.org,m:neil@brown.name,m:okorniev@redhat.com,m:Dai.Ngo@oracle.com,m:tom@talpey.com,m:andros@netapp.com,m:clm@meta.com,m:linux-nfs@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:jlayton@kernel.org,s:lists@lfdr.de];
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
	RCPT_COUNT_SEVEN(0.00)[10];
	TAGGED_RCPT(0.00)[linux-nfs];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,meta.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 3BA4F6C0805

From: Chris Mason <clm@meta.com>

nfs4_free_cpntf_statelist() drains a parent stid's sc_cp_list by
repeatedly taking the first entry and calling
_free_cpntf_state_locked(), which only unlinks and frees the entry
when refcount_dec_and_test() drops cs_count to zero.  When a
concurrent holder has bumped cs_count via manage_cpntf_state(),
the helper returns early and leaves the entry on sc_cp_list, so
the drain re-decrements the same entry on the next iteration and
burns the reference that belonged to that concurrent holder.

    CPU 0                              CPU 1
    -----                              -----
    find_cpntf_state()
      manage_cpntf_state(clp=NULL)
        spin_lock(&nn->s2s_cp_lock)
        refcount_inc(cs_count) 1->2
        spin_unlock(&nn->s2s_cp_lock)
      /* caller now owns a ref */
                                       nfs4_free_cpntf_statelist()
                                         spin_lock(&s2s_cp_lock)
                                         iter 1: dec_and_test 2->1
                                                 (no unlink/free)
                                         iter 2: dec_and_test 1->0
                                                 list_del + idr_remove
                                                 kfree(cps)
                                         spin_unlock(&s2s_cp_lock)
    nfs4_put_cpntf_state(cps)
      spin_lock(&s2s_cp_lock)
      _free_cpntf_state_locked(cps)    /* cps is freed slab */

The late put writes into the freed slab object's refcount_t, a
KASAN-detectable use-after-free.

Fix by rewriting the drain to unconditionally revoke each entry
before dropping the parent's reference.  Walk sc_cp_list with
list_for_each_entry_safe(), list_del_init() the entry, remove it
from nn->s2s_cp_stateids, and only then drop the parent-owned
reference via a new put_cpntf_state_unlinked_locked() helper
that does refcount_dec_and_test() + kfree().  The drain now
terminates in one pass per entry regardless of cs_count.

Concurrent holders keep their own reference; their eventual
nfs4_put_cpntf_state() reaches _free_cpntf_state_locked() on an
entry the drain has already unlinked from sc_cp_list and from
nn->s2s_cp_stateids.  _free_cpntf_state_locked() gates its
list_del_init() and idr_remove() on !list_empty(&cps->cp_list);
the drain's list_del_init() leaves cp_list self-linked, so the
late put skips both calls and only the final refcount drop runs.

Gating idr_remove() on the same check is required because
idr_alloc_cyclic() may already have recycled the so_id for an
unrelated cpntf entry by the time the late put runs; an
unconditional idr_remove() would silently unhash that live entry
and corrupt subsequent find_cpntf_state() lookups.

Fixes: 624322f1adc5 ("NFSD add COPY_NOTIFY operation")
Assisted-by: kres:claude-opus-4-7
Signed-off-by: Chris Mason <clm@meta.com>
---
 fs/nfsd/nfs4state.c | 65 ++++++++++++++++++++++++++++++++++++++++++-----------
 1 file changed, 52 insertions(+), 13 deletions(-)

diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index b8946db3ebaa..374155e57f3f 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -1025,17 +1025,58 @@ void nfs4_free_copy_state(struct nfsd4_copy *copy)
 	spin_unlock(&nn->s2s_cp_lock);
 }
 
+/*
+ * Drop the parent stid's reference on a cpntf entry that has already been
+ * removed from sc_cp_list and the s2s_cp_stateids IDR. If a concurrent holder
+ * still owns a reference (acquired viamanage_cpntf_state() before the unlink),
+ * that holder's nfs4_put_cpntf_state() will perform the final free.
+ *
+ * The nn->s2s_cp_lock must be held!
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
+ * Unhash the stateid from the s2s stateid hash, and detach it from the sc_cp_list.
+ * Note that this is gated on a list_empty() check, to avoid problems with IDR
+ * hashval reuse.
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
+	/*
+	 * Unlink every entry from sc_cp_list and the IDR before dropping
+	 * the parent's reference.  This makes the drain terminate in one
+	 * pass per entry regardless of cs_count: a concurrent holder that
+	 * obtained the entry via manage_cpntf_state() retains its own
+	 * reference, and its eventual nfs4_put_cpntf_state() will see the
+	 * entry already unlinked (list_del_init() in
+	 * _free_cpntf_state_locked makes that a no-op) and drive the final
+	 * kfree itself.
+	 */
+	list_for_each_entry_safe(cps, tmp, &stid->sc_cp_list, cp_list) {
+		nfsd4_unhash_cpntf_state(nn, cps);
+		put_cpntf_state_unlinked_locked(cps);
 	}
 	spin_unlock(&nn->s2s_cp_lock);
 }
@@ -7870,16 +7911,14 @@ nfs4_check_file(struct svc_rqst *rqstp, struct svc_fh *fhp, struct nfs4_stid *s,
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

-- 
2.54.0



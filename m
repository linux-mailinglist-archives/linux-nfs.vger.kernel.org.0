Return-Path: <linux-nfs+bounces-23012-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id azbUBy4ES2q3KwEAu9opvQ
	(envelope-from <linux-nfs+bounces-23012-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Mon, 06 Jul 2026 03:26:06 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F3EF70BE7B
	for <lists+linux-nfs@lfdr.de>; Mon, 06 Jul 2026 03:26:05 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=bft88HQV;
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "linux-nfs+bounces-23012-lists+linux-nfs=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="linux-nfs+bounces-23012-lists+linux-nfs=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 7F80E300E2AC
	for <lists+linux-nfs@lfdr.de>; Mon,  6 Jul 2026 01:26:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 056B232A3FE;
	Mon,  6 Jul 2026 01:26:02 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD2A9324B06
	for <linux-nfs@vger.kernel.org>; Mon,  6 Jul 2026 01:26:00 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783301161; cv=none; b=QuyS5Ozl0mcw/b5WvyQUfmNZlnNVW/tUmMuJDbHIubE8cy9RB2A/jqBKRBZJN04FfSpsXZmM5D9+raDBp+8tOpH8ngSd7vJ4kyoJTOt1Y4zK7XdT+QQSvx493bdAPOoHfVIMep6bBv8nQr0TD6eif5ja8VtOtUXdO2kyrtcu2bI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783301161; c=relaxed/simple;
	bh=tfGHcxuvL67BSVc7BqAnAwchj6NvBIOGRdby5ZFndoM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=OTQ58LD9HBk5YYY0Ef1sYfzWwQbM0FkY3YtPoAa6kbPlVWar3/0lBMJWwl60ZUvq0rFZo36SNERunkGQPOgxvGFIECmCQllgRD5sbwOJS/+X1TdyHLtbAOVeXux3OKOCbEH+NwOZu+Yd9pmE5dS4XEWlxy5cu5YdpISRDcer4KA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bft88HQV; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 250341F00A3A;
	Mon,  6 Jul 2026 01:26:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783301160;
	bh=cPCmDFImn4TZFAYG11yn+Eo2T+i7NfGZ0U08jzeODio=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=bft88HQVAXIfghj4g48iWSsn87XTex+zp/GJNWDKSTxqqLKjbl3WZrTiHRbYemtSq
	 dizHaFE4meRlOjjWjx5DdziyuhjuVp6xuwUfREJos+oHnuyOuJ6STZpbsO3B1px7eg
	 z6fbkYo3Vyld6qz/EDuOtp2Gmyq9dKohTlewRIfoYahGdGzvjd36c8H4bUNr1cux9X
	 Zn6UvA5kRwnr+PkjTafv9xmpcKwMt3ZosI0O9KB21D4ef8ht9u5dyx/AKFRISdlJF0
	 lMTfMs6CAmkbrTC4a/bIM4+2NpDZWLoWAhRoHinKLTwlhRlMbeskzLllwih/oIEOi1
	 2Kj8BwBHO1juA==
From: Chuck Lever <cel@kernel.org>
Date: Sun, 05 Jul 2026 21:25:38 -0400
Subject: [PATCH v2 2/6] NFSD: Prevent client use-after-free during
 delegation revoke
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260705-cel-v2-2-d88c3b68e8bc@kernel.org>
References: <20260705-cel-v2-0-d88c3b68e8bc@kernel.org>
In-Reply-To: <20260705-cel-v2-0-d88c3b68e8bc@kernel.org>
To: Jeff Layton <jlayton@kernel.org>, NeilBrown <neil@brown.name>, 
 Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, 
 Tom Talpey <tom@talpey.com>
Cc: linux-nfs@vger.kernel.org, Chuck Lever <cel@kernel.org>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=4290; i=cel@kernel.org;
 h=from:subject:message-id; bh=tfGHcxuvL67BSVc7BqAnAwchj6NvBIOGRdby5ZFndoM=;
 b=owEBbQKS/ZANAwAKATNqszNvZn+XAcsmYgBqSwQmCCeJ6eCO+NPPUB7m+EkyQelPHLD1D2HbV
 FSq3R4bAEmJAjMEAAEKAB0WIQQosuWwEobfJDzyPv4zarMzb2Z/lwUCaksEJgAKCRAzarMzb2Z/
 l+mMEACqXH7OO+Fq5p45BphnRLK2WrVIgBC4rBGMdGRUCij7KDEIZB1YEcj7hMoehMyg061QOsa
 kj/JS4OO3jMcZUoExptpY0O/5NOETZf/z+0xdiy9PlbKU8Qcgftlcvv+2L1ZILnT5UxE7UhUOCD
 D7HWGWQPYXO++xe9mHAI40UJaJsWf4yAMqtmNIZt9GUebpgaGb2M50GmLtL2ueJ5bnX4nHGFPui
 Iagl6UzBpwfrezEKjWWPMxCxKTghHZym30Vo/SM9pUtUJ7/ZQdDa6beL2JnA7WVJHMVDsS8P64i
 hKafbUzP0cVdWNp8K7DSsZnKEqqapBHm8BGUvRn9/tGFOpSmWdjbPQSNslhIzNBVCA1ZFFGZQgR
 C4uSmLTCb734ASalGNS4yYEAOxTCAXrBvYWw0QFvigy86agX7oQdtrnxNLQdoeEexRoUf9z3bX7
 0zu0wX5RekytGUseJ8Nofl38mJno9eWk1DjotSpgONBs/v8LOM635YFij+/Hxht/KlbuR5m6ZKE
 94RzX6JJ0RIRa6NUKsvC5AwXwybo7UZWfHXQsXiM1fssBRvGnA83LwbkQQhhKC9nObAsFdcTJvy
 m/jnZKHW6JRqcgdJFNeMAvMjIIP41E5Iw46cwb/lVinf277u1QeUCc8mYQ88iNx8lQqThxzPKWF
 iKtS0Q5SrekLHpg==
X-Developer-Key: i=cel@kernel.org; a=openpgp;
 fpr=28B2E5B01286DF243CF23EFE336AB3336F667F97
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-23012-lists,linux-nfs=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:jlayton@kernel.org,m:neil@brown.name,m:okorniev@redhat.com,m:Dai.Ngo@oracle.com,m:tom@talpey.com,m:linux-nfs@vger.kernel.org,m:cel@kernel.org,s:lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[cel@kernel.org,linux-nfs@vger.kernel.org];
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
	FROM_NEQ_ENVFROM(0.00)[cel@kernel.org,linux-nfs@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	TAGGED_RCPT(0.00)[linux-nfs];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 9F3EF70BE7B

A delegation stateid stores only a bare pointer to its owning
nfs4_client; a reference on the stateid does not keep the client
alive.  The client outlives its stateids solely because
__destroy_client() drains every delegation from cl_delegations and
cl_revoked before free_client() runs.

nfs4_laundromat() breaks that invariant.  It unhashes an expired
delegation from cl_delegations under deleg_lock, drops the lock, and
calls revoke_delegation(), which reacquires clp->cl_lock and links the
delegation onto clp->cl_revoked.  Between the unhash and the revoke the
delegation is on neither client-reachable list, so client_has_state()
can report no remaining state.

Every path that can free a client holding delegations first requires
cl_rpc_users to be zero: DESTROY_CLIENTID and a superseding EXCHANGE_ID
gate on mark_client_expired_locked(), and the admin "expire" write
waits in force_expire_client().  The laundromat holds no such
reference.  A client whose recalled delegation has just timed out -- a
rebooted client whose new incarnation supersedes the old one, say --
can therefore run __destroy_client() to completion and free the client
while revoke_delegation() is still about to dereference clp->cl_lock
and clp->cl_revoked, a use-after-free.

Pin the client with cl_rpc_users across the revoke so the teardown
paths block until it completes and then reap it from cl_revoked
themselves.  A client already expiring reaps its own delegations, so
skip it and leave the delegation on del_recall_lru for
__destroy_client() to handle.

Fixes: 3bd64a5ba171 ("nfsd4: implement SEQ4_STATUS_RECALLABLE_STATE_REVOKED")
Signed-off-by: Chuck Lever <cel@kernel.org>
---
 fs/nfsd/netns.h     |  6 ++++--
 fs/nfsd/nfs4state.c | 23 +++++++++++++++++++++++
 2 files changed, 27 insertions(+), 2 deletions(-)

diff --git a/fs/nfsd/netns.h b/fs/nfsd/netns.h
index 03724bef10a7..a7bd7b67fa4f 100644
--- a/fs/nfsd/netns.h
+++ b/fs/nfsd/netns.h
@@ -115,7 +115,8 @@ struct nfsd_net {
 	struct list_head client_lru;
 	struct list_head close_lru;
 
-	/* protects del_recall_lru and delegation hash/unhash */
+	/* protects del_recall_lru and delegation hash/unhash;
+	 * nests outside client_lock */
 	spinlock_t deleg_lock ____cacheline_aligned;
 	struct list_head del_recall_lru;
 
@@ -124,7 +125,8 @@ struct nfsd_net {
 
 	struct delayed_work laundromat_work;
 
-	/* client_lock protects the client lru list and session hash table */
+	/* client_lock protects the client lru list and session hash
+	 * table; nests inside deleg_lock */
 	spinlock_t client_lock;
 
 	/* protects blocked_locks_lru */
diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index e000ed3e96e9..efeb2a2e9c8f 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -7457,6 +7457,7 @@ nfs4_laundromat(struct nfsd_net *nn)
 		.new_timeo = nn->nfsd4_lease
 	};
 	struct nfs4_cpntf_state *cps;
+	struct nfs4_client *clp;
 	copy_stateid_t *cps_t;
 	int i;
 
@@ -7485,6 +7486,18 @@ nfs4_laundromat(struct nfsd_net *nn)
 		dp = list_entry (pos, struct nfs4_delegation, dl_recall_lru);
 		if (!state_expired(&lt, dp->dl_time))
 			break;
+		clp = dp->dl_stid.sc_client;
+		spin_lock(&nn->client_lock);
+		if (is_client_expired(clp)) {
+			spin_unlock(&nn->client_lock);
+			continue;
+		}
+		/*
+		 * Pin without reviving: get_client_locked() would
+		 * flip a courtesy client back to NFSD4_ACTIVE.
+		 */
+		atomic_inc(&clp->cl_rpc_users);
+		spin_unlock(&nn->client_lock);
 		refcount_inc(&dp->dl_stid.sc_count);
 		unhash_delegation_locked(dp, SC_STATUS_REVOKED);
 		list_add(&dp->dl_recall_lru, &reaplist);
@@ -7493,8 +7506,18 @@ nfs4_laundromat(struct nfsd_net *nn)
 	while (!list_empty(&reaplist)) {
 		dp = list_first_entry(&reaplist, struct nfs4_delegation,
 					dl_recall_lru);
+		clp = dp->dl_stid.sc_client;
 		list_del_init(&dp->dl_recall_lru);
 		revoke_delegation(dp);
+		/*
+		 * Unpin without renewing: put_client_renew() would
+		 * renew the reaped client's lease.
+		 */
+		if (atomic_dec_and_lock(&clp->cl_rpc_users, &nn->client_lock)) {
+			if (is_client_expired(clp))
+				wake_up_all(&expiry_wq);
+			spin_unlock(&nn->client_lock);
+		}
 	}
 
 	spin_lock(&nn->client_lock);

-- 
2.54.0



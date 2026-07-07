Return-Path: <linux-nfs+bounces-23145-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id VE6FEG9VTWoMygEAu9opvQ
	(envelope-from <linux-nfs+bounces-23145-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Tue, 07 Jul 2026 21:37:19 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EC8871F486
	for <lists+linux-nfs@lfdr.de>; Tue, 07 Jul 2026 21:37:18 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=HEEIcAgz;
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "linux-nfs+bounces-23145-lists+linux-nfs=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-nfs+bounces-23145-lists+linux-nfs=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 23A5730D4BBB
	for <lists+linux-nfs@lfdr.de>; Tue,  7 Jul 2026 19:31:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 006043148D9;
	Tue,  7 Jul 2026 19:31:44 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6740384CCE
	for <linux-nfs@vger.kernel.org>; Tue,  7 Jul 2026 19:31:42 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783452703; cv=none; b=g6yqnfYirpvbkFgVJMx87gvWChYIBgOjmLwgCcd6Mjg3NTXZVJ5YLo4lTe81yL7uJacZdogynAtVPyA8s2VZAZl2egnyRoOi4Okv0pLMmUwcANEky0P8vpA95NJJMAc45uVE9s3ifWqzR/mMQz0h2hx18ArVNo3m46Mir0/etMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783452703; c=relaxed/simple;
	bh=BGYhbIZdEt1XuBbURBJjf5k9ZTycYt/4iUjdIRqIIkQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=qncODV7XKhq5FhbQqOpcDjJeGEKT0qd/sPbt+MwsWCraWFIw8ZJaA+dj/ums9JtFEDAWxG1XMlBcPBgOOm5QNAhE/51NYstTDmLOv+0ulUcBc6cVqYEK4wF3evcD8Uf+RI6j1FFWHpZB42eAoqsthELdMG+LCUBCUuiPv3lm2oQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HEEIcAgz; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EED651F00A3F;
	Tue,  7 Jul 2026 19:31:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783452702;
	bh=7FJ5DYKe4vXr22Y21rio49hpHl4GHogFOlLHfX29HTY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=HEEIcAgzw3BnBkGAgGrSgaPhTOJMOknMuQ5rf7qfq5AIGmY017QIZiOxge0UTi+L5
	 MToNjHfYhI7FZSHlQmN6R0hg8BnE7MOavF3dFCuEIt91zIjKJpJwesmcybQ4KvSKvF
	 QZmQoj89O/1zLTNJoPdW2nlwy325YSCi8qYZM5a8G+lHXGkGuZJl5PqhVCw/2hN53O
	 cQ5cK8+kQKoTLoNfvgjlyc3VI4f6Etgf2+a7MZkl8xVB4e1zszR/ke6FcRNRPHL8du
	 8IaAKit8+PuUMkWWbEjsHYtVxeEl2WD72d4+pmYzlXhD2pgYiqhp2+q/MBfjbiDKjG
	 1auqPOUB5WMSg==
From: Chuck Lever <cel@kernel.org>
Date: Tue, 07 Jul 2026 15:31:22 -0400
Subject: [PATCH v3 2/9] NFSD: Prevent client use-after-free during
 delegation revoke
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260707-cel-v3-2-7c0cc16fd54f@kernel.org>
References: <20260707-cel-v3-0-7c0cc16fd54f@kernel.org>
In-Reply-To: <20260707-cel-v3-0-7c0cc16fd54f@kernel.org>
To: Jeff Layton <jlayton@kernel.org>, NeilBrown <neil@brown.name>, 
 Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, 
 Tom Talpey <tom@talpey.com>
Cc: linux-nfs@vger.kernel.org, Chuck Lever <cel@kernel.org>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=3853; i=cel@kernel.org;
 h=from:subject:message-id; bh=BGYhbIZdEt1XuBbURBJjf5k9ZTycYt/4iUjdIRqIIkQ=;
 b=owEBbQKS/ZANAwAKATNqszNvZn+XAcsmYgBqTVQbhTvG1icIY6pOYHUE9iGGGy/X4Rpl0W+/e
 jqOeYCPJuiJAjMEAAEKAB0WIQQosuWwEobfJDzyPv4zarMzb2Z/lwUCak1UGwAKCRAzarMzb2Z/
 l+A1D/4h+ln6FB/PlvSoPuOjeFv6NKwXFjnyf4561PeFswaf4mdJ5qfAWupPozxBOyIY4ixhbN+
 l2k0ZVWsGgD9+Wt78WErqS+a+c6cLHD3ydwOSqtuzjUt6Hl6w0LM9UFMbUM3cdQ1ZXT/K97gyrk
 j42VuUAR+gUcc+XdlKm4dhmQoc2CGa8uxNaNPqxauxuEsHvNidfWmOmRzQM2h0E0DJTC61mUEqG
 FWcjsfbnYw3USACieX9DGvYnsY9r6RcESPfTqUy+Y/lt+ru7kAOTIAZZtBbq5xhC/iuh9iKEBwU
 eB83xV0nil0Hg+SdrB1e3BQZYcFT9kiFLQ3Aqsz9CFYBgAp4ZrzRtCcqfhiyK88WABbo7qk5rj5
 Yc/lxUVXq0tsR0nHPZgC8gcG3bMjzpuqJmjg5SfwlbMu4WbkXnmA/2uv1QderaotcL7CB8z6rI9
 mjD+D7pdwW4n+dWrhjvEb0YQ8QAbVBaWU64QyiVmZqIl0qtnUucZynpU+pJD9gPREhwoxODWMrp
 mYrKBBub/bEMVJIbJY4mx3FLDE4MJbsRZOfAXdHlrhzUO1mOG68hTWuAktabX0+LljzhRODQUoK
 Bd3LHcRDD1xIIU6Vb+TVtSnLzmz3izHrxS5Ogg40cvx29WmdHv2UliPyTeCG7EeRyH0HENoP367
 4GtABLxS/cnxTYQ==
X-Developer-Key: i=cel@kernel.org; a=openpgp;
 fpr=28B2E5B01286DF243CF23EFE336AB3336F667F97
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
	TAGGED_FROM(0.00)[bounces-23145-lists,linux-nfs=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[brown.name:email,vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 8EC8871F486

A delegation stateid holds only a bare pointer to its owning
nfs4_client and does not keep it alive.  The client survives its
stateids only because __destroy_client() drains cl_delegations and
cl_revoked before free_client() runs.

nfs4_laundromat() breaks that invariant: it unhashes an
expired delegation from cl_delegations, drops deleg_lock, then
revoke_delegation() relinks it onto cl_revoked under cl_lock.  In that
window the delegation is on neither list, so client_has_state() can
report no remaining state.

Every teardown path first requires cl_rpc_users to be zero, but
the laundromat holds no such reference.  A client whose recalled
delegation has just timed out can therefore reach free_client()
while revoke_delegation() is still about to dereference cl_lock,
a use-after-free.

Pin the client with cl_rpc_users across the revoke so teardown blocks
until it completes, then reap the delegation from cl_revoked.  A client
already expiring reaps its own, so skip it and leave the delegation on
del_recall_lru.

Fixes: 3bd64a5ba171 ("nfsd4: implement SEQ4_STATUS_RECALLABLE_STATE_REVOKED")
Reviewed-by: NeilBrown <neil@brown.name>
Reviewed-by: Jeff Layton <jlayton@kernel.org>
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



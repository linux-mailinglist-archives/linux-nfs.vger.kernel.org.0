Return-Path: <linux-nfs+bounces-23191-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id LOsiHondT2qUpQIAu9opvQ
	(envelope-from <linux-nfs+bounces-23191-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Thu, 09 Jul 2026 19:42:33 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E303733EB0
	for <lists+linux-nfs@lfdr.de>; Thu, 09 Jul 2026 19:42:33 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=LIkI0JAx;
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "linux-nfs+bounces-23191-lists+linux-nfs=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="linux-nfs+bounces-23191-lists+linux-nfs=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id E7C3A306490B
	for <lists+linux-nfs@lfdr.de>; Thu,  9 Jul 2026 17:41:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0733F4195B0;
	Thu,  9 Jul 2026 17:40:42 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A89F14195A4
	for <linux-nfs@vger.kernel.org>; Thu,  9 Jul 2026 17:40:40 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783618841; cv=none; b=KRVsdLUrhxoFAPVKCPc7IDXx0dW2s8GYWyu3xa4A7AbqtXGh75cIHbfIVJUD1kWgVIUAmTofufRVFEZdmc8NWEQpd5AH+ZDE/RcwNTqRDn1NZ2b1NvigtAOYStgtz34rqJ8WrFceF7G2BwM4aYBa2EAmcZ9QeoyxyfnaNE8OM1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783618841; c=relaxed/simple;
	bh=BGYhbIZdEt1XuBbURBJjf5k9ZTycYt/4iUjdIRqIIkQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=JUcrkT2KcoFYRWODWTZ2W5ybj5oYQ+WNfAiEbR2kMAZAwkiGKPTErrMSZ7psmoYQRFw4B43MZwUZTtTW1rMinzKPwuhvz+iOyUilpN4A9H5lo14ImpwK10bviSLzwRRZRZ9sORMpFB/vaFKRwHVXAh3bunR2NpopLwwFiNIk76c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LIkI0JAx; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E24891F000E9;
	Thu,  9 Jul 2026 17:40:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783618840;
	bh=7FJ5DYKe4vXr22Y21rio49hpHl4GHogFOlLHfX29HTY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=LIkI0JAxcwnmcRgcA6lltjSyF+cMsY5AkZjvhzi0GDdNrVwq+bkMtRwDrsFA163gW
	 Zb33YAc4AOdHkq4+3RkQq97Omed9vzCk6z1Qr8XzRlcaGT1csvZZWKI8ZRDs14iSHo
	 sQS1Ty1EqRCuysTmWOWFhLpv53Sdq/MmhA3DqL2m5g+lYxWB+HJdDQDe4Ff/jl3+Pw
	 bqY3xm5nXjQCygEHAZmN3UvhK3L1w++KBcqUhayedsikbNIlkhZIITiHw99647z9kt
	 VF/UpPSS8W52TEuwQ33msJjuTbx0PI2cgTVDbRjqH6bXvO+P5+rhs7M7BJ2u0knT6+
	 Ai91iZ18ZgH/g==
From: Chuck Lever <cel@kernel.org>
Date: Thu, 09 Jul 2026 13:40:25 -0400
Subject: [PATCH v4 2/9] NFSD: Prevent client use-after-free during
 delegation revoke
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260709-cel-v4-2-1d519d9be0cb@kernel.org>
References: <20260709-cel-v4-0-1d519d9be0cb@kernel.org>
In-Reply-To: <20260709-cel-v4-0-1d519d9be0cb@kernel.org>
To: Jeff Layton <jlayton@kernel.org>, NeilBrown <neil@brown.name>, 
 Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, 
 Tom Talpey <tom@talpey.com>
Cc: linux-nfs@vger.kernel.org, Chuck Lever <cel@kernel.org>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=3853; i=cel@kernel.org;
 h=from:subject:message-id; bh=BGYhbIZdEt1XuBbURBJjf5k9ZTycYt/4iUjdIRqIIkQ=;
 b=owEBbQKS/ZANAwAKATNqszNvZn+XAcsmYgBqT90VNL1PffSyS8qm57QyyOJ6MLRHLaFxHv4KN
 BCfsBKBnjyJAjMEAAEKAB0WIQQosuWwEobfJDzyPv4zarMzb2Z/lwUCak/dFQAKCRAzarMzb2Z/
 lxkxEACzGzt3U3+feimCsve46jbeAqRf6g8oLQCO0obO2uwbHcQOD4mpcfYSzRmdmPxkUE76T9r
 l6lsLUJ1WS1pvJT58++tkvotSrKh9f3xxMesV/KcSIwIm1hBf0bmSUSwbZ+Ijv2wOpfIv5cqCaU
 pFAn18XFLbq25tZ/BYqEOhYkbIQ1jEz1jX5JUobIbRMncwGrAWRhlFt5sL04groTgeYCyYYP3w1
 NFO0Q1jZHF16c7XjO4jD7oC1wsFq1fpnGJdafb0c760lU2ERATD0VWY6XugxIgbJ6lRRjuxKBJV
 3ueIuaay53gnrz1GqsHnlO8Z8BDgR7hllmrfIVvBs+7/Le4HThJZ0Ksg5mgJnT8zrTv1jNk+TPf
 /OI1WDB1+HRK3AozJ6zv8fOo8qtz1Qp2XhlMhcv1Et1uq7wYJ5eGReE0pyGF1E4cdo0y7nbV8qI
 Hbv19BaDzpzQwfDbkfweqXfqJ+aHiCqj+e9CULa9lQmMS+dUhjlOiM4O6mGAhOEMUglZ2P15Gbe
 w2fAyzNuFeaf2r/DYeOLySCKdC83uawsvRIX6ijgpw3pw9uA/AkEaZu5nMDFEYGcu9FWUJJwlb7
 44Y/VZtvBY2qoyhfJVuMD/kiSk4ocjqrgTNAZKs0YW9sNCl1dKsFtJc/7QQ5CNxomk+X15kD7bp
 QDLDapA5gVUQZDA==
X-Developer-Key: i=cel@kernel.org; a=openpgp;
 fpr=28B2E5B01286DF243CF23EFE336AB3336F667F97
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-23191-lists,linux-nfs=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 0E303733EB0

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



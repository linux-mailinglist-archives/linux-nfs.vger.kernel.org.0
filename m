Return-Path: <linux-nfs+bounces-19172-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GBQrDdSonWnRQwQAu9opvQ
	(envelope-from <linux-nfs+bounces-19172-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Tue, 24 Feb 2026 14:34:12 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E0D7187C24
	for <lists+linux-nfs@lfdr.de>; Tue, 24 Feb 2026 14:34:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 1DB2830A4B5F
	for <lists+linux-nfs@lfdr.de>; Tue, 24 Feb 2026 13:29:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B5353A1A57;
	Tue, 24 Feb 2026 13:28:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QizqXHef"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E14743A1A51;
	Tue, 24 Feb 2026 13:28:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771939705; cv=none; b=bHRb4NlZijn9ruWs3JPCoY8Ysy/QnJfPLBRYlYVEwmp2gGZ+PZwBlvH6zIYuqANK/CaUNHouhMq+8e+ApgMVGFqIsGv4tsckEM1Nc24LIq25FDAESYRocmfo5JlMRwUjyRoF8Ge6fZ7ZwgQTHOEW57PZBLCkHsf81CfXZaIIkdo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771939705; c=relaxed/simple;
	bh=ecpyfmt7sagFtOFRnMqdB6HCO/23PI7SqpgvAoLfjXM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=CvncfmsKjnptrR3kKVP95/5S+9lxf3W+4EMx2yuSOVFeXMTS9LBx1o756iYJ0dURoTslwLAsJRwkFUZBmDXxz+EdU1Ytat7bVKvQfEt70pY2XZ6W91C9ajaCbu3f/ABBlZ2bYW6o5CumZpPRxYWuEdaBUIjiHzFlPoRJNQzaDVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QizqXHef; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 022ACC19424;
	Tue, 24 Feb 2026 13:28:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771939704;
	bh=ecpyfmt7sagFtOFRnMqdB6HCO/23PI7SqpgvAoLfjXM=;
	h=From:Date:Subject:To:Cc:From;
	b=QizqXHef2pdrVJIBVVfGuPvqGUwG2s27AOEpR/7SSMz1hHo2KpnoH1mEHiSiZ4Xkf
	 VHufBL2mx4BeGbsqBhU8OyEz/bDTd+akVxGbB7Xk7/6EuznegfiK9pQUKrjKG7b64n
	 4bR4ZzXlTrYYPL8RO9OyOrSesV7wexKS9BI+sGnN+JybsdokbNL62F1f9zxsGX+KO+
	 ibWtMWU+VXVb46ZeiaQsmpjrVEIVuaWkdTFkolMfOZ3F1V4W+8U5MnzkNJuZpf3F8E
	 JugQjYIBZihnfnIhjqT1ymynbzZKAnSFUW7EW9dGul4glz/VHRk61XZW0Wt1tBDMKa
	 e1/6laf2IRBTw==
From: Jeff Layton <jlayton@kernel.org>
Date: Tue, 24 Feb 2026 08:28:11 -0500
Subject: [PATCH] nfsd: convert global state_lock to per-net deleg_lock
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260224-nfsd-deleg-lock-v1-1-1df17c1daa47@kernel.org>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/x3MMQqAMAxA0atIZgO1jQ5eRRykSTUoVVoQQXp3i
 +Mb/n8hS1LJMDYvJLk16xkrurYBvy1xFVSuBmvsYKwljCEzshyy4nH6HalnY4icd46hVleSoM9
 /nOZSPhhAuklhAAAA
X-Change-ID: 20260224-nfsd-deleg-lock-45d00443c33d
To: Chuck Lever <chuck.lever@oracle.com>, NeilBrown <neil@brown.name>, 
 Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, 
 Tom Talpey <tom@talpey.com>
Cc: linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=10292; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=ecpyfmt7sagFtOFRnMqdB6HCO/23PI7SqpgvAoLfjXM=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBpnadzk13U61unstwxXd93LvW71TTZgZ/y1trF/
 9+tpMAcqnOJAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCaZ2ncwAKCRAADmhBGVaC
 FXfED/4rVabKsWk20qu3j+E6k14uWApXEH0nFr62YFLYQgW6/RyG/ziWVxUPcNtcEv5CSU02eY4
 +ZmZzsMNsgpFEvzan7HuK/9Nl1+jgYlQ2V6t1fFmZyv0F9CXLWH2DQ4tAH0LDBFZZK0LPUWXwfB
 Et9+5XK3qPPLiEkiromEJd7cCufp7xXpNQiS2TDG87vvZzbcj5lHE3bQxGPddVGHHOltmNMY49c
 4CNtSU2pERb4PWs2Kiv96IruGB/j6ot8txJHCAbyiExCzoJaP+hsOl2V3IM/7lVp1VTUC4IejbU
 1L6GKlZ1gJsKXSQTI9FdiL5d79DHMley8U6k1Y3cmjX+pldMAT6vWA8rIBLyyzi6CXsmCakw5Hu
 pcYJ0xSdmwQIomdMmwEahojgHFZ3WuDZrpqChs7dnqWX3EvDCJNU8aEFb9mgmEEvFD+jFqTNymF
 xQp9Lf8uqeGAvxUcUSYkKrjDs8UPgLJIbSXn8K934NyM1GEPS4zSFNI2ZJ7bzdObJ9pJqXW2LHh
 nEK/P8AVYxn+ZwcNl/eYy1xMAXMzE08gcKEiDGsSGBIwmSi5G48go39dxy4fudj6oOpRAdiV51g
 Hg27awALlJ69qIcKN+vC1OIFoB2XCuHyJOM5i3oQsPZvPqK9ZvFws0dbqjZ59cUTTtOYtaLxumS
 ia1HfEgGUBlcnWg==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-19172-lists,linux-nfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jlayton@kernel.org,linux-nfs@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 2E0D7187C24
X-Rspamd-Action: no action

Replace the global state_lock spinlock with a per-nfsd_net deleg_lock.
The state_lock was only used to protect delegation lifecycle operations
(the del_recall_lru list and delegation hash/unhash), all of which are
scoped to a single network namespace. Making the lock per-net removes
a source of unnecessary contention between containers.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/nfsd/netns.h     |  3 +++
 fs/nfsd/nfs4state.c | 62 +++++++++++++++++++++++++++--------------------------
 fs/nfsd/state.h     |  2 +-
 3 files changed, 36 insertions(+), 31 deletions(-)

diff --git a/fs/nfsd/netns.h b/fs/nfsd/netns.h
index 0071cc25fbc23282d928c6cb9a8c5468c4560c33..71193dd96b58680172cc6b55f8eaf8fe437a3323 100644
--- a/fs/nfsd/netns.h
+++ b/fs/nfsd/netns.h
@@ -101,6 +101,9 @@ struct nfsd_net {
 	struct list_head close_lru;
 	struct list_head del_recall_lru;
 
+	/* protects del_recall_lru and delegation hash/unhash */
+	spinlock_t deleg_lock;
+
 	/* protected by blocked_locks_lock */
 	struct list_head blocked_locks_lru;
 
diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index 1d31f2bb21622680e04238be861d4040da7d2f01..ba49f49bb93b9f590a0afa9910c7c2058f9b11e4 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -93,13 +93,6 @@ static void deleg_reaper(struct nfsd_net *nn);
 
 /* Locking: */
 
-/*
- * Currently used for the del_recall_lru and file hash table.  In an
- * effort to decrease the scope of the client_mutex, this spinlock may
- * eventually cover more:
- */
-static DEFINE_SPINLOCK(state_lock);
-
 enum nfsd4_st_mutex_lock_subclass {
 	OPEN_STATEID_MUTEX = 0,
 	LOCK_STATEID_MUTEX = 1,
@@ -1295,8 +1288,9 @@ nfs4_delegation_exists(struct nfs4_client *clp, struct nfs4_file *fp)
 {
 	struct nfs4_delegation *searchdp = NULL;
 	struct nfs4_client *searchclp = NULL;
+	struct nfsd_net *nn = net_generic(clp->net, nfsd_net_id);
 
-	lockdep_assert_held(&state_lock);
+	lockdep_assert_held(&nn->deleg_lock);
 	lockdep_assert_held(&fp->fi_lock);
 
 	list_for_each_entry(searchdp, &fp->fi_delegations, dl_perfile) {
@@ -1325,8 +1319,9 @@ static int
 hash_delegation_locked(struct nfs4_delegation *dp, struct nfs4_file *fp)
 {
 	struct nfs4_client *clp = dp->dl_stid.sc_client;
+	struct nfsd_net *nn = net_generic(clp->net, nfsd_net_id);
 
-	lockdep_assert_held(&state_lock);
+	lockdep_assert_held(&nn->deleg_lock);
 	lockdep_assert_held(&fp->fi_lock);
 	lockdep_assert_held(&clp->cl_lock);
 
@@ -1348,8 +1343,10 @@ static bool
 unhash_delegation_locked(struct nfs4_delegation *dp, unsigned short statusmask)
 {
 	struct nfs4_file *fp = dp->dl_stid.sc_file;
+	struct nfsd_net *nn = net_generic(dp->dl_stid.sc_client->net,
+					  nfsd_net_id);
 
-	lockdep_assert_held(&state_lock);
+	lockdep_assert_held(&nn->deleg_lock);
 
 	if (!delegation_hashed(dp))
 		return false;
@@ -1374,10 +1371,12 @@ unhash_delegation_locked(struct nfs4_delegation *dp, unsigned short statusmask)
 static void destroy_delegation(struct nfs4_delegation *dp)
 {
 	bool unhashed;
+	struct nfsd_net *nn = net_generic(dp->dl_stid.sc_client->net,
+					  nfsd_net_id);
 
-	spin_lock(&state_lock);
+	spin_lock(&nn->deleg_lock);
 	unhashed = unhash_delegation_locked(dp, SC_STATUS_CLOSED);
-	spin_unlock(&state_lock);
+	spin_unlock(&nn->deleg_lock);
 	if (unhashed)
 		destroy_unhashed_deleg(dp);
 }
@@ -1840,11 +1839,11 @@ void nfsd4_revoke_states(struct nfsd_net *nn, struct super_block *sb)
 				case SC_TYPE_DELEG:
 					refcount_inc(&stid->sc_count);
 					dp = delegstateid(stid);
-					spin_lock(&state_lock);
+					spin_lock(&nn->deleg_lock);
 					if (!unhash_delegation_locked(
 						    dp, SC_STATUS_ADMIN_REVOKED))
 						dp = NULL;
-					spin_unlock(&state_lock);
+					spin_unlock(&nn->deleg_lock);
 					if (dp)
 						revoke_delegation(dp);
 					break;
@@ -2510,13 +2509,13 @@ __destroy_client(struct nfs4_client *clp)
 	struct nfs4_delegation *dp;
 	LIST_HEAD(reaplist);
 
-	spin_lock(&state_lock);
+	spin_lock(&nn->deleg_lock);
 	while (!list_empty(&clp->cl_delegations)) {
 		dp = list_entry(clp->cl_delegations.next, struct nfs4_delegation, dl_perclnt);
 		unhash_delegation_locked(dp, SC_STATUS_CLOSED);
 		list_add(&dp->dl_recall_lru, &reaplist);
 	}
-	spin_unlock(&state_lock);
+	spin_unlock(&nn->deleg_lock);
 	while (!list_empty(&reaplist)) {
 		dp = list_entry(reaplist.next, struct nfs4_delegation, dl_recall_lru);
 		list_del_init(&dp->dl_recall_lru);
@@ -5427,12 +5426,12 @@ static void nfsd4_cb_recall_prepare(struct nfsd4_callback *cb)
 	 * If the dl_time != 0, then we know that it has already been
 	 * queued for a lease break. Don't queue it again.
 	 */
-	spin_lock(&state_lock);
+	spin_lock(&nn->deleg_lock);
 	if (delegation_hashed(dp) && dp->dl_time == 0) {
 		dp->dl_time = ktime_get_boottime_seconds();
 		list_add_tail(&dp->dl_recall_lru, &nn->del_recall_lru);
 	}
-	spin_unlock(&state_lock);
+	spin_unlock(&nn->deleg_lock);
 }
 
 static int nfsd4_cb_recall_done(struct nfsd4_callback *cb,
@@ -6064,6 +6063,7 @@ nfs4_set_delegation(struct nfsd4_open *open, struct nfs4_ol_stateid *stp,
 {
 	bool deleg_ts = nfsd4_want_deleg_timestamps(open);
 	struct nfs4_client *clp = stp->st_stid.sc_client;
+	struct nfsd_net *nn = net_generic(clp->net, nfsd_net_id);
 	struct nfs4_file *fp = stp->st_stid.sc_file;
 	struct nfs4_clnt_odstate *odstate = stp->st_clnt_odstate;
 	struct nfs4_delegation *dp;
@@ -6123,7 +6123,7 @@ nfs4_set_delegation(struct nfsd4_open *open, struct nfs4_ol_stateid *stp,
 		return ERR_PTR(-EOPNOTSUPP);
 	}
 
-	spin_lock(&state_lock);
+	spin_lock(&nn->deleg_lock);
 	spin_lock(&fp->fi_lock);
 	if (nfs4_delegation_exists(clp, fp))
 		status = -EAGAIN;
@@ -6138,7 +6138,7 @@ nfs4_set_delegation(struct nfsd4_open *open, struct nfs4_ol_stateid *stp,
 	} else
 		fp->fi_delegees++;
 	spin_unlock(&fp->fi_lock);
-	spin_unlock(&state_lock);
+	spin_unlock(&nn->deleg_lock);
 	if (nf)
 		nfsd_file_put(nf);
 	if (status)
@@ -6182,13 +6182,13 @@ nfs4_set_delegation(struct nfsd4_open *open, struct nfs4_ol_stateid *stp,
 	if (fp->fi_had_conflict)
 		goto out_unlock;
 
-	spin_lock(&state_lock);
+	spin_lock(&nn->deleg_lock);
 	spin_lock(&clp->cl_lock);
 	spin_lock(&fp->fi_lock);
 	status = hash_delegation_locked(dp, fp);
 	spin_unlock(&fp->fi_lock);
 	spin_unlock(&clp->cl_lock);
-	spin_unlock(&state_lock);
+	spin_unlock(&nn->deleg_lock);
 
 	if (status)
 		goto out_unlock;
@@ -6964,7 +6964,7 @@ nfs4_laundromat(struct nfsd_net *nn)
 
 	nfs40_clean_admin_revoked(nn, &lt);
 
-	spin_lock(&state_lock);
+	spin_lock(&nn->deleg_lock);
 	list_for_each_safe(pos, next, &nn->del_recall_lru) {
 		dp = list_entry (pos, struct nfs4_delegation, dl_recall_lru);
 		if (!state_expired(&lt, dp->dl_time))
@@ -6973,7 +6973,7 @@ nfs4_laundromat(struct nfsd_net *nn)
 		unhash_delegation_locked(dp, SC_STATUS_REVOKED);
 		list_add(&dp->dl_recall_lru, &reaplist);
 	}
-	spin_unlock(&state_lock);
+	spin_unlock(&nn->deleg_lock);
 	while (!list_empty(&reaplist)) {
 		dp = list_first_entry(&reaplist, struct nfs4_delegation,
 					dl_recall_lru);
@@ -8996,6 +8996,7 @@ static int nfs4_state_create_net(struct net *net)
 	INIT_LIST_HEAD(&nn->client_lru);
 	INIT_LIST_HEAD(&nn->close_lru);
 	INIT_LIST_HEAD(&nn->del_recall_lru);
+	spin_lock_init(&nn->deleg_lock);
 	spin_lock_init(&nn->client_lock);
 	spin_lock_init(&nn->s2s_cp_lock);
 	idr_init(&nn->s2s_cp_stateids);
@@ -9127,13 +9128,13 @@ nfs4_state_shutdown_net(struct net *net)
 	locks_end_grace(&nn->nfsd4_manager);
 
 	INIT_LIST_HEAD(&reaplist);
-	spin_lock(&state_lock);
+	spin_lock(&nn->deleg_lock);
 	list_for_each_safe(pos, next, &nn->del_recall_lru) {
 		dp = list_entry (pos, struct nfs4_delegation, dl_recall_lru);
 		unhash_delegation_locked(dp, SC_STATUS_CLOSED);
 		list_add(&dp->dl_recall_lru, &reaplist);
 	}
-	spin_unlock(&state_lock);
+	spin_unlock(&nn->deleg_lock);
 	list_for_each_safe(pos, next, &reaplist) {
 		dp = list_entry (pos, struct nfs4_delegation, dl_recall_lru);
 		list_del_init(&dp->dl_recall_lru);
@@ -9456,6 +9457,7 @@ nfsd_get_dir_deleg(struct nfsd4_compound_state *cstate,
 		   struct nfsd_file *nf)
 {
 	struct nfs4_client *clp = cstate->clp;
+	struct nfsd_net *nn = net_generic(clp->net, nfsd_net_id);
 	struct nfs4_delegation *dp;
 	struct file_lease *fl;
 	struct nfs4_file *fp, *rfp;
@@ -9479,7 +9481,7 @@ nfsd_get_dir_deleg(struct nfsd4_compound_state *cstate,
 	}
 
 	/* if this client already has one, return that it's unavailable */
-	spin_lock(&state_lock);
+	spin_lock(&nn->deleg_lock);
 	spin_lock(&fp->fi_lock);
 	/* existing delegation? */
 	if (nfs4_delegation_exists(clp, fp)) {
@@ -9491,7 +9493,7 @@ nfsd_get_dir_deleg(struct nfsd4_compound_state *cstate,
 		++fp->fi_delegees;
 	}
 	spin_unlock(&fp->fi_lock);
-	spin_unlock(&state_lock);
+	spin_unlock(&nn->deleg_lock);
 
 	if (status) {
 		put_nfs4_file(fp);
@@ -9520,13 +9522,13 @@ nfsd_get_dir_deleg(struct nfsd4_compound_state *cstate,
 	 * trying to set a delegation on the same file. If that happens,
 	 * then just say UNAVAIL.
 	 */
-	spin_lock(&state_lock);
+	spin_lock(&nn->deleg_lock);
 	spin_lock(&clp->cl_lock);
 	spin_lock(&fp->fi_lock);
 	status = hash_delegation_locked(dp, fp);
 	spin_unlock(&fp->fi_lock);
 	spin_unlock(&clp->cl_lock);
-	spin_unlock(&state_lock);
+	spin_unlock(&nn->deleg_lock);
 
 	if (!status) {
 		put_nfs4_file(fp);
diff --git a/fs/nfsd/state.h b/fs/nfsd/state.h
index 4a246b07dee0f88af2cd7383d46329512363ff83..07528004989edc4c09694ae97aa0d5ed0e6dd5cd 100644
--- a/fs/nfsd/state.h
+++ b/fs/nfsd/state.h
@@ -123,7 +123,7 @@ struct nfs4_stid {
 #define SC_TYPE_LAYOUT		BIT(3)
 	unsigned short		sc_type;
 
-/* state_lock protects sc_status for delegation stateids.
+/* nn->deleg_lock protects sc_status for delegation stateids.
  * ->cl_lock protects sc_status for open and lock stateids.
  * ->st_mutex also protect sc_status for open stateids.
  * ->ls_lock protects sc_status for layout stateids.

---
base-commit: 9affc4c96f49744c7eab647d922fc82d290834b2
change-id: 20260224-nfsd-deleg-lock-45d00443c33d

Best regards,
-- 
Jeff Layton <jlayton@kernel.org>



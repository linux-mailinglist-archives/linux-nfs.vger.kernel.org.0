Return-Path: <linux-nfs+bounces-2132-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A5E4686D826
	for <lists+linux-nfs@lfdr.de>; Fri,  1 Mar 2024 01:10:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A9EDC1C20DE8
	for <lists+linux-nfs@lfdr.de>; Fri,  1 Mar 2024 00:10:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F24BE17E;
	Fri,  1 Mar 2024 00:10:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="VGB2QD0J";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="bd+vr29u";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="VGB2QD0J";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="bd+vr29u"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0906D365
	for <linux-nfs@vger.kernel.org>; Fri,  1 Mar 2024 00:10:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709251818; cv=none; b=meRG898OpRyKRKm7TjJLRCu6gbR/+Z+FM296YKVdBCQtGY6vI0Mz5fE/8iz2dOn7FYUfnu5q1JH469h+TO9erII2IvihquRZAT+Qv/IfrYcMao2KAY/NCPL4Zf5u/PdMhYWUYUc5mP2IYejtGUJ7MkzpSfTZrdf4pNrXPKGStcs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709251818; c=relaxed/simple;
	bh=+AboxGb62em+KGVWRFHAd2/9u6cSbqyKvRCixdLjXZE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Fnm9tPt6kWhM7xaP6eheRsqlshZQRqt3wnXAowO0IHjAs7gKXUt3Ouz0Rw7+ZqfUUWlSiSgR4+wKqlGwy0wqNbyY4hb3oSthabFE1GV9tbZ162jQA3S1erZr7+5DlG4rmLVLWATAD+GyFQBZS7SNO+GC7gYeqrNDKY4YE4f1cg4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=VGB2QD0J; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=bd+vr29u; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=VGB2QD0J; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=bd+vr29u; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 178541F814;
	Fri,  1 Mar 2024 00:10:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1709251815; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=V0erjh0+e81QFKq/QeT9ISBY7sIMd7Ps9vcYmTt40zg=;
	b=VGB2QD0J9XkV7PqFtbpNCDER4W2lh1eQYrIpIRYXVVkOEMuqLdMpLtOg4XjHVhxDN7g0JP
	nwqfymts9DU67oJ5hHYbGjbjcsMXktHIc/C9MyiN6Hbe5ndPVU6Iw+QYvhtm0UT2IiR5K9
	wLjd47XfOkSYz0WkatIXrEGNts6pBWs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1709251815;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=V0erjh0+e81QFKq/QeT9ISBY7sIMd7Ps9vcYmTt40zg=;
	b=bd+vr29uCnGMtYGA8AbM8Kb4ANPkIdVghso3aLvI1q+qJevtlN316GOUk0e9SB3jTS5Jx1
	1VthP6kyLFDO4aDw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1709251815; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=V0erjh0+e81QFKq/QeT9ISBY7sIMd7Ps9vcYmTt40zg=;
	b=VGB2QD0J9XkV7PqFtbpNCDER4W2lh1eQYrIpIRYXVVkOEMuqLdMpLtOg4XjHVhxDN7g0JP
	nwqfymts9DU67oJ5hHYbGjbjcsMXktHIc/C9MyiN6Hbe5ndPVU6Iw+QYvhtm0UT2IiR5K9
	wLjd47XfOkSYz0WkatIXrEGNts6pBWs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1709251815;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=V0erjh0+e81QFKq/QeT9ISBY7sIMd7Ps9vcYmTt40zg=;
	b=bd+vr29uCnGMtYGA8AbM8Kb4ANPkIdVghso3aLvI1q+qJevtlN316GOUk0e9SB3jTS5Jx1
	1VthP6kyLFDO4aDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C9A2813AB0;
	Fri,  1 Mar 2024 00:10:12 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 1iJTHuQc4WW4JwAAD6G6ig
	(envelope-from <neilb@suse.de>); Fri, 01 Mar 2024 00:10:12 +0000
From: NeilBrown <neilb@suse.de>
To: Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>
Cc: linux-nfs@vger.kernel.org,
	Olga Kornievskaia <kolga@netapp.com>,
	Dai Ngo <Dai.Ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>
Subject: [PATCH 2/3] nfsd: replace rp_mutex to avoid deadlock in move_to_close_lru()
Date: Fri,  1 Mar 2024 11:07:38 +1100
Message-ID: <20240301000950.2306-3-neilb@suse.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240301000950.2306-1-neilb@suse.de>
References: <20240301000950.2306-1-neilb@suse.de>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp-out2.suse.de;
	none
X-Spam-Level: 
X-Spam-Score: 0.70
X-Spamd-Result: default: False [0.70 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 R_MISSING_CHARSET(2.50)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 BROKEN_CONTENT_TYPE(1.50)[];
	 RCPT_COUNT_FIVE(0.00)[6];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 MID_CONTAINS_FROM(1.00)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-3.00)[100.00%]
X-Spam-Flag: NO

move_to_close_lru() waits for sc_count to become zero while holding
rp_mutex.  This can deadlock if another thread holds a reference and is
waiting for rp_mutex.

By the time we get to move_to_close_lru() the openowner is unhashed and
cannot be found any more.  So code waiting for the mutex can safely
retry the lookup if move_to_close_lru() has started.

So change rp_mutex to an atomic_t with three states:

 RP_UNLOCK   - state is still hashed, not locked for reply
 RP_LOCKED   - state is still hashed, is locked for reply
 RP_UNHASHED - state is now hashed, no code can get a lock.

Use wait_ver_event() to wait for either a lock, or for the owner to be
unhashed.  In the latter case, retry the lookup.

Signed-off-by: NeilBrown <neilb@suse.de>
---
 fs/nfsd/nfs4state.c | 46 ++++++++++++++++++++++++++++++++++++---------
 fs/nfsd/state.h     |  2 +-
 2 files changed, 38 insertions(+), 10 deletions(-)

diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index e625f738f7b0..5dab316932d3 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -4442,21 +4442,32 @@ nfsd4_init_leases_net(struct nfsd_net *nn)
 	atomic_set(&nn->nfsd_courtesy_clients, 0);
 }
 
+enum rp_lock {
+	RP_UNLOCKED,
+	RP_LOCKED,
+	RP_UNHASHED,
+};
+
 static void init_nfs4_replay(struct nfs4_replay *rp)
 {
 	rp->rp_status = nfserr_serverfault;
 	rp->rp_buflen = 0;
 	rp->rp_buf = rp->rp_ibuf;
-	mutex_init(&rp->rp_mutex);
+	atomic_set(&rp->rp_locked, RP_UNLOCKED);
 }
 
-static void nfsd4_cstate_assign_replay(struct nfsd4_compound_state *cstate,
-		struct nfs4_stateowner *so)
+static int nfsd4_cstate_assign_replay(struct nfsd4_compound_state *cstate,
+				      struct nfs4_stateowner *so)
 {
 	if (!nfsd4_has_session(cstate)) {
-		mutex_lock(&so->so_replay.rp_mutex);
+		wait_var_event(&so->so_replay.rp_locked,
+			       atomic_cmpxchg(&so->so_replay.rp_locked,
+					      RP_UNLOCKED, RP_LOCKED) != RP_LOCKED);
+		if (atomic_read(&so->so_replay.rp_locked) == RP_UNHASHED)
+			return -EAGAIN;
 		cstate->replay_owner = nfs4_get_stateowner(so);
 	}
+	return 0;
 }
 
 void nfsd4_cstate_clear_replay(struct nfsd4_compound_state *cstate)
@@ -4465,7 +4476,8 @@ void nfsd4_cstate_clear_replay(struct nfsd4_compound_state *cstate)
 
 	if (so != NULL) {
 		cstate->replay_owner = NULL;
-		mutex_unlock(&so->so_replay.rp_mutex);
+		atomic_set(&so->so_replay.rp_locked, RP_UNLOCKED);
+		wake_up_var(&so->so_replay.rp_locked);
 		nfs4_put_stateowner(so);
 	}
 }
@@ -4691,7 +4703,11 @@ move_to_close_lru(struct nfs4_ol_stateid *s, struct net *net)
 	 * Wait for the refcount to drop to 2. Since it has been unhashed,
 	 * there should be no danger of the refcount going back up again at
 	 * this point.
+	 * Some threads with a reference might be waiting for rp_locked,
+	 * so tell them to stop waiting.
 	 */
+	atomic_set(&oo->oo_owner.so_replay.rp_locked, RP_UNHASHED);
+	wake_up_var(&oo->oo_owner.so_replay.rp_locked);
 	wait_event(close_wq, refcount_read(&s->st_stid.sc_count) == 2);
 
 	release_all_access(s);
@@ -5064,6 +5080,7 @@ nfsd4_process_open1(struct nfsd4_compound_state *cstate,
 	clp = cstate->clp;
 
 	strhashval = ownerstr_hashval(&open->op_owner);
+retry:
 	oo = find_openstateowner_str(strhashval, open, clp);
 	open->op_openowner = oo;
 	if (!oo)
@@ -5074,17 +5091,24 @@ nfsd4_process_open1(struct nfsd4_compound_state *cstate,
 		open->op_openowner = NULL;
 		goto new_owner;
 	}
-	nfsd4_cstate_assign_replay(cstate, &oo->oo_owner);
+	if (nfsd4_cstate_assign_replay(cstate, &oo->oo_owner) == -EAGAIN) {
+		nfs4_put_stateowner(&oo->oo_owner);
+		goto retry;
+	}
 	status = nfsd4_check_seqid(cstate, &oo->oo_owner, open->op_seqid);
 	if (status)
 		return status;
 	goto alloc_stateid;
 new_owner:
 	oo = alloc_init_open_stateowner(strhashval, open, cstate);
+	open->op_openowner = oo;
 	if (oo == NULL)
 		return nfserr_jukebox;
-	open->op_openowner = oo;
-	nfsd4_cstate_assign_replay(cstate, &oo->oo_owner);
+	if (nfsd4_cstate_assign_replay(cstate, &oo->oo_owner) == -EAGAIN) {
+		WARN_ON(1);
+		nfs4_put_stateowner(&oo->oo_owner);
+		goto new_owner;
+	}
 alloc_stateid:
 	open->op_stp = nfs4_alloc_open_stateid(clp);
 	if (!open->op_stp)
@@ -6841,11 +6865,15 @@ nfs4_preprocess_seqid_op(struct nfsd4_compound_state *cstate, u32 seqid,
 	trace_nfsd_preprocess(seqid, stateid);
 
 	*stpp = NULL;
+retry:
 	status = nfsd4_lookup_stateid(cstate, stateid, typemask, &s, nn);
 	if (status)
 		return status;
 	stp = openlockstateid(s);
-	nfsd4_cstate_assign_replay(cstate, stp->st_stateowner);
+	if (nfsd4_cstate_assign_replay(cstate, stp->st_stateowner) == -EAGAIN) {
+		nfs4_put_stateowner(stp->st_stateowner);
+		goto retry;
+	}
 
 	status = nfs4_seqid_op_checks(cstate, stateid, seqid, stp);
 	if (!status)
diff --git a/fs/nfsd/state.h b/fs/nfsd/state.h
index 41bdc913fa71..6a3becd86112 100644
--- a/fs/nfsd/state.h
+++ b/fs/nfsd/state.h
@@ -446,7 +446,7 @@ struct nfs4_replay {
 	unsigned int		rp_buflen;
 	char			*rp_buf;
 	struct knfsd_fh		rp_openfh;
-	struct mutex		rp_mutex;
+	atomic_t		rp_locked;
 	char			rp_ibuf[NFSD4_REPLAY_ISIZE];
 };
 
-- 
2.43.0



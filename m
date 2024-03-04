Return-Path: <linux-nfs+bounces-2192-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 92C3B87104F
	for <lists+linux-nfs@lfdr.de>; Mon,  4 Mar 2024 23:47:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0C89D1F213E7
	for <lists+linux-nfs@lfdr.de>; Mon,  4 Mar 2024 22:47:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 132461C6AB;
	Mon,  4 Mar 2024 22:47:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="V8shjRLM";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="pTuUrile";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="V8shjRLM";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="pTuUrile"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F28D3C28
	for <linux-nfs@vger.kernel.org>; Mon,  4 Mar 2024 22:47:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709592472; cv=none; b=VWvCey5ny6NgNroGCOKF6txDmFdIz9g36AIol9GJtE2aIqef4xa8UPzxD2EYspk7MrgE2k2tqeUYQJjmY6DhqF12DKtmojYBNbiRyMLsIZp8/9hHpkKIKDJR30UbYqj6+7D8qImrfyNtljsujumhlqQCmApXA5Uq+5c4A8czMyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709592472; c=relaxed/simple;
	bh=V1hcneIotSeCrFpbAmjAwhDv7pfINQYDCyNKY5q+0Sk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iWvaenWCpYrA8mWrE65FqNRWn0mFB+bSPxFbkTnYmsfbif626X58FDqU0Lp6m3vmSL0lWW6H1rNMwWaQvYD+8CXdGcVHd/GB/ypY38yFJXxZZNpDTYARLF2x63l4PXeaBoQxuatpX0Hjwo/HfoYiQ8m6VVGEWjOg6RF6J2Ggj1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=V8shjRLM; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=pTuUrile; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=V8shjRLM; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=pTuUrile; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id B6A6720D1A;
	Mon,  4 Mar 2024 22:47:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1709592468; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YnqQWOAjh9G3g8aEhgj8k1CV1fcCF81WwpX6/O/o5Nc=;
	b=V8shjRLMFqAvfzl+QLMx0+ptXEPshSawXFAFga0KKolbQUuq/IFJa8Vw/sI5QL845djk6w
	gVU7yF7byBosroaHmoS5oO6Nkg1RohuoVaNsrUJG2CVBIEcxF8g74Grmi+TocpxzSKBw5k
	neYJp0Z426erRJbnXJaBEbC/gdQs9gQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1709592468;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YnqQWOAjh9G3g8aEhgj8k1CV1fcCF81WwpX6/O/o5Nc=;
	b=pTuUrilemZAJhAG3ujGnQz+ReIs4FkYR8a9KHq0hNM4AHea9HVoZ3BP2iKJwfmd7b2mp+A
	xdXdxsulNnrqf+Bg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1709592468; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YnqQWOAjh9G3g8aEhgj8k1CV1fcCF81WwpX6/O/o5Nc=;
	b=V8shjRLMFqAvfzl+QLMx0+ptXEPshSawXFAFga0KKolbQUuq/IFJa8Vw/sI5QL845djk6w
	gVU7yF7byBosroaHmoS5oO6Nkg1RohuoVaNsrUJG2CVBIEcxF8g74Grmi+TocpxzSKBw5k
	neYJp0Z426erRJbnXJaBEbC/gdQs9gQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1709592468;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YnqQWOAjh9G3g8aEhgj8k1CV1fcCF81WwpX6/O/o5Nc=;
	b=pTuUrilemZAJhAG3ujGnQz+ReIs4FkYR8a9KHq0hNM4AHea9HVoZ3BP2iKJwfmd7b2mp+A
	xdXdxsulNnrqf+Bg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 1F8D513A5B;
	Mon,  4 Mar 2024 22:47:45 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id iepHLZFP5mU0YgAAD6G6ig
	(envelope-from <neilb@suse.de>); Mon, 04 Mar 2024 22:47:45 +0000
From: NeilBrown <neilb@suse.de>
To: Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>
Cc: linux-nfs@vger.kernel.org,
	Olga Kornievskaia <kolga@netapp.com>,
	Dai Ngo <Dai.Ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>
Subject: [PATCH 3/4] nfsd: replace rp_mutex to avoid deadlock in move_to_close_lru()
Date: Tue,  5 Mar 2024 09:45:23 +1100
Message-ID: <20240304224714.10370-4-neilb@suse.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240304224714.10370-1-neilb@suse.de>
References: <20240304224714.10370-1-neilb@suse.de>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp-out2.suse.de;
	none
X-Spam-Level: ***
X-Spam-Score: 3.59
X-Spamd-Result: default: False [3.59 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 R_MISSING_CHARSET(2.50)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 NEURAL_SPAM_SHORT(2.69)[0.896];
	 BROKEN_CONTENT_TYPE(1.50)[];
	 RCPT_COUNT_FIVE(0.00)[6];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
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
 RP_UNHASHED - state is not hashed, no code can get a lock.

Use wait_var_event() to wait for either a lock, or for the owner to be
unhashed.  In the latter case, retry the lookup.

Signed-off-by: NeilBrown <neilb@suse.de>
---
 fs/nfsd/nfs4state.c | 43 ++++++++++++++++++++++++++++++++++++-------
 fs/nfsd/state.h     |  2 +-
 2 files changed, 37 insertions(+), 8 deletions(-)

diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index 0c1058e8cc4b..52838db0c46e 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -4639,21 +4639,37 @@ nfsd4_init_leases_net(struct nfsd_net *nn)
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
+		/*
+		 * rp_locked is an open-coded mutex which is unlocked in
+		 * nfsd4_cstate_clear_replay() or aborted in
+		 * move_to_close_lru().
+		 */
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
@@ -4662,7 +4678,8 @@ void nfsd4_cstate_clear_replay(struct nfsd4_compound_state *cstate)
 
 	if (so != NULL) {
 		cstate->replay_owner = NULL;
-		mutex_unlock(&so->so_replay.rp_mutex);
+		atomic_set(&so->so_replay.rp_locked, RP_UNLOCKED);
+		wake_up_var(&so->so_replay.rp_locked);
 		nfs4_put_stateowner(so);
 	}
 }
@@ -4958,7 +4975,11 @@ move_to_close_lru(struct nfs4_ol_stateid *s, struct net *net)
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
@@ -5331,11 +5352,15 @@ nfsd4_process_open1(struct nfsd4_compound_state *cstate,
 	clp = cstate->clp;
 
 	strhashval = ownerstr_hashval(&open->op_owner);
+retry:
 	oo = find_or_alloc_open_stateowner(strhashval, open, cstate);
 	open->op_openowner = oo;
 	if (!oo)
 		return nfserr_jukebox;
-	nfsd4_cstate_assign_replay(cstate, &oo->oo_owner);
+	if (nfsd4_cstate_assign_replay(cstate, &oo->oo_owner) == -EAGAIN) {
+		nfs4_put_stateowner(&oo->oo_owner);
+		goto retry;
+	}
 	status = nfsd4_check_seqid(cstate, &oo->oo_owner, open->op_seqid);
 	if (status)
 		return status;
@@ -7175,12 +7200,16 @@ nfs4_preprocess_seqid_op(struct nfsd4_compound_state *cstate, u32 seqid,
 	trace_nfsd_preprocess(seqid, stateid);
 
 	*stpp = NULL;
+retry:
 	status = nfsd4_lookup_stateid(cstate, stateid,
 				      typemask, statusmask, &s, nn);
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
index 01c6f3445646..0400441c87c1 100644
--- a/fs/nfsd/state.h
+++ b/fs/nfsd/state.h
@@ -486,7 +486,7 @@ struct nfs4_replay {
 	unsigned int		rp_buflen;
 	char			*rp_buf;
 	struct knfsd_fh		rp_openfh;
-	struct mutex		rp_mutex;
+	atomic_t		rp_locked;
 	char			rp_ibuf[NFSD4_REPLAY_ISIZE];
 };
 
-- 
2.43.0



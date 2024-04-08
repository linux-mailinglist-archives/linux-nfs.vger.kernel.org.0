Return-Path: <linux-nfs+bounces-2708-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A945689B5D7
	for <lists+linux-nfs@lfdr.de>; Mon,  8 Apr 2024 04:12:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 366E61F216AB
	for <lists+linux-nfs@lfdr.de>; Mon,  8 Apr 2024 02:12:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3E8C17F7;
	Mon,  8 Apr 2024 02:12:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="jf5Pb4oj";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="mOLU3T83";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="jf5Pb4oj";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="mOLU3T83"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44FBF17F6
	for <linux-nfs@vger.kernel.org>; Mon,  8 Apr 2024 02:12:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712542352; cv=none; b=PyUJcDAlmcg6mjwty2kYWjtcdlQxEeP+V9DHyzXk4y67ZLPtWtWXUubQJh9dsX+02cG7QEot+oNiAroPt3ugGcWu7N5P2vibyzXKKk86xxZtRVh2U7MazV+s+MW+QD7PmyPKxOMA4IWQWvn+Da/B42KplpT/wzoscxp1Nckct/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712542352; c=relaxed/simple;
	bh=4+1jW8rvKKo0X0Vj88GK3Sn1b7yh2wE7iFTuiqMLNoA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=inkLIxYYYtg5cAYUrrGHS8z+8xPWZSB4XrixXchPEhg8xfD8WaemYXr4qMsUaAegiuZ4BUrSRP2/KvioxVbJebD01IRkuVuVi1dOqkA5MZx524LrCpvgRa9j2l4mTKn3VNt7FQDHdPMUJF5FQwlI9HeYIzcSByyzc3dHhDrUtFo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=jf5Pb4oj; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=mOLU3T83; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=jf5Pb4oj; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=mOLU3T83; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 92CF321851;
	Mon,  8 Apr 2024 02:12:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1712542349; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GRRI21b0IxSVQnvS4WmoIdkkj9iGueVlrC2MbKpsE2M=;
	b=jf5Pb4ojh6QuNvexQQKLrd4aa0VYmYOp7ScDx6BDWMlxqZ+Ddg/1JYFjyKruhBBLO6fM4C
	RfiTJckN4Vinnr2ZpHSA9RbwoQx8Ms8+HlxD4Gcr2Wi1C+1Q/slJlncz7ZMzkoahc6jZnS
	x3/wgTumj+kjylus+zMKmZi6A/jCYk4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1712542349;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GRRI21b0IxSVQnvS4WmoIdkkj9iGueVlrC2MbKpsE2M=;
	b=mOLU3T83XXJRwXIxBlXRgBgp9LMdorv/kTiqlxDDkZAoztPlF5JY4nZRY9elFoC9PwDKXP
	/6HDHxHevGWE3SCQ==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=jf5Pb4oj;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=mOLU3T83
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1712542349; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GRRI21b0IxSVQnvS4WmoIdkkj9iGueVlrC2MbKpsE2M=;
	b=jf5Pb4ojh6QuNvexQQKLrd4aa0VYmYOp7ScDx6BDWMlxqZ+Ddg/1JYFjyKruhBBLO6fM4C
	RfiTJckN4Vinnr2ZpHSA9RbwoQx8Ms8+HlxD4Gcr2Wi1C+1Q/slJlncz7ZMzkoahc6jZnS
	x3/wgTumj+kjylus+zMKmZi6A/jCYk4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1712542349;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GRRI21b0IxSVQnvS4WmoIdkkj9iGueVlrC2MbKpsE2M=;
	b=mOLU3T83XXJRwXIxBlXRgBgp9LMdorv/kTiqlxDDkZAoztPlF5JY4nZRY9elFoC9PwDKXP
	/6HDHxHevGWE3SCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E98C813796;
	Mon,  8 Apr 2024 02:12:26 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id LfSTIopSE2YHEgAAD6G6ig
	(envelope-from <neilb@suse.de>); Mon, 08 Apr 2024 02:12:26 +0000
From: NeilBrown <neilb@suse.de>
To: Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>
Cc: linux-nfs@vger.kernel.org,
	Olga Kornievskaia <kolga@netapp.com>,
	Dai Ngo <Dai.Ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>
Subject: [PATCH 3/4] nfsd: replace rp_mutex to avoid deadlock in move_to_close_lru()
Date: Mon,  8 Apr 2024 12:09:17 +1000
Message-ID: <20240408021156.6104-4-neilb@suse.de>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240408021156.6104-1-neilb@suse.de>
References: <20240408021156.6104-1-neilb@suse.de>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Flag: NO
X-Spam-Score: -3.01
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 92CF321851
X-Spam-Level: 
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	TO_DN_SOME(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	FROM_HAS_DN(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns]

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

Reviewed-by: Jeff Layton <jlayton@kernel.org>
Signed-off-by: NeilBrown <neilb@suse.de>
---
 fs/nfsd/nfs4state.c | 38 +++++++++++++++++++++++++++++++-------
 fs/nfsd/state.h     |  2 +-
 2 files changed, 32 insertions(+), 8 deletions(-)

diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index 2ff8cb50f2e3..5dbd1a73bc28 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -4664,21 +4664,32 @@ nfsd4_init_leases_net(struct nfsd_net *nn)
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
@@ -4687,7 +4698,8 @@ void nfsd4_cstate_clear_replay(struct nfsd4_compound_state *cstate)
 
 	if (so != NULL) {
 		cstate->replay_owner = NULL;
-		mutex_unlock(&so->so_replay.rp_mutex);
+		atomic_set(&so->so_replay.rp_locked, RP_UNLOCKED);
+		wake_up_var(&so->so_replay.rp_locked);
 		nfs4_put_stateowner(so);
 	}
 }
@@ -4983,7 +4995,11 @@ move_to_close_lru(struct nfs4_ol_stateid *s, struct net *net)
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
@@ -5356,11 +5372,15 @@ nfsd4_process_open1(struct nfsd4_compound_state *cstate,
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
@@ -7200,12 +7220,16 @@ nfs4_preprocess_seqid_op(struct nfsd4_compound_state *cstate, u32 seqid,
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
index 7f33b89f3b2c..f42d8d782c84 100644
--- a/fs/nfsd/state.h
+++ b/fs/nfsd/state.h
@@ -488,7 +488,7 @@ struct nfs4_replay {
 	unsigned int		rp_buflen;
 	char			*rp_buf;
 	struct knfsd_fh		rp_openfh;
-	struct mutex		rp_mutex;
+	atomic_t		rp_locked;
 	char			rp_ibuf[NFSD4_REPLAY_ISIZE];
 };
 
-- 
2.44.0



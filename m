Return-Path: <linux-nfs+bounces-8528-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 443949ED904
	for <lists+linux-nfs@lfdr.de>; Wed, 11 Dec 2024 22:49:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 72CD7164FA9
	for <lists+linux-nfs@lfdr.de>; Wed, 11 Dec 2024 21:49:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 750541F0E3F;
	Wed, 11 Dec 2024 21:49:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="N9jWnKYR";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="Y5xOIjkw";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="N9jWnKYR";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="Y5xOIjkw"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B0F11EC4D0
	for <linux-nfs@vger.kernel.org>; Wed, 11 Dec 2024 21:49:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733953774; cv=none; b=N971QkAt/+AF3qpP78I+MtaaG/8rxHBxJPtrdJbqCRHFj7uBJZTNdb+O0lKPVBXjmYYH7J20OAXgwVPC7fkrm0D/k9LjTvA5aLvBMKXMj3AlSc8r0jlT3gb8OwGqYQSURNjptPqDr9SPsd1ew06icJ9IFcFP4O7+J2yN1Rhg/fg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733953774; c=relaxed/simple;
	bh=SPXWRlNj9MrK9DPjwHjiSgkVq6XS85l0G4+bzf7r7p4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hQQj4P0U2YJ+Q2RB58ldbv7OgArRlMzPa4KpDY4Ev31ARI+VwvwUxP2FoNk/RFtMhggD48wU9/ecnF9CW1UPMu9E8vlVULE58Q5b9BNMNYDDNiK2brl2+xQiYDOeqGtsCGDod80P+HUXGTNqfoBsFDmTc16XiEKZ77i/mDb+wMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=N9jWnKYR; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=Y5xOIjkw; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=N9jWnKYR; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=Y5xOIjkw; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id CFC4F21181;
	Wed, 11 Dec 2024 21:49:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1733953769; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=e90EOqnfP7xyfGmBwGs39Py3URlmjVCBnQrX5Lez29w=;
	b=N9jWnKYRTFo2pTLD7NX3dyP188ckwyh+TjVVBISDtSp99vKOogBSrwAE1BzG2DTmb38Vs2
	BwYEfq2L7NNaRP8XGeMHt0ogxh2CVFag1MggiHGn3vwQZa0uyfTuFO+Ogf1foMHbnkonIp
	xTNmy1hi7FbaF9/LDRNJKB4rWBLHPic=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1733953769;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=e90EOqnfP7xyfGmBwGs39Py3URlmjVCBnQrX5Lez29w=;
	b=Y5xOIjkw9j3Lezp3dkQR2Lcc4RkpPSO/7UQuGfYXJHkz9QFK7kjkAdevIMS5gT+XI7POkc
	e9/4LwoEo0iAe9DQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1733953769; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=e90EOqnfP7xyfGmBwGs39Py3URlmjVCBnQrX5Lez29w=;
	b=N9jWnKYRTFo2pTLD7NX3dyP188ckwyh+TjVVBISDtSp99vKOogBSrwAE1BzG2DTmb38Vs2
	BwYEfq2L7NNaRP8XGeMHt0ogxh2CVFag1MggiHGn3vwQZa0uyfTuFO+Ogf1foMHbnkonIp
	xTNmy1hi7FbaF9/LDRNJKB4rWBLHPic=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1733953769;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=e90EOqnfP7xyfGmBwGs39Py3URlmjVCBnQrX5Lez29w=;
	b=Y5xOIjkw9j3Lezp3dkQR2Lcc4RkpPSO/7UQuGfYXJHkz9QFK7kjkAdevIMS5gT+XI7POkc
	e9/4LwoEo0iAe9DQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 6D21F1344A;
	Wed, 11 Dec 2024 21:49:27 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id fuj6COcIWmfeMgAAD6G6ig
	(envelope-from <neilb@suse.de>); Wed, 11 Dec 2024 21:49:27 +0000
From: NeilBrown <neilb@suse.de>
To: Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>
Cc: linux-nfs@vger.kernel.org,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <Dai.Ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>
Subject: [PATCH 5/6] nfsd: add support for freeing unused session-DRC slots
Date: Thu, 12 Dec 2024 08:47:08 +1100
Message-ID: <20241211214842.2022679-6-neilb@suse.de>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241211214842.2022679-1-neilb@suse.de>
References: <20241211214842.2022679-1-neilb@suse.de>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	R_RATELIMIT(0.00)[from(RLewrxuus8mos16izbn)];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.de:mid];
	RCVD_TLS_ALL(0.00)[]
X-Spam-Score: -2.80
X-Spam-Flag: NO

Reducing the number of slots in the session slot table requires
confirmation from the client.  This patch adds reduce_session_slots()
which starts the process of getting confirmation, but never calls it.
That will come in a later patch.

Before we can free a slot we need to confirm that the client won't try
to use it again.  This involves returning a lower cr_maxrequests in a
SEQUENCE reply and then seeing a ca_maxrequests on the same slot which
is not larger than we limit we are trying to impose.  So for each slot
we need to remember that we have sent a reduced cr_maxrequests.

To achieve this we introduce a concept of request "generations".  Each
time we decide to reduce cr_maxrequests we increment the generation
number, and record this when we return the lower cr_maxrequests to the
client.  When a slot with the current generation reports a low
ca_maxrequests, we commit to that level and free extra slots.

We use an 16 bit generation number (64 seems wasteful) and if it cycles
we iterate all slots and reset the generation number to avoid false matches.

When we free a slot we store the seqid in the slot pointer so that it can
be restored when we reactivate the slot.  The RFC can be read as
suggesting that the slot number could restart from one after a slot is
retired and reactivated, but also suggests that retiring slots is not
required.  So when we reactive a slot we accept with the next seqid in
sequence, or 1.

When decoding sa_highest_slotid into maxslots we need to add 1 - this
matches how it is encoded for the reply.

se_dead is moved in struct nfsd4_session to remove a hole.

Reviewed-by: Jeff Layton <jlayton@kernel.org>
Signed-off-by: NeilBrown <neilb@suse.de>
---
 fs/nfsd/nfs4state.c | 94 ++++++++++++++++++++++++++++++++++++++++-----
 fs/nfsd/nfs4xdr.c   |  5 ++-
 fs/nfsd/state.h     |  6 ++-
 fs/nfsd/xdr4.h      |  2 -
 4 files changed, 92 insertions(+), 15 deletions(-)

diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index fd9473d487f3..a2d1f97b8a0e 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -1910,17 +1910,69 @@ gen_sessionid(struct nfsd4_session *ses)
 #define NFSD_MIN_HDR_SEQ_SZ  (24 + 12 + 44)
 
 static void
-free_session_slots(struct nfsd4_session *ses)
+free_session_slots(struct nfsd4_session *ses, int from)
 {
 	int i;
 
-	for (i = 0; i < ses->se_fchannel.maxreqs; i++) {
+	if (from >= ses->se_fchannel.maxreqs)
+		return;
+
+	for (i = from; i < ses->se_fchannel.maxreqs; i++) {
 		struct nfsd4_slot *slot = xa_load(&ses->se_slots, i);
 
-		xa_erase(&ses->se_slots, i);
+		/*
+		 * Save the seqid in case we reactivate this slot.
+		 * This will never require a memory allocation so GFP
+		 * flag is irrelevant
+		 */
+		xa_store(&ses->se_slots, i, xa_mk_value(slot->sl_seqid), 0);
 		free_svc_cred(&slot->sl_cred);
 		kfree(slot);
 	}
+	ses->se_fchannel.maxreqs = from;
+	if (ses->se_target_maxslots > from)
+		ses->se_target_maxslots = from;
+}
+
+/**
+ * reduce_session_slots - reduce the target max-slots of a session if possible
+ * @ses:  The session to affect
+ * @dec:  how much to decrease the target by
+ *
+ * This interface can be used by a shrinker to reduce the target max-slots
+ * for a session so that some slots can eventually be freed.
+ * It uses spin_trylock() as it may be called in a context where another
+ * spinlock is held that has a dependency on client_lock.  As shrinkers are
+ * best-effort, skiping a session is client_lock is already held has no
+ * great coast
+ *
+ * Return value:
+ *   The number of slots that the target was reduced by.
+ */
+static int __maybe_unused
+reduce_session_slots(struct nfsd4_session *ses, int dec)
+{
+	struct nfsd_net *nn = net_generic(ses->se_client->net,
+					  nfsd_net_id);
+	int ret = 0;
+
+	if (ses->se_target_maxslots <= 1)
+		return ret;
+	if (!spin_trylock(&nn->client_lock))
+		return ret;
+	ret = min(dec, ses->se_target_maxslots-1);
+	ses->se_target_maxslots -= ret;
+	ses->se_slot_gen += 1;
+	if (ses->se_slot_gen == 0) {
+		int i;
+		ses->se_slot_gen = 1;
+		for (i = 0; i < ses->se_fchannel.maxreqs; i++) {
+			struct nfsd4_slot *slot = xa_load(&ses->se_slots, i);
+			slot->sl_generation = 0;
+		}
+	}
+	spin_unlock(&nn->client_lock);
+	return ret;
 }
 
 /*
@@ -1968,6 +2020,7 @@ static struct nfsd4_session *alloc_session(struct nfsd4_channel_attrs *fattrs,
 	}
 	fattrs->maxreqs = i;
 	memcpy(&new->se_fchannel, fattrs, sizeof(struct nfsd4_channel_attrs));
+	new->se_target_maxslots = i;
 	new->se_cb_slot_avail = ~0U;
 	new->se_cb_highest_slot = min(battrs->maxreqs - 1,
 				      NFSD_BC_SLOT_TABLE_SIZE - 1);
@@ -2081,7 +2134,7 @@ static void nfsd4_del_conns(struct nfsd4_session *s)
 
 static void __free_session(struct nfsd4_session *ses)
 {
-	free_session_slots(ses);
+	free_session_slots(ses, 0);
 	xa_destroy(&ses->se_slots);
 	kfree(ses);
 }
@@ -2684,6 +2737,9 @@ static int client_info_show(struct seq_file *m, void *v)
 	seq_printf(m, "session slots:");
 	list_for_each_entry(ses, &clp->cl_sessions, se_perclnt)
 		seq_printf(m, " %u", ses->se_fchannel.maxreqs);
+	seq_printf(m, "\nsession target slots:");
+	list_for_each_entry(ses, &clp->cl_sessions, se_perclnt)
+		seq_printf(m, " %u", ses->se_target_maxslots);
 	spin_unlock(&clp->cl_lock);
 	seq_puts(m, "\n");
 
@@ -3674,10 +3730,10 @@ nfsd4_exchange_id_release(union nfsd4_op_u *u)
 	kfree(exid->server_impl_name);
 }
 
-static __be32 check_slot_seqid(u32 seqid, u32 slot_seqid, bool slot_inuse)
+static __be32 check_slot_seqid(u32 seqid, u32 slot_seqid, u8 flags)
 {
 	/* The slot is in use, and no response has been sent. */
-	if (slot_inuse) {
+	if (flags & NFSD4_SLOT_INUSE) {
 		if (seqid == slot_seqid)
 			return nfserr_jukebox;
 		else
@@ -3686,6 +3742,8 @@ static __be32 check_slot_seqid(u32 seqid, u32 slot_seqid, bool slot_inuse)
 	/* Note unsigned 32-bit arithmetic handles wraparound: */
 	if (likely(seqid == slot_seqid + 1))
 		return nfs_ok;
+	if ((flags & NFSD4_SLOT_REUSED) && seqid == 1)
+		return nfs_ok;
 	if (seqid == slot_seqid)
 		return nfserr_replay_cache;
 	return nfserr_seq_misordered;
@@ -4236,8 +4294,7 @@ nfsd4_sequence(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 	dprintk("%s: slotid %d\n", __func__, seq->slotid);
 
 	trace_nfsd_slot_seqid_sequence(clp, seq, slot);
-	status = check_slot_seqid(seq->seqid, slot->sl_seqid,
-					slot->sl_flags & NFSD4_SLOT_INUSE);
+	status = check_slot_seqid(seq->seqid, slot->sl_seqid, slot->sl_flags);
 	if (status == nfserr_replay_cache) {
 		status = nfserr_seq_misordered;
 		if (!(slot->sl_flags & NFSD4_SLOT_INITIALIZED))
@@ -4262,6 +4319,12 @@ nfsd4_sequence(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 	if (status)
 		goto out_put_session;
 
+	if (session->se_target_maxslots < session->se_fchannel.maxreqs &&
+	    slot->sl_generation == session->se_slot_gen &&
+	    seq->maxslots <= session->se_target_maxslots)
+		/* Client acknowledged our reduce maxreqs */
+		free_session_slots(session, session->se_target_maxslots);
+
 	buflen = (seq->cachethis) ?
 			session->se_fchannel.maxresp_cached :
 			session->se_fchannel.maxresp_sz;
@@ -4272,9 +4335,11 @@ nfsd4_sequence(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 	svc_reserve(rqstp, buflen);
 
 	status = nfs_ok;
-	/* Success! bump slot seqid */
+	/* Success! accept new slot seqid */
 	slot->sl_seqid = seq->seqid;
+	slot->sl_flags &= ~NFSD4_SLOT_REUSED;
 	slot->sl_flags |= NFSD4_SLOT_INUSE;
+	slot->sl_generation = session->se_slot_gen;
 	if (seq->cachethis)
 		slot->sl_flags |= NFSD4_SLOT_CACHETHIS;
 	else
@@ -4291,9 +4356,11 @@ nfsd4_sequence(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 	 * the client might use.
 	 */
 	if (seq->slotid == session->se_fchannel.maxreqs - 1 &&
+	    session->se_target_maxslots >= session->se_fchannel.maxreqs &&
 	    session->se_fchannel.maxreqs < NFSD_MAX_SLOTS_PER_SESSION) {
 		int s = session->se_fchannel.maxreqs;
 		int cnt = DIV_ROUND_UP(s, 5);
+		void *prev_slot;
 
 		do {
 			/*
@@ -4303,18 +4370,25 @@ nfsd4_sequence(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 			 */
 			slot = kzalloc(slot_bytes(&session->se_fchannel),
 				       GFP_NOWAIT);
+			prev_slot = xa_load(&session->se_slots, s);
+			if (xa_is_value(prev_slot) && slot) {
+				slot->sl_seqid = xa_to_value(prev_slot);
+				slot->sl_flags |= NFSD4_SLOT_REUSED;
+			}
 			if (slot &&
 			    !xa_is_err(xa_store(&session->se_slots, s, slot,
 						GFP_NOWAIT))) {
 				s += 1;
 				session->se_fchannel.maxreqs = s;
+				session->se_target_maxslots = s;
 			} else {
 				kfree(slot);
 				slot = NULL;
 			}
 		} while (slot && --cnt > 0);
 	}
-	seq->maxslots = session->se_fchannel.maxreqs;
+	seq->maxslots = max(session->se_target_maxslots, seq->maxslots);
+	seq->target_maxslots = session->se_target_maxslots;
 
 out:
 	switch (clp->cl_cb_state) {
diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
index 53fac037611c..4dcb03cd9292 100644
--- a/fs/nfsd/nfs4xdr.c
+++ b/fs/nfsd/nfs4xdr.c
@@ -1884,7 +1884,8 @@ nfsd4_decode_sequence(struct nfsd4_compoundargs *argp,
 		return nfserr_bad_xdr;
 	seq->seqid = be32_to_cpup(p++);
 	seq->slotid = be32_to_cpup(p++);
-	seq->maxslots = be32_to_cpup(p++);
+	/* sa_highest_slotid counts from 0 but maxslots  counts from 1 ... */
+	seq->maxslots = be32_to_cpup(p++) + 1;
 	seq->cachethis = be32_to_cpup(p);
 
 	seq->status_flags = 0;
@@ -4968,7 +4969,7 @@ nfsd4_encode_sequence(struct nfsd4_compoundres *resp, __be32 nfserr,
 	if (nfserr != nfs_ok)
 		return nfserr;
 	/* sr_target_highest_slotid */
-	nfserr = nfsd4_encode_slotid4(xdr, seq->maxslots - 1);
+	nfserr = nfsd4_encode_slotid4(xdr, seq->target_maxslots - 1);
 	if (nfserr != nfs_ok)
 		return nfserr;
 	/* sr_status_flags */
diff --git a/fs/nfsd/state.h b/fs/nfsd/state.h
index aad547d3ad8b..4251ff3c5ad1 100644
--- a/fs/nfsd/state.h
+++ b/fs/nfsd/state.h
@@ -245,10 +245,12 @@ struct nfsd4_slot {
 	struct svc_cred sl_cred;
 	u32	sl_datalen;
 	u16	sl_opcnt;
+	u16	sl_generation;
 #define NFSD4_SLOT_INUSE	(1 << 0)
 #define NFSD4_SLOT_CACHETHIS	(1 << 1)
 #define NFSD4_SLOT_INITIALIZED	(1 << 2)
 #define NFSD4_SLOT_CACHED	(1 << 3)
+#define NFSD4_SLOT_REUSED	(1 << 4)
 	u8	sl_flags;
 	char	sl_data[];
 };
@@ -321,7 +323,6 @@ struct nfsd4_session {
 	u32			se_cb_slot_avail; /* bitmap of available slots */
 	u32			se_cb_highest_slot;	/* highest slot client wants */
 	u32			se_cb_prog;
-	bool			se_dead;
 	struct list_head	se_hash;	/* hash by sessionid */
 	struct list_head	se_perclnt;
 	struct nfs4_client	*se_client;
@@ -331,6 +332,9 @@ struct nfsd4_session {
 	struct list_head	se_conns;
 	u32			se_cb_seq_nr[NFSD_BC_SLOT_TABLE_SIZE];
 	struct xarray		se_slots;	/* forward channel slots */
+	u16			se_slot_gen;
+	bool			se_dead;
+	u32			se_target_maxslots;
 };
 
 /* formatted contents of nfs4_sessionid */
diff --git a/fs/nfsd/xdr4.h b/fs/nfsd/xdr4.h
index 382cc1389396..c26ba86dbdfd 100644
--- a/fs/nfsd/xdr4.h
+++ b/fs/nfsd/xdr4.h
@@ -576,9 +576,7 @@ struct nfsd4_sequence {
 	u32			slotid;			/* request/response */
 	u32			maxslots;		/* request/response */
 	u32			cachethis;		/* request */
-#if 0
 	u32			target_maxslots;	/* response */
-#endif /* not yet */
 	u32			status_flags;		/* response */
 };
 
-- 
2.47.0



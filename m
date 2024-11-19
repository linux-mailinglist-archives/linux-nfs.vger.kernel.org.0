Return-Path: <linux-nfs+bounces-8102-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 629B09D1CCD
	for <lists+linux-nfs@lfdr.de>; Tue, 19 Nov 2024 01:50:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AABD3B213B4
	for <lists+linux-nfs@lfdr.de>; Tue, 19 Nov 2024 00:50:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B36951B813;
	Tue, 19 Nov 2024 00:50:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="dubt1w3a";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="7MSbYIuD";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="dubt1w3a";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="7MSbYIuD"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB0D58825
	for <linux-nfs@vger.kernel.org>; Tue, 19 Nov 2024 00:50:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731977421; cv=none; b=OhyM5vPftQr68l5X/DzjVWmJobzTTrXvgG8WYu1r8WzMjHGV7h8VUpJ0RwvbIiLiiytwhJOkfp+w3WBtiq9/j/nk5ick1vMOkz8aswqb+5UpWkbtlR4jJjkV61xLjKQeZ4PqONsx5Mr2lxbu/q7qF5cJhvmAGTUK2iqTMsnSiz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731977421; c=relaxed/simple;
	bh=W+znEoAxtV+1FLMr//hhIt2VIf31MYjjvq9SjswbqUU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sx+1dxcK4F20LkES37z+hTIUsiw5rI8je2V7btpIRK+bZwPphhGS+mG2CpL9JjOgE3+cSN6pQAQguAZp0uct7u0vlRulVe4fAqC16vCFMzoiFg3Ig8I54B8DCOMKZuqlVnl9IHYD4ExOJjlbO+uLvokMr6qCIV5v024iS0s5CS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=dubt1w3a; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=7MSbYIuD; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=dubt1w3a; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=7MSbYIuD; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 2E90E21757;
	Tue, 19 Nov 2024 00:50:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1731977417; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fukzpdoR2OmTjwQuqs98Rm+SyCkObZk2NvCX5odXncs=;
	b=dubt1w3atcT0DBsARoMMv/aGbIddgiX0nzCXZ7hu3a1CMTQNtUing0i4iRIO0AbIFuQCt0
	cflSYPMnBW8jDkD2g7vRNkNIC4uNq08ldL/ciI4sKU4/NeLu2uQLdJJwNm4hJwL1yneDBX
	co+YPuyjtmrmwVJm9i8IWv9CIVGjioE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1731977417;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fukzpdoR2OmTjwQuqs98Rm+SyCkObZk2NvCX5odXncs=;
	b=7MSbYIuDgkjlX0kl1mSN9hKrTK218f/x3ZHij0uRTYSWvwnxfsTFCprW0IOHK1QiDu5xgz
	8lLjkdiqgGASxODg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1731977417; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fukzpdoR2OmTjwQuqs98Rm+SyCkObZk2NvCX5odXncs=;
	b=dubt1w3atcT0DBsARoMMv/aGbIddgiX0nzCXZ7hu3a1CMTQNtUing0i4iRIO0AbIFuQCt0
	cflSYPMnBW8jDkD2g7vRNkNIC4uNq08ldL/ciI4sKU4/NeLu2uQLdJJwNm4hJwL1yneDBX
	co+YPuyjtmrmwVJm9i8IWv9CIVGjioE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1731977417;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fukzpdoR2OmTjwQuqs98Rm+SyCkObZk2NvCX5odXncs=;
	b=7MSbYIuDgkjlX0kl1mSN9hKrTK218f/x3ZHij0uRTYSWvwnxfsTFCprW0IOHK1QiDu5xgz
	8lLjkdiqgGASxODg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 232CD1376E;
	Tue, 19 Nov 2024 00:50:14 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id SEwLM8bgO2fAJgAAD6G6ig
	(envelope-from <neilb@suse.de>); Tue, 19 Nov 2024 00:50:14 +0000
From: NeilBrown <neilb@suse.de>
To: Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>
Cc: linux-nfs@vger.kernel.org,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <Dai.Ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>
Subject: [PATCH 5/6] nfsd: add support for freeing unused session-DRC slots
Date: Tue, 19 Nov 2024 11:41:32 +1100
Message-ID: <20241119004928.3245873-6-neilb@suse.de>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241119004928.3245873-1-neilb@suse.de>
References: <20241119004928.3245873-1-neilb@suse.de>
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

We use an 8 bit generation number (64 seems wasteful) and if it cycles
we iterate all slots and reset the generation number to avoid false matches.

When we free a slot we store the seqid in the slot pointer so that it can
be restored when we reactivate the slot.  The RFC can be read as
suggesting that the slot number could restart from one after a slot is
retired and reactivated, but also suggests that retiring slots is not
required.  So when we reactive a slot we accept with the next seqid in
sequence, or 1.

When decoding sa_highest_slotid into maxslots we need to add 1 - this
matches how it is encoded for the reply.

Signed-off-by: NeilBrown <neilb@suse.de>
---
 fs/nfsd/nfs4state.c | 81 ++++++++++++++++++++++++++++++++++++++-------
 fs/nfsd/nfs4xdr.c   |  5 +--
 fs/nfsd/state.h     |  4 +++
 fs/nfsd/xdr4.h      |  2 --
 4 files changed, 76 insertions(+), 16 deletions(-)

diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index fb522165b376..0625b0aec6b8 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -1910,17 +1910,55 @@ gen_sessionid(struct nfsd4_session *ses)
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
+		xa_store(&ses->se_slots, i, xa_mk_value(slot->sl_seqid),
+			 GFP_ATOMIC);
 		free_svc_cred(&slot->sl_cred);
 		kfree(slot);
 	}
+	ses->se_fchannel.maxreqs = from;
+	if (ses->se_target_maxslots > from)
+		ses->se_target_maxslots = from;
+}
+
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
@@ -1967,6 +2005,7 @@ static struct nfsd4_session *alloc_session(struct nfsd4_channel_attrs *fattrs,
 	}
 	fattrs->maxreqs = i;
 	memcpy(&new->se_fchannel, fattrs, sizeof(struct nfsd4_channel_attrs));
+	new->se_target_maxslots = i;
 	new->se_cb_slot_avail = ~0U;
 	new->se_cb_highest_slot = min(battrs->maxreqs - 1,
 				      NFSD_BC_SLOT_TABLE_SIZE - 1);
@@ -2080,7 +2119,7 @@ static void nfsd4_del_conns(struct nfsd4_session *s)
 
 static void __free_session(struct nfsd4_session *ses)
 {
-	free_session_slots(ses);
+	free_session_slots(ses, 0);
 	xa_destroy(&ses->se_slots);
 	kfree(ses);
 }
@@ -3687,10 +3726,10 @@ nfsd4_exchange_id_release(union nfsd4_op_u *u)
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
@@ -3699,6 +3738,8 @@ static __be32 check_slot_seqid(u32 seqid, u32 slot_seqid, bool slot_inuse)
 	/* Note unsigned 32-bit arithmetic handles wraparound: */
 	if (likely(seqid == slot_seqid + 1))
 		return nfs_ok;
+	if ((flags & NFSD4_SLOT_REUSED) && seqid == 1)
+		return nfs_ok;
 	if (seqid == slot_seqid)
 		return nfserr_replay_cache;
 	return nfserr_seq_misordered;
@@ -4249,8 +4290,7 @@ nfsd4_sequence(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 	dprintk("%s: slotid %d\n", __func__, seq->slotid);
 
 	trace_nfsd_slot_seqid_sequence(clp, seq, slot);
-	status = check_slot_seqid(seq->seqid, slot->sl_seqid,
-					slot->sl_flags & NFSD4_SLOT_INUSE);
+	status = check_slot_seqid(seq->seqid, slot->sl_seqid, slot->sl_flags);
 	if (status == nfserr_replay_cache) {
 		status = nfserr_seq_misordered;
 		if (!(slot->sl_flags & NFSD4_SLOT_INITIALIZED))
@@ -4275,6 +4315,12 @@ nfsd4_sequence(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
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
@@ -4285,8 +4331,9 @@ nfsd4_sequence(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 	svc_reserve(rqstp, buflen);
 
 	status = nfs_ok;
-	/* Success! bump slot seqid */
+	/* Success! accept new slot seqid */
 	slot->sl_seqid = seq->seqid;
+	slot->sl_flags &= ~NFSD4_SLOT_REUSED;
 	slot->sl_flags |= NFSD4_SLOT_INUSE;
 	if (seq->cachethis)
 		slot->sl_flags |= NFSD4_SLOT_CACHETHIS;
@@ -4302,8 +4349,10 @@ nfsd4_sequence(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 	 * gently try to allocate another one.
 	 */
 	if (seq->slotid == session->se_fchannel.maxreqs - 1 &&
+	    session->se_target_maxslots >= session->se_fchannel.maxreqs &&
 	    session->se_fchannel.maxreqs < NFSD_MAX_SLOTS_PER_SESSION) {
 		int s = session->se_fchannel.maxreqs;
+		void *prev_slot;
 
 		/*
 		 * GFP_NOWAIT is a low-priority non-blocking allocation
@@ -4314,13 +4363,21 @@ nfsd4_sequence(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 		 * allocation.
 		 */
 		slot = kzalloc(slot_bytes(&session->se_fchannel), GFP_NOWAIT);
+		prev_slot = xa_load(&session->se_slots, s);
+		if (xa_is_value(prev_slot) && slot) {
+			slot->sl_seqid = xa_to_value(prev_slot);
+			slot->sl_flags |= NFSD4_SLOT_REUSED;
+		}
 		if (slot && !xa_is_err(xa_store(&session->se_slots, s, slot,
-						GFP_ATOMIC)))
+						GFP_ATOMIC))) {
 			session->se_fchannel.maxreqs += 1;
-		else
+			session->se_target_maxslots = session->se_fchannel.maxreqs;
+		} else {
 			kfree(slot);
+		}
 	}
-	seq->maxslots = session->se_fchannel.maxreqs;
+	seq->maxslots = max(session->se_target_maxslots, seq->maxslots);
+	seq->target_maxslots = session->se_target_maxslots;
 
 out:
 	switch (clp->cl_cb_state) {
diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
index 5c79494bd20b..b281a2198ff3 100644
--- a/fs/nfsd/nfs4xdr.c
+++ b/fs/nfsd/nfs4xdr.c
@@ -1905,7 +1905,8 @@ nfsd4_decode_sequence(struct nfsd4_compoundargs *argp,
 		return nfserr_bad_xdr;
 	seq->seqid = be32_to_cpup(p++);
 	seq->slotid = be32_to_cpup(p++);
-	seq->maxslots = be32_to_cpup(p++);
+	/* sa_highest_slotid counts from 0 but maxslots  counts from 1 ... */
+	seq->maxslots = be32_to_cpup(p++) + 1;
 	seq->cachethis = be32_to_cpup(p);
 
 	seq->status_flags = 0;
@@ -5054,7 +5055,7 @@ nfsd4_encode_sequence(struct nfsd4_compoundres *resp, __be32 nfserr,
 	if (nfserr != nfs_ok)
 		return nfserr;
 	/* sr_target_highest_slotid */
-	nfserr = nfsd4_encode_slotid4(xdr, seq->maxslots - 1);
+	nfserr = nfsd4_encode_slotid4(xdr, seq->target_maxslots - 1);
 	if (nfserr != nfs_ok)
 		return nfserr;
 	/* sr_status_flags */
diff --git a/fs/nfsd/state.h b/fs/nfsd/state.h
index a14a823670e9..ea6659d52be2 100644
--- a/fs/nfsd/state.h
+++ b/fs/nfsd/state.h
@@ -268,7 +268,9 @@ struct nfsd4_slot {
 #define NFSD4_SLOT_CACHETHIS	(1 << 1)
 #define NFSD4_SLOT_INITIALIZED	(1 << 2)
 #define NFSD4_SLOT_CACHED	(1 << 3)
+#define NFSD4_SLOT_REUSED	(1 << 4)
 	u8	sl_flags;
+	u8	sl_generation;
 	char	sl_data[];
 };
 
@@ -350,6 +352,8 @@ struct nfsd4_session {
 	struct list_head	se_conns;
 	u32			se_cb_seq_nr[NFSD_BC_SLOT_TABLE_SIZE];
 	struct xarray		se_slots;	/* forward channel slots */
+	u8			se_slot_gen;
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



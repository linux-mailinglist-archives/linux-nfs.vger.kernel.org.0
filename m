Return-Path: <linux-nfs+bounces-8358-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C58B9E6279
	for <lists+linux-nfs@lfdr.de>; Fri,  6 Dec 2024 01:49:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B4B1B1881D68
	for <lists+linux-nfs@lfdr.de>; Fri,  6 Dec 2024 00:49:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A1FEBE46;
	Fri,  6 Dec 2024 00:49:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="TH1wVG5L";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="1voWqQdi";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="TH1wVG5L";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="1voWqQdi"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E8B6881E
	for <linux-nfs@vger.kernel.org>; Fri,  6 Dec 2024 00:49:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733446195; cv=none; b=WWSdmiejQ5ypgsPEQxbTMvH7VHNn5SKPP52fgp4QJcvhpok6XYTCC92SIzkIXlWZn2h/g5iLfquxvwDF/dtSSphPr6AsIjvGU8JrdU6YWTloGOmac5k292ZOa+Wu9Y3WUs/qVnCRL/G8+6uA/1wTUcvFCQY8wsh5cqj9QmWZEQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733446195; c=relaxed/simple;
	bh=Y0rCJUcrvgXP7O9jFBcH4/CTjf2rQz0AqDN9IkkBs6s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=paZmrmzm/L198T3ogotULTnEJ5cG4TDcykMySu5TSlnL4KE5Yz9R1gMsXAWHZY+5LqzLPBEOMJdlsRcI20SLby/85wtDWcCtD4yFXVzNtyVlJhf93eoLhOOMRrEoZ2TocfwcY/AUg/UvHa8QaROqBLg5ROZpIjGr2809Sy0eg7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=TH1wVG5L; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=1voWqQdi; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=TH1wVG5L; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=1voWqQdi; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 392FD1F37C;
	Fri,  6 Dec 2024 00:49:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1733446191; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2hQFARmqDWnTIg/1MFeAl9Kl9DSfLlPh0qmDl8wIkjI=;
	b=TH1wVG5LeZ2tWaIqQpzqJ1dcdDPh3hVEaID3pQ6DMGl1ad1KCUmUnAT/DQx3XvHvGpg+ix
	bzqTDkdaL7UI/etdzduxufOESXvRZi8KiZ0ffEz3IPzMvmDZERLY+ZtfMiWwzw0sJIeJL4
	bhrTrvGHGBpj5+iZDIpVSouEzpI8Ahs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1733446191;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2hQFARmqDWnTIg/1MFeAl9Kl9DSfLlPh0qmDl8wIkjI=;
	b=1voWqQdi72fw3ZuRox9sWO4/djqkYl9s4jHd+Ytp9EERoAWu7WmIcQjqohYro3F6qyU+y3
	FENvAZJjhP+C0SBQ==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=TH1wVG5L;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=1voWqQdi
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1733446191; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2hQFARmqDWnTIg/1MFeAl9Kl9DSfLlPh0qmDl8wIkjI=;
	b=TH1wVG5LeZ2tWaIqQpzqJ1dcdDPh3hVEaID3pQ6DMGl1ad1KCUmUnAT/DQx3XvHvGpg+ix
	bzqTDkdaL7UI/etdzduxufOESXvRZi8KiZ0ffEz3IPzMvmDZERLY+ZtfMiWwzw0sJIeJL4
	bhrTrvGHGBpj5+iZDIpVSouEzpI8Ahs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1733446191;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2hQFARmqDWnTIg/1MFeAl9Kl9DSfLlPh0qmDl8wIkjI=;
	b=1voWqQdi72fw3ZuRox9sWO4/djqkYl9s4jHd+Ytp9EERoAWu7WmIcQjqohYro3F6qyU+y3
	FENvAZJjhP+C0SBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C2320132EB;
	Fri,  6 Dec 2024 00:49:48 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id djSRHSxKUmcLDgAAD6G6ig
	(envelope-from <neilb@suse.de>); Fri, 06 Dec 2024 00:49:48 +0000
From: NeilBrown <neilb@suse.de>
To: Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>
Cc: linux-nfs@vger.kernel.org,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <Dai.Ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>
Subject: [PATCH 5/6] nfsd: add support for freeing unused session-DRC slots
Date: Fri,  6 Dec 2024 11:43:19 +1100
Message-ID: <20241206004829.3497925-6-neilb@suse.de>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241206004829.3497925-1-neilb@suse.de>
References: <20241206004829.3497925-1-neilb@suse.de>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 392FD1F37C
X-Spam-Level: 
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:25478, ipnet:::/0, country:RU];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	R_RATELIMIT(0.00)[from(RLewrxuus8mos16izbn)];
	TO_DN_SOME(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_COUNT_TWO(0.00)[2];
	RCVD_TLS_ALL(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -3.01
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
 fs/nfsd/nfs4state.c | 80 +++++++++++++++++++++++++++++++++++++++------
 fs/nfsd/nfs4xdr.c   |  5 +--
 fs/nfsd/state.h     |  4 +++
 fs/nfsd/xdr4.h      |  2 --
 4 files changed, 77 insertions(+), 14 deletions(-)

diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index ec4468ebbd40..e73668462739 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -1910,17 +1910,54 @@ gen_sessionid(struct nfsd4_session *ses)
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
@@ -1968,6 +2005,7 @@ static struct nfsd4_session *alloc_session(struct nfsd4_channel_attrs *fattrs,
 	}
 	fattrs->maxreqs = i;
 	memcpy(&new->se_fchannel, fattrs, sizeof(struct nfsd4_channel_attrs));
+	new->se_target_maxslots = i;
 	new->se_cb_slot_avail = ~0U;
 	new->se_cb_highest_slot = min(battrs->maxreqs - 1,
 				      NFSD_BC_SLOT_TABLE_SIZE - 1);
@@ -2081,7 +2119,7 @@ static void nfsd4_del_conns(struct nfsd4_session *s)
 
 static void __free_session(struct nfsd4_session *ses)
 {
-	free_session_slots(ses);
+	free_session_slots(ses, 0);
 	xa_destroy(&ses->se_slots);
 	kfree(ses);
 }
@@ -2684,6 +2722,9 @@ static int client_info_show(struct seq_file *m, void *v)
 	seq_printf(m, "session slots:");
 	list_for_each_entry(ses, &clp->cl_sessions, se_perclnt)
 		seq_printf(m, " %u", ses->se_fchannel.maxreqs);
+	seq_printf(m, "\nsession target slots:");
+	list_for_each_entry(ses, &clp->cl_sessions, se_perclnt)
+		seq_printf(m, " %u", ses->se_target_maxslots);
 	spin_unlock(&clp->cl_lock);
 	seq_puts(m, "\n");
 
@@ -3674,10 +3715,10 @@ nfsd4_exchange_id_release(union nfsd4_op_u *u)
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
@@ -3686,6 +3727,8 @@ static __be32 check_slot_seqid(u32 seqid, u32 slot_seqid, bool slot_inuse)
 	/* Note unsigned 32-bit arithmetic handles wraparound: */
 	if (likely(seqid == slot_seqid + 1))
 		return nfs_ok;
+	if ((flags & NFSD4_SLOT_REUSED) && seqid == 1)
+		return nfs_ok;
 	if (seqid == slot_seqid)
 		return nfserr_replay_cache;
 	return nfserr_seq_misordered;
@@ -4236,8 +4279,7 @@ nfsd4_sequence(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 	dprintk("%s: slotid %d\n", __func__, seq->slotid);
 
 	trace_nfsd_slot_seqid_sequence(clp, seq, slot);
-	status = check_slot_seqid(seq->seqid, slot->sl_seqid,
-					slot->sl_flags & NFSD4_SLOT_INUSE);
+	status = check_slot_seqid(seq->seqid, slot->sl_seqid, slot->sl_flags);
 	if (status == nfserr_replay_cache) {
 		status = nfserr_seq_misordered;
 		if (!(slot->sl_flags & NFSD4_SLOT_INITIALIZED))
@@ -4262,6 +4304,12 @@ nfsd4_sequence(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
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
@@ -4272,9 +4320,11 @@ nfsd4_sequence(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
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
@@ -4291,9 +4341,11 @@ nfsd4_sequence(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
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
@@ -4307,17 +4359,25 @@ nfsd4_sequence(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
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
 						GFP_ATOMIC | __GFP_NOWARN))) {
 				s += 1;
 				session->se_fchannel.maxreqs = s;
+				session->se_target_maxslots = s;
 			} else {
 				kfree(slot);
+				slot = NULL;
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
index aad547d3ad8b..74f2ab3c95aa 100644
--- a/fs/nfsd/state.h
+++ b/fs/nfsd/state.h
@@ -249,7 +249,9 @@ struct nfsd4_slot {
 #define NFSD4_SLOT_CACHETHIS	(1 << 1)
 #define NFSD4_SLOT_INITIALIZED	(1 << 2)
 #define NFSD4_SLOT_CACHED	(1 << 3)
+#define NFSD4_SLOT_REUSED	(1 << 4)
 	u8	sl_flags;
+	u8	sl_generation;
 	char	sl_data[];
 };
 
@@ -331,6 +333,8 @@ struct nfsd4_session {
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



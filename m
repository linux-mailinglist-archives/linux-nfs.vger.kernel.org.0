Return-Path: <linux-nfs+bounces-8103-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 100189D1CCC
	for <lists+linux-nfs@lfdr.de>; Tue, 19 Nov 2024 01:50:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C4C4C2823A6
	for <lists+linux-nfs@lfdr.de>; Tue, 19 Nov 2024 00:50:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3445918E20;
	Tue, 19 Nov 2024 00:50:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="dzuQrhX7";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="J8J8U/f+";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="dzuQrhX7";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="J8J8U/f+"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 672238825
	for <linux-nfs@vger.kernel.org>; Tue, 19 Nov 2024 00:50:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731977431; cv=none; b=Z4ko2gRHtQjQtxTUbiVSBs158NmMhb7I+w7q1XFCAmbmy3xzmYDGRGxGIAcCyFtmrbsUfIFqGn7MxFY3JgftDVJ+ntCTqECJ+LzPDq4LAZzy2KADh/wvWWc10DqNXq5pBtyH81UzaZQ9lA7KCJXWyts9sD8gNvBfhdwlhe0aMPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731977431; c=relaxed/simple;
	bh=BIdOVcuAUbFwmTjUzn6M/lI8oC8MPaFvY43LkiyhIXE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=h+seJorc45z3r/G0D4nMa/EW/A/w+7M0cl7jtSCUoAAd/tqiTKQj4OobcscjwnVZxJPBwBeIBrdnXwl3nEZDMXu6wHxrI7jafpTRVM4CX3k/6g9wAYRqnir43bQNOcthwKNbBvKTYeeWqe/9cAMs5kTfTKt10IE2gAxY7mfbDjk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=dzuQrhX7; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=J8J8U/f+; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=dzuQrhX7; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=J8J8U/f+; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id B570321757;
	Tue, 19 Nov 2024 00:50:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1731977426; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bBLfYchDQ2mEzlzN4+iUrMrVp11dAzvrj3g/Q3iZdks=;
	b=dzuQrhX7R67yCcaX5BV9pOJKjgl+iHHQdTJg3PvpCWW50pKpla7mBpN+qdifD37sD0tazy
	MaXF9CdMBxdYHosHMdbMwToscyw9Wp0c/t7lZ1S7OnQioqdLctfpLsiPj4ZIQbZcC+YMJo
	BhVZIsJ5lKCT1TGyPY2KGTsW0GjJF+8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1731977426;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bBLfYchDQ2mEzlzN4+iUrMrVp11dAzvrj3g/Q3iZdks=;
	b=J8J8U/f+8UvgUTiYHgVtrg3moQw6o5Oh+e7j8QRzr2ottzGA8rxEYhtzCPnZ2AOuhuN4vF
	hWpZNHNYDCY8X6CQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1731977426; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bBLfYchDQ2mEzlzN4+iUrMrVp11dAzvrj3g/Q3iZdks=;
	b=dzuQrhX7R67yCcaX5BV9pOJKjgl+iHHQdTJg3PvpCWW50pKpla7mBpN+qdifD37sD0tazy
	MaXF9CdMBxdYHosHMdbMwToscyw9Wp0c/t7lZ1S7OnQioqdLctfpLsiPj4ZIQbZcC+YMJo
	BhVZIsJ5lKCT1TGyPY2KGTsW0GjJF+8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1731977426;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bBLfYchDQ2mEzlzN4+iUrMrVp11dAzvrj3g/Q3iZdks=;
	b=J8J8U/f+8UvgUTiYHgVtrg3moQw6o5Oh+e7j8QRzr2ottzGA8rxEYhtzCPnZ2AOuhuN4vF
	hWpZNHNYDCY8X6CQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id ACAD21376E;
	Tue, 19 Nov 2024 00:50:24 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 1/QIGdDgO2fHJgAAD6G6ig
	(envelope-from <neilb@suse.de>); Tue, 19 Nov 2024 00:50:24 +0000
From: NeilBrown <neilb@suse.de>
To: Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>
Cc: linux-nfs@vger.kernel.org,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <Dai.Ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>
Subject: [PATCH 6/6] nfsd: add shrinker to reduce number of slots allocated per session
Date: Tue, 19 Nov 2024 11:41:33 +1100
Message-ID: <20241119004928.3245873-7-neilb@suse.de>
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

Add a shrinker which frees unused slots and may ask the clients to use
fewer slots on each session.

Each session now tracks se_client_maxreqs which is the most recent
max-requests-in-use reported by the client, and se_target_maxreqs which
is a target number of requests which is reduced by the shrinker.

The shrinker iterates over all sessions on all client in all
net-namespaces and reduces the target by 1 for each.  The shrinker may
get called multiple times to reduce by more than 1 each.

If se_target_maxreqs is above se_client_maxreqs, those slots can be
freed immediately.  If not the client will be ask to reduce its usage
and as the usage goes down slots will be freed.

Once the usage has dropped to match the target, the target can be
increased if the client uses all available slots and if a GFP_NOWAIT
allocation succeeds.

Signed-off-by: NeilBrown <neilb@suse.de>
---
 fs/nfsd/nfs4state.c | 72 ++++++++++++++++++++++++++++++++++++++++++---
 fs/nfsd/state.h     |  1 +
 2 files changed, 69 insertions(+), 4 deletions(-)

diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index 0625b0aec6b8..ac49c3bd0dcb 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -1909,6 +1909,16 @@ gen_sessionid(struct nfsd4_session *ses)
  */
 #define NFSD_MIN_HDR_SEQ_SZ  (24 + 12 + 44)
 
+static struct shrinker *nfsd_slot_shrinker;
+static DEFINE_SPINLOCK(nfsd_session_list_lock);
+static LIST_HEAD(nfsd_session_list);
+/* The sum of "target_slots-1" on every session.  The shrinker can push this
+ * down, though it can take a little while for the memory to actually
+ * be freed.  The "-1" is because we can never free slot 0 while the
+ * session is active.
+ */
+static atomic_t nfsd_total_target_slots = ATOMIC_INIT(0);
+
 static void
 free_session_slots(struct nfsd4_session *ses, int from)
 {
@@ -1931,11 +1941,14 @@ free_session_slots(struct nfsd4_session *ses, int from)
 		kfree(slot);
 	}
 	ses->se_fchannel.maxreqs = from;
-	if (ses->se_target_maxslots > from)
-		ses->se_target_maxslots = from;
+	if (ses->se_target_maxslots > from) {
+		int new_target = from ?: 1;
+		atomic_sub(ses->se_target_maxslots - new_target, &nfsd_total_target_slots);
+		ses->se_target_maxslots = new_target;
+	}
 }
 
-static int __maybe_unused
+static int
 reduce_session_slots(struct nfsd4_session *ses, int dec)
 {
 	struct nfsd_net *nn = net_generic(ses->se_client->net,
@@ -1948,6 +1961,7 @@ reduce_session_slots(struct nfsd4_session *ses, int dec)
 		return ret;
 	ret = min(dec, ses->se_target_maxslots-1);
 	ses->se_target_maxslots -= ret;
+	atomic_sub(ret, &nfsd_total_target_slots);
 	ses->se_slot_gen += 1;
 	if (ses->se_slot_gen == 0) {
 		int i;
@@ -2006,6 +2020,7 @@ static struct nfsd4_session *alloc_session(struct nfsd4_channel_attrs *fattrs,
 	fattrs->maxreqs = i;
 	memcpy(&new->se_fchannel, fattrs, sizeof(struct nfsd4_channel_attrs));
 	new->se_target_maxslots = i;
+	atomic_add(i - 1, &nfsd_total_target_slots);
 	new->se_cb_slot_avail = ~0U;
 	new->se_cb_highest_slot = min(battrs->maxreqs - 1,
 				      NFSD_BC_SLOT_TABLE_SIZE - 1);
@@ -2130,6 +2145,36 @@ static void free_session(struct nfsd4_session *ses)
 	__free_session(ses);
 }
 
+static unsigned long
+nfsd_slot_count(struct shrinker *s, struct shrink_control *sc)
+{
+	unsigned long cnt = atomic_read(&nfsd_total_target_slots);
+
+	return cnt ? cnt : SHRINK_EMPTY;
+}
+
+static unsigned long
+nfsd_slot_scan(struct shrinker *s, struct shrink_control *sc)
+{
+	struct nfsd4_session *ses;
+	unsigned long scanned = 0;
+	unsigned long freed = 0;
+
+	spin_lock(&nfsd_session_list_lock);
+	list_for_each_entry(ses, &nfsd_session_list, se_all_sessions) {
+		freed += reduce_session_slots(ses, 1);
+		scanned += 1;
+		if (scanned >= sc->nr_to_scan) {
+			/* Move starting point for next scan */
+			list_move(&nfsd_session_list, &ses->se_all_sessions);
+			break;
+		}
+	}
+	spin_unlock(&nfsd_session_list_lock);
+	sc->nr_scanned = scanned;
+	return freed;
+}
+
 static void init_session(struct svc_rqst *rqstp, struct nfsd4_session *new, struct nfs4_client *clp, struct nfsd4_create_session *cses)
 {
 	int idx;
@@ -2154,6 +2199,10 @@ static void init_session(struct svc_rqst *rqstp, struct nfsd4_session *new, stru
 	list_add(&new->se_perclnt, &clp->cl_sessions);
 	spin_unlock(&clp->cl_lock);
 
+	spin_lock(&nfsd_session_list_lock);
+	list_add_tail(&new->se_all_sessions, &nfsd_session_list);
+	spin_unlock(&nfsd_session_list_lock);
+
 	{
 		struct sockaddr *sa = svc_addr(rqstp);
 		/*
@@ -2223,6 +2272,9 @@ unhash_session(struct nfsd4_session *ses)
 	spin_lock(&ses->se_client->cl_lock);
 	list_del(&ses->se_perclnt);
 	spin_unlock(&ses->se_client->cl_lock);
+	spin_lock(&nfsd_session_list_lock);
+	list_del(&ses->se_all_sessions);
+	spin_unlock(&nfsd_session_list_lock);
 }
 
 /* SETCLIENTID and SETCLIENTID_CONFIRM Helper functions */
@@ -4335,6 +4387,7 @@ nfsd4_sequence(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 	slot->sl_seqid = seq->seqid;
 	slot->sl_flags &= ~NFSD4_SLOT_REUSED;
 	slot->sl_flags |= NFSD4_SLOT_INUSE;
+	slot->sl_generation = session->se_slot_gen;
 	if (seq->cachethis)
 		slot->sl_flags |= NFSD4_SLOT_CACHETHIS;
 	else
@@ -4371,6 +4424,8 @@ nfsd4_sequence(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 		if (slot && !xa_is_err(xa_store(&session->se_slots, s, slot,
 						GFP_ATOMIC))) {
 			session->se_fchannel.maxreqs += 1;
+			atomic_add(session->se_fchannel.maxreqs - session->se_target_maxslots,
+				   &nfsd_total_target_slots);
 			session->se_target_maxslots = session->se_fchannel.maxreqs;
 		} else {
 			kfree(slot);
@@ -8779,7 +8834,6 @@ nfs4_state_start_net(struct net *net)
 }
 
 /* initialization to perform when the nfsd service is started: */
-
 int
 nfs4_state_start(void)
 {
@@ -8789,6 +8843,15 @@ nfs4_state_start(void)
 	if (ret)
 		return ret;
 
+	nfsd_slot_shrinker = shrinker_alloc(0, "nfsd-DRC-slot");
+	if (!nfsd_slot_shrinker) {
+		rhltable_destroy(&nfs4_file_rhltable);
+		return -ENOMEM;
+	}
+	nfsd_slot_shrinker->count_objects = nfsd_slot_count;
+	nfsd_slot_shrinker->scan_objects = nfsd_slot_scan;
+	shrinker_register(nfsd_slot_shrinker);
+
 	set_max_delegations();
 	return 0;
 }
@@ -8830,6 +8893,7 @@ void
 nfs4_state_shutdown(void)
 {
 	rhltable_destroy(&nfs4_file_rhltable);
+	shrinker_free(nfsd_slot_shrinker);
 }
 
 static void
diff --git a/fs/nfsd/state.h b/fs/nfsd/state.h
index ea6659d52be2..0e320ba097f2 100644
--- a/fs/nfsd/state.h
+++ b/fs/nfsd/state.h
@@ -345,6 +345,7 @@ struct nfsd4_session {
 	bool			se_dead;
 	struct list_head	se_hash;	/* hash by sessionid */
 	struct list_head	se_perclnt;
+	struct list_head	se_all_sessions;/* global list of sessions */
 	struct nfs4_client	*se_client;
 	struct nfs4_sessionid	se_sessionid;
 	struct nfsd4_channel_attrs se_fchannel;
-- 
2.47.0



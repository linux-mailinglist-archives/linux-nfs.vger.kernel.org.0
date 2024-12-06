Return-Path: <linux-nfs+bounces-8359-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 59AAC9E627A
	for <lists+linux-nfs@lfdr.de>; Fri,  6 Dec 2024 01:50:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 10932285E99
	for <lists+linux-nfs@lfdr.de>; Fri,  6 Dec 2024 00:50:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8811FBE46;
	Fri,  6 Dec 2024 00:50:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="0BS3LIKU";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="ECklLl5B";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="0BS3LIKU";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="ECklLl5B"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A32CE881E
	for <linux-nfs@vger.kernel.org>; Fri,  6 Dec 2024 00:49:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733446200; cv=none; b=MKnZMFtFtBbZZlsERCm7dnwaPu5bDMrFyygXHsaULtDjT24UF5j2WkHxrT19n13DreN/n7L3uYQgqNslMQi5xkcenqszdi+rOkyp/6n9ap4IRZPqiz1QSavjIBz82WEZUpXPx2CU6Nb9efzt9sGDhB7YTFcQQ6vRrN4fOSTttPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733446200; c=relaxed/simple;
	bh=gpTMt2kMyzVUBVKLQ6Cs5GRNEbbsF1lxFGN7VRakAuk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mg6dDW00MPCuE6Z0vEf4glajpwvRQ/a2uwdlKMSSM7XkMWDLGQSm8msroBzMs4MZzEKFdP6GOzjcihIhia7P/MFf+YTF38XnxvOBgLc9sS8E8jmOXpkX6Z1iEmiwjF/ILzupADUqhxiUSE23+r34tuyMC71nBnZ0iSEKCoMuNqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=0BS3LIKU; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=ECklLl5B; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=0BS3LIKU; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=ECklLl5B; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id CE54C1F38E;
	Fri,  6 Dec 2024 00:49:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1733446196; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=viKw0cVtbpH8ufaLhQ3pAH8iOEnsGm1S6c4VF72xZuo=;
	b=0BS3LIKUeGw4onDOCfqLOc16qPWGJ6nCHR6FOmhi0WyrlC0dbJlX1k4XGsZenNvfRSE2Qe
	uHw1VSjKonFj709R7Pwkeisdm+Uu1RbzheoMd6virw/6NS+yNqjewCkaoHzFkwW0LaOE4P
	JFry9BrGveVsHgNMT/l8Se5xqLLeODo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1733446196;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=viKw0cVtbpH8ufaLhQ3pAH8iOEnsGm1S6c4VF72xZuo=;
	b=ECklLl5BXKn23JpzuLXE0gVazLyl1ERFwzpEhL7XCHInPxXoT1nEKYeggy/723CHeyGkKA
	24Y7GwocnrOLyYBQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1733446196; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=viKw0cVtbpH8ufaLhQ3pAH8iOEnsGm1S6c4VF72xZuo=;
	b=0BS3LIKUeGw4onDOCfqLOc16qPWGJ6nCHR6FOmhi0WyrlC0dbJlX1k4XGsZenNvfRSE2Qe
	uHw1VSjKonFj709R7Pwkeisdm+Uu1RbzheoMd6virw/6NS+yNqjewCkaoHzFkwW0LaOE4P
	JFry9BrGveVsHgNMT/l8Se5xqLLeODo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1733446196;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=viKw0cVtbpH8ufaLhQ3pAH8iOEnsGm1S6c4VF72xZuo=;
	b=ECklLl5BXKn23JpzuLXE0gVazLyl1ERFwzpEhL7XCHInPxXoT1nEKYeggy/723CHeyGkKA
	24Y7GwocnrOLyYBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B07E8132EB;
	Fri,  6 Dec 2024 00:49:54 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id U0dDGTJKUmcVDgAAD6G6ig
	(envelope-from <neilb@suse.de>); Fri, 06 Dec 2024 00:49:54 +0000
From: NeilBrown <neilb@suse.de>
To: Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>
Cc: linux-nfs@vger.kernel.org,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <Dai.Ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>
Subject: [PATCH 6/6] nfsd: add shrinker to reduce number of slots allocated per session
Date: Fri,  6 Dec 2024 11:43:20 +1100
Message-ID: <20241206004829.3497925-7-neilb@suse.de>
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo];
	RCVD_TLS_ALL(0.00)[]
X-Spam-Score: -2.80
X-Spam-Flag: NO

Add a shrinker which frees unused slots and may ask the clients to use
fewer slots on each session.

We keep a global count of the number of freeable slots, which is the sum
of one less than the current "target" slots in all sessions in all
clients in all net-namespaces. This number is reported by the shrinker.

When the shrinker is asked to free some, we call xxx on each session in
a round-robin asking each to reduce the slot count by 1.  This will
reduce the "target" so the number reported by the shrinker will reduce
immediately.  The memory will only be freed later when the client
confirmed that it is no longer needed.

We use a global list of sessions and move the "head" to after the last
session that we asked to reduce, so the next callback from the shrinker
will move on to the next session.  This pressure should be applied
"evenly" across all sessions over time.

Signed-off-by: NeilBrown <neilb@suse.de>
---
 fs/nfsd/nfs4state.c | 71 ++++++++++++++++++++++++++++++++++++++++++---
 fs/nfsd/state.h     |  1 +
 2 files changed, 68 insertions(+), 4 deletions(-)

diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index e73668462739..d7bccc237027 100644
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
@@ -1930,11 +1940,14 @@ free_session_slots(struct nfsd4_session *ses, int from)
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
@@ -1947,6 +1960,7 @@ reduce_session_slots(struct nfsd4_session *ses, int dec)
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
@@ -4369,6 +4421,8 @@ nfsd4_sequence(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 						GFP_ATOMIC | __GFP_NOWARN))) {
 				s += 1;
 				session->se_fchannel.maxreqs = s;
+				atomic_add(s - session->se_target_maxslots,
+					   &nfsd_total_target_slots);
 				session->se_target_maxslots = s;
 			} else {
 				kfree(slot);
@@ -8765,7 +8819,6 @@ nfs4_state_start_net(struct net *net)
 }
 
 /* initialization to perform when the nfsd service is started: */
-
 int
 nfs4_state_start(void)
 {
@@ -8775,6 +8828,15 @@ nfs4_state_start(void)
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
@@ -8816,6 +8878,7 @@ void
 nfs4_state_shutdown(void)
 {
 	rhltable_destroy(&nfs4_file_rhltable);
+	shrinker_free(nfsd_slot_shrinker);
 }
 
 static void
diff --git a/fs/nfsd/state.h b/fs/nfsd/state.h
index 74f2ab3c95aa..a4ce2cf3d6a3 100644
--- a/fs/nfsd/state.h
+++ b/fs/nfsd/state.h
@@ -326,6 +326,7 @@ struct nfsd4_session {
 	bool			se_dead;
 	struct list_head	se_hash;	/* hash by sessionid */
 	struct list_head	se_perclnt;
+	struct list_head	se_all_sessions;/* global list of sessions */
 	struct nfs4_client	*se_client;
 	struct nfs4_sessionid	se_sessionid;
 	struct nfsd4_channel_attrs se_fchannel;
-- 
2.47.0



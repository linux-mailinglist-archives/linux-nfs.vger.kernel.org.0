Return-Path: <linux-nfs+bounces-8438-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C40369E884B
	for <lists+linux-nfs@lfdr.de>; Sun,  8 Dec 2024 23:47:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8084F28106C
	for <lists+linux-nfs@lfdr.de>; Sun,  8 Dec 2024 22:47:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00E1884D29;
	Sun,  8 Dec 2024 22:47:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="tWuMpASW";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="TkVUi3JM";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="tWuMpASW";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="TkVUi3JM"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B77928691
	for <linux-nfs@vger.kernel.org>; Sun,  8 Dec 2024 22:47:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733698048; cv=none; b=c1VxWT5Mh0zniF8Rse8WbBNdFXn2iJCQBBYcZvidXtCwKkckMcwDwFtFX9oidzdknRJYyvwngxhvSnoEptM4ar+GAZmJaIwUuJJeGBid3vBbpFpo68m5rpDxWdXaxAENe8YphUb6liYOvfvvUATuCHnRSVflOka43isaQCWTrTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733698048; c=relaxed/simple;
	bh=/5ECN0xEdvhVQIVDjbpiNs9LfTO9OeodrJLM2jlGzuQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gz/i1HT4oR92WtlhW9esczhChIZ1vvaxmKsPIxkapeD/kMzkh/Ub2z15FSba1gKZ5WxZrW7cZ+4EiezEbxEzD9afNlfE2XF5rKOGOn3JJ1ZCsM6E+9FWo5e9xAdfoyTTXgZISY7OjWLk79R8va683aBAUsfTuuNGvBIcG1ufcng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=tWuMpASW; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=TkVUi3JM; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=tWuMpASW; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=TkVUi3JM; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 4312E1F385;
	Sun,  8 Dec 2024 22:47:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1733698045; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9v3kf0rrmU6Z1P1s6cqz8WyVA2ZKIdfZv+EwD6FHu3E=;
	b=tWuMpASWNzfHzPpDTeJUxrV3gIYnu/ucBedzKUJ+Sn1LKFNkbf5Z4R0R0UQcuL9TqTzp6v
	WU8G5YdxgNTsRKNQCGAPkgGAvhqaaP3d2Z1PnGfVCBR7DmNekYyNMHadSUJ23fYOpN2/r3
	81pIl/SowclfDV8E3RcqUE+ebqJefIw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1733698045;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9v3kf0rrmU6Z1P1s6cqz8WyVA2ZKIdfZv+EwD6FHu3E=;
	b=TkVUi3JMHPHZc+YGs3pmu+P34wssT5Gd780j+f2Z4lNobCBcgQ0P54yPmGC8i08d5EEty9
	cIuhqr69Sxowz+Ag==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=tWuMpASW;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=TkVUi3JM
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1733698045; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9v3kf0rrmU6Z1P1s6cqz8WyVA2ZKIdfZv+EwD6FHu3E=;
	b=tWuMpASWNzfHzPpDTeJUxrV3gIYnu/ucBedzKUJ+Sn1LKFNkbf5Z4R0R0UQcuL9TqTzp6v
	WU8G5YdxgNTsRKNQCGAPkgGAvhqaaP3d2Z1PnGfVCBR7DmNekYyNMHadSUJ23fYOpN2/r3
	81pIl/SowclfDV8E3RcqUE+ebqJefIw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1733698045;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9v3kf0rrmU6Z1P1s6cqz8WyVA2ZKIdfZv+EwD6FHu3E=;
	b=TkVUi3JMHPHZc+YGs3pmu+P34wssT5Gd780j+f2Z4lNobCBcgQ0P54yPmGC8i08d5EEty9
	cIuhqr69Sxowz+Ag==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 1A2C513998;
	Sun,  8 Dec 2024 22:47:22 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 1UTvL/ohVmfxAQAAD6G6ig
	(envelope-from <neilb@suse.de>); Sun, 08 Dec 2024 22:47:22 +0000
From: NeilBrown <neilb@suse.de>
To: Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>
Cc: linux-nfs@vger.kernel.org,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <Dai.Ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>
Subject: [PATCH 6/6] nfsd: add shrinker to reduce number of slots allocated per session
Date: Mon,  9 Dec 2024 09:43:17 +1100
Message-ID: <20241208224629.697448-7-neilb@suse.de>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241208224629.697448-1-neilb@suse.de>
References: <20241208224629.697448-1-neilb@suse.de>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 4312E1F385
X-Spam-Score: -3.01
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:mid,suse.de:email];
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
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

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
index a2d1f97b8a0e..311f67418759 100644
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
@@ -1930,8 +1940,11 @@ free_session_slots(struct nfsd4_session *ses, int from)
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
 
 /**
@@ -1949,7 +1962,7 @@ free_session_slots(struct nfsd4_session *ses, int from)
  * Return value:
  *   The number of slots that the target was reduced by.
  */
-static int __maybe_unused
+static int
 reduce_session_slots(struct nfsd4_session *ses, int dec)
 {
 	struct nfsd_net *nn = net_generic(ses->se_client->net,
@@ -1962,6 +1975,7 @@ reduce_session_slots(struct nfsd4_session *ses, int dec)
 		return ret;
 	ret = min(dec, ses->se_target_maxslots-1);
 	ses->se_target_maxslots -= ret;
+	atomic_sub(ret, &nfsd_total_target_slots);
 	ses->se_slot_gen += 1;
 	if (ses->se_slot_gen == 0) {
 		int i;
@@ -2021,6 +2035,7 @@ static struct nfsd4_session *alloc_session(struct nfsd4_channel_attrs *fattrs,
 	fattrs->maxreqs = i;
 	memcpy(&new->se_fchannel, fattrs, sizeof(struct nfsd4_channel_attrs));
 	new->se_target_maxslots = i;
+	atomic_add(i - 1, &nfsd_total_target_slots);
 	new->se_cb_slot_avail = ~0U;
 	new->se_cb_highest_slot = min(battrs->maxreqs - 1,
 				      NFSD_BC_SLOT_TABLE_SIZE - 1);
@@ -2145,6 +2160,36 @@ static void free_session(struct nfsd4_session *ses)
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
@@ -2169,6 +2214,10 @@ static void init_session(struct svc_rqst *rqstp, struct nfsd4_session *new, stru
 	list_add(&new->se_perclnt, &clp->cl_sessions);
 	spin_unlock(&clp->cl_lock);
 
+	spin_lock(&nfsd_session_list_lock);
+	list_add_tail(&new->se_all_sessions, &nfsd_session_list);
+	spin_unlock(&nfsd_session_list_lock);
+
 	{
 		struct sockaddr *sa = svc_addr(rqstp);
 		/*
@@ -2238,6 +2287,9 @@ unhash_session(struct nfsd4_session *ses)
 	spin_lock(&ses->se_client->cl_lock);
 	list_del(&ses->se_perclnt);
 	spin_unlock(&ses->se_client->cl_lock);
+	spin_lock(&nfsd_session_list_lock);
+	list_del(&ses->se_all_sessions);
+	spin_unlock(&nfsd_session_list_lock);
 }
 
 /* SETCLIENTID and SETCLIENTID_CONFIRM Helper functions */
@@ -4380,6 +4432,8 @@ nfsd4_sequence(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 						GFP_NOWAIT))) {
 				s += 1;
 				session->se_fchannel.maxreqs = s;
+				atomic_add(s - session->se_target_maxslots,
+					   &nfsd_total_target_slots);
 				session->se_target_maxslots = s;
 			} else {
 				kfree(slot);
@@ -8776,7 +8830,6 @@ nfs4_state_start_net(struct net *net)
 }
 
 /* initialization to perform when the nfsd service is started: */
-
 int
 nfs4_state_start(void)
 {
@@ -8786,6 +8839,15 @@ nfs4_state_start(void)
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
@@ -8827,6 +8889,7 @@ void
 nfs4_state_shutdown(void)
 {
 	rhltable_destroy(&nfs4_file_rhltable);
+	shrinker_free(nfsd_slot_shrinker);
 }
 
 static void
diff --git a/fs/nfsd/state.h b/fs/nfsd/state.h
index 4251ff3c5ad1..f45aee751a10 100644
--- a/fs/nfsd/state.h
+++ b/fs/nfsd/state.h
@@ -325,6 +325,7 @@ struct nfsd4_session {
 	u32			se_cb_prog;
 	struct list_head	se_hash;	/* hash by sessionid */
 	struct list_head	se_perclnt;
+	struct list_head	se_all_sessions;/* global list of sessions */
 	struct nfs4_client	*se_client;
 	struct nfs4_sessionid	se_sessionid;
 	struct nfsd4_channel_attrs se_fchannel;
-- 
2.47.0



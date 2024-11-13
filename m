Return-Path: <linux-nfs+bounces-7926-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C79999C68EB
	for <lists+linux-nfs@lfdr.de>; Wed, 13 Nov 2024 06:54:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 88E812840C7
	for <lists+linux-nfs@lfdr.de>; Wed, 13 Nov 2024 05:54:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C385A1632E8;
	Wed, 13 Nov 2024 05:54:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="dnC3S6CF";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="2Oy9yYh/";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="dnC3S6CF";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="2Oy9yYh/"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCBE62309AE
	for <linux-nfs@vger.kernel.org>; Wed, 13 Nov 2024 05:54:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731477261; cv=none; b=LYUXVXYm5qVeXnEekoKRadF8jaZ2jaNr2UFjZvYeoPVCzqjzJYhyFg+hk1i905H+oB0DqGFSLiGHgLNuvLAFhG2Ey2C1ZlnSQImWfJGXbQmloEf8HegDKh+9i7PspkFsJ07edqSFfvHfH5o2A0Ni18FgDo44XB8XFkqe18Myu0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731477261; c=relaxed/simple;
	bh=JN8Y1zraGSF5kDeBBKTwC/r5Hzulb+OXLKf2/MASB5A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sHhXQH8cL7UdOY/x2wQ53al4tEdAPIzLxXsnMko0LNojNW+UwHShSmsbcDc2eSfULFEtDnMTIINL7nmIOtg9ii87Lf5GsHa6WZHoBvyc/ixClmTdTeyf/MxdU8UCQ4tPU3Rmud2wdUXAVfS1Ltd+0Xm6wo/polRC+R4iBGnWD3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=dnC3S6CF; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=2Oy9yYh/; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=dnC3S6CF; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=2Oy9yYh/; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 0E117211E9;
	Wed, 13 Nov 2024 05:54:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1731477258; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cHRnBhukkWMtu08x+fOXswoZ2TBLYJ6Z4NIVMjU42Ss=;
	b=dnC3S6CFHedwpRx74eqykRpGTD+sxrkGJ2qw8hiQoeWcIxs1MOC05QmDGLxKywfaVEPUje
	ZK8Fvh9CJoIw0+rkMIMyP1uApxPd68B2Ktmua/83t9+PRj7IzsG+SpX4U6IgNY8DuzlQfg
	aZWbEWSnQe0dZUtpBn4Rs2M9nF7SCdY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1731477258;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cHRnBhukkWMtu08x+fOXswoZ2TBLYJ6Z4NIVMjU42Ss=;
	b=2Oy9yYh/GRmBwc+Zu+CMXnoLmAfAxP59pu4O1gKRrA5AOFmOXbP9ZXcEuTvp6MGHnS5JIM
	uS3mpg4A0+AfRgDA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1731477258; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cHRnBhukkWMtu08x+fOXswoZ2TBLYJ6Z4NIVMjU42Ss=;
	b=dnC3S6CFHedwpRx74eqykRpGTD+sxrkGJ2qw8hiQoeWcIxs1MOC05QmDGLxKywfaVEPUje
	ZK8Fvh9CJoIw0+rkMIMyP1uApxPd68B2Ktmua/83t9+PRj7IzsG+SpX4U6IgNY8DuzlQfg
	aZWbEWSnQe0dZUtpBn4Rs2M9nF7SCdY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1731477258;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cHRnBhukkWMtu08x+fOXswoZ2TBLYJ6Z4NIVMjU42Ss=;
	b=2Oy9yYh/GRmBwc+Zu+CMXnoLmAfAxP59pu4O1gKRrA5AOFmOXbP9ZXcEuTvp6MGHnS5JIM
	uS3mpg4A0+AfRgDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id F3B8913890;
	Wed, 13 Nov 2024 05:54:15 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id eCgzKgc/NGegfQAAD6G6ig
	(envelope-from <neilb@suse.de>); Wed, 13 Nov 2024 05:54:15 +0000
From: NeilBrown <neilb@suse.de>
To: Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>
Cc: linux-nfs@vger.kernel.org,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <Dai.Ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>
Subject: [PATCH 4/4] nfsd: add shrinker to reduce number of slots allocated per session
Date: Wed, 13 Nov 2024 16:38:37 +1100
Message-ID: <20241113055345.494856-5-neilb@suse.de>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241113055345.494856-1-neilb@suse.de>
References: <20241113055345.494856-1-neilb@suse.de>
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
 fs/nfsd/nfs4state.c | 82 ++++++++++++++++++++++++++++++++++++++++++++-
 fs/nfsd/nfs4xdr.c   |  2 +-
 fs/nfsd/state.h     |  3 ++
 fs/nfsd/xdr4.h      |  2 --
 4 files changed, 85 insertions(+), 4 deletions(-)

diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index 15de62416243..bbc365002885 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -1925,6 +1925,8 @@ free_session_slots(struct nfsd4_session *ses, int from)
 		ses->se_slots[i] = (void *)seqid;
 	}
 	ses->se_fchannel.maxreqs = from;
+	if (ses->se_target_maxreqs > from)
+		ses->se_target_maxreqs = from;
 }
 
 /*
@@ -1968,6 +1970,7 @@ static struct nfsd4_session *alloc_session(struct nfsd4_channel_attrs *fattrs,
 	fattrs->maxreqs = i;
 	memcpy(&new->se_fchannel, fattrs, sizeof(struct nfsd4_channel_attrs));
 	memcpy(&new->se_bchannel, battrs, sizeof(struct nfsd4_channel_attrs));
+	new->se_target_maxreqs = i;
 
 	return new;
 out_free:
@@ -2086,6 +2089,57 @@ static void free_session(struct nfsd4_session *ses)
 	__free_session(ses);
 }
 
+
+static DEFINE_SPINLOCK(nfsd_session_list_lock);
+static LIST_HEAD(nfsd_session_list);
+
+static unsigned long
+nfsd_slot_count(struct shrinker *s, struct shrink_control *sc)
+{
+	struct nfsd4_session *ses;
+	unsigned long cnt = 0;
+
+	spin_lock(&nfsd_session_list_lock);
+	list_for_each_entry(ses, &nfsd_session_list, se_all_sessions)
+		if (ses->se_target_maxreqs > 1)
+			cnt += ses->se_target_maxreqs - 1;
+	spin_unlock(&nfsd_session_list_lock);
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
+		struct nfsd_net *nn = net_generic(ses->se_client->net,
+						  nfsd_net_id);
+
+		spin_lock(&nn->client_lock);
+		if (ses->se_fchannel.maxreqs > 1 &&
+		    ses->se_target_maxreqs > 1) {
+			freed += 1;
+			ses->se_target_maxreqs -= 1;
+			free_session_slots(ses, max(ses->se_target_maxreqs,
+						    ses->se_client_maxreqs));
+		}
+		spin_unlock(&nn->client_lock);
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
@@ -2107,6 +2161,10 @@ static void init_session(struct svc_rqst *rqstp, struct nfsd4_session *new, stru
 	list_add(&new->se_perclnt, &clp->cl_sessions);
 	spin_unlock(&clp->cl_lock);
 
+	spin_lock(&nfsd_session_list_lock);
+	list_add_tail(&new->se_all_sessions, &nfsd_session_list);
+	spin_unlock(&nfsd_session_list_lock);
+
 	{
 		struct sockaddr *sa = svc_addr(rqstp);
 		/*
@@ -2176,6 +2234,9 @@ unhash_session(struct nfsd4_session *ses)
 	spin_lock(&ses->se_client->cl_lock);
 	list_del(&ses->se_perclnt);
 	spin_unlock(&ses->se_client->cl_lock);
+	spin_lock(&nfsd_session_list_lock);
+	list_del(&ses->se_all_sessions);
+	spin_unlock(&nfsd_session_list_lock);
 }
 
 /* SETCLIENTID and SETCLIENTID_CONFIRM Helper functions */
@@ -4221,8 +4282,11 @@ nfsd4_sequence(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 	if (status)
 		goto out_put_session;
 
-	/* If there are lots of unused slots, free some */
+	/* we can safely free some slots */
 	free_session_slots(session, seq->maxslots + NFSD_MAX_UNUSED_SLOTS);
+	free_session_slots(session, max(seq->maxslots,
+					session->se_target_maxreqs));
+	session->se_client_maxreqs = seq->maxslots;
 
 	buflen = (seq->cachethis) ?
 			session->se_fchannel.maxresp_cached :
@@ -4251,6 +4315,7 @@ nfsd4_sequence(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 	 * gently try to allocate another one.
 	 */
 	if (seq->slotid == session->se_fchannel.maxreqs - 1 &&
+	    session->se_target_maxreqs >= session->se_fchannel.maxreqs &&
 	    session->se_fchannel.maxreqs < NFSD_MAX_SLOTS_PER_SESSION) {
 		int s = session->se_fchannel.maxreqs;
 
@@ -4260,9 +4325,11 @@ nfsd4_sequence(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 			slot->sl_seqid = (uintptr_t)session->se_slots[s];
 			session->se_slots[s] = slot;
 			session->se_fchannel.maxreqs += 1;
+			session->se_target_maxreqs = session->se_fchannel.maxreqs;
 		}
 	}
 	seq->maxslots = session->se_fchannel.maxreqs;
+	seq->target_maxslots = session->se_target_maxreqs;
 
 out:
 	switch (clp->cl_cb_state) {
@@ -8653,6 +8720,8 @@ nfs4_state_start_net(struct net *net)
 
 /* initialization to perform when the nfsd service is started: */
 
+static struct shrinker *nfsd_slot_shrinker;
+
 int
 nfs4_state_start(void)
 {
@@ -8662,6 +8731,16 @@ nfs4_state_start(void)
 	if (ret)
 		return ret;
 
+	nfsd_slot_shrinker = shrinker_alloc(0, "nfsd-DRC-slot");
+	if (!nfsd_slot_shrinker) {
+		rhltable_destroy(&nfs4_file_rhltable);
+		return -ENOMEM;
+	}
+	nfsd_slot_shrinker->count_objects = nfsd_slot_count;
+	nfsd_slot_shrinker->scan_objects = nfsd_slot_scan;
+	nfsd_slot_shrinker->seeks = 1;
+	shrinker_register(nfsd_slot_shrinker);
+
 	set_max_delegations();
 	return 0;
 }
@@ -8703,6 +8782,7 @@ void
 nfs4_state_shutdown(void)
 {
 	rhltable_destroy(&nfs4_file_rhltable);
+	shrinker_free(nfsd_slot_shrinker);
 }
 
 static void
diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
index 846ed52fdaf5..ac3376c2e5cc 100644
--- a/fs/nfsd/nfs4xdr.c
+++ b/fs/nfsd/nfs4xdr.c
@@ -4956,7 +4956,7 @@ nfsd4_encode_sequence(struct nfsd4_compoundres *resp, __be32 nfserr,
 	if (nfserr != nfs_ok)
 		return nfserr;
 	/* sr_target_highest_slotid */
-	nfserr = nfsd4_encode_slotid4(xdr, seq->maxslots - 1);
+	nfserr = nfsd4_encode_slotid4(xdr, seq->target_maxslots - 1);
 	if (nfserr != nfs_ok)
 		return nfserr;
 	/* sr_status_flags */
diff --git a/fs/nfsd/state.h b/fs/nfsd/state.h
index 012b68a0bafa..a25f3cfaab09 100644
--- a/fs/nfsd/state.h
+++ b/fs/nfsd/state.h
@@ -304,12 +304,15 @@ struct nfsd4_session {
 /* See SESSION4_PERSIST, etc. for standard flags; this is internal-only: */
 #define NFS4_SESSION_DEAD	0x010
 	u32			se_flags;
+	struct list_head	se_all_sessions;/* global list of sessions */
 	struct nfs4_client	*se_client;
 	struct nfs4_sessionid	se_sessionid;
 	struct nfsd4_channel_attrs se_fchannel;
 	struct nfsd4_channel_attrs se_bchannel;
 	struct nfsd4_cb_sec	se_cb_sec;
 	struct list_head	se_conns;
+	u8			se_target_maxreqs;
+	u8			se_client_maxreqs;
 	u32			se_cb_prog;
 	u32			se_cb_seq_nr;
 	struct nfsd4_slot	*se_slots[NFSD_MAX_SLOTS_PER_SESSION];	/* forward channel slots */
diff --git a/fs/nfsd/xdr4.h b/fs/nfsd/xdr4.h
index 2a21a7662e03..71b87190a4a6 100644
--- a/fs/nfsd/xdr4.h
+++ b/fs/nfsd/xdr4.h
@@ -575,9 +575,7 @@ struct nfsd4_sequence {
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



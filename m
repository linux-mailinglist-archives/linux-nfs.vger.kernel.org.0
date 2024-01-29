Return-Path: <linux-nfs+bounces-1520-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DB8F483FCD6
	for <lists+linux-nfs@lfdr.de>; Mon, 29 Jan 2024 04:37:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 93232282EC8
	for <lists+linux-nfs@lfdr.de>; Mon, 29 Jan 2024 03:37:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A62F7101EE;
	Mon, 29 Jan 2024 03:37:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Z+fqByu3";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="8SyoZChq";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Z+fqByu3";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="8SyoZChq"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 146684A0F
	for <linux-nfs@vger.kernel.org>; Mon, 29 Jan 2024 03:37:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706499444; cv=none; b=gNxDXBuTnMGO6XXnsoNrYjihrlNlHuVPzrQR0ExwmwoqlvodNdeFdBNbpAJXT9pDUNPDvH9K+7jyN19gFf94K+enPSVutLINJL8jHzka/BalKmgE/qMidMAfD0hCWL4pDUtE/pPGGS1Agg0+aas0hJABDW2Fz/ghLfurDB4AUHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706499444; c=relaxed/simple;
	bh=SaeMn3oZAtm3czFkoVsOaWyTYKB6DewwvrGMWhXzSB8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kvemtXkcvFBhc/5wZI6+8gwSaD9u931PDKB4hx0P9Drgxf0T7sqD+NurQSLMrWbol/nMTnhVKOQZkeDdRNct3yfhWiJh3oSXxiJIQ5xlw2ZeL32CQ3BeIPejIUaCqCI+nDlW2nnct+E9kfcWXQjvUSUeGLCOu0pJPM8kmHSejRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=Z+fqByu3; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=8SyoZChq; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=Z+fqByu3; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=8SyoZChq; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 2CE4E2229D;
	Mon, 29 Jan 2024 03:37:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1706499440; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0sgF13g/1+zF1+exOtT4ktSUyzafNvbCywSEPLrdi4M=;
	b=Z+fqByu3003gVLhRZrsH6iyQB4sK3HJJinNnGeqbztKhAWsZdMbRsN++KSyWoMiOPW+wgF
	597LyLRwGlmw+Y3dACS9hhalW+ceB+r01VuEHIxVtlf/k/oc+I9fSN6j9YX7e97qW1aCuU
	1oBsNhxnsxKV9dAiH386FFYEWnIVUeg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1706499440;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0sgF13g/1+zF1+exOtT4ktSUyzafNvbCywSEPLrdi4M=;
	b=8SyoZChqc/UVkM4q+e3kcZsNGMszeBHXaG+kaqlbkv7KP5isJUy/ruq92V/9xgoyf/izNw
	TX8sqyr2eCty4ODA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1706499440; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0sgF13g/1+zF1+exOtT4ktSUyzafNvbCywSEPLrdi4M=;
	b=Z+fqByu3003gVLhRZrsH6iyQB4sK3HJJinNnGeqbztKhAWsZdMbRsN++KSyWoMiOPW+wgF
	597LyLRwGlmw+Y3dACS9hhalW+ceB+r01VuEHIxVtlf/k/oc+I9fSN6j9YX7e97qW1aCuU
	1oBsNhxnsxKV9dAiH386FFYEWnIVUeg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1706499440;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0sgF13g/1+zF1+exOtT4ktSUyzafNvbCywSEPLrdi4M=;
	b=8SyoZChqc/UVkM4q+e3kcZsNGMszeBHXaG+kaqlbkv7KP5isJUy/ruq92V/9xgoyf/izNw
	TX8sqyr2eCty4ODA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4430713867;
	Mon, 29 Jan 2024 03:37:16 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id p5AnO2wdt2UmKgAAD6G6ig
	(envelope-from <neilb@suse.de>); Mon, 29 Jan 2024 03:37:16 +0000
From: NeilBrown <neilb@suse.de>
To: Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>
Cc: linux-nfs@vger.kernel.org,
	Olga Kornievskaia <kolga@netapp.com>,
	Dai Ngo <Dai.Ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>,
	Christoph Hellwig <hch@lst.de>,
	Tom Haynes <loghyr@gmail.com>
Subject: [PATCH 05/13] nfsd: split sc_status out of sc_type
Date: Mon, 29 Jan 2024 14:29:27 +1100
Message-ID: <20240129033637.2133-6-neilb@suse.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240129033637.2133-1-neilb@suse.de>
References: <20240129033637.2133-1-neilb@suse.de>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp-out1.suse.de;
	none
X-Spamd-Result: default: False [1.90 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 FREEMAIL_ENVRCPT(0.00)[gmail.com];
	 R_MISSING_CHARSET(2.50)[];
	 MIME_GOOD(-0.10)[text/plain];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 BROKEN_CONTENT_TYPE(1.50)[];
	 R_RATELIMIT(0.00)[from(RLewrxuus8mos16izbn)];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 RCPT_COUNT_SEVEN(0.00)[8];
	 MID_CONTAINS_FROM(1.00)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 FREEMAIL_CC(0.00)[vger.kernel.org,netapp.com,oracle.com,talpey.com,lst.de,gmail.com];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-3.00)[100.00%]
X-Spam-Level: *
X-Spam-Score: 1.90
X-Spam-Flag: NO

sc_type identifies the type of a state - open, lock, deleg, layout - and
also the status of a state - closed or revoked.

This is a bit untidy and could get worse when "admin-revoked" states are
added.  So clean it up.

With this patch, the type is now all that is stored in sc_type.  This is
zero when the state is first added to ->cl_stateids (causing it to be
ignored), and is then set appropriately once it is fully initialised.
It is set under ->cl_lock to ensure atomicity w.r.t lookup.  It is now
never cleared.

sc_type is still a bit-set even though at most one bit is set.  This allows
lookup functions to be given a bitmap of acceptable types.

sc_type is now an unsigned short rather than char.  There is no value in
restricting to just 8 bits.

All the constants now start SC_TYPE_ matching the field in which they
are stored.  Keeping the existing names and ensuring clear separation
from non-type flags would have required something like
NFS4_STID_TYPE_CLOSED which is cumbersome.  The "NFS4" prefix is
redundant was they only appear in NFS4 code, so remove that and change
STID to SC to match the field.

The status is stored in a separate unsigned short named "sc_status".  It
has two flags: SC_STATUS_CLOSED and SC_STATUS_REVOKED.
CLOSED combines NFS4_CLOSED_STID, NFS4_CLOSED_DELEG_STID, and is used
for SC_TYPE_LOCK and SC_TYPE_LAYOUT instead of setting the sc_type to zero.
These flags are only ever set, never cleared.
For deleg stateids they are set under the global state_lock.
For open and lock stateids they are set under ->cl_lock.
For layout stateids they are set under ->ls_lock

nfs4_unhash_stid() has been removed, and we never set sc_type = 0.  This
was only used for LOCK and LAYOUT stids and they now use
SC_STATUS_CLOSED.

Also TRACE_DEFINE_NUM() calls for the various STID #define have been
removed because these things are not enums, and so that call is
incorrect.

Signed-off-by: NeilBrown <neilb@suse.de>
---
 fs/nfsd/nfs4layouts.c |  14 +--
 fs/nfsd/nfs4state.c   | 207 +++++++++++++++++++++---------------------
 fs/nfsd/state.h       |  40 +++++---
 fs/nfsd/trace.h       |  31 +++----
 4 files changed, 151 insertions(+), 141 deletions(-)

diff --git a/fs/nfsd/nfs4layouts.c b/fs/nfsd/nfs4layouts.c
index 5e8096bc5eaa..857b822450b4 100644
--- a/fs/nfsd/nfs4layouts.c
+++ b/fs/nfsd/nfs4layouts.c
@@ -236,7 +236,7 @@ nfsd4_alloc_layout_stateid(struct nfsd4_compound_state *cstate,
 	nfsd4_init_cb(&ls->ls_recall, clp, &nfsd4_cb_layout_ops,
 			NFSPROC4_CLNT_CB_LAYOUT);
 
-	if (parent->sc_type == NFS4_DELEG_STID)
+	if (parent->sc_type == SC_TYPE_DELEG)
 		ls->ls_file = nfsd_file_get(fp->fi_deleg_file);
 	else
 		ls->ls_file = find_any_file(fp);
@@ -250,7 +250,7 @@ nfsd4_alloc_layout_stateid(struct nfsd4_compound_state *cstate,
 	}
 
 	spin_lock(&clp->cl_lock);
-	stp->sc_type = NFS4_LAYOUT_STID;
+	stp->sc_type = SC_TYPE_LAYOUT;
 	list_add(&ls->ls_perclnt, &clp->cl_lo_states);
 	spin_unlock(&clp->cl_lock);
 
@@ -269,13 +269,13 @@ nfsd4_preprocess_layout_stateid(struct svc_rqst *rqstp,
 {
 	struct nfs4_layout_stateid *ls;
 	struct nfs4_stid *stid;
-	unsigned char typemask = NFS4_LAYOUT_STID;
+	unsigned short typemask = SC_TYPE_LAYOUT;
 	__be32 status;
 
 	if (create)
-		typemask |= (NFS4_OPEN_STID | NFS4_LOCK_STID | NFS4_DELEG_STID);
+		typemask |= (SC_TYPE_OPEN | SC_TYPE_LOCK | SC_TYPE_DELEG);
 
-	status = nfsd4_lookup_stateid(cstate, stateid, typemask, &stid,
+	status = nfsd4_lookup_stateid(cstate, stateid, typemask, 0, &stid,
 			net_generic(SVC_NET(rqstp), nfsd_net_id));
 	if (status)
 		goto out;
@@ -286,7 +286,7 @@ nfsd4_preprocess_layout_stateid(struct svc_rqst *rqstp,
 		goto out_put_stid;
 	}
 
-	if (stid->sc_type != NFS4_LAYOUT_STID) {
+	if (stid->sc_type != SC_TYPE_LAYOUT) {
 		ls = nfsd4_alloc_layout_stateid(cstate, stid, layout_type);
 		nfs4_put_stid(stid);
 
@@ -518,7 +518,7 @@ nfsd4_return_file_layouts(struct svc_rqst *rqstp,
 		lrp->lrs_present = true;
 	} else {
 		trace_nfsd_layoutstate_unhash(&ls->ls_stid.sc_stateid);
-		nfs4_unhash_stid(&ls->ls_stid);
+		ls->ls_stid.sc_status |= SC_STATUS_CLOSED;
 		lrp->lrs_present = false;
 	}
 	spin_unlock(&ls->ls_lock);
diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index dbf9ed84610e..6bccdd0af814 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -1260,11 +1260,6 @@ static void destroy_unhashed_deleg(struct nfs4_delegation *dp)
 	nfs4_put_stid(&dp->dl_stid);
 }
 
-void nfs4_unhash_stid(struct nfs4_stid *s)
-{
-	s->sc_type = 0;
-}
-
 /**
  * nfs4_delegation_exists - Discover if this delegation already exists
  * @clp:     a pointer to the nfs4_client we're granting a delegation to
@@ -1317,7 +1312,7 @@ hash_delegation_locked(struct nfs4_delegation *dp, struct nfs4_file *fp)
 	if (nfs4_delegation_exists(clp, fp))
 		return -EAGAIN;
 	refcount_inc(&dp->dl_stid.sc_count);
-	dp->dl_stid.sc_type = NFS4_DELEG_STID;
+	dp->dl_stid.sc_type = SC_TYPE_DELEG;
 	list_add(&dp->dl_perfile, &fp->fi_delegations);
 	list_add(&dp->dl_perclnt, &clp->cl_delegations);
 	return 0;
@@ -1329,7 +1324,7 @@ static bool delegation_hashed(struct nfs4_delegation *dp)
 }
 
 static bool
-unhash_delegation_locked(struct nfs4_delegation *dp, unsigned char type)
+unhash_delegation_locked(struct nfs4_delegation *dp, unsigned short statusmask)
 {
 	struct nfs4_file *fp = dp->dl_stid.sc_file;
 
@@ -1339,8 +1334,9 @@ unhash_delegation_locked(struct nfs4_delegation *dp, unsigned char type)
 		return false;
 
 	if (dp->dl_stid.sc_client->cl_minorversion == 0)
-		type = NFS4_CLOSED_DELEG_STID;
-	dp->dl_stid.sc_type = type;
+		statusmask = SC_STATUS_CLOSED;
+	dp->dl_stid.sc_status |= statusmask;
+
 	/* Ensure that deleg break won't try to requeue it */
 	++dp->dl_time;
 	spin_lock(&fp->fi_lock);
@@ -1356,7 +1352,7 @@ static void destroy_delegation(struct nfs4_delegation *dp)
 	bool unhashed;
 
 	spin_lock(&state_lock);
-	unhashed = unhash_delegation_locked(dp, NFS4_CLOSED_DELEG_STID);
+	unhashed = unhash_delegation_locked(dp, SC_STATUS_CLOSED);
 	spin_unlock(&state_lock);
 	if (unhashed)
 		destroy_unhashed_deleg(dp);
@@ -1370,7 +1366,7 @@ static void revoke_delegation(struct nfs4_delegation *dp)
 
 	trace_nfsd_stid_revoke(&dp->dl_stid);
 
-	if (dp->dl_stid.sc_type == NFS4_REVOKED_DELEG_STID) {
+	if (dp->dl_stid.sc_status & SC_STATUS_REVOKED) {
 		spin_lock(&clp->cl_lock);
 		refcount_inc(&dp->dl_stid.sc_count);
 		list_add(&dp->dl_recall_lru, &clp->cl_revoked);
@@ -1379,8 +1375,8 @@ static void revoke_delegation(struct nfs4_delegation *dp)
 	destroy_unhashed_deleg(dp);
 }
 
-/* 
- * SETCLIENTID state 
+/*
+ * SETCLIENTID state
  */
 
 static unsigned int clientid_hashval(u32 id)
@@ -1543,7 +1539,7 @@ static bool unhash_lock_stateid(struct nfs4_ol_stateid *stp)
 	if (!unhash_ol_stateid(stp))
 		return false;
 	list_del_init(&stp->st_locks);
-	nfs4_unhash_stid(&stp->st_stid);
+	stp->st_stid.sc_status |= SC_STATUS_CLOSED;
 	return true;
 }
 
@@ -1622,6 +1618,7 @@ static void release_open_stateid(struct nfs4_ol_stateid *stp)
 	LIST_HEAD(reaplist);
 
 	spin_lock(&stp->st_stid.sc_client->cl_lock);
+	stp->st_stid.sc_status |= SC_STATUS_CLOSED;
 	if (unhash_open_stateid(stp, &reaplist))
 		put_ol_stateid_locked(stp, &reaplist);
 	spin_unlock(&stp->st_stid.sc_client->cl_lock);
@@ -2230,7 +2227,7 @@ __destroy_client(struct nfs4_client *clp)
 	spin_lock(&state_lock);
 	while (!list_empty(&clp->cl_delegations)) {
 		dp = list_entry(clp->cl_delegations.next, struct nfs4_delegation, dl_perclnt);
-		unhash_delegation_locked(dp, NFS4_CLOSED_DELEG_STID);
+		unhash_delegation_locked(dp, SC_STATUS_CLOSED);
 		list_add(&dp->dl_recall_lru, &reaplist);
 	}
 	spin_unlock(&state_lock);
@@ -2462,14 +2459,16 @@ find_stateid_locked(struct nfs4_client *cl, stateid_t *t)
 }
 
 static struct nfs4_stid *
-find_stateid_by_type(struct nfs4_client *cl, stateid_t *t, char typemask)
+find_stateid_by_type(struct nfs4_client *cl, stateid_t *t,
+		     unsigned short typemask, unsigned short ok_states)
 {
 	struct nfs4_stid *s;
 
 	spin_lock(&cl->cl_lock);
 	s = find_stateid_locked(cl, t);
 	if (s != NULL) {
-		if (typemask & s->sc_type)
+		if ((s->sc_status & ~ok_states) == 0 &&
+		    (typemask & s->sc_type))
 			refcount_inc(&s->sc_count);
 		else
 			s = NULL;
@@ -2622,7 +2621,7 @@ static int nfs4_show_open(struct seq_file *s, struct nfs4_stid *st)
 	struct nfs4_stateowner *oo;
 	unsigned int access, deny;
 
-	if (st->sc_type != NFS4_OPEN_STID && st->sc_type != NFS4_LOCK_STID)
+	if (st->sc_type != SC_TYPE_OPEN && st->sc_type != SC_TYPE_LOCK)
 		return 0; /* XXX: or SEQ_SKIP? */
 	ols = openlockstateid(st);
 	oo = ols->st_stateowner;
@@ -2754,13 +2753,13 @@ static int states_show(struct seq_file *s, void *v)
 	struct nfs4_stid *st = v;
 
 	switch (st->sc_type) {
-	case NFS4_OPEN_STID:
+	case SC_TYPE_OPEN:
 		return nfs4_show_open(s, st);
-	case NFS4_LOCK_STID:
+	case SC_TYPE_LOCK:
 		return nfs4_show_lock(s, st);
-	case NFS4_DELEG_STID:
+	case SC_TYPE_DELEG:
 		return nfs4_show_deleg(s, st);
-	case NFS4_LAYOUT_STID:
+	case SC_TYPE_LAYOUT:
 		return nfs4_show_layout(s, st);
 	default:
 		return 0; /* XXX: or SEQ_SKIP? */
@@ -4532,7 +4531,8 @@ nfsd4_find_existing_open(struct nfs4_file *fp, struct nfsd4_open *open)
 			continue;
 		if (local->st_stateowner != &oo->oo_owner)
 			continue;
-		if (local->st_stid.sc_type == NFS4_OPEN_STID) {
+		if (local->st_stid.sc_type == SC_TYPE_OPEN &&
+		    !local->st_stid.sc_status) {
 			ret = local;
 			refcount_inc(&ret->st_stid.sc_count);
 			break;
@@ -4546,17 +4546,10 @@ nfsd4_verify_open_stid(struct nfs4_stid *s)
 {
 	__be32 ret = nfs_ok;
 
-	switch (s->sc_type) {
-	default:
-		break;
-	case 0:
-	case NFS4_CLOSED_STID:
-	case NFS4_CLOSED_DELEG_STID:
-		ret = nfserr_bad_stateid;
-		break;
-	case NFS4_REVOKED_DELEG_STID:
+	if (s->sc_status & SC_STATUS_REVOKED)
 		ret = nfserr_deleg_revoked;
-	}
+	else if (s->sc_status & SC_STATUS_CLOSED)
+		ret = nfserr_bad_stateid;
 	return ret;
 }
 
@@ -4642,7 +4635,7 @@ init_open_stateid(struct nfs4_file *fp, struct nfsd4_open *open)
 
 	open->op_stp = NULL;
 	refcount_inc(&stp->st_stid.sc_count);
-	stp->st_stid.sc_type = NFS4_OPEN_STID;
+	stp->st_stid.sc_type = SC_TYPE_OPEN;
 	INIT_LIST_HEAD(&stp->st_locks);
 	stp->st_stateowner = nfs4_get_stateowner(&oo->oo_owner);
 	get_nfs4_file(fp);
@@ -4869,9 +4862,9 @@ static int nfsd4_cb_recall_done(struct nfsd4_callback *cb,
 
 	trace_nfsd_cb_recall_done(&dp->dl_stid.sc_stateid, task);
 
-	if (dp->dl_stid.sc_type == NFS4_CLOSED_DELEG_STID ||
-	    dp->dl_stid.sc_type == NFS4_REVOKED_DELEG_STID)
-	        return 1;
+	if (dp->dl_stid.sc_status)
+		/* CLOSED or REVOKED */
+		return 1;
 
 	switch (task->tk_status) {
 	case 0:
@@ -5116,12 +5109,12 @@ static int share_access_to_flags(u32 share_access)
 	return share_access == NFS4_SHARE_ACCESS_READ ? RD_STATE : WR_STATE;
 }
 
-static struct nfs4_delegation *find_deleg_stateid(struct nfs4_client *cl, stateid_t *s)
+static struct nfs4_delegation *find_deleg_stateid(struct nfs4_client *cl,
+						  stateid_t *s)
 {
 	struct nfs4_stid *ret;
 
-	ret = find_stateid_by_type(cl, s,
-				NFS4_DELEG_STID|NFS4_REVOKED_DELEG_STID);
+	ret = find_stateid_by_type(cl, s, SC_TYPE_DELEG, SC_STATUS_REVOKED);
 	if (!ret)
 		return NULL;
 	return delegstateid(ret);
@@ -5144,7 +5137,7 @@ nfs4_check_deleg(struct nfs4_client *cl, struct nfsd4_open *open,
 	deleg = find_deleg_stateid(cl, &open->op_delegate_stateid);
 	if (deleg == NULL)
 		goto out;
-	if (deleg->dl_stid.sc_type == NFS4_REVOKED_DELEG_STID) {
+	if (deleg->dl_stid.sc_status & SC_STATUS_REVOKED) {
 		nfs4_put_stid(&deleg->dl_stid);
 		status = nfserr_deleg_revoked;
 		goto out;
@@ -5777,7 +5770,6 @@ nfsd4_process_open2(struct svc_rqst *rqstp, struct svc_fh *current_fh, struct nf
 	} else {
 		status = nfs4_get_vfs_file(rqstp, fp, current_fh, stp, open, true);
 		if (status) {
-			stp->st_stid.sc_type = NFS4_CLOSED_STID;
 			release_open_stateid(stp);
 			mutex_unlock(&stp->st_mutex);
 			goto out;
@@ -6169,7 +6161,7 @@ nfs4_laundromat(struct nfsd_net *nn)
 		dp = list_entry (pos, struct nfs4_delegation, dl_recall_lru);
 		if (!state_expired(&lt, dp->dl_time))
 			break;
-		unhash_delegation_locked(dp, NFS4_REVOKED_DELEG_STID);
+		unhash_delegation_locked(dp, SC_STATUS_REVOKED);
 		list_add(&dp->dl_recall_lru, &reaplist);
 	}
 	spin_unlock(&state_lock);
@@ -6408,22 +6400,20 @@ static __be32 nfsd4_validate_stateid(struct nfs4_client *cl, stateid_t *stateid)
 	status = nfsd4_stid_check_stateid_generation(stateid, s, 1);
 	if (status)
 		goto out_unlock;
+	status = nfsd4_verify_open_stid(s);
+	if (status)
+		goto out_unlock;
+
 	switch (s->sc_type) {
-	case NFS4_DELEG_STID:
+	case SC_TYPE_DELEG:
 		status = nfs_ok;
 		break;
-	case NFS4_REVOKED_DELEG_STID:
-		status = nfserr_deleg_revoked;
-		break;
-	case NFS4_OPEN_STID:
-	case NFS4_LOCK_STID:
+	case SC_TYPE_OPEN:
+	case SC_TYPE_LOCK:
 		status = nfsd4_check_openowner_confirmed(openlockstateid(s));
 		break;
 	default:
 		printk("unknown stateid type %x\n", s->sc_type);
-		fallthrough;
-	case NFS4_CLOSED_STID:
-	case NFS4_CLOSED_DELEG_STID:
 		status = nfserr_bad_stateid;
 	}
 out_unlock:
@@ -6433,7 +6423,8 @@ static __be32 nfsd4_validate_stateid(struct nfs4_client *cl, stateid_t *stateid)
 
 __be32
 nfsd4_lookup_stateid(struct nfsd4_compound_state *cstate,
-		     stateid_t *stateid, unsigned char typemask,
+		     stateid_t *stateid,
+		     unsigned short typemask, unsigned short statusmask,
 		     struct nfs4_stid **s, struct nfsd_net *nn)
 {
 	__be32 status;
@@ -6444,10 +6435,13 @@ nfsd4_lookup_stateid(struct nfsd4_compound_state *cstate,
 	 *  only return revoked delegations if explicitly asked.
 	 *  otherwise we report revoked or bad_stateid status.
 	 */
-	if (typemask & NFS4_REVOKED_DELEG_STID)
+	if (statusmask & SC_STATUS_REVOKED)
 		return_revoked = true;
-	else if (typemask & NFS4_DELEG_STID)
-		typemask |= NFS4_REVOKED_DELEG_STID;
+	if (typemask & SC_TYPE_DELEG)
+		/* Always allow REVOKED for DELEG so we can
+		 * retturn the appropriate error.
+		 */
+		statusmask |= SC_STATUS_REVOKED;
 
 	if (ZERO_STATEID(stateid) || ONE_STATEID(stateid) ||
 		CLOSE_STATEID(stateid))
@@ -6460,14 +6454,12 @@ nfsd4_lookup_stateid(struct nfsd4_compound_state *cstate,
 	}
 	if (status)
 		return status;
-	stid = find_stateid_by_type(cstate->clp, stateid, typemask);
+	stid = find_stateid_by_type(cstate->clp, stateid, typemask, statusmask);
 	if (!stid)
 		return nfserr_bad_stateid;
-	if ((stid->sc_type == NFS4_REVOKED_DELEG_STID) && !return_revoked) {
+	if ((stid->sc_status & SC_STATUS_REVOKED) && !return_revoked) {
 		nfs4_put_stid(stid);
-		if (cstate->minorversion)
-			return nfserr_deleg_revoked;
-		return nfserr_bad_stateid;
+		return nfserr_deleg_revoked;
 	}
 	*s = stid;
 	return nfs_ok;
@@ -6478,17 +6470,17 @@ nfs4_find_file(struct nfs4_stid *s, int flags)
 {
 	struct nfsd_file *ret = NULL;
 
-	if (!s)
+	if (!s || s->sc_status)
 		return NULL;
 
 	switch (s->sc_type) {
-	case NFS4_DELEG_STID:
+	case SC_TYPE_DELEG:
 		spin_lock(&s->sc_file->fi_lock);
 		ret = nfsd_file_get(s->sc_file->fi_deleg_file);
 		spin_unlock(&s->sc_file->fi_lock);
 		break;
-	case NFS4_OPEN_STID:
-	case NFS4_LOCK_STID:
+	case SC_TYPE_OPEN:
+	case SC_TYPE_LOCK:
 		if (flags & RD_STATE)
 			ret = find_readable_file(s->sc_file);
 		else
@@ -6601,7 +6593,8 @@ static __be32 find_cpntf_state(struct nfsd_net *nn, stateid_t *st,
 		goto out;
 
 	*stid = find_stateid_by_type(found, &cps->cp_p_stateid,
-			NFS4_DELEG_STID|NFS4_OPEN_STID|NFS4_LOCK_STID);
+				     SC_TYPE_DELEG|SC_TYPE_OPEN|SC_TYPE_LOCK,
+				     0);
 	if (*stid)
 		status = nfs_ok;
 	else
@@ -6658,8 +6651,8 @@ nfs4_preprocess_stateid_op(struct svc_rqst *rqstp,
 	}
 
 	status = nfsd4_lookup_stateid(cstate, stateid,
-				NFS4_DELEG_STID|NFS4_OPEN_STID|NFS4_LOCK_STID,
-				&s, nn);
+				SC_TYPE_DELEG|SC_TYPE_OPEN|SC_TYPE_LOCK,
+				0, &s, nn);
 	if (status == nfserr_bad_stateid)
 		status = find_cpntf_state(nn, stateid, &s);
 	if (status)
@@ -6670,16 +6663,13 @@ nfs4_preprocess_stateid_op(struct svc_rqst *rqstp,
 		goto out;
 
 	switch (s->sc_type) {
-	case NFS4_DELEG_STID:
+	case SC_TYPE_DELEG:
 		status = nfs4_check_delegmode(delegstateid(s), flags);
 		break;
-	case NFS4_OPEN_STID:
-	case NFS4_LOCK_STID:
+	case SC_TYPE_OPEN:
+	case SC_TYPE_LOCK:
 		status = nfs4_check_olstateid(openlockstateid(s), flags);
 		break;
-	default:
-		status = nfserr_bad_stateid;
-		break;
 	}
 	if (status)
 		goto out;
@@ -6758,33 +6748,34 @@ nfsd4_free_stateid(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 
 	spin_lock(&cl->cl_lock);
 	s = find_stateid_locked(cl, stateid);
-	if (!s)
+	if (!s || s->sc_status & SC_STATUS_CLOSED)
 		goto out_unlock;
 	spin_lock(&s->sc_lock);
 	switch (s->sc_type) {
-	case NFS4_DELEG_STID:
+	case SC_TYPE_DELEG:
+		if (s->sc_status & SC_STATUS_REVOKED) {
+			spin_unlock(&s->sc_lock);
+			dp = delegstateid(s);
+			list_del_init(&dp->dl_recall_lru);
+			spin_unlock(&cl->cl_lock);
+			nfs4_put_stid(s);
+			ret = nfs_ok;
+			goto out;
+		}
 		ret = nfserr_locks_held;
 		break;
-	case NFS4_OPEN_STID:
+	case SC_TYPE_OPEN:
 		ret = check_stateid_generation(stateid, &s->sc_stateid, 1);
 		if (ret)
 			break;
 		ret = nfserr_locks_held;
 		break;
-	case NFS4_LOCK_STID:
+	case SC_TYPE_LOCK:
 		spin_unlock(&s->sc_lock);
 		refcount_inc(&s->sc_count);
 		spin_unlock(&cl->cl_lock);
 		ret = nfsd4_free_lock_stateid(stateid, s);
 		goto out;
-	case NFS4_REVOKED_DELEG_STID:
-		spin_unlock(&s->sc_lock);
-		dp = delegstateid(s);
-		list_del_init(&dp->dl_recall_lru);
-		spin_unlock(&cl->cl_lock);
-		nfs4_put_stid(s);
-		ret = nfs_ok;
-		goto out;
 	/* Default falls through and returns nfserr_bad_stateid */
 	}
 	spin_unlock(&s->sc_lock);
@@ -6827,6 +6818,7 @@ static __be32 nfs4_seqid_op_checks(struct nfsd4_compound_state *cstate, stateid_
  * @seqid: seqid (provided by client)
  * @stateid: stateid (provided by client)
  * @typemask: mask of allowable types for this operation
+ * @statusmask: mask of allowed states: 0 or STID_CLOSED
  * @stpp: return pointer for the stateid found
  * @nn: net namespace for request
  *
@@ -6836,7 +6828,8 @@ static __be32 nfs4_seqid_op_checks(struct nfsd4_compound_state *cstate, stateid_
  */
 static __be32
 nfs4_preprocess_seqid_op(struct nfsd4_compound_state *cstate, u32 seqid,
-			 stateid_t *stateid, char typemask,
+			 stateid_t *stateid,
+			 unsigned short typemask, unsigned short statusmask,
 			 struct nfs4_ol_stateid **stpp,
 			 struct nfsd_net *nn)
 {
@@ -6847,7 +6840,8 @@ nfs4_preprocess_seqid_op(struct nfsd4_compound_state *cstate, u32 seqid,
 	trace_nfsd_preprocess(seqid, stateid);
 
 	*stpp = NULL;
-	status = nfsd4_lookup_stateid(cstate, stateid, typemask, &s, nn);
+	status = nfsd4_lookup_stateid(cstate, stateid,
+				      typemask, statusmask, &s, nn);
 	if (status)
 		return status;
 	stp = openlockstateid(s);
@@ -6869,7 +6863,7 @@ static __be32 nfs4_preprocess_confirmed_seqid_op(struct nfsd4_compound_state *cs
 	struct nfs4_ol_stateid *stp;
 
 	status = nfs4_preprocess_seqid_op(cstate, seqid, stateid,
-						NFS4_OPEN_STID, &stp, nn);
+					  SC_TYPE_OPEN, 0, &stp, nn);
 	if (status)
 		return status;
 	oo = openowner(stp->st_stateowner);
@@ -6900,8 +6894,8 @@ nfsd4_open_confirm(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 		return status;
 
 	status = nfs4_preprocess_seqid_op(cstate,
-					oc->oc_seqid, &oc->oc_req_stateid,
-					NFS4_OPEN_STID, &stp, nn);
+					  oc->oc_seqid, &oc->oc_req_stateid,
+					  SC_TYPE_OPEN, 0, &stp, nn);
 	if (status)
 		goto out;
 	oo = openowner(stp->st_stateowner);
@@ -7031,18 +7025,20 @@ nfsd4_close(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 	struct net *net = SVC_NET(rqstp);
 	struct nfsd_net *nn = net_generic(net, nfsd_net_id);
 
-	dprintk("NFSD: nfsd4_close on file %pd\n", 
+	dprintk("NFSD: nfsd4_close on file %pd\n",
 			cstate->current_fh.fh_dentry);
 
 	status = nfs4_preprocess_seqid_op(cstate, close->cl_seqid,
-					&close->cl_stateid,
-					NFS4_OPEN_STID|NFS4_CLOSED_STID,
-					&stp, nn);
+					  &close->cl_stateid,
+					  SC_TYPE_OPEN, SC_STATUS_CLOSED,
+					  &stp, nn);
 	nfsd4_bump_seqid(cstate, status);
 	if (status)
-		goto out; 
+		goto out;
 
-	stp->st_stid.sc_type = NFS4_CLOSED_STID;
+	spin_lock(&stp->st_stid.sc_client->cl_lock);
+	stp->st_stid.sc_status |= SC_STATUS_CLOSED;
+	spin_unlock(&stp->st_stid.sc_client->cl_lock);
 
 	/*
 	 * Technically we don't _really_ have to increment or copy it, since
@@ -7084,7 +7080,7 @@ nfsd4_delegreturn(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 	if ((status = fh_verify(rqstp, &cstate->current_fh, S_IFREG, 0)))
 		return status;
 
-	status = nfsd4_lookup_stateid(cstate, stateid, NFS4_DELEG_STID, &s, nn);
+	status = nfsd4_lookup_stateid(cstate, stateid, SC_TYPE_DELEG, 0, &s, nn);
 	if (status)
 		goto out;
 	dp = delegstateid(s);
@@ -7351,7 +7347,7 @@ init_lock_stateid(struct nfs4_ol_stateid *stp, struct nfs4_lockowner *lo,
 	if (retstp)
 		goto out_found;
 	refcount_inc(&stp->st_stid.sc_count);
-	stp->st_stid.sc_type = NFS4_LOCK_STID;
+	stp->st_stid.sc_type = SC_TYPE_LOCK;
 	stp->st_stateowner = nfs4_get_stateowner(&lo->lo_owner);
 	get_nfs4_file(fp);
 	stp->st_stid.sc_file = fp;
@@ -7538,9 +7534,10 @@ nfsd4_lock(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 							&lock_stp, &new);
 	} else {
 		status = nfs4_preprocess_seqid_op(cstate,
-				       lock->lk_old_lock_seqid,
-				       &lock->lk_old_lock_stateid,
-				       NFS4_LOCK_STID, &lock_stp, nn);
+						  lock->lk_old_lock_seqid,
+						  &lock->lk_old_lock_stateid,
+						  SC_TYPE_LOCK, 0, &lock_stp,
+						  nn);
 	}
 	if (status)
 		goto out;
@@ -7853,8 +7850,8 @@ nfsd4_locku(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 		 return nfserr_inval;
 
 	status = nfs4_preprocess_seqid_op(cstate, locku->lu_seqid,
-					&locku->lu_stateid, NFS4_LOCK_STID,
-					&stp, nn);
+					  &locku->lu_stateid, SC_TYPE_LOCK, 0,
+					  &stp, nn);
 	if (status)
 		goto out;
 	nf = find_any_file(stp->st_stid.sc_file);
@@ -8292,7 +8289,7 @@ nfs4_state_shutdown_net(struct net *net)
 	spin_lock(&state_lock);
 	list_for_each_safe(pos, next, &nn->del_recall_lru) {
 		dp = list_entry (pos, struct nfs4_delegation, dl_recall_lru);
-		unhash_delegation_locked(dp, NFS4_CLOSED_DELEG_STID);
+		unhash_delegation_locked(dp, SC_STATUS_CLOSED);
 		list_add(&dp->dl_recall_lru, &reaplist);
 	}
 	spin_unlock(&state_lock);
diff --git a/fs/nfsd/state.h b/fs/nfsd/state.h
index 41bdc913fa71..ffc8920d0558 100644
--- a/fs/nfsd/state.h
+++ b/fs/nfsd/state.h
@@ -88,17 +88,33 @@ struct nfsd4_callback_ops {
  */
 struct nfs4_stid {
 	refcount_t		sc_count;
-#define NFS4_OPEN_STID 1
-#define NFS4_LOCK_STID 2
-#define NFS4_DELEG_STID 4
-/* For an open stateid kept around *only* to process close replays: */
-#define NFS4_CLOSED_STID 8
+
+	/* A new stateid is added to the cl_stateids idr early before it
+	 * is fully initialised.  Its sc_type is then zero.  After
+	 * initialisation the sc_type it set under cl_lock, and then
+	 * never changes.
+	 */
+#define SC_TYPE_OPEN		BIT(0)
+#define SC_TYPE_LOCK		BIT(1)
+#define SC_TYPE_DELEG		BIT(2)
+#define SC_TYPE_LAYOUT		BIT(3)
+	unsigned short		sc_type;
+
+/* state_lock protects sc_status for delegation stateids.
+ * ->cl_lock protects sc_status for open and lock stateids.
+ * ->st_mutex also protect sc_status for open stateids.
+ * ->ls_lock protects sc_status for layout stateids.
+ */
+/*
+ * For an open stateid kept around *only* to process close replays.
+ * For deleg stateid, kept in idr until last reference is dropped.
+ */
+#define SC_STATUS_CLOSED	BIT(0)
 /* For a deleg stateid kept around only to process free_stateid's: */
-#define NFS4_REVOKED_DELEG_STID 16
-#define NFS4_CLOSED_DELEG_STID 32
-#define NFS4_LAYOUT_STID 64
+#define SC_STATUS_REVOKED	BIT(1)
+	unsigned short		sc_status;
+
 	struct list_head	sc_cp_list;
-	unsigned char		sc_type;
 	stateid_t		sc_stateid;
 	spinlock_t		sc_lock;
 	struct nfs4_client	*sc_client;
@@ -672,15 +688,15 @@ extern __be32 nfs4_preprocess_stateid_op(struct svc_rqst *rqstp,
 		stateid_t *stateid, int flags, struct nfsd_file **filp,
 		struct nfs4_stid **cstid);
 __be32 nfsd4_lookup_stateid(struct nfsd4_compound_state *cstate,
-		     stateid_t *stateid, unsigned char typemask,
-		     struct nfs4_stid **s, struct nfsd_net *nn);
+			    stateid_t *stateid, unsigned short typemask,
+			    unsigned short statusmask,
+			    struct nfs4_stid **s, struct nfsd_net *nn);
 struct nfs4_stid *nfs4_alloc_stid(struct nfs4_client *cl, struct kmem_cache *slab,
 				  void (*sc_free)(struct nfs4_stid *));
 int nfs4_init_copy_state(struct nfsd_net *nn, struct nfsd4_copy *copy);
 void nfs4_free_copy_state(struct nfsd4_copy *copy);
 struct nfs4_cpntf_state *nfs4_alloc_init_cpntf_state(struct nfsd_net *nn,
 			struct nfs4_stid *p_stid);
-void nfs4_unhash_stid(struct nfs4_stid *s);
 void nfs4_put_stid(struct nfs4_stid *s);
 void nfs4_inc_and_copy_stateid(stateid_t *dst, struct nfs4_stid *stid);
 void nfs4_remove_reclaim_record(struct nfs4_client_reclaim *, struct nfsd_net *);
diff --git a/fs/nfsd/trace.h b/fs/nfsd/trace.h
index d1e8cf079b0f..fe08ca18b647 100644
--- a/fs/nfsd/trace.h
+++ b/fs/nfsd/trace.h
@@ -641,23 +641,17 @@ DEFINE_EVENT(nfsd_stateseqid_class, nfsd_##name, \
 DEFINE_STATESEQID_EVENT(preprocess);
 DEFINE_STATESEQID_EVENT(open_confirm);
 
-TRACE_DEFINE_ENUM(NFS4_OPEN_STID);
-TRACE_DEFINE_ENUM(NFS4_LOCK_STID);
-TRACE_DEFINE_ENUM(NFS4_DELEG_STID);
-TRACE_DEFINE_ENUM(NFS4_CLOSED_STID);
-TRACE_DEFINE_ENUM(NFS4_REVOKED_DELEG_STID);
-TRACE_DEFINE_ENUM(NFS4_CLOSED_DELEG_STID);
-TRACE_DEFINE_ENUM(NFS4_LAYOUT_STID);
-
 #define show_stid_type(x)						\
 	__print_flags(x, "|",						\
-		{ NFS4_OPEN_STID,		"OPEN" },		\
-		{ NFS4_LOCK_STID,		"LOCK" },		\
-		{ NFS4_DELEG_STID,		"DELEG" },		\
-		{ NFS4_CLOSED_STID,		"CLOSED" },		\
-		{ NFS4_REVOKED_DELEG_STID,	"REVOKED" },		\
-		{ NFS4_CLOSED_DELEG_STID,	"CLOSED_DELEG" },	\
-		{ NFS4_LAYOUT_STID,		"LAYOUT" })
+		{ SC_TYPE_OPEN,		"OPEN" },		\
+		{ SC_TYPE_LOCK,		"LOCK" },		\
+		{ SC_TYPE_DELEG,		"DELEG" },		\
+		{ SC_TYPE_LAYOUT,		"LAYOUT" })
+
+#define show_stid_status(x)						\
+	__print_flags(x, "|",						\
+		{ SC_STATUS_CLOSED,		"CLOSED" },		\
+		{ SC_STATUS_REVOKED,		"REVOKED" })		\
 
 DECLARE_EVENT_CLASS(nfsd_stid_class,
 	TP_PROTO(
@@ -666,6 +660,7 @@ DECLARE_EVENT_CLASS(nfsd_stid_class,
 	TP_ARGS(stid),
 	TP_STRUCT__entry(
 		__field(unsigned long, sc_type)
+		__field(unsigned long, sc_status)
 		__field(int, sc_count)
 		__field(u32, cl_boot)
 		__field(u32, cl_id)
@@ -676,16 +671,18 @@ DECLARE_EVENT_CLASS(nfsd_stid_class,
 		const stateid_t *stp = &stid->sc_stateid;
 
 		__entry->sc_type = stid->sc_type;
+		__entry->sc_status = stid->sc_status;
 		__entry->sc_count = refcount_read(&stid->sc_count);
 		__entry->cl_boot = stp->si_opaque.so_clid.cl_boot;
 		__entry->cl_id = stp->si_opaque.so_clid.cl_id;
 		__entry->si_id = stp->si_opaque.so_id;
 		__entry->si_generation = stp->si_generation;
 	),
-	TP_printk("client %08x:%08x stateid %08x:%08x ref=%d type=%s",
+	TP_printk("client %08x:%08x stateid %08x:%08x ref=%d type=%s state=%s",
 		__entry->cl_boot, __entry->cl_id,
 		__entry->si_id, __entry->si_generation,
-		__entry->sc_count, show_stid_type(__entry->sc_type)
+		__entry->sc_count, show_stid_type(__entry->sc_type),
+		show_stid_status(__entry->sc_status)
 	)
 );
 
-- 
2.43.0



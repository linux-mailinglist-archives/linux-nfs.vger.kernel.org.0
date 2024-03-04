Return-Path: <linux-nfs+bounces-2154-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CEEF86F94D
	for <lists+linux-nfs@lfdr.de>; Mon,  4 Mar 2024 05:43:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 787661F214BE
	for <lists+linux-nfs@lfdr.de>; Mon,  4 Mar 2024 04:43:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDA4017C8;
	Mon,  4 Mar 2024 04:43:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="KKpumefE";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="XAMxECJ3";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="KKpumefE";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="XAMxECJ3"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01C744A3C
	for <linux-nfs@vger.kernel.org>; Mon,  4 Mar 2024 04:43:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709527422; cv=none; b=s3VFif2xKXi63Xe/1MF6bN8Yw/sLGuSu11CxHq8s6B2X4kKc2pFTNN2Ho5gGD2O/xYar0liEMmbW+me+mF3tNK09/ai2GSNlulMbt1tk40Ld9tiMl47thDfvW7a+2rk0jsqehhNvP0hhZGZ9tYYlwpskJ40QLAbjQM3dCwypJsE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709527422; c=relaxed/simple;
	bh=IRSVgYUAeExwJwzB8FBSpgJx4IdC8yAxmlUJBaWQ9SI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WFptyR9AcSHRcJlwE3sgiNi1/TFp4tA+dug2u4gjYXcTDVVzysKm1OPEcgx41wkSw6vg++SIRZRDnpnokxgcFaV0+8AXKT06sHXTYO0hbVFtLcHXbVYldrJV8reFjpJA+NmRE4w683wMo7eO1c/N0/9h4Zi7NMzXIbJ/x7V7K2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=KKpumefE; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=XAMxECJ3; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=KKpumefE; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=XAMxECJ3; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 26BF9680B9;
	Mon,  4 Mar 2024 04:43:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1709527419; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SSIr2uQMw2vlXpOEU8kF8JD17WH/2oj8+IN1b6mtos0=;
	b=KKpumefE8FshSIrje9LC8AlFboxillHNys+1pxsui0nXD03+yntuUl2dymFomnRQFRHSME
	SqLg2os2VFxxdonExyBfQYWfVImFhNtAUYsjHFUWDsWBSW39MDpRB+aIiaElZ200dpnF+z
	mA1sMN2Th6/VT/S9LKS/bUuV5qwtCuU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1709527419;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SSIr2uQMw2vlXpOEU8kF8JD17WH/2oj8+IN1b6mtos0=;
	b=XAMxECJ38z/W4isqWWnP9TJfg5OOY5h24iC3MSLZdzB7VOYIyweNpEySvQ4A0VJQAIVhB2
	rp5fCs4TR/78YOCw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1709527419; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SSIr2uQMw2vlXpOEU8kF8JD17WH/2oj8+IN1b6mtos0=;
	b=KKpumefE8FshSIrje9LC8AlFboxillHNys+1pxsui0nXD03+yntuUl2dymFomnRQFRHSME
	SqLg2os2VFxxdonExyBfQYWfVImFhNtAUYsjHFUWDsWBSW39MDpRB+aIiaElZ200dpnF+z
	mA1sMN2Th6/VT/S9LKS/bUuV5qwtCuU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1709527419;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SSIr2uQMw2vlXpOEU8kF8JD17WH/2oj8+IN1b6mtos0=;
	b=XAMxECJ38z/W4isqWWnP9TJfg5OOY5h24iC3MSLZdzB7VOYIyweNpEySvQ4A0VJQAIVhB2
	rp5fCs4TR/78YOCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 852AB13A9F;
	Mon,  4 Mar 2024 04:43:36 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id mSl5CnhR5WVqNwAAD6G6ig
	(envelope-from <neilb@suse.de>); Mon, 04 Mar 2024 04:43:36 +0000
From: NeilBrown <neilb@suse.de>
To: Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>
Cc: linux-nfs@vger.kernel.org,
	Olga Kornievskaia <kolga@netapp.com>,
	Dai Ngo <Dai.Ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>
Subject: [PATCH 3/4] nfsd: replace rp_mutex to avoid deadlock in move_to_close_lru()
Date: Mon,  4 Mar 2024 15:40:21 +1100
Message-ID: <20240304044304.3657-4-neilb@suse.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240304044304.3657-1-neilb@suse.de>
References: <20240304044304.3657-1-neilb@suse.de>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp-out2.suse.de;
	none
X-Spamd-Result: default: False [1.90 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 R_MISSING_CHARSET(2.50)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 BROKEN_CONTENT_TYPE(1.50)[];
	 RCPT_COUNT_FIVE(0.00)[6];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 MID_CONTAINS_FROM(1.00)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-3.00)[100.00%]
X-Spam-Level: *
X-Spam-Score: 1.90
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
 fs/nfsd/nfs4state.c | 38 +++++++++++++++++++++++++++++++-------
 fs/nfsd/state.h     |  2 +-
 2 files changed, 32 insertions(+), 8 deletions(-)

diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index 690d0e697320..47e879d5d68a 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -4430,21 +4430,32 @@ nfsd4_init_leases_net(struct nfsd_net *nn)
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
@@ -4453,7 +4464,8 @@ void nfsd4_cstate_clear_replay(struct nfsd4_compound_state *cstate)
 
 	if (so != NULL) {
 		cstate->replay_owner = NULL;
-		mutex_unlock(&so->so_replay.rp_mutex);
+		atomic_set(&so->so_replay.rp_locked, RP_UNLOCKED);
+		wake_up_var(&so->so_replay.rp_locked);
 		nfs4_put_stateowner(so);
 	}
 }
@@ -4691,7 +4703,11 @@ move_to_close_lru(struct nfs4_ol_stateid *s, struct net *net)
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
@@ -5064,11 +5080,15 @@ nfsd4_process_open1(struct nfsd4_compound_state *cstate,
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
@@ -6828,11 +6848,15 @@ nfs4_preprocess_seqid_op(struct nfsd4_compound_state *cstate, u32 seqid,
 	trace_nfsd_preprocess(seqid, stateid);
 
 	*stpp = NULL;
+retry:
 	status = nfsd4_lookup_stateid(cstate, stateid, typemask, &s, nn);
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
index 41bdc913fa71..6a3becd86112 100644
--- a/fs/nfsd/state.h
+++ b/fs/nfsd/state.h
@@ -446,7 +446,7 @@ struct nfs4_replay {
 	unsigned int		rp_buflen;
 	char			*rp_buf;
 	struct knfsd_fh		rp_openfh;
-	struct mutex		rp_mutex;
+	atomic_t		rp_locked;
 	char			rp_ibuf[NFSD4_REPLAY_ISIZE];
 };
 
-- 
2.43.0



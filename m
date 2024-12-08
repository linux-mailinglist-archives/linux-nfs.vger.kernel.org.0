Return-Path: <linux-nfs+bounces-8436-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A9969E8849
	for <lists+linux-nfs@lfdr.de>; Sun,  8 Dec 2024 23:47:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 46073280F5F
	for <lists+linux-nfs@lfdr.de>; Sun,  8 Dec 2024 22:47:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E24528691;
	Sun,  8 Dec 2024 22:47:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="gH9qs76b";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="ZvyIgnak";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="gH9qs76b";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="ZvyIgnak"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADE1084D29
	for <linux-nfs@vger.kernel.org>; Sun,  8 Dec 2024 22:47:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733698033; cv=none; b=C1WFmWJC1HxQqHuLKLv+j78OJ6E7XQhyW/GBsRVEPe3GvVzDIAIHTSaRBVuT4opij1DCZz9ao6B6pK45s/HI8b+LutCwRF7YR1vNjKiKR/Ya08iWZCp4IVJc/P/6Yv3Gq+CpomTWUYN25HpV47KR8+V5ScWQsJuiKZphABOuKSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733698033; c=relaxed/simple;
	bh=ngyeeYLPUQOgTlQm+FEjrAamtny6c4RI5c9TvM8wM7g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LmqSdHQAIKTIucmB9tPdXUIQaVmMkuy5CRBBFEgN0z5caurJvOVwpFxZCaENaOKNV9/5tSpJFn7s7m/4pqj8xCAK3uczDsppxlB18LMumTRDUvnoDy1mm4EZMJNBjQd7TIWz+wMEuW0cwrNJlGAKv66ez/IFuQ6BvZ7xbbFxW8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=gH9qs76b; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=ZvyIgnak; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=gH9qs76b; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=ZvyIgnak; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id DAD4D1F385;
	Sun,  8 Dec 2024 22:47:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1733698029; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XyZxyPeXY5WCKw9cguJ9EoNtwefoSSY7SrITZR0Nels=;
	b=gH9qs76bOfEIzkd0a8hRUm4jKhL3PRFDDVrFencPzK4JbRke1TqEzG3O5l1NQBnYosR3n3
	VzfSng97pPkYNYXp6qJG2VchSW8Q/J87zrqEc+bloISS9+vFZLB2BDVikAHDn90+2NB+im
	tDOxR4KmoAoVbfE41PEz9iRH0xO2P9g=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1733698029;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XyZxyPeXY5WCKw9cguJ9EoNtwefoSSY7SrITZR0Nels=;
	b=ZvyIgnakbiaqgMxJ6IZFj+h/2mEgGGc1PH+pKrnZMAoxgoyOu5nOjkQrzSTRINkeCIN/0+
	nAAfUZOVO10QNABw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1733698029; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XyZxyPeXY5WCKw9cguJ9EoNtwefoSSY7SrITZR0Nels=;
	b=gH9qs76bOfEIzkd0a8hRUm4jKhL3PRFDDVrFencPzK4JbRke1TqEzG3O5l1NQBnYosR3n3
	VzfSng97pPkYNYXp6qJG2VchSW8Q/J87zrqEc+bloISS9+vFZLB2BDVikAHDn90+2NB+im
	tDOxR4KmoAoVbfE41PEz9iRH0xO2P9g=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1733698029;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XyZxyPeXY5WCKw9cguJ9EoNtwefoSSY7SrITZR0Nels=;
	b=ZvyIgnakbiaqgMxJ6IZFj+h/2mEgGGc1PH+pKrnZMAoxgoyOu5nOjkQrzSTRINkeCIN/0+
	nAAfUZOVO10QNABw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B9A3D13998;
	Sun,  8 Dec 2024 22:47:07 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id W+pdG+shVmfhAQAAD6G6ig
	(envelope-from <neilb@suse.de>); Sun, 08 Dec 2024 22:47:07 +0000
From: NeilBrown <neilb@suse.de>
To: Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>
Cc: linux-nfs@vger.kernel.org,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <Dai.Ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>
Subject: [PATCH 4/6] nfsd: allocate new session-based DRC slots on demand.
Date: Mon,  9 Dec 2024 09:43:15 +1100
Message-ID: <20241208224629.697448-5-neilb@suse.de>
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

If a client ever uses the highest available slot for a given session,
attempt to allocate more slots so there is room for the client to use
them if wanted.  GFP_NOWAIT is used so if there is not plenty of
free memory, failure is expected - which is what we want.  It also
allows the allocation while holding a spinlock.

Each time we increase the number of slots by 20% (rounded up).  This
allows fairly quick growth while avoiding excessive over-shoot.

We would expect to stablise with around 10% more slots available than
the client actually uses.

Signed-off-by: NeilBrown <neilb@suse.de>
---
 fs/nfsd/nfs4state.c | 37 ++++++++++++++++++++++++++++++++-----
 1 file changed, 32 insertions(+), 5 deletions(-)

diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index 67dfc699e411..fd9473d487f3 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -4235,11 +4235,6 @@ nfsd4_sequence(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 	slot = xa_load(&session->se_slots, seq->slotid);
 	dprintk("%s: slotid %d\n", __func__, seq->slotid);
 
-	/* We do not negotiate the number of slots yet, so set the
-	 * maxslots to the session maxreqs which is used to encode
-	 * sr_highest_slotid and the sr_target_slot id to maxslots */
-	seq->maxslots = session->se_fchannel.maxreqs;
-
 	trace_nfsd_slot_seqid_sequence(clp, seq, slot);
 	status = check_slot_seqid(seq->seqid, slot->sl_seqid,
 					slot->sl_flags & NFSD4_SLOT_INUSE);
@@ -4289,6 +4284,38 @@ nfsd4_sequence(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 	cstate->session = session;
 	cstate->clp = clp;
 
+	/*
+	 * If the client ever uses the highest available slot,
+	 * gently try to allocate another 20%.  This allows
+	 * fairly quick growth without grossly over-shooting what
+	 * the client might use.
+	 */
+	if (seq->slotid == session->se_fchannel.maxreqs - 1 &&
+	    session->se_fchannel.maxreqs < NFSD_MAX_SLOTS_PER_SESSION) {
+		int s = session->se_fchannel.maxreqs;
+		int cnt = DIV_ROUND_UP(s, 5);
+
+		do {
+			/*
+			 * GFP_NOWAIT both allows allocation under a
+			 * spinlock, and only succeeds if there is
+			 * plenty of memory.
+			 */
+			slot = kzalloc(slot_bytes(&session->se_fchannel),
+				       GFP_NOWAIT);
+			if (slot &&
+			    !xa_is_err(xa_store(&session->se_slots, s, slot,
+						GFP_NOWAIT))) {
+				s += 1;
+				session->se_fchannel.maxreqs = s;
+			} else {
+				kfree(slot);
+				slot = NULL;
+			}
+		} while (slot && --cnt > 0);
+	}
+	seq->maxslots = session->se_fchannel.maxreqs;
+
 out:
 	switch (clp->cl_cb_state) {
 	case NFSD4_CB_DOWN:
-- 
2.47.0



Return-Path: <linux-nfs+bounces-7924-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E3FD09C68E9
	for <lists+linux-nfs@lfdr.de>; Wed, 13 Nov 2024 06:54:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 741661F23431
	for <lists+linux-nfs@lfdr.de>; Wed, 13 Nov 2024 05:54:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A79B61527A7;
	Wed, 13 Nov 2024 05:54:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="EWYDWOnC";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="jXedBEZw";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="EWYDWOnC";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="jXedBEZw"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0008E2309AE
	for <linux-nfs@vger.kernel.org>; Wed, 13 Nov 2024 05:54:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731477250; cv=none; b=MLxPAliEO+Npl1JcoyxBXi9c/pkGSR3kxboJJJtdp7WhBRHOSrxDAUAs7/4Ns0OPAH/dM2mS6IR9lmOOWt5d6QHwv/8KMGjsD8InSfHAwPtEQM30I2cT0mGrom9U5NtTj687PCkcEBexUIwTjPY/PKV+9ikk+O6oSDZ64GGHSw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731477250; c=relaxed/simple;
	bh=bvbhobzw/zRzH4V2Hi5D+LejyrLlBvNh1CnPdazMw38=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jzekodJ8rfz5dIMWAF0OYoxNT7/ArWrqU14WTerboAq7eNGGHWfgiOHxoutuEE1i1DYAf7zU2ZI/7eoED8PI3UUBMQqdNOy6eRoy+yALgxjPqwgc/lW62mBolpScXB/BJAGE448vWAaFOIzOwJ9Rlc1qWIzJ+Lu0vL6VEj/GZUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=EWYDWOnC; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=jXedBEZw; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=EWYDWOnC; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=jXedBEZw; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 333CF1F37C;
	Wed, 13 Nov 2024 05:54:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1731477247; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lzX+qC534JJcA9uid6IS+aRdRdskaikQAuxnrYz8eDA=;
	b=EWYDWOnCTORUAoaY1vIGhVIiLQoiNd/l5lpEClX/JRCYjmZFaIbxzivObNcNhLUoQJLpr6
	Tdlibnh+9DCCdBRIjR9Ih1ZAvUnxD3xcIKxCC/JpmVh35yZ7zUT0T35gEP+7EpYRryqq4i
	T84dC9OiPe0tWdyrM2ieFJ47tV86hug=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1731477247;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lzX+qC534JJcA9uid6IS+aRdRdskaikQAuxnrYz8eDA=;
	b=jXedBEZwqKLhzGeB/d5MaQj4e8ruSXQ821Z44YI+Vfj/ZbEvUtGNNC6WXlusJ1DeMMsjJ8
	6DsrQIuB2RNTQoBQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1731477247; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lzX+qC534JJcA9uid6IS+aRdRdskaikQAuxnrYz8eDA=;
	b=EWYDWOnCTORUAoaY1vIGhVIiLQoiNd/l5lpEClX/JRCYjmZFaIbxzivObNcNhLUoQJLpr6
	Tdlibnh+9DCCdBRIjR9Ih1ZAvUnxD3xcIKxCC/JpmVh35yZ7zUT0T35gEP+7EpYRryqq4i
	T84dC9OiPe0tWdyrM2ieFJ47tV86hug=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1731477247;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lzX+qC534JJcA9uid6IS+aRdRdskaikQAuxnrYz8eDA=;
	b=jXedBEZwqKLhzGeB/d5MaQj4e8ruSXQ821Z44YI+Vfj/ZbEvUtGNNC6WXlusJ1DeMMsjJ8
	6DsrQIuB2RNTQoBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 25EFD13890;
	Wed, 13 Nov 2024 05:54:04 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id afyZM/w+NGeSfQAAD6G6ig
	(envelope-from <neilb@suse.de>); Wed, 13 Nov 2024 05:54:04 +0000
From: NeilBrown <neilb@suse.de>
To: Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>
Cc: linux-nfs@vger.kernel.org,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <Dai.Ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>
Subject: [PATCH 2/4] nfsd: allocate new session-based DRC slots on demand.
Date: Wed, 13 Nov 2024 16:38:35 +1100
Message-ID: <20241113055345.494856-3-neilb@suse.de>
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
X-Spam-Score: -2.80
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,suse.de:email];
	RCVD_TLS_ALL(0.00)[]
X-Spam-Flag: NO
X-Spam-Level: 

If a client ever uses the highest available slot for a given session,
attempt to allocate another slot so there is room for the client to use
more slots if wanted.  GFP_NOWAIT is used so if there is not plenty of
free memory, failure is expected - which is what we want.  It also
allows the allocation while holding a spinlock.

We would expect to stablise with one more slot available than the client
actually uses.

Now that we grow the slot table on demand we can start with a smaller
allocation.  Define NFSD_MAX_UNUSED_SLOTS and allocate at most that many
when session is created.

Signed-off-by: NeilBrown <neilb@suse.de>
---
 fs/nfsd/nfs4state.c | 22 ++++++++++++++++------
 fs/nfsd/state.h     |  2 ++
 2 files changed, 18 insertions(+), 6 deletions(-)

diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index 2dcba0c83c10..683bb908039b 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -1953,7 +1953,7 @@ static struct nfsd4_session *alloc_session(struct nfsd4_channel_attrs *fattrs,
 	if (!new->se_slots[0])
 		goto out_free;
 
-	for (i = 1; i < numslots; i++) {
+	for (i = 1; i < numslots && i < NFSD_MAX_UNUSED_SLOTS; i++) {
 		new->se_slots[i] = kzalloc(slotsize, GFP_KERNEL | __GFP_NORETRY);
 		if (!new->se_slots[i])
 			break;
@@ -4187,11 +4187,6 @@ nfsd4_sequence(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 	slot = session->se_slots[seq->slotid];
 	dprintk("%s: slotid %d\n", __func__, seq->slotid);
 
-	/* We do not negotiate the number of slots yet, so set the
-	 * maxslots to the session maxreqs which is used to encode
-	 * sr_highest_slotid and the sr_target_slot id to maxslots */
-	seq->maxslots = session->se_fchannel.maxreqs;
-
 	trace_nfsd_slot_seqid_sequence(clp, seq, slot);
 	status = check_slot_seqid(seq->seqid, slot->sl_seqid,
 					slot->sl_flags & NFSD4_SLOT_INUSE);
@@ -4241,6 +4236,21 @@ nfsd4_sequence(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 	cstate->session = session;
 	cstate->clp = clp;
 
+	/*
+	 * If the client ever uses the highest available slot,
+	 * gently try to allocate another one.
+	 */
+	if (seq->slotid == session->se_fchannel.maxreqs - 1 &&
+	    session->se_fchannel.maxreqs < NFSD_MAX_SLOTS_PER_SESSION) {
+		int s = session->se_fchannel.maxreqs;
+
+		session->se_slots[s] = kzalloc(slot_bytes(&session->se_fchannel),
+					       GFP_NOWAIT);
+		if (session->se_slots[s])
+			session->se_fchannel.maxreqs += 1;
+	}
+	seq->maxslots = session->se_fchannel.maxreqs;
+
 out:
 	switch (clp->cl_cb_state) {
 	case NFSD4_CB_DOWN:
diff --git a/fs/nfsd/state.h b/fs/nfsd/state.h
index c052e9eea81b..012b68a0bafa 100644
--- a/fs/nfsd/state.h
+++ b/fs/nfsd/state.h
@@ -215,6 +215,8 @@ static inline struct nfs4_delegation *delegstateid(struct nfs4_stid *s)
 
 /* Maximum number of slots per session. 160 is useful for long haul TCP */
 #define NFSD_MAX_SLOTS_PER_SESSION     160
+/* Maximum number of slots per session that are allocated by unused */
+#define NFSD_MAX_UNUSED_SLOTS		6
 /* Maximum  session per slot cache size */
 #define NFSD_SLOT_CACHE_SIZE		2048
 /* Maximum number of NFSD_SLOT_CACHE_SIZE slots per session */
-- 
2.47.0



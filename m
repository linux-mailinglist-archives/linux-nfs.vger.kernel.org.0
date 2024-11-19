Return-Path: <linux-nfs+bounces-8101-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AE32C9D1CCA
	for <lists+linux-nfs@lfdr.de>; Tue, 19 Nov 2024 01:50:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6EEB9282181
	for <lists+linux-nfs@lfdr.de>; Tue, 19 Nov 2024 00:50:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09FF58825;
	Tue, 19 Nov 2024 00:50:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="1qhYN/AL";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="jj4OBlzn";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="1qhYN/AL";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="jj4OBlzn"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51D781BC2A
	for <linux-nfs@vger.kernel.org>; Tue, 19 Nov 2024 00:50:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731977410; cv=none; b=D3C9qirPoTEFp+Rb5mE3Rb+yYYPemOcOqDZahL405WB/zqPJTvAU1beZqkA44sfo4vuHw58bOR5wkjkYpxChT0HGn4q3RBSLMaAjx6q7JOtvUYlGqdRjiL5wPHu7De4Zf1nwGiLv9tzcHdXDTgOWFSJMtcxtZ7xSvGV/s5zeJHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731977410; c=relaxed/simple;
	bh=RJteXuvL0W5dfWk03EbYTanEqmBGaxiMqvMNBe8I7jc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jhuRO4LiEiww6r8QCktWNq72KUwKoHpa/Lj2vi8CbIHjU/ysqb4HfmRgOiM+UWzJWS6/mzvxBiDT2vW8k8s27xCB6EiAeSHb6veA+Zs8JrdwgCi4rePd7CYQVWWEc6f5qwUhzlNkhMmPlv81HHYJkmGUF8PnSDJDrFXybcv2pjM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=1qhYN/AL; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=jj4OBlzn; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=1qhYN/AL; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=jj4OBlzn; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id AA75D218B5;
	Tue, 19 Nov 2024 00:50:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1731977407; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HNPpi4BWqN0rgNRytN6u3NrSLAfARCynp6N0siX2U/s=;
	b=1qhYN/AL2jWqLFexjDtVTwiRdGUh1r+QrvKdk7GAM0V+B3i4weyefGaqvYfWZXOYnmJPVI
	v4EJfCk8lZ1Tdqy+FkJKz8m8u2WczqfQugUxYCzUGsrtwWvCNzETzy84CBxIqVx26yF73Z
	fzrfCJuJBlXa2hdC6vXysB37iOYAcl8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1731977407;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HNPpi4BWqN0rgNRytN6u3NrSLAfARCynp6N0siX2U/s=;
	b=jj4OBlznD3vBw+qCLo2yjJarLy0+K4GTJeji4hbODK/eYRC84LOTarcv1FVCAlje/ow05V
	kFabzn2tHu/eDeCA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1731977407; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HNPpi4BWqN0rgNRytN6u3NrSLAfARCynp6N0siX2U/s=;
	b=1qhYN/AL2jWqLFexjDtVTwiRdGUh1r+QrvKdk7GAM0V+B3i4weyefGaqvYfWZXOYnmJPVI
	v4EJfCk8lZ1Tdqy+FkJKz8m8u2WczqfQugUxYCzUGsrtwWvCNzETzy84CBxIqVx26yF73Z
	fzrfCJuJBlXa2hdC6vXysB37iOYAcl8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1731977407;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HNPpi4BWqN0rgNRytN6u3NrSLAfARCynp6N0siX2U/s=;
	b=jj4OBlznD3vBw+qCLo2yjJarLy0+K4GTJeji4hbODK/eYRC84LOTarcv1FVCAlje/ow05V
	kFabzn2tHu/eDeCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A8C321376E;
	Tue, 19 Nov 2024 00:50:05 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id ZFJRGL3gO2e5JgAAD6G6ig
	(envelope-from <neilb@suse.de>); Tue, 19 Nov 2024 00:50:05 +0000
From: NeilBrown <neilb@suse.de>
To: Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>
Cc: linux-nfs@vger.kernel.org,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <Dai.Ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>
Subject: [PATCH 4/6] nfsd: allocate new session-based DRC slots on demand.
Date: Tue, 19 Nov 2024 11:41:31 +1100
Message-ID: <20241119004928.3245873-5-neilb@suse.de>
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

If a client ever uses the highest available slot for a given session,
attempt to allocate another slot so there is room for the client to use
more slots if wanted.  GFP_NOWAIT is used so if there is not plenty of
free memory, failure is expected - which is what we want.  It also
allows the allocation while holding a spinlock.

We would expect to stablise with one more slot available than the client
actually uses.

Now that we grow the slot table on demand we can start with a smaller
allocation.  Define NFSD_MAX_INITIAL_SLOTS and allocate at most that
many when session is created.

Signed-off-by: NeilBrown <neilb@suse.de>
---
 fs/nfsd/nfs4state.c | 32 ++++++++++++++++++++++++++------
 fs/nfsd/state.h     |  2 ++
 2 files changed, 28 insertions(+), 6 deletions(-)

diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index 31ff9f92a895..fb522165b376 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -1956,7 +1956,7 @@ static struct nfsd4_session *alloc_session(struct nfsd4_channel_attrs *fattrs,
 	if (!slot || xa_is_err(xa_store(&new->se_slots, 0, slot, GFP_KERNEL)))
 		goto out_free;
 
-	for (i = 1; i < numslots; i++) {
+	for (i = 1; i < numslots && i < NFSD_MAX_INITIAL_SLOTS; i++) {
 		slot = kzalloc(slotsize, GFP_KERNEL | __GFP_NORETRY);
 		if (!slot)
 			break;
@@ -4248,11 +4248,6 @@ nfsd4_sequence(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
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
@@ -4302,6 +4297,31 @@ nfsd4_sequence(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
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
+		/*
+		 * GFP_NOWAIT is a low-priority non-blocking allocation
+		 * which can be used under client_lock and only succeeds
+		 * if there is plenty of memory.
+		 * Use GFP_ATOMIC which is higher priority for xa_store()
+		 * so we are less likely to waste the effort of the first
+		 * allocation.
+		 */
+		slot = kzalloc(slot_bytes(&session->se_fchannel), GFP_NOWAIT);
+		if (slot && !xa_is_err(xa_store(&session->se_slots, s, slot,
+						GFP_ATOMIC)))
+			session->se_fchannel.maxreqs += 1;
+		else
+			kfree(slot);
+	}
+	seq->maxslots = session->se_fchannel.maxreqs;
+
 out:
 	switch (clp->cl_cb_state) {
 	case NFSD4_CB_DOWN:
diff --git a/fs/nfsd/state.h b/fs/nfsd/state.h
index e97626916a68..a14a823670e9 100644
--- a/fs/nfsd/state.h
+++ b/fs/nfsd/state.h
@@ -249,6 +249,8 @@ static inline struct nfs4_delegation *delegstateid(struct nfs4_stid *s)
  * get good throughput on high-latency servers.
  */
 #define NFSD_MAX_SLOTS_PER_SESSION	2048
+/* Maximum number of slots per session to allocate for CREATE_SESSION */
+#define NFSD_MAX_INITIAL_SLOTS		32
 /* Maximum  session per slot cache size */
 #define NFSD_SLOT_CACHE_SIZE		2048
 /* Maximum number of NFSD_SLOT_CACHE_SIZE slots per session */
-- 
2.47.0



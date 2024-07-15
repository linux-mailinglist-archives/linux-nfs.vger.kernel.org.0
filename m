Return-Path: <linux-nfs+bounces-4902-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A876930F1F
	for <lists+linux-nfs@lfdr.de>; Mon, 15 Jul 2024 09:49:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3F987281354
	for <lists+linux-nfs@lfdr.de>; Mon, 15 Jul 2024 07:48:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E3C5171E60;
	Mon, 15 Jul 2024 07:48:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="mABKd4s3";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="Af5aFq7N";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="mABKd4s3";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="Af5aFq7N"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40A376AB8
	for <linux-nfs@vger.kernel.org>; Mon, 15 Jul 2024 07:48:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721029736; cv=none; b=nZAAlIk83h2ln6PhKP+a0nI0Yx/7Cz2gLSgllX1D5viCz6l1GMKIBr4bYs0i3hCdhRNGYvB2i6uD9i8rI13p8w64cgLX2ykAPEzygmo9GxPtgjb7huFle8ETYSKEWJ8HW/MZFRyywlpD6FH+qR6qXftY5BRuYoSULOdVN7Gq1Gg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721029736; c=relaxed/simple;
	bh=TNwG1A1Ug7JYDJcYLHP0dBi6biuInT0z27a5DVDSYfA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IoKLppezoJFrSvSQoJQvSFz+IduBTuRWhKGc/Z2Lpj6CzDLQp7GxoAv1JGJU71XJy8ozR2+C4uNeqZ3XphcOWruOA7vk/oG+XvK92xbjbNlVTEiRGSc65yKNTRedHuMCy3R/2Gf0iFiHUfZVwMtHVK6Csz9QLEg+ZTp1ubflLrc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=mABKd4s3; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=Af5aFq7N; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=mABKd4s3; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=Af5aFq7N; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 7B1911F7FA;
	Mon, 15 Jul 2024 07:48:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1721029733; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3Cxwmq0yD9JnyqpYfnRRM5fh611Hdmw98vPH3b0+NyM=;
	b=mABKd4s3QLnjuZO/HrrCRQENG6sUDzJOL/zCauUhuGFVvPv/2259HpR3pZ+OS0U2j65Lx8
	N1k0hmQ+qAANVzl41MvGmDgVb8ne39LuSN5eIoYzP5FD2fLEZRV0SUa3mlFZ1hJWSerl+N
	rLqDi/2aH+zVKyHhw9DCOxxpkr3/17s=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1721029733;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3Cxwmq0yD9JnyqpYfnRRM5fh611Hdmw98vPH3b0+NyM=;
	b=Af5aFq7No3r/GHieASK8YG4T4VJ3T6sVd4E1s3+/hpl+i+CiE3ko8pO4xikVYiRR6DESap
	8YjsDn+naJocT/BQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1721029733; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3Cxwmq0yD9JnyqpYfnRRM5fh611Hdmw98vPH3b0+NyM=;
	b=mABKd4s3QLnjuZO/HrrCRQENG6sUDzJOL/zCauUhuGFVvPv/2259HpR3pZ+OS0U2j65Lx8
	N1k0hmQ+qAANVzl41MvGmDgVb8ne39LuSN5eIoYzP5FD2fLEZRV0SUa3mlFZ1hJWSerl+N
	rLqDi/2aH+zVKyHhw9DCOxxpkr3/17s=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1721029733;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3Cxwmq0yD9JnyqpYfnRRM5fh611Hdmw98vPH3b0+NyM=;
	b=Af5aFq7No3r/GHieASK8YG4T4VJ3T6sVd4E1s3+/hpl+i+CiE3ko8pO4xikVYiRR6DESap
	8YjsDn+naJocT/BQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 11E27137EB;
	Mon, 15 Jul 2024 07:48:50 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id lUBsLmLUlGYybgAAD6G6ig
	(envelope-from <neilb@suse.de>); Mon, 15 Jul 2024 07:48:50 +0000
From: NeilBrown <neilb@suse.de>
To: Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>
Cc: linux-nfs@vger.kernel.org,
	Olga Kornievskaia <kolga@netapp.com>,
	Dai Ngo <Dai.Ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>,
	Steve Dickson <steved@redhat.com>
Subject: [PATCH 10/14] nfs: dynamically adjust per-client DRC slot limits.
Date: Mon, 15 Jul 2024 17:14:23 +1000
Message-ID: <20240715074657.18174-11-neilb@suse.de>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240715074657.18174-1-neilb@suse.de>
References: <20240715074657.18174-1-neilb@suse.de>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Flag: NO
X-Spam-Score: 1.20
X-Spamd-Result: default: False [1.20 / 50.00];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_EQ_ENVFROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:email];
	RCVD_COUNT_TWO(0.00)[2];
	RCVD_TLS_ALL(0.00)[]
X-Spam-Level: *

Currently per-client DRC slot limits (for v4.1+) are calculated when the
client connects and are left unchanged.  So earlier clients can get a
larger share when memory is tight.

The heuristic for choosing a number includes the number of configured
server threads.  This is problematic for 2 reasons.
1/ sv_nrthreads is different in different net namespaces, but the
   memory allocation is global across all namespaces.  So different
   namespaces get treated differently without good reason.
2/ a future patch will auto-configure number of threads based on
   load so that there is no need to preconfigure a number.  This will
   make the current heuristic even more arbitrary.

NFSv4.1 allows the number of slots to be varied dynamically - in the
reply to each SEQUENCE op.  With this patch we provide a provisional
upper limit in the EXCHANGE_ID reply which might end up being too big,
and adjust it with each SEQUENCE reply.

The goal for when memory is tight is to allow each client to have a
similar number of slots.  So clients that ask for larger slots get more
memory.   This may not be ideal.  It could be changed later.

So we track the sum of the slot sizes of all active clients, and share
memory out based on the ratio of the slot size for a given client with
the total slot size.  We never allow more in a SEQUENCE reply than we
did in the EXCHANGE_ID reply.

Signed-off-by: NeilBrown <neilb@suse.de>
---
 fs/nfsd/nfs4state.c | 81 ++++++++++++++++++++++++---------------------
 fs/nfsd/nfs4xdr.c   |  2 +-
 fs/nfsd/nfsd.h      |  2 +-
 fs/nfsd/nfssvc.c    |  7 ++--
 fs/nfsd/state.h     |  2 +-
 fs/nfsd/xdr4.h      |  2 --
 6 files changed, 52 insertions(+), 44 deletions(-)

diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index 88936f3189e1..4dd619e6010f 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -1909,44 +1909,26 @@ static inline u32 slot_bytes(struct nfsd4_channel_attrs *ca)
 }
 
 /*
- * XXX: If we run out of reserved DRC memory we could (up to a point)
- * re-negotiate active sessions and reduce their slot usage to make
- * room for new connections. For now we just fail the create session.
+ * When a client connects it gets a max_requests number that would allow
+ * it to use 1/8 of the memory we think can reasonably be used for the DRC.
+ * Later in response to SEQUENCE operations we further limit that when there
+ * are more than 8 concurrent clients.
  */
-static u32 nfsd4_get_drc_mem(struct nfsd4_channel_attrs *ca, struct nfsd_net *nn)
+static u32 nfsd4_get_drc_mem(struct nfsd4_channel_attrs *ca)
 {
 	u32 slotsize = slot_bytes(ca);
 	u32 num = ca->maxreqs;
-	unsigned long avail, total_avail;
-	unsigned int scale_factor;
+	unsigned long avail;
 
 	spin_lock(&nfsd_drc_lock);
-	if (nfsd_drc_max_mem > nfsd_drc_mem_used)
-		total_avail = nfsd_drc_max_mem - nfsd_drc_mem_used;
-	else
-		/* We have handed out more space than we chose in
-		 * set_max_drc() to allow.  That isn't really a
-		 * problem as long as that doesn't make us think we
-		 * have lots more due to integer overflow.
-		 */
-		total_avail = 0;
-	avail = min((unsigned long)NFSD_MAX_MEM_PER_SESSION, total_avail);
-	/*
-	 * Never use more than a fraction of the remaining memory,
-	 * unless it's the only way to give this client a slot.
-	 * The chosen fraction is either 1/8 or 1/number of threads,
-	 * whichever is smaller.  This ensures there are adequate
-	 * slots to support multiple clients per thread.
-	 * Give the client one slot even if that would require
-	 * over-allocation--it is better than failure.
-	 */
-	scale_factor = max_t(unsigned int, 8, nn->nfsd_serv->sv_nrthreads);
 
-	avail = clamp_t(unsigned long, avail, slotsize,
-			total_avail/scale_factor);
-	num = min_t(int, num, avail / slotsize);
-	num = max_t(int, num, 1);
-	nfsd_drc_mem_used += num * slotsize;
+	avail = min(NFSD_MAX_MEM_PER_SESSION,
+		    nfsd_drc_max_mem / 8);
+
+	num = clamp_t(int, num, 1, avail / slotsize);
+
+	nfsd_drc_slotsize_sum += slotsize;
+
 	spin_unlock(&nfsd_drc_lock);
 
 	return num;
@@ -1957,10 +1939,33 @@ static void nfsd4_put_drc_mem(struct nfsd4_channel_attrs *ca)
 	int slotsize = slot_bytes(ca);
 
 	spin_lock(&nfsd_drc_lock);
-	nfsd_drc_mem_used -= slotsize * ca->maxreqs;
+	nfsd_drc_slotsize_sum -= slotsize;
 	spin_unlock(&nfsd_drc_lock);
 }
 
+/*
+ * Report the number of slots that we would like the client to limit
+ * itself to.  When the number of clients is large, we start sharing
+ * memory so all clients get the same number of slots.
+ */
+static unsigned int nfsd4_get_drc_slots(struct nfsd4_session *session)
+{
+	u32 slotsize = slot_bytes(&session->se_fchannel);
+	unsigned long avail;
+	unsigned long slotsize_sum = READ_ONCE(nfsd_drc_slotsize_sum);
+
+	if (slotsize_sum < slotsize)
+		slotsize_sum = slotsize;
+
+	/* Find our share of avail mem across all active clients,
+	 * then limit to 1/8 of total, and configured max
+	 */
+	avail = min3(nfsd_drc_max_mem * slotsize / nfsd_drc_slotsize_sum,
+		     nfsd_drc_max_mem / 8,
+		     NFSD_MAX_MEM_PER_SESSION);
+	return max3(1UL, avail / slotsize, session->se_fchannel.maxreqs);
+}
+
 static struct nfsd4_session *alloc_session(struct nfsd4_channel_attrs *fattrs,
 					   struct nfsd4_channel_attrs *battrs)
 {
@@ -3726,7 +3731,7 @@ static __be32 check_forechannel_attrs(struct nfsd4_channel_attrs *ca, struct nfs
 	 * Note that we always allow at least one slot, because our
 	 * accounting is soft and provides no guarantees either way.
 	 */
-	ca->maxreqs = nfsd4_get_drc_mem(ca, nn);
+	ca->maxreqs = nfsd4_get_drc_mem(ca);
 
 	return nfs_ok;
 }
@@ -4220,10 +4225,12 @@ nfsd4_sequence(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 	slot = session->se_slots[seq->slotid];
 	dprintk("%s: slotid %d\n", __func__, seq->slotid);
 
-	/* We do not negotiate the number of slots yet, so set the
-	 * maxslots to the session maxreqs which is used to encode
-	 * sr_highest_slotid and the sr_target_slot id to maxslots */
-	seq->maxslots = session->se_fchannel.maxreqs;
+	/* Negotiate number of slots: set the target, and use the
+	 * same for max as long as it doesn't decrease the max
+	 * (that isn't allowed).
+	 */
+	seq->target_maxslots = nfsd4_get_drc_slots(session);
+	seq->maxslots = max(seq->maxslots, seq->target_maxslots);
 
 	trace_nfsd_slot_seqid_sequence(clp, seq, slot);
 	status = check_slot_seqid(seq->seqid, slot->sl_seqid,
diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
index 42b41d55d4ed..a65812fcdae0 100644
--- a/fs/nfsd/nfs4xdr.c
+++ b/fs/nfsd/nfs4xdr.c
@@ -4961,7 +4961,7 @@ nfsd4_encode_sequence(struct nfsd4_compoundres *resp, __be32 nfserr,
 	if (nfserr != nfs_ok)
 		return nfserr;
 	/* sr_target_highest_slotid */
-	nfserr = nfsd4_encode_slotid4(xdr, seq->maxslots - 1);
+	nfserr = nfsd4_encode_slotid4(xdr, seq->target_maxslots - 1);
 	if (nfserr != nfs_ok)
 		return nfserr;
 	/* sr_status_flags */
diff --git a/fs/nfsd/nfsd.h b/fs/nfsd/nfsd.h
index 369c3b3ce53e..e4c643255dc9 100644
--- a/fs/nfsd/nfsd.h
+++ b/fs/nfsd/nfsd.h
@@ -90,7 +90,7 @@ extern const struct svc_version	nfsd_version2, nfsd_version3, nfsd_version4;
 extern struct mutex		nfsd_mutex;
 extern spinlock_t		nfsd_drc_lock;
 extern unsigned long		nfsd_drc_max_mem;
-extern unsigned long		nfsd_drc_mem_used;
+extern unsigned long		nfsd_drc_slotsize_sum;
 extern atomic_t			nfsd_th_cnt;		/* number of available threads */
 
 extern const struct seq_operations nfs_exports_op;
diff --git a/fs/nfsd/nfssvc.c b/fs/nfsd/nfssvc.c
index f5de04a63c6f..b005b2e2e6ad 100644
--- a/fs/nfsd/nfssvc.c
+++ b/fs/nfsd/nfssvc.c
@@ -78,7 +78,7 @@ DEFINE_MUTEX(nfsd_mutex);
  */
 DEFINE_SPINLOCK(nfsd_drc_lock);
 unsigned long	nfsd_drc_max_mem;
-unsigned long	nfsd_drc_mem_used;
+unsigned long	nfsd_drc_slotsize_sum;
 
 #if defined(CONFIG_NFSD_V2_ACL) || defined(CONFIG_NFSD_V3_ACL)
 static const struct svc_version *nfsd_acl_version[] = {
@@ -532,10 +532,13 @@ void nfsd_reset_versions(struct nfsd_net *nn)
  */
 static void set_max_drc(void)
 {
+	if (nfsd_drc_max_mem)
+		return;
+
 	#define NFSD_DRC_SIZE_SHIFT	7
 	nfsd_drc_max_mem = (nr_free_buffer_pages()
 					>> NFSD_DRC_SIZE_SHIFT) * PAGE_SIZE;
-	nfsd_drc_mem_used = 0;
+	nfsd_drc_slotsize_sum = 0;
 	dprintk("%s nfsd_drc_max_mem %lu \n", __func__, nfsd_drc_max_mem);
 }
 
diff --git a/fs/nfsd/state.h b/fs/nfsd/state.h
index ffc217099d19..2b1d619bc00f 100644
--- a/fs/nfsd/state.h
+++ b/fs/nfsd/state.h
@@ -213,7 +213,7 @@ static inline struct nfs4_delegation *delegstateid(struct nfs4_stid *s)
 /* Maximum number of slots per session. 160 is useful for long haul TCP */
 #define NFSD_MAX_SLOTS_PER_SESSION     160
 /* Maximum  session per slot cache size */
-#define NFSD_SLOT_CACHE_SIZE		2048
+#define NFSD_SLOT_CACHE_SIZE		2048UL
 /* Maximum number of NFSD_SLOT_CACHE_SIZE slots per session */
 #define NFSD_CACHE_SIZE_SLOTS_PER_SESSION	32
 #define NFSD_MAX_MEM_PER_SESSION  \
diff --git a/fs/nfsd/xdr4.h b/fs/nfsd/xdr4.h
index fbdd42cde1fa..1c78a09bf63f 100644
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
2.44.0



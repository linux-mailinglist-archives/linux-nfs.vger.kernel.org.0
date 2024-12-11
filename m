Return-Path: <linux-nfs+bounces-8525-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C0CA9ED8FF
	for <lists+linux-nfs@lfdr.de>; Wed, 11 Dec 2024 22:49:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 30BF6164589
	for <lists+linux-nfs@lfdr.de>; Wed, 11 Dec 2024 21:49:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE6D31D8DFE;
	Wed, 11 Dec 2024 21:49:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="C5vXB9j1";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="l05jXPC1";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="C5vXB9j1";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="l05jXPC1"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA3FB1D31B5
	for <linux-nfs@vger.kernel.org>; Wed, 11 Dec 2024 21:49:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733953757; cv=none; b=FJetsE9pdlhb9Tgh24IQV6EXqeRn+IT5c4DhMBevJOIdFKrg/jaYNyQMRQsZF+XT9czn1jZml7vbQtGAUNF5OaG6eRgHfuVhi7ZrqHqvrNKnD+ZWGdfSvDjr0owv/gVFzQ25Lc86o2/H5kIONGNU9a5u1ljnElGs+P8nXwAL0Lg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733953757; c=relaxed/simple;
	bh=rHhZn1/o9zzwC16Fuq+ADWY2o/ColjmkttEe2uBM02c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=B6X7vPbXvKnapUAy2tJpIsDN7OOu/6u0+AugLd3zA0Fp51TkB6FrS9TQC2AIApXR0t+k2U5yA2uLG5BMMsuHYGxlc0xE+SvyfBl8w1Ezn4+D6ZfGGlDo57HCeFQBQbicc53eDE6tcF0eEyo91Sc3LMhuSPvgoZNa3HMKgvJ3Ad8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=C5vXB9j1; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=l05jXPC1; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=C5vXB9j1; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=l05jXPC1; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 070D221182;
	Wed, 11 Dec 2024 21:49:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1733953753; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1DrB9DTJzAQ7ZwflGwvGIrh70CDO/4BF6ezF2f21BbY=;
	b=C5vXB9j1J6cC6CLxmwWwCdh1D9mqJITVCaf5KZp5Y5EStM4horCgwFrfvsGJvjzAxh3Q1N
	bbXva+ABSnONdor7n8E1naGBdocSBWjh53vAlAwUPYYhHcYd+nfgIQxsc5z9VhL6dTGY78
	fBFHnXmlK3nByKfAXelNsvxOQgr3OVk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1733953753;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1DrB9DTJzAQ7ZwflGwvGIrh70CDO/4BF6ezF2f21BbY=;
	b=l05jXPC1wwvz3p3ix6R2NvLXYW8yeROeHFgtERbdtxni74l22matesaBcV8GjyqnlUhiyO
	vAevHrisCsogtvBg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1733953753; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1DrB9DTJzAQ7ZwflGwvGIrh70CDO/4BF6ezF2f21BbY=;
	b=C5vXB9j1J6cC6CLxmwWwCdh1D9mqJITVCaf5KZp5Y5EStM4horCgwFrfvsGJvjzAxh3Q1N
	bbXva+ABSnONdor7n8E1naGBdocSBWjh53vAlAwUPYYhHcYd+nfgIQxsc5z9VhL6dTGY78
	fBFHnXmlK3nByKfAXelNsvxOQgr3OVk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1733953753;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1DrB9DTJzAQ7ZwflGwvGIrh70CDO/4BF6ezF2f21BbY=;
	b=l05jXPC1wwvz3p3ix6R2NvLXYW8yeROeHFgtERbdtxni74l22matesaBcV8GjyqnlUhiyO
	vAevHrisCsogtvBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E23C31344A;
	Wed, 11 Dec 2024 21:49:10 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 0+KJJdYIWmfGMgAAD6G6ig
	(envelope-from <neilb@suse.de>); Wed, 11 Dec 2024 21:49:10 +0000
From: NeilBrown <neilb@suse.de>
To: Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>
Cc: linux-nfs@vger.kernel.org,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <Dai.Ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>
Subject: [PATCH 2/6] nfsd: remove artificial limits on the session-based DRC
Date: Thu, 12 Dec 2024 08:47:05 +1100
Message-ID: <20241211214842.2022679-3-neilb@suse.de>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241211214842.2022679-1-neilb@suse.de>
References: <20241211214842.2022679-1-neilb@suse.de>
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

Rather than guessing how much space it might be safe to use for the DRC,
simply try allocating slots and be prepared to accept failure.

The first slot for each session is allocated with GFP_KERNEL which is
unlikely to fail.  Subsequent slots are allocated with the addition of
__GFP_NORETRY which is expected to fail if there isn't much free memory.

This is probably too aggressive but clears the way for adding a
shrinker interface to free extra slots when memory is tight.

Reviewed-by: Jeff Layton <jlayton@kernel.org>
Signed-off-by: NeilBrown <neilb@suse.de>
---
 fs/nfsd/nfs4state.c | 94 ++++++++-------------------------------------
 fs/nfsd/nfsd.h      |  3 --
 fs/nfsd/nfssvc.c    | 32 ---------------
 3 files changed, 16 insertions(+), 113 deletions(-)

diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index aa4f1293d4d3..808cb0d897d5 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -1938,65 +1938,13 @@ static inline u32 slot_bytes(struct nfsd4_channel_attrs *ca)
 	return size + sizeof(struct nfsd4_slot);
 }
 
-/*
- * XXX: If we run out of reserved DRC memory we could (up to a point)
- * re-negotiate active sessions and reduce their slot usage to make
- * room for new connections. For now we just fail the create session.
- */
-static u32 nfsd4_get_drc_mem(struct nfsd4_channel_attrs *ca, struct nfsd_net *nn)
-{
-	u32 slotsize = slot_bytes(ca);
-	u32 num = ca->maxreqs;
-	unsigned long avail, total_avail;
-	unsigned int scale_factor;
-
-	spin_lock(&nfsd_drc_lock);
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
-
-	avail = clamp_t(unsigned long, avail, slotsize,
-			total_avail/scale_factor);
-	num = min_t(int, num, avail / slotsize);
-	num = max_t(int, num, 1);
-	nfsd_drc_mem_used += num * slotsize;
-	spin_unlock(&nfsd_drc_lock);
-
-	return num;
-}
-
-static void nfsd4_put_drc_mem(struct nfsd4_channel_attrs *ca)
-{
-	int slotsize = slot_bytes(ca);
-
-	spin_lock(&nfsd_drc_lock);
-	nfsd_drc_mem_used -= slotsize * ca->maxreqs;
-	spin_unlock(&nfsd_drc_lock);
-}
-
 static struct nfsd4_session *alloc_session(struct nfsd4_channel_attrs *fattrs,
 					   struct nfsd4_channel_attrs *battrs)
 {
 	int numslots = fattrs->maxreqs;
 	int slotsize = slot_bytes(fattrs);
 	struct nfsd4_session *new;
+	struct nfsd4_slot *slot;
 	int i;
 
 	new = kzalloc(sizeof(*new), GFP_KERNEL);
@@ -2004,17 +1952,21 @@ static struct nfsd4_session *alloc_session(struct nfsd4_channel_attrs *fattrs,
 		return NULL;
 	xa_init(&new->se_slots);
 	/* allocate each struct nfsd4_slot and data cache in one piece */
-	for (i = 0; i < numslots; i++) {
-		struct nfsd4_slot *slot;
-		slot = kzalloc(slotsize, GFP_KERNEL);
+	slot = kzalloc(slotsize, GFP_KERNEL);
+	if (!slot || xa_is_err(xa_store(&new->se_slots, 0, slot, GFP_KERNEL)))
+		goto out_free;
+
+	for (i = 1; i < numslots; i++) {
+		const gfp_t gfp = GFP_KERNEL | __GFP_NORETRY | __GFP_NOWARN;
+		slot = kzalloc(slotsize, gfp);
 		if (!slot)
-			goto out_free;
-		if (xa_is_err(xa_store(&new->se_slots, i, slot, GFP_KERNEL))) {
+			break;
+		if (xa_is_err(xa_store(&new->se_slots, i, slot, gfp))) {
 			kfree(slot);
-			goto out_free;
+			break;
 		}
 	}
-
+	fattrs->maxreqs = i;
 	memcpy(&new->se_fchannel, fattrs, sizeof(struct nfsd4_channel_attrs));
 	new->se_cb_slot_avail = ~0U;
 	new->se_cb_highest_slot = min(battrs->maxreqs - 1,
@@ -2022,8 +1974,7 @@ static struct nfsd4_session *alloc_session(struct nfsd4_channel_attrs *fattrs,
 	spin_lock_init(&new->se_lock);
 	return new;
 out_free:
-	while (i--)
-		kfree(xa_load(&new->se_slots, i));
+	kfree(slot);
 	xa_destroy(&new->se_slots);
 	kfree(new);
 	return NULL;
@@ -2138,7 +2089,6 @@ static void __free_session(struct nfsd4_session *ses)
 static void free_session(struct nfsd4_session *ses)
 {
 	nfsd4_del_conns(ses);
-	nfsd4_put_drc_mem(&ses->se_fchannel);
 	__free_session(ses);
 }
 
@@ -3786,17 +3736,6 @@ static __be32 check_forechannel_attrs(struct nfsd4_channel_attrs *ca, struct nfs
 	ca->maxresp_cached = min_t(u32, ca->maxresp_cached,
 			NFSD_SLOT_CACHE_SIZE + NFSD_MIN_HDR_SEQ_SZ);
 	ca->maxreqs = min_t(u32, ca->maxreqs, NFSD_MAX_SLOTS_PER_SESSION);
-	/*
-	 * Note decreasing slot size below client's request may make it
-	 * difficult for client to function correctly, whereas
-	 * decreasing the number of slots will (just?) affect
-	 * performance.  When short on memory we therefore prefer to
-	 * decrease number of slots instead of their size.  Clients that
-	 * request larger slots than they need will get poor results:
-	 * Note that we always allow at least one slot, because our
-	 * accounting is soft and provides no guarantees either way.
-	 */
-	ca->maxreqs = nfsd4_get_drc_mem(ca, nn);
 
 	return nfs_ok;
 }
@@ -3874,11 +3813,11 @@ nfsd4_create_session(struct svc_rqst *rqstp,
 		return status;
 	status = check_backchannel_attrs(&cr_ses->back_channel);
 	if (status)
-		goto out_release_drc_mem;
+		goto out_err;
 	status = nfserr_jukebox;
 	new = alloc_session(&cr_ses->fore_channel, &cr_ses->back_channel);
 	if (!new)
-		goto out_release_drc_mem;
+		goto out_err;
 	conn = alloc_conn_from_crses(rqstp, cr_ses);
 	if (!conn)
 		goto out_free_session;
@@ -3987,8 +3926,7 @@ nfsd4_create_session(struct svc_rqst *rqstp,
 	free_conn(conn);
 out_free_session:
 	__free_session(new);
-out_release_drc_mem:
-	nfsd4_put_drc_mem(&cr_ses->fore_channel);
+out_err:
 	return status;
 }
 
diff --git a/fs/nfsd/nfsd.h b/fs/nfsd/nfsd.h
index 4b56ba1e8e48..3eb21e63b921 100644
--- a/fs/nfsd/nfsd.h
+++ b/fs/nfsd/nfsd.h
@@ -88,9 +88,6 @@ struct nfsd_genl_rqstp {
 extern struct svc_program	nfsd_programs[];
 extern const struct svc_version	nfsd_version2, nfsd_version3, nfsd_version4;
 extern struct mutex		nfsd_mutex;
-extern spinlock_t		nfsd_drc_lock;
-extern unsigned long		nfsd_drc_max_mem;
-extern unsigned long		nfsd_drc_mem_used;
 extern atomic_t			nfsd_th_cnt;		/* number of available threads */
 
 extern const struct seq_operations nfs_exports_op;
diff --git a/fs/nfsd/nfssvc.c b/fs/nfsd/nfssvc.c
index 49e2f32102ab..3dbaefc96608 100644
--- a/fs/nfsd/nfssvc.c
+++ b/fs/nfsd/nfssvc.c
@@ -70,16 +70,6 @@ static __be32			nfsd_init_request(struct svc_rqst *,
  */
 DEFINE_MUTEX(nfsd_mutex);
 
-/*
- * nfsd_drc_lock protects nfsd_drc_max_pages and nfsd_drc_pages_used.
- * nfsd_drc_max_pages limits the total amount of memory available for
- * version 4.1 DRC caches.
- * nfsd_drc_pages_used tracks the current version 4.1 DRC memory usage.
- */
-DEFINE_SPINLOCK(nfsd_drc_lock);
-unsigned long	nfsd_drc_max_mem;
-unsigned long	nfsd_drc_mem_used;
-
 #if IS_ENABLED(CONFIG_NFS_LOCALIO)
 static const struct svc_version *localio_versions[] = {
 	[1] = &localio_version1,
@@ -575,27 +565,6 @@ void nfsd_reset_versions(struct nfsd_net *nn)
 		}
 }
 
-/*
- * Each session guarantees a negotiated per slot memory cache for replies
- * which in turn consumes memory beyond the v2/v3/v4.0 server. A dedicated
- * NFSv4.1 server might want to use more memory for a DRC than a machine
- * with mutiple services.
- *
- * Impose a hard limit on the number of pages for the DRC which varies
- * according to the machines free pages. This is of course only a default.
- *
- * For now this is a #defined shift which could be under admin control
- * in the future.
- */
-static void set_max_drc(void)
-{
-	#define NFSD_DRC_SIZE_SHIFT	7
-	nfsd_drc_max_mem = (nr_free_buffer_pages()
-					>> NFSD_DRC_SIZE_SHIFT) * PAGE_SIZE;
-	nfsd_drc_mem_used = 0;
-	dprintk("%s nfsd_drc_max_mem %lu \n", __func__, nfsd_drc_max_mem);
-}
-
 static int nfsd_get_default_max_blksize(void)
 {
 	struct sysinfo i;
@@ -678,7 +647,6 @@ int nfsd_create_serv(struct net *net)
 	nn->nfsd_serv = serv;
 	spin_unlock(&nfsd_notifier_lock);
 
-	set_max_drc();
 	/* check if the notifier is already set */
 	if (atomic_inc_return(&nfsd_notifier_refcount) == 1) {
 		register_inetaddr_notifier(&nfsd_inetaddr_notifier);
-- 
2.47.0



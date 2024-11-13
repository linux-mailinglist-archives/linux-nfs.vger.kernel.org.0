Return-Path: <linux-nfs+bounces-7923-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 05CC09C68E8
	for <lists+linux-nfs@lfdr.de>; Wed, 13 Nov 2024 06:54:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 80E981F23499
	for <lists+linux-nfs@lfdr.de>; Wed, 13 Nov 2024 05:54:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7D2A2309AE;
	Wed, 13 Nov 2024 05:54:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="SwHwtqvt";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="FM0jpPoC";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="of61QU/a";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="RSeVpRv+"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEDEF1632E8
	for <linux-nfs@vger.kernel.org>; Wed, 13 Nov 2024 05:54:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731477245; cv=none; b=iNI3lsnQGAaB3R2827m+Q8q1sNovl/bXtnVEwCIThlWGpfwW4Vf1u+h++LWzKw+sdQLfbWLd2KO4RGbiXLaQV4BC89WE3Oj5uJZKJgRmMKV/FyC/VwCznsLqAwoQtaHRKClCh+qgTuWh9AxP8ZWzBTM+iw5dVJz3BmvIMRIs2eU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731477245; c=relaxed/simple;
	bh=FbjzFYVG8NjR2zInSlmwoUV6vo0MMVBCCcvXpbdSe7g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HarbNqCVe0qRQHbCmAJJyAzlzZxXab1j62hgIo2PRBEDeCXfWY39AaJJ4TQ0pAEhDLdidIOi4WfKAZ6LyO4ukQYZq8LVOIUhL2y52DiH77GnY2kOEJj5dEZLFHFp3JHFXUAY/Cb2lXw7qEUrXbzpJnW6RNsBYlTfihrUf37w0SE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=SwHwtqvt; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=FM0jpPoC; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=of61QU/a; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=RSeVpRv+; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id C9D8E1F365;
	Wed, 13 Nov 2024 05:54:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1731477242; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bSizj0r6GMrBZ02dwSsfSG2SBy80koqTOIQwdMfa7HU=;
	b=SwHwtqvt6442MSepHbbTcAit7MUdHnRpT3JsDyaaUzZiBwJB4O2k+wiKCpyXUYiB8CBWi4
	2GZnBOpIy2RmbWpLOc6mj2cnJj/hQt8MW3aevLsRLg5v5OYG5/eaoOmCELQXChfruAjnF3
	wHa5bXwVFicFrwP7p7B+PSlPHQt1SVA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1731477242;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bSizj0r6GMrBZ02dwSsfSG2SBy80koqTOIQwdMfa7HU=;
	b=FM0jpPoCyE/6+sTEWbx4X1dvlJt8zEaXEOhY7elwHT7vUJZGy2ErTd4/i+ebspX5kvsGy1
	cOnI2lb6Jdf2oZDw==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b="of61QU/a";
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=RSeVpRv+
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1731477241; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bSizj0r6GMrBZ02dwSsfSG2SBy80koqTOIQwdMfa7HU=;
	b=of61QU/aQzXAV/qMFbA/hUjrzU07soAwnmgjX1lvynt+8wLZilNbPG7k4/mAY5/vlnOGzr
	ZQkI9p/qCEW4r4RZOJ115gHFD5HY7HEmFStr7jqJfsbf5jcEwn2XGLh8zv4Mv1tZBOqkXD
	/XOEABh3Qvk7V8GnFJ4KYmgxLfG/Dvo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1731477241;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bSizj0r6GMrBZ02dwSsfSG2SBy80koqTOIQwdMfa7HU=;
	b=RSeVpRv+hRFJoAccb7jScnbOptkqJ6NySERFuCclanI6FLyzwisqs6vTfuUNc05x+kEpTY
	GG5S+jGtt1DUtFCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 66DD713890;
	Wed, 13 Nov 2024 05:53:59 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id DfWsB/c+NGeNfQAAD6G6ig
	(envelope-from <neilb@suse.de>); Wed, 13 Nov 2024 05:53:59 +0000
From: NeilBrown <neilb@suse.de>
To: Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>
Cc: linux-nfs@vger.kernel.org,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <Dai.Ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>
Subject: [PATCH 1/4] nfsd: remove artificial limits on the session-based DRC
Date: Wed, 13 Nov 2024 16:38:34 +1100
Message-ID: <20241113055345.494856-2-neilb@suse.de>
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
X-Rspamd-Queue-Id: C9D8E1F365
X-Spam-Level: 
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.de:dkim,suse.de:mid];
	ASN(0.00)[asn:25478, ipnet:::/0, country:RU];
	ARC_NA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_COUNT_TWO(0.00)[2];
	RCVD_TLS_ALL(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -3.01
X-Spam-Flag: NO

Rather than guessing how much space it might be safe to use for the DRC,
simply try allocating slots and be prepared to accept failure.

The first slot for each session is allocated with GFP_KERNEL which is
unlikely to fail.  Subsequent slots are allocated with the addition of
__GFP_NORETRY which is expected to fail if there isn't much free memory.

This is probably too aggressive but clears the way for adding a
shrinker interface to free extra slots when memory is tight.

Also *always* allow NFSD_MAX_SLOTS_PER_SESSION slot pointers per
session.  This allows the session to be allocated before we know how
many slots we will successfully allocate, and will be useful when we
starting dynamically increasing the number of allocated slots.

Signed-off-by: NeilBrown <neilb@suse.de>
---
 fs/nfsd/nfs4state.c | 91 +++++++--------------------------------------
 fs/nfsd/nfsd.h      |  3 --
 fs/nfsd/nfssvc.c    | 32 ----------------
 fs/nfsd/state.h     |  2 +-
 4 files changed, 14 insertions(+), 114 deletions(-)

diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index 551d2958ec29..2dcba0c83c10 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -1935,59 +1935,6 @@ static inline u32 slot_bytes(struct nfsd4_channel_attrs *ca)
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
@@ -1996,26 +1943,27 @@ static struct nfsd4_session *alloc_session(struct nfsd4_channel_attrs *fattrs,
 	struct nfsd4_session *new;
 	int i;
 
-	BUILD_BUG_ON(struct_size(new, se_slots, NFSD_MAX_SLOTS_PER_SESSION)
-		     > PAGE_SIZE);
+	BUILD_BUG_ON(sizeof(new) > PAGE_SIZE);
 
-	new = kzalloc(struct_size(new, se_slots, numslots), GFP_KERNEL);
+	new = kzalloc(sizeof(*new), GFP_KERNEL);
 	if (!new)
 		return NULL;
 	/* allocate each struct nfsd4_slot and data cache in one piece */
-	for (i = 0; i < numslots; i++) {
-		new->se_slots[i] = kzalloc(slotsize, GFP_KERNEL);
+	new->se_slots[0] = kzalloc(slotsize, GFP_KERNEL);
+	if (!new->se_slots[0])
+		goto out_free;
+
+	for (i = 1; i < numslots; i++) {
+		new->se_slots[i] = kzalloc(slotsize, GFP_KERNEL | __GFP_NORETRY);
 		if (!new->se_slots[i])
-			goto out_free;
+			break;
 	}
-
+	fattrs->maxreqs = i;
 	memcpy(&new->se_fchannel, fattrs, sizeof(struct nfsd4_channel_attrs));
 	memcpy(&new->se_bchannel, battrs, sizeof(struct nfsd4_channel_attrs));
 
 	return new;
 out_free:
-	while (i--)
-		kfree(new->se_slots[i]);
 	kfree(new);
 	return NULL;
 }
@@ -2128,7 +2076,6 @@ static void __free_session(struct nfsd4_session *ses)
 static void free_session(struct nfsd4_session *ses)
 {
 	nfsd4_del_conns(ses);
-	nfsd4_put_drc_mem(&ses->se_fchannel);
 	__free_session(ses);
 }
 
@@ -3748,17 +3695,6 @@ static __be32 check_forechannel_attrs(struct nfsd4_channel_attrs *ca, struct nfs
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
@@ -3836,11 +3772,11 @@ nfsd4_create_session(struct svc_rqst *rqstp,
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
@@ -3950,8 +3886,7 @@ nfsd4_create_session(struct svc_rqst *rqstp,
 		expire_client(old);
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
diff --git a/fs/nfsd/state.h b/fs/nfsd/state.h
index 35b3564c065f..c052e9eea81b 100644
--- a/fs/nfsd/state.h
+++ b/fs/nfsd/state.h
@@ -310,7 +310,7 @@ struct nfsd4_session {
 	struct list_head	se_conns;
 	u32			se_cb_prog;
 	u32			se_cb_seq_nr;
-	struct nfsd4_slot	*se_slots[];	/* forward channel slots */
+	struct nfsd4_slot	*se_slots[NFSD_MAX_SLOTS_PER_SESSION];	/* forward channel slots */
 };
 
 /* formatted contents of nfs4_sessionid */
-- 
2.47.0



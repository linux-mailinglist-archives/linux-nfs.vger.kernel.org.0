Return-Path: <linux-nfs+bounces-9455-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B1D3A18ADA
	for <lists+linux-nfs@lfdr.de>; Wed, 22 Jan 2025 04:57:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 34D143A41BE
	for <lists+linux-nfs@lfdr.de>; Wed, 22 Jan 2025 03:57:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7961139CEF;
	Wed, 22 Jan 2025 03:57:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Tvm4r8WU";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="et9G/AZY";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Tvm4r8WU";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="et9G/AZY"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8BCE1FAA
	for <linux-nfs@vger.kernel.org>; Wed, 22 Jan 2025 03:57:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737518227; cv=none; b=J24Qi5xgbU4gwbuJMTAkTq9nzt05H9+p07l5MwSYL7RQLRh97KBq1wpQKgQNbHKTlbB19CaByzWSEMxeu5GVOi2ub4okgy1HtJHCGGYhF1R6Ax4BbDEIk3f7Ai7xx17iPZL61mjLgxJE/q9jGrt3Fp8w2M2sHPzjLh19/zjNqx8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737518227; c=relaxed/simple;
	bh=7mNmbzgspCfVjClHXVKvqVsSIl8DiUzd6xgJ+zmlMq8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aGXSVcQrQdphPy3/jHm1nWTgQaSsluzsDzQj31BllrCrHkukOlBLa7sdJfZuZfNc4YSOdW5bho7fzMI54IyGVrA6OBmgpD4nu8namFvxjBOlYRrKoPFklfg/SNONCJ7CBlRjh4uAVx9GAxUWJQzbnWHIYC99yK6nu1Y9gpRX0YE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=Tvm4r8WU; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=et9G/AZY; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=Tvm4r8WU; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=et9G/AZY; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id E1177211F1;
	Wed, 22 Jan 2025 03:57:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1737518223; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PXUkRC0AnQ2vHmDB4VfbeJHXYAtPL9GaER7J50GWESE=;
	b=Tvm4r8WULjjkfwzmFn716KKLAG6omZaUE+SxgIj8sGXqJi+46d1qlaDl3eYJTE4QEHOZ2X
	nfDpaF7r4MFpZAZwOYleejcXVvuktJb3NQy4cRfPPkFxcPjfXdhrc9/U4YKx9Ifx1E5lZw
	4o8SlBCvR3qzJhhaYiyAWsbB9duGuMY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1737518223;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PXUkRC0AnQ2vHmDB4VfbeJHXYAtPL9GaER7J50GWESE=;
	b=et9G/AZYWqs9O2+SgyGp0cqrLolMFcjYIybBHL6ilPC3cRam+maPUHHGgcNV6iwit1XfIx
	D3QtVySdZRqV8UCg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1737518223; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PXUkRC0AnQ2vHmDB4VfbeJHXYAtPL9GaER7J50GWESE=;
	b=Tvm4r8WULjjkfwzmFn716KKLAG6omZaUE+SxgIj8sGXqJi+46d1qlaDl3eYJTE4QEHOZ2X
	nfDpaF7r4MFpZAZwOYleejcXVvuktJb3NQy4cRfPPkFxcPjfXdhrc9/U4YKx9Ifx1E5lZw
	4o8SlBCvR3qzJhhaYiyAWsbB9duGuMY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1737518223;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PXUkRC0AnQ2vHmDB4VfbeJHXYAtPL9GaER7J50GWESE=;
	b=et9G/AZYWqs9O2+SgyGp0cqrLolMFcjYIybBHL6ilPC3cRam+maPUHHGgcNV6iwit1XfIx
	D3QtVySdZRqV8UCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id BFEFB136A1;
	Wed, 22 Jan 2025 03:57:01 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id q7PwHI1skGelYQAAD6G6ig
	(envelope-from <neilb@suse.de>); Wed, 22 Jan 2025 03:57:01 +0000
From: NeilBrown <neilb@suse.de>
To: Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>
Cc: linux-nfs@vger.kernel.org,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <Dai.Ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>
Subject: [PATCH 4/4] nfsd: filecache: change garbage collection to a timer.
Date: Wed, 22 Jan 2025 14:54:10 +1100
Message-ID: <20250122035615.2893754-5-neilb@suse.de>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250122035615.2893754-1-neilb@suse.de>
References: <20250122035615.2893754-1-neilb@suse.de>
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
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	R_RATELIMIT(0.00)[from(RLewrxuus8mos16izbn)];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	RCVD_TLS_ALL(0.00)[]
X-Spam-Flag: NO
X-Spam-Level: 

garbage collection never sleeps and no longer walks a list so it runs
quickly only requiring a spinlock.

This means we don't need to use a workqueue, we can use a simple timer
instead.  This means it can run in "bh" context so we need to use "_bh"
locking.

Signed-off-by: NeilBrown <neilb@suse.de>
---
 fs/nfsd/filecache.c | 51 +++++++++++++++++++++++++--------------------
 1 file changed, 28 insertions(+), 23 deletions(-)

diff --git a/fs/nfsd/filecache.c b/fs/nfsd/filecache.c
index 552feba94f09..ebde4e86cdee 100644
--- a/fs/nfsd/filecache.c
+++ b/fs/nfsd/filecache.c
@@ -66,7 +66,7 @@ struct nfsd_fcache_disposal {
 	struct list_head older;	/* haven't been used in last 0-2 seconds */
 	struct list_head freeme; /* ready to be discarded */
 	unsigned long num_gc; /* Approximate size of recent plus older */
-	struct delayed_work filecache_laundrette;
+	struct timer_list timer;
 	struct shrinker *file_shrinker;
 	struct nfsd_net *nn;
 };
@@ -115,8 +115,8 @@ static const struct rhashtable_params nfsd_file_rhash_params = {
 static void
 nfsd_file_schedule_laundrette(struct nfsd_fcache_disposal *l)
 {
-	queue_delayed_work(system_unbound_wq, &l->filecache_laundrette,
-			   NFSD_LAUNDRETTE_DELAY);
+	if (!timer_pending(&l->timer))
+		mod_timer(&l->timer, jiffies + NFSD_LAUNDRETTE_DELAY);
 }
 
 static void
@@ -333,16 +333,16 @@ static bool nfsd_file_lru_add(struct nfsd_file *nf)
 	struct nfsd_net *nn = net_generic(nf->nf_net, nfsd_net_id);
 	struct nfsd_fcache_disposal *l = nn->fcache_disposal;
 
-	spin_lock(&l->lock);
+	spin_lock_bh(&l->lock);
 	if (list_empty(&nf->nf_lru)) {
 		list_add_tail(&nf->nf_lru, &l->recent);
 		l->num_gc += 1;
 		atomic_long_inc(&nfsd_lru_total);
 		trace_nfsd_file_lru_add(nf);
-		spin_unlock(&l->lock);
+		spin_unlock_bh(&l->lock);
 		return true;
 	}
-	spin_unlock(&l->lock);
+	spin_unlock_bh(&l->lock);
 	return false;
 }
 
@@ -351,17 +351,17 @@ static bool nfsd_file_lru_remove(struct nfsd_file *nf)
 	struct nfsd_net *nn = net_generic(nf->nf_net, nfsd_net_id);
 	struct nfsd_fcache_disposal *l = nn->fcache_disposal;
 
-	spin_lock(&l->lock);
+	spin_lock_bh(&l->lock);
 	if (!list_empty(&nf->nf_lru)) {
 		list_del_init(&nf->nf_lru);
 		atomic_long_dec(&nfsd_lru_total);
 		if (l->num_gc > 0)
 			l->num_gc -= 1;
 		trace_nfsd_file_lru_del(nf);
-		spin_unlock(&l->lock);
+		spin_unlock_bh(&l->lock);
 		return true;
 	}
-	spin_unlock(&l->lock);
+	spin_unlock_bh(&l->lock);
 	return false;
 }
 
@@ -487,9 +487,9 @@ nfsd_file_dispose_list_delayed(struct list_head *dispose)
 		struct nfsd_net *nn = net_generic(nf->nf_net, nfsd_net_id);
 		struct nfsd_fcache_disposal *l = nn->fcache_disposal;
 
-		spin_lock(&l->lock);
+		spin_lock_bh(&l->lock);
 		list_move_tail(&nf->nf_lru, &l->freeme);
-		spin_unlock(&l->lock);
+		spin_unlock_bh(&l->lock);
 		svc_wake_up(nn->nfsd_serv);
 	}
 }
@@ -511,7 +511,7 @@ void nfsd_file_net_dispose(struct nfsd_net *nn)
 		LIST_HEAD(dispose);
 		int i;
 
-		spin_lock(&l->lock);
+		spin_lock_bh(&l->lock);
 		for (i = 0; i < 8 && !list_empty(&l->freeme); i++) {
 			struct nfsd_file *nf = list_first_entry(
 				&l->freeme, struct nfsd_file, nf_lru);
@@ -531,7 +531,7 @@ void nfsd_file_net_dispose(struct nfsd_net *nn)
 				this_cpu_inc(nfsd_file_evictions);
 			}
 		}
-		spin_unlock(&l->lock);
+		spin_unlock_bh(&l->lock);
 		if (!list_empty(&l->freeme))
 			/* Wake up another thread to share the work
 			 * *before* doing any actual disposing.
@@ -542,12 +542,12 @@ void nfsd_file_net_dispose(struct nfsd_net *nn)
 }
 
 static void
-nfsd_file_gc_worker(struct work_struct *work)
+nfsd_file_gc_worker(struct timer_list *t)
 {
 	struct nfsd_fcache_disposal *l = container_of(
-		work, struct nfsd_fcache_disposal, filecache_laundrette.work);
+		t, struct nfsd_fcache_disposal, timer);
 
-	spin_lock(&l->lock);
+	spin_lock_bh(&l->lock);
 	list_splice_init(&l->older, &l->freeme);
 	list_splice_init(&l->recent, &l->older);
 	/* We don't know how many were moved to 'freeme' and don't want
@@ -557,9 +557,8 @@ nfsd_file_gc_worker(struct work_struct *work)
 	if (!list_empty(&l->freeme))
 		svc_wake_up(l->nn->nfsd_serv);
 	if (!list_empty(&l->older) || !list_empty(&l->recent))
-		nfsd_file_schedule_laundrette(l);
-	spin_unlock(&l->lock);
-
+		mod_timer(t, jiffies + NFSD_LAUNDRETTE_DELAY);
+	spin_unlock_bh(&l->lock);
 }
 
 static unsigned long
@@ -577,7 +576,7 @@ nfsd_file_lru_scan(struct shrinker *s, struct shrink_control *sc)
 	struct nfsd_file *nf;
 	int scanned = 0;
 
-	spin_lock(&l->lock);
+	spin_lock_bh(&l->lock);
 	while (scanned < sc->nr_to_scan &&
 	       (nf = list_first_entry_or_null(&l->older,
 					      struct nfsd_file, nf_lru)) != NULL) {
@@ -599,7 +598,9 @@ nfsd_file_lru_scan(struct shrinker *s, struct shrink_control *sc)
 		list_add_tail(&nf->nf_lru, &l->older);
 		scanned += 1;
 	}
-	spin_unlock(&l->lock);
+	spin_unlock_bh(&l->lock);
+
+	trace_nfsd_file_shrinker_removed(scanned, l->num_gc);
 	return scanned;
 }
 
@@ -854,7 +855,9 @@ nfsd_alloc_fcache_disposal(void)
 	if (!l)
 		return NULL;
 	spin_lock_init(&l->lock);
-	INIT_DELAYED_WORK(&l->filecache_laundrette, nfsd_file_gc_worker);
+	timer_setup(&l->timer, nfsd_file_gc_worker, 0);
+	INIT_LIST_HEAD(&l->recent);
+	INIT_LIST_HEAD(&l->older);
 	INIT_LIST_HEAD(&l->recent);
 	INIT_LIST_HEAD(&l->older);
 	INIT_LIST_HEAD(&l->freeme);
@@ -871,13 +874,15 @@ nfsd_alloc_fcache_disposal(void)
 	l->file_shrinker->private_data = l;
 
 	shrinker_register(l->file_shrinker);
+
 	return l;
 }
 
 static void
 nfsd_free_fcache_disposal(struct nfsd_fcache_disposal *l)
 {
-	cancel_delayed_work_sync(&l->filecache_laundrette);
+	shrinker_free(l->file_shrinker);
+	del_timer_sync(&l->timer);
 	shrinker_free(l->file_shrinker);
 	nfsd_file_release_list(&l->recent);
 	WARN_ON_ONCE(!list_empty(&l->recent));
-- 
2.47.1



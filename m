Return-Path: <linux-nfs+bounces-9649-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0104FA1CF6D
	for <lists+linux-nfs@lfdr.de>; Mon, 27 Jan 2025 02:23:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 55CA51610D9
	for <lists+linux-nfs@lfdr.de>; Mon, 27 Jan 2025 01:23:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B308D64D;
	Mon, 27 Jan 2025 01:23:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="PXkIOpcm";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="Nhc/qeTs";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="PXkIOpcm";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="Nhc/qeTs"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D3214C6E
	for <linux-nfs@vger.kernel.org>; Mon, 27 Jan 2025 01:23:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737941023; cv=none; b=GA0gBGPCTH/vz3tw0gB2FN4HUrXIci+JeKYd+aQ7W43Sn99NFBObBh8hsT5Ovvf38oHuG3s9x5Wey1+A5d3LGQcplOT/JdOrpuq4BFey9khfwqhM5l11OIr9AaX1tskWS6tsczVHMY001Vri+xf/WZYZvN/b4YisooZw7wyhPF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737941023; c=relaxed/simple;
	bh=4w6tOB4tRGCAHLn377kIRAuXJYu/l61pBpio+KATOsk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dUUzfg27MJgCkI/qtV2dE3gZdz/nEHwDqFLd+KE1fUeoil9FfoXZqUOA9YCw+VWPx6vohZNfKaDrUJs+cIyY2M/xzcgMdBJ6+Qs0gE08dXvecIWJfe2eftgvwvvDhY0hFqWEC0yG8OCrd0/7TEtYJFZx6vvmnTVNnW/Vo9pn+Fg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=PXkIOpcm; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=Nhc/qeTs; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=PXkIOpcm; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=Nhc/qeTs; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 9A2791F38F;
	Mon, 27 Jan 2025 01:23:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1737941019; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0o7e2GUBtE9TJ5xQZyDGgS87nL6Ky3E6vZGTESNcucQ=;
	b=PXkIOpcmQPd6hQCG8t49aEru0GsIBDQFgLnmGdKbFKYp3Cx+THQsMcMyLtyCafy9qcnZYI
	9nrIzv8euyRkWgzzrrp/o0VMk+j3CwnEfoquK2VKXdPb6Cwp/ZEDMZrS57Y9zvBLephgfh
	YR3UngF+GxwMBmfc+Ag1xpyswF2KMz4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1737941019;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0o7e2GUBtE9TJ5xQZyDGgS87nL6Ky3E6vZGTESNcucQ=;
	b=Nhc/qeTs5OcHlKbHXoDBYWWOCRB3EBBTRXEH3u1eySm7GM0k7n2Fs0jcEkk1bILGCV7QZp
	j1FB/DLoE1nN/RDQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1737941019; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0o7e2GUBtE9TJ5xQZyDGgS87nL6Ky3E6vZGTESNcucQ=;
	b=PXkIOpcmQPd6hQCG8t49aEru0GsIBDQFgLnmGdKbFKYp3Cx+THQsMcMyLtyCafy9qcnZYI
	9nrIzv8euyRkWgzzrrp/o0VMk+j3CwnEfoquK2VKXdPb6Cwp/ZEDMZrS57Y9zvBLephgfh
	YR3UngF+GxwMBmfc+Ag1xpyswF2KMz4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1737941019;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0o7e2GUBtE9TJ5xQZyDGgS87nL6Ky3E6vZGTESNcucQ=;
	b=Nhc/qeTs5OcHlKbHXoDBYWWOCRB3EBBTRXEH3u1eySm7GM0k7n2Fs0jcEkk1bILGCV7QZp
	j1FB/DLoE1nN/RDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D8DB013782;
	Mon, 27 Jan 2025 01:23:36 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id bVjrIhjglmc4AQAAD6G6ig
	(envelope-from <neilb@suse.de>); Mon, 27 Jan 2025 01:23:36 +0000
From: NeilBrown <neilb@suse.de>
To: Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>
Cc: linux-nfs@vger.kernel.org,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <Dai.Ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>,
	Dave Chinner <david@fromorbit.com>
Subject: [PATCH 3/7] nfsd: filecache: move globals nfsd_file_lru and nfsd_file_shrinker to be per-net
Date: Mon, 27 Jan 2025 12:20:34 +1100
Message-ID: <20250127012257.1803314-4-neilb@suse.de>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250127012257.1803314-1-neilb@suse.de>
References: <20250127012257.1803314-1-neilb@suse.de>
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
	RCPT_COUNT_SEVEN(0.00)[7];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	R_RATELIMIT(0.00)[from(RLewrxuus8mos16izbn)];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo];
	RCVD_TLS_ALL(0.00)[]
X-Spam-Flag: NO
X-Spam-Level: 

The final freeing of nfsd files is done by per-net nfsd threads (which
call nfsd_file_net_dispose()) so it makes some sense to make more of the
freeing infrastructure to be per-net - in struct nfsd_fcache_disposal.

This is a step towards replacing the list_lru with simple lists which
each share the per-net lock in nfsd_fcache_disposal and will require
less list walking.

As the net is always shutdown before there is any chance that the rest
of the filecache is shut down we can removed the tests on
NFSD_FILE_CACHE_UP.

For the filecache stats file, which assumes a global lru, we keep a
separate counter which includes all files in all netns lrus.

Reviewed-by: Jeff Layton <jlayton@kernel.org>
Signed-off-by: NeilBrown <neilb@suse.de>
---
 fs/nfsd/filecache.c | 128 +++++++++++++++++++++++++-------------------
 1 file changed, 72 insertions(+), 56 deletions(-)

diff --git a/fs/nfsd/filecache.c b/fs/nfsd/filecache.c
index 549969d4aa7c..55f69bcde500 100644
--- a/fs/nfsd/filecache.c
+++ b/fs/nfsd/filecache.c
@@ -60,18 +60,20 @@ static DEFINE_PER_CPU(unsigned long, nfsd_file_allocations);
 static DEFINE_PER_CPU(unsigned long, nfsd_file_releases);
 static DEFINE_PER_CPU(unsigned long, nfsd_file_total_age);
 static DEFINE_PER_CPU(unsigned long, nfsd_file_evictions);
+static DEFINE_PER_CPU(unsigned long, nfsd_file_lru_total);
 
 struct nfsd_fcache_disposal {
 	spinlock_t lock;
+	struct list_lru file_lru;
 	struct list_head freeme;
+	struct delayed_work filecache_laundrette;
+	struct shrinker *file_shrinker;
 };
 
 static struct kmem_cache		*nfsd_file_slab;
 static struct kmem_cache		*nfsd_file_mark_slab;
-static struct list_lru			nfsd_file_lru;
 static unsigned long			nfsd_file_flags;
 static struct fsnotify_group		*nfsd_file_fsnotify_group;
-static struct delayed_work		nfsd_filecache_laundrette;
 static struct rhltable			nfsd_file_rhltable
 						____cacheline_aligned_in_smp;
 
@@ -109,11 +111,18 @@ static const struct rhashtable_params nfsd_file_rhash_params = {
 };
 
 static void
-nfsd_file_schedule_laundrette(void)
+nfsd_file_schedule_laundrette(struct nfsd_fcache_disposal *l)
 {
-	if (test_bit(NFSD_FILE_CACHE_UP, &nfsd_file_flags))
-		queue_delayed_work(system_unbound_wq, &nfsd_filecache_laundrette,
-				   NFSD_LAUNDRETTE_DELAY);
+	queue_delayed_work(system_unbound_wq, &l->filecache_laundrette,
+			   NFSD_LAUNDRETTE_DELAY);
+}
+
+static void
+nfsd_file_schedule_laundrette_net(struct net *net)
+{
+	struct nfsd_net *nn = net_generic(net, nfsd_net_id);
+
+	nfsd_file_schedule_laundrette(nn->fcache_disposal);
 }
 
 static void
@@ -318,11 +327,14 @@ nfsd_file_check_writeback(struct nfsd_file *nf)
 		mapping_tagged(mapping, PAGECACHE_TAG_WRITEBACK);
 }
 
-
 static bool nfsd_file_lru_add(struct nfsd_file *nf)
 {
+	struct nfsd_net *nn = net_generic(nf->nf_net, nfsd_net_id);
+	struct nfsd_fcache_disposal *l = nn->fcache_disposal;
+
 	set_bit(NFSD_FILE_REFERENCED, &nf->nf_flags);
-	if (list_lru_add_obj(&nfsd_file_lru, &nf->nf_lru)) {
+	if (list_lru_add_obj(&l->file_lru, &nf->nf_lru)) {
+		this_cpu_inc(nfsd_file_lru_total);
 		trace_nfsd_file_lru_add(nf);
 		return true;
 	}
@@ -331,7 +343,11 @@ static bool nfsd_file_lru_add(struct nfsd_file *nf)
 
 static bool nfsd_file_lru_remove(struct nfsd_file *nf)
 {
-	if (list_lru_del_obj(&nfsd_file_lru, &nf->nf_lru)) {
+	struct nfsd_net *nn = net_generic(nf->nf_net, nfsd_net_id);
+	struct nfsd_fcache_disposal *l = nn->fcache_disposal;
+
+	if (list_lru_del_obj(&l->file_lru, &nf->nf_lru)) {
+		this_cpu_dec(nfsd_file_lru_total);
 		trace_nfsd_file_lru_del(nf);
 		return true;
 	}
@@ -371,7 +387,7 @@ nfsd_file_put(struct nfsd_file *nf)
 
 		/* Try to add it to the LRU.  If that fails, decrement. */
 		if (nfsd_file_lru_add(nf)) {
-			nfsd_file_schedule_laundrette();
+			nfsd_file_schedule_laundrette_net(nf->nf_net);
 			return;
 		}
 
@@ -525,12 +541,14 @@ nfsd_file_lru_cb(struct list_head *item, struct list_lru_one *lru,
 	if (!refcount_dec_and_test(&nf->nf_ref)) {
 		trace_nfsd_file_gc_in_use(nf);
 		list_lru_isolate(lru, &nf->nf_lru);
+		this_cpu_dec(nfsd_file_lru_total);
 		return LRU_REMOVED;
 	}
 
 	/* Refcount went to zero. Unhash it and queue it to the dispose list */
 	nfsd_file_unhash(nf);
 	list_lru_isolate(lru, &nf->nf_lru);
+	this_cpu_dec(nfsd_file_lru_total);
 	list_add(&nf->nf_gc, head);
 	this_cpu_inc(nfsd_file_evictions);
 	trace_nfsd_file_gc_disposed(nf);
@@ -538,18 +556,18 @@ nfsd_file_lru_cb(struct list_head *item, struct list_lru_one *lru,
 }
 
 static void
-nfsd_file_gc(void)
+nfsd_file_gc(struct nfsd_fcache_disposal *l)
 {
-	unsigned long remaining = list_lru_count(&nfsd_file_lru);
+	unsigned long remaining = list_lru_count(&l->file_lru);
 	LIST_HEAD(dispose);
 	unsigned long ret;
 
 	while (remaining > 0) {
 		unsigned long num_to_scan = min(remaining, NFSD_FILE_GC_BATCH);
 
-		ret = list_lru_walk(&nfsd_file_lru, nfsd_file_lru_cb,
+		ret = list_lru_walk(&l->file_lru, nfsd_file_lru_cb,
 				    &dispose, num_to_scan);
-		trace_nfsd_file_gc_removed(ret, list_lru_count(&nfsd_file_lru));
+		trace_nfsd_file_gc_removed(ret, list_lru_count(&l->file_lru));
 		nfsd_file_dispose_list_delayed(&dispose);
 		remaining -= num_to_scan;
 	}
@@ -558,32 +576,36 @@ nfsd_file_gc(void)
 static void
 nfsd_file_gc_worker(struct work_struct *work)
 {
-	nfsd_file_gc();
-	if (list_lru_count(&nfsd_file_lru))
-		nfsd_file_schedule_laundrette();
+	struct nfsd_fcache_disposal *l = container_of(
+		work, struct nfsd_fcache_disposal, filecache_laundrette.work);
+	nfsd_file_gc(l);
+	if (list_lru_count(&l->file_lru))
+		nfsd_file_schedule_laundrette(l);
 }
 
 static unsigned long
 nfsd_file_lru_count(struct shrinker *s, struct shrink_control *sc)
 {
-	return list_lru_count(&nfsd_file_lru);
+	struct nfsd_fcache_disposal *l = s->private_data;
+
+	return list_lru_count(&l->file_lru);
 }
 
 static unsigned long
 nfsd_file_lru_scan(struct shrinker *s, struct shrink_control *sc)
 {
+	struct nfsd_fcache_disposal *l = s->private_data;
+
 	LIST_HEAD(dispose);
 	unsigned long ret;
 
-	ret = list_lru_shrink_walk(&nfsd_file_lru, sc,
+	ret = list_lru_shrink_walk(&l->file_lru, sc,
 				   nfsd_file_lru_cb, &dispose);
-	trace_nfsd_file_shrinker_removed(ret, list_lru_count(&nfsd_file_lru));
+	trace_nfsd_file_shrinker_removed(ret, list_lru_count(&l->file_lru));
 	nfsd_file_dispose_list_delayed(&dispose);
 	return ret;
 }
 
-static struct shrinker *nfsd_file_shrinker;
-
 /**
  * nfsd_file_cond_queue - conditionally unhash and queue a nfsd_file
  * @nf: nfsd_file to attempt to queue
@@ -763,29 +785,10 @@ nfsd_file_cache_init(void)
 		goto out_err;
 	}
 
-	ret = list_lru_init(&nfsd_file_lru);
-	if (ret) {
-		pr_err("nfsd: failed to init nfsd_file_lru: %d\n", ret);
-		goto out_err;
-	}
-
-	nfsd_file_shrinker = shrinker_alloc(0, "nfsd-filecache");
-	if (!nfsd_file_shrinker) {
-		ret = -ENOMEM;
-		pr_err("nfsd: failed to allocate nfsd_file_shrinker\n");
-		goto out_lru;
-	}
-
-	nfsd_file_shrinker->count_objects = nfsd_file_lru_count;
-	nfsd_file_shrinker->scan_objects = nfsd_file_lru_scan;
-	nfsd_file_shrinker->seeks = 1;
-
-	shrinker_register(nfsd_file_shrinker);
-
 	ret = lease_register_notifier(&nfsd_file_lease_notifier);
 	if (ret) {
 		pr_err("nfsd: unable to register lease notifier: %d\n", ret);
-		goto out_shrinker;
+		goto out_err;
 	}
 
 	nfsd_file_fsnotify_group = fsnotify_alloc_group(&nfsd_file_fsnotify_ops,
@@ -798,17 +801,12 @@ nfsd_file_cache_init(void)
 		goto out_notifier;
 	}
 
-	INIT_DELAYED_WORK(&nfsd_filecache_laundrette, nfsd_file_gc_worker);
 out:
 	if (ret)
 		clear_bit(NFSD_FILE_CACHE_UP, &nfsd_file_flags);
 	return ret;
 out_notifier:
 	lease_unregister_notifier(&nfsd_file_lease_notifier);
-out_shrinker:
-	shrinker_free(nfsd_file_shrinker);
-out_lru:
-	list_lru_destroy(&nfsd_file_lru);
 out_err:
 	kmem_cache_destroy(nfsd_file_slab);
 	nfsd_file_slab = NULL;
@@ -860,13 +858,38 @@ nfsd_alloc_fcache_disposal(void)
 	if (!l)
 		return NULL;
 	spin_lock_init(&l->lock);
+	INIT_DELAYED_WORK(&l->filecache_laundrette, nfsd_file_gc_worker);
 	INIT_LIST_HEAD(&l->freeme);
+	l->file_shrinker = shrinker_alloc(0, "nfsd-filecache");
+	if (!l->file_shrinker) {
+		pr_err("nfsd: failed to allocate nfsd_file_shrinker\n");
+		kfree(l);
+		return NULL;
+	}
+	l->file_shrinker->count_objects = nfsd_file_lru_count;
+	l->file_shrinker->scan_objects = nfsd_file_lru_scan;
+	l->file_shrinker->seeks = 1;
+	l->file_shrinker->private_data = l;
+
+	/* if file_lru is not zeroed it can trigger a bug: ->key is the problem */
+	memset(&l->file_lru, 0, sizeof(l->file_lru));
+	if (list_lru_init(&l->file_lru)) {
+		pr_err("nfsd: failed to init nfsd_file_lru\n");
+		shrinker_free(l->file_shrinker);
+		kfree(l);
+		return NULL;
+	}
+
+	shrinker_register(l->file_shrinker);
 	return l;
 }
 
 static void
 nfsd_free_fcache_disposal(struct nfsd_fcache_disposal *l)
 {
+	cancel_delayed_work_sync(&l->filecache_laundrette);
+	shrinker_free(l->file_shrinker);
+	list_lru_destroy(&l->file_lru);
 	nfsd_file_dispose_list(&l->freeme);
 	kfree(l);
 }
@@ -919,14 +942,7 @@ nfsd_file_cache_shutdown(void)
 		return;
 
 	lease_unregister_notifier(&nfsd_file_lease_notifier);
-	shrinker_free(nfsd_file_shrinker);
-	/*
-	 * make sure all callers of nfsd_file_lru_cb are done before
-	 * calling nfsd_file_cache_purge
-	 */
-	cancel_delayed_work_sync(&nfsd_filecache_laundrette);
 	__nfsd_file_cache_purge(NULL);
-	list_lru_destroy(&nfsd_file_lru);
 	rcu_barrier();
 	fsnotify_put_group(nfsd_file_fsnotify_group);
 	nfsd_file_fsnotify_group = NULL;
@@ -944,6 +960,7 @@ nfsd_file_cache_shutdown(void)
 		per_cpu(nfsd_file_releases, i) = 0;
 		per_cpu(nfsd_file_total_age, i) = 0;
 		per_cpu(nfsd_file_evictions, i) = 0;
+		per_cpu(nfsd_file_lru_total, i) = 0;
 	}
 }
 
@@ -1297,8 +1314,6 @@ int nfsd_file_cache_stats_show(struct seq_file *m, void *v)
 		struct bucket_table *tbl;
 		struct rhashtable *ht;
 
-		lru = list_lru_count(&nfsd_file_lru);
-
 		rcu_read_lock();
 		ht = &nfsd_file_rhltable.ht;
 		count = atomic_read(&ht->nelems);
@@ -1309,6 +1324,7 @@ int nfsd_file_cache_stats_show(struct seq_file *m, void *v)
 	mutex_unlock(&nfsd_mutex);
 
 	for_each_possible_cpu(i) {
+		lru += per_cpu(nfsd_file_lru_total, i);
 		hits += per_cpu(nfsd_file_cache_hits, i);
 		acquisitions += per_cpu(nfsd_file_acquisitions, i);
 		allocations += per_cpu(nfsd_file_allocations, i);
-- 
2.47.1



Return-Path: <linux-nfs+bounces-8965-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 59BAFA04D0E
	for <lists+linux-nfs@lfdr.de>; Wed,  8 Jan 2025 00:04:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D114618876F3
	for <lists+linux-nfs@lfdr.de>; Tue,  7 Jan 2025 23:04:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FF49199920;
	Tue,  7 Jan 2025 23:04:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="dKyGRTWu";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="yIJ06VJG";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="dKyGRTWu";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="yIJ06VJG"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 090D01E4113
	for <linux-nfs@vger.kernel.org>; Tue,  7 Jan 2025 23:04:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736291047; cv=none; b=h3qIyUKIdS6X6EmxS4Xev89BF1yezlAYsHZenfV9ZiMhH9FJiGG5xG7J6xkqgBklmJRNFLrjsX7YBvFP50VBMdspAoukF8xrWpNbuEd8cAesIkMjLy2vAcVNR99owjY46jZbVcLwSXUZE5zHShraYB5Xf47jVxXavKvUycpG8Rs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736291047; c=relaxed/simple;
	bh=NWdVVhGLgPiePMyPZQ+LYv5eSmHR1TSl0/vQvLswfy4=;
	h=Content-Type:MIME-Version:From:To:cc:Subject:Date:Message-id; b=jqqSOKXenoJg1CI18ucX9fBiEUq41yZ83oHg2BQxOxOCvToldE3+I0c6eCGB4drQD9p9A7WD2L8z7E4iSUFCObuk3v1qZIqIZ36QKsRuE7FnHBLDAk3v92LMbQOe9eFLMGg4KPYIpRuCQ14puZMlzVUhPDPPj5vHuEfQknBKwzs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=dKyGRTWu; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=yIJ06VJG; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=dKyGRTWu; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=yIJ06VJG; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 09B6121157;
	Tue,  7 Jan 2025 23:04:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1736291043; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=1sowSR4p+OmvLaKQIdsrwPFR6Xnh7AXoFUyf/5pjzBU=;
	b=dKyGRTWuy0QFKOzlvcMX2t4zdYK55ljgH21QGsfOfxRr0ysz2m4YXT3FtyRiiMfHXnWost
	CCiZmTtMCn9bE1mFn44esIMbkyB3VW5hb1e5DaLbm0j9mbjtqV5u3ymd1RVpinxg+NsYls
	g4AQ+2Wqx++hSq6m4YWS5JIC11Fw0A4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1736291043;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=1sowSR4p+OmvLaKQIdsrwPFR6Xnh7AXoFUyf/5pjzBU=;
	b=yIJ06VJG4wLTaRkYrvvVgZsE0cWlFN4ulhTHEUfwnCN5ITxIib7/wOQc0/6T/qhR4tBq6O
	hiFfaqY7q/v++4DA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1736291043; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=1sowSR4p+OmvLaKQIdsrwPFR6Xnh7AXoFUyf/5pjzBU=;
	b=dKyGRTWuy0QFKOzlvcMX2t4zdYK55ljgH21QGsfOfxRr0ysz2m4YXT3FtyRiiMfHXnWost
	CCiZmTtMCn9bE1mFn44esIMbkyB3VW5hb1e5DaLbm0j9mbjtqV5u3ymd1RVpinxg+NsYls
	g4AQ+2Wqx++hSq6m4YWS5JIC11Fw0A4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1736291043;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=1sowSR4p+OmvLaKQIdsrwPFR6Xnh7AXoFUyf/5pjzBU=;
	b=yIJ06VJG4wLTaRkYrvvVgZsE0cWlFN4ulhTHEUfwnCN5ITxIib7/wOQc0/6T/qhR4tBq6O
	hiFfaqY7q/v++4DA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 905EB13763;
	Tue,  7 Jan 2025 23:04:00 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id ES/JEOCyfWc/SQAAD6G6ig
	(envelope-from <neilb@suse.de>); Tue, 07 Jan 2025 23:04:00 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "NeilBrown" <neilb@suse.de>
To: "Chuck Lever" <chuck.lever@oracle.com>,
  "Jeff Layton" <jlayton@kernel.org>,
 "Olga Kornievskaia" <okorniev@redhat.com>, "Dai Ngo" <Dai.Ngo@oracle.com>,
 "Tom Talpey" <tom@talpey.com>
cc: linux-nfs@vger.kernel.org
Subject:
 [PATCH RFC] nfsd: change filecache garbage collection list management.
Date: Wed, 08 Jan 2025 10:03:53 +1100
Message-id: <173629103327.22054.7411711418787098876@noble.neil.brown.name>
X-Spam-Level: 
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-0.983];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[noble.neil.brown.name:mid,suse.de:email]
X-Spam-Score: -4.30
X-Spam-Flag: NO


The nfsd filecache currently uses list_lru for tracking files recently
used in NFSv3 requests which need to be "garbage collected" when they
have becoming idle - unused for 2-4 seconds.

I do not believe list_lru is a good tool for this.  It does no allow the
timeout which filecache requires so we have to add a timeout mechanism
which holds the list_lru for while the whole list is scanned looking for
entries that haven't been recently accessed.  When the list is largish
(even a few hundred) this can block new requests which need the lock to
remove a file to access it.

This patch removes the list_lru and instead uses 2 simple linked lists.
When a file is accessed it is removed from whichever list it is one,
then added to the tail of the first list.  Every 2 seconds the second
list is moved to the "freeme" list and the first list is moved to the
second list.  This avoids any need to walk a list to find old entries.

These lists are per-netns rather than global as the freeme list is
per-netns as the actual freeing is done in nfsd threads which are
per-netns.

Also the shrinker is moved to be per-netns so that it can access just
the lists of that netns.

We don't need a work_item for the gc pass as it never sleeps.  We can
use a simple timer instead.  This requires taking the spinlock with
"_bh".

Previously a file would be unhashed before being moved to the freeme
list.  We don't do that any more.  The freeme list is much like the
other two lists (recent and older) in that they all hold a reference to
the file and the file is still hashed.  When the nfsd thread processes
the freeme list it now use the new nfsd_file_release_list() which uses
nfsd_file_cond_queue() to unhash and drop the refcount.

We no longer have a precise cound of the size of the lru (recent +
older) as we don't know how big "older" is when it is moved to "freeme".
How the shrinker can with an approximation.  So when we keep a count of
number in the lru and hwen "older" is moved to "freeme" we divide that
count by 2.  When we remove anything from the lru we decrement that
counter but ensure it never goes negative.  Naturally when we add to the
lru we increase the counter.

For the filecache stats file, which assumes a global lru, we keep a
separate counter which includes all files in all netns in recent or
older of freeme.

We discard the nf_gc linkage in an nfsd_file and only use nf_lru.
We discard NFSD_FILE_REFERENCED.
nfsd_file_close_inode_sync() included a copy of
nfsd_file_dispose_list().  This has been change to call that function
instead.

Possibly this patch could be broken into a few smaller patches.

Tracepoints should be revieed.

Signed-off-by: NeilBrown <neilb@suse.de>
---
 fs/nfsd/filecache.c | 304 +++++++++++++++++++++++---------------------
 fs/nfsd/filecache.h |   4 +-
 fs/nfsd/trace.h     |   1 -
 3 files changed, 157 insertions(+), 152 deletions(-)

diff --git a/fs/nfsd/filecache.c b/fs/nfsd/filecache.c
index a1cdba42c4fa..319c60234f09 100644
--- a/fs/nfsd/filecache.c
+++ b/fs/nfsd/filecache.c
@@ -34,7 +34,6 @@
 #include <linux/file.h>
 #include <linux/pagemap.h>
 #include <linux/sched.h>
-#include <linux/list_lru.h>
 #include <linux/fsnotify_backend.h>
 #include <linux/fsnotify.h>
 #include <linux/seq_file.h>
@@ -63,17 +62,22 @@ static DEFINE_PER_CPU(unsigned long, nfsd_file_evictions);
=20
 struct nfsd_fcache_disposal {
 	spinlock_t lock;
-	struct list_head freeme;
+	struct timer_list timer;
+	struct list_head recent; /* have been used in last 0-2 seconds */
+	struct list_head older;	/* haven't been used in last 0-2 seconds */
+	struct list_head freeme; /* ready to be discarded */
+	unsigned long num_gc; /* Approximate size of recent plus older */
+	struct shrinker *file_shrinker;
+	struct nfsd_net *nn;
 };
=20
 static struct kmem_cache		*nfsd_file_slab;
 static struct kmem_cache		*nfsd_file_mark_slab;
-static struct list_lru			nfsd_file_lru;
 static unsigned long			nfsd_file_flags;
 static struct fsnotify_group		*nfsd_file_fsnotify_group;
-static struct delayed_work		nfsd_filecache_laundrette;
 static struct rhltable			nfsd_file_rhltable
 						____cacheline_aligned_in_smp;
+static atomic_long_t			nfsd_lru_total =3D ATOMIC_LONG_INIT(0);
=20
 static bool
 nfsd_match_cred(const struct cred *c1, const struct cred *c2)
@@ -109,11 +113,14 @@ static const struct rhashtable_params nfsd_file_rhash_p=
arams =3D {
 };
=20
 static void
-nfsd_file_schedule_laundrette(void)
+nfsd_file_schedule_laundrette(struct net *net)
 {
-	if (test_bit(NFSD_FILE_CACHE_UP, &nfsd_file_flags))
-		queue_delayed_work(system_unbound_wq, &nfsd_filecache_laundrette,
-				   NFSD_LAUNDRETTE_DELAY);
+	struct nfsd_net *nn =3D net_generic(net, nfsd_net_id);
+	struct nfsd_fcache_disposal *l =3D nn->fcache_disposal;
+
+	if (test_bit(NFSD_FILE_CACHE_UP, &nfsd_file_flags) &&
+	    !timer_pending(&l->timer))
+		mod_timer(&l->timer, jiffies + NFSD_LAUNDRETTE_DELAY);
 }
=20
 static void
@@ -218,7 +225,6 @@ nfsd_file_alloc(struct net *net, struct inode *inode, uns=
igned char need,
=20
 	this_cpu_inc(nfsd_file_allocations);
 	INIT_LIST_HEAD(&nf->nf_lru);
-	INIT_LIST_HEAD(&nf->nf_gc);
 	nf->nf_birthtime =3D ktime_get();
 	nf->nf_file =3D NULL;
 	nf->nf_cred =3D get_current_cred();
@@ -318,23 +324,40 @@ nfsd_file_check_writeback(struct nfsd_file *nf)
 		mapping_tagged(mapping, PAGECACHE_TAG_WRITEBACK);
 }
=20
-
 static bool nfsd_file_lru_add(struct nfsd_file *nf)
 {
-	set_bit(NFSD_FILE_REFERENCED, &nf->nf_flags);
-	if (list_lru_add_obj(&nfsd_file_lru, &nf->nf_lru)) {
+	struct nfsd_net *nn =3D net_generic(nf->nf_net, nfsd_net_id);
+	struct nfsd_fcache_disposal *l =3D nn->fcache_disposal;
+
+	spin_lock_bh(&l->lock);
+	if (list_empty(&nf->nf_lru)) {
+		list_add_tail(&nf->nf_lru, &l->recent);
+		l->num_gc +=3D 1;
+		atomic_long_inc(&nfsd_lru_total);
+		spin_unlock_bh(&l->lock);
 		trace_nfsd_file_lru_add(nf);
 		return true;
 	}
+	spin_unlock_bh(&l->lock);
 	return false;
 }
=20
 static bool nfsd_file_lru_remove(struct nfsd_file *nf)
 {
-	if (list_lru_del_obj(&nfsd_file_lru, &nf->nf_lru)) {
+	struct nfsd_net *nn =3D net_generic(nf->nf_net, nfsd_net_id);
+	struct nfsd_fcache_disposal *l =3D nn->fcache_disposal;
+
+	spin_lock_bh(&l->lock);
+	if (!list_empty(&nf->nf_lru)) {
+		list_del_init(&nf->nf_lru);
+		atomic_long_dec(&nfsd_lru_total);
+		if (l->num_gc > 0)
+			l->num_gc -=3D 1;
+		spin_unlock_bh(&l->lock);
 		trace_nfsd_file_lru_del(nf);
 		return true;
 	}
+	spin_unlock_bh(&l->lock);
 	return false;
 }
=20
@@ -373,7 +396,7 @@ nfsd_file_put(struct nfsd_file *nf)
 		if (nfsd_file_lru_add(nf)) {
 			/* If it's still hashed, we're done */
 			if (test_bit(NFSD_FILE_HASHED, &nf->nf_flags)) {
-				nfsd_file_schedule_laundrette();
+				nfsd_file_schedule_laundrette(nf->nf_net);
 				return;
 			}
=20
@@ -424,12 +447,26 @@ nfsd_file_dispose_list(struct list_head *dispose)
 	struct nfsd_file *nf;
=20
 	while (!list_empty(dispose)) {
-		nf =3D list_first_entry(dispose, struct nfsd_file, nf_gc);
-		list_del_init(&nf->nf_gc);
+		nf =3D list_first_entry(dispose, struct nfsd_file, nf_lru);
+		list_del_init(&nf->nf_lru);
 		nfsd_file_free(nf);
 	}
 }
=20
+static void
+nfsd_file_cond_queue(struct nfsd_file *nf, struct list_head *dispose);
+
+static void
+nfsd_file_release_list(struct list_head *dispose)
+{
+	LIST_HEAD(dispose2);
+	struct nfsd_file *nf, *nf2;
+
+	list_for_each_entry_safe(nf, nf2, dispose, nf_lru)
+		nfsd_file_cond_queue(nf, &dispose2);
+	nfsd_file_dispose_list(&dispose2);
+}
+
 /**
  * nfsd_file_dispose_list_delayed - move list of dead files to net's freeme =
list
  * @dispose: list of nfsd_files to be disposed
@@ -442,13 +479,13 @@ nfsd_file_dispose_list_delayed(struct list_head *dispos=
e)
 {
 	while(!list_empty(dispose)) {
 		struct nfsd_file *nf =3D list_first_entry(dispose,
-						struct nfsd_file, nf_gc);
+						struct nfsd_file, nf_lru);
 		struct nfsd_net *nn =3D net_generic(nf->nf_net, nfsd_net_id);
 		struct nfsd_fcache_disposal *l =3D nn->fcache_disposal;
=20
-		spin_lock(&l->lock);
-		list_move_tail(&nf->nf_gc, &l->freeme);
-		spin_unlock(&l->lock);
+		spin_lock_bh(&l->lock);
+		list_move_tail(&nf->nf_lru, &l->freeme);
+		spin_unlock_bh(&l->lock);
 		svc_wake_up(nn->nfsd_serv);
 	}
 }
@@ -470,115 +507,97 @@ void nfsd_file_net_dispose(struct nfsd_net *nn)
 		LIST_HEAD(dispose);
 		int i;
=20
-		spin_lock(&l->lock);
-		for (i =3D 0; i < 8 && !list_empty(&l->freeme); i++)
-			list_move(l->freeme.next, &dispose);
-		spin_unlock(&l->lock);
+		spin_lock_bh(&l->lock);
+		for (i =3D 0; i < 8 && !list_empty(&l->freeme); i++) {
+			struct nfsd_file *nf =3D list_first_entry(
+				&l->freeme, struct nfsd_file, nf_lru);
+
+			/*
+			 * Don't throw out files that are still
+			 * undergoing I/O or that have uncleared errors
+			 * pending.
+			 */
+			if (nfsd_file_check_writeback(nf)) {
+				list_move(&nf->nf_lru, &l->recent);
+				l->num_gc +=3D 1;
+			} else {
+				list_move(&nf->nf_lru, &dispose);
+				this_cpu_inc(nfsd_file_evictions);
+			}
+		}
+		spin_unlock_bh(&l->lock);
 		if (!list_empty(&l->freeme))
 			/* Wake up another thread to share the work
 			 * *before* doing any actual disposing.
 			 */
 			svc_wake_up(nn->nfsd_serv);
-		nfsd_file_dispose_list(&dispose);
-	}
-}
-
-/**
- * nfsd_file_lru_cb - Examine an entry on the LRU list
- * @item: LRU entry to examine
- * @lru: controlling LRU
- * @arg: dispose list
- *
- * Return values:
- *   %LRU_REMOVED: @item was removed from the LRU
- *   %LRU_ROTATE: @item is to be moved to the LRU tail
- *   %LRU_SKIP: @item cannot be evicted
- */
-static enum lru_status
-nfsd_file_lru_cb(struct list_head *item, struct list_lru_one *lru,
-		 void *arg)
-{
-	struct list_head *head =3D arg;
-	struct nfsd_file *nf =3D list_entry(item, struct nfsd_file, nf_lru);
-
-	/* We should only be dealing with GC entries here */
-	WARN_ON_ONCE(!test_bit(NFSD_FILE_GC, &nf->nf_flags));
-
-	/*
-	 * Don't throw out files that are still undergoing I/O or
-	 * that have uncleared errors pending.
-	 */
-	if (nfsd_file_check_writeback(nf)) {
-		trace_nfsd_file_gc_writeback(nf);
-		return LRU_SKIP;
-	}
-
-	/* If it was recently added to the list, skip it */
-	if (test_and_clear_bit(NFSD_FILE_REFERENCED, &nf->nf_flags)) {
-		trace_nfsd_file_gc_referenced(nf);
-		return LRU_ROTATE;
-	}
-
-	/*
-	 * Put the reference held on behalf of the LRU. If it wasn't the last
-	 * one, then just remove it from the LRU and ignore it.
-	 */
-	if (!refcount_dec_and_test(&nf->nf_ref)) {
-		trace_nfsd_file_gc_in_use(nf);
-		list_lru_isolate(lru, &nf->nf_lru);
-		return LRU_REMOVED;
+		nfsd_file_release_list(&dispose);
 	}
-
-	/* Refcount went to zero. Unhash it and queue it to the dispose list */
-	nfsd_file_unhash(nf);
-	list_lru_isolate(lru, &nf->nf_lru);
-	list_add(&nf->nf_gc, head);
-	this_cpu_inc(nfsd_file_evictions);
-	trace_nfsd_file_gc_disposed(nf);
-	return LRU_REMOVED;
-}
-
-static void
-nfsd_file_gc(void)
-{
-	LIST_HEAD(dispose);
-	unsigned long ret;
-
-	ret =3D list_lru_walk(&nfsd_file_lru, nfsd_file_lru_cb,
-			    &dispose, list_lru_count(&nfsd_file_lru));
-	trace_nfsd_file_gc_removed(ret, list_lru_count(&nfsd_file_lru));
-	nfsd_file_dispose_list_delayed(&dispose);
 }
=20
 static void
-nfsd_file_gc_worker(struct work_struct *work)
+nfsd_file_gc_worker(struct timer_list *t)
 {
-	nfsd_file_gc();
-	if (list_lru_count(&nfsd_file_lru))
-		nfsd_file_schedule_laundrette();
+	struct nfsd_fcache_disposal *l =3D container_of(
+		t, struct nfsd_fcache_disposal, timer);
+	bool wakeup =3D false;
+
+	spin_lock_bh(&l->lock);
+	list_splice_init(&l->older, &l->freeme);
+	list_splice_init(&l->recent, &l->older);
+	/* We don't know how many were moved to 'freeme' and don't want
+	 * to waste time counting - guess a half.
+	 */
+	l->num_gc /=3D 2;
+	if (!list_empty(&l->freeme))
+		wakeup =3D true;
+	if (!list_empty(&l->older) || !list_empty(&l->recent))
+		mod_timer(t, jiffies + NFSD_LAUNDRETTE_DELAY);
+	spin_unlock_bh(&l->lock);
+	if (wakeup)
+		svc_wake_up(l->nn->nfsd_serv);
 }
=20
 static unsigned long
 nfsd_file_lru_count(struct shrinker *s, struct shrink_control *sc)
 {
-	return list_lru_count(&nfsd_file_lru);
+	struct nfsd_fcache_disposal *l =3D s->private_data;
+	return l->num_gc;
 }
=20
 static unsigned long
 nfsd_file_lru_scan(struct shrinker *s, struct shrink_control *sc)
 {
-	LIST_HEAD(dispose);
-	unsigned long ret;
+	struct nfsd_fcache_disposal *l =3D s->private_data;
+	struct nfsd_file *nf;
+	int scanned =3D 0;
+
+	spin_lock_bh(&l->lock);
+	while (scanned < sc->nr_to_scan &&
+	       (nf =3D list_first_entry_or_null(&l->older,
+					      struct nfsd_file, nf_lru)) !=3D NULL) {
+		list_del_init(&nf->nf_lru);
+		list_add_tail(&nf->nf_lru, &l->freeme);
+		if (l->num_gc > 0)
+			l->num_gc -=3D 1;
+		scanned +=3D 1;
+	}
+	if (scanned > 0)
+		svc_wake_up(l->nn->nfsd_serv);
+
+	while (scanned < sc->nr_to_scan &&
+	       (nf =3D list_first_entry_or_null(&l->recent,
+					      struct nfsd_file, nf_lru)) !=3D NULL) {
+		list_del_init(&nf->nf_lru);
+		list_add_tail(&nf->nf_lru, &l->older);
+		scanned +=3D 1;
+	}
+	spin_unlock_bh(&l->lock);
=20
-	ret =3D list_lru_shrink_walk(&nfsd_file_lru, sc,
-				   nfsd_file_lru_cb, &dispose);
-	trace_nfsd_file_shrinker_removed(ret, list_lru_count(&nfsd_file_lru));
-	nfsd_file_dispose_list_delayed(&dispose);
-	return ret;
+	trace_nfsd_file_shrinker_removed(scanned, l->num_gc);
+	return scanned;
 }
=20
-static struct shrinker *nfsd_file_shrinker;
-
 /**
  * nfsd_file_cond_queue - conditionally unhash and queue a nfsd_file
  * @nf: nfsd_file to attempt to queue
@@ -589,7 +608,6 @@ static struct shrinker *nfsd_file_shrinker;
  */
 static void
 nfsd_file_cond_queue(struct nfsd_file *nf, struct list_head *dispose)
-	__must_hold(RCU)
 {
 	int decrement =3D 1;
=20
@@ -607,7 +625,7 @@ nfsd_file_cond_queue(struct nfsd_file *nf, struct list_he=
ad *dispose)
=20
 	/* If refcount goes to 0, then put on the dispose list */
 	if (refcount_sub_and_test(decrement, &nf->nf_ref)) {
-		list_add(&nf->nf_gc, dispose);
+		list_add(&nf->nf_lru, dispose);
 		trace_nfsd_file_closing(nf);
 	}
 }
@@ -676,17 +694,12 @@ nfsd_file_close_inode(struct inode *inode)
 void
 nfsd_file_close_inode_sync(struct inode *inode)
 {
-	struct nfsd_file *nf;
 	LIST_HEAD(dispose);
=20
 	trace_nfsd_file_close(inode);
=20
 	nfsd_file_queue_for_close(inode, &dispose);
-	while (!list_empty(&dispose)) {
-		nf =3D list_first_entry(&dispose, struct nfsd_file, nf_gc);
-		list_del_init(&nf->nf_gc);
-		nfsd_file_free(nf);
-	}
+	nfsd_file_dispose_list(&dispose);
 }
=20
 static int
@@ -763,29 +776,10 @@ nfsd_file_cache_init(void)
 		goto out_err;
 	}
=20
-	ret =3D list_lru_init(&nfsd_file_lru);
-	if (ret) {
-		pr_err("nfsd: failed to init nfsd_file_lru: %d\n", ret);
-		goto out_err;
-	}
-
-	nfsd_file_shrinker =3D shrinker_alloc(0, "nfsd-filecache");
-	if (!nfsd_file_shrinker) {
-		ret =3D -ENOMEM;
-		pr_err("nfsd: failed to allocate nfsd_file_shrinker\n");
-		goto out_lru;
-	}
-
-	nfsd_file_shrinker->count_objects =3D nfsd_file_lru_count;
-	nfsd_file_shrinker->scan_objects =3D nfsd_file_lru_scan;
-	nfsd_file_shrinker->seeks =3D 1;
-
-	shrinker_register(nfsd_file_shrinker);
-
 	ret =3D lease_register_notifier(&nfsd_file_lease_notifier);
 	if (ret) {
 		pr_err("nfsd: unable to register lease notifier: %d\n", ret);
-		goto out_shrinker;
+		goto out_err;
 	}
=20
 	nfsd_file_fsnotify_group =3D fsnotify_alloc_group(&nfsd_file_fsnotify_ops,
@@ -798,17 +792,12 @@ nfsd_file_cache_init(void)
 		goto out_notifier;
 	}
=20
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
 	nfsd_file_slab =3D NULL;
@@ -860,14 +849,38 @@ nfsd_alloc_fcache_disposal(void)
 	if (!l)
 		return NULL;
 	spin_lock_init(&l->lock);
+	timer_setup(&l->timer, nfsd_file_gc_worker, 0);
+	INIT_LIST_HEAD(&l->recent);
+	INIT_LIST_HEAD(&l->older);
 	INIT_LIST_HEAD(&l->freeme);
+	l->num_gc =3D 0;
+	l->file_shrinker =3D shrinker_alloc(0, "nfsd-filecache");
+	if (!l->file_shrinker) {
+		pr_err("nfsd: failed to allocate nfsd_file_shrinker\n");
+		kfree(l);
+		return NULL;
+	}
+	l->file_shrinker->count_objects =3D nfsd_file_lru_count;
+	l->file_shrinker->scan_objects =3D nfsd_file_lru_scan;
+	l->file_shrinker->seeks =3D 1;
+	l->file_shrinker->private_data =3D l;
+
+	shrinker_register(l->file_shrinker);
+
 	return l;
 }
=20
 static void
 nfsd_free_fcache_disposal(struct nfsd_fcache_disposal *l)
 {
-	nfsd_file_dispose_list(&l->freeme);
+	del_timer_sync(&l->timer);
+	shrinker_free(l->file_shrinker);
+	nfsd_file_release_list(&l->recent);
+	WARN_ON_ONCE(!list_empty(&l->recent));
+	nfsd_file_release_list(&l->older);
+	WARN_ON_ONCE(!list_empty(&l->older));
+	nfsd_file_release_list(&l->freeme);
+	WARN_ON_ONCE(!list_empty(&l->freeme));
 	kfree(l);
 }
=20
@@ -886,6 +899,8 @@ nfsd_file_cache_start_net(struct net *net)
 	struct nfsd_net *nn =3D net_generic(net, nfsd_net_id);
=20
 	nn->fcache_disposal =3D nfsd_alloc_fcache_disposal();
+	if (nn->fcache_disposal)
+		nn->fcache_disposal->nn =3D nn;
 	return nn->fcache_disposal ? 0 : -ENOMEM;
 }
=20
@@ -919,14 +934,7 @@ nfsd_file_cache_shutdown(void)
 		return;
=20
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
 	nfsd_file_fsnotify_group =3D NULL;
@@ -1297,7 +1305,7 @@ int nfsd_file_cache_stats_show(struct seq_file *m, void=
 *v)
 		struct bucket_table *tbl;
 		struct rhashtable *ht;
=20
-		lru =3D list_lru_count(&nfsd_file_lru);
+		lru =3D atomic_long_read(&nfsd_lru_total);
=20
 		rcu_read_lock();
 		ht =3D &nfsd_file_rhltable.ht;
diff --git a/fs/nfsd/filecache.h b/fs/nfsd/filecache.h
index d5db6b34ba30..d88ae287c01f 100644
--- a/fs/nfsd/filecache.h
+++ b/fs/nfsd/filecache.h
@@ -36,15 +36,13 @@ struct nfsd_file {
 	struct net		*nf_net;
 #define NFSD_FILE_HASHED	(0)
 #define NFSD_FILE_PENDING	(1)
-#define NFSD_FILE_REFERENCED	(2)
-#define NFSD_FILE_GC		(3)
+#define NFSD_FILE_GC		(2)
 	unsigned long		nf_flags;
 	refcount_t		nf_ref;
 	unsigned char		nf_may;
=20
 	struct nfsd_file_mark	*nf_mark;
 	struct list_head	nf_lru;
-	struct list_head	nf_gc;
 	struct rcu_head		nf_rcu;
 	ktime_t			nf_birthtime;
 };
diff --git a/fs/nfsd/trace.h b/fs/nfsd/trace.h
index ad2c0c432d08..a266f1f21adc 100644
--- a/fs/nfsd/trace.h
+++ b/fs/nfsd/trace.h
@@ -1038,7 +1038,6 @@ DEFINE_CLID_EVENT(confirmed_r);
 	__print_flags(val, "|",						\
 		{ 1 << NFSD_FILE_HASHED,	"HASHED" },		\
 		{ 1 << NFSD_FILE_PENDING,	"PENDING" },		\
-		{ 1 << NFSD_FILE_REFERENCED,	"REFERENCED" },		\
 		{ 1 << NFSD_FILE_GC,		"GC" })
=20
 DECLARE_EVENT_CLASS(nfsd_file_class,

base-commit: 5e5a0681df5068efbd000dcfcbc34ae064fda1cc
--=20
2.47.1



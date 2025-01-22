Return-Path: <linux-nfs+bounces-9454-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B02DA18AD9
	for <lists+linux-nfs@lfdr.de>; Wed, 22 Jan 2025 04:57:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 804BA168E1D
	for <lists+linux-nfs@lfdr.de>; Wed, 22 Jan 2025 03:57:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C7371FAA;
	Wed, 22 Jan 2025 03:56:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="KS4KYsbo";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="9Lz6qvud";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="KS4KYsbo";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="9Lz6qvud"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E33A136351
	for <linux-nfs@vger.kernel.org>; Wed, 22 Jan 2025 03:56:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737518218; cv=none; b=kw5/LB0EqqlYMIb5paMsyw1/QKZruKZXwznN7La/9MAX0Z1KlomungIV2rJgbKagsKh/6sxRiNbBvszznhazzOIU1+5wgLC9C7GirH2OkZnrqmlHUt5atEvqaxnMwb/l5YTAQlVnD3BijFkL4onzMNYt05rEZUVFJQxulk431Yc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737518218; c=relaxed/simple;
	bh=IokhloFnkI92sgyRF+U2BWQ7i67xXC+oPo5UCOsuPWI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BFNHgtfQEJo3jy9hqW6rEV5TMEadbIVeBgNWlOm+T3g3bFoWOpHY+M9LEcXgF9bUWwx47VzSFKlpFU8C3nzanUSiStnSBQNB11uZYAjiCtl9avUjLYAwwmQQxHzBmHziDZ4aW4PmB+3Xp2x5r/Tc5uAxhj9LACCpvfeSZneQCgY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=KS4KYsbo; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=9Lz6qvud; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=KS4KYsbo; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=9Lz6qvud; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 4F9B51F78B;
	Wed, 22 Jan 2025 03:56:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1737518214; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8uVay4fGgM4OZOk5+Qe9+fWwD8YbQsLc/BQNvDw9Ie4=;
	b=KS4KYsbocR2G6ed7G8S0e6LfQV7knOutTK5C77/E7gjjpF5ZAf9GL6GS7Y7hSq0H6Cf6lE
	Apo256pJleaWsjo5NZ/pLXo5Fiz4fSNLWWipu66uClhluzqaRgAHbWL96cvMd7ZQfDNcHs
	5IVwNEK7il064zwybaDJygi0K+dRnT4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1737518214;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8uVay4fGgM4OZOk5+Qe9+fWwD8YbQsLc/BQNvDw9Ie4=;
	b=9Lz6qvud/y+qwFpIuezoRCWGJcpl8p1da6XxmfC4VNVRR1/oGRtxM61KBPvv6u3JAZIvzh
	Ral93jvBuMR3/WCQ==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=KS4KYsbo;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=9Lz6qvud
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1737518214; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8uVay4fGgM4OZOk5+Qe9+fWwD8YbQsLc/BQNvDw9Ie4=;
	b=KS4KYsbocR2G6ed7G8S0e6LfQV7knOutTK5C77/E7gjjpF5ZAf9GL6GS7Y7hSq0H6Cf6lE
	Apo256pJleaWsjo5NZ/pLXo5Fiz4fSNLWWipu66uClhluzqaRgAHbWL96cvMd7ZQfDNcHs
	5IVwNEK7il064zwybaDJygi0K+dRnT4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1737518214;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8uVay4fGgM4OZOk5+Qe9+fWwD8YbQsLc/BQNvDw9Ie4=;
	b=9Lz6qvud/y+qwFpIuezoRCWGJcpl8p1da6XxmfC4VNVRR1/oGRtxM61KBPvv6u3JAZIvzh
	Ral93jvBuMR3/WCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D96B7136A1;
	Wed, 22 Jan 2025 03:56:51 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id yVIPI4NskGeyXgAAD6G6ig
	(envelope-from <neilb@suse.de>); Wed, 22 Jan 2025 03:56:51 +0000
From: NeilBrown <neilb@suse.de>
To: Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>
Cc: linux-nfs@vger.kernel.org,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <Dai.Ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>
Subject: [PATCH 3/4] nfsd: filecache: change garbage collection list management.
Date: Wed, 22 Jan 2025 14:54:09 +1100
Message-ID: <20250122035615.2893754-4-neilb@suse.de>
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
X-Rspamd-Queue-Id: 4F9B51F78B
X-Spam-Score: -3.01
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:25478, ipnet:::/0, country:RU];
	MIME_TRACE(0.00)[0:+];
	R_RATELIMIT(0.00)[from(RLewrxuus8mos16izbn)];
	TO_DN_SOME(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	ARC_NA(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

The nfsd filecache currently uses  list_lru for tracking files recently
used in NFSv3 requests which need to be "garbage collected" when they
have becoming idle - unused for 2-4 seconds.

I do not believe list_lru is a good tool for this.  It does not allow the
timeout which filecache requires so we have to add a timeout mechanism
which holds the list_lru lock while the whole list is scanned looking for
entries that haven't been recently accessed.  When the list is largish
(even a few hundred) this can block new requests which need the lock to
remove a file to access it.

This patch removes the list_lru and instead uses 2 simple linked lists.
When a file is accessed it is removed from whichever list it is on,
then added to the tail of the first list.  Every 2 seconds the second
list is moved to the "freeme" list and the first list is moved to the
second list.  This avoids any need to walk a list to find old entries.

Previously a file would be unhashed before being moved to the freeme
list.  We don't do that any more.  The freeme list is much like the
other two lists (recent and older) in that they all hold a reference to
the file and the file is still hashed.  When the nfsd thread processes
the freeme list it now uses the new nfsd_file_release_list() which uses
nfsd_file_cond_queue() to unhash and drop the refcount.

We no longer have a precise count of the size of the lru (recent +
older) as we don't know how big "older" is when it is moved to "freeme".
However the shrinker can cope with an approximation.  So we keep a
count of number in the lru and when "older" is moved to "freeme" we
divide that count by 2.  When we remove anything from the lru we
decrement that counter but ensure it never goes negative.  Naturally
when we add to the lru we increase the counter.

For the filecache stats file, which assumes a global lru, we keep a
separate counter which includes all files in all netns in recent or
older or freeme.

We discard the nf_gc linkage in an nfsd_file and only use nf_lru.
We discard NFSD_FILE_REFERENCED.

This patch drops the nfsd_file_gc_removed() trace point.  I couldn't
think of useful information to provide.

Signed-off-by: NeilBrown <neilb@suse.de>
---
 fs/nfsd/filecache.c | 215 ++++++++++++++++++++++----------------------
 fs/nfsd/filecache.h |   4 +-
 fs/nfsd/trace.h     |   4 -
 3 files changed, 108 insertions(+), 115 deletions(-)

diff --git a/fs/nfsd/filecache.c b/fs/nfsd/filecache.c
index 4f39f6632b35..552feba94f09 100644
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
@@ -63,10 +62,13 @@ static DEFINE_PER_CPU(unsigned long, nfsd_file_evictions);
 
 struct nfsd_fcache_disposal {
 	spinlock_t lock;
-	struct list_lru file_lru;
-	struct list_head freeme;
+	struct list_head recent; /* have been used in last 0-2 seconds */
+	struct list_head older;	/* haven't been used in last 0-2 seconds */
+	struct list_head freeme; /* ready to be discarded */
+	unsigned long num_gc; /* Approximate size of recent plus older */
 	struct delayed_work filecache_laundrette;
 	struct shrinker *file_shrinker;
+	struct nfsd_net *nn;
 };
 
 static struct kmem_cache		*nfsd_file_slab;
@@ -227,7 +229,6 @@ nfsd_file_alloc(struct net *net, struct inode *inode, unsigned char need,
 
 	this_cpu_inc(nfsd_file_allocations);
 	INIT_LIST_HEAD(&nf->nf_lru);
-	INIT_LIST_HEAD(&nf->nf_gc);
 	nf->nf_birthtime = ktime_get();
 	nf->nf_file = NULL;
 	nf->nf_cred = get_current_cred();
@@ -332,12 +333,16 @@ static bool nfsd_file_lru_add(struct nfsd_file *nf)
 	struct nfsd_net *nn = net_generic(nf->nf_net, nfsd_net_id);
 	struct nfsd_fcache_disposal *l = nn->fcache_disposal;
 
-	set_bit(NFSD_FILE_REFERENCED, &nf->nf_flags);
-	if (list_lru_add_obj(&l->file_lru, &nf->nf_lru)) {
+	spin_lock(&l->lock);
+	if (list_empty(&nf->nf_lru)) {
+		list_add_tail(&nf->nf_lru, &l->recent);
+		l->num_gc += 1;
 		atomic_long_inc(&nfsd_lru_total);
 		trace_nfsd_file_lru_add(nf);
+		spin_unlock(&l->lock);
 		return true;
 	}
+	spin_unlock(&l->lock);
 	return false;
 }
 
@@ -346,11 +351,17 @@ static bool nfsd_file_lru_remove(struct nfsd_file *nf)
 	struct nfsd_net *nn = net_generic(nf->nf_net, nfsd_net_id);
 	struct nfsd_fcache_disposal *l = nn->fcache_disposal;
 
-	if (list_lru_del_obj(&l->file_lru, &nf->nf_lru)) {
+	spin_lock(&l->lock);
+	if (!list_empty(&nf->nf_lru)) {
+		list_del_init(&nf->nf_lru);
 		atomic_long_dec(&nfsd_lru_total);
+		if (l->num_gc > 0)
+			l->num_gc -= 1;
 		trace_nfsd_file_lru_del(nf);
+		spin_unlock(&l->lock);
 		return true;
 	}
+	spin_unlock(&l->lock);
 	return false;
 }
 
@@ -440,12 +451,26 @@ nfsd_file_dispose_list(struct list_head *dispose)
 	struct nfsd_file *nf;
 
 	while (!list_empty(dispose)) {
-		nf = list_first_entry(dispose, struct nfsd_file, nf_gc);
-		list_del_init(&nf->nf_gc);
+		nf = list_first_entry(dispose, struct nfsd_file, nf_lru);
+		list_del_init(&nf->nf_lru);
 		nfsd_file_free(nf);
 	}
 }
 
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
  * nfsd_file_dispose_list_delayed - move list of dead files to net's freeme list
  * @dispose: list of nfsd_files to be disposed
@@ -458,12 +483,12 @@ nfsd_file_dispose_list_delayed(struct list_head *dispose)
 {
 	while(!list_empty(dispose)) {
 		struct nfsd_file *nf = list_first_entry(dispose,
-						struct nfsd_file, nf_gc);
+						struct nfsd_file, nf_lru);
 		struct nfsd_net *nn = net_generic(nf->nf_net, nfsd_net_id);
 		struct nfsd_fcache_disposal *l = nn->fcache_disposal;
 
 		spin_lock(&l->lock);
-		list_move_tail(&nf->nf_gc, &l->freeme);
+		list_move_tail(&nf->nf_lru, &l->freeme);
 		spin_unlock(&l->lock);
 		svc_wake_up(nn->nfsd_serv);
 	}
@@ -487,88 +512,32 @@ void nfsd_file_net_dispose(struct nfsd_net *nn)
 		int i;
 
 		spin_lock(&l->lock);
-		for (i = 0; i < 8 && !list_empty(&l->freeme); i++)
-			list_move(l->freeme.next, &dispose);
+		for (i = 0; i < 8 && !list_empty(&l->freeme); i++) {
+			struct nfsd_file *nf = list_first_entry(
+				&l->freeme, struct nfsd_file, nf_lru);
+
+			/*
+			 * Don't throw out files that are still
+			 * undergoing I/O or that have uncleared errors
+			 * pending.
+			 */
+			if (nfsd_file_check_writeback(nf)) {
+				trace_nfsd_file_gc_writeback(nf);
+				list_move(&nf->nf_lru, &l->recent);
+				l->num_gc += 1;
+			} else {
+				trace_nfsd_file_gc_disposed(nf);
+				list_move(&nf->nf_lru, &dispose);
+				this_cpu_inc(nfsd_file_evictions);
+			}
+		}
 		spin_unlock(&l->lock);
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
-	struct list_head *head = arg;
-	struct nfsd_file *nf = list_entry(item, struct nfsd_file, nf_lru);
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
-	}
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
-nfsd_file_gc(struct nfsd_fcache_disposal *l)
-{
-	unsigned long remaining = list_lru_count(&l->file_lru);
-	LIST_HEAD(dispose);
-	unsigned long ret;
-
-	while (remaining > 0) {
-		unsigned long num_to_scan = min(remaining, NFSD_FILE_GC_BATCH);
-
-		ret = list_lru_walk(&l->file_lru, nfsd_file_lru_cb,
-				    &dispose, num_to_scan);
-		trace_nfsd_file_gc_removed(ret, list_lru_count(&l->file_lru));
-		nfsd_file_dispose_list_delayed(&dispose);
-		remaining -= num_to_scan;
+		nfsd_file_release_list(&dispose);
 	}
 }
 
@@ -577,9 +546,20 @@ nfsd_file_gc_worker(struct work_struct *work)
 {
 	struct nfsd_fcache_disposal *l = container_of(
 		work, struct nfsd_fcache_disposal, filecache_laundrette.work);
-	nfsd_file_gc(l);
-	if (list_lru_count(&l->file_lru))
+
+	spin_lock(&l->lock);
+	list_splice_init(&l->older, &l->freeme);
+	list_splice_init(&l->recent, &l->older);
+	/* We don't know how many were moved to 'freeme' and don't want
+	 * to waste time counting - guess a half.
+	 */
+	l->num_gc /= 2;
+	if (!list_empty(&l->freeme))
+		svc_wake_up(l->nn->nfsd_serv);
+	if (!list_empty(&l->older) || !list_empty(&l->recent))
 		nfsd_file_schedule_laundrette(l);
+	spin_unlock(&l->lock);
+
 }
 
 static unsigned long
@@ -587,22 +567,40 @@ nfsd_file_lru_count(struct shrinker *s, struct shrink_control *sc)
 {
 	struct nfsd_fcache_disposal *l = s->private_data;
 
-	return list_lru_count(&l->file_lru);
+	return l->num_gc;
 }
 
 static unsigned long
 nfsd_file_lru_scan(struct shrinker *s, struct shrink_control *sc)
 {
 	struct nfsd_fcache_disposal *l = s->private_data;
+	struct nfsd_file *nf;
+	int scanned = 0;
+
+	spin_lock(&l->lock);
+	while (scanned < sc->nr_to_scan &&
+	       (nf = list_first_entry_or_null(&l->older,
+					      struct nfsd_file, nf_lru)) != NULL) {
+		list_del_init(&nf->nf_lru);
+		list_add_tail(&nf->nf_lru, &l->freeme);
+		if (l->num_gc > 0)
+			l->num_gc -= 1;
+		scanned += 1;
+	}
+	if (scanned > 0)
+		svc_wake_up(l->nn->nfsd_serv);
 
-	LIST_HEAD(dispose);
-	unsigned long ret;
+	trace_nfsd_file_shrinker_removed(scanned, l->num_gc);
 
-	ret = list_lru_shrink_walk(&l->file_lru, sc,
-				   nfsd_file_lru_cb, &dispose);
-	trace_nfsd_file_shrinker_removed(ret, list_lru_count(&l->file_lru));
-	nfsd_file_dispose_list_delayed(&dispose);
-	return ret;
+	while (scanned < sc->nr_to_scan &&
+	       (nf = list_first_entry_or_null(&l->recent,
+					      struct nfsd_file, nf_lru)) != NULL) {
+		list_del_init(&nf->nf_lru);
+		list_add_tail(&nf->nf_lru, &l->older);
+		scanned += 1;
+	}
+	spin_unlock(&l->lock);
+	return scanned;
 }
 
 /**
@@ -615,7 +613,6 @@ nfsd_file_lru_scan(struct shrinker *s, struct shrink_control *sc)
  */
 static void
 nfsd_file_cond_queue(struct nfsd_file *nf, struct list_head *dispose)
-	__must_hold(RCU)
 {
 	int decrement = 1;
 
@@ -633,7 +630,7 @@ nfsd_file_cond_queue(struct nfsd_file *nf, struct list_head *dispose)
 
 	/* If refcount goes to 0, then put on the dispose list */
 	if (refcount_sub_and_test(decrement, &nf->nf_ref)) {
-		list_add(&nf->nf_gc, dispose);
+		list_add(&nf->nf_lru, dispose);
 		trace_nfsd_file_closing(nf);
 	}
 }
@@ -858,7 +855,10 @@ nfsd_alloc_fcache_disposal(void)
 		return NULL;
 	spin_lock_init(&l->lock);
 	INIT_DELAYED_WORK(&l->filecache_laundrette, nfsd_file_gc_worker);
+	INIT_LIST_HEAD(&l->recent);
+	INIT_LIST_HEAD(&l->older);
 	INIT_LIST_HEAD(&l->freeme);
+	l->num_gc = 0;
 	l->file_shrinker = shrinker_alloc(0, "nfsd-filecache");
 	if (!l->file_shrinker) {
 		pr_err("nfsd: failed to allocate nfsd_file_shrinker\n");
@@ -870,13 +870,6 @@ nfsd_alloc_fcache_disposal(void)
 	l->file_shrinker->seeks = 1;
 	l->file_shrinker->private_data = l;
 
-	if (list_lru_init(&l->file_lru)) {
-		pr_err("nfsd: failed to init nfsd_file_lru\n");
-		shrinker_free(l->file_shrinker);
-		kfree(l);
-		return NULL;
-	}
-
 	shrinker_register(l->file_shrinker);
 	return l;
 }
@@ -886,8 +879,12 @@ nfsd_free_fcache_disposal(struct nfsd_fcache_disposal *l)
 {
 	cancel_delayed_work_sync(&l->filecache_laundrette);
 	shrinker_free(l->file_shrinker);
-	list_lru_destroy(&l->file_lru);
-	nfsd_file_dispose_list(&l->freeme);
+	nfsd_file_release_list(&l->recent);
+	WARN_ON_ONCE(!list_empty(&l->recent));
+	nfsd_file_release_list(&l->older);
+	WARN_ON_ONCE(!list_empty(&l->older));
+	nfsd_file_release_list(&l->freeme);
+	WARN_ON_ONCE(!list_empty(&l->freeme));
 	kfree(l);
 }
 
@@ -906,6 +903,8 @@ nfsd_file_cache_start_net(struct net *net)
 	struct nfsd_net *nn = net_generic(net, nfsd_net_id);
 
 	nn->fcache_disposal = nfsd_alloc_fcache_disposal();
+	if (nn->fcache_disposal)
+		nn->fcache_disposal->nn = nn;
 	return nn->fcache_disposal ? 0 : -ENOMEM;
 }
 
diff --git a/fs/nfsd/filecache.h b/fs/nfsd/filecache.h
index a09a851d510e..02059b6c5e9a 100644
--- a/fs/nfsd/filecache.h
+++ b/fs/nfsd/filecache.h
@@ -42,15 +42,13 @@ struct nfsd_file {
 	struct net		*nf_net;
 #define NFSD_FILE_HASHED	(0)
 #define NFSD_FILE_PENDING	(1)
-#define NFSD_FILE_REFERENCED	(2)
-#define NFSD_FILE_GC		(3)
+#define NFSD_FILE_GC		(2)
 	unsigned long		nf_flags;
 	refcount_t		nf_ref;
 	unsigned char		nf_may;
 
 	struct nfsd_file_mark	*nf_mark;
 	struct list_head	nf_lru;
-	struct list_head	nf_gc;
 	struct rcu_head		nf_rcu;
 	ktime_t			nf_birthtime;
 };
diff --git a/fs/nfsd/trace.h b/fs/nfsd/trace.h
index ad2c0c432d08..efa683541ed5 100644
--- a/fs/nfsd/trace.h
+++ b/fs/nfsd/trace.h
@@ -1038,7 +1038,6 @@ DEFINE_CLID_EVENT(confirmed_r);
 	__print_flags(val, "|",						\
 		{ 1 << NFSD_FILE_HASHED,	"HASHED" },		\
 		{ 1 << NFSD_FILE_PENDING,	"PENDING" },		\
-		{ 1 << NFSD_FILE_REFERENCED,	"REFERENCED" },		\
 		{ 1 << NFSD_FILE_GC,		"GC" })
 
 DECLARE_EVENT_CLASS(nfsd_file_class,
@@ -1314,9 +1313,7 @@ DEFINE_NFSD_FILE_GC_EVENT(nfsd_file_lru_add);
 DEFINE_NFSD_FILE_GC_EVENT(nfsd_file_lru_add_disposed);
 DEFINE_NFSD_FILE_GC_EVENT(nfsd_file_lru_del);
 DEFINE_NFSD_FILE_GC_EVENT(nfsd_file_lru_del_disposed);
-DEFINE_NFSD_FILE_GC_EVENT(nfsd_file_gc_in_use);
 DEFINE_NFSD_FILE_GC_EVENT(nfsd_file_gc_writeback);
-DEFINE_NFSD_FILE_GC_EVENT(nfsd_file_gc_referenced);
 DEFINE_NFSD_FILE_GC_EVENT(nfsd_file_gc_disposed);
 
 DECLARE_EVENT_CLASS(nfsd_file_lruwalk_class,
@@ -1345,7 +1342,6 @@ DEFINE_EVENT(nfsd_file_lruwalk_class, name,				\
 	),								\
 	TP_ARGS(removed, remaining))
 
-DEFINE_NFSD_FILE_LRUWALK_EVENT(nfsd_file_gc_removed);
 DEFINE_NFSD_FILE_LRUWALK_EVENT(nfsd_file_shrinker_removed);
 
 TRACE_EVENT(nfsd_file_close,
-- 
2.47.1



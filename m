Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B82074643B4
	for <lists+linux-nfs@lfdr.de>; Wed,  1 Dec 2021 00:58:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345451AbhLAABk (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 30 Nov 2021 19:01:40 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:43790 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236395AbhLAABj (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 30 Nov 2021 19:01:39 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 6DA5E21763;
        Tue, 30 Nov 2021 23:58:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1638316698; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zZl/Sy/G9tMBVz674EeZm2CdvfURHnLkpCffWckKbAE=;
        b=oygaVtF5pm3ff3tSKcdqKD0LbCJDT7+TrR3cDTw8a14sEyTXRsmn6IHLDHbQPfkiO/hmcB
        q8yV6EITKYxTzzXQKB//e7Fbp+xaowtXu1cl4irWt65ucGsg3iyR+phjzfquvWtuJv0pET
        Y9xRGf6xvznuciIeGeq9XMHxIuOcP84=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1638316698;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zZl/Sy/G9tMBVz674EeZm2CdvfURHnLkpCffWckKbAE=;
        b=/UOaoiJo5aSVwxzh1ofrAbguH9nWyudtMbN8HC2xgAbacySMoxCtau+/1MVDVT/MPwACYG
        d9ByV/Pda1mdnqAA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 5DD5613D84;
        Tue, 30 Nov 2021 23:58:17 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id J9lqB5m6pmGhGgAAMHmgww
        (envelope-from <neilb@suse.de>); Tue, 30 Nov 2021 23:58:17 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
From:   "NeilBrown" <neilb@suse.de>
To:     paulmck@kernel.org, "Chuck Lever" <chuck.lever@oracle.com>
cc:     linux-nfs@vger.kernel.org
Subject: [PATCH/rfc] NFSD: simplify per-net file cache management
In-reply-to: <163831537509.26075.12859361728901873347@noble.neil.brown.name>
References: <163821156142.90770.4019362941494014139.stgit@bazille.1015granger.net>,
 <20211130225250.GC641268@paulmck-ThinkPad-P17-Gen-1>,
 <163831537509.26075.12859361728901873347@noble.neil.brown.name>
Date:   Wed, 01 Dec 2021 10:58:14 +1100
Message-id: <163831669455.26075.14420575954675785122@noble.neil.brown.name>
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org


We currently have a 'laundrette' for closing cached files - a different
work-item for each network-namespace.

These 'laundrettes' (aka struct nfsd_fcache_disposal) are currently on a
list, and are freed using rcu.

The list is not necessary as we have a per-namespace structure (struct
nfsd_net) which can hold a link to the nfsd_fcache_disposal.
The use of kfree_rcu is also unnecessary as the cache is cleaned of all
files associated with a given namespace, and no new files can be added,
before the nfsd_fcache_disposal is freed.

So add a '->fcache_disposal' link to nfsd_net, and discard the list
management and rcu usage.

Signed-off-by: NeilBrown <neilb@suse.de>
---

This patch compiles, but I haven't tested it.  It is a suggestion.

NeilBrown


 fs/nfsd/filecache.c | 76 +++++++++------------------------------------
 fs/nfsd/netns.h     |  2 ++
 2 files changed, 17 insertions(+), 61 deletions(-)

diff --git a/fs/nfsd/filecache.c b/fs/nfsd/filecache.c
index fdf89fcf1a0c..aa5dca498b27 100644
--- a/fs/nfsd/filecache.c
+++ b/fs/nfsd/filecache.c
@@ -44,12 +44,9 @@ struct nfsd_fcache_bucket {
 static DEFINE_PER_CPU(unsigned long, nfsd_file_cache_hits);
 
 struct nfsd_fcache_disposal {
-	struct list_head list;
 	struct work_struct work;
-	struct net *net;
 	spinlock_t lock;
 	struct list_head freeme;
-	struct rcu_head rcu;
 };
 
 static struct workqueue_struct *nfsd_filecache_wq __read_mostly;
@@ -62,8 +59,6 @@ static long				nfsd_file_lru_flags;
 static struct fsnotify_group		*nfsd_file_fsnotify_group;
 static atomic_long_t			nfsd_filecache_count;
 static struct delayed_work		nfsd_filecache_laundrette;
-static DEFINE_SPINLOCK(laundrette_lock);
-static LIST_HEAD(laundrettes);
 
 static void nfsd_file_gc(void);
 
@@ -367,19 +362,13 @@ nfsd_file_list_remove_disposal(struct list_head *dst,
 static void
 nfsd_file_list_add_disposal(struct list_head *files, struct net *net)
 {
-	struct nfsd_fcache_disposal *l;
+	struct nfsd_net *nn = net_generic(net, nfsd_net_id);
+	struct nfsd_fcache_disposal *l = nn->fcache_disposal;
 
-	rcu_read_lock();
-	list_for_each_entry_rcu(l, &laundrettes, list) {
-		if (l->net == net) {
-			spin_lock(&l->lock);
-			list_splice_tail_init(files, &l->freeme);
-			spin_unlock(&l->lock);
-			queue_work(nfsd_filecache_wq, &l->work);
-			break;
-		}
-	}
-	rcu_read_unlock();
+	spin_lock(&l->lock);
+	list_splice_tail_init(files, &l->freeme);
+	spin_unlock(&l->lock);
+	queue_work(nfsd_filecache_wq, &l->work);
 }
 
 static void
@@ -755,7 +744,7 @@ nfsd_file_cache_purge(struct net *net)
 }
 
 static struct nfsd_fcache_disposal *
-nfsd_alloc_fcache_disposal(struct net *net)
+nfsd_alloc_fcache_disposal(void)
 {
 	struct nfsd_fcache_disposal *l;
 
@@ -763,7 +752,6 @@ nfsd_alloc_fcache_disposal(struct net *net)
 	if (!l)
 		return NULL;
 	INIT_WORK(&l->work, nfsd_file_delayed_close);
-	l->net = net;
 	spin_lock_init(&l->lock);
 	INIT_LIST_HEAD(&l->freeme);
 	return l;
@@ -772,61 +760,27 @@ nfsd_alloc_fcache_disposal(struct net *net)
 static void
 nfsd_free_fcache_disposal(struct nfsd_fcache_disposal *l)
 {
-	rcu_assign_pointer(l->net, NULL);
 	cancel_work_sync(&l->work);
 	nfsd_file_dispose_list(&l->freeme);
-	kfree_rcu(l, rcu);
-}
-
-static void
-nfsd_add_fcache_disposal(struct nfsd_fcache_disposal *l)
-{
-	spin_lock(&laundrette_lock);
-	list_add_tail_rcu(&l->list, &laundrettes);
-	spin_unlock(&laundrette_lock);
-}
-
-static void
-nfsd_del_fcache_disposal(struct nfsd_fcache_disposal *l)
-{
-	spin_lock(&laundrette_lock);
-	list_del_rcu(&l->list);
-	spin_unlock(&laundrette_lock);
-}
-
-static int
-nfsd_alloc_fcache_disposal_net(struct net *net)
-{
-	struct nfsd_fcache_disposal *l;
-
-	l = nfsd_alloc_fcache_disposal(net);
-	if (!l)
-		return -ENOMEM;
-	nfsd_add_fcache_disposal(l);
-	return 0;
+	kfree(l);
 }
 
 static void
 nfsd_free_fcache_disposal_net(struct net *net)
 {
-	struct nfsd_fcache_disposal *l;
+	struct nfsd_net *nn = net_generic(net, nfsd_net_id);
+	struct nfsd_fcache_disposal *l = nn->fcache_disposal;
 
-	rcu_read_lock();
-	list_for_each_entry_rcu(l, &laundrettes, list) {
-		if (l->net != net)
-			continue;
-		nfsd_del_fcache_disposal(l);
-		rcu_read_unlock();
-		nfsd_free_fcache_disposal(l);
-		return;
-	}
-	rcu_read_unlock();
+	nfsd_free_fcache_disposal(l);
 }
 
 int
 nfsd_file_cache_start_net(struct net *net)
 {
-	return nfsd_alloc_fcache_disposal_net(net);
+	struct nfsd_net *nn = net_generic(net, nfsd_net_id);
+
+	nn->fcache_disposal = nfsd_alloc_fcache_disposal();
+	return nn->fcache_disposal ? 0 : -ENOMEM;
 }
 
 void
diff --git a/fs/nfsd/netns.h b/fs/nfsd/netns.h
index 021acdc0d03b..9e8b77d2a3a4 100644
--- a/fs/nfsd/netns.h
+++ b/fs/nfsd/netns.h
@@ -185,6 +185,8 @@ struct nfsd_net {
 
 	/* utsname taken from the process that starts the server */
 	char			nfsd_name[UNX_MAXNODENAME+1];
+
+	struct nfsd_fcache_disposal *fcache_disposal;
 };
 
 /* Simple check to find out if a given net was properly initialized */
-- 
2.34.1


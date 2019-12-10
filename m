Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 95EEE1191F4
	for <lists+linux-nfs@lfdr.de>; Tue, 10 Dec 2019 21:30:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726589AbfLJU3u (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 10 Dec 2019 15:29:50 -0500
Received: from mail-yb1-f193.google.com ([209.85.219.193]:46485 "EHLO
        mail-yb1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726879AbfLJU3t (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 10 Dec 2019 15:29:49 -0500
Received: by mail-yb1-f193.google.com with SMTP id v15so8129566ybp.13
        for <linux-nfs@vger.kernel.org>; Tue, 10 Dec 2019 12:29:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Ba0uzz6l8AKpkZYZrCYzKwmhXV5OyQbQtIoLGFI8Opk=;
        b=lLxkDuNL1XPPGbCSrUnxqnvlFZy7OwA7YtGbes8CrCKADlO8Vv1uM0t+TG1w4FIogh
         LkzvTu32mMpok8W0FwpOM0v2+XyUTR4AS5hhE0+iYXTTLVJTGLEOOolcoRppMbUgdcdp
         cm33xuNJqy6tpHVqML4uQXn4qlyzLuPN2fWqYZF7lTUx5cSKTcI0wcqK7dpbgH38i70J
         WvN2fK68K+6GEXbzjjogKTIY/9+/34w8YUUrjgN5ADt1NtVIaWFlhGX8bSchwJ3r6Hqg
         Uya/JRBzwFbgMggpx/owakguNiUM3HWJe0EkajGPCF1jezeKPsehoGSBMndOh6GDQ4cd
         uRCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Ba0uzz6l8AKpkZYZrCYzKwmhXV5OyQbQtIoLGFI8Opk=;
        b=czSzCgpFu3CXPiRNYdcjvu4u8fvsRzlQz7wIAQxog57gP7rBV2SN09zMGXlpK37P1t
         Aa9ibFoQitsP4cLZ+HNGoflE6noxFdsDyE1M8iann5MwXcQe4T5WJve+V8evUBtEKfRJ
         gXvXqvJrjzyeM9OGfmhgMK8aZtuLOYMM7T293PfLWmzvTy5sZfZx7pYYehnI2w8U7mkG
         WoojY/PFh3ERzymLS3iYo2X7FDZCjHYb9A05dkGt+Sgi2HvXFjWXihu7GaqgOHUKcdRd
         1nwXDw365eg1KxFPAgLWv4wQ9zrDe5ptLGzVjNAfsJCYJsdCMrcYp8N8hsTakq5rXfIq
         8A1g==
X-Gm-Message-State: APjAAAWrIvIx8KOvrQh148yfbReBOqsto3O/X+VH0FFAbcprD8c+W7hJ
        4f+cmqgpEvLX1dEohFtzvA==
X-Google-Smtp-Source: APXvYqyqb7LxxZMNvP7TpYbtinQQxgT45JTB0oTEnVcYaDF2WPmzmZ7LkPYeCwUXd3pXUAv4sihH8Q==
X-Received: by 2002:a25:3803:: with SMTP id f3mr25934062yba.144.1576009788063;
        Tue, 10 Dec 2019 12:29:48 -0800 (PST)
Received: from localhost.localdomain (c-68-40-189-247.hsd1.mi.comcast.net. [68.40.189.247])
        by smtp.gmail.com with ESMTPSA id x84sm1947508ywg.47.2019.12.10.12.29.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Dec 2019 12:29:47 -0800 (PST)
From:   Trond Myklebust <trondmy@gmail.com>
X-Google-Original-From: Trond Myklebust <trond.myklebust@hammerspace.com>
To:     "J. Bruce Fields" <bfields@fieldses.org>
Cc:     Chuck Lever <chuck.lever@oracle.com>, linux-nfs@vger.kernel.org
Subject: [PATCH 3/6] nfsd: Containerise filecache laundrette
Date:   Tue, 10 Dec 2019 15:27:32 -0500
Message-Id: <20191210202735.304477-4-trond.myklebust@hammerspace.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191210202735.304477-3-trond.myklebust@hammerspace.com>
References: <20191210202735.304477-1-trond.myklebust@hammerspace.com>
 <20191210202735.304477-2-trond.myklebust@hammerspace.com>
 <20191210202735.304477-3-trond.myklebust@hammerspace.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Ensure that if the filecache laundrette gets stuck, it only affects
the knfsd instances of one container.

The notifier callbacks can be called from various contexts so avoid
using synchonous filesystem operations that might deadlock.

Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 fs/nfsd/filecache.c | 238 ++++++++++++++++++++++++++++++++++++--------
 fs/nfsd/filecache.h |   2 +
 fs/nfsd/nfssvc.c    |   9 +-
 3 files changed, 207 insertions(+), 42 deletions(-)

diff --git a/fs/nfsd/filecache.c b/fs/nfsd/filecache.c
index c048e3071db7..e71af553c2ed 100644
--- a/fs/nfsd/filecache.c
+++ b/fs/nfsd/filecache.c
@@ -44,6 +44,17 @@ struct nfsd_fcache_bucket {
 
 static DEFINE_PER_CPU(unsigned long, nfsd_file_cache_hits);
 
+struct nfsd_fcache_disposal {
+	struct list_head list;
+	struct work_struct work;
+	struct net *net;
+	spinlock_t lock;
+	struct list_head freeme;
+	struct rcu_head rcu;
+};
+
+struct workqueue_struct *nfsd_filecache_wq __read_mostly;
+
 static struct kmem_cache		*nfsd_file_slab;
 static struct kmem_cache		*nfsd_file_mark_slab;
 static struct nfsd_fcache_bucket	*nfsd_file_hashtbl;
@@ -52,32 +63,21 @@ static long				nfsd_file_lru_flags;
 static struct fsnotify_group		*nfsd_file_fsnotify_group;
 static atomic_long_t			nfsd_filecache_count;
 static struct delayed_work		nfsd_filecache_laundrette;
+static DEFINE_SPINLOCK(laundrette_lock);
+static LIST_HEAD(laundrettes);
 
-enum nfsd_file_laundrette_ctl {
-	NFSD_FILE_LAUNDRETTE_NOFLUSH = 0,
-	NFSD_FILE_LAUNDRETTE_MAY_FLUSH
-};
+static void nfsd_file_gc(void);
 
 static void
-nfsd_file_schedule_laundrette(enum nfsd_file_laundrette_ctl ctl)
+nfsd_file_schedule_laundrette(void)
 {
 	long count = atomic_long_read(&nfsd_filecache_count);
 
 	if (count == 0 || test_bit(NFSD_FILE_SHUTDOWN, &nfsd_file_lru_flags))
 		return;
 
-	/* Be more aggressive about scanning if over the threshold */
-	if (count > NFSD_FILE_LRU_THRESHOLD)
-		mod_delayed_work(system_wq, &nfsd_filecache_laundrette, 0);
-	else
-		schedule_delayed_work(&nfsd_filecache_laundrette, NFSD_LAUNDRETTE_DELAY);
-
-	if (ctl == NFSD_FILE_LAUNDRETTE_NOFLUSH)
-		return;
-
-	/* ...and don't delay flushing if we're out of control */
-	if (count >= NFSD_FILE_LRU_LIMIT)
-		flush_delayed_work(&nfsd_filecache_laundrette);
+	queue_delayed_work(system_wq, &nfsd_filecache_laundrette,
+			NFSD_LAUNDRETTE_DELAY);
 }
 
 static void
@@ -312,7 +312,9 @@ nfsd_file_put(struct nfsd_file *nf)
 
 	set_bit(NFSD_FILE_REFERENCED, &nf->nf_flags);
 	if (nfsd_file_put_noref(nf) == 1 && is_hashed && unused)
-		nfsd_file_schedule_laundrette(NFSD_FILE_LAUNDRETTE_MAY_FLUSH);
+		nfsd_file_schedule_laundrette();
+	if (atomic_long_read(&nfsd_filecache_count) >= NFSD_FILE_LRU_LIMIT)
+		nfsd_file_gc();
 }
 
 struct nfsd_file *
@@ -353,6 +355,58 @@ nfsd_file_dispose_list_sync(struct list_head *dispose)
 		flush_delayed_fput();
 }
 
+static void
+nfsd_file_list_remove_disposal(struct list_head *dst,
+		struct nfsd_fcache_disposal *l)
+{
+	spin_lock(&l->lock);
+	list_splice_init(&l->freeme, dst);
+	spin_unlock(&l->lock);
+}
+
+static void
+nfsd_file_list_add_disposal(struct list_head *files, struct net *net)
+{
+	struct nfsd_fcache_disposal *l;
+
+	rcu_read_lock();
+	list_for_each_entry_rcu(l, &laundrettes, list) {
+		if (l->net == net) {
+			spin_lock(&l->lock);
+			list_splice_tail_init(files, &l->freeme);
+			spin_unlock(&l->lock);
+			queue_work(nfsd_filecache_wq, &l->work);
+			break;
+		}
+	}
+	rcu_read_unlock();
+}
+
+static void
+nfsd_file_list_add_pernet(struct list_head *dst, struct list_head *src,
+		struct net *net)
+{
+	struct nfsd_file *nf, *tmp;
+
+	list_for_each_entry_safe(nf, tmp, src, nf_lru) {
+		if (nf->nf_net == net)
+			list_move_tail(&nf->nf_lru, dst);
+	}
+}
+
+static void
+nfsd_file_dispose_list_delayed(struct list_head *dispose)
+{
+	LIST_HEAD(list);
+	struct nfsd_file *nf;
+
+	while(!list_empty(dispose)) {
+		nf = list_first_entry(dispose, struct nfsd_file, nf_lru);
+		nfsd_file_list_add_pernet(&list, dispose, nf->nf_net);
+		nfsd_file_list_add_disposal(&list, nf->nf_net);
+	}
+}
+
 /*
  * Note this can deadlock with nfsd_file_cache_purge.
  */
@@ -399,17 +453,40 @@ nfsd_file_lru_cb(struct list_head *item, struct list_lru_one *lru,
 	return LRU_SKIP;
 }
 
-static void
-nfsd_file_lru_dispose(struct list_head *head)
+static unsigned long
+nfsd_file_lru_walk_list(struct shrink_control *sc)
 {
+	LIST_HEAD(head);
 	struct nfsd_file *nf;
+	unsigned long ret;
 
-	list_for_each_entry(nf, head, nf_lru) {
+	if (sc)
+		ret = list_lru_shrink_walk(&nfsd_file_lru, sc,
+				nfsd_file_lru_cb, &head);
+	else
+		ret = list_lru_walk(&nfsd_file_lru,
+				nfsd_file_lru_cb,
+				&head, LONG_MAX);
+	list_for_each_entry(nf, &head, nf_lru) {
 		spin_lock(&nfsd_file_hashtbl[nf->nf_hashval].nfb_lock);
 		nfsd_file_do_unhash(nf);
 		spin_unlock(&nfsd_file_hashtbl[nf->nf_hashval].nfb_lock);
 	}
-	nfsd_file_dispose_list(head);
+	nfsd_file_dispose_list_delayed(&head);
+	return ret;
+}
+
+static void
+nfsd_file_gc(void)
+{
+	nfsd_file_lru_walk_list(NULL);
+}
+
+static void
+nfsd_file_gc_worker(struct work_struct *work)
+{
+	nfsd_file_gc();
+	nfsd_file_schedule_laundrette();
 }
 
 static unsigned long
@@ -421,12 +498,7 @@ nfsd_file_lru_count(struct shrinker *s, struct shrink_control *sc)
 static unsigned long
 nfsd_file_lru_scan(struct shrinker *s, struct shrink_control *sc)
 {
-	LIST_HEAD(head);
-	unsigned long ret;
-
-	ret = list_lru_shrink_walk(&nfsd_file_lru, sc, nfsd_file_lru_cb, &head);
-	nfsd_file_lru_dispose(&head);
-	return ret;
+	return nfsd_file_lru_walk_list(sc);
 }
 
 static struct shrinker	nfsd_file_shrinker = {
@@ -488,7 +560,7 @@ nfsd_file_close_inode(struct inode *inode)
 
 	__nfsd_file_close_inode(inode, hashval, &dispose);
 	trace_nfsd_file_close_inode(inode, hashval, !list_empty(&dispose));
-	nfsd_file_dispose_list(&dispose);
+	nfsd_file_dispose_list_delayed(&dispose);
 }
 
 /**
@@ -504,16 +576,11 @@ static void
 nfsd_file_delayed_close(struct work_struct *work)
 {
 	LIST_HEAD(head);
+	struct nfsd_fcache_disposal *l = container_of(work,
+			struct nfsd_fcache_disposal, work);
 
-	list_lru_walk(&nfsd_file_lru, nfsd_file_lru_cb, &head, LONG_MAX);
-
-	if (test_and_clear_bit(NFSD_FILE_LRU_RESCAN, &nfsd_file_lru_flags))
-		nfsd_file_schedule_laundrette(NFSD_FILE_LAUNDRETTE_NOFLUSH);
-
-	if (!list_empty(&head)) {
-		nfsd_file_lru_dispose(&head);
-		flush_delayed_fput();
-	}
+	nfsd_file_list_remove_disposal(&head, l);
+	nfsd_file_dispose_list(&head);
 }
 
 static int
@@ -574,6 +641,10 @@ nfsd_file_cache_init(void)
 	if (nfsd_file_hashtbl)
 		return 0;
 
+	nfsd_filecache_wq = alloc_workqueue("nfsd_filecache", 0, 0);
+	if (!nfsd_filecache_wq)
+		goto out;
+
 	nfsd_file_hashtbl = kcalloc(NFSD_FILE_HASH_SIZE,
 				sizeof(*nfsd_file_hashtbl), GFP_KERNEL);
 	if (!nfsd_file_hashtbl) {
@@ -627,7 +698,7 @@ nfsd_file_cache_init(void)
 		spin_lock_init(&nfsd_file_hashtbl[i].nfb_lock);
 	}
 
-	INIT_DELAYED_WORK(&nfsd_filecache_laundrette, nfsd_file_delayed_close);
+	INIT_DELAYED_WORK(&nfsd_filecache_laundrette, nfsd_file_gc_worker);
 out:
 	return ret;
 out_notifier:
@@ -643,6 +714,8 @@ nfsd_file_cache_init(void)
 	nfsd_file_mark_slab = NULL;
 	kfree(nfsd_file_hashtbl);
 	nfsd_file_hashtbl = NULL;
+	destroy_workqueue(nfsd_filecache_wq);
+	nfsd_filecache_wq = NULL;
 	goto out;
 }
 
@@ -681,6 +754,88 @@ nfsd_file_cache_purge(struct net *net)
 	}
 }
 
+static struct nfsd_fcache_disposal *
+nfsd_alloc_fcache_disposal(struct net *net)
+{
+	struct nfsd_fcache_disposal *l;
+
+	l = kmalloc(sizeof(*l), GFP_KERNEL);
+	if (!l)
+		return NULL;
+	INIT_WORK(&l->work, nfsd_file_delayed_close);
+	l->net = net;
+	spin_lock_init(&l->lock);
+	INIT_LIST_HEAD(&l->freeme);
+	return l;
+}
+
+static void
+nfsd_free_fcache_disposal(struct nfsd_fcache_disposal *l)
+{
+	rcu_assign_pointer(l->net, NULL);
+	cancel_work_sync(&l->work);
+	nfsd_file_dispose_list(&l->freeme);
+	kfree_rcu(l, rcu);
+}
+
+static void
+nfsd_add_fcache_disposal(struct nfsd_fcache_disposal *l)
+{
+	spin_lock(&laundrette_lock);
+	list_add_tail_rcu(&l->list, &laundrettes);
+	spin_unlock(&laundrette_lock);
+}
+
+static void
+nfsd_del_fcache_disposal(struct nfsd_fcache_disposal *l)
+{
+	spin_lock(&laundrette_lock);
+	list_del_rcu(&l->list);
+	spin_unlock(&laundrette_lock);
+}
+
+static int
+nfsd_alloc_fcache_disposal_net(struct net *net)
+{
+	struct nfsd_fcache_disposal *l;
+
+	l = nfsd_alloc_fcache_disposal(net);
+	if (!l)
+		return -ENOMEM;
+	nfsd_add_fcache_disposal(l);
+	return 0;
+}
+
+static void
+nfsd_free_fcache_disposal_net(struct net *net)
+{
+	struct nfsd_fcache_disposal *l;
+
+	rcu_read_lock();
+	list_for_each_entry_rcu(l, &laundrettes, list) {
+		if (l->net != net)
+			continue;
+		nfsd_del_fcache_disposal(l);
+		rcu_read_unlock();
+		nfsd_free_fcache_disposal(l);
+		return;
+	}
+	rcu_read_unlock();
+}
+
+int
+nfsd_file_cache_start_net(struct net *net)
+{
+	return nfsd_alloc_fcache_disposal_net(net);
+}
+
+void
+nfsd_file_cache_shutdown_net(struct net *net)
+{
+	nfsd_file_cache_purge(net);
+	nfsd_free_fcache_disposal_net(net);
+}
+
 void
 nfsd_file_cache_shutdown(void)
 {
@@ -705,6 +860,8 @@ nfsd_file_cache_shutdown(void)
 	nfsd_file_mark_slab = NULL;
 	kfree(nfsd_file_hashtbl);
 	nfsd_file_hashtbl = NULL;
+	destroy_workqueue(nfsd_filecache_wq);
+	nfsd_filecache_wq = NULL;
 }
 
 static bool
@@ -872,7 +1029,8 @@ nfsd_file_acquire(struct svc_rqst *rqstp, struct svc_fh *fhp,
 	nfsd_file_hashtbl[hashval].nfb_maxcount = max(nfsd_file_hashtbl[hashval].nfb_maxcount,
 			nfsd_file_hashtbl[hashval].nfb_count);
 	spin_unlock(&nfsd_file_hashtbl[hashval].nfb_lock);
-	atomic_long_inc(&nfsd_filecache_count);
+	if (atomic_long_inc_return(&nfsd_filecache_count) >= NFSD_FILE_LRU_THRESHOLD)
+		nfsd_file_gc();
 
 	nf->nf_mark = nfsd_file_mark_find_or_create(nf);
 	if (nf->nf_mark)
diff --git a/fs/nfsd/filecache.h b/fs/nfsd/filecache.h
index 851d9abf54c2..79a7d6808d97 100644
--- a/fs/nfsd/filecache.h
+++ b/fs/nfsd/filecache.h
@@ -51,6 +51,8 @@ struct nfsd_file {
 int nfsd_file_cache_init(void);
 void nfsd_file_cache_purge(struct net *);
 void nfsd_file_cache_shutdown(void);
+int nfsd_file_cache_start_net(struct net *net);
+void nfsd_file_cache_shutdown_net(struct net *net);
 void nfsd_file_put(struct nfsd_file *nf);
 struct nfsd_file *nfsd_file_get(struct nfsd_file *nf);
 void nfsd_file_close_inode_sync(struct inode *inode);
diff --git a/fs/nfsd/nfssvc.c b/fs/nfsd/nfssvc.c
index e8bee8ff30c5..dce7a8e2c1c5 100644
--- a/fs/nfsd/nfssvc.c
+++ b/fs/nfsd/nfssvc.c
@@ -394,13 +394,18 @@ static int nfsd_startup_net(int nrservs, struct net *net, const struct cred *cre
 		nn->lockd_up = 1;
 	}
 
-	ret = nfs4_state_start_net(net);
+	ret = nfsd_file_cache_start_net(net);
 	if (ret)
 		goto out_lockd;
+	ret = nfs4_state_start_net(net);
+	if (ret)
+		goto out_filecache;
 
 	nn->nfsd_net_up = true;
 	return 0;
 
+out_filecache:
+	nfsd_file_cache_shutdown_net(net);
 out_lockd:
 	if (nn->lockd_up) {
 		lockd_down(net);
@@ -415,7 +420,7 @@ static void nfsd_shutdown_net(struct net *net)
 {
 	struct nfsd_net *nn = net_generic(net, nfsd_net_id);
 
-	nfsd_file_cache_purge(net);
+	nfsd_file_cache_shutdown_net(net);
 	nfs4_state_shutdown_net(net);
 	if (nn->lockd_up) {
 		lockd_down(net);
-- 
2.23.0


Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 67658131764
	for <lists+linux-nfs@lfdr.de>; Mon,  6 Jan 2020 19:20:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726683AbgAFSU1 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 6 Jan 2020 13:20:27 -0500
Received: from mail-yb1-f194.google.com ([209.85.219.194]:41621 "EHLO
        mail-yb1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726569AbgAFSU1 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 6 Jan 2020 13:20:27 -0500
Received: by mail-yb1-f194.google.com with SMTP id k5so2949323ybf.8
        for <linux-nfs@vger.kernel.org>; Mon, 06 Jan 2020 10:20:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=MXI7TKmJZJi0CofkXvBvPSoItXOdOc5Wya7Tcn2EIOU=;
        b=FzTztk/6KAQPL2NrszJFO2Afl19DjLcd0P1H0n9g5/n5p8UPVFKhRUOoVYLHPTuHP2
         FSq7GsmW7/eW0665Ec4p3TdKqu32t+GRwoq3H8fA4/ywt6GexhtVem/NZldNxllk/RXE
         1Z40tkFxPETq5PGnLojs48VgwQzXrgtc5783RBafSEciaSEaLcFha1w2kda0GzdYuu0n
         aWZPN7ip+Ly0uwOXkfO8IZA5qI8Eb/mcv7ZzKrbMotRlZ61AqAH1rPgG1wOZrBGo2kdU
         N7UB+GTs36MjkgbLXd/9ZSBRv4Dn89wdp5wV1xASONJ20vNTv9QeXhaWYd1ng/e9p6sU
         jx1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=MXI7TKmJZJi0CofkXvBvPSoItXOdOc5Wya7Tcn2EIOU=;
        b=oEuOACAKwKQqt1cCXyivGq/jb1Bp7SckwIZ1wF7GnnMloOLNzvGpxsRgeHn/J15osa
         x5cnn06YHWJAyqBCdZPBH2rApmIbuYfc8zj4dma+Pi7nWuEOHep7WDiXVaAGqMShkOD3
         zNoMSuFAWzf0ThqDpv22t5i1F3j1uTzEj2h6/f8DW2nIMPjxCDwer4u0D1ZclLhMnQ8U
         BHeT7FFNFXya9BHysC4Z/ERZvZcQ4156cUILDDBdiel+XKj8Dn40WRPwJ17T4MF20k+w
         09AEWQKzr90CXl6ZgZJwS6oD9WyqBPQJ800xORZya67CwSVsJT9PMZ3EzbbhLaI0xj+v
         ilMw==
X-Gm-Message-State: APjAAAXZxQRCwn705ZA7CgEjRoBL2L+l619/zvguqblxpPAKazY9LBbn
        2iEdDRe4BXlfamdyJapgPA==
X-Google-Smtp-Source: APXvYqyPl6FpenZwRuOI1Klu9fr61vA9hYMR0bup9UCU49l4zNVylWTgcVgQPRIDiDPg/n8aVR3tmA==
X-Received: by 2002:a25:dc52:: with SMTP id y79mr69086892ybe.354.1578334825710;
        Mon, 06 Jan 2020 10:20:25 -0800 (PST)
Received: from localhost.localdomain (c-68-40-189-247.hsd1.mi.comcast.net. [68.40.189.247])
        by smtp.gmail.com with ESMTPSA id r31sm24800524ywa.82.2020.01.06.10.20.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jan 2020 10:20:25 -0800 (PST)
From:   Trond Myklebust <trondmy@gmail.com>
X-Google-Original-From: Trond Myklebust <trond.myklebust@hammerspace.com>
To:     "J. Bruce Fields" <bfields@redhat.com>
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH RESEND 3/6] nfsd: Containerise filecache laundrette
Date:   Mon,  6 Jan 2020 13:18:05 -0500
Message-Id: <20200106181808.562969-4-trond.myklebust@hammerspace.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200106181808.562969-3-trond.myklebust@hammerspace.com>
References: <20200106181808.562969-1-trond.myklebust@hammerspace.com>
 <20200106181808.562969-2-trond.myklebust@hammerspace.com>
 <20200106181808.562969-3-trond.myklebust@hammerspace.com>
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
2.24.1


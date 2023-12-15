Return-Path: <linux-nfs+bounces-618-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CE498813F20
	for <lists+linux-nfs@lfdr.de>; Fri, 15 Dec 2023 02:21:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 84CF6283666
	for <lists+linux-nfs@lfdr.de>; Fri, 15 Dec 2023 01:21:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70D7C7E4;
	Fri, 15 Dec 2023 01:21:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="isrYEF7F";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="eVzmPEne";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="isrYEF7F";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="eVzmPEne"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FB7C7FC
	for <linux-nfs@vger.kernel.org>; Fri, 15 Dec 2023 01:21:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 6B0A822111;
	Fri, 15 Dec 2023 01:21:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1702603283; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=54HcQ4/fuS1n/1QZ/FLqITCzzb9XxexdPgMUT6ntITY=;
	b=isrYEF7FHC0LbzifUa0Bns/cLM+hqKfpQ1xNfDGy8w8qQdz/3RRcV8HO3maJ5eD+EoVJ9/
	3g2EYitMdUBuGweeKIE0njJ8ZMrHU/dfM/pfZjal9C3Kg/+kUn8c7lhuI1dn0pqCTdlk3Y
	PdhgrOabAxWc1/gJqIo8FgaE5T0ZLhI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1702603283;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=54HcQ4/fuS1n/1QZ/FLqITCzzb9XxexdPgMUT6ntITY=;
	b=eVzmPEneLzUqyb2d+w2i0h35sCuNNeaPnAYlvs1BwI4r1SmIajWmBDlPmNOJJFHMacDsOo
	XJX2OM+k4GMx3LAw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1702603283; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=54HcQ4/fuS1n/1QZ/FLqITCzzb9XxexdPgMUT6ntITY=;
	b=isrYEF7FHC0LbzifUa0Bns/cLM+hqKfpQ1xNfDGy8w8qQdz/3RRcV8HO3maJ5eD+EoVJ9/
	3g2EYitMdUBuGweeKIE0njJ8ZMrHU/dfM/pfZjal9C3Kg/+kUn8c7lhuI1dn0pqCTdlk3Y
	PdhgrOabAxWc1/gJqIo8FgaE5T0ZLhI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1702603283;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=54HcQ4/fuS1n/1QZ/FLqITCzzb9XxexdPgMUT6ntITY=;
	b=eVzmPEneLzUqyb2d+w2i0h35sCuNNeaPnAYlvs1BwI4r1SmIajWmBDlPmNOJJFHMacDsOo
	XJX2OM+k4GMx3LAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 574231342E;
	Fri, 15 Dec 2023 01:21:21 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id k3TvAxGqe2UuVQAAD6G6ig
	(envelope-from <neilb@suse.de>); Fri, 15 Dec 2023 01:21:21 +0000
From: NeilBrown <neilb@suse.de>
To: Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>
Cc: linux-nfs@vger.kernel.org,
	Olga Kornievskaia <kolga@netapp.com>,
	Dai Ngo <Dai.Ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>
Subject: [PATCH 1/2] nfsd: Don't leave work of closing files to a work queue.
Date: Fri, 15 Dec 2023 12:18:30 +1100
Message-ID: <20231215012059.30857-2-neilb@suse.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231215012059.30857-1-neilb@suse.de>
References: <20231215012059.30857-1-neilb@suse.de>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Level: *
X-Spam-Level: 
X-Spamd-Bar: /
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=isrYEF7F;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=eVzmPEne
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-0.46 / 50.00];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	 TO_DN_SOME(0.00)[];
	 R_MISSING_CHARSET(2.50)[];
	 BROKEN_CONTENT_TYPE(1.50)[];
	 RCPT_COUNT_FIVE(0.00)[6];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_TRACE(0.00)[suse.de:+];
	 MX_GOOD(-0.01)[];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 BAYES_HAM(-3.00)[100.00%];
	 ARC_NA(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 FROM_HAS_DN(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 NEURAL_HAM_LONG(-0.95)[-0.953];
	 MIME_GOOD(-0.10)[text/plain];
	 DWL_DNSWL_LOW(-1.00)[suse.de:dkim];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 MID_CONTAINS_FROM(1.00)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 RCVD_TLS_ALL(0.00)[]
X-Spam-Score: -0.46
X-Rspamd-Queue-Id: 6B0A822111
X-Spam-Flag: NO

The work of closing a file can have non-trivial cost.  Doing it in a
separate work queue thread means that cost isn't imposed on the nfsd
threads and an imbalance can be created.  This can result in files being
queued for the work queue more quickly that the work queue can process
them, resulting in unbounded growth of the queue and memory exhaustion.

To avoid this work imbalance that exhausts memory, this patch moves all
closing of files into the nfsd threads.  This means that when the work
imposes a cost, that cost appears where it would be expected - in the
work of the nfsd thread.  A subsequent patch will ensure the final
__fput() is called in the same (nfsd) thread which calls filp_close().

Files opened for NFSv3 are never explicitly closed by the client and are
kept open by the server in the "filecache", which responds to memory
pressure, is garbage collected even when there is no pressure, and
sometimes closes files when there is particular need such as for rename.
These files currently have filp_close() called in a dedicated work
queue, so their __fput() can have no effect on nfsd threads.

This patch discards the work queue and instead has each nfsd thread call
flip_close() on as many as 8 files from the filecache each time it acts
on a client request (or finds there are no pending client requests).  If
there are more to be closed, more threads are woken.  This spreads the
work of __fput() over multiple threads and imposes any cost on those
threads.

The number 8 is somewhat arbitrary.  It needs to be greater than 1 to
ensure that files are closed more quickly than they can be added to the
cache.  It needs to be small enough to limit the per-request delays that
will be imposed on clients when all threads are busy closing files.

Signed-off-by: NeilBrown <neilb@suse.de>
---
 fs/nfsd/filecache.c | 67 +++++++++++++++++++++------------------------
 fs/nfsd/filecache.h |  1 +
 fs/nfsd/nfssvc.c    |  2 ++
 3 files changed, 34 insertions(+), 36 deletions(-)

diff --git a/fs/nfsd/filecache.c b/fs/nfsd/filecache.c
index ef063f93fde9..2521379d28ec 100644
--- a/fs/nfsd/filecache.c
+++ b/fs/nfsd/filecache.c
@@ -61,13 +61,10 @@ static DEFINE_PER_CPU(unsigned long, nfsd_file_total_age);
 static DEFINE_PER_CPU(unsigned long, nfsd_file_evictions);
 
 struct nfsd_fcache_disposal {
-	struct work_struct work;
 	spinlock_t lock;
 	struct list_head freeme;
 };
 
-static struct workqueue_struct *nfsd_filecache_wq __read_mostly;
-
 static struct kmem_cache		*nfsd_file_slab;
 static struct kmem_cache		*nfsd_file_mark_slab;
 static struct list_lru			nfsd_file_lru;
@@ -421,7 +418,37 @@ nfsd_file_dispose_list_delayed(struct list_head *dispose)
 		spin_lock(&l->lock);
 		list_move_tail(&nf->nf_lru, &l->freeme);
 		spin_unlock(&l->lock);
-		queue_work(nfsd_filecache_wq, &l->work);
+		svc_wake_up(nn->nfsd_serv);
+	}
+}
+
+/**
+ * nfsd_file_net_dispose - deal with nfsd_files waiting to be disposed.
+ * @nn: nfsd_net in which to find files to be disposed.
+ *
+ * When files held open for nfsv3 are removed from the filecache, whether
+ * due to memory pressure or garbage collection, they are queued to
+ * a per-net-ns queue.  This function completes the disposal, either
+ * directly or by waking another nfsd thread to help with the work.
+ */
+void nfsd_file_net_dispose(struct nfsd_net *nn)
+{
+	struct nfsd_fcache_disposal *l = nn->fcache_disposal;
+
+	if (!list_empty(&l->freeme)) {
+		LIST_HEAD(dispose);
+		int i;
+
+		spin_lock(&l->lock);
+		for (i = 0; i < 8 && !list_empty(&l->freeme); i++)
+			list_move(l->freeme.next, &dispose);
+		spin_unlock(&l->lock);
+		if (!list_empty(&l->freeme))
+			/* Wake up another thread to share the work
+			 * *before* doing any actual disposing.
+			 */
+			svc_wake_up(nn->nfsd_serv);
+		nfsd_file_dispose_list(&dispose);
 	}
 }
 
@@ -634,27 +661,6 @@ nfsd_file_close_inode_sync(struct inode *inode)
 	flush_delayed_fput();
 }
 
-/**
- * nfsd_file_delayed_close - close unused nfsd_files
- * @work: dummy
- *
- * Scrape the freeme list for this nfsd_net, and then dispose of them
- * all.
- */
-static void
-nfsd_file_delayed_close(struct work_struct *work)
-{
-	LIST_HEAD(head);
-	struct nfsd_fcache_disposal *l = container_of(work,
-			struct nfsd_fcache_disposal, work);
-
-	spin_lock(&l->lock);
-	list_splice_init(&l->freeme, &head);
-	spin_unlock(&l->lock);
-
-	nfsd_file_dispose_list(&head);
-}
-
 static int
 nfsd_file_lease_notifier_call(struct notifier_block *nb, unsigned long arg,
 			    void *data)
@@ -717,10 +723,6 @@ nfsd_file_cache_init(void)
 		return ret;
 
 	ret = -ENOMEM;
-	nfsd_filecache_wq = alloc_workqueue("nfsd_filecache", 0, 0);
-	if (!nfsd_filecache_wq)
-		goto out;
-
 	nfsd_file_slab = kmem_cache_create("nfsd_file",
 				sizeof(struct nfsd_file), 0, 0, NULL);
 	if (!nfsd_file_slab) {
@@ -735,7 +737,6 @@ nfsd_file_cache_init(void)
 		goto out_err;
 	}
 
-
 	ret = list_lru_init(&nfsd_file_lru);
 	if (ret) {
 		pr_err("nfsd: failed to init nfsd_file_lru: %d\n", ret);
@@ -785,8 +786,6 @@ nfsd_file_cache_init(void)
 	nfsd_file_slab = NULL;
 	kmem_cache_destroy(nfsd_file_mark_slab);
 	nfsd_file_mark_slab = NULL;
-	destroy_workqueue(nfsd_filecache_wq);
-	nfsd_filecache_wq = NULL;
 	rhltable_destroy(&nfsd_file_rhltable);
 	goto out;
 }
@@ -832,7 +831,6 @@ nfsd_alloc_fcache_disposal(void)
 	l = kmalloc(sizeof(*l), GFP_KERNEL);
 	if (!l)
 		return NULL;
-	INIT_WORK(&l->work, nfsd_file_delayed_close);
 	spin_lock_init(&l->lock);
 	INIT_LIST_HEAD(&l->freeme);
 	return l;
@@ -841,7 +839,6 @@ nfsd_alloc_fcache_disposal(void)
 static void
 nfsd_free_fcache_disposal(struct nfsd_fcache_disposal *l)
 {
-	cancel_work_sync(&l->work);
 	nfsd_file_dispose_list(&l->freeme);
 	kfree(l);
 }
@@ -910,8 +907,6 @@ nfsd_file_cache_shutdown(void)
 	fsnotify_wait_marks_destroyed();
 	kmem_cache_destroy(nfsd_file_mark_slab);
 	nfsd_file_mark_slab = NULL;
-	destroy_workqueue(nfsd_filecache_wq);
-	nfsd_filecache_wq = NULL;
 	rhltable_destroy(&nfsd_file_rhltable);
 
 	for_each_possible_cpu(i) {
diff --git a/fs/nfsd/filecache.h b/fs/nfsd/filecache.h
index e54165a3224f..c61884def906 100644
--- a/fs/nfsd/filecache.h
+++ b/fs/nfsd/filecache.h
@@ -56,6 +56,7 @@ void nfsd_file_cache_shutdown_net(struct net *net);
 void nfsd_file_put(struct nfsd_file *nf);
 struct nfsd_file *nfsd_file_get(struct nfsd_file *nf);
 void nfsd_file_close_inode_sync(struct inode *inode);
+void nfsd_file_net_dispose(struct nfsd_net *nn);
 bool nfsd_file_is_cached(struct inode *inode);
 __be32 nfsd_file_acquire_gc(struct svc_rqst *rqstp, struct svc_fh *fhp,
 		  unsigned int may_flags, struct nfsd_file **nfp);
diff --git a/fs/nfsd/nfssvc.c b/fs/nfsd/nfssvc.c
index fe61d9bbcc1f..26e203f42edd 100644
--- a/fs/nfsd/nfssvc.c
+++ b/fs/nfsd/nfssvc.c
@@ -956,6 +956,8 @@ nfsd(void *vrqstp)
 
 		svc_recv(rqstp);
 		validate_process_creds();
+
+		nfsd_file_net_dispose(nn);
 	}
 
 	atomic_dec(&nfsdstats.th_cnt);
-- 
2.43.0



Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BCFED46D83A
	for <lists+linux-nfs@lfdr.de>; Wed,  8 Dec 2021 17:31:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234361AbhLHQfK (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 8 Dec 2021 11:35:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230245AbhLHQfK (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 8 Dec 2021 11:35:10 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07D6CC061746
        for <linux-nfs@vger.kernel.org>; Wed,  8 Dec 2021 08:31:38 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C348FB8218D
        for <linux-nfs@vger.kernel.org>; Wed,  8 Dec 2021 16:31:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A977C00446
        for <linux-nfs@vger.kernel.org>; Wed,  8 Dec 2021 16:31:35 +0000 (UTC)
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org
Subject: [PATCH] NFSD: simplify per-net file cache management
Date:   Wed,  8 Dec 2021 11:31:34 -0500
Message-Id:  <163898106312.86477.6520238261086492731.stgit@bazille.1015granger.net>
X-Mailer: git-send-email 2.34.0
User-Agent: StGit/1.4
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=5185; i=chuck.lever@oracle.com; h=from:subject:message-id; bh=q9QtWOrV0lVkw5PcEjL/bwvEBld46Q4ROnAc8oNkPL0=; b=owEBbQKS/ZANAwAIATNqszNvZn+XAcsmYgBhsN3mmVIaW3V1K0eTHVHjfktIMxALjWm7wSz3YPGr XwY/WLaJAjMEAAEIAB0WIQQosuWwEobfJDzyPv4zarMzb2Z/lwUCYbDd5gAKCRAzarMzb2Z/l0yGEA CHumpC+cGBZhyXkUY6lin0cySyGfUH/SIUFWScYfE8NoFyJjl/Bp2OygmLZHI9YYTRaERAPLkuMfJP 7jEaW52tCK3Jc13l8Zs6nBCWZ7olDMVD6xoFxLXAEPlR/sNLBZ5BywHRsPGzvucWQ3SdZ+of47mWMw Sz85K3tv5bzWVltWV3bukIjTxkpbjOMiothQBtdCTvuQOqwV8fP9vCAPchdPdM8/tfYEP1NeqsIRg5 Hh0eTz4Zp8HKZuav0C0pet7PffretJrWCqrkxpoIZ4El28aqXnMoU6enlscGazPcsWweluUZLWbU0l 2Hhlj3Tbwm6CXmoz8CfSubPhQhYSHMBEY6L95kiz1UPg1EKT5BY49WsMnsCrTvZ5SFGhs3GP/klEfr fYUEe7K67GgmluDlnYATjZUEkwgXCI6fxq1rB6snNEN0+pd+Yx9fZijwb/DmYQhvyvvmBTjxQb09un GHU3s3eNNSZewa7osJMo0AGT95I4RN0KH5jL6silHBGsx9T13dknmkegDM06s3nFVp8EIQJAUkoLPj AJErrf7edpxETSvYlO0gal8anwXWLMEDxzZQERuIMcjQ+bQE5GN3RYDNpUFXVog3KZW698twsNluVJ 6Gpec9rFlK6GUgtI7AleUtyWA8rGFZMy/W5Fd/OnGFzeUOxilZZ+
 zaghEaMA==
X-Developer-Key: i=chuck.lever@oracle.com; a=openpgp; fpr=28B2E5B01286DF243CF23EFE336AB3336F667F97
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: NeilBrown <neilb@suse.de>

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
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/filecache.c |   76 ++++++++++-----------------------------------------
 fs/nfsd/netns.h     |    2 +
 2 files changed, 17 insertions(+), 61 deletions(-)


Initial testing shows Neil's patch works as expected. I'm planning
to apply this for 5.17. Please review!


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
index 935c1028c217..b746d856bef5 100644
--- a/fs/nfsd/netns.h
+++ b/fs/nfsd/netns.h
@@ -184,6 +184,8 @@ struct nfsd_net {
 
 	/* utsname taken from the process that starts the server */
 	char			nfsd_name[UNX_MAXNODENAME+1];
+
+	struct nfsd_fcache_disposal *fcache_disposal;
 };
 
 /* Simple check to find out if a given net was properly initialized */


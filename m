Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E8CE41A3EE
	for <lists+linux-nfs@lfdr.de>; Tue, 28 Sep 2021 01:49:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238195AbhI0Xut (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 27 Sep 2021 19:50:49 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:35428 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238189AbhI0Xus (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 27 Sep 2021 19:50:48 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 97930201AD;
        Mon, 27 Sep 2021 23:49:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1632786549; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=btZeY2vVvOn6nKadQpEn7sG3SRL3UvgyURHoxS1z3fU=;
        b=tRIEVkZw35AwWGV8Psm/BIzE3JzWqhf+3+HihxopkCC8vk0g3LrlqgT93DtEZCYxSLodTC
        o2zHQTj4XZYe+AiZMQuLRx6XwCaP/KXzrN5X8D7yQ7NRsKoAfAOpj0lztUZpXmxE3eCPjM
        xVXnVl1+YB5zozVst8nIWQqogiBBKpU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1632786549;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=btZeY2vVvOn6nKadQpEn7sG3SRL3UvgyURHoxS1z3fU=;
        b=6d5EAoc59JcKDHJb982EKDPK6AOvGcObWGUaxczz57RuTUuHg26qbc5g7cBFjPCVVq2bNL
        rooBVUGWRMtxI+DQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 8B07313A5D;
        Mon, 27 Sep 2021 23:49:08 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id jJ7OEnRYUmGPJQAAMHmgww
        (envelope-from <neilb@suse.de>); Mon, 27 Sep 2021 23:49:08 +0000
Subject: [PATCH 3/3] NFS: don't store 'struct cred *' in struct
 nfs_access_entry
From:   NeilBrown <neilb@suse.de>
To:     Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>
Cc:     linux-nfs@vger.kernel.org
Date:   Tue, 28 Sep 2021 09:47:57 +1000
Message-ID: <163278647712.17728.11762338282726655245.stgit@noble.brown>
In-Reply-To: <163278643081.17728.10586733395858659759.stgit@noble.brown>
References: <163278643081.17728.10586733395858659759.stgit@noble.brown>
User-Agent: StGit/0.23
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Storing the 'struct cred *' in nfs_access_entry is problematic.
An active 'cred' can keep a 'struct key *' active, and a quota is
imposed on the number of such keys that a user can maintain.
Cached 'nfs_access_entry' structs have indefinite lifetime, and having
these keep 'struct key's alive imposes on that quota.

So remove the 'struct cred *' and replace it with the fields we need:
  kuid_t, kgid_t, and struct group_info *

This makes the 'struct nfs_access_entry' 64 bits larger.

New function "access_cmp" is introduced which is identical to
cred_fscmp() except that the second arg is an 'nfs_access_entry', rather
than a 'cred'

Fixes: b68572e07c58 ("NFS: change access cache to use 'struct cred'.")
Signed-off-by: NeilBrown <neilb@suse.de>
---
 fs/nfs/dir.c           |   50 ++++++++++++++++++++++++++++++++++++++++++------
 fs/nfs/nfs4proc.c      |    1 -
 include/linux/nfs_fs.h |    4 +++-
 3 files changed, 47 insertions(+), 8 deletions(-)

diff --git a/fs/nfs/dir.c b/fs/nfs/dir.c
index 0cd66ff2b8ba..34d1669bf163 100644
--- a/fs/nfs/dir.c
+++ b/fs/nfs/dir.c
@@ -2531,7 +2531,7 @@ MODULE_PARM_DESC(nfs_access_max_cachesize, "NFS access maximum total cache lengt
 
 static void nfs_access_free_entry(struct nfs_access_entry *entry)
 {
-	put_cred(entry->cred);
+	put_group_info(entry->group_info);
 	kfree_rcu(entry, rcu_head);
 	smp_mb__before_atomic();
 	atomic_long_dec(&nfs_access_nr_entries);
@@ -2657,6 +2657,43 @@ void nfs_access_zap_cache(struct inode *inode)
 }
 EXPORT_SYMBOL_GPL(nfs_access_zap_cache);
 
+static int access_cmp(const struct cred *a, const struct nfs_access_entry *b)
+{
+	struct group_info *ga, *gb;
+	int g;
+
+	if (uid_lt(a->fsuid, b->fsuid))
+		return -1;
+	if (uid_gt(a->fsuid, b->fsuid))
+		return 1;
+
+	if (gid_lt(a->fsgid, b->fsgid))
+		return -1;
+	if (gid_gt(a->fsgid, b->fsgid))
+		return 1;
+
+	ga = a->group_info;
+	gb = b->group_info;
+	if (ga == gb)
+		return 0;
+	if (ga == NULL)
+		return -1;
+	if (gb == NULL)
+		return 1;
+	if (ga->ngroups < gb->ngroups)
+		return -1;
+	if (ga->ngroups > gb->ngroups)
+		return 1;
+
+	for (g = 0; g < ga->ngroups; g++) {
+		if (gid_lt(ga->gid[g], gb->gid[g]))
+			return -1;
+		if (gid_gt(ga->gid[g], gb->gid[g]))
+			return 1;
+	}
+	return 0;
+}
+
 static struct nfs_access_entry *nfs_access_search_rbtree(struct inode *inode, const struct cred *cred)
 {
 	struct rb_node *n = NFS_I(inode)->access_cache.rb_node;
@@ -2664,7 +2701,7 @@ static struct nfs_access_entry *nfs_access_search_rbtree(struct inode *inode, co
 	while (n != NULL) {
 		struct nfs_access_entry *entry =
 			rb_entry(n, struct nfs_access_entry, rb_node);
-		int cmp = cred_fscmp(cred, entry->cred);
+		int cmp = access_cmp(cred, entry);
 
 		if (cmp < 0)
 			n = n->rb_left;
@@ -2734,7 +2771,7 @@ static int nfs_access_get_cached_rcu(struct inode *inode, const struct cred *cre
 	lh = rcu_dereference(list_tail_rcu(&nfsi->access_cache_entry_lru));
 	cache = list_entry(lh, struct nfs_access_entry, lru);
 	if (lh == &nfsi->access_cache_entry_lru ||
-	    cred_fscmp(cred, cache->cred) != 0)
+	    access_cmp(cred, cache) != 0)
 		cache = NULL;
 	if (cache == NULL)
 		goto out;
@@ -2776,7 +2813,7 @@ static void nfs_access_add_rbtree(struct inode *inode,
 	while (*p != NULL) {
 		parent = *p;
 		entry = rb_entry(parent, struct nfs_access_entry, rb_node);
-		cmp = cred_fscmp(cred, entry->cred);
+		cmp = access_cmp(cred, entry);
 
 		if (cmp < 0)
 			p = &parent->rb_left;
@@ -2805,7 +2842,9 @@ void nfs_access_add_cache(struct inode *inode, struct nfs_access_entry *set,
 	if (cache == NULL)
 		return;
 	RB_CLEAR_NODE(&cache->rb_node);
-	cache->cred = get_cred(cred);
+	cache->fsuid = cred->fsuid;
+	cache->fsgid = cred->fsgid;
+	cache->group_info = get_group_info(cred->group_info);
 	cache->mask = set->mask;
 
 	/* The above field assignments must be visible
@@ -2898,7 +2937,6 @@ static int nfs_do_access(struct inode *inode, const struct cred *cred, int mask)
 		cache.mask |= NFS_ACCESS_DELETE | NFS_ACCESS_LOOKUP;
 	else
 		cache.mask |= NFS_ACCESS_EXECUTE;
-	cache.cred = cred;
 	status = NFS_PROTO(inode)->access(inode, &cache, cred);
 	if (status != 0) {
 		if (status == -ESTALE) {
diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
index 5f622b099412..27d3c694bc8a 100644
--- a/fs/nfs/nfs4proc.c
+++ b/fs/nfs/nfs4proc.c
@@ -2653,7 +2653,6 @@ static int nfs4_opendata_access(const struct cred *cred,
 	} else if ((fmode & FMODE_READ) && !opendata->file_created)
 		mask = NFS4_ACCESS_READ;
 
-	cache.cred = cred;
 	nfs_access_set_mask(&cache, opendata->o_res.access_result);
 	nfs_access_add_cache(state->inode, &cache, cred);
 
diff --git a/include/linux/nfs_fs.h b/include/linux/nfs_fs.h
index 6e356dbda519..86dcb300b0fd 100644
--- a/include/linux/nfs_fs.h
+++ b/include/linux/nfs_fs.h
@@ -61,7 +61,9 @@
 struct nfs_access_entry {
 	struct rb_node		rb_node;
 	struct list_head	lru;
-	const struct cred *	cred;
+	kuid_t			fsuid;
+	kgid_t			fsgid;
+	struct group_info	*group_info;
 	__u32			mask;
 	struct rcu_head		rcu_head;
 };



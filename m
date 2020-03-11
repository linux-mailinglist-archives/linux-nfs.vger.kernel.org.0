Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CFB121822E7
	for <lists+linux-nfs@lfdr.de>; Wed, 11 Mar 2020 20:56:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387438AbgCKT4c (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 11 Mar 2020 15:56:32 -0400
Received: from smtp-fw-9102.amazon.com ([207.171.184.29]:20946 "EHLO
        smtp-fw-9102.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387431AbgCKT4c (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 11 Mar 2020 15:56:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1583956590; x=1615492590;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=FbPE0RTEzznmwCYx/2Y31Uv2FB5qAgNq53BsMDnuobA=;
  b=qQcMgBwjP0dOfdKUpBg9cmCd5c+iZrBWBp1WSplzaPQbIr9HlkTn2Ztc
   5vPsa+emmhmrl6C63b0yoaW7bL4+/7rU6KBG/63kJVM75LPSOEnk7UJfX
   D3tywWnBZWHftXQrJrjDcQiV+HrovkgWPdqXF2qqKmPnew2VXnRa8lxeI
   c=;
IronPort-SDR: LXc48V2Z9bQx9fijW28AnsMnZdi6cAxHLJ/SkY05d52xzNjf89kjeFE2xQnb9tHi7nl2chA7FH
 Xf8UPnGWGH8A==
X-IronPort-AV: E=Sophos;i="5.70,541,1574121600"; 
   d="scan'208";a="30663722"
Received: from sea32-co-svc-lb4-vlan3.sea.corp.amazon.com (HELO email-inbound-relay-1e-62350142.us-east-1.amazon.com) ([10.47.23.38])
  by smtp-border-fw-out-9102.sea19.amazon.com with ESMTP; 11 Mar 2020 19:56:27 +0000
Received: from EX13MTAUWB001.ant.amazon.com (iad55-ws-svc-p15-lb9-vlan3.iad.amazon.com [10.40.159.166])
        by email-inbound-relay-1e-62350142.us-east-1.amazon.com (Postfix) with ESMTPS id 49E0CA24B0;
        Wed, 11 Mar 2020 19:56:24 +0000 (UTC)
Received: from EX13D13UWB002.ant.amazon.com (10.43.161.21) by
 EX13MTAUWB001.ant.amazon.com (10.43.161.249) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Wed, 11 Mar 2020 19:56:24 +0000
Received: from EX13MTAUWC001.ant.amazon.com (10.43.162.135) by
 EX13D13UWB002.ant.amazon.com (10.43.161.21) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Wed, 11 Mar 2020 19:56:24 +0000
Received: from dev-dsk-fllinden-2c-c1893d73.us-west-2.amazon.com
 (172.23.141.97) by mail-relay.amazon.com (10.43.162.232) with Microsoft SMTP
 Server id 15.0.1367.3 via Frontend Transport; Wed, 11 Mar 2020 19:56:24 +0000
Received: by dev-dsk-fllinden-2c-c1893d73.us-west-2.amazon.com (Postfix, from userid 6262777)
        id 12BF7DEF4B; Wed, 11 Mar 2020 19:56:24 +0000 (UTC)
From:   Frank van der Linden <fllinden@amazon.com>
To:     <trond.myklebust@hammerspace.com>, <anna.schumaker@netapp.com>,
        <linux-nfs@vger.kernel.org>
CC:     Frank van der Linden <fllinden@amazon.com>
Subject: [PATCH 13/13] NFSv4.2: add client side xattr caching.
Date:   Wed, 11 Mar 2020 19:56:13 +0000
Message-ID: <20200311195613.26108-14-fllinden@amazon.com>
X-Mailer: git-send-email 2.16.6
In-Reply-To: <20200311195613.26108-1-fllinden@amazon.com>
References: <20200311195613.26108-1-fllinden@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Implement client side caching for NFSv4.2 extended attributes. The cache
is a per-inode hashtable, with name/value entries. There is one special
entry for the listxattr cache.

NFS inodes have a pointer to a cache structure. The cache structure is
allocated on demand, freed when the cache is invalidated.

Memory shrinkers keep the size in check. Large entries (> PAGE_SIZE)
are collected by a separate shrinker, and freed more aggressively
than others.

Signed-off-by: Frank van der Linden <fllinden@amazon.com>
---
 fs/nfs/Makefile             |    1 +
 fs/nfs/inode.c              |    9 +-
 fs/nfs/internal.h           |   20 +
 fs/nfs/nfs42proc.c          |   12 +
 fs/nfs/nfs42xattr.c         | 1083 +++++++++++++++++++++++++++++++++++++++++++
 fs/nfs/nfs4proc.c           |   42 +-
 fs/nfs/nfs4super.c          |   10 +
 include/linux/nfs_fs.h      |    6 +
 include/uapi/linux/nfs_fs.h |    1 +
 9 files changed, 1177 insertions(+), 7 deletions(-)
 create mode 100644 fs/nfs/nfs42xattr.c

diff --git a/fs/nfs/Makefile b/fs/nfs/Makefile
index 2433c3e03cfa..191b3e9aa232 100644
--- a/fs/nfs/Makefile
+++ b/fs/nfs/Makefile
@@ -31,6 +31,7 @@ nfsv4-$(CONFIG_NFS_USE_LEGACY_DNS) += cache_lib.o
 nfsv4-$(CONFIG_SYSCTL)	+= nfs4sysctl.o
 nfsv4-$(CONFIG_NFS_V4_1)	+= pnfs.o pnfs_dev.o pnfs_nfs.o
 nfsv4-$(CONFIG_NFS_V4_2)	+= nfs42proc.o
+nfsv4-$(CONFIG_NFS_V4_2)	+= nfs42xattr.o
 
 obj-$(CONFIG_PNFS_FILE_LAYOUT) += filelayout/
 obj-$(CONFIG_PNFS_BLOCK) += blocklayout/
diff --git a/fs/nfs/inode.c b/fs/nfs/inode.c
index d2be152796ef..9d4952d2306b 100644
--- a/fs/nfs/inode.c
+++ b/fs/nfs/inode.c
@@ -194,6 +194,7 @@ bool nfs_check_cache_invalid(struct inode *inode, unsigned long flags)
 
 	return nfs_check_cache_invalid_not_delegated(inode, flags);
 }
+EXPORT_SYMBOL_GPL(nfs_check_cache_invalid);
 
 static void nfs_set_cache_invalid(struct inode *inode, unsigned long flags)
 {
@@ -235,11 +236,13 @@ static void nfs_zap_caches_locked(struct inode *inode)
 					| NFS_INO_INVALID_DATA
 					| NFS_INO_INVALID_ACCESS
 					| NFS_INO_INVALID_ACL
+					| NFS_INO_INVALID_XATTR
 					| NFS_INO_REVAL_PAGECACHE);
 	} else
 		nfs_set_cache_invalid(inode, NFS_INO_INVALID_ATTR
 					| NFS_INO_INVALID_ACCESS
 					| NFS_INO_INVALID_ACL
+					| NFS_INO_INVALID_XATTR
 					| NFS_INO_REVAL_PAGECACHE);
 	nfs_zap_label_cache_locked(nfsi);
 }
@@ -1885,7 +1888,8 @@ static int nfs_update_inode(struct inode *inode, struct nfs_fattr *fattr)
 			if (!(have_writers || have_delegation)) {
 				invalid |= NFS_INO_INVALID_DATA
 					| NFS_INO_INVALID_ACCESS
-					| NFS_INO_INVALID_ACL;
+					| NFS_INO_INVALID_ACL
+					| NFS_INO_INVALID_XATTR;
 				/* Force revalidate of all attributes */
 				save_cache_validity |= NFS_INO_INVALID_CTIME
 					| NFS_INO_INVALID_MTIME
@@ -2084,6 +2088,9 @@ struct inode *nfs_alloc_inode(struct super_block *sb)
 #if IS_ENABLED(CONFIG_NFS_V4)
 	nfsi->nfs4_acl = NULL;
 #endif /* CONFIG_NFS_V4 */
+#ifdef CONFIG_NFS_V4_2
+	nfsi->xattr_cache = NULL;
+#endif
 	return &nfsi->vfs_inode;
 }
 EXPORT_SYMBOL_GPL(nfs_alloc_inode);
diff --git a/fs/nfs/internal.h b/fs/nfs/internal.h
index 1e3a7e119c93..67b8e4f7c554 100644
--- a/fs/nfs/internal.h
+++ b/fs/nfs/internal.h
@@ -575,6 +575,26 @@ extern void nfs4_test_session_trunk(struct rpc_clnt *clnt,
 				struct rpc_xprt *xprt,
 				void *data);
 
+#ifdef CONFIG_NFS_V4_2
+extern int __init nfs4_xattr_cache_init(void);
+extern void nfs4_xattr_cache_exit(void);
+extern void nfs4_xattr_cache_add(struct inode *inode, const char *name,
+				 const char *buf, struct page **pages,
+				 ssize_t buflen);
+extern void nfs4_xattr_cache_remove(struct inode *inode, const char *name);
+extern ssize_t nfs4_xattr_cache_get(struct inode *inode, const char *name,
+				char *buf, ssize_t buflen);
+extern void nfs4_xattr_cache_set_list(struct inode *inode, const char *buf,
+				      ssize_t buflen);
+extern ssize_t nfs4_xattr_cache_list(struct inode *inode, char *buf,
+				     ssize_t buflen);
+extern void nfs4_xattr_cache_zap(struct inode *inode);
+#else
+static inline void nfs4_xattr_cache_zap(struct inode *inode)
+{
+}
+#endif
+
 static inline struct inode *nfs_igrab_and_active(struct inode *inode)
 {
 	inode = igrab(inode);
diff --git a/fs/nfs/nfs42proc.c b/fs/nfs/nfs42proc.c
index 8c2e52bc986a..e200522469af 100644
--- a/fs/nfs/nfs42proc.c
+++ b/fs/nfs/nfs42proc.c
@@ -1182,6 +1182,18 @@ static ssize_t _nfs42_proc_getxattr(struct inode *inode, const char *name,
 	if (ret < 0)
 		return ret;
 
+	/*
+	 * Normally, the caching is done one layer up, but for successful
+	 * RPCS, always cache the result here, even if the caller was
+	 * just querying the length, or if the reply was too big for
+	 * the caller. This avoids a second RPC in the case of the
+	 * common query-alloc-retrieve cycle for xattrs.
+	 *
+	 * Note that xattr_len is always capped to XATTR_SIZE_MAX.
+	 */
+
+	nfs4_xattr_cache_add(inode, name, NULL, pages, res.xattr_len);
+
 	if (buflen) {
 		if (res.xattr_len > buflen)
 			return -ERANGE;
diff --git a/fs/nfs/nfs42xattr.c b/fs/nfs/nfs42xattr.c
new file mode 100644
index 000000000000..23fdab977a2a
--- /dev/null
+++ b/fs/nfs/nfs42xattr.c
@@ -0,0 +1,1083 @@
+// SPDX-License-Identifier: GPL-2.0
+
+/*
+ * Copyright 2019, 2020 Amazon.com, Inc. or its affiliates. All rights reserved.
+ *
+ * User extended attribute client side cache functions.
+ *
+ * Author: Frank van der Linden <fllinden@amazon.com>
+ */
+#include <linux/errno.h>
+#include <linux/nfs_fs.h>
+#include <linux/hashtable.h>
+#include <linux/refcount.h>
+#include <uapi/linux/xattr.h>
+
+#include "nfs4_fs.h"
+#include "internal.h"
+
+/*
+ * User extended attributes client side caching is implemented by having
+ * a cache structure attached to NFS inodes. This structure is allocated
+ * when needed, and freed when the cache is zapped.
+ *
+ * The cache structure contains as hash table of entries, and a pointer
+ * to a special-cased entry for the listxattr cache.
+ *
+ * Accessing and allocating / freeing the caches is done via reference
+ * counting. The cache entries use a similar refcounting scheme.
+ *
+ * This makes freeing a cache, both from the shrinker and from the
+ * zap cache path, easy. It also means that, in current use cases,
+ * the large majority of inodes will not waste any memory, as they
+ * will never have any user extended attributes assigned to them.
+ *
+ * Attribute entries are hashed in to a simple hash table. They are
+ * also part of an LRU.
+ *
+ * There are three shrinkers.
+ *
+ * Two shrinkers deal with the cache entries themselves: one for
+ * large entries (> PAGE_SIZE), and one for smaller entries. The
+ * shrinker for the larger entries works more aggressively than
+ * those for the smaller entries.
+ *
+ * The other shrinker frees the cache structures themselves.
+ */
+
+/*
+ * 64 buckets is a good default. There is likely no reasonable
+ * workload that uses more than even 64 user extended attributes.
+ * You can certainly add a lot more - but you get what you ask for
+ * in those circumstances.
+ */
+#define NFS4_XATTR_HASH_SIZE	64
+
+#define NFSDBG_FACILITY	NFSDBG_XATTRCACHE
+
+struct nfs4_xattr_cache;
+struct nfs4_xattr_entry;
+
+struct nfs4_xattr_bucket {
+	spinlock_t lock;
+	struct hlist_head hlist;
+	struct nfs4_xattr_cache *cache;
+	bool draining;
+};
+
+struct nfs4_xattr_cache {
+	struct kref ref;
+	spinlock_t hash_lock;	/* protects hashtable and lru */
+	struct nfs4_xattr_bucket buckets[NFS4_XATTR_HASH_SIZE];
+	struct list_head lru;
+	struct list_head dispose;
+	atomic_long_t nent;
+	spinlock_t listxattr_lock;
+	struct inode *inode;
+	struct nfs4_xattr_entry *listxattr;
+	struct work_struct work;
+};
+
+struct nfs4_xattr_entry {
+	struct kref ref;
+	struct hlist_node hnode;
+	struct list_head lru;
+	struct list_head dispose;
+	char *xattr_name;
+	void *xattr_value;
+	size_t xattr_size;
+	struct nfs4_xattr_bucket *bucket;
+	uint32_t flags;
+};
+
+#define	NFS4_XATTR_ENTRY_EXTVAL	0x0001
+
+/*
+ * LRU list of NFS inodes that have xattr caches.
+ */
+static struct list_lru nfs4_xattr_cache_lru;
+static struct list_lru nfs4_xattr_entry_lru;
+static struct list_lru nfs4_xattr_large_entry_lru;
+
+static struct kmem_cache *nfs4_xattr_cache_cachep;
+
+static struct workqueue_struct *nfs4_xattr_cache_wq;
+
+/*
+ * Hashing helper functions.
+ */
+static void
+nfs4_xattr_hash_init(struct nfs4_xattr_cache *cache)
+{
+	unsigned int i;
+
+	for (i = 0; i < NFS4_XATTR_HASH_SIZE; i++) {
+		INIT_HLIST_HEAD(&cache->buckets[i].hlist);
+		spin_lock_init(&cache->buckets[i].lock);
+		cache->buckets[i].cache = cache;
+		cache->buckets[i].draining = false;
+	}
+}
+
+/*
+ * Locking order:
+ * 1. inode i_lock or bucket lock
+ * 2. list_lru lock (taken by list_lru_* functions)
+ */
+
+/*
+ * Wrapper functions to add a cache entry to the right LRU.
+ */
+static bool
+nfs4_xattr_entry_lru_add(struct nfs4_xattr_entry *entry)
+{
+	struct list_lru *lru;
+
+	lru = (entry->flags & NFS4_XATTR_ENTRY_EXTVAL) ?
+	    &nfs4_xattr_large_entry_lru : &nfs4_xattr_entry_lru;
+
+	return list_lru_add(lru, &entry->lru);
+}
+
+static bool
+nfs4_xattr_entry_lru_del(struct nfs4_xattr_entry *entry)
+{
+	struct list_lru *lru;
+
+	lru = (entry->flags & NFS4_XATTR_ENTRY_EXTVAL) ?
+	    &nfs4_xattr_large_entry_lru : &nfs4_xattr_entry_lru;
+
+	return list_lru_del(lru, &entry->lru);
+}
+
+/*
+ * This function allocates cache entries. They are the normal
+ * extended attribute name/value pairs, but may also be a listxattr
+ * cache. Those allocations use the same entry so that they can be
+ * treated as one by the memory shrinker.
+ *
+ * xattr cache entries are allocated together with names. If the
+ * value fits in to one page with the entry structure and the name,
+ * it will also be part of the same allocation (kmalloc). This is
+ * expected to be the vast majority of cases. Larger allocations
+ * have a value pointer that is allocated separately by kvmalloc.
+ *
+ * Parameters:
+ *
+ * @name:  Name of the extended attribute. NULL for listxattr cache
+ *         entry.
+ * @value: Value of attribute, or listxattr cache. NULL if the
+ *         value is to be copied from pages instead.
+ * @pages: Pages to copy the value from, if not NULL. Passed in to
+ *	   make it easier to copy the value after an RPC, even if
+ *	   the value will not be passed up to application (e.g.
+ *	   for a 'query' getxattr with NULL buffer).
+ * @len:   Length of the value. Can be 0 for zero-length attribues.
+ *         @value and @pages will be NULL if @len is 0.
+ */
+static struct nfs4_xattr_entry *
+nfs4_xattr_alloc_entry(const char *name, const void *value,
+		       struct page **pages, size_t len)
+{
+	struct nfs4_xattr_entry *entry;
+	void *valp;
+	char *namep;
+	size_t alloclen, slen;
+	char *buf;
+	uint32_t flags;
+
+	BUILD_BUG_ON(sizeof(struct nfs4_xattr_entry) +
+	    XATTR_NAME_MAX + 1 > PAGE_SIZE);
+
+	alloclen = sizeof(struct nfs4_xattr_entry);
+	if (name != NULL) {
+		slen = strlen(name) + 1;
+		alloclen += slen;
+	} else
+		slen = 0;
+
+	if (alloclen + len <= PAGE_SIZE) {
+		alloclen += len;
+		flags = 0;
+	} else {
+		flags = NFS4_XATTR_ENTRY_EXTVAL;
+	}
+
+	buf = kmalloc(alloclen, GFP_KERNEL_ACCOUNT | GFP_NOFS);
+	if (buf == NULL)
+		return NULL;
+	entry = (struct nfs4_xattr_entry *)buf;
+
+	if (name != NULL) {
+		namep = buf + sizeof(struct nfs4_xattr_entry);
+		memcpy(namep, name, slen);
+	} else {
+		namep = NULL;
+	}
+
+
+	if (flags & NFS4_XATTR_ENTRY_EXTVAL) {
+		valp = kvmalloc(len, GFP_KERNEL_ACCOUNT | GFP_NOFS);
+		if (valp == NULL) {
+			kfree(buf);
+			return NULL;
+		}
+	} else if (len != 0) {
+		valp = buf + sizeof(struct nfs4_xattr_entry) + slen;
+	} else
+		valp = NULL;
+
+	if (valp != NULL) {
+		if (value != NULL)
+			memcpy(valp, value, len);
+		else
+			_copy_from_pages(valp, pages, 0, len);
+	}
+
+	entry->flags = flags;
+	entry->xattr_value = valp;
+	kref_init(&entry->ref);
+	entry->xattr_name = namep;
+	entry->xattr_size = len;
+	entry->bucket = NULL;
+	INIT_LIST_HEAD(&entry->lru);
+	INIT_LIST_HEAD(&entry->dispose);
+	INIT_HLIST_NODE(&entry->hnode);
+
+	return entry;
+}
+
+static void
+nfs4_xattr_free_entry(struct nfs4_xattr_entry *entry)
+{
+	if (entry->flags & NFS4_XATTR_ENTRY_EXTVAL)
+		kvfree(entry->xattr_value);
+	kfree(entry);
+}
+
+static void
+nfs4_xattr_free_entry_cb(struct kref *kref)
+{
+	struct nfs4_xattr_entry *entry;
+
+	entry = container_of(kref, struct nfs4_xattr_entry, ref);
+
+	if (WARN_ON(!list_empty(&entry->lru)))
+		return;
+
+	nfs4_xattr_free_entry(entry);
+}
+
+static void
+nfs4_xattr_free_cache_cb(struct kref *kref)
+{
+	struct nfs4_xattr_cache *cache;
+	int i;
+
+	cache = container_of(kref, struct nfs4_xattr_cache, ref);
+
+	for (i = 0; i < NFS4_XATTR_HASH_SIZE; i++) {
+		if (WARN_ON(!hlist_empty(&cache->buckets[i].hlist)))
+			return;
+		cache->buckets[i].draining = false;
+	}
+
+	cache->listxattr = NULL;
+
+	kmem_cache_free(nfs4_xattr_cache_cachep, cache);
+
+}
+
+static struct nfs4_xattr_cache *
+nfs4_xattr_alloc_cache(void)
+{
+	struct nfs4_xattr_cache *cache;
+
+	cache = kmem_cache_alloc(nfs4_xattr_cache_cachep,
+	    GFP_KERNEL_ACCOUNT | GFP_NOFS);
+	if (cache == NULL)
+		return NULL;
+
+	kref_init(&cache->ref);
+	atomic_long_set(&cache->nent, 0);
+
+	return cache;
+}
+
+/*
+ * Set the listxattr cache, which is a special-cased cache entry.
+ * The special value ERR_PTR(-ESTALE) is used to indicate that
+ * the cache is being drained - this prevents a new listxattr
+ * cache from being added to what is now a stale cache.
+ */
+static int
+nfs4_xattr_set_listcache(struct nfs4_xattr_cache *cache,
+			 struct nfs4_xattr_entry *new)
+{
+	struct nfs4_xattr_entry *old;
+	int ret = 1;
+
+	spin_lock(&cache->listxattr_lock);
+
+	old = cache->listxattr;
+
+	if (old == ERR_PTR(-ESTALE)) {
+		ret = 0;
+		goto out;
+	}
+
+	cache->listxattr = new;
+	if (new != NULL && new != ERR_PTR(-ESTALE))
+		nfs4_xattr_entry_lru_add(new);
+
+	if (old != NULL) {
+		nfs4_xattr_entry_lru_del(old);
+		kref_put(&old->ref, nfs4_xattr_free_entry_cb);
+	}
+out:
+	spin_unlock(&cache->listxattr_lock);
+
+	return ret;
+}
+
+/*
+ * Unlink a cache from its parent inode, clearing out an invalid
+ * cache. Must be called with i_lock held.
+ */
+static struct nfs4_xattr_cache *
+nfs4_xattr_cache_unlink(struct inode *inode)
+{
+	struct nfs_inode *nfsi;
+	struct nfs4_xattr_cache *oldcache;
+
+	nfsi = NFS_I(inode);
+
+	oldcache = nfsi->xattr_cache;
+	if (oldcache != NULL) {
+		list_lru_del(&nfs4_xattr_cache_lru, &oldcache->lru);
+		oldcache->inode = NULL;
+	}
+	nfsi->xattr_cache = NULL;
+	nfsi->cache_validity &= ~NFS_INO_INVALID_XATTR;
+
+	return oldcache;
+
+}
+
+/*
+ * Discard a cache. Usually called by a worker, since walking all
+ * the entries can take up some cycles that we don't want to waste
+ * in the I/O path. Can also be called from the shrinker callback.
+ *
+ * The cache is dead, it has already been unlinked from its inode,
+ * and no longer appears on the cache LRU list.
+ *
+ * Mark all buckets as draining, so that no new entries are added. This
+ * could still happen in the unlikely, but possible case that another
+ * thread had grabbed a reference before it was unlinked from the inode,
+ * and is still holding it for an add operation.
+ *
+ * Remove all entries from the LRU lists, so that there is no longer
+ * any way to 'find' this cache. Then, remove the entries from the hash
+ * table.
+ *
+ * At that point, the cache will remain empty and can be freed when the final
+ * reference drops, which is very likely the kref_put at the end of
+ * this function, or the one called immediately afterwards in the
+ * shrinker callback.
+ */
+static void
+nfs4_xattr_discard_cache(struct nfs4_xattr_cache *cache)
+{
+	unsigned int i;
+	struct nfs4_xattr_entry *entry;
+	struct nfs4_xattr_bucket *bucket;
+	struct hlist_node *n;
+
+	nfs4_xattr_set_listcache(cache, ERR_PTR(-ESTALE));
+
+	for (i = 0; i < NFS4_XATTR_HASH_SIZE; i++) {
+		bucket = &cache->buckets[i];
+
+		spin_lock(&bucket->lock);
+		bucket->draining = true;
+		hlist_for_each_entry_safe(entry, n, &bucket->hlist, hnode) {
+			nfs4_xattr_entry_lru_del(entry);
+			hlist_del_init(&entry->hnode);
+			kref_put(&entry->ref, nfs4_xattr_free_entry_cb);
+		}
+		spin_unlock(&bucket->lock);
+	}
+
+	atomic_long_set(&cache->nent, 0);
+
+	kref_put(&cache->ref, nfs4_xattr_free_cache_cb);
+}
+
+static void
+nfs4_xattr_discard_cache_worker(struct work_struct *work)
+{
+	struct nfs4_xattr_cache *cache = container_of(work,
+	    struct nfs4_xattr_cache, work);
+
+	nfs4_xattr_discard_cache(cache);
+}
+
+static void
+nfs4_xattr_reap_cache(struct nfs4_xattr_cache *cache)
+{
+	queue_work(nfs4_xattr_cache_wq, &cache->work);
+}
+
+/*
+ * Get a referenced copy of the cache structure. Avoid doing allocs
+ * while holding i_lock. Which means that we do some optimistic allocation,
+ * and might have to free the result in rare cases.
+ *
+ * This function only checks the NFS_INO_INVALID_XATTR cache validity bit
+ * and acts accordingly, replacing the cache when needed. For the read case
+ * (!add), this means that the caller must make sure that the cache
+ * is valid before caling this function. getxattr and listxattr call
+ * revalidate_inode to do this. The attribute cache timeout (for the
+ * non-delegated case) is expected to be dealt with in the revalidate
+ * call.
+ */
+
+static struct nfs4_xattr_cache *
+nfs4_xattr_get_cache(struct inode *inode, int add)
+{
+	struct nfs_inode *nfsi;
+	struct nfs4_xattr_cache *cache, *oldcache, *newcache;
+
+	nfsi = NFS_I(inode);
+
+	cache = oldcache = NULL;
+
+	spin_lock(&inode->i_lock);
+
+	if (nfsi->cache_validity & NFS_INO_INVALID_XATTR)
+		oldcache = nfs4_xattr_cache_unlink(inode);
+	else
+		cache = nfsi->xattr_cache;
+
+	if (cache != NULL)
+		kref_get(&cache->ref);
+
+	spin_unlock(&inode->i_lock);
+
+	if (add && cache == NULL) {
+		newcache = NULL;
+
+		cache = nfs4_xattr_alloc_cache();
+		if (cache == NULL)
+			goto out;
+
+		spin_lock(&inode->i_lock);
+		if (nfsi->cache_validity & NFS_INO_INVALID_XATTR) {
+			/*
+			 * The cache was invalidated again. Give up,
+			 * since what we want to enter is now likely
+			 * outdated anyway.
+			 */
+			spin_unlock(&inode->i_lock);
+			kref_put(&cache->ref, nfs4_xattr_free_cache_cb);
+			cache = NULL;
+			goto out;
+		}
+
+		/*
+		 * Check if someone beat us to it.
+		 */
+		if (nfsi->xattr_cache != NULL) {
+			newcache = nfsi->xattr_cache;
+			kref_get(&newcache->ref);
+		} else {
+			kref_get(&cache->ref);
+			nfsi->xattr_cache = cache;
+			cache->inode = inode;
+			list_lru_add(&nfs4_xattr_cache_lru, &cache->lru);
+		}
+
+		spin_unlock(&inode->i_lock);
+
+		/*
+		 * If there was a race, throw away the cache we just
+		 * allocated, and use the new one allocated by someone
+		 * else.
+		 */
+		if (newcache != NULL) {
+			kref_put(&cache->ref, nfs4_xattr_free_cache_cb);
+			cache = newcache;
+		}
+	}
+
+out:
+	/*
+	 * Discarding an old cache is done via a workqueue.
+	 */
+	if (oldcache != NULL)
+		nfs4_xattr_reap_cache(oldcache);
+
+	return cache;
+}
+
+static inline struct nfs4_xattr_bucket *
+nfs4_xattr_hash_bucket(struct nfs4_xattr_cache *cache, const char *name)
+{
+	return &cache->buckets[jhash(name, strlen(name), 0) &
+	    (ARRAY_SIZE(cache->buckets) - 1)];
+}
+
+static struct nfs4_xattr_entry *
+nfs4_xattr_get_entry(struct nfs4_xattr_bucket *bucket, const char *name)
+{
+	struct nfs4_xattr_entry *entry;
+
+	entry = NULL;
+
+	hlist_for_each_entry(entry, &bucket->hlist, hnode) {
+		if (!strcmp(entry->xattr_name, name))
+			break;
+	}
+
+	return entry;
+}
+
+static int
+nfs4_xattr_hash_add(struct nfs4_xattr_cache *cache,
+		    struct nfs4_xattr_entry *entry)
+{
+	struct nfs4_xattr_bucket *bucket;
+	struct nfs4_xattr_entry *oldentry = NULL;
+	int ret = 1;
+
+	bucket = nfs4_xattr_hash_bucket(cache, entry->xattr_name);
+	entry->bucket = bucket;
+
+	spin_lock(&bucket->lock);
+
+	if (bucket->draining) {
+		ret = 0;
+		goto out;
+	}
+
+	oldentry = nfs4_xattr_get_entry(bucket, entry->xattr_name);
+	if (oldentry != NULL) {
+		hlist_del_init(&oldentry->hnode);
+		nfs4_xattr_entry_lru_del(oldentry);
+	} else {
+		atomic_long_inc(&cache->nent);
+	}
+
+	hlist_add_head(&entry->hnode, &bucket->hlist);
+	nfs4_xattr_entry_lru_add(entry);
+
+out:
+	spin_unlock(&bucket->lock);
+
+	if (oldentry != NULL)
+		kref_put(&oldentry->ref, nfs4_xattr_free_entry_cb);
+
+	return ret;
+}
+
+static void
+nfs4_xattr_hash_remove(struct nfs4_xattr_cache *cache, const char *name)
+{
+	struct nfs4_xattr_bucket *bucket;
+	struct nfs4_xattr_entry *entry;
+
+	bucket = nfs4_xattr_hash_bucket(cache, name);
+
+	spin_lock(&bucket->lock);
+
+	entry = nfs4_xattr_get_entry(bucket, name);
+	if (entry != NULL) {
+		hlist_del_init(&entry->hnode);
+		nfs4_xattr_entry_lru_del(entry);
+		atomic_long_dec(&cache->nent);
+	}
+
+	spin_unlock(&bucket->lock);
+
+	if (entry != NULL)
+		kref_put(&entry->ref, nfs4_xattr_free_entry_cb);
+}
+
+static struct nfs4_xattr_entry *
+nfs4_xattr_hash_find(struct nfs4_xattr_cache *cache, const char *name)
+{
+	struct nfs4_xattr_bucket *bucket;
+	struct nfs4_xattr_entry *entry;
+
+	bucket = nfs4_xattr_hash_bucket(cache, name);
+
+	spin_lock(&bucket->lock);
+
+	entry = nfs4_xattr_get_entry(bucket, name);
+	if (entry != NULL)
+		kref_get(&entry->ref);
+
+	spin_unlock(&bucket->lock);
+
+	return entry;
+}
+
+/*
+ * Entry point to retrieve an entry from the cache.
+ */
+ssize_t nfs4_xattr_cache_get(struct inode *inode, const char *name, char *buf,
+			 ssize_t buflen)
+{
+	struct nfs4_xattr_cache *cache;
+	struct nfs4_xattr_entry *entry;
+	ssize_t ret;
+
+	cache = nfs4_xattr_get_cache(inode, 0);
+	if (cache == NULL)
+		return -ENOENT;
+
+	ret = 0;
+	entry = nfs4_xattr_hash_find(cache, name);
+
+	if (entry != NULL) {
+		dprintk("%s: cache hit '%s', len %lu\n", __func__,
+		    entry->xattr_name, (unsigned long)entry->xattr_size);
+		if (buflen == 0) {
+			/* Length probe only */
+			ret = entry->xattr_size;
+		} else if (buflen < entry->xattr_size)
+			ret = -ERANGE;
+		else {
+			memcpy(buf, entry->xattr_value, entry->xattr_size);
+			ret = entry->xattr_size;
+		}
+		kref_put(&entry->ref, nfs4_xattr_free_entry_cb);
+	} else {
+		dprintk("%s: cache miss '%s'\n", __func__, name);
+		ret = -ENOENT;
+	}
+
+	kref_put(&cache->ref, nfs4_xattr_free_cache_cb);
+
+	return ret;
+}
+
+/*
+ * Retrieve a cached list of xattrs from the cache.
+ */
+ssize_t nfs4_xattr_cache_list(struct inode *inode, char *buf, ssize_t buflen)
+{
+	struct nfs4_xattr_cache *cache;
+	struct nfs4_xattr_entry *entry;
+	ssize_t ret;
+
+	cache = nfs4_xattr_get_cache(inode, 0);
+	if (cache == NULL)
+		return -ENOENT;
+
+	spin_lock(&cache->listxattr_lock);
+
+	entry = cache->listxattr;
+
+	if (entry != NULL && entry != ERR_PTR(-ESTALE)) {
+		if (buflen == 0) {
+			/* Length probe only */
+			ret = entry->xattr_size;
+		} else if (entry->xattr_size > buflen)
+			ret = -ERANGE;
+		else {
+			memcpy(buf, entry->xattr_value, entry->xattr_size);
+			ret = entry->xattr_size;
+		}
+	} else {
+		ret = -ENOENT;
+	}
+
+	spin_unlock(&cache->listxattr_lock);
+
+	kref_put(&cache->ref, nfs4_xattr_free_cache_cb);
+
+	return ret;
+}
+
+/*
+ * Add an xattr to the cache.
+ *
+ * This also invalidates the xattr list cache.
+ */
+void nfs4_xattr_cache_add(struct inode *inode, const char *name,
+			  const char *buf, struct page **pages, ssize_t buflen)
+{
+	struct nfs4_xattr_cache *cache;
+	struct nfs4_xattr_entry *entry;
+
+	dprintk("%s: add '%s' len %lu\n", __func__,
+	    name, (unsigned long)buflen);
+
+	cache = nfs4_xattr_get_cache(inode, 1);
+	if (cache == NULL)
+		return;
+
+	entry = nfs4_xattr_alloc_entry(name, buf, pages, buflen);
+	if (entry == NULL)
+		goto out;
+
+	(void)nfs4_xattr_set_listcache(cache, NULL);
+
+	if (!nfs4_xattr_hash_add(cache, entry))
+		kref_put(&entry->ref, nfs4_xattr_free_entry_cb);
+
+out:
+	kref_put(&cache->ref, nfs4_xattr_free_cache_cb);
+}
+
+
+/*
+ * Remove an xattr from the cache.
+ *
+ * This also invalidates the xattr list cache.
+ */
+void nfs4_xattr_cache_remove(struct inode *inode, const char *name)
+{
+	struct nfs4_xattr_cache *cache;
+
+	dprintk("%s: remove '%s'\n", __func__, name);
+
+	cache = nfs4_xattr_get_cache(inode, 0);
+	if (cache == NULL)
+		return;
+
+	(void)nfs4_xattr_set_listcache(cache, NULL);
+	nfs4_xattr_hash_remove(cache, name);
+
+	kref_put(&cache->ref, nfs4_xattr_free_cache_cb);
+}
+
+/*
+ * Cache listxattr output, replacing any possible old one.
+ */
+void nfs4_xattr_cache_set_list(struct inode *inode, const char *buf,
+			       ssize_t buflen)
+{
+	struct nfs4_xattr_cache *cache;
+	struct nfs4_xattr_entry *entry;
+
+	cache = nfs4_xattr_get_cache(inode, 1);
+	if (cache == NULL)
+		return;
+
+	entry = nfs4_xattr_alloc_entry(NULL, buf, NULL, buflen);
+	if (entry == NULL)
+		goto out;
+
+	/*
+	 * This is just there to be able to get to bucket->cache,
+	 * which is obviously the same for all buckets, so just
+	 * use bucket 0.
+	 */
+	entry->bucket = &cache->buckets[0];
+
+	if (!nfs4_xattr_set_listcache(cache, entry))
+		kref_put(&entry->ref, nfs4_xattr_free_entry_cb);
+
+out:
+	kref_put(&cache->ref, nfs4_xattr_free_cache_cb);
+}
+
+/*
+ * Zap the entire cache. Called when an inode is evicted.
+ */
+void nfs4_xattr_cache_zap(struct inode *inode)
+{
+	struct nfs4_xattr_cache *oldcache;
+
+	spin_lock(&inode->i_lock);
+	oldcache = nfs4_xattr_cache_unlink(inode);
+	spin_unlock(&inode->i_lock);
+
+	if (oldcache)
+		nfs4_xattr_discard_cache(oldcache);
+}
+
+/*
+ * The entry LRU is shrunk more aggressively than the cache LRU,
+ * by settings @seeks to 1.
+ *
+ * Cache structures are freed only when they've become empty, after
+ * pruning all but one entry.
+ */
+
+static unsigned long nfs4_xattr_cache_count(struct shrinker *shrink,
+					    struct shrink_control *sc);
+static unsigned long nfs4_xattr_entry_count(struct shrinker *shrink,
+					    struct shrink_control *sc);
+static unsigned long nfs4_xattr_cache_scan(struct shrinker *shrink,
+					   struct shrink_control *sc);
+static unsigned long nfs4_xattr_entry_scan(struct shrinker *shrink,
+					   struct shrink_control *sc);
+
+static struct shrinker nfs4_xattr_cache_shrinker = {
+	.count_objects	= nfs4_xattr_cache_count,
+	.scan_objects	= nfs4_xattr_cache_scan,
+	.seeks		= DEFAULT_SEEKS,
+	.flags		= SHRINKER_MEMCG_AWARE,
+};
+
+static struct shrinker nfs4_xattr_entry_shrinker = {
+	.count_objects	= nfs4_xattr_entry_count,
+	.scan_objects	= nfs4_xattr_entry_scan,
+	.seeks		= DEFAULT_SEEKS,
+	.batch		= 512,
+	.flags		= SHRINKER_MEMCG_AWARE,
+};
+
+static struct shrinker nfs4_xattr_large_entry_shrinker = {
+	.count_objects	= nfs4_xattr_entry_count,
+	.scan_objects	= nfs4_xattr_entry_scan,
+	.seeks		= 1,
+	.batch		= 512,
+	.flags		= SHRINKER_MEMCG_AWARE,
+};
+
+static enum lru_status
+cache_lru_isolate(struct list_head *item,
+	struct list_lru_one *lru, spinlock_t *lru_lock, void *arg)
+{
+	struct list_head *dispose = arg;
+	struct inode *inode;
+	struct nfs4_xattr_cache *cache = container_of(item,
+	    struct nfs4_xattr_cache, lru);
+
+	if (atomic_long_read(&cache->nent) > 1)
+		return LRU_SKIP;
+
+	/*
+	 * If a cache structure is on the LRU list, we know that
+	 * its inode is valid. Try to lock it to break the link.
+	 * Since we're inverting the lock order here, only try.
+	 */
+	inode = cache->inode;
+
+	if (!spin_trylock(&inode->i_lock))
+		return LRU_SKIP;
+
+	kref_get(&cache->ref);
+
+	cache->inode = NULL;
+	NFS_I(inode)->xattr_cache = NULL;
+	NFS_I(inode)->cache_validity &= ~NFS_INO_INVALID_XATTR;
+	list_lru_isolate(lru, &cache->lru);
+
+	spin_unlock(&inode->i_lock);
+
+	list_add_tail(&cache->dispose, dispose);
+	return LRU_REMOVED;
+}
+
+static unsigned long
+nfs4_xattr_cache_scan(struct shrinker *shrink, struct shrink_control *sc)
+{
+	LIST_HEAD(dispose);
+	unsigned long freed;
+	struct nfs4_xattr_cache *cache;
+
+	freed = list_lru_shrink_walk(&nfs4_xattr_cache_lru, sc,
+	    cache_lru_isolate, &dispose);
+	while (!list_empty(&dispose)) {
+		cache = list_first_entry(&dispose, struct nfs4_xattr_cache,
+		    dispose);
+		list_del_init(&cache->dispose);
+		nfs4_xattr_discard_cache(cache);
+		kref_put(&cache->ref, nfs4_xattr_free_cache_cb);
+	}
+
+	return freed;
+}
+
+
+static unsigned long
+nfs4_xattr_cache_count(struct shrinker *shrink, struct shrink_control *sc)
+{
+	unsigned long count;
+
+	count = list_lru_count(&nfs4_xattr_cache_lru);
+	return vfs_pressure_ratio(count);
+}
+
+static enum lru_status
+entry_lru_isolate(struct list_head *item,
+	struct list_lru_one *lru, spinlock_t *lru_lock, void *arg)
+{
+	struct list_head *dispose = arg;
+	struct nfs4_xattr_bucket *bucket;
+	struct nfs4_xattr_cache *cache;
+	struct nfs4_xattr_entry *entry = container_of(item,
+	    struct nfs4_xattr_entry, lru);
+
+	bucket = entry->bucket;
+	cache = bucket->cache;
+
+	/*
+	 * Unhook the entry from its parent (either a cache bucket
+	 * or a cache structure if it's a listxattr buf), so that
+	 * it's no longer found. Then add it to the isolate list,
+	 * to be freed later.
+	 *
+	 * In both cases, we're reverting lock order, so use
+	 * trylock and skip the entry if we can't get the lock.
+	 */
+	if (entry->xattr_name != NULL) {
+		/* Regular cache entry */
+		if (!spin_trylock(&bucket->lock))
+			return LRU_SKIP;
+
+		kref_get(&entry->ref);
+
+		hlist_del_init(&entry->hnode);
+		atomic_long_dec(&cache->nent);
+		list_lru_isolate(lru, &entry->lru);
+
+		spin_unlock(&bucket->lock);
+	} else {
+		/* Listxattr cache entry */
+		if (!spin_trylock(&cache->listxattr_lock))
+			return LRU_SKIP;
+
+		kref_get(&entry->ref);
+
+		cache->listxattr = NULL;
+		list_lru_isolate(lru, &entry->lru);
+
+		spin_unlock(&cache->listxattr_lock);
+	}
+
+	list_add_tail(&entry->dispose, dispose);
+	return LRU_REMOVED;
+}
+
+static unsigned long
+nfs4_xattr_entry_scan(struct shrinker *shrink, struct shrink_control *sc)
+{
+	LIST_HEAD(dispose);
+	unsigned long freed;
+	struct nfs4_xattr_entry *entry;
+	struct list_lru *lru;
+
+	lru = (shrink == &nfs4_xattr_large_entry_shrinker) ?
+	    &nfs4_xattr_large_entry_lru : &nfs4_xattr_entry_lru;
+
+	freed = list_lru_shrink_walk(lru, sc, entry_lru_isolate, &dispose);
+
+	while (!list_empty(&dispose)) {
+		entry = list_first_entry(&dispose, struct nfs4_xattr_entry,
+		    dispose);
+		list_del_init(&entry->dispose);
+
+		/*
+		 * Drop two references: the one that we just grabbed
+		 * in entry_lru_isolate, and the one that was set
+		 * when the entry was first allocated.
+		 */
+		kref_put(&entry->ref, nfs4_xattr_free_entry_cb);
+		kref_put(&entry->ref, nfs4_xattr_free_entry_cb);
+	}
+
+	return freed;
+}
+
+static unsigned long
+nfs4_xattr_entry_count(struct shrinker *shrink, struct shrink_control *sc)
+{
+	unsigned long count;
+	struct list_lru *lru;
+
+	lru = (shrink == &nfs4_xattr_large_entry_shrinker) ?
+	    &nfs4_xattr_large_entry_lru : &nfs4_xattr_entry_lru;
+
+	count = list_lru_count(lru);
+	return vfs_pressure_ratio(count);
+}
+
+
+static void nfs4_xattr_cache_init_once(void *p)
+{
+	struct nfs4_xattr_cache *cache = (struct nfs4_xattr_cache *)p;
+
+	spin_lock_init(&cache->listxattr_lock);
+	atomic_long_set(&cache->nent, 0);
+	nfs4_xattr_hash_init(cache);
+	cache->listxattr = NULL;
+	INIT_WORK(&cache->work, nfs4_xattr_discard_cache_worker);
+	INIT_LIST_HEAD(&cache->lru);
+	INIT_LIST_HEAD(&cache->dispose);
+}
+
+int __init nfs4_xattr_cache_init(void)
+{
+	int ret = 0;
+
+	nfs4_xattr_cache_cachep = kmem_cache_create("nfs4_xattr_cache_cache",
+	    sizeof(struct nfs4_xattr_cache), 0,
+	    (SLAB_RECLAIM_ACCOUNT|SLAB_MEM_SPREAD|SLAB_ACCOUNT),
+	    nfs4_xattr_cache_init_once);
+	if (nfs4_xattr_cache_cachep == NULL)
+		return -ENOMEM;
+
+	ret = list_lru_init_memcg(&nfs4_xattr_large_entry_lru,
+	    &nfs4_xattr_large_entry_shrinker);
+	if (ret)
+		goto out4;
+
+	ret = list_lru_init_memcg(&nfs4_xattr_entry_lru,
+	    &nfs4_xattr_entry_shrinker);
+	if (ret)
+		goto out3;
+
+	ret = list_lru_init_memcg(&nfs4_xattr_cache_lru,
+	    &nfs4_xattr_cache_shrinker);
+	if (ret)
+		goto out2;
+
+	nfs4_xattr_cache_wq = alloc_workqueue("nfs4_xattr", WQ_MEM_RECLAIM, 0);
+	if (nfs4_xattr_cache_wq == NULL)
+		goto out1;
+
+	ret = register_shrinker(&nfs4_xattr_cache_shrinker);
+	if (ret)
+		goto out0;
+
+	ret = register_shrinker(&nfs4_xattr_entry_shrinker);
+	if (ret)
+		goto out;
+
+	ret = register_shrinker(&nfs4_xattr_large_entry_shrinker);
+	if (!ret)
+		return 0;
+
+	unregister_shrinker(&nfs4_xattr_entry_shrinker);
+out:
+	unregister_shrinker(&nfs4_xattr_cache_shrinker);
+out0:
+	destroy_workqueue(nfs4_xattr_cache_wq);
+out1:
+	list_lru_destroy(&nfs4_xattr_cache_lru);
+out2:
+	list_lru_destroy(&nfs4_xattr_entry_lru);
+out3:
+	list_lru_destroy(&nfs4_xattr_large_entry_lru);
+out4:
+	kmem_cache_destroy(nfs4_xattr_cache_cachep);
+
+	return ret;
+}
+
+void nfs4_xattr_cache_exit(void)
+{
+	unregister_shrinker(&nfs4_xattr_entry_shrinker);
+	unregister_shrinker(&nfs4_xattr_cache_shrinker);
+	list_lru_destroy(&nfs4_xattr_entry_lru);
+	list_lru_destroy(&nfs4_xattr_cache_lru);
+	kmem_cache_destroy(nfs4_xattr_cache_cachep);
+	destroy_workqueue(nfs4_xattr_cache_wq);
+}
diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
index 6df94857f5bb..079c1ac84cee 100644
--- a/fs/nfs/nfs4proc.c
+++ b/fs/nfs/nfs4proc.c
@@ -7459,6 +7459,7 @@ static int nfs4_xattr_set_nfs4_user(const struct xattr_handler *handler,
 				    size_t buflen, int flags)
 {
 	struct nfs_access_entry cache;
+	int ret;
 
 	if (!nfs_server_capable(inode, NFS_CAP_XATTR))
 		return -EOPNOTSUPP;
@@ -7477,10 +7478,17 @@ static int nfs4_xattr_set_nfs4_user(const struct xattr_handler *handler,
 			return -EACCES;
 	}
 
-	if (buf == NULL)
-		return nfs42_proc_removexattr(inode, key);
-	else
-		return nfs42_proc_setxattr(inode, key, buf, buflen, flags);
+	if (buf == NULL) {
+		ret = nfs42_proc_removexattr(inode, key);
+		if (!ret)
+			nfs4_xattr_cache_remove(inode, key);
+	} else {
+		ret = nfs42_proc_setxattr(inode, key, buf, buflen, flags);
+		if (!ret)
+			nfs4_xattr_cache_add(inode, key, buf, NULL, buflen);
+	}
+
+	return ret;
 }
 
 static int nfs4_xattr_get_nfs4_user(const struct xattr_handler *handler,
@@ -7488,6 +7496,7 @@ static int nfs4_xattr_get_nfs4_user(const struct xattr_handler *handler,
 				    const char *key, void *buf, size_t buflen)
 {
 	struct nfs_access_entry cache;
+	ssize_t ret;
 
 	if (!nfs_server_capable(inode, NFS_CAP_XATTR))
 		return -EOPNOTSUPP;
@@ -7497,7 +7506,17 @@ static int nfs4_xattr_get_nfs4_user(const struct xattr_handler *handler,
 			return -EACCES;
 	}
 
-	return nfs42_proc_getxattr(inode, key, buf, buflen);
+	ret = nfs_revalidate_inode(NFS_SERVER(inode), inode);
+	if (ret)
+		return ret;
+
+	ret = nfs4_xattr_cache_get(inode, key, buf, buflen);
+	if (ret >= 0 || (ret < 0 && ret != -ENOENT))
+		return ret;
+
+	ret = nfs42_proc_getxattr(inode, key, buf, buflen);
+
+	return ret;
 }
 
 static ssize_t
@@ -7505,7 +7524,7 @@ nfs4_listxattr_nfs4_user(struct inode *inode, char *list, size_t list_len)
 {
 	u64 cookie;
 	bool eof;
-	int ret, size;
+	ssize_t ret, size;
 	char *buf;
 	size_t buflen;
 	struct nfs_access_entry cache;
@@ -7518,6 +7537,14 @@ nfs4_listxattr_nfs4_user(struct inode *inode, char *list, size_t list_len)
 			return 0;
 	}
 
+	ret = nfs_revalidate_inode(NFS_SERVER(inode), inode);
+	if (ret)
+		return ret;
+
+	ret = nfs4_xattr_cache_list(inode, list, list_len);
+	if (ret >= 0 || (ret < 0 && ret != -ENOENT))
+		return ret;
+
 	cookie = 0;
 	eof = false;
 	buflen = list_len ? list_len : XATTR_LIST_MAX;
@@ -7537,6 +7564,9 @@ nfs4_listxattr_nfs4_user(struct inode *inode, char *list, size_t list_len)
 		size += ret;
 	}
 
+	if (list_len)
+		nfs4_xattr_cache_set_list(inode, list, size);
+
 	return size;
 }
 
diff --git a/fs/nfs/nfs4super.c b/fs/nfs/nfs4super.c
index 1475f932d7da..0c1ab846b83d 100644
--- a/fs/nfs/nfs4super.c
+++ b/fs/nfs/nfs4super.c
@@ -69,6 +69,7 @@ static void nfs4_evict_inode(struct inode *inode)
 	pnfs_destroy_layout(NFS_I(inode));
 	/* First call standard NFS clear_inode() code */
 	nfs_clear_inode(inode);
+	nfs4_xattr_cache_zap(inode);
 }
 
 struct nfs_referral_count {
@@ -268,6 +269,12 @@ static int __init init_nfs_v4(void)
 	if (err)
 		goto out1;
 
+#ifdef CONFIG_NFS_V4_2
+	err = nfs4_xattr_cache_init();
+	if (err)
+		goto out2;
+#endif
+
 	err = nfs4_register_sysctl();
 	if (err)
 		goto out2;
@@ -288,6 +295,9 @@ static void __exit exit_nfs_v4(void)
 	nfs4_pnfs_v3_ds_connect_unload();
 
 	unregister_nfs_version(&nfs_v4);
+#ifdef CONFIG_NFS_V4_2
+	nfs4_xattr_cache_exit();
+#endif
 	nfs4_unregister_sysctl();
 	nfs_idmap_quit();
 	nfs_dns_resolver_destroy();
diff --git a/include/linux/nfs_fs.h b/include/linux/nfs_fs.h
index 1fcfef670a4a..c08cc22d9c32 100644
--- a/include/linux/nfs_fs.h
+++ b/include/linux/nfs_fs.h
@@ -102,6 +102,8 @@ struct nfs_delegation;
 
 struct posix_acl;
 
+struct nfs4_xattr_cache;
+
 /*
  * nfs fs inode data in memory
  */
@@ -188,6 +190,10 @@ struct nfs_inode {
 	struct fscache_cookie	*fscache;
 #endif
 	struct inode		vfs_inode;
+
+#ifdef CONFIG_NFS_V4_2
+	struct nfs4_xattr_cache *xattr_cache;
+#endif
 };
 
 struct nfs4_copy_state {
diff --git a/include/uapi/linux/nfs_fs.h b/include/uapi/linux/nfs_fs.h
index 7bcc8cd6831d..3afe3767c55d 100644
--- a/include/uapi/linux/nfs_fs.h
+++ b/include/uapi/linux/nfs_fs.h
@@ -56,6 +56,7 @@
 #define NFSDBG_PNFS		0x1000
 #define NFSDBG_PNFS_LD		0x2000
 #define NFSDBG_STATE		0x4000
+#define NFSDBG_XATTRCACHE	0x8000
 #define NFSDBG_ALL		0xFFFF
 
 
-- 
2.16.6


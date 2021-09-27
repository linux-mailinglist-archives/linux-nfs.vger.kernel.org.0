Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 310E241A3EC
	for <lists+linux-nfs@lfdr.de>; Tue, 28 Sep 2021 01:49:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237972AbhI0Xum (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 27 Sep 2021 19:50:42 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:35408 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238189AbhI0Xuk (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 27 Sep 2021 19:50:40 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id EB49C201AD;
        Mon, 27 Sep 2021 23:49:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1632786540; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=mWw2hiME+ZZrkLfl3tbKKa/7rv0k934xGVZZGKOOI0k=;
        b=i/FTaIJqn26GEgpTuLtAQ9LHaqmQzk6WhhBf5cI5cXPB9pfV7B/YqHSrhzEZB7sEWQHRFq
        jnQ/FFiVAaOnl5TykxT8ri8zJbikGX76/TzIiyj8qPHZ+A0pc9oSbEpcHI2RsKFdo3toOm
        SVH5WUC+FSds68fgd4FaX6Itk1CHIX4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1632786540;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=mWw2hiME+ZZrkLfl3tbKKa/7rv0k934xGVZZGKOOI0k=;
        b=uyPXX6/gzZ0i6iQTK7Iv4N67DsGCBc2bf1V5JJuCvh3mIgjO69Jvh6Pv7F0weawDZsZVNf
        YpxcMl1BHXx8zHAA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id DEA1813A5D;
        Mon, 27 Sep 2021 23:48:59 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id NfIPJ2tYUmGDJQAAMHmgww
        (envelope-from <neilb@suse.de>); Mon, 27 Sep 2021 23:48:59 +0000
Subject: [PATCH 1/3] NFS: change nfs_access_get_cached to only report the mask
From:   NeilBrown <neilb@suse.de>
To:     Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>
Cc:     linux-nfs@vger.kernel.org
Date:   Tue, 28 Sep 2021 09:47:57 +1000
Message-ID: <163278647709.17728.7450732027488004355.stgit@noble.brown>
In-Reply-To: <163278643081.17728.10586733395858659759.stgit@noble.brown>
References: <163278643081.17728.10586733395858659759.stgit@noble.brown>
User-Agent: StGit/0.23
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Currently the nfs_access_get_cached family of functions report a
'struct nfs_access_entry' as the result, with both .mask and .cred set.
However the .cred is never used.  This is probably good and there is no
guarantee that it won't be freed before use.

Change to only report the 'mask' - as this is all that is used or needed.

Signed-off-by: NeilBrown <neilb@suse.de>
---
 fs/nfs/dir.c           |   20 +++++++++-----------
 fs/nfs/nfs4proc.c      |   18 +++++++++---------
 include/linux/nfs_fs.h |    4 ++--
 3 files changed, 20 insertions(+), 22 deletions(-)

diff --git a/fs/nfs/dir.c b/fs/nfs/dir.c
index 1a6d2867fba4..96b5019c6748 100644
--- a/fs/nfs/dir.c
+++ b/fs/nfs/dir.c
@@ -2676,7 +2676,7 @@ static struct nfs_access_entry *nfs_access_search_rbtree(struct inode *inode, co
 	return NULL;
 }
 
-static int nfs_access_get_cached_locked(struct inode *inode, const struct cred *cred, struct nfs_access_entry *res, bool may_block)
+static int nfs_access_get_cached_locked(struct inode *inode, const struct cred *cred, u32 *mask, bool may_block)
 {
 	struct nfs_inode *nfsi = NFS_I(inode);
 	struct nfs_access_entry *cache;
@@ -2706,8 +2706,7 @@ static int nfs_access_get_cached_locked(struct inode *inode, const struct cred *
 		spin_lock(&inode->i_lock);
 		retry = false;
 	}
-	res->cred = cache->cred;
-	res->mask = cache->mask;
+	*mask = cache->mask;
 	list_move_tail(&cache->lru, &nfsi->access_cache_entry_lru);
 	err = 0;
 out:
@@ -2719,7 +2718,7 @@ static int nfs_access_get_cached_locked(struct inode *inode, const struct cred *
 	return -ENOENT;
 }
 
-static int nfs_access_get_cached_rcu(struct inode *inode, const struct cred *cred, struct nfs_access_entry *res)
+static int nfs_access_get_cached_rcu(struct inode *inode, const struct cred *cred, u32 *mask)
 {
 	/* Only check the most recently returned cache entry,
 	 * but do it without locking.
@@ -2741,22 +2740,21 @@ static int nfs_access_get_cached_rcu(struct inode *inode, const struct cred *cre
 		goto out;
 	if (nfs_check_cache_invalid(inode, NFS_INO_INVALID_ACCESS))
 		goto out;
-	res->cred = cache->cred;
-	res->mask = cache->mask;
+	*mask = cache->mask;
 	err = 0;
 out:
 	rcu_read_unlock();
 	return err;
 }
 
-int nfs_access_get_cached(struct inode *inode, const struct cred *cred, struct
-nfs_access_entry *res, bool may_block)
+int nfs_access_get_cached(struct inode *inode, const struct cred *cred,
+			  u32 *mask, bool may_block)
 {
 	int status;
 
-	status = nfs_access_get_cached_rcu(inode, cred, res);
+	status = nfs_access_get_cached_rcu(inode, cred, mask);
 	if (status != 0)
-		status = nfs_access_get_cached_locked(inode, cred, res,
+		status = nfs_access_get_cached_locked(inode, cred, mask,
 		    may_block);
 
 	return status;
@@ -2877,7 +2875,7 @@ static int nfs_do_access(struct inode *inode, const struct cred *cred, int mask)
 
 	trace_nfs_access_enter(inode);
 
-	status = nfs_access_get_cached(inode, cred, &cache, may_block);
+	status = nfs_access_get_cached(inode, cred, &cache.mask, may_block);
 	if (status == 0)
 		goto out_cached;
 
diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
index e1214bb6b7ee..dabea09060e6 100644
--- a/fs/nfs/nfs4proc.c
+++ b/fs/nfs/nfs4proc.c
@@ -7676,7 +7676,7 @@ static int nfs4_xattr_set_nfs4_user(const struct xattr_handler *handler,
 				    const char *key, const void *buf,
 				    size_t buflen, int flags)
 {
-	struct nfs_access_entry cache;
+	u32 mask;
 	int ret;
 
 	if (!nfs_server_capable(inode, NFS_CAP_XATTR))
@@ -7691,8 +7691,8 @@ static int nfs4_xattr_set_nfs4_user(const struct xattr_handler *handler,
 	 * do a cached access check for the XA* flags to possibly avoid
 	 * doing an RPC and getting EACCES back.
 	 */
-	if (!nfs_access_get_cached(inode, current_cred(), &cache, true)) {
-		if (!(cache.mask & NFS_ACCESS_XAWRITE))
+	if (!nfs_access_get_cached(inode, current_cred(), &mask, true)) {
+		if (!(mask & NFS_ACCESS_XAWRITE))
 			return -EACCES;
 	}
 
@@ -7713,14 +7713,14 @@ static int nfs4_xattr_get_nfs4_user(const struct xattr_handler *handler,
 				    struct dentry *unused, struct inode *inode,
 				    const char *key, void *buf, size_t buflen)
 {
-	struct nfs_access_entry cache;
+	u32 mask;
 	ssize_t ret;
 
 	if (!nfs_server_capable(inode, NFS_CAP_XATTR))
 		return -EOPNOTSUPP;
 
-	if (!nfs_access_get_cached(inode, current_cred(), &cache, true)) {
-		if (!(cache.mask & NFS_ACCESS_XAREAD))
+	if (!nfs_access_get_cached(inode, current_cred(), &mask, true)) {
+		if (!(mask & NFS_ACCESS_XAREAD))
 			return -EACCES;
 	}
 
@@ -7745,13 +7745,13 @@ nfs4_listxattr_nfs4_user(struct inode *inode, char *list, size_t list_len)
 	ssize_t ret, size;
 	char *buf;
 	size_t buflen;
-	struct nfs_access_entry cache;
+	u32 mask;
 
 	if (!nfs_server_capable(inode, NFS_CAP_XATTR))
 		return 0;
 
-	if (!nfs_access_get_cached(inode, current_cred(), &cache, true)) {
-		if (!(cache.mask & NFS_ACCESS_XALIST))
+	if (!nfs_access_get_cached(inode, current_cred(), &mask, true)) {
+		if (!(mask & NFS_ACCESS_XALIST))
 			return 0;
 	}
 
diff --git a/include/linux/nfs_fs.h b/include/linux/nfs_fs.h
index b9a8b925db43..56609378159f 100644
--- a/include/linux/nfs_fs.h
+++ b/include/linux/nfs_fs.h
@@ -517,8 +517,8 @@ extern int nfs_instantiate(struct dentry *dentry, struct nfs_fh *fh,
 			struct nfs_fattr *fattr, struct nfs4_label *label);
 extern int nfs_may_open(struct inode *inode, const struct cred *cred, int openflags);
 extern void nfs_access_zap_cache(struct inode *inode);
-extern int nfs_access_get_cached(struct inode *inode, const struct cred *cred, struct nfs_access_entry *res,
-				 bool may_block);
+extern int nfs_access_get_cached(struct inode *inode, const struct cred *cred,
+				 u32 *mask, bool may_block);
 
 /*
  * linux/fs/nfs/symlink.c



Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 56E5741A3ED
	for <lists+linux-nfs@lfdr.de>; Tue, 28 Sep 2021 01:49:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238153AbhI0Xup (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 27 Sep 2021 19:50:45 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:35420 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238189AbhI0Xuo (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 27 Sep 2021 19:50:44 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 4E403201AD;
        Mon, 27 Sep 2021 23:49:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1632786545; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2qN26GcldooHs+qxrodX/678EgvrDsK9S4yKSvPWc0E=;
        b=HOltGNscwi7QKDaoLQLfhP4YldrqRsWdhEov8AViJUyZVH+mQ+iLBhEXw8Vjrli7EC35FX
        Sbl4dAje36VEsVHR2JnDZEdC/u1nuQ2N1KRdD5qN8gbu5bj0xiwFTLu0MRSA5WJ7C3fb8f
        g/7xr23R4ipgN2MYS1mMGUCFqUuHx/k=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1632786545;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2qN26GcldooHs+qxrodX/678EgvrDsK9S4yKSvPWc0E=;
        b=pvpV4ZZJAi8e3uyOqJBhCDRc+08hc9c/Ok/KCwWHy2R/vCkMh+0+e45JY+CEAsrgyZRZEc
        s7Mf0/unDIIWo7DQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 4142B13A5D;
        Mon, 27 Sep 2021 23:49:04 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id eG2MAHBYUmGLJQAAMHmgww
        (envelope-from <neilb@suse.de>); Mon, 27 Sep 2021 23:49:04 +0000
Subject: [PATCH 2/3] NFS: pass cred explicitly for access tests
From:   NeilBrown <neilb@suse.de>
To:     Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>
Cc:     linux-nfs@vger.kernel.org
Date:   Tue, 28 Sep 2021 09:47:57 +1000
Message-ID: <163278647711.17728.14237571204536263214.stgit@noble.brown>
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

So a future patch will remove the ->cred ref from nfs_access_entry.

To prepare, change various functions to not assume there is a 'cred' in
the nfs_access_entry, but to pass the cred around explicitly.

Signed-off-by: NeilBrown <neilb@suse.de>
---
 fs/nfs/dir.c            |   17 ++++++++++-------
 fs/nfs/nfs3proc.c       |    5 +++--
 fs/nfs/nfs4proc.c       |   12 +++++++-----
 include/linux/nfs_fs.h  |    2 +-
 include/linux/nfs_xdr.h |    2 +-
 5 files changed, 22 insertions(+), 16 deletions(-)

diff --git a/fs/nfs/dir.c b/fs/nfs/dir.c
index 96b5019c6748..0cd66ff2b8ba 100644
--- a/fs/nfs/dir.c
+++ b/fs/nfs/dir.c
@@ -2761,7 +2761,9 @@ int nfs_access_get_cached(struct inode *inode, const struct cred *cred,
 }
 EXPORT_SYMBOL_GPL(nfs_access_get_cached);
 
-static void nfs_access_add_rbtree(struct inode *inode, struct nfs_access_entry *set)
+static void nfs_access_add_rbtree(struct inode *inode,
+				  struct nfs_access_entry *set,
+				  const struct cred *cred)
 {
 	struct nfs_inode *nfsi = NFS_I(inode);
 	struct rb_root *root_node = &nfsi->access_cache;
@@ -2774,7 +2776,7 @@ static void nfs_access_add_rbtree(struct inode *inode, struct nfs_access_entry *
 	while (*p != NULL) {
 		parent = *p;
 		entry = rb_entry(parent, struct nfs_access_entry, rb_node);
-		cmp = cred_fscmp(set->cred, entry->cred);
+		cmp = cred_fscmp(cred, entry->cred);
 
 		if (cmp < 0)
 			p = &parent->rb_left;
@@ -2796,13 +2798,14 @@ static void nfs_access_add_rbtree(struct inode *inode, struct nfs_access_entry *
 	nfs_access_free_entry(entry);
 }
 
-void nfs_access_add_cache(struct inode *inode, struct nfs_access_entry *set)
+void nfs_access_add_cache(struct inode *inode, struct nfs_access_entry *set,
+			  const struct cred *cred)
 {
 	struct nfs_access_entry *cache = kmalloc(sizeof(*cache), GFP_KERNEL);
 	if (cache == NULL)
 		return;
 	RB_CLEAR_NODE(&cache->rb_node);
-	cache->cred = get_cred(set->cred);
+	cache->cred = get_cred(cred);
 	cache->mask = set->mask;
 
 	/* The above field assignments must be visible
@@ -2810,7 +2813,7 @@ void nfs_access_add_cache(struct inode *inode, struct nfs_access_entry *set)
 	 * use rcu_assign_pointer, so just force the memory barrier.
 	 */
 	smp_wmb();
-	nfs_access_add_rbtree(inode, cache);
+	nfs_access_add_rbtree(inode, cache, cred);
 
 	/* Update accounting */
 	smp_mb__before_atomic();
@@ -2896,7 +2899,7 @@ static int nfs_do_access(struct inode *inode, const struct cred *cred, int mask)
 	else
 		cache.mask |= NFS_ACCESS_EXECUTE;
 	cache.cred = cred;
-	status = NFS_PROTO(inode)->access(inode, &cache);
+	status = NFS_PROTO(inode)->access(inode, &cache, cred);
 	if (status != 0) {
 		if (status == -ESTALE) {
 			if (!S_ISDIR(inode->i_mode))
@@ -2906,7 +2909,7 @@ static int nfs_do_access(struct inode *inode, const struct cred *cred, int mask)
 		}
 		goto out;
 	}
-	nfs_access_add_cache(inode, &cache);
+	nfs_access_add_cache(inode, &cache, cred);
 out_cached:
 	cache_mask = nfs_access_calc_mask(cache.mask, inode->i_mode);
 	if ((mask & ~cache_mask & (MAY_READ | MAY_WRITE | MAY_EXEC)) != 0)
diff --git a/fs/nfs/nfs3proc.c b/fs/nfs/nfs3proc.c
index f7524310ddf4..c18103292a73 100644
--- a/fs/nfs/nfs3proc.c
+++ b/fs/nfs/nfs3proc.c
@@ -222,7 +222,8 @@ static int nfs3_proc_lookupp(struct inode *inode, struct nfs_fh *fhandle,
 				  task_flags);
 }
 
-static int nfs3_proc_access(struct inode *inode, struct nfs_access_entry *entry)
+static int nfs3_proc_access(struct inode *inode, struct nfs_access_entry *entry,
+			    const struct cred *cred)
 {
 	struct nfs3_accessargs	arg = {
 		.fh		= NFS_FH(inode),
@@ -233,7 +234,7 @@ static int nfs3_proc_access(struct inode *inode, struct nfs_access_entry *entry)
 		.rpc_proc	= &nfs3_procedures[NFS3PROC_ACCESS],
 		.rpc_argp	= &arg,
 		.rpc_resp	= &res,
-		.rpc_cred	= entry->cred,
+		.rpc_cred	= cred,
 	};
 	int status = -ENOMEM;
 
diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
index dabea09060e6..5f622b099412 100644
--- a/fs/nfs/nfs4proc.c
+++ b/fs/nfs/nfs4proc.c
@@ -2655,7 +2655,7 @@ static int nfs4_opendata_access(const struct cred *cred,
 
 	cache.cred = cred;
 	nfs_access_set_mask(&cache, opendata->o_res.access_result);
-	nfs_access_add_cache(state->inode, &cache);
+	nfs_access_add_cache(state->inode, &cache, cred);
 
 	flags = NFS4_ACCESS_READ | NFS4_ACCESS_EXECUTE | NFS4_ACCESS_LOOKUP;
 	if ((mask & ~cache.mask & flags) == 0)
@@ -4472,7 +4472,8 @@ static int nfs4_proc_lookupp(struct inode *inode, struct nfs_fh *fhandle,
 	return err;
 }
 
-static int _nfs4_proc_access(struct inode *inode, struct nfs_access_entry *entry)
+static int _nfs4_proc_access(struct inode *inode, struct nfs_access_entry *entry,
+			     const struct cred *cred)
 {
 	struct nfs_server *server = NFS_SERVER(inode);
 	struct nfs4_accessargs args = {
@@ -4486,7 +4487,7 @@ static int _nfs4_proc_access(struct inode *inode, struct nfs_access_entry *entry
 		.rpc_proc = &nfs4_procedures[NFSPROC4_CLNT_ACCESS],
 		.rpc_argp = &args,
 		.rpc_resp = &res,
-		.rpc_cred = entry->cred,
+		.rpc_cred = cred,
 	};
 	int status = 0;
 
@@ -4506,14 +4507,15 @@ static int _nfs4_proc_access(struct inode *inode, struct nfs_access_entry *entry
 	return status;
 }
 
-static int nfs4_proc_access(struct inode *inode, struct nfs_access_entry *entry)
+static int nfs4_proc_access(struct inode *inode, struct nfs_access_entry *entry,
+			    const struct cred *cred)
 {
 	struct nfs4_exception exception = {
 		.interruptible = true,
 	};
 	int err;
 	do {
-		err = _nfs4_proc_access(inode, entry);
+		err = _nfs4_proc_access(inode, entry, cred);
 		trace_nfs4_access(inode, err);
 		err = nfs4_handle_exception(NFS_SERVER(inode), err,
 				&exception);
diff --git a/include/linux/nfs_fs.h b/include/linux/nfs_fs.h
index 56609378159f..6e356dbda519 100644
--- a/include/linux/nfs_fs.h
+++ b/include/linux/nfs_fs.h
@@ -391,7 +391,7 @@ extern int nfs_post_op_update_inode_force_wcc(struct inode *inode, struct nfs_fa
 extern int nfs_post_op_update_inode_force_wcc_locked(struct inode *inode, struct nfs_fattr *fattr);
 extern int nfs_getattr(struct user_namespace *, const struct path *,
 		       struct kstat *, u32, unsigned int);
-extern void nfs_access_add_cache(struct inode *, struct nfs_access_entry *);
+extern void nfs_access_add_cache(struct inode *, struct nfs_access_entry *, const struct cred *);
 extern void nfs_access_set_mask(struct nfs_access_entry *, u32);
 extern int nfs_permission(struct user_namespace *, struct inode *, int);
 extern int nfs_open(struct inode *, struct file *);
diff --git a/include/linux/nfs_xdr.h b/include/linux/nfs_xdr.h
index e9698b6278a5..80e8f8ce1bb2 100644
--- a/include/linux/nfs_xdr.h
+++ b/include/linux/nfs_xdr.h
@@ -1747,7 +1747,7 @@ struct nfs_rpc_ops {
 			    struct nfs4_label *);
 	int	(*lookupp) (struct inode *, struct nfs_fh *,
 			    struct nfs_fattr *, struct nfs4_label *);
-	int	(*access)  (struct inode *, struct nfs_access_entry *);
+	int	(*access)  (struct inode *, struct nfs_access_entry *, const struct cred *);
 	int	(*readlink)(struct inode *, struct page *, unsigned int,
 			    unsigned int);
 	int	(*create)  (struct inode *, struct dentry *,



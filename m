Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2BF9C362758
	for <lists+linux-nfs@lfdr.de>; Fri, 16 Apr 2021 20:00:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235514AbhDPSAs (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 16 Apr 2021 14:00:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236045AbhDPSAr (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 16 Apr 2021 14:00:47 -0400
Received: from fieldses.org (fieldses.org [IPv6:2600:3c00:e000:2f7::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96950C061756
        for <linux-nfs@vger.kernel.org>; Fri, 16 Apr 2021 11:00:21 -0700 (PDT)
Received: by fieldses.org (Postfix, from userid 2815)
        id 0559B6D25; Fri, 16 Apr 2021 14:00:19 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 fieldses.org 0559B6D25
From:   "J. Bruce Fields" <bfields@redhat.com>
To:     Chuck Lever <chuck.lever@oracle.com>
Cc:     linux-nfs@vger.kernel.org, "J. Bruce Fields" <bfields@redhat.com>
Subject: [PATCH 3/5] nfsd: track filehandle aliasing in nfs4_files
Date:   Fri, 16 Apr 2021 14:00:16 -0400
Message-Id: <1618596018-9899-3-git-send-email-bfields@redhat.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1618596018-9899-1-git-send-email-bfields@redhat.com>
References: <1618596018-9899-1-git-send-email-bfields@redhat.com>
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: "J. Bruce Fields" <bfields@redhat.com>

It's unusual but possible for multiple filehandles to point to the same
file.  In that case, we may end up with multiple nfs4_files referencing
the same inode.

For delegation purposes it will turn out to be useful to flag those
cases.

Signed-off-by: J. Bruce Fields <bfields@redhat.com>
---
 fs/nfsd/nfs4state.c | 37 ++++++++++++++++++++++++++++---------
 fs/nfsd/state.h     |  2 ++
 2 files changed, 30 insertions(+), 9 deletions(-)

diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index b0c74dbde07b..c1ba60db671a 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -4075,6 +4075,8 @@ static void nfsd4_init_file(struct svc_fh *fh, unsigned int hashval,
 	fp->fi_share_deny = 0;
 	memset(fp->fi_fds, 0, sizeof(fp->fi_fds));
 	memset(fp->fi_access, 0, sizeof(fp->fi_access));
+	fp->fi_aliased = false;
+	fp->fi_inode = d_inode(fh->fh_dentry);
 #ifdef CONFIG_NFSD_PNFS
 	INIT_LIST_HEAD(&fp->fi_lo_states);
 	atomic_set(&fp->fi_lo_recalls, 0);
@@ -4427,6 +4429,31 @@ find_file_locked(struct svc_fh *fh, unsigned int hashval)
 	return NULL;
 }
 
+static struct nfs4_file *insert_file(struct nfs4_file *new, struct svc_fh *fh,
+				     unsigned int hashval)
+{
+	struct nfs4_file *fp;
+	struct nfs4_file *ret = NULL;
+	bool alias_found = false;
+
+	spin_lock(&state_lock);
+	hlist_for_each_entry_rcu(fp, &file_hashtbl[hashval], fi_hash,
+				 lockdep_is_held(&state_lock)) {
+		if (fh_match(&fp->fi_fhandle, &fh->fh_handle)) {
+			if (refcount_inc_not_zero(&fp->fi_ref))
+				ret = fp;
+		} else if (d_inode(fh->fh_dentry) == fp->fi_inode)
+			fp->fi_aliased = alias_found = true;
+	}
+	if (likely(ret == NULL)) {
+		nfsd4_init_file(fh, hashval, new);
+		new->fi_aliased = alias_found;
+		ret = new;
+	}
+	spin_unlock(&state_lock);
+	return ret;
+}
+
 static struct nfs4_file * find_file(struct svc_fh *fh)
 {
 	struct nfs4_file *fp;
@@ -4450,15 +4477,7 @@ find_or_add_file(struct nfs4_file *new, struct svc_fh *fh)
 	if (fp)
 		return fp;
 
-	spin_lock(&state_lock);
-	fp = find_file_locked(fh, hashval);
-	if (likely(fp == NULL)) {
-		nfsd4_init_file(fh, hashval, new);
-		fp = new;
-	}
-	spin_unlock(&state_lock);
-
-	return fp;
+	return insert_file(new, fh, hashval);
 }
 
 /*
diff --git a/fs/nfsd/state.h b/fs/nfsd/state.h
index af1d9f2e373e..7b10b3eaaa5c 100644
--- a/fs/nfsd/state.h
+++ b/fs/nfsd/state.h
@@ -512,6 +512,8 @@ struct nfs4_clnt_odstate {
  */
 struct nfs4_file {
 	refcount_t		fi_ref;
+	struct inode *		fi_inode;
+	bool			fi_aliased;
 	spinlock_t		fi_lock;
 	struct hlist_node       fi_hash;	/* hash on fi_fhandle */
 	struct list_head        fi_stateids;
-- 
2.30.2


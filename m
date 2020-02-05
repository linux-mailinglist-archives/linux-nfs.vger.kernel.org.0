Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BC56A153268
	for <lists+linux-nfs@lfdr.de>; Wed,  5 Feb 2020 15:02:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726748AbgBEOCR (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 5 Feb 2020 09:02:17 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:46550 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728018AbgBEOCR (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 5 Feb 2020 09:02:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1580911335;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=e+o5OiQBHXNstUTVejwdEx6lUSjg50xIhae2fa7l50o=;
        b=PByJK/oafesxhfeiQ5kJT1pXQPv5JXf5FrbEs1T4PHIjv9VsRSxlaT9qz2DnBvN+5Ht3qN
        ZjRWr1s5574KrCT8hCo0inHT2/8vHa+Bm/FpoX/WBE6geyKUCN8iV5d/tWpcdHjxpdsEmk
        3AvrHzpYdVFA1M5u3GxYGplomitikcg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-300-tlMfL1_fMV2U-_hihnwEjQ-1; Wed, 05 Feb 2020 09:01:56 -0500
X-MC-Unique: tlMfL1_fMV2U-_hihnwEjQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C4AE6107B0E1;
        Wed,  5 Feb 2020 14:01:55 +0000 (UTC)
Received: from bcodding.csb (ovpn-64-2.rdu2.redhat.com [10.10.64.2])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 6C66E5DA7C;
        Wed,  5 Feb 2020 14:01:55 +0000 (UTC)
Received: by bcodding.csb (Postfix, from userid 24008)
        id F07DA10D2E33; Wed,  5 Feb 2020 09:01:54 -0500 (EST)
From:   Benjamin Coddington <bcodding@redhat.com>
To:     Anna Schumaker <Anna.Schumaker@netapp.com>,
        Trond Myklebust <trond.myklebust@hammerspace.com>
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH 3/3] NFSv4: Fix revalidation of dentries with delegations
Date:   Wed,  5 Feb 2020 09:01:54 -0500
Message-Id: <bf77a5baf5aea52fa721f4f629f3e2ccac2a5339.1580910601.git.bcodding@redhat.com>
In-Reply-To: <c594c55e683648cfa73a93bb11072befd496b6e1.1580910601.git.bcodding@redhat.com>
References: <cover.1580910601.git.bcodding@redhat.com> <1fb737c85fdfc56abe19cac56c04b6b9bf4287d8.1580910601.git.bcodding@redhat.com> <c594c55e683648cfa73a93bb11072befd496b6e1.1580910601.git.bcodding@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Content-Transfer-Encoding: quoted-printable
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Trond Myklebust <trondmy@gmail.com>

If a dentry was not initially looked up while we were holding a
delegation, then we do still need to revalidate that it still holds
the same name. If there are multiple hard links to the same file,
then all the hard links need validation.

Reported-by: Benjamin Coddington <bcodding@redhat.com>
Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
Reviewed-by: Benjamin Coddington <bcodding@redhat.com>
Tested-by: Benjamin Coddington <bcodding@redhat.com>
---
 fs/nfs/delegation.c    |   6 +++
 fs/nfs/dir.c           | 103 +++++++++++++++++++++++++++++++++++++++--
 fs/nfs/inode.c         |   1 +
 include/linux/nfs_fs.h |  26 +++--------
 4 files changed, 113 insertions(+), 23 deletions(-)

diff --git a/fs/nfs/delegation.c b/fs/nfs/delegation.c
index 4a841071d8a7..d856326836a2 100644
--- a/fs/nfs/delegation.c
+++ b/fs/nfs/delegation.c
@@ -42,6 +42,8 @@ static void nfs_mark_delegation_revoked(struct nfs_dele=
gation *delegation)
 	if (!test_and_set_bit(NFS_DELEGATION_REVOKED, &delegation->flags)) {
 		delegation->stateid.type =3D NFS4_INVALID_STATEID_TYPE;
 		atomic_long_dec(&nfs_active_delegations);
+		if (!test_bit(NFS_DELEGATION_RETURNING, &delegation->flags))
+			nfs_clear_verifier_delegated(delegation->inode);
 	}
 }
=20
@@ -276,6 +278,8 @@ nfs_start_delegation_return_locked(struct nfs_inode *=
nfsi)
 	if (!test_and_set_bit(NFS_DELEGATION_RETURNING, &delegation->flags))
 		ret =3D delegation;
 	spin_unlock(&delegation->lock);
+	if (ret)
+		nfs_clear_verifier_delegated(&nfsi->vfs_inode);
 out:
 	return ret;
 }
@@ -689,6 +693,8 @@ void nfs4_inode_return_delegation_on_close(struct ino=
de *inode)
 			ret =3D delegation;
 		}
 		spin_unlock(&delegation->lock);
+		if (ret)
+			nfs_clear_verifier_delegated(inode);
 	}
 out:
 	rcu_read_unlock();
diff --git a/fs/nfs/dir.c b/fs/nfs/dir.c
index b4e7558e42ab..2856e04c20d6 100644
--- a/fs/nfs/dir.c
+++ b/fs/nfs/dir.c
@@ -986,14 +986,111 @@ static int nfs_fsync_dir(struct file *filp, loff_t=
 start, loff_t end,
  * full lookup on all child dentries of 'dir' whenever a change occurs
  * on the server that might have invalidated our dcache.
  *
+ * Note that we reserve bit '0' as a tag to let us know when a dentry
+ * was revalidated while holding a delegation on its inode.
+ *
  * The caller should be holding dir->i_lock
  */
 void nfs_force_lookup_revalidate(struct inode *dir)
 {
-	NFS_I(dir)->cache_change_attribute++;
+	NFS_I(dir)->cache_change_attribute +=3D 2;
 }
 EXPORT_SYMBOL_GPL(nfs_force_lookup_revalidate);
=20
+/**
+ * nfs_verify_change_attribute - Detects NFS remote directory changes
+ * @dir: pointer to parent directory inode
+ * @verf: previously saved change attribute
+ *
+ * Return "false" if the verifiers doesn't match the change attribute.
+ * This would usually indicate that the directory contents have changed =
on
+ * the server, and that any dentries need revalidating.
+ */
+static bool nfs_verify_change_attribute(struct inode *dir, unsigned long=
 verf)
+{
+	return (verf & ~1UL) =3D=3D nfs_save_change_attribute(dir);
+}
+
+static void nfs_set_verifier_delegated(unsigned long *verf)
+{
+	*verf |=3D 1UL;
+}
+
+static void nfs_unset_verifier_delegated(unsigned long *verf)
+{
+	*verf &=3D ~1UL;
+}
+
+static bool nfs_test_verifier_delegated(unsigned long verf)
+{
+	return verf & 1;
+}
+
+static bool nfs_verifier_is_delegated(struct dentry *dentry)
+{
+	return nfs_test_verifier_delegated(dentry->d_time);
+}
+
+static void nfs_set_verifier_locked(struct dentry *dentry, unsigned long=
 verf)
+{
+	struct inode *inode =3D d_inode(dentry);
+
+	if (!nfs_verifier_is_delegated(dentry) &&
+	    !nfs_verify_change_attribute(d_inode(dentry->d_parent), verf))
+		goto out;
+	if (inode && NFS_PROTO(inode)->have_delegation(inode, FMODE_READ))
+		nfs_set_verifier_delegated(&verf);
+out:
+	dentry->d_time =3D verf;
+}
+
+/**
+ * nfs_set_verifier - save a parent directory verifier in the dentry
+ * @dentry: pointer to dentry
+ * @verf: verifier to save
+ *
+ * Saves the parent directory verifier in @dentry. If the inode has
+ * a delegation, we also tag the dentry as having been revalidated
+ * while holding a delegation so that we know we don't have to
+ * look it up again after a directory change.
+ */
+void nfs_set_verifier(struct dentry *dentry, unsigned long verf)
+{
+
+	spin_lock(&dentry->d_lock);
+	nfs_set_verifier_locked(dentry, verf);
+	spin_unlock(&dentry->d_lock);
+}
+EXPORT_SYMBOL_GPL(nfs_set_verifier);
+
+#if IS_ENABLED(CONFIG_NFS_V4)
+/**
+ * nfs_clear_verifier_delegated - clear the dir verifier delegation tag
+ * @inode: pointer to inode
+ *
+ * Iterates through the dentries in the inode alias list and clears
+ * the tag used to indicate that the dentry has been revalidated
+ * while holding a delegation.
+ * This function is intended for use when the delegation is being
+ * returned or revoked.
+ */
+void nfs_clear_verifier_delegated(struct inode *inode)
+{
+	struct dentry *alias;
+
+	if (!inode)
+		return;
+	spin_lock(&inode->i_lock);
+	hlist_for_each_entry(alias, &inode->i_dentry, d_u.d_alias) {
+		spin_lock(&alias->d_lock);
+		nfs_unset_verifier_delegated(&alias->d_time);
+		spin_unlock(&alias->d_lock);
+	}
+	spin_unlock(&inode->i_lock);
+}
+EXPORT_SYMBOL_GPL(nfs_clear_verifier_delegated);
+#endif /* IS_ENABLED(CONFIG_NFS_V4) */
+
 /*
  * A check for whether or not the parent directory has changed.
  * In the case it has, we assume that the dentries are untrustworthy
@@ -1235,7 +1332,7 @@ nfs_do_lookup_revalidate(struct inode *dir, struct =
dentry *dentry,
 		goto out_bad;
 	}
=20
-	if (NFS_PROTO(dir)->have_delegation(inode, FMODE_READ))
+	if (nfs_verifier_is_delegated(dentry))
 		return nfs_lookup_revalidate_delegated(dir, dentry, inode);
=20
 	/* Force a full look up iff the parent directory has changed */
@@ -1675,7 +1772,7 @@ nfs4_do_lookup_revalidate(struct inode *dir, struct=
 dentry *dentry,
 	if (inode =3D=3D NULL)
 		goto full_reval;
=20
-	if (NFS_PROTO(dir)->have_delegation(inode, FMODE_READ))
+	if (nfs_verifier_is_delegated(dentry))
 		return nfs_lookup_revalidate_delegated(dir, dentry, inode);
=20
 	/* NFS only supports OPEN on regular files */
diff --git a/fs/nfs/inode.c b/fs/nfs/inode.c
index 1309e6f47f3d..11bf15800ac9 100644
--- a/fs/nfs/inode.c
+++ b/fs/nfs/inode.c
@@ -2114,6 +2114,7 @@ static void init_once(void *foo)
 	init_rwsem(&nfsi->rmdir_sem);
 	mutex_init(&nfsi->commit_mutex);
 	nfs4_init_once(nfsi);
+	nfsi->cache_change_attribute =3D 0;
 }
=20
 static int __init nfs_init_inodecache(void)
diff --git a/include/linux/nfs_fs.h b/include/linux/nfs_fs.h
index a5f8f03ecd59..5d5b91e54f73 100644
--- a/include/linux/nfs_fs.h
+++ b/include/linux/nfs_fs.h
@@ -337,35 +337,17 @@ static inline int nfs_server_capable(struct inode *=
inode, int cap)
 	return NFS_SERVER(inode)->caps & cap;
 }
=20
-static inline void nfs_set_verifier(struct dentry * dentry, unsigned lon=
g verf)
-{
-	dentry->d_time =3D verf;
-}
-
 /**
  * nfs_save_change_attribute - Returns the inode attribute change cookie
  * @dir - pointer to parent directory inode
- * The "change attribute" is updated every time we finish an operation
- * that will result in a metadata change on the server.
+ * The "cache change attribute" is updated when we need to revalidate
+ * our dentry cache after a directory was seen to change on the server.
  */
 static inline unsigned long nfs_save_change_attribute(struct inode *dir)
 {
 	return NFS_I(dir)->cache_change_attribute;
 }
=20
-/**
- * nfs_verify_change_attribute - Detects NFS remote directory changes
- * @dir - pointer to parent directory inode
- * @chattr - previously saved change attribute
- * Return "false" if the verifiers doesn't match the change attribute.
- * This would usually indicate that the directory contents have changed =
on
- * the server, and that any dentries need revalidating.
- */
-static inline int nfs_verify_change_attribute(struct inode *dir, unsigne=
d long chattr)
-{
-	return chattr =3D=3D NFS_I(dir)->cache_change_attribute;
-}
-
 /*
  * linux/fs/nfs/inode.c
  */
@@ -495,6 +477,10 @@ extern const struct file_operations nfs_dir_operatio=
ns;
 extern const struct dentry_operations nfs_dentry_operations;
=20
 extern void nfs_force_lookup_revalidate(struct inode *dir);
+extern void nfs_set_verifier(struct dentry * dentry, unsigned long verf)=
;
+#if IS_ENABLED(CONFIG_NFS_V4)
+extern void nfs_clear_verifier_delegated(struct inode *inode);
+#endif /* IS_ENABLED(CONFIG_NFS_V4) */
 extern struct dentry *nfs_add_or_obtain(struct dentry *dentry,
 			struct nfs_fh *fh, struct nfs_fattr *fattr,
 			struct nfs4_label *label);
--=20
2.20.1


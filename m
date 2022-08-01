Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40A2C58620C
	for <lists+linux-nfs@lfdr.de>; Mon,  1 Aug 2022 02:33:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231254AbiHAAdo (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sun, 31 Jul 2022 20:33:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229710AbiHAAdn (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sun, 31 Jul 2022 20:33:43 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27234B495
        for <linux-nfs@vger.kernel.org>; Sun, 31 Jul 2022 17:33:40 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id C942560134;
        Mon,  1 Aug 2022 00:33:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1659314018; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=je3PPLcLNlovbpyK8FUorB3ovdSdDL0ljw01/HKhLHE=;
        b=1NEzzVu5QvRs+kPzsZvhySgD5OrLFVFrN3TKMXCPETRZSBrNCggHgTwVO+mgvzAtxY2IYc
        jSKlkNjmv6OFxjg8PgP6vP2gkPVPsWEk7DtIypqncOtO/OHRNq7kbR+Xoc3OWbrXWzFo41
        xYU1GveECFPyE1UfT+T3pq9NHS744eM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1659314018;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=je3PPLcLNlovbpyK8FUorB3ovdSdDL0ljw01/HKhLHE=;
        b=2x1zkyyWwwtkS37yxLtCJ4lWRoVEjuGTJPPW/JimbCYJgltJTug3/ItT4YUpt3vcWccRSH
        v5azMBltBnAgh2Bg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id A7E9013754;
        Mon,  1 Aug 2022 00:33:37 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id GBxlGGEf52JAGAAAMHmgww
        (envelope-from <neilb@suse.de>); Mon, 01 Aug 2022 00:33:37 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
From:   "NeilBrown" <neilb@suse.de>
To:     Trond Myklebust <trondmy@hammerspace.com>,
        Anna Schumaker <anna@kernel.org>
Cc:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: [PATCH] NFS: don't unhash dentry during unlink/rename
Date:   Mon, 01 Aug 2022 10:33:34 +1000
Message-id: <165931401422.4359.6525940729395119377@noble.neil.brown.name>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org


NFS unlink() (and rename over existing target) must determine if the
file is open, and must perform a "silly rename" instead of an unlink (or
before rename) if it is.  Otherwise the client might hold a file open
which has been removed on the server.

Consequently if it determines that the file isn't open, it must block
any subsequent opens until the unlink/rename has been completed on the
server.

This is currently achieved by unhashing the dentry.  This forces any
open attempt to the slow-path for lookup which will block on i_rwsem on
the directory until the unlink/rename completes.  A future patch will
change the VFS to only get a shared lock on i_rwsem for unlink, so this
will no longer work.

Instead we introduce an explicit interlock.  A special value is stored
in dentry->d_fsdata while the unlink/rename is running and
->d_revalidate blocks while that value is present.  When ->d_revalidate
unblocks, the dentry will be invalid.  This closes the race
without requiring exclusion on i_rwsem.

d_fsdata is already used in two different ways.
1/ an IS_ROOT directory dentry might have a "devname" stored in
   d_fsdata.  Such a dentry doesn't have a name and so cannot be the
   target of unlink or rename.  For safety we check if an old devname
   is still stored, and remove it if it is.
2/ a dentry with DCACHE_NFSFS_RENAMED set will have a 'struct
   nfs_unlinkdata' stored in d_fsdata.  While this is set maydelete()
   will fail, so an unlink or rename will never proceed on such
   a dentry.

Neither of these can be in effect when a dentry is the target of unlink
or rename.  So we can expect d_fsdata to be NULL, and store a special
value ((void*)1) which is given the name NFS_FSDATA_BLOCKED to indicate
that any lookup will be blocked.

The d_count() is incremented under d_lock() when a lookup finds the
dentry, so we check d_count() is low, and set NFS_FSDATA_BLOCKED under
the same lock to avoid any races.

Signed-off-by: NeilBrown <neilb@suse.de>
---
 fs/nfs/dir.c           | 72 +++++++++++++++++++++++++++++++-----------
 include/linux/nfs_fs.h |  9 ++++++
 2 files changed, 63 insertions(+), 18 deletions(-)

diff --git a/fs/nfs/dir.c b/fs/nfs/dir.c
index 0c4e8dd6aa96..a988dc9a5c92 100644
--- a/fs/nfs/dir.c
+++ b/fs/nfs/dir.c
@@ -1778,6 +1778,8 @@ __nfs_lookup_revalidate(struct dentry *dentry, unsigned=
 int flags,
 	int ret;
=20
 	if (flags & LOOKUP_RCU) {
+		if (dentry->d_fsdata =3D=3D NFS_FSDATA_BLOCKED)
+			return -ECHILD;
 		parent =3D READ_ONCE(dentry->d_parent);
 		dir =3D d_inode_rcu(parent);
 		if (!dir)
@@ -1786,6 +1788,9 @@ __nfs_lookup_revalidate(struct dentry *dentry, unsigned=
 int flags,
 		if (parent !=3D READ_ONCE(dentry->d_parent))
 			return -ECHILD;
 	} else {
+		/* Wait for unlink to complete */
+		wait_var_event(&dentry->d_fsdata,
+			       dentry->d_fsdata !=3D NFS_FSDATA_BLOCKED);
 		parent =3D dget_parent(dentry);
 		ret =3D reval(d_inode(parent), dentry, flags);
 		dput(parent);
@@ -2454,7 +2459,6 @@ static int nfs_safe_remove(struct dentry *dentry)
 int nfs_unlink(struct inode *dir, struct dentry *dentry)
 {
 	int error;
-	int need_rehash =3D 0;
=20
 	dfprintk(VFS, "NFS: unlink(%s/%lu, %pd)\n", dir->i_sb->s_id,
 		dir->i_ino, dentry);
@@ -2469,15 +2473,25 @@ int nfs_unlink(struct inode *dir, struct dentry *dent=
ry)
 		error =3D nfs_sillyrename(dir, dentry);
 		goto out;
 	}
-	if (!d_unhashed(dentry)) {
-		__d_drop(dentry);
-		need_rehash =3D 1;
-	}
+	/* We must prevent any concurrent open until the unlink
+	 * completes.  ->d_revalidate will wait for ->d_fsdata
+	 * to clear.  We set it here to ensure no lookup succeeds until
+	 * the unlink is complete on the server.
+	 */
+	error =3D -ETXTBSY;
+	if (WARN_ON(dentry->d_flags & DCACHE_NFSFS_RENAMED) ||
+	    WARN_ON(dentry->d_fsdata =3D=3D NFS_FSDATA_BLOCKED))
+		goto out;
+	if (dentry->d_fsdata)
+		/* old devname */
+		kfree(dentry->d_fsdata);
+	dentry->d_fsdata =3D NFS_FSDATA_BLOCKED;
+
 	spin_unlock(&dentry->d_lock);
 	error =3D nfs_safe_remove(dentry);
 	nfs_dentry_remove_handle_error(dir, dentry, error);
-	if (need_rehash)
-		d_rehash(dentry);
+	dentry->d_fsdata =3D NULL;
+	wake_up_var(&dentry->d_fsdata);
 out:
 	trace_nfs_unlink_exit(dir, dentry, error);
 	return error;
@@ -2584,6 +2598,15 @@ nfs_link(struct dentry *old_dentry, struct inode *dir,=
 struct dentry *dentry)
 }
 EXPORT_SYMBOL_GPL(nfs_link);
=20
+static void
+nfs_unblock_rename(struct rpc_task *task, struct nfs_renamedata *data)
+{
+	struct dentry *new_dentry =3D data->new_dentry;
+
+	new_dentry->d_fsdata =3D NULL;
+	wake_up_var(&new_dentry->d_fsdata);
+}
+
 /*
  * RENAME
  * FIXME: Some nfsds, like the Linux user space nfsd, may generate a
@@ -2614,8 +2637,9 @@ int nfs_rename(struct user_namespace *mnt_userns, struc=
t inode *old_dir,
 {
 	struct inode *old_inode =3D d_inode(old_dentry);
 	struct inode *new_inode =3D d_inode(new_dentry);
-	struct dentry *dentry =3D NULL, *rehash =3D NULL;
+	struct dentry *dentry =3D NULL;
 	struct rpc_task *task;
+	bool must_unblock =3D false;
 	int error =3D -EBUSY;
=20
 	if (flags)
@@ -2633,18 +2657,27 @@ int nfs_rename(struct user_namespace *mnt_userns, str=
uct inode *old_dir,
 	 * the new target.
 	 */
 	if (new_inode && !S_ISDIR(new_inode->i_mode)) {
-		/*
-		 * To prevent any new references to the target during the
-		 * rename, we unhash the dentry in advance.
+		/* We must prevent any concurrent open until the unlink
+		 * completes.  ->d_revalidate will wait for ->d_fsdata
+		 * to clear.  We set it here to ensure no lookup succeeds until
+		 * the unlink is complete on the server.
 		 */
-		if (!d_unhashed(new_dentry)) {
-			d_drop(new_dentry);
-			rehash =3D new_dentry;
+		error =3D -ETXTBSY;
+		if (WARN_ON(new_dentry->d_flags & DCACHE_NFSFS_RENAMED) ||
+		    WARN_ON(new_dentry->d_fsdata =3D=3D NFS_FSDATA_BLOCKED))
+			goto out;
+		if (new_dentry->d_fsdata) {
+			/* old devname */
+			kfree(new_dentry->d_fsdata);
+			new_dentry->d_fsdata =3D NULL;
 		}
=20
+		spin_lock(&new_dentry->d_lock);
 		if (d_count(new_dentry) > 2) {
 			int err;
=20
+			spin_unlock(&new_dentry->d_lock);
+
 			/* copy the target dentry's name */
 			dentry =3D d_alloc(new_dentry->d_parent,
 					 &new_dentry->d_name);
@@ -2657,14 +2690,19 @@ int nfs_rename(struct user_namespace *mnt_userns, str=
uct inode *old_dir,
 				goto out;
=20
 			new_dentry =3D dentry;
-			rehash =3D NULL;
 			new_inode =3D NULL;
+		} else {
+			new_dentry->d_fsdata =3D NFS_FSDATA_BLOCKED;
+			must_unblock =3D true;
+			spin_unlock(&new_dentry->d_lock);
 		}
+
 	}
=20
 	if (S_ISREG(old_inode->i_mode))
 		nfs_sync_inode(old_inode);
-	task =3D nfs_async_rename(old_dir, new_dir, old_dentry, new_dentry, NULL);
+	task =3D nfs_async_rename(old_dir, new_dir, old_dentry, new_dentry,
+				must_unblock ? nfs_unblock_rename : NULL);
 	if (IS_ERR(task)) {
 		error =3D PTR_ERR(task);
 		goto out;
@@ -2688,8 +2726,6 @@ int nfs_rename(struct user_namespace *mnt_userns, struc=
t inode *old_dir,
 		spin_unlock(&old_inode->i_lock);
 	}
 out:
-	if (rehash)
-		d_rehash(rehash);
 	trace_nfs_rename_exit(old_dir, old_dentry,
 			new_dir, new_dentry, error);
 	if (!error) {
diff --git a/include/linux/nfs_fs.h b/include/linux/nfs_fs.h
index a17c337dbdf1..b32ed68e7dc4 100644
--- a/include/linux/nfs_fs.h
+++ b/include/linux/nfs_fs.h
@@ -617,6 +617,15 @@ nfs_fileid_to_ino_t(u64 fileid)
=20
 #define NFS_JUKEBOX_RETRY_TIME (5 * HZ)
=20
+/* We need to block new opens while a file is being unlinked.
+ * If it is opened *before* we decide to unlink, we will silly-rename
+ * instead. If it is opened *after*, then we need to create or will fail.
+ * If we allow the two to race, we could end up with a file that is open
+ * but deleted on the server resulting in ESTALE.
+ * So use ->d_fsdata to record when the unlink is happening
+ * and block dentry revalidation while it is set.
+ */
+#define NFS_FSDATA_BLOCKED ((void*)1)
=20
 # undef ifdebug
 # ifdef NFS_DEBUG
--=20
2.36.1


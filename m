Return-Path: <linux-nfs+bounces-3427-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0456B8D1286
	for <lists+linux-nfs@lfdr.de>; Tue, 28 May 2024 05:27:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AD74B28303E
	for <lists+linux-nfs@lfdr.de>; Tue, 28 May 2024 03:27:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C51114AB8;
	Tue, 28 May 2024 03:27:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="I+PLR+Pq";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="t2Vxq+Rf";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="ZWfOEHfE";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="SdnhObC5"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9786E12E5D
	for <linux-nfs@vger.kernel.org>; Tue, 28 May 2024 03:27:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716866862; cv=none; b=Kd5Z/eOVH7HJ3ZubsNmdJaqw17V42tilUfnamNVQu9SEBMmTs7hvyNGr01NluREpazfOwjeLt2TmjkwTtkiClePAz/H58X4PxHKy4n7vtRGSYxOwdDjbhPxKQOovGRrWLvrpKruLrKcdUAaWK04PaBtPwQ9sz8y/V+ZHU8vaLpI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716866862; c=relaxed/simple;
	bh=mdpYLEj3VNACe3U/xqp9V7GnAJKDtXd9D46ByNipgfc=;
	h=Content-Type:MIME-Version:From:Subject:To:Cc:Date:Message-id; b=mdivQTm0b8kyN6edkQbevYQrj1BpOJQcP36ul9XGTQhSR0Ez65myu46GfsKJcBQsxtjVUNtNdBv6pwfyRa5KvEeGkp+6yrC07lrz5YjjSChAhNpbkKGu5q6Lc/cRpnl4a7vyhIjyqgRFBvuzhNpWz37fdnYWPZXbxKd1JB1Pmno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=I+PLR+Pq; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=t2Vxq+Rf; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=ZWfOEHfE; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=SdnhObC5; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 63E922249E;
	Tue, 28 May 2024 03:27:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1716866853; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=rX5hhHtoMCeBIqylOGhowJOMPkAWEmRnUQJaY3NmcXM=;
	b=I+PLR+PqrO1ZJcYNK1Z2wbWgV0x1n274hIMkIsR5vmWIx6NNOeTk0Osnib9AW459R8BpRI
	Wjs820HDcRYDyL/zPacbI3zRqzbsMa0iw5ZBETj1fslQ5JCGlj9FnkM8NGbEJe9xrrwa2W
	G8GOFKvm3ANCpnYjkOhTWA7tXNYq3G0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1716866853;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=rX5hhHtoMCeBIqylOGhowJOMPkAWEmRnUQJaY3NmcXM=;
	b=t2Vxq+RfSZ9Wd/DJBnMEXjdGJbaiLaZAdtWKzx3FXbHVF/lr/bUwgpewcdEfQlz+eCqqiX
	skWMQL6SU3nO44Dg==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=ZWfOEHfE;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=SdnhObC5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1716866852; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=rX5hhHtoMCeBIqylOGhowJOMPkAWEmRnUQJaY3NmcXM=;
	b=ZWfOEHfERJvglQfcimWlGAR2MpEqBAZCQVoDtMasdpIOMwxCwxJj8NxVtVjSM4fSXGrNpF
	HrunQxFczsJK5MDLyuFvGlJq9XCCmdf88t/QUo42vSriRK/MHZUQ9hMBqGYRgX1fT2AG+w
	k6svc0DjscdMWNMmZKHgqA4OOetB714=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1716866852;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=rX5hhHtoMCeBIqylOGhowJOMPkAWEmRnUQJaY3NmcXM=;
	b=SdnhObC5wcc5IZn6F0ohUtqCv/5yxaWSuYOAoR51n5k5cXwg2G5XCMvpkQjWoXhnGddt0x
	G4dGpYSl+GIQiqCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 2182713A55;
	Tue, 28 May 2024 03:27:29 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 5hs6LSFPVWbpRwAAD6G6ig
	(envelope-from <neilb@suse.de>); Tue, 28 May 2024 03:27:29 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "NeilBrown" <neilb@suse.de>
Subject: [PATCH v2] NFS: add barriers when testing for NFS_FSDATA_BLOCKED
To: Trond Myklebust <trond.myklebust@hammerspace.com>,
 Anna Schumaker <anna@kernel.org>
Cc: linux-nfs@vger.kernel.org,
 Richard Kojedzinszky <richard+debian+bugreport@kojedz.in>,
 1071501@bugs.debian.org
Date: Tue, 28 May 2024 13:27:17 +1000
Message-id: <171686683755.27191.3511021543845435733@noble.neil.brown.name>
X-Spam-Flag: NO
X-Spam-Score: -3.01
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 63E922249E
X-Spam-Level: 
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	TAGGED_RCPT(0.00)[debian,bugreport];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCPT_COUNT_FIVE(0.00)[5];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:email];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.de:+]


dentry->d_fsdata is set to NFS_FSDATA_BLOCKED while unlinking or
renaming-over a file to ensure that no open succeeds while the NFS
operation progressed on the server.

Setting dentry->d_fsdata to NFS_FSDATA_BLOCKED is done under ->d_lock
after checking the refcount is not elevated.  Any attempt to open the
file (through that name) will go through lookp_open() which will take
->d_lock while incrementing the refcount, we can be sure that once the
new value is set, __nfs_lookup_revalidate() *will* see the new value and
will block.

We don't have any locking guarantee that when we set ->d_fsdata to NULL,
the wait_var_event() in __nfs_lookup_revalidate() will notice.
wait/wake primitives do NOT provide barriers to guarantee order.  We
must use smp_load_acquire() in wait_var_event() to ensure we look at an
up-to-date value, and must use smp_store_release() before wake_up_var().

This patch adds those barrier functions and factors out
block_revalidate() and unblock_revalidate() far clarity.

There is also a hypothetical bug in that if memory allocation fails
(which never happens in practice) we might leave ->d_fsdata locked.
This patch adds the missing call to unblock_revalidate().

Reported-and-tested-by: Richard Kojedzinszky <richard+debian+bugreport@kojedz=
.in>
Closes: https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=3D1071501
Fixes: 3c59366c207e ("NFS: don't unhash dentry during unlink/rename")
Signed-off-by: NeilBrown <neilb@suse.de>
---
 fs/nfs/dir.c | 47 ++++++++++++++++++++++++++++++++---------------
 1 file changed, 32 insertions(+), 15 deletions(-)

v1 incorrectly assigned NULL to ->d_fsdata in block_revalidate().
It should assign NFS_FSDATA_BLOCKED.

diff --git a/fs/nfs/dir.c b/fs/nfs/dir.c
index ac505671efbd..bdd6cb33a370 100644
--- a/fs/nfs/dir.c
+++ b/fs/nfs/dir.c
@@ -1802,9 +1802,10 @@ __nfs_lookup_revalidate(struct dentry *dentry, unsigne=
d int flags,
 		if (parent !=3D READ_ONCE(dentry->d_parent))
 			return -ECHILD;
 	} else {
-		/* Wait for unlink to complete */
+		/* Wait for unlink to complete - see unblock_revalidate() */
 		wait_var_event(&dentry->d_fsdata,
-			       dentry->d_fsdata !=3D NFS_FSDATA_BLOCKED);
+			       smp_load_acquire(&dentry->d_fsdata)
+			       !=3D NFS_FSDATA_BLOCKED);
 		parent =3D dget_parent(dentry);
 		ret =3D reval(d_inode(parent), dentry, flags);
 		dput(parent);
@@ -1817,6 +1818,29 @@ static int nfs_lookup_revalidate(struct dentry *dentry=
, unsigned int flags)
 	return __nfs_lookup_revalidate(dentry, flags, nfs_do_lookup_revalidate);
 }
=20
+static void block_revalidate(struct dentry *dentry)
+{
+	/* old devname - just in case */
+	kfree(dentry->d_fsdata);
+
+	/* Any new reference that could lead to an open
+	 * will take ->d_lock in lookup_open() -> d_lookup().
+	 * Holding this lock ensures we cannot race with
+	 * __nfs_lookup_revalidate() and removes and need
+	 * for further barriers.
+	 */
+	lockdep_assert_held(&dentry->d_lock);
+
+	dentry->d_fsdata =3D NFS_FSDATA_BLOCKED;
+}
+
+static void unblock_revalidate(struct dentry *dentry)
+{
+	/* store_release ensures wait_var_event() sees the update */
+	smp_store_release(&dentry->d_fsdata, NULL);
+	wake_up_var(&dentry->d_fsdata);
+}
+
 /*
  * A weaker form of d_revalidate for revalidating just the d_inode(dentry)
  * when we don't really care about the dentry name. This is called when a
@@ -2501,15 +2525,12 @@ int nfs_unlink(struct inode *dir, struct dentry *dent=
ry)
 		spin_unlock(&dentry->d_lock);
 		goto out;
 	}
-	/* old devname */
-	kfree(dentry->d_fsdata);
-	dentry->d_fsdata =3D NFS_FSDATA_BLOCKED;
+	block_revalidate(dentry);
=20
 	spin_unlock(&dentry->d_lock);
 	error =3D nfs_safe_remove(dentry);
 	nfs_dentry_remove_handle_error(dir, dentry, error);
-	dentry->d_fsdata =3D NULL;
-	wake_up_var(&dentry->d_fsdata);
+	unblock_revalidate(dentry);
 out:
 	trace_nfs_unlink_exit(dir, dentry, error);
 	return error;
@@ -2616,8 +2637,7 @@ nfs_unblock_rename(struct rpc_task *task, struct nfs_re=
namedata *data)
 {
 	struct dentry *new_dentry =3D data->new_dentry;
=20
-	new_dentry->d_fsdata =3D NULL;
-	wake_up_var(&new_dentry->d_fsdata);
+	unblock_revalidate(new_dentry);
 }
=20
 /*
@@ -2679,11 +2699,6 @@ int nfs_rename(struct mnt_idmap *idmap, struct inode *=
old_dir,
 		if (WARN_ON(new_dentry->d_flags & DCACHE_NFSFS_RENAMED) ||
 		    WARN_ON(new_dentry->d_fsdata =3D=3D NFS_FSDATA_BLOCKED))
 			goto out;
-		if (new_dentry->d_fsdata) {
-			/* old devname */
-			kfree(new_dentry->d_fsdata);
-			new_dentry->d_fsdata =3D NULL;
-		}
=20
 		spin_lock(&new_dentry->d_lock);
 		if (d_count(new_dentry) > 2) {
@@ -2705,7 +2720,7 @@ int nfs_rename(struct mnt_idmap *idmap, struct inode *o=
ld_dir,
 			new_dentry =3D dentry;
 			new_inode =3D NULL;
 		} else {
-			new_dentry->d_fsdata =3D NFS_FSDATA_BLOCKED;
+			block_revalidate(new_dentry);
 			must_unblock =3D true;
 			spin_unlock(&new_dentry->d_lock);
 		}
@@ -2717,6 +2732,8 @@ int nfs_rename(struct mnt_idmap *idmap, struct inode *o=
ld_dir,
 	task =3D nfs_async_rename(old_dir, new_dir, old_dentry, new_dentry,
 				must_unblock ? nfs_unblock_rename : NULL);
 	if (IS_ERR(task)) {
+		if (must_unblock)
+			unblock_revalidate(new_dentry);
 		error =3D PTR_ERR(task);
 		goto out;
 	}
--=20
2.44.0



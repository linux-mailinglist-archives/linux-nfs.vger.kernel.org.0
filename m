Return-Path: <linux-nfs+bounces-3394-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 95C298CF7E8
	for <lists+linux-nfs@lfdr.de>; Mon, 27 May 2024 05:07:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 263321F216B2
	for <lists+linux-nfs@lfdr.de>; Mon, 27 May 2024 03:07:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6525CD50F;
	Mon, 27 May 2024 03:04:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="sHdBAUPG";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="DnDlXBrP";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="iS3nfgO+";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="cgy2WTuh"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36CA9D502
	for <linux-nfs@vger.kernel.org>; Mon, 27 May 2024 03:04:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716779062; cv=none; b=fh7jImr+UAwI4yjXbfs8leYfFIT1x+0RrNKcU31g6Ze/nGg3zetpMFXv6H8aP/mf0cxaRPPrcotiSYcNGKeTAwZd4A+x7F1xxyfbBSmVWPhpaGqQpNPxkgRUsZzHtAjP1qCi40PD+J/17XfOK1AUOMtPAV0h4Ef8mOLXxnscskQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716779062; c=relaxed/simple;
	bh=Ep+SLj3L1wdEG2hXmv19UT3hed+DWnCmQS4UG5Fu+Y4=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:Date:Message-id; b=GrlcFaUJ17vfJuQW7fcNCJTmxdJ2dNyePut3BtCHTgUy7G4kQM3KYRQAzQoltlRQojhW13VM7SmbE0vZfpUvI0FPPusjLqY/bG/2/ve3/DrO8soKS0wnenUdbwQ41PQ85dW85nyEumXrZ0rGKTAaMQr0l4FA7efERY6tnbco3tI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=sHdBAUPG; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=DnDlXBrP; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=iS3nfgO+; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=cgy2WTuh; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 3BB1621B53;
	Mon, 27 May 2024 03:04:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1716779058; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=rg4o7ftwFzS82RXBIrjKlLVMU4CrNnLEHSABsUD1SCg=;
	b=sHdBAUPGxwzn/8sOFuQ1z2nMt1sxvvPz5glNsfKPOU0wF/l08aj+70JLHMN/Uy8NPqUutC
	jRfhHLTd6mpbpgDMvgctQVVG+nHmewm3IN+81/5Rw66QPbMT92LW6QZjuU6JaEcdaC5UJq
	NcVK+bJ0LdVbVyQdScDBDToHcBgw/Dw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1716779058;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=rg4o7ftwFzS82RXBIrjKlLVMU4CrNnLEHSABsUD1SCg=;
	b=DnDlXBrPt4Uj/gzr2xkutsDZaN5qJAsolBV3BUYb6FFKwXg3SX8s+BIwAcKV0hHkPjGAOm
	HlTZJS8jn+4r1FBg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1716779057; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=rg4o7ftwFzS82RXBIrjKlLVMU4CrNnLEHSABsUD1SCg=;
	b=iS3nfgO+GysHRVfeejCFE8/BzjNgnSLBH1nEZPbE9UkfkuWrzRNO4AxGRYrfSE5N/6dGhh
	wh2c6hEO7zvzLaMg63aAFYQiA6Fqtq6jvhZnESG2fld8k3CdwmJ1pIRsTZtHvyKxUd2T6S
	k+S8YCN5FgqETi89rQz1wjB+UOft2aw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1716779057;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=rg4o7ftwFzS82RXBIrjKlLVMU4CrNnLEHSABsUD1SCg=;
	b=cgy2WTuh7DoTEP+cbFHX2pFUivNlARerIz4rNQvbkYv2kiYxXqKKRZ571xnGFfN5maXV7p
	UmuhX39W38OQF4Bw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E9DC313A6B;
	Mon, 27 May 2024 03:04:14 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id ZoazIi74U2Z0XwAAD6G6ig
	(envelope-from <neilb@suse.de>); Mon, 27 May 2024 03:04:14 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "NeilBrown" <neilb@suse.de>
To: Trond Myklebust <trond.myklebust@hammerspace.com>,
 Anna Schumaker <anna@kernel.org>
Cc: linux-nfs@vger.kernel.org,
 Richard Kojedzinszky <richard+debian+bugreport@kojedz.in>,
 1071501@bugs.debian.org
Subject: [PATCH] NFS: add barriers when testing for NFS_FSDATA_BLOCKED
Date: Mon, 27 May 2024 13:04:10 +1000
Message-id: <171677905033.27191.7405469009187788343@noble.neil.brown.name>
X-Spam-Level: 
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_COUNT_TWO(0.00)[2];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[debian,bugreport];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email]
X-Spam-Score: -2.80
X-Spam-Flag: NO


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
 fs/nfs/dir.c | 44 +++++++++++++++++++++++++++++---------------
 1 file changed, 29 insertions(+), 15 deletions(-)

diff --git a/fs/nfs/dir.c b/fs/nfs/dir.c
index ac505671efbd..c91dc36d41cc 100644
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
@@ -1817,6 +1818,26 @@ static int nfs_lookup_revalidate(struct dentry *dentry=
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
+	 */
+	lockdep_assert_held(&dentry->d_lock);
+
+	dentry->d_fsdata =3D NULL;
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
@@ -2501,15 +2522,12 @@ int nfs_unlink(struct inode *dir, struct dentry *dent=
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
@@ -2616,8 +2634,7 @@ nfs_unblock_rename(struct rpc_task *task, struct nfs_re=
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
@@ -2679,11 +2696,6 @@ int nfs_rename(struct mnt_idmap *idmap, struct inode *=
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
@@ -2705,7 +2717,7 @@ int nfs_rename(struct mnt_idmap *idmap, struct inode *o=
ld_dir,
 			new_dentry =3D dentry;
 			new_inode =3D NULL;
 		} else {
-			new_dentry->d_fsdata =3D NFS_FSDATA_BLOCKED;
+			block_revalidate(new_dentry);
 			must_unblock =3D true;
 			spin_unlock(&new_dentry->d_lock);
 		}
@@ -2717,6 +2729,8 @@ int nfs_rename(struct mnt_idmap *idmap, struct inode *o=
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



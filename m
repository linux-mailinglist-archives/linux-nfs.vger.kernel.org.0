Return-Path: <linux-nfs+bounces-2203-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A95687135E
	for <lists+linux-nfs@lfdr.de>; Tue,  5 Mar 2024 03:11:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5EACC1C22478
	for <lists+linux-nfs@lfdr.de>; Tue,  5 Mar 2024 02:11:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D698918AE0;
	Tue,  5 Mar 2024 02:10:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="R1Z4txzX";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="nQbihhzH";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="R1Z4txzX";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="nQbihhzH"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC7C6182DF
	for <linux-nfs@vger.kernel.org>; Tue,  5 Mar 2024 02:10:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709604628; cv=none; b=luHILTPYLnUOHMlkKSoMfnD4+en3jlBDvS4KmkcOKJ/MyeJwCgyXWHROOYnfg1hVJj9Rk2Cqdk7Q5gOCU72OaztWowScpb3MLyXbSzsKhDRvPa51ZQZLJ7cPTKiL3wbYrvsOf/5lSVqirLVeUxr47r08HELp79j4OBWo4F+E3zU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709604628; c=relaxed/simple;
	bh=Xh9egH5m8QasORhIE68f1hgtlfDw4Nx/raSxKSbagmU=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:Date:Message-id; b=OgOzlKnlcjAjCiq4iu3XtOzBaugEr+ggntAf7ZOAeEHt6oX8sbABhZx+Fq0gjcuLZ1XjiznHuYyCXKhijR1+MaMfFB7wpn3RO6X0B482zgIj/3vTta2LeupolpWHA825+9iPq0j65NZSWQ20vXENwgh28YXq13M9aZ+r1CIATi4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=R1Z4txzX; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=nQbihhzH; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=R1Z4txzX; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=nQbihhzH; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id D69EF229A4;
	Tue,  5 Mar 2024 02:10:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1709604624; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=u1MNFR1J8Qr84QGzW7VULoXALPQtETjnepSLKirSNE8=;
	b=R1Z4txzXF2tmL8ar5N7vVb5ASzrGhybriRfQ/PwFtKz/S9f4gMIubGq7BuIYe3xnK60fxm
	BFGoev3+RdgeiP/7ZkETovq7vJicnAvVu7FiHJhIU/K8RN2Wvyj7+E7xXrTcp5RNUJrcSs
	o2+m47eqoqow78dtVS8qEIO3WCMUa5E=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1709604624;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=u1MNFR1J8Qr84QGzW7VULoXALPQtETjnepSLKirSNE8=;
	b=nQbihhzH2uyTqwG0sLMhN94Fnpmbw4zWx2B2KV50UgyvDSCqiVBN73EcUvd+4xyxYiL3Q+
	z9tS2XWKQdr9+dDQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1709604624; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=u1MNFR1J8Qr84QGzW7VULoXALPQtETjnepSLKirSNE8=;
	b=R1Z4txzXF2tmL8ar5N7vVb5ASzrGhybriRfQ/PwFtKz/S9f4gMIubGq7BuIYe3xnK60fxm
	BFGoev3+RdgeiP/7ZkETovq7vJicnAvVu7FiHJhIU/K8RN2Wvyj7+E7xXrTcp5RNUJrcSs
	o2+m47eqoqow78dtVS8qEIO3WCMUa5E=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1709604624;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=u1MNFR1J8Qr84QGzW7VULoXALPQtETjnepSLKirSNE8=;
	b=nQbihhzH2uyTqwG0sLMhN94Fnpmbw4zWx2B2KV50UgyvDSCqiVBN73EcUvd+4xyxYiL3Q+
	z9tS2XWKQdr9+dDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 5C3C113A7B;
	Tue,  5 Mar 2024 02:10:23 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id Gm2JAA9/5mUTFgAAD6G6ig
	(envelope-from <neilb@suse.de>); Tue, 05 Mar 2024 02:10:23 +0000
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
Cc: linux-nfs@vger.kernel.org
Subject:
 [PATCH/RFC] NFS: add atomic_open for NFSv3 to handle O_TRUNC correctly.
Date: Tue, 05 Mar 2024 13:10:19 +1100
Message-id: <170960461960.24797.16435704587383279525@noble.neil.brown.name>
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=R1Z4txzX;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=nQbihhzH
X-Spamd-Result: default: False [-3.31 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	 FROM_HAS_DN(0.00)[];
	 RCPT_COUNT_THREE(0.00)[3];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 DKIM_TRACE(0.00)[suse.de:+];
	 MX_GOOD(-0.01)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-3.00)[100.00%]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: D69EF229A4
X-Spam-Level: 
X-Spam-Score: -3.31
X-Spam-Flag: NO


With two clients with NFSv3 mounts of the same directory, the sequence:

   client1            client2
  ls -l afile
                      echo hello there > afile
  echo HELLO > afile
  cat afile

will show
   HELLO
   there

because the O_TRUNC requested in the final 'echo' doesn't take effect.
This is because the "Negative dentry, just create a file" section in
lookup_open() assumes that the file *does* get created since the dentry
was negative, so it sets FMODE_CREATED, and this causes do_open() to
clear O_TRUNC and so the file doesn't get truncated.

Even mounting with -o lookupcache=3Dnone does not help as
nfs_neg_need_reval() always returns false if LOOKUP_CREATE is set.

This patch fixes the problem by providing an atomic_open inode operation
for NFSv3 (and v2).  The code is largely the code from the branch in
lookup_open() when atomic_open is not provided.  The significant change
is that the O_TRUNC flag is passed a new nfs_do_create() which add
'trunc' handling to nfs_create().

Signed-off-by: NeilBrown <neilb@suse.de>
---

This is the first time I seriously looked at the atomic_lookup interface
so I might have done something silly.  Please expect to find something
wrong :-)

I've only done basic testing so far.  I plan to run some test suites
tomorrow, but thought I would post now to get initial feedback.

Thanks.

 fs/nfs/dir.c           | 55 ++++++++++++++++++++++++++++++++++++++++--
 fs/nfs/nfs3proc.c      |  1 +
 fs/nfs/proc.c          |  1 +
 include/linux/nfs_fs.h |  3 +++
 4 files changed, 58 insertions(+), 2 deletions(-)

diff --git a/fs/nfs/dir.c b/fs/nfs/dir.c
index ac505671efbd..48a3a3455f00 100644
--- a/fs/nfs/dir.c
+++ b/fs/nfs/dir.c
@@ -56,6 +56,8 @@ static int nfs_readdir(struct file *, struct dir_context *);
 static int nfs_fsync_dir(struct file *, loff_t, loff_t, int);
 static loff_t nfs_llseek_dir(struct file *, loff_t, int);
 static void nfs_readdir_clear_array(struct folio *);
+static int nfs_do_create(struct mnt_idmap *idmap, struct inode *dir,
+			 struct dentry *dentry, umode_t mode, bool excl, bool trunc);
=20
 const struct file_operations nfs_dir_operations =3D {
 	.llseek		=3D nfs_llseek_dir,
@@ -2243,6 +2245,45 @@ static int nfs4_lookup_revalidate(struct dentry *dentr=
y, unsigned int flags)
=20
 #endif /* CONFIG_NFSV4 */
=20
+int nfs_atomic_open_v23(struct inode *dir, struct dentry *dentry,
+			struct file *file, unsigned int open_flags,
+			umode_t mode)
+{
+
+	/* Same as look+open from lookup_open(), but we different O_TRUNC
+	 * handling.
+	 */
+	int error =3D 0;
+	unsigned int lookup_flags =3D 0;
+
+	if (open_flags & O_DIRECTORY)
+		lookup_flags =3D LOOKUP_OPEN | LOOKUP_DIRECTORY;
+	if (open_flags & O_EXCL)
+		lookup_flags |=3D LOOKUP_EXCL;
+
+	if (d_in_lookup(dentry)) {
+		struct dentry *res =3D nfs_lookup(dir, dentry, open_flags);
+
+		d_lookup_done(dentry);
+		if (unlikely(res)) {
+			if (IS_ERR(res))
+				return PTR_ERR(res);
+			return finish_no_open(file, res);
+		}
+	}
+
+	/* Negative dentry, just create the file */
+	if (!dentry->d_inode && (open_flags & O_CREAT)) {
+		file->f_mode |=3D FMODE_CREATED;
+		error =3D nfs_do_create(NULL, dir, dentry, mode,
+				      open_flags & O_EXCL, open_flags & O_TRUNC);
+		if (error)
+			return error;
+	}
+	return finish_open(file, dentry, NULL);
+}
+EXPORT_SYMBOL_GPL(nfs_atomic_open_v23);
+
 struct dentry *
 nfs_add_or_obtain(struct dentry *dentry, struct nfs_fh *fhandle,
 				struct nfs_fattr *fattr)
@@ -2303,8 +2344,8 @@ EXPORT_SYMBOL_GPL(nfs_instantiate);
  * that the operation succeeded on the server, but an error in the
  * reply path made it appear to have failed.
  */
-int nfs_create(struct mnt_idmap *idmap, struct inode *dir,
-	       struct dentry *dentry, umode_t mode, bool excl)
+static int nfs_do_create(struct mnt_idmap *idmap, struct inode *dir,
+			 struct dentry *dentry, umode_t mode, bool excl, bool trunc)
 {
 	struct iattr attr;
 	int open_flags =3D excl ? O_CREAT | O_EXCL : O_CREAT;
@@ -2315,6 +2356,10 @@ int nfs_create(struct mnt_idmap *idmap, struct inode *=
dir,
=20
 	attr.ia_mode =3D mode;
 	attr.ia_valid =3D ATTR_MODE;
+	if (trunc) {
+		attr.ia_size =3D 0;
+		attr.ia_valid |=3D ATTR_SIZE;
+	}
=20
 	trace_nfs_create_enter(dir, dentry, open_flags);
 	error =3D NFS_PROTO(dir)->create(dir, dentry, &attr, open_flags);
@@ -2326,6 +2371,12 @@ int nfs_create(struct mnt_idmap *idmap, struct inode *=
dir,
 	d_drop(dentry);
 	return error;
 }
+
+int nfs_create(struct mnt_idmap *idmap, struct inode *dir,
+	       struct dentry *dentry, umode_t mode, bool excl)
+{
+	return nfs_do_create(idmap, dir, dentry, mode, excl, false);
+}
 EXPORT_SYMBOL_GPL(nfs_create);
=20
 /*
diff --git a/fs/nfs/nfs3proc.c b/fs/nfs/nfs3proc.c
index 2de66e4e8280..15ddf6755ede 100644
--- a/fs/nfs/nfs3proc.c
+++ b/fs/nfs/nfs3proc.c
@@ -986,6 +986,7 @@ static int nfs3_have_delegation(struct inode *inode, fmod=
e_t flags)
=20
 static const struct inode_operations nfs3_dir_inode_operations =3D {
 	.create		=3D nfs_create,
+	.atomic_open	=3D nfs_atomic_open_v23,
 	.lookup		=3D nfs_lookup,
 	.link		=3D nfs_link,
 	.unlink		=3D nfs_unlink,
diff --git a/fs/nfs/proc.c b/fs/nfs/proc.c
index ad3a321ae997..d105e5b2659d 100644
--- a/fs/nfs/proc.c
+++ b/fs/nfs/proc.c
@@ -695,6 +695,7 @@ static int nfs_have_delegation(struct inode *inode, fmode=
_t flags)
 static const struct inode_operations nfs_dir_inode_operations =3D {
 	.create		=3D nfs_create,
 	.lookup		=3D nfs_lookup,
+	.atomic_open	=3D nfs_atomic_open_v23,
 	.link		=3D nfs_link,
 	.unlink		=3D nfs_unlink,
 	.symlink	=3D nfs_symlink,
diff --git a/include/linux/nfs_fs.h b/include/linux/nfs_fs.h
index f5ce7b101146..cacbeb397a58 100644
--- a/include/linux/nfs_fs.h
+++ b/include/linux/nfs_fs.h
@@ -561,6 +561,9 @@ extern int nfs_may_open(struct inode *inode, const struct=
 cred *cred, int openfl
 extern void nfs_access_zap_cache(struct inode *inode);
 extern int nfs_access_get_cached(struct inode *inode, const struct cred *cre=
d,
 				 u32 *mask, bool may_block);
+extern int nfs_atomic_open_v23(struct inode *dir, struct dentry *dentry,
+			       struct file *file, unsigned int open_flags,
+			       umode_t mode);
=20
 /*
  * linux/fs/nfs/symlink.c
--=20
2.43.0



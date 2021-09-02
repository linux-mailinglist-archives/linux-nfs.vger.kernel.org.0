Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 94C6C3FE712
	for <lists+linux-nfs@lfdr.de>; Thu,  2 Sep 2021 03:15:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232859AbhIBBQe (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 1 Sep 2021 21:16:34 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:59106 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229958AbhIBBQc (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 1 Sep 2021 21:16:32 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id EC1F722550;
        Thu,  2 Sep 2021 01:15:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1630545333; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=qSFp8XwFyaMsa4snx7TNOgOlW3sovPRZ4y45x/a1kcw=;
        b=LF4Zv8GPZBMhKy9mKxtlUQTa916FicY85EMoMb0t+gLMI5MFpyDwj3BB3dhr8pVG3TtMPR
        ih9/GnD0eYO5CqwQauL5mTIw1OgJzprru8QPh7BHA8qWCUSYdwehbdDyT7qg4GCq4jrbDp
        h0oXcDLxFeXgcIBy0Sgfq4NrEPkcT38=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1630545333;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=qSFp8XwFyaMsa4snx7TNOgOlW3sovPRZ4y45x/a1kcw=;
        b=V0xB8/IPM0eye9EabuFjt4yxO3l+0tZ9nMW7IUn7h6lDb/6T0Rdk2jG+hMwm/pT07PFXKv
        cgB1T7XywElfWWAg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 5BF2013AE9;
        Thu,  2 Sep 2021 01:15:32 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id jZT6BrQlMGFtVAAAMHmgww
        (envelope-from <neilb@suse.de>); Thu, 02 Sep 2021 01:15:32 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
From:   "NeilBrown" <neilb@suse.de>
To:     "Chuck Lever III" <chuck.lever@oracle.com>
Cc:     "Bruce Fields" <bfields@fieldses.org>,
        "Linux NFS Mailing List" <linux-nfs@vger.kernel.org>,
        "Christoph Hellwig" <hch@lst.de>
Subject: [PATCH 2/3 v3] NFSD: drop support for ancient filehandles
In-reply-to: <163054528774.24419.6639477440713170169@noble.neil.brown.name>
References: <20210827151505.GA19199@lst.de>,
 <163038488360.7591.7865010833762169362@noble.neil.brown.name>,
 <20210901074407.GB18673@lst.de>,
 <F517668C-DD79-4358-96AE-1566B956025A@oracle.com>,
 <163054528774.24419.6639477440713170169@noble.neil.brown.name>
Date:   Thu, 02 Sep 2021 11:15:29 +1000
Message-id: <163054532947.24419.15934648756713210376@noble.neil.brown.name>
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org


Filehandles not in the "new" or "version 1" format have not been handed
out for new mounts since Linux 2.4 which was released 20 years ago.
I think it is safe to say that no such file handles are still in use,
and that we can drop support for them.

Signed-off-by: NeilBrown <neilb@suse.de>
---
 fs/nfsd/nfsfh.c | 160 +++++++++++++++---------------------------------
 fs/nfsd/nfsfh.h |  35 +----------
 2 files changed, 54 insertions(+), 141 deletions(-)

diff --git a/fs/nfsd/nfsfh.c b/fs/nfsd/nfsfh.c
index c475d2271f9c..149f9bbc48a4 100644
--- a/fs/nfsd/nfsfh.c
+++ b/fs/nfsd/nfsfh.c
@@ -154,11 +154,12 @@ static inline __be32 check_pseudo_root(struct svc_rqst =
*rqstp,
 static __be32 nfsd_set_fh_dentry(struct svc_rqst *rqstp, struct svc_fh *fhp)
 {
 	struct knfsd_fh	*fh =3D &fhp->fh_handle;
-	struct fid *fid =3D NULL, sfid;
+	struct fid *fid =3D NULL;
 	struct svc_export *exp;
 	struct dentry *dentry;
 	int fileid_type;
 	int data_left =3D fh->fh_size/4;
+	int len;
 	__be32 error;
=20
 	error =3D nfserr_stale;
@@ -167,48 +168,35 @@ static __be32 nfsd_set_fh_dentry(struct svc_rqst *rqstp=
, struct svc_fh *fhp)
 	if (rqstp->rq_vers =3D=3D 4 && fh->fh_size =3D=3D 0)
 		return nfserr_nofilehandle;
=20
-	if (fh->fh_version =3D=3D 1) {
-		int len;
-
-		if (--data_left < 0)
-			return error;
-		if (fh->fh_auth_type !=3D 0)
-			return error;
-		len =3D key_len(fh->fh_fsid_type) / 4;
-		if (len =3D=3D 0)
-			return error;
-		if  (fh->fh_fsid_type =3D=3D FSID_MAJOR_MINOR) {
-			/* deprecated, convert to type 3 */
-			len =3D key_len(FSID_ENCODE_DEV)/4;
-			fh->fh_fsid_type =3D FSID_ENCODE_DEV;
-			/*
-			 * struct knfsd_fh uses host-endian fields, which are
-			 * sometimes used to hold net-endian values. This
-			 * confuses sparse, so we must use __force here to
-			 * keep it from complaining.
-			 */
-			fh->fh_fsid[0] =3D new_encode_dev(MKDEV(ntohl((__force __be32)fh->fh_fsid=
[0]),
-							ntohl((__force __be32)fh->fh_fsid[1])));
-			fh->fh_fsid[1] =3D fh->fh_fsid[2];
-		}
-		data_left -=3D len;
-		if (data_left < 0)
-			return error;
-		exp =3D rqst_exp_find(rqstp, fh->fh_fsid_type, fh->fh_fsid);
-		fid =3D (struct fid *)(fh->fh_fsid + len);
-	} else {
-		__u32 tfh[2];
-		dev_t xdev;
-		ino_t xino;
-
-		if (fh->fh_size !=3D NFS_FHSIZE)
-			return error;
-		/* assume old filehandle format */
-		xdev =3D old_decode_dev(fh->ofh_xdev);
-		xino =3D u32_to_ino_t(fh->ofh_xino);
-		mk_fsid(FSID_DEV, tfh, xdev, xino, 0, NULL);
-		exp =3D rqst_exp_find(rqstp, FSID_DEV, tfh);
+	if (fh->fh_version !=3D 1)
+		return error;
+
+	if (--data_left < 0)
+		return error;
+	if (fh->fh_auth_type !=3D 0)
+		return error;
+	len =3D key_len(fh->fh_fsid_type) / 4;
+	if (len =3D=3D 0)
+		return error;
+	if (fh->fh_fsid_type =3D=3D FSID_MAJOR_MINOR) {
+		/* deprecated, convert to type 3 */
+		len =3D key_len(FSID_ENCODE_DEV)/4;
+		fh->fh_fsid_type =3D FSID_ENCODE_DEV;
+		/*
+		 * struct knfsd_fh uses host-endian fields, which are
+		 * sometimes used to hold net-endian values. This
+		 * confuses sparse, so we must use __force here to
+		 * keep it from complaining.
+		 */
+		fh->fh_fsid[0] =3D new_encode_dev(MKDEV(ntohl((__force __be32)fh->fh_fsid[=
0]),
+						      ntohl((__force __be32)fh->fh_fsid[1])));
+		fh->fh_fsid[1] =3D fh->fh_fsid[2];
 	}
+	data_left -=3D len;
+	if (data_left < 0)
+		return error;
+	exp =3D rqst_exp_find(rqstp, fh->fh_fsid_type, fh->fh_fsid);
+	fid =3D (struct fid *)(fh->fh_fsid + len);
=20
 	error =3D nfserr_stale;
 	if (IS_ERR(exp)) {
@@ -253,18 +241,7 @@ static __be32 nfsd_set_fh_dentry(struct svc_rqst *rqstp,=
 struct svc_fh *fhp)
 	if (rqstp->rq_vers > 2)
 		error =3D nfserr_badhandle;
=20
-	if (fh->fh_version !=3D 1) {
-		sfid.i32.ino =3D fh->ofh_ino;
-		sfid.i32.gen =3D fh->ofh_generation;
-		sfid.i32.parent_ino =3D fh->ofh_dirino;
-		fid =3D &sfid;
-		data_left =3D 3;
-		if (fh->ofh_dirino =3D=3D 0)
-			fileid_type =3D FILEID_INO32_GEN;
-		else
-			fileid_type =3D FILEID_INO32_GEN_PARENT;
-	} else
-		fileid_type =3D fh->fh_fileid_type;
+	fileid_type =3D fh->fh_fileid_type;
=20
 	if (fileid_type =3D=3D FILEID_ROOT)
 		dentry =3D dget(exp->ex_path.dentry);
@@ -452,20 +429,6 @@ static void _fh_update(struct svc_fh *fhp, struct svc_ex=
port *exp,
 	}
 }
=20
-/*
- * for composing old style file handles
- */
-static inline void _fh_update_old(struct dentry *dentry,
-				  struct svc_export *exp,
-				  struct knfsd_fh *fh)
-{
-	fh->ofh_ino =3D ino_t_to_u32(d_inode(dentry)->i_ino);
-	fh->ofh_generation =3D d_inode(dentry)->i_generation;
-	if (d_is_dir(dentry) ||
-	    (exp->ex_flags & NFSEXP_NOSUBTREECHECK))
-		fh->ofh_dirino =3D 0;
-}
-
 static bool is_root_export(struct svc_export *exp)
 {
 	return exp->ex_path.dentry =3D=3D exp->ex_path.dentry->d_sb->s_root;
@@ -562,9 +525,6 @@ fh_compose(struct svc_fh *fhp, struct svc_export *exp, st=
ruct dentry *dentry,
 	/* ref_fh is a reference file handle.
 	 * if it is non-null and for the same filesystem, then we should compose
 	 * a filehandle which is of the same version, where possible.
-	 * Currently, that means that if ref_fh->fh_handle.fh_version =3D=3D 0xca
-	 * Then create a 32byte filehandle using nfs_fhbase_old
-	 *
 	 */
=20
 	struct inode * inode =3D d_inode(dentry);
@@ -600,35 +560,21 @@ fh_compose(struct svc_fh *fhp, struct svc_export *exp, =
struct dentry *dentry,
 	fhp->fh_dentry =3D dget(dentry); /* our internal copy */
 	fhp->fh_export =3D exp_get(exp);
=20
-	if (fhp->fh_handle.fh_version =3D=3D 0xca) {
-		/* old style filehandle please */
-		memset(&fhp->fh_handle.fh_base, 0, NFS_FHSIZE);
-		fhp->fh_handle.fh_size =3D NFS_FHSIZE;
-		fhp->fh_handle.ofh_dcookie =3D 0xfeebbaca;
-		fhp->fh_handle.ofh_dev =3D  old_encode_dev(ex_dev);
-		fhp->fh_handle.ofh_xdev =3D fhp->fh_handle.ofh_dev;
-		fhp->fh_handle.ofh_xino =3D
-			ino_t_to_u32(d_inode(exp->ex_path.dentry)->i_ino);
-		fhp->fh_handle.ofh_dirino =3D ino_t_to_u32(parent_ino(dentry));
-		if (inode)
-			_fh_update_old(dentry, exp, &fhp->fh_handle);
-	} else {
-		fhp->fh_handle.fh_size =3D
-			key_len(fhp->fh_handle.fh_fsid_type) + 4;
-		fhp->fh_handle.fh_auth_type =3D 0;
-
-		mk_fsid(fhp->fh_handle.fh_fsid_type,
-			fhp->fh_handle.fh_fsid,
-			ex_dev,
-			d_inode(exp->ex_path.dentry)->i_ino,
-			exp->ex_fsid, exp->ex_uuid);
-
-		if (inode)
-			_fh_update(fhp, exp, dentry);
-		if (fhp->fh_handle.fh_fileid_type =3D=3D FILEID_INVALID) {
-			fh_put(fhp);
-			return nfserr_opnotsupp;
-		}
+	fhp->fh_handle.fh_size =3D
+		key_len(fhp->fh_handle.fh_fsid_type) + 4;
+	fhp->fh_handle.fh_auth_type =3D 0;
+
+	mk_fsid(fhp->fh_handle.fh_fsid_type,
+		fhp->fh_handle.fh_fsid,
+		ex_dev,
+		d_inode(exp->ex_path.dentry)->i_ino,
+		exp->ex_fsid, exp->ex_uuid);
+
+	if (inode)
+		_fh_update(fhp, exp, dentry);
+	if (fhp->fh_handle.fh_fileid_type =3D=3D FILEID_INVALID) {
+		fh_put(fhp);
+		return nfserr_opnotsupp;
 	}
=20
 	return 0;
@@ -649,16 +595,12 @@ fh_update(struct svc_fh *fhp)
 	dentry =3D fhp->fh_dentry;
 	if (d_really_is_negative(dentry))
 		goto out_negative;
-	if (fhp->fh_handle.fh_version !=3D 1) {
-		_fh_update_old(dentry, fhp->fh_export, &fhp->fh_handle);
-	} else {
-		if (fhp->fh_handle.fh_fileid_type !=3D FILEID_ROOT)
-			return 0;
+	if (fhp->fh_handle.fh_fileid_type !=3D FILEID_ROOT)
+		return 0;
=20
-		_fh_update(fhp, fhp->fh_export, dentry);
-		if (fhp->fh_handle.fh_fileid_type =3D=3D FILEID_INVALID)
-			return nfserr_opnotsupp;
-	}
+	_fh_update(fhp, fhp->fh_export, dentry);
+	if (fhp->fh_handle.fh_fileid_type =3D=3D FILEID_INVALID)
+		return nfserr_opnotsupp;
 	return 0;
 out_bad:
 	printk(KERN_ERR "fh_update: fh not verified!\n");
diff --git a/fs/nfsd/nfsfh.h b/fs/nfsd/nfsfh.h
index 988e4dfdfbd9..8b5587f274a7 100644
--- a/fs/nfsd/nfsfh.h
+++ b/fs/nfsd/nfsfh.h
@@ -14,27 +14,7 @@
 #include <linux/exportfs.h>
 #include <linux/nfs4.h>
=20
-
-/*
- * This is the old "dentry style" Linux NFSv2 file handle.
- *
- * The xino and xdev fields are currently used to transport the
- * ino/dev of the exported inode.
- */
-struct nfs_fhbase_old {
-	u32		fb_dcookie;	/* dentry cookie - always 0xfeebbaca */
-	u32		fb_ino;		/* our inode number */
-	u32		fb_dirino;	/* dir inode number, 0 for directories */
-	u32		fb_dev;		/* our device */
-	u32		fb_xdev;
-	u32		fb_xino;
-	u32		fb_generation;
-};
-
 /*
- * This is the new flexible, extensible style NFSv2/v3/v4 file handle.
- * by Neil Brown <neilb@cse.unsw.edu.au> - March 2000
- *
  * The file handle starts with a sequence of four-byte words.
  * The first word contains a version number (1) and three descriptor bytes
  * that tell how the remaining 3 variable length fields should be handled.
@@ -58,7 +38,7 @@ struct nfs_fhbase_old {
  *     6  - 16 byte uuid
  *     7  - 8 byte inode number and 16 byte uuid
  *
- * The fileid_type identified how the file within the filesystem is encoded.
+ * The fileid_type identifies how the file within the filesystem is encoded.
  *   The values for this field are filesystem specific, exccept that
  *   filesystems must not use the values '0' or '0xff'. 'See enum fid_type'
  *   in include/linux/exportfs.h for currently registered values.
@@ -66,7 +46,7 @@ struct nfs_fhbase_old {
 struct nfs_fhbase_new {
 	union {
 		struct {
-			u8		fb_version_aux;	/* =3D=3D 1, even =3D> nfs_fhbase_old */
+			u8		fb_version_aux;	/* =3D=3D 1 */
 			u8		fb_auth_type_aux;
 			u8		fb_fsid_type_aux;
 			u8		fb_fileid_type_aux;
@@ -75,7 +55,7 @@ struct nfs_fhbase_new {
 		/*	u32		fb_fileid[0]; floating */
 		};
 		struct {
-			u8		fb_version;	/* =3D=3D 1, even =3D> nfs_fhbase_old */
+			u8		fb_version;	/* =3D=3D 1 */
 			u8		fb_auth_type;
 			u8		fb_fsid_type;
 			u8		fb_fileid_type;
@@ -90,20 +70,11 @@ struct knfsd_fh {
 					 * a new file handle
 					 */
 	union {
-		struct nfs_fhbase_old	fh_old;
 		u32			fh_pad[NFS4_FHSIZE/4];
 		struct nfs_fhbase_new	fh_new;
 	} fh_base;
 };
=20
-#define ofh_dcookie		fh_base.fh_old.fb_dcookie
-#define ofh_ino			fh_base.fh_old.fb_ino
-#define ofh_dirino		fh_base.fh_old.fb_dirino
-#define ofh_dev			fh_base.fh_old.fb_dev
-#define ofh_xdev		fh_base.fh_old.fb_xdev
-#define ofh_xino		fh_base.fh_old.fb_xino
-#define ofh_generation		fh_base.fh_old.fb_generation
-
 #define	fh_version		fh_base.fh_new.fb_version
 #define	fh_fsid_type		fh_base.fh_new.fb_fsid_type
 #define	fh_auth_type		fh_base.fh_new.fb_auth_type
--=20
2.32.0


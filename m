Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E5ED3F81C0
	for <lists+linux-nfs@lfdr.de>; Thu, 26 Aug 2021 06:28:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229789AbhHZE3J (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 26 Aug 2021 00:29:09 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:46072 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229566AbhHZE3I (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 26 Aug 2021 00:29:08 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id B750422269;
        Thu, 26 Aug 2021 04:28:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1629952100; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=Ex3qLV3/Tz0E/wuHyZ4gWQEhe3V0p8ws3unSwMwWRrA=;
        b=kmw5veeoFzoanAGsxSitRw11EnEIem7/A9/83wXRcjbnsg+Ng7XYunSHBZEw17fI3ZTuEX
        69S49xC8RlL4D8T57T7eulHwX2mHuhXNRU15HWZpRyvzve0zStY4x8hSH2UQolQkCy7S7y
        DzcyRTMnV8Tu3lGFQeRsFCwPpz8DnOM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1629952100;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=Ex3qLV3/Tz0E/wuHyZ4gWQEhe3V0p8ws3unSwMwWRrA=;
        b=AK+RcL4oIjzmJwJSfW6NdAnuQReUPIBG0pLBwtlIvjKuYHJnNJCkinq/Dvth644ZDe7m7w
        aZNWOAmQDp/r2MDA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 25A3F13B75;
        Thu, 26 Aug 2021 04:28:18 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id Fdc+NWIYJ2F+MgAAMHmgww
        (envelope-from <neilb@suse.de>); Thu, 26 Aug 2021 04:28:18 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
From:   "NeilBrown" <neilb@suse.de>
To:     "J.  Bruce Fields" <bfields@fieldses.org>,
        Chuck Lever <chuck.lever@oracle.com>,
        Christoph Hellwig <hch@lst.de>
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH] NFSD: drop support for ancient file-handles
Date:   Thu, 26 Aug 2021 14:28:15 +1000
Message-id: <162995209561.7591.4202079352301963089@noble.neil.brown.name>
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org


File-handles not in the "new" or "version 1" format have not been handed
out for new mounts since Linux 2.4 which was released 20 years ago.
I think it is safe to say that no such file handles are still in use,
and that we can drop support for them.

This patch also moves the nfsfh.h from the include/uapi directory into
fs/nfsd.  I can find no evidence of it being used anywhere outside the
kernel.  Certainly nfs-utils and wireshark do not use it.

fh_base and fh_pad are occasionally used to refer to the whole
filehandle.  These are replaced with "fh_raw" which is hopefully more
meaningful.

Signed-off-by: NeilBrown <neilb@suse.de>
---

I found
 https://www.spinics.net/lists/linux-nfs/msg43280.html
 "Re: [PATCH] nfsd: clean up fh_auth usage"
from 2014 where moving nfsfh.h out of uapi was considered but not
actioned. Christoph said he would "do some research if the
uapi <linux/nfsd/*.h> headers are used anywhere at all".  I can find no
report on the result of that research.  My own research turned up
nothing.

Thanks,
NeilBrown


 fs/nfsd/lockd.c                 |   2 +-
 fs/nfsd/nfs3xdr.c               |   4 +-
 fs/nfsd/nfs4callback.c          |   2 +-
 fs/nfsd/nfs4proc.c              |   2 +-
 fs/nfsd/nfs4state.c             |   4 +-
 fs/nfsd/nfs4xdr.c               |   4 +-
 fs/nfsd/nfsctl.c                |   6 +-
 fs/nfsd/nfsfh.c                 | 177 +++++++++++---------------------
 fs/nfsd/nfsfh.h                 |  55 +++++++++-
 fs/nfsd/nfsxdr.c                |   4 +-
 include/uapi/linux/nfsd/nfsfh.h | 116 ---------------------
 11 files changed, 126 insertions(+), 250 deletions(-)
 delete mode 100644 include/uapi/linux/nfsd/nfsfh.h

diff --git a/fs/nfsd/lockd.c b/fs/nfsd/lockd.c
index 3f5b3d7b62b7..74d1630e7994 100644
--- a/fs/nfsd/lockd.c
+++ b/fs/nfsd/lockd.c
@@ -33,7 +33,7 @@ nlm_fopen(struct svc_rqst *rqstp, struct nfs_fh *f, struct =
file **filp)
 	/* must initialize before using! but maxsize doesn't matter */
 	fh_init(&fh,0);
 	fh.fh_handle.fh_size =3D f->size;
-	memcpy((char*)&fh.fh_handle.fh_base, f->data, f->size);
+	memcpy((char*)&fh.fh_handle.fh_raw, f->data, f->size);
 	fh.fh_export =3D NULL;
=20
 	nfserr =3D nfsd_open(rqstp, &fh, S_IFREG, NFSD_MAY_LOCK, filp);
diff --git a/fs/nfsd/nfs3xdr.c b/fs/nfsd/nfs3xdr.c
index 0a5ebc52e6a9..3d37923afb06 100644
--- a/fs/nfsd/nfs3xdr.c
+++ b/fs/nfsd/nfs3xdr.c
@@ -92,7 +92,7 @@ svcxdr_decode_nfs_fh3(struct xdr_stream *xdr, struct svc_fh=
 *fhp)
 		return false;
 	fh_init(fhp, NFS3_FHSIZE);
 	fhp->fh_handle.fh_size =3D size;
-	memcpy(&fhp->fh_handle.fh_base, p, size);
+	memcpy(&fhp->fh_handle.fh_raw, p, size);
=20
 	return true;
 }
@@ -131,7 +131,7 @@ svcxdr_encode_nfs_fh3(struct xdr_stream *xdr, const struc=
t svc_fh *fhp)
 	*p++ =3D cpu_to_be32(size);
 	if (size)
 		p[XDR_QUADLEN(size) - 1] =3D 0;
-	memcpy(p, &fhp->fh_handle.fh_base, size);
+	memcpy(p, &fhp->fh_handle.fh_raw, size);
=20
 	return true;
 }
diff --git a/fs/nfsd/nfs4callback.c b/fs/nfsd/nfs4callback.c
index 0f8b10f363e7..11f8715d92d6 100644
--- a/fs/nfsd/nfs4callback.c
+++ b/fs/nfsd/nfs4callback.c
@@ -121,7 +121,7 @@ static void encode_nfs_fh4(struct xdr_stream *xdr, const =
struct knfsd_fh *fh)
=20
 	BUG_ON(length > NFS4_FHSIZE);
 	p =3D xdr_reserve_space(xdr, 4 + length);
-	xdr_encode_opaque(p, &fh->fh_base, length);
+	xdr_encode_opaque(p, &fh->fh_raw, length);
 }
=20
 /*
diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
index 486c5dba4b65..4872b9519a72 100644
--- a/fs/nfsd/nfs4proc.c
+++ b/fs/nfsd/nfs4proc.c
@@ -519,7 +519,7 @@ nfsd4_putfh(struct svc_rqst *rqstp, struct nfsd4_compound=
_state *cstate,
=20
 	fh_put(&cstate->current_fh);
 	cstate->current_fh.fh_handle.fh_size =3D putfh->pf_fhlen;
-	memcpy(&cstate->current_fh.fh_handle.fh_base, putfh->pf_fhval,
+	memcpy(&cstate->current_fh.fh_handle.fh_raw, putfh->pf_fhval,
 	       putfh->pf_fhlen);
 	ret =3D fh_verify(rqstp, &cstate->current_fh, 0, NFSD_MAY_BYPASS_GSS);
 #ifdef CONFIG_NFSD_V4_2_INTER_SSC
diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index fa67ecd5fe63..d66b4be99063 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -1010,7 +1010,7 @@ static int delegation_blocked(struct knfsd_fh *fh)
 		}
 		spin_unlock(&blocked_delegations_lock);
 	}
-	hash =3D jhash(&fh->fh_base, fh->fh_size, 0);
+	hash =3D jhash(&fh->fh_raw, fh->fh_size, 0);
 	if (test_bit(hash&255, bd->set[0]) &&
 	    test_bit((hash>>8)&255, bd->set[0]) &&
 	    test_bit((hash>>16)&255, bd->set[0]))
@@ -1029,7 +1029,7 @@ static void block_delegations(struct knfsd_fh *fh)
 	u32 hash;
 	struct bloom_pair *bd =3D &blocked_delegations;
=20
-	hash =3D jhash(&fh->fh_base, fh->fh_size, 0);
+	hash =3D jhash(&fh->fh_raw, fh->fh_size, 0);
=20
 	spin_lock(&blocked_delegations_lock);
 	__set_bit(hash&255, bd->set[bd->new]);
diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
index 7abeccb975b2..a54b2845473b 100644
--- a/fs/nfsd/nfs4xdr.c
+++ b/fs/nfsd/nfs4xdr.c
@@ -3110,7 +3110,7 @@ nfsd4_encode_fattr(struct xdr_stream *xdr, struct svc_f=
h *fhp,
 		p =3D xdr_reserve_space(xdr, fhp->fh_handle.fh_size + 4);
 		if (!p)
 			goto out_resource;
-		p =3D xdr_encode_opaque(p, &fhp->fh_handle.fh_base,
+		p =3D xdr_encode_opaque(p, &fhp->fh_handle.fh_raw,
 					fhp->fh_handle.fh_size);
 	}
 	if (bmval0 & FATTR4_WORD0_FILEID) {
@@ -3667,7 +3667,7 @@ nfsd4_encode_getfh(struct nfsd4_compoundres *resp, __be=
32 nfserr, struct svc_fh
 	p =3D xdr_reserve_space(xdr, len + 4);
 	if (!p)
 		return nfserr_resource;
-	p =3D xdr_encode_opaque(p, &fhp->fh_handle.fh_base, len);
+	p =3D xdr_encode_opaque(p, &fhp->fh_handle.fh_raw, len);
 	return 0;
 }
=20
diff --git a/fs/nfsd/nfsctl.c b/fs/nfsd/nfsctl.c
index c2c3d9077dc5..449b57e5e328 100644
--- a/fs/nfsd/nfsctl.c
+++ b/fs/nfsd/nfsctl.c
@@ -395,12 +395,12 @@ static ssize_t write_filehandle(struct file *file, char=
 *buf, size_t size)
 	auth_domain_put(dom);
 	if (len)
 		return len;
-=09
+
 	mesg =3D buf;
 	len =3D SIMPLE_TRANSACTION_LIMIT;
-	qword_addhex(&mesg, &len, (char*)&fh.fh_base, fh.fh_size);
+	qword_addhex(&mesg, &len, (char*)&fh.fh_raw, fh.fh_size);
 	mesg[-1] =3D '\n';
-	return mesg - buf;=09
+	return mesg - buf;
 }
=20
 /*
diff --git a/fs/nfsd/nfsfh.c b/fs/nfsd/nfsfh.c
index c475d2271f9c..7695c0f1eefe 100644
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
+	if  (fh->fh_fsid_type =3D=3D FSID_MAJOR_MINOR) {
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
@@ -600,35 +563,21 @@ fh_compose(struct svc_fh *fhp, struct svc_export *exp, =
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
@@ -649,23 +598,19 @@ fh_update(struct svc_fh *fhp)
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
 	return nfserr_serverfault;
 out_negative:
 	printk(KERN_ERR "fh_update: %pd2 still negative!\n",
-		dentry);
+	       dentry);
 	return nfserr_serverfault;
 }
=20
@@ -702,12 +647,12 @@ char * SVCFH_fmt(struct svc_fh *fhp)
 	static char buf[80];
 	sprintf(buf, "%d: %08x %08x %08x %08x %08x %08x",
 		fh->fh_size,
-		fh->fh_base.fh_pad[0],
-		fh->fh_base.fh_pad[1],
-		fh->fh_base.fh_pad[2],
-		fh->fh_base.fh_pad[3],
-		fh->fh_base.fh_pad[4],
-		fh->fh_base.fh_pad[5]);
+		fh->fh_raw[0],
+		fh->fh_raw[1],
+		fh->fh_raw[2],
+		fh->fh_raw[3],
+		fh->fh_raw[4],
+		fh->fh_raw[5]);
 	return buf;
 }
=20
diff --git a/fs/nfsd/nfsfh.h b/fs/nfsd/nfsfh.h
index 6106697adc04..f36234c474dc 100644
--- a/fs/nfsd/nfsfh.h
+++ b/fs/nfsd/nfsfh.h
@@ -10,9 +10,56 @@
=20
 #include <linux/crc32.h>
 #include <linux/sunrpc/svc.h>
-#include <uapi/linux/nfsd/nfsfh.h>
 #include <linux/iversion.h>
 #include <linux/exportfs.h>
+#include <linux/nfs4.h>
+
+/*
+ * The file handle starts with a sequence of four-byte words.
+ * The first word contains a version number (1) and three descriptor bytes
+ * that tell how the remaining 3 variable length fields should be handled.
+ * These three bytes are auth_type, fsid_type and fileid_type.
+ *
+ * All four-byte values are in host-byte-order.
+ *
+ * The auth_type field is deprecated and must be set to 0.
+ *
+ * The fsid_type identifies how the filesystem (or export point) is
+ *    encoded.
+ *  Current values:
+ *     0  - 4 byte device id (ms-2-bytes major, ls-2-bytes minor), 4byte ino=
de number
+ *        NOTE: we cannot use the kdev_t device id value, because kdev_t.h
+ *              says we mustn't.  We must break it up and reassemble.
+ *     1  - 4 byte user specified identifier
+ *     2  - 4 byte major, 4 byte minor, 4 byte inode number - DEPRECATED
+ *     3  - 4 byte device id, encoded for user-space, 4 byte inode number
+ *     4  - 4 byte inode number and 4 byte uuid
+ *     5  - 8 byte uuid
+ *     6  - 16 byte uuid
+ *     7  - 8 byte inode number and 16 byte uuid
+ *
+ * The fileid_type identified how the file within the filesystem is encoded.
+ *   The values for this field are filesystem specific, exccept that
+ *   filesystems must not use the values '0' or '0xff'. 'See enum fid_type'
+ *   in include/linux/exportfs.h for currently registered values.
+ */
+
+struct knfsd_fh {
+	unsigned int	fh_size;	/*
+					 * Points to the current size while
+					 * building a new file handle.
+					 */
+	union {
+		__u32			fh_raw[NFS4_FHSIZE/4];
+		struct {
+			__u8		fh_version;	/* =3D=3D 1 */
+			__u8		fh_auth_type;	/* deprecated */
+			__u8		fh_fsid_type;
+			__u8		fh_fileid_type;
+			__u32		fh_fsid[]; /* flexible-array member */
+		};
+	};
+};
=20
 static inline __u32 ino_t_to_u32(ino_t ino)
 {
@@ -188,7 +235,7 @@ static inline void
 fh_copy_shallow(struct knfsd_fh *dst, struct knfsd_fh *src)
 {
 	dst->fh_size =3D src->fh_size;
-	memcpy(&dst->fh_base, &src->fh_base, src->fh_size);
+	memcpy(&dst->fh_raw, &src->fh_raw, src->fh_size);
 }
=20
 static __inline__ struct svc_fh *
@@ -203,7 +250,7 @@ static inline bool fh_match(struct knfsd_fh *fh1, struct =
knfsd_fh *fh2)
 {
 	if (fh1->fh_size !=3D fh2->fh_size)
 		return false;
-	if (memcmp(fh1->fh_base.fh_pad, fh2->fh_base.fh_pad, fh1->fh_size) !=3D 0)
+	if (memcmp(fh1->fh_raw, fh2->fh_raw, fh1->fh_size) !=3D 0)
 		return false;
 	return true;
 }
@@ -227,7 +274,7 @@ static inline bool fh_fsid_match(struct knfsd_fh *fh1, st=
ruct knfsd_fh *fh2)
  */
 static inline u32 knfsd_fh_hash(const struct knfsd_fh *fh)
 {
-	return ~crc32_le(0xFFFFFFFF, (unsigned char *)&fh->fh_base, fh->fh_size);
+	return ~crc32_le(0xFFFFFFFF, (unsigned char *)&fh->fh_raw, fh->fh_size);
 }
 #else
 static inline u32 knfsd_fh_hash(const struct knfsd_fh *fh)
diff --git a/fs/nfsd/nfsxdr.c b/fs/nfsd/nfsxdr.c
index a06c05fe3b42..082449c7d0db 100644
--- a/fs/nfsd/nfsxdr.c
+++ b/fs/nfsd/nfsxdr.c
@@ -64,7 +64,7 @@ svcxdr_decode_fhandle(struct xdr_stream *xdr, struct svc_fh=
 *fhp)
 	if (!p)
 		return false;
 	fh_init(fhp, NFS_FHSIZE);
-	memcpy(&fhp->fh_handle.fh_base, p, NFS_FHSIZE);
+	memcpy(&fhp->fh_handle.fh_raw, p, NFS_FHSIZE);
 	fhp->fh_handle.fh_size =3D NFS_FHSIZE;
=20
 	return true;
@@ -78,7 +78,7 @@ svcxdr_encode_fhandle(struct xdr_stream *xdr, const struct =
svc_fh *fhp)
 	p =3D xdr_reserve_space(xdr, NFS_FHSIZE);
 	if (!p)
 		return false;
-	memcpy(p, &fhp->fh_handle.fh_base, NFS_FHSIZE);
+	memcpy(p, &fhp->fh_handle.fh_raw, NFS_FHSIZE);
=20
 	return true;
 }
diff --git a/include/uapi/linux/nfsd/nfsfh.h b/include/uapi/linux/nfsd/nfsfh.h
deleted file mode 100644
index 427294dd56a1..000000000000
--- a/include/uapi/linux/nfsd/nfsfh.h
+++ /dev/null
@@ -1,116 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
-/*
- * This file describes the layout of the file handles as passed
- * over the wire.
- *
- * Copyright (C) 1995, 1996, 1997 Olaf Kirch <okir@monad.swb.de>
- */
-
-#ifndef _UAPI_LINUX_NFSD_FH_H
-#define _UAPI_LINUX_NFSD_FH_H
-
-#include <linux/types.h>
-#include <linux/nfs.h>
-#include <linux/nfs2.h>
-#include <linux/nfs3.h>
-#include <linux/nfs4.h>
-
-/*
- * This is the old "dentry style" Linux NFSv2 file handle.
- *
- * The xino and xdev fields are currently used to transport the
- * ino/dev of the exported inode.
- */
-struct nfs_fhbase_old {
-	__u32		fb_dcookie;	/* dentry cookie - always 0xfeebbaca */
-	__u32		fb_ino;		/* our inode number */
-	__u32		fb_dirino;	/* dir inode number, 0 for directories */
-	__u32		fb_dev;		/* our device */
-	__u32		fb_xdev;
-	__u32		fb_xino;
-	__u32		fb_generation;
-};
-
-/*
- * This is the new flexible, extensible style NFSv2/v3/v4 file handle.
- * by Neil Brown <neilb@cse.unsw.edu.au> - March 2000
- *
- * The file handle starts with a sequence of four-byte words.
- * The first word contains a version number (1) and three descriptor bytes
- * that tell how the remaining 3 variable length fields should be handled.
- * These three bytes are auth_type, fsid_type and fileid_type.
- *
- * All four-byte values are in host-byte-order.
- *
- * The auth_type field is deprecated and must be set to 0.
- *
- * The fsid_type identifies how the filesystem (or export point) is
- *    encoded.
- *  Current values:
- *     0  - 4 byte device id (ms-2-bytes major, ls-2-bytes minor), 4byte ino=
de number
- *        NOTE: we cannot use the kdev_t device id value, because kdev_t.h
- *              says we mustn't.  We must break it up and reassemble.
- *     1  - 4 byte user specified identifier
- *     2  - 4 byte major, 4 byte minor, 4 byte inode number - DEPRECATED
- *     3  - 4 byte device id, encoded for user-space, 4 byte inode number
- *     4  - 4 byte inode number and 4 byte uuid
- *     5  - 8 byte uuid
- *     6  - 16 byte uuid
- *     7  - 8 byte inode number and 16 byte uuid
- *
- * The fileid_type identified how the file within the filesystem is encoded.
- *   The values for this field are filesystem specific, exccept that
- *   filesystems must not use the values '0' or '0xff'. 'See enum fid_type'
- *   in include/linux/exportfs.h for currently registered values.
- */
-struct nfs_fhbase_new {
-	union {
-		struct {
-			__u8		fb_version_aux;	/* =3D=3D 1, even =3D> nfs_fhbase_old */
-			__u8		fb_auth_type_aux;
-			__u8		fb_fsid_type_aux;
-			__u8		fb_fileid_type_aux;
-			__u32		fb_auth[1];
-			/*	__u32		fb_fsid[0]; floating */
-			/*	__u32		fb_fileid[0]; floating */
-		};
-		struct {
-			__u8		fb_version;	/* =3D=3D 1, even =3D> nfs_fhbase_old */
-			__u8		fb_auth_type;
-			__u8		fb_fsid_type;
-			__u8		fb_fileid_type;
-			__u32		fb_auth_flex[]; /* flexible-array member */
-		};
-	};
-};
-
-struct knfsd_fh {
-	unsigned int	fh_size;	/* significant for NFSv3.
-					 * Points to the current size while building
-					 * a new file handle
-					 */
-	union {
-		struct nfs_fhbase_old	fh_old;
-		__u32			fh_pad[NFS4_FHSIZE/4];
-		struct nfs_fhbase_new	fh_new;
-	} fh_base;
-};
-
-#define ofh_dcookie		fh_base.fh_old.fb_dcookie
-#define ofh_ino			fh_base.fh_old.fb_ino
-#define ofh_dirino		fh_base.fh_old.fb_dirino
-#define ofh_dev			fh_base.fh_old.fb_dev
-#define ofh_xdev		fh_base.fh_old.fb_xdev
-#define ofh_xino		fh_base.fh_old.fb_xino
-#define ofh_generation		fh_base.fh_old.fb_generation
-
-#define	fh_version		fh_base.fh_new.fb_version
-#define	fh_fsid_type		fh_base.fh_new.fb_fsid_type
-#define	fh_auth_type		fh_base.fh_new.fb_auth_type
-#define	fh_fileid_type		fh_base.fh_new.fb_fileid_type
-#define	fh_fsid			fh_base.fh_new.fb_auth_flex
-
-/* Do not use, provided for userspace compatiblity. */
-#define	fh_auth			fh_base.fh_new.fb_auth
-
-#endif /* _UAPI_LINUX_NFSD_FH_H */
--=20
2.32.0



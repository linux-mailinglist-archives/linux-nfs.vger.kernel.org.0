Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D1BF3FC200
	for <lists+linux-nfs@lfdr.de>; Tue, 31 Aug 2021 06:44:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230353AbhHaEni (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 31 Aug 2021 00:43:38 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:41670 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230244AbhHaEni (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 31 Aug 2021 00:43:38 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id EF9EE20106;
        Tue, 31 Aug 2021 04:42:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1630384962; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=GunPKnSkGzOn6BvzAe4MUgWszyyQV809KWj7A4CqNFM=;
        b=L5RTQRZLzkGLo5TLrVU+cCy6c55+0VHotNEBupHCzGwSeqVA1fJrjz96N3+AZT6iHjA46g
        YGN8Z594tH9cM2xPXs5P6HSi3+rEZVa5XPFH/FquPHB41EkXqLEx3tED8IMKas2J2bRaLX
        Fe9Q5EIKDvLdMftp0ymCigkVvkv5LrQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1630384962;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=GunPKnSkGzOn6BvzAe4MUgWszyyQV809KWj7A4CqNFM=;
        b=4s758vHBFUSxUXh5Os5lE2fE3ZKGqj0vy3aJIWqgO59IGK99h5vY0jnqm0/XDJIf7Qjfem
        IxAnWBi64XHGXwAA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id A0A7013A49;
        Tue, 31 Aug 2021 04:42:41 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id RcLUF0GzLWGhfgAAMHmgww
        (envelope-from <neilb@suse.de>); Tue, 31 Aug 2021 04:42:41 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
From:   "NeilBrown" <neilb@suse.de>
To:     "J.  Bruce Fields" <bfields@fieldses.org>,
        "Chuck Lever" <chuck.lever@oracle.com>
Cc:     "Christoph Hellwig" <hch@lst.de>, linux-nfs@vger.kernel.org
Subject: [PATCH 2/2] NFSD: simplify struct nfsfh
In-reply-to: <163038488360.7591.7865010833762169362@noble.neil.brown.name>
References: <162995209561.7591.4202079352301963089@noble.neil.brown.name>,
 <20210827151505.GA19199@lst.de>,
 <163038488360.7591.7865010833762169362@noble.neil.brown.name>
Date:   Tue, 31 Aug 2021 14:42:38 +1000
Message-id: <163038495873.7591.9260775605693695494@noble.neil.brown.name>
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org


Most of the fields in 'struct knfsd_fh' are 2 levels deep (a union and a
struct) and are accessed using macros:

 #define fh_FOO fh_base.fh_new.fb_FOO

This patch makes the union and struct anonymous, so that "fh_FOO" can be
a name directly within 'struct knfsd_fh' and the #defines aren't needed.

The file handle as a whole is sometimes accessed as "fh_base" or
"fh_base.fh_pad", neither of which are particularly helpful names.
As the struct holding the filehandle is now anonymous, we
cannot use the name of that, so we union it with 'fh_raw' and use that
where the raw filehandle is needed.

fh_raw is a 'char' array, removing any need to cast it for memcpy etc.

SVCFH_fmt() is simplified using the "%ph" printk format.  This
changes the appearance of filehandles in dprintk() debugging, making
them a little more precise.

Signed-off-by: NeilBrown <neilb@suse.de>
---
 fs/nfsd/flexfilelayout.c |  2 +-
 fs/nfsd/lockd.c          |  2 +-
 fs/nfsd/nfs3xdr.c        |  4 ++--
 fs/nfsd/nfs4callback.c   |  2 +-
 fs/nfsd/nfs4proc.c       |  4 ++--
 fs/nfsd/nfs4state.c      |  4 ++--
 fs/nfsd/nfs4xdr.c        |  4 ++--
 fs/nfsd/nfsctl.c         |  6 ++---
 fs/nfsd/nfsfh.c          | 13 ++++-------
 fs/nfsd/nfsfh.h          | 50 ++++++++++++----------------------------
 fs/nfsd/nfsxdr.c         |  4 ++--
 11 files changed, 35 insertions(+), 60 deletions(-)

diff --git a/fs/nfsd/flexfilelayout.c b/fs/nfsd/flexfilelayout.c
index db7ef07ae50c..2e2f1d5e9f62 100644
--- a/fs/nfsd/flexfilelayout.c
+++ b/fs/nfsd/flexfilelayout.c
@@ -61,7 +61,7 @@ nfsd4_ff_proc_layoutget(struct inode *inode, const struct s=
vc_fh *fhp,
 		goto out_error;
=20
 	fl->fh.size =3D fhp->fh_handle.fh_size;
-	memcpy(fl->fh.data, &fhp->fh_handle.fh_base, fl->fh.size);
+	memcpy(fl->fh.data, &fhp->fh_handle.fh_raw, fl->fh.size);
=20
 	/* Give whole file layout segments */
 	seg->offset =3D 0;
diff --git a/fs/nfsd/lockd.c b/fs/nfsd/lockd.c
index 3f5b3d7b62b7..9f6eb091db08 100644
--- a/fs/nfsd/lockd.c
+++ b/fs/nfsd/lockd.c
@@ -33,7 +33,7 @@ nlm_fopen(struct svc_rqst *rqstp, struct nfs_fh *f, struct =
file **filp)
 	/* must initialize before using! but maxsize doesn't matter */
 	fh_init(&fh,0);
 	fh.fh_handle.fh_size =3D f->size;
-	memcpy((char*)&fh.fh_handle.fh_base, f->data, f->size);
+	memcpy(&fh.fh_handle.fh_raw, f->data, f->size);
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
index 486c5dba4b65..3f7e59ec4e32 100644
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
@@ -1383,7 +1383,7 @@ nfsd4_setup_inter_ssc(struct svc_rqst *rqstp,
 	s_fh =3D &cstate->save_fh;
=20
 	copy->c_fh.size =3D s_fh->fh_handle.fh_size;
-	memcpy(copy->c_fh.data, &s_fh->fh_handle.fh_base, copy->c_fh.size);
+	memcpy(copy->c_fh.data, &s_fh->fh_handle.fh_raw, copy->c_fh.size);
 	copy->stateid.seqid =3D cpu_to_be32(s_stid->si_generation);
 	memcpy(copy->stateid.other, (void *)&s_stid->si_opaque,
 	       sizeof(stateid_opaque_t));
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
index c2c3d9077dc5..5e48bc48942e 100644
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
+	qword_addhex(&mesg, &len, fh.fh_raw, fh.fh_size);
 	mesg[-1] =3D '\n';
-	return mesg - buf;=09
+	return mesg - buf;
 }
=20
 /*
diff --git a/fs/nfsd/nfsfh.c b/fs/nfsd/nfsfh.c
index 9194a940b23d..e74ee4e63866 100644
--- a/fs/nfsd/nfsfh.c
+++ b/fs/nfsd/nfsfh.c
@@ -643,16 +643,11 @@ fh_put(struct svc_fh *fhp)
 char * SVCFH_fmt(struct svc_fh *fhp)
 {
 	struct knfsd_fh *fh =3D &fhp->fh_handle;
+	static char buf[2+1+1+64*3+1];
=20
-	static char buf[80];
-	sprintf(buf, "%d: %08x %08x %08x %08x %08x %08x",
-		fh->fh_size,
-		fh->fh_base.fh_pad[0],
-		fh->fh_base.fh_pad[1],
-		fh->fh_base.fh_pad[2],
-		fh->fh_base.fh_pad[3],
-		fh->fh_base.fh_pad[4],
-		fh->fh_base.fh_pad[5]);
+	if (fh->fh_size < 0 || fh->fh_size> 64)
+		return "bad-fh";
+	sprintf(buf, "%d: %*ph", fh->fh_size, fh->fh_size, fh->fh_raw);
 	return buf;
 }
=20
diff --git a/fs/nfsd/nfsfh.h b/fs/nfsd/nfsfh.h
index 17fc6f57d1bb..d11e4b6870d6 100644
--- a/fs/nfsd/nfsfh.h
+++ b/fs/nfsd/nfsfh.h
@@ -43,44 +43,24 @@
  *   filesystems must not use the values '0' or '0xff'. 'See enum fid_type'
  *   in include/linux/exportfs.h for currently registered values.
  */
-struct nfs_fhbase_new {
-	union {
-		struct {
-			u8		fb_version_aux;	/* =3D=3D 1, even =3D> nfs_fhbase_old */
-			u8		fb_auth_type_aux;
-			u8		fb_fsid_type_aux;
-			u8		fb_fileid_type_aux;
-			u32		fb_auth[1];
-		/*	u32		fb_fsid[0]; floating */
-		/*	u32		fb_fileid[0]; floating */
-		};
-		struct {
-			u8		fb_version;	/* =3D=3D 1, even =3D> nfs_fhbase_old */
-			u8		fb_auth_type;
-			u8		fb_fsid_type;
-			u8		fb_fileid_type;
-			u32		fb_auth_flex[]; /* flexible-array member */
-		};
-	};
-};
=20
 struct knfsd_fh {
-	unsigned int	fh_size;	/* significant for NFSv3.
-					 * Points to the current size while building
-					 * a new file handle
+	unsigned int	fh_size;	/*
+					 * Points to the current size while
+					 * building a new file handle.
 					 */
 	union {
-		u32			fh_pad[NFS4_FHSIZE/4];
-		struct nfs_fhbase_new	fh_new;
-	} fh_base;
+		char			fh_raw[NFS4_FHSIZE];
+		struct {
+			u8		fh_version;	/* =3D=3D 1 */
+			u8		fh_auth_type;	/* deprecated */
+			u8		fh_fsid_type;
+			u8		fh_fileid_type;
+			u32		fh_fsid[]; /* flexible-array member */
+		};
+	};
 };
=20
-#define	fh_version		fh_base.fh_new.fb_version
-#define	fh_fsid_type		fh_base.fh_new.fb_fsid_type
-#define	fh_auth_type		fh_base.fh_new.fb_auth_type
-#define	fh_fileid_type		fh_base.fh_new.fb_fileid_type
-#define	fh_fsid			fh_base.fh_new.fb_auth_flex
-
 static inline __u32 ino_t_to_u32(ino_t ino)
 {
 	return (__u32) ino;
@@ -255,7 +235,7 @@ static inline void
 fh_copy_shallow(struct knfsd_fh *dst, struct knfsd_fh *src)
 {
 	dst->fh_size =3D src->fh_size;
-	memcpy(&dst->fh_base, &src->fh_base, src->fh_size);
+	memcpy(&dst->fh_raw, &src->fh_raw, src->fh_size);
 }
=20
 static __inline__ struct svc_fh *
@@ -270,7 +250,7 @@ static inline bool fh_match(struct knfsd_fh *fh1, struct =
knfsd_fh *fh2)
 {
 	if (fh1->fh_size !=3D fh2->fh_size)
 		return false;
-	if (memcmp(fh1->fh_base.fh_pad, fh2->fh_base.fh_pad, fh1->fh_size) !=3D 0)
+	if (memcmp(fh1->fh_raw, fh2->fh_raw, fh1->fh_size) !=3D 0)
 		return false;
 	return true;
 }
@@ -294,7 +274,7 @@ static inline bool fh_fsid_match(struct knfsd_fh *fh1, st=
ruct knfsd_fh *fh2)
  */
 static inline u32 knfsd_fh_hash(const struct knfsd_fh *fh)
 {
-	return ~crc32_le(0xFFFFFFFF, (unsigned char *)&fh->fh_base, fh->fh_size);
+	return ~crc32_le(0xFFFFFFFF, fh->fh_raw, fh->fh_size);
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
--=20
2.32.0


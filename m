Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 095A63F8235
	for <lists+linux-nfs@lfdr.de>; Thu, 26 Aug 2021 08:03:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231134AbhHZGD4 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 26 Aug 2021 02:03:56 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:54810 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230313AbhHZGD4 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 26 Aug 2021 02:03:56 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id C18852220F;
        Thu, 26 Aug 2021 06:03:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1629957788; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=MdL08DvbLkMTzgBfcDRGN+6VaQUe08pmIKJ7fVll1Tg=;
        b=Wte8hdwhCGrisEd9oN0H8uSRamcOU1rwh7ZXhg+Q+lssD+ilf9qFM91DEw5t9sTFTXr2t8
        SLkhCmY0YYescqf6wDJvvtEn6Mx5I2Rw9wiIi1ihlOUadwMIEOkJfFG+ka7LxrvIcjCbqd
        yVf/oQ+qzm+81xgRv72jLRMXlSRx1/M=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1629957788;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=MdL08DvbLkMTzgBfcDRGN+6VaQUe08pmIKJ7fVll1Tg=;
        b=TBi8SE12tefxmcJLuG8ROCcjQv8vLXEMhpVdEBSxQW5iIWoD4onDzJht4RJJQl+WwyRMBv
        u/55PXjKcVdp4VDQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 2F34F12FC5;
        Thu, 26 Aug 2021 06:03:06 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id R1xAN5ouJ2GhRwAAMHmgww
        (envelope-from <neilb@suse.de>); Thu, 26 Aug 2021 06:03:06 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
From:   "NeilBrown" <neilb@suse.de>
To:     "J.  Bruce Fields" <bfields@fieldses.org>,
        "Chuck Lever" <chuck.lever@oracle.com>
Cc:     linux-nfs@vger.kernel.org, Josef Bacik <josef@toxicpanda.com>
Subject: [PATCH v2] BTRFS/NFSD: provide more unique inode number for btrfs export
In-reply-to: <162995209561.7591.4202079352301963089@noble.neil.brown.name>
References: <162995209561.7591.4202079352301963089@noble.neil.brown.name>
Date:   Thu, 26 Aug 2021 16:03:04 +1000
Message-id: <162995778427.7591.11743795294299207756@noble.neil.brown.name>
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org


[[ Hi Bruce and Chuck,
   I've rebased this patch on the earlier patch I sent which allows
   me to use the name "fh_flags".  I've also added a missing #include.
   I've added the 'Acked-by' which Joesf provided earlier for the
   btrfs-part.  I don't have an 'ack' for the  stat.h part, but no-one
   has complained wither.
   I think it is as ready as it can be, and am keen to know what you
   think.
   I'm not *very* keen on testing s_magic in nfsd code (though we
   already have a couple of such tests in nfs3proc.c), but it does have
   the advantage of ensuring that no other filesystem can use this
   functionality without landing a patch in fs/nfsd/.
=20
   Thanks for any review that you can provide,
   NeilBrown
]]

BTRFS does not provide unique inode numbers across a filesystem.
It only provides unique inode numbers within a subvolume and
uses synthetic device numbers for different subvolumes to ensure
uniqueness for device+inode.

nfsd cannot use these varying synthetic device numbers.  If nfsd were to
synthesise different stable filesystem ids to give to the client, that
would cause subvolumes to appear in the mount table on the client, even
though they don't appear in the mount table on the server.  Also, NFSv3
doesn't support changing the filesystem id without a new explicit mount
on the client (this is partially supported in practice, but violates the
protocol specification and has problems in some edge cases).

So currently, the roots of all subvolumes report the same inode number
in the same filesystem to NFS clients and tools like 'find' notice that
a directory has the same identity as an ancestor, and so refuse to
enter that directory.

This patch allows btrfs (or any filesystem) to provide a 64bit number
that can be xored with the inode number to make the number more unique.
Rather than the client being certain to see duplicates, with this patch
it is possible but extremely rare.

The number that btrfs provides is a swab64() version of the subvolume
identifier.  This has most entropy in the high bits (the low bits of the
subvolume identifer), while the inode has most entropy in the low bits.
The result will always be unique within a subvolume, and will almost
always be unique across the filesystem.

If an upgrade of the NFS server caused all inode numbers in an exportfs
BTRFS filesystem to appear to the client to change, the client may not
handle this well.  The Linux client will cause any open files to become
'stale'.  If the mount point changed inode number, the whole mount would
become inaccessible.

To avoid this, an unused byte in the filehandle (fh_auth) has been
repurposed as "fh_flags".  The new behaviour of uniquifying inode number
is only activated when a new flag is set.

NFSD will only set this flag in filehandles it reports if the filehandle
of the parent (provided by the client) contains the bit, or if
 - the filehandle for the parent is not provided or is for a different
   export and
 - the filehandle refers to a BTRFS filesystem.

Thus if you have a BTRFS filesystem originally mounted from a server
without this patch, the flag will never be set and the current behaviour
will continue.  Only once you re-mount the filesystem (or the filesystem
is re-auto-mounted) will the inode numbers change.  When that happens,
it is likely that the filesystem st_dev number seen on the client will
change anyway.

Acked-by: Josef Bacik <josef@toxicpanda.com> (for BTFS change)
Signed-off-by: NeilBrown <neilb@suse.de>
---
 fs/btrfs/inode.c     |  4 ++++
 fs/nfsd/nfs3xdr.c    | 15 ++++++++++++++-
 fs/nfsd/nfs4xdr.c    |  7 ++++---
 fs/nfsd/nfsfh.c      | 14 ++++++++++++--
 fs/nfsd/nfsfh.h      | 34 +++++++++++++++++++++++++++++++---
 fs/nfsd/xdr3.h       |  2 ++
 include/linux/stat.h | 18 ++++++++++++++++++
 7 files changed, 85 insertions(+), 9 deletions(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 06f9f167222b..d35e2a30f25f 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -9195,6 +9195,10 @@ static int btrfs_getattr(struct user_namespace *mnt_us=
erns,
 	generic_fillattr(&init_user_ns, inode, stat);
 	stat->dev =3D BTRFS_I(inode)->root->anon_dev;
=20
+	if (BTRFS_I(inode)->root->root_key.objectid !=3D BTRFS_FS_TREE_OBJECTID)
+		stat->ino_uniquifier =3D
+			swab64(BTRFS_I(inode)->root->root_key.objectid);
+
 	spin_lock(&BTRFS_I(inode)->lock);
 	delalloc_bytes =3D BTRFS_I(inode)->new_delalloc_bytes;
 	inode_bytes =3D inode_get_bytes(inode);
diff --git a/fs/nfsd/nfs3xdr.c b/fs/nfsd/nfs3xdr.c
index 3d37923afb06..5e2d5c352ecd 100644
--- a/fs/nfsd/nfs3xdr.c
+++ b/fs/nfsd/nfs3xdr.c
@@ -340,6 +340,7 @@ svcxdr_encode_fattr3(struct svc_rqst *rqstp, struct xdr_s=
tream *xdr,
 {
 	struct user_namespace *userns =3D nfsd_user_namespace(rqstp);
 	__be32 *p;
+	u64 ino;
 	u64 fsid;
=20
 	p =3D xdr_reserve_space(xdr, XDR_UNIT * 21);
@@ -377,7 +378,8 @@ svcxdr_encode_fattr3(struct svc_rqst *rqstp, struct xdr_s=
tream *xdr,
 	p =3D xdr_encode_hyper(p, fsid);
=20
 	/* fileid */
-	p =3D xdr_encode_hyper(p, stat->ino);
+	ino =3D nfsd_uniquify_ino(fhp, stat);
+	p =3D xdr_encode_hyper(p, ino);
=20
 	p =3D encode_nfstime3(p, &stat->atime);
 	p =3D encode_nfstime3(p, &stat->mtime);
@@ -1151,6 +1153,17 @@ svcxdr_encode_entry3_common(struct nfsd3_readdirres *r=
esp, const char *name,
 	if (xdr_stream_encode_item_present(xdr) < 0)
 		return false;
 	/* fileid */
+	if (!resp->dir_have_uniquifier) {
+		struct kstat stat;
+		if (fh_getattr(&resp->fh, &stat) =3D=3D nfs_ok)
+			resp->dir_ino_uniquifier =3D
+				nfsd_ino_uniquifier(&resp->fh, &stat);
+		else
+			resp->dir_ino_uniquifier =3D 0;
+		resp->dir_have_uniquifier =3D true;
+	}
+	if (resp->dir_ino_uniquifier !=3D ino)
+		ino ^=3D resp->dir_ino_uniquifier;
 	if (xdr_stream_encode_u64(xdr, ino) < 0)
 		return false;
 	/* name */
diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
index a54b2845473b..6e31f6286e0b 100644
--- a/fs/nfsd/nfs4xdr.c
+++ b/fs/nfsd/nfs4xdr.c
@@ -3114,10 +3114,11 @@ nfsd4_encode_fattr(struct xdr_stream *xdr, struct svc=
_fh *fhp,
 					fhp->fh_handle.fh_size);
 	}
 	if (bmval0 & FATTR4_WORD0_FILEID) {
+		u64 ino =3D nfsd_uniquify_ino(fhp, &stat);
 		p =3D xdr_reserve_space(xdr, 8);
 		if (!p)
 			goto out_resource;
-		p =3D xdr_encode_hyper(p, stat.ino);
+		p =3D xdr_encode_hyper(p, ino);
 	}
 	if (bmval0 & FATTR4_WORD0_FILES_AVAIL) {
 		p =3D xdr_reserve_space(xdr, 8);
@@ -3274,7 +3275,7 @@ nfsd4_encode_fattr(struct xdr_stream *xdr, struct svc_f=
h *fhp,
=20
 		p =3D xdr_reserve_space(xdr, 8);
 		if (!p)
-                	goto out_resource;
+			goto out_resource;
 		/*
 		 * Get parent's attributes if not ignoring crossmount
 		 * and this is the root of a cross-mounted filesystem.
@@ -3284,7 +3285,7 @@ nfsd4_encode_fattr(struct xdr_stream *xdr, struct svc_f=
h *fhp,
 			err =3D get_parent_attributes(exp, &parent_stat);
 			if (err)
 				goto out_nfserr;
-			ino =3D parent_stat.ino;
+			ino =3D nfsd_uniquify_ino(fhp, &parent_stat);
 		}
 		p =3D xdr_encode_hyper(p, ino);
 	}
diff --git a/fs/nfsd/nfsfh.c b/fs/nfsd/nfsfh.c
index 7695c0f1eefe..18bb139f8bfe 100644
--- a/fs/nfsd/nfsfh.c
+++ b/fs/nfsd/nfsfh.c
@@ -9,6 +9,7 @@
  */
=20
 #include <linux/exportfs.h>
+#include <linux/magic.h>
=20
 #include <linux/sunrpc/svcauth_gss.h>
 #include "nfsd.h"
@@ -173,7 +174,7 @@ static __be32 nfsd_set_fh_dentry(struct svc_rqst *rqstp, =
struct svc_fh *fhp)
=20
 	if (--data_left < 0)
 		return error;
-	if (fh->fh_auth_type !=3D 0)
+	if ((fh->fh_flags & ~NFSD_FH_FLAG_ALL) !=3D 0)
 		return error;
 	len =3D key_len(fh->fh_fsid_type) / 4;
 	if (len =3D=3D 0)
@@ -532,6 +533,7 @@ fh_compose(struct svc_fh *fhp, struct svc_export *exp, st=
ruct dentry *dentry,
=20
 	struct inode * inode =3D d_inode(dentry);
 	dev_t ex_dev =3D exp_sb(exp)->s_dev;
+	u8 flags =3D 0;
=20
 	dprintk("nfsd: fh_compose(exp %02x:%02x/%ld %pd2, ino=3D%ld)\n",
 		MAJOR(ex_dev), MINOR(ex_dev),
@@ -548,6 +550,14 @@ fh_compose(struct svc_fh *fhp, struct svc_export *exp, s=
truct dentry *dentry,
 	/* If we have a ref_fh, then copy the fh_no_wcc setting from it. */
 	fhp->fh_no_wcc =3D ref_fh ? ref_fh->fh_no_wcc : false;
=20
+	if (ref_fh && ref_fh->fh_export =3D=3D exp) {
+		flags =3D ref_fh->fh_handle.fh_flags;
+	} else {
+		/* Set flags as needed */
+		if (exp->ex_path.mnt->mnt_sb->s_magic =3D=3D BTRFS_SUPER_MAGIC)
+			flags |=3D NFSD_FH_FLAG_INO_UNIQUIFY;
+	}
+
 	if (ref_fh =3D=3D fhp)
 		fh_put(ref_fh);
=20
@@ -565,7 +575,7 @@ fh_compose(struct svc_fh *fhp, struct svc_export *exp, st=
ruct dentry *dentry,
=20
 	fhp->fh_handle.fh_size =3D
 		key_len(fhp->fh_handle.fh_fsid_type) + 4;
-	fhp->fh_handle.fh_auth_type =3D 0;
+	fhp->fh_handle.fh_flags =3D flags;
=20
 	mk_fsid(fhp->fh_handle.fh_fsid_type,
 		fhp->fh_handle.fh_fsid,
diff --git a/fs/nfsd/nfsfh.h b/fs/nfsd/nfsfh.h
index f36234c474dc..bbc7ddd34143 100644
--- a/fs/nfsd/nfsfh.h
+++ b/fs/nfsd/nfsfh.h
@@ -18,11 +18,17 @@
  * The file handle starts with a sequence of four-byte words.
  * The first word contains a version number (1) and three descriptor bytes
  * that tell how the remaining 3 variable length fields should be handled.
- * These three bytes are auth_type, fsid_type and fileid_type.
+ * These three bytes are flags, fsid_type and fileid_type.
  *
  * All four-byte values are in host-byte-order.
  *
- * The auth_type field is deprecated and must be set to 0.
+ * The flags field (previously auth_type) can be used when nfsd behaviour
+ * needs to change in a non-compatible way, usually for some specific
+ * filesystem.  Flags should only be set in filehandles for filesystems which
+ * need them.
+ * Current values:
+ *   1  -  BTRFS only.  Cause stat->ino_uniquifier to be used to improve ino=
de
+ *         number uniqueness.
  *
  * The fsid_type identifies how the filesystem (or export point) is
  *    encoded.
@@ -53,7 +59,7 @@ struct knfsd_fh {
 		__u32			fh_raw[NFS4_FHSIZE/4];
 		struct {
 			__u8		fh_version;	/* =3D=3D 1 */
-			__u8		fh_auth_type;	/* deprecated */
+			__u8		fh_flags;
 			__u8		fh_fsid_type;
 			__u8		fh_fileid_type;
 			__u32		fh_fsid[]; /* flexible-array member */
@@ -131,6 +137,28 @@ enum fsid_source {
 };
 extern enum fsid_source fsid_source(const struct svc_fh *fhp);
=20
+enum nfsd_fh_flags {
+	NFSD_FH_FLAG_INO_UNIQUIFY =3D 1,	/* BTRFS only */
+
+	NFSD_FH_FLAG_ALL =3D 1
+};
+
+static inline u64 nfsd_ino_uniquifier(const struct svc_fh *fhp,
+				      const struct kstat *stat)
+{
+	if (fhp->fh_handle.fh_flags & NFSD_FH_FLAG_INO_UNIQUIFY)
+		return stat->ino_uniquifier;
+	return 0;
+}
+
+static inline u64 nfsd_uniquify_ino(const struct svc_fh *fhp,
+				    const struct kstat *stat)
+{
+	u64 u =3D nfsd_ino_uniquifier(fhp, stat);
+	if (u !=3D stat->ino)
+		return stat->ino ^ u;
+	return stat->ino;
+}
=20
 /*
  * This might look a little large to "inline" but in all calls except
diff --git a/fs/nfsd/xdr3.h b/fs/nfsd/xdr3.h
index 933008382bbe..d9b6c8314bbb 100644
--- a/fs/nfsd/xdr3.h
+++ b/fs/nfsd/xdr3.h
@@ -179,6 +179,8 @@ struct nfsd3_readdirres {
 	struct xdr_buf		dirlist;
 	struct svc_fh		scratch;
 	struct readdir_cd	common;
+	u64			dir_ino_uniquifier;
+	bool			dir_have_uniquifier;
 	unsigned int		cookie_offset;
 	struct svc_rqst *	rqstp;
=20
diff --git a/include/linux/stat.h b/include/linux/stat.h
index fff27e603814..0f3f74d302f8 100644
--- a/include/linux/stat.h
+++ b/include/linux/stat.h
@@ -46,6 +46,24 @@ struct kstat {
 	struct timespec64 btime;			/* File creation time */
 	u64		blocks;
 	u64		mnt_id;
+	/*
+	 * BTRFS does not provide unique inode numbers within a filesystem,
+	 * depending on a synthetic 'dev' to provide uniqueness.
+	 * NFSd cannot make use of this 'dev' number so clients often see
+	 * duplicate inode numbers.
+	 * For BTRFS, 'ino' is unlikely to use the high bits until the filesystem
+	 * has created a great many inodes.
+	 * It puts another number in ino_uniquifier which:
+	 * - has most entropy in the high bits
+	 * - is different precisely when 'dev' is different
+	 * - is stable across unmount/remount
+	 * NFSd can xor this with 'ino' to get a substantially more unique
+	 * number for reporting to the client.
+	 * The ino_uniquifier for a directory can reasonably be applied
+	 * to inode numbers reported by the readdir filldir callback.
+	 * It is NOT currently exported to user-space.
+	 */
+	u64		ino_uniquifier;
 };
=20
 #endif
--=20
2.32.0




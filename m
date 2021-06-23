Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6DC683B112D
	for <lists+linux-nfs@lfdr.de>; Wed, 23 Jun 2021 02:59:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229769AbhFWBBW (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 22 Jun 2021 21:01:22 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:58488 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229751AbhFWBBW (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 22 Jun 2021 21:01:22 -0400
Received: from imap.suse.de (imap-alt.suse-dmz.suse.de [192.168.254.47])
        (using TLSv1.2 with cipher ECDHE-ECDSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 4A73F2196B;
        Wed, 23 Jun 2021 00:59:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1624409945; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=E7mGQJSkpgyjYm2G/NycnP6vAQ15eHbGUGqhAHrJIyI=;
        b=RHvSndY6M3VP8fj1G4mq/tZEMgub7tAZ/cReWegwLigpdom+wnjJlYM/m271DulMbe9g01
        ucFbny5dleQ1HvcxFTPSvYelbjYhyPE2fSy9kqYNK1kHc9m4opLS4STGQgMs09hCtVzbFN
        stlkcdeQWjDkVUTYbnLXNpZp3Fk4L4Y=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1624409945;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=E7mGQJSkpgyjYm2G/NycnP6vAQ15eHbGUGqhAHrJIyI=;
        b=bv0qj5FbAT02QzGPDcMamMtvsJAnR85+u7vp5qPJIYjTtB2JbZJ6qWR1rrA6UFG6Pys4p6
        IGwJMc/893wgLMBg==
Received: from imap3-int (imap-alt.suse-dmz.suse.de [192.168.254.47])
        by imap.suse.de (Postfix) with ESMTP id 45C9F11A97;
        Wed, 23 Jun 2021 00:59:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1624409945; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=E7mGQJSkpgyjYm2G/NycnP6vAQ15eHbGUGqhAHrJIyI=;
        b=RHvSndY6M3VP8fj1G4mq/tZEMgub7tAZ/cReWegwLigpdom+wnjJlYM/m271DulMbe9g01
        ucFbny5dleQ1HvcxFTPSvYelbjYhyPE2fSy9kqYNK1kHc9m4opLS4STGQgMs09hCtVzbFN
        stlkcdeQWjDkVUTYbnLXNpZp3Fk4L4Y=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1624409945;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=E7mGQJSkpgyjYm2G/NycnP6vAQ15eHbGUGqhAHrJIyI=;
        b=bv0qj5FbAT02QzGPDcMamMtvsJAnR85+u7vp5qPJIYjTtB2JbZJ6qWR1rrA6UFG6Pys4p6
        IGwJMc/893wgLMBg==
Received: from director2.suse.de ([192.168.254.72])
        by imap3-int with ESMTPSA
        id 2MC8OVeH0mAEeQAALh3uQQ
        (envelope-from <neilb@suse.de>); Wed, 23 Jun 2021 00:59:03 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
From:   "NeilBrown" <neilb@suse.de>
To:     "Wang Yugui" <wangyugui@e16-tech.com>
Cc:     linux-nfs@vger.kernel.org
Subject: Re: any idea about auto export multiple btrfs snapshots?
In-reply-to: <20210622151407.C002.409509F4@e16-tech.com>
References: <162432531379.17441.15110145423567943074@noble.neil.brown.name>,
 <20210622112253.DAEE.409509F4@e16-tech.com>,
 <20210622151407.C002.409509F4@e16-tech.com>
Date:   Wed, 23 Jun 2021 10:59:00 +1000
Message-id: <162440994038.28671.7338874000115610814@noble.neil.brown.name>
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Tue, 22 Jun 2021, Wang Yugui wrote:
> >=20
> > btrfs subvol should be treated as virtual 'mount point' for nfsd in follo=
w_down().
>=20
> btrfs subvol crossmnt begin to work, although buggy.
>=20
> some subvol is crossmnt-ed, some subvol is yet not, and some dir is
> wrongly crossmnt-ed
>=20
> 'stat /nfs/test /nfs/test/sub1' will cause btrfs subvol crossmnt begin
> to happen.
>=20
> This is the current patch based on 5.10.44.=20
> At least nfsd_follow_up() is buggy.
>=20

I don't think the approach you are taking makes sense.  Let me explain
why.

The problem is that applications on the NFS client can see different
files or directories on the same (apparent) filesystem with the same
inode number.  Most application won't care and NFS itself doesn't get
confused by the duplicate inode numbers, but 'find' and similar programs
(probably 'tar' for example) do get upset.

This happens because BTRFS reuses inode numbers in subvols which it
presents to the kernel as all part of the one filesystem (or at least,
all part of the one mount point).  NFSD only sees one filesystem, and so
reports the same filesystem-id (fsid) for all objects.  The NFS client
then sees that the fsid is the same and tells applications that the
objects are all in the one filesystem.

To fix this, we need to make sure that nfsd reports a different fsid for
objects in different subvols.  There are two obvious ways to do this.

One is to teach nfsd to recognize btrfs subvolumes exactly like separate
filesystems (as nfsd already ensure each filesystem gets its own fsid).
This is the approach of my first suggestion.  It requires changing
nfsd_mountpoint() and follow_up() and any other code that is aware of
different filesytems.  As I mentioned, it also requires changing mountd
to be able to extract a list of subvols from btrfs because they don't
appear in /proc/mounts. =20

As you might know an NFS filehandle has 3 parts: a header, a filesystem
identifier, and an inode identifier.  This approach would involve giving
different subvols different filesystem identifiers in the filehandle.
This, it turns out is a very big change - bigger than I at first
imagined.

The second obvious approach is to leave the filehandles unchanged and to
continue to treat an entire btrfs filesystem as a single filesystem
EXCEPT when reporting the fsid to the NFS client.  All we *really* need
to do is make sure the client sees a different fsid when it enters a
part of the filesystem which re-uses inode numbers.  This is what my
latest patch did.

Your patch seems to combine ideas from both approaches.  It includes my
code to replace the fsid, but also intercepts follow_up etc.  This
cannot be useful.

As I noted when I posted it, there is a problem with my patch.  I now
understand that problem.

When NFS sees that fsid change it needs to create 2 inodes for that
directory.  One inode will be in the parent filesystem and will be
marked as an auto-mount point so that any lookup below that directory
will trigger an internal mount.  The other inode is the root of the
child filesystem.  It gets mounted on the first inode.

With normal filesystem mounts, there really is an inode in the parent
filesystem and NFS can find it (with NFSv4) using the MOUNTED_ON_FILEID
attribute.  This fileid will be different from all other inode numbers
in the parent filesystem.

With BTRFS there is no inode in the parent volume (as far as I know) so
there is nothing useful to return for MOUNTED_ON_FILEID.  This results
in NFS using the same inode number for the inode in the parent
filesystem as the inode in the child filesystem.  For btrfs, this will
be 256.  As there is already an inode in the parent filesystem with inum
256, 'find' complains.

The following patch addresses this by adding code to nfsd when it
determines MOUINTD_ON_FILEID to choose an number that should be unused
in btrfs.  With this change, 'find' seems to work correctly with NFSv4
mounts of btrfs.

This doesn't work with NFSv3 as NFSv3 doesn't have the MOUNTED_ON_FILEID
attribute - strictly speaking, the NFSv3 protocol doesn't support
crossing mount points, though the Linux implementation does allow it.

So this patch works and, I think, is the best we can do in terms of
functionality.  I don't like the details of the implementation though.
It requires NFSD to know too much about BTRFS internals.

I think I would like btrfs to make it clear where a subvol started,
maybe by setting DCACHE_MOUNTED on the dentry.  This flag is only a
hint, not a promise of anything, so other code should get confused.
This would have nfsd calling vfs_statfs quite so often ....  maybe that
isn't such a big deal.

More importantly, there needs to be some way for NFSD to find an inode
number to report for the MOUNTED_ON_FILEID.  This needs to be a number
not used elsewhere in the filesystem.  It might be safe to use the
same fileid for all subvols (as my patch currently does), but we would
need to confirm that 'find' and 'tar' don't complain about that or
mishandle it.  If it is safe to use the same fileid, then a new field in
the superblock to store it might work.  If a different fileid is needed,
the we might need a new field in 'struct kstatfs', so vfs_statfs can
report it.

Anyway, here is my current patch.  It includes support for NFSv3 as well
as NFSv4.

NeilBrown

diff --git a/fs/nfsd/export.c b/fs/nfsd/export.c
index 9421dae22737..790a3357525d 100644
--- a/fs/nfsd/export.c
+++ b/fs/nfsd/export.c
@@ -15,6 +15,7 @@
 #include <linux/slab.h>
 #include <linux/namei.h>
 #include <linux/module.h>
+#include <linux/statfs.h>
 #include <linux/exportfs.h>
 #include <linux/sunrpc/svc_xprt.h>
=20
@@ -575,6 +576,7 @@ static int svc_export_parse(struct cache_detail *cd, char=
 *mesg, int mlen)
 	int err;
 	struct auth_domain *dom =3D NULL;
 	struct svc_export exp =3D {}, *expp;
+	struct kstatfs statfs;
 	int an_int;
=20
 	if (mesg[mlen-1] !=3D '\n')
@@ -604,6 +606,10 @@ static int svc_export_parse(struct cache_detail *cd, cha=
r *mesg, int mlen)
 	err =3D kern_path(buf, 0, &exp.ex_path);
 	if (err)
 		goto out1;
+	err =3D vfs_statfs(&exp.ex_path, &statfs);
+	if (err)
+		goto out3;
+	exp.ex_fsid64 =3D statfs.f_fsid;
=20
 	exp.ex_client =3D dom;
 	exp.cd =3D cd;
@@ -809,6 +815,7 @@ static void export_update(struct cache_head *cnew, struct=
 cache_head *citem)
 	new->ex_anon_uid =3D item->ex_anon_uid;
 	new->ex_anon_gid =3D item->ex_anon_gid;
 	new->ex_fsid =3D item->ex_fsid;
+	new->ex_fsid64 =3D item->ex_fsid64;
 	new->ex_devid_map =3D item->ex_devid_map;
 	item->ex_devid_map =3D NULL;
 	new->ex_uuid =3D item->ex_uuid;
diff --git a/fs/nfsd/export.h b/fs/nfsd/export.h
index ee0e3aba4a6e..d3eb9a599918 100644
--- a/fs/nfsd/export.h
+++ b/fs/nfsd/export.h
@@ -68,6 +68,7 @@ struct svc_export {
 	kuid_t			ex_anon_uid;
 	kgid_t			ex_anon_gid;
 	int			ex_fsid;
+	__kernel_fsid_t		ex_fsid64;
 	unsigned char *		ex_uuid; /* 16 byte fsid */
 	struct nfsd4_fs_locations ex_fslocs;
 	uint32_t		ex_nflavors;
diff --git a/fs/nfsd/nfs3xdr.c b/fs/nfsd/nfs3xdr.c
index 0a5ebc52e6a9..f11ba3434fd6 100644
--- a/fs/nfsd/nfs3xdr.c
+++ b/fs/nfsd/nfs3xdr.c
@@ -367,10 +367,18 @@ svcxdr_encode_fattr3(struct svc_rqst *rqstp, struct xdr=
_stream *xdr,
 	case FSIDSOURCE_FSID:
 		fsid =3D (u64)fhp->fh_export->ex_fsid;
 		break;
-	case FSIDSOURCE_UUID:
+	case FSIDSOURCE_UUID: {
+		struct kstatfs statfs;
+
 		fsid =3D ((u64 *)fhp->fh_export->ex_uuid)[0];
 		fsid ^=3D ((u64 *)fhp->fh_export->ex_uuid)[1];
+		if (fh_getstafs(fhp, &statfs) =3D=3D 0 &&
+		    (statfs.f_fsid.val[0] !=3D fhp->fh_export->ex_fsid64.val[0] ||
+		     statfs.f_fsid.val[1] !=3D fhp->fh_export->ex_fsid64.val[1]))
+			/* looks like a btrfs subvol */
+			fsid =3D statfs.f_fsid.val[0] ^ statfs.f_fsid.val[1];
 		break;
+		}
 	default:
 		fsid =3D (u64)huge_encode_dev(fhp->fh_dentry->d_sb->s_dev);
 	}
diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
index 7abeccb975b2..5f614d1b362e 100644
--- a/fs/nfsd/nfs4xdr.c
+++ b/fs/nfsd/nfs4xdr.c
@@ -42,6 +42,7 @@
 #include <linux/sunrpc/svcauth_gss.h>
 #include <linux/sunrpc/addr.h>
 #include <linux/xattr.h>
+#include <linux/btrfs_tree.h>
 #include <uapi/linux/xattr.h>
=20
 #include "idmap.h"
@@ -2869,8 +2870,10 @@ nfsd4_encode_fattr(struct xdr_stream *xdr, struct svc_=
fh *fhp,
 	if (err)
 		goto out_nfserr;
 	if ((bmval0 & (FATTR4_WORD0_FILES_AVAIL | FATTR4_WORD0_FILES_FREE |
+		       FATTR4_WORD0_FSID |
 			FATTR4_WORD0_FILES_TOTAL | FATTR4_WORD0_MAXNAME)) ||
 	    (bmval1 & (FATTR4_WORD1_SPACE_AVAIL | FATTR4_WORD1_SPACE_FREE |
+		       FATTR4_WORD1_MOUNTED_ON_FILEID |
 		       FATTR4_WORD1_SPACE_TOTAL))) {
 		err =3D vfs_statfs(&path, &statfs);
 		if (err)
@@ -3024,6 +3027,12 @@ nfsd4_encode_fattr(struct xdr_stream *xdr, struct svc_=
fh *fhp,
 		case FSIDSOURCE_UUID:
 			p =3D xdr_encode_opaque_fixed(p, exp->ex_uuid,
 								EX_UUID_LEN);
+			if (statfs.f_fsid.val[0] !=3D exp->ex_fsid64.val[0] ||
+			    statfs.f_fsid.val[1] !=3D exp->ex_fsid64.val[1]) {
+				/* looks like a btrfs subvol */
+				p[-2] ^=3D statfs.f_fsid.val[0];
+				p[-1] ^=3D statfs.f_fsid.val[1];
+			}
 			break;
 		}
 	}
@@ -3286,6 +3295,12 @@ nfsd4_encode_fattr(struct xdr_stream *xdr, struct svc_=
fh *fhp,
 				goto out_nfserr;
 			ino =3D parent_stat.ino;
 		}
+		if (fsid_source(fhp) =3D=3D FSIDSOURCE_UUID &&
+		    (statfs.f_fsid.val[0] !=3D exp->ex_fsid64.val[0] ||
+		     statfs.f_fsid.val[1] !=3D exp->ex_fsid64.val[1]))
+			    /* btrfs subvol pseudo mount point */
+			    ino =3D BTRFS_FIRST_FREE_OBJECTID-1;
+
 		p =3D xdr_encode_hyper(p, ino);
 	}
 #ifdef CONFIG_NFSD_PNFS
diff --git a/fs/nfsd/vfs.h b/fs/nfsd/vfs.h
index b21b76e6b9a8..82b76b0b7bec 100644
--- a/fs/nfsd/vfs.h
+++ b/fs/nfsd/vfs.h
@@ -160,6 +160,13 @@ static inline __be32 fh_getattr(const struct svc_fh *fh,=
 struct kstat *stat)
 				    AT_STATX_SYNC_AS_STAT));
 }
=20
+static inline __be32 fh_getstafs(const struct svc_fh *fh, struct kstatfs *st=
atfs)
+{
+	struct path p =3D {.mnt =3D fh->fh_export->ex_path.mnt,
+			 .dentry =3D fh->fh_dentry};
+	return nfserrno(vfs_statfs(&p, statfs));
+}
+
 static inline int nfsd_create_is_exclusive(int createmode)
 {
 	return createmode =3D=3D NFS3_CREATE_EXCLUSIVE

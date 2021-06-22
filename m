Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 667733AFA98
	for <lists+linux-nfs@lfdr.de>; Tue, 22 Jun 2021 03:28:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230082AbhFVBay (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 21 Jun 2021 21:30:54 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:36280 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229663AbhFVBay (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 21 Jun 2021 21:30:54 -0400
Received: from imap.suse.de (imap-alt.suse-dmz.suse.de [192.168.254.47])
        (using TLSv1.2 with cipher ECDHE-ECDSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 59EA41FD33;
        Tue, 22 Jun 2021 01:28:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1624325318; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wz+J/uP8RsXnw+1vAX2T4U49+KY+xmVJYwr2cgDWqlU=;
        b=J7YupEmnCckIVCUNj1oYEUamettmhBgqO64pky4DpLw+rFdwgbsH2sNbTv9p4fvoqrD/ey
        lQ+pm6IXt30n1Zpj8BXTLXLTl4PB7ufA8kBzNbaDqZ7rovXdwdbYakMKaAmRYPTxEZpDca
        0oFCXkwbPtpL+h5T97oss/mM9R0PpV4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1624325318;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wz+J/uP8RsXnw+1vAX2T4U49+KY+xmVJYwr2cgDWqlU=;
        b=KxxUudK96y57umJQHsqHwWau/sJDbbnVujMjjQwBZWJYydZjPHbOaEH1lZTWLd0JBD/eU8
        rBbrFNkSaa6NJRCg==
Received: from imap3-int (imap-alt.suse-dmz.suse.de [192.168.254.47])
        by imap.suse.de (Postfix) with ESMTP id 5609D118DD;
        Tue, 22 Jun 2021 01:28:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1624325318; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wz+J/uP8RsXnw+1vAX2T4U49+KY+xmVJYwr2cgDWqlU=;
        b=J7YupEmnCckIVCUNj1oYEUamettmhBgqO64pky4DpLw+rFdwgbsH2sNbTv9p4fvoqrD/ey
        lQ+pm6IXt30n1Zpj8BXTLXLTl4PB7ufA8kBzNbaDqZ7rovXdwdbYakMKaAmRYPTxEZpDca
        0oFCXkwbPtpL+h5T97oss/mM9R0PpV4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1624325318;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wz+J/uP8RsXnw+1vAX2T4U49+KY+xmVJYwr2cgDWqlU=;
        b=KxxUudK96y57umJQHsqHwWau/sJDbbnVujMjjQwBZWJYydZjPHbOaEH1lZTWLd0JBD/eU8
        rBbrFNkSaa6NJRCg==
Received: from director2.suse.de ([192.168.254.72])
        by imap3-int with ESMTPSA
        id BzXWAcU80WD7cgAALh3uQQ
        (envelope-from <neilb@suse.de>); Tue, 22 Jun 2021 01:28:37 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
From:   "NeilBrown" <neilb@suse.de>
To:     "Wang Yugui" <wangyugui@e16-tech.com>
Cc:     linux-nfs@vger.kernel.org
Subject: Re: any idea about auto export multiple btrfs snapshots?
In-reply-to: <20210621163441.428C.409509F4@e16-tech.com>
References: <162425113589.17441.4163890972298681569@noble.neil.brown.name>,
 <162425240757.17441.3695249639927377778@noble.neil.brown.name>,
 <20210621163441.428C.409509F4@e16-tech.com>
Date:   Tue, 22 Jun 2021 11:28:33 +1000
Message-id: <162432531379.17441.15110145423567943074@noble.neil.brown.name>
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Mon, 21 Jun 2021, Wang Yugui wrote:
> Hi,
>=20
> > > > It seems more fixes are needed.
> > >=20
> > > I think the problem is that the submount doesn't appear in /proc/mounts.
> > > "nfsd_fh()" in nfs-utils needs to be able to map from the uuid for a
> > > filesystem to the mount point.  To do this it walks through /proc/mounts
> > > checking the uuid of each filesystem.  If a filesystem isn't listed
> > > there, it obviously fails.
> > >=20
> > > I guess you could add code to nfs-utils to do whatever "btrfs subvol
> > > list" does to make up for the fact that btrfs doesn't register in
> > > /proc/mounts.
> >=20
> > Another approach might be to just change svcxdr_encode_fattr3() and
> > nfsd4_encode_fattr() in the 'FSIDSOJURCE_UUID' case to check if
> > dentry->d_inode has a different btrfs volume id to
> > exp->ex_path.dentry->d_inode.
> > If it does, then mix the volume id into the fsid somehow.
> >=20
> > With that, you wouldn't want the first change I suggested.
>=20
> This is what I have done. and it is based on linux 5.10.44
>=20
> but it still not work, so still more jobs needed.
>=20

The following is more what I had in mind.  It doesn't quite work and I
cannot work out why.

If you 'stat' a file inside the subvol, then 'find' will not complete.
If you don't, then it will.

Doing that 'stat' changes the st_dev number of the main filesystem,
which seems really weird.
I'm probably missing something obvious.  Maybe a more careful analysis
of what is changing when will help.

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
diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
index 7abeccb975b2..8144e6037eae 100644
--- a/fs/nfsd/nfs4xdr.c
+++ b/fs/nfsd/nfs4xdr.c
@@ -2869,6 +2869,7 @@ nfsd4_encode_fattr(struct xdr_stream *xdr, struct svc_f=
h *fhp,
 	if (err)
 		goto out_nfserr;
 	if ((bmval0 & (FATTR4_WORD0_FILES_AVAIL | FATTR4_WORD0_FILES_FREE |
+		       FATTR4_WORD0_FSID |
 			FATTR4_WORD0_FILES_TOTAL | FATTR4_WORD0_MAXNAME)) ||
 	    (bmval1 & (FATTR4_WORD1_SPACE_AVAIL | FATTR4_WORD1_SPACE_FREE |
 		       FATTR4_WORD1_SPACE_TOTAL))) {
@@ -3024,6 +3025,12 @@ nfsd4_encode_fattr(struct xdr_stream *xdr, struct svc_=
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


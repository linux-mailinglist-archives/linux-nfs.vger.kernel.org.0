Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D6F1C2B3C36
	for <lists+linux-nfs@lfdr.de>; Mon, 16 Nov 2020 05:43:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726163AbgKPEni (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sun, 15 Nov 2020 23:43:38 -0500
Received: from mx2.suse.de ([195.135.220.15]:47632 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726016AbgKPEnh (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Sun, 15 Nov 2020 23:43:37 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id EF3B0ABDE;
        Mon, 16 Nov 2020 04:43:35 +0000 (UTC)
From:   NeilBrown <neilb@suse.de>
To:     Trond Myklebust <trondmy@hammerspace.com>,
        "anna.schumaker@netapp.com" <anna.schumaker@netapp.com>
Date:   Mon, 16 Nov 2020 15:43:30 +1100
Cc:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] NFS: only invalidate dentrys that are clearly invalid.
In-Reply-To: <d2fabd4b78dda3bd52519b84f50785dbcc2d40fb.camel@hammerspace.com>
References: <87361aovm3.fsf@notabene.neil.brown.name>
 <d2fabd4b78dda3bd52519b84f50785dbcc2d40fb.camel@hammerspace.com>
Message-ID: <87zh3hoqrx.fsf@notabene.neil.brown.name>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha256; protocol="application/pgp-signature"
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

--=-=-=
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 16 2020, Trond Myklebust wrote:

> On Mon, 2020-11-16 at 13:59 +1100, NeilBrown wrote:
>>=20
>> Prior to commit 5ceb9d7fdaaf ("NFS: Refactor
>> nfs_lookup_revalidate()")
>> and error from nfs_lookup_verify_inode() other than -ESTALE would
>> result
>> in nfs_lookup_revalidate() returning that error code (-ESTALE is
>> mapped
>> to zero).
>> Since that commit, all errors result in zero being returned.
>>=20
>> When nfs_lookup_revalidate() returns zero, the dentry is invalidated
>> and, significantly, if the dentry is a directory that is mounted on,
>> that mountpoint is lost.
>>=20
>> If you:
>> =C2=A0- mount an NFS filesystem which contains a directory
>> =C2=A0- mount something (e.g. tmpfs) on that directory
>> =C2=A0- use iptables (or scissors) to block traffic to the server
>> =C2=A0- ls -l the-mounted-on-directory
>> =C2=A0- interrupt the 'ls -l'
>> you will find that the directory has been unmounted.
>>=20
>> This can be fixed by returning the actual error code from
>> nfs_lookup_verify_inode() rather then zero (except for -ESTALE).
>>=20
>> Fixes: 5ceb9d7fdaaf ("NFS: Refactor nfs_lookup_revalidate()")
>> Signed-off-by: NeilBrown <neilb@suse.de>
>> ---
>> =C2=A0fs/nfs/dir.c | 8 +++++---
>> =C2=A01 file changed, 5 insertions(+), 3 deletions(-)
>>=20
>> diff --git a/fs/nfs/dir.c b/fs/nfs/dir.c
>> index cb52db9a0cfb..d24acf556e9e 100644
>> --- a/fs/nfs/dir.c
>> +++ b/fs/nfs/dir.c
>> @@ -1350,7 +1350,7 @@ nfs_do_lookup_revalidate(struct inode *dir,
>> struct dentry *dentry,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 un=
signed int flags)
>> =C2=A0{
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0struct inode *inode;
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0int error;
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0int error =3D 0;
>> =C2=A0
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0nfs_inc_stats(dir, NFSIO=
S_DENTRYREVALIDATE);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0inode =3D d_inode(dentry=
);
>> @@ -1372,8 +1372,10 @@ nfs_do_lookup_revalidate(struct inode *dir,
>> struct dentry *dentry,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 nfs_c=
heck_verifier(dir, dentry, flags & LOOKUP_RCU)) {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0error =3D nfs_lookup_verify_inode(inode, flags);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0if (error) {
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (er=
ror =3D=3D -ESTALE)
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (er=
ror =3D=3D -ESTALE) {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0nfs_zap_caches(dir);
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0error =3D 0;
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0}
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0got=
o out_bad;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0}
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0nfs_advise_use_readdirplus(dir);
>> @@ -1395,7 +1397,7 @@ nfs_do_lookup_revalidate(struct inode *dir,
>> struct dentry *dentry,
>> =C2=A0out_bad:
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (flags & LOOKUP_RCU)
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0return -ECHILD;
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0return nfs_lookup_revalidate_=
done(dir, dentry, inode, 0);
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0return nfs_lookup_revalidate_=
done(dir, dentry, inode, error);
>
> Which errors do we actually need to return here? As far as I can tell,
> the only errors that nfs_lookup_verify_inode() is supposed to return is
> ENOMEM, ESTALE, ECHILD, and possibly EIO or ETiMEDOUT.
>
> Why would it be better to return those errors rather than just a 0 when
> we need to invalidate the inode, particularly since we already have a
> special case in nfs_lookup_revalidate_done() when the dentry is root?

ERESTARTSYS is the error that easily causes problems.

Returning 0 causes d_invalidate() to be called which is quite heavy
handed in mountpoints.
So it is only reasonable to return 0 when we have unambiguous
confirmation from the server that the object no longer exists.  ESTALE
is unambiguous. EIO might be unambiguous.  ERESTARTSYS, ENOMEM,
ETIMEDOUT are transient and don't justify d_invalidate() being called.

(BTW, Commit cc89684c9a26 ("NFS: only invalidate dentrys that are clearly i=
nvalid.")
 fixed much the same bug 3 years ago).
=20
Thanks,
NeilBrown


>
>> =C2=A0}
>> =C2=A0
>> =C2=A0static int
>
> --=20
> Trond Myklebust
> Linux NFS client maintainer, Hammerspace
> trond.myklebust@hammerspace.com

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQJCBAEBCAAsFiEEG8Yp69OQ2HB7X0l6Oeye3VZigbkFAl+yA3IOHG5laWxiQHN1
c2UuZGUACgkQOeye3VZigbm1+BAAkCWhqH1cS4EDBSKyqYlP8yn9TrBlfmTrEq4A
u/gOxvp9N3AlEvnTbw4pCy5Gac/xhsTRJjH5jxt25jF3oNGXd3478SWyGNc9SbrZ
S00Gx6beyRfjEl58wOGsCsSH2klpNHyucY7YIExlSTFvtNGc+KpD0dH79Tw6kh8q
dij0i0Aycf/QiOBlLmXOwsY9OjgbzlFNzzXQw+nTxPoc5DGrePHVqW5bXR3bUIUX
1NesoEFe/Ikz2RIfGZkDP+Kvt/1MECIosuVRBzYL5sS7lxHjkgS4X1OUzMTk5wxr
F3d381OF7GVYh/6igd9Wek7qH2fTHjGVus7T1O6peE/ajPt32i0wXYuTRN/6/p6c
gUnQh6HXaqs0Nlsj/urykHVULgUTTHFvfoeo1X45IrmF2vlHfJ7LQtZNJvv1ppDj
iyQ0gY3e7EOlxcMXtrw5+yMC+pmAq3LT7N2qrW4mS3kg9pFdVJ6R01VzHmuOCky3
NZZ6UoyXUpMC818kOB0LGqOKV6hUf3kfSeoT1JxyS6xuswGhKTtRtjsmIs8wD50L
lE38NF7PoCI7dNau3I70xZnvuAhG/UXjlntlKz1GqvoqzDLs+DeS6nDvKky5OY3l
Xh5Kg3KzYcFWXYt42c9xjHQtFz6jl3SFt+gn8O5Jh1f6kvUOKt3mqm8DpZBtPxgK
tHJs/XI=
=+eWE
-----END PGP SIGNATURE-----
--=-=-=--

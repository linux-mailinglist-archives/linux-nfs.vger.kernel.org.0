Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 86BEC2B3C4C
	for <lists+linux-nfs@lfdr.de>; Mon, 16 Nov 2020 06:01:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725379AbgKPFBE (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 16 Nov 2020 00:01:04 -0500
Received: from mx2.suse.de ([195.135.220.15]:50728 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725300AbgKPFBE (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Mon, 16 Nov 2020 00:01:04 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 68ADCABDE;
        Mon, 16 Nov 2020 05:01:01 +0000 (UTC)
From:   NeilBrown <neilb@suse.de>
To:     Trond Myklebust <trondmy@hammerspace.com>,
        "anna.schumaker@netapp.com" <anna.schumaker@netapp.com>
Date:   Mon, 16 Nov 2020 16:00:56 +1100
Cc:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] NFS: only invalidate dentrys that are clearly invalid.
In-Reply-To: <d208c9c085d8abf27a764e31a61e98f9c3743675.camel@hammerspace.com>
References: <87361aovm3.fsf@notabene.neil.brown.name>
 <d2fabd4b78dda3bd52519b84f50785dbcc2d40fb.camel@hammerspace.com>
 <87zh3hoqrx.fsf@notabene.neil.brown.name>
 <d208c9c085d8abf27a764e31a61e98f9c3743675.camel@hammerspace.com>
Message-ID: <87wnylopyv.fsf@notabene.neil.brown.name>
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

> On Mon, 2020-11-16 at 15:43 +1100, NeilBrown wrote:
>> On Mon, Nov 16 2020, Trond Myklebust wrote:
>>=20
>> > On Mon, 2020-11-16 at 13:59 +1100, NeilBrown wrote:
>> > >=20
>> > > Prior to commit 5ceb9d7fdaaf ("NFS: Refactor
>> > > nfs_lookup_revalidate()")
>> > > and error from nfs_lookup_verify_inode() other than -ESTALE would
>> > > result
>> > > in nfs_lookup_revalidate() returning that error code (-ESTALE is
>> > > mapped
>> > > to zero).
>> > > Since that commit, all errors result in zero being returned.
>> > >=20
>> > > When nfs_lookup_revalidate() returns zero, the dentry is
>> > > invalidated
>> > > and, significantly, if the dentry is a directory that is mounted
>> > > on,
>> > > that mountpoint is lost.
>> > >=20
>> > > If you:
>> > > =C2=A0- mount an NFS filesystem which contains a directory
>> > > =C2=A0- mount something (e.g. tmpfs) on that directory
>> > > =C2=A0- use iptables (or scissors) to block traffic to the server
>> > > =C2=A0- ls -l the-mounted-on-directory
>> > > =C2=A0- interrupt the 'ls -l'
>> > > you will find that the directory has been unmounted.
>> > >=20
>> > > This can be fixed by returning the actual error code from
>> > > nfs_lookup_verify_inode() rather then zero (except for -ESTALE).
>> > >=20
>> > > Fixes: 5ceb9d7fdaaf ("NFS: Refactor nfs_lookup_revalidate()")
>> > > Signed-off-by: NeilBrown <neilb@suse.de>
>> > > ---
>> > > =C2=A0fs/nfs/dir.c | 8 +++++---
>> > > =C2=A01 file changed, 5 insertions(+), 3 deletions(-)
>> > >=20
>> > > diff --git a/fs/nfs/dir.c b/fs/nfs/dir.c
>> > > index cb52db9a0cfb..d24acf556e9e 100644
>> > > --- a/fs/nfs/dir.c
>> > > +++ b/fs/nfs/dir.c
>> > > @@ -1350,7 +1350,7 @@ nfs_do_lookup_revalidate(struct inode *dir,
>> > > struct dentry *dentry,
>> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 unsigned int flags)
>> > > =C2=A0{
>> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0struct inode *inode;
>> > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0int error;
>> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0int error =3D 0;
>> > > =C2=A0
>> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0nfs_inc_stats(dir, N=
FSIOS_DENTRYREVALIDATE);
>> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0inode =3D d_inode(de=
ntry);
>> > > @@ -1372,8 +1372,10 @@ nfs_do_lookup_revalidate(struct inode
>> > > *dir,
>> > > struct dentry *dentry,
>> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 n=
fs_check_verifier(dir, dentry, flags & LOOKUP_RCU))
>> > > {
>> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0error =3D nfs_lookup_verify_inode(inode, flag=
s);
>> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (error) {
>> > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if =
(error =3D=3D -ESTALE)
>> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if =
(error =3D=3D -ESTALE) {
>> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0nfs_zap_caches(dir);
>> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0error =3D 0;
>> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0}
>> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0goto out_bad;
>> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0}
>> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0nfs_advise_use_readdirplus(dir);
>> > > @@ -1395,7 +1397,7 @@ nfs_do_lookup_revalidate(struct inode *dir,
>> > > struct dentry *dentry,
>> > > =C2=A0out_bad:
>> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (flags & LOOKUP_R=
CU)
>> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0return -ECHILD;
>> > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0return nfs_lookup_revalid=
ate_done(dir, dentry, inode, 0);
>> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0return nfs_lookup_revalid=
ate_done(dir, dentry, inode,
>> > > error);
>> >=20
>> > Which errors do we actually need to return here? As far as I can
>> > tell,
>> > the only errors that nfs_lookup_verify_inode() is supposed to
>> > return is
>> > ENOMEM, ESTALE, ECHILD, and possibly EIO or ETiMEDOUT.
>> >=20
>> > Why would it be better to return those errors rather than just a 0
>> > when
>> > we need to invalidate the inode, particularly since we already have
>> > a
>> > special case in nfs_lookup_revalidate_done() when the dentry is
>> > root?
>>=20
>> ERESTARTSYS is the error that easily causes problems.
>>=20
>> Returning 0 causes d_invalidate() to be called which is quite heavy
>> handed in mountpoints.
>
> My point is that it shouldn't get returned for mountpoints. See
> nfs_lookup_revalidate_done().

nfs_lookup_revalidate_done() only checks IS_ROOT(), and while many
mountpoints are IS_ROOT(), not all are (--bind easily makes others).

But that isn't even really relevant here.  The dentry being revalidated
is the underlying directory - that something else is mounted on.
step_into() which follows mount points is called in walk_component()
*after* lookup_fast or lookup_slow which will have revalidated the
dentry.

NeilBrown


>
>> So it is only reasonable to return 0 when we have unambiguous
>> confirmation from the server that the object no longer exists.=C2=A0
>> ESTALE
>> is unambiguous. EIO might be unambiguous.=C2=A0 ERESTARTSYS, ENOMEM,
>> ETIMEDOUT are transient and don't justify d_invalidate() being
>> called.
>>=20
>> (BTW, Commit cc89684c9a26 ("NFS: only invalidate dentrys that are
>> clearly invalid.")
>> =C2=A0fixed much the same bug 3 years ago).
>> =C2=A0
>> Thanks,
>> NeilBrown
>>=20
>>=20
>> >=20
>> > > =C2=A0}
>> > > =C2=A0
>> > > =C2=A0static int
>> >=20
>> > --=20
>> > Trond Myklebust
>> > Linux NFS client maintainer, Hammerspace
>> > trond.myklebust@hammerspace.com
>
> --=20
> Trond Myklebust
> CTO, Hammerspace Inc
> 4984 El Camino Real, Suite 208
> Los Altos, CA 94022
> =E2=80=8B
> www.hammer.space

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQJCBAEBCAAsFiEEG8Yp69OQ2HB7X0l6Oeye3VZigbkFAl+yB4gOHG5laWxiQHN1
c2UuZGUACgkQOeye3VZigbnK/RAAkuiAcVLvKi1Ezt0gPnhEz1OxkVARMvT6IyMz
N9DZRfSg2vRVqswYp4yDvWy+2PpY1o2wQM+kDtWxw2wfwjMcnaERYQx2Lc5l6K/T
OWUSWyja/uoSxAlffMB9KAUApj1xTlakhgPrg+DSMIHUB5SEyCUa8m4agNkGz6OG
4O0+wgsUXdNwFO8k+ZZhT3iRjYV1mFT+pmL6fQU5dLvvA8ZBQRlw/h6XXg3nd3tM
wKIH+g7VpsSfIcGfil4jxWy71cYR1d8xFncKgPuDaV/eWf+ELiBsMoI/GT/vqJHl
8EQemkONLBk7+BK/Em2zf8JQgkjWFCe6W3F3ZmXBDMt86sQ8IYM3e2kaq6aDuRVH
z7Oa91X2eF0krYvI7xAZWzjHShhnGwTWHpIXp8ZgOuP5GUjpZart0Z/FhxwYbtuG
QPVnYCVk6/BcQ9MLaesYcG+OUKHwIzUhM1I63yELSijsOJGBkE1pdxZxcOk2Rcw8
FhW31Cy/q79TLY0/dpVRiDhPTBcpGwhocz/x/wtgk86igQvQEKpxqkQK/84EbcAs
3hKZvHmFqUvW8VWrAexJEVTNE3P/t8oyRF1wNJvq0lnOQQwkxc0pixayQ3jGnZCO
8p/Oeb7JTLEPZoodmHeAa7/P0V5z1MrDUo/qnsz7jfbq/KHIv2wYfItL9UpemZeW
zJD+qxo=
=UPNe
-----END PGP SIGNATURE-----
--=-=-=--

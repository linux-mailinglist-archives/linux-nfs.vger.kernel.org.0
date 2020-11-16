Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7003F2B3CCF
	for <lists+linux-nfs@lfdr.de>; Mon, 16 Nov 2020 07:10:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726741AbgKPGI5 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 16 Nov 2020 01:08:57 -0500
Received: from mx2.suse.de ([195.135.220.15]:59164 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725379AbgKPGI5 (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Mon, 16 Nov 2020 01:08:57 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id F01E6AC48;
        Mon, 16 Nov 2020 06:08:54 +0000 (UTC)
From:   NeilBrown <neilb@suse.de>
To:     Trond Myklebust <trondmy@hammerspace.com>,
        "anna.schumaker@netapp.com" <anna.schumaker@netapp.com>
Date:   Mon, 16 Nov 2020 17:08:47 +1100
Cc:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] NFS: only invalidate dentrys that are clearly invalid.
In-Reply-To: <0673647d9d70f31a02c74da713e5343ac3918835.camel@hammerspace.com>
References: <87361aovm3.fsf@notabene.neil.brown.name>
 <d2fabd4b78dda3bd52519b84f50785dbcc2d40fb.camel@hammerspace.com>
 <87zh3hoqrx.fsf@notabene.neil.brown.name>
 <d208c9c085d8abf27a764e31a61e98f9c3743675.camel@hammerspace.com>
 <87wnylopyv.fsf@notabene.neil.brown.name>
 <b28216153179dd20c22aa164259d3f901099896c.camel@hammerspace.com>
 <87tutpopfj.fsf@notabene.neil.brown.name>
 <0673647d9d70f31a02c74da713e5343ac3918835.camel@hammerspace.com>
Message-ID: <87r1otomts.fsf@notabene.neil.brown.name>
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

> On Mon, 2020-11-16 at 16:12 +1100, NeilBrown wrote:
>> On Mon, Nov 16 2020, Trond Myklebust wrote:
>>=20
>> > On Mon, 2020-11-16 at 16:00 +1100, NeilBrown wrote:
>> > > On Mon, Nov 16 2020, Trond Myklebust wrote:
>> > >=20
>> > > > On Mon, 2020-11-16 at 15:43 +1100, NeilBrown wrote:
>> > > > > On Mon, Nov 16 2020, Trond Myklebust wrote:
>> > > > >=20
>> > > > > > On Mon, 2020-11-16 at 13:59 +1100, NeilBrown wrote:
>> > > > > > >=20
>> > > > > > > Prior to commit 5ceb9d7fdaaf ("NFS: Refactor
>> > > > > > > nfs_lookup_revalidate()")
>> > > > > > > and error from nfs_lookup_verify_inode() other than -
>> > > > > > > ESTALE
>> > > > > > > would
>> > > > > > > result
>> > > > > > > in nfs_lookup_revalidate() returning that error code (-
>> > > > > > > ESTALE
>> > > > > > > is
>> > > > > > > mapped
>> > > > > > > to zero).
>> > > > > > > Since that commit, all errors result in zero being
>> > > > > > > returned.
>> > > > > > >=20
>> > > > > > > When nfs_lookup_revalidate() returns zero, the dentry is
>> > > > > > > invalidated
>> > > > > > > and, significantly, if the dentry is a directory that is
>> > > > > > > mounted
>> > > > > > > on,
>> > > > > > > that mountpoint is lost.
>> > > > > > >=20
>> > > > > > > If you:
>> > > > > > > =C2=A0- mount an NFS filesystem which contains a directory
>> > > > > > > =C2=A0- mount something (e.g. tmpfs) on that directory
>> > > > > > > =C2=A0- use iptables (or scissors) to block traffic to the
>> > > > > > > server
>> > > > > > > =C2=A0- ls -l the-mounted-on-directory
>> > > > > > > =C2=A0- interrupt the 'ls -l'
>> > > > > > > you will find that the directory has been unmounted.
>> > > > > > >=20
>> > > > > > > This can be fixed by returning the actual error code from
>> > > > > > > nfs_lookup_verify_inode() rather then zero (except for -
>> > > > > > > ESTALE).
>> > > > > > >=20
>> > > > > > > Fixes: 5ceb9d7fdaaf ("NFS: Refactor
>> > > > > > > nfs_lookup_revalidate()")
>> > > > > > > Signed-off-by: NeilBrown <neilb@suse.de>
>> > > > > > > ---
>> > > > > > > =C2=A0fs/nfs/dir.c | 8 +++++---
>> > > > > > > =C2=A01 file changed, 5 insertions(+), 3 deletions(-)
>> > > > > > >=20
>> > > > > > > diff --git a/fs/nfs/dir.c b/fs/nfs/dir.c
>> > > > > > > index cb52db9a0cfb..d24acf556e9e 100644
>> > > > > > > --- a/fs/nfs/dir.c
>> > > > > > > +++ b/fs/nfs/dir.c
>> > > > > > > @@ -1350,7 +1350,7 @@ nfs_do_lookup_revalidate(struct
>> > > > > > > inode
>> > > > > > > *dir,
>> > > > > > > struct dentry *dentry,
>> > > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 unsigned int flags)
>> > > > > > > =C2=A0{
>> > > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0struct inode=
 *inode;
>> > > > > > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0int error;
>> > > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0int error =3D 0;
>> > > > > > > =C2=A0
>> > > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0nfs_inc_stat=
s(dir, NFSIOS_DENTRYREVALIDATE);
>> > > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0inode =3D d_=
inode(dentry);
>> > > > > > > @@ -1372,8 +1372,10 @@ nfs_do_lookup_revalidate(struct
>> > > > > > > inode
>> > > > > > > *dir,
>> > > > > > > struct dentry *dentry,
>> > > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 nfs_check_verifier(dir, dentry, flags &
>> > > > > > > LOOKUP_RCU))
>> > > > > > > {
>> > > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0error =3D nfs_lookup_verify_inode(inode,
>> > > > > > > flags);
>> > > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (error) {
>> > > > > > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0if (error =3D=3D -ESTALE)
>> > > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0if (error =3D=3D -ESTALE) {
>> > > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0nfs_zap_caches(dir=
);
>> > > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0error =3D 0;
>> > > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0}
>> > > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0goto out_bad;
>> > > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0}
>> > > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0nfs_advise_use_readdirplus(dir);
>> > > > > > > @@ -1395,7 +1397,7 @@ nfs_do_lookup_revalidate(struct
>> > > > > > > inode
>> > > > > > > *dir,
>> > > > > > > struct dentry *dentry,
>> > > > > > > =C2=A0out_bad:
>> > > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (flags & =
LOOKUP_RCU)
>> > > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0return -ECHILD;
>> > > > > > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0return nfs_lookup=
_revalidate_done(dir, dentry,
>> > > > > > > inode,
>> > > > > > > 0);
>> > > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0return nfs_lookup=
_revalidate_done(dir, dentry,
>> > > > > > > inode,
>> > > > > > > error);
>> > > > > >=20
>> > > > > > Which errors do we actually need to return here? As far as
>> > > > > > I
>> > > > > > can
>> > > > > > tell,
>> > > > > > the only errors that nfs_lookup_verify_inode() is supposed
>> > > > > > to
>> > > > > > return is
>> > > > > > ENOMEM, ESTALE, ECHILD, and possibly EIO or ETiMEDOUT.
>> > > > > >=20
>> > > > > > Why would it be better to return those errors rather than
>> > > > > > just
>> > > > > > a 0
>> > > > > > when
>> > > > > > we need to invalidate the inode, particularly since we
>> > > > > > already
>> > > > > > have
>> > > > > > a
>> > > > > > special case in nfs_lookup_revalidate_done() when the
>> > > > > > dentry is
>> > > > > > root?
>> > > > >=20
>> > > > > ERESTARTSYS is the error that easily causes problems.
>> > > > >=20
>> > > > > Returning 0 causes d_invalidate() to be called which is quite
>> > > > > heavy
>> > > > > handed in mountpoints.
>> > > >=20
>> > > > My point is that it shouldn't get returned for mountpoints. See
>> > > > nfs_lookup_revalidate_done().
>> > >=20
>> > > nfs_lookup_revalidate_done() only checks IS_ROOT(), and while
>> > > many
>> > > mountpoints are IS_ROOT(), not all are (--bind easily makes
>> > > others).
>> > >=20
>> > > But that isn't even really relevant here.=C2=A0 The dentry being
>> > > revalidated
>> > > is the underlying directory - that something else is mounted on.
>> > > step_into() which follows mount points is called in
>> > > walk_component()
>> > > *after* lookup_fast or lookup_slow which will have revalidated
>> > > the
>> > > dentry.
>> >=20
>> > So then why is it not sufficient to just add a check for
>> > d_mountpoint()? This is a revalidation, not a new lookup.
>> >=20
>>=20
>> I guess you could do that.
>> But why would you want to call d_invalidate() just because a signal
>> was
>> received, or a memory allocation failed?
>
> Why would I care about the error return from nfs_lookup_verify_inode()?

?? Why wouldn't you?  What am I missing?

> This is a revalidation, and so sometimes the error returned is not
> transient, but is persistent (e.g. EIO/ETIMEDOUT if the server is
> down). In those cases, I still want to be able to do things like
> unmount the filesystem.

Why do you think that a server being down is a persistent error?
Servers come back up.

I don't have a particular opinion on how EIO and ETIMEDOUT should be
handled as I don't have a clear idea of what underlying issue produces
them.

I do know that ESTALE means the directory doesn't exist any more, so the
dentry should be invalidated, whether it is mounted on or not.
I do know that ERESTARTSYS means that a fatal signal was received by the
current process, so it is inappropriate to invalidate the dentry.

So I'm certain that we need to be able to handle different error codes
differently.  Maybe EIO should be treated the same as ESTALE.  Probably
ENOMEM should be handled like ERESTARTSYS....

NeilBrown


>
>>=20
>> NeilBrown
>>=20
>>=20
>> > >=20
>> > > NeilBrown
>> > >=20
>> > >=20
>> > > >=20
>> > > > > So it is only reasonable to return 0 when we have unambiguous
>> > > > > confirmation from the server that the object no longer
>> > > > > exists.=C2=A0
>> > > > > ESTALE
>> > > > > is unambiguous. EIO might be unambiguous.=C2=A0 ERESTARTSYS,
>> > > > > ENOMEM,
>> > > > > ETIMEDOUT are transient and don't justify d_invalidate()
>> > > > > being
>> > > > > called.
>> > > > >=20
>> > > > > (BTW, Commit cc89684c9a26 ("NFS: only invalidate dentrys that
>> > > > > are
>> > > > > clearly invalid.")
>> > > > > =C2=A0fixed much the same bug 3 years ago).
>> > > > > =C2=A0
>> > > > > Thanks,
>> > > > > NeilBrown
>> > > > >=20
>> > > > >=20
>> > > > > >=20
>> > > > > > > =C2=A0}
>> > > > > > > =C2=A0
>> > > > > > > =C2=A0static int
>> > > > > >=20
>> > > > > > --=20
>> > > > > > Trond Myklebust
>> > > > > > Linux NFS client maintainer, Hammerspace
>> > > > > > trond.myklebust@hammerspace.com
>> > > >=20
>> > > > --=20
>> > > > Trond Myklebust
>> > > > CTO, Hammerspace Inc
>> > > > 4984 El Camino Real, Suite 208
>> > > > Los Altos, CA 94022
>> > > > =E2=80=8B
>> > > > www.hammer.space
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

iQJCBAEBCAAsFiEEG8Yp69OQ2HB7X0l6Oeye3VZigbkFAl+yF3EOHG5laWxiQHN1
c2UuZGUACgkQOeye3VZigblmDw/8DfeLcvLewWy/L+fVd9xH0vt5krjZR4W+tCNl
Qkja3aMIZO8k80RW7m4l2YnEDaLkZM5Gs7COq8e+WkAaKcJNWxMpiRUI6zdDXhe+
V0acxUQ5cvUhvGkq2yzllAkE4E1OolrOQFfnsLqaNCd28dbQp9PeylUOkE6dncRe
OMZVOcKZIfQuavyf2J9EWq4pQC//gwumaWzBl4pM89n6v9//ui+tOsUh4JdLlEyc
ZiOeecffgJkx7k8sONneGufechh6B4fMP0hk7MNXaBWXHGK1sSOTUZvscM13yXxi
nV6++8n/s93Vv84Mm82zu2a0QOa2LTMp2ZXtyiElODG62lgn/TGbkfCeeseaHgHp
GM4kxxvM/ZFxs9pxxQ+ypD46aVTUl2XyuX61hLA5pEwfGW9PNpVuzzCaW2Aqk6gV
L/+6EM09PLpb7ASSpV/ylDQmjlV6il08d2VdvyrLqwzvycNs7M5IL2xI99gqFX0T
ygKMTNuUS46eN5FunIMQ94ruXNywZhhGI9pc3Yxpl+W8Ko7aX0bjjceXj7KUvqdZ
M3++Fr2ppZ/OQYrCA0wq2qNc2MUUWMFgZQulVgupBtaxWUiArZnVG0YArFJ2TK1K
y2f7MxQHEzodrjnBjFOT5WU3Y2UcoNrGJUJf7t2Z0KcQFqDhOM+QsJJ1aPh+DUVG
1Ty6TE4=
=36zm
-----END PGP SIGNATURE-----
--=-=-=--

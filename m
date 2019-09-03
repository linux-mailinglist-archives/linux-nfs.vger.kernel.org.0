Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 47A6AA7652
	for <lists+linux-nfs@lfdr.de>; Tue,  3 Sep 2019 23:37:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726177AbfICVhe (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 3 Sep 2019 17:37:34 -0400
Received: from dresden.studentenwerk.mhn.de ([141.84.225.229]:34850 "EHLO
        email.studentenwerk.mhn.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725882AbfICVhe (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 3 Sep 2019 17:37:34 -0400
Received: from mailhub.studentenwerk.mhn.de (mailhub.studentenwerk.mhn.de [127.0.0.1])
        by email.studentenwerk.mhn.de (Postfix) with ESMTP id 46NKzt6zfJzRhSl;
        Tue,  3 Sep 2019 23:37:30 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stwm.de;
        s=stwm-20170627; t=1567546650;
        bh=x71KSc2S5IaHepI+fQ1jtlydMrj7kQCHxn9jAXkAW6w=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=k0breuMkUhAE0GGU0llN2c7HZwP//0ZLfgHw5SUfs1d4ZCj9Yxdnbxno2eO2kEOZU
         eh1K6Vu2UZVUBbUW1HWx+Bv9GdnZ5q143Sawq0I+85ovGQC8W60Z+qIT0Jitg6xbvV
         4rPyA36f3pWq68s3mzYXklOIxBrq3qbXK7NfEbyXuQLMTVP9BrxA96MpBUhkW+EmZ5
         8y+l3xxc+FV2CsD+hQeeoEIrz4teMyGTjZ28+tEq9FSIfRSMaLYBsBC6VSPuZwZ8lN
         gDqQbrUXX8f/QJLzEwQ5WWSc3bAokfnTtIPAOoewfA1g8ZRBXPtqO8Btln7Z7TZOoG
         qcKymjAbvBv3Q==
From:   Wolfgang Walter <linux@stwm.de>
To:     Jason L Tibbitts III <tibbs@math.uh.edu>
Cc:     "J. Bruce Fields" <bfields@fieldses.org>,
        linux-nfs@vger.kernel.org, km@cm4all.com,
        linux-kernel@vger.kernel.org
Subject: Re: Regression in 5.1.20: Reading long directory fails
Date:   Tue, 03 Sep 2019 23:37:30 +0200
Message-ID: <4198657.JbNDGbLXiX@h2o.as.studentenwerk.mhn.de>
User-Agent: KMail/4.14.3 (Linux/5.0.6-050006-generic; KDE/4.14.13; x86_64; ; )
In-Reply-To: <ufapnkhqjwm.fsf@epithumia.math.uh.edu>
References: <ufak1bhyuew.fsf@epithumia.math.uh.edu> <4418877.15LTP4gqqJ@stwm.de> <ufapnkhqjwm.fsf@epithumia.math.uh.edu>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Am Dienstag, 3. September 2019, 14:06:33 schrieb Jason L Tibbitts III:
> >>>>> "WW" =3D=3D Wolfgang Walter <linux@stwm.de> writes:
> WW> What filesystem do you use on the server? xfs?
>=20
> Yeah, it's XFS.
>=20
> WW> If yes, does it use 64bit inodes (or started to use them)?
>=20
> These filesystems aren't super old, and were all created with the
> default RHEL7 options.  I'm not sure how to check that 64 bit inodes =
are
> being used, though.  xfs_info says:
>=20
> meta-data=3D/dev/mapper/nas-faculty--08 isize=3D256    agcount=3D4, a=
gsize=3D3276800
> blks =3D                       sectsz=3D512   attr=3D2, projid32bit=3D=
1 =3D         =20
>             crc=3D0        finobt=3D0 spinodes=3D0
> data     =3D                       bsize=3D4096   blocks=3D13107200, =
imaxpct=3D25
>          =3D                       sunit=3D0      swidth=3D0 blks
> naming   =3Dversion 2              bsize=3D4096   ascii-ci=3D0 ftype=3D=
0
> log      =3Dinternal               bsize=3D4096   blocks=3D6400, vers=
ion=3D2
>          =3D                       sectsz=3D512   sunit=3D0 blks, laz=
y-count=3D1
> realtime =3Dnone                   extsz=3D4096   blocks=3D0, rtexten=
ts=3D0
>=20
> WW> Do you set a fsid when you export the filesystem?
>=20
> I have never done so on any server.
>=20
> And note that the servers are basically unchanged for quite some time=
,
> while the problem I'm having is new.  I want to find some server-rela=
ted
> cause for this but so far I haven't been able to do so.  It seems my
> best option now seems to be to migrate all data off of this server an=
d
> then wipe, reinstall and see if the problem reoccurs.
>=20
>  - J<

I'm not familiar with RHEL7. But kernel 5.1.20 uses the inode64 mount o=
ption=20
by default, as far as I know (see Documentation/filesystems/xfs.txt). S=
o if=20
you do not use the mount option inode32 your xfs may now uses inode64 f=
or=20
newly created files?

We had similar problems some time ago. Then, inode64 was indeed the cau=
se of=20
the problem. With inode64 it seems that only little room is left in the=
 nfs4=20
handle for the fsid. When nfs mangles fsid and the xfs inode number to =
form a=20
nfs4 handle it seems that in large directories different files may end =
having=20
the same handle if there inodes do not fit in 32bit.

You may try setting a rather small fsid (say 500) and reexport the fs a=
nd then=20
see, if the problem disappears. I think our problems dissappered then, =
but I=20
do not remember exactly. We now use inode32 to avoid the problem.


Regards,
--=20
Wolfgang Walter
Studentenwerk M=FCnchen
Anstalt des =F6ffentlichen Rechts

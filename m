Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 48A4647F880
	for <lists+linux-nfs@lfdr.de>; Sun, 26 Dec 2021 19:34:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231459AbhLZSeq (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sun, 26 Dec 2021 13:34:46 -0500
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:35643 "EHLO
        out3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230465AbhLZSeq (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sun, 26 Dec 2021 13:34:46 -0500
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.nyi.internal (Postfix) with ESMTP id B8DCE5C0093;
        Sun, 26 Dec 2021 13:34:45 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute1.internal (MEProxy); Sun, 26 Dec 2021 13:34:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=a0dFVF
        82WizF9FvBRbCiW5Gm3vxn6RBxpn+fRF6z6Rs=; b=HEbGhNG5H2cIrIrZ/61mhj
        xkjupTtU3bYALg8Beu7pNNc/UB6WRhDdYaq4OeE753c/Ct/Dk9vLiR4g7PP+SJZQ
        fOr9gZbHAbU5/QEjfKdlDzkvht4qkWSI1NQJNbJWZUzJyZL6qkYEbPJ9XetDgMPv
        fti3cnybaOmvCSrISm58qUcfi+tvC4G2cI6W5yAFfoXEdRlnurYZkW8Ri9U8DpPJ
        mNzxkBjtbWT0cmdHlIM9RIHz26FolQDeSfqpQGf1hOYYf5TObuuRA/7jb4IFdQ8j
        OMF+32pl9lGHdKO+zp0rMBn34MZaOxgjeK2YtVwOuig4PspAAfnjzMdbNAq0avOg
        ==
X-ME-Sender: <xms:xbXIYQLd-egsWIbSgx9uJcz9SyQbFUX4ytboNaqiLNDm-j_NRkRJAw>
    <xme:xbXIYQICwXDkghiwNF6ZhrKEu4XEZNVDYFWwitHf_SNfHeh11tPBvVEV8j3A77DXu
    pIAOEjNlXsHVTOLeQ>
X-ME-Received: <xmr:xbXIYQv_M_c0xwm3BrQpRBGI7Rg-9u3VcvL97Zy9lmWi4QuGIcPpiK19LeZStGGYzMisVcV-wmff64TstlRoA8NweJDjTEBiY1ftJks0i7JJ5cNhYWL1LZrEXVeSrWS77Y8nONYis1C3Ye6o7_XSJ0dCrGOMhqpT>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvuddruddugedgieekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffktgggufffjgfvfhfosehgtdhmrehhtdejnecuhfhrohhmpedfffhorhhi
    rghnucfvrgihlhhorhculdfnihhsthhsmddfuceolhhishhtshesughorhhirghnthgrhi
    hlohhrrdgtohhmqeenucggtffrrghtthgvrhhnpedvhedtvdetledtkeetueefleehgeff
    vdfgtdeiheehtdetgfeugfegteffhfdvleenucffohhmrghinhepthhimhgvrdhsohdpgh
    hsshgurdhtohdpughorhhirghnthgrhihlohhrrdgtohhmnecuvehluhhsthgvrhfuihii
    vgeptdenucfrrghrrghmpehmrghilhhfrhhomheplhhishhtshesughorhhirghnthgrhi
    hlohhrrdgtohhm
X-ME-Proxy: <xmx:xbXIYdblTuVpk3OmtjyDFJaJTYqcMoc_tKoAhEmpk7Iq26ty0pGTuA>
    <xmx:xbXIYXbkoTb_U-b9KMa08wHk1QXItaqK4ESl32wDyxKPUBPm57WdGA>
    <xmx:xbXIYZDm3idlcS_Ul3wQxkCyQ8vJgGFOuJlRGAUHoSXIR650RPSDPQ>
    <xmx:xbXIYTGOZz13LV25IE7GLWAqJmcgbLYlTkozWdblaaZTqUlwOt3I2Q>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 26 Dec 2021 13:34:45 -0500 (EST)
From:   "Dorian Taylor (Lists)" <lists@doriantaylor.com>
Message-Id: <AA15B46B-032F-456D-A562-504AD0516AC0@doriantaylor.com>
Content-Type: multipart/signed;
        boundary="Apple-Mail=_85F050A9-8880-49C2-B8B2-A5A3F44E194E";
        protocol="application/pgp-signature";
        micalg=pgp-sha512
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.120.23.2.7\))
Subject: Re: GSSAPI as it relates to NFS
Date:   Sun, 26 Dec 2021 13:34:43 -0500
In-Reply-To: <9DA49FE9-F4AF-44CC-8BCF-86F4D2D984AA@oracle.com>
Cc:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>
To:     Chuck Lever III <chuck.lever@oracle.com>
References: <234CDB6C-C565-4BB4-AE38-92F4B05AB4BD@doriantaylor.com>
 <48DBBF53-7CE3-4DDA-B697-B14F8C382E78@oracle.com>
 <AF7243DE-250E-4CCB-86C0-40C69BB71C88@doriantaylor.com>
 <9DA49FE9-F4AF-44CC-8BCF-86F4D2D984AA@oracle.com>
X-Mailer: Apple Mail (2.3608.120.23.2.7)
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org


--Apple-Mail=_85F050A9-8880-49C2-B8B2-A5A3F44E194E
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=utf-8


> On Dec 25, 2021, at 5:53 PM, Chuck Lever III <chuck.lever@oracle.com> =
wrote:
>=20
> IIRC Linux requires that a mount operation be done by root. If you run =
gssd with "-n", become root, then kinit as yourself, I think it should =
work.
>=20
> There has been some discussion about enabling a non-privileged user to =
perform a mount... it's a bit tricky because the function of mount is to =
alter the file namespace, which traditionally requires extra privilege =
to do.
>=20
> Mac OS has had this functionality for ages to enable basic Finder =
operation. Linux doesn't have it yet.

I mean, you=E2=80=99re the expert, though it looks a heck of a lot like =
the functionality is present: mount(8) is setuid (and so is mount.nfs), =
there is the `user` (and separate `users`) mount option in fstab, and I =
am pretty sure I have mounted things like optical drives and USB keys =
from a Linux desktop without e.g. entering a password (though I suppose =
that could have been the work of FUSE or GVFS or something).

> AFAIK you are not doing anything wrong. It just isn't supported on =
Linux at this time.

So, here is something interesting:

* I run `rpc.gssd -fn -vvv`
* in a root shell, I `kinit` as myself
* I `mount remotehome:/in/fstab`
* miraculously, that $RPC_PIPEFS/nfs/$CLIENT/krb5 pseudo-file now =
reports =E2=80=9Cmech=3Dkrb5 uid=3D1000=E2=80=A6=E2=80=9D
* after some carping about credential caches, rpc.gssd works correctly =
and the share is mounted as me.

I didn=E2=80=99t mount the NFS share though, root did, with my Kerberos =
TGT. =46rom this I can deduce that that uid=3D1000 must be coming from =
rpc.idmapd, because where else could it come from? That=E2=80=99s the =
only thing that =E2=80=9Cknows=E2=80=9D the relationship between the =
Kerberos principals and the user IDs on the system.

Moreover, what looks like what happened with the credential caches is =
that even though doing a kinit for my ticket as root, the ccache that =
rpc.gssd actually *used* to authenticate the share was a different one  =
owned by me (uid 1000) that was also in /tmp at the time.

So /tmp/krb5cc_0 is used (presumably by rpc.idmapd) to find out that =
dorian@REALM -> 1000, but then /tmp/krb5cc_1000_XoaBV1 (by rpc.gssd) to =
actually authenticate the mount.

What this is telling me is that there is no reason in principle why a =
non-root user shouldn't be able to mount an NFSv4 share authenticated by =
GSS/Kerberos (as both `mount` and `mount.nfs` are setuid, and the fstab =
entry has `user` in the options; by all means the code to do the job =
sure looks like it=E2=80=99s in there), but rather the information about =
the *initial* mapping from Kerberos principal to system uid is not =
getting transmitted to rpc.gssd. To recap:

* when I run `mount remotehome:/in/fstab` as myself, gssd reports =
reading uid=3D0 in that pseudo-file;
* when I run `mount remotehome:/in/fstab` as root with my ticket, gssd =
reports uid=3D1000.

although, actually:

* it turns out that the only parts that matter are a) rpc.gssd -n, and =
b) root having a ccache with my ticket in it, in addition to me having =
one as well. I also appear not to need to be root to do the actual mount =
though, as `mount` is suid.

(aside: it looks like the `noresvport` mount option is ignored, as port =
<1024 is used to connect whether the real uid invoking `mount` is root =
or myself.)

This is looking more and more like a bug. I wonder what it would take to =
get it to work properly?

--
Dorian Taylor
Make things. Make sense.
https://doriantaylor.com


--Apple-Mail=_85F050A9-8880-49C2-B8B2-A5A3F44E194E
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEQCibkUxMA9OSsNh/irFKO32Nr6MFAmHItcMACgkQirFKO32N
r6O1sg/6ArrqEYO0GU7Oca3z00BVduPdralr3KP2ni1fA7P+88yfCavQRku3m5Vq
fr08hpB4ByL9mNG7Hj7ITtk2huGe612y865PzmfZ2JFBnNfVv9qDCfdm6xri+WgB
zg3lTDvV5I0E8rJCZeTb0mPNho8rLZF8rCOOh1gQPFykONl/CRUakud7GzapYbuE
Vze/U9HEYacMxfPgGqAsm+DtuhG+4ASNLDMYM67X7h/NFSRsMwJx43KC6WPx4jPg
TO6oHz3P+3AFaab2wH8ooZFUuihiG0cQ3yBjQk0A/ZblWK3ZN4RvJGUiSfIVRYKS
VyGhiGWATfFCsMJqspYBDwEYjZEhSMzhi4JUllc7iWY5k7VzI06TZ3moGZsHEof8
cjPy1JNGXBQKRg5lwofoaD24227isC1DTKLUIMp5NL9pSfrqw2nC2e+NU3N6uyHO
p0Dx7SR16+BOSQmV+p7yzxCyo/dKM5rIEgs9kZhqh0zsLqfIRH7SHyqJTL3OX0z0
4Gw3YkdUrJG5krd/Zj57xsfT5W0pE0Q22r7kFQkbQN7RdrqeM6wWzmM8fZCEiY6S
yP2R+rdxfByTfYaDEOtp9ZW5REyG6MDgjz6Zm+GLqGu9odZRJL/ZIynihuyGCo3g
cKtZZLjuqXGcx7bcMx294qHNeBolnBK4jw8OX68wfaM6uV9UFS8=
=SmfW
-----END PGP SIGNATURE-----

--Apple-Mail=_85F050A9-8880-49C2-B8B2-A5A3F44E194E--

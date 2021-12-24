Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 725E347F0A1
	for <lists+linux-nfs@lfdr.de>; Fri, 24 Dec 2021 20:15:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229868AbhLXTPK (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 24 Dec 2021 14:15:10 -0500
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:49367 "EHLO
        out3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229553AbhLXTPK (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 24 Dec 2021 14:15:10 -0500
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id EEC4D5C00AD;
        Fri, 24 Dec 2021 14:15:09 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Fri, 24 Dec 2021 14:15:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=pMAqQD
        UxbYGOnAJf2qV2T+VlvbOwZ/0WnWo+RmKCjOg=; b=ejWrFFNjoplIPTzmnPMI0V
        2zbebTdrBHQ5wtQ2EgIM3vg8pGhr9GMOrpUj/93Pq72CWUE2tfkvrim9XgtFq2f5
        ZH01m+Y+q0tEZ2qE+RwycOXP3naoYlN0/xJDNBS6w+bjCPkAziMXO3XZOFdXLgrJ
        bJ4+dIcJrNKLEuoEex5hG/3J5q9Q3LKDxQCoSikaJqmz5nkZcJZ2eXXKEl3Rmnqc
        6PHrgvlkNDACuiNsahrp2JVJI2O8iA1Hb5wPsUjkMh2uUuS8FOaakIGVOFe9+PIY
        jOekbg2gPIEyD7OeULNHHiXZGSHRsDIy8I8cln+G7SM5pT5C91vZqd9HA895eI4Q
        ==
X-ME-Sender: <xms:PRzGYcMlgB85BFhKzHHMTaZy6E01Ni5OIXNtebHIX0gxt23XuDu9Xg>
    <xme:PRzGYS9iN72EbllIUFTLwSMc5d1XpgZ2zUhhgu5_8cCKIlQZ3A_jNUcTprYTnvgCt
    mkMJ-HPegEVMKTZVw>
X-ME-Received: <xmr:PRzGYTRgf49LxTiuam8AiJspqplxFU_XEoBLXVg3eMRtHhALIPtXy6s5zTmtnuhtzkBEvpNEgq1slTzMMiQ6I_u6O82yiP2m9Um8vLpfZQovjgEsSVqywGdhHZ3DHNZeDUoFZjlTgakr4CR8uy6_nEVvzKZwppaC>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvuddruddutddguddvgecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefhkfgtggfuffgjvfhfofesghdtmherhhdtjeenucfhrhhomhepfdffohhr
    ihgrnhcuvfgrhihlohhrucdlnfhishhtshdmfdcuoehlihhsthhsseguohhrihgrnhhtrg
    ihlhhorhdrtghomheqnecuggftrfgrthhtvghrnhepgeehveffledufefhveekffffteej
    hfetkeefvdetfffghffhuddufeelvedtueetnecuffhomhgrihhnpeguohhrihgrnhhtrg
    ihlhhorhdrtghomhenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhl
    fhhrohhmpehlihhsthhsseguohhrihgrnhhtrgihlhhorhdrtghomh
X-ME-Proxy: <xmx:PRzGYUsafpYXNvnVrb1DhByDP1sPIgnyIbAhsys9m1Wi6778_e7yAw>
    <xmx:PRzGYUdYuOIfRHyPA7fmIfvt3UWOY1YP6svF2s0UsbvFIwhvMke5WA>
    <xmx:PRzGYY38J5wxWDohHa0s7Betp3KNHLLU74D4TeLGiM-NcDXvVD8cZA>
    <xmx:PRzGYc6GDPDjbcl2pDYjq68b-DYv5FnKaaUDrMQawWRW1Lq72ezrXA>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 24 Dec 2021 14:15:09 -0500 (EST)
From:   "Dorian Taylor (Lists)" <lists@doriantaylor.com>
Message-Id: <AF7243DE-250E-4CCB-86C0-40C69BB71C88@doriantaylor.com>
Content-Type: multipart/signed;
        boundary="Apple-Mail=_43A80A52-2F84-4AB4-8BB9-AF025D3E9853";
        protocol="application/pgp-signature";
        micalg=pgp-sha512
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.120.23.2.7\))
Subject: Re: GSSAPI as it relates to NFS
Date:   Fri, 24 Dec 2021 14:15:08 -0500
In-Reply-To: <48DBBF53-7CE3-4DDA-B697-B14F8C382E78@oracle.com>
Cc:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>
To:     Chuck Lever III <chuck.lever@oracle.com>
References: <234CDB6C-C565-4BB4-AE38-92F4B05AB4BD@doriantaylor.com>
 <48DBBF53-7CE3-4DDA-B697-B14F8C382E78@oracle.com>
X-Mailer: Apple Mail (2.3608.120.23.2.7)
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org


--Apple-Mail=_43A80A52-2F84-4AB4-8BB9-AF025D3E9853
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=utf-8


> On Dec 24, 2021, at 12:28 PM, Chuck Lever III <chuck.lever@oracle.com> =
wrote:
>=20
> man 8 rpc.gssd
>=20
> The "-n" option might be helpful.

Interesting, thanks. I tried it, but predictably it complained that my =
ccache was (correctly) owned by uid 1000, not 0. What I=E2=80=99m =
wondering about is why the uid in the $RPC_PIPEFS/nfs/$CLIENT/krb5 =
pseudofile is 0 when it should be 1000. Like I=E2=80=99m trying to =
determine if I have something misconfigured vs whether something is =
calling geteuid() when it should be calling getuid() (or whatever). =
Restating my situation:

* I run `kinit` as myself and get my TGT
* I run `mount -t nfs4 -o sec=3Dkrb5p =
host:/listed/in/fstab/with/user/flag /desired/target`
* I get EPERM with additional information saying the mount was denied by =
the server (actually a red herring; wireshark shows nothing coherent =
makes it to the server so the request is summarily denied)
* rpc.gssd -f -vvv shows that the failure is because it can=E2=80=99t =
find a keytab for various service principals
* problem is I am expecting it to use *my* *user* principal
* I know the mount should work because my Mac is already doing it; =
it=E2=80=99s the Linux client that=E2=80=99s failing

I have tracked the failure down as far as the pseudo-file =
$RPC_PIPEFS/nfs/$CLIENT/krb5 containing incorrect information (namely it =
says =E2=80=9Cmech=3Dkrb5 uid=3D0 service=3D*=E2=80=9D where it should =
be saying =E2=80=9Cmech=3Dkrb5 uid=3D1000=E2=80=9D). If that pseudo-file =
contained the correct information then by all accounts rpc.gssd should =
do the right thing. Thing is, I don=E2=80=99t know what (the kernel? =
something else?) populates that pseudo-file, and I have zero leads as to =
what creates it short of exhaustively poring over the kernel and =
nfs-utils (and other?) source code.

(I should also note that I have the debug output on rpc.idmapd also =
cranked up, and it does report that it interacts with that rpc_pipefs =
pseudo-filesystem but *not* that krb5 pseudo-file.)

(I even ran mount.nfs4 in gdb, but since it=E2=80=99s suid and because =
of that I have to run gdb as root, I=E2=80=99m necessarily going to miss =
the exact thing I=E2=80=99m looking for.)

I have two hypotheses:

* I have misconfigured something, but if I have, I can=E2=80=99t find =
the documentation needed to un-misconfigure it, because no documentation =
I have found so far mentions troubleshooting nfsv4+gss/krb5 with user =
(not machine) credentials, at least with non-root users (despite =
appearing to be supported in the source code)

* something is short-circuiting whatever mechanism is supposed to =
correctly report my (real) uid to whatever other mechanism makes it show =
up in that krb5 pseudo-file which subsequently directs rpc.gssd=E2=80=99s =
behaviour, and there isn=E2=80=99t a test case to catch it.

Either way, if there is a flow diagram kicking around showing all of the =
parts and pieces of the nfsv4+krb5 mounting process, I would be =
eternally grateful to see it.


--
Dorian Taylor
Make things. Make sense.
https://doriantaylor.com


--Apple-Mail=_43A80A52-2F84-4AB4-8BB9-AF025D3E9853
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEQCibkUxMA9OSsNh/irFKO32Nr6MFAmHGHDwACgkQirFKO32N
r6NieA//f4zxm6KQB9vHDiumhc+jOBl0UbrW0FCDKPaPYZSi22iq1C2bkmT37uOI
dLlM2eNoPuc82sRxgGZl8pc+hjxHFWUlrRwnDKXABtLc215xllfkB0QtPB0SdEm6
UOneIQp+MhlJizKEx1+gzfbXrYDHztUr4m2uTEoQqFuVdDJC72dokUEZfF3JdffA
evCOnE6Hst+PI+j41GlD5ipaWGzPfwUTEZrWCWhIXVa7je8MzAb2R2o+InlvrOYl
HTT8B5EGASncXwV8JvED+g+GVbzVfJSefcdGLlH1S+IMfttAmKylF/UCuTydCAB5
p9SNscym1f3+04g77fvU1YiEqFvh2MT3DLP6uZPYtvvqNlr5ryo4O7DSWhXvBF/b
zl+Tj+HMsCFSzHp6sOTnJQD0LeuroItUr8OfeXmwstS4VpyTKybH92PO/L4Xpwrt
zx/SBurgZROFlI57JTevVrTVjoBBG/FEB8SmZWG8OU4MjUxKw3wxonhhYxA09Jsk
cTIFi2GvXIM4BQJGir2wPiF6WT5lVwyq2ufOZTJG1xhqtLJzfFRlGe71nGzxh3yP
PjdhaYSSFY4DY2HydnpnWI10HHOctYRvZ16CYByP3giSZjt1/Mv8yId7b0G5s6M3
OL1MkYQrN0hr6n9Cv6M7VRqi6Lk42IhpZqTxzjjPQnIVUOGzxOo=
=at8g
-----END PGP SIGNATURE-----

--Apple-Mail=_43A80A52-2F84-4AB4-8BB9-AF025D3E9853--

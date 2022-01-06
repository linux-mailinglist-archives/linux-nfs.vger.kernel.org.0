Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 720B4486577
	for <lists+linux-nfs@lfdr.de>; Thu,  6 Jan 2022 14:44:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239689AbiAFNog (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 6 Jan 2022 08:44:36 -0500
Received: from wout5-smtp.messagingengine.com ([64.147.123.21]:43773 "EHLO
        wout5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S239492AbiAFNof (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 6 Jan 2022 08:44:35 -0500
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.west.internal (Postfix) with ESMTP id 1399532008FD;
        Thu,  6 Jan 2022 08:44:34 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Thu, 06 Jan 2022 08:44:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=mkbSgg
        WY6X6f41XSPi+6W8YDY0AGr1M/9CuZb+0exRs=; b=GfpwNhx4oGHqHOTvAYWDeW
        NFvFRb2a8BoIfqZAXRvioTyRAVTZV0hRoQks7GB8KqgmRhACcZR1dbyf01iO2sjt
        yl+R5cgl/M4mQpRuyslLNhypp6TtcDcYxiJJurNgc5qG0cdNS+BWOQLLkYUYl6S+
        jNdCCrdmNydmQAbv30kmvzDF5zlYJEEqyvCvwvZS4HhZF8oQPLcc8xLesvUO6DFk
        o7T8TkPixSYkXDauNYxzEKtRPJ26ItH+LAO8mv0V5GciliJf/vkVWT8esM2d1IVx
        DTjaHl5E5Kzoyd+GPRHdcmJ3aSz1iHOSwjlgcYtJX+qO7nDcrNabkT6zjnqDPW2A
        ==
X-ME-Sender: <xms:QvLWYa25hz4gXbgQQ6B6G4Dtz0Yrs5rSxQgUxLM3dFVKaNLOzJFbkA>
    <xme:QvLWYdGYDQotQVXARwKhHVhE3j9A0CmQIuf0ojVzZZ5G2Fh0l0dxyxHWu6u745fHl
    uYf4aLJRkRKZKTmqA>
X-ME-Received: <xmr:QvLWYS4vIpXp86O_Q-m7QURt_frljrtBK0LvRFG1Itai0EPynVjFmGMY7aOoelAshOnPJIy0orlTBre1TNWUvDEKYbiU_HSQQ3yddKZEt8t2CGm501bbl_2I2MKH6JY21jKQUzvkeOMA1HXY5fk6vktTY6h3G7lH>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvuddrudefledgheehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffktgggufffjgfvfhfosehgtdhmrehhtdejnecuhfhrohhmpedfffhorhhi
    rghnucfvrgihlhhorhculdfnihhsthhsmddfuceolhhishhtshesughorhhirghnthgrhi
    hlohhrrdgtohhmqeenucggtffrrghtthgvrhhnpeegheevffeludefhfevkeffffetjefh
    teekfedvteffgffhhfduudefleevtdeuteenucffohhmrghinhepughorhhirghnthgrhi
    hlohhrrdgtohhmnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhf
    rhhomheplhhishhtshesughorhhirghnthgrhihlohhrrdgtohhm
X-ME-Proxy: <xmx:QvLWYb3WPN2TCLdJwzrhCZi0_gdjt1FYywPIw49mitQGwKjcGVY1fw>
    <xmx:QvLWYdEAVfQT2KO9ja7dYHG8y_dSfi0yDTJ5IN5vReQGsy4x8IrV7Q>
    <xmx:QvLWYU-7f-Y1O81IeWt-qi_Lu75_RUjkPCWRA0tDmgdAfYstL4aetg>
    <xmx:QvLWYWMbDhKVe_paf2sGNWugX2bugzwVOFOm1bta0l3BGLloQBVa5g>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 6 Jan 2022 08:44:33 -0500 (EST)
From:   "Dorian Taylor (Lists)" <lists@doriantaylor.com>
Message-Id: <0CCD4AC8-B96A-4498-8327-4C9BB8EAEDAB@doriantaylor.com>
Content-Type: multipart/signed;
        boundary="Apple-Mail=_0B787BA1-5A59-4EB0-91EC-97C70E7181F2";
        protocol="application/pgp-signature";
        micalg=pgp-sha512
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.120.23.2.7\))
Subject: Re: GSSAPI as it relates to NFS
Date:   Thu, 6 Jan 2022 08:44:31 -0500
In-Reply-To: <1a7193c740c8cb7ba94ecfb5d5eedd32af37088c.camel@hammerspace.com>
Cc:     "bfields@fieldses.org" <bfields@fieldses.org>,
        "chuck.lever@oracle.com" <chuck.lever@oracle.com>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
To:     Trond Myklebust <trondmy@hammerspace.com>
References: <234CDB6C-C565-4BB4-AE38-92F4B05AB4BD@doriantaylor.com>
 <48DBBF53-7CE3-4DDA-B697-B14F8C382E78@oracle.com>
 <AF7243DE-250E-4CCB-86C0-40C69BB71C88@doriantaylor.com>
 <9DA49FE9-F4AF-44CC-8BCF-86F4D2D984AA@oracle.com>
 <20220103213229.GL21514@fieldses.org>
 <1a7193c740c8cb7ba94ecfb5d5eedd32af37088c.camel@hammerspace.com>
X-Mailer: Apple Mail (2.3608.120.23.2.7)
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org


--Apple-Mail=_0B787BA1-5A59-4EB0-91EC-97C70E7181F2
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=utf-8

Apologies, I had missed the additional activity on this topic.

TL;DR: `mount` of an nfsv4 volume as an unprivileged user works with =
Kerberos, for some definition of =E2=80=9Cworks=E2=80=9D, as long as =
root also has a copy of the unprivileged user=E2=80=99s TGT.

> On Jan 3, 2022, at 4:45 PM, Trond Myklebust <trondmy@hammerspace.com> =
wrote:
>=20
> As noted, the main issue is the bind() privileges needed for AUTH_SYS.
>=20
> When using AUTH_GSS, the knfsd server doesn't care about the
> originating port, which would allow unprivileged mounts to go ahead
> provided that the user specifies the 'noresvport' mount option on the
> client. Isn't that working?

Indeed, mounting an nfs volume as an unprivileged user seems to work in =
principle; it looks like what=E2=80=99s happening is the mounting =
process fails to transmit (or fails to make use of a successful =
transmission of) the correct uid at some point along the line.

consider the relevant part of the server=E2=80=99s /etc/exports:

/srv/home/dorian =
*(rw,nohide,insecure,no_subtree_check,async,pnfs,sec=3Dkrb5p:krb5i:krb5:sy=
s)

and the client=E2=80=99s /etc/fstab:

deuce:/home/dorian	/net/dorian	nfs4	=
sec=3Dkrb5p,soft,noresvport,noauto,user	0	0

Then the procedure:

* start rpc.gssd with -n to prevent it from looking for service =
principals

* `kinit` as myself, also `sudo kinit dorian` to get a ticket for me =
owned by root

* then just execute `mount deuce:/home/dorian` as myself.

Both my user and root have to have a TGT for dorian@REALM or it won=E2=80=99=
t work. Same with rpc.gssd suppressing service principals, but I suspect =
that is just incidental. It=E2=80=99s also worth noting that the =
connection appears to be unconditionally made on a privileged port even =
though `insecure` was set on the server and `noresvport` was specified =
on the client.

I am afraid I do not have any additional visibility into the mounting =
procedure save to note that that `krb5` pipefs pseudo-file looks like =
it=E2=80=99s getting its information from rpc.idmapd, which in turn is =
getting its own information from Kerberos principals. I don=E2=80=99t =
know how that pipefs mechanism works though. If I were to hazard a guess =
as to what was happening, it=E2=80=99s that mount.nfs(8) internals are =
losing track of the caller=E2=80=99s real uid when escalating privileges =
to do the mount. That is consistent with a) root also needing an =
unprivileged TGT and b) the client unconditionally connecting on port =
<1024.

--
Dorian Taylor
Make things. Make sense.
https://doriantaylor.com


--Apple-Mail=_0B787BA1-5A59-4EB0-91EC-97C70E7181F2
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEQCibkUxMA9OSsNh/irFKO32Nr6MFAmHW8j8ACgkQirFKO32N
r6OVTg/+OnMCsXCWb9TmHMoPgQ2kUkQUCc3TSI2VyEdVxQkDrokZZ6By/qBxWlQO
Qah/uqvCsc1iFo8n0ySoagDTQektklMmvE2PIT5ToNbGh1rOFo463TLI+7yVG7fh
G4bnMNAF48H7T0VSKz+5DXoLyPE8Dim750GVQfu29Vgy4h6a1IXefHpD/9IPvM2Z
sFHIIsJBUKwdnAbP6nWAzBW4Vm6GdcESQgVSGoAjafSyg6q7tcakZnkU2QjfbsyE
kwT1Uk+YeL/IdiC5rVKlfDDoDa+Ue8k56pH8u9q3rYp6UoiTMRiiyYzcMO5rRmeG
CvD3RI31tqTpXWXp17RoXAsVNEpWF2cknBC+tyRs0ZKu2BzO7ta3R+3RWytQlcDp
dxBIWVQ790QMjMo3+LdD05sjvImVlz9IYvoyofCTffzW4QlEj8zs3y1UAMmsnEEx
QA2sL9ZOXmU0AGTXeBpH+1Hlx5v5DZQHLrDjAD4CILNWq7wfgbTKiYCIpiRrNAJq
z/TsbSCKzOqH6MxWhPTm0b5/hscwbqUstOAaDgbmKAixudupAOa6/NwbOThgtkbf
QNqzLWuXXCdlJkoTMQXLrJxMuZFFc7mTjydbakNfkEHj7NpWaaGORCLPgSG+b4ie
izIQ2XtUBrlBBIDiL01xNOukjRP9UKFCTJTDfu+eg1zY3r5gHxw=
=WxTW
-----END PGP SIGNATURE-----

--Apple-Mail=_0B787BA1-5A59-4EB0-91EC-97C70E7181F2--

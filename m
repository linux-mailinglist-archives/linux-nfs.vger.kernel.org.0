Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C61747E986
	for <lists+linux-nfs@lfdr.de>; Thu, 23 Dec 2021 23:28:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350431AbhLWW22 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 23 Dec 2021 17:28:28 -0500
Received: from out5-smtp.messagingengine.com ([66.111.4.29]:41611 "EHLO
        out5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234802AbhLWW17 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 23 Dec 2021 17:27:59 -0500
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id 2D46A5C004D
        for <linux-nfs@vger.kernel.org>; Thu, 23 Dec 2021 17:27:59 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Thu, 23 Dec 2021 17:27:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=content-type:date:from:message-id
        :mime-version:subject:to:x-me-proxy:x-me-proxy:x-me-sender
        :x-me-sender:x-sasl-enc; s=fm1; bh=3g7iDYJehwluc9cgkj64GPzKpwDsB
        A28lAPMMLigrU4=; b=fGboMObBXW3gyXnjOZS+h1qx6wn8eUjahj2lQmM2xi1c9
        OBFSDa7J6YQJM/RRFaAH0xc0w0v1wZCasSrqfR/HP/JQ/9ECec3lHZ3Len6oL9o8
        1Kxk+w06w2izFpfenR9UutZSqvfYxcvr2LQHzDnrvFkPxa24iPaLOJuXe87bUQWj
        e4Yr8DaardSwjwbfQd8bJALrVF6ofxT+2teX6Q4vrIY9XIm8SCvTBuFA9TBOYMJW
        uEdtOqlkbQW60i+J/lSjXzDLMuyQhmxikEy0QaLdy9GV+QJB4WGVemn94RyXKtdy
        csTGstz2Yf7MrSeW10Ko4odx5KxahFHgWZZ8Dh3qg==
X-ME-Sender: <xms:7vfEYW7dgriKJXDiAkgA_jFaH7HqRWIdIifd6Rm6MdVI84ncV0GEPA>
    <xme:7vfEYf43B_DpKIFva_wx6JBhgiTTtPP7YXRfWaF6YWwVDlR52yjsqlRNVgK1osnHq
    0fYihqVMHSeOV0fvw>
X-ME-Received: <xmr:7vfEYVdj6Ygk3jVGmy927wqpQ2CUjj-PALb8HtBIerVRFfwJWXDfdInhoMDyoh2wRRp_VtMd7cLrBKDFcw90FmNKFWqtcE3sDJu81AJTFa9uivlUJILYZ1F25dM5uEhlENfZ4r0yklkYp4YH_Wefk0vbpB-N-_oO>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvuddruddtkedgudehiecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecunecujfgurhephfgtggfukfffvffosehgtdhmre
    hhtdejnecuhfhrohhmpeffohhrihgrnhcuvfgrhihlohhruceohhhiseguohhrihgrnhht
    rgihlhhorhdrtghomheqnecuggftrfgrthhtvghrnhepiefghffgveelfeevudevleffff
    efvdeljeelgfdvleekuddvkeejjefhgfefhffgnecuffhomhgrihhnpegrshhkuhgsuhhn
    thhurdgtohhmpdguohhrihgrnhhtrgihlhhorhdrtghomhenucevlhhushhtvghrufhiii
    gvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehhihesughorhhirghnthgrhihlohhr
    rdgtohhm
X-ME-Proxy: <xmx:7_fEYTLitkXnDNe0rFKb2zBG9m0Asb-EH1RT7OlaP-wa2DhMISDfnw>
    <xmx:7_fEYaL_chzxkvs1rNx07qKT8PuIX_7MJ_RdRq71g9AxhI_ap-btLA>
    <xmx:7_fEYUwA4RREXli_iVXVuXJT_r8YBzYt06Q2rgZTCTLeX6yduEOceQ>
    <xmx:7_fEYRWfzWQuwtEIkd3NbqsUzkEyH9w-Tvy0_bLle31rtg5zLfy6Qw>
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <linux-nfs@vger.kernel.org>; Thu, 23 Dec 2021 17:27:58 -0500 (EST)
From:   Dorian Taylor <hi@doriantaylor.com>
Content-Type: multipart/signed;
        boundary="Apple-Mail=_8244C879-04D7-46E2-AF33-6DBBDC9DCE90";
        protocol="application/pgp-signature";
        micalg=pgp-sha512
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.120.23.2.7\))
Subject: GSSAPI as it relates to NFS
Message-Id: <234CDB6C-C565-4BB4-AE38-92F4B05AB4BD@doriantaylor.com>
Date:   Thu, 23 Dec 2021 17:27:57 -0500
To:     linux-nfs@vger.kernel.org
X-Mailer: Apple Mail (2.3608.120.23.2.7)
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org


--Apple-Mail=_8244C879-04D7-46E2-AF33-6DBBDC9DCE90
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=utf-8

Greetings list,

I have been scouring the Web (and nfs-utils, kernel, and libmount source =
trees) for several days now to try to understand what happens during the =
mount procedure when the (NFSv4) share is authenticated by GSS (or =
rather, Kerberos). What I am trying to do is mount an NFS share as =
myself (a regular user) with my own Kerberos credentials. What I am =
seeing is an insistence on the part of some part of the system to =
populate the $RPC_PIPEFS/nfs/$CLIENT/krb5 pseudo-file with =E2=80=9Cmech=3D=
krb5 uid=3D0 service=3D* enctypes=3D=E2=80=A6=E2=80=9D, which then gets =
ferried on to rpc.gssd, which dutifully goes looking for machine =
credentials that do not exist. Instead (at least by my reading of the =
source code for what kind of outcome I want), that pseudo-file should =
say =E2=80=9Cmech=3Dkrb5 uid=3D1000 enctypes=3D=E2=80=A6=E2=80=9D (ie no =
service=3D=E2=80=A6) etc. If it said that then rpc.gssd would (likely) =
do the right thing.

My question then: what is populating that pseudo-file in the rpc_pipefs =
filesystem? (and when is it doing it?) How come it insists on directing =
rpc.gssd to look for machine credentials for root instead of the uid of =
the caller (me)? I have been unable to locate any information on the =
role of rpc_pipefs beyond a blurb in the kernel source code, nor have I =
been able to locate anything that looks remotely like a protocol diagram =
for the NFSv4(+gss/krb5) mounting process, so I guess my question =
reduces to: where do I go looking for a solution to this problem?

(Note this is all recent Ubuntu, 20.04 and newer, and I already have Mac =
clients connecting to the server. More context and details here: =
https://askubuntu.com/questions/1382702/21-10-client-gssd-cant-seem-to-see=
-user-credentials-cache-when-mounting-nfsv4)

Thanks in advance for any insight,

--
Dorian Taylor
Make things. Make sense.
https://doriantaylor.com


--Apple-Mail=_8244C879-04D7-46E2-AF33-6DBBDC9DCE90
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEQCibkUxMA9OSsNh/irFKO32Nr6MFAmHE9+0ACgkQirFKO32N
r6P6zw/+IOrMgJ6mtzgP/05EiO8GXopvKH9lbFg1jt2ZX8ad/PkANLE9pdYI45AP
ti16K6ybk3USEys/oE05+HhVygE4emccg/touq6i9yn+0udUBf9egsY7rAFiNptx
paCyQMa0w4xC2KCzBses89KwCh5nOIekyESooBZbAMtASMJWh2mj4XMDCEEBew90
hZCpBFnySHkrZSAaQ8YnVwOxMi0zFId10ZwxIO45E+6/ZH++INpNJMDzN6a1K8xc
2on2nFLLZ0WhMkWZ7gvcqxzJ/XEV8Yx8hxF/mSqmJ9EBKMZSYMSPltwo8UcmK53w
qNlQ3DjUSWc0/KEA7UgVnwhwzXLf+OvZwlTWE2tfwm47Sa7kgRj0S2nle+SQ5R3J
37TqppWhFUyY0iawb388dS3Rb00UTmvBCxhcsEd8tttYyLiX5OezwT2SxA5hQ9be
2KeMoO4FGywnTf2BNiyHOEJ+Y3xUtwL4l34ciB7GyCHOzO4muEk5CimZPMOKqQ33
rv7vcVKqrWb/dagn9y41Q8CZg37MAqky0dowT+iTu6ryBNuwBkaCAsfdircp80YG
LrmVEx1VByGqGAjJf/PGkpQAtgCd3gjJNDMRPOwNklKwIQocJrWoHgypLVz3HtEA
uH1YFfIqptnpivHla92qlekRhPpjNZ02+oZ7XvBRdp4aEugAz1Q=
=vseO
-----END PGP SIGNATURE-----

--Apple-Mail=_8244C879-04D7-46E2-AF33-6DBBDC9DCE90--

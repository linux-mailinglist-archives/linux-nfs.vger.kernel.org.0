Return-Path: <linux-nfs+bounces-792-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2759681DAD0
	for <lists+linux-nfs@lfdr.de>; Sun, 24 Dec 2023 15:12:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B896A281EC2
	for <lists+linux-nfs@lfdr.de>; Sun, 24 Dec 2023 14:12:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D225F53BA;
	Sun, 24 Dec 2023 14:12:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="eQBP8cu3"
X-Original-To: linux-nfs@vger.kernel.org
Received: from sonic318-20.consmr.mail.gq1.yahoo.com (sonic318-20.consmr.mail.gq1.yahoo.com [98.137.70.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E6BD525E
	for <linux-nfs@vger.kernel.org>; Sun, 24 Dec 2023 14:12:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yahoo.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1703427149; bh=IQltHoPs8hV47KEHDt+7DVEhdW6pBb6JFXanfvABvbc=; h=Date:From:To:Cc:In-Reply-To:References:Subject:From:Subject:Reply-To; b=eQBP8cu3iMNIGSdP8NM7LMpiWKhPLyD5E8m2RsWUxf5ISxLHUHiBUJGkbj6+gEYnDKE1vKZJzK/r99N4KkGs4aFKUdeg6fUE2r2Ivvb9jRo7iR60+NjVgctQdly1khSFcgsRauGurkA1CEqvxG5LQ/XoceW/I2D82/LWR5Tf/fmsspNMOPGA/KxUuQoYHmF3/bDws29hn2AaDDbfdMSQnM6j9q4GfEUJTu6rYDS1hnX+nF/heiqMjZGIaeJrbosu30vyE9wUGQ4FbqZiOZ/vMmyQaxchInAml+E/EnGlJgfEIa3V88p4lgRmh5AhhQvIsxmTMoTRbTapzvf9Am8Ehg==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1703427149; bh=tcO8ki4KaWDPrcDc8pMFAeRH6M/SfqKg2XYxdNgKgLC=; h=X-Sonic-MF:Date:From:To:Subject:From:Subject; b=ViGsRLHyfm2opAeKOwpE3PV6sXWRWN4pOaCLZam24/Ec8qCuMEkRR48TeHCT8tUUi9TTBqdBvY3elzvVU0JvEcHkwH+SaTaLJxFPNh1wc0RJ66OQ3BYE/XttyaKUn9fLjIa+diNfz1pK9syY6cUZqoe2K6LXctnc9JXmxNELZHg6osQDSGikvCXFQ+tVpgsg9hwFy/Kb/aYEsf0VfIfYbWMToH442KxR7oyopWdke4cKo7i9XA5zLiiBRb4sUqLm/rY9v2+KoHN79U6QAe3urn/t+cF1DwbExGjQnLNG8EqCWQL3GBYHAF5gLuugMUK95XFK1hBxXVynvVNoBCD5Og==
X-YMail-OSG: 4YtUpzIVM1ksFvG84HFOxyw2G1o5NKod9.KnwoMGouxqe7Xu5SbrKqbWmytO7kR
 hiFDfMDPlmguvIGH5NHm2QGKyke3sAucUR1iLaR_AYnxQa5iFWNnXfsqBRKUzpnWyslcWyku7i0C
 9BmYcbAF19x8czYnnoR9CRU1FiXMfGoMGY1L4R0fZsDD3SU4X72YzMyiL0V6w6.zjY_lbMRPEpxh
 Q3wNu2AprnOXBYO1vJNTGWyt79aiCvjl9o4YibSvOVNvGboYfdKNTeKh1YJq2yiqrkM9FRe2HlOz
 iQkJfJEXtbLXOBJ4atKB7OpnibXU9052bRWy6HwMIwlXs_ajamFcFKBcTofry0pcGIKt4n9dELt1
 zUp.AEsIVXlhWMu0ERu14.sVmzonLfqLhepYwH7KUpZ4StWqY8UEtTW26ByA5xA5bld0k_L__k2M
 MzPbyRKWip3C8VL9MYmvAeTdzZ74nneAr6Vb5hJ_Y6ruwYvI5qwP65C72Yv.Bjy3K8m3DuBX1.qO
 cQxcWaSuHrry2QUjAVmdAQBvAEM70SEBpcftiZusnCPyw7_41qCKQdPopMHpmoii2Y7q6zh5Y7.s
 V4czVnNSaRUOvfz6EOzxDjVUOO4XshpWcZ0YRrHgpOlfzA44.zLolUAXemTjyUDj9lL05jdy2Bdy
 demq8CUx3pgtreWvmMdaeEuW26vC6Rx6GTL3fFl0dt8boPbsDDAY5pMRA5KVjk7i68T5VstWqmL8
 DA_FwW_AjZhlJlE4YDPce6HJAszc7doiY4a0Pi4epxhyqATpwmpSV5bLnsPfcYuM.zynn2_1AGlZ
 khLh5Mo9lrtyakNsnhfWJ8b11EXItjQTTJ8lVlihIbF_Pz1fiWpi55n.gpGs5Kyur7HTe41nleGe
 8QqZC.MeAA2P7IzNqTjATecQOoufD5qIosuV6pi1Mxg99RzO9DYW6zfuQNSRfFM6gB683GtKWJhp
 jrHrXRSAZF53ZyIyqM0iJUqEz0GZmhLwbQ.h9ylcEKoqNbUTIViAyCLN0ZDlXuLRDtCH1.MkAs2u
 Iuvi2NbzO2e9EvAffqIciYnd1REGbn0EUxtGu8ymbM2iOzXZwBvoCW4aX6tjD9hkjX2kvQQvZhVr
 HpyVdnQloyjuvtH0tBBTLVk3DjtHmnpxCuRlqLzQqHgX9kV6UPLi3KFfDYqH4Otf23sGcFgVHoIe
 5IekEoZ8fuYYi.XKeTy3xECaz1bHXZKLuYCvwPsGBoKBPWOhEqQ7snghrOf6MtmZ13fAWHz5tl93
 a2OZAytgwfW62pwDDT7HQPDfVSgCLsWbm6DxvJkz__BEvspLLimU5xLBSkiRKKoJ9gecGjNomlN.
 UMGwMv6FDOX7IH.bco6XUNu1CJiLmTOSvTJEvcq7.lF1ZzOXj_gVrFKZbVzPI6HFM44OLnL5Sp0N
 z4afYZUzOSX9Z3ls.eRwFXKQmSNRi4fCewtjX._VcLlong9YnpQalLv..8mKHminOGnjT8iRJU46
 yhBT1HmEqMYWelddwNHVwfrL1xk_2gLufWJdMBW.vinr90AQEED0W.ACYc_o3cppZ_e1wJDItXTe
 .4QRhoUKkVvtFHzBUy_q.XgLfi39MUhwmzOm2kQ5hSlarDAJQzUoTV5Wj6RV0cbJMScXRVeFi_hZ
 h9aMnnDHhmzo4lOOQNuTlEbEcE20dNqXFgr7kWaw7OzipsVStB6PIeDE5ek8uvK47.zJJ5.1XzQ_
 4rKIsN6XBWG.zHbragnoTktDPkWM4.zd0kHy4ON0cjCQ1UurylE9le4I3XLfp41HC3LqX525uEe1
 v92UGqnOpnh0onIMr0v5oAkCagdGcZcxKPo6vUl18VJUtPzXeZR.wyanghL16ygQJMEDCnEGAOTI
 Y1XzLGOvWXJkgIr5iRI5LGTD9gWFWPEpOnRiTip8kODgqlff8cKJdNLKjKdUw9pBzq2A.4qOoAmD
 QdIeJxKweVrSrQ_rmnVnew3kTpE0e_BCba8zsBMopz16TzrHcYLMK4T.mvH4lHlCQ0hm7OKXEmYS
 LufAeJMD4H6IVK4ta.SYvRBM9kQtWw6qme01dZOZffZtTuc3LoZQ8E6mfvLQGW0vI3k5PbDWR48g
 _GeD7kDxHTT_15Vpu1VRh9RzrnIlv1zpY40eFKP5tS8O8QqtUfHJVB55UM24ItX2a4yC7TXTrZpX
 RfwL8En0Xg1DqF1bSvxL_hnrVWG2rQPSVPQiQP9PG6uPZX4znlVOadTcdCoEOmwcPIhWeaNq75sm
 J10w4V8JTwY6f1uS5DA4.i3g-
X-Sonic-MF: <chaosesqueteam@yahoo.com>
X-Sonic-ID: 96b5159f-bb62-4edb-8705-a066ca19457f
Received: from sonic.gate.mail.ne1.yahoo.com by sonic318.consmr.mail.gq1.yahoo.com with HTTP; Sun, 24 Dec 2023 14:12:29 +0000
Date: Sun, 24 Dec 2023 14:12:27 +0000 (UTC)
From: "chaosesqueteam@yahoo.com" <chaosesqueteam@yahoo.com>
To: Jan Stary <hans@stare.cz>, "misc@openbsd.org" <misc@openbsd.org>, 
	"tech@openbsd.org" <tech@openbsd.org>
Cc: Richard Stallman <rms@gnu.org>, Bruce Perens <bruce@perens.com>, 
	Aditya Pakki <pakki001@umn.edu>, 
	Anna Schumaker <anna.schumaker@netapp.com>, 
	"ansgar@debian.org" <ansgar@debian.org>, 
	"blukashev@sempervictus.com" <blukashev@sempervictus.com>, 
	Chuck Lever <chuck.lever@oracle.com>, 
	Dave Wysochanski <dwysocha@redhat.com>, 
	"tcallawa@redhat.com" <tcallawa@redhat.com>, 
	"David S. Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, 
	Linux Networking <netdev@vger.kernel.org>, 
	"editor@lwn.net" <editor@lwn.net>, 
	"esr@thyrsus.com" <esr@thyrsus.com>, 
	"gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>, 
	"J. Bruce Fields" <bfields@fieldses.org>, 
	Leon Romanovsky <leon@kernel.org>, 
	"linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>, 
	"moglen@columbia.edu" <moglen@columbia.edu>, 
	"skraw.ml@ithnet.com" <skraw.ml@ithnet.com>, 
	"tech@openbsd.org" <tech@openbsd.org>, 
	"torvalds@linuxfoundation.org" <torvalds@linuxfoundation.org>, 
	"torvalds@osdl.org" <torvalds@osdl.org>, 
	Trond Myklebust <trond.myklebust@hammerspace.com>, 
	Bagas Sanjaya <bagasdotme@gmail.com>, 
	Eric Dumazet <edumazet@google.com>, 
	Julia Lawall <julia.lawall@inria.fr>, 
	Paolo Abeni <pabeni@redhat.com>, 
	"jon@elytron.openbsd.amsterdam" <jon@elytron.openbsd.amsterdam>, 
	"netbsd-current-users@netbsd.org" <netbsd-current-users@netbsd.org>, 
	"netbsd-users@netbsd.org" <netbsd-users@netbsd.org>, 
	Wolfenstein Enemy Territory Fans <6469670767@groups.facebook.com>
Message-ID: <800605155.4107290.1703427147662@mail.yahoo.com>
In-Reply-To: <ZX34jd2Qhx2rObC_@www.stare.cz>
References: <bf818dab301fb4e4@pg4> <1299484129.1816565.1702749635639@mail.yahoo.com> <ZX34jd2Qhx2rObC_@www.stare.cz>
Subject: Re: I can't get contributors for my C project. Can you help?
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Mailer: WebService/1.1.21952 YMailNorrin

Dear Jan: I'll do as I wish; and if you want to stop me you'll have to phys=
ically kill me.
Do you understand, woman?

And if you want to be in a fight or contest with me, of some kind; either l=
egal or otherwise.:=20
that can be arranged I suppose.
Do you understand, woman?

I'll make sure I post this to misc@openbsd.org
And I will remember that you did not assist my opensource project in realiz=
ing Unreal map format loading;=20
and that you wish for my project to not even be-able to ask for fellow C pr=
ogrammers help.
Do you understand, woman.

This is a direct warning aimed at your person.
Woman.

I will be glad when your civilization is erased.
Along with it's millions of police and white men that enforce your rights (=
derived from the New Testament, and
the newer parts of the old testament; in contrivance to the original parts =
of the law of the God: which you,
a woman, the first mentioned parts support, and the latter mentioned law; r=
evile)


-------

If there is anyone that wishes to reject the New Testament pro-women's righ=
ts belief system that Jan epitomizes,
("castrate yourself for heaven" --matthew 19 greek, "no male nor female", "=
don't stone women", "better a millstone" (drown anyone that likes young gir=
ls), "turn the other cheek", "obey all earthly rulers")
and further reject the newer-parts-of-the-old-testament writings (some of w=
hich were "discovered" in the 1500s; including
one where a woman "saves" various people from Iran, for some reason)

And instead do the much disliked work of C programming, while, perhaps, bei=
ng infavor of the original laws of the Old Testament
(marrying little girls is fine (padia, na'ar*, puella) (including in cases =
of rape (tahphas**)) Devarim 22, verse 28,=C2=A0 (hebrew, greek, latin).

(*"moses was a crying na'ar" (exodus) when pharo's darughter pulled him fro=
m the river: yes white people: na'ar means child)
(**to take: as to take a city)
(kill adulterous women) (Devarim)
(man is the ba'al (master, ruler) of the woman) (Devarim)
(if anyone entices you to follow another Power: kill them) (Devarim)
(no euniches in the assembly of the ruler) (Devarim)

[Above are the laws and beliefs that white people, chirstians, and good peo=
ple reject.]
[Just as they have come to reject programming in C.]
[Beliefs that Jan, as a woman, opposes aswell]

[Just as the pre-hellenistic world in greece held men in slavery; ruled ove=
r by women;]
[Today men are held in bondage; mental and otherwise; by the 2 million poli=
ce women can call at a moments notice.]

[Men have lost all the rights they gained in the past; they have subsumed t=
hemselves to a trans-demi-god (New Testament)]
[And have reread all earlier works in light of that.]

Then please explore this link which has the source code and all supporting =
source code that has been discovered, regarding Unreal map loading: sf.net/=
p/chaosesqueanthology/tickets/2/


TLDR: I'm glad the taliban won; because they marry little girls; just as YH=
WH's law allows.
Please help opensource game with UNREAL map loading.
And if you don't because you oppose child brides: then I will remember you =
as an enemy.

I hope western civilization falls and all your daughers are married before =
menarche (first blood) as true virgins (rabbinical)

On Saturday, December 16, 2023 at 02:20:48 PM EST, Jan Stary <hans@stare.cz=
> wrote:=20





Don't post this crap to misc@openbsd.org


On Dec 16 18:00:35, chaosesqueteam@yahoo.com wrote:
> I wish I could accept your offer.
> I don't have any money though, at all.
> If I had any I would be glad for your offer and accept.
> But I never got into the bitcoin stuff, even when it just started and was=
 being advertised on slashdot.
>=20
> If I had money I would definitely accept however.
> I just don't.
>=20
> I dream to get this opensource engine working with the unreal map format.
>=20
>=20
>=20
> On Saturday, December 16, 2023 at 10:40:30 AM EST, <jon@elytron.openbsd.a=
msterdam> wrote:=20
>=20
>=20
>=20
>=20
>=20
> Hello. I'm intersted in your task. I'm quite comfortable with C in
> general and currently working on graphics related things. I could
> give you a hand for a fair fee. Would you be interested in that?
>=20
>=20


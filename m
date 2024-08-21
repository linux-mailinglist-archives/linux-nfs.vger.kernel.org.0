Return-Path: <linux-nfs+bounces-5531-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 381E495A331
	for <lists+linux-nfs@lfdr.de>; Wed, 21 Aug 2024 18:51:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E2616284BE0
	for <lists+linux-nfs@lfdr.de>; Wed, 21 Aug 2024 16:51:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1982B18C348;
	Wed, 21 Aug 2024 16:51:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eheP/KsP"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E91D914E2EF
	for <linux-nfs@vger.kernel.org>; Wed, 21 Aug 2024 16:51:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724259114; cv=none; b=tIxnkjzrtlWFdvrcQHmKtEJaLWDYEiCRQgkeDWOQmsrS8qvUPOlpeiMJH6sDwjl31R3Dk+V9I3x4Xwa3BFFNLF3aA8cGCXzL5K1b3lnksLYere+6yEZC39p/0GmFpO70DQGVnjj85Yarz88va17soT2rjV7hq0KfOJKhUJCRiE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724259114; c=relaxed/simple;
	bh=o3ujtU9Bowb8lebAjJTr7HDZUHDKundpAqu2oiE+uzk=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=eZ8PPeJkqkaZCpQ5g/6NEGEL1IBXcIq9sNjs3Bh9JnarxTrosADA+2B0hQ6xOXMCDXepmlGW3hIQovZd4dyoMe2jJwM2ZjNSaEqIlcDJZP0GxVTRWIa/KdxlUCBzLd4yoCrDHWcRTO76ZkUqcZk8H4gKHKl3ilgpXhgeGAukacc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eheP/KsP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4D3CC32781;
	Wed, 21 Aug 2024 16:51:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724259113;
	bh=o3ujtU9Bowb8lebAjJTr7HDZUHDKundpAqu2oiE+uzk=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=eheP/KsPHGK86lXgAXdY+wmhMLsn8ZG5xsSJ+7NxiBiwJIJB0lLGj488xlm5WPzSm
	 UgWKHW+U5P9AMx5+fr9B6uUnTA6TkOAYqYbsR06xIogan/CQxbmCbQcLgK91l7otAu
	 R0oc6GcO961u+BPtDuOi9hHHx8Dqa432Rhmqe60ejbEQ1+w7dHD/Sd6PrqweyZqmXd
	 8TIRwR//X5EuuV9d68loWCAIdABpHIh2fIGNC9GigQBfGcylb5/FEtcAcJUEj3RuJB
	 9DXqExcw7IK0WCI9NFfL3ChHgi3MVia5YoZubf0oCCJeuwZf9gJgy98S7EvuRaOL2Z
	 USxdwgsWE3qyA==
Message-ID: <590b91607e15f1fecd563781a0c5390ff02da5b2.camel@kernel.org>
Subject: Re: [RFC PATCH 2/2] NFSD: Create an initial nfs4_1.x file
From: Jeff Layton <jlayton@kernel.org>
To: Chuck Lever <chuck.lever@oracle.com>
Cc: cel@kernel.org, linux-nfs@vger.kernel.org, Trond Myklebust
	 <trondmy@hammerspace.com>, Anna Schumaker <anna@kernel.org>
Date: Wed, 21 Aug 2024 12:51:51 -0400
In-Reply-To: <ZsX79e6NPi/4/rxC@tissot.1015granger.net>
References: <20240820144600.189744-1-cel@kernel.org>
	 <20240820144600.189744-3-cel@kernel.org>
	 <6a3d9288fdeb6409dca7c2ceedf249d3b40a7d97.camel@kernel.org>
	 <ZsX79e6NPi/4/rxC@tissot.1015granger.net>
Autocrypt: addr=jlayton@kernel.org; prefer-encrypt=mutual;
 keydata=mQINBE6V0TwBEADXhJg7s8wFDwBMEvn0qyhAnzFLTOCHooMZyx7XO7dAiIhDSi7G1NPxw
 n8jdFUQMCR/GlpozMFlSFiZXiObE7sef9rTtM68ukUyZM4pJ9l0KjQNgDJ6Fr342Htkjxu/kFV1Wv
 egyjnSsFt7EGoDjdKqr1TS9syJYFjagYtvWk/UfHlW09X+jOh4vYtfX7iYSx/NfqV3W1D7EDi0PqV
 T2h6v8i8YqsATFPwO4nuiTmL6I40ZofxVd+9wdRI4Db8yUNA4ZSP2nqLcLtFjClYRBoJvRWvsv4lm
 0OX6MYPtv76hka8lW4mnRmZqqx3UtfHX/hF/zH24Gj7A6sYKYLCU3YrI2Ogiu7/ksKcl7goQjpvtV
 YrOOI5VGLHge0awt7bhMCTM9KAfPc+xL/ZxAMVWd3NCk5SamL2cE99UWgtvNOIYU8m6EjTLhsj8sn
 VluJH0/RcxEeFbnSaswVChNSGa7mXJrTR22lRL6ZPjdMgS2Km90haWPRc8Wolcz07Y2se0xpGVLEQ
 cDEsvv5IMmeMe1/qLZ6NaVkNuL3WOXvxaVT9USW1+/SGipO2IpKJjeDZfehlB/kpfF24+RrK+seQf
 CBYyUE8QJpvTZyfUHNYldXlrjO6n5MdOempLqWpfOmcGkwnyNRBR46g/jf8KnPRwXs509yAqDB6sE
 LZH+yWr9LQZEwARAQABtCVKZWZmIExheXRvbiA8amxheXRvbkBwb29jaGllcmVkcy5uZXQ+iQI7BB
 MBAgAlAhsDBgsJCAcDAgYVCAIJCgsEFgIDAQIeAQIXgAUCTpXWPAIZAQAKCRAADmhBGVaCFc65D/4
 gBLNMHopQYgG/9RIM3kgFCCQV0pLv0hcg1cjr+bPI5f1PzJoOVi9s0wBDHwp8+vtHgYhM54yt43uI
 7Htij0RHFL5eFqoVT4TSfAg2qlvNemJEOY0e4daljjmZM7UtmpGs9NN0r9r50W82eb5Kw5bc/r0km
 R/arUS2st+ecRsCnwAOj6HiURwIgfDMHGPtSkoPpu3DDp/cjcYUg3HaOJuTjtGHFH963B+f+hyQ2B
 rQZBBE76ErgTDJ2Db9Ey0kw7VEZ4I2nnVUY9B5dE2pJFVO5HJBMp30fUGKvwaKqYCU2iAKxdmJXRI
 ONb7dSde8LqZahuunPDMZyMA5+mkQl7kpIpR6kVDIiqmxzRuPeiMP7O2FCUlS2DnJnRVrHmCljLkZ
 Wf7ZUA22wJpepBligemtSRSbqCyZ3B48zJ8g5B8xLEntPo/NknSJaYRvfEQqGxgk5kkNWMIMDkfQO
 lDSXZvoxqU9wFH/9jTv1/6p8dHeGM0BsbBLMqQaqnWiVt5mG92E1zkOW69LnoozE6Le+12DsNW7Rj
 iR5K+27MObjXEYIW7FIvNN/TQ6U1EOsdxwB8o//Yfc3p2QqPr5uS93SDDan5ehH59BnHpguTc27Xi
 QQZ9EGiieCUx6Zh2ze3X2UW9YNzE15uKwkkuEIj60NvQRmEDfweYfOfPVOueC+iFifbQgSmVmZiBM
 YXl0b24gPGpsYXl0b25AcmVkaGF0LmNvbT6JAjgEEwECACIFAk6V0q0CGwMGCwkIBwMCBhUIAgkKC
 wQWAgMBAh4BAheAAAoJEAAOaEEZVoIViKUQALpvsacTMWWOd7SlPFzIYy2/fjvKlfB/Xs4YdNcf9q
 LqF+lk2RBUHdR/dGwZpvw/OLmnZ8TryDo2zXVJNWEEUFNc7wQpl3i78r6UU/GUY/RQmOgPhs3epQC
 3PMJj4xFx+VuVcf/MXgDDdBUHaCTT793hyBeDbQuciARDJAW24Q1RCmjcwWIV/pgrlFa4lAXsmhoa
 c8UPc82Ijrs6ivlTweFf16VBc4nSLX5FB3ls7S5noRhm5/Zsd4PGPgIHgCZcPgkAnU1S/A/rSqf3F
 LpU+CbVBDvlVAnOq9gfNF+QiTlOHdZVIe4gEYAU3CUjbleywQqV02BKxPVM0C5/oVjMVx3bri75n1
 TkBYGmqAXy9usCkHIsG5CBHmphv9MHmqMZQVsxvCzfnI5IO1+7MoloeeW/lxuyd0pU88dZsV/riHw
 87i2GJUJtVlMl5IGBNFpqoNUoqmvRfEMeXhy/kUX4Xc03I1coZIgmwLmCSXwx9MaCPFzV/dOOrju2
 xjO+2sYyB5BNtxRqUEyXglpujFZqJxxau7E0eXoYgoY9gtFGsspzFkVNntamVXEWVVgzJJr/EWW0y
 +jNd54MfPRqH+eCGuqlnNLktSAVz1MvVRY1dxUltSlDZT7P2bUoMorIPu8p7ZCg9dyX1+9T6Muc5d
 Hxf/BBP/ir+3e8JTFQBFOiLNdFtB9KZWZmIExheXRvbiA8amxheXRvbkBzYW1iYS5vcmc+iQI4BBM
 BAgAiBQJOldK9AhsDBgsJCAcDAgYVCAIJCgsEFgIDAQIeAQIXgAAKCRAADmhBGVaCFWgWD/0ZRi4h
 N9FK2BdQs9RwNnFZUr7JidAWfCrs37XrA/56olQl3ojn0fQtrP4DbTmCuh0SfMijB24psy1GnkPep
 naQ6VRf7Dxg/Y8muZELSOtsv2CKt3/02J1BBitrkkqmHyni5fLLYYg6fub0T/8Kwo1qGPdu1hx2BQ
 RERYtQ/S5d/T0cACdlzi6w8rs5f09hU9Tu4qV1JLKmBTgUWKN969HPRkxiojLQziHVyM/weR5Reu6
 FZVNuVBGqBD+sfk/c98VJHjsQhYJijcsmgMb1NohAzwrBKcSGKOWJToGEO/1RkIN8tqGnYNp2G+aR
 685D0chgTl1WzPRM6mFG1+n2b2RR95DxumKVpwBwdLPoCkI24JkeDJ7lXSe3uFWISstFGt0HL8Eew
 P8RuGC8s5h7Ct91HMNQTbjgA+Vi1foWUVXpEintAKgoywaIDlJfTZIl6Ew8ETN/7DLy8bXYgq0Xzh
 aKg3CnOUuGQV5/nl4OAX/3jocT5Cz/OtAiNYj5mLPeL5z2ZszjoCAH6caqsF2oLyAnLqRgDgR+wTQ
 T6gMhr2IRsl+cp8gPHBwQ4uZMb+X00c/Amm9VfviT+BI7B66cnC7Zv6Gvmtu2rEjWDGWPqUgccB7h
 dMKnKDthkA227/82tYoFiFMb/NwtgGrn5n2vwJyKN6SEoygGrNt0SI84y6hEVbQlSmVmZiBMYXl0b
 24gPGpsYXl0b25AcHJpbWFyeWRhdGEuY29tPokCOQQTAQIAIwUCU4xmKQIbAwcLCQgHAwIBBhUIAg
 kKCwQWAgMBAh4BAheAAAoJEAAOaEEZVoIV1H0P/j4OUTwFd7BBbpoSp695qb6HqCzWMuExsp8nZjr
 uymMaeZbGr3OWMNEXRI1FWNHMtcMHWLP/RaDqCJil28proO+PQ/yPhsr2QqJcW4nr91tBrv/MqItu
 AXLYlsgXqp4BxLP67bzRJ1Bd2x0bWXurpEXY//VBOLnODqThGEcL7jouwjmnRh9FTKZfBDpFRaEfD
 FOXIfAkMKBa/c9TQwRpx2DPsl3eFWVCNuNGKeGsirLqCxUg5kWTxEorROppz9oU4HPicL6rRH22Ce
 6nOAON2vHvhkUuO3GbffhrcsPD4DaYup4ic+DxWm+DaSSRJ+e1yJvwi6NmQ9P9UAuLG93S2MdNNbo
 sZ9P8k2mTOVKMc+GooI9Ve/vH8unwitwo7ORMVXhJeU6Q0X7zf3SjwDq2lBhn1DSuTsn2DbsNTiDv
 qrAaCvbsTsw+SZRwF85eG67eAwouYk+dnKmp1q57LDKMyzysij2oDKbcBlwB/TeX16p8+LxECv51a
 sjS9TInnipssssUDrHIvoTTXWcz7Y5wIngxDFwT8rPY3EggzLGfK5Zx2Q5S/N0FfmADmKknG/D8qG
 IcJE574D956tiUDKN4I+/g125ORR1v7bP+OIaayAvq17RP+qcAqkxc0x8iCYVCYDouDyNvWPGRhbL
 UO7mlBpjW9jK9e2fvZY9iw3QzIPGKtClKZWZmIExheXRvbiA8amVmZi5sYXl0b25AcHJpbWFyeWRh
 dGEuY29tPokCOQQTAQIAIwUCU4xmUAIbAwcLCQgHAwIBBhUIAgkKCwQWAgMBAh4BAheAAAoJEAAOa
 EEZVoIVzJoQALFCS6n/FHQS+hIzHIb56JbokhK0AFqoLVzLKzrnaeXhE5isWcVg0eoV2oTScIwUSU
 apy94if69tnUo4Q7YNt8/6yFM6hwZAxFjOXR0ciGE3Q+Z1zi49Ox51yjGMQGxlakV9ep4sV/d5a50
 M+LFTmYSAFp6HY23JN9PkjVJC4PUv5DYRbOZ6Y1+TfXKBAewMVqtwT1Y+LPlfmI8dbbbuUX/kKZ5d
 dhV2736fgyfpslvJKYl0YifUOVy4D1G/oSycyHkJG78OvX4JKcf2kKzVvg7/Rnv+AueCfFQ6nGwPn
 0P91I7TEOC4XfZ6a1K3uTp4fPPs1Wn75X7K8lzJP/p8lme40uqwAyBjk+IA5VGd+CVRiyJTpGZwA0
 jwSYLyXboX+Dqm9pSYzmC9+/AE7lIgpWj+3iNisp1SWtHc4pdtQ5EU2SEz8yKvDbD0lNDbv4ljI7e
 flPsvN6vOrxz24mCliEco5DwhpaaSnzWnbAPXhQDWb/lUgs/JNk8dtwmvWnqCwRqElMLVisAbJmC0
 BhZ/Ab4sph3EaiZfdXKhiQqSGdK4La3OTJOJYZphPdGgnkvDV9Pl1QZ0ijXQrVIy3zd6VCNaKYq7B
 AKidn5g/2Q8oio9Tf4XfdZ9dtwcB+bwDJFgvvDYaZ5bI3ln4V3EyW5i2NfXazz/GA/I/ZtbsigCFc
 8ftCBKZWZmIExheXRvbiA8amxheXRvbkBrZXJuZWwub3JnPokCOAQTAQIAIgUCWe8u6AIbAwYLCQg
 HAwIGFQgCCQoLBBYCAwECHgECF4AACgkQAA5oQRlWghUuCg/+Lb/xGxZD2Q1oJVAE37uW308UpVSD
 2tAMJUvFTdDbfe3zKlPDTuVsyNsALBGclPLagJ5ZTP+Vp2irAN9uwBuacBOTtmOdz4ZN2tdvNgozz
 uxp4CHBDVzAslUi2idy+xpsp47DWPxYFIRP3M8QG/aNW052LaPc0cedYxp8+9eiVUNpxF4SiU4i9J
 DfX/sn9XcfoVZIxMpCRE750zvJvcCUz9HojsrMQ1NFc7MFT1z3MOW2/RlzPcog7xvR5ENPH19ojRD
 CHqumUHRry+RF0lH00clzX/W8OrQJZtoBPXv9ahka/Vp7kEulcBJr1cH5Wz/WprhsIM7U9pse1f1g
 Yy9YbXtWctUz8uvDR7shsQxAhX3qO7DilMtuGo1v97I/Kx4gXQ52syh/w6EBny71CZrOgD6kJwPVV
 AaM1LRC28muq91WCFhs/nzHozpbzcheyGtMUI2Ao4K6mnY+3zIuXPygZMFr9KXE6fF7HzKxKuZMJO
 aEZCiDOq0anx6FmOzs5E6Jqdpo/mtI8beK+BE7Va6ni7YrQlnT0i3vaTVMTiCThbqsB20VrbMjlhp
 f8lfK1XVNbRq/R7GZ9zHESlsa35ha60yd/j3pu5hT2xyy8krV8vGhHvnJ1XRMJBAB/UYb6FyC7S+m
 QZIQXVeAA+smfTT0tDrisj1U5x6ZB9b3nBg65kc=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-1.fc40) 
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2024-08-21 at 10:38 -0400, Chuck Lever wrote:
> On Wed, Aug 21, 2024 at 10:22:15AM -0400, Jeff Layton wrote:
> > On Tue, 2024-08-20 at 10:46 -0400, cel@kernel.org=C2=A0wrote:
> > > From: Chuck Lever <chuck.lever@oracle.com>
> > >=20
> > > Build an NFSv4 protocol snippet to support the delstid
> > > extensions.
> > > The new fs/nfsd/nfs4_1.x file can be added to over time as other
> > > parts of NFSD's XDR functions are converted to machine-generated
> > > code.
> > >=20
> > > Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
> > > ---
> > > =C2=A0fs/nfsd/nfs4_1.x=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 164 ++++++++++=
+++++++++++++++++++
> > > =C2=A0fs/nfsd/nfs4xdr_gen.c | 236
> > > ++++++++++++++++++++++++++++++++++++++++++
> > > =C2=A0fs/nfsd/nfs4xdr_gen.h | 113 ++++++++++++++++++++
> > > =C2=A03 files changed, 513 insertions(+)
> > > =C2=A0create mode 100644 fs/nfsd/nfs4_1.x
> > > =C2=A0create mode 100644 fs/nfsd/nfs4xdr_gen.c
> > > =C2=A0create mode 100644 fs/nfsd/nfs4xdr_gen.h
> > >=20
> >=20
> > I see the patches in your lkxdrgen branch. I gave this a try and
> > started rebasing my delstid work on top of it, but I hit the same
> > symbol conflicts I hit before once I started trying to include the
> > full-blown nfs4xdr_gen.h header:
> >=20
> > ------------------------8<---------------------------
> > In file included from fs/nfsd/nfs4xdr.c:58:
> > fs/nfsd/nfs4xdr_gen.h:86:9: error: redeclaration of enumerator
> > =E2=80=98FATTR4_OPEN_ARGUMENTS=E2=80=99
> > =C2=A0=C2=A0 86 |=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 FATTR=
4_OPEN_ARGUMENTS =3D 86
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 ^~~~~~~~~~~~~~~~~~~~~
> > In file included from fs/nfsd/nfsfh.h:15,
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 from fs/nfsd/state.h:41,
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 from fs/nfsd/xdr4.h:40,
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 from fs/nfsd/nfs4xdr.c:51:
> > ./include/linux/nfs4.h:518:9: note: previous definition of
> > =E2=80=98FATTR4_OPEN_ARGUMENTS=E2=80=99 with type =E2=80=98enum <anonym=
ous>=E2=80=99
> > =C2=A0 518 |=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 FATTR4_OPE=
N_ARGUMENTS=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =3D=
 86,
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 ^~~~~~~~~~~~~~~~~~~~~
> > fs/nfsd/nfs4xdr_gen.h:102:9: error: redeclaration of enumerator
> > =E2=80=98FATTR4_TIME_DELEG_ACCESS=E2=80=99
> > =C2=A0 102 |=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 FATTR4_TIM=
E_DELEG_ACCESS =3D 84
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 ^~~~~~~~~~~~~~~~~~~~~~~~
> > ./include/linux/nfs4.h:516:9: note: previous definition of
> > =E2=80=98FATTR4_TIME_DELEG_ACCESS=E2=80=99 with type =E2=80=98enum <ano=
nymous>=E2=80=99
> > =C2=A0 516 |=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 FATTR4_TIM=
E_DELEG_ACCESS=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =3D 84,
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 ^~~~~~~~~~~~~~~~~~~~~~~~
> > fs/nfsd/nfs4xdr_gen.h:106:9: error: redeclaration of enumerator
> > =E2=80=98FATTR4_TIME_DELEG_MODIFY=E2=80=99
> > =C2=A0 106 |=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 FATTR4_TIM=
E_DELEG_MODIFY =3D 85
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 ^~~~~~~~~~~~~~~~~~~~~~~~
> > ./include/linux/nfs4.h:517:9: note: previous definition of
> > =E2=80=98FATTR4_TIME_DELEG_MODIFY=E2=80=99 with type =E2=80=98enum <ano=
nymous>=E2=80=99
> > =C2=A0 517 |=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 FATTR4_TIM=
E_DELEG_MODIFY=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =3D 85,
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 ^~~~~~~~~~~~~~~~~~~~~~~~
> > ------------------------8<---------------------------
> >=20
> > I'm not sure of the best way to work around this, unless we want to
> > try
> > to split up nfs4.h.
>=20
> That header is shared with the client, so I consider it immutable
> for our purposes here.
>=20
>
> One option would be to namespace the generated data items. Eg, name
> them:
>=20
> 	XG_FATTR4_TIME_DELEG_ACCESS
> 	XG_FATTR4_TIME_DELEG_MODIFY
>=20
> That way they don't conflict with existing definitions.
>=20

I'd rather avoid that if we can. Having things named exactly the same
as in the spec makes the code easier to read and understand.

What might be best is to autogenerate a header from a (combined)
nfs4.x, and then have the old nfs4.h file include it. Then we'd just
have to eliminate anything from nfs4.h that conflicts with the
autogenerated symbols.

That's definitely not treating include/linux/nfs4.h as immutable, but
we might still be able to avoid a lot of changes to the client code
that way.

We'd need Trond and Anna to buy in on that though.

>=20
> > Also, as a side note:
> >=20
> > fs/nfsd/nfs4xdr.c: In function
> > =E2=80=98nfsd4_encode_fattr4_open_arguments=E2=80=99:
> > fs/nfsd/nfs4xdr.c:3446:55: error: incompatible type for argument 2
> > of =E2=80=98xdrgen_encode_fattr4_open_arguments=E2=80=99
> > =C2=A03446 |=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (!xdrge=
n_encode_fattr4_open_arguments(xdr,
> > &nfsd_open_arguments))
> >=20
> >=20
> > OPEN_ARGUMENTS4 is a large structure with 5 different bitmaps in
> > it. We
> > probably don't want to pass that by value. When the tool is dealing
> > with a struct, we should have it generate functions that take a
> > pointer
> > instead (IMO).
>=20
> The decoders are passed structs by reference already, fwiw. I had
> been considering the same for the encoder functions, for efficiency.
> I can give it a try.
>=20

Sounds good.
--=20
Jeff Layton <jlayton@kernel.org>


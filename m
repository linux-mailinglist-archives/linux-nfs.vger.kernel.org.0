Return-Path: <linux-nfs+bounces-3283-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2199B8C951B
	for <lists+linux-nfs@lfdr.de>; Sun, 19 May 2024 16:58:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9666B1F210A6
	for <lists+linux-nfs@lfdr.de>; Sun, 19 May 2024 14:58:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 874F34AEE3;
	Sun, 19 May 2024 14:58:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nQfKDUYO"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61439481AA
	for <linux-nfs@vger.kernel.org>; Sun, 19 May 2024 14:58:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716130697; cv=none; b=q/pR8Ss6/JyQe0y0J1VoYU1EIjONueVf5RSAgT4zsCJ5iNZi82WMWsZ6HNTX9dZRItZFkTFtjiYfKLSStu3jPByyOuMvyh0IAwHBtJCwGhjYl9vRgLUMD6Ljw1fB4WvwnWZKqT7IWsFPr+kod6iLW5UvuOCBopc1j+TsowYwQos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716130697; c=relaxed/simple;
	bh=6q1g09AK3qVNmiQzWvhSFFthSNvY60683ZrF9cuFKNk=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=bRunC6XxKcuuOxwyORqgJuQqiPBxUXTkfjp5BwHTchXE0vOkdVmowFVvvJaWvsK2klqh4sZrVRAxHmESy4bJWLmf9NkEf5xGjTHB3GoiSybEVs1d0bSmj034VVaNza8v9E1fBsgueMKQmqdgxojl8Cya8kyVPubYJH+0Ib4+9Fo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nQfKDUYO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F45DC32781;
	Sun, 19 May 2024 14:58:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716130696;
	bh=6q1g09AK3qVNmiQzWvhSFFthSNvY60683ZrF9cuFKNk=;
	h=Subject:From:To:Date:In-Reply-To:References:From;
	b=nQfKDUYO56U/Rhu5el0Ub/KX+JvhH6J9Juwx/UMeSB3zDSC0aTqKxtwNAZ5TWyF6t
	 CANzCzeSRxr3iP7fxSk5IUgXTN0DWSG/uKejOFMfVWkxM6mbyRt0Qm/ODylgN/OW8t
	 ZHTF1gJFM2PkXApjLqakJ4tunCOudmZTtJheE++yOOodqmnK9Hjzzkw7KBXssBM8Vn
	 p8IR3G9jPy2//j7PiLoV31HxdP4MVm+6qfWwg4dJWkyHYTuOlPkd3YIzhAuhh0snfV
	 MKY7op80G96GAU5PD9tLWBlX7JGooGQocKOneQ7ARgh4/U3T0tl9JkL4N4gsZfgcv4
	 j2LRHnljS4Zyg==
Message-ID: <0309145a87db46a4e56b83d64d2f5273990a08d7.camel@kernel.org>
Subject: Re: [BUG] Linux 6.8.10 NPE
From: Jeff Layton <jlayton@kernel.org>
To: Chris Rankin <rankincj@gmail.com>, Chuck Lever <chuck.lever@oracle.com>,
  linux-nfs@vger.kernel.org
Date: Sun, 19 May 2024 10:58:15 -0400
In-Reply-To: <CAK2bqVJ+GgWtjvy4wGzGqAvwoCrH2Hmo6W5oT6wu_0LXzUV3VA@mail.gmail.com>
References: 
	<CAK2bqVJoT3yy2m0OmTnqH9EAKkj6O1iTk42EyyMtvvxKh6YDKg@mail.gmail.com>
	 <CAK2bqV+FA-bcBXeOAT93Y=-6fyXOP38yoYgH_4O+waygWLbnEg@mail.gmail.com>
	 <CAK2bqVJ+GgWtjvy4wGzGqAvwoCrH2Hmo6W5oT6wu_0LXzUV3VA@mail.gmail.com>
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
User-Agent: Evolution 3.52.1 (3.52.1-1.fc40app1) 
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Sun, 2024-05-19 at 14:15 +0100, Chris Rankin wrote:
> FWIW the problem appears to be with linux-6.8/fs/nfsd/stats.c#L38:
>=20
>         struct nfsd_net *nn =3D net_generic(net, nfsd_net_id);
>=20
> although the value of the "net" variable looks reasonable.
>=20
> Cheers,
> Chris
>=20
> On Sun, 19 May 2024 at 13:26, Chris Rankin <rankincj@gmail.com> wrote:
> >=20
> > Hi,
> >=20
> > CC after emailing both linux-kernel and stable.
> >=20
> > Cheers,
> > Chris
> >=20
> > ---------- Forwarded message ---------
> > From: Chris Rankin <rankincj@gmail.com>
> > Date: Sat, 18 May 2024 at 13:53
> > Subject: [BUG] Linux 6.8.10 NPE
> > To: LKML <linux-kernel@vger.kernel.org>, Linux Stable <stable@vger.kern=
el.org>
> >=20
> > Hi,
> >=20
> > I am using vanilla Linux 6.8.10, and I've just noticed this BUG in my
> > dmesg log. I have no idea what triggered it, and especially since I
> > have not even mounted any NFS filesystems?!
> >=20
> > Cheers,
> > Chris
> >=20
> > [ 9114.607417] BUG: kernel NULL pointer dereference, address: 000000000=
0000068
> > [ 9114.613082] #PF: supervisor read access in kernel mode
> > [ 9114.616929] #PF: error_code(0x0000) - not-present page
> > [ 9114.620775] PGD 0 P4D 0
> > [ 9114.622013] Oops: 0000 [#16] PREEMPT SMP PTI
> > [ 9114.624987] CPU: 2 PID: 16501 Comm: sadc Tainted: G      D   I
> >   6.8.10 #1
> > [ 9114.630993] Hardware name: Gigabyte Technology Co., Ltd.
> > EX58-UD3R/EX58-UD3R, BIOS FB  05/04/2009
> > [ 9114.638561] RIP: 0010:nfsd_show+0x39/0x18e [nfsd]
> > [ 9114.642026] Code: fb 48 83 ec 10 48 8b 47 70 8b 2d 34 9b 03 00 48
> > 8b 80 b0 00 00 00 4c 8b a0 60 02 00 00 e8 99 84 f2 df 49 8b 84 24 f8
> > 0b 00 00 <48> 8b 2c e8 e8 6d c0 f2 df 48 8d bd 00 03 00 00 e8 8f ff ff
> > ff 48
> > [ 9114.659472] RSP: 0018:ffffc9000b1afcf8 EFLAGS: 00010202
> > [ 9114.663405] RAX: 0000000000000000 RBX: ffff88810cd5de80 RCX: 0000000=
000001000
> > [ 9114.669239] RDX: ffff88813f45b900 RSI: 0000000000000001 RDI: ffff888=
10cd5de80
> > [ 9114.675069] RBP: 000000000000000d R08: 0000000000400cc0 R09: 0000000=
0ffffffff
> > [ 9114.680905] R10: 0000000000000000 R11: 0000000000000000 R12: fffffff=
fa11e51e0
> > [ 9114.686737] R13: ffffc9000b1afef8 R14: ffff88810cd5de80 R15: fffffff=
f81a2a520
> > [ 9114.692586] FS:  00007f3637e49740(0000) GS:ffff888343c80000(0000)
> > knlGS:0000000000000000
> > [ 9114.699370] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > [ 9114.703809] CR2: 0000000000000068 CR3: 000000027a18c000 CR4: 0000000=
0000006f0
> > [ 9114.709642] Call Trace:
> > [ 9114.710798]  <TASK>
> > [ 9114.711602]  ? __die_body+0x1a/0x5c
> > [ 9114.713802]  ? page_fault_oops+0x321/0x36e
> > [ 9114.716636]  ? exc_page_fault+0x105/0x117
> > [ 9114.719348]  ? asm_exc_page_fault+0x22/0x30
> > [ 9114.722237]  ? nfsd_show+0x39/0x18e [nfsd]
> > [ 9114.725103]  ? nfsd_show+0x31/0x18e [nfsd]
> > [ 9114.727954]  seq_read_iter+0x171/0x353
> > [ 9114.730410]  seq_read+0xe0/0x108
> > [ 9114.732350]  ? startup_64+0x1/0x60
> > [ 9114.734458]  proc_reg_read+0x8c/0xa7
> > [ 9114.736746]  vfs_read+0xa6/0x1bf
> > [ 9114.738685]  ? __do_sys_newfstat+0x34/0x5c
> > [ 9114.741486]  ksys_read+0x74/0xc0
> > [ 9114.743418]  do_syscall_64+0x6c/0xdc
> > [ 9114.745695]  entry_SYSCALL_64_after_hwframe+0x60/0x68
> > [ 9114.749449] RIP: 0033:0x7f3638039cc1
> > [ 9114.751752] Code: 00 48 8b 15 59 81 0d 00 f7 d8 64 89 02 b8 ff ff
> > ff ff eb bd e8 b0 aa 01 00 f3 0f 1e fa 80 3d 85 03 0e 00 00 74 13 31
> > c0 0f 05 <48> 3d 00 f0 ff ff 77 4f c3 66 0f 1f 44 00 00 55 48 89 e5 48
> > 83 ec
> > [ 9114.769198] RSP: 002b:00007ffec523c288 EFLAGS: 00000246 ORIG_RAX:
> > 0000000000000000
> > [ 9114.775499] RAX: ffffffffffffffda RBX: 000055619e0982e0 RCX: 00007f3=
638039cc1
> > [ 9114.781332] RDX: 0000000000000400 RSI: 000055619e0a3b70 RDI: 0000000=
000000004
> > [ 9114.787166] RBP: 00007ffec523c2c0 R08: 0000000000000001 R09: 0000000=
000000000
> > [ 9114.792997] R10: 0000000000000000 R11: 0000000000000246 R12: 00007f3=
638111050
> > [ 9114.798830] R13: 00007f3638110f00 R14: 0000000000000000 R15: 0000556=
19e0982e0
> > [ 9114.804668]  </TASK>
> > [ 9114.805559] Modules linked in: udf usb_storage snd_seq_dummy
> > rpcrdma rdma_cm iw_cm ib_cm ib_core nf_nat_ftp nf_conntrack_ftp
> > cfg80211 af_packet nf_conntrack_netbios_ns nf_conntrack_broadcast
> > nft_fib_inet nft_fib_ipv4 nft_fib_ipv6 nft_fib nft_reject_inet
> > nf_reject_ipv4 nf_reject_ipv6 nft_reject nft_ct nft_chain_nat
> > nf_tables ebtable_nat ebtable_broute ip6table_nat ip6table_mangle
> > ip6table_raw ip6table_security iptable_nat nf_nat nf_conntrack
> > nf_defrag_ipv6 nf_defrag_ipv4 libcrc32c iptable_mangle iptable_raw
> > iptable_security ebtable_filter ebtables ip6table_filter ip6_tables
> > iptable_filter ip_tables x_tables it87 hwmon_vid bnep binfmt_misc
> > snd_hda_codec_realtek snd_hda_codec_generic snd_hda_codec_hdmi
> > snd_hda_intel uvcvideo btusb uvc btintel btbcm videobuf2_vmalloc
> > snd_intel_dspcfg videobuf2_memops bluetooth videobuf2_v4l2
> > snd_hda_codec videodev snd_usb_audio intel_powerclamp coretemp
> > snd_virtuoso snd_hda_core kvm_intel snd_oxygen_lib videobuf2_common
> > ecdh_generic snd_usbmidi_lib snd_mpu401_uart snd_hwdep mc snd_rawmidi
> > [ 9114.805644]  input_leds joydev led_class snd_seq rfkill kvm ecc
> > snd_seq_device gpio_ich pktcdvd snd_pcm iTCO_wdt r8169 irqbypass
> > i2c_i801 snd_hrtimer realtek snd_timer mdio_devres intel_cstate snd
> > libphy acpi_cpufreq i2c_smbus pcspkr intel_uncore psmouse lpc_ich
> > i7core_edac mxm_wmi soundcore tiny_power_button button nfsd
> > auth_rpcgss nfs_acl lockd grace sunrpc dm_mod loop fuse dax configfs
> > nfnetlink zram zsmalloc ext4 crc32c_generic crc16 mbcache jbd2 amdgpu
> > video amdxcp i2c_algo_bit mfd_core drm_ttm_helper ttm hid_microsoft
> > drm_exec gpu_sched drm_suballoc_helper drm_buddy drm_display_helper
> > sr_mod usbhid sd_mod cdrom drm_kms_helper ahci pata_jmicron libahci
> > drm uhci_hcd libata ehci_pci ehci_hcd xhci_pci firewire_ohci xhci_hcd
> > firewire_core scsi_mod crc32c_intel sha512_ssse3 usbcore
> > drm_panel_orientation_quirks sha256_ssse3 cec serio_raw sha1_ssse3
> > rc_core crc_itu_t bsg usb_common scsi_common wmi msr [last unloaded:
> > sg]
> > [ 9114.974386] CR2: 0000000000000068
> > [ 9114.976469] ---[ end trace 0000000000000000 ]---
> > [ 9114.979859] RIP: 0010:nfsd_show+0x39/0x18e [nfsd]
> > [ 9114.983413] Code: fb 48 83 ec 10 48 8b 47 70 8b 2d 34 9b 03 00 48
> > 8b 80 b0 00 00 00 4c 8b a0 60 02 00 00 e8 99 84 f2 df 49 8b 84 24 f8
> > 0b 00 00 <48> 8b 2c e8 e8 6d c0 f2 df 48 8d bd 00 03 00 00 e8 8f ff ff
> > ff 48
> > [ 9115.000909] RSP: 0018:ffffc90002edfcf8 EFLAGS: 00010202
> > [ 9115.004850] RAX: 0000000000000000 RBX: ffff88813fee9780 RCX: 0000000=
000001000
> > [ 9115.010725] RDX: ffff88810b474740 RSI: 0000000000000001 RDI: ffff888=
13fee9780
> > [ 9115.016621] RBP: 000000000000000d R08: 0000000000400cc0 R09: 0000000=
0ffffffff
> > [ 9115.022507] R10: 0000000000000000 R11: 0000000000000000 R12: fffffff=
fa11e51e0
> > [ 9115.028414] R13: ffffc90002edfef8 R14: ffff88813fee9780 R15: fffffff=
f81a2a520
> > [ 9115.034338] FS:  00007f3637e49740(0000) GS:ffff888343c00000(0000)
> > knlGS:0000000000000000
> > [ 9115.041191] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > [ 9115.045739] CR2: 00007f7171a17ef0 CR3: 000000027a18c000 CR4: 0000000=
0000006f0


Can you run faddr2line against that kmod and tell us where it failed?
Something like this, with a non-stripped kmod:

    $ scripts/faddr2line --list fs/nfsd/nfsd.ko nfsd_show+0x39/0x18e

Thanks,
--=20
Jeff Layton <jlayton@kernel.org>


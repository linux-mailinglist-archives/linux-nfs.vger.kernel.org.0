Return-Path: <linux-nfs+bounces-9830-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 27EE4A24F04
	for <lists+linux-nfs@lfdr.de>; Sun,  2 Feb 2025 17:52:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7A4E5162A5D
	for <lists+linux-nfs@lfdr.de>; Sun,  2 Feb 2025 16:52:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B043439ACC;
	Sun,  2 Feb 2025 16:51:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cKE0IsZR"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88BE738F83
	for <linux-nfs@vger.kernel.org>; Sun,  2 Feb 2025 16:51:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738515118; cv=none; b=HuObdkUhzWRrch2him1iU6ItMJbbtyo57ownL55Y1YWZ1EuLzuMcVMt0i0dVf9otecAt3HoVMmySvy899qRniobSKY71zA+e8SglRO1SOPmD+iaiyC3UkxCz0xRcSVAaT2Ei1k1iNWYLVHNAz5fpY76y6X/o511ijnNls6O5mkI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738515118; c=relaxed/simple;
	bh=7Ka3xyVhJxvOR9J81xINVqabJAfTLsOXMsG3NJcRx5g=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=KqC54w7G0JgxJx8qQHCAJ7Y34gsiloDhF56MbWcn2WbjneHBGitkuU79G88xDhHXgDtIRHDoXZD/luDqt8XuAG4K3ofTY813hXMiEwAtO7IIAUl++rN14fEMYfplEpeq3wkyuWT46n7BIoII7ttVnwMXSJNIJ1vvJwDZ8teF/Ns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cKE0IsZR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63B5DC4CED1;
	Sun,  2 Feb 2025 16:51:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738515118;
	bh=7Ka3xyVhJxvOR9J81xINVqabJAfTLsOXMsG3NJcRx5g=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=cKE0IsZRMDOOqViQqg4/79HmVjiNXH6Huke2lLTTRHKExVRlmDGq2MOahlIH8AcRN
	 BxtAIRIPJ7sPVprovjqm5srvVywsDHOvKIEVTu6cOy4FleI3I16tJ7I6BqL0KfnbVE
	 u1WMBQDOqfouuSYDy7kQ9sTVc02szG8MfZJvRT02fFzoPfKBo2qN/F5oo4VxWKLwtS
	 qdt4TZ7loV8xMhrSImXg4iR1IYBgGCJ0oQQQmfOdgUKw92QcE0281AnhR3KnAp8Eu2
	 apNK7NDpnkl6mKaUm8k91Nekbs1m2z3lEvRZzoBds1wFQt4Bs2PW9QbLzMnT6YlOK6
	 IQUWJMOhaQPMw==
Message-ID: <747af7d6caf2ac79d828b8299e0db23c5a1824b2.camel@kernel.org>
Subject: Re: `rcu: INFO: rcu_sched self-detected stall on CPU` and spinning
 kworker `rpciod`
From: Jeff Layton <jlayton@kernel.org>
To: Chuck Lever <chuck.lever@oracle.com>, Salvatore Bonaccorso
	 <carnil@debian.org>
Cc: Paul Menzel <pmenzel@molgen.mpg.de>, Linux NFS Mailing List
	 <linux-nfs@vger.kernel.org>, "it+linux-nfs@molgen.mpg.de"
	 <it+linux-nfs@molgen.mpg.de>
Date: Sun, 02 Feb 2025 11:51:56 -0500
In-Reply-To: <196a87b2-94ce-46bc-b6a0-c9c65f4ab34c@oracle.com>
References: <76a841e5-4e3d-4942-9a4b-24f87d6b79a5@molgen.mpg.de>
	 <ZqVjVEV5IF_vz4Eq@eldamar.lan>
	 <47222A7B-6B89-4260-AA16-EA7E7EAFBD68@oracle.com>
	 <ZqjaX_uJqsJiCpam@eldamar.lan>
	 <7ccb2a39-bb32-47f8-8366-b4d09895593f@molgen.mpg.de>
	 <ZsBhuwLnejLo6iip@eldamar.lan>
	 <6BEEE588-B7B0-40C0-BE91-4919A71ED052@oracle.com>
	 <Z5z3hBaZtUM0BQ1H@eldamar.lan> <Z590k-vpFiGl0OOZ@eldamar.lan>
	 <196a87b2-94ce-46bc-b6a0-c9c65f4ab34c@oracle.com>
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
User-Agent: Evolution 3.54.3 (3.54.3-1.fc41) 
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Sun, 2025-02-02 at 11:18 -0500, Chuck Lever wrote:
> On 2/2/25 8:35 AM, Salvatore Bonaccorso wrote:
> > Hi Chuck,
> >=20
> > On Fri, Jan 31, 2025 at 05:17:08PM +0100, Salvatore Bonaccorso wrote:
> > > Hi Chuck,
> > >=20
> > > On Sat, Aug 17, 2024 at 02:52:38PM +0000, Chuck Lever III wrote:
> > > >=20
> > > >=20
> > > > > On Aug 17, 2024, at 4:39=E2=80=AFAM, Salvatore Bonaccorso <carnil=
@debian.org> wrote:
> > > > >=20
> > > > > Hi,
> > > > >=20
> > > > > On Tue, Jul 30, 2024 at 02:52:47PM +0200, Paul Menzel wrote:
> > > > > > Dear Salvatore, dear Chuck,
> > > > > >=20
> > > > > >=20
> > > > > > Thank you for your messages.
> > > > > >=20
> > > > > >=20
> > > > > > Am 30.07.24 um 14:19 schrieb Salvatore Bonaccorso:
> > > > > >=20
> > > > > > > On Sat, Jul 27, 2024 at 09:19:24PM +0000, Chuck Lever III wro=
te:
> > > > > > > >=20
> > > > > > > > > On Jul 27, 2024, at 5:15=E2=80=AFPM, Salvatore Bonaccorso=
 <carnil@debian.org> wrote:
> > > > > >=20
> > > > > > > > > On Wed, Jul 17, 2024 at 07:33:24AM +0200, Paul Menzel wro=
te:
> > > > > >=20
> > > > > > > > > > Using Linux 5.15.160 on a Dell PowerEdge T440/021KCD, B=
IOS 2.11.2
> > > > > > > > > > 04/22/2021, a mount from another server hung. Linux log=
s:
> > > > > > > > > >=20
> > > > > > > > > > ```
> > > > > > > > > > $ dmesg -T
> > > > > > > > > > [Wed Jul  3 16:39:34 2024] Linux version 5.15.160.mx64.=
476(root@theinternet.molgen.mpg.de) (gcc (GCC) 12.3.0, GNU ld (GNU Binutils=
) 2.41) #1 SMP Wed Jun 5 12:24:15 CEST 2024
> > > > > > > > > > [Wed Jul  3 16:39:34 2024] Command line: root=3DLABEL=
=3Droot ro crashkernel=3D64G-:256M console=3DttyS0,115200n8 console=3Dtty0 =
init=3D/bin/systemd audit=3D0 random.trust_cpu=3Don systemd.unified_cgroup_=
hierarchy
> > > > > > > > > > [=E2=80=A6]
> > > > > > > > > > [Wed Jul  3 16:39:34 2024] DMI: Dell Inc. PowerEdge T44=
0/021KCD, BIOS 2.11.2 04/22/2021
> > > > > > > > > > [=E2=80=A6]
> > > > > > > > > > [Tue Jul 16 06:00:10 2024] md: md3: data-check interrup=
ted.
> > > > > > > > > > [Tue Jul 16 11:06:01 2024] receive_cb_reply: Got unreco=
gnized reply: calldir 0x1 xpt_bc_xprt 00000000ee580afa xid 6890a3d2
> > > > > > > > > > [Tue Jul 16 11:06:01 2024] receive_cb_reply: Got unreco=
gnized reply: calldir 0x1 xpt_bc_xprt 00000000d4d84570 xid 3ca4017a
> > > > > >=20
> > > > > > [=E2=80=A6]
> > > > > >=20
> > > > > > > > > > [Tue Jul 16 11:35:59 2024] receive_cb_reply: Got unreco=
gnized reply: calldir 0x1 xpt_bc_xprt 0000000028481e8f xid b682b676
> > > > > > > > > > [Tue Jul 16 11:35:59 2024] receive_cb_reply: Got unreco=
gnized reply: calldir 0x1 xpt_bc_xprt 00000000c384ff38 xid b5d5dbf5
> > > > > > > > > > [Tue Jul 16 11:36:40 2024] rcu: INFO: rcu_sched self-de=
tected stall on CPU
> > > > > > > > > > [Tue Jul 16 11:36:40 2024] rcu:  13-....: (20997 ticks =
this GP) idle=3D54f/1/0x4000000000000000 softirq=3D31904928/31904928 fqs=3D=
4433
> > > > > > > > > > [Tue Jul 16 11:36:40 2024]  (t=3D21017 jiffies g=3D1949=
58993 q=3D5715)
> > > > > > > > > > [Tue Jul 16 11:36:40 2024] Task dump for CPU 13:
> > > > > > > > > > [Tue Jul 16 11:36:40 2024] task:kworker/u34:2   state:R=
  running task stack:    0 pid:30413 ppid:     2 flags:0x00004008
> > > > > > > > > > [Tue Jul 16 11:36:40 2024] Workqueue: rpciod rpc_async_=
schedule [sunrpc]
> > > > > > > > > > [Tue Jul 16 11:36:40 2024] Call Trace:
> > > > > > > > > > [Tue Jul 16 11:36:40 2024]  <IRQ>
> > > > > > > > > > [Tue Jul 16 11:36:40 2024]  sched_show_task.cold+0xc2/0=
xda
> > > > > > > > > > [Tue Jul 16 11:36:40 2024]  rcu_dump_cpu_stacks+0xa1/0x=
d3
> > > > > > > > > > [Tue Jul 16 11:36:40 2024]  rcu_sched_clock_irq.cold+0x=
c7/0x1e7
> > > > > > > > > > [Tue Jul 16 11:36:40 2024]  ? trigger_load_balance+0x6d=
/0x300
> > > > > > > > > > [Tue Jul 16 11:36:40 2024]  ? scheduler_tick+0xda/0x260
> > > > > > > > > > [Tue Jul 16 11:36:40 2024]  update_process_times+0xa1/0=
xe0
> > > > > > > > > > [Tue Jul 16 11:36:40 2024]  tick_sched_timer+0x8e/0xa0
> > > > > > > > > > [Tue Jul 16 11:36:40 2024]  ? tick_sched_do_timer+0x90/=
0x90
> > > > > > > > > > [Tue Jul 16 11:36:40 2024]  __hrtimer_run_queues+0x139/=
0x2a0
> > > > > > > > > > [Tue Jul 16 11:36:40 2024]  hrtimer_interrupt+0xf4/0x21=
0
> > > > > > > > > > [Tue Jul 16 11:36:40 2024]  __sysvec_apic_timer_interru=
pt+0x5f/0xe0
> > > > > > > > > > [Tue Jul 16 11:36:40 2024]  sysvec_apic_timer_interrupt=
+0x69/0x90
> > > > > > > > > > [Tue Jul 16 11:36:40 2024]  </IRQ>
> > > > > > > > > > [Tue Jul 16 11:36:40 2024]  <TASK>
> > > > > > > > > > [Tue Jul 16 11:36:40 2024]  asm_sysvec_apic_timer_inter=
rupt+0x16/0x20
> > > > > > > > > > [Tue Jul 16 11:36:40 2024] RIP: 0010:read_tsc+0x3/0x20
> > > > > > > > > > [Tue Jul 16 11:36:40 2024] Code: cc cc cc cc cc cc cc 8=
b 05 56 ab 72 01 c3 cc cc cc cc 0f 1f 44 00 00 c3 cc cc cc cc 66 66 2e 0f 1=
f 84 00 00 00 00 00 0f 01 f9 <66> 90 48 c1 e2 20 48 09 d0 c3 cc cc cc cc 66=
 66 2e 0f 1f 84 00 00
> > > > > > > > > > [Tue Jul 16 11:36:40 2024] RSP: 0018:ffffc900087cfe00 E=
FLAGS: 00000246
> > > > > > > > > > [Tue Jul 16 11:36:40 2024] RAX: 00000000226dc8b8 RBX: 0=
00000003f3c079e RCX: 000000000000100d
> > > > > > > > > > [Tue Jul 16 11:36:40 2024] RDX: 00000000004535c4 RSI: 0=
000000000000046 RDI: ffffffff82435600
> > > > > > > > > > [Tue Jul 16 11:36:40 2024] RBP: 0003ed08d3641da3 R08: f=
fffffffa012c770 R09: ffffffffa012c788
> > > > > > > > > > [Tue Jul 16 11:36:40 2024] R10: 0000000000000003 R11: 0=
000000000000283 R12: 0000000000000000
> > > > > > > > > > [Tue Jul 16 11:36:40 2024] R13: 0000000000000001 R14: f=
fff88909311c000 R15: ffff88909311c005
> > > > > > > > > > [Tue Jul 16 11:36:40 2024]  ktime_get+0x38/0xa0
> > > > > > > > > > [Tue Jul 16 11:36:40 2024]  ? rpc_sleep_on_priority+0x7=
0/0x70 [sunrpc]
> > > > > > > > > > [Tue Jul 16 11:36:40 2024]  rpc_exit_task+0x9a/0x100 [s=
unrpc]
> > > > > > > > > > [Tue Jul 16 11:36:40 2024]  __rpc_execute+0x6e/0x410 [s=
unrpc]
> > > > > > > > > > [Tue Jul 16 11:36:40 2024]  rpc_async_schedule+0x29/0x4=
0 [sunrpc]
> > > > > > > > > > [Tue Jul 16 11:36:40 2024]  process_one_work+0x1d7/0x3a=
0
> > > > > > > > > > [Tue Jul 16 11:36:40 2024]  worker_thread+0x4a/0x3c0
> > > > > > > > > > [Tue Jul 16 11:36:40 2024]  ? process_one_work+0x3a0/0x=
3a0
> > > > > > > > > > [Tue Jul 16 11:36:40 2024]  kthread+0x115/0x140
> > > > > > > > > > [Tue Jul 16 11:36:40 2024]  ? set_kthread_struct+0x50/0=
x50
> > > > > > > > > > [Tue Jul 16 11:36:40 2024]  ret_from_fork+0x1f/0x30
> > > > > > > > > > [Tue Jul 16 11:36:40 2024]  </TASK>
> > > > > > > > > > [Tue Jul 16 11:37:19 2024] rcu: INFO: rcu_sched self-de=
tected stall on CPU
> > > > > > > > > > [Tue Jul 16 11:37:19 2024] rcu:  7-....: (21000 ticks t=
his GP) idle=3D5b1/1/0x4000000000000000 softirq=3D29984492/29984492 fqs=3D5=
159
> > > > > > > > > > [Tue Jul 16 11:37:19 2024]  (t=3D21017 jiffies g=3D1949=
59001 q=3D2008)
> > > > > > > > > > [Tue Jul 16 11:37:19 2024] Task dump for CPU 7:
> > > > > > > > > > [Tue Jul 16 11:37:19 2024] task:kworker/u34:2   state:R=
  running task stack:    0 pid:30413 ppid:     2 flags:0x00004008
> > > > > > > > > > [Tue Jul 16 11:37:19 2024] Workqueue: rpciod rpc_async_=
schedule [sunrpc]
> > > > > > > > > > [Tue Jul 16 11:37:19 2024] Call Trace:
> > > > > > > > > > [Tue Jul 16 11:37:19 2024]  <IRQ>
> > > > > > > > > > [Tue Jul 16 11:37:19 2024]  sched_show_task.cold+0xc2/0=
xda
> > > > > > > > > > [Tue Jul 16 11:37:19 2024]  rcu_dump_cpu_stacks+0xa1/0x=
d3
> > > > > > > > > > [Tue Jul 16 11:37:19 2024]  rcu_sched_clock_irq.cold+0x=
c7/0x1e7
> > > > > > > > > > [Tue Jul 16 11:37:19 2024]  ? trigger_load_balance+0x6d=
/0x300
> > > > > > > > > > [Tue Jul 16 11:37:19 2024]  ? scheduler_tick+0xda/0x260
> > > > > > > > > > [Tue Jul 16 11:37:19 2024]  update_process_times+0xa1/0=
xe0
> > > > > > > > > > [Tue Jul 16 11:37:19 2024]  tick_sched_timer+0x8e/0xa0
> > > > > > > > > > [Tue Jul 16 11:37:19 2024]  ? tick_sched_do_timer+0x90/=
0x90
> > > > > > > > > > [Tue Jul 16 11:37:19 2024]  __hrtimer_run_queues+0x139/=
0x2a0
> > > > > > > > > > [Tue Jul 16 11:37:19 2024]  hrtimer_interrupt+0xf4/0x21=
0
> > > > > > > > > > [Tue Jul 16 11:37:19 2024]  __sysvec_apic_timer_interru=
pt+0x5f/0xe0
> > > > > > > > > > [Tue Jul 16 11:37:19 2024]  sysvec_apic_timer_interrupt=
+0x69/0x90
> > > > > > > > > > [Tue Jul 16 11:37:19 2024]  </IRQ>
> > > > > > > > > > [Tue Jul 16 11:37:19 2024]  <TASK>
> > > > > > > > > > [Tue Jul 16 11:37:19 2024]  asm_sysvec_apic_timer_inter=
rupt+0x16/0x20
> > > > > > > > > > [Tue Jul 16 11:37:19 2024] RIP: 0010:_raw_spin_lock+0x1=
0/0x20
> > > > > > > > > > [Tue Jul 16 11:37:19 2024] Code: b8 00 02 00 00 f0 0f c=
1 07 a9 ff 01 00 00 75 05 c3 cc cc cc cc e9 f0 05 59 ff 0f 1f 44 00 00 31 c=
0 ba 01 00 00 00 f0 0f b1 17 <75> 05 c3 cc cc cc cc 89 c6 e9 62 02 59 ff 66=
 90 0f 1f 44 00 00 fa
> > > > > > > > > > [Tue Jul 16 11:37:19 2024] RSP: 0018:ffffc900087cfe30 E=
FLAGS: 00000246
> > > > > > > > > > [Tue Jul 16 11:37:19 2024] RAX: 0000000000000000 RBX: f=
fff88997131a500 RCX: 0000000000000001
> > > > > > > > > > [Tue Jul 16 11:37:19 2024] RDX: 0000000000000001 RSI: f=
fff88997131a500 RDI: ffffffffa012c700
> > > > > > > > > > [Tue Jul 16 11:37:19 2024] RBP: ffffffffa012c700 R08: f=
fffffffa012c770 R09: ffffffffa012c788
> > > > > > > > > > [Tue Jul 16 11:37:19 2024] R10: 0000000000000003 R11: 0=
000000000000283 R12: ffff88997131a530
> > > > > > > > > > [Tue Jul 16 11:37:19 2024] R13: 0000000000000001 R14: f=
fff88909311c000 R15: ffff88909311c005
> > > > > > > > > > [Tue Jul 16 11:37:19 2024]  __rpc_execute+0x95/0x410 [s=
unrpc]
> > > > > > > > > > [Tue Jul 16 11:37:19 2024]  rpc_async_schedule+0x29/0x4=
0 [sunrpc]
> > > > > > > > > > [Tue Jul 16 11:37:19 2024]  process_one_work+0x1d7/0x3a=
0
> > > > > > > > > > [Tue Jul 16 11:37:19 2024]  worker_thread+0x4a/0x3c0
> > > > > > > > > > [Tue Jul 16 11:37:19 2024]  ? process_one_work+0x3a0/0x=
3a0
> > > > > > > > > > [Tue Jul 16 11:37:19 2024]  kthread+0x115/0x140
> > > > > > > > > > [Tue Jul 16 11:37:19 2024]  ? set_kthread_struct+0x50/0=
x50
> > > > > > > > > > [Tue Jul 16 11:37:19 2024]  ret_from_fork+0x1f/0x30
> > > > > > > > > > [Tue Jul 16 11:37:19 2024]  </TASK>
> > > > > > > > > > [Tue Jul 16 11:37:57 2024] rcu: INFO: rcu_sched self-de=
tected stall on CPU
> > > > > > > > > > [=E2=80=A6]
> > > > > > > > > > ```
> > > > > > > > >=20
> > > > > > > > > FWIW, on one NFS server occurence we are seeing something=
 very close
> > > > > > > > > to the above but in the 5.10.y case for the Debian kernel=
 after
> > > > > > > > > updating to 5.10.218-1 to 5.10.221-1, so kernel after whi=
ch had the
> > > > > > > > > big NFS related stack backported.
> > > > > > > > >=20
> > > > > > > > > One backtrace we were able to catch was
> > > > > > > > >=20
> > > > > > > > > [...]
> > > > > > > > > Jul 27 15:24:52 nfsserver kernel: receive_cb_reply: Got u=
nrecognized reply: calldir 0x1 xpt_bc_xprt 000000003d26f7ec xid b172e1c6
> > > > > > > > > Jul 27 15:24:52 nfsserver kernel: receive_cb_reply: Got u=
nrecognized reply: calldir 0x1 xpt_bc_xprt 0000000017f1552a xid a90d7751
> > > > > > > > > Jul 27 15:24:52 nfsserver kernel: receive_cb_reply: Got u=
nrecognized reply: calldir 0x1 xpt_bc_xprt 000000006337c521 xid 8e5e58bd
> > > > > > > > > Jul 27 15:24:54 nfsserver kernel: receive_cb_reply: Got u=
nrecognized reply: calldir 0x1 xpt_bc_xprt 00000000cbf89319 xid c2da3c73
> > > > > > > > > Jul 27 15:24:54 nfsserver kernel: receive_cb_reply: Got u=
nrecognized reply: calldir 0x1 xpt_bc_xprt 00000000e2588a21 xid a01bfec6
> > > > > > > > > Jul 27 15:24:54 nfsserver kernel: receive_cb_reply: Got u=
nrecognized reply: calldir 0x1 xpt_bc_xprt 000000005fda63ca xid c2eeeaa6
> > > > > > > > > [...]
> > > > > > > > > Jul 27 15:25:15 nfsserver kernel: rcu: INFO: rcu_sched se=
lf-detected stall on CPU
> > > > > > > > > Jul 27 15:25:15 nfsserver kernel: rcu:         15-....: (=
5250 ticks this GP) idle=3D74e/1/0x4000000000000000 softirq=3D3160997/31610=
06 fqs=3D2233
> > > > > > > > > Jul 27 15:25:15 nfsserver kernel:         (t=3D5255 jiffi=
es g=3D8381377 q=3D106333)
> > > > > > > > > Jul 27 15:25:15 nfsserver kernel: NMI backtrace for cpu 1=
5
> > > > > > > > > Jul 27 15:25:15 nfsserver kernel: CPU: 15 PID: 3725556 Co=
mm: kworker/u42:4 Not tainted 5.10.0-31-amd64 #1 Debian 5.10.221-1
> > > > > > > > > Jul 27 15:25:15 nfsserver kernel: Hardware name: DALCO AG=
 S2600WFT/S2600WFT, BIOS SE5C620.86B.02.01.0008.031920191559 03/19/2019
> > > > > > > > > Jul 27 15:25:15 nfsserver kernel: Workqueue: rpciod rpc_a=
sync_schedule [sunrpc]
> > > > > > > > > Jul 27 15:25:15 nfsserver kernel: Call Trace:
> > > > > > > > > Jul 27 15:25:15 nfsserver kernel:  <IRQ>
> > > > > > > > > Jul 27 15:25:15 nfsserver kernel:  dump_stack+0x6b/0x83
> > > > > > > > > Jul 27 15:25:15 nfsserver kernel:  nmi_cpu_backtrace.cold=
+0x32/0x69
> > > > > > > > > Jul 27 15:25:15 nfsserver kernel:  ? lapic_can_unplug_cpu=
+0x80/0x80
> > > > > > > > > Jul 27 15:25:15 nfsserver kernel:  nmi_trigger_cpumask_ba=
cktrace+0xdf/0xf0
> > > > > > > > > Jul 27 15:25:15 nfsserver kernel:  rcu_dump_cpu_stacks+0x=
a5/0xd7
> > > > > > > > > Jul 27 15:25:15 nfsserver kernel:  rcu_sched_clock_irq.co=
ld+0x202/0x3d9
> > > > > > > > > Jul 27 15:25:15 nfsserver kernel:  ? trigger_load_balance=
+0x5a/0x220
> > > > > > > > > Jul 27 15:25:15 nfsserver kernel:  update_process_times+0=
x8c/0xc0
> > > > > > > > > Jul 27 15:25:15 nfsserver kernel:  tick_sched_handle+0x22=
/0x60
> > > > > > > > > Jul 27 15:25:15 nfsserver kernel:  tick_sched_timer+0x65/=
0x80
> > > > > > > > > Jul 27 15:25:15 nfsserver kernel:  ? tick_sched_do_timer+=
0x90/0x90
> > > > > > > > > Jul 27 15:25:15 nfsserver kernel:  __hrtimer_run_queues+0=
x127/0x280
> > > > > > > > > Jul 27 15:25:15 nfsserver kernel:  hrtimer_interrupt+0x11=
0/0x2c0
> > > > > > > > > Jul 27 15:25:15 nfsserver kernel:  __sysvec_apic_timer_in=
terrupt+0x5c/0xe0
> > > > > > > > > Jul 27 15:25:15 nfsserver kernel:  asm_call_irq_on_stack+=
0xf/0x20
> > > > > > > > > Jul 27 15:25:15 nfsserver kernel:  </IRQ>
> > > > > > > > > Jul 27 15:25:15 nfsserver kernel:  sysvec_apic_timer_inte=
rrupt+0x72/0x80
> > > > > > > > > Jul 27 15:25:15 nfsserver kernel:  asm_sysvec_apic_timer_=
interrupt+0x12/0x20
> > > > > > > > > Jul 27 15:25:15 nfsserver kernel: RIP: 0010:mod_delayed_w=
ork_on+0x5d/0x90
> > > > > > > > > Jul 27 15:25:15 nfsserver kernel: Code: 00 4c 89 e7 e8 34=
 fe ff ff 89 c3 83 f8 f5 74 e9 85 c0 78 1b 89 ef 4c 89 f1 4c 89 e2 4c 89 ee=
 e8 f9 fc ff ff 48 8b 3c 24 57 9d <0f> 1f 44 >
> > > > > > > > > Jul 27 15:25:15 nfsserver kernel: RSP: 0018:ffffb5efe356f=
d90 EFLAGS: 00000246
> > > > > > > > > Jul 27 15:25:15 nfsserver kernel: RAX: 0000000000000000 R=
BX: 0000000000000000 RCX: 000000003820000f
> > > > > > > > > Jul 27 15:25:15 nfsserver kernel: RDX: 0000000038000000 R=
SI: 0000000000000046 RDI: 0000000000000246
> > > > > > > > > Jul 27 15:25:15 nfsserver kernel: RBP: 0000000000002000 R=
08: ffffffffc0884430 R09: ffffffffc0884448
> > > > > > > > > Jul 27 15:25:15 nfsserver kernel: R10: 0000000000000003 R=
11: 0000000000000003 R12: ffffffffc0884428
> > > > > > > > > Jul 27 15:25:15 nfsserver kernel: R13: ffff8c89d0f6b800 R=
14: 00000000000001f4 R15: 0000000000000000
> > > > > > > > > Jul 27 15:25:15 nfsserver kernel:  __rpc_sleep_on_priorit=
y_timeout+0x111/0x120 [sunrpc]
> > > > > > > > > Jul 27 15:25:15 nfsserver kernel:  rpc_delay+0x56/0x90 [s=
unrpc]
> > > > > > > > > Jul 27 15:25:15 nfsserver kernel:  rpc_exit_task+0x5a/0x1=
40 [sunrpc]
> > > > > > > > > Jul 27 15:25:15 nfsserver kernel:  ? __rpc_do_wake_up_tas=
k_on_wq+0x1e0/0x1e0 [sunrpc]
> > > > > > > > > Jul 27 15:25:15 nfsserver kernel:  __rpc_execute+0x6d/0x4=
10 [sunrpc]
> > > > > > > > > Jul 27 15:25:15 nfsserver kernel:  rpc_async_schedule+0x2=
9/0x40 [sunrpc]
> > > > > > > > > Jul 27 15:25:15 nfsserver kernel:  process_one_work+0x1b3=
/0x350
> > > > > > > > > Jul 27 15:25:15 nfsserver kernel:  worker_thread+0x53/0x3=
e0
> > > > > > > > > Jul 27 15:25:15 nfsserver kernel:  ? process_one_work+0x3=
50/0x350
> > > > > > > > > Jul 27 15:25:15 nfsserver kernel:  kthread+0x118/0x140
> > > > > > > > > Jul 27 15:25:15 nfsserver kernel:  ? __kthread_bind_mask+=
0x60/0x60
> > > > > > > > > Jul 27 15:25:15 nfsserver kernel:  ret_from_fork+0x1f/0x3=
0
> > > > > > > > > [...]
> > > > > > > > >=20
> > > > > > > > > Is there anything which could help debug this issue?
> > > > > > > >=20
> > > > > > > > The backtrace suggests an issue in the RPC client code; the
> > > > > > > > server's NFSv4.1 backchannel would use that to send callbac=
ks.
> > > > > > > >=20
> > > > > > > > Since 5.10.218 and 5.10.221 are only about a thousand commi=
ts
> > > > > > > > apart, a bisect should be quick and narrow down the issue t=
o
> > > > > > > > one or two commits.
> > > > > > >=20
> > > > > > > Yes indeed. Unfortunately was yet unable to reproduce the iss=
ue in
> > > > > > > more syntentic way on test environment, and the affected serv=
er in
> > > > > > > particular is a production system.
> > > > > > >=20
> > > > > > > Paul, is your case in some way reproducible in a testing envi=
ronment
> > > > > > > so that a bisection might be give enough hints on the problem=
?
> > > > > > We hit this issue once more on the same server with Linux 5.15.=
160, and had
> > > > > > to hard reboot it.
> > > > > >=20
> > > > > > Unfortunately we did not have time yet to set up a test system =
to find a
> > > > > > reproducer. In our cases a lot of compute servers seem to have =
accessed the
> > > > > > NFS server. A lot of the many processes were `zstd` on a first =
glance.
> > > > >=20
> > > > > So we neither, due to the nature of the server (production system=
) and
> > > > > unability to reproduce the issue under some more controlled way a=
nd on
> > > > > test environment.
> > > > >=20
> > > > > In our case users seems to cause workloads involving use of wandb=
.
> > > > >=20
> > > > > What we tried is to boot the recent kernel from 5.10.y series ava=
iable
> > > > > (5.10.223-1). Then the issue showed up still. Since we disabled
> > > > > fs.leases-enable the situation seems to be more stable). While th=
is
> > > > > is/might not be the solution, does that gives some additional hit=
s?
> > > >=20
> > > > The problem is backchannel-related, and disabling delegation
> > > > will reduce the number of backchannel operations. Your finding
> > > > comports with our current theory, but I can't think of how it
> > > > narrows the field of suspects.
> > > >=20
> > > > Is the server running short on memory, perhaps? One backchannel
> > > > operation that was added in v5.10.220 is CB_RECALL_ANY, which
> > > > is triggered on memory exhaustion. But that should be a fairly
> > > > harmless addition unless there is a bug in there somewhere.
> > > >=20
> > > > If your NFS server does not have any NFS mounts, then we could
> > > > provide instructions for enabling client-side tracing to watch
> > > > the details of callback traffic.
> > >=20
> > > The NFS server acts as well as NFS client, so tracing more
> > > back-channel related will I guess just load the tracing more.
> > >=20
> > > But we got "lucky" and we were able to trigger the issue twice in las=
t
> > > days, once NFSv4 delegations were enabled again and some users starte=
d
> > > to cause more load on the specific server as well.
> > >=20
> > > I did issue=20
> > >=20
> > > 	rpcdebug -m rpc -c
> > >=20
> > > before rebooting/resetting the server  which is
> > >=20
> > > Jan 30 05:27:05 nfsserver kernel: 26407 2281   -512 3d1fdb92        0=
        0 79bc1aa5 nfs4_cbv1 CB_RECALL_ANY a:rpc_exit_task [sunrpc] q:delay=
q
> > >=20
> > > and the first RPC related soft lookup slapt in the log/journal I was
> > > able to gather is:
> > >=20
> > > Jan 29 22:34:05 nfsserver kernel: watchdog: BUG: soft lockup - CPU#11=
 stuck for 23s! [kworker/u42:3:705574]
> > > Jan 29 22:34:05 nfsserver kernel: Modules linked in: binfmt_misc rpcs=
ec_gss_krb5 nfsv4 dns_resolver nfs fscache bonding quota_v2 quota_tree ipmi=
_ssif intel_rapl_msr intel_rapl_common skx_edac skx_edac_common nfit libnvd=
imm x86_pkg_temp_thermal intel_powerclamp coretemp kvm_intel kvm irqbypass =
ghash_clmulni_intel aesni_intel libaes crypto_simd cryptd ast glue_helper d=
rm_vram_helper drm_ttm_helper rapl acpi_ipmi ttm iTCO_wdt intel_cstate ipmi=
_si intel_pmc_bxt drm_kms_helper mei_me iTCO_vendor_support ipmi_devintf ce=
c ioatdma intel_uncore pcspkr evdev joydev sg i2c_algo_bit watchdog mei dca=
 ipmi_msghandler acpi_power_meter acpi_pad button fuse drm configfs nfsd au=
th_rpcgss nfs_acl lockd grace sunrpc ip_tables x_tables autofs4 ext4 crc16 =
mbcache jbd2 raid10 raid456 async_raid6_recov async_memcpy async_pq async_x=
or async_tx xor raid6_pq libcrc32c crc32c_generic raid1 raid0 multipath lin=
ear md_mod dm_mod hid_generic usbhid hid sd_mod t10_pi crc_t10dif crct10dif=
_generic xhci_pci ahci xhci_hcd libahci i40e libata
> > > Jan 29 22:34:05 nfsserver kernel:  crct10dif_pclmul arcmsr crct10dif_=
common ptp crc32_pclmul usbcore crc32c_intel scsi_mod pps_core i2c_i801 lpc=
_ich i2c_smbus wmi usb_common
> > > Jan 29 22:34:05 nfsserver kernel: CPU: 11 PID: 705574 Comm: kworker/u=
42:3 Not tainted 5.10.0-33-amd64 #1 Debian 5.10.226-1
> > > Jan 29 22:34:05 nfsserver kernel: Hardware name: DALCO AG S2600WFT/S2=
600WFT, BIOS SE5C620.86B.02.01.0008.031920191559 03/19/2019
> > > Jan 29 22:34:05 nfsserver kernel: Workqueue: rpciod rpc_async_schedul=
e [sunrpc]
> > > Jan 29 22:34:05 nfsserver kernel: RIP: 0010:ktime_get+0x7b/0xa0
> > > Jan 29 22:34:05 nfsserver kernel: Code: d1 e9 48 f7 d1 48 89 c2 48 85=
 c1 8b 05 ae 2c a5 02 8b 0d ac 2c a5 02 48 0f 45 d5 8b 35 7e 2c a5 02 41 39=
 f4 75 9e 48 0f af c2 <48> 01 f8 48 d3 e8 48 01 d8 5b 5d 41 5c c3 cc cc cc =
cc f3 90 eb 84
> > > Jan 29 22:34:05 nfsserver kernel: RSP: 0018:ffffa1aca9227e00 EFLAGS: =
00000202
> > > Jan 29 22:34:05 nfsserver kernel: RAX: 0000371a545e1910 RBX: 000005fc=
e82a4372 RCX: 0000000000000018
> > > Jan 29 22:34:05 nfsserver kernel: RDX: 000000000078efbe RSI: 00000000=
0031f238 RDI: 00385c1353c92824
> > > Jan 29 22:34:05 nfsserver kernel: RBP: 0000000000000000 R08: ffffffff=
c081f410 R09: ffffffffc081f410
> > > Jan 29 22:34:05 nfsserver kernel: R10: 0000000000000003 R11: 00000000=
00000003 R12: 000000000031f238
> > > Jan 29 22:34:05 nfsserver kernel: R13: ffff8ed42bf34830 R14: 00000000=
00000001 R15: 0000000000000000
> > > Jan 29 22:34:05 nfsserver kernel: FS:  0000000000000000(0000) GS:ffff=
8ee94f880000(0000) knlGS:0000000000000000
> > > Jan 29 22:34:05 nfsserver kernel: CS:  0010 DS: 0000 ES: 0000 CR0: 00=
00000080050033
> > > Jan 29 22:34:05 nfsserver kernel: CR2: 00007ffddf306080 CR3: 00000017=
c420a002 CR4: 00000000007706e0
> > > Jan 29 22:34:05 nfsserver kernel: DR0: 0000000000000000 DR1: 00000000=
00000000 DR2: 0000000000000000
> > > Jan 29 22:34:05 nfsserver kernel: DR3: 0000000000000000 DR6: 00000000=
fffe0ff0 DR7: 0000000000000400
> > > Jan 29 22:34:05 nfsserver kernel: PKRU: 55555554
> > > Jan 29 22:34:05 nfsserver kernel: Call Trace:
> > > Jan 29 22:34:05 nfsserver kernel:  <IRQ>
> > > Jan 29 22:34:05 nfsserver kernel:  ? watchdog_timer_fn+0x1bb/0x210
> > > Jan 29 22:34:05 nfsserver kernel:  ? lockup_detector_update_enable+0x=
50/0x50
> > > Jan 29 22:34:05 nfsserver kernel:  ? __hrtimer_run_queues+0x127/0x280
> > > Jan 29 22:34:05 nfsserver kernel:  ? hrtimer_interrupt+0x110/0x2c0
> > > Jan 29 22:34:05 nfsserver kernel:  ? __sysvec_apic_timer_interrupt+0x=
5c/0xe0
> > > Jan 29 22:34:05 nfsserver kernel:  ? asm_call_irq_on_stack+0xf/0x20
> > > Jan 29 22:34:05 nfsserver kernel:  </IRQ>
> > > Jan 29 22:34:05 nfsserver kernel:  ? sysvec_apic_timer_interrupt+0x72=
/0x80
> > > Jan 29 22:34:05 nfsserver kernel:  ? asm_sysvec_apic_timer_interrupt+=
0x12/0x20
> > > Jan 29 22:34:05 nfsserver kernel:  ? ktime_get+0x7b/0xa0
> > > Jan 29 22:34:05 nfsserver kernel:  rpc_exit_task+0x96/0x140 [sunrpc]
> > > Jan 29 22:34:05 nfsserver kernel:  ? __rpc_do_wake_up_task_on_wq+0x1e=
0/0x1e0 [sunrpc]
> > > Jan 29 22:34:05 nfsserver kernel:  __rpc_execute+0x6d/0x410 [sunrpc]
> > > Jan 29 22:34:05 nfsserver kernel:  rpc_async_schedule+0x29/0x40 [sunr=
pc]
> > > Jan 29 22:34:05 nfsserver kernel:  process_one_work+0x1b3/0x350
> > > Jan 29 22:34:05 nfsserver kernel:  worker_thread+0x53/0x3e0
> > > Jan 29 22:34:05 nfsserver kernel:  ? process_one_work+0x350/0x350
> > > Jan 29 22:34:05 nfsserver kernel:  kthread+0x118/0x140
> > > Jan 29 22:34:05 nfsserver kernel:  ? __kthread_bind_mask+0x60/0x60
> > > Jan 29 22:34:05 nfsserver kernel:  ret_from_fork+0x1f/0x30
> > >=20
> > > I can try to pick on top of the kernel the change Chuck mentioned to
> > > me offlist, which is the posting of
> > > https://lore.kernel.org/linux-nfs/1738271066-6727-1-git-send-email-da=
i.ngo@oracle.com/,
> > > and in fact this could be interesting. If the users keep doing the
> > > same kind of load, this might help understanding more the issue.
> > >=20
> > > As we suspect that the issue is more frequently triggered after the
> > > switch of 5.10.118 -> 5.10.221, this enforces more the above, which
> > > says it fixes 66af25799940 ("NFSD: add courteous server support for
> > > thread with only delegation"), which is in 5.19-rc1, but got
> > > backported to 5.15.154 and 5.10.220 as well.
> >=20
> > Unfortunately not. The system ran slightly more stable with that patch =
on, and
> > there was a nfsd hang inbeween here, within a series of=20
> >=20
> > [...]
> > Feb 02 03:22:40 nfsserver kernel: receive_cb_reply: Got unrecognized re=
ply: calldir 0x1 xpt_bc_xprt 00000000b31acdd9 xid 5d31fb84
> > Feb 02 03:22:40 nfsserver kernel: receive_cb_reply: Got unrecognized re=
ply: calldir 0x1 xpt_bc_xprt 00000000ca92d20a xid 9ec25b24
> > Feb 02 03:23:09 nfsserver kernel: receive_cb_reply: Got unrecognized re=
ply: calldir 0x1 xpt_bc_xprt 00000000ca92d20a xid 9fc25b24
> > Feb 02 03:23:12 nfsserver kernel: receive_cb_reply: Got unrecognized re=
ply: calldir 0x1 xpt_bc_xprt 00000000b31acdd9 xid 5e31fb84
> > Feb 02 03:23:24 nfsserver kernel: receive_cb_reply: Got unrecognized re=
ply: calldir 0x1 xpt_bc_xprt 00000000ca92d20a xid a0c25b24
> > Feb 02 03:23:24 nfsserver kernel: receive_cb_reply: Got unrecognized re=
ply: calldir 0x1 xpt_bc_xprt 00000000b31acdd9 xid 5f31fb84
> > Feb 02 03:23:31 nfsserver kernel: receive_cb_reply: Got unrecognized re=
ply: calldir 0x1 xpt_bc_xprt 00000000fe9013df xid 756103e9
> > Feb 02 03:23:31 nfsserver kernel: receive_cb_reply: Got unrecognized re=
ply: calldir 0x1 xpt_bc_xprt 00000000471650a0 xid ef4f583e
> > Feb 02 03:23:33 nfsserver kernel: receive_cb_reply: Got unrecognized re=
ply: calldir 0x1 xpt_bc_xprt 000000008f30d648 xid 1ec77a2e
> > Feb 02 03:23:35 nfsserver kernel: receive_cb_reply: Got unrecognized re=
ply: calldir 0x1 xpt_bc_xprt 0000000035c718f5 xid d0b95b44
> > Feb 02 03:27:43 nfsserver kernel: receive_cb_reply: Got unrecognized re=
ply: calldir 0x1 xpt_bc_xprt 00000000b31acdd9 xid 7d31fb84
> > Feb 02 03:27:44 nfsserver kernel: receive_cb_reply: Got unrecognized re=
ply: calldir 0x1 xpt_bc_xprt 00000000ca92d20a xid bec25b24
> > Feb 02 03:27:44 nfsserver kernel: receive_cb_reply: Got unrecognized re=
ply: calldir 0x1 xpt_bc_xprt 00000000f83dcedd xid e0be7eef
> > Feb 02 03:28:07 nfsserver kernel: receive_cb_reply: Got unrecognized re=
ply: calldir 0x1 xpt_bc_xprt 00000000ca92d20a xid bfc25b24
> > Feb 02 03:28:09 nfsserver kernel: receive_cb_reply: Got unrecognized re=
ply: calldir 0x1 xpt_bc_xprt 00000000f83dcedd xid e1be7eef
> > Feb 02 03:31:41 nfsserver kernel: receive_cb_reply: Got unrecognized re=
ply: calldir 0x1 xpt_bc_xprt 000000004563c9e7 xid f96ccce2
> > Feb 02 03:31:44 nfsserver kernel: receive_cb_reply: Got unrecognized re=
ply: calldir 0x1 xpt_bc_xprt 0000000035c718f5 xid 06ba5b44
> > Feb 02 03:31:49 nfsserver kernel: receive_cb_reply: Got unrecognized re=
ply: calldir 0x1 xpt_bc_xprt 00000000b31acdd9 xid 9531fb84
> > Feb 02 03:31:51 nfsserver kernel: receive_cb_reply: Got unrecognized re=
ply: calldir 0x1 xpt_bc_xprt 00000000f83dcedd xid f7be7eef
> > Feb 02 03:31:52 nfsserver kernel: receive_cb_reply: Got unrecognized re=
ply: calldir 0x1 xpt_bc_xprt 00000000471650a0 xid 2550583e
> > Feb 02 03:31:53 nfsserver kernel: receive_cb_reply: Got unrecognized re=
ply: calldir 0x1 xpt_bc_xprt 00000000ca92d20a xid d5c25b24
> > Feb 02 03:31:53 nfsserver kernel: receive_cb_reply: Got unrecognized re=
ply: calldir 0x1 xpt_bc_xprt 00000000fe9013df xid ab6103e9
> > Feb 02 03:31:53 nfsserver kernel: receive_cb_reply: Got unrecognized re=
ply: calldir 0x1 xpt_bc_xprt 000000004111342b xid 9da4f045
> > Feb 02 03:32:32 nfsserver kernel: receive_cb_reply: Got unrecognized re=
ply: calldir 0x1 xpt_bc_xprt 00000000ca92d20a xid d8c25b24
> > Feb 02 03:32:32 nfsserver kernel: receive_cb_reply: Got unrecognized re=
ply: calldir 0x1 xpt_bc_xprt 00000000f83dcedd xid fabe7eef
> > Feb 02 04:18:12 nfsserver kernel: receive_cb_reply: Got unrecognized re=
ply: calldir 0x1 xpt_bc_xprt 00000000ca92d20a xid a1c35b24
> > Feb 02 04:18:12 nfsserver kernel: receive_cb_reply: Got unrecognized re=
ply: calldir 0x1 xpt_bc_xprt 000000009715512e xid 29a849e3
> > Feb 02 04:18:13 nfsserver kernel: receive_cb_reply: Got unrecognized re=
ply: calldir 0x1 xpt_bc_xprt 00000000fe9013df xid 786203e9
> > Feb 02 04:18:13 nfsserver kernel: receive_cb_reply: Got unrecognized re=
ply: calldir 0x1 xpt_bc_xprt 00000000471650a0 xid f150583e
> > Feb 02 04:18:13 nfsserver kernel: receive_cb_reply: Got unrecognized re=
ply: calldir 0x1 xpt_bc_xprt 000000004563c9e7 xid c66dcce2
> > Feb 02 04:18:13 nfsserver kernel: receive_cb_reply: Got unrecognized re=
ply: calldir 0x1 xpt_bc_xprt 000000008f30d648 xid 21c87a2e
> > Feb 02 04:18:13 nfsserver kernel: receive_cb_reply: Got unrecognized re=
ply: calldir 0x1 xpt_bc_xprt 0000000053af79cb xid 49da29a2
> > Feb 02 04:18:13 nfsserver kernel: receive_cb_reply: Got unrecognized re=
ply: calldir 0x1 xpt_bc_xprt 00000000b31acdd9 xid 6132fb84
> > Feb 02 04:49:18 nfsserver kernel: receive_cb_reply: Got unrecognized re=
ply: calldir 0x1 xpt_bc_xprt 0000000035c718f5 xid 2ebb5b44
> > Feb 02 04:49:21 nfsserver kernel: receive_cb_reply: Got unrecognized re=
ply: calldir 0x1 xpt_bc_xprt 000000004563c9e7 xid 226ecce2
> > Feb 02 04:49:22 nfsserver kernel: receive_cb_reply: Got unrecognized re=
ply: calldir 0x1 xpt_bc_xprt 00000000ca92d20a xid fdc35b24
> > Feb 02 04:49:22 nfsserver kernel: receive_cb_reply: Got unrecognized re=
ply: calldir 0x1 xpt_bc_xprt 00000000f83dcedd xid 1fc07eef
> > Feb 02 05:01:25 nfsserver kernel: receive_cb_reply: Got unrecognized re=
ply: calldir 0x1 xpt_bc_xprt 00000000ca92d20a xid 25c45b24
> > Feb 02 05:09:27 nfsserver kernel: receive_cb_reply: Got unrecognized re=
ply: calldir 0x1 xpt_bc_xprt 00000000ca92d20a xid 51c45b24
> > [...]
> > Feb 02 05:34:46 nfsserver kernel: INFO: task nfsd:1590 blocked for more=
 than 120 seconds.
> > Feb 02 05:34:46 nfsserver kernel:       Tainted: G            E     5.1=
0.0-34-amd64 #1 Debian 5.10.228-1~test1
> > Feb 02 05:34:46 nfsserver kernel: "echo 0 > /proc/sys/kernel/hung_task_=
timeout_secs" disables this message.
> > Feb 02 05:34:46 nfsserver kernel: task:nfsd            state:D stack:  =
  0 pid: 1590 ppid:     2 flags:0x00004000
> > Feb 02 05:34:46 nfsserver kernel: Call Trace:
> > Feb 02 05:34:46 nfsserver kernel:  __schedule+0x282/0x870
> > Feb 02 05:34:46 nfsserver kernel:  ? rwsem_spin_on_owner+0x74/0xd0
> > Feb 02 05:34:46 nfsserver kernel:  schedule+0x46/0xb0
> > Feb 02 05:34:46 nfsserver kernel:  rwsem_down_write_slowpath+0x257/0x4d=
0
> > Feb 02 05:34:46 nfsserver kernel:  ? trace_call_bpf+0x76/0xe0
> > Feb 02 05:34:46 nfsserver kernel:  ? nfsd4_write+0x1/0x1a0 [nfsd]
> > Feb 02 05:34:46 nfsserver kernel:  ext4_buffered_write_iter+0x33/0x160 =
[ext4]
> > Feb 02 05:34:46 nfsserver kernel:  do_iter_readv_writev+0x14f/0x1b0
> > Feb 02 05:34:46 nfsserver kernel:  do_iter_write+0x80/0x1c0
> > Feb 02 05:34:46 nfsserver kernel:  nfsd_vfs_write+0x17f/0x680 [nfsd]
> > Feb 02 05:34:46 nfsserver kernel:  nfsd4_write+0xd0/0x1a0 [nfsd]
> > Feb 02 05:34:46 nfsserver kernel:  elfcorehdr_read+0x40/0x40
> > Feb 02 05:34:46 nfsserver kernel:  ? nfsd_dispatch+0x15b/0x250 [nfsd]
> > Feb 02 05:34:46 nfsserver kernel:  ? svc_process_common+0x3e1/0x6e0 [su=
nrpc]
> > Feb 02 05:34:46 nfsserver kernel:  ? nfsd_svc+0x390/0x390 [nfsd]
> > Feb 02 05:34:46 nfsserver kernel:  ? svc_process+0xb7/0xf0 [sunrpc]
> > Feb 02 05:34:46 nfsserver kernel:  ? nfsd+0x91/0xb0 [nfsd]
> > Feb 02 05:34:46 nfsserver kernel:  ? get_order+0x20/0x20 [nfsd]
> > Feb 02 05:34:46 nfsserver kernel:  ? kthread+0x118/0x140
> > Feb 02 05:34:46 nfsserver kernel:  ? __kthread_bind_mask+0x60/0x60
> > Feb 02 05:34:46 nfsserver kernel:  ? ret_from_fork+0x1f/0x30
> > Feb 02 05:34:46 nfsserver kernel: INFO: task nfsd:1599 blocked for more=
 than 120 seconds.
> > Feb 02 05:34:46 nfsserver kernel:       Tainted: G            E     5.1=
0.0-34-amd64 #1 Debian 5.10.228-1~test1
> > Feb 02 05:34:46 nfsserver kernel: "echo 0 > /proc/sys/kernel/hung_task_=
timeout_secs" disables this message.
> > Feb 02 05:34:46 nfsserver kernel: task:nfsd            state:D stack:  =
  0 pid: 1599 ppid:     2 flags:0x00004000
> > Feb 02 05:34:46 nfsserver kernel: Call Trace:
> > Feb 02 05:34:46 nfsserver kernel:  __schedule+0x282/0x870
> > Feb 02 05:34:46 nfsserver kernel:  ? rwsem_spin_on_owner+0x74/0xd0
> > Feb 02 05:34:46 nfsserver kernel:  schedule+0x46/0xb0
> > Feb 02 05:34:46 nfsserver kernel:  rwsem_down_write_slowpath+0x257/0x4d=
0
> > Feb 02 05:34:46 nfsserver kernel:  ? trace_call_bpf+0x76/0xe0
> > Feb 02 05:34:46 nfsserver kernel:  ? nfsd4_write+0x1/0x1a0 [nfsd]
> > Feb 02 05:34:46 nfsserver kernel:  ext4_buffered_write_iter+0x33/0x160 =
[ext4]
> > Feb 02 05:34:46 nfsserver kernel:  do_iter_readv_writev+0x14f/0x1b0
> > Feb 02 05:34:46 nfsserver kernel:  do_iter_write+0x80/0x1c0
> > Feb 02 05:34:46 nfsserver kernel:  nfsd_vfs_write+0x17f/0x680 [nfsd]
> > Feb 02 05:34:46 nfsserver kernel:  nfsd4_write+0xd0/0x1a0 [nfsd]
> > Feb 02 05:34:46 nfsserver kernel:  elfcorehdr_read+0x40/0x40
> > Feb 02 05:34:46 nfsserver kernel:  ? nfsd_dispatch+0x15b/0x250 [nfsd]
> > Feb 02 05:34:46 nfsserver kernel:  ? svc_process_common+0x3e1/0x6e0 [su=
nrpc]
> > Feb 02 05:34:46 nfsserver kernel:  ? nfsd_svc+0x390/0x390 [nfsd]
> > Feb 02 05:34:46 nfsserver kernel:  ? svc_process+0xb7/0xf0 [sunrpc]
> > Feb 02 05:34:46 nfsserver kernel:  ? nfsd+0x91/0xb0 [nfsd]
> > Feb 02 05:34:46 nfsserver kernel:  ? get_order+0x20/0x20 [nfsd]
> > Feb 02 05:34:46 nfsserver kernel:  ? kthread+0x118/0x140
> > Feb 02 05:34:46 nfsserver kernel:  ? __kthread_bind_mask+0x60/0x60
> > Feb 02 05:34:46 nfsserver kernel:  ? ret_from_fork+0x1f/0x30
> > Feb 02 05:34:46 nfsserver kernel: INFO: task nfsd:1601 blocked for more=
 than 121 seconds.
> > Feb 02 05:34:46 nfsserver kernel:       Tainted: G            E     5.1=
0.0-34-amd64 #1 Debian 5.10.228-1~test1
> > Feb 02 05:34:46 nfsserver kernel: "echo 0 > /proc/sys/kernel/hung_task_=
timeout_secs" disables this message.
> > Feb 02 05:34:46 nfsserver kernel: task:nfsd            state:D stack:  =
  0 pid: 1601 ppid:     2 flags:0x00004000
> > Feb 02 05:34:46 nfsserver kernel: Call Trace:
> > Feb 02 05:34:46 nfsserver kernel:  __schedule+0x282/0x870
> > Feb 02 05:34:46 nfsserver kernel:  ? rwsem_spin_on_owner+0x74/0xd0
> > Feb 02 05:34:46 nfsserver kernel:  schedule+0x46/0xb0
> > Feb 02 05:34:47 nfsserver kernel:  rwsem_down_write_slowpath+0x257/0x4d=
0
> > Feb 02 05:34:47 nfsserver kernel:  ? trace_call_bpf+0x76/0xe0
> > Feb 02 05:34:47 nfsserver kernel:  ? nfsd4_write+0x1/0x1a0 [nfsd]
> > Feb 02 05:34:47 nfsserver kernel:  ext4_buffered_write_iter+0x33/0x160 =
[ext4]
> > Feb 02 05:34:47 nfsserver kernel:  do_iter_readv_writev+0x14f/0x1b0
> > Feb 02 05:34:47 nfsserver kernel:  do_iter_write+0x80/0x1c0
> > Feb 02 05:34:47 nfsserver kernel:  nfsd_vfs_write+0x17f/0x680 [nfsd]
> > Feb 02 05:34:47 nfsserver kernel:  nfsd4_write+0xd0/0x1a0 [nfsd]
> > Feb 02 05:34:47 nfsserver kernel:  elfcorehdr_read+0x40/0x40
> > Feb 02 05:34:47 nfsserver kernel:  ? nfsd_dispatch+0x15b/0x250 [nfsd]
> > Feb 02 05:34:47 nfsserver kernel:  ? svc_process_common+0x3e1/0x6e0 [su=
nrpc]
> > Feb 02 05:34:47 nfsserver kernel:  ? nfsd_svc+0x390/0x390 [nfsd]
> > Feb 02 05:34:47 nfsserver kernel:  ? svc_process+0xb7/0xf0 [sunrpc]
> > Feb 02 05:34:47 nfsserver kernel:  ? nfsd+0x91/0xb0 [nfsd]
> > Feb 02 05:34:47 nfsserver kernel:  ? get_order+0x20/0x20 [nfsd]
> > Feb 02 05:34:47 nfsserver kernel:  ? kthread+0x118/0x140
> > Feb 02 05:34:47 nfsserver kernel:  ? __kthread_bind_mask+0x60/0x60
> > Feb 02 05:34:47 nfsserver kernel:  ? ret_from_fork+0x1f/0x30
> > Feb 02 05:34:47 nfsserver kernel: INFO: task nfsd:1604 blocked for more=
 than 121 seconds.
> > Feb 02 05:34:47 nfsserver kernel:       Tainted: G            E     5.1=
0.0-34-amd64 #1 Debian 5.10.228-1~test1
> > Feb 02 05:34:47 nfsserver kernel: "echo 0 > /proc/sys/kernel/hung_task_=
timeout_secs" disables this message.
> > Feb 02 05:34:47 nfsserver kernel: task:nfsd            state:D stack:  =
  0 pid: 1604 ppid:     2 flags:0x00004000
> > Feb 02 05:34:47 nfsserver kernel: Call Trace:
> > Feb 02 05:34:47 nfsserver kernel:  __schedule+0x282/0x870
> > Feb 02 05:34:47 nfsserver kernel:  ? rwsem_spin_on_owner+0x74/0xd0
> > Feb 02 05:34:47 nfsserver kernel:  schedule+0x46/0xb0
> > Feb 02 05:34:47 nfsserver kernel:  rwsem_down_write_slowpath+0x257/0x4d=
0
> > Feb 02 05:34:47 nfsserver kernel:  ? trace_call_bpf+0x76/0xe0
> > Feb 02 05:34:47 nfsserver kernel:  ? nfsd4_write+0x1/0x1a0 [nfsd]
> > Feb 02 05:34:47 nfsserver kernel:  ext4_buffered_write_iter+0x33/0x160 =
[ext4]
> > Feb 02 05:34:47 nfsserver kernel:  do_iter_readv_writev+0x14f/0x1b0
> > Feb 02 05:34:47 nfsserver kernel:  do_iter_write+0x80/0x1c0
> > Feb 02 05:34:47 nfsserver kernel:  nfsd_vfs_write+0x17f/0x680 [nfsd]
> > Feb 02 05:34:47 nfsserver kernel:  nfsd4_write+0xd0/0x1a0 [nfsd]
> > Feb 02 05:34:47 nfsserver kernel:  elfcorehdr_read+0x40/0x40
> > Feb 02 05:34:47 nfsserver kernel:  ? nfsd_dispatch+0x15b/0x250 [nfsd]
> > Feb 02 05:34:47 nfsserver kernel:  ? svc_process_common+0x3e1/0x6e0 [su=
nrpc]
> > Feb 02 05:34:47 nfsserver kernel:  ? nfsd_svc+0x390/0x390 [nfsd]
> > Feb 02 05:34:47 nfsserver kernel:  ? svc_process+0xb7/0xf0 [sunrpc]
> > Feb 02 05:34:47 nfsserver kernel:  ? nfsd+0x91/0xb0 [nfsd]
> > Feb 02 05:34:47 nfsserver kernel:  ? get_order+0x20/0x20 [nfsd]
> > Feb 02 05:34:47 nfsserver kernel:  ? kthread+0x118/0x140
> > Feb 02 05:34:47 nfsserver kernel:  ? __kthread_bind_mask+0x60/0x60
> > Feb 02 05:34:47 nfsserver kernel:  ? ret_from_fork+0x1f/0x30
> > Feb 02 05:34:47 nfsserver kernel: INFO: task nfsd:1610 blocked for more=
 than 121 seconds.
> > Feb 02 05:34:47 nfsserver kernel:       Tainted: G            E     5.1=
0.0-34-amd64 #1 Debian 5.10.228-1~test1
> > Feb 02 05:34:47 nfsserver kernel: "echo 0 > /proc/sys/kernel/hung_task_=
timeout_secs" disables this message.
> > Feb 02 05:34:47 nfsserver kernel: task:nfsd            state:D stack:  =
  0 pid: 1610 ppid:     2 flags:0x00004000
> > Feb 02 05:34:47 nfsserver kernel: Call Trace:
> > Feb 02 05:34:47 nfsserver kernel:  __schedule+0x282/0x870
> > Feb 02 05:34:47 nfsserver kernel:  schedule+0x46/0xb0
> > Feb 02 05:34:47 nfsserver kernel:  rwsem_down_write_slowpath+0x257/0x4d=
0
> > Feb 02 05:34:47 nfsserver kernel:  ? trace_call_bpf+0x76/0xe0
> > Feb 02 05:34:47 nfsserver kernel:  ? nfsd4_write+0x1/0x1a0 [nfsd]
> > Feb 02 05:34:47 nfsserver kernel:  ext4_buffered_write_iter+0x33/0x160 =
[ext4]
> > Feb 02 05:34:47 nfsserver kernel:  do_iter_readv_writev+0x14f/0x1b0
> > Feb 02 05:34:47 nfsserver kernel:  do_iter_write+0x80/0x1c0
> > Feb 02 05:34:47 nfsserver kernel:  nfsd_vfs_write+0x17f/0x680 [nfsd]
> > Feb 02 05:34:47 nfsserver kernel:  nfsd4_write+0xd0/0x1a0 [nfsd]
> > Feb 02 05:34:47 nfsserver kernel:  elfcorehdr_read+0x40/0x40
> > Feb 02 05:34:47 nfsserver kernel:  ? nfsd_dispatch+0x15b/0x250 [nfsd]
> > Feb 02 05:34:47 nfsserver kernel:  ? svc_process_common+0x3e1/0x6e0 [su=
nrpc]
> > Feb 02 05:34:47 nfsserver kernel:  ? nfsd_svc+0x390/0x390 [nfsd]
> > Feb 02 05:34:47 nfsserver kernel:  ? svc_process+0xb7/0xf0 [sunrpc]
> > Feb 02 05:34:47 nfsserver kernel:  ? nfsd+0x91/0xb0 [nfsd]
> > Feb 02 05:34:47 nfsserver kernel:  ? get_order+0x20/0x20 [nfsd]
> > Feb 02 05:34:47 nfsserver kernel:  ? kthread+0x118/0x140
> > Feb 02 05:34:47 nfsserver kernel:  ? __kthread_bind_mask+0x60/0x60
> > Feb 02 05:34:47 nfsserver kernel:  ? ret_from_fork+0x1f/0x30
>=20
> This is a totally different failure mode: it's hanging in the
> ext4 write path. One of your nfsd threads is stuck in D state
> waiting to get a rw semaphor.
>=20
> Question is, who is holding that rw_sem and why?
>=20
>=20

It looks like ext4_buffered_write_iter() takes the inode_lock, so it's
probably the inode->i_rwsem that it's waiting on. Unfortunately all
sorts of things take that lock so it's hard to speculate about the
cause of it being stuck. Consider triggering a sysrq-w if this occurs
again, which would tell us something about the contended locks.


> > This happend a couple of times again and "recovered", but got finally s=
tuck
> > again with:
> >=20
> > Feb 02 10:55:25 nfsserver kernel: receive_cb_reply: Got unrecognized re=
ply: calldir 0x1 xpt_bc_xprt 00000000b31acdd9 xid 1639fb84
> > Feb 02 10:55:26 nfsserver kernel: receive_cb_reply: Got unrecognized re=
ply: calldir 0x1 xpt_bc_xprt 000000004111342b xid 24acf045
> > Feb 02 10:55:27 nfsserver kernel: receive_cb_reply: Got unrecognized re=
ply: calldir 0x1 xpt_bc_xprt 0000000035c718f5 xid 89c15b44
> > Feb 02 10:55:28 nfsserver kernel: receive_cb_reply: Got unrecognized re=
ply: calldir 0x1 xpt_bc_xprt 000000004563c9e7 xid 8c74cce2
> > Feb 02 10:55:50 nfsserver kernel: rcu: INFO: rcu_sched self-detected st=
all on CPU
> > Feb 02 10:55:50 nfsserver kernel: rcu:         14-....: (5249 ticks thi=
s GP) idle=3Dc4e/1/0x4000000000000000 softirq=3D3120573/3120573 fqs=3D2624=
=20
> > Feb 02 10:55:50 nfsserver kernel:         (t=3D5250 jiffies g=3D4585625=
 q=3D145785)
> > Feb 02 10:55:50 nfsserver kernel: NMI backtrace for cpu 14
> > Feb 02 10:55:50 nfsserver kernel: CPU: 14 PID: 614435 Comm: kworker/u42=
:2 Tainted: G            E     5.10.0-34-amd64 #1 Debian 5.10.228-1~test1
> > Feb 02 10:55:50 nfsserver kernel: Hardware name: DALCO AG S2600WFT/S260=
0WFT, BIOS SE5C620.86B.02.01.0008.031920191559 03/19/2019
> > Feb 02 10:55:50 nfsserver kernel: Workqueue: rpciod rpc_async_schedule =
[sunrpc]
> > Feb 02 10:55:50 nfsserver kernel: Call Trace:
> > Feb 02 10:55:50 nfsserver kernel:  <IRQ>
> > Feb 02 10:55:50 nfsserver kernel:  dump_stack+0x6b/0x83
> > Feb 02 10:55:50 nfsserver kernel:  nmi_cpu_backtrace.cold+0x32/0x69
> > Feb 02 10:55:50 nfsserver kernel:  ? lapic_can_unplug_cpu+0x80/0x80
> > Feb 02 10:55:50 nfsserver kernel:  nmi_trigger_cpumask_backtrace+0xdb/0=
xf0
> > Feb 02 10:55:50 nfsserver kernel:  rcu_dump_cpu_stacks+0xa5/0xd7
> > Feb 02 10:55:50 nfsserver kernel:  rcu_sched_clock_irq.cold+0x202/0x3d9
> > Feb 02 10:55:50 nfsserver kernel:  ? timekeeping_advance+0x370/0x5c0
> > Feb 02 10:55:50 nfsserver kernel:  update_process_times+0x8c/0xc0
> > Feb 02 10:55:50 nfsserver kernel:  tick_sched_handle+0x22/0x60
> > Feb 02 10:55:50 nfsserver kernel:  tick_sched_timer+0x65/0x80
> > Feb 02 10:55:50 nfsserver kernel:  ? tick_sched_do_timer+0x90/0x90
> > Feb 02 10:55:50 nfsserver kernel:  __hrtimer_run_queues+0x127/0x280
> > Feb 02 10:55:50 nfsserver kernel:  hrtimer_interrupt+0x110/0x2c0
> > Feb 02 10:55:50 nfsserver kernel:  __sysvec_apic_timer_interrupt+0x5c/0=
xe0
> > Feb 02 10:55:50 nfsserver kernel:  asm_call_irq_on_stack+0xf/0x20
> > Feb 02 10:55:50 nfsserver kernel:  </IRQ>
> > Feb 02 10:55:50 nfsserver kernel:  sysvec_apic_timer_interrupt+0x72/0x8=
0
> > Feb 02 10:55:50 nfsserver kernel:  asm_sysvec_apic_timer_interrupt+0x12=
/0x20
> > Feb 02 10:55:50 nfsserver kernel: RIP: 0010:mod_delayed_work_on+0x5d/0x=
90

mod_delayed_work_on() disables IRQs and then calls down into the
workqueue code to modify a wq job. If that took too long then you'd see
an rcu_sched warning like this.

> > Feb 02 10:55:50 nfsserver kernel: Code: 00 4c 89 e7 e8 34 fe ff ff 89 c=
3 83 f8 f5 74 e9 85 c0 78 1b 89 ef 4c 89 f1 4c 89 e2 4c 89 ee e8 f9 fc ff f=
f 48 8b 3c 24 57 9d <0f> 1f 44 00 00 85 db 0f 95 c0 48 8b 4c 24 08 65 48 2b=
 0c 25 28 00
> > Feb 02 10:55:50 nfsserver kernel: RSP: 0018:ffffaaff25d57d90 EFLAGS: 00=
000246
> > Feb 02 10:55:50 nfsserver kernel: RAX: 0000000000000000 RBX: 0000000000=
000000 RCX: 000000003e60000e
> > Feb 02 10:55:50 nfsserver kernel: RDX: 000000003e400000 RSI: 0000000000=
000046 RDI: 0000000000000246
> > Feb 02 10:55:50 nfsserver kernel: RBP: 0000000000002000 R08: ffffffffc0=
8f6430 R09: ffffffffc08f6448
> > Feb 02 10:55:50 nfsserver kernel: R10: 0000000000000003 R11: 0000000000=
000003 R12: ffffffffc08f6428
> > Feb 02 10:55:50 nfsserver kernel: R13: ffff8e4083a4b400 R14: 0000000000=
0001f4 R15: 0000000000000000
> > Feb 02 10:55:50 nfsserver kernel:  __rpc_sleep_on_priority_timeout+0x11=
1/0x120 [sunrpc]
> > Feb 02 10:55:50 nfsserver kernel:  rpc_delay+0x56/0x90 [sunrpc]
> > Feb 02 10:55:50 nfsserver kernel:  rpc_exit_task+0x5a/0x140 [sunrpc]
> > Feb 02 10:55:50 nfsserver kernel:  ? __rpc_do_wake_up_task_on_wq+0x1e0/=
0x1e0 [sunrpc]
> > Feb 02 10:55:50 nfsserver kernel:  __rpc_execute+0x6d/0x410 [sunrpc]
> > Feb 02 10:55:50 nfsserver kernel:  rpc_async_schedule+0x29/0x40 [sunrpc=
]
> > Feb 02 10:55:50 nfsserver kernel:  process_one_work+0x1b3/0x350
> > Feb 02 10:55:50 nfsserver kernel:  worker_thread+0x53/0x3e0
> > Feb 02 10:55:50 nfsserver kernel:  ? process_one_work+0x350/0x350
> > Feb 02 10:55:50 nfsserver kernel:  kthread+0x118/0x140
> > Feb 02 10:55:50 nfsserver kernel:  ? __kthread_bind_mask+0x60/0x60
> > Feb 02 10:55:50 nfsserver kernel:  ret_from_fork+0x1f/0x30
> >=20
> > Before rebooting the system, rpcdebug -m rpc -c  was issued again, with=
 the
> > following logged entry:
> >=20
> > Feb 02 11:01:52 nfsserver kernel: -pid- flgs status -client- --rqstp- -=
timeout ---ops--
> > Feb 02 11:01:52 nfsserver kernel: 42135 2281      0 8ff8d038        0  =
    500  1a6bcc0 nfs4_cbv1 CB_RECALL_ANY a:call_start [sunrpc] q:none
>=20
> This is also different: the CB_RECALL_ANY is waiting to start, it's not
> retransmitting.
>=20
>
>=20
> > The system is now again back booted with fs.leases-enable=3D0 to keep i=
t more
> > "stable".
>=20
> Understood, but I don't yet see how this new scenario is related to
> NFSv4 delegation. We can speculate, but here's nothing standing out in
> the collected data.
>=20
>=20

Agreed. It looks like there are bigger issues than just nfsd here.=20
--=20
Jeff Layton <jlayton@kernel.org>


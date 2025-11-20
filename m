Return-Path: <linux-nfs+bounces-16633-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EF070C75F8D
	for <lists+linux-nfs@lfdr.de>; Thu, 20 Nov 2025 19:47:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sin.lore.kernel.org (Postfix) with ESMTPS id D656329154
	for <lists+linux-nfs@lfdr.de>; Thu, 20 Nov 2025 18:47:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D18C718FDDB;
	Thu, 20 Nov 2025 18:47:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="s1erXfC3"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 824B94C98
	for <linux-nfs@vger.kernel.org>; Thu, 20 Nov 2025 18:47:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763664450; cv=none; b=P79S89B5VkO4gtlODDzaaMKgw9f3TYXtYwbXLU//7RqgJi83GrzMaevhsuc8hupuS2p+7R5O833B7B2imTt6orpsguRt7O6XnWc+jUU9vfjZKTTQ5lsbwVKt19pkQqjXDyZ8NE9624lQc8RhZzva/T0gw8Pc9hENwJdjOk3TwC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763664450; c=relaxed/simple;
	bh=kSG92/o3VnGUwoIWIxjnQCE74Uo4TX7cKwrM86KYRKw=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=V0VvP4UoaL3fn3EgStIqnis5PakCo24tiPRvl43k47gEOh8t23CKfBabu7DZPPX6KX8EwEuszxzw4cpy+zSDxDCcUZ67W30S/7IaxA8+2hypJTSPrDeH+pg4BbG9E4hC1NzaYAOBzpmHPefJvpUFKxq5UG3SR/+lfvlbJLFarYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=s1erXfC3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA0A8C4CEF1;
	Thu, 20 Nov 2025 18:47:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763664450;
	bh=kSG92/o3VnGUwoIWIxjnQCE74Uo4TX7cKwrM86KYRKw=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=s1erXfC3xcOUBB8Bi26NF3mdHIGmLw+3dXGHZ3zj0H0qlxPoxoL8ETrzW1DxasHqo
	 U+mbWbW0wmKMStZOO6RAjrA1cflOgFLz0Vn/NfndoFiX75WMXVoAV7dHe4iDGeFPNr
	 iKHndM5dPi30r8iHCRB6kSUcqqUpjZIvwetS0a90MWS/in+G4889zbrfTekpYS2ugP
	 Kld+vTGLF2zCOYXfMpu/G6citO+XKJAHS0l1BPNAUK9LTgO39zThPepHoks1W4DB8T
	 8NpVNkFyQOK2UAjLkqxNsFwS9od0tffOraJlwNV18SX+GFx01rPWP8CY7aI9nvVxcN
	 egkgFen4xZd7A==
Message-ID: <1591667c585ef9ae91f8c18b71e47c63cf29f152.camel@kernel.org>
Subject: Re: [RFC PATCH] locks: Add lm_would_deadlock callback to prevent
 NFSD hangs
From: Jeff Layton <jlayton@kernel.org>
To: Chuck Lever <cel@kernel.org>, NeilBrown <neil@brown.name>, Olga
 Kornievskaia <okorniev@redhat.com>, Dai Ngo <dai.ngo@oracle.com>, Tom
 Talpey <tom@talpey.com>
Cc: linux-nfs@vger.kernel.org, Chuck Lever <chuck.lever@oracle.com>
Date: Thu, 20 Nov 2025 13:47:28 -0500
In-Reply-To: <20251120174831.5860-1-cel@kernel.org>
References: <20251120174831.5860-1-cel@kernel.org>
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
User-Agent: Evolution 3.58.1 (3.58.1-1.fc43) 
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2025-11-20 at 12:48 -0500, Chuck Lever wrote:
> From: Chuck Lever <chuck.lever@oracle.com>
>=20
> When multiple pNFS layout conflicts occur on an NFS server, the NFSD
> thread pool can become exhausted while threads are waiting in
> __break_lease for clients to return their layouts. If all NFSD
> threads are blocked, none are available to process incoming
> LAYOUTRETURNs, creating a deadlock.
>=20
> The approach proposed here, although somewhat expedient, avoids
> fencing responsive clients.
>=20
> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
> ---
>  Documentation/filesystems/locking.rst |  2 ++
>  fs/locks.c                            | 12 ++++++++++
>  fs/nfsd/nfs4layouts.c                 | 33 +++++++++++++++++++++++++++
>  include/linux/filelock.h              |  1 +
>  4 files changed, 48 insertions(+)
>=20
> This is 100% untested and falls squarely in the "crazy ideas"
> category. I'm posting to provide an alternative and encourage some
> creative thinking about this sticky problem.
>=20
> diff --git a/Documentation/filesystems/locking.rst b/Documentation/filesy=
stems/locking.rst
> index 77704fde9845..6b0cb5fd03fd 100644
> --- a/Documentation/filesystems/locking.rst
> +++ b/Documentation/filesystems/locking.rst
> @@ -403,6 +403,7 @@ prototypes::
>  	bool (*lm_breaker_owns_lease)(struct file_lock *);
>          bool (*lm_lock_expirable)(struct file_lock *);
>          void (*lm_expire_lock)(void);
> +        bool (*lm_would_deadlock)(struct file_lock *);
> =20
>  locking rules:
> =20
> @@ -416,6 +417,7 @@ lm_change		yes		no			no
>  lm_breaker_owns_lease:	yes     	no			no
>  lm_lock_expirable	yes		no			no
>  lm_expire_lock		no		no			yes
> +lm_would_deadlock	yes		no			no
>  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D	=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D	=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D	=3D=3D=3D=3D=3D=3D=3D=3D=3D
> =20
>  buffer_head
> diff --git a/fs/locks.c b/fs/locks.c
> index 04a3f0e20724..4ea473c885a8 100644
> --- a/fs/locks.c
> +++ b/fs/locks.c
> @@ -1615,6 +1615,18 @@ int __break_lease(struct inode *inode, unsigned in=
t mode, unsigned int type)
>  	percpu_up_read(&file_rwsem);
> =20
>  	locks_dispose_list(&dispose);
> +
> +	/* Check if lease manager predicts a deadlock situation */
> +	if (fl->fl_lmops && fl->fl_lmops->lm_would_deadlock &&
> +	    fl->fl_lmops->lm_would_deadlock(fl)) {
> +		trace_break_lease_noblock(inode, new_fl);
> +		error =3D -EWOULDBLOCK;
> +		percpu_down_read(&file_rwsem);
> +		spin_lock(&ctx->flc_lock);
> +		__locks_delete_block(&new_fl->c);
> +		goto out;
> +	}
> +
>  	error =3D wait_event_interruptible_timeout(new_fl->c.flc_wait,
>  						 list_empty(&new_fl->c.flc_blocked_member),
>  						 break_time);
> diff --git a/fs/nfsd/nfs4layouts.c b/fs/nfsd/nfs4layouts.c
> index 683bd1130afe..748a1b1b0626 100644
> --- a/fs/nfsd/nfs4layouts.c
> +++ b/fs/nfsd/nfs4layouts.c
> @@ -764,9 +764,42 @@ nfsd4_layout_lm_change(struct file_lease *onlist, in=
t arg,
>  	return lease_modify(onlist, arg, dispose);
>  }
> =20
> +static bool
> +nfsd4_layout_lm_would_deadlock(struct file_lease *fl)
> +{
> +	struct svc_rqst *rqstp;
> +	struct svc_pool *pool;
> +	struct llist_node *idle;
> +
> +	/*
> +	 * Check if we're running in an NFSD thread context.
> +	 * If not, we can't cause an NFSD deadlock.
> +	 */
> +	rqstp =3D nfsd_current_rqst();
> +	if (!rqstp)
> +		return false;
> +
> +	pool =3D rqstp->rq_pool;
> +
> +	/*
> +	 * Check the number of idle threads in the pool. We use
> +	 * READ_ONCE as sp_idle_threads is a lockless list.
> +	 * If we have 0 or 1 idle threads remaining and the current
> +	 * thread is about to block, we risk deadlock as there may
> +	 * not be enough threads available to process the LAYOUTRETURN
> +	 * RPCs needed to unblock.
> +	 */
> +	idle =3D READ_ONCE(pool->sp_idle_threads.first);
> +	if (!idle || !READ_ONCE(idle->next))

I think you might need the rcu_read_lock() around the above. I think
it's possible for idle to be freed before you can dereference
idle->next.

> +		return true;
> +
> +	return false;
> +}
> +
>  static const struct lease_manager_operations nfsd4_layouts_lm_ops =3D {
>  	.lm_break	=3D nfsd4_layout_lm_break,
>  	.lm_change	=3D nfsd4_layout_lm_change,
> +	.lm_would_deadlock =3D nfsd4_layout_lm_would_deadlock,
>  };
> =20
>  int
> diff --git a/include/linux/filelock.h b/include/linux/filelock.h
> index c2ce8ba05d06..7c46444a3d50 100644
> --- a/include/linux/filelock.h
> +++ b/include/linux/filelock.h
> @@ -49,6 +49,7 @@ struct lease_manager_operations {
>  	int (*lm_change)(struct file_lease *, int, struct list_head *);
>  	void (*lm_setup)(struct file_lease *, void **);
>  	bool (*lm_breaker_owns_lease)(struct file_lease *);
> +	bool (*lm_would_deadlock)(struct file_lease *);
>  };
> =20
>  struct lock_manager {

--=20
Jeff Layton <jlayton@kernel.org>


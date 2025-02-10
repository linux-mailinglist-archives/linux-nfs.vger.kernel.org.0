Return-Path: <linux-nfs+bounces-10022-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 46CB1A2F509
	for <lists+linux-nfs@lfdr.de>; Mon, 10 Feb 2025 18:21:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D61571687E9
	for <lists+linux-nfs@lfdr.de>; Mon, 10 Feb 2025 17:21:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EB80255E34;
	Mon, 10 Feb 2025 17:20:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dY2HXXZ5"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBEFD24BD0B
	for <linux-nfs@vger.kernel.org>; Mon, 10 Feb 2025 17:20:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739208054; cv=none; b=UCzQeLRQW7h2dr7K/oATpPn6++tMtw8VGihOSf1uVTNFRoeiZLjpMgPhNGzw+VVesv3HFvfS3YryhRLCzNBmeSe/YNT2iQqFLv2H21Ae4msCLnIKwc3CxZuLfLswWp7ZS/0pqaDZ/4p/uoHd3y4rfJXrN2R97pSnyF3Brg1/nXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739208054; c=relaxed/simple;
	bh=nu2CNJMBDsCc5bi3XQry8yMmOGDpbWrDSQfdCEvXzq0=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=rNdAQFiBSUKDfZXcL1BJ5Qu3OO7vWVo38PgO5i5aDmo3SW64U/FpRiJZURP44HR5JgYylxtWOGgqGlL+ipS640TqqsojOoEzyvOctZgDAWqN8T/pW7hPPnquRplB0QhnG04PixKHuJG/lYBYMvdG7xGqUxDliKjk8vHdEGdbyJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dY2HXXZ5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9EC6C4CEE6;
	Mon, 10 Feb 2025 17:20:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739208054;
	bh=nu2CNJMBDsCc5bi3XQry8yMmOGDpbWrDSQfdCEvXzq0=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=dY2HXXZ5pqTnPwTfPyqYF/zoWsNLYqCUl6ITIkYh8zE72whEyZvay+TuelIcbWdOR
	 lTpeQybu6D9qDnjpzyAqu4LiZVUkH28OTk5QLl9CFOb6wikO1b3oxPy18dfhHuMKVu
	 r9sAmVXFK9HNR1L+Gtr1w6wMovvIlG3lH0AhAneUnQpiqDJ+7wGy7HOhAVUwLeskn3
	 7AbkfwnxSO4ypM5yqhEklPb7PVZB88MGCAhkjoke9JQ8t7U5ZqIelBvs6HC2tmvyFG
	 Wr4j7T8qyj9UQDZiJ7fCiTHz63NDcPMfNNe7unX6ylWtNGioQjog9riInxnYrEsioQ
	 NtzMDgiS3o2BQ==
Message-ID: <10f2778fe0efd8f081a19d5a3200eb1d49147a06.camel@kernel.org>
Subject: Re: [PATCH v4] nfsd: disallow file locking and delegations for
 NFSv4 reexport
From: Jeff Layton <jlayton@kernel.org>
To: cel@kernel.org, Neil Brown <neilb@suse.de>, Olga Kornievskaia	
 <okorniev@redhat.com>, Dai Ngo <dai.ngo@oracle.com>, Tom Talpey
 <tom@talpey.com>
Cc: linux-nfs@vger.kernel.org, Mike Snitzer <snitzer@kernel.org>
Date: Mon, 10 Feb 2025 12:20:52 -0500
In-Reply-To: <20250210162553.112705-1-cel@kernel.org>
References: <20250210162553.112705-1-cel@kernel.org>
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

On Mon, 2025-02-10 at 11:25 -0500, cel@kernel.org wrote:
> From: Mike Snitzer <snitzer@kernel.org>
>=20
> We do not and cannot support file locking with NFS reexport over
> NFSv4.x for the same reason we don't do it for NFSv3: NFS reexport
> server reboot cannot allow clients to recover locks because the source
> NFS server has not rebooted, and so it is not in grace.=C2=A0
>=20

Refresh my memory: how do we prevent this in v3? It seems like NLM
should use the same mechanism.

>  Since the
> source NFS server is not in grace, it cannot offer any guarantees that
> the file won't have been changed between the locks getting lost and
> any attempt to recover/reclaim them.  The same applies to delegations
> and any associated locks, so disallow them too.
>=20
> Clients are no longer allowed to get file locks or delegations from a
> reexport server, any attempts will fail with operation not supported.
>=20
> Update the "Reboot recovery" section accordingly in
> Documentation/filesystems/nfs/reexport.rst
>=20
> Signed-off-by: Mike Snitzer <snitzer@kernel.org>
> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
> ---
>  Documentation/filesystems/nfs/reexport.rst | 10 +++++++---
>  fs/nfs/export.c                            |  3 ++-
>  fs/nfsd/nfs4state.c                        | 18 ++++++++++++++++++
>  include/linux/exportfs.h                   | 14 +++++++++++++-
>  4 files changed, 40 insertions(+), 5 deletions(-)
>=20
>=20
> Jeff and I believe that it is better to prevent data corruption for
> now than to continue to enable risky use cases. Thus I've forward-
> ported this patch to v6.14-rc2 and intend to include it in the
> nfsd-6.15 pull request.
>=20
> We remain open to considering solutions that enable locking through
> to the back-end NFS server with appropriate lock recovery.
>=20
>=20
> diff --git a/Documentation/filesystems/nfs/reexport.rst b/Documentation/f=
ilesystems/nfs/reexport.rst
> index ff9ae4a46530..044be965d75e 100644
> --- a/Documentation/filesystems/nfs/reexport.rst
> +++ b/Documentation/filesystems/nfs/reexport.rst
> @@ -26,9 +26,13 @@ Reboot recovery
>  ---------------
> =20
>  The NFS protocol's normal reboot recovery mechanisms don't work for the
> -case when the reexport server reboots.  Clients will lose any locks
> -they held before the reboot, and further IO will result in errors.
> -Closing and reopening files should clear the errors.
> +case when the reexport server reboots because the source server has not
> +rebooted, and so it is not in grace.  Since the source server is not in
> +grace, it cannot offer any guarantees that the file won't have been
> +changed between the locks getting lost and any attempt to recover them.
> +The same applies to delegations and any associated locks.  Clients are
> +not allowed to get file locks or delegations from a reexport server, any
> +attempts will fail with operation not supported.
> =20
>  Filehandle limits
>  -----------------
> diff --git a/fs/nfs/export.c b/fs/nfs/export.c
> index be686b8e0c54..e9c233b6fd20 100644
> --- a/fs/nfs/export.c
> +++ b/fs/nfs/export.c
> @@ -154,5 +154,6 @@ const struct export_operations nfs_export_ops =3D {
>  		 EXPORT_OP_CLOSE_BEFORE_UNLINK	|
>  		 EXPORT_OP_REMOTE_FS		|
>  		 EXPORT_OP_NOATOMIC_ATTR	|
> -		 EXPORT_OP_FLUSH_ON_CLOSE,
> +		 EXPORT_OP_FLUSH_ON_CLOSE	|
> +		 EXPORT_OP_NOLOCKS,
>  };
> diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
> index b42e2ab7a042..f0fb6ca4b70c 100644
> --- a/fs/nfsd/nfs4state.c
> +++ b/fs/nfsd/nfs4state.c
> @@ -6000,6 +6000,15 @@ nfs4_set_delegation(struct nfsd4_open *open, struc=
t nfs4_ol_stateid *stp,
>  	if (!nf)
>  		return ERR_PTR(-EAGAIN);
> =20
> +	/*
> +	 * File delegations and associated locks cannot be recovered if the
> +	 * export is from an NFS proxy server.
> +	 */
> +	if (exportfs_cannot_lock(nf->nf_file->f_path.mnt->mnt_sb->s_export_op))=
 {
> +		nfsd_file_put(nf);
> +		return ERR_PTR(-EOPNOTSUPP);
> +	}
> +
>  	spin_lock(&state_lock);
>  	spin_lock(&fp->fi_lock);
>  	if (nfs4_delegation_exists(clp, fp))
> @@ -8140,6 +8149,10 @@ nfsd4_lock(struct svc_rqst *rqstp, struct nfsd4_co=
mpound_state *cstate,
>  	status =3D fh_verify(rqstp, &cstate->current_fh, S_IFREG, 0);
>  	if (status !=3D nfs_ok)
>  		return status;
> +	if (exportfs_cannot_lock(cstate->current_fh.fh_dentry->d_sb->s_export_o=
p)) {
> +		status =3D nfserr_notsupp;
> +		goto out;
> +	}
> =20
>  	if (lock->lk_is_new) {
>  		if (nfsd4_has_session(cstate))
> @@ -8479,6 +8492,11 @@ nfsd4_locku(struct svc_rqst *rqstp, struct nfsd4_c=
ompound_state *cstate,
>  		status =3D nfserr_lock_range;
>  		goto put_stateid;
>  	}
> +	if (exportfs_cannot_lock(nf->nf_file->f_path.mnt->mnt_sb->s_export_op))=
 {
> +		status =3D nfserr_notsupp;
> +		goto put_file;
> +	}
> +
>  	file_lock =3D locks_alloc_lock();
>  	if (!file_lock) {
>  		dprintk("NFSD: %s: unable to allocate lock!\n", __func__);
> diff --git a/include/linux/exportfs.h b/include/linux/exportfs.h
> index 4cc8801e50e3..ca6c605072c7 100644
> --- a/include/linux/exportfs.h
> +++ b/include/linux/exportfs.h
> @@ -259,10 +259,22 @@ struct export_operations {
>  						  atomic attribute updates
>  						*/
>  #define EXPORT_OP_FLUSH_ON_CLOSE	(0x20) /* fs flushes file data on close=
 */
> -#define EXPORT_OP_ASYNC_LOCK		(0x40) /* fs can do async lock request */
> +#define EXPORT_OP_NOLOCKS		(0x40) /* no file locking support */
>  	unsigned long	flags;
>  };
> =20
> +/**
> + * exportfs_cannot_lock() - check if export implements file locking
> + * @export_ops:	the nfs export operations to check
> + *
> + * Returns true if the export does not support file locking.
> + */
> +static inline bool
> +exportfs_cannot_lock(const struct export_operations *export_ops)
> +{
> +	return export_ops->flags & EXPORT_OP_NOLOCKS;
> +}
> +
>  extern int exportfs_encode_inode_fh(struct inode *inode, struct fid *fid=
,
>  				    int *max_len, struct inode *parent,
>  				    int flags);


Aside from the question about NLM, this looks good:

Reviewed-by: Jeff Layton <jlayton@kernel.org>


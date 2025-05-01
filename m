Return-Path: <linux-nfs+bounces-11383-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 99E25AA606C
	for <lists+linux-nfs@lfdr.de>; Thu,  1 May 2025 17:04:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6D525164772
	for <lists+linux-nfs@lfdr.de>; Thu,  1 May 2025 15:04:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9336D1A08B8;
	Thu,  1 May 2025 15:03:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L92ANJDI"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C3261FBC8C
	for <linux-nfs@vger.kernel.org>; Thu,  1 May 2025 15:03:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746111837; cv=none; b=MeHGYmkMoKDoHyzIbOlO5WVGKBvcm8RjMO9rnMRc73fNDE2lFdnKSqdEndAit5/keE09eP/4zBU6ZL4EOK/wDWLgWfcXsTMfRsh0Bsz4TNDBCflZ77DpWos35+SJcQAHtsWVsIuAG9Aqik1EPjROaZHnST49m91xiXjCMLZd20Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746111837; c=relaxed/simple;
	bh=MYb+hykp748SVg2R3CmCSYl+vNjZEm6S3Ilqu7CFQjM=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=eFIwuZB02bA216cwNEnQXvnx5/nT9QJWPGiR4JxeBFYqgWFmThSSfp416yUKt4NGiUPWiX8ZzWkHio3X0q237Xgydp++44e+RexFw6zDW7xyijuZu7xYox3Z4U30JdcfJPBiYq6n8VXBiopv5H3SJX5aurRALM4XNwDBu2zEk/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L92ANJDI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6EB1C4CEE3;
	Thu,  1 May 2025 15:03:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746111836;
	bh=MYb+hykp748SVg2R3CmCSYl+vNjZEm6S3Ilqu7CFQjM=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=L92ANJDIsttyslLZvbskN+eKL75EaOKte549WlnbjeKJQKj2Bytqvu9Zm3A3Y/czq
	 wPkv96COZ6WmVOCuqdAG0p7QzFLHswl0YHnTU7/li/6JZbaoi+UPhBFQt6I513ScEG
	 1wVYFopF9r1Q8n35f7BndEPEKhL/O9KZWncGkkdPFr9UxUL+2k8TE/nnAEJP0CDY+L
	 R8nezMpyO2SfiMDEAuptd0O+CifdvDKo6jGiCntoo8zyFE7FbBaAHQyg1jJ7GyBJA6
	 lA237DE6hwZswgshVoTifg7voKPp+wQ9qEJYZIz48C2koEWg3CZIB7lP/G9iRYVlup
	 FMe2yipnp9DUA==
Message-ID: <7da4f3ee14aaa307d4cafb6d7eada3cceb32381a.camel@kernel.org>
Subject: Re: [PATCH v2 1/1] NFSv4: Allow FREE_STATEID to clean up delegations
From: Jeff Layton <jlayton@kernel.org>
To: Benjamin Coddington <bcodding@redhat.com>, Trond Myklebust
	 <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>
Cc: linux-nfs@vger.kernel.org
Date: Thu, 01 May 2025 08:03:56 -0700
In-Reply-To: <b1aca11bea75b7804232aa65ad4bb4e591e3434b.1746102154.git.bcodding@redhat.com>
References: <cover.1746102154.git.bcodding@redhat.com>
	 <b1aca11bea75b7804232aa65ad4bb4e591e3434b.1746102154.git.bcodding@redhat.com>
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

On Thu, 2025-05-01 at 08:29 -0400, Benjamin Coddington wrote:
> The NFS client's list of delegations can grow quite large (well beyond th=
e
> delegation watermark) if the server is revoking or there are repeated
> events that expire state.  Once this happens, the revoked delegations can
> cause a performance problem for subsequent walks of the
> servers->delegations list when the client tries to test and free state.
>=20
> If we can determine that the FREE_STATEID operation has completed without
> error, we can prune the delegation from the list.
>=20
> Since the NFS client combines TEST_STATEID with FREE_STATEID in its minor
> version operations, there isn't an easy way to communicate success of
> FREE_STATEID.  Rather than re-arrange quite a number of calling paths to
> break out the separate procedures, let's signal the success of FREE_STATE=
ID
> by setting the stateid's type.
>=20
> Set NFS4_FREED_STATEID_TYPE for stateids that have been successfully
> discarded from the server, and use that type to signal that the delegatio=
n
> can be cleaned up.
>=20
> Signed-off-by: Benjamin Coddington <bcodding@redhat.com>
> ---
>  fs/nfs/delegation.c  | 25 ++++++++++++++++++-------
>  fs/nfs/nfs4_fs.h     |  3 +--
>  fs/nfs/nfs4proc.c    | 12 ++++++------
>  include/linux/nfs4.h |  1 +
>  4 files changed, 26 insertions(+), 15 deletions(-)
>=20
> diff --git a/fs/nfs/delegation.c b/fs/nfs/delegation.c
> index 4db912f56230..b746793cf730 100644
> --- a/fs/nfs/delegation.c
> +++ b/fs/nfs/delegation.c
> @@ -1006,13 +1006,6 @@ static void nfs_revoke_delegation(struct inode *in=
ode,
>  		nfs_inode_find_state_and_recover(inode, stateid);
>  }
> =20
> -void nfs_remove_bad_delegation(struct inode *inode,
> -		const nfs4_stateid *stateid)
> -{
> -	nfs_revoke_delegation(inode, stateid);
> -}
> -EXPORT_SYMBOL_GPL(nfs_remove_bad_delegation);
> -
>  void nfs_delegation_mark_returned(struct inode *inode,
>  		const nfs4_stateid *stateid)
>  {
> @@ -1054,6 +1047,24 @@ void nfs_delegation_mark_returned(struct inode *in=
ode,
>  	nfs_inode_find_state_and_recover(inode, stateid);
>  }
> =20
> +/**
> + * nfs_remove_bad_delegation - handle delegations that are unusable
> + * @inode: inode to process
> + * @stateid: the delegation's stateid
> + *
> + * If the server ACK-ed our FREE_STATEID then clean
> + * up the delegation, else mark and keep the revoked state.
> + */
> +void nfs_remove_bad_delegation(struct inode *inode,
> +		const nfs4_stateid *stateid)
> +{
> +	if (stateid && stateid->type =3D=3D NFS4_FREED_STATEID_TYPE)
> +		nfs_delegation_mark_returned(inode, stateid);
> +	else
> +		nfs_revoke_delegation(inode, stateid);
> +}
> +EXPORT_SYMBOL_GPL(nfs_remove_bad_delegation);
> +
>  /**
>   * nfs_expire_unused_delegation_types
>   * @clp: client to process
> diff --git a/fs/nfs/nfs4_fs.h b/fs/nfs/nfs4_fs.h
> index 7d383d29a995..d3ca91f60fc1 100644
> --- a/fs/nfs/nfs4_fs.h
> +++ b/fs/nfs/nfs4_fs.h
> @@ -67,8 +67,7 @@ struct nfs4_minor_version_ops {
>  	void	(*free_lock_state)(struct nfs_server *,
>  			struct nfs4_lock_state *);
>  	int	(*test_and_free_expired)(struct nfs_server *,
> -					 const nfs4_stateid *,
> -					 const struct cred *);
> +					 nfs4_stateid *, const struct cred *);
>  	struct nfs_seqid *
>  		(*alloc_seqid)(struct nfs_seqid_counter *, gfp_t);
>  	void	(*session_trunk)(struct rpc_clnt *clnt,
> diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
> index 6e95db6c17e9..c969e6b0dd84 100644
> --- a/fs/nfs/nfs4proc.c
> +++ b/fs/nfs/nfs4proc.c
> @@ -105,7 +105,7 @@ static struct rpc_task *_nfs41_proc_sequence(struct n=
fs_client *clp,
>  		bool is_privileged);
>  static int nfs41_test_stateid(struct nfs_server *, const nfs4_stateid *,
>  			      const struct cred *);
> -static int nfs41_free_stateid(struct nfs_server *, const nfs4_stateid *,
> +static int nfs41_free_stateid(struct nfs_server *, nfs4_stateid *,
>  			      const struct cred *, bool);
>  #endif
> =20
> @@ -2886,16 +2886,14 @@ static int nfs40_open_expired(struct nfs4_state_o=
wner *sp, struct nfs4_state *st
>  }
> =20
>  static int nfs40_test_and_free_expired_stateid(struct nfs_server *server=
,
> -					       const nfs4_stateid *stateid,
> -					       const struct cred *cred)
> +					       nfs4_stateid *stateid, const struct cred *cred)
>  {
>  	return -NFS4ERR_BAD_STATEID;
>  }
> =20
>  #if defined(CONFIG_NFS_V4_1)
>  static int nfs41_test_and_free_expired_stateid(struct nfs_server *server=
,
> -					       const nfs4_stateid *stateid,
> -					       const struct cred *cred)
> +					       nfs4_stateid *stateid, const struct cred *cred)
>  {
>  	int status;
> =20
> @@ -2904,6 +2902,7 @@ static int nfs41_test_and_free_expired_stateid(stru=
ct nfs_server *server,
>  		break;
>  	case NFS4_INVALID_STATEID_TYPE:
>  	case NFS4_SPECIAL_STATEID_TYPE:
> +	case NFS4_FREED_STATEID_TYPE:
>  		return -NFS4ERR_BAD_STATEID;
>  	case NFS4_REVOKED_STATEID_TYPE:
>  		goto out_free;
> @@ -10570,7 +10569,7 @@ static const struct rpc_call_ops nfs41_free_state=
id_ops =3D {
>   * Note: this function is always asynchronous.
>   */
>  static int nfs41_free_stateid(struct nfs_server *server,
> -		const nfs4_stateid *stateid,
> +		nfs4_stateid *stateid,
>  		const struct cred *cred,
>  		bool privileged)
>  {
> @@ -10610,6 +10609,7 @@ static int nfs41_free_stateid(struct nfs_server *=
server,
>  	if (IS_ERR(task))
>  		return PTR_ERR(task);
>  	rpc_put_task(task);
> +	stateid->type =3D NFS4_FREED_STATEID_TYPE;
>  	return 0;
>  }
> =20
> diff --git a/include/linux/nfs4.h b/include/linux/nfs4.h
> index 9ac83ca88326..8ec5766cb22f 100644
> --- a/include/linux/nfs4.h
> +++ b/include/linux/nfs4.h
> @@ -72,6 +72,7 @@ struct nfs4_stateid_struct {
>  		NFS4_LAYOUT_STATEID_TYPE,
>  		NFS4_PNFS_DS_STATEID_TYPE,
>  		NFS4_REVOKED_STATEID_TYPE,
> +		NFS4_FREED_STATEID_TYPE,
>  	} type;
>  };
> =20

Seems like a good idea to me!

Reviewed-by: Jeff Layton <jlayton@kernel.org>


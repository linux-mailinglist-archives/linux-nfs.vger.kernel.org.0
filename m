Return-Path: <linux-nfs+bounces-7290-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 09C219A464E
	for <lists+linux-nfs@lfdr.de>; Fri, 18 Oct 2024 20:56:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 686BB2819AA
	for <lists+linux-nfs@lfdr.de>; Fri, 18 Oct 2024 18:56:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90BD2202F71;
	Fri, 18 Oct 2024 18:56:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MZmTETxS"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65CA417D346
	for <linux-nfs@vger.kernel.org>; Fri, 18 Oct 2024 18:56:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729277802; cv=none; b=hrpIqFIFSaQNlJ+I32SYeqnYF20GJZZ/1zAXGMMHTmqRlRoF7/pGSQeCyZTH324A/Q2zdRoRImiintFy1wlhem7+qvQAAOS3nX8/4fYfKnqgroYBkCYk1Jw8aLjjEqn2qMT7CbzATiPMyX+K0jHfhV/FEkrGUZ9VEXllLDA/3cg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729277802; c=relaxed/simple;
	bh=phSeA9p//Ud2AcqrUpAlZe477TW8JL2AS9niaHebMH8=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=jfBim87+yJ6N9xdFajo1U+bhN7eZloLeOhsNAvNqlxeFV8O3C1DZgJ5LckkBbPuz66mgdSKgpc2fQWNCheMPsumJml8xK/V5Dh7xxK2vlC/YE9kfEJzs0fLuOjdWGxPpwrOnnU+eaYN4Ui45TTZAVM6A6XTkXzSseIuot2ND5ro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MZmTETxS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8C1CC4CEC3;
	Fri, 18 Oct 2024 18:56:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729277802;
	bh=phSeA9p//Ud2AcqrUpAlZe477TW8JL2AS9niaHebMH8=;
	h=Subject:From:To:Date:In-Reply-To:References:From;
	b=MZmTETxSY0pUqM6r/uCeaJvWqCAA3lTrT8dU8eUWEyrmzNe9UqsZSi3ZtJ3ocaFE+
	 Qmmp8XAVXVu5Nq1jMYzjGAYpHjuIQX5rMQggEnGxZxViJct+o+Hs7Qv/bMsi23u/8q
	 stNj8BgKZ8ce272GJIlAApRPJnAiK1/S4PjTtDyT7w4bADfQG7i4oOYI1dpKQmXIJT
	 RQR06xFGf4ExcrkfoiAxbJrqRhPyjboTbO+bAHSlIcBHf5x7RVgUAp6CbUM9fFRUVQ
	 Q4WoQJWQ7hoTovgpMMMyFfJk9iHu1Y0GQc90QUq1CcSK9bPM212FeQXw9zBvoS5OFH
	 gH4L+a4ZuF4mA==
Message-ID: <ec5b6e191b976c413dc00681013ad1378d9f260b.camel@kernel.org>
Subject: Re: [PATCH v2 11/19] NFSv4: Delegreturn must set m/atime when they
 are delegated
From: Jeff Layton <jlayton@kernel.org>
To: trondmy@kernel.org, linux-nfs@vger.kernel.org
Date: Fri, 18 Oct 2024 14:56:40 -0400
In-Reply-To: <20240617012137.674046-12-trondmy@kernel.org>
References: <20240617012137.674046-1-trondmy@kernel.org>
	 <20240617012137.674046-2-trondmy@kernel.org>
	 <20240617012137.674046-3-trondmy@kernel.org>
	 <20240617012137.674046-4-trondmy@kernel.org>
	 <20240617012137.674046-5-trondmy@kernel.org>
	 <20240617012137.674046-6-trondmy@kernel.org>
	 <20240617012137.674046-7-trondmy@kernel.org>
	 <20240617012137.674046-8-trondmy@kernel.org>
	 <20240617012137.674046-9-trondmy@kernel.org>
	 <20240617012137.674046-10-trondmy@kernel.org>
	 <20240617012137.674046-11-trondmy@kernel.org>
	 <20240617012137.674046-12-trondmy@kernel.org>
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
Content-Type: multipart/mixed; boundary="=-yvyNYdxgQz8LlGj4e1IN"
User-Agent: Evolution 3.52.4 (3.52.4-1.fc40) 
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

--=-yvyNYdxgQz8LlGj4e1IN
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, 2024-06-16 at 21:21 -0400, trondmy@kernel.org wrote:
> From: Trond Myklebust <trond.myklebust@primarydata.com>
>=20
> If the atime or mtime attributes were delegated, then we need to
> propagate their new values back to the server when returning the
> delegation.
>=20
> Signed-off-by: Trond Myklebust <trond.myklebust@primarydata.com>
> Signed-off-by: Lance Shelton <lance.shelton@hammerspace.com>
> Reviewed-by: Jeff Layton <jlayton@kernel.org>
> Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
> ---
>  fs/nfs/delegation.c |  9 +++++----
>  fs/nfs/delegation.h |  4 +++-
>  fs/nfs/nfs4proc.c   | 27 ++++++++++++++++++++++++---
>  3 files changed, 32 insertions(+), 8 deletions(-)
>=20
> diff --git a/fs/nfs/delegation.c b/fs/nfs/delegation.c
> index d9117630e062..d5edb3b3eeef 100644
> --- a/fs/nfs/delegation.c
> +++ b/fs/nfs/delegation.c
> @@ -266,7 +266,9 @@ void nfs_inode_reclaim_delegation(struct inode *inode=
, const struct cred *cred,
>  	}
>  }
> =20
> -static int nfs_do_return_delegation(struct inode *inode, struct nfs_dele=
gation *delegation, int issync)
> +static int nfs_do_return_delegation(struct inode *inode,
> +				    struct nfs_delegation *delegation,
> +				    int issync)
>  {
>  	const struct cred *cred;
>  	int res =3D 0;
> @@ -275,9 +277,8 @@ static int nfs_do_return_delegation(struct inode *ino=
de, struct nfs_delegation *
>  		spin_lock(&delegation->lock);
>  		cred =3D get_cred(delegation->cred);
>  		spin_unlock(&delegation->lock);
> -		res =3D nfs4_proc_delegreturn(inode, cred,
> -				&delegation->stateid,
> -				issync);
> +		res =3D nfs4_proc_delegreturn(inode, cred, &delegation->stateid,
> +					    delegation, issync);
>  		put_cred(cred);
>  	}
>  	return res;
> diff --git a/fs/nfs/delegation.h b/fs/nfs/delegation.h
> index 001551e2ab60..71524d34ed20 100644
> --- a/fs/nfs/delegation.h
> +++ b/fs/nfs/delegation.h
> @@ -70,7 +70,9 @@ void nfs_test_expired_all_delegations(struct nfs_client=
 *clp);
>  void nfs_reap_expired_delegations(struct nfs_client *clp);
> =20
>  /* NFSv4 delegation-related procedures */
> -int nfs4_proc_delegreturn(struct inode *inode, const struct cred *cred, =
const nfs4_stateid *stateid, int issync);
> +int nfs4_proc_delegreturn(struct inode *inode, const struct cred *cred,
> +			  const nfs4_stateid *stateid,
> +			  struct nfs_delegation *delegation, int issync);
>  int nfs4_open_delegation_recall(struct nfs_open_context *ctx, struct nfs=
4_state *state, const nfs4_stateid *stateid);
>  int nfs4_lock_delegation_recall(struct file_lock *fl, struct nfs4_state =
*state, const nfs4_stateid *stateid);
>  bool nfs4_copy_delegation_stateid(struct inode *inode, fmode_t flags, nf=
s4_stateid *dst, const struct cred **cred);
> diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
> index 1209ce22158e..88edeaf5b5d5 100644
> --- a/fs/nfs/nfs4proc.c
> +++ b/fs/nfs/nfs4proc.c
> @@ -6739,7 +6739,10 @@ static const struct rpc_call_ops nfs4_delegreturn_=
ops =3D {
>  	.rpc_release =3D nfs4_delegreturn_release,
>  };
> =20
> -static int _nfs4_proc_delegreturn(struct inode *inode, const struct cred=
 *cred, const nfs4_stateid *stateid, int issync)
> +static int _nfs4_proc_delegreturn(struct inode *inode, const struct cred=
 *cred,
> +				  const nfs4_stateid *stateid,
> +				  struct nfs_delegation *delegation,
> +				  int issync)
>  {
>  	struct nfs4_delegreturndata *data;
>  	struct nfs_server *server =3D NFS_SERVER(inode);
> @@ -6791,12 +6794,27 @@ static int _nfs4_proc_delegreturn(struct inode *i=
node, const struct cred *cred,
>  		}
>  	}
> =20
> +	if (delegation &&
> +	    test_bit(NFS_DELEGATION_DELEGTIME, &delegation->flags)) {
> +		if (delegation->type & FMODE_READ) {
> +			data->sattr.atime =3D inode_get_atime(inode);

I'm seeing the client try to set bad atimes with newly-created files.
To reproduce, I just created a file with vim on an NFS mount and wrote
a few bytes to it and then closed it.

The client gets a WRITE_DELEG_ATTRS delegation, and after I close the
file it does a SETATTR before the DELEGRETURN for TIME_DELEG_ACCESS and
TIME_DELEG_MODIFY. The mtime looks fine, but the atime is ~1500 seconds
after the epoch.

pcap is attached.

Cheers,

> +			data->sattr.atime_set =3D true;
> +		}
> +		if (delegation->type & FMODE_WRITE) {
> +			data->sattr.mtime =3D inode_get_mtime(inode);
> +			data->sattr.mtime_set =3D true;
> +		}
> +		data->args.sattr_args =3D &data->sattr;
> +		data->res.sattr_res =3D true;
> +	}
> +
>  	if (!data->inode)
>  		nfs4_init_sequence(&data->args.seq_args, &data->res.seq_res, 1,
>  				   1);
>  	else
>  		nfs4_init_sequence(&data->args.seq_args, &data->res.seq_res, 1,
>  				   0);
> +
>  	task_setup_data.callback_data =3D data;
>  	msg.rpc_argp =3D &data->args;
>  	msg.rpc_resp =3D &data->res;
> @@ -6814,13 +6832,16 @@ static int _nfs4_proc_delegreturn(struct inode *i=
node, const struct cred *cred,
>  	return status;
>  }
> =20
> -int nfs4_proc_delegreturn(struct inode *inode, const struct cred *cred, =
const nfs4_stateid *stateid, int issync)
> +int nfs4_proc_delegreturn(struct inode *inode, const struct cred *cred,
> +			  const nfs4_stateid *stateid,
> +			  struct nfs_delegation *delegation, int issync)
>  {
>  	struct nfs_server *server =3D NFS_SERVER(inode);
>  	struct nfs4_exception exception =3D { };
>  	int err;
>  	do {
> -		err =3D _nfs4_proc_delegreturn(inode, cred, stateid, issync);
> +		err =3D _nfs4_proc_delegreturn(inode, cred, stateid,
> +					     delegation, issync);
>  		trace_nfs4_delegreturn(inode, stateid, err);
>  		switch (err) {
>  			case -NFS4ERR_STALE_STATEID:

--=20
Jeff Layton <jlayton@kernel.org>

--=-yvyNYdxgQz8LlGj4e1IN
Content-Type: application/x-xz; name="bad_deleg_atime.pcapng.xz"
Content-Disposition: attachment; filename="bad_deleg_atime.pcapng.xz"
Content-Transfer-Encoding: base64

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
scRn+wIAAAAABFla


--=-yvyNYdxgQz8LlGj4e1IN--


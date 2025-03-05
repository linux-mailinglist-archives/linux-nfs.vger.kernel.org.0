Return-Path: <linux-nfs+bounces-10478-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F38F5A5024F
	for <lists+linux-nfs@lfdr.de>; Wed,  5 Mar 2025 15:40:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8A05B1898338
	for <lists+linux-nfs@lfdr.de>; Wed,  5 Mar 2025 14:37:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF44C24EF9E;
	Wed,  5 Mar 2025 14:34:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IcBgIWEj"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9A0724EF99
	for <linux-nfs@vger.kernel.org>; Wed,  5 Mar 2025 14:34:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741185287; cv=none; b=lDuVRUGYSBr49r5ewgBRzPjromqIq1cilFdcBPOASDPHCy8busPM0lYEpRUD23iNvuwHi6QI6PqAnbRl0Us88SztnB5UsFzrxy9T9FUbd8WgkACGbRMlSRi3oDobl5HXgGKJUvajuZTooGZs3ZeeytJBVdSFs1Aqa59jdM1oxmc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741185287; c=relaxed/simple;
	bh=SYEpFmorBfhvyHoDSPuyHa+brirUzcGnuB9MC4iYvvQ=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=OGfXGGpVjQDv/4RQq5Ln11Yf+yheX6sr5sdaR4zy0l19u8W5KniwCfF9YNI14OU17bGMHo45+FN2TNc5BA5asMEXNYfUJ8AimN64r4AtIAgZJdK/n5eOHExwZMcJXh6tOfydYCGnHi2Q1MlfLPbZA8ntv9j88YqJtp4JCmTrHeM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IcBgIWEj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0263BC4CEE0;
	Wed,  5 Mar 2025 14:34:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741185287;
	bh=SYEpFmorBfhvyHoDSPuyHa+brirUzcGnuB9MC4iYvvQ=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=IcBgIWEjSOxMl8lY1Ngz3n/qgCpLFGHzxm4uLN+5LB4eznJa0u790C8aaBI5gZ7ov
	 N6G9OKKgps7Q3TlYP2WQ+WAHRmPeGfFmeNTDjM7KtLjHyVKCZGhrTrOvXCRAT8T5Zx
	 IqYzKcKaMfIw7ANXx0WYDU1P2+xDcRFg6aML99axpL1bcVh4LHqMeyK/oXnyT5/U2e
	 6ovyBtyNaBePDrbDr5CFUPfwffoJX+ygdyXE/pPoIiYlf+4z63ulPBp/qPGBsm+Nl9
	 KT6dTz1SqIU+VT5qsx/wCKjGQUm2httK3nsXrMfHKFjip4K8cT1cN3OAkrIGfJweUD
	 94K7/UKXcLdmQ==
Message-ID: <22c1c21fde3a5b17851207664571341e3dcfc315.camel@kernel.org>
Subject: Re: [PATCH V4 2/2] NFSD: allow client to use write delegation
 stateid for READ
From: Jeff Layton <jlayton@kernel.org>
To: Dai Ngo <dai.ngo@oracle.com>, chuck.lever@oracle.com, neilb@suse.de, 
	okorniev@redhat.com, tom@talpey.com
Cc: linux-nfs@vger.kernel.org, sagi@grimberg.me
Date: Wed, 05 Mar 2025 09:34:45 -0500
In-Reply-To: <1741120693-2517-3-git-send-email-dai.ngo@oracle.com>
References: <1741120693-2517-1-git-send-email-dai.ngo@oracle.com>
	 <1741120693-2517-3-git-send-email-dai.ngo@oracle.com>
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

On Tue, 2025-03-04 at 12:38 -0800, Dai Ngo wrote:
> Allow READ using write delegation stateid granted on OPENs with
> OPEN4_SHARE_ACCESS_WRITE only, to accommodate clients whose WRITE
> implementation may unavoidably do (e.g., due to buffer cache
> constraints).
>=20
> For write delegation granted for OPEN with OPEN4_SHARE_ACCESS_WRITE
> a new nfsd_file and a struct file are allocated to use for reads.
> The nfsd_file is freed when the file is closed by release_all_access.
>=20
> Signed-off-by: Dai Ngo <dai.ngo@oracle.com>
> ---
>  fs/nfsd/nfs4state.c | 44 ++++++++++++++++++++++++++++++++++++--------
>  1 file changed, 36 insertions(+), 8 deletions(-)
>=20
> diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
> index b533225e57cf..35018af4e7fb 100644
> --- a/fs/nfsd/nfs4state.c
> +++ b/fs/nfsd/nfs4state.c
> @@ -6126,6 +6126,34 @@ nfs4_delegation_stat(struct nfs4_delegation *dp, s=
truct svc_fh *currentfh,
>  	return rc =3D=3D 0;
>  }
> =20
> +/*
> + * Add NFS4_SHARE_ACCESS_READ to the write delegation granted on OPEN
> + * with NFS4_SHARE_ACCESS_WRITE by allocating separate nfsd_file and
> + * struct file to be used for read with delegation stateid.
> + *
> + */
> +static bool
> +nfsd4_add_rdaccess_to_wrdeleg(struct svc_rqst *rqstp, struct nfsd4_open =
*open,
> +			      struct svc_fh *fh, struct nfs4_ol_stateid *stp)
> +{
> +	struct nfs4_file *fp;
> +	struct nfsd_file *nf =3D NULL;
> +
> +	if ((open->op_share_access & NFS4_SHARE_ACCESS_BOTH) =3D=3D
> +			NFS4_SHARE_ACCESS_WRITE) {
> +		if (nfsd_file_acquire_opened(rqstp, fh, NFSD_MAY_READ, NULL, &nf))
> +			return (false);
> +		fp =3D stp->st_stid.sc_file;
> +		spin_lock(&fp->fi_lock);
> +		__nfs4_file_get_access(fp, NFS4_SHARE_ACCESS_READ);
> +		set_access(NFS4_SHARE_ACCESS_READ, stp);
> +		fp =3D stp->st_stid.sc_file;
> +		fp->fi_fds[O_RDONLY] =3D nf;
> +		spin_unlock(&fp->fi_lock);
> +	}
> +	return (true);

no need for parenthesis here ^^^

> +}
> +
>  /*
>   * The Linux NFS server does not offer write delegations to NFSv4.0
>   * clients in order to avoid conflicts between write delegations and
> @@ -6151,8 +6179,9 @@ nfs4_delegation_stat(struct nfs4_delegation *dp, st=
ruct svc_fh *currentfh,
>   * open or lock state.
>   */
>  static void
> -nfs4_open_delegation(struct nfsd4_open *open, struct nfs4_ol_stateid *st=
p,
> -		     struct svc_fh *currentfh)
> +nfs4_open_delegation(struct svc_rqst *rqstp, struct nfsd4_open *open,
> +		     struct nfs4_ol_stateid *stp, struct svc_fh *currentfh,
> +		     struct svc_fh *fh)
>  {
>  	bool deleg_ts =3D open->op_deleg_want & OPEN4_SHARE_ACCESS_WANT_DELEG_T=
IMESTAMPS;
>  	struct nfs4_openowner *oo =3D openowner(stp->st_stateowner);
> @@ -6197,7 +6226,8 @@ nfs4_open_delegation(struct nfsd4_open *open, struc=
t nfs4_ol_stateid *stp,
>  	memcpy(&open->op_delegate_stateid, &dp->dl_stid.sc_stateid, sizeof(dp->=
dl_stid.sc_stateid));
> =20
>  	if (open->op_share_access & NFS4_SHARE_ACCESS_WRITE) {
> -		if (!nfs4_delegation_stat(dp, currentfh, &stat)) {
> +		if ((!nfsd4_add_rdaccess_to_wrdeleg(rqstp, open, fh, stp)) ||

extra set of parens above too ^^^

> +				!nfs4_delegation_stat(dp, currentfh, &stat)) {
>  			nfs4_put_stid(&dp->dl_stid);
>  			destroy_delegation(dp);
>  			goto out_no_deleg;
> @@ -6353,7 +6383,8 @@ nfsd4_process_open2(struct svc_rqst *rqstp, struct =
svc_fh *current_fh, struct nf
>  	* Attempt to hand out a delegation. No error return, because the
>  	* OPEN succeeds even if we fail.
>  	*/
> -	nfs4_open_delegation(open, stp, &resp->cstate.current_fh);
> +	nfs4_open_delegation(rqstp, open, stp,
> +		&resp->cstate.current_fh, current_fh);
> =20
>  	/*
>  	 * If there is an existing open stateid, it must be updated and
> @@ -7098,10 +7129,6 @@ nfs4_find_file(struct nfs4_stid *s, int flags)
> =20
>  	switch (s->sc_type) {
>  	case SC_TYPE_DELEG:
> -		spin_lock(&s->sc_file->fi_lock);
> -		ret =3D nfsd_file_get(s->sc_file->fi_deleg_file);
> -		spin_unlock(&s->sc_file->fi_lock);
> -		break;
>  	case SC_TYPE_OPEN:
>  	case SC_TYPE_LOCK:
>  		if (flags & RD_STATE)
> @@ -7277,6 +7304,7 @@ nfs4_preprocess_stateid_op(struct svc_rqst *rqstp,
>  		status =3D find_cpntf_state(nn, stateid, &s);
>  	if (status)
>  		return status;
> +
>  	status =3D nfsd4_stid_check_stateid_generation(stateid, s,
>  			nfsd4_has_session(cstate));
>  	if (status)

Patch itself looks good though, so with the nits fixed up, you can add:

Reviewed-by: Jeff Layton <jlayton@kernel.org>


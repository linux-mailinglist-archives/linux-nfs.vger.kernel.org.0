Return-Path: <linux-nfs+bounces-13749-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 72BB8B2B1DB
	for <lists+linux-nfs@lfdr.de>; Mon, 18 Aug 2025 21:47:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2D0DF16824A
	for <lists+linux-nfs@lfdr.de>; Mon, 18 Aug 2025 19:46:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC4811F37D3;
	Mon, 18 Aug 2025 19:46:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MUCZo6eq"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C659186349
	for <linux-nfs@vger.kernel.org>; Mon, 18 Aug 2025 19:46:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755546367; cv=none; b=CzVO42JbTRHXaBFeYMSnUJk1OLbuy7riVsjbf22240klnnFIensgUZLxEYLJS50YOv1aPQM3ck58uz9HhnkaINjeODHzzvnG0h9PGI3JpZURA7ml7hye6mx2EelfxmvZ3yapNNuzRn/CTi+vUobErldmrOBCKmXyEhDas4EWnWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755546367; c=relaxed/simple;
	bh=GBaRLjIlz5cV0wuWgrtXChqslrHskKFr81BA40vROHw=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=YGdVZK808VK3LbRQzxP64ER5YNZwSJW1Wbt/5dQJuFmnFSxuhp29eLdjtd9IBkSovTe8cH2JTzZs3OfVyAvCmMkzibBtTKsEPtm23DnsMMUP/BhMIVh3ViqieSxrlkvZzLgbM/SJhy3f1igS37bpPVClWXQTxA8uAzFUnA+m5k8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MUCZo6eq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E073C4CEEB;
	Mon, 18 Aug 2025 19:46:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755546367;
	bh=GBaRLjIlz5cV0wuWgrtXChqslrHskKFr81BA40vROHw=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=MUCZo6eqYk7d1bx/CbKNbx84zoGwsycKtiQzvoZnIw8eZS21Uap+jBvX2BYE66hut
	 QQbJJS48NHsW91DFCp43VTBW9fQ6xtz+0bhAy5riAV1lEoX3cEMNEboBhxwLU2ERDE
	 YWF8SqBlCWBfNJA5jkKyvpK8EhqT73M8DAm58uOSHNysAylQDXxUAYdrNzRuHi8bPq
	 y1kcxq4Y/q7G0myjLzocRPNRQuYb2jsA5net1QF4O2Q6Bw7KdjFDEN/stt6yqZ8EmC
	 WIttYS9ClWmMi6HntQAGfJrFxlDNStEM1b02fNQhDwmAp0tFx61roBL7w+ZGpE4o6b
	 vFFDyaXIybQRg==
Message-ID: <e5052736e0d18f153bd3c3a9b75a7349218b5697.camel@kernel.org>
Subject: Re: [PATCH v7 6/7] NFSD: issue WRITEs using O_DIRECT even if IO is
 misaligned
From: Jeff Layton <jlayton@kernel.org>
To: Mike Snitzer <snitzer@kernel.org>, Chuck Lever <chuck.lever@oracle.com>
Cc: linux-nfs@vger.kernel.org
Date: Mon, 18 Aug 2025 15:46:06 -0400
In-Reply-To: <20250815144607.50967-7-snitzer@kernel.org>
References: <20250815144607.50967-1-snitzer@kernel.org>
	 <20250815144607.50967-7-snitzer@kernel.org>
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
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2025-08-15 at 10:46 -0400, Mike Snitzer wrote:
> If NFSD_IO_DIRECT is used, split any misaligned WRITE into a start,
> middle and end as needed. The large middle extent is DIO-aligned and
> the start and/or end are misaligned. Buffered IO is used for the
> misaligned extents and O_DIRECT is used for the middle DIO-aligned
> extent.
>=20
> Signed-off-by: Mike Snitzer <snitzer@kernel.org>
> ---
>  fs/nfsd/vfs.c | 176 +++++++++++++++++++++++++++++++++++++++++++++++---
>  1 file changed, 168 insertions(+), 8 deletions(-)
>=20
> diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
> index 64732dc8985d6..afcc22fdddefc 100644
> --- a/fs/nfsd/vfs.c
> +++ b/fs/nfsd/vfs.c
> @@ -1355,6 +1355,169 @@ static int wait_for_concurrent_writes(struct file=
 *file)
>  	return err;
>  }
> =20
> +struct nfsd_write_dio {
> +	loff_t middle_offset;	/* Offset for start of DIO-aligned middle */
> +	loff_t end_offset;	/* Offset for start of DIO-aligned end */
> +	ssize_t	start_len;	/* Length for misaligned first extent */
> +	ssize_t	middle_len;	/* Length for DIO-aligned middle extent */
> +	ssize_t	end_len;	/* Length for misaligned last extent */
> +};
> +
> +static bool
> +nfsd_analyze_write_dio(struct svc_rqst *rqstp, struct svc_fh *fhp,
> +		       struct nfsd_file *nf, loff_t offset,
> +		       unsigned long len, struct nfsd_write_dio *write_dio)
> +{
> +	const u32 dio_blocksize =3D nf->nf_dio_offset_align;
> +	loff_t orig_end, middle_end, start_end, start_offset =3D offset;
> +	ssize_t start_len =3D len;
> +
> +	if (WARN_ONCE(!nf->nf_dio_mem_align || !dio_blocksize,
> +		      "%s: underlying filesystem has not provided DIO alignment info\n=
",
> +		      __func__))
> +		return false;
> +	if (WARN_ONCE(dio_blocksize > PAGE_SIZE,
> +		      "%s: underlying storage's dio_blocksize=3D%u > PAGE_SIZE=3D%lu\n=
",
> +		      __func__, dio_blocksize, PAGE_SIZE))
> +		return false;
> +	if (unlikely(len < dio_blocksize))
> +		return false;
> +
> +	memset(write_dio, 0, sizeof(*write_dio));
> +
> +	if (((offset | len) & (dio_blocksize-1)) =3D=3D 0) {
> +		/* already DIO-aligned, no misaligned head or tail */
> +		write_dio->middle_offset =3D offset;
> +		write_dio->middle_len =3D len;
> +		/* clear these for the benefit of trace_nfsd_analyze_write_dio */
> +		start_offset =3D 0;
> +		start_len =3D 0;
> +		return true;
> +	}
> +
> +	start_end =3D round_up(offset, dio_blocksize);
> +	start_len =3D start_end - offset;
> +	orig_end =3D offset + len;
> +	middle_end =3D round_down(orig_end, dio_blocksize);
> +
> +	write_dio->start_len =3D start_len;
> +	write_dio->middle_offset =3D start_end;
> +	write_dio->middle_len =3D middle_end - start_end;
> +	write_dio->end_offset =3D middle_end;
> +	write_dio->end_len =3D orig_end - middle_end;
> +
> +	return true;
> +}
> +
> +/*
> + * Setup as many as 3 iov_iter based on extents described by @write_dio.
> + * @iterp: pointer to pointer to onstack array of 3 iov_iter structs fro=
m caller.
> + * @iter_is_dio_aligned: pointer to onstack array of 3 bools from caller=
.
> + * @rq_bvec: backing bio_vec used to setup all 3 iov_iter permutations.
> + * @nvecs: number of segments in @rq_bvec
> + * @cnt: size of the request in bytes
> + * @write_dio: nfsd_write_dio struct that describes start, middle and en=
d extents.
> + *
> + * Returns the number of iov_iter that were setup.
> + */
> +static int
> +nfsd_setup_write_dio_iters(struct iov_iter **iterp, bool *iter_is_dio_al=
igned,
> +			   struct bio_vec *rq_bvec, unsigned int nvecs,
> +			   unsigned long cnt, struct nfsd_write_dio *write_dio)
> +{
> +	int n_iters =3D 0;
> +	struct iov_iter *iters =3D *iterp;
> +
> +	/* Setup misaligned start? */
> +	if (write_dio->start_len) {
> +		iter_is_dio_aligned[n_iters] =3D false;
> +		iov_iter_bvec(&iters[n_iters], ITER_SOURCE, rq_bvec, nvecs, cnt);
> +		iters[n_iters].count =3D write_dio->start_len;
> +		++n_iters;
> +	}
> +
> +	/* Setup DIO-aligned middle */
> +	iter_is_dio_aligned[n_iters] =3D true;
> +	iov_iter_bvec(&iters[n_iters], ITER_SOURCE, rq_bvec, nvecs, cnt);
> +	if (write_dio->start_len)
> +		iov_iter_advance(&iters[n_iters], write_dio->start_len);
> +	iters[n_iters].count -=3D write_dio->end_len;
> +	++n_iters;
> +
> +	/* Setup misaligned end? */
> +	if (write_dio->end_len) {
> +		iter_is_dio_aligned[n_iters] =3D false;
> +		iov_iter_bvec(&iters[n_iters], ITER_SOURCE, rq_bvec, nvecs, cnt);
> +		iov_iter_advance(&iters[n_iters],
> +				 write_dio->start_len + write_dio->middle_len);
> +		++n_iters;
> +	}
> +
> +	return n_iters;
> +}
> +
> +static int
> +nfsd_issue_write_buffered(struct svc_rqst *rqstp, struct file *file,
> +			  unsigned int nvecs, unsigned long *cnt,
> +			  struct kiocb *kiocb)
> +{
> +	struct iov_iter iter;
> +	int host_err;
> +
> +	iov_iter_bvec(&iter, ITER_SOURCE, rqstp->rq_bvec, nvecs, *cnt);
> +	host_err =3D vfs_iocb_iter_write(file, kiocb, &iter);
> +	if (host_err < 0)
> +		return host_err;
> +	*cnt =3D host_err;
> +
> +	return 0;
> +}
> +
> +static noinline int
> +nfsd_issue_write_dio(struct svc_rqst *rqstp, struct svc_fh *fhp,
> +		     struct nfsd_file *nf, loff_t offset,
> +		     unsigned int nvecs, unsigned long *cnt,
> +		     struct kiocb *kiocb)
> +{
> +	struct nfsd_write_dio write_dio;
> +	struct file *file =3D nf->nf_file;
> +
> +	if (!nfsd_analyze_write_dio(rqstp, fhp, nf, offset, *cnt, &write_dio))
> +		return nfsd_issue_write_buffered(rqstp, file, nvecs, cnt, kiocb);
> +	else {
> +		bool iter_is_dio_aligned[3];
> +		struct iov_iter iter_stack[3];
> +		struct iov_iter *iter =3D iter_stack;
> +		unsigned int n_iters =3D 0;
> +		int host_err;
> +
> +		n_iters =3D nfsd_setup_write_dio_iters(&iter, iter_is_dio_aligned,
> +				rqstp->rq_bvec, nvecs, *cnt, &write_dio);
> +		*cnt =3D 0;
> +		for (int i =3D 0; i < n_iters; i++) {
> +			if (iter_is_dio_aligned[i] &&
> +			    nfsd_iov_iter_aligned_bvec(&iter[i], nf->nf_dio_mem_align-1,
> +						       nf->nf_dio_offset_align-1))
> +				kiocb->ki_flags |=3D IOCB_DIRECT;
> +			else
> +				kiocb->ki_flags &=3D ~IOCB_DIRECT;
> +			host_err =3D vfs_iocb_iter_write(file, kiocb, &iter[i]);
> +			if (host_err < 0) {
> +				/* Underlying FS will return -EINVAL if misaligned
> +				 * DIO is attempted because it shouldn't be.
> +				 */
> +				WARN_ON_ONCE(host_err =3D=3D -EINVAL);
> +				return host_err;
> +			}
> +			*cnt +=3D host_err;
> +			if (host_err < iter[i].count) /* partial write? */
> +				return *cnt;
> +		}

If this ends up doing some buffered I/Os on the unaligned end bits,
should we have it issue a vfs_fsync_range() (or maybe use IOCB_SYNC)
here as well to ensure that those bits get written back before sending
the reply? I worry a bit about an aligned (DIO) read of a page racing
in and not seeing data that hasn't been written back yet.

> +	}
> +
> +	return 0;
> +}
> +
>  /**
>   * nfsd_vfs_write - write data to an already-open file
>   * @rqstp: RPC execution context
> @@ -1382,7 +1545,6 @@ nfsd_vfs_write(struct svc_rqst *rqstp, struct svc_f=
h *fhp,
>  	struct super_block	*sb =3D file_inode(file)->i_sb;
>  	struct kiocb		kiocb;
>  	struct svc_export	*exp;
> -	struct iov_iter		iter;
>  	errseq_t		since;
>  	__be32			nfserr;
>  	int			host_err;
> @@ -1419,31 +1581,29 @@ nfsd_vfs_write(struct svc_rqst *rqstp, struct svc=
_fh *fhp,
>  		kiocb.ki_flags |=3D IOCB_DSYNC;
> =20
>  	nvecs =3D xdr_buf_to_bvec(rqstp->rq_bvec, rqstp->rq_maxpages, payload);
> -	iov_iter_bvec(&iter, ITER_SOURCE, rqstp->rq_bvec, nvecs, *cnt);
> +
>  	since =3D READ_ONCE(file->f_wb_err);
>  	if (verf)
>  		nfsd_copy_write_verifier(verf, nn);
> =20
>  	switch (nfsd_io_cache_write) {
>  	case NFSD_IO_DIRECT:
> -		/* direct I/O must be aligned to device logical sector size */
> -		if (nf->nf_dio_mem_align && nf->nf_dio_offset_align &&
> -		    (((offset | *cnt) & (nf->nf_dio_offset_align-1)) =3D=3D 0))
> -			kiocb.ki_flags |=3D IOCB_DIRECT;
> +		host_err =3D nfsd_issue_write_dio(rqstp, fhp, nf, offset,
> +						nvecs, cnt, &kiocb);
>  		break;
>  	case NFSD_IO_DONTCACHE:
>  		kiocb.ki_flags |=3D IOCB_DONTCACHE;
>  		fallthrough;
>  	case NFSD_IO_UNSPECIFIED:
>  	case NFSD_IO_BUFFERED:
> +		host_err =3D nfsd_issue_write_buffered(rqstp, file,
> +						nvecs, cnt, &kiocb);
>  		break;
>  	}
> -	host_err =3D vfs_iocb_iter_write(file, &kiocb, &iter);
>  	if (host_err < 0) {
>  		commit_reset_write_verifier(nn, rqstp, host_err);
>  		goto out_nfserr;
>  	}
> -	*cnt =3D host_err;
>  	nfsd_stats_io_write_add(nn, exp, *cnt);
>  	fsnotify_modify(file);
>  	host_err =3D filemap_check_wb_err(file->f_mapping, since);

--=20
Jeff Layton <jlayton@kernel.org>


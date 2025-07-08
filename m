Return-Path: <linux-nfs+bounces-12927-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 94084AFCDB5
	for <lists+linux-nfs@lfdr.de>; Tue,  8 Jul 2025 16:34:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4D4E27B2451
	for <lists+linux-nfs@lfdr.de>; Tue,  8 Jul 2025 14:33:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A0E42E03F1;
	Tue,  8 Jul 2025 14:34:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O6pvcaSh"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F4F621B184;
	Tue,  8 Jul 2025 14:34:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751985258; cv=none; b=R4wv+RGaDsGawQorS7/vThvqcoBk0MbQgC/3hJszpMvDs/c30RpH3U9/OgXkNezq7Yf4OH9/UrOIvvxGot9/8fyS6VFGFg7P5CnHkVo8O5ngPvvEkEURQ7ziwciIr5v3ES432jc7kfBX76e5cCFE7jhShmxeaRCwj/YUG40n13U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751985258; c=relaxed/simple;
	bh=UdxhaBVzFZfTm5naFiZZgw2/CTDHYA/R6Mpy1RLP0mk=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=iScOUzBQslyJMWZTWM9AjydBFlHlZ/l+5eHP0vwWOglRRTuGFd6TdDzM3dF7++pdkdG0zw3ep6ETyqE/gABrfkvruIcggRv9fi9AH0ZhwXEjMP10nLpgNwXOgen4JKAVSXj5Z6586KVHBxVtQScOc7kwXrYJgmsLgsYj6qTbqqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O6pvcaSh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D19CFC4CEED;
	Tue,  8 Jul 2025 14:34:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751985257;
	bh=UdxhaBVzFZfTm5naFiZZgw2/CTDHYA/R6Mpy1RLP0mk=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=O6pvcaShM2rlTjm4BDrgLkXsFee9nj0yjbRpSOMnA9FtnbIsfVuF/ypvkp6F+eyyP
	 qDUoJzptIj+curz+7LNO+VV/ZRTdvYDKavY3YkRnnqoOSwtmvvZ7Jkv7aA8zG9feNO
	 bkjfp3eouyMH4RA4vjVfNPnEJbIWeL6WMSEl7a4uUkZH74EiBmyRgK/SV+FUVfl2bB
	 a2v9NpHSWMBiM4n0ElUGjMPv5RKconGAyUNA+9Htl1hE+VS70zk3fJ8D0H5COVNlWB
	 ImUMajFNBiwJ1U+3c4kf2sU/kTW03ytdLg+qgR6ZFXUfzLyX0FYEETGHGowlAbjX4n
	 ZV3jTmpYyhH3A==
Message-ID: <cda4542e4ae8b30a6f5628386388f813d3209558.camel@kernel.org>
Subject: Re: [PATCH RFC 2/2] nfsd: call generic_fadvise after v3 READ,
 stable WRITE or COMMIT
From: Jeff Layton <jlayton@kernel.org>
To: Chuck Lever <chuck.lever@oracle.com>, Trond Myklebust
 <trondmy@kernel.org>,  Anna Schumaker	 <anna@kernel.org>, NeilBrown
 <neil@brown.name>, Olga Kornievskaia	 <okorniev@redhat.com>, Dai Ngo
 <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>,  Mike Snitzer
 <snitzer@kernel.org>
Cc: linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Tue, 08 Jul 2025 10:34:15 -0400
In-Reply-To: <520bd301-4526-4364-bbfa-5f591ab8f60a@oracle.com>
References: <20250703-nfsd-testing-v1-0-cece54f36556@kernel.org>
	 <20250703-nfsd-testing-v1-2-cece54f36556@kernel.org>
	 <520bd301-4526-4364-bbfa-5f591ab8f60a@oracle.com>
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
Content-Type: multipart/mixed; boundary="=-vZv7rRJiZkN9TNqY/qEc"
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

--=-vZv7rRJiZkN9TNqY/qEc
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 2025-07-03 at 16:07 -0400, Chuck Lever wrote:
> On 7/3/25 3:53 PM, Jeff Layton wrote:
> > Recent testing has shown that keeping pagecache pages around for too
> > long can be detrimental to performance with nfsd. Clients only rarely
> > revisit the same data, so the pages tend to just hang around.
> >=20
> > This patch changes the pc_release callbacks for NFSv3 READ, WRITE and
> > COMMIT to call generic_fadvise(..., POSIX_FADV_DONTNEED) on the accesse=
d
> > range.
> >=20
> > Signed-off-by: Jeff Layton <jlayton@kernel.org>
> > ---
> >  fs/nfsd/debugfs.c  |  2 ++
> >  fs/nfsd/nfs3proc.c | 59 +++++++++++++++++++++++++++++++++++++++++++++-=
--------
> >  fs/nfsd/nfsd.h     |  1 +
> >  fs/nfsd/nfsproc.c  |  4 ++--
> >  fs/nfsd/vfs.c      | 21 ++++++++++++++-----
> >  fs/nfsd/vfs.h      |  5 +++--
> >  fs/nfsd/xdr3.h     |  3 +++
> >  7 files changed, 77 insertions(+), 18 deletions(-)
> >=20
> > diff --git a/fs/nfsd/debugfs.c b/fs/nfsd/debugfs.c
> > index 84b0c8b559dc90bd5c2d9d5e15c8e0682c0d610c..b007718dd959bc081166ec8=
4e06f577a8fc2b46b 100644
> > --- a/fs/nfsd/debugfs.c
> > +++ b/fs/nfsd/debugfs.c
> > @@ -44,4 +44,6 @@ void nfsd_debugfs_init(void)
> > =20
> >  	debugfs_create_file("disable-splice-read", S_IWUSR | S_IRUGO,
> >  			    nfsd_top_dir, NULL, &nfsd_dsr_fops);
> > +	debugfs_create_bool("enable-fadvise-dontneed", 0644,
> > +			    nfsd_top_dir, &nfsd_enable_fadvise_dontneed);
>=20
> I prefer that this setting is folded into the new io_cache_read /
> io_cache_write tune-ables that Mike's patch adds, rather than adding
> a new boolean.
>=20
> That might make a hybrid "DONTCACHE for READ and fadvise for WRITE"
> pretty easy.
>=20

I ended up rebasing Mike's dontcache branch on top of v6.16-rc5 with
all of Chuck's trees in. I then added the attached patch and did some
testing with a couple of machines I checked out internally at Meta.
This is the throughput results with the fio-seq-RW test with the file
size set to 100G and the duration at 5 mins.

Note that:

read and writes buffered:
   READ: bw=3D3024MiB/s (3171MB/s), 186MiB/s-191MiB/s (195MB/s-201MB/s), io=
=3D889GiB (954GB), run=3D300012-300966msec
  WRITE: bw=3D2015MiB/s (2113MB/s), 124MiB/s-128MiB/s (131MB/s-134MB/s), io=
=3D592GiB (636GB), run=3D300012-300966msec

   READ: bw=3D2902MiB/s (3043MB/s), 177MiB/s-183MiB/s (186MB/s-192MB/s), io=
=3D851GiB (913GB), run=3D300027-300118msec
  WRITE: bw=3D1934MiB/s (2027MB/s), 119MiB/s-122MiB/s (124MB/s-128MB/s), io=
=3D567GiB (608GB), run=3D300027-300118msec

   READ: bw=3D2897MiB/s (3037MB/s), 178MiB/s-183MiB/s (186MB/s-192MB/s), io=
=3D849GiB (911GB), run=3D300006-300078msec
  WRITE: bw=3D1930MiB/s (2023MB/s), 119MiB/s-122MiB/s (125MB/s-128MB/s), io=
=3D565GiB (607GB), run=3D300006-300078msec

reads and writes RWF_DONTCACHE:
   READ: bw=3D3090MiB/s (3240MB/s), 190MiB/s-195MiB/s (199MB/s-205MB/s), io=
=3D906GiB (972GB), run=3D300015-300113msec
  WRITE: bw=3D2060MiB/s (2160MB/s), 126MiB/s-130MiB/s (132MB/s-137MB/s), io=
=3D604GiB (648GB), run=3D300015-300113msec

   READ: bw=3D3057MiB/s (3205MB/s), 188MiB/s-193MiB/s (198MB/s-203MB/s), io=
=3D897GiB (963GB), run=3D300329-300450msec
  WRITE: bw=3D2037MiB/s (2136MB/s), 126MiB/s-129MiB/s (132MB/s-135MB/s), io=
=3D598GiB (642GB), run=3D300329-300450msec

   READ: bw=3D3166MiB/s (3320MB/s), 196MiB/s-200MiB/s (205MB/s-210MB/s), io=
=3D928GiB (996GB), run=3D300021-300090msec
  WRITE: bw=3D2111MiB/s (2213MB/s), 131MiB/s-133MiB/s (137MB/s-140MB/s), io=
=3D619GiB (664GB), run=3D300021-300090msec

reads and writes witg O_DIRECT:
   READ: bw=3D3115MiB/s (3267MB/s), 192MiB/s-198MiB/s (201MB/s-208MB/s), io=
=3D913GiB (980GB), run=3D300025-300078msec
  WRITE: bw=3D2077MiB/s (2178MB/s), 128MiB/s-131MiB/s (134MB/s-138MB/s), io=
=3D609GiB (653GB), run=3D300025-300078msec

   READ: bw=3D3189MiB/s (3343MB/s), 197MiB/s-202MiB/s (207MB/s-211MB/s), io=
=3D934GiB (1003GB), run=3D300023-300096msec
  WRITE: bw=3D2125MiB/s (2228MB/s), 132MiB/s-134MiB/s (138MB/s-140MB/s), io=
=3D623GiB (669GB), run=3D300023-300096msec

   READ: bw=3D3113MiB/s (3264MB/s), 191MiB/s-197MiB/s (200MB/s-207MB/s), io=
=3D912GiB (979GB), run=3D300020-300098msec
  WRITE: bw=3D2075MiB/s (2175MB/s), 127MiB/s-131MiB/s (134MB/s-138MB/s), io=
=3D608GiB (653GB), run=3D300020-300098msec

RWF_DONTCACHE on reads and stable writes + fadvise DONTNEED after COMMIT:
   READ: bw=3D2888MiB/s (3029MB/s), 178MiB/s-182MiB/s (187MB/s-191MB/s), io=
=3D846GiB (909GB), run=3D300012-300109msec
  WRITE: bw=3D1924MiB/s (2017MB/s), 118MiB/s-121MiB/s (124MB/s-127MB/s), io=
=3D564GiB (605GB), run=3D300012-300109msec

   READ: bw=3D2899MiB/s (3040MB/s), 180MiB/s-183MiB/s (188MB/s-192MB/s), io=
=3D852GiB (915GB), run=3D300022-300940msec
  WRITE: bw=3D1931MiB/s (2025MB/s), 119MiB/s-122MiB/s (125MB/s-128MB/s), io=
=3D567GiB (609GB), run=3D300022-300940msec

   READ: bw=3D2902MiB/s (3043MB/s), 179MiB/s-184MiB/s (188MB/s-193MB/s), io=
=3D853GiB (916GB), run=3D300913-301146msec
  WRITE: bw=3D1933MiB/s (2027MB/s), 119MiB/s-122MiB/s (125MB/s-128MB/s), io=
=3D568GiB (610GB), run=3D300913-301146msec


The fadvise case is clearly slower than the others. Interestingly it
also slowed down read performance, which leads me to believe that maybe
the fadvise calls were interfering with concurrent reads. Given the
disappointing numbers, I'll probably drop the last patch.

There is probably a case to be made for patch #1, on the general
principle of expediting sending the reply as much as possible. Chuck,
let me know if you want me to submit that individually.
--=20
Jeff Layton <jlayton@kernel.org>

--=-vZv7rRJiZkN9TNqY/qEc
Content-Disposition: attachment;
	filename*0=0001-nfsd-add-a-NFSD_IO_FADVISE-setting-to-io_cache_write.pat;
	filename*1=ch
Content-Type: text/x-patch;
	name="0001-nfsd-add-a-NFSD_IO_FADVISE-setting-to-io_cache_write.patch";
	charset="UTF-8"
Content-Transfer-Encoding: base64

RnJvbSAxNDk1ODUxNmJmNDVmOTJhODYwOWNiNmFkNTA0ZTkyNTUwYjQxNmQ3IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBKZWZmIExheXRvbiA8amxheXRvbkBrZXJuZWwub3JnPgpEYXRl
OiBNb24sIDcgSnVsIDIwMjUgMTE6MDA6MzQgLTA0MDAKU3ViamVjdDogW1BBVENIXSBuZnNkOiBh
ZGQgYSBORlNEX0lPX0ZBRFZJU0Ugc2V0dGluZyB0byBpb19jYWNoZV93cml0ZQoKU2lnbmVkLW9m
Zi1ieTogSmVmZiBMYXl0b24gPGpsYXl0b25Aa2VybmVsLm9yZz4KLS0tCiBmcy9uZnNkL2RlYnVn
ZnMuYyAgfCAgMiArKwogZnMvbmZzZC9uZnMzcHJvYy5jIHwgMjQgKysrKysrKysrKysrKysrKysr
Ky0tLS0tCiBmcy9uZnNkL25mc2QuaCAgICAgfCAgMyArKy0KIGZzL25mc2QvdmZzLmMgICAgICB8
ICA0ICsrKysKIGZzL25mc2QveGRyMy5oICAgICB8ICAxICsKIDUgZmlsZXMgY2hhbmdlZCwgMjgg
aW5zZXJ0aW9ucygrKSwgNiBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS9mcy9uZnNkL2RlYnVn
ZnMuYyBiL2ZzL25mc2QvZGVidWdmcy5jCmluZGV4IGZhZGYxZDg4ZjY0MC4uZDBmN2RmZTZkNjIx
IDEwMDY0NAotLS0gYS9mcy9uZnNkL2RlYnVnZnMuYworKysgYi9mcy9uZnNkL2RlYnVnZnMuYwpA
QCAtODksNiArODksNyBAQCBERUZJTkVfREVCVUdGU19BVFRSSUJVVEUobmZzZF9pb19jYWNoZV9y
ZWFkX2ZvcHMsIG5mc2RfaW9fY2FjaGVfcmVhZF9nZXQsCiAgKiAgICUwOiBORlMgV1JJVEUgd2ls
bCB1c2UgYnVmZmVyZWQgSU8gKGRlZmF1bHQpCiAgKiAgICUxOiBORlMgV1JJVEUgd2lsbCB1c2Ug
ZG9udGNhY2hlIChidWZmZXJlZCBJTyB3LyBkcm9wYmVoaW5kKQogICogICAlMjogTkZTIFdSSVRF
IHdpbGwgdXNlIGRpcmVjdCBJTworICogICAlMzogTkZTIHN0YWJsZSBXUklURSB3aWxsIHVzZSBk
b250Y2FjaGUgKyBmYWR2aXNlIERPTlRORUVEIGFmdGVyIENPTU1JVAogICoKICAqIFRoZSBkZWZh
dWx0IHZhbHVlIG9mIHRoaXMgc2V0dGluZyBpcyB6ZXJvIChidWZmZXJlZCBJTyBpcwogICogdXNl
ZCkuIFRoaXMgc2V0dGluZyB0YWtlcyBpbW1lZGlhdGUgZWZmZWN0IGZvciBhbGwgTkZTCkBAIC0x
MDcsNiArMTA4LDcgQEAgc3RhdGljIGludCBuZnNkX2lvX2NhY2hlX3dyaXRlX3NldCh2b2lkICpk
YXRhLCB1NjQgdmFsKQogCWNhc2UgTkZTRF9JT19CVUZGRVJFRDoKIAljYXNlIE5GU0RfSU9fRE9O
VENBQ0hFOgogCWNhc2UgTkZTRF9JT19ESVJFQ1Q6CisJY2FzZSBORlNEX0lPX0ZBRFZJU0U6CiAJ
CW5mc2RfaW9fY2FjaGVfd3JpdGUgPSB2YWw7CiAJCWJyZWFrOwogCWRlZmF1bHQ6CmRpZmYgLS1n
aXQgYS9mcy9uZnNkL25mczNwcm9jLmMgYi9mcy9uZnNkL25mczNwcm9jLmMKaW5kZXggYjZkMDNl
MWVmNWY3Li42NzM3ZDIyYzAwMWQgMTAwNjQ0Ci0tLSBhL2ZzL25mc2QvbmZzM3Byb2MuYworKysg
Yi9mcy9uZnNkL25mczNwcm9jLmMKQEAgLTksNiArOSw3IEBACiAjaW5jbHVkZSA8bGludXgvZXh0
Ml9mcy5oPgogI2luY2x1ZGUgPGxpbnV4L21hZ2ljLmg+CiAjaW5jbHVkZSA8bGludXgvbmFtZWku
aD4KKyNpbmNsdWRlIDxsaW51eC9mYWR2aXNlLmg+CiAKICNpbmNsdWRlICJjYWNoZS5oIgogI2lu
Y2x1ZGUgInhkcjMuaCIKQEAgLTc0OCw3ICs3NDksNiBAQCBuZnNkM19wcm9jX2NvbW1pdChzdHJ1
Y3Qgc3ZjX3Jxc3QgKnJxc3RwKQogewogCXN0cnVjdCBuZnNkM19jb21taXRhcmdzICphcmdwID0g
cnFzdHAtPnJxX2FyZ3A7CiAJc3RydWN0IG5mc2QzX2NvbW1pdHJlcyAqcmVzcCA9IHJxc3RwLT5y
cV9yZXNwOwotCXN0cnVjdCBuZnNkX2ZpbGUgKm5mOwogCiAJZHByaW50aygibmZzZDogQ09NTUlU
KDMpICAgJXMgJXVAJUx1XG4iLAogCQkJCVNWQ0ZIX2ZtdCgmYXJncC0+ZmgpLApAQCAtNzU3LDE3
ICs3NTcsMzEgQEAgbmZzZDNfcHJvY19jb21taXQoc3RydWN0IHN2Y19ycXN0ICpycXN0cCkKIAog
CWZoX2NvcHkoJnJlc3AtPmZoLCAmYXJncC0+ZmgpOwogCXJlc3AtPnN0YXR1cyA9IG5mc2RfZmls
ZV9hY3F1aXJlX2djKHJxc3RwLCAmcmVzcC0+ZmgsIE5GU0RfTUFZX1dSSVRFIHwKLQkJCQkJICAg
IE5GU0RfTUFZX05PVF9CUkVBS19MRUFTRSwgJm5mKTsKKwkJCQkJICAgIE5GU0RfTUFZX05PVF9C
UkVBS19MRUFTRSwgJnJlc3AtPm5mKTsKIAlpZiAocmVzcC0+c3RhdHVzKQogCQlnb3RvIG91dDsK
LQlyZXNwLT5zdGF0dXMgPSBuZnNkX2NvbW1pdChycXN0cCwgJnJlc3AtPmZoLCBuZiwgYXJncC0+
b2Zmc2V0LAorCXJlc3AtPnN0YXR1cyA9IG5mc2RfY29tbWl0KHJxc3RwLCAmcmVzcC0+ZmgsIHJl
c3AtPm5mLCBhcmdwLT5vZmZzZXQsCiAJCQkJICAgYXJncC0+Y291bnQsIHJlc3AtPnZlcmYpOwot
CW5mc2RfZmlsZV9wdXQobmYpOwogb3V0OgogCXJlc3AtPnN0YXR1cyA9IG5mc2QzX21hcF9zdGF0
dXMocmVzcC0+c3RhdHVzKTsKIAlyZXR1cm4gcnBjX3N1Y2Nlc3M7CiB9CiAKK3N0YXRpYyB2b2lk
CituZnNkM19yZWxlYXNlX2NvbW1pdChzdHJ1Y3Qgc3ZjX3Jxc3QgKnJxc3RwKQoreworCXN0cnVj
dCBuZnNkM19jb21taXRhcmdzICphcmdwID0gcnFzdHAtPnJxX2FyZ3A7CisJc3RydWN0IG5mc2Qz
X2NvbW1pdHJlcyAqcmVzcCA9IHJxc3RwLT5ycV9yZXNwOworCisJZmhfcHV0KCZyZXNwLT5maCk7
CisJaWYgKHJlc3AtPm5mKSB7CisJCWlmIChuZnNkX2lvX2NhY2hlX3dyaXRlID09IE5GU0RfSU9f
RkFEVklTRSkKKwkJCXZmc19mYWR2aXNlKG5mc2RfZmlsZV9maWxlKHJlc3AtPm5mKSwgYXJncC0+
b2Zmc2V0LAorCQkJCSAgICBhcmdwLT5jb3VudCwgUE9TSVhfRkFEVl9ET05UTkVFRCk7CisJCW5m
c2RfZmlsZV9wdXQocmVzcC0+bmYpOworCX0KK30KKwogCiAvKgogICogTkZTdjMgU2VydmVyIHBy
b2NlZHVyZXMuCkBAIC0xMDM5LDcgKzEwNTMsNyBAQCBzdGF0aWMgY29uc3Qgc3RydWN0IHN2Y19w
cm9jZWR1cmUgbmZzZF9wcm9jZWR1cmVzM1syMl0gPSB7CiAJCS5wY19mdW5jID0gbmZzZDNfcHJv
Y19jb21taXQsCiAJCS5wY19kZWNvZGUgPSBuZnMzc3ZjX2RlY29kZV9jb21taXRhcmdzLAogCQku
cGNfZW5jb2RlID0gbmZzM3N2Y19lbmNvZGVfY29tbWl0cmVzLAotCQkucGNfcmVsZWFzZSA9IG5m
czNzdmNfcmVsZWFzZV9maGFuZGxlLAorCQkucGNfcmVsZWFzZSA9IG5mc2QzX3JlbGVhc2VfY29t
bWl0LAogCQkucGNfYXJnc2l6ZSA9IHNpemVvZihzdHJ1Y3QgbmZzZDNfY29tbWl0YXJncyksCiAJ
CS5wY19hcmd6ZXJvID0gc2l6ZW9mKHN0cnVjdCBuZnNkM19jb21taXRhcmdzKSwKIAkJLnBjX3Jl
c3NpemUgPSBzaXplb2Yoc3RydWN0IG5mc2QzX2NvbW1pdHJlcyksCmRpZmYgLS1naXQgYS9mcy9u
ZnNkL25mc2QuaCBiL2ZzL25mc2QvbmZzZC5oCmluZGV4IDFhZTM4YzU1NTdjNC4uYjIxOTAyZTAy
OTgyIDEwMDY0NAotLS0gYS9mcy9uZnNkL25mc2QuaAorKysgYi9mcy9uZnNkL25mc2QuaApAQCAt
MTU2LDcgKzE1Niw4IEBAIGV4dGVybiBib29sIG5mc2RfZGlzYWJsZV9zcGxpY2VfcmVhZCBfX3Jl
YWRfbW9zdGx5OwogZW51bSB7CiAJTkZTRF9JT19CVUZGRVJFRCA9IDAsCiAJTkZTRF9JT19ET05U
Q0FDSEUsCi0JTkZTRF9JT19ESVJFQ1QKKwlORlNEX0lPX0RJUkVDVCwKKwlORlNEX0lPX0ZBRFZJ
U0UKIH07CiAKIGV4dGVybiB1NjQgbmZzZF9pb19jYWNoZV9yZWFkIF9fcmVhZF9tb3N0bHk7CmRp
ZmYgLS1naXQgYS9mcy9uZnNkL3Zmcy5jIGIvZnMvbmZzZC92ZnMuYwppbmRleCAwODM1MDA3MGUw
ODMuLjVkNDU4OGExMDZiMiAxMDA2NDQKLS0tIGEvZnMvbmZzZC92ZnMuYworKysgYi9mcy9uZnNk
L3Zmcy5jCkBAIC0xMjcxLDYgKzEyNzEsMTAgQEAgbmZzZF92ZnNfd3JpdGUoc3RydWN0IHN2Y19y
cXN0ICpycXN0cCwgc3RydWN0IHN2Y19maCAqZmhwLAogCWNhc2UgTkZTRF9JT19ET05UQ0FDSEU6
CiAJCWtpb2NiLmtpX2ZsYWdzID0gSU9DQl9ET05UQ0FDSEU7CiAJCWJyZWFrOworCWNhc2UgTkZT
RF9JT19GQURWSVNFOgorCQlpZiAoc3RhYmxlKQorCQkJa2lvY2Iua2lfZmxhZ3MgPSBJT0NCX0RP
TlRDQUNIRTsKKwkJYnJlYWs7CiAJY2FzZSBORlNEX0lPX0JVRkZFUkVEOgogCQlicmVhazsKIAl9
CmRpZmYgLS1naXQgYS9mcy9uZnNkL3hkcjMuaCBiL2ZzL25mc2QveGRyMy5oCmluZGV4IDUyMjA2
N2I3ZmQ3NS4uZWM5MWEyNGU2NTFhIDEwMDY0NAotLS0gYS9mcy9uZnNkL3hkcjMuaAorKysgYi9m
cy9uZnNkL3hkcjMuaApAQCAtMjE3LDYgKzIxNyw3IEBAIHN0cnVjdCBuZnNkM19jb21taXRyZXMg
ewogCV9fYmUzMgkJCXN0YXR1czsKIAlzdHJ1Y3Qgc3ZjX2ZoCQlmaDsKIAlfX2JlMzIJCQl2ZXJm
WzJdOworCXN0cnVjdCBuZnNkX2ZpbGUJKm5mOwogfTsKIAogc3RydWN0IG5mc2QzX2dldGFjbHJl
cyB7Ci0tIAoyLjUwLjAKCg==


--=-vZv7rRJiZkN9TNqY/qEc--


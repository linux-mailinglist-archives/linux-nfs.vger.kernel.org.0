Return-Path: <linux-nfs+bounces-6763-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C9B9098BC7A
	for <lists+linux-nfs@lfdr.de>; Tue,  1 Oct 2024 14:44:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 62F3D1F230A2
	for <lists+linux-nfs@lfdr.de>; Tue,  1 Oct 2024 12:44:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EE9A1C243F;
	Tue,  1 Oct 2024 12:44:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JWLCGX0d"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7D1C1A00D1;
	Tue,  1 Oct 2024 12:44:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727786686; cv=none; b=P4kQFvfrbyv3cH+15oG1KzILqXjr77qGDALygyau0kGCMETjT3RgOWsw3LWUpI6h0FBS2kTlHclocxgRWbIUk7D1cX35rMs+9uWdmkQf4auCw7BDXWKgdTzr9qXEdZ8cf0mLx/7Gfw2FWR089tggNZfSYQhNaVqLj0MKaZWDJVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727786686; c=relaxed/simple;
	bh=r3HlHQ7n8ImYsTzE4cFA107MpU4F5zeRaCuRYroHzBI=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=R2IpjBooqw6Rw7OcyGaMrhO6zllQOoa1BRZOcOKUXhf5LVKx/ETzNiNM+zZc6ptSQZwXzRkIA9866+mcidni8kytogrgU+YhM5l1XpLhcVP+TxEO0XiqxcdBI8oJjx96JLel/2GEQdHxkZfSUnGa713z718x90p5kOs2AA6I8yw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JWLCGX0d; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2AD2C4CEC6;
	Tue,  1 Oct 2024 12:44:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727786685;
	bh=r3HlHQ7n8ImYsTzE4cFA107MpU4F5zeRaCuRYroHzBI=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=JWLCGX0dkaKDOoY6/5kaicnqwvBRd8cr3PJs96xHK6JxRJ5s/c14As6X2Go7jGRL9
	 LBSh0Ch9LKYCobwG2a40EBtboxjIshPna5U92UjuDQXiKmpCiwDNq+a0k2Ml4TzHdG
	 tqxkOyDJDbdcY9/oZCsYIYfZILyThHkg6bovMo2EDA96BcRwsrcsxI5Lq+CLq6D9KO
	 G/OMRKUPBaaRe9NM1jboodHp+1LphSSLn6alC/OeefZmmZHPHxdvwy/l0rc6f2OVh6
	 cBTTzidNvtrDX5yvayoMN1nVcsQN4gm1M1TelvlyjQ8dKtKNrcqXRLMa9o2Tl+dXgD
	 DjKj2VxTjCcIw==
Message-ID: <70ce1781c9fb39d974d38b7426194ead97926ed3.camel@kernel.org>
Subject: Re: [linux-next:master] [nfsd]  8cb33389f6:  fsmark.app_overhead
 81.6% regression
From: Jeff Layton <jlayton@kernel.org>
To: kernel test robot <oliver.sang@intel.com>
Cc: oe-lkp@lists.linux.dev, lkp@intel.com, Linux Memory Management List
	 <linux-mm@kvack.org>, Chuck Lever <chuck.lever@oracle.com>, 
	linux-nfs@vger.kernel.org, ying.huang@intel.com, feng.tang@intel.com, 
	fengwei.yin@intel.com
Date: Tue, 01 Oct 2024 08:44:43 -0400
In-Reply-To: <202409161645.d44bced5-oliver.sang@intel.com>
References: <202409161645.d44bced5-oliver.sang@intel.com>
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

On Mon, 2024-09-16 at 16:41 +0800, kernel test robot wrote:
>=20
> Hello,
>=20
> kernel test robot noticed a 81.6% regression of fsmark.app_overhead on:
>=20
>=20
> commit: 8cb33389f66441dc4e54b28fe0d9bd4bcd9b796d ("nfsd: implement OPEN_A=
RGS_SHARE_ACCESS_WANT_OPEN_XOR_DELEGATION")
> https://git.kernel.org/cgit/linux/kernel/git/next/linux-next.git master
>=20
> testcase: fsmark
> test machine: 128 threads 2 sockets Intel(R) Xeon(R) Platinum 8358 CPU @ =
2.60GHz (Ice Lake) with 128G memory
> parameters:
>=20
> 	iterations: 1x
> 	nr_threads: 1t
> 	disk: 1HDD
> 	fs: btrfs
> 	fs2: nfsv4
> 	filesize: 4K
> 	test_size: 40M
> 	sync_method: fsyncBeforeClose
> 	nr_files_per_directory: 1fpd
> 	cpufreq_governor: performance
>=20
>=20
>=20
>=20
> If you fix the issue in a separate patch/commit (i.e. not just a new vers=
ion of
> the same patch/commit), kindly add following tags
> > Reported-by: kernel test robot <oliver.sang@intel.com>
> > Closes: https://lore.kernel.org/oe-lkp/202409161645.d44bced5-oliver.san=
g@intel.com
>=20
>=20
> Details are as below:
> -------------------------------------------------------------------------=
------------------------->
>=20
>=20
> The kernel config and materials to reproduce are available at:
> https://download.01.org/0day-ci/archive/20240916/202409161645.d44bced5-ol=
iver.sang@intel.com
>=20
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> compiler/cpufreq_governor/disk/filesize/fs2/fs/iterations/kconfig/nr_file=
s_per_directory/nr_threads/rootfs/sync_method/tbox_group/test_size/testcase=
:
>   gcc-12/performance/1HDD/4K/nfsv4/btrfs/1x/x86_64-rhel-8.3/1fpd/1t/debia=
n-12-x86_64-20240206.cgz/fsyncBeforeClose/lkp-icl-2sp6/40M/fsmark
>=20
> commit:=20
>   e29c78a693 ("nfsd: add support for FATTR4_OPEN_ARGUMENTS")
>   8cb33389f6 ("nfsd: implement OPEN_ARGS_SHARE_ACCESS_WANT_OPEN_XOR_DELEG=
ATION")
>=20
> e29c78a6936e7422 8cb33389f66441dc4e54b28fe0d=20
> ---------------- ---------------------------=20
>          %stddev     %change         %stddev
>              \          |                \ =20
>      24388 =C2=B1 20%     -32.8%      16400 =C2=B1 18%  numa-vmstat.node0=
.nr_slab_reclaimable
>      61.50 =C2=B1  4%     -10.6%      55.00 =C2=B1  6%  perf-c2c.HITM.loc=
al
>       0.20 =C2=B1  3%     +23.0%       0.24 =C2=B1 13%  perf-sched.sch_de=
lay.max.ms.__cond_resched.__wait_for_common.affine_move_task.__set_cpus_all=
owed_ptr.__sched_setaffinity
>       2977            -6.1%       2796        vmstat.system.cs
>    2132466 =C2=B1  2%     +81.6%    3871852        fsmark.app_overhead

I have been unable to reproduce this result with fs_mark. I've run a
number of repeated tests, and I can create files just as fast with or
without this patch (roughly ~46 files/s on my test machine).

I'm particularly suspicious of the fsmark.app_overhead value above. The
fsmark output says:

#       App overhead is time in microseconds spent in the test not doing fi=
le writing related system calls.

That seems outside the purview of anything we're altering here, so I
have to wonder if something else is going on. Oliver, can you rerun
this test and see if this regression is reproducible?

Thanks,

>      53442           -17.3%      44172        fsmark.time.voluntary_conte=
xt_switches
>       2907            -5.7%       2742        perf-stat.i.context-switche=
s
>       2902            -5.7%       2737        perf-stat.ps.context-switch=
es
>    1724787            -1.0%    1706808        proc-vmstat.numa_hit
>    1592345            -1.1%    1574310        proc-vmstat.numa_local
>      24.87 =C2=B1 33%     -38.9%      15.20 =C2=B1 12%  sched_debug.cpu.n=
r_uninterruptible.max
>       4.36 =C2=B1  9%     -17.1%       3.61 =C2=B1 10%  sched_debug.cpu.n=
r_uninterruptible.stddev
>      97541 =C2=B1 20%     -32.7%      65610 =C2=B1 18%  numa-meminfo.node=
0.KReclaimable
>      97541 =C2=B1 20%     -32.7%      65610 =C2=B1 18%  numa-meminfo.node=
0.SReclaimable
>     256796 =C2=B1  9%     -18.7%     208805 =C2=B1 13%  numa-meminfo.node=
0.Slab
>    2307911 =C2=B1 52%     +68.5%    3888971 =C2=B1  5%  numa-meminfo.node=
1.MemUsed
>     193326 =C2=B1 12%     +24.7%     241049 =C2=B1 12%  numa-meminfo.node=
1.Slab
>       0.90 =C2=B1 27%      -0.5        0.36 =C2=B1103%  perf-profile.call=
trace.cycles-pp.evsel__read_counter.read_counters.process_interval.dispatch=
_events.cmd_stat
>       0.36 =C2=B1 70%      +0.2        0.58 =C2=B1  3%  perf-profile.call=
trace.cycles-pp.btrfs_commit_transaction.btrfs_sync_file.btrfs_do_write_ite=
r.do_iter_readv_writev.vfs_iter_write
>       0.52 =C2=B1 47%      +0.3        0.78 =C2=B1  8%  perf-profile.call=
trace.cycles-pp.vfs_write.ksys_write.do_syscall_64.entry_SYSCALL_64_after_h=
wframe.write
>       1.62 =C2=B1 12%      +0.3        1.93 =C2=B1  9%  perf-profile.call=
trace.cycles-pp.__handle_mm_fault.handle_mm_fault.do_user_addr_fault.exc_pa=
ge_fault.asm_exc_page_fault
>       1.22 =C2=B1 21%      -0.3        0.89 =C2=B1 10%  perf-profile.chil=
dren.cycles-pp.readn
>       0.46 =C2=B1 32%      -0.2        0.24 =C2=B1 34%  perf-profile.chil=
dren.cycles-pp.__close
>       0.45 =C2=B1 32%      -0.2        0.22 =C2=B1 15%  perf-profile.chil=
dren.cycles-pp.__x64_sys_close
>       0.40 =C2=B1 29%      -0.2        0.18 =C2=B1 38%  perf-profile.chil=
dren.cycles-pp.__fput
>       0.31 =C2=B1 23%      -0.2        0.16 =C2=B1 33%  perf-profile.chil=
dren.cycles-pp.irq_work_tick
>       0.17 =C2=B1 51%      -0.1        0.03 =C2=B1111%  perf-profile.chil=
dren.cycles-pp.nfs_file_release
>       0.16 =C2=B1 43%      -0.1        0.03 =C2=B1111%  perf-profile.chil=
dren.cycles-pp.__put_nfs_open_context
>       0.26 =C2=B1 18%      -0.1        0.15 =C2=B1 34%  perf-profile.chil=
dren.cycles-pp.perf_event_task_tick
>       0.15 =C2=B1 41%      -0.1        0.03 =C2=B1108%  perf-profile.chil=
dren.cycles-pp.get_free_pages_noprof
>       0.18 =C2=B1 55%      -0.1        0.06 =C2=B1 32%  perf-profile.chil=
dren.cycles-pp.native_apic_mem_eoi
>       0.18 =C2=B1 32%      -0.1        0.07 =C2=B1 81%  perf-profile.chil=
dren.cycles-pp.flush_end_io
>       0.17 =C2=B1 41%      -0.1        0.07 =C2=B1 93%  perf-profile.chil=
dren.cycles-pp.mas_store_gfp
>       0.52 =C2=B1  5%      +0.1        0.58 =C2=B1  3%  perf-profile.chil=
dren.cycles-pp.btrfs_commit_transaction
>       0.02 =C2=B1141%      +0.1        0.08 =C2=B1 42%  perf-profile.chil=
dren.cycles-pp.uptime_proc_show
>       0.02 =C2=B1141%      +0.1        0.08 =C2=B1 44%  perf-profile.chil=
dren.cycles-pp.get_zeroed_page_noprof
>       0.02 =C2=B1141%      +0.1        0.09 =C2=B1 35%  perf-profile.chil=
dren.cycles-pp.__rmqueue_pcplist
>       0.14 =C2=B1 12%      +0.1        0.28 =C2=B1 29%  perf-profile.chil=
dren.cycles-pp.hrtimer_next_event_without
>       0.47 =C2=B1 27%      +0.2        0.67 =C2=B1 19%  perf-profile.chil=
dren.cycles-pp.__mmap
>       0.70 =C2=B1 21%      +0.2        0.91 =C2=B1  7%  perf-profile.chil=
dren.cycles-pp.vfs_write
>       0.74 =C2=B1 20%      +0.2        0.96 =C2=B1  9%  perf-profile.chil=
dren.cycles-pp.ksys_write
>       0.73 =C2=B1 21%      +0.3        1.00 =C2=B1  7%  perf-profile.chil=
dren.cycles-pp.copy_process
>       1.05 =C2=B1 13%      +0.3        1.38 =C2=B1 10%  perf-profile.chil=
dren.cycles-pp.kernel_clone
>       0.28 =C2=B1 22%      -0.1        0.13 =C2=B1 35%  perf-profile.self=
.cycles-pp.irq_work_tick
>       0.18 =C2=B1 55%      -0.1        0.06 =C2=B1 32%  perf-profile.self=
.cycles-pp.native_apic_mem_eoi
>=20
>=20
>=20
>=20
> Disclaimer:
> Results have been estimated based on internal Intel analysis and are prov=
ided
> for informational purposes only. Any difference in system hardware or sof=
tware
> design or configuration may affect actual performance.
>=20
>=20

--=20
Jeff Layton <jlayton@kernel.org>


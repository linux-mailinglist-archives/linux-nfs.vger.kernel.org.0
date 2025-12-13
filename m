Return-Path: <linux-nfs+bounces-17081-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D549CBB426
	for <lists+linux-nfs@lfdr.de>; Sat, 13 Dec 2025 22:38:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 825373008EA7
	for <lists+linux-nfs@lfdr.de>; Sat, 13 Dec 2025 21:38:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE6812E92D2;
	Sat, 13 Dec 2025 21:38:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kkrD6nWi"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9552B246798;
	Sat, 13 Dec 2025 21:38:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765661923; cv=none; b=cbVOXznq1z18BT3evO0WZMog45DKuXIbeq5qgRgFrhWCP5pmaiwkeqYWY6gMw/ff6auUEKZOXuv5f2CRzj7ZS/7WV+3WeDtLhAzgZp8pCI7ZFX5YZoFdE68Ys0sN2AepcfH2wixtEOcbjm0BD1wQeUCZ2OfJsdlGC3HnOyU/1Lk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765661923; c=relaxed/simple;
	bh=gkz9AhvTHlwtv2cVgbcVKM3B/qPO50m6F+I806zQruE=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=LZWffRIJ+ilv7zTL5cJSRW6nxTrB6zJisRM4oDr2F1ZbdUB9rSciQO6XkKc/eL+FtJDlHb4ovoYc+JyZZjMTZWgYezTkUdRcH1LxAyZtT/cqtjFhB1Uyek7PUkkHcjcoffRiV910i+/zWkAd4tsl06Robjk0tEcV/BJS/e3OfZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kkrD6nWi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99033C4CEF7;
	Sat, 13 Dec 2025 21:38:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765661923;
	bh=gkz9AhvTHlwtv2cVgbcVKM3B/qPO50m6F+I806zQruE=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=kkrD6nWiwwAcnyyBvUZh1fEbBsQ5k7xKsXKeOs6HahOGESJ7QyWETS1OxbBCOhRYh
	 QQ+EMUCpdcSrfPtivmRIDh+pj7DM66DEQr7Y5y7q1B4dm5LuIrugb4MtQN/u6m+0Mh
	 FGRx3kFYMCuvsU0zX4kawnBz/ZV1dLlz5EqQGBJky4GmPkcp8hrKsIaqmae9yUaTtI
	 lGZ3mnF3BEhxgiwdTxCV8xubwxWwAoEy//pPZWhFdBlg+bSr/bUxzWnqoVstu3ISH1
	 FGBf7S2wsoEaQDzQz48yt4uBN1rg6ULwEW9TAt1SjJyRfNUPe1ZbLYV1qnWxhuDnPA
	 PRdvKZLQRfm6g==
Message-ID: <92da69632c342cf4ab82a379a51670d676075b53.camel@kernel.org>
Subject: Re: [PATCH RFC 4/6] sunrpc: introduce the concept of a minimum
 number of threads per pool
From: Jeff Layton <jlayton@kernel.org>
To: Chuck Lever <cel@kernel.org>, Chuck Lever <chuck.lever@oracle.com>, 
 NeilBrown <neil@brown.name>, Olga Kornievskaia <okorniev@redhat.com>, Dai
 Ngo <Dai.Ngo@oracle.com>,  Tom Talpey <tom@talpey.com>, Trond Myklebust
 <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>
Cc: linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Sun, 14 Dec 2025 06:38:39 +0900
In-Reply-To: <828c4fe7-930b-41b3-be73-62b2c76f43e4@app.fastmail.com>
References: <20251213-nfsd-dynathread-v1-0-de755e59cbc4@kernel.org>
	 <20251213-nfsd-dynathread-v1-4-de755e59cbc4@kernel.org>
	 <828c4fe7-930b-41b3-be73-62b2c76f43e4@app.fastmail.com>
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
User-Agent: Evolution 3.58.2 (3.58.2-1.fc43) 
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Sat, 2025-12-13 at 15:19 -0500, Chuck Lever wrote:
>=20
> On Fri, Dec 12, 2025, at 5:39 PM, Jeff Layton wrote:
> > Add a new pool->sp_nrthrmin field to track the minimum number of thread=
s
> > in a pool. Add min_threads parameters to both svc_set_num_threads() and
> > svc_set_pool_threads(). If min_threads is non-zero, then have
> > svc_set_num_threads() ensure that the number of running threads is
> > between the min and the max.
> >=20
> > For now, the min_threads is always 0, but a later patch will pass the
> > proper value through from nfsd.
> >=20
> > Signed-off-by: Jeff Layton <jlayton@kernel.org>
> > ---
> >  fs/lockd/svc.c             |  4 ++--
> >  fs/nfs/callback.c          |  8 ++++----
> >  fs/nfsd/nfssvc.c           |  8 ++++----
> >  include/linux/sunrpc/svc.h |  7 ++++---
> >  net/sunrpc/svc.c           | 21 ++++++++++++++++++---
> >  5 files changed, 32 insertions(+), 16 deletions(-)
> >=20
> > diff --git a/fs/lockd/svc.c b/fs/lockd/svc.c
> > index=20
> > fbf132b4e08d11a91784c21ee0209fd7c149fd9d..7899205314391415dfb698ab58fe9=
7efc426d928=20
> > 100644
> > --- a/fs/lockd/svc.c
> > +++ b/fs/lockd/svc.c
> > @@ -340,7 +340,7 @@ static int lockd_get(void)
> >  		return -ENOMEM;
> >  	}
> >=20
> > -	error =3D svc_set_num_threads(serv, 1);
> > +	error =3D svc_set_num_threads(serv, 1, 0);
> >  	if (error < 0) {
> >  		svc_destroy(&serv);
> >  		return error;
> > @@ -368,7 +368,7 @@ static void lockd_put(void)
> >  	unregister_inet6addr_notifier(&lockd_inet6addr_notifier);
> >  #endif
> >=20
> > -	svc_set_num_threads(nlmsvc_serv, 0);
> > +	svc_set_num_threads(nlmsvc_serv, 0, 0);
> >  	timer_delete_sync(&nlmsvc_retry);
> >  	svc_destroy(&nlmsvc_serv);
> >  	dprintk("lockd_down: service destroyed\n");
> > diff --git a/fs/nfs/callback.c b/fs/nfs/callback.c
> > index=20
> > 44b35b7f8dc022f1d8c069eaf2f7d334c93f77fc..32bbc0e688ff3988e4ba50eeb36b4=
808cec07c87=20
> > 100644
> > --- a/fs/nfs/callback.c
> > +++ b/fs/nfs/callback.c
> > @@ -119,9 +119,9 @@ static int nfs_callback_start_svc(int minorversion,=
=20
> > struct rpc_xprt *xprt,
> >  	if (serv->sv_nrthreads =3D=3D nrservs)
> >  		return 0;
> >=20
> > -	ret =3D svc_set_num_threads(serv, nrservs);
> > +	ret =3D svc_set_num_threads(serv, nrservs, 0);
> >  	if (ret) {
> > -		svc_set_num_threads(serv, 0);
> > +		svc_set_num_threads(serv, 0, 0);
> >  		return ret;
> >  	}
> >  	dprintk("nfs_callback_up: service started\n");
> > @@ -242,7 +242,7 @@ int nfs_callback_up(u32 minorversion, struct=20
> > rpc_xprt *xprt)
> >  	cb_info->users++;
> >  err_net:
> >  	if (!cb_info->users) {
> > -		svc_set_num_threads(cb_info->serv, 0);
> > +		svc_set_num_threads(cb_info->serv, 0, 0);
> >  		svc_destroy(&cb_info->serv);
> >  	}
> >  err_create:
> > @@ -268,7 +268,7 @@ void nfs_callback_down(int minorversion, struct net=
=20
> > *net)
> >  	nfs_callback_down_net(minorversion, serv, net);
> >  	cb_info->users--;
> >  	if (cb_info->users =3D=3D 0) {
> > -		svc_set_num_threads(serv, 0);
> > +		svc_set_num_threads(serv, 0, 0);
> >  		dprintk("nfs_callback_down: service destroyed\n");
> >  		svc_destroy(&cb_info->serv);
> >  	}
> > diff --git a/fs/nfsd/nfssvc.c b/fs/nfsd/nfssvc.c
> > index=20
> > aafec8ff588b85b0e26d40b76ef00953dc6472b4..993ed338764b0ccd7bdfb76bd6fbb=
5dc6ab4022d=20
> > 100644
> > --- a/fs/nfsd/nfssvc.c
> > +++ b/fs/nfsd/nfssvc.c
> > @@ -594,7 +594,7 @@ void nfsd_shutdown_threads(struct net *net)
> >  	}
> >=20
> >  	/* Kill outstanding nfsd threads */
> > -	svc_set_num_threads(serv, 0);
> > +	svc_set_num_threads(serv, 0, 0);
> >  	nfsd_destroy_serv(net);
> >  	mutex_unlock(&nfsd_mutex);
> >  }
> > @@ -704,7 +704,7 @@ int nfsd_set_nrthreads(int n, int *nthreads, struct=
=20
> > net *net)
> >=20
> >  	/* Special case: When n =3D=3D 1, distribute threads equally among po=
ols. */
> >  	if (n =3D=3D 1)
> > -		return svc_set_num_threads(nn->nfsd_serv, nthreads[0]);
> > +		return svc_set_num_threads(nn->nfsd_serv, nthreads[0], 0);
> >=20
> >  	if (n > nn->nfsd_serv->sv_nrpools)
> >  		n =3D nn->nfsd_serv->sv_nrpools;
> > @@ -732,7 +732,7 @@ int nfsd_set_nrthreads(int n, int *nthreads, struct=
=20
> > net *net)
> >  	for (i =3D 0; i < n; i++) {
> >  		err =3D svc_set_pool_threads(nn->nfsd_serv,
> >  					   &nn->nfsd_serv->sv_pools[i],
> > -					   nthreads[i]);
> > +					   nthreads[i], 0);
> >  		if (err)
> >  			goto out;
> >  	}
> > @@ -741,7 +741,7 @@ int nfsd_set_nrthreads(int n, int *nthreads, struct=
=20
> > net *net)
> >  	for (i =3D n; i < nn->nfsd_serv->sv_nrpools; ++i) {
> >  		err =3D svc_set_pool_threads(nn->nfsd_serv,
> >  					   &nn->nfsd_serv->sv_pools[i],
> > -					   0);
> > +					   0, 0);
> >  		if (err)
> >  			goto out;
> >  	}
> > diff --git a/include/linux/sunrpc/svc.h b/include/linux/sunrpc/svc.h
> > index=20
> > ee9260ca908c907f4373f4cfa471b272bc7bcc8c..35bd3247764ae8dc5dcdfffeea36f=
7cfefd13372=20
> > 100644
> > --- a/include/linux/sunrpc/svc.h
> > +++ b/include/linux/sunrpc/svc.h
> > @@ -36,6 +36,7 @@
> >  struct svc_pool {
> >  	unsigned int		sp_id;		/* pool id; also node id on NUMA */
> >  	unsigned int		sp_nrthreads;	/* # of threads currently running in pool=
=20
> > */
> > +	unsigned int		sp_nrthrmin;	/* Min number of threads to run per pool *=
/
> >  	unsigned int		sp_nrthrmax;	/* Max requested number of threads in pool=
=20
> > */
> >  	struct lwq		sp_xprts;	/* pending transports */
> >  	struct list_head	sp_all_threads;	/* all server threads */
> > @@ -72,7 +73,7 @@ struct svc_serv {
> >  	struct svc_stat *	sv_stats;	/* RPC statistics */
> >  	spinlock_t		sv_lock;
> >  	unsigned int		sv_nprogs;	/* Number of sv_programs */
> > -	unsigned int		sv_nrthreads;	/* # of server threads */
> > +	unsigned int		sv_nrthreads;	/* # of running server threads */
> >  	unsigned int		sv_max_payload;	/* datagram payload size */
> >  	unsigned int		sv_max_mesg;	/* max_payload + 1 page for overheads */
> >  	unsigned int		sv_xdrsize;	/* XDR buffer size */
> > @@ -447,8 +448,8 @@ struct svc_serv *  svc_create_pooled(struct=20
> > svc_program *prog,
> >  				     struct svc_stat *stats,
> >  				     unsigned int bufsize,
> >  				     int (*threadfn)(void *data));
> > -int		   svc_set_pool_threads(struct svc_serv *, struct svc_pool *,=20
> > int);
> > -int		   svc_set_num_threads(struct svc_serv *, int);
> > +int		   svc_set_pool_threads(struct svc_serv *, struct svc_pool *,=20
> > int, unsigned int);
> > +int		   svc_set_num_threads(struct svc_serv *, int, unsigned int);
> >  int		   svc_pool_stats_open(struct svc_info *si, struct file *file);
> >  void		   svc_process(struct svc_rqst *rqstp);
> >  void		   svc_process_bc(struct rpc_rqst *req, struct svc_rqst *rqstp);
> > diff --git a/net/sunrpc/svc.c b/net/sunrpc/svc.c
> > index=20
> > 8cd45f62ef74af6e0826b8f13cc903b0962af5e0..dc818158f8529b62dcf96c91bd9a9=
d4ab21df91f=20
> > 100644
> > --- a/net/sunrpc/svc.c
> > +++ b/net/sunrpc/svc.c
> > @@ -821,6 +821,7 @@ svc_stop_kthreads(struct svc_serv *serv, struct=20
> > svc_pool *pool, int nrservs)
> >   * @serv: RPC service to adjust
> >   * @pool: Specific pool from which to choose threads
> >   * @nrservs: New number of threads for @serv (0 or less means kill all=
=20
> > threads)
> > + * @min_threads: minimum number of threads per pool (0 means set to=
=20
> > same as nrservs)
> >   *
> >   * Create or destroy threads in @pool to bring it to @nrservs.
> >   *
> > @@ -831,12 +832,22 @@ svc_stop_kthreads(struct svc_serv *serv, struct=
=20
> > svc_pool *pool, int nrservs)
> >   * starting a thread.
> >   */
> >  int
> > -svc_set_pool_threads(struct svc_serv *serv, struct svc_pool *pool, int=
=20
> > nrservs)
> > +svc_set_pool_threads(struct svc_serv *serv, struct svc_pool *pool, int=
=20
> > nrservs,
> > +		     unsigned int min_threads)
> >  {
> >  	if (!pool)
> >  		return -EINVAL;
> >=20
> >  	pool->sp_nrthrmax =3D nrservs;
> > +	if (min_threads) {
> > +		if (pool->sp_nrthreads > nrservs) {
> > +			// fallthrough to update nrservs
> > +		} else if (pool->sp_nrthreads < min_threads) {
> > +			nrservs =3D min_threads;
>=20
> Nit: The mixed sign types here gives me hives. Can you think of
> a reason nrservs is a signed int rather than unsigned?
>=20
>=20
> > +		} else {
> > +			return 0;
> > +		}
> > +	}
> >  	nrservs -=3D pool->sp_nrthreads;
> >=20
> >  	if (nrservs > 0)

Because of this ^^^. We could certainly make the argument unsigned and
use a signed value internally in this function. I'll plan to do that on
the next respin.


> > @@ -851,6 +862,7 @@ EXPORT_SYMBOL_GPL(svc_set_pool_threads);
> >   * svc_set_num_threads - adjust number of threads in serv
> >   * @serv: RPC service to adjust
> >   * @nrservs: New number of threads for @serv (0 or less means kill all=
=20
> > threads)
> > + * @min_threads: minimum number of threads per pool (0 means set to=
=20
> > same as nrservs)
> >   *
> >   * Create or destroy threads in @serv to bring it to @nrservs. If ther=
e
> >   * are multiple pools then the new threads or victims will be=20
> > distributed
> > @@ -863,20 +875,23 @@ EXPORT_SYMBOL_GPL(svc_set_pool_threads);
> >   * starting a thread.
> >   */
> >  int
> > -svc_set_num_threads(struct svc_serv *serv, int nrservs)
> > +svc_set_num_threads(struct svc_serv *serv, int nrservs, unsigned int=
=20
> > min_threads)
> >  {
> >  	int base =3D nrservs / serv->sv_nrpools;
> >  	int remain =3D nrservs % serv->sv_nrpools;
> >  	int i, err;
> >=20
> >  	for (i =3D 0; i < serv->sv_nrpools; ++i) {
> > +		struct svc_pool *pool =3D &serv->sv_pools[i];
> >  		int threads =3D base;
> >=20
> >  		if (remain) {
> >  			++threads;
> >  			--remain;
> >  		}
> > -		err =3D svc_set_pool_threads(serv, &serv->sv_pools[i], threads);
> > +
> > +		pool->sp_nrthrmin =3D min_threads;
> > +		err =3D svc_set_pool_threads(serv, pool, threads, min_threads);
> >  		if (err)
> >  			break;
> >  	}
> >=20
> > --=20
> > 2.52.0

--=20
Jeff Layton <jlayton@kernel.org>


Return-Path: <linux-nfs+bounces-9690-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CA6FA1D9D5
	for <lists+linux-nfs@lfdr.de>; Mon, 27 Jan 2025 16:44:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9CEDB1884EAD
	for <lists+linux-nfs@lfdr.de>; Mon, 27 Jan 2025 15:44:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89EF514A4E9;
	Mon, 27 Jan 2025 15:43:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m55FTrc3"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BF8719BBA;
	Mon, 27 Jan 2025 15:43:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737992620; cv=none; b=eevyO0hkaE9wx7epUsfHWTE4B1tZmxGjEagK5w0jQ5V6q9KjMZupCV22QXpdjI+JgVcbd0SFU9NUOJSuBqOFQy20JUxJZHJGUgI0xn4mBozzQzGzaA8Hea7Qf0N3KdexfY5KOUak+a9gO0wK6q1GNPq7EB3WQDyx5Ur/L0M8DAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737992620; c=relaxed/simple;
	bh=FF4I//QwpAmKu9WdHqN0rUQlglUArDcAj5q6Sbnig7w=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=KTOSe3kPOKy24a4guVubkw8HfchPpLXPAv19wZn2K5dHjQaY1Yd8Hh5L06+wasr0htxRaQW4rRz6dr2KiBmwDVPvfkXjKWS536bAxz/17t4dzhulgoOWAVvA/w9eP917bvQOVB5p3YxcDlfiDYfhCHl+IO9hutXuXtG1MxF+v1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m55FTrc3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3A1FC4CED2;
	Mon, 27 Jan 2025 15:43:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737992620;
	bh=FF4I//QwpAmKu9WdHqN0rUQlglUArDcAj5q6Sbnig7w=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=m55FTrc3g3e/jyNJ5392HSIT7P3eg2/OMo6CkxNs3Sc2vqUCpwR+bVVzqMNGtmbxf
	 BuP5hB7SM2ZVHK2pCX/Cp2fOdknvG2+key7S8tqpLgXyLcdHTmlKhV4zLbZUr7kaY5
	 vFeDSMy3Mu5LqxEhAdMjPsOTLwxuVUElA7o3p3NJ8Mql2okkz8pvhMn/JWKV31Dy+r
	 2kz0FZE+U0hCENBJOxqrQD/yIS6oOVlpoM57ry4nK6RYbd9U6ii23u9GMi7UB8Zwaa
	 +AnUHl/oSNUpBlgjONr4VYO/asWMg+I9tUh9V0GtpTFt0bqKFFV9ImPIHM96DfeFe7
	 ldCxfgoFpChXA==
Message-ID: <7bf69557c04b6c9084cdc153f30bd3ac7cb48065.camel@kernel.org>
Subject: Re: [PATCH 1/8] nfsd: don't restart v4.1+ callback when
 RPC_SIGNALLED is set
From: Jeff Layton <jlayton@kernel.org>
To: Chuck Lever <chuck.lever@oracle.com>, NeilBrown <neilb@suse.de>
Cc: Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, 
 Tom Talpey <tom@talpey.com>, "J. Bruce Fields" <bfields@fieldses.org>,
 Kinglong Mee	 <kinglongmee@gmail.com>, Trond Myklebust
 <trondmy@kernel.org>, Anna Schumaker	 <anna@kernel.org>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet	 <edumazet@google.com>, Jakub Kicinski
 <kuba@kernel.org>, Paolo Abeni	 <pabeni@redhat.com>, Simon Horman
 <horms@kernel.org>, linux-nfs@vger.kernel.org, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Date: Mon, 27 Jan 2025 10:43:37 -0500
In-Reply-To: <ac5834d4-1465-4dde-a451-b0804c537f04@oracle.com>
References: <20250123-nfsd-6-14-v1-0-c1137a4fa2ae@kernel.org>
	 <20250123-nfsd-6-14-v1-1-c1137a4fa2ae@kernel.org>
	 <173784610046.22054.813567864998956753@noble.neil.brown.name>
	 <d52cf9b9b83753434c1b0098afe1b77bf65590d4.camel@kernel.org>
	 <ac5834d4-1465-4dde-a451-b0804c537f04@oracle.com>
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

On Sun, 2025-01-26 at 11:41 -0500, Chuck Lever wrote:
> On 1/26/25 6:18 AM, Jeff Layton wrote:
> > On Sun, 2025-01-26 at 10:01 +1100, NeilBrown wrote:
> > > On Fri, 24 Jan 2025, Jeff Layton wrote:
> > > > This is problematic, since the RPC might have been entirely success=
ful.
> > > > There is no point in restarting a v4.1+ callback just because
> > > > RPC_SIGNALLED is true. The v4.1+ error handling has other mechanism=
s for
> > > > detecting when it should retransmit the RPC.
> > >=20
> > > But why might RPC_SIGNALLED() ever be true?
> > > The flag RPC_TASK_SIGNALLED is only ever set by rpc_signal_task() whi=
ch
> > > is only called from rpc_killall_tasks() and __rpc_execute() for
> > > non-async tasks which doesn't apply to nfsd callbacks as they are
> > > started with rpc_call_async().
> > >=20
> > > rpc_killall_tasks() is called by fs/nfs/ which isn't relevant for us,
> > > and from rpc_shutdown_client().  In those cases we certainly don't wa=
nt
> > > the request to be retried, though the nfsd4_process_cb_update() case =
is
> > > a little interesting as we do want it to be retried, but in a differe=
nt
> > > client.
> > >=20
> > > So the code you are removing is either dead code because something el=
se
> > > will prevent the restart when a client is being shut down, or it is b=
ad
> > > code because it would delay rpc_shutdown_client() while the request i=
s
> > > retried.
> > >=20
> > > I haven't dug the extra step to figure out which, but either way I th=
ink
> > > the code should go.
> >=20
> > Thanks. That was my analysis too.
>=20
> Agreed, this code is problematic, but it appears to me that some of
> these problems are not resolved by simply removing the signal check.
>=20
>=20
> > rpc_shutdown_client() is called when we tear down and rebuild the
> > rpc_client. nfsd does this in setup_callback_client(), which gets
> > called from nfsd4_process_cb_update() (basically when we detect that
> > the backchannel is having problems).
> >=20
> > There are really only two states: We either got a reply from the server
> > before the client went down, or we didn't. In the case where we got a
> > reply, there is no need to retry anything. In the case where we didn't,
> > the tk_status will be '1', so there is no need to check RPC_SIGNALLED()
> > at all here.
>=20
> Fwiw, the "cb_seq_status =3D=3D 1" arm skips the signal check in the curr=
ent
> code.
>=20
>=20
> > The existing code could lead to the call being retried when we had
> > already gotten a perfectly valid reply.
>=20
> Here's a case-by-case audit:
>=20
>   - NFS_OK: SEQUENCE was decoded and passed sanity checks. So this should
>     not ever requeue in here. It might be requeued during subsequent
>     processing.
>=20
>   - ESERVERFAULT: SEQUENCE was decoded but failed sanity checking. The
>     reply should be dropped now, and the session marked FAULT. No requeue
>     is ever needed here.
>=20
>     [ I question whether the sequence number should be bumped in this
>       case -- the client's callback server replied with the identity of
>       some other slot. And anyway, this session is about to become
>       toast. ]
>=20

It didn't necessarily reply with the ID of a different slot. It's just
that the decoding failed in some way. It could have been any of the
cases in decode_cb_sequence4resok(). Maybe that function needs to
return more distinct error codes so we know what was mangled.

>   - 1: The timeout case. We want a fresh session here, so it falls
>     through to BADSESSION.
>=20

Ok.

>   - NFS4ERR_BADSESSION: This needs a requeue so that the operation can
>     be retried with a fresh session. But it should always check if the
>     rpc_clnt is shutting down before doing so. This is a problem in the
>     current code.
>=20

I'm not sure I understand the problem you see with that in the existing
code. There's a rather complicated dance in nfsd4_process_cb_update(),
but if the nfs4_client is shutting down, then clp->cl_cb_client will be
NULL after it, and the callback will end.

You said "rpc_clnt" though, so I'm not sure I understand the scenario
you mean.

>   - NFS4ERR_DELAY: Skips the signal check, but shouldn't. If the rpc_clnt
>     is shutting down, this RPC should not be requeued.
>=20

Good point -- ot sure how we deal with that in a non-racy way. I'll
think about it.

>   - NFS4ERR_BAD_SLOT: Skips the signal check, but shouldn't. I need to
>     think more about BAD_SLOT recovery best practice.
>=20

RPC_SIGNALLED() is irrelevant here. I think what we want to do is mark
the backchannel as faulty, _leak_ the slot and retry via the workqueue
(not just requeue the rpc_task). That should just cause the callback to
exit once it runs again.

We should also mark the backchannel as faulty, since the client and
server no longer agree on the size of the slot table.

>   - NFS4ERR_SEQ_MISORDERED: Does one retry with a seq_nr of 1. It
>     probably should terminate if that fails. IMO this should check for
>     rpc_clnt shutdown before requeuing the retry.
>=20

Fair enough. There is a frustrating lack of guidance in the spec about
SEQ_MISORDERED. We should probably mark the BC as having a FAULT too if
the retry fails.

>   - default: I don't think this case should ever be requeued, but it
>     appears that it could be if the rpc_clnt is shutting down.
>=20

Yeah. Might not hurt to throw a pr_warn() here too. I think we never
want to fall into this case.

In any case, my intention is to fix up the cb_session lifetime problem
first, and then we can rework the error handling from the callbacks on
top of that.
--=20
Jeff Layton <jlayton@kernel.org>


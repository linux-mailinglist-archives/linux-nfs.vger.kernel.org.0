Return-Path: <linux-nfs+bounces-9988-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F3108A2DF49
	for <lists+linux-nfs@lfdr.de>; Sun,  9 Feb 2025 18:05:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B50973A4F0E
	for <lists+linux-nfs@lfdr.de>; Sun,  9 Feb 2025 17:05:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E37E1DF24F;
	Sun,  9 Feb 2025 17:05:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F8XwX3eY"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3CA1EAC6;
	Sun,  9 Feb 2025 17:05:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739120724; cv=none; b=upMWbHGUPfR+nktN6lHwfede0QKHUorJ185CI4YSDzntc72NhemQ4HP7tx1mxsqriwXksQoB6U0KhLgLvZsKNHJwzKqF585GChUcZ5FKZ/UWs0KBcfzlFqxpGRNt6Rmqr2p7fRyn+MjEKxGYe+pg8OqCC7JKYpD7h8S3pLqGB6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739120724; c=relaxed/simple;
	bh=2qdYcrcx4kG+29As4PpoSVVefggjkuBEXHtbUQZjYws=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=XQpzXiGbTnZ3SNqwtzF6R6kRSTSIppatUsMzd1HTL2ArPJGDQ4FOlDFRj2ml+Fu434Z5wkNxmD3cHAqYskYSl5Fshyf8Fbi+MHchfYlTa2Z73Cd6+rDDe3XkRlSKVlKJlj0JRquRBc/yrtbrCjQ0bSZ0u/LHAbOpWDitMoiQ5/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F8XwX3eY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A37B6C4CEDD;
	Sun,  9 Feb 2025 17:05:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739120723;
	bh=2qdYcrcx4kG+29As4PpoSVVefggjkuBEXHtbUQZjYws=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=F8XwX3eYixTbH/WOwC2Ws8c5DOCFGSSlqKW5iVrYaNcHSVYk/a5rrqekzTadfXlaW
	 H0XTG38EqRzKCP6RtYfHmjlK3hxofi7qItaegAbDYS4+2tEksFABz3rqUJcYQn6J7T
	 gFtMJXlYpQ4mpQQ3vf8JswFIBGt9hkrzONCp3pcS4tVUz2f/o4kuvw3CG6luj4cfWj
	 cm4reBAVqIzz3AJGHBlPBbTW5+LhQagOwgEZXiMMWW/A2VL0x0gZ96vRFbK2EN4/5w
	 HsFTdyuhirzkShiDWeqJr6fhvYzl2XwPz64MrZT1DhVz5XTKtYsfo7cxmL6aX4sOwJ
	 hCUWwyRBIrN2A==
Message-ID: <76d23f2ad2d45f04cc60711cdf60dc59e7d0ae77.camel@kernel.org>
Subject: Re: [PATCH v5 6/7] nfsd: handle CB_SEQUENCE NFS4ERR_SEQ_MISORDERED
 error better
From: Jeff Layton <jlayton@kernel.org>
To: Tom Talpey <tom@talpey.com>, Chuck Lever <chuck.lever@oracle.com>, Neil
 Brown <neilb@suse.de>, Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo
 <Dai.Ngo@oracle.com>,  "J. Bruce Fields" <bfields@fieldses.org>
Cc: linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Sun, 09 Feb 2025 12:05:21 -0500
In-Reply-To: <bef3a870-32b6-48be-8698-e56e1512dd40@talpey.com>
References: <20250207-nfsd-6-14-v5-0-f3b54fb60dc0@kernel.org>
	 <20250207-nfsd-6-14-v5-6-f3b54fb60dc0@kernel.org>
	 <28174296-129d-4459-aa23-a94bbf00d257@oracle.com>
	 <3e4d14075482489cd010e4ea621c0bd368700e27.camel@kernel.org>
	 <40970e33-4689-4623-a423-b346e739ba80@talpey.com>
	 <66532654ca25280ffa30168a977601ba4a37aaab.camel@kernel.org>
	 <29e739f1-2d85-40c2-a549-5ab9d71686b0@talpey.com>
	 <35cae0eb73781bb36c49aed2c2bc49a808698635.camel@kernel.org>
	 <2f9fe86f-b49c-460c-bf2e-fed97970952d@oracle.com>
	 <ad26cab0-8f63-4ff7-a786-1d0ec51da490@talpey.com>
	 <d6fdb3ba346ef606f630441de1a34cb00030cb4d.camel@kernel.org>
	 <7da740d0-1e4f-4e1b-986f-9516c8286d19@talpey.com>
	 <6606c3bb229513af8a8e1b4cc398aa6e72257666.camel@kernel.org>
	 <bef3a870-32b6-48be-8698-e56e1512dd40@talpey.com>
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

On Sun, 2025-02-09 at 11:58 -0500, Tom Talpey wrote:
> On 2/9/2025 11:51 AM, Jeff Layton wrote:
> > On Sun, 2025-02-09 at 11:26 -0500, Tom Talpey wrote:
> > > On 2/8/2025 9:14 PM, Jeff Layton wrote:
> > > > On Sat, 2025-02-08 at 20:24 -0500, Tom Talpey wrote:
> > > > > On 2/8/2025 4:07 PM, Chuck Lever wrote:
> > > > > > On 2/8/25 3:45 PM, Jeff Layton wrote:
> > > > > > > On Sat, 2025-02-08 at 14:18 -0500, Tom Talpey wrote:
> > > > > > > > On 2/8/2025 11:08 AM, Jeff Layton wrote:
> > > > > > > > > On Sat, 2025-02-08 at 13:40 -0500, Tom Talpey wrote:
> > > > > > > > > > On 2/8/2025 10:02 AM, Jeff Layton wrote:
> > > > > > > > > > > On Sat, 2025-02-08 at 12:01 -0500, Chuck Lever wrote:
> > > > > > > > > > > > On 2/7/25 4:53 PM, Jeff Layton wrote:
> > > > > > > > > > > > > For NFS4ERR_SEQ_MISORDERED, do one attempt with a=
 seqid of 1, and then
> > > > > > > > > > > > > fall back to treating it like a BADSLOT if that f=
ails.
> > > > > > > > > > > > >=20
> > > > > > > > > > > > > Signed-off-by: Jeff Layton <jlayton@kernel.org>
> > > > > > > > > > > > > ---
> > > > > > > > > > > > >       fs/nfsd/nfs4callback.c | 16 ++++++++++-----=
-
> > > > > > > > > > > > >       1 file changed, 10 insertions(+), 6 deletio=
ns(-)
> > > > > > > > > > > > >=20
> > > > > > > > > > > > > diff --git a/fs/nfsd/nfs4callback.c b/fs/nfsd/nfs=
4callback.c
> > > > > > > > > > > > > index 10067a34db3afff8d4e4383854ab9abd9767c2d6..d=
6e3e8bb2efabadda9f922318880e12e1cb2c23f 100644
> > > > > > > > > > > > > --- a/fs/nfsd/nfs4callback.c
> > > > > > > > > > > > > +++ b/fs/nfsd/nfs4callback.c
> > > > > > > > > > > > > @@ -1393,6 +1393,16 @@ static bool nfsd4_cb_seque=
nce_done(struct rpc_task *task, struct nfsd4_callback
> > > > > > > > > > > > >       			goto requeue;
> > > > > > > > > > > > >       		rpc_delay(task, 2 * HZ);
> > > > > > > > > > > > >       		return false;
> > > > > > > > > > > > > +	case -NFS4ERR_SEQ_MISORDERED:
> > > > > > > > > > > > > +		/*
> > > > > > > > > > > > > +		 * Reattempt once with seq_nr 1. If that fails=
, treat this
> > > > > > > > > > > > > +		 * like BADSLOT.
> > > > > > > > > > > > > +		 */
> > > > > > > > > > > >=20
> > > > > > > > > > > > Nit: this comment says exactly what the code says. =
If it were me, I'd
> > > > > > > > > > > > remove it. Is there a "why" statement that could be=
 made here? Like,
> > > > > > > > > > > > why retry with a seq_nr of 1 instead of just failin=
g immediately?
> > > > > > > > > > > >=20
> > > > > > > > > > >=20
> > > > > > > > > > > There isn't one that I know of. It looks like Kinglon=
g Mee added it in
> > > > > > > > > > > 7ba6cad6c88f, but there is no real mention of that in=
 the changelog.
> > > > > > > > > > >=20
> > > > > > > > > > > TBH, I'm not enamored with this remedy either. What i=
f the seq_nr was 2
> > > > > > > > > > > when we got this error, and we then retry with a seq_=
nr of 1? Does the
> > > > > > > > > > > server then treat that as a retransmission?
> > > > > > > > > >=20
> > > > > > > > > > So I assume you mean the requester sent seq_nr 1, saw a=
 reply and sent a
> > > > > > > > > > subsequent seq_nr 2, to which it gets SEQ_MISORDERED.
> > > > > > > > > >=20
> > > > > > > > > > If so, yes definitely backing up the seq_nr to 1 will r=
esult in the
> > > > > > > > > > peer considering it to be a retransmission, which will =
be bad.
> > > > > > > > > >=20
> > > > > > > > >=20
> > > > > > > > > Yes, that's what I meant.
> > > > > > > > >=20
> > > > > > > > > > > We might be best off
> > > > > > > > > > > dropping this and just always treating it like BADSLO=
T.
> > > > > > > > > >=20
> > > > > > > > > > But, why would this happen? Usually I'd think the peer =
sent seq_nr X
> > > > > > > > > > before it received a reply to seq_nr X-1, which would b=
e a peer bug.
> > > > > > > > > >=20
> > > > > > > > > > OTOH, SEQ_MISORDERED is a valid response to an in-progr=
ess retry. So,
> > > > > > > > > > how does the requester know the difference?
> > > > > > > > > >=20
> > > > > > > > > > If treating it as BADSLOT completely resets the sequenc=
e, then sure,
> > > > > > > > > > but either a) the request is still in-progress, or b) i=
f a bug is
> > > > > > > > > > causing the situation, well it's not going to converge =
on a functional
> > > > > > > > > > session.
> > > > > > > > > >=20
> > > > > > > > >=20
> > > > > > > > > With this patchset, on BADSLOT, we'll set SEQ4_STATUS_BAC=
KCHANNEL_FAULT
> > > > > > > > > in the next forechannel SEQUENCE on the session. That sho=
uld cause the
> > > > > > > > > client to (eventually) send a DESTROY_SESSION and create =
a new one.
> > > > > > > > >=20
> > > > > > > > > Unfortunately, in the meantime, because of the way the ca=
llback channel
> > > > > > > > > update works, the server can end up trying to send the ca=
llback again
> > > > > > > > > on the same session (and maybe more than once). I'm not s=
ure that
> > > > > > > > > that's a real problem per-se, but it's less than ideal.
> > > > > > > > >=20
> > > > > > > > > > Not sure I have a solid suggestion right now. Whatever =
the fix, it
> > > > > > > > > > should capture any subtlety in a comment.
> > > > > > > > > >=20
> > > > > > > > >=20
> > > > > > > > > At this point, I'm leaning toward just treating it like B=
ADSLOT.
> > > > > > > > > Basically, mark the backchannel faulty, and leak the slot=
 so that
> > > > > > > > > nothing else uses it. That allows us to send backchannel =
requests on
> > > > > > > > > the other slots until the session gets recreated.
> > > > > > > >=20
> > > > > > > > Hmm, leaking the slot is a workable approach, as long as it=
 doesn't
> > > > > > > > cascade more than a time or two. Some sort of trigger shoul=
d be armed
> > > > > > > > to prevent runaway retries.
> > > > > > > >=20
> > > > > > > > It's maybe worth considering what state the peer might be i=
n when this
> > > > > > > > happens. It too may effectively leak a slot, and if is reta=
ining some
> > > > > > > > bogus state either as a result of or because of the previou=
s exchange(s)
> > > > > > > > then this may lead to future hangs/failures. Not pretty, an=
d maybe not
> > > > > > > > worth trying to guess.
> > > > > > > >=20
> > > > > > > > Tom.
> > > > > > > >=20
> > > > > > >=20
> > > > > > >=20
> > > > > > > The idea here is that eventually the client should figure out=
 that
> > > > > > > something is wrong and reestablish the session. Currently we =
don't
> > > > > > > limit the number of retries on a callback.
> > > > > > >=20
> > > > > > > Maybe they should time out after a while? If we've retried a =
callback
> > > > > > > for more than two lease periods, give up and log something?
> > > > > > >=20
> > > > > > > Either way, I'd consider that to be follow-on work to this se=
t.
> > > > > >=20
> > > > > > As a general comment, I think making a heroic effort to recover=
 in any
> > > > > > of these cases is probably not worth the additional complexity.=
 Where it
> > > > > > is required or where we believe it is worth the trouble, that's=
 where we
> > > > > > want a detailed comment.
> > > > > >=20
> > > > > > What we want to do is ensure forward progress. I'm guessing tha=
t error
> > > > > > conditions are going to be rare, so leaking the slot until a ce=
rtain
> > > > > > portion of them are gone, and then indicating a session fault t=
o force
> > > > > > the client to start over from scratch, is probably the most
> > > > > > straightforward approach.
> > > > > >=20
> > > > > > So, is there a good reason to retry? There doesn't appear to be=
 any
> > > > > > reasoning mentioned in the commit log or in nearby comments.
> > > > >=20
> > > > > Agreed on the general comment.
> > > > >=20
> > > > > As for the "any reason to retry" - maybe. If it's a transient err=
or we
> > > > > don't want to give up early. Unfortunately that appears to be an
> > > > > ambiguous situation, because SEQ_MISORDERED is allowed in place o=
f
> > > > > ERR_DELAY. I don't have any great suggestion however.
> > > > >=20
> > > >=20
> > > > IMO, we should retry callbacks (basically) indefinitely, unless the
> > > > NFSv4 client is being torn down (i.e. lease expires or an unmount
> > > > happened, etc).
> > > >=20
> > > > > Jeff, to your point that the "client should figure out something =
is
> > > > > wrong", I'm not sure how you think that will happen. If the serve=
r is
> > > > > making a delegation recall and the client receive code chooses to=
 reject
> > > > > it at the sequence check, how would that eventually cause the cli=
ent to
> > > > > reestablish the session (on the forechannel)?
> > > > >=20
> > > > >=20
> > > >=20
> > > > In the BADSLOT case, it calls nfsd4_mark_cb_fault(cb->cb_clp), whic=
h
> > > > sets a flag in the client that makes it set
> > > > SEQ4_STATUS_BACKCHANNEL_FAULT in the next SEQUENCE call.
> > >=20
> > > Aha, that's good. RFC8881 only mentions it twice, but it's normative:
> > >=20
> > > SEQ4_STATUS_BACKCHANNEL_FAULT
> > >       The server has encountered an unrecoverable fault with the
> > >       backchannel (e.g., it has lost track of the sequence ID for a s=
lot
> > >       in the backchannel). The client MUST stop sending more requests=
 on
> > >       the session's fore channel, wait for all outstanding requests t=
o
> > >       complete on the fore and back channel, and then destroy the ses=
sion.
> > >=20
> > > I guess my question is, what if the client ignores it anyway? What
> > > server code actually forces the recovery?
> > >=20
> > > Tom.
> > >=20
> >=20
> > I don't think there is anything that does this right now. Does the RFC
> > mention what the server should do if that happens? I suppose the server
> > could just unilaterally destroy the session at some point, and force
> > the client to reestablish it.
>=20
> Nope. :( Like many other requirements, it's unenforced normatively.
>=20
> Perhaps we could consider this as an erratum, but it's more of an
> omission. Because of that, it may need IETF discussion ("at some point"
> needs a MUST). I'll volunteer to open an issue, if you agree to discuss!

Sure. I don't have a whole lot to add, but my proposal would be:

If the server sends a SEQUENCE reply with SEQ4_STATUS_BACKCHANNEL_FAULT
set, then the client has another lease period in which to reestablish
the session. After that, the server may unilaterally drop the session
and start returning NFS4ERR_BADSESSION to attempts to use it.

--=20
Jeff Layton <jlayton@kernel.org>


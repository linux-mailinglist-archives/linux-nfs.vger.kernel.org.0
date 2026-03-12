Return-Path: <linux-nfs+bounces-20057-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6A2MGUStsmkjOwAAu9opvQ
	(envelope-from <linux-nfs+bounces-20057-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Thu, 12 Mar 2026 13:10:44 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C3B09271756
	for <lists+linux-nfs@lfdr.de>; Thu, 12 Mar 2026 13:10:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D6B4C302A067
	for <lists+linux-nfs@lfdr.de>; Thu, 12 Mar 2026 12:10:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7EDB3B7B87;
	Thu, 12 Mar 2026 12:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GwsE8gQp"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B6D136DA09;
	Thu, 12 Mar 2026 12:10:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773317429; cv=none; b=ux9kK3QA62TL+qaxiJR9catFvfJWtH6Psf6SlmOTrIyURaPty1RGuGV6ys7zXgFWFtI8RezWYoJ0SeCmASX1rymYUi6qUV/K8fT6aJXUj4E5jvnhCnJ9wZCS/0itzIB03JdCSxBnEEHYhLzrSShCx45pXvqsl4NUbFX/CjhLB3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773317429; c=relaxed/simple;
	bh=HltwtVdjzVMHydU/ixyI56sfvFOm/UycX9ON36RAijA=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=JGnq+gL4Jb99v0NZFk2fVeYLDYndPmTcMg35AlKQhcEdwJr2pJfieyI/uPQqG90i9Arj+q+nO8NSaKIsXBNsv9fCHMMgzLAEG8o+/4+6d8qAHPyXSGdXATImjU49UVeUooHlwFTT4Q57FRs6kDGBhZQaaNPb5KH6SDHPhdKGT+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GwsE8gQp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ECA72C4CEF7;
	Thu, 12 Mar 2026 12:10:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773317428;
	bh=HltwtVdjzVMHydU/ixyI56sfvFOm/UycX9ON36RAijA=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=GwsE8gQp0p94VRRrY/tI3piy2wAQpZ523wNvmQfPnzbw6g/H1bUbq8rvWKQyzwN5r
	 VCZbXKxAIl6x4zqFRCfKJS9cpD3AFhskIyQmz7Os+u+L7isxclvN57gC0OC6VnatAe
	 hhpebG17crgt6Fd5wch6Dz5viG5mHIljR5SGK1x2PoXGPlpp6DiVXW7DavqJnrOtLr
	 usJMcMyvgf7Dgjh+Hpm9tU6AlvztH2XQR2jkYWCWFgOKdHYvL+3cMrHv8PeYvNnRgm
	 QjqGS3YECyFfDxPryxAhUXnfXDGYfWl8PV1fw3llcExkNA1wKXPuk5j6FuPP7XJIE6
	 6ibtFHXgwlZGA==
Message-ID: <cf78feb7ffaee6ed478afb734d2ede149597de86.camel@kernel.org>
Subject: Re: Regression: Missing check in nfsd_permission() causes -ENOLCK
 No locks available
From: Jeff Layton <jlayton@kernel.org>
To: Thorsten Leemhuis <regressions@leemhuis.info>, NeilBrown
 <neil@brown.name>
Cc: 1128861@bugs.debian.org, Tj <tj.iam.tj@proton.me>, 
	linux-nfs@vger.kernel.org, Olga Kornievskaia <okorniev@redhat.com>, 
	stable@vger.kernel.org
Date: Thu, 12 Mar 2026 08:10:24 -0400
In-Reply-To: <6ba41798-9c69-44f5-9a4e-09336c75a4b9@leemhuis.info>
References: <c0f15088-3fc0-487a-9f24-cf89c158420d@proton.me>
	 <177266540127.7472.3460090956713656639@noble.neil.brown.name>
	 <6ba41798-9c69-44f5-9a4e-09336c75a4b9@leemhuis.info>
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
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43) 
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-20057-lists,linux-nfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jlayton@kernel.org,linux-nfs@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: C3B09271756
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, 2026-03-12 at 09:55 +0100, Thorsten Leemhuis wrote:
> On 3/5/26 00:03, NeilBrown wrote:
> > On Tue, 24 Feb 2026, Tj wrote:
> > > Upstream commit 4cc9b9f2bf4dfe13fe573 "nfsd: refine and rename=20
> > > NFSD_MAY_LOCK" and
> > >  =C2=A0stable v6.12.54 commit 18744bc56b0ec=C2=A0 (re)moves checks fr=
om=20
> > > fs/nfsd/vfs.c::nfsd_permission().
> > >=20
> > >  =C2=A0This causes NFS clients to see
> > >=20
> > > $ flock -e -w 4 /srv/NAS/test/debian-13.3.0-amd64-netinst.iso sleep 1
> > > flock: /srv/NAS/test/debian-13.3.0-amd64-netinst.iso: No locks availa=
ble
> > >=20
> > > Keeping the check in nfsd_permission() whilst also copying it to=20
> > > fs/nfsd/nfsfh.c::__fh_verify() resolves the issue.
> > >=20
> > > This was discovered on the Debian openQA infrastructure server when=
=20
> > > upgrading kernel from v6.12.48 to later v6.12.y where worker hosts (w=
ith=20
> > > any earlier or later kernel version) pass NFSv3 mounted ISO images to=
=20
> > > qemu-system-x86_64 and it reports:
>=20
> Neil, thx for the explanation.
>=20
> Jeff, do you have any opinion on what Neil suggested (see quote below).
>=20
> But as Neil mentioned, it's a regression, so it must be handled some
> way. And it looks like this stalled. Given that the commit in that
> caused this is somewhat old, I wonder:
>=20
> Is that something we expect other people to run into?
>=20
> If yes, I'd say Linus expects us to fix this.
>=20
> And if not: is there something the Debian openQA infra (a) can and (b)
> is willing to do to work around this regression cleanly (by upgrading
> Qemu or something like that maybe)? Then we maybe can leave things as
> they are[1].
>=20
> Ciao, Thorsten
>=20
> [1] see the hand-holding aspect mention in
> https://www.kernel.org/doc/html/next/process/handling-regressions.html#on=
-exceptions-to-the-no-regressions-rule
>=20


Yes. NAK on the patch below. It would break legitimate cases where the
lock should be denied. Neil is right not to encourage its use.

As Neil points out, exclusive locks on NLM require write access. We're
constrained by a protocol that doesn't have a provision for flock()
style locks. It may technically be a regression since it worked before,
but I'm wondering whether it ever should have.

Has anyone experiencing this tried using the no_auth_nlm export option
on the server? ISTM that that should work around the problem for these
folks, even if it's not ideal.
=20
> > > !!! : qemu-system-x86_64: -device=20
> > > scsi-cd,id=3Dcd0-device,drive=3Dcd0-overlay0,serial=3Dcd0: Failed to =
get=20
> > > "consistent read" lock: No locks available
> > > QEMU: Is another process using the image=20
> > > [/var/lib/openqa/pool/2/20260223-1-debian-testing-amd64-netinst.iso]?
> > >=20
> > > A simple reproducer with the server using:
> > >=20
> > > # cat /etc/exports.d/test.exports
> > > /srv/NAS/test=20
> > > fdff::/64(fsid=3D0,rw,no_root_squash,sync,no_subtree_check,auth_nlm)
> > >=20
> > > and clients using:
> > >=20
> > > # mount -t nfs [fdff::2]:/srv/NAS/test /srv/NAS/test -o=20
> > > proto=3Dtcp6,ro,fsc,soft
> >=20
> > Linux has two quite different sorts of locks - flock and fcntl.
> > flocks lock the whole file, shared or exclusive.
> > fcntl can lock any byte-range (including the whole file), shared or
> > exclusive.  flock and fcntl locks don't conflict.
> >=20
> > exclusive flock locks only require read access to the file
> > exclusive fcntl locks require write access to the file.
> >=20
> > The NLM protocol only supports one type of byte-range lock.  It is
> > natural to map fcntl locks onto NLM locks.  The early Linux NFS
> > implementation handled flock locks entirely locally so different client=
s
> > didn't conflict.  This could be confusing but was widely documented and
> > understood.
> > Some years ago Linux NFS was enhanced to handle flock locks like
> > whole-file fcntl locks.  This means that clients with flock locks would
> > conflict (maybe good) but that flock locks and fcntl locks would now
> > conflict (maybe bad).
> > You can still get the old behaviour with "-o local_lock=3Dflock".
> >=20
> > So if you open a file on NFS read-only and attempt an exclusive flock,
> > that will be sent to the server as a full-range fcntl lock which should
> > require write access.  If the server finds you don't have write access =
-
> > you lose.
> >=20
> > It would seems to make sense to tell qemu that the device is read-only.=
=20
> > Then it will hopefully only request a shared lock.  Can you try that?
> >=20
> > Note that even before my patch, if the filesystem was exported read-onl=
y
> > or mounted read-only on the server, then exclusive flock locks would
> > fail.
> >=20
> > I think that the current behaviour is correct, however I do understand
> > that it is a regression and maybe that justifies incorrect behaviour.
> > Maybe Jeff, as locking maintainer, would be willing to do something lik=
e
> >=20
> > diff --git a/fs/lockd/svcsubs.c b/fs/lockd/svcsubs.c
> > index dd0214dcb695..6c674fc51bab 100644
> > --- a/fs/lockd/svcsubs.c
> > +++ b/fs/lockd/svcsubs.c
> > @@ -73,6 +73,14 @@ static inline unsigned int file_hash(struct nfs_fh *=
f)
> > =20
> >  int lock_to_openmode(struct file_lock *lock)
> >  {
> > +	/*
> > +	 * flock only requires READ access and to support
> > +	 * clients which send flock locks via NLM we
> > +	 * report O_RDONLY for full-file locks.
> > +	 */
> > +	if (lock->fl_start =3D=3D 0 &&
> > +	    lock->fl_end =3D=3D NLM4_OFFSET_MAX)
> > +		return O_RDONLY;
> >  	return lock_is_write(lock) ? O_WRONLY : O_RDONLY;
> >  }
> > =20
> >=20
> > But I wouldn't encourage him to.
> >=20
> > NeilBrown
> >=20
> >=20
> > >=20
> > > will trigger the error as shown above:
> > >=20
> > > $ flock -e -w 4 /srv/NAS/test/debian-13.3.0-amd64-netinst.iso sleep 1
> > > flock: /srv/NAS/test/debian-13.3.0-amd64-netinst.iso: No locks availa=
ble
> > >=20
> > > A simple test program calling fcntl() with the same arguments QEMU us=
es=20
> > > also fails in the same way.
> > >=20
> > > $ ./nfs3_range_lock_test=20
> > > /srv/NAS/test/debian-13.3.0-amd64-netinst.{iso,overlay}
> > > Opened base file: /srv/NAS/test/debian-13.3.0-amd64-netinst.iso
> > > Opened overlay file: /srv/NAS/test/debian-13.3.0-amd64-netinst.overla=
y
> > > Attempting lock at 4 on /srv/NAS/test/debian-13.3.0-amd64-netinst.iso
> > > fcntl(fd, F_GETLK, &fl) failed on base: No locks available
> > > Attempting lock at 8 on /srv/NAS/test/debian-13.3.0-amd64-netinst.ove=
rlay
> > > fcntl(fd, F_GETLK, &fl) failed on overlay: No locks available
> > >=20
> > >=20
> > >=20
> > >=20
> >=20
>=20

--=20
Jeff Layton <jlayton@kernel.org>


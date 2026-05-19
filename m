Return-Path: <linux-nfs+bounces-21706-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KBkqHPqVDGq/jQUAu9opvQ
	(envelope-from <linux-nfs+bounces-21706-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Tue, 19 May 2026 18:55:22 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E38E4582B0F
	for <lists+linux-nfs@lfdr.de>; Tue, 19 May 2026 18:55:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B9A82305D865
	for <lists+linux-nfs@lfdr.de>; Tue, 19 May 2026 16:38:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CF63352008;
	Tue, 19 May 2026 16:38:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="t/vwKjWw"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3768D352004
	for <linux-nfs@vger.kernel.org>; Tue, 19 May 2026 16:38:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779208717; cv=none; b=JKHf6jxQNjxD+bfTG9VBIqhn65CsheUONIpaeBu5Ban95n4vr/jJdJbjXGJGqECLMg4aRMZDQPM+phuMj1xqf4qfj1kfnXo8rVioy3GsA3mGBU6MbqFEf9hOFoh/RdZg/hB8RCweoa03ncA4+IDNO/oB7ggMTg1AnoQzjQXevxs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779208717; c=relaxed/simple;
	bh=awDA1lmyL3FYpPwRXlXWhUQjEqVhN5jgZ1Fc+jZh3bQ=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=o9W9MbJ/78NvoKU1HJuKMTDxkQf4pGUCy7Amyb/5jpBDu8UqLnvOiPxEHvjLiizKOKNZmf5ksFQi1O83bJy3Y8fkAiuCNfU+vs96CYlOEp8J4Mp3o1L20MWZNnhWK0ccQaFROTVg1wvq9MnTAvdhlEy/CJjHWReqIO+ZeKFMwSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=t/vwKjWw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01770C2BCB3;
	Tue, 19 May 2026 16:38:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779208716;
	bh=awDA1lmyL3FYpPwRXlXWhUQjEqVhN5jgZ1Fc+jZh3bQ=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=t/vwKjWwXJPPH5RWS8LQFtSZGgRX9f2hH1HhGhLteH56yVR8eEGUFJkxQ8ZDENBsN
	 Z0pmVVfMzwkP/bOPV74XfFIGi0DsTqcWoETeV+e1MyZWUjZFK9/0xtneadufLR/RU8
	 QYMryEubNEi1ypBa0YruskLkUCYBh8f2mrizqFHG5ey5mQOwvRi4uwrp3v/ObezuVx
	 sdpqddwr1Job5wriAC/ndUkmatLzrbsvjHsCzw+7CpA5Yz+gbVMbb2JcouLW22CBwn
	 /JedyeM2ndkblor59MRsEmWH8pMYwL7WLKj8Ek6hsQk0Wqid0GuuF8ld/oxqCZJFAr
	 8Grh3u95v56ag==
Message-ID: <cedc5b4159b50265f87810116d1e622c97700c9a.camel@kernel.org>
Subject: Re: [PATCH 2/2] SUNRPC: Return an error from xdr_buf_to_bvec() on
 overflow
From: Jeff Layton <jlayton@kernel.org>
To: Chuck Lever <cel@kernel.org>, Trond Myklebust <trondmy@kernel.org>, Anna
 Schumaker <anna@kernel.org>
Cc: NeilBrown <neil@brown.name>, Olga Kornievskaia <okorniev@redhat.com>, 
 Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>, Chris Mason
 <clm@meta.com>, 	linux-nfs@vger.kernel.org, Chuck Lever
 <chuck.lever@oracle.com>
Date: Tue, 19 May 2026 12:38:33 -0400
In-Reply-To: <20260519-xdr-buf-to-bvec-fix-v1-2-1c9decbd4466@oracle.com>
References: <20260519-xdr-buf-to-bvec-fix-v1-0-1c9decbd4466@oracle.com>
	 <20260519-xdr-buf-to-bvec-fix-v1-2-1c9decbd4466@oracle.com>
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
User-Agent: Evolution 3.60.1 (3.60.1-1.fc44) 
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
	TAGGED_FROM(0.00)[bounces-21706-lists,linux-nfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jlayton@kernel.org,linux-nfs@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,meta.com:email,oracle.com:email]
X-Rspamd-Queue-Id: E38E4582B0F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, 2026-05-19 at 09:34 -0400, Chuck Lever wrote:
> From: Chuck Lever <chuck.lever@oracle.com>
>=20
> xdr_buf_to_bvec() returns a slot count even when the caller's bvec
> budget is exhausted partway through the xdr_buf. Callers feed that
> count into iov_iter_bvec() and continue as if the conversion had
> succeeded, silently sending or writing fewer bytes than the data
> length declares. For an NFS WRITE the server reports the truncated
> transfer to the client as full success.
>=20
> The overflow represents an internal invariant violation: a higher
> layer reserved a bvec budget too small for the xdr_buf it then
> asked the encoder to convert. That is a server-side fault, not a
> media I/O failure and not a malformed client argument.
>=20
> Change xdr_buf_to_bvec() to return a signed int and have the
> overflow label return -ESERVERFAULT. Update the three callers to
> detect the negative return and fail the request: nfsd_vfs_write()
> folds the error into host_err, which nfserrno() translates to
> nfserr_serverfault for the WRITE reply; svc_udp_sendto() and
> svc_tcp_sendmsg() propagate the error out of the send path.
>=20
> Reported-by: Chris Mason <clm@meta.com>
> Fixes: 2eb2b9358181 ("SUNRPC: Convert svc_tcp_sendmsg to use bio_vecs dir=
ectly")
> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
> ---
>  fs/nfsd/vfs.c              |  6 +++++-
>  include/linux/sunrpc/xdr.h |  4 ++--
>  net/sunrpc/svcsock.c       | 14 ++++++++++++--
>  net/sunrpc/xdr.c           | 11 ++++++-----
>  4 files changed, 25 insertions(+), 10 deletions(-)
>=20
> diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
> index eafdf7b7890f..83324cf472ef 100644
> --- a/fs/nfsd/vfs.c
> +++ b/fs/nfsd/vfs.c
> @@ -1439,7 +1439,7 @@ nfsd_vfs_write(struct svc_rqst *rqstp, struct svc_f=
h *fhp,
>  	unsigned long		exp_op_flags =3D 0;
>  	unsigned int		pflags =3D current->flags;
>  	bool			restore_flags =3D false;
> -	unsigned int		nvecs;
> +	int			nvecs;
> =20
>  	trace_nfsd_write_opened(rqstp, fhp, offset, *cnt);
> =20
> @@ -1479,6 +1479,10 @@ nfsd_vfs_write(struct svc_rqst *rqstp, struct svc_=
fh *fhp,
>  	}
> =20
>  	nvecs =3D xdr_buf_to_bvec(rqstp->rq_bvec, rqstp->rq_maxpages, payload);
> +	if (nvecs < 0) {
> +		host_err =3D nvecs;
> +		goto out_nfserr;
> +	}
> =20
>  	since =3D READ_ONCE(file->f_wb_err);
>  	if (verf)
> diff --git a/include/linux/sunrpc/xdr.h b/include/linux/sunrpc/xdr.h
> index 31971b01d962..b102b4f21e6b 100644
> --- a/include/linux/sunrpc/xdr.h
> +++ b/include/linux/sunrpc/xdr.h
> @@ -138,8 +138,8 @@ void	xdr_terminate_string(const struct xdr_buf *, con=
st u32);
>  size_t	xdr_buf_pagecount(const struct xdr_buf *buf);
>  int	xdr_alloc_bvec(struct xdr_buf *buf, gfp_t gfp);
>  void	xdr_free_bvec(struct xdr_buf *buf);
> -unsigned int xdr_buf_to_bvec(struct bio_vec *bvec, unsigned int bvec_siz=
e,
> -			     const struct xdr_buf *xdr);
> +int xdr_buf_to_bvec(struct bio_vec *bvec, unsigned int bvec_size,
> +		    const struct xdr_buf *xdr);
>  int xdr_buf_to_sg(const struct xdr_buf *buf, unsigned int offset,
>  		  unsigned int len, struct scatterlist *sg, unsigned int nsg);
>  int xdr_buf_to_sg_alloc(const struct xdr_buf *buf, unsigned int offset,
> diff --git a/net/sunrpc/svcsock.c b/net/sunrpc/svcsock.c
> index 7be3de1a1aed..c434b6a6637d 100644
> --- a/net/sunrpc/svcsock.c
> +++ b/net/sunrpc/svcsock.c
> @@ -732,7 +732,7 @@ static int svc_udp_sendto(struct svc_rqst *rqstp)
>  		.msg_flags	=3D MSG_SPLICE_PAGES,
>  		.msg_controllen	=3D sizeof(buffer),
>  	};
> -	unsigned int count;
> +	int count;
>  	int err;
> =20
>  	svc_udp_release_ctxt(xprt, rqstp->rq_xprt_ctxt);
> @@ -746,6 +746,10 @@ static int svc_udp_sendto(struct svc_rqst *rqstp)
>  		goto out_notconn;
> =20
>  	count =3D xdr_buf_to_bvec(svsk->sk_bvec, SUNRPC_MAX_UDP_SENDPAGES, xdr)=
;
> +	if (count < 0) {
> +		err =3D count;
> +		goto out_trace;
> +	}
> =20
>  	iov_iter_bvec(&msg.msg_iter, ITER_SOURCE, svsk->sk_bvec,
>  		      count, rqstp->rq_res.len);
> @@ -757,6 +761,7 @@ static int svc_udp_sendto(struct svc_rqst *rqstp)
>  		err =3D sock_sendmsg(svsk->sk_sock, &msg);
>  	}
> =20
> +out_trace:
>  	trace_svcsock_udp_send(xprt, err);
> =20
>  	mutex_unlock(&xprt->xpt_mutex);
> @@ -1237,7 +1242,7 @@ static int svc_tcp_sendmsg(struct svc_sock *svsk, s=
truct svc_rqst *rqstp,
>  	struct msghdr msg =3D {
>  		.msg_flags	=3D MSG_SPLICE_PAGES,
>  	};
> -	unsigned int count;
> +	int count;
>  	void *buf;
>  	int ret;
> =20
> @@ -1253,10 +1258,15 @@ static int svc_tcp_sendmsg(struct svc_sock *svsk,=
 struct svc_rqst *rqstp,
> =20
>  	count =3D xdr_buf_to_bvec(svsk->sk_bvec + 1, rqstp->rq_maxpages,
>  				&rqstp->rq_res);
> +	if (count < 0) {
> +		ret =3D count;
> +		goto out;
> +	}
> =20
>  	iov_iter_bvec(&msg.msg_iter, ITER_SOURCE, svsk->sk_bvec,
>  		      1 + count, sizeof(marker) + rqstp->rq_res.len);
>  	ret =3D sock_sendmsg(svsk->sk_sock, &msg);
> +out:
>  	page_frag_free(buf);
>  	return ret;
>  }
> diff --git a/net/sunrpc/xdr.c b/net/sunrpc/xdr.c
> index 8f52782d8a37..fa6a30b5f046 100644
> --- a/net/sunrpc/xdr.c
> +++ b/net/sunrpc/xdr.c
> @@ -139,13 +139,14 @@ xdr_free_bvec(struct xdr_buf *buf)
>  /**
>   * xdr_buf_to_bvec - Copy components of an xdr_buf into a bio_vec array
>   * @bvec: bio_vec array to populate
> - * @bvec_size: element count of @bio_vec
> + * @bvec_size: element count of @bvec
>   * @xdr: xdr_buf to be copied
>   *
> - * Returns the number of entries consumed in @bvec.
> + * Returns the number of entries consumed in @bvec on success, or
> + * -ESERVERFAULT when @xdr does not fit within @bvec_size entries.
>   */
> -unsigned int xdr_buf_to_bvec(struct bio_vec *bvec, unsigned int bvec_siz=
e,
> -			     const struct xdr_buf *xdr)
> +int xdr_buf_to_bvec(struct bio_vec *bvec, unsigned int bvec_size,
> +		    const struct xdr_buf *xdr)
>  {
>  	const struct kvec *head =3D xdr->head;
>  	const struct kvec *tail =3D xdr->tail;
> @@ -187,7 +188,7 @@ unsigned int xdr_buf_to_bvec(struct bio_vec *bvec, un=
signed int bvec_size,
> =20
>  bvec_overflow:
>  	pr_warn_once("%s: bio_vec array overflow\n", __func__);
> -	return count;
> +	return -ESERVERFAULT;
>  }
>  EXPORT_SYMBOL_GPL(xdr_buf_to_bvec);
> =20

Reviewed-by: Jeff Layton <jlayton@kernel.org>


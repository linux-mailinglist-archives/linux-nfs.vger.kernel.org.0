Return-Path: <linux-nfs+bounces-20633-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SG5iDyPOz2kP0wYAu9opvQ
	(envelope-from <linux-nfs+bounces-20633-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Fri, 03 Apr 2026 16:26:43 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4541A395344
	for <lists+linux-nfs@lfdr.de>; Fri, 03 Apr 2026 16:26:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 93FF9302A724
	for <lists+linux-nfs@lfdr.de>; Fri,  3 Apr 2026 14:25:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 826FB315793;
	Fri,  3 Apr 2026 14:25:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YYjODexi"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DD982E173B
	for <linux-nfs@vger.kernel.org>; Fri,  3 Apr 2026 14:25:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775226330; cv=none; b=pzqceOpYZTiS+IG1/JudpThITR/2z+QCpsvlpjBXdrfGvGS66Of492Mutf5SDX5FhDFl4ys62wO/A7GaeqOUyR1+quwhOGpp2+VIIBUxamKvrB82cRKO/9NNqGKkqrONcBluPQCO+1SRLYSabfL9wIGl6iEud0PIEfWisl8mwC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775226330; c=relaxed/simple;
	bh=34N99hQANwD/XmGmnB4Bj1eg6zdnMCCcgqhMqFfmji8=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=j0ccfJO90IdZ2LZwIcjylgt9eFrZjLJfl2Zspk1ki2/EziRVduccepr0z07bmhxSjQrlrQxJK3GVrSd71QxK3Ko9MD07fFEZ8Dczo9W5PNUPlsHv8FLcc9QVK2rRm36epBR4TvJhIEkIyeF/QqTtHbHae5F4gAjQNQGD6yMliwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YYjODexi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B6C1C4CEF7;
	Fri,  3 Apr 2026 14:25:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775226330;
	bh=34N99hQANwD/XmGmnB4Bj1eg6zdnMCCcgqhMqFfmji8=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=YYjODexiyV1k1uO4AnP2l/w09gjfTnBdHyeJPOe4tvipfL6mKP4Rcqr4HdjPZuFEG
	 CwAzQWnnptndIxTxisF/XBe/sOYJcwyqUPIrpZ0s9z2AGnfD1Cm5h2hEsxZyuSuW5q
	 rzWkvJAO1UpUlaLnS8rXmeTaPlSTg6IjwdVxRFUVFOfjjpT84et0tOQUoRwIfz5yZA
	 98+xfXNrWanHF+2eEBF5w47E40fK1oGLzc/vc30ngTe6WYWga1aaAwueVkWiWXI2LK
	 VVf0loDOpU8FkEdUiEU83vKcSUUMgf0nB7KnZp3oQK/7AFsDBFu9kR8lDr1xa5UJzR
	 OqgUWryuJz4Yw==
Message-ID: <ed256acbdea17162c21b089fedcc1ffb2d1b874e.camel@kernel.org>
Subject: Re: [PATCH] nfsd: fix file change detection in CB_GETATTR
From: Jeff Layton <jlayton@kernel.org>
To: Scott Mayhew <smayhew@redhat.com>, Chuck Lever <chuck.lever@oracle.com>
Cc: NeilBrown <neil@brown.name>, Olga Kornievskaia <okorniev@redhat.com>, 
 Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>,
 linux-nfs@vger.kernel.org
Date: Fri, 03 Apr 2026 10:25:26 -0400
In-Reply-To: <20260403132209.1479385-1-smayhew@redhat.com>
References: <20260403132209.1479385-1-smayhew@redhat.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-20633-lists,linux-nfs=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 4541A395344
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, 2026-04-03 at 09:22 -0400, Scott Mayhew wrote:
> RFC 8881, section 10.4.3 doesn't say anything about caching the file
> size in the delegation record, nor does it say anything about comparing
> a cached file size with the size reported by the client in the
> CB_GETATTR reply for the purpose of determining if the client holds
> modified data for the file.
>=20
> What section 10.4.3 of RFC 8881 does say is that the server should
> compare the *current* file size with size reported by the client holding
> the delegation in the CB_GETATTR reply, and if they differ to treat it
> as a modification regardless of the change attribute retrieved via the
> CB_GETATTR.
>=20
> Doing otherwise would cause the server to believe the client holding the
> delegation has a modified version of the file, even if the client
> flushed the modifications to the server prior to the CB_GETATTR.  This
> would have the added side effect of subsequent CB_GETATTRs causing
> updates to the mtime, ctime, and change attribute even if the client
> holding the delegation makes no further updates to the file.
>=20
> Modify nfsd4_deleg_getattr_conflict() to obtain the current file size
> via vfs_getattr().  Retain the ncf_cur_fsize field, since it's a
> convenient way to return the file size back to nfsd4_encode_fattr4(),
> but don't use it for the purpose of detecting file changes.
>=20
> Fixes: c5967721e106 ("NFSD: handle GETATTR conflict with write delegation=
")
> Signed-off-by: Scott Mayhew <smayhew@redhat.com>
> ---
> Note this patch is against Chuck's nfsd-next branch.
>=20
> Also, I have a pynfs test that illustrates the "bad" behavior.  See
> "pynfs: add delegation test for CB_GETATTR after sync WRITE", which will
> be sent shortly.
>=20
>  fs/nfsd/nfs4state.c | 17 +++++++++++------
>  fs/nfsd/nfs4xdr.c   |  2 +-
>  fs/nfsd/state.h     |  2 +-
>  3 files changed, 13 insertions(+), 8 deletions(-)
>=20
> diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
> index b4d0e82b2690..2c82438918f6 100644
> --- a/fs/nfsd/nfs4state.c
> +++ b/fs/nfsd/nfs4state.c
> @@ -9372,7 +9372,7 @@ static int cb_getattr_update_times(struct dentry *d=
entry, struct nfs4_delegation
>   * caller must put the reference.
>   */
>  __be32
> -nfsd4_deleg_getattr_conflict(struct svc_rqst *rqstp, struct dentry *dent=
ry,
> +nfsd4_deleg_getattr_conflict(struct svc_rqst *rqstp, struct path *path,
>  			     struct nfs4_delegation **pdp)
>  {
>  	struct nfsd_net *nn =3D net_generic(SVC_NET(rqstp), nfsd_net_id);
> @@ -9381,7 +9381,9 @@ nfsd4_deleg_getattr_conflict(struct svc_rqst *rqstp=
, struct dentry *dentry,
>  	struct nfs4_delegation *dp =3D NULL;
>  	struct file_lease *fl;
>  	struct nfs4_cb_fattr *ncf;
> -	struct inode *inode =3D d_inode(dentry);
> +	struct inode *inode =3D d_inode(path->dentry);
> +	struct kstat stat;
> +	int err;
>  	__be32 status;
> =20
>  	ctx =3D locks_inode_context(inode);
> @@ -9430,19 +9432,22 @@ nfsd4_deleg_getattr_conflict(struct svc_rqst *rqs=
tp, struct dentry *dentry,
>  		    !nfsd_wait_for_delegreturn(rqstp, inode))
>  			goto out_status;
>  	}
> +	err =3D vfs_getattr(path, &stat, STATX_SIZE, AT_STATX_SYNC_AS_STAT);
> +	if (err) {
> +		status =3D nfserrno(err);
> +		goto out_status;
> +	}
>  	if (!ncf->ncf_file_modified &&
>  	    (ncf->ncf_initial_cinfo !=3D ncf->ncf_cb_change ||
> -	     ncf->ncf_cur_fsize !=3D ncf->ncf_cb_fsize))
> +	     stat.size !=3D ncf->ncf_cb_fsize))
>  		ncf->ncf_file_modified =3D true;
>  	if (ncf->ncf_file_modified) {
> -		int err;
> -
>  		/*
>  		 * Per section 10.4.3 of RFC 8881, the server would
>  		 * not update the file's metadata with the client's
>  		 * modified size
>  		 */
> -		err =3D cb_getattr_update_times(dentry, dp);
> +		err =3D cb_getattr_update_times(path->dentry, dp);
>  		if (err) {
>  			status =3D nfserrno(err);
>  			goto out_status;
> diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
> index 2a0946c630e1..b380c2545f6a 100644
> --- a/fs/nfsd/nfs4xdr.c
> +++ b/fs/nfsd/nfs4xdr.c
> @@ -3914,7 +3914,7 @@ nfsd4_encode_fattr4(struct svc_rqst *rqstp, struct =
xdr_stream *xdr,
>  	    (attrmask[1] & (FATTR4_WORD1_TIME_ACCESS |
>  			    FATTR4_WORD1_TIME_MODIFY |
>  			    FATTR4_WORD1_TIME_METADATA))) {
> -		status =3D nfsd4_deleg_getattr_conflict(rqstp, dentry, &dp);
> +		status =3D nfsd4_deleg_getattr_conflict(rqstp, &path, &dp);
>  		if (status)
>  			goto out;
>  	}
> diff --git a/fs/nfsd/state.h b/fs/nfsd/state.h
> index 9b05462da4cc..edfb3402dfd2 100644
> --- a/fs/nfsd/state.h
> +++ b/fs/nfsd/state.h
> @@ -889,7 +889,7 @@ static inline bool try_to_expire_client(struct nfs4_c=
lient *clp)
>  }
> =20
>  extern __be32 nfsd4_deleg_getattr_conflict(struct svc_rqst *rqstp,
> -		struct dentry *dentry, struct nfs4_delegation **pdp);
> +		struct path *path, struct nfs4_delegation **pdp);
> =20
>  struct nfsd4_get_dir_delegation;
>  struct nfs4_delegation *nfsd_get_dir_deleg(struct nfsd4_compound_state *=
cstate,

Reviewed-by: Jeff Layton <jlayton@kernel.org>


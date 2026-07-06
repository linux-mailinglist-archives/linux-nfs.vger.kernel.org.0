Return-Path: <linux-nfs+bounces-23100-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id y/+pCzzXS2rwbAEAu9opvQ
	(envelope-from <linux-nfs+bounces-23100-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Mon, 06 Jul 2026 18:26:36 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7651D7133D2
	for <lists+linux-nfs@lfdr.de>; Mon, 06 Jul 2026 18:26:35 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=MOQoGuQq;
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "linux-nfs+bounces-23100-lists+linux-nfs=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-nfs+bounces-23100-lists+linux-nfs=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3B1D435DE448
	for <lists+linux-nfs@lfdr.de>; Mon,  6 Jul 2026 15:52:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFAA53A8753;
	Mon,  6 Jul 2026 15:52:28 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14BAE3EB0EE
	for <linux-nfs@vger.kernel.org>; Mon,  6 Jul 2026 15:52:20 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783353146; cv=none; b=SwwEZSm5nUMJ6R2svDmkm7M8BmOMH9fOoSnDcnpt2NYkW1RBP6xVMnYiX/VvmRt3Srn9pvcPcsqYFj9bLTL/xDLZGO1HiZQmk/y0WC0wheBIqFACSvL3PCJbtQ+wrhbNviL6OyNZkgAkdQY55yiFzFgLR7no0WNtBUg6Cb37hro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783353146; c=relaxed/simple;
	bh=gXZASFQyiiaSmZ/vOl4/oHyzSXWuIYJoDZAmRKRK6rQ=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=NTxCqMpLGFFZKQ4F0/ezA/d+Op/e0HEjji64Mn+fFZ/LBOfO83bbTAyyJVh0MYKAUx+gYOVBxVHoDBzS5JulIfRNGzgGYcEcanDWtqPdHDbQJNvSvCVlBLps0215SCPi1hOsk93y21F65c/T0ArlfTKxVVoYWQy6Nu3s//R6yQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MOQoGuQq; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5C671F00A3A;
	Mon,  6 Jul 2026 15:52:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783353137;
	bh=CUDOxJb4WEWHl/BDrlHvuC5Ttz26RzVYRmI5/HDTzs0=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=MOQoGuQqg2LVwoLr4jilvsByINB9hfmq6zLSU5TNMNoqlCSVqXQznq93pxBvESO/9
	 WkaEK/lnVghjr++sC/D4av9Yd7wizK6B2namGk+I42Q8ifW9LDAdsnnT9EiwZX+eCq
	 UFF75i9Hpj6oUuzpD2ddt4VHAtsWy+cMI6F7Gdz0Iw4lvbNsdfmAycGOH6Gqm93Xa5
	 YYlCkHm27DTiTQ6W95oTFXmCmiFx+NjIOK2029Bs952DbEYrtQ+e/qs1xTnhpsg92t
	 Fx568lEbh+Fg+EBIaUxLm/StMh0Qij/kr1yEXT/m9EAFGoKSjviotyEfSEIAuBeQ2O
	 EkZUAw7okAHFQ==
Message-ID: <8ef43a6cfb235b0ef449388d56a4faeab492160c.camel@kernel.org>
Subject: Re: [PATCH v2 06/14] nfsd: in nfsd4_create_file() let VFS report if
 file was created.
From: Jeff Layton <jlayton@kernel.org>
To: NeilBrown <neil@brown.name>, Chuck Lever <chuck.lever@oracle.com>
Cc: Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, 
 Tom Talpey <tom@talpey.com>, linux-nfs@vger.kernel.org
Date: Mon, 06 Jul 2026 11:52:15 -0400
In-Reply-To: <20260705222032.1240057-7-neilb@ownmail.net>
References: <20260705222032.1240057-1-neilb@ownmail.net>
	 <20260705222032.1240057-7-neilb@ownmail.net>
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
User-Agent: Evolution 3.60.2 (3.60.2-1.fc44) 
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:neil@brown.name,m:chuck.lever@oracle.com,m:okorniev@redhat.com,m:Dai.Ngo@oracle.com,m:tom@talpey.com,m:linux-nfs@vger.kernel.org,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[jlayton@kernel.org,linux-nfs@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-23100-lists,linux-nfs=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jlayton@kernel.org,linux-nfs@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,brown.name:email,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 7651D7133D2

On Mon, 2026-07-06 at 08:19 +1000, NeilBrown wrote:
> From: NeilBrown <neil@brown.name>
>=20
> nfsd4_create_file() currently assumes that if a lookup failed but then a
> create succeeds, then the "create" operation actually created the file.
> With atomic_open this may not be the case - some other actor might have
> created the file between the lookup and the create.
>=20
> So we move the call to nfsd4_vfs_create() earlier and set ->op_created
> based on the FMODE_CREATED flag that it set.  Then use "!  ->op_created"
> to trigger nfserr_exist handling.
>=20
> The switch statement is split up into two if() statements.
> First we check for the possibility of a successful exclusive
> create and set ->op_create to true if appropriate.
> Then we check for NFS4_CREATE_UNCHECKED to decide if a
> pre-existing file means an error or success.
>=20
> This allows us to combine the two fh_compose() calls to one place.
>=20
> A subtle difference here is that we now must only pass O_EXCL to
> dentry_create() for NFS4_CREATE_GUARDED.  For the EXCLUSIVE create modes
> we want a successful open even if the file already exists.  We then
> check the verifier after the open succeeded to see if it was exclusive.
>=20

Do we really want a successful open in the EXCLUSIVE cases?

Opens have side effects (notably, that they can cause delegation
recalls). If you have two racing clients creating a file, the first
gets an open and write delegation and then the second ends up
immediately causing a delegrecall for the first, even though it may
never touch the file again after the OPEN fails.

I think we may want to reconsider that logic, if possible: Maybe we
should keep using O_EXCL in those cases and just re-drive the open
without it if it fails and the verifier looks right? That's a bit
uglier, but that may cause fewer delegation recalls.

> The above requires changing dentry_create() to reliably set
> FMODE_CREATED when the file was actually created.  Previously it only
> sets this flag when atomic_open is used.
>=20
> Signed-off-by: NeilBrown <neil@brown.name>
> ---
>  fs/namei.c         |  2 ++
>  fs/nfsd/nfs4proc.c | 69 ++++++++++++++++++++--------------------------
>  2 files changed, 32 insertions(+), 39 deletions(-)
>=20
> diff --git a/fs/namei.c b/fs/namei.c
> index 5cc9f0f466b8..e0a62198fc60 100644
> --- a/fs/namei.c
> +++ b/fs/namei.c
> @@ -5073,6 +5073,8 @@ struct file *dentry_create(struct path *path, int f=
lags, umode_t mode,
>  		error =3D vfs_create(mnt_idmap(path->mnt), path->dentry, mode, NULL);
>  		if (!error)
>  			error =3D vfs_open(path, file);
> +		if (!error)
> +			file->f_mode |=3D FMODE_CREATED;
>  	}
>  	if (unlikely(error))
>  		return ERR_PTR(error);
> diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
> index 69cdbdcde7e9..f59ee074c0c9 100644
> --- a/fs/nfsd/nfs4proc.c
> +++ b/fs/nfsd/nfs4proc.c
> @@ -210,7 +210,11 @@ nfsd4_vfs_create(struct svc_fh *fhp, struct dentry *=
*child,
>  	int oflags;
> =20
>  	oflags =3D O_CREAT | O_LARGEFILE;
> -	if (nfsd4_create_is_exclusive(open->op_createmode))
> +	/*
> +	 * For the EXCLUSIVE modes we do our own uniqueness tests
> +	 * so don't want O_EXCL.
> +	 */
> +	if (open->op_createmode =3D=3D NFS4_CREATE_GUARDED)
>  		oflags |=3D O_EXCL;
> =20
>  	switch (open->op_share_access & NFS4_SHARE_ACCESS_BOTH) {
> @@ -333,22 +337,30 @@ nfsd4_create_file(struct svc_rqst *rqstp, struct sv=
c_fh *fhp,
>  		status =3D fh_verify(rqstp, fhp, S_IFDIR, NFSD_MAY_CREATE);
>  		if (status !=3D nfs_ok)
>  			goto out;
> -	}
> =20
> -	if (d_really_is_positive(child)) {
> -		/* NFSv4 protocol requires change attributes even though
> -		 * no change happened.
> -		 */
> -		fh_fill_post_noop(fhp);
> -
> -		status =3D fh_compose(resfhp, fhp->fh_export, child, fhp);
> +		status =3D nfsd4_vfs_create(fhp, &child, open);
>  		if (status !=3D nfs_ok)
>  			goto out;
> +		open->op_created =3D open->op_filp->f_mode & FMODE_CREATED;
> +	}
> =20
> -		switch (open->op_createmode) {
> -		case NFS4_CREATE_UNCHECKED:
> -			if (!d_is_reg(child))
> -				break;
> +	status =3D fh_compose(resfhp, fhp->fh_export, child, fhp);
> +	if (status !=3D nfs_ok)
> +		goto out;
> +
> +	if (!open->op_created &&
> +	    nfsd4_create_is_exclusive(open->op_createmode) &&
> +	    inode_get_mtime_sec(d_inode(child)) =3D=3D v_mtime &&
> +	    inode_get_atime_sec(d_inode(child)) =3D=3D v_atime &&
> +	    d_inode(child)->i_size =3D=3D 0)
> +		open->op_created =3D true;
> +
> +	if (!open->op_created) {
> +		if (open->op_createmode =3D=3D NFS4_CREATE_UNCHECKED) {
> +			/* NFSv4 protocol requires change attributes
> +			 * even though no change happened.
> +			 */
> +			fh_fill_post_noop(fhp);
> =20
>  			/*
>  			 * In NFSv4, we don't want to truncate the file
> @@ -356,41 +368,20 @@ nfsd4_create_file(struct svc_rqst *rqstp, struct sv=
c_fh *fhp,
>  			 * some other reason. Furthermore, if the size is
>  			 * nonzero, we should ignore it according to spec!
>  			 */
> -			open->op_truncate =3D (iap->ia_valid & ATTR_SIZE) &&
> -						!iap->ia_size;
> -			break;
> -		case NFS4_CREATE_GUARDED:
> -			status =3D nfserr_exist;
> -			break;
> -		case NFS4_CREATE_EXCLUSIVE:
> -		case NFS4_CREATE_EXCLUSIVE4_1:
> -			if (inode_get_mtime_sec(d_inode(child)) =3D=3D v_mtime &&
> -			    inode_get_atime_sec(d_inode(child)) =3D=3D v_atime &&
> -			    d_inode(child)->i_size =3D=3D 0) {
> -				open->op_created =3D true;
> -				goto set_attr;
> -			}
> +			open->op_truncate =3D (d_is_reg(child) &&
> +					     (iap->ia_valid & ATTR_SIZE) &&
> +					     !iap->ia_size);
> +		} else
>  			status =3D nfserr_exist;
> -			break;
> -		}
>  		goto out;
>  	}
> -
> -	status =3D nfsd4_vfs_create(fhp, &child, open);
> -	if (status !=3D nfs_ok)
> -		goto out;
> -	open->op_created =3D true;
> +	/* file was created */
>  	fh_fill_post_attrs(fhp);
> =20
> -	status =3D fh_compose(resfhp, fhp->fh_export, child, fhp);
> -	if (status !=3D nfs_ok)
> -		goto out;
> -
>  	/* A newly created file already has a file size of zero. */
>  	if ((iap->ia_valid & ATTR_SIZE) && (iap->ia_size =3D=3D 0))
>  		iap->ia_valid &=3D ~ATTR_SIZE;
> =20
> -set_attr:
>  	status =3D nfsd_create_setattr(rqstp, fhp, resfhp, &attrs);
> =20
>  	if (attrs.na_labelerr)

--=20
Jeff Layton <jlayton@kernel.org>


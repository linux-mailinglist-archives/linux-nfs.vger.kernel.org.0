Return-Path: <linux-nfs+bounces-18736-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oAGiFp58hGl/3AMAu9opvQ
	(envelope-from <linux-nfs+bounces-18736-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Thu, 05 Feb 2026 12:18:54 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 64B73F1C92
	for <lists+linux-nfs@lfdr.de>; Thu, 05 Feb 2026 12:18:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 8E04130028C1
	for <lists+linux-nfs@lfdr.de>; Thu,  5 Feb 2026 11:18:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06DA42609E3;
	Thu,  5 Feb 2026 11:18:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nQ9fPeD0"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6EA113C918;
	Thu,  5 Feb 2026 11:18:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770290327; cv=none; b=VPiugyFZzwzlonJb6/1mWO+SE5kT5qyWMv8L3M7WEVR4i7r1ewzIjdj1E6mf6oQJ1PM8qIne5dSbS23Pcy5Q8j2QMEfWTE6IvhzH5WQPokrbmEtN5VuqnHal84ElYhq+RNg2mOs8p4IoviWcFHwhl6XhCgLIWV35HaPKPZB/P1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770290327; c=relaxed/simple;
	bh=BlcIuNYWPg9lpO6h13T4Wsx856P2IBJ0XmWZYz80JCQ=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Le1/cFEa2TY+fYSaFbE2usIpt2vCcM3b+nzhBZuLTabl5i8zT2qPLDGBOeV2HSwIJspLh2hmpjVmZ1NfES/w95DA2fBTtyUjxsorD3s9BoAP7xxzx5i3DU39lfVv+QnArEZ7gjMYeBQ7ujbIAG1y2WLOuQrhxP0KY/G5koHVX10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nQ9fPeD0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80FD5C4CEF7;
	Thu,  5 Feb 2026 11:18:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770290327;
	bh=BlcIuNYWPg9lpO6h13T4Wsx856P2IBJ0XmWZYz80JCQ=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=nQ9fPeD0PcHJ7dmIl/IPzNaVHkg7fa1HMYVYlh6/maepQJY8M5E4pESSCC/cf79+i
	 mEN4NhgOHG/inVBNoY6JwZGqreNAJCDFEYfBRn3siYhAh1sJ+WmUaEvmDD3j8Uu2gu
	 xIzzeiwo3JV2NJz/Pg6gMtxb1occcbUmbZ725gLMMjDbepzYgfNZSDek7Pd3XcAh/f
	 NLHiWHixHi/hmUrFUfDnGqMEp/oOJrGVgvLseTfIQ8tYJfllY5dQUibEJsD2XFDfar
	 zpsuCgJ0TpW0lesLUPAnpWDA1gPYFftKtRAAXJTVOTAMRSSs42Oea8mOjM91TdzxMd
	 /f2CMBiQFOVfQ==
Message-ID: <d0484cf69968e0415e4c0b9fca9217ebeca928e7.camel@kernel.org>
Subject: Re: [PATCH] nfsd: report the requested maximum number of threads
 instead of number running
From: Jeff Layton <jlayton@kernel.org>
To: Mike Owen <mjnowen@gmail.com>, Chuck Lever <cel@kernel.org>, Chuck Lever
	 <chuck.lever@oracle.com>, NeilBrown <neil@brown.name>, Olga Kornievskaia	
 <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey
 <tom@talpey.com>
Cc: linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Thu, 05 Feb 2026 06:18:45 -0500
In-Reply-To: <6944906a-9256-4f10-88fa-822a639eb5eb@gmail.com>
References: <20260204-minthreads-v1-1-7480176baf35@kernel.org>
	 <2abf7a33-789f-405d-8993-8fbf30153aaa@app.fastmail.com>
	 <bb9c7c2c53d5a4196ceb0ec81dcee747dd7df5e9.camel@kernel.org>
	 <6944906a-9256-4f10-88fa-822a639eb5eb@gmail.com>
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
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-18736-lists,linux-nfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com,kernel.org,oracle.com,brown.name,redhat.com,talpey.com];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jlayton@kernel.org,linux-nfs@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,svennd.be:url]
X-Rspamd-Queue-Id: 64B73F1C92
X-Rspamd-Action: no action

You won't be able to get to the min-threads setting from /proc. That's
only available via netlink. If you enable dynamic threading (via
netlink), then the traditional "th" count in /proc currently shows you
the number of running threads. If this patch is applied, it'll show you
the requested maximum instead.

So, with this patch applied you can query both the min and max number
of threads via netlink. We don't yet have an interface to query the
number of threads currently running. In principle, you can get that
info from "ps", but we could add that to the netlink interface if
someone can make a good use-case for it.

-- Jeff

On Thu, 2026-02-05 at 10:01 +0000, Mike Owen wrote:
> Hi,
> I currently rely on: "/proc/net/rpc/nfsd" to retrieve the current number =
of threads via "th": https://svennd.be/nfsd-stats-explained-procnetrpcnfsd/
> After the various patches to introduce dynamic threading, where in the fu=
ture, would a user retrieve the currently set min, max and actual running t=
hread count reliably?
> Would be lovely if the man page indicated this.
> Thanks,
> Mike
>=20
> On 04/02/2026 19:13, Jeff Layton wrote:
> > On Wed, 2026-02-04 at 13:51 -0500, Chuck Lever wrote:
> > >=20
> > > On Wed, Feb 4, 2026, at 12:23 PM, Jeff Layton wrote:
> > > > The current netlink and /proc interfaces deviate from their traditi=
onal
> > > > values when dynamic threading is enabled, and there is currently no=
 way
> > > > to know what the current setting is. This patch brings the reportin=
g
> > > > back in line with traditional behavior.
> > > >=20
> > > > Make these interfaces report the requested maximum number of thread=
s
> > > > instead of the number currently running.
> > > >=20
> > > > Fixes: d8316b837c2c ("nfsd: add controls to set the minimum number =
of=20
> > > > threads per pool")
> > > > Signed-off-by: Jeff Layton <jlayton@kernel.org>
> > > > ---
> > > > I think this is less surprising than the current behavior of what's=
 in
> > > > Chuck's tree. We could also consider adding netlink attributes to r=
eport
> > > > the number of running threads, but you can get that info from ps to=
o.
> > > > ---
> > > >  fs/nfsd/nfsctl.c | 2 +-
> > > >  fs/nfsd/nfssvc.c | 7 ++++---
> > > >  2 files changed, 5 insertions(+), 4 deletions(-)
> > > >=20
> > > > diff --git a/fs/nfsd/nfsctl.c b/fs/nfsd/nfsctl.c
> > > > index=20
> > > > 4d8e3c1a7be3b3a4e4f5248b27b60d6b3ae88d51..178c7646b2e25630b85de937d=
7ced18947c047f9=20
> > > > 100644
> > > > --- a/fs/nfsd/nfsctl.c
> > > > +++ b/fs/nfsd/nfsctl.c
> > > > @@ -1700,7 +1700,7 @@ int nfsd_nl_threads_get_doit(struct sk_buff *=
skb,=20
> > > > struct genl_info *info)
> > > >  			struct svc_pool *sp =3D &nn->nfsd_serv->sv_pools[i];
> > > >=20
> > > >  			err =3D nla_put_u32(skb, NFSD_A_SERVER_THREADS,
> > > > -					  sp->sp_nrthreads);
> > > > +					  sp->sp_nrthrmax);
> > > >  			if (err)
> > > >  				goto err_unlock;
> > > >  		}
> > > > diff --git a/fs/nfsd/nfssvc.c b/fs/nfsd/nfssvc.c
> > > > index=20
> > > > 8184514c58de8e396795cd4714a04d66d9637f17..be0add971c2d994948c3e8fca=
19bcf6f3c75dfaf=20
> > > > 100644
> > > > --- a/fs/nfsd/nfssvc.c
> > > > +++ b/fs/nfsd/nfssvc.c
> > > > @@ -239,12 +239,13 @@ static void nfsd_net_free(struct percpu_ref *=
ref)
> > > >=20
> > > >  int nfsd_nrthreads(struct net *net)
> > > >  {
> > > > -	int rv =3D 0;
> > > > +	int i, rv =3D 0;
> > > >  	struct nfsd_net *nn =3D net_generic(net, nfsd_net_id);
> > > >=20
> > > >  	mutex_lock(&nfsd_mutex);
> > > >  	if (nn->nfsd_serv)
> > > > -		rv =3D nn->nfsd_serv->sv_nrthreads;
> > > > +		for (i =3D 0; i < nn->nfsd_serv->sv_nrpools; ++i)
> > > > +			rv +=3D nn->nfsd_serv->sv_pools[i].sp_nrthrmax;
> > > >  	mutex_unlock(&nfsd_mutex);
> > > >  	return rv;
> > > >  }
> > > > @@ -673,7 +674,7 @@ int nfsd_get_nrthreads(int n, int *nthreads, st=
ruct=20
> > > > net *net)
> > > >=20
> > > >  	if (serv)
> > > >  		for (i =3D 0; i < serv->sv_nrpools && i < n; i++)
> > > > -			nthreads[i] =3D serv->sv_pools[i].sp_nrthreads;
> > > > +			nthreads[i] =3D serv->sv_pools[i].sp_nrthrmax;
> > > >  	return 0;
> > > >  }
> > >=20
> > > AI code review observes that:
> > >=20
> > > The documentation should be updated to reflect that these interfaces
> > > now report the configured maximum threads rather than running threads=
:
> > >=20
> > > 1. Documentation/netlink/specs/nfsd.yaml line 168 - threads-get is
> > >    documented as "get the number of running threads" but now returns
> > >    the configured maximum
> > > 2. fs/nfsd/nfsctl.c lines 387-405 - The write_threads() docstring
> > >    says it reports "the number of running NFSD threads" but now
> > >    reports the configured maximum
> > > 3. fs/nfsd/nfsctl.c lines 1666-1673 - The nfsd_nl_threads_get_doit()
> > >    docstring says "get the number of running threads"
> > >=20
> >=20
> > Ok, I'll do that for v2.
> >=20
> > Thanks,
>=20

--=20
Jeff Layton <jlayton@kernel.org>


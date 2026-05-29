Return-Path: <linux-nfs+bounces-22087-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8IIeGRPPGWrgzAgAu9opvQ
	(envelope-from <linux-nfs+bounces-22087-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Fri, 29 May 2026 19:38:27 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 34570606A3A
	for <lists+linux-nfs@lfdr.de>; Fri, 29 May 2026 19:38:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id EA9FA30F9DB7
	for <lists+linux-nfs@lfdr.de>; Fri, 29 May 2026 17:32:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06D76387364;
	Fri, 29 May 2026 17:31:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Be9D30zC"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB147382394;
	Fri, 29 May 2026 17:31:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780075910; cv=none; b=T/lu1h84EKzT0l012hbddnHlSZtbh42SJz/RPEsaCzPpPA7rwAZunvWU35bhiBJHwm752a1eUrbDcBMzA7nyZbBOaGT/bpur3MLAw3g10WEA2Ma6+3poK8hIzNQOLf4Jubcrv6dE9FZSYp5ilPRCfCMUxJf1DghFrzAZ60F1bjY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780075910; c=relaxed/simple;
	bh=MQMSQmWEhJFkzfIswyfhs/Mb21Bj5GyrWCZq5ZbzJ68=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ZQ5djSy19nE5OS35/BxNZXZ/hC164G/iRs0VJs7EEnvtpCle05Tj7r1sbiP+VvZ/QaT7L4Z6I1okkHGbB2qcmbTiltH2VjA4hluAURKspkKYpejB+3MgTsjQP9SIfn8GuOXk3hEz2cv2Up3w6OXHAY5IX8hFxPsSq2QdyJdUH60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Be9D30zC; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 166361F00899;
	Fri, 29 May 2026 17:31:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780075909;
	bh=HsS54jvB99rkZSl4J6teqaQqg24anYU2BWbCptKFrbA=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=Be9D30zCxz61RFKEIE+Sl+YIDRVAaj0TMFKQEfCT0lfGPdepSLWWYpicT3IQEubmk
	 CDAmmzlQSqtUa1vUulTIfTS975VdLItoJSEJzgGHTZWAlGWgT0vGf1ijqbnP75rUhA
	 dsnBn5R8d40HVNvk6s+hCzNjGziOJ0BUB6cUYYrYmEgH4fWLl+7GCbV1oBDWrCJ2Ew
	 O2Yocun3qDv2NQyDx9k5r0pcFirTNA2cZqt+Pw2gf24If23gCEXiRU3xn66/7K5KfG
	 BULoTjNUiunCVM8C1UfCrkDoxLmma2/ye7fJIB5iJyPH9QD9AZEYhStgnWrEWoPsjd
	 xcKO8IhMDKWZw==
Message-ID: <a7d2a218bb9cb500df1af89e1db39b69b16417af.camel@kernel.org>
Subject: Re: [PATCH 02/10] nfsd: drain callbacks and clear cl_cb_session
From: Jeff Layton <jlayton@kernel.org>
To: Chuck Lever <cel@kernel.org>, Chuck Lever <chuck.lever@oracle.com>, 
 NeilBrown <neil@brown.name>, Olga Kornievskaia <okorniev@redhat.com>, Dai
 Ngo <Dai.Ngo@oracle.com>,  Tom Talpey <tom@talpey.com>, "J. Bruce Fields"
 <bfields@fieldses.org>, Scott Mayhew <smayhew@redhat.com>,  Trond Myklebust
 <Trond.Myklebust@netapp.com>, Andreas Gruenbacher <agruen@suse.de>, Mike
 Snitzer	 <snitzer@kernel.org>, Rick Macklem <rmacklem@uoguelph.ca>
Cc: Chris Mason <clm@meta.com>, linux-nfs@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Date: Fri, 29 May 2026 13:31:46 -0400
In-Reply-To: <fc8740de-d9bd-4686-a30e-e0a6c1b7f351@app.fastmail.com>
References: <20260528-nfsd-fixes-v1-0-e78708eff77d@kernel.org>
	 <20260528-nfsd-fixes-v1-2-e78708eff77d@kernel.org>
	 <fc8740de-d9bd-4686-a30e-e0a6c1b7f351@app.fastmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-22087-lists,linux-nfs=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jlayton@kernel.org,linux-nfs@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-nfs];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,meta.com:email]
X-Rspamd-Queue-Id: 34570606A3A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, 2026-05-29 at 11:13 -0400, Chuck Lever wrote:
>=20
> On Thu, May 28, 2026, at 5:55 PM, Jeff Layton wrote:
> > From: Chris Mason <clm@meta.com>
> >=20
> > After a DESTROY_SESSION the per-session teardown path can free a
> > session while rpciod still holds an inflight callback rpc_task that
> > dereferences clp->cl_cb_session.  nfsd4_probe_callback_sync() flushes
> > cl_callback_wq, but once nfsd4_run_cb_work() has called
> > rpc_call_async() the rpc_task lives on rpciod; flushing the workqueue
> > does not wait for it.  After the flush returns,
> > nfsd4_destroy_session() proceeds through nfsd4_put_session_locked()
> > and free_session() kfree()s the slab while rpciod's
> > nfsd4_cb_sequence_done(), grab_slot(), and nfsd41_cb_release_slot()
> > are still dereferencing cb->cb_clp->cl_cb_session.
> >=20
> >     destroy path                       rpciod
> >     ------------                       ------
> >     unhash_session(ses)
> >     nfsd4_probe_callback_sync(clp)
> >       flush_workqueue(cl_callback_wq)
> >       /* returns; rpc_task still live */
> >     nfsd4_put_session_locked(ses)
> >     free_session(ses) -> kfree(ses)
> >                                        nfsd4_cb_sequence_done()
> >                                          reads cb_clp->cl_cb_session
> >                                          /* freed slab */
> >=20
> > A second window exists in nfsd4_process_cb_update().  When
> > __nfsd4_find_backchannel() returns NULL because unhash_session() has
> > already removed the destroyed session from cl_sessions,
> > setup_callback_client() takes the v4.1 early return
> >=20
> >     if (!conn->cb_xprt || !ses)
> >             return -EINVAL;
> >=20
> > so clp->cl_cb_session =3D ses never fires and the field retains a
> > pointer to the about-to-be-freed session.  Symmetrically, if a later
> > probe finds a different session's backchannel conn and that
> > setup_callback_client() call fails, the error tail must still scrub
> > any previously published cl_cb_session.
> >=20
> > Fix by mirroring the two-stage drain that nfsd4_shutdown_callback()
> > already performs: call nfsd41_cb_inflight_wait_complete() in
> > nfsd4_probe_callback_sync() after flush_workqueue() so rpciod-side
> > nfsd41_cb_inflight_end() decrements are observed before the caller
> > releases the final session reference.  The two direct callers,
> > nfsd4_destroy_session() and nfsd4_init_conn() (itself invoked from
> > nfsd4_create_session() and nfsd4_bind_conn_to_session()), run in
> > sleepable process context and tolerate the wait_var_event() sleep:
> >=20
> >     nfsd4_destroy_session() (fs/nfsd/nfs4state.c):
> >       unhash_session(ses);
> >       spin_unlock(&nn->client_lock);   /* spinlock dropped */
> >       nfsd4_probe_callback_sync(ses->se_client);
> >=20
> >     nfsd4_init_conn() (fs/nfsd/nfs4state.c):
> >       acquires no locks in its body; calls nfsd4_hash_conn(),
> >       nfsd4_register_conn(), then nfsd4_probe_callback_sync() --
> >       entirely in sleepable process context.
> >=20
> > Also clear clp->cl_cb_session unconditionally on the
> > nfsd4_process_cb_update() error return so every
> > setup_callback_client() failure -- whether c is NULL or points at a
> > different session whose probe failed -- leaves the field NULL rather
> > than pointing at a session that may subsequently be freed.
> >=20
> > Fixes: dcbeaa68dbbd ("nfsd4: allow backchannel recovery")
> > Assisted-by: kres:claude-opus-4-7
> > Signed-off-by: Chris Mason <clm@meta.com>
> > ---
> >  fs/nfsd/nfs4callback.c | 21 +++++++++++++++++----
> >  1 file changed, 17 insertions(+), 4 deletions(-)
> >=20
> > diff --git a/fs/nfsd/nfs4callback.c b/fs/nfsd/nfs4callback.c
> > index 1964a213f80e..1cf6b6100357 100644
> > --- a/fs/nfsd/nfs4callback.c
> > +++ b/fs/nfsd/nfs4callback.c
> > @@ -1205,9 +1205,8 @@ static int setup_callback_client(struct=20
> > nfs4_client *clp, struct nfs4_cb_conn *c
> >  	} else {
> >  		if (!conn->cb_xprt || !ses)
> >  			return -EINVAL;
> > -		clp->cl_cb_session =3D ses;
> >  		args.bc_xprt =3D conn->cb_xprt;
> > -		args.prognumber =3D clp->cl_cb_session->se_cb_prog;
> > +		args.prognumber =3D ses->se_cb_prog;
> >  		args.protocol =3D conn->cb_xprt->xpt_class->xcl_ident |
> >  				XPRT_TRANSPORT_BC;
> >  		args.authflavor =3D ses->se_cb_sec.flavor;
> > @@ -1225,8 +1224,10 @@ static int setup_callback_client(struct=20
> > nfs4_client *clp, struct nfs4_cb_conn *c
> >  		return -ENOMEM;
> >  	}
> >=20
> > -	if (clp->cl_minorversion !=3D 0)
> > +	if (clp->cl_minorversion !=3D 0) {
> >  		clp->cl_cb_conn.cb_xprt =3D conn->cb_xprt;
> > +		clp->cl_cb_session =3D ses;
> > +	}
> >  	clp->cl_cb_client =3D client;
> >  	clp->cl_cb_cred =3D cred;
> >  	rcu_read_lock();
> > @@ -1299,6 +1300,7 @@ void nfsd4_probe_callback_sync(struct nfs4_client=
 *clp)
> >  {
> >  	nfsd4_probe_callback(clp);
> >  	flush_workqueue(clp->cl_callback_wq);
> > +	nfsd41_cb_inflight_wait_complete(clp);
> >  }
> >=20
> >  void nfsd4_change_callback(struct nfs4_client *clp, struct=20
> > nfs4_cb_conn *conn)
> > @@ -1679,7 +1681,17 @@ static struct nfsd4_conn *=20
> > __nfsd4_find_backchannel(struct nfs4_client *clp)
> >   * Note there isn't a lot of locking in this code; instead we depend o=
n
> >   * the fact that it is run from clp->cl_callback_wq, which won't run=
=20
> > two
> >   * work items at once.  So, for example, clp->cl_callback_wq handles=
=20
> > all
> > - * access of cl_cb_client and all calls to rpc_create or=20
> > rpc_shutdown_client.
> > + * access of cl_cb_client and cl_cb_session, and all calls to=20
> > rpc_create
> > + * or rpc_shutdown_client.
> > + *
> > + * rpciod-side readers of cl_cb_session (encode_cb_sequence4args(),
> > + * nfsd4_cb_sequence_done(), the cb-slot helpers, and the cb_sequence
> > + * tracepoints) run outside cl_callback_wq.  The
> > + * nfsd41_cb_inflight_wait_complete() drain in=20
> > nfsd4_probe_callback_sync()
> > + * waits until cl_cb_inflight reaches zero before the caller proceeds=
=20
> > with
> > + * session teardown; any rpc_task that reads cl_cb_session must hold a=
n
> > + * inflight pin (via nfsd41_cb_inflight_begin) for this fence to be
> > + * effective.
> >   */
> >  static void nfsd4_process_cb_update(struct nfsd4_callback *cb)
> >  {
> > @@ -1731,6 +1743,7 @@ static void nfsd4_process_cb_update(struct=20
> > nfsd4_callback *cb)
> >  		nfsd4_mark_cb_down(clp);
> >  		if (c)
> >  			svc_xprt_put(c->cn_xprt);
> > +		clp->cl_cb_session =3D NULL;
> >  		return;
> >  	}
> >  }
> >=20
> > --=20
> > 2.54.0
>=20
> Several NFSD callback done handlers retry indefinitely on
> NFS4ERR_DELAY via rpc_delay(), so a client that keeps
> replying DELAY leaves this per-client counter nonzero and
> blocks the foreground CREATE/BIND/DESTROY_SESSION request
> even though the callback no longer references the session
> being torn down.
>=20
> Although partly due to the way callbacks are structured
> currently, this patch potentially introduces a client-
> controlled DoS vector.
>=20

Good point. I'm currently looking at reworking this so that each stage
of the callback state machine can tolerate a NULL cl_cb_session
pointer. If I can make that work, then we can fix the UAF without
blocking.

I'll definitely be sending a v2 of the series.
--=20
Jeff Layton <jlayton@kernel.org>


Return-Path: <linux-nfs+bounces-20781-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MLMAIUyv1mkLHQgAu9opvQ
	(envelope-from <linux-nfs+bounces-20781-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Wed, 08 Apr 2026 21:41:00 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 212B83C344B
	for <lists+linux-nfs@lfdr.de>; Wed, 08 Apr 2026 21:41:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A71AB301CDB2
	for <lists+linux-nfs@lfdr.de>; Wed,  8 Apr 2026 19:40:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E81E37DE97;
	Wed,  8 Apr 2026 19:40:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Yt3X/ZzC"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09323332601;
	Wed,  8 Apr 2026 19:40:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775677245; cv=none; b=uFmBZln29TMnQy9/3XvWGXOnm+TVdKz+CbewU02kztlSEssb1TkUMMQoW9uKf81pWWNhKVS2Vv65WgjTe7wvyjxFCrU9mDu6k37gxHXt7GBR4OvVCFdJnhNXyNZS2rhiZRBGbHAvoPvs4Jw5lb6wzP7EWQf5ubv3ArGCMub4qvA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775677245; c=relaxed/simple;
	bh=Nhi7c0x5vjI8SEDj6T99wuxNb4wyr1cPq0OUVRaRSkY=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=fIEiGRhWL6Ioi/jLJeKLiHsfZ5jR8NIYTI1eFpC1BQ5//DX4MXpwUJvpaeRLo2TlG5/SivsyWnx3o12N+ico2MQ4kd+VQqp8SYp0dP50qTvPzalBMKSe8JesKLya30kv4ssiMUP3lFM1EaTkMPB/PLMaIvAO+KmP+XtaFB1+GM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Yt3X/ZzC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 953DEC19421;
	Wed,  8 Apr 2026 19:40:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775677244;
	bh=Nhi7c0x5vjI8SEDj6T99wuxNb4wyr1cPq0OUVRaRSkY=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=Yt3X/ZzC0bTUOlPprrUChyMLxwSvqAm2zkpiC3dW413/PyPRjjX539KF+Nh5em6cY
	 VRdabHh+EE9cERAD6DhjnffUF2eI85oJ3JqBlchBBSX31bRKRtPuD2IAh4pZK1yqNi
	 1MUs145ZpFzBDSJ1z23Vjlt82efLGOyyjq/SK6XM7DGuuip7MNIsp2/n+epve0eA0j
	 hMj2gK/QJiAjhus5eO0+JdVKdG3IrVwpXQ26Xl00AocLkSipyEM2aoLVTq1JLtiZO8
	 sEcz/+R2W/AymJZiXGeK4/5uojXLJAh9wsJQu6Q9O8FWqgpZ+EnJ4ULfdzFoKExTYQ
	 w6g3XZUExjf6A==
Message-ID: <2fed798124b3c3819cc20d7aa9104a55085fbe00.camel@kernel.org>
Subject: Re: [PATCH 13/24] nfsd: add notification handlers for dir events
From: Jeff Layton <jlayton@kernel.org>
To: Chuck Lever <cel@kernel.org>, Alexander Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner	 <brauner@kernel.org>, Jan Kara <jack@suse.cz>, Chuck
 Lever	 <chuck.lever@oracle.com>, Alexander Aring <alex.aring@gmail.com>,
 Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu
 <mhiramat@kernel.org>, Mathieu Desnoyers	 <mathieu.desnoyers@efficios.com>,
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan	 <skhan@linuxfoundation.org>,
 NeilBrown <neil@brown.name>, Olga Kornievskaia	 <okorniev@redhat.com>, Dai
 Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>,  Trond Myklebust
 <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>, Amir Goldstein
 <amir73il@gmail.com>
Cc: Calum Mackay <calum.mackay@oracle.com>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-nfs@vger.kernel.org
Date: Wed, 08 Apr 2026 15:40:40 -0400
In-Reply-To: <f60c8d0f-45b6-4d4e-8944-dfd69f2cf9bf@app.fastmail.com>
References: <20260407-dir-deleg-v1-0-aaf68c478abd@kernel.org>
	 <20260407-dir-deleg-v1-13-aaf68c478abd@kernel.org>
	 <f60c8d0f-45b6-4d4e-8944-dfd69f2cf9bf@app.fastmail.com>
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
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-20781-lists,linux-nfs=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[kernel.org,zeniv.linux.org.uk,suse.cz,oracle.com,gmail.com,goodmis.org,efficios.com,lwn.net,linuxfoundation.org,brown.name,redhat.com,talpey.com];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jlayton@kernel.org,linux-nfs@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	RCPT_COUNT_TWELVE(0.00)[24];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 212B83C344B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, 2026-04-08 at 14:34 -0400, Chuck Lever wrote:
>=20
> On Tue, Apr 7, 2026, at 9:21 AM, Jeff Layton wrote:
> > Add the necessary parts to accept a fsnotify callback for directory
> > change event and create a CB_NOTIFY request for it. When a dir nfsd_fil=
e
> > is created set a handle_event callback to handle the notification.
> >=20
> > Use that to allocate a nfsd_notify_event object and then hand off a
> > reference to each delegation's CB_NOTIFY. If anything fails along the
> > way, recall any affected delegations.
> >=20
> > Signed-off-by: Jeff Layton <jlayton@kernel.org>
>=20
> > diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
> > index b2b8c454fc0f..339c3d0bb575 100644
> > --- a/fs/nfsd/nfs4state.c
> > +++ b/fs/nfsd/nfs4state.c
>=20
> > @@ -9796,3 +9887,118 @@ nfsd_get_dir_deleg(struct nfsd4_compound_state=
=20
> > *cstate,
> >  	put_nfs4_file(fp);
> >  	return ERR_PTR(status);
> >  }
> > +
> > +static void
> > +nfsd4_run_cb_notify(struct nfsd4_cb_notify *ncn)
> > +{
> > +	struct nfs4_delegation *dp =3D container_of(ncn, struct=20
> > nfs4_delegation, dl_cb_notify);
> > +
> > +	if (test_and_set_bit(NFSD4_CALLBACK_RUNNING, &ncn->ncn_cb.cb_flags))
> > +		return;
> > +
> > +	if (!refcount_inc_not_zero(&dp->dl_stid.sc_count))
> > +		clear_bit(NFSD4_CALLBACK_RUNNING, &ncn->ncn_cb.cb_flags);
> > +	else
> > +		nfsd4_run_cb(&ncn->ncn_cb);
> > +}
> > +
> > +static struct nfsd_notify_event *
> > +alloc_nfsd_notify_event(u32 mask, const struct qstr *q, struct dentry=
=20
> > *dentry)
> > +{
> > +	struct nfsd_notify_event *ne;
> > +
> > +	ne =3D kmalloc(sizeof(*ne) + q->len + 1, GFP_KERNEL);
> > +	if (!ne)
> > +		return NULL;
> > +
> > +	memcpy(&ne->ne_name, q->name, q->len);
> > +	refcount_set(&ne->ne_ref, 1);
> > +	ne->ne_mask =3D mask;
> > +	ne->ne_name[q->len] =3D '\0';
> > +	ne->ne_namelen =3D q->len;
> > +	ne->ne_dentry =3D dget(dentry);
> > +	return ne;
> > +}
> > +
> > +static bool
> > +should_notify_deleg(u32 mask, struct file_lease *fl)
> > +{
> > +	/* Only nfsd leases */
> > +	if (fl->fl_lmops !=3D &nfsd_lease_mng_ops)
> > +		return false;
> > +
> > +	/* Skip if this event wasn't ignored by the lease */
> > +	if ((mask & FS_DELETE) && !(fl->c.flc_flags & FL_IGN_DIR_DELETE))
> > +		return false;
> > +	if ((mask & FS_CREATE) && !(fl->c.flc_flags & FL_IGN_DIR_CREATE))
> > +		return false;
> > +	if ((mask & FS_RENAME) && !(fl->c.flc_flags & FL_IGN_DIR_RENAME))
> > +		return false;
> > +
> > +	return true;
> > +}
>=20
> For a cross-directory rename, vfs_rename calls try_break_deleg(old_dir,
> LEASE_BREAK_DIR_DELETE, ...). A delegation with FL_IGN_DIR_DELETE
> (subscribed to NOTIFY4_REMOVE_ENTRY) suppresses the lease break, which
> is correct.
>=20
> But fsnotify delivers FS_RENAME on old_dir, not FS_DELETE. In
> should_notify_deleg(), the check (mask & FS_RENAME) &&
> !(fl->c.flc_flags & FL_IGN_DIR_RENAME) fails, because the delegation
> has FL_IGN_DIR_DELETE but not FL_IGN_DIR_RENAME. No notification is
> sent.
>=20

Actually, it delivers FS_RENAME_FROM to the old directory and
FS_RENAME_TO to the new one in this case, AFAICT. Basically, we need to
watch for those in addition to FS_CREATE/DELETE and treat them the same
way. I'm looking at a fix now. I'll also see about adding a pynfs test
to do a cross directory rename with notifications. I don't think I have
that now.

Thanks!

> IIUC, a client subscribed to NOTIFY4_REMOVE_ENTRY for old_dir sees
> neither a lease break nor a CB_NOTIFY when a child is renamed out of
> the directory. Is that behavior correct?
>=20
>=20
> > +
> > +static void
> > +nfsd_recall_all_dir_delegs(const struct inode *dir)
> > +{
> > +	struct file_lock_context *ctx =3D locks_inode_context(dir);
> > +	struct file_lock_core *flc;
> > +
> > +	spin_lock(&ctx->flc_lock);
> > +	list_for_each_entry(flc, &ctx->flc_lease, flc_list) {
> > +		struct file_lease *fl =3D container_of(flc, struct file_lease, c);
> > +
> > +		if (fl->fl_lmops =3D=3D &nfsd_lease_mng_ops)
> > +			nfsd_break_deleg_cb(fl);
> > +	}
> > +	spin_unlock(&ctx->flc_lock);
> > +}
> > +
> > +int
> > +nfsd_handle_dir_event(u32 mask, const struct inode *dir, const void=
=20
> > *data,
> > +		      int data_type, const struct qstr *name)
> > +{
> > +	struct dentry *dentry =3D fsnotify_data_dentry(data, data_type);
> > +	struct file_lock_context *ctx;
> > +	struct file_lock_core *flc;
> > +	struct nfsd_notify_event *evt;
> > +
> > +	/* Don't do anything if this is not an expected event */
> > +	if (!(mask & (FS_CREATE|FS_DELETE|FS_RENAME)))
> > +		return 0;
> > +
> > +	ctx =3D locks_inode_context(dir);
> > +	if (!ctx || list_empty(&ctx->flc_lease))
> > +		return 0;
> > +
> > +	evt =3D alloc_nfsd_notify_event(mask, name, dentry);
> > +	if (!evt) {
> > +		nfsd_recall_all_dir_delegs(dir);
> > +		return 0;
> > +	}
> > +
> > +	spin_lock(&ctx->flc_lock);
> > +	list_for_each_entry(flc, &ctx->flc_lease, flc_list) {
> > +		struct file_lease *fl =3D container_of(flc, struct file_lease, c);
> > +		struct nfs4_delegation *dp =3D flc->flc_owner;
> > +		struct nfsd4_cb_notify *ncn =3D &dp->dl_cb_notify;
> > +
> > +		if (!should_notify_deleg(mask, fl))
> > +			continue;
> > +
> > +		spin_lock(&ncn->ncn_lock);
> > +		if (ncn->ncn_evt_cnt >=3D NOTIFY4_EVENT_QUEUE_SIZE) {
> > +			/* We're generating notifications too fast. Recall. */
> > +			spin_unlock(&ncn->ncn_lock);
> > +			nfsd_break_deleg_cb(fl);
> > +			continue;
> > +		}
> > +		ncn->ncn_evt[ncn->ncn_evt_cnt++] =3D nfsd_notify_event_get(evt);
> > +		spin_unlock(&ncn->ncn_lock);
> > +
> > +		nfsd4_run_cb_notify(ncn);
> > +	}
> > +	spin_unlock(&ctx->flc_lock);
> > +	nfsd_notify_event_put(evt);
> > +	return 0;
> > +}
>=20

--=20
Jeff Layton <jlayton@kernel.org>


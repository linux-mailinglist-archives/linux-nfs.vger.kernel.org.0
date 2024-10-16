Return-Path: <linux-nfs+bounces-7207-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 545129A0D70
	for <lists+linux-nfs@lfdr.de>; Wed, 16 Oct 2024 16:55:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CDCEA1F26959
	for <lists+linux-nfs@lfdr.de>; Wed, 16 Oct 2024 14:55:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6429E20E001;
	Wed, 16 Oct 2024 14:54:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HdFVqPDZ"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C248208D95;
	Wed, 16 Oct 2024 14:54:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729090485; cv=none; b=K/HaysHcswYVWc1+vDmbN4hlQcKCMCb+poyoHlybdyHNb4WDvyGonq4UrfcNzk46843DswSMH1a5air2RKUy6B1iAUkDFNDfoBTcDEH3OCGH0+MV+c0oPh5uwuT7r76xGnCi9IRvgsHtodanP19k5JHuUXzZFpQMbulpUszTILw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729090485; c=relaxed/simple;
	bh=3BCgHcirtEbH3leNmUBYC0xGCArqCYUFgQpSEkV/Le4=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=STA2br+A3M+vokaIt0G52gjeljLM1ub7TMWIfhD1nZQft3p19GNC0fu9iNGv28opZWiwQ/79T+BRdmNuKaxY+LZVCU/jdXlVNebpUOvOUb2rpdC4WECv+3l8q0DuLpeoGIal1uAjQgQSfmLTH7fCDZYvXnG0ipw8JrS41JdXhYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HdFVqPDZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 044B5C4CEC5;
	Wed, 16 Oct 2024 14:54:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729090483;
	bh=3BCgHcirtEbH3leNmUBYC0xGCArqCYUFgQpSEkV/Le4=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=HdFVqPDZP5Kj1wIQuq9y5eThgwvA80RXU9qhQW24GoDFCHFe1FZ9VCFML+ktYqLnX
	 kHFd2Xxxd5jLVpLqUlN7Y3Bj+XdStljiEsJYiytc1X45Iqe7ucDUpRw+TKjSRd6FK1
	 dKvvpdjtjOLUTRTlqh9M+KbAkKukvm6M32Cg0tdlmtUevNdKXCA/zBULZSULQ6PoYJ
	 4GI2RV0OutiLzzsDtv9X+7GMPzB7ZeTbTDMy79T8nePVqfI6Z2KmUjjnnX7fn0vuAQ
	 q/SbzWZFiL5t6U+tX7s5sQaXpcb7F1VqBWHigjIugCm43AUSA/qSS5QTJMydevZIvc
	 K7gugRQQCQbbA==
Message-ID: <33a6cc271475b0fc520b8fc20ed0b4f7742a2560.camel@kernel.org>
Subject: Re: [RFC PATCH v1 21/57] sunrpc: Remove PAGE_SIZE compile-time
 constant assumption
From: Jeff Layton <jlayton@kernel.org>
To: Chuck Lever <chuck.lever@oracle.com>, Ryan Roberts <ryan.roberts@arm.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Anna Schumaker
 <anna@kernel.org>,  Anshuman Khandual <anshuman.khandual@arm.com>, Ard
 Biesheuvel <ardb@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>,
 David Hildenbrand <david@redhat.com>, Greg Marsden
 <greg.marsden@oracle.com>, Ivan Ivanov <ivan.ivanov@suse.com>, Kalesh Singh
 <kaleshsingh@google.com>, Marc Zyngier <maz@kernel.org>, Mark Rutland
 <mark.rutland@arm.com>, Matthias Brugger <mbrugger@suse.com>, Miroslav
 Benes <mbenes@suse.cz>, Trond Myklebust <trondmy@kernel.org>, Will Deacon
 <will@kernel.org>, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org, linux-mm@kvack.org, linux-nfs@vger.kernel.org
Date: Wed, 16 Oct 2024 10:54:40 -0400
In-Reply-To: <Zw/SE9+AMYmzBprS@tissot.1015granger.net>
References: <20241014105514.3206191-1-ryan.roberts@arm.com>
	 <20241014105912.3207374-1-ryan.roberts@arm.com>
	 <20241014105912.3207374-21-ryan.roberts@arm.com>
	 <bee3f66f-cc22-4b3e-be07-23ce4c90df20@arm.com>
	 <Zw/SE9+AMYmzBprS@tissot.1015granger.net>
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
User-Agent: Evolution 3.52.4 (3.52.4-1.fc40) 
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2024-10-16 at 10:47 -0400, Chuck Lever wrote:
> On Wed, Oct 16, 2024 at 03:42:12PM +0100, Ryan Roberts wrote:
> > + Chuck Lever, Jeff Layton
> >=20
> > This was a rather tricky series to get the recipients correct for and m=
y script
> > did not realize that "supporter" was a pseudonym for "maintainer" so yo=
u were
> > missed off the original post. Appologies!
> >=20
> > More context in cover letter:
> > https://lore.kernel.org/all/20241014105514.3206191-1-ryan.roberts@arm.c=
om/
> >=20
> >=20
> > On 14/10/2024 11:58, Ryan Roberts wrote:
> > > To prepare for supporting boot-time page size selection, refactor cod=
e
> > > to remove assumptions about PAGE_SIZE being compile-time constant. Co=
de
> > > intended to be equivalent when compile-time page size is active.
> > >=20
> > > Updated array sizes in various structs to contain enough entries for =
the
> > > smallest supported page size.
> > >=20
> > > Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
> > > ---
> > >=20
> > > ***NOTE***
> > > Any confused maintainers may want to read the cover note here for con=
text:
> > > https://lore.kernel.org/all/20241014105514.3206191-1-ryan.roberts@arm=
.com/
> > >=20
> > >  include/linux/sunrpc/svc.h      | 8 +++++---
> > >  include/linux/sunrpc/svc_rdma.h | 4 ++--
> > >  include/linux/sunrpc/svcsock.h  | 2 +-
> > >  3 files changed, 8 insertions(+), 6 deletions(-)
> > >=20
> > > diff --git a/include/linux/sunrpc/svc.h b/include/linux/sunrpc/svc.h
> > > index a7d0406b9ef59..dda44018b8f36 100644
> > > --- a/include/linux/sunrpc/svc.h
> > > +++ b/include/linux/sunrpc/svc.h
> > > @@ -160,6 +160,8 @@ extern u32 svc_max_payload(const struct svc_rqst =
*rqstp);
> > >   */
> > >  #define RPCSVC_MAXPAGES		((RPCSVC_MAXPAYLOAD+PAGE_SIZE-1)/PAGE_SIZE =
\
> > >  				+ 2 + 1)
> > > +#define RPCSVC_MAXPAGES_MAX	((RPCSVC_MAXPAYLOAD+PAGE_SIZE_MIN-1)/PAG=
E_SIZE_MIN \
> > > +				+ 2 + 1)
>=20
> There is already a "MAX" in the name, so adding this new macro seems
> superfluous to me. Can we get away with simply updating the
> "RPCSVC_MAXPAGES" macro, instead of adding this new one?
>=20

+1 that was my thinking too. This is mostly just used to size arrays,
so we might as well just change the existing macro.

With 64k pages we probably wouldn't need arrays as long as these will
be. Fixing those array sizes to be settable at runtime though is not a
trivial project though.

>=20
> > >  /*
> > >   * The context of a single thread, including the request currently b=
eing
> > > @@ -190,14 +192,14 @@ struct svc_rqst {
> > >  	struct xdr_stream	rq_res_stream;
> > >  	struct page		*rq_scratch_page;
> > >  	struct xdr_buf		rq_res;
> > > -	struct page		*rq_pages[RPCSVC_MAXPAGES + 1];
> > > +	struct page		*rq_pages[RPCSVC_MAXPAGES_MAX + 1];
> > >  	struct page *		*rq_respages;	/* points into rq_pages */
> > >  	struct page *		*rq_next_page; /* next reply page to use */
> > >  	struct page *		*rq_page_end;  /* one past the last page */
> > > =20
> > >  	struct folio_batch	rq_fbatch;
> > > -	struct kvec		rq_vec[RPCSVC_MAXPAGES]; /* generally useful.. */
> > > -	struct bio_vec		rq_bvec[RPCSVC_MAXPAGES];
> > > +	struct kvec		rq_vec[RPCSVC_MAXPAGES_MAX]; /* generally useful.. */
> > > +	struct bio_vec		rq_bvec[RPCSVC_MAXPAGES_MAX];
> > > =20
> > >  	__be32			rq_xid;		/* transmission id */
> > >  	u32			rq_prog;	/* program number */
> > > diff --git a/include/linux/sunrpc/svc_rdma.h b/include/linux/sunrpc/s=
vc_rdma.h
> > > index d33bab33099ab..7c6441e8d6f7a 100644
> > > --- a/include/linux/sunrpc/svc_rdma.h
> > > +++ b/include/linux/sunrpc/svc_rdma.h
> > > @@ -200,7 +200,7 @@ struct svc_rdma_recv_ctxt {
> > >  	struct svc_rdma_pcl	rc_reply_pcl;
> > > =20
> > >  	unsigned int		rc_page_count;
> > > -	struct page		*rc_pages[RPCSVC_MAXPAGES];
> > > +	struct page		*rc_pages[RPCSVC_MAXPAGES_MAX];
> > >  };
> > > =20
> > >  /*
> > > @@ -242,7 +242,7 @@ struct svc_rdma_send_ctxt {
> > >  	void			*sc_xprt_buf;
> > >  	int			sc_page_count;
> > >  	int			sc_cur_sge_no;
> > > -	struct page		*sc_pages[RPCSVC_MAXPAGES];
> > > +	struct page		*sc_pages[RPCSVC_MAXPAGES_MAX];
> > >  	struct ib_sge		sc_sges[];
> > >  };
> > > =20
> > > diff --git a/include/linux/sunrpc/svcsock.h b/include/linux/sunrpc/sv=
csock.h
> > > index 7c78ec6356b92..6c6bcc82685a3 100644
> > > --- a/include/linux/sunrpc/svcsock.h
> > > +++ b/include/linux/sunrpc/svcsock.h
> > > @@ -40,7 +40,7 @@ struct svc_sock {
> > > =20
> > >  	struct completion	sk_handshake_done;
> > > =20
> > > -	struct page *		sk_pages[RPCSVC_MAXPAGES];	/* received data */
> > > +	struct page *		sk_pages[RPCSVC_MAXPAGES_MAX];	/* received data */
> > >  };
> > > =20
> > >  static inline u32 svc_sock_reclen(struct svc_sock *svsk)
> >=20
>=20

--=20
Jeff Layton <jlayton@kernel.org>


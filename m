Return-Path: <linux-nfs+bounces-4932-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 360A9931952
	for <lists+linux-nfs@lfdr.de>; Mon, 15 Jul 2024 19:30:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 963F41F21EAE
	for <lists+linux-nfs@lfdr.de>; Mon, 15 Jul 2024 17:30:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 670C1487A7;
	Mon, 15 Jul 2024 17:29:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jT5WVxfy"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 428C4481AA
	for <linux-nfs@vger.kernel.org>; Mon, 15 Jul 2024 17:29:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721064561; cv=none; b=DoBU0xV5Ur8iNOWz8l5xqxrvc3gnxSs32ZtLX/D7vWaNBJ/4j5CI0bJgC/LLkQJlKQzfhNGe96AuOxrp/taVxbsFlYgwpwT5WKf/vgC5xKAbEtAnrKtsNeTgolNxHpeBcmJhhmhDas+M7/itZ34nf5BpN44CTgJ1PjfoHx6j1OQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721064561; c=relaxed/simple;
	bh=tJ8mmPgLbKYtzPRz7mC72tOjK+XMrULLgPs2rmhmnrc=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=G6yW8fIbBnIEw05ztbrDB5oshzUMi4HDqN3hy7Vht7eepO15dRLSlNLEBh6Hcnh3HfozGyXteI4zjxXjazuqRgZSYTQ76IypMK1vaGy5slH8dRjjoYVq1UFwFSwId97XseINFyL05A9oAlb00/fQNl1+ImnePa6BnLkhac5R6T0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jT5WVxfy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 236E4C32782;
	Mon, 15 Jul 2024 17:29:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721064560;
	bh=tJ8mmPgLbKYtzPRz7mC72tOjK+XMrULLgPs2rmhmnrc=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=jT5WVxfyP2F4HSqkECX52rfjzx7D/bavRPlTqEL7osl/dLeZhic6MGeLcO53Hc8Ov
	 kHwcgZgfjy6FcpqTwjxIbKdL2YnN9WtC+QakBSsbjDmr/PaaOPH/FFDKDgtfSZ9Ldz
	 YcUw9uNwTBfAoIVE1gDekG8Kz+KO/54nLGDfm9U6UaSSGPLwebJKwm7ZuMKrUljyRR
	 d1T+JC/tq1YGNsTM3PJl8htPf19adrmm/l+Q5f42qiatKoix+9hKLG0TpWz9NOwk+i
	 GRhjOnmaCUFO5hak2jYUK7Zbn6MZ2BAD0moayV06r16cvrT1YXETc53ivHhmRiV1uI
	 77TOgvJyj0zmw==
Message-ID: <ca50839f334e4898a2da19c2d129ecdf24e0540b.camel@kernel.org>
Subject: Re: [PATCH 00/14 RFC] support automatic changes to nfsd thread count
From: Jeff Layton <jlayton@kernel.org>
To: NeilBrown <neilb@suse.de>, Chuck Lever <chuck.lever@oracle.com>
Cc: linux-nfs@vger.kernel.org, Olga Kornievskaia <kolga@netapp.com>, Dai Ngo
	 <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>, Steve Dickson
	 <steved@redhat.com>
Date: Mon, 15 Jul 2024 13:29:18 -0400
In-Reply-To: <20240715074657.18174-1-neilb@suse.de>
References: <20240715074657.18174-1-neilb@suse.de>
Autocrypt: addr=jlayton@kernel.org; prefer-encrypt=mutual;
 keydata=mQINBE6V0TwBEADXhJg7s8wFDwBMEvn0qyhAnzFLTOCHooMZyx7XO7dAiIhDSi7G1NPxwn8jdFUQMCR/GlpozMFlSFiZXiObE7sef9rTtM68ukUyZM4pJ9l0KjQNgDJ6Fr342Htkjxu/kFV1WvegyjnSsFt7EGoDjdKqr1TS9syJYFjagYtvWk/UfHlW09X+jOh4vYtfX7iYSx/NfqV3W1D7EDi0PqVT2h6v8i8YqsATFPwO4nuiTmL6I40ZofxVd+9wdRI4Db8yUNA4ZSP2nqLcLtFjClYRBoJvRWvsv4lm0OX6MYPtv76hka8lW4mnRmZqqx3UtfHX/hF/zH24Gj7A6sYKYLCU3YrI2Ogiu7/ksKcl7goQjpvtVYrOOI5VGLHge0awt7bhMCTM9KAfPc+xL/ZxAMVWd3NCk5SamL2cE99UWgtvNOIYU8m6EjTLhsj8snVluJH0/RcxEeFbnSaswVChNSGa7mXJrTR22lRL6ZPjdMgS2Km90haWPRc8Wolcz07Y2se0xpGVLEQcDEsvv5IMmeMe1/qLZ6NaVkNuL3WOXvxaVT9USW1+/SGipO2IpKJjeDZfehlB/kpfF24+RrK+seQfCBYyUE8QJpvTZyfUHNYldXlrjO6n5MdOempLqWpfOmcGkwnyNRBR46g/jf8KnPRwXs509yAqDB6sELZH+yWr9LQZEwARAQABtCBKZWZmIExheXRvbiA8amxheXRvbkBrZXJuZWwub3JnPokCOAQTAQIAIgUCWe8u6AIbAwYLCQgHAwIGFQgCCQoLBBYCAwECHgECF4AACgkQAA5oQRlWghUuCg/+Lb/xGxZD2Q1oJVAE37uW308UpVSD2tAMJUvFTdDbfe3zKlPDTuVsyNsALBGclPLagJ5ZTP+Vp2irAN9uwBuacBOTtmOdz4ZN2tdvNgozzuxp4CHBDVzAslUi2idy+xpsp47DWPxYFIRP3M8QG/aNW052LaPc0cedY
	xp8+9eiVUNpxF4SiU4i9JDfX/sn9XcfoVZIxMpCRE750zvJvcCUz9HojsrMQ1NFc7MFT1z3MOW2/RlzPcog7xvR5ENPH19ojRDCHqumUHRry+RF0lH00clzX/W8OrQJZtoBPXv9ahka/Vp7kEulcBJr1cH5Wz/WprhsIM7U9pse1f1gYy9YbXtWctUz8uvDR7shsQxAhX3qO7DilMtuGo1v97I/Kx4gXQ52syh/w6EBny71CZrOgD6kJwPVVAaM1LRC28muq91WCFhs/nzHozpbzcheyGtMUI2Ao4K6mnY+3zIuXPygZMFr9KXE6fF7HzKxKuZMJOaEZCiDOq0anx6FmOzs5E6Jqdpo/mtI8beK+BE7Va6ni7YrQlnT0i3vaTVMTiCThbqsB20VrbMjlhpf8lfK1XVNbRq/R7GZ9zHESlsa35ha60yd/j3pu5hT2xyy8krV8vGhHvnJ1XRMJBAB/UYb6FyC7S+mQZIQXVeAA+smfTT0tDrisj1U5x6ZB9b3nBg65ke5Ag0ETpXRPAEQAJkVmzCmF+IEenf9a2nZRXMluJohnfl2wCMmw5qNzyk0f+mYuTwTCpw7BE2H0yXk4ZfAuA+xdj14K0A1Dj52j/fKRuDqoNAhQe0b6ipo85Sz98G+XnmQOMeFVp5G1Z7r/QP/nus3mXvtFsu9lLSjMA0cam2NLDt7vx3l9kUYlQBhyIE7/DkKg+3fdqRg7qJoMHNcODtQY+n3hMyaVpplJ/l0DdQDbRSZi5AzDM3DWZEShhuP6/E2LN4O3xWnZukEiz688d1ppl7vBZO9wBql6Ft9Og74diZrTN6lXGGjEWRvO55h6ijMsLCLNDRAVehPhZvSlPldtUuvhZLAjdWpwmzbRIwgoQcO51aWeKthpcpj8feDdKdlVjvJO9fgFD5kqZQiErRVPpB7VzA/pYV5Mdy7GMbPjmO0IpoL0tVZ8JvUzUZXB3ErS/dJflvboAAQeLpLCkQjqZiQ/D
	CmgJCrBJst9Xc7YsKKS379Tc3GU33HNSpaOxs2NwfzoesyjKU+P35czvXWTtj7KVVSj3SgzzFk+gLx8y2Nvt9iESdZ1Ustv8tipDsGcvIZ43MQwqU9YbLg8k4V9ch+Mo8SE+C0jyZYDCE2ZGf3OztvtSYMsTnF6/luzVyej1AFVYjKHORzNoTwdHUeC+9/07GO0bMYTPXYvJ/vxBFm3oniXyhgb5FtABEBAAGJAh8EGAECAAkFAk6V0TwCGwwACgkQAA5oQRlWghXhZRAAyycZ2DDyXh2bMYvI8uHgCbeXfL3QCvcw2XoZTH2l2umPiTzrCsDJhgwZfG9BDyOHaYhPasd5qgrUBtjjUiNKjVM+Cx1DnieR0dZWafnqGv682avPblfi70XXr2juRE/fSZoZkyZhm+nsLuIcXTnzY4D572JGrpRMTpNpGmitBdh1l/9O7Fb64uLOtA5Qj5jcHHOjL0DZpjmFWYKlSAHmURHrE8M0qRryQXvlhoQxlJR4nvQrjOPMsqWD5F9mcRyowOzr8amasLv43w92rD2nHoBK6rbFE/qC7AAjABEsZq8+TQmueN0maIXUQu7TBzejsEbV0i29z+kkrjU2NmK5pcxgAtehVxpZJ14LqmN6E0suTtzjNT1eMoqOPrMSx+6vOCIuvJ/MVYnQgHhjtPPnU86mebTY5Loy9YfJAC2EVpxtcCbx2KiwErTndEyWL+GL53LuScUD7tW8vYbGIp4RlnUgPLbqpgssq2gwYO9m75FGuKuB2+2bCGajqalid5nzeq9v7cYLLRgArJfOIBWZrHy2m0C+pFu9DSuV6SNr2dvMQUv1V58h0FaSOxHVQnJdnoHn13g/CKKvyg2EMrMt/EfcXgvDwQbnG9we4xJiWOIOcsvrWcB6C6lWBDA+In7w7SXnnokkZWuOsJdJQdmwlWC5L5ln9xgfr/4mOY38B0U=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.4 (3.50.4-1.fc39) 
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2024-07-15 at 17:14 +1000, NeilBrown wrote:
> This patch set (against nfsd-next) enables automatic adjustment of the
> number of nfsd threads.=C2=A0 The number can increase under high load, an=
d
> reduce after idle periods.
>=20
> The first few patches (1-6) are cleanups that may not be entirely
> relevant to the current series.=C2=A0 They could safely land any time and
> only need minimal review.
>=20
> Patch 9,10,11 remove some places were sv_nrthreads are used for things
> other than counting threads.=C2=A0 It is use to adjust other limits.=C2=
=A0 At the
> time this seemed like an easy and sensible solution.=C2=A0 I now have to
> repent of that short-cut and find a better way to impose reasonable
> limits.
>=20
> These and the other sundry patches (7,8,12) can, I think safely land
> whenever that get sufficient review.=C2=A0 I think they are sensible even=
 if
> we won't end up adjusting threads dynamically.
>=20
> Patches 13 and 14 build on all this to provide the desired
> functionality.=C2=A0 Patch 13 allows the maximum to be configured, and pa=
tch
> 14 starts or stops threads based on some simple triggers.
>=20
> For 13 I decided that if the user/admin makes no explicit configuration,
> then the currently request number of threads becomes a minimum, and a
> maximum is determined based on the amount of memory.=C2=A0 This will make
> the patch set immediately useful but shouldn't unduly impact existing
> configurations.
>=20
> For patch 14 I only implemented starting a thread when there is work to
> do but no threads to do it, and stopping a thread when it has been idle
> for 5 seconds.=C2=A0 The start-up is deliberately serialised so at least =
one
> NFS request is serviced between the decision to start a thread and the
> action of starting it.=C2=A0 This hopefully encourages a ramping up of th=
read
> count rather than a sudden jump.
>=20
> There is certain room for discussion around the wisdom of these
> heuristics, and what other heuristics are needed - we probably want a
> shrinker to impose memory pressure of the number of threads.=C2=A0 We
> probably want a thread to exit rather than retry when a memory
> allocation in svc_alloc_arg() fails.
>=20
> I certainly wouldn't recommend patch 14 landing in any hurry at all.
>=20
> I'd love to hear what y'all think, and what experiences you have when
> testing it.
>=20
>=20

This looks mostly reasonable, modulo a few nits on the later patches.
You can add my Reviewed-by to 1-9. 10-12 others look tentatively OK
too, but I'm less familiar with the slot handling code, and it sounds
like you're going to rework that part anyway.

For 13 I have some ideas about how we should present this from a user
interface standpoint that I wrote in my reply. The heuristics you came
up with in 14 look like a fine place to start.

Cheers!
--=20
Jeff Layton <jlayton@kernel.org>


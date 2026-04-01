Return-Path: <linux-nfs+bounces-20582-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6BSDAiEhzWlWaQYAu9opvQ
	(envelope-from <linux-nfs+bounces-20582-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Wed, 01 Apr 2026 15:44:01 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DCF037B6F1
	for <lists+linux-nfs@lfdr.de>; Wed, 01 Apr 2026 15:44:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AFC6D30A5592
	for <lists+linux-nfs@lfdr.de>; Wed,  1 Apr 2026 13:08:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A6EF3DE427;
	Wed,  1 Apr 2026 13:08:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="i2RBDZI0"
X-Original-To: linux-nfs@vger.kernel.org
Received: from master.debian.org (master.debian.org [82.195.75.110])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8400736D500;
	Wed,  1 Apr 2026 13:08:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.110
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775048891; cv=none; b=TDBibcs8wnxuIQYb+qHOpXq/i5G8kBUZBdmXEcAHAjMpkDo4M71fSHfcD7HDszPjRCfhtIeiDSaHB7V/C8/rsfcqlWAxNH46sU9qLGV0XRqnzAC0XroggtC9faMM32Gk6KL2QPCk7tR1D1F831rGe+kg5Dab22xMWYpn+XJVbXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775048891; c=relaxed/simple;
	bh=VygY8rwnP9T9H1mSKfEPncnRPrYOnaytGeQvMY1NKg8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UpZ8wnj948Ftv2g6oLOpRb0A3Y30Sf6iHoWMIPH8wq6wfCyaYyPWAp+F4uL3t6f2PFTtGlf4oakJBDAb7DoBIBSfPss4UqUkd68iy0ZIiyTvhC+EbLMuCWGBTNElyzsJkgxPaZJHRrQ7YPS09Kbj+cTtWvaq0f3tYobk+VohHYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=none smtp.mailfrom=master.debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=i2RBDZI0; arc=none smtp.client-ip=82.195.75.110
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=master.debian.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.master; h=In-Reply-To:Content-Type:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description;
	bh=VygY8rwnP9T9H1mSKfEPncnRPrYOnaytGeQvMY1NKg8=; b=i2RBDZI0m+o/IAcGynYeDm4kT+
	S8+86EuTKLWBFAHE6QYCDhXuB+1O+vr1vElGJ7oH3M8zBS8ixnrYxmFe1Uf2KPllRAgTHKGTA74Zs
	+zipOqKbfPGq/+AatbhGNkYumiDaID9U9aHSvr4Dc3uMilp3sVrZCrXM7tQFwDrwByXWIT4y6ee8a
	faoZOYGzcHhv5g51uLOUao4UYQqZBG8m9G1t6NSkpXkkmGgI1rdQCMenl0dtUl6nSS1Ji+0I4jnZE
	6jyWHBL2YXKN0aK72K3C4dlzLgdN9hLFgAZEpb/oxG4GnHMtNRyWkXWgXzQXAjmVdq14+1dtgA9Rx
	RaKsBjWg==;
Received: from ukleinek by master.debian.org with local (Exim 4.96)
	(envelope-from <ukleinek@master.debian.org>)
	id 1w7v5P-007TLX-1X;
	Wed, 01 Apr 2026 12:54:19 +0000
Date: Wed, 1 Apr 2026 14:54:18 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@debian.org>
To: Chuck Lever <cel@kernel.org>, 1128861@bugs.debian.org
Cc: NeilBrown <neil@brown.name>, Jeff Layton <jlayton@kernel.org>, 
	Thorsten Leemhuis <regressions@leemhuis.info>, Tj <tj.iam.tj@proton.me>, linux-nfs@vger.kernel.org, 
	Olga Kornievskaia <okorniev@redhat.com>, stable@vger.kernel.org
Subject: Re: Bug#1128861: [PATCH v2] lockd: fix TEST handling when not all
 permissions are available.
Message-ID: <ac0U4P92l-TkQvnh@monoceros>
References: <177266540127.7472.3460090956713656639@noble.neil.brown.name>
 <6ba41798-9c69-44f5-9a4e-09336c75a4b9@leemhuis.info>
 <cf78feb7ffaee6ed478afb734d2ede149597de86.camel@kernel.org>
 <177434721528.7102.13514118512738778346@noble.neil.brown.name>
 <d4773958-5ae5-42d4-b785-6598b5c9b27a@app.fastmail.com>
 <177442248735.2237155.773724155681455344@noble.neil.brown.name>
 <a6e6a731-2885-4510-87dd-45e6a8f4fbd7@app.fastmail.com>
 <177456522377.1851489.16395975485525163031@noble.neil.brown.name>
 <177187492815.425331.14320091315652332093.reportbug@nimble>
 <465012d6-c824-4d8d-b6f6-8a2d85e30154@app.fastmail.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="mjowkry23wizm7jm"
Content-Disposition: inline
In-Reply-To: <465012d6-c824-4d8d-b6f6-8a2d85e30154@app.fastmail.com>
X-Spamd-Result: default: False [-3.26 / 15.00];
	SIGNED_PGP(-2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_DKIM_ALLOW(-0.20)[debian.org:s=smtpauto.master];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	DMARC_NA(0.00)[debian.org];
	TAGGED_FROM(0.00)[bounces-20582-lists,linux-nfs=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[debian.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ukleinek@debian.org,linux-nfs@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-nfs];
	RCPT_COUNT_SEVEN(0.00)[9];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 9DCF037B6F1
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


--mjowkry23wizm7jm
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Subject: Re: Bug#1128861: [PATCH v2] lockd: fix TEST handling when not all
 permissions are available.
MIME-Version: 1.0

Hello Chuck,

On Fri, Mar 27, 2026 at 09:56:38AM -0400, Chuck Lever wrote:
> I think the stable folks will insist on this fix going into
> upstream first. However, this version of the fix does not
> apply to nfsd-testing because that branch has the NLMv4
> xdrgen rewrite.

This is not the first time a bug is fixed by changes that are too
intrusive for backport. Usually the stable maintainers can be talked to
accept a small targeted fix even if it's not upstream. The discussion is
simplified by people claiming to have tested the fix and confirm it
helps.

Best regards
Uwe

--mjowkry23wizm7jm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmnNFXgACgkQj4D7WH0S
/k45NQgAquCg6aNkirXvxO8Gk61oQk0FgWK0VGoMPJ2eoPaOhTLPMkXd49pxrA7E
R7xSAaVjHpDD5VSqla8ELxlLNvs139Zy7BumYr3k5IRt9/WFxiSQ09zoL+iYG2TY
eSlBpiOuPSMcMPy+O26kR3yDMKU59htjmFWiLEkY9mjShyVWVRAhJwVnVuSgZKXB
yRbVwL79yaj+kcibI0+CjSMbH47qFyZHp+NC0yu/uMs39otVoQzdmuVgNLqXLkeS
VqxQBcmqgR5IXZQf1lDV2OEsU7bWeF5ObUJUOolgq0QGs5Ta/bU/TPeaBY233buB
O2isMv95+ZclT598QNxC0gmZlqLqiw==
=iwjP
-----END PGP SIGNATURE-----

--mjowkry23wizm7jm--


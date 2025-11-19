Return-Path: <linux-nfs+bounces-16584-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 15EF8C71208
	for <lists+linux-nfs@lfdr.de>; Wed, 19 Nov 2025 22:15:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by tor.lore.kernel.org (Postfix) with ESMTPS id D465828EAA
	for <lists+linux-nfs@lfdr.de>; Wed, 19 Nov 2025 21:15:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5260F21CC47;
	Wed, 19 Nov 2025 21:15:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=permerror (0-bit key) header.d=josefsson.org header.i=@josefsson.org header.b="DZm2fwOC";
	dkim=temperror (0-bit key) header.d=josefsson.org header.i=@josefsson.org header.b="hWnKnpfN"
X-Original-To: linux-nfs@vger.kernel.org
Received: from uggla.sjd.se (uggla.sjd.se [178.174.241.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BB231E51EB;
	Wed, 19 Nov 2025 21:15:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.174.241.107
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763586948; cv=none; b=ceqAWE24HNECLAQ61AJqP9hott7kWjcjR5naolyVpcpmq7uCru73zyTzHoelxTuvBWxI2Mv0dvKymJ6uZGRFl+WSk09Uik5UNO5Vl74oFuqbATsXa0irH7dobn0GlglvV2XjBK1YXlVqJlo0+TmPlUvM9UzX0NRXNrFOXoy3d0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763586948; c=relaxed/simple;
	bh=GIr4vRAAS1PLeNG+QkQOZ7UvqLM0gVWU0sbKhNT32S8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=F6EoixBHCafzVYN0QWcIhqQ0HP7o8xsF/naIZEyqPD0E4V93ZmovNKyrUn2/dBx6Vf5DArMO7dWFJVEVfB3vg8Fh+FWVDwc9lV2+2reAX4O7YlsPyd6/brkTeI5pO67D5ejs+dad/4nEivvJv2XDtorK40GFn0z+3WfVCV9ZxZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=josefsson.org; spf=pass smtp.mailfrom=josefsson.org; dkim=permerror (0-bit key) header.d=josefsson.org header.i=@josefsson.org header.b=DZm2fwOC; dkim=temperror (0-bit key) header.d=josefsson.org header.i=@josefsson.org header.b=hWnKnpfN; arc=none smtp.client-ip=178.174.241.107
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=josefsson.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=josefsson.org
DKIM-Signature: v=1; a=ed25519-sha256; q=dns/txt; c=relaxed/relaxed;
	d=josefsson.org; s=ed2303; h=Content-Type:MIME-Version:Message-ID:Date:
	References:In-Reply-To:Subject:Cc:To:From:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=B+Swd9IW3Ur70d4A0fUsNwU2I4T+3RUbUfGRWxlZvNk=; t=1763586936; x=1764796536; 
	b=DZm2fwOCF8DPXdLP8ZfYqNHFKGsVUb0Q6jXsqlGfV1KgHWokUyrmC0pLVOalB7dflPqLiOTwkb0
	nJ6p+LhI8Cw==;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=josefsson.org; s=rsa2303; h=Content-Type:MIME-Version:Message-ID:Date:
	References:In-Reply-To:Subject:Cc:To:From:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=B+Swd9IW3Ur70d4A0fUsNwU2I4T+3RUbUfGRWxlZvNk=; t=1763586936; x=1764796536; 
	b=hWnKnpfN/34Jzs3WKWIqBbfBCnENVqQSPiXhgDrGWRO9evpPZwMwyx6peqkjWOrpK8AptYIhOwE
	bnxgeEkuRTCQEyqgVaS1ok8ji1tg81GJkU5bUwcBOXzceohI+VMZbn4FTGhL/C1Q2QPVUAkWWJMHN
	I/8oXXOw37v9TCxy2KJKrFybg4yQuKMeUJvw8eHbMqecPoxZD6Ii42gsYRNTJNXKo/pNtxa68WG89
	ykBklCxKHNRprHnzqjcn88ySDUkElfnkIJecQuPHgi5HKjBNNgY+dqQZCF+5IddXhuH76eRiCLjh5
	Dbs2c2piNG9HSa1heNu0S6njWI+b8t6S8Y+w0pLAAZdKyeHaVUygMaLJqOAaEZbufIcBztOSnLz8H
	xG3S2jHk46vKvewYhmjCFPL2bsr3zvp8HADWyOxaHwWHQNbcKQN9XcHix8uJLjXQLDUBrRgcj;
Received: from [2001:9b1:41ac:ff00:4544:2a2d:5da8:7fae] (port=54284 helo=kaka)
	by uggla.sjd.se with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.95)
	(envelope-from <simon@josefsson.org>)
	id 1vLpDw-008nl9-Ui;
	Wed, 19 Nov 2025 20:56:21 +0000
From: Simon Josefsson <simon@josefsson.org>
To: Salvatore Bonaccorso <carnil@debian.org>
Cc: "Tyler W. Ross" <TWR@tylerwross.com>,  Scott Mayhew
 <smayhew@redhat.com>,  Trond Myklebust <trondmy@kernel.org>,  Chuck Lever
 <chuck.lever@oracle.com>,  Anna Schumaker <anna@kernel.org>,
  "1120598@bugs.debian.org" <1120598@bugs.debian.org>,  Jeff Layton
 <jlayton@kernel.org>,  NeilBrown <neil@brown.name>,  Steve Dickson
 <steved@redhat.com>,  Olga Kornievskaia <okorniev@redhat.com>,  Dai Ngo
 <Dai.Ngo@oracle.com>,  Tom Talpey <tom@talpey.com>,
  linux-nfs@vger.kernel.org,  linux-kernel@vger.kernel.org
Subject: Re: ls input/output error ("NFS: readdir(/) returns -5") on krb5
 NFSv4 client using SHA2
In-Reply-To: <aR1MiaZYVc4kR8Yf@eldamar.lan> (Salvatore Bonaccorso's message of
	"Wed, 19 Nov 2025 05:50:17 +0100")
References: <aRZL8kbmfbssOwKF@eldamar.lan>
	<fVv3cF7Ulh3cKUP17C98gh_uOv9BcMlMpsIh1Nv5_0tdw-75PKiPJgIEP5o2jBVry7orwz7jeiGQenfCbuUxyj5JFstbx3RTFYr223qDmV0=@tylerwross.com>
	<a6d1435b-f507-49eb-b80c-4322dc7e1157@oracle.com>
	<Y79HV0VGpScPYqI_dDxeItkX2UZwSdReaUOpIeMeZXq2HLsHf5J_PTQqr7HrBYygICRsn-OB89QPrxPzjgv2smuzTThUPy_3fq_N1NprlUg=@tylerwross.com>
	<4a63ad3d-b53a-4eab-8ffb-dd206f52c20e@oracle.com>
	<902ff4995d8e75ad1cd2196bf7d8da42932fba35.camel@kernel.org>
	<aRunktdq8sJ7Eecj@aion>
	<db8b1ef4-afbb-4c23-b7f1-9ae688cef363@TylerWRoss.com>
	<aRyyWy6hO1ueKf5_@aion>
	<85cd9202-dc22-41b8-8a20-e82cd118215f@TylerWRoss.com>
	<aR1MiaZYVc4kR8Yf@eldamar.lan>
OpenPGP: id=B1D2BD1375BECB784CF4F8C4D73CF638C53C06BE;
 url=https://josefsson.org/key-20190320.txt
X-Hashcash: 1:23:251119:smayhew@redhat.com::FNOVbgLI6PxeA/En:h3H
X-Hashcash: 1:23:251119:neil@brown.name::6XDduMDcNU+G7B6H:3SlT
X-Hashcash: 1:23:251119:dai.ngo@oracle.com::Nkv+UhdnkwoRHzeA:6flR
X-Hashcash: 1:23:251119:carnil@debian.org::VJ51ojdR4pzekZvA:8oEJ
X-Hashcash: 1:23:251119:1120598@bugs.debian.org::Q1zArJXh8NI87x/O:3G7V
X-Hashcash: 1:23:251119:trondmy@kernel.org::qH0UajHQRMd8Nw+v:9WBc
X-Hashcash: 1:23:251119:steved@redhat.com::mISrfmJvQ9joaRrY:D0o7
X-Hashcash: 1:23:251119:anna@kernel.org::Oxq/2qySBAICMaax:BNVg
X-Hashcash: 1:23:251119:twr@tylerwross.com::WcNRGQw/b4rF5Eui:ExLv
X-Hashcash: 1:23:251119:tom@talpey.com::wpk0SFKHD5VO9APM:Ii6l
X-Hashcash: 1:23:251119:chuck.lever@oracle.com::FSCNwBW1aiEAxJTl:9uCO
X-Hashcash: 1:23:251119:okorniev@redhat.com::JlJjqr9jkXq7jFo3:Xf2u
X-Hashcash: 1:23:251119:jlayton@kernel.org::PFl2/V6siTm5OrOR:dTD6
X-Hashcash: 1:23:251119:linux-kernel@vger.kernel.org::S6xmp5A1+YrOLo/B:01vxb
X-Hashcash: 1:23:251119:linux-nfs@vger.kernel.org::beGq0C3eaV5QWACU:1ps6n
Date: Wed, 19 Nov 2025 21:54:42 +0100
Message-ID: <87zf8hhhf1.fsf@josefsson.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha256; protocol="application/pgp-signature"

--=-=-=
Content-Type: text/plain

Salvatore Bonaccorso <carnil@debian.org> writes:

> I'm looping in here the gssproxy maintainer as well. Simon, this is
> about https://bugs.debian.org/1120598 . I assume there is nothing on
> gssroxy side which can be done to warn about the situation, quoting
> again:
>
>> The actual issue at hand then seems to be that gssproxy is requesting (and
>> receiving) a service ticket with an unusable (for the NFS mount) enctype,
>> when performing constrained delegation/S4U2Proxy.
>
> ?

It isn't clear to me if the gssproxy behaviour is buggy or just
sub-optimal, but it seems like gssproxy upstream could develop some
patch to make the enctypes match.  I'm not sure if that is generally a
safe thing, even if it would fix the problem.  Anyway, I think this
looks definitely beyond any Debian-specific concern about gssproxy so I
think some upstream recommendation is needed here, and I don't have a
working NFSv4 gss setup available to debug this.

/Simon

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQNoBAEWCAMQFiEEo8ychwudMQq61M8vUXIrCP5HRaIFAmkeLpIUHHNpbW9uQGpv
c2Vmc3Nvbi5vcmfCHCYAmDMEXJLOtBYJKwYBBAHaRw8BAQdACIcrZIvhrxDBkK9f
V+QlTmXxo2naObDuGtw58YaxlOu0JVNpbW9uIEpvc2Vmc3NvbiA8c2ltb25Aam9z
ZWZzc29uLm9yZz6IlgQTFggAPgIbAwULCQgHAgYVCAkKCwIEFgIDAQIeAQIXgBYh
BLHSvRN1vst4TPT4xNc89jjFPAa+BQJn0XQkBQkNZGbwAAoJENc89jjFPAa+BtIA
/iR73CfBurG9y8pASh3cbGOMHpDZfMAtosu6jbpO69GHAP4p7l57d+iVty2VQMsx
+3TCSAvZkpr4P/FuTzZ8JZe8BrgzBFySz4EWCSsGAQQB2kcPAQEHQOxTCIOaeXAx
I2hIX4HK9bQTpNVei708oNr1Klm8qCGKiPUEGBYIACYCGwIWIQSx0r0Tdb7LeEz0
+MTXPPY4xTwGvgUCZ9F0SgUJDWRmSQCBdiAEGRYIAB0WIQSjzJyHC50xCrrUzy9R
cisI/kdFogUCXJLPgQAKCRBRcisI/kdFoqdMAQCgH45aseZgIrwKOvUOA9QfsmeE
8GZHYNuFHmM9FEQS6AD6A4x5aYvoY6lo98pgtw2HPDhmcCXFItjXCrV4A0GmJA4J
ENc89jjFPAa+wUUBAO64fbZek6FPlRK0DrlWsrjCXuLi6PUxyzCAY6lG2nhUAQC6
qobB9mkZlZ0qihy1x4JRtflqFcqqT9n7iUZkCDIiDbg4BFySz2oSCisGAQQBl1UB
BQEBB0AxlRumDW6nZY7A+VCfek9VpEx6PJmdJyYPt3lNHMd6HAMBCAeIfgQYFggA
JgIbDBYhBLHSvRN1vst4TPT4xNc89jjFPAa+BQJn0XTSBQkNZGboAAoJENc89jjF
PAa+0M0BAPPRq73kLnHYNDMniVBOzUdi2XeF32idjEWWfjvyIJUOAP4wZ+ALxIeh
is3Uw2BzGZE6ttXQ2Q+DeCJO3TPpIqaXDAAKCRBRcisI/kdForoiAP43U7TSUdfe
r2VnOefzgRorLcwk+b2DfRZ+Nq9VEv2/wQEAmrZbYfdt2eJGAqfAVEkQbbHgolb1
rroSP3CheBFq2gE=
=tJ2r
-----END PGP SIGNATURE-----
--=-=-=--


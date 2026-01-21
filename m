Return-Path: <linux-nfs+bounces-18274-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oLkHCM9VcWkNEwAAu9opvQ
	(envelope-from <linux-nfs+bounces-18274-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Wed, 21 Jan 2026 23:40:15 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B4DC5EF4D
	for <lists+linux-nfs@lfdr.de>; Wed, 21 Jan 2026 23:40:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C6AEB8897DE
	for <lists+linux-nfs@lfdr.de>; Wed, 21 Jan 2026 22:39:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E407144A722;
	Wed, 21 Jan 2026 22:38:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b="UT6E2AvY";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="CPihRHW3"
X-Original-To: linux-nfs@vger.kernel.org
Received: from fout-b7-smtp.messagingengine.com (fout-b7-smtp.messagingengine.com [202.12.124.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B199441048
	for <linux-nfs@vger.kernel.org>; Wed, 21 Jan 2026 22:38:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769035136; cv=none; b=QoZj/dUbVSgNuGGOsc4tmTBA69hukK1MJsSesSZiCGfuACAE4Cnnpye+ht44AybvxaO8atsZwENbegdztEbg4nn9Ni9S2qJ28EWBNWe8z9yMtYNGbiTF3fTUalrd4m1bmN2NOO8vbHZ9WQouCfgNJVqLqYjzLMzFTLkX5E/kR8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769035136; c=relaxed/simple;
	bh=h/pEE4irDqXdXxxsbuYx4XmHfNQ9yj/IJxWP4Z0JEqA=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=JOSpivRQZrFqBeDZv0LEGMD/p0g3GlFmGBEbf35CPSaUdQz5ubG8rLV8fiN2ePguQ4v0mEDBius2ck2LXdkySIS1/R/84V1R97g5vw88PPlmLvy9HKsC9jkEM4ZZqLeVrupn2+neHiDPZ6FjK++IPujAbBORlyuW/MNEzGXsylc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=UT6E2AvY; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=CPihRHW3; arc=none smtp.client-ip=202.12.124.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.stl.internal (Postfix) with ESMTP id 4567F1D00067;
	Wed, 21 Jan 2026 17:38:53 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Wed, 21 Jan 2026 17:38:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to; s=fm2; t=
	1769035133; x=1769121533; bh=1SUuuTIqK1vvdl78p1pJsNvgydrEktkaNJA
	GxWtEUNM=; b=UT6E2AvYKUe9J2GUXzz+09hxSjdYeOaQ7CJ/O68n6cXqW9+U/tT
	e3t4dEqCvrIXekjcN5oqlr+2Wxx2yOMAnazSqVUIZUqBWNVOxLLL+ZikVbHTSjRp
	Q3BQ+B6fSUhThUl5aT3pcG3PafmgSOQ/pGupnLOfLYAivvTKjRCt+o7oVFLSXA0F
	K8tQiFSjz9rkGa/0gfhUqZJ/xo/dpMCCh2jeeDU13l9iyUk0XW5AnEQlQNQ+xW1o
	vZkmJaKWujyt2Uh/yKt08pnM03XyX0wrnZn/otMnaBPP1sBPMc1mrKfVk6n6QI5e
	YrAzOOYVgMnLAdMW/em3NgkZDD3YiXVtN5A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1769035133; x=
	1769121533; bh=1SUuuTIqK1vvdl78p1pJsNvgydrEktkaNJAGxWtEUNM=; b=C
	PihRHW3cd56l9MAxt8ry2NqarRM99AdpJGHpEW+GZXobKqLhaprVHJ5T2Jr0OEdL
	Euq3ol9rTyNVn5Iwt4GvktV7g/NQODw/GtFvApiAxG1TrqcKEiYX7mNcED6+F4M6
	OxIiZ5tMq+bDOdBBojO959vPNzVZZehGxTE1hkC6uN1iOPtp5X7iFVQ+8QCNHFR1
	y+sXMbFdwY7dOeu1iYOTokiqbLF6EcDUnuophzIFaxjcUa3KykSaCF1UpvDySZWh
	oNih41ZlxNMEcmZwrg6CCC34w3oLOYMKoI/hecNeyb3csTOIzz3yXW3sZACvx/BX
	nGn7EInogPIB3dbZvXhDQ==
X-ME-Sender: <xms:fFVxaSk7UtURhKP8Vam1PrwfVh0Lm2fVdEGQDijn3jDyFg47dNOpxQ>
    <xme:fFVxaQvtIuhkgatiCdyzkdGKulNr5ywkWHvnvnC-zmWk3fxxy_fdsOd3ZLK96zx6z
    1sazA7gv0izDtGtmwd0G_sFMBUPZsjtV5XfTsnDqv7K359xCw>
X-ME-Received: <xmr:fFVxaY9iDetzWkNBnH4QrIMdXHTQreT5HR-AVZQ8MLC6lfylkCWmzRGf0j7Rzw5lW0ZXiXpxV0VQcDsFdR6hZBVLNoEr0z9y-AxlA9GBDhTa>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddugeeghedtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurheptgfgggfhvfevufgjfhffkfhrsehtqhertddttdejnecuhfhrohhmpefpvghilheu
    rhhofihnuceonhgvihhlsgesohifnhhmrghilhdrnhgvtheqnecuggftrfgrthhtvghrnh
    epleejtdefgeeukeeiteduveehudevfeffvedutefgteduhfegvdfgtdeigeeuudejnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepnhgvihhlsg
    esohifnhhmrghilhdrnhgvthdpnhgspghrtghpthhtohephedpmhhouggvpehsmhhtphho
    uhhtpdhrtghpthhtoheplhhinhhugidqnhhfshesvhhgvghrrdhkvghrnhgvlhdrohhrgh
    dprhgtphhtthhopehsthgvvhgvugesrhgvughhrghtrdgtohhmpdhrtghpthhtoheptghh
    uhgtkhdrlhgvvhgvrhesohhrrggtlhgvrdgtohhmpdhrtghpthhtohepjhhlrgihthhonh
    eskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepsggtohguughinhhgsehhrghmmhgvrhhs
    phgrtggvrdgtohhm
X-ME-Proxy: <xmx:fFVxaSObtH7wcF2A6o9g04QWth2Dcah4J7kvP7NqQtMRxQum4QaJOA>
    <xmx:fFVxaeE8ocmLUhgDXDjfjC-NUBdap4IM26M3CU5uFcXs7984I27cNA>
    <xmx:fFVxaYRrwfeBMiOWnfd0r2e3HL-bM1d-arbv0v76mHinGGGNjpNJIw>
    <xmx:fFVxaTun3C8LomVFPmHzepexdj1X8UT83l1i3aU_9CL0ArPUxTyoAw>
    <xmx:fVVxaSN4jFVTl-p_frQ7DUktY6564SdIJCUVgcvkvDGqsKhWgoQELJwF>
Feedback-ID: iab3e480c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 21 Jan 2026 17:38:50 -0500 (EST)
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: NeilBrown <neilb@ownmail.net>
To: "Benjamin Coddington" <bcodding@hammerspace.com>
Cc: "Steve Dickson" <steved@redhat.com>, linux-nfs@vger.kernel.org,
 "Chuck Lever" <chuck.lever@oracle.com>, "Jeff Layton" <jlayton@kernel.org>
Subject: Re: [PATCH v1 1/2] nfsdctl/rpc.nfsd: Add support for passing
 encrypted filehandle key
In-reply-to: <3EB8A763-21AF-44E3-8D22-030C6DC62A8B@hammerspace.com>
References: <cover.1768586942.git.bcodding@hammerspace.com>, =?utf-8?q?=3C90?=
 =?utf-8?q?fad47b2b34117ae30373569a5e5a87ef63cec7=2E1768586942=2Egit=2Ebcodd?=
 =?utf-8?q?ing=40hammerspace=2Ecom=3E=2C?=
 <176868679725.16766.14739276568986177664@noble.neil.brown.name>,
 <8328B53F-21DE-4237-AF79-5DE88D53D8B9@hammerspace.com>,
 <176877755694.16766.8795981876133751749@noble.neil.brown.name>,
 <3EB8A763-21AF-44E3-8D22-030C6DC62A8B@hammerspace.com>
Date: Thu, 22 Jan 2026 09:38:49 +1100
Message-id: <176903512916.16766.9732522324635199948@noble.neil.brown.name>
Reply-To: NeilBrown <neil@brown.name>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.96 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[ownmail.net:s=fm2,messagingengine.com:s=fm2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DMARC_POLICY_ALLOW(0.00)[ownmail.net,none];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	FREEMAIL_FROM(0.00)[ownmail.net];
	TAGGED_FROM(0.00)[bounces-18274-lists,linux-nfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[ownmail.net:+,messagingengine.com:+];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[brown.name:replyto,dfw.mirrors.kernel.org:helo,dfw.mirrors.kernel.org:rdns,ownmail.net:dkim,messagingengine.com:dkim,hammerspace.com:email,noble.neil.brown.name:mid];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	FROM_NEQ_ENVFROM(0.00)[neilb@ownmail.net,linux-nfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:7979, ipnet:2605:f480::/32, country:US];
	HAS_REPLYTO(0.00)[neil@brown.name]
X-Rspamd-Queue-Id: 7B4DC5EF4D
X-Rspamd-Action: no action

On Thu, 22 Jan 2026, Benjamin Coddington wrote:
> On 18 Jan 2026, at 18:05, NeilBrown wrote:
>=20
> > On Mon, 19 Jan 2026, Benjamin Coddington wrote:
> >> On 17 Jan 2026, at 16:53, NeilBrown wrote:
> >>
> >>> On Sat, 17 Jan 2026, Benjamin Coddington wrote:
> >>>> If fh-key-file=3D<path> is set in nfs.conf, the "nfsdctl autostart" co=
mmand
> >>>
> >>> ... is set in THE NFSD SECTION OF nfs.conf
> >>>
> >>>
> >>>> will hash the contents of the file with libuuid's uuid_generate_sha1 a=
nd
> >>>> send the first 16 bytes into the kernel via NFSD_CMD_FH_KEY_SET.
> >>>
> >>> This patch adds no code that uses uuid_generate_sha1(), and doesn't
> >>> provide any code for hash_fh_key_file()...
> >>
> >> I forgot to add the hash function after moving it into libnfs to make it
> >> available to both rpc.nfsd and nfsdctl -- here it is, will fix on v2:
> >>
> >> diff --git a/support/nfs/fh_key_file.c b/support/nfs/fh_key_file.c
> >> new file mode 100644
> >> index 000000000000..350d36bf8649
> >> --- /dev/null
> >> +++ b/support/nfs/fh_key_file.c
> >> @@ -0,0 +1,83 @@
> >> +/*
> >> + * Copyright (c) 2025 Benjamin Coddington <bcodding@hammerspace.com>
> >> + * All rights reserved.
> >> + *
> >> + * Redistribution and use in source and binary forms, with or without
> >> + * modification, are permitted provided that the following conditions
> >> + * are met:
> >> + * 1. Redistributions of source code must retain the above copyright
> >> + *    notice, this list of conditions and the following disclaimer.
> >> + * 2. Redistributions in binary form must reproduce the above copyright
> >> + *    notice, this list of conditions and the following disclaimer in t=
he
> >> + *    documentation and/or other materials provided with the distributi=
on.
> >> + *
> >> + * THIS SOFTWARE IS PROVIDED BY THE AUTHOR ``AS IS'' AND ANY EXPRESS OR
> >> + * IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRA=
NTIES
> >> + * OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIM=
ED.
> >> + * IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR ANY DIRECT, INDIRECT,
> >> + * INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING,=
 BUT
> >> + * NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF=
 USE,
> >> + * DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY
> >> + * THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
> >> + * (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE US=
E OF
> >> + * THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
> >> + */
> >
> > I wonder if it is time to stop putting this boilerplate in nfs-utils and
> > start using SPDX like the kernel does.
> >
> >> +
> >> +#include <sys/types.h>
> >> +#include <unistd.h>
> >> +#include <errno.h>
> >> +#include <uuid/uuid.h>
> >> +
> >> +#include "nfslib.h"
> >> +
> >> +#define HASH_BLOCKSIZE  256
> >> +int hash_fh_key_file(const char *fh_key_file, uuid_t uuid)
> >> +{
> >> +	const char seed_s[] =3D "8fc57f1b-1a6f-482f-af92-d2e007c1ae58";
> >> +	FILE *sfile =3D NULL;
> >> +	char *buf =3D malloc(HASH_BLOCKSIZE);
> >
> > Can this be
> >    char buf[HASH_BLOCKSIZE];
> > ??
> >
> >> +	size_t pos;
> >> +	int ret =3D 0;
> >> +
> >> +	if (!buf)
> >> +		goto out;
> >> +
> >> +	sfile =3D fopen(fh_key_file, "r");
> >> +	if (!sfile) {
> >> +		ret =3D errno;
> >> +		xlog(L_ERROR, "Unable to read fh-key-file %s: %s", fh_key_file, strer=
ror(errno));
> >> +		goto out;
> >> +	}
> >> +
> >> +	uuid_parse(seed_s, uuid);
> >> +	while (1) {
> >> +		size_t sread;
> >> +		pos =3D 0;
> >> +
> >> +		while (1) {
> >> +			if (feof(sfile))
> >> +				goto finish_block;
> >> +
> >> +			sread =3D fread(buf + pos, 1, HASH_BLOCKSIZE - pos, sfile);
> >> +			pos +=3D sread;
> >> +
> >> +			if (pos =3D=3D HASH_BLOCKSIZE)
> >> +				break;
> >> +
> >> +			if (sread =3D=3D 0) {
> >> +				if (ferror(sfile))
> >> +					goto out;
> >> +				goto finish_block;
> >> +			}
> >> +		}
> >
> > I think this inner look is not needed or wanted.
> > fread() will loop as needed until EOF or an error, and we don't want to
> > continue on an error.
>=20
> The fh_key_file can be any length - and this function reads it in
> HASH_BLOCKSIZE chunks.  Each chuck gets hashed against the previous result.

Yes, so the outer loop is clearly needed.
The inner loop will never execute more than once as fread() only returns
short reads on EOF or error.

>=20
> That said, there is a bug where ferror(sfile) never gets assigned to "ret",
> fixing that..

Thanks.

NeilBrown

>=20
> Ben
>=20



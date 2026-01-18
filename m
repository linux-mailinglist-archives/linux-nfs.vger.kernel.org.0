Return-Path: <linux-nfs+bounces-18087-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C2CB2D39B11
	for <lists+linux-nfs@lfdr.de>; Mon, 19 Jan 2026 00:06:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 918A13000EA0
	for <lists+linux-nfs@lfdr.de>; Sun, 18 Jan 2026 23:06:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 225E6311C14;
	Sun, 18 Jan 2026 23:06:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b="eoMCsM81";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Qb3ZK/kw"
X-Original-To: linux-nfs@vger.kernel.org
Received: from fout-a2-smtp.messagingengine.com (fout-a2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BE0C311C09
	for <linux-nfs@vger.kernel.org>; Sun, 18 Jan 2026 23:06:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768777565; cv=none; b=hs4iGGPHbw8fovnz423EelZ4mgPHY6IduTJY8444Sv2aOHWtkDa/FGzDGMIyhBpkzwRbHL34C6SDIEQcSltq8PIALNxzRVoYLoIuS6tUaPtGtkTB9MrbEimX3nfVj26Fyw/iyE6F0hySAX8XIG40hT/Op/cN2WghrxXB1de2bSw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768777565; c=relaxed/simple;
	bh=YHRrSnl4FoYZbjOyqKLHE7h0KGGxWZE+tSuPN9z9jL4=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=qacUxRi9bx0fjIG87eRTch2dbGExcTIfie00iO9ttR4C5RSUTRTporkmILi38Ce6mi9jSWHJuTIKj+L/Xr8bXLZeqpCSNaSVDAupY2Ssuh/4XpNvaAHCL0G0Xe5tqy894tac7B+zNEy+x64cg5Th9zWIvemSfp9WlhlS6VJAbWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=eoMCsM81; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Qb3ZK/kw; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfout.phl.internal (Postfix) with ESMTP id E1726EC0552;
	Sun, 18 Jan 2026 18:06:00 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-10.internal (MEProxy); Sun, 18 Jan 2026 18:06:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to; s=fm2; t=
	1768777560; x=1768863960; bh=tIeoQtgrj/YkBKsaMFaem/1Mq86nHKgsjiF
	nn00H7BU=; b=eoMCsM81sbXgZVPLyK64hTb/uMjn1HDFVY7oMhSdIphe+sZ+1u7
	UkuJ5smYxbTGZq9Q2xSOs+HTQkeZDYO5WSyPz2W/eRvrLN8kRVA5msO3TkphRnyR
	N33gmoff2lb36qClPxSym5sxjM9OAB1JShkgpZT+4uwdorKzOn6HN19iyX4b8XFi
	RYW+G0VX78CpWKZWjnGsMh09OgKVc4gaqwAKgn8yu1eWrXvA2P1iNTgFujPmiOr1
	AdoZmyy29Pt1JZ0wnNqllba6IHP4g/b/e5xKAPrdDKPYuGAmSWixK8LkM/uByHgj
	adqzEzDfqy5wpoozTGH71MYbhLFvaL333yg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1768777560; x=
	1768863960; bh=tIeoQtgrj/YkBKsaMFaem/1Mq86nHKgsjiFnn00H7BU=; b=Q
	b3ZK/kwNJAw+kZWfAxMuFX7VVZ9quucSW/DhLPCeN3mf9oJ2+L9eUtfNxVGi8Ktf
	dC0Dml6OOOpXuPpqE4MMTJeCS3Nsx0aedHL2EAMvDB3rkzqxbkQZHhHK2EtS3aDn
	wS7i9D7eZUIfd4Motgc2Q00QvAJg345W/VVtXLDJ6HKosQd243TfrQXAtshXZ6u6
	ghlgUNBaWGLKUTfyu/8wBOWssEJI1j1ovJUXHpZ18NMWhfN7eyMx7zrxAKJKaFSW
	z6zru66DRX7o84cgA3JKKoloFiZ9P/SfpWVisS+jaNWgY7isT2/GuwNewxF63vnJ
	BZrtf/nBIFWs51fI9VVkg==
X-ME-Sender: <xms:WGdtaTajWvtC6cUDWEcRCGQGmX6t9gGGUJ8dtYblMEY3MQ5cBjVnLg>
    <xme:WGdtaZToLtmsbp5IXoo6lmcIKI_s9IucA-r4w7efEOcgYbg3iI5fapLTg1NVO2YDG
    zmyO9XV0YtJVeOkH-VB2AK5mJPiCW0e0QEcYgy7Xd1_6TzSRw>
X-ME-Received: <xmr:WGdtaeSRcAE9y7CfUl-lFsEgag5ruNfrISlYPqwgrTmOAvXD4n8WTwleXEFwMfuGKFIg32teU9DSavpVZiZ1A5dywEHAFUJ85fxv-cxet-rS>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddufeehleejucetufdoteggodetrf
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
X-ME-Proxy: <xmx:WGdtaVQg0ns4xsOOtjfc-CoqcIF5HB3k2F0ic_VslFmD9gUjtIo0Eg>
    <xmx:WGdtab74CFyj0kS-z2VillG-bPxaBy1ovhrKQiYj08WvP4G76axARw>
    <xmx:WGdtaZ32cFbrgC7ismBsLoXd0usXW3OSmPQ9_6XCQeWA1NCuUSljSw>
    <xmx:WGdtaeBWnyD_kf8Mwvy9ud0nz2BW-hnexikUu_RYzpZQTMzLKwfrAQ>
    <xmx:WGdtaZ5VYeiTkNSqCrCm07BDs7bNVRubHqGNFmHZnNtyJU0RaM4ylI1_>
Feedback-ID: iab3e480c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 18 Jan 2026 18:05:58 -0500 (EST)
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
In-reply-to: <8328B53F-21DE-4237-AF79-5DE88D53D8B9@hammerspace.com>
References: <cover.1768586942.git.bcodding@hammerspace.com>, =?utf-8?q?=3C90?=
 =?utf-8?q?fad47b2b34117ae30373569a5e5a87ef63cec7=2E1768586942=2Egit=2Ebcodd?=
 =?utf-8?q?ing=40hammerspace=2Ecom=3E=2C?=
 <176868679725.16766.14739276568986177664@noble.neil.brown.name>,
 <8328B53F-21DE-4237-AF79-5DE88D53D8B9@hammerspace.com>
Date: Mon, 19 Jan 2026 10:05:56 +1100
Message-id: <176877755694.16766.8795981876133751749@noble.neil.brown.name>
Reply-To: NeilBrown <neil@brown.name>

On Mon, 19 Jan 2026, Benjamin Coddington wrote:
> On 17 Jan 2026, at 16:53, NeilBrown wrote:
>=20
> > On Sat, 17 Jan 2026, Benjamin Coddington wrote:
> >> If fh-key-file=3D<path> is set in nfs.conf, the "nfsdctl autostart" comm=
and
> >
> > ... is set in THE NFSD SECTION OF nfs.conf
> >
> >
> >> will hash the contents of the file with libuuid's uuid_generate_sha1 and
> >> send the first 16 bytes into the kernel via NFSD_CMD_FH_KEY_SET.
> >
> > This patch adds no code that uses uuid_generate_sha1(), and doesn't
> > provide any code for hash_fh_key_file()...
>=20
> I forgot to add the hash function after moving it into libnfs to make it
> available to both rpc.nfsd and nfsdctl -- here it is, will fix on v2:
>=20
> diff --git a/support/nfs/fh_key_file.c b/support/nfs/fh_key_file.c
> new file mode 100644
> index 000000000000..350d36bf8649
> --- /dev/null
> +++ b/support/nfs/fh_key_file.c
> @@ -0,0 +1,83 @@
> +/*
> + * Copyright (c) 2025 Benjamin Coddington <bcodding@hammerspace.com>
> + * All rights reserved.
> + *
> + * Redistribution and use in source and binary forms, with or without
> + * modification, are permitted provided that the following conditions
> + * are met:
> + * 1. Redistributions of source code must retain the above copyright
> + *    notice, this list of conditions and the following disclaimer.
> + * 2. Redistributions in binary form must reproduce the above copyright
> + *    notice, this list of conditions and the following disclaimer in the
> + *    documentation and/or other materials provided with the distribution.
> + *
> + * THIS SOFTWARE IS PROVIDED BY THE AUTHOR ``AS IS'' AND ANY EXPRESS OR
> + * IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTI=
ES
> + * OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED.
> + * IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR ANY DIRECT, INDIRECT,
> + * INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT
> + * NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF US=
E,
> + * DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY
> + * THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
> + * (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF
> + * THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
> + */

I wonder if it is time to stop putting this boilerplate in nfs-utils and
start using SPDX like the kernel does.

> +
> +#include <sys/types.h>
> +#include <unistd.h>
> +#include <errno.h>
> +#include <uuid/uuid.h>
> +
> +#include "nfslib.h"
> +
> +#define HASH_BLOCKSIZE  256
> +int hash_fh_key_file(const char *fh_key_file, uuid_t uuid)
> +{
> +	const char seed_s[] =3D "8fc57f1b-1a6f-482f-af92-d2e007c1ae58";
> +	FILE *sfile =3D NULL;
> +	char *buf =3D malloc(HASH_BLOCKSIZE);

Can this be=20
   char buf[HASH_BLOCKSIZE];
??

> +	size_t pos;
> +	int ret =3D 0;
> +
> +	if (!buf)
> +		goto out;
> +
> +	sfile =3D fopen(fh_key_file, "r");
> +	if (!sfile) {
> +		ret =3D errno;
> +		xlog(L_ERROR, "Unable to read fh-key-file %s: %s", fh_key_file, strerror=
(errno));
> +		goto out;
> +	}
> +
> +	uuid_parse(seed_s, uuid);
> +	while (1) {
> +		size_t sread;
> +		pos =3D 0;
> +
> +		while (1) {
> +			if (feof(sfile))
> +				goto finish_block;
> +
> +			sread =3D fread(buf + pos, 1, HASH_BLOCKSIZE - pos, sfile);
> +			pos +=3D sread;
> +
> +			if (pos =3D=3D HASH_BLOCKSIZE)
> +				break;
> +
> +			if (sread =3D=3D 0) {
> +				if (ferror(sfile))
> +					goto out;
> +				goto finish_block;
> +			}
> +		}

I think this inner look is not needed or wanted.
fread() will loop as needed until EOF or an error, and we don't want to
continue on an error.

> +		uuid_generate_sha1(uuid, uuid, buf, HASH_BLOCKSIZE);
> +	}
> +finish_block:
> +	if (pos)
> +		uuid_generate_sha1(uuid, uuid, buf, pos);
> +out:
> +	if (sfile)
> +		fclose(sfile);
> +	free(buf);
> +	return ret;
> +}
>=20

Thanks,
NeilBrown


Return-Path: <linux-nfs+bounces-1964-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E70A856B58
	for <lists+linux-nfs@lfdr.de>; Thu, 15 Feb 2024 18:41:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DE029B2424B
	for <lists+linux-nfs@lfdr.de>; Thu, 15 Feb 2024 17:41:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B0BF13667A;
	Thu, 15 Feb 2024 17:41:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=earthlink.net header.i=@earthlink.net header.b="iHqrQlrB"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mta-101a.earthlink-vadesecure.net (mta-101b.earthlink-vadesecure.net [51.81.61.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D497136995
	for <linux-nfs@vger.kernel.org>; Thu, 15 Feb 2024 17:41:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=51.81.61.61
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708018886; cv=none; b=LtayPfJpe2ti60VvqITUwziDnas2SFV97bedVHx3CGOJhwf9yRT+23X2CC3kiQDHvFZ/0OAFXiVDsttWNomqf5HZuV2TF30VIej7i1mS8YHfDI48gzemhSCgXXJedw8zfQ2olEyDxUCLr2VyIbncC7tJnv2Q6sqS4snp/ofhl2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708018886; c=relaxed/simple;
	bh=3BglWeHrci/yxhZAoLxt57yBSoavWshFZO5bwD/tLLU=;
	h=From:To:Cc:References:In-Reply-To:Subject:Date:Message-ID:
	 MIME-Version:Content-Type; b=ok3Ud2YlkX0En3vEEeZszGq+IKgVnMSMo2EHWyOmvKe6VDCwUP8lI3H8agZBVo/MhozprsilDEMsEBXJsTj2BW+4WvOuv3g+u4ZtTwEqb6z5xUknOFmVbC/3FTh9WbvxS4CbnWKJmksEQq2473GxcSQvbvjdQ0xlaCDYl4UFV/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mindspring.com; spf=pass smtp.mailfrom=mindspring.com; dkim=pass (2048-bit key) header.d=earthlink.net header.i=@earthlink.net header.b=iHqrQlrB; arc=none smtp.client-ip=51.81.61.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mindspring.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mindspring.com
DKIM-Signature: v=1; a=rsa-sha256; bh=3BglWeHrci/yxhZAoLxt57yBSoavWshFZO5bwD
 /tLLU=; c=relaxed/relaxed; d=earthlink.net; h=from:reply-to:subject:
 date:to:cc:resent-date:resent-from:resent-to:resent-cc:in-reply-to:
 references:list-id:list-help:list-unsubscribe:list-subscribe:list-post:
 list-owner:list-archive; q=dns/txt; s=dk12062016; t=1708017956;
 x=1708622756; b=iHqrQlrBp6C0EMrX82EIXeqZV7aglGFkvNdNddC0INwjvyN2Swikucj
 tZEOuENFDQCo9l/2+ZeXfWbNnH7Bap6PVgqV3aKtx/Le4sxRMiflLzkOwZZRAV1I0pU1M9X
 L0RwC2505N1ofUsgF5B8QegjTxWkaX0aWN7HpyPpr2Asg3l8jJsQLkwqmzLT8jq4gj2a2Ot
 1JAEkK85bDwuBkXHeOpUspYLt/0SO7UJQYQgw8AFaLTL9V2hWS+Cx0koqKTv+OQPguI4f0m
 gr8DwrAP98RUeqXJHjAlz1CDQM6QM0sWqc1AgdW+tBsrx1+J2bvs3TPgDiAkVohZjATI8pX
 l5A==
Authentication-Results: earthlink-vadesecure.net;
 auth=pass smtp.auth=ffilzlnx@mindspring.com smtp.mailfrom=ffilzlnx@mindspring.com;
Received: from FRANKSTHINKPAD ([174.174.49.201])
 by vsel1nmtao01p.internal.vadesecure.com with ngmta
 id 8aa18a2e-17b419481230242b; Thu, 15 Feb 2024 17:25:56 +0000
From: "Frank Filz" <ffilzlnx@mindspring.com>
To: "'Cedric Blancher'" <cedric.blancher@gmail.com>,
	"'Trond Myklebust'" <trondmy@hammerspace.com>
Cc: <jlayton@kernel.org>,
	<dan.f.shelton@gmail.com>,
	<tom@talpey.com>,
	<linux-nfs@vger.kernel.org>
References: <CAAvCNcBvWjt13mBGoNZf-BGwn18_R6KAeMmA7NZOTifORLEANg@mail.gmail.com> <CAAvCNcAkZFkLU-XtmJy30AT7ad_MvSzZTMEk86PiZXLdcMg4fA@mail.gmail.com> <b14648b0-a2f7-451a-a56b-6bb626c4ffa8@talpey.com> <14e1e8c8613c74d07cb0cefbcebbf79a3a57311e.camel@kernel.org> <CAAvCNcAsow-QTPYLm0fUNX3K5X4Aci=aFi+hi4a0S8k19oa-KA@mail.gmail.com> <3fa863dc2c1ec75416704a9cdaa17bf1a2e447e4.camel@hammerspace.com> <CALXu0UfuKEa8u-dz9aG8K--ULBe2yaZoYbEoR3Tyr2NG6a1_Rw@mail.gmail.com>
In-Reply-To: <CALXu0UfuKEa8u-dz9aG8K--ULBe2yaZoYbEoR3Tyr2NG6a1_Rw@mail.gmail.com>
Subject: RE: Public NFSv4 handle?
Date: Thu, 15 Feb 2024 09:25:56 -0800
Message-ID: <013f01da6034$0995a960$1cc0fc20$@mindspring.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 15.0
Content-Language: en-us
Thread-Index: AQFFDhjPWnhj6LNoGjIaUcmmZbCZKQG7Czk6Ak0SvGUA9wP+KgJURJGOAXdWb5IBde+k47HkPvcQ

> From: Cedric Blancher [mailto:cedric.blancher@gmail.com]
> On Tue, 13 Feb 2024 at 21:59, Trond Myklebust =
<trondmy@hammerspace.com>
> wrote:
> >
> > On Tue, 2024-02-13 at 21:28 +0100, Dan Shelton wrote:
> > > [You don't often get email from dan.f.shelton@gmail.com. Learn why
> > > this is important at https://aka.ms/LearnAboutSenderIdentification =
]
> > >
> > > On Fri, 9 Feb 2024 at 16:32, Jeff Layton <jlayton@kernel.org> =
wrote:
> > > >
> > > > On Thu, 2024-02-08 at 21:37 -0500, Tom Talpey wrote:
> > > > > On 2/8/2024 7:19 PM, Dan Shelton wrote:
> > > > > > ?
> > > > > >
> > > > > > On Thu, 25 Jan 2024 at 02:48, Dan Shelton
> > > > > > <dan.f.shelton@gmail.com> wrote:
> > > > > > >
> > > > > > > Hello!
> > > > > > >
> > > > > > > Do the Linux NFSv4 server and client support the NFS =
public
> > > > > > > handle?
> > > > >
> > > > > Are you referring the the old WebNFS stuff? That was a v2/v3
> > > > > thing, and, I believe, only ever supported by Solaris.
> > > > >
> > > >
> > > > One more try! I think my MUA was having issues this morning.
> > > >
> > > > NFSv4.1 supports the PUTPUBFH op:
> > > >
> > > > =
https://www.rfc-editor.org/rfc/rfc8881.html#name-operation-23-putp
> > > > ubfh-set-p
> > > >
> > > > ...but this op is only for backward compatibility. The Linux
> > > > server returns the rootfh (as it SHOULD).
> > >
> > > No, I do not consider this "backward compatibility". The "public"
> > > option is also intended for public servers, like package mirrors
> > > (e.g.
> > > Debian), to have a better solution than http or ftp.
> > >
> >
> > PUTPUBFH offers no extra security features over PUTROOTFH. It is
> > literally just a way to offer a second point of entry into the same
> > exported filesystem.

Do any clients even provide a mechanism to mount using PUTPUBFH?

> Right. It doesn't expose your "private" filesystem hierarchy.

There are ways to avoid exposing the private filesystem hierarchy. I =
have used bind mounts in the past and some servers may allow specifying =
the pseudo path for exports to hide the filesystem hierarchy.

> > A more modern approach would be to create 2 containers on the same
> > host: one that shares the full namespace to be exported, and one =
that
> > shares only the bits of the namespace that are considered "public".
> > That approach requires no extra patches or customisation to existing
> > kernels.
>=20
> Oh for god's sake. Please don't call "containers" a "modern approach".
> It's just a sad waste of resources, aside from the other shitload of =
problems they
> cause.
> Also in real life, we frog-eating backwards savages here in Europe do =
not have
> so many public IPv4 addresses available to put everything into =
containers, and
> changing everything to IPv6-only networks will take another 2 or 3 =
decades
> here.

There are ways to do it without containers, though a container gives an =
additional level of security.

> Cedric Blancher <cedric.blancher@gmail.com>
> [https://plus.google.com/u/0/+CedricBlancher/]
> Institute Pasteur

Frank Filz




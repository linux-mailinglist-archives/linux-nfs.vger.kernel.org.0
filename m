Return-Path: <linux-nfs+bounces-8408-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 769DA9E7C81
	for <lists+linux-nfs@lfdr.de>; Sat,  7 Dec 2024 00:33:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1551D1884180
	for <lists+linux-nfs@lfdr.de>; Fri,  6 Dec 2024 23:33:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 828C41AAA24;
	Fri,  6 Dec 2024 23:33:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nrubsig.org header.i=@nrubsig.org header.b="oqFwylK7"
X-Original-To: linux-nfs@vger.kernel.org
Received: from dwarf.ash.relay.mailchannels.net (dwarf.ash.relay.mailchannels.net [23.83.222.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D44FE19ABC6
	for <linux-nfs@vger.kernel.org>; Fri,  6 Dec 2024 23:33:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=23.83.222.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733528031; cv=fail; b=mou1qQYQxlrISoZxEeuZr095Qjv1IkcpEjJEfG3OuB9azXjR4ELn6HvTuRND687uHYk1a/HvZzf3TYVmgTP26HKjIYJ8r7pWHjiFvZA0qpp1bFCGmUER5AbaJKykV8RTHWUtMsKNAvr0gXyIo+62Q+np+GMnRPGC1c/8A6CjdEc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733528031; c=relaxed/simple;
	bh=wl7H0RMEzrPXoc8Tl0euJFcd4XtGbA45Qc8xZt0BGN4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=eHoDJ62+Fj/cKCY/20Gi39Tgj9C90P/mbq0R4rwD5Q8wK3KWsniGPyd9/ALtEZL+050n3h7GxmxJIw8LQvHWl+9EVtQwX5nCTwMx9/2o2PK4pfbL+vKZkMfOX3EAPr5M/4dKK9K2OkKcHziUha/M1I/jLYOkFD/YCa7V6spoFzA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nrubsig.org; spf=pass smtp.mailfrom=nrubsig.org; dkim=pass (2048-bit key) header.d=nrubsig.org header.i=@nrubsig.org header.b=oqFwylK7; arc=fail smtp.client-ip=23.83.222.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nrubsig.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nrubsig.org
X-Sender-Id: dreamhost|x-authsender|gisburn@nrubsig.org
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id C194F82263C
	for <linux-nfs@vger.kernel.org>; Fri,  6 Dec 2024 23:33:41 +0000 (UTC)
Received: from pdx1-sub0-mail-a267.dreamhost.com (100-125-212-232.trex-nlb.outbound.svc.cluster.local [100.125.212.232])
	(Authenticated sender: dreamhost)
	by relay.mailchannels.net (Postfix) with ESMTPA id 66E27822D0B
	for <linux-nfs@vger.kernel.org>; Fri,  6 Dec 2024 23:33:41 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1733528021; a=rsa-sha256;
	cv=none;
	b=WG/2+exGZMNU1PgDf44UzwOZpcXfQb7OfGV5KewaV9w7Oe5agwTd7SDMuiGwWcOMDIgB/x
	yCuzajsFNiqIMFR7CrObph6KVxh/QkQyUrYs1cqSa+EkNOuch2DGUUSqHdwlR4BEiyXX1f
	cqEGJdmgSilnNTGqLxBKeAEOW6iVDC4mYZ0RM6o/RPMZXt/ZCKJu5vP6znN30RQYGAC/AZ
	d+YAbQfP/MLgU15z5HUKtcyuudp/htQSS1LCVoMwiNQb6pNznt0aPiRI+TFlDZ0rV/6x1C
	gw9kZQ2U0ZClMFoNM46TJs3gxCYZ5AHbyL+2aQ5P9or/ZeOs/MQzEJVEu0Q9DQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
	s=arc-2022; t=1733528021;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=k/R0g8v4nrpjKBrckWIqHSHyZ7ELgud30YUWhqX8x3A=;
	b=xGCodCiMYkIB7bHWxoR5ZY9FgSNJaBS/JP2IJ+YpQhAGBrpdfqawh5b7XrOcISm1sRYGSM
	m4bkAiGFSec+Bi5ZCDgY+dAS7VAjCaxlaBCxzE4ZPGGo90SljSS6+vUkQ705SWY5XKlms3
	UTvTdbquiNTqHYW6lnUQXOdCharqAVThMHwctkgGM10txOlbpdWexPwFBZMw76z+yuD6KI
	++j/9cF37RZQh9gtabBrjyHzACibZcQx4KW4ThWJ4dXf6XR5geoUH62x7+6FsonAIoX/6v
	wS2kBK8cZYXeS90QbEStxkofhtLSnsIPnWmGJaI3cKJgAPF1trl/mXvDyrT/Ig==
ARC-Authentication-Results: i=1;
	rspamd-fc7fd4597-pwqk4;
	auth=pass smtp.auth=dreamhost smtp.mailfrom=roland.mainz@nrubsig.org
X-Sender-Id: dreamhost|x-authsender|gisburn@nrubsig.org
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|gisburn@nrubsig.org
X-MailChannels-Auth-Id: dreamhost
X-Eight-Thoughtful: 5badc5a416983337_1733528021631_1009820469
X-MC-Loop-Signature: 1733528021631:1243333856
X-MC-Ingress-Time: 1733528021631
Received: from pdx1-sub0-mail-a267.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.125.212.232 (trex/7.0.2);
	Fri, 06 Dec 2024 23:33:41 +0000
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: gisburn@nrubsig.org)
	by pdx1-sub0-mail-a267.dreamhost.com (Postfix) with ESMTPSA id 4Y4ndK1yZJz3h
	for <linux-nfs@vger.kernel.org>; Fri,  6 Dec 2024 15:33:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nrubsig.org;
	s=dreamhost; t=1733528021;
	bh=eOul/lnauvZk0FiRZ714dm0MrPVUpZYr9iqbFs4tn20=;
	h=From:Date:Subject:To:Content-Type:Content-Transfer-Encoding;
	b=oqFwylK7C9LhJMcW5nf5v6b1TXv2xW3oA+u5QBbrhzUzPn0+/zB+lH7lEI28EUz5c
	 HiN4rvGzMkKdbx5wrX1PKK/E1HNgqvMjOW0OocP2IQ3/BzoZUjoqi4UZOIHFNm0aCW
	 KS5UBsRK1sYoNyr3QV5AtU6aJB2f0A7VZ9Q0Sua+G4g5kistXWUKVcuLOVZRHlLLWI
	 6AtkHYjNW99MI/wOIYcji8mwd3/RfhP0lvlZQ8kJJoguVQvHtPJqjibXbbIZVVUvqG
	 tPPQQtQWJFFML649mKcoWjWkNo6qc3LQn1xXk00beSLz5u/Gmuh4w9PQUuAkpGuW6h
	 k/Vds8FjNdBVQ==
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-3862d16b4f5so662165f8f.0
        for <linux-nfs@vger.kernel.org>; Fri, 06 Dec 2024 15:33:41 -0800 (PST)
X-Gm-Message-State: AOJu0Ywl5xeVLaL/+hq0wyeu632XUc9ehHPqBiGByWuPqvZvxvr6jvnP
	4+Vyeci1SfpHPKxQRH+8hxvzhlCIef80WlPIloPrBO4MpX3sw6ck+gV2/wUSm80A2Ml7LdltO2Q
	0XX2ZSdoLheugsIwCI+2Sywh35OQ=
X-Google-Smtp-Source: AGHT+IHsXmCYg4grgCi/IZdO125FpMlUw3QhTtzPnaJ+PkioT1FY6ig7fSMRqjizPK2H3ixS11wZzdXN0EmSrBNG2+Q=
X-Received: by 2002:a05:6000:2cc:b0:385:e4a6:5ae1 with SMTP id
 ffacd0b85a97d-3861bb5c182mr7684438f8f.8.1733528019475; Fri, 06 Dec 2024
 15:33:39 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAKAoaQmaf7d01vK4TfR+=8k4CVN-CX3ESPFh88EaxvcOAQDWtQ@mail.gmail.com>
 <fb7bf50a-29d3-4543-90e8-617fdd205f76@oracle.com>
In-Reply-To: <fb7bf50a-29d3-4543-90e8-617fdd205f76@oracle.com>
From: Roland Mainz <roland.mainz@nrubsig.org>
Date: Sat, 7 Dec 2024 00:33:13 +0100
X-Gmail-Original-Message-ID: <CAKAoaQ=d0RUc2CGSGDej0yYQ5QMWJTEDSXd_Ox3WXx776xzrhg@mail.gmail.com>
Message-ID: <CAKAoaQ=d0RUc2CGSGDej0yYQ5QMWJTEDSXd_Ox3WXx776xzrhg@mail.gmail.com>
Subject: Re: [patch] mount.nfs: Add support for nfs://-URLs ...
To: Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 6, 2024 at 4:54=E2=80=AFPM Chuck Lever <chuck.lever@oracle.com>=
 wrote:
> Here are some initial review comments to get the ball rolling.
> On 12/6/24 5:54 AM, Roland Mainz wrote:
> > Below (and also available at https://nrubsig.kpaste.net/b37) is a
> > patch which adds support for nfs://-URLs in mount.nfs4, as alternative
> > to the traditional hostname:/path+-o port=3D<tcp-port> notation.
> >
> > * Main advantages are:
> > - Single-line notation with the familiar URL syntax, which includes
> > hostname, path *AND* TCP port number (last one is a common generator
> > of *PAIN* with ISPs) in ONE string
> > - Support for non-ASCII mount points, e.g. paths with CJKV (Chinese,
>
> s/mount points/export paths

OK

> (When/if you need to repost, you should move this introductory text into
> a cover letter.)

What is a "cover letter" in this context ? git feature, or something else ?

> > Japanese, ...) characters, which is typically a big problem if you try
> > to transfer such mount point information across email/chat/clipboard
> > etc., which tends to mangle such characters to death (e.g.
> > transliteration, adding of ZWSP or just '?').
> > - URL parameters are supported, providing support for future extensions
>
> IMO, any support for URL parameters should be dropped from this
> patch and then added later when we know what the parameters look
> like. Generally, we avoid adding extra code until we have actual
> use cases. Keeps things simple and reduces technical debt and dead
> code.

Originally we had much more URL parameters in the patch.

After lots of debate I've cut that part down to the set (i.e. { "rw",
"ro" } * { "0", "1" }, e.g. "ro=3D1", "ro=3D0" etc,) which is supported by
ALL nfs://-URL implementations right now - which means if we revise
the nfs://-URL RFC to make nfs://-URLs independent then we have to
cover the existing "ro"/"rw" URL parameters anyway.

Technically I can rip it out for now, but per URL RFC *any* unexpected
URL parameter must be fatal, which in this case will break stuff.
That's why I would prefer to keep this code, and it's also intended to
demonstrate how to implement URL parameters correctly.

Maybe split this off into a 2nd patch ?

> > * Notes:
> > - Similar support for nfs://-URLs exists in other NFSv4.*
> > implementations, including Illumos, Windows ms-nfs41-client,
> > sahlberg/libnfs, ...
>
> The key here is that this proposal is implementing a /standard/
> (RFC 2224).

Right, I wasn't sure whether to quote it or not, because section 2 of
that RFC quotes WebNFS, and some people are afraid of
"WebNFS-will-come-back-from-the-grave-to-have-it's-revenge"... :-)
... but yes, I'll quote that.

> > - This is NOT about WebNFS, this is only to use an URL representation
> > to make the life of admins a LOT easier
> > - Only absolute paths are supported
>
> This is actually a critical part of this proposal, IMO.
>
> RFC 2224 specifies two types of NFS URL: one that specifies an
> absolute path, which is relative to the server's root FH, and
> one that specifies a relative path, which is relative to the
> server's PUB FH.
>
> You are adding support for only the absolute path style. This
> means the URL is converted to string mount options by mount.nfs
> and no code changes are needed in the kernel. There is no new
> requirement for support of PUBFH.

Right, I know. And the code will reject any relative URLs ($ grep -r
-F 'Relative nfs://-URLs are not supported.' #) ...

> I wonder how distributions will test the ability to mount
> percent-escaped path names, though. Maybe not upstream's problem.

It's more an issue to generate the URLs, but any URL-encoding-web page
can do that.
I also have http://svn.nrubsig.org/svn/people/gisburn/scripts/nfsurlconv/nf=
surlconv.ksh
and other utilities, but that would be a seperate patch series.

DISCLAIMER: Yes, it's a ksh(93) script (because it needs multiline
extended regular expressions, which bash does not have in that form),
and putting that into nfs-utils will NOT cause a runtime dependency to
/sbin/mount.nfs4 or somehow break DRACUT/initramfs. It's just a
utility *script*.

> > - This feature will not be provided for NFSv3
>
> Why shouldn't mount.nfs also support using an NFS URL to mount an
> NFSv3-only server? Isn't this simply a matter of letting mount.nfs
> negotiate down to NFSv3 if needed?

Two issues:
1. I consider NFSv2/NFSv3/NFSv4.0 as obsolete
2. It would be much more complex because we need to think about how to
encode rpcbind&transport parameters, e.g. in cases of issues like
custom rpcbind+mountd ports, and/or UDP. That will quickly escalate
and require lots of debates. We had that debate already in ~~2006 when
I was at SUN Microsystems, and there was never a consensus on how to
do nfs://-URLs for NFSv3 outside WebNFS.

I think it can be done, IMHO but this is way outside of the scope of
this patch, which is mainly intended to fix some *URGENT* issues like
paths with non-ASCII characters for the CJKV people and implement
"hostport" notation (e.g. keep hostname+port in one string together).

> General comments:
>
> The white space below looks mangled. That needs to be fixed before
> this patch can be applied.

Yes, I know, that is a problem that I only have the choice between
GoogleMail or MS Outlook at work. That's why I provided kpaste.net
links (https://nrubsig.kpaste.net/e8c5cb?raw and
https://nrubsig.kpaste.net/e8c5cb). I'll try to set up git-imap-send
in the future, but that needs time to convince our IT.

This should work for the v2 patch:
---- snip ----
git clone git://git.linux-nfs.org/projects/steved/nfs-utils.git
cd nfs-utils/
wget 'https://nrubsig.kpaste.net/e8c5cb?raw'
dos2unix e8c5cb\@raw
patch -p1 --dry-run <e8c5cb\@raw
patch -p1 <e8c5cb\@raw
---- snip ----

> IMO, man page updates are needed along with this code change.

Could we please move this to a separate patch set ?

> IMO, using a URL parser library might be better for us in the
> long run (eg, more secure) than adding our own little
> implementation. FedFS used liburiparser.

The liburiparser is a bit of an overkill, but I can look into it. I
tried to keep it simple for ms-nfs41-client (see below), because
otherwise I would've to deal with another DLL (which are far worse
than any *.so issue I've seen on Solaris/Linux).

The current urlparser1.[ch] was written for OpenSolaris long ago, and
then updated for the Windows ms-nfs41-client project (see
https://github.com/kofemann/ms-nfs41-client/tree/master/mount ; almost
the same code, except there are additions for wide-char streams and MS
Visual Studio) and is being maintained for that and several in-house
projects, so maintenance is guaranteed (that's why my manager (Marvin
Wenzel) signed it off, too).

[snip]
> > ---- snip ----
> >  From e7b5a3ac981727e4585288bd66d1a9b2dea045dc Mon Sep 17 00:00:00 2001
> > From: Roland Mainz <roland.mainz@nrubsig.org>
> > Date: Fri, 6 Dec 2024 10:58:48 +0100
> > Subject: [PATCH] mount.nfs4: Add support for nfs://-URLs
> >
> > Add support for RFC 2224-style nfs://-URLs as alternative to the
> > traditional hostname:/path+-o port=3D<tcp-port> notation,
> > providing standardised, extensible, single-string, crossplatform,
> > portable, Character-Encoding independent (e.g. mount point with
>
> As above: s/mount point/export path

OK

Anything else ?

----

Bye,
Roland
--=20
  __ .  . __
 (o.\ \/ /.o) roland.mainz@nrubsig.org
  \__\/\/__/  MPEG specialist, C&&JAVA&&Sun&&Unix programmer
  /O /=3D=3D\ O\  TEL +49 641 3992797
 (;O/ \/ \O;)


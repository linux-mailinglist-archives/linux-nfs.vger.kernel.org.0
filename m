Return-Path: <linux-nfs+bounces-8464-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AE56C9E9A28
	for <lists+linux-nfs@lfdr.de>; Mon,  9 Dec 2024 16:15:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 61CA818870B4
	for <lists+linux-nfs@lfdr.de>; Mon,  9 Dec 2024 15:15:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9210535975;
	Mon,  9 Dec 2024 15:15:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P0v+/stG"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACBC235972
	for <linux-nfs@vger.kernel.org>; Mon,  9 Dec 2024 15:15:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733757340; cv=none; b=UMmvnPF9Wd0sTlLcni9jLkefiaqXAT3CveGWmpLBxXqxZnrXiagwoZSGLvoptUbFFam0qjQyXOtpx2h8hFWFK7GiTYiXCVwtNCm6Ju5I6A4tml9fddfl7ryd/8HiTVmDqphBYoWTzrI3Ua0oM5Z5ZtXPmg6yLkt1mwra1SRRvNc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733757340; c=relaxed/simple;
	bh=lYKDhXDWTyTTz35Y26cJ+m5JkYZZE0qHRnleY7h2/FY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=Y0VgvMmcSfm6vpu5kLbFmqCZntVOC5EQmALTn5Yrq6TYaa4UC7FR0yabRE5tM5MCNE3ZzeB4s0dcadHsKT2wHvUVsmblljMvu5R55o+rKAOBiWmUsDjwq7H6QCTS3ljL68y0QqXgogXNd4trN3t7HtX5UC1HuNxy/43YAs20BGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P0v+/stG; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-3862ca8e0bbso2410602f8f.0
        for <linux-nfs@vger.kernel.org>; Mon, 09 Dec 2024 07:15:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733757337; x=1734362137; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CqcENWzP53fdFadWaTpdri4C9mcU81T+K0p692a5tjE=;
        b=P0v+/stGVWWpQwBdOeXLOAGtyldGqCzZopSZkp3Yc1WXL3J+wZ5hNZKSo6tXlWQ2YH
         Ak4iCoZffo2iCAabxkk2O3Vzxshv6PD0eMx6PrJs86xnjS82zd3Vm6/pI/bAD73WUgjy
         mOvvhR8U1qLIKCz5+ABv699YxKgQWasaZZ+4mhDlrdbDH4FD5aMM1ZL2hkhxXGpPX2EZ
         yIkf6ZOxSOD0J6zMxi7p/6QryNFpnpOURV+Bu2ZyOs6vZYNItKGlxfhDOZH30+GdPMAb
         +93XWO+QJWJ56/zuuR3Gr/wMQJCXNTbUO3bvd5xgbTr8TjvpuREa7GeWs1pXwgnukbSR
         UAEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733757337; x=1734362137;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CqcENWzP53fdFadWaTpdri4C9mcU81T+K0p692a5tjE=;
        b=HF7pNlm1p2hxnQXoR2Gqhk5pzI9GEh1ypn1DzDpYDzSnJT0UfWWJIJ5D3QB09nwrMP
         bPP16gm8j+Qmqw5LG9u0Onmu3kpL88RG8/IFSFpluSP7OMst7z7gPiYItyTioApFHTRG
         zyO/VVuzPFn+jS7wzzcS/dgJwE8unL6q7FBEP131m5nOlLDV+gKXZlz9mXSlv7lhqi0q
         VZcgW1kzdcvD2iCJYcLvzAtvVo7xHd+qxL5Q/jUpkgpWX3LGOfNwLHFve/gd6ZJQgeIY
         OyOMNATz3SMiKT50dhR7ktYdW4feDQxzkSh73CdeLMhSICe5OKUpKCisM2quEtdFt0OH
         Lipg==
X-Gm-Message-State: AOJu0YzA5kpjfgpBYqeJIiTDuFj+5A3p24GEn2xpOlbhOQGkSo/aASXo
	lP8J4zaVGAM31J2EDUEcXThWW5q4zuzLkb/GmIqZ99oSA045nuHJJz3XSip5noZDUueqpyg3MuR
	5YDgdDXRO1GgcNyOdHqYvyvH+kkpFHn7r
X-Gm-Gg: ASbGnctFlLuZCd5kwgDXjekQ2aJgQAtPnlYiwpj3N1+fyo4AdMWEEg7uBRP0+SF05K1
	xgP5hs5TNeN6UvRToC64g+hmLPj57SnY=
X-Google-Smtp-Source: AGHT+IH/SxSLNAFe0avCEMDYFBrfVrLgdzfO28Sm0XcLPLAIfDhg73EPPzJxYKUK6SDEKr248NY1N2gg/JOywynD0ck=
X-Received: by 2002:a05:6000:1868:b0:385:fd24:3317 with SMTP id
 ffacd0b85a97d-386453cf868mr1149234f8f.1.1733757336488; Mon, 09 Dec 2024
 07:15:36 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cce34896-f8fe-42fa-a8aa-4a26cd42498c@oracle.com>
 <173362855836.1734440.12419990006245500946@noble.neil.brown.name> <4be7ab28-3ca1-4815-9e9d-9c3a06e126b3@oracle.com>
In-Reply-To: <4be7ab28-3ca1-4815-9e9d-9c3a06e126b3@oracle.com>
From: Takeshi Nishimura <takeshi.nishimura.linux@gmail.com>
Date: Mon, 9 Dec 2024 16:15:00 +0100
Message-ID: <CALWcw=HA6zOrpyi5zPjYq88vLVRjaqx3Jiy2yoFbFieMoQsKAA@mail.gmail.com>
Subject: Re: [patch] mount.nfs: Add support for nfs://-URLs ...
To: Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Dec 8, 2024 at 4:58=E2=80=AFPM Chuck Lever <chuck.lever@oracle.com>=
 wrote:
>
> On 12/7/24 10:29 PM, NeilBrown wrote:
> > On Sun, 08 Dec 2024, Chuck Lever wrote:
> >> On 12/7/24 3:53 PM, NeilBrown wrote:
> >>> On Sat, 07 Dec 2024, Chuck Lever wrote:
> >>>> Hi Roland, thanks for posting.
> >>>>
> >>>> Here are some initial review comments to get the ball rolling.
> >>>>
> >>>>
> >>>> On 12/6/24 5:54 AM, Roland Mainz wrote:
> >>>>> Hi!
> >>>>>
> >>>>> ----
> >>>>>
> >>>>> Below (and also available at https://nrubsig.kpaste.net/b37) is a
> >>>>> patch which adds support for nfs://-URLs in mount.nfs4, as alternat=
ive
> >>>>> to the traditional hostname:/path+-o port=3D<tcp-port> notation.
> >>>>>
> >>>>> * Main advantages are:
> >>>>> - Single-line notation with the familiar URL syntax, which includes
> >>>>> hostname, path *AND* TCP port number (last one is a common generato=
r
> >>>>> of *PAIN* with ISPs) in ONE string
> >>>>> - Support for non-ASCII mount points, e.g. paths with CJKV (Chinese=
,
> >>>>
> >>>> s/mount points/export paths
> >>>>
> >>>> (When/if you need to repost, you should move this introductory text =
into
> >>>> a cover letter.)
> >>>>
> >>>>
> >>>>> Japanese, ...) characters, which is typically a big problem if you =
try
> >>>>> to transfer such mount point information across email/chat/clipboar=
d
> >>>>> etc., which tends to mangle such characters to death (e.g.
> >>>>> transliteration, adding of ZWSP or just '?').
> >>>>> - URL parameters are supported, providing support for future extens=
ions
> >>>>
> >>>> IMO, any support for URL parameters should be dropped from this
> >>>> patch and then added later when we know what the parameters look
> >>>> like. Generally, we avoid adding extra code until we have actual
> >>>> use cases. Keeps things simple and reduces technical debt and dead
> >>>> code.
> >>>>
> >>>>
> >>>>> * Notes:
> >>>>> - Similar support for nfs://-URLs exists in other NFSv4.*
> >>>>> implementations, including Illumos, Windows ms-nfs41-client,
> >>>>> sahlberg/libnfs, ...
> >>>>
> >>>> The key here is that this proposal is implementing a /standard/
> >>>> (RFC 2224).
> >>>
> >>> Actually it isn't.  You have already discussed the pub/root filehandl=
e
> >>> difference.
> >>
> >> RFC 2224 specifies both. Pub vs. root filehandles are discussed
> >> there, along with how standard NFS URLs describe either situation.
> >>
> >>
> >>> The RFC doesn't know about v4.  The RFC explicitly isn't a
> >>> standard.
> >>
> >> RFC 7532 contains the NFSv4 bits. RFC 2224 is not a Normative
> >> standard, like all early NFS-related RFCs, but it is a
> >> specification that other implementations cleave to. RFC 7532
> >> /is/ a Normative standard.
> >
> > The usage in RFC 7532 is certainly more convincing than 2224.
> >
> >>
> >>
> >>> So I wonder if this is the right approach to solve the need.
> >>>
> >>> What is the needed?
> >>> Part of it seems to be non-ascii host names.  Shouldn't we fix that f=
or
> >>> the existing syntax?  What are the barriers?
> >>
> >> Both non-ASCII hostnames (iDNA) and export paths can contain
> >> components with non-ASCII characters.
> >
> > But they cannot contain non-Unicode characters, so UTF-8 should be
> > sufficient.
> >
> >>
> >> The issue is how to specify certain code points when the client's
> >> locale might not support them. Using a URL seems to be the mechanism
> >> chosen by several other NFS implementations to deal with this problem.
> >
> > If locale-mismatch is a problem, it isn't clear to me that "mount.nfs"
> > is the place to solve it.
> >
> > The problem is presented as:
> >
> >   to transfer such mount point information across email/chat/clipboard
> >   etc., which tends to mangle such characters to death (e.g.
> >   transliteration, adding of ZWSP or just '?').
> >
> > So it sounds like the problem is copy/paste.  I doubt that NFS addresse=
s
> > are the only things that can get corrupted.
> > Maybe a more generic tool would be appropriate.
>
> I agree. The cited copy/paste use case is pretty weak.

What a bold statement. Classic English-only user.

Have you ever worked in a mixed language environment? Used VMware with
Japanese Windows, and Japanese MAC OSX, and used clipboard between all
these virtual machines?
For example if you use MS File Explorer, and use "Copy Address", not
"Copy Address As Text"? You'll find Unicode zero width space markers
(class ZWSP), characters which are not displayed, to mark the begin
and end of a Win32 object file name.
Just Linux clipboard doesn't know about that little detail, worse, in
UTF8 locales the characters are still invisible, because they use zero
terminal cells (wcwidth() returns 0 for ZWSP characters!) you are
literally screwed over.
So copy in Windows, paste in Linux, paths will not work, unless you
paste in the Linux terminal, then select&copy in the terminal the SAME
path, and then paste it again. That works because it eliminates the
ZWSP.

BIDI (Bidirectional Text Layout) also uses such markers, depending on
application. Shitty .NET apps for example.

Finally, there is CTL, Complex Text Layout, for languages like Hindi
(just 600 million people speak that as first or second language, so no
need to care about them).
Wanna hear what inter-OS clipboard usage does to such paths?
--=20
Internationalization&localization dev / =E5=A4=A7=E9=98=AA=E5=A4=A7=E5=AD=
=A6
Takeshi Nishimura <takeshi.nishimura.linux@gmail.com>


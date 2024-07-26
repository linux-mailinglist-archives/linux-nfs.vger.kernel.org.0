Return-Path: <linux-nfs+bounces-5079-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A684B93D9EE
	for <lists+linux-nfs@lfdr.de>; Fri, 26 Jul 2024 22:42:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D84241C2212F
	for <lists+linux-nfs@lfdr.de>; Fri, 26 Jul 2024 20:42:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0371B50288;
	Fri, 26 Jul 2024 20:42:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hcl-software.com header.i=@hcl-software.com header.b="eq2AxWpD"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0137218641
	for <linux-nfs@vger.kernel.org>; Fri, 26 Jul 2024 20:42:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722026522; cv=none; b=PMf8TOJSSsL34n8fshAZG1liPmF5qDCROZxuQtD3gVlkffNPQByexH8ERGdEiaTsmf+xeipawb1NwkgD7+bjfY8IpHGuLZNOYnaoibqPEo1RK3l442pIfkXgOdA8z20Mo3MZrFv5YmZwa4I3fhbokdCzPAkbyMhSL7Rz2sGoGGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722026522; c=relaxed/simple;
	bh=HZVQQ4D5RNJzvnjzYRACEwPxrNx1DGdxMdi64re3qNo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UH1jOd5119YshZbBVZR6SBlu8MG4TELTvG8FaP+meGXiv2ijZanu1QzPQEat60EH0ZxXN8rloWlYm6ZrKsa7/nFJmGqY/dXzCr1ZCV0UQC0effsZgTsCqvmZ8hCmR12r5S287633xc4zatIPg0Rh8l2HBH/D0fCZuI3YRa35g+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hcl-software.com; spf=pass smtp.mailfrom=hcl.software; dkim=pass (2048-bit key) header.d=hcl-software.com header.i=@hcl-software.com header.b=eq2AxWpD; arc=none smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hcl-software.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hcl.software
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-2ef2cce8be8so20213911fa.1
        for <linux-nfs@vger.kernel.org>; Fri, 26 Jul 2024 13:42:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=hcl-software.com; s=google; t=1722026519; x=1722631319; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HZVQQ4D5RNJzvnjzYRACEwPxrNx1DGdxMdi64re3qNo=;
        b=eq2AxWpD8wsa3YkEHWEdL8GkMh4IZTxrpMKxmYfDsejnz01jnUQWscCyV4xfWZjwCZ
         8CaF3+FpRM8jcv5FDL/EEC06oyqluBqGKlAE3+TN0lJcR5iwuPiDur3b7qmrqOunVpPh
         5gsQOkX1RL5u5MOAdCH41T/jr0Gbj/1/4VhoHoZBnavzyE9TMWQ3/0LuNkK7SiqPWcIZ
         bSFmg5fWqG7VEKWy1WHsARMP4eI5e77BaOPG9VN4ZyHoXvGLdFdPuYfhy0niUqE7AGTa
         hHyd3Nz3/qvW/ijUkfujZYnFSzAWApL6rfrRP5AqQDqj1qLpRMtJyxX30PEWxulXmBjF
         lsPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722026519; x=1722631319;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HZVQQ4D5RNJzvnjzYRACEwPxrNx1DGdxMdi64re3qNo=;
        b=VK2mzGYB1MWfdmZ7Vnw9N/Xm95avdTvzSQ3h/8uvzGkzTREILonjEUIxNoEoZ94Sd8
         qu6TJ0qgXgOjbKs3iBeFGFOkcdleuFAx95WSitn2C/7NuyEHag0wMTdyIXAewfo9u8m0
         vHy2+LlI0CfMlQfxAZ/oJR9PXRtJEuVkRUYRC2qjduNlQQzkxbzLcQewpNO7q7qNpCzf
         Z+G6wK/sRl+av+d9+upGogTk9C/9ithx1e97ukDpd2dtoNgrVoEXdeWbPt1n92a4eWoD
         ur15R9r7kN7XMU80wmxhiKjXarccW0HLVZWLR8cUODkXq2CH/4EQR9CLMwiO4Qt9wrh0
         18uA==
X-Gm-Message-State: AOJu0Yyyc3ILkfoHOFn1JiD8ktBi7gZ4zsz1eQRhq05z1oc154I9JHFa
	OXmp+s14iF0jJGdODIzRh6jw9p0rotFJW1qxp3entGNK2MhBi8s3PdYmEjowdGa0S/9IBDtF5Vr
	5qqkb7+9t9CPSqmHLGBN9qmNMQI0auh6M2QCtGRp1Ubb3vkw6WMY=
X-Google-Smtp-Source: AGHT+IEP1OFSoCBQjdiXlvmiT6OrdPUHE2/NNjg8JU+jbYYtuHLftX49s3uhXkMPlU/BYx5yubcyynWVych7YWUR0Hg=
X-Received: by 2002:a2e:97cb:0:b0:2f0:1a8f:4cd2 with SMTP id
 38308e7fff4ca-2f12ee249f9mr5187841fa.33.1722026519100; Fri, 26 Jul 2024
 13:41:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAGOwBeW31AThuSLW-aWE0wAz302qaXDaCKCOmmOPjCewB8rkgw@mail.gmail.com>
 <02af01dadd24$d51d7690$7f5863b0$@mindspring.com>
In-Reply-To: <02af01dadd24$d51d7690$7f5863b0$@mindspring.com>
From: Brian Cowan <brian.cowan@hcl-software.com>
Date: Fri, 26 Jul 2024 16:41:48 -0400
Message-ID: <CAGOwBeUC6fxC96QBghiUoMOzSqHxVcG4tK40TcgSuCE0b4oOzA@mail.gmail.com>
Subject: Re: Limits to number of files opened by remote hosts over NFSv4?
To: Frank Filz <ffilzlnx@mindspring.com>
Cc: linux-nfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Yes, a DOCUMENTED and configurable limit may be useful... If there is
some way to monitor it, that would help too. Because "hidden" limits
are a pain... If I'm about to hit a brick wall, I'd like to at least
see it coming...

Regards,

Brian Cowan

ClearCase/VersionVault SWAT



Mob: +1 (978) 907-2334



hcltechsw.com



On Tue, Jul 23, 2024 at 1:22=E2=80=AFPM Frank Filz <ffilzlnx@mindspring.com=
> wrote:
>
> Any server is likely to have some limit based on the memory use for the o=
pen state.
>
> We recently introduced a configuration to limit the number of opens per c=
lientid in nfs-ganesha for comparison, prior to that it was not specificall=
y limited (and the configuration defaults to no limit) other than we would =
eventually run out of memory.
>
> It's probably good to have a limit, but your case suggests a value in tha=
t limit being configurable.
>
> Frank
>
> > -----Original Message-----
> > From: Brian Cowan [mailto:brian.cowan@hcl-software.com]
> > Sent: Tuesday, July 23, 2024 7:16 AM
> > To: linux-nfs@vger.kernel.org
> > Subject: Limits to number of files opened by remote hosts over NFSv4?
> >
> > I am responsible for supporting an application that opens LOTS of files=
 over NFS
> > from a given host, and potentially a few files/host from a LOT of clien=
ts. We've
> > run into some "interesting" limitations from other OS's when it comes t=
o
> > NFSv4...
> >
> > Solaris, for example, "only" allows 10K or so files per NFS export to b=
e opened
> > over NFSv4. When you have 2500+ client hosts opening files over NFSv4, =
the
> > Solaris NFS server stops responding to "open" requests until an entry i=
n its state
> > table is freed up by a file close. Which causes single threaded client =
processes
> > trying to open said files to hang... Luckily we convinced that customer=
 to move
> > the clients back to using NFSv3 since they didn't need the additional f=
eatures of
> > V4.
> >
> > We're also seeing a potential issue with NetApp filers where opening to=
o many
> > files from a single host seems to have issues. We're being told that Da=
taOnTAP
> > has a per-client-host limit on the number of files in the Openstate poo=
l (and not
> > being told what that limit is...) I say "potential" since the only repo=
rt is from
> > things falling apart after moving from AIX 7.2 to 7.3 (meaning there is=
 a non-
> > zero chance that this is actually an AIX NFS issue). In this case, NFSv=
3 is not an
> > option since NFSv4 ACLs are required...
> >
> > Anyway, as a result, I'm trying to find out if the Linux NFSv4 server h=
as a limit on
> > either total number of files, total number of files per export, or tota=
l files per
> > host.
>


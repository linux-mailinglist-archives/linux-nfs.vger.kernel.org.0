Return-Path: <linux-nfs+bounces-8897-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A451DA00F3A
	for <lists+linux-nfs@lfdr.de>; Fri,  3 Jan 2025 22:00:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7A0741647B6
	for <lists+linux-nfs@lfdr.de>; Fri,  3 Jan 2025 21:00:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB5111BEF83;
	Fri,  3 Jan 2025 21:00:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l1c2uxB4"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 052CF84A5B
	for <linux-nfs@vger.kernel.org>; Fri,  3 Jan 2025 21:00:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735938002; cv=none; b=qFLere9MGLFtTkO6yP6fjCqTTs3D/NmxKSSpJxnuouOa8P+u7UjNtHIDDU4qj4IIJfXrR0OgARFUS9dsceFIw3aKnoOMdoCvhtZSABUL9IBV9Drj+n/PnUL5qVI1/yG+O2iQ8LxKF7mqQUmZ23H2kuYLpNhMYdi+UG7Rs6kT+NE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735938002; c=relaxed/simple;
	bh=1kFqOwma1Pcp+3tTz2jWDP/J6kxIDSW/xwOhvaNC6bU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=fShIldXEWIOWs5zrfbgH5gpaNoI9BsmmTm+spSc7MIPi/K0AJ3Rz09rwFt66FBrrPoTrImrAVIl1iSFX56R6UEja+pK8qY0ffVsk+E3N4feIoXX9sNNv05zgtfUOIn0UYC7N4/nV+2B6BQKCglx6RbA2xhDzMlZM5tVOdPpSQys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l1c2uxB4; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-aa692211331so2392317466b.1
        for <linux-nfs@vger.kernel.org>; Fri, 03 Jan 2025 13:00:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1735937998; x=1736542798; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1kFqOwma1Pcp+3tTz2jWDP/J6kxIDSW/xwOhvaNC6bU=;
        b=l1c2uxB4dN+sA5pvtog18z5j5X8TXimo0pRmBzzWMBk3I4c/FOtI70t9h4Njs/w8am
         yOMwOsmp/WSUqFZfQ/modC3q2WJl2a4hdOmivdW0oiLrkk3Ar42wQIvb1SNn3goqsLz8
         WA+CHgp/4GolyDyBc13NF2hVKkt8HbtY0G0QIa0QUMJsrP/WZ5xVJuqkotlI9Uf1+OHs
         Lkw0Lrg9yMwjBYudOewV60ccMTpzGbRFAxUWlwOEu3Yzxt80NM0WxF2pnvEOdLY09oJX
         DLoE+2/++0fMcxfPIqsgQorzJXzbRCwLT7ecR0lN3Nal35nfy99mD9ziqxMk80C7x/K1
         JpPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735937998; x=1736542798;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1kFqOwma1Pcp+3tTz2jWDP/J6kxIDSW/xwOhvaNC6bU=;
        b=jcRMK/LNN5h2sL9LrihlCX8YqQKpPGXMr6ZrnMUbq9sxuxwJidhkyjk+jKXDW0ctaC
         kTLaCRm+S/O8xUyNF9dTh/jMzPqD135UX5DU364RNBj6AuPaQAupuD6NvkY3sUgWKY+H
         pp2ey9FTjSo2b49Z0HjYYayECmX/gg9dC9pltrnshZ9nxywLiQXoNLKgTltVeBTEpyea
         Em4DHEx7x15lTg/lratO0W6tRQIT3aknEwfVIG46UgK4XQeoh5uMmQudX9YBiXPrCovV
         CI5lo6ArsNPPWWnYoXbimNIOU7iG4p5q7ucW/qvaR1Neb+agd1DDrYTDeYMMZ4PXHpVh
         u8rg==
X-Gm-Message-State: AOJu0Yyv9fcwFL6+0I3cFzWXRK4tTCqzLa2j3B54Gb6rqB+Ah4p7n+e1
	+TtJFw4rg5o8zaUiC7bD6SG39k+auahgXQMdVQ5plEBwv3NeHMrv9CJKOJL5ZWiOzHXM0lMZo74
	nXNfsGHmgd248HxcBxMEqojTse74mM0XW
X-Gm-Gg: ASbGnct4GfIyB0zsreRhrKZNcPepw5qa5+boajNYE/GmpqrPJJvtZTVTatFGexuN4dB
	8E25C2lhSB0sTsqrDCUEGQozyPNkR89o4WojL7A==
X-Google-Smtp-Source: AGHT+IFvB2zWjVsNyafRskC5scZjRlvn0db0yoL3SyHS/wd02A3dIwUMmof9wSZ+VxAeqeGmXknIU4mVaX5iEKOhx3Y=
X-Received: by 2002:a17:907:97d2:b0:aa6:8dcb:365b with SMTP id
 a640c23a62f3a-aac3349cca7mr4519042066b.5.1735937998470; Fri, 03 Jan 2025
 12:59:58 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240706224207.927978-1-sagi@grimberg.me> <114581777d5b61b6973ec9ef2537ee887989e197.camel@kernel.org>
 <9156BC30-78C3-4854-8BC3-510E586B4613@oracle.com> <3b4ec3b0-5359-4f95-81a3-1d558756bddd@oracle.com>
 <5a071e49-f214-41d3-b29f-aa1860b12455@grimberg.me> <e23bb0d4-7f83-45fd-8df1-b127e1f749db@oracle.com>
 <9b9430e9-845b-4e21-b021-cfc387cbd01e@grimberg.me> <53440FD0-58F1-4B92-BCC3-20CB91BB529C@oracle.com>
 <500c22cd-b88c-48e6-8cb4-732f66f8e913@grimberg.me> <9DB557C4-60D9-4148-9017-AEE32792BA0A@oracle.com>
 <a8d6d640-ab58-498d-9b28-427014ca9b5b@grimberg.me>
In-Reply-To: <a8d6d640-ab58-498d-9b28-427014ca9b5b@grimberg.me>
From: Martin Wege <martin.l.wege@gmail.com>
Date: Fri, 3 Jan 2025 21:58:00 +0100
Message-ID: <CANH4o6NyKgTt+ooWCzQDwB+CvRB674ikmMD9kEegBvzdeCtCfg@mail.gmail.com>
Subject: Re: [PATCH rfc] nfsd: offer write delegation for O_WRONLY opens
To: Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 18, 2024 at 12:56=E2=80=AFAM Sagi Grimberg <sagi@grimberg.me> w=
rote:
>
>
>
> On 10/07/2024 17:45, Chuck Lever III wrote:
> >
> >> On Jul 10, 2024, at 3:11=E2=80=AFAM, Sagi Grimberg <sagi@grimberg.me> =
wrote:
> >>
> >>
> >>> Yes, as an NFSD co-maintainer, I would like to see the
> >>> READ stateid issue addressed. We just got distracted
> >>> by other things in the meantime.
> >> OK, so reading the correspondence from the last time, it seems that
> >> the breakage was the usage of anon stateid on a read. The spec says th=
at
> >> the client should use a stateid associated with a open/deleg to avoid
> >> self-recall, but allowed to use the anon stateid.
> >>
> >> I think that Dai's patch is a good starting point but needs to add han=
dling of
> >> the anon stateid case. The server should check if the client holds a d=
elegation,
> >> if so simply allow, if another client holds a deleg, it should recall?
> > For an anon stateid, NFSD might just always recall if
> > there is a delegation on that file. The use of anon is
> > kind of a legacy behavior, IIUC, so no need to go to a
> > lot of trouble to make it optimal.
> >
> > (This is my starting position; I'm open to be convinced
> > NFSD should take more pain for this use case).
>
> Hey Chuck, didn't forget about this.
>
> I'll look into this when I find some time (which I lack these days).
>

Welcome to 2025 - is this issue fixed?

Thanks,
Martin


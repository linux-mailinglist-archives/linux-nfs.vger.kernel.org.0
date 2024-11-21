Return-Path: <linux-nfs+bounces-8176-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BDA699D4E20
	for <lists+linux-nfs@lfdr.de>; Thu, 21 Nov 2024 14:53:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 199D01F22422
	for <lists+linux-nfs@lfdr.de>; Thu, 21 Nov 2024 13:53:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B84F1B0F0C;
	Thu, 21 Nov 2024 13:53:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m1bN6bWV"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB3161F5E6
	for <linux-nfs@vger.kernel.org>; Thu, 21 Nov 2024 13:53:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732197183; cv=none; b=Rddss+P/A5quI7vOLXeBesGCtRlaFdH7uN3w4R689lHb1xl/7Mnk+MIlYydhBWueNYfjy5P9qYxSG63/BpYfw09sJWE0j9ZzHG0H4TJ8z+y1JoLXk3Cfay28I/AJDX5r0lmkyhdRMVrqDA4DGE7QV1EcF/8oOen7ETYvt1oO1IU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732197183; c=relaxed/simple;
	bh=5dal29cXm2NcmKSHNfyXbEQUoYwHh9qcxUpXW+9I40Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=IdBIwD8edEGg7DQiSD8pJ7/U7pQgLk0HZ+Shw+peLWZx+rIVUYIV33qBOLyk71oW7VdtolzO7of8xBRnz1qtILMW1nCcj8NypqoZj6J05lnwVbOfaPEaOc59QazmA34TPuLcKl3XISl6OZEs00Ydv9OS0Z+/C2WeTN0qthvuxz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m1bN6bWV; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a9a977d6cc7so64485566b.3
        for <linux-nfs@vger.kernel.org>; Thu, 21 Nov 2024 05:53:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732197180; x=1732801980; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PIG371UZS+cWZjeXNHSHZxUdyHzkWSjXQJUnmePM4zs=;
        b=m1bN6bWVRcZN3oIlBDxPW3VnYMtQKpQlJZd7o6I/RXe0syVmXLja2xbQlcogn8/etX
         +V3+KVdPpI/AVVQBWy5loCtAj2viGRAwu5G9uciydAoNSzRNkBcNaOhrkRD99e/kC4ne
         zQplnSe0Drg7PwIk4CKiaXaz1TihAAMJfqSmO4sgkSH6btZcrKSc83CGdG96FATfcv2s
         Ce7rd9bbD11PEml/fdu2fW/CCKXra+B0XPA8CMmU11sEXiMgsMQrRrN2iIWfYhnUxJ9s
         54BG2msoJdZT3J7cSbwriXqrhE0cexNwxKFyXjLoW6T/YBEmpzmMxALg1uzmiE6kwJoT
         PENA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732197180; x=1732801980;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PIG371UZS+cWZjeXNHSHZxUdyHzkWSjXQJUnmePM4zs=;
        b=Yl+zgTCyQ5asy0Z5AY5qQ0IFZlFR+gTkBH+QE+c+01qZ/6alyK1biRrUdEZZIv7vsH
         v/FMsvbr2hkxwW2Od14vfohKEw2nNmP0VQlR3Zss6a+OCzlRt/MNPFgvUS+1GlMS5uyL
         qlAYqG8uwzPwqjRBnB0J7F/qSMtOglXraymakw+hEGuSWGGOs8OO+YAd+FYfgBi8O2RI
         zeeZOGFvyVw9qt0Wq00uWhCmCbkHuzk1doguLsjmRK177YMsFAvQktDdduPRoiLTueX9
         0W2+Am0nzWtpdSPbGDqSl/8RLM4+loFPXdlQ4ITjl00EDYpeh5tK52sNCRf0Z21DxS2e
         l0bg==
X-Gm-Message-State: AOJu0YxtyFNh6DgMOtz3a/JBs675bsUt91l/fmmYkh5fY8esAp+Vm/z9
	4an7J8NAUh4G/hRhz2A3Ofo5vJ5HNPaJmziLwhmKufdzMF5zi4wPWU498+Oh8YcYTRm6QeOkZ+a
	LC9yeEntkw9EjEOuVN/99cYpZzHZeLoMv
X-Gm-Gg: ASbGncv1ETGIKK1yz/R5bmfWFrsYilzH4ijfDBPRff6j27yliuYjcyG1mH+t0ppGlRT
	Z8VMmgWw5/Q2JisEHnxL+rOcxH03Q7kmQ
X-Google-Smtp-Source: AGHT+IEYTbC0PQ/8FiH3XBeCwjJxLXKfM2apa04CG6dJtkW9WZjL7XdQpEDoFsYhWWjfDkWIW090cdqedeIV+q0Gtzs=
X-Received: by 2002:a05:6402:520c:b0:5cf:634a:10ce with SMTP id
 4fb4d7f45d1cf-5cff4ca4f33mr6978983a12.25.1732197179583; Thu, 21 Nov 2024
 05:52:59 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241119165942.213409-1-steved@redhat.com> <59ca2dd7-583f-4141-aef9-4acff857c957@redhat.com>
 <CAAvCNcByu8MAmBRMw6U2a0pHiYQKrp361R9NpCnFp8A3om5hUQ@mail.gmail.com>
In-Reply-To: <CAAvCNcByu8MAmBRMw6U2a0pHiYQKrp361R9NpCnFp8A3om5hUQ@mail.gmail.com>
From: Cedric Blancher <cedric.blancher@gmail.com>
Date: Thu, 21 Nov 2024 14:51:00 +0100
Message-ID: <CALXu0Ueq5HP==Fde=4W70ngVpu=dFCOfNAFbZpYe1zPAKiJZpg@mail.gmail.com>
Subject: Re: [PATCH V2] nfs(5): Update rsize/wsize options
To: Linux NFS Mailing list <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Thu, 21 Nov 2024 at 00:17, Dan Shelton <dan.f.shelton@gmail.com> wrote:
>
> On Wed, 20 Nov 2024 at 21:56, Steve Dickson <steved@redhat.com> wrote:
> >
> >
> >
> > On 11/19/24 11:59 AM, Steve Dickson wrote:
> > > From: Seiichi Ikarashi <s.ikarashi@fujitsu.com>
> > >
> > > The rsize/wsize values are not multiples of 1024 but multiples of the
> > > system's page size or powers of 2 if < system's page size as defined
> > > in fs/nfs/internal.h:nfs_io_size().
> > >
> > > Signed-off-by: Steve Dickson <steved@redhat.com>
> > Committed... (tag: nfs-utils-2-8-2-rc2)
> >
> > I know we are still discussing this but I think
> > this version is better than what we have.
>
> Nope. The code is IMO wrong, and the docs are buggy too.
>
> >
> > So update patches are welcome!
>
> Solaris, HPUX, FreeBSD and Windows NFSv3/v4 implementations all count in bytes.

I hereby concur, this is better to be consistent across operating
systems. In any case this is better than some machine- or
hardware-specific config option called "default page size", which no
one knows at boot time.

Ced
-- 
Cedric Blancher <cedric.blancher@gmail.com>
[https://plus.google.com/u/0/+CedricBlancher/]
Institute Pasteur


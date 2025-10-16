Return-Path: <linux-nfs+bounces-15295-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 61F20BE3EF3
	for <lists+linux-nfs@lfdr.de>; Thu, 16 Oct 2025 16:37:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9E90942510C
	for <lists+linux-nfs@lfdr.de>; Thu, 16 Oct 2025 14:36:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91B953375D3;
	Thu, 16 Oct 2025 14:36:38 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-vk1-f176.google.com (mail-vk1-f176.google.com [209.85.221.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8E0F2E36FD
	for <linux-nfs@vger.kernel.org>; Thu, 16 Oct 2025 14:36:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760625398; cv=none; b=hGlxUsklHTOInDiqkRrYuY1fTeZzkn5K0D0ZUJ7wmRkk1avU7fDQ/aEM8xyj3GWddQuyT13DkcD1BcwnRrZHKQzkzUGVhpnlnkpFFfNE4rl07iz6l1wu+gW957bYKksbrvK0/3hvGhVZ4EIBiRhyCPIp0OHeVgBO3zvHdNvysVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760625398; c=relaxed/simple;
	bh=JtiFr1lfFip5CCoHK1c9pObM6nRvuG0oTh4JpnGVCOI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=opyMrnOV72tVb799cLc6rzoys2+kmqh5DiDqlG72tAaLxKl6VWeorrrR1m1AdLt1WoBlKIQJeDnLzFwAWhkV78trxvLC8vJ7VXRG+qWWUawC1HFNIDljS3ccbcD+7w7m6nxFgbyN513pawhdZk2DJKTAWKiJxGa1D1R/a+zbqV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f176.google.com with SMTP id 71dfb90a1353d-54bc6356624so1679446e0c.1
        for <linux-nfs@vger.kernel.org>; Thu, 16 Oct 2025 07:36:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760625396; x=1761230196;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kVQhekYxGpPKLazc3W0RRSQdJSktpe1qJ4nKjQm0ylE=;
        b=OIVNXuccQnY+XMbYBONCYnT//gxs9OMBFTvd/vk6Uc6rbg5w150fxyZdEZiXwY4pmh
         Z/s7Wr5jrXLeq2bruzsyNphdCZQWGrLnZRpfBTcohqwJPzWVr/vsW2jF+o9+gHmzYo0L
         nVOicX3NP5rLfWFE1Kf8NkroINfRc8eJOpF03Vwax0EUpe8Fy6Ay715qFyxH9g2gTqcn
         H41Dc6j3SOcKULphwnKDw9QZAKVBQ8QM2qtGGxBwtyby/MZo2hxqjCp1hgd1pAnibLA4
         CTt58IKgOT/0UeCEUFL/oZPmj0UX4SsfHnnYAeoAHcwmi3y7lhqGaT+mG8QV3M/YT6v9
         3zuA==
X-Forwarded-Encrypted: i=1; AJvYcCWcrltmqfMYbGSJeTrQK+iHjdTugX+sqnUh8FBoiEkVUT8eEKC2YnNs32sDGzoKvapTVXQe3LtqE+c=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx65E/GWvu1Z+fywERiS4DzGA1U8X8yoxN61OVjT7i3635COhhu
	Ekq62RGvkRhz+7SirrhC4CB+vfX+xyfp9piLhWap+FTKiabN6iFbb7ucuJ7b25wT
X-Gm-Gg: ASbGncvCEWpRHRfyYEEA0eATAW/OnpFIVdOtV/t52YpzivN8f1jiDCHTL5uWe8G3I2q
	ZDQ0LWHUHpImD0EXJsLVfhHW2GLVLrtzZX+ig/SgSoBrtueI8tmefZTsyvUgO0I4HakkC91uint
	ttSO7Eegro6S6gzuPbEJch2xrVF6wMa6WSV5MHgK0VjuJCwMi0m4SW+Mr4QhWWqobIVUm3UdVpF
	A1/61m4wWlgLTNWpkxaza9rhnnSzEN80MG9+Up0Cs8RLKXTHQAV/IL3AuP+Tuv8wUa/9Lu+P26L
	JgOzhmecxSoQ+/84tGVqJxATMkk0+Sy1FujZmsIdoE23jjFGwgaV9H3RSIzclo+E9IDSbwb0Jcr
	5C4/EAnucKc5TvZN8OMhZgNkHqGWVyYIHk8vsqIHGHckf+6MpYlBdUBpaZM4bFhdI/l0lPcXknf
	K/Y88Y1Vuz9NmoZG5ikl2+x7Fs4rVk6vCadE5o5NrruAwm84rF
X-Google-Smtp-Source: AGHT+IE/J3S6Fd9Q9qRFK6/TIF+CanoNT5mL0p0uBdmO6pZSyoViHc4SPIk8tGtN2R/f2YdTAjK6Fw==
X-Received: by 2002:a05:6122:469d:b0:552:361e:25fd with SMTP id 71dfb90a1353d-5564ed6df2amr261994e0c.2.1760625395468;
        Thu, 16 Oct 2025 07:36:35 -0700 (PDT)
Received: from mail-vs1-f50.google.com (mail-vs1-f50.google.com. [209.85.217.50])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-554d80ddf8asm6054058e0c.21.2025.10.16.07.36.35
        for <linux-nfs@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Oct 2025 07:36:35 -0700 (PDT)
Received: by mail-vs1-f50.google.com with SMTP id ada2fe7eead31-5b99f5d5479so1445947137.0
        for <linux-nfs@vger.kernel.org>; Thu, 16 Oct 2025 07:36:35 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVscLT9a6zIrLGuZIVaul4beOlxh2SX7G2TN0j8avnqENT60dhbcqGXh77NNVlBnhsdv3Ql4CHjE8A=@vger.kernel.org
X-Received: by 2002:a05:6102:c54:b0:4e5:8d09:7b12 with SMTP id
 ada2fe7eead31-5d7dd561de7mr291034137.7.1760625395137; Thu, 16 Oct 2025
 07:36:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251006135010.2165-1-cel@kernel.org> <CAMuHMdVYNUBH11trBr2Mo3i_fDh5sw5AzqYbPwO7_m4H6Y3sfA@mail.gmail.com>
 <20251013192103.GA61714@google.com> <f3a3f734-e75a-4d93-9a89-988417d5008c@kernel.org>
 <96e2c0717722be57011f4670b1a6b19bb5f4ef48.camel@kernel.org>
In-Reply-To: <96e2c0717722be57011f4670b1a6b19bb5f4ef48.camel@kernel.org>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 16 Oct 2025 16:36:23 +0200
X-Gmail-Original-Message-ID: <CAMuHMdX-LN-uhecx_ZJ9DokNJQ-0maGiLij_u9LVhNk9TODFVA@mail.gmail.com>
X-Gm-Features: AS18NWBYBkPaDTD1IE_FVtvCC_5e0spscrE1gzoktLGiMPWEWcHRJ_XW2mFbbB8
Message-ID: <CAMuHMdX-LN-uhecx_ZJ9DokNJQ-0maGiLij_u9LVhNk9TODFVA@mail.gmail.com>
Subject: Re: [GIT PULL] NFSD changes for v6.18
To: Jeff Layton <jlayton@kernel.org>
Cc: Chuck Lever <cel@kernel.org>, Eric Biggers <ebiggers@kernel.org>, 
	Trond Myklebust <trondmy@kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>, 
	linux-kernel@vger.kernel.org, linux-nfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Jeff,

On Thu, 16 Oct 2025 at 16:31, Jeff Layton <jlayton@kernel.org> wrote:
> On Mon, 2025-10-13 at 15:37 -0400, Chuck Lever wrote:
> > On 10/13/25 3:21 PM, Eric Biggers wrote:
> > > On Mon, Oct 13, 2025 at 12:15:52PM +0200, Geert Uytterhoeven wrote:
> > > > Hi Chuck, Eric,
> > > >
> > > > On Wed, 8 Oct 2025 at 00:05, Chuck Lever <cel@kernel.org> wrote:
> > > > > Eric Biggers (4):
> > > > >       SUNRPC: Make RPCSEC_GSS_KRB5 select CRYPTO instead of depending on it
> > > >
> > > > This is now commit d8e97cc476e33037 ("SUNRPC: Make RPCSEC_GSS_KRB5
> > > > select CRYPTO instead of depending on it") in v6.18-rc1.
> > > > As RPCSEC_GSS_KRB5 defaults to "y", CRYPTO is now auto-enabled in
> > > > defconfigs that didn't enable it before.
> > >
> > > Now the config is:
> > >
> > >     config RPCSEC_GSS_KRB5
> > >         tristate "Secure RPC: Kerberos V mechanism"
> > >         depends on SUNRPC
> > >         default y
> > >         select SUNRPC_GSS
> > >         select CRYPTO
> > >         select CRYPTO_SKCIPHER
> > >         select CRYPTO_HASH
> > >
> > > Perhaps the 'default y' should be removed?
> > >
> > > Chuck, do you know why it's there?
> > The "default y" was added by 2010 commit df486a25900f ("NFS: Fix the
> > selection of security flavours in Kconfig"), then modified again by
> > commit e3b2854faabd ("SUNRPC: Fix the SUNRPC Kerberos V RPCSEC_GSS
> > module dependencies") in 2011.
> >
> > Copying Trond, the author of both of those patches.
>
> Looking at this a bit closer, maybe a patch like this is what we want?
> This should make it so that we only enable RPCSEC_GSS_KRB5 if CRYPTO is
> already enabled:
>
> diff --git a/net/sunrpc/Kconfig b/net/sunrpc/Kconfig
> index 984e0cf9bf8a..d433626c7917 100644
> --- a/net/sunrpc/Kconfig
> +++ b/net/sunrpc/Kconfig
> @@ -19,9 +19,8 @@ config SUNRPC_SWAP
>  config RPCSEC_GSS_KRB5
>         tristate "Secure RPC: Kerberos V mechanism"
>         depends on SUNRPC
> -       default y
> +       default y if CRYPTO

This merely controls the default, the user can still override it.
Implementing your suggestion above would mean re-adding "depends on
CRYPTO", i.e. reverting commit d8e97cc476e33037.

>         select SUNRPC_GSS
> -       select CRYPTO
>         select CRYPTO_SKCIPHER
>         select CRYPTO_HASH
>         help

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds


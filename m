Return-Path: <linux-nfs+bounces-15098-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9306EBCA5F3
	for <lists+linux-nfs@lfdr.de>; Thu, 09 Oct 2025 19:28:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B9DB81A6447C
	for <lists+linux-nfs@lfdr.de>; Thu,  9 Oct 2025 17:28:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48BFC241664;
	Thu,  9 Oct 2025 17:28:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=umich.edu header.i=@umich.edu header.b="T6vpwVUh"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38E89A31
	for <linux-nfs@vger.kernel.org>; Thu,  9 Oct 2025 17:28:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760030905; cv=none; b=ZC3OVmQk+PDN+5YTtvhH9WlT5eIeS5izHcixSNT35pkDxBgoVcM/Dppqq304pIvapfHfyPJNcUzmkxvFH4Uky12Wrib5apzArVcCKQ624XzG14gMaQ0nHXvaRw8KjHnIfzJMQ80q+5oXj2MsX1s88mlTlXfhykxt2hHrWVo1yyw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760030905; c=relaxed/simple;
	bh=32ge6AcbL9hEml+y/2wN1GdS6RremgElGmkZYw/65zg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KXbdwxo2iSNVCyClX2RBDrtRdmScNxigclwdeRsW9tVeS1k7PLRZnL5MyerPz0gG5fRjAqGQwhZZ95ImKC8aTXx9TWl22WsXK2e36y8xxTHd0vdLw/VYqB1BkW/enGXAr7cXJigz93itVgZEoElBNPojuaNtuQT1gZ2Qv7kPLzc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=umich.edu; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=umich.edu header.i=@umich.edu header.b=T6vpwVUh; arc=none smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=umich.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-3635bd94dadso10378631fa.1
        for <linux-nfs@vger.kernel.org>; Thu, 09 Oct 2025 10:28:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umich.edu; s=google-2016-06-03; t=1760030901; x=1760635701; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=S6vLF+fEGoTJFFSo5arJmwA7v0Hbm1swAQ1m+PxqBPo=;
        b=T6vpwVUhD/cV2J9G5aHA7sm82DGLe1DhrBtA7o17V6sSpS8CeXgmQ5lsqwpsRFtusx
         HAIeC5k2fJe5w1ZHOk6YQ8etnKyIUBx7AQSmDVEH/zhO84H6/Klb0HmB+dAR7Ok+AH20
         DartqE3v8RZ2XJBdAYg11rddWNHi62/7kDy70KXj4BPPxJ3wG2GdP2NTiUqhyHPQnmz+
         ZZUOiI/6B8DMyEw3OMNLdc5VrYrKVV/67yEPF+0T47goEZdm5rdmCJRkcLbQCw0ZZTX3
         WonbSh2WLODaNqS60/DuC15IGmw2+5FJ97jYxKdgbBW5hiz2sRnI+RXrZvXVZZIxEFyJ
         5UOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760030901; x=1760635701;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=S6vLF+fEGoTJFFSo5arJmwA7v0Hbm1swAQ1m+PxqBPo=;
        b=kfsbGY0to06b+wtV4Lx0TMyDMizdShRkzZ5QwmgnNCTjgTABpXc/fvJJ+TTvongvJG
         I2B1pl/mC/yUm7xkwhOF9iNuJ9LeHigc0tTgkYVikAmAd2Z5pGPeBhIwuXfGjUmlqzCU
         +hiTd0NoX0G8mXFt2+NuJIHvOQWytYiVxCInEKmN2xUymhD1r5AKdqFuj51EeNjcZGho
         1FaRiY5c/kD7CY9/ttgPHYLpopeQ7LBEQvc6WzGw6aIfqpPLkKLy97lmH11xV6Jn2NiS
         aYlLIkvEQfpysUdRk9P2aFomlbkYBthqlGE8FFH0/4YrzHRL3B6V/9P61sZYt4OBPivR
         3ZWQ==
X-Forwarded-Encrypted: i=1; AJvYcCWlyHj0q789CJaOtCuMOtKjF+ytd6MdbZmilI67DJGiJyMG705uOqOJphDUif53S5CohUOc00hiOdc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/WOgXCJ7Yy2WeBuWraLyBHsf1+DV/bYxctXJMGthTdWtnhZ9/
	hSaEKi7F/y4vrmoI1nGWmpgAmfnbfMqHFjgCcEYWv6AdY5sAb2648R4ODMCNIpV9VbSlxRXcYqg
	MnBfOTS044a8eqoPuK1UVccUH356sAw+RXQ==
X-Gm-Gg: ASbGnctN+H3iX1z4ZV7U5v7Ch2sTthBdw4kEEtuwzpkSH/DE2sqxtpEG5mK5qQN1ECI
	/NMm+3mLDmvZGOWGlLIRBCZh7u0wlYsMQ5IbljNTpgqrvjjjmBPl/4sMlIQ6c+1+K145FPKgwML
	GG2Lfgl7JTWrMCDtJYdTSywQtgzfeXTZhfp1wCRjsSAO2sXixRTKRop62+SYGGdCZKRL6hNMOgb
	q3dtIUwuXGDZzIGn2fggt4NnkG976c/Lggqu0RQWKIekqkSUJHSJog7+lNusx1M131BmRH14BI=
X-Google-Smtp-Source: AGHT+IFnp/pKHCCmNpcevrnSEbheYc3FL6IPf6jCJalhGQkqKBi4sPhGNHg6YIs7lGIldARGv1sOtdphPm01fxc/Jdg=
X-Received: by 2002:a05:651c:12c3:b0:372:9fd0:8c44 with SMTP id
 38308e7fff4ca-37609ce10acmr28281351fa.3.1760030901069; Thu, 09 Oct 2025
 10:28:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251009160653.81261-1-okorniev@redhat.com> <8c4c1602-c180-44cb-b1e6-782f0fe3f8b0@oracle.com>
 <fcb54c42-0eac-4e6b-9c47-0dbf8266ac4a@oracle.com>
In-Reply-To: <fcb54c42-0eac-4e6b-9c47-0dbf8266ac4a@oracle.com>
From: Olga Kornievskaia <aglo@umich.edu>
Date: Thu, 9 Oct 2025 13:28:09 -0400
X-Gm-Features: AS18NWBY7banNiRvE-HbHxXUepZPVSWxz-cvVwJuTs4ODYNgYBzHRLD89K1wI0Q
Message-ID: <CAN-5tyFCas4+mQ86PozDgzx7zMudi+Z1MC3oRknkZ4jPMbw3sA@mail.gmail.com>
Subject: Re: [PATCH 1/1] nfsd: add missing FATTR4_WORD2_CLONE_BLKSIZE from
 supported attributes
To: Chuck Lever <chuck.lever@oracle.com>
Cc: Olga Kornievskaia <okorniev@redhat.com>, jlayton@kernel.org, linux-nfs@vger.kernel.org, 
	neilb@suse.de, Dai.Ngo@oracle.com, tom@talpey.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 9, 2025 at 1:27=E2=80=AFPM Chuck Lever <chuck.lever@oracle.com>=
 wrote:
>
> On 10/9/25 1:13 PM, Chuck Lever wrote:
> > On 10/9/25 12:06 PM, Olga Kornievskaia wrote:
> >> RFC 7862
>
> And, let's add Section 4.1.2 here.
>
>
> > says that if the server supports CLONE it must support
> >
> > MUST   << BCP14
> >
> >
> >> clone_blksize attribute.
> >
> > Fixes: d6ca7d2643ee ("NFSD: Implement FATTR4_CLONE_BLKSIZE attribute")
>
> I will add a Cc: stable here.
>
>
> >> Signed-off-by: Olga Kornievskaia <okorniev@redhat.com>
> >> ---
> >>  fs/nfsd/nfsd.h | 3 ++-
> >>  1 file changed, 2 insertions(+), 1 deletion(-)
> >>
> >> diff --git a/fs/nfsd/nfsd.h b/fs/nfsd/nfsd.h
> >> index ea87b42894dd..8cda8cd0f723 100644
> >> --- a/fs/nfsd/nfsd.h
> >> +++ b/fs/nfsd/nfsd.h
> >> @@ -459,7 +459,8 @@ enum {
> >>      FATTR4_WORD2_XATTR_SUPPORT | \
> >>      FATTR4_WORD2_TIME_DELEG_ACCESS | \
> >>      FATTR4_WORD2_TIME_DELEG_MODIFY | \
> >> -    FATTR4_WORD2_OPEN_ARGUMENTS)
> >> +    FATTR4_WORD2_OPEN_ARGUMENTS | \
> >> +    FATTR4_WORD2_CLONE_BLKSIZE)
>
> Nit: shall we keep these in numeric order? CLONE_BLKSIZE should be added
> before XATTR_SUPPORT.

Thank you Chuck. I'll send a v2.

>
>
> >>
> >>  extern const u32 nfsd_suppattrs[3][3];
> >>
> >
> >
>
>
> --
> Chuck Lever
>


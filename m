Return-Path: <linux-nfs+bounces-9143-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 817ECA0A61B
	for <lists+linux-nfs@lfdr.de>; Sat, 11 Jan 2025 22:17:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C880B7A2258
	for <lists+linux-nfs@lfdr.de>; Sat, 11 Jan 2025 21:17:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A4001B87C4;
	Sat, 11 Jan 2025 21:17:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WsF4e6UY"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 577D279D2
	for <linux-nfs@vger.kernel.org>; Sat, 11 Jan 2025 21:17:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736630256; cv=none; b=ESMukRjqgQfTuR8RxjBzhcSHHsGXIxHnbMOmZFUjAoEs+2sUVmqr5XDihBqKa5zGU3KLSg7S5RHxBZ9yBocGEyGt/NHg6A74V9vcHYKNimL8xUQzVm/gzo16Sgmh+dKyz6kFOUDPYkC6mOapEBzzJNrmaVc+Ws92Esh/TBcBZZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736630256; c=relaxed/simple;
	bh=uEsaLxosfO1bHwzS1JH1VWhLh8MPsSEm+jG+cVRtZAQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=shqPE/ULfPvDpg4oMHGqTQkLqsBgA53+eO2gOBO5x5DukJO2NWrch/wXwHaejL4gYKwT7ku5vnknql0wFZv2Gt6udESKefmvC12O4PJs3M9bTmykUHcWd9H6u00dk1/2an4bzMP7h/JMpishyiBVJQCqfHUZcdaY0MfvOTequ2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WsF4e6UY; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-5d122cf8e52so5157030a12.1
        for <linux-nfs@vger.kernel.org>; Sat, 11 Jan 2025 13:17:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736630254; x=1737235054; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uEsaLxosfO1bHwzS1JH1VWhLh8MPsSEm+jG+cVRtZAQ=;
        b=WsF4e6UYvNAmOjYEOuwLQjA4b4sDkoKAk8VGHQSFdt5Y8xtE2pUqp38ZoscM+zkvOK
         izt7DYtyHxeSCrbmNb8LWe/g92W+po8c15lg8f7mkpdThDCEJ5qDmG9ej9ppRibu2QzD
         x7yfcm0DcgWUhSTe9XK9nNZbeGC/Des0elWiuo+UDwDeHfyGVehInBSMrUWXAwl9xhv7
         AmhYzzIr3b5DNUJYote2BcI4CMLxLqONXXJs+2DKsxMlsm1aXfjEQAvAXTwo4UDdAYk+
         6WdjbEtRTYGQq1bMMsDQMNrFBlawzrxQ1RBJZ9spgRJyCQemnJXhLTsrA6oNZ0WTg+Kh
         s6lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736630254; x=1737235054;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uEsaLxosfO1bHwzS1JH1VWhLh8MPsSEm+jG+cVRtZAQ=;
        b=vdt/wkKK1IdZ2C45kjwh+imtrVq5DQEG/k7UOY0mB9WxMK7W/9XczpuECVizVQ+oOJ
         x0gGutXA+pwSCNANJEuPMlCCYNin3HRuCrBJ1jo9UrqbTBmFZsCHQa6M39WyMgzCZiHp
         ++pyrPFiH+ZCZGOCmavUzeThNwGlBwrMVIdqn+p5Q0XS9KjfYm4Er5YcxruFesis9Y13
         Y8+0nRJoNf/u1Ebqb7ncez+OmfGN1ItAzpUkeNK05TErm2ZfoiX5GLScvEFMvVG0v7Su
         NFzMDiGFLgKVSp8Y8vibKKwk5DDvj2QLViGCupFRZs7ml54cE+pXrLzAfJQ3WZx9+bAA
         HL7w==
X-Gm-Message-State: AOJu0YyHrAPKI0LIAvopJ9DfpsOARSSIBs0sG92aqeHJ7tpqinV10yvc
	+Q9lTU8VOxpUueZtWv7nBoXmvtyjcBREZzskebzrjM5H3FRQcvOZRVexO2daQ/OdisewvZDZ/0m
	8Y9miN/1Jdx53bbNLCoGKtDcls0Ga
X-Gm-Gg: ASbGncuo/cw2KdcgPI/q5zDnRgSi1LxWCj9adnVTa8XXl++YNareCw5f+nIklrScRiB
	3P22Ur4PdXYUX4tbhlgF70tb15CUSn2Duy8FO0KP0FOAYYy4AMjRQVB2VbXX3ok9HDKdyLEM=
X-Google-Smtp-Source: AGHT+IG2StgbmBOOtUuJS8+zNaLDj9AXiHQdhfFIZQ5tKd1GjghlEPZCOf1YXZ68k5aKA2v6BP1KRPSSjt44nlOgz54=
X-Received: by 2002:a05:6402:50c6:b0:5d0:b2c8:8d04 with SMTP id
 4fb4d7f45d1cf-5d972e147famr15733600a12.18.1736630253157; Sat, 11 Jan 2025
 13:17:33 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CALWcw=EPJk3XFNfXG95v4A3Dq7=spqh5aLYru05r9Lm-eVep6w@mail.gmail.com>
In-Reply-To: <CALWcw=EPJk3XFNfXG95v4A3Dq7=spqh5aLYru05r9Lm-eVep6w@mail.gmail.com>
From: Rick Macklem <rick.macklem@gmail.com>
Date: Sat, 11 Jan 2025 13:17:13 -0800
X-Gm-Features: AbW1kvYJLObqVOlSg6XFeRKIIsTLhCDA3OcKmte122vtKpvSt50SO4Dnjx8lmkA
Message-ID: <CAM5tNy5QamjN6xab3vESQmZJGD2+JgjXvn+qQit=AncG=fTPGg@mail.gmail.com>
Subject: Re: BUG: Linux 6.12 nfsd does not support FATTR4_WORD2_CHANGE_ATTR_TYPE
 in NFSv4.2 mode!!
To: Takeshi Nishimura <takeshi.nishimura.linux@gmail.com>
Cc: Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Jan 11, 2025 at 12:08=E2=80=AFPM Takeshi Nishimura
<takeshi.nishimura.linux@gmail.com> wrote:
>
> Dear list,
>
> We tried to use FATTR4_WORD2_CHANGE_ATTR_TYPE with Linux 6.12 nfsd,
> but the server does not set that attribute, while it is mandatory for
> NFSv4.2.
My understand is that nothing is mandatory in NFSv4.2. Everything is consid=
ered
optional extensions. I doubt any extant 4.2 server supports all of the opti=
onal
extensions in NFSv4.2.

> Could this please be fixed?
I'll leave if/when this optional extension will be added to the Linux
knfsd to the
Linux folk.

rick

> --
> Internationalization&localization dev / =E5=A4=A7=E9=98=AA=E5=A4=A7=E5=AD=
=A6
> Takeshi Nishimura <takeshi.nishimura.linux@gmail.com>
>


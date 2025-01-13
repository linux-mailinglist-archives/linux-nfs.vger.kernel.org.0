Return-Path: <linux-nfs+bounces-9151-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 74A68A0AE17
	for <lists+linux-nfs@lfdr.de>; Mon, 13 Jan 2025 05:07:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7EC821885B82
	for <lists+linux-nfs@lfdr.de>; Mon, 13 Jan 2025 04:07:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44058136347;
	Mon, 13 Jan 2025 04:07:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h56f2ge6"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90F6A8248C
	for <linux-nfs@vger.kernel.org>; Mon, 13 Jan 2025 04:07:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736741222; cv=none; b=JySPwrqZ40YGbdfnNhbMgKepNRH+Llfwp0iyMlKY543shehgVEct52Z2BetoKSfBkOqtDxYDjTDgDlR0L2zA1T4m4FsDFAhmeTw2kqt/yYhISmyX1PxR/p7ghlV9ZLGqD4fvwrz7PO9ptx7EQRK71hWix1wxTNvTEi2S2Ll4ufI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736741222; c=relaxed/simple;
	bh=Gw4f1ORznWgN+M8PrMicAvvH+t9inr8e+GTk3Q15G74=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=XDrvZYbPA1F0Kai2RH0p7Wk7LINYautNLpbahMmMB6+laSvv1UtgrF0nPjq+mKDjzbFPRE6hkXnfj4TPiT0biC+eB9dKz29Hlc7gFcFKrSBgP8Umr3IhzvJRoX5P/mI6t8hKJ0aoERou2Ml9jeSEQ65abL9VcP3PN/T1N0+vd6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h56f2ge6; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-aaf900cc7fbso694078566b.3
        for <linux-nfs@vger.kernel.org>; Sun, 12 Jan 2025 20:07:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736741218; x=1737346018; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Gw4f1ORznWgN+M8PrMicAvvH+t9inr8e+GTk3Q15G74=;
        b=h56f2ge6CRvCM9D4+IhOQqR9TjdlJdh7oxK95CP1B2XrOV9N1VPlxD735hjppso4NP
         L6X3a0bWjTHvsGP4mJgc3R9kpXIm0m+JPzAxOzsHFGMfaXx1KAvkidufkE8UGuEpaI8v
         42W67azsYWnPZSrPaaoStAKnw7Pmj1ZTM3dd8nOPwUcqHn2+I1qyTBYaGt/9nRU7wfRx
         SSxjCjLtrFhBZJ4zHGsY60E+dgqVqYH85ecVWO1xTwQnnM+LQGcvt1bsBkNJtui0bZ7h
         hLtgoT4uaUZh4Hw0RtvDDShIv1YoNOirTVsQ3IakKkuvRdAF0XgT2gce/O+PePwHsCl/
         dRvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736741218; x=1737346018;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Gw4f1ORznWgN+M8PrMicAvvH+t9inr8e+GTk3Q15G74=;
        b=WRMIr0ndAlw0si937HR8/VoY7Hw7edkTn4L+iwRRrlZlHTPsKSeEAb47mIq5xMN0sv
         UJjcVjAQanitWfM9ayIwWp6XzYjbjsDdwVZXf/xU7BaXI0KqAyqAm+eUmJZjl+JJSHYT
         kmPFevfSY4ZXprnnbFE3OxXi7YmuOtKu+EeETozvzLuZgpMAvNdnrRkaDoM0Lh9w9B9q
         86V4GoYmhS4iNG9uHoO5ZFl6qFKWXatlvu+Rk8gFBRJXP4t+J8s6f6/X+0H6/o1mQGqT
         n3Shu5MFOanXzbp+KNhRtT2pFokzoCf8ZFDnqu/orvOssj3AusvlFC1nUkDGLeM8G+p8
         eaYw==
X-Gm-Message-State: AOJu0Yxol0TH/+SnyW+WcVSdo7f5lx1op3T9ckMpJ4uvPX2kaHh31blR
	eYvXNXdCkmlz4EVWHKwW+MI7KWGNxGkgfNlmHif3nLwR3aKlPL61+ZQ6m5mfMcUn216M1NWszcB
	evoV+IBSibBJuVTjIWVxs+Oec9CM/6g==
X-Gm-Gg: ASbGncvekjqWTXs1ZvijSfq6fx7UIecAoRITsxMhbCkzgKGcW57eWUbcv1WCyvIw4v0
	uLJB/gRHopyZZn4gAHa8MG5g4IVn6zw0N9xTOs1k=
X-Google-Smtp-Source: AGHT+IHLoJFQG+gOuZHpCHy2QRMtD7qxHpQgYJF18SpFBEB0hLXa1PzJsW5QkI/9OAWkiDsSv/K0vvY59+JZp8Yp+QE=
X-Received: by 2002:a17:907:6ea6:b0:aac:619:e914 with SMTP id
 a640c23a62f3a-ab2ab709e32mr1791674766b.16.1736741218196; Sun, 12 Jan 2025
 20:06:58 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CALWcw=EPJk3XFNfXG95v4A3Dq7=spqh5aLYru05r9Lm-eVep6w@mail.gmail.com>
 <CAM5tNy5QamjN6xab3vESQmZJGD2+JgjXvn+qQit=AncG=fTPGg@mail.gmail.com>
In-Reply-To: <CAM5tNy5QamjN6xab3vESQmZJGD2+JgjXvn+qQit=AncG=fTPGg@mail.gmail.com>
From: Takeshi Nishimura <takeshi.nishimura.linux@gmail.com>
Date: Mon, 13 Jan 2025 05:06:00 +0100
X-Gm-Features: AbW1kvY97Oxeynj0uJmb71GIKxghChrEEn3JbOHOeJUAJpWJielS0AzmCFSiFxc
Message-ID: <CALWcw=GGunhwiuGJpA0HarYNiWCAtx8ku-TVZM8jgfDfwaiwcA@mail.gmail.com>
Subject: Re: BUG: Linux 6.12 nfsd does not support FATTR4_WORD2_CHANGE_ATTR_TYPE
 in NFSv4.2 mode!!
To: Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Jan 11, 2025 at 10:17=E2=80=AFPM Rick Macklem <rick.macklem@gmail.c=
om> wrote:
>
> On Sat, Jan 11, 2025 at 12:08=E2=80=AFPM Takeshi Nishimura
> <takeshi.nishimura.linux@gmail.com> wrote:
> >
> > Dear list,
> >
> > We tried to use FATTR4_WORD2_CHANGE_ATTR_TYPE with Linux 6.12 nfsd,
> > but the server does not set that attribute, while it is mandatory for
> > NFSv4.2.
> My understand is that nothing is mandatory in NFSv4.2. Everything is cons=
idered
> optional extensions. I doubt any extant 4.2 server supports all of the op=
tional
> extensions in NFSv4.2.

That can't be true, or would be a bug in the NFSv4.2 spec then.
"Everything optional" means feature support gets fragmented, and
interoperability will cease to exist.
--=20
Internationalization&localization dev / =E5=A4=A7=E9=98=AA=E5=A4=A7=E5=AD=
=A6
Takeshi Nishimura <takeshi.nishimura.linux@gmail.com>


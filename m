Return-Path: <linux-nfs+bounces-8414-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AE959E8134
	for <lists+linux-nfs@lfdr.de>; Sat,  7 Dec 2024 18:15:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 60E51188384E
	for <lists+linux-nfs@lfdr.de>; Sat,  7 Dec 2024 17:15:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9E3414C5AA;
	Sat,  7 Dec 2024 17:15:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OZLKd2P1"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0126114AD2E
	for <linux-nfs@vger.kernel.org>; Sat,  7 Dec 2024 17:14:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733591700; cv=none; b=mszcfxvW1xyxv5K/7mNRtMo8Lo9eAM88kvBeHSQEfRU3fVCvUx8gd3x6zYU4+MJ9Dg7ZiYkAsns4H83Vejc2HqbiVrZUZdC7VlW0I3pU7ClCBTFDPuBnPNk+JCg3bmsdqgGv1rrbUquDDUTsFGAMpA7FvxhCH/h2kwzZw5IUAeI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733591700; c=relaxed/simple;
	bh=rtGt7K1eB99Q/NKpH+qYVYkFNTUX7L9JSsQ2PLR6lrM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=C9nOquDK1PJWNrUogRu+8bocT6IM4wAsoBq0mQddnKNG4QaVQ3M57MczaCVV19Qb+sObuDs+GETmh0UVX+8jbHGokjPhb/hNeRDlLletVjDeSYCpDia2CScRC0IInt4TNWr5bf01eqNgrJhhHCPPzRcTfu/kxHE4rxg1FuRFQsk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OZLKd2P1; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-aa6332dde13so235848066b.1
        for <linux-nfs@vger.kernel.org>; Sat, 07 Dec 2024 09:14:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733591697; x=1734196497; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rtGt7K1eB99Q/NKpH+qYVYkFNTUX7L9JSsQ2PLR6lrM=;
        b=OZLKd2P1Fx6O7alQ3tKR3TE7n6OIFy0pK+0iNIEWKMqQ/48XoBpN0f67l/NuRqi/rQ
         ihxzBuIjVpMihsB0w0Tfu2kRL92lzatZwzaQr3fbFmD4lfCn5/NHYyo7qiieZGCDYPG+
         JLECsE60L67RNaQtoD5Xha5hXEXelDlAnx7Uafl8RO71/A/D/3/idGPkhJUYkU7Ux04c
         FU8VeHuXBzbbqNwSeq/sLFcSI0vyH4ZgJcnl52wvFqaCVxl3lWSbHPzKu8SqKYu1Jgj0
         7d48Imat+ZusxwCFcd1qEynUarpjpvsPv0v9cXB1z+JwCoagnrMuyDneCcHX5bvuG55M
         Ogbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733591697; x=1734196497;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rtGt7K1eB99Q/NKpH+qYVYkFNTUX7L9JSsQ2PLR6lrM=;
        b=aE3B2jGSCoAC9+QMtDGj0hNGpc3xgUQQE0FVtnIHfPsMaNntHm/rk2bNMliz/oM4mi
         RtWlsVQHdo1tzxSaiQ8HvyIYG9loaho7RVk5KhXBKcqNEq+m0yBK2yviwN/ysnTBpdZV
         rExHPdXV5na092O2pjMF5kfa3idgzSpn12cx9bkL6fvhg/+bF8LHh5TjLz7tNyJ0BX0q
         lPgLBDpE9bRVTIvoRJAWcanI2i1ZbchjBInR8wxfNsIPAab8y7wkjVD0Run8ZapqWwNz
         e7+8vk0hCB0BrS/+8hdqegFmafRNucscEpjCrFXYKwlGUHGKFnYxkthXb3+PrE82o9mw
         gjkA==
X-Gm-Message-State: AOJu0YwieJPPGjDR2sCreqRUBub1mIcdBRy//n7DmKbLI9MSrrN0jcwR
	gvw5OkgjYx39P1k5cUKfkRfH81e66HZB77Kk7kzwQTD+OE8ZSaChwaRBSPl+GEb1v3xGKEUkUO1
	lqh0R9rU6DwV+EvW5r/D3IuZlhD8mbQ==
X-Gm-Gg: ASbGnctCkWfxo3m0NexRvJ2moJ2AoNVYF1SrQW712BI8URd3VeX/lmKsLzgPDcK2JxI
	6Ii/L1cgtaSFI94HglHC/5AypXfahA38=
X-Google-Smtp-Source: AGHT+IFFiNU/tdeD+zhVnLVWd5ky5MVpfpwc1JtIdbtTbWOPlY9hV5zVmpRC6ChfH060ea3dWBp4gqIUDmjQOysbhtw=
X-Received: by 2002:a17:906:9c0f:b0:aa5:2088:6fee with SMTP id
 a640c23a62f3a-aa63a073a03mr587585366b.26.1733591697013; Sat, 07 Dec 2024
 09:14:57 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAKAoaQk-T=yBU2jJ=E_WcSmbPPkKk78N_tkTacL7Nu=udUDNFg@mail.gmail.com>
In-Reply-To: <CAKAoaQk-T=yBU2jJ=E_WcSmbPPkKk78N_tkTacL7Nu=udUDNFg@mail.gmail.com>
From: Takeshi Nishimura <takeshi.nishimura.linux@gmail.com>
Date: Sat, 7 Dec 2024 18:14:00 +0100
Message-ID: <CALWcw=GHZe4_9BejU8xzNOcMxY42DVChcKysFfYHQns5uH238g@mail.gmail.com>
Subject: Re: [patch v2] mount.nfs: Add support for nfs://-URLs ...
To: Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 6, 2024 at 10:55=E2=80=AFPM Roland Mainz <roland.mainz@nrubsig.=
org> wrote:
>
> Hi!
>
> ----
>
> Below (also attached as
> "0001-mount.nfs4-Add-support-for-nfs-URLs_v2.patch" and available at
> https://nrubsig.kpaste.net/e8c5cb) is version 2 of the patch which
> adds support for nfs://-URLs in mount.nfs4, as alternative to the
> traditional hostname:/path+-o port=3D<tcp-port> notation.
>
> * Main advantages are:
> - Single-line notation with the familiar URL syntax, which includes
> hostname, path *AND* TCP port number (last one is a common generator
> of *PAIN* with ISPs) in ONE string
> - Support for non-ASCII mount points, e.g. paths with CJKV (Chinese,
> Japanese, ...) characters, which is typically a big problem if you try
> to transfer such mount point information across email/chat/clipboard
> etc., which tends to mangle such characters to death (e.g.
> transliteration, adding of ZWSP or just '?').

- Server
mkdir '/nfsroot11/=E3=82=A2=E3=83=BC=E3=82=AB=E3=82=A4=E3=83=96'
- Convert path at https://www.urlencoder.org/
'/nfsroot11/=E3=82=A2=E3=83=BC=E3=82=AB=E3=82=A4=E3=83=96' ---->
'/nfsroot11/%E3%82%A2%E3%83%BC%E3%82%AB%E3%82%A4%E3%83%96'
- Client
mount.nfs -o rw
'nfs://133.1.138.101//nfsroot11//%E3%82%A2%E3%83%BC%E3%82%AB%E3%82%A4%E3%83=
%96'
/mnt

Works - (=E2=97=95=E2=80=BF=E2=97=95) - =E7=B4=A0=E6=99=B4=E3=82=89=E3=81=
=97=E3=81=84

@Roland Mainz Thank you!!

> - URL parameters are supported, providing support for future extensions
> * Notes:
> - Similar support for nfs://-URLs exists in other NFSv4.*
> implementations, including Illumos, Windows ms-nfs41-client,
> sahlberg/libnfs, ...
> - This is NOT about WebNFS, this is only to use an URL representation
> to make the life of admins a LOT easier
> - Only absolute paths are supported
> - This feature will not be provided for NFSv3

NFSv3 does not do Unicode, so this is not going to work anyway

--
Internationalization&localization dev / =E5=A4=A7=E9=98=AA=E5=A4=A7=E5=AD=
=A6
Takeshi Nishimura <takeshi.nishimura.linux@gmail.com>


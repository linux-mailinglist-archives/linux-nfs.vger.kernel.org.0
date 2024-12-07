Return-Path: <linux-nfs+bounces-8413-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9468E9E8120
	for <lists+linux-nfs@lfdr.de>; Sat,  7 Dec 2024 18:06:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 548F62818F2
	for <lists+linux-nfs@lfdr.de>; Sat,  7 Dec 2024 17:06:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B50113D29A;
	Sat,  7 Dec 2024 17:06:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nTkeDBs3"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4708122C6CD
	for <linux-nfs@vger.kernel.org>; Sat,  7 Dec 2024 17:06:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733591167; cv=none; b=HJVLG6iuZ2N1rqvDV+jMcfJLcxd7rt22yWxd/ACyWZKLs81AfLeDkqOgr3qMFvtNCUafzGf+DsENxDgcfgioNpBn26oD12vBEAspe0+zQGB9+4ErWKsPM7CX6S5nfdCdIofTFt2XzvydquO6DhIRSFhPFTZV20pyGd/OV+wyHIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733591167; c=relaxed/simple;
	bh=UW0+1fL9pQcQZnalPKmE5RXmM/klfe1zPLp+HRWIuAc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=TFYPN6dCkBvJNmo45QfqTDlJ4f3VIsoNKcHZVj344TSdvvFSR8fsSkgif4HNyIC07rVAjlhlT8vkEW5+6egNWJ1yLmjtbBsf+ZdVrL9gVOW/BJRXrpEH7yGWKxJ7pWgiQb5B3NP91j3k6HHPAGcAcBLVD1kDWDzMaszj32UINAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nTkeDBs3; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-aa62f1d2b21so387952866b.1
        for <linux-nfs@vger.kernel.org>; Sat, 07 Dec 2024 09:06:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733591164; x=1734195964; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UW0+1fL9pQcQZnalPKmE5RXmM/klfe1zPLp+HRWIuAc=;
        b=nTkeDBs3jNWyo0f1zSIB/UNpOphLMP5qkZa6kVBSx20YgvHclbTnfhEjsZKOmNMYpP
         Y4xRdZjpCchGf66cj/SymESIDbnVbN8Dpt7xcrA5szqVNeXKv1QzXIkAvHLx9+e+91bw
         56jx1rFK+M8q8eMxwGXJiIbH8F0XBOi/Wj8YZGL8gkNXn6wxVIhhr5O3fDG//r0h0MSA
         70+RqtX547tpbui8t3l8VHDrobEnPxtf1lnHTV4lD4yVsCKAOYEKhXJfnkhNDFC3sHHD
         N44U5PXA1yqiNZq9PRqf/i5pWehagehLE+ralYQPSqBbDO6EKjob/M7lyidOcijwRYNz
         4TgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733591164; x=1734195964;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UW0+1fL9pQcQZnalPKmE5RXmM/klfe1zPLp+HRWIuAc=;
        b=WLWYA5SyYXefZSUQ67zNyp80lu3JKZdgm6BXKtpUoPQVDrYMyMMGJzQ0F+1l/hw44k
         ZMcD7YNPtAYa3FK5n/454dnirpW7EGRxHvChVlvor3RmbprPEFnhqux829W2lNHSMwx2
         T4n4us80nExK6u58Jsz6xg2u/88JOgK/jQM8ilRVp38XQbE3Sad7NfK5RZgfIkqX6GX1
         qE2P1WrA6xSiDCmkJkFJJPHJXXCBG7zebY4Q60jjXqQQU8E+0CT0HbGgKcLwjSdLakLw
         5akY6Z/1ZePBVAw+G3zgqmutZu4DrI11EMVzrmpSQ3UgDY7eyknofUuBwfBX91K4c4N7
         nluw==
X-Gm-Message-State: AOJu0Yw34KagICcwL3IUi3d0z6y0tLHYhzkiVRsSM+65aD9v9tvvWgiJ
	7nM2VIUfsLW3Ipbmm/mn19dIbl/h6xB/bpL71t4K4gAoLr99SGzfda6ISeF8BxO5XOD9yeGnA7w
	BpAZpxIJahoPjqT4OpVsIO1b7obk/Cg==
X-Gm-Gg: ASbGnct99M6zio5jkg6zloQzsp79WOpOZoRWMNuh/ca+O1y3Dk1AjYSgZ8iNljfKpLv
	N2irFYyKR/Ma3vwBYl4/preKv2/2vEWE=
X-Google-Smtp-Source: AGHT+IHDv0JpcafOTu1kqPt0htAEJ6Re43kh4csqlcIpckARKO4qaKzPr/FynYU271PLPk1eI37q3X0jUBQMrWEyCyY=
X-Received: by 2002:a17:906:3115:b0:a9a:c651:e7d9 with SMTP id
 a640c23a62f3a-aa63a207df3mr481362066b.46.1733591164200; Sat, 07 Dec 2024
 09:06:04 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAKAoaQmaf7d01vK4TfR+=8k4CVN-CX3ESPFh88EaxvcOAQDWtQ@mail.gmail.com>
In-Reply-To: <CAKAoaQmaf7d01vK4TfR+=8k4CVN-CX3ESPFh88EaxvcOAQDWtQ@mail.gmail.com>
From: Takeshi Nishimura <takeshi.nishimura.linux@gmail.com>
Date: Sat, 7 Dec 2024 18:05:00 +0100
Message-ID: <CALWcw=G61BP5NoFOPtYg0wm94qUARMWYRH15sasejt3cZjbtsg@mail.gmail.com>
Subject: Re: [patch] mount.nfs: Add support for nfs://-URLs ...
To: Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 6, 2024 at 12:10=E2=80=AFPM Roland Mainz <roland.mainz@nrubsig.=
org> wrote:
>
> Hi!
>
> ----
>
> Below (and also available at https://nrubsig.kpaste.net/b37) is a
> patch which adds support for nfs://-URLs in mount.nfs4, as alternative
> to the traditional hostname:/path+-o port=3D<tcp-port> notation.
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

Why wasn't this fixed earlier?

> - URL parameters are supported, providing support for future extensions
>
> * Notes:
> - Similar support for nfs://-URLs exists in other NFSv4.*
> implementations, including Illumos, Windows ms-nfs41-client,
> sahlberg/libnfs, ...

OpenText NFS Solo also uses nfs URL

> - This is NOT about WebNFS, this is only to use an URL representation
> to make the life of admins a LOT easier
> - Only absolute paths are supported
> - This feature will not be provided for NFSv3
>
> ---- snip ----
> From e7b5a3ac981727e4585288bd66d1a9b2dea045dc Mon Sep 17 00:00:00 2001
> From: Roland Mainz <roland.mainz@nrubsig.org>
> Date: Fri, 6 Dec 2024 10:58:48 +0100
> Subject: [PATCH] mount.nfs4: Add support for nfs://-URLs
>
> Add support for RFC 2224-style nfs://-URLs as alternative to the
> traditional hostname:/path+-o port=3D<tcp-port> notation,
> providing standardised, extensible, single-string, crossplatform,
> portable, Character-Encoding independent (e.g. mount point with
> Japanese, Chinese, French etc. characters) and ASCII-compatible
> descriptions of NFSv4 server resources (exports).
>
> Reviewed-by: Martin Wege <martin.l.wege@gmail.com>
> Signed-off-by: Cedric Blancher <cedric.blancher@gmail.com>
> ---

Sweet. LGTM
--=20
Internationalization&localization dev / =E5=A4=A7=E9=98=AA=E5=A4=A7=E5=AD=
=A6
Takeshi Nishimura <takeshi.nishimura.linux@gmail.com>


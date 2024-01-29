Return-Path: <linux-nfs+bounces-1546-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EF75E84052F
	for <lists+linux-nfs@lfdr.de>; Mon, 29 Jan 2024 13:42:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2D82E1C2245D
	for <lists+linux-nfs@lfdr.de>; Mon, 29 Jan 2024 12:42:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D93C4627EC;
	Mon, 29 Jan 2024 12:42:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GlsLDeyo"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22BFC627ED
	for <linux-nfs@vger.kernel.org>; Mon, 29 Jan 2024 12:42:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706532135; cv=none; b=gmvhRi/Z2/UH/q1Vp2pXZtfISVoaWwACns30KVErrWpn1aru4mSUAo02pwq/AeKhdv+sciehp7pdnFj2kjaiIORatVJ5yQ4GcbztQkK29PLzoLKM7JBEJRtY/f65K0p5hX8euiIchCaXlKBU1hTIk2AM3QlVdyTXo0KHJ2nW3aE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706532135; c=relaxed/simple;
	bh=VSP1nHVa5JhmxfrKkAApzKuUAwQn3KWRJ7+lqp6TZ3M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=pbxKsWVTsT4U/qTJUCja4nQ/cHeH9EuXZYOQAsyoc4zqd375kuWScDupLwAxeVe3LDCwEhVmxr4SS0KfeRzxG+SnWr6vd5VBPuUkBWAMu/6XAdrezO6bmY7c8zmuh6MDKkxLfHpbCBVsxjxkCa1gEhfLL5V9wbINX7aE4LCKyjg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GlsLDeyo; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-51109060d6aso1763171e87.2
        for <linux-nfs@vger.kernel.org>; Mon, 29 Jan 2024 04:42:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706532132; x=1707136932; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VSP1nHVa5JhmxfrKkAApzKuUAwQn3KWRJ7+lqp6TZ3M=;
        b=GlsLDeyo9rsKlwoorp/vjNBeh950O7h9BFzyrd+k4RViadkIb5xbRqZ28N9KSxP90o
         Ib0WFjV0Skfc0rY3+TlSrvZwmCi7m8nJbRte5+hAgAaUs+IS7BV2ugsmtlcptgMMsXWH
         2W6vr4tM2KyPXmosRi/sqlU2WWkA57QQdmtdf8yIvxH/a1YwKHCgAlPDrO9Zt2zYlUW/
         if7Ii+QE5OXi79XCb3RaaQag2ZDQ8UyP81x1XTEKlM4RWSrcGwEa5/brwHamOh2kpXeI
         iYi7UCamwHTtaZSZs4gwNvF0qYMaEyn0byby1XQYPhnkmO13fxWP8VK35dbbW8MayyVx
         obWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706532132; x=1707136932;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VSP1nHVa5JhmxfrKkAApzKuUAwQn3KWRJ7+lqp6TZ3M=;
        b=LACRwsq2g/rixwPEI/8dDcuKOOJmCvhCn5qwJFciWgZpKI0IXE2ED3W01XJYSTSnAR
         RfuLQs/kkdQ09q74YI+d80B49HLSXzycyktU0QKwFF6rSnpg8A2dJEzv8subLlcQmp88
         2x7NZcJ3FYLK9CBnTQ9G5THL8UX10DHLhI87a7c4dRtydyTzi90PSXLv4MkV6RwOoM0u
         oPW2TSHWoRExuJTDH5IMroWu22+WR3w+z1pW/yb368kcNKkP1E6/NzSuXnhPmei7gtRh
         4nyR/cdGMTlJlii5zs9vaTzKs9KcK0dwCkVLdAEST0U1MXog5wajHLWylYs0cDGejucU
         6w0A==
X-Gm-Message-State: AOJu0Yw9gYpjE1lXSOFfZGLWr5k1cspXGMXZVXyGwL5qR6R22dvwTu+p
	gRcVeNEZBCE97ICbMV0noZ3mpDKNlwmVwkf/+eL0ogE+7oEKerEYB+NJbb2k3RAcexLCEUP4BDr
	sh5zgMugqhTnuK2YODDaJbq4aDxUzD5VkuK0Tfg==
X-Google-Smtp-Source: AGHT+IHydZWbHgHt/x8jlOtMNXwskU/kEna2rGPbRkDwH4LWkkJ+3euImlI7gNW2daT0vGrdNX+/YfsTLhR+EzW1xqQ=
X-Received: by 2002:ac2:596c:0:b0:510:c7c:5a6a with SMTP id
 h12-20020ac2596c000000b005100c7c5a6amr4378100lfp.61.1706532131933; Mon, 29
 Jan 2024 04:42:11 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAKAoaQmF2_iQtSdyTvk0ayLPqSXpLt0d_NFNHUwL90hGrYRgSA@mail.gmail.com>
 <CAKAoaQnsgn+wE02qReVqq5NtwL6t-GdAkfv-EU5zoGZfQb1LjQ@mail.gmail.com> <CANH4o6P-x8ku-hrNH5Ryz++1hE35JKHPM-5WXWn5pQPC3o8gRQ@mail.gmail.com>
In-Reply-To: <CANH4o6P-x8ku-hrNH5Ryz++1hE35JKHPM-5WXWn5pQPC3o8gRQ@mail.gmail.com>
From: Dan Shelton <dan.f.shelton@gmail.com>
Date: Mon, 29 Jan 2024 13:42:00 +0100
Message-ID: <CAAvCNcBmg4Fp2CBD-XEUbAe+48m4UgevKCmgEs5B0He8chRf4A@mail.gmail.com>
Subject: Re: [Ms-nfs41-client-devel] NFSv4.1 filesystem client Windows driver
 binaries for Windows 10/11 for testing, 2024-01-28 ...
To: Martin Wege <martin.l.wege@gmail.com>, 
	Linux NFS Mailing List <linux-nfs@vger.kernel.org>, ms-nfs41-client-devel@lists.sourceforge.net
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 29 Jan 2024 at 10:10, Martin Wege <martin.l.wege@gmail.com> wrote:
>
> Hello,
>
> Please test the binaries
>
> Thanks,
> Martin
>
> ---------- Forwarded message ---------
> From: Roland Mainz <roland.mainz@nrubsig.org>
> Date: Sun, Jan 28, 2024 at 11:54=E2=80=AFPM
> Subject: [Ms-nfs41-client-devel] NFSv4.1 filesystem client Windows
> driver binaries for Windows 10/11 for testing, 2024-01-28 ...
> To: <ms-nfs41-client-devel@lists.sourceforge.net>
>
>
> Hi!
>
> ----
>
> I've created a set of test binaries for the NFSv4.1 filesystem client
> driver for Windows 10/11, based on
> https://github.com/kofemann/ms-nfs41-client (commit id
> #38817b806bc146316c193954bfbfdc2209a7b3c6, git bundle in tarball), for
> testing and feedback (download URL in "Installation" section below).
>

Thank you, Roland.

Deep and long paths now work too.

Dan
--=20
Dan Shelton - Cluster Specialist Win/Lin/Bsd


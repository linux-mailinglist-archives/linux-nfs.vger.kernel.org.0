Return-Path: <linux-nfs+bounces-1578-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E4B7A841718
	for <lists+linux-nfs@lfdr.de>; Tue, 30 Jan 2024 00:44:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 242221C22654
	for <lists+linux-nfs@lfdr.de>; Mon, 29 Jan 2024 23:44:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DF142C6B0;
	Mon, 29 Jan 2024 23:44:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lCuVv0o6"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-oa1-f49.google.com (mail-oa1-f49.google.com [209.85.160.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8481524B1
	for <linux-nfs@vger.kernel.org>; Mon, 29 Jan 2024 23:44:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706571846; cv=none; b=rw6az6geMuj5SC22loAUE0itB4k8USVXWV1XB7JFN3jYC3AtuTMUzgcNyOUmgdFlo60DnCo8m9F9IeyCjxb1aLHaNUEBca8R/IuIi/85glaUMulgAsimq6L3PNXR3eR37uq7YCr+FWRCwrr9lYYh42drMt/3DafULqr1Enx9KX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706571846; c=relaxed/simple;
	bh=e/2zq2YgW9d2S1QVFWfVL68QjukxEMdAqXIYvUeyDak=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=VkXfsB3fiOPnvaXYbFRrSICJ5TF30wiaBDBh1XT5DN0+/jGPADpFFhjmQTkIk09uArfmJokqc28keI2jrKwXeK08N65nSpFFvRiTfzrCiopeME4bTVcuJ3JKzD0kNRRTMkbellVQ4uUcIXQElT8pGiT5n5ZAAsFyjfyDiF8g+DA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lCuVv0o6; arc=none smtp.client-ip=209.85.160.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f49.google.com with SMTP id 586e51a60fabf-21460195d11so2242441fac.2
        for <linux-nfs@vger.kernel.org>; Mon, 29 Jan 2024 15:44:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706571843; x=1707176643; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e/2zq2YgW9d2S1QVFWfVL68QjukxEMdAqXIYvUeyDak=;
        b=lCuVv0o6Qz9imKLcf5G4OaVdQzp8fyq+ffKCnnayOXrMnv5JDL2wJo2Z29fIM/sYAy
         skmvoNY/A9OxFVACdzfsMmAWTwVg+eEtjcmQSdxupA1GIJl3OyMU+xGwDZr+PqjT1Fmu
         cIk77+Bw48e6EdXYw1HvN55xnvd99ieR3YaBjLe0lbgTdDxTtS6E1hIvisg8Kcw15IzM
         1Ln1IuvcNXKBbgralexEnSt68TT4lfFTlxRgeCMsvWviqk2zg58d+ruyBHSKEObjoPeR
         /5BRxPezT3DND3L6OXMDw/AbF3qYH2RRp3Nr2TXaaEaALICbWAlWr9ZviAhUeMjMRp5r
         13HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706571843; x=1707176643;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=e/2zq2YgW9d2S1QVFWfVL68QjukxEMdAqXIYvUeyDak=;
        b=bGUaXhKtpmliovtYNOzvnt3aap3oubXaFujn7XAWHeR7yvL+gE/tcnEZ2kBOh90ihS
         hOY20/s1DmToAtRWyNdcssfQ/mFwCzOGm4zNHYwnJOveOAPSIPdNThqHtbxs8fo8EiVB
         jLHUVCqN4Z5FPoV7zDcGxGG8pa+a+VMEPu4n2FQqEF544J7rDPuY+TX5ViBy0hzKOATc
         L9Xu3x3FA9e7WIWf42iOGloDR13Iv9wMHSMC9SzwKoWaqsQfldinVfaLZ+TDu4Dii4Fj
         tzOUM31gKiMa5rwYE0wFA1M5rm7JEMHDjoPBLbJcLHGj2yiWdzdoMEZYhj7qwFk4kJWQ
         kMiw==
X-Gm-Message-State: AOJu0YxbzhC8zwrS7stZ6Z58Z9oYNHCWPXgOVEt73H6Ie7eZD1uuQdCf
	7hzcOgct7i/OsPDhcFbH3iJQVvCIHdaH85Vcxy0LgL1rA0Q6s5swc81TV0YCO+kWPd4Udi/LsPF
	HMaWph7iyxyNVZBQ8bgioQonRJ3JcygKI
X-Google-Smtp-Source: AGHT+IGNZxlaurySYWTCzdCWupeog8sU569k+NsGYtV5Qmw/yWEXLs3hFnqbKiXh0QWPFHFbv7yDHXJWBSpRaxSf0x0=
X-Received: by 2002:a05:6870:d8cc:b0:218:550b:d6a with SMTP id
 of12-20020a056870d8cc00b00218550b0d6amr5922985oac.48.1706571843641; Mon, 29
 Jan 2024 15:44:03 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CANH4o6MqecahkZj3i4YwS1UQjQimFrDcbM8abCbrGiLyk9ZTkg@mail.gmail.com>
 <CANH4o6Na-KPweTmeUAiU9sK4OGt8RkkZU+vK5xpEe-BrP-s_Bg@mail.gmail.com>
 <761568108.788363.1700121338355.JavaMail.zimbra@desy.de> <CANH4o6MbXf1vehqa4VSUc6VhJbb_pVH71M+ovFSWV7kz4j0Pmw@mail.gmail.com>
In-Reply-To: <CANH4o6MbXf1vehqa4VSUc6VhJbb_pVH71M+ovFSWV7kz4j0Pmw@mail.gmail.com>
From: Martin Wege <martin.l.wege@gmail.com>
Date: Tue, 30 Jan 2024 00:43:51 +0100
Message-ID: <CANH4o6PxoQEk3SFvRDa+BqpKXFUW6cPC9Jcuf886Ntxqmorbmw@mail.gmail.com>
Subject: Re: Filesystem test suite for NFSv4?
To: Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 16, 2023 at 10:26=E2=80=AFPM Martin Wege <martin.l.wege@gmail.c=
om> wrote:
>
> On Thu, Nov 16, 2023 at 8:55=E2=80=AFAM Mkrtchyan, Tigran
> <tigran.mkrtchyan@desy.de> wrote:
> >
> >
> > What do you want to test?
>
> Filesystem tests, from POSIX layer. open(), close(), mmap(), write(),
> read(), SEEK_HOLE, SEEK_DATA
>
> > Protocol-level test can be performed with pynfs:
> >
> > https://git.linux-nfs.org/?p=3Dcdmackay/pynfs.git;a=3Dsummary
> >
> > IO bandwidth and latency tests can be performed ior or fio.
>
> Is this a test for the NFS server, or NFS client?
>
> Thanks,
> Martin

?


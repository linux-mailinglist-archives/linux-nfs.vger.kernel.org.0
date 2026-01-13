Return-Path: <linux-nfs+bounces-17806-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id DC30BD1A69E
	for <lists+linux-nfs@lfdr.de>; Tue, 13 Jan 2026 17:52:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 426C13008145
	for <lists+linux-nfs@lfdr.de>; Tue, 13 Jan 2026 16:51:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1A3A34D938;
	Tue, 13 Jan 2026 16:51:46 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-ot1-f41.google.com (mail-ot1-f41.google.com [209.85.210.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CC6533CE86
	for <linux-nfs@vger.kernel.org>; Tue, 13 Jan 2026 16:51:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768323106; cv=none; b=ts51ssv1wviAi1HPeV0JBqT0mLdM6+fDsCozLCS9lDHEN7TasMTT2LgCdcGw8pda/vU+cEb7hm2iKrOLt5rT9zuIdj/ohm8PNg1GtZb/MMbBZe+RlkI4ulOcVRmIPaj6plPfMYaLNtNbJE4tMpi4PqEtGtg76FUc4Etxr6G+BRs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768323106; c=relaxed/simple;
	bh=Hm+hFkCxE6lVbQx4eQObQxXAcvrq9lVQw90Wa4bRafg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AF7BzOG5rUDtB5zwZ8ucPwnsHm0tLtBHPJt/O6vYBM/tg8yP9Tzon/MaLYl2kDjCZxPSGa77CE0EIzUls4mji8sdf5Z68VnL97DF9YkcBNCe5OEtkLogJeIWhDiT6fV5VXep5zyWbH0lPbUG9q4Hc7ME92coIoZuxDJxJkAYMPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gompa.dev; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.210.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gompa.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f41.google.com with SMTP id 46e09a7af769-7cfb21a52a8so1494476a34.2
        for <linux-nfs@vger.kernel.org>; Tue, 13 Jan 2026 08:51:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768323104; x=1768927904;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=gc7yqO7D0eseyKYDyefBFLldfXSHU35zlyHiXIvs8J4=;
        b=xS8TQm5qK6j00xn+/IuMkWFodK6eIsvYv6mEmUnTcRREOk1TZ/FsjHVrxWCKoenFPr
         NU4ZvL1KH7KytBdEDymFFDFnBOhhAgnJt+9EDYK1g0ecpc2CsvJ0rDmIBc4RsEA9aVxj
         +JwmzFgi3tFSheLnCd0RSEMnwOKJIb0eNaJb1bRhUcukm+c2KpbOGqqHGUtErKAq6lhD
         nCsLqYkKYBvPQOBHXYAem+rIX6TuWI4heuLtQSIc0g90J/QvfLNPpgEaMWjA8OdmfXRQ
         YFOLsIrOlD2zk5LS9Rw8Hxm9p0nEF4imkUTTOoeE/h3OcXndNX8bTgS5OLn5Eub4F2AE
         6JlQ==
X-Forwarded-Encrypted: i=1; AJvYcCWCp+zEKdo9j9jMyWWS9cDKocpbmWhSlD/h3XWbLaQpzESbh/lgdruxQ1Xaud2RkF7ymV7Bcpkgrp0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzRNz47ISjHPapfd5c7ZPDNeMiUk1gnL0rZs4Pk98MgbLAJMu5B
	Xt9b7fpN5bDP/LbpEhZyAqhN3baSLnJpb2DhuQhnxJkG7Y7+8zzeS5UwzFSHOg==
X-Gm-Gg: AY/fxX7v1Bws/NZ+NCr87BvqxMYY2oplc7YA+6/e6uGOC2D95tAltzNYOrE0hwVk7fW
	WpEYbuED67RSHc4HkFuiKFUq2f4frl30D3usMUP4PyB7dzGo7JHqkAG74+LdCqn+uawRhn6x7+Z
	3akuVZ7ztsegbiQz+DdsPJ00EZZt3R/I2YY7BvrEmnS+iz7NPoMd2h+gVNSC0s0YaQDeD5+GXTK
	EeQImOzf2xQC9BZGd3aLollzJgJ2uVKHuwk2hyS2V32aN/+htbOIvsuEMbRj5xTwKPAH0Wv0K+C
	bxq+x9VXs2HjMdCs270gbSobYPP/5tI70ia/XF4oKFYkDbUIVrUSFleE1+2jIpoXlpC11kWPj+B
	GUrJjzD5VSQ3FJbUR/rEsKmr60cSdq/i+zw4fQIQV9Td4cZC1ltKGGn7gzjX+4BZnwe0NKCjXfE
	hFJU7f5nZqVGEMtPxmJJk/GsmRWPYa03UDnpho1hLBjJAWADDyzwUQp6sjAFEXpj0RwbYTWE6d
X-Google-Smtp-Source: AGHT+IEbTu1pKr+FF+9S7Jnjn2Vrn9Yg1KrndrjtnD1QKwbTDF9/aQBTjkB8haRBbCJpxuuUB7jTRw==
X-Received: by 2002:a05:6830:3116:b0:7c7:4bd:d527 with SMTP id 46e09a7af769-7ce50a29cd7mr10547341a34.21.1768323104359;
        Tue, 13 Jan 2026 08:51:44 -0800 (PST)
Received: from mail-oa1-f49.google.com (mail-oa1-f49.google.com. [209.85.160.49])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7cfb21a150asm5203509a34.31.2026.01.13.08.51.44
        for <linux-nfs@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Jan 2026 08:51:44 -0800 (PST)
Received: by mail-oa1-f49.google.com with SMTP id 586e51a60fabf-3ec4d494383so5593368fac.3
        for <linux-nfs@vger.kernel.org>; Tue, 13 Jan 2026 08:51:44 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXr9yNhsiWQYuSkEHltNL2qTROpCSSpluP6oEqxyPL3EMW712NmT7SRbolxlmzp7TYW+iz+a8DiDrA=@vger.kernel.org
X-Received: by 2002:a05:6830:2e04:b0:7bb:7a28:51ba with SMTP id
 46e09a7af769-7ce50a6def5mr10521137a34.26.1768322616531; Tue, 13 Jan 2026
 08:43:36 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260112174629.3729358-1-cel@kernel.org> <20260112174629.3729358-9-cel@kernel.org>
 <20260113160223.GA15522@frogsfrogsfrogs>
In-Reply-To: <20260113160223.GA15522@frogsfrogsfrogs>
From: Neal Gompa <neal@gompa.dev>
Date: Tue, 13 Jan 2026 11:43:00 -0500
X-Gmail-Original-Message-ID: <CAEg-Je8LGZGGAQ3XLMQg8=XmJjvvJNShT3zkE-o2t2fv=VGeHw@mail.gmail.com>
X-Gm-Features: AZwV_QiAh8VN4kaDD2E2Q52MaqDS5cW88U1qWaL9kDfC-E_siYu-7adEi4A7eM4
Message-ID: <CAEg-Je8LGZGGAQ3XLMQg8=XmJjvvJNShT3zkE-o2t2fv=VGeHw@mail.gmail.com>
Subject: Re: [PATCH v3 08/16] xfs: Report case sensitivity in fileattr_get
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: Chuck Lever <cel@kernel.org>, vira@web.codeaurora.org, 
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org, 
	linux-ext4@vger.kernel.org, linux-xfs@vger.kernel.org, 
	linux-cifs@vger.kernel.org, linux-nfs@vger.kernel.org, 
	linux-f2fs-devel@lists.sourceforge.net, hirofumi@mail.parknet.co.jp, 
	linkinjeon@kernel.org, sj1557.seo@samsung.com, yuezhang.mo@sony.com, 
	almaz.alexandrovich@paragon-software.com, slava@dubeyko.com, 
	glaubitz@physik.fu-berlin.de, frank.li@vivo.com, tytso@mit.edu, 
	adilger.kernel@dilger.ca, cem@kernel.org, sfrench@samba.org, pc@manguebit.org, 
	ronniesahlberg@gmail.com, sprasad@microsoft.com, trondmy@kernel.org, 
	anna@kernel.org, jaegeuk@kernel.org, chao@kernel.org, hansg@kernel.org, 
	senozhatsky@chromium.org, Chuck Lever <chuck.lever@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 13, 2026 at 11:02=E2=80=AFAM Darrick J. Wong <djwong@kernel.org=
> wrote:
>
> On Mon, Jan 12, 2026 at 12:46:21PM -0500, Chuck Lever wrote:
> > From: Chuck Lever <chuck.lever@oracle.com>
> >
> > Upper layers such as NFSD need to query whether a filesystem is
> > case-sensitive. Populate the case_insensitive and case_preserving
> > fields in xfs_fileattr_get(). XFS always preserves case. XFS is
> > case-sensitive by default, but supports ASCII case-insensitive
> > lookups when formatted with the ASCIICI feature flag.
> >
> > Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
>
> Well as a pure binary statement of xfs' capabilities, this is correct so:
> Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>
>
> [add ngompa]
>
> But the next obvious question I would have as a userspace programmer is
> "case insensitive how, exactly?", which was the topic of the previous
> revision.  Somewhere out there there's a program / emulation layer that
> will want to know the exact transformation when doing a non-memcmp
> lookup.  Probably Winderz casefolding has behaved differently every
> release since the start of NTFS, etc.
>

NTFS itself is case preserving and has a namespace for Win32k entries
(case-insensitive) and SFU/SUA/LXSS entries (case-sensitive). I'm not
entirely certain of the nature of *how* those entries are managed, but
I *believe* it's from the personalities themselves.

> I don't know how to solve that, other than the fs compiles its
> case-flattening code into a bpf program and exports that where someone
> can read() it and run/analyze/reverse engineer it.  But ugh, Linus is
> right that this area is a mess. :/
>

The biggie is that it has to be NLS aware. That's where it gets
complicated since there are different case rules for different
languages.



--=20
=E7=9C=9F=E5=AE=9F=E3=81=AF=E3=81=84=E3=81=A4=E3=82=82=E4=B8=80=E3=81=A4=EF=
=BC=81/ Always, there's only one truth!


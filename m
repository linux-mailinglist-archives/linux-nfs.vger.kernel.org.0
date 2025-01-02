Return-Path: <linux-nfs+bounces-8876-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E3379FFB13
	for <lists+linux-nfs@lfdr.de>; Thu,  2 Jan 2025 16:40:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 23BA7160F94
	for <lists+linux-nfs@lfdr.de>; Thu,  2 Jan 2025 15:40:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B95DA189B8D;
	Thu,  2 Jan 2025 15:40:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SS2Cix3u"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F007279D2
	for <linux-nfs@vger.kernel.org>; Thu,  2 Jan 2025 15:40:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735832446; cv=none; b=MmNJ1cTGvDkmo2jDuAxEH99Z5zTOicA4zWgHq6brK/0W9J7e3sv9rO3vGpLN3zg8wOuE7UiVWAIaIQC1rAGX2U3/LfQoxbIHY7DgiAomTto6X/PDZP7I7pGLIsjkdO9+QbAHgoXqHY/HEov7np0zww6phV2traQlrjOMui67qvs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735832446; c=relaxed/simple;
	bh=FId2TLedXnMU1iDtnwP7giG71xlXVE0XJsqLvFGQvKw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VCZEFst8unc+mNvtWFBbsKalkO2fhIjRQOlYYyMiyHIjlIme9Rh0Q2TQftyzgyhWjjoi/RNWB0X0eDr2utc6ReYbJMt3AI2vWu2DlEBV3EeymQyFboOoNZUyHGH2vH5fSv4/Lp1KW9OotBWbHlHlYU/dQ7FlFD4oIGasGmV5TAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SS2Cix3u; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-5d647d5df90so4410078a12.2
        for <linux-nfs@vger.kernel.org>; Thu, 02 Jan 2025 07:40:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1735832443; x=1736437243; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FId2TLedXnMU1iDtnwP7giG71xlXVE0XJsqLvFGQvKw=;
        b=SS2Cix3uO38//q3EBhHyOXoVsHYvYK/cfLH1FVYaNcWfGCZsytpkxdl658FUckscPB
         btjpvZptxwhd1uxPP1+g6b7TBTV+xTY3xW+6YGM2HtcZBY8cjoKW2dwQrbxcNe6IlGOA
         dULkGRImN/83aIDNnBiKBhJFJU3ZcGWcJ6WBTEuaQpmBkF4jJMp3850BKUfrdFLjM2eE
         r+RCNj2tzYm2xAl1gThB9UTmDMVpp8sLZLsYcBnWUFCFQ1qkZJQ8oBgzsWtGVmfWdbTt
         TDkXugMIm69y4GgLV9ZVJMYcSlc351FtgbuBfjY6Be6QCfSCc8BPbSSvZxpbokDj4+1y
         xelQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735832443; x=1736437243;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FId2TLedXnMU1iDtnwP7giG71xlXVE0XJsqLvFGQvKw=;
        b=K8TI2oaNO++SWkgZlZOExdEJvb9K3CPMFJ5qSIfNWNjcSwEyihENFHq5L27Nwyzy5i
         UdDt41lAok5hMTsoMDbRDsihteUPZCxEAGOv70UU3AY3jr223v1dYvnmlO8CILrg8MHI
         wGDv4bBzpvSK6uHnAtx2vfdwNIgwxqH5LfgJ2JrBToAlz8E8O1ijoApyLME2NDdKx8Hh
         BSnf0NEk1IHEBuEU6hLwScPpyszz2fnoFcf2sAm3UqyY5e2ty81rlYZeT50FJLzoKZd2
         5Ru061E+Fxx7yRxG5HTxfy9ivAlaLP+p+BsiMSID9L8hgPdAKJcG0FaWBxKTcC3jndU/
         ihaA==
X-Forwarded-Encrypted: i=1; AJvYcCVMeogzFm8Z2adRJaBYhTzTHXNwDm1Qo1cu46II7r+aHvWmlx7fXVbraxlO+6xh42CXqaxhVwYBH+g=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxz3Wvn+K9Ta47TXvV7MT4zdd9nfuPFLNNZgDsWAd3JQmPPsxQR
	YgKIu8w5FqUGGnDO9DQYv5uCjayxVIzURgCuXcOxgbp/MkaJ3jdHOfYjwMh5uCJdzf9th0PBTQb
	VxiIKLxxhU//00kbgUInczWGIxg==
X-Gm-Gg: ASbGncsJ8jeRgjVDGk6MtgtHTu74+7mdc822/uejCBH+hgqoaVzyQAOLysjyPo5GO3/
	r5KmKICgKaNOUhTp22KKS+xkIJ7Lf8dmTD3Am4S5zu6KdfAYtKRTORTrn3UPTXEMguJFgSA==
X-Google-Smtp-Source: AGHT+IExGLqBOODWVwB/z3nB7/Jy2IZhZOm0aG98ZwxJDY1GTYJxm8NUHztX1mkSvzhhy6AnlV87uriYJAxqU93twL0=
X-Received: by 2002:a50:cb8c:0:b0:5d9:a62:33e with SMTP id 4fb4d7f45d1cf-5d90a62038bmr1329667a12.15.1735832442838;
 Thu, 02 Jan 2025 07:40:42 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAFEWm5DTvUucAps=SamE5OVs0uYX5n4trFf5PBasBOFbEFWAfA@mail.gmail.com>
 <e52500f98a7153822a6165d26dcf66c3d352129b.camel@kernel.org>
In-Reply-To: <e52500f98a7153822a6165d26dcf66c3d352129b.camel@kernel.org>
From: Rick Macklem <rick.macklem@gmail.com>
Date: Thu, 2 Jan 2025 07:40:32 -0800
Message-ID: <CAM5tNy7ghT0X7N6VmhRbA3ra5ThcEuuOO8+YgSdKSm3BOtSrbQ@mail.gmail.com>
Subject: Re: Write delegation stateid permission checks
To: Jeff Layton <jlayton@kernel.org>
Cc: Shaul Tamari <shaul.tamari@vastdata.com>, linux-nfs@vger.kernel.org, 
	Sagi Grimberg <sagi@grimberg.me>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 2, 2025 at 5:41=E2=80=AFAM Jeff Layton <jlayton@kernel.org> wro=
te:
>
> On Thu, 2025-01-02 at 11:08 +0200, Shaul Tamari wrote:
> > Hi,
> >
> > I have a question regarding NFS4.1 write delegation stateid permission =
checks.
> >
> > Is there a difference in how a server should check permissions for a
> > write delegation stateid that was given when the file was opened with:
> > 1. OPEN4_SHARE_ACCESS_BOTH
> > 2. OPEN4_SHARE_ACCESS_WRITE
> >
>
> (cc'ing Sagi since he was looking at this recently)
>
> A write delegation really should have been called a read-write
> delegation, because the server has to allow the client to do reads as
> well, if you hold one.
My interpretation for "write" is that it was a synonym for "exclusive".

>
> The Linux kernel nfs server doesn't currently give out delegations to
> OPEN4_SHARE_ACCESS_WRITE-only opens for this reason. You have to
> request BOTH in order to get one, because a permission check for write
> is not sufficient to allow you to read as well.
I'll admit my interpretation has always been somewhat different.
My version is that a delegation allows a client to do Opens locally,
but does not infer permissions for any given user.

A Jeff notes at the end of his post, a client must do a ACCESS
operation to check for permissions during Opens unless the ACE
in the write delegation reply allows access.

Given the above, a server's decision to issue a write delegation
is orthogonal to file permissions, except for what it returns in the ACE, i=
mho.

>
>
> > Should the server check permissions for read access as well when
> > OPEN4_SHARE_ACCESS_WRITE is requested and DELEGATION_WRITE is granted
> > ?
> >
>
> Possibly? When trying to grant a write delegation, the server should
> probably also do an opportunistic permission check for read as well,
> and only grant the delegation if that passes. If it fails, you could
> still allow the open and just not grant the delegation.
My interpretation is that the server can choose to (or choose not to)
issue a delegation for any file. The only requirement is a working
callback path. The WANT_xxx flags are just hints from the client.

Although it might not make much sense, a server can even issue
a write delegation for a file that is r--r--r--.

Again, this is my interpretation of the RFCs.

>
> ISTR that Sagi may have tried this approach though and there was a
> problem with it?
>
> > or there is an assumption that the client will query the server for
> > read access permissions ?
> >
>
> The client should always do an ACCESS call to test permissions unless
> the user's access matches the ACE that gets sent along with the
> delegation.
Yes, and this is why a write delegation can be issued whenever the server
feels like doing so.

rick

> --
> Jeff Layton <jlayton@kernel.org>
>


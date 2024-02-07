Return-Path: <linux-nfs+bounces-1825-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A8B7F84D266
	for <lists+linux-nfs@lfdr.de>; Wed,  7 Feb 2024 20:51:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 33FA21F230A1
	for <lists+linux-nfs@lfdr.de>; Wed,  7 Feb 2024 19:51:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A12185943;
	Wed,  7 Feb 2024 19:51:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OqqFz3vz"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BC9882C64
	for <linux-nfs@vger.kernel.org>; Wed,  7 Feb 2024 19:51:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707335482; cv=none; b=io/yOcP7cELK3ICtXjyFf92fvwiQDxlwCFvWHbqILPnpbDm50/xmfE6HBwFch9Ee8njwYiPhDOIudJ4IqG832zuOQnDqoBGK2vlvA5DRxFyJhWSXhqCkrYZ1PzHHLFD+FIa+pb7gvKs4y3HIu5FDShftTi78x1O5/lw1tq1v+3Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707335482; c=relaxed/simple;
	bh=fAs2n3ub1kwPrYCKODqOz3Vzd3O25+jhYcabZ2xg4wA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jOJELwK+aCVWwEpUymEcjyzCadmwuGWXNficsdwkPHeToT9dXVxsISrIPU4CrXNTsJ0QtqSVL3XTvJ02TvHLXYGG56niqHjLNEgQdNEvMCSQtk9dDak03fO0AnLnE46s8bKQire2AZZFopF1pM5XUGZvzRnwZj4rmJ11Pc6NxUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OqqFz3vz; arc=none smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-2d0438dfd67so1877801fa.1
        for <linux-nfs@vger.kernel.org>; Wed, 07 Feb 2024 11:51:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707335478; x=1707940278; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t2rUIzopR2iZjt/u0+LDIGnggQrzGcTFMClPiJwrIE0=;
        b=OqqFz3vzYEq1LSM70801Cw9KusD6eNY31Hdwd/umVxsq5Dn/T0aDrNmRyq9DOE53xS
         W9l4XFvC4iJpd9MCxYr06jBDXPjc+JeDdd5+eAFqgcFPjheIELidQLJGXgkzS6RIVgy4
         kFoUGMVuSWBYoy10ALci5PagRPo5qUYFM8YvUPI1RCa2sHDIfpvpOwMs134QNGOLb47C
         YL28dsKSR0oQ9UX9sSl7v7qLl4iMoW8QEBaS6hsL5xAoi0nzWhc9fF8zz2sOWD5qd7rS
         xQOa++3czJ/dJN8KtkhPCmiXMl0QFsZCvoKW2Q+IqEULukVPqbrhhhnF4iWP+gFQAXSF
         +ymg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707335478; x=1707940278;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=t2rUIzopR2iZjt/u0+LDIGnggQrzGcTFMClPiJwrIE0=;
        b=W+sSkjySlTrpW60RRjgbhzkUlT8h9FnG4ExHVQbLN+4uB5Ql8wd1N19Rrh99OByVvb
         AIsy/mgLFmzJnXFVYU8OL/ypRqdIaXykVMfokN6VriE7puZCYbxo/tzt/0bPrnQ4PcCz
         dHuu3PcN6dil+IwIUe42DvQBeyyCxYwlDPDqQaQaESV1b0WX7B/J/f6eV+7UHxkpV135
         atPzCH/yglDmxv/NiiIGJMs9G2rrdRDtS93OR8JP2lhAAFz/Dxnd1InFugZPfcBuHm7c
         rFstMoc03s0XHFZ9j31VzA41F420yFIP88u2ZG3Di8q/wlBcAuhAOg7UmSpdDdvshorj
         u9xA==
X-Forwarded-Encrypted: i=1; AJvYcCXuMpk7c+/F/3PopcVt3AN0KM5caVkw+Co8QaTpAEPJ8qxRRxgka1qoi+4iajBilUsHj8E/weiCtLsWukf8iYU4QO2uMALlY980
X-Gm-Message-State: AOJu0YyXSbMtWTxrXvlFlkhzV5b+d+bVnTM1R/ZuOHToqmnW7Lgz0PSw
	IQUyKIyi9oPbvF2oFwUlYMAXE1Ai5jJ5CrO7oCmzDg0cZRleVgBSFApBjAsVtnPoi92a4689TTK
	k4jcJa72qxkix4o5VelGhtXgCZaE=
X-Google-Smtp-Source: AGHT+IFKu7cTtO/P7hEJuwIkMdTtEaH3R+KQf3yx2PuLLXEsvkimFWMEvmBZzIYuTbNrBSBXvVNvv96re2QfJQYn2Pc=
X-Received: by 2002:a2e:920a:0:b0:2d0:97e1:6194 with SMTP id
 k10-20020a2e920a000000b002d097e16194mr4227626ljg.3.1707335478056; Wed, 07 Feb
 2024 11:51:18 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240207182912.30981-1-olga.kornievskaia@gmail.com> <be83ac24a9d17fc78590d4b182afd3f4e6c1e8a7.camel@hammerspace.com>
In-Reply-To: <be83ac24a9d17fc78590d4b182afd3f4e6c1e8a7.camel@hammerspace.com>
From: Olga Kornievskaia <olga.kornievskaia@gmail.com>
Date: Wed, 7 Feb 2024 14:51:05 -0500
Message-ID: <CAN-5tyFTx4bUvuF627E_2x9Kw2h9tccqU-7KfCtJHyFazTTLYg@mail.gmail.com>
Subject: Re: [PATCH 1/1] NFSv4.1/pnfs: error gracefully on partial pnfs layout
To: Trond Myklebust <trondmy@hammerspace.com>
Cc: "anna.schumaker@netapp.com" <anna.schumaker@netapp.com>, 
	"linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 7, 2024 at 2:12=E2=80=AFPM Trond Myklebust <trondmy@hammerspace=
.com> wrote:
>
> On Wed, 2024-02-07 at 13:29 -0500, Olga Kornievskaia wrote:
> > From: Olga Kornievskaia <kolga@netapp.com>
> >
> > Currently, if the server returns a partial layout, the client gets
> > stuck asking for a layout indefinitely. Until we add support for
> > partial layouts, treat partial layout as layout unavailable error.
> >
> > Signed-off-by: Olga Kornievskaia <kolga@netapp.com>
> > ---
> >  fs/nfs/nfs4proc.c | 6 ++++++
> >  1 file changed, 6 insertions(+)
> >
> > diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
> > index dae4c1b6cc1c..108bc7f3e8c2 100644
> > --- a/fs/nfs/nfs4proc.c
> > +++ b/fs/nfs/nfs4proc.c
> > @@ -9790,6 +9790,12 @@ nfs4_proc_layoutget(struct nfs4_layoutget
> > *lgp,
> >       if (status !=3D 0)
> >               goto out;
> >
> > +     /* Since client does not support partial pnfs layout, then
> > treat
> > +      * getting a partial layout as LAYOUTUNAVAILABLE error
> > +      */
> > +     if (lgp->args.range.length !=3D lgp->res.range.length)
> > +             task->tk_status =3D -NFS4ERR_LAYOUTUNAVAILABLE;
>
>
> I think this case is better handled by allowing the caller to set lgp-
> >args.minlength to an appropriate minimum value.

I do not understand what this suggestion means. What I can think of is
that the caller would set an appropriate minimum value and the code
here would check that the result is at least as large?

If so, can you explain why that's more desirable? Seems to me it'd be
more lines for something that would be removed later?

>
> > +
> >       if (task->tk_status < 0) {
> >               exception->retry =3D 1;
> >               status =3D nfs4_layoutget_handle_exception(task, lgp,
> > exception);
>
> --
> Trond Myklebust
> Linux NFS client maintainer, Hammerspace
> trond.myklebust@hammerspace.com
>
>


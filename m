Return-Path: <linux-nfs+bounces-4743-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D5F6C92AADB
	for <lists+linux-nfs@lfdr.de>; Mon,  8 Jul 2024 23:02:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 811FA1F227C9
	for <lists+linux-nfs@lfdr.de>; Mon,  8 Jul 2024 21:02:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BB9E14EC41;
	Mon,  8 Jul 2024 21:02:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jgcDs360"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-oa1-f54.google.com (mail-oa1-f54.google.com [209.85.160.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84EA2748A
	for <linux-nfs@vger.kernel.org>; Mon,  8 Jul 2024 21:02:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720472538; cv=none; b=CObutu8IEOi8WLPpblfo4j8DqBJbxj9yTdouP4tEJ1V/TrfdWH9KcqmvPAv1eqvFBtHNCKdcFzhkUtn4LyrO6KGn07spAnMj9IWEjV9mPq8POzlTmM+9XitGpib4F3IQusZiGrEpVOR1m9W9tONDxjoqq4OdNg8CMrKtWj0KMas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720472538; c=relaxed/simple;
	bh=IQ3ZJse1pkOqZRaPY0Ll0AdXMEVn/CT1FX9Gd0q2vKc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=GfW/3seqqvX61h7PTW9FmTAoyetckCywe/E+XvVT6zJyvad4WYuXYwgciRlXW0iBgmt7YTDvwGP8UxkGpjUkqUFTr2t8s8T2weF8v1sDU58GoSdJjJ+aGFImNiX8rsBkt2QVBkFXp5efcYkyvpuDLorhhLvOdsTSbOYlh/SVVeE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jgcDs360; arc=none smtp.client-ip=209.85.160.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f54.google.com with SMTP id 586e51a60fabf-25e3bc751daso2405799fac.3
        for <linux-nfs@vger.kernel.org>; Mon, 08 Jul 2024 14:02:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720472535; x=1721077335; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=L9QtyVkg3va0hVKWgHBNyJmqCcbJ0QgCPU1lzsDKnTU=;
        b=jgcDs360QEL85t4v4kyn6JFJ/wMLPIWrPkqzzFnihPkpC4OFovlkwhNYdvCiHgdcUJ
         iNgXilwh6fpZFwp+rJE9yOfjzspJRZ+Tim9ml7iMXnTd/dgOV9Kdfdk4qTMhQGGYsDMO
         ohVZ6zhvK2ghDh1FYV1z8zzWITOeA9Ojj+OMvx83azKk/5OMt0Xs720At/0YMFJaYRVq
         F+LZKO6sSKpidBsv/rJ4Gt3uCaXVHP5LFYDHO3FMQ0XgTpj97DJ1q2N3H0B4kQvUwnZA
         YYDxrUtjxqsPWMZagL0LannfZcY1OTs9MzthGIzHloMCcwpwCzQ2h4h0skLD1AvgrZpQ
         yFGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720472535; x=1721077335;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=L9QtyVkg3va0hVKWgHBNyJmqCcbJ0QgCPU1lzsDKnTU=;
        b=YAkOuOn2iciAAN8/ppOFXNfPyOPrthksAeXZtG0FivwJVz0puCi7uzhTCw7Ldnu7A0
         GZZq27nFoFl4A2OLZn2UsCJPQ8rLbNLPymKbMP/+Yb7YyYKgGwfBdxbjyTEddyzHLAw0
         HsYVkbGeqSBg5hxLJP0X4Ru/t+EhaoGuogzUp+7Ud/Fu57ouCrp0fa7jMBh/fxQnRrIA
         i8FzHQ3ebO7s9T2tq0dvjoF1xwL1twT5WizLUJqTLV81hG3ZiGBz2b1qLCV5s40wpL7a
         z7RRV96jMgKFNzf4am9rO+bxh0zpBoCoOGoSfYc0lbp55Eh2z+ENTpaDbWAJN43RELlk
         nhLg==
X-Gm-Message-State: AOJu0Yw0HBB5N/VF46A4xhIRDl03chALJM8NYeQKfKOX1Wq40qYZniwJ
	7hiPvzTgWWJL588ORJy5HyCBrvN7xelvLvZv3T5EjuA+s2kgrIbO5eH2Jzb4b3NpYniOk04QCgv
	3RizSyr9aVjeotdhbKSNyPzxnNvjb+g==
X-Google-Smtp-Source: AGHT+IHfVjemxNrLuCHb/KzdSWdxVlfzRVM41dlHj98vft01T+ajtlsS/QsarrlHbmk4RdpNuuUwKXOZD7wF9G6Se/s=
X-Received: by 2002:a05:6870:8194:b0:25d:f71b:6860 with SMTP id
 586e51a60fabf-25eaec554f6mr435410fac.55.1720472535436; Mon, 08 Jul 2024
 14:02:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240706224207.927978-1-sagi@grimberg.me> <114581777d5b61b6973ec9ef2537ee887989e197.camel@kernel.org>
 <9156BC30-78C3-4854-8BC3-510E586B4613@oracle.com>
In-Reply-To: <9156BC30-78C3-4854-8BC3-510E586B4613@oracle.com>
From: Dan Shelton <dan.f.shelton@gmail.com>
Date: Mon, 8 Jul 2024 23:01:49 +0200
Message-ID: <CAAvCNcADDowua3r2dmxPBHxrqpUdyxfjDqOpN-8hL4D6khV-fg@mail.gmail.com>
Subject: Re: [PATCH rfc] nfsd: offer write delegation for O_WRONLY opens
To: Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 8 Jul 2024 at 16:19, Chuck Lever III <chuck.lever@oracle.com> wrote=
:
>
>
>
> > On Jul 7, 2024, at 7:06=E2=80=AFAM, Jeff Layton <jlayton@kernel.org> wr=
ote:
> >
> > On Sun, 2024-07-07 at 01:42 +0300, Sagi Grimberg wrote:
> >> Many applications open files with O_WRONLY, fully intending to write
> >> into the opened file. There is no reason why these applications should
> >> not enjoy a write delegation handed to them.
> >>
> >> Cc: Dai Ngo <dai.ngo@oracle.com>
> >> Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
> >> ---
> >> Note: I couldn't find any reason to why the initial implementation cho=
se
> >> to offer write delegations only to NFS4_SHARE_ACCESS_BOTH, but it seem=
ed
> >> like an oversight to me. So I figured why not just send it out and see=
 who
> >> objects...
> >>
> >> fs/nfsd/nfs4state.c | 10 +++++-----
> >> 1 file changed, 5 insertions(+), 5 deletions(-)
> >>
> >> diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
> >> index a20c2c9d7d45..69d576b19eb6 100644
> >> --- a/fs/nfsd/nfs4state.c
> >> +++ b/fs/nfsd/nfs4state.c
> >> @@ -5784,15 +5784,15 @@ nfs4_set_delegation(struct nfsd4_open *open, s=
truct nfs4_ol_stateid *stp,
> >>  *  "An OPEN_DELEGATE_WRITE delegation allows the client to handle,
> >>  *   on its own, all opens."
> >>  *
> >> -  * Furthermore the client can use a write delegation for most READ
> >> -  * operations as well, so we require a O_RDWR file here.
> >> -  *
> >> -  * Offer a write delegation in the case of a BOTH open, and ensure
> >> -  * we get the O_RDWR descriptor.
> >> +  * Offer a write delegation in the case of a BOTH open (ensure
> >> +  * a O_RDWR descriptor) Or WRONLY open (with a O_WRONLY descriptor).
> >>  */
> >> if ((open->op_share_access & NFS4_SHARE_ACCESS_BOTH) =3D=3D NFS4_SHARE=
_ACCESS_BOTH) {
> >> nf =3D find_rw_file(fp);
> >> dl_type =3D NFS4_OPEN_DELEGATE_WRITE;
> >> + } else if (open->op_share_access & NFS4_SHARE_ACCESS_WRITE) {
> >> + nf =3D find_writeable_file(fp);
> >> + dl_type =3D NFS4_OPEN_DELEGATE_WRITE;
> >> }
> >>
> >> /*
>
> Thanks Sagi, I'm glad to see this posting!
>
>
> > I *think* the main reason we limited this before is because a write
> > delegation is really a read/write delegation. There is no such thing as
> > a write-only delegation.
>
> I recall (quite dimly) that Dai found some bad behavior
> in a subtle corner case, so we decided to leave this on
> the table as a possible future enhancement. Adding Dai.

So could you please test this change against other clients, such as:
- Windows ms-nfs41-client (https://github.com/kofemann/ms-nfs41-client/)
- FreeBSD NFS4.1 client
- Solaris 11 NFS4 client

Dan
--=20
Dan Shelton - Cluster Specialist Win/Lin/Bsd


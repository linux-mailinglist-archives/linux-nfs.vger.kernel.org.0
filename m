Return-Path: <linux-nfs+bounces-5619-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A80F95D0EC
	for <lists+linux-nfs@lfdr.de>; Fri, 23 Aug 2024 17:05:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8CB7D1C2280E
	for <lists+linux-nfs@lfdr.de>; Fri, 23 Aug 2024 15:05:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9B1E18952D;
	Fri, 23 Aug 2024 15:03:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=umich.edu header.i=@umich.edu header.b="i/g0oN7d"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3822188A10
	for <linux-nfs@vger.kernel.org>; Fri, 23 Aug 2024 15:03:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724425414; cv=none; b=tPzhy9DIpnSKUnFlP9TsefcyzAeQh2yufEWUgATWH+490Q3LsDnyBOKk/OQYrXbLEhMxDzMc5BYvKKdX8DGfwjj0Ccobc2EE5DBqqHVRfGTLpcwQmsUbQUXdgILcBa4q/6N+f51m9Q5Njl0rkMvZWavlj67aJGxxm3WtXZfIfso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724425414; c=relaxed/simple;
	bh=DYwnk58CFAPfYu9VcUvQquCkN7cH/h7SLkSx7kIGfm4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Yaf2wwtNcN2CaVDYlFawdymekj7us+yU+CsajirGT2pw59jPwDlFzU8MlalPAqukqS9BNn6SFcb1GhwMmnRWFFPtUkIVY72ddZ7H5ehMu72yHEU4vEnOTMdonByW6yUoZVmJPXjd4kcxgLNvgDIq5JGkMZ6lnfw0QhWGcY5Ae10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=umich.edu; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=umich.edu header.i=@umich.edu header.b=i/g0oN7d; arc=none smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=umich.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-2ef27bfd15bso19730361fa.2
        for <linux-nfs@vger.kernel.org>; Fri, 23 Aug 2024 08:03:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umich.edu; s=google-2016-06-03; t=1724425410; x=1725030210; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PzkeH7Z3xwIhDijYWVxr4oEJ7WIQRTE0RIPu/OveZbc=;
        b=i/g0oN7dJBo2OfCOivvSHrho7ndODZCegTvTsdpnDMxhw4LuLU2stj3qEug2q3JciE
         8pV647tyv0p7aPyFxJnr5PvFdBYDMjnCZlpsi2SIxSu95TeydiR4W65n8FaeHpYdFd6s
         pqiL9edBiHgyMyDCUZqcsUSGqjjuFwvM0MT48C9eAtay2AuT0Eyf8qf68ikWrdBhShZY
         k6jew7hJ5LM2LnbhBH8/9W9HNyNouHU2Oxe+V9T6MEzLlIQPs1Zy8qK/wkaoSfGH81eK
         Km5N4RzFZZTyF0Y+rb/Z+OUS6lRvioAZPoFx0BSqi1BImF1wDyZq4h8RvHJqOmLQ/owa
         ikmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724425410; x=1725030210;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PzkeH7Z3xwIhDijYWVxr4oEJ7WIQRTE0RIPu/OveZbc=;
        b=eYknjYi516LXOzNuj45F76hmDM0+cBb2DxXVzLW13iHWBML4O2PkUUoClQ3TORthIe
         sW72wnuGFkuZCAomcj4vQ/lrj5mInb/0Y7m+vBmQe3fQMbgmeKGfQR0XpZ9cYSYvkdmD
         E1LMWZG3Wb4gHydWTg8qmQdLH9GGx1EsTyg5gvjXxogYoNCFtbxuw1BzWrtUC++Dxpem
         ELFrLBw8K6f1wC9ifCQmEpdzXTZZ/BTnSRc2ONK4qnQUNKYsXebEfhw739Z/oXSHqhGb
         1kjtgM3qD2XbktSE3HyhfsCnhbyPDnjKvfGBPqKCf0LgviVEbu52KIVsYHOE4RNb2SXT
         jv5A==
X-Forwarded-Encrypted: i=1; AJvYcCWJ/R0kw25C3Y6Gtd3NIZ5TG17hTbXI8hML5yZ+DhSyLZBDMB8McTfWcYYbgERuYNYKGbaxvOoHwpk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/2COvCrdf6lPtGSmKrJEqLitm8tBxGbmNxD4oukCRvNkw1WuE
	1ckK/crusSdSTuzKabW5Exm8aBGGkHOceAe+KykeH9yYR/hja9Cp62GkevXJMwyj3uxlSI5tOEC
	/eCbssKrystZybxwD+3lK4SU9z7A=
X-Google-Smtp-Source: AGHT+IGx7OK977m0HTcn+jv+FdthwpDsqWdVVw79mR5En2nNIWYNP6k+7WvMVAGOt8lo+sP4HebpZsLvTzu2nHk2iD4=
X-Received: by 2002:a05:651c:1027:b0:2f3:f6fa:cfd2 with SMTP id
 38308e7fff4ca-2f4f49142e8mr15439981fa.25.1724425409352; Fri, 23 Aug 2024
 08:03:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240823141401.71740-1-okorniev@redhat.com> <Zsif6pDBfVm1sUiV@tissot.1015granger.net>
In-Reply-To: <Zsif6pDBfVm1sUiV@tissot.1015granger.net>
From: Olga Kornievskaia <aglo@umich.edu>
Date: Fri, 23 Aug 2024 11:03:17 -0400
Message-ID: <CAN-5tyHENMDTeyESPA9ceCA=RaPMMW9ORh3NXu9RnbFiLZHRYg@mail.gmail.com>
Subject: Re: [PATCH 1/1] nfsd: prevent states_show() from using invalid stateids
To: Chuck Lever <chuck.lever@oracle.com>
Cc: Olga Kornievskaia <okorniev@redhat.com>, jlayton@kernel.org, linux-nfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 23, 2024 at 10:44=E2=80=AFAM Chuck Lever <chuck.lever@oracle.co=
m> wrote:
>
> On Fri, Aug 23, 2024 at 10:14:01AM -0400, Olga Kornievskaia wrote:
> > states_show() relied on sc_type field to be of valid type
> > before calling into a subfunction to show content of a
> > particular stateid. But from commit 3f29cc82a84c we
> > split the validity of the stateid into sc_status and no longer
> > changed sc_type to 0 while unhashing the stateid. This
> > resulted in kernel oopsing as something like
> > nfs4_show_open() would derefence sc_file which was NULL.
> >
> > To reproduce: mount the server with 4.0, read and close
> > a file and then on the server cat /proc/fs/nfsd/clients/2/states
> >
> > [  513.590804] Call trace:
> > [  513.590925]  _raw_spin_lock+0xcc/0x160
> > [  513.591119]  nfs4_show_open+0x78/0x2c0 [nfsd]
> > [  513.591412]  states_show+0x44c/0x488 [nfsd]
> > [  513.591681]  seq_read_iter+0x5d8/0x760
> > [  513.591896]  seq_read+0x188/0x208
> > [  513.592075]  vfs_read+0x148/0x470
> > [  513.592241]  ksys_read+0xcc/0x178
> >
> > Fixes: 3f29cc82a84c ("nfsd: split sc_status out of sc_type")
> > Signed-off-by: Olga Kornievskaia <okorniev@redhat.com>
> > ---
> >  fs/nfsd/nfs4state.c | 3 +++
> >  1 file changed, 3 insertions(+)
> >
> > diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
> > index c3def49074a4..8351724b8a43 100644
> > --- a/fs/nfsd/nfs4state.c
> > +++ b/fs/nfsd/nfs4state.c
> > @@ -2907,6 +2907,9 @@ static int states_show(struct seq_file *s, void *=
v)
> >  {
> >       struct nfs4_stid *st =3D v;
> >
> > +     if (!st->sc_file)
> > +             return 0;
> > +
> >       switch (st->sc_type) {
> >       case SC_TYPE_OPEN:
> >               return nfs4_show_open(s, st);
> > --
> > 2.43.5
> >
>
> I'll wait for Neil/Jeff's Reviewed-by, but the root cause analysis
> seems plausible to me, and I'll plan to apply it for v6.11-rc.
>
> Btw, I noticed this at the tail of states_show():
>
>         /* XXX: copy stateids? */
>
> I'm not really sure, but those won't ever have an sc_file, will
> they? Are COPY callback stateids something we want the server to
> display in this code? Just musing aloud: maybe the NULL sc_file
> check wants to be moved into the show helpers.

I can see that the copy stateids still have type NFS4_COPY_STID so
they are not converted to the new type of SC_TYPE. But it just means
we are not displaying them. I'm not sure what happens to sc_file for
copy stateid, I'd need to check.

>
> --
> Chuck Lever
>


Return-Path: <linux-nfs+bounces-1826-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D83CE84D27D
	for <lists+linux-nfs@lfdr.de>; Wed,  7 Feb 2024 20:59:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0FAF61C2492B
	for <lists+linux-nfs@lfdr.de>; Wed,  7 Feb 2024 19:59:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7314785947;
	Wed,  7 Feb 2024 19:59:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QpFVk4jr"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DB4684A21
	for <linux-nfs@vger.kernel.org>; Wed,  7 Feb 2024 19:59:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707335944; cv=none; b=huetOo+q2H7UhvHbbOJBk/U4hX8yE6OtCahAsfmarh5w+SIzuxpWNjY7sFVrGVLb2cAdQ8Q7sN9XL/glqNhGjAf7iyguvSRmHBiXBu5kHu/C7JzsI5z48AbRNACjD+cH9uouvtHY2/V6e6OzIYhnX0RVugYVfp4ezaUeqPTxGyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707335944; c=relaxed/simple;
	bh=DJtATnf86+C6VAsvau6qMbtfVcUsu+uR0tKCm/OE8b0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mJtArKNkxXUfM8SDEBPdsA6/c73XSM1L+2CPPPaK5eWGz64pQ3Jnp3eiRjZ0de2IQCioDQPvixNsHOMpLGA+TS2n7l6CSOhhGke19E/g/fOJuHxDix2LfXe5MZYYzb4PfD0w8CotejbZbpa+X2k/JwAb3zAfKnOz1G1+7ytPLOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QpFVk4jr; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-2d0a0af15ddso4944441fa.1
        for <linux-nfs@vger.kernel.org>; Wed, 07 Feb 2024 11:59:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707335940; x=1707940740; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qplGqRvT3RG78nISYN4gJ3PXg+Vm6YVg1234bKncLSc=;
        b=QpFVk4jr3uQPRga7E2D0nkbi+OlOS9rbUSnXRj++weIYto+/Aw6KgZvKjxYNv8S9xl
         CJqWNF1uBsTKf+caQfGRsbBZX2jcXj5OTcZ+dJnxTVRk38S1IrUxmTIyRUUiwK4hc+6d
         4xwa7TOHFiRcARs3uHFInX3Z7leVGQFYEUuJTTcrGNd2h9mRglGhH6gqCnswjRmc9nPI
         dW4MQVrXqx07mVhs+EMwYKx4+gwBkaMJrG/jOMZloVlox7/TWtfOW69Ab0B2GszrzLoY
         11krLHYvsBPDzz7CmeQjUiNv8+wl2JoTCC7b3Ec/7CL5ZHbrhRQ9F5RYXmspm7eyHuMI
         0O3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707335940; x=1707940740;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qplGqRvT3RG78nISYN4gJ3PXg+Vm6YVg1234bKncLSc=;
        b=J5ABqbtLi2LUUBm/hw/X5qP/guE9zJ1+1kVCON4IVpsbPpNob/QJbVnZ5kjcAGNnpM
         7MyFEeySVnuTiKxthBFFLz/WaiqMm7aeJmNer40LQGST0M3QXu5X8IA8eCZOyWIHFYle
         7tq8kHsUWxQVF4eF0EuJyKFSFDt+QH87x+2qgkvog2hiG8GQCBl1LCqZhgkh9NYMD6IW
         As2PZK3xZ2YeuMDUIJuaaSiGneK1KdlaHOnGyfZm3aC3kbGKgXq6klAvx8ijFz3lBurk
         WO/XItWtz3Oe4LtM0xxmYykCUY1+Rg3KF6i6qYbNGSw7bImhE+sFEaKNQrE3bIqSz2Wi
         LByA==
X-Gm-Message-State: AOJu0YxKPThHVjY0MKDsa+3wG53X3fKnaxbOb1iNdY9zNaEC8wEZPwRW
	vDKXedBMMfHpQwTQb8uapw5/FHJkfUoesX3POgrgy/ik9pUQXu3JHDCN6lDJ6aHvTr0zO2J6K+r
	preFpgZIe+qw8saR/ovQw/k8JGoA=
X-Google-Smtp-Source: AGHT+IHMaLjm8dDG/5GG72iKbUSfTow3lryDgDNPYV11hcwDT23VvtcKJgTTJVr362uJsim2FEkMPhPB1wgyorgDiO0=
X-Received: by 2002:a2e:9214:0:b0:2d0:a4e8:4293 with SMTP id
 k20-20020a2e9214000000b002d0a4e84293mr4509255ljg.3.1707335939877; Wed, 07 Feb
 2024 11:58:59 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240207182912.30981-1-olga.kornievskaia@gmail.com>
 <be83ac24a9d17fc78590d4b182afd3f4e6c1e8a7.camel@hammerspace.com> <CAN-5tyFTx4bUvuF627E_2x9Kw2h9tccqU-7KfCtJHyFazTTLYg@mail.gmail.com>
In-Reply-To: <CAN-5tyFTx4bUvuF627E_2x9Kw2h9tccqU-7KfCtJHyFazTTLYg@mail.gmail.com>
From: Olga Kornievskaia <olga.kornievskaia@gmail.com>
Date: Wed, 7 Feb 2024 14:58:48 -0500
Message-ID: <CAN-5tyF2bqMy9y1rbeYbU5uakzg0AeiF7rEzH8M7S=kWyogY_w@mail.gmail.com>
Subject: Re: [PATCH 1/1] NFSv4.1/pnfs: error gracefully on partial pnfs layout
To: Trond Myklebust <trondmy@hammerspace.com>
Cc: "anna.schumaker@netapp.com" <anna.schumaker@netapp.com>, 
	"linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 7, 2024 at 2:51=E2=80=AFPM Olga Kornievskaia
<olga.kornievskaia@gmail.com> wrote:
>
> On Wed, Feb 7, 2024 at 2:12=E2=80=AFPM Trond Myklebust <trondmy@hammerspa=
ce.com> wrote:
> >
> > On Wed, 2024-02-07 at 13:29 -0500, Olga Kornievskaia wrote:
> > > From: Olga Kornievskaia <kolga@netapp.com>
> > >
> > > Currently, if the server returns a partial layout, the client gets
> > > stuck asking for a layout indefinitely. Until we add support for
> > > partial layouts, treat partial layout as layout unavailable error.
> > >
> > > Signed-off-by: Olga Kornievskaia <kolga@netapp.com>
> > > ---
> > >  fs/nfs/nfs4proc.c | 6 ++++++
> > >  1 file changed, 6 insertions(+)
> > >
> > > diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
> > > index dae4c1b6cc1c..108bc7f3e8c2 100644
> > > --- a/fs/nfs/nfs4proc.c
> > > +++ b/fs/nfs/nfs4proc.c
> > > @@ -9790,6 +9790,12 @@ nfs4_proc_layoutget(struct nfs4_layoutget
> > > *lgp,
> > >       if (status !=3D 0)
> > >               goto out;
> > >
> > > +     /* Since client does not support partial pnfs layout, then
> > > treat
> > > +      * getting a partial layout as LAYOUTUNAVAILABLE error
> > > +      */
> > > +     if (lgp->args.range.length !=3D lgp->res.range.length)
> > > +             task->tk_status =3D -NFS4ERR_LAYOUTUNAVAILABLE;
> >
> >
> > I think this case is better handled by allowing the caller to set lgp-
> > >args.minlength to an appropriate minimum value.
>
> I do not understand what this suggestion means. What I can think of is
> that the caller would set an appropriate minimum value and the code
> here would check that the result is at least as large?

A follow up question on a "minimum value". It seems that since the
client would then need to set it to the same value as the "length" (ie
whole file layout value), yes? So it shifts the responsibility to the
server, disallowing it from returning a partial layout.

> If so, can you explain why that's more desirable? Seems to me it'd be
> more lines for something that would be removed later?

> >
> > > +
> > >       if (task->tk_status < 0) {
> > >               exception->retry =3D 1;
> > >               status =3D nfs4_layoutget_handle_exception(task, lgp,
> > > exception);
> >
> > --
> > Trond Myklebust
> > Linux NFS client maintainer, Hammerspace
> > trond.myklebust@hammerspace.com
> >
> >


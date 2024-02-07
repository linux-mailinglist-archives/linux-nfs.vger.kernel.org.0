Return-Path: <linux-nfs+bounces-1829-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 311C584D586
	for <lists+linux-nfs@lfdr.de>; Wed,  7 Feb 2024 23:11:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 51CDD1C22C32
	for <lists+linux-nfs@lfdr.de>; Wed,  7 Feb 2024 22:11:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31CB413249C;
	Wed,  7 Feb 2024 21:44:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="myhNRsPx"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31DC11386C2
	for <linux-nfs@vger.kernel.org>; Wed,  7 Feb 2024 21:44:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707342268; cv=none; b=imM6MKQHetCYQhwnMDn0ILZSESwRbYQ0XDy3Q5C0bZsc+5Vv+HyEnCsPmKogSOZGsBhRg1bq8skF8A+Bi5awlvGCmpI1RZoPNklji1zYeeDXl0w65dL8eSuRwXZIbj8GIv16Lpnoe8ijHt1I1Sb2n9IMbRdGN+z20dJVB9fXetU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707342268; c=relaxed/simple;
	bh=jY18Nfk8UfG5gtIZwhUR2z0Vnaf8sMnFHjKHz0wRWu4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NfxMjGa+i4skiE1RH3ataHgW5rmNigjJGpgMTSUQM8vupVpMbVRYSyDeK5sn2CbTrYIghajmotiVkSqly1i3k6GeE/7XadsYmD74hke57SV4g9yyRLW4oW0F8UEKsyq+LC1yZQ1UlCtD3LzKpYBOSU7u0MY4u6v0BmohlmLb0gk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=myhNRsPx; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-2d0cc05abd3so3554861fa.0
        for <linux-nfs@vger.kernel.org>; Wed, 07 Feb 2024 13:44:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707342264; x=1707947064; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qr4/5KA5TcSWc9v3YR6rTN+lnO/KxpvbGLdaCECNHPE=;
        b=myhNRsPxUMfDYIva+hr9/nky6m5NilI2zrs5PlhYACINd/p2DsNKbbIFmz3HNB8FRr
         y0fxj0bNKPN+Piic6sn9qnKwm6QN6fLmt1OILVIZjP2xXmRwsB2OwJYZMMX0LRFzV0B+
         2XFkasIA6zA2F6PrI8o+7TSERuofPsDQjkQaZMlA3ernYcsCRCvY0GB1YkOPmPjRQzQz
         t/5Fno0pIzSEZxzS2EEXZl17wHSsW95BBBLuDegtW6YFh3Aa7R66j0hQjt+bpQwdNNyn
         FdjwG3XSJnum1yKivNfOqnlFPpE6US+2jvu45KdmtaA9m9h+vrbf/6qo6F9Nw+3No/SL
         Gd/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707342264; x=1707947064;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qr4/5KA5TcSWc9v3YR6rTN+lnO/KxpvbGLdaCECNHPE=;
        b=awMcFR7tZaS6rgZ5WMEI9lcfwGN/kgpIuGPBTBSApgfXUUojKvION0GJakaVhPDTdG
         5lyeEDNNDeiUx/1BQoYgZCe1/5g2+HWhKfPJknVGmf5mm2/E8j3X3Q8Lca+Xy3Bfcvab
         Ba1quah58Q4yWa3mM03J4V1bQ0pUFrfRGC08K7zptTMwCbjlnXfMu8slKClaNcYLVkyM
         Bk9RJ/GdgsG8nW+uG/8DZHzsIfwsROwcrRqLIg9Vb/3gesBSXNoSNWN4O5E995/Y2PZd
         7QkABK3c+Xnbl6+bC+mM5Y6gztf78t8rUKUZExY3+J9jGNhZPl/QM7eeLYCYoVK2Aq4W
         iWvw==
X-Gm-Message-State: AOJu0Yx4fY9vXCpIkBA4uBpSba18Yh595zh6pI4nBYNEKrGwTEgwHTxW
	HD2X+R7guE0IMizEsOHQOEa5rJ4X3XqBtCnF4NbpG0yB+IUJJD+AwkqSklBv8JUTBojb6voVfnc
	DfeWJK3C6STo8M6uEaL504mCBltM0NN5a
X-Google-Smtp-Source: AGHT+IFfnYAN76OOEXV6fbhuu/tkkx4t4Hj9mz1XpHfFfvYUI0M0DcLSBiIY4tvD1bl1gq2NFj6abAAscD6Fc6lIYrU=
X-Received: by 2002:a2e:9915:0:b0:2cf:5847:b033 with SMTP id
 v21-20020a2e9915000000b002cf5847b033mr4670394lji.2.1707342263592; Wed, 07 Feb
 2024 13:44:23 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240207182912.30981-1-olga.kornievskaia@gmail.com>
 <be83ac24a9d17fc78590d4b182afd3f4e6c1e8a7.camel@hammerspace.com>
 <CAN-5tyFTx4bUvuF627E_2x9Kw2h9tccqU-7KfCtJHyFazTTLYg@mail.gmail.com>
 <CAN-5tyF2bqMy9y1rbeYbU5uakzg0AeiF7rEzH8M7S=kWyogY_w@mail.gmail.com> <10ca1cfa1243a7b039502a5cc8253a56c2572408.camel@hammerspace.com>
In-Reply-To: <10ca1cfa1243a7b039502a5cc8253a56c2572408.camel@hammerspace.com>
From: Olga Kornievskaia <olga.kornievskaia@gmail.com>
Date: Wed, 7 Feb 2024 16:44:11 -0500
Message-ID: <CAN-5tyFQYVKqzansQ8E9=uKGbrhOJ_e6jzS3CeCMGPp9=aKTVQ@mail.gmail.com>
Subject: Re: [PATCH 1/1] NFSv4.1/pnfs: error gracefully on partial pnfs layout
To: Trond Myklebust <trondmy@hammerspace.com>
Cc: "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>, 
	"anna.schumaker@netapp.com" <anna.schumaker@netapp.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 7, 2024 at 3:42=E2=80=AFPM Trond Myklebust <trondmy@hammerspace=
.com> wrote:
>
> On Wed, 2024-02-07 at 14:58 -0500, Olga Kornievskaia wrote:
> > On Wed, Feb 7, 2024 at 2:51=E2=80=AFPM Olga Kornievskaia
> > <olga.kornievskaia@gmail.com> wrote:
> > >
> > > On Wed, Feb 7, 2024 at 2:12=E2=80=AFPM Trond Myklebust
> > > <trondmy@hammerspace.com> wrote:
> > > >
> > > > On Wed, 2024-02-07 at 13:29 -0500, Olga Kornievskaia wrote:
> > > > > From: Olga Kornievskaia <kolga@netapp.com>
> > > > >
> > > > > Currently, if the server returns a partial layout, the client
> > > > > gets
> > > > > stuck asking for a layout indefinitely. Until we add support
> > > > > for
> > > > > partial layouts, treat partial layout as layout unavailable
> > > > > error.
> > > > >
> > > > > Signed-off-by: Olga Kornievskaia <kolga@netapp.com>
> > > > > ---
> > > > >  fs/nfs/nfs4proc.c | 6 ++++++
> > > > >  1 file changed, 6 insertions(+)
> > > > >
> > > > > diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
> > > > > index dae4c1b6cc1c..108bc7f3e8c2 100644
> > > > > --- a/fs/nfs/nfs4proc.c
> > > > > +++ b/fs/nfs/nfs4proc.c
> > > > > @@ -9790,6 +9790,12 @@ nfs4_proc_layoutget(struct
> > > > > nfs4_layoutget
> > > > > *lgp,
> > > > >       if (status !=3D 0)
> > > > >               goto out;
> > > > >
> > > > > +     /* Since client does not support partial pnfs layout,
> > > > > then
> > > > > treat
> > > > > +      * getting a partial layout as LAYOUTUNAVAILABLE error
> > > > > +      */
> > > > > +     if (lgp->args.range.length !=3D lgp->res.range.length)
> > > > > +             task->tk_status =3D -NFS4ERR_LAYOUTUNAVAILABLE;
> > > >
> > > >
> > > > I think this case is better handled by allowing the caller to set
> > > > lgp-
> > > > > args.minlength to an appropriate minimum value.
> > >
> > > I do not understand what this suggestion means. What I can think of
> > > is
> > > that the caller would set an appropriate minimum value and the code
> > > here would check that the result is at least as large?
> >
> > A follow up question on a "minimum value". It seems that since the
> > client would then need to set it to the same value as the "length"
> > (ie
> > whole file layout value), yes? So it shifts the responsibility to the
> > server, disallowing it from returning a partial layout.
>
> My expectation is that we use 'minimum length' to mean the length that
> is the smallest value that is acceptable to the client (i.e. the
> "loga_minlength" as described in RFC5661 Section 18.43). If the client
> cannot handle a layout that is smaller than a whole file layout, then
> that's the value we should set for loga_minlength. The server then gets
> to decide if it can honour the request, or should return
> NFS4ERR_LAYOUTTRYLATER.
>
> The other value is the desired length (i.e. the "loga_length" as
> described in RFC5661, Section 18.43). Currently, in the flexfiles
> client, we set that to the length of the I/O request that we're trying
> to obey. If the server can meet or exceed that value, it will still do
> so, but it doesn't need to return an error if it cannot meet that value
> provided that it can still return a layout with a length that meets the
> "loga_minlength" requirement.

I think I'm misunderstanding a partial layout and the client's ability
to support them. Is partial layout support something that generic pnfs
code does or is that something that each layout driver supposed to
support?  I was under the impression that it is or will be generic.
I'm specifically confused because in the previous email you said, the
minimal (layout) length is set to a PAGE (or I/O request size) and
that each driver is supposed to be able to handle that. That seems to
imply to me that if the server returned back a layout of 1 page
(which is a partial layout) then the layoutdriver should be OK with it
(mean handle partial layouts) (which filalyout driver does not, it
needs a whole file layout), is that correct?

>
> --
> Trond Myklebust
> Linux NFS client maintainer, Hammerspace
> trond.myklebust@hammerspace.com
>
>


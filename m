Return-Path: <linux-nfs+bounces-3213-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 628AE8C03DF
	for <lists+linux-nfs@lfdr.de>; Wed,  8 May 2024 19:56:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1F1642895D6
	for <lists+linux-nfs@lfdr.de>; Wed,  8 May 2024 17:56:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D67F12C52E;
	Wed,  8 May 2024 17:55:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VkcY0mE2"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41FAB12C484
	for <linux-nfs@vger.kernel.org>; Wed,  8 May 2024 17:55:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715190957; cv=none; b=jwdTzyGxrrgTed4zcFoX1RyyZWlG50OHOwQezZc1IgIsvyEJuK8bW4Kg8QXoa13pYrAthCg6dnlI3NxWZxiXUlbaBRZMQA/1i3Mgi7ICUOm0azI0F/SSi8lJV6NqfseLaETgxeInFn5RuIMXOaSgIyN3AvWlDNMOH0LqxnytqA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715190957; c=relaxed/simple;
	bh=pUTEKP6FoCIfV4NaerFcI0Oy3+5drXI00qPB0sfiS5k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XnzV7hiyMq7lrcGEs64va4vJxpHiXSiYwKN0f365iIqkYLZJLS0V4A8CIy25t2mDBLTxVqyqiVIQqa5sDV2qQCDoLMZ4o/kiLhlYhJax2AyOBze5/ef7MMipcn4ihGu729fd/lOH4dFls/riseG8FSf8cGxl4ioUP+98GHmpvr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VkcY0mE2; arc=none smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-2e1e8c880ffso33771fa.2
        for <linux-nfs@vger.kernel.org>; Wed, 08 May 2024 10:55:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715190954; x=1715795754; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CwWOJO/c//OtKDHoXEtAe/07E6itqOhiODkzvQndlcE=;
        b=VkcY0mE21ThMvUb55mtVb48jVAzl6uzm0GPe5HqcH8DhhHK8+D2wlECwbMzS2GTn+h
         FUhgjRdMzVk1DQ0uAk7zi+HTbgQqt3fIgGXPzN/mYfSdWdAnAv13EIohWxD1iuXVeCSp
         bJaEImgn6nkDe5z6B/9dF3Z2DvBgOBtfUIxkz5ukKPealazZ/cCgacKr0EcczRIFRKpk
         W9cHGTyM+YZnnaNX19gBlxtCtexhYtLtD8A2zkbl5a0DBj4PfEgQ7297OxTkbZCeamfg
         mdCzQN4RTwqIg9I8zc11au9oMHhZb9e29HdP2SBW96NG0OBpfL7BIpWIkRmir/EVjJYD
         /i7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715190954; x=1715795754;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CwWOJO/c//OtKDHoXEtAe/07E6itqOhiODkzvQndlcE=;
        b=S+YdBkIuXH1HnR1IAmtT4f2JNA23nCRJB/KhPUFKIg61liE/99kcM2tWLVfJCtgHvl
         CiAiwEItDl05xL5QlKGwLdyTb1Bp0zSeRUMI59SfYP/jEeNQhNSkkh3ekfzojmgDMusH
         idyBPL1kJxNXMN6CwOJOn0MHWg9kr3GuIRlIoI6QdddV2ECqV+7xV/tjV4BiY6Zxga5l
         OX07P10nKUPyLfvt4+fwlXNecoWOm966m80LpL0PVt9Bw5tBBqk3shH40YShrWQprFb+
         Gu/GzW2MLgZYFzTubtuijPd8BpQBOKODWcpzaOkW+Mxkqa/OKrMecNxnWbVU1ydImab5
         aV1g==
X-Forwarded-Encrypted: i=1; AJvYcCXvQ9Q4vww6z4i+newHGevkBTLRUlCrIN2kg3Qy06oLmFxLPAm/lbx3tym7+JcM3zBLw4uuvbUOETEiYQKX7xxxhPumZiQTw3Xu
X-Gm-Message-State: AOJu0YwW3WFoL6THDDc4Yv99X9lR4NKlEVKtz9NqVYx40q67mVlVifkW
	i5huMrD6qdD5yexExAg7KqYyrzzNAdsEPF4pXXeLvE6NfCAUjdTsCW3maLatUG/Ohx3D0POcOt+
	dWF6xGKRTrtsEP1Ytmx8kK19FrYI=
X-Google-Smtp-Source: AGHT+IEzFio06cmmej0Z8ZMeWpBAsurGqESol9Iyd7cYhQ8vsvC996ePp+wrjIYy4F8loXrpvbSFvYyn3ILo3+QkpdY=
X-Received: by 2002:a05:651c:4d0:b0:2e3:3b4e:43ef with SMTP id
 38308e7fff4ca-2e4479a2d12mr27121281fa.4.1715190954355; Wed, 08 May 2024
 10:55:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240507195933.45683-1-olga.kornievskaia@gmail.com>
 <9D9DB9E5-E772-462B-BD38-7F703459A0FC@redhat.com> <CAN-5tyFWrqihMv8UwvAmrcxuFdM6S5qMvnZgWkJqWXm6iFJeVQ@mail.gmail.com>
In-Reply-To: <CAN-5tyFWrqihMv8UwvAmrcxuFdM6S5qMvnZgWkJqWXm6iFJeVQ@mail.gmail.com>
From: Olga Kornievskaia <olga.kornievskaia@gmail.com>
Date: Wed, 8 May 2024 13:55:42 -0400
Message-ID: <CAN-5tyGx-Q1szxNvRK=+Msxu76-Xwiyg9u+rp0NxxT53ha-Q+Q@mail.gmail.com>
Subject: Re: [PATCH 1/1] pNFS/filelayout: check layout segment range
To: Benjamin Coddington <bcodding@redhat.com>
Cc: trond.myklebust@hammerspace.com, anna.schumaker@netapp.com, 
	linux-nfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 8, 2024 at 1:52=E2=80=AFPM Olga Kornievskaia
<olga.kornievskaia@gmail.com> wrote:
>
> On Wed, May 8, 2024 at 10:50=E2=80=AFAM Benjamin Coddington <bcodding@red=
hat.com> wrote:
> >
> > On 7 May 2024, at 15:59, Olga Kornievskaia wrote:
> >
> > > From: Olga Kornievskaia <kolga@netapp.com>
> > >
> > > Before doing the IO, check that we have the layout covering the range=
 of
> > > IO.

I should add that this patch extends previously posted 2 patches by
Anna for the partial layout support for filelayout (as in they go
together).

> > >
> > > Signed-off-by: Olga Kornievskaia <kolga@netapp.com>
> > > ---
> > >  fs/nfs/filelayout/filelayout.c | 2 ++
> > >  1 file changed, 2 insertions(+)
> > >
> > > diff --git a/fs/nfs/filelayout/filelayout.c b/fs/nfs/filelayout/filel=
ayout.c
> > > index 85d2dc9bc212..bf3ba2e98f33 100644
> > > --- a/fs/nfs/filelayout/filelayout.c
> > > +++ b/fs/nfs/filelayout/filelayout.c
> > > @@ -868,6 +868,7 @@ filelayout_pg_init_read(struct nfs_pageio_descrip=
tor *pgio,
> > >                       struct nfs_page *req)
> > >  {
> > >       pnfs_generic_pg_check_layout(pgio);
> > > +     pnfs_generic_pg_check_range(pgio, req);
> > >       if (!pgio->pg_lseg) {
> > >               pgio->pg_lseg =3D fl_pnfs_update_layout(pgio->pg_inode,
> > >                                                     nfs_req_openctx(r=
eq),
> > > @@ -892,6 +893,7 @@ filelayout_pg_init_write(struct nfs_pageio_descri=
ptor *pgio,
> > >                        struct nfs_page *req)
> > >  {
> > >       pnfs_generic_pg_check_layout(pgio);
> > > +     pnfs_generic_pg_check_range(pgio, req);
> > >       if (!pgio->pg_lseg) {
> > >               pgio->pg_lseg =3D fl_pnfs_update_layout(pgio->pg_inode,
> > >                                                     nfs_req_openctx(r=
eq),
> > > --
> > > 2.39.1
> >
> > Looks right, less duplication to just call pnfs_generic_pg_check_range(=
)
> > from pnfs_generic_pg_check_layout() now.
>
> filelayout.c is not the only caller of pnfs_generic_pg_check_layout().
> flexfilelayout has a wrapper around those 2 functions and calls that.
> however, the argument about duplicated code frustrates me because
> currently the code has 4lines. but if we were to re-write the same
> with a function, it would be more lines used in total (flexfiles has 8
> lines for it).
>
> >
> > Reviewed-by: Benjamin Coddington <bcodding@redhat.com>
> >
> > Ben
> >


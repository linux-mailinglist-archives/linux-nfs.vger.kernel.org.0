Return-Path: <linux-nfs+bounces-10674-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 842D1A682C9
	for <lists+linux-nfs@lfdr.de>; Wed, 19 Mar 2025 02:41:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D1DC9422E65
	for <lists+linux-nfs@lfdr.de>; Wed, 19 Mar 2025 01:41:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C164324CEF9;
	Wed, 19 Mar 2025 01:41:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FA2Eqyor"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E85E812CD8B
	for <linux-nfs@vger.kernel.org>; Wed, 19 Mar 2025 01:41:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742348477; cv=none; b=juUsXsMJCWc+BFGNz6vXSZwSj5AX+5IdXTWbxoD4WEph6y4XnKTMnfonMonIIoermegJaJbb2Qb8kF8nw9jGpfPFxp6iWoMpMByA20BZZObOLqB1xMf3TagjhRG29SJ0viAvNo1qL6lgpIvLMUnZVW6QV9JEzb7Zy8aFBhiqeTI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742348477; c=relaxed/simple;
	bh=FPt/ycb+iWyAlMDbx3M8MgLeKpcxLxLHAOjEms4+mHM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=R9OdZlR7uJFnnwcDEJZXNpGFL2OLJV9B1FazwNOMyXYzm1cZKv3Dw0H+DwUj225hs32YVmR6icDqRphYyOlM4OGQtNjtBlzB/9Tuh80ExFFr40cxzDbpbV3Ym1GHRapAo8E/ySVPxOahB9rKZo1A+TGTMKlhfylKxilD4lNaBvM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FA2Eqyor; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-5dccaaca646so462850a12.0
        for <linux-nfs@vger.kernel.org>; Tue, 18 Mar 2025 18:41:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742348474; x=1742953274; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FPt/ycb+iWyAlMDbx3M8MgLeKpcxLxLHAOjEms4+mHM=;
        b=FA2EqyorGzm2u0J80PBBNXVgv+qA3IrNiBii0e+6mZZMbNVhB3vIKw5lBjDZog+4E8
         ZiE0RGZ5uYQsYcH8KXPBGDfoQN6D3Vq9efDDMTh/nVk8FyDWmjpyXem89uEbFKKKQGns
         CShC++u2j/8XWmHpJiu8CQ3QSk2Z6CAC8XKmlwCV9wGvQZ1n+W5BHGfOZvVKVKlhdYTk
         SVsz5JAjbo/Hly4C3xbUncvXcSIhgZO4mcJh81XmcJOCy3MNCHwHjh+fOIkiYvDaJgfm
         av2DA4qo6M+ApIK96ShJUoJWKnYIt6h1xm7UZEc94hw4EAjlR3wA3WoK4Z+72jnnB7HO
         1yDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742348474; x=1742953274;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FPt/ycb+iWyAlMDbx3M8MgLeKpcxLxLHAOjEms4+mHM=;
        b=BjNbhGBZx/eZ1E6hc5sWCLYpilEDodvlJHtEiDWLG3fi3onxPjV12gNW1RHpuIDLTa
         ppw/9G0hpoQc4beNTv5Scq4I1Ymy5+lyHPmYJBQnUJI90hj1pBQTAsut3hL5Rqp5y+nI
         cCuF+RWCDnj7y5zT0wfgNDQootG51q2Yxm1d1aA7rwyjUHVHjfKnwhmFPTlVfnIz+pN/
         In4gz8yOnU0hVH25GNR7YkiTJznQ80zkAj8kpJe6Yb2pnXLfyOSGaO2yfT9gXbTaOGO1
         7MRWXK0Q9lcr5XPt80taO++/rMYiuyreEI4YlPQyjuQJjIp8iT9rqhtBJOERqHzcCmBc
         dEVA==
X-Forwarded-Encrypted: i=1; AJvYcCU6aybnr3uIH21oXxx/eQ0ChyyLFCpqgtUKc3pYrVKORPArwrCfYpQJ43pKigTnz9QZCzttJrsKnVo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxMqRJJkIL3sni9+/XHQFB6RtJhGQ0kTDUQtQ0z6cKQ2lXequkB
	w9hAlcNsiwshp9Oc2u0znNQHHsUynx+TVUrA6KNcn4g5FIygsy3oElQy9lVMgJ1XSX74rTnMeVJ
	mN/+3gtLbLt20vJyvE2GhcOHWkQ==
X-Gm-Gg: ASbGncs4hSL8XMkneeXq9PzedSxTOt2jJ3SpJsCjeflbXknmtErOXudDjwc8a0FUlcY
	AXhIDMlRpswyLY4vWysrlEyiSVAQTTnulK7jwcZh5O+0lmUK1WyQljXgb9tjLsz6SfpASpKDwwQ
	+35NTGuaiWHguHWyGRlJa8T7syjYltWTk/pdcUhQ9EVz0Z6d1BYmQiHNC8wRA=
X-Google-Smtp-Source: AGHT+IFDfdGE8kjyvyipHKGVCX/Ol8r2K+Mj2XLNvcxnAp/kdpGzby04vNwg70fZ/TX3VkqOaGb1yVa7xA2uRdNcSrs=
X-Received: by 2002:a05:6402:35c9:b0:5e7:8e5e:4467 with SMTP id
 4fb4d7f45d1cf-5eb80b10044mr711820a12.3.1742348473886; Tue, 18 Mar 2025
 18:41:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CALWcw=EeJ7rePwqv48mf8Se0B5tLE+Qu56pkS-fo0-X0R3DQ=Q@mail.gmail.com>
 <0ea71027-c0cb-436a-8dc7-6f261f0d9e0e@oracle.com> <89535c4a-7080-41cc-a0a3-1f66daa9287a@oracle.com>
 <CAM5tNy7FdNRC6i62jqyMs=A=03omztTk3YdgS=P3qJVersSFbg@mail.gmail.com>
 <e674d6ec96cc8598b079efd3b93612537f840a87.camel@hammerspace.com>
 <CAPJSo4WrOnWfLzmfoCcj1MuYQQBHo434vTK=9qx+rh_FCVck=w@mail.gmail.com>
 <e21645871fd6249d93f9bb33b154c3663eaf0a70.camel@hammerspace.com>
 <CAM5tNy5ZA5MKuCsFQHXE_uBkmMv3eBH7dgonaTrk9Rk-p2jA0g@mail.gmail.com>
 <09c573463b19a1d1f4b1e50484faa657d3c3aa28.camel@hammerspace.com> <75d4e5849c488bddeaa12f2a9780394dfe8d743e.camel@hammerspace.com>
In-Reply-To: <75d4e5849c488bddeaa12f2a9780394dfe8d743e.camel@hammerspace.com>
From: Rick Macklem <rick.macklem@gmail.com>
Date: Tue, 18 Mar 2025 18:40:59 -0700
X-Gm-Features: AQ5f1Jqw6cgJvmjul71WZEur61S9RNjdQGsqEjzaxyUXiST0yrQs3a-ytPTMKFo
Message-ID: <CAM5tNy5W_WwtYT8LpPrX_B5wHyu3yi5DMrf9Hcu3iM4911Jvgw@mail.gmail.com>
Subject: Re: Supporting FALLOC_FL_WRITE_ZEROES in NFS4.2 with WRITE_SAME?
To: Trond Myklebust <trondmy@hammerspace.com>
Cc: "lionelcons1972@gmail.com" <lionelcons1972@gmail.com>, 
	"linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>, 
	"takeshi.nishimura.linux@gmail.com" <takeshi.nishimura.linux@gmail.com>, 
	"anna.schumaker@oracle.com" <anna.schumaker@oracle.com>, 
	"chuck.lever@oracle.com" <chuck.lever@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 18, 2025 at 6:12=E2=80=AFPM Trond Myklebust <trondmy@hammerspac=
e.com> wrote:
>
> On Tue, 2025-03-18 at 23:59 +0000, Trond Myklebust wrote:
> > On Tue, 2025-03-18 at 16:52 -0700, Rick Macklem wrote:
> > > On Tue, Mar 18, 2025 at 4:40=E2=80=AFPM Trond Myklebust
> > > <trondmy@hammerspace.com> wrote:
> > >
> > > > Yes, I also realise that none of the above operations actually
> > > > resulted
> > > > in blocks being physically filled with data, but all modern flash
> > > > based
> > > > drives tend to have a log structured FTL. So while overwriting
> > > > data
> > > > in
> > > > the HDD era meant that you would usually (unless you had a log
> > > > based
> > > > filesystem) overwrite the same physical space with data, today's
> > > > drives
> > > > are free to shift the rewritten block to any new physical
> > > > location
> > > > in
> > > > order to ensure even wear levelling of the SSD.
> > > Yea. The Wr_zero operation writes 0s to the logical block. Does
> > > that
> > > guarantee there is no "old block for the logical block" that still
> > > holds
> > > the data? (It does say Wr_zero can be used for secure erasure,
> > > but??)
> > >
> > > Good question for which I don't have any idea what the answer is,
> > > rick
> >
> > In both the above arguments, you are talking about specific
> > filesystem
> > implementation details that you'll also have to address with your new
> > operation.
>
> Actually, let me correct that... I'm not aware of any requirement on
> any of the NFSv4.2 operations or the NFSv4.2 extensions, that expect
> the permanent and irrevocable deletion of data.
> I definitely won't say there isn't a use case for it, but I am saying
> that it isn't covered by any NFS protocol today.
Agreed.

I thought it was an implementation of FALLOC_FL_ZERO_RANGE
was what was being looked at (or is there now a separate
FALLOC_FL_WRITE_ZEROS?). I agree that the NFSV4.2
DEALLOCATE followed by ALLOCATE seems to satisfy the
requirement.
There is the question "What happens if DEALLOCATE
succeeds and then ALLOCATE fails?".

>
> IOW: if data wiping is what you're actually looking for here, then I
> think that needs to be a new operation, and we'll need a lot of
> discussion about how the NFS protocol should deal with all the various
> ways in which not just the storage, but also the filesystem go about
> trying to preserve data. We can probably leave the existence of
> external backups as an exercise for the user... =F0=9F=A4=94=EF=B8=8F
>
> --
> Trond Myklebust
> Linux NFS client maintainer, Hammerspace
> trond.myklebust@hammerspace.com
>
>


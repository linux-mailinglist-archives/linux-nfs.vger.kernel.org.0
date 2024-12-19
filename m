Return-Path: <linux-nfs+bounces-8678-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B4B409F873F
	for <lists+linux-nfs@lfdr.de>; Thu, 19 Dec 2024 22:43:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1A92E165AF4
	for <lists+linux-nfs@lfdr.de>; Thu, 19 Dec 2024 21:43:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4291E1A073F;
	Thu, 19 Dec 2024 21:43:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=umich.edu header.i=@umich.edu header.b="inGa4zuf"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D91317799F;
	Thu, 19 Dec 2024 21:43:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734644582; cv=none; b=TA3bd+dQb/BQ6PWy4smmODiWcb0lJ1c1Rkbecf+E11BWLOARAwLt607Kp10Q/5iv3Xiiu0iCLHwnRmHdReQNafKbiTNu0zXF2HYM1Q72q4AJ6xVONrrkWGMWQVBHy1IRSjXE+JuaxbUBARBoq4IlEoj0jpiL69hU5HbyUx0QaBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734644582; c=relaxed/simple;
	bh=aKlSEyieBl9aSfuh0LGVtfMsxyGoZwrS8uYV/9+ElL8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KN4mM3pkKw6KqQfsPaLGLSOWJ9Zl8PjexuWUgDrtRRHgiTxPWLjgPxsy9RP4QgGCoxG4zM1Fd0aokC8qbh4QpVXKb0srEaNAcrI7EgEki9SKXKbovFCXhc8SV8YsA1+kQazD9v3N9fLu2WT7X21Sz0v5Wkwt7ySWfSQA8vxbDAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=umich.edu; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=umich.edu header.i=@umich.edu header.b=inGa4zuf; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=umich.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-30167f4c1deso12376931fa.1;
        Thu, 19 Dec 2024 13:43:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umich.edu; s=google-2016-06-03; t=1734644578; x=1735249378; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ft9II/n1FZS/uBFLaflc7mb6/8rtn5IB8T/SNnrk/0M=;
        b=inGa4zufx75FuFikE9+lbXAOPPUs3hyzRNeYQ2n9ktgs8nO62Om5YfRytEiHh21KNq
         1e9Xpsj8SC5G5LPe7ry3NRTlmOZXNH//m1tt6pivca270RNwv92KJav+POWCmLGVabUw
         fy9EkPzeoc1sFbSonZlYM/jRpsZHy07sLo49E4sA/YgiNjbleSaqdw0G90Z4cAPiKqPg
         UqZVM3vczkl2M58iuOYAnPBNPGU4+0MGTqT3yC+BDK64mxmeKqlLIuacjzEW1S0kYBNA
         LytKTnopXqWrIec3P/ZA+cSYD+k8CsYTw2dfedYYK/pqmaL/uqyfXhpU3EGkbfVEOnUr
         90Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734644578; x=1735249378;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ft9II/n1FZS/uBFLaflc7mb6/8rtn5IB8T/SNnrk/0M=;
        b=oKebWSINq6QqlBLC8iEnQ45Q4w75Vtwa4cB1LnV7kt9Fhl9UmL425ZzZi0VacUZkZe
         CGAXO3ng2Rk9S/8a07YOQ2nmstRxQV3ubKscROhN6LVyjmyyjF4q0aupNKe4b1dXqGl5
         PdjhOUVjPvW5XwxcFdUiwClTcaD6xIciodw7039PbwSbH2SJ5MPimFgHSm879k4stWX3
         L4Q3xlQO7S5pRdmg8kc80rHtvdmynoP9M3Z7kBIwhX/m4y37PC44jnb+59FcokzZkA62
         Fe2bj0UERX5+9OOGhKA7x5aYnZV8tsMyJOLn/57rIojPXt3hKHMrtd6qa3bj/uUVbSAj
         K8RQ==
X-Forwarded-Encrypted: i=1; AJvYcCV8raaiuhvuWmiWDpsNC24daHAGKiHV73lxDjEXe0mmGgAdlm7jiaCR0m55OYjvlaoaZjfXoeA2o7dVUHE=@vger.kernel.org, AJvYcCWa+NX2326vEaF2eun70u7dGc+IoJiPtrR3zpsQOtNv0vg4GGvLsoKzfne3NzKRUDPFQHvsjjdV7Zq0@vger.kernel.org
X-Gm-Message-State: AOJu0Yyecw136ogq+9Q3hePbul1whTCJWG4xlu0D1emSTKGZmE2apQV9
	htHD/cAi7wgS0Dui//UQvb6iB1SbcDZRd+46204i1cgMR0rZ2b4am5ehrpM5PbcZZZ3cwkeviKZ
	NMKRaaAvskj8EbtulesD/rhoGL2o=
X-Gm-Gg: ASbGncu3fMLdRSmLCWRRzXIlyj4+lYCGVraAoEKZoLTMrAfhMcyZ+uHT+cHcRm0j4WW
	Rnjj0JVauHDmghXBXfB8T3heFlbu5o6JyUXrk2UxZ3pPzWaNSpPXPHvkxQVJwBfPWfQM6sjTy
X-Google-Smtp-Source: AGHT+IFbERrEsFom+BhdjiAMfCRknldLlb+wlsK8dy4W8lNO8HgTvPiyf/nh0yAB9TQuyD7VvX0Mh2Sg6mHrV1GZat0=
X-Received: by 2002:a2e:b8ca:0:b0:302:1b18:2bfa with SMTP id
 38308e7fff4ca-304685b9d5cmr2264411fa.23.1734644578123; Thu, 19 Dec 2024
 13:42:58 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240826-nfsd-cb-v1-0-82d3a4e5913b@kernel.org>
 <20240826-nfsd-cb-v1-1-82d3a4e5913b@kernel.org> <CAN-5tyGWmAZ2ovmS4SqiEoZhokxOG+ERvOVFB6ziTqE-ahLFUg@mail.gmail.com>
 <4ea104be11ae3979e76144d3018ede5e0d49cc3c.camel@kernel.org>
In-Reply-To: <4ea104be11ae3979e76144d3018ede5e0d49cc3c.camel@kernel.org>
From: Olga Kornievskaia <aglo@umich.edu>
Date: Thu, 19 Dec 2024 16:42:46 -0500
Message-ID: <CAN-5tyFHmBUWR5d=Rt08MxQobtmZatLw7umeRV=8BN_GUs-vxg@mail.gmail.com>
Subject: Re: [PATCH 1/3] nfsd: add more info to WARN_ON_ONCE on failed callbacks
To: Jeff Layton <jlayton@kernel.org>
Cc: Chuck Lever <chuck.lever@oracle.com>, Neil Brown <neilb@suse.de>, 
	Olga Kornievskaia <kolga@netapp.com>, Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>, 
	linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 19, 2024 at 4:33=E2=80=AFPM Jeff Layton <jlayton@kernel.org> wr=
ote:
>
> On Thu, 2024-12-19 at 16:23 -0500, Olga Kornievskaia wrote:
> > On Mon, Aug 26, 2024 at 8:54=E2=80=AFAM Jeff Layton <jlayton@kernel.org=
> wrote:
> > >
> > > Currently, you get the warning and stack trace, but nothing is printe=
d
> > > about the relevant error codes. Add that in.
> > >
> > > Signed-off-by: Jeff Layton <jlayton@kernel.org>
> > > ---
> > >  fs/nfsd/nfs4callback.c | 3 ++-
> > >  1 file changed, 2 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/fs/nfsd/nfs4callback.c b/fs/nfsd/nfs4callback.c
> > > index d756f443fc44..dee9477cc5b5 100644
> > > --- a/fs/nfsd/nfs4callback.c
> > > +++ b/fs/nfsd/nfs4callback.c
> > > @@ -1333,7 +1333,8 @@ static void nfsd4_cb_done(struct rpc_task *task=
, void *calldata)
> > >                 return;
> > >
> > >         if (cb->cb_status) {
> > > -               WARN_ON_ONCE(task->tk_status);
> > > +               WARN_ONCE(task->tk_status, "cb_status=3D%d tk_status=
=3D%d",
> > > +                         cb->cb_status, task->tk_status);
> >
> > Can we add cb->cb_ops->opcode to that as well?
>
> I'd be fine with that, but this patch is already merged. Care to
> propose one that could go on top?

Yep of course was just testing if that was Ok. I just realized it
would have saved a lot of time (me coming up with that fix I just
posted) if I knew what callback was in play.

>
> >
> > >                 task->tk_status =3D cb->cb_status;
> > >         }
> > >
> > >
> > > --
> > > 2.46.0
> > >
> > >
>
> --
> Jeff Layton <jlayton@kernel.org>


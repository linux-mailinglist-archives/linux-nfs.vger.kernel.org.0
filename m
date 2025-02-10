Return-Path: <linux-nfs+bounces-9999-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C40B2A2E20A
	for <lists+linux-nfs@lfdr.de>; Mon, 10 Feb 2025 02:34:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7A4A5163D6E
	for <lists+linux-nfs@lfdr.de>; Mon, 10 Feb 2025 01:34:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E336323CB;
	Mon, 10 Feb 2025 01:34:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XhlteEde"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17A5B1A28D
	for <linux-nfs@vger.kernel.org>; Mon, 10 Feb 2025 01:34:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739151292; cv=none; b=XEnff1wIi5mUfy1rUEGssHduuv/UeQgFMDlBeFklA4X2iJvEamG+reCKurxX8EN/dGrwo0aiUQ0Afi9CjUO2nnPmTX9z4a7qxBobdeKR2CbSqlMJ+S6gfHNUEElztXF9KUw+1D5+t3DYYdDBWc2NpydhXMzvQoL9e+2UAsGezNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739151292; c=relaxed/simple;
	bh=WMn7jp4NFouO2gNnIfZfZVmFXxbdIx+KYEkK1k8Ay6I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RCkO1KpB6iU6GTHEnGZXaFDfFLoQaGtRuiyKri443qb3O5Bhz03BIs85pwJTQrw25LNR1JQbED6qIASEIresvPtdrQYudcG170H1f7RBG1Nm7HcomrTJcEjr7bMWoC94VlKok4j2XON6uJzLXbMVLmwmjIAPeObUi+XvM1y85fY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XhlteEde; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-5de4d4adac9so4653650a12.3
        for <linux-nfs@vger.kernel.org>; Sun, 09 Feb 2025 17:34:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739151289; x=1739756089; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SlPzA2DARq/4iEWMxSGxTDYQ3luiJwJCB6SAtil1wN0=;
        b=XhlteEdeaJ5ioQmWf/vLN9/QVmyAHpkfDHGd2JsVSi+qk3dgfsWd7HYamN9x9rfoFU
         p4aVR678D3Uux4IPnCGpSz/d0E0j3edhufsUz3c0X+wwJViPtQrWDSHs42PJlzh4FG6Q
         q8qsn+Zfk0JEyqYEz9cjFQmV3kpEWo7Bovds9zcFdyoY2kmBrPAB2oa52craBnLOjevR
         78KA/H5rkL4MRc3oaVKsscUISv5KHk2rgbYj3CEdtn3/3vNjlsnzflyjZGHnFr3/V0dB
         KL9FX/dvn63xAGEv+UGif9V/Ne1Qeg+kF/IMoHzOdeGjw7TFnXt0r64OQ6lCd0AaqY4h
         4yuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739151289; x=1739756089;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SlPzA2DARq/4iEWMxSGxTDYQ3luiJwJCB6SAtil1wN0=;
        b=cesSafDi+4b8EAPU4oem5f7PKA3Xal0ak5l6YpSlrt7C56QQ6FRd4lQJ5SF92Kl0bB
         BneSJgmBCGALOiD1kuXM8uMXDNN/rWM1HzLjuzXsRwxqn3fQGaKyi8GpfCfxO1WcdcB4
         Iwut5XjiBktvbgqwCtHp2P/O1+Lqolfh2WFnoJX/O3iK3xuK3ym71D4JuU6B+q9IA/Hh
         mypu1FnvZkbgmXXruc8loZkJ5xRAkVAHELInY6t10I+/3Bn52+OSqNTXlMsUu/M2DEZa
         MH4qYn72f0EFK7xUVsU81qE34nepaEY1HKlhyWz3lOLngYfzxUjH2Jh2NSKo+ckilsgm
         gscw==
X-Gm-Message-State: AOJu0Yzq5lxiuQPBp4HNU7Z6bH7ZOluxcV64YhncTCOJz15ur4O/7+nm
	5El7C1hF4PGDSg8AVWuKCv4zVAjnGTXmtRAeFxQ5Am86DG9owS55mcuiYZqlsiRMXG1bMP0wDFY
	bC562BhqAqLmvamWfS+sA1oDtoaYq
X-Gm-Gg: ASbGncuNkIOqHo/t/dr9LVIPNvkQ1dMwngXhR2ScZ2X+IuTYSBxQ4T0Z2A/+6TArQPf
	dE1X49ShVMfZW47i5iwWF1iHrr8pQS4n68I5A/MpDmHnPPmHJJN5w7sQUo7gjGfyKMmTXBqfpTB
	hdGE2l8nlXkloC3E3JgWj6UttPg196
X-Google-Smtp-Source: AGHT+IEP+SwwRDii+uopxe3racWqeG4n7qSTqXVaTeBZocPBqbpFbDmkxU8UYaq1JPUWcsOj0WwQa6vxvybTJL/TExM=
X-Received: by 2002:a05:6402:360d:b0:5de:5864:6628 with SMTP id
 4fb4d7f45d1cf-5de586466d5mr7885739a12.26.1739151289121; Sun, 09 Feb 2025
 17:34:49 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAM5tNy4f9YyMhYRydudNkCqzVp5f8Np6N25NOT=-+TjJN2ewqg@mail.gmail.com>
 <884876492c56e76fd6fbb4c5c4fb08ee14de9fe1.camel@hammerspace.com>
In-Reply-To: <884876492c56e76fd6fbb4c5c4fb08ee14de9fe1.camel@hammerspace.com>
From: Rick Macklem <rick.macklem@gmail.com>
Date: Sun, 9 Feb 2025 17:34:37 -0800
X-Gm-Features: AWEUYZm0wBifqfWNhbYerQca_fXcn9o1QgezOxe3NQ47NAg6dn9Ejw_9huBIOYc
Message-ID: <CAM5tNy5yv1CkVc3z0dTJ_Fed9mP-ZBug1L39Jnau48s=OnSPvA@mail.gmail.com>
Subject: Re: resizing slot tables for sessions
To: Trond Myklebust <trondmy@hammerspace.com>
Cc: "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Feb 9, 2025 at 3:34=E2=80=AFPM Trond Myklebust <trondmy@hammerspace=
.com> wrote:
>
> On Sun, 2025-02-09 at 13:39 -0800, Rick Macklem wrote:
> > Hi,
> >
> > I thought I'd post here instead of nfsv4@ietf.org since I
> > think the Linux server has been implementing this recently.
> >
> > I am not interested in making the FreeBSD NFSv4.1/4.2
> > server dynamically resize slot tables in sessions, but I do
> > want to make sure the FreeBSD handles this case correctly.
> >
> > Here is what I believe is supposed to be done:
> > For growing the slot table...
> > - Server/replier sends SEQUENCE replies with both
> >    sr_highest_slot and sr_target_highest_slot set to a larger value.
> > --> The client can then use those slots with
> >       sa_sequenceid set to 1 for the first SEQUENCE operation on
> >       each of them.
> >
> > For shrinking the slot table...
> > - Server/replier sends SEQUENCE replies with a smaller
> >   value for sr_target_highest_slot.
> >   - The server/replier waits for the client to do a SEQUENCE
> >      operation on one of the slot(s) where the server has replied
> >      with the smaller value for sr_target_highest_slot with a
> >      sa_highest_slot value <=3D to the new smaller
> >       sr_target_highest_slot
> >      - Once this happens, the server/replier can set sr_highest_slot
> >         to the lower value of sr_target_highest_slot and throw the
> >          slot table entries above that value away.
> > --> Once the client sees a reply with sr_target_highest_slot set
> >       to the lower value, it should not do any additional SEQUENCE
> >       operations with a sa_slotid > sr_target_highest_slot
> >
> > Does the above sound correct?
>
> The above captures the case where the server is adjusting using
> OP_SEQUENCE. However there is another potential mode where the server
> sends out a CB_RECALL_SLOT.
Ouch. I completely forgot about this one and I'll admit the FreeBSD client
doesn't have it implemented.

Just fyi, does the Linux server do this, or do I have some time to implemen=
t it?

Thanks, rick

>
> In the latter case, it is up to the client to send out enough SEQUENCE
> operations on the forward channel to implicitly acknowledges the change
> in slots using the sa_highestslot field (see RFC8881, Section 20.8.3).
>
> If the client was completely idle when it received the CB_RECALL_SLOT,
> it should only need to send out 1 extra SEQUENCE op, but if using RDMA,
> then it has to keep pounding out "RDMA send" messages until the RDMA
> credit count has been brought down too.
>
> --
> Trond Myklebust
> Linux NFS client maintainer, Hammerspace
> trond.myklebust@hammerspace.com
>
>


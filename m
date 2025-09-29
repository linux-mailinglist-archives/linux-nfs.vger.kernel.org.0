Return-Path: <linux-nfs+bounces-14786-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2058FBAA3B3
	for <lists+linux-nfs@lfdr.de>; Mon, 29 Sep 2025 19:50:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 75B591893B5F
	for <lists+linux-nfs@lfdr.de>; Mon, 29 Sep 2025 17:50:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA567219303;
	Mon, 29 Sep 2025 17:50:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=umich.edu header.i=@umich.edu header.b="U6GbvT1K"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1FA21F4262
	for <linux-nfs@vger.kernel.org>; Mon, 29 Sep 2025 17:50:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759168217; cv=none; b=gaFyUd8XMxWYcIt9gSJTXpgL2w8n1fJ0lQBUX0mURsKn+arGt5fZMEvMY7EtrWONA9mo5Hp2QSv48erjP+H7L0e4T3lAT8dDq50ytC2nQ1D/qg+UJxiZZvqbTXLXAk833tHQFMXX+0MwfCjCtcjnN4teU8VV2LTBx5d5hYRvazA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759168217; c=relaxed/simple;
	bh=HiyLZKLd2OS9k2yFo9nu7n520zGB/DmoweRkNbL6iCY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LbKOoyFuydqw/l3o6SIxKPnG8yAKZLeqbNmDs6v0AJX7rCLeqi8v8vYBVs1RWDEnRKayAu1qXs5HXemd1Ep4tSorRPUJzgZuOr+PK3xhDfg3PbkcLpVcaLT+P+AzFfCNUmNepWloBQ10qwXt8OFmIxSEiSR/udLbWDwHHGq0RXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=umich.edu; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=umich.edu header.i=@umich.edu header.b=U6GbvT1K; arc=none smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=umich.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-33c9f2bcdceso48921791fa.2
        for <linux-nfs@vger.kernel.org>; Mon, 29 Sep 2025 10:50:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umich.edu; s=google-2016-06-03; t=1759168212; x=1759773012; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0sqKrrNtljWqhc66PpnxwhPC99YJYY/vmlaSLPJIg3A=;
        b=U6GbvT1K9OT83Y1gYfepEHugrjOq/+f8cqLgzYkUv/Ry+08zjflv8+n0W87O91V4Io
         gWEM5PsAbNaKWhmk4veGpwmp40x+YkZtqRyFf4Xi3Cf113nKEmzJQHXlmykraL2f4bdU
         EStJ/2mWgMF4dLB1hRsScbeqKGS0zuWhT/4zQT1EuhmDWCwQd5l4+aWpLkijp8zIrkGO
         HYoBHkTRTgyZBD5TULZUq3LHTWY7pjPQnDKy/B0PP276Hisy1N57oqbHKLpu0z7YdOrR
         xKnbCEE1sGzBYTSd6zxYnvopwFXOIM3rFz90SACtcdu8SLAuushEW8n6f9mqvxknbkWj
         FScw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759168212; x=1759773012;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0sqKrrNtljWqhc66PpnxwhPC99YJYY/vmlaSLPJIg3A=;
        b=j4wTbjIE5TC5kQEzZMh4dZjKqWTjXJirHSOu9K5P98w3xA9zH9P+HJclr7GKdO1ASn
         LExNIIDo2pMsaAgZOq/MNbNXDdLrtyny2BNkzZ3JPPqEmO8IOXIl6+/Ul1/vCMPNmjar
         v5c5uRI6XyNg9zuPB+j1I5YLSX8k5AAmplzzw1SMjAiLKzE6XGakgvaGOdkLtrwPuKQe
         x3+BWi0D3lQB+t/1aaam80S4iuOMpDF74MxuPfdu3f1SFAKzNOpOBBCJcg6K25PwFaqr
         QnBs6X1rHzHWN1IBEC8BSkYWOuMa42U+mAhP24ilvYFi+t7p7PWLSe+WJwkYYe56lf6y
         VW1A==
X-Forwarded-Encrypted: i=1; AJvYcCVZq3Lq/eNaMpA61RZ2mmIoqHz5f20QsIui3JLtgT7Nkhj7dvDonVh06ESJAsQ5M7natiRpoPe726g=@vger.kernel.org
X-Gm-Message-State: AOJu0YxG2m9pGUBtnysUoldjZ99IUJuW2cOtnYFL0WYzXdpv1MWed8yX
	O46JODjlb5+5nIj3HPlzByBOzP1sJoD7IUmkiLvQRncoXY27K4IZP76VgqAD1cSBYAmMCaLTfbl
	LFccanxpDRo47mCVLzqQhwo1C6R1WJ+0=
X-Gm-Gg: ASbGncvT5OmpmJFPRWOjLtoxSshnDcUOAF2Y7beMFBzD0n3JhYVA+cDQPjeKkM98ATJ
	+MSAtmLfFSy3qSdiFOJyB9kzGJ1Fd1ff5AyHSL+reqGzu0oAU3dqrvZlSquvkUpXBdu00mcjol4
	SI76lo9teEfgYAXm9ndKAKwTk7FFbA0DV3cgbsCF9tzLsEKWd+0T6wvcP+MEOTDpiR5Hb0Ss8Aa
	o3ykEE77i5Vrr9guzGi7Q/K5w4KnWjrB8KhEbIrqgVaz8uzuZ+Fjyxg37c+Bwc=
X-Google-Smtp-Source: AGHT+IHQrJfcib+rbRfen/aJAEBDyExB+6YWTF6aZtcNGnC3CRCFgm1tgDtDcRjq7TG/OsX4+EV/1+vZhH0FKVj4ZcU=
X-Received: by 2002:a2e:a802:0:b0:36b:be8:a4f with SMTP id 38308e7fff4ca-36f7f936ff4mr58525941fa.37.1759168211445;
 Mon, 29 Sep 2025 10:50:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250811181848.99275-1-okorniev@redhat.com> <CAN-5tyEmf9HHMuXHDU86Y5FWYZz+ZYFKctmoLaCAB+DZ1zcXSQ@mail.gmail.com>
 <2b87402379d4c88545dabce30d2877722940f483.camel@kernel.org>
 <CACSpFtC3FbdGS6W6yKKwn+JcFmkSKE8yZRkQzuEWwRjAsZYkWQ@mail.gmail.com>
 <831f2ac457624092dcfadcf8b290fc65dc10e563.camel@kernel.org> <CACSpFtAqWdPPCbHLnXKGOmn7bR0fBjS9fj_J=i4aNnL+=8t1zA@mail.gmail.com>
In-Reply-To: <CACSpFtAqWdPPCbHLnXKGOmn7bR0fBjS9fj_J=i4aNnL+=8t1zA@mail.gmail.com>
From: Olga Kornievskaia <aglo@umich.edu>
Date: Mon, 29 Sep 2025 13:49:59 -0400
X-Gm-Features: AS18NWAMNHiN2qqy3xHpXci7vVdgC_qkxWIJt11N5bx_FXLkZFhDnFKNsvNNVjw
Message-ID: <CAN-5tyEY17k5SZ6hj2QsgW_006c-0ywS5H5vPvadj80bC0X=7w@mail.gmail.com>
Subject: Re: [PATCH 1/1] NFSv4: handle ERR_GRACE on delegation recalls
To: Olga Kornievskaia <okorniev@redhat.com>
Cc: Trond Myklebust <trondmy@kernel.org>, anna.schumaker@oracle.com, 
	linux-nfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 12, 2025 at 12:04=E2=80=AFPM Olga Kornievskaia <okorniev@redhat=
.com> wrote:
>
> On Fri, Sep 12, 2025 at 11:11=E2=80=AFAM Trond Myklebust <trondmy@kernel.=
org> wrote:
> >
> > On Fri, 2025-09-12 at 10:41 -0400, Olga Kornievskaia wrote:
> > > On Fri, Sep 12, 2025 at 10:29=E2=80=AFAM Trond Myklebust <trondmy@ker=
nel.org>
> > > wrote:
> > > >
> > > > On Fri, 2025-09-12 at 10:21 -0400, Olga Kornievskaia wrote:
> > > > > Any comments on or objections to this patch? It does lead to
> > > > > possible
> > > > > data corruption.
> > > > >
> > > >
> > > > Sorry, I think was travelling when you originally sent this patch.
> > > >
> > > > > On Mon, Aug 11, 2025 at 2:25=E2=80=AFPM Olga Kornievskaia
> > > > > <okorniev@redhat.com> wrote:
> > > > > >
> > > > > > RFC7530 states that clients should be prepared for the return
> > > > > > of
> > > > > > NFS4ERR_GRACE errors for non-reclaim lock and I/O requests.
> > > > > >
> > > > > > Signed-off-by: Olga Kornievskaia <okorniev@redhat.com>
> > > > > > ---
> > > > > >  fs/nfs/nfs4proc.c | 4 ++--
> > > > > >  1 file changed, 2 insertions(+), 2 deletions(-)
> > > > > >
> > > > > > diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
> > > > > > index 341740fa293d..fa9b81300604 100644
> > > > > > --- a/fs/nfs/nfs4proc.c
> > > > > > +++ b/fs/nfs/nfs4proc.c
> > > > > > @@ -7867,10 +7867,10 @@ int nfs4_lock_delegation_recall(struct
> > > > > > file_lock *fl, struct nfs4_state *state,
> > > > > >                 return err;
> > > > > >         do {
> > > > > >                 err =3D _nfs4_do_setlk(state, F_SETLK, fl,
> > > > > > NFS_LOCK_NEW);
> > > > > > -               if (err !=3D -NFS4ERR_DELAY)
> > > > > > +               if (err !=3D -NFS4ERR_DELAY && err !=3D -
> > > > > > NFS4ERR_GRACE)
> > > > > >                         break;
> > > > > >                 ssleep(1);
> > > > > > -       } while (err =3D=3D -NFS4ERR_DELAY);
> > > > > > +       } while (err =3D=3D -NFS4ERR_DELAY || err =3D=3D -
> > > > > > NFSERR_GRACE);
> > > > > >         return nfs4_handle_delegation_recall_error(server,
> > > > > > state,
> > > > > > stateid, fl, err);
> > > > > >  }
> > > > > >
> > > > > > --
> > > > > > 2.47.1
> > > > > >
> > > > > >
> > > >
> > > > Should the server be sending NFS4ERR_GRACE in this case, though?
> > > > The
> > > > client already holds a delegation, so it is clear that other
> > > > clients
> > > > cannot reclaim any locks that would conflict.
> > > >
> > > > ..or is the issue that this could happen before the client has a
> > > > chance
> > > > to reclaim the delegation after a reboot?
> > >
> > To answer my own question here: in that case the server would return
> > NFS4ERR_BAD_STATEID, and not NFS4ERR_GRACE.
> >
> > > The scenario was, v4 client had an open file and a lock and upon
> > > server reboot (during grace) sends the reclaim open, to which the
> > > server replies with a delegation. How a v3 client comes in and
> > > requests the same lock. The linux server at this point sends a
> > > delegation recall to v4 client, the client sends its local lock
> > > request and gets ERR_GRACE.
> > >
> > > And the spec explicitly notes as I mention in the commit comment that
> > > the client is supposed to handle ERR_GRACE for non-reclaim locks.
> > > Thus
> > > this patch.
> > >
> >
> > Sure, however the same spec also says (Section 9.6.2.):
> >
> >    If the server can reliably determine that granting a non-reclaim
> >    request will not conflict with reclamation of locks by other clients=
,
> >    the NFS4ERR_GRACE error does not have to be returned and the
> >    non-reclaim client request can be serviced.
> >
> > The server can definitely reliably determine that is the case here,
> > since it already granted the delegation to the client.
>
> I'll take your word for it as I'm not that versed in the server code.
> But it's an optimization and hard to argue that a server must do it
> and thus the client really should handle the case that actually
> happens in practice now?
>
> > I'm not saying that the client shouldn't also handle NFS4ERR_GRACE, but
> > I am stating that the server shouldn't really be putting us in this
> > situation in the first place.
> > I'm also saying that if we're going to handle NFS4ERR_GRACE, then we
> > also need to handle all the other possible errors under a reboot
> > scenario.
>
> I don't see how the "if" and "then" are combined. I think if there are
> other errors we don't handle in reclaim then we should but I don't see
> it's conditional on handling ERR_GRACE error.

What's the path forward here?

>
> > --
> > Trond Myklebust
> > Linux NFS client maintainer, Hammerspace
> > trondmy@kernel.org, trond.myklebust@hammerspace.com
> >
>


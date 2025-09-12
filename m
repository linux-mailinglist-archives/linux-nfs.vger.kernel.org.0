Return-Path: <linux-nfs+bounces-14388-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BF0D0B55468
	for <lists+linux-nfs@lfdr.de>; Fri, 12 Sep 2025 18:04:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C5EC6166BC1
	for <lists+linux-nfs@lfdr.de>; Fri, 12 Sep 2025 16:04:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2196924BCF5;
	Fri, 12 Sep 2025 16:04:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="M3Z1Yf4r"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5673330E83D
	for <linux-nfs@vger.kernel.org>; Fri, 12 Sep 2025 16:04:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757693077; cv=none; b=mzgk1gUNcODlifjrwQoE4UFpVIUUMZ/pFW4CNRuPxXcIotdUqXljW+fRCgJm0J6zTu1wLqyUpFnIp6mohFBvU2OXdD3i3JYojs1lq9uA6HIpx2TFQGS5e8VgNAB4Jefkm3HYuCbU/TQuBqmZo04h3tLuOtVNmHyzvXdk6mVNsmI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757693077; c=relaxed/simple;
	bh=WsS72Wv4jhtJw72PS/PT2NESDXPRAcwT5FcMmlYX78A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AfanQc9ujrdOUyL6WFtG6pliDYmT6RHiEKn4UC7g/RtGl29Ol9RIYb2aR/TiRofVBtzcAzIMSzShrRa+78IxDwoGi9ahG+JAi+7uisOG735ocFlgt7fdDb1cwdcTdGaYPQazmdlMl4F7V5OQsj0hTUZ439FsbslHfctCEA/wR28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=M3Z1Yf4r; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1757693074;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mm4VeDBPiCIKqpL0vROry5Hbz6tm2LhDfOLPdtkPPPQ=;
	b=M3Z1Yf4rAGyB76e7xP8dRnWVq69FvubRGe2MzPRkRoZy0UuQbVnpC66jEkaGs69kseaYs9
	6/elXASysp/5Ym+5RRBoyoIEkitSTDiNKzYUL65k/8DF9WgA2wRLbL6ay/eYmjsWEDrJV/
	n46ZYJMt9J2WT2F3pSR7P8MhTKFl+Ks=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-135-JBGnsEUPMdiG3tw9SF45JA-1; Fri, 12 Sep 2025 12:04:32 -0400
X-MC-Unique: JBGnsEUPMdiG3tw9SF45JA-1
X-Mimecast-MFC-AGG-ID: JBGnsEUPMdiG3tw9SF45JA_1757693072
Received: by mail-ed1-f71.google.com with SMTP id 4fb4d7f45d1cf-62b77ca3f64so1978380a12.3
        for <linux-nfs@vger.kernel.org>; Fri, 12 Sep 2025 09:04:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757693071; x=1758297871;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mm4VeDBPiCIKqpL0vROry5Hbz6tm2LhDfOLPdtkPPPQ=;
        b=T4Jq1bO9Z0Cw3TTr9tvwAkzIrQ52lyoY1wX588a0QnJMCYDxRTRdk9DJE2L/wPaZY6
         1vtQKVAHH7HiZKzivq9lw2ag1mj0drtos84f5GtqLHaRopVmtwG8DcPZw/rI0280fK6p
         D8Im5Nv1JYUpo3cREPJlVBGvrVV9zGG4enVvHmoMwFSxsA9SL1nI690i9Keq/+VnWGTw
         TFk8Cl1hNInt1DEYPMT0trnU2lJExxwejOGfZcuc+4aT2S9yliuWZC7O48QbfNL7e3bi
         NHgBsxjrCB6MwphvdasnwN71RP9OIgyibgDU7cbGlgomQKDu7oMcxpV0td9zSikHx1+5
         w+mQ==
X-Forwarded-Encrypted: i=1; AJvYcCVKG10bzEURTnnZ1YtTnF3Qz4g/1GjPSEHmylLfQzPuBfN2vQFwKKJbyvxG4EItiD+bljZb8p89olg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzC0nnb3qSmSAosJDsaqlz0+zmKrRdo5v9qWp9bqrONSB9+/S/k
	2+HJmKz526BhujyueFuXvW8PWeOC6jt8WYk167dumkkaJQvmjAExYigEjw3+zLa167umoQvgfzN
	WxzEjGqOyQqpe2FtFQFMmhEDk1YapxpGHT/H+iO2KXmv8YiGpU6tQfWYZkQbxED90GlV4F+AWSl
	ZkYF56eNdnAgw6Lwpc+6mzom3WNkSJxAma4cbD
X-Gm-Gg: ASbGncuw9QUVI+XHxcyJDGzru9GDbp4e73/5l3ts7FJsmbY01dze2KgRIlt5Nw3Bbjt
	o9+dl5qCFEwiLmt55NYzX0SDXZPswzNiveL645Z5sBii4h2/RmknRyJ2ppmEVaXReFlGhQP0cEY
	v0AlwrXQn6lO7U4MwKcqXxvTGUjGn3Q/b/WXQGA/jYYu3YfXibvxWR1dw=
X-Received: by 2002:a05:6402:24da:b0:61a:9385:c78b with SMTP id 4fb4d7f45d1cf-62ed82e079fmr2625149a12.38.1757693071511;
        Fri, 12 Sep 2025 09:04:31 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHmkQK3SANqddWtFDGpRQqr5l5jKFUnI5oEywyJUmT2k9t0eTg89BxdManmtZ2iy4RbCF4w6G1y8Htvn0o9gI0=
X-Received: by 2002:a05:6402:24da:b0:61a:9385:c78b with SMTP id
 4fb4d7f45d1cf-62ed82e079fmr2625121a12.38.1757693071049; Fri, 12 Sep 2025
 09:04:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250811181848.99275-1-okorniev@redhat.com> <CAN-5tyEmf9HHMuXHDU86Y5FWYZz+ZYFKctmoLaCAB+DZ1zcXSQ@mail.gmail.com>
 <2b87402379d4c88545dabce30d2877722940f483.camel@kernel.org>
 <CACSpFtC3FbdGS6W6yKKwn+JcFmkSKE8yZRkQzuEWwRjAsZYkWQ@mail.gmail.com> <831f2ac457624092dcfadcf8b290fc65dc10e563.camel@kernel.org>
In-Reply-To: <831f2ac457624092dcfadcf8b290fc65dc10e563.camel@kernel.org>
From: Olga Kornievskaia <okorniev@redhat.com>
Date: Fri, 12 Sep 2025 12:04:20 -0400
X-Gm-Features: AS18NWB14IZMmfzXUSGi80OXk8RbaucxyAgUfSLCTbLyLsZbp1FCcRMLSwrQ1vA
Message-ID: <CACSpFtAqWdPPCbHLnXKGOmn7bR0fBjS9fj_J=i4aNnL+=8t1zA@mail.gmail.com>
Subject: Re: [PATCH 1/1] NFSv4: handle ERR_GRACE on delegation recalls
To: Trond Myklebust <trondmy@kernel.org>
Cc: Olga Kornievskaia <aglo@umich.edu>, anna.schumaker@oracle.com, linux-nfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 12, 2025 at 11:11=E2=80=AFAM Trond Myklebust <trondmy@kernel.or=
g> wrote:
>
> On Fri, 2025-09-12 at 10:41 -0400, Olga Kornievskaia wrote:
> > On Fri, Sep 12, 2025 at 10:29=E2=80=AFAM Trond Myklebust <trondmy@kerne=
l.org>
> > wrote:
> > >
> > > On Fri, 2025-09-12 at 10:21 -0400, Olga Kornievskaia wrote:
> > > > Any comments on or objections to this patch? It does lead to
> > > > possible
> > > > data corruption.
> > > >
> > >
> > > Sorry, I think was travelling when you originally sent this patch.
> > >
> > > > On Mon, Aug 11, 2025 at 2:25=E2=80=AFPM Olga Kornievskaia
> > > > <okorniev@redhat.com> wrote:
> > > > >
> > > > > RFC7530 states that clients should be prepared for the return
> > > > > of
> > > > > NFS4ERR_GRACE errors for non-reclaim lock and I/O requests.
> > > > >
> > > > > Signed-off-by: Olga Kornievskaia <okorniev@redhat.com>
> > > > > ---
> > > > >  fs/nfs/nfs4proc.c | 4 ++--
> > > > >  1 file changed, 2 insertions(+), 2 deletions(-)
> > > > >
> > > > > diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
> > > > > index 341740fa293d..fa9b81300604 100644
> > > > > --- a/fs/nfs/nfs4proc.c
> > > > > +++ b/fs/nfs/nfs4proc.c
> > > > > @@ -7867,10 +7867,10 @@ int nfs4_lock_delegation_recall(struct
> > > > > file_lock *fl, struct nfs4_state *state,
> > > > >                 return err;
> > > > >         do {
> > > > >                 err =3D _nfs4_do_setlk(state, F_SETLK, fl,
> > > > > NFS_LOCK_NEW);
> > > > > -               if (err !=3D -NFS4ERR_DELAY)
> > > > > +               if (err !=3D -NFS4ERR_DELAY && err !=3D -
> > > > > NFS4ERR_GRACE)
> > > > >                         break;
> > > > >                 ssleep(1);
> > > > > -       } while (err =3D=3D -NFS4ERR_DELAY);
> > > > > +       } while (err =3D=3D -NFS4ERR_DELAY || err =3D=3D -
> > > > > NFSERR_GRACE);
> > > > >         return nfs4_handle_delegation_recall_error(server,
> > > > > state,
> > > > > stateid, fl, err);
> > > > >  }
> > > > >
> > > > > --
> > > > > 2.47.1
> > > > >
> > > > >
> > >
> > > Should the server be sending NFS4ERR_GRACE in this case, though?
> > > The
> > > client already holds a delegation, so it is clear that other
> > > clients
> > > cannot reclaim any locks that would conflict.
> > >
> > > ..or is the issue that this could happen before the client has a
> > > chance
> > > to reclaim the delegation after a reboot?
> >
> To answer my own question here: in that case the server would return
> NFS4ERR_BAD_STATEID, and not NFS4ERR_GRACE.
>
> > The scenario was, v4 client had an open file and a lock and upon
> > server reboot (during grace) sends the reclaim open, to which the
> > server replies with a delegation. How a v3 client comes in and
> > requests the same lock. The linux server at this point sends a
> > delegation recall to v4 client, the client sends its local lock
> > request and gets ERR_GRACE.
> >
> > And the spec explicitly notes as I mention in the commit comment that
> > the client is supposed to handle ERR_GRACE for non-reclaim locks.
> > Thus
> > this patch.
> >
>
> Sure, however the same spec also says (Section 9.6.2.):
>
>    If the server can reliably determine that granting a non-reclaim
>    request will not conflict with reclamation of locks by other clients,
>    the NFS4ERR_GRACE error does not have to be returned and the
>    non-reclaim client request can be serviced.
>
> The server can definitely reliably determine that is the case here,
> since it already granted the delegation to the client.

I'll take your word for it as I'm not that versed in the server code.
But it's an optimization and hard to argue that a server must do it
and thus the client really should handle the case that actually
happens in practice now?

> I'm not saying that the client shouldn't also handle NFS4ERR_GRACE, but
> I am stating that the server shouldn't really be putting us in this
> situation in the first place.
> I'm also saying that if we're going to handle NFS4ERR_GRACE, then we
> also need to handle all the other possible errors under a reboot
> scenario.

I don't see how the "if" and "then" are combined. I think if there are
other errors we don't handle in reclaim then we should but I don't see
it's conditional on handling ERR_GRACE error.

> --
> Trond Myklebust
> Linux NFS client maintainer, Hammerspace
> trondmy@kernel.org, trond.myklebust@hammerspace.com
>



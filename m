Return-Path: <linux-nfs+bounces-14819-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BCC5DBAE1C7
	for <lists+linux-nfs@lfdr.de>; Tue, 30 Sep 2025 19:01:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B694F3C1431
	for <lists+linux-nfs@lfdr.de>; Tue, 30 Sep 2025 17:00:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D2683081A4;
	Tue, 30 Sep 2025 17:00:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=umich.edu header.i=@umich.edu header.b="plLE7x4c"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEB7D19D880
	for <linux-nfs@vger.kernel.org>; Tue, 30 Sep 2025 17:00:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759251652; cv=none; b=Qh29ATyvNIRjGWblagIRUVieV3CXspIRmO+PJf7BeVWBMgdG4ZbZPpy0TQt72BGHyI4xA2+lZwti6aEX9h4eVmdhpLKKJvlbAVGt0WZ+gy+ie1/jtkEOoxRPgGlEQKos7VlPJK8jr0NRJRL8I0BbC1iYmyLs7hBJ8iSDIpg+RkU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759251652; c=relaxed/simple;
	bh=Cgq+1M1IaIZ1XEZlWjgPlVesMaTX3t4bO/BKLL5Qqjo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=b9hAxJisRgNfW+LXa1zMOxyrY2E7go/lKNnGtQxgBDVXUABJkqOXZvirCLfKurrKcKgUhIBBbodWB7Gg7h2a+FUk1gYHIOto7Kyf7k64dnN4PuFhgMaAS92iCxZMh4dUSDBtBTuzESYjJWp+aXkT/kwRO0tm03mN0TtZnTceakw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=umich.edu; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=umich.edu header.i=@umich.edu header.b=plLE7x4c; arc=none smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=umich.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-36bf096b092so86648971fa.1
        for <linux-nfs@vger.kernel.org>; Tue, 30 Sep 2025 10:00:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umich.edu; s=google-2016-06-03; t=1759251645; x=1759856445; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=84z4pmPz9hQFFLoAbNEr/yMwIYLOEkbhrc7MN09GPcI=;
        b=plLE7x4cVxJnfE9Bzvfc6hiLMy9KrQkND9LPyplcS2oqMXwal3vJstWLOMHFMfm4I0
         wEDdKxXKs5lKDvJGhia3YYWWKOsH1S8/3HJzxd0ZqENYM7NT6c7VMa42/dXonJleuiU+
         2oWAHzqs2ejSmXbrdnJvTSZSOXH4MUwHaLAeSTI0nozHLU2nAxTBWDIaK87yxhdazY82
         3xkuHJFLZY8dMT52kn6Ck23q2rG10b64eWMB6TLrRPW/pAamTkiZyQps8GAevRC34Yqv
         2FOv7aGAC66zjzZmruZ1zBXGCtmRPU0rp30LT/U4pl0ifhrKc1cPguxGOARZJTffZjnm
         BIvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759251645; x=1759856445;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=84z4pmPz9hQFFLoAbNEr/yMwIYLOEkbhrc7MN09GPcI=;
        b=VxL0sssTHo3ZocWb8B6i/txpvBBjqmov+2vhoshfBqo5+Zw0qOLxaRVJQqTGuuBc4u
         HjfoEVjXsOozIRgDyHM/GTuWAE1DM38C8aBIoO7h3IVTYGSW/8ryDr/y9mQBa/KCBmPj
         WpYU8nlGdVSSiKauZqNJ8jgbpWkhx8+sV/8JIK4pOIU+U2ADG/g7wsT6P/0Pm/igvVXE
         HLDV/R8JpBDzUjik9GM/iWgISL2e0uWz7lBdfjJYCBlNDwai4qIhIScng9uuCxRuia8Z
         2fjnzqtpAerKJ0id+/fHa0J7Pos/ikFDuylp1+mMRZyvS3WRcIEPIUbcyu6YLE1kCHuX
         qpZw==
X-Forwarded-Encrypted: i=1; AJvYcCW7dO0FB5SST/boNWRU9JSC7yWWiBXT8iQmsPqzqXHIDC4P/ZzHRZrURMz2/khxb0zA/5RrjscDISI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwruOLKz/Kx95n3RDE0liy23Jc1nvJzo03XnvjzSwJhFPvCYYZz
	Eo5QmZz57Q+B6z68kvuNzIc+Y07N1DEzwWmCZM+1vHE3r8n2AGVnmL1hrcPxduMX3hQhd70BMtI
	PO8a4fy4F/7ToLKmLsWa23YaGOFj2yc8=
X-Gm-Gg: ASbGncsF1DWmgP3Az3woaKsNVqGQiS3HeHow3N12ntob/PkxE8OklZnyLeR5qo5W+KB
	KKxib5Su5jeKWs7yHVQ46F1fkYArlaaPVSPBKe1sVIiO3GD3h0ZG9RmXeypXTF/UAvOP9xORljD
	4DEIsijcCpsOF2j8aze4A7mfaIfMw3lnD2xKbKXyEulmNlB6CRsTzflY0kFI568OEptV1dkYT32
	hdl5Wj5cmawre0Nz5BG36ju9MLwIzMT9SlWCPEI/bPKxVo/JVF/gPJx8ueIKllLBcyOPhr6+MU=
X-Google-Smtp-Source: AGHT+IEAu7fkDKJgMxz47BVbyrtGz7mgbaYkkof+k+qkMcq5phDqEN9Tu7cM8AA5EbxoKtywfzHgaIx+YUqkXKDV3nM=
X-Received: by 2002:a2e:a58b:0:b0:367:997c:6399 with SMTP id
 38308e7fff4ca-373a74624b7mr606221fa.44.1759251644472; Tue, 30 Sep 2025
 10:00:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250811181848.99275-1-okorniev@redhat.com> <CAN-5tyEmf9HHMuXHDU86Y5FWYZz+ZYFKctmoLaCAB+DZ1zcXSQ@mail.gmail.com>
 <2b87402379d4c88545dabce30d2877722940f483.camel@kernel.org>
 <CACSpFtC3FbdGS6W6yKKwn+JcFmkSKE8yZRkQzuEWwRjAsZYkWQ@mail.gmail.com>
 <831f2ac457624092dcfadcf8b290fc65dc10e563.camel@kernel.org>
 <CACSpFtAqWdPPCbHLnXKGOmn7bR0fBjS9fj_J=i4aNnL+=8t1zA@mail.gmail.com> <CAN-5tyEY17k5SZ6hj2QsgW_006c-0ywS5H5vPvadj80bC0X=7w@mail.gmail.com>
In-Reply-To: <CAN-5tyEY17k5SZ6hj2QsgW_006c-0ywS5H5vPvadj80bC0X=7w@mail.gmail.com>
From: Olga Kornievskaia <aglo@umich.edu>
Date: Tue, 30 Sep 2025 13:00:32 -0400
X-Gm-Features: AS18NWB9rkVjyuYzgPYHT_RtoHywKKImoYmKt4sO310Sqti94VUyuMIxnUMSW5g
Message-ID: <CAN-5tyHrOcfz5JP8T1b1OHsQ398Fn6buk9F2RZbvSXX2Uva0=w@mail.gmail.com>
Subject: Re: [PATCH 1/1] NFSv4: handle ERR_GRACE on delegation recalls
To: Olga Kornievskaia <okorniev@redhat.com>
Cc: Trond Myklebust <trondmy@kernel.org>, anna.schumaker@oracle.com, 
	linux-nfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 29, 2025 at 1:49=E2=80=AFPM Olga Kornievskaia <aglo@umich.edu> =
wrote:
>
> On Fri, Sep 12, 2025 at 12:04=E2=80=AFPM Olga Kornievskaia <okorniev@redh=
at.com> wrote:
> >
> > On Fri, Sep 12, 2025 at 11:11=E2=80=AFAM Trond Myklebust <trondmy@kerne=
l.org> wrote:
> > >
> > > On Fri, 2025-09-12 at 10:41 -0400, Olga Kornievskaia wrote:
> > > > On Fri, Sep 12, 2025 at 10:29=E2=80=AFAM Trond Myklebust <trondmy@k=
ernel.org>
> > > > wrote:
> > > > >
> > > > > On Fri, 2025-09-12 at 10:21 -0400, Olga Kornievskaia wrote:
> > > > > > Any comments on or objections to this patch? It does lead to
> > > > > > possible
> > > > > > data corruption.
> > > > > >
> > > > >
> > > > > Sorry, I think was travelling when you originally sent this patch=
.
> > > > >
> > > > > > On Mon, Aug 11, 2025 at 2:25=E2=80=AFPM Olga Kornievskaia
> > > > > > <okorniev@redhat.com> wrote:
> > > > > > >
> > > > > > > RFC7530 states that clients should be prepared for the return
> > > > > > > of
> > > > > > > NFS4ERR_GRACE errors for non-reclaim lock and I/O requests.
> > > > > > >
> > > > > > > Signed-off-by: Olga Kornievskaia <okorniev@redhat.com>
> > > > > > > ---
> > > > > > >  fs/nfs/nfs4proc.c | 4 ++--
> > > > > > >  1 file changed, 2 insertions(+), 2 deletions(-)
> > > > > > >
> > > > > > > diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
> > > > > > > index 341740fa293d..fa9b81300604 100644
> > > > > > > --- a/fs/nfs/nfs4proc.c
> > > > > > > +++ b/fs/nfs/nfs4proc.c
> > > > > > > @@ -7867,10 +7867,10 @@ int nfs4_lock_delegation_recall(struc=
t
> > > > > > > file_lock *fl, struct nfs4_state *state,
> > > > > > >                 return err;
> > > > > > >         do {
> > > > > > >                 err =3D _nfs4_do_setlk(state, F_SETLK, fl,
> > > > > > > NFS_LOCK_NEW);
> > > > > > > -               if (err !=3D -NFS4ERR_DELAY)
> > > > > > > +               if (err !=3D -NFS4ERR_DELAY && err !=3D -
> > > > > > > NFS4ERR_GRACE)
> > > > > > >                         break;
> > > > > > >                 ssleep(1);
> > > > > > > -       } while (err =3D=3D -NFS4ERR_DELAY);
> > > > > > > +       } while (err =3D=3D -NFS4ERR_DELAY || err =3D=3D -
> > > > > > > NFSERR_GRACE);
> > > > > > >         return nfs4_handle_delegation_recall_error(server,
> > > > > > > state,
> > > > > > > stateid, fl, err);
> > > > > > >  }
> > > > > > >
> > > > > > > --
> > > > > > > 2.47.1
> > > > > > >
> > > > > > >
> > > > >
> > > > > Should the server be sending NFS4ERR_GRACE in this case, though?
> > > > > The
> > > > > client already holds a delegation, so it is clear that other
> > > > > clients
> > > > > cannot reclaim any locks that would conflict.
> > > > >
> > > > > ..or is the issue that this could happen before the client has a
> > > > > chance
> > > > > to reclaim the delegation after a reboot?
> > > >
> > > To answer my own question here: in that case the server would return
> > > NFS4ERR_BAD_STATEID, and not NFS4ERR_GRACE.
> > >
> > > > The scenario was, v4 client had an open file and a lock and upon
> > > > server reboot (during grace) sends the reclaim open, to which the
> > > > server replies with a delegation. How a v3 client comes in and
> > > > requests the same lock. The linux server at this point sends a
> > > > delegation recall to v4 client, the client sends its local lock
> > > > request and gets ERR_GRACE.
> > > >
> > > > And the spec explicitly notes as I mention in the commit comment th=
at
> > > > the client is supposed to handle ERR_GRACE for non-reclaim locks.
> > > > Thus
> > > > this patch.
> > > >
> > >
> > > Sure, however the same spec also says (Section 9.6.2.):
> > >
> > >    If the server can reliably determine that granting a non-reclaim
> > >    request will not conflict with reclamation of locks by other clien=
ts,
> > >    the NFS4ERR_GRACE error does not have to be returned and the
> > >    non-reclaim client request can be serviced.
> > >
> > > The server can definitely reliably determine that is the case here,
> > > since it already granted the delegation to the client.
> >
> > I'll take your word for it as I'm not that versed in the server code.
> > But it's an optimization and hard to argue that a server must do it
> > and thus the client really should handle the case that actually
> > happens in practice now?
> >
> > > I'm not saying that the client shouldn't also handle NFS4ERR_GRACE, b=
ut
> > > I am stating that the server shouldn't really be putting us in this
> > > situation in the first place.
> > > I'm also saying that if we're going to handle NFS4ERR_GRACE, then we
> > > also need to handle all the other possible errors under a reboot
> > > scenario.
> >
> > I don't see how the "if" and "then" are combined. I think if there are
> > other errors we don't handle in reclaim then we should but I don't see
> > it's conditional on handling ERR_GRACE error.
>
> What's the path forward here?

Trond, you mentioned "we also need to handle all the other possible
errors under a reboot scenario".

I could be wrong but I think ERR_GRACE is the only (critical)
unhandled error that's left. _nfs4_do_setlk() via
(nfs4_handle_setlk_error) handles (some) state errors and stale
clientid errors. I think session errors are handled by the
nfs41_sequence_process(). So we are left with ERR_GRACE? Isn't
ERR_GRACE and ERR_DELAY the only 2 errors that get handled by
nfs4_lock_expired and thus we should do the same in reboot recovery
case too?

>
> >
> > > --
> > > Trond Myklebust
> > > Linux NFS client maintainer, Hammerspace
> > > trondmy@kernel.org, trond.myklebust@hammerspace.com
> > >
> >


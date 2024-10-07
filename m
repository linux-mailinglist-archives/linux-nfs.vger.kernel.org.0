Return-Path: <linux-nfs+bounces-6909-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 85092993119
	for <lists+linux-nfs@lfdr.de>; Mon,  7 Oct 2024 17:26:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 089961F21648
	for <lists+linux-nfs@lfdr.de>; Mon,  7 Oct 2024 15:26:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9A571D86E1;
	Mon,  7 Oct 2024 15:26:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=umich.edu header.i=@umich.edu header.b="oSKAbY8f"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D8BA1D86D5;
	Mon,  7 Oct 2024 15:26:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728314801; cv=none; b=j5bzvypK08tB0PsV6W4BODaB3KP6jGPN+gSwz/npVCWvOtxrLywIk5Qy4pZ12xboMPc67XfaHRJ8FGcpSuqsP1oOUzWq2glWsM9qn3LqoCAR+GktZ3BsWNdV8JMa+lzT1HokN11gS6kGZ8rvrGm/4BhSDBsbr0A4B/iVATeBhLo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728314801; c=relaxed/simple;
	bh=Cwxab3OEYEQnKVD8IpuFZfg4FAWBq/eZGqQs5eWoeqQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nXAub/LIxmk5CYBwjxWQ/MY4t207uA0gro/IVz9/OJ9KrCA48J8oTM2yRzjxyCDIk61O/uvmv/xrWSGNijauj1xTbUQ0iIkbL8YYkooCPyLOUITa/zOe6/xaPqwP1uuHgE2xqnd1w+UxvKngy39hz6PPWSM63XuyJKmeefvUwgY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=umich.edu; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=umich.edu header.i=@umich.edu header.b=oSKAbY8f; arc=none smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=umich.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-2fac3f1287bso49458591fa.1;
        Mon, 07 Oct 2024 08:26:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umich.edu; s=google-2016-06-03; t=1728314798; x=1728919598; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NZzmI3/E+4zvUFPe267H6YGr4dzPAzhTWsYOYQT4nKc=;
        b=oSKAbY8f9KEIa7HD8T49YC8v7V2ClfxToWzA73vLwAg87j9dp1nWvmZl26J9/hiwo3
         CnzQFuc8/pbBRrZ90zBrZo7rGD8LUIJR08uQj7Dnd7yxIttGK4Nflz1ofuh2Rv9Hue84
         xRbqqEZuwFGiOUrNGkPkkjxUof9vrrdyblUnw+ROeVnfEIGCsuaO9wKKhfD2IuorGX+a
         O2MFP0fUIEV8wXaQ9bBcX6J2tjFchUdpvWYu2vw89vIgMYeVtgKlVQyWenRXKNWhtP08
         R6nY6MUBeR8afOZGyFCZ0QMWnAiogn5PnCqHCTYFtbL0g9Xd9BnTQ4LYvENN6auWz7Tg
         dKkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728314798; x=1728919598;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NZzmI3/E+4zvUFPe267H6YGr4dzPAzhTWsYOYQT4nKc=;
        b=GyVNqcqJ6Q8EnDW0QuOf3dNaNWVl8goptRAgbihKRorc2YQr/6Ik3ipUEmtWG9wwCb
         r01fIwCYUWSKJCjo21/TPtsLmGt9iTsORlcPKKxcQNlOZoxFVHHlrY+ZRlBXCMT2A48W
         VjSIVoDqDWghqTowXYHlynPdu8KC0fkLg2fE55ClwE3O/t8FgAWh+ZAR9ers1GAik5xD
         jxu/QGYKABgMGmhLGMjYVatS5+HDVeG7/ximl1Z54xZs8avslwfBzcHn0pkhYR8SlZql
         EFnpaj6rsBCbK5VBO410wfPqoFqzrgTQb8aB+cf+FszJqqnydXQ1PqOtj5QP7nQPPDbd
         NieQ==
X-Forwarded-Encrypted: i=1; AJvYcCUjNXH1nMGEbwqFtsvpM+BeWmRw5lqWDJMpyq20GBEpnedyVheUQp3iNhvR4y2ALS07oTap7wtH1PI=@vger.kernel.org, AJvYcCVldCyHdIi1Lpf7CMe+r7SX8QTtyw6w5k9OIvgKlYdhFUrWOutwx4j+ZgsJtEkFR4bbBhYerl/H@vger.kernel.org
X-Gm-Message-State: AOJu0YwDVZ/tURHYrt4sUGkDJtnHo6YpP/pKmxfKYW24OXR/u7d0p0tR
	qnNYGUME1UHqKR7SGfNNvMqpq5rZa553suit9w18ogQk+riBJ0kOt5qTL2yhKY1SZgVtwwH49uT
	8VqN3RagJ/dbl8RguafQKfz8nJYo=
X-Google-Smtp-Source: AGHT+IGojiny12Chfp+GslN/SL3gAhwspzeqsorG42D6HB8PDv5anfD7mEWfasq5TMCCusncpTIfTHbAzUXM2GZ4Gp8=
X-Received: by 2002:a2e:bc21:0:b0:2fa:d534:3ee7 with SMTP id
 38308e7fff4ca-2faf3d724dfmr59608961fa.35.1728314797484; Mon, 07 Oct 2024
 08:26:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ZwF96Z8i3XcxDe/z@tissot.1015granger.net> <172816225422.1692160.16192443029175940103@noble.neil.brown.name>
In-Reply-To: <172816225422.1692160.16192443029175940103@noble.neil.brown.name>
From: Olga Kornievskaia <aglo@umich.edu>
Date: Mon, 7 Oct 2024 11:26:25 -0400
Message-ID: <CAN-5tyE=XkZ9hfGOortUapxCc43_YkgSeN9+7oFf=M8xRFFxTw@mail.gmail.com>
Subject: Re: [PATCH 1/1] nfsd: fix possible badness in FREE_STATEID
To: NeilBrown <neilb@suse.de>
Cc: Chuck Lever <chuck.lever@oracle.com>, Jeff Layton <jlayton@kernel.org>, 
	Olga Kornievskaia <okorniev@redhat.com>, 
	"linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>, 
	"stable@vger.kernel.org" <stable@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Oct 5, 2024 at 5:09=E2=80=AFPM NeilBrown <neilb@suse.de> wrote:
>
> On Sun, 06 Oct 2024, Chuck Lever wrote:
> > On Sat, Oct 05, 2024 at 12:20:48PM -0400, Jeff Layton wrote:
> > > On Sat, 2024-10-05 at 10:53 -0400, Chuck Lever wrote:
> > > > On Fri, Oct 04, 2024 at 06:04:03PM -0400, Olga Kornievskaia wrote:
> > > > > When multiple FREE_STATEIDs are sent for the same delegation stat=
eid,
> > > > > it can lead to a possible either use-after-tree or counter refcou=
nt
> > > > > underflow errors.
> > > > >
> > > > > In nfsd4_free_stateid() under the client lock we find a delegatio=
n
> > > > > stateid, however the code drops the lock before calling nfs4_put_=
stid(),
> > > > > that allows another FREE_STATE to find the stateid again. The fir=
st one
> > > > > will proceed to then free the stateid which leads to either
> > > > > use-after-free or decrementing already zerod counter.
> > > > >
> > > > > CC: stable@vger.kernel.org
> > > >
> > > > I assume that the broken commit is pretty old, but this fix does no=
t
> > > > apply before v6.9 (where sc_status is introduced). I can add
> > > > "# v6.9+" to the Cc: stable tag.
> > > >
> > >
> > > I don't know. It looks like nfsd4_free_stateid always returned
> > > NFS4ERR_LOCKS_HELD on a delegation stateid until 3f29cc82a84c.
> > >
> > > > But what do folks think about a Fixes: tag?
> > > >
> > > > Could be e1ca12dfb1be ("NFSD: added FREE_STATEID operation"), but
> > > > that doesn't have the switch statement, which was added by
> > > > 2da1cec713bc ("nfsd4: simplify free_stateid").
> > > >
> > > >
> > >
> > > Maybe this one?
> > >
> > >     3f29cc82a84c nfsd: split sc_status out of sc_type
> > >
> > > That particular bit of the code (and the SC_STATUS_CLOSED flag) was
> > > added in that patch, and I don't think you'd want to apply this patch
> > > to anything that didn't have it.
> >
> > OK, if we believe that 3f29cc82 is where the misbehavior started,
> > then I can replace the "Cc: stable@" with "Fixes: 3f29cc82a84c".
>
> I believe the misbehaviour started with
> Commit: b0fc29d6fcd0 ("nfsd: Ensure stateids remain unique until they are=
 freed")
> in v3.18.
>
> The bug in the current code is that it assumes that
>
>         list_del_init(&dp->dl_recall_lru);
>
> actually removes from the the dl_recall_lru, and so a reference must be
> dropped.  But if it wasn't on the list, then that is wrong.

I've actually been chasing a different problem (a UAF) and Ben noticed
a problem with doing a double free (by double free_stateid) which this
patch addresses. But, this particular line list_del_init() in
nfsd4_free_stateid() has been bothering me as I thought this access
should be guarded by the "state_lock"? Though I have to admit I've
tried that and it doesn't seem to help my UAF problem. Anyway where
I'm going with it perhaps the guard "if
(!list_empty(&dp->dl_recall_lru))" is still needed (not for double
free_stateid by from other possibilities)?

I was wondering if the nfsd4_free_stateid() somehow could steal the
entries from the list while the laundromat is going thru the
revocation process. The problem I believe is that the laundromat
thread marks the delegation "revoked" but somehow never ends up
calling destroy_delegation() (destoy_delegation is the place that
frees the lease -- but instead we are left with a lease on the file
which causes a new open to call into break_lease() which ends up doing
a UAF on a freed delegation stateid -- which was freed by the
free_stateid).


> So a "if (!list_empty(&dp->dl_recall_lru))" guard might also fix the
> bug (though adding SC_STATUS_CLOSED is a better fix I think).
>
> Prior to the above 3.17 commit, the relevant code was
>
>  static void destroy_revoked_delegation(struct nfs4_delegation *dp)
>  {
>         list_del_init(&dp->dl_recall_lru);
>         remove_stid(&dp->dl_stid);
>         nfs4_put_delegation(dp);
>  }
>
> so the revoked delegation would be removed (remove_stid) from the idr
> and a subsequent FREE_STATEID request would not find it.
> The commit removed the remove_stid() call but didn't do anything to
> prevent the free_stateid being repeated.
> In that kernel it might have been appropriate to set
>   dp->dl_stid.sc_type =3D NFS4_CLOSED_DELEG_STID;
> was done to unhash_delegation() in that patch.
>
> So I think we should declare
> Fixes: b0fc29d6fcd0 ("nfsd: Ensure stateids remain unique until they are =
freed")
>
> and be prepared to provide alternate patches for older kernels.
>
> NeilBrown
>
> >
> >
> > > > > Signed-off-by: Olga Kornievskaia <okorniev@redhat.com>
> > > > > ---
> > > > >  fs/nfsd/nfs4state.c | 1 +
> > > > >  1 file changed, 1 insertion(+)
> > > > >
> > > > > diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
> > > > > index ac1859c7cc9d..56b261608af4 100644
> > > > > --- a/fs/nfsd/nfs4state.c
> > > > > +++ b/fs/nfsd/nfs4state.c
> > > > > @@ -7154,6 +7154,7 @@ nfsd4_free_stateid(struct svc_rqst *rqstp, =
struct nfsd4_compound_state *cstate,
> > > > >         switch (s->sc_type) {
> > > > >         case SC_TYPE_DELEG:
> > > > >                 if (s->sc_status & SC_STATUS_REVOKED) {
> > > > > +                       s->sc_status |=3D SC_STATUS_CLOSED;
> > > > >                         spin_unlock(&s->sc_lock);
> > > > >                         dp =3D delegstateid(s);
> > > > >                         list_del_init(&dp->dl_recall_lru);
> > > > > --
> > > > > 2.43.5
> > > > >
> > > >
> > >
> > > --
> > > Jeff Layton <jlayton@kernel.org>
> >
> > --
> > Chuck Lever
> >
>
>


Return-Path: <linux-nfs+bounces-13846-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 23214B301E1
	for <lists+linux-nfs@lfdr.de>; Thu, 21 Aug 2025 20:20:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8FD14AE0553
	for <lists+linux-nfs@lfdr.de>; Thu, 21 Aug 2025 18:20:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 340B6343D8A;
	Thu, 21 Aug 2025 18:20:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=umich.edu header.i=@umich.edu header.b="fPNOYZqi"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF14C305E26
	for <linux-nfs@vger.kernel.org>; Thu, 21 Aug 2025 18:20:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755800421; cv=none; b=GXTs5ldExI5APJi7PMROz42tQRRxqIlM3IGDPEV1T7OlVdjipADYD3SMNJeIl71NPF0aS/5p2+lbG33t2HERRMUluFhnzhYUxQF0MVFCMDiW5vTFm/ifF6H6gGX0wnJDZN/btvxKH4lTWgc+nwhuVqOBF2VsGrSMVoHYkWrYnmE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755800421; c=relaxed/simple;
	bh=gMNjHuExMNN+uc7lG1T/VYWkLv+oTrCvRB2IDVg2J+g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jw3ov0j6omvNj4KxK/8Pq2bTiG0vkcFkO3ScsJ/t1oFcBQA52VRpe/FIDnJlC99lJeIXBTAgWYVhyNLvn0PAI32CpS/NMu9v/x+O0fWqHsMbbqHUzUxUqAkBQY3Zc8k2ZZ9DiAAv3QAryqBCKfcl9YJztOiqj2GqzMcDpGDL/ag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=umich.edu; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=umich.edu header.i=@umich.edu header.b=fPNOYZqi; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=umich.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-55ce527ffbfso1202535e87.3
        for <linux-nfs@vger.kernel.org>; Thu, 21 Aug 2025 11:20:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umich.edu; s=google-2016-06-03; t=1755800416; x=1756405216; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kYbxQgi7tkNZcp9G5qvmiixvl5GQdvbJ6Wy530vV8xU=;
        b=fPNOYZqiVocU4kpQVZMO3h3UZFdCqrA3iKd7sKTSEpQ/D9JlB5kMw4Ew1gvvQkkLrm
         iXZiaAq3bh4nsvKv4eZMeg1/3a8ohGrI7nL0tfW3e8RxrTv5mHLTMAMKzY18yAOgySpw
         WwGyAmQbJCCVEKi79/ectrqlckfOb13kn4gNqJCqbOMOLTXXSSY9rs7QTIpEmFSkBoBc
         stUanhb9HDDRyW/zQoXC8dn9BewiXXgR2JpgNiVAt1zRYgbCq9QkMmRQcr0HMeBCUYxY
         pjD9zMg9YSu50U0xIv7mYUWxHRPr8fPFVsZHe9L1u8j9WQdmQ2i1YbmwojQ2H5DSq4Xt
         gpCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755800416; x=1756405216;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kYbxQgi7tkNZcp9G5qvmiixvl5GQdvbJ6Wy530vV8xU=;
        b=Aj2PeTfn7KhHLTLS9CbAmS2L/RNbA95A8iLS0oWJGIT/rPsLaMHO5Svv6ZYLU8r4/R
         mKWCV5JwZXCk83dhABC2vPQU9NsOFTfFOyElttdmgNN5P9n6u69fI+pafQb/jsO+Cgzb
         OeULytZiSpvXf5sXpqmaNFdYig8Z/4Vspe2qBieLMbSCzXJpXBU4Cvi8hqQ0xToa9z0j
         FRV3qwWNbuvUGM0bkF6FVpaG0FLqVDBrqJo+2SpBmasx+63pE1p9HrepwEWuWUEA9DpT
         04WcLqe9/Ko3Tb2EXs8A0EYl2NTyoHqFvXVbhD4XK0waeGKFp0e/aRpyIociSZyARmyt
         xnPQ==
X-Forwarded-Encrypted: i=1; AJvYcCVHK+G6/vHbaY+4GVpgNGyiTVynKZwl2ZBpwzGpkR/hJo57uwpcX+l++pGYh1qMHRH1zt+dSeMsjwk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw5rRdcroVpYc77h6yoorm3j0qSn7rZR/uexgZPtTYJu477NaVH
	r1MjkNILau6LLFoSYPlhfq6WsbcZYa8O4XsiXR0WHncxu+vQL1YGra+YG0JYhtSz1rSFO0WbV7a
	8zljWSR+JiEO4Om89AHmo3zAxe/OIZj0=
X-Gm-Gg: ASbGncu+i/W6+Vwddeqja2rxTVLDmLD1luiBsDUlr3Bxk0fZ9/az2HfesWnpsMri6Wd
	up2QXb5jjnIDkS7Ih0mLvcr7h+Xb3B5y2pPPySODQbrkPjHkdAHAc9WkPCFhK4nxHJP8WUJNVGz
	2eDgA72MVzlNoo1UPCnoY2cJVyLRL/4ed78RTbobkUUHZFgAoZ/5eqQNGNAVePiaoyyS+ZgKKdi
	bcLcGPsTunZd10Y3DQwH8DwuQWtBAltgUwspO8e0g==
X-Google-Smtp-Source: AGHT+IGoJ2m7R1LutqGC42Trqrk73R5aUmwa3b/NJMddPpMh/r5eJnziFuLU89xPZ/I0uXM44tXslh9pgnZ7AtUzUT0=
X-Received: by 2002:a05:6512:3d87:b0:55c:d64e:f941 with SMTP id
 2adb3069b0e04-55f0ccefb10mr128140e87.1.1755800416197; Thu, 21 Aug 2025
 11:20:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAN-5tyEammkfv3QGwe5Z38q1nFAxYV=REFDN++3XrX7Lni+H0A@mail.gmail.com>
 <175573171079.2234665.16260718612520667514@noble.neil.brown.name>
 <CAN-5tyGXxzmMipt8fcdMkpSiPq8cxF5++OJcZriQbcjk9JK3GA@mail.gmail.com> <8d72170c-ac40-4652-96ef-5ca39b2cb0c6@oracle.com>
In-Reply-To: <8d72170c-ac40-4652-96ef-5ca39b2cb0c6@oracle.com>
From: Olga Kornievskaia <aglo@umich.edu>
Date: Thu, 21 Aug 2025 14:20:04 -0400
X-Gm-Features: Ac12FXwTKDa_9RtewW-uozUHKK7ALJ7XIemb7nk8jh9I4aumYHpAHZzzFUCMBdc
Message-ID: <CAN-5tyH4qbcxLDaEnnFABHSC3DPpHmMk8O+GEOX1BubfLS5cww@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] lockd: while grace prefer to fail with nlm_lck_denied_grace_period
To: Chuck Lever <chuck.lever@oracle.com>
Cc: NeilBrown <neil@brown.name>, Olga Kornievskaia <okorniev@redhat.com>, jlayton@kernel.org, 
	linux-nfs@vger.kernel.org, Dai.Ngo@oracle.com, tom@talpey.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 21, 2025 at 11:09=E2=80=AFAM Chuck Lever <chuck.lever@oracle.co=
m> wrote:
>
> On 8/21/25 9:56 AM, Olga Kornievskaia wrote:
> > On Wed, Aug 20, 2025 at 7:15=E2=80=AFPM NeilBrown <neil@brown.name> wro=
te:
> >>
> >> On Thu, 14 Aug 2025, Olga Kornievskaia wrote:
> >>> On Tue, Aug 12, 2025 at 8:05=E2=80=AFPM NeilBrown <neil@brown.name> w=
rote:
> >>>>
> >>>> On Wed, 13 Aug 2025, Olga Kornievskaia wrote:
> >>>>> When nfsd is in grace and receives an NLM LOCK request which turns
> >>>>> out to have a conflicting delegation, return that the server is in
> >>>>> grace.
> >>>>>
> >>>>> Reviewed-by: Jeff Layton <jlayton@redhat.com>
> >>>>> Signed-off-by: Olga Kornievskaia <okorniev@redhat.com>
> >>>>> ---
> >>>>>  fs/lockd/svc4proc.c | 15 +++++++++++++--
> >>>>>  1 file changed, 13 insertions(+), 2 deletions(-)
> >>>>>
> >>>>> diff --git a/fs/lockd/svc4proc.c b/fs/lockd/svc4proc.c
> >>>>> index 109e5caae8c7..7ac4af5c9875 100644
> >>>>> --- a/fs/lockd/svc4proc.c
> >>>>> +++ b/fs/lockd/svc4proc.c
> >>>>> @@ -141,8 +141,19 @@ __nlm4svc_proc_lock(struct svc_rqst *rqstp, st=
ruct nlm_res *resp)
> >>>>>       resp->cookie =3D argp->cookie;
> >>>>>
> >>>>>       /* Obtain client and file */
> >>>>> -     if ((resp->status =3D nlm4svc_retrieve_args(rqstp, argp, &hos=
t, &file)))
> >>>>> -             return resp->status =3D=3D nlm_drop_reply ? rpc_drop_=
reply :rpc_success;
> >>>>> +     resp->status =3D nlm4svc_retrieve_args(rqstp, argp, &host, &f=
ile);
> >>>>> +     switch (resp->status) {
> >>>>> +     case 0:
> >>>>> +             break;
> >>>>> +     case nlm_drop_reply:
> >>>>> +             if (locks_in_grace(SVC_NET(rqstp))) {
> >>>>> +                     resp->status =3D nlm_lck_denied_grace_period;
> >>>>
> >>>> I think this is wrong.  If the lock request has the "reclaim" flag s=
et,
> >>>> then nlm_lck_denied_grace_period is not a meaningful error.
> >>>> nlm4svc_retrieve_args() returns nlm_drop_reply when there is a delay
> >>>> getting a response to an upcall to mountd.  For NLM the request real=
ly
> >>>> must be dropped.
> >>>
> >>> Thank you for pointing out this case so we are suggesting to.
> >>>
> >>> if (locks_in_grace(SVC_NET(rqstp)) && !argp->reclaim)
> >>>
> >>> However, I've been looking and looking but I cannot figure out how
> >>> nlm4svc_retrieve_args() would ever get nlm_drop_reply. You say it can
> >>> happen during the upcall to mountd. So that happens within nfsd_open(=
)
> >>> call and a part of fh_verify().
> >>> To return nlm_drop_reply, nlm_fopen() must have gotten nfserr_dropit
> >>> from the nfsd_open().  I have searched and searched but I don't see
> >>> anything that ever sets nfserr_dropit (NFSERR_DROPIT).
> >>>
> >>> I searched the logs and nfserr_dropit was an error that was EAGAIN
> >>> translated into but then removed by the following patch.
> >>
> >> Oh.  I didn't know that.
> >> We now use RQ_DROPME instead.
> >> I guess we should remove NFSERR_DROPIT completely as it not used at al=
l
> >> any more.
> >>
> >> Though returning nfserr_jukebox to an v2 client isn't a good idea....
> >
> > I'll take your word for you.
> >
> >> So I guess my main complaint isn't valid, but I still don't like this
> >> patch.  It seems an untidy place to put the locks_in_grace test.
> >> Other callers of nlm4svc_retrieve_args() check locks_in_grace() before
> >> making that call.  __nlm4svc_proc_lock probably should too.  Or is the=
re
> >> a reason that it is delayed until the middle of nlmsvc_lock()..
> >
> > I thought the same about why not adding the in_grace check and decided
> > that it was probably because you dont want to deny a lock if there are
> > no conflicts. If we add it, somebody might notice and will complain
> > that they can't get their lock when there are no conflicts.
> >
> >> The patch is not needed and isn't clearly an improvement, so I would
> >> rather it were dropped.
> >
> > I'm not against dropping this patch if the conclusion is that dropping
> > the packet is no worse than returning in_grace error.
>
> I dropped both of these from nfsd-testing. If a fix is still needed,
> let's start again with fresh patches.

Can you clarify when you said "both"?

What objections are there for the 1st patch in the series. It solves a
problem and a fix is needed. This one I agree is not needed but I
thought was an improvement.

>
>
> >> Thanks,
> >> NeilBrown
> >>
> >>
> >>>
> >>> commit 062304a815fe10068c478a4a3f28cf091c55cb82
> >>> Author: J. Bruce Fields <bfields@fieldses.org>
> >>> Date:   Sun Jan 2 22:05:33 2011 -0500
> >>>
> >>>     nfsd: stop translating EAGAIN to nfserr_dropit
> >>>
> >>> diff --git a/fs/nfsd/nfsproc.c b/fs/nfsd/nfsproc.c
> >>> index dc9c2e3fd1b8..fd608a27a8d5 100644
> >>> --- a/fs/nfsd/nfsproc.c
> >>> +++ b/fs/nfsd/nfsproc.c
> >>> @@ -735,7 +735,8 @@ nfserrno (int errno)
> >>>                 { nfserr_stale, -ESTALE },
> >>>                 { nfserr_jukebox, -ETIMEDOUT },
> >>>                 { nfserr_jukebox, -ERESTARTSYS },
> >>> -               { nfserr_dropit, -EAGAIN },
> >>> +               { nfserr_jukebox, -EAGAIN },
> >>> +               { nfserr_jukebox, -EWOULDBLOCK },
> >>>                 { nfserr_jukebox, -ENOMEM },
> >>>                 { nfserr_badname, -ESRCH },
> >>>                 { nfserr_io, -ETXTBSY },
> >>>
> >>> so if fh_verify is failing whatever it is returning, it is not
> >>> nfserr_dropit nor is it nfserr_jukebox which means nlm_fopen() would
> >>> translate it to nlm_failed which with my patch would not trigger
> >>> nlm_lck_denied_grace_period error but resp->status would be set to
> >>> nlm_failed.
> >>>
> >>> So I circle back to I hope that convinces you that we don't need a
> >>> check for the reclaim lock.
> >>>
> >>> I believe nlm_drop_reply is nfsd_open's jukebox error, one of which i=
s
> >>> delegation recall. it can be a memory failure. But I'm sure when
> >>> EWOULDBLOCK occurs.
> >>>
> >>>> At the very least we need to guard against the reclaim flag being se=
t in
> >>>> the above test.  But I would much rather a more clear distinction we=
re
> >>>> made between "drop because of a conflicting delegation" and "drop
> >>>> because of a delay getting upcall response".
> >>>> Maybe a new "nlm_conflicting_delegtion" return from ->fopen which nl=
m4
> >>>> (and ideally nlm2) handles appropriately.
> >>>
> >>>
> >>>> NeilBrown
> >>>>
> >>>>
> >>>>> +                     return rpc_success;
> >>>>> +             }
> >>>>> +             return nlm_drop_reply;
> >>>>> +     default:
> >>>>> +             return rpc_success;
> >>>>> +     }
> >>>>>
> >>>>>       /* Now try to lock the file */
> >>>>>       resp->status =3D nlmsvc_lock(rqstp, file, host, &argp->lock,
> >>>>> --
> >>>>> 2.47.1
> >>>>>
> >>>>>
> >>>>
> >>>>
> >>>
> >>
>
>
> --
> Chuck Lever


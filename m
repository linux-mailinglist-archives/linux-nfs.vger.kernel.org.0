Return-Path: <linux-nfs+bounces-13851-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AFC1B302B7
	for <lists+linux-nfs@lfdr.de>; Thu, 21 Aug 2025 21:16:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0BF131CE3779
	for <lists+linux-nfs@lfdr.de>; Thu, 21 Aug 2025 19:16:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71FA2748F;
	Thu, 21 Aug 2025 19:15:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=umich.edu header.i=@umich.edu header.b="M/eU42wd"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4671BE56A
	for <linux-nfs@vger.kernel.org>; Thu, 21 Aug 2025 19:15:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755803736; cv=none; b=lxQ7sTkbD97Jcy937w4hlmJTlsTtwcl2FcsG6cQQVTq5TRgRWU96+i5vlpnpuWMX2wkt3K4QKxyGCvGuHV4NM29wK/TjD7lKCmYeMGCi430wZf9VvB7+WbCDijh4qYfI6T/seNftK9Z47fVLNec/UYLE9Sa5asIXy4+3E0LcYOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755803736; c=relaxed/simple;
	bh=JEKforClnaQzH609QqGZXg5xmdKFm3NA5AZZk40esT4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jxPR2cF46yRGn7cHNPxPKdKBflbW396yAmaAySZeLCuFLmOFgWx3BHttzwdqs06IoC9MTjLugA2AfyfPiHBiBHlXII3uiXT+NAawDnV50hBYYaqnkfQ5s67288baDrFu/C1006WOaHxXIfS4SSxrLPQdCz8wwn73lbccE0VWu+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=umich.edu; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=umich.edu header.i=@umich.edu header.b=M/eU42wd; arc=none smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=umich.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-333f8d1ecffso11713551fa.0
        for <linux-nfs@vger.kernel.org>; Thu, 21 Aug 2025 12:15:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umich.edu; s=google-2016-06-03; t=1755803732; x=1756408532; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g4soZWYXMEzJLctjhinKLMFmX4cP0+Sgf9Js9bIxP/0=;
        b=M/eU42wdAsK99Ulgq42OwpZq7aB0Wryn/MRrD0GdNkL3gPjHplTXSB9IAwnnUyDjlz
         lDmvWM2bMPbY4xwGA2tCy21GjQEcrNO5HGDGuxbmTqCCHDrRzNfclt5YkItCeNMj/AF8
         Uv7hOn7NsH/2NDj8q43OzKouKnTdHTZg+IHIRylQSnbviadpXsoII1g/8loWhA4F3dny
         cl/79BxYYvOOHhzFzH8pW3Rbb1hDP9nTT05e9zaWkifKPQg+QvA6j9jyyuWE9K4bF3nQ
         hSDjv7Am9yIdFpMKv2yXiSPjN3RbQtkSZiseaB4xKhn3uL9+kwvn7jwQD4RJL7Y1qzMf
         n89g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755803732; x=1756408532;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=g4soZWYXMEzJLctjhinKLMFmX4cP0+Sgf9Js9bIxP/0=;
        b=Zej3DZw1m0YvoLCX3H3TYyr1V2Gm0U0BemL+ETPLAtBCyEJSQuAhg2ROdxapdO6RZl
         2XlsEy22kj3+km7f345iPIjZ7Z6kB8NMAPrmyYu6RjazQjlG4hjU56GMjXOEGyLSqPqI
         2bsnY4u2+2NAf8CtfyPzP5NnbgdbDDG2nnrk21FwwUmuUb7ilS1bwlvFXECcYfD17WEl
         NkWiOb0h1MB5fRhtHmWpvVUg6xMXgEeK/WAG+FXSWWbX5kNOthH46FCj2C9YP2EhwgKD
         9Xxvx0wSJOZnwDQ/FZ3DMuRNgVxOcdYOsl1imXnYVDwHVRRb9O9RZttkpitRJpvApHHb
         O+WQ==
X-Forwarded-Encrypted: i=1; AJvYcCW0GBaiY52b4pnTiGyYyaw/oCvsVJFNjKP0SBn6aRWIy+BG/zcrJOQ1iSp0aR1shZMVFI3jh1jSr+k=@vger.kernel.org
X-Gm-Message-State: AOJu0YylG28VUdJpgKDXNelwMREZhjeJXJ0VK/lVxqm68jG6T6/jSF30
	LfVrh0d9G05yyhzBRL8HMbWYaEvgFSy5ofhFE4bUMFjYXA3xlTjiBKDj0D/BrEGoTraDyma89bI
	0LULQiMi1XGcQX9N8tBS6lnd5ThSPhJA=
X-Gm-Gg: ASbGncth03LiUVO/8VNAv7lB3d7AOxRboJ9+mf3rshDYQHjrkPuX07ABU6IReAKEIIi
	oa84y6iPnGeW75yj5XIXWIPPTeU8JQHCvbKooMPepnddMochqyyqTLjwXCMcFNrriCqVWUsx3tg
	boapEpup8238OGcQru+GyuOnmd9Zx0YPrqXXOv+8mcTSNdKytOC3rL32fTLAmRJsX99UcZyoy8p
	W2eZ6RpzDTcBLQCG+DTInKUm/P5GYEt3PJ6EUdezA==
X-Google-Smtp-Source: AGHT+IEdmxRBikq50JGdDz9tEvPNqNpe69LXbtvCRlqB30o/C14YYmx5ZdWbLS7UFvqX1ix8lHFCw8RBBldSk5ZL/40=
X-Received: by 2002:a05:651c:f0c:b0:32a:6aa0:2173 with SMTP id
 38308e7fff4ca-33650f99354mr529731fa.20.1755803731968; Thu, 21 Aug 2025
 12:15:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAN-5tyEammkfv3QGwe5Z38q1nFAxYV=REFDN++3XrX7Lni+H0A@mail.gmail.com>
 <175573171079.2234665.16260718612520667514@noble.neil.brown.name>
 <CAN-5tyGXxzmMipt8fcdMkpSiPq8cxF5++OJcZriQbcjk9JK3GA@mail.gmail.com>
 <8d72170c-ac40-4652-96ef-5ca39b2cb0c6@oracle.com> <CAN-5tyH4qbcxLDaEnnFABHSC3DPpHmMk8O+GEOX1BubfLS5cww@mail.gmail.com>
 <f54c0edf-18b3-4432-af0b-7caac995fe01@oracle.com> <CAN-5tyF7wqG6_n_x4rNCKeLmkChGDA74TWduun8HahVuHfHbZw@mail.gmail.com>
 <fc97f4d3-6f0d-4ead-adb5-68cea81bd38f@oracle.com>
In-Reply-To: <fc97f4d3-6f0d-4ead-adb5-68cea81bd38f@oracle.com>
From: Olga Kornievskaia <aglo@umich.edu>
Date: Thu, 21 Aug 2025 15:15:20 -0400
X-Gm-Features: Ac12FXyZODZ_T1_O8cLgYMgZtDYB-scPAo2k1gLZKyy8mpaPeoEf21jSaK3TP_g
Message-ID: <CAN-5tyEixqKLAuY=BthE=WHyZd_CQ0kLQJuUzLoeQQgCutrOxQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] lockd: while grace prefer to fail with nlm_lck_denied_grace_period
To: Chuck Lever <chuck.lever@oracle.com>
Cc: NeilBrown <neil@brown.name>, Olga Kornievskaia <okorniev@redhat.com>, jlayton@kernel.org, 
	linux-nfs@vger.kernel.org, Dai.Ngo@oracle.com, tom@talpey.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 21, 2025 at 2:39=E2=80=AFPM Chuck Lever <chuck.lever@oracle.com=
> wrote:
>
> On 8/21/25 2:33 PM, Olga Kornievskaia wrote:
> > On Thu, Aug 21, 2025 at 2:24=E2=80=AFPM Chuck Lever <chuck.lever@oracle=
.com> wrote:
> >>
> >> On 8/21/25 2:20 PM, Olga Kornievskaia wrote:
> >>> On Thu, Aug 21, 2025 at 11:09=E2=80=AFAM Chuck Lever <chuck.lever@ora=
cle.com> wrote:
> >>>>
> >>>> On 8/21/25 9:56 AM, Olga Kornievskaia wrote:
> >>>>> On Wed, Aug 20, 2025 at 7:15=E2=80=AFPM NeilBrown <neil@brown.name>=
 wrote:
> >>>>>>
> >>>>>> On Thu, 14 Aug 2025, Olga Kornievskaia wrote:
> >>>>>>> On Tue, Aug 12, 2025 at 8:05=E2=80=AFPM NeilBrown <neil@brown.nam=
e> wrote:
> >>>>>>>>
> >>>>>>>> On Wed, 13 Aug 2025, Olga Kornievskaia wrote:
> >>>>>>>>> When nfsd is in grace and receives an NLM LOCK request which tu=
rns
> >>>>>>>>> out to have a conflicting delegation, return that the server is=
 in
> >>>>>>>>> grace.
> >>>>>>>>>
> >>>>>>>>> Reviewed-by: Jeff Layton <jlayton@redhat.com>
> >>>>>>>>> Signed-off-by: Olga Kornievskaia <okorniev@redhat.com>
> >>>>>>>>> ---
> >>>>>>>>>  fs/lockd/svc4proc.c | 15 +++++++++++++--
> >>>>>>>>>  1 file changed, 13 insertions(+), 2 deletions(-)
> >>>>>>>>>
> >>>>>>>>> diff --git a/fs/lockd/svc4proc.c b/fs/lockd/svc4proc.c
> >>>>>>>>> index 109e5caae8c7..7ac4af5c9875 100644
> >>>>>>>>> --- a/fs/lockd/svc4proc.c
> >>>>>>>>> +++ b/fs/lockd/svc4proc.c
> >>>>>>>>> @@ -141,8 +141,19 @@ __nlm4svc_proc_lock(struct svc_rqst *rqstp=
, struct nlm_res *resp)
> >>>>>>>>>       resp->cookie =3D argp->cookie;
> >>>>>>>>>
> >>>>>>>>>       /* Obtain client and file */
> >>>>>>>>> -     if ((resp->status =3D nlm4svc_retrieve_args(rqstp, argp, =
&host, &file)))
> >>>>>>>>> -             return resp->status =3D=3D nlm_drop_reply ? rpc_d=
rop_reply :rpc_success;
> >>>>>>>>> +     resp->status =3D nlm4svc_retrieve_args(rqstp, argp, &host=
, &file);
> >>>>>>>>> +     switch (resp->status) {
> >>>>>>>>> +     case 0:
> >>>>>>>>> +             break;
> >>>>>>>>> +     case nlm_drop_reply:
> >>>>>>>>> +             if (locks_in_grace(SVC_NET(rqstp))) {
> >>>>>>>>> +                     resp->status =3D nlm_lck_denied_grace_per=
iod;
> >>>>>>>>
> >>>>>>>> I think this is wrong.  If the lock request has the "reclaim" fl=
ag set,
> >>>>>>>> then nlm_lck_denied_grace_period is not a meaningful error.
> >>>>>>>> nlm4svc_retrieve_args() returns nlm_drop_reply when there is a d=
elay
> >>>>>>>> getting a response to an upcall to mountd.  For NLM the request =
really
> >>>>>>>> must be dropped.
> >>>>>>>
> >>>>>>> Thank you for pointing out this case so we are suggesting to.
> >>>>>>>
> >>>>>>> if (locks_in_grace(SVC_NET(rqstp)) && !argp->reclaim)
> >>>>>>>
> >>>>>>> However, I've been looking and looking but I cannot figure out ho=
w
> >>>>>>> nlm4svc_retrieve_args() would ever get nlm_drop_reply. You say it=
 can
> >>>>>>> happen during the upcall to mountd. So that happens within nfsd_o=
pen()
> >>>>>>> call and a part of fh_verify().
> >>>>>>> To return nlm_drop_reply, nlm_fopen() must have gotten nfserr_dro=
pit
> >>>>>>> from the nfsd_open().  I have searched and searched but I don't s=
ee
> >>>>>>> anything that ever sets nfserr_dropit (NFSERR_DROPIT).
> >>>>>>>
> >>>>>>> I searched the logs and nfserr_dropit was an error that was EAGAI=
N
> >>>>>>> translated into but then removed by the following patch.
> >>>>>>
> >>>>>> Oh.  I didn't know that.
> >>>>>> We now use RQ_DROPME instead.
> >>>>>> I guess we should remove NFSERR_DROPIT completely as it not used a=
t all
> >>>>>> any more.
> >>>>>>
> >>>>>> Though returning nfserr_jukebox to an v2 client isn't a good idea.=
...
> >>>>>
> >>>>> I'll take your word for you.
> >>>>>
> >>>>>> So I guess my main complaint isn't valid, but I still don't like t=
his
> >>>>>> patch.  It seems an untidy place to put the locks_in_grace test.
> >>>>>> Other callers of nlm4svc_retrieve_args() check locks_in_grace() be=
fore
> >>>>>> making that call.  __nlm4svc_proc_lock probably should too.  Or is=
 there
> >>>>>> a reason that it is delayed until the middle of nlmsvc_lock()..
> >>>>>
> >>>>> I thought the same about why not adding the in_grace check and deci=
ded
> >>>>> that it was probably because you dont want to deny a lock if there =
are
> >>>>> no conflicts. If we add it, somebody might notice and will complain
> >>>>> that they can't get their lock when there are no conflicts.
> >>>>>
> >>>>>> The patch is not needed and isn't clearly an improvement, so I wou=
ld
> >>>>>> rather it were dropped.
> >>>>>
> >>>>> I'm not against dropping this patch if the conclusion is that dropp=
ing
> >>>>> the packet is no worse than returning in_grace error.
> >>>>
> >>>> I dropped both of these from nfsd-testing. If a fix is still needed,
> >>>> let's start again with fresh patches.
> >>>
> >>> Can you clarify when you said "both"?
> >>>
> >>> What objections are there for the 1st patch in the series. It solves =
a
> >>> problem and a fix is needed.
> >>
> >> There are two reasons to drop the first patch.
> >>
> >> 1. Neil's "remove nfserr_dropit" patch doesn't apply unless both patch=
es
> >> are reverted.
> >>
> >> 2. As I said above, NFSv2 does not have a mechanism like NFS3ERR_JUKEB=
OX
> >> to request that the client wait a bit and resend.
> >
> > ERR_JUKEBOX is not returned to another v2 or v3.
> >
> > Patch1 (nfsd: nfserr_jukebox in nlm_fopen should lead to a retry)
> > translates err_jukebox into the nlm_drop_reply and returns to lockd.
> > As the result, no error is returned to the client but the reply is
> > dropped all together.
>
> If you want NLM to drop the response, then set RQ_DROPME. Using
> nfserr_jukebox here is confusing -- it means "return a response to the
> client that requests a resend". You want NLM to /not send a response/,
> and we have a specific mechanism for that.

I don't understand why the suggestion holds value.

nlm_open() is going to call nfsd_open() which will return
nfserr_jukebox (for among other conditions) when there is a
conflicting delegation. Currently, nlm_fopen() would return nlm_failed
(it does not recognize nfserr_jukebox error code). nlm_fopen() has to
identify that nfserr_jukebox error as special to mean that the request
needs to be dropped. There is already a mechanism for it and that is
to return nlm_drop_reply.

What purpose would be to set RQ_DROPME for the nfserr_jukebox in
nlm_fopen() (note that nfserr_jukebox needs to be identified) . What
error should one be returning instead of "nlm_drop_reply"?  Why is
returning some other error code + setting RQ_DROPME be more "clear"?

>
>
> >> So, if 1/2 has been tested with NFSv2 and does not cause NFSD to leak
> >> nfserr_jukebox to NFSv2 clients, then please rebase that one on the
> >> current nfsd-testing branch and post it again.
> >>
> >>
> >>> This one I agree is not needed but I
> >>> thought was an improvement.
> >>>
> >>>>
> >>>>
> >>>>>> Thanks,
> >>>>>> NeilBrown
> >>>>>>
> >>>>>>
> >>>>>>>
> >>>>>>> commit 062304a815fe10068c478a4a3f28cf091c55cb82
> >>>>>>> Author: J. Bruce Fields <bfields@fieldses.org>
> >>>>>>> Date:   Sun Jan 2 22:05:33 2011 -0500
> >>>>>>>
> >>>>>>>     nfsd: stop translating EAGAIN to nfserr_dropit
> >>>>>>>
> >>>>>>> diff --git a/fs/nfsd/nfsproc.c b/fs/nfsd/nfsproc.c
> >>>>>>> index dc9c2e3fd1b8..fd608a27a8d5 100644
> >>>>>>> --- a/fs/nfsd/nfsproc.c
> >>>>>>> +++ b/fs/nfsd/nfsproc.c
> >>>>>>> @@ -735,7 +735,8 @@ nfserrno (int errno)
> >>>>>>>                 { nfserr_stale, -ESTALE },
> >>>>>>>                 { nfserr_jukebox, -ETIMEDOUT },
> >>>>>>>                 { nfserr_jukebox, -ERESTARTSYS },
> >>>>>>> -               { nfserr_dropit, -EAGAIN },
> >>>>>>> +               { nfserr_jukebox, -EAGAIN },
> >>>>>>> +               { nfserr_jukebox, -EWOULDBLOCK },
> >>>>>>>                 { nfserr_jukebox, -ENOMEM },
> >>>>>>>                 { nfserr_badname, -ESRCH },
> >>>>>>>                 { nfserr_io, -ETXTBSY },
> >>>>>>>
> >>>>>>> so if fh_verify is failing whatever it is returning, it is not
> >>>>>>> nfserr_dropit nor is it nfserr_jukebox which means nlm_fopen() wo=
uld
> >>>>>>> translate it to nlm_failed which with my patch would not trigger
> >>>>>>> nlm_lck_denied_grace_period error but resp->status would be set t=
o
> >>>>>>> nlm_failed.
> >>>>>>>
> >>>>>>> So I circle back to I hope that convinces you that we don't need =
a
> >>>>>>> check for the reclaim lock.
> >>>>>>>
> >>>>>>> I believe nlm_drop_reply is nfsd_open's jukebox error, one of whi=
ch is
> >>>>>>> delegation recall. it can be a memory failure. But I'm sure when
> >>>>>>> EWOULDBLOCK occurs.
> >>>>>>>
> >>>>>>>> At the very least we need to guard against the reclaim flag bein=
g set in
> >>>>>>>> the above test.  But I would much rather a more clear distinctio=
n were
> >>>>>>>> made between "drop because of a conflicting delegation" and "dro=
p
> >>>>>>>> because of a delay getting upcall response".
> >>>>>>>> Maybe a new "nlm_conflicting_delegtion" return from ->fopen whic=
h nlm4
> >>>>>>>> (and ideally nlm2) handles appropriately.
> >>>>>>>
> >>>>>>>
> >>>>>>>> NeilBrown
> >>>>>>>>
> >>>>>>>>
> >>>>>>>>> +                     return rpc_success;
> >>>>>>>>> +             }
> >>>>>>>>> +             return nlm_drop_reply;
> >>>>>>>>> +     default:
> >>>>>>>>> +             return rpc_success;
> >>>>>>>>> +     }
> >>>>>>>>>
> >>>>>>>>>       /* Now try to lock the file */
> >>>>>>>>>       resp->status =3D nlmsvc_lock(rqstp, file, host, &argp->lo=
ck,
> >>>>>>>>> --
> >>>>>>>>> 2.47.1
> >>>>>>>>>
> >>>>>>>>>
> >>>>>>>>
> >>>>>>>>
> >>>>>>>
> >>>>>>
> >>>>
> >>>>
> >>>> --
> >>>> Chuck Lever
> >>>
> >>
> >>
> >> --
> >> Chuck Lever
>
>
> --
> Chuck Lever


Return-Path: <linux-nfs+bounces-13848-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 82918B3021D
	for <lists+linux-nfs@lfdr.de>; Thu, 21 Aug 2025 20:33:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 211711BC3289
	for <lists+linux-nfs@lfdr.de>; Thu, 21 Aug 2025 18:34:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE06225A352;
	Thu, 21 Aug 2025 18:33:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=umich.edu header.i=@umich.edu header.b="AAB8QTuU"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D46823C509
	for <linux-nfs@vger.kernel.org>; Thu, 21 Aug 2025 18:33:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755801232; cv=none; b=SeJSTiOqo7So31FTqSKqJ8Dbcdo2IvdYoclJcXyr3+PYywjnI7SDrd+/YiYiyjY9mJoNfk10m+tlGmUEnmLnD/5iFn0cJ9Qq/shdWUziBzO7XPV7kInoMrDtBA8LnbwQkNTzq5W2+l7/0GNp1FOMo4Knj4GS/BIdxkeWn1JyvGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755801232; c=relaxed/simple;
	bh=uvGA+5LaUWtliarUazi5M4vVL7DnnnsGMjEgu3ae7oM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Z+Vrsuq4E+U1YuaXcZ3WaLW15D7oBjgt8z9CFBcxKDew9TOwyBlKNtEF5JPeNGZ+NyfUpiMhv/rMvDm6whtqjoh/EcMpILDj7myhlCZfDRExhBab9V+08XHZsw8Mp/3thaPrl8/zGgsZTlR+0OGx9k1G+oeFp/arcocpK0qcaCU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=umich.edu; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=umich.edu header.i=@umich.edu header.b=AAB8QTuU; arc=none smtp.client-ip=209.85.208.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=umich.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-3354b208913so7105461fa.1
        for <linux-nfs@vger.kernel.org>; Thu, 21 Aug 2025 11:33:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umich.edu; s=google-2016-06-03; t=1755801229; x=1756406029; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MSM89Q2YO3q9qP7nLG2OxFZMAbl1CLDZHp+Wo9HCAtI=;
        b=AAB8QTuU+ssyIMoGWalmEVNUJe4nE/BgpkVUYlvwSdiGbIG9sKqdJCLz5x3EKyyBMX
         XvAAfemF8qEWODbdGm47HawKI/dxx5UFEZJybS1EY/FXXKZqPwgUChTH9ke9+g6SoxpO
         y5ZsRpCfxV8PbuMHe5n9nC93lu3wkH2IMbUoSpvgxSDjrrgt2Ud1PyHQ9+tQo6A5lyCM
         7bVX9u2Ucm8KtTqiZqmr8v8Uwl1feapDoKryEZgkjrbEDygbkU1qmUQsDnoX4d0rVHUM
         rr0xqtXeYsgn6OMvg9YmK2qB2K6ztL6Ao7TTQFCIQINtWmEnCivUFyieXonwp7hC+wff
         F/ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755801229; x=1756406029;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MSM89Q2YO3q9qP7nLG2OxFZMAbl1CLDZHp+Wo9HCAtI=;
        b=bmAZ+UVqXGnbJSeFw0vE2e+F7vpGOXpMzGGas+8fUjtTzvLm8+yKtBVY5nA4spHMoB
         oYqhuiofNfRbk5w2W4TXS+CKUAGQYnbs+GYhBDxUTivK/auu4+8cIz8sPAHBtBR4ZmL0
         ERa7nR6yTJwccyYMOzLDBktzsrB1sQDnMIwn44t/gLjCkxf0yIHLbysD1istqVHjmulh
         uSMJvRD3n5q8r7Bk48ftvr3DwGIIMp+PhKSjHFMCzI0Aiq/BsdBU3JN1I2v3cO8UcAoD
         ibVq5cbT/q5nimrfyWuj4HqU/A8OWAHZS9NdzSyW4BkBt+gY0HwwY6oH0g74Tj9KVwqy
         aDMw==
X-Forwarded-Encrypted: i=1; AJvYcCXkh1yb+sYfeUQGiSP/n5NcR19g7GqEnn57TgDPsACZVqyHnFAJdt1CjRJwpPe/zFhWkTWnTzDwAKM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzFi4M8j90q28cFspUNeoCAW4roTZ9bqE30SXFFCokcgfEct9Uw
	ejcLi5nhf2T1dSdasIeI+EIYtHIeKIgtUimOfUyIJRZY/PBLxl2RPOyNL31GRPRVnVFMRXXxMWJ
	/VyfotyTWMaQDBJ6qkQ9t2rUq199c10Q=
X-Gm-Gg: ASbGncuLqWIBSZBMNeH3IS8+EeIhFKrWeK1l3g6LTt4BzIVy59BWFeBR87AXLxxNjg4
	s4hYflDbQNm3LNPC5VVf645vN51YWRfBEOSG2pSEJorv4JD6OnoPIhnjWwb2iCZa2o3pTJlB4YJ
	epIGCy5xYAcVSBUq/ypUdUOdm0ZTlkQoA21CQuAcdn/c9Zc5Gfz3oSS5GNkPoDu1wv3esDgHHdH
	JsFUj+hIzIGa4YTNi8bAMHYbr02ycz0YuNB6S6EKw==
X-Google-Smtp-Source: AGHT+IExe1psslS/9HqGYTut7HAgs3QC8Eg05B5O92yIO5elAYd05uHYZx0TsJh724rzRN3VAPcJPurTHSd4bHcO0Yk=
X-Received: by 2002:a2e:8e62:0:b0:332:1de5:c52b with SMTP id
 38308e7fff4ca-33650ecba60mr325921fa.1.1755801228300; Thu, 21 Aug 2025
 11:33:48 -0700 (PDT)
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
 <f54c0edf-18b3-4432-af0b-7caac995fe01@oracle.com>
In-Reply-To: <f54c0edf-18b3-4432-af0b-7caac995fe01@oracle.com>
From: Olga Kornievskaia <aglo@umich.edu>
Date: Thu, 21 Aug 2025 14:33:36 -0400
X-Gm-Features: Ac12FXyw4kGVABnz2nplJ8BlMOynlw9G8ghFD9TPXbm0Q-tt6cVXwRm2wmUxDIE
Message-ID: <CAN-5tyF7wqG6_n_x4rNCKeLmkChGDA74TWduun8HahVuHfHbZw@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] lockd: while grace prefer to fail with nlm_lck_denied_grace_period
To: Chuck Lever <chuck.lever@oracle.com>
Cc: NeilBrown <neil@brown.name>, Olga Kornievskaia <okorniev@redhat.com>, jlayton@kernel.org, 
	linux-nfs@vger.kernel.org, Dai.Ngo@oracle.com, tom@talpey.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 21, 2025 at 2:24=E2=80=AFPM Chuck Lever <chuck.lever@oracle.com=
> wrote:
>
> On 8/21/25 2:20 PM, Olga Kornievskaia wrote:
> > On Thu, Aug 21, 2025 at 11:09=E2=80=AFAM Chuck Lever <chuck.lever@oracl=
e.com> wrote:
> >>
> >> On 8/21/25 9:56 AM, Olga Kornievskaia wrote:
> >>> On Wed, Aug 20, 2025 at 7:15=E2=80=AFPM NeilBrown <neil@brown.name> w=
rote:
> >>>>
> >>>> On Thu, 14 Aug 2025, Olga Kornievskaia wrote:
> >>>>> On Tue, Aug 12, 2025 at 8:05=E2=80=AFPM NeilBrown <neil@brown.name>=
 wrote:
> >>>>>>
> >>>>>> On Wed, 13 Aug 2025, Olga Kornievskaia wrote:
> >>>>>>> When nfsd is in grace and receives an NLM LOCK request which turn=
s
> >>>>>>> out to have a conflicting delegation, return that the server is i=
n
> >>>>>>> grace.
> >>>>>>>
> >>>>>>> Reviewed-by: Jeff Layton <jlayton@redhat.com>
> >>>>>>> Signed-off-by: Olga Kornievskaia <okorniev@redhat.com>
> >>>>>>> ---
> >>>>>>>  fs/lockd/svc4proc.c | 15 +++++++++++++--
> >>>>>>>  1 file changed, 13 insertions(+), 2 deletions(-)
> >>>>>>>
> >>>>>>> diff --git a/fs/lockd/svc4proc.c b/fs/lockd/svc4proc.c
> >>>>>>> index 109e5caae8c7..7ac4af5c9875 100644
> >>>>>>> --- a/fs/lockd/svc4proc.c
> >>>>>>> +++ b/fs/lockd/svc4proc.c
> >>>>>>> @@ -141,8 +141,19 @@ __nlm4svc_proc_lock(struct svc_rqst *rqstp, =
struct nlm_res *resp)
> >>>>>>>       resp->cookie =3D argp->cookie;
> >>>>>>>
> >>>>>>>       /* Obtain client and file */
> >>>>>>> -     if ((resp->status =3D nlm4svc_retrieve_args(rqstp, argp, &h=
ost, &file)))
> >>>>>>> -             return resp->status =3D=3D nlm_drop_reply ? rpc_dro=
p_reply :rpc_success;
> >>>>>>> +     resp->status =3D nlm4svc_retrieve_args(rqstp, argp, &host, =
&file);
> >>>>>>> +     switch (resp->status) {
> >>>>>>> +     case 0:
> >>>>>>> +             break;
> >>>>>>> +     case nlm_drop_reply:
> >>>>>>> +             if (locks_in_grace(SVC_NET(rqstp))) {
> >>>>>>> +                     resp->status =3D nlm_lck_denied_grace_perio=
d;
> >>>>>>
> >>>>>> I think this is wrong.  If the lock request has the "reclaim" flag=
 set,
> >>>>>> then nlm_lck_denied_grace_period is not a meaningful error.
> >>>>>> nlm4svc_retrieve_args() returns nlm_drop_reply when there is a del=
ay
> >>>>>> getting a response to an upcall to mountd.  For NLM the request re=
ally
> >>>>>> must be dropped.
> >>>>>
> >>>>> Thank you for pointing out this case so we are suggesting to.
> >>>>>
> >>>>> if (locks_in_grace(SVC_NET(rqstp)) && !argp->reclaim)
> >>>>>
> >>>>> However, I've been looking and looking but I cannot figure out how
> >>>>> nlm4svc_retrieve_args() would ever get nlm_drop_reply. You say it c=
an
> >>>>> happen during the upcall to mountd. So that happens within nfsd_ope=
n()
> >>>>> call and a part of fh_verify().
> >>>>> To return nlm_drop_reply, nlm_fopen() must have gotten nfserr_dropi=
t
> >>>>> from the nfsd_open().  I have searched and searched but I don't see
> >>>>> anything that ever sets nfserr_dropit (NFSERR_DROPIT).
> >>>>>
> >>>>> I searched the logs and nfserr_dropit was an error that was EAGAIN
> >>>>> translated into but then removed by the following patch.
> >>>>
> >>>> Oh.  I didn't know that.
> >>>> We now use RQ_DROPME instead.
> >>>> I guess we should remove NFSERR_DROPIT completely as it not used at =
all
> >>>> any more.
> >>>>
> >>>> Though returning nfserr_jukebox to an v2 client isn't a good idea...=
.
> >>>
> >>> I'll take your word for you.
> >>>
> >>>> So I guess my main complaint isn't valid, but I still don't like thi=
s
> >>>> patch.  It seems an untidy place to put the locks_in_grace test.
> >>>> Other callers of nlm4svc_retrieve_args() check locks_in_grace() befo=
re
> >>>> making that call.  __nlm4svc_proc_lock probably should too.  Or is t=
here
> >>>> a reason that it is delayed until the middle of nlmsvc_lock()..
> >>>
> >>> I thought the same about why not adding the in_grace check and decide=
d
> >>> that it was probably because you dont want to deny a lock if there ar=
e
> >>> no conflicts. If we add it, somebody might notice and will complain
> >>> that they can't get their lock when there are no conflicts.
> >>>
> >>>> The patch is not needed and isn't clearly an improvement, so I would
> >>>> rather it were dropped.
> >>>
> >>> I'm not against dropping this patch if the conclusion is that droppin=
g
> >>> the packet is no worse than returning in_grace error.
> >>
> >> I dropped both of these from nfsd-testing. If a fix is still needed,
> >> let's start again with fresh patches.
> >
> > Can you clarify when you said "both"?
> >
> > What objections are there for the 1st patch in the series. It solves a
> > problem and a fix is needed.
>
> There are two reasons to drop the first patch.
>
> 1. Neil's "remove nfserr_dropit" patch doesn't apply unless both patches
> are reverted.
>
> 2. As I said above, NFSv2 does not have a mechanism like NFS3ERR_JUKEBOX
> to request that the client wait a bit and resend.

ERR_JUKEBOX is not returned to another v2 or v3.

Patch1 (nfsd: nfserr_jukebox in nlm_fopen should lead to a retry)
translates err_jukebox into the nlm_drop_reply and returns to lockd.
As the result, no error is returned to the client but the reply is
dropped all together.


> So, if 1/2 has been tested with NFSv2 and does not cause NFSD to leak
> nfserr_jukebox to NFSv2 clients, then please rebase that one on the
> current nfsd-testing branch and post it again.
>
>
> > This one I agree is not needed but I
> > thought was an improvement.
> >
> >>
> >>
> >>>> Thanks,
> >>>> NeilBrown
> >>>>
> >>>>
> >>>>>
> >>>>> commit 062304a815fe10068c478a4a3f28cf091c55cb82
> >>>>> Author: J. Bruce Fields <bfields@fieldses.org>
> >>>>> Date:   Sun Jan 2 22:05:33 2011 -0500
> >>>>>
> >>>>>     nfsd: stop translating EAGAIN to nfserr_dropit
> >>>>>
> >>>>> diff --git a/fs/nfsd/nfsproc.c b/fs/nfsd/nfsproc.c
> >>>>> index dc9c2e3fd1b8..fd608a27a8d5 100644
> >>>>> --- a/fs/nfsd/nfsproc.c
> >>>>> +++ b/fs/nfsd/nfsproc.c
> >>>>> @@ -735,7 +735,8 @@ nfserrno (int errno)
> >>>>>                 { nfserr_stale, -ESTALE },
> >>>>>                 { nfserr_jukebox, -ETIMEDOUT },
> >>>>>                 { nfserr_jukebox, -ERESTARTSYS },
> >>>>> -               { nfserr_dropit, -EAGAIN },
> >>>>> +               { nfserr_jukebox, -EAGAIN },
> >>>>> +               { nfserr_jukebox, -EWOULDBLOCK },
> >>>>>                 { nfserr_jukebox, -ENOMEM },
> >>>>>                 { nfserr_badname, -ESRCH },
> >>>>>                 { nfserr_io, -ETXTBSY },
> >>>>>
> >>>>> so if fh_verify is failing whatever it is returning, it is not
> >>>>> nfserr_dropit nor is it nfserr_jukebox which means nlm_fopen() woul=
d
> >>>>> translate it to nlm_failed which with my patch would not trigger
> >>>>> nlm_lck_denied_grace_period error but resp->status would be set to
> >>>>> nlm_failed.
> >>>>>
> >>>>> So I circle back to I hope that convinces you that we don't need a
> >>>>> check for the reclaim lock.
> >>>>>
> >>>>> I believe nlm_drop_reply is nfsd_open's jukebox error, one of which=
 is
> >>>>> delegation recall. it can be a memory failure. But I'm sure when
> >>>>> EWOULDBLOCK occurs.
> >>>>>
> >>>>>> At the very least we need to guard against the reclaim flag being =
set in
> >>>>>> the above test.  But I would much rather a more clear distinction =
were
> >>>>>> made between "drop because of a conflicting delegation" and "drop
> >>>>>> because of a delay getting upcall response".
> >>>>>> Maybe a new "nlm_conflicting_delegtion" return from ->fopen which =
nlm4
> >>>>>> (and ideally nlm2) handles appropriately.
> >>>>>
> >>>>>
> >>>>>> NeilBrown
> >>>>>>
> >>>>>>
> >>>>>>> +                     return rpc_success;
> >>>>>>> +             }
> >>>>>>> +             return nlm_drop_reply;
> >>>>>>> +     default:
> >>>>>>> +             return rpc_success;
> >>>>>>> +     }
> >>>>>>>
> >>>>>>>       /* Now try to lock the file */
> >>>>>>>       resp->status =3D nlmsvc_lock(rqstp, file, host, &argp->lock=
,
> >>>>>>> --
> >>>>>>> 2.47.1
> >>>>>>>
> >>>>>>>
> >>>>>>
> >>>>>>
> >>>>>
> >>>>
> >>
> >>
> >> --
> >> Chuck Lever
> >
>
>
> --
> Chuck Lever


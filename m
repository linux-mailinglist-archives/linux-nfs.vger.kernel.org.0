Return-Path: <linux-nfs+bounces-13850-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 308CFB3024F
	for <lists+linux-nfs@lfdr.de>; Thu, 21 Aug 2025 20:51:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C80201CC37EA
	for <lists+linux-nfs@lfdr.de>; Thu, 21 Aug 2025 18:51:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C31F13451C1;
	Thu, 21 Aug 2025 18:51:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=umich.edu header.i=@umich.edu header.b="n8nHIGaz"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FF3C343D9B
	for <linux-nfs@vger.kernel.org>; Thu, 21 Aug 2025 18:51:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755802281; cv=none; b=kGjz4dqyMeUUFiKdwuumh/XOUmvk/uEIyLNlCnztvrnAwe1TPLNQOMldsvB8H220LlOQc66M+VhtwEQ7pF8fC7HjtQgPWd0/0Kp5mWkZKh6sI4630HrRGxBemiwszSmztbI6kpLvC00kBTwG7NxvFTP6R4VPcUbIWM87BDHFrsA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755802281; c=relaxed/simple;
	bh=agKF78+nPxCNj9JmwED+/8SenIfOPHqhkTqM7OQ3Ejk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NfGs4fgBaX3JHWlzL10TMzZcpMFlbA0O7W8GcQGri9sCzev6BL3viUUXFPYYFZkAhAHM2G9d2SAvz/YDfpP7e2AdZyryab17IyaljRDXRMOHvfPHXEhSYsNW7wfnXDLEtjwAeCz67guyjJ2X6lUDUqJbHw5NWLASid6fTyJBk2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=umich.edu; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=umich.edu header.i=@umich.edu header.b=n8nHIGaz; arc=none smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=umich.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-333f8f0965dso11517751fa.1
        for <linux-nfs@vger.kernel.org>; Thu, 21 Aug 2025 11:51:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umich.edu; s=google-2016-06-03; t=1755802277; x=1756407077; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ddk+wy6VK7MJEAI8GlBXfFm9yBwizBAHQQ8O2lFtND0=;
        b=n8nHIGazoudDOYfa1fubJ13wpAP3joUSfCdrhxiZPz964kOZ5OZyOfThXcXt0tRqep
         T6avQYNRPB17lkvah0Gtl8zMFVFfAk+JB8dO9LQUT1ZtkHirLNL7lufgYdQE8bl9RhlI
         Dd6EaheMUbWhH42XPxpJEp0jDuQpKtOZ02F+77PRhrNJAA5Iw8hWdQJtQ5kCwNuYRgGn
         wmWouHZhnvymeTh2nyTX5ChRR7HbAOtSDIS+xRbsiAA5xHXOAUm6icquYSOjBigcH6J4
         b4QiGBxvkcdEagt6Xryo8pVAoUwJ2ytKo5wMJcAmE9AM93qRcaKwEHriEk+qM1qPkkgd
         HBLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755802277; x=1756407077;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ddk+wy6VK7MJEAI8GlBXfFm9yBwizBAHQQ8O2lFtND0=;
        b=IasvExEtVNBS3He0L8rTwHXSO/0ryI+WggNKQ6jok4PNPN05gJXAZFbFi0pIdMLlwo
         /VkSQA8vrPEAPGFKgDB/Vj/FVe1v9x/yO7kDX65ihPrdqrsb/mnAicYLoKFI2FjOBtLM
         4gpOvZQjR6zCQJU1MART7OZzpdlMv0jw4bMNv/51diypICPktXtUVOsLqwcI8gmHRB4g
         IhiQ+KjFlLO50lgZHm+3tD6dLm7sJdzaGoOhBjIsXx5ha2OENxLSOmyt7sOu6TjnxbwU
         xIU8eLSp+I6kFWf8iZEvhP0uu/z4yb12SvWyDIPKAAyYYs3hGWD59sM+e6LChkTR4cKr
         dJ/Q==
X-Forwarded-Encrypted: i=1; AJvYcCVTwxo9yJVPeCJZ5i8HavqYHefmLjkk/Td3hubmcxKoa5IN8XMsF0Ebl/L0QNNSlu/e0GeY83oaUo4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyJXLvRhHsrnNpPMWnQ9m6llft68K5mI25faUlgHilrYr0UVXAO
	R9q4ClygUp5Z/ejU3NJCnOLHFk+H4jI1pw8YAZESSy9p7IN7Kf18qILaGyMbtulf6Yr6Py1X3Q6
	gaa+mCmI2aglZnLA+FhPqbtokYsQWw9w1mFTA
X-Gm-Gg: ASbGncvkMcGvA6ELTvnflLiC7ci9UhHal2bgwkQCNYx2lAljpf/p9gzHWEoyX+G+LMi
	sDoLIJ1ofmKR4KTXMKrMWr8mvIMfkYGKJdsCx5+stVZK984e06+UlSTIl0wfaVpZe9tPctlzvlJ
	2POTFX3HYFXACg88DAxrILEXDjNYFp1xch0ADFzXH3xRftLzAdDiayehPkuKmH0vM/rzcdUWqaa
	29p9N+vq8SAYsj8hf3hyuSDJppNBH4MWCAbvav1mfKd01fHLIKJ
X-Google-Smtp-Source: AGHT+IE8ev3uWy9h/aeacniS/R4mmo6hf94yg9un4jzeDhnT2N994zqXtdO6zF/46MrQM4wdcrA//jNREPzWT/gCKo8=
X-Received: by 2002:a2e:8a8c:0:b0:32a:8030:7004 with SMTP id
 38308e7fff4ca-33650dd7f70mr319011fa.4.1755802277318; Thu, 21 Aug 2025
 11:51:17 -0700 (PDT)
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
Date: Thu, 21 Aug 2025 14:51:05 -0400
X-Gm-Features: Ac12FXwuBns_p8SxnfDYkn4INkZqardaSQT0bEnY1j6Psz1ey8o6c0l1HqNaMrk
Message-ID: <CAN-5tyHqL-AYw6RD0iFUzszKwB2Ex23weTfnVtJrwAaiiXmWYA@mail.gmail.com>
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

To drop a response lockd expect that it gets nlm_drop_response.

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


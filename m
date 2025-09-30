Return-Path: <linux-nfs+bounces-14811-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A7AEBAD2D8
	for <lists+linux-nfs@lfdr.de>; Tue, 30 Sep 2025 16:30:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8C9287A9CBA
	for <lists+linux-nfs@lfdr.de>; Tue, 30 Sep 2025 14:28:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32C871D63D8;
	Tue, 30 Sep 2025 14:30:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=umich.edu header.i=@umich.edu header.b="Io/BW+Gs"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2D85303CB7
	for <linux-nfs@vger.kernel.org>; Tue, 30 Sep 2025 14:30:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759242609; cv=none; b=lpIoCUFLFDPe9OMk8EiR662eQozfbXglgrmiSGI3KEB/Qssky8BqN3YtgNgRZfHr9bgTx2rq9ChNamrelWykg4ugMopplk/GVwFLGWAPCnwfeQSv23Ydl/k8m9/c0aG3/g2aZTLnABRfr4u6k2bmyGT/Iw+Afil0CCFBAmLAQ38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759242609; c=relaxed/simple;
	bh=/iYkvErdRYMyBhE56KyTapbGGtx6/6H3CiLF2wLZpb4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=i4j65DbGz35IcoR4bPByn4HliEqZen+XJLtScPdKxVc9UGqG44LnDqQ8nTixnrxZrq5bs6Qt2/MOm0zY7LADYnas0kGUsBtDVGloV7PGn6/s+ruW4WrYA7QU/aerWOwJimsvSPyLxSCLVdRXXAKyH8WTvAZeib66oRaF8n5adOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=umich.edu; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=umich.edu header.i=@umich.edu header.b=Io/BW+Gs; arc=none smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=umich.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-362acd22c78so58154681fa.2
        for <linux-nfs@vger.kernel.org>; Tue, 30 Sep 2025 07:30:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umich.edu; s=google-2016-06-03; t=1759242605; x=1759847405; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xX116JK0VFP/pGKEbJJpRpWYEjrm3DD19Ud9zcKGOyI=;
        b=Io/BW+GsWgfhxSU/qCM9CRV06MvzLc4j1MhW/kHcKzXvFzQ0FWKdB+RPF6rj5APGz+
         7hhp6eAUAGraiN9fEeH0ESdprT3iu0kDInlyVF4nO8Ex8Ogm3XIdLgm1vF0PWmVk/+8b
         DySfkj8+7kLIbMXK0tWiyiXoyjKhEESom5Kg6WNMnJhVjjOckprQ47JNxYmHT18LdaHS
         aGiuhILcQbw3FO9XDzyZAQB6UBpY5cURT9NglnQ1m+vExT11uPp1aN7eAgFLE3Bi45mR
         lmd55AJuw0aYLA6QM0uujLkm6UMEmiFWRM4b/DTLXsHCs929qhkyvdzms5bdfK79XwL9
         edug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759242605; x=1759847405;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xX116JK0VFP/pGKEbJJpRpWYEjrm3DD19Ud9zcKGOyI=;
        b=YOxpWo2UB/ETXPcIyWh3BAMJW6UvrDlTKBH9mVJoishXBKf2qWeyMYAFVm+W73xpCM
         LZGSlVLlm4KWaEfnnPV+FuNh3GSq8iwJ/B95IiRAUasaYFce0NtrFx7A479RfFVyNR+6
         h7HbHW0ic25GszhVflXXBOwUoZ9Y9r9X10ZKEDTwzY3ORGvig0vJqt/LwZ9maQJRpwO4
         qzeuzL86m1U0KjOtB+BPh5BdMD8MG95/xWUpotHV1S8CfYSQzwjnwWFYowO4mhIxpAUB
         7u3UBr5y59YgFfgE88WeaQBXMQnzhAWGrBiRxL2D/MnGmasNKssd7eNCL1E0TNmR2Oep
         Y72g==
X-Forwarded-Encrypted: i=1; AJvYcCXkrtm1a37Qyy9qbEio4xv0sgL97cERp313hJ7oEBv/4b1ydzNwQZrFRjuztXY12NKH9QVtqKAJo2c=@vger.kernel.org
X-Gm-Message-State: AOJu0YyppIP/hphJvszyuWU0fI49ASMCo63i3TZijddzrAixQur1gOSD
	WojcJbxRoeMo8mBFC2BjPH/+7SmRWlZdqBjSEd+4Oh/gRr70nrCsEmcbehMRr2dmi4FLIlbiyxq
	5yVp7P/xqHVTrBMD6Pv70DIR9jyXdK/E=
X-Gm-Gg: ASbGncsWue8JJy26VzPSeBWer6717yWMucsa867s8yOu1LeC2gQWfE5lVPIfW7TkNGc
	LnOEXi35pH2j9XhHmuCQfCtC/vnKB7p+aOENCbpfzD8QI1aCTZg4DbfSx5DAIgZL6s1CaPt7Hag
	1B40P6kMEKbcoF3oCzGocw/wKi38nJ7cv34t81pI8L+NJGZtV7nWVv7/VAd15dMGyEweUG31RAT
	Fzq0s6hvVO7lQHUyB0NgKQFzAlOL0vR4rFUH0Yiq21bTBcUOS6TDGMQp1+WeUSMzEBBn9/DeG3l
X-Google-Smtp-Source: AGHT+IE4kxIll3dD6ZS7U4TIMokjy3ddVsXs5xvPVbLrn28LcagVLdz6wXLOb2ZpjVCtPSCgsZFxd7TT7xjwT2LyAFs=
X-Received: by 2002:a05:651c:2542:10b0:372:90ab:8bfa with SMTP id
 38308e7fff4ca-37290ab904bmr26238551fa.37.1759242604703; Tue, 30 Sep 2025
 07:30:04 -0700 (PDT)
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
 <CACSpFtAqWdPPCbHLnXKGOmn7bR0fBjS9fj_J=i4aNnL+=8t1zA@mail.gmail.com>
 <CAN-5tyEY17k5SZ6hj2QsgW_006c-0ywS5H5vPvadj80bC0X=7w@mail.gmail.com> <f6ba4e9d-98df-46f2-b2fa-8ac832b8ce11@oracle.com>
In-Reply-To: <f6ba4e9d-98df-46f2-b2fa-8ac832b8ce11@oracle.com>
From: Olga Kornievskaia <aglo@umich.edu>
Date: Tue, 30 Sep 2025 10:29:53 -0400
X-Gm-Features: AS18NWDyFp5Wy7nbt00ywcI-ixFEjR1VGQKZHjuYIurTmS2Tfqbmay5fFTxlRQs
Message-ID: <CAN-5tyE+VgWxK6ZT0Ls-5cV53DVrSCBMyd2SLz3PfiC2Z=gyNw@mail.gmail.com>
Subject: Re: [PATCH 1/1] NFSv4: handle ERR_GRACE on delegation recalls
To: Chuck Lever <chuck.lever@oracle.com>
Cc: Olga Kornievskaia <okorniev@redhat.com>, Trond Myklebust <trondmy@kernel.org>, anna.schumaker@oracle.com, 
	linux-nfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 30, 2025 at 10:02=E2=80=AFAM Chuck Lever <chuck.lever@oracle.co=
m> wrote:
>
> On 9/29/25 1:49 PM, Olga Kornievskaia wrote:
> > On Fri, Sep 12, 2025 at 12:04=E2=80=AFPM Olga Kornievskaia <okorniev@re=
dhat.com> wrote:
> >>
> >> On Fri, Sep 12, 2025 at 11:11=E2=80=AFAM Trond Myklebust <trondmy@kern=
el.org> wrote:
> >>>
> >>> On Fri, 2025-09-12 at 10:41 -0400, Olga Kornievskaia wrote:
> >>>> On Fri, Sep 12, 2025 at 10:29=E2=80=AFAM Trond Myklebust <trondmy@ke=
rnel.org>
> >>>> wrote:
> >>>>>
> >>>>> On Fri, 2025-09-12 at 10:21 -0400, Olga Kornievskaia wrote:
> >>>>>> Any comments on or objections to this patch? It does lead to
> >>>>>> possible
> >>>>>> data corruption.
> >>>>>>
> >>>>>
> >>>>> Sorry, I think was travelling when you originally sent this patch.
> >>>>>
> >>>>>> On Mon, Aug 11, 2025 at 2:25=E2=80=AFPM Olga Kornievskaia
> >>>>>> <okorniev@redhat.com> wrote:
> >>>>>>>
> >>>>>>> RFC7530 states that clients should be prepared for the return
> >>>>>>> of
> >>>>>>> NFS4ERR_GRACE errors for non-reclaim lock and I/O requests.
> >>>>>>>
> >>>>>>> Signed-off-by: Olga Kornievskaia <okorniev@redhat.com>
> >>>>>>> ---
> >>>>>>>  fs/nfs/nfs4proc.c | 4 ++--
> >>>>>>>  1 file changed, 2 insertions(+), 2 deletions(-)
> >>>>>>>
> >>>>>>> diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
> >>>>>>> index 341740fa293d..fa9b81300604 100644
> >>>>>>> --- a/fs/nfs/nfs4proc.c
> >>>>>>> +++ b/fs/nfs/nfs4proc.c
> >>>>>>> @@ -7867,10 +7867,10 @@ int nfs4_lock_delegation_recall(struct
> >>>>>>> file_lock *fl, struct nfs4_state *state,
> >>>>>>>                 return err;
> >>>>>>>         do {
> >>>>>>>                 err =3D _nfs4_do_setlk(state, F_SETLK, fl,
> >>>>>>> NFS_LOCK_NEW);
> >>>>>>> -               if (err !=3D -NFS4ERR_DELAY)
> >>>>>>> +               if (err !=3D -NFS4ERR_DELAY && err !=3D -
> >>>>>>> NFS4ERR_GRACE)
> >>>>>>>                         break;
> >>>>>>>                 ssleep(1);
> >>>>>>> -       } while (err =3D=3D -NFS4ERR_DELAY);
> >>>>>>> +       } while (err =3D=3D -NFS4ERR_DELAY || err =3D=3D -
> >>>>>>> NFSERR_GRACE);
> >>>>>>>         return nfs4_handle_delegation_recall_error(server,
> >>>>>>> state,
> >>>>>>> stateid, fl, err);
> >>>>>>>  }
> >>>>>>>
> >>>>>>> --
> >>>>>>> 2.47.1
> >>>>>>>
> >>>>>>>
> >>>>>
> >>>>> Should the server be sending NFS4ERR_GRACE in this case, though?
> >>>>> The
> >>>>> client already holds a delegation, so it is clear that other
> >>>>> clients
> >>>>> cannot reclaim any locks that would conflict.
> >>>>>
> >>>>> ..or is the issue that this could happen before the client has a
> >>>>> chance
> >>>>> to reclaim the delegation after a reboot?
> >>>>
> >>> To answer my own question here: in that case the server would return
> >>> NFS4ERR_BAD_STATEID, and not NFS4ERR_GRACE.
> >>>
> >>>> The scenario was, v4 client had an open file and a lock and upon
> >>>> server reboot (during grace) sends the reclaim open, to which the
> >>>> server replies with a delegation. How a v3 client comes in and
> >>>> requests the same lock. The linux server at this point sends a
> >>>> delegation recall to v4 client, the client sends its local lock
> >>>> request and gets ERR_GRACE.
> >>>>
> >>>> And the spec explicitly notes as I mention in the commit comment tha=
t
> >>>> the client is supposed to handle ERR_GRACE for non-reclaim locks.
> >>>> Thus
> >>>> this patch.
> >>>>
> >>>
> >>> Sure, however the same spec also says (Section 9.6.2.):
> >>>
> >>>    If the server can reliably determine that granting a non-reclaim
> >>>    request will not conflict with reclamation of locks by other clien=
ts,
> >>>    the NFS4ERR_GRACE error does not have to be returned and the
> >>>    non-reclaim client request can be serviced.
> >>>
> >>> The server can definitely reliably determine that is the case here,
> >>> since it already granted the delegation to the client.
> >>
> >> I'll take your word for it as I'm not that versed in the server code.
> >> But it's an optimization and hard to argue that a server must do it
> >> and thus the client really should handle the case that actually
> >> happens in practice now?
> >>
> >>> I'm not saying that the client shouldn't also handle NFS4ERR_GRACE, b=
ut
> >>> I am stating that the server shouldn't really be putting us in this
> >>> situation in the first place.
> >>> I'm also saying that if we're going to handle NFS4ERR_GRACE, then we
> >>> also need to handle all the other possible errors under a reboot
> >>> scenario.
> >>
> >> I don't see how the "if" and "then" are combined. I think if there are
> >> other errors we don't handle in reclaim then we should but I don't see
> >> it's conditional on handling ERR_GRACE error.
> >
> > What's the path forward here?
>
> I saw something earlier in the thread that caught my eye.
>
> It looked like you said that, while NFSD is in grace, it allowed a
> client to acquire an NLM lock and that triggered the delegation recall.
> It seems to me that, because it was in grace, NFSD should not have
> allowed the creation of a new lock; it should have returned nlm_grace.
>
> Did I read that incorrectly?

NFSD did not allow for the creation of a new lock.

NFSD got a v3 lock request which triggered a delegation recall (while
in grace). nfsd v3 call (with the patch a082e4b4d08a "nfsd:
nfserr_jukebox in nlm_fopen should lead to a retry" no longer fails
the request) drops the reply forcing the client to retry. Please
recall that I was advocating for an additional fix where the server
goes a step further and returns nlm_lck_denied_grace_period but it was
not accepted. But that wouldn't have helped the current problem.

Because the delegation is triggered, the client sends a reclaim lock
(but the client already sent a reclaim_complete, as it reclaimed the
open and gotten a delegation) so this is a "new" lock and the server
returns ERR_GRACE. Client does not handle this error and instead acts
like it got the lock and thus silent corruption.

The proposed patch is to handle ERR_GRACE error while reclaiming
delegation state.



>
>
> --
> Chuck Lever


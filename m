Return-Path: <linux-nfs+bounces-14815-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D7356BAD617
	for <lists+linux-nfs@lfdr.de>; Tue, 30 Sep 2025 16:58:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7A3051942A50
	for <lists+linux-nfs@lfdr.de>; Tue, 30 Sep 2025 14:57:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 594CE30505E;
	Tue, 30 Sep 2025 14:56:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=umich.edu header.i=@umich.edu header.b="IH9laM8i"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20063199939
	for <linux-nfs@vger.kernel.org>; Tue, 30 Sep 2025 14:56:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759244217; cv=none; b=KHDNpDvxNbTsyswM6HsKC8f5GUxd/+AOHgcjFxqBEqrVqy84fuQf2kQB6cIUE3FMKyQsgRpha8YB656CdfX6R/sGh3ci6FgwyZZz7TSsrz/LX7TOPNHT1tZsLBT12+7FzVqQLlmHIIcPBTHDTxhT792SEpqRy6NVvTfpfPSziPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759244217; c=relaxed/simple;
	bh=C2R+Lt57f2cS3AtFKNEuGlCwHY6gczv9zg6VqZnOzm4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kJ1uTVP0fn+DG3op/4BifcWktiPjfovguT/XB6cUURfAS65XLn5xvC24W34Q5Xk7ihBpXHrDRX0H8viCwjlBgVUWQuPWdC4OgObzFY8rkNfXkMSZCnIN+SggNo1p2UFfOOFID1J+7MJHKktXpa0MUWAVFM2iU6D6ZuqSJW5xtog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=umich.edu; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=umich.edu header.i=@umich.edu header.b=IH9laM8i; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=umich.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-55ce508d4d6so5619497e87.0
        for <linux-nfs@vger.kernel.org>; Tue, 30 Sep 2025 07:56:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umich.edu; s=google-2016-06-03; t=1759244212; x=1759849012; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wex9wiLa/qdSNYU4LfdQpQpTQpFqtQcvpBI70k5rSqc=;
        b=IH9laM8ixzXCUp7GZymhtpPzITEYYztXLIp7C7Mm+JYP8EtoW3qHrhD1OylzBZX7Xf
         wPbIxFK9py/C4FPBKEyIpkVbJlbclD0TPT+9GfqDziNtlafiDiaS/zycJAUoVthBtVZJ
         7WNfFxCd1yipyQQ4D29IUiIxiXi8kDgXzZ4UjjzzYe6xZgnHE52MctHr4mWA2u7FJUn8
         pTqxqS0pUjPDv2Q/nPUSSCWyDOPk0wrj51FAYU9P+BoaenA+C7Rzg97O+ALMPSbE8pn5
         0b5ELf6GtXAPS3wZjcGPHIZOkobfdrVwLrft/ErFTpma4GNhNrabDsvlPPDcslfdmpem
         FIAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759244212; x=1759849012;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wex9wiLa/qdSNYU4LfdQpQpTQpFqtQcvpBI70k5rSqc=;
        b=gBvmikuC6Hw0iLUt9D9cxmbaXa3TgHziZbzFGdb8NZbsmAt4WBrO8ES2D2mOmI3sYA
         tsjJXxnKa+wlVBH2IBnQbNI4lvqnFjVQuLG6d/upCD8VPJc68z1qlUXy8O5d9S8q4GuG
         gNIIwbDGNcqRFbiC7ZTAlU9hzuorpTzsz2ELR7Vp/FdnXmf/GYDTNNQmfO7h2rdIo0HD
         C4whOw1ivjU/TFhHQmVVhbESJZtRsBFU13y/l0L2h27isLvQMKX9U4Re+kUAIHzJ2b2E
         budQ5VsxsJrfY891pgkZ39Vkh6DUwo5tIsWQ7Adazb88/vvB88DrroiFmCjh/T0DguRo
         9Atw==
X-Forwarded-Encrypted: i=1; AJvYcCUYbVkKhX3aBk3PBBd6M+sZMwnDbqEbdr5z/DqfUyqUbhDIbh+vPDItVQOYY5WYLLtx2qEKdR9kiVc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx7zb60EfeZlmR2jXFMQ3UwrX3KYI7RaN9WuNIfXK+/yM68RdL0
	buJ69qgxXDDhahbLJUv0AtiNr1teC+jgmZcxqgAUbyaTm09JBd7pXOh80bjJ8Fzi3vF7uObHfNZ
	EEIZ8vHYlhkPQqvFCqNaC4RRzXIqnuIk=
X-Gm-Gg: ASbGncvNk6KN6lZkmevf+xsXeJ9NPKMvthqF6eCxVsads9D6dowPGYdlj8PxSYQyU6g
	NsKvc1JyWvYhUFx8CY8ukEv/Mxy8LLr4zX/4VVylf3UmwndDkoe4X2ToyJfIYQP0JNgcLrAGh6r
	MVkYIi8sgIbQ+dyRm8JyHHVlSCSw7c/MdZurC+eUOng7mIsbUEjH7+rKs2kJcjBZsKX+rkh87UH
	S6E4AbcrYWbnJzYQGVI/xOp8r5klJFg1iODDr5XL28PbQJ0IYC9PVOHQVh3MpsbIQ==
X-Google-Smtp-Source: AGHT+IG5jHyQfPtDc1Wl9loVpq0dVOIC9e7Ex/m9if6wKoKUOLOEIWxpgoFwCjNnA9aL2lSGyBiCmeXjKPK//uP/lrQ=
X-Received: by 2002:a05:6512:68f:b0:55f:52a6:d4be with SMTP id
 2adb3069b0e04-582d0e13342mr6149113e87.14.1759244211921; Tue, 30 Sep 2025
 07:56:51 -0700 (PDT)
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
 <CAN-5tyEY17k5SZ6hj2QsgW_006c-0ywS5H5vPvadj80bC0X=7w@mail.gmail.com>
 <f6ba4e9d-98df-46f2-b2fa-8ac832b8ce11@oracle.com> <CAN-5tyE+VgWxK6ZT0Ls-5cV53DVrSCBMyd2SLz3PfiC2Z=gyNw@mail.gmail.com>
 <CAN-5tyF+uB8p2NP-q-Z6vp9barr3L=vPYWaRSH5iAQk-VEHKDw@mail.gmail.com> <b5b8835d-1c1d-4e3c-ba85-a7a2eb87b61b@oracle.com>
In-Reply-To: <b5b8835d-1c1d-4e3c-ba85-a7a2eb87b61b@oracle.com>
From: Olga Kornievskaia <aglo@umich.edu>
Date: Tue, 30 Sep 2025 10:56:40 -0400
X-Gm-Features: AS18NWDvDWqMgumUy17xQXWHLRGTMSiQtO41xdZEEaLMhf3CoPcmMjthWw1uR8g
Message-ID: <CAN-5tyE1X0uEEmVHRz8bxdPs1DR2foA8a7KnRvGPixxK2p0n4g@mail.gmail.com>
Subject: Re: [PATCH 1/1] NFSv4: handle ERR_GRACE on delegation recalls
To: Chuck Lever <chuck.lever@oracle.com>
Cc: Olga Kornievskaia <okorniev@redhat.com>, Trond Myklebust <trondmy@kernel.org>, anna.schumaker@oracle.com, 
	linux-nfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 30, 2025 at 10:37=E2=80=AFAM Chuck Lever <chuck.lever@oracle.co=
m> wrote:
>
> On 9/30/25 10:32 AM, Olga Kornievskaia wrote:
> > On Tue, Sep 30, 2025 at 10:29=E2=80=AFAM Olga Kornievskaia <aglo@umich.=
edu> wrote:
> >>
> >> On Tue, Sep 30, 2025 at 10:02=E2=80=AFAM Chuck Lever <chuck.lever@orac=
le.com> wrote:
> >>>
> >>> On 9/29/25 1:49 PM, Olga Kornievskaia wrote:
> >>>> On Fri, Sep 12, 2025 at 12:04=E2=80=AFPM Olga Kornievskaia <okorniev=
@redhat.com> wrote:
> >>>>>
> >>>>> On Fri, Sep 12, 2025 at 11:11=E2=80=AFAM Trond Myklebust <trondmy@k=
ernel.org> wrote:
> >>>>>>
> >>>>>> On Fri, 2025-09-12 at 10:41 -0400, Olga Kornievskaia wrote:
> >>>>>>> On Fri, Sep 12, 2025 at 10:29=E2=80=AFAM Trond Myklebust <trondmy=
@kernel.org>
> >>>>>>> wrote:
> >>>>>>>>
> >>>>>>>> On Fri, 2025-09-12 at 10:21 -0400, Olga Kornievskaia wrote:
> >>>>>>>>> Any comments on or objections to this patch? It does lead to
> >>>>>>>>> possible
> >>>>>>>>> data corruption.
> >>>>>>>>>
> >>>>>>>>
> >>>>>>>> Sorry, I think was travelling when you originally sent this patc=
h.
> >>>>>>>>
> >>>>>>>>> On Mon, Aug 11, 2025 at 2:25=E2=80=AFPM Olga Kornievskaia
> >>>>>>>>> <okorniev@redhat.com> wrote:
> >>>>>>>>>>
> >>>>>>>>>> RFC7530 states that clients should be prepared for the return
> >>>>>>>>>> of
> >>>>>>>>>> NFS4ERR_GRACE errors for non-reclaim lock and I/O requests.
> >>>>>>>>>>
> >>>>>>>>>> Signed-off-by: Olga Kornievskaia <okorniev@redhat.com>
> >>>>>>>>>> ---
> >>>>>>>>>>  fs/nfs/nfs4proc.c | 4 ++--
> >>>>>>>>>>  1 file changed, 2 insertions(+), 2 deletions(-)
> >>>>>>>>>>
> >>>>>>>>>> diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
> >>>>>>>>>> index 341740fa293d..fa9b81300604 100644
> >>>>>>>>>> --- a/fs/nfs/nfs4proc.c
> >>>>>>>>>> +++ b/fs/nfs/nfs4proc.c
> >>>>>>>>>> @@ -7867,10 +7867,10 @@ int nfs4_lock_delegation_recall(struct
> >>>>>>>>>> file_lock *fl, struct nfs4_state *state,
> >>>>>>>>>>                 return err;
> >>>>>>>>>>         do {
> >>>>>>>>>>                 err =3D _nfs4_do_setlk(state, F_SETLK, fl,
> >>>>>>>>>> NFS_LOCK_NEW);
> >>>>>>>>>> -               if (err !=3D -NFS4ERR_DELAY)
> >>>>>>>>>> +               if (err !=3D -NFS4ERR_DELAY && err !=3D -
> >>>>>>>>>> NFS4ERR_GRACE)
> >>>>>>>>>>                         break;
> >>>>>>>>>>                 ssleep(1);
> >>>>>>>>>> -       } while (err =3D=3D -NFS4ERR_DELAY);
> >>>>>>>>>> +       } while (err =3D=3D -NFS4ERR_DELAY || err =3D=3D -
> >>>>>>>>>> NFSERR_GRACE);
> >>>>>>>>>>         return nfs4_handle_delegation_recall_error(server,
> >>>>>>>>>> state,
> >>>>>>>>>> stateid, fl, err);
> >>>>>>>>>>  }
> >>>>>>>>>>
> >>>>>>>>>> --
> >>>>>>>>>> 2.47.1
> >>>>>>>>>>
> >>>>>>>>>>
> >>>>>>>>
> >>>>>>>> Should the server be sending NFS4ERR_GRACE in this case, though?
> >>>>>>>> The
> >>>>>>>> client already holds a delegation, so it is clear that other
> >>>>>>>> clients
> >>>>>>>> cannot reclaim any locks that would conflict.
> >>>>>>>>
> >>>>>>>> ..or is the issue that this could happen before the client has a
> >>>>>>>> chance
> >>>>>>>> to reclaim the delegation after a reboot?
> >>>>>>>
> >>>>>> To answer my own question here: in that case the server would retu=
rn
> >>>>>> NFS4ERR_BAD_STATEID, and not NFS4ERR_GRACE.
> >>>>>>
> >>>>>>> The scenario was, v4 client had an open file and a lock and upon
> >>>>>>> server reboot (during grace) sends the reclaim open, to which the
> >>>>>>> server replies with a delegation. How a v3 client comes in and
> >>>>>>> requests the same lock. The linux server at this point sends a
> >>>>>>> delegation recall to v4 client, the client sends its local lock
> >>>>>>> request and gets ERR_GRACE.
> >>>>>>>
> >>>>>>> And the spec explicitly notes as I mention in the commit comment =
that
> >>>>>>> the client is supposed to handle ERR_GRACE for non-reclaim locks.
> >>>>>>> Thus
> >>>>>>> this patch.
> >>>>>>>
> >>>>>>
> >>>>>> Sure, however the same spec also says (Section 9.6.2.):
> >>>>>>
> >>>>>>    If the server can reliably determine that granting a non-reclai=
m
> >>>>>>    request will not conflict with reclamation of locks by other cl=
ients,
> >>>>>>    the NFS4ERR_GRACE error does not have to be returned and the
> >>>>>>    non-reclaim client request can be serviced.
> >>>>>>
> >>>>>> The server can definitely reliably determine that is the case here=
,
> >>>>>> since it already granted the delegation to the client.
> >>>>>
> >>>>> I'll take your word for it as I'm not that versed in the server cod=
e.
> >>>>> But it's an optimization and hard to argue that a server must do it
> >>>>> and thus the client really should handle the case that actually
> >>>>> happens in practice now?
> >>>>>
> >>>>>> I'm not saying that the client shouldn't also handle NFS4ERR_GRACE=
, but
> >>>>>> I am stating that the server shouldn't really be putting us in thi=
s
> >>>>>> situation in the first place.
> >>>>>> I'm also saying that if we're going to handle NFS4ERR_GRACE, then =
we
> >>>>>> also need to handle all the other possible errors under a reboot
> >>>>>> scenario.
> >>>>>
> >>>>> I don't see how the "if" and "then" are combined. I think if there =
are
> >>>>> other errors we don't handle in reclaim then we should but I don't =
see
> >>>>> it's conditional on handling ERR_GRACE error.
> >>>>
> >>>> What's the path forward here?
> >>>
> >>> I saw something earlier in the thread that caught my eye.
> >>>
> >>> It looked like you said that, while NFSD is in grace, it allowed a
> >>> client to acquire an NLM lock and that triggered the delegation recal=
l.
> >>> It seems to me that, because it was in grace, NFSD should not have
> >>> allowed the creation of a new lock; it should have returned nlm_grace=
.
> >>>
> >>> Did I read that incorrectly?
> >>
> >> NFSD did not allow for the creation of a new lock.
> >>
> >> NFSD got a v3 lock request which triggered a delegation recall (while
> >> in grace). nfsd v3 call (with the patch a082e4b4d08a "nfsd:
> >> nfserr_jukebox in nlm_fopen should lead to a retry" no longer fails
> >> the request) drops the reply forcing the client to retry. Please
> >> recall that I was advocating for an additional fix where the server
> >> goes a step further and returns nlm_lck_denied_grace_period but it was
> >> not accepted. But that wouldn't have helped the current problem.
> >>
> >> Because the delegation is triggered, the client sends a reclaim lock
> >> (but the client already sent a reclaim_complete, as it reclaimed the
> >> open and gotten a delegation) so this is a "new" lock and the server
> >> returns ERR_GRACE. Client does not handle this error and instead acts
> >> like it got the lock and thus silent corruption.
> >>
> >> The proposed patch is to handle ERR_GRACE error while reclaiming
> >> delegation state.
> >>
> >
> > To clarify there are 2 clients: v3 client (making a new lock request)
> > and v4 client that holds a delegation (and a local lock).
>
> I'm still confused about the procession of events. Namely, whether a
> delegation recall was done while the server was still in grace.

Yes. Delegation recall is done while the server is in grace.

> Could you provide a ladder diagram showing the interactions, in steps?

I'm not sure I can do a ladder diagram but let me try to lay out steps.

1. v4 client sends open (foo) and gets a delegation.
2. v4 client locally locks the file.
3. server reboots. grace starts.
4. v4 client sends reclaim open for "foo" and gets a delegation in reply.
5. v4 client sends reclaim_complete
6. v3 client sends NLM lock for "foo".
as a result of  step 6 there are 2 actions happen on the server
(a) server sends cb_recall to v4 client
(b) drops NLM lock request for v3 client (so that that the v3 client retrie=
s)
7. v4 client sends (non-reclaim) lock request to the server . Server
replies ERR_GRACE.
--> this is where the client doesn't retry but assumes it got the lock.
8. client sends delegreturn.

... if we let this play out. the v3 client which keeps resending NLM
lock request will get the lock once the nfsd is out of grace.



>
>
> --
> Chuck Lever


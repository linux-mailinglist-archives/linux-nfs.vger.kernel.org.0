Return-Path: <linux-nfs+bounces-14812-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EB0DBAD2EA
	for <lists+linux-nfs@lfdr.de>; Tue, 30 Sep 2025 16:32:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 02D09189DBEA
	for <lists+linux-nfs@lfdr.de>; Tue, 30 Sep 2025 14:32:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0DA01A0BE0;
	Tue, 30 Sep 2025 14:32:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=umich.edu header.i=@umich.edu header.b="PbDnzGmG"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A27FD1B4156
	for <linux-nfs@vger.kernel.org>; Tue, 30 Sep 2025 14:32:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759242742; cv=none; b=tRlLUCQ8cSH0kYaBsV0Z/ZkD0EGqhQnN7zlY6rm/iQkmd4QeNHVgI12IWCOOGLdSx8iVfhGSp2g8io4M9f7BDCxis8VJ8U0q8w10LZQnOnX/ECKVN1X3Qbs5qWhh+pGCjg5dnIgjOaeLdHZNRANl3YnEkeYM2X5X2FG2NKzOKY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759242742; c=relaxed/simple;
	bh=ffWcSHCLeOaDXScaENygFtuAnFLJ1av6QYa42LrlrxM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YwHSnggvSKtxiocCxAAIBZeWt8rHzW+yv1Fs09rED1pEjmlbDH1JgqYemK80B/nLDM7Y84G469nZ5FTG7sDF8xEKK+ZZCI+ytHyl9CPWbGNHNzRxRDMDDTpV5B+Jl531PLS085FWiOEDKi/PxktYqr/WBpHrQoVw6FifbREZNa8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=umich.edu; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=umich.edu header.i=@umich.edu header.b=PbDnzGmG; arc=none smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=umich.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-36a6a39752bso56317671fa.0
        for <linux-nfs@vger.kernel.org>; Tue, 30 Sep 2025 07:32:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umich.edu; s=google-2016-06-03; t=1759242737; x=1759847537; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pN2hLFbi7srvkwL/nn4qmCedqAPpOBE/icIrEp0MBN4=;
        b=PbDnzGmGKpmOisDUBaH/0XuttgKjF4MKJlbKHeVvzVWsnXNQi6mPqasSbmRMCc31et
         c35uxtbT8p8xr5K+KMJFNF6ki+Ui8z6YI9vJWw16eW8fH6fErtmJj8mzGOblXpNQ0Y9L
         6Bg5lVEeiz7OEQXEF92liztjJKQFQ0lBEAq6daB9Xylm2Y7whI/gXa4lyTf0L4/NNsfj
         5xsfZu9M2bgJjPk/0c7CYP8P7MYWH7AWzNLeB1NO6LqxcaBhRDK8HiRdMeP6ZjodJ6/3
         f4hC5dsNljkZg9/MUwx7zTC8evzkNG2cSyIjo35FlYDvU+ID9T1s08cWPNPizLb9xJD0
         xfBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759242737; x=1759847537;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pN2hLFbi7srvkwL/nn4qmCedqAPpOBE/icIrEp0MBN4=;
        b=A7sKXZocECcSUi0KlK6rwCCYtgyAQp/gXpGdteD4XwvKhZnej2X15bU4lHriQZHYI6
         cCBoIEvhM/0C2DrUSQFawbOeKgLw1z8wEuF9I8BFUHPEWOSWyvdKwAx0XHDy+gOQ2YZS
         iJiPHpknEgzYTJ/NtyHGM5SUabUKt2a+54seiVwh2Q87gVAfqsB30ZEO2ZBsSA5ZbxzR
         kq0gncFbB23UkMLPeKbhCXwu3sf84YPPjSs77rmalvAS82XZnnLZ4evQf7UpyQYw4I3/
         6hrPJrrv2oYUIjrqH+PvDgkutnORhaBlAhXg36ODw5kNAxjCa7bRru0ybAVu1wKhOfXK
         xeLQ==
X-Forwarded-Encrypted: i=1; AJvYcCV1R4id1flYm18SLvuG6yhVuUijVhOdeJ/+7bZmB3XOWVwjdXzOIYll3AbDVJTX2xDHELjFo90l5lo=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywga/8pF4zgGlFRJuMGLZ1HWf8I/JL1C/Dw1SRo1fDmWG3yy9+c
	3E+Rw7sH681p0XNFr7zfIi/zIbpuJIZVmTgcaCEEMQtCJ74fUvurswzggoWMMoiFoh5fA6g2h3k
	5N8l6dDHXNPH9oJ10dL952rQv1cJTr38=
X-Gm-Gg: ASbGncu7R8L5GmgiVPSP2/jHXZ8RWE1uPnpikGGjNhJhcJz40cLUN6sZTvYQfVZiYWv
	HVD+l9zyDRw2+zOvFDx8VFxTfCpwhQM0djnSTXE83iLFcLe0hN93fZvnSdPuHxXJQ+IrOrGo/uK
	mMu3hTGvmw+ZGvWULfEUskLOtx4nr+gYpP3aYaUCpJWskmdH9tJD+bJH2j/kn2Scrg3IGRBAYJ5
	swIrmvCjgQ5iQPYPeHIgWwNcQE79BtGd1aJabuN+wAe/ftHxHzIdqHYx4x1s53Kfw==
X-Google-Smtp-Source: AGHT+IEvmirJc8s2wSKLbEh3dZ6mw4mziNPW0zMFBprTQg+/gtNwUMpQjGWF77SPciE8sucJYH7GkcOF8zDqstT3dMc=
X-Received: by 2002:a2e:a802:0:b0:36c:f394:2ae8 with SMTP id
 38308e7fff4ca-36f7fd25246mr65806381fa.36.1759242736454; Tue, 30 Sep 2025
 07:32:16 -0700 (PDT)
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
In-Reply-To: <CAN-5tyE+VgWxK6ZT0Ls-5cV53DVrSCBMyd2SLz3PfiC2Z=gyNw@mail.gmail.com>
From: Olga Kornievskaia <aglo@umich.edu>
Date: Tue, 30 Sep 2025 10:32:05 -0400
X-Gm-Features: AS18NWCBvdSOQlVsOpvlOW6uthe7Rqsm8AH9jNcKL-sorbD8wpD0crxIwSZMUAE
Message-ID: <CAN-5tyF+uB8p2NP-q-Z6vp9barr3L=vPYWaRSH5iAQk-VEHKDw@mail.gmail.com>
Subject: Re: [PATCH 1/1] NFSv4: handle ERR_GRACE on delegation recalls
To: Chuck Lever <chuck.lever@oracle.com>
Cc: Olga Kornievskaia <okorniev@redhat.com>, Trond Myklebust <trondmy@kernel.org>, anna.schumaker@oracle.com, 
	linux-nfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 30, 2025 at 10:29=E2=80=AFAM Olga Kornievskaia <aglo@umich.edu>=
 wrote:
>
> On Tue, Sep 30, 2025 at 10:02=E2=80=AFAM Chuck Lever <chuck.lever@oracle.=
com> wrote:
> >
> > On 9/29/25 1:49 PM, Olga Kornievskaia wrote:
> > > On Fri, Sep 12, 2025 at 12:04=E2=80=AFPM Olga Kornievskaia <okorniev@=
redhat.com> wrote:
> > >>
> > >> On Fri, Sep 12, 2025 at 11:11=E2=80=AFAM Trond Myklebust <trondmy@ke=
rnel.org> wrote:
> > >>>
> > >>> On Fri, 2025-09-12 at 10:41 -0400, Olga Kornievskaia wrote:
> > >>>> On Fri, Sep 12, 2025 at 10:29=E2=80=AFAM Trond Myklebust <trondmy@=
kernel.org>
> > >>>> wrote:
> > >>>>>
> > >>>>> On Fri, 2025-09-12 at 10:21 -0400, Olga Kornievskaia wrote:
> > >>>>>> Any comments on or objections to this patch? It does lead to
> > >>>>>> possible
> > >>>>>> data corruption.
> > >>>>>>
> > >>>>>
> > >>>>> Sorry, I think was travelling when you originally sent this patch=
.
> > >>>>>
> > >>>>>> On Mon, Aug 11, 2025 at 2:25=E2=80=AFPM Olga Kornievskaia
> > >>>>>> <okorniev@redhat.com> wrote:
> > >>>>>>>
> > >>>>>>> RFC7530 states that clients should be prepared for the return
> > >>>>>>> of
> > >>>>>>> NFS4ERR_GRACE errors for non-reclaim lock and I/O requests.
> > >>>>>>>
> > >>>>>>> Signed-off-by: Olga Kornievskaia <okorniev@redhat.com>
> > >>>>>>> ---
> > >>>>>>>  fs/nfs/nfs4proc.c | 4 ++--
> > >>>>>>>  1 file changed, 2 insertions(+), 2 deletions(-)
> > >>>>>>>
> > >>>>>>> diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
> > >>>>>>> index 341740fa293d..fa9b81300604 100644
> > >>>>>>> --- a/fs/nfs/nfs4proc.c
> > >>>>>>> +++ b/fs/nfs/nfs4proc.c
> > >>>>>>> @@ -7867,10 +7867,10 @@ int nfs4_lock_delegation_recall(struct
> > >>>>>>> file_lock *fl, struct nfs4_state *state,
> > >>>>>>>                 return err;
> > >>>>>>>         do {
> > >>>>>>>                 err =3D _nfs4_do_setlk(state, F_SETLK, fl,
> > >>>>>>> NFS_LOCK_NEW);
> > >>>>>>> -               if (err !=3D -NFS4ERR_DELAY)
> > >>>>>>> +               if (err !=3D -NFS4ERR_DELAY && err !=3D -
> > >>>>>>> NFS4ERR_GRACE)
> > >>>>>>>                         break;
> > >>>>>>>                 ssleep(1);
> > >>>>>>> -       } while (err =3D=3D -NFS4ERR_DELAY);
> > >>>>>>> +       } while (err =3D=3D -NFS4ERR_DELAY || err =3D=3D -
> > >>>>>>> NFSERR_GRACE);
> > >>>>>>>         return nfs4_handle_delegation_recall_error(server,
> > >>>>>>> state,
> > >>>>>>> stateid, fl, err);
> > >>>>>>>  }
> > >>>>>>>
> > >>>>>>> --
> > >>>>>>> 2.47.1
> > >>>>>>>
> > >>>>>>>
> > >>>>>
> > >>>>> Should the server be sending NFS4ERR_GRACE in this case, though?
> > >>>>> The
> > >>>>> client already holds a delegation, so it is clear that other
> > >>>>> clients
> > >>>>> cannot reclaim any locks that would conflict.
> > >>>>>
> > >>>>> ..or is the issue that this could happen before the client has a
> > >>>>> chance
> > >>>>> to reclaim the delegation after a reboot?
> > >>>>
> > >>> To answer my own question here: in that case the server would retur=
n
> > >>> NFS4ERR_BAD_STATEID, and not NFS4ERR_GRACE.
> > >>>
> > >>>> The scenario was, v4 client had an open file and a lock and upon
> > >>>> server reboot (during grace) sends the reclaim open, to which the
> > >>>> server replies with a delegation. How a v3 client comes in and
> > >>>> requests the same lock. The linux server at this point sends a
> > >>>> delegation recall to v4 client, the client sends its local lock
> > >>>> request and gets ERR_GRACE.
> > >>>>
> > >>>> And the spec explicitly notes as I mention in the commit comment t=
hat
> > >>>> the client is supposed to handle ERR_GRACE for non-reclaim locks.
> > >>>> Thus
> > >>>> this patch.
> > >>>>
> > >>>
> > >>> Sure, however the same spec also says (Section 9.6.2.):
> > >>>
> > >>>    If the server can reliably determine that granting a non-reclaim
> > >>>    request will not conflict with reclamation of locks by other cli=
ents,
> > >>>    the NFS4ERR_GRACE error does not have to be returned and the
> > >>>    non-reclaim client request can be serviced.
> > >>>
> > >>> The server can definitely reliably determine that is the case here,
> > >>> since it already granted the delegation to the client.
> > >>
> > >> I'll take your word for it as I'm not that versed in the server code=
.
> > >> But it's an optimization and hard to argue that a server must do it
> > >> and thus the client really should handle the case that actually
> > >> happens in practice now?
> > >>
> > >>> I'm not saying that the client shouldn't also handle NFS4ERR_GRACE,=
 but
> > >>> I am stating that the server shouldn't really be putting us in this
> > >>> situation in the first place.
> > >>> I'm also saying that if we're going to handle NFS4ERR_GRACE, then w=
e
> > >>> also need to handle all the other possible errors under a reboot
> > >>> scenario.
> > >>
> > >> I don't see how the "if" and "then" are combined. I think if there a=
re
> > >> other errors we don't handle in reclaim then we should but I don't s=
ee
> > >> it's conditional on handling ERR_GRACE error.
> > >
> > > What's the path forward here?
> >
> > I saw something earlier in the thread that caught my eye.
> >
> > It looked like you said that, while NFSD is in grace, it allowed a
> > client to acquire an NLM lock and that triggered the delegation recall.
> > It seems to me that, because it was in grace, NFSD should not have
> > allowed the creation of a new lock; it should have returned nlm_grace.
> >
> > Did I read that incorrectly?
>
> NFSD did not allow for the creation of a new lock.
>
> NFSD got a v3 lock request which triggered a delegation recall (while
> in grace). nfsd v3 call (with the patch a082e4b4d08a "nfsd:
> nfserr_jukebox in nlm_fopen should lead to a retry" no longer fails
> the request) drops the reply forcing the client to retry. Please
> recall that I was advocating for an additional fix where the server
> goes a step further and returns nlm_lck_denied_grace_period but it was
> not accepted. But that wouldn't have helped the current problem.
>
> Because the delegation is triggered, the client sends a reclaim lock
> (but the client already sent a reclaim_complete, as it reclaimed the
> open and gotten a delegation) so this is a "new" lock and the server
> returns ERR_GRACE. Client does not handle this error and instead acts
> like it got the lock and thus silent corruption.
>
> The proposed patch is to handle ERR_GRACE error while reclaiming
> delegation state.
>

To clarify there are 2 clients: v3 client (making a new lock request)
and v4 client that holds a delegation (and a local lock).

>
>
> >
> >
> > --
> > Chuck Lever


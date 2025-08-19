Return-Path: <linux-nfs+bounces-13772-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C41BEB2C847
	for <lists+linux-nfs@lfdr.de>; Tue, 19 Aug 2025 17:19:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9AF9E167BC9
	for <lists+linux-nfs@lfdr.de>; Tue, 19 Aug 2025 15:15:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C48128314C;
	Tue, 19 Aug 2025 15:15:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=umich.edu header.i=@umich.edu header.b="XypUCETc"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6935188906
	for <linux-nfs@vger.kernel.org>; Tue, 19 Aug 2025 15:15:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755616507; cv=none; b=SFFgfnOqdaaT3E5rDGR82WkTIhlTWnw6TWJYCv1WdamHwFJJ/RcWz23L+GtCMVjajGGfnqrbYdu+NAmAN/U4ypdUATJGb5jUUIpP73osweh/3dIT1DfphjjeSHV+kqnHIchpkkDe1TWuahwjNqV7n6+sB64DDUfglhvGV77Z+ns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755616507; c=relaxed/simple;
	bh=hl4s/UgGIXc1JLR3EQF2BWsJpUgZouU4dccgElEeGk4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WeT4VE/BHe8dYZ+vHSVKsoGL/tPoOChM0yK4BknAqXbVBC3LXGvRG1iiSApCWQco1wT6fSBTy1FOvUp6ml3NoIKXvDeUKjztq0G/BaZsgabDPD25BmtD8pSV5tJfpfKS6pjMm2Ak+oUwclaVx+YbXfHSRq5R5bTUkaMGgVeNy5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=umich.edu; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=umich.edu header.i=@umich.edu header.b=XypUCETc; arc=none smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=umich.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-333e7517adcso57613391fa.1
        for <linux-nfs@vger.kernel.org>; Tue, 19 Aug 2025 08:15:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umich.edu; s=google-2016-06-03; t=1755616504; x=1756221304; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HzUzgVLNXJcix1nOlPw95q+IY6z97LrvF/QM0CqiYaw=;
        b=XypUCETc11Ymn6gU5Dj0Uc1dYUJtTtthLM4klvyUOpvnfWxCxlAWsKp3dR1BMps98j
         YUS+VPpW7f5DD33/YE+j1nB3hCpdVq3zOYkl00Z7KZLErrI/afRhjyTzfNER/q67DasA
         washq2AXLGS1v+VKQ3m5LBJjIkHfZcykpHprhIp1kIbFvA/U1A/pYu9IBmebhs7F/elK
         jIkqhFMiKPI+iM2hS+PjxyAs8BUm3hssUvLvx0umUreSJmOCmI4jca2U5nTkWrjkHKwP
         YJj0hD7rQyeD27e526YlaOLfN7dVevkf7neUH5pKpXg/vOFzddHNYfDz/15tf/atWNoX
         Bq4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755616504; x=1756221304;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HzUzgVLNXJcix1nOlPw95q+IY6z97LrvF/QM0CqiYaw=;
        b=gsaCCUE00IN5JL2l29rICBxq86KfrpPhe91Nq5R2v2nQXlx6TCXUepUC+N/wmCWiit
         z3WvbOK0I/HgErnAoovRU+uK37UmRCrNXleuLHqrXwkvpahpM2rgC/wHWaW9ZlW83Q1s
         RdvyOQiqYEYAhXfZSbBPVSMaM+/mUoUdcXzh3Re9GSkJX9pSC0OIoOC0va89bZNCGvZe
         KPWeFFgtckLWL8SQAil2ZeBw+jeCw+c3Yc9dVO/K2iXvcs4w054L8MoilYvSANbM2H7H
         lXMgIPHI9THhV5hlef4JThtC5CNUNk9jF1N2UdV+E0ZtVScwH4ARMoC6KhezYkr1fca1
         mCrw==
X-Forwarded-Encrypted: i=1; AJvYcCVwgm7YdZk9MdQ6mikwReoM3cJfrhAxVwql3TGwcMaZpblWFBXtaiBYDuJr9ouWBjQ40eD3jn0exaU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyIAphsy25CPHPrdtHTlvCZTB+Ml1LJ4RPoDPqpRc3+VqXN9aKG
	hZHgUhns5s7Ov+eg6PLJfnRRRHMveUVhxHE2G51j3WAUqICJNUuDp4hbGiDO84UPvLJyCIhqHBi
	XLiOkHIOktzJMvljVB7EhuTS0IkyNrTY=
X-Gm-Gg: ASbGncu1Ex6Kk10ceQYD9v9G6rn6+qIaxDkNdK+uNpWh5wtYs2lburnlphrR7FnqKAD
	24aLnElmZOS/QpRITAcL94Zpa2j9IrDFfvZDX5o5RecsNqZOuocSI9JemaiXU8bICvAgm24Z1gM
	SljFuKWhYr6YdmUcxX3K6YbJSprx9RYeiLQH3K60m7VSb2O8qeD/NS23y3jFaZFRwMAmkuI0yEh
	w4eljKeSBDqN656njUemmbrZz7Dy8pEpRrNLjF56ntAadjN5YhS
X-Google-Smtp-Source: AGHT+IGQnrMpzd79fmK3eIkLQGVwt4k3jVxSCLTCT4cnkq77YfUgDkQV3TTlYPpeQ095ACnhEWUuRBnE13wfjxq3RL0=
X-Received: by 2002:a2e:ae13:0:b0:30b:f0dd:9096 with SMTP id
 38308e7fff4ca-33531445dadmr5464591fa.12.1755616503666; Tue, 19 Aug 2025
 08:15:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250818182557.11259-1-okorniev@redhat.com> <c4722c18-57a5-49b5-818b-1e46cb4733b8@oracle.com>
 <CAN-5tyHincZxuNL3z5QDZ8Sv1F=fqT1b-3nUt2DVvFhr0MePRw@mail.gmail.com>
 <CACSpFtB3WDtWL7sv3FEyBh7UYiYSwiQwDr42vDck_nVQB_Z2ww@mail.gmail.com>
 <ff15eec1-3827-4057-a116-1f1bbc9bc8fd@oracle.com> <37b4ab16-6adc-48c3-984d-cfaf0bac259b@oracle.com>
In-Reply-To: <37b4ab16-6adc-48c3-984d-cfaf0bac259b@oracle.com>
From: Olga Kornievskaia <aglo@umich.edu>
Date: Tue, 19 Aug 2025 11:14:51 -0400
X-Gm-Features: Ac12FXw3Vz9fI4DWOw_jdom4oFBJPRwtMZdoYh3i-6NOlWjzaQJyLqSbzaaA6Eg
Message-ID: <CAN-5tyH2yX3O1j2QrhewiLGCYMgyNHbt6ZRY3equvyiHLu639w@mail.gmail.com>
Subject: Re: [PATCH 1/1] nfsd: unregister with rpcbind when deleting a transport
To: Chuck Lever <chuck.lever@oracle.com>
Cc: Olga Kornievskaia <okorniev@redhat.com>, jlayton@kernel.org, linux-nfs@vger.kernel.org, 
	neil@brown.name, Dai.Ngo@oracle.com, tom@talpey.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 18, 2025 at 4:47=E2=80=AFPM Chuck Lever <chuck.lever@oracle.com=
> wrote:
>
> On 8/18/25 3:36 PM, Chuck Lever wrote:
> > On 8/18/25 3:04 PM, Olga Kornievskaia wrote:
> >> On Mon, Aug 18, 2025 at 2:55=E2=80=AFPM Olga Kornievskaia <aglo@umich.=
edu> wrote:
> >>>
> >>> On Mon, Aug 18, 2025 at 2:48=E2=80=AFPM Chuck Lever <chuck.lever@orac=
le.com> wrote:
> >>>>
> >>>> Hi Olga -
> >>>>
> >>>> On 8/18/25 2:25 PM, Olga Kornievskaia wrote:
> >>>>> When a listener is added, a part of creation of transport also regi=
sters
> >>>>> program/port with rpcbind. However, when the listener is removed,
> >>>>> while transport goes away, rpcbind still has the entry for that
> >>>>> port/type.
> >>>>>
> >>>>> When deleting the transport, unregister with rpcbind when appropria=
te.
> >>>>
> >>>> The patch description needs to explain why this is needed. Did you
> >>>> mention to me there was a crash or other malfunction?
> >>>
> >>> Malfunction is that nfsdctl removed a listener (nfsdctl listener
> >>> -udp::2049)  but rpcinfo query still shows it (rpcinfo -p |grep -w
> >>> nfs).
> >>>
> >>>>> Fixes: d093c9089260 ("nfsd: fix management of listener transports")
> >>>>> Signed-off-by: Olga Kornievskaia <okorniev@redhat.com>
> >>>>> ---
> >>>>>  net/sunrpc/svc_xprt.c | 17 +++++++++++++++++
> >>>>>  1 file changed, 17 insertions(+)
> >>>>>
> >>>>> diff --git a/net/sunrpc/svc_xprt.c b/net/sunrpc/svc_xprt.c
> >>>>> index 8b1837228799..223737fac95d 100644
> >>>>> --- a/net/sunrpc/svc_xprt.c
> >>>>> +++ b/net/sunrpc/svc_xprt.c
> >>>>> @@ -1014,6 +1014,23 @@ static void svc_delete_xprt(struct svc_xprt =
*xprt)
> >>>>>       struct svc_serv *serv =3D xprt->xpt_server;
> >>>>>       struct svc_deferred_req *dr;
> >>>>>
> >>>>> +     /* unregister with rpcbind for when transport type is TCP or =
UDP.
> >>>>> +      * Only TCP and RDMA sockets are marked as LISTENER sockets, =
so
> >>>>> +      * check for UDP separately.
> >>>>> +      */
> >>>>> +     if ((test_bit(XPT_LISTENER, &xprt->xpt_flags) &&
> >>>>> +         xprt->xpt_class->xcl_ident !=3D XPRT_TRANSPORT_RDMA) ||
> >>>>> +         xprt->xpt_class->xcl_ident =3D=3D XPRT_TRANSPORT_UDP) {
>
> I still think this check is unnecessarily confusing.
>
> Can you instead add an XPT_RPCB_UNREG_ON_CLOSE flag in the
> svc_xprt::xpt_flags field? Check if that one flag is set here.
>
> Set XPT_RPCB_UNREG_ON_CLOSE for TCP listener sockets and all UDP
> sockets.
>
> An additional clean-up might be to add an svc_rpcb_cleanup() call to
> svc_xprt_destroy_all(), and remove svc_rpcb_cleanup() from the upper
> layer callers to svc_xprt_destroy_all().

Let me work on v2 for the above.

>
>
> >>>> Now I thought that UDP also had a rpcbind registration ... ?
> >>>
> >>> Correct.
> >>>
> >>>> So I don't
> >>>> quite understand why gating the unregistration is necessary.
> >>>
> >>> We are sending unregister for when the transport xprt is of type
> >>> LISTENER (which covers TCP but not UDP) so to also send unregister fo=
r
> >>> UDP we need to check for it separately. RDMA listener transport is
> >>> also marked as listener but we do not want to trigger unregister here
> >>> because rpcbind knows nothing about rdma type.
> >
> > rpcbind is supposed to know about the "rdma" and "rdma6" netids. The
> > convention though is not to register them. Registering those transports
> > should work just fine.
> >
> >
> >>> Transports are not necessarily of listener type and thus we don't wan=
t
> >>> to trigger rpcbind unregister for that.
> >
> > Ah. Maybe svc_delete_xprt() is not the right place for unregistration.
> >
> > The "listener" check here doesn't seem like the correct approach, but
> > I don't know enough about how UDP set-up works to understand how that
> > transport is registered.
> >
> > A xpo_register and a xpo_unregister method can be added to the
> > svc_xprt_ops structure to partially handle the differences. The questio=
n
> > is where should those methods be called?
> >
> >
> >> I still feel that unregistering "all" with rpcbind in nfsctl after we
> >> call svc_xprt_destroy_all() seems cleaner (single call vs a call per
> >> registered transport). But this approach would go for when listeners
> >> are allowed to be deleted while the server is running. Perhaps both
> >> patches can be considered for inclusion.
> >
> > You and Jeff both seem to want to punt on this, but...
> >
> > People will see that a transport can be removed, but having to shut dow=
n
> > the whole NFS service to do that seems... unexpected and rather useless=
.
> > At the very least, it would indicate to me as a sysadmin that the
> > "remove transport" feature is not finished, and is thus unusable in its
> > current form.
> >
> > An alternative is to simply disable the "remove transport" API until it
> > can be implemented correctly.
> >
> >
> >>>>> +             struct svc_sock *svsk =3D container_of(xprt, struct s=
vc_sock,
> >>>>> +                                                  sk_xprt);
> >>>>> +             struct socket *sock =3D svsk->sk_sock;
> >>>>> +
> >>>>> +             if (svc_register(serv, xprt->xpt_net, sock->sk->sk_fa=
mily,
> >>>>> +                              sock->sk->sk_protocol, 0) < 0)
> >>>>> +                     pr_warn("failed to unregister %s with rpcbind=
\n",
> >>>>> +                             xprt->xpt_class->xcl_name);
> >>>>> +     }
> >>>>> +
> >>>>>       if (test_and_set_bit(XPT_DEAD, &xprt->xpt_flags))
> >>>>>               return;
> >>>>>
> >>>>
> >>>>
> >>>> --
> >>>> Chuck Lever
> >>>>
> >>>
> >>
> >
> >
>
>
> --
> Chuck Lever


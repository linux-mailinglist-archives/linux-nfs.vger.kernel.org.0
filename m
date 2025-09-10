Return-Path: <linux-nfs+bounces-14245-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BA5DB51EAF
	for <lists+linux-nfs@lfdr.de>; Wed, 10 Sep 2025 19:15:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AD7EF566E11
	for <lists+linux-nfs@lfdr.de>; Wed, 10 Sep 2025 17:15:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 174982DECBC;
	Wed, 10 Sep 2025 17:14:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=umich.edu header.i=@umich.edu header.b="emehGzOu"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C36BF329F0B
	for <linux-nfs@vger.kernel.org>; Wed, 10 Sep 2025 17:14:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757524498; cv=none; b=RjPVQRUAyQxOSWSmHrxBL/SZtmErKB0fSQInAMayHFNCxpcrdPQItJokylzcuwiUP8ihahtu8rRmpUKSNGj5Cp1T4WfJHeZln62e5HdD0Il8dYXP7byUxQVOiT2XuFhJfvFcD5uGDPqvjWttTQrYCusv9j2ksgh7/IxHy1n8JYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757524498; c=relaxed/simple;
	bh=h31ESta0f6zzcpV695KuRl2Ejd+Ty6eHvUeaEkUD39A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mRV4DGqLKgLHVpdNEkRqTcgFiOAADTAsvC4M/jPUq48VTFfD2avr8OMF+ELIqKerh3lCOmMEifopWH9BJ7LSHOmhiVEMk1rtUKaO+k67XQmnv6o7+84kmdQ0sgO5XftAXVBLUWmXXHv1hpw1bbVss+OqavJy+d7ix6e0Hm/iswk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=umich.edu; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=umich.edu header.i=@umich.edu header.b=emehGzOu; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=umich.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-55f72452a8eso8496938e87.3
        for <linux-nfs@vger.kernel.org>; Wed, 10 Sep 2025 10:14:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umich.edu; s=google-2016-06-03; t=1757524494; x=1758129294; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OfGKj30Zn3smuGczTnygXMmhWUjtpgNty6xpswLaGTc=;
        b=emehGzOu40+Hjb9TQWLeJgHeq80N9N0mupe03N2ASkRuVOO7Kh8SxgRp8YPxtGExRW
         +9a8axIYF+WgM+dAFVNNm+CiLp3LMoV/sOaHsIM8XII53qD41ciUe6FvRv758vBcqp9w
         Q6BcyrR481UtlENgpfg3PrIEKwS3RKmwXkLNRidSrxgIZChwjCjUKff45NQeK43sUQP8
         t4BGNWUpOLtPEAnHRMlTur97Dqn9SVdJoqeiTcQ6O/qZ9NA2tRXMvi7BQemx2etcLP8s
         AckJ00P4SkZcHt10UqznXXhXiHpwunmUTVfj202rfKKj2tJG63rmoYM7Y/5A3vV63uog
         uU/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757524494; x=1758129294;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OfGKj30Zn3smuGczTnygXMmhWUjtpgNty6xpswLaGTc=;
        b=vUkjhpvqN5QNdMDvFqNhNMbwfwe0YgblEp/E40JpXerNMZr/dug2QcJDP16tQmnmdf
         lTtfx1GA4Th3u5gEQ7cYZDLsvkC5AmQSnicsnbau1aCN99Y0Uq0kULDzs7WJKiE794TW
         jkt2rUBWAXt2Gc7Mmttt8XC7W+U69BDdSz/LWoxJnX+RvoaUfSR/h3sQZfjBIAsPkQw6
         gAIPeaJEwh4GPD8XlsOwQ9boe8hBJzc9sJEuKA5bZLYrci1bW6eRP8aMUziG0mK5emiJ
         HqoGgmi3jm1ehnFKeFx5QTKRhIsTyWfi0fMq0MwOWm5FuOMcQ6lZba9a/w9zCLjNFS+/
         L/Wg==
X-Forwarded-Encrypted: i=1; AJvYcCUBX7OIqXzKkBroRWNhljiiL1dSrVNiTQD+TwR0F5rt3Av7LOht2Mb0qCTPsODXeSgMg7CPSbS99hU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxjio7jsz7YXRuf0W44f7M5dYdfznPQFvNpIxCce7uNIplxosyc
	NrOZvq5ch7pmpJ5ZBLPvPQbdHB8ydXpT9ZNJOLrsO+LIIdpvae/g+/C6MjKud/dnyAnYtn7Ahjg
	387n2GltSAWz0OtqHj+8Wkay/1QpTj/0=
X-Gm-Gg: ASbGncvIlR1KF/5WIyU7YH+Jk8ZsflIUcfy5SNBXadpKrJ2NYr+DyBmS4AIwz+mWxlc
	ya8H6TM58tiAvltcYs5dlafJIk8lp0r/bCrs137XDx/8bTeWaUdGAlq+Kih1ievSAjLTGAoz/hk
	dG6dvJNb35rpBh1K62SCA4s/DkVYV3C5Tae5XXgJhmXsgPt6V0PelcgWIY70PKhDOMdkBaTOczg
	J1Q2gA/hhlILi9AmQ==
X-Google-Smtp-Source: AGHT+IG+hSFAoXVZS/N8MeX34W3YHGDhZutoginVtuGNRKgjHYXPk6POWzoDLrMV+bxpM6OD77TrYx0u8YybeWqy384=
X-Received: by 2002:a05:6512:b12:b0:55f:6d6e:1e97 with SMTP id
 2adb3069b0e04-56264a0f596mr5553255e87.52.1757524493584; Wed, 10 Sep 2025
 10:14:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250903155335.1558-1-cel@kernel.org> <CACSpFtB7CSkakYL5FZj_6L4dgj2ybBMVzgqX8kWhZrGBW0GT7Q@mail.gmail.com>
 <5a1f9a16-2373-4e30-b356-42e3af047126@kernel.org>
In-Reply-To: <5a1f9a16-2373-4e30-b356-42e3af047126@kernel.org>
From: Olga Kornievskaia <aglo@umich.edu>
Date: Wed, 10 Sep 2025 13:14:42 -0400
X-Gm-Features: Ac12FXwB8ByMNYhPpze7qn0baB0qShw9MdUUcOCfqr58KZwVI506HQpeEN0aGYg
Message-ID: <CAN-5tyFXySFeOcDorhDcD+oAzBFq_G-48mmxFSQMEik8rEcd8w@mail.gmail.com>
Subject: Re: [RFC PATCH v1] svcrdma: Release transport resources synchronously
To: Chuck Lever <cel@kernel.org>
Cc: Olga Kornievskaia <okorniev@redhat.com>, NeilBrown <neil@brown.name>, 
	Jeff Layton <jlayton@kernel.org>, Dai Ngo <dai.ngo@oracle.com>, Tom Talpey <tom@talpey.com>, 
	linux-nfs@vger.kernel.org, Chuck Lever <chuck.lever@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 4, 2025 at 11:48=E2=80=AFAM Chuck Lever <cel@kernel.org> wrote:
>
> On 9/4/25 11:43 AM, Olga Kornievskaia wrote:
> > On Wed, Sep 3, 2025 at 11:53=E2=80=AFAM Chuck Lever <cel@kernel.org> wr=
ote:
> >>
> >> From: Chuck Lever <chuck.lever@oracle.com>
> >>
> >> NFSD has always supported added network listeners. The new netlink
> >> protocol now enables the removal of listeners.
> >>
> >> Olga noticed that if an RDMA listener is removed and immediately
> >> re-added, the deferred __svc_rdma_free() function might not have
> >> run yet, so some or all of the old listener's RDMA resources
> >> linger, which prevents a new listener on the same address from
> >> being created.
> >
> > Does this mean that you prefer to go the way of rdma synchronous
> > release vs the patch I posted?
>
> We could do both. IMO we need to make "remove listener" work while
> there are still nfsd threads running, and this RFC patch does
> nothing about that.
>
> But as noted below, it looks like the svc_xprt_free() code path assumes
> that ->xpo_free releases all transport resources synchronously, and
> there can be consequences if that does not happen. That needs to be
> addressed somehow.
>
>
> > I'm not against the approach as I have previously noted it as an
> > alternative which I tested and it also solves the problem. But I still
> > dont grasp the consequence of making svc_rdma_free() synchronous,
> > especially for active transports (not listening sockets).
>
> I've tested the synchronous approach a little, there didn't seem to
> be a problem with it. But I agree, the certainty level is not as
> high as it ought to be.

So what do you think about including this patch? I don't see it in
your nfsd-testing branch.

Either this patch or my patch fix an existing problem and I believe
would be beneficial to include now (and backport). A solution for
removal of listeners on an active server can be worked on top of that.



> >> Also, svc_xprt_free() does a module_put() just after calling
> >> ->xpo_free(). That means if there is deferred work going on, the
> >> module could be unloaded before that work is even started,
> >> resulting in a UAF.
> >>
> >> Neil asks:
> >>> What particular part of __svc_rdma_free() needs to run in order for a
> >>> subsequent registration to succeed?
> >>> Can that bit be run directory from svc_rdma_free() rather than be
> >>> delayed?
> >>> (I know almost nothing about rdma so forgive me if the answers to the=
se
> >>> questions seems obvious)
> >>
> >> The reasons I can recall are:
> >>
> >>  - Some of the transport tear-down work can sleep
> >>  - Releasing a cm_id is tricky and can deadlock
> >>
> >> We might be able to mitigate the second issue with judicious
> >> application of transport reference counting.
> >>
> >> Reported-by: Olga Kornievskaia <okorniev@redhat.com>
> >> Suggested-by: NeilBrown <neil@brown.name>
> >> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
> >> ---
> >>  net/sunrpc/svc_xprt.c                    |  1 +
> >>  net/sunrpc/xprtrdma/svc_rdma_transport.c | 19 ++++++++-----------
> >>  2 files changed, 9 insertions(+), 11 deletions(-)
> >>
> >> diff --git a/net/sunrpc/svc_xprt.c b/net/sunrpc/svc_xprt.c
> >> index 8b1837228799..8526bfc3ab20 100644
> >> --- a/net/sunrpc/svc_xprt.c
> >> +++ b/net/sunrpc/svc_xprt.c
> >> @@ -168,6 +168,7 @@ static void svc_xprt_free(struct kref *kref)
> >>         struct svc_xprt *xprt =3D
> >>                 container_of(kref, struct svc_xprt, xpt_ref);
> >>         struct module *owner =3D xprt->xpt_class->xcl_owner;
> >> +
> >>         if (test_bit(XPT_CACHE_AUTH, &xprt->xpt_flags))
> >>                 svcauth_unix_info_release(xprt);
> >>         put_cred(xprt->xpt_cred);
> >> diff --git a/net/sunrpc/xprtrdma/svc_rdma_transport.c b/net/sunrpc/xpr=
trdma/svc_rdma_transport.c
> >> index 3d7f1413df02..b7b318ad25c4 100644
> >> --- a/net/sunrpc/xprtrdma/svc_rdma_transport.c
> >> +++ b/net/sunrpc/xprtrdma/svc_rdma_transport.c
> >> @@ -591,12 +591,18 @@ static void svc_rdma_detach(struct svc_xprt *xpr=
t)
> >>         rdma_disconnect(rdma->sc_cm_id);
> >>  }
> >>
> >> -static void __svc_rdma_free(struct work_struct *work)
> >> +/**
> >> + * svc_rdma_free - Release class-specific transport resources
> >> + * @xprt: Generic svc transport object
> >> + */
> >> +static void svc_rdma_free(struct svc_xprt *xprt)
> >>  {
> >>         struct svcxprt_rdma *rdma =3D
> >> -               container_of(work, struct svcxprt_rdma, sc_work);
> >> +               container_of(xprt, struct svcxprt_rdma, sc_xprt);
> >>         struct ib_device *device =3D rdma->sc_cm_id->device;
> >>
> >> +       might_sleep();
> >> +
> >>         /* This blocks until the Completion Queues are empty */
> >>         if (rdma->sc_qp && !IS_ERR(rdma->sc_qp))
> >>                 ib_drain_qp(rdma->sc_qp);
> >> @@ -629,15 +635,6 @@ static void __svc_rdma_free(struct work_struct *w=
ork)
> >>         kfree(rdma);
> >>  }
> >>
> >> -static void svc_rdma_free(struct svc_xprt *xprt)
> >> -{
> >> -       struct svcxprt_rdma *rdma =3D
> >> -               container_of(xprt, struct svcxprt_rdma, sc_xprt);
> >> -
> >> -       INIT_WORK(&rdma->sc_work, __svc_rdma_free);
> >> -       schedule_work(&rdma->sc_work);
> >> -}
> >> -
> >>  static int svc_rdma_has_wspace(struct svc_xprt *xprt)
> >>  {
> >>         struct svcxprt_rdma *rdma =3D
> >> --
> >> 2.50.0
> >>
> >
>
>
> --
> Chuck Lever
>


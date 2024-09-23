Return-Path: <linux-nfs+bounces-6617-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1638197F194
	for <lists+linux-nfs@lfdr.de>; Mon, 23 Sep 2024 22:15:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 77DEAB210C1
	for <lists+linux-nfs@lfdr.de>; Mon, 23 Sep 2024 20:15:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 811C41A0716;
	Mon, 23 Sep 2024 20:15:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="0BaoH5OZ"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD7B236126
	for <linux-nfs@vger.kernel.org>; Mon, 23 Sep 2024 20:15:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727122533; cv=none; b=C54yjQHaU5POX+ad3YFLLkxPgDE6bdT7SRicwux0SIkDAHGCuW3GvLx/+k0V+cBL/Ks1K6N65l2x1hPYHivuZODDMqx/DuP7Xszhp13BtwZpeLximL0KGHLgB/iY4BBv+rLhIx8/zmjGbMwtmOWmbahG+XVQ+AQo7pYDQ2wvm6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727122533; c=relaxed/simple;
	bh=0H6ENbvlTQSEZxIo+1obedDkpsYcANjKsRp/QdY+1z8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mxJJjBcdkgu9QSvQnLdSFeavmFEtzVvPfhKBaoQdIzrP6tRbWNbIyiJXuS9e5PodZDhNwiQmAn186hAQBTlUg9Qf6xprrx80mRen4+irD1+n8bql9kO8j3yRSpsGMUYDvtInFLqq8HBTD7ovXaVZGufeoCYfXysFfpZw+Moaxj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=0BaoH5OZ; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2056aa5cefcso42175ad.0
        for <linux-nfs@vger.kernel.org>; Mon, 23 Sep 2024 13:15:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1727122531; x=1727727331; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cTuhI0jObA1thj5wXELvo1EktSlaWbvDYhEVGakUX6o=;
        b=0BaoH5OZaK4t3V4lrtsS2DV8XUo2gRRQgruZ4DypyHtgdt/HWfyvY9MIPsDkN8Mqbj
         BhQDjsZClnq5SkrY4VaoMyeRPtJMEt1jJgh3nSuo3R6dOhOc7eotz26DFdJfXeHQXqeJ
         xzuLmpn7BBvMbSTodgrv5Xhdh8AfGFgkIVQbl9Nc3vBy7xkZrBeyG7ZhkHFzQiRCsm8h
         brM+5LEoKINm24sbHM0VAMQG8814fOqfskHZtjMKpDHK/DJWUNvQYN87jJGL/Uxw6Lmq
         HSl4n0mtrpkuIehgiqoiBvcxXDIkxRSXlrQDU5YH1L+WDKM0P4UjZsE8GMVcvsEyJ4Il
         Lsvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727122531; x=1727727331;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cTuhI0jObA1thj5wXELvo1EktSlaWbvDYhEVGakUX6o=;
        b=sxkCbZpniN1E3AULsYsPziAbkHj5PU4ngQ21mhSflcJ5iQaV0iHz4BO81A+j1QTZJj
         wjLQUlPcQclVPnvM4SEHp0opUn8tIue2p6x5etcf9o4aHbyfd4vBYScRRP5sg7yeNiQb
         BfoXzjZlt8c3921plSmihgedLisiSDe1YvCHSKUrC6Sk6jgj+9Tz+FFs131QBVXue8w8
         MoVJN0OxHEe2SXNCtZCA7sxLxSw7dOWSxxxsLw9woorqGviPOUtDlKf7SbMS3bP8dbDq
         jl2DdvZQ3j/7Bm+dsrFhD96gqa2/lmeHZ9XNDxdQasecKogaMaACwzqXSdqfGo5zRb4d
         27kw==
X-Forwarded-Encrypted: i=1; AJvYcCU7IaLPJSv1CLWJ+FGC7r2iXq6Le06SpXGMTfHhuoJAx6+qX2HSdOndQi+OsrUyXWIvuJUykd6Xkas=@vger.kernel.org
X-Gm-Message-State: AOJu0YwMzV4u6VL47fSrtPBC2ILOzP8jM5Atvlg2wzLtcOPqq/cFANIA
	IOrEIH5V6De0T/Iwaekc9gcR+Gb35Hx6KL3cR6oa31pfngogaAhe9a9a/zFCeOtpwKb1/2qaOkc
	by4MAfD9swqybCWbARdCe67/sO6FrIDxM7pa/Ry05QDEFYpAOtw==
X-Google-Smtp-Source: AGHT+IHmh02yXm9i2/a395bH2npymCVb0LAxjXgYhMK0kTeo0IfylvI3/ai3urygr3mdT8sWUE48LgPgqLYcSWrvHyE=
X-Received: by 2002:a17:903:24d:b0:206:d6a4:e13a with SMTP id
 d9443c01a7336-20aeedf40b3mr625565ad.26.1727122530929; Mon, 23 Sep 2024
 13:15:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <8f2e20f2fc894398da371517c6c8111aba072fb1.camel@kernel.org>
 <20240909163610.2148932-1-ovt@google.com> <84f2415b4d5bb42dc7e26518983f53a997647130.camel@hammerspace.com>
 <CACGj0ChtssX4hCCEnD9hah+-ioxmAB8SzFjJR3Uk1FEWMizv-A@mail.gmail.com>
 <8d95e5334c664d10a751e5791c8291959217524e.camel@hammerspace.com> <CACGj0CgobBUv9CgpAhw+XWFwJY7+A0MryOTyukXz8Jsoc9hdQw@mail.gmail.com>
In-Reply-To: <CACGj0CgobBUv9CgpAhw+XWFwJY7+A0MryOTyukXz8Jsoc9hdQw@mail.gmail.com>
From: Oleksandr Tymoshenko <ovt@google.com>
Date: Mon, 23 Sep 2024 13:15:17 -0700
Message-ID: <CACGj0ChbuJ=p6WT62rYWarB=E6Uf3Cs_rz7icDPo5uH3GgVpmQ@mail.gmail.com>
Subject: Re: [PATCH] NFSv4: fix a mount deadlock in NFS v4.1 client
To: Trond Myklebust <trondmy@hammerspace.com>
Cc: "anna@kernel.org" <anna@kernel.org>, "jbongio@google.com" <jbongio@google.com>, 
	"linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>, 
	"stable@vger.kernel.org" <stable@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Trond,

Following up on this: do you have plans to submit the patch you proposed
or do you want me to rework my submission along the lines you proposed?

On Tue, Sep 10, 2024 at 2:08=E2=80=AFPM Oleksandr Tymoshenko <ovt@google.co=
m> wrote:
>
> On Mon, Sep 9, 2024 at 5:22=E2=80=AFPM Trond Myklebust <trondmy@hammerspa=
ce.com> wrote:
> >
> > On Mon, 2024-09-09 at 16:06 -0700, Oleksandr Tymoshenko wrote:
> > > On Mon, Sep 9, 2024 at 10:56=E2=80=AFAM Trond Myklebust
> > > <trondmy@hammerspace.com> wrote:
> > > >
> > > > On Mon, 2024-09-09 at 16:36 +0000, Oleksandr Tymoshenko wrote:
> > > > > > > nfs41_init_clientid does not signal a failure condition from
> > > > > > > nfs4_proc_exchange_id and nfs4_proc_create_session to a
> > > > > > > client
> > > > > > > which
> > > > > > > may
> > > > > > > lead to mount syscall indefinitely blocked in the following
> > > > > > > stack
> > > > >
> > > > > > NACK. This will break all sorts of recovery scenarios, because
> > > > > > it
> > > > > > doesn't distinguish between an initial 'mount' and a server
> > > > > > reboot
> > > > > > recovery situation.
> > > > > > Even in the case where we are in the initial mount, it also
> > > > > > doesn't
> > > > > > distinguish between transient errors such as NFS4ERR_DELAY or
> > > > > > reboot
> > > > > > errors such as NFS4ERR_STALE_CLIENTID, etc.
> > > > >
> > > > > > Exactly what is the scenario that is causing your hang? Let's
> > > > > > try
> > > > > > to
> > > > > > address that with a more targeted fix.
> > > > >
> > > > > The scenario is as follows: there are several NFS servers and
> > > > > several
> > > > > production machines with multiple NFS mounts. This is a
> > > > > containerized
> > > > > multi-tennant workflow so every tennant gets its own NFS mount to
> > > > > access their
> > > > > data. At some point nfs41_init_clientid fails in the initial
> > > > > mount.nfs call
> > > > > and all subsequent mount.nfs calls just hang in
> > > > > nfs_wait_client_init_complete
> > > > > until the original one, where nfs4_proc_exchange_id has failed,
> > > > > is
> > > > > killed.
> > > > >
> > > > > The cause of the nfs41_init_clientid failure in the production
> > > > > case
> > > > > is a timeout.
> > > > > The following error message is observed in logs:
> > > > >   NFS: state manager: lease expired failed on NFSv4 server <ip>
> > > > > with
> > > > > error 110
> > > > >
> > > >
> > > > How about something like the following fix then?
> > > > 8<-----------------------------------------------
> > > > From eb402b489bb0d0ada1a3dd9101d4d7e193402e46 Mon Sep 17 00:00:00
> > > > 2001
> > > > Message-ID:
> > > > <eb402b489bb0d0ada1a3dd9101d4d7e193402e46.1725904471.git.trond.mykl
> > > > ebust@hammerspace.com>
> > > > From: Trond Myklebust <trond.myklebust@hammerspace.com>
> > > > Date: Mon, 9 Sep 2024 13:47:07 -0400
> > > > Subject: [PATCH] NFSv4: Fail mounts if the lease setup times out
> > > >
> > > > If the server is down when the client is trying to mount, so that
> > > > the
> > > > calls to exchange_id or create_session fail, then we should allow
> > > > the
> > > > mount system call to fail rather than hang and block other
> > > > mount/umount
> > > > calls.
> > > >
> > > > Reported-by: Oleksandr Tymoshenko <ovt@google.com>
> > > > Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
> > > > ---
> > > >  fs/nfs/nfs4state.c | 6 ++++++
> > > >  1 file changed, 6 insertions(+)
> > > >
> > > > diff --git a/fs/nfs/nfs4state.c b/fs/nfs/nfs4state.c
> > > > index 30aba1dedaba..59dcdf9bc7b4 100644
> > > > --- a/fs/nfs/nfs4state.c
> > > > +++ b/fs/nfs/nfs4state.c
> > > > @@ -2024,6 +2024,12 @@ static int
> > > > nfs4_handle_reclaim_lease_error(struct nfs_client *clp, int status)
> > > >                 nfs_mark_client_ready(clp, -EPERM);
> > > >                 clear_bit(NFS4CLNT_LEASE_CONFIRM, &clp->cl_state);
> > > >                 return -EPERM;
> > > > +       case -ETIMEDOUT:
> > > > +               if (clp->cl_cons_state =3D=3D NFS_CS_SESSION_INITIN=
G) {
> > > > +                       nfs_mark_client_ready(clp, -EIO);
> > > > +                       return -EIO;
> > > > +               }
> > > > +               fallthrough;
> > > >         case -EACCES:
> > > >         case -NFS4ERR_DELAY:
> > > >         case -EAGAIN:
> > > > --
> > >
> > > This patch fixes the issue in my simulated environment. ETIMEDOUT is
> > > the error code that
> > > was observed in the production env but I guess it's not the only
> > > possible one. Would it make
> > > sense to handle all error conditions in the NFS_CS_SESSION_INITING
> > > state or are there
> > > some others that are recoverable?
> > >
> >
> > The only other one that I'm thinking might want to be treated similarly
> > is the above EACCES error. That's because that is only returned if
> > there is a problem with your RPCSEC_GSS/krb5 credential. I was thinking
> > of changing that one too in the same patch, but came to the conclusion
> > it would be better to treat the two issues with separate fixes.
> >
> > The other error conditions are all supposed to be transient NFS level
> > errors. They should not be treated as fatal.
>
> Sounds good. Will you submit this patch to the mainline kernel? If so
> please add me to Cc. Thanks for looking into this.


Return-Path: <linux-nfs+bounces-17241-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id BA99DCD144B
	for <lists+linux-nfs@lfdr.de>; Fri, 19 Dec 2025 19:00:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A0CBA31415E1
	for <lists+linux-nfs@lfdr.de>; Fri, 19 Dec 2025 17:54:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0075634D93A;
	Fri, 19 Dec 2025 17:43:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=umich.edu header.i=@umich.edu header.b="EKmKx6cq"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BBEA34D910
	for <linux-nfs@vger.kernel.org>; Fri, 19 Dec 2025 17:43:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766166236; cv=none; b=sG3I/QwPMkZEjtt93GxJ4sHajdyWZAE3RgPcpsDtR0XnQC/bmG2GYpVOOyOMfkvl838QxTX6xUF9e86XWU6Nj/9meMcgVPnU0xRjx+97gEnGCyTFLRoAOZ7P86olqapWarfc797ofOKfVI/C9qpO/CXEKuCyX0ISSNXqot81V+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766166236; c=relaxed/simple;
	bh=clJOmcKBoIw88yyLKoGsGuFZz1HxZegEl+3YdMQFKMo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qmrtsbZLDKs14jKdgjD3VmAwC5YCxN12fmEo+fV668n/1NQ/PvutqjUM0itSVROOqstcbOl+yxLlDSiCZxdxYMNekUU7UD5aFNDcRELa998RPBye4+0bsnKDbTOGpB8vBqGreh2KXy6ffeZgKa2LNFUThdGInQHy9U4nyBb/TYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=umich.edu; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=umich.edu header.i=@umich.edu header.b=EKmKx6cq; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=umich.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-37a415a22ecso13745251fa.0
        for <linux-nfs@vger.kernel.org>; Fri, 19 Dec 2025 09:43:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umich.edu; s=google-2016-06-03; t=1766166233; x=1766771033; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NVixkaXTuKtHeBsxOi4jAc7JBev7bh1+nWIb2RYC3oo=;
        b=EKmKx6cqr0SKapJQjrfCqcQiCJxEOFpQA2bZrGPDQusRExrdzSg3O1cg8J1T1F5dq7
         HfCYi7J/PCL7b89wyYON+ZJtrp0ohFzsJ8hliEHDNCzVeYT5ZR0FjaJWmw7z0gVZBU3k
         VnTbSjiBfsG/mkpXxhBFIuh7WkNMfIwF4nezT0CJsdUN0d4XeZTbWOfHDA8FIeSWrc8s
         RCR14tbgbCqSiu8h291hp+zTNA7OyazxxPQXPQzBRL+XH9iNXpLbD+XsXJzjiinRm6lz
         SFv16SuySrm8CfnZOQbaWnQ2bxvm/ieh3XeW5U2AhEvwt6eKDtoJOOQdAfsVxotyzUda
         lWBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766166233; x=1766771033;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=NVixkaXTuKtHeBsxOi4jAc7JBev7bh1+nWIb2RYC3oo=;
        b=taplgF1onN7YfzgJ3H/s11gJ+NRA+lKZ7myK3zq3CL7sytRNlOfKulT/m1GYOdyoHE
         eEjHWdhde4PsKUqJukAQTf4D5xXgeE0KirTyS3+xJbRcYZQ5bimPVmT33YWrqpKOqP1l
         4LhvZFPQsp+Lw3J2q+qu09+cs+FX0Bx39OkZ/WdRpXnm6AkkIndNqciwH9V4NjK1f+X6
         OuaczB2sPBMHozmLU795sjorGSQPgE4KcaeCjG8ljqPoyOBQGI/9OHQLu4FePIgDmwFf
         RD6zPw9SQQE0SnjisXpNO6i65ql29V0dnQVt4om57BnTu0wtPjAdoj3F0+EGFopl8A/T
         f0lQ==
X-Forwarded-Encrypted: i=1; AJvYcCW9zWKXBMFZQiPv79pSaynqc8zK9HsHA2HhBeiWhHPUIWKJAkNMArhvD6IhHmMftir3IrsRttQr21o=@vger.kernel.org
X-Gm-Message-State: AOJu0YxAeXy42GR3cfCePHeVUjIEl14vt+aAegEY9F0ImlKO0EBJ5jt0
	ikm3NvWhvkYr5J3VtGdg/4gUlSGOgamDg4q+1eNhM28/N4B1jC+iTI4u16qszeXkCLK7Dl0l3z2
	m9taA5M0LsLa9RR50sL7C9hWw80A7Xgk=
X-Gm-Gg: AY/fxX5N7jhg1zaM0Six5DK1gaItiCavSdxPNgBV6084iRbAfT/Dy0yKMK7r7CSBitU
	HpufHu9VRw/4oeoVMAAyoEtwOKLB0t3Z12yRi5Mcnzgx3i0lod/q1XmFkokLrh1qCGBFNPhyn/W
	JUUVllvv6Ihv88WZaHf0ZcksiGkNVNIsf9G9WCskTJebfTk1ukdNSY0pHka6+8FW2CRTvE4KWPz
	DZcWhRZoMKvLcfk4njfgWWNps94ih3lPL4rNqgPEA68kfkcB2tDI7J2yKEK3Gn9ROFZk+ZQnAeB
	hLr4bkKx+oBeiQRq878R5o6CNnviCg==
X-Google-Smtp-Source: AGHT+IGBTzirJN0UMNYnb3SF06ff10PRsmk6ZfxGaQEVs2SJVv9RMQ8FyELJ0lDv89cOigRB7MBj/ZxfRIZYQuecn6E=
X-Received: by 2002:a2e:be1b:0:b0:37b:9674:f480 with SMTP id
 38308e7fff4ca-38113248ba3mr22256161fa.11.1766166232887; Fri, 19 Dec 2025
 09:43:52 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250730-nfsd-testing-v4-0-7f5730570a52@kernel.org>
 <20250730-nfsd-testing-v4-8-7f5730570a52@kernel.org> <CAN-5tyEjYRFrJ7Gc4S8KwAZUuF-uz6ovPa4-_ynt+GGVqJHN_A@mail.gmail.com>
 <ca86b70c1a4a25c2f084bfce53ed864a557ebfed.camel@kernel.org>
In-Reply-To: <ca86b70c1a4a25c2f084bfce53ed864a557ebfed.camel@kernel.org>
From: Olga Kornievskaia <aglo@umich.edu>
Date: Fri, 19 Dec 2025 12:43:41 -0500
X-Gm-Features: AQt7F2o2e0WOyiUDgBbJV-UEiZdMnMvYpMz7N-BnEynBqDbI0To7sXd0rYxMHwc
Message-ID: <CAN-5tyE1YazMhYJX5qT-YM=+h_rcQ+C9PZBNEEvwWRnWZtLXGQ@mail.gmail.com>
Subject: Re: [PATCH v4 8/8] nfsd: freeze c/mtime updates with outstanding
 WRITE_ATTRS delegation
To: Jeff Layton <jlayton@kernel.org>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Chuck Lever <chuck.lever@oracle.com>, 
	NeilBrown <neil@brown.name>, Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, 
	Tom Talpey <tom@talpey.com>, Trond Myklebust <trondmy@hammerspace.com>, 
	Anna Schumaker <anna@kernel.org>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	linux-nfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 19, 2025 at 12:25=E2=80=AFPM Jeff Layton <jlayton@kernel.org> w=
rote:
>
> On Fri, 2025-12-19 at 10:58 -0500, Olga Kornievskaia wrote:
> > Hi Jeff,
> >
> > I narrowed down the upstream failure for generic/215 and generic/407
> > to this commit.
> >
> > Let's consider first where the kernel is compiled with delegated
> > attributes off (but it also fails just the same if the delegated
> > attributes are compiled in).
> >
> > I don't understand why the code unconditionally changed to call
> > nfsd4_finalize_deleg_timestamps() which I think the main driver behind
> > the failure.
> >
> > Running generic/407 there is an OPEN (which gives out a write
> > delegation) and returns a change id, then on this filehandle there is
> > a SETATTR (with a getattr) which returns a new changeid. Then there is
> > a CLONE where the filehandle is the destination filehandle on which
> > there is a getattr which returns unchanged changeid/modify time (bad).
> > Then there is a DELEGRETURN (with a getattr) which again returns same
> > change id. Test fails.
> >
> > Prior to this commit. The changeid/modify time is different in CLONE
> > and DELEGRETURN -- test passes.
> >
> > Now let me describe what happens with delegated attributes enabled.
> > OPEN returns delegated attributes delegation, included getattr return
> > a changeid. Then CLONE is done, the included gettattr returns a
> > different (from open's) changeid (different time_modify). Then there
> > is SETATTR+GEATTR+DELEGRETURN compound from the client (which carries
> > a time_deleg_modify value different from above). Server in getattr
> > replies with changeid same as in clone and mtime with the value client
> > provided. So I'm not sure exactly why the test fails here but that's a
> > different problem as my focus is on "delegation attribute off option"
> > at the moment.
> >
> > I don't know if this is the correct fix or not but perhaps we
> > shouldn't unconditionally be setting this mode? (note this fix only
> > fixes the delegattributes off. however i have no claims that this
> > patch is what broke 215/407 for delegated attributes on. Something
> > else is in play there). If this solution is acceptable, I can send a
> > patch.
> >
> > diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
> > index 81fa7cc6c77b..624cc6ab2802 100644
> > --- a/fs/nfsd/nfs4state.c
> > +++ b/fs/nfsd/nfs4state.c
> > @@ -6318,7 +6318,8 @@ nfs4_open_delegation(struct svc_rqst *rqstp,
> > struct nfsd4_open *open,
> >                 dp->dl_ctime =3D stat.ctime;
> >                 dp->dl_mtime =3D stat.mtime;
> >                 spin_lock(&f->f_lock);
> > -               f->f_mode |=3D FMODE_NOCMTIME;
> > +               if (deleg_ts)
> > +                       f->f_mode |=3D FMODE_NOCMTIME;
> >                 spin_unlock(&f->f_lock);
> >                 trace_nfsd_deleg_write(&dp->dl_stid.sc_stateid);
> >         } else {
> >
> >
>
> That patch does look correct to me -- nice catch. Have you validated
> that it fixes 215 and 407?

Yes, it does fix 215 and 407 for me.

>
> Thanks,
> Jeff
> --
> Jeff Layton <jlayton@kernel.org>


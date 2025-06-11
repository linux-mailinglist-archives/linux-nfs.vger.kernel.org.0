Return-Path: <linux-nfs+bounces-12339-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AAB6DAD628D
	for <lists+linux-nfs@lfdr.de>; Thu, 12 Jun 2025 00:39:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3ACAB1E09B4
	for <lists+linux-nfs@lfdr.de>; Wed, 11 Jun 2025 22:39:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF4C518D65E;
	Wed, 11 Jun 2025 22:39:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MJ5FZqNg"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD108DF49
	for <linux-nfs@vger.kernel.org>; Wed, 11 Jun 2025 22:39:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749681584; cv=none; b=fHaZzhI8EAeBipMmedrtGx0su2p9v9Be55hGLUJLZHza6vaw/ZAwAuuOSXHQ3If9vkOESyb+6wFqgjHvuXLzO3DhObM+JHP0C/y+MO6gEk8Am96qT4xXOii9csC0WtL0Zl2Ezk731GO9n8ldOHvOSiudLprhynRJDFaBiQ5B8yA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749681584; c=relaxed/simple;
	bh=9CNAIkfrE18MYeUQ32ncwf+tCcjBepROY4+FG74JdlY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KWROSINNvGXjKWm8jsKqIJkZeBa+HyVLva04hK4RaCMkq9A4vxon7MPlC8Kmuqv2yihYCPMr6LBc2b9yX7Hz+/PG5lNRousrC0OVkK8gEgAQvOXt0+68FUSHZtcbnaoCLsdgZfz3u8ChQ5mY7xxINbUCxHyfVaVMqqx2UWgSo0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MJ5FZqNg; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-ad56cbc7b07so52908366b.0
        for <linux-nfs@vger.kernel.org>; Wed, 11 Jun 2025 15:39:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749681581; x=1750286381; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RUCPmjPRLI4Pb3Q5qhyrTHUUHuShfXNsWVvAtCiOcCs=;
        b=MJ5FZqNgE5or44DS4E2pLCfLStnfMBKi2FchIDL70k/fDLranFcNeSqOLAc7EA6L22
         hABaxjVuicq+m7I0qG5HvTBD2wjxSE4unCpKlvU2HkGDh/pMyLR65RwlYfSqbXHOmcM/
         AKEwb0wdop9aEto9Xx+hYqb1NsIK4cYRn4X+9vmGur44CHE4kcccjZmabk6o0yWAv9eQ
         07qkzOo0guW10DlceF7h7G9OohejVf8IjV3xXX1NHH9obQ1ZXi8jMmseYFNqqXVMLGdN
         O3juLMRlOd0SeBrwFw0ZXz9Cy3EYHw7V24yC+USjUXPcNQHVDyNrHUdt8m4hpmg1S3/Z
         +wpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749681581; x=1750286381;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RUCPmjPRLI4Pb3Q5qhyrTHUUHuShfXNsWVvAtCiOcCs=;
        b=wKHnTtBJsvGDHBD39N5k03iQ3sa9CNs+dBrOvMl+Daw2quAGJffxueeBTRv6Rc9p2Q
         Qu8Bcure/KjJnHfZFcCRR0kHVSMeKua1gfKg+ZHic8gObGegzDDeLURLEDm0vmza516m
         Oqcc8RgeaURNoVkPEJY+BdNb12KlneNbAFFdKY1fga1IQORwtyPEfwrf/EEvv3DZ58nY
         aH4eoLxsM7JUFpCMlR1L12CpUkhog4g12Vy+6zRlp6xDh381GAe4mq3NjhwE25HBIsFJ
         OtcZq1lm4cc+t6thgkTPMqd/9wn8IVJX09oLdKxPuPsBqdBhtJaE3jsAHA1jUkImeOLN
         uhLw==
X-Forwarded-Encrypted: i=1; AJvYcCUxG9AxemHRBPOuOabstOVieBAz8qpcujAsQR9YYNKYrkamVsDd/yjoNgTzgZD4EJWkjiXupn4RRm4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyBcENxV/5NLnfWV4mzzYOxgBJDEvZOCV71KjT3oGy82DJNqlvr
	9OJWXHLXTmoMx9uLY5+mhL9kGyOQrL7tuKSka3jG6vXNkSd6OqO8pT/uOnEqsvRC+50ZNwNqQ2z
	jmVBez8/4dRvqdH+Ga2GGUcfxKstnlg==
X-Gm-Gg: ASbGnct4sUaQXioM46/Qvzti0fCdgZI4KnzUXvvO7AcEHJ2sDSjZeTWpg/sAIqZjfM1
	CUjhVkSy5Lw2XTvVMYkM1BbXKqIlXCWpNWxwcmf/yj8hkN4EHxaHxIJ3UyR4eTQuOa6TeE5uccD
	OuBrmVaHZcY2S/x4TA37T8ddb5pz6Oxhf29aiZbkiRt+6Fof8qusau6gEnHKVPCb0hKArL49ArV
	sw=
X-Google-Smtp-Source: AGHT+IHEF/bFrP4Ti3UGbZ/lC5Jmw+ElaAxVEuO7hCY4Am8Zhu9v2dOeQvBfrdJ+S2pvZQyCV6QWg+RYXKNgcaUkTeU=
X-Received: by 2002:a17:907:3d8d:b0:aca:95e7:9977 with SMTP id
 a640c23a62f3a-adea93e073fmr83680266b.28.1749681580585; Wed, 11 Jun 2025
 15:39:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAM5tNy7kfqToA8p4-=LOnhvZuk36vocy32U6kgT+561uOWR_iQ@mail.gmail.com>
 <CADaq8jd1gH1-f3Dqg+mAV2RTEwqVS-C21Be4QJT24+bNTuycYA@mail.gmail.com> <CAM5tNy5MUCAXs_4zWy33xqOJSMk1hW5006OpLoD32KWLbOfNLQ@mail.gmail.com>
In-Reply-To: <CAM5tNy5MUCAXs_4zWy33xqOJSMk1hW5006OpLoD32KWLbOfNLQ@mail.gmail.com>
From: Rick Macklem <rick.macklem@gmail.com>
Date: Wed, 11 Jun 2025 15:39:27 -0700
X-Gm-Features: AX0GCFum60p_EHa0OwtkFLPCtmmKj3OW85DkAV24jy8yHXK55i1ZkkzfpKVzahc
Message-ID: <CAM5tNy4E8r9BXMqJ_srvD9aL=xog5w08_kCTWEDaXX59RscShw@mail.gmail.com>
Subject: Re: [nfsv4] simple NFSv4.1/4.2 test of remove while holding a delegation
To: David Noveck <davenoveck@gmail.com>
Cc: NFSv4 <nfsv4@ietf.org>, Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 11, 2025 at 1:57=E2=80=AFPM Rick Macklem <rick.macklem@gmail.co=
m> wrote:
>
> On Wed, Jun 11, 2025 at 9:28=E2=80=AFAM David Noveck <davenoveck@gmail.co=
m> wrote:
> >
> >
> >
> > On Mon, Jun 9, 2025, 7:35=E2=80=AFPM Rick Macklem <rick.macklem@gmail.c=
om> wrote:
> >>
> >> Hi,
> >>
> >> I hope you don't mind a cross-post, but I thought both groups
> >> might find this interesting...
> >
> >
> > I find it interesting, but I can't speak.for either group.
> >>
> >>
> >> I have been creating a compound RPC that does REMOVE and
> >> then tries to determine if the file object has been removed and
> >> I was surprised to see quite different results from the Linux knfsd
> >> and Solaris 11.4 NFSv4.1/4.2 servers. I think both these servers
> >> provide FH4_PERSISTENT file handles, although I suppose I
> >> should check that?
> >>
> >> First, the test OPEN/CREATEs a regular file called "foo" (only one
> >> hard link) and acquires a write delegation for it.
> >> Then a compound does the following:
> >> ...
> >> REMOVE foo
> >> PUTFH fh for foo
> >> GETATTR
> >>
> >> For the Solaris 11.4 server, the server CB_RECALLs the
> >> delegation and then replies NFS4ERR_STALE for the PUTFH above.
> >> (The FreeBSD server currently does the same.)
> >>
> >> For a fairly recent Linux (6.12) knfsd, the above replies NFS_OK
> >> with nlinks =3D=3D 0 in the GETATTR reply.
> >>
> >> Hmm. So I've looked in RFC8881 (I'm terrible at reading it so I
> >> probably missed something) and I cannot find anything that states
> >> either of the above behaviours is incorrect.
> >> (NFS4ERR_STALE is listed as an error code for PUTFH, but the
> >> description of PUTFH only says that it sets the CFH to the fh arg.
> >> It does not say anything w.r.t. the fh arg. needing to be for a file
> >> that still exists.) Neither of these servers sets
> >> OPEN4_RESULT_PRESERVE_UNLINKED in the OPEN reply.
> >>
> >> So, it looks like "file object no longer exists" is indicated either
> >> by a NFS4ERR_STALE reply to either PUTFH or GETATTR
> >> OR
> >> by a successful reply, but with nlinks =3D=3D 0 for the GETATTR reply.
> >>
> >> To be honest, I kinda like the Linux knfsd version, but I am wondering
> >> if others think that both of these replies is correct?
> >
> >
> > I think they are both correct.  It seems to me that an attempt to choos=
e one of these as preferred and deprecating the other should be rejected si=
nce it unjustiably imposes a particular design choice on the server.
> >>
> >>
> >> Also, is the CB_RECALL needed when the delegation is held by
> >> the same client as the one doing the REMOVE?
> >
> >
> > I think so.
> From a practical point of view, I am not convinced it is needed.
> The server can determine if the REMOVE actually deleted the
> file and, if it did, can throw away any delegation record(s) for the
> file object.
> The client knows it has a delegation and can either DELEGRETURN
> it or throw it away if it knows the file object has been deleted and the
> associated file handle is no longer valid (it receives a NFS4ERR_STALE
> from the server for it).
>
> Also, wearing my pragmatic practitioner's hat, since the Linux knfsd
> does not do a CB_RECALL now and has shipped this way to who
> knows how many users, declaring that it must be CB_RECALL'd
> does not seem useful?
>
Btw, I did some quick tests with 3 NFSv4.1/4.2 clients. Linux 6.12,
Solaris 11.4 and FreeBSD recent releases.

For a REMOVE when the client holds a write delegation for the file object:
- All 3 DELERETURN before REMOVE.

For a RENAME when the client holds write delegations for both src and
dst file object:
- Solaris and FreeBSD DELEGRETURN both delegations before RENAME.
- Linux DELEGRETURNs the dst delegation befor RENAME.
  (I believe Linux is correct in doing so, since the FreeBSD server reports
   a fh_expire_type of FH4_PERSISTENT, which I understand means
   "will still be valid after a RENAME".)

As such, none of these extant NFSv4.1/4.2 clients will need a server
to CB_RECALL any delegation for REMOVE or RENAME.

It is the experimental NFSv4.1/4.2 client I am playing with that does
not do DELEGRETURNs before REMOVE or RENAME, which is why
I am now trying to determine allowable/correct behaviour.

Thanks everyone for your comments, rick

> rick
>
> >
> >> (I don't think it is, but there is a discussion in 18.25.4 which says
> >> "When the determination above cannot be made definitively because
> >> delegations are being held, they MUST be recalled.." but everything
> >> above that is a may/MAY, so it is not obvious to me if a server really
> >> needs to case?)
> >
> >
> > This should be more clear.  Will be looking at a possible change in the=
 next rfc5661bis draft.
> >>
> >>
> >> Any comments? Thanks, rick
> >> ps: I am amazed when I learn these things about NFSv4.n after all
> >>       these years.
> >>
> >> _______________________________________________
> >> nfsv4 mailing list -- nfsv4@ietf.org
> >> To unsubscribe send an email to nfsv4-leave@ietf.org


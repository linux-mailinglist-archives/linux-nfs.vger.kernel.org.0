Return-Path: <linux-nfs+bounces-13564-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 07E5EB21553
	for <lists+linux-nfs@lfdr.de>; Mon, 11 Aug 2025 21:32:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BC07B7A54DC
	for <lists+linux-nfs@lfdr.de>; Mon, 11 Aug 2025 19:30:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96296311C3E;
	Mon, 11 Aug 2025 19:32:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=umich.edu header.i=@umich.edu header.b="m3fs3Y4L"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CA964C7F
	for <linux-nfs@vger.kernel.org>; Mon, 11 Aug 2025 19:32:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754940743; cv=none; b=sMruXCUnzjUG2clGqHPp3nDuRjvaWFk3EAeF/w7Te+EIR5kTmaLcX7d9QAoBb/lyLT6Ezozf3xbkw/NFJYNUD6fol2zPx+Aoj16hY0fbVjbIkSszm5me9dTt/3Us/DNoKNeb5a5ekYDyvXVoPglbhaY+q6F5+ptvnKNqzJcMug4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754940743; c=relaxed/simple;
	bh=wOARDU5PqhHBj8fW4KsCtwanmPVZYIHpeQ79p3bmw9M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ac2NRCaxyH01hOhxo+/aqUyiD9ibufLFECUfaJwm3lLikpAszXzGiwex6+1BBmRa293t1WpVXhBvgBnHfHjNiozkHLbm3K1yx6gSi6LObvKGuEkcwhTn16Mko5r8zfpxmULEW/lHlTU118fwLqjdD+yemuor6UCdSqmszEY+BoA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=umich.edu; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=umich.edu header.i=@umich.edu header.b=m3fs3Y4L; arc=none smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=umich.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-33275f235ffso43598481fa.0
        for <linux-nfs@vger.kernel.org>; Mon, 11 Aug 2025 12:32:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umich.edu; s=google-2016-06-03; t=1754940739; x=1755545539; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uiAT41pwV5TgmWszpxZAVT0cttU8TJ2U05OAnuqTQ6E=;
        b=m3fs3Y4LOQvb9kqXONezZDaYJpNbjz9IWmbuj9UlLf3owNn+blh6hMe4oZbyeVN1Kx
         5cVYNjGlHuTlk7Ho9BOgydtop20rAUJvkiCLEYDuGIM09DE+VxV8R9fMz7hcd3FvcqON
         7Bdzjr47qswf6KIlTaaRGx5sHWaihW/mioPufaNxS6A2sZ41F/TAwSQm4drsF9zpndW2
         lK+A6WUyWw+7M8Mj/bYsulupC3yrhLqhYeX0FEUwMFfxItd+cuLq99LCAS340UxC9b61
         YjChuYYFUnibIiP5yHhOxKqPU3kpg7R3y5fLZB/Zajns6idir/pNBnfYIxLTQDQgmVgF
         EpYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754940740; x=1755545540;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uiAT41pwV5TgmWszpxZAVT0cttU8TJ2U05OAnuqTQ6E=;
        b=XhjLxIANncEV6RLnRpsSQDdNlPuos88Etkn2GJ7uIw5fVwjD+rl1/sYcwOkfczzv+O
         NGjhWG75aAHA1uSpfSGL9JuKDn0cAzchD5A8ftS2epXME2Er3svOma5bhZyWSw7OsnwF
         HC6AqNlj7D1aY2KGvWH9ZPeNsN0ncBVPjvpx3mupzkwnUQTuNfG+KK8zctEXhQqjWAGu
         fp1bE0ybPzOkjUfvTCPaLMNtjh8aMPHc7dj1xLp46Ksymdr3N2I6JWY5ZIevxyz2jI2v
         NRbi261BdeuljbDWyczVZMlEkFUESAXGf0ihpJXb2HzgStoqnAhYxxAknt3wDUkbvJgQ
         mCyw==
X-Forwarded-Encrypted: i=1; AJvYcCVUca9baJCaaE+Y3DGC7wlJqSMvevm4KpqcTGSNtiugAGpqO3mTuM8gdADYljOnhPKze1MzQL11D4U=@vger.kernel.org
X-Gm-Message-State: AOJu0YwK+UOJRNsI1Q9WqA9z0ixX6HIycSJybf8wI5f/LsGIvTbHYZoh
	VxQIJiJN9BxN7NMV8CKKRjq3ytEDu+aZc4w4ByYUDKGsu/321fzuKXbjYnh69yIQw/AfJHjoRYM
	yqbsYgyxdcZSDbl2urgOXocBdcAAsj3Q=
X-Gm-Gg: ASbGnctjAOhDr2Zs5YMTtWaIDGEYGIaURWbnk+lEem2q0mbaP361bRdV0PM3Mg35ZuJ
	b7WDBIg3eqvPrSoA7AeIybcwgxQ0QqhnK2KRMd0jYrE4yaZQrc+f73Ohl7+rCPgPiosyYMJsI1L
	RxwJMNnyrtEHPC3S5JXFYGIwI8uEW/jlAQp+vnmXtfX0MxMfYocintnVwu0FuGnm4sL3rfaQTDx
	xnvinx1VAvkmkKEOfqvY7+14puGXTgqRKTotn7EJg==
X-Google-Smtp-Source: AGHT+IEWpQdaVmsjKwib8RA0TFfdrdREwx98zute86k3R2A1Yr0L3hcPl91LiBO4dXyM/vdapOq5xD206IOvzBZxuEU=
X-Received: by 2002:a2e:a54a:0:b0:32a:6cab:fd75 with SMTP id
 38308e7fff4ca-333d7b6504amr1730761fa.11.1754940739274; Mon, 11 Aug 2025
 12:32:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250811181840.99269-1-okorniev@redhat.com> <20250811181840.99269-2-okorniev@redhat.com>
 <c7bf2dca30c1ac3c947da3fa9ee537cf3b57536a.camel@kernel.org>
In-Reply-To: <c7bf2dca30c1ac3c947da3fa9ee537cf3b57536a.camel@kernel.org>
From: Olga Kornievskaia <aglo@umich.edu>
Date: Mon, 11 Aug 2025 15:32:07 -0400
X-Gm-Features: Ac12FXwApiHMhE_IzsDMTw48oeUgakHUgqObPN_c_zQBnsxVTRxf53ipoX1tPTI
Message-ID: <CAN-5tyFbT8zR7mXL1bghSObya+nkynmNKBvJocteE9QnpweVUQ@mail.gmail.com>
Subject: Re: [RFC PATCH 1/2] nfsd: nfserr_jukebox in nlm_fopen should lead to
 a retry
To: Jeff Layton <jlayton@kernel.org>
Cc: Olga Kornievskaia <okorniev@redhat.com>, chuck.lever@oracle.com, linux-nfs@vger.kernel.org, 
	neil@brown.name, Dai.Ngo@oracle.com, tom@talpey.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 11, 2025 at 3:10=E2=80=AFPM Jeff Layton <jlayton@kernel.org> wr=
ote:
>
> On Mon, 2025-08-11 at 14:18 -0400, Olga Kornievskaia wrote:
> > When v3 NLM request finds a conflicting delegation, it triggers
> > a delegation recall and nfsd_open fails with EAGAIN. nfsd_open
> > then translates EAGAIN into nfserr_jukebox. In nlm_fopen, instead
> > of returning nlm_failed for when there is a conflicting delegation,
> > drop this NLM request so that the client retries. Once delegation
> > is recalled and if a local lock is claimed, a retry would lead to
> > nfsd returning a nlm_lck_blocked error or a successful nlm lock.
> >
> > Signed-off-by: Olga Kornievskaia <okorniev@redhat.com>
> > ---
> >  fs/nfsd/lockd.c | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/fs/nfsd/lockd.c b/fs/nfsd/lockd.c
> > index edc9f75dc75c..ad3e461f30c0 100644
> > --- a/fs/nfsd/lockd.c
> > +++ b/fs/nfsd/lockd.c
> > @@ -57,6 +57,7 @@ nlm_fopen(struct svc_rqst *rqstp, struct nfs_fh *f, s=
truct file **filp,
> >       switch (nfserr) {
> >       case nfs_ok:
> >               return 0;
> > +     case nfserr_jukebox:
> >       case nfserr_dropit:
> >               return nlm_drop_reply;
> >       case nfserr_stale:
>
> This works by triggering a RPC retransmission. That could time out on
> soft mounts if it takes a while to return a delegation. Looking at the
> NLM spec here:
>
>     https://pubs.opengroup.org/onlinepubs/9629799/chap14.htm
>
> What about returning NLM4_DENIED instead? The description there is:
>
> NLM4_DENIED
>     The call failed. For attempts to set a lock, this status implies
> that if the client retries the call later, it may succeed.
>
> Presumably the client should redrive this effectively indefinitely that
> way?

I have previously tried "denied" but that lead to client failing with
no lock just like from nlm_failed instead of retrying. I think only
blocked (or block_grace) leads to a retry.


> --
> Jeff Layton <jlayton@kernel.org>
>


Return-Path: <linux-nfs+bounces-5039-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EF8F793B73B
	for <lists+linux-nfs@lfdr.de>; Wed, 24 Jul 2024 21:13:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A5B062856F2
	for <lists+linux-nfs@lfdr.de>; Wed, 24 Jul 2024 19:13:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16B3F2AE6C;
	Wed, 24 Jul 2024 19:12:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=umich.edu header.i=@umich.edu header.b="GWihHtVx"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33CCD161915
	for <linux-nfs@vger.kernel.org>; Wed, 24 Jul 2024 19:12:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721848378; cv=none; b=FISTtEkSfU/0Q7dVOA6kqL30xCYypviDvqLyHtH069GlskJbdjhk07jklZUXRewssqXnIyYwdZ4LEf4d3YADvUZvhFnHBxtqsR5htT8aTnmrykvgmK69MX5oldQZ21ZsakzjCRxzdv/LY6PNWT0TI5dJYDEwwyxFIkdUDetV1Ic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721848378; c=relaxed/simple;
	bh=NyxKuV6Nez+7yAWYYzstAc3cOhsdC05ScJPLiIQblmY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XVGO/5LLNMK/j7x9rr5O4SCmC3TV+VBzJPgbD7B8DQPDubr543CHW+FaU1GNi1Mk4YJER09hqtG/2nErTddUEapiNq3QMIYApA8rZ+YHWRkz+aBKdDrz7U65CMg75Eel0xDBtBL5JWTLSik8ZgnGLxm+5BFYzSMXy516iC0dUmM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=umich.edu; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=umich.edu header.i=@umich.edu header.b=GWihHtVx; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=umich.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-2ef302f5dbbso170091fa.2
        for <linux-nfs@vger.kernel.org>; Wed, 24 Jul 2024 12:12:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umich.edu; s=google-2016-06-03; t=1721848374; x=1722453174; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Vw9tFAOHkLcpsVIMjyeBi0KalgOPimavlcd8gz8qJ3A=;
        b=GWihHtVxVtcS6GLPnGQmvYqumqXUhG+HJq/BNiNeIVX2m9Ct/Bg2OhEci2c1PpyAHW
         NO8wPv8XAqhfbaCkpPGhLsfF10ylemyDc79H51tHiqiPFN8XDsQLq3fGjqZJ96MJXCfO
         5Zgph+fC9ipqKNPavLJtA0SVH/pFS3AfO2Zf7AP4p4sOmscUgTT2T4Bz77J6IaHBuU4H
         IglEXkDwXWTlI05xMPlI/fVFdbIhJVBpBAKgSN0A4FXNDdJ8oSYpdK79E0FmjdkikDzm
         EugPlVobejNWYPBk0Za0JaKj2KUcfnmD1bM+m2AR/UEpEzYOwToyQxtdPzJs2wY/5A86
         vqXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721848374; x=1722453174;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Vw9tFAOHkLcpsVIMjyeBi0KalgOPimavlcd8gz8qJ3A=;
        b=JU1hALMNz5bxghq9Dy4Xrl5J6Kpw1Y1Hjvm/8Y1sX81/uPGOIlpwXbxnJ3zHZLJTiJ
         gVU6NI7lxf1mhzmA3lJ9kNdK6b08lyxYxw/G38eWrTAbBdcYt6l4ikbuQUCSXabP3hIu
         4PRrX6Cz6/KP+l3HxliqL7flDjUXEuZzHqiS3DQBy/qHhMT58IEISOPfCKZpPm4Uwyst
         NU+3OftM/jGCYHABIiNAsyL4yrbZvpDoGiP70P6q1XMT+NlmgSV9E1GtVA0juOzMwMIG
         SVmdqD3lSzQtHsqJ9lCBEWIrG9L2WIUhOlrCNacveEZ7yupjD4q9aXA6Kj4nWZV7ScVt
         EIIg==
X-Forwarded-Encrypted: i=1; AJvYcCWik4F+ZKQGNimNjk1qleE3G2ED4YO556Si9Ykf//3B4Sk9wr5t23rGZzaQJ8iyvrx5Nkw15Zf8fApwyxUWgWuYt7J3DxdKW6eK
X-Gm-Message-State: AOJu0Yzx97sOwHpF/WqJYD3v+YIDJcEm0/Y2iAHu+fcLlNDGVCyxOJFe
	C7yOl75SCVvBoXt6ykcYs41axqtMGbGNmwkE8Gotoxv1RHCY5EZS/+fWZ4HvgNJpxzwgthhHF9+
	SgDxds+ZQZH5xKO6EKVyqBEgmg3wxbg==
X-Google-Smtp-Source: AGHT+IHNpE70m3Yli81y9iDNSz81asMlic29NlvjX6ceb8NdOPKYl2d/CzQQP5IXWa8Gdz59geI6F16B/eLkZRr5CrA=
X-Received: by 2002:a2e:bc1a:0:b0:2ee:d55c:255f with SMTP id
 38308e7fff4ca-2f03c7ce3d8mr590221fa.7.1721848373962; Wed, 24 Jul 2024
 12:12:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240724170138.1942307-1-sagi@grimberg.me> <ZqE0kTRdRAibsjm7@tissot.1015granger.net>
In-Reply-To: <ZqE0kTRdRAibsjm7@tissot.1015granger.net>
From: Olga Kornievskaia <aglo@umich.edu>
Date: Wed, 24 Jul 2024 15:12:42 -0400
Message-ID: <CAN-5tyGAm3LYqTaJvu=w32UEdRPhOCAMtdhnK0e0KacYzTw7Uw@mail.gmail.com>
Subject: Re: [PATCH rfc 1/2] nfsd: don't assume copy notify when preprocessing
 the stateid
To: Chuck Lever <chuck.lever@oracle.com>
Cc: Sagi Grimberg <sagi@grimberg.me>, Dai Ngo <dai.ngo@oracle.com>, 
	Jeff Layton <jlayton@kernel.org>, linux-nfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 24, 2024 at 1:06=E2=80=AFPM Chuck Lever <chuck.lever@oracle.com=
> wrote:
>
> Adding Olga for her review and comments.
>
> On Wed, Jul 24, 2024 at 10:01:37AM -0700, Sagi Grimberg wrote:
> > Move the stateid handling to nfsd4_copy_notify, if nfs4_preprocess_stat=
eid_op
> > did not produce an output stateid, error out.
> >
> > Copy notify specifically does not permit the use of special stateids,
> > so enforce that outside generic stateid pre-processing.

I dont see how this patch is accomplishing this. As far as I can tell
(just by looking at the code without actually testing it) instead it
does exactly the opposite.

> >
> > Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
> > ---
> >  fs/nfsd/nfs4proc.c  | 4 +++-
> >  fs/nfsd/nfs4state.c | 6 +-----
> >  2 files changed, 4 insertions(+), 6 deletions(-)
> >
> > diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
> > index 46bd20fe5c0f..7b70309ad8fb 100644
> > --- a/fs/nfsd/nfs4proc.c
> > +++ b/fs/nfsd/nfs4proc.c
> > @@ -1942,7 +1942,7 @@ nfsd4_copy_notify(struct svc_rqst *rqstp, struct =
nfsd4_compound_state *cstate,
> >       struct nfsd4_copy_notify *cn =3D &u->copy_notify;
> >       __be32 status;
> >       struct nfsd_net *nn =3D net_generic(SVC_NET(rqstp), nfsd_net_id);
> > -     struct nfs4_stid *stid;
> > +     struct nfs4_stid *stid =3D NULL;
> >       struct nfs4_cpntf_state *cps;
> >       struct nfs4_client *clp =3D cstate->clp;
> >
> > @@ -1951,6 +1951,8 @@ nfsd4_copy_notify(struct svc_rqst *rqstp, struct =
nfsd4_compound_state *cstate,
> >                                       &stid);
> >       if (status)
> >               return status;
> > +     if (!stid)
> > +             return nfserr_bad_stateid;
> >
> >       cn->cpn_lease_time.tv_sec =3D nn->nfsd4_lease;
> >       cn->cpn_lease_time.tv_nsec =3D 0;
> > diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
> > index 69d576b19eb6..dc61a8adfcd4 100644
> > --- a/fs/nfsd/nfs4state.c
> > +++ b/fs/nfsd/nfs4state.c
> > @@ -7020,11 +7020,7 @@ nfs4_preprocess_stateid_op(struct svc_rqst *rqst=
p,
> >               *nfp =3D NULL;
> >
> >       if (ZERO_STATEID(stateid) || ONE_STATEID(stateid)) {
> > -             if (cstid)
> > -                     status =3D nfserr_bad_stateid;
> > -             else
> > -                     status =3D check_special_stateids(net, fhp, state=
id,
> > -                                                                     f=
lags);

This code was put in by Bruce in commit ("nfsd: fix crash on
COPY_NOTIFY with special stateid"). Its intentions were to make sure
that IF COPY_NOTFY was sent with a special state it, then the server
would produce an error (in this case bad_stateid). Only from
copy_notify do we call nfs4_preproces_stateid_op() with a non-null
cstid. This above logic is needed here as far as I can tell.

> > +             status =3D check_special_stateids(net, fhp, stateid, flag=
s);
> >               goto done;
> >       }
> >
> > --
> > 2.43.0
> >
> >
>
> --
> Chuck Lever


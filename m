Return-Path: <linux-nfs+bounces-5073-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D5B7A93D4C5
	for <lists+linux-nfs@lfdr.de>; Fri, 26 Jul 2024 16:08:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 04FF51C23206
	for <lists+linux-nfs@lfdr.de>; Fri, 26 Jul 2024 14:08:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4262A1860;
	Fri, 26 Jul 2024 14:07:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=umich.edu header.i=@umich.edu header.b="iYkUoxug"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D12F946BF
	for <linux-nfs@vger.kernel.org>; Fri, 26 Jul 2024 14:07:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722002879; cv=none; b=QyinGOEE5wCXcViEhrduX5/weQlm1pOQkxY023Jii9/IyPrjp7oauq3j+3lMyGVWqnkMdK2rbX5zL4fOCZg9QUJfBoblCVKp5RA4q/d2aVbpUrF+UwK8PuDqrDnS1U2gceiYO4cAdq4lvexVge2KcjFt84Sp4U2LBsfui3bZYdk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722002879; c=relaxed/simple;
	bh=4+6OK0xJXvChmNtbSJBWSBb7ENdASWUGXJtp3eDZLxk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cn3/P/YsPGupfgSN0ec/JMEdI/6SkksFuAy3iyEwJYtt3/SjBpRYWvSGA9Y6WEdm5FyEbX0PsmrTvuO+J3Bo3dxsejXcVnVguZ8QOxTjeCYaJNpB/Y2RCBwsIfP4YkieA+AneiAGA6jKOaYMnYC7qIU3SIe9S0BM6GgOdr5NLkw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=umich.edu; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=umich.edu header.i=@umich.edu header.b=iYkUoxug; arc=none smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=umich.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-2ef260c4467so2354791fa.0
        for <linux-nfs@vger.kernel.org>; Fri, 26 Jul 2024 07:07:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umich.edu; s=google-2016-06-03; t=1722002875; x=1722607675; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6VRDx+JDLl6as5NghRbhrYBOlha+xkDJBX07gfto8Sc=;
        b=iYkUoxug8VKo+Jmsdob8SbdNb5AvXAuLu2ljP1Df4yAsYThVAF7XcFJY079V+2xDSF
         SOCJNVgDrSr6Ugib1hmHVstAvwNFaZrRkYOS/0cujO/FMAWfEZKP9ZIdUcDmyGI1c5Vo
         yimjx0qFiX6u0SYjGXmrI0mL6vNEE0e05XpB6UiZ5YWFthrztIFtOYX4xAD44t70Nmo0
         rDZcu/fu4hZP9sd4TdKMPgdlRt8gcXw9d8hunDt7rJBkXVTNSQzNl3zc6kJuCd74uS4q
         92b+AkeER+/2MIqOn68cTTIOnrA6QEyBpjYK+HFllGGuCexXPipmB7WHYjtFeR2pMUGo
         UcXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722002875; x=1722607675;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6VRDx+JDLl6as5NghRbhrYBOlha+xkDJBX07gfto8Sc=;
        b=D4i7uhyUt7GIHdMq7Fzl50Odp3m71AQRrNyWAO/8QgaRRajisqyb4Y5RhvDbcL8tZC
         897ZyCdXnVp4/RyZbe8DYGlVepmL52AYAFLuoQ5PK336dwo1lMMz4rTmNSp/3198Ad0P
         MYvzehD9CDTRfF6FNo9xbBEhY0GqDBaVvjkSpiMkYQdJZWW146yvwO4OnaC7OvbjTxdE
         HoYpyC2DJCr6uRxKi8ChnMSQKmGUXxQpSQa9yNOcH9fr2BfgMhBu6+Rh9KWpoxW38uf9
         dz9sN3wdfQLgK1+lRKlAllmqh+dY5OdrFYV+rksSEh9IBGT20ApYv3oYJu/KmMs+H0zh
         nrCQ==
X-Forwarded-Encrypted: i=1; AJvYcCW0Gw8i7/2zXDLOR3KcL86wQO4HpmcqxgC+7GByqQZvceThZU/KTjhnqEjdGDaa3erKfeaQJBIO+s8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyV90rfnQiaij0fEIC0r3+EIQI7FFBHBd8+IKchp/bi3UHu81QH
	YBVwXMf4hA9sFWg1u5Ukvoo06nn32MMcj74pHsCRaWKL7uPR5A5miz1X6+z2Kzgj6TAQeyri7jV
	zYiANs/vas54dyOwUuixjPIKUvsI=
X-Google-Smtp-Source: AGHT+IGUQqmNdnwkm2cBGsiI0OvVvTmjd8W7JjexnQkr2NhD/FoksBURBH8uaeB7WEwVCgoMuKHOhv6UFdjlAeDMc54=
X-Received: by 2002:a2e:a7d6:0:b0:2ee:d55c:603 with SMTP id
 38308e7fff4ca-2f03c7c94fcmr28580571fa.7.1722002874616; Fri, 26 Jul 2024
 07:07:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240724170138.1942307-1-sagi@grimberg.me> <ZqE0kTRdRAibsjm7@tissot.1015granger.net>
 <CAN-5tyGAm3LYqTaJvu=w32UEdRPhOCAMtdhnK0e0KacYzTw7Uw@mail.gmail.com>
 <cf9e9f1c-6e54-4982-a82e-9208a3979989@grimberg.me> <CAN-5tyHj2JNWxzjkKQCK=+AMic25E9vXLVH8iFvc1ur4C+AuEg@mail.gmail.com>
 <ZqOo2UJHfOF3UbDj@tissot.1015granger.net>
In-Reply-To: <ZqOo2UJHfOF3UbDj@tissot.1015granger.net>
From: Olga Kornievskaia <aglo@umich.edu>
Date: Fri, 26 Jul 2024 10:07:42 -0400
Message-ID: <CAN-5tyE_fFeMuoH5XU+ghLxjfFskN5phCb9-b10VVQMk-rq7cw@mail.gmail.com>
Subject: Re: [PATCH rfc 1/2] nfsd: don't assume copy notify when preprocessing
 the stateid
To: Chuck Lever <chuck.lever@oracle.com>
Cc: Sagi Grimberg <sagi@grimberg.me>, Dai Ngo <dai.ngo@oracle.com>, 
	Jeff Layton <jlayton@kernel.org>, linux-nfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 26, 2024 at 9:47=E2=80=AFAM Chuck Lever <chuck.lever@oracle.com=
> wrote:
>
> On Thu, Jul 25, 2024 at 09:51:11AM -0400, Olga Kornievskaia wrote:
> > On Wed, Jul 24, 2024 at 5:43=E2=80=AFPM Sagi Grimberg <sagi@grimberg.me=
> wrote:
> > >
> > >
> > >
> > >
> > > On 24/07/2024 22:12, Olga Kornievskaia wrote:
> > > > On Wed, Jul 24, 2024 at 1:06=E2=80=AFPM Chuck Lever <chuck.lever@or=
acle.com> wrote:
> > > >> Adding Olga for her review and comments.
> > > >>
> > > >> On Wed, Jul 24, 2024 at 10:01:37AM -0700, Sagi Grimberg wrote:
> > > >>> Move the stateid handling to nfsd4_copy_notify, if nfs4_preproces=
s_stateid_op
> > > >>> did not produce an output stateid, error out.
> > > >>>
> > > >>> Copy notify specifically does not permit the use of special state=
ids,
> > > >>> so enforce that outside generic stateid pre-processing.
> > > > I dont see how this patch is accomplishing this. As far as I can te=
ll
> > > > (just by looking at the code without actually testing it) instead i=
t
> > > > does exactly the opposite.
> > >
> > > I haven't tested this either, does pynfs have a test for it?
> > >
> > > >
> > > >>> Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
> > > >>> ---
> > > >>>   fs/nfsd/nfs4proc.c  | 4 +++-
> > > >>>   fs/nfsd/nfs4state.c | 6 +-----
> > > >>>   2 files changed, 4 insertions(+), 6 deletions(-)
> > > >>>
> > > >>> diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
> > > >>> index 46bd20fe5c0f..7b70309ad8fb 100644
> > > >>> --- a/fs/nfsd/nfs4proc.c
> > > >>> +++ b/fs/nfsd/nfs4proc.c
> > > >>> @@ -1942,7 +1942,7 @@ nfsd4_copy_notify(struct svc_rqst *rqstp, s=
truct nfsd4_compound_state *cstate,
> > > >>>        struct nfsd4_copy_notify *cn =3D &u->copy_notify;
> > > >>>        __be32 status;
> > > >>>        struct nfsd_net *nn =3D net_generic(SVC_NET(rqstp), nfsd_n=
et_id);
> > > >>> -     struct nfs4_stid *stid;
> > > >>> +     struct nfs4_stid *stid =3D NULL;
> > > >>>        struct nfs4_cpntf_state *cps;
> > > >>>        struct nfs4_client *clp =3D cstate->clp;
> > > >>>
> > > >>> @@ -1951,6 +1951,8 @@ nfsd4_copy_notify(struct svc_rqst *rqstp, s=
truct nfsd4_compound_state *cstate,
> > > >>>                                        &stid);
> > > >>>        if (status)
> > > >>>                return status;
> > > >>> +     if (!stid)
> > > >>> +             return nfserr_bad_stateid;
> > > >>>
> > > >>>        cn->cpn_lease_time.tv_sec =3D nn->nfsd4_lease;
> > > >>>        cn->cpn_lease_time.tv_nsec =3D 0;
> > > >>> diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
> > > >>> index 69d576b19eb6..dc61a8adfcd4 100644
> > > >>> --- a/fs/nfsd/nfs4state.c
> > > >>> +++ b/fs/nfsd/nfs4state.c
> > > >>> @@ -7020,11 +7020,7 @@ nfs4_preprocess_stateid_op(struct svc_rqst=
 *rqstp,
> > > >>>                *nfp =3D NULL;
> > > >>>
> > > >>>        if (ZERO_STATEID(stateid) || ONE_STATEID(stateid)) {
> > > >>> -             if (cstid)
> > > >>> -                     status =3D nfserr_bad_stateid;
> > > >>> -             else
> > > >>> -                     status =3D check_special_stateids(net, fhp,=
 stateid,
> > > >>> -                                                                =
     flags);
> > > > This code was put in by Bruce in commit ("nfsd: fix crash on
> > > > COPY_NOTIFY with special stateid"). Its intentions were to make sur=
e
> > > > that IF COPY_NOTFY was sent with a special state it, then the serve=
r
> > > > would produce an error (in this case bad_stateid). Only from
> > > > copy_notify do we call nfs4_preproces_stateid_op() with a non-null
> > > > cstid. This above logic is needed here as far as I can tell.
> > >
> > > So the purpose was now special stateids will not generate an output
> > > stateid, which COPY_NOTIFY now checks, and fails locally in this case=
.
> >
> > Ok I see it now I do agree with the nfsd4_copy_notify() changes it
> > should be still guard against the use of special stateid.
> >
> > > Maybe I'm missing something, but my assumption is that if a client
> > > sends a COPY_NOTIFY with a special stateid, it will still error out w=
ith
> > > bad stateid (due to the change in nfsd4_copy_notify...\
> >
> > I agree now. Thank you for the explanation. Looks good.
>
> Hi Olga, may I add a Reviewed-by: from you?

Of course.

>
> --
> Chuck Lever


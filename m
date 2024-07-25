Return-Path: <linux-nfs+bounces-5049-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5899D93C356
	for <lists+linux-nfs@lfdr.de>; Thu, 25 Jul 2024 15:51:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 60DEA1C21D28
	for <lists+linux-nfs@lfdr.de>; Thu, 25 Jul 2024 13:51:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6D3913AA36;
	Thu, 25 Jul 2024 13:51:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=umich.edu header.i=@umich.edu header.b="bapyF1f7"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB4F019B3D6
	for <linux-nfs@vger.kernel.org>; Thu, 25 Jul 2024 13:51:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721915486; cv=none; b=TFnholfWpTd3UP/Js6n10nxXs9oatw5TEqF8oa2Jv9XyTfsIK1/ADTtVjISM2oWCJhSAG2j8AiSMFnfkdeki0aYEwoYO7lCvTrKx4eSaDNI0Q5yeX/TEUxi+ltAgNY0B6b7mdhISpSmpXsoq2noRvGrw4jvKn20yOben7Cgfad0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721915486; c=relaxed/simple;
	bh=78ppdNYQlq5/E6FHY4HwFPz1fNEGW8jODQJlBEs89S0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=t06YRkqQ82OCIzsHuk+/M+Mv8HfLy7++OBcErnl3sUw3DU3hPoo4j7FdHPfOG4HTwGpI5xq7qDBdFav8sWCc5S5NnhUWZXZHdpqglMg5dPJYxppaiKbUs0uzo3d7AMnLrGnXf3xMulEIDTdSUiTHhFCe243MiU9E5uAlgPC/lns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=umich.edu; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=umich.edu header.i=@umich.edu header.b=bapyF1f7; arc=none smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=umich.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-2ef298ff716so293251fa.1
        for <linux-nfs@vger.kernel.org>; Thu, 25 Jul 2024 06:51:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umich.edu; s=google-2016-06-03; t=1721915483; x=1722520283; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C5GR/0BbuF/dMcAN2EI9klfmxQgA6Ox0IbiCm+hdnO8=;
        b=bapyF1f71e7gyDMezyVzGbv53/Q9hBtrYG3/MKCZGNR2PDlNx60sU1UQ73LJUcvUuH
         0Dk4SYPznDaL0nbVb1UAYvS0IqVzIID2Tnw98iB27vdKWxeY8A8DpPLWGIOP2CYVDWIv
         3v98skZ22JdNWPrOxWMlRoabuK8ioVwcENc6LvOmF4ksGebmyRYJ0snd4So4S7ePgG72
         XM2agP84eeQcHBNdaotdLVEvPEsddehuXUb4D2fMXJrZTTTfJdoH3VQrhONIhgNMeroM
         jgEpf+lAgIi9OckIKOVNh3aFc+AgQ2f5HMMkuhvhK7yZvWXZXsbtpOioZDLCCaZMPSUZ
         JHcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721915483; x=1722520283;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=C5GR/0BbuF/dMcAN2EI9klfmxQgA6Ox0IbiCm+hdnO8=;
        b=EWX74chgqGPZWdZjBVzAy0Ty6pjTBZdaqDTlK1gL8uV2BAzkoFxpHBgNCI5qeyVhb4
         cSqu5g8SzozwzKJQVkGf0XrhwtneNeaW7zu2QonaTD46Psxb2zzuyCmjmRq4Ju2rXbef
         Yr0RF+1XSV0WGCgtoTYiFbpd0nD5IcXnj8wJlwxq2yv6JbB5AoojFyqHHTTepUHI1JL7
         loupS0lqDEqoX2qpUMmO+PGTvqyJzMGNw1MCbaBJYtv8oivtt82Uoumgcrdk3Ul/ellx
         0qaUjuA7d6S10PNy/f5odtrMdMUrLiEaQg1G2inYg17To6q+mhJSx53pkVoJDUSGKMnm
         +yCQ==
X-Forwarded-Encrypted: i=1; AJvYcCULSOhNiR4T9CagL04a5L1Iqslmj7IQohliapRczsYdT7SdNQxZwK8U5byK4Kh69MkAq3NZIHDd/M72q1NyYzGEZW2VQ+9yb4+i
X-Gm-Message-State: AOJu0Yy/C0VOuzTZ3+OR5/vzkyXRRxyCaNI6k5js7WVF1HbVBXTkkgq4
	D5Ddy95loo3QdIcYaN44FjA3zq9WuN/Vywi1tcxrAWsSHnsLbFu+gYvFjHisYQ3AV8EDeUG3NdT
	hJUON2aPOmkxrpn8wJhZGRn/u+0s=
X-Google-Smtp-Source: AGHT+IFQVX1hTYdfGGFLBOhKH+QlQI+iSNSF1AfwrlFEM+nAeGyzQwDBw/wHGTsZJvyHsGz+zmyfYQyHqYfypv25FQs=
X-Received: by 2002:a2e:a99a:0:b0:2ef:17df:62f9 with SMTP id
 38308e7fff4ca-2f03c7dd359mr11994011fa.7.1721915482429; Thu, 25 Jul 2024
 06:51:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240724170138.1942307-1-sagi@grimberg.me> <ZqE0kTRdRAibsjm7@tissot.1015granger.net>
 <CAN-5tyGAm3LYqTaJvu=w32UEdRPhOCAMtdhnK0e0KacYzTw7Uw@mail.gmail.com> <cf9e9f1c-6e54-4982-a82e-9208a3979989@grimberg.me>
In-Reply-To: <cf9e9f1c-6e54-4982-a82e-9208a3979989@grimberg.me>
From: Olga Kornievskaia <aglo@umich.edu>
Date: Thu, 25 Jul 2024 09:51:11 -0400
Message-ID: <CAN-5tyHj2JNWxzjkKQCK=+AMic25E9vXLVH8iFvc1ur4C+AuEg@mail.gmail.com>
Subject: Re: [PATCH rfc 1/2] nfsd: don't assume copy notify when preprocessing
 the stateid
To: Sagi Grimberg <sagi@grimberg.me>
Cc: Chuck Lever <chuck.lever@oracle.com>, Dai Ngo <dai.ngo@oracle.com>, 
	Jeff Layton <jlayton@kernel.org>, linux-nfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 24, 2024 at 5:43=E2=80=AFPM Sagi Grimberg <sagi@grimberg.me> wr=
ote:
>
>
>
>
> On 24/07/2024 22:12, Olga Kornievskaia wrote:
> > On Wed, Jul 24, 2024 at 1:06=E2=80=AFPM Chuck Lever <chuck.lever@oracle=
.com> wrote:
> >> Adding Olga for her review and comments.
> >>
> >> On Wed, Jul 24, 2024 at 10:01:37AM -0700, Sagi Grimberg wrote:
> >>> Move the stateid handling to nfsd4_copy_notify, if nfs4_preprocess_st=
ateid_op
> >>> did not produce an output stateid, error out.
> >>>
> >>> Copy notify specifically does not permit the use of special stateids,
> >>> so enforce that outside generic stateid pre-processing.
> > I dont see how this patch is accomplishing this. As far as I can tell
> > (just by looking at the code without actually testing it) instead it
> > does exactly the opposite.
>
> I haven't tested this either, does pynfs have a test for it?
>
> >
> >>> Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
> >>> ---
> >>>   fs/nfsd/nfs4proc.c  | 4 +++-
> >>>   fs/nfsd/nfs4state.c | 6 +-----
> >>>   2 files changed, 4 insertions(+), 6 deletions(-)
> >>>
> >>> diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
> >>> index 46bd20fe5c0f..7b70309ad8fb 100644
> >>> --- a/fs/nfsd/nfs4proc.c
> >>> +++ b/fs/nfsd/nfs4proc.c
> >>> @@ -1942,7 +1942,7 @@ nfsd4_copy_notify(struct svc_rqst *rqstp, struc=
t nfsd4_compound_state *cstate,
> >>>        struct nfsd4_copy_notify *cn =3D &u->copy_notify;
> >>>        __be32 status;
> >>>        struct nfsd_net *nn =3D net_generic(SVC_NET(rqstp), nfsd_net_i=
d);
> >>> -     struct nfs4_stid *stid;
> >>> +     struct nfs4_stid *stid =3D NULL;
> >>>        struct nfs4_cpntf_state *cps;
> >>>        struct nfs4_client *clp =3D cstate->clp;
> >>>
> >>> @@ -1951,6 +1951,8 @@ nfsd4_copy_notify(struct svc_rqst *rqstp, struc=
t nfsd4_compound_state *cstate,
> >>>                                        &stid);
> >>>        if (status)
> >>>                return status;
> >>> +     if (!stid)
> >>> +             return nfserr_bad_stateid;
> >>>
> >>>        cn->cpn_lease_time.tv_sec =3D nn->nfsd4_lease;
> >>>        cn->cpn_lease_time.tv_nsec =3D 0;
> >>> diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
> >>> index 69d576b19eb6..dc61a8adfcd4 100644
> >>> --- a/fs/nfsd/nfs4state.c
> >>> +++ b/fs/nfsd/nfs4state.c
> >>> @@ -7020,11 +7020,7 @@ nfs4_preprocess_stateid_op(struct svc_rqst *rq=
stp,
> >>>                *nfp =3D NULL;
> >>>
> >>>        if (ZERO_STATEID(stateid) || ONE_STATEID(stateid)) {
> >>> -             if (cstid)
> >>> -                     status =3D nfserr_bad_stateid;
> >>> -             else
> >>> -                     status =3D check_special_stateids(net, fhp, sta=
teid,
> >>> -                                                                    =
 flags);
> > This code was put in by Bruce in commit ("nfsd: fix crash on
> > COPY_NOTIFY with special stateid"). Its intentions were to make sure
> > that IF COPY_NOTFY was sent with a special state it, then the server
> > would produce an error (in this case bad_stateid). Only from
> > copy_notify do we call nfs4_preproces_stateid_op() with a non-null
> > cstid. This above logic is needed here as far as I can tell.
>
> So the purpose was now special stateids will not generate an output
> stateid, which COPY_NOTIFY now checks, and fails locally in this case.

Ok I see it now I do agree with the nfsd4_copy_notify() changes it
should be still guard against the use of special stateid.

> Maybe I'm missing something, but my assumption is that if a client
> sends a COPY_NOTIFY with a special stateid, it will still error out with
> bad stateid (due to the change in nfsd4_copy_notify...\

I agree now. Thank you for the explanation. Looks good.


Return-Path: <linux-nfs+bounces-3190-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 93C6C8BD8A9
	for <lists+linux-nfs@lfdr.de>; Tue,  7 May 2024 02:31:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2188F1F245F8
	for <lists+linux-nfs@lfdr.de>; Tue,  7 May 2024 00:31:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C4DE7E2;
	Tue,  7 May 2024 00:31:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LrDu/XUZ"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9FB364F
	for <linux-nfs@vger.kernel.org>; Tue,  7 May 2024 00:31:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715041906; cv=none; b=T5ZOKLaUq1E3Did35K03c4x7HLAw0edVJ/8FHiYt5i8k4C9Ozfmogs+mArdR09aKbhW5Cf7xl69mKYDTI0/4BUEM1ByY7x474h4UrBLAx/pWeqmGhxL4E2403ZD2TGx6xOz5fiI5RyCSxz2lQq98p+sGYqEzXtGE//Fr5SPoLCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715041906; c=relaxed/simple;
	bh=04djSHZwHfbp8Y1UrGws/qN/WFWMI/hgu/hPbJ39ePI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bPMAmSoqDEv1e7o6/9/OHRIp768uN5czXMalpHqVSA0E+5Ky3q2mz9Ubo56gAn6py3bs/9SOEt0rpK9OTVRc0RnLW+W7CS+pO+ZkthB6pCGbU0TIuG8RAcH8Lre1C89GZvGlLcWGXGWXmtDpcD/Jobmujg/1hwoTX3LwSIh5J3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LrDu/XUZ; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-2ab1ddfded1so2257109a91.1
        for <linux-nfs@vger.kernel.org>; Mon, 06 May 2024 17:31:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715041904; x=1715646704; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GDgjvR7FpvgxVAR4iSw5rC2wWIHTDn6o/d1oAW9o2gc=;
        b=LrDu/XUZ7NXF9kTxNNj7s8Uv0agmxlaz5DbLlkp/ghOuCAOn6AQ0eODRYv1cn+bYH2
         6J8SBhgZvomrk2b1BQTZ/sCRe/XiiidtS7Vza+cGgNJieLcexA+pM6MloLHZPnPsHmlH
         t9oqFDkHvsO/oy0JJyL/Ax8ACwKB3fC3ZzjpZtFUa3lWcklteHs3yh+Uy2/Kj5tYYLTv
         pISlNK+lrCRZa69WS9synD5NAddvUXyYaHLswq/bnT9sX4ykyUrpgGsfbGiFqx+zPajH
         BjDfgHv2wNuSJWJWQBv1oACiEQiiBfi8cm3roZDcJOsCHQIa2aSGEWFU1MDPBu8ffjVP
         0l3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715041904; x=1715646704;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GDgjvR7FpvgxVAR4iSw5rC2wWIHTDn6o/d1oAW9o2gc=;
        b=mb9I7Vg+pq6Byq3bSVyzyCNLJM3YvH/SNDjYW4J7RPSHC//tybPA+0dhs3vtMoJpjd
         gfum81IiDEH1lA26YDb7njYVmWIdopGB6ow0WgvoVaYpivfdhVoUCUGQMaD6VswRfzDl
         WDxQKVmM96vSo0wD/jI8tBPbupT59202WStl1YG4ax+FhxBPljtJ4JAYiUpzVecFAR2v
         77LJ77CltSmCJ18JDK0zzxNfwyUhn0krZVNXxwJBPg0x6vwrL/yXKKcbuC/IAE/yvDU5
         2ZEBU06lB3terOzAlTIZZxeZ1Q/BO0AWbP7IecUCWoufR8LJngrpcVwRIv8Xyz+lRetf
         eD9Q==
X-Forwarded-Encrypted: i=1; AJvYcCUCUhtdz6wBfabnqaj7DmWA9PuqstBkgC1SEpTs/ZdFrrAYujaElie8Kj9KYYtbrIEzK8fM7p3G8jRXBI8BuXJscFNhVg1hLgk9
X-Gm-Message-State: AOJu0Yzaix6qBdZzS3V5O8WnCoTeKhgUWU25mJECptuTluh8sqUTEjsv
	WOZkD6cPq6vahtE9q4yx+sLwPzLJm1McKC2RSQjMqSPpKQuhDvFLz6rsGstyZwVfvAekKsY4Sbj
	GKf4mcf02FJVk0a3rwsX9oPokmwp4
X-Google-Smtp-Source: AGHT+IEMLoqBfLVtBfiD9wYw1aMLkQzQE+O4SVfsYaYqfJ+fJFDprY92PCdJDyh9CgQAI/Tmu/qaW+CuSmLuSCswMuE=
X-Received: by 2002:a17:90a:c28f:b0:2a7:a774:ba7f with SMTP id
 f15-20020a17090ac28f00b002a7a774ba7fmr10207350pjt.32.1715041903621; Mon, 06
 May 2024 17:31:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240506210408.4760-1-cel@kernel.org> <CAM5tNy4nceCa7k+E1sKEAi5GYJvMwYDuApspFJvSdVdXBuHjmw@mail.gmail.com>
 <ZjlyT95XGccXXRzL@tissot.1015granger.net>
In-Reply-To: <ZjlyT95XGccXXRzL@tissot.1015granger.net>
From: Rick Macklem <rick.macklem@gmail.com>
Date: Mon, 6 May 2024 17:31:33 -0700
Message-ID: <CAM5tNy6gSqAzWnjyFLynZAPXq1Fa6rjik8x8VwNMLYEgHQm0uA@mail.gmail.com>
Subject: Re: [RFC PATCH] NFSD: Force all NFSv4.2 COPY requests to be synchronous
To: Chuck Lever <chuck.lever@oracle.com>
Cc: cel@kernel.org, linux-nfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, May 6, 2024 at 5:14=E2=80=AFPM Chuck Lever <chuck.lever@oracle.com>=
 wrote:
>
> On Mon, May 06, 2024 at 03:30:18PM -0700, Rick Macklem wrote:
> > On Mon, May 6, 2024 at 2:04=E2=80=AFPM <cel@kernel.org> wrote:
> > >
> > > From: Chuck Lever <chuck.lever@oracle.com>
> > >
> > > We've discovered that delivering a CB_OFFLOAD operation can be
> > > unreliable in some pretty unremarkable situations, and the Linux
> > > NFS client does not yet support sending an OFFLOAD_STATUS
> > > operation to probe whether an asynchronous COPY operation has
> > > finished. On Linux NFS clients, COPY can hang until manually
> > > interrupted.
> > >
> > > I've tried a couple of remedies, but so far the side-effects are
> > > worse than the disease. For now, force COPY operations to be
> > > synchronous so that the use of CB_OFFLOAD is avoided entirely.
> > Just a yellow warning light from my experience with the FreeBSD server
> > (which always does synchronous Copy's).
> > A large synchronous Copy can take a long time, resulting in a slow RPC
> > response time. A user reported 25sec.
> > The 25sec case turned out to be a ZFS specific issue that could be avoi=
ded
> > via a ZFS tunable.
> >
> > I do not have a good generic solution, but I do have a tunable that can
> > be used to clip the Copy len, which is a rather blunt and ugly workarou=
nd.
> > (The generic copy routine internal to FreeBSD can accept a flag that in=
dicates
> > "return after 1sec with a partial copy done", but that is not implement=
ed for
> > file systems like ZFS.)
> >
> > Although there is no hard limit in the RFCs for RPC response times,
> > I've typically
> > assumed a max of 1-2sec is desirable.
>
> This is not meant to be a permanent change, but rather one that can
> be backported to LTS kernels if we see the need. A long-term fix
> will re-enable async COPY but deal properly with the loss of a
> CB_OFFLOAD.
>
> The server should return NFS4ERR_DELAY if it expects to take a long
> time, no?
And then the client is going to try the same Copy again after waiting a whi=
le,
yes?
I think you need the Copy to make some progress, so that the client doesn't
just try try again. (Also, in FreeBSD it wouldn't be easy to "interrupt" a =
copy
that is in progress on a server file system so, at least in FreeBSD, I don'=
t
know how the NFS server would know to expect a long delay.  As I noted,
there is a "stop copying after 1sec" flag that, if obeyed by all file syste=
ms,
does allow some progress without taking an excessive time.)

rick

>
> > rick
> >
> > >
> > > I have some patches that add an OFFLOAD_STATUS implementation to the
> > > Linux NFS client, but that is not likely to fix older clients.
> > >
> > > Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
> > > ---
> > >  fs/nfsd/nfs4proc.c | 7 +++++++
> > >  1 file changed, 7 insertions(+)
> > >
> > > diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
> > > index ea3cc3e870a7..12722c709cc6 100644
> > > --- a/fs/nfsd/nfs4proc.c
> > > +++ b/fs/nfsd/nfs4proc.c
> > > @@ -1807,6 +1807,13 @@ nfsd4_copy(struct svc_rqst *rqstp, struct nfsd=
4_compound_state *cstate,
> > >         __be32 status;
> > >         struct nfsd4_copy *async_copy =3D NULL;
> > >
> > > +       /*
> > > +        * Currently, async COPY is not reliable. Force all COPY
> > > +        * requests to be synchronous to avoid client application
> > > +        * hangs waiting for completion.
> > > +        */
> > > +       nfsd4_copy_set_sync(copy, true);
> > > +
> > >         copy->cp_clp =3D cstate->clp;
> > >         if (nfsd4_ssc_is_inter(copy)) {
> > >                 trace_nfsd_copy_inter(copy);
> > >
> > > base-commit: 939cb14d51a150e3c12ef7a8ce0ba04ce6131bd2
> > > --
> > > 2.44.0
> > >
> > >
>
> --
> Chuck Lever


Return-Path: <linux-nfs+bounces-11034-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 831C8A7E94A
	for <lists+linux-nfs@lfdr.de>; Mon,  7 Apr 2025 20:05:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7E5CA3B0759
	for <lists+linux-nfs@lfdr.de>; Mon,  7 Apr 2025 18:02:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 171E818C31;
	Mon,  7 Apr 2025 18:02:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="V3WF2uai"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2225F21A45E
	for <linux-nfs@vger.kernel.org>; Mon,  7 Apr 2025 18:02:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744048963; cv=none; b=eZwRTBpAd5e217is8/vJaFY5LJufWkTK4GbU2dGX8pg4EdUUEPMdfXRRRuPNrt+vGtNun+A9J9QECwe/onR1Jc0F0GzsyrDtvFwRqSVYL1Tk0wDHh2xJMne3JyDLImvsYXqp43Y1YQ552m/zUTau1+dnP1kygvEMIOnEzLsNUzw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744048963; c=relaxed/simple;
	bh=LEbRXWppC6X4wjVyZCWS3az1BOJDGmUe2vwDJ9TtanI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=i7YOTXnR0V53t/a7JOZcSBjA8ynuRljeUPmMDi7C+CgVI3wqIlieMpPS26ICoEvyqBjrt/FRxY2J/XAMcc8l6ds5Tiya1irJqSN7N8B9C0wKE9RoBoW28USPAKJcKU0IeXNiPnOyDCepJqwxtORlV/JYE4eWO7yO9wJ6eZbP1N4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=V3WF2uai; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1744048960;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xT3ET71nKLKtqOOj0DYsBw0M7Lc2oncOXgGAqvNccJo=;
	b=V3WF2uairQXlkUpDVebw2r0LNhUdrwx01iW03OVkavFuAXklc23afjTanEfZOkgh/B6EQD
	ihX0IFXjHbDJaygP93F6OOvNF7QCEeDZbjuRAs2fuLcXMmy6pWrC1cg2M9JeWqavhZxiGe
	udNK8ANLdYCTWA2pdVTU+q+CJRs9BVY=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-76-KARfzCyBPu29jFqgrJM_vw-1; Mon, 07 Apr 2025 14:02:38 -0400
X-MC-Unique: KARfzCyBPu29jFqgrJM_vw-1
X-Mimecast-MFC-AGG-ID: KARfzCyBPu29jFqgrJM_vw_1744048957
Received: by mail-ed1-f71.google.com with SMTP id 4fb4d7f45d1cf-5e6c14c0a95so3837250a12.0
        for <linux-nfs@vger.kernel.org>; Mon, 07 Apr 2025 11:02:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744048957; x=1744653757;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xT3ET71nKLKtqOOj0DYsBw0M7Lc2oncOXgGAqvNccJo=;
        b=APnc/LTReflhpGxK+4n+rzDByMs0y3EAzL8OXLmpN5lT+3qaWuSLYVT5uvVteHbDqn
         P1VuhToTJFKt8XJwemBEnIKG8y0xFMIedsMEGgyLaDXVuKvJOvgZFFMxOGRx1iTs6Mul
         +ThMJKc/BmZgrM4E0qSmhtc51U1yyxE14Dj79+Kbclbrkc53M6OfrF+K2/Ab42S9Vth3
         RpZIhK/Dc6RJldYFoBzXBX5lv1T+PxVSLKzoWgq80K5j6BrVCAzq+QCjFOH9KEYNh86r
         4Lry+t7PYHrnbBF9RDoToZdEf1vIgc3ib7z3xxL87iiVCXvxe165Pb4fTu5pP6rD8X6T
         0R8w==
X-Forwarded-Encrypted: i=1; AJvYcCXokHcP0iZIatlHfvUXCBuUsFmiYSq3FNoT5+Ie6305JPUPAGVUqs+JSR+nRMrUsf6Fn69nVsfUISM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzU47AFpueuccGaRGuAfWnfkyxMXUJ/GmQ2qPSIJjIr6yW47VG3
	bWK2KlUd6nmgAxzeYuBDGjkki0mxtubC26yvQbbDqP3Fay+Lpje8uq/OUGAFpx/7HG9s48x4g1k
	qNMx3Qg8kcHRmYQKGYA96+5GeSNlkNeKhLGSKmYYRriWAZrdl/ToAaxaRU8pYcuQyDxdSK3jY0V
	wkrqD1KwmICJuj480iYePDlvKiCZYqGbFeooihiVKRnLQ=
X-Gm-Gg: ASbGncsneLv3cQGR+fJOSeyiPrE/Ssla7DYuMg9n+3cBnEgACWzxEGwJn/uWkuvUyWF
	wFsm3hIQFec0vUs6O185nHTTiq6xcbfaKw5gipGb/+dafvGXtAg2LEkGspOtRRb6tY0saSAiyhy
	SdDaqrHBaoQfsG/N+hJX5/fKLw3rbjvP0=
X-Received: by 2002:a05:6402:3513:b0:5ec:939e:a60e with SMTP id 4fb4d7f45d1cf-5f0b309a5d5mr11732175a12.0.1744048956634;
        Mon, 07 Apr 2025 11:02:36 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEkdb2dlVmvohyNgitAZ+4JCuBuGjWo6aJJSpGD7/rzbGbtczlOHekmmpARH8y0/YoIPBdw8VZUiunMfMhjW0Q=
X-Received: by 2002:a05:6402:3513:b0:5ec:939e:a60e with SMTP id
 4fb4d7f45d1cf-5f0b309a5d5mr11732136a12.0.1744048956209; Mon, 07 Apr 2025
 11:02:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250322001306.41666-1-okorniev@redhat.com> <20250322001306.41666-3-okorniev@redhat.com>
 <8556bbf14b11dcb29798374d93f6da27bd1735b7.camel@kernel.org>
 <CACSpFtBrJs8PbAbbBBybW_Gn7LR1r9vVSppGa4VVEWMBt_2osA@mail.gmail.com>
 <3963da47314bfa375d46117b382c2fb2961177a1.camel@kernel.org>
 <CACSpFtBu7prTs5t=fy=7t8jWgMwNY1H5nh2B3wASnCCTD8JmDw@mail.gmail.com> <1e446eb107d8a575abf716e5ae40611b3cb52e11.camel@kernel.org>
In-Reply-To: <1e446eb107d8a575abf716e5ae40611b3cb52e11.camel@kernel.org>
From: Olga Kornievskaia <okorniev@redhat.com>
Date: Mon, 7 Apr 2025 14:02:25 -0400
X-Gm-Features: ATxdqUH3NhmCD5drR1IS7xUygWBAWrgqpJxI7hQ-rPhk-leb-zoq2YGgaNWREPw
Message-ID: <CACSpFtCcDgGqFwCSATce6AywDcPY_b6SMO4CK81w0spXBCUpvg@mail.gmail.com>
Subject: Re: [PATCH 2/3] nfsd: adjust nfsd4_spo_must_allow checking order
To: Jeff Layton <jlayton@kernel.org>
Cc: chuck.lever@oracle.com, linux-nfs@vger.kernel.org, neilb@suse.de, 
	Dai.Ngo@oracle.com, tom@talpey.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 7, 2025 at 1:47=E2=80=AFPM Jeff Layton <jlayton@kernel.org> wro=
te:
>
> On Mon, 2025-04-07 at 13:17 -0400, Olga Kornievskaia wrote:
> > On Mon, Apr 7, 2025 at 11:59=E2=80=AFAM Jeff Layton <jlayton@kernel.org=
> wrote:
> > >
> > > On Mon, 2025-04-07 at 11:56 -0400, Olga Kornievskaia wrote:
> > > > On Mon, Apr 7, 2025 at 11:36=E2=80=AFAM Jeff Layton <jlayton@kernel=
.org> wrote:
> > > > >
> > > > > On Fri, 2025-03-21 at 20:13 -0400, Olga Kornievskaia wrote:
> > > > > > Prior to this patch, some non-4.x NFS operations such as NLM
> > > > > > calls have to go thru export policy checking would end up
> > > > > > calling nfsd4_spo_must_allow() function and lead to an
> > > > > > out-of-bounds error because no compound state structures
> > > > > > needed by nfsd4_spo_must_allow() are present in the svc_rqst
> > > > > > request structure.
> > > > > >
> > > > > > Instead, do the nfsd4_spo_must_allow() checking after the
> > > > > > may_bypass_gss check which is geared towards allowing various
> > > > > > calls such as NLM while export policy is set with sec=3Dkrb5:..=
.
> > > > > >
> > > > > > Fixes: 4cc9b9f2bf4d ("nfsd: refine and rename NFSD_MAY_LOCK")
> > > > > > Signed-off-by: Olga Kornievskaia <okorniev@redhat.com>
> > > > > > ---
> > > > > >  fs/nfsd/export.c | 17 ++++++++---------
> > > > > >  1 file changed, 8 insertions(+), 9 deletions(-)
> > > > > >
> > > > > > diff --git a/fs/nfsd/export.c b/fs/nfsd/export.c
> > > > > > index 88ae410b4113..02f26cbd59d0 100644
> > > > > > --- a/fs/nfsd/export.c
> > > > > > +++ b/fs/nfsd/export.c
> > > > > > @@ -1143,15 +1143,6 @@ __be32 check_nfsd_access(struct svc_expo=
rt *exp, struct svc_rqst *rqstp,
> > > > > >                       return nfs_ok;
> > > > > >       }
> > > > > >
> > > > > > -     /* If the compound op contains a spo_must_allowed op,
> > > > > > -      * it will be sent with integrity/protection which
> > > > > > -      * will have to be expressly allowed on mounts that
> > > > > > -      * don't support it
> > > > > > -      */
> > > > > > -
> > > > > > -     if (nfsd4_spo_must_allow(rqstp))
> > > > > > -             return nfs_ok;
> > > > > > -
> > > > > >       /* Some calls may be processed without authentication
> > > > > >        * on GSS exports. For example NFS2/3 calls on root
> > > > > >        * directory, see section 2.3.2 of rfc 2623.
> > > > > > @@ -1168,6 +1159,14 @@ __be32 check_nfsd_access(struct svc_expo=
rt *exp, struct svc_rqst *rqstp,
> > > > > >                               return 0;
> > > > > >               }
> > > > > >       }
> > > > > > +     /* If the compound op contains a spo_must_allowed op,
> > > > > > +      * it will be sent with integrity/protection which
> > > > > > +      * will have to be expressly allowed on mounts that
> > > > > > +      * don't support it
> > > > > > +      */
> > > > > > +     if (nfsd4_spo_must_allow(rqstp))
> > > > > > +             return nfs_ok;
> > > > > > +
> > > > > >
> > > > > >  denied:
> > > > > >       return nfserr_wrongsec;
> > > > >
> > > > > Is this enough to fully fix the OOB problem? It looks like you co=
uld
> > > > > still get past the may_bypass_gss if statement above this with a
> > > > > carefully crafted RPC.
> > > >
> > > > A crafted RPC can and thus Neil's patch that checks the version in
> > > > nfsd4_spo_must_allow is needed.
> > > >
> > > > I still feel changing the order would be beneficial as it would tak=
e
> > > > care of realistic requests.
> > >
> > > No objection to changing the order if that makes sense, but I think w=
e
> > > do need to guard against carefully crafted RPCs too. Can we have
> > > nfsd4_spo_must_allow() vet that the request is NFSv4 before checking
> > > the compound fields too?
> >
> > Neil already posted a patch for that? "nfsd: nfsd4_spo_must_allow()
> > must check this is a v4 compound request" march 27th.
> >
> >
>
> Perfect. You guys are way ahead of me!
>
> With that in place, what's the benefit to taking this patch? Does
> reordering these checks give us anything?

I think with this patch the code is cleaner as the "realistic" v3 path
will never go into nfsd4_spo_must_allow() this way.

> --
> Jeff Layton <jlayton@kernel.org>
>



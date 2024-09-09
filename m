Return-Path: <linux-nfs+bounces-6349-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 49F37971D6C
	for <lists+linux-nfs@lfdr.de>; Mon,  9 Sep 2024 17:03:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F0DAB284337
	for <lists+linux-nfs@lfdr.de>; Mon,  9 Sep 2024 15:03:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E7D418EAB;
	Mon,  9 Sep 2024 15:03:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SU+39dFF"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7811518EB1
	for <linux-nfs@vger.kernel.org>; Mon,  9 Sep 2024 15:02:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725894180; cv=none; b=EoiH2bKU3SipV2Ws/9VMPnjPI/+uR4tJNYFKdyCxXryuDDZnY+3016Mk97iC1zbaEVvgsll7Jbk4pQRqZ+fDsld0KuP0zjWmiB20fDvWeAO/lXWbZQ3yOdAHcsm/YNfgVfigzUpJ/3pXnbr2C1nCYFiyK8zFqN5MZiNrArCfQQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725894180; c=relaxed/simple;
	bh=NMO5GcxdVuLwM0CvohM5c8zcxLwY7KZkTzycBzOafqc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WPxtnwJQ+9zCbrS2ti8zEW6ruWglA8CMCt3UF/rZTdMhpAjg9LiJHuUwPmKgQHVO8UmXPn41RtMkJ9i4bG8K/+UQoqxyq+U5Fq/O3kzhKS+cWbl0mhCcsi0SSeCPgTwZg+YRcNNTa/yr1dx0aBN6zS6DH889Ej7Skit4jhkuWjQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SU+39dFF; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1725894177;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Hy1PSOHPpL4kUQdCAK0GA/zlWy9Z1gksxVpOdhpaeME=;
	b=SU+39dFFOfC50lnrZj7BMx+gQM567bc6nwtRsI9vffqn7R+/39DiZM14Z8ockEbgGpvVI8
	28vufMiDb/TUM5oJtv3o87/4Yu/ikyp4Va124nFTyu72H/JFAGyB/6RrV39/8mLmPm5GxU
	v1RdCucH2ZvNiFYjzOjMfstRyj5WgyE=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-482-mKa-ToWYMuST3gvNDXgW8Q-1; Mon, 09 Sep 2024 11:02:56 -0400
X-MC-Unique: mKa-ToWYMuST3gvNDXgW8Q-1
Received: by mail-ed1-f71.google.com with SMTP id 4fb4d7f45d1cf-5c25d413306so3710199a12.1
        for <linux-nfs@vger.kernel.org>; Mon, 09 Sep 2024 08:02:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725894175; x=1726498975;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Hy1PSOHPpL4kUQdCAK0GA/zlWy9Z1gksxVpOdhpaeME=;
        b=rEVQ9nUaKfxq34MMNarCaghabDdew4gTc/YCRYYr589H+QwOcQfxb6a39EPIYk82Cb
         zUNKFaD1JZrIyUHEkjDmEpkPcDueltRydFp6pvI5Q8C/8prd/3vIVz7LMcMWsOAcE1Cr
         p7iF7ucZYi4WlSR1NN2xjX5PGXfKibSVDrgjVcPEiYg2qqCk2rmvJLLai4B+BeK4GHmc
         hcXRYyMAPpQ9u0oyPAopofvAYXPKcfwhMC/2foJTSo7T2AptD6ud0EePUXBjlnyNKDz9
         xE8qL7e7DDXiYTaplixCpEbdbTa4F0PZAtRYg6AQaQDRlpN8onrfaEZVnbBq01oVBhGI
         +D4g==
X-Forwarded-Encrypted: i=1; AJvYcCVVNaQ/QY7W5H74bHbTvv2SbFWToLmsf7L3HRf2ZOuWO74UTT8uOMGKFe73D+irbsbmbJHa+Ij1GWM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzMzqSmnotbD7lBZMpmUqsK2zkDwBTNOTI3FhPPnFZ+UEFzmjip
	TEgAa0gMTQW3/voCDMbgr4/g8peWUsHrY8alwAauYcVP2rJuMzEZg4zNx3tkU0dV5KVu0fl1FPK
	OvDFKd2nasiSRKhi+DilxoGP8TMR0tnPyhgaeBUp+PLElJVsWiFYelb966siseYBdOi3sE0TazN
	V6wtJzFQg9gGjCMH/3stlkchMZ/h+pJRae
X-Received: by 2002:a05:6402:5246:b0:5c2:5254:e340 with SMTP id 4fb4d7f45d1cf-5c3e953542cmr5320081a12.4.1725894174626;
        Mon, 09 Sep 2024 08:02:54 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF2v4XVVtTYSS3ZOdeFxmRFBlnysCo0aNhnMkmrPr77igm8qfWvFLvTXG1X2/rJfh9/Daj67aoN3lRHdIJJHtc=
X-Received: by 2002:a05:6402:5246:b0:5c2:5254:e340 with SMTP id
 4fb4d7f45d1cf-5c3e953542cmr5320028a12.4.1725894173803; Mon, 09 Sep 2024
 08:02:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <172585839640.4433.13337900639103448371@noble.neil.brown.name>
 <adadfa97e30bc4d827df194814e4e05aa26b8266.camel@kernel.org>
 <CACSpFtBYpQpAKVOmHLPUOr5LvoYq0-ea_NFMctqhMYSamUL_ZQ@mail.gmail.com> <Zt8IOQUF/VEkCPgO@tissot.1015granger.net>
In-Reply-To: <Zt8IOQUF/VEkCPgO@tissot.1015granger.net>
From: Olga Kornievskaia <okorniev@redhat.com>
Date: Mon, 9 Sep 2024 11:02:42 -0400
Message-ID: <CACSpFtCD-yBiO3Oe9m8k9q6Wug6MqgNQmjoT9K8DRAmc3bGLfg@mail.gmail.com>
Subject: Re: [PATCH] nfsd: fix delegation_blocked() to block correctly for at
 least 30 seconds
To: Chuck Lever <chuck.lever@oracle.com>
Cc: Jeff Layton <jlayton@kernel.org>, NeilBrown <neilb@suse.de>, Dai Ngo <Dai.Ngo@oracle.com>, 
	Tom Talpey <tom@talpey.com>, linux-nfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 9, 2024 at 10:38=E2=80=AFAM Chuck Lever <chuck.lever@oracle.com=
> wrote:
>
> On Mon, Sep 09, 2024 at 10:17:42AM -0400, Olga Kornievskaia wrote:
> > On Mon, Sep 9, 2024 at 8:24=E2=80=AFAM Jeff Layton <jlayton@kernel.org>=
 wrote:
> > >
> > > On Mon, 2024-09-09 at 15:06 +1000, NeilBrown wrote:
> > > > The pair of bloom filtered used by delegation_blocked() was intende=
d to
> > > > block delegations on given filehandles for between 30 and 60 second=
s.  A
> > > > new filehandle would be recorded in the "new" bit set.  That would =
then
> > > > be switch to the "old" bit set between 0 and 30 seconds later, and =
it
> > > > would remain as the "old" bit set for 30 seconds.
> > > >
> > >
> > > Since we're on the subject...
> > >
> > > 60s seems like an awfully long time to block delegations on an inode.
> > > Recalls generally don't take more than a few seconds when things are
> > > functioning properly.
> > >
> > > Should we swap the bloom filters more often?
> >
> > I was also thinking that perhaps we can do 15-30s perhaps? Another
> > thought was should this be a configurable value (with some
> > non-negotiable min and max)?
>
> If it needs to be configurable, then we haven't done our jobs as
> system architects. Temporarily blocking delegation ought to be
> effective without human intervention IMHO.
>
> At least let's get some specific usage scenarios that demonstrate a
> palpable need for enabling an admin to adjust this behavior (ie, a
> need that is not simply an implementation bug), then design for
> those specific cases.
>
> Does NFSD have metrics in this area, for example?
>
> Generally speaking, though, I'm not opposed to finessing the behavior
> of the Bloom filter. I'd like to apply the patch below for v6.12,

100% agreed that we need this patch to go in now. The configuration
was just a thought for after which I should have stated explicitly. I
guess I'm not a big fan of hard coded numbers in the code and naively
thinking that it's always better to have a config over a hardcoded
value.

> preserving the Cc: stable, but handle the behavioral finessing via
> a subsequent patch targeting v6.13 so that can be appropriately
> reviewed and tested. Ja?
>
> BTW, nice catch!
>
>
> > > > Unfortunately the code intended to clear the old bit set once it re=
ached
> > > > 30 seconds old, preparing it to be the next new bit set, instead cl=
eared
> > > > the *new* bit set before switching it to be the old bit set.  This =
means
> > > > that the "old" bit set is always empty and delegations are blocked
> > > > between 0 and 30 seconds.
> > > >
> > > > This patch updates bd->new before clearing the set with that index,
> > > > instead of afterwards.
> > > >
> > > > Reported-by: Olga Kornievskaia <okorniev@redhat.com>
> > > > Cc: stable@vger.kernel.org
> > > > Fixes: 6282cd565553 ("NFSD: Don't hand out delegations for 30 secon=
ds after recalling them.")
> > > > Signed-off-by: NeilBrown <neilb@suse.de>
> > > > ---
> > > >  fs/nfsd/nfs4state.c | 5 +++--
> > > >  1 file changed, 3 insertions(+), 2 deletions(-)
> > > >
> > > > diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
> > > > index 4313addbe756..6f18c1a7af2e 100644
> > > > --- a/fs/nfsd/nfs4state.c
> > > > +++ b/fs/nfsd/nfs4state.c
> > > > @@ -1078,7 +1078,8 @@ static void nfs4_free_deleg(struct nfs4_stid =
*stid)
> > > >   * When a delegation is recalled, the filehandle is stored in the =
"new"
> > > >   * filter.
> > > >   * Every 30 seconds we swap the filters and clear the "new" one,
> > > > - * unless both are empty of course.
> > > > + * unless both are empty of course.  This results in delegations f=
or a
> > > > + * given filehandle being blocked for between 30 and 60 seconds.
> > > >   *
> > > >   * Each filter is 256 bits.  We hash the filehandle to 32bit and u=
se the
> > > >   * low 3 bytes as hash-table indices.
> > > > @@ -1107,9 +1108,9 @@ static int delegation_blocked(struct knfsd_fh=
 *fh)
> > > >               if (ktime_get_seconds() - bd->swap_time > 30) {
> > > >                       bd->entries -=3D bd->old_entries;
> > > >                       bd->old_entries =3D bd->entries;
> > > > +                     bd->new =3D 1-bd->new;
> > > >                       memset(bd->set[bd->new], 0,
> > > >                              sizeof(bd->set[0]));
> > > > -                     bd->new =3D 1-bd->new;
> > > >                       bd->swap_time =3D ktime_get_seconds();
> > > >               }
> > > >               spin_unlock(&blocked_delegations_lock);
> > >
> > > --
> > > Jeff Layton <jlayton@kernel.org>
> > >
> >
>
> --
> Chuck Lever
>



Return-Path: <linux-nfs+bounces-11032-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F4ACA7E7FF
	for <lists+linux-nfs@lfdr.de>; Mon,  7 Apr 2025 19:18:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 70054169167
	for <lists+linux-nfs@lfdr.de>; Mon,  7 Apr 2025 17:18:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD50520FAAD;
	Mon,  7 Apr 2025 17:18:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hfgWMFvO"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD47F290F
	for <linux-nfs@vger.kernel.org>; Mon,  7 Apr 2025 17:18:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744046285; cv=none; b=obeegibu2q/4xvQuGeXuVBXNNnUPtwJw4hQKoZYGWpc24sjVjTYpmcJjfXGQTGTW6oyaTXwt3z2n5zWl+kDzPoRiwHJLVQYsewt5DHyA+kWq4DtSv5opzcKaCRaJ9Ko7fgG7UTeiNKPuoNsu8i1cS2OuiDIG72Qu9R7eL3cTcuM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744046285; c=relaxed/simple;
	bh=RybfJQ75oqjCQ/vkccXa78uSrzF+2xBKnLxLZJJfUao=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Pf5albYc4MX7U68Mhzj9Uqv8j87CTL+/bw/fNpT/JbOjCGPd0yp2rWQdcBPTgf6xHFyZdvWEzHIDiXBKC/9wM+kWSy+JyNKFnl7uOnlYCVzARpL8c0wc6+Xm8E+iY7qzvlpfnP7ZqNncI2tZqbrPkDQz1Jet1uM+Y8YLXSGguT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hfgWMFvO; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1744046282;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=juow1stOPFCdXq77lxjCRbrtN+cDu/Ru06+bOLtkS9M=;
	b=hfgWMFvO7iEX82tS8Gn9/J9G9xNHwuup94RGd5y/jBLuAro8KtXo0G8Vr+L0FyjYmByPfn
	GRR/IcJUA7RhPxG9PGM35/2t7DBR5iRpzZY2ZV/Wy6cZ2/AnWtWAqirtqMmkezT49UkdnH
	6GatzfoynirA1pWeILR0ynOzaPDym2w=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-551-jWz9MfzkMp2sb2lPUFcPaw-1; Mon, 07 Apr 2025 13:18:01 -0400
X-MC-Unique: jWz9MfzkMp2sb2lPUFcPaw-1
X-Mimecast-MFC-AGG-ID: jWz9MfzkMp2sb2lPUFcPaw_1744046280
Received: by mail-ed1-f69.google.com with SMTP id 4fb4d7f45d1cf-5e5eb195f01so4039518a12.1
        for <linux-nfs@vger.kernel.org>; Mon, 07 Apr 2025 10:18:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744046280; x=1744651080;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=juow1stOPFCdXq77lxjCRbrtN+cDu/Ru06+bOLtkS9M=;
        b=Bi6Xpe3gaV4qIzCjWShjh4qc7apzgWMkUNqzVYo2Gmb/CfOr8Jt88aKS8aI6PxKxPy
         yOfvvhaivpDid8RymeP69mpJik53MlqJUc/ohQECNJM4F+FVfHmpna8it5IMQh3JhWbd
         9Bpo+sUH5wP0i/k2KLq7RD+azHoPslppIbtSrtqKUC/Ftn2O0/E0vX4P584fnlm/yFfl
         /Ab7EdA3BwwQJ+Eo6oS+SN/6VCtHYBpGv7crpu94EaYJTKOBj5iQomB5fZ0fAs/cO6pt
         HOC6rr545vCN6/viazufnmk48nMUOprYDY1yFDCtoDFefFYQWBMCPC1GI8+FtGb3HtuA
         MbQQ==
X-Forwarded-Encrypted: i=1; AJvYcCXOH6pWldmX6EAzi9ymfMQm8Dz+xEV4vWQ9BQ+F9z6C47r22EysXML05ihOapUDhn+XT614jVQM6VA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz8boO7N6qBq66+oNYQzGt7AAfW2LYEVb3WWyiWQF+jAEA+bPjs
	3vgenkCgevZyxAKPicq3txj6iJdUtERXB5cDkcEWXD1eQwSbU1wYN12LG/dRKkt/alLhX2v0aQO
	a1Z5u2NZB/kAxU5GyhWMPGJ3RwpZJ4Fu0Rht9wJLmQDDq0LQBgOE6HAGkdy0NBv/hiny8fzGUah
	bmCVg8OMnTgB2xva2/fIrcxZWVU3cz/3sk
X-Gm-Gg: ASbGnctUL98bkIF7UtR7Sb99fu62Q/iZEjRTn77GtEKgy6mDNu3deUFVKfTZ/d0WIf5
	IZNJNZnMya5M/tiea7H87li/cPUYnaFCh9aB23glWcM0dKfFWCeBdkvb3OLnXxVVkk0ha7rzmkS
	6epkLz8quS1vW6DP1IQt/0Fg+WVU6KJgo=
X-Received: by 2002:a05:6402:3213:b0:5f0:d853:5010 with SMTP id 4fb4d7f45d1cf-5f0d8535098mr9547489a12.19.1744046280127;
        Mon, 07 Apr 2025 10:18:00 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF/zZMutDy36uIHKi59Pn+9k1LhyWFY8MNntjrd/mdujoENMKdtR2ZJh//ZECIszFvm+G3MgBxAhV7EDubf4c8=
X-Received: by 2002:a05:6402:3213:b0:5f0:d853:5010 with SMTP id
 4fb4d7f45d1cf-5f0d8535098mr9547470a12.19.1744046279785; Mon, 07 Apr 2025
 10:17:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250322001306.41666-1-okorniev@redhat.com> <20250322001306.41666-3-okorniev@redhat.com>
 <8556bbf14b11dcb29798374d93f6da27bd1735b7.camel@kernel.org>
 <CACSpFtBrJs8PbAbbBBybW_Gn7LR1r9vVSppGa4VVEWMBt_2osA@mail.gmail.com> <3963da47314bfa375d46117b382c2fb2961177a1.camel@kernel.org>
In-Reply-To: <3963da47314bfa375d46117b382c2fb2961177a1.camel@kernel.org>
From: Olga Kornievskaia <okorniev@redhat.com>
Date: Mon, 7 Apr 2025 13:17:48 -0400
X-Gm-Features: ATxdqUHm2jXZ_HooYjrcc4VvGbSaibaih_AjS9kVeTnM0YN9kNMyuVff4sIAOV4
Message-ID: <CACSpFtBu7prTs5t=fy=7t8jWgMwNY1H5nh2B3wASnCCTD8JmDw@mail.gmail.com>
Subject: Re: [PATCH 2/3] nfsd: adjust nfsd4_spo_must_allow checking order
To: Jeff Layton <jlayton@kernel.org>
Cc: chuck.lever@oracle.com, linux-nfs@vger.kernel.org, neilb@suse.de, 
	Dai.Ngo@oracle.com, tom@talpey.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 7, 2025 at 11:59=E2=80=AFAM Jeff Layton <jlayton@kernel.org> wr=
ote:
>
> On Mon, 2025-04-07 at 11:56 -0400, Olga Kornievskaia wrote:
> > On Mon, Apr 7, 2025 at 11:36=E2=80=AFAM Jeff Layton <jlayton@kernel.org=
> wrote:
> > >
> > > On Fri, 2025-03-21 at 20:13 -0400, Olga Kornievskaia wrote:
> > > > Prior to this patch, some non-4.x NFS operations such as NLM
> > > > calls have to go thru export policy checking would end up
> > > > calling nfsd4_spo_must_allow() function and lead to an
> > > > out-of-bounds error because no compound state structures
> > > > needed by nfsd4_spo_must_allow() are present in the svc_rqst
> > > > request structure.
> > > >
> > > > Instead, do the nfsd4_spo_must_allow() checking after the
> > > > may_bypass_gss check which is geared towards allowing various
> > > > calls such as NLM while export policy is set with sec=3Dkrb5:...
> > > >
> > > > Fixes: 4cc9b9f2bf4d ("nfsd: refine and rename NFSD_MAY_LOCK")
> > > > Signed-off-by: Olga Kornievskaia <okorniev@redhat.com>
> > > > ---
> > > >  fs/nfsd/export.c | 17 ++++++++---------
> > > >  1 file changed, 8 insertions(+), 9 deletions(-)
> > > >
> > > > diff --git a/fs/nfsd/export.c b/fs/nfsd/export.c
> > > > index 88ae410b4113..02f26cbd59d0 100644
> > > > --- a/fs/nfsd/export.c
> > > > +++ b/fs/nfsd/export.c
> > > > @@ -1143,15 +1143,6 @@ __be32 check_nfsd_access(struct svc_export *=
exp, struct svc_rqst *rqstp,
> > > >                       return nfs_ok;
> > > >       }
> > > >
> > > > -     /* If the compound op contains a spo_must_allowed op,
> > > > -      * it will be sent with integrity/protection which
> > > > -      * will have to be expressly allowed on mounts that
> > > > -      * don't support it
> > > > -      */
> > > > -
> > > > -     if (nfsd4_spo_must_allow(rqstp))
> > > > -             return nfs_ok;
> > > > -
> > > >       /* Some calls may be processed without authentication
> > > >        * on GSS exports. For example NFS2/3 calls on root
> > > >        * directory, see section 2.3.2 of rfc 2623.
> > > > @@ -1168,6 +1159,14 @@ __be32 check_nfsd_access(struct svc_export *=
exp, struct svc_rqst *rqstp,
> > > >                               return 0;
> > > >               }
> > > >       }
> > > > +     /* If the compound op contains a spo_must_allowed op,
> > > > +      * it will be sent with integrity/protection which
> > > > +      * will have to be expressly allowed on mounts that
> > > > +      * don't support it
> > > > +      */
> > > > +     if (nfsd4_spo_must_allow(rqstp))
> > > > +             return nfs_ok;
> > > > +
> > > >
> > > >  denied:
> > > >       return nfserr_wrongsec;
> > >
> > > Is this enough to fully fix the OOB problem? It looks like you could
> > > still get past the may_bypass_gss if statement above this with a
> > > carefully crafted RPC.
> >
> > A crafted RPC can and thus Neil's patch that checks the version in
> > nfsd4_spo_must_allow is needed.
> >
> > I still feel changing the order would be beneficial as it would take
> > care of realistic requests.
>
> No objection to changing the order if that makes sense, but I think we
> do need to guard against carefully crafted RPCs too. Can we have
> nfsd4_spo_must_allow() vet that the request is NFSv4 before checking
> the compound fields too?

Neil already posted a patch for that? "nfsd: nfsd4_spo_must_allow()
must check this is a v4 compound request" march 27th.

> --
> Jeff Layton <jlayton@kernel.org>
>



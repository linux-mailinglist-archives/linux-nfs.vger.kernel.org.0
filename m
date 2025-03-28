Return-Path: <linux-nfs+bounces-10935-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DC00A741C1
	for <lists+linux-nfs@lfdr.de>; Fri, 28 Mar 2025 01:36:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 18D0C178641
	for <lists+linux-nfs@lfdr.de>; Fri, 28 Mar 2025 00:36:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F2A628373;
	Fri, 28 Mar 2025 00:36:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DTkLKT6e"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EDC517BCE
	for <linux-nfs@vger.kernel.org>; Fri, 28 Mar 2025 00:36:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743122183; cv=none; b=PKiw9AuovY3DSaPId082XoLtvAsW896ebEgHvwZC81fPjPFGGcdnF40bNLvhT+qODMb9luH0V8NyXbHbIntru3y9NblXSV8eqbbNDwD9yRHG1YeB8yqU3yjg+DtAg9aZh3f3PtGf8w1dNdPQlafxYoOmw1rrLpcXlq6Kehj53u8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743122183; c=relaxed/simple;
	bh=wctJ1ErYcQBnFjNhI/Wh4UmCu7tinOhLlAmuiPV8uWo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QIIIcxAKreJHyZHBAYtURoCDO6H1RPGXG5L7vGudBO2R68ncc2QQjy9aHO2AZEKbnEaioSy9j6T5E1bIWsbc1AL0DPu9o07dU5cieZp5eXkog31NKOO8bZpSz++r2Peb+2JMZOP4GeGzTVHvvupw2poND+bBp9cFjVI3KNo9C5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DTkLKT6e; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1743122180;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jZgT0WURSRB848HBI94GLSiMtq/jWtcd9/O2hUbTiIc=;
	b=DTkLKT6e/K9EnOD0vhRi4l7U9yaBZGs/Gft/VC/BaOCFhHQ3z1K2ZqUjEiWt8De8T3jXle
	jPvGlaHNBxOrRQyEjt3SjH5JAab56CX649tjspU+CiMlBMSbh6rO7tFbFCSNdKYVgT/yq5
	1u+kdNQasSMhFdjf0OyNLeyGXKjg6fA=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-182-17TiKDEaPqaXFelBl45HIg-1; Thu, 27 Mar 2025 20:36:18 -0400
X-MC-Unique: 17TiKDEaPqaXFelBl45HIg-1
X-Mimecast-MFC-AGG-ID: 17TiKDEaPqaXFelBl45HIg_1743122177
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-ac28a2c7c48so78546366b.3
        for <linux-nfs@vger.kernel.org>; Thu, 27 Mar 2025 17:36:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743122177; x=1743726977;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jZgT0WURSRB848HBI94GLSiMtq/jWtcd9/O2hUbTiIc=;
        b=Wkdp69yeovZlIvqmjd9N9yKZCeEyrdd73RUoFsAvt4iY+j/RPBe+/m/UoQzK48pN4R
         9oDO/BwGKuVyj6d4WkopnHQzWYP3aFqMwpgJo3xxE1XmPTA4dCdk41oQYSSgrz+r5nx9
         D3AXHyOB7rYLq9dxsXkScur2TZieG1OrhUU++KwcXoRdx2lhkH4kRQAW/VRJjEUl405J
         NOjHLbaWvUUjqmXn+N2LtFvNe3rVpyJx1H8Ex3gBfNcGTk3F/dUhPtSt5xVPaHlIvgVO
         ZxfDlwOPX0cLMpMB/ztBbHMvfvkZZF/BgZspHmsnStOlQz6AfHciFMB3SE3yzZOrYE1B
         C/qA==
X-Forwarded-Encrypted: i=1; AJvYcCXxpQJqabd0gBCovuPy+Uv9K3osVilLEv+Zwzs52Gpb1dr7YGDpg9rFPFFpjO9LkpcERMVxXA4qsFY=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywx5yoljKqR1JH56bUnATA55vFsdAg8ndaxQ1qJohaugtgeI9qr
	YFm8Q9kNyX8xJ+2gM57hMvzAPSNy7sUSUEp05E8rWVfE5yzQRk3+LtiNtuSf0iyoOwAr/ILsqWk
	P2An5HnC67vP/d2noqI5VjsjQhCqjgpgKL/Zfmr0cF0v3Je1Q4PW6kjnyCc11J3QE8CKlzrNoMt
	dxOEsRCn3CmeFyXq9jBfUp8hVCpXvVyOqb
X-Gm-Gg: ASbGncsIstC7fvk7FQnRPp8QsXBzaIMX1dZUbsVj25KG32+Z5qqRCnSn4/M+jGnLeVF
	DSyqgGK9VulHyF2cSvxh/ef4a5OTadO+wce9/Ax8Q1jd9DaoE3Ogfp95ggbtsyyhanrpOCEST2D
	wx4AfojLw7EGpgMOdqY1y6+tFsLn1wlQM=
X-Received: by 2002:a17:907:3e90:b0:ac4:2a9:5093 with SMTP id a640c23a62f3a-ac6fb14ebddmr553280766b.41.1743122177276;
        Thu, 27 Mar 2025 17:36:17 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEOv5cgmL9L69uRA52T3l+7YmYTaNqKGARXqj9YkPhDmy6k+21t7V0zdDjPYRed82cY0+NI9ayCDEso7MgThBg=
X-Received: by 2002:a17:907:3e90:b0:ac4:2a9:5093 with SMTP id
 a640c23a62f3a-ac6fb14ebddmr553278466b.41.1743122176865; Thu, 27 Mar 2025
 17:36:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250322001306.41666-1-okorniev@redhat.com> <20250322001306.41666-4-okorniev@redhat.com>
 <174311964828.9342.15055420092560166796@noble.neil.brown.name>
In-Reply-To: <174311964828.9342.15055420092560166796@noble.neil.brown.name>
From: Olga Kornievskaia <okorniev@redhat.com>
Date: Thu, 27 Mar 2025 20:36:05 -0400
X-Gm-Features: AQ5f1JprVynr4NtDep7euj9wRN1G8k3rs5niCQvvhm-OVoEH1H2pUAx1epZXtqQ
Message-ID: <CACSpFtAj1TxzsMfxuSttA0_tqAZ2FZR69DuL5i-xK6bvMbtc_w@mail.gmail.com>
Subject: Re: [PATCH 3/3] nfsd: reset access mask for NLM calls in nfsd_permission
To: NeilBrown <neilb@suse.de>
Cc: chuck.lever@oracle.com, jlayton@kernel.org, linux-nfs@vger.kernel.org, 
	Dai.Ngo@oracle.com, tom@talpey.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 27, 2025 at 7:54=E2=80=AFPM NeilBrown <neilb@suse.de> wrote:
>
> On Sat, 22 Mar 2025, Olga Kornievskaia wrote:
> > NLM locking calls need to pass thru file permission checking
> > and for that prior to calling inode_permission() we need
> > to set appropriate access mask.
> >
> > Fixes: 4cc9b9f2bf4d ("nfsd: refine and rename NFSD_MAY_LOCK")
> > Signed-off-by: Olga Kornievskaia <okorniev@redhat.com>
> > ---
> >  fs/nfsd/vfs.c | 7 +++++++
> >  1 file changed, 7 insertions(+)
> >
> > diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
> > index 4021b047eb18..7928ae21509f 100644
> > --- a/fs/nfsd/vfs.c
> > +++ b/fs/nfsd/vfs.c
> > @@ -2582,6 +2582,13 @@ nfsd_permission(struct svc_cred *cred, struct sv=
c_export *exp,
> >       if ((acc & NFSD_MAY_TRUNC) && IS_APPEND(inode))
> >               return nfserr_perm;
> >
> > +     /*
> > +      * For the purpose of permission checking of NLM requests,
> > +      * the locker must have READ access or own the file
> > +      */
> > +     if (acc & NFSD_MAY_NLM)
> > +             acc =3D NFSD_MAY_READ | NFSD_MAY_OWNER_OVERRIDE;
> > +
>
> I don't agree with this change.
> The only time that NFSD_MAY_NLM is set, NFSD_MAY_OWNER_OVERRIDE is also
> set.  So that part of the change adds no value.
>
> This change only affects the case where a write lock is being requested.
> In that case acc will contains NFSD_MAY_WRITE but not NFSD_MAY_READ.
> This change will set NFSD_MAY_READ.  Is that really needed?
>
> Can you please describe the particular problem you saw that is fixed by
> this patch?  If there is a problem and we do need to add NFSD_MAY_READ,
> then I would rather it were done in nlm_fopen().

set export policy with (sec=3Dkrb5:...) then mount with sec=3Dkrb5,vers=3D3=
,
then ask for an exclusive flock(), it would fail.

The reason it fails is because nlm_fopen() translates lock to open
with WRITE. Prior to patch 4cc9b9f2bf4d, the access would be set to
acc =3D NFSD_MAY_READ | NFSD_MAY_OWNER_OVERRIDE; before calling into
inode_permission(). The patch changed it and lead to lock no longer
being given out with sec=3Dkrb5 policy.


>
> Thanks,
> NeilBrown
>
>
> >       /*
> >        * The file owner always gets access permission for accesses that
> >        * would normally be checked at open time. This is to make
> > --
> > 2.47.1
> >
> >
>



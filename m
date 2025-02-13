Return-Path: <linux-nfs+bounces-10097-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 96052A34BEE
	for <lists+linux-nfs@lfdr.de>; Thu, 13 Feb 2025 18:30:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3CCDC1884ED5
	for <lists+linux-nfs@lfdr.de>; Thu, 13 Feb 2025 17:30:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CE5D200BB4;
	Thu, 13 Feb 2025 17:30:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SPEk44Z4"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B1CF28A2AC
	for <linux-nfs@vger.kernel.org>; Thu, 13 Feb 2025 17:30:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739467831; cv=none; b=JkUOpUnD04Y+zZQHPNo902E8isvzEuyVHdQdFINIx6YHPLUVrU93VVlrsqMiwEcanIhTa/oYV4fCuMh8d0WG/LAHbIGSzPMG9IhtVTUKo0s1ma+caEVOXK/0SHz9VYBns3wKgPeITbG0/3NIms2Z+17uzFutU9DK4iSeiTf65f4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739467831; c=relaxed/simple;
	bh=B1DRwpsDsU+65wFJFbwQjOr1F7cWU+P0Sc5eU5pcdmU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=i3aPL6e7w/RzjGsoni7koGT615GdJi/yb7sZRdVd+RInO15EtlaDttvXNAPdNkCqvbqdYpIq3dsRFpEfCLKeF7X1qfc3OceN8Q5Eb5i0spycUpZevmP4LiQdusjhD5AgChWFtpdRletlScZXvr3Xg4ZyX2ghckWR9qVbvUHByt8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SPEk44Z4; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1739467828;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xPL2GTjrCSFMENU3YPux7glgmNbX/7/D1+yyhzBuAZA=;
	b=SPEk44Z4QsyXybSg5JYh8Qt7RBEpmMxek9CHMYoyGlbeKMgguY47fZ0iBYQhwSFwt5P2fa
	B11CiQm4PtkR+Oq3yy8+to/8ChYuhB8SLvU7K6eUJ2zLvzCiowBbpg07zzzRL1yFxx4mND
	RcautDkarfUd9/Wklpzi1wzEC4AV6jc=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-351-f0e5w6m_Ng2K0oeAGs73Ew-1; Thu, 13 Feb 2025 12:30:26 -0500
X-MC-Unique: f0e5w6m_Ng2K0oeAGs73Ew-1
X-Mimecast-MFC-AGG-ID: f0e5w6m_Ng2K0oeAGs73Ew_1739467826
Received: by mail-ed1-f70.google.com with SMTP id 4fb4d7f45d1cf-5de575eecbaso1045206a12.1
        for <linux-nfs@vger.kernel.org>; Thu, 13 Feb 2025 09:30:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739467825; x=1740072625;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xPL2GTjrCSFMENU3YPux7glgmNbX/7/D1+yyhzBuAZA=;
        b=wLXSVypQunhVvhcNgvu/M/PC2cC95xaMCz4G4IMJcvpiNJdYtuyrNjgZuZHT1UnTLK
         hjOmiKvDgZpZzh+bLVebz3jLfBO53ZiHmlk7hu29Tr+AUza8zL03LdUwS+4bFGhaOTMJ
         c8xp0h48pdMv1LjtyTIGQrY/suTrMAc7vYRxFlfRwwUBkqnCik85j/QQRd+g07ar/uJq
         Ik+GarobSJ5uB4DoqRwaG544gaQJVWgXe/p68QK4hd5APbqbAS7vzfzM3ffNsXI7Gv8M
         5AIgadO5Uet/lcML75nIZYiOQwLimFlHH29k/xiQ/nHG0U58DAT7I0xmzB9uYMo0S6vQ
         wCBg==
X-Forwarded-Encrypted: i=1; AJvYcCWW8r+yRNloLv7fF9ZaGW5nFlKzf0We7MxK9o3ks30Z4ZQzfgBufl1NDsiMQu50Lt5AQ/nBmVs5xv4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyiT21VjH0vA7rR5zFBQ9uTmmfUKA5bLCxud/xOCPfqGLCme3ub
	lLNtVND903JDHdiBRMUAGFgzwbsVObpPw0uftTyUWoCLcmrbISpxLp8vF7+B8y6SxfpKmruaE7f
	KyWTqk1NiVto9bkVfValAAt6+JVaBUn2eOLJMDQZQcjcJtztd1ftv0nqBvSphhZdE+8ggJYRhVT
	LYhY0SpsH2tjd1fJ2lOtw7NRH+y/nAKMSh
X-Gm-Gg: ASbGncuizxkcyuivLx65hXd32oF2fU8VEKUeTp6DyJ9uGJ4OXcibJ2oLd7q/OoY1fkr
	rvq/8NmqImoiccz0xKSCljCuCs/dsRHomesgTueKoTYZxfLeJcVt6OpfQ2nzcbr0WgJjjVN7TK9
	4pghtYTS06SGz8082G7j/w
X-Received: by 2002:a05:6402:3549:b0:5de:515d:814f with SMTP id 4fb4d7f45d1cf-5deaddc11ebmr7417551a12.19.1739467825299;
        Thu, 13 Feb 2025 09:30:25 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGjnq5U16/4qeZ/qwOYyvgMYwQlCr2oTpZ7rPPZNRTBlKdG1jEk9hV2/+gs/3aIU0UHBNDCrVTGKg+Cr8YHBGg=
X-Received: by 2002:a05:6402:3549:b0:5de:515d:814f with SMTP id
 4fb4d7f45d1cf-5deaddc11ebmr7417494a12.19.1739467824699; Thu, 13 Feb 2025
 09:30:24 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250213154722.37499-1-okorniev@redhat.com> <c65ebd14-f7e1-45a8-9bc2-211440977ab0@oracle.com>
In-Reply-To: <c65ebd14-f7e1-45a8-9bc2-211440977ab0@oracle.com>
From: Olga Kornievskaia <okorniev@redhat.com>
Date: Thu, 13 Feb 2025 12:30:14 -0500
X-Gm-Features: AWEUYZk8b3zv-iRXc1uE06zBqplD1pIV_nevisaAvyXkLhOG2ybqvSrbc3JpGf0
Message-ID: <CACSpFtDjqhgmFO=pTY1ErZEhQZNgewo9ao+RuuGY3hm9CSqcqA@mail.gmail.com>
Subject: Re: [PATCH 1/1] nfs-utils: nfsdctl: dont ignore rdma listener return
To: Chuck Lever <chuck.lever@oracle.com>
Cc: steved@redhat.com, linux-nfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 13, 2025 at 11:01=E2=80=AFAM Chuck Lever <chuck.lever@oracle.co=
m> wrote:
>
> On 2/13/25 10:47 AM, Olga Kornievskaia wrote:
> > Don't ignore return code of adding rdma listener. If nfs.conf has asked
> > for "rdma=3Dy" but adding the listener fails, don't ignore the failure.
> > Note in soft-rdma-provider environment (such as soft iwarp, soft roce),
> > when no address-constraints are used, an "any" listener is created and
> > rdma-enabling is done independently.
>
> This behavior is confusing... I suggest that an nfs.conf man page
> update accompany the below code change.

Do you find only the rdma=3Dy soft-rdma case confusing, or do you find
that when listeners fail and we shouldn't start knfsd threads in
general confusing?

It was always the case that if rdma=3Dy is done, then any listener
created for it does not check whether or not the underlying interface
is already rdma-enabled. This hasn't changed. Nor does this patch
change it.

> Reviewed-by: Chuck Lever <chuck.lever@oracle.com>
>
>
> > Fixes: e3b72007ab31 ("nfs-utils: nfsdctl: cleanup listeners if some fai=
led")
> > Signed-off-by: Olga Kornievskaia <okorniev@redhat.com>
> > ---
> >  utils/nfsdctl/nfsdctl.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/utils/nfsdctl/nfsdctl.c b/utils/nfsdctl/nfsdctl.c
> > index 05fecc71..244910ef 100644
> > --- a/utils/nfsdctl/nfsdctl.c
> > +++ b/utils/nfsdctl/nfsdctl.c
> > @@ -1388,7 +1388,7 @@ static int configure_listeners(void)
> >                       if (tcp)
> >                               ret =3D add_listener("tcp", n->field, por=
t);
> >                       if (rdma)
> > -                             add_listener("rdma", n->field, rdma_port)=
;
> > +                             ret =3D add_listener("rdma", n->field, rd=
ma_port);
> >                       if (ret)
> >                               return ret;
> >               }
> > @@ -1398,7 +1398,7 @@ static int configure_listeners(void)
> >               if (tcp)
> >                       ret =3D add_listener("tcp", "", port);
> >               if (rdma)
> > -                     add_listener("rdma", "", rdma_port);
> > +                     ret =3D add_listener("rdma", "", rdma_port);
> >       }
> >       return ret;
> >  }
>
>
> --
> Chuck Lever
>



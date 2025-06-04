Return-Path: <linux-nfs+bounces-12107-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EF14ACE47F
	for <lists+linux-nfs@lfdr.de>; Wed,  4 Jun 2025 20:46:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 280F97A9F31
	for <lists+linux-nfs@lfdr.de>; Wed,  4 Jun 2025 18:45:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8BC9320F;
	Wed,  4 Jun 2025 18:46:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="in34B1uG"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 438481DED7C
	for <linux-nfs@vger.kernel.org>; Wed,  4 Jun 2025 18:46:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749062787; cv=none; b=m3TBRzoga9xDPQpyFyw9LnbWwEgi5leC/0D5n9qKcsVhhvUNG5wIYBTIULfRZ6gt7R3caWP8jEIzNO8xeAqEbW6ttz6Qj2rrdUiQwrBhcVLiaic+vmcxgSKPFPOasuJlYVBUeQKJtMK15ezBqxlDufkw9/yVHzz4BGYNgU84IeQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749062787; c=relaxed/simple;
	bh=eDerJRpEuYJaaEMu9v3zlLMWe1Ogm3m5cHCgT8/5zAI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Pn+wWj+NV3+7GMvGEYJOg8kehmXAQsAP9igddWGaQ9SWwtEl+BwMgg6QzJzfhQfDVdaFU9QH7Lj7qQGSsbO9i8FPfvdtMh/dW3d410yfnNqgDRFSpqa44tlJ7iovxvsXnpyR/ZKKuGW0oTlvI8eM0aYg6ZjUhZmON0P43dwhz7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=in34B1uG; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2350b1b9129so1228625ad.0
        for <linux-nfs@vger.kernel.org>; Wed, 04 Jun 2025 11:46:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749062785; x=1749667585; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ubQ+qLVNtT+NxwkpW/CWUf1z395bwuh7DYdc9xbrXcA=;
        b=in34B1uGWqPH5vyTne4F4kQbGImalZ7B9PfnuRI6RzYFKilyLfTCFsgE8DCGK+wd1+
         lMjtl/7GIKtf+rZeZ1rFkMKlwT8Ip3g/G6vYpH4aHMQtkEN77zHqquyMAK6rBf4TOGmn
         Grpt8RWDvl2bo3/dSRX3Q67eS1lJCzVTMk3OLQkcvoSSlVlCofP62ltQkKzfQKEL3m7q
         NT8luM8r3LwU/hVmlmtQ2lGO/hTmlPmMZOqkp1+sKxXglWc1e9hfAYRIxBRH75ygXzt3
         328W5lp+HDdV3p/1vhxDqhnRkaX/kdpfwusDenv0Xw0gz0y+n152lWorwE1aY8e0QcZU
         rSJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749062785; x=1749667585;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ubQ+qLVNtT+NxwkpW/CWUf1z395bwuh7DYdc9xbrXcA=;
        b=PGPJsU2K0bkr5mLYX8o9T6shWjHdJX9lz1Qy/cVhZAhdMdN1/kt9Wp7/FxqGj/7CQ/
         HP5IAOCe8GySW55yLvrg9hTHO3RwXPd2P3ummrqII+0740b+GWYcYmJKUp5n35SS1euG
         8doJLC8MQDKa9UEDE2F+MzR7uz8lnLwrVf97TkzR3HkbO0XaCHjbHJgZgdxysvKUE6/1
         FAA30X3RwBtbHkKZJ28fHdV3J2J5KYDz35iQFhqrP54DsibFPK+K1EwG85Ax6uDjYdTc
         xmv39nVsYhn5ahkK5Of/+Ps+piBhNEzUS+BPYX/Qf97APLblusmOrhgFiOfjvZWzGTli
         ahbQ==
X-Forwarded-Encrypted: i=1; AJvYcCXeY6BCAPsRrnrvJu9GX0gRutxQDVLvI69JFe0R6c4+CyZXgPaocQq5jy+Sf9BLZovAJL2+qfGzoMM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwU9IFKXrHOHJXfQAGPtSgfUHMEk0M+BekFLT9lOxiSs+MOsR7x
	Gov49F+Oknij14TUVzs6dap5K3PvKhw//vWIbn/V73Lx7xP73zRMroXzzCMKleeyColxWouGVht
	iYypIGmK6DZWsYfSON+lmlzwxFXEXq4A=
X-Gm-Gg: ASbGncsJiGO5zlvGfWF2l6U0k80eOAWpz1kQhtWQGVixJRXDBwTCnxvkyUaVH9ths8X
	Ti5yqxwqJDykY27NIG2ohED88XZtb7DT1QvRsQ5q5IErcET4KhZWy/+2d1CkJZ3d3on4DFho+ba
	F/XEo+L68rckwCPkoCOluU56XiVMTDXTds
X-Google-Smtp-Source: AGHT+IH/CtUW9OMuJiqxhR68X8gy74rvnMJihk9gmC/Hvk51nnk/wB5EJI7BCzgpXhhN5ttgBBaUPXx6yul9/GcEScc=
X-Received: by 2002:a17:902:ce8f:b0:229:1619:ab58 with SMTP id
 d9443c01a7336-235e120601dmr57030575ad.43.1749062785535; Wed, 04 Jun 2025
 11:46:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250513-master-v1-1-e845fe412715@kernel.org> <7bbb789d-b3ae-4258-bebf-40ed87587576@redhat.com>
In-Reply-To: <7bbb789d-b3ae-4258-bebf-40ed87587576@redhat.com>
From: Cedric Blancher <cedric.blancher@gmail.com>
Date: Wed, 4 Jun 2025 20:45:48 +0200
X-Gm-Features: AX0GCFvmO-xLRZSdcRWy5hLeGDhwMLO2dSX7aYFfaqBeSepJdjDCR2QJmpVmpNw
Message-ID: <CALXu0Ud2BHcd_pWTzV2ToB3Qm-_Zrg3ebsEPX5WWPsPnKQ8Usg@mail.gmail.com>
Subject: Re: [PATCH nfs-utils] exportfs: make "insecure" the default for all exports
To: Steve Dickson <steved@redhat.com>
Cc: Jeff Layton <jlayton@kernel.org>, Tom Haynes <loghyr@gmail.com>, linux-nfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 4 Jun 2025 at 20:26, Steve Dickson <steved@redhat.com> wrote:
>
> Hello all,
>
> On 5/13/25 9:50 AM, Jeff Layton wrote:
> > Back in the 80's someone thought it was a good idea to carve out a set
> > of ports that only privileged users could use. When NFS was originally
> > conceived, Sun made its server require that clients use low ports.
> > Since Linux was following suit with Sun in those days, exportfs has
> > always defaulted to requiring connections from low ports.
> >
> > These days, anyone can be root on their laptop, so limiting connections
> > to low source ports is of little value.
> >
> > Make the default be "insecure" when creating exports.
> >
> > Signed-off-by: Jeff Layton <jlayton@kernel.org>
> > ---
> > In discussion at the Bake-a-thon, we decided to just go for making
> > "insecure" the default for all exports.
> > ---
> >   support/nfs/exports.c      | 7 +++++--
> >   utils/exportfs/exports.man | 4 ++--
> >   2 files changed, 7 insertions(+), 4 deletions(-)
> >
> > diff --git a/support/nfs/exports.c b/support/nfs/exports.c
> > index 21ec6486ba3d3945df0800972ba1dfd03bd65375..69f8ca8b5e2ed50b837ef287ca0685af3e70ed0b 100644
> > --- a/support/nfs/exports.c
> > +++ b/support/nfs/exports.c
> > @@ -34,8 +34,11 @@
> >   #include "reexport.h"
> >   #include "nfsd_path.h"
> >
> > -#define EXPORT_DEFAULT_FLAGS \
> > -  (NFSEXP_READONLY|NFSEXP_ROOTSQUASH|NFSEXP_GATHERED_WRITES|NFSEXP_NOSUBTREECHECK)
> > +#define EXPORT_DEFAULT_FLAGS (NFSEXP_READONLY |      \
> > +                              NFSEXP_ROOTSQUASH |    \
> > +                              NFSEXP_GATHERED_WRITES |\
> > +                              NFSEXP_NOSUBTREECHECK | \
> > +                              NFSEXP_INSECURE_PORT)
> >
> >   struct flav_info flav_map[] = {
> >       { "krb5",       RPC_AUTH_GSS_KRB5,      1},
> > diff --git a/utils/exportfs/exports.man b/utils/exportfs/exports.man
> > index 39dc30fb8290213990ca7a14b1b3971140b0d120..0b62bb3a82b0e74bc2a7eb84301c4ec97b14d003 100644
> > --- a/utils/exportfs/exports.man
> > +++ b/utils/exportfs/exports.man
> > @@ -180,8 +180,8 @@ understands the following export options:
> >   .TP
> >   .IR secure
> >   This option requires that requests not using gss originate on an
> > -Internet port less than IPPORT_RESERVED (1024). This option is on by default.
> > -To turn it off, specify
> > +Internet port less than IPPORT_RESERVED (1024). This option is off by default
> > +but can be explicitly disabled by specifying
> >   .IR insecure .
> >   (NOTE: older kernels (before upstream kernel version 4.17) enforced this
> >   requirement on gss requests as well.)
> >
> > ---
> > base-commit: 2cf015ea4312f37598efe9733fef3232ab67f784
> > change-id: 20250513-master-89974087bb04
> >
> > Best regards,
> My apologies but I got a bit lost in the fairly large thread
> What as is consensus on this patch? Thumbs up or down.

Thumbs up for a V2, which renames the darn option "resvport" and
"noresvport" (like Solaris, Windows, ...), and keeping
"insecure"+"secure" as a depreciated alias around.

Ced
-- 
Cedric Blancher <cedric.blancher@gmail.com>
[https://plus.google.com/u/0/+CedricBlancher/]
Institute Pasteur


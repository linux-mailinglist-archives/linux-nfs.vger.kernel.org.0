Return-Path: <linux-nfs+bounces-453-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D1249809537
	for <lists+linux-nfs@lfdr.de>; Thu,  7 Dec 2023 23:22:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7D58F28148E
	for <lists+linux-nfs@lfdr.de>; Thu,  7 Dec 2023 22:22:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A5BE840D1;
	Thu,  7 Dec 2023 22:22:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J/pkGmJA"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F412F10F1
	for <linux-nfs@vger.kernel.org>; Thu,  7 Dec 2023 14:22:03 -0800 (PST)
Received: by mail-lj1-x22f.google.com with SMTP id 38308e7fff4ca-2c9ebd15396so4133851fa.1
        for <linux-nfs@vger.kernel.org>; Thu, 07 Dec 2023 14:22:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701987722; x=1702592522; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TOuP/x0hSEhtnSfJ5820pzfgGeEk88kWyPwubHF8+0o=;
        b=J/pkGmJAPYAKLdQUIXVjVV0yrZohdzF7b7N/TVMCl1XX8S1R37f2c+E56i2392HFUT
         G/BEB1f7E9gSb5qCE0Atqr94xswnJn806D1tZm2bBMQX9B3hmkEkyslzD1IfHDrAQ1Yq
         JGfTWPF2aGmjwULJBwhWgB4J+rbpTrpQSuUAKKUV+2rLqxzSI6g4pyarQuacXpPXE+Ic
         VE8szwfEISJ9WLmYaYLBchS7Y72x7W4J0ZHv9KjTNRijbatrT/1iZV7Be3F6EbHTpKvL
         7b0dBMDGMUGdETQ32cz6uY6S39XQVAaDm1wnX3QcTokWzgvBu/PC3jql+oTHxkHQ77Vm
         oKDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701987722; x=1702592522;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TOuP/x0hSEhtnSfJ5820pzfgGeEk88kWyPwubHF8+0o=;
        b=lPLEjxwiDh7dQaJL4nrIdU77GXoDsECNVXt69m/s9Ac2lUTxEp5iTM8zarPWM3cgPx
         eYZat9ZOY3dZy1qR7XapLBY/i5GGCe0fiitGWBNljZIicSacfaKHErRF8XqvQTxUNPNJ
         Y6x4GoZEQr5nSbsfMDAd+BhKno7fl5mbcPRxMTeEQCcxf3VUOrMVQcoiXfXuEjxI6tZw
         5LVarT5cmwGLaUY7gHLmXQkrgkuoCcvbxETTR67okVkdAnKlzhz8ceq8aeyISML1YnyJ
         rFBBbK/avQsW3QWwmtOsvYJIc662Ft5qcyGf1oUNMJOWyVV+pq/c0wP167my24gfhL74
         3kjw==
X-Gm-Message-State: AOJu0Yx5kq3/czN9BFStKpygmScNsPjNIIGn+ngPdBsD8cZ09X0la2g9
	mJXD4PoGKa4jrcfZcjPIG3p1wH7JFgktcv8csVk=
X-Google-Smtp-Source: AGHT+IHiyNa+oIywM03smwqmQymPzA3cQvuPkgwCvasHvlXx5MR1LCPqroUl81zohU/3B3dqymNmH7aEo8hw2WCaGq0=
X-Received: by 2002:a2e:141e:0:b0:2c9:f0f3:937f with SMTP id
 u30-20020a2e141e000000b002c9f0f3937fmr4074677ljd.5.1701987721943; Thu, 07 Dec
 2023 14:22:01 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231206213332.55565-1-olga.kornievskaia@gmail.com>
 <20231206213332.55565-7-olga.kornievskaia@gmail.com> <ZXHaTIvFruYfycsm@tissot.1015granger.net>
In-Reply-To: <ZXHaTIvFruYfycsm@tissot.1015granger.net>
From: Olga Kornievskaia <olga.kornievskaia@gmail.com>
Date: Thu, 7 Dec 2023 17:21:50 -0500
Message-ID: <CAN-5tyFr7-eRP_wjrv_zOmsVC6ft1f1c+fNovbOXr0CVrtzfRw@mail.gmail.com>
Subject: Re: [PATCH 6/6] configure: check for rpc_gss_seccreate
To: Chuck Lever <chuck.lever@oracle.com>
Cc: steved@redhat.com, linux-nfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 7, 2023 at 9:44=E2=80=AFAM Chuck Lever <chuck.lever@oracle.com>=
 wrote:
>
> On Wed, Dec 06, 2023 at 04:33:32PM -0500, Olga Kornievskaia wrote:
> > From: Olga Kornievskaia <kolga@netapp.com>
> >
> > If we have rpc_gss_sccreate in tirpc library define
> > HAVE_TIRPC_GSS_SECCREATE, which would allow us to handle bad_integrity
> > errors.
> >
> > Signed-off-by: Olga Kornievskaia <kolga@netapp.com>
> > ---
> >  aclocal/libtirpc.m4 | 5 +++++
> >  1 file changed, 5 insertions(+)
> >
> > diff --git a/aclocal/libtirpc.m4 b/aclocal/libtirpc.m4
> > index bddae022..ef48a2ae 100644
> > --- a/aclocal/libtirpc.m4
> > +++ b/aclocal/libtirpc.m4
> > @@ -26,6 +26,11 @@ AC_DEFUN([AC_LIBTIRPC], [
> >                                      [Define to 1 if your tirpc library=
 provides libtirpc_set_debug])],,
> >                           [${LIBS}])])
> >
> > +     AS_IF([test -n "${LIBTIRPC}"],
> > +           [AC_CHECK_LIB([tirpc], [rpc_gss_seccreate],
> > +                         [AC_DEFINE([HAVE_TIRPC_GSS_SECCREATE], [1],
> > +                                    [Define to 1 if your tirpc library=
 provides rpc_gss_seccreate])],,
> > +                         [${LIBS}])])
> >    AC_SUBST([AM_CPPFLAGS])
> >    AC_SUBST(LIBTIRPC)
>
> It would be better for distributors if this checked that the local
> version of libtirpc has the rpc_gss_seccreate fix that you sent.
> The PKG_CHECK_MODULES macro should work for that, once you know the
> version number of libtirpc that will have that fix.
>
> Also, this patch should come either before "gssd: switch to using
> rpc_gss_seccreate()" or this change should be squashed into that
> patch, IMO.

I can certainly re-arrange the order (if Steve wants me to re-send an
ordered list).  I attempted to address your comment to  check for
existence of the function or fallback to the old way. I'm not sure I'm
capable of producing something that depends on distro versioning (or
am I supposed to be)? I think this goes back to me hoping that a
distro would create matching set of libtirpc and nfs-utils rpms...

Thank you for the reviews!

>
>
> --
> Chuck Lever


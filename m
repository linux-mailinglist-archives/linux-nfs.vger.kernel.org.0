Return-Path: <linux-nfs+bounces-463-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 931F680A566
	for <lists+linux-nfs@lfdr.de>; Fri,  8 Dec 2023 15:26:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3C0801F2129E
	for <lists+linux-nfs@lfdr.de>; Fri,  8 Dec 2023 14:26:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C16EB1DDFF;
	Fri,  8 Dec 2023 14:26:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KFnXenAY"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A15D198C
	for <linux-nfs@vger.kernel.org>; Fri,  8 Dec 2023 06:26:24 -0800 (PST)
Received: by mail-lj1-x232.google.com with SMTP id 38308e7fff4ca-2ca2281bcf4so5975081fa.0
        for <linux-nfs@vger.kernel.org>; Fri, 08 Dec 2023 06:26:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702045582; x=1702650382; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sD5rLqwBZM4r4R/ZG1+AX6Oy+x7KA79r3j7t1lGIuJo=;
        b=KFnXenAYPvgCmpSnjBGAVTFx+30aVlsg4cIWQ/tgix16gGyeW7hKw0M/I7chK6t1Ta
         +M9vXfUKAhZrN3EPdfHwBsaOMewZzv/hW9rVrc+W1NzbKhoCU9g/JRB/i/hnkxoSpeVE
         3yDQEfevP4Msp2eieIpwsoWNrDUjOHfbSGM73TJ7xatWNJb/0K3tRbD2UOH1JNPCBIOX
         Svg3ssLbu5A78iXhEyI+4JMLZaJOTN48aeHSLRk1w2T9Oh010pEp5IzWU5WpxOi80hVc
         mk8Ce/iottrobtZzBwY1OvkSuF+jdu6fzvtU5BRPuv3BHV6iXAEVq5oRYYftsNCvT/Rz
         PGCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702045582; x=1702650382;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sD5rLqwBZM4r4R/ZG1+AX6Oy+x7KA79r3j7t1lGIuJo=;
        b=DByLC7tmmLKoz2ORZWAEwMJ+0wW2W9foVFXN56GfofhMzvxQMzvg0YUon4KpXmBmDO
         HlOlsKJDFfBNHcu2VkqKk/ryJI41XA54X2MYHxKOFL39ly9n3pOz/O+flMF+nQIDQ5nj
         POJNWHoW+0UXjMyINAg5SZW/Zy0UH0meOMScbeLdYCz4OzduKzVOkpnajoVayNmnbagu
         grDm40ITEOCubnUcim34FOEOVS9lX5bKU5xsLJgp/vm19reL+Cw3oKLplh+2ule/j7iw
         94pbQqw0bPQfQZukibPy7j5HycL8Rff3mnK4700Z9dv+KFAJ454k2rg+OdQ6YHn63NPr
         qSAg==
X-Gm-Message-State: AOJu0YxR1HkC3c9luXy7lEJIpuDE/UvO2T2NAaPZ3CkcVLg3cTZQomjn
	79nD6fxQnFpIM+lWE9+8yA3tq1NL8WQjncBMsKL8QGIG
X-Google-Smtp-Source: AGHT+IEItQyOBAC7IE4xuHZrELrifjI5pbU017KgBb06ck064a7oRVckjUqUF+XLaN4JOHUO7tOmx9FXe6eO3cUahjM=
X-Received: by 2002:a2e:5c07:0:b0:2ca:18dc:ac29 with SMTP id
 q7-20020a2e5c07000000b002ca18dcac29mr5489579ljb.3.1702045582034; Fri, 08 Dec
 2023 06:26:22 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231206213332.55565-1-olga.kornievskaia@gmail.com>
 <20231206213332.55565-7-olga.kornievskaia@gmail.com> <ZXHaTIvFruYfycsm@tissot.1015granger.net>
 <CAN-5tyFr7-eRP_wjrv_zOmsVC6ft1f1c+fNovbOXr0CVrtzfRw@mail.gmail.com> <ZXJG2xyFUs9pzHlq@tissot.1015granger.net>
In-Reply-To: <ZXJG2xyFUs9pzHlq@tissot.1015granger.net>
From: Olga Kornievskaia <olga.kornievskaia@gmail.com>
Date: Fri, 8 Dec 2023 09:26:10 -0500
Message-ID: <CAN-5tyE_jBLJeW_JK0RScEDLF9jAZoi6upsM9aWRhtHPcYxHUQ@mail.gmail.com>
Subject: Re: [PATCH 6/6] configure: check for rpc_gss_seccreate
To: Chuck Lever <chuck.lever@oracle.com>
Cc: steved@redhat.com, linux-nfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 7, 2023 at 5:27=E2=80=AFPM Chuck Lever <chuck.lever@oracle.com>=
 wrote:
>
> On Thu, Dec 07, 2023 at 05:21:50PM -0500, Olga Kornievskaia wrote:
> > On Thu, Dec 7, 2023 at 9:44=E2=80=AFAM Chuck Lever <chuck.lever@oracle.=
com> wrote:
> > >
> > > On Wed, Dec 06, 2023 at 04:33:32PM -0500, Olga Kornievskaia wrote:
> > > > From: Olga Kornievskaia <kolga@netapp.com>
> > > >
> > > > If we have rpc_gss_sccreate in tirpc library define
> > > > HAVE_TIRPC_GSS_SECCREATE, which would allow us to handle bad_integr=
ity
> > > > errors.
> > > >
> > > > Signed-off-by: Olga Kornievskaia <kolga@netapp.com>
> > > > ---
> > > >  aclocal/libtirpc.m4 | 5 +++++
> > > >  1 file changed, 5 insertions(+)
> > > >
> > > > diff --git a/aclocal/libtirpc.m4 b/aclocal/libtirpc.m4
> > > > index bddae022..ef48a2ae 100644
> > > > --- a/aclocal/libtirpc.m4
> > > > +++ b/aclocal/libtirpc.m4
> > > > @@ -26,6 +26,11 @@ AC_DEFUN([AC_LIBTIRPC], [
> > > >                                      [Define to 1 if your tirpc lib=
rary provides libtirpc_set_debug])],,
> > > >                           [${LIBS}])])
> > > >
> > > > +     AS_IF([test -n "${LIBTIRPC}"],
> > > > +           [AC_CHECK_LIB([tirpc], [rpc_gss_seccreate],
> > > > +                         [AC_DEFINE([HAVE_TIRPC_GSS_SECCREATE], [1=
],
> > > > +                                    [Define to 1 if your tirpc lib=
rary provides rpc_gss_seccreate])],,
> > > > +                         [${LIBS}])])
> > > >    AC_SUBST([AM_CPPFLAGS])
> > > >    AC_SUBST(LIBTIRPC)
> > >
> > > It would be better for distributors if this checked that the local
> > > version of libtirpc has the rpc_gss_seccreate fix that you sent.
> > > The PKG_CHECK_MODULES macro should work for that, once you know the
> > > version number of libtirpc that will have that fix.
> > >
> > > Also, this patch should come either before "gssd: switch to using
> > > rpc_gss_seccreate()" or this change should be squashed into that
> > > patch, IMO.
> >
> > I can certainly re-arrange the order (if Steve wants me to re-send an
> > ordered list).  I attempted to address your comment to  check for
> > existence of the function or fallback to the old way.
>
> A comment that I made when I thought no changes to rpc_gss_seccreate(3t)
> would be needed.... But you found and fixed a bug there.
>
>
> > I'm not sure I'm
> > capable of producing something that depends on distro versioning (or
> > am I supposed to be)?
>
> I think this series truly needs to check the libtirpc version.
> Otherwise the build will complete successfully, gssd will use
> rpc_gss_seccreate(), but it will be broken.
>
> Grep for PKG_CHECK_MODULES in the other files in aclocal/ and you
> should find a pattern to use.

Yes but I won't know the version number of libtirpc (version or rpm
package) for which to check? It seems like libtirpc changes needs to
be checked in (btw I'm assuming a new version would need to be
generated), then (if that's it or libtirpc version and package version
are different things there might be more) this particular patch could
be generated. Isn't that correct?

Steve, I could really use your guidance on steps to be done here.

Thank you.

>
>
> > I think this goes back to me hoping that a
> > distro would create matching set of libtirpc and nfs-utils rpms...
>
> IME distros don't work that way.
>
>
> --
> Chuck Lever


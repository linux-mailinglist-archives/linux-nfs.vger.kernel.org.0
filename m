Return-Path: <linux-nfs+bounces-8271-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A9DC9DF056
	for <lists+linux-nfs@lfdr.de>; Sat, 30 Nov 2024 13:33:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 21D932821CC
	for <lists+linux-nfs@lfdr.de>; Sat, 30 Nov 2024 12:33:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A41761531E6;
	Sat, 30 Nov 2024 12:33:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Um+t7c2l"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D6F614A4C6
	for <linux-nfs@vger.kernel.org>; Sat, 30 Nov 2024 12:33:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732969988; cv=none; b=hP12w32TJ3oGPiLfk+hXQNXpg3fAjYuKwMz8BXFiwzTLAfdxvmgZG3kBXgjna9FL1Ul5VAwALhs6gPWzdEdPh0xYRk/YmGwkumzMRFpAPPedPCj+TYKtPjWYQQMzFanHIjX4qkltzgNmqsRk+LzBQfVXros8ZnF9Rum9lKLrc8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732969988; c=relaxed/simple;
	bh=Kjxgv7tnUjGPeAr41QYzgBD9LIb7ZDcsJmC9f5ujuU8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=heK2/TS9S9AYYVMhrMGMzpeY3E3mBqOWwvinjAQHj5FQKaurXDB00FJ2LU6YjjB5wf2uIwTNHns/IwBLiwoM9EeKpQdLgwX4+XiVhDyBqU8eTxYK3yuFogv10vBTB7Ryh0jDfTRYAG5WxsFCgmtN+lS2L9uGxXY6MHFc0s2gCO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Um+t7c2l; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-434a1639637so25149685e9.1
        for <linux-nfs@vger.kernel.org>; Sat, 30 Nov 2024 04:33:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732969985; x=1733574785; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FwCPcfyY7iHIFrM6tR/M+ImOUJCVw9GN8+kt0+Wl1Jg=;
        b=Um+t7c2lH3zMzrMu7znECafRjAnD2Incxkh+8pDmcUFxf9snuzk585QnTX7ZOt2bxM
         UKmWa1WYjrX4Liz/Limd3KZT/eHOC1xhmv8kFrUv3EvB6brd98DyuY9bUC7MBdw1FzBC
         E3UnI3E+XDp2dTIdAskwMJ6g4CFoQ/JB7iZs09ZdjUnLB+gd5N33klTo+mxeke9yxyS9
         lWUCJNpfxWaD80yXUaSC4bNit7lOFRMHLia42fyanRDs+jXIIxqZ1x4XlTEHXRf7Wa4O
         BWm17ODvjBeodp07cZJDxenMWxzyZQ2mUfdqqmx6sMYrunX7nBy/dXaQUGFoDTNV+jdA
         q5Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732969985; x=1733574785;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FwCPcfyY7iHIFrM6tR/M+ImOUJCVw9GN8+kt0+Wl1Jg=;
        b=LHTODiWUuGjTbtWHX0WKOWY8lVVQfW6hyVEjmCKA6uza674M7eYarvgyamQJFULjSO
         yjYP12tMhT8oP1PrjfuhNPnTM3v2KZsPPn/7J/ECq24Mjf7WPstSZm1qOoJpsoIflhau
         d67Qim3Hh3P1WVK/T6ieS0IirL0MSQADsrqHvkF+WjN8ggTTuyyGl2B3VRDHajrfcdrV
         kIUWF7NG5DrSngCyA6Q5E/OLlfgPXU+24dwtZKG+B3rhq6fdg4asEyrPPHKe5z0l/ARz
         hz6LYoUl0mqBy4Ey0CXDAzIupuFr/uhdIRckLN6U8Z70h3BdX0I68OgDBADFg5+si2yS
         X8ng==
X-Gm-Message-State: AOJu0YwIjLXb8leX8X4yaG8BfO/vhYqmiEpQSCPeeVSA5xbe9pSROl8L
	RDARG7kDqSYcWvrHH3kUrenzgqFNwd7/699UpUP78UzwnWZ+6/BAsi4jr0wuqqXeoVhEFnMsPaa
	aFjXwSrQD0tUeq9VGbbPo307H/Gg=
X-Gm-Gg: ASbGnctEn+c94M1pG0bR4e2ppNiDgDA8wlLz5uuJEVVxV9uj5MSf3SG1Ut+9JYj9DrW
	95lGM7U35MAYkRmCKFDFUPSBqENd7AtaDcg==
X-Google-Smtp-Source: AGHT+IFyv/JJqzjbkQahi030jDjwkViHyhcK5V5ithxbTxMppekFwWpyWVTkK89sjLzi3uuaLMC1HIVvTCKZxAaaWqI=
X-Received: by 2002:a05:600c:4fc9:b0:434:a6af:79f6 with SMTP id
 5b1f17b1804b1-434a9dc7074mr153651335e9.15.1732969984539; Sat, 30 Nov 2024
 04:33:04 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240530071725.70043-1-b.tataroiu@gmail.com> <d7165359-a031-456e-bfae-a45d0aed5d80@redhat.com>
 <fbd5e08d-3975-48e8-90b6-325628cb1b85@redhat.com>
In-Reply-To: <fbd5e08d-3975-48e8-90b6-325628cb1b85@redhat.com>
From: =?UTF-8?B?Qm9nZGFuLUNyaXN0aWFuIFTEg3TEg3JvaXU=?= <b.tataroiu@gmail.com>
Date: Sat, 30 Nov 2024 12:32:38 +0000
Message-ID: <CAC=XK8Nk_odMwvwXrj9suXCayni-pVnzTga0aV9tn-B-3=ia9g@mail.gmail.com>
Subject: Re: [PATCH] Add guards around [nfsidmap] usages of [sysconf].
To: Steve Dickson <steved@redhat.com>
Cc: linux-nfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hey Steve,

My apologies for dropping this.

I'm a bit confused since the man page for sysconf [1] seems to say it
returns -1 and sets errno to EINVAL (and indeed the patch I originally
submitted shows the intended behaviour on my musl system).

The snippet in the newly defined [get_pwnam_buflen] is pretty much
just what's in the [getpwnam] man page [2] example.

Maybe the thing you're pointing to is that I have [*size_t* buflen =3D
sysconf(_SC_GETPW_R_SIZE_MAX)].
I guess that should technically be [long buflen] and the result could
be converted to [size_t] upon return, it's just that the implicit
conversions make it such that the current code behaves as expected.

So something like

     long buflen =3D sysconf(_SC_GETPW_R_SIZE_MAX);
     if (buflen =3D=3D -1)
         buflen =3D 16384;
     return (size_t)buflen;

Does that make more sense?

[1] https://www.man7.org/linux/man-pages/man3/sysconf.3.html
[2] https://www.man7.org/linux/man-pages/man3/getpwnam.3.html

Best,
Bogdan

On Sat, Nov 9, 2024 at 6:25=E2=80=AFPM Steve Dickson <steved@redhat.com> wr=
ote:
>
>
>
> On 6/17/24 2:51 PM, Steve Dickson wrote:
> >
> >
> > On 5/30/24 2:17 AM, Bogdan-Cristian T=C4=83t=C4=83roiu wrote:
> >> sysconf(_SC_GETPW_R_SIZE_MAX) and sysconf(_SC_GETGR_R_SIZE_MAX)
> >> return -1 on musl, which causes either segmentation faults or ENOMEM
> >> errors.
> > Actually sysconf() returns EINVAL not -1 since the return
> > value is a size_t (unsigned long). So I needed to change
> >
> >      size_t buflen =3D sysconf(_SC_GETPW_R_SIZE_MAX);
> >      if (buflen =3D=3D EINVAL) <<< this from -1 to EINVAL
> >          buflen =3D 16384;
> >      return buflen;
> >
> > Good with that? Will this work with musl?
> Just found this on my todo list... Still
> interest in  have these patch committed?
>
> steved.
>
> >
> > steved.
> >
> >>
> >> Replace all usages of sysconf with dedicated methods that guard agains=
t
> >> a result of -1.
> >>
> >> Signed-off-by: Bogdan-Cristian T=C4=83t=C4=83roiu <b.tataroiu@gmail.co=
m>
> >> ---
> >>   support/nfsidmap/gums.c             |  4 ++--
> >>   support/nfsidmap/libnfsidmap.c      |  4 ++--
> >>   support/nfsidmap/nfsidmap_common.c  | 16 ++++++++++++++++
> >>   support/nfsidmap/nfsidmap_private.h |  2 ++
> >>   support/nfsidmap/nss.c              |  8 ++++----
> >>   support/nfsidmap/regex.c            |  9 +++++----
> >>   support/nfsidmap/static.c           |  5 +++--
> >>   7 files changed, 34 insertions(+), 14 deletions(-)
> >>
> >> diff --git a/support/nfsidmap/gums.c b/support/nfsidmap/gums.c
> >> index 1d6eb318..e94a4c50 100644
> >> --- a/support/nfsidmap/gums.c
> >> +++ b/support/nfsidmap/gums.c
> >> @@ -475,7 +475,7 @@ static int translate_to_uid(char *local_uid, uid_t
> >> *uid, uid_t *gid)
> >>       int ret =3D -1;
> >>       struct passwd *pw =3D NULL;
> >>       struct pwbuf *buf =3D NULL;
> >> -    size_t buflen =3D sysconf(_SC_GETPW_R_SIZE_MAX);
> >> +    size_t buflen =3D get_pwnam_buflen();
> >>       buf =3D malloc(sizeof(*buf) + buflen);
> >>       if (buf =3D=3D NULL)
> >> @@ -501,7 +501,7 @@ static int translate_to_gid(char *local_gid, uid_t
> >> *gid)
> >>       struct group *gr =3D NULL;
> >>       struct group grbuf;
> >>       char *buf =3D NULL;
> >> -    size_t buflen =3D sysconf(_SC_GETGR_R_SIZE_MAX);
> >> +    size_t buflen =3D get_grnam_buflen();
> >>       int ret =3D -1;
> >>       do {
> >> diff --git a/support/nfsidmap/libnfsidmap.c b/support/nfsidmap/
> >> libnfsidmap.c
> >> index f8c36480..e1475879 100644
> >> --- a/support/nfsidmap/libnfsidmap.c
> >> +++ b/support/nfsidmap/libnfsidmap.c
> >> @@ -457,7 +457,7 @@ int nfs4_init_name_mapping(char *conffile)
> >>       nobody_user =3D conf_get_str("Mapping", "Nobody-User");
> >>       if (nobody_user) {
> >> -        size_t buflen =3D sysconf(_SC_GETPW_R_SIZE_MAX);
> >> +        size_t buflen =3D get_pwnam_buflen();
> >>           struct passwd *buf;
> >>           struct passwd *pw =3D NULL;
> >>           int err;
> >> @@ -478,7 +478,7 @@ int nfs4_init_name_mapping(char *conffile)
> >>       nobody_group =3D conf_get_str("Mapping", "Nobody-Group");
> >>       if (nobody_group) {
> >> -        size_t buflen =3D sysconf(_SC_GETGR_R_SIZE_MAX);
> >> +        size_t buflen =3D get_grnam_buflen();
> >>           struct group *buf;
> >>           struct group *gr =3D NULL;
> >>           int err;
> >> diff --git a/support/nfsidmap/nfsidmap_common.c b/support/nfsidmap/
> >> nfsidmap_common.c
> >> index 4d2cb14f..310c68f0 100644
> >> --- a/support/nfsidmap/nfsidmap_common.c
> >> +++ b/support/nfsidmap/nfsidmap_common.c
> >> @@ -116,3 +116,19 @@ int get_reformat_group(void)
> >>       return reformat_group;
> >>   }
> >> +
> >> +size_t get_pwnam_buflen(void)
> >> +{
> >> +    size_t buflen =3D sysconf(_SC_GETPW_R_SIZE_MAX);
> >> +    if (buflen =3D=3D -1)
> >> +        buflen =3D 16384;
> >> +    return buflen;
> >> +}
> >> +
> >> +size_t get_grnam_buflen(void)
> >> +{
> >> +    size_t buflen =3D sysconf(_SC_GETGR_R_SIZE_MAX);
> >> +    if (buflen =3D=3D -1)
> >> +        buflen =3D 16384;
> >> +    return buflen;
> >> +}
> >> diff --git a/support/nfsidmap/nfsidmap_private.h b/support/nfsidmap/
> >> nfsidmap_private.h
> >> index a5cb6dda..234ca9d4 100644
> >> --- a/support/nfsidmap/nfsidmap_private.h
> >> +++ b/support/nfsidmap/nfsidmap_private.h
> >> @@ -40,6 +40,8 @@ struct conf_list *get_local_realms(void);
> >>   void free_local_realms(void);
> >>   int get_nostrip(void);
> >>   int get_reformat_group(void);
> >> +size_t get_pwnam_buflen(void);
> >> +size_t get_grnam_buflen(void);
> >>   typedef enum {
> >>       IDTYPE_USER =3D 1,
> >> diff --git a/support/nfsidmap/nss.c b/support/nfsidmap/nss.c
> >> index 0f43076e..3fc045dc 100644
> >> --- a/support/nfsidmap/nss.c
> >> +++ b/support/nfsidmap/nss.c
> >> @@ -91,7 +91,7 @@ static int nss_uid_to_name(uid_t uid, char *domain,
> >> char *name, size_t len)
> >>       struct passwd *pw =3D NULL;
> >>       struct passwd pwbuf;
> >>       char *buf;
> >> -    size_t buflen =3D sysconf(_SC_GETPW_R_SIZE_MAX);
> >> +    size_t buflen =3D get_pwnam_buflen();
> >>       int err =3D -ENOMEM;
> >>       buf =3D malloc(buflen);
> >> @@ -119,7 +119,7 @@ static int nss_gid_to_name(gid_t gid, char
> >> *domain, char *name, size_t len)
> >>       struct group *gr =3D NULL;
> >>       struct group grbuf;
> >>       char *buf;
> >> -    size_t buflen =3D sysconf(_SC_GETGR_R_SIZE_MAX);
> >> +    size_t buflen =3D get_grnam_buflen();
> >>       int err;
> >>       if (domain =3D=3D NULL)
> >> @@ -192,7 +192,7 @@ static struct passwd *nss_getpwnam(const char
> >> *name, const char *domain,
> >>   {
> >>       struct passwd *pw;
> >>       struct pwbuf *buf;
> >> -    size_t buflen =3D sysconf(_SC_GETPW_R_SIZE_MAX);
> >> +    size_t buflen =3D get_pwnam_buflen();
> >>       char *localname;
> >>       int err =3D ENOMEM;
> >> @@ -301,7 +301,7 @@ static int _nss_name_to_gid(char *name, gid_t
> >> *gid, int dostrip)
> >>       struct group *gr =3D NULL;
> >>       struct group grbuf;
> >>       char *buf, *domain;
> >> -    size_t buflen =3D sysconf(_SC_GETGR_R_SIZE_MAX);
> >> +    size_t buflen =3D get_grnam_buflen();
> >>       int err =3D -EINVAL;
> >>       char *localname =3D NULL;
> >>       char *ref_name =3D NULL;
> >> diff --git a/support/nfsidmap/regex.c b/support/nfsidmap/regex.c
> >> index 8424179f..ea094b95 100644
> >> --- a/support/nfsidmap/regex.c
> >> +++ b/support/nfsidmap/regex.c
> >> @@ -46,6 +46,7 @@
> >>   #include "nfsidmap.h"
> >>   #include "nfsidmap_plugin.h"
> >> +#include "nfsidmap_private.h"
> >>   #define CONFIG_GET_STRING nfsidmap_config_get
> >>   extern const char *nfsidmap_config_get(const char *, const char *);
> >> @@ -95,7 +96,7 @@ static struct passwd *regex_getpwnam(const char
> >> *name, const char *UNUSED(domain
> >>   {
> >>       struct passwd *pw;
> >>       struct pwbuf *buf;
> >> -    size_t buflen =3D sysconf(_SC_GETPW_R_SIZE_MAX);
> >> +    size_t buflen =3D get_pwnam_buflen();
> >>       char *localname;
> >>       size_t namelen;
> >>       int err;
> >> @@ -175,7 +176,7 @@ static struct group *regex_getgrnam(const char
> >> *name, const char *UNUSED(domain)
> >>   {
> >>       struct group *gr;
> >>       struct grbuf *buf;
> >> -    size_t buflen =3D sysconf(_SC_GETGR_R_SIZE_MAX);
> >> +    size_t buflen =3D get_grnam_buflen();
> >>       char *localgroup;
> >>       char *groupname;
> >>       size_t namelen;
> >> @@ -366,7 +367,7 @@ static int regex_uid_to_name(uid_t uid, char
> >> *domain, char *name, size_t len)
> >>       struct passwd *pw =3D NULL;
> >>       struct passwd pwbuf;
> >>       char *buf;
> >> -    size_t buflen =3D sysconf(_SC_GETPW_R_SIZE_MAX);
> >> +    size_t buflen =3D get_pwnam_buflen();
> >>       int err =3D -ENOMEM;
> >>       buf =3D malloc(buflen);
> >> @@ -392,7 +393,7 @@ static int regex_gid_to_name(gid_t gid, char
> >> *UNUSED(domain), char *name, size_t
> >>       struct group grbuf;
> >>       char *buf;
> >>       const char *name_prefix;
> >> -    size_t buflen =3D sysconf(_SC_GETGR_R_SIZE_MAX);
> >> +    size_t buflen =3D get_grnam_buflen();
> >>       int err;
> >>       char * groupname =3D NULL;
> >> diff --git a/support/nfsidmap/static.c b/support/nfsidmap/static.c
> >> index 8ac4a398..395cac06 100644
> >> --- a/support/nfsidmap/static.c
> >> +++ b/support/nfsidmap/static.c
> >> @@ -44,6 +44,7 @@
> >>   #include "conffile.h"
> >>   #include "nfsidmap.h"
> >>   #include "nfsidmap_plugin.h"
> >> +#include "nfsidmap_private.h"
> >>   /*
> >>    * Static Translation Methods
> >> @@ -98,7 +99,7 @@ static struct passwd *static_getpwnam(const char *na=
me,
> >>   {
> >>       struct passwd *pw;
> >>       struct pwbuf *buf;
> >> -    size_t buflen =3D sysconf(_SC_GETPW_R_SIZE_MAX);
> >> +    size_t buflen =3D get_pwnam_buflen();
> >>       char *localname;
> >>       int err;
> >> @@ -149,7 +150,7 @@ static struct group *static_getgrnam(const char
> >> *name,
> >>   {
> >>       struct group *gr;
> >>       struct grbuf *buf;
> >> -    size_t buflen =3D sysconf(_SC_GETGR_R_SIZE_MAX);
> >> +    size_t buflen =3D get_grnam_buflen();
> >>       char *localgroup;
> >>       int err;
>


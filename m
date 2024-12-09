Return-Path: <linux-nfs+bounces-8451-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 20FF69E9021
	for <lists+linux-nfs@lfdr.de>; Mon,  9 Dec 2024 11:29:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EAE9816300F
	for <lists+linux-nfs@lfdr.de>; Mon,  9 Dec 2024 10:29:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B02652165F5;
	Mon,  9 Dec 2024 10:29:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YAyXWywy"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF1D4216380
	for <linux-nfs@vger.kernel.org>; Mon,  9 Dec 2024 10:29:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733740157; cv=none; b=KRDCPc2nJs5MK2pNMOVuyDuhMEFYG12Mux4y3Vd5/1ySsFc0w36KXMonBbtbsCJseq6fr1hFbxUkcjOyvzPQAjC4Md4n1aVVkVgj+8VRQEP8ZbqqnrTcHV+eLWYtSkjM4RiWvXi80xZ4o3ZTI7+Uh4H+/AK/Iuvagg9UldzPnQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733740157; c=relaxed/simple;
	bh=MVd/sHDUd7l+Rlap2xMZ1oADDaQ9VgzGXCTWooAPvxM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rFV/fhtqRkc1fJilWyVRxyV6WBVM5DbArAE6dJNR+xkZ3EDOuqG3EnSAKGWaVtcaR75GAh3olypznhHkjE9lZswIPKfiVhCYGsrq7w9d5fpwZGwz+OIZnmOqWM9R/mx/GESoEI9E2fAU7NcYyDOLxAQCy1lKHTfdaF3l5dBTIdA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YAyXWywy; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-385e27c75f4so3195234f8f.2
        for <linux-nfs@vger.kernel.org>; Mon, 09 Dec 2024 02:29:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733740154; x=1734344954; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DYOdnayKG4Tf3NGz2WMBy4WPANqGavkTNgEQsNw6uBc=;
        b=YAyXWywy7ITHz4Wsvjrv4BqT76+IfZaO1xrKEqlwnI14blJuN83ware75Gg20a28rH
         4TXWmP0Z6XgY03+BEhQBBVpG6p30gqFmPN0gj5yqzdW+93X4ck1VxzSWdUAhCY5uDA8z
         m++leLlWB+sCzsSt6lQ/gT4JrTmcOEZrXRNGBA8J7vmYw9tIsSOo4jhZe6GPdZnNDw2r
         XRORtr2v/KQJ+l237OTMaeZosqxm1U34MmyUdpdhXvuBI67JNMk0P1pupoE2x2Ezkih7
         G/tI/6yazueZDMNeJEPg3qRcvh7PB+/fd5TvZ1nCZf1QNSJ/PXnd29I+UAQtRyjtdFqn
         C0AQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733740154; x=1734344954;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DYOdnayKG4Tf3NGz2WMBy4WPANqGavkTNgEQsNw6uBc=;
        b=qNAI0I394nnuZ/TJlRM4TxnxyDWCNhelDmTPA53l9vnLuqq5DxaJZxeXERBajJ4fj7
         ZuUWVxhAwIZcWLpsPBaeT5r5v6Am883frnxbzFRMJcgrf3X3ouAetjPLoUC8+Htg1p4u
         ulYkmV4cYTCeW+s56UsnWK/BYijZqduiExjQW5Foy1S93nzME4hKrxh9JLvrehXud8QY
         q/3mlKEC/EGAlA427kmH9UmWOHbyVMVed3UcVYrsz9WomzP19VbTsiE+ik36QENlaxtJ
         DdLPZdb9J8QsBM0TdVrIpaZMbjKkCRzJYlyWkvevIfpZ7ZT455djrXPcJ99L0yMUSflp
         V+9Q==
X-Gm-Message-State: AOJu0Ywag/WrlQ6taubNWG8uQ74S+IWz7WzAP6JMSd2GJAavKiO5VPQ5
	T3yVwQslfohOKniunnkJyUenV6eM1VK+OU3cSe9WIzXKJ6iFUg6XrLo1PtI+AL77kd6McYKcQ3o
	lPZrTjU0+LlFM4RtjEytBX1K0ZPahyMVoT4z95Q==
X-Gm-Gg: ASbGnct/V0HOSqbMRWaPKEc/TScMuc4sd4aHXpQXmvTM0Xt21G68I+YrTsaVGs2zjzK
	bFjpeoURYsNiWj5zcJCRHxOwxDuq6kmIOmw==
X-Google-Smtp-Source: AGHT+IGRRvu+2Njj67orGYY9d4PAtsZGRE7YhgjyMFze4/c/4QZ2/o2w8dPSNL938jBfox349UQpHMRxoL4W/Ce+kf4=
X-Received: by 2002:a5d:6dab:0:b0:386:3262:28c6 with SMTP id
 ffacd0b85a97d-38632622926mr5307637f8f.5.1733740153720; Mon, 09 Dec 2024
 02:29:13 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241201153637.449538-1-b.tataroiu@gmail.com> <354319ae-76d7-40d4-a713-3bb569579e5c@redhat.com>
In-Reply-To: <354319ae-76d7-40d4-a713-3bb569579e5c@redhat.com>
From: =?UTF-8?B?Qm9nZGFuLUNyaXN0aWFuIFTEg3TEg3JvaXU=?= <b.tataroiu@gmail.com>
Date: Mon, 9 Dec 2024 10:28:47 +0000
Message-ID: <CAC=XK8MLEg=X0gPVv_B-qz0JpR_Dx+S8wLdR96WXU4cHGKGbkQ@mail.gmail.com>
Subject: Re: [PATCH V2] Add guards around [nfsidmap] usages of [sysconf].
To: Steve Dickson <steved@redhat.com>
Cc: Linux NFS Mailing list <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thank you!

Bogdan

On Mon, Dec 9, 2024 at 10:27=E2=80=AFAM Steve Dickson <steved@redhat.com> w=
rote:
>
>
>
> On 12/1/24 10:36 AM, Bogdan-Cristian Ttroiu wrote:
> > From: Bogdan-Cristian T=C4=83t=C4=83roiu <b.tataroiu@gmail.com>
> >
> > sysconf(_SC_GETPW_R_SIZE_MAX) and sysconf(_SC_GETGR_R_SIZE_MAX)
> > return -1 on musl, which causes either segmentation faults or ENOMEM
> > errors.
> >
> > Replace all usages of sysconf with dedicated methods that guard against
> > a result of -1.
> Committed... (tag: nfs-utils-2-8-2-rc4)
>
> steved.
>
> > ---
> >   support/nfsidmap/gums.c             |  4 ++--
> >   support/nfsidmap/libnfsidmap.c      |  4 ++--
> >   support/nfsidmap/nfsidmap_common.c  | 16 ++++++++++++++++
> >   support/nfsidmap/nfsidmap_private.h |  2 ++
> >   support/nfsidmap/nss.c              |  8 ++++----
> >   support/nfsidmap/regex.c            |  9 +++++----
> >   support/nfsidmap/static.c           |  5 +++--
> >   7 files changed, 34 insertions(+), 14 deletions(-)
> >
> > diff --git a/support/nfsidmap/gums.c b/support/nfsidmap/gums.c
> > index 1d6eb318..e94a4c50 100644
> > --- a/support/nfsidmap/gums.c
> > +++ b/support/nfsidmap/gums.c
> > @@ -475,7 +475,7 @@ static int translate_to_uid(char *local_uid, uid_t =
*uid, uid_t *gid)
> >       int ret =3D -1;
> >       struct passwd *pw =3D NULL;
> >       struct pwbuf *buf =3D NULL;
> > -     size_t buflen =3D sysconf(_SC_GETPW_R_SIZE_MAX);
> > +     size_t buflen =3D get_pwnam_buflen();
> >
> >       buf =3D malloc(sizeof(*buf) + buflen);
> >       if (buf =3D=3D NULL)
> > @@ -501,7 +501,7 @@ static int translate_to_gid(char *local_gid, uid_t =
*gid)
> >       struct group *gr =3D NULL;
> >       struct group grbuf;
> >       char *buf =3D NULL;
> > -     size_t buflen =3D sysconf(_SC_GETGR_R_SIZE_MAX);
> > +     size_t buflen =3D get_grnam_buflen();
> >       int ret =3D -1;
> >
> >       do {
> > diff --git a/support/nfsidmap/libnfsidmap.c b/support/nfsidmap/libnfsid=
map.c
> > index f8c36480..e1475879 100644
> > --- a/support/nfsidmap/libnfsidmap.c
> > +++ b/support/nfsidmap/libnfsidmap.c
> > @@ -457,7 +457,7 @@ int nfs4_init_name_mapping(char *conffile)
> >
> >       nobody_user =3D conf_get_str("Mapping", "Nobody-User");
> >       if (nobody_user) {
> > -             size_t buflen =3D sysconf(_SC_GETPW_R_SIZE_MAX);
> > +             size_t buflen =3D get_pwnam_buflen();
> >               struct passwd *buf;
> >               struct passwd *pw =3D NULL;
> >               int err;
> > @@ -478,7 +478,7 @@ int nfs4_init_name_mapping(char *conffile)
> >
> >       nobody_group =3D conf_get_str("Mapping", "Nobody-Group");
> >       if (nobody_group) {
> > -             size_t buflen =3D sysconf(_SC_GETGR_R_SIZE_MAX);
> > +             size_t buflen =3D get_grnam_buflen();
> >               struct group *buf;
> >               struct group *gr =3D NULL;
> >               int err;
> > diff --git a/support/nfsidmap/nfsidmap_common.c b/support/nfsidmap/nfsi=
dmap_common.c
> > index 4d2cb14f..1d5b542b 100644
> > --- a/support/nfsidmap/nfsidmap_common.c
> > +++ b/support/nfsidmap/nfsidmap_common.c
> > @@ -116,3 +116,19 @@ int get_reformat_group(void)
> >
> >       return reformat_group;
> >   }
> > +
> > +size_t get_pwnam_buflen(void)
> > +{
> > +     long buflen =3D sysconf(_SC_GETPW_R_SIZE_MAX);
> > +     if (buflen =3D=3D -1)
> > +             buflen =3D 16384;
> > +     return (size_t)buflen;
> > +}
> > +
> > +size_t get_grnam_buflen(void)
> > +{
> > +     long buflen =3D sysconf(_SC_GETGR_R_SIZE_MAX);
> > +     if (buflen =3D=3D -1)
> > +             buflen =3D 16384;
> > +     return (size_t)buflen;
> > +}
> > diff --git a/support/nfsidmap/nfsidmap_private.h b/support/nfsidmap/nfs=
idmap_private.h
> > index a5cb6dda..234ca9d4 100644
> > --- a/support/nfsidmap/nfsidmap_private.h
> > +++ b/support/nfsidmap/nfsidmap_private.h
> > @@ -40,6 +40,8 @@ struct conf_list *get_local_realms(void);
> >   void free_local_realms(void);
> >   int get_nostrip(void);
> >   int get_reformat_group(void);
> > +size_t get_pwnam_buflen(void);
> > +size_t get_grnam_buflen(void);
> >
> >   typedef enum {
> >       IDTYPE_USER =3D 1,
> > diff --git a/support/nfsidmap/nss.c b/support/nfsidmap/nss.c
> > index 0f43076e..3fc045dc 100644
> > --- a/support/nfsidmap/nss.c
> > +++ b/support/nfsidmap/nss.c
> > @@ -91,7 +91,7 @@ static int nss_uid_to_name(uid_t uid, char *domain, c=
har *name, size_t len)
> >       struct passwd *pw =3D NULL;
> >       struct passwd pwbuf;
> >       char *buf;
> > -     size_t buflen =3D sysconf(_SC_GETPW_R_SIZE_MAX);
> > +     size_t buflen =3D get_pwnam_buflen();
> >       int err =3D -ENOMEM;
> >
> >       buf =3D malloc(buflen);
> > @@ -119,7 +119,7 @@ static int nss_gid_to_name(gid_t gid, char *domain,=
 char *name, size_t len)
> >       struct group *gr =3D NULL;
> >       struct group grbuf;
> >       char *buf;
> > -     size_t buflen =3D sysconf(_SC_GETGR_R_SIZE_MAX);
> > +     size_t buflen =3D get_grnam_buflen();
> >       int err;
> >
> >       if (domain =3D=3D NULL)
> > @@ -192,7 +192,7 @@ static struct passwd *nss_getpwnam(const char *name=
, const char *domain,
> >   {
> >       struct passwd *pw;
> >       struct pwbuf *buf;
> > -     size_t buflen =3D sysconf(_SC_GETPW_R_SIZE_MAX);
> > +     size_t buflen =3D get_pwnam_buflen();
> >       char *localname;
> >       int err =3D ENOMEM;
> >
> > @@ -301,7 +301,7 @@ static int _nss_name_to_gid(char *name, gid_t *gid,=
 int dostrip)
> >       struct group *gr =3D NULL;
> >       struct group grbuf;
> >       char *buf, *domain;
> > -     size_t buflen =3D sysconf(_SC_GETGR_R_SIZE_MAX);
> > +     size_t buflen =3D get_grnam_buflen();
> >       int err =3D -EINVAL;
> >       char *localname =3D NULL;
> >       char *ref_name =3D NULL;
> > diff --git a/support/nfsidmap/regex.c b/support/nfsidmap/regex.c
> > index 8424179f..ea094b95 100644
> > --- a/support/nfsidmap/regex.c
> > +++ b/support/nfsidmap/regex.c
> > @@ -46,6 +46,7 @@
> >
> >   #include "nfsidmap.h"
> >   #include "nfsidmap_plugin.h"
> > +#include "nfsidmap_private.h"
> >
> >   #define CONFIG_GET_STRING nfsidmap_config_get
> >   extern const char *nfsidmap_config_get(const char *, const char *);
> > @@ -95,7 +96,7 @@ static struct passwd *regex_getpwnam(const char *name=
, const char *UNUSED(domain
> >   {
> >       struct passwd *pw;
> >       struct pwbuf *buf;
> > -     size_t buflen =3D sysconf(_SC_GETPW_R_SIZE_MAX);
> > +     size_t buflen =3D get_pwnam_buflen();
> >       char *localname;
> >       size_t namelen;
> >       int err;
> > @@ -175,7 +176,7 @@ static struct group *regex_getgrnam(const char *nam=
e, const char *UNUSED(domain)
> >   {
> >       struct group *gr;
> >       struct grbuf *buf;
> > -     size_t buflen =3D sysconf(_SC_GETGR_R_SIZE_MAX);
> > +     size_t buflen =3D get_grnam_buflen();
> >       char *localgroup;
> >       char *groupname;
> >       size_t namelen;
> > @@ -366,7 +367,7 @@ static int regex_uid_to_name(uid_t uid, char *domai=
n, char *name, size_t len)
> >       struct passwd *pw =3D NULL;
> >       struct passwd pwbuf;
> >       char *buf;
> > -     size_t buflen =3D sysconf(_SC_GETPW_R_SIZE_MAX);
> > +     size_t buflen =3D get_pwnam_buflen();
> >       int err =3D -ENOMEM;
> >
> >       buf =3D malloc(buflen);
> > @@ -392,7 +393,7 @@ static int regex_gid_to_name(gid_t gid, char *UNUSE=
D(domain), char *name, size_t
> >       struct group grbuf;
> >       char *buf;
> >       const char *name_prefix;
> > -     size_t buflen =3D sysconf(_SC_GETGR_R_SIZE_MAX);
> > +     size_t buflen =3D get_grnam_buflen();
> >       int err;
> >       char * groupname =3D NULL;
> >
> > diff --git a/support/nfsidmap/static.c b/support/nfsidmap/static.c
> > index 8ac4a398..395cac06 100644
> > --- a/support/nfsidmap/static.c
> > +++ b/support/nfsidmap/static.c
> > @@ -44,6 +44,7 @@
> >   #include "conffile.h"
> >   #include "nfsidmap.h"
> >   #include "nfsidmap_plugin.h"
> > +#include "nfsidmap_private.h"
> >
> >   /*
> >    * Static Translation Methods
> > @@ -98,7 +99,7 @@ static struct passwd *static_getpwnam(const char *nam=
e,
> >   {
> >       struct passwd *pw;
> >       struct pwbuf *buf;
> > -     size_t buflen =3D sysconf(_SC_GETPW_R_SIZE_MAX);
> > +     size_t buflen =3D get_pwnam_buflen();
> >       char *localname;
> >       int err;
> >
> > @@ -149,7 +150,7 @@ static struct group *static_getgrnam(const char *na=
me,
> >   {
> >       struct group *gr;
> >       struct grbuf *buf;
> > -     size_t buflen =3D sysconf(_SC_GETGR_R_SIZE_MAX);
> > +     size_t buflen =3D get_grnam_buflen();
> >       char *localgroup;
> >       int err;
> >
>


Return-Path: <linux-nfs+bounces-8276-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BFB669DF518
	for <lists+linux-nfs@lfdr.de>; Sun,  1 Dec 2024 10:22:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 76388281194
	for <lists+linux-nfs@lfdr.de>; Sun,  1 Dec 2024 09:22:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C477F70824;
	Sun,  1 Dec 2024 09:22:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Il22jhhx"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9426735885
	for <linux-nfs@vger.kernel.org>; Sun,  1 Dec 2024 09:21:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733044920; cv=none; b=KZD1z9eWUphpzTCR1YWnkVH8xy3IfqYnUfg+XFBGm8d1b77X/ieghTxWwV1dLeDg0EYcXQE6wLI7PzUz9pRB8PvzFuxnO1w9piWPK8mBZOPe62TXUJr883rZogNBcf26lE+H21gauQnzO/Vn43S8l3ncyCZDQBq6pYSWURyRxFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733044920; c=relaxed/simple;
	bh=B0gcfux8Z1fbFfgKHfsm9bJlCCAZ0CGJNrCGVw/TaCE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=blQnD8sAwKuXeefgVqEtwaTYxpT7gs3GhAKi0v11fkQe0NDDE2t/5IsVJDs03aJ2vLi9Mlru2jBacJmH3rTxSWYoKJUUVboZxSK3rMLau8mbzoGfZJ2RfGbxSadGXo3dUbLg8fAHRbV0YKs6fW7/X9lTs+GrNUd48j6BBtPdKYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Il22jhhx; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-385e06af753so1028371f8f.2
        for <linux-nfs@vger.kernel.org>; Sun, 01 Dec 2024 01:21:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733044917; x=1733649717; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=NgoneLzAYgNwAognLKBP54DOK4WOgEcN5knvE5YrnKg=;
        b=Il22jhhxVhTWMSljDdN/ClwRM+gPDDZfm4mQ3AF6xAFe0ucaC6e7wv3GRlL+6YOvvJ
         sbRF6tFOSmf5YV0AVcEtCV+tBl9lLtnZrvN81LBMm92MGk7sX1pPstopkY4tJNqXO0Oe
         eDpsGOW8Ejvl3+5hqGnp/90HaHdCiUGU6IE2N1Jb9rOODKJ7STaU8OzsIyGHBNSe8f73
         rqLH0mnlO7xqjKl7RUeuOnkGfJ8QCmrNYjTLDQ9QYnblUgkqpIIGq2+T2a6JOt165u0z
         XzSx+ir95l5KirrnYuW1Eg25mTEGd+blXhJMnGKZjQ3Mn1hK2VCf8sls68HYcXCJtNPP
         58xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733044917; x=1733649717;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NgoneLzAYgNwAognLKBP54DOK4WOgEcN5knvE5YrnKg=;
        b=A5eyB4TpFIGmOEEgm4yqTlU5m80/BvXMeAVtiyLsVVbnbgoAndg23kUY6I9LP+/0bM
         xCDH4fywdrktgR3taRaJO4/fso5OYtAauA2I5+px2W0ud2aMeS6wMattMfnCFu1hyTB7
         OVC0386fqCc/gBJ5/dUfuOtdeHbKTPFo+p4V/qn0JRAZj8Qxg5e4mrc8UQv9Vby52GgM
         jbKmF0iWgXTWQhQCcpRidaFahcm+3oySWDDr4rcntjvup0cnvH2n5dRwZ4A/qf2cqC4S
         pqpmpXvA1/gIQR7xUjwhKXWDoVEVuug2Wu/vvtFJOM/VS073Fl+zkZ0f/AdW7MRvD/XY
         kv+A==
X-Gm-Message-State: AOJu0YxEyf3rs0uzEXKWtLsIUTmgEi3/arJuzBIhlfcfxyjFlPx6FkKT
	qpHhIZN7hpIgQvq8/xdDy1RPTI1K/hrO51OeRLR1YIm3q15eLh4znNhFji9d2a+/Extyyuh9x/0
	ps59JgotV/43OVUrEtrBllFHsWvZ+HcGOqvA=
X-Gm-Gg: ASbGnctvh23e8e5X+TRJU+BzHu2vl0G3kK94YhWRX3pqx1iB9Au+O2/7ANhcXTE8rzi
	+KHM6BspPmTp7GcCSAMdvE5UhHguzb/oG
X-Google-Smtp-Source: AGHT+IETrOyjsbjvxK3chqZ/880p1dotV3QhtIM3Ns3nSdW6wd83RscFI0Vt+h2Pt/p8WiXh51MjTmnb+BZmp4Hrswg=
X-Received: by 2002:a05:6000:2a7:b0:385:efc7:9348 with SMTP id
 ffacd0b85a97d-385efc79866mr718358f8f.1.1733044916642; Sun, 01 Dec 2024
 01:21:56 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240530071725.70043-1-b.tataroiu@gmail.com> <d7165359-a031-456e-bfae-a45d0aed5d80@redhat.com>
 <fbd5e08d-3975-48e8-90b6-325628cb1b85@redhat.com> <CAC=XK8Nk_odMwvwXrj9suXCayni-pVnzTga0aV9tn-B-3=ia9g@mail.gmail.com>
 <71ebdfc0-b7c9-44a5-916e-b73911a8fdff@redhat.com>
In-Reply-To: <71ebdfc0-b7c9-44a5-916e-b73911a8fdff@redhat.com>
From: =?UTF-8?B?Qm9nZGFuLUNyaXN0aWFuIFTEg3TEg3JvaXU=?= <b.tataroiu@gmail.com>
Date: Sun, 1 Dec 2024 09:21:29 +0000
Message-ID: <CAC=XK8N0H7w4eAqNgeYUDS_DGcSVWR2AUwdCub0tjXJjSmoY6A@mail.gmail.com>
Subject: Re: [PATCH] Add guards around [nfsidmap] usages of [sysconf].
To: Steve Dickson <steved@redhat.com>
Cc: linux-nfs@vger.kernel.org
Content-Type: multipart/mixed; boundary="000000000000a3053d062831f621"

--000000000000a3053d062831f621
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hey Steve,

Sure, I've attached an updated patch now. I ran it on my musl system
on top of git master and it works fine.

Cheers,
Bogdan

On Sat, Nov 30, 2024 at 2:20=E2=80=AFPM Steve Dickson <steved@redhat.com> w=
rote:
>
>
>
> On 11/30/24 7:32 AM, Bogdan-Cristian T=C4=83t=C4=83roiu wrote:
> > Hey Steve,
> >
> > My apologies for dropping this.
> >
> > I'm a bit confused since the man page for sysconf [1] seems to say it
> > returns -1 and sets errno to EINVAL (and indeed the patch I originally
> > submitted shows the intended behaviour on my musl system).
> >
> > The snippet in the newly defined [get_pwnam_buflen] is pretty much
> > just what's in the [getpwnam] man page [2] example.
> >
> > Maybe the thing you're pointing to is that I have [*size_t* buflen =3D
> > sysconf(_SC_GETPW_R_SIZE_MAX)].
> > I guess that should technically be [long buflen] and the result could
> > be converted to [size_t] upon return, it's just that the implicit
> > conversions make it such that the current code behaves as expected.
> >
> > So something like
> >
> >       long buflen =3D sysconf(_SC_GETPW_R_SIZE_MAX);
> >       if (buflen =3D=3D -1)
> >           buflen =3D 16384;
> >       return (size_t)buflen;
> >
> > Does that make more sense?
> Yes... it does... would mind posting another patch?
>
> I don't have access to a musl system so I can not
> test the change in that world.
>
> tia
>
> steved.
> >
> > [1] https://www.man7.org/linux/man-pages/man3/sysconf.3.html
> > [2] https://www.man7.org/linux/man-pages/man3/getpwnam.3.html
> >
> > Best,
> > Bogdan
> >
> > On Sat, Nov 9, 2024 at 6:25=E2=80=AFPM Steve Dickson <steved@redhat.com=
> wrote:
> >>
> >>
> >>
> >> On 6/17/24 2:51 PM, Steve Dickson wrote:
> >>>
> >>>
> >>> On 5/30/24 2:17 AM, Bogdan-Cristian T=C4=83t=C4=83roiu wrote:
> >>>> sysconf(_SC_GETPW_R_SIZE_MAX) and sysconf(_SC_GETGR_R_SIZE_MAX)
> >>>> return -1 on musl, which causes either segmentation faults or ENOMEM
> >>>> errors.
> >>> Actually sysconf() returns EINVAL not -1 since the return
> >>> value is a size_t (unsigned long). So I needed to change
> >>>
> >>>       size_t buflen =3D sysconf(_SC_GETPW_R_SIZE_MAX);
> >>>       if (buflen =3D=3D EINVAL) <<< this from -1 to EINVAL
> >>>           buflen =3D 16384;
> >>>       return buflen;
> >>>
> >>> Good with that? Will this work with musl?
> >> Just found this on my todo list... Still
> >> interest in  have these patch committed?
> >>
> >> steved.
> >>
> >>>
> >>> steved.
> >>>
> >>>>
> >>>> Replace all usages of sysconf with dedicated methods that guard agai=
nst
> >>>> a result of -1.
> >>>>
> >>>> Signed-off-by: Bogdan-Cristian T=C4=83t=C4=83roiu <b.tataroiu@gmail.=
com>
> >>>> ---
> >>>>    support/nfsidmap/gums.c             |  4 ++--
> >>>>    support/nfsidmap/libnfsidmap.c      |  4 ++--
> >>>>    support/nfsidmap/nfsidmap_common.c  | 16 ++++++++++++++++
> >>>>    support/nfsidmap/nfsidmap_private.h |  2 ++
> >>>>    support/nfsidmap/nss.c              |  8 ++++----
> >>>>    support/nfsidmap/regex.c            |  9 +++++----
> >>>>    support/nfsidmap/static.c           |  5 +++--
> >>>>    7 files changed, 34 insertions(+), 14 deletions(-)
> >>>>
> >>>> diff --git a/support/nfsidmap/gums.c b/support/nfsidmap/gums.c
> >>>> index 1d6eb318..e94a4c50 100644
> >>>> --- a/support/nfsidmap/gums.c
> >>>> +++ b/support/nfsidmap/gums.c
> >>>> @@ -475,7 +475,7 @@ static int translate_to_uid(char *local_uid, uid=
_t
> >>>> *uid, uid_t *gid)
> >>>>        int ret =3D -1;
> >>>>        struct passwd *pw =3D NULL;
> >>>>        struct pwbuf *buf =3D NULL;
> >>>> -    size_t buflen =3D sysconf(_SC_GETPW_R_SIZE_MAX);
> >>>> +    size_t buflen =3D get_pwnam_buflen();
> >>>>        buf =3D malloc(sizeof(*buf) + buflen);
> >>>>        if (buf =3D=3D NULL)
> >>>> @@ -501,7 +501,7 @@ static int translate_to_gid(char *local_gid, uid=
_t
> >>>> *gid)
> >>>>        struct group *gr =3D NULL;
> >>>>        struct group grbuf;
> >>>>        char *buf =3D NULL;
> >>>> -    size_t buflen =3D sysconf(_SC_GETGR_R_SIZE_MAX);
> >>>> +    size_t buflen =3D get_grnam_buflen();
> >>>>        int ret =3D -1;
> >>>>        do {
> >>>> diff --git a/support/nfsidmap/libnfsidmap.c b/support/nfsidmap/
> >>>> libnfsidmap.c
> >>>> index f8c36480..e1475879 100644
> >>>> --- a/support/nfsidmap/libnfsidmap.c
> >>>> +++ b/support/nfsidmap/libnfsidmap.c
> >>>> @@ -457,7 +457,7 @@ int nfs4_init_name_mapping(char *conffile)
> >>>>        nobody_user =3D conf_get_str("Mapping", "Nobody-User");
> >>>>        if (nobody_user) {
> >>>> -        size_t buflen =3D sysconf(_SC_GETPW_R_SIZE_MAX);
> >>>> +        size_t buflen =3D get_pwnam_buflen();
> >>>>            struct passwd *buf;
> >>>>            struct passwd *pw =3D NULL;
> >>>>            int err;
> >>>> @@ -478,7 +478,7 @@ int nfs4_init_name_mapping(char *conffile)
> >>>>        nobody_group =3D conf_get_str("Mapping", "Nobody-Group");
> >>>>        if (nobody_group) {
> >>>> -        size_t buflen =3D sysconf(_SC_GETGR_R_SIZE_MAX);
> >>>> +        size_t buflen =3D get_grnam_buflen();
> >>>>            struct group *buf;
> >>>>            struct group *gr =3D NULL;
> >>>>            int err;
> >>>> diff --git a/support/nfsidmap/nfsidmap_common.c b/support/nfsidmap/
> >>>> nfsidmap_common.c
> >>>> index 4d2cb14f..310c68f0 100644
> >>>> --- a/support/nfsidmap/nfsidmap_common.c
> >>>> +++ b/support/nfsidmap/nfsidmap_common.c
> >>>> @@ -116,3 +116,19 @@ int get_reformat_group(void)
> >>>>        return reformat_group;
> >>>>    }
> >>>> +
> >>>> +size_t get_pwnam_buflen(void)
> >>>> +{
> >>>> +    size_t buflen =3D sysconf(_SC_GETPW_R_SIZE_MAX);
> >>>> +    if (buflen =3D=3D -1)
> >>>> +        buflen =3D 16384;
> >>>> +    return buflen;
> >>>> +}
> >>>> +
> >>>> +size_t get_grnam_buflen(void)
> >>>> +{
> >>>> +    size_t buflen =3D sysconf(_SC_GETGR_R_SIZE_MAX);
> >>>> +    if (buflen =3D=3D -1)
> >>>> +        buflen =3D 16384;
> >>>> +    return buflen;
> >>>> +}
> >>>> diff --git a/support/nfsidmap/nfsidmap_private.h b/support/nfsidmap/
> >>>> nfsidmap_private.h
> >>>> index a5cb6dda..234ca9d4 100644
> >>>> --- a/support/nfsidmap/nfsidmap_private.h
> >>>> +++ b/support/nfsidmap/nfsidmap_private.h
> >>>> @@ -40,6 +40,8 @@ struct conf_list *get_local_realms(void);
> >>>>    void free_local_realms(void);
> >>>>    int get_nostrip(void);
> >>>>    int get_reformat_group(void);
> >>>> +size_t get_pwnam_buflen(void);
> >>>> +size_t get_grnam_buflen(void);
> >>>>    typedef enum {
> >>>>        IDTYPE_USER =3D 1,
> >>>> diff --git a/support/nfsidmap/nss.c b/support/nfsidmap/nss.c
> >>>> index 0f43076e..3fc045dc 100644
> >>>> --- a/support/nfsidmap/nss.c
> >>>> +++ b/support/nfsidmap/nss.c
> >>>> @@ -91,7 +91,7 @@ static int nss_uid_to_name(uid_t uid, char *domain=
,
> >>>> char *name, size_t len)
> >>>>        struct passwd *pw =3D NULL;
> >>>>        struct passwd pwbuf;
> >>>>        char *buf;
> >>>> -    size_t buflen =3D sysconf(_SC_GETPW_R_SIZE_MAX);
> >>>> +    size_t buflen =3D get_pwnam_buflen();
> >>>>        int err =3D -ENOMEM;
> >>>>        buf =3D malloc(buflen);
> >>>> @@ -119,7 +119,7 @@ static int nss_gid_to_name(gid_t gid, char
> >>>> *domain, char *name, size_t len)
> >>>>        struct group *gr =3D NULL;
> >>>>        struct group grbuf;
> >>>>        char *buf;
> >>>> -    size_t buflen =3D sysconf(_SC_GETGR_R_SIZE_MAX);
> >>>> +    size_t buflen =3D get_grnam_buflen();
> >>>>        int err;
> >>>>        if (domain =3D=3D NULL)
> >>>> @@ -192,7 +192,7 @@ static struct passwd *nss_getpwnam(const char
> >>>> *name, const char *domain,
> >>>>    {
> >>>>        struct passwd *pw;
> >>>>        struct pwbuf *buf;
> >>>> -    size_t buflen =3D sysconf(_SC_GETPW_R_SIZE_MAX);
> >>>> +    size_t buflen =3D get_pwnam_buflen();
> >>>>        char *localname;
> >>>>        int err =3D ENOMEM;
> >>>> @@ -301,7 +301,7 @@ static int _nss_name_to_gid(char *name, gid_t
> >>>> *gid, int dostrip)
> >>>>        struct group *gr =3D NULL;
> >>>>        struct group grbuf;
> >>>>        char *buf, *domain;
> >>>> -    size_t buflen =3D sysconf(_SC_GETGR_R_SIZE_MAX);
> >>>> +    size_t buflen =3D get_grnam_buflen();
> >>>>        int err =3D -EINVAL;
> >>>>        char *localname =3D NULL;
> >>>>        char *ref_name =3D NULL;
> >>>> diff --git a/support/nfsidmap/regex.c b/support/nfsidmap/regex.c
> >>>> index 8424179f..ea094b95 100644
> >>>> --- a/support/nfsidmap/regex.c
> >>>> +++ b/support/nfsidmap/regex.c
> >>>> @@ -46,6 +46,7 @@
> >>>>    #include "nfsidmap.h"
> >>>>    #include "nfsidmap_plugin.h"
> >>>> +#include "nfsidmap_private.h"
> >>>>    #define CONFIG_GET_STRING nfsidmap_config_get
> >>>>    extern const char *nfsidmap_config_get(const char *, const char *=
);
> >>>> @@ -95,7 +96,7 @@ static struct passwd *regex_getpwnam(const char
> >>>> *name, const char *UNUSED(domain
> >>>>    {
> >>>>        struct passwd *pw;
> >>>>        struct pwbuf *buf;
> >>>> -    size_t buflen =3D sysconf(_SC_GETPW_R_SIZE_MAX);
> >>>> +    size_t buflen =3D get_pwnam_buflen();
> >>>>        char *localname;
> >>>>        size_t namelen;
> >>>>        int err;
> >>>> @@ -175,7 +176,7 @@ static struct group *regex_getgrnam(const char
> >>>> *name, const char *UNUSED(domain)
> >>>>    {
> >>>>        struct group *gr;
> >>>>        struct grbuf *buf;
> >>>> -    size_t buflen =3D sysconf(_SC_GETGR_R_SIZE_MAX);
> >>>> +    size_t buflen =3D get_grnam_buflen();
> >>>>        char *localgroup;
> >>>>        char *groupname;
> >>>>        size_t namelen;
> >>>> @@ -366,7 +367,7 @@ static int regex_uid_to_name(uid_t uid, char
> >>>> *domain, char *name, size_t len)
> >>>>        struct passwd *pw =3D NULL;
> >>>>        struct passwd pwbuf;
> >>>>        char *buf;
> >>>> -    size_t buflen =3D sysconf(_SC_GETPW_R_SIZE_MAX);
> >>>> +    size_t buflen =3D get_pwnam_buflen();
> >>>>        int err =3D -ENOMEM;
> >>>>        buf =3D malloc(buflen);
> >>>> @@ -392,7 +393,7 @@ static int regex_gid_to_name(gid_t gid, char
> >>>> *UNUSED(domain), char *name, size_t
> >>>>        struct group grbuf;
> >>>>        char *buf;
> >>>>        const char *name_prefix;
> >>>> -    size_t buflen =3D sysconf(_SC_GETGR_R_SIZE_MAX);
> >>>> +    size_t buflen =3D get_grnam_buflen();
> >>>>        int err;
> >>>>        char * groupname =3D NULL;
> >>>> diff --git a/support/nfsidmap/static.c b/support/nfsidmap/static.c
> >>>> index 8ac4a398..395cac06 100644
> >>>> --- a/support/nfsidmap/static.c
> >>>> +++ b/support/nfsidmap/static.c
> >>>> @@ -44,6 +44,7 @@
> >>>>    #include "conffile.h"
> >>>>    #include "nfsidmap.h"
> >>>>    #include "nfsidmap_plugin.h"
> >>>> +#include "nfsidmap_private.h"
> >>>>    /*
> >>>>     * Static Translation Methods
> >>>> @@ -98,7 +99,7 @@ static struct passwd *static_getpwnam(const char *=
name,
> >>>>    {
> >>>>        struct passwd *pw;
> >>>>        struct pwbuf *buf;
> >>>> -    size_t buflen =3D sysconf(_SC_GETPW_R_SIZE_MAX);
> >>>> +    size_t buflen =3D get_pwnam_buflen();
> >>>>        char *localname;
> >>>>        int err;
> >>>> @@ -149,7 +150,7 @@ static struct group *static_getgrnam(const char
> >>>> *name,
> >>>>    {
> >>>>        struct group *gr;
> >>>>        struct grbuf *buf;
> >>>> -    size_t buflen =3D sysconf(_SC_GETGR_R_SIZE_MAX);
> >>>> +    size_t buflen =3D get_grnam_buflen();
> >>>>        char *localgroup;
> >>>>        int err;
> >>
> >
>

--000000000000a3053d062831f621
Content-Type: application/octet-stream; 
	name="0001-Add-guards-around-nfsidmap-usages-of-sysconf.patch"
Content-Disposition: attachment; 
	filename="0001-Add-guards-around-nfsidmap-usages-of-sysconf.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_m45dzhgt0>
X-Attachment-Id: f_m45dzhgt0

RnJvbSAxNWNjMzJjMzFlYTEwZTQyNjQ4MDcwMGUzZDlhNDI4OWVjYzkzNmM3IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiA9P1VURi04P3E/Qm9nZGFuLUNyaXN0aWFuPTIwVD1DND04M3Q9
QzQ9ODNyb2l1Pz0KIDxiLnRhdGFyb2l1QGdtYWlsLmNvbT4KRGF0ZTogVGh1LCAzMCBNYXkgMjAy
NCAwNzoyODoyOCArMDEwMApTdWJqZWN0OiBbUEFUQ0hdIEFkZCBndWFyZHMgYXJvdW5kIFtuZnNp
ZG1hcF0gdXNhZ2VzIG9mIFtzeXNjb25mXS4KCnN5c2NvbmYoX1NDX0dFVFBXX1JfU0laRV9NQVgp
IGFuZCBzeXNjb25mKF9TQ19HRVRHUl9SX1NJWkVfTUFYKQpyZXR1cm4gLTEgb24gbXVzbCwgd2hp
Y2ggY2F1c2VzIGVpdGhlciBzZWdtZW50YXRpb24gZmF1bHRzIG9yIEVOT01FTQplcnJvcnMuCgpS
ZXBsYWNlIGFsbCB1c2FnZXMgb2Ygc3lzY29uZiB3aXRoIGRlZGljYXRlZCBtZXRob2RzIHRoYXQg
Z3VhcmQgYWdhaW5zdAphIHJlc3VsdCBvZiAtMS4KLS0tCiBzdXBwb3J0L25mc2lkbWFwL2d1bXMu
YyAgICAgICAgICAgICB8ICA0ICsrLS0KIHN1cHBvcnQvbmZzaWRtYXAvbGlibmZzaWRtYXAuYyAg
ICAgIHwgIDQgKystLQogc3VwcG9ydC9uZnNpZG1hcC9uZnNpZG1hcF9jb21tb24uYyAgfCAxNiAr
KysrKysrKysrKysrKysrCiBzdXBwb3J0L25mc2lkbWFwL25mc2lkbWFwX3ByaXZhdGUuaCB8ICAy
ICsrCiBzdXBwb3J0L25mc2lkbWFwL25zcy5jICAgICAgICAgICAgICB8ICA4ICsrKystLS0tCiBz
dXBwb3J0L25mc2lkbWFwL3JlZ2V4LmMgICAgICAgICAgICB8ICA5ICsrKysrLS0tLQogc3VwcG9y
dC9uZnNpZG1hcC9zdGF0aWMuYyAgICAgICAgICAgfCAgNSArKystLQogNyBmaWxlcyBjaGFuZ2Vk
LCAzNCBpbnNlcnRpb25zKCspLCAxNCBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS9zdXBwb3J0
L25mc2lkbWFwL2d1bXMuYyBiL3N1cHBvcnQvbmZzaWRtYXAvZ3Vtcy5jCmluZGV4IDFkNmViMzE4
Li5lOTRhNGM1MCAxMDA2NDQKLS0tIGEvc3VwcG9ydC9uZnNpZG1hcC9ndW1zLmMKKysrIGIvc3Vw
cG9ydC9uZnNpZG1hcC9ndW1zLmMKQEAgLTQ3NSw3ICs0NzUsNyBAQCBzdGF0aWMgaW50IHRyYW5z
bGF0ZV90b191aWQoY2hhciAqbG9jYWxfdWlkLCB1aWRfdCAqdWlkLCB1aWRfdCAqZ2lkKQogCWlu
dCByZXQgPSAtMTsKIAlzdHJ1Y3QgcGFzc3dkICpwdyA9IE5VTEw7CiAJc3RydWN0IHB3YnVmICpi
dWYgPSBOVUxMOwotCXNpemVfdCBidWZsZW4gPSBzeXNjb25mKF9TQ19HRVRQV19SX1NJWkVfTUFY
KTsKKwlzaXplX3QgYnVmbGVuID0gZ2V0X3B3bmFtX2J1ZmxlbigpOwogCiAJYnVmID0gbWFsbG9j
KHNpemVvZigqYnVmKSArIGJ1Zmxlbik7CiAJaWYgKGJ1ZiA9PSBOVUxMKQpAQCAtNTAxLDcgKzUw
MSw3IEBAIHN0YXRpYyBpbnQgdHJhbnNsYXRlX3RvX2dpZChjaGFyICpsb2NhbF9naWQsIHVpZF90
ICpnaWQpCiAJc3RydWN0IGdyb3VwICpnciA9IE5VTEw7CiAJc3RydWN0IGdyb3VwIGdyYnVmOwog
CWNoYXIgKmJ1ZiA9IE5VTEw7Ci0Jc2l6ZV90IGJ1ZmxlbiA9IHN5c2NvbmYoX1NDX0dFVEdSX1Jf
U0laRV9NQVgpOworCXNpemVfdCBidWZsZW4gPSBnZXRfZ3JuYW1fYnVmbGVuKCk7CiAJaW50IHJl
dCA9IC0xOwogCiAJZG8gewpkaWZmIC0tZ2l0IGEvc3VwcG9ydC9uZnNpZG1hcC9saWJuZnNpZG1h
cC5jIGIvc3VwcG9ydC9uZnNpZG1hcC9saWJuZnNpZG1hcC5jCmluZGV4IGY4YzM2NDgwLi5lMTQ3
NTg3OSAxMDA2NDQKLS0tIGEvc3VwcG9ydC9uZnNpZG1hcC9saWJuZnNpZG1hcC5jCisrKyBiL3N1
cHBvcnQvbmZzaWRtYXAvbGlibmZzaWRtYXAuYwpAQCAtNDU3LDcgKzQ1Nyw3IEBAIGludCBuZnM0
X2luaXRfbmFtZV9tYXBwaW5nKGNoYXIgKmNvbmZmaWxlKQogCiAJbm9ib2R5X3VzZXIgPSBjb25m
X2dldF9zdHIoIk1hcHBpbmciLCAiTm9ib2R5LVVzZXIiKTsKIAlpZiAobm9ib2R5X3VzZXIpIHsK
LQkJc2l6ZV90IGJ1ZmxlbiA9IHN5c2NvbmYoX1NDX0dFVFBXX1JfU0laRV9NQVgpOworCQlzaXpl
X3QgYnVmbGVuID0gZ2V0X3B3bmFtX2J1ZmxlbigpOwogCQlzdHJ1Y3QgcGFzc3dkICpidWY7CiAJ
CXN0cnVjdCBwYXNzd2QgKnB3ID0gTlVMTDsKIAkJaW50IGVycjsKQEAgLTQ3OCw3ICs0NzgsNyBA
QCBpbnQgbmZzNF9pbml0X25hbWVfbWFwcGluZyhjaGFyICpjb25mZmlsZSkKIAogCW5vYm9keV9n
cm91cCA9IGNvbmZfZ2V0X3N0cigiTWFwcGluZyIsICJOb2JvZHktR3JvdXAiKTsKIAlpZiAobm9i
b2R5X2dyb3VwKSB7Ci0JCXNpemVfdCBidWZsZW4gPSBzeXNjb25mKF9TQ19HRVRHUl9SX1NJWkVf
TUFYKTsKKwkJc2l6ZV90IGJ1ZmxlbiA9IGdldF9ncm5hbV9idWZsZW4oKTsKIAkJc3RydWN0IGdy
b3VwICpidWY7CiAJCXN0cnVjdCBncm91cCAqZ3IgPSBOVUxMOwogCQlpbnQgZXJyOwpkaWZmIC0t
Z2l0IGEvc3VwcG9ydC9uZnNpZG1hcC9uZnNpZG1hcF9jb21tb24uYyBiL3N1cHBvcnQvbmZzaWRt
YXAvbmZzaWRtYXBfY29tbW9uLmMKaW5kZXggNGQyY2IxNGYuLjFkNWI1NDJiIDEwMDY0NAotLS0g
YS9zdXBwb3J0L25mc2lkbWFwL25mc2lkbWFwX2NvbW1vbi5jCisrKyBiL3N1cHBvcnQvbmZzaWRt
YXAvbmZzaWRtYXBfY29tbW9uLmMKQEAgLTExNiwzICsxMTYsMTkgQEAgaW50IGdldF9yZWZvcm1h
dF9ncm91cCh2b2lkKQogCiAJcmV0dXJuIHJlZm9ybWF0X2dyb3VwOwogfQorCitzaXplX3QgZ2V0
X3B3bmFtX2J1Zmxlbih2b2lkKQoreworCWxvbmcgYnVmbGVuID0gc3lzY29uZihfU0NfR0VUUFdf
Ul9TSVpFX01BWCk7CisJaWYgKGJ1ZmxlbiA9PSAtMSkKKwkJYnVmbGVuID0gMTYzODQ7CisJcmV0
dXJuIChzaXplX3QpYnVmbGVuOworfQorCitzaXplX3QgZ2V0X2dybmFtX2J1Zmxlbih2b2lkKQor
eworCWxvbmcgYnVmbGVuID0gc3lzY29uZihfU0NfR0VUR1JfUl9TSVpFX01BWCk7CisJaWYgKGJ1
ZmxlbiA9PSAtMSkKKwkJYnVmbGVuID0gMTYzODQ7CisJcmV0dXJuIChzaXplX3QpYnVmbGVuOwor
fQpkaWZmIC0tZ2l0IGEvc3VwcG9ydC9uZnNpZG1hcC9uZnNpZG1hcF9wcml2YXRlLmggYi9zdXBw
b3J0L25mc2lkbWFwL25mc2lkbWFwX3ByaXZhdGUuaAppbmRleCBhNWNiNmRkYS4uMjM0Y2E5ZDQg
MTAwNjQ0Ci0tLSBhL3N1cHBvcnQvbmZzaWRtYXAvbmZzaWRtYXBfcHJpdmF0ZS5oCisrKyBiL3N1
cHBvcnQvbmZzaWRtYXAvbmZzaWRtYXBfcHJpdmF0ZS5oCkBAIC00MCw2ICs0MCw4IEBAIHN0cnVj
dCBjb25mX2xpc3QgKmdldF9sb2NhbF9yZWFsbXModm9pZCk7CiB2b2lkIGZyZWVfbG9jYWxfcmVh
bG1zKHZvaWQpOwogaW50IGdldF9ub3N0cmlwKHZvaWQpOwogaW50IGdldF9yZWZvcm1hdF9ncm91
cCh2b2lkKTsKK3NpemVfdCBnZXRfcHduYW1fYnVmbGVuKHZvaWQpOworc2l6ZV90IGdldF9ncm5h
bV9idWZsZW4odm9pZCk7CiAKIHR5cGVkZWYgZW51bSB7CiAJSURUWVBFX1VTRVIgPSAxLApkaWZm
IC0tZ2l0IGEvc3VwcG9ydC9uZnNpZG1hcC9uc3MuYyBiL3N1cHBvcnQvbmZzaWRtYXAvbnNzLmMK
aW5kZXggMGY0MzA3NmUuLjNmYzA0NWRjIDEwMDY0NAotLS0gYS9zdXBwb3J0L25mc2lkbWFwL25z
cy5jCisrKyBiL3N1cHBvcnQvbmZzaWRtYXAvbnNzLmMKQEAgLTkxLDcgKzkxLDcgQEAgc3RhdGlj
IGludCBuc3NfdWlkX3RvX25hbWUodWlkX3QgdWlkLCBjaGFyICpkb21haW4sIGNoYXIgKm5hbWUs
IHNpemVfdCBsZW4pCiAJc3RydWN0IHBhc3N3ZCAqcHcgPSBOVUxMOwogCXN0cnVjdCBwYXNzd2Qg
cHdidWY7CiAJY2hhciAqYnVmOwotCXNpemVfdCBidWZsZW4gPSBzeXNjb25mKF9TQ19HRVRQV19S
X1NJWkVfTUFYKTsKKwlzaXplX3QgYnVmbGVuID0gZ2V0X3B3bmFtX2J1ZmxlbigpOwogCWludCBl
cnIgPSAtRU5PTUVNOwogCiAJYnVmID0gbWFsbG9jKGJ1Zmxlbik7CkBAIC0xMTksNyArMTE5LDcg
QEAgc3RhdGljIGludCBuc3NfZ2lkX3RvX25hbWUoZ2lkX3QgZ2lkLCBjaGFyICpkb21haW4sIGNo
YXIgKm5hbWUsIHNpemVfdCBsZW4pCiAJc3RydWN0IGdyb3VwICpnciA9IE5VTEw7CiAJc3RydWN0
IGdyb3VwIGdyYnVmOwogCWNoYXIgKmJ1ZjsKLQlzaXplX3QgYnVmbGVuID0gc3lzY29uZihfU0Nf
R0VUR1JfUl9TSVpFX01BWCk7CisJc2l6ZV90IGJ1ZmxlbiA9IGdldF9ncm5hbV9idWZsZW4oKTsK
IAlpbnQgZXJyOwogCiAJaWYgKGRvbWFpbiA9PSBOVUxMKQpAQCAtMTkyLDcgKzE5Miw3IEBAIHN0
YXRpYyBzdHJ1Y3QgcGFzc3dkICpuc3NfZ2V0cHduYW0oY29uc3QgY2hhciAqbmFtZSwgY29uc3Qg
Y2hhciAqZG9tYWluLAogewogCXN0cnVjdCBwYXNzd2QgKnB3OwogCXN0cnVjdCBwd2J1ZiAqYnVm
OwotCXNpemVfdCBidWZsZW4gPSBzeXNjb25mKF9TQ19HRVRQV19SX1NJWkVfTUFYKTsKKwlzaXpl
X3QgYnVmbGVuID0gZ2V0X3B3bmFtX2J1ZmxlbigpOwogCWNoYXIgKmxvY2FsbmFtZTsKIAlpbnQg
ZXJyID0gRU5PTUVNOwogCkBAIC0zMDEsNyArMzAxLDcgQEAgc3RhdGljIGludCBfbnNzX25hbWVf
dG9fZ2lkKGNoYXIgKm5hbWUsIGdpZF90ICpnaWQsIGludCBkb3N0cmlwKQogCXN0cnVjdCBncm91
cCAqZ3IgPSBOVUxMOwogCXN0cnVjdCBncm91cCBncmJ1ZjsKIAljaGFyICpidWYsICpkb21haW47
Ci0Jc2l6ZV90IGJ1ZmxlbiA9IHN5c2NvbmYoX1NDX0dFVEdSX1JfU0laRV9NQVgpOworCXNpemVf
dCBidWZsZW4gPSBnZXRfZ3JuYW1fYnVmbGVuKCk7CiAJaW50IGVyciA9IC1FSU5WQUw7CiAJY2hh
ciAqbG9jYWxuYW1lID0gTlVMTDsKIAljaGFyICpyZWZfbmFtZSA9IE5VTEw7CmRpZmYgLS1naXQg
YS9zdXBwb3J0L25mc2lkbWFwL3JlZ2V4LmMgYi9zdXBwb3J0L25mc2lkbWFwL3JlZ2V4LmMKaW5k
ZXggODQyNDE3OWYuLmVhMDk0Yjk1IDEwMDY0NAotLS0gYS9zdXBwb3J0L25mc2lkbWFwL3JlZ2V4
LmMKKysrIGIvc3VwcG9ydC9uZnNpZG1hcC9yZWdleC5jCkBAIC00Niw2ICs0Niw3IEBACiAKICNp
bmNsdWRlICJuZnNpZG1hcC5oIgogI2luY2x1ZGUgIm5mc2lkbWFwX3BsdWdpbi5oIgorI2luY2x1
ZGUgIm5mc2lkbWFwX3ByaXZhdGUuaCIKIAogI2RlZmluZSBDT05GSUdfR0VUX1NUUklORyBuZnNp
ZG1hcF9jb25maWdfZ2V0CiBleHRlcm4gY29uc3QgY2hhciAqbmZzaWRtYXBfY29uZmlnX2dldChj
b25zdCBjaGFyICosIGNvbnN0IGNoYXIgKik7CkBAIC05NSw3ICs5Niw3IEBAIHN0YXRpYyBzdHJ1
Y3QgcGFzc3dkICpyZWdleF9nZXRwd25hbShjb25zdCBjaGFyICpuYW1lLCBjb25zdCBjaGFyICpV
TlVTRUQoZG9tYWluCiB7CiAJc3RydWN0IHBhc3N3ZCAqcHc7CiAJc3RydWN0IHB3YnVmICpidWY7
Ci0Jc2l6ZV90IGJ1ZmxlbiA9IHN5c2NvbmYoX1NDX0dFVFBXX1JfU0laRV9NQVgpOworCXNpemVf
dCBidWZsZW4gPSBnZXRfcHduYW1fYnVmbGVuKCk7CiAJY2hhciAqbG9jYWxuYW1lOwogCXNpemVf
dCBuYW1lbGVuOwogCWludCBlcnI7CkBAIC0xNzUsNyArMTc2LDcgQEAgc3RhdGljIHN0cnVjdCBn
cm91cCAqcmVnZXhfZ2V0Z3JuYW0oY29uc3QgY2hhciAqbmFtZSwgY29uc3QgY2hhciAqVU5VU0VE
KGRvbWFpbikKIHsKIAlzdHJ1Y3QgZ3JvdXAgKmdyOwogCXN0cnVjdCBncmJ1ZiAqYnVmOwotCXNp
emVfdCBidWZsZW4gPSBzeXNjb25mKF9TQ19HRVRHUl9SX1NJWkVfTUFYKTsKKwlzaXplX3QgYnVm
bGVuID0gZ2V0X2dybmFtX2J1ZmxlbigpOwogCWNoYXIgKmxvY2FsZ3JvdXA7CiAJY2hhciAqZ3Jv
dXBuYW1lOwogCXNpemVfdCBuYW1lbGVuOwpAQCAtMzY2LDcgKzM2Nyw3IEBAIHN0YXRpYyBpbnQg
cmVnZXhfdWlkX3RvX25hbWUodWlkX3QgdWlkLCBjaGFyICpkb21haW4sIGNoYXIgKm5hbWUsIHNp
emVfdCBsZW4pCiAJc3RydWN0IHBhc3N3ZCAqcHcgPSBOVUxMOwogCXN0cnVjdCBwYXNzd2QgcHdi
dWY7CiAJY2hhciAqYnVmOwotCXNpemVfdCBidWZsZW4gPSBzeXNjb25mKF9TQ19HRVRQV19SX1NJ
WkVfTUFYKTsKKwlzaXplX3QgYnVmbGVuID0gZ2V0X3B3bmFtX2J1ZmxlbigpOwogCWludCBlcnIg
PSAtRU5PTUVNOwogCiAJYnVmID0gbWFsbG9jKGJ1Zmxlbik7CkBAIC0zOTIsNyArMzkzLDcgQEAg
c3RhdGljIGludCByZWdleF9naWRfdG9fbmFtZShnaWRfdCBnaWQsIGNoYXIgKlVOVVNFRChkb21h
aW4pLCBjaGFyICpuYW1lLCBzaXplX3QKIAlzdHJ1Y3QgZ3JvdXAgZ3JidWY7CiAJY2hhciAqYnVm
OwogICAgIGNvbnN0IGNoYXIgKm5hbWVfcHJlZml4OwotCXNpemVfdCBidWZsZW4gPSBzeXNjb25m
KF9TQ19HRVRHUl9SX1NJWkVfTUFYKTsKKwlzaXplX3QgYnVmbGVuID0gZ2V0X2dybmFtX2J1Zmxl
bigpOwogCWludCBlcnI7CiAgICAgY2hhciAqIGdyb3VwbmFtZSA9IE5VTEw7CiAKZGlmZiAtLWdp
dCBhL3N1cHBvcnQvbmZzaWRtYXAvc3RhdGljLmMgYi9zdXBwb3J0L25mc2lkbWFwL3N0YXRpYy5j
CmluZGV4IDhhYzRhMzk4Li4zOTVjYWMwNiAxMDA2NDQKLS0tIGEvc3VwcG9ydC9uZnNpZG1hcC9z
dGF0aWMuYworKysgYi9zdXBwb3J0L25mc2lkbWFwL3N0YXRpYy5jCkBAIC00NCw2ICs0NCw3IEBA
CiAjaW5jbHVkZSAiY29uZmZpbGUuaCIKICNpbmNsdWRlICJuZnNpZG1hcC5oIgogI2luY2x1ZGUg
Im5mc2lkbWFwX3BsdWdpbi5oIgorI2luY2x1ZGUgIm5mc2lkbWFwX3ByaXZhdGUuaCIKIAogLyoK
ICAqIFN0YXRpYyBUcmFuc2xhdGlvbiBNZXRob2RzCkBAIC05OCw3ICs5OSw3IEBAIHN0YXRpYyBz
dHJ1Y3QgcGFzc3dkICpzdGF0aWNfZ2V0cHduYW0oY29uc3QgY2hhciAqbmFtZSwKIHsKIAlzdHJ1
Y3QgcGFzc3dkICpwdzsKIAlzdHJ1Y3QgcHdidWYgKmJ1ZjsKLQlzaXplX3QgYnVmbGVuID0gc3lz
Y29uZihfU0NfR0VUUFdfUl9TSVpFX01BWCk7CisJc2l6ZV90IGJ1ZmxlbiA9IGdldF9wd25hbV9i
dWZsZW4oKTsKIAljaGFyICpsb2NhbG5hbWU7CiAJaW50IGVycjsKIApAQCAtMTQ5LDcgKzE1MCw3
IEBAIHN0YXRpYyBzdHJ1Y3QgZ3JvdXAgKnN0YXRpY19nZXRncm5hbShjb25zdCBjaGFyICpuYW1l
LAogewogCXN0cnVjdCBncm91cCAqZ3I7CiAJc3RydWN0IGdyYnVmICpidWY7Ci0Jc2l6ZV90IGJ1
ZmxlbiA9IHN5c2NvbmYoX1NDX0dFVEdSX1JfU0laRV9NQVgpOworCXNpemVfdCBidWZsZW4gPSBn
ZXRfZ3JuYW1fYnVmbGVuKCk7CiAJY2hhciAqbG9jYWxncm91cDsKIAlpbnQgZXJyOwogCi0tIAoy
LjQ1LjIKCg==
--000000000000a3053d062831f621--


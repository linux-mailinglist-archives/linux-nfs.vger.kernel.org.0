Return-Path: <linux-nfs+bounces-378-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A9CC2807A89
	for <lists+linux-nfs@lfdr.de>; Wed,  6 Dec 2023 22:34:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CCF621C20944
	for <lists+linux-nfs@lfdr.de>; Wed,  6 Dec 2023 21:34:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98B4770966;
	Wed,  6 Dec 2023 21:34:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=umich.edu header.i=@umich.edu header.b="NfvWopDY"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87A2AF7
	for <linux-nfs@vger.kernel.org>; Wed,  6 Dec 2023 13:34:04 -0800 (PST)
Received: by mail-lj1-x233.google.com with SMTP id 38308e7fff4ca-2c9f223675aso658801fa.1
        for <linux-nfs@vger.kernel.org>; Wed, 06 Dec 2023 13:34:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umich.edu; s=google-2016-06-03; t=1701898443; x=1702503243; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OETlxYvyskwkyxrhlNzLdNXt2WWmwT+Fgq2UfhvH5Ig=;
        b=NfvWopDYcN3oiNqZJ9fe4DIZ8RqHInoLz5fCe81yGT1aojTaEC+a0l5oDX4KWEpyib
         zlLkafuQ+427R42v/W+tyyWfkW8n9oI93f4uYzx4WFYUxyGHUhDBNxMsF1sI98a50zDL
         9ufrpn7oAn96wtRmcYl52s8bnSKk2dv+q0nuNjPF+naEeTKh4E6m/N1eozis5/0OaEwR
         utA5ojERfCgtANNFA0jxhgO+MuhZsKbIMQ/kS3HA+GpF4jj2v2tBX+fXbnsn5+gskhJG
         w7aJ4jV2VwZWRcHsI2EMz5tXXXAH6zxN07Dn6cjLbp8cmPHwIIc0z2NSIH88pnBajn7+
         T4YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701898443; x=1702503243;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OETlxYvyskwkyxrhlNzLdNXt2WWmwT+Fgq2UfhvH5Ig=;
        b=OPJIW/GhBBnyg6P52fNuujC2L0wmisu6/DYXQYp7DZEe2OzxRKie96/ZaUabq+GsSv
         gcZDufa3Aj6o0USbGIFv36/m/qDTUIlWr9EgSXvQY03tZWaeHKnUIqBQicyzkUdOEVIG
         oMl4lVxuy0/P9yyn+sr2TOyHoHuOC2K0VyOkFMb4IMgmGWEFwLwwz0EY3u1tDLyS6RH7
         5a0WElKyIqQ6JOfNloy4MCMnyyNiEdjCwlTCDQ98oiquSayJQlETKhEvVL4n8PnVffKu
         2Le00pV72T4x4+tx6UrIBdalrkGVu9iCKmOyus75wCtt271ET53IqN352encDUSevVSY
         i6XA==
X-Gm-Message-State: AOJu0YyctJjEYp++7bFZmRAgOxZPt0crm7RgByIbaiFMinRqw0xiBC9u
	GM04VRfUAsjhQXI+rWF7AGNpyc0z19WlBrNGdZM=
X-Google-Smtp-Source: AGHT+IE/NaC1/bNeILLeemr03nmz97tmQ7rrT8PD3zuQKSDJx3XMWOZ3drMmPSgLntUg4jvxqKfLN2qwPqfGmcbFV2I=
X-Received: by 2002:a2e:5c89:0:b0:2c9:f945:9ea6 with SMTP id
 q131-20020a2e5c89000000b002c9f9459ea6mr2150963ljb.5.1701898442358; Wed, 06
 Dec 2023 13:34:02 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <b38ecca96762d939d377c381bf34521ee5945129.1700601199.git.nabijaczleweli@nabijaczleweli.xyz>
In-Reply-To: <b38ecca96762d939d377c381bf34521ee5945129.1700601199.git.nabijaczleweli@nabijaczleweli.xyz>
From: Olga Kornievskaia <aglo@umich.edu>
Date: Wed, 6 Dec 2023 16:33:50 -0500
Message-ID: <CAN-5tyGfu9xcFHwD7G5+Hkan=19H1mmWenBm+g75M-uUwzzU7Q@mail.gmail.com>
Subject: Re: [PATCH nfs-utils v2 1/2] fsidd: call anonymous sockets by their
 name only, don't fill with NULs to 108 bytes
To: =?UTF-8?Q?Ahelenia_Ziemia=C5=84ska?= <nabijaczleweli@nabijaczleweli.xyz>
Cc: linux-nfs@vger.kernel.org, NeilBrown <neilb@suse.de>, 
	Steve Dickson <steved@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 21, 2023 at 4:15=E2=80=AFPM Ahelenia Ziemia=C5=84ska
<nabijaczleweli@nabijaczleweli.xyz> wrote:
>
> Since e00ab3c0616fe6d83ab0710d9e7d989c299088f7, ss -l looks like this:
>   u_seq               LISTEN                0                     5      =
                              @/run/fsid.sock@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@=
@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@ 26989379   =
                                                    * 0
> with fsidd pushing all the addresses to 108 bytes wide, which is deeply
> egregious if you don't filter it out and recolumnate.
>
> This is because, naturally (unix(7)), "Null bytes in the name have
> no special significance": abstract addresses are binary blobs, but
> paths automatically terminate at the first NUL byte, since paths
> can't contain those.
>
> So just specify the correct address length when we're using the abstract =
domain:
> unix(7) recommends "offsetof(struct sockaddr_un, sun_path) + strlen(sun_p=
ath) + 1"
> for paths, but we don't want to include the terminating NUL, so it's just
> "offsetof(struct sockaddr_un, sun_path) + strlen(sun_path)".
> This brings the width back to order:
> -- >8 --
> $ ss -la | grep @
> u_str ESTAB     0      0      @45208536ec96909a/bus/systemd-timesyn/bus-a=
pi-timesync 18500238                            * 18501249
> u_str ESTAB     0      0       @fecc9657d2315eb7/bus/systemd-network/bus-=
api-network 18495452                            * 18494406
> u_seq LISTEN    0      5                                             @/ru=
n/fsid.sock 27168796                            * 0
> u_str ESTAB     0      0                 @ac308f35f50797a2/bus/systemd-lo=
gind/system 19406                               * 15153
> u_str ESTAB     0      0                @b6606e0dfacbae75/bus/systemd/bus=
-api-system 18494353                            * 18495334
> u_str ESTAB     0      0                    @5880653d215718a7/bus/systemd=
/bus-system 26930876                            * 26930003
> -- >8 --
>
> Fixes: e00ab3c0616fe6d83ab0710d9e7d989c299088f7 ("fsidd: provide
>  better default socket name.")
> Signed-off-by: Ahelenia Ziemia=C5=84ska <nabijaczleweli@nabijaczleweli.xy=
z>
> ---
> v1: <04f3fe71defa757d518468f04f08334a5d0dfbb9.1693754442.git.nabijaczlewe=
li@nabijaczleweli.xyz>
> v2 NFC, addr_len declared at top of function
>
>  support/reexport/fsidd.c    | 9 ++++++---
>  support/reexport/reexport.c | 8 ++++++--
>  2 files changed, 12 insertions(+), 5 deletions(-)
>
> diff --git a/support/reexport/fsidd.c b/support/reexport/fsidd.c
> index 3e62b3fc..8a70b78f 100644
> --- a/support/reexport/fsidd.c
> +++ b/support/reexport/fsidd.c
> @@ -147,6 +147,7 @@ int main(void)
>  {
>         struct event *srv_ev;
>         struct sockaddr_un addr;
> +       socklen_t addr_len;
>         char *sock_file;
>         int srv;
>
> @@ -161,10 +162,12 @@ int main(void)
>         memset(&addr, 0, sizeof(struct sockaddr_un));
>         addr.sun_family =3D AF_UNIX;
>         strncpy(addr.sun_path, sock_file, sizeof(addr.sun_path) - 1);
> -       if (addr.sun_path[0] =3D=3D '@')
> +       addr_len =3D sizeof(struct sockaddr_un);
> +       if (addr.sun_path[0] =3D=3D '@') {
>                 /* "abstract" socket namespace */
> +               addr_len =3D offsetof(struct sockaddr_un, sun_path) + str=
len(addr.sun_path);
>                 addr.sun_path[0] =3D 0;
> -       else
> +       } else
>                 unlink(sock_file);
>
>         srv =3D socket(AF_UNIX, SOCK_SEQPACKET | SOCK_NONBLOCK, 0);
> @@ -173,7 +176,7 @@ int main(void)
>                 return 1;
>         }
>
> -       if (bind(srv, (const struct sockaddr *)&addr, sizeof(struct socka=
ddr_un)) =3D=3D -1) {
> +       if (bind(srv, (const struct sockaddr *)&addr, addr_len) =3D=3D -1=
) {
>                 xlog(L_WARNING, "Unable to bind %s: %m\n", sock_file);
>                 return 1;
>         }
> diff --git a/support/reexport/reexport.c b/support/reexport/reexport.c
> index 78516586..0fb49a46 100644
> --- a/support/reexport/reexport.c
> +++ b/support/reexport/reexport.c
> @@ -21,6 +21,7 @@ static int fsidd_srv =3D -1;
>  static bool connect_fsid_service(void)
>  {
>         struct sockaddr_un addr;
> +       socklen_t addr_len;
>         char *sock_file;
>         int ret;
>         int s;
> @@ -33,9 +34,12 @@ static bool connect_fsid_service(void)
>         memset(&addr, 0, sizeof(struct sockaddr_un));
>         addr.sun_family =3D AF_UNIX;
>         strncpy(addr.sun_path, sock_file, sizeof(addr.sun_path) - 1);
> -       if (addr.sun_path[0] =3D=3D '@')
> +       addr_len =3D sizeof(struct sockaddr_un);
> +       if (addr.sun_path[0] =3D=3D '@') {
>                 /* "abstract" socket namespace */
> +               addr_len =3D offsetof(struct sockaddr_un, sun_path) + str=
len(addr.sun_path);
>                 addr.sun_path[0] =3D 0;
> +       }
>
>         s =3D socket(AF_UNIX, SOCK_SEQPACKET, 0);
>         if (s =3D=3D -1) {
> @@ -43,7 +47,7 @@ static bool connect_fsid_service(void)
>                 return false;
>         }
>
> -       ret =3D connect(s, (const struct sockaddr *)&addr, sizeof(struct =
sockaddr_un));
> +       ret =3D connect(s, (const struct sockaddr *)&addr, addr_len);
>         if (ret =3D=3D -1) {
>                 xlog(L_WARNING, "Unable to connect %s: %m, is fsidd runni=
ng?\n", sock_file);
>                 return false;
> --
> 2.39.2
>

Hi folks,

I'm hitting the following compile error (in RHEL9.2). I believe the
code is missing an include for stddef.h. When I add it, things
compile. I'll submit a patch.

gcc -DHAVE_CONFIG_H -I. -I../../support/include  -I/usr/include/tirpc
-D_GNU_SOURCE -pipe  -Wall  -Wextra  -Werror=3Dstrict-prototypes
-Werror=3Dmissing-prototypes  -Werror=3Dmissing-declarations
-Werror=3Dformat=3D2  -Werror=3Dundef  -Werror=3Dmissing-include-dirs
-Werror=3Dstrict-aliasing=3D2  -Werror=3Dinit-self
-Werror=3Dimplicit-function-declaration  -Werror=3Dreturn-type
-Werror=3Dswitch  -Werror=3Doverflow  -Werror=3Dparentheses
-Werror=3Daggregate-return  -Werror=3Dunused-result  -fno-strict-aliasing
-Werror=3Dformat-overflow=3D2 -Werror=3Dint-conversion
-Werror=3Dincompatible-pointer-types -Werror=3Dmisleading-indentation
-Wno-cast-function-type -g -O2 -MT reexport.o -MD -MP -MF
.deps/reexport.Tpo -c -o reexport.o reexport.c
reexport.c: In function =E2=80=98connect_fsid_service=E2=80=99:
reexport.c:40:28: error: implicit declaration of function =E2=80=98offsetof=
=E2=80=99
[-Werror=3Dimplicit-function-declaration]
   40 |                 addr_len =3D offsetof(struct sockaddr_un,
sun_path) + strlen(addr.sun_path);
      |                            ^~~~~~~~
reexport.c:18:1: note: =E2=80=98offsetof=E2=80=99 is defined in header =E2=
=80=98<stddef.h>=E2=80=99;
did you forget to =E2=80=98#include <stddef.h>=E2=80=99?
   17 | #include "xlog.h"
  +++ |+#include <stddef.h>
   18 |
reexport.c:40:37: error: expected expression before =E2=80=98struct=E2=80=
=99
   40 |                 addr_len =3D offsetof(struct sockaddr_un,
sun_path) + strlen(addr.sun_path);
      |                                     ^~~~~~
cc1: some warnings being treated as errors
make[2]: *** [Makefile:529: reexport.o] Error 1
make[2]: Leaving directory '/home/aglo/nfs-utils/support/reexport'
make[1]: *** [Makefile:448: all-recursive] Error 1
make[1]: Leaving directory '/home/aglo/nfs-utils/support'


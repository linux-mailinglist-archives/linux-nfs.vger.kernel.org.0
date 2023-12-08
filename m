Return-Path: <linux-nfs+bounces-455-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A56F28096F0
	for <lists+linux-nfs@lfdr.de>; Fri,  8 Dec 2023 01:08:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0EDA52815B8
	for <lists+linux-nfs@lfdr.de>; Fri,  8 Dec 2023 00:08:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DBC5195;
	Fri,  8 Dec 2023 00:08:51 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2a07:de40:b251:101:10:150:64:1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 424FA170F
	for <linux-nfs@vger.kernel.org>; Thu,  7 Dec 2023 16:08:46 -0800 (PST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 60B15220D6;
	Fri,  8 Dec 2023 00:08:44 +0000 (UTC)
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C18E3136F5;
	Fri,  8 Dec 2023 00:08:42 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id zopGHIpecmWPdwAAD6G6ig
	(envelope-from <neilb@suse.de>); Fri, 08 Dec 2023 00:08:42 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "NeilBrown" <neilb@suse.de>
To: "Olga Kornievskaia" <aglo@umich.edu>
Cc: Ahelenia =?utf-8?q?Ziemia=C5=84ska?= <nabijaczleweli@nabijaczleweli.xyz>,
 linux-nfs@vger.kernel.org, "Steve Dickson" <steved@redhat.com>
Subject: Re: [PATCH nfs-utils v2 1/2] fsidd: call anonymous sockets by their
 name only, don't fill with NULs to 108 bytes
In-reply-to:
 <CAN-5tyGfu9xcFHwD7G5+Hkan=19H1mmWenBm+g75M-uUwzzU7Q@mail.gmail.com>
References: =?utf-8?q?=3Cb38ecca96762d939d377c381bf34521ee5945129=2E17006011?=
 =?utf-8?q?99=2Egit=2Enabijaczleweli=40nabijaczleweli=2Exyz=3E=2C?=
 <CAN-5tyGfu9xcFHwD7G5+Hkan=19H1mmWenBm+g75M-uUwzzU7Q@mail.gmail.com>
Date: Fri, 08 Dec 2023 11:08:39 +1100
Message-id: <170199411925.12910.14964427409507748000@noble.neil.brown.name>
X-Spamd-Result: default: False [3.79 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 RCPT_COUNT_THREE(0.00)[4];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 R_SPF_SOFTFAIL(4.60)[~all:c];
	 RCVD_COUNT_THREE(0.00)[3];
	 MX_GOOD(-0.01)[];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 R_DKIM_NA(2.20)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-3.00)[100.00%];
	 DMARC_POLICY_SOFTFAIL(0.10)[suse.de : No valid SPF, No valid DKIM,none]
X-Spamd-Bar: +++
Authentication-Results: smtp-out1.suse.de;
	dkim=none;
	dmarc=fail reason="No valid SPF, No valid DKIM" header.from=suse.de (policy=none);
	spf=softfail (smtp-out1.suse.de: 2a07:de40:b281:104:10:150:64:97 is neither permitted nor denied by domain of neilb@suse.de) smtp.mailfrom=neilb@suse.de
X-Rspamd-Server: rspamd1
X-Rspamd-Queue-Id: 60B15220D6
X-Spam-Score: 3.79

On Thu, 07 Dec 2023, Olga Kornievskaia wrote:
> On Tue, Nov 21, 2023 at 4:15=E2=80=AFPM Ahelenia Ziemia=C5=84ska
> <nabijaczleweli@nabijaczleweli.xyz> wrote:
> >
> > Since e00ab3c0616fe6d83ab0710d9e7d989c299088f7, ss -l looks like this:
> >   u_seq               LISTEN                0                     5      =
                              @/run/fsid.sock@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@=
@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@ 26989379       =
                                                * 0
> > with fsidd pushing all the addresses to 108 bytes wide, which is deeply
> > egregious if you don't filter it out and recolumnate.
> >
> > This is because, naturally (unix(7)), "Null bytes in the name have
> > no special significance": abstract addresses are binary blobs, but
> > paths automatically terminate at the first NUL byte, since paths
> > can't contain those.
> >
> > So just specify the correct address length when we're using the abstract =
domain:
> > unix(7) recommends "offsetof(struct sockaddr_un, sun_path) + strlen(sun_p=
ath) + 1"
> > for paths, but we don't want to include the terminating NUL, so it's just
> > "offsetof(struct sockaddr_un, sun_path) + strlen(sun_path)".
> > This brings the width back to order:
> > -- >8 --
> > $ ss -la | grep @
> > u_str ESTAB     0      0      @45208536ec96909a/bus/systemd-timesyn/bus-a=
pi-timesync 18500238                            * 18501249
> > u_str ESTAB     0      0       @fecc9657d2315eb7/bus/systemd-network/bus-=
api-network 18495452                            * 18494406
> > u_seq LISTEN    0      5                                             @/ru=
n/fsid.sock 27168796                            * 0
> > u_str ESTAB     0      0                 @ac308f35f50797a2/bus/systemd-lo=
gind/system 19406                               * 15153
> > u_str ESTAB     0      0                @b6606e0dfacbae75/bus/systemd/bus=
-api-system 18494353                            * 18495334
> > u_str ESTAB     0      0                    @5880653d215718a7/bus/systemd=
/bus-system 26930876                            * 26930003
> > -- >8 --
> >
> > Fixes: e00ab3c0616fe6d83ab0710d9e7d989c299088f7 ("fsidd: provide
> >  better default socket name.")
> > Signed-off-by: Ahelenia Ziemia=C5=84ska <nabijaczleweli@nabijaczleweli.xy=
z>
> > ---
> > v1: <04f3fe71defa757d518468f04f08334a5d0dfbb9.1693754442.git.nabijaczlewe=
li@nabijaczleweli.xyz>
> > v2 NFC, addr_len declared at top of function
> >
> >  support/reexport/fsidd.c    | 9 ++++++---
> >  support/reexport/reexport.c | 8 ++++++--
> >  2 files changed, 12 insertions(+), 5 deletions(-)
> >
> > diff --git a/support/reexport/fsidd.c b/support/reexport/fsidd.c
> > index 3e62b3fc..8a70b78f 100644
> > --- a/support/reexport/fsidd.c
> > +++ b/support/reexport/fsidd.c
> > @@ -147,6 +147,7 @@ int main(void)
> >  {
> >         struct event *srv_ev;
> >         struct sockaddr_un addr;
> > +       socklen_t addr_len;
> >         char *sock_file;
> >         int srv;
> >
> > @@ -161,10 +162,12 @@ int main(void)
> >         memset(&addr, 0, sizeof(struct sockaddr_un));
> >         addr.sun_family =3D AF_UNIX;
> >         strncpy(addr.sun_path, sock_file, sizeof(addr.sun_path) - 1);
> > -       if (addr.sun_path[0] =3D=3D '@')
> > +       addr_len =3D sizeof(struct sockaddr_un);
> > +       if (addr.sun_path[0] =3D=3D '@') {
> >                 /* "abstract" socket namespace */
> > +               addr_len =3D offsetof(struct sockaddr_un, sun_path) + str=
len(addr.sun_path);
> >                 addr.sun_path[0] =3D 0;
> > -       else
> > +       } else
> >                 unlink(sock_file);
> >
> >         srv =3D socket(AF_UNIX, SOCK_SEQPACKET | SOCK_NONBLOCK, 0);
> > @@ -173,7 +176,7 @@ int main(void)
> >                 return 1;
> >         }
> >
> > -       if (bind(srv, (const struct sockaddr *)&addr, sizeof(struct socka=
ddr_un)) =3D=3D -1) {
> > +       if (bind(srv, (const struct sockaddr *)&addr, addr_len) =3D=3D -1=
) {
> >                 xlog(L_WARNING, "Unable to bind %s: %m\n", sock_file);
> >                 return 1;
> >         }
> > diff --git a/support/reexport/reexport.c b/support/reexport/reexport.c
> > index 78516586..0fb49a46 100644
> > --- a/support/reexport/reexport.c
> > +++ b/support/reexport/reexport.c
> > @@ -21,6 +21,7 @@ static int fsidd_srv =3D -1;
> >  static bool connect_fsid_service(void)
> >  {
> >         struct sockaddr_un addr;
> > +       socklen_t addr_len;
> >         char *sock_file;
> >         int ret;
> >         int s;
> > @@ -33,9 +34,12 @@ static bool connect_fsid_service(void)
> >         memset(&addr, 0, sizeof(struct sockaddr_un));
> >         addr.sun_family =3D AF_UNIX;
> >         strncpy(addr.sun_path, sock_file, sizeof(addr.sun_path) - 1);
> > -       if (addr.sun_path[0] =3D=3D '@')
> > +       addr_len =3D sizeof(struct sockaddr_un);
> > +       if (addr.sun_path[0] =3D=3D '@') {
> >                 /* "abstract" socket namespace */
> > +               addr_len =3D offsetof(struct sockaddr_un, sun_path) + str=
len(addr.sun_path);
> >                 addr.sun_path[0] =3D 0;
> > +       }
> >
> >         s =3D socket(AF_UNIX, SOCK_SEQPACKET, 0);
> >         if (s =3D=3D -1) {
> > @@ -43,7 +47,7 @@ static bool connect_fsid_service(void)
> >                 return false;
> >         }
> >
> > -       ret =3D connect(s, (const struct sockaddr *)&addr, sizeof(struct =
sockaddr_un));
> > +       ret =3D connect(s, (const struct sockaddr *)&addr, addr_len);
> >         if (ret =3D=3D -1) {
> >                 xlog(L_WARNING, "Unable to connect %s: %m, is fsidd runni=
ng?\n", sock_file);
> >                 return false;
> > --
> > 2.39.2
> >
>=20
> Hi folks,
>=20
> I'm hitting the following compile error (in RHEL9.2). I believe the
> code is missing an include for stddef.h. When I add it, things
> compile. I'll submit a patch.
>=20
> gcc -DHAVE_CONFIG_H -I. -I../../support/include  -I/usr/include/tirpc
> -D_GNU_SOURCE -pipe  -Wall  -Wextra  -Werror=3Dstrict-prototypes
> -Werror=3Dmissing-prototypes  -Werror=3Dmissing-declarations
> -Werror=3Dformat=3D2  -Werror=3Dundef  -Werror=3Dmissing-include-dirs
> -Werror=3Dstrict-aliasing=3D2  -Werror=3Dinit-self
> -Werror=3Dimplicit-function-declaration  -Werror=3Dreturn-type
> -Werror=3Dswitch  -Werror=3Doverflow  -Werror=3Dparentheses
> -Werror=3Daggregate-return  -Werror=3Dunused-result  -fno-strict-aliasing
> -Werror=3Dformat-overflow=3D2 -Werror=3Dint-conversion
> -Werror=3Dincompatible-pointer-types -Werror=3Dmisleading-indentation
> -Wno-cast-function-type -g -O2 -MT reexport.o -MD -MP -MF
> .deps/reexport.Tpo -c -o reexport.o reexport.c
> reexport.c: In function =E2=80=98connect_fsid_service=E2=80=99:
> reexport.c:40:28: error: implicit declaration of function =E2=80=98offsetof=
=E2=80=99
> [-Werror=3Dimplicit-function-declaration]
>    40 |                 addr_len =3D offsetof(struct sockaddr_un,
> sun_path) + strlen(addr.sun_path);
>       |                            ^~~~~~~~
> reexport.c:18:1: note: =E2=80=98offsetof=E2=80=99 is defined in header =E2=
=80=98<stddef.h>=E2=80=99;
> did you forget to =E2=80=98#include <stddef.h>=E2=80=99?
>    17 | #include "xlog.h"
>   +++ |+#include <stddef.h>
>    18 |
> reexport.c:40:37: error: expected expression before =E2=80=98struct=E2=80=99
>    40 |                 addr_len =3D offsetof(struct sockaddr_un,
> sun_path) + strlen(addr.sun_path);
>       |                                     ^~~~~~
> cc1: some warnings being treated as errors
> make[2]: *** [Makefile:529: reexport.o] Error 1
> make[2]: Leaving directory '/home/aglo/nfs-utils/support/reexport'
> make[1]: *** [Makefile:448: all-recursive] Error 1
> make[1]: Leaving directory '/home/aglo/nfs-utils/support'
>=20


Interesting - in openSUSE, dlfcn.h includes stddef.h, which is why the
compile works for me.   Obviously we cannot rely on that.

reexport.c and fsidd.c will both need stddef.

Thanks!

NeilBrown


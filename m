Return-Path: <linux-nfs+bounces-21-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AFD97F37A8
	for <lists+linux-nfs@lfdr.de>; Tue, 21 Nov 2023 21:41:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 462791C20B34
	for <lists+linux-nfs@lfdr.de>; Tue, 21 Nov 2023 20:41:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1103855790;
	Tue, 21 Nov 2023 20:41:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-nfs@vger.kernel.org
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DE3FD45
	for <linux-nfs@vger.kernel.org>; Tue, 21 Nov 2023 12:41:05 -0800 (PST)
Received: from localhost (localhost [127.0.0.1])
	by lithops.sigma-star.at (Postfix) with ESMTP id EEBD7622F57C;
	Tue, 21 Nov 2023 21:41:02 +0100 (CET)
Received: from lithops.sigma-star.at ([127.0.0.1])
	by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
	with ESMTP id SIgBJyn8PSn5; Tue, 21 Nov 2023 21:41:02 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by lithops.sigma-star.at (Postfix) with ESMTP id 6AE5C622F591;
	Tue, 21 Nov 2023 21:41:02 +0100 (CET)
Received: from lithops.sigma-star.at ([127.0.0.1])
	by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id VEyKsmPq_YzI; Tue, 21 Nov 2023 21:41:02 +0100 (CET)
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
	by lithops.sigma-star.at (Postfix) with ESMTP id 43AC6622F57C;
	Tue, 21 Nov 2023 21:41:02 +0100 (CET)
Date: Tue, 21 Nov 2023 21:41:02 +0100 (CET)
From: Richard Weinberger <richard@nod.at>
To: Salvatore Bonaccorso <carnil@debian.org>
Cc: NeilBrown <neilb@suse.de>, Steve Dickson <steved@redhat.com>, 
	Ahelenia =?utf-8?Q?Ziemia=C5=84ska?= <nabijaczleweli@nabijaczleweli.xyz>, 
	linux-nfs <linux-nfs@vger.kernel.org>
Message-ID: <1045643521.1888.1700599262115.JavaMail.zimbra@nod.at>
In-Reply-To: <ZV0L9Y5bRxfWPRus@eldamar.lan>
References: <04f3fe71defa757d518468f04f08334a5d0dfbb9.1693754442.git.nabijaczleweli@nabijaczleweli.xyz> <ZV0L9Y5bRxfWPRus@eldamar.lan>
Subject: Re: [PATCH nfs-utils 1/2] fsidd: call anonymous sockets by their
 name only, don't fill with NULs to 108 bytes
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Mailer: Zimbra 8.8.12_GA_3807 (ZimbraWebClient - FF97 (Linux)/8.8.12_GA_3809)
Thread-Topic: fsidd: call anonymous sockets by their name only, don't fill with NULs to 108 bytes
Thread-Index: SZ9WUdVJ1jChxXfIT86JbtWyXl/XMQ==

----- Urspr=C3=BCngliche Mail -----
> Von: "Salvatore Bonaccorso" <carnil@debian.org>
> An: "NeilBrown" <neilb@suse.de>, "richard" <richard@nod.at>, "Steve Dicks=
on" <steved@redhat.com>
> CC: "Ahelenia Ziemia=C5=84ska" <nabijaczleweli@nabijaczleweli.xyz>, "linu=
x-nfs" <linux-nfs@vger.kernel.org>
> Gesendet: Dienstag, 21. November 2023 20:58:45
> Betreff: Re: [PATCH nfs-utils 1/2] fsidd: call anonymous sockets by their=
 name only, don't fill with NULs to 108 bytes

> Hi,
>=20
> Explicitly CC'ing people involved for the e00ab3c0616f ("fsidd:
> provide better default socket name.") change:
>=20
> On Sun, Sep 03, 2023 at 05:21:52PM +0200, Ahelenia Ziemia=C5=84ska wrote:
>> Since e00ab3c0616fe6d83ab0710d9e7d989c299088f7, ss -l looks like this:
>>   u_seq               LISTEN                0                     5
>>   @/run/fsid.sock@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@=
@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
>>   26989379                                                       * 0
>> with fsidd pushing all the addresses to 108 bytes wide, which is deeply
>> egregious if you don't filter it out and recolumnate.
>>=20
>> This is because, naturally (unix(7)), "Null bytes in the name have
>> no special significance": abstract addresses are binary blobs, but
>> paths automatically terminate at the first NUL byte, since paths
>> can't contain those.
>>=20
>> So just specify the correct address length when we're using the abstract=
 domain:
>> unix(7) recommends "offsetof(struct sockaddr_un, sun_path) + strlen(sun_=
path) +
>> 1"
>> for paths, but we don't want to include the terminating NUL, so it's jus=
t
>> "offsetof(struct sockaddr_un, sun_path) + strlen(sun_path)".
>> This brings the width back to order:
>> -- >8 --
>> $ ss -la | grep @
>> u_str ESTAB     0      0
>> @45208536ec96909a/bus/systemd-timesyn/bus-api-timesync 18500238
>> * 18501249
>> u_str ESTAB     0      0
>> @fecc9657d2315eb7/bus/systemd-network/bus-api-network 18495452
>> * 18494406
>> u_seq LISTEN    0      5
>> @/run/fsid.sock 27168796
>> * 0
>> u_str ESTAB     0      0
>> @ac308f35f50797a2/bus/systemd-logind/system 19406
>> * 15153
>> u_str ESTAB     0      0
>> @b6606e0dfacbae75/bus/systemd/bus-api-system 18494353
>> * 18495334
>> u_str ESTAB     0      0
>> @5880653d215718a7/bus/systemd/bus-system 26930876
>> * 26930003
>> -- >8 --
>>=20
>> Fixes: e00ab3c0616fe6d83ab0710d9e7d989c299088f7 ("fsidd: provide
>>  better default socket name.")
>> Signed-off-by: Ahelenia Ziemia=C5=84ska <nabijaczleweli@nabijaczleweli.x=
yz>
>> ---
>>  support/reexport/fsidd.c    | 8 +++++---
>>  support/reexport/reexport.c | 7 +++++--
>>  2 files changed, 10 insertions(+), 5 deletions(-)
>>=20
>> diff --git a/support/reexport/fsidd.c b/support/reexport/fsidd.c
>> index d4b245e8..4c377415 100644
>> --- a/support/reexport/fsidd.c
>> +++ b/support/reexport/fsidd.c
>> @@ -171,10 +171,12 @@ int main(void)
>>  =09memset(&addr, 0, sizeof(struct sockaddr_un));
>>  =09addr.sun_family =3D AF_UNIX;
>>  =09strncpy(addr.sun_path, sock_file, sizeof(addr.sun_path) - 1);
>> -=09if (addr.sun_path[0] =3D=3D '@')
>> +=09socklen_t addr_len =3D sizeof(struct sockaddr_un);
>> +=09if (addr.sun_path[0] =3D=3D '@') {
>>  =09=09/* "abstract" socket namespace */
>> +=09=09addr_len =3D offsetof(struct sockaddr_un, sun_path) + strlen(addr=
.sun_path);
>>  =09=09addr.sun_path[0] =3D 0;
>> -=09else
>> +=09} else
>>  =09=09unlink(sock_file);
>> =20
>>  =09srv =3D socket(AF_UNIX, SOCK_SEQPACKET | SOCK_NONBLOCK, 0);
>> @@ -183,7 +185,7 @@ int main(void)
>>  =09=09return 1;
>>  =09}
>> =20
>> -=09if (bind(srv, (const struct sockaddr *)&addr, sizeof(struct sockaddr=
_un)) =3D=3D
>> -1) {
>> +=09if (bind(srv, (const struct sockaddr *)&addr, addr_len) =3D=3D -1) {
>>  =09=09xlog(L_WARNING, "Unable to bind %s: %m\n", sock_file);
>>  =09=09return 1;
>>  =09}
>> diff --git a/support/reexport/reexport.c b/support/reexport/reexport.c
>> index d9a700af..b7ee6f46 100644
>> --- a/support/reexport/reexport.c
>> +++ b/support/reexport/reexport.c
>> @@ -40,9 +40,12 @@ static bool connect_fsid_service(void)
>>  =09memset(&addr, 0, sizeof(struct sockaddr_un));
>>  =09addr.sun_family =3D AF_UNIX;
>>  =09strncpy(addr.sun_path, sock_file, sizeof(addr.sun_path) - 1);
>> -=09if (addr.sun_path[0] =3D=3D '@')
>> +=09socklen_t addr_len =3D sizeof(struct sockaddr_un);
>> +=09if (addr.sun_path[0] =3D=3D '@') {
>>  =09=09/* "abstract" socket namespace */
>> +=09=09addr_len =3D offsetof(struct sockaddr_un, sun_path) + strlen(addr=
.sun_path);
>>  =09=09addr.sun_path[0] =3D 0;
>> +=09}
>> =20
>>  =09s =3D socket(AF_UNIX, SOCK_SEQPACKET, 0);
>>  =09if (s =3D=3D -1) {
>> @@ -50,7 +53,7 @@ static bool connect_fsid_service(void)
>>  =09=09return false;
>>  =09}
>> =20
>> -=09ret =3D connect(s, (const struct sockaddr *)&addr, sizeof(struct soc=
kaddr_un));
>> +=09ret =3D connect(s, (const struct sockaddr *)&addr, addr_len);
>>  =09if (ret =3D=3D -1) {
>>  =09=09xlog(L_WARNING, "Unable to connect %s: %m, is fsidd running?\n", =
sock_file);
>>  =09=09return false;
>> --
>> 2.40.1
>=20
> Did this one felt trough the cracks?

At least it never hit my inbox.
Change looks good to me.

Thanks,
//richard


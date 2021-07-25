Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F64E3D4F06
	for <lists+linux-nfs@lfdr.de>; Sun, 25 Jul 2021 19:14:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229584AbhGYQeX (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sun, 25 Jul 2021 12:34:23 -0400
Received: from smtpcmd15176.aruba.it ([62.149.156.176]:60665 "EHLO
        smtpcmd15176.aruba.it" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229545AbhGYQeX (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sun, 25 Jul 2021 12:34:23 -0400
Received: from smtpclient.apple ([146.241.181.181])
        by Aruba Outgoing Smtp  with ESMTPA
        id 7hiEmJAq8GRi47hiEmTLfE; Sun, 25 Jul 2021 19:14:51 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=aruba.it; s=a1;
        t=1627233291; bh=JOM6Sb7NYD+BpaPgIHYi11VEZfYCdFAQDkjjGVkR84Y=;
        h=Content-Type:From:Mime-Version:Subject:Date:To;
        b=UQp+BE6sqmSxyQtNc59XpuRdYEK8pvv5Fmx1luQb8gf0XSSovD7re0HzO6FFKYbux
         X5TekTDz0CqmQeN77NiaYCC+nXlwy73fojezh/dZmbBAhAZydZ6XjCfkBm3RcfI8Fl
         3a5iv/tnvaY3tZ5VbM5iqoiLE0AW0N2DLiPi3Tsw8U0temtr6TzGco5VOOPAlA2jxh
         W2F5wrDqA80HP+p8I9bmIZEdYOt6GdB1ix8oTSccIal+59Jtv4erk5TDMBbkSrnvU8
         9/BTPX2xpj3PjK0kaEh0vlleS4qrwNtl136CbiJfEwIOylt/uWz5M5WuIaIvROTD2j
         0Y3x0a1/3vVVw==
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From:   Giulio Benetti <giulio.benetti@benettiengineering.com>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH] nfs-utils: fix time_t build error on 64-bits platforms
Date:   Sun, 25 Jul 2021 19:14:50 +0200
Message-Id: <9066A3FB-22C8-4E99-BDA8-A0FC794888B6@benettiengineering.com>
References: <793a60e6-4adb-99f5-89de-1c0877347e4c@redhat.com>
Cc:     linux-nfs@vger.kernel.org
In-Reply-To: <793a60e6-4adb-99f5-89de-1c0877347e4c@redhat.com>
To:     Steve Dickson <steved@redhat.com>
X-Mailer: iPhone Mail (18F72)
X-CMAE-Envelope: MS4xfE1X8vbh/miahVldVWfQ5udMPym6N8K7ZF8c1foxVeFzQTxnqutffBnq5waf3Egh8jbS6B3EUxSgzUvOw2cEvzL6GR9totcAeZ2tOgEcTwZVUahyUMmH
 s4d78iIPjsg6kSD6mY6dmQT/SbcrIlkb5UjDOYCZPOi4QE9uenKIam2s98K60OgRqm+iwv/YD5LE4/KA4sEDLbBpwDP4wzEbndnD48OzFD7WZoE1CFVnMsjM
 EJGneZ5TvvUFu+RN7ps3vw==
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hello Steve,

> Il giorno 25 lug 2021, alle ore 19:05, Steve Dickson <steved@redhat.com> h=
a scritto:
>=20
> =EF=BB=BFHello,
>=20
>> On 7/22/21 11:24 AM, Giulio Benetti wrote:
>> When passing time_t type to "%ld" on 64-bits platforms where time_t is a
>> 'long long' we encouter this build failure:
>> error: format =E2=80=98%ld=E2=80=99 expects argument of type =E2=80=98lon=
g int=E2=80=99, but argument 4 has type =E2=80=98time_t=E2=80=99 {aka =E2=80=
=98long long int=E2=80=99} [-Werror=3Dformat=3D]
>> So let's change "%ld" markers to "%lld" assuming it to be a 64-bits and
>> cast variables to '(long long)' if the type is a time_t.
> Just an FYI... I will be using Petr's patches [1] and [2]
> since they used the inittypes defines which seem a
> bit more portable and they do the same thing.

Sure, I=E2=80=99ve missed those patches, thank you for pointing so I can use=
 them in Buildroot instead of this one.

Best regards
Giulio Benetti

>=20
> steved.
>=20
> [1] https://marc.info/?l=3Dlinux-nfs&m=3D162697054816925&w=3D2
> [2] https://marc.info/?l=3Dlinux-nfs&m=3D162697054816926&w=3D2
>> Signed-off-by: Giulio Benetti <giulio.benetti@benettiengineering.com>
>> ---
>>  utils/nfsdcltrack/nfsdcltrack.c | 2 +-
>>  utils/nfsdcltrack/sqlite.c      | 4 ++--
>>  2 files changed, 3 insertions(+), 3 deletions(-)
>> diff --git a/utils/nfsdcltrack/nfsdcltrack.c b/utils/nfsdcltrack/nfsdcltr=
ack.c
>> index e926f1c0..437477bb 100644
>> --- a/utils/nfsdcltrack/nfsdcltrack.c
>> +++ b/utils/nfsdcltrack/nfsdcltrack.c
>> @@ -525,7 +525,7 @@ cltrack_gracedone(const char *timestr)
>>      if (*tail)
>>          return -EINVAL;
>>  -    xlog(D_GENERAL, "%s: grace done. gracetime=3D%ld", __func__, gracet=
ime);
>> +    xlog(D_GENERAL, "%s: grace done. gracetime=3D%lld", __func__, (long l=
ong)gracetime);
>>        ret =3D sqlite_remove_unreclaimed(gracetime);
>>  diff --git a/utils/nfsdcltrack/sqlite.c b/utils/nfsdcltrack/sqlite.c
>> index f79aebb3..6e603087 100644
>> --- a/utils/nfsdcltrack/sqlite.c
>> +++ b/utils/nfsdcltrack/sqlite.c
>> @@ -544,8 +544,8 @@ sqlite_remove_unreclaimed(time_t grace_start)
>>      int ret;
>>      char *err =3D NULL;
>>  -    ret =3D snprintf(buf, sizeof(buf), "DELETE FROM clients WHERE time <=
 %ld",
>> -            grace_start);
>> +    ret =3D snprintf(buf, sizeof(buf), "DELETE FROM clients WHERE time <=
 %lld",
>> +            (long long)grace_start);
>>      if (ret < 0) {
>>          return ret;
>>      } else if ((size_t)ret >=3D sizeof(buf)) {
>=20


Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D2680194AD5
	for <lists+linux-nfs@lfdr.de>; Thu, 26 Mar 2020 22:44:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726422AbgCZVo0 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 26 Mar 2020 17:44:26 -0400
Received: from mx2.suse.de ([195.135.220.15]:49692 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726270AbgCZVo0 (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Thu, 26 Mar 2020 17:44:26 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 12261AA7C;
        Thu, 26 Mar 2020 21:44:24 +0000 (UTC)
From:   NeilBrown <neilb@suse.de>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        linux-kernel@vger.kernel.org
Date:   Fri, 27 Mar 2020 08:44:17 +1100
Cc:     linux-nfs@vger.kernel.org, kernel-janitors@vger.kernel.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH 2/2] SUNRPC: Optimize 'svc_print_xprts()'
In-Reply-To: <2e2d1293-c978-3f1d-5a1e-dc43dc2ad06b@wanadoo.fr>
References: <20200325070452.22043-1-christophe.jaillet@wanadoo.fr> <EA5BCDB2-DB05-4B26-8635-E6F5C231DDC6@oracle.com> <42afbf1f-19e1-a05c-e70c-1d46eaba3a71@wanadoo.fr> <87wo786o80.fsf@notabene.neil.brown.name> <2e2d1293-c978-3f1d-5a1e-dc43dc2ad06b@wanadoo.fr>
Message-ID: <87r1xe7pvy.fsf@notabene.neil.brown.name>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha256; protocol="application/pgp-signature"
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

--=-=-=
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 26 2020, Christophe JAILLET wrote:

> Le 25/03/2020 =C3=A0 23:53, NeilBrown a =C3=A9crit=C2=A0:
>> Can I suggest something more like this:
>> diff --git a/net/sunrpc/svc_xprt.c b/net/sunrpc/svc_xprt.c
>> index de3c077733a7..0292f45b70f6 100644
>> --- a/net/sunrpc/svc_xprt.c
>> +++ b/net/sunrpc/svc_xprt.c
>> @@ -115,16 +115,9 @@ int svc_print_xprts(char *buf, int maxlen)
>>   	buf[0] =3D '\0';
>>=20=20=20
>>   	spin_lock(&svc_xprt_class_lock);
>> -	list_for_each_entry(xcl, &svc_xprt_class_list, xcl_list) {
>> -		int slen;
>> -
>> -		sprintf(tmpstr, "%s %d\n", xcl->xcl_name, xcl->xcl_max_payload);
>> -		slen =3D strlen(tmpstr);
>> -		if (len + slen > maxlen)
>> -			break;
>> -		len +=3D slen;
>> -		strcat(buf, tmpstr);
>> -	}
>> +	list_for_each_entry(xcl, &svc_xprt_class_list, xcl_list)
>> +		len +=3D scnprintf(buf + len, maxlen - len, "%s %d\n",
>> +				 xcl->xcl_name, xcl->xcl_max_payload);
>>   	spin_unlock(&svc_xprt_class_lock);
>>=20=20=20
>>   	return len;
>>
>> NeilBrown
>
> Hi,
>
> this was what I suggested in the patch:
>  =C2=A0=C2=A0=C2=A0 ---
>  =C2=A0=C2=A0=C2=A0 This patch should have no functional change.
>  =C2=A0=C2=A0=C2=A0 We could go further, use scnprintf and write directly=
 in the=20
> destination
>  =C2=A0=C2=A0=C2=A0 buffer. However, this could lead to a truncated last =
line.
>  =C2=A0=C2=A0=C2=A0 ---

Sorry - I missed that.
So add

 end =3D strrchr(tmpstr, '\n');
 if (end)
    end[1] =3D 0;
 else
    tmpstr[0] =3D 0;

or maybe something like
	list_for_each_entry(xcl, &svc_xprt_class_list, xcl_list) {
		int l =3D snprintf(buf + len, maxlen - len, "%s %d\n",
				 xcl->xcl_name, xcl->xcl_max_payload);
                if (l < maxlen - len)
                	len +=3D l;
        }
        buf[len] =3D 0;

There really is no need to have the secondary buffer, and I think doing
so just complicates the code.
That last version is a change of behaviour in that it will skip over
lines that are too long, rather than aborting on the first one.
I don't know which is preferred.

Thanks,
NeilBrown
=20

>
> And Chuck Lever confirmed that:
>  =C2=A0=C2=A0=C2=A0 That's exactly what this function is trying to avoid.=
 As part of any
>  =C2=A0=C2=A0=C2=A0 change in this area, it would be good to replace the =
current block
>  =C2=A0=C2=A0=C2=A0 comment before this function with a Doxygen-format co=
mment that
>  =C2=A0=C2=A0=C2=A0 documents that goal.
>
> So, I will only send a V2 based on comments already received.
>
> CJ

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEG8Yp69OQ2HB7X0l6Oeye3VZigbkFAl59IjEACgkQOeye3VZi
gbmUPg/9EV6cZxRae5hgXZCWW9ODQKt1pH+ZIMVmP2UWNb+3mv6hPhNsGY1ED3xE
4Ktqrz/6hiP8WHvNjZfmy1dAU7pqBnBJbZyfpfe2bBcvYZW7YI3oH/aliB+3KoLa
qJ3FljZh9XnnaJ3f8qv77+G3+6vnrFioJhw1dFjn8WQZMY5FLPEUdLMu92GrKvQl
I5DKtHTubYZ2OAT5n+D1duYfmiUBy9zV39ed1poMhfhAWuyYtprUGXiWw16DiDfH
dbD5chlzkKL0HQwKclWTBpoxXoYn2NiUSNOiLmLRKZKBCHC1ry5+awc6nIy2xISI
SuwRZfnCTuUYxFKjHO42ZqWgt0rX9xL+31mCbZt5jSV4ODo5jHSmAkSEwzcYNzwr
GSe9o2T/Km6p0eWROf+mrxSy+NGmZqMpKqCkldWcu+dMA9o9UWk0AIfuU4vJTfkK
LFxj86WFiL+r369g3XWPcyYh41v8iZmz48I1JV92IZ2xxCS+eI0KeoCw9cMA31IR
S7BCSI5KazLdA8QVoVyTZX44SSvq9tiHTTrmrsIWtCU6k777o72o5E+bccyubCMb
Wo6kFjlkahhCjF5UzY8HhnFofK218VGrhOIXqZ+X6nctA2KRDHPaSEQ1rXq509sO
aWXiq5sSoIrwStrkyIk/6R1O/zGZDmgRJ0AvlUjxRjdio4wsyII=
=oJ/H
-----END PGP SIGNATURE-----
--=-=-=--

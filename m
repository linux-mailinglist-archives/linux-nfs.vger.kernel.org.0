Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 954171933E2
	for <lists+linux-nfs@lfdr.de>; Wed, 25 Mar 2020 23:53:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727417AbgCYWx2 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 25 Mar 2020 18:53:28 -0400
Received: from mx2.suse.de ([195.135.220.15]:54188 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727399AbgCYWx2 (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Wed, 25 Mar 2020 18:53:28 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id E7F1AAD88;
        Wed, 25 Mar 2020 22:53:25 +0000 (UTC)
From:   NeilBrown <neilb@suse.de>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        linux-kernel@vger.kernel.org
Date:   Thu, 26 Mar 2020 09:53:19 +1100
Cc:     linux-nfs@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH 2/2] SUNRPC: Optimize 'svc_print_xprts()'
In-Reply-To: <42afbf1f-19e1-a05c-e70c-1d46eaba3a71@wanadoo.fr>
References: <20200325070452.22043-1-christophe.jaillet@wanadoo.fr> <EA5BCDB2-DB05-4B26-8635-E6F5C231DDC6@oracle.com> <42afbf1f-19e1-a05c-e70c-1d46eaba3a71@wanadoo.fr>
Message-ID: <87wo786o80.fsf@notabene.neil.brown.name>
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

On Wed, Mar 25 2020, Christophe JAILLET wrote:

> Le 25/03/2020 =C3=A0 15:52, Chuck Lever a =C3=A9crit=C2=A0:
>> Hi Christophe,
>>
>>
>>> On Mar 25, 2020, at 3:04 AM, Christophe JAILLET <christophe.jaillet@wan=
adoo.fr> wrote:
>>>
>>> Using 'snprintf' is safer than 'sprintf' because it can avoid a buffer
>>> overflow.
>> That's true as a general statement, but how likely is such an
>> overflow to occur here?
>>
> I guess, that it us unlikely and that the 80 chars buffer is big enough.
> That is the exact reason of why I've proposed 2 patches. The first one=20
> could happen in RL. The 2nd is more like a clean-up and is less=20
> relevant, IMHO.
>>
>>> The return value can also be used to avoid a strlen a call.
>> That's also true of sprintf, isn't it?
>
> Sure.
>
>
>>
>>> Finally, we know where we need to copy and the length to copy, so, we
>>> can save a few cycles by rearraging the code and using a memcpy instead=
 of
>>> a strcat.
>> I would be OK with squashing these two patches together. I don't
>> see the need to keep the two changes separated.
>
> NP, I can resend as a V2 with your comments.
> As said above, the first fixes something that could, IMHO, happen and=20
> the 2nd is more a matter of taste and a clean-up.
>
>
>>
>>> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
>>> ---
>>> This patch should have no functionnal change.
>>> We could go further, use scnprintf and write directly in the destination
>>> buffer. However, this could lead to a truncated last line.
>> That's exactly what this function is trying to avoid. As part of any
>> change in this area, it would be good to replace the current block
>> comment before this function with a Doxygen-format comment that
>> documents that goal.
>
> I'll take care of it.
>
>
>>> ---
>>> net/sunrpc/svc_xprt.c | 8 ++++----
>>> 1 file changed, 4 insertions(+), 4 deletions(-)
>>>
>>> diff --git a/net/sunrpc/svc_xprt.c b/net/sunrpc/svc_xprt.c
>>> index df39e7b8b06c..6df861650040 100644
>>> --- a/net/sunrpc/svc_xprt.c
>>> +++ b/net/sunrpc/svc_xprt.c
>>> @@ -118,12 +118,12 @@ int svc_print_xprts(char *buf, int maxlen)
>>> 	list_for_each_entry(xcl, &svc_xprt_class_list, xcl_list) {
>>> 		int slen;
>>>
>>> -		sprintf(tmpstr, "%s %d\n", xcl->xcl_name, xcl->xcl_max_payload);
>>> -		slen =3D strlen(tmpstr);
>>> -		if (len + slen >=3D maxlen)
>>> +		slen =3D snprintf(tmpstr, sizeof(tmpstr), "%s %d\n",
>>> +				xcl->xcl_name, xcl->xcl_max_payload);
>>> +		if (slen >=3D sizeof(tmpstr) || len + slen >=3D maxlen)
>>> 			break;
>>> +		memcpy(buf + len, tmpstr, slen + 1);
>>> 		len +=3D slen;
>>> -		strcat(buf, tmpstr);
>> IMO replacing the strcat makes the code harder to read, and this
>> is certainly not a performance path. Can you drop that part of the
>> patch?
>
> Ok
>
>
>>
>>> 	}
>>> 	spin_unlock(&svc_xprt_class_lock);
>>>
>>> --=20

Can I suggest something more like this:

diff --git a/net/sunrpc/svc_xprt.c b/net/sunrpc/svc_xprt.c
index de3c077733a7..0292f45b70f6 100644
=2D-- a/net/sunrpc/svc_xprt.c
+++ b/net/sunrpc/svc_xprt.c
@@ -115,16 +115,9 @@ int svc_print_xprts(char *buf, int maxlen)
 	buf[0] =3D '\0';
=20
 	spin_lock(&svc_xprt_class_lock);
=2D	list_for_each_entry(xcl, &svc_xprt_class_list, xcl_list) {
=2D		int slen;
=2D
=2D		sprintf(tmpstr, "%s %d\n", xcl->xcl_name, xcl->xcl_max_payload);
=2D		slen =3D strlen(tmpstr);
=2D		if (len + slen > maxlen)
=2D			break;
=2D		len +=3D slen;
=2D		strcat(buf, tmpstr);
=2D	}
+	list_for_each_entry(xcl, &svc_xprt_class_list, xcl_list)
+		len +=3D scnprintf(buf + len, maxlen - len, "%s %d\n",
+				 xcl->xcl_name, xcl->xcl_max_payload);
 	spin_unlock(&svc_xprt_class_lock);
=20
 	return len;

NeilBrown

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEG8Yp69OQ2HB7X0l6Oeye3VZigbkFAl574N8ACgkQOeye3VZi
gblt1g/9HiVqAgfOAczPAHMlZ3fEpsGid1IWxmMW6KeiZkcNztY76eVboisWNlPs
ZZK88kbrsOAKqagKDyKbRc1qbEFBfMQd0EGzQm4J562fO0YQgF7MwGVhBfxXGEeL
ca9GPo2ZqG2p9/9FjFIk+/kOYk/8WMpK9noKlKR4Nqk/C+jW2jqNtZf/f6BE1OU/
js7FCd0iK4KQSLGXSKT4i9puHiJoZMi0d+7bAxWDxub9UFrQk5yk1HQDQK6EuQj0
hhalu5Pz3KoBih6gzlVLR0O2rUGr8abLRM/L0Cwa3p2113gymBmsEVPJyAQ2O5E/
ohyRZCeGKMs9RXAcsAjFUr6CVmeJFvT+P35wbDT29V5wbnOja0R8UubAVxg8PPnm
ZPrGeDVzOrKvRWoydX1mPffpj8PexJvJSZaXvDugmqY30WKDgDsjg7vsHox7oRC7
R0MY26ilBwsvdrsegZlr3J7jRIcDj+ItkLoKYubhu0VUMQSyGZlP++Cz43PdQD21
dujfjUKOVQvZ3h3IKO8L7Zo8hcetaKwDqCtrigO0O0IrClfSX7Jtrojnyj8jUobB
67x/pEkRB8WVXI6ldungASWirIir5COofkJCVRNPeQDk6tFKb4blb5jqA8Xxi/Xt
gua4apqXIK9M1nmXvriKSzVmiB+RRJG6Tjx+jfqNaDi8WRZKcyI=
=aTlo
-----END PGP SIGNATURE-----
--=-=-=--

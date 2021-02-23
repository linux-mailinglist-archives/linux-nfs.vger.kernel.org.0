Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D8D2322CEE
	for <lists+linux-nfs@lfdr.de>; Tue, 23 Feb 2021 15:55:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232171AbhBWOzg (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 23 Feb 2021 09:55:36 -0500
Received: from btbn.de ([5.9.118.179]:53356 "EHLO btbn.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231591AbhBWOzc (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Tue, 23 Feb 2021 09:55:32 -0500
Received: from [IPv6:2001:16b8:6400:6a00:b95b:a0e2:14c2:38f0] (200116b864006a00b95ba0e214c238f0.dip.versatel-1u1.de [IPv6:2001:16b8:6400:6a00:b95b:a0e2:14c2:38f0])
        by btbn.de (Postfix) with ESMTPSA id BC1BF1ACEFC;
        Tue, 23 Feb 2021 15:54:47 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rothenpieler.org;
        s=mail; t=1614092087;
        bh=vidYkvw7js5hb1PcR4yaf72vReZJ40NHEc7GajqrV3E=;
        h=Subject:To:References:From:Date:In-Reply-To;
        b=VBGI60BJWiulGSt0rB8tVBin7gk2WEi5OIbU0b55Tvf5TMEgK4G1huCOpsTypzDH5
         LKQSwwDllThi12o5Tm0gHC7vvqWSPj6DlI4Wy2prubkPnJubTTmR1YTKRQOmOwkGSt
         oCvF9rqfvVEpwxO/VgoZkyWCZI2r0NwGuHrZbDn9wTVs3lFsnHRQ208YMuw+77X6w/
         wpiZjXA9BnWzQAaSLjD4JrE6K0tm7WZM7HljtbsEiprpVljfh/I04qqROp6TE6zagN
         0kjOFc1h30NQCR8gzkG3CCkLk/Wy1ltHogiUaKvjMhr7CfD3MslencuZqp2dLzmbO1
         z2+f4XkjO3tjA==
Subject: Re: [PATCH] nfs: fix PNFS_FLEXFILE_LAYOUT Kconfig default
To:     Trond Myklebust <trondmy@hammerspace.com>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
References: <20210223141901.1652-1-timo@rothenpieler.org>
 <6626a1877551f25f8e57addc720acba5af674d1f.camel@hammerspace.com>
From:   Timo Rothenpieler <timo@rothenpieler.org>
Message-ID: <4a53c37a-89bd-d7e7-9597-4117825b4a19@rothenpieler.org>
Date:   Tue, 23 Feb 2021 15:54:45 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <6626a1877551f25f8e57addc720acba5af674d1f.camel@hammerspace.com>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256; boundary="------------ms050604030902070107040506"
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

This is a cryptographically signed message in MIME format.

--------------ms050604030902070107040506
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 23.02.2021 15:51, Trond Myklebust wrote:
> On Tue, 2021-02-23 at 15:19 +0100, Timo Rothenpieler wrote:
>> This follows what was done in
>> 8c2fabc6542d9d0f8b16bd1045c2eda59bdcde13.
>> With the default being m, it's impossible to build the module into
>> the
>> kernel.
>>
>> Signed-off-by: Timo Rothenpieler <timo@rothenpieler.org>
>> ---
>>  =C2=A0fs/nfs/Kconfig | 2 +-
>>  =C2=A01 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/fs/nfs/Kconfig b/fs/nfs/Kconfig
>> index e2a488d403a6..14a72224b657 100644
>> --- a/fs/nfs/Kconfig
>> +++ b/fs/nfs/Kconfig
>> @@ -127,7 +127,7 @@ config PNFS_BLOCK
>>  =C2=A0config PNFS_FLEXFILE_LAYOUT
>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0tristate
>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0depends on NFS_V4_1 &=
& NFS_V3
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0default m
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0default NFS_V4
>>  =20
>=20
> Let's just make that
>=20
>      default y
>=20
> ...and let the dependencies work out whether or not this needs to be a
> 'y', 'm' or 'N'. Tying it to NFS_V4 just makes the Kconfig harder to
> read, with the result being the same anyway.

Sure. Should I change the other two PNFS_ configs to default to y as=20
well while at it?


--------------ms050604030902070107040506
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

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
LnAuQS4xLDAqBgNVBAMMI0FjdGFsaXMgQ2xpZW50IEF1dGhlbnRpY2F0aW9uIENBIEczMIIC
IjANBgkqhkiG9w0BAQEFAAOCAg8AMIICCgKCAgEA7eaHlqHBpLbtwkJV9z8PDyJgXxPgpkOI
hkmReRwbLxpQD9xGAe72ujqGzFFh78QPgAhxKVqtGHzYeq0VJVCzhnCKRBbVX+JwIhL3ULYh
UAZrViUp952qDB6qTL5sGeJS9F69VPSR5k6pFNw7mHDTTt0voWFg2aVkG3khomzVXoieJGOi
Q4dH76paCtQbLkt59joAKz2BnwGLQ4wr09nfumJt5AKx2YxHK2XgSPslVZ4z8G00gimsfA7U
tjT/wiekY6Z0b7ksLrEcvODncHQe9VSrNRA149SE3AlkWaZM/joVei/GYfj9K5jkiReinR4m
qM353FEceLOeBhSTURpMdQ5wsXLi9DSTGBuNv4aw2Dozb/qBlkhGTvwk92mi0jAecE22Sn3A
9UfrU2p1w/uRs+TIteQ0xO0B/J2mY2caqocsS9SsriIGlQ8b0LT0o6Ob07KGtPa5/lIvMmx5
72Dv2v+vDiECByxm1Hdgjp8JtE4mdyYP6GBscJyT71NZw1zXHnFkyCbxReag9qaSR9x4CVVX
j1BDmNROCqd5NAfIXUXYTFeZ/jukQigkxXGWhEhfLBC4Ha6pwizz9fq1+wwPKcWaF9P/SZOu
BDrG30MiyCZa66G9mEtF5ZLuh4rGfKqxy4Z5Mxecuzt+MZmrSKfKGeXOeED/iuX5Z02M1o7i
MS8CAwEAAaOCAfQwggHwMA8GA1UdEwEB/wQFMAMBAf8wHwYDVR0jBBgwFoAUUtiIOsifeGbt
ifN7OHCUyQICNtAwQQYIKwYBBQUHAQEENTAzMDEGCCsGAQUFBzABhiVodHRwOi8vb2NzcDA1
LmFjdGFsaXMuaXQvVkEvQVVUSC1ST09UMEUGA1UdIAQ+MDwwOgYEVR0gADAyMDAGCCsGAQUF
BwIBFiRodHRwczovL3d3dy5hY3RhbGlzLml0L2FyZWEtZG93bmxvYWQwHQYDVR0lBBYwFAYI
KwYBBQUHAwIGCCsGAQUFBwMEMIHjBgNVHR8EgdswgdgwgZaggZOggZCGgY1sZGFwOi8vbGRh
cDA1LmFjdGFsaXMuaXQvY24lM2RBY3RhbGlzJTIwQXV0aGVudGljYXRpb24lMjBSb290JTIw
Q0EsbyUzZEFjdGFsaXMlMjBTLnAuQS4lMmYwMzM1ODUyMDk2NyxjJTNkSVQ/Y2VydGlmaWNh
dGVSZXZvY2F0aW9uTGlzdDtiaW5hcnkwPaA7oDmGN2h0dHA6Ly9jcmwwNS5hY3RhbGlzLml0
L1JlcG9zaXRvcnkvQVVUSC1ST09UL2dldExhc3RDUkwwHQYDVR0OBBYEFL6XqaqEv4C/EFN9
CTL54S4yG893MA4GA1UdDwEB/wQEAwIBBjANBgkqhkiG9w0BAQsFAAOCAgEAJpvnG1kNdLMS
A+nnVfeEgIXNQsM7YRxXx6bmEt9IIrFlH1qYKeNw4NV8xtop91Rle168wghmYeCTP10FqfuK
MZsleNkI8/b3PBkZLIKOl9p2Dmz2Gc0I3WvcMbAgd/IuBtx998PJX/bBb5dMZuGV2drNmxfz
3ar6ytGYLxedfjKCD55Yv8CQcN6e9sW5OUm9TJ3kjt7Wdvd1hcw5s+7bhlND38rWFJBuzump
5xqm1NSOggOkFSlKnhSz6HUjgwBaid6Ypig9L1/TLrkmtEIpx+wpIj7WTA9JqcMMyLJ0rN6j
jpetLSGUDk3NCOpQntSy4a8+0O+SepzS/Tec1cGdSN6Ni2/A7ewQNd1Rbmb2SM2qVBlfN0e6
ZklWo9QYpNZyf0d/d3upsKabE9eNCg1S4eDnp8sJqdlaQQ7hI/UYCAgDtLIm7/J9+/S2zuwE
WtJMPcvaYIBczdjwF9uW+8NJ/Zu/JKb98971uua7OsJexPFRBzX7/PnJ2/NXcTdwudShJc/p
d9c3IRU7qw+RxRKchIczv3zEuQJMHkSSM8KM8TbOzi/0v0lU6SSyS9bpGdZZxx19Hd8Qs0cv
+R6nyt7ohttizwefkYzQ6GzwIwM9gSjH5Bf/r9Kc5/JqqpKKUGicxAGy2zKYEGB0Qo761Mcc
IyclBW9mfuNFDbTBeDEyu80xggPzMIID7wIBATCBljCBgTELMAkGA1UEBhMCSVQxEDAOBgNV
BAgMB0JlcmdhbW8xGTAXBgNVBAcMEFBvbnRlIFNhbiBQaWV0cm8xFzAVBgNVBAoMDkFjdGFs
aXMgUy5wLkEuMSwwKgYDVQQDDCNBY3RhbGlzIENsaWVudCBBdXRoZW50aWNhdGlvbiBDQSBH
MwIQCP8se1eXTyBvFrjHrZ83LDANBglghkgBZQMEAgEFAKCCAi0wGAYJKoZIhvcNAQkDMQsG
CSqGSIb3DQEHATAcBgkqhkiG9w0BCQUxDxcNMjEwMjIzMTQ1NDQ2WjAvBgkqhkiG9w0BCQQx
IgQgDEkJjdRctmiHXHG8erhNq1WwBmt1ci5UacwCdUw3R5owbAYJKoZIhvcNAQkPMV8wXTAL
BglghkgBZQMEASowCwYJYIZIAWUDBAECMAoGCCqGSIb3DQMHMA4GCCqGSIb3DQMCAgIAgDAN
BggqhkiG9w0DAgIBQDAHBgUrDgMCBzANBggqhkiG9w0DAgIBKDCBpwYJKwYBBAGCNxAEMYGZ
MIGWMIGBMQswCQYDVQQGEwJJVDEQMA4GA1UECAwHQmVyZ2FtbzEZMBcGA1UEBwwQUG9udGUg
U2FuIFBpZXRybzEXMBUGA1UECgwOQWN0YWxpcyBTLnAuQS4xLDAqBgNVBAMMI0FjdGFsaXMg
Q2xpZW50IEF1dGhlbnRpY2F0aW9uIENBIEczAhAI/yx7V5dPIG8WuMetnzcsMIGpBgsqhkiG
9w0BCRACCzGBmaCBljCBgTELMAkGA1UEBhMCSVQxEDAOBgNVBAgMB0JlcmdhbW8xGTAXBgNV
BAcMEFBvbnRlIFNhbiBQaWV0cm8xFzAVBgNVBAoMDkFjdGFsaXMgUy5wLkEuMSwwKgYDVQQD
DCNBY3RhbGlzIENsaWVudCBBdXRoZW50aWNhdGlvbiBDQSBHMwIQCP8se1eXTyBvFrjHrZ83
LDANBgkqhkiG9w0BAQEFAASCAQAidG6k7Bx4JDJNMh/VabbbEJY3I36bk1ttpcfJpXnGvrNB
/S0fWXAq0zNRYj7L8ygBf84AmxvPwdMcvNicbrfZ0IDpfxSk0y8wmaifWvGEKNZh46FFjMFJ
HCXyRXenD2Ek2wXRHODyXf+sWegXoljtbjtwIBZ10FkYfW5hnEBYH12CSYLOkFPCR4HGnuD0
r5Gk09mTNa3oAQYcEmNs7Zf0/i6L9hUFu63e9apt6iaPU4SP3Wysi3yt2KiCtTrR0efvZRhu
dLTN6L+gvwxKFeRbfmRJyDNwk98OYYdm0Qwo16jNWWu6Iy7lekGF20LK1adt61EZ62BHcsj2
lCYMwKwhAAAAAAAA
--------------ms050604030902070107040506--

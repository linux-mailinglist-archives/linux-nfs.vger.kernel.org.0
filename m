Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60E616A10A2
	for <lists+linux-nfs@lfdr.de>; Thu, 23 Feb 2023 20:38:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229448AbjBWTiI (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 23 Feb 2023 14:38:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231777AbjBWTiG (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 23 Feb 2023 14:38:06 -0500
X-Greylist: delayed 5940 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 23 Feb 2023 11:38:04 PST
Received: from smtp-o-2.desy.de (smtp-o-2.desy.de [IPv6:2001:638:700:1038::1:9b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A506126FE
        for <linux-nfs@vger.kernel.org>; Thu, 23 Feb 2023 11:38:04 -0800 (PST)
Received: from smtp-buf-2.desy.de (smtp-buf-2.desy.de [IPv6:2001:638:700:1038::1:a5])
        by smtp-o-2.desy.de (Postfix) with ESMTP id D5E8716110B
        for <linux-nfs@vger.kernel.org>; Thu, 23 Feb 2023 20:38:02 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp-o-2.desy.de D5E8716110B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=desy.de; s=default;
        t=1677181082; bh=GOoXZUKDLkGNXXEP46udne3shP5sMwM2TjGZOY2hexw=;
        h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
        b=2DFBp4vr27eI1715HRJx8WPdaS+V8GwXUtzoJb0u1KeBnyphC0y1pIkGjyXeJm7j2
         8Rnb9erOAajrQB3eUM+C9eVK5g7au3BWDIyyIaTMVPqx9CnmCfop7vt8HEcy6hJt94
         8j1p6WMl0gmx7UkyrsdRRcz+YZH8uxwFL/ZAVFxA=
Received: from smtp-m-2.desy.de (smtp-m-2.desy.de [131.169.56.130])
        by smtp-buf-2.desy.de (Postfix) with ESMTP id C365E1A0092;
        Thu, 23 Feb 2023 20:38:02 +0100 (CET)
Received: from smtp-intra-2.desy.de (smtp-intra-2.desy.de [IPv6:2001:638:700:1038::1:53])
        by smtp-m-2.desy.de (Postfix) with ESMTP id BBD961200C0;
        Thu, 23 Feb 2023 20:38:02 +0100 (CET)
Received: from z-mbx-2.desy.de (z-mbx-2.desy.de [131.169.55.140])
        by smtp-intra-2.desy.de (Postfix) with ESMTP id B6705100077;
        Thu, 23 Feb 2023 20:38:02 +0100 (CET)
Date:   Thu, 23 Feb 2023 20:38:02 +0100 (CET)
From:   "Mkrtchyan, Tigran" <tigran.mkrtchyan@desy.de>
To:     Jeff Layton <jlayton@kernel.org>
Cc:     Frank Filz <ffilzlnx@mindspring.com>,
        "J. Bruce Fields" <bfields@fieldses.org>,
        Dai Ngo <dai.ngo@oracle.com>,
        linux-nfs <linux-nfs@vger.kernel.org>
Message-ID: <1292079534.40950670.1677181082600.JavaMail.zimbra@desy.de>
In-Reply-To: <bc8ab54d427e62f17f46022980bfcaf392e0a0c3.camel@kernel.org>
References: <20230222134952.32851-1-jlayton@kernel.org> <029901d947a3$0dd00c00$29702400$@mindspring.com> <bc8ab54d427e62f17f46022980bfcaf392e0a0c3.camel@kernel.org>
Subject: Re: [pynfs RFC PATCH] nfs4.0/testserver.py: don't return an error
 when tests fail
MIME-Version: 1.0
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256; 
        boundary="----=_Part_40950671_156846307.1677181082702"
X-Mailer: Zimbra 9.0.0_GA_4485 (ZimbraWebClient - FF110 (Linux)/9.0.0_GA_4478)
Thread-Topic: nfs4.0/testserver.py: don't return an error when tests fail
Thread-Index: mUDYtHeEyXIGDOoXB7gCQ24ScNy1pw==
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HK_RANDOM_ENVFROM,
        HK_RANDOM_FROM,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

------=_Part_40950671_156846307.1677181082702
Date: Thu, 23 Feb 2023 20:38:02 +0100 (CET)
From: "Mkrtchyan, Tigran" <tigran.mkrtchyan@desy.de>
To: Jeff Layton <jlayton@kernel.org>
Cc: Frank Filz <ffilzlnx@mindspring.com>, 
	"J. Bruce Fields" <bfields@fieldses.org>, 
	Dai Ngo <dai.ngo@oracle.com>, linux-nfs <linux-nfs@vger.kernel.org>
Message-ID: <1292079534.40950670.1677181082600.JavaMail.zimbra@desy.de>
In-Reply-To: <bc8ab54d427e62f17f46022980bfcaf392e0a0c3.camel@kernel.org>
References: <20230222134952.32851-1-jlayton@kernel.org> <029901d947a3$0dd00c00$29702400$@mindspring.com> <bc8ab54d427e62f17f46022980bfcaf392e0a0c3.camel@kernel.org>
Subject: Re: [pynfs RFC PATCH] nfs4.0/testserver.py: don't return an error
 when tests fail
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Mailer: Zimbra 9.0.0_GA_4485 (ZimbraWebClient - FF110 (Linux)/9.0.0_GA_4478)
Thread-Topic: nfs4.0/testserver.py: don't return an error when tests fail
Thread-Index: mUDYtHeEyXIGDOoXB7gCQ24ScNy1pw==



----- Original Message -----
> From: "Jeff Layton" <jlayton@kernel.org>
> To: "Frank Filz" <ffilzlnx@mindspring.com>, "J. Bruce Fields" <bfields@fi=
eldses.org>, "Dai Ngo" <dai.ngo@oracle.com>
> Cc: "linux-nfs" <linux-nfs@vger.kernel.org>
> Sent: Thursday, 23 February, 2023 18:08:19
> Subject: Re: [pynfs RFC PATCH] nfs4.0/testserver.py: don't return an erro=
r when tests fail

> On Thu, 2023-02-23 at 08:22 -0800, Frank Filz wrote:
>> > From: Jeff Layton [mailto:jlayton@kernel.org]
>> =C2=A0
>> > This script was originally changed in eb3ba0b60055 ("Have
>> > testserver.py
>> have
>> > non-zero exit code if any tests fail"), but the same change wasn't
>> > made to
>> the
>> > 4.1 testserver.py script.
>> >=20
>> > There also wasn't much explanation for it, and it makes it difficult
>> > to
>> tell
>> > whether the test harness itself failed, or whether there was a
>> > failure in
>> a
>> > requested test.
>> >=20
>> > Stop the 4.0 testserver.py from exiting with an error code when a
>> > test
>> fails, so
>> > that a successful return means only that the test harness itself
>> > worked,
>> not that
>> > every requested test passed.
>> >=20
>> > Cc: Frank Filz <ffilzlnx@mindspring.com>
>> > Signed-off-by: Jeff Layton <jlayton@kernel.org>
>> > ---
>> > =C2=A0nfs4.0/testserver.py | 2 --
>> > =C2=A01 file changed, 2 deletions(-)
>> >=20
>> > I'm not sure about this one. I've worked around this in kdevops for
>> > now,
>> but it
>> > would really be preferable if it worked this way, imo. If this isn't
>> acceptable,
>> > maybe we can add a new option that enables this behavior?
>> >=20
>> > Frank, what was the original rationale for eb3ba0b60055 ?
>>=20
>> We needed a way for CI to easily detect failure of pynfs. I'm not sure
>> how
>> helpful it is since Ganesha does fail some tests...
>>=20
>> It might be helpful to have some helpers for CI to use, or an option
>> that
>> causes pynfs to report in a way that's much easier for CI to determine
>> if
>> pynfs succeeded or not.
>>=20
>=20
> That's exactly the issue I had when working with this for kdevops. It
> runs testserver.py via ansible, and when it gets a non-zero exit code,
> the run aborts without doing anything further. I have it ignoring the
> return code from testserver.py for now, but that's not ideal since I
> can't catch actual problems with the test harness.
>=20
> I have testserver.py output the result to JSON, and then analyze that to
> see if anything failed. That also gives us what you were asking for in
> your other email -- the ability to filter out known failures. Here's
> what I have so far, but I'd like to expand it to highlight other
> behavior changes:
>=20
> https://github.com/linux-kdevops/kdevops/blob/master/scripts/workflows/py=
nfs/check_pynfs_results.py
>=20
> It may make sense to move that script into pynfs itself.
>=20
> If there is CI that depends on this behavior, then I'd be interested to
> hear how they are dealing with failed tests. Do they just not run the
> tests that always fail?


Same here... The test generates for us xunit report, thus error code is in =
the
reporting and we always have to run it as:

```
./testserver.py -v --noinit --xml=3D"${WORKSPACE}/xunit-report-v41.xml" ${S=
UT}:${TEST_PATH} all $NFS41_INCLUDES $NFS41_EXCLUDES_OPTION || true
```

>=20
>> Hmm, one thing that would help is to be able to flag a set of tests
>> that
>> should not constitute a CI failure (known errors) but we want to keep
>> running them because of what they exercise, or to more readily detect
>> that
>> they have been fixed.

yeah, an option might do the job.

Tigran.

>>=20
>=20
> The right way to do that is the same way that xfstests works. You test
> for the conditions being favorable for a test and then just skip it if
> they aren't.
>=20
>> > diff --git a/nfs4.0/testserver.py b/nfs4.0/testserver.py index
>> > f2c41568e5c7..4f4286daa657 100755
>> > --- a/nfs4.0/testserver.py
>> > +++ b/nfs4.0/testserver.py
>> > @@ -387,8 +387,6 @@ def main():
>> >=20
>> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if nfail < 0:
>> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0sys.exit(3)
>> > -    if nfail > 0:
>> > -        sys.exit(2)
>> >=20
>> > =C2=A0if __name__ =3D=3D "__main__":
>> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0main()
>> > --
>> > 2.39.2
>>=20
>=20
> --
> Jeff Layton <jlayton@kernel.org>

------=_Part_40950671_156846307.1677181082702
Content-Type: application/pkcs7-signature; name=smime.p7s; smime-type=signed-data
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

MIAGCSqGSIb3DQEHAqCAMIACAQExDzANBglghkgBZQMEAgEFADCABgkqhkiG9w0BBwEAAKCAMIIF
vzCCBKegAwIBAgIMJENPm+MXSsxZAQzUMA0GCSqGSIb3DQEBCwUAMIGNMQswCQYDVQQGEwJERTFF
MEMGA1UECgw8VmVyZWluIHp1ciBGb2VyZGVydW5nIGVpbmVzIERldXRzY2hlbiBGb3JzY2h1bmdz
bmV0emVzIGUuIFYuMRAwDgYDVQQLDAdERk4tUEtJMSUwIwYDVQQDDBxERk4tVmVyZWluIEdsb2Jh
bCBJc3N1aW5nIENBMB4XDTIxMDIxMDEyMzEwOVoXDTI0MDIxMDEyMzEwOVowWDELMAkGA1UEBhMC
REUxLjAsBgNVBAoMJURldXRzY2hlcyBFbGVrdHJvbmVuLVN5bmNocm90cm9uIERFU1kxGTAXBgNV
BAMMEFRpZ3JhbiBNa3J0Y2h5YW4wggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQClVKHU
er1OiIaoo2MFDgCSzcqRCB8qVjjLJyJwzHWkhKniE6dwY8xHciG0HZFpSQqiRsoakD+BzqINXsqI
CkVck5n7cUJ6cHBOM1r4pzEBcuuozPrT2tAfnHkFFGTZffOXgjmEITfSh6SD+DYeZH4Dt8kPZmnD
mzWMDFDyB67WWcWApVC1nPh29yGgJk18UZ+Ut9a+woaovMZlutMbuvLVt/x5rpycMw0z+J1qeK7J
8F3bKb0o2gg+Mnz9LzpLtJp7E9qJUKOTkZGDua9w9xrlo4XGX9Vn72K5wodu6woahdgNG+sXRcJM
RH3aWgfdznoi1ORLJCfTbdfjSBpclvt/AgMBAAGjggJRMIICTTA+BgNVHSAENzA1MA8GDSsGAQQB
ga0hgiwBAQQwEAYOKwYBBAGBrSGCLAEBBAgwEAYOKwYBBAGBrSGCLAIBBAgwCQYDVR0TBAIwADAO
BgNVHQ8BAf8EBAMCBeAwHQYDVR0lBBYwFAYIKwYBBQUHAwIGCCsGAQUFBwMEMB0GA1UdDgQWBBQG
1+t/IHSjHSbbu11uU5Iw7JW92zAfBgNVHSMEGDAWgBRrOpiL+fJTidrgrbIyHgkf6Ko7dDAjBgNV
HREEHDAagRh0aWdyYW4ubWtydGNoeWFuQGRlc3kuZGUwgY0GA1UdHwSBhTCBgjA/oD2gO4Y5aHR0
cDovL2NkcDEucGNhLmRmbi5kZS9kZm4tY2EtZ2xvYmFsLWcyL3B1Yi9jcmwvY2FjcmwuY3JsMD+g
PaA7hjlodHRwOi8vY2RwMi5wY2EuZGZuLmRlL2Rmbi1jYS1nbG9iYWwtZzIvcHViL2NybC9jYWNy
bC5jcmwwgdsGCCsGAQUFBwEBBIHOMIHLMDMGCCsGAQUFBzABhidodHRwOi8vb2NzcC5wY2EuZGZu
LmRlL09DU1AtU2VydmVyL09DU1AwSQYIKwYBBQUHMAKGPWh0dHA6Ly9jZHAxLnBjYS5kZm4uZGUv
ZGZuLWNhLWdsb2JhbC1nMi9wdWIvY2FjZXJ0L2NhY2VydC5jcnQwSQYIKwYBBQUHMAKGPWh0dHA6
Ly9jZHAyLnBjYS5kZm4uZGUvZGZuLWNhLWdsb2JhbC1nMi9wdWIvY2FjZXJ0L2NhY2VydC5jcnQw
DQYJKoZIhvcNAQELBQADggEBADaFbcKsjBPbw6aRf5vxlJdehkafMy4JIdduMEGB+IjpBRZGmu0Z
R2FRWNyq0lNRz03holZ8Rew0Ldx58REJmvAEzbwox4LT1wG8gRLEehyasSROajZBFrIHadDja0y4
1JrfqP2umZFE2XWap8pDFpQk4sZOXW1mEamLzFtlgXtCfalmYmbnrq5DnSVKX8LOt5BZvDWin3r4
m5v313d5/l0Qz2IrN6v7qNIyqT4peW90DUJHB1MGN60W2qe+VimWIuLJkQXMOpaUQJUlhkHOnhw8
82g+jWG6kpKBMzIQMMGP0urFlPAia2Iuu2VtCkT7Wr43xyhiVzkZcT6uzR23PLsAADGCApswggKX
AgEBMIGeMIGNMQswCQYDVQQGEwJERTFFMEMGA1UECgw8VmVyZWluIHp1ciBGb2VyZGVydW5nIGVp
bmVzIERldXRzY2hlbiBGb3JzY2h1bmdzbmV0emVzIGUuIFYuMRAwDgYDVQQLDAdERk4tUEtJMSUw
IwYDVQQDDBxERk4tVmVyZWluIEdsb2JhbCBJc3N1aW5nIENBAgwkQ0+b4xdKzFkBDNQwDQYJYIZI
AWUDBAIBBQCggc4wGAYJKoZIhvcNAQkDMQsGCSqGSIb3DQEHATAcBgkqhkiG9w0BCQUxDxcNMjMw
MjIzMTkzODAyWjAtBgkqhkiG9w0BCTQxIDAeMA0GCWCGSAFlAwQCAQUAoQ0GCSqGSIb3DQEBCwUA
MC8GCSqGSIb3DQEJBDEiBCA/MwfdWdJ0qTMJ10eIwQpr6WqoEvz5jfB6J8Adb0J4gzA0BgkqhkiG
9w0BCQ8xJzAlMAoGCCqGSIb3DQMHMA4GCCqGSIb3DQMCAgIAgDAHBgUrDgMCBzANBgkqhkiG9w0B
AQsFAASCAQCd5Df1+eWFM6gr7g4wgWzkYuB8XW2C5mRgjbrCdC5TM7FbwiII6go/QK03tBUumtL7
iQu+Xfi6c1IUPFxaDYvJ+xnJZDjpYA4vEGnIa9/Z0L38h8Wn54GH1z4wElNwpvnDXg65qz05XaYr
ebxFW9TbhQvTxj0ZLBh5ydWsqQi51UjmyAfYDWLD8PxgrRvGZ05cZnCZ44lWGUPib8NngERxjvyk
3P3GcxHOYV3yLSBd08VKUK5SvfnIxYj2yYEU776oGtoX9f1J9MwVdUfqvTYeQE4l6Uady9bvXVm8
Kt0z6R8ZGbO9LduAvOcmGpPIhpU4Vr8O9FvYbaMp+6/oRaFsAAAAAAAA
------=_Part_40950671_156846307.1677181082702--

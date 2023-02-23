Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 504146A0EF3
	for <lists+linux-nfs@lfdr.de>; Thu, 23 Feb 2023 18:59:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229485AbjBWR7J (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 23 Feb 2023 12:59:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229477AbjBWR7I (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 23 Feb 2023 12:59:08 -0500
Received: from smtp-o-2.desy.de (smtp-o-2.desy.de [131.169.56.155])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F201C17CC8
        for <linux-nfs@vger.kernel.org>; Thu, 23 Feb 2023 09:59:05 -0800 (PST)
Received: from smtp-buf-2.desy.de (smtp-buf-2.desy.de [131.169.56.165])
        by smtp-o-2.desy.de (Postfix) with ESMTP id 1AF52161109
        for <linux-nfs@vger.kernel.org>; Thu, 23 Feb 2023 18:59:02 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp-o-2.desy.de 1AF52161109
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=desy.de; s=default;
        t=1677175142; bh=0IWlhj/qGJ+Gz0Yo/TkgTD2v6senreBYcizST1xBlng=;
        h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
        b=3/FdnWxbjegZJOYMqAGiScFdJfXsb2JrzueymzSg3ZQgvFppEXJBN2Vl/XKqCoIAy
         wb8wRY2fzoqfAdVXVKwxo4Q2Bh+LbhR32J2l7Y87st60UWNsEQaST+vMNeW96s77Sg
         vj3YpckdSx07ohZsNHDZ+z6t98NRZyC6wfKD0k7Q=
Received: from smtp-m-2.desy.de (smtp-m-2.desy.de [131.169.56.130])
        by smtp-buf-2.desy.de (Postfix) with ESMTP id 0359B1A0092;
        Thu, 23 Feb 2023 18:59:02 +0100 (CET)
Received: from smtp-intra-2.desy.de (smtp-intra-2.desy.de [IPv6:2001:638:700:1038::1:53])
        by smtp-m-2.desy.de (Postfix) with ESMTP id EEBC31200C0;
        Thu, 23 Feb 2023 18:59:01 +0100 (CET)
Received: from z-mbx-2.desy.de (z-mbx-2.desy.de [131.169.55.140])
        by smtp-intra-2.desy.de (Postfix) with ESMTP id E6E1A100077;
        Thu, 23 Feb 2023 18:59:01 +0100 (CET)
Date:   Thu, 23 Feb 2023 18:59:01 +0100 (CET)
From:   "Mkrtchyan, Tigran" <tigran.mkrtchyan@desy.de>
To:     Jeff Layton <jlayton@kernel.org>
Cc:     Frank Filz <ffilzlnx@mindspring.com>,
        Chuck Lever III <chuck.lever@oracle.com>,
        "J. Bruce Fields" <bfields@fieldses.org>,
        Dai Ngo <dai.ngo@oracle.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        Calum Mackay <calum.mackay@oracle.com>
Message-ID: <300618233.40925377.1677175141647.JavaMail.zimbra@desy.de>
In-Reply-To: <fabf62538a93fda344c05b1a07c1298e7f3199bb.camel@kernel.org>
References: <20230222182043.155712-1-jlayton@kernel.org> <20230223151959.GC10456@fieldses.org> <3B034712-F376-4D71-8A72-703B030140F9@oracle.com> <029a01d947a3$a51b4750$ef51d5f0$@mindspring.com> <fabf62538a93fda344c05b1a07c1298e7f3199bb.camel@kernel.org>
Subject: Re: [pynfs RFC PATCH] testserver.py: special-case the "all" flag
MIME-Version: 1.0
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256; 
        boundary="----=_Part_40925378_1417744821.1677175141882"
X-Mailer: Zimbra 9.0.0_GA_4485 (ZimbraWebClient - FF110 (Linux)/9.0.0_GA_4478)
Thread-Topic: testserver.py: special-case the "all" flag
Thread-Index: KIOL0uFgegsjv+0srGMChqyVbPjO9A==
X-Spam-Status: No, score=-6.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HK_RANDOM_ENVFROM,
        HK_RANDOM_FROM,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

------=_Part_40925378_1417744821.1677175141882
Date: Thu, 23 Feb 2023 18:59:01 +0100 (CET)
From: "Mkrtchyan, Tigran" <tigran.mkrtchyan@desy.de>
To: Jeff Layton <jlayton@kernel.org>
Cc: Frank Filz <ffilzlnx@mindspring.com>, 
	Chuck Lever III <chuck.lever@oracle.com>, 
	"J. Bruce Fields" <bfields@fieldses.org>, 
	Dai Ngo <dai.ngo@oracle.com>, 
	Linux NFS Mailing List <linux-nfs@vger.kernel.org>, 
	Calum Mackay <calum.mackay@oracle.com>
Message-ID: <300618233.40925377.1677175141647.JavaMail.zimbra@desy.de>
In-Reply-To: <fabf62538a93fda344c05b1a07c1298e7f3199bb.camel@kernel.org>
References: <20230222182043.155712-1-jlayton@kernel.org> <20230223151959.GC10456@fieldses.org> <3B034712-F376-4D71-8A72-703B030140F9@oracle.com> <029a01d947a3$a51b4750$ef51d5f0$@mindspring.com> <fabf62538a93fda344c05b1a07c1298e7f3199bb.camel@kernel.org>
Subject: Re: [pynfs RFC PATCH] testserver.py: special-case the "all" flag
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Mailer: Zimbra 9.0.0_GA_4485 (ZimbraWebClient - FF110 (Linux)/9.0.0_GA_4478)
Thread-Topic: testserver.py: special-case the "all" flag
Thread-Index: KIOL0uFgegsjv+0srGMChqyVbPjO9A==



----- Original Message -----
> From: "Jeff Layton" <jlayton@kernel.org>
> To: "Frank Filz" <ffilzlnx@mindspring.com>, "Chuck Lever III" <chuck.leve=
r@oracle.com>, "J. Bruce Fields"
> <bfields@fieldses.org>
> Cc: "Dai Ngo" <dai.ngo@oracle.com>, "Linux NFS Mailing List" <linux-nfs@v=
ger.kernel.org>, "Calum Mackay"
> <calum.mackay@oracle.com>
> Sent: Thursday, 23 February, 2023 18:10:47
> Subject: Re: [pynfs RFC PATCH] testserver.py: special-case the "all" flag

> On Thu, 2023-02-23 at 08:26 -0800, Frank Filz wrote:
>>=20
>> > -----Original Message-----
>> > From: Chuck Lever III [mailto:chuck.lever@oracle.com]
>> > Sent: Thursday, February 23, 2023 8:22 AM
>> > To: Bruce Fields <bfields@fieldses.org>
>> > Cc: Jeff Layton <jlayton@kernel.org>; Dai Ngo <dai.ngo@oracle.com>; Li=
nux
>> > NFS Mailing List <linux-nfs@vger.kernel.org>; Calum Mackay
>> > <calum.mackay@oracle.com>; Frank Filz <ffilzlnx@mindspring.com>
>> > Subject: Re: [pynfs RFC PATCH] testserver.py: special-case the "all" f=
lag
>> >=20
>> >=20
>> >=20
>> > > On Feb 23, 2023, at 10:19 AM, J. Bruce Fields <bfields@fieldses.org>
>> wrote:
>> > >=20
>> > > On Wed, Feb 22, 2023 at 01:20:43PM -0500, Jeff Layton wrote:
>> > > > The READMEs for v4.0 and v4.1 are inconsistent here. For v4.0, the
>> "all"
>> > > > flag is supposed to run all of the "standard" tests. For v4.1 "all=
"
>> > > > is documented to run all of the tests, but it actually doesn't sin=
ce
>> > > > not every tests has "all" in its FLAGS: field.
>> > > >=20
>> > > > I move that we change this. If I say that I want to run "all", the=
n I
>> > > > really do want to run _all_ of the tests. Ensure that every test h=
as
>> > > > the "all" flag set.
>> > >=20
>> > > In some (all?) cases where the "all" flag was left off, it was
>> > > intentional.
>> > >=20
>> > > We try not to flag spec-compliant servers as failing, because people
>> > > are sometimes a little careless about "fixing" failures that in thei=
r
>> > > particular case really shouldn't be fixed.  But sometimes it's still
>> > > useful to have a test that goes somewhat beyond the spec.
>> > >=20
>> > > There might be other ways to handle that kind of test, but it would
>> > > need some more thought.
>> >=20
>> > We could use a different name for "all" since it doesn't actually run
>> /all/ tests.
>> > Jeff suggested "standard", which seems sensible.
>>=20
>> The challenge with changing this is all the CI scripts and other testing
>> scripts out there that use all. If all suddenly changed, server maintain=
ers
>> might get a deluge of bug reports for failing odd test cases no one
>> necessarily expected to work...
>>=20
>=20
> Are those CI systems pulling down the upstream tree to run? How do they
> contend with new tests that might suddenly show up as part of "all"?

We are actually explicitly disabling some tests that are part of the `all`

```
./testserver.py -v --noinit --xml=3D/scratch/jenkins/root/workspace/pynfs-t=
est/xunit-report-v40.xml nfs-lab:/data/nfs all noACC2a noACC2b noACC2c noAC=
C2d noACC2f noACC2r noACC2s noCID1 noCID2 noCID4a noCID4b noCID4c noCID4d n=
oCID4e noCLOSE10 noCLOSE12 noCLOSE5 noCLOSE6 noCLOSE8 noCLOSE9 noCMT1aa noC=
MT1b noCMT1c noCMT1d noCMT1e noCMT1f noCMT2a noCMT2b noCMT2c noCMT2d noCMT2=
f noCMT2s noCMT3 noCMT4 noCR12 noLKT1 noLKT2a noLKT2b noLKT2c noLKT2d noLKT=
2f noLKT2s noLKT3 noLKT4 noLKT6 noLKT7 noLKT8 noLKT9 noLKU10 noLKU3 noLKU4 =
noLKU5 noLKU6 noLKU6b noLKU7 noLKU8 noLKU9 noLKUNONE noLOCK12a noLOCK12b no=
LOCK13 noLOCK24 noLOCKRNG noLOCKCHGU noLOCKCHGD noOPCF1 noOPCF6 noOPDG2 noO=
PDG3 noOPDG6 noOPDG7 noOPEN15 noOPEN18 noOPEN2 noOPEN20 noOPEN22 noOPEN23 n=
oOPEN24 noOPEN26 noOPEN27 noOPEN28 noOPEN3 noOPEN30 noOPEN4 noRENEW3 noRD1 =
noRD10 noRD2 noRD3 noRD5 noRD6 noRD7a noRD7b noRD7c noRD7d noRD7f noRD7s no=
RPLY1 noRPLY10 noRPLY12 noRPLY14 noRPLY2 noRPLY3 noRPLY5 noRPLY6 noRPLY7 no=
RPLY8 noRPLY9 noSATT3d noSATT4 noSATT6d noSATT6r noSATT18 noSEC7 noWRT1 noW=
RT11 noWRT13 noWRT14 noWRT15 noWRT18 noWRT19 noWRT1b noWRT2 noWRT3 noWRT6a =
noWRT6b noWRT6c noWRT6d noWRT6f noWRT6s noWRT8 noWRT9
```

However, I don't think it will be a big issue to adjust if suddenly `all` h=
as more tests.
BTW, we have the containerized version as well, which is publicly available=
. I will write some docu...

podman run -ti --rm -v `pwd`/out:/out dcache/pynfs:0.1  /bin/bash -c "cd /p=
ynfs/nfs4.0; python3 -u ./testserver.py --xml=3D/out/xunit-report-v40.xml -=
-noinit nfs-lab:/data all; exit 0"

I am happy to share Dockerfile and make it more user friendly :)

Best regards,
   Tigran.



>=20
>> > Also, we could add test categories specifically for particular server
>> > implementations, if that's interesting to folks.
>>=20
>> I have already done so with a ganesha tag...
>>=20
>> Literally all anyone has to do is start using a new tag so it's a trivia=
l
>> thing for developers to add.
>>=20
>=20
> The problem is that you have to add the tag to hundreds of tests. It's
> scriptable, sure, but if you want to be at all selective, it's not
> trivial.
>=20
> That said, I'm open to doing something different here. Maybe we could
> declare a new "everything" special case instead? It's confusing naming,
> but that would at least preserve the existing behavior for those CI
> systems.
>=20
>> >=20
>> > > --b.
>> > >=20
>> > > > Signed-off-by: Jeff Layton <jlayton@kernel.org>
>> > > > ---
>> > > > nfs4.1/testmod.py | 2 ++
>> > > > 1 file changed, 2 insertions(+)
>> > > >=20
>> > > > If this is unacceptable, then an alternative could be to add a new
>> > > > (similarly special-cased) "everything" flag.
>> > > >=20
>> > > > diff --git a/nfs4.1/testmod.py b/nfs4.1/testmod.py index
>> > > > 11e759d673fd..7b3bac543084 100644
>> > > > --- a/nfs4.1/testmod.py
>> > > > +++ b/nfs4.1/testmod.py
>> > > > @@ -386,6 +386,8 @@ def createtests(testdir):
>> > > >     for t in tests:
>> > > > ##         if not t.flags_list:
>> > > > ##             raise RuntimeError("%s has no flags" % t.fullname)
>> > > > +        if "all" not in t.flags_list:
>> > > > +            t.flags_list.append("all")
>> > > >         for f in t.flags_list:
>> > > >             if f not in flag_dict:
>> > > >                 flag_dict[f] =3D bit
>> > > > --
>> > > > 2.39.2
>> >=20
>> > --
>> > Chuck Lever
>> >=20
>>=20
>>=20
>=20
> --
> Jeff Layton <jlayton@kernel.org>

------=_Part_40925378_1417744821.1677175141882
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
MjIzMTc1OTAxWjAtBgkqhkiG9w0BCTQxIDAeMA0GCWCGSAFlAwQCAQUAoQ0GCSqGSIb3DQEBCwUA
MC8GCSqGSIb3DQEJBDEiBCCB0gndSZQs74VkH/IMHyr7S0elxtR9NMzO9RMkQQqxgDA0BgkqhkiG
9w0BCQ8xJzAlMAoGCCqGSIb3DQMHMA4GCCqGSIb3DQMCAgIAgDAHBgUrDgMCBzANBgkqhkiG9w0B
AQsFAASCAQAjxJz1gODWmeHRWq7ljr9WSvB65yhzmmDGKOg6KGU8xipfmN/W2A3steA1lpbdeoRb
BNUkchzp8VWvu4OgjvbwMmSfuBAAFfSUzvblFE40DsQKljFeh0Ykn900Lh5/BxBwBaAN4fBI0/WU
38ZYlAWDurQL3lwcdY5pYvu7owj0h1VEd3BhAkgX9lFwqPi30g/NbJJMZkB6q82I6ROBadv+X89B
GYEVhHmgfl2KIqIXMKxxPSnMPRMZcgG3JvEjCdMTu94ePqHx+FIwzY4sZd+YxzQkQ+y5Vuebw/Wl
K2UZT2KnjKjrOON7JolNXYOb/UPUxfXu5qbTRg77ubi+HSgXAAAAAAAA
------=_Part_40925378_1417744821.1677175141882--

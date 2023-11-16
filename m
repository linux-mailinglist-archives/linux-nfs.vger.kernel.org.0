Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AEDF07EDC8E
	for <lists+linux-nfs@lfdr.de>; Thu, 16 Nov 2023 09:03:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229997AbjKPIDM (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 16 Nov 2023 03:03:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234833AbjKPIDL (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 16 Nov 2023 03:03:11 -0500
X-Greylist: delayed 444 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 16 Nov 2023 00:03:07 PST
Received: from smtp-o-2.desy.de (smtp-o-2.desy.de [IPv6:2001:638:700:1038::1:9b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EAEB1BD
        for <linux-nfs@vger.kernel.org>; Thu, 16 Nov 2023 00:03:06 -0800 (PST)
Received: from smtp-buf-2.desy.de (smtp-buf-2.desy.de [131.169.56.165])
        by smtp-o-2.desy.de (Postfix) with ESMTP id 3F7BC16114B
        for <linux-nfs@vger.kernel.org>; Thu, 16 Nov 2023 08:55:39 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp-o-2.desy.de 3F7BC16114B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=desy.de; s=default;
        t=1700121339; bh=5xIfOPc1b1MUhxX22S91f9OQxZiAem0cs1HUlnbyhkU=;
        h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
        b=BitUPG4zLQS0PoKmfuSlz3wSJyzGZu3rgCSUfx4EdkMPgi96mdrZnBbxpD1vrLm/0
         TDCgnhJ63El+Z9zHM3JUVBbW72eKYLSeNC+UKCoJCPtcgaHANXVDQx+qyaNyQHYv3c
         73NmPskI+ta5HrmGf3UveHGvfvFej7E/bJbhYTtk=
Received: from smtp-m-2.desy.de (smtp-m-2.desy.de [IPv6:2001:638:700:1038::1:82])
        by smtp-buf-2.desy.de (Postfix) with ESMTP id 31FEF1A0093;
        Thu, 16 Nov 2023 08:55:39 +0100 (CET)
Received: from b1722.mx.srv.dfn.de (b1722.mx.srv.dfn.de [194.95.235.47])
        by smtp-m-2.desy.de (Postfix) with ESMTP id 2B70E123FC3;
        Thu, 16 Nov 2023 08:55:39 +0100 (CET)
Received: from smtp-intra-2.desy.de (smtp-intra-2.desy.de [131.169.56.83])
        by b1722.mx.srv.dfn.de (Postfix) with ESMTP id 888F4220039;
        Thu, 16 Nov 2023 08:55:38 +0100 (CET)
Received: from z-mbx-2.desy.de (z-mbx-2.desy.de [131.169.55.140])
        by smtp-intra-2.desy.de (Postfix) with ESMTP id 74BF210006A;
        Thu, 16 Nov 2023 08:55:38 +0100 (CET)
Date:   Thu, 16 Nov 2023 08:55:38 +0100 (CET)
From:   "Mkrtchyan, Tigran" <tigran.mkrtchyan@desy.de>
To:     Martin Wege <martin.l.wege@gmail.com>
Cc:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Message-ID: <761568108.788363.1700121338355.JavaMail.zimbra@desy.de>
In-Reply-To: <CANH4o6Na-KPweTmeUAiU9sK4OGt8RkkZU+vK5xpEe-BrP-s_Bg@mail.gmail.com>
References: <CANH4o6MqecahkZj3i4YwS1UQjQimFrDcbM8abCbrGiLyk9ZTkg@mail.gmail.com> <CANH4o6Na-KPweTmeUAiU9sK4OGt8RkkZU+vK5xpEe-BrP-s_Bg@mail.gmail.com>
Subject: Re: Filesystem test suite for NFSv4?
MIME-Version: 1.0
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256; 
        boundary="----=_Part_788366_1996345786.1700121338439"
X-Mailer: Zimbra 9.0.0_GA_4564 (ZimbraWebClient - FF119 (Linux)/9.0.0_GA_4571)
Thread-Topic: Filesystem test suite for NFSv4?
Thread-Index: 7zphy2nzK2vwAnKOBacHp569D5ec7w==
X-Spam-Status: No, score=-0.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HK_RANDOM_ENVFROM,
        HK_RANDOM_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

------=_Part_788366_1996345786.1700121338439
Date: Thu, 16 Nov 2023 08:55:38 +0100 (CET)
From: "Mkrtchyan, Tigran" <tigran.mkrtchyan@desy.de>
To: Martin Wege <martin.l.wege@gmail.com>
Cc: Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Message-ID: <761568108.788363.1700121338355.JavaMail.zimbra@desy.de>
In-Reply-To: <CANH4o6Na-KPweTmeUAiU9sK4OGt8RkkZU+vK5xpEe-BrP-s_Bg@mail.gmail.com>
References: <CANH4o6MqecahkZj3i4YwS1UQjQimFrDcbM8abCbrGiLyk9ZTkg@mail.gmail.com> <CANH4o6Na-KPweTmeUAiU9sK4OGt8RkkZU+vK5xpEe-BrP-s_Bg@mail.gmail.com>
Subject: Re: Filesystem test suite for NFSv4?
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Mailer: Zimbra 9.0.0_GA_4564 (ZimbraWebClient - FF119 (Linux)/9.0.0_GA_4571)
Thread-Topic: Filesystem test suite for NFSv4?
Thread-Index: 7zphy2nzK2vwAnKOBacHp569D5ec7w==


What do you want to test?
Protocol-level test can be performed with pynfs:

https://git.linux-nfs.org/?p=3Dcdmackay/pynfs.git;a=3Dsummary

IO bandwidth and latency tests can be performed ior or fio.

Best regards,
   Tigran.


----- Original Message -----
> From: "Martin Wege" <martin.l.wege@gmail.com>
> To: "Linux NFS Mailing List" <linux-nfs@vger.kernel.org>
> Sent: Thursday, 16 November, 2023 08:05:50
> Subject: Re: Filesystem test suite for NFSv4?

> ?
>=20
> On Fri, Nov 10, 2023 at 8:42=E2=80=AFAM Martin Wege <martin.l.wege@gmail.=
com> wrote:
>>
>> Hello,
>>
>> Is there a filesystem test suite for NFSv4, which can be used by a
>> non-root user for testing?
>>
>> Thanks,
> > Martin

------=_Part_788366_1996345786.1700121338439
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
AWUDBAIBBQCggc4wGAYJKoZIhvcNAQkDMQsGCSqGSIb3DQEHATAcBgkqhkiG9w0BCQUxDxcNMjMx
MTE2MDc1NTM4WjAtBgkqhkiG9w0BCTQxIDAeMA0GCWCGSAFlAwQCAQUAoQ0GCSqGSIb3DQEBCwUA
MC8GCSqGSIb3DQEJBDEiBCDM5eiqTAXQY49cyxWNxxj366ojNIdNVBC9daQezzL5ODA0BgkqhkiG
9w0BCQ8xJzAlMAoGCCqGSIb3DQMHMA4GCCqGSIb3DQMCAgIAgDAHBgUrDgMCBzANBgkqhkiG9w0B
AQsFAASCAQBej1ntcTMfFpDWVOr2GGU4uFIQj1CfJkxG+UxyPE2bguQqkkgTDbuo++UuOFo52wGU
RjXlJ5K1sV6uW24lkynmu7nh8QkWZNYXx9y2Bbpm1lBHw1lJbuTVCzkxng+mF+jkcaio8RYw4qiy
LURHdKCRfcXeFfMcxI5Fjl8isOf7eh1lT2hI0I9emTJeCr/teTS0P3iAfek23nqhKl0ZDq2ylc1P
VJVbOM/f0iLoeMbilsmnPRn66Lb3e0Z+FkpjODo17E/RrjNw1HrDXm+PM53fxRdzjEgdkU8pryz+
63FanUxNS+K6NVfLqThctgE55M6gsk2a2gx1bM7gxkYLv1vXAAAAAAAA
------=_Part_788366_1996345786.1700121338439--

Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CAE5672DC72
	for <lists+linux-nfs@lfdr.de>; Tue, 13 Jun 2023 10:27:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234722AbjFMI1o (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 13 Jun 2023 04:27:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241213AbjFMI1n (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 13 Jun 2023 04:27:43 -0400
Received: from smtp-o-1.desy.de (smtp-o-1.desy.de [IPv6:2001:638:700:1038::1:9a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD561D2
        for <linux-nfs@vger.kernel.org>; Tue, 13 Jun 2023 01:27:40 -0700 (PDT)
Received: from smtp-buf-1.desy.de (smtp-buf-1.desy.de [IPv6:2001:638:700:1038::1:a4])
        by smtp-o-1.desy.de (Postfix) with ESMTP id A9743E0A5B
        for <linux-nfs@vger.kernel.org>; Tue, 13 Jun 2023 10:27:38 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp-o-1.desy.de A9743E0A5B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=desy.de; s=default;
        t=1686644858; bh=fatxL0F99l70Gp5p8drVWgdRue5MVdJDTl4c50VDrXc=;
        h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
        b=wjCURcb2qWiZkb/vXSkABHx+v5H1JhVBlcwy59BUo0iunkJ7byvB1cR4nmnavECLe
         DNu62ujw/y+0jZRKQLI9cXECKvQrspcBfPI5wjUqbc+M9nTEAVTB1XDmbH1s3wAZR9
         uCy4jTrRdPmW/6GUXyV8hor3ZsNmE06nfKCEQp+8=
Received: from smtp-m-1.desy.de (smtp-m-1.desy.de [131.169.56.129])
        by smtp-buf-1.desy.de (Postfix) with ESMTP id 9ED6512039C;
        Tue, 13 Jun 2023 10:27:38 +0200 (CEST)
Received: from a1722.mx.srv.dfn.de (a1722.mx.srv.dfn.de [IPv6:2001:638:d:c301:acdc:1979:2:e7])
        by smtp-m-1.desy.de (Postfix) with ESMTP id 968034028A;
        Tue, 13 Jun 2023 10:27:38 +0200 (CEST)
Received-SPF: Neutral (mailfrom) identity=mailfrom; client-ip=131.169.56.83; helo=smtp-intra-2.desy.de; envelope-from=tigran.mkrtchyan@desy.de; receiver=<UNKNOWN> 
Received: from smtp-intra-2.desy.de (smtp-intra-2.desy.de [131.169.56.83])
        by a1722.mx.srv.dfn.de (Postfix) with ESMTP id CEFF1220043;
        Tue, 13 Jun 2023 10:27:37 +0200 (CEST)
Received: from z-mbx-2.desy.de (z-mbx-2.desy.de [131.169.55.140])
        by smtp-intra-2.desy.de (Postfix) with ESMTP id 5E762100266;
        Tue, 13 Jun 2023 10:27:37 +0200 (CEST)
Date:   Tue, 13 Jun 2023 10:27:37 +0200 (CEST)
From:   "Mkrtchyan, Tigran" <tigran.mkrtchyan@desy.de>
To:     Benjamin Coddington <bcodding@redhat.com>
Cc:     Trond Myklebust <trondmy@hammerspace.com>, anna <anna@kernel.org>,
        linux-nfs <linux-nfs@vger.kernel.org>
Message-ID: <1588974117.1198850.1686644857335.JavaMail.zimbra@desy.de>
In-Reply-To: <83016291-825A-4A16-B7A8-8B492A47CD5A@redhat.com>
References: <20230608144933.412664-1-tigran.mkrtchyan@desy.de> <cfde2b7b2a7f24f2652ce0bb82727cb0b810c758.camel@hammerspace.com> <AD6C85BF-50F9-42BB-83E8-16BCE03D3CF1@desy.de> <437767d036ee95a7ce92d7fa2add82a441eedf78.camel@hammerspace.com> <1144390245.427543.1686317435856.JavaMail.zimbra@desy.de> <83016291-825A-4A16-B7A8-8B492A47CD5A@redhat.com>
Subject: Re: [PATCH] nfs4: don't map EACCESS and EPERM to EIO
MIME-Version: 1.0
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256; 
        boundary="----=_Part_1198851_465769043.1686644857341"
X-Mailer: Zimbra 9.0.0_GA_4546 (ZimbraWebClient - FF114 (Linux)/9.0.0_GA_4546)
Thread-Topic: nfs4: don't map EACCESS and EPERM to EIO
Thread-Index: g1eNkjomBVi+aJQH6NpOSPQXa14zzg==
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HK_RANDOM_ENVFROM,
        HK_RANDOM_FROM,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

------=_Part_1198851_465769043.1686644857341
Date: Tue, 13 Jun 2023 10:27:37 +0200 (CEST)
From: "Mkrtchyan, Tigran" <tigran.mkrtchyan@desy.de>
To: Benjamin Coddington <bcodding@redhat.com>
Cc: Trond Myklebust <trondmy@hammerspace.com>, anna <anna@kernel.org>, 
	linux-nfs <linux-nfs@vger.kernel.org>
Message-ID: <1588974117.1198850.1686644857335.JavaMail.zimbra@desy.de>
In-Reply-To: <83016291-825A-4A16-B7A8-8B492A47CD5A@redhat.com>
References: <20230608144933.412664-1-tigran.mkrtchyan@desy.de> <cfde2b7b2a7f24f2652ce0bb82727cb0b810c758.camel@hammerspace.com> <AD6C85BF-50F9-42BB-83E8-16BCE03D3CF1@desy.de> <437767d036ee95a7ce92d7fa2add82a441eedf78.camel@hammerspace.com> <1144390245.427543.1686317435856.JavaMail.zimbra@desy.de> <83016291-825A-4A16-B7A8-8B492A47CD5A@redhat.com>
Subject: Re: [PATCH] nfs4: don't map EACCESS and EPERM to EIO
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Mailer: Zimbra 9.0.0_GA_4546 (ZimbraWebClient - FF114 (Linux)/9.0.0_GA_4546)
Thread-Topic: nfs4: don't map EACCESS and EPERM to EIO
Thread-Index: g1eNkjomBVi+aJQH6NpOSPQXa14zzg==

Thanks, Ben!

Tigran.

----- Original Message -----
> From: "Benjamin Coddington" <bcodding@redhat.com>
> To: "Tigran Mkrtchyan" <tigran.mkrtchyan@desy.de>
> Cc: "Trond Myklebust" <trondmy@hammerspace.com>, "anna" <anna@kernel.org>, "linux-nfs" <linux-nfs@vger.kernel.org>
> Sent: Friday, 9 June, 2023 16:00:34
> Subject: Re: [PATCH] nfs4: don't map EACCESS and EPERM to EIO

> On 9 Jun 2023, at 9:30, Mkrtchyan, Tigran wrote:
> 
>> Hi Trond,
>>
>> Obviously, the patch is incorrect. The behavior of the upstream kernel and
>> RHEL kernels are different.
> 
> RHEL-9 should be ok here.
> 
> There's a few things we need to be fixing for RHEL-8.9.  This is one of them.
> https://bugzilla.redhat.com/show_bug.cgi?id=2213828
> 
> Ben

------=_Part_1198851_465769043.1686644857341
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
NjEzMDgyNzM3WjAtBgkqhkiG9w0BCTQxIDAeMA0GCWCGSAFlAwQCAQUAoQ0GCSqGSIb3DQEBCwUA
MC8GCSqGSIb3DQEJBDEiBCCH+mekGZ/7VXh/H3+Hf5GGlRVvwAhQ24ZDORGHd9ZH8DA0BgkqhkiG
9w0BCQ8xJzAlMAoGCCqGSIb3DQMHMA4GCCqGSIb3DQMCAgIAgDAHBgUrDgMCBzANBgkqhkiG9w0B
AQsFAASCAQCiEuivfamkgBx7/egiO1alk6MHdX0cI1JQL4x4ol/pr1PG+coT+q8/dZJsctRIpwjP
rcmT/MJULp4c998F/ngQK3EjQgT9xgQsWSGjlMG9sE4aAHEZzUORuuXC0Dgj2up5xz3O/xckDaG8
FTl5Pz5tftji6wXNaadAHeOvG/gbGrnX0zxvZT3GfbgS49vtpWDzJoHbFtNE9iwdqv0izBHwl7BX
P7i0y3i3iImm0uS5MpKXdBxZftWr+XdX5FgYm4rCK/0b7ADcoWTvi3ls1gWHzOjLEI3J0uTyrZ/8
OrQAqvTjE0UZNzv1uSDK64XO0lkDsGGmoFA5FNqJyhHrEPo+AAAAAAAA
------=_Part_1198851_465769043.1686644857341--

Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D1FF5638D1
	for <lists+linux-nfs@lfdr.de>; Fri,  1 Jul 2022 19:58:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229906AbiGAR6U (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 1 Jul 2022 13:58:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230331AbiGAR6T (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 1 Jul 2022 13:58:19 -0400
Received: from smtp-o-3.desy.de (smtp-o-3.desy.de [131.169.56.156])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F63F13FA2
        for <linux-nfs@vger.kernel.org>; Fri,  1 Jul 2022 10:58:16 -0700 (PDT)
Received: from smtp-buf-3.desy.de (smtp-buf-3.desy.de [IPv6:2001:638:700:1038::1:a6])
        by smtp-o-3.desy.de (Postfix) with ESMTP id F128E608B6
        for <linux-nfs@vger.kernel.org>; Fri,  1 Jul 2022 19:58:14 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp-o-3.desy.de F128E608B6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=desy.de; s=default;
        t=1656698295; bh=IuaYl3I1sgXYws7QgXAMTDpDgZs6QQ9/SWGCIIRUCe4=;
        h=Date:From:To:Subject:From;
        b=sw/SBoaE3thhgdq+1Pm4XU8n0Z0/frqWCqSGQSkmxY7oE+ZoaHIYVnbL5tSoBA1wV
         CC6dHAqRXzLh4T8cvNpfRWuJhhuBxGFVJPyT9bG3/Sxtmxic/ZKtO3MWSzIOvScb7u
         aPM/XxPEqgRlfyC+AfapJ340ujMwwWgIAq9A+wLQ=
Received: from smtp-m-3.desy.de (smtp-m-3.desy.de [IPv6:2001:638:700:1038::1:83])
        by smtp-buf-3.desy.de (Postfix) with ESMTP id EAE03A0586
        for <linux-nfs@vger.kernel.org>; Fri,  1 Jul 2022 19:58:14 +0200 (CEST)
Received: from z-mbx-2.desy.de (z-mbx-2.desy.de [131.169.55.140])
        by smtp-intra-3.desy.de (Postfix) with ESMTP id D525B80347
        for <linux-nfs@vger.kernel.org>; Fri,  1 Jul 2022 19:58:14 +0200 (CEST)
Date:   Fri, 1 Jul 2022 19:58:14 +0200 (CEST)
From:   "Mkrtchyan, Tigran" <tigran.mkrtchyan@desy.de>
To:     linux-nfs <linux-nfs@vger.kernel.org>
Message-ID: <737440541.1127428.1656698294694.JavaMail.zimbra@desy.de>
Subject: Per user rate limiter
MIME-Version: 1.0
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256; 
        boundary="----=_Part_1127430_1635155811.1656698294829"
X-Mailer: Zimbra 8.8.15_GA_4308 (ZimbraWebClient - FF102 (Linux)/8.8.15_GA_4303)
Thread-Index: VvWRCLsWSwi3+X3WtqrMTkYKdx9xXA==
Thread-Topic: Per user rate limiter
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HK_RANDOM_ENVFROM,
        HK_RANDOM_FROM,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

------=_Part_1127430_1635155811.1656698294829
Date: Fri, 1 Jul 2022 19:58:14 +0200 (CEST)
From: "Mkrtchyan, Tigran" <tigran.mkrtchyan@desy.de>
To: linux-nfs <linux-nfs@vger.kernel.org>
Message-ID: <737440541.1127428.1656698294694.JavaMail.zimbra@desy.de>
Subject: Per user rate limiter
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Mailer: Zimbra 8.8.15_GA_4308 (ZimbraWebClient - FF102 (Linux)/8.8.15_GA_4303)
Thread-Index: VvWRCLsWSwi3+X3WtqrMTkYKdx9xXA==
Thread-Topic: Per user rate limiter


Hi NFS folks,

reticently we got a kind of DDoS from one of our user: 5k jobs ware aggressively
reading a handful number of files. Of course we have an overload protection,
however, such a large number of requests by a single user didn't give other
users a chance to perform any IO. As we extensively use pNFS, such user behavior
makes some DSes not available to other users.

To address this issues, we are looking at some kind of per user principal
rate limiter. All users will get some IO portion and if there is no requests
from other users, then a single user can get it all. Not ideal solution, of
course, but a good starting point.

So, the question is how tell the aggressive user to back-off? Delaying the response
will block all other requests from the same host for other users. Returning
NFS4ERR_DELAY will have the same effect (this is what we do now). NFSv4.1 session
slots are client wide, thus, any increase or decrease per client id will
either give more slots to aggressive user or reduce for all other as well.

Are there any developments in the direction of per-client (cgroups or namespaces)
timeout/error handling? Are there a nfs client friendly solutions, better that
returning NFS4ERR_DELAY?

Thanks in advance,
   Tigran.
------=_Part_1127430_1635155811.1656698294829
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
AWUDBAIBBQCggc4wGAYJKoZIhvcNAQkDMQsGCSqGSIb3DQEHATAcBgkqhkiG9w0BCQUxDxcNMjIw
NzAxMTc1ODE0WjAtBgkqhkiG9w0BCTQxIDAeMA0GCWCGSAFlAwQCAQUAoQ0GCSqGSIb3DQEBCwUA
MC8GCSqGSIb3DQEJBDEiBCCeAScGmaMu0TuxwhRhv7hLHdpz0P75JqzpNWMmMa9wPjA0BgkqhkiG
9w0BCQ8xJzAlMAoGCCqGSIb3DQMHMA4GCCqGSIb3DQMCAgIAgDAHBgUrDgMCBzANBgkqhkiG9w0B
AQsFAASCAQAJpjUY0u9hxWxDzUln/RA6Z/KcfPyxU37Tx2k1xYZzauuxvRj4sqkBrRigCqgNRXZR
doG6LIoQOAG6NJHmBttv4NHIMmrMe7lZQXu9CPl9TdrCxER/MbWeD2PYBtEYSE3/5xg07nz+cpR1
PxYNO2fOvsq5RqdxHuc3tQ8X3sS0C2OCJCi+mZoV3yKRRJMBJtxemFjg7A2wrt9OGTgO1K633RvU
AL1HQGN8rIXvLjGiCUAZYkh2df7DcovXGE2nrdEh0DXtFxyS9gF/4SXbTKYIkruKhjSDo2PLcyTG
ff+XvJI4Wh3kAENZgo+k6wVwH/XLdWeQGVKw9ppTslB077FnAAAAAAAA
------=_Part_1127430_1635155811.1656698294829--

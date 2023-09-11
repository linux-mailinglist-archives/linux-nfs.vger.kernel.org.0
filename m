Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7986E79BA57
	for <lists+linux-nfs@lfdr.de>; Tue, 12 Sep 2023 02:11:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240947AbjIKV6y (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 11 Sep 2023 17:58:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240992AbjIKO7L (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 11 Sep 2023 10:59:11 -0400
Received: from smtp-o-2.desy.de (smtp-o-2.desy.de [131.169.56.155])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A956F1B9
        for <linux-nfs@vger.kernel.org>; Mon, 11 Sep 2023 07:59:06 -0700 (PDT)
Received: from smtp-buf-2.desy.de (smtp-buf-2.desy.de [131.169.56.165])
        by smtp-o-2.desy.de (Postfix) with ESMTP id 0CA8C1611EE
        for <linux-nfs@vger.kernel.org>; Mon, 11 Sep 2023 16:59:05 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp-o-2.desy.de 0CA8C1611EE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=desy.de; s=default;
        t=1694444345; bh=1ROMS8kvUcUhiUc4c+OL2ZSTgs3ivgSt2Uktr1DkDZc=;
        h=Date:From:To:In-Reply-To:References:Subject:From;
        b=tappqgFrYCPqC1bDD9+JByRtNq3tgCMfsTUA1QqyTWfLYI2I4k11NuvTm+au/OGnh
         P2zw75esV96sGBkPPCwGKVfRtLWLbHM4Dm33NMbxdtZT0X2X/JmVqBZR973GbEIg9v
         WUHuitpWZdVlo9X6iGIVaMTKhur10lsoduGgkSpk=
Received: from smtp-m-2.desy.de (smtp-m-2.desy.de [131.169.56.130])
        by smtp-buf-2.desy.de (Postfix) with ESMTP id 0378E1A00C2
        for <linux-nfs@vger.kernel.org>; Mon, 11 Sep 2023 16:59:05 +0200 (CEST)
Received: from c1722.mx.srv.dfn.de (c1722.mx.srv.dfn.de [194.95.239.47])
        by smtp-m-2.desy.de (Postfix) with ESMTP id 065AF120042
        for <linux-nfs@vger.kernel.org>; Mon, 11 Sep 2023 16:59:05 +0200 (CEST)
Received: from smtp-intra-3.desy.de (smtp-intra-3.desy.de [131.169.56.69])
        by c1722.mx.srv.dfn.de (Postfix) with ESMTP id 61C05A003B
        for <linux-nfs@vger.kernel.org>; Mon, 11 Sep 2023 16:59:04 +0200 (CEST)
Received: from z-mbx-2.desy.de (z-mbx-2.desy.de [131.169.55.140])
        by smtp-intra-3.desy.de (Postfix) with ESMTP id 3F63980070
        for <linux-nfs@vger.kernel.org>; Mon, 11 Sep 2023 16:59:04 +0200 (CEST)
Date:   Mon, 11 Sep 2023 16:59:04 +0200 (CEST)
From:   "Mkrtchyan, Tigran" <tigran.mkrtchyan@desy.de>
To:     linux-nfs <linux-nfs@vger.kernel.org>
Message-ID: <582547008.6087350.1694444344114.JavaMail.zimbra@desy.de>
In-Reply-To: <20230829110411.8394-1-tigran.mkrtchyan@desy.de>
References: <20230829110411.8394-1-tigran.mkrtchyan@desy.de>
Subject: Fwd: [PATCH] nfs41: flexfiles: drop dependency between flexfiles
 layout driver and NFSv3 modules
MIME-Version: 1.0
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256; 
        boundary="----=_Part_6087351_1006156126.1694444344188"
X-Mailer: Zimbra 9.0.0_GA_4546 (ZimbraWebClient - FF117 (Linux)/9.0.0_GA_4546)
Thread-Topic: nfs41: flexfiles: drop dependency between flexfiles layout driver and NFSv3 modules
Thread-Index: 2LwT7vt/6Sff38egg4bc3bBPV1wzCg==
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HK_RANDOM_ENVFROM,
        HK_RANDOM_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

------=_Part_6087351_1006156126.1694444344188
Date: Mon, 11 Sep 2023 16:59:04 +0200 (CEST)
From: "Mkrtchyan, Tigran" <tigran.mkrtchyan@desy.de>
To: linux-nfs <linux-nfs@vger.kernel.org>
Message-ID: <582547008.6087350.1694444344114.JavaMail.zimbra@desy.de>
In-Reply-To: <20230829110411.8394-1-tigran.mkrtchyan@desy.de>
References: <20230829110411.8394-1-tigran.mkrtchyan@desy.de>
Subject: Fwd: [PATCH] nfs41: flexfiles: drop dependency between flexfiles
 layout driver and NFSv3 modules
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Mailer: Zimbra 9.0.0_GA_4546 (ZimbraWebClient - FF117 (Linux)/9.0.0_GA_4546)
Thread-Topic: nfs41: flexfiles: drop dependency between flexfiles layout driver and NFSv3 modules
Thread-Index: 2LwT7vt/6Sff38egg4bc3bBPV1wzCg==


Ups. Forwarding to correct list.

----- On 29 Aug, 2023, at 13:04, Tigran Mkrtchyan tigran.mkrtchyan@desy.de wrote:

The flexfiles layout driver depends on NFSv3 module as data servers
might be configure to provide nfsv3 only.

Disabling the nfsv3 protocol completely disables the flexfiles layout driver,
however, the data server still might support v4.1 protocol. Thus the strond
couling betwwen flexfiles and nfsv3 modules should be relaxed, as layout driver
will return UNSUPPORTED if not matching protocol is found.

Signed-off-by: Tigran Mkrtchyan <tigran.mkrtchyan@desy.de>
---
 fs/nfs/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/nfs/Kconfig b/fs/nfs/Kconfig
index b6fc169be1b1..ba95246be09e 100644
--- a/fs/nfs/Kconfig
+++ b/fs/nfs/Kconfig
@@ -125,7 +125,7 @@ config PNFS_BLOCK
 
 config PNFS_FLEXFILE_LAYOUT
 	tristate
-	depends on NFS_V4_1 && NFS_V3
+	depends on NFS_V4_1
 	default NFS_V4
 
 config NFS_V4_1_IMPLEMENTATION_ID_DOMAIN
-- 
2.39.1
------=_Part_6087351_1006156126.1694444344188
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
OTExMTQ1OTA0WjAtBgkqhkiG9w0BCTQxIDAeMA0GCWCGSAFlAwQCAQUAoQ0GCSqGSIb3DQEBCwUA
MC8GCSqGSIb3DQEJBDEiBCBxCp0A04a8KwF3/TLdDm4EtEzf243BBEahJE4wYX84/zA0BgkqhkiG
9w0BCQ8xJzAlMAoGCCqGSIb3DQMHMA4GCCqGSIb3DQMCAgIAgDAHBgUrDgMCBzANBgkqhkiG9w0B
AQsFAASCAQAubuztIwNLn7dSTjwQe2RGKRhZfrmUpXtAc0yNdI81DHOvdSlWZri37pfPF0HGAGb7
QgMZQPg5TJzmvxesXf5DIoX1U7oYLvmsUA6G6KK/MS1MFDaNTVCsaQWVvAe1ZLUcSVsRjeNtsQJ2
YRRdkX0Vm44vdoTK65w2ACzGDkTAACtM+9kdofUE178ZLMu9Vhl1izeIiTzTY05MPM+Hz7PNMO0i
FHW5XLrywqL6hsqehpUbdHzl5vq4daFR+YYKL6qKhCNg56NMgZsexf0+xdOlsqepuFj5ygu+LxfS
hAQUyZtVUTyBiV3HMypvDjvJX8F0IWpfFlQ+ABZzAxMghdC1AAAAAAAA
------=_Part_6087351_1006156126.1694444344188--

Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F5F278B362
	for <lists+linux-nfs@lfdr.de>; Mon, 28 Aug 2023 16:43:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229526AbjH1OnF (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 28 Aug 2023 10:43:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230063AbjH1Omz (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 28 Aug 2023 10:42:55 -0400
Received: from smtp-o-2.desy.de (smtp-o-2.desy.de [131.169.56.155])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4987FF7
        for <linux-nfs@vger.kernel.org>; Mon, 28 Aug 2023 07:42:49 -0700 (PDT)
Received: from smtp-buf-2.desy.de (smtp-buf-2.desy.de [IPv6:2001:638:700:1038::1:a5])
        by smtp-o-2.desy.de (Postfix) with ESMTP id 4177E161287
        for <linux-nfs@vger.kernel.org>; Mon, 28 Aug 2023 16:42:45 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp-o-2.desy.de 4177E161287
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=desy.de; s=default;
        t=1693233765; bh=Ss+KKw/6ru+fAC4zi9EIlkE1nImGETh76aSWk17pqpY=;
        h=Date:From:To:Cc:Subject:From;
        b=DqE5mmwDMqG5urk+G9kXQpONyFxPQi+a7mqnAr6e1RGy4ZTvt3Lafs/eVBEmcXvdr
         8EujuG8/tywVgj9+uCIUO+53c+c6ntvUUJtxIIWNi17owxP6j7DUTNoyoTFQFiS13P
         3uKlw25BiwKoIbofOkaejPM5ez3mMw1mEsTRVlPE=
Received: from smtp-m-2.desy.de (smtp-m-2.desy.de [131.169.56.130])
        by smtp-buf-2.desy.de (Postfix) with ESMTP id 384821A0125;
        Mon, 28 Aug 2023 16:42:45 +0200 (CEST)
Received: from b1722.mx.srv.dfn.de (b1722.mx.srv.dfn.de [194.95.235.47])
        by smtp-m-2.desy.de (Postfix) with ESMTP id 2F0A7120043;
        Mon, 28 Aug 2023 16:42:45 +0200 (CEST)
Received: from smtp-intra-2.desy.de (smtp-intra-2.desy.de [131.169.56.83])
        by b1722.mx.srv.dfn.de (Postfix) with ESMTP id B47A8220039;
        Mon, 28 Aug 2023 16:42:43 +0200 (CEST)
Received: from z-mbx-2.desy.de (z-mbx-2.desy.de [131.169.55.140])
        by smtp-intra-2.desy.de (Postfix) with ESMTP id 8AAD0100043;
        Mon, 28 Aug 2023 16:42:43 +0200 (CEST)
Date:   Mon, 28 Aug 2023 16:42:43 +0200 (CEST)
From:   "Mkrtchyan, Tigran" <tigran.mkrtchyan@desy.de>
To:     linux-nfs <linux-nfs@vger.kernel.org>
Cc:     Trond Myklebust <trond.myklebust@hammerspace.com>
Message-ID: <2016757990.1241869.1693233763403.JavaMail.zimbra@desy.de>
Subject: Unnecessary dependecy between nfsv3 and flexfiles modules
MIME-Version: 1.0
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256; 
        boundary="----=_Part_1241874_1909839403.1693233763497"
X-Mailer: Zimbra 9.0.0_GA_4546 (ZimbraWebClient - FF116 (Linux)/9.0.0_GA_4546)
Thread-Index: IawCR9AHV7xoX0pIdvW/LjDSBmaxxw==
Thread-Topic: Unnecessary dependecy between nfsv3 and flexfiles modules
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HK_RANDOM_ENVFROM,
        HK_RANDOM_FROM,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

------=_Part_1241874_1909839403.1693233763497
Date: Mon, 28 Aug 2023 16:42:43 +0200 (CEST)
From: "Mkrtchyan, Tigran" <tigran.mkrtchyan@desy.de>
To: linux-nfs <linux-nfs@vger.kernel.org>
Cc: Trond Myklebust <trond.myklebust@hammerspace.com>
Message-ID: <2016757990.1241869.1693233763403.JavaMail.zimbra@desy.de>
Subject: Unnecessary dependecy between nfsv3 and flexfiles modules
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Mailer: Zimbra 9.0.0_GA_4546 (ZimbraWebClient - FF116 (Linux)/9.0.0_GA_4546)
Thread-Index: IawCR9AHV7xoX0pIdvW/LjDSBmaxxw==
Thread-Topic: Unnecessary dependecy between nfsv3 and flexfiles modules


Dear NFS developers,

I have noticed an unnecessary dependency between the pNFS flexfiles layout driver and NFSv3 modules:

```Kconfig 
config PNFS_FLEXFILE_LAYOUT
        tristate
        depends on NFS_V4_1 && NFS_V3
        default NFS_V4

```

Thus, by disabling v3 (as one might do if only v4.1+ is needed), the flexfiles
layout driver is not available anymore.

It looks like, that flexfiles layout doesn't really depend on NFSv3 code and if I remove
this dependency, that I can build and run a kernel with flexfiles layout driver, but without
NFSv3 support:


```
[root@os-46-nfs-devel ~]# lsmod
Module                  Size  Used by
nfs_layout_flexfiles    61440  1
nfsv4                1200128  2 nfs_layout_flexfiles
dns_resolver           12288  1 nfsv4
[root@os-46-nfs-devel ~]#
```

But might be there is a non-obvious dependency that I miss. Otherwise I happy to fix that :)

Best regards,
   Tigran.
------=_Part_1241874_1909839403.1693233763497
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
ODI4MTQ0MjQzWjAtBgkqhkiG9w0BCTQxIDAeMA0GCWCGSAFlAwQCAQUAoQ0GCSqGSIb3DQEBCwUA
MC8GCSqGSIb3DQEJBDEiBCAEKrBeZ0Fwlr2kY3XoJsswVde3yp8BnI2ch2ecu0nsyzA0BgkqhkiG
9w0BCQ8xJzAlMAoGCCqGSIb3DQMHMA4GCCqGSIb3DQMCAgIAgDAHBgUrDgMCBzANBgkqhkiG9w0B
AQsFAASCAQAh+fgyGX6R1forEYovsGTQ07ANueKhdmm7uAhlgs6Y6vs5GoYF/7BudVFFAB3z08O8
sL5KijeJ34UO+me9CxXn42zHqeR2cjF4SvRWT5xRLLc+e+zOeI7AvyOn8SW/+q45f2LScuZVp3Qs
m1Au93mGeqG0th00v6rU/8lzzSCVZyI7kv0djrtoot1iQHsrMrVtQD1HF9IaPmYr9dmQ4mReek9l
w3/KVL6mE+7Hsq6Ce2FjPIIHgMuos2ANNXDNZ6W6KVjtT0/CJV6af+pk0N11lmt1slU4mPURSsf8
JSHe8jsOshg7mnYwm/ssOw0hUcUay4BhogsrXw80vDuzr01lAAAAAAAA
------=_Part_1241874_1909839403.1693233763497--

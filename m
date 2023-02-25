Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66F826A295C
	for <lists+linux-nfs@lfdr.de>; Sat, 25 Feb 2023 12:45:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229542AbjBYLpc (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sat, 25 Feb 2023 06:45:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229503AbjBYLpb (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sat, 25 Feb 2023 06:45:31 -0500
Received: from smtp-o-1.desy.de (smtp-o-1.desy.de [131.169.56.154])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21BB01C5AA
        for <linux-nfs@vger.kernel.org>; Sat, 25 Feb 2023 03:45:29 -0800 (PST)
Received: from smtp-buf-1.desy.de (smtp-buf-1.desy.de [131.169.56.164])
        by smtp-o-1.desy.de (Postfix) with ESMTP id 39115E0AF5
        for <linux-nfs@vger.kernel.org>; Sat, 25 Feb 2023 12:45:27 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp-o-1.desy.de 39115E0AF5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=desy.de; s=default;
        t=1677325527; bh=XcGlThv4nmPUYOpvzTj5s7imvyaP4FWNwgFDdJeUr2s=;
        h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
        b=UTx8uVXlA+pPM+UtWuBdR82FJsMQjXR0r4z5Y/TByRcT6B1nOIEL2wPcrMlm2OUVG
         XP2+KyZIjltmZ2xY2RNvE17bT3rowN7Wip/pgN46Nd4r3vxV2FK0g2fCh2K2Gkuyfm
         f8WGoFmQN8Ud4MVZzW5qOS44BuBJ90rSrHl0o+A4=
Received: from smtp-m-1.desy.de (smtp-m-1.desy.de [131.169.56.129])
        by smtp-buf-1.desy.de (Postfix) with ESMTP id 2859D1202CB;
        Sat, 25 Feb 2023 12:45:27 +0100 (CET)
Received: from smtp-intra-1.desy.de (smtp-intra-1.desy.de [131.169.56.82])
        by smtp-m-1.desy.de (Postfix) with ESMTP id 226E540143;
        Sat, 25 Feb 2023 12:45:27 +0100 (CET)
Received: from z-mbx-2.desy.de (z-mbx-2.desy.de [131.169.55.140])
        by smtp-intra-1.desy.de (Postfix) with ESMTP id 1CB2AC00A2;
        Sat, 25 Feb 2023 12:45:27 +0100 (CET)
Date:   Sat, 25 Feb 2023 12:45:26 +0100 (CET)
From:   "Mkrtchyan, Tigran" <tigran.mkrtchyan@desy.de>
To:     "J. Bruce Fields" <bfields@fieldses.org>
Cc:     Jeff Layton <jlayton@kernel.org>, Dai Ngo <dai.ngo@oracle.com>,
        linux-nfs <linux-nfs@vger.kernel.org>,
        Frank Filz <ffilzlnx@mindspring.com>
Message-ID: <436117750.41744935.1677325526601.JavaMail.zimbra@desy.de>
In-Reply-To: <20230223151132.GA10456@fieldses.org>
References: <20230222134952.32851-1-jlayton@kernel.org> <20230223151132.GA10456@fieldses.org>
Subject: Re: [pynfs RFC PATCH] nfs4.0/testserver.py: don't return an error
 when tests fail
MIME-Version: 1.0
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256; 
        boundary="----=_Part_41744936_2021151205.1677325527077"
X-Mailer: Zimbra 9.0.0_GA_4485 (ZimbraWebClient - FF110 (Linux)/9.0.0_GA_4478)
Thread-Topic: nfs4.0/testserver.py: don't return an error when tests fail
Thread-Index: DtDD6zX9qcKwlzioT4FaderabT6sCA==
X-Spam-Status: No, score=-6.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HK_RANDOM_ENVFROM,
        HK_RANDOM_FROM,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

------=_Part_41744936_2021151205.1677325527077
Date: Sat, 25 Feb 2023 12:45:26 +0100 (CET)
From: "Mkrtchyan, Tigran" <tigran.mkrtchyan@desy.de>
To: "J. Bruce Fields" <bfields@fieldses.org>
Cc: Jeff Layton <jlayton@kernel.org>, Dai Ngo <dai.ngo@oracle.com>, 
	linux-nfs <linux-nfs@vger.kernel.org>, 
	Frank Filz <ffilzlnx@mindspring.com>
Message-ID: <436117750.41744935.1677325526601.JavaMail.zimbra@desy.de>
In-Reply-To: <20230223151132.GA10456@fieldses.org>
References: <20230222134952.32851-1-jlayton@kernel.org> <20230223151132.GA10456@fieldses.org>
Subject: Re: [pynfs RFC PATCH] nfs4.0/testserver.py: don't return an error
 when tests fail
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Mailer: Zimbra 9.0.0_GA_4485 (ZimbraWebClient - FF110 (Linux)/9.0.0_GA_4478)
Thread-Topic: nfs4.0/testserver.py: don't return an error when tests fail
Thread-Index: DtDD6zX9qcKwlzioT4FaderabT6sCA==


----- Original Message -----
> From: "J. Bruce Fields" <bfields@fieldses.org>
> To: "Jeff Layton" <jlayton@kernel.org>
> Cc: "Dai Ngo" <dai.ngo@oracle.com>, "linux-nfs" <linux-nfs@vger.kernel.org>, "Frank Filz" <ffilzlnx@mindspring.com>
> Sent: Thursday, 23 February, 2023 16:11:32
> Subject: Re: [pynfs RFC PATCH] nfs4.0/testserver.py: don't return an error when tests fail

> I orginally thought I'd continue maintaining pynfs on a volunteer basis,
> but I haven't been.  These all look like reasonable changes, but someone
> else probably needs to step in to make sure they're handled in a
> reasonable amount of time.
> 

Well, I already have a fork in github that is used by others. Thus I can try to
pick the patches from the mailing list and try to keep the tree up-to-date. 

Tigran.
> --b.
> 
> On Wed, Feb 22, 2023 at 08:49:52AM -0500, Jeff Layton wrote:
>> This script was originally changed in eb3ba0b60055 ("Have testserver.py
>> have non-zero exit code if any tests fail"), but the same change wasn't
>> made to the 4.1 testserver.py script.
>> 
>> There also wasn't much explanation for it, and it makes it difficult to
>> tell whether the test harness itself failed, or whether there was a
>> failure in a requested test.
>> 
>> Stop the 4.0 testserver.py from exiting with an error code when a test
>> fails, so that a successful return means only that the test harness
>> itself worked, not that every requested test passed.
>> 
>> Cc: Frank Filz <ffilzlnx@mindspring.com>
>> Signed-off-by: Jeff Layton <jlayton@kernel.org>
>> ---
>>  nfs4.0/testserver.py | 2 --
>>  1 file changed, 2 deletions(-)
>> 
>> I'm not sure about this one. I've worked around this in kdevops for now,
>> but it would really be preferable if it worked this way, imo. If this
>> isn't acceptable, maybe we can add a new option that enables this
>> behavior?
>> 
>> Frank, what was the original rationale for eb3ba0b60055 ?
>> 
>> diff --git a/nfs4.0/testserver.py b/nfs4.0/testserver.py
>> index f2c41568e5c7..4f4286daa657 100755
>> --- a/nfs4.0/testserver.py
>> +++ b/nfs4.0/testserver.py
>> @@ -387,8 +387,6 @@ def main():
>>  
>>      if nfail < 0:
>>          sys.exit(3)
>> -    if nfail > 0:
>> -        sys.exit(2)
>>  
>>  if __name__ == "__main__":
>>      main()
>> --
> > 2.39.2

------=_Part_41744936_2021151205.1677325527077
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
MjI1MTE0NTI3WjAtBgkqhkiG9w0BCTQxIDAeMA0GCWCGSAFlAwQCAQUAoQ0GCSqGSIb3DQEBCwUA
MC8GCSqGSIb3DQEJBDEiBCD2sB19JvyK78vr8cOHsMiqdWZJlbuQw+rxvzpuPjmTXTA0BgkqhkiG
9w0BCQ8xJzAlMAoGCCqGSIb3DQMHMA4GCCqGSIb3DQMCAgIAgDAHBgUrDgMCBzANBgkqhkiG9w0B
AQsFAASCAQAu/9Z/zoqb3PJKEn/on7ECY5tQjOYviM6mlK1KsRExj39mJbZ1UOLGq2x596/gugmS
In7mkYdwgPLqjYLCiBx7kw0fkI9Qlo3b5b2nHS9atrXyoC2Jeuh0F09g9f1AKVa6XxhrN/Bpj5Xe
g8puUrAWDlGFIGAOuze7prwcZ4VNfcy61Ysv/lP4x1QnK1kyumvwCa8rIzGjgd7mS2nmhVGqEFXe
geXFyqb+YrxCoQliuyqWoAjHPgnC9gHZlbIxKnPq+QgXcSv3SB8mOkjnikv1Yq+2k0d74b/xzIqR
Ejppy4PeCLYJnJxLPSbqMKnz322sfsEcf8iMgIrnBAKaEa50AAAAAAAA
------=_Part_41744936_2021151205.1677325527077--

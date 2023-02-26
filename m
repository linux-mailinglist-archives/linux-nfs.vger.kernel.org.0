Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C745C6A339A
	for <lists+linux-nfs@lfdr.de>; Sun, 26 Feb 2023 20:25:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229545AbjBZTZx (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sun, 26 Feb 2023 14:25:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbjBZTZw (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sun, 26 Feb 2023 14:25:52 -0500
Received: from smtp-o-3.desy.de (smtp-o-3.desy.de [IPv6:2001:638:700:1038::1:9c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B11A6CA03
        for <linux-nfs@vger.kernel.org>; Sun, 26 Feb 2023 11:25:49 -0800 (PST)
Received: from smtp-buf-3.desy.de (smtp-buf-3.desy.de [131.169.56.166])
        by smtp-o-3.desy.de (Postfix) with ESMTP id ED3F96080F
        for <linux-nfs@vger.kernel.org>; Sun, 26 Feb 2023 20:25:46 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp-o-3.desy.de ED3F96080F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=desy.de; s=default;
        t=1677439547; bh=FeVx7lBMRSkbudJpGx94V9W69J8E/OFPz83H5Cz6e4c=;
        h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
        b=imxO8v1obuQ99FTzXkLmXdiDj5XdhCCpy57veaRAhL5dnfXmUTS1T+GJMdew50jer
         HTrFoch1kqgg5EcI57D6ofpsaYJc0a1DugA5pkJ8YA6NcGTvHIBo6/oPRoacOlLNKO
         dDf5W9g/EVXauXB7Bz7129hc4VG1n4ouozP8biZo=
Received: from smtp-m-3.desy.de (smtp-m-3.desy.de [IPv6:2001:638:700:1038::1:83])
        by smtp-buf-3.desy.de (Postfix) with ESMTP id D64EDA00B3;
        Sun, 26 Feb 2023 20:25:46 +0100 (CET)
Received: from smtp-intra-3.desy.de (smtp-intra-3.desy.de [IPv6:2001:638:700:1038::1:45])
        by smtp-m-3.desy.de (Postfix) with ESMTP id CB31260052;
        Sun, 26 Feb 2023 20:25:46 +0100 (CET)
Received: from z-mbx-2.desy.de (z-mbx-2.desy.de [131.169.55.140])
        by smtp-intra-3.desy.de (Postfix) with ESMTP id C213580067;
        Sun, 26 Feb 2023 20:25:46 +0100 (CET)
Date:   Sun, 26 Feb 2023 20:25:46 +0100 (CET)
From:   "Mkrtchyan, Tigran" <tigran.mkrtchyan@desy.de>
To:     Calum Mackay <calum.mackay@oracle.com>
Cc:     "J. Bruce Fields" <bfields@fieldses.org>,
        Jeff Layton <jlayton@kernel.org>, Dai Ngo <dai.ngo@oracle.com>,
        linux-nfs <linux-nfs@vger.kernel.org>,
        Frank Filz <ffilzlnx@mindspring.com>
Message-ID: <1098197133.42034815.1677439546609.JavaMail.zimbra@desy.de>
In-Reply-To: <f7c1e360-9d93-c522-b24a-5aeecf9a17f0@oracle.com>
References: <20230222134952.32851-1-jlayton@kernel.org> <20230223151132.GA10456@fieldses.org> <436117750.41744935.1677325526601.JavaMail.zimbra@desy.de> <f7c1e360-9d93-c522-b24a-5aeecf9a17f0@oracle.com>
Subject: Re: [pynfs RFC PATCH] nfs4.0/testserver.py: don't return an error
 when tests fail
MIME-Version: 1.0
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256; 
        boundary="----=_Part_42034816_845033863.1677439546728"
X-Mailer: Zimbra 9.0.0_GA_4485 (ZimbraWebClient - FF110 (Linux)/9.0.0_GA_4478)
Thread-Topic: nfs4.0/testserver.py: don't return an error when tests fail
Thread-Index: ZcIqUyHs6N+/r1kthS4IuNUFJl8hiw==
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HK_RANDOM_ENVFROM,
        HK_RANDOM_FROM,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

------=_Part_42034816_845033863.1677439546728
Date: Sun, 26 Feb 2023 20:25:46 +0100 (CET)
From: "Mkrtchyan, Tigran" <tigran.mkrtchyan@desy.de>
To: Calum Mackay <calum.mackay@oracle.com>
Cc: "J. Bruce Fields" <bfields@fieldses.org>, Jeff Layton <jlayton@kernel.org>, 
	Dai Ngo <dai.ngo@oracle.com>, linux-nfs <linux-nfs@vger.kernel.org>, 
	Frank Filz <ffilzlnx@mindspring.com>
Message-ID: <1098197133.42034815.1677439546609.JavaMail.zimbra@desy.de>
In-Reply-To: <f7c1e360-9d93-c522-b24a-5aeecf9a17f0@oracle.com>
References: <20230222134952.32851-1-jlayton@kernel.org> <20230223151132.GA10456@fieldses.org> <436117750.41744935.1677325526601.JavaMail.zimbra@desy.de> <f7c1e360-9d93-c522-b24a-5aeecf9a17f0@oracle.com>
Subject: Re: [pynfs RFC PATCH] nfs4.0/testserver.py: don't return an error
 when tests fail
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Mailer: Zimbra 9.0.0_GA_4485 (ZimbraWebClient - FF110 (Linux)/9.0.0_GA_4478)
Thread-Topic: nfs4.0/testserver.py: don't return an error when tests fail
Thread-Index: ZcIqUyHs6N+/r1kthS4IuNUFJl8hiw==



----- Original Message -----
> From: "Calum Mackay" <calum.mackay@oracle.com>
> To: "Tigran Mkrtchyan" <tigran.mkrtchyan@desy.de>, "J. Bruce Fields" <bfields@fieldses.org>
> Cc: "Calum Mackay" <calum.mackay@oracle.com>, "Jeff Layton" <jlayton@kernel.org>, "Dai Ngo" <dai.ngo@oracle.com>,
> "linux-nfs" <linux-nfs@vger.kernel.org>, "Frank Filz" <ffilzlnx@mindspring.com>
> Sent: Saturday, 25 February, 2023 16:57:12
> Subject: Re: [pynfs RFC PATCH] nfs4.0/testserver.py: don't return an error when tests fail

> On 25/02/2023 11:45 am, Mkrtchyan, Tigran wrote:
>> 
>> ----- Original Message -----
>>> From: "J. Bruce Fields" <bfields@fieldses.org>
>>> To: "Jeff Layton" <jlayton@kernel.org>
>>> Cc: "Dai Ngo" <dai.ngo@oracle.com>, "linux-nfs" <linux-nfs@vger.kernel.org>,
>>> "Frank Filz" <ffilzlnx@mindspring.com>
>>> Sent: Thursday, 23 February, 2023 16:11:32
>>> Subject: Re: [pynfs RFC PATCH] nfs4.0/testserver.py: don't return an error when
>>> tests fail
>> 
>>> I orginally thought I'd continue maintaining pynfs on a volunteer basis,
>>> but I haven't been.  These all look like reasonable changes, but someone
>>> else probably needs to step in to make sure they're handled in a
>>> reasonable amount of time.
>>>
>> 
>> Well, I already have a fork in github that is used by others. Thus I can try to
>> pick the patches from the mailing list and try to keep the tree up-to-date.
> 
> hi Tigran, I was going to take it over from Bruce, unless you'd prefer
> to, which is fine?

Hi Calum,

just go ahead!

Thanks for the effort,
   Tigran.

> 
> cheers,
> calum.
> 
>> 
>> Tigran.
>>> --b.
>>>
>>> On Wed, Feb 22, 2023 at 08:49:52AM -0500, Jeff Layton wrote:
>>>> This script was originally changed in eb3ba0b60055 ("Have testserver.py
>>>> have non-zero exit code if any tests fail"), but the same change wasn't
>>>> made to the 4.1 testserver.py script.
>>>>
>>>> There also wasn't much explanation for it, and it makes it difficult to
>>>> tell whether the test harness itself failed, or whether there was a
>>>> failure in a requested test.
>>>>
>>>> Stop the 4.0 testserver.py from exiting with an error code when a test
>>>> fails, so that a successful return means only that the test harness
>>>> itself worked, not that every requested test passed.
>>>>
>>>> Cc: Frank Filz <ffilzlnx@mindspring.com>
>>>> Signed-off-by: Jeff Layton <jlayton@kernel.org>
>>>> ---
>>>>   nfs4.0/testserver.py | 2 --
>>>>   1 file changed, 2 deletions(-)
>>>>
>>>> I'm not sure about this one. I've worked around this in kdevops for now,
>>>> but it would really be preferable if it worked this way, imo. If this
>>>> isn't acceptable, maybe we can add a new option that enables this
>>>> behavior?
>>>>
>>>> Frank, what was the original rationale for eb3ba0b60055 ?
>>>>
>>>> diff --git a/nfs4.0/testserver.py b/nfs4.0/testserver.py
>>>> index f2c41568e5c7..4f4286daa657 100755
>>>> --- a/nfs4.0/testserver.py
>>>> +++ b/nfs4.0/testserver.py
>>>> @@ -387,8 +387,6 @@ def main():
>>>>   
>>>>       if nfail < 0:
>>>>           sys.exit(3)
>>>> -    if nfail > 0:
>>>> -        sys.exit(2)
>>>>   
>>>>   if __name__ == "__main__":
>>>>       main()
>>>> --
>>>> 2.39.2
> 
> --
> Calum Mackay
> Linux Kernel Engineering
> Oracle Linux and Virtualisation

------=_Part_42034816_845033863.1677439546728
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
MjI2MTkyNTQ2WjAtBgkqhkiG9w0BCTQxIDAeMA0GCWCGSAFlAwQCAQUAoQ0GCSqGSIb3DQEBCwUA
MC8GCSqGSIb3DQEJBDEiBCD3FWPOQz3avss+n096+wrJOVM2YVbxZVzspO7Kkcbp4TA0BgkqhkiG
9w0BCQ8xJzAlMAoGCCqGSIb3DQMHMA4GCCqGSIb3DQMCAgIAgDAHBgUrDgMCBzANBgkqhkiG9w0B
AQsFAASCAQA+W9tXACtmxDMmFfAour3COIhAM6kMgjxeHBUhIncK0nEF46VI1lh1yXveaovZkKj2
BEE61XnRjQY7LQgmuKSQIHCIqfJq/MkPfz77fLfZcip7irdMDVjZcjivWZ/txtCODcaA+6fO4kz8
DYZ3W8i7kleVryF5tHuxC7nCRVUUTbu7UprjEDJOOm2+K2gaE8lT42ACDGWzHt1ByLWoRjcVHbPS
uUw9AYvQt0pefo6kN5oYtA1TS/kCdFnchNy+5/s6BYieUwSjBfTCjLYZ+w86Hk/RTURiqr+OWVWx
UFYCWe6i5L9QNS9FaWQHvTgUI6oPI2Bh+FBbz6s/BcWTn+0JAAAAAAAA
------=_Part_42034816_845033863.1677439546728--

Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C95C53B69F
	for <lists+linux-nfs@lfdr.de>; Thu,  2 Jun 2022 12:09:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233404AbiFBKJo (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 2 Jun 2022 06:09:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbiFBKJn (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 2 Jun 2022 06:09:43 -0400
X-Greylist: delayed 96108 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 02 Jun 2022 03:09:41 PDT
Received: from smtp-o-3.desy.de (smtp-o-3.desy.de [IPv6:2001:638:700:1038::1:9c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FEC92ACB7F
        for <linux-nfs@vger.kernel.org>; Thu,  2 Jun 2022 03:09:40 -0700 (PDT)
Received: from smtp-buf-3.desy.de (smtp-buf-3.desy.de [IPv6:2001:638:700:1038::1:a6])
        by smtp-o-3.desy.de (Postfix) with ESMTP id 4983860885
        for <linux-nfs@vger.kernel.org>; Thu,  2 Jun 2022 12:09:38 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp-o-3.desy.de 4983860885
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=desy.de; s=default;
        t=1654164578; bh=urCS+3toAfOetww/jr/GtKJU67uxk99HP0NLZWgPhiw=;
        h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
        b=ZBTc7p2qZ27EqOLpbiqS5qMqu7sHCj0SzgEZmYnVIeAeiGrypXBmxs3LmVU0Dw3r/
         ZyehVTlmuzwGmqLlJj251RwwIAL6QpFXQS+fqhqo16tFIJNb3rlYDv/5nA7L3jIPkC
         gj8BIGqfDdFC8+vNXAkbjtjyCcxseCZgL6v2ZOyk=
Received: from smtp-m-3.desy.de (smtp-m-3.desy.de [IPv6:2001:638:700:1038::1:83])
        by smtp-buf-3.desy.de (Postfix) with ESMTP id 3FBB3A0586;
        Thu,  2 Jun 2022 12:09:38 +0200 (CEST)
X-Virus-Scanned: amavisd-new at desy.de
Received: from z-mbx-2.desy.de (z-mbx-2.desy.de [131.169.55.140])
        by smtp-intra-2.desy.de (Postfix) with ESMTP id 108CE1001A9;
        Thu,  2 Jun 2022 12:09:38 +0200 (CEST)
Date:   Thu, 2 Jun 2022 12:09:37 +0200 (CEST)
From:   "Mkrtchyan, Tigran" <tigran.mkrtchyan@desy.de>
To:     trondmy <trondmy@hammerspace.com>
Cc:     Olga Kornievskaia <olga.kornievskaia@gmail.com>,
        linux-nfs <linux-nfs@vger.kernel.org>,
        Anna Schumaker <anna.schumaker@netapp.com>
Message-ID: <982484795.17789404.1654164577712.JavaMail.zimbra@desy.de>
In-Reply-To: <d858eb0f5c31e74185b2fc0fc29caedd06fe577b.camel@hammerspace.com>
References: <20220531134854.63115-1-olga.kornievskaia@gmail.com> <b829962068bf70b5aadcb16fd0265ec64c85f853.camel@hammerspace.com> <CAN-5tyGF56-spgEcwLV2cfw4KnNfO_ru9tRH9i_mMh+wmC+cTg@mail.gmail.com> <1666242553.16570812.1654068467831.JavaMail.zimbra@desy.de> <d858eb0f5c31e74185b2fc0fc29caedd06fe577b.camel@hammerspace.com>
Subject: Re: [PATCH] pNFS: fix IO thread starvation problem during
 LAYOUTUNAVAILABLE error
MIME-Version: 1.0
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256; 
        boundary="----=_Part_17789406_702074550.1654164578009"
X-Mailer: Zimbra 8.8.15_GA_4203 (ZimbraWebClient - FF100 (Linux)/8.8.15_GA_4232)
Thread-Topic: pNFS: fix IO thread starvation problem during LAYOUTUNAVAILABLE error
Thread-Index: AQHYdPUwtG1kTZlHl06QKDjQMPTRBK05FEoAgAARwQCAAQI5gIAAjI8Aw8etdXM=
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HK_RANDOM_ENVFROM,
        HK_RANDOM_FROM,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

------=_Part_17789406_702074550.1654164578009
Date: Thu, 2 Jun 2022 12:09:37 +0200 (CEST)
From: "Mkrtchyan, Tigran" <tigran.mkrtchyan@desy.de>
To: trondmy <trondmy@hammerspace.com>
Cc: Olga Kornievskaia <olga.kornievskaia@gmail.com>, 
	linux-nfs <linux-nfs@vger.kernel.org>, 
	Anna Schumaker <anna.schumaker@netapp.com>
Message-ID: <982484795.17789404.1654164577712.JavaMail.zimbra@desy.de>
In-Reply-To: <d858eb0f5c31e74185b2fc0fc29caedd06fe577b.camel@hammerspace.com>
References: <20220531134854.63115-1-olga.kornievskaia@gmail.com> <b829962068bf70b5aadcb16fd0265ec64c85f853.camel@hammerspace.com> <CAN-5tyGF56-spgEcwLV2cfw4KnNfO_ru9tRH9i_mMh+wmC+cTg@mail.gmail.com> <1666242553.16570812.1654068467831.JavaMail.zimbra@desy.de> <d858eb0f5c31e74185b2fc0fc29caedd06fe577b.camel@hammerspace.com>
Subject: Re: [PATCH] pNFS: fix IO thread starvation problem during
 LAYOUTUNAVAILABLE error
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Mailer: Zimbra 8.8.15_GA_4203 (ZimbraWebClient - FF100 (Linux)/8.8.15_GA_4232)
Thread-Topic: pNFS: fix IO thread starvation problem during LAYOUTUNAVAILABLE error
Thread-Index: AQHYdPUwtG1kTZlHl06QKDjQMPTRBK05FEoAgAARwQCAAQI5gIAAjI8Aw8etdXM=


I had re-run the tests. So, indeed, if I wait log enough, then client falls back to IO
through MDS and issues a new LAYOUTGET after the first successful READ operation.

the capture available at https://sas.desy.de/index.php/s/StGeijXTGysdHa2

Best regards,
  Tigran.


----- Original Message -----
> From: "trondmy" <trondmy@hammerspace.com>
> To: "Tigran Mkrtchyan" <tigran.mkrtchyan@desy.de>, "Olga Kornievskaia" <olga.kornievskaia@gmail.com>
> Cc: "linux-nfs" <linux-nfs@vger.kernel.org>, "Anna Schumaker" <anna.schumaker@netapp.com>
> Sent: Wednesday, 1 June, 2022 17:50:53
> Subject: Re: [PATCH] pNFS: fix IO thread starvation problem during LAYOUTUNAVAILABLE error

> On Wed, 2022-06-01 at 09:27 +0200, Mkrtchyan, Tigran wrote:
>> Hi Olga,
>> 
>> ----- Original Message -----
>> > From: "Olga Kornievskaia" <olga.kornievskaia@gmail.com>
>> > To: "trondmy" <trondmy@hammerspace.com>
>> > Cc: "Anna Schumaker" <anna.schumaker@netapp.com>, "linux-nfs"
>> > <linux-nfs@vger.kernel.org>
>> > Sent: Tuesday, 31 May, 2022 18:03:34
>> > Subject: Re: [PATCH] pNFS: fix IO thread starvation problem during
>> > LAYOUTUNAVAILABLE error
>> 
>> 
> 
> <snip>
> 
>> > To clarify, can you confirm that LAYOUTUNAVAILABLE would only turn
>> > off
>> > the inode permanently but for a period of time?
>> > 
>> > It looks to me that for the LAYOUTTRYLATER, the client would face
>> > the
>> > same starvation problem in the same situation. I don't see anything
>> > marking the segment failed for such error? I believe the client
>> > returns nolayout for that error, falls back to MDS but allows
>> > asking
>> > for the layout for a period of time, having again the queue of
>> > waiters
>> 
>> Your assumption doesn't match to our observation. For files that off-
>> line
>> (DS down or file is on tape) we return LAYOUTTRYLATER. Usually,
>> client keep
>> re-trying LAYOUTGET until file is available again. We use flexfile
>> layout
>> as nfs4_file has less predictable behavior. For files that should be
>> served
>> by MDS we return LAYOUTUNAVAILABLE. Typically, those files are quite
>> small
>> and served with a single READ request, so I haven't observe
>> repetitive LAYOUTGET
>> calls.
> 
> Right. If you're only doing READ, and this is a small file, then you
> are unlikely to see any repetition of the LAYOUTGET calls like Olga
> describes, because the client page cache will take care of serialising
> the initial I/O (by means of the folio lock/page lock) and will cache
> the results so that no further I/O is needed.
> 
> The main problems with NFS4ERR_LAYOUTUNAVAILABLE in current pNFS
> implementation will occur when reading large files and/or when writing
> to the file. In those cases, we will send a LAYOUTGET each time we need
> to schedule more I/O because we don't cache the negative result of the
> previous attempt.
> 
> --
> Trond Myklebust
> Linux NFS client maintainer, Hammerspace
> trond.myklebust@hammerspace.com

------=_Part_17789406_702074550.1654164578009
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
NjAyMTAwOTM4WjAtBgkqhkiG9w0BCTQxIDAeMA0GCWCGSAFlAwQCAQUAoQ0GCSqGSIb3DQEBCwUA
MC8GCSqGSIb3DQEJBDEiBCC18oXjkuePzYvNSoEScgr5oHuGtpvJWrW9IcKque2kTjA0BgkqhkiG
9w0BCQ8xJzAlMAoGCCqGSIb3DQMHMA4GCCqGSIb3DQMCAgIAgDAHBgUrDgMCBzANBgkqhkiG9w0B
AQsFAASCAQAWt2Em5NdWTIL26MHrUxM7TiFNe8nTi57Zw40JzlOPza0yZUL8254H9tCj/tmNObqj
rLlD0jV4kWMO9xjMipFEi8bE4Dqy8MtPWM/qKfqACxdmGCbVVy9xRK/P1V86izO9H/SAmZDgqwxL
0v/WGNLmfnGQLJj/1L7IF67zrF/IPi5Kjfol6/sYX/8zC2QE+dXacv3IurzjZ34/gYhLu2Nm1oSH
4anCcXh6wzpyCA06Cwb051+DVBtTsbhlKJGgGxC6FD9TnwtCYDiMQjFAVET40mFQJvI5s8kLmIzX
LR+ruZz2uDSek10y40OVbUo4Oma6jGUNnyv+pq9MRFZFl5hoAAAAAAAA
------=_Part_17789406_702074550.1654164578009--

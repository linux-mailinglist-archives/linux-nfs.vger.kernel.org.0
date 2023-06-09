Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BF58729BA0
	for <lists+linux-nfs@lfdr.de>; Fri,  9 Jun 2023 15:30:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230413AbjFINal (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 9 Jun 2023 09:30:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239546AbjFINak (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 9 Jun 2023 09:30:40 -0400
Received: from smtp-o-1.desy.de (smtp-o-1.desy.de [IPv6:2001:638:700:1038::1:9a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C17DF30D6
        for <linux-nfs@vger.kernel.org>; Fri,  9 Jun 2023 06:30:38 -0700 (PDT)
Received: from smtp-buf-1.desy.de (smtp-buf-1.desy.de [IPv6:2001:638:700:1038::1:a4])
        by smtp-o-1.desy.de (Postfix) with ESMTP id 41CF1E0A78
        for <linux-nfs@vger.kernel.org>; Fri,  9 Jun 2023 15:30:37 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp-o-1.desy.de 41CF1E0A78
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=desy.de; s=default;
        t=1686317437; bh=TXKLwvxWsSb5WlMTeItWVRMWJmtKcl8anfUqjo537jk=;
        h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
        b=Z2S05bFjCwugvNQNXHMohK9+pob7jpYUiWgDIsw/7ISHwVj5UiwktRZuvPPl/AyEb
         c1DZbDTdQXcERYB6Q1dqSqsorR3ct3EWTvzTuNemFTQupg6lFXj7XKO/fiYyWek6zH
         kMnMNAFanJg0iiC+muZ1271bFlxwmU/qtG8+x/Gs=
Received: from smtp-m-1.desy.de (smtp-m-1.desy.de [IPv6:2001:638:700:1038::1:81])
        by smtp-buf-1.desy.de (Postfix) with ESMTP id 35E491203BE;
        Fri,  9 Jun 2023 15:30:37 +0200 (CEST)
Received: from b1722.mx.srv.dfn.de (b1722.mx.srv.dfn.de [IPv6:2001:638:d:c302:acdc:1979:2:e7])
        by smtp-m-1.desy.de (Postfix) with ESMTP id 2FE3D40317;
        Fri,  9 Jun 2023 15:30:37 +0200 (CEST)
Received-SPF: Neutral (mailfrom) identity=mailfrom; client-ip=131.169.56.82; helo=smtp-intra-1.desy.de; envelope-from=tigran.mkrtchyan@desy.de; receiver=<UNKNOWN> 
Received: from smtp-intra-1.desy.de (smtp-intra-1.desy.de [131.169.56.82])
        by b1722.mx.srv.dfn.de (Postfix) with ESMTP id 4F03B220039;
        Fri,  9 Jun 2023 15:30:36 +0200 (CEST)
Received: from z-mbx-2.desy.de (z-mbx-2.desy.de [131.169.55.140])
        by smtp-intra-1.desy.de (Postfix) with ESMTP id F0A29C00A2;
        Fri,  9 Jun 2023 15:30:35 +0200 (CEST)
Date:   Fri, 9 Jun 2023 15:30:35 +0200 (CEST)
From:   "Mkrtchyan, Tigran" <tigran.mkrtchyan@desy.de>
To:     Trond Myklebust <trondmy@hammerspace.com>
Cc:     anna@kernel.org, linux-nfs <linux-nfs@vger.kernel.org>
Message-ID: <1144390245.427543.1686317435856.JavaMail.zimbra@desy.de>
In-Reply-To: <437767d036ee95a7ce92d7fa2add82a441eedf78.camel@hammerspace.com>
References: <20230608144933.412664-1-tigran.mkrtchyan@desy.de> <cfde2b7b2a7f24f2652ce0bb82727cb0b810c758.camel@hammerspace.com> <AD6C85BF-50F9-42BB-83E8-16BCE03D3CF1@desy.de> <437767d036ee95a7ce92d7fa2add82a441eedf78.camel@hammerspace.com>
Subject: Re: [PATCH] nfs4: don't map EACCESS and EPERM to EIO
MIME-Version: 1.0
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256; 
        boundary="----=_Part_427544_212201746.1686317435931"
X-Mailer: Zimbra 9.0.0_GA_4546 (ZimbraWebClient - FF114 (Linux)/9.0.0_GA_4546)
Thread-Topic: nfs4: don't map EACCESS and EPERM to EIO
Thread-Index: AQHZmhiBcPmt9J8+TUWQbzQkXHpsSa+BCOMAgAAkEgCAAAMCALMbuyzv
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

------=_Part_427544_212201746.1686317435931
Date: Fri, 9 Jun 2023 15:30:35 +0200 (CEST)
From: "Mkrtchyan, Tigran" <tigran.mkrtchyan@desy.de>
To: Trond Myklebust <trondmy@hammerspace.com>
Cc: anna@kernel.org, linux-nfs <linux-nfs@vger.kernel.org>
Message-ID: <1144390245.427543.1686317435856.JavaMail.zimbra@desy.de>
In-Reply-To: <437767d036ee95a7ce92d7fa2add82a441eedf78.camel@hammerspace.com>
References: <20230608144933.412664-1-tigran.mkrtchyan@desy.de> <cfde2b7b2a7f24f2652ce0bb82727cb0b810c758.camel@hammerspace.com> <AD6C85BF-50F9-42BB-83E8-16BCE03D3CF1@desy.de> <437767d036ee95a7ce92d7fa2add82a441eedf78.camel@hammerspace.com>
Subject: Re: [PATCH] nfs4: don't map EACCESS and EPERM to EIO
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Mailer: Zimbra 9.0.0_GA_4546 (ZimbraWebClient - FF114 (Linux)/9.0.0_GA_4546)
Thread-Topic: nfs4: don't map EACCESS and EPERM to EIO
Thread-Index: AQHZmhiBcPmt9J8+TUWQbzQkXHpsSa+BCOMAgAAkEgCAAAMCALMbuyzv


Hi Trond,

Obviously, the patch is incorrect. The behavior of the upstream kernel and
RHEL kernels are different.

Sorry for the noise,
  Tigran.


----- Original Message -----
> From: "Trond Myklebust" <trondmy@hammerspace.com>
> To: anna@kernel.org, "Tigran Mkrtchyan" <tigran.mkrtchyan@desy.de>
> Cc: "linux-nfs" <linux-nfs@vger.kernel.org>
> Sent: Thursday, 8 June, 2023 19:53:07
> Subject: Re: [PATCH] nfs4: don't map EACCESS and EPERM to EIO

> On Thu, 2023-06-08 at 19:42 +0200, Tigran Mkrtchyan wrote:
>> Hi Trond,
>>=20
>> I will check and let you know. What we see is EACCESS on layoutget
>> reported as EIO to the applications
>>=20
>=20
> If this is for a write, then that might just be
> nfs_mapping_set_error(). In newer kernels, it tries to avoid sending
> errors that are unexpected for strictly POSIX applications.
>=20
> Cheers
>  Trond
>=20
>> Best regards,
>> Tigran
>>=20
>>=20
>> On June 8, 2023 5:33:16 PM GMT+02:00, Trond Myklebust
>> <trondmy@hammerspace.com> wrote:
>> > Hi Tigran,
>> >=20
>> > On Thu, 2023-06-08 at 16:49 +0200, Tigran Mkrtchyan wrote:
>> > > the nfs4_map_errors function converts NFS specific errors to
>> > > userland
>> > > errors. However, it ignores NFS4ERR_PERM and EPERM, which then
>> > > get
>> > > mapped to EIO.
>> > >=20
>> > > Signed-off-by: Tigran Mkrtchyan
>> > > <tigran.mkrtchyan@desy.de>=C2=A0fs/nfs/nfs4proc.c | 2 ++
>> > > =C2=A01 file changed, 2 insertions(+)
>> > >=20
>> > > diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
>> > > index d3665390c4cb..795205fe4f30 100644
>> > > --- a/fs/nfs/nfs4proc.c
>> > > +++ b/fs/nfs/nfs4proc.c
>> > > @@ -171,12 +171,14 @@ static int nfs4_map_errors(int err)
>> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0case -NFS4ERR_LAYOUT=
TRYLATER:
>> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0case -NFS4ERR_RECALL=
CONFLICT:
>> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0return -EREMOTEIO;
>> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0case -NFS4ERR_PERM:
>> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0case -NFS4ERR_WRONGS=
EC:
>> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0case -NFS4ERR_WRONG_=
CRED:
>> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0return -EPERM;
>> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0case -NFS4ERR_BADOWN=
ER:
>> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0case -NFS4ERR_BADNAM=
E:
>> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0return -EINVAL;
>> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0case -NFS4ERR_ACCESS:
>> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0case -NFS4ERR_SHARE_=
DENIED:
>> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0return -EACCES;
>> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0case -NFS4ERR_MINOR_=
VERS_MISMATCH:
>> > >=20
>> >=20
>> > Hmm... Aren't both these cases covered by the exception at the top
>> > of
>> > the function?
>> >=20
>> > static int nfs4_map_errors(int err)
>> > {
>> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (err >=3D -1000)
>> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0return err;
>> >=20
>> > As I read it, that should mean that err =3D -NFS4ERR_ACCESS (=3D -13)
>> > and
>> > err =3D -NFS4ERR_PERM (=3D -1) will get returned verbatim.
>> >=20
>> > Are you seeing these NFS4ERR_ACCESS and NFS4ERR_PERM cases hitting
>> > the
>> > default: dprintk() when you turn it on?
>> >=20
>=20
> --
> Trond Myklebust
> CTO, Hammerspace Inc
> 1900 S Norfolk St, Suite 350 - #45
> San Mateo, CA 94403
>=20
> www.hammerspace.com

------=_Part_427544_212201746.1686317435931
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
NjA5MTMzMDM1WjAtBgkqhkiG9w0BCTQxIDAeMA0GCWCGSAFlAwQCAQUAoQ0GCSqGSIb3DQEBCwUA
MC8GCSqGSIb3DQEJBDEiBCD8YfV1uRYcSIlp71Uoh0JUR7rCImqxge9GYF05q1Ch7jA0BgkqhkiG
9w0BCQ8xJzAlMAoGCCqGSIb3DQMHMA4GCCqGSIb3DQMCAgIAgDAHBgUrDgMCBzANBgkqhkiG9w0B
AQsFAASCAQAqVgBwgqmVgNFLtqDPx2pE+of/mBN1NdR3oshaIiPced3ZYQfCbEk/Sn9VfpIyLeKn
JAkPHHXQzeJ83j+3SMXx/usXMGO/FerTkVz8Rinqo8kMvDbXlGODH7qgOH4oxz3xUwiNm6+DkH4u
ghSTvAJo9ycQgZZSUuNyC6TQK2N5tdUxnt4XF5TlBVVSQ6TCN4kPfafw23FE8804RvAhJJBVDXqS
mEsSL4AUquktF/Dbl3N4ZD0yrAZQKUmAetNuZYO+rAB3kJcUSaddj73NM2oumpx/vQywGTyVzRFO
AWMtskg2hufGYvTHJN8w5DlN1gDFwKr1wtPSUFGluiBgo/ouAAAAAAAA
------=_Part_427544_212201746.1686317435931--

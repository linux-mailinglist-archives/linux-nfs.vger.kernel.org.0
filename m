Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A1BD56656A
	for <lists+linux-nfs@lfdr.de>; Tue,  5 Jul 2022 10:50:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229849AbiGEIuY (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 5 Jul 2022 04:50:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229512AbiGEIuW (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 5 Jul 2022 04:50:22 -0400
Received: from smtp-o-1.desy.de (smtp-o-1.desy.de [131.169.56.154])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 664EADEA
        for <linux-nfs@vger.kernel.org>; Tue,  5 Jul 2022 01:50:20 -0700 (PDT)
Received: from smtp-buf-1.desy.de (smtp-buf-1.desy.de [IPv6:2001:638:700:1038::1:a4])
        by smtp-o-1.desy.de (Postfix) with ESMTP id F0EDCE0BC9
        for <linux-nfs@vger.kernel.org>; Tue,  5 Jul 2022 10:50:16 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp-o-1.desy.de F0EDCE0BC9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=desy.de; s=default;
        t=1657011017; bh=j8cO6kDsfnhDtiXnTVrxmJYmapfvEnNQpXyBMmZpc/I=;
        h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
        b=thvmrR+USVTxv62YimiHOq94RYb5+Ikw3lIjF7Fp9R8aezWdfMsS5rbLuJwKXytWp
         w6vF+wFgSoM6MaTdnmNEBd6s81+FnAEMUZXOnQkXNbPsI+9GhmnMSsZeo5ZG3Q0dGR
         9ml2R0RvzcEf+HfaIZWI7qjDQiWnvezIdP3HnvvA=
Received: from smtp-m-1.desy.de (smtp-m-1.desy.de [IPv6:2001:638:700:1038::1:81])
        by smtp-buf-1.desy.de (Postfix) with ESMTP id E724A1201D4;
        Tue,  5 Jul 2022 10:50:16 +0200 (CEST)
Received: from z-mbx-2.desy.de (z-mbx-2.desy.de [131.169.55.140])
        by smtp-intra-1.desy.de (Postfix) with ESMTP id D4D97C0177;
        Tue,  5 Jul 2022 10:50:16 +0200 (CEST)
Date:   Tue, 5 Jul 2022 10:50:16 +0200 (CEST)
From:   "Mkrtchyan, Tigran" <tigran.mkrtchyan@desy.de>
To:     Daire Byrne <daire@dneg.com>
Cc:     Trond Myklebust <trondmy@hammerspace.com>,
        linux-nfs <linux-nfs@vger.kernel.org>
Message-ID: <1803700180.2293937.1657011016730.JavaMail.zimbra@desy.de>
In-Reply-To: <CAPt2mGO3HsM6ixecvNioZ=jNCNBZ-DuPWmq+LzEnzJdR3McC9A@mail.gmail.com>
References: <737440541.1127428.1656698294694.JavaMail.zimbra@desy.de> <05f3b4e144ec5d12ab87d861222128181e805321.camel@hammerspace.com> <CAPt2mGO3HsM6ixecvNioZ=jNCNBZ-DuPWmq+LzEnzJdR3McC9A@mail.gmail.com>
Subject: Re: Per user rate limiter
MIME-Version: 1.0
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256; 
        boundary="----=_Part_2293939_478677305.1657011016828"
X-Mailer: Zimbra 8.8.15_GA_4308 (ZimbraWebClient - FF101 (Linux)/8.8.15_GA_4303)
Thread-Topic: Per user rate limiter
Thread-Index: Da1j1ULLgi8z5yAMwTEsD/3pCvsq9Q==
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HK_RANDOM_ENVFROM,
        HK_RANDOM_FROM,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

------=_Part_2293939_478677305.1657011016828
Date: Tue, 5 Jul 2022 10:50:16 +0200 (CEST)
From: "Mkrtchyan, Tigran" <tigran.mkrtchyan@desy.de>
To: Daire Byrne <daire@dneg.com>
Cc: Trond Myklebust <trondmy@hammerspace.com>, 
	linux-nfs <linux-nfs@vger.kernel.org>
Message-ID: <1803700180.2293937.1657011016730.JavaMail.zimbra@desy.de>
In-Reply-To: <CAPt2mGO3HsM6ixecvNioZ=jNCNBZ-DuPWmq+LzEnzJdR3McC9A@mail.gmail.com>
References: <737440541.1127428.1656698294694.JavaMail.zimbra@desy.de> <05f3b4e144ec5d12ab87d861222128181e805321.camel@hammerspace.com> <CAPt2mGO3HsM6ixecvNioZ=jNCNBZ-DuPWmq+LzEnzJdR3McC9A@mail.gmail.com>
Subject: Re: Per user rate limiter
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Mailer: Zimbra 8.8.15_GA_4308 (ZimbraWebClient - FF101 (Linux)/8.8.15_GA_4303)
Thread-Topic: Per user rate limiter
Thread-Index: Da1j1ULLgi8z5yAMwTEsD/3pCvsq9Q==

Hi Daire, hi Trond,

We will try to apply your suggestions.

Thanks for the help,
  Tigran.

----- Original Message -----
> From: "Daire Byrne" <daire@dneg.com>
> To: "Trond Myklebust" <trondmy@hammerspace.com>
> Cc: "Tigran Mkrtchyan" <tigran.mkrtchyan@desy.de>, "linux-nfs" <linux-nfs@vger.kernel.org>
> Sent: Friday, 1 July, 2022 23:51:51
> Subject: Re: Per user rate limiter

> On Fri, 1 Jul 2022 at 19:23, Trond Myklebust <trondmy@hammerspace.com> wrote:
>> 2) Define QoS policies for the connections using the kernel Traffic
> 
> If it helps, we use HTB qdisc/classes on our Linux NFS servers to
> optionally limit the total egress and ingress (ifb) bandwidth to/from
> our renderfarm.
> 
> User workstations are exempt from these limits so always get full speed.
> 
> We can do this fairly easily because our network is well defined and
> split into subnet ranges so filtering by these allows us to
> differentiate between host classes (farm/workstations etc).
> 
> Strictly speaking, it's a bit more complicated in that we only apply
> limits and change them dynamically based on the "load" of the server
> and how well it is keeping up with demand. This is just a bash script
> running in a loop looking at the state, scaling the HTB limits and
> applying filters.
> 
> Our goal is to always ensure that taff have a good experience on their
> interactive desktops and we'll happily slow batch farm jobs to keep it
> that way.
> 
> It is basically a low-pass filter that limits server load spikes.
> 
> To do something similar by user or process, you could run your jobs in
> a cgroup and have it mark the packets that the server could then use
> to filter. But I think this only works for the client writes to the
> server as you have no way to mark and act on the egress packets out of
> the server?
> 
> Daire

------=_Part_2293939_478677305.1657011016828
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
NzA1MDg1MDE2WjAtBgkqhkiG9w0BCTQxIDAeMA0GCWCGSAFlAwQCAQUAoQ0GCSqGSIb3DQEBCwUA
MC8GCSqGSIb3DQEJBDEiBCBtdCCKwFRHxK+BoDZfWCnT3JqlWzENQMiYA63d5CMcSTA0BgkqhkiG
9w0BCQ8xJzAlMAoGCCqGSIb3DQMHMA4GCCqGSIb3DQMCAgIAgDAHBgUrDgMCBzANBgkqhkiG9w0B
AQsFAASCAQBpmG+zgvzIQ7EdyPPQe1z506rWuE4crqn69TH+COQQiuNnxSDI9kE9ytdIvOv5rKAG
klLZLRHUzMQrK+V/2q2/qQjOJ+VPvbg1BNfE0IklOPtNyn4gUYCfNcyzVt2sAQc1Px8YeyTeFMt+
xzQjcLAak+6ABlppwG+dLWQAIpexptk8nNkjIEGWHIIw4moC4VuIgYPq0p1Hb3SCJdYKEnbM2Atx
dwDPGx+FZWG693T7kyWscHPMrOEZRl71yfR0oN8nYZQnBNhAgJfXftlgyLC9RzzjC/nhShxNomzo
IsdIxuplX83EZp3yWXa8BynDNdpg5Ew+X1EKSW54RikXnQCWAAAAAAAA
------=_Part_2293939_478677305.1657011016828--

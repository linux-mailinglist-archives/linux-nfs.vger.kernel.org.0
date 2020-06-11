Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E84781F70A8
	for <lists+linux-nfs@lfdr.de>; Fri, 12 Jun 2020 01:00:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726327AbgFKXAq (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 11 Jun 2020 19:00:46 -0400
Received: from mail-eopbgr660074.outbound.protection.outlook.com ([40.107.66.74]:25088
        "EHLO CAN01-QB1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726251AbgFKXAp (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Thu, 11 Jun 2020 19:00:45 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NPmoNhCf8u+iSKSjnOMNh8seht0dkpPfYqVCWRsOGFAWp9z0quES06dyzC7CCCrsBct3LhLkPgxyAohjtN+i5ha01QVzRpHu2yWaLmpCm1AtdvlsFk2VnqJ8jZhZRARDov2+gjT5q5/NEwaySma0ovyNcOrsPZTm4ZZbqCqIJAxRSMq2OadKyKvHKIDCQkEXL7xickpWeRAjZZrG5bAEel1ubn60WLxlBa6YO6FGVLSN2svad1TPyD6zalKdJYhdzFdXDqZe+970+G3a5RS1jXs65KRL8D+UsgyjNVAy9aGepynJ0eUeTmnn1fppRiiqQ/dPe66BnIm128+cu/6ulw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KefBbcE9gnKvgDLLzJnxs3oOi5o7dBELkYg5anW9/ww=;
 b=oFhRf55E3tTBs8aHsdCLSZxysamqVNfSsUY4tz5gKVBsYHbbyIdH8DhyupTDEBsmVI4hZCo9PQUfh12dSUo/0owcPUQNSLuowucXEkB0xxPw27gYs9NiGH22jRvCLsuyD0oHDr6hajX8JuJe2Nrl/37XpGKQS77KFqEk5SD+uQ3tq7ALt/RFVXsCg2igEMIMXy/uHHlDcLSG41t9z6YgYLB/e2itopJ9BBHOM0VnR1necVz6RJuJUOfqxuSDY0QYwoA1k51VDuxHhl5yIE6euiQMwsSmpxcI93jepmP/NESdRmkQubCQ/Ao/BiePQhn8+5zR9HidGKV+lcDfUKlmcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=uoguelph.ca; dmarc=pass action=none header.from=uoguelph.ca;
 dkim=pass header.d=uoguelph.ca; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uoguelph.ca;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KefBbcE9gnKvgDLLzJnxs3oOi5o7dBELkYg5anW9/ww=;
 b=P61/RleQRUDOrpMu3bUZZRrNhFJ4mYZbYtrpw+QWqBsN9l/eWTQ3BFPJGdJzXYhvnv4oWDpnMOsONTZ90prFww+yaEvgn0wQffx3n2DPVJneJN2FXbC6vRO3jNzCgxJQLyKpGPiz929Ci7290Djp8+yxA1tCoQJOTuSwne+l34Pkgt90Vvtw/8EEEDDYf4uQGO2y586ckvpBtW3dFxhhpc92jmvwqI4BUpAFUUgZudi7GsiYe06LHKHOd/j368gvTh9Uv/mm3EuiWyWGXf5lvbO4ed86IZb26G8sFFxywEC9Yx4V5/kaXslbPuSCkTfHPSmhQ1Dj0/zeKjCF+O4BSg==
Received: from QB1PR01MB3364.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:c00:38::14)
 by QB1PR01MB3619.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:c00:3f::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3088.21; Thu, 11 Jun
 2020 23:00:42 +0000
Received: from QB1PR01MB3364.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::60f3:4ca2:8a4a:1e91]) by QB1PR01MB3364.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::60f3:4ca2:8a4a:1e91%7]) with mapi id 15.20.3088.021; Thu, 11 Jun 2020
 23:00:42 +0000
From:   Rick Macklem <rmacklem@uoguelph.ca>
To:     "J. Bruce Fields" <bfields@fieldses.org>,
        "Schumaker, Anna" <Anna.Schumaker@netapp.com>
CC:     "olga.kornievskaia@gmail.com" <olga.kornievskaia@gmail.com>,
        "trondmy@hammerspace.com" <trondmy@hammerspace.com>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "steved@redhat.com" <steved@redhat.com>
Subject: Re: [PATCH 1/1] NFSv4.0 allow nconnect for v4.0
Thread-Topic: [PATCH 1/1] NFSv4.0 allow nconnect for v4.0
Thread-Index: AQHWQCye07Z/EMkfKU+tN6sJacNgAKjUBGjH
Date:   Thu, 11 Jun 2020 23:00:42 +0000
Message-ID: <QB1PR01MB3364AD78CCC13240528BC96CDD800@QB1PR01MB3364.CANPRD01.PROD.OUTLOOK.COM>
References: <20200116190857.26026-1-olga.kornievskaia@gmail.com>
 <1f3297c1549ad12d47497cd18d2c0d9bc7bc5fe7.camel@netapp.com>
 <803ff52e7e4fd7c2b2965368f8cd203b0da28f49.camel@hammerspace.com>
 <14cad1ec0a9080ce2ac064ff9a7ae76464e09aee.camel@netapp.com>,<20200611200919.GF16376@fieldses.org>
In-Reply-To: <20200611200919.GF16376@fieldses.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: fieldses.org; dkim=none (message not signed)
 header.d=none;fieldses.org; dmarc=none action=none header.from=uoguelph.ca;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b80fd153-109b-4ab7-a61e-08d80e5b4450
x-ms-traffictypediagnostic: QB1PR01MB3619:
x-microsoft-antispam-prvs: <QB1PR01MB3619B16F3AB2E81296407EE3DD800@QB1PR01MB3619.CANPRD01.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 0431F981D8
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 65wq3wQevj/tEPS4HgAaM/W0oUd0ZWGK3wX5r+0cXNYt6AXP8WEHKwLGLkMVU3rqiMUw2y6QrXRS6w9aNtn3yb+AogCcO52J3ataCBNOJtU+VS3zW1uNJUVrnDCpu5XNhd/cAHNct52Vu0FYPKPaaA+QL4FHA94sKCW+NZftqctEK3H0E8HqmK6rw9XqBfryK0TItugRQjy7TXSbk4UPwATDo8DX8/TkHBP5RK8XFE4OPK0F3SFBLKK0WhK0G1fZgTEvAzvi8C0bKqLfq1MliJP68MABvvjD+88On7/TBQFPBwcxwXW80bMYRK+Cg4Dj0sHMz7XzeJ/Zp2VyjxsTtw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:QB1PR01MB3364.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFTY:;SFS:(39860400002)(136003)(366004)(346002)(396003)(376002)(110136005)(86362001)(7696005)(8936002)(54906003)(786003)(83380400001)(33656002)(316002)(4326008)(55016002)(9686003)(66946007)(66476007)(52536014)(64756008)(76116006)(478600001)(66446008)(186003)(91956017)(5660300002)(8676002)(6506007)(66556008)(2906002)(71200400001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: dBWJEGQI1++ZY8DV9TX4Det5lIEH7MOh8FhyYjPfkTliyIzgx9yKoZMpEWt95tTz+QRs3T0gK6U72w5mhE3yRiEtaLMeMQT18SuMlIVk9Y/8qA4boXPShEoBdy3lEsqS92n+opil/xgZpzZFIAcFEeKZKRRLufcjDCoEHp3KZzCxqzD3gtQy708WMFa9FXdrwTtE6i2yxOq6u7+M1kuel6CGg53Hasky8UnWmdJjCnL9kmPbfh5CqNnClZxbGSY3nBbBToep3IneYxOw2LvmnCv1+9tNdDIUOTsvyuNRK9x3XSVPKsBcFbJsOJuosOEiyXvJPbb2JCVnQv9MVqOrts9BNvbGEkYlq2wjk7UfZhe+ucy/hqYarCNa04vxjr9LfWg0ImrLyTEAWEv6aqqEvMFe513VeCIvfSPlkojDq9KruAvyqyENonk/gBazCnVD1ubtBK06uj/wn0B+92PKFrS4906E1qQOuHdyQoI2Z+VMvZOD6cgMelztE1gdD+U+d9y8Tqz5iVj7kXmAmu/tMVo5vsL3JSH7VsN6Jim9B6oNWoQsf/vGek68EZ+04ErE
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: uoguelph.ca
X-MS-Exchange-CrossTenant-Network-Message-Id: b80fd153-109b-4ab7-a61e-08d80e5b4450
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Jun 2020 23:00:42.2684
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: be62a12b-2cad-49a1-a5fa-85f4f3156a7d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bZmxFGFDqHLnoWJwukTg5mQUVSQrruGfHFIXUHAe65sVoyOS6epuMJ1aKMWsGD0+2puIiQ5wRYVgVc4+IXHsAA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: QB1PR01MB3619
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

J. Bruce Fields wrote:=0A=
>On Fri, Jan 17, 2020 at 09:16:54PM +0000, Schumaker, Anna wrote:=0A=
>> On Fri, 2020-01-17 at 21:14 +0000, Trond Myklebust wrote:=0A=
>> > On Fri, 2020-01-17 at 21:09 +0000, Schumaker, Anna wrote:=0A=
>> > > Hi Olga,=0A=
>> > >=0A=
>> > > On Thu, 2020-01-16 at 14:08 -0500, Olga Kornievskaia wrote:=0A=
>> > > > From: Olga Kornievskaia <kolga@netapp.com>=0A=
>> > >=0A=
>> > > Have you done any testing with nconnect and the v4.0 replay caches? =
I=0A=
>> > > did some=0A=
>> > > digging on the mailing list and found this in one of the cover=0A=
>> > > letters from=0A=
>> > > Trond: "The feature is only enabled for NFSv4.1 and NFSv4.2 for now;=
=0A=
>> > > I don't=0A=
>> > > feel comfortable subjecting NFSv3/v4 replay caches to this treatment=
=0A=
>> > > yet."=0A=
>> > >=0A=
>> >=0A=
>> > That comment should be considered obsolete. The current code works har=
d=0A=
>> > to ensure that we replay using the same connection (or at least the=0A=
>> > same source/dest IP+ports) so that NFSv3/v4.0 DRCs work as expected.=
=0A=
>> > For that reason we've had NFSv3 support since the feature was merged.=
=0A=
>> > The NFSv4.0 support was just forgotten.=0A=
>>=0A=
>> Thanks for the explanation! I'll add the patch.=0A=
Maybe I am misinterpreting this discussion and, if so, please just ignore t=
hese=0A=
comments.=0A=
Here are two snippets from RFC7530:=0A=
In Sec. 3.1.=0A=
   Where an NFSv4 implementation supports operation over the IP network=0A=
   protocol, the supported transport layer between NFS and IP MUST be an=0A=
   IETF standardized transport protocol that is specified to avoid=0A=
   network congestion; such transports include TCP and the Stream=0A=
   Control Transmission Protocol (SCTP).  To enhance the possibilities=0A=
   for interoperability, an NFSv4 implementation MUST support operation=0A=
   over the TCP transport protocol.=0A=
=0A=
This clearly states that NFSv4.0 cannot operate over UDP. (See the MUST abo=
ve.)=0A=
=0A=
In Sec. 3.1.1.=0A=
   When processing an NFSv4 request received over a reliable transport=0A=
   such as TCP, the NFSv4 server MUST NOT silently drop the request,=0A=
   except if the established transport connection has been broken.=0A=
   Given such a contract between NFSv4 clients and servers, clients MUST=0A=
   NOT retry a request unless one or both of the following are true:=0A=
=0A=
   o  The transport connection has been broken=0A=
=0A=
   o  The procedure being retried is the NULL procedure=0A=
If the TCP connection is broken, making a new TCP connection on the=0A=
same port #s would be risky, unless a long delay is done. Normally a=0A=
different port# would be used and the implication of the above is that=0A=
any retry of an RPC (above the TCP layer retransmits of segments)=0A=
will normally be from a different port#.=0A=
=0A=
Long ago I played around with a DRC for TCP (which ended up in FreeBSD)=0A=
and because retries happen after a long timeout and there can be many=0A=
other RPCs done in between the first attempt for the RPC and a subsequent=
=0A=
retry of the RPC, the design must be very different than a DRC for UDP.=0A=
--> LRU caching doesn't work well unless the cache size is very large.=0A=
--> For NFSv4.0 over TCP (not NFSv3), the DRC must assume (or at least=0A=
      handle) retries from a different client port#, since they will be don=
e on=0A=
      a different TCP connection and that will almost inevitably imply a=0A=
      different port#.=0A=
=0A=
rick=0A=
=0A=
What happened to this patch?  As far as I can tell, the conclusion of=0A=
this thread was that it should be applied.=0A=
=0A=
--b.=0A=
=0A=
>=0A=
> Anna=0A=
>=0A=
> >=0A=
> > > Thanks,=0A=
> > > Anna=0A=
> > >=0A=
> > > > Signed-off-by: Olga Kornievskaia <kolga@netapp.com>=0A=
> > > > ---=0A=
> > > >  fs/nfs/nfs4client.c | 2 +-=0A=
> > > >  1 file changed, 1 insertion(+), 1 deletion(-)=0A=
> > > >=0A=
> > > > diff --git a/fs/nfs/nfs4client.c b/fs/nfs/nfs4client.c=0A=
> > > > index 460d625..4df3fb0 100644=0A=
> > > > --- a/fs/nfs/nfs4client.c=0A=
> > > > +++ b/fs/nfs/nfs4client.c=0A=
> > > > @@ -881,7 +881,7 @@ static int nfs4_set_client(struct nfs_server=0A=
> > > > *server,=0A=
> > > >=0A=
> > > >         if (minorversion =3D=3D 0)=0A=
> > > >                 __set_bit(NFS_CS_REUSEPORT, &cl_init.init_flags);=
=0A=
> > > > -       else if (proto =3D=3D XPRT_TRANSPORT_TCP)=0A=
> > > > +       if (proto =3D=3D XPRT_TRANSPORT_TCP)=0A=
> > > >                 cl_init.nconnect =3D nconnect;=0A=
> > > >=0A=
> > > >         if (server->flags & NFS_MOUNT_NORESVPORT)=0A=
> > --=0A=
> > Trond Myklebust=0A=
> > Linux NFS client maintainer, Hammerspace=0A=
> > trond.myklebust@hammerspace.com=0A=
> >=0A=
> >=0A=
=0A=

Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8456A6967F9
	for <lists+linux-nfs@lfdr.de>; Tue, 14 Feb 2023 16:25:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229538AbjBNPZI (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 14 Feb 2023 10:25:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229551AbjBNPZF (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 14 Feb 2023 10:25:05 -0500
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2113.outbound.protection.outlook.com [40.107.220.113])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 720BC2A175
        for <linux-nfs@vger.kernel.org>; Tue, 14 Feb 2023 07:25:04 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=C1sXS20MjaNs5A2VJNgFZypZe2mUzp3hf1CYG2XZwv90ZUG/NV5V3WOFz3ysqh4ld2Kwl598Wzz+WYpsMglLUmnnV7Lf5808z1Xe1ccOmIoc2im00l6cth+wMm0Zb7xBRehDO/Qih+CsmLCQ0JrhQAq8XWrXX4jWexc37JDKvQk8PGvxgy/laTKmmsSjlOunpPijbNSowFjs6AsdvTr5VzqmE/HzoJr0nD4ZB38UkTXXgIA767aSi46m9N0PruCQor6VYT6erfDjKh7XXc57prbNElRrwRpdB7gewa9FkYMqUHaDXACRQENthKcvEVUloxvonbeEKJm4CErFcLOBIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nUhUyXqcHUcH+HCsI+Dm6EjnLxAO6zM1TH9ahMbbT40=;
 b=Y2CnTToyxktgsy5+90NWkpM46BYkU6DIw3GKNETNkh3+GS9krD8e/RtVk+vTt9VVXRCkdmB2HZxEeY695NakNkOmFNZICmxM73lWVDQN01j58FgnGITzKtGjlov2tFnwPSFPF+o7nVByVW5cRrvlADeDXr3tj36KFxZh/8iirW8KJksuBtU5WGRMK7AC6pBDwcAaHoPTcr8N403etIMnkJN8LU12m0RRo9/gVzCczzp2jeaIeEpB+bp+fRRabqX/RKvK+D87N7XGmrhjHoR2py3MJhV69JtL6mmZwrUmivNzSFVKAmd97nletj9Ik0lR0LiSC2dlC15p0t84waYNCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=rutgers.edu; dmarc=pass action=none header.from=rutgers.edu;
 dkim=pass header.d=rutgers.edu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rutgers.edu;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nUhUyXqcHUcH+HCsI+Dm6EjnLxAO6zM1TH9ahMbbT40=;
 b=DMwQFn1AxYqtl8gxnR/GWcYfWVjTHryiPe3dKrBaXhXYluJ/EIKEmpPfWSE5XfYhQWMud7DaM4DHWVWcvAyHLthUb0CVVliQtOE9JeD4DUNSwhsV70oUZ0aMUjUOWLlWgaijrWUIsn6Kvl6T7Dz9JX63ExLNSM0MPsFec3Sd+Gs=
Received: from PH0PR14MB5493.namprd14.prod.outlook.com (2603:10b6:510:12a::11)
 by IA0PR14MB6864.namprd14.prod.outlook.com (2603:10b6:208:3dc::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.17; Tue, 14 Feb
 2023 15:25:02 +0000
Received: from PH0PR14MB5493.namprd14.prod.outlook.com
 ([fe80::b695:d955:65:f188]) by PH0PR14MB5493.namprd14.prod.outlook.com
 ([fe80::b695:d955:65:f188%7]) with mapi id 15.20.6086.019; Tue, 14 Feb 2023
 15:25:02 +0000
From:   Charles Hedrick <hedrick@rutgers.edu>
To:     Olga Kornievskaia <aglo@umich.edu>
CC:     Wang Yugui <wangyugui@e16-tech.com>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
Subject: Re: question about the performance impact of sec=krb5
Thread-Topic: question about the performance impact of sec=krb5
Thread-Index: AQHZPqeK1vTr9ZprgkOSoO1Rn1K+967NKnj9gAARMgCAAU8bAIAABnSb
Date:   Tue, 14 Feb 2023 15:25:01 +0000
Message-ID: <PH0PR14MB5493B65AF559662D81EA3A51AAA29@PH0PR14MB5493.namprd14.prod.outlook.com>
References: <20230212140148.4F0D.409509F4@e16-tech.com>
 <PH0PR14MB5493A75DC8E617230D426F09AADD9@PH0PR14MB5493.namprd14.prod.outlook.com>
 <CAN-5tyH45zKa+xcvwMoUzWPewUkwNZpJycNN+ZdHeea8Uj6tFQ@mail.gmail.com>
 <CAN-5tyGa6hpJcBkPDocuVPbPEP32Jg5AgR=Z6DbMc7kg_oKsLg@mail.gmail.com>
In-Reply-To: <CAN-5tyGa6hpJcBkPDocuVPbPEP32Jg5AgR=Z6DbMc7kg_oKsLg@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=rutgers.edu;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR14MB5493:EE_|IA0PR14MB6864:EE_
x-ms-office365-filtering-correlation-id: e8660eff-327e-4928-21cb-08db0e9fa42c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: PheHClcmGBRc/PSTKnIwPSTyofJhMDdY0F5ANCP3Y/iGHZF2Ic8w2Nm1LV6pKLB/D608gUQP66EiveS7iK3cgCw2sQSs+YMUvlYfGtYRi6NVAmqFOblgS0oRUAHLiE+Nid3Uhs1GaZmrXrjvvZmzCdKRmySrxIAAteykI7/+uOoPM/evW3OFbT7sjXjkMi+qBxycKTdc2XTlZYzW753BtNydGZrrTGl90fyeNsbQgCrAAX+GlDuqyFDTDHHc4g7jM23Ld8hpMn6z6WqG9C7/e/Q+ooCwkH7nLbI7E4x0Z5NgM/XY0tIr6kpTislLhfEkAMAXIuRkItMSgAr+gBwlISDiNLUM4h9LUog1Xm3zgkdVAFN0YNzOKUagVqP+fQUaSICiKhB5A7j8RSiT/so+pPysQO/V+pPLb6VmCFnqgYzJBkaUtPYfmbkVvFOwtgdzVYQEZViQx1z4MQ5+mQvkmDA0NMLMiqGy5fP5/wBkfjEydLjHjCWXeCJTDGqNYA1t2zivO7WsL7aXXczrdgSXetJXBFcVsygs11IxXw1JtO6pruDDRH/J/o/JGpL8HqztY7KfXodmxautM6oBGVlUgtiv/I0mWXraHbp1h1PkVo1sTZX/Elq4qrCYdBK+fIb1K4uOSkW1BZQCh6RZHGotLsOrKaEHA2274nnFIGf2ZnqzmfEerxGKoiv/K2fDkNIL
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR14MB5493.namprd14.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(39860400002)(346002)(366004)(376002)(136003)(396003)(451199018)(91956017)(83380400001)(5660300002)(66476007)(64756008)(52536014)(66556008)(41320700001)(38100700002)(8676002)(2906002)(86362001)(8936002)(41300700001)(122000001)(4326008)(33656002)(6916009)(54906003)(76116006)(66946007)(66446008)(316002)(75432002)(478600001)(6506007)(38070700005)(966005)(9686003)(53546011)(786003)(55016003)(186003)(71200400001)(7696005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?W8x5BbJbLYz4G2IRNj6RN4vR5mPunVYckMiyHdBxS4xB1kUbFm71ocfncT?=
 =?iso-8859-1?Q?7b6bjPR6votk5v/7LheJDVT99Wmj4ucbzWmPVemdZ7x91pX0HgchUxKL0j?=
 =?iso-8859-1?Q?EBEVf3t/ENhgFJf5Q6z/wbIsxzLRvFFSBNJPGXGVg2wRvdmGixHDkO/+l0?=
 =?iso-8859-1?Q?z8gMrTV1LTZgeozUZEajGU13aRJxRoHEYQqM1vnHbiM3gJJv4syChxlHwV?=
 =?iso-8859-1?Q?foVtKJwC7wVBGgE5T0BTabwC6rjnfhY/Yn+IxHByf2C/q42L0Vlibauq40?=
 =?iso-8859-1?Q?Kilu1dpPkuN0IvTgGrOILL4n6UBIkOFcRAcUjhb93GlJgRcY29gESxUIp6?=
 =?iso-8859-1?Q?Jjb8KPRDXj3BHJ05xK9oLx8gNs6UBbe0wZPZdf9un8pKHZjhVBUGObgKcO?=
 =?iso-8859-1?Q?bxtVFV725pyyUpDPfkS+wExpObP2P9+QexcQ1sQ2acZQ5JXZroGwKBkbcR?=
 =?iso-8859-1?Q?IjXXwJyKgvHuWd/+Pqb8Pmk7wrZrfFZnmQAfY7CZzoWPOOtof5VgVp4D21?=
 =?iso-8859-1?Q?XybacmFgi8Dd9PJ4pRa0KSFC6VFTsHAE5dWxQeh3i8u3FrKhmNtjF0/rWd?=
 =?iso-8859-1?Q?/SZChfrhXrAHak/yFGRIeGaN5qLMvgvif/fzF0sAkTSBeu5VtimYmo/FSh?=
 =?iso-8859-1?Q?OSinjWxcCeEJpVKi2WA3JCmMfv6w5t0oD/+4fqzw9Umd8DAFj5zMAMFJpE?=
 =?iso-8859-1?Q?1lVru/bFdMEyDS4kR/VX912xYP/clAKuMpHHzmx3SwjxXDjy1sAMEYi/Uf?=
 =?iso-8859-1?Q?TbMHUb6DgI8h1B9F4f0KDQ02mE4elTw5Jn9mZhpv7LcE59j9F08oKZ4OTw?=
 =?iso-8859-1?Q?cvEqvQ0VQaYL4jFlnsD4/Am82Xx3Pnb3QGsVUYQQZhxBlTWs8wSdnZQXf2?=
 =?iso-8859-1?Q?XAfzddLwveJNXuft3IHNOTcZJDOg+vm8GxzcouKUXI3O9c3EqiThZg6bUw?=
 =?iso-8859-1?Q?zyIQ21FhhqvI+EkVOubLZB1rhtA3xB1mDXGiOAK/zbAMVNvvzzjkTyIpm4?=
 =?iso-8859-1?Q?1sI38e76NU9yP37WZAXXc0y+Ti3wMs5um93bwkwfkvAXV3ysuY+kFW6648?=
 =?iso-8859-1?Q?I+tvKSHjAU/H/u3VmL60BuM2HeXmCs8+FqnnOhIsMq5T0UWf6vgt1ouJjt?=
 =?iso-8859-1?Q?r8WHFQpLpykE/D2q00xVubzBy7aAFAcEmEz0PXmJJE+eG7MBWxRFyhWTue?=
 =?iso-8859-1?Q?+p3BwPk2SRiglDw5Qzksr9GCUmr98E0maTRv4Ib2GzsOYF6hAXP+XwSV+o?=
 =?iso-8859-1?Q?cbAMkV0rYp8nq/+KgUBm8V3zF3iYei0xRBbwIwyRm+48fRlPxOg2XdWtDA?=
 =?iso-8859-1?Q?0YiojNeP1isAXy9o5htsxbGu8gde9jBDasJSXZtlu2zcaD/kZMfJGhKDAU?=
 =?iso-8859-1?Q?F3+S5rOkkG0qC8+7PmfEYMhRGt+Yhj5qBCz1ZpvjnndAMKRt6TOlAJ1no9?=
 =?iso-8859-1?Q?aniY+Jg2W0t27XTZ0ntd62cjqhtHdbvcWkQtv4QwZ89Yh2SQE1SYpjE1og?=
 =?iso-8859-1?Q?skgANYseogBgEKJg11nV/qrtmBMbh6vnMFx/uRr4ZNb1luSt4bEhZUAR03?=
 =?iso-8859-1?Q?V5DLII+rzeLPAEltGz6sH3HaR+2PpReA7xYmBjsVhinGo7TJGTFvO9xN13?=
 =?iso-8859-1?Q?IqFhsOVvn5icbqh3F574/6gjOcpy5WMKe88LAgGzcUocWdhX66xBLHgg?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: rutgers.edu
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR14MB5493.namprd14.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e8660eff-327e-4928-21cb-08db0e9fa42c
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Feb 2023 15:25:01.9533
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b92d2b23-4d35-4470-93ff-69aca6632ffe
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: r6+66RG8LtLP5/IJxwdEyqn1lx7j1O+Rrrfj5SYebRh65sDtqmQPdYx7rMO7J54f/DwYfFM/cZERxsy3veF3zQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR14MB6864
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

That's better, but that still leaves 53% reduction in performance. We don't=
 see that, and it's hard to understand where it would come from. 0.2 msec s=
till looks big. Our total RTT for a read is a bit over 0.3 msec, for data t=
hat comes from cache, which is 95% of it. We're using a generic Dell server=
 with Ubuntu 22.04, i.e. kernel 5.15. =0A=
=0A=
I do see a big slowdown from krb5p, but that's not so surprising.=0A=
=0A=
krb5p: 3:25=0A=
krb5: 1:38=0A=
sys: 1:29=0A=
=0A=
I guess it's possible that their server is so much more efficient that the =
sec=3Dsys performance is a lot faster, and so the difference is greater.=0A=
=0A=
From: Olga Kornievskaia <aglo@umich.edu>=0A=
Sent: Tuesday, February 14, 2023 9:53 AM=0A=
To: Charles Hedrick <hedrick@rutgers.edu>=0A=
Cc: Wang Yugui <wangyugui@e16-tech.com>; linux-nfs@vger.kernel.org <linux-n=
fs@vger.kernel.org>=0A=
Subject: Re: question about the performance impact of sec=3Dkrb5 =0A=
=A0=0A=
On Mon, Feb 13, 2023 at 1:53 PM Olga Kornievskaia <aglo@umich.edu> wrote:=
=0A=
>=0A=
> On Mon, Feb 13, 2023 at 1:02 PM Charles Hedrick <hedrick@rutgers.edu> wro=
te:=0A=
> >=0A=
> > those numbers seem implausible.=0A=
> >=0A=
> > I just tried my standard quick NFS test on the same file system with se=
c=3Dsys and sec=3Dkrb5. It untar's a file with 80,000 files in it, of a siz=
e typical for our users.=0A=
> >=0A=
> > krb5: 1:38=0A=
> > sys: 1:29=0A=
> >=0A=
> > I did the test only once. Since the server is in use, it should really =
be tried multiple times.=0A=
> >=0A=
> > krb5i and krb5p have to work on all the contents. I haven't looked at t=
he protocol details, but krb5 with no suffix should only have to work on he=
aders. 3.2 msec increase in latency would be a disaster, which we would cer=
tainly have noticed. (Almost all of our NFS activity uses krb5.)=0A=
> >=0A=
> > It is particularly implausible that latency would increase by 3.2 msec =
for krb5, 0.6 msec for krb5i and 1.6 for krb5p. krb5 encrypts only security=
 info. krb5p encrypts everything.=A0 Perhaps they mean 0.32 msec? We'd even=
 notice that, but at least it would be consistent with krb5i and krb5p.=0A=
>=0A=
> Actually they really did mean 3.2. Here's another reference that=0A=
> produces similar numbers :=0A=
> https://www.netapp.com/media/19384-tr-4616.pdf . Why krb5 perf gets=0A=
> higher latency then the rest is bizarre and should have been looked at=0A=
> before publication.=0A=
=0A=
Nevermind. After some investigation, it turns out the public report=0A=
has a typo, it should have been 0.2ms. Hopefully they'll fix it.=0A=
=0A=
> > From: Wang Yugui <wangyugui@e16-tech.com>=0A=
> > Sent: Sunday, February 12, 2023 1:01 AM=0A=
> > To: linux-nfs@vger.kernel.org <linux-nfs@vger.kernel.org>=0A=
> > Subject: question about the performance impact of sec=3Dkrb5=0A=
> >=0A=
> > Hi,=0A=
> >=0A=
> > question about the performance of sec=3Dkrb5.=0A=
> >=0A=
> > https://learn.microsoft.com/en-us/azure/azure-netapp-files/performance-=
impact-kerberos=0A=
> > Performance impact of krb5:=0A=
> >=A0=A0=A0=A0=A0=A0=A0=A0 Average IOPS decreased by 53%=0A=
> >=A0=A0=A0=A0=A0=A0=A0=A0 Average throughput decreased by 53%=0A=
> >=A0=A0=A0=A0=A0=A0=A0=A0 Average latency increased by 3.2 ms=0A=
> >=0A=
> > and then in 'man 5 nfs'=0A=
> > sec=3Dkrb5=A0 provides cryptographic proof of a user's identity in each=
 RPC request.=0A=
> >=0A=
> > Is there a option of better performance to check krb5 only when mount.n=
fs4,=0A=
> > not when file acess?=0A=
> >=0A=
> > Best Regards=0A=
> > Wang Yugui (wangyugui@e16-tech.com)=0A=
> > 2023/02/12=0A=
> >=

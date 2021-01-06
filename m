Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4491F2EC5E2
	for <lists+linux-nfs@lfdr.de>; Wed,  6 Jan 2021 22:48:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725860AbhAFVrp (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 6 Jan 2021 16:47:45 -0500
Received: from mail-eopbgr670088.outbound.protection.outlook.com ([40.107.67.88]:42044
        "EHLO CAN01-TO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725788AbhAFVro (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Wed, 6 Jan 2021 16:47:44 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lin1y1wBW7RThpIG/rjIRjC+vgS3hkGaGbiSrxpPcXXl7YdxKKH6AdNOHSXH4t4d/Nejzr9t83kh9u0mMI+wYSgdxp5iFoP39/7UtO6ydxPVJ8tKuet1Ae0y5bg1LGiaOpW5EfjGeqOt4VYGtKDGP0g3FkXeUeHxFmzX8BEEx42N4DjzbNNmWQgjZuNmLY1UHVziK2v6bmaJqOksmF6JPupY6YieajxHMiVtohpFr5R8KwNeWSQBzX5oKGCsT5hzgjR2+jeMuUFO46fnrX4aQwMgzrag8LTEXvhMzwHJP8X730O+ccgnLcsoPPyOZPPL7yRBOAdmzPh2vFlrRgkr5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V4UKNgtCS1XOw6ueMRxi7XLZwpEScsWLjzJPGL1S7Z0=;
 b=bei1uBMxUJy8ZNojjmNt0gPcRwnC3ZAkImNy/yWXeg4VBzcHlTNpdWwo0JLko3NRgn/s6/fFP+eF2hTYgEvVYn6dxaKhB9l0UxM8k1xzJIRS167kLAlNe+0Et55jnG+lqfvxXCpUYAaVh6j3d2xpdIL0BXShvur8ZM22Fgz4JahpbnnN8UvdV4QqNGdy7dzIqqZcZN7G8uhrKxXNAYNskBiel2/Rkh8l+cMTbSZcb+0JkWbSi0dwEUNIbIHPlPrQhTkFaLeb5wNrmD3KpTEUCRVyEN6f9iwo6fxTQbujR5rY1geG+ODyG4ifI2tgAGUvIB0v+U9p7vLoudmEI0/+DQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=uoguelph.ca; dmarc=pass action=none header.from=uoguelph.ca;
 dkim=pass header.d=uoguelph.ca; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uoguelph.ca;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V4UKNgtCS1XOw6ueMRxi7XLZwpEScsWLjzJPGL1S7Z0=;
 b=NvddcYxyzrgIchhl/JdEKqdZyuCB4ZPShwOeDhAcOeOt7KhCsZi7e+5y91xfH3tx830BENjgC75pint6nd4xat4FLNJ/qcfoelW+6iNG+9+C9rva66LDOO6m5zbIJZPLlfErJTDJpzUTSOup1Btqb/4I4da2fiYPbvA3N2xNDD8MQV76OatGRKCHv+z36O1q00aKMJ/iGRK/IQyxiFoDKMtyg2uL0Jh0OQQFb3MKIO52y55vvM/VZxbAziIXrkqeuXUArfSN1vuSUom5trL4zV5Md+8JunHVKP+RMJJ1WBv3jr5QWRlQGSynEneQ5CE1Pt/uuePM7KtQ/chE5TUj6A==
Received: from YQXPR0101MB0968.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c00:19::29) by YQXPR01MB3557.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c00:51::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3721.23; Wed, 6 Jan
 2021 21:46:27 +0000
Received: from YQXPR0101MB0968.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::3d86:c7f9:bc4c:40c0]) by YQXPR0101MB0968.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::3d86:c7f9:bc4c:40c0%6]) with mapi id 15.20.3721.024; Wed, 6 Jan 2021
 21:46:27 +0000
From:   Rick Macklem <rmacklem@uoguelph.ca>
To:     Olga Kornievskaia <aglo@umich.edu>,
        Chuck Lever <chuck.lever@oracle.com>
CC:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        NFSv4 <nfsv4@ietf.org>
Subject: Re: [nfsv4] virtual/permanent bakeathon infrastructure
Thread-Topic: [nfsv4] virtual/permanent bakeathon infrastructure
Thread-Index: AQHW4qAQw029x9f8w0a6E7AmBQGnUqoXfYqAgAH7jYCAAau/dw==
Date:   Wed, 6 Jan 2021 21:46:26 +0000
Message-ID: <YQXPR0101MB09680ED6F9B3E42A963F3586DDD00@YQXPR0101MB0968.CANPRD01.PROD.OUTLOOK.COM>
References: <85C06BBD-2861-4CDE-BCED-ACD974560D3A@redhat.com>
 <72FFA566-311D-4826-9F4A-29AE0F379327@oracle.com>,<CAN-5tyHSs+Qu4pY+Vh+KsNrQzzVzziyYLAHxEMQE=eHtmrTgtA@mail.gmail.com>
In-Reply-To: <CAN-5tyHSs+Qu4pY+Vh+KsNrQzzVzziyYLAHxEMQE=eHtmrTgtA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: umich.edu; dkim=none (message not signed)
 header.d=none;umich.edu; dmarc=none action=none header.from=uoguelph.ca;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 30285c74-4252-436e-727c-08d8b28c850a
x-ms-traffictypediagnostic: YQXPR01MB3557:
x-microsoft-antispam-prvs: <YQXPR01MB355740EDD6DD041751546F69DDD00@YQXPR01MB3557.CANPRD01.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: JoNjkkqd+zs7Wcihgl2Z/lxlK3M6e6Va09hpCz6D/1YcEML0RQcrKFJntqq71JJlJ1d2iJnUMNVqGh5u5EnT06z4OPAcihwndPzEitgAXz45cPjoh3JUUtHIpaC300kfHihkzjcDkaCvYt5PHsaYkcJjCvgHqKbrgQyaTzqD+nEtRNCdVEBJwPjJgYRdxr2YOjZG6ZPgh+PHzelJIU7vl4EAtB5tL3S4HfjVblJi9CtlT0+LHsRlENxU1VjW+fA/Il1OU6qflUTgn+ftpwJQ8HpyRJTjdquyzl6OwwtuMIpiR78FoeQWuZ/joj7Vw0MGriHdbVfa+FRFsNOyKhFydRZbNZ8fbVYAikgWQs8PK0m92t4iAgbSKn7qKEqRBmhItqBEj3BorCij7+7IxwqqMLtsfbd+5Stua7P9iVPxEAIdKkrbaNdAnJZE/5uwpOQFqN7eBqC7TXkbR8T0j3ytbQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YQXPR0101MB0968.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(396003)(136003)(376002)(346002)(366004)(39860400002)(186003)(91956017)(6506007)(110136005)(9686003)(66446008)(54906003)(7696005)(8936002)(76116006)(55016002)(66556008)(66946007)(52536014)(5660300002)(66476007)(2906002)(8676002)(786003)(966005)(316002)(4326008)(53546011)(86362001)(83380400001)(478600001)(33656002)(64756008)(71200400001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?zKR7e9jyOJ7u73xeqJUZtSG51Fzx8N08cdZH/yWGuYFMG1KHtyUIBqa9tx2l?=
 =?us-ascii?Q?t+UbZFC6c6kAH3avK1c8t8fq1eWNiAJYPb3peWeMoJDsFWukhuecQAXM9Usr?=
 =?us-ascii?Q?MxRBAOlx/RvUH3Y/pdIBtRQPiTykQT58DS8bHOn65u1zEmNc/sfgg5dMJoJt?=
 =?us-ascii?Q?aNToVJ2Vg/PMItOAOR3W7KBh4kusUKjI4uRM9WLaideLcRPQbzELHS3SKKyq?=
 =?us-ascii?Q?yE7+ahlhYJHHQK88zK7YS67PZmT/ptXARtAfNQcuOBTXH7rGG61bg9XMFUOF?=
 =?us-ascii?Q?pKdHCzYIM2IwkwEQ3p6kvbKVcHQdaXpKWgnvESidpsPsIIqLrz19PoM77xTu?=
 =?us-ascii?Q?GPKTzkc4jDPo+v8Ek4WO0UJiYH1bjS9L0Heb6G1Y6O+mhXvTnInCcq2Gv/Kw?=
 =?us-ascii?Q?zIHgpdIdGo3AT5qsupLq3scNDbo3780QpncR/LFeQxn8MBEFhCki3UQ1rEJi?=
 =?us-ascii?Q?6KFZVRmpRbNH57EqP/mgzuWXXy7yUsyjayF4cpoPYlRLnMC3+gL5bmlNAiAp?=
 =?us-ascii?Q?uDoHXRwvdZWC6flmOcUsit0PCZr/xSFF+/IaE87j72TI2njlrDLKQqQk3pYm?=
 =?us-ascii?Q?5brIyrjUoATgz4weVQ+RcCcwJzm5VylvLodRZ88zSEMGL3oJovuLFhhfHbmk?=
 =?us-ascii?Q?9R5SjGIKZb3uoh+1KqPyVWv0g0PMrQHB9ksEuJ66S5ULIrVRSm+B073S0KRS?=
 =?us-ascii?Q?iZJqF6r0KcETKd48mueLPyn8+fjgUcT7S3mvrpkuSm5f3om4y8I+DO4YD5h9?=
 =?us-ascii?Q?wtrCjpuvh5GkODeRnV+NBTyGLOqc20uDAhgC2eo2cEbglPUZrlGDe8Zq1riG?=
 =?us-ascii?Q?Hopx3bcPfUnl4wQkNpRb80/WHoRKigF1NA8avYKsuRZUcyrIzfzU1jDgfMFW?=
 =?us-ascii?Q?hZNwubxruGw5krigOBiKCv7o/5B3SmWfz1bpnS85vQnC43p80cUNfvYnm1s3?=
 =?us-ascii?Q?guFqR6sSKMdyY8uo50eFwmxWiaPtQ3uescBUiMAgvbZRO63sYmmaUfBR5TDk?=
 =?us-ascii?Q?Qbkfbv5CtWY5n2igYBpVsoQFCWzDiE/a+g1dojUFpfcHnFE=3D?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: uoguelph.ca
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: YQXPR0101MB0968.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 30285c74-4252-436e-727c-08d8b28c850a
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Jan 2021 21:46:26.9585
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: be62a12b-2cad-49a1-a5fa-85f4f3156a7d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: oBOOmqjQv5x1rGnw7mflkMEKenWRZhi1ZYeWyGsMLYyzodAOhZGLvhvUVgDM/kC8AZl2/s8oFZFIf3b44TpOiA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YQXPR01MB3557
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

I do not know if I can solve the logistics of participating,
but I will try to do so.

Last week of Feb. would be good timing for me, since it
would still allow me time to get critical fixes into FreeBSD13.

rick

________________________________________
From: nfsv4 <nfsv4-bounces@ietf.org> on behalf of Olga Kornievskaia <aglo@u=
mich.edu>
Sent: Tuesday, January 5, 2021 3:13 PM
To: Chuck Lever
Cc: Linux NFS Mailing List; NFSv4
Subject: Re: [nfsv4] virtual/permanent bakeathon infrastructure

CAUTION: This email originated from outside of the University of Guelph. Do=
 not click links or open attachments unless you recognize the sender and kn=
ow the content is safe. If in doubt, forward suspicious emails to IThelp@uo=
guelph.ca


On Mon, Jan 4, 2021 at 8:56 AM Chuck Lever <chuck.lever@oracle.com> wrote:
>
>
>
> > On Jan 4, 2021, at 8:46 AM, Benjamin Coddington <bcodding@redhat.com> w=
rote:
> >
> > How are folks feeling about throwing time at a virtual bakeathon?  I ha=
d
> > some ideas about how this might be possible by building out a virtual
> > network of OpenVPN clients, and hacked together some infrastructure to =
make
> > it happen:
> >
> > https://vpn.nfsv4.dev/
>
> My colleague Bill Baker has suggested we aren't going to get the
> rest of the way there until we have an actual event; ie, a moment
> in time where we drop our everyday tasks and focus on testing.
>
> So, I'm all for a virtual event.
>
> We could pick a week, say, the traditional week of Connectathon
> at the end of February.

Netapp is also saying that they will only allocate hardware for
testing for a given period of time and not indefinitely. Thus, having
an agreed upon date would be a good idea (even if it's a flexible
date).

> > That network exists today, and any systems that are able to join it can=
 use
> > it to test.  There are a number of problems/complications:
> >    - the private network is ipv6-only by design to avoid conflicts with
> >      overused ipv4 private addresses.
> >    - it uses hacked-together PKI to protect the TLS certificates encryp=
ting
> >      the connections
> >    - some implementations of NFS only run on systems that cannot run
> >      OpenVPN software, requiring complicated routing/transalations
> >    - it needs to be re-written from bash to something..  less bash.
> >    - network latencies restrict testing to function; testing performanc=
e
> >      doesn't make sense.
>
> And the only RDMA testing we can do is iWARP, which excludes some
> NFS/RDMA implementations.
>
>
> > With the ongoing work on NFS over TLS, my thought now is that if there =
is
> > interest in standing up permanent infrastructure for testing, then that=
's
> > probably sustainable way forward.  But until implementations mature, it=
s not
> > going to help us host a successful testing event in the near future.
>
> The community does need to integrate TLS testing into these events.
> However at the moment, there are only a very few implementations. I
> don't feel comfortable relying on RPC-over-TLS for general testing
> yet.
>
>
> > So, the second question -- should we instead work towards implementatio=
ns of
> > NFS over TLS as a way of creating a more permanent testing infrastructu=
re?
>
> Yes, but given how far away that reality is, we shouldn't delay our
> regular testing with the infrastructure you've set up already.
>
>
> > I am aware that I am leaving out a lot of detail here in order to try t=
o
> > start a conversation and perhaps coalesce momentum.
> >
> > Happy new year!
> > Ben
> >
> > _______________________________________________
> > nfsv4 mailing list
> > nfsv4@ietf.org
> > https://www.ietf.org/mailman/listinfo/nfsv4
>
> --
> Chuck Lever
>
>
>
> _______________________________________________
> nfsv4 mailing list
> nfsv4@ietf.org
> https://www.ietf.org/mailman/listinfo/nfsv4

_______________________________________________
nfsv4 mailing list
nfsv4@ietf.org
https://www.ietf.org/mailman/listinfo/nfsv4


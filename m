Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C934136A42B
	for <lists+linux-nfs@lfdr.de>; Sun, 25 Apr 2021 04:29:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229586AbhDYC3z (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sat, 24 Apr 2021 22:29:55 -0400
Received: from mail-eopbgr660046.outbound.protection.outlook.com ([40.107.66.46]:46976
        "EHLO CAN01-QB1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229514AbhDYC3y (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Sat, 24 Apr 2021 22:29:54 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=A89YK7vEmbU3xd5/Kth7ymtgwvxGZH0bAIvSTR+lC4q99J9aqmAvSt0ugmR6uuhVT8o/Cg1iuqeVqBT4+roxR+um1Rn9h4bM0odH2/m/lBftbwZHvfSZu+mmBbYUWmzy0p6t2AgLVVrHR2UEL5zCOPtvjs1QOyniW4yWzeDs68iuR3XOTc8YSQ7toKrMP0072w+JQ1QsgVMLbVUnJe/+I7gMiKA8wr6zROyXgqDppCpPzl/OiuXr8zYHraL2ap0Nsvf8nL2JDsuz1LyGdn8RXpB8kUS/BFmzTh3Mv4ZSoGkWTue6BSlI74fMQUNdL0/uh7rGJgB3QWSjA562kP/eNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4klSnY35+h35RvjKyXoEJ0uy5XeXZQ+WcCpvjBb644E=;
 b=oSOMT3Dh15m29NQJoX6lOv/RFHGW+81GokOkpr60caypRVi7sP7uN3r+NKQZdNFWf2kEvAevc9JQlASjxqM5MZ0ArbRdbpVhe04oiF5PkdXSlYAe2tdVvWQTiwdcSZk1zqBiNrVKjdgnIcMfdpKuz9UGrf+yCSwOzuI1Maag9FZmAxqckMcLBs40UeFDSWASzMw1HwpXz9UtfakIASt3RU13+OKrpHbVbyuXNuBJyD5lHHi8TsZPcu+uff8L1TfOOY8dG4Icw2SNtZ2JPyi4BZgRkkrzzihNTYb+hm+edswKalooe2wDmKTaDnSY34bp72xuI0V7gDYYYOd4QSyn2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=uoguelph.ca; dmarc=pass action=none header.from=uoguelph.ca;
 dkim=pass header.d=uoguelph.ca; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uoguelph.ca;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4klSnY35+h35RvjKyXoEJ0uy5XeXZQ+WcCpvjBb644E=;
 b=TKpimPCHH2tLwcRICof/hplzCyoMSsQ4y4XXShdDJ2YwlNFvX1KqgoJwJtSvb4XktQCR4i7x9gCr0Am90uf/eB28e5+7FAQVO7bjTCRQP6c1+SXiWcjtMjfWUMKFXZ/mrH26LkAw0WaRPaVo9c4PrIzq0CeslzfGmJw4naPv4FpK/ShI8bg+lzCLR2zxO/w8wVHL9IATcinrKCQ4u6BcW2tq5QVdq4vK4v8BWK2jUcrrW8Jy6dMidv8Zlth5G2N3k8Ma34gTyruXWfRlfTs1dEpszLjSV3Ojr3iAevxL9RkGdAHGAegTNNP8A+NWqIaxFhKycodcfL1IWPRIqrDkSw==
Received: from YQXPR0101MB0968.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c00:19::29) by QB1PR01MB2867.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c00:3d::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4042.23; Sun, 25 Apr
 2021 02:29:14 +0000
Received: from YQXPR0101MB0968.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::1c05:585a:132a:f08e]) by YQXPR0101MB0968.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::1c05:585a:132a:f08e%4]) with mapi id 15.20.3999.038; Sun, 25 Apr 2021
 02:29:14 +0000
From:   Rick Macklem <rmacklem@uoguelph.ca>
To:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: weird Linux client behaviour when there are multiple concurrent
 CB_RECALLs
Thread-Topic: weird Linux client behaviour when there are multiple concurrent
 CB_RECALLs
Thread-Index: AQHXOXfnjixeaFEWH0C9YjMT3U0+MQ==
Date:   Sun, 25 Apr 2021 02:29:14 +0000
Message-ID: <YQXPR0101MB0968124A7F9024769EC90F23DD439@YQXPR0101MB0968.CANPRD01.PROD.OUTLOOK.COM>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none
 header.from=uoguelph.ca;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e7bbf777-2580-4d52-6277-08d90791eae3
x-ms-traffictypediagnostic: QB1PR01MB2867:
x-microsoft-antispam-prvs: <QB1PR01MB28675558AF6DF4478141EF54DD439@QB1PR01MB2867.CANPRD01.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: dIzgPmvSX3nGSad3NE7yn6VXe41auyCPAWKZ2Iq90NxIEmhZ9UWyPrKuZpqHg8iDHepLPIQHMAmHO2UXZSL5aiTczUpgo5z3D4fQTClTy68F6U6bgqlJqJn3otIEkg1uueusVqURl13tqXFpq2cjTXt0YIwBV9VolyHAeMOwcz+VxcOkjbCTGdQ7iow90BcFe4FaJpNQ4FuhbX1nQorVEGj8iqT80zIc4JKzssPzN/RWgUZ8W8bF6agGBXV3g47t9cd4kllQmU22Fl3rq2wqXiv0Rz+STca01qbXsNHksxZapPk8rpYTvINq00/f09O6CXKRVjosja26s5gMe08Q7pyl0DUn/GCtKa3NC/aggwol/u2EEwmfxVovGN1w719NuHAlr8A7i1wB/3WtDH2RmgNuyh6bVX5gZr3vnUllvvBP0I1v3xR8XsaQnN1T9d6Wq5z55maY6M2GROwyUaTD3EHNqY5Lr1Jicn65+YFQ1+fr1pWqLCBCkpwdbIK3whlYpmqtg3ZG88JJNQ5YfLp34FFxlZ8pgor98JR3230/VWmobt0W1MWr4WghMcNE/r0fBACkl/p9GNVRcOKPaWj5BOX3cTzL9hs48W4bnXhOchwzcke8Mp8bdHltD3MhO0a19DqwNTEGxYHKuwuVQ57zW1oxhJar90UxyY8RCko3GDDge7yh5IoA0GYzpO3Asbnq
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YQXPR0101MB0968.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(39850400004)(136003)(376002)(396003)(346002)(366004)(786003)(7696005)(8936002)(316002)(83380400001)(33656002)(6916009)(52536014)(64756008)(66556008)(76116006)(66446008)(8676002)(91956017)(66476007)(66946007)(966005)(2906002)(122000001)(38100700002)(9686003)(86362001)(478600001)(71200400001)(186003)(6506007)(5660300002)(55016002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?iso-8859-1?Q?bu9VLHCoSnG0CCr3bCiiS4YslN/ex0jqMm3T7+tS9bL29uL+hDuzsU6FOY?=
 =?iso-8859-1?Q?CungBN/p1y23UDV3+d/HlZX07U+KoRSmac4f9zNjhlZKT9tmkRjgn3o2aX?=
 =?iso-8859-1?Q?x5117QYroGx8A+IX0YtlG229Qx2oljHA73FUK7U++6kXgAux+yQeXtj7q4?=
 =?iso-8859-1?Q?Ym8LuwhQ1Y2Tp9zrE7yyTiZqj0+8gURCNWzk2IMYBSDrPAEEFgtk4kDKe+?=
 =?iso-8859-1?Q?RU1ImxIueRWcGB9f+W3Mf34flFfHLdbI0rD7PNwOgi7Vl476HkwBXZDeBp?=
 =?iso-8859-1?Q?gBDPiiAG9S0F2D8mZLcvMFGVnD+TrNaWg/ZKdt3oKpNcKseowOL2Br5wAs?=
 =?iso-8859-1?Q?R4Uy/H9SjtiXY0zXJ0oZYjbGTqxFw7IJzdZXd3l066yEUKit2eMeJLCUZv?=
 =?iso-8859-1?Q?lLUtvRBTrrvAKL81Ig2zc4fhle94T+vG46muG7I2ubLrxyvHp29lnpOKlS?=
 =?iso-8859-1?Q?o8kkEGprRhECYRrnXOc1niNlCqSGuyDpH9ghDh73+JGrzH305byt7kqckQ?=
 =?iso-8859-1?Q?Miffgbn3Y8dRynGKHTwnoARBBZBwjwNaCl8B05WLRyb5UB8zYCfMk7D7RE?=
 =?iso-8859-1?Q?meSJTzZwZ5viFkXEf6/lEMii8WZU6Y98Ob3/VNqZ7vGGV0wktPiEmQkxBh?=
 =?iso-8859-1?Q?dIn0fDKZCxjG6G8Tuf5R0tB7w8dFlOkpVwW7p9rG3UiwCoEtr2S01QIPxM?=
 =?iso-8859-1?Q?wdAx/4daIGdgFBuWNa3PhAkGxyfsI3BVDbh1NMpfMsSIIrnjBt+lvgrJrM?=
 =?iso-8859-1?Q?SanIVyPefrSJgB4+Ka5OFvb933RxtCKAa2KyL5Zk/nKeTIb373Hc9vmGYb?=
 =?iso-8859-1?Q?QBEkNit/pNVu5VW+H52Y/cVtIZTON0lw+ifJHYgeBkxcRH4+YWYi/PQ8F1?=
 =?iso-8859-1?Q?EZksGKvK8bPgjjmvIjMHpbpg+v59gq1BJy1GgDldokQGbMUi09IMsn/ISI?=
 =?iso-8859-1?Q?iPq0/nfCuCK+h2zR1vATXxHZLTjd26jrXMjJOyQCi8aJxs7KI1wPQ5tU94?=
 =?iso-8859-1?Q?T0hhz30dleyvLVesduNsUN6r5pGVenGaA4r+DJ37rfLkvaFQw8cxAdKx4t?=
 =?iso-8859-1?Q?2FgrJqjzuQ+vYxz0ZvxLAPvpmW86O3h9VAlVUb0spGMdVuZMHtMGp6Bopb?=
 =?iso-8859-1?Q?LwmMS+I9GGht01lJG6el8rFr4XHVkbb1iYrW7vYXh4aOMALyOsKCVvNL8f?=
 =?iso-8859-1?Q?1abe5G+VsdW7P9p6XrCmLSimjSh80seh1jPw0cme3mxnW0oRwkM/NHd/Of?=
 =?iso-8859-1?Q?/0PvI8Y9fRMyJaruINMzOvx/MUqmTzNczw0bVdavrc21JXwIjcBuqaUpcv?=
 =?iso-8859-1?Q?G+O+/n9il4FFsIjmclqtp5Hu/8b+bdwhaSTJgS8FZlrm5M9w2uwzdW+CR6?=
 =?iso-8859-1?Q?yIg3ddRkdgQo/7y3LQgvTtowOsU/vAOlu1jssZGWKJps0AIvkELXPW8RE2?=
 =?iso-8859-1?Q?+N2IC2cxlE2bMiI3?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: uoguelph.ca
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: YQXPR0101MB0968.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: e7bbf777-2580-4d52-6277-08d90791eae3
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Apr 2021 02:29:14.1409
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: be62a12b-2cad-49a1-a5fa-85f4f3156a7d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OPbU6W582MFaajyzgHUogfTYAQY+vdoLZ+xx8fqbGAbJfBOiemDwpAHOZ4YwwKAbqt+47YAKZ5Bk+Gw85rAbbA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: QB1PR01MB2867
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi,=0A=
=0A=
I have been running a simple test using two clients (one FreeBSD=0A=
and the other Linux, Ferdora Core30, 5.2 kernel) with delegations=0A=
enabled in the server.=0A=
=0A=
The test consists of running the connectathon general tests=0A=
alternately om each client, using the same directory on the=0A=
server.=0A=
--> As such, each one results in CB_RECALLs of delegations=0A=
      from the other client.=0A=
Everything seems fine until the server does multiple concurrent=0A=
CB_RECALLs for different files/delegations using different=0A=
callback session slots.=0A=
--> Then the Linux client decides it must create a new connection,=0A=
       which breaks the back channel.=0A=
       After 0.1sec, the FreeBSD server notices the broken back=0A=
       channel and starts setting SEQ4_STATUS_CB_PATH_DOWN.=0A=
       --> 15sec after that, the Linux client does a BindConnectionToSessio=
n=0A=
              and things start working again.=0A=
=0A=
The mystery to me is why the client decides to create a new TCP=0A=
connection, forcing this 15sec hickup each time it happens?=0A=
=0A=
If you are interested in looking at a packet capture. you can=0A=
% fetch https://people.freebsd.org/~rmacklem/twoclientdeleg.pcap=0A=
There are multiple examples in it. One is at:=0A=
packet# 3518, 3520, 3521 CB_RECALL requests for 3 different delegations=0A=
                         time 137.5=0A=
--> This is followed by a close and open of a new TCP connection...=0A=
packet# 3582 - first one with SEQ4_STATUS_CB_PATH_DOWN at=0A=
                         time 137.6=0A=
packet# 3604 - client does a bindconnectiontosession at=0A=
                         time 152.7=0A=
Then things start to happen again...=0A=
192.168.1.5 - FreeBSD server=0A=
192.168.1.6 - Linux client=0A=
192.168.1.13 - FreeBSD client=0A=
=0A=
If this is a known issue that you think is fixed in a more recent=0A=
Linux kernel, then sorry about the noise.=0A=
=0A=
rick=0A=

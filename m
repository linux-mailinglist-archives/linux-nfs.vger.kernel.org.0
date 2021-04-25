Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1EC2E36A991
	for <lists+linux-nfs@lfdr.de>; Sun, 25 Apr 2021 23:43:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231300AbhDYVoG (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sun, 25 Apr 2021 17:44:06 -0400
Received: from mail-eopbgr670060.outbound.protection.outlook.com ([40.107.67.60]:48373
        "EHLO CAN01-TO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230494AbhDYVoG (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Sun, 25 Apr 2021 17:44:06 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UNVkLbbSasLulv8qwMu8OyAjQCwFDMxdJnIaPa50D0k+r+8d97JjXpHj4wpIeoJBvCAErvC2ItMKxRF13N74o3/kH6y6rYg8eIWzB480xcAUQ4YKbugzmvDb2/L/CUlMqHCCH1X/tiunGdOJG2zvT4iZ1Oc+9L6vdADAryuATKQqsjxi1aFIAqrGT+cV2Q/ZLYoIWCn0c0zYcWErHAuOandPiHHTKG73lG8imM+PImdoiOG+3sTGAktvtAflCaQ6IsQW1idUlSl5IMpmrobQx7jUyvaf8fR/0x83/SAVXzLCIQiOLBC3BEDZKOWgwa12DCR5qusj1yvkxQz1wyWpGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eFujQ36DT+E3Oy8mtC5FDbQ5PGQiZfiRWM0zap08lkI=;
 b=K5yaDlrJTNSfI0hX4b5VP0rq8anjPSG1m4UepSsiB07ZkOB7m/OW8EqvbC8L6HMp46VGViOkMKz6dYyFT0KcqFpTpCptE5XDGaXlH9DkdP41568Qgw5kBGqk/mZzHTf1hVOIKEx3jcIx1SC1ACj7uxvaLiH7bh9KlojpHKipciBtms8Qjo9fhhpr/BzKpPkIkPX6YX6uM0J0mVhxrYkh470tdk+vkJrkmTneY2xFBu9g8hn0VrEeSPzFUhGK12kBbiAnjeHx0+F69YSUTj7/NdiwJh2wR9FkzZ4y4a6kVqsRiHcN1kGmJscqs3wC3y2oq30Siqsb/9+ivyrYkdB/Tg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=uoguelph.ca; dmarc=pass action=none header.from=uoguelph.ca;
 dkim=pass header.d=uoguelph.ca; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uoguelph.ca;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eFujQ36DT+E3Oy8mtC5FDbQ5PGQiZfiRWM0zap08lkI=;
 b=wMzV+uTsql1pGBv3c5fyrmkLNktDpfroVNdYESUmWalrrcCrb3cDdIkERMAqiUnMzvYx4DzvfWQzyRAQaqGfObU9ejSM9XIQcnNd/IEL9eW2Olwtb+lrqKfyN2eFIdKxaDwLT7dGvdcqnkM0dCffHHPr7uiGCHq2zgVQ8zGJBeaB4WHM20WWdMg7UjZrRSy1XgTC874uHMcT/7LMSmy3uqXMXPbWUXPDthmSCTOCPlB8eaIzMNi7XJoDWXVmQzIcDvC9AaHhA+slSyV+4MoI9Dx++0ljQURGVIKjGGI3/F3eGwaeKJerG/+SqJ+KgM7XpmX/DRVCjByuJXJpcdIZAQ==
Received: from YQXPR0101MB0968.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c00:19::29) by YQXPR0101MB2248.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c00:17::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.26; Sun, 25 Apr
 2021 21:43:24 +0000
Received: from YQXPR0101MB0968.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::1c05:585a:132a:f08e]) by YQXPR0101MB0968.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::1c05:585a:132a:f08e%4]) with mapi id 15.20.4065.026; Sun, 25 Apr 2021
 21:43:24 +0000
From:   Rick Macklem <rmacklem@uoguelph.ca>
To:     Trond Myklebust <trondmy@hammerspace.com>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
Subject: Re: weird Linux client behaviour when there are multiple concurrent
 CB_RECALLs
Thread-Topic: weird Linux client behaviour when there are multiple concurrent
 CB_RECALLs
Thread-Index: AQHXOXfnjixeaFEWH0C9YjMT3U0+MarFfYOAgABHYb8=
Date:   Sun, 25 Apr 2021 21:43:24 +0000
Message-ID: <YQXPR0101MB096801BCED45A39CB05CA884DD439@YQXPR0101MB0968.CANPRD01.PROD.OUTLOOK.COM>
References: <YQXPR0101MB0968124A7F9024769EC90F23DD439@YQXPR0101MB0968.CANPRD01.PROD.OUTLOOK.COM>,<9dfaa112431882110d6795f93f52d7561b466b80.camel@hammerspace.com>
In-Reply-To: <9dfaa112431882110d6795f93f52d7561b466b80.camel@hammerspace.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: hammerspace.com; dkim=none (message not signed)
 header.d=none;hammerspace.com; dmarc=none action=none
 header.from=uoguelph.ca;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a377d0af-4a9c-46c1-11c6-08d90833273f
x-ms-traffictypediagnostic: YQXPR0101MB2248:
x-microsoft-antispam-prvs: <YQXPR0101MB2248EDA64D432D358CFEDD2DDD439@YQXPR0101MB2248.CANPRD01.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:1923;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: +Cd9JFiksJvdBOF68O6O9Zs+sgIPepMLQ6XBMgxXsmcmfzr15OVkdfNEsxaL1G8IwGBmOyx43gjunLtDm9vKCJQD35mG/BcIicG3RSmBWNVaOok1F9Q9AXRfbvHPXvRF64gAE0JEDJhAyF+JMKnZDvXlFFPiFCYlnodWEwYDS7nvih6iPIxQcwyYEgpe2vuI3lEkYeT4Lf8EA8u7mFDU+XbWf8CKS6UTO3BZiJiCWQs6dO9FmwnOSfCKJlXgOMGG2yr/wYAjQqsXaEaSPFu60z4xxI0TwoQ8ldgkNAzIYpiS90FBFN+laGYQDJMzVPSQqyMl4EaYzyfDVcifHcI34aT5RHwi9zf9R3bYRnZwyoJ95ZDGab2PtEYNjHzUxW5uqqKc6CS0fKPnt3hzvvFVoOQ55NxQ6zF8a+bpnJxM9UhxIHrWu9jpMHRqvah8xKnFGaymP6/mSNhvpX+fH4SqGg0OhsQaOFaL54lQkw4fCe5YqHUq8lpBA4L9M7ViWkLe/Mpl5fyFw/gyk0+FhvGNAVraKlFVE0YNmm0ObO5embmuZn89zdeiznS5bLhJJCJ2/3nnTOfvIlhWJ5lJZa99HjRkwSXj/0LzOtRyrg7xFe7j0Vfwt8g14XUc01pH4f0wpeDCDwn6nJ307UHKGkIEfRaeRThJ/acLS5VivBs+QhUVorFJL291D3p7NFRJ0fhp
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YQXPR0101MB0968.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(39850400004)(136003)(396003)(346002)(366004)(376002)(66446008)(91956017)(66946007)(64756008)(76116006)(66476007)(122000001)(966005)(66556008)(7696005)(53546011)(8676002)(6506007)(478600001)(8936002)(86362001)(33656002)(83380400001)(38100700002)(9686003)(55016002)(186003)(52536014)(71200400001)(2906002)(786003)(5660300002)(316002)(110136005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?U16VUqLj4NZcXSo8f/AU11RyUzmCIo/LncLAyQgNnLxnIlUFnfKFG05ZPGXu?=
 =?us-ascii?Q?lVnqo4GzKCwljQd/0hl7kKuFEBVr+4+6a+Jz6jXopfWY0UYTLuVc/+/NdNoR?=
 =?us-ascii?Q?z9hWnmD+ULFfxH6nMgjfKxJ0isaBiMh6OQqjFwhQgbcCb8gQXaj3d/6MWG+u?=
 =?us-ascii?Q?s0flEO13wH4nOyVo1wk1Ep3vGkemlbRlWeS/ZmgJUtWr+11IAGc2SM5lMzI0?=
 =?us-ascii?Q?nmNjyCzdmomQF+5SnpV0OexsIyroZvJ5uGNgt4tYjtry5WZfQjnI8mg2rDKx?=
 =?us-ascii?Q?kyiq+MkCnOcX4bZShP8Up89nOc66dYDOuiBbMXM0+TGamaKBG499zifuqxeU?=
 =?us-ascii?Q?9aV0+NMhfGhnLwerDTL0CA22aTS6UOlkCFXFYEIya3UNfIFkb0iHl9PGcVG6?=
 =?us-ascii?Q?snV8oFOecAIqP4OKmk1AQyqQqlYP7Evfvj4tlntZLsIUvzi/9Fn4a34vyHdd?=
 =?us-ascii?Q?2zYIF8/FoC+I7N6Ijnjw3bztmUTEBfT08y/Y5gkMQOHmwE2LY3MXrODRlkb8?=
 =?us-ascii?Q?Bt27AGbgBxBkpKVchtMdnsAE9Wz7upTvccYYBT/eX/gnxWCiPoqivP7SsYEq?=
 =?us-ascii?Q?cH+wAXr5tCrhs3Hr6XIR4Yy6TAhCHcjpDQqXna/mp/KLpEFixgdK22acjIw8?=
 =?us-ascii?Q?msRcQ3pQFspm903h8fYJmrA9hwSo4ScjwPW0TE/cOxd4iUAveAf7ySQarQwr?=
 =?us-ascii?Q?N9CK1+OYkO2p39woKnRThYA7HqToV6sLdBCCU2N1ycd26MNDOiIhNbe/gm4f?=
 =?us-ascii?Q?19FVfBU1gCAl+ToHlo1AkQuOhigjQ5q1s9/r/Y+9KlF6CSdagvqpWNiPOi2A?=
 =?us-ascii?Q?8JbO9Qwrw0PBA9HaMmdta3ooLrrAkgRLwXW4QfbyEFUz+k4isIT6VXtJdIwh?=
 =?us-ascii?Q?76DZLfzAr2pPSsa0eu6FbpPmabCBCLfq0xUMqWkJLBYjLXPHB+06+5VM4Ecl?=
 =?us-ascii?Q?AMuYacLaPgID0rlZ6SJOf/0dvwOK1E25hk0P2NK4/R9nxsh5+5S528xjHjVr?=
 =?us-ascii?Q?b0mwhgR4y8rzmTaebsUwaPp4EYwYjNY6wMYPn2OFtKMm3GuqgDXEbbpRbig6?=
 =?us-ascii?Q?UnbuNJHHe36Svhg324pyYsPywwLXe8byXViE1P3qTArUk3MTjM8jA30HjZ5G?=
 =?us-ascii?Q?olNoJDxlnHk36Y18KXAdeB5A+yxR/qzePtFqVmb00RXGG0c/yoNO6KJbGbV5?=
 =?us-ascii?Q?QdcA3fo6Iyph4kyzWrM885JdpReGgDyobd9IvkGfoyLqYpht5tdjjppU9cqC?=
 =?us-ascii?Q?ixpPDcYyONbeaBkV+rkCssRHi1bK/omGIee/77IY1cMV6ioCelxoEbY5R5QL?=
 =?us-ascii?Q?CMgZmuYBmI9u+yXshpTfcUP19K9LsOfmd4CN54rMFwngvux3QURd1zeoXGtP?=
 =?us-ascii?Q?ntAZ3ME=3D?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: uoguelph.ca
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: YQXPR0101MB0968.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: a377d0af-4a9c-46c1-11c6-08d90833273f
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Apr 2021 21:43:24.3445
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: be62a12b-2cad-49a1-a5fa-85f4f3156a7d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: F/vzvzp7xQxu1Ps0tDglh0fLJoBIobZnX1CewallSkW5GzD+hQ4WUg8ydLHUwuzfwmNwRXfaTg6sw3DPC+lCtg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YQXPR0101MB2248
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Thanks Trond. I upgrade my kernel one of these days
and test it.

rick

________________________________________
From: Trond Myklebust <trondmy@hammerspace.com>
Sent: Sunday, April 25, 2021 1:27 PM
To: linux-nfs@vger.kernel.org; Rick Macklem
Subject: Re: weird Linux client behaviour when there are multiple concurren=
t CB_RECALLs

CAUTION: This email originated from outside of the University of Guelph. Do=
 not click links or open attachments unless you recognize the sender and kn=
ow the content is safe. If in doubt, forward suspicious emails to IThelp@uo=
guelph.ca


On Sun, 2021-04-25 at 02:29 +0000, Rick Macklem wrote:
> Hi,
>
> I have been running a simple test using two clients (one FreeBSD
> and the other Linux, Ferdora Core30, 5.2 kernel) with delegations
> enabled in the server.
>
> The test consists of running the connectathon general tests
> alternately om each client, using the same directory on the
> server.
> --> As such, each one results in CB_RECALLs of delegations
>       from the other client.
> Everything seems fine until the server does multiple concurrent
> CB_RECALLs for different files/delegations using different
> callback session slots.
> --> Then the Linux client decides it must create a new connection,
>        which breaks the back channel.
>        After 0.1sec, the FreeBSD server notices the broken back
>        channel and starts setting SEQ4_STATUS_CB_PATH_DOWN.
>        --> 15sec after that, the Linux client does a
> BindConnectionToSession
>               and things start working again.
>
> The mystery to me is why the client decides to create a new TCP
> connection, forcing this 15sec hickup each time it happens?
>
> If you are interested in looking at a packet capture. you can
> % fetch https://people.freebsd.org/~rmacklem/twoclientdeleg.pcap
> There are multiple examples in it. One is at:
> packet# 3518, 3520, 3521 CB_RECALL requests for 3 different
> delegations
>                          time 137.5
> --> This is followed by a close and open of a new TCP connection...
> packet# 3582 - first one with SEQ4_STATUS_CB_PATH_DOWN at
>                          time 137.6
> packet# 3604 - client does a bindconnectiontosession at
>                          time 152.7
> Then things start to happen again...
> 192.168.1.5 - FreeBSD server
> 192.168.1.6 - Linux client
> 192.168.1.13 - FreeBSD client
>
> If this is a known issue that you think is fixed in a more recent
> Linux kernel, then sorry about the noise.
>

Should have been fixed in Linux 5.3 by commit 7402a4fedc2b ("SUNRPC:
Fix up backchannel slot table accounting") AFAICT.

--
Trond Myklebust
Linux NFS client maintainer, Hammerspace
trond.myklebust@hammerspace.com



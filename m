Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1294262230B
	for <lists+linux-nfs@lfdr.de>; Wed,  9 Nov 2022 05:20:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229705AbiKIEUP (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 8 Nov 2022 23:20:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229509AbiKIET7 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 8 Nov 2022 23:19:59 -0500
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B01E1181C;
        Tue,  8 Nov 2022 20:19:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1667967598; x=1699503598;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=A2586BYsOahTsgQvUCdaytclD/vORnQuTw5oC4Dkynk=;
  b=Si+/aIX4/GI2yHDv4IFg1nzm1cBFr2uVFJrMAxsqFxGBgU2xO9lqp0dQ
   anDnjR0TAEv0UUoYU33md598WYRLfEBir3cF2T/SD0BBIdd2QJtnw4IRT
   nL88MBV+N8ppoFBeo5dzfznbLOa7hzFrWRQdnl73c5IaNgeWrxklc7ZMy
   L1U948SIc+dKtASF3716F6phi1ZAy4eKvHPhdwB14b+qDIjcWwg/7RmFY
   s9s0JgN6ei2TkimIH4Z9DQDfY1l2/gnyRqNppOQCE8RdNiJSfereJOnEw
   BRmuNhxEzeltsqJoivYVZB1a1leaqBS7SlghB6muzQkT8v7zdJzjzqByu
   g==;
X-IronPort-AV: E=Sophos;i="5.96,149,1665417600"; 
   d="scan'208";a="320161488"
Received: from mail-co1nam11lp2169.outbound.protection.outlook.com (HELO NAM11-CO1-obe.outbound.protection.outlook.com) ([104.47.56.169])
  by ob1.hgst.iphmx.com with ESMTP; 09 Nov 2022 12:19:56 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WZBEtoira7UyVmguWVbPvpIiN4kYlKSlwTaiesPYA1lwTxMOoOOICmYIHfM9KggSCl8ba6/ntti1oAJiT3HhIbdPqSQwIabivfuALmqttktrVNzUkaEXZoUbzHVq0hgdDY/QLqL3JyJBa0S/w/51W/dZL8eoeeTPre4SYvorljRFNYWeb9W77r7gqaO54xgs5c1FwVEz4IBBFdZb+vLxbDf/U83ouWHskfy+E6gvFIOOjMUeMIldWV2FY5ZyLpWtLYfzcHtOdc9SYuAynIM17vK8kgSk9oZ3zWfzu/NTZqA4rac8SGwQLge7p6ehOiICgP+MEL4RemE6F7pY3/uNrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A2586BYsOahTsgQvUCdaytclD/vORnQuTw5oC4Dkynk=;
 b=KYBa7ZMVPiRbogo8uUScZXFjZBK3Ghet+AMPLxBNK9Rg4/UM/xGNo/pFcCPK5NlD5ujgdUsz/6GtUHSDzWW3nrDl2jL2YohQ8LYcdBu2xk//XxZrZ8HxRzIu5GmgPpu0iI1AZtdEaOHdCRWHq0B2Ws1Y/MtwyR8ocwBcqgT7X6ZXHtKT6Clv7j+dssIEqCw/AdXILAbIC2TrAfu7GpSsSVWP05VomUYcCvTLAYgDfGt+CYps04h5usiyneKp/24tbc1jYYxmU91xJJheb6lxaTfDjirUKZ5RK+BmgVM+/Svm7PaxaCrC1xRikUXu9qgPF947oT2cAc39HrE6WulBiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A2586BYsOahTsgQvUCdaytclD/vORnQuTw5oC4Dkynk=;
 b=bCqnRdg1kuWLnTnCpUkUecZmzmm5xwkHq6bAaFJhgtHxIQbx/6ric6+BNniAQ4Mq6w7diW4IKYR6f+wSF8GaVYfOPrbsX8MjCcf9KnafPeZtmg8jbhYIEb4nXiC1XPpAvNLqku9jPm9KBQhJbki2JRu7nDIpN8N0vhJ5dZmU8hw=
Received: from DM8PR04MB8037.namprd04.prod.outlook.com (2603:10b6:8:f::6) by
 BN8PR04MB5875.namprd04.prod.outlook.com (2603:10b6:408:a8::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5791.26; Wed, 9 Nov 2022 04:19:53 +0000
Received: from DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::d4b9:86e9:4fc8:d6e0]) by DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::d4b9:86e9:4fc8:d6e0%7]) with mapi id 15.20.5791.027; Wed, 9 Nov 2022
 04:19:53 +0000
From:   Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To:     Zorro Lang <zlang@redhat.com>
CC:     "fstests@vger.kernel.org" <fstests@vger.kernel.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        Chuck Lever III <chuck.lever@oracle.com>,
        "djwong@vger.kernel.org" <djwong@vger.kernel.org>,
        "linux-xfs@vger.kernel.org" <linux-xfs@vger.kernel.org>
Subject: Re: generic/650 makes v6.0-rc client unusable
Thread-Topic: generic/650 makes v6.0-rc client unusable
Thread-Index: AQHY8/KDAlsuTLAdeUqIt7enJlIXlA==
Date:   Wed, 9 Nov 2022 04:19:53 +0000
Message-ID: <20221109041951.wlgxac3buutvettq@shindev>
References: <3E21DFEA-8DF7-484B-8122-D578BFF7F9E0@oracle.com>
 <20220904131553.bqdsfbfhmdpuujd3@zlang-mailbox>
In-Reply-To: <20220904131553.bqdsfbfhmdpuujd3@zlang-mailbox>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR04MB8037:EE_|BN8PR04MB5875:EE_
x-ms-office365-filtering-correlation-id: 20a56cea-12cb-4825-d3f1-08dac209a701
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: mTkt64a5YVyT14lJ2TDwtjeAm26mbvNoBtt12KLXB1kNetWaIdntb8vuYGHNjGpj9Fg/fIzr60Qb7J1Bws6e7GI0Rh3PZS4sLWnW32fNWZgAHr0Sj82z2S/2iDyjqjHLsdiMTopmGResdPcouCwr/9Km84TIDLdlKnLO4OCQekPCgMVkdAIpMWgUxENO3T/jLHMZHxN+aU/kkdDkxDZSDlqclzFtF3DW0emFbs6CSJUUaWFDkBfqhHfkubVkMCatbWehZF8b3NFsPyUzejCzT0t5vCaUvyGSUv1nG4aLTNYSatzp8WQApiiLOo39k32paNbO9EmZsdsEVFkkfRmPPZiYkBe/iH5ZIW9a4mJwjFL6IJT5cclviAq6K4dLXyRj7cBkvzq2Ze1ldoCzgck6BRxnvQ8tZwwtRoHQDJj2y2ME8dhe+KFm983/B2cmBCvCUhxHwGCCdV35ZMsjX3n4Oh62eIkJuPDeuGl8yx9lIJeMdqhGuIdt1zum1RzrXuo/1ZnIvkX6L0AVFTwDYIEkRHX+fS650BSVWl/gR+u2DqffiwqDP5yECLjlaqGidoPLaELdV8nOGS9TN4Ij5sN7/bi7q/X+Q2GY4f7faRcwnh74nWXi4ueUVDO5z+C0E5mu31Cc6EG0p6vJ19/IQYaXD2O7xNvPfZipxuuBKbRB5y4TDUnInxmjSehaywJa4m48i0enyKvvHYgY5ntf8bdS7FgIaeY320wRXtGx5U8IYMTknkM9176kMv36uPxqbiCiXxaKrfq1lAZ14j7F9lr8VXoG8QxICkbOReHMxGHiMJM=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR04MB8037.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(7916004)(4636009)(396003)(136003)(366004)(39860400002)(346002)(376002)(451199015)(44832011)(8936002)(5660300002)(41300700001)(8676002)(4326008)(86362001)(82960400001)(64756008)(6916009)(316002)(54906003)(6486002)(76116006)(2906002)(91956017)(66556008)(66446008)(66946007)(66476007)(71200400001)(478600001)(9686003)(6512007)(26005)(186003)(33716001)(38070700005)(38100700002)(83380400001)(6506007)(1076003)(122000001)(41533002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?0bOWeYja3LIMC73aEitdPx3y5gdfKU3mhaE8WxLIxEm82ZHTzx3ikkLcjky0?=
 =?us-ascii?Q?kBIbQlSNfhFFuwBTmz8GnPWo1Xslh0NGvD08REML+meK30bHUtsZjv613IuM?=
 =?us-ascii?Q?VJIxLcF2tBUc2oexD4PHug/ISFGJv8fWdL44964zh8Gm19oDBzSIpGmZdi4L?=
 =?us-ascii?Q?mJjjYYWWPrUo0e1YkEodKmkvMwxqPw5LmT2H72BPtMbB2L3icMZpNHWNfzqg?=
 =?us-ascii?Q?K8y5xYr0UJ2Zqo6Xn8yZCDxRqIw6IcPI8nIvNQGx+0HCWt45b0vbRsAnXC4u?=
 =?us-ascii?Q?mNyVcP3cif+6cXDqKcuYe3dhafkVSc1UdlZ9//6ut+nznabzJRQjWp4vKd0m?=
 =?us-ascii?Q?wU8B5ol+wOMgmXBUg9AVwuq5BNOrjxJK2ZgNPLER6H0WiDsWKZI3o56yaOjn?=
 =?us-ascii?Q?5YGgwEct/oxaLIicJTqJn5qm9M++QpK/OCMcgiICqsWJrKbMzXI0+mx8/VEu?=
 =?us-ascii?Q?jVmTs6I0LBUoh4xgcqRT7N4lty4mzbLsUBbs0OhcQ1r/zbqECijQbXZkQ6zS?=
 =?us-ascii?Q?5e3butdBxr/+ztyIex6X0XqRcFyySFkAGlAYfC34NetYtusZbCHDqnrbrLM8?=
 =?us-ascii?Q?sFKnsUcPee3C0Z5n+m4aqf9pkZduAkkZoxULA9PqNP/WPe3G78aIvsglAnQe?=
 =?us-ascii?Q?IYMP3mAeVIXN/8aRHeFm/nwTCo/pnznU9pA6SOTFkUx0UCtuMOZq0eeJtcm6?=
 =?us-ascii?Q?ueafEoI5e40keBnw8cFc/44hAkTb2zaJDSmpQ1KV7Nd3kXwfjW6BTIgXBHNv?=
 =?us-ascii?Q?4mM5WO1w2KWOqZ/hkAbz9aB6XNVsBkqBja74mXNyMrGAG6o8dBUXBpkOEhOs?=
 =?us-ascii?Q?6OfGasX6JEJ/Quyyj5XqIOIEkDngKYTzClsv7CmYhfkxcIftBUzJ5IWStDGx?=
 =?us-ascii?Q?G+Z8f/ZJnY/zhhkQZMqncauUN4ifSZyut8S5e4xTQ2i5DExkILM+nFfjDs57?=
 =?us-ascii?Q?6cXYDQywwinomYDluXNqCCXdwrUz/XvWmQ2+T8bTB6ZnBfWbsfVAzvqv89ez?=
 =?us-ascii?Q?84ifxq7vjsoXPabvjLJSi0wWWI9nrGUWpf0YmwG9awaN+N7dfGWHUcIo/AEa?=
 =?us-ascii?Q?LnSC+QolDko/oto/n4uSBMBqINnKI6tGscQUBszxI0Sk+L5fgqF0fpAmaPlZ?=
 =?us-ascii?Q?Yl/L1Dw4Ad3aEg709IvIDM/NrM4X3MsMGtpQ1XkaSVZBZDJWrm6KjAUdACkX?=
 =?us-ascii?Q?tAh7/HkPCQtAgnPYETykMRyhUuDx9BKWtvvi8XJzqFU/uX7tm78izGMcmHsv?=
 =?us-ascii?Q?ToMazUde4L+ldBTix8J0se93DPsEVgEFhxXo38ENLGhPwYwjHnIEqkUfeYZ1?=
 =?us-ascii?Q?Po84ncAXaVQ7DZrmEWZV81J/mpWnaRVq96N0ejqIn+0fS8JtJDOguKvH+Sy9?=
 =?us-ascii?Q?/wrKzryhlii0/+8Y3rGvd1ZgwHuXbBonkC4Q6fSd4XCJW5bWkJfOzuF2mi+L?=
 =?us-ascii?Q?t6bkvB9Z1/W7xRW3ga60zYN9q6k2pZ/0my6tsDlKZyhjj6pH3E4OID8O2pb3?=
 =?us-ascii?Q?n+vkXZIuyNAd4QsXW0ljS0bQ3gFIATGiU6ZcEjUMpCZq/DGpVlvXt9nSCiAz?=
 =?us-ascii?Q?CD5/N/bAZmVmKnYsuT2sSRdT+VW7fsl24XG/sA2vNn42/qR91Li9UjhU/9iY?=
 =?us-ascii?Q?NZu2wbeMMQIG/JwNFRELnCI=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <BDCC8D78500ED84FA601D0D61AF40063@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR04MB8037.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 20a56cea-12cb-4825-d3f1-08dac209a701
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Nov 2022 04:19:53.8131
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bo8DqozHHBT7Cb1p7RZ/LL+dZFIRhJvhb0NMV2vddF6CtPlx3/maGp7g/ou8qh3ffMWWKDUzSYePGToiTmRQYHYHmtlqP9LgZEfs1IjwD2I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR04MB5875
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Sep 04, 2022 / 21:15, Zorro Lang wrote:
> On Sat, Sep 03, 2022 at 06:43:29PM +0000, Chuck Lever III wrote:
> > While investigating some of the other issues that have been
> > reported lately, I've found that my v6.0-rc3 NFS/TCP client
> > goes off the rails often (but not always) during generic/650.
> >=20
> > This is the test that runs a workload while offlining and
> > onlining CPUs. My test client has 12 physical cores.
> >=20
> > The test appears to start normally, but then after a bit
> > the NFS server workload drops to zero and the NFS mount
> > disappears. I can't run programs (sudo, for example) on
> > the client. Can't log in, even on the console. The console
> > has a constant stream of "can't rotate log: Input/Output
> > error" type messages.

I also observe this failure when I ran fstests using btrfs on my HDDs.
The failure is recreated almost always.

> >=20
> > I haven't looked further into this yet. Actually I'm not
> > quite sure where to start looking.
> >=20
> > I recently switched this client from a local /home to an
> > NFS-mounted one, and that's where the xfstests are built
> > and run from, fwiw.
>=20
> If most of users complain generic/650, I'd like to exclude g/650 from the
> "auto" default run group. Any more points?

+1. I wish to remove it from the "auto" group. Since I can not login to the=
 test
machine after the failure, I suggest to put it in the "dangerous" group.

--=20
Shin'ichiro Kawasaki=

Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E04C623DE4
	for <lists+linux-nfs@lfdr.de>; Thu, 10 Nov 2022 09:49:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232343AbiKJIts (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 10 Nov 2022 03:49:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229551AbiKJItr (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 10 Nov 2022 03:49:47 -0500
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB7EC64C5;
        Thu, 10 Nov 2022 00:49:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1668070186; x=1699606186;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=lYPeAFC/GxyBgzrN1t3Hc5DhcQWg44JNHeh5wpu8JPs=;
  b=JCY9cTxhoY9Z4otlbAGDfdRfu/uhYkxZhC9Gqh/4PSPWkcspxv2BrE+A
   oRw+H055KJumbUYtejJXZxOh3wJBjZaXXQfuwkZ0dloko80BNBIGMOoF2
   OuggxORkkgTEjG7Twz8zQAtIbaLxJTd+04W+YXr6wBRpddEQ3UlUN0yT5
   wkaPxkoESkywyTH7K6nwZPVRPlmFYPCkwQkdjcg3D2sgKrtBA1uMTwsbC
   spoiyHPsVtk4hlQKCiU7lwC+uDlQexvQlGY/sew1Ztgej92S8UCi9+jwG
   boWj3L3/cVBLEJmr86WG+pBkiqroLFiDLW4OMXTdyeGbC+MrKuQ5OvpiT
   w==;
X-IronPort-AV: E=Sophos;i="5.96,153,1665417600"; 
   d="scan'208";a="216272080"
Received: from mail-mw2nam04lp2171.outbound.protection.outlook.com (HELO NAM04-MW2-obe.outbound.protection.outlook.com) ([104.47.73.171])
  by ob1.hgst.iphmx.com with ESMTP; 10 Nov 2022 16:49:45 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=C6rtQfZEf6QbcHofoLQCo6efBti6Iv26Y/hk5Vmeov3HeAn3FufRXzDAV31Wlyqt8lFHSiqOYLLON1iRq6bDIIh/7iJCDlsTpCq6QSEnd+xX7K1GwYgnXAJybkI69vkmAorw19QfjlDCbpcjnTuzFnaEwEhjHecuHdReTBDLVRboIx9ZmQtn7l3Z4soeQJBfQ3W49C17c7Nj27fPV/eaQA2PE4z1QAvxQCHt5moKDiJCwckngxqAvR9VEtXc0jHK0nArxfvCWx7qm0XZn73ZR3V6Bozsdz7S+4hpVlbHdxHW5gdixh5xnsUQRz5rekRERhLSb/Ggkc7TFCh/wqb6VQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eWNc3RoTrCnJmH/Lx6hXsAL4uLTA7sgYjWDP21gnCKg=;
 b=L4ZhhQ/Eb1m1gj24XAkqcyvNtL8dEPjInVcYIslkq3sZ5WTn+E6yhoML4VDWuhItfh7E+lxlUvwNeAlQyp9UeGT2Thi0kfCCN8BAwUhckxLMKFY5rgNzvL7HgTIWWhIAaTAmsIe432Omt0msZ0eGs+2Bw49I0bB3bQedt2pBgd49dRBcAUA1RhRHY585wr7OANIjREzCATLjBRU9nYaBff4UucwCdxL2nYFLVb5heUiIvqOBaXv4Pd44WWx0OOXwxwHtiuskS2FiQ5BKvgKv/84Q54S8zZf6oW497VtJF/J7PMZmFkRN5GXdEhklprIUAzA0try/NpjABhRiFd9C5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eWNc3RoTrCnJmH/Lx6hXsAL4uLTA7sgYjWDP21gnCKg=;
 b=ohW/pKF56hCAQ9b+QOb2Kvf6KLI826qxuA3tTvEu34W0aLlcY66y+a9pThgKDjFgvCB5X9NA2LkK2KKF+g3+SvyNmRXci/j0SPT+79GQv9Tu6juiiQdNrqiXqmTWkZKpZ0yTBqwiZMiH0voPsEdv9bhtO89vlpUmC0ahtIMSmfo=
Received: from DM8PR04MB8037.namprd04.prod.outlook.com (2603:10b6:8:f::6) by
 BY5PR04MB6485.namprd04.prod.outlook.com (2603:10b6:a03:1d9::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.13; Thu, 10 Nov
 2022 08:49:43 +0000
Received: from DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::d4b9:86e9:4fc8:d6e0]) by DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::d4b9:86e9:4fc8:d6e0%7]) with mapi id 15.20.5791.027; Thu, 10 Nov 2022
 08:49:43 +0000
From:   Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To:     "Darrick J. Wong" <djwong@kernel.org>
CC:     Filipe Manana <fdmanana@kernel.org>, Zorro Lang <zlang@redhat.com>,
        "fstests@vger.kernel.org" <fstests@vger.kernel.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        Chuck Lever III <chuck.lever@oracle.com>,
        "djwong@vger.kernel.org" <djwong@vger.kernel.org>,
        "linux-xfs@vger.kernel.org" <linux-xfs@vger.kernel.org>
Subject: Re: generic/650 makes v6.0-rc client unusable
Thread-Topic: generic/650 makes v6.0-rc client unusable
Thread-Index: AQHY8/KDAlsuTLAdeUqIt7enJlIXlK42Zj0AgAB92YCAAPbFgA==
Date:   Thu, 10 Nov 2022 08:49:43 +0000
Message-ID: <20221110084943.bpnypxlandzjokyi@shindev>
References: <3E21DFEA-8DF7-484B-8122-D578BFF7F9E0@oracle.com>
 <20220904131553.bqdsfbfhmdpuujd3@zlang-mailbox>
 <20221109041951.wlgxac3buutvettq@shindev>
 <CAL3q7H5eV9Sb1axmNgvcbG7UrgGTH3AovaibQuWMz44Jfo-8_w@mail.gmail.com>
 <Y2vsJc1CKuUNzGID@magnolia>
In-Reply-To: <Y2vsJc1CKuUNzGID@magnolia>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR04MB8037:EE_|BY5PR04MB6485:EE_
x-ms-office365-filtering-correlation-id: 036f1029-5a69-4c3c-cf97-08dac2f8834c
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Smy0H2UhcmSWJLhuVgQyoVROyX0dCc34rlcyLqNZitFi/B858HJSGj0or2CJ3EXjA9Ljqyh/QQggv0FH0/RGpk9fvVKB6jGz3GjqDrZP7Bkkho8h+D/6cecp80S+7Qvxgpxj8hoF8xZmmOplm3O0lb+y6+wGlmfkwBLOwd5wUO/lOwNsFDymMM1e/4ZSc7OZlCXD8o0GZJDCNksSuPoIVJKCI8hm+U0dqpuRsMWo5hF57g47GStVlYxspLqT5/sLX6pjVAHxaoY/a2TXed749SYRKeEWA2QoQzyYLDM06ChTZHMujSCz4yezh1wvljOmXh7x4f+z6Ph/shxMzlInK0QnR7VDLvVT667wcWhNETpV9gpDSrfLVQqkQIJ/kV35KjoDUBTV1XgyaGcRQRkxkG8YVMRa7KnsUlou6ecnvaQjMRJO/N1niE60LkKFjVQfgtyHWjjhawHWVbqOnD/LwTZYYn/DPuNv8Gzysq7dqm4W+iXZvaz2fXlVbEOTYXy+s/+0RLSE884wORHyzQKX+mrD9gsV9Mwe5SqY4i6o99ViHHPBlx7Njuqt0vhqeVGwFs800eXDxFapTeTvSHTSNgxk4Zp+ViNzNIDrt27KwRD1kfl7I39Hyu1kL8y3WwhyKfb/0uuY50Cz/aHizDYBxR14+MrOVI7sO5b2z7hTdGe8WCT+Zi4X4lvQ5j0SqtC6J6+L23meE2rQUlKVH699cS9qYEDfBQPns+1zKcr7eP+DKbE3n88YuvRDyAAwV6lIMWJeZWF86UEqs5I5TBYedH6jfevSUiNMaWc0uKahRMA=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR04MB8037.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(7916004)(396003)(376002)(136003)(39860400002)(366004)(346002)(451199015)(316002)(6486002)(9686003)(6512007)(66446008)(4744005)(66556008)(44832011)(66946007)(8676002)(64756008)(76116006)(26005)(66476007)(4326008)(91956017)(2906002)(3716004)(8936002)(41300700001)(5660300002)(186003)(1076003)(86362001)(6506007)(478600001)(38100700002)(33716001)(122000001)(82960400001)(6916009)(54906003)(38070700005)(71200400001)(41533002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?28lsON655BqGTcA/oNFkEKUWCDmKj8I5bEj/Q50WSRI5CAzBKRoiyzOXaLkV?=
 =?us-ascii?Q?D7nfWUmBbwKh7AOtcpmkvPVhxZ9EQBcAcjFIBTEcolJucAtANygKrL1DjUfp?=
 =?us-ascii?Q?ZYi6+iTmZ0EJVbu5KEeLTtXibHlziuvvRvXHQsWzHtYePvFasZE1cwraR8gf?=
 =?us-ascii?Q?EJp9NWOCKqq1EsolCzh7Xbyz6vpQTHFYSUrPFdMoRRWKL7cEPYx1JDU3ktta?=
 =?us-ascii?Q?9Pgq//nrdYeuc0qZzGaCIPdIUlb+EAJhl+zOE94CxBaHLZh3GGU1TndT3/0v?=
 =?us-ascii?Q?jNi0cGd3NX7Zm6usgfw+kR0i3le9G58w0JvPBqJzeD0vg0C1qsp0k8X5xRPE?=
 =?us-ascii?Q?1qGan9Iijf8UGvWIBBUOnuEDhOLErc7x4Zf+QjRVZS7MXNH+7Ow8XoTbX7Xw?=
 =?us-ascii?Q?pYM3y03x61Jy2sWpulbpUHc/M2Ei2Ket8GXUKGoGBwnguGj6PUkPctMk49v6?=
 =?us-ascii?Q?fE/SJ2vHKC+PkahNe/ZrgwPPM3nHbyOJznAlkZl2IbXyia0PWvYhJi0DZuYj?=
 =?us-ascii?Q?wYQJOjw/AEAYZhXFWP33JtEKsfatW0YjvfyhVuetoIgeZviDA4Tn1dzbDl05?=
 =?us-ascii?Q?4aiqFPohEerY4e5lE6WviwgPvuuGcFh0rwJX27+n/V/znNlLC9PVsnJN07Fn?=
 =?us-ascii?Q?jRB5tTg5EssFMm86LEjPznBEeJVpUNzdUF9Iy8wI8wLzLn07qWf0jx1cWtkm?=
 =?us-ascii?Q?oZh3iAdvzK4mFkDiQiDFoFzX6JWQgQIxZps7AbKPFtP9fzAQeBTlrid2kfoP?=
 =?us-ascii?Q?0COXQVQWarzAiy+A1Yupi/SZuVoZ/v4wayNcUZoJ4LPDvuh7RHEeZTL8u3Sc?=
 =?us-ascii?Q?3D0nay+/pPS/AAA1jW7v2jlDvPjjRqDHN40i2+fuYdKHfbt2OpzSHnLxQ0eQ?=
 =?us-ascii?Q?uY8FXPp/Q1htJkQ3CH3LSz88wPibTDLpJTGs3yFlkg7F6pM7Th79mx3xJJzk?=
 =?us-ascii?Q?Z+KPXLrUTBlH4v3hrVGhjVVsuPMWEqSz5eL8f/7fI7RlXi1dsx6Z4vro66H1?=
 =?us-ascii?Q?JJF8YNcQgZil+o99HG6stqTIhb5gNecG88J7cOW86fhHN9AQ9A3wyq4W2wRC?=
 =?us-ascii?Q?plq9+15LaYS8X9hobMz0WvfQFQw8asa9dhoo84GSsmhBf2tdiRALbHns3sUy?=
 =?us-ascii?Q?/3OgW7XPGniQCLsxZOjerKjtZTpGKj0Roz3TD/jDzYk9YFSB+S+KGhnlzHVe?=
 =?us-ascii?Q?/nC934uk4xj4KWBCDRB7UrPwEF/FMhAnCXTQI33ald43I5rM20IkNgsg29+L?=
 =?us-ascii?Q?6/HMu0MuzEM2OJN6wp8/zZ9sqxSw70Gf1imV3fyt/XKJAUCaWnpGRr4/lJxK?=
 =?us-ascii?Q?2x8o7rtLLon9vAQl0LeMwPaz+qngVqzDRURRM8MqiWHtmzzXpUIVgr3m9hru?=
 =?us-ascii?Q?kfYXvx4H289TOTjnncW6V4J3GnmpuShOL7Q8aKWhko1gI8nIjutwMKbVJub8?=
 =?us-ascii?Q?Pt1H377RZevPN96I5lp/6emoqct6smBIuFjaaF/xnFnaNhAWMar9KnBwaZrx?=
 =?us-ascii?Q?oVjss8mLkFKXo/EBIcpq3B5RBofKdgXdt4CRyWgiP11TILyhYIbHVGKpaJxq?=
 =?us-ascii?Q?2fok+9ImFX2hWF9xb7bZWfrIEqQRV23LmlVwJXsbNDbwCVILeJnrhLrB9ObB?=
 =?us-ascii?Q?Favy5AUGWkq7dsYpK6I2Tmo=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <F72DF8E1CFC9A6449ECDBA551AC6FC8E@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR04MB8037.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 036f1029-5a69-4c3c-cf97-08dac2f8834c
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Nov 2022 08:49:43.6405
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /MAKaBdO5OeG7wON2jp/OClf9WZh2Hc5Pt24WUasMc9PDlvLnmi2euy1UwF2RGcbITHWBGh7e/hRgs+STXOjGBpNoavDkLeFhpGfrqRzjYw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR04MB6485
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Nov 09, 2022 / 10:06, Darrick J. Wong wrote:

...

> I don't think it's valid to remove a test from the auto group because it
> uncovers bugs.  If test runner folks want to put it in their own exclude
> lists for their own convenience, that's fine with me.

I see, then removing the test case from auto group may not be a good idea.
I will set the test case to my exclude list.

--=20
Shin'ichiro Kawasaki=

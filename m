Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F2731A9781
	for <lists+linux-nfs@lfdr.de>; Thu,  5 Sep 2019 02:13:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727562AbfIEANG convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-nfs@lfdr.de>); Wed, 4 Sep 2019 20:13:06 -0400
Received: from mail-eopbgr660054.outbound.protection.outlook.com ([40.107.66.54]:51379
        "EHLO CAN01-QB1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727156AbfIEANF (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Wed, 4 Sep 2019 20:13:05 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=E3nPy9nwtm7XCMvMu63HnJDmBrBjuPyEmSO6nI43rRU/hBcDHDU8wfNd7gB698y7XPb6R48uno1AYOteANcKagLSEeuwFmNTGK7yttz61QhqGXh4hP5zhyt5ka86WpfvKd6bXGA9r5i6c5bPpQstWjMaxLgv0+NbbfTxl7AnlRoWqxYS2gzzsne9iOtFfzwRbVX9RsdiJ89pEAuR/fECUVyVLa5PDiUlQr+2LuyLqNlIqEjeLYMVeNx8kMzM5F05PqdHJOJrFGlcrJyGC8jEqFht9fAavQbOMFPkUYlzcJisXCxktKHh5g8fsnDGr5AJ62Za3XZVwNsaWyRqCAc9Tw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=98CscI05NJ9cTsSzBPy1dszZLv1nGkqSjZT8Xa7ppDU=;
 b=Y4XJ6OB6kREZR+gfjE9Cc4sIffA0k5UuQGbZnssTPnYEFh5u9qeSPc3ORDP+qP9vaoMdq3JeadsK7ECEGw8uXPF/aRUxEspItGWlyz+V40e6nLbtqY1YxnEmNN89LKZ2L6hH1q7OHBaDrH2Z+v0VRNcnrpT5jEoUUKqY4OClgKZaOEkGp0N2sVblblfVEyPIlfqD21U0iocVnWmqvVQoayGrY8MHLlM2CNVv3VokNDO8k+MmB+kJC5f3YnSFKHghFMlretxPqC4cPYuenBeXZY2nkHKXtoW96HQLxXo7ACNEOkYWDGXM2+5JcPf74j/ZE71C+Ro5JKeVt5eyOpOX7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=uoguelph.ca; dmarc=pass action=none header.from=uoguelph.ca;
 dkim=pass header.d=uoguelph.ca; arc=none
Received: from YT1PR01MB2907.CANPRD01.PROD.OUTLOOK.COM (10.255.42.216) by
 YT1PR01MB2937.CANPRD01.PROD.OUTLOOK.COM (10.255.43.14) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2220.20; Thu, 5 Sep 2019 00:13:03 +0000
Received: from YT1PR01MB2907.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::4031:c693:f53a:9ce3]) by YT1PR01MB2907.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::4031:c693:f53a:9ce3%7]) with mapi id 15.20.2199.021; Thu, 5 Sep 2019
 00:13:03 +0000
From:   Rick Macklem <rmacklem@uoguelph.ca>
To:     Olga Kornievskaia <olga.kornievskaia@gmail.com>,
        "J. Bruce Fields" <bfields@fieldses.org>
CC:     "J. Bruce Fields" <bfields@redhat.com>,
        linux-nfs <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH v5 0/9] server-side support for "inter" SSC copy
Thread-Topic: [PATCH v5 0/9] server-side support for "inter" SSC copy
Thread-Index: AQHVY2Jcg39MoyU1GESbWgASmNNYIKccNIsAgAABEVc=
Date:   Thu, 5 Sep 2019 00:13:03 +0000
Message-ID: <YT1PR01MB29074F44ABABECF04D4A18E0DDBB0@YT1PR01MB2907.CANPRD01.PROD.OUTLOOK.COM>
References: <20190808201848.36640-1-olga.kornievskaia@gmail.com>
 <20190904205015.GD14319@fieldses.org>,<CAN-5tyGcT6rCpzOB3coj4H19-BuDsBRheD=rsRHZthn7STNq0Q@mail.gmail.com>
In-Reply-To: <CAN-5tyGcT6rCpzOB3coj4H19-BuDsBRheD=rsRHZthn7STNq0Q@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=rmacklem@uoguelph.ca; 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6fe33128-90e8-4b88-ea71-08d73195d187
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600166)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:YT1PR01MB2937;
x-ms-traffictypediagnostic: YT1PR01MB2937:
x-microsoft-antispam-prvs: <YT1PR01MB29375C3AEF17102267A25F13DDBB0@YT1PR01MB2937.CANPRD01.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 015114592F
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(396003)(366004)(346002)(376002)(39860400002)(189003)(199004)(99286004)(71200400001)(71190400001)(486006)(476003)(446003)(11346002)(55016002)(66946007)(74316002)(4744005)(316002)(33656002)(52536014)(86362001)(5660300002)(66476007)(66446008)(786003)(66556008)(8936002)(25786009)(4326008)(256004)(64756008)(81166006)(8676002)(81156014)(54906003)(2906002)(6246003)(6436002)(478600001)(9686003)(14454004)(53936002)(229853002)(102836004)(76116006)(305945005)(186003)(76176011)(46003)(7696005)(6506007)(110136005);DIR:OUT;SFP:1101;SCL:1;SRVR:YT1PR01MB2937;H:YT1PR01MB2907.CANPRD01.PROD.OUTLOOK.COM;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: uoguelph.ca does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: O4O2p+QTTCip8/wReJJSibUIToFS2lm8+7jBTcDsBduNK2frAmLZccEAA8Q/fGj49N7KazSmve1KYNjLi1+T5HGJG825Q/vl0T5q0hsHmRtbYJOBl46ycOhmGNLNty7vclxSApgap/nWL+n7cOXgGrin7CuPD74sWk3EiLL6xTMZeUkBbCZWOavBev9LNbb1w/C8RHl8Cyv+j4CZ0OpT6XTkTGQPvr6KuPwfDHfmGUC9Uw5tKLH75wtB2n9zk/N8f5Z9swuVWQDNoZCSjE1oxUAvgY43b6YNL+HUJCo0FMtaoW/TAh1+/E0iWGzgUbIQIbNjDkD0Onjp5sq3Z8+K+gTrVe7wF4FnzXPZCYhJBWbqFQpV4tzl2m2gLIthSansDQwYMXEF+Fg3IPPB7k45E/jrqMbTr4Ak3MuB0NA1mfg=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-OriginatorOrg: uoguelph.ca
X-MS-Exchange-CrossTenant-Network-Message-Id: 6fe33128-90e8-4b88-ea71-08d73195d187
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Sep 2019 00:13:03.0698
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: be62a12b-2cad-49a1-a5fa-85f4f3156a7d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QLNDF2rRK5e5H07uBaQtRJEPX0rfAg6jhJrrnMOQzVkh9ACa5GwQ9DpvgZG8pv/xwOh75PgonUHLH0BC88bt3Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YT1PR01MB2937
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

>Olga Kornievskaia wrote:
>On Wed, Sep 4, 2019 at 4:50 PM J. Bruce Fields <bfields@fieldses.org> wrote:
>>
>> What do we know about the status of NFSv4.2 and COPY support on Netapp
>> or other servers?  In either the single-server or inter-server cases?
>
>I'm unaware of any other (current/on-going) implementations. Netapp is
>interested in having (implementing) this 4.2 feature though (single
>server case for sure not sure about the inter-server).

Just fyi, I have implemented the single-server case for FreeBSD. (The code is
currently in a projects area of the FreeBSD subversion repository, which makes
it a little awkward to set up for testing at this point, but if anyone is interested,
just email me.)

I haven't yet implemented the async case, but plan on doing so soon, rick


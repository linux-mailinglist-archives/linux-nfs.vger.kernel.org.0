Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 78E02ABC8A
	for <lists+linux-nfs@lfdr.de>; Fri,  6 Sep 2019 17:32:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388663AbfIFPcE convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-nfs@lfdr.de>); Fri, 6 Sep 2019 11:32:04 -0400
Received: from mail-eopbgr660053.outbound.protection.outlook.com ([40.107.66.53]:53461
        "EHLO CAN01-QB1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725871AbfIFPcE (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Fri, 6 Sep 2019 11:32:04 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gkA9DP+wcBLQP2f92IBvWWIeka/AKBr3PgBInFgE1i5dQ0Ug2UsmuzE4GdH4K0XjkUcg0mU01YokXvFtMDgmM+qeinhwDA/+Ae9b6Y2qLjiLQ61Es8LTi/HteT5tLhDas5nxvWaq591TsOIit3+mEFMLGdg4j3DAizZsLH0cX6Chutj0B0jwnMaGHjxKfdnGleSKVhOwXpbC2rTVyujt7c2yr1ZREP8lwJBxtuF0b1bkWa4jM1L7M8XonIPrK0NUTH/wc08j5c9B3pg8NziUL4NoOjZ2BXAJ8m9iWJ2vv8YQRKnSuQ14RSNmFEtBF8cSCbd9+XprWvss6tP0IK/Wjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bKIZHMkaGGbr1bIBcaGflVaaINwx7BSyg+HrOnZ+sj8=;
 b=HQ6voW57yZNLMTNVwgzKwx0nNju//alVYnYQYQz0ow3LNXjfgTBjsbEMt3SYOBINdY+plW0KugaEY/b2zSIXLJlZTPTNUSgbjFdc7aC4FvCkHE10FWIl9aCQ5J0j/FINQrN061BBY8h8FS528cvh/OiZnZuTBGWwMJBiH5LIxNp+Nj3dQr7q1TDdZWC0saQ7nrX07bUWoAa565TJzJ720UHFv0zFaZAbtXDXvg6is6bxAawEHJGttQ6TNo0whR+mHLQf7YZKJHKco54AZ0GS2gu2uGpK9MMcILHLlZten/WcEu8yooI6+50ugxrRCwwQ/XM4JN7jWqH9giT50iLKgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=uoguelph.ca; dmarc=pass action=none header.from=uoguelph.ca;
 dkim=pass header.d=uoguelph.ca; arc=none
Received: from YT1PR01MB2907.CANPRD01.PROD.OUTLOOK.COM (10.255.42.216) by
 YT1PR01MB3626.CANPRD01.PROD.OUTLOOK.COM (10.255.41.23) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2241.15; Fri, 6 Sep 2019 15:32:01 +0000
Received: from YT1PR01MB2907.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::4031:c693:f53a:9ce3]) by YT1PR01MB2907.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::4031:c693:f53a:9ce3%7]) with mapi id 15.20.2241.018; Fri, 6 Sep 2019
 15:32:01 +0000
From:   Rick Macklem <rmacklem@uoguelph.ca>
To:     Olga Kornievskaia <olga.kornievskaia@gmail.com>
CC:     "J. Bruce Fields" <bfields@fieldses.org>,
        "J. Bruce Fields" <bfields@redhat.com>,
        linux-nfs <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH v5 0/9] server-side support for "inter" SSC copy
Thread-Topic: [PATCH v5 0/9] server-side support for "inter" SSC copy
Thread-Index: AQHVY2Jcg39MoyU1GESbWgASmNNYIKccNIsAgAABEVeAAoDhgIAAElOR
Date:   Fri, 6 Sep 2019 15:32:01 +0000
Message-ID: <YT1PR01MB29073642E8A8630E6E1C38D2DDBA0@YT1PR01MB2907.CANPRD01.PROD.OUTLOOK.COM>
References: <20190808201848.36640-1-olga.kornievskaia@gmail.com>
 <20190904205015.GD14319@fieldses.org>
 <CAN-5tyGcT6rCpzOB3coj4H19-BuDsBRheD=rsRHZthn7STNq0Q@mail.gmail.com>
 <YT1PR01MB29074F44ABABECF04D4A18E0DDBB0@YT1PR01MB2907.CANPRD01.PROD.OUTLOOK.COM>,<CAN-5tyEqPsybNe_e4XLqxRNygo1ci446Wq0jvVEFEBhip-eXdg@mail.gmail.com>
In-Reply-To: <CAN-5tyEqPsybNe_e4XLqxRNygo1ci446Wq0jvVEFEBhip-eXdg@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=rmacklem@uoguelph.ca; 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2aa9d93d-3b53-49e2-75ec-08d732df5d3e
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600166)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:YT1PR01MB3626;
x-ms-traffictypediagnostic: YT1PR01MB3626:
x-microsoft-antispam-prvs: <YT1PR01MB362640BE49DBC6A08C7F7BADDDBA0@YT1PR01MB3626.CANPRD01.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 0152EBA40F
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(979002)(346002)(366004)(136003)(396003)(39860400002)(376002)(189003)(199004)(54906003)(66446008)(7696005)(86362001)(66946007)(66476007)(64756008)(66556008)(76116006)(229853002)(5660300002)(102836004)(4326008)(478600001)(6506007)(6246003)(305945005)(76176011)(53936002)(71190400001)(786003)(316002)(71200400001)(256004)(25786009)(99286004)(74316002)(8936002)(6436002)(486006)(2906002)(9686003)(55016002)(46003)(186003)(6916009)(52536014)(11346002)(8676002)(14454004)(446003)(476003)(33656002)(81166006)(81156014)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1101;SCL:1;SRVR:YT1PR01MB3626;H:YT1PR01MB2907.CANPRD01.PROD.OUTLOOK.COM;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: uoguelph.ca does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: FN+wadK4iMquitKOOdfOozGRzPv6yRvAWMIUs5Q6zjXbLBhvKAWUdT/1R5KHC9LImxxFuhOa3YQL6+IzmQz8tdMdP8J/CyQ+M7oJisdUDTAzmvdhDZ5FCMI81lK1s5GUIC0DqQgZ+hYNtRAP62fXOVXQMSmIPgky5/lMYNwypaaBB4AosKie6VOpBuTOXEGHDvrR3ClDEyoKQ7N637I8GAlSz4mgt/7CNfvO7O1DMn7aMq0JmHu3O4wIYdN618Z6QUh74Bq3vzXFICJNi+4F0BJUixDF5ShC5WEbs7lHwyyN4UlBM1STFf57A2aFdai+phYDZYiu/A6+q6qUBSKsfLo9YgMcejEHvpVCmUCEiFZ8th8nVID1wQjME44AWZd/Srm3Ux56ijyDRquVeXo7sZQB6A/MgzPgGhcj4kBj7UU=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-OriginatorOrg: uoguelph.ca
X-MS-Exchange-CrossTenant-Network-Message-Id: 2aa9d93d-3b53-49e2-75ec-08d732df5d3e
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Sep 2019 15:32:01.8545
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: be62a12b-2cad-49a1-a5fa-85f4f3156a7d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VKznh/+jJ3URM+PzSUvWHj01npnU+xVC0Uris0m8S6vikyq4sys7XiqhWPAfI15AZN0HqR0elHuINKNPoqAkpg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YT1PR01MB3626
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Olga Kornievskaia wrote:
>On Wed, Sep 4, 2019 at 8:13 PM Rick Macklem <rmacklem@uoguelph.ca> wrote:
>>
>> >Olga Kornievskaia wrote:
>> >On Wed, Sep 4, 2019 at 4:50 PM J. Bruce Fields <bfields@fieldses.org> wrote:
>> >>
>> >> What do we know about the status of NFSv4.2 and COPY support on Netapp
>> >> or other servers?  In either the single-server or inter-server cases?
>> >
>> >I'm unaware of any other (current/on-going) implementations. Netapp is
>> >interested in having (implementing) this 4.2 feature though (single
>> >server case for sure not sure about the inter-server).
>>
>> Just fyi, I have implemented the single-server case for FreeBSD. (The code is
>> currently in a projects area of the FreeBSD subversion repository, which makes
>> it a little awkward to set up for testing at this point, but if anyone is interested,
>> just email me.)
>
>That's great Rick. Have you done any interoperability with the linux
implementation?
Not yet, but I am planning on doing so soon.

> Will the code go into the main freeBSD release (or is
>already there)?
Not there yet. My target is FreeBSD13.

rick


> I haven't yet implemented the async case, but plan on doing so soon, rick

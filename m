Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB0282A31E1
	for <lists+linux-nfs@lfdr.de>; Mon,  2 Nov 2020 18:45:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725817AbgKBRpv (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 2 Nov 2020 12:45:51 -0500
Received: from mail-bn8nam11on2129.outbound.protection.outlook.com ([40.107.236.129]:54560
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725768AbgKBRpv (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Mon, 2 Nov 2020 12:45:51 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CYcY4qcMK0Khy7eeNACoaeqzLcz95iiodFx/rKyI9ZIrI2mYEaeXfBGOWo+QEDfJAWynUuDUoxjtG1zmZFjjSWRs2/zYDluPqSX0WnvRHUG3u6/MBtZn7ZtYTkjVTJu8aU0CRGihHiAdygQiFHUWbP6jE0FZkVVo6btWHgFZyJ5GbsihFMykcGEegRrOK9RCwvCHjpmZujeDrFt4XakMEeOWZd1Y8yLQu2l2UopJ9iOEvU3gXxsyJMAsxltgsuDemYAtGJLLmvu53aSlVuiK8tHmzDx1N1j23A9kcIMWvWb8UOydGcu3aZLHDhXWOaSM0NqHUZ51ZStMKwd5THXs7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lqPRKiTGyFwJdgQaxjb64MtyvmzURAP1GMsPEYDXUz0=;
 b=fx6WzuWxk64EKHpAJO0PprTeoCm6SVkXmD5/rTZcQYuRU7SdhT3Kv3s/iIaKcT73soi0zsig0Tyn/VKM6W/XZqjSZUOx52h1bsreBWqQ/0RmCNIejG1NClcIDFxuSK7fi9NIjgjJG68FFXoIf2OAXjsd/YRKhkCtooQdlyEYRqFDej3D2VVFpVt6lT4zF8YNoBxAGlisrYB+aT8fbP+zhxRearTk++X3FePwxn17tRGOTKE/sGhnFiv3PDmgvnuPnxndtQTsTQv7aKN1144ie9HDf0ika2u/IS1g3iBpKMY12J0+hHlcU1f0cAipgM9xaWwCg025AjoGJQSBgjJOBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lqPRKiTGyFwJdgQaxjb64MtyvmzURAP1GMsPEYDXUz0=;
 b=G/c7iDPi8R60PGd3IEP2XW7kIIbwyAbrokBK7bR/0YYF8MjnDKuZCBu+B2hf5v+nrgz7+/aeOrpnTEneHbdn5iRTHqSjJPs4GBefBJ+3pnsqTKfF5hCCDbQj8CDJW4idkK63XxOjmecRrExI72y1DZcQ0N4h52PMGQr5yqXFOyw=
Received: from MN2PR13MB3957.namprd13.prod.outlook.com (2603:10b6:208:263::11)
 by BL0PR13MB4449.namprd13.prod.outlook.com (2603:10b6:208:1cb::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3541.10; Mon, 2 Nov
 2020 17:45:48 +0000
Received: from MN2PR13MB3957.namprd13.prod.outlook.com
 ([fe80::e989:f666:131a:e210]) by MN2PR13MB3957.namprd13.prod.outlook.com
 ([fe80::e989:f666:131a:e210%9]) with mapi id 15.20.3541.010; Mon, 2 Nov 2020
 17:45:48 +0000
From:   Trond Myklebust <trondmy@hammerspace.com>
To:     "anna.schumaker@netapp.com" <anna.schumaker@netapp.com>,
        "solomonchenclever@gmail.com" <solomonchenclever@gmail.com>
CC:     "chenwenle@huawei.com" <chenwenle@huawei.com>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "solachenclever@hotmail.com" <solachenclever@hotmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "nixiaoming@huawei.com" <nixiaoming@huawei.com>,
        "solachenclever@gmail.com" <solachenclever@gmail.com>
Subject: Re: [PATCH 2/2] NFS: Limit the number of retries
Thread-Topic: [PATCH 2/2] NFS: Limit the number of retries
Thread-Index: AQHWsTSzGjVbwL1P20Koha6ceevLkqm1HZMA
Date:   Mon, 2 Nov 2020 17:45:48 +0000
Message-ID: <8db50c039cb8b8325bb428c60ff005b899654fb4.camel@hammerspace.com>
References: <20201102162438.14034-1-chenwenle@huawei.com>
         <20201102162438.14034-3-chenwenle@huawei.com>
In-Reply-To: <20201102162438.14034-3-chenwenle@huawei.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: netapp.com; dkim=none (message not signed)
 header.d=none;netapp.com; dmarc=none action=none header.from=hammerspace.com;
x-originating-ip: [68.36.133.222]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f3bf4fd2-2732-4dbf-9806-08d87f57220e
x-ms-traffictypediagnostic: BL0PR13MB4449:
x-microsoft-antispam-prvs: <BL0PR13MB444907CFAFA468A598556344B8100@BL0PR13MB4449.namprd13.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3044;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: WhP5ZOTQAi0wznTk2UzduF2TkZVstO/B0nhKf6YralzaA1PvalqqsLlNGZvk6rq3gy9bhDoLMjgdYIL70PAFCzs17i63hoH/DGqytcsQrW73aqRtP7ed7iWiFI6703VRKFr9niUredFFgAVtg9WmhKUubWSCQkYJEf60k32Ql1mRvhZ7SG5tC272mx1mLORhbbjR2W0TwXi3cxqIV7JPNLFDqswGrfeh73+DR+WtskB8lHCvqAKN5wb42Jv43m93C7p7O2Qr7iCa1G76vyUsSexZaIqro+fM4MO8XecRaQiJGClDnk4Mp8ivcYZ3d/S26NxOmwTtwN/JziIdRnZg4Q==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR13MB3957.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(39830400003)(136003)(366004)(376002)(346002)(396003)(186003)(6486002)(36756003)(71200400001)(66446008)(64756008)(66556008)(2906002)(66476007)(6512007)(66946007)(5660300002)(2616005)(8936002)(316002)(86362001)(26005)(478600001)(6506007)(54906003)(83380400001)(110136005)(76116006)(8676002)(4326008)(91956017);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: An3ruF1k48lUbS/1UzmRhEW9XZiKLRxjHYNNk8k+mP6fizPCDaRoRakl1W/UlR+lWPFug9glWwoXyEUJjzabcCioyo2HpO7skFWwVhv16i9FW7sHp/VIAVo8WiMdcZZF/T4JaV1n07aKHdMKgCmwIdvnB4Fmcm2Zi+cgBCdQOcvy/bCnzYl+bftw1ynHTZsA7sSxPKBEE35EmWN7HQeXQrMJ/aFakqxpkVifInKoOBy88c94X8iua7S+euiiXg5/pB6HU2zmtcEe40Km42yuZioC+4jtQjvWcf9M04Onb+NHqYydumEmucsfKg0LAAkpsu3dNCqg8i1Wx2AzQwX35mAYyh7WgR9fLM6vkgDh9h47jWxEXK3ik/4aF60/aqSlpzY1aa64MoZFXrRNdNL9Q+mqXXPPj6cVUl/OQTyo6hS+X+APTIEuivDHgKwAYMZG1DQ8vbbawO83IrXMxWUMSbsObcSO1JIDyC+ciY1+ErJoEqxfuCOdab1K4JNAR5Eb28XZJt69H+mlN4+zI8pekU010PHRbr33spA1tS3G+Lev7C71JsczQxlM69WcUs/FmUe6ordCa4PV6Z9rVCTLC0oBPNW4SDCedPa8M0CoQx6GEVz4uQ0mlzNzlNR02pSX51AKkWwQCjhi3jqCjfmUtQ==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <0BBB8973C3DE484881131189EFFF4159@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR13MB3957.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f3bf4fd2-2732-4dbf-9806-08d87f57220e
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Nov 2020 17:45:48.1675
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2YBXZm0VYkTqWxhBgCgWukW3u8iYJk9nojch3+UPxEXvQdH0uZFfFwns+MRoo2KOVBsWB1Cu6n1BHk2WQWuHJw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR13MB4449
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

T24gVHVlLCAyMDIwLTExLTAzIGF0IDAwOjI0ICswODAwLCBXZW5sZSBDaGVuIHdyb3RlOg0KPiDC
oCBXZSBjYW4ndCB3YWl0IGZvcmV2ZXIsIGV2ZW4gaWYgdGhlIHN0YXRlDQo+IGlzIGFsd2F5cyBk
ZWxheWVkLg0KPiANCj4gU2lnbmVkLW9mZi1ieTogV2VubGUgQ2hlbiA8Y2hlbndlbmxlQGh1YXdl
aS5jb20+DQo+IC0tLQ0KPiDCoGZzL25mcy9uZnM0cHJvYy5jIHwgNCArKystDQo+IMKgMSBmaWxl
IGNoYW5nZWQsIDMgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQ0KPiANCj4gZGlmZiAtLWdp
dCBhL2ZzL25mcy9uZnM0cHJvYy5jIGIvZnMvbmZzL25mczRwcm9jLmMNCj4gaW5kZXggZjZiNWRj
NzkyYjMzLi5iYjIzMTZiZjEzZjYgMTAwNjQ0DQo+IC0tLSBhL2ZzL25mcy9uZnM0cHJvYy5jDQo+
ICsrKyBiL2ZzL25mcy9uZnM0cHJvYy5jDQo+IEBAIC03MzkwLDE1ICs3MzkwLDE3IEBAIGludCBu
ZnM0X2xvY2tfZGVsZWdhdGlvbl9yZWNhbGwoc3RydWN0DQo+IGZpbGVfbG9jayAqZmwsIHN0cnVj
dCBuZnM0X3N0YXRlICpzdGF0ZSwNCj4gwqB7DQo+IMKgwqDCoMKgwqDCoMKgwqBzdHJ1Y3QgbmZz
X3NlcnZlciAqc2VydmVyID0gTkZTX1NFUlZFUihzdGF0ZS0+aW5vZGUpOw0KPiDCoMKgwqDCoMKg
wqDCoMKgaW50IGVycjsNCj4gK8KgwqDCoMKgwqDCoMKgaW50IHJldHJ5ID0gMzsNCj4gwqANCj4g
wqDCoMKgwqDCoMKgwqDCoGVyciA9IG5mczRfc2V0X2xvY2tfc3RhdGUoc3RhdGUsIGZsKTsNCj4g
wqDCoMKgwqDCoMKgwqDCoGlmIChlcnIgIT0gMCkNCj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqByZXR1cm4gZXJyOw0KPiDCoMKgwqDCoMKgwqDCoMKgZG8gew0KPiDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoGVyciA9IF9uZnM0X2RvX3NldGxrKHN0YXRlLCBGX1NFVExL
LCBmbCwNCj4gTkZTX0xPQ0tfTkVXKTsNCj4gLcKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oGlmIChlcnIgIT0gLU5GUzRFUlJfREVMQVkpDQo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqBpZiAoZXJyICE9IC1ORlM0RVJSX0RFTEFZIHx8IHJldHJ5ID09IDApDQo+IMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoGJyZWFrOw0KPiDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoHNzbGVlcCgxKTsNCj4gK8KgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoC0tcmV0cnk7DQo+IMKgwqDCoMKgwqDCoMKgwqB9IHdoaWxlICgxKTsNCj4g
wqDCoMKgwqDCoMKgwqDCoHJldHVybiBuZnM0X2hhbmRsZV9kZWxlZ2F0aW9uX3JlY2FsbF9lcnJv
cihzZXJ2ZXIsIHN0YXRlLA0KPiBzdGF0ZWlkLCBmbCwgZXJyKTsNCj4gwqB9DQoNClRoaXMgcGF0
Y2ggd2lsbCBqdXN0IGNhdXNlIHRoZSBsb2NrcyB0byBiZSBzaWxlbnRseSBsb3N0LCBubz8NCg0K
LS0gDQpUcm9uZCBNeWtsZWJ1c3QNCkxpbnV4IE5GUyBjbGllbnQgbWFpbnRhaW5lciwgSGFtbWVy
c3BhY2UNCnRyb25kLm15a2xlYnVzdEBoYW1tZXJzcGFjZS5jb20NCg0KDQo=

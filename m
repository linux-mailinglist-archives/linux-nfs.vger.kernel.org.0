Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F2AB03B490B
	for <lists+linux-nfs@lfdr.de>; Fri, 25 Jun 2021 20:57:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229653AbhFYS7p (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 25 Jun 2021 14:59:45 -0400
Received: from mail-bn8nam11on2096.outbound.protection.outlook.com ([40.107.236.96]:62049
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229531AbhFYS7o (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Fri, 25 Jun 2021 14:59:44 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CCrgCiCtp4Vol/PGn3h8GwFW81zKRKD/Lsx0o70X59OR947cvUTY0BOXRKBXdKTVUy5hqKlxLBsKvmRXU03JIoU1NkVm9eCeiwS5h+uNFcoor5eOTZfVon+wNVPIpxbE6XOrgQNBW4cFRzjWbg59KkZyRiK8uwDZe3nteT8BMH9wMy918vjkJwP1rD64MG/BjzQWUDcASeo3G8H03KBgJvzfW6VvA5bETovMEHoxb6U7fY4MwHP1p+Uli4UyV3gZolr1ZTgZRmTgqs5BacE8E5w+c3xKzTZAcjlUNXPMX62swP8OYAof79vLZoZPKwA1tpK42TfoyiHM/RwsUhLOFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zYRsAo4zF5hYwhE3MUv5aXuceokSs33zybGS6SwpZck=;
 b=Y08BZylbXEN1xDial1gGcg4Nt6KP8KS6P8lvaxxAxrcNlmWkQI58Sd7ojhA2cfCiVZ5XQbAscQW3N5itNkMOVSgbazEaJ7NxSKyawq5PX3wmzOiSvRsDJ9PUxqdBQYVcEIT2FI/a6SaFLzLdEgCYVpQ/sm1OjTVcyjvfT/oRHreuTzO9cin2YwCO2Fek15jG9mjSZF/I9LL80UEjxGxkP7cB2rTPfPsdzXoTsmrRqspp7U2WPqB1Rb5Vd0OION6Lw7uSfv+lvQB7BBF9gUNCk7arvY9bv/xC+LAOIWqZMGomcrQOh5c2q5wrRsuKb0+njVRU0F7mozjJHFF+67Do8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zYRsAo4zF5hYwhE3MUv5aXuceokSs33zybGS6SwpZck=;
 b=HD8SP73+D/TZcqQyViGgiNkzQ/8rXtJZrBa7jGVdimzA0i1I7Etbf1f6vuyi8FfW25+Gxw5mo9zCE+TB2nkmpflcKMjRxEhVEYpJS4NwIalg1cmh2pYyh7932gzgegfxEWX0Jhp/sfYuQHsoHa36akAHWPNktJt8oSPCJHgcQ38=
Received: from CH0PR13MB5084.namprd13.prod.outlook.com (2603:10b6:610:111::7)
 by CH2PR13MB3333.namprd13.prod.outlook.com (2603:10b6:610:23::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4287.12; Fri, 25 Jun
 2021 18:57:20 +0000
Received: from CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::cc40:f406:86f9:3e05]) by CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::cc40:f406:86f9:3e05%4]) with mapi id 15.20.4264.021; Fri, 25 Jun 2021
 18:57:20 +0000
From:   Trond Myklebust <trondmy@hammerspace.com>
To:     "chuck.lever@oracle.com" <chuck.lever@oracle.com>
CC:     "bfields@fieldses.org" <bfields@fieldses.org>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH] NFSD: Prevent a possible oops in the nfs_dirent()
 tracepoint
Thread-Topic: [PATCH] NFSD: Prevent a possible oops in the nfs_dirent()
 tracepoint
Thread-Index: AQHXadSSY72lgbY6MU6xHAIFBHV+9qsk6oSAgAAbGwCAAA6QgA==
Date:   Fri, 25 Jun 2021 18:57:20 +0000
Message-ID: <951807a3b7f8870951bd2bc4ef5a1f4f0e50fc25.camel@hammerspace.com>
References: <162463396907.1820.8112792283525036426.stgit@klimt.1015granger.net>
         <b71c76c0fb21ebb35e1f91864bbb411a4c895370.camel@hammerspace.com>
         <FB070B1F-FF5C-43B5-AFC2-0DC6B9348AC6@oracle.com>
In-Reply-To: <FB070B1F-FF5C-43B5-AFC2-0DC6B9348AC6@oracle.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: oracle.com; dkim=none (message not signed)
 header.d=none;oracle.com; dmarc=none action=none header.from=hammerspace.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b2e7360c-3d31-4ab0-74c5-08d9380b0f9d
x-ms-traffictypediagnostic: CH2PR13MB3333:
x-microsoft-antispam-prvs: <CH2PR13MB33332335BB5BF4730DA861D4B8069@CH2PR13MB3333.namprd13.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1850;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: fu6u5UuFF1Wk+2Q9XS7q7ZLD9V9Hhp5K4+9UBthctTs/B1mexGQTB0C85klGta+ipOx8VipyaC+nSZgwPs1VhBiRyq8dmW0A94zv+isfsJt38Ocm77hEGAfQrPzxXjFR8N1NXIWVcO82Bo/a9PrDDLzL5F0dbL5mO6b1G1W261EYKYGEKY8AKF64WYf53s1GJvuPUgkouSSHICPN3luJ+6MK+iTMUGZIRNgzLIUSmhtHxk7XCOeAUsI2UBCUuzbVvKPe8CUPT8xnHzsFRshlPTbMMyfK2gtMJAPDi6nvarLNFIzXUhT/PIRQvbAuM/c8WFf1xoRMa5BOeHwUJu2vRSRQdgiW6d82Qjj1zL42aIsFmI08n6l6PgB/zelIS0ETxwjtqf1LRp2c7DX+Jiphu+kLosnvYAo3+EJVyIlGYjn8srFZ4Wf2EwHK6pCwNsH+FpcMyLonrFVDvStkNEsbH6GwGuUKST+GtpZtKsxfNBJO+HCrV1+SsgjPc36T9cJGpnX1qh31F6C8R5lYE+9FV36AsBbChVzzqkkzs2HuUHh1h7N+Qhf3BrU1zWyiPU58FdwOSXjXtLhd2AnKfSquweN/fycq59AFkNIjo/dw5z54tQLTW3jxhbdglD/1RJGTD0qOb6UBVhBIaxPFuA1O8w==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR13MB5084.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(39830400003)(366004)(136003)(346002)(376002)(396003)(86362001)(83380400001)(5660300002)(186003)(8676002)(66476007)(66446008)(478600001)(64756008)(54906003)(66556008)(38100700002)(76116006)(2616005)(6512007)(66946007)(53546011)(4326008)(2906002)(6486002)(6506007)(122000001)(8936002)(316002)(71200400001)(36756003)(26005)(6916009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RjRlMS81M085MWwxTk9DMXpRWElublhycS9KbE5TWHJjeGZmR1ZRTTcyUkQ1?=
 =?utf-8?B?ZTFhc1RFbWJjenBVNDZJY2dpSzYyMEhvVmt1RDY5N1JYVzlZT3dhUHhseHJp?=
 =?utf-8?B?ZGhha1lTeXBQVGFhQ2cwNmQ4UGN0NUFoL05yM1UzVWJHVXZ5Vzk5Um85VHJy?=
 =?utf-8?B?bnQwQUNIL0lRWkM2R0VIYWFaMWNleklDTlZXYkZ0ajNpdG1pWUFhNmJyM1pZ?=
 =?utf-8?B?dlUrc25XaDhXczErL2FvVkRjSFpGY05TcU5STUZKWmtBZmVCSmdlZGJXTyt1?=
 =?utf-8?B?LzlHaWVwd3Q5UzBCWjBLR2JWNXdMbGpxSC8yOHJnMjUwMjFLWU0yNUlUYmtI?=
 =?utf-8?B?cU5jM2tveXlzMkZwVmIxMnMzTTVVUVlNR0xWU2dKVkd0cEFLRWE2Z0swM0lO?=
 =?utf-8?B?WDgxMHVuRjFwTG11MThVYU1uUGVlMlNKeENBWGJzaDlGTktDUXZDNThEbG0r?=
 =?utf-8?B?ZkxSc0dzczJlSEcrYUR4YjNYSGtwZDNCZ1Y1bnFmRTgxU01IOENtMEhTTjRK?=
 =?utf-8?B?WkJiWTN1RDBseGhPci9wc1oyVWI5ejJzOVdHbXlzV1ZOd3hLTjVjU0sxUCtZ?=
 =?utf-8?B?d3owZ1JaQWtnNTA4dFdrR05XQ3BjVXlNY0hSTUNYNnZIRFRSSmRuYlRPY1Nx?=
 =?utf-8?B?WE9uSWQ1Y3RQa0M0bkwwelVaZ2tHMU5kL2h2Qy91QUxteHpXQmx1V0N3dFV0?=
 =?utf-8?B?T1lnQWJjaGRJaXl0QWNseTNrTmM0MGhFVFlZNjRhY1lqTXR5Mnc4TlIwYUFF?=
 =?utf-8?B?NVVZelJCQy9TUHg3V05kQjVQTHNmSlIxOEtVMkRQTjM3SjRxMzJoQytxS3c0?=
 =?utf-8?B?Rm10bFZOMUhsR0FLQVcyZmltcUpXL21UaW1wUWhqT1k1azZaekRlMmJDdmpR?=
 =?utf-8?B?WFppR1pmSUZOUVVqajJjZ2hoVkp4SUF0NWRPZmRHblUzZmNZVWFkb0VwRld4?=
 =?utf-8?B?Sm9ldWpFdmJOeFphOW5kUmx0WWc0ckpBYUJka09pVGlwOXA4QXNFOVJvSGxW?=
 =?utf-8?B?dGhINklqZ2tLd0tta2J5REdsK3RmSitQajh0UitnY0sxbFJLV1JJQ1B4MFd5?=
 =?utf-8?B?Zmpwd3hwSE5TVWtYcytlRCsyTkNRUUUweFZKSlZLNDZ2OU5xY2VjYXFZY3JF?=
 =?utf-8?B?SEs0QzNhVkhTQkQrWDZCTEJtQjBoTVJDRytwOEhGbFgxREs2YzN0K0owWDEy?=
 =?utf-8?B?ZkQ0bk1nYXYxQytJQTVzM0M4UndVZDhUOTJ5TTBSUU96OUxQVXJzaWRTcDNr?=
 =?utf-8?B?OURtclRBQVhlMEVLMkY1TkZ1N25xS0IzNXF3Um1GTTJhUGw5UENGQ3ZRMWZU?=
 =?utf-8?B?WHRLMFNob1RYZVpsdFZCdzY2QzBBQXFIUjJoLzBtajJHSEZYQlU2bVpGZ1JE?=
 =?utf-8?B?bEVkdkhndXBob2kzVU9DdnhBUnlXNkFINXV2WEEyNGFZcXlTSm93TlZrVjZY?=
 =?utf-8?B?SHRNbHdTZlFmamdqaW1iUUdKSjdXU3RiSmlKT1NQRWhsUWVWallQZGN2cHUx?=
 =?utf-8?B?RlZOOTBUWExpVGlTSmtkczJIWHpwRkRzYmNjRnN6YXNWN0dOVkpjc1BMbnFB?=
 =?utf-8?B?ekNUM2pXcXhIZVRSWXZHUGhiNDB6UCtvaGxtMDZySVVVc1J2TURGQkZBOGdI?=
 =?utf-8?B?T3FnZUFTbDlRaDF5K3FKaDBVSmxPQnFoZGtrblp3VGNpVjJIRVBnUWR3YWo0?=
 =?utf-8?B?ZEs2eFlzZkVneGt6TFlEZjBqZkRTZHlKWGV3UFk1Wk1UZFBNQWZ1U1ZDeGVJ?=
 =?utf-8?Q?xJNmc+2nFciHtDW0KzMgY/VCZt1UvzedaaTR7XV?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <3F35D3FDED6EE7439D19DD347FEBBCA1@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR13MB5084.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b2e7360c-3d31-4ab0-74c5-08d9380b0f9d
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Jun 2021 18:57:20.6592
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rNAuDbC0f6mWm3qMyWRvmumFbiu273seF8ytnnEUHCjxMpFhE+ab7y011v9/Qov5o+PV/w1P+jm/1OzVZCnkAw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR13MB3333
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

T24gRnJpLCAyMDIxLTA2LTI1IGF0IDE4OjA1ICswMDAwLCBDaHVjayBMZXZlciBJSUkgd3JvdGU6
DQo+IA0KPiANCj4gPiBPbiBKdW4gMjUsIDIwMjEsIGF0IDEyOjI4IFBNLCBUcm9uZCBNeWtsZWJ1
c3QNCj4gPiA8dHJvbmRteUBoYW1tZXJzcGFjZS5jb20+IHdyb3RlOg0KPiA+IA0KPiA+IE9uIEZy
aSwgMjAyMS0wNi0yNSBhdCAxMToxMiAtMDQwMCwgQ2h1Y2sgTGV2ZXIgd3JvdGU6DQo+ID4gPiBU
aGUgZG91YmxlIGNvcHkgb2YgdGhlIHN0cmluZyBpcyBhIG1pc3Rha2UsIHBsdXMgX19hc3NpZ25f
c3RyKCkNCj4gPiA+IHVzZXMgc3RybGVuKCksIHdoaWNoIGlzIHdyb25nIHRvIGRvIG9uIGEgc3Ry
aW5nIHRoYXQgaXNuJ3QNCj4gPiA+IGd1YXJhbnRlZWQgdG8gYmUgTlVMLXRlcm1pbmF0ZWQuDQo+
ID4gPiANCj4gPiA+IEZpeGVzOiA2MDE5Y2UwNzQyY2EgKCJORlNEOiBBZGQgYSB0cmFjZXBvaW50
IHRvIHJlY29yZCBkaXJlY3RvcnkNCj4gPiA+IGVudHJ5IGVuY29kaW5nIikNCj4gPiA+IFNpZ25l
ZC1vZmYtYnk6IENodWNrIExldmVyIDxjaHVjay5sZXZlckBvcmFjbGUuY29tPg0KPiA+ID4gLS0t
DQo+ID4gPiDCoGZzL25mc2QvdHJhY2UuaCB8wqDCoMKgIDEgLQ0KPiA+ID4gwqAxIGZpbGUgY2hh
bmdlZCwgMSBkZWxldGlvbigtKQ0KPiA+ID4gDQo+ID4gPiBkaWZmIC0tZ2l0IGEvZnMvbmZzZC90
cmFjZS5oIGIvZnMvbmZzZC90cmFjZS5oDQo+ID4gPiBpbmRleCAyN2E5M2ViZDFkODAuLjg5ZGNj
Y2VkNTI2YSAxMDA2NDQNCj4gPiA+IC0tLSBhL2ZzL25mc2QvdHJhY2UuaA0KPiA+ID4gKysrIGIv
ZnMvbmZzZC90cmFjZS5oDQo+ID4gPiBAQCAtNDA4LDcgKzQwOCw2IEBAIFRSQUNFX0VWRU5UKG5m
c2RfZGlyZW50LA0KPiA+ID4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIF9fZW50cnkt
PmlubyA9IGlubzsNCj4gPiA+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBfX2VudHJ5
LT5sZW4gPSBuYW1sZW47DQo+ID4gPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgbWVt
Y3B5KF9fZ2V0X3N0cihuYW1lKSwgbmFtZSwgbmFtbGVuKTsNCj4gPiA+IC3CoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgIF9fYXNzaWduX3N0cihuYW1lLCBuYW1lKTsNCj4gPiA+IMKgwqDCoMKg
wqDCoMKgICksDQo+ID4gPiDCoMKgwqDCoMKgwqDCoCBUUF9wcmludGsoImZoX2hhc2g9MHglMDh4
IGlubz0lbGx1IG5hbWU9JS4qcyIsDQo+ID4gPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqAgX19lbnRyeS0+ZmhfaGFzaCwgX19lbnRyeS0+aW5vLA0KPiA+ID4gDQo+ID4gPiANCj4gPiAN
Cj4gPiBXaHkgbm90IGp1c3Qgc3RvcmUgaXQgYXMgYSBOVUwgdGVybWluYXRlZCBzdHJpbmcgYW5k
IHNhdmUgYSBmZXcgYnl0ZXMNCj4gPiBieSBnZXR0aW5nIHJpZCBvZiB0aGUgaW50ZWdlci1zaXpl
ZCBzdG9yYWdlIG9mIHRoZSBsZW5ndGg/DQo+IA0KPiBTdGVwaGVuIGlzIGFkZGluZyBzb21lIGhl
bHBlcnMgdG8gZG8gdGhhdCBpbiB0aGUgbmV4dCBtZXJnZQ0KPiB3aW5kb3cuIEZvciBub3csIEkg
bmVlZCB0byBmaXggdGhpcyBvb3BzLCBhbmQgdGhpcyBpcyB0aGUNCj4gZmFzdGVzdCB3YXkgdG8g
ZG8gdGhhdC4NCg0KDQpXb24ndCB0aGlzIHN1ZmZpY2U/DQo4PC0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLQ0KZGlmZiAtLWdpdCBhL2ZzL25mc2QvdHJhY2UuaCBiL2ZzL25m
c2QvdHJhY2UuaA0KaW5kZXggMjdhOTNlYmQxZDgwLi43OTkxNjg3NzRjY2YgMTAwNjQ0DQotLS0g
YS9mcy9uZnNkL3RyYWNlLmgNCisrKyBiL2ZzL25mc2QvdHJhY2UuaA0KQEAgLTQwMCwxOSArNDAw
LDE3IEBAIFRSQUNFX0VWRU5UKG5mc2RfZGlyZW50LA0KIAlUUF9TVFJVQ1RfX2VudHJ5KA0KIAkJ
X19maWVsZCh1MzIsIGZoX2hhc2gpDQogCQlfX2ZpZWxkKHU2NCwgaW5vKQ0KLQkJX19maWVsZChp
bnQsIGxlbikNCi0JCV9fZHluYW1pY19hcnJheSh1bnNpZ25lZCBjaGFyLCBuYW1lLCBuYW1sZW4p
DQorCQlfX2R5bmFtaWNfYXJyYXkodW5zaWduZWQgY2hhciwgbmFtZSwgbmFtbGVuICsgMSkNCiAJ
KSwNCiAJVFBfZmFzdF9hc3NpZ24oDQogCQlfX2VudHJ5LT5maF9oYXNoID0gZmhwID8ga25mc2Rf
ZmhfaGFzaCgmZmhwLT5maF9oYW5kbGUpIDogMDsNCiAJCV9fZW50cnktPmlubyA9IGlubzsNCi0J
CV9fZW50cnktPmxlbiA9IG5hbWxlbjsNCiAJCW1lbWNweShfX2dldF9zdHIobmFtZSksIG5hbWUs
IG5hbWxlbik7DQotCQlfX2Fzc2lnbl9zdHIobmFtZSwgbmFtZSk7DQorCQlfX2dldF9zdHIobmFt
ZSlbbmFtbGVuXSA9IDA7DQogCSksDQotCVRQX3ByaW50aygiZmhfaGFzaD0weCUwOHggaW5vPSVs
bHUgbmFtZT0lLipzIiwNCisJVFBfcHJpbnRrKCJmaF9oYXNoPTB4JTA4eCBpbm89JWxsdSBuYW1l
PSVzIiwNCiAJCV9fZW50cnktPmZoX2hhc2gsIF9fZW50cnktPmlubywNCi0JCV9fZW50cnktPmxl
biwgX19nZXRfc3RyKG5hbWUpKQ0KKwkJX19nZXRfc3RyKG5hbWUpKQ0KICkNCiANCiAjaW5jbHVk
ZSAic3RhdGUuaCINCg0KDQotLSANClRyb25kIE15a2xlYnVzdA0KTGludXggTkZTIGNsaWVudCBt
YWludGFpbmVyLCBIYW1tZXJzcGFjZQ0KdHJvbmQubXlrbGVidXN0QGhhbW1lcnNwYWNlLmNvbQ0K
DQoNCg==

Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1605A23FC0
	for <lists+linux-nfs@lfdr.de>; Mon, 20 May 2019 19:59:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726566AbfETR7F (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 20 May 2019 13:59:05 -0400
Received: from mail-eopbgr770058.outbound.protection.outlook.com ([40.107.77.58]:33522
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726990AbfETR7F (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Mon, 20 May 2019 13:59:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=netapp.onmicrosoft.com; s=selector2-netapp-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GcrDmKZct75wPRBoNi+lPlwJz2XcC+YJhfZaMfkRjgQ=;
 b=teGZQqwQ5JnynKfBMNfUKqjnmwQXYW/h7F03jiN4WNg1p2uBwqPzmIqHFF4kYt1g79m95JHOyJTZbdo5+6xrGkNxaUo8iZel4VZOhn3UDXNXXytEkqjgy2ShLooig42Si8kmsNo3E18ETZ+I7JLYvM6PaXPTDSz0antj6vvcl0s=
Received: from BN8PR06MB6228.namprd06.prod.outlook.com (20.178.217.156) by
 BN8PR06MB5730.namprd06.prod.outlook.com (20.179.136.222) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1900.18; Mon, 20 May 2019 17:59:02 +0000
Received: from BN8PR06MB6228.namprd06.prod.outlook.com
 ([fe80::7d92:449d:f9a5:fee2]) by BN8PR06MB6228.namprd06.prod.outlook.com
 ([fe80::7d92:449d:f9a5:fee2%3]) with mapi id 15.20.1900.020; Mon, 20 May 2019
 17:59:02 +0000
From:   "Schumaker, Anna" <Anna.Schumaker@netapp.com>
To:     "bfields@fieldses.org" <bfields@fieldses.org>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "zhangxiaoxu5@huawei.com" <zhangxiaoxu5@huawei.com>,
        "jlayton@kernel.org" <jlayton@kernel.org>,
        "trond.myklebust@hammerspace.com" <trond.myklebust@hammerspace.com>,
        "davem@davemloft.net" <davem@davemloft.net>
Subject: Re: [PATCH] SUNRPC: task should be exit if encode return EKEYEXPIRED
 more times
Thread-Topic: [PATCH] SUNRPC: task should be exit if encode return EKEYEXPIRED
 more times
Thread-Index: AQHU/m3iodwbStmJ+kyzhj0PFigq46ZahMUAgA3aY4CADA9jAA==
Date:   Mon, 20 May 2019 17:59:01 +0000
Message-ID: <ef9ea7a98c8c4ac90c53d476df215ff6c866529a.camel@netapp.com>
References: <1556530351-81780-1-git-send-email-zhangxiaoxu5@huawei.com>
         <dd163a59-eb34-242a-052d-eb0ac4d4a9e8@huawei.com>
         <f3fcad81-1a0f-a59b-d67b-7d8a541be2c8@huawei.com>
In-Reply-To: <f3fcad81-1a0f-a59b-d67b-7d8a541be2c8@huawei.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.32.2 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Anna.Schumaker@netapp.com; 
x-originating-ip: [73.145.169.100]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: fb753626-4698-4ca7-0c4e-08d6dd4cd77d
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(2017052603328)(7193020);SRVR:BN8PR06MB5730;
x-ms-traffictypediagnostic: BN8PR06MB5730:
x-microsoft-antispam-prvs: <BN8PR06MB5730ED62C3DF5713CABFACB2F8060@BN8PR06MB5730.namprd06.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-forefront-prvs: 004395A01C
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(979002)(39860400002)(346002)(366004)(376002)(136003)(396003)(189003)(199004)(102836004)(11346002)(2616005)(476003)(446003)(14444005)(256004)(6506007)(53546011)(86362001)(58126008)(110136005)(73956011)(71200400001)(71190400001)(91956017)(486006)(72206003)(305945005)(478600001)(76116006)(316002)(66946007)(2501003)(76176011)(186003)(66446008)(64756008)(66556008)(66476007)(26005)(99286004)(6512007)(118296001)(25786009)(229853002)(6486002)(6436002)(5660300002)(68736007)(2201001)(2906002)(36756003)(14454004)(81166006)(66066001)(7736002)(81156014)(8676002)(6246003)(6116002)(3846002)(8936002)(53936002)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1101;SCL:1;SRVR:BN8PR06MB5730;H:BN8PR06MB6228.namprd06.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: netapp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: JCPu8+oqCGJutav2puRZ6g4TzMWO3mIp8xC9gbJFjvn2sToKas4WMvgaeIRz/ZG4iFrOCF4o5Kepav7Q2k7SYay7NwtV7q/3cHh0v35i0Ve6hlszBtB9fK+deEClBZAu0C2kmJ+RQ1omYP8YSEY6i7fwoGLRhbY1Es4oki/7SyOBMeD5HHoRfkTTEqAye18J9GvETdg0U/23jBjNpBYTzRV4dG0Iuyhc8Fu3bLeD6XL9zEU2BgUu/NqIDSFONcrVsxo5LqsSsip8tVRBUKoIH+GeamREXvd8o6yk25DJC0Cix0RneNlOsDK1Unpvi/Efdp6QrePXFBw7DsyKGXg1WbOK9Zy1MjB+kEkkoG7RxmS7XRUc++JbM5SgTErquovkNNK0fQsSSAsfa3/HCmyif+NZqxZurZiq3yKiLEgNy4w=
Content-Type: text/plain; charset="utf-8"
Content-ID: <3DE79289ACB2CB43A4EB2BB59B42EA9A@namprd06.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: netapp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fb753626-4698-4ca7-0c4e-08d6dd4cd77d
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 May 2019 17:59:02.0114
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4b0911a0-929b-4715-944b-c03745165b3a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR06MB5730
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

SGkgWmhhbmdYaWFveHUNCg0KQm90aCBvZiB5b3VyIHBhdGNoZXMgaGF2ZSBiZWVuIG1lcmdlZCBp
bnRvIExpbnV4IDUuMi1yYzEuDQoNClRoYW5rcyBmb3IgY2hlY2tpbmchDQpBbm5hDQoNCk9uIE1v
biwgMjAxOS0wNS0xMyBhdCAwOTo0OCArMDgwMCwgemhhbmd4aWFveHUgKEEpIHdyb3RlOg0KPiBw
aW5nLg0KPiANCj4gT24gNS80LzIwMTkgMjoxNSBQTSwgemhhbmd4aWFveHUgKEEpIHdyb3RlOg0K
PiA+IHBpbmcuDQo+ID4gDQo+ID4gT24gNC8yOS8yMDE5IDU6MzIgUE0sIFpoYW5nWGlhb3h1IHdy
b3RlOg0KPiA+ID4gSWYgdGhlIHJwYy5nc3NkIGFsd2F5cyByZXR1cm4gY3JlZCBzdWNjZXNzLCBi
dXQgbm93IHRoZSBjcmVkIGlzDQo+ID4gPiBleHBpcmVkLCB0aGVuIHRoZSB0YXNrIHdpbGwgbG9v
cCBpbiBjYWxsX3JlZnJlc2ggYW5kIGNhbGxfdHJhbnNtaXQuDQo+ID4gPiANCj4gPiA+IEV4aXQg
dGhlIHJwYyB0YXNrIGFmdGVyIHJldHJ5Lg0KPiA+ID4gDQo+ID4gPiBTaWduZWQtb2ZmLWJ5OiBa
aGFuZ1hpYW94dSA8emhhbmd4aWFveHU1QGh1YXdlaS5jb20+DQo+ID4gPiAtLS0NCj4gPiA+ICAg
bmV0L3N1bnJwYy9jbG50LmMgfCA5ICsrKysrKysrLQ0KPiA+ID4gICAxIGZpbGUgY2hhbmdlZCwg
OCBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0pDQo+ID4gPiANCj4gPiA+IGRpZmYgLS1naXQg
YS9uZXQvc3VucnBjL2NsbnQuYyBiL25ldC9zdW5ycGMvY2xudC5jDQo+ID4gPiBpbmRleCA4ZmYx
MWRjLi5hMzJkM2YxIDEwMDY0NA0KPiA+ID4gLS0tIGEvbmV0L3N1bnJwYy9jbG50LmMNCj4gPiA+
ICsrKyBiL25ldC9zdW5ycGMvY2xudC5jDQo+ID4gPiBAQCAtMTc5Myw3ICsxNzkzLDE0IEBAIGNh
bGxfZW5jb2RlKHN0cnVjdCBycGNfdGFzayAqdGFzaykNCj4gPiA+ICAgICAgICAgICAgICAgcnBj
X2RlbGF5KHRhc2ssIEhaID4+IDQpOw0KPiA+ID4gICAgICAgICAgICAgICBicmVhazsNCj4gPiA+
ICAgICAgICAgICBjYXNlIC1FS0VZRVhQSVJFRDoNCj4gPiA+IC0gICAgICAgICAgICB0YXNrLT50
a19hY3Rpb24gPSBjYWxsX3JlZnJlc2g7DQo+ID4gPiArICAgICAgICAgICAgaWYgKCF0YXNrLT50
a19jcmVkX3JldHJ5KSB7DQo+ID4gPiArICAgICAgICAgICAgICAgIHJwY19leGl0KHRhc2ssIHRh
c2stPnRrX3N0YXR1cyk7DQo+ID4gPiArICAgICAgICAgICAgfSBlbHNlIHsNCj4gPiA+ICsgICAg
ICAgICAgICAgICAgdGFzay0+dGtfYWN0aW9uID0gY2FsbF9yZWZyZXNoOw0KPiA+ID4gKyAgICAg
ICAgICAgICAgICB0YXNrLT50a19jcmVkX3JldHJ5LS07DQo+ID4gPiArICAgICAgICAgICAgICAg
IGRwcmludGsoIlJQQzogJTV1ICVzOiByZXRyeSByZWZyZXNoIGNyZWRzXG4iLA0KPiA+ID4gKyAg
ICAgICAgICAgICAgICAgICAgdGFzay0+dGtfcGlkLCBfX2Z1bmNfXyk7DQo+ID4gPiArICAgICAg
ICAgICAgfQ0KPiA+ID4gICAgICAgICAgICAgICBicmVhazsNCj4gPiA+ICAgICAgICAgICBkZWZh
dWx0Og0KPiA+ID4gICAgICAgICAgICAgICBycGNfZXhpdCh0YXNrLCB0YXNrLT50a19zdGF0dXMp
Ow0KPiA+ID4gDQo+ID4gDQo+ID4gLg0KPiA+IA0K

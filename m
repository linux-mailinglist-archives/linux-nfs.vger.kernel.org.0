Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 478601D9BC5
	for <lists+linux-nfs@lfdr.de>; Tue, 19 May 2020 17:55:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729055AbgESPza (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 19 May 2020 11:55:30 -0400
Received: from mail-eopbgr690095.outbound.protection.outlook.com ([40.107.69.95]:30595
        "EHLO NAM04-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728994AbgESPz3 (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Tue, 19 May 2020 11:55:29 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fhSrL4i4yCx8a1SWQd+LoQctit8wNJKcdMcOfc4ayiC43Vf6o8NwOk8/kbtlGEvFYkMTGPHfF5AAhzeb1iS766QUg7qmpF2BMhQ5CJe81HVtqpq52P0JpNicocxR/Dpuam6WD5bGY+Ua9CNeTwgqa9fvZx45eb/oHurJiWsJNgAj2yl858gJJPo7qVJTbYVvokrssv8RCU7R06/omLPLYns8OElpB9UXqk4mEk+AyFlfa8clKG9yoiiGdGprehXqH9xWNKtnpluhoYrF6xjjyD8lEMYfour51y1442x4TfWjuTlLJDyJwAX22T/w4auTfeoZrA0FoDol151ncTurFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Usu7ACu1ayXDrfOURUBUQElrmIoPzsKaSOTLKnMogOQ=;
 b=S0by6s8as+DB4S639ZGZelJxjXZr0Q35VGAr+V6ksa6aJilHB53swU98wtIcntd6GZ8mrGZ9oP/FbjEBylBh9foP6DtwzV3rUU414AYK08FpHIGSq5vWmPei6byrwJ5KuJ3qjbbcQOTkNdlCeQjKDLBwhju4u6p3lw1NxyYEtf0yhjQxhrHOJaiMcTL0r8Qlk4amsg4HSsZtjXjSKg1dP6yM6ldah4T2e4AKE1+BSIc9yHrFp5bZoyfePY8GR3AFH1uG1qLJ8mV5aN5O9WNtH7SH5L1Z80Z30OYPcTXanQsltKwhYc8ZPkJ+UIAvKizAqPGwirDRjJogeGhpoD5LLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Usu7ACu1ayXDrfOURUBUQElrmIoPzsKaSOTLKnMogOQ=;
 b=ams5l34PnR8QOAcEDh1mIRyUw0zuZ/YKqBPuYpOBNURe38HAWhFgaksfEkF/d3TY7HbGAsjlfkzE13h8hqivuybcTNT1/yMYZEFQ3cKZvcdKEcC8QHYjljzDvRk0vwO6pDaye61N1A2n/SLB3tguzwAACkbNUEioEHSlikarvp4=
Received: from CH2PR13MB3398.namprd13.prod.outlook.com (2603:10b6:610:2a::33)
 by CH2PR13MB3416.namprd13.prod.outlook.com (2603:10b6:610:16::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3021.19; Tue, 19 May
 2020 15:55:25 +0000
Received: from CH2PR13MB3398.namprd13.prod.outlook.com
 ([fe80::49f6:ce9b:9803:2493]) by CH2PR13MB3398.namprd13.prod.outlook.com
 ([fe80::49f6:ce9b:9803:2493%6]) with mapi id 15.20.3021.013; Tue, 19 May 2020
 15:55:25 +0000
From:   Trond Myklebust <trondmy@hammerspace.com>
To:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "zhengbin13@huawei.com" <zhengbin13@huawei.com>,
        "anna.schumaker@netapp.com" <anna.schumaker@netapp.com>
CC:     "zhangxiaoxu5@huawei.com" <zhangxiaoxu5@huawei.com>,
        "yi.zhang@huawei.com" <yi.zhang@huawei.com>
Subject: Re: [PATCH] nfs: always force a full attribute revalidation after
 NFSv4 writes
Thread-Topic: [PATCH] nfs: always force a full attribute revalidation after
 NFSv4 writes
Thread-Index: AQHWLb7P4B/NSRrDS0G4yyDQTT2OxqivkFGA
Date:   Tue, 19 May 2020 15:55:24 +0000
Message-ID: <76ec9fdd763cb1340855a55829b3254d94d568fc.camel@hammerspace.com>
References: <20200519092753.13658-1-zhengbin13@huawei.com>
In-Reply-To: <20200519092753.13658-1-zhengbin13@huawei.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none
 header.from=hammerspace.com;
x-originating-ip: [68.36.133.222]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 780a8afd-c1ec-42d2-42e7-08d7fc0d0b4b
x-ms-traffictypediagnostic: CH2PR13MB3416:
x-microsoft-antispam-prvs: <CH2PR13MB3416440C3105CDEFEF498426B8B90@CH2PR13MB3416.namprd13.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5797;
x-forefront-prvs: 040866B734
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: D399irvjCUutL5eHnYiFWLZDXvjkEM105EkUreCYMYAAeReID643mLi9Ty4io1rahHYsrXHIcRsGVOnoKZ36ZOdrLjuFsar+mw198rIhfr6pfjXGhZn1PlkcbsoCdS9UDGbER/II6jME0ezaI0+U3jmtw+NQUiJn0u7fwMPvr0ipX1Ns5FpYyEfmdskRUXldOxLfSTlFFlVTMTcO6L6A0d1x5Yo/t0MBiFAJR9ecds1QciS4uEHPRRIg6HIvSGiORwYeIQrCkOtzxoIFkenzMT5W2pMY/pYee3CDwE1lKTcfFCpLFrgmLSWv+ezaGCzQbONeBVCbKW0HUKV7XDINTQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR13MB3398.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(39830400003)(346002)(366004)(396003)(136003)(376002)(2906002)(76116006)(2616005)(66556008)(66476007)(64756008)(66446008)(86362001)(71200400001)(478600001)(6506007)(4326008)(66946007)(5660300002)(36756003)(316002)(54906003)(110136005)(186003)(6486002)(8676002)(26005)(8936002)(6512007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: hjcXIiKc3zKteGoUeL1OHCVMk8Y44dysg0kU27XMN4YrihBbW2uDSFBXaX0+fkiYrabd6+/v0wA+5kpR1wSXHUe5U3sP+vmjEM5kD86ovW0ONAXJCza6TU+NGfncF2Gg4PjGkKp5v3sQ0xzkN9I9i3pYy98sQSsTRRRTLhzwsOK/O9J87Y6OeGHN7/uCJbRbXAgyRgfRGLADeDsWXZCmon61k022oCtLKgTbrDwPXwG2s2u3YRItgx95Y79CyPGvnRge8Omf1yErkTmRwcFJeGKlSzYzIdZ+Ro8+5QMn92TorP189YDWpAtGIjh2NCXypRiNlEHYKSYZ4KPZSIn/iOP+ZP0p8HRq1beNS1ofaMMv2TJ+/b2dT5s421JZfpdZbrR5j+C7Se0ACzl5oCjvX9LqTfiDJMsl29y2/8v64PU3wOqhhXYTEEdC4Cz3alojHay3eN7t3/Tn/5Ns00OaKvT4BZGCxYc+MwOQZVr9jXc=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <E9F82CE234BB6E4FA3256F5CE71A5F51@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 780a8afd-c1ec-42d2-42e7-08d7fc0d0b4b
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 May 2020 15:55:24.8821
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2zWp/XpRQBccUMNWmzGI/+i6jzRBwa+hZqmE6jE0zACUze/3Av17e2Eu5+3MuLhrasrqSIkz425NCNdQcboftw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR13MB3416
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

T24gVHVlLCAyMDIwLTA1LTE5IGF0IDE3OjI3ICswODAwLCBaaGVuZyBCaW4gd3JvdGU6DQo+IFVz
ZSB0aGUgZm9sbG93aW5nIGNvbW1hbmQgdG8gdGVzdCBuZnN2NChzaXplIG9mIGZpbGUxTSBpcyAx
TUIpOg0KPiBtb3VudCAtdCBuZnMgLW8gdmVycz00LjAsYWN0aW1lbz02MCAxMjcuMC4wLjEvZGly
MSAvbW50DQo+IGNwIGZpbGUxTSAvbW50DQo+IGR1IC1oIC9tbnQvZmlsZTFNICAtLT4wIHdpdGhp
biA2MHMsIHRoZW4gMU0NCj4gDQo+IFdoZW4gd3JpdGUgaXMgZG9uZShjcCBmaWxlMU0gL21udCks
IHdpbGwgY2FsbCB0aGlzOg0KPiBuZnNfd3JpdGViYWNrX2RvbmUNCj4gICBuZnM0X3dyaXRlX2Rv
bmUNCj4gICAgIG5mczRfd3JpdGVfZG9uZV9jYg0KPiAgICAgICBuZnNfd3JpdGViYWNrX3VwZGF0
ZV9pbm9kZQ0KPiAgICAgICAgIG5mc19wb3N0X29wX3VwZGF0ZV9pbm9kZV9mb3JjZV93Y2NfbG9j
a2VkKGNoYW5nZSwgY3RpbWUsDQo+IG10aW1lDQo+IG5mc19wb3N0X29wX3VwZGF0ZV9pbm9kZV9m
b3JjZV93Y2NfbG9ja2VkDQo+ICAgIG5mc19zZXRfY2FjaGVfaW52YWxpZA0KPiAgICBuZnNfcmVm
cmVzaF9pbm9kZV9sb2NrZWQNCj4gICAgICBuZnNfdXBkYXRlX2lub2RlDQo+IA0KPiBuZnNkIHdy
aXRlIHJlc3BvbnNlIGNvbnRhaW5zIGNoYW5nZSwgY3RpbWUsIG10aW1lLCB0aGUgZmxhZyB3aWxs
IGJlDQo+IGNsZWFyIGFmdGVyIG5mc191cGRhdGVfaW5vZGUuIEhvd2VydmVyLCB3cml0ZSByZXNw
b25zZSBkb2VzIG5vdA0KPiBjb250YWluDQo+IHNwYWNlX3VzZWQsIHByZXZpb3VzIG9wZW4gcmVz
cG9uc2UgY29udGFpbnMgc3BhY2VfdXNlZCB3aG9zZSB2YWx1ZSBpcw0KPiAwLA0KPiBzbyBpbm9k
ZS0+aV9ibG9ja3MgaXMgc3RpbGwgMC4NCj4gDQo+IG5mc19nZXRhdHRyICAtLT5jYWxsZWQgYnkg
ImR1IC1oIg0KPiAgIGRvX3VwZGF0ZSB8PSBmb3JjZV9zeW5jIHx8IG5mc19hdHRyaWJ1dGVfY2Fj
aGVfZXhwaXJlZCAtLT5mYWxzZSBpbg0KPiA2MHMNCj4gICBjYWNoZV92YWxpZGl0eSA9IFJFQURf
T05DRShORlNfSShpbm9kZSktPmNhY2hlX3ZhbGlkaXR5KQ0KPiAgIGRvX3VwZGF0ZSB8PSBjYWNo
ZV92YWxpZGl0eSAmIChORlNfSU5PX0lOVkFMSURfQVRUUiAgICAtLT5mYWxzZQ0KPiAgIGlmIChk
b191cGRhdGUpIHsNCj4gCV9fbmZzX3JldmFsaWRhdGVfaW5vZGUNCj4gICB9DQo+IA0KPiBXaXRo
aW4gNjBzLCBkb2VzIG5vdCBzZW5kIGdldGF0dHIgcmVxdWVzdCB0byBuZnNkLCB0aHVzICJkdSAt
aA0KPiAvbW50L2ZpbGUxTSINCj4gaXMgMC4NCj4gDQo+IEZpeGVzOiAxNmUxNDM3NTE3MjcgKCJO
RlM6IE1vcmUgZmluZSBncmFpbmVkIGF0dHJpYnV0ZSB0cmFja2luZyIpDQo+IFNpZ25lZC1vZmYt
Ynk6IFpoZW5nIEJpbiA8emhlbmdiaW4xM0BodWF3ZWkuY29tPg0KPiAtLS0NCj4gIGZzL25mcy9p
bm9kZS5jIHwgMyArKy0NCj4gIDEgZmlsZSBjaGFuZ2VkLCAyIGluc2VydGlvbnMoKyksIDEgZGVs
ZXRpb24oLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9mcy9uZnMvaW5vZGUuYyBiL2ZzL25mcy9pbm9k
ZS5jDQo+IGluZGV4IGI5ZDA5MjFjYjRmZS4uYmRmYjk4ZDVmNDViIDEwMDY0NA0KPiAtLS0gYS9m
cy9uZnMvaW5vZGUuYw0KPiArKysgYi9mcy9uZnMvaW5vZGUuYw0KPiBAQCAtMTc2NCw3ICsxNzY0
LDggQEAgaW50DQo+IG5mc19wb3N0X29wX3VwZGF0ZV9pbm9kZV9mb3JjZV93Y2NfbG9ja2VkKHN0
cnVjdCBpbm9kZSAqaW5vZGUsIHN0cnVjdA0KPiBuZnNfZmENCj4gIAlzdGF0dXMgPSBuZnNfcG9z
dF9vcF91cGRhdGVfaW5vZGVfbG9ja2VkKGlub2RlLCBmYXR0ciwNCj4gIAkJCU5GU19JTk9fSU5W
QUxJRF9DSEFOR0UNCj4gIAkJCXwgTkZTX0lOT19JTlZBTElEX0NUSU1FDQo+IC0JCQl8IE5GU19J
Tk9fSU5WQUxJRF9NVElNRSk7DQo+ICsJCQl8IE5GU19JTk9fSU5WQUxJRF9NVElNRQ0KPiArCQkJ
fCBORlNfSU5PX0lOVkFMSURfT1RIRVIpOw0KPiAgCXJldHVybiBzdGF0dXM7DQo+ICB9DQo+IA0K
DQpOQUNLLiBQbGVhc2UgYWRkIGEgTkZTX0lOT19JTlZBTElEX0JMT0NLUyBmb3IgdGhpcyBjYXNl
IGluc3RlYWQgb2YNCnNldHRpbmcgSU5WQUxJRF9PVEhFUi4NCg0KUXVpdGUgZnJhbmtseSwgInNw
YWNlIHVzZWQiIGlzIGFuIGFuYWNocm9uaXNtIGZyb20gdGhlIGRheXMgd2hlbg0KZXZlcnl0aGlu
ZyB3YXMgc3RvcmVkIG9uIGxvY2FsIGRpc2sgb24geW91ciB3b3Jrc3RhdGlvbiwgYmVmb3JlIHRo
ZQ0KZGF5cyBvZiBhdXRvbWF0ZWQgdGllcmluZywgZGVkdXAgYW5kL29yIGNvbXByZXNzaW9uLiBJ
dCBzaG91bGQgbm90DQptYXR0ZXIgdG8gYXBwbGljYXRpb25zIGFuZCBzbyB3ZSBkZWZpbml0ZWx5
IHdhbnQgdG8gYmUgYWJsZSB0byBvcHRpbWlzZQ0KaXQgYXdheSBpbiBzdGF0eCgpIGNhbGxzIHRo
YXQgZG9uJ3QgZXhwbGljaXRseSBhc2sgZm9yIGl0Lg0KDQotLSANClRyb25kIE15a2xlYnVzdA0K
TGludXggTkZTIGNsaWVudCBtYWludGFpbmVyLCBIYW1tZXJzcGFjZQ0KdHJvbmQubXlrbGVidXN0
QGhhbW1lcnNwYWNlLmNvbQ0KDQoNCg==

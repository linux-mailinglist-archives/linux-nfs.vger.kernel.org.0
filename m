Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 91E08ACFD4
	for <lists+linux-nfs@lfdr.de>; Sun,  8 Sep 2019 18:47:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726443AbfIHQr3 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sun, 8 Sep 2019 12:47:29 -0400
Received: from mail-eopbgr730133.outbound.protection.outlook.com ([40.107.73.133]:60384
        "EHLO NAM05-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726535AbfIHQr3 (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Sun, 8 Sep 2019 12:47:29 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iRri61bn/U72txM3m3ne1Alxc5a091+5hkTi0ayJVf0GGR9Zn3Au2zUat8DmH5tPu1F07u0wAJrLl62hNP2CEgwwN+b5N0HmMHzzwe/DLsntY48dYm8cQX7S+gKKH+oDpsujyJ/D4rBcYAXqlln1Snj2CRMzCSvfU5qzS1ekW3qCdjrGwuD11BP2vr+esCZMnNgd3jW633Drz5+PEnKnO15jBjR9nvfNEBeXy2kI348c6phaPnRYEBK6Qn9JdQkTXVNAa7QLhN4a8JdVLS3VweyY5sK7NHsTvY3+9upcaPJSrzuelbaZ74IqHsGaU6i3Ls/6SM/9fDJS44IJXBpxSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ieHB/BB9A5QHck7gp/nPsffo9HGENejXEigWNKQAQdg=;
 b=BJXSZAogFgy9FZ1gYmxyOhqpYG4qQh/4A/l5ySecxMXCEpkWCFmkp7avetz/Z9XVc9G++AThzVonplOB3eEMvyApnM7wnSXgy+S4YWsf6IkR0cNpXkJDT8m92dVziDhlwbTsVfwngYMV7EB6GRZoehmDjXVkd9ulueNc+aVNVttd7MCu+KQu0MNuoWL6yH0vaKPm8xXuU3q3nA173oEGAa+KcmKjgoObsaYfHecPtxwUq31TksPLS7BTB6IOw2RtZ8PntEC8gbja95fVr29fqgkfwcOsyhmP6jIwMkFAwY8gIBv6h9bGN9VtRzft9CAugntU6q8eLsCg7ArWjyct6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ieHB/BB9A5QHck7gp/nPsffo9HGENejXEigWNKQAQdg=;
 b=NDrQMV045IlG791tGsvCrueaapskS9b7qyvWWnXePZcPOSA2GEK9n6iAgEA+UKmhaHvObPADp1W9H4IZbuTRcP1R4K4PAFe86lr7FxUqJVWr6DStrbZ/BfoP4dj/mnVyy4AjFKr5wwYet/FslvHTZD6YpVxpVJSEdFEiSdBhEDU=
Received: from DM5PR13MB1851.namprd13.prod.outlook.com (10.171.159.143) by
 DM5PR13MB1177.namprd13.prod.outlook.com (10.168.235.23) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2263.10; Sun, 8 Sep 2019 16:47:19 +0000
Received: from DM5PR13MB1851.namprd13.prod.outlook.com
 ([fe80::70fd:85c2:8ea9:a0b6]) by DM5PR13MB1851.namprd13.prod.outlook.com
 ([fe80::70fd:85c2:8ea9:a0b6%9]) with mapi id 15.20.2263.005; Sun, 8 Sep 2019
 16:47:19 +0000
From:   Trond Myklebust <trondmy@hammerspace.com>
To:     "chuck.lever@oracle.com" <chuck.lever@oracle.com>
CC:     "tibbs@math.uh.edu" <tibbs@math.uh.edu>,
        "bfields@fieldses.org" <bfields@fieldses.org>,
        "linux@stwm.de" <linux@stwm.de>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "bcodding@redhat.com" <bcodding@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "km@cm4all.com" <km@cm4all.com>
Subject: Re: Regression in 5.1.20: Reading long directory fails
Thread-Topic: Regression in 5.1.20: Reading long directory fails
Thread-Index: AQHVUfDuoAq39fX+s0K+L+pluMBkM6cHnsTegAlOTYCAAAwCNIAJQZHggAAlEwCAABHoXoAAKhIAgABG1wuAA/3qgIAAZExXgAAA1wCAAoqWAIAAPZqAgAAIMwCAABBKAA==
Date:   Sun, 8 Sep 2019 16:47:18 +0000
Message-ID: <9c3483e089986fa9f5e8af8ea9e552f4313ecd6a.camel@hammerspace.com>
References: <ufak1bhyuew.fsf@epithumia.math.uh.edu>
         <4418877.15LTP4gqqJ@stwm.de> <ufapnkhqjwm.fsf@epithumia.math.uh.edu>
         <4198657.JbNDGbLXiX@h2o.as.studentenwerk.mhn.de>
         <ufad0ggrfrk.fsf@epithumia.math.uh.edu>
         <20190906144837.GD17204@fieldses.org>
         <ufapnkdw3s3.fsf@epithumia.math.uh.edu>
         <75F810C6-E99E-40C3-B5E1-34BA2CC42773@oracle.com>
         <A862CFCD-76A2-4373-8F44-F156DB38E6A5@redhat.com>
         <1ebf86cff330eb15c02249f0dac415a8aff99f49.camel@hammerspace.com>
         <3B2EEB3C-3305-4A50-A55B-51093A985284@oracle.com>
In-Reply-To: <3B2EEB3C-3305-4A50-A55B-51093A985284@oracle.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=trondmy@hammerspace.com; 
x-originating-ip: [50.36.167.63]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7fef697c-29c7-44eb-e627-08d7347c3683
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600166)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:DM5PR13MB1177;
x-ms-traffictypediagnostic: DM5PR13MB1177:
x-ms-exchange-purlcount: 1
x-microsoft-antispam-prvs: <DM5PR13MB11773892B12F7B0C0CE376EBB8B40@DM5PR13MB1177.namprd13.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3631;
x-forefront-prvs: 0154C61618
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(136003)(396003)(346002)(39830400003)(376002)(199004)(189003)(86362001)(6116002)(71200400001)(71190400001)(6436002)(486006)(2351001)(14454004)(6486002)(5660300002)(2501003)(446003)(6916009)(66946007)(66476007)(66556008)(64756008)(66446008)(66066001)(229853002)(11346002)(2616005)(476003)(25786009)(102836004)(26005)(186003)(4326008)(256004)(316002)(54906003)(14444005)(6506007)(478600001)(7736002)(305945005)(53546011)(8676002)(118296001)(91956017)(76116006)(53936002)(966005)(81166006)(5640700003)(81156014)(8936002)(6512007)(2906002)(6306002)(76176011)(3846002)(99286004)(6246003)(36756003);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR13MB1177;H:DM5PR13MB1851.namprd13.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: hammerspace.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: bwC/M3tr9K4zP9AvKeEJoXDENIQWnNgrIGyex9m5F0VN6vhsF8H2FGRn4nX+P+yJAKIyAQg+cR0fWX52RYHj9mqGk5VpuMqrdmCvaRiRTLd5z2qk8WZsUDfpW1EUeKZPUxIMK21fD0c5BrvjIwOXtzp2Fo50llCEZ8Eko6uGhrAWQ54eJXMYwDH1fOvtCP4voJ16tMwPjFXCzO0ccFW/JCkdi/5SP5TI/oBJ1yhcURcbRz3V245AhSH8hrqL/Ts03rZN7LbQE0LdvuVb7ptMWq+c+OA40+dbVHvh4KH6wb143AtWQC2plWnUTskUmzkITH+YnQ8h+xjH4JH5nKqQKWHYk8FwaHiUl3Qf5XVCYxzDIBBa5c4xWogAoLoUqELralnK9Izs5fj6lo4wsACJJqh3ozO8GOuDJJPjBJix5Nc=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <666E4FE7F1BB69449745E98C1B3D9AB3@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7fef697c-29c7-44eb-e627-08d7347c3683
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Sep 2019 16:47:18.9498
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vgadv4reY8WHg4LcTPI+WfC67mHfr7f0Wp+UKr/42g5xFXg/JdrvtI1ngCnqcO/q+owZhOQIC9kbDTojX9t/BA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR13MB1177
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

T24gU3VuLCAyMDE5LTA5LTA4IGF0IDExOjQ4IC0wNDAwLCBDaHVjayBMZXZlciB3cm90ZToNCj4g
PiBPbiBTZXAgOCwgMjAxOSwgYXQgMTE6MTkgQU0sIFRyb25kIE15a2xlYnVzdCA8DQo+ID4gdHJv
bmRteUBoYW1tZXJzcGFjZS5jb20+IHdyb3RlOg0KPiA+IA0KPiA+IE9uIFN1biwgMjAxOS0wOS0w
OCBhdCAwNzozOSAtMDQwMCwgQmVuamFtaW4gQ29kZGluZ3RvbiB3cm90ZToNCj4gPiA+IE9uIDYg
U2VwIDIwMTksIGF0IDE2OjUwLCBDaHVjayBMZXZlciB3cm90ZToNCj4gPiA+IA0KPiA+ID4gPiA+
IE9uIFNlcCA2LCAyMDE5LCBhdCA0OjQ3IFBNLCBKYXNvbiBMIFRpYmJpdHRzIElJSSA8DQo+ID4g
PiA+ID4gdGliYnNAbWF0aC51aC5lZHU+IA0KPiA+ID4gPiA+IHdyb3RlOg0KPiA+ID4gPiA+IA0K
PiA+ID4gPiA+ID4gPiA+ID4gPiAiSkJGIiA9PSBKIEJydWNlIEZpZWxkcyA8YmZpZWxkc0BmaWVs
ZHNlcy5vcmc+DQo+ID4gPiA+ID4gPiA+ID4gPiA+IHdyaXRlczoNCj4gPiA+ID4gPiANCj4gPiA+
ID4gPiBKQkY+IFRob3NlIHJlYWRkaXIgY2hhbmdlcyB3ZXJlIGNsaWVudC1zaWRlLCByaWdodD8g
IEJhc2VkIG9uDQo+ID4gPiA+ID4gdGhhdCANCj4gPiA+ID4gPiBJJ2QNCj4gPiA+ID4gPiBKQkY+
IGJlZW4gYXNzdW1pbmcgYSBjbGllbnQgYnVnLCBidXQgbWF5YmUgaXQnZCBiZSB3b3J0aA0KPiA+
ID4gPiA+IGdldHRpbmcNCj4gPiA+ID4gPiBhIA0KPiA+ID4gPiA+IGZ1bGwNCj4gPiA+ID4gPiBK
QkY+IHBhY2tldCBjYXB0dXJlIG9mIHRoZSByZWFkZGlyIHJlcGx5IHRvIG1ha2Ugc3VyZSBpdCdz
DQo+ID4gPiA+ID4gbGVnaXQuDQo+ID4gPiA+ID4gDQo+ID4gPiA+ID4gSSBoYXZlIGJlZW4gd29y
a2luZyB3aXRoIGJjb2RkaW5nIG9uIElSQyBmb3IgdGhlIHBhc3QgY291cGxlDQo+ID4gPiA+ID4g
b2YNCj4gPiA+ID4gPiBkYXlzIA0KPiA+ID4gPiA+IG9uDQo+ID4gPiA+ID4gdGhpcy4gIEZvcnR1
bmF0ZWx5IEkgd2FzIGFibGUgdG8gY29tZSB1cCB3aXRoIHdheSB0byBmaWxsIHVwDQo+ID4gPiA+
ID4gYSANCj4gPiA+ID4gPiBkaXJlY3RvcnkNCj4gPiA+ID4gPiBpbiBzdWNoIGEgd2F5IHRoYXQg
aXQgd2lsbCBmYWlsIHdpdGggY2VydGFpbnR5IGFuZCBhcyBhIGJvbnVzDQo+ID4gPiA+ID4gZG9l
c24ndA0KPiA+ID4gPiA+IGluY2x1ZGUgYW55IHVzZXIgZGF0YSBzbyBJIGNhbiBmZWVsIE9LIGFi
b3V0IHNoYXJpbmcgcGFja2V0DQo+ID4gPiA+ID4gY2FwdHVyZXMuIA0KPiA+ID4gPiA+IEkNCj4g
PiA+ID4gPiBoYXZlIGEgY2FwdHVyZSBhbG9uZ3NpZGUgYSBrZXJuZWwgdHJhY2Ugb2YgdGhlIHBy
b2JsZW1hdGljDQo+ID4gPiA+ID4gb3BlcmF0aW9uIA0KPiA+ID4gPiA+IGluDQo+ID4gPiA+ID4g
aHR0cHM6Ly93d3cubWF0aC51aC5lZHUvfnRpYmJzL25mcy8uICBOb3QgdGhhdCBJIGNhbg0KPiA+
ID4gPiA+IHBhcnRpY3VsYXJseSANCj4gPiA+ID4gPiB0ZWxsDQo+ID4gPiA+ID4gYW55dGhpbmcg
dXNlZnVsIGZyb20gdGhhdCwgYnV0IGJjb2RkaW5nIHNheXMgdGhhdCBpdCBzZWVtcyB0bw0KPiA+
ID4gPiA+IHBvaW50IA0KPiA+ID4gPiA+IHRvDQo+ID4gPiA+ID4gc29tZSBpc3N1ZSBpbiBzdW5y
cGMuDQo+ID4gPiA+ID4gDQo+ID4gPiA+ID4gQW5kIGJlY2F1c2UgSSBjYW4gZWFzaWx5IHJlcHJv
ZHVjZSB0aGlzIGFuZCBJIHdhcyBhYmxlIHRvIGRvDQo+ID4gPiA+ID4gYSANCj4gPiA+ID4gPiBi
aXNlY3Q6DQo+ID4gPiA+ID4gDQo+ID4gPiA+ID4gMmM5NGI4ZWNhMWEyNmNkNDYwMTBkNmU3M2Ey
M2RhNWYyZTkzYTE5ZCBpcyB0aGUgZmlyc3QgYmFkDQo+ID4gPiA+ID4gY29tbWl0DQo+ID4gPiA+
ID4gY29tbWl0IDJjOTRiOGVjYTFhMjZjZDQ2MDEwZDZlNzNhMjNkYTVmMmU5M2ExOWQNCj4gPiA+
ID4gPiBBdXRob3I6IENodWNrIExldmVyIDxjaHVjay5sZXZlckBvcmFjbGUuY29tPg0KPiA+ID4g
PiA+IERhdGU6ICAgTW9uIEZlYiAxMSAxMToyNTo0MSAyMDE5IC0wNTAwDQo+ID4gPiA+ID4gDQo+
ID4gPiA+ID4gICBTVU5SUEM6IFVzZSBhdV9yc2xhY2sgd2hlbiBjb21wdXRpbmcgcmVwbHkgYnVm
ZmVyIHNpemUNCj4gPiA+ID4gPiANCj4gPiA+ID4gPiAgIGF1X3JzbGFjayBpcyBzaWduaWZpY2Fu
dGx5IHNtYWxsZXIgdGhhbiAoYXVfY3NsYWNrIDw8IDIpLg0KPiA+ID4gPiA+IFVzaW5nDQo+ID4g
PiA+ID4gICB0aGF0IHZhbHVlIHJlc3VsdHMgaW4gc21hbGxlciByZWNlaXZlIGJ1ZmZlcnMuIElu
IHNvbWUNCj4gPiA+ID4gPiBjYXNlcw0KPiA+ID4gPiA+IHRoaXMNCj4gPiA+ID4gPiAgIGVsaW1p
bmF0ZXMgYW4gZXh0cmEgc2VnbWVudCBpbiBSZXBseSBjaHVua3MgKFJQQy9SRE1BKS4NCj4gPiA+
ID4gPiANCj4gPiA+ID4gPiAgIFNpZ25lZC1vZmYtYnk6IENodWNrIExldmVyIDxjaHVjay5sZXZl
ckBvcmFjbGUuY29tPg0KPiA+ID4gPiA+ICAgU2lnbmVkLW9mZi1ieTogQW5uYSBTY2h1bWFrZXIg
PEFubmEuU2NodW1ha2VyQE5ldGFwcC5jb20+DQo+ID4gPiA+ID4gDQo+ID4gPiA+ID4gOjA0MDAw
MCAwNDAwMDAgZDRkMWNlMmZiZTAwMzVjNWJkOWRmOTc2YjhjNDQ4ZGY4NWRjYjUwNSANCj4gPiA+
ID4gPiA3MDExYTc5MmRmZTcyZmY5Y2Q3MGQ2NmU0NWQzNTNmM2Q3ODE3ZTNlIE0gICAgICBuZXQN
Cj4gPiA+ID4gPiANCj4gPiA+ID4gPiBCdXQgb2YgY291cnNlLCBJIGNhbid0IHNheSB3aGV0aGVy
IHRoaXMgaXMgdGhlIGFjdHVhbCBiYWQNCj4gPiA+ID4gPiBjb21taXQNCj4gPiA+ID4gPiBvcg0K
PiA+ID4gPiA+IHdoZXRoZXIgaXQganVzdCBpbnRyb2R1Y2VkIGEgYmVoYXZpb3IgY2hhbmdlIHdo
aWNoIGFsdGVycw0KPiA+ID4gPiA+IHRoZSANCj4gPiA+ID4gPiBjb25kaXRpb25zDQo+ID4gPiA+
ID4gdW5kZXIgd2hpY2ggdGhlIHByb2JsZW0gYXBwZWFycy4NCj4gPiA+ID4gDQo+ID4gPiA+IFRo
ZSBmaXJzdCBwbGFjZSBJJ2Qgc3RhcnQgbG9va2luZyBpcyB0aGUgWERSIGNvbnN0YW50cyBhdCB0
aGUNCj4gPiA+ID4gaGVhZA0KPiA+ID4gPiBvZiANCj4gPiA+ID4gZnMvbmZzL25mczR4ZHIuYw0K
PiA+ID4gPiBoYXZpbmcgdG8gZG8gd2l0aCBSRUFERElSLg0KPiA+ID4gPiANCj4gPiA+ID4gVGhl
IHJlcG9ydCBvZiBiZWhhdmlvciBjaGFuZ2VzIHdpdGggdGhlIHVzZSBvZiBrcmI1cCBhbHNvIG1h
a2VzDQo+ID4gPiA+IHRoaXMgDQo+ID4gPiA+IGNvbW1pdCBwbGF1c2libGUuDQo+ID4gPiANCj4g
PiA+IEFmdGVyIHNwcmlua2xpbmcgdGhlIHByaW50aydzLCB3ZSdyZSBjb21pbmcgdXAgb25lIHdv
cmQgc2hvcnQgaW4NCj4gPiA+IHRoZSANCj4gPiA+IHJlY2VpdmUNCj4gPiA+IGJ1ZmZlci4gIEkg
dGhpbmsgd2UncmUgbm90IGFjY291bnRpbmcgZm9yIHRoZSB4ZHIgcGFkIG9mIGJ1Zi0NCj4gPiA+
ID5wYWdlcw0KPiA+ID4gZm9yIA0KPiA+ID4gTkZTNA0KPiA+ID4gcmVhZGRpciAtLSBidXQgSSBu
ZWVkIHRvIGNoZWNrIHRoZSBSRkNzLiAgQW55b25lIGtub3cgaWYgdjQNCj4gPiA+IFJFQURESVIg
DQo+ID4gPiByZXN1bHRzDQo+ID4gPiBoYXZlIHRvIGJlIGFsaWduZWQ/DQo+ID4gPiANCj4gPiA+
IEFsc28gbmVlZCB0byBjaGVjayBqdXN0IHdoeSBrcmI1aSBpcyB0aGUgb25seSBhdXRoIHRoYXQg
Y2FyZXMuLg0KPiA+ID4gDQo+ID4gDQo+ID4gSSdtIG5vdCBzZWVpbmcgdGhhdC4gSWYgeW91IGxv
b2sgYXQgY29tbWl0IDAyZWYwNGU0MzJiYSwgeW91J2xsIHNlZQ0KPiA+IHRoYXQgQ2h1Y2sgZGlk
IGFkZCBhICdwYWRkaW5nIHRlcm0nIHRvIGRlY29kZV9yZWFkZGlyX21heHN6IGluIHRoZQ0KPiA+
IE5GU3Y0IGNhc2UuDQo+ID4gVGhlIG90aGVyIHRoaW5nIHRvIHJlbWVtYmVyIGlzIHRoYXQgYSBy
ZWFkZGlyICdkaXJsaXN0NCcgZW50cnkgaXMNCj4gPiBhbHdheXMgd29yZCBhbGlnbmVkIChpcnJl
c3BlY3RpdmUgb2YgdGhlIGxlbmd0aCBvZiB0aGUgZmlsZW5hbWUpLA0KPiA+IHNvDQo+ID4gdGhl
cmUgaXMgbm8gcGFkZGluZyB0aGF0IG5lZWRzIHRvIGJlIHRha2VuIGludG8gYWNjb3VudC4NCj4g
PiANCj4gPiBJIHRoaW5rIHdlIHByb2JhYmx5IHJhdGhlciB3YW50IHRvIGxvb2sgYXQgaG93IGF1
dGgtPmF1X3JhbGlnbiBpcw0KPiA+IGJlaW5nDQo+ID4gY2FsY3VsYXRlZCBmb3IgdGhlIGNhc2Ug
b2Yga3JiNWkuIEknbSByZWFsbHkgbm90IHVuZGVyc3RhbmRpbmcgd2h5DQo+ID4gYXV0aC0+YXVf
cmFsaWduIHNob3VsZCBub3QgdGFrZSBpbnRvIGFjY291bnQgdGhlIHByZXNlbmNlIG9mIHRoZQ0K
PiA+IG1pYy4NCj4gPiBDaHVjaz8NCj4gDQo+IEknbSBsb29raW5nIGF0IGdzc191bndyYXBfcmVz
cF9pbnRlZygpOg0KPiANCj4gMTk3MSAgICAgICAgIGF1dGgtPmF1X3JzbGFjayA9IGF1dGgtPmF1
X3ZlcmZzaXplICsgMiArIDEgKw0KPiBYRFJfUVVBRExFTihtaWMubGVuKTsNCj4gMTk3MiAgICAg
ICAgIGF1dGgtPmF1X3JhbGlnbiA9IGF1dGgtPmF1X3ZlcmZzaXplICsgMjsNCj4gDQo+IGF1X3Jh
bGlnbiBub3cgc2V0cyB0aGUgYWxpZ25tZW50IG9mIHRoZSBfc3RhcnRfIG9mIHRoZSBSUEMgbWVz
c2FnZQ0KPiBib2R5Lg0KPiBUaGUgTUlDIGNvbWVzIF9hZnRlcl8gdGhlIFJQQyBtZXNzYWdlIGJv
ZHkgZm9yIGtyYjVpLg0KPiANCj4gSWYgQmVuIGlzIG9mZiBieSBvbmUgcXVhZCwgdGhhdCdzIG5v
dCB0aGUgTUlDLCB3aGljaCBpcyB0eXBpY2FsbHkgMzINCj4gb2N0ZXRzLA0KPiBpc24ndCBpdD8N
Cj4gDQo+IE1heWJlIHNvbWUgdmFyaWFibGUtbGVuZ3RoIGRhdGEgaXRlbSBpbiB0aGUgcmV0dXJu
ZWQgZmlsZSBhdHRyaWJ1dGVzDQo+IGlzIG1pc3NpbmcNCj4gYW4gWERSIHBhZC4NCg0KVGhlIG9u
bHkgdHdvIHBpZWNlcyBvZiB2YXJpYWJsZSBsZW5ndGggZGF0YSBpbiB0aGUgcmVhZGRpciBwYXls
b2FkIGFyZQ0KdGhlIGZpbGUgbmFtZSBhbmQgdGhlIGZpbGVoYW5kbGUgZGF0YS4gVGhvc2UgbWln
aHQgcHJlc2VudCBhIHByb2JsZW0NCndoZW4gZW5jb2Rpbmcgb24gdGhlIHNlcnZlciBzaWRlLCBi
dXQgbm90IHdoZW4gZGVjb2Rpbmcgb24gdGhlIGNsaWVudA0Kc2lkZSwgc2luY2UgdGhleSBhcmUg
ZW1iZWRkZWQgaW4gdGhlIGRpcmxpc3Q0ICh3aGljaCwgYXMgSSBzYWlkLCBpcw0KYXV0b21hdGlj
YWxseSBhbGlnbmVkKS4NCg0KSG1tLi4uIE9uZSB0aGluZyB0aGF0IGRvZXMgYm90aGVyIG1lIGlu
IGJvdGggZ3NzX3Vud3JhcF9yZXNwX2ludGVnKCkNCmFuZCBnc3NfdW53cmFwX3Jlc3BfcHJpdigp
IGlzIHRoYXQgaWYgdGhlIHNlcW5vIGRvZXMgbm90IG1hdGNoLCB0aGVuIHdlDQpyZXR1cm4gRUlP
LiBXaGF0IGlmIHdlIGhhZCB0byByZXRyYW5zbWl0IGEgcmVxdWVzdCwgYnV0IHRoZSBzZXJ2ZXIN
Cm1hbmFnZWQgdG8gc3F1ZWV6ZSBvZmYgYSByZXBseSB0byB0aGUgZmlyc3QgdHJhbnNtaXNzaW9u
Pw0KTm90ZTogaXQgc2hvdWxkIGJlIHByZXR0eSBlYXN5IHRvIGNhdGNoIGlzc3VlcyBzdWNoIGFz
IHRoaXMsIHNpbmNlIHdlDQpkbyBoYXZlIHRyYWNlcG9pbnRzIGZvciB0aGVtLiBUaGF0IHNhaWQs
IGl0IGlzIHByZXR0eSBoYXJkIHRvIGltYWdpbmUNCnRoaXMgYmVpbmcgdGhlIHByb2JsZW0gaGVy
ZSBpZiB0aGUgYnVnIGlzIGFsd2F5cyByZXByb2R1Y2libGUgKHNpbmNlDQpyZXRyYW5zbWlzc2lv
bnMgdHlwaWNhbGx5IGFyZSBub3QpLg0KDQotLSANClRyb25kIE15a2xlYnVzdA0KTGludXggTkZT
IGNsaWVudCBtYWludGFpbmVyLCBIYW1tZXJzcGFjZQ0KdHJvbmQubXlrbGVidXN0QGhhbW1lcnNw
YWNlLmNvbQ0KDQoNCg==

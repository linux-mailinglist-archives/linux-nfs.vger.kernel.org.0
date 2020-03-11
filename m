Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0E058181F00
	for <lists+linux-nfs@lfdr.de>; Wed, 11 Mar 2020 18:16:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730235AbgCKRQS (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 11 Mar 2020 13:16:18 -0400
Received: from mail-eopbgr770074.outbound.protection.outlook.com ([40.107.77.74]:33345
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730453AbgCKRQS (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Wed, 11 Mar 2020 13:16:18 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GDnaMTUdcjafdH0MKf/fbMdFiba8CR77BWbDfbxBzkadJXEmkFl2MWUBdPctuFYcVrYXI+PLa4th3lMj9AVJmTA0doU+lCON3h6nBNWmTTkGswOyJqrAPHEcYArMMPFq1RuIbDlDF9xXz6GG0Gms1cr0YDbifTCDMYOFe61gx/BU1dt52102YVHCURs1D/yFqG8Wg0R/iHYwlvP+ir36xkxNMWMgDBx6NP7uVlsI7aFqR1SK8FcTNpYx1wv9uCa86OwbpyTJZKT7dF4fQKZh5LbQRJFa6qPLjwQjsPIQ1zm7XrHNL1DDrMEhJhYzq/RsRN8gnGA9uPbMVQoZl7yNGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5bPLrcuNb7zb5zjvx17giZ0c3jSJ0z4BjNRxBg006ak=;
 b=nrLH6an8UZH0TgNebiKlrsP3KSq7bSmzA7932MCbkp9epK6QkgrJ3/CA6QyeWI7/CL/txNG93g7fF/C5KRf3M9dgKm//jz4fTfTZy4TGHv5CKqJmPVzdJiPCAuH68siQgbiblcjRNwgdijWGILEG0PUfs+n2k2jg7jfFSehil4Fa5gwL3gWeUFdN1n/a+vMtf8JR8GS5S7WV41rfILBIbBb3TaGhxwJGuRcUa0h7zLqOBETFu/76Guq9Hdk9BSfBTTVj9EZqeECdBL099XjGVKO9EVKGFqrFBGOesYouttqH0/yLaY+UASR+Lh52JvssEpyVjnVSlpWsDchkjKyoSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=netapp.com; dmarc=pass action=none header.from=netapp.com;
 dkim=pass header.d=netapp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=netapp.onmicrosoft.com; s=selector1-netapp-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5bPLrcuNb7zb5zjvx17giZ0c3jSJ0z4BjNRxBg006ak=;
 b=n7DZYEEtHO2J/BLISs8YKXKCbvBeqfubo5be7XF7b5uSxXxYWZGZViFkuzADWen6/IF+s/8GcY7FcgpBu+X0Ze4u6/GEk+MuXs4OhTjBLL6wrlZwqYxwY5C+qvi8g9iKWTEbgoQc9cGmg3brS+yzaTnS2AL5RFAsioiaS0Wg6L4=
Received: from DM6PR06MB6617.namprd06.prod.outlook.com (2603:10b6:5:25f::14)
 by DM6PR06MB6058.namprd06.prod.outlook.com (2603:10b6:5:108::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2793.16; Wed, 11 Mar
 2020 17:16:03 +0000
Received: from DM6PR06MB6617.namprd06.prod.outlook.com
 ([fe80::f1d5:1417:3acd:c3be]) by DM6PR06MB6617.namprd06.prod.outlook.com
 ([fe80::f1d5:1417:3acd:c3be%6]) with mapi id 15.20.2793.013; Wed, 11 Mar 2020
 17:16:03 +0000
From:   "Schumaker, Anna" <Anna.Schumaker@netapp.com>
To:     "chucklever@gmail.com" <chucklever@gmail.com>
CC:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Subject: Re: [PATCH v1 00/11] NFS/RDMA client side connection overhaul
Thread-Topic: [PATCH v1 00/11] NFS/RDMA client side connection overhaul
Thread-Index: AQHV97mmoXijF6aOKkWfrtPieJQTOahDogiA
Date:   Wed, 11 Mar 2020 17:16:03 +0000
Message-ID: <8572bf1221aec75c3f37f437caee396f379e764a.camel@netapp.com>
References: <20200221214906.2072.32572.stgit@manet.1015granger.net>
         <AA5039EB-DDA0-44CA-B382-61BD544A330A@gmail.com>
In-Reply-To: <AA5039EB-DDA0-44CA-B382-61BD544A330A@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.36.0 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Anna.Schumaker@netapp.com; 
x-originating-ip: [68.32.74.190]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d3cc8b9d-3cf1-4b38-717a-08d7c5dfe0df
x-ms-traffictypediagnostic: DM6PR06MB6058:
x-microsoft-antispam-prvs: <DM6PR06MB605890C9B5ED8FC823C59A09F8FC0@DM6PR06MB6058.namprd06.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 0339F89554
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(396003)(346002)(376002)(136003)(39860400002)(366004)(199004)(2906002)(2616005)(6512007)(6916009)(71200400001)(4326008)(66946007)(86362001)(186003)(5660300002)(91956017)(81156014)(6486002)(81166006)(36756003)(54906003)(8936002)(76116006)(316002)(66446008)(26005)(66476007)(8676002)(53546011)(66556008)(64756008)(6506007)(478600001);DIR:OUT;SFP:1101;SCL:1;SRVR:DM6PR06MB6058;H:DM6PR06MB6617.namprd06.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;
received-spf: None (protection.outlook.com: netapp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: MC4tvmBJaRRxu9I1zzZTRjIKMHwu/z6n8Jl4b1SqkYayp+WPJCdopjNh2TEWKEL8+AoZWNj+mgp8o38DCLgu89EeG8+StkZN+KOjW341NVk6HDFAA06p5dPC1h14kmmyj0qkBGXGhQlUQcYYf3RBlHffXXTPI3B+YJksnpza7IViVx+hDD1jqAm6gDCNpUK/w5jGycngDZt2i7mmur7UQGvHAj0cKyQEjh9D7sbBGDj9RwO3cci+L7PsgVJkz6zLWfvUpKAPv6ECpKzTTkqji772Y0cUtmLdLyfwzogV7MqontOM9siZEKsG9icBBVAjipU8Z9QvhL842u6F4YE/en8PvNrB935++veHl7uUWiHHqIKM7vsRTRQFz8l29yN8JRgWY7psH8Med0ONNIeBmIxS/rLbipCFmhIgY7qJ7gyFa5RUNIiuovlRg8roJjeG
x-ms-exchange-antispam-messagedata: NLABDZ+HYn+Aq0JF6Jx8CzOpv6JSfEqXVVI/oMvYvTx2fD7T12ef1DKCDdxUGu7FAK0vXS8foX1a3zcCKkWRdnlDd7ZhOxn7t2bAlX+f/q1KKUuVRFI6fMy4qvGEy8cmtfPd3VS4inZP/ie2X17IwQ==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <D60D88EA3A5F7D4C98E33261EE990E46@namprd06.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: netapp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d3cc8b9d-3cf1-4b38-717a-08d7c5dfe0df
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Mar 2020 17:16:03.6198
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4b0911a0-929b-4715-944b-c03745165b3a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: i2C5Ycj9SROjHkqFnVeh3H8igTMh0sc28QxQvXs4FZ/M1WnD4TKldusdTnfMB8OKumo1rno4ZnFhXgoZeCh8tQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR06MB6058
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

SGkgQ2h1Y2ssDQoNCk9uIFdlZCwgMjAyMC0wMy0xMSBhdCAxMToyNyAtMDQwMCwgQ2h1Y2sgTGV2
ZXIgd3JvdGU6DQo+IEhpIEFubmEsIEkgZG9uJ3QgcmVjYWxsIHJlY2VpdmluZyBhbnkgY29tbWVu
dHMgdGhhdCByZXF1aXJlIG1vZGlmeWluZw0KPiB0aGlzIHNlcmllcy4gRG8geW91IHdhbnQgbWUg
dG8gcmVzZW5kIGl0IGZvciB0aGUgbmV4dCBtZXJnZSB3aW5kb3c/DQoNCklmIHRoZXJlIGhhdmVu
J3QgYmVlbiBhbnkgY2hhbmdlcywgdGhlbiBJJ2xsIGp1c3QgdXNlIHRoZSB2ZXJzaW9uIHlvdSd2
ZSBhbHJlYWR5DQpwb3N0ZWQuIE5vIG5lZWQgdG8gcmVzZW5kLg0KDQpUaGFua3MgZm9yIGNoZWNr
aW5nIQ0KQW5uYQ0KDQo+IA0KPiANCj4gPiBPbiBGZWIgMjEsIDIwMjAsIGF0IDU6MDAgUE0sIENo
dWNrIExldmVyIDxjaHVjay5sZXZlckBvcmFjbGUuY29tPiB3cm90ZToNCj4gPiANCj4gPiBIb3dk
eS4NCj4gPiANCj4gPiBJJ3ZlIGhhZCByZXBvcnRzIChhbmQgcGVyc29uYWwgZXhwZXJpZW5jZSkg
d2hlcmUgdGhlIExpbnV4IE5GUy9SRE1BDQo+ID4gY2xpZW50IHdhaXRzIGZvciBhIHZlcnkgbG9u
ZyB0aW1lIGFmdGVyIGEgZGlzcnVwdGlvbiBvZiB0aGUgbmV0d29yaw0KPiA+IG9yIE5GUyBzZXJ2
ZXIuDQo+ID4gDQo+ID4gVGhlcmUgaXMgYSBkaXNjb25uZWN0IHRpbWUgd2FpdCBpbiB0aGUgQ29u
bmVjdGlvbiBNYW5hZ2VyIHdoaWNoDQo+ID4gYmxvY2tzIHRoZSBSUEMvUkRNQSB0cmFuc3BvcnQg
ZnJvbSB0ZWFyaW5nIGRvd24gYSBjb25uZWN0aW9uIGZvciBhDQo+ID4gZmV3IG1pbnV0ZXMgd2hl
biB0aGUgcmVtb3RlIGNhbm5vdCByZXNwb25kIHRvIERSRVEgbWVzc2FnZXMuDQo+ID4gDQo+ID4g
QW4gUlBDL1JETUEgdHJhbnNwb3J0IGhhcyBvbmx5IG9uZSBzbG90IGZvciBjb25uZWN0aW9uIHN0
YXRlLCBzbyB0aGUNCj4gPiB0cmFuc3BvcnQgaXMgcHJldmVudGVkIGZyb20gZXN0YWJsaXNoaW5n
IGEgZnJlc2ggY29ubmVjdGlvbiB1bnRpbA0KPiA+IHRoZSB0aW1lIHdhaXQgY29tcGxldGVzLg0K
PiA+IA0KPiA+IFRoaXMgcGF0Y2ggc2VyaWVzIHJlZmFjdG9ycyB0aGUgY29ubmVjdGlvbiBlbmQg
cG9pbnQgZGF0YSBzdHJ1Y3R1cmVzDQo+ID4gdG8gZW5hYmxlIG9uZSBhY3RpdmUgYW5kIG11bHRp
cGxlIHpvbWJpZSBjb25uZWN0aW9ucy4gTm93LCB3aGlsZSBhDQo+ID4gZGVmdW5jdCBjb25uZWN0
aW9uIGlzIHdhaXRpbmcgdG8gZGllLCBpdCBpcyBzZXBhcmF0ZWQgZnJvbSB0aGUNCj4gPiB0cmFu
c3BvcnQsIGNsZWFyaW5nIHRoZSB3YXkgZm9yIHRoZSBpbW1lZGlhdGUgY3JlYXRpb24gb2YgYSBu
ZXcNCj4gPiBjb25uZWN0aW9uLiBDbGVhbi11cCBvZiB0aGUgb2xkIGNvbm5lY3Rpb24ncyBkYXRh
IHN0cnVjdHVyZXMgYW5kDQo+ID4gcmVzb3VyY2VzIHRoZW4gY29tcGxldGVzIGluIHRoZSBiYWNr
Z3JvdW5kLg0KPiA+IA0KPiA+IFdlbGwsIHRoYXQncyB0aGUgaWRlYSwgYW55d2F5LiBSZXZpZXcg
YW5kIGNvbW1lbnRzIHdlbGNvbWUuIEhvcGluZw0KPiA+IHRoaXMgY2FuIGJlIG1lcmdlZCBpbiB2
NS43Lg0KPiA+IA0KPiA+IC0tLQ0KPiA+IA0KPiA+IENodWNrIExldmVyICgxMSk6DQo+ID4gICAg
ICB4cHJ0cmRtYTogSW52b2tlIHJwY3JkbWFfZXBfY3JlYXRlKCkgaW4gdGhlIGNvbm5lY3Qgd29y
a2VyDQo+ID4gICAgICB4cHJ0cmRtYTogUmVmYWN0b3IgZnJ3cl9pbml0X21yKCkNCj4gPiAgICAg
IHhwcnRyZG1hOiBDbGVhbiB1cCB0aGUgcG9zdF9zZW5kIHBhdGgNCj4gPiAgICAgIHhwcnRyZG1h
OiBSZWZhY3RvciBycGNyZG1hX2VwX2Nvbm5lY3QoKSBhbmQgcnBjcmRtYV9lcF9kaXNjb25uZWN0
KCkNCj4gPiAgICAgIHhwcnRyZG1hOiBBbGxvY2F0ZSBQcm90ZWN0aW9uIERvbWFpbiBpbiBycGNy
ZG1hX2VwX2NyZWF0ZSgpDQo+ID4gICAgICB4cHJ0cmRtYTogSW52b2tlIHJwY3JkbWFfaWFfb3Bl
biBpbiB0aGUgY29ubmVjdCB3b3JrZXINCj4gPiAgICAgIHhwcnRyZG1hOiBSZW1vdmUgcnBjcmRt
YV9pYTo6cmlfZmxhZ3MNCj4gPiAgICAgIHhwcnRyZG1hOiBEaXNjb25uZWN0IG9uIGZsdXNoZWQg
Y29tcGxldGlvbg0KPiA+ICAgICAgeHBydHJkbWE6IE1lcmdlIHN0cnVjdCBycGNyZG1hX2lhIGlu
dG8gc3RydWN0IHJwY3JkbWFfZXANCj4gPiAgICAgIHhwcnRyZG1hOiBFeHRyYWN0IHNvY2thZGRy
IGZyb20gc3RydWN0IHJkbWFfY21faWQNCj4gPiAgICAgIHhwcnRyZG1hOiBrbWFsbG9jIHJwY3Jk
bWFfZXAgc2VwYXJhdGUgZnJvbSBycGNyZG1hX3hwcnQNCj4gPiANCj4gPiANCj4gPiBpbmNsdWRl
L3RyYWNlL2V2ZW50cy9ycGNyZG1hLmggICAgfCAgIDk3ICsrLS0tDQo+ID4gbmV0L3N1bnJwYy94
cHJ0cmRtYS9iYWNrY2hhbm5lbC5jIHwgICAgOCANCj4gPiBuZXQvc3VucnBjL3hwcnRyZG1hL2Zy
d3Jfb3BzLmMgICAgfCAgMTUyICsrKystLS0tDQo+ID4gbmV0L3N1bnJwYy94cHJ0cmRtYS9ycGNf
cmRtYS5jICAgIHwgICAzMiArLQ0KPiA+IG5ldC9zdW5ycGMveHBydHJkbWEvdHJhbnNwb3J0LmMg
ICB8ICAgNzIgKy0tLQ0KPiA+IG5ldC9zdW5ycGMveHBydHJkbWEvdmVyYnMuYyAgICAgICB8ICA2
ODEgKysrKysrKysrKysrKystLS0tLS0tLS0tLS0tLS0tLS0tLS0NCj4gPiAtLQ0KPiA+IG5ldC9z
dW5ycGMveHBydHJkbWEveHBydF9yZG1hLmggICB8ICAgODkgKystLS0NCj4gPiA3IGZpbGVzIGNo
YW5nZWQsIDQ0NSBpbnNlcnRpb25zKCspLCA2ODYgZGVsZXRpb25zKC0pDQo+ID4gDQo+ID4gLS0N
Cj4gPiBDaHVjayBMZXZlcg0K

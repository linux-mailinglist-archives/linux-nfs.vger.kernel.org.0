Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9D81111D2A5
	for <lists+linux-nfs@lfdr.de>; Thu, 12 Dec 2019 17:47:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729771AbfLLQr6 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 12 Dec 2019 11:47:58 -0500
Received: from mail-dm6nam11on2097.outbound.protection.outlook.com ([40.107.223.97]:56064
        "EHLO NAM11-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729762AbfLLQr6 (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Thu, 12 Dec 2019 11:47:58 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oWOT9pJzaS//5lTtFdEkxX2GM7c2B/2bVpjIbrgWeHm+FPfASnBcmc3Tq6rvUZyJ7gq7n617LOvuskqQB4y62rcEA7MaADrOVhs5ex17i/25ko6MYpsHOG9b7smy8WZgYvh6wNuW1dlaWwpSCGbEx8URVjt7d2xMmM0A8P7MYHSyenoBiHAcvHekxBUArpJTx6o4MsFFSfF2ddOjbPre3/g/w2l6V0UlfRXlfBjRvLF0h59M6/Q82vaRJ9tpAD3BFk+T144z/Z4nmBPPBuJbMAC2CzM2Lu2ihks6DHPKPcG3UcxwLsxP45bSN8dRsUtT1tdja959xtrYNmON/yU0HA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jsk+sIKx3YaCmOCUd8aPXAdKOlxomo2XL6gFAtmkObY=;
 b=hbOJb12SU2W9PohLjvQv/lqmFgnTfoaFUuQ8XSMFo4JjRnxE0lBUbtCKzGE6OrwasmtVfw6aeKzKvwdf6Ci/LQ7/xBaC7Q9MU/ep7OjKP6cFidoXmP7WsG2MIL974vTWDh32EEC8nE8fnq59snxTpBeTx5mRCcA5VPqb35YwF86xlgOsVTKg59Quijbjk9pfHDBDPO9ycGA/vJheUhIARP4NgpGN8DjoVukjaJgDIFMcWVeT2B2LCRWx9+tLmhs6CGuGlTdZ+vUqdlhl9PHKRaBIDbSH7eP3Awgy2z7WbOIpLKo5Lg2UMxrVb1RQMi9DBkNVDElxL22Nats4fx+33Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jsk+sIKx3YaCmOCUd8aPXAdKOlxomo2XL6gFAtmkObY=;
 b=FNRs6xUN+k1o/hoB4S5Pro1OJNIUtsssz/9Y1tpDYLuv9kZhNON3GQCCUcgwahsHB/Bnr//bXIQXpG4IF7GiOSUyADTxc+1gSI0ctvmn4KGONuh6j7e2AVaZrD0R5+YZt/2/RotxUxkW9fMD8V6o5UlcFFpIn62CHH8ajYqwCGM=
Received: from DM5PR1301MB2108.namprd13.prod.outlook.com (10.174.186.34) by
 DM5PR1301MB2185.namprd13.prod.outlook.com (10.174.181.167) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2538.9; Thu, 12 Dec 2019 16:47:55 +0000
Received: from DM5PR1301MB2108.namprd13.prod.outlook.com
 ([fe80::2d23:b456:d67:f230]) by DM5PR1301MB2108.namprd13.prod.outlook.com
 ([fe80::2d23:b456:d67:f230%6]) with mapi id 15.20.2538.012; Thu, 12 Dec 2019
 16:47:54 +0000
From:   Trond Myklebust <trondmy@hammerspace.com>
To:     "aglo@umich.edu" <aglo@umich.edu>
CC:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
Subject: Re: NFS/TCP timeouts
Thread-Topic: NFS/TCP timeouts
Thread-Index: AQHUW0dNKoxhP3zTWk27MD4kbuUnMqUN3AmAgAAFqICCqizyAIABUpmA
Date:   Thu, 12 Dec 2019 16:47:54 +0000
Message-ID: <b90ab1ae883db0109e3a0b390fa5cc599268819c.camel@hammerspace.com>
References: <CAN-5tyH_+OZJ+eUGvqvo+-EuG1OdaoFYERNKi=k=CDxpOFVoCQ@mail.gmail.com>
         <e2541b5d08b823aaec01195178e87ba39526aa92.camel@hammerspace.com>
         <CAN-5tyFVb_jqt+jknn2+o6_Cu=7cKw4qt9B_e2pd0azu2-7zaQ@mail.gmail.com>
         <CAN-5tyHm+aG9GmM1EWFDLeKfLxJWvGSGbRP5QwN4=phwaNQkyQ@mail.gmail.com>
In-Reply-To: <CAN-5tyHm+aG9GmM1EWFDLeKfLxJWvGSGbRP5QwN4=phwaNQkyQ@mail.gmail.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=trondmy@hammerspace.com; 
x-originating-ip: [68.40.189.247]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6f941a65-4282-4458-dbe5-08d77f230910
x-ms-traffictypediagnostic: DM5PR1301MB2185:
x-microsoft-antispam-prvs: <DM5PR1301MB21857768E3EAC6581DEA0C0CB8550@DM5PR1301MB2185.namprd13.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 0249EFCB0B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(396003)(136003)(346002)(39840400004)(376002)(189003)(199004)(81166006)(3480700005)(8936002)(6486002)(71200400001)(81156014)(8676002)(2906002)(6512007)(4326008)(53546011)(26005)(508600001)(4001150100001)(6506007)(91956017)(76116006)(186003)(86362001)(36756003)(5660300002)(66946007)(64756008)(66446008)(66476007)(66556008)(316002)(6916009)(2616005);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR1301MB2185;H:DM5PR1301MB2108.namprd13.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: hammerspace.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: KxNEuyOLDqe+jxGz4Lzqjdd2mh1jk4OfWKMhTcLwj8ovc2G5jWcNAQ+5M+Di2YS36mmVYtueR35sIfZ9IJqjNdHbjw25y1rYJEau7Pc0p+GPHD1whCsJR4M9KQ1+SS7FPzND22Xpil9ugUyUfOaNUcsvVWZXOspgPqjE+nYgL26m4pPYPFHrsZw1Mz7KNk2afji/RR29HhOL6mIOt8AUHCbEInBm7IZ5QHr1IjLTnnxXKrD7DqvnBftwtFuKzSEVascM0+NqSIH0+rFIp003+8ejhAKWg1WwpD98CbebH4IION7CA1wbIEkiZhzQaMHLrU/2pugMReyEYruvvGxv726RvGh2xCh818yww27YJvbCGn/8VaOYZBdLRWKp4tisbtFMvjYUe6K0HEEdO3W6N5lAYiqPwK+mNeH9MBIUAX7niEySqRQmWTKBx+lH9A4C
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <E36848CA525C0B4A80D7FCCEB44277A7@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f941a65-4282-4458-dbe5-08d77f230910
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Dec 2019 16:47:54.7717
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /wPHe854wwmrQJ0sqn96SNXPSNMtclkv868XcuFZdms8lpZSZeIFKJFRDdvrRuYCgHR0w6Gs++UiYRXM67VexQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1301MB2185
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

SGkgT2xnYSwNCg0KT24gV2VkLCAyMDE5LTEyLTExIGF0IDE1OjM2IC0wNTAwLCBPbGdhIEtvcm5p
ZXZza2FpYSB3cm90ZToNCj4gSGkgVHJvbmQsDQo+IA0KPiBJJ2QgbGlrZSB0byByYWlzZSB0aGlz
IG9uY2UgYWdhaW4uIElzIHRoaXMgdHJ1ZSB0aGF0IHNldHRpbmcgYQ0KPiB0aW1lb3V0DQo+IGxp
bWl0IChUQ1BfVVNFUl9USU1FT1VUKSBpcyBub3QgdXNlciBjb25maWd1cmFibGUgKHJhdGhlciBJ
J20gcHJldHR5DQo+IHN1cmUgaXQgaXMgbm90KSBidXQgbXkgcXVlc3Rpb24gaXMgd2h5IHNob3Vs
ZG4ndCBpdCBiZSB0aWVkIHRvIHRoZQ0KPiAidGltZW8iIG1vdW50IG9wdGlvbj8gUmlnaHQgbm93
LCBvbmx5IHRoZSBzZXNzb24vbGVhc2UgbWFuYWdlciB0aHJlYWQNCj4gc2V0cyBpdCB2aWEgcnBj
X3NldF9jb25uZWN0X3RpbWVvdXQoKSB0byBiZSBsZWFzZSBwZXJpb2QgcmVsYXRlZC4NCj4gDQo+
IElzIGl0IHRoZSBmYWN0IHRoYXQgd2UgZG9uJ3Qgd2FudCB0byBhbGxvdyB1c2VyIHRvIGNvbnRy
b2wgVENQDQo+IHNldHRpbmdzIHZpYSB0aGUgbW91bnQgb3B0aW9ucz8gQnV0IHNvbWVob3cgZm9s
a3MgYXJlIGV4cGVjdGluZyB0byBiZQ0KPiBhYmxlIHRvIHNldCBsb3cgInRpbWVvIiB2YWx1ZSBh
bmQgaGF2ZSB0aGUgKGRlYWQpIGNvbm5lY3Rpb24gdG8gYmUNCj4gY29uc2lkZXJlZCBkZWFkIGVh
cmxpZXIgdGhhbiBmb3IgYSByYXRoZXIgbG9uZyB0aW1lb3V0IHBlcmlvZCB3aGljaA0KPiBpcw0K
PiBoYXBwZW5pbmcgbm93Lg0KDQpJbiBteSBtaW5kLCB0aGUgdHdvIGFyZSBjb3JyZWxhdGVkLCBi
dXQgYXJlIG5vdCBlcXVpdmFsZW50Lg0KDQpUaGUgJ3RpbWVvJyB2YWx1ZSBpcyBiYXNpY2FsbHkg
YSB0aW1lb3V0IGZvciBob3cgbG9uZyBpdCB0YWtlcyBmb3IgdGhlDQp3aG9sZSBwcm9jZXNzIG9m
ICJzZW5kIFJQQyBjYWxsIiwgImhhdmUgaXQgcHJvY2Vzc2VkIGJ5IHRoZSBzZXJ2ZXIiIGFuZA0K
InJlY2VpdmUgcmVwbHkiLg0KSU9XOiAndGltZW8nIGlzIGFib3V0IGhvdyBsb25nIGl0IHRha2Vz
IGZvciBhbiBSUEMgY2FsbCB0byBleGVjdXRlIGVuZC0NCnRvLWVuZC4NCg0KVGhlIFRDUF9VU0VS
X1RJTUVPVVQsIGlzIGVzc2VudGlhbGx5IGEgdGltZW91dCBmb3IgaG93IGxvbmcgaXQgdGFrZXMN
CnRoZSBzZXJ2ZXIgdG8gQUNLIHJlY2VpcHQgb2YgdGhlIFJQQyBjYWxsIG9uY2Ugd2UndmUgcGxh
Y2VkIGl0IGluIHRoZQ0KVENQIHNvY2tldC4NCklPVzogaXQgaXMgYSB0aW1lb3V0IGZvciB0aGUg
bmV0d29ya2luZyBwYXJ0IG9mIGFuIFJQQyBjYWxsDQp0cmFuc21pc3Npb24uDQoNClNvLCBhcyBJ
IHNhaWQsIHRoZSB0d28gYXJlIGNvcnJlbGF0ZWQ6IGlmIHRoZSBzZXJ2ZXIgaXMgZG93biwgdGhl
biB5b3VyDQp0aW1lb3V0IGlzIGRvbWluYXRlZCBieSB0aGUgZmFjdCB0aGF0IHRoZSBuZXR3b3Jr
IHRyYW5zbWlzc2lvbiBuZXZlcg0KY29tcGxldGVzLiBIb3dldmVyIGlmIHRoZSBzZXJ2ZXIgaXMg
dXAgYW5kIGNvbmdlc3RlZCwgdGhlbiB0aGUNCiJwcm9jZXNzaW5nIGJ5IHRoZSBzZXJ2ZXIiIGlz
IGxpa2VseSB0byBkb21pbmF0ZS4NCg0KVGhlIG90aGVyIHRoaW5nIHRvIG5vdGUgaXMgdGhhdCBp
ZiB0aGUgVENQIGNvbm5lY3Rpb24gaXMgdW5yZXNwb25zaXZlLA0Kd2UgbWF5IHdhbnQgdG8gZmFp
bCB0aGF0IG11Y2ggZmFzdGVyIGluIG9yZGVyIHRvIGdpdmUgb3Vyc2VsdmVzIGENCmNoYW5jZSB0
byBjbG9zZSB0aGUgY29ubmVjdGlvbiwgb3BlbiBhIG5ldyBvbmUgYW5kIHJldHJhbnNtaXQgdGhl
DQpyZXF1ZXN0cyBmcm9tIHRoZSBvbGQgY29ubmVjdGlvbiBiZWZvcmUgdGhlICd0aW1lbycgaXMg
dHJpZ2dlcmVkIChzaW5jZQ0KaW4gdGhlIGNhc2Ugb2YgYSBzb2Z0IHRpbWVvdXQsIHRoYXQgY291
bGQgYmUgYSBmYXRhbCBlcnJvcikuDQoNCkRvZXMgdGhhdCBtYWtlIHNlbnNlPw0KDQo+IA0KPiBU
aGFua3MuDQo+IA0KPiBPbiBXZWQsIE9jdCAzLCAyMDE4IGF0IDM6MDYgUE0gT2xnYSBLb3JuaWV2
c2thaWEgPGFnbG9AdW1pY2guZWR1Pg0KPiB3cm90ZToNCj4gPiBPbiBXZWQsIE9jdCAzLCAyMDE4
IGF0IDI6NDUgUE0gVHJvbmQgTXlrbGVidXN0IDwNCj4gPiB0cm9uZG15QGhhbW1lcnNwYWNlLmNv
bT4gd3JvdGU6DQo+ID4gPiBPbiBXZWQsIDIwMTgtMTAtMDMgYXQgMTQ6MzEgLTA0MDAsIE9sZ2Eg
S29ybmlldnNrYWlhIHdyb3RlOg0KPiA+ID4gPiBIaSBmb2xrcywNCj4gPiA+ID4gDQo+ID4gPiA+
IElzIGl0IHRydWUgdGhhdCBORlMgbW91bnQgb3B0aW9uICJ0aW1lbyIgaGFzIG5vdGhpbmcgdG8g
ZG8gd2l0aA0KPiA+ID4gPiB0aGUNCj4gPiA+ID4gc29ja2V0J3Mgc2V0dGluZyBvZiB0aGUgdXNl
ci1zcGVjaWZpZWQgdGltZW91dA0KPiA+ID4gPiBUQ1BfVVNFUl9USU1FT1VULg0KPiA+ID4gPiBJ
bnN0ZWFkLCB3aGVuIGNyZWF0aW5nIGEgVENQIHNvY2tldCBORlMgdXNlcyBlaXRoZXINCj4gPiA+
ID4gZGVmYXVsdC9oYXJkDQo+ID4gPiA+IGNvZGVkDQo+ID4gPiA+IHZhbHVlIG9mIDYwcyBmb3Ig
djMgb3IgZm9yIHY0LnggaXQncyBsZWFzZSBiYXNlZC4gSXMgdGhlcmUgbm8NCj4gPiA+ID4gdmFs
dWUNCj4gPiA+ID4gaXMNCj4gPiA+ID4gaGF2aW5nIGFuIGFkanVzdGFibGUgVENQIHRpbWVvdXQg
dmFsdWU/DQo+ID4gPiA+IA0KPiA+ID4gDQo+ID4gPiBJdCBpcyBhZGp1c3RlZC4gUGxlYXNlIHNl
ZSB0aGUgY2FsY3VsYXRpb24gaW4NCj4gPiA+IHhzX3RjcF9zZXRfc29ja2V0X3RpbWVvdXRzKCku
DQo+ID4gDQo+ID4gYnV0IGl0J3Mgbm90IHVzZXIgY29uZmlndXJhYmxlLCBpcyBpdD8gSSBkb24n
dCBzZWUgYSB3YXkgdG8gbW9kaWZ5DQo+ID4gdjMncyBkZWZhdWx0IDYwcyBUQ1AgdGltZW91dC4g
YW5kIGFsc28gaW4gdjQsIHRoZSB0aW1lb3V0cyBhcmUgc2V0DQo+ID4gZnJvbSB4c190Y3Bfc2V0
X2Nvbm5lY3RfdGltZW91dCgpIGZvciB0aGUgbGVhc2UgcGVyaW9kIGJ1dCBhZ2Fpbg0KPiA+IG5v
dA0KPiA+IHVzZXIgY29uZmlndXJhYmxlLCBhcyBmYXIgYXMgaSBjYW4gdGVsbC4NCj4gPiANCj4g
PiA+IC0tDQo+ID4gPiBUcm9uZCBNeWtsZWJ1c3QNCj4gPiA+IExpbnV4IE5GUyBjbGllbnQgbWFp
bnRhaW5lciwgSGFtbWVyc3BhY2UNCj4gPiA+IHRyb25kLm15a2xlYnVzdEBoYW1tZXJzcGFjZS5j
b20NCj4gPiA+IA0KPiA+ID4gDQotLSANClRyb25kIE15a2xlYnVzdA0KTGludXggTkZTIGNsaWVu
dCBtYWludGFpbmVyLCBIYW1tZXJzcGFjZQ0KdHJvbmQubXlrbGVidXN0QGhhbW1lcnNwYWNlLmNv
bQ0KDQoNCg==

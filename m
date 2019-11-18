Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 837B710019A
	for <lists+linux-nfs@lfdr.de>; Mon, 18 Nov 2019 10:46:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726488AbfKRJqY (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 18 Nov 2019 04:46:24 -0500
Received: from mail-eopbgr730118.outbound.protection.outlook.com ([40.107.73.118]:44795
        "EHLO NAM05-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726464AbfKRJqY (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Mon, 18 Nov 2019 04:46:24 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Un71/R+Lku1f7+dHlfEYmcFFIjZEm5qiI6xCs5NsohUOnUPnZteCUATREjydq7AT3jiT1ngDAW9BMlG5u/M0tdd/MFTpMBm8EXyrQka7/yz4RHBaNwmZ2JewK9ahGs2iB3twpCUhVbELbcp2TxyEFFZ73RSqA2WrRwvv1yFlHdw6YXoB9fg266/RmLiRQQvT2EXLhjzetQ73qAEOTMI1DUBwXT0Dm26adulJzTPdA+xMUojGO8dMXVw+HYiouLhIV+aIhPiPJvlo5Ws/YkN/7TOBalAOjZOAmUcv18/AXINP98FoVv199HFw1Qicf1GQK/NQoxQWpN8M5ZKpTwyDag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aFrW4L449Q8if04rnRJMU5cuNZQVNl/IjoeRNYSKHHU=;
 b=LEnhP/rUDAG7k6pZghKiDeG4iN9s1VgJ+nWXmRvrE+zgFGvh8xkKTgsDKfp2OF7L4cYV2ODrd3PkIeXQ9TbGvJ/xLEYgF8eXjbiSTwebioEmHnvHMnTpoUGPk5a5+omt6fgFe68dgnP4HOKJkjbLGWK9pitYJJRLhrt1CQ6QlaOxnZdd6hIJrXnwCEZnA5QLiW+MqFJHrO9+j3S5Qd42HpoNQYVjT6DZ/v22Tp99PeQfVAm4MNIvp+Dww5P777CnEIsqdNFY43Ywq4FWEN7DVyvnSART6IKZu0foHx2xUgaeFA+tUvxjNri6Hj5dsFVCRLHYW3AskLNBOh85gzEMJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aFrW4L449Q8if04rnRJMU5cuNZQVNl/IjoeRNYSKHHU=;
 b=F7TsQ0mMbSHOuaxPkonjQj41ob0/m6gCzQRB7lD61BbVi2HEfU9ZsbpB1TF1ZtYRxAUhmA9s20U3y+v+xKKdVTVKUhho9sPklZJj1mN8PuquE9vGY9hr+j8rAuJ7XP/AVcfrkdvoseUB6D+wAs3zjXAlMhYjx4S+Sn7jSC1haTI=
Received: from DM5PR1301MB2108.namprd13.prod.outlook.com (10.174.186.34) by
 DM5PR1301MB1914.namprd13.prod.outlook.com (10.174.184.148) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2474.12; Mon, 18 Nov 2019 09:46:17 +0000
Received: from DM5PR1301MB2108.namprd13.prod.outlook.com
 ([fe80::2d23:b456:d67:f230]) by DM5PR1301MB2108.namprd13.prod.outlook.com
 ([fe80::2d23:b456:d67:f230%6]) with mapi id 15.20.2474.012; Mon, 18 Nov 2019
 09:46:17 +0000
From:   Trond Myklebust <trondmy@hammerspace.com>
To:     "anna.schumaker@netapp.com" <anna.schumaker@netapp.com>,
        "olga.kornievskaia@gmail.com" <olga.kornievskaia@gmail.com>
CC:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
Subject: Re: [RFC PATCH] NFS: allow deprecation of NFS UDP protocol
Thread-Topic: [RFC PATCH] NFS: allow deprecation of NFS UDP protocol
Thread-Index: AQHVlnv6ytr/FuAC3kGoiE4PYOw0hqeQvQ+A
Date:   Mon, 18 Nov 2019 09:46:17 +0000
Message-ID: <d96b92919fdfba28f53cd2770ebb99715c3d9a04.camel@hammerspace.com>
References: <20191108213201.66194-1-olga.kornievskaia@gmail.com>
In-Reply-To: <20191108213201.66194-1-olga.kornievskaia@gmail.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=trondmy@hammerspace.com; 
x-originating-ip: [88.95.63.95]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 30547686-5941-4fce-4449-08d76c0c28b5
x-ms-traffictypediagnostic: DM5PR1301MB1914:
x-microsoft-antispam-prvs: <DM5PR1301MB1914A8B6691157DD06C66D2DB84D0@DM5PR1301MB1914.namprd13.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5797;
x-forefront-prvs: 0225B0D5BC
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(376002)(396003)(346002)(136003)(39830400003)(189003)(199004)(71200400001)(8936002)(118296001)(81156014)(25786009)(8676002)(6436002)(229853002)(71190400001)(86362001)(6512007)(2906002)(4326008)(2501003)(66066001)(3846002)(316002)(110136005)(6116002)(256004)(14444005)(6246003)(2616005)(446003)(81166006)(11346002)(66446008)(476003)(91956017)(66946007)(66476007)(76116006)(66556008)(99286004)(64756008)(6486002)(486006)(36756003)(76176011)(186003)(26005)(305945005)(478600001)(7736002)(5660300002)(102836004)(14454004)(6506007);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR1301MB1914;H:DM5PR1301MB2108.namprd13.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: hammerspace.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: DNIwK3OgwqwCn063MFkimJzOGJvwOUHdj5zQkj4S+1EkPp3ghaoDeSHZtN+CDxM+U/eEZRdtbxqhw/Otyzhj8oq8XWHuHcCT43duJRMvOZGw71uTs4+jTe2Wli/upMTUK8liHcXT/k+MuirdiUDgVqQcE0KI/QOUGSZUHajuqPLmSxuSKeEN2R3bBnc6fus6u3OMtwC7rsHcw4Mf/mlIkwAKjqX4M57+QcRVJpZin7goPW2jAP5Z+dAvr9l0qkkj7QBKOWLMBs+eiT/BWf+WGpoQarjtbvEyvjx8IJz9bZISY7jg73N2XzD0CS4AkqfOnz8ZdmRnNLDpr9OSCPUR2naNjm7bEQJ9eo0AIplXKt/kaP8Vcrg2DQcjvIFgLbVb12sb3pDNvUmJlEyT23enczCC2x2ctN04H7B01z0j++P7ExbcxQ6X5AQuBpm1sB30
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <B171E58F0122E64997406E4A453411E2@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 30547686-5941-4fce-4449-08d76c0c28b5
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Nov 2019 09:46:17.3520
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WWr+UZ3BUhjaZdO/AKCKEV2EZU7fyTxIOz7CJ0NIoSVV3fQhdTvNuJBu/mNmqkq10vHjtRmleVbVDFlbq3QuqQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1301MB1914
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

SGkgT2xnYQ0KDQpPbiBGcmksIDIwMTktMTEtMDggYXQgMTY6MzIgLTA1MDAsIE9sZ2EgS29ybmll
dnNrYWlhIHdyb3RlOg0KPiBGcm9tOiBPbGdhIEtvcm5pZXZza2FpYSA8a29sZ2FAbmV0YXBwLmNv
bT4NCj4gDQo+IEFkZCBhIGtlcm5lbCBjb25maWcgQ09ORklHX05GU19ESVNBQkxFX1VEUF9TVVBQ
T1JUIHRvIGRpc2FsbG93IE5GUw0KPiBVRFAgbW91bnRzLg0KPiANCj4gSSB0b29rIHRoZSBzYW1l
IGFwcHJvYWNoIGFzIENodWNrJ3MgZGVwcmVjYXRpb24gb2YgREVTIGVuYyB0eXBlcw0KPiB0byBz
dGFydCB3aXRoIGRlZmF1bHQgdG8gc3RpbGwgYWxsb3cgYnV0IEkgdGhpbmsgdGhlIHVsdGltYXRl
DQo+IGdvYWwgaXMgdG8gZGlzYWJsZQ0KPiANCj4gUXVlc3Rpb246IGhvdyBkbyB3ZSBoYXZlIGZv
bGtzIHRyeWluZyB0aGlzIHVubGVzcyB3ZSBzZXQgaXQgdG8gZmFsc2U/DQo+IA0KPiBTaWduZWQt
b2ZmLWJ5OiBPbGdhIEtvcm5pZXZza2FpYSA8a29sZ2FAbmV0YXBwLmNvbT4NCj4gLS0tDQo+ICBm
cy9uZnMvS2NvbmZpZyAgfCAxMCArKysrKysrKysrDQo+ICBmcy9uZnMvY2xpZW50LmMgfCAgNCAr
KysrDQo+ICBmcy9uZnMvc3VwZXIuYyAgfCAgOCArKysrKysrKw0KPiAgMyBmaWxlcyBjaGFuZ2Vk
LCAyMiBpbnNlcnRpb25zKCspDQo+IA0KPiBkaWZmIC0tZ2l0IGEvZnMvbmZzL0tjb25maWcgYi9m
cy9uZnMvS2NvbmZpZw0KPiBpbmRleCAyOTVhN2EyLi42MzIwMTEzIDEwMDY0NA0KPiAtLS0gYS9m
cy9uZnMvS2NvbmZpZw0KPiArKysgYi9mcy9uZnMvS2NvbmZpZw0KPiBAQCAtMTk2LDMgKzE5Niwx
MyBAQCBjb25maWcgTkZTX0RFQlVHDQo+ICAJZGVwZW5kcyBvbiBORlNfRlMgJiYgU1VOUlBDX0RF
QlVHDQo+ICAJc2VsZWN0IENSQzMyDQo+ICAJZGVmYXVsdCB5DQo+ICsNCj4gK2NvbmZpZyBORlNf
RElTQUJMRV9VRFBfU1VQUE9SVA0KPiArCWJvb2wgIk5GUzogRGlzYWJsZSBORlMgVURQIHByb3Rv
Y29sIHN1cHBvcnQiDQo+ICsJZGVwZW5kcyBvbiBORlNfRlMNCj4gKwlkZWZhdWx0IG4NCj4gKwlo
ZWxwDQo+ICsJICBDaG9vc2UgWSBoZXJlIHRvIGRpc2FibGUgdGhlIHVzZSBvZiBORlMgb3ZlciBV
RFAuIE5GUyBvdmVyDQo+IFVEUA0KPiArCSAgb24gbW9kZXJuIG5ldHdvcmtzICgxR2IrKSBjYW4g
bGVhZCB0byBkYXRhIGNvcnJ1cHRpb24gY2F1c2VkDQo+IGJ5DQo+ICsJICBmcmFnbWVudGF0aW9u
IGR1cmluZyBoaWdoIGxvYWRzLg0KPiArCSAgVGhlIGRlZmF1bHQgaXMgTiBiZWNhdXNlIG1hbnkg
ZGVwbG95bWVudHMgc3RpbGwgdXNlIFVEUC4NCj4gZGlmZiAtLWdpdCBhL2ZzL25mcy9jbGllbnQu
YyBiL2ZzL25mcy9jbGllbnQuYw0KPiBpbmRleCAwMjExMGEzLi4yNGNhMzE0IDEwMDY0NA0KPiAt
LS0gYS9mcy9uZnMvY2xpZW50LmMNCj4gKysrIGIvZnMvbmZzL2NsaWVudC5jDQo+IEBAIC00NzQs
NiArNDc0LDcgQEAgdm9pZCBuZnNfaW5pdF90aW1lb3V0X3ZhbHVlcyhzdHJ1Y3QgcnBjX3RpbWVv
dXQNCj4gKnRvLCBpbnQgcHJvdG8sDQo+ICAJCQl0by0+dG9fbWF4dmFsID0gdG8tPnRvX2luaXR2
YWw7DQo+ICAJCXRvLT50b19leHBvbmVudGlhbCA9IDA7DQo+ICAJCWJyZWFrOw0KPiArI2lmZGVm
IENPTkZJR19ORlNfRElTQUJMRV9VRFBfU1VQUE9SVA0KPiAgCWNhc2UgWFBSVF9UUkFOU1BPUlRf
VURQOg0KPiAgCQlpZiAocmV0cmFucyA9PSBORlNfVU5TUEVDX1JFVFJBTlMpDQo+ICAJCQl0by0+
dG9fcmV0cmllcyA9IE5GU19ERUZfVURQX1JFVFJBTlM7DQo+IEBAIC00ODQsNiArNDg1LDcgQEAg
dm9pZCBuZnNfaW5pdF90aW1lb3V0X3ZhbHVlcyhzdHJ1Y3QgcnBjX3RpbWVvdXQNCj4gKnRvLCBp
bnQgcHJvdG8sDQo+ICAJCXRvLT50b19tYXh2YWwgPSBORlNfTUFYX1VEUF9USU1FT1VUOw0KPiAg
CQl0by0+dG9fZXhwb25lbnRpYWwgPSAxOw0KPiAgCQlicmVhazsNCj4gKyNlbmRpZg0KPiAgCWRl
ZmF1bHQ6DQo+ICAJCUJVRygpOw0KPiAgCX0NCj4gQEAgLTU4MCw4ICs1ODIsMTAgQEAgc3RhdGlj
IGludCBuZnNfc3RhcnRfbG9ja2Qoc3RydWN0IG5mc19zZXJ2ZXINCj4gKnNlcnZlcikNCj4gIAkJ
ZGVmYXVsdDoNCj4gIAkJCW5sbV9pbml0LnByb3RvY29sID0gSVBQUk9UT19UQ1A7DQo+ICAJCQli
cmVhazsNCj4gKyNpZmRlZiBDT05GSUdfTkZTX0RJU0FCTEVfVURQX1NVUFBPUlQNCj4gIAkJY2Fz
ZSBYUFJUX1RSQU5TUE9SVF9VRFA6DQo+ICAJCQlubG1faW5pdC5wcm90b2NvbCA9IElQUFJPVE9f
VURQOw0KPiArI2VuZGlmDQo+ICAJfQ0KPiAgDQo+ICAJaG9zdCA9IG5sbWNsbnRfaW5pdCgmbmxt
X2luaXQpOw0KPiBkaWZmIC0tZ2l0IGEvZnMvbmZzL3N1cGVyLmMgYi9mcy9uZnMvc3VwZXIuYw0K
PiBpbmRleCBhODRkZjdkNi4uMjFlNTlkYSAxMDA2NDQNCj4gLS0tIGEvZnMvbmZzL3N1cGVyLmMN
Cj4gKysrIGIvZnMvbmZzL3N1cGVyLmMNCj4gQEAgLTEwMTEsNyArMTAxMSw5IEBAIHN0YXRpYyB2
b2lkIG5mc19zZXRfcG9ydChzdHJ1Y3Qgc29ja2FkZHIgKnNhcCwNCj4gaW50ICpwb3J0LA0KPiAg
c3RhdGljIHZvaWQgbmZzX3ZhbGlkYXRlX3RyYW5zcG9ydF9wcm90b2NvbChzdHJ1Y3QNCj4gbmZz
X3BhcnNlZF9tb3VudF9kYXRhICptbnQpDQo+ICB7DQo+ICAJc3dpdGNoIChtbnQtPm5mc19zZXJ2
ZXIucHJvdG9jb2wpIHsNCj4gKyNpZmRlZiBDT05GSUdfTkZTX0RJU0FCTEVfVURQX1NVUFBPUlQN
Cj4gIAljYXNlIFhQUlRfVFJBTlNQT1JUX1VEUDoNCj4gKyNlbmRpZg0KPiAgCWNhc2UgWFBSVF9U
UkFOU1BPUlRfVENQOg0KPiAgCWNhc2UgWFBSVF9UUkFOU1BPUlRfUkRNQToNCj4gIAkJYnJlYWs7
DQo+IEBAIC0xMDMzLDggKzEwMzUsMTAgQEAgc3RhdGljIHZvaWQNCj4gbmZzX3NldF9tb3VudF90
cmFuc3BvcnRfcHJvdG9jb2woc3RydWN0IG5mc19wYXJzZWRfbW91bnRfZGF0YSAqbW50KQ0KPiAg
CQkJcmV0dXJuOw0KPiAgCXN3aXRjaCAobW50LT5uZnNfc2VydmVyLnByb3RvY29sKSB7DQo+ICAJ
Y2FzZSBYUFJUX1RSQU5TUE9SVF9VRFA6DQo+ICsjaWZkZWYgQ09ORklHX05GU19ESVNBQkxFX1VE
UF9TVVBQT1JUDQo+ICAJCW1udC0+bW91bnRfc2VydmVyLnByb3RvY29sID0gWFBSVF9UUkFOU1BP
UlRfVURQOw0KPiAgCQlicmVhazsNCj4gKyNlbmRpZg0KDQpEb24ndCB3ZSB3YW50IHRvIHJldHVy
biBhbiBlcnJvciBoZXJlIHJhdGhlciB0aGFuIGRlZmF1bHRpbmcgdG8gdGhlDQpUQ1AvUkRNQSBi
ZWhhdmlvdXI/DQoNCj4gIAljYXNlIFhQUlRfVFJBTlNQT1JUX1RDUDoNCj4gIAljYXNlIFhQUlRf
VFJBTlNQT1JUX1JETUE6DQo+ICAJCW1udC0+bW91bnRfc2VydmVyLnByb3RvY29sID0gWFBSVF9U
UkFOU1BPUlRfVENQOw0KPiBAQCAtMjIwNCw2ICsyMjA4LDEwIEBAIHN0YXRpYyBpbnQgbmZzX3Zh
bGlkYXRlX3RleHRfbW91bnRfZGF0YSh2b2lkDQo+ICpvcHRpb25zLA0KPiAgI2VuZGlmIC8qIENP
TkZJR19ORlNfVjQgKi8NCj4gIAl9IGVsc2Ugew0KPiAgCQluZnNfc2V0X21vdW50X3RyYW5zcG9y
dF9wcm90b2NvbChhcmdzKTsNCj4gKyNpZmRlZiBDT05GSUdfTkZTX0RJU0FCTEVfVURQX1NVUFBP
UlQNCj4gKwkJaWYgKGFyZ3MtPm5mc19zZXJ2ZXIucHJvdG9jb2wgPT0gWFBSVF9UUkFOU1BPUlRf
VURQKQ0KPiArCQkJZ290byBvdXRfaW52YWxpZF90cmFuc3BvcnRfdWRwOw0KPiArI2VuZGlmDQo+
ICAJCWlmIChhcmdzLT5uZnNfc2VydmVyLnByb3RvY29sID09IFhQUlRfVFJBTlNQT1JUX1JETUEp
DQo+ICAJCQlwb3J0ID0gTkZTX1JETUFfUE9SVDsNCj4gIAl9DQotLSANClRyb25kIE15a2xlYnVz
dA0KTGludXggTkZTIGNsaWVudCBtYWludGFpbmVyLCBIYW1tZXJzcGFjZQ0KdHJvbmQubXlrbGVi
dXN0QGhhbW1lcnNwYWNlLmNvbQ0KDQoNCg==

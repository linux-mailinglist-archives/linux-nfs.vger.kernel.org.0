Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 76C0B274AF9
	for <lists+linux-nfs@lfdr.de>; Tue, 22 Sep 2020 23:15:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726607AbgIVVPJ (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 22 Sep 2020 17:15:09 -0400
Received: from mail-eopbgr690112.outbound.protection.outlook.com ([40.107.69.112]:22403
        "EHLO NAM04-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726563AbgIVVPI (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Tue, 22 Sep 2020 17:15:08 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NMlzecYdDJzpI579QyacpCbNTd+Fpf6qGBhuuMDs366BYq2VbnmXngMBHKpZwOvGGG47psote47YG08puQDPgqO5x5isvL8SiiqpGFUJHvzbeLjPtXHixMGxt9sDvMCNevSRN5H2kig6DB0SVBMxPFDix6zIGvzNedkbFqt+UQru5OZJUZ0/gK3u/4bPFYloS3ToyACs6Tk31MloR2bnrGRq6oEYD+8NZ0jwrkRLNxhloPefksSnQ6EivsafZ3fkGvpoWECZmlnI5l/S0y4EgsDycffYn0lRul7wDutx2hTLxS6pxUOj43+LvlWBTjgGDRD/rR2IGpVduEJAqnijVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1u66DojvhTVFIMecGAN8/lTtnKUNTb2xJaIbs8lIgEE=;
 b=DZXCqbUIxPkpRbG2NBkPfEEZSWNgA371ZfC5J8tJJ/Gr591zlYPWOqX0FysJ2XWnLDUfobg9WYS8ViH1EcETreOHfUfiVjcs4rqgO8auiL/IGvY2cFZU6aeqHvtpm4gYvfMcrvKhJOCvMsoEwIdQ3mqf7m3K/d7z4Mlba9gQWXpjjncP+p2WmpM/8mwlk4Im0BZALSpsa0qEFsSX8isfG84u/AzvzJZNJQ20vh9C6EkEhwFkdGn1KtM+dzBkjx6HoG9T4yHpaNePaCrSMFtkFjNOnjDNPK2hnT4QsVULMdCLxd0J9L5ZmHz5XrjhpC/n1YaFzAxZYz0BsHCc3GHgsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1u66DojvhTVFIMecGAN8/lTtnKUNTb2xJaIbs8lIgEE=;
 b=I98eMFe6++OVNq9jrkEqZRkx9z67UYmiqc+82i8/ToGOf/Ey76LY8jGco1uZf7IbfG5qC6bSpnU5+kek3j+f7rTqjPwYuRe//9KT/88+cl190Z6MaAudIMLCvrh9nC6xA71RibnCpzJNySY4dV305psA0GKY9t6Wq+DdemY0TLU=
Received: from MN2PR13MB3957.namprd13.prod.outlook.com (2603:10b6:208:263::11)
 by MN2PR13MB3869.namprd13.prod.outlook.com (2603:10b6:208:1e0::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3412.7; Tue, 22 Sep
 2020 21:15:03 +0000
Received: from MN2PR13MB3957.namprd13.prod.outlook.com
 ([fe80::e8a1:6acc:70f0:ef39]) by MN2PR13MB3957.namprd13.prod.outlook.com
 ([fe80::e8a1:6acc:70f0:ef39%6]) with mapi id 15.20.3412.020; Tue, 22 Sep 2020
 21:15:03 +0000
From:   Trond Myklebust <trondmy@hammerspace.com>
To:     "bcodding@redhat.com" <bcodding@redhat.com>
CC:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "anna.schumaker@netapp.com" <anna.schumaker@netapp.com>
Subject: Re: [PATCH 1/2 v2] NFSv4: Fix a livelock when CLOSE pre-emptively
 bumps state sequence
Thread-Topic: [PATCH 1/2 v2] NFSv4: Fix a livelock when CLOSE pre-emptively
 bumps state sequence
Thread-Index: AQHWkRTNIqDVyz0uzUW0tMAc3PwMmal1EH0AgAAWcACAAAHHAA==
Date:   Tue, 22 Sep 2020 21:15:03 +0000
Message-ID: <ad2189f161a657118868fe1c2897b2e661e04261.camel@hammerspace.com>
References: <cover.1600801124.git.bcodding@redhat.com>
         <a641f9a42786d4699ec99cafa14ab5272a9362bf.1600801124.git.bcodding@redhat.com>
         <d6c2ce2b4c0517bd430b4005c4c96d118fba6f3a.camel@hammerspace.com>
         <75089C5A-31C2-4BF2-AD01-BC9D923FCE4B@redhat.com>
In-Reply-To: <75089C5A-31C2-4BF2-AD01-BC9D923FCE4B@redhat.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=hammerspace.com;
x-originating-ip: [68.36.133.222]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: fbf95c69-3e87-4bc9-c454-08d85f3c92a2
x-ms-traffictypediagnostic: MN2PR13MB3869:
x-microsoft-antispam-prvs: <MN2PR13MB38698B755AE731D8F8C8142EB83B0@MN2PR13MB3869.namprd13.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Q4EOPkox54XBc5bzP7relZNYnqMKb+g8+CaEpfkk5S5V43G1dz2TPvhQbmXDALTccs/jgsUIcYVCeaXIc2bbeKKkGBsjWmhSyCBNASY8vwVde4P99xuSR/jLqSXpulItGfKhd1YiemM5++1UzNedIC0OLMYt2k15jqWAzq38j7bZQG2hje7a1mf1wrvY5TdThdBD0x5CnI59TEJHZd/BJcZBcUW46OcZk/1MaW55ITO5mETjSX+JZLXNngBSvy5ljnCRda9/6oZqS+fzpEGu4P1UItmzY/Do72iPJ30eZAbf37AKVtjAM98n4lzYPexN
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR13MB3957.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(376002)(346002)(366004)(396003)(136003)(39830400003)(83380400001)(6916009)(36756003)(71200400001)(316002)(8936002)(6486002)(86362001)(2906002)(186003)(26005)(8676002)(478600001)(53546011)(66476007)(66556008)(64756008)(66446008)(5660300002)(91956017)(6512007)(66946007)(6506007)(54906003)(76116006)(2616005)(4326008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: rB9WfR/oNXUB5aGulsST3bwAQI53r/QYZLnmECtLjH2lGof/wTJfa6jlHEeAILy4CfH4rdTu9l6H60P78d3NBCBLieWgD9zIXNGMMsTsMygkG2tEt9jN8btaP7VvFOuYf8x+SZ4kGxhz+mYtpX0EshiWMJqqPFPk6T7iuc1ik37IZDHebYOk40YzHRK/OaTIYpERcDkK2/biEoC09HsDDuBIk/q4Ca35JBWuHR2+Hsq9R33Xz7BtC3VEbciahavtulgygyZt/SeKgAk+18LA6TCCQVqdPyMKt19Jqcr6QTd8juxDxfPAMNGZpqYKtbvyWwAmTovyKAV+G6egwqXfsOIWQeRd9GYuYNu7prbAw5CSnyNrVij/Na8FosBUCd5sPDgy3MiHAz5gjw3ZjaQhqMdzDHcNfi1oEnk6f+HQdT4P1sdUxxcaBR1MmrzNsAfMqxq0yPqa8jO4nFLCC6ezLH79el4u6J3JG0VhXkmL/rbMWdOGjZLYfMJrMSsc74+m97f/DXpv34km+auguvr9UUeWdzAYb0mXhjyqk8hf1MdN4wXVSoYZhE3rOWzZuM8vtwTTVq3+ocvx9iZ45cxq/4Nzygran7ajgOXBAR7K8WbcxqCFjzJUn3Ug83evzdoVRYCiHJC61AerpfXg2P6tXg==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <C70A24EE0CE7884C817C9CE137387F72@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR13MB3957.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fbf95c69-3e87-4bc9-c454-08d85f3c92a2
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Sep 2020 21:15:03.4099
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8PYKEwd+DSixKvQW5BUu1XkZLar1o+n6bEnqOhg3MGrE4Sh4zT/MZCz9wAV+RjbIn5kG6XT8OXDinr1Hl7MeUg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR13MB3869
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

T24gVHVlLCAyMDIwLTA5LTIyIGF0IDE3OjA4IC0wNDAwLCBCZW5qYW1pbiBDb2RkaW5ndG9uIHdy
b3RlOg0KPiBPbiAyMiBTZXAgMjAyMCwgYXQgMTU6NDgsIFRyb25kIE15a2xlYnVzdCB3cm90ZToN
Cj4gDQo+ID4gT24gVHVlLCAyMDIwLTA5LTIyIGF0IDE1OjE1IC0wNDAwLCBCZW5qYW1pbiBDb2Rk
aW5ndG9uIHdyb3RlOg0KPiA+ID4gU2luY2UgY29tbWl0IDBlMGNiMzViNDE3ZiAoIk5GU3Y0OiBI
YW5kbGUgTkZTNEVSUl9PTERfU1RBVEVJRCBpbg0KPiA+ID4gQ0xPU0UvT1BFTl9ET1dOR1JBREUi
KSB0aGUgZm9sbG93aW5nIGxpdmVsb2NrIG1heSBvY2N1ciBpZiBhDQo+ID4gPiBDTE9TRQ0KPiA+
ID4gcmFjZXMNCj4gPiA+IHdpdGggdGhlIHVwZGF0ZSBvZiB0aGUgbmZzX3N0YXRlOg0KPiA+ID4g
DQo+ID4gPiBQcm9jZXNzIDEgICAgICAgICAgIFByb2Nlc3MgMiAgICAgICAgICAgU2VydmVyDQo+
ID4gPiA9PT09PT09PT0gICAgICAgICAgID09PT09PT09PSAgICAgICAgICAgPT09PT09PT0NCj4g
PiA+ICBPUEVOIGZpbGUNCj4gPiA+ICAgICAgICAgICAgICAgICAgICAgT1BFTiBmaWxlDQo+ID4g
PiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgUmVwbHkgT1BFTiAoMSkN
Cj4gPiA+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBSZXBseSBPUEVO
ICgyKQ0KPiA+ID4gIFVwZGF0ZSBzdGF0ZSAoMSkNCj4gPiA+ICBDTE9TRSBmaWxlICgxKQ0KPiA+
ID4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIFJlcGx5IE9MRF9TVEFU
RUlEICgxKQ0KPiA+ID4gIENMT1NFIGZpbGUgKDIpDQo+ID4gPiAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgUmVwbHkgQ0xPU0UgKC0xKQ0KPiA+ID4gICAgICAgICAgICAg
ICAgICAgICBVcGRhdGUgc3RhdGUgKDIpDQo+ID4gPiAgICAgICAgICAgICAgICAgICAgIHdhaXQg
Zm9yIHN0YXRlIGNoYW5nZQ0KPiA+ID4gIE9QRU4gZmlsZQ0KPiA+ID4gICAgICAgICAgICAgICAg
ICAgICB3YWtlDQo+ID4gPiAgQ0xPU0UgZmlsZQ0KPiA+ID4gIE9QRU4gZmlsZQ0KPiA+ID4gICAg
ICAgICAgICAgICAgICAgICB3YWtlDQo+ID4gPiAgQ0xPU0UgZmlsZQ0KPiA+ID4gIC4uLg0KPiA+
ID4gICAgICAgICAgICAgICAgICAgICAuLi4NCj4gPiA+IA0KPiA+ID4gQXMgbG9uZyBhcyB0aGUg
Zmlyc3QgcHJvY2VzcyBjb250aW51ZXMgdXBkYXRpbmcgc3RhdGUsIHRoZSBzZWNvbmQNCj4gPiA+
IHByb2Nlc3MNCj4gPiA+IHdpbGwgZmFpbCB0byBleGl0IHRoZSBsb29wIGluDQo+ID4gPiBuZnNf
c2V0X29wZW5fc3RhdGVpZF9sb2NrZWQoKS4gIFRoaXMNCj4gPiA+IGxpdmVsb2NrDQo+ID4gPiBo
YXMgYmVlbiBvYnNlcnZlZCBpbiBnZW5lcmljLzE2OC4NCj4gPiA+IA0KPiA+ID4gRml4IHRoaXMg
YnkgZGV0ZWN0aW5nIHRoZSBjYXNlIGluIG5mc19uZWVkX3VwZGF0ZV9vcGVuX3N0YXRlaWQoKQ0K
PiA+ID4gYW5kDQo+ID4gPiB0aGVuIGV4aXQgdGhlIGxvb3AgaWY6DQo+ID4gPiAgLSB0aGUgc3Rh
dGUgaXMgTkZTX09QRU5fU1RBVEUsIGFuZA0KPiA+ID4gIC0gdGhlIHN0YXRlaWQgc2VxdWVuY2Ug
aXMgPiAxLCBhbmQNCj4gPiA+ICAtIHRoZSBzdGF0ZWlkIGRvZXNuJ3QgbWF0Y2ggdGhlIGN1cnJl
bnQgb3BlbiBzdGF0ZWlkDQo+ID4gPiANCj4gPiA+IEZpeGVzOiAwZTBjYjM1YjQxN2YgKCJORlN2
NDogSGFuZGxlIE5GUzRFUlJfT0xEX1NUQVRFSUQgaW4NCj4gPiA+IENMT1NFL09QRU5fRE9XTkdS
QURFIikNCj4gPiA+IENjOiBzdGFibGVAdmdlci5rZXJuZWwub3JnICMgdjUuNCsNCj4gPiA+IFNp
Z25lZC1vZmYtYnk6IEJlbmphbWluIENvZGRpbmd0b24gPGJjb2RkaW5nQHJlZGhhdC5jb20+DQo+
ID4gPiAtLS0NCj4gPiA+ICBmcy9uZnMvbmZzNHByb2MuYyB8IDI3ICsrKysrKysrKysrKysrKysr
LS0tLS0tLS0tLQ0KPiA+ID4gIDEgZmlsZSBjaGFuZ2VkLCAxNyBpbnNlcnRpb25zKCspLCAxMCBk
ZWxldGlvbnMoLSkNCj4gPiA+IA0KPiA+ID4gZGlmZiAtLWdpdCBhL2ZzL25mcy9uZnM0cHJvYy5j
IGIvZnMvbmZzL25mczRwcm9jLmMNCj4gPiA+IGluZGV4IDZlOTVjODVmZTM5NS4uOWRiMjlhNDM4
NTQwIDEwMDY0NA0KPiA+ID4gLS0tIGEvZnMvbmZzL25mczRwcm9jLmMNCj4gPiA+ICsrKyBiL2Zz
L25mcy9uZnM0cHJvYy5jDQo+ID4gPiBAQCAtMTU4OCwxOCArMTU4OCwyNSBAQCBzdGF0aWMgdm9p
ZA0KPiA+ID4gbmZzX3Rlc3RfYW5kX2NsZWFyX2FsbF9vcGVuX3N0YXRlaWQoc3RydWN0IG5mczRf
c3RhdGUgKnN0YXRlKQ0KPiA+ID4gIHN0YXRpYyBib29sIG5mc19uZWVkX3VwZGF0ZV9vcGVuX3N0
YXRlaWQoc3RydWN0IG5mczRfc3RhdGUNCj4gPiA+ICpzdGF0ZSwNCj4gPiA+ICAJCWNvbnN0IG5m
czRfc3RhdGVpZCAqc3RhdGVpZCkNCj4gPiA+ICB7DQo+ID4gPiAtCWlmICh0ZXN0X2JpdChORlNf
T1BFTl9TVEFURSwgJnN0YXRlLT5mbGFncykgPT0gMCB8fA0KPiA+ID4gLQkgICAgIW5mczRfc3Rh
dGVpZF9tYXRjaF9vdGhlcihzdGF0ZWlkLCAmc3RhdGUtPm9wZW5fc3RhdGVpZCkpIHsNCj4gPiA+
IC0JCWlmIChzdGF0ZWlkLT5zZXFpZCA9PSBjcHVfdG9fYmUzMigxKSkNCj4gPiA+ICsJYm9vbCBz
dGF0ZV9tYXRjaGVzX290aGVyID0gbmZzNF9zdGF0ZWlkX21hdGNoX290aGVyKHN0YXRlaWQsDQo+
ID4gPiAmc3RhdGUtPm9wZW5fc3RhdGVpZCk7DQo+ID4gPiArCWJvb2wgc2VxaWRfb25lID0gc3Rh
dGVpZC0+c2VxaWQgPT0gY3B1X3RvX2JlMzIoMSk7DQo+ID4gPiArDQo+ID4gPiArCWlmICh0ZXN0
X2JpdChORlNfT1BFTl9TVEFURSwgJnN0YXRlLT5mbGFncykpIHsNCj4gPiA+ICsJCS8qIFRoZSBj
b21tb24gY2FzZSAtIHdlJ3JlIHVwZGF0aW5nIHRvIGEgbmV3IHNlcXVlbmNlDQo+ID4gPiBudW1i
ZXIgKi8NCj4gPiA+ICsJCWlmIChzdGF0ZV9tYXRjaGVzX290aGVyICYmDQo+ID4gPiBuZnM0X3N0
YXRlaWRfaXNfbmV3ZXIoc3RhdGVpZCwgJnN0YXRlLT5vcGVuX3N0YXRlaWQpKSB7DQo+ID4gPiAr
CQkJbmZzX3N0YXRlX2xvZ19vdXRfb2Zfb3JkZXJfb3Blbl9zdGF0ZWlkKHN0YXRlLA0KPiA+ID4g
c3RhdGVpZCk7DQo+ID4gPiArCQkJcmV0dXJuIHRydWU7DQo+ID4gPiArCQl9DQo+ID4gPiArCX0g
ZWxzZSB7DQo+ID4gPiArCQkvKiBUaGlzIGlzIHRoZSBmaXJzdCBPUEVOICovDQo+ID4gPiArCQlp
ZiAoIXN0YXRlX21hdGNoZXNfb3RoZXIgJiYgc2VxaWRfb25lKSB7DQo+ID4gDQo+ID4gV2h5IGFy
ZSB3ZSBsb29raW5nIGF0IHRoZSB2YWx1ZSBvZiBzdGF0ZV9tYXRjaGVzX290aGVyIGhlcmU/IElm
IHRoZQ0KPiA+IE5GU19PUEVOX1NUQVRFIGZsYWdzIGlzIG5vdCBzZXQsIHRoZW4gdGhlIHN0YXRl
LT5vcGVuX3N0YXRlaWQgaXMNCj4gPiBub3QNCj4gPiBpbml0aWFsaXNlZCwgc28gaG93IGRvZXMg
aXQgbWFrZSBzZW5zZSB0byBsb29rIGF0IGEgY29tcGFyaXNvbg0KPiA+IHdpdGggDQo+ID4gdGhl
DQo+ID4gaW5jb21pbmcgc3RhdGVpZD8NCj4gDQo+IFlvdSdyZSByaWdodCAtIGl0IGRvZXNuJ3Qg
bWFrZSBzZW5zZS4gSSBmYWlsZWQgdG8gY2xlYW4gaXQgdXAgb3V0IG9mDQo+IG15DQo+IGRlY2lz
aW9uIG1hdHJpeC4gIEknbGwgc2VuZCBhIHYzIGFmdGVyIGl0IGdldHMgdGVzdGVkIG92ZXJuaWdo
dC4NCj4gDQo+IFRoYW5rcyBmb3IgdGhlIGxvb2ssIGFuZCBpZiB5b3UgaGF2ZSBhbm90aGVyIG1v
bWVudCAtIHdoYXQgZG8geW91DQo+IHRoaW5rDQo+IGFib3V0IG5vdCBidW1waW5nIHRoZSBzZXFp
ZCBpbiB0aGUgQ0xPU0UvT1BFTl9ET1dOR1JBREUgcGF0aCBvbiANCj4gT0xEX1NUQVRFSUQNCj4g
aWYgdGhlIHN0YXRlJ3MgcmVmY291bnQgPiAxPyAgVGhpcyB3b3VsZCBvcHRpbWl6ZSBhd2F5IGEg
bG90IG9mDQo+IHJlY292ZXJ5IA0KPiBmb3INCj4gcmFjZXMgbGlrZSB0aGlzLCBidXQgSSB3b25k
ZXIgaWYgaXQgd291bGQgYmUgcG9zc2libGUgdG8gZW5kIHVwIHdpdGgNCj4gdHdvDQo+IE9QRU5f
RE9XTkdSQURFcyBkdWVsaW5nIHRoYXQgd291bGQgbmV2ZXIgcmVjb3Zlci4NCj4gDQoNCkl0IHdv
dWxkIGxlYWQgdG8gYSByZXR1cm4gb2YgdGhlIGluZmluaXRlIGxvb3AgaW4gY2FzZXMgd2hlcmUg
dGhlDQpjbGllbnQgbWlzc2VzIGEgcmVwbHkgdG8gYW4gT1BFTiBvciBDTE9TRSBkdWUgdG8gYSBz
b2Z0IHRpbWVvdXQgKHdoaWNoDQppcyBhbiBpbXBvcnRhbnQgdXNlIGNhc2UgZm9yIHVzKS4NCg0K
LS0gDQpUcm9uZCBNeWtsZWJ1c3QNCkxpbnV4IE5GUyBjbGllbnQgbWFpbnRhaW5lciwgSGFtbWVy
c3BhY2UNCnRyb25kLm15a2xlYnVzdEBoYW1tZXJzcGFjZS5jb20NCg0KDQo=

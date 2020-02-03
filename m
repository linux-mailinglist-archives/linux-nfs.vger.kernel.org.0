Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6EAFA151298
	for <lists+linux-nfs@lfdr.de>; Mon,  3 Feb 2020 23:56:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726331AbgBCW4B (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 3 Feb 2020 17:56:01 -0500
Received: from mail-mw2nam10on2099.outbound.protection.outlook.com ([40.107.94.99]:62048
        "EHLO NAM10-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726278AbgBCW4B (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Mon, 3 Feb 2020 17:56:01 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T3jad4VBA4a/bwH0FcvAuVdrX8udoz5BwWxMQnu35KDmS3wJmHJA+28EY+kKmobHytNM8RGU9IDuVjSG0a4cdVXnykAeMY0nsq3y82BrWXG466XcBsy/pBWSLC3ZAMNF8sS2vRgHc1ltvZcWfNkwxImN2AhnCmT0gYTHZZwFQ79/FYYLruNMYWWf+7Ae/IBpXHXfANAPbf/d/Ll9WjGHOAdwy0uv5xW8ixaufLYWFzekrDopZCi82uIjVl1TWAjfDSUR9Mcj3ZOQnZKqDxJrDvOf+UeDYw9IU2qC7vaygbpUQImQAXsWo0P+s3DH6RrqEPGuktz9U+JKq9tmf3CCqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uYwNjhRefoJsHTTOu53CqzY42xhSvyz2/4CMUArc3us=;
 b=OWvFwQmOA3VH8eogK6i6LvoPXIKa5xIPLWIoHfMDBcMmtR9a13odo+9Z3B8RyMwvVKwf9IAsvbPTmficeWygzAVCom3YBnDyd+x53YZIjBZzAuU45hm0uqsm6uQ2UoR1vJocEyGhg4/UBFXdUh234Mr/nbqS3nXouc7rXMW3oFeHgRuxcB2jb++LTiZvLCOcpO9zzaS4WmTh8+0yZmGShbGEFlhgibHM2X/AsWROnUqmCV8KuflomeYIm2PVHmWM5cZQUKUBqQcM2V6V0tgFTEQlt6rVq8Pi3vACvvt2E6jphyPxoy1fw91QmtBGWZr5k4alrUCP4rB/K1qPKHE0sw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uYwNjhRefoJsHTTOu53CqzY42xhSvyz2/4CMUArc3us=;
 b=XsMFyxrDsF58vf2ai3skuKupc0n7tSEQmVJDNHmRNFsTtHEOJFKizSO87B2HArkyZCo7yeRwSCUnt62e7qXKmemFwi7Teq5baonNFA0UhccyZGqD4Masp0vtkOG8SVeg6hqkQ6YoXUV4l8J1+A9xYVl/ZGHOA/CfsxxMIOhAU+c=
Received: from DM5PR1301MB2108.namprd13.prod.outlook.com (10.174.186.34) by
 DM5PR1301MB1881.namprd13.prod.outlook.com (10.174.184.34) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2707.20; Mon, 3 Feb 2020 22:55:55 +0000
Received: from DM5PR1301MB2108.namprd13.prod.outlook.com
 ([fe80::9449:ded8:d7b:a344]) by DM5PR1301MB2108.namprd13.prod.outlook.com
 ([fe80::9449:ded8:d7b:a344%3]) with mapi id 15.20.2707.018; Mon, 3 Feb 2020
 22:55:55 +0000
From:   Trond Myklebust <trondmy@hammerspace.com>
To:     "Anna.Schumaker@netapp.com" <Anna.Schumaker@netapp.com>
CC:     "dai.ngo@oracle.com" <dai.ngo@oracle.com>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "bcodding@redhat.com" <bcodding@redhat.com>
Subject: Re: [PATCH 2/4] NFS: Directory page cache pages need to be locked
 when read
Thread-Topic: [PATCH 2/4] NFS: Directory page cache pages need to be locked
 when read
Thread-Index: AQHV2hv42rcDbF+6jk2nrb8C0oLYkagJ7Z6AgAANQ4CAAACzgIAAF2eAgAABlYCAAAFkgA==
Date:   Mon, 3 Feb 2020 22:55:55 +0000
Message-ID: <af9f123727b738150c598c0b35107f6081703e68.camel@hammerspace.com>
References: <20200202225356.995080-1-trond.myklebust@hammerspace.com>
         <20200202225356.995080-2-trond.myklebust@hammerspace.com>
         <20200202225356.995080-3-trond.myklebust@hammerspace.com>
         <16a7298dacd9fd1d08cd26b7073e9ced62c5fa24.camel@netapp.com>
         <beb3c648da7f641d34f9a1cbef5639ba014de6db.camel@gmail.com>
         <af1ed1339b6854af4c6def212b1035d18ce863df.camel@netapp.com>
         <7acea747deb126b86fc4a2f2742362155a4cf698.camel@hammerspace.com>
         <fdf116b70a147d169a4b9b6800a34682eba582b6.camel@hammerspace.com>
In-Reply-To: <fdf116b70a147d169a4b9b6800a34682eba582b6.camel@hammerspace.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=trondmy@hammerspace.com; 
x-originating-ip: [68.40.189.247]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0212a82f-ef79-4cdd-17b8-08d7a8fc3a22
x-ms-traffictypediagnostic: DM5PR1301MB1881:
x-microsoft-antispam-prvs: <DM5PR1301MB1881658826AF8B2D2E57EF34B8000@DM5PR1301MB1881.namprd13.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-forefront-prvs: 0302D4F392
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(376002)(136003)(396003)(346002)(39850400004)(199004)(189003)(2906002)(36756003)(66476007)(64756008)(5660300002)(66446008)(66556008)(81166006)(8676002)(8936002)(91956017)(76116006)(66946007)(81156014)(6506007)(2616005)(6512007)(71200400001)(6916009)(26005)(6486002)(478600001)(186003)(4326008)(86362001)(54906003)(316002);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR1301MB1881;H:DM5PR1301MB2108.namprd13.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: hammerspace.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: aaF2Cn1DAdkRc9OXM7lJ3wm8dFjk1l+Q68Dlw3XhisEqWhqxNx+gOwOG9I+RYsZXglUG4/4yqPQOQw2a9TynoMBedAiML3LjTveXHNqGpD7TnOL+0aKJG9ZlCUxnJWo2sMZX1G6Ou2u5itIKnk1xJkOfM8Xi4fMRcVPMpUUMWY8KyfDuGMT7J4FlMiVkgCchZ1+x8P3lw/0w4DndJGqrPzJ3cyTB7p6C9DA8aDPxOP21pNET2z5oIKym5nVzcIedhjhSWFTerwncjJgVjcE/MPiF/tbNcQinWGEIc6Z5P0pAKdo1SGYVHFWB5AadmvKWvIjUobg/pQTmCGj2KIr7e1ufzSBNTlQM10kMeP3xilII7Sf1EneLNsU/5XD4NwFDN7A21uRVZqo0fbMRECwKox5z9G5Bx1UdgHTzepePuJiJUcNVXhWnprTB6pNLXsOl
x-ms-exchange-antispam-messagedata: YTpsjBXHn7C9HF3WqtKLlRPd21ZNBd7AsqwP/pyifFSGS+rkyNScFJ+iYA/KHWw16XcuN0LEaQxrJz5jsRiVRQ5+kNPiCvhk3ku5OlM4Zx2FgpWnDEDYmbdg1gBPei6jH4LNDODxY6yQX7APTcjwhw==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <EEE068F49B54FE4EB967C3209308A836@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0212a82f-ef79-4cdd-17b8-08d7a8fc3a22
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Feb 2020 22:55:55.6342
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: D12EHI5YGQyB/YpL8OiaYfdYjn3nDR5/40QBUcoEYym6wIICBCgayhTCzwl2gbp6QPtncc28jGHae2hZHSSbNQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1301MB1881
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

T24gTW9uLCAyMDIwLTAyLTAzIGF0IDIyOjUwICswMDAwLCBUcm9uZCBNeWtsZWJ1c3Qgd3JvdGU6
DQo+IE9uIE1vbiwgMjAyMC0wMi0wMyBhdCAyMjo0NSArMDAwMCwgVHJvbmQgTXlrbGVidXN0IHdy
b3RlOg0KPiA+IE9uIE1vbiwgMjAyMC0wMi0wMyBhdCAyMToyMSArMDAwMCwgU2NodW1ha2VyLCBB
bm5hIHdyb3RlOg0KPiA+ID4gT24gTW9uLCAyMDIwLTAyLTAzIGF0IDE2OjE4IC0wNTAwLCBUcm9u
ZCBNeWtsZWJ1c3Qgd3JvdGU6DQo+ID4gPiA+IE9uIE1vbiwgMjAyMC0wMi0wMyBhdCAyMDozMSAr
MDAwMCwgU2NodW1ha2VyLCBBbm5hIHdyb3RlOg0KPiA+ID4gPiA+IEhpIFRyb25kLA0KPiA+ID4g
PiA+IA0KPiA+ID4gPiA+IE9uIFN1biwgMjAyMC0wMi0wMiBhdCAxNzo1MyAtMDUwMCwgVHJvbmQg
TXlrbGVidXN0IHdyb3RlOg0KPiA+ID4gPiA+ID4gV2hlbiBhIE5GUyBkaXJlY3RvcnkgcGFnZSBj
YWNoZSBwYWdlIGlzIHJlbW92ZWQgZnJvbSB0aGUNCj4gPiA+ID4gPiA+IHBhZ2UNCj4gPiA+ID4g
PiA+IGNhY2hlLA0KPiA+ID4gPiA+ID4gaXRzIGNvbnRlbnRzIGFyZSBmcmVlZCB0aHJvdWdoIGEg
Y2FsbCB0bw0KPiA+ID4gPiA+ID4gbmZzX3JlYWRkaXJfY2xlYXJfYXJyYXkoKS4NCj4gPiA+ID4g
PiA+IFRvIHByZXZlbnQgdGhlIHJlbW92YWwgb2YgdGhlIHBhZ2UgY2FjaGUgZW50cnkgdW50aWwg
YWZ0ZXINCj4gPiA+ID4gPiA+IHdlJ3ZlDQo+ID4gPiA+ID4gPiBmaW5pc2hlZCByZWFkaW5nIGl0
LCB3ZSBtdXN0IHRha2UgdGhlIHBhZ2UgbG9jay4NCj4gPiA+ID4gPiA+IA0KPiA+ID4gPiA+ID4g
Rml4ZXM6IDExZGUzYjExZTA4YyAoIk5GUzogRml4IGEgbWVtb3J5IGxlYWsgaW4NCj4gPiA+ID4g
PiA+IG5mc19yZWFkZGlyIikNCj4gPiA+ID4gPiA+IENjOiBzdGFibGVAdmdlci5rZXJuZWwub3Jn
ICMgdjIuNi4zNysNCj4gPiA+ID4gPiA+IFNpZ25lZC1vZmYtYnk6IFRyb25kIE15a2xlYnVzdCA8
DQo+ID4gPiA+ID4gPiB0cm9uZC5teWtsZWJ1c3RAaGFtbWVyc3BhY2UuY29tDQo+ID4gPiA+ID4g
PiAtLS0NCj4gPiA+ID4gPiA+ICBmcy9uZnMvZGlyLmMgfCAzMCArKysrKysrKysrKysrKysrKysr
LS0tLS0tLS0tLS0NCj4gPiA+ID4gPiA+ICAxIGZpbGUgY2hhbmdlZCwgMTkgaW5zZXJ0aW9ucygr
KSwgMTEgZGVsZXRpb25zKC0pDQo+ID4gPiA+ID4gPiANCj4gPiA+ID4gPiA+IGRpZmYgLS1naXQg
YS9mcy9uZnMvZGlyLmMgYi9mcy9uZnMvZGlyLmMNCj4gPiA+ID4gPiA+IGluZGV4IGJhMGQ1NTkz
MGU4YS4uOTA0NjdiNDRlYzEzIDEwMDY0NA0KPiA+ID4gPiA+ID4gLS0tIGEvZnMvbmZzL2Rpci5j
DQo+ID4gPiA+ID4gPiArKysgYi9mcy9uZnMvZGlyLmMNCj4gPiA+ID4gPiA+IEBAIC03MDUsOCAr
NzA1LDYgQEAgaW50IG5mc19yZWFkZGlyX2ZpbGxlcih2b2lkICpkYXRhLA0KPiA+ID4gPiA+ID4g
c3RydWN0DQo+ID4gPiA+ID4gPiBwYWdlKg0KPiA+ID4gPiA+ID4gcGFnZSkNCj4gPiA+ID4gPiA+
ICBzdGF0aWMNCj4gPiA+ID4gPiA+ICB2b2lkIGNhY2hlX3BhZ2VfcmVsZWFzZShuZnNfcmVhZGRp
cl9kZXNjcmlwdG9yX3QgKmRlc2MpDQo+ID4gPiA+ID4gPiAgew0KPiA+ID4gPiA+ID4gLQlpZiAo
IWRlc2MtPnBhZ2UtPm1hcHBpbmcpDQo+ID4gPiA+ID4gPiAtCQluZnNfcmVhZGRpcl9jbGVhcl9h
cnJheShkZXNjLT5wYWdlKTsNCj4gPiA+ID4gPiA+ICAJcHV0X3BhZ2UoZGVzYy0+cGFnZSk7DQo+
ID4gPiA+ID4gPiAgCWRlc2MtPnBhZ2UgPSBOVUxMOw0KPiA+ID4gPiA+ID4gIH0NCj4gPiA+ID4g
PiA+IEBAIC03MjAsMTkgKzcxOCwyOCBAQCBzdHJ1Y3QgcGFnZQ0KPiA+ID4gPiA+ID4gKmdldF9j
YWNoZV9wYWdlKG5mc19yZWFkZGlyX2Rlc2NyaXB0b3JfdA0KPiA+ID4gPiA+ID4gKmRlc2MpDQo+
ID4gPiA+ID4gPiAgDQo+ID4gPiA+ID4gPiAgLyoNCj4gPiA+ID4gPiA+ICAgKiBSZXR1cm5zIDAg
aWYgZGVzYy0+ZGlyX2Nvb2tpZSB3YXMgZm91bmQgb24gcGFnZSBkZXNjLQ0KPiA+ID4gPiA+ID4g
PiBwYWdlX2luZGV4DQo+ID4gPiA+ID4gPiArICogYW5kIGxvY2tzIHRoZSBwYWdlIHRvIHByZXZl
bnQgcmVtb3ZhbCBmcm9tIHRoZSBwYWdlDQo+ID4gPiA+ID4gPiBjYWNoZS4NCj4gPiA+ID4gPiA+
ICAgKi8NCj4gPiA+ID4gPiA+ICBzdGF0aWMNCj4gPiA+ID4gPiA+IC1pbnQgZmluZF9jYWNoZV9w
YWdlKG5mc19yZWFkZGlyX2Rlc2NyaXB0b3JfdCAqZGVzYykNCj4gPiA+ID4gPiA+ICtpbnQgZmlu
ZF9hbmRfbG9ja19jYWNoZV9wYWdlKG5mc19yZWFkZGlyX2Rlc2NyaXB0b3JfdA0KPiA+ID4gPiA+
ID4gKmRlc2MpDQo+ID4gPiA+ID4gPiAgew0KPiA+ID4gPiA+ID4gIAlpbnQgcmVzOw0KPiA+ID4g
PiA+ID4gIA0KPiA+ID4gPiA+ID4gIAlkZXNjLT5wYWdlID0gZ2V0X2NhY2hlX3BhZ2UoZGVzYyk7
DQo+ID4gPiA+ID4gPiAgCWlmIChJU19FUlIoZGVzYy0+cGFnZSkpDQo+ID4gPiA+ID4gPiAgCQly
ZXR1cm4gUFRSX0VSUihkZXNjLT5wYWdlKTsNCj4gPiA+ID4gPiA+IC0NCj4gPiA+ID4gPiA+IC0J
cmVzID0gbmZzX3JlYWRkaXJfc2VhcmNoX2FycmF5KGRlc2MpOw0KPiA+ID4gPiA+ID4gKwlyZXMg
PSBsb2NrX3BhZ2Vfa2lsbGFibGUoZGVzYy0+cGFnZSk7DQo+ID4gPiA+ID4gPiAgCWlmIChyZXMg
IT0gMCkNCj4gPiA+ID4gPiA+IC0JCWNhY2hlX3BhZ2VfcmVsZWFzZShkZXNjKTsNCj4gPiA+ID4g
PiA+ICsJCWdvdG8gZXJyb3I7DQo+ID4gPiA+ID4gPiArCXJlcyA9IC1FQUdBSU47DQo+ID4gPiA+
ID4gPiArCWlmIChkZXNjLT5wYWdlLT5tYXBwaW5nICE9IE5VTEwpIHsNCj4gPiA+ID4gPiA+ICsJ
CXJlcyA9IG5mc19yZWFkZGlyX3NlYXJjaF9hcnJheShkZXNjKTsNCj4gPiA+ID4gPiA+ICsJCWlm
IChyZXMgPT0gMCkNCj4gPiA+ID4gPiA+ICsJCQlyZXR1cm4gMDsNCj4gPiA+ID4gPiA+ICsJfQ0K
PiA+ID4gPiA+ID4gKwl1bmxvY2tfcGFnZShkZXNjLT5wYWdlKTsNCj4gPiA+ID4gPiA+ICtlcnJv
cjoNCj4gPiA+ID4gPiA+ICsJY2FjaGVfcGFnZV9yZWxlYXNlKGRlc2MpOw0KPiA+ID4gPiA+ID4g
IAlyZXR1cm4gcmVzOw0KPiA+ID4gPiA+ID4gIH0NCj4gPiA+ID4gPiA+ICANCj4gPiA+ID4gPiAN
Cj4gPiA+ID4gPiBDYW4geW91IGdpdmUgbWUgc29tZSBndWlkYW5jZSBvbiBob3cgdG8gYXBwbHkg
dGhpcyBvbiB0b3Agb2YNCj4gPiA+ID4gPiBEYWkncyB2Mg0KPiA+ID4gPiA+IHBhdGNoIGZyb20N
Cj4gPiA+ID4gPiBKYW51YXJ5IDIzPyBSaWdodCBub3cgSSBoYXZlIHRoZSBuZnNpLT5wYWdlX2lu
ZGV4IGdldHRpbmcgc2V0DQo+ID4gPiA+ID4gYmVmb3JlDQo+ID4gPiA+ID4gdGhlDQo+ID4gPiA+
ID4gdW5sb2NrX3BhZ2UoKToNCj4gPiA+ID4gDQo+ID4gPiA+IFNpbmNlIHRoaXMgbmVlZHMgdG8g
YmUgYSBzdGFibGUgcGF0Y2gsIGl0IHdvdWxkIGJlIHByZWZlcmFibGUNCj4gPiA+ID4gdG8NCj4g
PiA+ID4gYXBwbHkNCj4gPiA+ID4gdGhlbSBpbiB0aGUgb3Bwb3NpdGUgb3JkZXIgdG8gYXZvaWQg
YW4gZXh0cmEgZGVwZW5kZW5jeSBvbg0KPiA+ID4gPiBEYWkncw0KPiA+ID4gPiBwYXRjaC4NCj4g
PiA+IA0KPiA+ID4gVGhhdCBtYWtlcyBzZW5zZS4NCj4gPiA+IA0KPiA+ID4gPiBUaGF0IHNhaWQs
IHNpbmNlIHRoZSBuZnNpLT5wYWdlX2luZGV4IGlzIG5vdCBhIHBlci1wYWdlDQo+ID4gPiA+IHZh
cmlhYmxlLA0KPiA+ID4gPiB0aGVyZQ0KPiA+ID4gPiBpcyBubyBuZWVkIHRvIHB1dCBpdCB1bmRl
ciB0aGUgcGFnZSBsb2NrLg0KPiA+ID4gDQo+ID4gPiBHb3QgaXQuIEknbGwgc3dhcCB0aGUgb3Jk
ZXIgb2YgZXZlcnl0aGluZywgYW5kIHB1dCB0aGUgcGFnZV9pbmRleA0KPiA+ID4gb3V0c2lkZSBv
ZiB0aGUNCj4gPiA+IHBhZ2UgbG9jayB3aGVuIHJlc29sdmluZyB0aGUgY29uZmxpY3QuDQo+ID4g
PiANCj4gPiANCj4gPiBPb3BzLi4uIEFjdHVhbGx5IERhaSdzIGNvZGUgbmVlZHMgdG8gZ28gaW4g
dGhlICdyZXR1cm4gMCcgcGF0aA0KPiA+IGFib3ZlDQo+ID4gKGkuZS4gYWZ0ZXIgYSBzdWNjZXNz
ZnVsIGNhbGwgdG8gbmZzX3JlYWRkaXJfc2VhcmNoX2FycmF5KCkpLg0KPiA+IEl0IHNob3VsZG4n
dCBnbyBpbiB0aGUgZXJyb3IgcGF0aC4NCj4gDQo+IFdoaWxlIG1vdmluZyB0aGUgY29kZSwgY291
bGQgeW91IGFsc28gYWRkIGluIGEgc21hbGwgbWljcm8tDQo+IG9wdGltaXNhdGlvbj8gSWYgd2Ug
dXNlIGZpbGVfaW5vZGUoZGVzYy0+ZmlsZSkgaW5zdGVhZCBvZg0KPiBkX2lub2RlKGZpbGVfZGVu
dHJ5KGRlc2MtPmZpbGUpKSB0aGVuIHdlIGF2b2lkIGF0IGxlYXN0IG9uZSBwb2ludGVyDQo+IGlu
ZGlyZWN0aW9uLg0KPiANCg0KT2gsIGFuZCBwbGVhc2UgcmVtb3ZlIHRoZSBjYWxsIHRvIG5mc196
YXBfbWFwcGluZyhkaXIsIGRpci0+aV9tYXBwaW5nKQ0KaW4gbmZzX2Zvcl91c2VfcmVhZGRpcnBs
dXMoKS4gV2UgZG9uJ3QgbmVlZCB0aGF0IHdoZW4gd2UgaGF2ZSB0aGUgY2FsbA0KdG8gaW52YWxp
ZGF0ZV9tYXBwaW5nX3BhZ2VzKCkuDQotLSANClRyb25kIE15a2xlYnVzdA0KTGludXggTkZTIGNs
aWVudCBtYWludGFpbmVyLCBIYW1tZXJzcGFjZQ0KdHJvbmQubXlrbGVidXN0QGhhbW1lcnNwYWNl
LmNvbQ0KDQoNCg==

Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D9AFEB937A
	for <lists+linux-nfs@lfdr.de>; Fri, 20 Sep 2019 16:54:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389136AbfITOyc (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 20 Sep 2019 10:54:32 -0400
Received: from mail-eopbgr680105.outbound.protection.outlook.com ([40.107.68.105]:17678
        "EHLO NAM04-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2387967AbfITOyb (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Fri, 20 Sep 2019 10:54:31 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LQxyajonG5vWQK/y2zcb4FM8tObVYDztzpkVlEqSGRx+PCIlIpK5vsDzIxFKa9goImsXXWy6ifhbDbnBbPP2ocpCEP0dEpV4IasQmwbCraK5ZbcBUTWgRu7cXeVmL54IXn4ji5UYzkswROgENnxZSjsuxh84WkkKBZl6wsSVj+vqX6DmJOUiF7nM0wmY8gK97CjE3gLnZJeMNBeCQRLgT19j8DSr1Kedu1F2XAQPORc5Zx7Zuk2mZTtbPOJ6Z11iAfXzATKjm5weaKwb7smD4OYPOVwFruxHixQOb5sPJBxmpvGsAjPOMEONgINl+ds4YYs9HIJ1EMuoSyVSyhwZqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QEEY0zlhpiqOGY7B3IKYYTbhOlHKo8jezyybzuMSMug=;
 b=ch9hHEyAp1WitWQQ+RRXPDWj3kEz6p2OzneEX5XD8IRvIaZ8t5vF42t++1f6E2BZRJTyjN9qAAaXJD0mQaHzOLqxd+SUhwMkg9AlVIQWBRiBrMprvdw1ThBftw8Wn2XaNfIP844RkUSEjC9ahAx7f8vEJUopsc/Vmn3jYTOztyxlR40ciErcpbkOmiKQfkQN42IYuB8q/RMBvnnMuOG4HPC6hD2V2EpIYCFOWXVWYvnLUY7YR9Tw0sb4/2WpNPyKRdXQuZs36ejgURsZ5SdRBoOl22k79HYi2sb7oL9TALWYC5HWuhaPbT1WSi/m/TbzCW3c+ZoNA8ZxVPWlwezR3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QEEY0zlhpiqOGY7B3IKYYTbhOlHKo8jezyybzuMSMug=;
 b=XQ+Laiatb2Z3Dt+QKDCuHvlahNex2HnUZp6Wo2V5Sr8mL0LDhlptrNNvZlbdFow6Crw/54mWcxkJraOHaHLnec/OWefeU4HBdn/d7lW0l+8DNt/rd1QExTuJX2OQSVE9s7s7+c3ILRQAgRwT1YWqe0TLuldJcwWYbknR7m8Frs4=
Received: from DM5PR13MB1851.namprd13.prod.outlook.com (10.171.159.143) by
 DM5PR13MB0892.namprd13.prod.outlook.com (10.169.159.28) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2305.10; Fri, 20 Sep 2019 14:54:28 +0000
Received: from DM5PR13MB1851.namprd13.prod.outlook.com
 ([fe80::70fd:85c2:8ea9:a0b6]) by DM5PR13MB1851.namprd13.prod.outlook.com
 ([fe80::70fd:85c2:8ea9:a0b6%9]) with mapi id 15.20.2284.009; Fri, 20 Sep 2019
 14:54:28 +0000
From:   Trond Myklebust <trondmy@hammerspace.com>
To:     "aglo@umich.edu" <aglo@umich.edu>
CC:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "Anna.Schumaker@netapp.com" <Anna.Schumaker@netapp.com>
Subject: Re: [PATCH v2 0/9] Various NFSv4 state error handling fixes
Thread-Topic: [PATCH v2 0/9] Various NFSv4 state error handling fixes
Thread-Index: AQHVbM/S/fixzh0y6ESu1Qgv6VvgnKcx18EAgABneQCAAL+UgIAAr0SAgAD22YCAAAgNAA==
Date:   Fri, 20 Sep 2019 14:54:27 +0000
Message-ID: <a64c0ac2bdac105edca74f1e40d33ab91a6165ad.camel@hammerspace.com>
References: <20190916204419.21717-1-trond.myklebust@hammerspace.com>
         <CAN-5tyF27z=+3tbU1De_wR0aosiczn67dNanBmBe4icj=uAYwQ@mail.gmail.com>
         <4c620de7a944ff38644eceb4fed863f5092f1a15.camel@hammerspace.com>
         <CAN-5tyGX_Mb-wGTREtSWRFFSNK0qjgqLbm8SFPG=DPM7M2OWoQ@mail.gmail.com>
         <8720be3295e3b0035396b9bec70231a628231c93.camel@hammerspace.com>
         <CAN-5tyHgP75cJL4SNb+-Q8iDaJOTPt6JUbjMQjJYvdZfBrdecA@mail.gmail.com>
In-Reply-To: <CAN-5tyHgP75cJL4SNb+-Q8iDaJOTPt6JUbjMQjJYvdZfBrdecA@mail.gmail.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=trondmy@hammerspace.com; 
x-originating-ip: [68.40.189.247]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ff96bbc5-55f6-44d6-a90a-08d73dda6fa0
x-ms-traffictypediagnostic: DM5PR13MB0892:
x-microsoft-antispam-prvs: <DM5PR13MB08927469BB03E935161DA862B8880@DM5PR13MB0892.namprd13.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-forefront-prvs: 0166B75B74
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39840400004)(376002)(396003)(136003)(346002)(366004)(189003)(199004)(6512007)(76176011)(14454004)(81156014)(81166006)(2501003)(256004)(1730700003)(316002)(86362001)(6246003)(6436002)(4326008)(5640700003)(8936002)(229853002)(2171002)(25786009)(2906002)(6916009)(6116002)(6486002)(478600001)(305945005)(7736002)(3846002)(8676002)(26005)(54906003)(486006)(186003)(64756008)(66446008)(66476007)(66946007)(66066001)(66556008)(5660300002)(71200400001)(36756003)(2351001)(476003)(71190400001)(11346002)(446003)(102836004)(118296001)(99286004)(6506007)(76116006)(53546011)(91956017)(5024004)(14444005)(2616005);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR13MB0892;H:DM5PR13MB1851.namprd13.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: hammerspace.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: KzfvTxw/FjnXUGXdwFIHd2iRAigOf2FGB5bBoqL6gmdXA71vyuxxj7ANzzvfWGdiPHXdDIhjDmlCdH+jY3/NQgjrOVAi6wqP1F0ngpRADJwQW8HADXxhrH4EgXMc7Ll51H11tt6q4TRCFYqrukAOJk7Ltvn5XI8hwUPyxxW6E+j3v7wXkN7PcP+tI2yko/mtILl11L27HQjGzsC+7gZJXaz4bzF0a+QGyEwUJCmvmLsTZdeEPWrmhS1oIMl83TSzaa7QR/HzsUE977x0RyJ3DhQdJ+M8JDXNh5hLuzU5cIx/WnIgauMsob1wQTSYv8XJpmicqwvHY8Md+1K8fzHsusssMJtrvZRaZBiuggJN5662g/IXj5If7oNA6szVCflcYyp6oeIOXClrNdxHM31bN4+j6in23j/0vmiTKJDvBUM=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <68F9AB4270E94149A2E0BFE735ED84D8@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ff96bbc5-55f6-44d6-a90a-08d73dda6fa0
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Sep 2019 14:54:27.8950
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1T15ScYpcbqrP3H3XPjYw0B0zcvn3a0UKULxGOWiZ8qRuxIzocO1zuxpemqge2NC0tNN6lEV3jBIKAjG91sn2g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR13MB0892
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

T24gRnJpLCAyMDE5LTA5LTIwIGF0IDEwOjI1IC0wNDAwLCBPbGdhIEtvcm5pZXZza2FpYSB3cm90
ZToNCj4gSGkgVHJvbmQsDQo+IA0KPiBPbiBUaHUsIFNlcCAxOSwgMjAxOSBhdCA3OjQyIFBNIFRy
b25kIE15a2xlYnVzdCA8DQo+IHRyb25kbXlAaGFtbWVyc3BhY2UuY29tPiB3cm90ZToNCj4gPiBI
aSBPbGdhDQo+ID4gDQo+ID4gT24gVGh1LCAyMDE5LTA5LTE5IGF0IDA5OjE0IC0wNDAwLCBPbGdh
IEtvcm5pZXZza2FpYSB3cm90ZToNCj4gPiA+IEhpIFRyb25kLA0KPiA+ID4gDQo+ID4gPiBPbiBX
ZWQsIFNlcCAxOCwgMjAxOSBhdCA5OjQ5IFBNIFRyb25kIE15a2xlYnVzdCA8DQo+ID4gPiB0cm9u
ZG15QGhhbW1lcnNwYWNlLmNvbT4gd3JvdGU6DQo+ID4gPiA+IEhpIE9sZ2ENCj4gPiA+ID4gDQo+
ID4gPiA+IE9uIFdlZCwgMjAxOS0wOS0xOCBhdCAxNTozOCAtMDQwMCwgT2xnYSBLb3JuaWV2c2th
aWEgd3JvdGU6DQo+ID4gPiA+ID4gSGkgVHJvbmQsDQo+ID4gPiA+ID4gDQo+ID4gPiA+ID4gVGhl
c2Ugc2V0IG9mIHBhdGNoZXMgZG8gbm90IGFkZHJlc3MgdGhlIGxvY2tpbmcgcHJvYmxlbS4gSXQn
cw0KPiA+ID4gPiA+IGFjdHVhbGx5DQo+ID4gPiA+ID4gbm90IHRoZSBsb2NraW5nIHBhdGNoICh3
aGljaCBJIHRob3VnaHQgaXQgd2FzIGFzIEkgcmV2ZXJ0ZWQNCj4gPiA+ID4gPiBpdA0KPiA+ID4g
PiA+IGFuZA0KPiA+ID4gPiA+IHN0aWxsIGhhZCB0aGUgaXNzdWUpLiBXaXRob3V0IHRoZSB3aG9s
ZSBwYXRjaCBzZXJpZXMgdGhlDQo+ID4gPiA+ID4gdW5sb2NrDQo+ID4gPiA+ID4gd29ya3MNCj4g
PiA+ID4gPiBmaW5lIHNvIHNvbWV0aGluZyBpbiB0aGVzZSBuZXcgcGF0Y2hlcy4gU29tZXRoaW5n
IGlzIHVwIHdpdGgNCj4gPiA+ID4gPiB0aGUNCj4gPiA+ID4gPiAyDQo+ID4gPiA+ID4gcGF0Y2hl
czoNCj4gPiA+ID4gPiBORlN2NDogSGFuZGxlIE5GUzRFUlJfT0xEX1NUQVRFSUQgaW4gQ0xPU0Uv
T1BFTl9ET1dOR1JBREUNCj4gPiA+ID4gPiBORlN2NDogSGFuZGxlIE5GUzRFUlJfT0xEX1NUQVRF
SUQgaW4gTE9DS1UNCj4gPiA+ID4gPiANCj4gPiA+ID4gPiBJZiBJIHJlbW92ZSBlaXRoZXIgb25l
IHNlcGFyYXRlbHksIHVubG9jayBmYWlscyBidXQgaWYgSQ0KPiA+ID4gPiA+IHJlbW92ZQ0KPiA+
ID4gPiA+IGJvdGgNCj4gPiA+ID4gPiB1bmxvY2sgd29ya3MuDQo+ID4gPiA+IA0KPiA+ID4gPiBD
YW4geW91IGRlc2NyaWJlIGhvdyB5b3UgYXJlIHRlc3RpbmcgdGhpcywgYW5kIHBlcmhhcHMgcHJv
dmlkZQ0KPiA+ID4gPiB3aXJlc2hhcmsgdHJhY2VzIHRoYXQgc2hvdyBob3cgd2UncmUgdHJpZ2dl
cmluZyB0aGVzZSBwcm9ibGVtcz8NCj4gPiA+IA0KPiA+ID4gSSdtIHRyaWdnZXJpbmcgYnkgcnVu
bmluZyAibmZzdGVzdF9sb2NrIC0tbmZzdmVyc2lvbiA0LjEgLS0NCj4gPiA+IHJ1bnRlc3QNCj4g
PiA+IGJ0ZXN0MDEiIGFnYWluc3QgZWl0aGVyIGxpbnV4IG9yIG9udGFwIHNlcnZlcnMgKHdoaWxl
IHRoZSB0ZXN0DQo+ID4gPiBkb2Vzbid0DQo+ID4gPiBmYWlsIGJ1dCBvbiB0aGUgbmV0d29yayB0
cmFjZSB5b3UgY2FuIHNlZSB1bmxvY2sgZmFpbGluZyB3aXRoDQo+ID4gPiBiYWRfc3RhdGVpZCku
IE5ldHdvcmsgdHJhY2UgYXR0YWNoZWQuDQo+ID4gPiANCj4gPiA+IEJ1dCBhY3R1YWxseSBhIHNp
bXBsZSB0ZXN0IG9wZW4sIGxvY2ssIHVubG9jayBkb2VzIHRoZSB0cmljaw0KPiA+ID4gKG5ldHdv
cmsNCj4gPiA+IHRyYWNlIGF0dGFjaGVkKS4NCj4gPiA+IGZkMSA9IG9wZW4oUkRXUikNCj4gPiA+
IGZjdGwoZmQxKSAobG9jayAvdW5sb2NrKQ0KPiA+IA0KPiA+IFRoZXNlIHRyYWNlcyByZWFsbHkg
ZG8gbm90IG1lc2ggd2l0aCB3aGF0IEknbSBzZWVpbmcgdXNpbmcgYSBzaW1wbGUNCj4gPiBDb25u
ZWN0YXRob24gbG9jayB0ZXN0IHJ1bi4gV2hlbiBJIGxvb2sgYXQgdGhlIHdpcmVzaGFyayBvdXRw
dXQNCj4gPiBmcm9tDQo+ID4gdGhhdCwgSSBzZWUgZXhhZHRseSB0d28gY2FzZXMgd2hlcmUgdGhl
IHN0YXRlaWQgYXJndW1lbnRzIGFyZSBib3RoDQo+ID4gemVybywgYW5kIHRob3NlIGFyZSBib3Ro
IFNFVEFUVFIsIHNvIGV4cGVjdGVkLg0KPiA+IA0KPiA+IEFsbCB0aGUgTE9DS1UgYXJlIHNob3dp
bmcgdXAgYXMgbm9uLXplcm8gc3RhdGVpZHMsIGFuZCBzbyBJJ20NCj4gPiBzZWVpbmcgbm8NCj4g
PiBCQURfU1RBVEVJRCBvciBPTERfU1RBVEVJRCBlcnJvcnMgYXQgYWxsLg0KPiA+IA0KPiA+IElz
IHRoZXJlIHNvbWV0aGluZyBzcGVjaWFsIGFib3V0IGhvdyB5b3VyIHRlc3QgaXMgcnVubmluZz8N
Cj4gDQo+IFRoZXJlIGlzIG5vdGhpbmcgc3BlY2lhbCB0aGF0IEkgY2FuIHRoaW5rIG9mIGFib3V0
IG15IHNldHVwIG9yIGhvdw0KPiB0ZXN0IHJ1bi4gSSBwdWxsIGZyb20geW91ciB0ZXN0aW5nIGJy
YW5jaCwgYnVpbGQgaXQgKG5vIGV4dHJhDQo+IHBhdGNoZXMpLiBSdW4gdGVzdHMgb3ZlciA0LjEg
KGRlZmF1bHQgbW91bnQgb3B0cykgYWdhaW5zdCBhIGxpbnV4DQo+IHNlcnZlciAodHlwaWNhbGx5
IHNhbWUga2VybmVsKS4NCj4gDQo+IElzIHRoaXMgcGF0Y2ggc2VyaWVzIHNvbWV3aGVyZSBpbiB5
b3VyIGdpdCBicmFuY2hlcz8gSSd2ZSBiZWVuDQo+IHRlc3RpbmcNCj4geW91ciB0ZXN0aW5nIGJy
YW5jaCAoYXMgSSBjb3VsZCBzZWUgdjIgY2hhbmdlcyB3ZXJlIGluIHRoZSB0ZXN0aW5nDQo+IGJy
YW5jaCkuIEl0J3Mgbm90IG9idmlvdXMgdG8gbWUgd2hhdCB3YXMgY2hhbmdlZCBpbiB2MyB0byBz
ZWUgaWYgdGhlDQo+IHRlc3RpbmcgYnJhbmNoIGhhcyB0aGUgcmlnaHQgY29kZS4NCg0KSSBoYWRu
J3QgeWV0IHVwZGF0ZWQgdGhlIHRlc3RpbmcgYnJhbmNoIHdpdGggdGhlIHYzIGNvZGUuIFB1c2hl
ZCBvdXQNCm5vdyBhcyBhIGZvcmNlZC11cGRhdGUuDQoNCkNoZWVycw0KICBUcm9uZA0KDQotLSAN
ClRyb25kIE15a2xlYnVzdA0KTGludXggTkZTIGNsaWVudCBtYWludGFpbmVyLCBIYW1tZXJzcGFj
ZQ0KdHJvbmQubXlrbGVidXN0QGhhbW1lcnNwYWNlLmNvbQ0KDQoNCg==

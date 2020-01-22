Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3CAA5145C49
	for <lists+linux-nfs@lfdr.de>; Wed, 22 Jan 2020 20:10:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726164AbgAVTKx (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 22 Jan 2020 14:10:53 -0500
Received: from mail-eopbgr690088.outbound.protection.outlook.com ([40.107.69.88]:53486
        "EHLO NAM04-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726004AbgAVTKx (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Wed, 22 Jan 2020 14:10:53 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nl/UfqygSS/LsTaGAOw2Pb9VIOe5vzmbERi4ULQThqp9vvnB1yE/x4s+KwTaJx7BuRMsIvjI/5ICTX0cAEMtzj5T5hV1K8UnB4ZTE7OI11L9OykOEwxJZmlIbR5BiOj6za9xN8C++uIPSHttG62SNG4bAXGMFTA0z8hrl/g+txxIB3a49kpvecFF8Jl2ukLT9gNuvyZNQSQSEcA3iY6XiQMwfit8hRo1OMebAEslyEp1FZ8fjkEmKANA9XUiLnq8lmqJz1HjO2lN0Uu9t3Vugh2uoWtk0zdPbCYbHtk8V0xl39HUmSSocVUWS9PAKA/HWER3F97PQYki0y9eHLNOeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hxAtYX4/qv4J8zb6knexfRb3qu6KRoi+zLYOyEWU4ic=;
 b=JOlp8j082E64133QE91pZaksafCRtyxG/sROV3divrhjfpDPm/ts+xDkTsBeVbZFx3Nr18Ii+U0Xf8JxslJZicpope56oxd0hnztrRexpzHiJjKOWryiPekio7Lv76PYKihoRWh80YBW1mCuOgcM+Vbnu42necpg8Vg4Ej7b4LSjznKMr2R19SQ5jxjCjyTuDPIyB9cH4VeBs6dtMZ3EG5EqCRZtcsZ018EJeh4Gl+gdyJMm2ckePNlrqU7sheHY2vNlx7bgVB43Dr4hZiv1Wi5HJz4LJCkDls6G6WZ5Q6oXhzQxiU4aeV0D5V0UmQO8JnKub0ZOaknUqpXPA67Y2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=netapp.com; dmarc=pass action=none header.from=netapp.com;
 dkim=pass header.d=netapp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=netapp.onmicrosoft.com; s=selector1-netapp-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hxAtYX4/qv4J8zb6knexfRb3qu6KRoi+zLYOyEWU4ic=;
 b=p1XttpmwzZi2X8G8hS1LhgE0MOiJYWLzW89zvGi1wKBDghAgsO3RCeU+JV+W4+cGfmarC2S71vR37umMvLPbClDlfyGxqA4eAYpmnBU7JyvNxdgzTDhRRyNnCX0iFj9gdDN/Zygv2AXdZngSfK2qpWgJhVaKu7uZX0uEyXfOoas=
Received: from BL0PR06MB4370.namprd06.prod.outlook.com (10.167.241.142) by
 BL0PR06MB4436.namprd06.prod.outlook.com (10.167.172.145) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2644.18; Wed, 22 Jan 2020 19:10:49 +0000
Received: from BL0PR06MB4370.namprd06.prod.outlook.com
 ([fe80::dd54:50fb:1e98:46a1]) by BL0PR06MB4370.namprd06.prod.outlook.com
 ([fe80::dd54:50fb:1e98:46a1%6]) with mapi id 15.20.2644.027; Wed, 22 Jan 2020
 19:10:48 +0000
From:   "Schumaker, Anna" <Anna.Schumaker@netapp.com>
To:     "rmilkowski@gmail.com" <rmilkowski@gmail.com>,
        "chuck.lever@oracle.com" <chuck.lever@oracle.com>,
        "trondmy@hammerspace.com" <trondmy@hammerspace.com>
CC:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "trond.myklebust@hammerspace.com" <trond.myklebust@hammerspace.com>
Subject: Re: [PATCH v3] NFSv4.0: nfs4_do_fsinfo() should not do implicit lease
 renewals
Thread-Topic: [PATCH v3] NFSv4.0: nfs4_do_fsinfo() should not do implicit
 lease renewals
Thread-Index: AdW/I2auAYB5hyQWQDmn+e9BiY7hDAAA4KMABCT0qAAAZzrDgA==
Date:   Wed, 22 Jan 2020 19:10:48 +0000
Message-ID: <49e7b99bd1451a0dbb301915f655c73b3d9354df.camel@netapp.com>
References: <025801d5bf24$aa242100$fe6c6300$@gmail.com>
         <D82A1590-FAA3-47C5-B198-937ED88EF71C@oracle.com>
         <084f01d5cfba$bc5c4d10$3514e730$@gmail.com>
In-Reply-To: <084f01d5cfba$bc5c4d10$3514e730$@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.34.3 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Anna.Schumaker@netapp.com; 
x-originating-ip: [68.42.68.242]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 65154a06-b3e8-44bf-c4cf-08d79f6eca90
x-ms-traffictypediagnostic: BL0PR06MB4436:
x-microsoft-antispam-prvs: <BL0PR06MB4436D467F03368DD8A64261AF80C0@BL0PR06MB4436.namprd06.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 029097202E
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(396003)(39860400002)(136003)(376002)(346002)(366004)(199004)(189003)(36756003)(478600001)(54906003)(6486002)(6506007)(53546011)(110136005)(316002)(86362001)(6512007)(26005)(186003)(4326008)(2616005)(8676002)(8936002)(81156014)(81166006)(5660300002)(66446008)(71200400001)(64756008)(66476007)(66946007)(91956017)(76116006)(66556008)(2906002);DIR:OUT;SFP:1101;SCL:1;SRVR:BL0PR06MB4436;H:BL0PR06MB4370.namprd06.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: netapp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: UTcTvHQSVqv5waHU1JhKBJlO9fPePLWYibRJ0uk+o5CmdxV7+m2wI1BnuCYUyCgHcrVAetE+3F2E6WEh+3awMLIPWkSb3BZgjA6oXEOebavf9pi4qVYnyGfVAaWM5c4HUWTGL7uGDO0p06/8rKs1bDKndLeFGqRob0TfU0SY3fN6ldj8k/z4PZUFAbkYnJQQP1lt/GbhEZTcItIXaPpHPof0qBISoV9axIeAMoKMtlNA2azY1pRHvSiTyBTGN83G6Z3aAxPKEmUniFe9qs2JHZcOVUlo0aqHwQ1c1mRNgMkuqVsiix0bxaGC8NRnQ/yEAVm1lXoH7I+veQQqbByl8OfXILjN72GXQomhFH9QU16CYT2Ow477JFPxUJGqhllh/QBOeXGNBqmlGXHAJVWrfoAbrliitBQeWrwEXj+wfvcCQZ984ZXEDMef1JTd3s7e
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <2025728EAE217242A7F6395DB5E25160@namprd06.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: netapp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 65154a06-b3e8-44bf-c4cf-08d79f6eca90
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Jan 2020 19:10:48.9434
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4b0911a0-929b-4715-944b-c03745165b3a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: m+wTT5ETTZFURL3a0jJHz8mn/CPJ2dOdMtikChs7WxfnEerOueCai25co9UbvVEZ8x0Za0A531f0jwzhsP6EeA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR06MB4436
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

SGkgUm9iZXJ0LA0KDQpPbiBNb24sIDIwMjAtMDEtMjAgYXQgMTc6NTUgKzAwMDAsIFJvYmVydCBN
aWxrb3dza2kgd3JvdGU6DQo+ID4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gPiBGcm9t
OiBDaHVjayBMZXZlciA8Y2h1Y2subGV2ZXJAb3JhY2xlLmNvbT4NCj4gPiBTZW50OiAzMCBEZWNl
bWJlciAyMDE5IDE1OjM3DQo+ID4gVG86IFJvYmVydCBNaWxrb3dza2kgPHJtaWxrb3dza2lAZ21h
aWwuY29tPg0KPiA+IENjOiBMaW51eCBORlMgTWFpbGluZyBMaXN0IDxsaW51eC1uZnNAdmdlci5r
ZXJuZWwub3JnPjsgVHJvbmQgTXlrbGVidXN0DQo+ID4gPHRyb25kLm15a2xlYnVzdEBoYW1tZXJz
cGFjZS5jb20+OyBBbm5hIFNjaHVtYWtlcg0KPiA+IDxhbm5hLnNjaHVtYWtlckBuZXRhcHAuY29t
PjsgbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZw0KPiA+IFN1YmplY3Q6IFJlOiBbUEFUQ0gg
djNdIE5GU3Y0LjA6IG5mczRfZG9fZnNpbmZvKCkgc2hvdWxkIG5vdCBkbyBpbXBsaWNpdA0KPiA+
IGxlYXNlIHJlbmV3YWxzDQo+ID4gDQo+ID4gDQo+ID4gDQo+ID4gPiBPbiBEZWMgMzAsIDIwMTks
IGF0IDEwOjIwIEFNLCBSb2JlcnQgTWlsa293c2tpIDxybWlsa293c2tpQGdtYWlsLmNvbT4NCj4g
PiB3cm90ZToNCj4gPiA+IEZyb206IFJvYmVydCBNaWxrb3dza2kgPHJtaWxrb3dza2lAZ21haWwu
Y29tPg0KPiA+ID4gDQo+ID4gPiBDdXJyZW50bHksIGVhY2ggdGltZSBuZnM0X2RvX2ZzaW5mbygp
IGlzIGNhbGxlZCBpdCB3aWxsIGRvIGFuIGltcGxpY2l0DQo+ID4gPiBORlM0IGxlYXNlIHJlbmV3
YWwsIHdoaWNoIGlzIG5vdCBjb21wbGlhbnQgd2l0aCB0aGUgTkZTNA0KPiA+IHNwZWNpZmljYXRp
b24uDQo+ID4gPiBUaGlzIGNhbiByZXN1bHQgaW4gYSBsZWFzZSBiZWluZyBleHBpcmVkIGJ5IGFu
IE5GUyBzZXJ2ZXIuDQo+ID4gPiANCj4gPiA+IENvbW1pdCA4M2NhN2Y1YWIzMWYgKCJORlM6IEF2
b2lkIFBVVFJPT1RGSCB3aGVuIG1hbmFnaW5nIGxlYXNlcyIpDQo+ID4gPiBpbnRyb2R1Y2VkIGlt
cGxpY2l0IGNsaWVudCBsZWFzZSByZW5ld2FsIGluIG5mczRfZG9fZnNpbmZvKCksIHdoaWNoDQo+
ID4gPiBjYW4gcmVzdWx0IGluIHRoZSBORlN2NC4wIGxlYXNlIHRvIGV4cGlyZSBvbiBhIHNlcnZl
ciBzaWRlLCBhbmQNCj4gPiA+IHNlcnZlcnMgcmV0dXJuaW5nIE5GUzRFUlJfRVhQSVJFRCBvciBO
RlM0RVJSX1NUQUxFX0NMSUVOVElELg0KPiA+ID4gDQo+ID4gPiBUaGlzIGNhbiBlYXNpbHkgYmUg
cmVwcm9kdWNlZCBieSBmcmVxdWVudGx5IHVubW91bnRpbmcgYSBzdWItbW91bnQsDQo+ID4gPiB0
aGVuIHN0YXQnaW5nIGl0IHRvIGdldCBpdCBtb3VudGVkIGFnYWluLCB3aGljaCB3aWxsIGRlbGF5
IG9yIGV2ZW4NCj4gPiA+IGNvbXBsZXRlbHkgcHJldmVudCBjbGllbnQgZnJvbSBzZW5kaW5nIFJF
TkVXIG9wZXJhdGlvbnMgaWYgbm8gb3RoZXINCj4gPiA+IE5GUyBvcGVyYXRpb25zIGFyZSBpc3N1
ZWQuIEV2ZW50dWFsbHkgbmZzIHNlcnZlciB3aWxsIGV4cGlyZSBjbGllbnQncw0KPiA+ID4gbGVh
c2UgYW5kIHJldHVybiBhbiBlcnJvciBvbiBmaWxlIGFjY2VzcyBvciBuZXh0IFJFTkVXLg0KPiA+
ID4gDQo+ID4gPiBUaGlzIGNhbiBhbHNvIGhhcHBlbiB3aGVuIGEgc3ViLW1vdW50IGlzIGF1dG9t
YXRpY2FsbHkgdW5tb3VudGVkIGR1ZQ0KPiA+ID4gdG8gaW5hY3Rpdml0eSAoYWZ0ZXIgbmZzX21v
dW50cG9pbnRfZXhwaXJ5X3RpbWVvdXQpLCB0aGVuIGl0IGlzDQo+ID4gPiBtb3VudGVkIGFnYWlu
IHZpYSBzdGF0KCkuIFRoaXMgY2FuIHJlc3VsdCBpbiBhIHNob3J0IHdpbmRvdyBkdXJpbmcNCj4g
PiA+IHdoaWNoIGNsaWVudCdzIGxlYXNlIHdpbGwgZXhwaXJlIG9uIGEgc2VydmVyIGJ1dCBub3Qg
b24gYSBjbGllbnQuDQo+ID4gPiBUaGlzIHNwZWNpZmljIGNhc2Ugd2FzIG9ic2VydmVkIG9uIHBy
b2R1Y3Rpb24gc3lzdGVtcy4NCj4gPiA+IA0KPiA+ID4gVGhpcyBwYXRjaCBtYWtlcyBhbiBleHBs
aWNpdCBsZWFzZSByZW5ld2FsIGluc3RlYWQgb2YgYW4gaW1wbGljaXQgb25lLA0KPiA+ID4gYnkg
YWRkaW5nIFJFTkVXIHRvIGEgY29tcG91bmQgb3BlcmF0aW9uIGlzc3VlZCBieSBuZnM0X2RvX2Zz
aW5mbygpLA0KPiA+ID4gc2ltaWxhcmx5IHRvIE5GU3Y0LjEgd2hpY2ggYWRkcyBTRVFVRU5DRSBv
cGVyYXRpb24uDQo+ID4gPiANCj4gPiA+IEZpeGVzOiA4M2NhN2Y1YWIzMWYgKCJORlM6IEF2b2lk
IFBVVFJPT1RGSCB3aGVuIG1hbmFnaW5nIGxlYXNlcyIpDQo+ID4gPiBTaWduZWQtb2ZmLWJ5OiBS
b2JlcnQgTWlsa293c2tpIDxybWlsa293c2tpQGdtYWlsLmNvbT4NCj4gPiANCj4gPiBSZXZpZXdl
ZC1ieTogQ2h1Y2sgTGV2ZXIgPGNodWNrLmxldmVyQG9yYWNsZS5jb20+DQo+ID4gDQo+ID4gDQo+
IA0KPiBIb3cgZG8gd2UgcHJvZ3Jlc3MgaXQgZnVydGhlcj8NCg0KVGhhbmtzIGZvciBmb2xsb3dp
bmcgdXAhIEkgaGF2ZSB0aGUgcGF0Y2ggaW5jbHVkZWQgaW4gbXkgbGludXgtbmV4dCBicmFuY2gg
Zm9yDQp0aGUgbmV4dCBtZXJnZSB3aW5kb3cuDQoNCkFubmENCg0KPiANCg==

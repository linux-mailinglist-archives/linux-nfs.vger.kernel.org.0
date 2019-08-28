Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8B9ECA065D
	for <lists+linux-nfs@lfdr.de>; Wed, 28 Aug 2019 17:32:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726462AbfH1Pcb (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 28 Aug 2019 11:32:31 -0400
Received: from mail-eopbgr720117.outbound.protection.outlook.com ([40.107.72.117]:43664
        "EHLO NAM05-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726415AbfH1Pcb (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Wed, 28 Aug 2019 11:32:31 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WGp8Qr96TnTt+qzUe0sQU0FtUM4jYIedIxMvMGfnzwJMOR+OkH6pMT8zNb4KHrn5/lbyN5qczgsKrDd0p9BKhrmkOLSfoaQ7Tq9e83R3rBPQM/PXm4AN4aMwSBS1gXVTBzJnTMvSmIksMkvzxXzcWJz9eOF6ASoZYtsdBZJfZgSKQRjUuWUnA2MXsnErF1VRbtlRrDJ4GK/MFYFjl2BxobEbYea8w8WT0Hnrzwziib7WbtqYd1LDYVRyRjVIjJ7Xn4kcqfS7WGw93zaDg5gSq8A4v1MT8x495YZ/Zusp3+t1AxQPfvsVLy7C2U6pbQw/0Fd/Jebkom7sIx91XQUEaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GPVxMC6B4aXNrRTvUUp4PtjWaWO9PlRQuNZnfP+WuUM=;
 b=jwlEx10L0icvHxkeP1GVryCbgYTfe2kdtvrEi7j5qQ3WcqCMvW9OO+f1awqAo3MVNLq7B9/g4cEjIjeiPma28n1SAWhO2p5NbFBvcUQPDcNAdyHe+f+pfl2JK10B8yOPHg2AhpCyBWOJCWjwuH5InAAgDpTqqRA1rq6qxPpU0ZEzmC01VHorG7HcV0oZyYS7gRxdbaweZRQyfts3ca0QsLXPHBHglmP0zqj6ZoXW1El8hm5PkxLhd5KON3KBu39Z7wa6jaCxVsASLX128lEvlZUBaFChyB9gCEQ2C0pD99ZWUbqgsmbmp2RWYWZOEDXc2ycgWXo2bvHU/4k792/qBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GPVxMC6B4aXNrRTvUUp4PtjWaWO9PlRQuNZnfP+WuUM=;
 b=bD0J2+6QDuwpPer9ytZbk3wMWJGlsylQLb2g2B71HeUVFiq5Gbr4gR8VjAMFeOfnQpONScFKTiBQ7qJ+gJIM8sOk2aDXu2S0q1GbLf/AqSnTIkCVmyFDjgTp45gCdGkCIZ+hLmG0BbHVryxZZzFJ3AnrweCpIqG8qSpIMHVXajU=
Received: from DM5PR13MB1851.namprd13.prod.outlook.com (10.171.159.143) by
 DM5PR13MB1100.namprd13.prod.outlook.com (10.168.118.137) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2241.4; Wed, 28 Aug 2019 15:32:25 +0000
Received: from DM5PR13MB1851.namprd13.prod.outlook.com
 ([fe80::5d60:e645:84a2:be75]) by DM5PR13MB1851.namprd13.prod.outlook.com
 ([fe80::5d60:e645:84a2:be75%7]) with mapi id 15.20.2220.013; Wed, 28 Aug 2019
 15:32:25 +0000
From:   Trond Myklebust <trondmy@hammerspace.com>
To:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "jencce.kernel@gmail.com" <jencce.kernel@gmail.com>
CC:     "ltp@lists.linux.it" <ltp@lists.linux.it>
Subject: Re: nfs-for-5.3-3 update "breaks" NFSv4 directIO somehow
Thread-Topic: nfs-for-5.3-3 update "breaks" NFSv4 directIO somehow
Thread-Index: AQHVXYqWkaBiigZLzUiLlkqzKNa/B6cQsH6A
Date:   Wed, 28 Aug 2019 15:32:25 +0000
Message-ID: <00923c9f5d5a69e8225640abcf7ad54df2cb62d2.camel@hammerspace.com>
References: <20190828102256.3nhyb2ngzitwd7az@XZHOUW.usersys.redhat.com>
In-Reply-To: <20190828102256.3nhyb2ngzitwd7az@XZHOUW.usersys.redhat.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=trondmy@hammerspace.com; 
x-originating-ip: [68.40.189.247]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1d205597-b75e-4b64-29ce-08d72bcced96
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600166)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:DM5PR13MB1100;
x-ms-traffictypediagnostic: DM5PR13MB1100:
x-microsoft-antispam-prvs: <DM5PR13MB1100AE78767E7E66486F2000B8A30@DM5PR13MB1100.namprd13.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:288;
x-forefront-prvs: 014304E855
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(396003)(136003)(366004)(376002)(39840400004)(189003)(199004)(8936002)(229853002)(36756003)(86362001)(6486002)(118296001)(66066001)(478600001)(5660300002)(316002)(14454004)(7736002)(66556008)(64756008)(66446008)(66476007)(2501003)(110136005)(53936002)(71190400001)(71200400001)(4326008)(25786009)(76176011)(66946007)(6246003)(5024004)(14444005)(256004)(76116006)(91956017)(305945005)(6436002)(11346002)(446003)(99286004)(81156014)(3846002)(2616005)(26005)(476003)(486006)(15650500001)(53546011)(6506007)(6512007)(102836004)(8676002)(81166006)(186003)(2906002)(6116002);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR13MB1100;H:DM5PR13MB1851.namprd13.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: hammerspace.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: gAcWUjlXzDPBo+ruxrhBxDuAUBYlnzxhrqmVkIXSJHjt6lmhsz4iDerBBKNQQcX9Gb968NRBEEPCM036HQ7zkepy0mZmOvj+xEbaI0/Pg1jNDIQw/6xX4Dhwewu22f/Yqml7QeuijTDXoqXbZgu9Zj49Q4B6VGqAtsMHyvhtg7fiQD4rRulpmAKMEwTYrmVycc5Y84/F+NjC3O21K5hJuZj8e8eOgL7A7M4MVzi7h0X8YDU6Lgd//2sGP9YKFesUWQGqtoKZou5C88XC+stn5RDCmd+tMUQ6QrDdUn3I7Gny3g0WfbaUnAfR9tLpcJgRvX2QMnKkVFMergQsh5d2zdRQG6qFK4btBpNv4TeczF+MUF9D8LW8H9yE47fChOpB6N8g5fN6FILH19iC6J6UW3PonFFzGUKR1WdiqQ1OXGM=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <E0C4B619E3829145A82C32C87B11A883@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d205597-b75e-4b64-29ce-08d72bcced96
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Aug 2019 15:32:25.4669
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: X+aq1GarNvhddVpKsSC315iAgfTegqVR153zkXyJpARQwFbghNkHZ56xJkC0vAJR4RuXZme1d1mqu2k6AZOA0Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR13MB1100
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

T24gV2VkLCAyMDE5LTA4LTI4IGF0IDE4OjIyICswODAwLCBNdXJwaHkgWmhvdSB3cm90ZToNCj4g
SGksDQo+IA0KPiBJZiB3cml0ZSB0byBmaWxlIHdpdGggT19ESVJFQ1QsIHRoZW4gcmVhZCBpdCB3
aXRob3V0IE9fRElSRUNULCByZWFkDQo+IHJldHVybnMgMC4NCj4gRnJvbSB0c2hhcmsgb3V0cHV0
LCBsb29rcyBsaWtlIHRoZSBSRUFEIGNhbGwgaXMgbWlzc2luZy4NCj4gDQo+IExUUFsxXSBkaW8g
dGVzdHMgc3BvdCB0aGlzLiBUaGluZ3Mgd29yayB3ZWxsIGJlZm9yZSB0aGlzIHVwZGF0ZS4NCj4g
DQo+IEJpc2VjdCBsb2cgaXMgcG9pbnRpbmcgdG86DQo+IA0KPiAJY29tbWl0IDdlMTBjYzI1YmZh
MGRkMzYwMmJiY2Y1Y2M5Yzc1OWE5MGViNjc1ZGMNCj4gCUF1dGhvcjogVHJvbmQgTXlrbGVidXN0
IDx0cm9uZC5teWtsZWJ1c3RAaGFtbWVyc3BhY2UuY29tPg0KPiAJRGF0ZTogICBGcmkgQXVnIDkg
MTI6MDY6NDMgMjAxOSAtMDQwMA0KPiAJDQo+IAkgICAgTkZTOiBEb24ndCByZWZyZXNoIGF0dHJp
YnV0ZXMgd2l0aCBtb3VudGVkLW9uLWZpbGUNCj4gaW5mb3JtYXRpbw0KPiANCj4gV2l0aCB0aGlz
IGNvbW1pdCByZXZlcnRlZCwgdGhlIHRlc3RzIHBhc3MgYWdhaW4uDQo+IA0KPiBJdCdzIG9ubHkg
YWJvdXQgTkZTdjQoNC4wIDQuMSBhbmQgNC4yKSwgTkZTdjMgd29ya3Mgd2VsbC4NCj4gDQo+IEJp
c2VjdCBsb2csIG91dHB1dHMgb2YgdHNoYXJrLCBzYW1wbGUgdGVzdCBwcm9ncmFtbWUgZGVyaXZl
ZCBmcm9tDQo+IExUUCBkaW90ZXN0MDIuYyBhbmQgYSBzaW1wbGUgdGVzdCBzY3JpcHQgYXJlIGF0
dGFjaGVkLg0KPiANCj4gSWYgdGhpcyBpcyBhbiBleHBlY3RlZCBjaGFuZ2UsIHdlIHdpbGwgbmVl
ZCB0byB1cGRhdGUgdGhlIHRlc3RjYXNlcy4NCg0KVGhhdCBpcyBub3QgaW50ZW50aW9uYWwsIHNv
IHRoYW5rcyBmb3IgcmVwb3J0aW5nIGl0ISBEb2VzIHRoZSBmb2xsb3dpbmcNCmZpeCBoZWxwPw0K
DQo4PC0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQ0KRnJvbSBjZTYxNjE4YmMwODVkOGNlYThhNjE0
YjVlMWViMDllMTZlYThlMDM2IE1vbiBTZXAgMTcgMDA6MDA6MDAgMjAwMQ0KRnJvbTogVHJvbmQg
TXlrbGVidXN0IDx0cm9uZC5teWtsZWJ1c3RAaGFtbWVyc3BhY2UuY29tPg0KRGF0ZTogV2VkLCAy
OCBBdWcgMjAxOSAxMToyNjoxMyAtMDQwMA0KU3ViamVjdDogW1BBVENIXSBORlM6IEZpeCBpbm9k
ZSBmaWxlaWQgY2hlY2tzIGluIGF0dHJpYnV0ZSByZXZhbGlkYXRpb24gY29kZQ0KDQpXZSB3YW50
IHRvIHRocm93IG91dCB0aGUgYXR0cmJ1dGUgaWYgaXQgcmVmZXJzIHRvIHRoZSBtb3VudGVkIG9u
IGZpbGVpZCwNCmFuZCBub3QgdGhlIHJlYWwgZmlsZWlkLiBIb3dldmVyIHdlIGRvIG5vdCB3YW50
IHRvIGJsb2NrIGNhY2hlIGNvbnNpc3RlbmN5DQp1cGRhdGVzIGZyb20gTkZTdjQgd3JpdGVzLg0K
DQpSZXBvcnRlZC1ieTogTXVycGh5IFpob3UgPGplbmNjZS5rZXJuZWxAZ21haWwuY29tPg0KRml4
ZXM6IDdlMTBjYzI1YmZhMCAoIk5GUzogRG9uJ3QgcmVmcmVzaCBhdHRyaWJ1dGVzIHdpdGggbW91
bnRlZC1vbi1maWxlLi4uIikNClNpZ25lZC1vZmYtYnk6IFRyb25kIE15a2xlYnVzdCA8dHJvbmQu
bXlrbGVidXN0QGhhbW1lcnNwYWNlLmNvbT4NCi0tLQ0KIGZzL25mcy9pbm9kZS5jIHwgMTQgKysr
KysrKystLS0tLS0NCiAxIGZpbGUgY2hhbmdlZCwgOCBpbnNlcnRpb25zKCspLCA2IGRlbGV0aW9u
cygtKQ0KDQpkaWZmIC0tZ2l0IGEvZnMvbmZzL2lub2RlLmMgYi9mcy9uZnMvaW5vZGUuYw0KaW5k
ZXggYzc2NGNmZTQ1NmU1Li5kN2U3OGIyMjBjZjYgMTAwNjQ0DQotLS0gYS9mcy9uZnMvaW5vZGUu
Yw0KKysrIGIvZnMvbmZzL2lub2RlLmMNCkBAIC0xNDA0LDEwICsxNDA0LDExIEBAIHN0YXRpYyBp
bnQgbmZzX2NoZWNrX2lub2RlX2F0dHJpYnV0ZXMoc3RydWN0IGlub2RlICppbm9kZSwgc3RydWN0
IG5mc19mYXR0ciAqZmF0DQogCQlyZXR1cm4gMDsNCiANCiAJLyogTm8gZmlsZWlkPyBKdXN0IGV4
aXQgKi8NCi0JaWYgKCEoZmF0dHItPnZhbGlkICYgTkZTX0FUVFJfRkFUVFJfRklMRUlEKSkNCi0J
CXJldHVybiAwOw0KKwlpZiAoIShmYXR0ci0+dmFsaWQgJiBORlNfQVRUUl9GQVRUUl9GSUxFSUQp
KSB7DQorCQlpZiAoZmF0dHItPnZhbGlkICYgTkZTX0FUVFJfRkFUVFJfTU9VTlRFRF9PTl9GSUxF
SUQpDQorCQkJcmV0dXJuIDA7DQogCS8qIEhhcyB0aGUgaW5vZGUgZ29uZSBhbmQgY2hhbmdlZCBi
ZWhpbmQgb3VyIGJhY2s/ICovDQotCWlmIChuZnNpLT5maWxlaWQgIT0gZmF0dHItPmZpbGVpZCkg
ew0KKwl9IGVsc2UgaWYgKG5mc2ktPmZpbGVpZCAhPSBmYXR0ci0+ZmlsZWlkKSB7DQogCQkvKiBJ
cyB0aGlzIHBlcmhhcHMgdGhlIG1vdW50ZWQtb24gZmlsZWlkPyAqLw0KIAkJaWYgKChmYXR0ci0+
dmFsaWQgJiBORlNfQVRUUl9GQVRUUl9NT1VOVEVEX09OX0ZJTEVJRCkgJiYNCiAJCSAgICBuZnNp
LT5maWxlaWQgPT0gZmF0dHItPm1vdW50ZWRfb25fZmlsZWlkKQ0KQEAgLTE4MDgsMTAgKzE4MDks
MTEgQEAgc3RhdGljIGludCBuZnNfdXBkYXRlX2lub2RlKHN0cnVjdCBpbm9kZSAqaW5vZGUsIHN0
cnVjdCBuZnNfZmF0dHIgKmZhdHRyKQ0KIAkJCWF0b21pY19yZWFkKCZpbm9kZS0+aV9jb3VudCks
IGZhdHRyLT52YWxpZCk7DQogDQogCS8qIE5vIGZpbGVpZD8gSnVzdCBleGl0ICovDQotCWlmICgh
KGZhdHRyLT52YWxpZCAmIE5GU19BVFRSX0ZBVFRSX0ZJTEVJRCkpDQotCQlyZXR1cm4gMDsNCisJ
aWYgKCEoZmF0dHItPnZhbGlkICYgTkZTX0FUVFJfRkFUVFJfRklMRUlEKSkgew0KKwkJaWYgKGZh
dHRyLT52YWxpZCAmIE5GU19BVFRSX0ZBVFRSX01PVU5URURfT05fRklMRUlEKQ0KKwkJCXJldHVy
biAwOw0KIAkvKiBIYXMgdGhlIGlub2RlIGdvbmUgYW5kIGNoYW5nZWQgYmVoaW5kIG91ciBiYWNr
PyAqLw0KLQlpZiAobmZzaS0+ZmlsZWlkICE9IGZhdHRyLT5maWxlaWQpIHsNCisJfSBlbHNlIGlm
IChuZnNpLT5maWxlaWQgIT0gZmF0dHItPmZpbGVpZCkgew0KIAkJLyogSXMgdGhpcyBwZXJoYXBz
IHRoZSBtb3VudGVkLW9uIGZpbGVpZD8gKi8NCiAJCWlmICgoZmF0dHItPnZhbGlkICYgTkZTX0FU
VFJfRkFUVFJfTU9VTlRFRF9PTl9GSUxFSUQpICYmDQogCQkgICAgbmZzaS0+ZmlsZWlkID09IGZh
dHRyLT5tb3VudGVkX29uX2ZpbGVpZCkNCi0tIA0KMi4yMS4wDQoNCi0tIA0KVHJvbmQgTXlrbGVi
dXN0DQpMaW51eCBORlMgY2xpZW50IG1haW50YWluZXIsIEhhbW1lcnNwYWNlDQp0cm9uZC5teWts
ZWJ1c3RAaGFtbWVyc3BhY2UuY29tDQoNCg0K

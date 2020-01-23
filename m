Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 148DD1470EB
	for <lists+linux-nfs@lfdr.de>; Thu, 23 Jan 2020 19:39:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728931AbgAWSjE (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 23 Jan 2020 13:39:04 -0500
Received: from mail-dm6nam11on2094.outbound.protection.outlook.com ([40.107.223.94]:49716
        "EHLO NAM11-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727590AbgAWSjD (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Thu, 23 Jan 2020 13:39:03 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=D08HoAwjwpPPiZEECUn5cJ6V/ynuBBqwWJR1XSoy19aRiabeyOxMv5WuxqE+hrfC/25SNeszSnBBcAD+mnPjOM7BXOKsetJBIPSo38Y9bviUpNyx6gW1pw3Qseyi1D/x6DBN9huUdXTlp5QXdfYK0YxlmEUiOPxmKj5744/PxmnHcMJlTSMM0rZW7sKbi/6I+KrrrXD6i2lhMbBhQurWZxg/KOB2DZIVjsFa/qcAAXvKXwe0xEF8J3jEHmcbNBrFECqNFlZutO+bgFlpVy1KZsFnKs/zQdpkA2OalCmtMHOLfSpSZK2Sw0MSoqTf86DE0QwSqQqHzmcK+SIhtCmDKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1DULSO1cx09+FCLinGQeChHJRUnkN3PiygLov4Ro4mk=;
 b=iCxHY02lMEYedRf/NaNlF/svPdDS74dfadAy+sxboN1PJEpepIlfhD0i2SUzcMjfEm1aCEHg5xjH2NCQxc1fqlNFAGN1t39zd9BjRzO3WwVvBeoSwYGgv5+cAV6t1ujnWSjgyePFbQSWHCgU7SFwYxIF+qUfM0hY772QT4AUkxCESH10NCs45/vX2BpsAkYWeHT7nYxJ/ZBb2O5e2aKiaoemRARyQ+hsaqtAu38F3tCfSvkERoQqfuzvukbOlbdh6DjgP0WWhWIbWNCCXIASe7KONiw7SHmVDsXz33DuGfnmy7DcVtGSQjmZsets1t6IQOCKtD0LCkR1yoXiKHxFdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1DULSO1cx09+FCLinGQeChHJRUnkN3PiygLov4Ro4mk=;
 b=gd0mrehCzFvMAjqBmQJcjv2m/5JEU2J7lyKrWrFB1oG7rdEJnTt4k0oEoATDlruFEmSlLdbtfxKLQLLPGtQ+ltwspMh7b3lzLfYbUnBqi7D9GmEWLgCNjquyv1xY4DMuvZzofg/6DVZ8OUVI/lstAvmcxRYCs79nomiasZudOcc=
Received: from DM5PR1301MB2108.namprd13.prod.outlook.com (10.174.186.34) by
 DM5PR1301MB1948.namprd13.prod.outlook.com (10.174.184.158) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2686.11; Thu, 23 Jan 2020 18:38:57 +0000
Received: from DM5PR1301MB2108.namprd13.prod.outlook.com
 ([fe80::9449:ded8:d7b:a344]) by DM5PR1301MB2108.namprd13.prod.outlook.com
 ([fe80::9449:ded8:d7b:a344%3]) with mapi id 15.20.2665.017; Thu, 23 Jan 2020
 18:38:57 +0000
From:   Trond Myklebust <trondmy@hammerspace.com>
To:     "dai.ngo@oracle.com" <dai.ngo@oracle.com>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "anna.schumaker@netapp.com" <anna.schumaker@netapp.com>
Subject: Re: [PATCH v2] nfs: optimise readdir cache page invalidation
Thread-Topic: [PATCH v2] nfs: optimise readdir cache page invalidation
Thread-Index: AQHV0Y7WuqNjCP7pwUGBEBMYOB/nk6f4lZ4A
Date:   Thu, 23 Jan 2020 18:38:57 +0000
Message-ID: <f6e251a181018bb5349d2780cd3c62493ab713e6.camel@hammerspace.com>
References: <20200123014539.13991-1-dai.ngo@oracle.com>
In-Reply-To: <20200123014539.13991-1-dai.ngo@oracle.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=trondmy@hammerspace.com; 
x-originating-ip: [63.235.104.78]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3310b19e-1d08-44cc-9aa7-08d7a03381ef
x-ms-traffictypediagnostic: DM5PR1301MB1948:
x-microsoft-antispam-prvs: <DM5PR1301MB19486EEE55C4A8BADBF1F2B5B80F0@DM5PR1301MB1948.namprd13.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4941;
x-forefront-prvs: 029174C036
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(396003)(136003)(346002)(376002)(39830400003)(199004)(189003)(81166006)(66946007)(81156014)(76116006)(186003)(8936002)(6512007)(91956017)(8676002)(26005)(36756003)(66476007)(66556008)(64756008)(66446008)(2616005)(6486002)(2906002)(5660300002)(86362001)(6506007)(71200400001)(478600001)(110136005)(316002);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR1301MB1948;H:DM5PR1301MB2108.namprd13.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: hammerspace.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 3jV59uTFC3EBU9tuljfOg6YKJ/TTTjgodmCIkh3RPS81Bd5BbuuZg5KmUTMntDSBtubjHjgSteRN+sEOm7lA8GEynUIsuEs1Tvp09TsoPnI3ult1CqbIKHQBiAGceGsAsLwo7gHn2Ogl+2o6IaURpNJIMhEvjrkM1V69p01J52HukGET+mYbagSjn0bVyWBnARMyCHZeIaVbk6mrbIAQAEw3Zw5KlFrMY5ch4VimOXpGaQKPCx5xrsYyxFH5ijAoa7F49lv62t+3XtQMHGtAlgWkDxB1JqjoxG3DVFQsf6B5TJrt3ZWOm5JqVShooOeKQleuhzdz0s4g/sWrNwC6W05iLLJ59bWdgh7F0U7NjJJnkqtW16QrQBW49Op5UPxM5zNdpGGEOB0UifdospFgmSqa4PKSalqzIDwZqZAqGnBPuL5g1GaW7P45w9rGuRwW
x-ms-exchange-antispam-messagedata: oqq75P4C88XZe4z2Y3pG/ysfrMf2oTTVFyZrOd1E984jmvABTUpFKQSpScyPAwZvCX9TcagVflBVnekW31KXbMIOYqVH+eoDRBVeIY4ex7NTCoJV/86ozHmqyI7SgrV5BIY/jbfmWZdjCF8a2qnXFg==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <5DD1D758CDD3AA47B2D9700370AF32C6@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3310b19e-1d08-44cc-9aa7-08d7a03381ef
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Jan 2020 18:38:57.8735
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: iihinLRhHduHjZAVzJcERgAIM3wN8UudOhPnsHwOthF9BkFdnsdBJa5h3JAu0U+LI5irTHFk8u9hI2FVnG7G6g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1301MB1948
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

T24gV2VkLCAyMDIwLTAxLTIyIGF0IDIwOjQ1IC0wNTAwLCBEYWkgTmdvIHdyb3RlOg0KPiBXaGVu
IHRoZSBkaXJlY3RvcnkgaXMgbGFyZ2UgYW5kIGl0J3MgYmVpbmcgbW9kaWZpZWQgYnkgb25lIGNs
aWVudA0KPiB3aGlsZSBhbm90aGVyIGNsaWVudCBpcyBkb2luZyB0aGUgJ2xzIC1sJyBvbiB0aGUg
c2FtZSBkaXJlY3RvcnkgdGhlbg0KPiB0aGUgY2FjaGUgcGFnZSBpbnZhbGlkYXRpb24gZnJvbSBu
ZnNfZm9yY2VfdXNlX3JlYWRkaXJwbHVzIGNhdXNlcw0KPiB0aGUgcmVhZGluZyBjbGllbnQgdG8g
a2VlcCByZXN0YXJ0aW5nIFJFQURESVJQTFVTIGZyb20gY29va2llIDANCj4gd2hpY2ggY2F1c2Vz
IHRoZSAnbHMgLWwnIHRvIHRha2UgYSB2ZXJ5IGxvbmcgdGltZSB0byBjb21wbGV0ZSwNCj4gcG9z
c2libHkgbmV2ZXIgY29tcGxldGluZy4NCj4gDQo+IEN1cnJlbnRseSB3aGVuIG5mc19mb3JjZV91
c2VfcmVhZGRpcnBsdXMgaXMgY2FsbGVkIHRvIHN3aXRjaCBmcm9tDQo+IFJFQURESVIgdG8gUkVB
RERJUlBMVVMsIGl0IGludmFsaWRhdGVzIGFsbCB0aGUgY2FjaGVkIHBhZ2VzIG9mIHRoZQ0KPiBk
aXJlY3RvcnkuIFRoaXMgY2FjaGUgcGFnZSBpbnZhbGlkYXRpb24gY2F1c2VzIHRoZSBuZXh0IG5m
c19yZWFkZGlyDQo+IHRvIHJlLXJlYWQgdGhlIGRpcmVjdG9yeSBjb250ZW50IGZyb20gY29va2ll
IDAuDQo+IA0KPiBUaGlzIHBhdGNoIGlzIHRvIG9wdGltaXNlIHRoZSBjYWNoZSBpbnZhbGlkYXRp
b24gaW4NCj4gbmZzX2ZvcmNlX3VzZV9yZWFkZGlycGx1cyBieSBvbmx5IHRydW5jYXRpbmcgdGhl
IGNhY2hlZCBwYWdlcyBmcm9tDQo+IGxhc3QgcGFnZSBpbmRleCBhY2Nlc3NlZCB0byB0aGUgZW5k
IHRoZSBmaWxlLiBJdCBhbHNvIG1hcmtzIHRoZQ0KPiBpbm9kZSB0byBkZWxheSBpbnZhbGlkYXRp
bmcgYWxsIHRoZSBjYWNoZWQgcGFnZSBvZiB0aGUgZGlyZWN0b3J5DQo+IHVudGlsIHRoZSBuZXh0
IGluaXRpYWwgbmZzX3JlYWRkaXIgb2YgdGhlIG5leHQgJ2xzJyBpbnN0YW5jZS4NCj4gDQo+IFNp
Z25lZC1vZmYtYnk6IERhaSBOZ28gPGRhaS5uZ29Ab3JhY2xlLmNvbT4NCg0KUmV2aWV3ZWQtYnk6
IFRyb25kIE15a2xlYnVzdCA8dHJvbmQubXlrbGVidXN0QGhhbW1lcnNwYWNlLmNvbT4NCg0KPiAN
Cj4gLS0tDQo+ICBmcy9uZnMvZGlyLmMgICAgICAgICAgIHwgMTMgKysrKysrKysrKysrLQ0KPiAg
aW5jbHVkZS9saW51eC9uZnNfZnMuaCB8ICAzICsrKw0KPiAgMiBmaWxlcyBjaGFuZ2VkLCAxNSBp
bnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvZnMvbmZzL2Rp
ci5jIGIvZnMvbmZzL2Rpci5jDQo+IGluZGV4IGUxODAwMzNlMzVjZi4uMTZlMzIwOGMyN2Q2IDEw
MDY0NA0KPiAtLS0gYS9mcy9uZnMvZGlyLmMNCj4gKysrIGIvZnMvbmZzL2Rpci5jDQo+IEBAIC00
MzcsNyArNDM3LDkgQEAgdm9pZCBuZnNfZm9yY2VfdXNlX3JlYWRkaXJwbHVzKHN0cnVjdCBpbm9k
ZSAqZGlyKQ0KPiAgCWlmIChuZnNfc2VydmVyX2NhcGFibGUoZGlyLCBORlNfQ0FQX1JFQURESVJQ
TFVTKSAmJg0KPiAgCSAgICAhbGlzdF9lbXB0eSgmbmZzaS0+b3Blbl9maWxlcykpIHsNCj4gIAkJ
c2V0X2JpdChORlNfSU5PX0FEVklTRV9SRFBMVVMsICZuZnNpLT5mbGFncyk7DQo+IC0JCWludmFs
aWRhdGVfbWFwcGluZ19wYWdlcyhkaXItPmlfbWFwcGluZywgMCwgLTEpOw0KPiArCQluZnNfemFw
X21hcHBpbmcoZGlyLCBkaXItPmlfbWFwcGluZyk7DQo+ICsJCWludmFsaWRhdGVfbWFwcGluZ19w
YWdlcyhkaXItPmlfbWFwcGluZywNCj4gKwkJCW5mc2ktPnBhZ2VfaW5kZXggKyAxLCAtMSk7DQo+
ICAJfQ0KPiAgfQ0KPiAgDQo+IEBAIC03MDksNiArNzExLDkgQEAgc3RydWN0IHBhZ2UNCj4gKmdl
dF9jYWNoZV9wYWdlKG5mc19yZWFkZGlyX2Rlc2NyaXB0b3JfdCAqZGVzYykNCj4gIGludCBmaW5k
X2NhY2hlX3BhZ2UobmZzX3JlYWRkaXJfZGVzY3JpcHRvcl90ICpkZXNjKQ0KPiAgew0KPiAgCWlu
dCByZXM7DQo+ICsJc3RydWN0IGlub2RlICppbm9kZTsNCj4gKwlzdHJ1Y3QgbmZzX2lub2RlICpu
ZnNpOw0KPiArCXN0cnVjdCBkZW50cnkgKmRlbnRyeTsNCj4gIA0KPiAgCWRlc2MtPnBhZ2UgPSBn
ZXRfY2FjaGVfcGFnZShkZXNjKTsNCj4gIAlpZiAoSVNfRVJSKGRlc2MtPnBhZ2UpKQ0KPiBAQCAt
NzE3LDYgKzcyMiwxMiBAQCBpbnQgZmluZF9jYWNoZV9wYWdlKG5mc19yZWFkZGlyX2Rlc2NyaXB0
b3JfdA0KPiAqZGVzYykNCj4gIAlyZXMgPSBuZnNfcmVhZGRpcl9zZWFyY2hfYXJyYXkoZGVzYyk7
DQo+ICAJaWYgKHJlcyAhPSAwKQ0KPiAgCQljYWNoZV9wYWdlX3JlbGVhc2UoZGVzYyk7DQo+ICsN
Cj4gKwlkZW50cnkgPSBmaWxlX2RlbnRyeShkZXNjLT5maWxlKTsNCj4gKwlpbm9kZSA9IGRfaW5v
ZGUoZGVudHJ5KTsNCj4gKwluZnNpID0gTkZTX0koaW5vZGUpOw0KPiArCW5mc2ktPnBhZ2VfaW5k
ZXggPSBkZXNjLT5wYWdlX2luZGV4Ow0KPiArDQo+ICAJcmV0dXJuIHJlczsNCj4gIH0NCj4gIA0K
PiBkaWZmIC0tZ2l0IGEvaW5jbHVkZS9saW51eC9uZnNfZnMuaCBiL2luY2x1ZGUvbGludXgvbmZz
X2ZzLmgNCj4gaW5kZXggYzA2YjFmZDEzMGYzLi5hNWY4ZjAzZWNkNTkgMTAwNjQ0DQo+IC0tLSBh
L2luY2x1ZGUvbGludXgvbmZzX2ZzLmgNCj4gKysrIGIvaW5jbHVkZS9saW51eC9uZnNfZnMuaA0K
PiBAQCAtMTY4LDYgKzE2OCw5IEBAIHN0cnVjdCBuZnNfaW5vZGUgew0KPiAgCXN0cnVjdCByd19z
ZW1hcGhvcmUJcm1kaXJfc2VtOw0KPiAgCXN0cnVjdCBtdXRleAkJY29tbWl0X211dGV4Ow0KPiAg
DQo+ICsJLyogdHJhY2sgbGFzdCBhY2Nlc3MgdG8gY2FjaGVkIHBhZ2VzICovDQo+ICsJdW5zaWdu
ZWQgbG9uZwkJcGFnZV9pbmRleDsNCj4gKw0KPiAgI2lmIElTX0VOQUJMRUQoQ09ORklHX05GU19W
NCkNCj4gIAlzdHJ1Y3QgbmZzNF9jYWNoZWRfYWNsCSpuZnM0X2FjbDsNCj4gICAgICAgICAgLyog
TkZTdjQgc3RhdGUgKi8NCi0tIA0KVHJvbmQgTXlrbGVidXN0DQpMaW51eCBORlMgY2xpZW50IG1h
aW50YWluZXIsIEhhbW1lcnNwYWNlDQp0cm9uZC5teWtsZWJ1c3RAaGFtbWVyc3BhY2UuY29tDQoN
Cg0K

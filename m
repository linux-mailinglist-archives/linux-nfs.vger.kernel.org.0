Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3FC5C1511BA
	for <lists+linux-nfs@lfdr.de>; Mon,  3 Feb 2020 22:21:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726561AbgBCVVc (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 3 Feb 2020 16:21:32 -0500
Received: from mail-bn8nam11on2066.outbound.protection.outlook.com ([40.107.236.66]:10432
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726278AbgBCVVc (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Mon, 3 Feb 2020 16:21:32 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=avD9JUfv4/gyKqnmaxltjdCwWUYAUlsxiI2jwT0FSi2MhBcCquYnN284ZDFtkcg1POkYUq1EE0nDtgLxYWxxafvoVrN3bH54H2IBiQwIkMY93EAcXl5V6bgK4yLV/ugdDBFA5SxhIpEShY4q9zX/sVPZEjl2VB9xumpyHOVybc41JPeXyMCeg1qLIJE1l9IecPRG0hw0ib3eymHdHgvt11RO/OL7wj+SwxEZODw1MbcCei8kbx2rF5zpiBDeaRI0Gewjy1+sT8X9kTQcQQxnGJeS1a6+iznkEJjf7pPh1bIs5iQfX7OR2GDJC4Kwjo5gJQZ6DuU6oyXeH3AGWotcNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=acQ1viLHZCkZCncTyhb3yafeeMuzUo3idHAkW3h0sK4=;
 b=mb89ZRykT14LmSaaouYKNZIYO4eEWOqgaxF15vEEWeRF6mKBBQyMbAqGcV6PyrXffT9qlY78kHl4HOu1V58Qw9C1AOeoFJ3rlikRYswy25+u5BY3LMJK7OnE0/+NctIpvCbqsiqsTXGsbbfwsbA3uTcz6XlOENYEgZvxzvdlPxxwNpc7ts5KJZKLx1xKCS/9J+4CidR545yZd3LYc6QKxuYoCq3an+rXZeEdMa4vsu5/J8rgP20Fx6HoSns9Bu+oUB6IMqjIITlviYn0/jBnEHJOEDBDXxj035lbNjQX6g3m6Id26xCg4Ry2Gi2zEzRdm8GJ7kZIUqJUFwfcg7FTgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=netapp.com; dmarc=pass action=none header.from=netapp.com;
 dkim=pass header.d=netapp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=netapp.onmicrosoft.com; s=selector1-netapp-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=acQ1viLHZCkZCncTyhb3yafeeMuzUo3idHAkW3h0sK4=;
 b=uwPe1GfAHLWg84CscWe/5Ud6IBol4K0TaIKHO2MQIPDrrxmuOu3z41WADg+XxvschPCmTaxGOysYrgX6Pr01WJaFWyWvGZczuvEqd8/Sb0V7BRtQJw9BpdLPisQUAvTSyThxvq+jKM+fRNabiTW+j1Pq44xKxqGsctq3OFJuYUU=
Received: from DM6PR06MB6091.namprd06.prod.outlook.com (20.179.161.77) by
 DM6PR06MB5001.namprd06.prod.outlook.com (20.176.119.147) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2686.27; Mon, 3 Feb 2020 21:21:29 +0000
Received: from DM6PR06MB6091.namprd06.prod.outlook.com
 ([fe80::f1f3:b30c:a1bc:ad26]) by DM6PR06MB6091.namprd06.prod.outlook.com
 ([fe80::f1f3:b30c:a1bc:ad26%6]) with mapi id 15.20.2686.031; Mon, 3 Feb 2020
 21:21:29 +0000
From:   "Schumaker, Anna" <Anna.Schumaker@netapp.com>
To:     "trondmy@gmail.com" <trondmy@gmail.com>
CC:     "dai.ngo@oracle.com" <dai.ngo@oracle.com>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "bcodding@redhat.com" <bcodding@redhat.com>
Subject: Re: [PATCH 2/4] NFS: Directory page cache pages need to be locked
 when read
Thread-Topic: [PATCH 2/4] NFS: Directory page cache pages need to be locked
 when read
Thread-Index: AQHV2hv46pnojp8PA0aFY+L/g5EnF6gJ7Z0AgAANRICAAACyAA==
Date:   Mon, 3 Feb 2020 21:21:29 +0000
Message-ID: <af1ed1339b6854af4c6def212b1035d18ce863df.camel@netapp.com>
References: <20200202225356.995080-1-trond.myklebust@hammerspace.com>
         <20200202225356.995080-2-trond.myklebust@hammerspace.com>
         <20200202225356.995080-3-trond.myklebust@hammerspace.com>
         <16a7298dacd9fd1d08cd26b7073e9ced62c5fa24.camel@netapp.com>
         <beb3c648da7f641d34f9a1cbef5639ba014de6db.camel@gmail.com>
In-Reply-To: <beb3c648da7f641d34f9a1cbef5639ba014de6db.camel@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.34.3 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Anna.Schumaker@netapp.com; 
x-originating-ip: [68.42.68.242]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ca925013-0b2b-495e-0dfb-08d7a8ef08ff
x-ms-traffictypediagnostic: DM6PR06MB5001:
x-microsoft-antispam-prvs: <DM6PR06MB5001F52ECA8F9F46271922A1F8000@DM6PR06MB5001.namprd06.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 0302D4F392
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(136003)(396003)(376002)(39860400002)(346002)(366004)(189003)(199004)(2616005)(6506007)(6512007)(2906002)(186003)(26005)(6486002)(71200400001)(478600001)(4326008)(86362001)(6916009)(54906003)(316002)(5660300002)(81166006)(8936002)(8676002)(81156014)(36756003)(64756008)(66446008)(66556008)(91956017)(76116006)(66476007)(66946007);DIR:OUT;SFP:1101;SCL:1;SRVR:DM6PR06MB5001;H:DM6PR06MB6091.namprd06.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: netapp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: mn9FbRfu21E4T3qtBE6wCi3yrmS8usdI11VLyusSYRgZuEyaD4bkn/WDVNQSMhJjOSZR9Q2lJffvIesecGIasPxGupFUfXb8RuuLILFU+V77DbBsI2b6afoZVnnU18mECgUPJnud44gyFnXvl2BZTb98tbikiQKGWvxL7VakjrRK5UvZmBtbrqJ8dmcJSk5KgghyWTxSMB7ChcR7ikfXdKDjpIuP9oIV5VEm5BGiVIvd15bscduosk4CYKzn2G2CtUDx6uf7KcCBLE6i6ykh8Z62ferQatWj/wd6nRKlVQVuUKtE/JQbGp4nIsGCEYz4ySpsaG98DvvZfUtJTlcslx5r1tz2u0sEQudUU58f7nckJFnvrzBqW+FzZNJKFwFHAJ9wEQyBTTgK8SenxM57S8QcalgBRVhbTI1ktGKjgtaanGGgtUXLnGrvQlhQXMsw
x-ms-exchange-antispam-messagedata: 1RizKAFypP8TE1SCcqWA5BhHeZsxmGtNayv3ACPmI706uRt0t9e2gnfUaYuC2NmGV1MbwjJnOVd0khHxtMovfEsgt5FCACGVtn8tioJJzpQl9qV8YYidHHRhfqt4epoV5qndC/HE5Le9br52Z17vew==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <4BFEB69B831E824AB406336E3E0BD764@namprd06.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: netapp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ca925013-0b2b-495e-0dfb-08d7a8ef08ff
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Feb 2020 21:21:29.7217
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4b0911a0-929b-4715-944b-c03745165b3a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NXAuD21YmyiN4q+3JwJ6MPE7rn2vchPukIJLgAyFfLl77kAcHywUP0iNCoR9w+pAapFBLsINaSpsvzosk80PPg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR06MB5001
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

T24gTW9uLCAyMDIwLTAyLTAzIGF0IDE2OjE4IC0wNTAwLCBUcm9uZCBNeWtsZWJ1c3Qgd3JvdGU6
DQo+IE9uIE1vbiwgMjAyMC0wMi0wMyBhdCAyMDozMSArMDAwMCwgU2NodW1ha2VyLCBBbm5hIHdy
b3RlOg0KPiA+IEhpIFRyb25kLA0KPiA+IA0KPiA+IE9uIFN1biwgMjAyMC0wMi0wMiBhdCAxNzo1
MyAtMDUwMCwgVHJvbmQgTXlrbGVidXN0IHdyb3RlOg0KPiA+ID4gV2hlbiBhIE5GUyBkaXJlY3Rv
cnkgcGFnZSBjYWNoZSBwYWdlIGlzIHJlbW92ZWQgZnJvbSB0aGUgcGFnZQ0KPiA+ID4gY2FjaGUs
DQo+ID4gPiBpdHMgY29udGVudHMgYXJlIGZyZWVkIHRocm91Z2ggYSBjYWxsIHRvIG5mc19yZWFk
ZGlyX2NsZWFyX2FycmF5KCkuDQo+ID4gPiBUbyBwcmV2ZW50IHRoZSByZW1vdmFsIG9mIHRoZSBw
YWdlIGNhY2hlIGVudHJ5IHVudGlsIGFmdGVyIHdlJ3ZlDQo+ID4gPiBmaW5pc2hlZCByZWFkaW5n
IGl0LCB3ZSBtdXN0IHRha2UgdGhlIHBhZ2UgbG9jay4NCj4gPiA+IA0KPiA+ID4gRml4ZXM6IDEx
ZGUzYjExZTA4YyAoIk5GUzogRml4IGEgbWVtb3J5IGxlYWsgaW4gbmZzX3JlYWRkaXIiKQ0KPiA+
ID4gQ2M6IHN0YWJsZUB2Z2VyLmtlcm5lbC5vcmcgIyB2Mi42LjM3Kw0KPiA+ID4gU2lnbmVkLW9m
Zi1ieTogVHJvbmQgTXlrbGVidXN0IDx0cm9uZC5teWtsZWJ1c3RAaGFtbWVyc3BhY2UuY29tPg0K
PiA+ID4gLS0tDQo+ID4gPiAgZnMvbmZzL2Rpci5jIHwgMzAgKysrKysrKysrKysrKysrKysrKy0t
LS0tLS0tLS0tDQo+ID4gPiAgMSBmaWxlIGNoYW5nZWQsIDE5IGluc2VydGlvbnMoKyksIDExIGRl
bGV0aW9ucygtKQ0KPiA+ID4gDQo+ID4gPiBkaWZmIC0tZ2l0IGEvZnMvbmZzL2Rpci5jIGIvZnMv
bmZzL2Rpci5jDQo+ID4gPiBpbmRleCBiYTBkNTU5MzBlOGEuLjkwNDY3YjQ0ZWMxMyAxMDA2NDQN
Cj4gPiA+IC0tLSBhL2ZzL25mcy9kaXIuYw0KPiA+ID4gKysrIGIvZnMvbmZzL2Rpci5jDQo+ID4g
PiBAQCAtNzA1LDggKzcwNSw2IEBAIGludCBuZnNfcmVhZGRpcl9maWxsZXIodm9pZCAqZGF0YSwg
c3RydWN0IHBhZ2UqDQo+ID4gPiBwYWdlKQ0KPiA+ID4gIHN0YXRpYw0KPiA+ID4gIHZvaWQgY2Fj
aGVfcGFnZV9yZWxlYXNlKG5mc19yZWFkZGlyX2Rlc2NyaXB0b3JfdCAqZGVzYykNCj4gPiA+ICB7
DQo+ID4gPiAtCWlmICghZGVzYy0+cGFnZS0+bWFwcGluZykNCj4gPiA+IC0JCW5mc19yZWFkZGly
X2NsZWFyX2FycmF5KGRlc2MtPnBhZ2UpOw0KPiA+ID4gIAlwdXRfcGFnZShkZXNjLT5wYWdlKTsN
Cj4gPiA+ICAJZGVzYy0+cGFnZSA9IE5VTEw7DQo+ID4gPiAgfQ0KPiA+ID4gQEAgLTcyMCwxOSAr
NzE4LDI4IEBAIHN0cnVjdCBwYWdlDQo+ID4gPiAqZ2V0X2NhY2hlX3BhZ2UobmZzX3JlYWRkaXJf
ZGVzY3JpcHRvcl90DQo+ID4gPiAqZGVzYykNCj4gPiA+ICANCj4gPiA+ICAvKg0KPiA+ID4gICAq
IFJldHVybnMgMCBpZiBkZXNjLT5kaXJfY29va2llIHdhcyBmb3VuZCBvbiBwYWdlIGRlc2MtDQo+
ID4gPiA+IHBhZ2VfaW5kZXgNCj4gPiA+ICsgKiBhbmQgbG9ja3MgdGhlIHBhZ2UgdG8gcHJldmVu
dCByZW1vdmFsIGZyb20gdGhlIHBhZ2UgY2FjaGUuDQo+ID4gPiAgICovDQo+ID4gPiAgc3RhdGlj
DQo+ID4gPiAtaW50IGZpbmRfY2FjaGVfcGFnZShuZnNfcmVhZGRpcl9kZXNjcmlwdG9yX3QgKmRl
c2MpDQo+ID4gPiAraW50IGZpbmRfYW5kX2xvY2tfY2FjaGVfcGFnZShuZnNfcmVhZGRpcl9kZXNj
cmlwdG9yX3QgKmRlc2MpDQo+ID4gPiAgew0KPiA+ID4gIAlpbnQgcmVzOw0KPiA+ID4gIA0KPiA+
ID4gIAlkZXNjLT5wYWdlID0gZ2V0X2NhY2hlX3BhZ2UoZGVzYyk7DQo+ID4gPiAgCWlmIChJU19F
UlIoZGVzYy0+cGFnZSkpDQo+ID4gPiAgCQlyZXR1cm4gUFRSX0VSUihkZXNjLT5wYWdlKTsNCj4g
PiA+IC0NCj4gPiA+IC0JcmVzID0gbmZzX3JlYWRkaXJfc2VhcmNoX2FycmF5KGRlc2MpOw0KPiA+
ID4gKwlyZXMgPSBsb2NrX3BhZ2Vfa2lsbGFibGUoZGVzYy0+cGFnZSk7DQo+ID4gPiAgCWlmIChy
ZXMgIT0gMCkNCj4gPiA+IC0JCWNhY2hlX3BhZ2VfcmVsZWFzZShkZXNjKTsNCj4gPiA+ICsJCWdv
dG8gZXJyb3I7DQo+ID4gPiArCXJlcyA9IC1FQUdBSU47DQo+ID4gPiArCWlmIChkZXNjLT5wYWdl
LT5tYXBwaW5nICE9IE5VTEwpIHsNCj4gPiA+ICsJCXJlcyA9IG5mc19yZWFkZGlyX3NlYXJjaF9h
cnJheShkZXNjKTsNCj4gPiA+ICsJCWlmIChyZXMgPT0gMCkNCj4gPiA+ICsJCQlyZXR1cm4gMDsN
Cj4gPiA+ICsJfQ0KPiA+ID4gKwl1bmxvY2tfcGFnZShkZXNjLT5wYWdlKTsNCj4gPiA+ICtlcnJv
cjoNCj4gPiA+ICsJY2FjaGVfcGFnZV9yZWxlYXNlKGRlc2MpOw0KPiA+ID4gIAlyZXR1cm4gcmVz
Ow0KPiA+ID4gIH0NCj4gPiA+ICANCj4gPiANCj4gPiBDYW4geW91IGdpdmUgbWUgc29tZSBndWlk
YW5jZSBvbiBob3cgdG8gYXBwbHkgdGhpcyBvbiB0b3Agb2YgRGFpJ3MgdjINCj4gPiBwYXRjaCBm
cm9tDQo+ID4gSmFudWFyeSAyMz8gUmlnaHQgbm93IEkgaGF2ZSB0aGUgbmZzaS0+cGFnZV9pbmRl
eCBnZXR0aW5nIHNldCBiZWZvcmUNCj4gPiB0aGUNCj4gPiB1bmxvY2tfcGFnZSgpOg0KPiANCj4g
U2luY2UgdGhpcyBuZWVkcyB0byBiZSBhIHN0YWJsZSBwYXRjaCwgaXQgd291bGQgYmUgcHJlZmVy
YWJsZSB0byBhcHBseQ0KPiB0aGVtIGluIHRoZSBvcHBvc2l0ZSBvcmRlciB0byBhdm9pZCBhbiBl
eHRyYSBkZXBlbmRlbmN5IG9uIERhaSdzIHBhdGNoLg0KDQpUaGF0IG1ha2VzIHNlbnNlLg0KDQo+
IA0KPiBUaGF0IHNhaWQsIHNpbmNlIHRoZSBuZnNpLT5wYWdlX2luZGV4IGlzIG5vdCBhIHBlci1w
YWdlIHZhcmlhYmxlLCB0aGVyZQ0KPiBpcyBubyBuZWVkIHRvIHB1dCBpdCB1bmRlciB0aGUgcGFn
ZSBsb2NrLg0KDQpHb3QgaXQuIEknbGwgc3dhcCB0aGUgb3JkZXIgb2YgZXZlcnl0aGluZywgYW5k
IHB1dCB0aGUgcGFnZV9pbmRleCBvdXRzaWRlIG9mIHRoZQ0KcGFnZSBsb2NrIHdoZW4gcmVzb2x2
aW5nIHRoZSBjb25mbGljdC4NCg0KVGhhbmtzIQ0KQW5uYQ0KDQo+IA0KPiANCj4gPiBAQCAtNzMy
LDE1ICs3MzMsMjQgQEAgaW50IGZpbmRfY2FjaGVfcGFnZShuZnNfcmVhZGRpcl9kZXNjcmlwdG9y
X3QNCj4gPiAqZGVzYykNCj4gPiAgCWlmIChJU19FUlIoZGVzYy0+cGFnZSkpDQo+ID4gIAkJcmV0
dXJuIFBUUl9FUlIoZGVzYy0+cGFnZSk7DQo+ID4gIA0KPiA+IC0JcmVzID0gbmZzX3JlYWRkaXJf
c2VhcmNoX2FycmF5KGRlc2MpOw0KPiA+ICsJcmVzID0gbG9ja19wYWdlX2tpbGxhYmxlKGRlc2Mt
PnBhZ2UpOw0KPiA+ICAJaWYgKHJlcyAhPSAwKQ0KPiA+ICAJCWNhY2hlX3BhZ2VfcmVsZWFzZShk
ZXNjKTsNCj4gPiArCQlnb3RvIGVycm9yOw0KPiA+ICsJcmVzID0gLUVBR0FJTjsNCj4gPiArCWlm
IChkZXNjLT5wYWdlLT5tYXBwaW5nICE9IE5VTEwpIHsNCj4gPiArCQlyZXMgPSBuZnNfcmVhZGRp
cl9zZWFyY2hfYXJyYXkoZGVzYyk7DQo+ID4gKwkJaWYgKHJlcyA9PSAwKQ0KPiA+ICsJCQlyZXR1
cm4gMDsNCj4gPiArCX0NCj4gPiAgDQo+ID4gIAlkZW50cnkgPSBmaWxlX2RlbnRyeShkZXNjLT5m
aWxlKTsNCj4gPiAgCWlub2RlID0gZF9pbm9kZShkZW50cnkpOw0KPiA+ICAJbmZzaSA9IE5GU19J
KGlub2RlKTsNCj4gPiAgCW5mc2ktPnBhZ2VfaW5kZXggPSBkZXNjLT5wYWdlX2luZGV4Ow0KPiA+
IC0NCj4gPiArCXVubG9ja19wYWdlKGRlc2MtPnBhZ2UpOw0KPiA+ICtlcnJvcjoNCj4gPiArCWNh
Y2hlX3BhZ2VfcmVsZWFzZShkZXNjKTsNCj4gPiAgCXJldHVybiByZXM7DQo+ID4gIH0NCj4gPiAg
DQo+ID4gDQo+ID4gUGxlYXNlIGxldCBtZSBrbm93IGlmIHRoZXJlIGlzIGEgYmV0dGVyIHdheSB0
byBoYW5kbGUgdGhlIGNvbmZsaWN0IQ0KPiA+IA0KPiA+IEFubmENCj4gPiANCj4gPiANCj4gPiA+
IEBAIC03NDcsNyArNzU0LDcgQEAgaW50DQo+ID4gPiByZWFkZGlyX3NlYXJjaF9wYWdlY2FjaGUo
bmZzX3JlYWRkaXJfZGVzY3JpcHRvcl90DQo+ID4gPiAqZGVzYykNCj4gPiA+ICAJCWRlc2MtPmxh
c3RfY29va2llID0gMDsNCj4gPiA+ICAJfQ0KPiA+ID4gIAlkbyB7DQo+ID4gPiAtCQlyZXMgPSBm
aW5kX2NhY2hlX3BhZ2UoZGVzYyk7DQo+ID4gPiArCQlyZXMgPSBmaW5kX2FuZF9sb2NrX2NhY2hl
X3BhZ2UoZGVzYyk7DQo+ID4gPiAgCX0gd2hpbGUgKHJlcyA9PSAtRUFHQUlOKTsNCj4gPiA+ICAJ
cmV0dXJuIHJlczsNCj4gPiA+ICB9DQo+ID4gPiBAQCAtNzg2LDcgKzc5Myw2IEBAIGludCBuZnNf
ZG9fZmlsbGRpcihuZnNfcmVhZGRpcl9kZXNjcmlwdG9yX3QNCj4gPiA+ICpkZXNjKQ0KPiA+ID4g
IAkJZGVzYy0+ZW9mID0gdHJ1ZTsNCj4gPiA+ICANCj4gPiA+ICAJa3VubWFwKGRlc2MtPnBhZ2Up
Ow0KPiA+ID4gLQljYWNoZV9wYWdlX3JlbGVhc2UoZGVzYyk7DQo+ID4gPiAgCWRmcHJpbnRrKERJ
UkNBQ0hFLCAiTkZTOiBuZnNfZG9fZmlsbGRpcigpIGZpbGxpbmcgZW5kZWQgQA0KPiA+ID4gY29v
a2llICVMdTsNCj4gPiA+IHJldHVybmluZyA9ICVkXG4iLA0KPiA+ID4gIAkJCSh1bnNpZ25lZCBs
b25nIGxvbmcpKmRlc2MtPmRpcl9jb29raWUsIHJlcyk7DQo+ID4gPiAgCXJldHVybiByZXM7DQo+
ID4gPiBAQCAtODMyLDEzICs4MzgsMTMgQEAgaW50IHVuY2FjaGVkX3JlYWRkaXIobmZzX3JlYWRk
aXJfZGVzY3JpcHRvcl90DQo+ID4gPiAqZGVzYykNCj4gPiA+ICANCj4gPiA+ICAJc3RhdHVzID0g
bmZzX2RvX2ZpbGxkaXIoZGVzYyk7DQo+ID4gPiAgDQo+ID4gPiArIG91dF9yZWxlYXNlOg0KPiA+
ID4gKwluZnNfcmVhZGRpcl9jbGVhcl9hcnJheShkZXNjLT5wYWdlKTsNCj4gPiA+ICsJY2FjaGVf
cGFnZV9yZWxlYXNlKGRlc2MpOw0KPiA+ID4gICBvdXQ6DQo+ID4gPiAgCWRmcHJpbnRrKERJUkNB
Q0hFLCAiTkZTOiAlczogcmV0dXJucyAlZFxuIiwNCj4gPiA+ICAJCQlfX2Z1bmNfXywgc3RhdHVz
KTsNCj4gPiA+ICAJcmV0dXJuIHN0YXR1czsNCj4gPiA+IC0gb3V0X3JlbGVhc2U6DQo+ID4gPiAt
CWNhY2hlX3BhZ2VfcmVsZWFzZShkZXNjKTsNCj4gPiA+IC0JZ290byBvdXQ7DQo+ID4gPiAgfQ0K
PiA+ID4gIA0KPiA+ID4gIC8qIFRoZSBmaWxlIG9mZnNldCBwb3NpdGlvbiByZXByZXNlbnRzIHRo
ZSBkaXJlbnQgZW50cnkgbnVtYmVyLiAgQQ0KPiA+ID4gQEAgLTkwMyw2ICs5MDksOCBAQCBzdGF0
aWMgaW50IG5mc19yZWFkZGlyKHN0cnVjdCBmaWxlICpmaWxlLA0KPiA+ID4gc3RydWN0DQo+ID4g
PiBkaXJfY29udGV4dCAqY3R4KQ0KPiA+ID4gIAkJCWJyZWFrOw0KPiA+ID4gIA0KPiA+ID4gIAkJ
cmVzID0gbmZzX2RvX2ZpbGxkaXIoZGVzYyk7DQo+ID4gPiArCQl1bmxvY2tfcGFnZShkZXNjLT5w
YWdlKTsNCj4gPiA+ICsJCWNhY2hlX3BhZ2VfcmVsZWFzZShkZXNjKTsNCj4gPiA+ICAJCWlmIChy
ZXMgPCAwKQ0KPiA+ID4gIAkJCWJyZWFrOw0KPiA+ID4gIAl9IHdoaWxlICghZGVzYy0+ZW9mKTsN
Cg==

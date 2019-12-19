Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B06C7126362
	for <lists+linux-nfs@lfdr.de>; Thu, 19 Dec 2019 14:24:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726734AbfLSNYt (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 19 Dec 2019 08:24:49 -0500
Received: from mail-eopbgr770105.outbound.protection.outlook.com ([40.107.77.105]:42621
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726695AbfLSNYt (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Thu, 19 Dec 2019 08:24:49 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oYtJPCZpJJ8vxobcZVoSo0MQiZTq8MvmNxnaRfKlrPw5Ika20P1ZeccahZ/y0cFmOsCSIiTUrjsPcg2TK3KLLksiG0mesj+nvwXRtGa+t1q7tVrKJNo+kIiEOicNW6qIj+z+qIVnFI5fEIUqOlwsT/Ukfjs0e0JPoutjrHlgVfabqnBQkOKsyRuNCJYR7w0LTiXaz9zd0s5H6ihxTxj1jymsmVaYOu8wgllEdawY87I9ydkNLaQhEji4n8+GAJs0vFhhJn4GHmtJsY4W1OMxGjO/amXaZqaK7UHr5hm29q4NX7X8FaVR1ExnhNRhozrv8Imj1lTtY8vyRipepY4BeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hug3ltEy8lYBdWYDl3+RGEKemXB1ai03Oalnx0h+0Xk=;
 b=BnYdIpEmi38iOf6oXQ7e8vUEPkGwAEhsyK6SY6FptWLnw8+KxQIskoWxUwAMAJMomkkOoGDBOKHz5AxOm34RhW8CW+Ji8WoS29kMRnemTkpzZDem8ZOg3QmO8NX96KzZuitxdYt1hYGn2FGpttpUc712lA9ariTAT/IeuzaJRkgiZZW04HxSPNTfA2X+KzadbFHdPUlL91K+BYFlSSmah+QTKbHrZgtwPL3cNTJ0mxkTQ0eftHyfBONG7pvkr822dUflBCIav3I1SJZuyjXfrtp1VG9SfqH8uBd4nmFVGNqye3/QvZCeD7uF4/VbwwnPrMXdgwi6f1+kyTiOAc2yqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hug3ltEy8lYBdWYDl3+RGEKemXB1ai03Oalnx0h+0Xk=;
 b=bAOSunDEF2nU0NzUWzsPCe2kqVzkadTezVBMmD/5/sV8XJorXjCe3BCkunNFamtTGuG33ldPbkhHAz35DxODBDIWtiFp547Rzjz81GqPVl9jxTN2NpcYu1H5qpW2LrA8xXvvdkZn5zyR1LVgE6mrhUeh/rj3xL63+6u6tpLq/KQ=
Received: from DM5PR1301MB2108.namprd13.prod.outlook.com (10.174.186.34) by
 DM5PR1301MB2059.namprd13.prod.outlook.com (10.174.186.20) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2559.9; Thu, 19 Dec 2019 13:24:41 +0000
Received: from DM5PR1301MB2108.namprd13.prod.outlook.com
 ([fe80::2d23:b456:d67:f230]) by DM5PR1301MB2108.namprd13.prod.outlook.com
 ([fe80::2d23:b456:d67:f230%6]) with mapi id 15.20.2559.012; Thu, 19 Dec 2019
 13:24:41 +0000
From:   Trond Myklebust <trondmy@hammerspace.com>
To:     "neilb@suse.de" <neilb@suse.de>,
        "anna.schumaker@netapp.com" <anna.schumaker@netapp.com>
CC:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH/RFC] NFS: handle NFSv4.1 server that doesn't support
 NFS4_OPEN_CLAIM_DELEG_CUR_FH
Thread-Topic: [PATCH/RFC] NFS: handle NFSv4.1 server that doesn't support
 NFS4_OPEN_CLAIM_DELEG_CUR_FH
Thread-Index: AQHVtfUj0Db4D3dPKk6JV7ObGp2xVqfAjyIAgAA0tACAACX5gIAAB7uAgACB4IA=
Date:   Thu, 19 Dec 2019 13:24:41 +0000
Message-ID: <9f5f220e64245d7f1b0359149876b5dc056dcf12.camel@hammerspace.com>
References: <87y2v9fdz8.fsf@notabene.neil.brown.name>
         <3afd2d5c631d8e3429e025e204a7b1c95b3c1415.camel@hammerspace.com>
         <87v9qdf2gh.fsf@notabene.neil.brown.name>
         <d3299fefa94d6959d848b765ce60e2467ce1b253.camel@hammerspace.com>
         <87pngkg9ga.fsf@notabene.neil.brown.name>
In-Reply-To: <87pngkg9ga.fsf@notabene.neil.brown.name>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=trondmy@hammerspace.com; 
x-originating-ip: [68.40.189.247]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 060e7dc0-675e-4cea-bc88-08d78486cdfe
x-ms-traffictypediagnostic: DM5PR1301MB2059:
x-microsoft-antispam-prvs: <DM5PR1301MB20599AB4A2D25BA7C7F8005EB8520@DM5PR1301MB2059.namprd13.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 0256C18696
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(396003)(39830400003)(376002)(346002)(136003)(199004)(189003)(51444003)(4001150100001)(4326008)(110136005)(36756003)(71200400001)(6486002)(6512007)(86362001)(186003)(5660300002)(26005)(6506007)(316002)(8676002)(508600001)(76116006)(66946007)(91956017)(81166006)(2616005)(81156014)(2906002)(66476007)(66556008)(66446008)(64756008)(8936002);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR1301MB2059;H:DM5PR1301MB2108.namprd13.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: hammerspace.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: XQ2vitt7drH27MLwmVW/ieGZS9+Uu79ShBw1CcxYEcYofsuqM2mISB/yIveDIdVUBhZ/YQiBZlNCt0r35fE6HmvrwziEkLCIp4WMYp4boC4ypcaSYqmubyFlb2BeWohlf+OtsIJmfOeLP1BBAlLEj+tWiauu8DKYD16gh1REml9UbhCIs1RHb8OZDZ7h7t3fU/cl/KZ7Rvp47xIr3zn4do4eUaiBv/Lry+d8qhrt4/SVgYVb12CgpVVDca2JiZ4XPLKuATm2K6XVj1i+ktWYFNKfotyN1vPQa8W+T2Q6pVmcfiRv924AtNpjO9UePcQcR5ClpVDv7wtJ8hVdyHWgAeugHco/G3OscNgkdyU1b5QycxUxvN0ooLC5fL11rw31FiMRlfMoiLMaDFAcTAXfRzG6DEoi5q2TmP2ns6GdzEb6KJHF9JnrtXKVyRH0Lb0H0QKJpJMi3c6fJCBGiIi6IPFoFux7xV1tDdJWQDRfH9L10+/t4bVn4K4SrLflPzBW
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <5B030C2E14D5F24CB658EB9AFBD0A8E0@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 060e7dc0-675e-4cea-bc88-08d78486cdfe
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Dec 2019 13:24:41.2112
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hdmx6ug+PJP649HmTqg2J6X+Mm6B89S2bms+gVIX++FM0vDK7/WnJhRMdQKcjULnhnmKk9vrtm7VFWW04/mrpw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1301MB2059
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

T24gVGh1LCAyMDE5LTEyLTE5IGF0IDE2OjM5ICsxMTAwLCBOZWlsQnJvd24gd3JvdGU6DQo+IE9u
IFRodSwgRGVjIDE5IDIwMTksIFRyb25kIE15a2xlYnVzdCB3cm90ZToNCj4gDQo+ID4gT24gVGh1
LCAyMDE5LTEyLTE5IGF0IDEzOjU2ICsxMTAwLCBOZWlsQnJvd24gd3JvdGU6DQo+ID4gPiBPbiBX
ZWQsIERlYyAxOCAyMDE5LCBUcm9uZCBNeWtsZWJ1c3Qgd3JvdGU6DQo+ID4gPiANCj4gPiA+ID4g
T24gVGh1LCAyMDE5LTEyLTE5IGF0IDA5OjQ3ICsxMTAwLCBOZWlsQnJvd24gd3JvdGU6DQo+ID4g
PiA+ID4gSWYgYW4gTkZTdjQuMSBzZXJ2ZXIgZG9lc24ndCBzdXBwb3J0DQo+ID4gPiA+ID4gTkZT
NF9PUEVOX0NMQUlNX0RFTEVHX0NVUl9GSA0KPiA+ID4gPiA+IChlLmcuIExpbnV4IDMuMCksIGFu
ZCBhIG5ld2VyIE5GUyBjbGllbnQgdHJpZXMgdG8gdXNlIGl0IHRvDQo+ID4gPiA+ID4gY2xhaW0N
Cj4gPiA+ID4gPiBhbiBvcGVuIGJlZm9yZSByZXR1cm5pbmcgYSBkZWxlZ2F0aW9uLCB0aGUgc2Vy
dmVyIG1pZ2h0DQo+ID4gPiA+ID4gcmV0dXJuDQo+ID4gPiA+ID4gTkZTNEVSUl9CQURYRFIuDQo+
ID4gPiA+ID4gVGhhdCBpcyB3aGF0IExpbnV4IDMuMCBkb2VzLCB0aG91Z2ggdGhlIFJGQyBkb2Vz
bid0IHNlZW0gdG8NCj4gPiA+ID4gPiBiZQ0KPiA+ID4gPiA+IGV4cGxpY2l0DQo+ID4gPiA+ID4g
b24gd2hpY2ggZmxhZ3MgbXVzdCBiZSBzdXBwb3J0ZWQsIGFuZCB3aGF0IGVycm9yIGNhbiBiZQ0K
PiA+ID4gPiA+IHJldHVybmVkDQo+ID4gPiA+ID4gZm9yDQo+ID4gPiA+ID4gdW5zdXBwb3J0ZWQg
ZmxhZ3MuDQo+ID4gPiA+IA0KPiA+ID4gPiBORlM0RVJSX0JBRFhEUiBpcyBkZWZpbmVkIGluIFJG
QzU2NjEsIHNlY3Rpb24gMTUuMS4xLjEgYXMNCj4gPiA+ID4gbWVhbmluZw0KPiA+ID4gPiANCj4g
PiA+ID4gIlRoZSBhcmd1bWVudHMgZm9yIHRoaXMgb3BlcmF0aW9uIGRvIG5vdCBtYXRjaCB0aG9z
ZSBzcGVjaWZpZWQNCj4gPiA+ID4gaW4NCj4gPiA+ID4gdGhlDQo+ID4gPiA+IFhEUiBkZWZpbml0
aW9uLiINCj4gPiA+ID4gDQo+ID4gPiA+IFRoYXQncyBjbGVhcmx5IG5vdCB0aGUgY2FzZSBoZXJl
LCBzbyBJJ2QgY2hhbGsgdGhpcyBkb3duIHRvIGENCj4gPiA+ID4gZmFpcmx5DQo+ID4gPiA+IGJs
YXRhbnQgc2VydmVyIGJ1ZywgYXQgd2hpY2ggcG9pbnQgaXQgbWFrZXMgbm8gc2Vuc2UgdG8gZml4
IGl0DQo+ID4gPiA+IGluDQo+ID4gPiA+IHRoZQ0KPiA+ID4gPiBjbGllbnQuDQo+ID4gPiANCj4g
PiA+IE9rLCBidXQgdGhlIFJGQyBzZWVtcyB0byBzdWdnZXN0IGl0IGlzIE9LIHRvIG5vdCBzdXBw
b3J0IHRoaXMNCj4gPiA+IGZsYWcsDQo+ID4gPiBzbw0KPiA+ID4gc3VwcG9zZSBJIGZpeGVkIHRo
ZSBzZXJ2ZXIgdG8gcmV0dXJuIE5GUzRFUlJfTk9UU1VQUCBpbnN0ZWFkLg0KPiA+ID4gVGhlIGNs
aWVudCBzdGlsbCB3b3VsZG4ndCBoYW5kbGUgdGhpcyByZXNwb25zZSBncmFjZWZ1bGx5Lg0KPiA+
ID4gDQo+ID4gDQo+ID4gTkZTNEVSUl9OT1RTVVBQIGlzIHdyb25nIHRvbyBhcyB0aGUgT1BFTiBv
cGVyYXRpb24gaXMgY2xlYXJseQ0KPiA+IHN1cHBvcnRlZC4gVGhlIG9ubHkgZXJyb3IgdGhhdCBt
aWdodCBtYWtlIHNlbnNlIGlzIE5GUzRFUlJfSU5WQUw6DQo+ID4gDQo+ID4gIjE1LjEuMS40LiAg
TkZTNEVSUl9JTlZBTCAoRXJyb3IgQ29kZSAyMikNCj4gPiANCj4gPiAgICBUaGUgYXJndW1lbnRz
IGZvciB0aGlzIG9wZXJhdGlvbiBhcmUgbm90IHZhbGlkIGZvciBzb21lIHJlYXNvbiwNCj4gPiBl
dmVuDQo+ID4gICAgdGhvdWdoIHRoZXkgZG8gbWF0Y2ggdGhvc2Ugc3BlY2lmaWVkIGluIHRoZSBY
RFIgZGVmaW5pdGlvbiBmb3INCj4gPiB0aGUNCj4gPiAgICByZXF1ZXN0LiINCj4gPiANCj4gPiBU
aGF0IHNhaWQsIHdoeSBkbyB3ZSBjYXJlIGFib3V0IHN1cHBvcnRpbmcgTkZTdjQuMSBvbiB0aGlz
IHNlcnZlcj8NCj4gPiBJdA0KPiA+IGlzIGNsZWFybHkgYnJva2VuLg0KPiANCj4gSSBjYXJlIGFi
b3V0IGl0IGJlY2F1c2UgYSBjdXN0b21lciBoYXMgYSBzdXBwb3J0IGNvbnRyYWN0LCBidXQgdGhh
dA0KPiBpc24ndCB5b3VyIHByb2JsZW0uDQo+IA0KPiBJIHdvdWxkIHRoaW5rICJ3ZSIgY2FyZSBh
Ym91dCBpdCBiZWNhdXNlIHdlIHdhbnQgdG8gc3VwcG9ydCB0aGUgc3BlYywNCj4gYW5kIHRoZSBz
cGVjIChSRkMgNTY2MSBzZWN0aW9uIDIuNCkgc2F5czoNCj4gDQo+ICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgd2hlcmUgdGhlDQo+IHNlcnZl
cg0KPiAgICBzdXBwb3J0cyBuZWl0aGVyIHRoZSBDTEFJTV9ERUxFR0FURV9QUkVWIG5vciBDTEFJ
TV9ERUxFR19DVVJfRkgNCj4gY2xhaW0NCj4gICAgdHlwZXMNCg0KR2l2ZW4gdGhlIGNvbnRleHQs
IEkgdGhpbmsgdGhhdCBpcyBhY3R1YWxseSBhIHR5cG8uIEl0IGxvb2tzIHRvIG1lIGxpa2UNCml0
IGlzIHRhbGtpbmcgYWJvdXQgQ0xBSU1fREVMRUdBVEVfUFJFViBhbmQgQ0xBSU1fREVMRUdfUFJF
Vl9GSCwgc2luY2UNCm90aGVyd2lzZSB0aGUgdGFsayBhYm91dCByZWxlYXNpbmcgZGVsZWdhdGlv
biBzdGF0ZSB3aGVuIGVzdGFibGlzaGluZyBhDQpuZXcgbGVhc2UgbWFrZXMgbm8gc2Vuc2UuDQoN
Cg0KPiBBbHNvIHlvdSBoYXZlIGNvZGUgaW4gdGhlIGNsaWVudCB0byBoYW5kbGUgdGhlIHBvc3Np
YmlsaXR5IHRoYXQgYW4NCj4gTkZTdjQuMSBvciBsYXRlciBzZXJ2ZXIgbWlnaHQgbm90IGhhbmRs
ZSBzb21lIGZlYXR1cmVzIG9mIE9QRU4uDQo+IFRocmVlIHNlcGFyYXRlIGZlYXR1cmVzIGFyZSBn
cm91cGVkIHVuZGVyICJORlNfQ0FQX0FUT01JQ19PUEVOX1YxIjoNCj4gSWYgdGhpcyBpc24ndCBz
ZXQsIHdlIGZhbGwgYmFjazoNCj4gDQo+ICAgICAgICAgY2FzZSBORlM0X09QRU5fQ0xBSU1fRkg6
DQo+ICAgICAgICAgICAgICAgICByZXR1cm4gTkZTNF9PUEVOX0NMQUlNX05VTEw7DQo+ICAgICAg
ICAgY2FzZSBORlM0X09QRU5fQ0xBSU1fREVMRUdfQ1VSX0ZIOg0KPiAgICAgICAgICAgICAgICAg
cmV0dXJuIE5GUzRfT1BFTl9DTEFJTV9ERUxFR0FURV9DVVI7DQo+ICAgICAgICAgY2FzZSBORlM0
X09QRU5fQ0xBSU1fREVMRUdfUFJFVl9GSDoNCj4gICAgICAgICAgICAgICAgIHJldHVybiBORlM0
X09QRU5fQ0xBSU1fREVMRUdBVEVfUFJFVjsNCj4gDQoNClJpZ2h0LiBUaGF0J3MgYSBjb252ZW5p
ZW5jZSBmb3IgZG93bmdyYWRpbmcgTkZTdjQuMSBzZXJ2aWNlIHRvIHdoYXQgaXMNCnN1cHBvcnRl
ZCBieSBORlN2NC4wLg0KDQo+IEhvd2V2ZXIgbmZzNF9tYXBfYXRvbWljX29wZW5fY2xhaW0oKSBp
cyBub3QgY2FsbGVkIHdoZW4NCj4gTkZTNF9PUEVOX0NMQUlNX0RFTEVHX0NVUl9GSCBpcyB0cmll
ZCwgYW5kIGZhaWxzLiAgVGhpcyBhcHBlYXJzDQo+IHRvIGJlIGFuIG9taXNzaW9uIGluIHRoZSBj
b2RlLg0KPiANCg0KSXQgaXMgZGVsaWJlcmF0ZS4gVGhlcmUgcmVhbGx5IGlzbid0IGFueXRoaW5n
IHRoYXQgZGVzY3JpYmVzIHdoYXQgaXMNCmFuZCBpc24ndCBtYW5kYXRvcnkgdG8gaW1wbGVtZW50
IGluIE5GU3Y0LjEsIGJ1dCBpZiB3ZSBoYXZlIHRvIG1ha2UNCmV2ZXJ5dGhpbmcgb3B0aW9uYWws
IHRoZW4gd2UncmUgZ29pbmcgdG8gaGF2ZSB0byBhZGQgYSBsb3Qgb2YgbW9zdGx5DQp1bm5lY2Vz
c2FyeSBjb21wbGV4aXR5IHRvIHRoZSBjbGllbnQuDQpBdCB3aGF0IHBvaW50IGRvIHdlIHRoZW4g
c3RvcD8gRG8gd2Ugc3VwcG9ydCBhIE5GU3Y0LjEgc2VydmVyIHRoYXQNCmltcGxlbWVudHMgbm8g
TkZTdjQuMSBmZWF0dXJlcz8gV2h5IG5vdCBqdXN0IGxldCB0aGUgY2xpZW50IGRvd25ncmFkZQ0K
dG8gTkZTdjQuMCBpbiB0aGF0IGNhc2U/DQoNCg0KLS0gDQpUcm9uZCBNeWtsZWJ1c3QNCkxpbnV4
IE5GUyBjbGllbnQgbWFpbnRhaW5lciwgSGFtbWVyc3BhY2UNCnRyb25kLm15a2xlYnVzdEBoYW1t
ZXJzcGFjZS5jb20NCg0KDQo=

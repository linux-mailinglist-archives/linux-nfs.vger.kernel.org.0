Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C16132CE5B3
	for <lists+linux-nfs@lfdr.de>; Fri,  4 Dec 2020 03:28:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725984AbgLDC2A (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 3 Dec 2020 21:28:00 -0500
Received: from mail-bn8nam12on2101.outbound.protection.outlook.com ([40.107.237.101]:45537
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725960AbgLDC17 (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Thu, 3 Dec 2020 21:27:59 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lMM5Elf3KAQZFg7Fctgb732UmAHqQM0MksdyZ15ktxwOUFcyhHdUsC64losJidy7oHKFbyT5WRrlAgE4HLwTpO07khE3FxGJOt1xga9KrPiv2f5aCRbytB1DFFx/D96ZiVT4ekiTSIO8EnU7wGo5Ee4PkEahCbIskJR/PJ1OUF2wtmz4duH0yQrVS+VI48kNOzezoi7uOaYbYVr3Now3oagu0/PbU8CR01K6TRxnRPVYlW+vDdOFpk05PTx7nMIA60t2tMjJjva78EucTxLdMMpRXCvNG8ATum5YAnFiHKCU8PnyfXuX3HNdwvxEob+iODULVe5joucX8dxOg763Vw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BytVoS1i5XQp7fp2VGBo0VDJ6I/Gv2b5DGlrfIdCo64=;
 b=S7pH7DEjKZHzKYhQdK76MAqPTxvYqrhJmLjRVeQL9MfmIyMl0g3Np7M9eMDYX3aWNwM7Ps2Qmevy1Gidg1Y5wvG3dJ+YU6ULmmd/TYTXRebbdeuJG52BfMtxB8qYASwTeMcgYQr9PoJ3vTXWTfRXnV9cY9ntRbaRzRv2cFIe1nG1CndW+w9INJtzbrBRcpx4eprbuMfbn4xS+K39w6mjaLg5LJRpK7cw8C75SJ7M8vn6yzmWV1NsTrXiz+bnNhJtyrOjJ/P+/6SG5C+f/7tdmJ3QSeHF1+uF/wR/FZ4zrmD3TENZSVd7FeydmrxjI9Q5kIpsa/hxVVCKA519KcYB2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BytVoS1i5XQp7fp2VGBo0VDJ6I/Gv2b5DGlrfIdCo64=;
 b=hH/pocRrPoFLTZ6vboEE7svIHOvwMiR00ON9We5Y2kR/o1sy5YNkHHM5BcnSQ8uNwoXKHczSxrxpQxpUPr3zNFJtXEgFZPJb+FxIF+AaIYAl7BXEFBAbHSQqy//uXy8AUESqZVDSS4l1N6sD4exw0ETxUf4QsSJRWQ+H0xMJoHI=
Received: from MN2PR13MB3957.namprd13.prod.outlook.com (2603:10b6:208:263::11)
 by MN2PR13MB2735.namprd13.prod.outlook.com (2603:10b6:208:f2::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3632.9; Fri, 4 Dec
 2020 02:27:06 +0000
Received: from MN2PR13MB3957.namprd13.prod.outlook.com
 ([fe80::e989:f666:131a:e210]) by MN2PR13MB3957.namprd13.prod.outlook.com
 ([fe80::e989:f666:131a:e210%9]) with mapi id 15.20.3632.016; Fri, 4 Dec 2020
 02:27:06 +0000
From:   Trond Myklebust <trondmy@hammerspace.com>
To:     "bfields@fieldses.org" <bfields@fieldses.org>
CC:     "linux-cachefs@redhat.com" <linux-cachefs@redhat.com>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "daire@dneg.com" <daire@dneg.com>
Subject: Re: Adventures in NFS re-exporting
Thread-Topic: Adventures in NFS re-exporting
Thread-Index: fNDm/l4o9cYx5Rz5g0S1EO4zMAtIR4tJDJwAAAWCe4BeKhpLVGiQL7pUtKchSdvFeTqNAIAEhEYAgBNavQCAAAtBAIABTyGAgAxAb4CAAG0ggIAAGvSAgAAMzwCAAAXZAIAAE9IAgAACQQCAAAaSgIAAHXOAgAAKzwCAAAzbgA==
Date:   Fri, 4 Dec 2020 02:27:06 +0000
Message-ID: <55fc9b74ed33e08e046031515fa10532f7b46877.camel@hammerspace.com>
References: <932244432.93596532.1606324491501.JavaMail.zimbra@dneg.com>
         <1403656117.98163597.1606998035261.JavaMail.zimbra@dneg.com>
         <20201203185109.GB27931@fieldses.org>
         <4903965f2beb742e0eca089b5db8aa3a4cabb7f0.camel@hammerspace.com>
         <20201203211328.GC27931@fieldses.org>
         <9df8556bf825bd0d565f057b115e35c1b507cf46.camel@hammerspace.com>
         <20201203224520.GG27931@fieldses.org>
         <d88c69f90820bf631908cbe3d3ce34343ec672f1.camel@hammerspace.com>
         <20201203231655.GH27931@fieldses.org>
         <136e9c309ad962cb247b9e696633484db76d1f3b.camel@hammerspace.com>
         <20201204014100.GI27931@fieldses.org>
In-Reply-To: <20201204014100.GI27931@fieldses.org>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: fieldses.org; dkim=none (message not signed)
 header.d=none;fieldses.org; dmarc=none action=none
 header.from=hammerspace.com;
x-originating-ip: [68.36.133.222]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 494cbd6d-b750-4d0d-7f59-08d897fc17f7
x-ms-traffictypediagnostic: MN2PR13MB2735:
x-microsoft-antispam-prvs: <MN2PR13MB2735854359EAF05F5E9300D7B8F10@MN2PR13MB2735.namprd13.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: c+hKY3dB76nyrGpRVuAvxo3Y2D+HBKf+aA1/QU/mfvXPASDJ+yYo7Iubbs4a7GpWl8A34Hu3WrkBmmTlb56NkdxFCfKBPouspcxgSRZGk+RqiP7iqW3tB6T7vl1sCuTQDar5AqabJ1WXzhiUXTC6GiAlcdpCeaN32fRYtlp9RQrNTXnm+mkrfltTtehnFiJh7+TCMIuOlje9NySKLxJbz4C7/czb5sxyK2yvy6xCHaM2UkUloTqgL99nURsC2tNZ7LqG0yc0ibnndN6Bc+inbU9Nnt1XuntPrsXcak5rfLmJx6YoJwURz+dmfnkiM5zkJhwoXdBr2NfyrcxSbmCqOA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR13MB3957.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(39840400004)(136003)(346002)(366004)(376002)(396003)(4326008)(36756003)(186003)(8936002)(6486002)(26005)(6506007)(478600001)(6916009)(6512007)(8676002)(2906002)(2616005)(71200400001)(86362001)(66556008)(91956017)(66946007)(64756008)(66446008)(66476007)(76116006)(54906003)(316002)(5660300002)(83380400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?utf-8?B?QVVKaU1JRjV3dXA4aCtkb0EvRXBrYzJJaWVCMHBhQzVZTDdrUWYreDF3c0Zp?=
 =?utf-8?B?WWtRNnZNUEVoR2Y0bmlxZFZwTlN6VVhkUjZKTWp0T24zdTBWaEEvRk5EL243?=
 =?utf-8?B?Y3dnYnluajd4OUwrMFgzcWNrZ2xWRU1MSXBGdmRIWk9EajVvNnIxV0h5M1Rk?=
 =?utf-8?B?bGRRUFZxeTNLWFptNFBsaStuNzhOUHJMYThzOG1yamZ6L2RsY0lBMEZONjVT?=
 =?utf-8?B?eDh2VXZrWEdZbHF3Q1IrS2luUHo0ZjZWZHRtYzVQWHlNdFVtNStUZ0gxajZC?=
 =?utf-8?B?bkQyU0J0NzVRRVI5dnU0Z1pMejg5NUNDM09iTjlnTHhIUHZkMzVGc3NZd3J6?=
 =?utf-8?B?a0o0ZXJ3alBsVUpKOXd2bDdBZFZPOEFMS1N5REVHcWdMZEJnanJmczNqWkN5?=
 =?utf-8?B?d0lhb3Z0bDRwR1Izd3ltUyt1TjZiM0JYNU82dkZBZ2R1THVpUmc5aHdwRVgz?=
 =?utf-8?B?aVJHWjhzREhOam02K2dDT29nQWRKYlVLdDZ3Wmd6ZUZrMHVQU3ZmcUtaNDNX?=
 =?utf-8?B?cVBwN2doU0piWWIybGJBWG5QVGh2NVk3WmRkeW9mVEU1aC9IVGY5bDBuT0Nu?=
 =?utf-8?B?TlE1MDhtNElpa2NNd3Myb0htN3dBRlErMzlTUkFlOGU3S200REVsSXNDZGF1?=
 =?utf-8?B?Q3hJRzlVVHhaM0V1RXZYdFpnSVMxRWw2MDN6REZaQkgrUS93YzF0OW43Vi8x?=
 =?utf-8?B?cUsrM2pmK0dyN2NOdVE5V2RGQWtKS29hT1Y5MFIwUW1UZ3RWVlVraVpZUWFq?=
 =?utf-8?B?eHlyZTdTWFZXVTVPZXBEOVJmOWVqUW9vRjIzcU95REJieVUwWEttdTF1MHIy?=
 =?utf-8?B?R3ZJSU92V21CT1E2Skt0NFlXS09oMXUxdkNidk1qMDZMd3FkWTlGVTRlVENB?=
 =?utf-8?B?b0JnTkhTRk90YlhJYVBYRUM1QmhYZ1R4VGxveDc1cTFYNUwrd01IYlBVcERR?=
 =?utf-8?B?OTFLMnZ2U2dHVHNVWnNnVHp5WFJGaFk0V21Qd3RWV3hwQk5TeUNxdzBiMWIv?=
 =?utf-8?B?ay9sQ1RwaDVjUDgyR1NFWUg0Qk15czk4VkpGVWhQTmFNNHRZbm5hTmNHam9W?=
 =?utf-8?B?bGVoRG5WSU9VZU9IRU1jNlhWaEJSSmkwTmZqcFdjL1VDRWdnV29VMVZNMVY5?=
 =?utf-8?B?UzdndytHdzVCREZSYitFMk9yQ2s2ZHlBK2tPTWo5SElGZ2Eya3B4M3JVLzB1?=
 =?utf-8?B?R2p5dUk0MFdKbDBuSDdLMjhlWmhMQW9yQkVjN2pBb002U2dVK2FQUzhtK2M4?=
 =?utf-8?B?ZVVrUnVUL3hkYTd1c0VBTkUwc1h3NWJOWG9nWlJCRWJDallvVG4yQU9tR3lK?=
 =?utf-8?Q?/Ra7nXqn6i+9VrsYsb0OqoqRztQevcyito?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <69924AEBEED4FD4688827ECF98E3D37E@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR13MB3957.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 494cbd6d-b750-4d0d-7f59-08d897fc17f7
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Dec 2020 02:27:06.1199
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ECAUqtkkdCFcCnBhrlS6kf+irETNfQrFgSQtcdV9xCbNbDgekef599QBO8QePTzBLnP7YJeXKHWJeLpqQvA9dA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR13MB2735
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

T24gVGh1LCAyMDIwLTEyLTAzIGF0IDIwOjQxIC0wNTAwLCBiZmllbGRzQGZpZWxkc2VzLm9yZyB3
cm90ZToNCj4gT24gRnJpLCBEZWMgMDQsIDIwMjAgYXQgMDE6MDI6MjBBTSArMDAwMCwgVHJvbmQg
TXlrbGVidXN0IHdyb3RlOg0KPiA+IE9uIFRodSwgMjAyMC0xMi0wMyBhdCAxODoxNiAtMDUwMCwg
YmZpZWxkc0BmaWVsZHNlcy5vcmfCoHdyb3RlOg0KPiA+ID4gT24gVGh1LCBEZWMgMDMsIDIwMjAg
YXQgMTA6NTM6MjZQTSArMDAwMCwgVHJvbmQgTXlrbGVidXN0IHdyb3RlOg0KPiA+ID4gPiBPbiBU
aHUsIDIwMjAtMTItMDMgYXQgMTc6NDUgLTA1MDAsIGJmaWVsZHNAZmllbGRzZXMub3JnwqB3cm90
ZToNCj4gPiA+ID4gPiBPbiBUaHUsIERlYyAwMywgMjAyMCBhdCAwOTozNDoyNlBNICswMDAwLCBU
cm9uZCBNeWtsZWJ1c3QNCj4gPiA+ID4gPiB3cm90ZToNCj4gPiA+ID4gPiA+IEkndmUgYmVlbiB3
YW50aW5nIHN1Y2ggYSBmdW5jdGlvbiBmb3IgcXVpdGUgYSB3aGlsZSBhbnl3YXkNCj4gPiA+ID4g
PiA+IGluDQo+ID4gPiA+ID4gPiBvcmRlciB0byBhbGxvdyB0aGUgY2xpZW50IHRvIGRldGVjdCBz
dGF0ZSBsZWFrcyAoZWl0aGVyIGR1ZQ0KPiA+ID4gPiA+ID4gdG8NCj4gPiA+ID4gPiA+IHNvZnQg
dGltZW91dHMsIG9yIGR1ZSB0byByZW9yZGVyZWQgY2xvc2Uvb3BlbiBvcGVyYXRpb25zKS4NCj4g
PiA+ID4gPiANCj4gPiA+ID4gPiBPbmUgc3VyZSB3YXkgdG8gZml4IGFueSBzdGF0ZSBsZWFrcyBp
cyB0byByZWJvb3QgdGhlIHNlcnZlci7CoA0KPiA+ID4gPiA+IFRoZQ0KPiA+ID4gPiA+IHNlcnZl
ciB0aHJvd3MgZXZlcnl0aGluZyBhd2F5LCB0aGUgY2xpZW50cyByZWNsYWltLCBhbGwNCj4gPiA+
ID4gPiB0aGF0J3MNCj4gPiA+ID4gPiBsZWZ0DQo+ID4gPiA+ID4gaXMgc3R1ZmYgdGhleSBzdGls
bCBhY3R1YWxseSBjYXJlIGFib3V0Lg0KPiA+ID4gPiA+IA0KPiA+ID4gPiA+IEl0J3MgdmVyeSBk
aXNydXB0aXZlLg0KPiA+ID4gPiA+IA0KPiA+ID4gPiA+IEJ1dCB5b3UgY291bGQgZG8gYSBsaW1p
dGVkIHZlcnNpb24gb2YgdGhhdDogdGhlIHNlcnZlciB0aHJvd3MNCj4gPiA+ID4gPiBhd2F5DQo+
ID4gPiA+ID4gdGhlIHN0YXRlIGZyb20gb25lIGNsaWVudCAoa2VlcGluZyB0aGUgdW5kZXJseWlu
ZyBsb2NrcyBvbg0KPiA+ID4gPiA+IHRoZQ0KPiA+ID4gPiA+IGV4cG9ydGVkIGZpbGVzeXN0ZW0p
LCBsZXRzIHRoZSBjbGllbnQgZ28gdGhyb3VnaCBpdHMgbm9ybWFsDQo+ID4gPiA+ID4gcmVjbGFp
bQ0KPiA+ID4gPiA+IHByb2Nlc3MsIGF0IHRoZSBlbmQgb2YgdGhhdCB0aHJvd3MgYXdheSBhbnl0
aGluZyB0aGF0IHdhc24ndA0KPiA+ID4gPiA+IHJlY2xhaW1lZC7CoCBUaGUgb25seSBkZWxheSBp
cyB0byBhbnlvbmUgdHJ5aW5nIHRvIGFjcXVpcmUgbmV3DQo+ID4gPiA+ID4gbG9ja3MNCj4gPiA+
ID4gPiB0aGF0IGNvbmZsaWN0IHdpdGggdGhhdCBzZXQgb2YgbG9ja3MsIGFuZCBvbmx5IGZvciBh
cyBsb25nIGFzDQo+ID4gPiA+ID4gaXQNCj4gPiA+ID4gPiB0YWtlcyBmb3IgdGhlIG9uZSBjbGll
bnQgdG8gcmVjbGFpbS4NCj4gPiA+ID4gDQo+ID4gPiA+IE9uZSBjb3VsZCBkbyB0aGF0LCBidXQg
dGhhdCByZXF1aXJlcyB0aGUgZXhpc3RlbmNlIG9mIGENCj4gPiA+ID4gcXVpZXNjZW50DQo+ID4g
PiA+IHBlcmlvZCB3aGVyZSB0aGUgY2xpZW50IGhvbGRzIG5vIHN0YXRlIGF0IGFsbCBvbiB0aGUg
c2VydmVyLg0KPiA+ID4gDQo+ID4gPiBObywgYXMgSSBzYWlkLCB0aGUgY2xpZW50IHBlcmZvcm1z
IHJlYm9vdCByZWNvdmVyeSBmb3IgYW55IHN0YXRlDQo+ID4gPiB0aGF0DQo+ID4gPiBpdA0KPiA+
ID4gaG9sZHMgd2hlbiB3ZSBkbyB0aGlzLg0KPiA+ID4gDQo+ID4gDQo+ID4gSG1tLi4uIFNvIGhv
dyBkbyB0aGUgY2xpZW50IGFuZCBzZXJ2ZXIgY29vcmRpbmF0ZSB3aGF0IGNhbiBhbmQNCj4gPiBj
YW5ub3QNCj4gPiBiZSByZWNsYWltZWQ/IFRoZSBpc3N1ZSBpcyB0aGF0IHJhY2VzIGNhbiB3b3Jr
IGJvdGggd2F5cywgd2l0aCB0aGUNCj4gPiBjbGllbnQgc29tZXRpbWVzIGJlbGlldmluZyB0aGF0
IGl0IGhvbGRzIGEgbGF5b3V0IG9yIGEgZGVsZWdhdGlvbg0KPiA+IHRoYXQNCj4gPiB0aGUgc2Vy
dmVyIHRoaW5rcyBpdCBoYXMgcmV0dXJuZWQuIElmIHRoZSBzZXJ2ZXIgYWxsb3dzIGEgcmVjbGFp
bQ0KPiA+IG9mDQo+ID4gc3VjaCBhIGRlbGVnYXRpb24sIHRoZW4gdGhhdCBjb3VsZCBiZSBwcm9i
bGVtYXRpYyAoYmVjYXVzZSBpdA0KPiA+IGJyZWFrcw0KPiA+IGxvY2sgYXRvbWljaXR5IG9uIHRo
ZSBjbGllbnQgYW5kIGJlY2F1c2UgaXQgbWF5IGNhdXNlIGNvbmZsaWN0cykuDQo+IA0KPiBUaGUg
c2VydmVyJ3Mgbm90IGFjdHVhbGx5IGZvcmdldHRpbmcgYW55dGhpbmcsIGl0J3MganVzdCBwcmV0
ZW5kaW5nDQo+IHRvLA0KPiBpbiBvcmRlciB0byB0cmlnZ2VyIHRoZSBjbGllbnQncyByZWJvb3Qg
cmVjb3ZlcnkuwqAgSXQgY2FuIHR1cm4gZG93bg0KPiB0aGUNCj4gY2xpZW50J3MgYXR0ZW1wdCB0
byByZWNsYWltIHNvbWV0aGluZyBpdCBkb2Vzbid0IGhhdmUuDQo+IA0KPiBUaG91Z2ggaXNuJ3Qg
aXQgYWxyZWFkeSBnYW1lIG92ZXIgYnkgdGhlIHRpbWUgdGhlIGNsaWVudCB0aGlua3MgaXQNCj4g
aG9sZHMNCj4gc29tZSBsb2NrL29wZW4vZGVsZWdhdGlvbiB0aGF0IHRoZSBzZXJ2ZXIgZG9lc24n
dD/CoCBJIGd1ZXNzIEknZCBuZWVkDQo+IHRvDQo+IHNlZSB0aGVzZSBjYXNlcyB3cml0dGVuIG91
dCBpbiBkZXRhaWwgdG8gdW5kZXJzdGFuZC4NCj4gDQoNCk5vcm1hbGx5LCB0aGUgc2VydmVyIHdp
bGwgcmV0dXJuIE5GUzRFUlJfQkFEX1NUQVRFSUQgb3INCk5GUzRFUlJfT0xEX1NUQVRFSUQgaWYg
dGhlIGNsaWVudCB0cmllcyB0byB1c2UgYW4gaW52YWxpZCBzdGF0ZWlkLiBUaGUNCmlzc3VlIGhl
cmUgaXMgdGhhdCB5b3UnZCBiZSBkaXNjYXJkaW5nIHRoYXQgbWFjaGluZXJ5LCBiZWNhdXNlIHRo
ZQ0KY2xpZW50IGlzIGZvcmdldHRpbmcgaXRzIHN0YXRlaWRzIHdoZW4gaXQgZ2V0cyB0b2xkIHRo
YXQgdGhlIHNlcnZlcg0KcmVib290ZWQuDQpUaGF0IGFnYWluIHB1dHMgdGhlIG9udXMgb24gdGhl
IHNlcnZlciB0byB2ZXJpZnkgbW9yZSBzdHJvbmdseSB3aGV0aGVyDQpvciBub3QgdGhlIGNsaWVu
dCBpcyByZWNvdmVyaW5nIHN0YXRlIHRoYXQgaXQgYWN0dWFsbHkgaG9sZHMuDQoNCg0KU28gdG8g
ZWxhYm9yYXRlIGEgbGl0dGxlIG1vcmUgb24gdGhlIGNhc2VzIHdoZXJlIHdlIGhhdmUgc2VlbiB0
aGUNCmNsaWVudCBhbmQgc2VydmVyIHN0YXRlIG1lc3MgdXAgaGVyZS4gVHlwaWNhbGx5IGl0IGhh
cHBlbnMgd2hlbiB3ZQ0KYnVpbGQgQ09NUE9VTkRTIHdoZXJlIHRoZXJlIGlzIGEgc3RhdGVmdWwg
b3BlcmF0aW9uIGZvbGxvd2VkIGJ5IGEgc2xvdw0Kb3BlcmF0aW9uLiBTb21ldGhpbmcgbGlrZQ0K
DQpUaHJlYWQgMQ0KPT09PT09PT0NCk9QRU4oZm9vKSArIExBWU9VVEdFVA0KLT4gb3BlbnN0YXRl
aWQoMDE6IGJsYWgpDQoNCgkJCQlUaHJlYWQgMg0KCQkJCT09PT09PT09DQoJCQkJT1BFTihmb28p
DQoJCQkJLT5vcGVuc3RhdGVpZCgwMjogYmxhaCkNCgkJCQlDTE9TRShvcGVuc3RhdGVpZCgwMjpi
bGFoKSkNCg0KKGdldHMgcmVwbHkgZnJvbSBPUEVOKS4NCg0KVHlwaWNhbGx5IHRoZSBjbGllbnQg
Zm9yZ2V0cyBhYm91dCB0aGUgc3RhdGVpZCBhZnRlciB0aGUgQ0xPU0UsIHNvIHdoZW4NCml0IGdl
dHMgYSByZXBseSB0byB0aGUgb3JpZ2luYWwgT1BFTiwgaXQgdGhpbmtzIGl0IGp1c3QgZ290IGEN
CmNvbXBsZXRlbHkgZnJlc2ggc3RhdGVpZCAib3BlbnN0YXRlaWQoMDE6IGJsYWgpIiwgd2hpY2gg
aXQgbWlnaHQgdHJ5IHRvDQpyZWNsYWltIGlmIHRoZSBzZXJ2ZXIgZGVjbGFyZXMgYSByZWJvb3Qu
DQoNCj4gLS1iLg0KPiANCj4gPiBCeSB0aGUgd2F5LCB0aGUgb3RoZXIgdGhpbmcgdGhhdCBJJ2Qg
bGlrZSB0byBhZGQgdG8gbXkgd2lzaGxpc3QgaXMNCj4gPiBhDQo+ID4gY2FsbGJhY2sgdGhhdCBh
bGxvd3MgdGhlIHNlcnZlciB0byBhc2sgdGhlIGNsaWVudCBpZiBpdCBzdGlsbCBob2xkcw0KPiA+
IGENCj4gPiBnaXZlbiBvcGVuIG9yIGxvY2sgc3RhdGVpZC4gQSBzZXJ2ZXIgY2FuIHJlY2FsbCBh
IGRlbGVnYXRpb24gb3IgYQ0KPiA+IGxheW91dCwgc28gaXQgY2FuIGZpeCB1cCBsZWFrcyBvZiB0
aG9zZSwgaG93ZXZlciBpdCBoYXMgbm8gcmVtZWR5DQo+ID4gaWYNCj4gPiB0aGUgY2xpZW50IGxv
c2VzIGFuIG9wZW4gb3IgbG9jayBzdGF0ZWlkIG90aGVyIHRoYW4gdG8gcG9zc2libHkNCj4gPiBm
b3JjaWJseSByZXZva2Ugc3RhdGUuIFRoYXQgY291bGQgY2F1c2UgYXBwbGljYXRpb24gY3Jhc2hl
cyBpZiB0aGUNCj4gPiBzZXJ2ZXIgbWFrZXMgYSBtaXN0YWtlIGFuZCByZXZva2VzIGEgbG9jayB0
aGF0IGlzIGFjdHVhbGx5IGluIHVzZS4NCj4gPiANCg0KLS0gDQpUcm9uZCBNeWtsZWJ1c3QNCkxp
bnV4IE5GUyBjbGllbnQgbWFpbnRhaW5lciwgSGFtbWVyc3BhY2UNCnRyb25kLm15a2xlYnVzdEBo
YW1tZXJzcGFjZS5jb20NCg0KDQo=

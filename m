Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB9E53DF951
	for <lists+linux-nfs@lfdr.de>; Wed,  4 Aug 2021 03:38:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233906AbhHDBii (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 3 Aug 2021 21:38:38 -0400
Received: from mail-bn8nam12on2122.outbound.protection.outlook.com ([40.107.237.122]:40672
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233389AbhHDBih (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Tue, 3 Aug 2021 21:38:37 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b48Pbvpb7idNaZo18kCMbry8k5lgETR/mCplpyL44vuGvw1StCi8ZwOJ+0ysdWgF/gOxDos3kPsGC8gTqTA/q3WzIYg0Y/WQw38s62+sUXKirmbnhIS8zcBvpdl9OmEJ50P5zdcRJJkJYH7vXkGgVQvYAwCFIYatS6dHjJ46bjh3kIWpWeSsKYC1l4QQ71h7VQkBnIeVvGjzS9fBkoQZwKkGrmtH8V3gnxJr7FFxNi+kb7TJWXnx1hm0/KNUo5/KlsRCqQW4hhmBn7/34RQL9cHBD2Cn4Au/7XbghEzBukWlprfMwMM8QGargPzzWIyIl5/yWdJh2PdEinnX4CEgRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xmlKL42JSRV2nfn82CowQNpQ+x1H03NYStmMd4/virA=;
 b=LOOWC2yCaBh8iMiTOmUTlCRh5FgpiG31Bg+IdstlVg+fMHuuFEwZ2O/5+LDokp4S/RDwPcbwEV7pcqPHbxD/lSGTNkeFvceu7JSkkEZCo6i2KV+QPjNeSX33YkCSW8pDuckTp5Ij2Ee4zPQpzWKVvzV+8kjNidPo4lJuWWbOavB9hN2t6Y9VOrWBe4YCJyCHp4PJtt+5Yytr2WSOv99hVqYHw+OgMkGYhyIFUuokuiAOZAcb1yXqF92amDcvjFiKbArqzrr8iXMZoz+UyMeGD+salENw+9k0lo33nAp4TmGDDZc3wPHpel6qndN7mYCpSW3A79JmPKpxswcFWQO5ow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xmlKL42JSRV2nfn82CowQNpQ+x1H03NYStmMd4/virA=;
 b=NWWxTOslwKAu89vTEk0s4fl6vCDu5e8PiZwjwHoueS7l36pYnHHN2/zj2p/OL1U+9c6TVuf/ruPmmhKb43KsnUuAK6187P+iasU2/4mJH6velXDD2kMBWJhkQXy/w2IUEVBT273o0wyZtsuV9+x+g00I3CuAukbzkcREKs2hzRk=
Received: from CH0PR13MB5084.namprd13.prod.outlook.com (2603:10b6:610:111::7)
 by CH2PR13MB4489.namprd13.prod.outlook.com (2603:10b6:610:68::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4394.8; Wed, 4 Aug
 2021 01:38:23 +0000
Received: from CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::185b:505d:b35c:a3a2]) by CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::185b:505d:b35c:a3a2%6]) with mapi id 15.20.4394.015; Wed, 4 Aug 2021
 01:38:23 +0000
From:   Trond Myklebust <trondmy@hammerspace.com>
To:     "neilb@suse.de" <neilb@suse.de>
CC:     "bfields@fieldses.org" <bfields@fieldses.org>,
        "plambri@redhat.com" <plambri@redhat.com>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "bcodding@redhat.com" <bcodding@redhat.com>
Subject: Re: cto changes for v4 atomic open
Thread-Topic: cto changes for v4 atomic open
Thread-Index: AQHXhUZ9owuGm7b0CEqtoxaJkItc06tbmWqAgAao74CAAAokgIAACEIAgAACAoCAACJ2AIAAA5WAgAAQJoCAAAG1gIAAB2KAgAACOwA=
Date:   Wed, 4 Aug 2021 01:38:23 +0000
Message-ID: <dfe4f6ad0420a67b9ae0f500324ba976d700642c.camel@hammerspace.com>
References: <DF3F94B7-F322-4054-952F-90CE02B442FE@redhat.com>   ,
 <ef395e52f3bb8d07dd7a39bb0a6dd6fb64a87a1c.camel@hammerspace.com>       ,
 <20210803203051.GA3043@fieldses.org>   ,
 <3feb71ab232b26df6d63111ee8226f6bb7e8dc36.camel@hammerspace.com>       ,
 <20210803213642.GA4042@fieldses.org>   ,
 <a1934e03e68ada8b7d1abf1744ad1b8f9d784aa4.camel@hammerspace.com>       ,
 <162803443497.32159.4120609262211305187@noble.neil.brown.name> ,
 <08db3d70a6a4799a7f3a6f5227335403f5a148dd.camel@hammerspace.com>       ,
 <162803867150.32159.9013174090922030713@noble.neil.brown.name> ,
 <ea79c8676bea627bb78c57e33199229e3cf27a9c.camel@hammerspace.com>
         <162804062307.32159.5606967736886802956@noble.neil.brown.name>
In-Reply-To: <162804062307.32159.5606967736886802956@noble.neil.brown.name>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: suse.de; dkim=none (message not signed)
 header.d=none;suse.de; dmarc=none action=none header.from=hammerspace.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d499f830-ca9e-4272-7eb2-08d956e88c77
x-ms-traffictypediagnostic: CH2PR13MB4489:
x-microsoft-antispam-prvs: <CH2PR13MB44893DE50351541D793CA12DB8F19@CH2PR13MB4489.namprd13.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: kmL9oKdGBXAPBf05Fz5GS21ZiYJWFEushXTWnlh9riFQMZ88pJ/DjYkBBTuRH7lqzcZ0xUnZbGhRMPMCv2EoGKVYePHIzQ9fVq86+G7yjDOngNvdJJIl1CapupnWzweZIk8dz72KzxFYJHoDvBtof9eheuSNCjgzEJDJpjCnYc4SW75LA7jpJ9ApsyOuXFQ590aauoOW0gIIhEnQibfuIy5IgPDPR2L0PMGvZA4fnrOPwVju09LpVu2iyLdMwz5kfhEvUwaZ7p+03nv0lYDrmixQhcUHXpn5lzCmky9PTrd6MbohiPjhyzOsaj64FZq1OEJ3H545TVYaHV+DUB3c7S/zM5KkzPEk4MZvRP+2B4Wn7lvN07xDiN90NX6Xvab1xqGaabZE1PgPhBYFZtydD0C+CX2yfFPks+myJXcs7fxC9TcsLXJQsHSB9OWzRJJuyho9btNhkE+xTW7/yEdpnVOSMPhd+NAeKDn8Ggq2znAXJf5UrPO0VHQHilHX9ZgDWpyiDeXFBRfaVjrob0jCKzXF4NkfS1YOPOExdAxaoNLVIeVxER9omOjn1P2IRI31WiKAhPfM1d0UJNeiP5vqGc5EiJQ5wzrYh/FHPua9I49G0KnQ7XwcDnUXog1L1/2wJYQ202Sbc4BN8OtYsEy8JNnTtgPa7nZ/PxFld49c7ZuKPDBrI0Nd+PLak8GZ5/PWX37X5jF6l8a3InTJQZlAkg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR13MB5084.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(376002)(346002)(39840400004)(136003)(366004)(396003)(6512007)(8676002)(2906002)(71200400001)(4326008)(2616005)(478600001)(36756003)(6916009)(186003)(66946007)(6506007)(122000001)(83380400001)(38100700002)(316002)(8936002)(76116006)(5660300002)(38070700005)(26005)(54906003)(66446008)(86362001)(64756008)(66476007)(6486002)(66556008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NVlpa0VuemdXQUhNNkpmMSs2U21FL0FxMEtnV3RYMVp3TGdoRGUwWWlYWW9H?=
 =?utf-8?B?cmJyaUIyTmFJWnliOE1iZ01YNkMwWWpXV1R2aTJvZkdtZVNKbG91MTh4dUIw?=
 =?utf-8?B?bU53NElpUURLZXFJck5HTFpadWxBSlRGQitpaW1YOS9LQnBQRXJsZEhBak45?=
 =?utf-8?B?aDFXU0N6Vi9zUTRqdE5NSFFHTFRiRjFWWTR4aVNzZStIbkk5ZG1Ua2swWDJF?=
 =?utf-8?B?N2NiVU1tY0MzNnNuS3YwU0FjOVd3aXJiQy9sQWtCUFRVeDh3emp2K0gveEJw?=
 =?utf-8?B?aXZVL1gwbVo5enY4RVkrSXdnWEE1Y3V1VnB0TXZCTFgrMGswdVE0NlZURnl4?=
 =?utf-8?B?TFVyM0NDSEFlRERUc0IyQUduVzE5RU45ckJIR08wcTRkcmJVVHhOL3gyYW5W?=
 =?utf-8?B?TTVvakl6c2hzcEpnOUxGWU8xQjNNTGRMN3c4V2VuWCs2YnJLYlNFcmZydDlw?=
 =?utf-8?B?OG1mM2JjT1czYmFzVUFUZVNFZGZTS2Q4a0Vmc0JjWFdaQTBqT1NuTE13eVN0?=
 =?utf-8?B?SHdIaE5kSFNtSnZvTzlQVGxSSWNDb1FIVGRoUS9UK2hwTitOWXJ1eGRzNWFi?=
 =?utf-8?B?WjRWejhxMnAyZ210cGNnUUlXYnZaQTlOdEZnc3liOENJVlhmNUg0SGw1T2pK?=
 =?utf-8?B?bjdWYzJCUHBpL21uN0hOTm5KNDU0b2VFSDJTRW1TT0lZR3hmVUpIZldaZzkz?=
 =?utf-8?B?YzBrcUQ3UVV3N2lNaU1ROFpOWGd0S0cyeGozS1hFd25pY0s1cUJKUGVYUGky?=
 =?utf-8?B?TXhPdjlDcysreFpCOU9zYVk1c3lvN2MrUzRhZThnRHZldFczM1pLa1VFcVFm?=
 =?utf-8?B?Tzd0N21Odm9FbTVKRTZLeWZZeFJMTDh2RWZuSWEyUngwY0J0RFpFQnhva2xE?=
 =?utf-8?B?UXNYdDh1ek5zcEhZUjBHeXIwL2FTWDNSVlEvUzBRQW9TYXphaTNlaEVFTHBC?=
 =?utf-8?B?MW5USGJidVdxOWFMb2krMHVvYnd2VUZ2SDJPZlpXV2FwOUJ2ZFB1VjNVWFND?=
 =?utf-8?B?OHZNaS8yV1BERnlnZTJFcWtZMEw5ZDlhaWJkeTF0YVRmV0NJZ3NPeTk3ZXJs?=
 =?utf-8?B?MmtCT0NuZno4NXdDMU9CQTlHb29kWEJQaGtuZm9mc1VwSmVMa0hLUEhsSll6?=
 =?utf-8?B?TlNMaGtteFZTQUI3TVY1YWxrOGg4Zi9RblBMby85ekpYQVRpdUpFM2x0R0Nw?=
 =?utf-8?B?V1IvREdzd3kxYUJodmVGOUg1V3BaZnJxTjRiRGV1NFlvTGtUZlZrWEk3VXNr?=
 =?utf-8?B?WTFFUW1qK1lmYW5wZ3RkV3hDcUtYVjRLSEZPdnFkSlJ1cHUyR3piZnNzSEtD?=
 =?utf-8?B?SkJsY0lvQXpWSGVDdFZqZi9WN1lMVTdzeG9KbVZvSzNoNWxtQUw1dXdMUk9V?=
 =?utf-8?B?L2FzSk94T0ZvcE53Zk1zbEVhYXUrWWVZb3dGZjZuK0ZybmVGaDZaZHdmT2xm?=
 =?utf-8?B?YnNCSTVNK3ZGY1FkVWIvUklhMUZBSllHRXVoNTNMVk5sbnphTER5SzFjQ2k4?=
 =?utf-8?B?VW5McDBsVU01SFVuRlZadC92NjFWNjdpWWRNeGZiR1kxMDBjdDFZTzFqcU1P?=
 =?utf-8?B?TG5zK2E5ZkpObUo4cnoxai9BSkdWeW5BeVlXeVJpRVRwTkYzZDd4QmRZbjJP?=
 =?utf-8?B?elJuLzUxazJZQzlYNEpJdnplTWNtVW9nMjNzMWNNZWhReitHeEhqd2s1c01w?=
 =?utf-8?B?bHNJQlpHdnRIWlNEU2lEdVZTMTFxMGptdFJWSFI0L0cyMDJYdGZ2ajBVdnNM?=
 =?utf-8?Q?Rb45PBMcuJCU2vodXDxtp/QcT9x8PXhf5XpC863?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <6E9D550F2147F14E9899B492266189CF@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR13MB5084.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d499f830-ca9e-4272-7eb2-08d956e88c77
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Aug 2021 01:38:23.7404
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: F2cka5lpuw0T0Rq27DF1sRKOhKawvDQM9ZlizyaNrAuM4z2B20mnBqxWkZ7qd8A9d7lQn6ROKabwqAsT+Sg6nw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR13MB4489
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

T24gV2VkLCAyMDIxLTA4LTA0IGF0IDExOjMwICsxMDAwLCBOZWlsQnJvd24gd3JvdGU6DQo+IE9u
IFdlZCwgMDQgQXVnIDIwMjEsIFRyb25kIE15a2xlYnVzdCB3cm90ZToNCj4gPiBPbiBXZWQsIDIw
MjEtMDgtMDQgYXQgMTA6NTcgKzEwMDAsIE5laWxCcm93biB3cm90ZToNCj4gPiA+IE9uIFdlZCwg
MDQgQXVnIDIwMjEsIFRyb25kIE15a2xlYnVzdCB3cm90ZToNCj4gPiA+ID4gDQo+ID4gPiA+IE5v
LiBXaGF0IHlvdSBwcm9wb3NlIGlzIHRvIG9wdGltaXNlIGZvciBhIGZyaW5nZSBjYXNlLCB3aGlj
aCB3ZQ0KPiA+ID4gPiBjYW5ub3QNCj4gPiA+ID4gZ3VhcmFudGVlIHdpbGwgd29yayBhbnl3YXku
IEknZCBtdWNoIHJhdGhlciBvcHRpbWlzZSBmb3IgdGhlDQo+ID4gPiA+IGNvbW1vbg0KPiA+ID4g
PiBjYXNlLCB3aGljaCBpcyB0aGUgb25seSBjYXNlIHdpdGggcHJlZGljdGFibGUgc2VtYW50aWNz
Lg0KPiA+ID4gPiANCj4gPiA+IA0KPiA+ID4gInByZWRpY3RhYmxlIj8/DQo+ID4gPiANCj4gPiA+
IEFzIEkgdW5kZXJzdGFuZCBpdCAoSSBoYXZlbid0IGV4YW1pbmVkIHRoZSBjb2RlKSB0aGUgY3Vy
cmVudA0KPiA+ID4gc2VtYW50aWNzDQo+ID4gPiBpbmNsdWRlczoNCj4gPiA+IMKgSWYgYSBmaWxl
IGlzIG9wZW4gZm9yIHJlYWQsIHNvbWUgb3RoZXIgY2xpZW50IGNoYW5nZWQgdGhlIGZpbGUsDQo+
ID4gPiBhbmQNCj4gPiA+IHRoZQ0KPiA+ID4gwqAgZmlsZSBpcyB0aGVuIG9wZW5lZCwgdGhlbiB0
aGUgc2Vjb25kIG9wZW4gbWlnaHQgc2VlIG5ldyBkYXRhLA0KPiA+ID4gb3INCj4gPiA+IG1pZ2h0
DQo+ID4gPiDCoCBzZWUgb2xkIGRhdGEsIGRlcGVuZGluZyBvbiB3aGV0aGVyIHRoZSByZXF1ZXN0
ZWQgZGF0YSBpcyBzdGlsbA0KPiA+ID4gaW4NCj4gPiA+IMKgIGNhY2hlIG9yIG5vdC4NCj4gPiA+
IA0KPiA+ID4gSSBmaW5kIHRoaXMgdG8gYmUgbGVzcyBwcmVkaWN0YWJsZSB0aGFuIHRoZSBlYXN5
LXRvLXVuZGVyc3RhbmQNCj4gPiA+IHNlbWFudGljcw0KPiA+ID4gdGhhdCBCcnVjZSBoYXMgcXVv
dGVkOg0KPiA+ID4gwqAgLSByZXZhbGlkYXRlIG9uIGV2ZXJ5IG9wZW4sIGZsdXNoIG9uIGV2ZXJ5
IGNsb3NlDQo+ID4gPiANCj4gPiA+IEknbSBzdWdnZXN0aW5nIHdlIG9wdGltaXplIGZvciBmcmlu
Z2UgY2FzZXMsIEknbSBzdWdnZXN0aW5nIHdlDQo+ID4gPiBwcm92aWRlDQo+ID4gPiBzZW1hbnRp
Y3MgdGhhdCBhcmUgc2ltcGxlLCBkb2N1bWVudGF0ZWQsIGFuZCBwcmVkaWN0YWJsZS4NCj4gPiA+
IA0KPiA+IA0KPiA+ICJQcmVkaWN0YWJsZSIgaG93Pw0KPiA+IA0KPiA+IFRoaXMgaXMgY2FjaGVk
IEkvTy4gQnkgZGVmaW5pdGlvbiwgaXQgaXMgYWxsb3dlZCB0byBkbyB0aGluZ3MgbGlrZQ0KPiA+
IHJlYWRhaGVhZCwgd3JpdGViYWNrIGNhY2hpbmcsIG1ldGFkYXRhIGNhY2hpbmcuIFdoYXQgeW91
J3JlDQo+ID4gcHJvcG9zaW5nDQo+ID4gaXMgdG8gb3B0aW1pc2UgZm9yIGEgY2FzZSB0aGF0IGJy
ZWFrcyBhbGwgb2YgdGhlIGFib3ZlLiBXaGF0J3MgdGhlDQo+ID4gcG9pbnQ/IFdlIG1pZ2h0IGp1
c3QgYXMgd2VsbCB0aHJvdyBpbiB0aGUgdG93ZWwgYW5kIGp1c3QgbWFrZQ0KPiA+IHVuY2FjaGVk
DQo+ID4gSS9PIGFuZCAnbm9hYycgbW91bnRzIHRoZSBkZWZhdWx0Lg0KPiANCj4gSG93IGFyZSBy
ZWFkYWhlYWQsIGFuZCBvdGhlciBjYWNoaW5nIGJyb2tlbj8gSW5kZWVkLCBob3cgYXJlIHRoZXkN
Cj4gZXZlbg0KPiBwcmVkaWN0YWJsZT8gQ2FjaGluZyBpcyBhbG1vc3QgYnkgZGVmaW5pdGlvbiBh
IGJlc3QtZWZmb3J0LsKgIFJlYWQNCj4gcmVxdWVzdHMgbWF5LCBvciBtYXkgbm90LCBiZSBzZXJ2
ZWQgZnJvbSByZWFkLWFoZWFkIGRhdGEuwqAgV3JpdGUNCj4gbWF5YmUNCj4gd3JpdHRlbiBiYWNr
IHNvb25lciBvciBsYXRlci7CoCBWYXJpb3VzIHN5c3RlbS1sb2FkIGZhY3RvcnMgY2FuIGFmZmVj
dA0KPiB0aGlzLsKgwqAgWW91IGNhbiBuZXZlciBwcmVkaWN0IHRoYXQgYSBjYWNoZSAqd2lsbCog
YmUgdXNlZC4NCj4gDQoNCkNhY2hpbmcgbm90IGEgImJlc3QgZWZmb3J0IiBhdHRlbXB0LiBUaGUg
Y2xpZW50IGlzIGV4cGVjdGVkIHRvIHByb3ZpZGUNCmEgcGVyZmVjdCByZXByb2R1Y3Rpb24gb2Yg
dGhlIGRhdGEgc3RvcmVkIG9uIHRoZSBzZXJ2ZXIgaW4gdGhlIGNhc2UNCndoZXJlIHRoZXJlIGlz
IG5vIGNsb3NlLXRvLW9wZW4gdmlvbGF0aW9uLg0KSW4gdGhlIGNhc2Ugd2hlcmUgdGhlcmUgYXJl
IGNsb3NlLXRvLW9wZW4gdmlvbGF0aW9ucyB0aGVuIHRoZXJlIGFyZSB0d28NCmNhc2VzOg0KDQog
ICAxLiBUaGUgdXNlciBjYXJlcywgYW5kIGlzIHVzaW5nIHVuY2FjaGVkIEkvTyB0b2dldGhlciB3
aXRoIGENCiAgICAgIHN5bmNocm9uaXNhdGlvbiBwcm90b2NvbCBpbiBvcmRlciB0byBtaXRpZ2F0
ZSBhbnkgZGF0YSttZXRhZGF0YQ0KICAgICAgZGlzY3JlcGFuY2llcyBiZXR3ZWVuIHRoZSBjbGll
bnQgYW5kIHNlcnZlci4NCiAgIDIuIFRoZSB1c2VyIGRvZXNuJ3QgY2FyZSwgYW5kIHdlJ3JlIGlu
IHRoZSBzdGFuZGFyZCBidWZmZXJlZCBJL08NCiAgICAgIGNhc2UuDQoNCg0KV2h5IGFyZSB5b3Ug
YW5kIEJydWNlIGluc2lzdGluZyB0aGF0IGNhc2UgKDIpIG5lZWRzIHRvIGJlIHRyZWF0ZWQgYXMN
CnNwZWNpYWw/DQoNCj4gInJldmFsaWRhdGUgb24gZXZlcnkgb3BlbiwgZmx1c2ggb24gZXZlcnkg
Y2xvc2UiIChpbiB0aGUgYWJzZW5jZSBvZg0KPiBkZWxlZ2F0aW9ucyBvZiBjb3Vyc2UpIHByb3Zp
ZGVzIGFjY2VzcyB0byB0aGUgb25seSBlbGVtZW50IG9mIGNhY2hlDQo+IGJlaGF2aW91ciB0aGF0
ICpjYW4qIGJlIHByZWRpY3RhYmxlOiB0aGUgdGltZXMgd2hlbiBpdCAqd29udCogYmUNCj4gdXNl
ZC4NCj4gDQoNCk5vLiAuLi5hbmQgdGhlIHZlcnkgZmFjdCB5b3UgaGFkIHRvIHF1YWxpZnkgdGhl
IGFib3ZlIHdpdGggImluIHRoZQ0KYWJzZW5jZSBvZiBkZWxlZ2F0aW9ucyIgcHJvdmVzIG15IHBv
aW50Lg0KDQotLSANClRyb25kIE15a2xlYnVzdCBMaW51eCBORlMgY2xpZW50IG1haW50YWluZXIs
IEhhbW1lcnNwYWNlDQp0cm9uZC5teWtsZWJ1c3RAaGFtbWVyc3BhY2UuY29tDQo=

Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 854D72C9450
	for <lists+linux-nfs@lfdr.de>; Tue,  1 Dec 2020 01:51:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729947AbgLAAup (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 30 Nov 2020 19:50:45 -0500
Received: from mail-bn7nam10on2101.outbound.protection.outlook.com ([40.107.92.101]:40225
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727473AbgLAAup (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Mon, 30 Nov 2020 19:50:45 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OdanYrIz85WRnA6poB2BbeG5Vz30XgNLXzHg2pwOX/wVPuEZDi6PJKdbQy4Y0H63AlHy/sfPj5g+x4JW6HN/BzmbD32DuWbinZGi37e89gVru3dtCVUdpd9t0Z7PnXcZdV5FHL0V6d9it3FQzmdeQlVJXohARXrOqInLe379DGZEPrmJwry7uON7JgRPb2sGxyupMyXRpuH8QaCFO3jrsRIazm7b/ZPemf/14j6/kn+NmpvYgbh1svaVMSSDRd8IK53aC6hyu/MIoZ8uLDbcfqGdT/nUuPcgCONhzoimr/GrgAohviHl+xhBYyHXSfwaKMXI/yuTWT5f4UK9YGzZgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AMizYIg624K/lO40ZR/V3O3Rwo/1T9lnBFAs6+KGsrs=;
 b=Y7RT8akv5g92AukoBRXALehqY1MsIw3ywOPTae89oo1DUZzUxllIySVK6xpNg3sGRs06XGW/vINnWctohNO9I9V7O5hSXt78PE/gPtRr0ZL4eEhghSiNID4jwT4IKs7U9DA8iWOYl3l5IlxeCSYPrnp7oVlQKZR7Tn5lplwjUmD7XzCptUhzjQCVS7W3uJ5asTxTfB0+np3FVMkvlXfkUAkIxg2QmZU9KZeYonCI7lgIMZ8eF7Ui0+0eGFMegnkEaEUCcTp98wXm/eIiOP1MJDb9VbO+Ni8SE2z1holVBEerl7QisrNuc/i0+NkxOUcdne5imy4+ROhnXXYyMgH+fQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AMizYIg624K/lO40ZR/V3O3Rwo/1T9lnBFAs6+KGsrs=;
 b=YLYKMRzTePZvUVxwqtr/ePEdJtFqPZIDLG4uSKUenTjtdou4lpZtOT7PquTbAe2X749DvxJudH624QYwL8jDJwFb2pCr1hvBsUN1UXlivBz74M64D0l3Vr8GYfygpOFfitomjQORTkBUPtYGYxWzx06KJdpa7OP50WqFIlHRMvo=
Received: from MN2PR13MB3957.namprd13.prod.outlook.com (2603:10b6:208:263::11)
 by MN2PR13MB2864.namprd13.prod.outlook.com (2603:10b6:208:f7::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3632.6; Tue, 1 Dec
 2020 00:49:50 +0000
Received: from MN2PR13MB3957.namprd13.prod.outlook.com
 ([fe80::e989:f666:131a:e210]) by MN2PR13MB3957.namprd13.prod.outlook.com
 ([fe80::e989:f666:131a:e210%9]) with mapi id 15.20.3632.016; Tue, 1 Dec 2020
 00:49:50 +0000
From:   Trond Myklebust <trondmy@hammerspace.com>
To:     "chuck.lever@oracle.com" <chuck.lever@oracle.com>
CC:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "bfields@redhat.com" <bfields@redhat.com>
Subject: Re: [PATCH 1/6] nfsd: add a new EXPORT_OP_NOWCC flag to struct
 export_operations
Thread-Topic: [PATCH 1/6] nfsd: add a new EXPORT_OP_NOWCC flag to struct
 export_operations
Thread-Index: AQHWx1999UsH3Pym/kCB2OnbCNS3q6nhTX6AgAAbgIA=
Date:   Tue, 1 Dec 2020 00:49:50 +0000
Message-ID: <a20e7b0ecfc898041cf6049d42a875484cee774b.camel@hammerspace.com>
References: <20201130212455.254469-1-trondmy@kernel.org>
         <20201130212455.254469-2-trondmy@kernel.org>
         <3E4E4CA0-B7AB-4E87-9CD0-64618F1D4CFF@oracle.com>
In-Reply-To: <3E4E4CA0-B7AB-4E87-9CD0-64618F1D4CFF@oracle.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: oracle.com; dkim=none (message not signed)
 header.d=none;oracle.com; dmarc=none action=none header.from=hammerspace.com;
x-originating-ip: [68.36.133.222]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f4b15148-762e-4307-a52c-08d89593027b
x-ms-traffictypediagnostic: MN2PR13MB2864:
x-microsoft-antispam-prvs: <MN2PR13MB2864924560079573625EA5BAB8F40@MN2PR13MB2864.namprd13.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 3vb2FkrTFZCW2+5lZFWkYWcSKw0g1s1slyoS6WNi5V+0Z+QaGNS3EjvBYTdFKRFFH4URrTpsHEBEr8PVfc8SkgADt2D3/Yb9BsffR1huXB2naQMii3xtMoYrHO1DkbWbvdL4qCrFIZAFnyBtG+5G1+8x8JH+hvpEP/AvuOMI041e/xhYCEcNikBAWnkKzDK8wyU+LPhi2Fp8C7yJletncMm+lldfNvYttrlLmEg5qtdPvP2SV+WxHcHB5qHa4oh7Jf3/Ykma2VX7xFMLZdc8BHNvQE8sf//y4cleDjo1p4cG/pAY/94QDay8hTrcSFC9bGmqjNRSMMKc4ioWidlt8XfyrhrMAY3/8GJb9zy5SRMCxDrHTEAzKnAYAGw/fLL9
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR13MB3957.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(39840400004)(396003)(346002)(366004)(376002)(136003)(6506007)(53546011)(26005)(4326008)(66946007)(64756008)(6916009)(316002)(83380400001)(8676002)(8936002)(5660300002)(66476007)(66446008)(66556008)(2616005)(76116006)(91956017)(71200400001)(36756003)(6512007)(478600001)(186003)(86362001)(4001150100001)(6486002)(2906002)(54906003)(476724003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?utf-8?B?amM5NytKMzVQUmtuZU4zVytBcTVyOWtuMExUWDZwVjFGQXdNQmRBL3gvUVds?=
 =?utf-8?B?MlZDdEF4T2pNQ285RE5lSGVXM2tLNGJnVS83dW5MM0o1cHJkNlhFVnlObm5n?=
 =?utf-8?B?bmIvblJycXh2aVBaOERVYjR0b1Avd2NmYnZucmYvTjRKSVo1clE0Z0dzczN5?=
 =?utf-8?B?LzVZZWc3aFhDR1FQemdHQjNnQkZTaUNDZnFBaklmR0NZWkplTVlPZk1pSFlV?=
 =?utf-8?B?d0w3aU5WaktTK1FHLzJuQVFEVVRDT1pUZ3NmTUtKemdvdStJN1RUQkRjUjNr?=
 =?utf-8?B?OHpXZW80aFZZYWN4UmNpWjFUNWpqSE1hcDBFaVAvTnhtZGdBcUQyalZybGU3?=
 =?utf-8?B?eU0zS01PckRjZ0ZCU0JrSGZmU2Z1K2E2NXVDYVljZmdsTlZaczlsMlBYVUF2?=
 =?utf-8?B?dUh2Mjl1QldBZnRvV1VjdVl1Zk1Scmx0RExOTC9ZcFhaeldTOU5razhkVzUx?=
 =?utf-8?B?WmF5WmNYc2ZRN2dyOFUwMWF6dW15Z0hrZTJyNEZ2cUlDcUt1TjQ2UFZHZkNF?=
 =?utf-8?B?OHNOZmlQZExwNXhIWU51VU11WWc1bEZtbUg3M1cwZEFmd3h6cm1BN3FCVHZm?=
 =?utf-8?B?eWpCcEw1ZGZXQ0JUNkMrK1Q2ZVo1d0dORWdmQVk0MWx5dGtBR1hvYmhVajlq?=
 =?utf-8?B?OGNtY1kybC91NFdrZzdxN1IxNm9xWlpyNzFQUDR0eDdWYjBmUlVxZ211dllL?=
 =?utf-8?B?SHNjRFZmYUs0d00rRHR1cDQvbXpERm0xb05id0Z2VXJoL0R4OHJHbElJNjE3?=
 =?utf-8?B?cFA5UFRTQk1HekRBUnBGcGVTNGUwVEdJRlBqQ0JKaWVJcGVKc3czZVQ4Vmt6?=
 =?utf-8?B?bk5tQTZYaGdqUjNXNktzemwydm10bjdVRksyZGxHT2svZlY1cmNrN3ArZzYy?=
 =?utf-8?B?YkNuSFVhSHNRL3dsWk9nK2lTUURXNGQ4Z2pHbGhYbWg4QXJmSkE3OVlEMmdS?=
 =?utf-8?B?R0xRdllGRkpWSFZ2SmlSUks4cUsxVEg4eFNwWFZteUFRRUlJVnBWZWpJbGN5?=
 =?utf-8?B?TWU2YUN3dEhIc3NwME5uRW5Qb2JCdU1FYTc2OFE4V1U0L2QxRVVoOE12dW9J?=
 =?utf-8?B?cURVUlVnR254akJZcy8yeWtkRnJPNDRQNXBIT0ZDanNwclRZN2tjaEc4S2JS?=
 =?utf-8?B?MWZVaEJMM2xwVGdHNjNwSU5SL0dZeFNwMUdKbHhhdVBJT2F6SGdlY0R0ZFM0?=
 =?utf-8?B?UmhaYWJ1QWZUK3dOWTgzRHhRODhFZE5HMlNHSjF3V3V1bk1xOG55Mm9zUVNX?=
 =?utf-8?B?SlA0Z2lXcE5KOFhwcXZRUkd4OGFudXBHV3p2ZXM4TFNlVHM5YlZ4Mk93M1BL?=
 =?utf-8?Q?/eVzdQ7RqOppJWdtSB7O6E5SL8+bc81U6F?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <6D604AF8D66C074BA131F85CCC911E13@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR13MB3957.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f4b15148-762e-4307-a52c-08d89593027b
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Dec 2020 00:49:50.6268
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3IXarrwgwePbhgLc+2IvFBzm0hsv/2ggPImqDRAaH0GGwXxLlI0JLrKCJdNMIlwyCxJvbKJY1lp+OUqb2cgzgg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR13MB2864
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

T24gTW9uLCAyMDIwLTExLTMwIGF0IDE4OjExIC0wNTAwLCBDaHVjayBMZXZlciB3cm90ZToNCj4g
DQo+IA0KPiA+IE9uIE5vdiAzMCwgMjAyMCwgYXQgNDoyNCBQTSwgdHJvbmRteUBrZXJuZWwub3Jn
wqB3cm90ZToNCj4gPiANCj4gPiBGcm9tOiBKZWZmIExheXRvbiA8amVmZi5sYXl0b25AcHJpbWFy
eWRhdGEuY29tPg0KPiA+IA0KPiA+IFdpdGggTkZTdjMgbmZzZCB3aWxsIGFsd2F5cyBhdHRlbXB0
IHRvIHNlbmQgYWxvbmcgV0NDIGRhdGEgdG8gdGhlDQo+ID4gY2xpZW50LiBUaGlzIGdlbmVyYWxs
eSBpbnZvbHZlcyBzYXZpbmcgb2ZmIHRoZSBpbi1jb3JlIGlub2RlDQo+ID4gaW5mb3JtYXRpb24N
Cj4gPiBwcmlvciB0byBkb2luZyB0aGUgb3BlcmF0aW9uIG9uIHRoZSBnaXZlbiBmaWxlaGFuZGxl
LCBhbmQgdGhlbg0KPiA+IGlzc3VpbmcgYQ0KPiA+IHZmc19nZXRhdHRyIHRvIGl0IGFmdGVyIHRo
ZSBvcC4NCj4gPiANCj4gPiBTb21lIGZpbGVzeXN0ZW1zIChwYXJ0aWN1bGFybHkgY2x1c3RlcmVk
IG9yIG5ldHdvcmtlZCBvbmVzKSBoYXZlIGFuDQo+ID4gZXhwZW5zaXZlIC0+Z2V0YXR0ciBpbm9k
ZSBvcGVyYXRpb24uIEF0b21pY2l0aXkgaXMgYWxzbyBvZnRlbg0KPiA+IGRpZmZpY3VsdA0KPiA+
IG9yIGltcG9zc2libGUgdG8gZ3VhcmFudGVlIG9uIHN1Y2ggZmlsZXN5c3RlbXMuIEZvciB0aG9z
ZSwgd2UncmUNCj4gPiBiZXN0DQo+ID4gb2ZmIG5vdCB0cnlpbmcgdG8gcHJvdmlkZSBXQ0MgaW5m
b3JtYXRpb24gdG8gdGhlIGNsaWVudCBhdCBhbGwsIGFuZA0KPiA+IHRvDQo+ID4gc2ltcGx5IGFs
bG93IGl0IHRvIHBvbGwgZm9yIHRoYXQgaW5mb3JtYXRpb24gYXMgbmVlZGVkIHdpdGggYQ0KPiA+
IEdFVEFUVFINCj4gPiBSUEMuDQo+ID4gDQo+ID4gVGhpcyBwYXRjaCBhZGRzIGEgbmV3IGZsYWdz
IGZpZWxkIHRvIHN0cnVjdCBleHBvcnRfb3BlcmF0aW9ucywgYW5kDQo+ID4gZGVmaW5lcyBhIG5l
dyBFWFBPUlRfT1BfTk9XQ0MgZmxhZyB0aGF0IGZpbGVzeXN0ZW1zIGNhbiB1c2UgdG8NCj4gPiBp
bmRpY2F0ZQ0KPiA+IHRoYXQgbmZzZCBzaG91bGQgbm90IGF0dGVtcHQgdG8gcHJvdmlkZSBXQ0Mg
aW5mbyBpbiBORlN2MyByZXBsaWVzLg0KPiA+IEl0DQo+ID4gYWxzbyBhZGRzIGEgYmx1cmIgYWJv
dXQgdGhlIG5ldyBmbGFncyBmaWVsZCBhbmQgZmxhZyB0byB0aGUNCj4gPiBleHBvcnRpbmcNCj4g
PiBkb2N1bWVudGF0aW9uLg0KPiA+IA0KPiA+IFRoZSBzZXJ2ZXIgd2lsbCBhbHNvIG5vdyBza2lw
IGNvbGxlY3RpbmcgdGhpcyBpbmZvcm1hdGlvbiBmb3IgTkZTdjINCj4gPiBhcw0KPiA+IHdlbGws
IHNpbmNlIHRoYXQgaW5mbyBpcyBuZXZlciB1c2VkIHRoZXJlIGFueXdheS4NCj4gPiANCj4gPiBO
b3RlIHRoYXQgdGhpcyBwYXRjaCBkb2VzIG5vdCBhZGQgdGhpcyBmbGFnIHRvIGFueSBmaWxlc3lz
dGVtDQo+ID4gZXhwb3J0X29wZXJhdGlvbnMgc3RydWN0dXJlcy4gVGhpcyB3YXMgb3JpZ2luYWxs
eSBkZXZlbG9wZWQgdG8NCj4gPiBhbGxvdw0KPiA+IHJlZXhwb3J0aW5nIG5mcyB2aWEgbmZzZC4g
VGhhdCBjb2RlIGlzIG5vdCAoYW5kIG1heSBuZXZlciBiZSkNCj4gPiBzdWl0YWJsZQ0KPiA+IGZv
ciBtZXJnaW5nIGludG8gbWFpbmxpbmUuDQo+ID4gDQo+ID4gT3RoZXIgZmlsZXN5c3RlbXMgbWF5
IHdhbnQgdG8gY29uc2lkZXIgZW5hYmxpbmcgdGhpcyBmbGFnIHRvby4gSXQncw0KPiA+IGhhcmQN
Cj4gPiB0byB0ZWxsIGhvd2V2ZXIgd2hpY2ggb25lcyBoYXZlIGV4cG9ydCBvcGVyYXRpb25zIHRv
IGVuYWJsZSBleHBvcnQNCj4gPiB2aWENCj4gPiBrbmZzZCBhbmQgd2hpY2ggb25lcyBtb3N0bHkg
cmVseSBvbiB0aGVtIGZvciBvcGVuLWJ5LWZpbGVoYW5kbGUNCj4gPiBzdXBwb3J0LA0KPiA+IHNv
IEknbSBsZWF2aW5nIHRoYXQgdXAgdG8gdGhlIGluZGl2aWR1YWwgbWFpbnRhaW5lcnMgdG8gZGVj
aWRlLiBJDQo+ID4gYW0NCj4gPiBjYydpbmcgdGhlIHJlbGV2YW50IGxpc3RzIGZvciB0aG9zZSBm
aWxlc3lzdGVtcyB0aGF0IEkgdGhpbmsgbWF5DQo+ID4gd2FudCB0bw0KPiA+IGNvbnNpZGVyIGFk
ZGluZyB0aGlzIHRob3VnaC4NCj4gPiANCj4gPiBDYzogSFBERC1kaXNjdXNzQGxpc3RzLjAxLm9y
Zw0KPiA+IENjOiBjZXBoLWRldmVsQHZnZXIua2VybmVsLm9yZw0KPiA+IENjOiBjbHVzdGVyLWRl
dmVsQHJlZGhhdC5jb20NCj4gPiBDYzogZnVzZS1kZXZlbEBsaXN0cy5zb3VyY2Vmb3JnZS5uZXQN
Cj4gPiBDYzogb2NmczItZGV2ZWxAb3NzLm9yYWNsZS5jb20NCj4gPiBTaWduZWQtb2ZmLWJ5OiBK
ZWZmIExheXRvbiA8amVmZi5sYXl0b25AcHJpbWFyeWRhdGEuY29tPg0KPiA+IFNpZ25lZC1vZmYt
Ynk6IExhbmNlIFNoZWx0b24gPGxhbmNlLnNoZWx0b25AaGFtbWVyc3BhY2UuY29tPg0KPiA+IFNp
Z25lZC1vZmYtYnk6IFRyb25kIE15a2xlYnVzdCA8dHJvbmQubXlrbGVidXN0QGhhbW1lcnNwYWNl
LmNvbT4NCj4gDQo+IFRoZXNlIHNlZW0gdG8gYXBwbHkgZmluZSwgdGhhbmtzIGZvciByZXNlbmRp
bmcuDQo+IA0KPiBJZiB5b3UgcG9zdCBhIHYzIHRvIGFkZHJlc3MgQnJ1Y2UncyBjb21tZW50LCBj
YW4geW91IGFsc28NCj4gYWRkcmVzcyB0aGlzIGNoZWNrcGF0Y2ggbml0Pw0KDQpJJ20gbm90IHNl
ZWluZyBob3cgSSBjYW4gYWRkcmVzcyBCcnVjZSdzIGNvbW1lbnQgYXQgdGhpcyB0aW1lLiBJIGNh
bg0Kc2VuZCB5b3UgYSB2MyB0aGF0IGNoYW5nZXMgdGhlIGNvbW1lbnQgdG8gdGhlICJmYWxsdGhy
b3VnaCIgb2JzY2VuaXR5Lg0KDQo+IA0KPiANCj4gV0FSTklORzogUHJlZmVyICdmYWxsdGhyb3Vn
aDsnIG92ZXIgZmFsbHRocm91Z2ggY29tbWVudA0KPiAjMTU0OiBGSUxFOiBmcy9uZnNkL25mc2Zo
LmM6Mjk5Og0KPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgLyogRmFsbHRocm91Z2gg
Ki8NCj4gDQo+IHRvdGFsOiAwIGVycm9ycywgMSB3YXJuaW5ncywgMTIwIGxpbmVzIGNoZWNrZWQN
Cj4gDQo+IE5PVEU6IEZvciBzb21lIG9mIHRoZSByZXBvcnRlZCBkZWZlY3RzLCBjaGVja3BhdGNo
IG1heSBiZSBhYmxlIHRvDQo+IMKgwqDCoMKgwqAgbWVjaGFuaWNhbGx5IGNvbnZlcnQgdG8gdGhl
IHR5cGljYWwgc3R5bGUgdXNpbmcgLS1maXggb3IgLS1maXgtDQo+IGlucGxhY2UuDQo+IA0KDQot
LSANClRyb25kIE15a2xlYnVzdA0KTGludXggTkZTIGNsaWVudCBtYWludGFpbmVyLCBIYW1tZXJz
cGFjZQ0KdHJvbmQubXlrbGVidXN0QGhhbW1lcnNwYWNlLmNvbQ0KDQoNCg==

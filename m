Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5853C1BD0C3
	for <lists+linux-nfs@lfdr.de>; Wed, 29 Apr 2020 01:56:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726355AbgD1X4V (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 28 Apr 2020 19:56:21 -0400
Received: from mail-mw2nam10on2136.outbound.protection.outlook.com ([40.107.94.136]:29120
        "EHLO NAM10-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726256AbgD1X4V (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Tue, 28 Apr 2020 19:56:21 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=h1C/Mx+Gtv47dnbNmy3oU0xe1wfvOvDcjqLWwcyBLCIs001GARms88HfT3eYpDUq7/X4r+1stZJV62cAcyWvuVvJk9rRHbGzLpWbq+jVUbAdiA8V6qHrq6VM5OqQ6xNhzaiYbgB4gnIfmakq8GjpOHyzit7qqF0MGHkIcFXWTN5q/yoTFPsbx+/peh5/kyL8zJMjNgPbrQUi48/n3qNXi/bYL3PlRcaKi4yoAZz9BvbF5ZJYReLkvkmDgdNTnuOEY9T+BOIYtirq/YdQ7Wh0mcjW4/2FnBvEb6BJ7L4wLVOqpCSu4VejA6N48h0bOXvNi6kB6SsJEVghXKpr4+gX+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J/MT2YtbouDwfv1ZE9zv8aMfTD7NY7orCirVSpUJE9M=;
 b=bpfNvC6MQirM8gkXpi1DD9gO4Egv075+sA1iAYo9EArxhcAckbKrrrFCIFVdZC19fY5br8AuHD57FPlZuCeOcutesReG8aYuC1GHG5rWXJh6i3UXihrK5H8xZRTyJocOVOhkzhy3Cnmq/CzPBdG0mRl12BkJJhrU+iiN74zKA1RfeHqFmI63Ob7kQVBfZJVz6PqpDBFFsu3XN0kHmLqEHVqJvueed0RmjM8vFce38i1y5zgKgtmbxKekznRMHh7Oa2F1od9Maa0nc1PviHMhtJ2g+CPq6M+Pd7NrPHbk0Fr/14elHa2qIg3PHRo3RySYL0tc9fCTsuR4ajm8Waavcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J/MT2YtbouDwfv1ZE9zv8aMfTD7NY7orCirVSpUJE9M=;
 b=Gu/Ylr7JgYduJYaV0yPL+o6ekgudCRksJg3IG16EQuyDYAduTLtL9z17NVLBxZQQD4c+K+35gcKgPoDEisAvsjJtlpXTwVfeXF2XV9CWlTAzuOVmi0cj0BaGfGcwl+lfX6NypVA4jI9ORFyGisZYqA3sN8s67e3Yl6W53HliJ4s=
Received: from CH2PR13MB3398.namprd13.prod.outlook.com (2603:10b6:610:2a::33)
 by CH2PR13MB3654.namprd13.prod.outlook.com (2603:10b6:610:94::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2958.14; Tue, 28 Apr
 2020 23:56:16 +0000
Received: from CH2PR13MB3398.namprd13.prod.outlook.com
 ([fe80::49f6:ce9b:9803:2493]) by CH2PR13MB3398.namprd13.prod.outlook.com
 ([fe80::49f6:ce9b:9803:2493%6]) with mapi id 15.20.2958.014; Tue, 28 Apr 2020
 23:56:16 +0000
From:   Trond Myklebust <trondmy@hammerspace.com>
To:     "aglo@umich.edu" <aglo@umich.edu>
CC:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
Subject: Re: handling ERR_SERVERFAULT on RESTOREFH
Thread-Topic: handling ERR_SERVERFAULT on RESTOREFH
Thread-Index: AQHWHYjzjBZLlmadoEGcRGdAsbmgTaiO38OAgAAfvACAAA5TAIAAGV4AgAAK7wCAAAQAgA==
Date:   Tue, 28 Apr 2020 23:56:16 +0000
Message-ID: <8549f1fc955faedc35d810a4ad3e21904379a59a.camel@hammerspace.com>
References: <CAN-5tyE6JTeK7RFA7AkcO63p6iFE2v1+x2RFwRrTB1Jb1Yr76Q@mail.gmail.com>
         <98410608e028cb4b53024c7669e0fb70fea98214.camel@hammerspace.com>
         <CAN-5tyGDC9ittxr7d4wL_fKLQu9NLdZWwB19iEPsCn+Y0_sqVg@mail.gmail.com>
         <98a10c8775e4127419ac57630f839744bdf1063d.camel@hammerspace.com>
         <CAN-5tyGfCXVTz4dq3Qj2eXww8BNB_dT=0QwWteEGM93MZBJudw@mail.gmail.com>
         <b96e65b7aeb72e466d2a0170d4347652b6ab0ec5.camel@hammerspace.com>
In-Reply-To: <b96e65b7aeb72e466d2a0170d4347652b6ab0ec5.camel@hammerspace.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: umich.edu; dkim=none (message not signed)
 header.d=none;umich.edu; dmarc=none action=none header.from=hammerspace.com;
x-originating-ip: [68.36.133.222]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8133e0e7-1321-4a2d-15f1-08d7ebcfbd98
x-ms-traffictypediagnostic: CH2PR13MB3654:
x-microsoft-antispam-prvs: <CH2PR13MB36541D87F9B1BAF519E69BEDB8AC0@CH2PR13MB3654.namprd13.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 0387D64A71
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: eVT6seY5Z5udQjM7R4XDvhB2KGs2tln5BpwwWR2hba3AxIZ4z74bKeWpwwcgaGv4QvRVneYlwqBTQ01SlTr8w4BWFwjuM26KrYgbLROyIzJ2CQ44VLwR1ckcn5hsV9q5gYAbH+U5Ft9keu1CvtePQDihYc9KJA1iAOdPBEWsPKip3vZXBrFmcXMC0aJadfNf9kTItfDtVIDIiV5U/pjiR1yvBwlHlIRTwabjhan6sUddaaO02g9/P3bTTjnLSol5xXhHB2XB1nGzkYHtfUOWPhstqOh0oJNb9EagTid4PwoqdLbKI7SOG2elxBGK02xAalSpjywemD+JUZecTAUN/2iSmkJ9GJDTHU2V5RoxnbveMC3EAC8Fh87MoAreoK+JhFKH0Yvj4nFgGiBzI4rNcZSp7xE0JZuFoZ91msb/bNvfNm5qK9azVpwVbfFe8AvN
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR13MB3398.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(346002)(366004)(136003)(376002)(396003)(39830400003)(91956017)(86362001)(71200400001)(76116006)(6512007)(4326008)(478600001)(2906002)(36756003)(6916009)(6486002)(8676002)(8936002)(5660300002)(66946007)(66446008)(6506007)(66556008)(64756008)(66476007)(186003)(26005)(2616005)(53546011)(316002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: pSyZvM3RgQbepeZKE7ud2fM4/LTsqOKKFHc9ValEqCnSQme1eFGXz/G3qs908XrevwNgpyhHdbXPpgCQb5CCKjdKbItoVupFbfpw0I4/mHbX6el8KVnUwd9ToYc73YSvP7v8UOBppStW8FtkerjnmE70cBTrj+aHQOrozTQVLvNHRmeFfxmY/U2jfLwvBGVopv+u9MARR42LvHhsPB+uji9/gA+HNBU5MbwJHHjWQmNviAQvmDfRBlTsO8lZo9GLwJr5DaZz1SjsK8F9XmclcEOwIRtDG3chOCOxJqIq9JQKitYkMxS/hD5SFGkZq9lnhLTO9HWn+/nAsn5a83aXzFbILGzBOh0+DoICmUz3aCP+nvcWEFI7Lo6v4HNS9iWe7G7qxdHrlqL9FmzdDT5ZqGj3sHfifb7ul6nlTrb7D6JP3I0fF3VRrzqFsFtmEve4rTy/Gqk4va8GPRFJjz+U+TDd0InHnIgWMEduEZcZt10YCEdgzzVaTCQLKK6v+GfLFyCC1BdLJj8N8TndwJ/TNre81SgFzdv2AIepBfla/AL8+850V3l+DBtdssm9PB/QoCwqjSjMVTXFRId/yAzE3CVgpW/57FR2Bxq1EzQZGp6z6ICIZgQupjstUV/O/5JrqDJTtEiDObnktcTW+M2+0mHntdd0x5Y8DCnBOT/+tMesriIDBgUT3XB91KbE8qQcSAMYxmJTR+Zu9tRaz7WL3MXmq62a2FSm+PRld+GBAe9eR+f/03CWrPaT2tOJZ/nwuuTv/1nOKGCJnoR/G04kuxQN53SD/ubpG/GtRaPkFcY=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <F1F2977F18DF4C4EBA9103A83524D60A@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8133e0e7-1321-4a2d-15f1-08d7ebcfbd98
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Apr 2020 23:56:16.6953
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9lye8q26Ipn/7uRzeU8QzaZyXusUfuwFn6Uq7avJnFB+GfXOkYnccv56WB9AQWR9QkrClbMxrh2fjLX0E6i0FA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR13MB3654
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

T24gVHVlLCAyMDIwLTA0LTI4IGF0IDE5OjQxIC0wNDAwLCBUcm9uZCBNeWtsZWJ1c3Qgd3JvdGU6
DQo+IE9uIFR1ZSwgMjAyMC0wNC0yOCBhdCAxOTowMiAtMDQwMCwgT2xnYSBLb3JuaWV2c2thaWEg
d3JvdGU6DQo+ID4gT24gVHVlLCBBcHIgMjgsIDIwMjAgYXQgNTozMiBQTSBUcm9uZCBNeWtsZWJ1
c3QgPA0KPiA+IHRyb25kbXlAaGFtbWVyc3BhY2UuY29tPiB3cm90ZToNCj4gPiA+IE9uIFR1ZSwg
MjAyMC0wNC0yOCBhdCAxNjo0MCAtMDQwMCwgT2xnYSBLb3JuaWV2c2thaWEgd3JvdGU6DQo+ID4g
PiA+IE9uIFR1ZSwgQXByIDI4LCAyMDIwIGF0IDI6NDcgUE0gVHJvbmQgTXlrbGVidXN0IDwNCj4g
PiA+ID4gdHJvbmRteUBoYW1tZXJzcGFjZS5jb20+IHdyb3RlOg0KPiA+ID4gPiA+IEhpIE9sZ2Es
DQo+ID4gPiA+ID4gDQo+ID4gPiA+ID4gT24gVHVlLCAyMDIwLTA0LTI4IGF0IDE0OjE0IC0wNDAw
LCBPbGdhIEtvcm5pZXZza2FpYSB3cm90ZToNCj4gPiA+ID4gPiA+IEhpIGZvbGssDQo+ID4gPiA+
ID4gPiANCj4gPiA+ID4gPiA+IExvb2tpbmcgZm9yIGd1aWRhbmNlIG9uIHdoYXQgZm9sa3MgdGhp
bmsuIEEgY2xpZW50IGlzDQo+ID4gPiA+ID4gPiBzZW5kaW5nDQo+ID4gPiA+ID4gPiBhDQo+ID4g
PiA+ID4gPiBMSU5LDQo+ID4gPiA+ID4gPiBvcGVyYXRpb24gdG8gdGhlIHNlcnZlci4gVGhpcyBj
b21wb3VuZCBhZnRlciB0aGUgTElOSyBoYXMNCj4gPiA+ID4gPiA+IFJFU1RPUkVGSA0KPiA+ID4g
PiA+ID4gYW5kIEdFVEFUVFIuIFNlcnZlciByZXR1cm5zIFNFUlZFUl9GQVVMVCB0byBvbiBSRVNU
T1JFRkguDQo+ID4gPiA+ID4gPiBCdXQNCj4gPiA+ID4gPiA+IExJTksgaXMNCj4gPiA+ID4gPiA+
IGRvbmUgc3VjY2Vzc2Z1bGx5LiBDbGllbnQgc3RpbGwgZmFpbHMgdGhlIHN5c3RlbSBjYWxsIHdp
dGgNCj4gPiA+ID4gPiA+IEVJTy4NCj4gPiA+ID4gPiA+IFdlDQo+ID4gPiA+ID4gPiBoYXZlIGEg
aGFyZGxpbmUgYW5kICJsbiIgc2F5aW5nIGhhcmRsaW5rIGZhaWxlZC4NCj4gPiA+ID4gPiA+IA0K
PiA+ID4gPiA+ID4gU2hvdWxkIHRoZSBjbGllbnQgbm90IGZhaWwgdGhlIHN5c3RlbSBjYWxsIGlu
IHRoaXMgY2FzZT8NCj4gPiA+ID4gPiA+IFRoZQ0KPiA+ID4gPiA+ID4gZmFjdA0KPiA+ID4gPiA+
ID4gdGhhdA0KPiA+ID4gPiA+ID4gd2UgY291bGRuJ3QgZ2V0IHVwLXRvLWRhdGUgYXR0cmlidXRl
cyBkb24ndCBzZWVtIGxpa2UgdGhlDQo+ID4gPiA+ID4gPiByZWFzb24NCj4gPiA+ID4gPiA+IHRv
DQo+ID4gPiA+ID4gPiBmYWlsIHRoZSBzeXN0ZW0gY2FsbD8NCj4gPiA+ID4gPiA+IA0KPiA+ID4g
PiA+ID4gVGhhbmsgeW91Lg0KPiA+ID4gPiA+IA0KPiA+ID4gPiA+IEkgZG9uJ3QgcmVhbGx5IHNl
ZSB0aGlzIGFzIHdvcnRoIGZpeGluZyBvbiB0aGUgY2xpZW50LiBJdCBpcw0KPiA+ID4gPiA+IHZl
cnkNCj4gPiA+ID4gPiBjbGVhcmx5IGEgc2VydmVyIGJ1Zy4NCj4gPiA+ID4gDQo+ID4gPiA+IFdo
eSBpcyB0aGF0IGEgc2VydmVyIGJ1Zz8gQSBzZXJ2ZXIgY2FuIGxlZ2l0aW1hdGVseSBoYXZlIGFu
DQo+ID4gPiA+IGlzc3VlDQo+ID4gPiA+IHRyeWluZyB0byBleGVjdXRlIGFuIG9wZXJhdGlvbiAo
UkVTVE9SRUZIKSBhbmQgbGVnaXRpbWF0ZWx5DQo+ID4gPiA+IHJldHVybmluZw0KPiA+ID4gPiBh
biBlcnJvci4NCj4gPiA+IA0KPiA+ID4gSWYgaXQgaXMgaGFwcGVuaW5nIGNvbnNpc3RlbnRseSBv
biB0aGUgc2VydmVyLCB0aGVuIGl0IGlzIGEgYnVnLA0KPiA+ID4gYW5kIGl0DQo+ID4gPiBnZXRz
IHJlcG9ydGVkIGJ5IHRoZSBjbGllbnQgaW4gdGhlIHNhbWUgd2F5IHdlIGFsd2F5cyByZXBvcnQN
Cj4gPiA+IE5GUzRFUlJfU0VSVkVSRkFVTFQsIGJ5IGNvbnZlcnRpbmcgdG8gYW4gRVJFTU9URUlP
Lg0KPiA+IA0KPiA+IFllcyBidXQgdGhlIGNsaWVudCBkb2Vzbid0IHJldHJ5IHNvIGl0IGNhbid0
IGFzc2VzcyBpZiBpdCdzDQo+ID4gY29uc2lzdGVudGx5IGhhcHBlbmluZyBvciBub3QuIEl0IGNh
biBiZSBhIHRyYW5zaWVudCBlcnJvciAob3INCj4gPiBFTk9NRU0pDQo+ID4gdGhhdCdzIGxhdGVy
IHJlc29sdmVkLg0KPiANCj4gSWYgdGhlIHNlcnZlciB3YW50cyB0byBzaWduYWwgYSB0cmFuc2ll
bnQgZXJyb3IsIGl0IHNob3VsZCBzZW5kDQo+IE5GUzRFUlJfREVMQVkuDQo+IA0KPiA+ID4gPiBO
RlMgY2xpZW50IGFsc28gaWdub3JlcyBlcnJvcnMgb2YgdGhlIHJldHVybmluZyBHRVRBVFRSIGFm
dGVyDQo+ID4gPiA+IHRoZQ0KPiA+ID4gPiBSRVNUT1JFRkguIFNvIEknbSBub3Qgc3VyZSB3aHkg
d2UgYXJlIHRoZW4gbm90IGlnbm9yaW5nIGVycm9ycw0KPiA+ID4gPiAob3INCj4gPiA+ID4gc29t
ZSBlcnJvcnMpIG9mIHRoZSBSRVNUT1JFRkguDQo+ID4gPiANCj4gPiA+IFdlIGRvIG5lZWQgdG8g
Y2hlY2sgdGhlIHZhbHVlIG9mIFJFU1RPUkVGSCBpbiBvcmRlciB0byBmaWd1cmUgb3V0DQo+ID4g
PiBpZiB3ZQ0KPiA+ID4gY2FuIGNvbnRpbnVlIHJlYWRpbmcgdGhlIFhEUiBidWZmZXIgdG8gZGVj
b2RlIHRoZSBmaWxlDQo+ID4gPiBhdHRyaWJ1dGVzLg0KPiA+ID4gV2UNCj4gPiA+IHdhbnQgdG8g
cmVhZCB0aG9zZSBmaWxlIGF0dHJpYnV0ZXMgYmVjYXVzZSB3ZSBkbyBleHBlY3QgdGhlDQo+ID4g
PiBjaGFuZ2UNCj4gPiA+IGF0dHJpYnV0ZSwgdGhlIGN0aW1lIGFuZCB0aGUgbmxpbmtzIHZhbHVl
cyB0byBhbGwgY2hhbmdlIGFzIGENCj4gPiA+IHJlc3VsdCBvZg0KPiA+ID4gdGhlIG9wZXJhdGlv
bi4NCj4gPiANCj4gPiBJIGhhdmUgbm90aGluZyBhZ2FpbnN0IGRlY29kaW5nIHRoZSBlcnJvciBh
bmQgdXNpbmcgaXQgaW4gYQ0KPiA+IGRlY2lzaW9uDQo+ID4gdG8ga2VlcCBkZWNvZGluZy4gQnV0
IHRoZSBjbGllbnQgZG9lc24ndCBoYXZlIHRvIHByb3BhZ2F0ZSB0aGUNCj4gPiBSRVNUT1JFRkgg
ZXJyb3IgdG8gdGhlIGFwcGxpY2F0aW9uPw0KPiA+IA0KPiA+IEluIGFsbCBvdGhlciBub24taWRl
bXBvdGVudCBvcGVyYXRpb25zIHRoYXQgaGF2ZSBvdGhlciBvcGVyYXRpb25zDQo+ID4gKGllDQo+
ID4gR0VUQVRUUikgZm9sbG93aW5nIHRoZW0sIHRoZSBjbGllbnQgaWdub3JlcyB0aGUgZXJyb3Jz
LiBCdHcgSSBqdXN0DQo+ID4gbm90aWNlZCB0aGF0IG9uIE9QRU4gY29tcG91bmQsIHNpbmNlIHdl
IGlnbm9yZSBkZWNvZGUgZXJyb3IgZnJvbQ0KPiA+IHRoZQ0KPiA+IEdFVEFUVFIsIGl0IHdvdWxk
IGNvbnRpbnVlIGRlY29kaW5nIExBWU9VVEdFVC4uLg0KPiA+IA0KPiA+IENSRUFURSBoYXMgcHJv
YmxlbSBpZiB0aGUgZm9sbG93aW5nIEdFVEZIIHdpbGwgcmV0dXJuIEVERUxBWS4NCj4gPiBDbGll
bnQNCj4gPiBkb2Vzbid0IGRlYWwgd2l0aCByZXRyeWluZyBhIHBhcnQgb2YgdGhlIGNvbXBvdW5k
LiBJdCByZXRyaWVzIHRoZQ0KPiA+IHdob2xlIGNvbXBvdW5kLiBJdCBsZWFkcyB0byBhbiBlcnJv
ciAoc2luY2Ugbm9uLWlkZW1wb3RlbnQNCj4gPiBvcGVyYXRpb24NCj4gPiBpcyByZXRyaWVkKS4g
QnV0IEkgZ3Vlc3MgdGhhdCdzIGEgMm5kIGlzc3VlIChvciBhIDNyZCBpZiB3ZSBjb3VsZA0KPiA+
IHRoZQ0KPiA+IGRlY29kaW5nIGxheW91dGdldCkuLi4uDQo+ID4gDQo+ID4gQWxsIHRoaXMgaXMg
dW5kZXIgdGhlIHVtYnJlbGxhIG9mIGhvdyB0byBoYW5kbGUgZXJyb3JzIG9uDQo+ID4gbm9uLWlk
ZW1wb3RlbnQgb3BlcmF0aW9ucyBpbiBhIGNvbXBvdW5kLi4uLg0KPiANCj4gVGhlcmUgaXMgbm8g
cG9pbnQgaW4gdHJ5aW5nIHRvIGhhbmRsZSBlcnJvcnMgdGhhdCBtYWtlIG5vIHNlbnNlLiBJZg0K
PiB0aGUNCj4gc2VydmVyIGhhcyBhIGJ1ZywgdGhlbiBsZXQncyBleHBvc2UgaXQgaW5zdGVhZCBv
ZiB0cnlpbmcgdG8gaGlkZSBpdA0KPiBpbg0KPiB0aGUgc29mYSBjdXNoaW9ucy4NCg0KSXQgYmFz
aWNhbGx5IGJvaWxzIGRvd24gdG8gdGhpczoNCiAqIEkgZG8gbm90IHdhbnQgdG8gaGF2ZSB0byBt
YWludGFpbiBhIGxpc3Qgb2Ygc2VydmVyIGJ1Z3MgaW4gdGhlDQogICBjbGllbnQuDQogKiBJZiBJ
IG1ha2UgYSBjbGllbnQgY2hhbmdlLCBJIGRvbid0IHdhbnQgdG8gaGF2ZSB0byBjb25zaWRlciB3
aGV0aGVyDQogICBvciBub3QgaXQgY2F1c2VzIGEgcmVncmVzc2lvbiBhZ2FpbnN0IHNvbWUgc2Vy
dmVyIHRoYXQgb25seSAxMA0KICAgcGVvcGxlIGFyZSBzdGlsbCB1c2luZywgYW5kIHRoYXQgbmV2
ZXIgZ290IGEgZml4IGZvciBhIGJ1ZyBiZWNhdXNlDQogICAidGhlIGNsaWVudHMgaGFuZGxlIGl0
Ii4NCg0KV2Ugc2hvdWxkIGZpeCBjbGllbnQgYnVncyB3aGVuIGl0IGlzIGNsZWFyIHRoYXQgdGhl
eSBhcmUgY2xpZW50IGJ1Z3MuDQpXZSBzaG91bGQgcHVzaCBiYWNrIGhhcmQgb24gc2VydmVyIGJ1
Z3MgYmVjYXVzZSB0aGUgY2xpZW50IGlzIGFscmVhZHkgYQ0KY29tcGxleCBlbm91Z2ggYmVhc3Qu
DQoNCi0tIA0KVHJvbmQgTXlrbGVidXN0DQpMaW51eCBORlMgY2xpZW50IG1haW50YWluZXIsIEhh
bW1lcnNwYWNlDQp0cm9uZC5teWtsZWJ1c3RAaGFtbWVyc3BhY2UuY29tDQoNCg0K

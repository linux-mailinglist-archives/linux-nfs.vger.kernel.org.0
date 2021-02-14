Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C0F4131B198
	for <lists+linux-nfs@lfdr.de>; Sun, 14 Feb 2021 18:42:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229793AbhBNRl6 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sun, 14 Feb 2021 12:41:58 -0500
Received: from mail-mw2nam12on2112.outbound.protection.outlook.com ([40.107.244.112]:24544
        "EHLO NAM12-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229730AbhBNRl4 (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Sun, 14 Feb 2021 12:41:56 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Q6JNhsERoJvf48IIvEMFq9s5Z1gvJAagQ7obclFTwDsu93jcUobZCH9wP+lxGT87A8Fr+InadPMz6kdECpB0+bwR4EGhyN6zzj8xq7hm5HMBwF47OOq0rbfnK9G8dKtUQeZU1ZtvQTecK2JCuHaZslsBeDoWs2TpoRVBLJmkynfwoaxjd4/wci0FHJV5daiYZh/DuEqkcss5Kw2Qp1JSWiAmi60oQYMmtkqFfvlRlGUCqan2KK+SqtUHq013uA5FulQ01Zhl3jTvSvC+mC9jU+YjHUWyT7HPCfq4i0vos+uACZIPoGgElYVtZF4/8Be18ekdeiK/oODjoDcXYMzgRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bvIrmtIgMw4Rs81xdzaIPKWIF5J2TL5LJfVxNKU39QQ=;
 b=Y7UpGCPKAL+v39MK9jU3pdKEVnwlIBjDZHlj6DcXXHsPdBQA2FMITl8IkotMZlyjHOWvv4K7/f7lk0RFkazlbRrs9UEzTvTHC1N9mJcZlacf9Ux4ESWKkzaOUdJVt7Xwd9rzrRoXh3cWOMPMXx8bCTlPGdFhZWCBLznxhVbWyCCLXb/x6UFZAZK8iVV6TPy13h98+/JHlVk3iCEvAWEdncVJiKy55SD7mTaJ28JQZNId4H8skA4hYk1Zkr3YkRpWSNxZevExpxoQnUimHu+RK3h6k0uxcDY3QmrmSihPu6Sh9kwTxn0SdQzH/STjQTQtaff9CDLZKJAnc3WZHG1/jw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bvIrmtIgMw4Rs81xdzaIPKWIF5J2TL5LJfVxNKU39QQ=;
 b=BhJfJ0g0Td6cY54YLz/jB0StStwuMFePVqPE3vq29pfGtfZqtDRRvtCS351kaHVl9WoOIp8sDhGzyCENeyet6A1Ijw6j5FNtUvq6htxzXRwIeRdF2jfWCRZ0bg14on2/0BoNkyzXlcXpjWXVektBbMVDXW4p7VV3O9z5EipFVXI=
Received: from CH2PR13MB3525.namprd13.prod.outlook.com (2603:10b6:610:21::29)
 by CH2PR13MB4444.namprd13.prod.outlook.com (2603:10b6:610:67::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3868.11; Sun, 14 Feb
 2021 17:41:02 +0000
Received: from CH2PR13MB3525.namprd13.prod.outlook.com
 ([fe80::f453:2dd2:675:d063]) by CH2PR13MB3525.namprd13.prod.outlook.com
 ([fe80::f453:2dd2:675:d063%3]) with mapi id 15.20.3868.019; Sun, 14 Feb 2021
 17:41:02 +0000
From:   Trond Myklebust <trondmy@hammerspace.com>
To:     "chuck.lever@oracle.com" <chuck.lever@oracle.com>
CC:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "bfields@redhat.com" <bfields@redhat.com>
Subject: Re: [PATCH] SUNRPC: Use TCP_CORK to optimise send performance on the
 server
Thread-Topic: [PATCH] SUNRPC: Use TCP_CORK to optimise send performance on the
 server
Thread-Index: AQHXAkaKHQ4x2Pj5G0O0h0qlFPlIMKpWoMuAgAAErYCAABZIAIABGpiAgAAShICAAAOxAA==
Date:   Sun, 14 Feb 2021 17:41:02 +0000
Message-ID: <6f49449343dc7ee4efda1c9d9cc56d272c984502.camel@hammerspace.com>
References: <20210213202532.23146-1-trondmy@kernel.org>
         <952C605B-C072-4C6B-B9C0-88C25A3B891E@oracle.com>
         <f025fa709f923255b9cb8e76a9b5ad4cca9355c4.camel@hammerspace.com>
         <4CD2739A-D39B-48C9-BCCF-A9DF1047D507@oracle.com>
         <8ce015080f2f4eb57a81e10041947ad7e6f31499.camel@hammerspace.com>
         <C3A48B63-63AF-4308-A499-15665AB2FF9C@oracle.com>
In-Reply-To: <C3A48B63-63AF-4308-A499-15665AB2FF9C@oracle.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: oracle.com; dkim=none (message not signed)
 header.d=none;oracle.com; dmarc=none action=none header.from=hammerspace.com;
x-originating-ip: [68.36.133.222]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 16748314-c019-4958-8a4e-08d8d10fb2b1
x-ms-traffictypediagnostic: CH2PR13MB4444:
x-microsoft-antispam-prvs: <CH2PR13MB44447A5871840BF6FA41D10AB8899@CH2PR13MB4444.namprd13.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 77p1L1E24zkiIwfA3sfXfMNCou5vL8nvjhJix1cO5cedyw5vDhjMNvCv49GuUTzpSs+puTwG5kswjmOd+yRXtKWcsLaeqob8MrrD7p7JdtWv/83juZiYu+mhwD8chOdCNNBmv2k3EM7oJU/NEEeWLyzvEOAv4Wq1WkLxGJgY4JM1Ez/mnIMdpCDOFNmxoXBlK3MB3fnFnvq2NAVPXy3EC+XYNGIz6iML/1t5QCvHiG0p2CoRUYA2Jj7BAjkKxhyYIeRILGV87owMtc8r9isfHpohhltYjI/s6a6/d2on1EwnlHtxnOBJkTQQVMY0IniqLXoXu9/FvAwec9STA6BaT0ocU7cFFrAARB8LaRQV0GozwpINoby5JK0/t85ZNhfIIKmaKHPl3G4bbA3XMa4PqJx5AZpF398+IHZilcJNrW7jTZQwYydoGGnO5DQVAZDdKtB2fa8hh9OAwVwPn2cKRjdO7KxZEJMvEz0FgvtVfwqDU5nGe0ZfUvKZHoOgQWcL3JMuJ1aebOmuBZh8XpCYOg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR13MB3525.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(396003)(366004)(376002)(39830400003)(136003)(86362001)(64756008)(6916009)(66446008)(36756003)(76116006)(83380400001)(66556008)(478600001)(66476007)(66946007)(8936002)(2906002)(186003)(26005)(53546011)(6506007)(316002)(5660300002)(54906003)(6512007)(4326008)(6486002)(8676002)(71200400001)(2616005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?utf-8?B?d3RFTDdxSjdxN0FxVUpYejNtdnNzMWlQR1g5bENtbTBEZnZmZVp4MEhGOHc2?=
 =?utf-8?B?VmZ1cXNhUmpBYldvVnRzekNkMERCdGtTNmhCTzliUVJWelJnRytRN1ZveGFV?=
 =?utf-8?B?UWswY2w2RWVSNkJzUlBxT0hzUWxvTWZsOFJPRm1zVEdlMTU0VGtoYm1QUERm?=
 =?utf-8?B?bEdKejRtTnRRQ1BvRGVsb1laTVlKbjluNzdWQVBoUHhCdmViL0o0NExiWFlq?=
 =?utf-8?B?YXlxdFJZeVpQS041YjZSSU5UTkg4bDhtRlFtSG0xcmZaanhmS2taT01PR3li?=
 =?utf-8?B?Wmk3QitKL05SOU13KzNNTGRqWWxUSzNSQ0NtT0l0UXMzRnQ3ZW51TGdpUHVC?=
 =?utf-8?B?bVVJTXlLY2RCbUhwUkNCckM4YUxVKzRMVTRpVDB0L2tKdGRBc1hjZXpPTER5?=
 =?utf-8?B?alZVV2N4NWZ4QWZRS0dpU2Q2SlQxa0h1aEpIdHljNFpUUHFMUjlNczFRNjJa?=
 =?utf-8?B?L1grajNKQURYZ1daa3ZHTGJFZVgwamY4ZWRRa1hqSHQrTFZyWVFEZGpEWXNv?=
 =?utf-8?B?eWM0YXJLQ1R4a2NaVEdyOVhRUitDYXJwTi9zQXc0MVVaVERrWHBFUG1hYW9L?=
 =?utf-8?B?SnRhR1EwTGdkOXkyQk5MUnFKWFEwa2lYMXVPQ0tTT2RJaGY0NGh4cDNoeVBP?=
 =?utf-8?B?d2RDZ2pQTTkrN2w4eEErSDNXbEtGZFU0bzBDNGprQ3pjOCsyRXlpNmFZcE8w?=
 =?utf-8?B?Yi9ENkg4TG5CYkRqM2RYTDZRMDJIOWdORC9JRlZ5bUluNmVrdWQ3RE96Visv?=
 =?utf-8?B?WjNkemhhbXlSaE5NUW9yTE5lSVNHL3pTa2NJUmtHMmNQUnZXUnZmVUJDWm5w?=
 =?utf-8?B?NjIyaGs5aXdxdTRzSWFmMHhnamFBSUVlaWlHTUlneXg4dFJuNFQ4TUxLV3pX?=
 =?utf-8?B?UGtGQ3ZSaC8vMEdYbVc3a3dWUVpCU3Zpb2wvOC9ENVpVZU0zVmhvcFlFQjRh?=
 =?utf-8?B?VitObzBUbUFpcGVTS2wwU0tsQ1NMdWVrSElnaGlDRVRhcXp6TXp3WXNOcFJl?=
 =?utf-8?B?K3IvQVFEWk9ieGxHb0lpSERCVDVpcDVZc2YweUV0N0NURk95dW1tcWVCZnBJ?=
 =?utf-8?B?eTNQalg1UDJBbGhKQlc3Ykc1dzl3ZnJzZGVKaWMwV1VDMzJQNXJaL0l0eTZh?=
 =?utf-8?B?aGlacG9lcG81K3k5YjNNTUlHNWRZZ2ZJREx2WHpZUngrMkZoemFrYWdabmND?=
 =?utf-8?B?dTFxdkdaLzRDMTg4bUp0K0wydXVsWmxOLytLaDFZUnN6SmZ1Z3hpZkJEWWo5?=
 =?utf-8?B?ZnFuQW10cktxcEpoS3J5RVI4VFQrR1dVMFlLLzdFMm11YXI1cERBclAvS0dl?=
 =?utf-8?B?b3c0MG9ScGxPcjNCeXFYY3lqREtDaWhzSzFMbCsveFVhSmxOZXlHUUx2Tkhu?=
 =?utf-8?B?MHUwUGI3NTJTMU9TTFZEcEZsYjhDTWVyRXFOQ3hMWnNlZTBYQ0I3c2xjaWlB?=
 =?utf-8?B?dVVTMjQ2OE9YK0dGNnB6Rzh4QkxSWDR1WFFubTQ0SHg0VTFBTWQ2ZUNZdkN1?=
 =?utf-8?B?YkR2cHUzdkJjdVhnZ0o2N0tNaDdDUVd4VFUybURiZXRmamFiYytvSnJsV0dP?=
 =?utf-8?B?TThuVitDNVh4YXZBMUNxZFZ3S2hEUW5tajVVUjAveHJrOFN3eHFKRDNtb0F1?=
 =?utf-8?B?aXZhSjZSMEdUTFRCNExscU1EMElYWVVhbFB6cFdpZkNGYWwybzdRV25PYm0z?=
 =?utf-8?B?djB3MXEvRXB5VWxlMmRpSnBERG1zcVhkMGorWFpEQm9PbzhpRk1xZ0FMeGgz?=
 =?utf-8?Q?mtmj5qJsT3vWp9KJRu/eRyzrWiuuOpxI9s2bziS?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <BF145EB89FF43A4B9D4EA6CACF1C91D2@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH2PR13MB3525.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 16748314-c019-4958-8a4e-08d8d10fb2b1
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Feb 2021 17:41:02.4869
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jmcNKbl3MeHpgWrdRky21K2hFO92IImcT2GtahhIa3HJ2a7A3PZL5642DQjti9gwxUJ/JnI8eB/RoS+J+R+Vcw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR13MB4444
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

T24gU3VuLCAyMDIxLTAyLTE0IGF0IDE3OjI3ICswMDAwLCBDaHVjayBMZXZlciB3cm90ZToNCj4g
DQo+IA0KPiA+IE9uIEZlYiAxNCwgMjAyMSwgYXQgMTE6MjEgQU0sIFRyb25kIE15a2xlYnVzdA0K
PiA+IDx0cm9uZG15QGhhbW1lcnNwYWNlLmNvbT4gd3JvdGU6DQo+ID4gDQo+ID4gT24gU2F0LCAy
MDIxLTAyLTEzIGF0IDIzOjMwICswMDAwLCBDaHVjayBMZXZlciB3cm90ZToNCj4gPiA+IA0KPiA+
ID4gDQo+ID4gPiA+IE9uIEZlYiAxMywgMjAyMSwgYXQgNToxMCBQTSwgVHJvbmQgTXlrbGVidXN0
IDwNCj4gPiA+ID4gdHJvbmRteUBoYW1tZXJzcGFjZS5jb20+IHdyb3RlOg0KPiA+ID4gPiANCj4g
PiA+ID4gT24gU2F0LCAyMDIxLTAyLTEzIGF0IDIxOjUzICswMDAwLCBDaHVjayBMZXZlciB3cm90
ZToNCj4gPiA+ID4gPiBIaSBUcm9uZC0NCj4gPiA+ID4gPiANCj4gPiA+ID4gPiA+IE9uIEZlYiAx
MywgMjAyMSwgYXQgMzoyNSBQTSwgdHJvbmRteUBrZXJuZWwub3JnwqB3cm90ZToNCj4gPiA+ID4g
PiA+IA0KPiA+ID4gPiA+ID4gRnJvbTogVHJvbmQgTXlrbGVidXN0IDx0cm9uZC5teWtsZWJ1c3RA
aGFtbWVyc3BhY2UuY29tPg0KPiA+ID4gPiA+ID4gDQo+ID4gPiA+ID4gPiBVc2UgYSBjb3VudGVy
IHRvIGtlZXAgdHJhY2sgb2YgaG93IG1hbnkgcmVxdWVzdHMgYXJlIHF1ZXVlZA0KPiA+ID4gPiA+
ID4gYmVoaW5kDQo+ID4gPiA+ID4gPiB0aGUNCj4gPiA+ID4gPiA+IHhwcnQtPnhwdF9tdXRleCwg
YW5kIGtlZXAgVENQX0NPUksgc2V0IHVudGlsIHRoZSBxdWV1ZSBpcw0KPiA+ID4gPiA+ID4gZW1w
dHkuDQo+ID4gPiA+ID4gDQo+ID4gPiA+ID4gSSdtIGludHJpZ3VlZCwgYnV0IElNTywgdGhlIHBh
dGNoIGRlc2NyaXB0aW9uIG5lZWRzIHRvDQo+ID4gPiA+ID4gZXhwbGFpbg0KPiA+ID4gPiA+IHdo
eSB0aGlzIGNoYW5nZSBzaG91bGQgYmUgbWFkZS4gV2h5IGFiYW5kb24gTmFnbGU/DQo+ID4gPiA+
ID4gDQo+ID4gPiA+IA0KPiA+ID4gPiBUaGlzIGRvZXNuJ3QgY2hhbmdlIHRoZSBOYWdsZS9UQ1Bf
Tk9ERUxBWSBzZXR0aW5ncy4gSXQganVzdA0KPiA+ID4gPiBzd2l0Y2hlcyB0bw0KPiA+ID4gPiB1
c2luZyB0aGUgbmV3IGRvY3VtZW50ZWQga2VybmVsIGludGVyZmFjZS4NCj4gPiA+ID4gDQo+ID4g
PiA+IFRoZSBvbmx5IGNoYW5nZSBpcyB0byB1c2UgVENQX0NPUksgc28gdGhhdCB3ZSBkb24ndCBz
ZW5kIG91dA0KPiA+ID4gPiBwYXJ0aWFsbHkNCj4gPiA+ID4gZmlsbGVkIFRDUCBmcmFtZXMsIHdo
ZW4gd2UgY2FuIHNlZSB0aGF0IHRoZXJlIGFyZSBvdGhlciBSUEMNCj4gPiA+ID4gcmVwbGllcw0K
PiA+ID4gPiB0aGF0IGFyZSBxdWV1ZWQgdXAgZm9yIHRyYW5zbWlzc2lvbi4NCj4gPiA+ID4gDQo+
ID4gPiA+IE5vdGUgdGhlIGNvbWJpbmF0aW9uIFRDUF9DT1JLK1RDUF9OT0RFTEFZIGlzIGNvbW1v
biwgYW5kIHRoZQ0KPiA+ID4gPiBtYWluDQo+ID4gPiA+IGVmZmVjdCBvZiB0aGUgbGF0dGVyIGlz
IHRoYXQgd2hlbiB3ZSB0dXJuIG9mZiB0aGUgVENQX0NPUkssDQo+ID4gPiA+IHRoZW4NCj4gPiA+
ID4gdGhlcmUNCj4gPiA+ID4gaXMgYW4gaW1tZWRpYXRlIGZvcmNlZCBwdXNoIG9mIHRoZSBUQ1Ag
cXVldWUuDQo+ID4gPiANCj4gPiA+IFRoZSBkZXNjcmlwdGlvbiBhYm92ZSBzdWdnZXN0cyB0aGUg
cGF0Y2ggaXMganVzdCBhDQo+ID4gPiBjbGVhbi11cCwgYnV0IGEgZm9yY2VkIHB1c2ggaGFzIHBv
dGVudGlhbCB0byBjaGFuZ2UNCj4gPiA+IHRoZSBzZXJ2ZXIncyBiZWhhdmlvci4NCj4gPiANCj4g
PiBXZWxsLCB5ZXMuIFRoYXQncyB2ZXJ5IG11Y2ggdGhlIHBvaW50Lg0KPiA+IA0KPiA+IFJpZ2h0
IG5vdywgdGhlIFRDUF9OT0RFTEFZL05hZ2xlIHNldHRpbmcgbWVhbnMgdGhhdCB3ZSdyZSBkb2lu
Zw0KPiA+IHRoYXQNCj4gPiBmb3JjZWQgcHVzaCBhdCB0aGUgZW5kIG9mIF9ldmVyeV8gUlBDIHJl
cGx5LCB3aGV0aGVyIG9yIG5vdCB0aGVyZQ0KPiA+IGlzDQo+ID4gbW9yZSBzdHVmZiB0aGF0IGNh
biBiZSBxdWV1ZWQgdXAgaW4gdGhlIHNvY2tldC4gVGhlIE1TR19NT1JFIGlzIHRoZQ0KPiA+IG9u
bHkgdGhpbmcgdGhhdCBrZWVwcyB1cyBmcm9tIGRvaW5nIHRoZSBmb3JjZWQgcHVzaCBvbiBldmVy
eQ0KPiA+IHNlbmRwYWdlKCkNCj4gPiBjYWxsLg0KPiA+IFNvIHRoZSBUQ1BfQ09SSyBpcyB0aGVy
ZSB0byBfZnVydGhlciBkZWxheV8gdGhhdCBmb3JjZWQgcHVzaCB1bnRpbA0KPiA+IHdlDQo+ID4g
dGhpbmsgdGhlIHF1ZXVlIGlzIGVtcHR5Lg0KPiANCj4gTXkgY29uY2VybiBpcyB0aGF0IHdhaXRp
bmcgZm9yIHRoZSBxdWV1ZSB0byBlbXB0eSBiZWZvcmUgcHVzaGluZw0KPiBjb3VsZA0KPiBpbXBy
b3ZlIHRocm91Z2hwdXQgYXQgdGhlIGNvc3Qgb2YgaW5jcmVhc2VkIGF2ZXJhZ2Ugcm91bmQtdHJp
cA0KPiBsYXRlbmN5Lg0KPiBUaGF0IGNvbmNlcm4gaXMgYmFzZWQgb24gZXhwZXJpZW5jZSBJJ3Zl
IGhhZCBhdHRlbXB0aW5nIHRvIGJhdGNoDQo+IHNlbmRzDQo+IGluIHRoZSBSRE1BIHRyYW5zcG9y
dC4NCj4gDQo+IA0KPiA+IElPVzogaXQgYXR0ZW1wdHMgdG8gb3B0aW1pc2UgdGhlIHNjaGVkdWxp
bmcgb2YgdGhhdCBwdXNoIHVudGlsDQo+ID4gd2UncmUNCj4gPiBhY3R1YWxseSBkb25lIHB1c2hp
bmcgbW9yZSBzdHVmZiBpbnRvIHRoZSBzb2NrZXQuDQo+IA0KPiBZZXAsIGNsZWFyLCB0aGFua3Mu
IEl0IHdvdWxkIGhlbHAgYSBsb3QgaWYgdGhlIGFib3ZlIHdlcmUgaW5jbHVkZWQgaW4NCj4gdGhl
IHBhdGNoIGRlc2NyaXB0aW9uLg0KPiANCj4gQW5kLCBJIHByZXN1bWUgdGhhdCB0aGUgVENQIGxh
eWVyIHdpbGwgcHVzaCBhbnl3YXkgaWYgaXQgbmVlZHMgdG8NCj4gcmVjbGFpbSByZXNvdXJjZXMg
dG8gaGFuZGxlIG1vcmUgcXVldWVkIHNlbmRzLg0KPiANCj4gTGV0J3MgYWxzbyBjb25zaWRlciBz
dGFydmF0aW9uOyBpZSwgdGhhdCB0aGUgc2VydmVyIHdpbGwgY29udGludWUNCj4gcXVldWluZyBy
ZXBsaWVzIHN1Y2ggdGhhdCBpdCBuZXZlciB1bmNvcmtzLiBUaGUgbG9naWMgaW4gdGhlIHBhdGNo
DQo+IGFwcGVhcnMgdG8gZGVwZW5kIG9uIHRoZSBjbGllbnQgc3RvcHBpbmcgYXQgc29tZSBwb2lu
dCB0byB3YWl0IGZvcg0KPiB0aGUNCj4gc2VydmVyIHRvIGNhdGNoIHVwLiBUaGVyZSBwcm9iYWJs
eSBzaG91bGQgYmUgYSB0cmFwIGRvb3IgdGhhdCB1bmNvcmtzDQo+IGFmdGVyIGEgZmV3IHJlcXVl
c3RzIChzYXksIDgpIG9yIGNlcnRhaW4gbnVtYmVyIG9mIGJ5dGVzIGFyZSBwZW5kaW5nDQo+IHdp
dGhvdXQgYSBicmVhay4NCg0KU28sIGZpcnN0bHksIHRoZSBUQ1AgbGF5ZXIgd2lsbCBzdGlsbCBw
dXNoIGV2ZXJ5IHRpbWUgYSBmcmFtZSBpcyBmdWxsLA0Kc28gdHJhZmZpYyBkb2VzIG5vdCBzdG9w
IGFsdG9nZXRoZXIgd2hpbGUgVENQX0NPUksgaXMgc2V0LiBTZWNvbmRseSwNClRDUCB3aWxsIGFs
c28gYWx3YXlzIHB1c2ggb24gc2VuZCBlcnJvcnMgKGUuZy4gd2hlbiBvdXQgb2YgZnJlZSBzb2Nr
ZXQNCmJ1ZmZlcikuIFRoaXJkbHksIGl0IHdpbGwgYWx3YXlzIHB1c2ggYWZ0ZXIgaGl0dGluZyB0
aGUgMjAwbXMgY2VpbGluZywNCmFzIGRlc2NyaWJlZCBpbiB0aGUgdGNwKDcpIG1hbnBhZ2UuDQoN
CklPVzogVGhlIFRDUF9DT1JLIGZlYXR1cmUgaXMgbm90IGRlc2lnbmVkIHRvIGJsb2NrIHRoZSBz
b2NrZXQgZm9yZXZlci4NCkl0IGlzIHRoZXJlIHRvIGFsbG93IHRoZSBhcHBsaWNhdGlvbiB0byBo
aW50IHRvIHRoZSBUQ1AgbGF5ZXIgd2hhdCBpdA0KbmVlZHMgdG8gZG8gaW4gZXhhY3RseSB0aGUg
c2FtZSB3YXkgdGhhdCBNU0dfTU9SRSBkb2VzLg0KDQotLSANClRyb25kIE15a2xlYnVzdA0KTGlu
dXggTkZTIGNsaWVudCBtYWludGFpbmVyLCBIYW1tZXJzcGFjZQ0KdHJvbmQubXlrbGVidXN0QGhh
bW1lcnNwYWNlLmNvbQ0KDQoNCg==

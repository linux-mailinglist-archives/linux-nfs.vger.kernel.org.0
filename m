Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5627E2FF592
	for <lists+linux-nfs@lfdr.de>; Thu, 21 Jan 2021 21:13:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726067AbhAUUM0 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 21 Jan 2021 15:12:26 -0500
Received: from mail-eopbgr680092.outbound.protection.outlook.com ([40.107.68.92]:37933
        "EHLO NAM04-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726058AbhAUUMT (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Thu, 21 Jan 2021 15:12:19 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jtsQEIBWiKbsX3zHBbGGBB3caovFeMA99sQTYhDoW60JipsN6rR1/KMTP1Ulxp/TfqLlGK5BsQ5l6E6FBrZ0JrHP7OJw1mUYZBqvbEHAYakjCNO3stCJqkPZJ8lgd7DbiM5OvwTJoeDDT2DYMETWKjNaPKAPcQMwrVJ5V8C6YufTLuC56Unhj4OAjB3Sqcdb8FyWM1aCnyaoobIox9yvFVDuyzdBtb8wsG1nXMEJknhVuojMsOwi9cnaVxu2LoI4IuuyIcHhU4O7stRqC7gm8BHgjylJJuibdeQ83Bd+uQd1Kr02Cyy/TrytrCFJfL6BrgOHnTWLt5ha80x/JPuLaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3/iFRYz5BfAL4grQ+2JzCFbkRrf1mwPXd+Fey6WtbiY=;
 b=VZNjivu4UcUqBvMyYWw2T6GmX09KTGBIrcawfXbOmrc+yTKYtpeHDFfYNca6pwGKaIPRFekANVGJlGUB3OCTekppCTFi1yN5jhPrrQrysLESaTfMozi37iMvs1Wtic28DsxeuqrKD/lGa0ucho2IReMH9Z4hkQTwJiofI3enI6TAPUEXA0Si50iim1hRYqgXzcLnEBoSI6NIRc3TokHqYoQIh+vJYmsVl6NPAYqpEPSmHe4Sx5fyPDboROXso0TKbcgyM76wcXPjvvC8DiwKYSmqVfNPVnOEjHoPUGZG8+XBEhBk8iJjQbM1GQrWQysgEeZgJVhciYW61T0SZ4hnLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3/iFRYz5BfAL4grQ+2JzCFbkRrf1mwPXd+Fey6WtbiY=;
 b=NJE5R63V0Ghl0PLGTl9ZW/TfQlweD6JGnbm9Kz04jJF+ow+ZOeU5Kh+mWwvCqsxJD52KRNqGGAYfx5LMX6C/EfHI5BvzW9guNnOz/p5bRrJZeYb/bhmgdoCtTLgJMoyA4bi9o0UWGLDDArWD12pftqGInsrBisJvLSV0ODDVyAw=
Received: from (2603:10b6:610:21::29) by
 CH2PR13MB4459.namprd13.prod.outlook.com (2603:10b6:610:35::16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3784.9; Thu, 21 Jan 2021 20:11:28 +0000
Received: from CH2PR13MB3525.namprd13.prod.outlook.com
 ([fe80::f453:2dd2:675:d063]) by CH2PR13MB3525.namprd13.prod.outlook.com
 ([fe80::f453:2dd2:675:d063%3]) with mapi id 15.20.3805.006; Thu, 21 Jan 2021
 20:11:28 +0000
From:   Trond Myklebust <trondmy@hammerspace.com>
To:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "bcodding@redhat.com" <bcodding@redhat.com>
Subject: Re: [PATCH v1 04/10] NFS: Keep the readdir pagecache cursor updated
Thread-Topic: [PATCH v1 04/10] NFS: Keep the readdir pagecache cursor updated
Thread-Index: AQHW706uPXeu1qrbdUiJKwuBPKUG1aoygaAAgAAC8oA=
Date:   Thu, 21 Jan 2021 20:11:27 +0000
Message-ID: <187eb82fa8acad68141d026811945a56cc14b35d.camel@hammerspace.com>
References: <cover.1611160120.git.bcodding@redhat.com>
         <f803021382040dba38ce8414ed1db8e400c0cc49.1611160121.git.bcodding@redhat.com>
         <76fd114e0f4018cf7e00f565759e10acd1f0ba92.camel@hammerspace.com>
In-Reply-To: <76fd114e0f4018cf7e00f565759e10acd1f0ba92.camel@hammerspace.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none
 header.from=hammerspace.com;
x-originating-ip: [50.124.244.174]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f4be7dd0-d7b1-421b-ee9c-08d8be48bc68
x-ms-traffictypediagnostic: CH2PR13MB4459:
x-microsoft-antispam-prvs: <CH2PR13MB44593AEAAF4B5AA2E62AB88FB8A19@CH2PR13MB4459.namprd13.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: tkbZneQ+OvhEKlOh8y4A6ylbEpv9kRvkaGLBQbMYIZGQu2y750KXOEErBq9fjpAqv71rF/SeIMq4V0pv3QVv218D9rUSnhJZyWS17ctr7SwQAVFlHq3S7JFmuiFBDAanzFdcs5cNFiDtZjYqvh/8DE4lDxqg8KafB/+P75TueBlPbCycRfSIKralhS4VcmV7ihdgYhn+/ImSG645pznuprfBYdHeTOwn95Zthp0fV+g7ZjErdFcDBSNCdl2iwDhoyXhekFmHz+fUXbpcU4sLwZqFzNS419EEJPDiwDWorBhD8BvnJMPBBFIdfTfx4nPLcIBFsYs0ftnaGFR0c4E+Jxa2W0ZMcuMzRkjwqrnAJl6CJwLNMdnUdTvvRebIrtBuj1N5zv9LQc4tDThR7sjP5kdtcxYCiQwZf8HtQCH28ffaf8UGZsUBnr3xS/q8Zmx3tQr+JmWzUPnGEPhUjgz4xBTQgsgY2qYI++nx5xIDTUUqD9r8m2P05lVwUWFX4Tx0TCGCuJUl9uycXtKH3Y8lQQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR13MB3525.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(39840400004)(396003)(376002)(366004)(136003)(71200400001)(2616005)(4744005)(86362001)(8936002)(15650500001)(6512007)(2906002)(6486002)(8676002)(26005)(6506007)(478600001)(66556008)(316002)(186003)(64756008)(66446008)(83380400001)(76116006)(36756003)(66476007)(110136005)(5660300002)(66946007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?utf-8?B?dDgvRHRDeWx2bkZiTDVGQ0NVTllBVGY0Q3c2b3FxdTMwMkt0ZUlFTEtlcXFJ?=
 =?utf-8?B?UG8yVjlxWWdPcFcyVGJveG5zeE5JaXA0U085TGhwelpSYXgzL1BFNHIwWkZt?=
 =?utf-8?B?TmVCSkRJNnVCcDMwYzMwcmt0c2FkanV5c1JpaHJQNFExVTE2cHZ3Ti91c3ND?=
 =?utf-8?B?MzRCUldlVGZ0anFnSk96WGtyRHBEV2VXanA4a1QrNzZGRlJHNFBlSnQ1UzBK?=
 =?utf-8?B?Uk42d0FCYkNjVzUyL3hKeTQveFhMb3ZyQi8rT1ArMm9Qc2dwa1VGUEZTQmVv?=
 =?utf-8?B?QlNYazJZYng5MTk2OGdBY2E3T2UvL0R6OUxWaGRJalo4VTdGTHZLK0JnUHhC?=
 =?utf-8?B?RkhNdnVCQUlGUEc3cXlTR0tGc0FlQXJHMk91WkY1V1R5aHFkenhyS3JFZGZI?=
 =?utf-8?B?TlI3bGhFWjA0TldDUmRwMTl5YVJoZ2JXbFNpSGZWYmxJS2tNSW9IdFF4RFdn?=
 =?utf-8?B?bDFNZm1UVlBpSWVWb3NoRDBDSVZXOTV3WEh3eGlaNi9CcGVHRWxPV0dTbkZo?=
 =?utf-8?B?STgwZnRHcVRhV05TbSs4NU9iWlM1M3JGbHlDUFJLSnAxdk91TG8zS2Z5TEgv?=
 =?utf-8?B?YzFudnFQRG1LQkhNS2cyYUJ2ZStmd3JjL1l1MElVSWRIcXRGNklvSGNsSkFT?=
 =?utf-8?B?U2RCUHF3WnM2dXY2RVJCSmZYV1V2bHZEYytvSmx6bzRzRXhKcEI0bEUyME5y?=
 =?utf-8?B?c0dGaWIweGdNVEkwZWI4Nm9XeldoVmo4UXRNN0pXZnJsU21kUWoralVDVEJJ?=
 =?utf-8?B?bmtJdU82T2FZbzdDQ3N4SWpzME95TzVGMkxqcUZ0enhxWWRJaTZ6SmZOSFlw?=
 =?utf-8?B?aDlRZWhnOXdhTkQxT0gwNzNYTFNaOEZQZ1IxblI0N0RLTi92Tlk0TkkzM1Vn?=
 =?utf-8?B?bVk2TStQZzdmQW4vd1ZTYVl4V1lIaDRVcFNsaVc2RGVzZDdSVVdIL1hueDhV?=
 =?utf-8?B?eFFkYXJsaGRZQllIQit1M2k3WXl4dWRGQVpRUkp1RE53N242REhvZkNMMGlF?=
 =?utf-8?B?d25HOXhLaUQyME5pVTlDYmM2QnJuMUJKVlZVZ1MvWDNOTitHQy9CUllCQVdq?=
 =?utf-8?B?dW5ZaVpvVzF1Vlk1RXlpTGlheDRSUWFQamlUS3BSeXNaMTltMkN4RGN2TUpP?=
 =?utf-8?B?Snh3UEtTRTdzWkRjZVgwdzNrNjNQc1NhRUo0SWNGc1lsUkNRZ2d2SFJjK2Ir?=
 =?utf-8?B?ZnYrbkRIV2ZjV1FNRjBFQ3FsdkFjN0U2UkhuNDc1N3c2OXp3eGdVMjBSWFM2?=
 =?utf-8?B?cmtRUzBIUW44MHZQZTlTdDIvcC9mKzRqQ0dDNlJZYm5ML0R2Tmh0TmNnalI4?=
 =?utf-8?Q?txrWIvPB0EOuB5u6BA6YYupkgFm6PGEFAE?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <EDE452DAF26A9446904676D5F4316F42@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH2PR13MB3525.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f4be7dd0-d7b1-421b-ee9c-08d8be48bc68
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jan 2021 20:11:27.9602
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JfbDeN0exKEcWwapcpZrvW8Fa+oKQFJZECWdsmN1Iv39kGlcqB+PJWJRCKYM7hoPLTTPgdsaud/rW9rT4doznA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR13MB4459
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

T24gVGh1LCAyMDIxLTAxLTIxIGF0IDIwOjAwICswMDAwLCBUcm9uZCBNeWtsZWJ1c3Qgd3JvdGU6
DQo+IE9uIFdlZCwgMjAyMS0wMS0yMCBhdCAxMTo1OSAtMDUwMCwgQmVuamFtaW4gQ29kZGluZ3Rv
biB3cm90ZToNCj4gPiBXaGVuZXZlciB3ZSBzdWNjZXNzZnVsbHkgbG9jYXRlIG91ciBkaXJfY29v
a2llIHdpdGhpbiB0aGUNCj4gPiBwYWdlY2FjaGUsDQo+ID4gb3INCj4gPiBmaW5pc2ggZW1pdHRp
bmcgZW50cmllcyB0byB1c2Vyc3BhY2UsIHVwZGF0ZSB0aGUgcGFnZWNhY2hlIGN1cnNvci7CoA0K
PiA+IFRoZXNlDQo+ID4gdXBkYXRlcyBwcm92aWRlIG1hcmtlciBwb2ludHMgdG8gdmFsaWRhdGUg
cGFnZWNhY2hlIHBhZ2VzIGluIGENCj4gPiBmdXR1cmUNCj4gPiBwYXRjaC4NCj4gDQo+IEhvdyBp
c24ndCB0aGlzIGdvaW5nIHRvIGVuZCB1cCBzdWJqZWN0IHRvIHRoZSBleGFjdCBzYW1lIHByb2Js
ZW0gdGhhdA0KPiBEYXZlIFd5c29jaGFuc2tpJ3MgcGF0Y2hzZXQgaGFkPw0KDQpJT1c6IGhvdyBp
cyB0aGlzIG5vdCBhbHNvIG1ha2luZyBpbnZhbGlkIGFzc3VtcHRpb25zIGFyb3VuZCBwYWdlIGNh
Y2hlDQpsYXlvdXQgc3RhYmlsaXR5IGFjcm9zcyBSRUFERElSIGNhbGxzPw0KDQotLSANClRyb25k
IE15a2xlYnVzdA0KTGludXggTkZTIGNsaWVudCBtYWludGFpbmVyLCBIYW1tZXJzcGFjZQ0KdHJv
bmQubXlrbGVidXN0QGhhbW1lcnNwYWNlLmNvbQ0KDQoNCg==

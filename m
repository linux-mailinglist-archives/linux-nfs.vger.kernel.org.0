Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C9AD13A05F7
	for <lists+linux-nfs@lfdr.de>; Tue,  8 Jun 2021 23:26:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232640AbhFHV23 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 8 Jun 2021 17:28:29 -0400
Received: from mail-dm6nam08on2125.outbound.protection.outlook.com ([40.107.102.125]:16448
        "EHLO NAM04-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231830AbhFHV22 (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Tue, 8 Jun 2021 17:28:28 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hASl6w9U8BEPk//LQlExqhZ9grlWadw0fUSRwIAonuwoIsH5Y4Cbpm40IVqnNpMYGBLcX1ygYvyQU7SSIAa0eqZh05VXFP9ITkyHEKiippFPa2oAvdw8EFwEPOr4yAZrmq8N9uSjwPWv7jSWX5Lou/jwyHvYNWw/MTRyzPs720BNIXdvxbRQRSYHTaF6x5t/hDq6yMbMPqwJvv2ES1ChvgnUwvN3bvjIl9dFlxS90vqZZ4sMXi0WL30Jq2JwZ5Y2czBySTI9kAbMXtMBS+FdN6pycf73mH1ZpC4u4CKmylRcE+XC8DwmD+SdIsup9eDt2JHHIr0xXVsbMsSOVWrNDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LQbkZiNbzb09ZztxbHaMXIhqYtrA0zGkJy7SwAJCYh8=;
 b=n1bVXdh3IXZ6W7dpMq6hVjcePNvuo1Gpi+uGgTk6FzdYEJfgXeJTd3V1U2GbDsLL9eDy2+O6lNqO8/F6DZAkAmsc11JlSZfw4exfadIzq3HPqutrgBv4UNnZSKMV485snsBq+668irzqwfD77g/oteUWgDHvbD1e/6vjb1AxsGf8tAeFjqW9Iv8OgrxvtvCPRGiAutZiYrr2q97mz5Nxwbsx0hYWXfNWpx8doujGGF5iRvkt40RilLPJaQjmShJjczqrOzeOgdtgl0nM4k9mq4ko2p4mXoKZ30TQDr3NKCMH9qKwx53k0sJAdfQ8mubSISgZ9nHHoG8FKnwtx6xlvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LQbkZiNbzb09ZztxbHaMXIhqYtrA0zGkJy7SwAJCYh8=;
 b=ZB41jh9Uq2+1FseKsFc7xoqssGx+0zWmBOJyAkt5jYbndzvYnHmX/iwrd5bpHpp9GWEJAsEsuzjdO+mYVcynhZcT14K4xrdL7yCHGOjNu3sp9FJU6ErKLUiCANrQ8bxQm3LI9XaTtAj2SvLY+ujBZjRXH1PlxMMQFlxuxQOC414=
Received: from DS7PR13MB4733.namprd13.prod.outlook.com (2603:10b6:5:3b1::24)
 by DM6PR13MB3867.namprd13.prod.outlook.com (2603:10b6:5:245::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.15; Tue, 8 Jun
 2021 21:26:33 +0000
Received: from DS7PR13MB4733.namprd13.prod.outlook.com
 ([fe80::4c65:55ca:a5a2:f18]) by DS7PR13MB4733.namprd13.prod.outlook.com
 ([fe80::4c65:55ca:a5a2:f18%7]) with mapi id 15.20.4219.021; Tue, 8 Jun 2021
 21:26:33 +0000
From:   Trond Myklebust <trondmy@hammerspace.com>
To:     "olga.kornievskaia@gmail.com" <olga.kornievskaia@gmail.com>,
        "chuck.lever@oracle.com" <chuck.lever@oracle.com>
CC:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "anna.schumaker@netapp.com" <anna.schumaker@netapp.com>
Subject: Re: [PATCH 1/1] NFSv4.1+ add trunking when server trunking detected
Thread-Topic: [PATCH 1/1] NFSv4.1+ add trunking when server trunking detected
Thread-Index: AQHXXJZ2q4Fg/jBv8EW7vOhaPbIm9asKlDaAgAAEKoCAAALKAIAAA5OAgAAB/QA=
Date:   Tue, 8 Jun 2021 21:26:33 +0000
Message-ID: <1753b60c2cc23e6e650357fbf710ef4450310d76.camel@hammerspace.com>
References: <20210608184527.87018-1-olga.kornievskaia@gmail.com>
         <C9C7FA2C-1913-4332-91EA-B51F8E104728@oracle.com>
         <CAN-5tyFYyxYr4joR6uPR7zoFToYMmntNdkUkNWV=g33OVXFuOw@mail.gmail.com>
         <29835A59-A523-49FD-8D28-06CDC2F0E94C@oracle.com>
         <da738bdd35859aba7bdbed30da10df4e2d4087d2.camel@hammerspace.com>
In-Reply-To: <da738bdd35859aba7bdbed30da10df4e2d4087d2.camel@hammerspace.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=hammerspace.com;
x-originating-ip: [68.36.133.222]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1797e1d2-cacb-41b1-4579-08d92ac41711
x-ms-traffictypediagnostic: DM6PR13MB3867:
x-microsoft-antispam-prvs: <DM6PR13MB38673802DC6DF2216A5A35BFB8379@DM6PR13MB3867.namprd13.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 6aaAO9+vCbmYrTMgWIrJrCa/GLtrq4AlN7zP9toOjamJd5jzdgZ4blsEJFzHB5baHrmMCP3Woz9iO7mwt9RtEO1n0nERkpVbQ9Hfqywfraor8YVfhb6xMSMbAGpN6EtzB9okyV8AOywpetvuS3uWrl7NQ5WTKrQ0EcVKicy9jhfD6kUcn3dl0nHLdVpqbCURWnWDCX427X197BZldSMEuQTeDh/zau114MoLTT8k3gQKSTmN5Wydf8EOXMReCIcc8s/hy8K/BnG7WbBxCR/dH8cMi/n4erJCgzD3veNxP9997xGZYoS3oVgAmtdVj0kGd62A8qUaeXiAwGh/wK/KDvCace8dVg1S9pyEP3V1thncVSayfm78j2WlMPts0s7GyxWCZhusxaEbVyVQmKkPikoNmyKmfyBFAvb3FDC13Wtmt92HtW3eulvxRyVgv0Z8sloq9HJ7GEBV5Xz/InuOoESnro8Azt0+WMWmURyyWfX2VS97Mn24Ra6eCYBC+ZTpdv5IL1QOLYAIa07110C7ud5i80dsN3Z3EstrE1SlEw3YSUtMM3ayu7EO/iMzR7xqaZgCv2J+Nipdw7S3U2O6X2ggFd2QthV9WCOM91VLTjE=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR13MB4733.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(376002)(136003)(346002)(366004)(396003)(39830400003)(4326008)(6512007)(54906003)(71200400001)(66476007)(8676002)(8936002)(66556008)(91956017)(66446008)(83380400001)(76116006)(64756008)(6486002)(86362001)(5660300002)(110136005)(2906002)(26005)(2616005)(66946007)(122000001)(478600001)(6506007)(53546011)(186003)(36756003)(316002)(38100700002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dlBVbTV3OXJGSnQ2UlpxZXI2eDJEdVZSSWZ6SDdnbXdPdmwwM3dQbkdzc2g2?=
 =?utf-8?B?cldWWTVCaUtxSmJEQjJqcVRxS0MxK1MwRzVJWWJKd1hpODgxaVJnK09ydUdI?=
 =?utf-8?B?bDBLeFQ2bmdmeGtZNE5CNDRTS2FuM1JYWlBEYSs0c0VqSHRmdUtWVlFIc1Zk?=
 =?utf-8?B?TUl4ZjNyd3V1SWNYYkVNS2ZjTk1MaUNzVllYTjRUeldGbjVuVEY1cTRTQjNQ?=
 =?utf-8?B?WUF5TlJDUnB4T1MvUmVrdDRlTEVNaklRZmtBcmdoZ0hFLzAzV1pnZUhhdDNw?=
 =?utf-8?B?eVplN3E4cjFIQkdFU2tGSVZ6a2d1L3RJcERCTDFvdXIvckhIMDBBZnkwRVpK?=
 =?utf-8?B?aG56aE5PTmN5UTR3Nk1hNzliN2I3aVNuejgvb3BRUnY2bE95N2ZmSVhMTk5D?=
 =?utf-8?B?QUtRazR5c0VBZlN5QmdUek9mOW8rdWJYQVdJanlIWjNXMjhOeGsrQmZJS2VS?=
 =?utf-8?B?eHVXellZQXJEM0IxeU9XcDk4NnYza04xcDZScGxHOVYweEw4OCthOUt4V0lI?=
 =?utf-8?B?eWNQTjEwVWNOUFJLTm01VWpWN25Xd3pzMlhZL0JqUXdyQSs5bDZLeEZVYmE0?=
 =?utf-8?B?NStialRTcWh2dFlPWG1XcW5ibCtvMGlsNWlSWFAwNkYyWGJaWmVoR1ZjZkp4?=
 =?utf-8?B?Y1RYbEpCZGN5OUJEMTN5VDJBUWZQMjBnNi9lRkY3SnNzRUlXWWQ2MlozOUx2?=
 =?utf-8?B?K2FST3I4bG56TnlmWm4zUjZXSmNFVzU3d0crL0RxbDBaRW9EZGZtWWh6Y2NW?=
 =?utf-8?B?eEJ6Q3BNdmUwWGFJVWJPb0lyN29LN245YnFGVEVCUExXRVN6Z0EvRkN1RmtV?=
 =?utf-8?B?Mm96OSt2ZWEwY1p0OTVFei9aZWs3SlBYVGl6NGs1WEJINlJBZ1R4WWFHb0du?=
 =?utf-8?B?cGtpQ0dtODNoeUcxbi9XUEhqakFFT2lMUEpIdmhUU0pGR2t2Wm1XSEtqTHUv?=
 =?utf-8?B?cFh6Nkk4MithSzcwekk1RkcvdkRvNnBXSlkrdWRVbkExeVhwdk4yKzNzTTZm?=
 =?utf-8?B?STVSamJhRDVBSHh3V3U1WDZFVVk5WklmVGNEUXJZZmpheE9WS284Yi9qTjg1?=
 =?utf-8?B?Mzg1UGhFWE1iWWNhdzdpbVY0MEhkUEdTcUZxNnFyRkQ5ZVZMTFRNeENTajZQ?=
 =?utf-8?B?NjBra2Y2ME9aWGVRWnNhZ3hUdFZRM0x5NXpTY1NGd3VyTjRSdFprR2FhcHha?=
 =?utf-8?B?SzZYbVkweE5FeGZqenAyODFSRTBqQTBpdlpRQ2FZTmJFSmYwQ1FpNHFTM2Zj?=
 =?utf-8?B?L2RPK2RNNWRGZGczUTVPMUZhSnVBV2p5UWdMejRnNGcvQmJ5ODcxTEJtcXBu?=
 =?utf-8?B?aEo4V3M1R3JtMm45THFjNklQS0M0ZUFMZEw1Q2JEZmVIdEM0ak56ektXbjRC?=
 =?utf-8?B?aG1kVjR5Y1lFTFloeW1RQjd1NFBDOUZnY3E1UDFHbnpqQWh0ajkwc0N2RnZr?=
 =?utf-8?B?ZThFUUZPNGxMQXorVnFHczlncEw1bEI2c2dRV2tqK0loVFc0MzNaWGdzSGFy?=
 =?utf-8?B?RU1jWmMwMWNtMEtoMnJsb09EUG5GcVZKUGkrVE90dGFwZ2Y2MDRaSENuQ2po?=
 =?utf-8?B?L0FNTkdUUUtRQ3BNdndIRUhUVDJjM1Vic3RHNm5kZ3M2V1I3cnBEaU1tMlIw?=
 =?utf-8?B?UHhKM2d6dmFRc3k4S2M0WEFyZ1BrU0gzRnhocCs3bFNnV2F2SFFiUzlmMms2?=
 =?utf-8?B?cnlGWDBDTFlHWjhPOG90VDY1MDV1OE9SVXhiUXpLU25ack5wdGtUREpiS0FJ?=
 =?utf-8?Q?qn7NljUbmU4lbwVaychA/Dk7aZVi1l20Cc8Yb/C?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <FB57146885FD0D4BB48EAF45F71136C1@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS7PR13MB4733.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1797e1d2-cacb-41b1-4579-08d92ac41711
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jun 2021 21:26:33.5195
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QjhbSgOKI19UCJYKaSqTfIHsO8M7/6fKv/nH8XanRHJVCvyau8eqDW2oudCnMs/WLUd9HfnBqAFYoIY2vk7kzA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR13MB3867
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

T24gVHVlLCAyMDIxLTA2LTA4IGF0IDIxOjE5ICswMDAwLCBUcm9uZCBNeWtsZWJ1c3Qgd3JvdGU6
DQo+IE9uIFR1ZSwgMjAyMS0wNi0wOCBhdCAyMTowNiArMDAwMCwgQ2h1Y2sgTGV2ZXIgSUlJIHdy
b3RlOg0KPiA+IA0KPiA+IA0KPiA+ID4gT24gSnVuIDgsIDIwMjEsIGF0IDQ6NTYgUE0sIE9sZ2Eg
S29ybmlldnNrYWlhIDwgDQo+ID4gPiBvbGdhLmtvcm5pZXZza2FpYUBnbWFpbC5jb20+IHdyb3Rl
Og0KPiA+ID4gDQo+ID4gPiBPbiBUdWUsIEp1biA4LCAyMDIxIGF0IDQ6NDEgUE0gQ2h1Y2sgTGV2
ZXIgSUlJIDwgDQo+ID4gPiBjaHVjay5sZXZlckBvcmFjbGUuY29tPiB3cm90ZToNCj4gPiA+ID4g
DQo+ID4gPiA+IA0KPiA+ID4gPiANCj4gPiA+ID4gPiBPbiBKdW4gOCwgMjAyMSwgYXQgMjo0NSBQ
TSwgT2xnYSBLb3JuaWV2c2thaWEgPCANCj4gPiA+ID4gPiBvbGdhLmtvcm5pZXZza2FpYUBnbWFp
bC5jb20+IHdyb3RlOg0KPiA+ID4gPiA+IA0KPiA+ID4gPiA+IEZyb206IE9sZ2EgS29ybmlldnNr
YWlhIDxrb2xnYUBuZXRhcHAuY29tPg0KPiA+ID4gPiA+IA0KPiA+ID4gPiA+IEFmdGVyIHRydW5r
aW5nIGlzIGRpc2NvdmVyZWQgaW4NCj4gPiA+ID4gPiBuZnM0X2Rpc2NvdmVyX3NlcnZlcl90cnVu
a2luZygpLA0KPiA+ID4gPiA+IGFkZCB0aGUgdHJhbnNwb3J0IHRvIHRoZSBvbGQgY2xpZW50IHN0
cnVjdHVyZSBiZWZvcmUNCj4gPiA+ID4gPiBkZXN0cm95aW5nDQo+ID4gPiA+ID4gdGhlIG5ldyBj
bGllbnQgc3RydWN0dXJlIChhbG9uZyB3aXRoIGl0cyB0cmFuc3BvcnQpLg0KPiA+ID4gPiA+IA0K
PiA+ID4gPiA+IFNpZ25lZC1vZmYtYnk6IE9sZ2EgS29ybmlldnNrYWlhIDxrb2xnYUBuZXRhcHAu
Y29tPg0KPiA+ID4gPiA+IC0tLQ0KPiA+ID4gPiA+IGZzL25mcy9uZnM0Y2xpZW50LmMgfCA0MA0K
PiA+ID4gPiA+ICsrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysNCj4gPiA+
ID4gPiAxIGZpbGUgY2hhbmdlZCwgNDAgaW5zZXJ0aW9ucygrKQ0KPiA+ID4gPiA+IA0KPiA+ID4g
PiA+IGRpZmYgLS1naXQgYS9mcy9uZnMvbmZzNGNsaWVudC5jIGIvZnMvbmZzL25mczRjbGllbnQu
Yw0KPiA+ID4gPiA+IGluZGV4IDQyNzE5Mzg0ZTI1Zi4uOTg0Yzg1MTg0NGQ4IDEwMDY0NA0KPiA+
ID4gPiA+IC0tLSBhL2ZzL25mcy9uZnM0Y2xpZW50LmMNCj4gPiA+ID4gPiArKysgYi9mcy9uZnMv
bmZzNGNsaWVudC5jDQo+ID4gPiA+ID4gQEAgLTM2MSw2ICszNjEsNDQgQEAgc3RhdGljIGludA0K
PiA+ID4gPiA+IG5mczRfaW5pdF9jbGllbnRfbWlub3JfdmVyc2lvbihzdHJ1Y3QgbmZzX2NsaWVu
dCAqY2xwKQ0KPiA+ID4gPiA+IMKgwqDCoMKgIHJldHVybiBuZnM0X2luaXRfY2FsbGJhY2soY2xw
KTsNCj4gPiA+ID4gPiB9DQo+ID4gPiA+ID4gDQo+ID4gPiA+ID4gK3N0YXRpYyB2b2lkIG5mczRf
YWRkX3RydW5rKHN0cnVjdCBuZnNfY2xpZW50ICpjbHAsIHN0cnVjdA0KPiA+ID4gPiA+IG5mc19j
bGllbnQgKm9sZCkNCj4gPiA+ID4gPiArew0KPiA+ID4gPiA+ICvCoMKgwqDCoCBzdHJ1Y3Qgc29j
a2FkZHJfc3RvcmFnZSBjbHBfYWRkciwgb2xkX2FkZHI7DQo+ID4gPiA+ID4gK8KgwqDCoMKgIHN0
cnVjdCBzb2NrYWRkciAqY2xwX3NhcCA9IChzdHJ1Y3Qgc29ja2FkZHINCj4gPiA+ID4gPiAqKSZj
bHBfYWRkcjsNCj4gPiA+ID4gPiArwqDCoMKgwqAgc3RydWN0IHNvY2thZGRyICpvbGRfc2FwID0g
KHN0cnVjdCBzb2NrYWRkcg0KPiA+ID4gPiA+ICopJm9sZF9hZGRyOw0KPiA+ID4gPiA+ICvCoMKg
wqDCoCBzaXplX3QgY2xwX3NhbGVuLCBvbGRfc2FsZW47DQo+ID4gPiA+ID4gK8KgwqDCoMKgIHN0
cnVjdCB4cHJ0X2NyZWF0ZSB4cHJ0X2FyZ3MgPSB7DQo+ID4gPiA+ID4gK8KgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoCAuaWRlbnQgPSBvbGQtPmNsX3Byb3RvLA0KPiA+ID4gPiA+ICvCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqAgLm5ldCA9IG9sZC0+Y2xfbmV0LA0KPiA+ID4gPiA+ICvCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqAgLnNlcnZlcm5hbWUgPSBvbGQtPmNsX2hvc3RuYW1lLA0KPiA+ID4gPiA+
ICvCoMKgwqDCoCB9Ow0KPiA+ID4gPiA+ICvCoMKgwqDCoCBzdHJ1Y3QgbmZzNF9hZGRfeHBydF9k
YXRhIHhwcnRkYXRhID0gew0KPiA+ID4gPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgLmNs
cCA9IG9sZCwNCj4gPiA+ID4gPiArwqDCoMKgwqAgfTsNCj4gPiA+ID4gPiArwqDCoMKgwqAgc3Ry
dWN0IHJwY19hZGRfeHBydF90ZXN0IHJwY2RhdGEgPSB7DQo+ID4gPiA+ID4gK8KgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoCAuYWRkX3hwcnRfdGVzdCA9IG9sZC0+Y2xfbXZvcHMtPnNlc3Npb25fdHJ1
bmssDQo+ID4gPiA+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAuZGF0YSA9ICZ4cHJ0ZGF0
YSwNCj4gPiA+ID4gPiArwqDCoMKgwqAgfTsNCj4gPiA+ID4gPiArDQo+ID4gPiA+ID4gK8KgwqDC
oMKgIGlmIChjbHAtPmNsX3Byb3RvICE9IG9sZC0+Y2xfcHJvdG8pDQo+ID4gPiA+ID4gK8KgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoCByZXR1cm47DQo+ID4gPiA+ID4gK8KgwqDCoMKgIGNscF9zYWxl
biA9IHJwY19wZWVyYWRkcihjbHAtPmNsX3JwY2NsaWVudCwgY2xwX3NhcCwNCj4gPiA+ID4gPiBz
aXplb2YoY2xwX2FkZHIpKTsNCj4gPiA+ID4gPiArwqDCoMKgwqAgb2xkX3NhbGVuID0gcnBjX3Bl
ZXJhZGRyKG9sZC0+Y2xfcnBjY2xpZW50LCBvbGRfc2FwLA0KPiA+ID4gPiA+IHNpemVvZihvbGRf
YWRkcikpOw0KPiA+ID4gPiA+ICsNCj4gPiA+ID4gPiArwqDCoMKgwqAgaWYgKGNscF9hZGRyLnNz
X2ZhbWlseSAhPSBvbGRfYWRkci5zc19mYW1pbHkpDQo+ID4gPiA+ID4gK8KgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoCByZXR1cm47DQo+ID4gPiA+ID4gKw0KPiA+ID4gPiA+ICvCoMKgwqDCoCB4cHJ0
X2FyZ3MuZHN0YWRkciA9IGNscF9zYXA7DQo+ID4gPiA+ID4gK8KgwqDCoMKgIHhwcnRfYXJncy5h
ZGRybGVuID0gY2xwX3NhbGVuOw0KPiA+ID4gPiA+ICsNCj4gPiA+ID4gPiArwqDCoMKgwqAgeHBy
dGRhdGEuY3JlZCA9IG5mczRfZ2V0X2NsaWRfY3JlZChvbGQpOw0KPiA+ID4gPiA+ICvCoMKgwqDC
oCBycGNfY2xudF9hZGRfeHBydChvbGQtPmNsX3JwY2NsaWVudCwgJnhwcnRfYXJncywNCj4gPiA+
ID4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgcnBjX2Ns
bnRfc2V0dXBfdGVzdF9hbmRfYWRkX3hwcnQsDQo+ID4gPiA+ID4gJnJwY2RhdGEpOw0KPiA+ID4g
PiANCj4gPiA+ID4gSXMgdGhlcmUgYW4gdXBwZXIgYm91bmQgb24gdGhlIG51bWJlciBvZiB0cmFu
c3BvcnRzIHRoYXQNCj4gPiA+ID4gYXJlIGFkZGVkIHRvIHRoZSBORlMgY2xpZW50J3Mgc3dpdGNo
Pw0KPiA+ID4gDQo+ID4gPiBJIGRvbid0IGJlbGlldmUgYW55IGxpbWl0cyBleGlzdCByaWdodCBu
b3cuIFdoeSBzaG91bGQgdGhlcmUgYmUgYQ0KPiA+ID4gbGltaXQ/IEFyZSB5b3Ugc2F5aW5nIHRo
YXQgdGhlIGNsaWVudCBzaG91bGQgbGltaXQgdHJ1bmtpbmc/DQo+ID4gPiBXaGlsZQ0KPiA+ID4g
dGhpcyBpcyBub3Qgd2hhdCdzIGhhcHBlbmluZyBoZXJlLCBidXQgc2F5IEZTX0xPQ0FUSU9OIHJl
dHVybmVkDQo+ID4gPiAxMDANCj4gPiA+IGlwcyBmb3IgdGhlIHNlcnZlci4gQXJlIHlvdSBzYXlp
bmcgdGhlIGNsaWVudCBzaG91bGQgYmUgbGltaXRpbmcNCj4gPiA+IGhvdw0KPiA+ID4gbWFueSB0
cnVua2FibGUgY29ubmVjdGlvbnMgaXQgd291bGQgYmUgZXN0YWJsaXNoaW5nIGFuZCBwaWNraW5n
DQo+ID4gPiBqdXN0IGENCj4gPiA+IGZldyBhZGRyZXNzZXMgdG8gdHJ5PyBXaGF0J3MgaGFwcGVu
aW5nIHdpdGggdGhpcyBwYXRjaCBpcyB0aGF0DQo+ID4gPiBzYXkNCj4gPiA+IHRoZXJlIGFyZSAx
MDBtb3VudHMgdG8gMTAwIGlwcyAoZWFjaCByZXByZXNlbnRpbmcgdGhlIHNhbWUgc2VydmVyDQo+
ID4gPiBvcg0KPiA+ID4gdHJ1bmthYmxlIHNlcnZlcihzKSksIHdpdGhvdXQgdGhpcyBwYXRjaCBh
IHNpbmdsZSBjb25uZWN0aW9uIGlzDQo+ID4gPiBrZXB0LA0KPiA+ID4gd2l0aCB0aGlzIHBhdGNo
IHdlJ2xsIGhhdmUgMTAwIGNvbm5lY3Rpb25zLg0KPiA+IA0KPiA+IFRoZSBwYXRjaCBkZXNjcmlw
dGlvbiBuZWVkcyB0byBtYWtlIHRoaXMgYmVoYXZpb3IgbW9yZSBjbGVhci4gSXQNCj4gPiBuZWVk
cyB0byBleHBsYWluICJ3aHkiIC0tIHRoZSBib2R5IG9mIHRoZSBwYXRjaCBhbHJlYWR5IGV4cGxh
aW5zDQo+ID4gIndoYXQiLiBDYW4geW91IGluY2x1ZGUgeW91ciBsYXN0IHNlbnRlbmNlIGluIHRo
ZSBkZXNjcmlwdGlvbiBhcw0KPiA+IGEgdXNlIGNhc2U/DQo+ID4gDQo+ID4gQXMgZm9yIHRoZSBi
ZWhhdmlvci4uLiBTZWVtcyB0byBtZSB0aGF0IHRoZXJlIGFyZSBnb2luZyB0byBiZSBvbmx5DQo+
ID4gaW5maW5pdGVzaW1hbCBnYWlucyBhZnRlciB0aGUgZmlyc3QgZmV3IGNvbm5lY3Rpb25zLCBh
bmQgYWZ0ZXINCj4gPiB0aGF0LCBpdCdzIGdvaW5nIHRvIGJlIGEgbG90IGZvciBib3RoIHNpZGVz
IHRvIG1hbmFnZSBmb3Igbm8gcmVhbA0KPiA+IGdhaW4uIEkgdGhpbmsgeW91IGRvIHdhbnQgdG8g
Y2FwIHRoZSB0b3RhbCBudW1iZXIgb2YgY29ubmVjdGlvbnMNCj4gPiBhdCBhIHJlYXNvbmFibGUg
bnVtYmVyLCBldmVuIGluIHRoZSBGU19MT0NBVElPTlMgY2FzZS4NCj4gPiANCj4gDQo+IEknZCB0
ZW5kIHRvIGFncmVlLiBJZiB5b3Ugd2FudCB0byBzY2FsZSBJL08gdGhlbiBwTkZTIGlzIHRoZSB3
YXkgdG8NCj4gZ28sDQo+IG5vdCB2YXN0IG51bWJlcnMgb2YgY29ubmVjdGlvbnMgdG8gYSBzaW5n
bGUgc2VydmVyLg0KPiANCkJUVzogQUZBSUNTIHRoaXMgcGF0Y2ggd2lsbCBlbmQgdXAgYWRkaW5n
IGFub3RoZXIgY29ubmVjdGlvbiBldmVyeSB0aW1lDQp3ZSBtb3VudCBhIG5ldyBmaWxlc3lzdGVt
LCB3aGV0aGVyIG9yIG5vdCBhIGNvbm5lY3Rpb24gYWxyZWFkeSBleGlzdHMNCnRvIHRoYXQgSVAg
YWRkcmVzcy4gVGhhdCdzIHVuYWNjZXB0YWJsZS4NCg0KLS0gDQpUcm9uZCBNeWtsZWJ1c3QNCkxp
bnV4IE5GUyBjbGllbnQgbWFpbnRhaW5lciwgSGFtbWVyc3BhY2UNCnRyb25kLm15a2xlYnVzdEBo
YW1tZXJzcGFjZS5jb20NCg0KDQo=

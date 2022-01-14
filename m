Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 312EA48E31D
	for <lists+linux-nfs@lfdr.de>; Fri, 14 Jan 2022 04:59:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239064AbiAND7b (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 13 Jan 2022 22:59:31 -0500
Received: from mail-dm6nam11on2097.outbound.protection.outlook.com ([40.107.223.97]:48864
        "EHLO NAM11-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S239063AbiAND7b (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Thu, 13 Jan 2022 22:59:31 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=m8sYLXmHnysYd6jNu+arj2zb6On5eBBvvI4XDd+2KF0ZX1wkInwgO0rhs70DlzOaLIBdBRqMWY+OlAj7VlqEkIH8EIb/4quwMPcNPey6Fozew0ARDK9htz9GT+lGSbdMuJL9Zcso2yH+kpbZ5/WiX+iXy/sd1/2lt+8h3OURYHKjCY3UDImcLsvVfR9noohCQT6NRoi4mkGp6ZZDIwyjmYOEOCHYlNzuAdqdaRv1D3Jqt9WMN8G7zTmjGyCyjxZdIzuLdIevF9sC1xlqedV7A3hNZjCzbVTLvWPk4oCdF1nYTEgUiB3UBF8KsECZ9nvHCa0ythg4UMX6CiBdVUCgGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TU6l9AK4jZUZWwqr0MeDyE4Tmz2hpv9r6v92FvvpOG4=;
 b=NEJRkzZZOmOcmkN3ZeB7MYZeFHFUBvOXjGJbVmM0Eurg7fIkzK0I1cA8fiS6Yb3g7p0rLUPY6ggYEgHu80zoWCNtlojtn51gqlS/yW7RWaQZVLnzdVnmAABOu8/epBH7WL0uufUAnLAYY70EeKykYCcNxU57akXnaw+AMe9cBcCAVj3579yqkLEbK3tLQo3rryQiB5K/d9ISPCOJtEgWkUBhh+WCDUwOE0q+l6yvnFtBC8JNGZXrz+biy2QkphOz4AT45i2f8LEe2I02cvpYtvb2USY5MrRV4s0yOGCEBofA3hvWxb7HMk861oP+wmTKF12TfhI8ognFow3xf3KKhQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TU6l9AK4jZUZWwqr0MeDyE4Tmz2hpv9r6v92FvvpOG4=;
 b=btnOpaqZ0EzqznC0IdYHeBz5CA87IzEePTBrxVvYWWF7QBjqBpjZ3UnRF798IVolkpn6bXu14SCTyYBH7hwJ6PdlVEFO/iWjkjBZaSYbuV4IlZvGh1HX+C3rvtOfuDj/JfwTSIJ4uRD8BayPh2V83gYcoo5adjx1p9c3HY1mNYw=
Received: from CH0PR13MB5084.namprd13.prod.outlook.com (2603:10b6:610:111::7)
 by BY5PR13MB3412.namprd13.prod.outlook.com (2603:10b6:a03:1a8::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.3; Fri, 14 Jan
 2022 03:59:27 +0000
Received: from CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::ecb4:77ee:a645:9bae]) by CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::ecb4:77ee:a645:9bae%4]) with mapi id 15.20.4909.002; Fri, 14 Jan 2022
 03:59:27 +0000
From:   Trond Myklebust <trondmy@hammerspace.com>
To:     "cgel.zte@gmail.com" <cgel.zte@gmail.com>
CC:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "deng.changcheng@zte.com.cn" <deng.changcheng@zte.com.cn>,
        "anna.schumaker@netapp.com" <anna.schumaker@netapp.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "zealci@zte.com.cn" <zealci@zte.com.cn>
Subject: Re: [PATCH] NFS: Replace one-element array with flexible-array member
Thread-Topic: [PATCH] NFS: Replace one-element array with flexible-array
 member
Thread-Index: AQHYCOHyKodGvfEzfEadT3o7SIsiWKxh5HmA
Date:   Fri, 14 Jan 2022 03:59:26 +0000
Message-ID: <ad9ebec6db5bac36e3b486288b84c4e1bbd781f2.camel@hammerspace.com>
References: <20220114005732.763911-1-deng.changcheng@zte.com.cn>
In-Reply-To: <20220114005732.763911-1-deng.changcheng@zte.com.cn>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=hammerspace.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 63555263-db26-46d8-a03f-08d9d7124241
x-ms-traffictypediagnostic: BY5PR13MB3412:EE_
x-microsoft-antispam-prvs: <BY5PR13MB3412277923A17B1DA36D5266B8549@BY5PR13MB3412.namprd13.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 8n76DlsRsnlKQtlvndNHZ/GUsOxq0op3KWpl6k6a8phKg+Q3PR02TJ2R+I7757awVsqYwiZoF0ywPe86yF+hc+pilqKkrWyJZBU9r1jZZ0Xbd5gBYr9NAAqcbCFfPDW+8UTiggBL1/HWExMyD0EzUdQXQny1OULtr5SQ8yzqDvs8dMUuYTObML+IVQgtiBF5ZSvxmrtC0OT8rXsKrSgbGB9dtmMOwaaH64Xnf3t1IAvdBEyd8z1mZslI14Ofyf4G0turk1roOui2h1WLfjZnDvmTztvCSeQOC9JTzQegNtDmHw5gXwLA/robFd7qQtk0vHAsOEtK1x+a2zeBtgF0RPuREMhQmThBXNGxmv17sPwTYmM9aAcj7inaYGteVZAaKkE7efy0Xylq8lylyaDoO2paeg32yZjivBU1dKt4g3d5Yy74C15+rNr1K2qzcEqJJSDQxwahlGBk5EXT8BDjq/426nOquM0dl9/rfhM94P4h5zzAUr+WjJf/apFJLMG9crenm88N5VPxWnyKkE6Cy4GyPRe+SJSuDzJWrcjF4sHXLpKhg+z4Nboqu6mM5iDg1Nca4Ql/VKWnSrSTEqX2DDZ3oer41b3r3JNFto1rfTtJ5SttL0/j7JgLRflmOVHmsCSHqMzz7VoeOIfa2S1aVmc4TbK7ucyam49ARG4qh5yo3nVKqT8FZlFNrbGu6Xb4BZbrkcKTHHlH1mAXEM7HE5dyaXDlevYb+nzrhafk3lW1arjd23Ct2aPg8eRGcOqIwE2QfMgxwrsLAcLaUcDc+Ktr34a3b0bK2H9KZp5pAS0RSQHSfEu7xm8cjkUFDZokw4QipuWM4n2FK0s+3MKTNQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR13MB5084.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(39840400004)(376002)(366004)(136003)(396003)(346002)(26005)(6486002)(36756003)(6506007)(83380400001)(38100700002)(66476007)(122000001)(66556008)(508600001)(76116006)(186003)(316002)(6916009)(54906003)(86362001)(2906002)(966005)(66446008)(71200400001)(38070700005)(8676002)(66946007)(5660300002)(4326008)(64756008)(2616005)(8936002)(6512007)(20210929001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MC9KWlAraU9BY3pkNGhFUW9VR2xsUWlDUkRZdE5DeXowUkhRTDFXWFFTR253?=
 =?utf-8?B?Q2NaTmViYVB4bmwxWEg5ejdaaGE4ZjlCa0xZVWJxWnhIc0haci9xMURzejNL?=
 =?utf-8?B?SVNQKzNRYU5OOXkxZmREVzRPTEdPczZJUGdWWjZYQ2pUZTUvVDJKN0NmQjk2?=
 =?utf-8?B?T3doWXV4L1FmaDB1OWRZY3ExNGV1NFVBcmRzLzNENkdWb0xCeC9jVVJCUndU?=
 =?utf-8?B?eFkyV3ZaMk9ncUM2ckF5OW9McVN6ZnI5WEkvSi83ckwwZUcyRFFVaW9IUHRI?=
 =?utf-8?B?U3dsZ1d6U29mK1F6enBOTTVHVGNtcHA0c0hmcTRQbGMycWIrbnJ1bEJleGdJ?=
 =?utf-8?B?RHhsc1pwaWN0dXdsSTRmV2dtdGJsT05QUEZicHc5SnBLN29zcllhMHhxYW9H?=
 =?utf-8?B?UW5HZ3pqdU9oOHpvbDVhZE5lSEFiZ2VHRHdidVR3T3BkUTZxVDN6YjFac1Bu?=
 =?utf-8?B?TmJkdVRsbUlUa0pYUU1DZ2w5T2ZxVDdMVHd1a0FGVzgrcGowTi9SUjJtQ1p5?=
 =?utf-8?B?MHBoZjZtckxGTlN6amxFbHB2VlNxZWZocC9nVFozTHJQZ0VhS0xJUWM4U0ta?=
 =?utf-8?B?cUtvTkUyazd6amZZWDVkUkp3RVA5YWtSWk9ZcFQraWRqS3h1eGpIb1N0bzF3?=
 =?utf-8?B?RUhDVENzZEV0VWgwNmVJZ1F5ZnI5MkRudGk1TWtyb0hMZkl5RlB0K3FJYlph?=
 =?utf-8?B?VGxVY0laMmN4dXh1RFhzUUVhaDBLZTJ0OUc3QmgxdVZza0U3MUdaZ24rMjZn?=
 =?utf-8?B?WXljU3RyaGFRbVFnc0k2NEI1NllVVytGNjF2a2tNUTY0M0s4c3l6cG84MUhH?=
 =?utf-8?B?N29TVGJhVlF0UmdDcTB3cURNeG0rYTVIOXRhK2ViYkQwbWVzUEtleUpibGZX?=
 =?utf-8?B?SExHQVFCRTVnUXZVNm1nbVo4M2JvbDNVcCtrNzNyS2VscFU0MXRKYXo3Sk0v?=
 =?utf-8?B?QmtLWnJ3OGVNMlRmYU15aVdUY3UwVGVMWlBobXVJb0YwUkl2RlZtRlRyN2Ja?=
 =?utf-8?B?VDBDQ1ZRU2d3TXhOSmxaOVEyQ210UGFjTE5aV3VGSW1zZ1FUK291bWtoMDZI?=
 =?utf-8?B?S09rN08rUzQyNWdVN0ZUWmZZYzgvS29HVWJnazl1STlvNWpjck9CWDY5Tmdn?=
 =?utf-8?B?NHVRRVNOZXNTbzhjL2NlNnBkSTJXNVdrdDZPR3BIVTg4ZnRqdjBudnJ3TytL?=
 =?utf-8?B?WmkvaGZmQ1JaV01yRlZEQjlDcUxsQjlTRkNSaDlJc1VUMEh1b1B2SE1iL0pa?=
 =?utf-8?B?VmZMYlhKV1pWZ01xakYxendTZUxIQUpJaUNJMWlFbDJaU0VPSFovWkJhTUp2?=
 =?utf-8?B?WklLSDBXbTZ4eVZjZVhIc0s3dnNzV3JMN1JNVFZOcE03akhlbVZHaFI3L3U4?=
 =?utf-8?B?STkxNEI5QWdORXhBMUE1YVAvVExKRFREOUs3V25FdGxOWDNwL1JlZnB6VnlN?=
 =?utf-8?B?cnJkTWx1WVZkU2FOekpqaEFmV2JoY1NLVUQ5d0tYS1BUR0RWdURIclRXWHdq?=
 =?utf-8?B?cngzQXdOOHFvbHFjbU5hcWZuVlI0eVZrWkZRVDNjaWNVRTFrU3A4RlhENmRh?=
 =?utf-8?B?RzB3eFNYRHkwTDNtdk5YWVQySDJOUFNtVHQzZzEzbFI0anRFZEQ0YWw1Tm1x?=
 =?utf-8?B?RW1pNHROSDZnSklsZStKVG9sT0NvK2xxOVdWOEVJY2lxdm1ISS94TURxdVF3?=
 =?utf-8?B?RmRRbjg3WENZQVVZNFVvMnBxSTJDZXBQWUZFL2FmazNCVnlQTEtPRU5sd1Jn?=
 =?utf-8?B?eHFGdHVxeWJGYzBNLzJROWJJMytpd20yek5JV2ZUbUhxRXVkVmJCS0hnU29L?=
 =?utf-8?B?dW9JYlIwZ2krV3BlR2tIcEUwdmZHV2lXOFNYVXN0S3kyUElZd1VORktEK21q?=
 =?utf-8?B?VThTOC9aTGxQM0FsWEk4UHZONFlnNHB3RTgrOHpDOUV3aXVQeFpOVEtyREtu?=
 =?utf-8?B?eFROY2cvaDV5emZPUGZ4NFFJZU14NklMWGFIUWx3RXpmK0IySERpTjZQMXlK?=
 =?utf-8?B?SFVpclk5aXMrTGsvaWpRUmduZGYvYis5OFROT1oyNytwZ1YvZTVkcUJjRmJi?=
 =?utf-8?B?MzE4WnlFUi9aUjFMUmhFWTdQRFVJUTM5TXAyWXc2ZGJnOWdhOTFKdXRpWU5Z?=
 =?utf-8?B?ZDdwSmFsaDF0OHc4cjhWY2xSU2VSVzRjOXB5RkdYck5jUFRrVHl4Tk9BQnpw?=
 =?utf-8?Q?+CqtQoLCpG4S78VpiZKVKGI=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <5F88BA5D924A1946943D9359F301CD66@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR13MB5084.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 63555263-db26-46d8-a03f-08d9d7124241
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Jan 2022 03:59:26.9678
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: adk2HsHSLsBwtZWfViUFwvqdcIc/omAVzatLEuCe3Qy6pDqkMb+Fsjpia1M2PUyAibF4QOCnBKgPSUyEZfrL5w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR13MB3412
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

T24gRnJpLCAyMDIyLTAxLTE0IGF0IDAwOjU3ICswMDAwLCBjZ2VsLnp0ZUBnbWFpbC5jb20gd3Jv
dGU6DQo+IEZyb206IENoYW5nY2hlbmcgRGVuZyA8ZGVuZy5jaGFuZ2NoZW5nQHp0ZS5jb20uY24+
DQo+IA0KPiBUaGVyZSBpcyBhIHJlZ3VsYXIgbmVlZCBpbiB0aGUga2VybmVsIHRvIHByb3ZpZGUg
YSB3YXkgdG8gZGVjbGFyZQ0KPiBoYXZpbmcNCj4gYSBkeW5hbWljYWxseSBzaXplZCBzZXQgb2Yg
dHJhaWxpbmcgZWxlbWVudHMgaW4gYSBzdHJ1Y3R1cmUuIEtlcm5lbA0KPiBjb2RlDQo+IHNob3Vs
ZCBhbHdheXMgdXNlIOKAnGZsZXhpYmxlIGFycmF5IG1lbWJlcnPigJ0gZm9yIHRoZXNlIGNhc2Vz
LiBUaGUgb2xkZXINCj4gc3R5bGUgb2Ygb25lLWVsZW1lbnQgb3IgemVyby1sZW5ndGggYXJyYXlz
IHNob3VsZCBubyBsb25nZXIgYmUgdXNlZC4NCj4gDQo+IFJlZmVyZW5jZToNCj4gaHR0cHM6Ly93
d3cua2VybmVsLm9yZy9kb2MvaHRtbC9sYXRlc3QvcHJvY2Vzcy9kZXByZWNhdGVkLmh0bWwjemVy
by1sZW5ndGgNCj4gLQ0KPiBhbmQtb25lLWVsZW1lbnQtYXJyYXlzDQo+IA0KPiBSZXBvcnRlZC1i
eTogWmVhbCBSb2JvdCA8emVhbGNpQHp0ZS5jb20uY24+DQo+IFNpZ25lZC1vZmYtYnk6IENoYW5n
Y2hlbmcgRGVuZyA8ZGVuZy5jaGFuZ2NoZW5nQHp0ZS5jb20uY24+DQo+IC0tLQ0KPiDCoGluY2x1
ZGUvbGludXgvbmZzX3hkci5oIHwgMiArLQ0KPiDCoDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlv
bigrKSwgMSBkZWxldGlvbigtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2luY2x1ZGUvbGludXgvbmZz
X3hkci5oIGIvaW5jbHVkZS9saW51eC9uZnNfeGRyLmgNCj4gaW5kZXggMzkzOTBkOWRmOWUxLi43
ZjUxZWRkNTc4NWEgMTAwNjQ0DQo+IC0tLSBhL2luY2x1ZGUvbGludXgvbmZzX3hkci5oDQo+ICsr
KyBiL2luY2x1ZGUvbGludXgvbmZzX3hkci5oDQo+IEBAIC00MjEsNyArNDIxLDcgQEAgc3RydWN0
IG5mczQyX2xheW91dF9lcnJvciB7DQo+IMKgwqDCoMKgwqDCoMKgwqBfX3U2NCBvZmZzZXQ7DQo+
IMKgwqDCoMKgwqDCoMKgwqBfX3U2NCBsZW5ndGg7DQo+IMKgwqDCoMKgwqDCoMKgwqBuZnM0X3N0
YXRlaWQgc3RhdGVpZDsNCj4gLcKgwqDCoMKgwqDCoMKgc3RydWN0IG5mczQyX2RldmljZV9lcnJv
ciBlcnJvcnNbMV07DQo+ICvCoMKgwqDCoMKgwqDCoHN0cnVjdCBuZnM0Ml9kZXZpY2VfZXJyb3Ig
ZXJyb3JzW107DQo+IMKgfTsNCj4gwqANCj4gwqAjZGVmaW5lIE5GUzQyX0xBWU9VVEVSUk9SX01B
WCA1DQoNCk5BQ0suIFRoaXMgaXMgYSBmaXhlZCBzaXplIGFycmF5IG9mIGxlbmd0aCAxLCBub3Qg
YSB2YXJpYWJsZSBzaXplDQphcnJheS4gUGxlYXNlIGZpeCB5b3VyIHRvb2wuDQoNCi0tIA0KVHJv
bmQgTXlrbGVidXN0DQpMaW51eCBORlMgY2xpZW50IG1haW50YWluZXIsIEhhbW1lcnNwYWNlDQp0
cm9uZC5teWtsZWJ1c3RAaGFtbWVyc3BhY2UuY29tDQoNCg0K

Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 913BB2EF5E4
	for <lists+linux-nfs@lfdr.de>; Fri,  8 Jan 2021 17:37:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727128AbhAHQgo (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 8 Jan 2021 11:36:44 -0500
Received: from mail-dm6nam11on2112.outbound.protection.outlook.com ([40.107.223.112]:16993
        "EHLO NAM11-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726749AbhAHQgo (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Fri, 8 Jan 2021 11:36:44 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aNOVM7T9vHIcP4FWM8YeP889Z+StZm2TJmHOMnTM/Rtjdi/fg7fvG24tVGp6xFLNh5R2tZMhOBoVWf+8WlqSzEOyN3PI2614N4V7djOzNaOH/R7CSpyYarMT3k+Yte2GmWB3vW0HNgHRp7QR+BS7JNRu6lw2uc9pmNjxDUZPpcCborindFP8aOlnc5givVoTeyYJZqopR2/iPpMNI6pPWUhvuymkF2BEEdu1puiJuCe7/eeWT0qtt1dxmxRHN5m+E0pYaYDi7khbeVPKRLVd1x2qDSNKxZ7G6SXakq7zM01/HSMwcF56XsgmbTGwhfl1rh1++zybKij2jGlPspZF4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XnowNovX64dKFx8VBRsNcMlAsIb6k+wtjXIRY+xocJs=;
 b=n/Ka+OjCbnI6Kr6lXI+sx4JizQzDMe+fdhBhkfnBK0DGVOZh/gzOTC7QdZDkHOYuwbL7X0qUl0fSoA2EYDhly0NuBUIjWhMevfkqOa/Bsc3ITJP5QBNmkjzJB8HSQHPtWN9Z/GGeUJg0wKgs2iX7chnHd5NKO4/E1lURoeN1QIex8shOfzAuFLaNbh71qsBlR9u3ds6wTubLDhqZp/YHHcNg5N7UqJll7gsFk+IkSiiRiVOi/kANfq6GhCChTmQ0wi/bnhUau0zd9WmJprnWFhQd+W9poDuiRnTRiu892pbiET1YEcbIkU48figoSoZkXYC3Tyn0XlGY9DaXJVT8dg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XnowNovX64dKFx8VBRsNcMlAsIb6k+wtjXIRY+xocJs=;
 b=SIhRiBhzCDmW+z1sFOjj+f6dSBDYBlOL4tti6YKDuwPJJNq8aSsrAXVW12qjNHxgHG36xrChhwTRvlIOiDgWhjvsKvthBPOkoyUxP4Yvl/eNnWrvotQ+yNqlds2XpKspg5HrOphX8RMB8EjNqhwbC7kfvnSJYy73k+uyT3AU4cs=
Received: from CH2PR13MB3525.namprd13.prod.outlook.com (2603:10b6:610:21::29)
 by CH2PR13MB3781.namprd13.prod.outlook.com (2603:10b6:610:9a::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3763.5; Fri, 8 Jan
 2021 16:35:50 +0000
Received: from CH2PR13MB3525.namprd13.prod.outlook.com
 ([fe80::f9a6:6c23:4015:b7fc]) by CH2PR13MB3525.namprd13.prod.outlook.com
 ([fe80::f9a6:6c23:4015:b7fc%6]) with mapi id 15.20.3763.004; Fri, 8 Jan 2021
 16:35:50 +0000
From:   Trond Myklebust <trondmy@hammerspace.com>
To:     "bfields@fieldses.org" <bfields@fieldses.org>,
        "chuck.lever@oracle.com" <chuck.lever@oracle.com>
CC:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH v1 00/42] Update NFSD XDR functions
Thread-Topic: [PATCH v1 00/42] Update NFSD XDR functions
Thread-Index: AQHW43fKB1OYuGq7GEaxumlcnQjaYaodEswAgADSJoCAAACPgIAAASQAgAABi4CAAAmBAA==
Date:   Fri, 8 Jan 2021 16:35:50 +0000
Message-ID: <cf8329455c84c2efb76e3824b1639889ea22d716.camel@hammerspace.com>
References: <160986050640.5532.16498408936966394862.stgit@klimt.1015granger.net>
         <20210108031800.GA13604@fieldses.org>
         <FDB7EF17-AD34-4CB5-824D-0DB2F5FA6F6A@oracle.com>
         <20210108155209.GC4183@fieldses.org>
         <FE877FEA-2A2E-4558-9B95-64116804E924@oracle.com>
         <20210108160145.GD4183@fieldses.org>
In-Reply-To: <20210108160145.GD4183@fieldses.org>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: fieldses.org; dkim=none (message not signed)
 header.d=none;fieldses.org; dmarc=none action=none
 header.from=hammerspace.com;
x-originating-ip: [68.36.133.222]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7485cfaa-7592-4c43-e8a0-08d8b3f375cf
x-ms-traffictypediagnostic: CH2PR13MB3781:
x-microsoft-antispam-prvs: <CH2PR13MB37819F260FE1F305264DD738B8AE0@CH2PR13MB3781.namprd13.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: UohAFmqk62yngysCQKkwaVbUQmKadqFfpFBM6DkZMc4nGO37x1iF1GpcflJ/vcUVeSJoI0Iclc2gK2Qw1NKiQn5NZlmIfqxvhujVJwVN6iGBlfNYfXdxPKoyC+2RqKGlHuF2tPkddjaefZl2XfXYpswBRto7uHVx67INe50JuMfkzPuZjz+DyOn5sM9zIF/eDVvVUbXEbXkKY3pKqHatTzXAGTxlIC0YQodZrFTTYkRKdBdMQURGnyX8ajfR30UWI2y1ys4frNdnQbo6GLwUieLeoEjBXzE13954nSzqVamoV0lb2Z271UdOA+P0sT08F6pRB4e9H0jK5tJc7rXB00B5op9MvNGywLDQR0UHfO/vg+3c7V0DlJR/xXqSgHOHstVHylOXxNQrC2JIqiL30w==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR13MB3525.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(39840400004)(136003)(366004)(376002)(346002)(6486002)(6512007)(2616005)(8936002)(4326008)(186003)(71200400001)(76116006)(66556008)(66446008)(66946007)(53546011)(316002)(2906002)(478600001)(86362001)(110136005)(26005)(66476007)(64756008)(83380400001)(36756003)(5660300002)(8676002)(6506007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?utf-8?B?UFpwVENsdGVnVmlMVXZXQzJxRXpkNHd6dk1MWHc1RmV6VG9wa0VNYzlFbFZW?=
 =?utf-8?B?ZjBXNHFzZ0xqRnc2Kys0Mmd1YkRRc3hFc1Z3RTdRQ1kwSENyaWhIbEh1bFFH?=
 =?utf-8?B?KzZWem1NSDcwRkpONUE2QlV6WHJvclprdXRwRzNPbkpiRldud2RJdGtzRWFy?=
 =?utf-8?B?YTdQdzZoaXdjNTZRVitXV2xBQ0x3TlRMenVHZmI3ZmlXeTlMQ2Vnc0Juanht?=
 =?utf-8?B?dlBxRGdKR1VxSVhZdnFtMjZzWXNwZjhNNWxKY1Z0RHdjeFZRU1ZQZ056ZHRM?=
 =?utf-8?B?KzVaQTM0ZzVMUXcvZGM0c2tONThxQUxEc3VPNUlYSjZiZFA5VHN5TklXK25y?=
 =?utf-8?B?UTFiRlRSbmVtbFgwQnVoeHcwRy9wdnNDRmNyU096R2JUK1puVldiYjlMb3Fl?=
 =?utf-8?B?blV4cVZLQnBFazQxcjFHbW5OdDBkczI2QktEejN5dWFreWh2dW5JbldhNmlv?=
 =?utf-8?B?WTVwdjNtWjJGUVBjVis1bmpZWXAzS1hTOXNBUVZQS2R4czRCTytkaVVTUk1K?=
 =?utf-8?B?OTRWK2VvOXdyNUlYRlBxQm1EcXJuSTQzVG16ZGgrWGtlbXRGOUdTMU13TFZw?=
 =?utf-8?B?QzB0WGlpYkMyeFNiZHArQnBYeElVcnYxOHloM2FCaUMrNDV5R1htVElXdzNP?=
 =?utf-8?B?dDIycFNENHkyUGVjcEJmZ09tL25HN3cwcExDdzNIMU5pa0c1a2hiRGZYNUJv?=
 =?utf-8?B?cUpaYXBwM21aTWVTWDhxMHlxR0xMSFFiVFIzWTBuU05lT3ZhTUxDUEpzOTNN?=
 =?utf-8?B?TTZrd3NncnlPL3Z0MnVBRHpNRmRSRS9hV0U2MlU1dERmazdiUmk3bUx3aVEz?=
 =?utf-8?B?NU95UVpXQTFIeFBUQUpjZXgvcHBEY0xEaU1meG4rMXY2aEtZbXNVd1BZZTR5?=
 =?utf-8?B?T2tncVVWNjY5ZWF4OS8xVnhLS1l5bUdOMkNOUGV2NlpUdUJKMWVWbkdmZERS?=
 =?utf-8?B?YWVWeVhyNGI0dGVobmNXSHBiaVFSZlRGTWlXWGJpTHlIcFROaXVReHhqK0RK?=
 =?utf-8?B?cHVJelNCRUNjeHJTb3FXR1VXbzNBbWpyaG1FaFpYMDV0aEVabTh6MmpFTXl4?=
 =?utf-8?B?dkFueHg2N25tWEZkY1NWUWFiTTFORmZGYUkwbEphdlhHNFpjNTVNdk9hTVEz?=
 =?utf-8?B?eTFya0NyU0tOTTdhSW83VGRzMkp4Snd1d0tyZDJSZHdCZmFWZUtSWTFveDBP?=
 =?utf-8?B?cXp3MCtPUVNTNS9IcXlvRkM5NjZGSHZqanFCQk5hMmtBS1pUZnVxd0FEWm8y?=
 =?utf-8?B?OWczQS9DVFhmcFdlaDVJKzhnRWZoWXlRaDZsTXVVWUp1WnJlckVTNTJ4TXV4?=
 =?utf-8?Q?XcQrXutHqOOqNYdqFRhDR56ZchIpuoPz+M?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <5CD2DDDE7B573546A73220D853486E75@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH2PR13MB3525.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7485cfaa-7592-4c43-e8a0-08d8b3f375cf
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jan 2021 16:35:50.6720
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WxxqiY/WPQUuGSa+vHDahEy1KERaPjorNqOjECDnNR9MUa6C72Spc/joIaw06pPnOKbZoG1cqqSLyMnFyzOQVQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR13MB3781
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

T24gRnJpLCAyMDIxLTAxLTA4IGF0IDExOjAxIC0wNTAwLCBCcnVjZSBGaWVsZHMgd3JvdGU6DQo+
IE9uIEZyaSwgSmFuIDA4LCAyMDIxIGF0IDEwOjU2OjE0QU0gLTA1MDAsIENodWNrIExldmVyIHdy
b3RlOg0KPiA+IA0KPiA+IA0KPiA+ID4gT24gSmFuIDgsIDIwMjEsIGF0IDEwOjUyIEFNLCBCcnVj
ZSBGaWVsZHMgPGJmaWVsZHNAZmllbGRzZXMub3JnPg0KPiA+ID4gd3JvdGU6DQo+ID4gPiANCj4g
PiA+IE9uIEZyaSwgSmFuIDA4LCAyMDIxIGF0IDEwOjUwOjA5QU0gLTA1MDAsIENodWNrIExldmVy
IHdyb3RlOg0KPiA+ID4gPiANCj4gPiA+ID4gDQo+ID4gPiA+ID4gT24gSmFuIDcsIDIwMjEsIGF0
IDEwOjE4IFBNLCBiZmllbGRzQGZpZWxkc2VzLm9yZ8Kgd3JvdGU6DQo+ID4gPiA+ID4gDQo+ID4g
PiA+ID4gSSBoYXZlbid0IGhhZCBhIGNoYW5jZSB0byByZXZpZXcgdGhlc2UsIGJ1dCB0aG91Z2h0
IEkgc2hvdWxkDQo+ID4gPiA+ID4gbWVudGlvbiBJJ20NCj4gPiA+ID4gPiBzZWVpbmcgYSBmYWls
dXJlIGluIHhmc3Rlc3RzIGdlbmVyaWMvNDY1IHRoYXQgSSBkb24ndCAqdGhpbmsqDQo+ID4gPiA+
ID4gaXMNCj4gPiA+ID4gPiByZXByb2R1Y2VhYmxlIGJlZm9yZSB0aGlzIHNlcmllcy7CoCBVbmZv
cnR1bmF0ZWx5IGl0J3MNCj4gPiA+ID4gPiBpbnRlcm1pdHRlbnQsDQo+ID4gPiA+ID4gdGhvdWdo
LCBzbyBJJ20gbm90IGNlcnRhaW4geWV0Lg0KPiA+ID4gPiANCj4gPiA+ID4gQ29uZmlybWluZzog
ZG9lcyB0aGF0IGZhaWx1cmUgb2NjdXIgd2l0aCBORlN2Mz8NCj4gPiA+IA0KPiA+ID4gSSd2ZSBv
bmx5IHRyaWVkIGl0IG92ZXIgNC4yLg0KPiA+IA0KPiA+IEludGVyZXN0aW5nLiBUaGlzIHNlcmll
cyBzaG91bGRuJ3QgaGF2ZSBhbnkgaW1wYWN0IG9uIE5GU3Y0DQo+ID4gZGlyZWN0IEkvTyBmdW5j
dGlvbmFsaXR5Og0KPiA+IA0KPiA+IGZzL25mc19jb21tb24vbmZzYWNsLmPCoMKgwqDCoMKgwqDC
oMKgwqAgfMKgIDUyICsrKw0KPiA+IGZzL25mc2QvbmZzMmFjbC5jwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoCB8wqAgNjIgKystLQ0KPiA+IGZzL25mc2QvbmZzM2FjbC5jwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoCB8wqAgNDIgKystDQo+ID4gZnMvbmZzZC9uZnMzcHJvYy5jwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqAgfMKgIDcxICsrKy0tDQo+ID4gZnMvbmZzZC9uZnMzeGRyLmPC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHwgNTM4ICsrKysrKysrKysrKysrKysrKy0tLS0t
LS0tLS0tDQo+ID4gLS0tDQo+ID4gZnMvbmZzZC9uZnNwcm9jLmPCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgIHzCoCA3NCArKystLQ0KPiA+IGZzL25mc2QvbmZzc3ZjLmPCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqAgfMKgIDM0IC0tDQo+ID4gZnMvbmZzZC9uZnN4ZHIuY8KgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB8IDM1MCArKysrKysrKysrLS0tLS0tLS0tLS0NCj4gPiBm
cy9uZnNkL3hkci5owqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHzCoCAxMiAr
LQ0KPiA+IGZzL25mc2QveGRyMy5owqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB8
wqAgMjAgKy0NCj4gPiBpbmNsdWRlL2xpbnV4L25mc2FjbC5owqDCoMKgwqDCoMKgwqDCoMKgIHzC
oMKgIDMgKw0KPiA+IGluY2x1ZGUvbGludXgvc3VucnBjL21zZ19wcm90LmggfMKgwqAgMyAtDQo+
ID4gaW5jbHVkZS9saW51eC9zdW5ycGMveGRyLmjCoMKgwqDCoMKgIHzCoCAxMyArLQ0KPiA+IGlu
Y2x1ZGUvdHJhY2UvZXZlbnRzL3N1bnJwYy5owqDCoCB8wqAgMTUgKy0NCj4gPiBpbmNsdWRlL3Vh
cGkvbGludXgvbmZzMy5owqDCoMKgwqDCoMKgIHzCoMKgIDYgKw0KPiA+IDE1IGZpbGVzIGNoYW5n
ZWQsIDY4MCBpbnNlcnRpb25zKCspLCA2MTUgZGVsZXRpb25zKC0pDQo+ID4gDQo+ID4gQ2FuIHlv
dSB0cnkgdG8gbmFpbCBpdCBkb3duIGEgbGl0dGxlPw0KPiANCj4gSSB0b29rIGEgbG9vayBiYWNr
IHRocm91Z2ggbXkgdGVzdGluZyBoaXN0b3J5IGFuZCByZWFsaXplZCBJJ3ZlIHNlZW4NCj4gaXQN
Cj4gZmFpbCBwcmV2aW91c2x5LsKgIFNvIGl0IHdhcyBqdXN0IGNvaW5jaWRlbmNlIHRoYXQgSSBz
YXcgaXQgZmFpbCBhDQo+IGNvdXBsZQ0KPiB0aW1lcyBhZnRlciBhcHBseWluZyB0aGUgc2VyaWVz
IGJ1dCBub3QgYmVmb3JlIHllc3RlcmRheS7CoCBTb3JyeSBmb3INCj4gdGhlDQo+IG5vaXNlIQ0K
PiANCj4gLS1iLg0KDQpKdXN0IGlnbm9yZSBnZW5lcmljLzQ2NS4gQXMgZmFyIGFzIE5GUyBpcyBj
b25jZXJuZWQsIHRoZSB0ZXN0IGhhcw0KdXR0ZXJseSBib3JrZWQgYXNzdW1wdGlvbnMgYWJvdXQg
T19ESVJFQ1Qgb3JkZXJpbmcuDQoNCi0tIA0KVHJvbmQgTXlrbGVidXN0DQpMaW51eCBORlMgY2xp
ZW50IG1haW50YWluZXIsIEhhbW1lcnNwYWNlDQp0cm9uZC5teWtsZWJ1c3RAaGFtbWVyc3BhY2Uu
Y29tDQoNCg0K

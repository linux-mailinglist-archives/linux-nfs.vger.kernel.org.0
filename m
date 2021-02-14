Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B99831B1E5
	for <lists+linux-nfs@lfdr.de>; Sun, 14 Feb 2021 19:20:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229788AbhBNSTp (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sun, 14 Feb 2021 13:19:45 -0500
Received: from mail-bn8nam12on2112.outbound.protection.outlook.com ([40.107.237.112]:59776
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229792AbhBNSTp (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Sun, 14 Feb 2021 13:19:45 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MLszYXIC8Z4uRiOza0vy3iUOOEA/Ub4vDtUcuQx4yA6EHNjsxuV9zVPwoG49KcnhBfaUxsrlvGA72vfDzC3+ahJPyfFEDE+gy8RoKhEu4itxlNPTOpN3H2vuRI8pKcXKdLC9xYHnH4h4ABGMYdnpw92AHULbY6ebIJ8ebLInOMjFwCYTNxL3PGQgbZUptn9E4wTceTUvWCoptsqhm9tkDSVPGDAgdtSRJhpCnSbab6GLvxKXAARYTq2VbqdliOzRszx3zBi++P973uCVFr8Sv1Gdb3pQNrq75AoqqboRWRu7DAajoqQrnVWwMAihw5RjW3Ux++WscHg9gcqgIIdzDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PkHthK0exvUGw1zvFgKlK36KpIahyZosKN6YSZGDGrk=;
 b=gNgQv5v/pWcui3p1EmdjXkuBRcelPSep34wb82DqKq/xk1OjNL2Cugj3UsznRLuvaqq2BQCsriPCbcwnxglROWEwcXo1+6EWujgVnkendI5+rgzGoKb56MWIjQU5vEjWh1rb84inGIF/Xz4GgUMEY8B4A/5TJk5/HOGiUPJZk8AJEPCfQKlxhaMLJAE8szwfmfKudit3gDBRvce9TUXahb4ZRQY40dHFTI8gou8aLy7h8MkvfLT4s+K9dIqZVQ++xIkCkBQ4TLcXP7tMKmIadT0JcUpQwhwOsDZH9T1I2Y8tMYAs/3oAXHzyOPRmLN74Qg8IYFI/voVnErKwMxGAxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PkHthK0exvUGw1zvFgKlK36KpIahyZosKN6YSZGDGrk=;
 b=HWBtP3SPDwkgqEBs4U/S4lQJoW15WkN8WNyvtj++VYKMWkk+OOWyTRQ/tKKNNoMjw2o/Lz3fJog6W/eJ8aHm2AAJlWmdpuC00FeHW6iUJb2INXHcMOqrdiLh7+2G+iRu/B4IGSIq6fudY7ck7A74uu/knIrvy9ZqJO1YS2eaW20=
Received: from CH2PR13MB3525.namprd13.prod.outlook.com (52.132.231.221) by
 CH0PR13MB4731.namprd13.prod.outlook.com (13.101.45.179) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3868.11; Sun, 14 Feb 2021 18:18:50 +0000
Received: from CH2PR13MB3525.namprd13.prod.outlook.com
 ([fe80::f453:2dd2:675:d063]) by CH2PR13MB3525.namprd13.prod.outlook.com
 ([fe80::f453:2dd2:675:d063%3]) with mapi id 15.20.3868.019; Sun, 14 Feb 2021
 18:18:50 +0000
From:   Trond Myklebust <trondmy@hammerspace.com>
To:     "chuck.lever@oracle.com" <chuck.lever@oracle.com>
CC:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "bfields@redhat.com" <bfields@redhat.com>
Subject: Re: [PATCH] SUNRPC: Use TCP_CORK to optimise send performance on the
 server
Thread-Topic: [PATCH] SUNRPC: Use TCP_CORK to optimise send performance on the
 server
Thread-Index: AQHXAkaKHQ4x2Pj5G0O0h0qlFPlIMKpWoMuAgAAErYCAABZIAIABGpiAgAAShICAAAOxAIAABPGAgAAFo4A=
Date:   Sun, 14 Feb 2021 18:18:50 +0000
Message-ID: <531d2cc4836f95c07b2a41c4bb1eb7d5306208d1.camel@hammerspace.com>
References: <20210213202532.23146-1-trondmy@kernel.org>
         <952C605B-C072-4C6B-B9C0-88C25A3B891E@oracle.com>
         <f025fa709f923255b9cb8e76a9b5ad4cca9355c4.camel@hammerspace.com>
         <4CD2739A-D39B-48C9-BCCF-A9DF1047D507@oracle.com>
         <8ce015080f2f4eb57a81e10041947ad7e6f31499.camel@hammerspace.com>
         <C3A48B63-63AF-4308-A499-15665AB2FF9C@oracle.com>
         <6f49449343dc7ee4efda1c9d9cc56d272c984502.camel@hammerspace.com>
         <BE094630-AA8E-4C7E-ACF8-B153AECA2EDA@oracle.com>
In-Reply-To: <BE094630-AA8E-4C7E-ACF8-B153AECA2EDA@oracle.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: oracle.com; dkim=none (message not signed)
 header.d=none;oracle.com; dmarc=none action=none header.from=hammerspace.com;
x-originating-ip: [68.36.133.222]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0f3af60c-7e89-4937-ccce-08d8d114faba
x-ms-traffictypediagnostic: CH0PR13MB4731:
x-microsoft-antispam-prvs: <CH0PR13MB4731B7A592BCDE2BCA4DD910B8899@CH0PR13MB4731.namprd13.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: D/OCKamM4tREiDQEAkDyqZchXwLgUWDETKnJGmQLa0EzfehB9FGaGvqIJdSwAzhYhVs8LUcTamHP83MV1PFSlXyhSkX6EO6eWPWgm/AiXbH3P4xZOvVxGZFb5Y35b3eUjdARqp71DYfcYdhIwmQaupxhQxOVQns6ZYw++bEfbnIsShiVOoWc93HwQ8LGAmsRX6RItL8hhE0Lu7DxOpkmpdq6xyU7TvTGsc6FoQTg0U4IZYAixW+DtkLiao+2rSkcz34CS38iTl2bQmwPgiQKHiEnSKuOONyq9s51hrkQqWPG6lHAAtBhzK5lvSBy5cp2pfpkrg+YaYDFlJAmvTX4M/S3aLBPWqashGi32GGuNslABjE10cSUD/L5Vq1Ii2rcz74qYqTeQDrKoPS6P7PBdPJzihj0SPGVafrr92otLPaaMuVjYtqxPC6VRDo2mpmDxhl7/Gi7XetG0Fj6XIKedCvZ5tTEC7xGhQ27Bj8CWbMbYyWqmq5RVqpORABXfnwiW797dYcpjNSphzxKCBkQ5w==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR13MB3525.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(376002)(136003)(396003)(346002)(366004)(39830400003)(316002)(5660300002)(53546011)(83380400001)(36756003)(6506007)(54906003)(6916009)(6512007)(6486002)(66946007)(478600001)(64756008)(66446008)(186003)(66556008)(71200400001)(2616005)(4326008)(26005)(86362001)(2906002)(76116006)(8936002)(8676002)(66476007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?utf-8?B?b0ZSVCs3R0t0Wkx6R3VuWDkyUVQ1c1g4T25kQmdTNEswVkdEQzQxY2dodEZM?=
 =?utf-8?B?VVkwVnZBS00wcldGTXF6MjBUaXp2Tk4xQ2Z5YThyZVpIUGFhNmU3WUJINCtm?=
 =?utf-8?B?Y240KzN6ZGcyZzY0QzhZbDVNOG4yZjdDbVBNOE45VW16b0ZSTi8vc0dKV2F6?=
 =?utf-8?B?cjhtUnFjYnRlVG5WSS9XdFRRaEo3T3VtNzMvTnJXQWNzcXBGb2xZNTY1K3Zj?=
 =?utf-8?B?OW5wdk9nTjY3T1BRenBwbHN5a1JYcUxhZWFYK1lmQk12azhnZ21rdkdVNFRE?=
 =?utf-8?B?NHVjTFNXN2szSjlRUUh2UnI1VnlkMytBTlRPZDRmWG14M0lvS3FPb2htY2hQ?=
 =?utf-8?B?VUM1QmdPVHZaR2x3RmhIL2p4bHhxNWQ0S09sYk9TdHphRVNXV3ZNbU9FME5p?=
 =?utf-8?B?SXZxNnBMWkVybDhPS3pubGtBemVhRFVSTGJTZ0tpR1ptSlV6b0dXN2hJczR4?=
 =?utf-8?B?UTY5bWR5SE9zdm5TMVNadDBKOUpxS0lQOWRXWktYUlljTWRjQWlYS0tPSFp0?=
 =?utf-8?B?RmoyN0FOSlJtMDAxelAwUzhKN1hFSUJVNEltUmlOSHUwTjMzWWZpL3RWbzFS?=
 =?utf-8?B?eURWeG5ESjcrM1J5am51Z0RNMlByekxqSW9qbWV6cVd6RTFjWm1vTWtrakV1?=
 =?utf-8?B?YlV6RDhSZDFMUGVBNy84N1loNnBaNlhYalZoWXFmYTdrTUpEOU5zMDFHS1Fu?=
 =?utf-8?B?VXhMVUdjTXcyYjUyVWdQbzhNS2ExK3V2clVkUmk4eEN5UjRBeEdSc0gyZlNK?=
 =?utf-8?B?QVI5b0JWeGQvV1RQYm4vNlIrRjNwWUg0aVNVNUN4bkNodDVINXo0YWlTM1F3?=
 =?utf-8?B?Z1N4ZlNZMGN4bUlBUG9xcHJ4NlpDdGJiSnFDd25VZzFvOXNvL2J2WndaLy9G?=
 =?utf-8?B?U1A0UkxjVWhtbi91YUJKbndnVlVET0dMK3daRkJIOUl2RmxYRkhXRkhsTDJC?=
 =?utf-8?B?YThJMi9rdDNXN0tZT0R0dDIyZndqeFdKa0dpa2kzY3BpckZ2U1dhOVE3YTRw?=
 =?utf-8?B?eExiaWU2QVo3RS9MQUZOQ3ZINmtxc3lvZEorZDhiL05BQ0lSQlV1a2s2SkpI?=
 =?utf-8?B?ZTB0aVdUa3ZDVit1RFJaNUlMNnpKeGdlbHVtbmw0blVaSEpYalpwTk9HMUJU?=
 =?utf-8?B?TmFWd0Y2YkpGK1BsdjBkL29tbW5mVG9XMHk3MWRsdFowMWdvNDFEZG1ndnNj?=
 =?utf-8?B?eHNuWDAyYzgrQU15cVluaTgrN1ZVQTZQajlCbXA5cGtwQ0RZNDBHb0VBQ0VU?=
 =?utf-8?B?UzBwS3Vkd21QZlpsL1lqbWNCZTYvS0U0Q29qSDNnb3B4Z0pVSS9iUUExa2Fh?=
 =?utf-8?B?TExvUjlHeDNVOVBQcnVxMDg0UG5NZlp0NGNybXJjT3hEQUEva0RwTENjeGN5?=
 =?utf-8?B?WGdBWU1xSkZ1eFR2eUUrYmlpeDA1T0Zjc2xGRzM0TGhaY3puNlpEV2V4THNh?=
 =?utf-8?B?SE9aaWVja2ZDalhTdTFUSUk2aGZ0SmhvaE1YZUVLTWxadUsraDdMNU5sUnNW?=
 =?utf-8?B?SzZncFdKQVdzZC9KQmV3TUtNdVJxUmlGTFNlSnJWaU5wNkVLZ1o0V3RIb29V?=
 =?utf-8?B?MEIzZzlXMklBcGZaeGI5QnJQcCsrdWZZQmpGS1FKd0FhY0tYMnZ6eWE0cTc0?=
 =?utf-8?B?SnRsaGhuTEtvb0RiYUtaY0hrNUFmZHZwWXhYYWV5cHhoNFZySEtvWWxoa0lX?=
 =?utf-8?B?cTNwaWhQRkU4Sis1R0RZWmYxSlcrQThSU2FvelNRV0czclJSOFhiVTA2YllD?=
 =?utf-8?Q?Vh5mz5g/v2ME1DAL/pz2oPtZsG7wQapjjTGWmPu?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <691A1FBBC41EE4488669C406FA5D6396@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH2PR13MB3525.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f3af60c-7e89-4937-ccce-08d8d114faba
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Feb 2021 18:18:50.7053
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ld/79aFYNBW/Otlgw62Jg+maaoKLYh4yAkfBmUPQjloyaMwcxO+IbwihcM9X7PoepafPElCoTBzCxU4DrflYjA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR13MB4731
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

T24gU3VuLCAyMDIxLTAyLTE0IGF0IDE3OjU4ICswMDAwLCBDaHVjayBMZXZlciB3cm90ZToNCj4g
DQo+IA0KPiA+IE9uIEZlYiAxNCwgMjAyMSwgYXQgMTI6NDEgUE0sIFRyb25kIE15a2xlYnVzdCA8
IA0KPiA+IHRyb25kbXlAaGFtbWVyc3BhY2UuY29tPiB3cm90ZToNCj4gPiANCj4gPiBPbiBTdW4s
IDIwMjEtMDItMTQgYXQgMTc6MjcgKzAwMDAsIENodWNrIExldmVyIHdyb3RlOg0KPiA+ID4gDQo+
ID4gPiANCj4gPiA+ID4gT24gRmViIDE0LCAyMDIxLCBhdCAxMToyMSBBTSwgVHJvbmQgTXlrbGVi
dXN0DQo+ID4gPiA+IDx0cm9uZG15QGhhbW1lcnNwYWNlLmNvbT4gd3JvdGU6DQo+ID4gPiA+IA0K
PiA+ID4gPiBPbiBTYXQsIDIwMjEtMDItMTMgYXQgMjM6MzAgKzAwMDAsIENodWNrIExldmVyIHdy
b3RlOg0KPiA+ID4gPiA+IA0KPiA+ID4gPiA+IA0KPiA+ID4gPiA+ID4gT24gRmViIDEzLCAyMDIx
LCBhdCA1OjEwIFBNLCBUcm9uZCBNeWtsZWJ1c3QgPA0KPiA+ID4gPiA+ID4gdHJvbmRteUBoYW1t
ZXJzcGFjZS5jb20+IHdyb3RlOg0KPiA+ID4gPiA+ID4gDQo+ID4gPiA+ID4gPiBPbiBTYXQsIDIw
MjEtMDItMTMgYXQgMjE6NTMgKzAwMDAsIENodWNrIExldmVyIHdyb3RlOg0KPiA+ID4gPiA+ID4g
PiBIaSBUcm9uZC0NCj4gPiA+ID4gPiA+ID4gDQo+ID4gPiA+ID4gPiA+ID4gT24gRmViIDEzLCAy
MDIxLCBhdCAzOjI1IFBNLCB0cm9uZG15QGtlcm5lbC5vcmfCoHdyb3RlOg0KPiA+ID4gPiA+ID4g
PiA+IA0KPiA+ID4gPiA+ID4gPiA+IEZyb206IFRyb25kIE15a2xlYnVzdCA8dHJvbmQubXlrbGVi
dXN0QGhhbW1lcnNwYWNlLmNvbT4NCj4gPiA+ID4gPiA+ID4gPiANCj4gPiA+ID4gPiA+ID4gPiBV
c2UgYSBjb3VudGVyIHRvIGtlZXAgdHJhY2sgb2YgaG93IG1hbnkgcmVxdWVzdHMgYXJlDQo+ID4g
PiA+ID4gPiA+ID4gcXVldWVkDQo+ID4gPiA+ID4gPiA+ID4gYmVoaW5kDQo+ID4gPiA+ID4gPiA+
ID4gdGhlDQo+ID4gPiA+ID4gPiA+ID4geHBydC0+eHB0X211dGV4LCBhbmQga2VlcCBUQ1BfQ09S
SyBzZXQgdW50aWwgdGhlIHF1ZXVlDQo+ID4gPiA+ID4gPiA+ID4gaXMNCj4gPiA+ID4gPiA+ID4g
PiBlbXB0eS4NCj4gPiA+ID4gPiA+ID4gDQo+ID4gPiA+ID4gPiA+IEknbSBpbnRyaWd1ZWQsIGJ1
dCBJTU8sIHRoZSBwYXRjaCBkZXNjcmlwdGlvbiBuZWVkcyB0bw0KPiA+ID4gPiA+ID4gPiBleHBs
YWluDQo+ID4gPiA+ID4gPiA+IHdoeSB0aGlzIGNoYW5nZSBzaG91bGQgYmUgbWFkZS4gV2h5IGFi
YW5kb24gTmFnbGU/DQo+ID4gPiA+ID4gPiA+IA0KPiA+ID4gPiA+ID4gDQo+ID4gPiA+ID4gPiBU
aGlzIGRvZXNuJ3QgY2hhbmdlIHRoZSBOYWdsZS9UQ1BfTk9ERUxBWSBzZXR0aW5ncy4gSXQganVz
dA0KPiA+ID4gPiA+ID4gc3dpdGNoZXMgdG8NCj4gPiA+ID4gPiA+IHVzaW5nIHRoZSBuZXcgZG9j
dW1lbnRlZCBrZXJuZWwgaW50ZXJmYWNlLg0KPiA+ID4gPiA+ID4gDQo+ID4gPiA+ID4gPiBUaGUg
b25seSBjaGFuZ2UgaXMgdG8gdXNlIFRDUF9DT1JLIHNvIHRoYXQgd2UgZG9uJ3Qgc2VuZA0KPiA+
ID4gPiA+ID4gb3V0DQo+ID4gPiA+ID4gPiBwYXJ0aWFsbHkNCj4gPiA+ID4gPiA+IGZpbGxlZCBU
Q1AgZnJhbWVzLCB3aGVuIHdlIGNhbiBzZWUgdGhhdCB0aGVyZSBhcmUgb3RoZXIgUlBDDQo+ID4g
PiA+ID4gPiByZXBsaWVzDQo+ID4gPiA+ID4gPiB0aGF0IGFyZSBxdWV1ZWQgdXAgZm9yIHRyYW5z
bWlzc2lvbi4NCj4gPiA+ID4gPiA+IA0KPiA+ID4gPiA+ID4gTm90ZSB0aGUgY29tYmluYXRpb24g
VENQX0NPUksrVENQX05PREVMQVkgaXMgY29tbW9uLCBhbmQNCj4gPiA+ID4gPiA+IHRoZQ0KPiA+
ID4gPiA+ID4gbWFpbg0KPiA+ID4gPiA+ID4gZWZmZWN0IG9mIHRoZSBsYXR0ZXIgaXMgdGhhdCB3
aGVuIHdlIHR1cm4gb2ZmIHRoZSBUQ1BfQ09SSywNCj4gPiA+ID4gPiA+IHRoZW4NCj4gPiA+ID4g
PiA+IHRoZXJlDQo+ID4gPiA+ID4gPiBpcyBhbiBpbW1lZGlhdGUgZm9yY2VkIHB1c2ggb2YgdGhl
IFRDUCBxdWV1ZS4NCj4gPiA+ID4gPiANCj4gPiA+ID4gPiBUaGUgZGVzY3JpcHRpb24gYWJvdmUg
c3VnZ2VzdHMgdGhlIHBhdGNoIGlzIGp1c3QgYQ0KPiA+ID4gPiA+IGNsZWFuLXVwLCBidXQgYSBm
b3JjZWQgcHVzaCBoYXMgcG90ZW50aWFsIHRvIGNoYW5nZQ0KPiA+ID4gPiA+IHRoZSBzZXJ2ZXIn
cyBiZWhhdmlvci4NCj4gPiA+ID4gDQo+ID4gPiA+IFdlbGwsIHllcy4gVGhhdCdzIHZlcnkgbXVj
aCB0aGUgcG9pbnQuDQo+ID4gPiA+IA0KPiA+ID4gPiBSaWdodCBub3csIHRoZSBUQ1BfTk9ERUxB
WS9OYWdsZSBzZXR0aW5nIG1lYW5zIHRoYXQgd2UncmUgZG9pbmcNCj4gPiA+ID4gdGhhdA0KPiA+
ID4gPiBmb3JjZWQgcHVzaCBhdCB0aGUgZW5kIG9mIF9ldmVyeV8gUlBDIHJlcGx5LCB3aGV0aGVy
IG9yIG5vdA0KPiA+ID4gPiB0aGVyZQ0KPiA+ID4gPiBpcw0KPiA+ID4gPiBtb3JlIHN0dWZmIHRo
YXQgY2FuIGJlIHF1ZXVlZCB1cCBpbiB0aGUgc29ja2V0LiBUaGUgTVNHX01PUkUgaXMNCj4gPiA+
ID4gdGhlDQo+ID4gPiA+IG9ubHkgdGhpbmcgdGhhdCBrZWVwcyB1cyBmcm9tIGRvaW5nIHRoZSBm
b3JjZWQgcHVzaCBvbiBldmVyeQ0KPiA+ID4gPiBzZW5kcGFnZSgpDQo+ID4gPiA+IGNhbGwuDQo+
ID4gPiA+IFNvIHRoZSBUQ1BfQ09SSyBpcyB0aGVyZSB0byBfZnVydGhlciBkZWxheV8gdGhhdCBm
b3JjZWQgcHVzaA0KPiA+ID4gPiB1bnRpbA0KPiA+ID4gPiB3ZQ0KPiA+ID4gPiB0aGluayB0aGUg
cXVldWUgaXMgZW1wdHkuDQo+ID4gPiANCj4gPiA+IE15IGNvbmNlcm4gaXMgdGhhdCB3YWl0aW5n
IGZvciB0aGUgcXVldWUgdG8gZW1wdHkgYmVmb3JlIHB1c2hpbmcNCj4gPiA+IGNvdWxkDQo+ID4g
PiBpbXByb3ZlIHRocm91Z2hwdXQgYXQgdGhlIGNvc3Qgb2YgaW5jcmVhc2VkIGF2ZXJhZ2Ugcm91
bmQtdHJpcA0KPiA+ID4gbGF0ZW5jeS4NCj4gPiA+IFRoYXQgY29uY2VybiBpcyBiYXNlZCBvbiBl
eHBlcmllbmNlIEkndmUgaGFkIGF0dGVtcHRpbmcgdG8gYmF0Y2gNCj4gPiA+IHNlbmRzDQo+ID4g
PiBpbiB0aGUgUkRNQSB0cmFuc3BvcnQuDQo+ID4gPiANCj4gPiA+IA0KPiA+ID4gPiBJT1c6IGl0
IGF0dGVtcHRzIHRvIG9wdGltaXNlIHRoZSBzY2hlZHVsaW5nIG9mIHRoYXQgcHVzaCB1bnRpbA0K
PiA+ID4gPiB3ZSdyZQ0KPiA+ID4gPiBhY3R1YWxseSBkb25lIHB1c2hpbmcgbW9yZSBzdHVmZiBp
bnRvIHRoZSBzb2NrZXQuDQo+ID4gPiANCj4gPiA+IFllcCwgY2xlYXIsIHRoYW5rcy4gSXQgd291
bGQgaGVscCBhIGxvdCBpZiB0aGUgYWJvdmUgd2VyZQ0KPiA+ID4gaW5jbHVkZWQgaW4NCj4gPiA+
IHRoZSBwYXRjaCBkZXNjcmlwdGlvbi4NCj4gPiA+IA0KPiA+ID4gQW5kLCBJIHByZXN1bWUgdGhh
dCB0aGUgVENQIGxheWVyIHdpbGwgcHVzaCBhbnl3YXkgaWYgaXQgbmVlZHMgdG8NCj4gPiA+IHJl
Y2xhaW0gcmVzb3VyY2VzIHRvIGhhbmRsZSBtb3JlIHF1ZXVlZCBzZW5kcy4NCj4gPiA+IA0KPiA+
ID4gTGV0J3MgYWxzbyBjb25zaWRlciBzdGFydmF0aW9uOyBpZSwgdGhhdCB0aGUgc2VydmVyIHdp
bGwgY29udGludWUNCj4gPiA+IHF1ZXVpbmcgcmVwbGllcyBzdWNoIHRoYXQgaXQgbmV2ZXIgdW5j
b3Jrcy4gVGhlIGxvZ2ljIGluIHRoZQ0KPiA+ID4gcGF0Y2gNCj4gPiA+IGFwcGVhcnMgdG8gZGVw
ZW5kIG9uIHRoZSBjbGllbnQgc3RvcHBpbmcgYXQgc29tZSBwb2ludCB0byB3YWl0DQo+ID4gPiBm
b3INCj4gPiA+IHRoZQ0KPiA+ID4gc2VydmVyIHRvIGNhdGNoIHVwLiBUaGVyZSBwcm9iYWJseSBz
aG91bGQgYmUgYSB0cmFwIGRvb3IgdGhhdA0KPiA+ID4gdW5jb3Jrcw0KPiA+ID4gYWZ0ZXIgYSBm
ZXcgcmVxdWVzdHMgKHNheSwgOCkgb3IgY2VydGFpbiBudW1iZXIgb2YgYnl0ZXMgYXJlDQo+ID4g
PiBwZW5kaW5nDQo+ID4gPiB3aXRob3V0IGEgYnJlYWsuDQo+ID4gDQo+ID4gU28sIGZpcnN0bHks
IHRoZSBUQ1AgbGF5ZXIgd2lsbCBzdGlsbCBwdXNoIGV2ZXJ5IHRpbWUgYSBmcmFtZSBpcw0KPiA+
IGZ1bGwsDQo+ID4gc28gdHJhZmZpYyBkb2VzIG5vdCBzdG9wIGFsdG9nZXRoZXIgd2hpbGUgVENQ
X0NPUksgaXMgc2V0Lg0KPiANCj4gT0suDQo+IA0KPiANCj4gPiBTZWNvbmRseSwgVENQIHdpbGwg
YWxzbyBhbHdheXMgcHVzaCBvbiBzZW5kIGVycm9ycyAoZS5nLiB3aGVuIG91dA0KPiA+IG9mIGZy
ZWUgc29ja2V0DQo+ID4gYnVmZmVyKS4NCj4gDQo+IEFzIEkgcHJlc3VtZWQuIE9LLg0KPiANCj4g
DQo+ID4gVGhpcmRseSwgaXQgd2lsbCBhbHdheXMgcHVzaCBhZnRlciBoaXR0aW5nIHRoZSAyMDBt
cyBjZWlsaW5nLA0KPiA+IGFzIGRlc2NyaWJlZCBpbiB0aGUgdGNwKDcpIG1hbnBhZ2UuDQo+IA0K
PiBUaGF0J3MgdGhlIHRyYXAgZG9vciB3ZSBuZWVkIHRvIGVuc3VyZSBubyBzdGFydmF0aW9uIG9y
IGRlYWRsb2NrLA0KPiBhc3N1bWluZyB0aGVyZSBhcmUgbm8gYnVncyBpbiB0aGUgVENQIGxheWVy
J3MgbG9naWMuDQo+IA0KPiAyMDBtcyBzZWVtcyBhIGxvbmcgdGltZSB0byB3YWl0LCB0aG91Z2gs
IHdoZW4gYXZlcmFnZSByb3VuZCB0cmlwDQo+IGxhdGVuY2llcyBhcmUgdXN1YWxseSB1bmRlciAx
bXMgb24gdHlwaWNhbCBFdGhlcm5ldC4gSXQgd291bGQgYmUNCj4gZ29vZCB0byBrbm93IGhvdyBv
ZnRlbiBzZW5kaW5nIGhhcyB0byB3YWl0IHRoaXMgbG9uZy4NCg0KSWYgaXQgZG9lcyB3YWl0IHRo
YXQgbG9uZywgdGhlbiBpdCB3b3VsZCBiZSBiZWNhdXNlIHRoZSBzeXN0ZW0gaXMgdW5kZXINCnN1
Y2ggbG9hZCB0aGF0IHNjaGVkdWxpbmcgdGhlIG5leHQgdGFzayB3YWl0aW5nIGZvciB0aGUgeHB0
X211dGV4IGlzDQp0YWtpbmcgbW9yZSB0aGFuIDIwMG1zLiBJIGRvbid0IHNlZSBob3cgdGhpcyB3
b3VsZCBtYWtlIHRoaW5ncyBhbnkNCndvcnNlLg0KDQo+ID4gSU9XOiBUaGUgVENQX0NPUksgZmVh
dHVyZSBpcyBub3QgZGVzaWduZWQgdG8gYmxvY2sgdGhlIHNvY2tldA0KPiA+IGZvcmV2ZXIuDQo+
ID4gSXQgaXMgdGhlcmUgdG8gYWxsb3cgdGhlIGFwcGxpY2F0aW9uIHRvIGhpbnQgdG8gdGhlIFRD
UCBsYXllciB3aGF0DQo+ID4gaXQNCj4gPiBuZWVkcyB0byBkbyBpbiBleGFjdGx5IHRoZSBzYW1l
IHdheSB0aGF0IE1TR19NT1JFIGRvZXMuDQo+IA0KPiBBcyBsb25nIGFzIGl0IGlzIG9ubHkgYSBo
aW50LCB0aGVuIHdlJ3JlIGdvb2QuDQo+IA0KPiBPdXQgb2YgaW50ZXJlc3QsIHdoeSBub3QgdXNl
IG9ubHkgTVNHX01PUkUsIG9yIHJlbW92ZSB0aGUgdXNlDQo+IG9mIE1TR19NT1JFIGluIGZhdm9y
IG9mIG9ubHkgY29yaz8gSWYgdGhlc2UgYXJlIGVzc2VudGlhbGx5IHRoZQ0KPiBzYW1lIG1lY2hh
bmlzbSwgc2VlbXMgbGlrZSB3ZSBuZWVkIG9ubHkgb25lIG9yIHRoZSBvdGhlci4NCj4gDQoNClRo
ZSBhZHZhbnRhZ2Ugb2YgVENQX0NPUksgaXMgdGhhdCB5b3UgY2FuIHBlcmZvcm0gdGhlIHF1ZXVl
IGxlbmd0aA0KZXZhbHVhdGlvbiBfYWZ0ZXJfIHRoZSBzZW5kbXNnL3NlbmRwYWdlL3dyaXRldiBj
YWxsLiBTaW5jZSBhbGwgb2YgdGhvc2UNCmNhbiBibG9jayBkdWUgdG8gbWVtb3J5IGFsbG9jYXRp
b24sIHNvY2tldCBidWZmZXIgc2hvcnRhZ2UsIGV0YywgdGhlbg0KaXQgaXMgcXVpdGUgbGlrZWx5
IHVuZGVyIG1hbnkgd29ya2xvYWRzIHRoYXQgb3RoZXIgUlBDIGNhbGxzIG1heSBoYXZlDQp0aW1l
IHRvIGZpbmlzaCBwcm9jZXNzaW5nIGFuZCBnZXQgcXVldWVkIHVwLg0KDQpJIGFncmVlIHRoYXQg
d2UgcHJvYmFibHkgY291bGQgcmVtb3ZlIE1TR19NT1JFIGZvciB0Y3Agb25jZSBUQ1BfQ09SSyBp
cw0KaW1wbGVtZW50ZWQuIEhvd2V2ZXIgdGhvc2UgZmxhZ3MgY29udGludWUgdG8gYmUgdXNlZnVs
IGZvciB1ZHAuDQoNCi0tIA0KVHJvbmQgTXlrbGVidXN0DQpMaW51eCBORlMgY2xpZW50IG1haW50
YWluZXIsIEhhbW1lcnNwYWNlDQp0cm9uZC5teWtsZWJ1c3RAaGFtbWVyc3BhY2UuY29tDQoNCg0K

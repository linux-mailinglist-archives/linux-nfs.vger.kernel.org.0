Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB3313AF5D0
	for <lists+linux-nfs@lfdr.de>; Mon, 21 Jun 2021 21:06:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231416AbhFUTJL (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 21 Jun 2021 15:09:11 -0400
Received: from mail-co1nam11on2130.outbound.protection.outlook.com ([40.107.220.130]:11361
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231288AbhFUTJK (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Mon, 21 Jun 2021 15:09:10 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=m8ugLLZJpCFlCL+AlL43S2arq8Gij0JlHqavNT+r7MQGeyTNDCsfD3LM6hYKGqxLCnlA5ldCgACyTjBfbhfPzcFquKnCoyPoVlT56NioZMsv0eWfnW6wTRBOjarIRp6lPxByUh3jl9W1hpeY10qvBfeVNevwS+KK+LYPgpnx/PSnE2hbFAAz7ByLgqts6mni/XvZcCfH+WO9y+WCNXsQrTRddofsIQ+BqoJVAJPEzVa3CbLIAT0u3M+belTjJo3fa8tI75Zj0FT2kkgeokYu4g+ixlANXlYC5sSsqYr7t2OvrfD3GHSPBfbTPgxyQhbE+jqgfNmAWhB7vSz0mtEQVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vCs4x1eeFpil/nCfXHDVI2NYzaSaNpBSGyEiXj+tzS0=;
 b=AxAFibiBLw5lajJiKKsjrzzkD5NxDP3BmZMSxKt+KJT9+YofK7ZHtaIVwx1r0X/TzfjMcJJRJGuU84MtyR9acGcvgc1Ipv2QNCHOQRLzz2bVrtflhCh/55i4gNQiOV2hE7d1lMHKE7Uz9CULfcHAmhDXnGa63RC92u86fawsnXv5g1lQjYbRaZakCcAii+QJsXe47iPyebxu6aDsnPmFHLfNBRmXWoSkhZTRBxYFimygeHtzK1mOdjxmjX+yRCsgDG0aebhCLTP3uzJjy/Vi9bqe3qTD4KZCM6+IDU6fg93xa4x8lVfcqjyiKp8m4zweb4ld94P05S/diMazpRm2lA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vCs4x1eeFpil/nCfXHDVI2NYzaSaNpBSGyEiXj+tzS0=;
 b=Pg+QFf7A+IxZ+JENgi0lRH4p+qM2eFqxqFA/N5CYR1QxnFU358+yOm1H1kdlAsrO1eMFArFJFJqkUS3Fa8FOdIGV0zZaWpUEaDzJhOCy3dWzgVOc/5MB00swMHewmCBYI4YTYLfqXn+BE1ldz8qhXjvefscq3QmMVXY2ohfXXFk=
Received: from CH0PR13MB5084.namprd13.prod.outlook.com (2603:10b6:610:111::7)
 by CH2PR13MB4410.namprd13.prod.outlook.com (2603:10b6:610:64::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4264.11; Mon, 21 Jun
 2021 19:06:52 +0000
Received: from CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::cc40:f406:86f9:3e05]) by CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::cc40:f406:86f9:3e05%4]) with mapi id 15.20.4264.017; Mon, 21 Jun 2021
 19:06:52 +0000
From:   Trond Myklebust <trondmy@hammerspace.com>
To:     "chuck.lever@oracle.com" <chuck.lever@oracle.com>
CC:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "bfields@redhat.com" <bfields@redhat.com>,
        "trondmy@kernel.org" <trondmy@kernel.org>
Subject: Re: [PATCH] nfsd: Reduce contention for the nfsd_file nf_rwsem
Thread-Topic: [PATCH] nfsd: Reduce contention for the nfsd_file nf_rwsem
Thread-Index: AQHXY9BFOPrj5d3Km06dLrDzFdiFU6sesysAgAATu4CAAAe0gIAACvSA
Date:   Mon, 21 Jun 2021 19:06:52 +0000
Message-ID: <b49ec15528377bfa2f4707610440e9da73ea7456.camel@hammerspace.com>
References: <20210617232652.264884-1-trondmy@kernel.org>
         <1669C849-D7DC-46C1-B6B6-F2C79C819710@oracle.com>
         <ff7400e35ec0b227de4546c608d231caed921d5b.camel@hammerspace.com>
         <F48D54BC-24F6-4E92-9C1E-773E5C5E29DA@oracle.com>
In-Reply-To: <F48D54BC-24F6-4E92-9C1E-773E5C5E29DA@oracle.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: oracle.com; dkim=none (message not signed)
 header.d=none;oracle.com; dmarc=none action=none header.from=hammerspace.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 54b02919-8a40-4ab5-51e0-08d934e7bacf
x-ms-traffictypediagnostic: CH2PR13MB4410:
x-microsoft-antispam-prvs: <CH2PR13MB441027E7C1F8FBD7B7463FF5B80A9@CH2PR13MB4410.namprd13.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: QQPsNxXpQqO3UHWhviQ999ncSeCL+Logebwt68oLgLXvXb4o7ovnT46rnf6/xWmsfcA9BlMrelVYNWMuFlx6u89ChlXavCqI5fR9H6oRr4Zecv1Wt8WiHFqww7OLNYdi4khqqftsjris6xMdPQXq9e9QhkvWQvO3dgFq8BP+PZzqTbMc2/GcC1lYKHpSyMZluSrwA+MuregtuqVS9917ikbWpi0V2XaXyBz9ZZ91cWHKtfW9J6UXR5vMF4IZvFDnj+YbKANX1151XL0VSYsfKnQJOk5jKyxPH2gAvfFCa2LVD7lWi4gSqxEgvdRxcQxjkeOetSw8BjgzMZJsEMd2NFR8Gw1zLKSKEi6smCFrfKvED3RihTuVDALTiOCSv5jaAQgrtN/+PMvOZ9p0jLsA/cns7jJ33PgDGxnx4zT5i7NgyqaYzt8IKA/hTg0zDlhJ0E0OGcpGZGZ6rCGVZaDBKcI2GY0dASj6cOLeaUa5sccjwpr50bmyq6jX3XGReSR0i0kfdflYB5/luLYo6bESY2GY4e8ye+qxp86r0zfRhFhJS+KzEWxv3QK75kFHsIuyGXopykkApaJ94csZPXa6uJyj7vZnA5R646R07JQtH9Qs8mBzc4hDILljiBatIFtWXY4N/rUPOSVnz9lydgemxiL7LTAlBOfxzLHMw1jf8lzWypsXz4Mm79iOfl+nQJ3GxwJkC9AwmCF9DxmUJ1fppcbw07dzwAZzygWcDxANuGI=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR13MB5084.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(39830400003)(366004)(376002)(396003)(136003)(6486002)(83380400001)(54906003)(122000001)(316002)(6512007)(5660300002)(15974865002)(71200400001)(38100700002)(53546011)(2906002)(6506007)(26005)(66556008)(478600001)(8676002)(6916009)(8936002)(186003)(4326008)(66946007)(2616005)(86362001)(36756003)(66446008)(66476007)(76116006)(64756008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cXJmTkNtUDVqZkJlRCtqTkNEa3lxdUFwWlRzaGtML3NvakVXaVYxWVhrcWVC?=
 =?utf-8?B?L29LNisydHN6ajAxZ3ZWNXpMU3VOVFdyY2NmV3hPNEE0aUV6MHFtSDhheUhq?=
 =?utf-8?B?R3BPM2w0eE0xb3lrcmtmcEJZSkErdWQ5ZUd3QTMyNExIM2UrbWl1NGtiODdz?=
 =?utf-8?B?ZjljWTZGTVBZZUZtWFFmSDRqVE9nK0IwcHBUK3lNcTkrcTdDRFU3ZWI4VmRN?=
 =?utf-8?B?SUEvSCt6RTcvQlloaTNHcGxHUVZXL08yUUlKOEM0VVlTRXRIU282Y3RQeUpH?=
 =?utf-8?B?Ti9kUTdNK1kvSklLd3VseVJrQXZ5d2xaUy9vWEdiSXdIRkJ3aEVldGtNVm9a?=
 =?utf-8?B?c1N2L05ONTNsYXhDYU1lZmNUR0ZoaUF5ODdlc2ZHQlh3QU1pMWxvZ0FtR0Zx?=
 =?utf-8?B?emhGUTN4VDFpamIvbHB2WVdHM1pjRHMySENwNXZ5VXhKa0l3azFjcTRzb3ph?=
 =?utf-8?B?VGpsdGM0a1pqS3h2dGtseWpIaEw0MkZxdTlPbGk2YkVUeXRGaUR5REFuSk9W?=
 =?utf-8?B?RG9ncW5LaVIzakhkWXhwQ204U09wV0VtR25qUE9rRFN0K09JNnJBYWhQekdL?=
 =?utf-8?B?czRyOXI2bHc5bW0wVVM5bFR5bHhIdHFRUGdpcC80S0w1RGppTFV4L2hydTlZ?=
 =?utf-8?B?eGpwVTcwVENBQlNSUS9jR1hiek1ZT2xFWkcrRlZCYkhYTDdZdnNZNzh0Y21S?=
 =?utf-8?B?dUYrSXRtZDVZNVdmZzl1MXdwKzRrV09SeXM1VFROZ2dJZXkwVXVmTHdaWWp2?=
 =?utf-8?B?M200Y3lZRDEydXBwTlNvd2kvankwQnV1eG9tVXpRWXl5ZlBYNWNPVjBVVGJG?=
 =?utf-8?B?L2JIUkJ3ZDdWbnZmeVlYK240UXRHRUtDYUx1WFZ4QW9JS3FIdjJya0NKQWZz?=
 =?utf-8?B?OUNnREZIbVdaWUpmd05RaDRnY3lvQXZadW1NU0hkUUhHSUp3Yit2S201ZXdZ?=
 =?utf-8?B?OWpnbFpMSFhFczJFWmhzOFYyZUs0c2dQZDZmcUZxWjYvRUFjSFZ2VzlDMVYy?=
 =?utf-8?B?SEZYZ0xXTDNLbllVS0xlcmN6eDlUWDVVeVBiR2JKVWY0czRMcTBjbmtrRGVz?=
 =?utf-8?B?YXUwdHE5UWg3TVZYZUk1QnNkUW82UWUxR2hzZW9OTW1xSVYwazJGOUwyWEp5?=
 =?utf-8?B?WnNpcVdYMzg4RlJzY1VTRDZ1Y0hQTGRDSyt6a29rK042VmRkUVNSTVk3UXMy?=
 =?utf-8?B?T2F4dGlxZTBMUHZSNUFtNWNIUURQWWNTZmhZWFo5Z3ZYaXNDUGNvbzQ1Q0FI?=
 =?utf-8?B?VlQyVGFESFFRdTVYMmUwSkE5djhYaEE5U3ZJcUVzUEZJb1ltUGRPelA1ZWlv?=
 =?utf-8?B?eFFRMGh0T3BIWWlScmxmU05qRHJIbzVVaGd1VXN4djZPb0FRejFWeE9sdnFs?=
 =?utf-8?B?TlFJUDVNdm9wWU1ReEpXTE5CQjlXcklpbzdJRHEwOWZ3QUdYYUprL1E2OWZr?=
 =?utf-8?B?cFBwRHRSclYyMVlrK0x6MXJFbCt1M0p6TDhoK2RUQVFpUUZYSFZaL0FJemkx?=
 =?utf-8?B?MUQ1aG9jVFNDTXFZYXIvWG5MaThZa09DaitZZzM2R3crSkhsT1hReDN3VVVk?=
 =?utf-8?B?eWhmZi84Y014S2hrakJZRnZqbGh2aWhBbnFNSlNhT29Qa3ZONFpJc2RYWGx4?=
 =?utf-8?B?dEVjSytBMVVmQTFzODVYV1RaTFZON01CSnk0aWVSbU53OWJaS0J5MXczdEZE?=
 =?utf-8?B?czZJNU9tbVFBdzJCenNTN01vNEZuMlZ2enRhTEJrbm5yZ1NJeVpNNlN1SHhO?=
 =?utf-8?Q?9gtJ6BzAgCt0zHRrk34UxmhlaXpI4EKXsSTY9eY?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <E3C3F4307C18F44C919CF719C28A658B@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR13MB5084.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 54b02919-8a40-4ab5-51e0-08d934e7bacf
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jun 2021 19:06:52.5157
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NDQwH5GjfraCP6cNoKKLDx1oVAkgDBDFpheTwG5ziec0VFf+9uXY+AiCg0EblIXtzq8ShBV4TjLHYk+qOHuAbg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR13MB4410
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

T24gTW9uLCAyMDIxLTA2LTIxIGF0IDE4OjI3ICswMDAwLCBDaHVjayBMZXZlciBJSUkgd3JvdGU6
DQo+IA0KPiANCj4gPiBPbiBKdW4gMjEsIDIwMjEsIGF0IDI6MDAgUE0sIFRyb25kIE15a2xlYnVz
dA0KPiA+IDx0cm9uZG15QGhhbW1lcnNwYWNlLmNvbT4gd3JvdGU6DQo+ID4gDQo+ID4gT24gTW9u
LCAyMDIxLTA2LTIxIGF0IDE2OjQ5ICswMDAwLCBDaHVjayBMZXZlciBJSUkgd3JvdGU6DQo+ID4g
PiBIaS0NCj4gPiA+IA0KPiA+ID4gPiBPbiBKdW4gMTcsIDIwMjEsIGF0IDc6MjYgUE0sIHRyb25k
bXlAa2VybmVsLm9yZ8Kgd3JvdGU6DQo+ID4gPiA+IA0KPiA+ID4gPiBGcm9tOiBUcm9uZCBNeWts
ZWJ1c3QgPHRyb25kLm15a2xlYnVzdEBoYW1tZXJzcGFjZS5jb20+DQo+ID4gPiA+IA0KPiA+ID4g
PiBXaGVuIGZsdXNoaW5nIG91dCB0aGUgdW5zdGFibGUgZmlsZSB3cml0ZXMgYXMgcGFydCBvZiBh
IENPTU1JVA0KPiA+ID4gPiBjYWxsLCB0cnkNCj4gPiA+ID4gdG8gcGVyZm9ybSBtb3N0IG9mIG9m
IHRoZSBkYXRhIHdyaXRlcyBhbmQgd2FpdHMgb3V0c2lkZSB0aGUNCj4gPiA+ID4gc2VtYXBob3Jl
Lg0KPiA+ID4gPiANCj4gPiA+ID4gVGhpcyBtZWFucyB0aGF0IGlmIHRoZSBjbGllbnQgaXMgc2Vu
ZGluZyB0aGUgQ09NTUlUIGFzIHBhcnQgb2YNCj4gPiA+ID4gYQ0KPiA+ID4gPiBtZW1vcnkNCj4g
PiA+ID4gcmVjbGFpbSBvcGVyYXRpb24sIHRoZW4gaXQgY2FuIGNvbnRpbnVlIHBlcmZvcm1pbmcg
SS9PLCB3aXRoDQo+ID4gPiA+IGNvbnRlbnRpb24NCj4gPiA+ID4gZm9yIHRoZSBsb2NrIG9jY3Vy
cmluZyBvbmx5IG9uY2UgdGhlIGRhdGEgc3luYyBpcyBmaW5pc2hlZC4NCj4gPiA+ID4gDQo+ID4g
PiA+IEZpeGVzOiA1MDExYWY0YzY5OGEgKCJuZnNkOiBGaXggc3RhYmxlIHdyaXRlcyIpDQo+ID4g
PiA+IFNpZ25lZC1vZmYtYnk6IFRyb25kIE15a2xlYnVzdA0KPiA+ID4gPiA8dHJvbmQubXlrbGVi
dXN0QGhhbW1lcnNwYWNlLmNvbT4NCj4gPiA+IA0KPiA+ID4gVGhlIGdvb2QgbmV3cyBpcyBJJ3Zl
IGZvdW5kIG5vIGZ1bmN0aW9uYWwgcmVncmVzc2lvbnMuIFRoZSBiYWQNCj4gPiA+IG5ld3MgaXMg
SSBoYXZlbid0IHNlZW4gYW55IGRpZmZlcmVuY2UgaW4gcGVyZm9ybWFuY2UuIElzIHRoZXJlDQo+
ID4gPiBhIHBhcnRpY3VsYXIgdGVzdCB0aGF0IEkgY2FuIHJ1biB0byBvYnNlcnZlIGltcHJvdmVt
ZW50Pw0KPiA+IA0KPiA+IEknZCBleHBlY3QgdGhhdCByZS1leHBvcnRlZCBORlMgd291bGQgYmUg
dGhlIGJlc3QgdGVzdCBzaW5jZQ0KPiA+IGZzeW5jKCkgaXMNCj4gPiBhIGhpZ2ggbGF0ZW5jeSBv
cGVyYXRpb24gd2hlbiB0aGUgcGFnZSBjYWNoZSBpcyBsb2FkZWQuIFlvdSBhbHNvDQo+ID4gd2Fu
dA0KPiA+IHRvIHVzZSBhIGNsaWVudCB3aXRoIHJlbGF0aXZlbHkgbGltaXRlZCBtZW1vcnkgc28g
dGhhdCBpdCB3aWxsIHRyeQ0KPiA+IHRvDQo+ID4gcmVjbGFpbSBtZW1vcnkgYnkgcHVzaGluZyBv
dXQgZGlydHkgcGFnZXMgYW5kIGRvaW5nIENPTU1JVC4NCj4gDQo+IEkgdGhvdWdodCBJIHdhcyBo
aXR0aW5nIHRob3NlIGxvdy1tZW1vcnkgY2FzZXMgd2l0aCBkaXJlY3QgSS9PDQo+IHRlc3Rpbmcu
IDxzaHJ1Zz4NCg0KSWYgeW91IGRvIE9fRElSRUNUIHdpdGggMTAwTUIgd3JpdGUoKSBjYWxscywg
dGhlbiBtYXliZS4gSWYgeW91IHVzZSA8DQoxTUIgd3JpdGUoKXMgdGhlbiB5b3UnbGwgcmFyZWx5
IGlmIGV2ZXIgaGl0IGFueSBDT01NSVQgY2FsbHMuDQoNCj4gDQo+IA0KPiA+ID4gSSB3b25kZXIg
YWJvdXQgYWRkaW5nIGEgRml4ZXM6IHRhZyBmb3IgYSBjaGFuZ2UgdGhhdCB0aGUgcGF0Y2gNCj4g
PiA+IGRlc2NyaXB0aW9uIGRlc2NyaWJlcyBhcyBhbiBvcHRpbWl6YXRpb24uDQo+ID4gDQo+ID4g
SSd2ZSBvY2Nhc2lvbmFsbHkgaGl0IE9PTSBzaXR1YXRpb25zIGluIHRoZSByZS1leHBvcnQgY2Fz
ZSB3aGVuIHRoZQ0KPiA+IHIvdw0KPiA+IGxvY2sgY29udGVudGlvbiBjYXVzZXMgc29mdGVyciBm
YWlsdXJlIHRvIGJlIHNlcmlhbGlzZWQuDQo+ID4gaS5lLiBpZiB0aGUgc2VydmVyIGlzIGRvd24s
IGFuZCB5b3UncmUgZXNzZW50aWFsbHkgaG9waW5nIHRoYXQgdGhlDQo+ID4gbmZzZA0KPiA+IHRo
cmVhZHMgd2lsbCBnaXZlIHVwIGFuZCByZXR1cm4gRUpVS0VCT1gvTkZTNEVSUl9ERUxBWSB0byB0
aGUNCj4gPiBjbGllbnQsDQo+ID4gdGhlbiB0aGF0IGxvY2sgZW5zdXJlcyB0aGF0IHRocmVhZHMg
ZmFpbCBvbmUtYnktb25lIChncmFiIGxvY2ssDQo+ID4gd3JpdGUsDQo+ID4gdGltZW91dCwgcmVs
ZWFzZSBsb2NrKSBpbnN0ZWFkIG9mIGJlaW5nIGFibGUgdG8gYWxsIGZhaWwgYXQgb25jZQ0KPiA+
ICh3cml0ZSwgdGltZW91dCkuDQo+ID4gDQo+ID4gPiANCj4gPiA+IA0KPiA+ID4gPiAtLS0NCj4g
PiA+ID4gZnMvbmZzZC92ZnMuYyB8IDE4ICsrKysrKysrKysrKysrKystLQ0KPiA+ID4gPiAxIGZp
bGUgY2hhbmdlZCwgMTYgaW5zZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMoLSkNCj4gPiA+ID4gDQo+
ID4gPiA+IGRpZmYgLS1naXQgYS9mcy9uZnNkL3Zmcy5jIGIvZnMvbmZzZC92ZnMuYw0KPiA+ID4g
PiBpbmRleCAxNWFkZjFmNmFiMjEuLjQ2NDg1YzA0NzQwZCAxMDA2NDQNCj4gPiA+ID4gLS0tIGEv
ZnMvbmZzZC92ZnMuYw0KPiA+ID4gPiArKysgYi9mcy9uZnNkL3Zmcy5jDQo+ID4gPiA+IEBAIC0x
MTIzLDYgKzExMjMsMTkgQEAgbmZzZF93cml0ZShzdHJ1Y3Qgc3ZjX3Jxc3QgKnJxc3RwLA0KPiA+
ID4gPiBzdHJ1Y3QNCj4gPiA+ID4gc3ZjX2ZoICpmaHAsIGxvZmZfdCBvZmZzZXQsDQo+ID4gPiA+
IH0NCj4gPiA+ID4gDQo+ID4gPiA+ICNpZmRlZiBDT05GSUdfTkZTRF9WMw0KPiA+ID4gPiArc3Rh
dGljIGludA0KPiA+ID4gPiArbmZzZF9maWxlbWFwX3dyaXRlX2FuZF93YWl0X3JhbmdlKHN0cnVj
dCBuZnNkX2ZpbGUgKm5mLCBsb2ZmX3QNCj4gPiA+ID4gb2Zmc2V0LA0KPiA+ID4gPiArwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oCBsb2ZmX3QgZW5kKQ0KPiA+ID4gPiArew0KPiA+ID4gPiArwqDCoMKgwqDCoMKgIHN0cnVjdCBh
ZGRyZXNzX3NwYWNlICptYXBwaW5nID0gbmYtPm5mX2ZpbGUtPmZfbWFwcGluZzsNCj4gPiA+ID4g
K8KgwqDCoMKgwqDCoCBpbnQgcmV0ID0gZmlsZW1hcF9mZGF0YXdyaXRlX3JhbmdlKG1hcHBpbmcs
IG9mZnNldCwNCj4gPiA+ID4gZW5kKTsNCj4gPiA+ID4gKw0KPiA+ID4gPiArwqDCoMKgwqDCoMKg
IGlmIChyZXQpDQo+ID4gPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHJldHVybiBy
ZXQ7DQo+ID4gPiA+ICvCoMKgwqDCoMKgwqAgZmlsZW1hcF9mZGF0YXdhaXRfcmFuZ2Vfa2VlcF9l
cnJvcnMobWFwcGluZywgb2Zmc2V0LA0KPiA+ID4gPiBlbmQpOw0KPiA+ID4gPiArwqDCoMKgwqDC
oMKgIHJldHVybiAwOw0KPiA+ID4gPiArfQ0KPiA+ID4gPiArDQo+ID4gPiA+IC8qDQo+ID4gPiA+
IMKgKiBDb21taXQgYWxsIHBlbmRpbmcgd3JpdGVzIHRvIHN0YWJsZSBzdG9yYWdlLg0KPiA+ID4g
PiDCoCoNCj4gPiA+ID4gQEAgLTExNTMsMTAgKzExNjYsMTEgQEAgbmZzZF9jb21taXQoc3RydWN0
IHN2Y19ycXN0ICpycXN0cCwNCj4gPiA+ID4gc3RydWN0DQo+ID4gPiA+IHN2Y19maCAqZmhwLA0K
PiA+ID4gPiDCoMKgwqDCoMKgwqDCoCBpZiAoZXJyKQ0KPiA+ID4gPiDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqAgZ290byBvdXQ7DQo+ID4gPiA+IMKgwqDCoMKgwqDCoMKgIGlmIChFWF9J
U1NZTkMoZmhwLT5maF9leHBvcnQpKSB7DQo+ID4gPiA+IC3CoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgIGludCBlcnIyOw0KPiA+ID4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBp
bnQgZXJyMiA9DQo+ID4gPiA+IG5mc2RfZmlsZW1hcF93cml0ZV9hbmRfd2FpdF9yYW5nZShuZiwN
Cj4gPiA+ID4gb2Zmc2V0LCBlbmQpOw0KPiA+ID4gPiANCj4gPiA+ID4gwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgIGRvd25fd3JpdGUoJm5mLT5uZl9yd3NlbSk7DQo+ID4gPiA+IC3CoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGVycjIgPSB2ZnNfZnN5bmNfcmFuZ2UobmYtPm5mX2Zp
bGUsIG9mZnNldCwNCj4gPiA+ID4gZW5kLA0KPiA+ID4gPiAwKTsNCj4gPiA+ID4gK8KgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqAgaWYgKCFlcnIyKQ0KPiA+ID4gPiArwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgZXJyMiA9IHZmc19mc3luY19yYW5nZShuZi0+
bmZfZmlsZSwNCj4gPiA+ID4gb2Zmc2V0LA0KPiA+ID4gPiBlbmQsIDApOw0KPiA+ID4gPiDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgc3dpdGNoIChlcnIyKSB7DQo+ID4gPiA+IMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBjYXNlIDA6DQo+ID4gPiA+IMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgbmZzZF9jb3B5X2Jvb3RfdmVyaWZpZXIo
dmVyZiwNCj4gPiA+ID4gbmV0X2dlbmVyaWMobmYtPm5mX25ldCwNCj4gPiA+ID4gLS0gDQo+ID4g
PiA+IDIuMzEuMQ0KPiA+ID4gPiANCj4gPiA+IA0KPiA+ID4gLS0NCj4gPiA+IENodWNrIExldmVy
DQo+ID4gPiANCj4gPiA+IA0KPiA+ID4gDQo+ID4gDQo+ID4gLS0gDQo+ID4gVHJvbmQgTXlrbGVi
dXN0DQo+ID4gTGludXggTkZTIGNsaWVudCBtYWludGFpbmVyLCBIYW1tZXJzcGFjZQ0KPiA+IHRy
b25kLm15a2xlYnVzdEBoYW1tZXJzcGFjZS5jb20NCj4gDQo+IC0tDQo+IENodWNrIExldmVyDQo+
IA0KPiANCj4gDQoNCi0tIA0KVHJvbmQgTXlrbGVidXN0DQpDVE8sIEhhbW1lcnNwYWNlIEluYw0K
NDk4NCBFbCBDYW1pbm8gUmVhbCwgU3VpdGUgMjA4DQpMb3MgQWx0b3MsIENBIDk0MDIyDQrigIsN
Cnd3dy5oYW1tZXIuc3BhY2UNCg0K

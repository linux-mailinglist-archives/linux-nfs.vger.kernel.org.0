Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B295D36A27A
	for <lists+linux-nfs@lfdr.de>; Sat, 24 Apr 2021 19:59:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232546AbhDXSAG (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sat, 24 Apr 2021 14:00:06 -0400
Received: from mail-dm6nam11on2126.outbound.protection.outlook.com ([40.107.223.126]:49729
        "EHLO NAM11-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231307AbhDXSAF (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Sat, 24 Apr 2021 14:00:05 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BX4znE2jXsC2SJ8JqZpdKY1ZHjZ6CUK27OXPVFG5YYqIFttfljSG7txXK2aSVWdpMxox76Exd6vBFk6q9PfM8pvL6I+08gVol35URRQ/HKNZ3VfcmZdQXI0QQDmtZXqbTNZoM9CTKEFrRRJowm0JpkRtBf0dgKRizYyKMuMplyuBiYQEu+0JTU2/N6wKrvTDolR+wrh6oh14jRGZYPS4kBup1GE6N86MnSGA//puHj83+XaskgJonh4VozR9L1FLDU6Mqi2pgOFHvlkaXKl58Vp15Td+dVnrXCrusJGX2/VPbbvmegIyRrj/8pT5P4DS2KIKL5zPV84xRm6O6EVwTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6fi9QWMwTqCLMQwzXfu7eJ7AqrrEjJHFuy7i2rwJJaY=;
 b=ml74XC2+OiWcmOiVyX8AoGAeMLgQSWq1MPhkrtGxUxKtVsrs0Z6wxCVYT4wbPxgbWfSVz+SGu4Q1603wymWw2SBdrNg81YGnLW3luBdCXOUonf/7XtBDJ4xJ0GU+WlrgYl5Qz0s+/R0M2mhrhuvYWsFLyvGQyRf1DRBJO4dXwdvMFNqlA7cmKPktb/U8K9x8O5g1uO17leZqoKHtWRpFEqpvjkUpYBdcfKCx/PmLFwqz1/lFBpdXHmXKJfxuNTAfOQrrFNQ49CjPvsPbjVcNP2zurNOzb7qj68mU96EuB1OJfdsH2Cvxt7LW4ETfVNVtF7AOTsfLIrR1pu2F5IeyNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6fi9QWMwTqCLMQwzXfu7eJ7AqrrEjJHFuy7i2rwJJaY=;
 b=LKE4/cjaTGGgjzIQJeYjCLABebK4pjZGAF4/3joJLfyjR0i37iY+M6PUfOKjAggrPI5onHVRJWsI7/XTav8hcpA8BOmZCGHt3O5rXNVwSy9ztkj5H8KQtfgcsV/vB4RXQD5iRy4MVgYrBWZ0qS35eFEAXGcrngJC5SYBrEVSi1A=
Received: from DS7PR13MB4733.namprd13.prod.outlook.com (2603:10b6:5:3b1::24)
 by DM6PR13MB4432.namprd13.prod.outlook.com (2603:10b6:5:1b8::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4087.22; Sat, 24 Apr
 2021 17:59:26 +0000
Received: from DS7PR13MB4733.namprd13.prod.outlook.com
 ([fe80::f414:a9a:6686:f7e0]) by DS7PR13MB4733.namprd13.prod.outlook.com
 ([fe80::f414:a9a:6686:f7e0%4]) with mapi id 15.20.4087.022; Sat, 24 Apr 2021
 17:59:25 +0000
From:   Trond Myklebust <trondmy@hammerspace.com>
To:     "chuck.lever@oracle.com" <chuck.lever@oracle.com>
CC:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Subject: Re: [PATCH v3 07/26] xprtrdma: Improve locking around rpcrdma_rep
 destruction
Thread-Topic: [PATCH v3 07/26] xprtrdma: Improve locking around rpcrdma_rep
 destruction
Thread-Index: AQHXNUYor6w5EFWlLUq08aFp3pnm76rCnoCAgAFYcICAAAWiAA==
Date:   Sat, 24 Apr 2021 17:59:25 +0000
Message-ID: <4975b75027b5407c5fef961f9be123b781b40559.camel@hammerspace.com>
References: <161885481568.38598.16682844600209775665.stgit@manet.1015granger.net>
         <161885534259.38598.17355600080366820390.stgit@manet.1015granger.net>
         <89d2e2bbc40d953e28c4e4d56be0b5c83c25dc23.camel@hammerspace.com>
         <0DA1937B-3EA1-45A9-BD37-F7426764F83D@oracle.com>
In-Reply-To: <0DA1937B-3EA1-45A9-BD37-F7426764F83D@oracle.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: oracle.com; dkim=none (message not signed)
 header.d=none;oracle.com; dmarc=none action=none header.from=hammerspace.com;
x-originating-ip: [68.36.133.222]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 81dc47c3-98e4-43a7-9a36-08d9074ab2d6
x-ms-traffictypediagnostic: DM6PR13MB4432:
x-microsoft-antispam-prvs: <DM6PR13MB443257264A92F5700CE354CFB8449@DM6PR13MB4432.namprd13.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: XwHmYEzfiTkYpKTme/xhLfLTfpPGZz9gmsJCFya2NygJBE8m74YarsuCD6nt0BdXYKw6W19Yl8SOZ/6mupnj14NtdyJWZekeY05uMxwCDhsOUfKPMY1xcvSXxoOXdBcb6RZ/+xpLLt+Nwp6x010pxwVDneN8aAVo9qsw2rFke1K0sUydTvULsdPDXuYZJTnEPuzYk5xnqvlJIHkeoNIFs4uwqScHnTo1isz446HOqDXJUtcc2P6FOmY6vRopor+L6XwKEeQS+Kc9u0eGiHgHpMrxxbXMHG/+VfmhtsAjPkJ0873OBwQDlETnouDpu9p4WJjCd8sa90xCYaLAKZJ6/QFljF8D6q6EVCv+Tvgm/AcoCKNtiLkYWlRRZBPXCJBfsGZuzbAalwqXbuaov0U5ar7NRGIRCx9lczfA7HdeanGNPd6f85XmyB45NwWJ3s8qI7oNrweNNujbgO4GsPTJs2u/XWl5+qkWpfq0xwpz6xoHN4e4QNI1KEuRpCGptiRwckvdxZTHPYxFopGl4TYbkWRuvhlZNoP8pKDvDp8XwKTh74sp9REegMr6Q8cxlzzn+Pm1oCq0dAQdOqB8borsR+BxXkCYHsF/APtYaHQ+e6M=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR13MB4733.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(136003)(376002)(366004)(346002)(39830400003)(6486002)(54906003)(316002)(122000001)(38100700002)(6512007)(2906002)(6916009)(6506007)(53546011)(5660300002)(186003)(8676002)(4326008)(2616005)(8936002)(478600001)(71200400001)(66446008)(64756008)(66556008)(91956017)(66476007)(76116006)(66946007)(36756003)(83380400001)(86362001)(26005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?utf-8?B?aFR3Nm9VcUI0YVVzcHRMWnRuWDZ2bG5saDdaN0d5YkdiOTA5ZlFLYWwvdlZ4?=
 =?utf-8?B?MUFGTlFabUtDMVNVdm1xazVBVkZMU2tDMDRSUlpmTXhyZG84VFhjWFlUOW5D?=
 =?utf-8?B?S2x0MjVPSTJtby9rM3h0OUp4N1pMTTRZR3dCZG9xUDRWQnpsQStLQmhyNk1Z?=
 =?utf-8?B?ZmFSaUV5Zm15L1pDR285YnRLTEhPMzFGZjFjVHpHUFFvd3ZDdnVyekpmaTlq?=
 =?utf-8?B?K2NId3ExT09QVjkwYlhkeGtCaDA5NDhMTXVaelVlMmd6T0F3a3pJaHc4Mloy?=
 =?utf-8?B?Z2k4WHNVRkhjNU9PY3RsK2ZyTEtJblRmV3ZCeXVvM0xBcE9XQWdickliVS9w?=
 =?utf-8?B?OFNHZXV6VDRXSjkzR0VDOStQUTVXTFI4L0JIbXZNbEl3NkQ3ZThyaTM3Wjhz?=
 =?utf-8?B?RUdFVDYzZWszcmJEL0I3RHE4RFlSMGJuVXA1OWRjV2FJTXR1M0RkQTd2ay9I?=
 =?utf-8?B?RnJYOUluVC96N2NZSHFOU0xzYWZPQWxZdVBIbVlleDcrM1ViUkdrNXVHWk8r?=
 =?utf-8?B?OW9rZjFqT2h4SXRkSWJXZTNJcjd6TmdaK0tBUXAwS3FTbUVmRXNDSGFQZ2FJ?=
 =?utf-8?B?TXJ6TndGNHBQNURvcHM5OGNQdzVGQWVzRHNZa1dpWEJKdHIycGVIS1BMcERt?=
 =?utf-8?B?ZGhZZ0tUaVFtTnVmOVNsM2pXK1JuZytlVkl2UWRlZ0VyNjgyQjFCczN2R2RT?=
 =?utf-8?B?aXJTWDQzTVNCdGNmOVZtTllWRTlGVTZnSUZFby9EUStmQTVIV1BnYXRRajZY?=
 =?utf-8?B?eFZLSWQ0TTFHQ1Fjckdqb3RYOUtxSzdqMDJINk1ZK1BLNDFQYUtYdE9aRUhh?=
 =?utf-8?B?RlJ4aVhvRXlGTGxtTnN3a2w1clRwNlRmMVlVY0RuU3M4cEZad0ZyUnFZbytK?=
 =?utf-8?B?TFpwUHhKdXRWL1JCaTNWeHBLSHRneDN6YmlPS3dnQmgxWUFxMWVNY1hWbW9O?=
 =?utf-8?B?b0phM3JVQ1hkSjhnR1YvN1hlSU1tRTVWemQxQktmM3pQSU4yWEkyRTltSnZX?=
 =?utf-8?B?WHFDUnZmTGFJcWpzZVZqQjFDdGtXeDFBV1A2bGFhYmpOVmJHbmQ5N2dRS21s?=
 =?utf-8?B?NFVxYjFBZldoeGthM1lIRXZvLzZoeWdtQlNSNEtRUG44bDBwWWs3QXhHbHAy?=
 =?utf-8?B?a2Z0NUwrZjY5ZU5NSEtuRkZsU25ScUUxU3lSalM1TExhYVgvRUh2NHBjUG85?=
 =?utf-8?B?ckZMZ1B4alBIM2tpU2lSVURXVmJZTTVRSEZDc0w3MVJqQzIvaVJEc0FBOVNo?=
 =?utf-8?B?cUxsb0hWd1lrRmNwVWdDVU9NcGh6Y1haaFdQU25CZ3RGL2hzaGwxZGFFclVM?=
 =?utf-8?B?M0NqWmZTdUt5b0ZvM1U2akh2LzczeTlmUlJtU09tQ0ZZUlJaUmFZb21CaGts?=
 =?utf-8?B?YlVRT1loM1h0dFNqY2xhd0p6MnBPLzNCVUlrYlAxL2JNbHkyKzVZKzFONWxq?=
 =?utf-8?B?V0JFVGErSVFOTUJnZlJlaWI0ak41bHh1N3h6RjE4VGdEdzA0azBBZDlqNzh2?=
 =?utf-8?B?ZkQxQWN6NVJxS2dmK016cllWbk5PSzhBNGFjZExNaTVucmtLQzZ2SVA3MzZF?=
 =?utf-8?B?QVE0TEJ4RkpRa0hjOUllY3c1Z2hFeVFRUnJHOWpQOE4raDZjZXVBQ3pOMGhZ?=
 =?utf-8?B?SkdKNVYvMkhlNmFXMDZMUXNZOXh3RWtYZHBzT0pTS2hxZ2Y3eEN1bXN6ZUk2?=
 =?utf-8?B?bkw3eCtoUzJlVHlnZHlHclFJQ0ZCRlBtRzIvNllUU2ZVbDVyUmdMbytyWHZj?=
 =?utf-8?Q?88+KBD6KChilMiiRl/gglbJ8N8D15roFfevN9Ys?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <8B4B99B50B0B3242886EF3AB977F823B@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS7PR13MB4733.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 81dc47c3-98e4-43a7-9a36-08d9074ab2d6
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Apr 2021 17:59:25.7117
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bZeb8C/gTrTc98fwbrFnJsY8Ol27XIsbYfGPGci6stm7ZBenUxf5gwq9QMKGRUzK4jIC9TkUCPgLw2xFmX+Hwg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR13MB4432
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

T24gU2F0LCAyMDIxLTA0LTI0IGF0IDE3OjM5ICswMDAwLCBDaHVjayBMZXZlciBJSUkgd3JvdGU6
DQo+IA0KPiANCj4gPiBPbiBBcHIgMjMsIDIwMjEsIGF0IDU6MDYgUE0sIFRyb25kIE15a2xlYnVz
dCA8IA0KPiA+IHRyb25kbXlAaGFtbWVyc3BhY2UuY29tPiB3cm90ZToNCj4gPiANCj4gPiBPbiBN
b24sIDIwMjEtMDQtMTkgYXQgMTQ6MDIgLTA0MDAsIENodWNrIExldmVyIHdyb3RlOg0KPiA+ID4g
Q3VycmVudGx5IHJwY3JkbWFfcmVwc19kZXN0cm95KCkgYXNzdW1lcyB0aGF0LCBhdCB0cmFuc3Bv
cnQNCj4gPiA+IHRlYXItZG93biwgdGhlIGNvbnRlbnQgb2YgdGhlIHJiX2ZyZWVfcmVwcyBsaXN0
IGlzIHRoZSBzYW1lIGFzDQo+ID4gPiB0aGUNCj4gPiA+IGNvbnRlbnQgb2YgdGhlIHJiX2FsbF9y
ZXBzIGxpc3QuIEFsdGhvdWdoIHRoYXQgaXMgdXN1YWxseSB0cnVlLA0KPiA+ID4gdXNpbmcgdGhl
IHJiX2FsbF9yZXBzIGxpc3Qgc2hvdWxkIGJlIG1vcmUgcmVsaWFibGUgYmVjYXVzZSBvZg0KPiA+
ID4gdGhlIHdheSBpdCdzIG1hbmFnZWQuIEFuZCwgcnBjcmRtYV9yZXBzX3VubWFwKCkgdXNlcyBy
Yl9hbGxfcmVwczsNCj4gPiA+IHRoZXNlIHR3byBmdW5jdGlvbnMgc2hvdWxkIGJvdGggdHJhdmVy
c2UgdGhlICJhbGwiIGxpc3QuDQo+ID4gPiANCj4gPiA+IEVuc3VyZSB0aGF0IGFsbCBycGNyZG1h
X3JlcHMgYXJlIGFsd2F5cyBkZXN0cm95ZWQgd2hldGhlciB0aGV5DQo+ID4gPiBhcmUNCj4gPiA+
IG9uIHRoZSByZXAgZnJlZSBsaXN0IG9yIG5vdC4NCj4gPiA+IA0KPiA+ID4gU2lnbmVkLW9mZi1i
eTogQ2h1Y2sgTGV2ZXIgPGNodWNrLmxldmVyQG9yYWNsZS5jb20+DQo+ID4gPiAtLS0NCj4gPiA+
IMKgbmV0L3N1bnJwYy94cHJ0cmRtYS92ZXJicy5jIHzCoMKgIDMxICsrKysrKysrKysrKysrKysr
KysrKysrKy0tLS0tDQo+ID4gPiAtLQ0KPiA+ID4gwqAxIGZpbGUgY2hhbmdlZCwgMjQgaW5zZXJ0
aW9ucygrKSwgNyBkZWxldGlvbnMoLSkNCj4gPiA+IA0KPiA+ID4gZGlmZiAtLWdpdCBhL25ldC9z
dW5ycGMveHBydHJkbWEvdmVyYnMuYw0KPiA+ID4gYi9uZXQvc3VucnBjL3hwcnRyZG1hL3ZlcmJz
LmMNCj4gPiA+IGluZGV4IDFiNTk5YTYyM2VlYS4uNDgyZmRjOWUyNWMyIDEwMDY0NA0KPiA+ID4g
LS0tIGEvbmV0L3N1bnJwYy94cHJ0cmRtYS92ZXJicy5jDQo+ID4gPiArKysgYi9uZXQvc3VucnBj
L3hwcnRyZG1hL3ZlcmJzLmMNCj4gPiA+IEBAIC0xMDA3LDE2ICsxMDA3LDIzIEBAIHN0cnVjdCBy
cGNyZG1hX3JlcA0KPiA+ID4gKnJwY3JkbWFfcmVwX2NyZWF0ZShzdHJ1Y3QNCj4gPiA+IHJwY3Jk
bWFfeHBydCAqcl94cHJ0LA0KPiA+ID4gwqDCoMKgwqDCoMKgwqAgcmV0dXJuIE5VTEw7DQo+ID4g
PiDCoH0NCj4gPiA+IMKgDQo+ID4gPiAtLyogTm8gbG9ja2luZyBuZWVkZWQgaGVyZS4gVGhpcyBm
dW5jdGlvbiBpcyBpbnZva2VkIG9ubHkgYnkgdGhlDQo+ID4gPiAtICogUmVjZWl2ZSBjb21wbGV0
aW9uIGhhbmRsZXIsIG9yIGR1cmluZyB0cmFuc3BvcnQgc2h1dGRvd24uDQo+ID4gPiAtICovDQo+
ID4gPiAtc3RhdGljIHZvaWQgcnBjcmRtYV9yZXBfZGVzdHJveShzdHJ1Y3QgcnBjcmRtYV9yZXAg
KnJlcCkNCj4gPiA+ICtzdGF0aWMgdm9pZCBycGNyZG1hX3JlcF9kZXN0cm95X2xvY2tlZChzdHJ1
Y3QgcnBjcmRtYV9yZXAgKnJlcCkNCj4gPiANCj4gPiBUaGUgbmFtZSBoZXJlIGlzIGV4dHJlbWVs
eSBjb25mdXNpbmcuIEFzIGZhciBhcyBJIGNhbiB0ZWxsLCB0aGlzDQo+ID4gaXNuJ3QNCj4gPiBj
YWxsZWQgd2l0aCBhbnkgbG9jaz8NCj4gDQo+IEZhaXIgZW5vdWdoLg0KPiANCj4gSSByZW5hbWVk
IGl0IHJwY3JkbWFfcmVwX2ZyZWUoKSBhbmQgaXQgZG9lc24ndCBzZWVtIHRvIGhhdmUNCj4gYW55
IGNvbnNlcXVlbmNlcyBmb3IgZG93bnN0cmVhbSBjb21taXRzIGluIHRoaXMgc2VyaWVzLg0KDQpT
b3VuZHMgZ29vZC4NCg0KPiANCj4gWW91IGNvdWxkIGRvIGEgZ2xvYmFsIGVkaXQsIEkgY2FuIHJl
c2VuZCB5b3UgdGhpcyBwYXRjaCB3aXRoDQo+IHRoZSBjaGFuZ2UsIG9yIEkgY2FuIHBvc3QgYSB2
NCBvZiB0aGlzIHNlcmllcy4gTGV0IG1lIGtub3cNCj4geW91ciBwcmVmZXJlbmNlLg0KPiANCg0K
Q2FuIHlvdSBwbGVhc2UganVzdCByZXNlbmQgdGhpcyBwYXRjaCB3aXRoIHRoZSB1cGRhdGUsIHVu
bGVzcyB0aGVyZSBhcmUNCnJlcGVyY3Vzc2lvbnMgZm9yIHRoZSBvdGhlciBwYXRjaGVzPyAoaW4g
d2hpY2ggY2FzZSBhIHY0IHdvdWxkIGJlDQp3ZWxjb21lKQ0KDQo+IA0KPiA+ID4gwqB7DQo+ID4g
PiAtwqDCoMKgwqDCoMKgIGxpc3RfZGVsKCZyZXAtPnJyX2FsbCk7DQo+ID4gPiDCoMKgwqDCoMKg
wqDCoCBycGNyZG1hX3JlZ2J1Zl9mcmVlKHJlcC0+cnJfcmRtYWJ1Zik7DQo+ID4gPiDCoMKgwqDC
oMKgwqDCoCBrZnJlZShyZXApOw0KPiA+ID4gwqB9DQo+ID4gPiDCoA0KPiA+ID4gK3N0YXRpYyB2
b2lkIHJwY3JkbWFfcmVwX2Rlc3Ryb3koc3RydWN0IHJwY3JkbWFfcmVwICpyZXApDQo+ID4gPiAr
ew0KPiA+ID4gK8KgwqDCoMKgwqDCoCBzdHJ1Y3QgcnBjcmRtYV9idWZmZXIgKmJ1ZiA9ICZyZXAt
PnJyX3J4cHJ0LT5yeF9idWY7DQo+ID4gPiArDQo+ID4gPiArwqDCoMKgwqDCoMKgIHNwaW5fbG9j
aygmYnVmLT5yYl9sb2NrKTsNCj4gPiA+ICvCoMKgwqDCoMKgwqAgbGlzdF9kZWwoJnJlcC0+cnJf
YWxsKTsNCj4gPiA+ICvCoMKgwqDCoMKgwqAgc3Bpbl91bmxvY2soJmJ1Zi0+cmJfbG9jayk7DQo+
ID4gPiArDQo+ID4gPiArwqDCoMKgwqDCoMKgIHJwY3JkbWFfcmVwX2Rlc3Ryb3lfbG9ja2VkKHJl
cCk7DQo+ID4gPiArfQ0KPiA+ID4gKw0KPiA+ID4gwqBzdGF0aWMgc3RydWN0IHJwY3JkbWFfcmVw
ICpycGNyZG1hX3JlcF9nZXRfbG9ja2VkKHN0cnVjdA0KPiA+ID4gcnBjcmRtYV9idWZmZXIgKmJ1
ZikNCj4gPiA+IMKgew0KPiA+ID4gwqDCoMKgwqDCoMKgwqAgc3RydWN0IGxsaXN0X25vZGUgKm5v
ZGU7DQo+ID4gPiBAQCAtMTA0OSw4ICsxMDU2LDE4IEBAIHN0YXRpYyB2b2lkIHJwY3JkbWFfcmVw
c19kZXN0cm95KHN0cnVjdA0KPiA+ID4gcnBjcmRtYV9idWZmZXIgKmJ1ZikNCj4gPiA+IMKgew0K
PiA+ID4gwqDCoMKgwqDCoMKgwqAgc3RydWN0IHJwY3JkbWFfcmVwICpyZXA7DQo+ID4gPiDCoA0K
PiA+ID4gLcKgwqDCoMKgwqDCoCB3aGlsZSAoKHJlcCA9IHJwY3JkbWFfcmVwX2dldF9sb2NrZWQo
YnVmKSkgIT0gTlVMTCkNCj4gPiA+IC3CoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHJwY3Jk
bWFfcmVwX2Rlc3Ryb3kocmVwKTsNCj4gPiA+ICvCoMKgwqDCoMKgwqAgc3Bpbl9sb2NrKCZidWYt
PnJiX2xvY2spOw0KPiA+ID4gK8KgwqDCoMKgwqDCoCB3aGlsZSAoKHJlcCA9IGxpc3RfZmlyc3Rf
ZW50cnlfb3JfbnVsbCgmYnVmLT5yYl9hbGxfcmVwcywNCj4gPiA+ICvCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqAgc3RydWN0DQo+ID4gPiBycGNyZG1hX3JlcCwNCj4gPiA+ICvCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgcnJfYWxsKSkgIT0gTlVMTCkNCj4gPiA+IHsN
Cj4gPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGxpc3RfZGVsKCZyZXAtPnJyX2Fs
bCk7DQo+ID4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBzcGluX3VubG9jaygmYnVm
LT5yYl9sb2NrKTsNCj4gPiA+ICsNCj4gPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
IHJwY3JkbWFfcmVwX2Rlc3Ryb3lfbG9ja2VkKHJlcCk7DQo+ID4gPiArDQo+ID4gPiArwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBzcGluX2xvY2soJmJ1Zi0+cmJfbG9jayk7DQo+ID4gPiAr
wqDCoMKgwqDCoMKgIH0NCj4gPiA+ICvCoMKgwqDCoMKgwqAgc3Bpbl91bmxvY2soJmJ1Zi0+cmJf
bG9jayk7DQo+ID4gPiDCoH0NCj4gPiA+IMKgDQo+ID4gPiDCoC8qKg0KPiA+ID4gDQo+ID4gPiAN
Cj4gPiANCj4gPiAtLSANCj4gPiBUcm9uZCBNeWtsZWJ1c3QNCj4gPiBMaW51eCBORlMgY2xpZW50
IG1haW50YWluZXIsIEhhbW1lcnNwYWNlDQo+ID4gdHJvbmQubXlrbGVidXN0QGhhbW1lcnNwYWNl
LmNvbQ0KPiANCj4gLS0NCj4gQ2h1Y2sgTGV2ZXINCj4gDQo+IA0KPiANCg0KLS0gDQpUcm9uZCBN
eWtsZWJ1c3QNCkxpbnV4IE5GUyBjbGllbnQgbWFpbnRhaW5lciwgSGFtbWVyc3BhY2UNCnRyb25k
Lm15a2xlYnVzdEBoYW1tZXJzcGFjZS5jb20NCg0KDQo=

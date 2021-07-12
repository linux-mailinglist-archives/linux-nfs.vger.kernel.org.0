Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 06F5F3C620A
	for <lists+linux-nfs@lfdr.de>; Mon, 12 Jul 2021 19:36:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234542AbhGLRjC (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 12 Jul 2021 13:39:02 -0400
Received: from mail-mw2nam12on2100.outbound.protection.outlook.com ([40.107.244.100]:8289
        "EHLO NAM12-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230033AbhGLRjB (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Mon, 12 Jul 2021 13:39:01 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HXxOBZFdOMJjfk9ZGuhyAYmIRHXj2M3aSkfRur5/yPRLwPE1ZBPLOPObpQP1vRL891cTFTRt6F8Gr3p48NRmQHurcnGuD9XHtfrl6lXXM6ZzB9+AlaZzg280kBQbG/rAIT6sN2D4K5wOq1qHt2H5dt90LyBtLWMiahJ7euO26fDBZ6z5uOIVtqHFsjk7OFnw93sDbRkCLGhXCDdmwe5i9B/36Si3MWeZfuBvkmASVDJS7m0OlWwSm4LiwL9sZGyBv+Usz/ByB1QVAlZ9Bitq+waz4YdGTFWyV6Jp1oQ0pPrJJDnlFkwBs2ZmFy6M6VX31atwnzfgiSnPOCALU5TxYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5uM9luo7fIsgkmwY1fEMwBQDkdOEPkecX9u+pNAfmFw=;
 b=EYGMdbXKIAPEJFAm90AjYufv2SPZh4PuD79zhadsizS50EM4QUYrpXQN50UmlnhkH7DFJo7CVOARkC6g/OczxtTOpiF7SeL6BgHvvyQD4CyauUfB5gko4RGJMM/4Z0WhkDDJDWGn7ZKmF4NqxSKMCZPQFiZd8MfjFMlp1FLMiooJ6Wpmo3AKgJ5RXWgcQqvYpNS9LMiWJ2VLoTCRDkrc2vKpttRyN27dHl80tnNRKHU/5Wmv+RGP/VMrAPGe64qRdmAplwOjsNqX8l13CfSIC4Fm0cfiyE+iPrNfRMm0hq0nurt7M26vgoSfGHpnw/qf1eX9I3nfIubN60lPL6p1Hw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5uM9luo7fIsgkmwY1fEMwBQDkdOEPkecX9u+pNAfmFw=;
 b=IkK1mmjfwW8q1+5J5oWyMyaDhpQerzObC7tvDKU41hXnTrUGIIAGOv7UMsUA4dnLUkMU3qTz1PPrPlkkzzYapPfV3uANJZuCY3ZZsoZloLAEHJ43QQ444Mn9WDNn8Km0ARC7FSNpXBUIV2rv7AajimyPsfmKE5ucQ+hzaAROr4c=
Received: from CH0PR13MB5084.namprd13.prod.outlook.com (2603:10b6:610:111::7)
 by CH0PR13MB5130.namprd13.prod.outlook.com (2603:10b6:610:113::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.12; Mon, 12 Jul
 2021 17:36:11 +0000
Received: from CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::f427:dd84:789e:6c57]) by CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::f427:dd84:789e:6c57%5]) with mapi id 15.20.4331.021; Mon, 12 Jul 2021
 17:36:11 +0000
From:   Trond Myklebust <trondmy@hammerspace.com>
To:     "chuck.lever@oracle.com" <chuck.lever@oracle.com>
CC:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
Subject: Re: SOFT + NO_RETRANS_TIMEOUT semantics
Thread-Topic: SOFT + NO_RETRANS_TIMEOUT semantics
Thread-Index: AQHXd0BYAPlUDv7myUCZIzGi/bl7Las/mkyA
Date:   Mon, 12 Jul 2021 17:36:10 +0000
Message-ID: <c902bfca197cac1c1328e833f768908ae518b829.camel@hammerspace.com>
References: <981B8D74-2193-498C-8C4F-190E263FD8F6@oracle.com>
In-Reply-To: <981B8D74-2193-498C-8C4F-190E263FD8F6@oracle.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: oracle.com; dkim=none (message not signed)
 header.d=none;oracle.com; dmarc=none action=none header.from=hammerspace.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: bd1d3fbb-126d-468c-d0de-08d9455b8a48
x-ms-traffictypediagnostic: CH0PR13MB5130:
x-microsoft-antispam-prvs: <CH0PR13MB513039D61E7DFE9B96B31A36B8159@CH0PR13MB5130.namprd13.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: fiQpPeZ95tOh9kZ7H3VZAt/n320Mqruc3QSRZjfQ6uH4aZr5qFouzqp1Ai5ZKHBDM6wS04nAGrC/YF3346ChmZYI4cgDt0xA4aLDdssaKHyLrSrjVqg1WHQdtFJO39asXgrPVFEQp5tsineXAmchEM2/eNPW4k2/BzJ2AzHj6PCxsyp0tKcRsJ2unn3Zfn7e7b+WeNMpYKb6eQqnQz4GZD2pZ2aXDoXr7l1UXCdGnSDxXbMqynSnHAUpxAhLkSswD2NYAQoGuOzXR1CBrb0xxt1OHZ6ihsYU0TM3YyQLUjJ2h/LJNM+Ftqo0MiirHVSK+/wJ6Oq/t7wuyY/THZhg4clwaLN/uLhXg8OHjTgks9At+tfkF8y6pT/wO+N6JjWjD3+o/89Qbap8+dxRUvCiXFJplp7qHrDSJ4TWswjos61+vxxECPCmdKLDaUeOvWRt7QTkXxGdAsqBsbZJt9YbkqY0Tw36y26RRZxGMDV8mjo8XlAaTP/ezd/dOHzCtVGS2Da21CWy+SkLr/pQjv9On2A36mJEe8IdnOBLj/fak2yBgfD7mhxxQ1XucnY3u7UT/vU2Z8nMsvohiD9tctO7wv9m0mS3UmOYeLjd5FvY1PErhJsv8KP6Ddgh5Of/kOLWHsQIf5pLGo/9RN55eajCSw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR13MB5084.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(376002)(136003)(396003)(39830400003)(346002)(366004)(36756003)(4326008)(2906002)(2616005)(38100700002)(478600001)(8676002)(86362001)(8936002)(71200400001)(6506007)(5660300002)(26005)(64756008)(76116006)(66446008)(66556008)(6916009)(66476007)(66946007)(186003)(6512007)(122000001)(83380400001)(316002)(6486002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VFpoOHFub0RlalJONzdNV3Z0M3hiS25sd1lVOUF3VjErQW0yU3pyeisvcWQr?=
 =?utf-8?B?bklPY2RaNE52SE9jVmx6aEtYMUpremlpaDh3UEZ1OE41YkVDb096RVdTMHFC?=
 =?utf-8?B?RGtheGtzdCtGaTc3RjBOczJDc3VmUXNtemhUdHU2TlJ1UGlRajZON1F4S1Mv?=
 =?utf-8?B?MnZWb3lGNEFWNVFaaDkwZzJGbzZFaENpUEd5NTZPbVUxYmRNTmduL1pCZ1FT?=
 =?utf-8?B?elY2Q3VVRHgxWXlhR3RKMERnZ1pXM0ZwWE40MmhmdmtmTmJTYzR0WnVXR2w3?=
 =?utf-8?B?TlB1VXdWaXY3UVJlcEF4SktDV3MxQ0pPT1IrN3VpU05maXA3SkM3THdLTk9J?=
 =?utf-8?B?Y0I3T0Y2VmV2YU9XSmRkVU4rMjZPaHp5ajV5TENzMTJva3Y3a2lDOGZyeVFV?=
 =?utf-8?B?OGJYTHJqMTdJbTlMdTRiUmgwRlZQeVZoeFJCOCtPVlF6cjNvYzNaS09NUUNH?=
 =?utf-8?B?VXYvM1RaR0crSFUwM2RjTXhGby9OTkQweVQ3MnRUS2tPOTR4aENFNXhSTFFW?=
 =?utf-8?B?MDhwaEZJdldtbUVzNWt4VjZHdTJMUWptc253UTBWRzhHdjF0VnA1dlJxRlp3?=
 =?utf-8?B?amdZa0lsTklPeTJTR0JuM2hQSnlrNDVsK0MvaXZRUVZjbTh2bU1NQk5ia2tC?=
 =?utf-8?B?NmFwNnlLZ0NaU0RLNmpHWXFMUmJjS3diNVU4SkxtQWVrRnJIc0lkRytFWFQ0?=
 =?utf-8?B?M1ROTkNveWJPUFZuemhyY2xZM3pKZHlubFd5TjA3cjlITXhUS2hPY0gyelVF?=
 =?utf-8?B?am9obGU0ZTJxcDJ3N1d5NGNFeUJlM0VEQ0gwQ2JtV2QyS0Jjc0M2VytKR01R?=
 =?utf-8?B?MDZSUVRUUE53WU56b21BWkJsSkNvVTJsZU1vT0xmNHFsUVBCb1dCQ0RPTXJk?=
 =?utf-8?B?ZWcxdXJXNmJvTENYTWJ3SzBabHp6dFIvQXFpYTZqUEQzTWxiT1hKeXVQNTJO?=
 =?utf-8?B?QVRVOWJBRDZKcERucXFqd0VEeWYrTTk4Q25tL1J1MHdLS3F2UlROWU9SZXdh?=
 =?utf-8?B?Q3crQ0xKdU8veVNLTHJNWXRmdkdpakFHVnFFdVhFZWNPbUg0Q3hLT25UV2hS?=
 =?utf-8?B?VVBxa3MzT1RoYnhpTUt6YmprN2I3WDAxbkNLVnhnTjVuUE1MaTd6QXhWUzBL?=
 =?utf-8?B?Uk4yeFViVWlidmJ0QzZva1Q3ZzZHUlRDV3JtdmplaFZqR3g1cUxhQ3lBenJT?=
 =?utf-8?B?b2N1NFQ4dWpRaVlsSnhwNEl3cWdXcWh2RG5aMGR4amt3NnJ4dGFVRFVoZlNQ?=
 =?utf-8?B?VFdsUmxFck9laDRzSjhKWkNQV0tCMDdualR6by9hMy9TMjV0eHBvdEFtUmhW?=
 =?utf-8?B?TXNnTDZPQjFzV3paVTVpc3ZZL1Z0TmZOcTlHZzVsMzhZZHdQdVpKK1BXSEUx?=
 =?utf-8?B?U1FFVWtIMFN0aWpIbmR5NEM1dVcyK1NSOFVWWGV5cjc2SzFRYUlTRmR1NmJQ?=
 =?utf-8?B?Ymw4N0hhZ1BMNWlIQy9KdjgvV3p5M0VBNmRqQjJadmF2a0MzUk1LZU02NHFa?=
 =?utf-8?B?WSs0U0o3dXYyNTJVaXM4U2c0akZaRlArVFlMcEN2Z2tJSWcwMXk3bWRJcksv?=
 =?utf-8?B?eUFsVk1rNSswdVg1RUVsTk1sdStuK3JYa0V3Z3RTZDlwOUVGVW5DaFFiMStM?=
 =?utf-8?B?MWhtbkRIcGc0Q0NxczZlcHJUblZyZFgwendWcUFTdlJBNzhSeVgrWTR6SnVl?=
 =?utf-8?B?bEdlMmVzOVBDM3JnTUM1ek5QWnlVRkNqd1JadEFZbGVOSSt0Nk1IRXZhRGYy?=
 =?utf-8?Q?X/MFAbl+YxBYCPKlW0ARjCydGX8/F/OCSUqi0gL?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <1B608D9987B03B4BA773F9A051D7AE84@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR13MB5084.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bd1d3fbb-126d-468c-d0de-08d9455b8a48
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Jul 2021 17:36:11.1510
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: c9l2JZ0x/EMyACEO80KVPnd8SlOCjdxvCLkKDaPLd1ny0kA3pEjxl+MuNbOySIJMKad1JQC12rqIZn2nBncX7w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR13MB5130
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

T24gTW9uLCAyMDIxLTA3LTEyIGF0IDE3OjA3ICswMDAwLCBDaHVjayBMZXZlciBJSUkgd3JvdGU6
DQo+IEhpIFRyb25kLQ0KPiANCj4gSSdtIHNlZWluZyBzb21lIGludGVyZXN0aW5nIGNsaWVudCBo
YW5ncyB0aGF0IGFyaXNlIGZyb20gYSB3ZWxsLQ0KPiB0aW1lZCBzZXJ2ZXIgY3Jhc2ggb3IgbmV0
d29yayBwYXJ0aXRpb24uDQo+IA0KPiBUaGUgZWFzaWVzdCB0byBzZWUgaXMgZ3NzX2Rlc3Ryb3ko
KSBvbiBhbiBLZXJiZXJpemVkIE5GU3Y0IG1vdW50Lg0KPiANCj4gTkZTdjQgYXNzZXJ0cyB0aGUg
UlBDX1RBU0tfTk9fUkVUUkFOU19USU1FT1VUIGZsYWcgKGhlcmVhZnRlciBJJ2xsDQo+IHJlZmVy
IHRvIGl0IGFzIE5PUlRPKSB3aGVuIGNyZWF0aW5nIGEgbmV3IHJwY19jbG50LiBUaGUgaW5pdGlh
bA0KPiBycGNfcGluZygpIGZvciB0aGF0IHJwY19jbG50IGlzIGRvbmUgYmVmb3JlIHRoZSBsb2dp
YyB0aGF0IHNldHMNCj4gY2xfbm9yZXRyYW5zdGltZW8sIHRodXMgdGhhdCBwaW5nIHdvcmtzIGFz
IGV4cGVjdGVkIChTT0ZUIHwNCj4gU09GVENPTk4pIGFuZCBjYW4gdGltZSBvdXQgcHJvcGVybHkg
aWYgdGhlIHNlcnZlciBpc24ndA0KPiByZXNwb25zaXZlLg0KPiANCj4gSG93ZXZlciwgb25jZSB0
aGF0IHBpbmcgc3VjY2VlZHMsIGNsX25vcmV0cmFuc3RpbWVvIGlzIGFzc2VydGVkLA0KPiBhbmQg
YWxsIHN1YnNlcXVlbnQgUlBDIHJlcXVlc3RzIG9uIHRoYXQgcnBjX2NsbnQgYXJlIHdpdGggTk9S
VE8NCj4gc2VtYW50aWNzLg0KPiANCj4gV2hlbiBpdCBjb21lcyB0aW1lIHRvIGRlc3Ryb3kgdGhl
IEdTUyBjb250ZXh0IGZvciB0aGF0IHJwY19jbG50LA0KPiB0aGUgTlVMTCBwcm9jZWR1cmUgd2l0
aCB0aGUgR1NTIGRlY29yYXRpb25zIGlzIHNlbnQgd2l0aCBTT0ZUIHwNCj4gU09GVENPTk4gfCBO
T1JUTy4gSWYgdGhlIHNlcnZlciBpc24ndCByZXNwb25kaW5nIGF0IHRoYXQgcG9pbnQsDQo+IHRo
ZSBjbGllbnQgY29udGludWVzIHRvIHJldHJhbnNtaXQgdGhlIEdTUyBjb250ZXh0IGRlc3RydWN0
aW9uDQo+IHJlcXVlc3QgZm9yZXZlciwgYW5kIHRoZSB4cHJ0IGFuZCBwb3NzaWJseSB0aGUgbmZz
X2NsaWVudCBhcmUNCj4gcGlubmVkLg0KPiANCj4gVGhlIHByb2JsZW0gYWxzbyBhcmlzZXMgZm9y
IGxlYXNlIG1hbmFnZW1lbnQgb3BlcmF0aW9ucyBzdWNoIGFzDQo+IHNpbmdsZXRvbiBTRVFVRU5D
RSBvciBSRU5FVyByZXF1ZXN0cy4gVGhlc2UgYXJlIGFsc28gZG9uZSB3aXRoDQo+IFNPRlQsIGFz
IEkgcmVjYWxsIHRoZXkgbmVlZCB0byB0aW1lIG91dCBwcm9wZXJseS4gQnV0IHdpdGgNCj4gTk9S
VE8gKyBTT0ZULCB0aGV5IHdpbGwgYmUgcmV0cmllZCB1bnRpbCBhIGNvbm5lY3Rpb24gbG9zcyB0
aGF0DQo+IG1pZ2h0IG5ldmVyIGNvbWUuDQo+IA0KPiBJJ3ZlIHRob3VnaHQgb2Ygc29tZSB3YXlz
IHRvIG1vZGlmeSB0aGUgY2xfbm9yZXRyYW5zdGltZW8gbG9naWMNCj4gc3VjaCB0aGF0IGl0IGNh
biBiZSBkaXNhYmxlZCBmb3IgcGFydGljdWxhciBSUEMgdGFza3MsIHRob3VnaA0KPiBub25lIGlz
IHJlYWxseSBzdHJpa2luZyBtZSBhcyBleGNlcHRpb25hbGx5IGNsZXZlcjoNCj4gDQo+IMKgLSBB
ZGQgYSBmaWVsZCB0byBzdHJ1Y3QgcnBjX3Byb2NpbmZvIHRoYXQgY29udGFpbnMgYSBtYXNrIG9m
DQo+IMKgwqAgUlBDX1RBU0sgZmxhZ3MgdG8gY2xlYXIgZm9yIGVhY2ggcHJvY2VkdXJlLg0KPiDC
oC0gQWRkIGxvZ2ljIHRvIHJwY190YXNrX3NldF9jbGllbnQoKSB0aGF0IGNsZWFycyBOT1JUTyBp
bg0KPiDCoMKgIHNvbWUgc3BlY2lhbCBjYXNlcy4NCj4gwqAtIFJldmVyc2UgdGhlIG1lYW5pbmcg
b2YgTk9SVE8gKGUuZy4sIG1ha2UgaXQNCj4gwqDCoCBSUENfVEFTS19SRVRSQU5TX1RJTUVPVVQp
IHNvIHRoYXQgaXQgY2FuIGJlIHNldCBieSBhIGNhbGxlcg0KPiDCoMKgIGZvciBwYXJ0aWN1bGFy
IFJQQyB0YXNrcyBpZiB0aGUgcnBjX2NsbnQtZGVmYXVsdCBiZWhhdmlvcg0KPiDCoMKgIGlzIE5P
UlRPLg0KPiANCj4gQW55IHRob3VnaHRzPw0KPiANCg0KV2h5IHdvdWxkIHRoZSBjb25uZWN0aW9u
IG5vdCBicmVhayB3aGVuIHRoZSBzZXJ2ZXIgZ29lcyBkb3duPyBBcmVuJ3QNCnRoZSBUQ1BfVVNF
Ul9USU1FT1VUIG9yIHRoZSBUQ1BfS0VFUEFMSVZFIGtpY2tpbmcgaW4gYXMgdGhleSBzaG91bGQ/
DQoNCklzIHRoaXMgYW4gUkRNQSBwcm9ibGVtPw0KDQotLSANClRyb25kIE15a2xlYnVzdA0KTGlu
dXggTkZTIGNsaWVudCBtYWludGFpbmVyLCBIYW1tZXJzcGFjZQ0KdHJvbmQubXlrbGVidXN0QGhh
bW1lcnNwYWNlLmNvbQ0KDQoNCg==

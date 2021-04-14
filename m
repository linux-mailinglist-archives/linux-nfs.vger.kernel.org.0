Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1EDDE35EB40
	for <lists+linux-nfs@lfdr.de>; Wed, 14 Apr 2021 05:09:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346006AbhDNDJm (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 13 Apr 2021 23:09:42 -0400
Received: from mail-bn8nam12on2097.outbound.protection.outlook.com ([40.107.237.97]:12935
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1343722AbhDNDJm (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Tue, 13 Apr 2021 23:09:42 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Czjb9JnI3lxuIbsU0SCXOhhZ+C4tzNXp7/Pl3qpH1TrlgXhsCOs0nSFTrFrfwYmprMfxF8+d8jwfefAq8Lrm711N6+E+DCd9Jy/uBEcIZqe6xZYsLPLkFbO7J5nxEtVS8cPsvtrqJfLN5urJo/DjGl3tuh1rWCbP6QQFTrVvF2FS9zljEdFE+rwbsQfMm4F3ps/pQCzlwsMCXJQ+w6W1EhmBEYp9pUia7uuX8WvTciusEEXpT9Qwj+E+6OUnAAo6ZIWVbmV2Rmi0lKTw2DWKYTU58fXXTfkrp5CxDqBBp7+kW8CVurav29nrwnt7lOp9M9NOClLoQJpMU+z5grJibw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MJuX7FHc9kOvNSzzm3jcf+v4UStcbW8ijJoujHEERU0=;
 b=kVWmltMIr/J4PoHnBxfqDsnF5vPFmsjir8b9X8r2CamZrOcF8DGh3IOD1Lkqqp4LRAMrGpXA4+LrajV3Ak99dEnIHseBvK5YYACcBfX3oYVlki4sUfTCI7CL3dc2fjOY5K/shdGqYlDU+TR1dr746qflYrJeYqN7P89Xv7uQTQ1bzrNRRaEK4eQwwcfTQd7GYpCR/uQ8PILS6CwVNFS9MzZeNLNNZAIMnO0CTzn9nVRx0yYfBOHlfILgtQ5Cq3qAD3r8dP6WS7s3aKUrqMKMAzhi69ZICpsEGvCqJaRwYJbLJQxAOFdlqXWAs5TH+ZjIV32tGx0QAw4wYAqCu30uxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MJuX7FHc9kOvNSzzm3jcf+v4UStcbW8ijJoujHEERU0=;
 b=K8hqLZTojn8DoPEezPYW1GvnWezyogFZGGWuG2AUKkrIejYLYMSJxGpKTK4tYpjcmjUewFWQ8r5BnI93iuT9ZwhVkf0X3n0eOJbsmhDOaJvXFYADBxPOvKHZ+6wzoF+LzKkG36nLxYsDyKezV7N4tyZeoUs/tCC62Ik/2YMsxj0=
Received: from DS7PR13MB4733.namprd13.prod.outlook.com (2603:10b6:5:3b1::24)
 by DM6PR13MB3420.namprd13.prod.outlook.com (2603:10b6:5:1ca::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4042.6; Wed, 14 Apr
 2021 03:09:19 +0000
Received: from DS7PR13MB4733.namprd13.prod.outlook.com
 ([fe80::f414:a9a:6686:f7e0]) by DS7PR13MB4733.namprd13.prod.outlook.com
 ([fe80::f414:a9a:6686:f7e0%4]) with mapi id 15.20.4042.016; Wed, 14 Apr 2021
 03:09:19 +0000
From:   Trond Myklebust <trondmy@hammerspace.com>
To:     "bfields@fieldses.org" <bfields@fieldses.org>
CC:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "kolga@netapp.com" <kolga@netapp.com>
Subject: Re: generic/430 COPY/delegation caching regression
Thread-Topic: generic/430 COPY/delegation caching regression
Thread-Index: AQHXMLuHQLD/bsFs1ECAkjQCUE0ovaqzVaWA
Date:   Wed, 14 Apr 2021 03:09:18 +0000
Message-ID: <603d9d38a421b190a89254461e01625718ec5fcc.camel@hammerspace.com>
References: <20210413231958.GB31058@fieldses.org>
In-Reply-To: <20210413231958.GB31058@fieldses.org>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: fieldses.org; dkim=none (message not signed)
 header.d=none;fieldses.org; dmarc=none action=none
 header.from=hammerspace.com;
x-originating-ip: [68.36.133.222]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0e667491-ce4b-4cf1-51f4-08d8fef2b1b8
x-ms-traffictypediagnostic: DM6PR13MB3420:
x-microsoft-antispam-prvs: <DM6PR13MB342079DBDEC464004EF9C3E2B84E9@DM6PR13MB3420.namprd13.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: o7rhAxFkQHbURbv0DqjT9qEmkpWOnw/wYNhQwRbXH+gGBbsClVDS2gE++hNO3uhpCiwg/gTd8R7u7WrHF9DWrNwGnUoXaFQixUiCzIuZtmsOIckgtrlysF70YjWFFOU+baIeGvCQjZJO0yVbl65UaL4KXQn96vgnvV4VVNr8iMqbdEbQ5ng1T7iITreDPXHebMykdEBVeORL9leKQugu7JTpSuRz7Yw2/5YHIJUPIAdYCG+c/gD7wzUSU6cgMNFljDaqjacvBm4WrtjbDuzWybhHNvoqjDZbHbHe39A6HQFnVlVY+5qmDNggox8x78qBv6m7n76xULrESzwhPQ5McgqEGpZPtYE4AOhldsJD98TNYXUg4O2joRAP+ABuZo6lX3QybESnNz8A8ML7gmo2i5rVTKbnwAo6VOLw7DV2TIKbXXYa8vqVZOO3ZueOcptDabRa34oLWBH4dyJWpvQHEsfoA3rAJk9k2cC+RlpIQr/pRKuC+9TLkJD1fk73G/HqXe3XikUEi2sQDg4Q1/zLDiO3R9oxBe8tE5ZXrklVyGtA6B4YVipqWA1zcOeTG1p/QRHsvzxVCAtRGZG+9rz6d22YvTd6ee2EpWKjSp2lDdX1HJXmoP9Wdr4TQEFeIvftZIT9dVfr1VcaDWTycBEVWw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR13MB4733.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(396003)(136003)(346002)(39840400004)(376002)(2616005)(66556008)(66446008)(316002)(26005)(4326008)(76116006)(54906003)(478600001)(8676002)(64756008)(8936002)(38100700002)(122000001)(6916009)(6506007)(6512007)(36756003)(186003)(5660300002)(2906002)(66946007)(83380400001)(66476007)(91956017)(86362001)(71200400001)(6486002)(41533002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?utf-8?B?cWdsWGJ3MVBlbFlmR0ZZdVdnT01zYWVSelhPVmszWlF1ZEk0WUVoUVE1RHNn?=
 =?utf-8?B?czJ5Nk0zVEV4WFJ4Mk5WcVlMTTJndytVQm9IRmJtNnBtWE0xU0pxaEdoZzht?=
 =?utf-8?B?OUJPOXFaS050VGt6aGNBTmswZXpGWTA0SDJWUWh1UEI2cElaUUMrVnNFdHNr?=
 =?utf-8?B?WHl1Wk5WbmFjWU42UWQzdTA3cktmNWRJeGc1WUYvQ3lUOU5GQTdncjhhem5r?=
 =?utf-8?B?RjVUMWJyWldJMXNjQ1ZUQ0ttWCs4SytxaVp6Z3ZmUWg1T1djRWFlTm5PbG5W?=
 =?utf-8?B?VXZHYlpUcWdqT1dxaHdKUXRSRUZIbWdyS2pNaGYvOWNTVkJnWVh6R2ZpSitw?=
 =?utf-8?B?bEYxeHlwcWdRcms0N3hrcGJyZFBFaE1iaUVlcHg0Nm5rRUYvUkZyS1M0MzBH?=
 =?utf-8?B?U3BLNUdOOC9xMHA3Qkp0Kzg2SXNuVnZMcTZlUXJBUVNCYkl0TzNCZlNjMHJW?=
 =?utf-8?B?THBKS21CL3F2Z1pqSnhaYkgvSTk5Z3NzcG9lM0VoL3hNeUVCbkpNNnpJMU44?=
 =?utf-8?B?NjA2NlloeFBSbm9KWkdpOEtJdWN5WEJqYzNtcXNya21USEtIZm55L3h2ZkZR?=
 =?utf-8?B?RFZQN1BhaU9oQllVY3d5SGYyWW5oZ3ZZQTJkVmRkTG1HVmMxWWUrbHpHY0cy?=
 =?utf-8?B?aW9yVlU5U3ZjYi9DV2s3N2orT3hYVFFZd0I5cmVFcGxqRHgyY3ZMempkWFU0?=
 =?utf-8?B?S0ZMcVF6STZjaW93VHZMUFFpUlpxcUNXUVFMUVZsQ05QMWNlMmtwOUxxRVdw?=
 =?utf-8?B?aXFyTWpMaTFQdXFESGROcGNnYlREYkkvWGNEeml3cW1rMEFXdnVwZ2E3OVRF?=
 =?utf-8?B?YlRreDZpbFZEcW8vYUJQZ2trN25oU3JNMUE4YnRadE1MTWQya0lMMm9NWVY4?=
 =?utf-8?B?a1lPN3o0TXloT0c4bkRmenVZcnBSNy9ienFrSjZyOVJlQWlFc3E3ZnRROEY3?=
 =?utf-8?B?QXVVc25ZV0ZqcDh1ZFkxbjM3bmZwWEMrMksxRXdCbTJBQ3ZaaHk3a0lYWjJ1?=
 =?utf-8?B?djBRSWhRMDJybFBhMlZhcHd1ekJKb1dXL0FoYzVUQWRZWit2U1E0NU9QOUdH?=
 =?utf-8?B?ZEsrZ2RWTFNzR0RncjVIbGVqQlJkKzQxdjFWQTRYeERkMnNtTkxQMnpoc2Qw?=
 =?utf-8?B?Z0pVRlNRaXF3alF5QlNFaXAxaUVWbllKWUdkdDJVNFRmcGcySnMwZy9LOUJ2?=
 =?utf-8?B?QnZMYWI3RHZSOS9Fa0habDlZTktyN3Q3SyttMHpVb3JCTUpLampSVlNRZ00w?=
 =?utf-8?B?VkQydW91VWkxeS9wSDBoM2RYNlZHcTNIb3Q5eU5yaVpIbjBjS1JEUTdGK3Q2?=
 =?utf-8?B?ZHZpRFBBcXFDa1htSUE4N09pWHdYUUpHeGtDZ0s5aUp5dWZlVys4b2xyYkp3?=
 =?utf-8?B?Q3gxRVlvM3ZWZzMyb2dOV29ySXIvMVJPaFJ0SllheCsyek5FRWpwOERxQ0ZP?=
 =?utf-8?B?VE1TdUMzQm9ycjdHVVYrbzQwMER4c3JHMGlacHBPSXJUVUlzWE5leEhWSXVN?=
 =?utf-8?B?Wjl2SkUyeFdYcTlRaDhkSTlHcFR6aWQrTWY4UUcva1pUVlhlZnZUdFBQM2Zi?=
 =?utf-8?B?a2xnYnBtSkkrUHFIeVFpb0NIWUdXbG9BTlRGT3B1VVdwMFM4aWJKejJ4N0Yr?=
 =?utf-8?B?Tys3MFBNYlE1TTRkM2I3TkxkdkJYbjhxOWhGRzAvQnlJUWNBb3J6LzZuUGM5?=
 =?utf-8?B?OHR0R1NLOWJsZTVLQlQ2VnlZTkRDaXFGSWZPcWNCS3NQNEwvSnhKQVR0bzR2?=
 =?utf-8?Q?PXE6I4uyPQemtyQyJB9hfucjE5UIg65AWmSUnXS?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <D5AA71B3394FF9458925309C490C3DDB@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS7PR13MB4733.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e667491-ce4b-4cf1-51f4-08d8fef2b1b8
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Apr 2021 03:09:18.8350
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: M9yaY7CxOASSFekqWKZ/E67jxrynFXqW9hb+aKHaB2U/fn4yoQcTk/be6nfYLhc0ist9lTCfRaE+dEE3wsKSFw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR13MB3420
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

T24gVHVlLCAyMDIxLTA0LTEzIGF0IDE5OjE5IC0wNDAwLCBKLiBCcnVjZSBGaWVsZHMgd3JvdGU6
DQo+IGdlbmVyaWMvNDMwIHN0YXJ0ZWQgZmFpbGluZyBpbiA0LjEyLXJjMywgYXMgb2YgN2MxZDFk
Y2MyNGIzICJuZnNkOg0KPiBncmFudA0KPiByZWFkIGRlbGVnYXRpb25zIHRvIGNsaWVudHMgaG9s
ZGluZyB3cml0ZXMiLg0KPiANCj4gTG9va3MgbGlrZSB0aGF0IHJlaW50cm9kdWNlZCB0aGUgcHJv
YmxlbSBmaXhlZCBieSAxNmFiZDJhMGMxMjQNCj4gIk5GU3Y0LjI6DQo+IGZpeCBjbGllbnQncyBh
dHRyaWJ1dGUgY2FjaGUgbWFuYWdlbWVudCBmb3IgY29weV9maWxlX3JhbmdlIjogdGhlDQo+IGNs
aWVudA0KPiBuZWVkcyB0byBpbnZhbGlkYXRlIGl0cyBjYWNoZSBvZiB0aGUgZGVzdGluYXRpb24g
b2YgYSBjb3B5IGV2ZW4gd2hlbiBpdA0KPiBob2xkcyBhIGRlbGVnYXRpb24uDQo+IA0KPiAtLWIu
DQoNCkhtbS4uIFRoZSBvbmx5IHRoaW5nIEkgc2VlIHRoYXQgY291bGQgYmUgY2F1c2luZyBhbiBp
c3N1ZSBpcyB0aGUgZmFjdA0KdGhhdCB3ZSdyZSByZWx5aW5nIG9uIGNhY2hlIGludmFsaWRhdGlv
biB0byBjaGFuZ2UgdGhlIGZpbGUgc2l6ZS4gDQoNCiAgICAgICAgbmZzX3NldF9jYWNoZV9pbnZh
bGlkKA0KICAgICAgICAgICAgICAgIGRzdF9pbm9kZSwgTkZTX0lOT19SRVZBTF9QQUdFQ0FDSEUg
fCBORlNfSU5PX1JFVkFMX0ZPUkNFRCB8DQogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgIE5GU19JTk9fSU5WQUxJRF9TSVpFIHwgTkZTX0lOT19JTlZBTElEX0FUVFIgfA0KICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICBORlNfSU5PX0lOVkFMSURfREFUQSk7DQoNClRo
ZSBvbmx5IHByb2JsZW0gdGhlcmUgaXMgdGhhdCBuZnNfc2V0X2NhY2hlX2ludmFsaWQoKSB3aWxs
IGNsb2JiZXIgdGhlDQpORlNfSU5PX0lOVkFMSURfU0laRSBiZWNhdXNlIGlmIHdlIGhvbGQgYSBk
ZWxlZ2F0aW9uLCB0aGVuIG91ciBjbGllbnQNCmlzIHRoZSBzb2xlIGF1dGhvcml0eSBmb3IgdGhl
IHNpemUgYXR0cmlidXRlIChoZW5jZSB3ZSBkb24ndCBhbGxvdyBpdA0KdG8gYmUgaW52YWxpZGF0
ZWQpLiBXZSB0aGVyZWZvcmUgZXhwZWN0IGEgY2FsbCB0byBpX3NpemVfd3JpdGUoKSwgaWYNCnRo
ZSBmaWxlIHNpemUgZ3Jldy4NCg0KT3RoZXJ3aXNlLCB0aGUgc2V0dGluZyBvZiBORlNfSU5PX0lO
VkFMSURfREFUQSBzaG91bGQgYmUgcmVkdW5kYW50DQpiZWNhdXNlIHdlJ3ZlIGFscmVhZHkgcHVu
Y2hlZCBhIGhvbGUgd2l0aCB0cnVuY2F0ZV9wYWdlY2FjaGVfcmFuZ2UoKS4NCg0KLS0gDQpUcm9u
ZCBNeWtsZWJ1c3QNCkxpbnV4IE5GUyBjbGllbnQgbWFpbnRhaW5lciwgSGFtbWVyc3BhY2UNCnRy
b25kLm15a2xlYnVzdEBoYW1tZXJzcGFjZS5jb20NCg0KDQo=

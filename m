Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F6773E97BE
	for <lists+linux-nfs@lfdr.de>; Wed, 11 Aug 2021 20:38:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229869AbhHKSif (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 11 Aug 2021 14:38:35 -0400
Received: from mail-bn1nam07on2108.outbound.protection.outlook.com ([40.107.212.108]:12518
        "EHLO NAM02-BN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229846AbhHKSie (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Wed, 11 Aug 2021 14:38:34 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I8vYm8gVQK6No7HFcUP+RZuollPTEGQN+dm9K+bQUhhR3mnMZ3gR3t06XzyZC9zauh22wxsFa3R1w++3UAi4U5BYEqgKcIeigUauZbgvY2jULDuVJO6thy1A+y1Z6uBI7CF0bCIinbPcZAHr8ynfIowa82AEu5acOjyAWQnerYYULsfq+THPGlMNAPhpPXGFaDwmJlatplgqyNGGxpE8PZtj3rSetARuAhrGg43dfMeQja+UrfvE7w11bZx9q2dqcVjvPSDRZybTbiTKP8OeGfZ5qjiQHQY6O+hzEnfqTowhkUmKLrJQ4kNHvERPaefFI8o54uR/BdEw39OBNYVjiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2zcX4XuV7orWK6x4tOrvyMpfvUCs5Xa/xcdZ8XhDSYg=;
 b=cwpxWnWoYKt/qqCl3tfcLCsCoRd3D/dgb080DGdGDrd4jbip+C+s4vhRAdGHqHEZcKKnGYqJKPV6BakSAZhvACNmxvBwN/SpDL8LMs4O28bfkedEIHbVarjIyTJJQigXKz7mi3jpOLwgB+AGXdScXY2FJ/QsdlAfovvvA11T13TWgUDLjPImVozKZ9sY1oAXCcGKMucVEsVHQ7P4VukO9VwWpSjq4p89H+Jw/vAUeVpg/IyBC3V9qzowkua1I3qP2WEtqA7N6zSry9IN3gMRDwjZjgC3yjpJvTR184/w71Qo+cu/lVWtxc4ewQOZ6RtaKFHeiGjl/5FCbD9nYJayIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2zcX4XuV7orWK6x4tOrvyMpfvUCs5Xa/xcdZ8XhDSYg=;
 b=FohBpuXlq1NQ9RT2ykPs/EUdemjuPIm4Wvll9tDQ8psGjX9OE21lyw6dd8T4wnagHHGzeEWBYWtfy0cWZbViLHR/n4GrZj00Yv9er+oTgYglo6bi/x+hlmq/Guqr2CAWHzBxgzUEl7ONEKn1DHQ6ht4IQrDfBD5E9atlvxAEM9k=
Received: from CH0PR13MB5084.namprd13.prod.outlook.com (2603:10b6:610:111::7)
 by CH2PR13MB4473.namprd13.prod.outlook.com (2603:10b6:610:6b::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.6; Wed, 11 Aug
 2021 18:38:09 +0000
Received: from CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::185b:505d:b35c:a3a2]) by CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::185b:505d:b35c:a3a2%8]) with mapi id 15.20.4415.014; Wed, 11 Aug 2021
 18:38:09 +0000
From:   Trond Myklebust <trondmy@hammerspace.com>
To:     "trbecker@gmail.com" <trbecker@gmail.com>,
        "anna.schumaker@netapp.com" <anna.schumaker@netapp.com>
CC:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
Subject: Re: [RFC PATCH] nfs: add rasize mount option to control read ahead
Thread-Topic: [RFC PATCH] nfs: add rasize mount option to control read ahead
Thread-Index: AQHXjtRRbbniZtoOdU2zpL2C+kjZ1KtuomYA
Date:   Wed, 11 Aug 2021 18:38:09 +0000
Message-ID: <34af7b91a9ff18cf8592427efa759dca1433341c.camel@hammerspace.com>
References: <20210811171402.947156-1-trbecker@gmail.com>
In-Reply-To: <20210811171402.947156-1-trbecker@gmail.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=hammerspace.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6c61ca4e-5724-4bd4-7e82-08d95cf72ae1
x-ms-traffictypediagnostic: CH2PR13MB4473:
x-microsoft-antispam-prvs: <CH2PR13MB44731CA304092001706B09ABB8F89@CH2PR13MB4473.namprd13.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: GcuHjGkKd0tdT4TWlcpnMma+vzMzg7ad6cMhz/xztbCA+kEFEqkQR2uEi/wBxqkEsSnSxkjLwJHLDXsPXQ0pFRJMaAs/+0xCifnM0Mttd2xEgy4yxBdZfi2rxmpH/W1rEFjWcDtq//57KyhRG9sTnm32WheNfa2nccHUgj8/sp0psbU8PcIxZjdIS8tV+piVCbp47NnFuNHsc6wxfpwiK+9ZDXZdfvcx04OO8vrGmYt7WhdK4uSEHwZFLlNRWYZzRwYtqthhHjFdirSpytvOzA1+UaKQx6svVD1t2TyjRQuLghmEBOmT5RLFIJa2weisgWY1U+93Ga5WKGwiHOZ8wZXa/UGgjlND6EVGVw/5p0wyeL0L5WAGwMOLu/ydlejB4YAHMEHQ01DJhEPxI5BoijfefyFdTkD3YMn8LeqR4IU3W6Cwcaw2FPVV5uuhDCZlUm9SWckFb8tM+Ey9azIupCLjk1H8HVze0Tsz1/PO1vwF7XgE4f3bkZfTQt5IHcqTx7vF1Dt/eojpUABUKMMEAYcrdjKvQCZIVzUYzbM7idwL5+ZiJN/tFKP47g9XQGGChi5ygLqYRVHy+/HkOJK8mM3E68oGQCWO9bSuo2o3+12CWt6H3+iJfc4NZBzKSwLsa1RXxTbYi81loe9eldcsUv6BwpYWFp/H+qaSnfyuavMdGrSYVplKO0744kyz03m7Wj52PnV2uirunUl5aqp+Bw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR13MB5084.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(4744005)(66556008)(86362001)(508600001)(64756008)(76116006)(83380400001)(38070700005)(26005)(186003)(66446008)(71200400001)(6506007)(122000001)(38100700002)(66476007)(66946007)(36756003)(6486002)(4326008)(8676002)(8936002)(6512007)(110136005)(2616005)(2906002)(5660300002)(316002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UlFEcHJWN1RtYzhvalVOd3VZN1pzZGtua2dYT2lzbEo5Q1FJTmsyL2hmS2Nl?=
 =?utf-8?B?ZnBjMTNUV2tvT3h4Y0MyVS9vQ2NrVnV4SnpLVmRBcnYrdjdYeG56V0txQ3l6?=
 =?utf-8?B?N1I3ayt1alZhdWZscnNuZTJjWUpoSkpqRTQrZllvaUtxYkJQTWRSNnlsdjFh?=
 =?utf-8?B?bW9qTDNvQVlYZWEvVW9IZjFJaWNHUklnV0k3SDFiT2dpanNNbHhlRjVXcTho?=
 =?utf-8?B?L1dBSHdaT01uSlFpWDJMVTBoZExVTTA4cDFrNXgvb3MvNm4wVWQ3VUR2NnRj?=
 =?utf-8?B?V05PQnhEY2NsOXFYQTgxOWRQUjJzOFdPZDlzRUFLblRqaGRsWld0RGtyU0U2?=
 =?utf-8?B?MlNFOWd3VFBqd1hLN3ZFUGY5czNmOWY0azRZaFlVc2ZBWCtkWXkvMkcrSE5r?=
 =?utf-8?B?WEk2dG1LdWdDU2VnNGVlMFBGOU42Q0I1NzJ4eTgzcmhWVlBXM0VNL2xWaDk4?=
 =?utf-8?B?SHh3V0d4Nmt0SkJkclhvNE5JQ3crUjI2MTVuRisxSU5ZdExRLzBTZTlmV1hw?=
 =?utf-8?B?SWJrVVVJVDU2YzM4NDFKUWdoK3lFbUw0MzE3YkJYRDJVQ2pEcGsyS0FLM2xP?=
 =?utf-8?B?dzhzK0kzUjE1MHhJcngwcDlUSW9Zc3ljaExmZzAwbENZWFZuaTRiS0lLOXVz?=
 =?utf-8?B?L1RWUWwwei91ZFNMYk8vQnZQamhtRUg5YXpVSWw3ODhod0lvck0zcmQ4YXMw?=
 =?utf-8?B?NU5RUkNpak94TDlMZzNmang1T0tYWXNibTA3eFdFS0h3VjJBZWhzVHpvdmFa?=
 =?utf-8?B?VHR1TWtLV2x2SExnM0ZCcXU5WXFEbkpQMk5TNVVHb3FHbi9GNkpTSGhINFh6?=
 =?utf-8?B?OHBZd3BNdlFubzk1OVV6R1dLbzNTSlQzN2lEK3JyT29QTExiVlA1emRMWFBw?=
 =?utf-8?B?Zjc0RFBGVzJJOEZYditYMWdtZ0NIWUo2TWRKa1FJbEFzRUZ0bHNRaUZnN3Ey?=
 =?utf-8?B?Q3U4Z0E4L1huczFPc3FjL2U3TnhKUHU0QmFEOUdSSU1QYWVBUjg2RTEyYTVi?=
 =?utf-8?B?Ly9FZHRCZStOQ1ZVUEVCdzRyNHlqZWpTazZhalVMamlJOEduNFhnZUpSK3Bv?=
 =?utf-8?B?RzQvdWFVUDNDbHhuVmYwODAySmthUzRpUVB2eC9vRDRLRTZ5OG4rQklYSjV0?=
 =?utf-8?B?RG9ZWjFLOW10K3hHNWRLRjdRbUJXOXhWT0R3VVR0eUxIMlZtbjgyUlV0dGpZ?=
 =?utf-8?B?SlNZSG5QVVFGd0hmZXdTYS9PZ2xqN2JLdlAxT0h5eDlnZUhHUWxub3pSWjd2?=
 =?utf-8?B?NFlsSHhEVEhweW1JMGpaSk56RzJ2VXVha1NoLzlvVGdqZUhMSlJYOUhqdURV?=
 =?utf-8?B?OEhMSHpnNDJwMVRjbTlPRElIU0lYSUF1cFJ4Q2xzeE1ZVFZ5aEZ0cEU4L3h0?=
 =?utf-8?B?SWcwYk9kb2hXQnZSbHA2em5iMVM0cHl3UFNBdCsyWXdRTzFBcEoxeUJuZ21S?=
 =?utf-8?B?MURITEdtK1hJeWw3cGdZLy9wVFdPNTVhSWhLTlBrRDR6d1RwMFdmT0VLWHlK?=
 =?utf-8?B?c0ZaUUtHOEliaU5ES0JseTg0TWl3eUlKVDVYaXN3SHZOREVUSTgvUVQvL1Z5?=
 =?utf-8?B?M1VJYVNOTG5YaCs2WitYcVpJMW1CNWpLaldjN01NN1R6RklEYjZ6cCtuS2tJ?=
 =?utf-8?B?cWgwbWZxNG1UZTd6UVVtZ1VCSHZhWktMQ0M3NTZqNnEzZHFSY3hDMFRqZDRG?=
 =?utf-8?B?Z3ZYRjlVMnZxakRPa3dGeFFlaWhKQmVVSUkzTzBjMlNvWWx2NDNFektlQUxV?=
 =?utf-8?B?c2VYdGF5blFIU0dacUlVM2ZTcGRCd0VYMHhwcWF5VUV5TTdPWWlRYjQwdmhT?=
 =?utf-8?B?b1NDNXBpZDhYV0hxbWdvZz09?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <2762452191B9F44FBCAFE1377EA417F7@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR13MB5084.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c61ca4e-5724-4bd4-7e82-08d95cf72ae1
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Aug 2021 18:38:09.3882
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DwobcHisMyeVXZ0L4KzGf6hX9HOr9UBwFvB3R2y9qh0E2Q86JqeYKKDLnoX9zpK6HbjU3Mg6f589uFscCoWFow==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR13MB4473
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

T24gV2VkLCAyMDIxLTA4LTExIGF0IDE0OjE0IC0wMzAwLCBUaGlhZ28gUmFmYWVsIEJlY2tlciB3
cm90ZToNCj4gTGltaXRpbmcgbmZzIHRvIDEyOGtCIG9mIHJlYWQgYWhlYWQgaXMgcGVyZm9ybWlu
ZyBwb29ybHkgaW4gaGlnaA0KPiB2b2x1bWUNCj4gbW91bnRzLiBBZGQgdGhlIHJhc2l6ZSBvcHRp
b24gdG8gc2V0IHRoZSByZWFkIGFoZWFkIHRvIGEgbW9yZQ0KPiBzdWl0YWJsZQ0KPiB2YWx1ZS4N
Cj4gDQoNCk5BQ0suIFRoaXMgaXMgYW5vdGhlciBtb3VudCBvcHRpb24uDQoNCi0tIA0KVHJvbmQg
TXlrbGVidXN0DQpMaW51eCBORlMgY2xpZW50IG1haW50YWluZXIsIEhhbW1lcnNwYWNlDQp0cm9u
ZC5teWtsZWJ1c3RAaGFtbWVyc3BhY2UuY29tDQoNCg0K

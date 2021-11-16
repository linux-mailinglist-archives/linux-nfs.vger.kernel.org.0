Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C48E4533F4
	for <lists+linux-nfs@lfdr.de>; Tue, 16 Nov 2021 15:18:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237234AbhKPOUp (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 16 Nov 2021 09:20:45 -0500
Received: from mail-mw2nam10on2100.outbound.protection.outlook.com ([40.107.94.100]:24096
        "EHLO NAM10-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S237089AbhKPOUn (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Tue, 16 Nov 2021 09:20:43 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OhmwbUal5HOZRu0j7ydG6/9VogzWwFdeUK7i4uUkYNyw3Zeg0dZgQSegkHfvWSWw6X0gfGN7tJuRsM2ZdNbAJl0JkoSGz7FvEtWAj0WRbsQpjZdq7ErfbfOVtXXoBxLGGSuc0esA3vKLxgsiA40Sug/EWNZUnIlAORCMXiAVNwJFniIMrLlgPiyE6Yfvz56rx8QznBe/TD6KqgWTNH0mugH4o8l0ZZONQz5kIg+dxqW/hDAS7rRHTT3tHj9rbaWQHJfVxr/hkW0upATsK6S0RtIR1skyA86RT8INvCxdSgOrLbDUU/7jeSWV266pRu8PR7neCZPwH4YE3bS9u2MkcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=js+4cN/2xmWvTbughDlAueQ88pCCmPUvvff5e5dJCQs=;
 b=PqGj8YQhZh8cdBy1ZLwmDFg0xBFecMnG3avwwRvY6DUuAPDseH65SG1sOOzMPO+9vluiKj16n/lTvgBBMzRahFF/WdyntepQsFBeKA9C63hqM4nX7j/VRTe9Fn3+Oy5WdS6hoWU0AcLlg1f279/l9/h9z9GwR5yPBjP9B81v+F8Twhj4/dZ5ZBTOUayJihe3DcQMb/bBn+IRLyr2wIvYpZM9d259BuSX6GKz8Ul2L+MDGEsLok29o5gRIpoTC1yJdAOilYzk+GEnS5BmQOR4eS4pHk+p4eI13M1ltVTXgDNJqw/ye4f/kEmgUVgAcP5lSysdO+K5c3EguMrUv9nKLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=js+4cN/2xmWvTbughDlAueQ88pCCmPUvvff5e5dJCQs=;
 b=RRZ4NI4G/veo59FT9imolV3Q2QJpRQdHkaGbKSytkn8F0biLZoRkBTrEp11JiNMf/GivMEpwk3LDFYIN8XUsQNUKzq5EusWEX6HKef4IGeI++j0DkGB/aFHr+rD3Y3QMWWxIj+XB3sKTIDQNbP3vEYRxF44IR+gdBt7J84wjenc=
Received: from CH0PR13MB5084.namprd13.prod.outlook.com (2603:10b6:610:111::7)
 by CH2PR13MB4521.namprd13.prod.outlook.com (2603:10b6:610:63::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.19; Tue, 16 Nov
 2021 14:17:43 +0000
Received: from CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::288c:e4f1:334a:a08]) by CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::288c:e4f1:334a:a08%3]) with mapi id 15.20.4713.019; Tue, 16 Nov 2021
 14:17:42 +0000
From:   Trond Myklebust <trondmy@hammerspace.com>
To:     "bcodding@redhat.com" <bcodding@redhat.com>
CC:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "anna.schumaker@netapp.com" <anna.schumaker@netapp.com>
Subject: Re: [PATCH 2/3] NFSv42: Don't drop NFS_INO_INVALID_CHANGE if we hold
 a delegation
Thread-Topic: [PATCH 2/3] NFSv42: Don't drop NFS_INO_INVALID_CHANGE if we hold
 a delegation
Thread-Index: AQHX2vDLUMHGAI80skqH9d4qS3nyMKwGL5YAgAACgICAAAFwAA==
Date:   Tue, 16 Nov 2021 14:17:42 +0000
Message-ID: <879b0f03b5c3b786568aaefd26bc8c714e1d7aae.camel@hammerspace.com>
References: <cover.1637069577.git.bcodding@redhat.com>
         <c91e224b847e697e42b25cdc36cd164a61ad1ade.1637069577.git.bcodding@redhat.com>
         <a06d3d97a865747058c7d1cbcd4f70911c336fce.camel@hammerspace.com>
         <9FE34DCC-0F28-4960-B25C-B006DA6D9A38@redhat.com>
In-Reply-To: <9FE34DCC-0F28-4960-B25C-B006DA6D9A38@redhat.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=hammerspace.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 61704150-0c31-4951-504a-08d9a90bdac6
x-ms-traffictypediagnostic: CH2PR13MB4521:
x-microsoft-antispam-prvs: <CH2PR13MB4521DE6F4E3D5E2A76143C4BB8999@CH2PR13MB4521.namprd13.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: YptbPH8Q1WOjCNx8AQAFPB9mGCytvfvW7u3FEX2r0BdSMJ1NyEUOBcB9LyNxhSvF08WbDV4yJZe3koFScj7gcgeIIYEYVCA+H2ihSMIxCXQhzN0JgQBT500ddTRnpQEHF8lQGCxzJWTjjVnQ0oiRH5wTtvB/oqrbuVAx+SsV4rtLBaa8Ck2rR8SwPHPjJtt1LsjozJCQAEH4IY7LpdRpdBaAOmHi+ygUTHR0zAJpmsMOi8mnd9+7qkxXYFhckhJWjKW36bicnCGBRdpmi8uDMLR0ynndBPqrZ4K/fS/fij6ZM5BPtXTV/VjaWbcm6LjKIn92Ky9il+w8LR4TBIOMMpmYBmaV+J2vsvvg7mLJXkeCfJo7UuAUFwe9/AcMLLwDbyWUrVtH7ld5vFclKW3j7SzY5fDdB9l9YnkyYyI7hIeB9RuyhB8uIEzRf9l+Tg3UXNP/JfjPrAHqB6hNO89LSodIsxkNkhRgN2AbgJFnVGkcNpFrOTHaSAKcvQ3mF26aS1Qwu5WW39A2tIc2wHZb6v1uJEkoG01/tvT28Fl97RZ/QZbtE548chmMt6hFBatzrK7aY1pqsUsjd1Sukt5Sf4LGTm/mUzL7ZXHkWqQXPKGn71FwAPlJz5SRbUhRFNNnvdhv9326XA0GHL7UodLuDaT5ElVjGnHTzlQmAFWF2Nz77Nm/fclFKxt24JjXbJH1GXmQHWvqJtTk+BNJbWE33A==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR13MB5084.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(39840400004)(346002)(136003)(396003)(366004)(376002)(38100700002)(6486002)(54906003)(316002)(86362001)(8676002)(5660300002)(38070700005)(2906002)(8936002)(186003)(83380400001)(53546011)(26005)(6916009)(6506007)(36756003)(2616005)(4001150100001)(508600001)(4326008)(66476007)(76116006)(66556008)(64756008)(66446008)(66946007)(71200400001)(122000001)(6512007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?eUg2MkhhQUNmVitlbWNvaVZXeHkwbzl4dHZmdGRUYWtTTmNlUmp4Mm53T0xY?=
 =?utf-8?B?bysvYUpCejNlT1NKRFVpNUk4UVBYVnpPN2RSNTVMSWo2YUJEZWZGTXgyK3BJ?=
 =?utf-8?B?RnNoUzIyQ3dSVGNNSEhWQmJKLzFhdExWdmxEY2VtbFBJNFQwcThvRWlldWNQ?=
 =?utf-8?B?Qm9weTF5VE1WWjFOb0NsVmQyU29UUmtvQkhkeGhhVjk1amllSnNCaitWelQ5?=
 =?utf-8?B?ZCtsck9YWkQ4eGVhbXoyMTVoWGIyU2FtbDV6aU15djRaWkxkZnR4aVVoWCtX?=
 =?utf-8?B?N1RScjZ3ZU96RUtsK2Nxd2JURlZLOWJlSUN2VlZUTjEzNHVGS3BxbEdXSDZY?=
 =?utf-8?B?VmdGY1FiWXMyRU9QNDlUUnVEelcrM1paT0pBcUdLNmkxcFFqdlh2MEdLb21x?=
 =?utf-8?B?ZlRJcVkzcWNCMlZXQzQ5cHVZeFFZN1UxS1hFOWVna0ZhWUxyNEtIdW0rWkZT?=
 =?utf-8?B?TEVyc0FtQ1hicUNmYVluUExXR2J0Z2lCVk9YcVp1VHVwV0ZMZ2pjT0ZLczZQ?=
 =?utf-8?B?QjVDeGw2bXUwdUZ4K0lFRml2NlEvY2xsS29XcTBZMXo0NmRRb0d1dlg4NzNB?=
 =?utf-8?B?VVRuZ2RlVGhtVWZwNnNMQlBDSDQ3QkxTc09zaCtrRjFIQmtkTUt1WnpSM3J0?=
 =?utf-8?B?Ti9QR0FkcXZrWmp1dlBZN0JFUzR1Mm5qSmFuNGhSK054WjdwNXR4WjB1UVBB?=
 =?utf-8?B?am56MW80NmMzRktHaDJxMkF5QUxpVjJUTEhpUUl2WVp4T2JTb0hTbzduNUs1?=
 =?utf-8?B?RHV2clpqbUEzU0ZPNkhtYlBEdTNDTElJaklzM0FlTWJJTHR4TmNPQzR3dzN4?=
 =?utf-8?B?YVh0M2ZPSWZGbHNSd2pjcDZHcVVjZmpnZUFweEdUcDREY0pBR1U0SkpDMEhC?=
 =?utf-8?B?d3Yzb2ZwdVU3b0lFN3hvYUxBVnFPc1c5WDluNVR5TU9wV0hiNDZ6VGFzbno1?=
 =?utf-8?B?V1FqY29pajFLeWJQa1FZcjBVQXc3Z0xRSDd1VEYxbkl5QmhhWGJ4ZTRqRzRs?=
 =?utf-8?B?MHNzelozRXZ2QVFyV3dMTXM3WFh0T3IvTGJYOWxyb09qS2ZIVEdIQm5RNmtW?=
 =?utf-8?B?RFovRXJHaEExd0kxeHVCNXVHOW9CN2F0c1RuVzBza3hlOC9YU2NsN2JNSHZ3?=
 =?utf-8?B?WlZDVVJ0bWdET3J4Z3cxZWtmU0VRREZ4UzZOU3ZjYXp2NXNlZVlwYmlJbGlw?=
 =?utf-8?B?UTVOajByd2ZMa2hCZGM5Ynh1NWQ4bUZUNTVOcUVHZ1U3eHVtMUVzYlo1YlZP?=
 =?utf-8?B?eXN6UmhCY3VTRm5HK3ZQY2ZRUEpoWHdBa3BCRTVSNU9lL2ZmZE1UOUJFK3VT?=
 =?utf-8?B?NmF3YXhiR3hQYlEwaFFVRUp6RVBGZ1BVcnpIRXhVRnJ2UHBSb0pOQnB5eGZl?=
 =?utf-8?B?UDkydEQwd3NIdmt4RkVFTHdaeTNDcTZTelNQUVAvTTZaRElXbU1hekJvUFVm?=
 =?utf-8?B?S3IxSHA2MmxiWGo2UWdWS1VjNElYdjJjdnFyYzBLZjJ5K05rYmlYek5vRHI0?=
 =?utf-8?B?SGR0VmdzZHYvcWwxNXlYZDhDTkNJcm16Q2c5TStlUVU4VHdIWTcwYVFtVlll?=
 =?utf-8?B?ZG5ONXNCcjNwVWNKUW9VQ2tvZ283T1NkaWl5Z2hTbW40UUdEa0t3YzFaZjRo?=
 =?utf-8?B?aVFSei84NzJ5WjNCZkpiV1UxZEZWdFJ3WTZzdjVKenZUVzM4OVQ1WHJPMVM1?=
 =?utf-8?B?K0VKNE1BSmJwNnd6YnJZYlhnTU4zdDc1V214REdOTGg5WmNaUXVkOHhzaVdu?=
 =?utf-8?B?eXM5L282emRHbnhON1Frdkg1aTBYSlVZT2REeUl1T0ZoWDBQdUdzZVJFQ1V3?=
 =?utf-8?B?emxodkNvc2xDQTdUeUJXSDQ0M2xmcG10b3J4dGVBd3h5NFh4aTVkVzBCak00?=
 =?utf-8?B?RlJDTTZkcG51SkNtN29pcWlMbCtBNnMzV3VZdDg2QlFwdHV4U01US2tOemRs?=
 =?utf-8?B?VmJvMHlXYjdraVZ3cHNvMUtzVHREaHhFOE81bG9jRnpMdU9lUW1RTjVCWHFM?=
 =?utf-8?B?TXZRT3p0eG5GZFdTOWZkVUpuNDE5K0l3RUxtT3prVmx3T0tTVmtDdHBmTFVO?=
 =?utf-8?B?cFNORnNoMnlsdE5pbGl5LzhsNHlDRDBQQTBDZkVOdFRRVVNVbVd6RGk0T3Fj?=
 =?utf-8?B?QjdYb2tPbUVoS2ZRQ20xTjVtZ29BS2UzR2JLYitBWldDRWFJTUx5akpod3hU?=
 =?utf-8?Q?af825vAFPOJPlqk3Z/ljGK0=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <9FAFCEFD83F07549BA448AD7DC0B59B9@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR13MB5084.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 61704150-0c31-4951-504a-08d9a90bdac6
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Nov 2021 14:17:42.8983
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bzJhltsDI6keorEQt+BvcRfM/cB8FLkQNiDcVfM0iJEg/NbpLRwV50z0Ef9YBMOTBWOKL9eF7UN2d9Aju4KIOQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR13MB4521
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

T24gVHVlLCAyMDIxLTExLTE2IGF0IDA5OjEyIC0wNTAwLCBCZW5qYW1pbiBDb2RkaW5ndG9uIHdy
b3RlOg0KPiBPbiAxNiBOb3YgMjAyMSwgYXQgOTowMywgVHJvbmQgTXlrbGVidXN0IHdyb3RlOg0K
PiA+IE5vLCB3ZSByZWFsbHkgc2hvdWxkbid0IG5lZWQgdG8gY2FyZSB3aGF0IHRoZSBzZXJ2ZXIg
dGhpbmtzIG9yDQo+ID4gZG9lcy4NCj4gPiBUaGUgY2xpZW50IGlzIGF1dGhvcml0YXRpdmUgZm9y
IHRoZSBjaGFuZ2UgYXR0cmlidXRlIHdoaWxlIGl0IGhvbGRzDQo+ID4gYQ0KPiA+IGRlbGVnYXRp
b24sIG5vdCB0aGUgc2VydmVyLg0KPiANCj4gTXkgdW5kZXJzdGFuZGluZyBvZiB0aGUgaW50ZW50
aW9uIG9mIHRoZSBjb2RlICh3aGljaCBJIGhhZCB0byBzb3J0IG9mDQo+IHB1dA0KPiB0b2dldGhl
ciBmcm9tIGhpc3RvcmljYWwgcGF0Y2hlcyBpbiB0aGlzIGFyZWEpIGlzIHRoYXQgd2Ugd2FudCB0
byBzZWUNCj4gY3RpbWUsDQo+IG10aW1lLCBhbmQgYmxvY2sgc2l6ZSB1cGRhdGVzIGFmdGVyIGNv
cHkvY2xvbmUgZXZlbiBpZiB3ZSBob2xkIGENCj4gZGVsZWdhdGlvbiwNCj4gYnV0IHdpdGhvdXQg
TkZTX0lOT19JTlZBTElEX0NIQU5HRSwgdGhlIGNsaWVudCB3b24ndCB1cGRhdGUgdGhvc2UNCj4g
YXR0cmlidXRlcy4NCj4gDQo+IElmIHRoYXQncyBub3QgbmVjZXNzYXJ5LCB3ZSBjYW4gZHJvcCB0
aGlzIHBhdGNoLg0KPiANCg0KV2Ugd2lsbCBzdGlsbCBzZWUgdGhlIGN0aW1lL210aW1lL2Jsb2Nr
IHNpemUgdXBkYXRlcyBldmVuIGlmDQpORlNfSU5PX0lOVkFMSURfQ0hBTkdFIGlzIG5vdCBzZXQu
IFRob3NlIGF0dHJpYnV0ZXMnIGNhY2hlIHN0YXR1cyBhcmUNCnRyYWNrZWQgc2VwYXJhdGVseSB0
aHJvdWdoIHRoZWlyIG93biBORlNfSU5PX0lOVkFMSURfKiBiaXRzLg0KDQpUaGF0IHNhaWQsIHRo
ZXJlIHJlYWxseSBpcyBubyByZWFzb24gd2h5IHdlIHNob3VsZG4ndCB0cmVhdCB0aGUgY29weQ0K
YW5kIGNsb25lIGNvZGUgZXhhY3RseSB0aGUgc2FtZSB3YXkgd2Ugd291bGQgdHJlYXQgYSByZWd1
bGFyIHdyaXRlLg0KUGVyaGFwcyB3ZSBjYW4gZml4IHVwIHRoZSBhcmd1bWVudHMgb2YgbmZzX3dy
aXRlYmFja191cGRhdGVfaW5vZGUoKSBzbw0KdGhhdCBpdCBjYW4gYmUgY2FsbGVkIGhlcmU/DQoN
Ci0tIA0KVHJvbmQgTXlrbGVidXN0DQpMaW51eCBORlMgY2xpZW50IG1haW50YWluZXIsIEhhbW1l
cnNwYWNlDQp0cm9uZC5teWtsZWJ1c3RAaGFtbWVyc3BhY2UuY29tDQoNCg0K

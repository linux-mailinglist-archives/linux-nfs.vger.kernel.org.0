Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E1A23B7244
	for <lists+linux-nfs@lfdr.de>; Tue, 29 Jun 2021 14:45:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232856AbhF2MsZ (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 29 Jun 2021 08:48:25 -0400
Received: from mail-bn8nam11on2108.outbound.protection.outlook.com ([40.107.236.108]:37729
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232685AbhF2MsY (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Tue, 29 Jun 2021 08:48:24 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VwsGCwERMvdlIF7T66C65fEF3Jc5n6ghmJzNAqc1WpeHZO+QU4R+OdoV5KLxh6tmCKjTL3dio3KB7Ka3JW/4wAg91Q0XZ4Ox6CGiuD2hpG1Kh2vXh9qmZTuka2Gu7OdBUYHp/XhU/yEaeGMXNEB4sahFRyKiPK6n35kGSDqM6G7ip9UG/EFdTriYaTd8XV/H0RL1NaLLqfk7vuS7bQrSdWp1OMbt/niOD+zmAPTNmwlAtduwU7JxkEGqLK4yXwlR8sF2a1dKuc/J7AkI0A2+E3yMrcRG1x30WSQrwcUL0SsbafsI3pX72K3ZTDtLzQCwnqoIM4/K5eTh7FEOwGHt2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rXDUdGSLb+DZgJ/7cFEQr1sXFy9H0iPBoSlFO0uhs5M=;
 b=QPIC0+U0nv0GsBwx6GrXhn1Pwg5JvnupBCyyCfB/uAmp7TqoPQeO8Q2QEVQiCql9i+1FH7JuUDj1TLyZdekPiaYUpYdkW6uIt5MGeo6QNBSzqBilUukIPPS3kjhmOh7JYQJma6TTFp4fO4qljCZhJWug/6zOPLy1uDFWRA180KeTmU4P0rTc+MXcNIbcuksQRF0lzstBzVT96h1Y44HU9s6zp8TMQXQfalbSWwA6zGra4NJeioiF3eh0+BnFavn51sgCRipaazgbqeeVjr3zCvDvnMWMhAGTHuwws+PxFXB70TLZbzuQpErzPPqPyvxYwN3SxIsIx/Of5X1eR1bpdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rXDUdGSLb+DZgJ/7cFEQr1sXFy9H0iPBoSlFO0uhs5M=;
 b=NmXeDFxHEeKU/yj1q/KiE7hn+L0CvhXodcWwuH/RWKk6tTtPhOK4SiPdyeNnKIYK4WDWWcyM+4PPoc64RkM31qzrydBL3MY5ehI60KQ4U0zzA78laiTkiu43joEkia9a9A3U6D9+zQymZ61BqyKtNJJiWgcz3feEoYzP4FT3Cvo=
Received: from CH0PR13MB5084.namprd13.prod.outlook.com (2603:10b6:610:111::7)
 by CH2PR13MB3334.namprd13.prod.outlook.com (2603:10b6:610:21::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4287.13; Tue, 29 Jun
 2021 12:45:52 +0000
Received: from CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::f427:dd84:789e:6c57]) by CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::f427:dd84:789e:6c57%4]) with mapi id 15.20.4287.022; Tue, 29 Jun 2021
 12:45:51 +0000
From:   Trond Myklebust <trondmy@hammerspace.com>
To:     "dwysocha@redhat.com" <dwysocha@redhat.com>
CC:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "anna.schumaker@netapp.com" <anna.schumaker@netapp.com>
Subject: Re: [PATCH 4/4] NFS: Fix fscache read from NFS after cache error
Thread-Topic: [PATCH 4/4] NFS: Fix fscache read from NFS after cache error
Thread-Index: AQHXbESDVNEfZ6l1Z0mr+wlKyxwP6KspybkAgAAiQ4CAAA1AgIAAHcgAgAAO1gCAAJCmgIAAOlcA
Date:   Tue, 29 Jun 2021 12:45:51 +0000
Message-ID: <321b6e11718979668b5ab129a7048a511a9886a9.camel@hammerspace.com>
References: <1624901943-20027-1-git-send-email-dwysocha@redhat.com>
         <1624901943-20027-5-git-send-email-dwysocha@redhat.com>
         <efc373dd3f321f2f45e749a5edb383f2a11a7b78.camel@hammerspace.com>
         <CALF+zO=CFMYUGRG2m77XQy=LVVd-Zf_a+oQrJATymu-iqHRNtA@mail.gmail.com>
         <e9f38da48bfaf1b43546e273493afc907c52def5.camel@hammerspace.com>
         <CALF+zOma0-M7Nhsz1=XZR0ihFGe4d4v7ofr4Emjg2VJWeUj9uw@mail.gmail.com>
         <ac3deecf386901f688b0c682237326f468a625ef.camel@hammerspace.com>
         <CALF+zOn=p6wuZ_pdifwWtLOUsiArkxBHHVDEnYcxsBdQy1LtVw@mail.gmail.com>
In-Reply-To: <CALF+zOn=p6wuZ_pdifwWtLOUsiArkxBHHVDEnYcxsBdQy1LtVw@mail.gmail.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=hammerspace.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 55d8a55b-6f30-4219-7cdc-08d93afbd416
x-ms-traffictypediagnostic: CH2PR13MB3334:
x-microsoft-antispam-prvs: <CH2PR13MB3334240AEF63881E6569B467B8029@CH2PR13MB3334.namprd13.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: zWdyLZx3XcGiRBb8GSwSObnj/6rNjK2Q649ubhRzX/0tNjseg/kIJRLK/UcFY1u5zkDGpENbJmfFbR/jp+TwPoC+zGeu2I+2swjrlrWvgsIeO7JIvYpS37hRhtr3qE1NxYGKL7eCZCOcfobduyg+yixu6vNZFHw9OtP44HDDWpmZ0tex6INst2hWSF/e0Nqmevr9yMSyysnQYv1e/W+6kbSv7fxR/0cGqsnKWMpL6vR/GF8c17dkUtgZFUbRQ4ABJrKMrYYpp8dHWJ9uPI7NOcEcbwlaoLLesVqIw6Ik4fqxac9m8fVSjbti1Ywp4SbTilm242Ng+T72B+5S3DFO+kqWFnWlaz2FLHWFmA09yCYcejGxC3FrPo7QO9a+BBumN/1RT4m/Ft6ERUjuHV19B9AMfhz6KNtu2UiEDl4qz48Ydog4zwmL33/7Sg4lrzc1SwAzHiZqv9vk6YPuAQk8fnCb+pX16fwXWJWKuuxMgR74li0FCstfwKV1UBZqXLMbVubYP46JC4u4xvFvQzrGBwnwBM9CC3is69EFDSyO3eKxC2dUzsiu78hJS3+CH+55QDPu+ovVwQyExwYwgEYXqNXAUNNDPVlbkE3JscEO0aehTis/pLt54m+O5a8N2x2rLlGWFGfwXa4scdNsWXAbUQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR13MB5084.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(376002)(366004)(346002)(39840400004)(136003)(396003)(2906002)(38100700002)(6916009)(86362001)(36756003)(122000001)(5660300002)(53546011)(186003)(6506007)(83380400001)(26005)(6486002)(2616005)(6512007)(478600001)(66446008)(8936002)(66556008)(64756008)(71200400001)(8676002)(4326008)(316002)(54906003)(66476007)(66946007)(76116006);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NnZBNUdoUWlmbGN0NGlra2JKdHMraWpBbWxZZlo2ZGx0ZWs2OU9IV1ZQb0F3?=
 =?utf-8?B?TGlWQVYyQ0owcnZzeVRRVHBjMVhsRWZ3cDZXbTZYUnpyV2NISllwa0ZtUU8r?=
 =?utf-8?B?cFpIRVhlUDVaR3kyVCtTc09Eck92Tjg1TkIxWC9BNDBLV2UzZzdzNU13ejVU?=
 =?utf-8?B?Qi9XSXpXTGQ0LzVOdk1VS0pjNi81ZHZ5NWNJU29mN0h1Z29VVzNtTXVEK3By?=
 =?utf-8?B?NDhqMzhDT3JKbmxjc0FiVks3aW9vNXV1bGV6d09hR1lUdlVSTUNhaFprQ3E4?=
 =?utf-8?B?OVdIelNUWkZwWjkrKzk1TGFwSlk3WDh6NjZKRDI0WDNTNkdpZGVadlNNRDVV?=
 =?utf-8?B?YWJvU0tqTHpiR1BQcFdLOTlSWWhiNWNPN0RtSGV2UHgyamMvNi9zMGh2d3lR?=
 =?utf-8?B?dzBrdzJzZlFDRTh3K2FFQzVGRmZTcGdkOVQ4Q09mWjhJMHhETmg0RW9BRWo5?=
 =?utf-8?B?bXFwVFFxcGYxdnZzMWEvV0l3dE9oWmsvSzBwVmxkdWNHdSs3TTR0cHJUQk0z?=
 =?utf-8?B?ek1GUGxTWk1PMnJnK0pZaXlyWGp3dVN6SFJNSmJKQWhtbHI5ZTk0Ry95U2Rl?=
 =?utf-8?B?VzlKQXJXVldOdzZONjh6ZkYvbExIVm9tVVYvazRjbU51R0t2NzNGdE9QUUdt?=
 =?utf-8?B?QmtNb0NwQmFsNTJHUTJ0eHUxMkZ2cmgrQmVPTXpKYW53cDZ3d0RwK0dwbXFU?=
 =?utf-8?B?emZpd2dRa2pGdkMvajlLbFdIVDJuWjdwM05tTmxPRGlsaWl4U0VlSDVBTlA4?=
 =?utf-8?B?aHR3Z3dTc1hocmd6b2Qza1dvRGpIeVlybHo3elhlL3BKTFUyT1g0YW5MR0Vl?=
 =?utf-8?B?Q3Z4YmZpZS80MloyUjBaSytNdUJqeUU5RGZaQXJ2bnN5c25DRnN3cCs1dDRC?=
 =?utf-8?B?eWNxdWZqeTFBRWhhWENwZXR1aEFhUDNHMUI3aitNdWcrTjNxRkE0MGZHZkpQ?=
 =?utf-8?B?SHVCUWprbE9CTE03YlZ6cW1wZ0UvSnBxeWphTjFDQTRHOVZ0d3hNQ0c4anFj?=
 =?utf-8?B?QjhqNkxLbW1mYnpQRlJzenBOMjdSZkN5aTRldnhXeU9XWDFxaGpHVFdYMnph?=
 =?utf-8?B?TmRDdXllQUJrY1FQZWVHSEZ0SXd3NVV3ZWNZQk5hUy9sYkYyeDZ5bGZuNWZV?=
 =?utf-8?B?Q2pUME1xWjV1a2Q3SHZJN1IwcHBacWRHdEhUR01PenhDL29EcnQvZUdFbkow?=
 =?utf-8?B?NTkwb3FZTU9veEJERHRReTlIMllUQm4rS1pBUlIxeDVJR1JLVGszNGpGbVhM?=
 =?utf-8?B?MWxnbXRuU2lpQXhBRDVkZlo4ZGpjMDFNL2cwbENqc3g4bXRIUFp1YXRkM1lw?=
 =?utf-8?B?c29kQTdzWU5ta1hrNHFjRzVreS84TmdzTVk4aHVmUzNLNSt1RktDMlNoQkY2?=
 =?utf-8?B?NkdhbWloZDlHQ2QzeDQzcTVycWk3eHJ0aXhOc240OFNtVldQZHd6QUNKRlQr?=
 =?utf-8?B?Y1lkRWtHQTdhaGQ4b0JoTzY1S1Z0MGsrWmFhcnRQZ05IVVRnNWRHanpVTUxs?=
 =?utf-8?B?OHdNWGJISW5tM2pLZGl4ZGhydzZDRVlFcjlEa1RqZDNJMkhVaUtOV3VmLzR0?=
 =?utf-8?B?bUxiZTgzM1ZXZVUySVlnektSM3VSQkRxNnljaUN2NmtMQmMyWVdzbWM0ZTBO?=
 =?utf-8?B?dVNuWU5sUUZ0VVljMEpWWnlaK2FROFRjTWlzZm9uL1prZGh3SFR4aFA2Si9i?=
 =?utf-8?B?dkRNaUtsRCtKNW00emRUaTA4a3lQaDltZTM3RUllaUtiZnRzWWx5QUlnQWVG?=
 =?utf-8?Q?3PFkF2gEHuCCnlK7N5WNyfN2FUzLwBOJ/hkAc9b?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <BD8B1F4FE5EF1E4A89C468843AD9F753@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR13MB5084.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 55d8a55b-6f30-4219-7cdc-08d93afbd416
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Jun 2021 12:45:51.7170
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ApttUqyxDNy+h4ORYXc3fKmns5rdY+VXTJq2yavDe12xQN+qoVm7Rt5HbxHM7wrGFkNpTJva5bS0YVY5hyCPHA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR13MB3334
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

T24gVHVlLCAyMDIxLTA2LTI5IGF0IDA1OjE3IC0wNDAwLCBEYXZpZCBXeXNvY2hhbnNraSB3cm90
ZToNCj4gT24gTW9uLCBKdW4gMjgsIDIwMjEgYXQgODozOSBQTSBUcm9uZCBNeWtsZWJ1c3QNCj4g
PHRyb25kbXlAaGFtbWVyc3BhY2UuY29tPiB3cm90ZToNCj4gPiANCj4gPiBPbiBNb24sIDIwMjEt
MDYtMjggYXQgMTk6NDYgLTA0MDAsIERhdmlkIFd5c29jaGFuc2tpIHdyb3RlOg0KPiA+ID4gT24g
TW9uLCBKdW4gMjgsIDIwMjEgYXQgNTo1OSBQTSBUcm9uZCBNeWtsZWJ1c3QNCj4gPiA+IDx0cm9u
ZG15QGhhbW1lcnNwYWNlLmNvbT4gd3JvdGU6DQo+ID4gPiA+IA0KPiA+ID4gPiBPbiBNb24sIDIw
MjEtMDYtMjggYXQgMTc6MTIgLTA0MDAsIERhdmlkIFd5c29jaGFuc2tpIHdyb3RlOg0KPiA+ID4g
PiA+IE9uIE1vbiwgSnVuIDI4LCAyMDIxIGF0IDM6MDkgUE0gVHJvbmQgTXlrbGVidXN0DQo+ID4g
PiA+ID4gPHRyb25kbXlAaGFtbWVyc3BhY2UuY29tPiB3cm90ZToNCj4gPiA+ID4gPiA+IA0KPiA+
ID4gPiA+ID4gT24gTW9uLCAyMDIxLTA2LTI4IGF0IDEzOjM5IC0wNDAwLCBEYXZlIFd5c29jaGFu
c2tpIHdyb3RlOg0KPiA+ID4gPiA+ID4gPiBFYXJsaWVyIGNvbW1pdHMgcmVmYWN0b3JlZCBzb21l
IE5GUyByZWFkIGNvZGUgYW5kIHJlbW92ZWQNCj4gPiA+ID4gPiA+ID4gbmZzX3JlYWRwYWdlX2Fz
eW5jKCksIGJ1dCBuZWdsZWN0ZWQgdG8gcHJvcGVybHkgZml4dXANCj4gPiA+ID4gPiA+ID4gbmZz
X3JlYWRwYWdlX2Zyb21fZnNjYWNoZV9jb21wbGV0ZSgpLsKgIFRoZSBjb2RlIHBhdGggaXMNCj4g
PiA+ID4gPiA+ID4gb25seSBoaXQgd2hlbiBzb21ldGhpbmcgdW51c3VhbCBvY2N1cnMgd2l0aCB0
aGUNCj4gPiA+ID4gPiA+ID4gY2FjaGVmaWxlcw0KPiA+ID4gPiA+ID4gPiBiYWNraW5nIGZpbGVz
eXN0ZW0sIHN1Y2ggYXMgYW4gSU8gZXJyb3Igb3Igd2hpbGUgYSBjb29raWUNCj4gPiA+ID4gPiA+
ID4gaXMgYmVpbmcgaW52YWxpZGF0ZWQuDQo+ID4gPiA+ID4gPiA+IA0KPiA+ID4gPiA+ID4gPiBT
aWduZWQtb2ZmLWJ5OiBEYXZlIFd5c29jaGFuc2tpIDxkd3lzb2NoYUByZWRoYXQuY29tPg0KPiA+
ID4gPiA+ID4gPiAtLS0NCj4gPiA+ID4gPiA+ID4gwqBmcy9uZnMvZnNjYWNoZS5jIHwgMTQgKysr
KysrKysrKysrLS0NCj4gPiA+ID4gPiA+ID4gwqAxIGZpbGUgY2hhbmdlZCwgMTIgaW5zZXJ0aW9u
cygrKSwgMiBkZWxldGlvbnMoLSkNCj4gPiA+ID4gPiA+ID4gDQo+ID4gPiA+ID4gPiA+IGRpZmYg
LS1naXQgYS9mcy9uZnMvZnNjYWNoZS5jIGIvZnMvbmZzL2ZzY2FjaGUuYw0KPiA+ID4gPiA+ID4g
PiBpbmRleCBjNGMwMjFjNmViYmQuLmQzMDhjYjdlMWRkNCAxMDA2NDQNCj4gPiA+ID4gPiA+ID4g
LS0tIGEvZnMvbmZzL2ZzY2FjaGUuYw0KPiA+ID4gPiA+ID4gPiArKysgYi9mcy9uZnMvZnNjYWNo
ZS5jDQo+ID4gPiA+ID4gPiA+IEBAIC0zODEsMTUgKzM4MSwyNSBAQCBzdGF0aWMgdm9pZA0KPiA+
ID4gPiA+ID4gPiBuZnNfcmVhZHBhZ2VfZnJvbV9mc2NhY2hlX2NvbXBsZXRlKHN0cnVjdCBwYWdl
ICpwYWdlLA0KPiA+ID4gPiA+ID4gPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oCB2b2lkDQo+ID4gPiA+ID4gPiA+ICpjb250ZXh0LA0KPiA+ID4gPiA+ID4gPiDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBpbnQgZXJyb3IpDQo+ID4gPiA+ID4gPiA+IMKgew0K
PiA+ID4gPiA+ID4gPiArwqDCoMKgwqDCoMKgIHN0cnVjdCBuZnNfcmVhZGRlc2MgZGVzYzsNCj4g
PiA+ID4gPiA+ID4gK8KgwqDCoMKgwqDCoCBzdHJ1Y3QgaW5vZGUgKmlub2RlID0gcGFnZS0+bWFw
cGluZy0+aG9zdDsNCj4gPiA+ID4gPiA+ID4gKw0KPiA+ID4gPiA+ID4gPiDCoMKgwqDCoMKgwqDC
oCBkZnByaW50ayhGU0NBQ0hFLA0KPiA+ID4gPiA+ID4gPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoCAiTkZTOiByZWFkcGFnZV9mcm9tX2ZzY2FjaGVfY29tcGxldGUNCj4gPiA+ID4g
PiA+ID4gKDB4JXAvMHglcC8lZClcbiIsDQo+ID4gPiA+ID4gPiA+IMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgIHBhZ2UsIGNvbnRleHQsIGVycm9yKTsNCj4gPiA+ID4gPiA+ID4gDQo+
ID4gPiA+ID4gPiA+IC3CoMKgwqDCoMKgwqAgLyogaWYgdGhlIHJlYWQgY29tcGxldGVzIHdpdGgg
YW4gZXJyb3IsIHdlIGp1c3QNCj4gPiA+ID4gPiA+ID4gdW5sb2NrDQo+ID4gPiA+ID4gPiA+IHRo
ZQ0KPiA+ID4gPiA+ID4gPiBwYWdlIGFuZCBsZXQNCj4gPiA+ID4gPiA+ID4gLcKgwqDCoMKgwqDC
oMKgICogdGhlIFZNIHJlaXNzdWUgdGhlIHJlYWRwYWdlICovDQo+ID4gPiA+ID4gPiA+IMKgwqDC
oMKgwqDCoMKgIGlmICghZXJyb3IpIHsNCj4gPiA+ID4gPiA+ID4gwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgIFNldFBhZ2VVcHRvZGF0ZShwYWdlKTsNCj4gPiA+ID4gPiA+ID4gwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHVubG9ja19wYWdlKHBhZ2UpOw0KPiA+ID4gPiA+ID4g
PiArwqDCoMKgwqDCoMKgIH0gZWxzZSB7DQo+ID4gPiA+ID4gPiA+ICvCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgIGRlc2MuY3R4ID0gY29udGV4dDsNCj4gPiA+ID4gPiA+ID4gK8KgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqAgbmZzX3BhZ2Vpb19pbml0X3JlYWQoJmRlc2MucGdpbywgaW5v
ZGUsDQo+ID4gPiA+ID4gPiA+IGZhbHNlLA0KPiA+ID4gPiA+ID4gPiArDQo+ID4gPiA+ID4gPiA+
ICZuZnNfYXN5bmNfcmVhZF9jb21wbGV0aW9uX29wcyk7DQo+ID4gPiA+ID4gPiA+ICvCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgIGVycm9yID0gcmVhZHBhZ2VfYXN5bmNfZmlsbGVyKCZkZXNj
LA0KPiA+ID4gPiA+ID4gPiBwYWdlKTsNCj4gPiA+ID4gPiA+ID4gK8KgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqAgaWYgKGVycm9yKQ0KPiA+ID4gPiA+ID4gPiArwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgcmV0dXJuOw0KPiA+ID4gPiA+ID4gDQo+ID4gPiA+
ID4gPiBUaGlzIGNvZGUgcGF0aCBjYW4gY2xlYXJseSBmYWlsIHRvby4gV2h5IGNhbiB3ZSBub3Qg
Zml4DQo+ID4gPiA+ID4gPiB0aGlzDQo+ID4gPiA+ID4gPiBjb2RlDQo+ID4gPiA+ID4gPiB0bw0K
PiA+ID4gPiA+ID4gYWxsb3cgaXQgdG8gcmV0dXJuIHRoYXQgcmVwb3J0ZWQgZXJyb3Igc28gdGhh
dCB3ZSBjYW4NCj4gPiA+ID4gPiA+IGhhbmRsZQ0KPiA+ID4gPiA+ID4gdGhlDQo+ID4gPiA+ID4g
PiBmYWlsdXJlIGNhc2UgaW4gbmZzX3JlYWRwYWdlKCkgaW5zdGVhZCBvZiBkZWFkLWVuZGluZyBo
ZXJlPw0KPiA+ID4gPiA+ID4gDQo+ID4gPiA+ID4gDQo+ID4gPiA+ID4gTWF5YmUgdGhlIGJlbG93
IHBhdGNoIGlzIHdoYXQgeW91IGhhZCBpbiBtaW5kP8KgIFRoYXQgd2F5IGlmDQo+ID4gPiA+ID4g
ZnNjYWNoZQ0KPiA+ID4gPiA+IGlzIGVuYWJsZWQsIG5mc19yZWFkcGFnZSgpIHNob3VsZCBiZWhh
dmUgdGhlIHNhbWUgd2F5IGFzIGlmDQo+ID4gPiA+ID4gaXQncw0KPiA+ID4gPiA+IG5vdCwNCj4g
PiA+ID4gPiBmb3IgdGhlIGNhc2Ugd2hlcmUgYW4gSU8gZXJyb3Igb2NjdXJzIGluIHRoZSBORlMg
cmVhZA0KPiA+ID4gPiA+IGNvbXBsZXRpb24NCj4gPiA+ID4gPiBwYXRoLg0KPiA+ID4gPiA+IA0K
PiA+ID4gPiA+IElmIHdlIGNhbGwgaW50byBmc2NhY2hlIGFuZCB3ZSBnZXQgYmFjayB0aGF0IHRo
ZSBJTyBoYXMgYmVlbg0KPiA+ID4gPiA+IHN1Ym1pdHRlZCwNCj4gPiA+ID4gPiB3YWl0IHVudGls
IGl0IGlzIGNvbXBsZXRlZCwgc28gd2UnbGwgY2F0Y2ggYW55IElPIGVycm9ycyBpbg0KPiA+ID4g
PiA+IHRoZQ0KPiA+ID4gPiA+IHJlYWQNCj4gPiA+ID4gPiBjb21wbGV0aW9uDQo+ID4gPiA+ID4g
cGF0aC7CoCBUaGlzIGRvZXMgbm90IHNvbHZlIHRoZSAiY2F0Y2ggdGhlIGludGVybmFsIGVycm9y
cyIsDQo+ID4gPiA+ID4gSU9XLA0KPiA+ID4gPiA+IHRoZQ0KPiA+ID4gPiA+IG9uZXMgdGhhdCBz
aG93IHVwIGFzIHBnX2Vycm9yLCB0aGF0IHdpbGwgcHJvYmFibHkgcmVxdWlyZQ0KPiA+ID4gPiA+
IGNvcHlpbmcNCj4gPiA+ID4gPiBwZ19lcnJvciBpbnRvIG5mc19vcGVuX2NvbnRleHQuZXJyb3Ig
ZmllbGQuDQo+ID4gPiA+ID4gDQo+ID4gPiA+ID4gZGlmZiAtLWdpdCBhL2ZzL25mcy9yZWFkLmMg
Yi9mcy9uZnMvcmVhZC5jDQo+ID4gPiA+ID4gaW5kZXggNzhiOTE4MWU5NGJhLi4yOGUzMzE4MDgw
ZTAgMTAwNjQ0DQo+ID4gPiA+ID4gLS0tIGEvZnMvbmZzL3JlYWQuYw0KPiA+ID4gPiA+ICsrKyBi
L2ZzL25mcy9yZWFkLmMNCj4gPiA+ID4gPiBAQCAtMzU3LDEzICszNTcsMTMgQEAgaW50IG5mc19y
ZWFkcGFnZShzdHJ1Y3QgZmlsZSAqZmlsZSwNCj4gPiA+ID4gPiBzdHJ1Y3QNCj4gPiA+ID4gPiBw
YWdlDQo+ID4gPiA+ID4gKnBhZ2UpDQo+ID4gPiA+ID4gwqDCoMKgwqDCoMKgwqAgfSBlbHNlDQo+
ID4gPiA+ID4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGRlc2MuY3R4ID0NCj4gPiA+
ID4gPiBnZXRfbmZzX29wZW5fY29udGV4dChuZnNfZmlsZV9vcGVuX2NvbnRleHQoZmlsZSkpOw0K
PiA+ID4gPiA+IA0KPiA+ID4gPiA+ICvCoMKgwqDCoMKgwqAgeGNoZygmZGVzYy5jdHgtPmVycm9y
LCAwKTsNCj4gPiA+ID4gPiDCoMKgwqDCoMKgwqDCoCBpZiAoIUlTX1NZTkMoaW5vZGUpKSB7DQo+
ID4gPiA+ID4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHJldCA9IG5mc19yZWFkcGFn
ZV9mcm9tX2ZzY2FjaGUoZGVzYy5jdHgsDQo+ID4gPiA+ID4gaW5vZGUsDQo+ID4gPiA+ID4gcGFn
ZSk7DQo+ID4gPiA+ID4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGlmIChyZXQgPT0g
MCkNCj4gPiA+ID4gPiAtwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqAgZ290byBvdXQ7DQo+ID4gPiA+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgIGdvdG8gb3V0X3dhaXQ7DQo+ID4gPiA+ID4gwqDCoMKgwqDCoMKgwqAgfQ0K
PiA+ID4gPiA+IA0KPiA+ID4gPiA+IC3CoMKgwqDCoMKgwqAgeGNoZygmZGVzYy5jdHgtPmVycm9y
LCAwKTsNCj4gPiA+ID4gPiDCoMKgwqDCoMKgwqDCoCBuZnNfcGFnZWlvX2luaXRfcmVhZCgmZGVz
Yy5wZ2lvLCBpbm9kZSwgZmFsc2UsDQo+ID4gPiA+ID4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgJm5mc19hc3luY19yZWFkX2NvbXBsZXRp
b25fb3BzKTsNCj4gPiA+ID4gPiANCj4gPiA+ID4gPiBAQCAtMzczLDYgKzM3Myw3IEBAIGludCBu
ZnNfcmVhZHBhZ2Uoc3RydWN0IGZpbGUgKmZpbGUsDQo+ID4gPiA+ID4gc3RydWN0DQo+ID4gPiA+
ID4gcGFnZQ0KPiA+ID4gPiA+ICpwYWdlKQ0KPiA+ID4gPiA+IA0KPiA+ID4gPiA+IMKgwqDCoMKg
wqDCoMKgIG5mc19wYWdlaW9fY29tcGxldGVfcmVhZCgmZGVzYy5wZ2lvKTsNCj4gPiA+ID4gPiDC
oMKgwqDCoMKgwqDCoCByZXQgPSBkZXNjLnBnaW8ucGdfZXJyb3IgPCAwID8gZGVzYy5wZ2lvLnBn
X2Vycm9yIDoNCj4gPiA+ID4gPiAwOw0KPiA+ID4gPiA+ICtvdXRfd2FpdDoNCj4gPiA+ID4gPiDC
oMKgwqDCoMKgwqDCoCBpZiAoIXJldCkgew0KPiA+ID4gPiA+IMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoCByZXQgPSB3YWl0X29uX3BhZ2VfbG9ja2VkX2tpbGxhYmxlKHBhZ2UpOw0KPiA+
ID4gPiA+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBpZiAoIVBhZ2VVcHRvZGF0ZShw
YWdlKSAmJiAhcmV0KQ0KPiA+ID4gPiA+IA0KPiA+ID4gPiA+IA0KPiA+ID4gPiA+IA0KPiA+ID4g
PiA+IA0KPiA+ID4gPiA+ID4gPiArDQo+ID4gPiA+ID4gPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgIG5mc19wYWdlaW9fY29tcGxldGVfcmVhZCgmZGVzYy5wZ2lvKTsNCj4gPiA+ID4g
PiA+ID4gwqDCoMKgwqDCoMKgwqAgfQ0KPiA+ID4gPiA+ID4gPiDCoH0NCj4gPiA+ID4gPiA+ID4g
DQo+ID4gPiA+ID4gPiANCj4gPiA+ID4gPiA+IC0tDQo+ID4gPiA+ID4gPiBUcm9uZCBNeWtsZWJ1
c3QNCj4gPiA+ID4gPiA+IExpbnV4IE5GUyBjbGllbnQgbWFpbnRhaW5lciwgSGFtbWVyc3BhY2UN
Cj4gPiA+ID4gPiA+IHRyb25kLm15a2xlYnVzdEBoYW1tZXJzcGFjZS5jb20NCj4gPiA+ID4gPiA+
IA0KPiA+ID4gPiA+ID4gDQo+ID4gPiA+ID4gDQo+ID4gPiA+IA0KPiA+ID4gPiBZZXMsIHBsZWFz
ZS4gVGhpcyBhdm9pZHMgdGhhdCBkdXBsaWNhdGlvbiBvZiBORlMgcmVhZCBjb2RlIGluDQo+ID4g
PiA+IHRoZQ0KPiA+ID4gPiBmc2NhY2hlIGxheWVyLg0KPiA+ID4gPiANCj4gPiA+IA0KPiA+ID4g
SWYgeW91IG1lYW4gcGF0Y2ggNCB3ZSBzdGlsbCBuZWVkIHRoYXQgLSBJIGRvbid0IHNlZSBhbnl3
YXkgdG8NCj4gPiA+IGF2b2lkIGl0LsKgIFRoZSBhYm92ZSBqdXN0IHdpbGwgbWFrZSB0aGUgZnNj
YWNoZSBlbmFibGVkDQo+ID4gPiBwYXRoIHdhaXRzIGZvciB0aGUgSU8gdG8gY29tcGxldGUsIHNh
bWUgYXMgdGhlIG5vbi1mc2NhY2hlIGNhc2UuDQo+ID4gPiANCj4gPiANCj4gPiBXaXRoIHRoZSBh
Ym92ZSwgeW91IGNhbiBzaW1wbGlmeSBwYXRjaCA0LzQgdG8ganVzdCBtYWtlIHRoZSBwYWdlDQo+
ID4gdW5sb2NrDQo+ID4gdW5jb25kaXRpb25hbCBvbiB0aGUgZXJyb3IsIG5vPw0KPiA+IA0KPiA+
IGkuZS4NCj4gPiDCoMKgwqDCoMKgwqDCoCBpZiAoIWVycm9yKQ0KPiA+IMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoCBTZXRQYWdlVXB0b2RhdGUocGFnZSk7DQo+ID4gwqDCoMKgwqDCoMKg
wqAgdW5sb2NrX3BhZ2UocGFnZSk7DQo+ID4gDQo+ID4gRW5kIHJlc3VsdDogdGhlIGNsaWVudCBq
dXN0IGRvZXMgdGhlIHNhbWUgY2hlY2sgYXMgYmVmb3JlIGFuZCBsZXQncw0KPiA+IHRoZQ0KPiA+
IHZmcy9tbSBkZWNpZGUgYmFzZWQgb24gdGhlIHN0YXR1cyBvZiB0aGUgUEdfdXB0b2RhdGUgZmxh
ZyB3aGF0IHRvDQo+ID4gZG8NCj4gPiBuZXh0LiBJJ20gYXNzdW1pbmcgdGhhdCBhIHJldHJ5IHdv
bid0IGNhdXNlIGZzY2FjaGUgdG8gZG8gYW5vdGhlcg0KPiA+IGJpbw0KPiA+IGF0dGVtcHQ/DQo+
ID4gDQo+IA0KPiBZZXMgSSB0aGluayB5b3UncmUgcmlnaHQgYW5kIEknbSBmb2xsb3dpbmcgLSBs
ZXQgbWUgdGVzdCBpdCBhbmQgSSdsbA0KPiBzZW5kIGEgdjIuDQo+IFRoZW4gd2UgY2FuIGRyb3Ag
cGF0Y2ggIzMgcmlnaHQ/DQo+IA0KU291bmRzIGdvb2QuIFRoYW5rcyBEYXZlIQ0KDQotLSANClRy
b25kIE15a2xlYnVzdA0KTGludXggTkZTIGNsaWVudCBtYWludGFpbmVyLCBIYW1tZXJzcGFjZQ0K
dHJvbmQubXlrbGVidXN0QGhhbW1lcnNwYWNlLmNvbQ0KDQoNCg==

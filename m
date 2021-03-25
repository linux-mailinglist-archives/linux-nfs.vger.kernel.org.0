Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 83D703494E1
	for <lists+linux-nfs@lfdr.de>; Thu, 25 Mar 2021 16:04:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229574AbhCYPED (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 25 Mar 2021 11:04:03 -0400
Received: from mail-eopbgr1320114.outbound.protection.outlook.com ([40.107.132.114]:12848
        "EHLO APC01-PU1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230394AbhCYPDn (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Thu, 25 Mar 2021 11:03:43 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T6EWTcrhaARRwS74WeniyTWdodYamCf/F2fxX9o7gqPgNlJ/ZUeBOFeCIAYvbdj/gH4n6Fxf5NcNJuDbi6Cubudeb6znPKCMYl+Ul0kyQQqhMcMEN21ndR2WqY5v0p4vl1P/xPUxTP7sglUUz/r0B0tGX7SPzF9ggO8lbHrqEB0ZkFUgR25xK9AuHgGWczPXBrkASrHvU0P2TW3uqs6v2LDnN+WGVN5yR73ox21pZDNEacrV092X/OvfSM36pME36mwEHn9Q5VQt0XFxIaThmikbY/LKrESL6pFJ1QoR9RhUVdqotnKEASuwWxObhkWbbnl7BSfOYmfBhaogqeZ8kg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lbC6I6yNjRRQTJfMpQyscIpzoRvmtsOEkaTe4VuXW78=;
 b=DdOLQu3iJeFI5Ay2khSM47Z2hmesw35BkBx1Yu3XsPlJmfnJjpFMRmgxrFeLOaGCPgtCdPppuED3ASJK/LYRSptk9aG2tMZ+D+PWAVUYG4+ldU/qFBFRKQPcAVzxuFB75RNTPzqrr000cHehOsuRBzmdHbBkobfIJd0efZamN/yY3YS12jt+nNIzrzQG3cGVV+LbLrNUcTjM/+nva9bBhdGevNgdS3eBCYjxrgT7NNX7uWfbBckS0MIhRKZmEHjRiZHD2pNK1Cly445SBto1fFIalsWNfDkhCbRkvf74+sxfO6ynF4yypmdjmCKUju00JgfnqHTV/AsaT5TqWYUmhg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lbC6I6yNjRRQTJfMpQyscIpzoRvmtsOEkaTe4VuXW78=;
 b=GKSwChYe0+CPmHcSn2+UF/Np4OgdUr4J382i1dDlx4s+CL7R6iXqYxn0rQ5XMXSpgBDx0o08RChzqOK3py7piEQ/TFcL2UEOmLGL8C1N69OfsDi4taNCFV4b5c5VfEn/Zb/rsu0OgVkk2BeUnJWXibl8GVkDyYY4ZwPGlGTLe0E=
Received: from SG2P153MB0361.APCP153.PROD.OUTLOOK.COM (2603:1096:0:4::11) by
 SG2P15301MB0095.APCP153.PROD.OUTLOOK.COM (2603:1096:3:11::19) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3977.24; Thu, 25 Mar 2021 15:03:39 +0000
Received: from SG2P153MB0361.APCP153.PROD.OUTLOOK.COM
 ([fe80::cd6e:9dc1:85ac:f488]) by SG2P153MB0361.APCP153.PROD.OUTLOOK.COM
 ([fe80::cd6e:9dc1:85ac:f488%5]) with mapi id 15.20.3999.017; Thu, 25 Mar 2021
 15:03:39 +0000
From:   Nagendra Tomar <Nagendra.Tomar@microsoft.com>
To:     Anna Schumaker <anna.schumaker@netapp.com>
CC:     Olga Kornievskaia <aglo@umich.edu>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
Subject: RE: [EXTERNAL] Re: [PATCH v3 0/5] SUNRPC: Create sysfs files for
 changing IP address
Thread-Topic: [EXTERNAL] Re: [PATCH v3 0/5] SUNRPC: Create sysfs files for
 changing IP address
Thread-Index: AdcdJ6TyS5d0b7lmQfaamCRuNxFJBgDuh+6AAAouLPAAHQf/AAABn/cw
Date:   Thu, 25 Mar 2021 15:03:39 +0000
Message-ID: <SG2P153MB036155B6E43C625295AEBDC19E629@SG2P153MB0361.APCP153.PROD.OUTLOOK.COM>
References: <SG2P153MB0361F4B85684C232E63C04749E679@SG2P153MB0361.APCP153.PROD.OUTLOOK.COM>
 <CAN-5tyFLha3Wvy6m12S=9m+Yu0pg5wtEn_+4=aadXzECwBzoWA@mail.gmail.com>
 <SG2P153MB0361BA94D52E1123DEE7E1EC9E629@SG2P153MB0361.APCP153.PROD.OUTLOOK.COM>
 <CAFX2JfkH2c0jXHQnKezfcCFs9rwNVhnTtg+8pOtTZbLyKU7VBw@mail.gmail.com>
In-Reply-To: <CAFX2JfkH2c0jXHQnKezfcCFs9rwNVhnTtg+8pOtTZbLyKU7VBw@mail.gmail.com>
Accept-Language: en-IN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=a1ac3220-5fce-44e3-bba5-d84c7cc341dc;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2021-03-25T14:42:43Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: netapp.com; dkim=none (message not signed)
 header.d=none;netapp.com; dmarc=none action=none header.from=microsoft.com;
x-originating-ip: [122.172.188.128]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: ff337b92-d056-4621-6c84-08d8ef9f2c89
x-ms-traffictypediagnostic: SG2P15301MB0095:
x-microsoft-antispam-prvs: <SG2P15301MB0095B4E7AADEF0EAC8BD1B1E9E629@SG2P15301MB0095.APCP153.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 1zZ64oIDJqi9xeGaH57Iu4v0YZ1S6s2t94vvGx1DPUtQ2QnJ1wJMa+0YeApjbTmEC+7FE2gHiC9xTb/wGmwgtyxSd7Ha+RKAYaQxuf+MQvHOwzD/6ha1dP2ER+L5tJAr0VZMOLOQTaeRIaqtAj6WRGOX6i/N0+yQZC2vn+0rqwbqz4tf7r1CscMV+TaPLcPfJahE/4BbNfUPoy/8JpgJFC+VhTBZUHJkCMRe1jwaOfADlPhT2TfM6RDBqxzlCgPzyIBPUDi2sbq01KxJp96Gr558gV+294rNIviJwkgkv1pB7tFoDxOkWFdrMU0h0A/+VI3WIb6nRU5rZTsnT7Bt+AgNDiU1QFE/mzxoZrX9HvoLHE6P51w0OHXB2caBl12WQqNfjjHlMLEF2H9RB2fdgdtayA+iUHPxhSpgrObrSOE1+VHPRL96cr/9a6gJjXfkzBljwRHk7xcydUHlKjPKURncfOF2NYuSKkL1zedmHaMnny8KWi0HDCazo311gvQjfWSKw27nPoBKPVkqx59NA6UGvgaJ33dZ14/B8kTItwq/ywTq17X6EmNJ+AuGFQpy7dYxN4lQdCpthHZMH2ofc/+ascxQwPQJOTWROYvHpDInilAUf1EPtIqtBBAE8ikxgJ3QqkO6z4ta/aad5Jl8S6HFDDHkaG407qOhNLBcLGE=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SG2P153MB0361.APCP153.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(136003)(366004)(376002)(396003)(346002)(76116006)(8936002)(66446008)(66476007)(66946007)(64756008)(66556008)(8676002)(9686003)(55016002)(33656002)(71200400001)(2906002)(82950400001)(82960400001)(54906003)(10290500003)(478600001)(6506007)(7696005)(86362001)(55236004)(316002)(186003)(52536014)(26005)(83380400001)(8990500004)(6916009)(5660300002)(4326008)(38100700001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?utf-8?B?MXg3cFRXMmR4Y3BYMVFhbnBuVDFxNTNpRFh4QmZpQ0pLUGRob1kwUTMrajJJ?=
 =?utf-8?B?RzZKRkx1Y2hBUU1LSGl6L1JDRGNQbzJOeEhnOVhVRmZOOWNEckRDZG9mS3lk?=
 =?utf-8?B?S1FsYk5ydFp5UzRwQWR2b0I3VGZEaUZ0Sm54WXJkUGRabnpsRUd4SVpOaFZo?=
 =?utf-8?B?SThUREhrMC8wWmgrSnhkN3V2MVZmZFdLNTIrN1ZwSjIwVENLY2tmeDNhR1Ni?=
 =?utf-8?B?ZTFLTmpTVVRsRXJJT1RZUEFyN0RNbGVHb1pLQURZaWlyT0J2a081cnVoWFpT?=
 =?utf-8?B?cDVZeTl4cGRpNzdrL3ZMbGhNajFRWnNuZkxjVWwwaklFcC9vS2FrdVE4bkE5?=
 =?utf-8?B?dTZ5U21KQU9Pb3UrZWYvUS9iL2hpbDVWdHAvSjY1dEV0RHVrUlV3eVIxZytM?=
 =?utf-8?B?UC9XZnM5ZkpJUlNHWS9yNkpub3FnQ2gyNkR4akV1eVV1SHdCZnJoR1V2UDJB?=
 =?utf-8?B?MjNEN3JKVTF1Si9Zb0w5c2lSSU1QQ1RtRnVyZlora2JWNjdTWWVQMXI1OVNB?=
 =?utf-8?B?N2lpa0RIR2k5U0xxWXNENWloSExrRzRlK2FsNzViVWxNTHVYa1pyUmJrUVNY?=
 =?utf-8?B?Q213SGsvd2FBNDcwYVRXempocUR1VU4rT0dCNDU4TDJVN2RPNUk3VUdNNXQ0?=
 =?utf-8?B?ZCtOY0wrc2lQaHRMWjJqU3N6aGNxeFJQd1V0aktwUW1LK1MxQ0JwZlorL2Mv?=
 =?utf-8?B?K2oxazlOM1Q5R3E2bFRvTDcyV05YalJwMko5cWlyL25wbFdaSHo2RTIzdlZ1?=
 =?utf-8?B?OUJ1enpZVUl2MUlLNUREYm84RFU0cTJ4RG9xemFTcFRTSFZLTXRtMm1LQjVq?=
 =?utf-8?B?V0JGM3FiYWx3OGw5RVh2WmhEKzdhSjZSWUlXTFhTMms2L3lEUzBmWXptT1py?=
 =?utf-8?B?UW9WcyszT3BmM1E0UFNhdnpUbS8wYVFNcmcxdDFGN3RleEs1R0d2bG9CNUlj?=
 =?utf-8?B?NldrbExhLzZHaGswMTE4SmwyaWNoS3VoVDF0SW9sT1FhNzFjcC9ab1d0SFly?=
 =?utf-8?B?TEtpRXdsanV3OE1nbllWdkhKRnEyd3A0dmVHenFkZDlHdDM5eElWd2NBbS8w?=
 =?utf-8?B?WGlZZVhSeE5Ka2haYVRlR1UxYjJqb3oyMlpJRm90eGNQNkFTZGZZbm8rVnIz?=
 =?utf-8?B?Y0lMWTFFRHBTZVdMWFZvVzdrWWxqUTdyWVRITXJKRUNXT3YyU1NiRFdEWGZQ?=
 =?utf-8?B?bkM1bHE0VG9obXl2VFF4N084RUg0N1paVG1hcy9LWWZPV1JoVnlQMnFsNVhU?=
 =?utf-8?B?RkFFZnFKeTNxSDRtWW9hVlcwZmhTTmRmUy9SMG5ER1lOTDM1VWs3TkVvUDdK?=
 =?utf-8?B?djllM1pCdjRqSlFNMUxTS2NoY3JLaVdlNkh6dVJXdklqN0ZZM1UrbHNKWW1T?=
 =?utf-8?B?OXZadFJGRzJnVnJpZksyZVJtS2dqWGc0RzY1djRLcVMwNGk1RzVrNEhNTkc5?=
 =?utf-8?B?T0IzUENzTTlPQzYvalEzVjdzMk1pTzFaWi9WQWRSY05SdHd1M2JlWmtiOXRt?=
 =?utf-8?B?amVmOVN5bk8vdHZuN1NDSDJINy84V25EUHhFcFp3WVFBZUJvb1VSQVhwWEJw?=
 =?utf-8?B?STNBZW5ISndOd1hSTG1BUU11N1cwamZNMnpaS1doV0M0V2ptS1dMYmJzYUpq?=
 =?utf-8?B?ck50dVdpTDRjMVFLR05mSmRodTUzUFlyYzZyV0RrYTlTSFNPVDRCT2dlZC9E?=
 =?utf-8?B?TVJGSkxzVU01OW5ZaEZ0bC9rRGhlSnhKUGNpeVNZTnhJUEZFU3QyMXNoZjF3?=
 =?utf-8?Q?z2VI0sdmP0ZQBJwnfYcqeR3nKyOkYQ9mfJeFFsM?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SG2P153MB0361.APCP153.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: ff337b92-d056-4621-6c84-08d8ef9f2c89
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Mar 2021 15:03:39.6548
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zLoE0NuH6tpYrB2h/k8w7V4C6Uj5hMdCESzUJTrfWJrq7rP4iFH0kS8dEjdYmzs0ubDaLoo5LG9M8eqWuW01/g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SG2P15301MB0095
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

PiBGcm9tOiBBbm5hIFNjaHVtYWtlciA8YW5uYS5zY2h1bWFrZXJAbmV0YXBwLmNvbT4NCj4gU2Vu
dDogMjUgTWFyY2ggMjAyMSAxOToyNg0KPiBIaSBUb21hciwNCj4gDQo+IFNvcnJ5IGZvciBub3Qg
Y2hpbWluZyBpbiBlYXJsaWVyLCBhcyBPbGdhIHNhaWQ6IEknbSBvbiBsZWF2ZSAoYW5kIHdpbGwN
Cj4gYmUgZm9yIHNldmVyYWwgbW9yZSB3ZWVrcykgYWZ0ZXIgbXkgd2lmZSBhbmQgSSBoYWQgYSBi
YWJ5Lg0KDQpObyBwcm9ibGVtIEFubmEsIGFuZCBjb25ncmF0dWxhdGlvbnMgaW4gYWR2YW5jZSB0
byB5b3UgYW5kIHlvdXIgd2lmZSENCg0KPiBJJ3ZlIGJlZW4gdGhpbmtpbmcgb2YgdGhlIHdyaXRl
LXRvLXN5c2ZzIGFwcHJvYWNoIGFzIGp1c3QgdGhlIGtlcm5lbA0KPiBpbnRlcmZhY2UuIEkgd291
bGQgZXhwZWN0IHRoZXJlIHRvIGJlIHNvbWUgZnV0dXJlIHVzZXJzcGFjZSB0b29sIGJ1aWx0DQo+
IG9uIHRoZSBzeXNmcyBmaWxlcyB0aGF0IGlzIGVhc2llciBmb3IgYWRtaW5zIHRvIHVzZS4gVGhp
cyBmdXR1cmUgdG9vbA0KPiBjb3VsZCBwcm9iYWJseSBiZSBjb2RlZCB0byBoYW5kbGUgZG5zIHJl
c29sdXRpb25zIGFuZCB3cml0ZSB0aGUgcmVzdWx0DQo+IHRvIHRoZSBzeXNmcyBmaWxlLg0KDQpZ
ZWFoLCBJIGdvdCB0aGUgaWRlYS4gSSB3YXMgaG9waW5nIHRvIGF2b2lkIGFueSBhZGRpdGlvbmFs
IHVzZXJzcGFjZSB0b29sLg0KSUlVQyB0aGUgdXNlcnNwYWNlIHRvb2wgd291bGQgYmUgbW9yZSBs
aWtlIGFuIGFsd2F5cy1ydW5uaW5nIHByb2dyYW0gdGhhdCANCnBlcmlvZGljYWxseSBkb2VzIHRo
ZSBuYW1lIHJlc29sdXRpb24gYW5kIHVwZGF0ZXMgdGhlIHN5c2ZzIHhwcnQgYWRkcg0KZmlsZS4g
SXQgY2FuIGJlIGRvbmUgdXNpbmcgbW91bnQgaGVscGVycyB3aGljaCB0YWtlIHRoZSBORlMgc2Vy
dmVyJ3MgaG9zdG5hbWUNCmFuZCBzdGFydCB0aGUgcHJvY2VzcyB0byBwZXJpb2RpY2FsbHkgcmVz
b2x2ZSB0aGUgaG9zdG5hbWUgYW5kIHdyaXRlIHRvIHN5c2ZzLg0KVGhlbiBvbiB1bm1vdW50IHRo
ZSBwcm9ncmFtIGhhcyB0byBiZSBzdG9wcGVkLg0KV2l0aCB0aGUgZG5zIHJlc29sdXRpb24gdXBj
YWxsIG9uIHJlY29ubmVjdCwgYWxsIG9mIHRoaXMgY291bGQgYmUgYXZvaWRlZC4NCkluZmFjdCBh
cyBPbGdhIHNhaWQsIGlmIHdlIGV4dGVuZCB5b3VyIHBhdGNoIHRvIHRyZWF0IGhvc3RuYW1lcyBz
cGVjaWFsbHkgLSANCmRvIGRucyByZXNvbHV0aW9uIHVwY2FsbCBpZiB0aGUgc3lzZnMgaGFzIHRo
ZSBob3N0bmFtZSBpbnN0ZWFkIG9mIElQIGFkZHJlc3MsDQp0aGF0IHdpbGwgc2VydmUgbXkgdXNl
Y2FzZSB3ZWxsIHRvby4NCg0KVGhhbmtzLA0KVG9tYXINCg==

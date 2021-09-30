Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E60341DCB2
	for <lists+linux-nfs@lfdr.de>; Thu, 30 Sep 2021 16:51:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351588AbhI3OxD (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 30 Sep 2021 10:53:03 -0400
Received: from mail-dm6nam10on2128.outbound.protection.outlook.com ([40.107.93.128]:31649
        "EHLO NAM10-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1351967AbhI3Ow5 (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Thu, 30 Sep 2021 10:52:57 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WodOGfzbiRO4ePfke3mEKU7/NXTUqJlo/+ghwUaYcVDZIIdFcST9dl1n4owuwu/Ax2UIM499xLgxsqpn24iYfxc/EJi1/+d5AmxSpQbVZhl/0d5/nv/dveUVH0CJHsCP1ghbsF5Atlaas5nGc/fZWVsv97pAgt5YBIftxFj9T3HHqL1q36/0PjQejBOBpHZdYOz388nyffbkE3WSun2/CfJSx/ZRmjc+Qgt1YAG0BrvuRoI2sfr53M2p+wWcJcJsVkv3R3VLJ4sO2ETZmFoB+JcpbBM/z5Y7fQGKqR08jWbJLuvtVvTf+/OltUrOeKJiFLm+L7s9QIFVPDEoQWrtMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X5uJh7v2Tj/3s/PsIpSE71ujePS28JtnAF+SLKs3KA8=;
 b=F15kE10EbbOqhcXaYpZRoWxChnfE4+VJsSO2fFjzaZ9h+dZ9468/ZIVMNeGvlOqkJrkG1x/ZhNbElS2UnTNJ2dOZYfsL7CzsyDkaCdiHa8CysAyU5jizGWZA6HGtyeAFHi7V1ve6jXFtsMyRk/rQL50zOoOmhfhvMRYrGOSeOSK02OOcy4Eg99VDIK0Yu0m5Pjh+/LiQHqmr9ZeLsRcKFdxnJeYavVG3u/GhgRYdUs0ChRtxt8FY8FtiTq7a9CSld5AqUyb18fOV9+XbOR4uE0zRv8VCcT5vaonnhOdT/3tfEIq5yHCQcvST1c60cejww7XK2zfJRGM8vrmAzscVyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X5uJh7v2Tj/3s/PsIpSE71ujePS28JtnAF+SLKs3KA8=;
 b=KWP8YwyVYaSkzArUf69oS1sBP8tF2PHQfQkhGO2Wzg75+ZdBdC1LRSZHsMZSDzh20M3ReWyoHi3ojGFlh8L/obnDeYN6MMoRIUzCj0XNcCStkr8Bl9c6xR9A0yVnznfXyhNnCsH1tSUwVUZ6YyRWBH1/WZKm19zTk/qa5sjf5Q8=
Received: from CH0PR13MB5084.namprd13.prod.outlook.com (2603:10b6:610:111::7)
 by CH2PR13MB4411.namprd13.prod.outlook.com (2603:10b6:610:6e::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.10; Thu, 30 Sep
 2021 14:51:13 +0000
Received: from CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::185b:505d:b35c:a3a2]) by CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::185b:505d:b35c:a3a2%6]) with mapi id 15.20.4566.017; Thu, 30 Sep 2021
 14:51:13 +0000
From:   Trond Myklebust <trondmy@hammerspace.com>
To:     "bcodding@redhat.com" <bcodding@redhat.com>
CC:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH 4/5] NFS: Further optimisations for 'ls -l'
Thread-Topic: [PATCH 4/5] NFS: Further optimisations for 'ls -l'
Thread-Index: AQHXtTjgd3gxxmyKIUOhzT+omYBuM6u7GfkAgAAYUICAAEJpgIAAA+yAgAEsEICAAAYXgA==
Date:   Thu, 30 Sep 2021 14:51:13 +0000
Message-ID: <d043f95fbc80b03cb923fbb8ee3c1d7804301ebd.camel@hammerspace.com>
References: <20210929134944.632844-1-trondmy@kernel.org>
         <20210929134944.632844-2-trondmy@kernel.org>
         <20210929134944.632844-3-trondmy@kernel.org>
         <20210929134944.632844-4-trondmy@kernel.org>
         <C9ED123C-A092-4417-8597-AB6267379E2F@redhat.com>
         <f09a7c00b70d51a442542dec1e1ba98289ad612c.camel@hammerspace.com>
         <F6D17359-3190-4A67-9DF7-08BCE61BE075@redhat.com>
         <558be6c89090b38cc9b679a0893649c5067cff14.camel@hammerspace.com>
         <46C79084-3586-4B63-A55F-7A3B9ED547CE@redhat.com>
In-Reply-To: <46C79084-3586-4B63-A55F-7A3B9ED547CE@redhat.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=hammerspace.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 368658ba-f41f-4a3e-c48c-08d98421bf96
x-ms-traffictypediagnostic: CH2PR13MB4411:
x-microsoft-antispam-prvs: <CH2PR13MB4411B168A42811B471C3D32AB8AA9@CH2PR13MB4411.namprd13.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: w8pQJ4cBDgwl+sf5/cX9zNTwNGjOGSps37OQC3J2KDz4RKfk9lygEs/dTYBfVRL7LoWdwckFoJ+fBrWGXpzxvgQqvV6806YLxEhpk+UrsyCOgl7PSb2ygccZL/PB7VrJDzoiDl+RSPT8sE3JiqnGv8nnZqPjVlFH/VEjeuJUMFfwQrvrKc9mq3RyUJ1XULx37xSQNfjayMslH8XTB6PCVK8B4Hz4pzFQd4I+VoTC3iq5+B2ZflNArxtlKrxfDwKs2mT5xUg9V/JPOdwlZUv3T3N2nRp8XuwoPz61eFMeJWw6R6UAD+hpHMVl1FAbsXI3JoEBE9smK9QphTa6XVl+Rq1lFTmJakpN4tk7p7dF6Xuhdza81aEHJgltRPH/5JyOjMDZ4umBcAkjSJ0Aw2EfpGyp1JizFAQIsIIJITUmcSDZ86x4StRSo5uGVOo6BCA8+aG0V/XPi84+5EvNzX5cJypTVNWDDO5DDLb/Qks9oss4mnvo/9qWLploz86gySCMxMrCzf7UCigJHvvB27eXy3Ue//VgyGt745EF7UHgHD4gdakzWBW6sa6y4JEEbW8NJRCQuh4twudCTjgJTZtDVKtQ1x3M6/3dfp2NhiyP6y9k8haeXeRmnj82jJF6e6D9p3HSlEWUeTfWzMfU+P7jKt8dw9pTP5py1sFmZ18UkNk7QAZ8Ybd3ejno5qhWksXj+YutLPD3TaynTw7fVqGI7w==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR13MB5084.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(8676002)(66556008)(5660300002)(71200400001)(66446008)(64756008)(38100700002)(38070700005)(122000001)(8936002)(6916009)(4744005)(66476007)(83380400001)(66946007)(508600001)(6486002)(316002)(2616005)(186003)(6512007)(53546011)(76116006)(2906002)(4326008)(6506007)(86362001)(36756003)(26005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UjRCT2diRSt6dkNTK0xoUk1sbkcrRFRzNWdYcjhtMis4WS9HY0FVSnpRZTRa?=
 =?utf-8?B?ZjNWYm9JWUpMSWdDWnhrOS9yMTB4Z05SMGcvN1pGZkttUFFkd2xXL1BOajcr?=
 =?utf-8?B?NXh1MjE3V3pCZFdqaEpySW9MOEhFK1hFODZUQnoycGVhSUplcTh4d3ZWNzN6?=
 =?utf-8?B?REhQb21iUHdkNllvZVdvRjV6Uk01ZnhJM05kSEJ1ZXdBOTdjVENZQjBycEh5?=
 =?utf-8?B?YktJZFhta29BWjBtUjZUeXRNcmNjNEw5U2Rmb3NGODg5cWcrcHp2VThRaGNw?=
 =?utf-8?B?YXoySzVneGd4SndXSXRiT1RDTkJ4SFQ5RFIxWHhTMHo1RjYyMmlhUm90VlRS?=
 =?utf-8?B?UUFzbjRGT3B0NlY4R05zUU96WXhaZWVVQ2tPTFlRWlFEVm41ZHdMLzdwNitT?=
 =?utf-8?B?c0k0T2s5MWNNbVMrbkN1UTlhdXhaWDdWcjlFWFF0WkIyeDVDb2Z6ZGY2dnRw?=
 =?utf-8?B?VjZoejh6OWVWMklBaEN0U3R5RnVTVDhwL3ZzVDJ6anRFTSs3azZqcDJ4ZkZC?=
 =?utf-8?B?SG9tNFNlOFBUTFFyVjBiWTVIMWdRZ05mUC83SjMrUk02VTQ2T25tVXoraWxz?=
 =?utf-8?B?b2g2aHVla3pvVS9TZlltVkh3VnFGZ0xULzl2WThXSUtqNWZVK0hiTzlZNSty?=
 =?utf-8?B?Q2xVOGtGT3VZYXdZdmlQOTRpNE0xaVR4RWxzZWYyOGZiZjVWQkx3WHU2dnl4?=
 =?utf-8?B?SkRjTlp1dngzN1Q4SjBYOFo0WDQ1RGgramFnaFNHWXpVdHZzVU11VXVFSTZj?=
 =?utf-8?B?N0pEMGJSOUlpU0NCUWhYRC9iaUlxWWFKQ3prZDYrSkZxWFpTc0lkN0hPRlNl?=
 =?utf-8?B?WXhqc0NXa2Qvdy96OXdnWkZmK3c4a2F4TUxSZ1Blcmd0SEdXNzJ4dUxKN1ZC?=
 =?utf-8?B?b01pdzNTZnAzTDlQc2hIZnBSSWRQaUtUMWw5MjVUelpYeEtvSU16VmpvdktE?=
 =?utf-8?B?OU0ySllBUzd5VDhoYXNzL0VTL3ltN3VoMmtGdi84WElZWnZPRllJQ282aXVs?=
 =?utf-8?B?OXlkc3VGTlRvOExzV0ZiVllKek42emJoL0xBUTZwM1lnbkwrVjNYdWJRbmlZ?=
 =?utf-8?B?VHZnYmdFZ3orZXVWZ0VKcHVxdS9kRlFBYWZIUEhSZXMyTDFkWWI0bmRUeFRQ?=
 =?utf-8?B?WHcwRXNwZU5nQThIUlZOenlnMG5XR0dlUUllUVVuWkJwaEFMc0JUdmtvLzd5?=
 =?utf-8?B?bDhzUXdBSXlTZHR0UEgwc09KSUg3dHVhOXJpeW9hdGZZMGZHYld6NTJQaEtX?=
 =?utf-8?B?WkxJREVZcTRkUm9OSC9CWkFJdnBraWhwZllMcU1qL1ltdkJBQVloSURUdnJz?=
 =?utf-8?B?bFNINDZoVEc2SWlJOTdvOGwyU1NTOW55T3k1RkRWWk91Wm5MQ25TdXg0ZlUy?=
 =?utf-8?B?bkF3SnhDa1prSzF6TlR4SmtVNmtjYWNTODRnU3pob21QUkZNU3pNMmp4MmJN?=
 =?utf-8?B?MTlEYXJDKzJqTXYyODNHZHdyN2hCWTFlTnJFSXJwRDVmV3ViMGlIZXhlTTla?=
 =?utf-8?B?NVllcjgvSmZBeFVHdHVZWm14SVZNV043cDd2RFEyQ1dpTmRVZGw5K1p1RmlP?=
 =?utf-8?B?KzBFMzBrbTVIMkRaQVUxa0VTMVdETzhGNFVWc3ZhSDZuaG15ODlyUEdsMmox?=
 =?utf-8?B?SDJRbHI5M2tFOTV3b1NYSUtTY1hvWkxVQXhEYUV3bFJyNURkbnJiTTNaNGEw?=
 =?utf-8?B?Mm0zMTMvV0NvdDdubURCRHV0VlJsbSsyR1FOOVUyL3FjMHgvSXQrV1JxYlBI?=
 =?utf-8?Q?/s2DhiwCt2E/GSpzLQCUQDB/6blnXJbfZJPlUUx?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <60B66E0AB7DCD5458DC4CFA58DDBB97D@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR13MB5084.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 368658ba-f41f-4a3e-c48c-08d98421bf96
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Sep 2021 14:51:13.1716
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qP/ojQGapv2BP1wetpoKBQLiYTOP+eEaD0b1MN6yDl3h3Rq3KOkNydWjSKCUQX8RNT9iFBn4QalOSxNIxOccVw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR13MB4411
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

T24gVGh1LCAyMDIxLTA5LTMwIGF0IDEwOjI5IC0wNDAwLCBCZW5qYW1pbiBDb2RkaW5ndG9uIHdy
b3RlOg0KPiBPbiAyOSBTZXAgMjAyMSwgYXQgMTY6MzUsIFRyb25kIE15a2xlYnVzdCB3cm90ZToN
Cj4gPiBJdCBpcyBjb25jZXJuaW5nLCBhbmQgaW5kZWVkIGluIG91ciB0ZXN0IHdlIGFyZSBzZWVp
bmcgUkVBRERJUg0KPiA+IGFtcGxpZmljYXRpb24gd2l0aCB0aGVzZSBtdWx0aXBsZSBwcm9jZXNz
IGFjY2Vzc2VzLiBTbyBzY2VuYXJpb3MNCj4gPiBsaWtlDQo+ID4gdGhlIG9uZSB5b3UgZGVzY3Jp
YmUgYWJvdmUgYXJlIGV4YWN0bHkgdGhlIGtpbmQgb2YgaXNzdWUgSSB3YXMNCj4gPiBsb29raW5n
DQo+ID4gdG8gZml4IHdpdGggdGhlc2UgcGF0Y2hlcy4NCj4gDQo+IEkgc3BlbnQgc29tZSB0aW1l
IHRyeWluZyB0byB0cmlnZ2VyIHRoZSBzY2VuYXJpbyBJIHdhcyBjb25jZXJuZWQNCj4gYWJvdXQs
IGJ1dA0KPiBJIGNvdWxkbid0IGdlbmVyYXRlIGFueSBvcCBhbXBsaWZpY2F0aW9ucy7CoCBGZWVs
IGZyZWUgdG8gYWRkIG15Og0KPiANCj4gVGVzdGVkLWJ5OiBCZW5qYW1pbiBDb2RkaW5ndG9uIDxi
Y29kZGluZ0ByZWRoYXQuY29tPg0KPiBSZXZpZXdlZC1ieTogQmVuamFtaW4gQ29kZGluZ3RvbiA8
YmNvZGRpbmdAcmVkaGF0LmNvbT4NCj4gDQoNClRoYW5rcyBCZW4hIEkgcmVhbGx5IGFwcHJlY2lh
dGUgeW91ciBoZWxwLg0KDQoNCi0tIA0KVHJvbmQgTXlrbGVidXN0DQpMaW51eCBORlMgY2xpZW50
IG1haW50YWluZXIsIEhhbW1lcnNwYWNlDQp0cm9uZC5teWtsZWJ1c3RAaGFtbWVyc3BhY2UuY29t
DQoNCg0K

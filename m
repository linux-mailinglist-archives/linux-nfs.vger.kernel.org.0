Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EEC4F3461A9
	for <lists+linux-nfs@lfdr.de>; Tue, 23 Mar 2021 15:42:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232299AbhCWOl3 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 23 Mar 2021 10:41:29 -0400
Received: from mail-eopbgr1320099.outbound.protection.outlook.com ([40.107.132.99]:53952
        "EHLO APC01-PU1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232037AbhCWOlU (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Tue, 23 Mar 2021 10:41:20 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oPcTjL23iiREBRBzRb7ZcrAxzIgLQ7fi2ZdKJtti/wmO04UmAaNHjNtAB4taDZ5jOxHDMZ0AiZWT9hUAKMrDQ3KCh02wIP9DDG8jlB6PcqMQcNDmuZZ4Hl7AcOKagetyVqOK3KpJ9qGoa74/uUBQNrvhMMST08n2FQZCcDsAERfKYV+S9Z9F5gXCStmY5WKgbCSz/fIz2l5Ez8XHKzWlF+dLf6B4FzgRuNfjmdw0My1yI1ge6d+a7xR0N4QqCFP/h1aRqpWP9B6RM0nW2/fejlS8KnFGr6dCJavj+LzwmaVlvYwaKPV0vr4mvsj/GkwlMXa+YMzMZy2PAjj2WVKm7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yc4p6t4MnCoe4/A20rrXNrGh1JYAc2uM2HPqZ8yLu58=;
 b=kbyoXZ/mNaFs64llTD7ruusjn3WbdRn61KiXK7PULPJj8uQQx1wGW1LVSjp0QBQTqKGZGdGuafeJ5f5eyIG2cfi3DuZ3AW9lkjAVVKG7NPPmzfuc3yHTrhACOVUotDpLYA6c2IHTotf+28NAjyt+0sooBeUvXCLx+luFf7Sy+AWE482eayOQouTkVjOH+eE42AdjmvPa07dcwFgHtpVO7lwgcpV3h5/PJlqgGWCjy9pSpNysHPiokBVrDvDpZuOXi8bS1LvLcGgE0b7UXXa5icSi/ByUSaXs8iZAXEZcYvuFcuVV61j8BjyUBF2+KmZVSN8dEHaTc2Dl+p5dmc7f7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yc4p6t4MnCoe4/A20rrXNrGh1JYAc2uM2HPqZ8yLu58=;
 b=R3q22WGQ6uMMAJ3T17Mohko55s2jUI0sVXUFEnzQPUCqQOG8ti660w0+niiAOzB4XzHek/9dc1+NFdjWZglfzS8gh16CAX+lPgFXbHAhTUj1DgsXpkdYtfYJT7EP8HR7toXdj4I3ldCGo7kM2cD2gTOvtnjbMilOcMnF459HT30=
Received: from SG2P153MB0361.APCP153.PROD.OUTLOOK.COM (2603:1096:0:4::11) by
 SG2P153MB0229.APCP153.PROD.OUTLOOK.COM (2603:1096:4:8c::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3999.4; Tue, 23 Mar 2021 14:41:16 +0000
Received: from SG2P153MB0361.APCP153.PROD.OUTLOOK.COM
 ([fe80::cd6e:9dc1:85ac:f488]) by SG2P153MB0361.APCP153.PROD.OUTLOOK.COM
 ([fe80::cd6e:9dc1:85ac:f488%5]) with mapi id 15.20.3999.008; Tue, 23 Mar 2021
 14:41:16 +0000
From:   Nagendra Tomar <Nagendra.Tomar@microsoft.com>
To:     tom <tom@talpey.com>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
CC:     Trond Myklebust <trond.myklebust@hammerspace.com>,
        "anna.schumaker@netapp.com" <anna.schumaker@netapp.com>
Subject: RE: [EXTERNAL] Re: [PATCH 0/5] nfs: Add mount option for forcing RPC
 requests for one file over one connection
Thread-Topic: [EXTERNAL] Re: [PATCH 0/5] nfs: Add mount option for forcing RPC
 requests for one file over one connection
Thread-Index: Adcfp3hcmhRvn3IHQv25MQlIHJPMUAAPdXOAAAHL0dA=
Date:   Tue, 23 Mar 2021 14:41:15 +0000
Message-ID: <SG2P153MB03615B7CBA6B53C7E86DFCDE9E649@SG2P153MB0361.APCP153.PROD.OUTLOOK.COM>
References: <SG2P153MB0361E2D69F8AD8AFBF9E7CD89E649@SG2P153MB0361.APCP153.PROD.OUTLOOK.COM>
 <ace78074-0d1f-ceed-10c2-48d2ad3bdde1@talpey.com>
In-Reply-To: <ace78074-0d1f-ceed-10c2-48d2ad3bdde1@talpey.com>
Accept-Language: en-IN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: talpey.com; dkim=none (message not signed)
 header.d=none;talpey.com; dmarc=none action=none header.from=microsoft.com;
x-originating-ip: [122.172.188.128]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 8b25de25-bdd2-4278-d1d0-08d8ee09b6af
x-ms-traffictypediagnostic: SG2P153MB0229:
x-ld-processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
x-microsoft-antispam-prvs: <SG2P153MB02294BB26C01A2C5862DC2459E649@SG2P153MB0229.APCP153.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: jtZjtOjjSdP7bV5u2FQT273xKl2t/it+hpuJ4GXHhFBU/jqU5NAI03yPk1vGr159d4twnevJ/IPf4XWz7OU17AdwHxjvr83b6YmnE+qZqhebF9vS/kD4xogluUcYxVlFJ1z7mt9MUFnngOmnYh+OgknwKMoN+r4IpqzBa+j40BLCxFxI7BDQX7X3U8F5ZBfOu6oG1vOhllAiPr/ay5pkXDAu5+X4d8z+ojtDmM1poclVzWEiTUnXAAE6nX07nRNemNRQhbinOjejFkdxjUcENSZiGDu2J8/x5Subdsan519tPNy+0HrLz9vsOl60Io5zpm+roj46R8j8rqLMXucjb0a3FpZaLUMwtXgdzrDPLjqgU66Wzxg/xVawQHwAM3oFP9rlOx2qoSPt1eJ0z2k8BccFXJk3DZbKLtlN46P1NDHOoc0V2RR0q7Bchq6Kkay/xaosbYBxawwWjK7MFy3/uvjcRlNFR/tQjeWFy4JA3exvF+J0EfUInT0511CbTE3Sd5Qb7m+/ABVQj0p3+b6I+/vBjmY5nbAfegPdBBAQqEdmvcdeeghH+8X/XVqU96h7WGzl7rjr74ff/kNRg1Ogzgq5khnVdv+sYIx0n7iYjKoTtRFcT+WacZOhOvXIb8ryQ4aDp6sLusL4/VLfqyn2C1sSXnT/RmFESIHoR4YU/MY=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SG2P153MB0361.APCP153.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(4636009)(136003)(346002)(376002)(366004)(39860400002)(396003)(4326008)(8990500004)(110136005)(54906003)(71200400001)(316002)(64756008)(66476007)(66556008)(66446008)(76116006)(66946007)(52536014)(2906002)(9686003)(38100700001)(55016002)(8676002)(33656002)(8936002)(7696005)(53546011)(6506007)(83380400001)(186003)(5660300002)(86362001)(55236004)(26005)(478600001)(10290500003)(82960400001)(82950400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?utf-8?B?aE03L0tuSm1RQklJVS9WLzJPc0s1TmFRWDlrYWxZd2hZMXJHK2pJbDFueENV?=
 =?utf-8?B?d1lob3RXanA2dWV5TWc2NTYwY3RjYldPRm1VbkpZV3VYVXB2cWhRTjYxNmx1?=
 =?utf-8?B?dncxaysrdnBoc3hmT09oYUYxUWs4R2V1bTQ2MnBWQVVaTEptR3R2bjFLZHNu?=
 =?utf-8?B?WDl3MDVuaHgyd0ZHTlJEYkFTOGlIUTNTWlJlbnFvSGU5YW9JYTR4bmdsaEsw?=
 =?utf-8?B?ZGhNMjEzMXhLRVhLUW5PRjF6Sy9DVXdxUDhKZUhoYmlDK1hDRFB6ZXJEMUxX?=
 =?utf-8?B?eFZ0WExDL1VQa3dUSWRBclQrblQwWUljYjFkUVExSWlKbW5STUpYa2pkdUNt?=
 =?utf-8?B?by9lV1dvM00zT0RMZzdYd1BtOTVaL0RFL3N6WlVsVmhHWkxuU29WRno4NG5R?=
 =?utf-8?B?SytubnN2bWVVWDZUcytOQ245QkFGWXN6Y1Q5S1ZtaG5xNnQyMW1FUmIrQjBS?=
 =?utf-8?B?SnNaRzdHMFZiY0NVR084ZEFjSUkrUzRyNlZYb3V3emk5L1BOTWZhVDB0UVNp?=
 =?utf-8?B?M0M3RTBDLzVDY2JvQlNVUUQ4a2JPeUZVUk9McXA0M0VNaEFaMXdKcTBrdnAz?=
 =?utf-8?B?OVBpOUFVK3c5NzQ0M3NKeXFvNXlqTDlrTlJEeU04TFZib2VLNzRGOU4rZk5M?=
 =?utf-8?B?R0YrTFBWbitCOWE1UG9zN3Y5R2tzSEg4R1V3T0NXQ3JCdUthLzR1djJ1UGt6?=
 =?utf-8?B?UmxQR0lvSkg5MjMzcExjRFpjeWxIeUc1RU53MDd5RmNDSG9NR1dOZHcwYUxm?=
 =?utf-8?B?MGcySGhOTW5EdnVTbTlrYVNpWnh0Mm4wN0NUTVZhVm05a3paNUR3V0R6TnNS?=
 =?utf-8?B?bjl3dVpiRWVEdzdDU1RWRVd3ZFptNkNudFc5Y2V3aWRURkZITWR2Nzl3akkv?=
 =?utf-8?B?ZjJNdHhlcEoxWUJYSHp1VWE4VHdleVFrVGZmbS9uZjAwWTdqZzVpQnpoV0sv?=
 =?utf-8?B?UXl3VmkzRjRrOEdJK3FJYWh2NUNiZHBSdjRpanZPeHNVa25uVnduRGNhUmk4?=
 =?utf-8?B?dWVPVlJ1SVNDSXhmbENkVXBiRXhERHFITGlFMWtuc3IyRHlmSzh2UURjM0tp?=
 =?utf-8?B?QW9uV0F6aWFDb0s3aGVhNWNoQi8wYXd0NDAvcFFvOEJTQUhDVStEYXBKbVV4?=
 =?utf-8?B?SDNWTi92eHJiZkliZEhDSHl2TERuOG1FdGh6WFhWYWtZdjlERS9Bb3pqUXkw?=
 =?utf-8?B?MmJheU9OQ0orZ3JnQzNiMmdTTjh5SkZCZk9KOWZKMHFJU3J0UE5mUWhvZlQ3?=
 =?utf-8?B?SW14Z1dFdUw0RzI1aEJwYVhreld2UEFlSmZhV0tWQ0tpcGs1QWFCdSsxQnd0?=
 =?utf-8?B?QVhicE1GZHVBOXFIazVrU2dzY0g4MHZlL25EU3cxZGtod2FlaXNOSzkyY2NI?=
 =?utf-8?B?NWMveFQ4cEN2Zk9SZDNXY1N0ZHduL0ljVUF4WFovRnpsMExRU0RaYVA4Z3Nw?=
 =?utf-8?B?N0NsQUJ4MmtTK0YxbjdmZ2VpNDUwN3ArZkdLaVE1ZVFiQnNsak1EYndJbDZl?=
 =?utf-8?B?NVRtRS9tZXd0REJVRlJYSGFmOGtKQnhRbkNacDVIM3g3cGorWTlwdzdBT084?=
 =?utf-8?B?RUR1RUpoaUR4a2xRdG5KeFEvbzBPb2ljNm9oZFE3QXZWL1A0SmxJTlRhTXFs?=
 =?utf-8?B?dlBnV0JwSzZaVDZ6RC80elR2T2V5Nk1RSzRMYzZKVFd4SjY2MThZZU5MQnJ5?=
 =?utf-8?B?ZWsweHF3K0FPYnZTY1M4MFBKK1ZFdVp3VWs0Q081VStDNVlvd1FKSTlianZs?=
 =?utf-8?Q?WMU6XnejPsfsjoKr6Ci+mcBJmtm//PMHldvEuwZ?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SG2P153MB0361.APCP153.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b25de25-bdd2-4278-d1d0-08d8ee09b6af
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Mar 2021 14:41:15.7219
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MTmGJbidhcNJNTtjiqL+VMes0R2cIydmsOKqc0vNOhJ76niMMstaunAuKLOlqFJNzPqOs5QzeU08imd0zx100Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SG2P153MB0229
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

PiBBbGwgdGhlIHBhdGNoZXMgaW4gdGhpcyBzZXJpZXMgaGF2ZSB0aGUgc2FtZSBzdWJqZWN0L3Rp
dGxlLiBUaGV5DQo+IHJlYWxseSBzaG91bGQgaGF2ZSBtb3JlIGNvbnRleHQgc28gdGhleSBzdGFu
ZCBhbG9uZSBhbmQgY2FuIGJlDQo+IHJldmlld2VkIHNlcGFyYXRlbHkuDQoNClRoYW5rcyBmb3Ig
cG9pbnRpbmcsIHRoYXQgd2FzIGNsZWFybHkgdW5pbnRlbnRpb25hbC4gVGhvdWdoIGVhY2ggcGF0
Y2ggZG9lcw0KYnJpZWZseSBkZXNjcmliZSB3aGF0IGl0IGRvZXMuIExldCBtZSBrbm93IGlmIEkg
c2hvdWxkIHJlLXNlbmQuDQoNCj4gDQo+IEhpZ2ggbGV2ZWwgcXVlc3Rpb24gYmVsb3cuDQo+IA0K
PiBPbiAzLzIzLzIwMjEgMTo0NiBBTSwgTmFnZW5kcmEgVG9tYXIgd3JvdGU6DQo+ID4gRnJvbTog
TmFnZW5kcmEgUyBUb21hciA8bmF0b21hckBtaWNyb3NvZnQuY29tPg0KPiA+DQo+ID4gSWYgYSBj
bHVzdGVyZWQgTkZTIHNlcnZlciBpcyBiZWhpbmQgYW4gTDQgbG9hZGJhbGFuY2VyIHRoZSBkZWZh
dWx0DQo+ID4gbmNvbm5lY3Qgcm91bmRyb2JpbiBwb2xpY3kgbWF5IGNhdXNlIFJQQyByZXF1ZXN0
cyB0byBhIGZpbGUgdG8gYmUNCj4gPiBzZW50IHRvIGRpZmZlcmVudCBjbHVzdGVyIG5vZGVzLiBU
aGlzIGlzIGJlY2F1c2UgdGhlIHNvdXJjZSBwb3J0DQo+ID4gd291bGQgYmUgZGlmZmVyZW50IGZv
ciBhbGwgdGhlIG5jb25uZWN0IGNvbm5lY3Rpb25zLg0KPiA+IFdoaWxlIHRoaXMgc2hvdWxkIGZ1
bmN0aW9uYWxseSB3b3JrIChzaW5jZSB0aGUgY2x1c3RlciB3aWxsIHVzdWFsbHkNCj4gPiBoYXZl
IGEgY29uc2lzdGVudCB2aWV3IGlycmVzcGVjdGl2ZSBvZiB3aGljaCBub2RlIGlzIHNlcnZpbmcg
dGhlDQo+ID4gcmVxdWVzdCksIGl0IG1heSBub3QgYmUgZGVzaXJhYmxlIGZyb20gcGVyZm9ybWFu
Y2UgcG92LiBBcyBhbg0KPiA+IGV4YW1wbGUgd2UgaGF2ZSBhbiBORlN2MyBmcm9udGVuZCB0byBv
dXIgT2JqZWN0IHN0b3JlLCB3aGVyZSBldmVyeQ0KPiA+IE5GU3YzIGZpbGUgaXMgYW4gb2JqZWN0
LiBOb3cgaWYgd3JpdGVzIHRvIHRoZSBzYW1lIGZpbGUgYXJlIHNlbnQNCj4gPiByb3VuZHJvYmlu
IHRvIGRpZmZlcmVudCBjbHVzdGVyIG5vZGVzLCB0aGUgd3JpdGVzIGJlY29tZSB2ZXJ5DQo+ID4g
aW5lZmZpY2llbnQgZHVlIHRvIHRoZSBjb25zaXN0ZW5jeSByZXF1aXJlbWVudCBmb3Igb2JqZWN0
IHVwZGF0ZQ0KPiA+IGJlaW5nIGRvbmUgZnJvbSBkaWZmZXJlbnQgbm9kZXMuDQo+ID4gU2ltaWxh
cmx5IGVhY2ggbm9kZSBtYXkgbWFpbnRhaW4gc29tZSBraW5kIG9mIGNhY2hlIHRvIHNlcnZlIHRo
ZSBmaWxlDQo+ID4gZGF0YS9tZXRhZGF0YSByZXF1ZXN0cyBmYXN0ZXIgYW5kIGV2ZW4gaW4gdGhh
dCBjYXNlIGl0IGhlbHBzIHRvIGhhdmUNCj4gPiBhIHhwcnQgYWZmaW5pdHkgZm9yIGEgZmlsZS9k
aXIuDQo+ID4gSW4gZ2VuZXJhbCB3ZSBoYXZlIHNlZW4gc3VjaCBzY2hlbWUgdG8gc2NhbGUgdmVy
eSB3ZWxsLg0KPiA+DQo+ID4gVGhpcyBwYXRjaCBpbnRyb2R1Y2VzIGEgbmV3IHJwY194cHJ0X2l0
ZXJfb3BzIGZvciB1c2luZyBhbiBhZGRpdGlvbmFsDQo+ID4gdTMyIChmaWxlaGFuZGxlIGhhc2gp
IHRvIGFmZmluZSBSUENzIHRvIHRoZSBzYW1lIGZpbGUgdG8gb25lIHhwcnQuDQo+ID4gSXQgYWRk
cyBhIG5ldyBtb3VudCBvcHRpb24gIm5jcG9saWN5PXJvdW5kcm9iaW58aGFzaCIgd2hpY2ggY2Fu
IGJlDQo+ID4gdXNlZCB0byBzZWxlY3QgdGhlIG5jb25uZWN0IG11bHRpcGF0aCBwb2xpY3kgZm9y
IGEgZ2l2ZW4gbW91bnQgYW5kDQo+ID4gcGFzcyB0aGUgc2VsZWN0ZWQgcG9saWN5IHRvIHRoZSBS
UEMgY2xpZW50Lg0KPiANCj4gV2hhdCdzIHRoZSByZWFzb24gZm9yIGV4cG9zaW5nIHRoZXNlIGFz
IGEgbW91bnQgb3B0aW9uLCB3aXRoIG11bHRpcGxlDQo+IHZhbHVlcz8gV2hhdCBtYWtlcyBvbmUg
dmFsdWUgYmV0dGVyIHRoYW4gdGhlIG90aGVyLCBhbmQgd2h5IGlzIHRoZXJlDQo+IG5vdCBhIGRl
ZmF1bHQ/DQoNClRoZSBpZGVhIGlzIHRvIHNlbGVjdCBob3cgUlBDIHJlcXVlc3RzIHRvIHRoZSBz
YW1lIGZpbGUgcGljayB0aGUgb3V0Z29pbmcNCmNvbm5lY3Rpb24uIG5jcG9saWN5PXJvdW5kcm9i
aW4gY2F1c2VzIHRoZSByb3VuZHJvYmluIGNvbm5lY3Rpb24gc2VsZWN0aW9uDQp3aGVyZSBlYWNo
IFJQQyBpcyBzZW50IG92ZXIgdGhlIG5leHQgY29ubmVjdGlvbi4gVGhpcyBpcyBleGlzdGluZyBi
ZWhhdmlvciBhbmQNCmhlbmNlIGlzIHRoZSBkZWZhdWx0IHRvby4NCldpdGggbmNwb2xpY3k9aGFz
aCBtb3VudCBvcHRpb24sIGVhY2ggUlBDIHJlcXVlc3QgdG8gdGhlIHNhbWUgZmlsZS9kaXIsIHVz
ZXMNCnRoZSBzYW1lIGNvbm5lY3Rpb24uIFRoaXMgY29ubmVjdGlvbiBhZmZpbml0eSBpcyB0aGUg
bWFpbiByZWFzb24gYmVoaW5kIHRoaXMNCnBhdGNoLg0KDQo+IA0KPiA+IEl0IGFkZHMgYSBuZXcg
cnBjX3Byb2NpbmZvIG1lbWJlciBwX2ZoaGFzaCwgd2hpY2ggY2FuIGJlIHN1cHBsaWVkDQo+ID4g
YnkgdGhlIHNwZWNpZmljIFJQQyBwcm9ncmFtcyB0byByZXR1cm4gYSB1MzIgaGFzaCBvZiB0aGUg
ZmlsZS9kaXIgdGhlDQo+ID4gUlBDIGlzIHRhcmdldHRpbmcsIGFuZCBsYXN0bHkgaXQgcHJvdmlk
ZXMgcF9maGhhc2ggaW1wbGVtZW50YXRpb24NCj4gPiBmb3IgdmFyaW91cyBORlMgdjMvdjQvdjQx
L3Y0MiBSUENzIHRvIGdlbmVyYXRlIHRoZSBoYXNoIGNvcnJlY3RseS4NCj4gPg0KPiA+IFRob3Vn
aHRzPw0KPiA+DQo+ID4gVGhhbmtzLA0KPiA+IFRvbWFyDQo+ID4NCj4gPiBOYWdlbmRyYSBTIFRv
bWFyICg1KToNCj4gPiAgICBTVU5SUEM6IEFkZCBhIG5ldyBtdWx0aXBhdGggeHBydCBwb2xpY3kg
Zm9yIHhwcnQgc2VsZWN0aW9uIGJhc2VkDQo+ID4gICAgICBvbiB0YXJnZXQgZmlsZWhhbmRsZSBo
YXNoDQo+ID4gICAgU1VOUlBDL05GU3YzL05GU3Y0OiBJbnRyb2R1Y2UgImVudW0gbmNwb2xpY3ki
IHRvIHJlcHJlc2VudCB0aGUNCj4gbmNvbm5lY3QNCj4gPiAgICAgIHBvbGljeSBhbmQgcGFzcyBp
dCBkb3duIGZyb20gbW91bnQgb3B0aW9uIHRvIHJwYyBsYXllcg0KPiA+ICAgIFNVTlJQQy9ORlN2
NDogUmVuYW1lIFJQQ19UQVNLX05PX1JPVU5EX1JPQklOIC0+DQo+IFJQQ19UQVNLX1VTRV9NQUlO
X1hQUlQNCj4gPiAgICBORlN2MzogQWRkIGhhc2ggY29tcHV0YXRpb24gbWV0aG9kcyBmb3IgTkZT
djMgUlBDcw0KPiA+ICAgIE5GU3Y0OiBBZGQgaGFzaCBjb21wdXRhdGlvbiBtZXRob2RzIGZvciBO
RlN2NC9ORlN2NDIgUlBDcw0KPiA+DQo+ID4gICBmcy9uZnMvY2xpZW50LmMgICAgICAgICAgICAg
ICAgICAgICAgfCAgIDMgKw0KPiA+ICAgZnMvbmZzL2ZzX2NvbnRleHQuYyAgICAgICAgICAgICAg
ICAgIHwgIDI2ICsrDQo+ID4gICBmcy9uZnMvaW50ZXJuYWwuaCAgICAgICAgICAgICAgICAgICAg
fCAgIDIgKw0KPiA+ICAgZnMvbmZzL25mczNjbGllbnQuYyAgICAgICAgICAgICAgICAgIHwgICA0
ICstDQo+ID4gICBmcy9uZnMvbmZzM3hkci5jICAgICAgICAgICAgICAgICAgICAgfCAxNTQgKysr
KysrKysrKysNCj4gPiAgIGZzL25mcy9uZnM0Mnhkci5jICAgICAgICAgICAgICAgICAgICB8IDEx
MiArKysrKysrKw0KPiA+ICAgZnMvbmZzL25mczRjbGllbnQuYyAgICAgICAgICAgICAgICAgIHwg
IDE0ICstDQo+ID4gICBmcy9uZnMvbmZzNHByb2MuYyAgICAgICAgICAgICAgICAgICAgfCAgMTgg
Ky0NCj4gPiAgIGZzL25mcy9uZnM0eGRyLmMgICAgICAgICAgICAgICAgICAgICB8IDUxNiArKysr
KysrKysrKysrKysrKysrKysrKysrKysrKystLS0tLQ0KPiA+ICAgZnMvbmZzL3N1cGVyLmMgICAg
ICAgICAgICAgICAgICAgICAgIHwgICA3ICstDQo+ID4gICBpbmNsdWRlL2xpbnV4L25mc19mc19z
Yi5oICAgICAgICAgICAgfCAgIDEgKw0KPiA+ICAgaW5jbHVkZS9saW51eC9zdW5ycGMvY2xudC5o
ICAgICAgICAgIHwgIDE1ICsNCj4gPiAgIGluY2x1ZGUvbGludXgvc3VucnBjL3NjaGVkLmggICAg
ICAgICB8ICAgMiArLQ0KPiA+ICAgaW5jbHVkZS9saW51eC9zdW5ycGMveHBydG11bHRpcGF0aC5o
IHwgICA5ICstDQo+ID4gICBpbmNsdWRlL3RyYWNlL2V2ZW50cy9zdW5ycGMuaCAgICAgICAgfCAg
IDQgKy0NCj4gPiAgIG5ldC9zdW5ycGMvY2xudC5jICAgICAgICAgICAgICAgICAgICB8ICAzOCAr
Ky0NCj4gPiAgIG5ldC9zdW5ycGMveHBydG11bHRpcGF0aC5jICAgICAgICAgICB8ICA5MSArKysr
Ky0NCj4gPiAgIDE3IGZpbGVzIGNoYW5nZWQsIDkxMyBpbnNlcnRpb25zKCspLCAxMDMgZGVsZXRp
b25zKC0pDQo+ID4NCg==

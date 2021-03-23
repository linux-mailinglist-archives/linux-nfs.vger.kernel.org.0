Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A229346DE2
	for <lists+linux-nfs@lfdr.de>; Wed, 24 Mar 2021 00:32:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231172AbhCWXb4 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 23 Mar 2021 19:31:56 -0400
Received: from mail-eopbgr1310117.outbound.protection.outlook.com ([40.107.131.117]:35520
        "EHLO APC01-SG2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229574AbhCWXb1 (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Tue, 23 Mar 2021 19:31:27 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CHG4ejKMc6GDebKvPTv3PDvxrEyddgw7iF6JozrJKoYlwXT5OQfsxOJh81rlyVbKlSU65aBWryKjdR2WUFjyaz67ntCrpqP1Pn2/LwpYWBizfDJpWTHMP8njElji3AYyNhilAEO2zyORJMM9zN6L5ZQWpHnibfoa6/NvF9FIsE5OLYrk2H9AwexReMGvH5Je34OMFyZgV2sp1lgpumqJFLrmPYzWEuEPkX228Ta3WiQKppBf5MOWAfAFhW8lnJmHWt8ZzFyxogTW5ATTwemelW2s4YunTZ+ZAnWF0H0yVRTSJ9fTfrXUceWLkwStOnepL4+1sWUs4njZFJSIXHsjRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P7cv/GVqatNl32RgBMJxXO7dQYN8i5jj1Yz20DUtq4w=;
 b=NpX63ymN0yOnbZbdaT89+xbbtz2HgGg9draEJi3tzfqdADLHyVgPKxwjM6OlmAgANlxfu5SDQoP/k6cL1CsWsLAKf6arptk9HXxmhKRQRIda4Tnb48lQDadCcOttY5e+CojsXqWJ+aer20Xu0LPhcfxxCyaFbKeJ8/ECvv9RwjkHar46w03Jipv36qCWJTTofJPbv9yHt67yilKqV0Yu/Rgb9QHTNXJmAxTjKnL78acMoILoQ4nGZ19XgBdAEDx5GqSDqVMsAiecB7aTLg/SVDt5iSeUEuV2pd2vhoQEvxAcazHhMpYoNHQUeQYr/ncmDs+aHn+G9UdSdvViUwmO3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P7cv/GVqatNl32RgBMJxXO7dQYN8i5jj1Yz20DUtq4w=;
 b=f1GC7VuSm6Vpu2jExPlOjH1xzYl/j64V9UtiEF51SY0ZyneowtYsv7W8uPSfvBVNd2wZfv2wbzicZ4cVLogMmbvMhcwHhq29wL6ufZujrFoAG8d1DhZiFJ3HkOXjw1WV4ybX81CJLlxyx/X980Gl5F1F2PXe+fwdmQ8BCiPVRco=
Received: from SG2P153MB0361.APCP153.PROD.OUTLOOK.COM (2603:1096:0:4::11) by
 SG2P15301MB0014.APCP153.PROD.OUTLOOK.COM (2603:1096:3:f::19) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3999.5; Tue, 23 Mar 2021 23:31:24 +0000
Received: from SG2P153MB0361.APCP153.PROD.OUTLOOK.COM
 ([fe80::cd6e:9dc1:85ac:f488]) by SG2P153MB0361.APCP153.PROD.OUTLOOK.COM
 ([fe80::cd6e:9dc1:85ac:f488%5]) with mapi id 15.20.3999.012; Tue, 23 Mar 2021
 23:31:24 +0000
From:   Nagendra Tomar <Nagendra.Tomar@microsoft.com>
To:     Chuck Lever III <chuck.lever@oracle.com>
CC:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>
Subject: RE: [PATCH 0/5] nfs: Add mount option for forcing RPC requests for
 one file over one connection
Thread-Topic: [PATCH 0/5] nfs: Add mount option for forcing RPC requests for
 one file over one connection
Thread-Index: Adcfp3hcmhRvn3IHQv25MQlIHJPMUAARGOoAAAMHR+AAAek9AAAAU0WQAAIhaYAAALhG4AABaUIAAAmMFWA=
Date:   Tue, 23 Mar 2021 23:31:23 +0000
Message-ID: <SG2P153MB03616FAC8BFEAF305A10A71C9E649@SG2P153MB0361.APCP153.PROD.OUTLOOK.COM>
References: <SG2P153MB0361E2D69F8AD8AFBF9E7CD89E649@SG2P153MB0361.APCP153.PROD.OUTLOOK.COM>
 <CD47CE3E-0C07-4019-94AF-5474D531B12D@oracle.com>
 <SG2P153MB0361BCD6D1F8F86E0648E3EB9E649@SG2P153MB0361.APCP153.PROD.OUTLOOK.COM>
 <5B030422-09B7-470D-9C7A-18C666F5817D@oracle.com>
 <SG2P153MB0361DC1EF8EDD02356D29E579E649@SG2P153MB0361.APCP153.PROD.OUTLOOK.COM>
 <575FF32B-463E-41D8-882F-6A746DF7FDFA@oracle.com>
 <SG2P153MB0361455966B8436516A355729E649@SG2P153MB0361.APCP153.PROD.OUTLOOK.COM>
 <D13EEDD3-522C-4AA3-9FC8-907A582EC57D@oracle.com>
In-Reply-To: <D13EEDD3-522C-4AA3-9FC8-907A582EC57D@oracle.com>
Accept-Language: en-IN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: oracle.com; dkim=none (message not signed)
 header.d=none;oracle.com; dmarc=none action=none header.from=microsoft.com;
x-originating-ip: [122.172.188.128]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: b81c0ee4-dbba-46e6-a090-08d8ee53c5e1
x-ms-traffictypediagnostic: SG2P15301MB0014:
x-microsoft-antispam-prvs: <SG2P15301MB0014E56A1FC1DEFACD4887129E649@SG2P15301MB0014.APCP153.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:854;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ICUb/9hB79WK+Fiu4QP8jg5sprl7QseqCQTGESzNHt60Vo5+vUQY3VHCN8+3vZYo+pC9qalUzES47DYbQh0kwArFXp+x6D8SlTKXBE6xM3ZBRbaYVtTvLAJmozbJIxRMPZPOTKaWFfs39W/hOmHlPMcvcNTO+u1Z7X8HFIPlaCtIavgVlIrvrpHMJwieWtY4DsRrh39CVWv25VNgc+2oV3TYHpP0HoaNjjeG2+2BAi3a0slpS7DEK4ySKzWS0Bjc+uxmftSG9S1swFvJhZ3z73zhGMerde4JAZrN71tR1pb6lFoMWc9q6HL6TrW6rt+AEy5eN1bSiL8C30+Lus5NWxFMyr89WaD4hRW3ODvEX4S0cS/EK92LKjSVC+5wEAisVNoI6bWSzfKara9c2p0P9Whz42egZCNnJmhaw9/Z0KWDxKCzG28ZbQxClasn1f2kVmbMpD5q1kDuW9Fr4nCLVLZyen3pz6WCvefFnmoR5AN7O77AqIFn8aHHnTMRN8NVHVKq5C1I6GR33wH/ZjaWz16As9fbccYuGRCAeXANOw983ypIcZhV1nlYgdWs+bsOkFP4WJBHcZ1ebGiZ4pnOAyUa/TcZ68YOP6UWh7OvnmL0EnPD5M/eyDCoHyysFLSf0ppqeFJAsjUvxL6XLsTX0kBaVkbHl7eHJmqOBcw7H9A=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SG2P153MB0361.APCP153.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(4636009)(136003)(366004)(346002)(39860400002)(376002)(396003)(66946007)(6506007)(55236004)(8936002)(66556008)(66476007)(64756008)(76116006)(38100700001)(71200400001)(66446008)(53546011)(82950400001)(82960400001)(54906003)(83380400001)(8676002)(186003)(26005)(6916009)(316002)(4326008)(2906002)(8990500004)(7696005)(33656002)(52536014)(478600001)(86362001)(9686003)(5660300002)(55016002)(10290500003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?utf-8?B?dEVGMWk2VnRJQ21NQ09BVHJJaTlrTGtyb0hVV01TVmRweTB6VERYZE15MURL?=
 =?utf-8?B?bDZIYlc5c2VUaWplelJFL0tSUVVZR1FoMHUvNXVENHkzNWhEeXV2MTcrWmdW?=
 =?utf-8?B?TEVxNkdtVC9OendqYVNzS3ZXeTQyZGtwSjJRSzliMjk3aTgvZlFNejdkbEJx?=
 =?utf-8?B?NzFpeVY0MWhzZDU0aUFETkI0Qm5hSjkvR284U1pNODJaeXlkR2lSUnU4OGFp?=
 =?utf-8?B?eFFwdzdmZkFZejdKc1JLbkFUTUtnOEJVMC9URWxCNllSMUsrcnNtejAzL0pN?=
 =?utf-8?B?OWdDRThWWjFIUnFpSGRSaitYVTZvWEtDMk41OEg1MVZmbVVJSTMyNDNWVTVD?=
 =?utf-8?B?QXNYbXFRQk5LQmJ0WVVPdUhYdDdYdEFiWVppZEJKQTJXYWdVRHd1YkNZbEw0?=
 =?utf-8?B?bURiaUpVWEo0MTBpQUROM3BxdlRCM1MzdkJHVnNmN3kzaVRxVDhhOVdDZzhl?=
 =?utf-8?B?cVJ4WWJvSyt0OFc0bjdPRHllR2xSaER2ZnF3VWdyT2FJR0NYSVhaMTQydlZF?=
 =?utf-8?B?OXNCUTdtZjQ1dEwzNHhIZ3ZKSU9CTHNnQ01JY1dXWURNQlhDeUhocWljc0VO?=
 =?utf-8?B?WVBkQjhnblQxSnlCejhVYkRhci85RzFpWERHRU1MU093UDErcGk1VVJPdndC?=
 =?utf-8?B?ZDZGeGdpSlF5Y0VWTWRYbnFOZGZUNnB4SDRwQWRTUFpwZzZZMjRXeG1mTlJN?=
 =?utf-8?B?anhmYkRnUDRVSzRqYk55RFFpVFVLZm8xMUlHSlRTWXQ0b3JRQmJ2TEhCNi9r?=
 =?utf-8?B?clZTVnZ2VS90Q0Rrb003cE5vaWJiVjhuQ3ZjZEZBMkxWV01MUzNBZGxXVlR1?=
 =?utf-8?B?NTdydXcwSVhHSFFTYjZweDFsQzJpSkx4eGpacjhIUWgxU09lNFAzQ0hiUm9n?=
 =?utf-8?B?Q1dCQ2pobjZUYjFsNmpFVFl3alV0bGNOS2NDdEtYenZjd1RIdWZnZzJQb2ZI?=
 =?utf-8?B?UFR5YnFGc2QzcjdpajQxRTZKdEFpeWdiaGRpcDRxRE1NaE9Ma0dHTmE5R0xx?=
 =?utf-8?B?dzhlY3pmOFFxWWhzcEsyakVJdktubDVBc0JId3F1NFdRcGVGanVoV29zbkVB?=
 =?utf-8?B?QXF5ZUk0SnVIeEZTTGdEckhKWngzTlhRNjhoZXNtUHJsbGVPSXEvRjhHa0oy?=
 =?utf-8?B?OUtYbjdWcExvMmUvQTA1ZU5hdFdnNFUyL1J2VGFOUUg2UzlUWFI4MVRJbGxZ?=
 =?utf-8?B?YS8xWERCMmJpbWlXM3l1enQ3TmY5cXMyYkFFamp6eG1aTFVMdStXdHhZSjA1?=
 =?utf-8?B?dGE2eW4yeEV4alVaZzgyeEYyb3JhRHpmRlg0amZXMUVEMHEyUDV2aWJlTXJ5?=
 =?utf-8?B?dmFRZ2JiY0wwWnRMMVJva3VRM1FSclc1S0ZhaDBpS0ViV1RKbWErOTRNejRj?=
 =?utf-8?B?NTkva1ZrRGorYXo2VGEydmtxaUlDdjJCdURUcHNyZzZtR1VSbXRaMGl0dFdu?=
 =?utf-8?B?ZFgzcnEvUEorakFoWTNjc1A0MTFlelo4bmhhYnp5OW0rWnR1Z1VsQlFuNUty?=
 =?utf-8?B?RlM2RnNOUzQrc2lZcjhwWGluZnNOWkg4K1Z6Y0RlRnBKd0E0VnhheDIrSXpW?=
 =?utf-8?B?TXQzdnJhazMxQjJzNXpzSS9jdFNzWE1HMmxWMGxMOFQyaGs1RmtCZmw1WWtx?=
 =?utf-8?B?c1hjak90NVp0aFF2UWN4TjJBTDVHN0tjVFlHbFFobjZLZXBOMjdCRHdubVp5?=
 =?utf-8?B?NEtXczJnOERyUUlrT1ZOck9tcWJ4Y0JSVU9CSWtxU2NaZlB5TEZVVHZ1ZnNN?=
 =?utf-8?Q?ywozFM6Zl7mX25jezW5KGCnU4KdOFE0jBClu+ew?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SG2P153MB0361.APCP153.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: b81c0ee4-dbba-46e6-a090-08d8ee53c5e1
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Mar 2021 23:31:24.0150
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zp6PcGi0pRd1lsw2oKxAHzRwKWo1MDq+3xVl9VDRHSm1bdQwjz3aRkS8jumI7yWOG5tbKB+BlT3Gy/hHfhDEbg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SG2P15301MB0014
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

PiA+IE9uIE1hciAyMywgMjAyMSwgYXQgMjowMSBQTSwgTmFnZW5kcmEgVG9tYXINCj4gPE5hZ2Vu
ZHJhLlRvbWFyQG1pY3Jvc29mdC5jb20+IHdyb3RlOg0KPiA+DQo+ID4+IFRoZSBvdGhlciBhbHRl
cm5hdGl2ZSBpcyB0byBtYWtlIHRoZSBsb2FkIGJhbGFuY2VyIHNuaWZmIHRoZSBGSCBmcm9tIGVh
Y2gNCj4gPj4gTkZTIHJlcXVlc3QgYW5kIGRpcmVjdCBpdCB0byBhIGNvbnNpc3RlbnQgTkZTdjMg
RFMuIEkgc3RpbGwgcHJlZmVyIHRoYXQNCj4gPj4gb3ZlciBhZGRpbmcgYSB2ZXJ5IHNwZWNpYWwt
Y2FzZSBtb3VudCBvcHRpb24gdG8gdGhlIExpbnV4IGNsaWVudC4gQWdhaW4sDQo+ID4+IHlvdSdk
IGJlIGRlcGxveWluZyBhIGNvZGUgY2hhbmdlIGluIG9uZSBwbGFjZSwgdW5kZXIgeW91ciBjb250
cm9sLCBpbnN0ZWFkDQo+ID4+IG9mIG9uIDEwMCdzIG9mIGNsaWVudHMuDQo+ID4NCj4gPiBUaGF0
IGlzIG9uZSBvcHRpb24gYnV0IHRoYXQgbWFrZXMgTEIgYXBwbGljYXRpb24gYXdhcmUgYW5kIHBv
dGVudGlhbGx5IGxlc3MNCj4gPiBwZXJmb3JtYW50LiBBcHByZWNpYXRlIHlvdXIgc3VnZ2VzdGlv
biwgdGhvdWdoIQ0KPiANCj4gWW91IG1pZ2h0IGdldCBwYXJ0IG9mIHRoZSB3YXkgdGhlcmUgYnkg
aGF2aW5nIHRoZSBMQiBkaXJlY3QNCj4gdHJhZmZpYyBmcm9tIGEgcGFydGljdWxhciBjbGllbnQg
dG8gYSBwYXJ0aWN1bGFyIGJhY2tlbmQgTkZTDQo+IHNlcnZlci4gVGhlIGNsaWVudCBhbmQgaXRz
IGFwcGxpY2F0aW9ucyBhcmUgYm91bmQgdG8gaGF2ZSBhDQo+IG5hcnJvdyBmaWxlIHdvcmtpbmcg
c2V0Lg0KDQpZZXMsIHdpdGggdGhlIGxpbWl0YXRpb24gdGhhdCBvbmUgY2xpZW50IHdpbGwgb25s
eSBiZSBzZXJ2ZWQgYnkgb25lIGNsdXN0ZXINCm5vZGUuIFRoaXMgaXMgbm90IGFzIGdvb2QgYXMg
ZGlzdHJpYnV0aW5nIGRpZmZlcmVudCBmaWxlcyB0byBkaWZmZXJlbnQgbm9kZXMsDQp3aGljaCB3
b3VsZCBnZXQgdGhlIGhpZ2hlc3QgYWdncmVnYXRlIHRocm91Z2hwdXQvSU9wcyBwb3NzaWJsZS4N
Cg0KPiANCj4gDQo+ID4gSSB3YXMgaG9waW5nIHRoYXQgc3VjaCBhIGNsaWVudCBzaWRlIGNoYW5n
ZSBjb3VsZCBiZSB1c2VmdWwgdG8gcG9zc2libHkgbW9yZQ0KPiA+IHVzZXJzIHdpdGggc2ltaWxh
ciBzZXR1cHMsIGFmdGVyIGFsbCBmaWxlLT5jb25uZWN0aW9uIGFmZmluaXR5IGRvZXNuJ3Qgc291
bmQgdG9vDQo+ID4gYXJjYW5lIGFuZCBvbmUgY2FuIHRoaW5rIG9mIGJlbmVmaXRzIG9mIG9uZSBu
b2RlIHByb2Nlc3Npbmcgb25lIGZpbGUuIE5vPw0KPiANCj4gVGhhdCdzIHdoZXJlIEknbSBnZXR0
aW5nIGh1bmcgdXAgKG91dHNpZGUgdGhlIHBlcnNvbmFsIHByZWZlcmVuY2UNCj4gdGhhdCB3ZSBu
b3QgaW50cm9kdWNlIHllcyBhbm90aGVyIG1vdW50IG9wdGlvbikuIFdoaWxlIEkgdW5kZXJzdGFu
ZA0KPiB3aGF0J3MgZ29pbmcgb24gbm93ICh0aGFua3MhKSBJJ20gbm90IHN1cmUgdGhpcyBpcyBh
IGNvbW1vbiB1c2FnZQ0KPiBzY2VuYXJpbyBmb3IgTkZTdjMuIE90aGVyIG9waW5pb25zIHdlbGNv
bWUgaGVyZSENCj4gDQo+IE5vciBkb2VzIGl0IHNlZW0gbGlrZSBvbmUgdGhhdCB3ZSB3YW50IHRv
IGVuY291cmFnZSBvdmVyIHNvbHV0aW9ucw0KPiBsaWtlIHBORlMuIEdlbmVyYWxseSB0aGUgTGlu
dXggY29tbXVuaXR5IGhhcyB0YWtlbiB0aGUgcG9zaXRpb24NCj4gdGhhdCBzZXJ2ZXIgYnVncyBz
aG91bGQgYmUgYWRkcmVzc2VkIG9uIHRoZSBzZXJ2ZXIsIGFuZCB0aGlzIHNlZW1zDQo+IGxpa2Ug
YSBwcm9ibGVtIHRoYXQgaXMgaW50cm9kdWNlZCBieSB5b3VyIG1pZGRsZWJveCBhbmQgc2VydmVy
DQo+IGNvbWJpbmF0aW9uLiANCg0KSSB3b3VsZCBsaWtlIHRvIGxvb2sgYXQgaXQgbm90IGFzIGEg
cHJvYmxlbSBjcmVhdGVkIGJ5IG91ciBzZXJ2ZXIgc2V0dXAsDQpidXQgcmF0aGVyIGFzICJvbmUg
bW9yZSBzY2VuYXJpbyIgd2hpY2ggdGhlIGNsaWVudCBjYW4gbXVjaCBlYXNpbHkgYW5kDQpnZW5l
cmljYWxseSBoYW5kbGUgYW5kIGhlbmNlIHRoZSBwYXRjaC4NCg0KPiBUaGUgY2xpZW50IGlzIHdv
cmtpbmcgcHJvcGVybHkgYW5kIGlzIGNvbXBseWluZyB3aXRoIHNwZWMuDQoNClRoZSBuY29ubmVj
dCByb3VuZHJvYmluIGRpc3RyaWJ1dGlvbiBpcyBqdXN0IG9uZSB3YXkgb2YgdXRpbGl6aW5nIG11
bHRpcGxlDQpjb25uZWN0aW9ucywgd2hpY2ggaGFwcGVucyB0byBiZSBsaW1pdGluZyBmb3IgdGhp
cyBzcGVjaWZpYyB1c2VjYXNlLiANCk15IHBhdGNoIHByb3Bvc2VzIGFub3RoZXIgd2F5IG9mIGRp
c3RyaWJ1dGluZyBSUENzIG92ZXIgdGhlIGNvbm5lY3Rpb25zLA0Kd2hpY2ggaXMgbW9yZSBzdWl0
YWJsZSBmb3IgdGhpcyB1c2VjYXNlIGFuZCBtYXliZSBvdGhlcnMuIE5vIHZpb2xhdGlvbiBvZiAN
CmFueSBzcGVjIPCfmIoNCg0KPiANCj4gSWYgdGhlIHNlcnZlciBjbHVzdGVyIHByZWZlcnMgcGFy
dGljdWxhciByZXF1ZXN0cyB0byBnbyB0byBwYXJ0aWN1bGFyDQo+IHRhcmdldHMsIGEgbGF5b3V0
IGlzIHRoZSB3YXkgdG8gZ28sIElNSE8uDQo+IA0KPiAoSSdtIG5vdCBzcGVha2luZyBmb3IgdGhl
IE5GUyBjbGllbnQgbWFpbnRhaW5lcnMsIGp1c3Qgb2ZmZXJpbmcgYW4NCj4gb3BpbmlvbiBhbmQg
aG9waW5nIG15IGNvbW1lbnRzIGNsYXJpZnkgdGhlIHNjZW5hcmlvIGZvciBvdGhlcnMgb24NCj4g
dGhlIGxpc3QgcGF5aW5nIGF0dGVudGlvbiB0byB0aGlzIHRocmVhZCkuDQoNCkFwcHJlY2lhdGUg
eW91ciBjb21tZW50cywgdGhhbmtzISANCkl0J3MgYWx3YXlzIGdyZWF0IHRvIGhlYXIgZnJvbSBv
dGhlciB3ZWxsLWluZm9ybWVkIHVzZXJzLg0KDQo+IA0KPiAtLQ0KPiBDaHVjayBMZXZlcg0KPiAN
Cj4gDQoNCg==

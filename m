Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D86C913DEFC
	for <lists+linux-nfs@lfdr.de>; Thu, 16 Jan 2020 16:38:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726555AbgAPPiU (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 16 Jan 2020 10:38:20 -0500
Received: from mail-dm6nam11on2117.outbound.protection.outlook.com ([40.107.223.117]:34500
        "EHLO NAM11-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726100AbgAPPiU (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Thu, 16 Jan 2020 10:38:20 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U9SwA3S3ZHKwkqdbmhPY3fKxaXjFXbrpvEhoEqeBe6gC/uCpK64Fmn23nzI4JI3HGLSvS9FPB1A1dfFtcwSDKVaC8eubL6G9XVTD1E0D64uX100TYdxSctMkLRHeAZMg9TyavITArYL4zjKBGA7SHiky92NSZh61KUMQYQ9cLVaeBSfxaxu+5mEBPLMojhPV1YY0ZIS7e9lsqXPfbDWF/iScNvhNy7m3lV0jDXXsWSfJ5gxj0jSM8FqkHZfR+IyAhmEVHuDxdQ1FQCm+N/Hu1SRmbb7coR61Y3qe0hBrQYrRUTHnqZWJhfNR4Y+eH5OgrTjFGPDR7GJKNZH917egyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=us+mggzPTKxJG4j9NzWzufkqYmTi5FFn9DxMbYgcCc4=;
 b=RGXLID/Vqkg3PYUxh+uulQldGfeZL2fflrvZ/XrMxuYXeWMZv3TlWXEoyehpTIXg11TC5u+R+/Yl5wmlPmpeODDGlGxK49GeoS5jVHRoBaikAO2KTcZhjMqtuybxz3JqXhA7CXL5TbQUVbKT2xSScdbAi/wP/zO3aJw1DLadYKfc0mqI7aRcTl9zcw1jpFx036H+2VSdPdpz3b+qkCpKtgTGfYclHgefoY/pFJNECOROizBwfXgN5//nVRx5yF6XnPT1g99ic/VJGtXAqjyJ8PSva9IoponVx/Iw0S3jut1bVEScbj78age/Qd3q4x0O6jhhN3PcVfOIxiOIpU64Bg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=us+mggzPTKxJG4j9NzWzufkqYmTi5FFn9DxMbYgcCc4=;
 b=KErHuRqyJQ6suW+OrL4RsNpNKfIb92GaQj9pdNgF6Dd7TDTyuuve2yANc561zsvdVGrTtRu53e08IMUkw8yKzEwI2gm0ci1lTv3GYwYBQdLh3UZmAvcSyldx+reuLCq+kBsGf3igBb+g4lo/aUnDMOf+GPSvDEzlDKZto7JztFE=
Received: from DM5PR1301MB2108.namprd13.prod.outlook.com (10.174.186.34) by
 DM5PR1301MB2044.namprd13.prod.outlook.com (10.174.186.30) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2644.7; Thu, 16 Jan 2020 15:38:15 +0000
Received: from DM5PR1301MB2108.namprd13.prod.outlook.com
 ([fe80::2d32:cf4b:1b58:16ce]) by DM5PR1301MB2108.namprd13.prod.outlook.com
 ([fe80::2d32:cf4b:1b58:16ce%7]) with mapi id 15.20.2644.021; Thu, 16 Jan 2020
 15:38:15 +0000
From:   Trond Myklebust <trondmy@hammerspace.com>
To:     "bcodding@redhat.com" <bcodding@redhat.com>
CC:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
Subject: Re: Lookup revalidation for OPEN_CLAIM_FH
Thread-Topic: Lookup revalidation for OPEN_CLAIM_FH
Thread-Index: AQHVzHQOQmnjbX8Fb0WPSO1cRvS5YaftW3aAgAAKu4CAAAbTgA==
Date:   Thu, 16 Jan 2020 15:38:14 +0000
Message-ID: <3a91fb298d29c17c76e2bce1a190110cd6fe72c0.camel@hammerspace.com>
References: <31B20BC3-A089-47F9-9821-7A3543FF7413@redhat.com>
         <7eae4162d7c8a85bbb7fddab3a818472ec2ebc54.camel@hammerspace.com>
         <C69931E7-7465-4662-91AC-C74609A4CDB2@redhat.com>
In-Reply-To: <C69931E7-7465-4662-91AC-C74609A4CDB2@redhat.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=trondmy@hammerspace.com; 
x-originating-ip: [68.40.189.247]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 673e710e-e152-40c7-78ac-08d79a9a1a37
x-ms-traffictypediagnostic: DM5PR1301MB2044:
x-microsoft-antispam-prvs: <DM5PR1301MB20441B2104B250099638AB06B8360@DM5PR1301MB2044.namprd13.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 02843AA9E0
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(346002)(136003)(396003)(39830400003)(366004)(189003)(199004)(5660300002)(6512007)(66476007)(66446008)(66946007)(64756008)(6916009)(66556008)(6486002)(8936002)(26005)(8676002)(71200400001)(316002)(2616005)(36756003)(91956017)(53546011)(186003)(4326008)(6506007)(86362001)(2906002)(478600001)(81166006)(81156014)(76116006);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR1301MB2044;H:DM5PR1301MB2108.namprd13.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: hammerspace.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: RlAmROpGLXQ78fnKfYptCcSFSVu9HYUAYxSoHhWV9wX7HHIfLTu2Rl8PsRyWAxTz2B5FZm4ZUuUrNLGhqOBVxIA02/6/8Rzhb/poDAcYMJv+mC36+xvV4GzHwWRDPVHnxEaAIUxzPKfaQtBFwl0oFoXWUMGsJYi7MQUzUQdbLvvKA5jZ3VOvJzSphU5oVzJHLisbOun1pUuZu6F+gT/hly6wpQsC8R0RXho9LGhTO9WDJKJQuzsaBspzEC2ex59jydTRvCZ29WMTcEMgJ724DLiJ8eWEjtKNy52/VuvkKlquVkyBuviQDf2dQZlPzlGoakQjAK1yfNYg9Q771pRWy6mcc0iWKwD/vDbX9wRUU/LS/Rr6IMZDCLPhDXStsapsi90yJAqnBVJ9WTLHhgSZoNfqp6v6F69SxmnR6ekxBbtSp4v4+jSTVIq+AnjmPUFw
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <FF326153DBF72B48A9163D1F3E138DC3@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 673e710e-e152-40c7-78ac-08d79a9a1a37
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Jan 2020 15:38:15.0159
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MBptYZE3qcknUBP9PfopCOGwQ6c81PZk9D40EiVaI38zcSEXqxA2iULfOBveaP2955V7TwU83/BXY/R2mqc4KQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1301MB2044
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

T24gVGh1LCAyMDIwLTAxLTE2IGF0IDEwOjEzIC0wNTAwLCBCZW5qYW1pbiBDb2RkaW5ndG9uIHdy
b3RlOg0KPiBPbiAxNiBKYW4gMjAyMCwgYXQgOTozNSwgVHJvbmQgTXlrbGVidXN0IHdyb3RlOg0K
PiANCj4gPiBPbiBUaHUsIDIwMjAtMDEtMTYgYXQgMDg6NTEgLTA1MDAsIEJlbmphbWluIENvZGRp
bmd0b24gd3JvdGU6DQo+ID4gPiBIaSBUcm9uZCwNCj4gPiA+IA0KPiA+ID4gSSdkIGxpa2UgdG8g
Zml4IHVwIGxvb2t1cCByZXZhbGlkYXRpb24gZm9yIHY0LjErIHdoZW4gdGhlIGNsaWVudA0KPiA+
ID4gaXMNCj4gPiA+IHVzaW5nDQo+ID4gPiBPUEVOX0NMQUlNX0ZILiAgVGhlIGZpeGVzIGEgd2hp
bGUgYmFjayBmb3IgU3RhbiBIdSdzIGNhc2UgZG8gbm90DQo+ID4gPiBzZWVtDQo+ID4gPiB0bw0K
PiA+ID4gaW1wcm92ZSB0aGluZ3MgZm9yIHY0LjEsIGFuZCBhY3R1YWxseSBtYWtlIHRoZSBiZWhh
dmlvciBhIGJpdA0KPiA+ID4gd29yc2UNCj4gPiA+IHNpbmNlIHdlDQo+ID4gPiBubyBsb25nZXIg
cGFzcyB0aHJvdWdoIG5mc19sb29rdXBfdmVyaWZ5X2lub2RlKCksIHdoaWNoIHdvdWxkDQo+ID4g
PiBjYXRjaA0KPiA+ID4gdGhlDQo+ID4gPiBjYXNlcyB3aGVyZSBubGluayA9PSAwLg0KPiA+ID4g
DQo+ID4gPiBXb3VsZCB5b3UgYWNjZXB0IHdvcmsgdG8gX2Fsd2F5c18gcmV2YWxpZGF0ZSB0aGUg
ZGVudHJ5J3MgcGFyZW50DQo+ID4gPiBmb3INCj4gPiA+IENMQUlNX0ZIPyAgQWx0ZXJuYXRpdmVs
eSwgaXQgc2VlbXMgdGhhdCBDTEFJTV9OVUxMIHdvdWxkIGJlDQo+ID4gPiBwcmVmZXJhYmxlIGZv
cg0KPiA+ID4gdGhpcyBjYXNlLCB0aG91Z2ggSSBkb24ndCBrbm93IGhvdyB0aGUgY2xpZW50IHdv
dWxkIGtub3cgd2hlbiB0bw0KPiA+ID4gZGVjaWRlDQo+ID4gPiBiZXR3ZWVuIHRoZW0uDQo+ID4g
PiANCj4gPiA+IEhlcmUncyBhIHNpbXBsZSByZXByb2R1Y2VyIGZvciBjb252ZW5pZW5jZSwgSSB0
aGluayB3ZSd2ZSBhbHJlYWR5DQo+ID4gPiBhbGwNCj4gPiA+IGFncmVlZA0KPiA+ID4gdGhhdCB0
aGUgYmVoYXZpb3Igd2Ugd2FudCBpcyBmb3IgdGhlIHNlY29uZCBvcGVuIGJ5IGBjYXRgIHRvDQo+
ID4gPiByZWZsZWN0DQo+ID4gPiB0aGUNCj4gPiA+IHJlc3VsdHMgb2YgdGhlIG1vdmUgb24gdGhl
IHNlcnZlciwgb3IgYXQgbGVhc3QgZXZlbnR1YWxseSBsYXRlcg0KPiA+ID4gb3BlbnMNCj4gPiA+
IHdvdWxkDQo+ID4gPiByZXZhbGlkYXRlIHRoZSBkZW50cnk6DQo+ID4gPiANCj4gPiA+ICMhL2Jp
bi9iYXNoDQo+ID4gPiANCj4gPiA+IHNldCAtbyB4dHJhY2UNCj4gPiA+IHZlcnM9NC4xDQo+ID4g
PiANCj4gPiA+IGV4cG9ydGZzIC11YQ0KPiA+ID4gZXhwb3J0ZnMgLW8gcncsc2VjPXN5cyxub19y
b290X3NxdWFzaCAqOi9leHBvcnRzDQo+ID4gPiANCj4gPiA+IG1rZGlyIC9tbnQvbG9jYWxob3N0
IHx8IHRydWUNCj4gPiA+IA0KPiA+ID4gcm0gLWYgL2V4cG9ydHMvZmlsZXsxLDJ9DQo+ID4gPiAN
Cj4gPiA+IGVjaG8gdGhpcyBpcyBmaWxlIDEgPiAvZXhwb3J0cy9maWxlMQ0KPiA+ID4gZWNobyB0
aGlzIGlzIGZpbGUgMiA+IC9leHBvcnRzL2ZpbGUyDQo+ID4gPiANCj4gPiA+IG1vdW50IC10IG5m
cyAtb3YkdmVycyxzZWM9c3lzIGxvY2FsaG9zdDovZXhwb3J0cyAvbW50L2xvY2FsaG9zdA0KPiA+
ID4gDQo+ID4gPiB0YWlsIC1mIC9tbnQvbG9jYWxob3N0L2ZpbGUxICYNCj4gPiA+IHNsZWVwIDEN
Cj4gPiA+IA0KPiA+ID4gIyB0aGlzIGlzIGZpbGUgMQ0KPiA+ID4gY2F0IC9tbnQvbG9jYWxob3N0
L2ZpbGUxDQo+ID4gPiANCj4gPiA+ICMgb3ZlcndyaXRlIHRoZSBmaWxlIG9uIHRoZSBzZXJ2ZXI6
DQo+ID4gPiBtdiAtZiAvZXhwb3J0cy9maWxlMiAvZXhwb3J0cy9maWxlMQ0KPiA+ID4gDQo+ID4g
PiAjIHRoaXMgaXMgZmlsZSAyDQo+ID4gPiBjYXQgL21udC9sb2NhbGhvc3QvZmlsZTENCj4gPiA+
IA0KPiA+ID4ga2lsbGFsbCB0YWlsDQo+ID4gPiAjIHRoaXMgaXMgZmlsZSAyDQo+ID4gPiBjYXQg
L21udC9sb2NhbGhvc3QvZmlsZTENCj4gPiA+IHVtb3VudCAvbW50L2xvY2FsaG9zdA0KPiA+ID4g
DQo+ID4gPiANCj4gPiA+IFN3aXRjaGluZyB0aGUgJHZlcnMgdmFyaWFibGUgYmV0d2VlbiB2NC4w
IGFuZCB2NC4xIGluIHRoaXMgc2NyaXB0DQo+ID4gPiBzaG93cyB0aGUNCj4gPiA+IGRpZmZlcmVu
Y2UgaW4gYmVoYXZpb3IuDQo+ID4gPiANCj4gPiANCj4gPiBJZiBzb21lYm9keSBuZWVkcyBzdHJv
bmdlciBsb29rdXAgY2FjaGUgcmV2YWxpZGF0aW9uLCB0aGVuIHRoYXQncw0KPiA+IHdoYXQNCj4g
PiB0aGV5IGhhdmUgdGhlICdsb29rdXBjYWNoZT1ub25lJyBtb3VudCBvcHRpb24gZm9yLiBXZSBo
YXZlIHRoZXNlDQo+ID4gJ2xvb2t1cGNhY2hlJyBtb3VudCBvcHRpb25zIGluIG9yZGVyIHRvIGFs
bG93IHVzZXJzIHRvIHRhaWxvciB0aGUNCj4gPiBjYWNoaW5nIGJlaGF2aW91ciAob24gYSBwZXIt
bW91bnQgYmFzaXMpIHNob3VsZCB0aGUgZGVmYXVsdA0KPiA+IGJlaGF2aW91cg0KPiA+IGJlIGlu
c3VmZmljaWVudGx5IHN0cmljdC4NCj4gPiANCj4gPiBTaW5jZSB5b3VyIHRlc3RjYXNlIGRvZXNu
J3QgdXNlIHRoYXQgbW91bnQgb3B0aW9uLCBJIGRvbid0IHNlZSB3aGF0DQo+ID4gaXQNCj4gPiBp
cyBwcm92aW5nIG90aGVyIHRoYW4gd2hhdCB3ZSBhbHJlYWR5IGtub3cgYWJvdXQgdGhlIGRlZmF1
bHQgbG9va3VwDQo+ID4gY2FjaGluZzogbmFtZWx5IHRoYXQgaXQgc2FjcmlmaWNlcyBzb21lIGFj
Y3VyYWN5IGluIHRoZSBpbnRlcmVzdCBvZg0KPiA+IGZpbGUgb3BlbiBwZXJmb3JtYW5jZS4NCj4g
DQo+IFRoYW5rcyBmb3IgdGhlIGxvb2suICBUaGUgdGVzdGNhc2Ugb25seSBwcm92aWRlcyBhIGNv
bXBhcmlzb24gb2YNCj4gZGlmZmVyZW50DQo+IGJlaGF2aW9yIGJldHdlZW4gdjQuMCBhbmQgdjQu
MSwgd2hpY2ggaXMgZHVlIHRvIG91ciB1c2Ugb2YgQ0xBSU1fTlVMTA0KPiB2cw0KPiBDTEFJTV9G
SC4NCj4gDQo+IEluZGVlZCwgc2V0dGluZyBsb29rdXBjYWNoZT1ub25lIGdpdmUgcmVhbC10aW1l
IHVwZGF0ZXMuICBXaXRoDQo+IGRlZmF1bHQNCj4gbG9va3VwY2FjaGUsIGFmdGVyIHRoZSBkaXJl
Y3RvcnkgYXR0cmlidXRlcyB0aW1lIG91dCwgdGhlIGNsaWVudCB3aWxsDQo+IGxpa2V3aXNlIGdl
dCB0aGUgbmFtZXNwYWNlIHJpZ2h0LiAgU28sIHRoaXMgaXNuJ3QgYSBtYWpvciBwcm9ibGVtLA0K
PiBidXQgd2UgZG8NCj4gaGF2ZSBzb21lICBRRSBmb2xrcyB0aGF0IGFyZSB1bmhhcHB5IGFib3V0
IGl0Lg0KPiANCj4gQ2FuIHdlIGltcHJvdmUgdGhpbmdzIGEgYml0IGZvciB2NC4xIHdpdGhvdXQg
c2FjcmlmaWNpbmcNCj4gcGVyZm9ybWFuY2U/ICBJDQo+IGNhbid0IHRoaW5rIG9mIGEgcmVhc29u
IHRvIG5vdCBnbyBiYWNrIHRvIENMQUlNX05VTEwgaW4NCj4gbmZzNF9maWxlX29wZW4oKS4NCj4g
TWF5YmUgaXQgaXMgYSBiaXQgbW9yZSB3b3JrIG9uIHRoZSBzZXJ2ZXIgdG8gaGF2ZSB0byBkbyBv
bmUgZXh0cmENCj4gbG9va3VwIHBlcg0KPiBvcGVuLCBidXQgd2UnbGwgZW5kIHVwIHdpdGggdGhl
IHJpZ2h0IGZpbGUgZWFjaCB0aW1lLg0KPiANCj4gSXQgbWFrZXMgc2Vuc2UgdG8ga2VlcCBDTEFJ
TV9GSCBmb3IgcmVjb3ZlcnksIGJ1dCB3aHkga2VlcCBpdCBmb3INCj4gcmVndWxhcg0KPiBvcGVu
cz8NCj4gDQoNCm5mc19maWxlX29wZW4oKSBpcyBjb21wbGV0ZWx5IHRoZSB3cm9uZyBwbGFjZSB0
byBwZXJmb3JtIGEgbG9va3VwLiBJdHMNCnB1cnBvc2UgaW4gdGhlIFZGUyBpcyB0byBhbGxvdyB0
aGUgZmlsZXN5c3RlbSB0byBzZXQgdXAgc3RhdGUgKmFmdGVyKg0Kd2UndmUgYWxyZWFkeSBsb29r
ZWQgdXAgdGhlIGRlbnRyeSwgcmV2YWxpZGF0ZWQgaXQgYW5kIHRoZXJlZm9yZQ0KZGVjaWRlZCB3
aGljaCBmaWxlIHRvIG9wZW4uDQpUaGUgTkZTdjQuMCBiZWhhdmlvdXIgb2YgcGVyZm9ybWluZyBh
IG5ldyBsb29rdXAgaXMgYWN0dWFsbHkgdGhlDQphYmVycmF0aW9uIGhlcmUsIGFuZCBpcyBkdWUg
dG8gdGhlIGZhY3QgdGhhdCBpdCBkb2VzIG5vdCBoYXZlIGFuIG9wZW4tDQpieS1maWxlaGFuZGxl
IG9wZXJhdGlvbiwgc28gd2UgaGF2ZSBubyBhbHRlcm5hdGl2ZS4NCg0KQXMgSSBzYWlkLCBpZiB5
b3Ugd2FudCBzdHJvbmdlciBzZW1hbnRpY3MsIHRoZXJlIGFyZSBsb29rdXBjYWNoZSBtb3VudA0K
b3B0aW9ucyB0aGF0IGFsbG93IHlvdSB0byB0dW5lIHRoaW5ncy4gSSB0aGVyZWZvcmUgc2VlIG5v
IHZhbGlkIHJlYXNvbg0KdG8gY2hhbmdlIHRoZSBleGlzdGluZyBiZWhhdmlvdXIsIHdoaWNoIGFs
c28gbWF0Y2hlcyB0aGF0IG9mIG9sZGVyIE5GUw0KdmVyc2lvbnMgKGkuZS4gdjMgYW5kIHYyKS4N
Cg0KLS0gDQpUcm9uZCBNeWtsZWJ1c3QNCkxpbnV4IE5GUyBjbGllbnQgbWFpbnRhaW5lciwgSGFt
bWVyc3BhY2UNCnRyb25kLm15a2xlYnVzdEBoYW1tZXJzcGFjZS5jb20NCg0KDQo=

Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3DEF29E701
	for <lists+linux-nfs@lfdr.de>; Tue, 27 Aug 2019 13:47:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726140AbfH0Lqh (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 27 Aug 2019 07:46:37 -0400
Received: from mail-eopbgr750125.outbound.protection.outlook.com ([40.107.75.125]:44519
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728763AbfH0Lqg (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Tue, 27 Aug 2019 07:46:36 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=InLT7tCSmlLZpSpzmYNgphi+LCEKyw9IV588J/bO3KYNZ2f7SwGXuD65neOSZi1r2YBS2MStsbxP2HSnEP86VqAFDNqR0lC6ahEhMdsu1/Lb0MtQ5q9DCw3TT+a4fn4iP1VoELxwQu2PtfbKiK/UrDd9rfY+O8qSP/HZ0COsRbfUqkHC3WXAQV8UgOx0OGfCEt4to/y7Wb3nTlnQ7s3UvcWrqUXCJQBrioWgQ5RnCfnnHkoNgd7W0zetcqFus0+yIH6i8ZPAhBpQd14RvhcZJQpx28HORndPrYe8o1mMgEsDseFBvW2U6rxZpj2LFuhFKdUPr9DAsmQUR9EcPq9NdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Rnt3pThtEErTU+ki7dSrQ52EIuCbVFgtDOEN95KcBlM=;
 b=U0hGuVX2lqxZ1ymk8CALWdtNO/KXyYqK5F2hL6jSlKBET2USNGMBRvNLxew0nN3LiE9tHMTaGxDIxXLQStR3hhCkI2rQk0LrCs19pgVIIIXKRwBMx5UxM9iSj7xn8IF7Qm7g0KHPMyKnr351Y+F5DMme/DD3hl4k6bVD5DqxQIS5XqGga8Iq4lzKCR/vKCZbZMD24ggQ1/lzI/89u1i7qXx0qxIOS7BFphEaMZAOBir9bc12WdECTfk/Yvf/RG5Z0Yb936P86C0tVjrGZL8wCoYR5kilNQjBZydfwp53BFHYPc++qk8xwiX9gOczhkYwwyrbfIpM8dmx7qMjx8u9sQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Rnt3pThtEErTU+ki7dSrQ52EIuCbVFgtDOEN95KcBlM=;
 b=UB/4GEkO+BJ+bxwbV7gw+Wp7Dw8B8HDI+veQSrl/abDubYyhDYEsopmx5n2plY5FfW4BYH8UcMGlZocyfkQ9uTExy6dO6cgEreVP9AD1cNJonKHqQ+EWNvIWLNLgZhMIuGW/hYV501H54mu2xgOqzq0p20PFoBxsGiKY0EwzJFw=
Received: from DM5PR13MB1851.namprd13.prod.outlook.com (10.171.159.143) by
 DM5PR13MB0988.namprd13.prod.outlook.com (10.168.238.142) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2220.15; Tue, 27 Aug 2019 11:46:33 +0000
Received: from DM5PR13MB1851.namprd13.prod.outlook.com
 ([fe80::5d60:e645:84a2:be75]) by DM5PR13MB1851.namprd13.prod.outlook.com
 ([fe80::5d60:e645:84a2:be75%7]) with mapi id 15.20.2220.013; Tue, 27 Aug 2019
 11:46:33 +0000
From:   Trond Myklebust <trondmy@hammerspace.com>
To:     "bcodding@redhat.com" <bcodding@redhat.com>
CC:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "Anna.Schumaker@netapp.com" <Anna.Schumaker@netapp.com>,
        "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>
Subject: Re: [PATCH] NFSv3: nfs_instantiate() might succeed leaving dentry
 negative unhashed
Thread-Topic: [PATCH] NFSv3: nfs_instantiate() might succeed leaving dentry
 negative unhashed
Thread-Index: AQHVXExAbdA8Vm+B30KiQwEE/S1OS6cN5DuAgADoxwCAABSIgA==
Date:   Tue, 27 Aug 2019 11:46:33 +0000
Message-ID: <720c018fc83192cdea73f8f26ca737e5ac393902.camel@hammerspace.com>
References: <d2076a27c1f3faa0d732e64d49bcbab054cae23b.1566850914.git.bcodding@redhat.com>
         <e3b9ff47b2b195796ac30e8580764ce549d3c325.camel@hammerspace.com>
         <D44A2F26-920E-427A-90E2-D800606EA748@redhat.com>
In-Reply-To: <D44A2F26-920E-427A-90E2-D800606EA748@redhat.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=trondmy@hammerspace.com; 
x-originating-ip: [68.40.189.247]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 97395505-0f04-4fe7-3431-08d72ae43574
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600166)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:DM5PR13MB0988;
x-ms-traffictypediagnostic: DM5PR13MB0988:
x-microsoft-antispam-prvs: <DM5PR13MB0988BA900F063DC7EBD1E801B8A00@DM5PR13MB0988.namprd13.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 0142F22657
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(136003)(39840400004)(376002)(366004)(346002)(189003)(199004)(25786009)(66946007)(66476007)(64756008)(305945005)(14454004)(54906003)(66446008)(118296001)(6916009)(316002)(7736002)(76176011)(229853002)(66556008)(76116006)(91956017)(99286004)(2906002)(66066001)(5660300002)(14444005)(256004)(6512007)(86362001)(2616005)(11346002)(486006)(476003)(8676002)(1730700003)(81156014)(81166006)(446003)(8936002)(36756003)(186003)(2501003)(2351001)(102836004)(6116002)(3846002)(6436002)(71190400001)(6246003)(53936002)(71200400001)(478600001)(6486002)(4326008)(26005)(53546011)(6506007)(5640700003);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR13MB0988;H:DM5PR13MB1851.namprd13.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: hammerspace.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: P+IrWmgRlCpV7GwpMUVwZMSrGrL91dtdgB7Lxe06bG66y79U7kj9F4HAPF4ctjelbKOp0Ii6JIbo+BK0A1AH8yvnwSSC6KNqETBJ+nP2GM0pWcfQEXQj0UKMhfjsR/lMpVfQ9+6ZyooY2KRaPT8tOnIKubCT85AmQE+RWhBKEldC0gmxSt9raxWEACWT7VzdWhtpRkHjshnw7p1BDPT18vcIp9hdaE5SZBy9pQwFgRphoApK99du+i9BS2wRGOytYqVMuKbTCpJi7l1ATisVs+pLQUBVRYxKSMNquCQhWFS3SD0Oyh33Y4+a8kFYi4spSchv8ggvTs2HnqMsS6rk6wp+ZpEfAVPsG3TpXeYEmWTVWvpmlBtCqjSuHY0dUV7IMGMauKPXMLy88UA7VEWVuHDZq0gRq7ffDvkONC4kFk4=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <1827048BCFAF5445B760488319CD4507@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 97395505-0f04-4fe7-3431-08d72ae43574
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Aug 2019 11:46:33.2003
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OKwGeinBiQ3breTCkAlyj8gykyqH92w8iS4Ho/+8I+FW+6I3Dg8WtCd2YHGIvFmjUQy0R9E1F8FEhpqlnoeE/A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR13MB0988
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

T24gVHVlLCAyMDE5LTA4LTI3IGF0IDA2OjMzIC0wNDAwLCBCZW5qYW1pbiBDb2RkaW5ndG9uIHdy
b3RlOg0KPiBPbiAyNiBBdWcgMjAxOSwgYXQgMTY6MzksIFRyb25kIE15a2xlYnVzdCB3cm90ZToN
Cj4gDQo+ID4gT24gTW9uLCAyMDE5LTA4LTI2IGF0IDE2OjI0IC0wNDAwLCBCZW5qYW1pbiBDb2Rk
aW5ndG9uIHdyb3RlOg0KPiA+ID4gQWZ0ZXIgYWRkaW5nIGNvbW1pdCBiMGM2MTA4ZWNmNjQgKCJu
ZnNfaW5zdGFudGlhdGUoKTogcHJldmVudA0KPiA+ID4gbXVsdGlwbGUNCj4gPiA+IGFsaWFzZXMg
Zm9yIGRpcmVjdG9yeSBpbm9kZSIpIG15IE5GUyBjbGllbnQgY3Jhc2hlcyB3aGlsZSBkb2luZw0K
PiA+ID4gbHVzdHJlIHJhY2UNCj4gPiA+IHRlc3RzIHNpbXVsdGFuZW91c2x5IG9uIGEgbG9jYWwg
ZmlsZXN5c3RlbSBhbmQgdGhlIHNhbWUNCj4gPiA+IGZpbGVzeXN0ZW0NCj4gPiA+IGV4cG9ydGVk
DQo+ID4gPiB2aWEga25mc2Q6DQo+ID4gPiANCj4gPiA+ICAgICBCVUc6IHVuYWJsZSB0byBoYW5k
bGUga2VybmVsIE5VTEwgcG9pbnRlciBkZXJlZmVyZW5jZSBhdA0KPiA+ID4gMDAwMDAwMDAwMDAw
MDAyOA0KPiA+ID4gICAgICBDYWxsIFRyYWNlOg0KPiA+ID4gICAgICAgPyBpcHV0KzB4NzYvMHgy
MDANCj4gPiA+ICAgICAgID8gZF9zcGxpY2VfYWxpYXMrMHgzMDcvMHgzYzANCj4gPiA+ICAgICAg
ID8gZHB1dC5wYXJ0LjMxKzB4OTYvMHgxMTANCj4gPiA+ICAgICAgID8gbmZzX2luc3RhbnRpYXRl
KzB4NDUvMHgxNjAgW25mc10NCj4gPiA+ICAgICAgIG5mczNfcHJvY19zZXRhY2xzKzB4YS8weDIw
IFtuZnN2M10NCj4gPiA+ICAgICAgIG5mczNfcHJvY19jcmVhdGUrMHgxY2MvMHgyMzAgW25mc3Yz
XQ0KPiA+ID4gICAgICAgbmZzX2NyZWF0ZSsweDgzLzB4MTYwIFtuZnNdDQo+ID4gPiAgICAgICBw
YXRoX29wZW5hdCsweDExYWEvMHgxNGQwDQo+ID4gPiAgICAgICBkb19maWxwX29wZW4rMHg5My8w
eDEwMA0KPiA+ID4gICAgICAgPyBfX2NoZWNrX29iamVjdF9zaXplKzB4YTMvMHgxODENCj4gPiA+
ICAgICAgIGRvX3N5c19vcGVuKzB4MTg0LzB4MjIwDQo+ID4gPiAgICAgICBkb19zeXNjYWxsXzY0
KzB4NWIvMHgxYjANCj4gPiA+ICAgICAgIGVudHJ5X1NZU0NBTExfNjRfYWZ0ZXJfaHdmcmFtZSsw
eDY1LzB4Y2ENCj4gPiA+IA0KPiA+ID4gICAgMTU4IHN0YXRpYyBpbnQgX19uZnMzX3Byb2Nfc2V0
YWNscyhzdHJ1Y3QgaW5vZGUgKmlub2RlLCBzdHJ1Y3QNCj4gPiA+IHBvc2l4X2FjbCAqYWNsLA0K
PiA+ID4gICAgMTU5ICAgICAgICAgc3RydWN0IHBvc2l4X2FjbCAqZGZhY2wpDQo+ID4gPiAgICAx
NjAgew0KPiA+ID4gPiA+IDE2MSAgICAgc3RydWN0IG5mc19zZXJ2ZXIgKnNlcnZlciA9IE5GU19T
RVJWRVIoaW5vZGUpOw0KPiA+ID4gDQo+ID4gPiBUaGUgMHgyOCBvZmZzZXQgaXMgaV9zYiBpbiBz
dHJ1Y3QgaW5vZGUsIHdlIHBhc3NlZCBhIE5VTEwgaW5vZGUNCj4gPiA+IHRvDQo+ID4gPiBuZnMz
X3Byb2Nfc2V0YWNscygpLg0KPiA+ID4gDQo+ID4gPiBBZnRlciB0YWtpbmcgdGhpcyBhcGFydCwg
SSBmaW5kIHRoZSBkZW50cnkgaW4gUjEyIGhhcyBhIE5VTEwNCj4gPiA+IGlub2RlDQo+ID4gPiBh
ZnRlcg0KPiA+ID4gbmZzX2luc3RhbnRpYXRlKCksIHdoaWNoIG1ha2VzIHNlbnNlIGlmIHdlIG1v
dmUgaXQgdG8gdGhlIGFsaWFzDQo+ID4gPiBqdXN0DQo+ID4gPiBhZnRlcg0KPiA+ID4gbmZzX2Zo
Z2V0KCkgKFNlZSB0aGUgcmVmZXJlbmNlZCBjb21taXQgYWJvdmUpLiAgSW5kZWVkLCBvbiB0aGUN
Cj4gPiA+IGxpc3QNCj4gPiA+IG9mDQo+ID4gPiBjaGlsZHJlbiBpcyB0aGUgaWRlbnRpY2FsIHBv
c2l0aXZlIGRlbnRyeSB0aGF0IGlzIGxlZnQgYmVoaW5kDQo+ID4gPiBhZnRlcg0KPiA+ID4gZF9z
cGxpY2VfYWxpYXMoKS4gIE1vdmluZyBpdCB3b3VsZCB1c3VhbHkgYmUgZmluZSBmb3IgY2FsbGVy
cywNCj4gPiA+IGV4Y2VwdA0KPiA+ID4gZm9yDQo+ID4gPiBORlN2MyBiZWNhdXNlIHdlIHdhbnQg
dGhlIGlub2RlIHBvaW50ZXIgdG8gcmlkZSB0aGUgZGVudHJ5IGJhY2sNCj4gPiA+IHVwDQo+ID4g
PiB0aGUNCj4gPiA+IHN0YWNrIHNvIHdlIGNhbiBzZXQgQUNMcyBvbiBpdCBhbmQvb3Igc2V0IGF0
dHJpYnV0ZXMgaW4gdGhlIGNhc2UNCj4gPiA+IG9mDQo+ID4gPiBFWENMVVNJVkUuDQo+ID4gPiAN
Cj4gPiA+IEEgc2ltaWxhciBwcm9ibGVtIGV4aXN0ZWQgaW4gbmZzZF9jcmVhdGVfbG9ja2VkKCks
IGFuZCB3YXMgZml4ZWQNCj4gPiA+IGJ5DQo+ID4gPiBjb21taXQNCj4gPiA+IDM4MTliYjBkNzlm
NSAoIm5mc2Q6IHZmc19ta2RpcigpIG1pZ2h0IHN1Y2NlZWQgbGVhdmluZyBkZW50cnkNCj4gPiA+
IG5lZ2F0aXZlDQo+ID4gPiB1bmhhc2hlZCIpLiAgVGhpcyBwYXRjaCB0YWtlcyB0aGUgc2FtZSBh
cHByb2FjaCB0byBmaXhpbmcgdGhlDQo+ID4gPiBwcm9ibGVtOiBpbg0KPiA+ID4gdGhlIHJhcmUg
Y2FzZSB0aGF0IHdlIGxvc3QgdGhlIHJhY2UgdG8gdGhlIGRlbnRyeSwgbG9vayBpdCB1cCBhbmQN
Cj4gPiA+IGdldA0KPiA+ID4gdGhlDQo+ID4gPiBpbm9kZSBmcm9tIHRoZXJlLg0KPiA+ID4gDQo+
ID4gPiBTaWduZWQtb2ZmLWJ5OiBCZW5qYW1pbiBDb2RkaW5ndG9uIDxiY29kZGluZ0ByZWRoYXQu
Y29tPg0KPiA+ID4gRml4ZXM6IGIwYzYxMDhlY2Y2NCAoIm5mc19pbnN0YW50aWF0ZSgpOiBwcmV2
ZW50IG11bHRpcGxlIGFsaWFzZXMNCj4gPiA+IGZvcg0KPiA+ID4gZGlyZWN0b3J5IGlub2RlIikN
Cj4gPiA+IENjOiBBbCBWaXJvIDx2aXJvQHplbml2LmxpbnV4Lm9yZy51az4NCj4gPiA+IC0tLQ0K
PiA+ID4gIGZzL25mcy9uZnMzcHJvYy5jIHwgMjIgKysrKysrKysrKysrKysrKysrKysrLQ0KPiA+
ID4gIDEgZmlsZSBjaGFuZ2VkLCAyMSBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0pDQo+ID4g
PiANCj4gPiA+IGRpZmYgLS1naXQgYS9mcy9uZnMvbmZzM3Byb2MuYyBiL2ZzL25mcy9uZnMzcHJv
Yy5jDQo+ID4gPiBpbmRleCBhM2FkMmQ0NmZkNDIuLjI5MmM1M2MwODJmNyAxMDA2NDQNCj4gPiA+
IC0tLSBhL2ZzL25mcy9uZnMzcHJvYy5jDQo+ID4gPiArKysgYi9mcy9uZnMvbmZzM3Byb2MuYw0K
PiA+ID4gQEAgLTIwLDYgKzIwLDcgQEANCj4gPiA+ICAjaW5jbHVkZSA8bGludXgvbmZzX21vdW50
Lmg+DQo+ID4gPiAgI2luY2x1ZGUgPGxpbnV4L2ZyZWV6ZXIuaD4NCj4gPiA+ICAjaW5jbHVkZSA8
bGludXgveGF0dHIuaD4NCj4gPiA+ICsjaW5jbHVkZSA8bGludXgvbmFtZWkuaD4NCj4gPiA+IA0K
PiA+ID4gICNpbmNsdWRlICJpb3N0YXQuaCINCj4gPiA+ICAjaW5jbHVkZSAiaW50ZXJuYWwuaCIN
Cj4gPiA+IEBAIC0zMDUsNiArMzA2LDcgQEAgbmZzM19wcm9jX2NyZWF0ZShzdHJ1Y3QgaW5vZGUg
KmRpciwgc3RydWN0DQo+ID4gPiBkZW50cnkNCj4gPiA+ICpkZW50cnksIHN0cnVjdCBpYXR0ciAq
c2F0dHIsDQo+ID4gPiAgCXN0cnVjdCBwb3NpeF9hY2wgKmRlZmF1bHRfYWNsLCAqYWNsOw0KPiA+
ID4gIAlzdHJ1Y3QgbmZzM19jcmVhdGVkYXRhICpkYXRhOw0KPiA+ID4gIAlpbnQgc3RhdHVzID0g
LUVOT01FTTsNCj4gPiA+ICsJc3RydWN0IGRlbnRyeSAqZCA9IE5VTEw7DQo+ID4gPiANCj4gPiA+
ICAJZHByaW50aygiTkZTIGNhbGwgIGNyZWF0ZSAlcGRcbiIsIGRlbnRyeSk7DQo+ID4gPiANCj4g
PiA+IEBAIC0zNTUsNiArMzU3LDIyIEBAIG5mczNfcHJvY19jcmVhdGUoc3RydWN0IGlub2RlICpk
aXIsIHN0cnVjdA0KPiA+ID4gZGVudHJ5ICpkZW50cnksIHN0cnVjdCBpYXR0ciAqc2F0dHIsDQo+
ID4gPiAgCWlmIChzdGF0dXMgIT0gMCkNCj4gPiA+ICAJCWdvdG8gb3V0X3JlbGVhc2VfYWNsczsN
Cj4gPiA+IA0KPiA+ID4gKwkvKiBQb3NzaWJsZSB0aGF0IG5mc19pbnN0YW50aWF0ZSgpIGxvc3Qg
YSByYWNlIHRvIG9wZW4tYnktDQo+ID4gPiBmaGFuZGxlLA0KPiA+ID4gKwkgKiBpbiB3aGljaCBj
YXNlIHdlIGRvbid0IGhhdmUgYSByZWZlcmVuY2UgdG8gdGhlIGRlbnRyeSAqLw0KPiA+ID4gKwlp
ZiAodW5saWtlbHkoZF91bmhhc2hlZChkZW50cnkpKSkgew0KPiA+ID4gKwkJZCA9IGxvb2t1cF9v
bmVfbGVuKGRlbnRyeS0+ZF9uYW1lLm5hbWUsIGRlbnRyeS0NCj4gPiA+ID4gZF9wYXJlbnQsDQo+
ID4gPiArCQkJCQkJCWRlbnRyeS0NCj4gPiA+ID4gZF9uYW1lLmxlbik7DQo+ID4gPiArCQlpZiAo
SVNfRVJSKGQpKSB7DQo+ID4gPiArCQkJc3RhdHVzID0gUFRSX0VSUihkKTsNCj4gPiA+ICsJCQln
b3RvIG91dF9yZWxlYXNlX2FjbHM7DQo+ID4gPiArCQl9DQo+ID4gPiArCQlpZiAodW5saWtlbHko
ZF9pc19uZWdhdGl2ZShkKSkpIHsNCj4gPiA+ICsJCQlzdGF0dXMgPSAtRU5PRU5UOw0KPiA+ID4g
KwkJCWdvdG8gb3V0X3B1dF9kOw0KPiA+ID4gKwkJfQ0KPiA+ID4gKwkJZGVudHJ5ID0gZDsNCj4g
PiA+ICsJfQ0KPiA+ID4gKw0KPiA+IA0KPiA+IElmIHRoaXMgaXMgYSBjb25zZXF1ZW5jZSBvZiBh
IHJhY2UgaW4gbmZzX2luc3RhbnRpYXRlLCB0aGVuIHdoeSBhcmUNCj4gPiB3ZQ0KPiA+IG5vdCBm
aXggaXQgdGhlcmU/IFdvbid0IHdlIG90aGVyd2lzZSBlbmQgdXAgaGF2aW5nIHRvIGR1cGxpY2F0
ZSB0aGUNCj4gPiBhYm92ZSBjb2RlIGluIGFsbCB0aGUgb3RoZXIgY2FsbGVycz8NCj4gPiANCj4g
PiBJT1c6IHdoeSBub3Qgc2ltcGx5IG1vZGlmeSBuZnNfaW5zdGFudGlhdGUoKSB0byByZXR1cm4g
dGhlIGRlbnRyeQ0KPiA+IGZyb20NCj4gPiBkX3NwbGljZV9hbGlhcygpLCBtdWNoIGxpa2Ugd2Ug
YWxyZWFkeSBkbyBmb3IgbmZzX2xvb2t1cCgpPw0KPiANCj4gTm9uZSBvZiB0aGUgb3RoZXIgY2Fs
bGVycyBjYXJlIGFib3V0IHRoZSBkZW50cnkgYW5kIGl0IHNlZW1lZCBtb3JlDQo+IGludmFzaXZl
Lg0KPiBJdCBpcyBhbHNvIGFuIGFjY2VwdGVkIHBhdHRlcm4gZm9yIFZGUyAtIHRoYXQncyB3aHkg
QWwganVzdGlmaWVkIGl0DQo+IGluDQo+IGIwYzYxMDhlY2Y2NC4NCg0KSXQgaXMgcmFjeSwgdGhv
dWdoLiBOb3RoaW5nIGd1YXJhbnRlZXMgdGhhdCBhIGRlbnRyeSBmb3IgdGhhdCBmaWxlIGlzDQpz
dGlsbCBoYXNoZWQgdW5kZXIgdGhlIHNhbWUgbmFtZSB3aGVuIHlvdSBsb29rIGl0IHVwIGFnYWlu
LCBzbyBpdCBpcw0KYmV0dGVyIHRvIHBhc3MgaXQgYmFjayBkaXJlY3RseSBmcm9tIHRoZSBkX3Nw
bGljZV9hbGlhcygpIGNhbGwuDQoNCj4gSWYgeW91J2QgcmF0aGVyIGNoYW5nZSBhbGwgdGhlIGNh
bGxlcnMsIGxldCBtZSBrbm93IGFuZCBJIGNhbiBzZW5kDQo+IHRoYXQuDQoNCklmIHlvdSdkIHBy
ZWZlciBub3QgdG8gaGF2ZSB0byBjaGFuZ2UgYWxsIHRoZSBjYWxsZXJzLCB0aGVuIHBlcmhhcHMN
CnNwbGl0IHRoZSBmdW5jdGlvbiBpbnRvIHR3byBwYXJ0czoNCi0gVGhlIGlubmVyIHBhcnQgdGhh
dCByZXR1cm5zIHRoZSBkZW50cnkgZnJvbSBkX3NwbGljZV9hbGlhcygpIG9uDQpzdWNjZXNzLCBh
bmQgd2hpY2ggY2FuIGJlIGNhbGxlZCBkaXJlY3RseSBmcm9tIG5mczNfZG9fY3JlYXRlKCkuDQot
IFRoZW4gYSB3cmFwcGVyIHRoYXQgd29ya3MgbGlrZSBuZnNfaW5zdGFudGlhdGUoKSBieSBkcHV0
KClpbmcgdGhlDQp2YWxpZCBkZW50cnkgKGFuZCByZXR1cm5pbmcgMCkgb3Igb3RoZXJ3aXNlIGNv
bnZlcnRpbmcgdGhlIEVSUl9QVFIoKQ0KYW5kIHJldHVybmluZyB0aGF0Lg0KDQotLSANClRyb25k
IE15a2xlYnVzdA0KTGludXggTkZTIGNsaWVudCBtYWludGFpbmVyLCBIYW1tZXJzcGFjZQ0KdHJv
bmQubXlrbGVidXN0QGhhbW1lcnNwYWNlLmNvbQ0KDQoNCg==

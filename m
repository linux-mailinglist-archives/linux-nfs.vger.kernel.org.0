Return-Path: <linux-nfs+bounces-2979-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 22ABB8B0372
	for <lists+linux-nfs@lfdr.de>; Wed, 24 Apr 2024 09:47:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4601C1C237FB
	for <lists+linux-nfs@lfdr.de>; Wed, 24 Apr 2024 07:47:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B3641581FB;
	Wed, 24 Apr 2024 07:47:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b="2sa9ksyO"
X-Original-To: linux-nfs@vger.kernel.org
Received: from gate2.alliedtelesis.co.nz (gate2.alliedtelesis.co.nz [202.36.163.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5579C1581F5
	for <linux-nfs@vger.kernel.org>; Wed, 24 Apr 2024 07:47:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.36.163.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713944873; cv=none; b=XED6DO+Zafx0rEHJf//5aqf/g8QoA1Kz71vqJsUhzk52C0NMaIAGfKY/eYTKoeaekKikJxURKc0R4Lhsd5ymB+czFuoPTkYqfAlbhhqimNvvWKJmA3XGaPx0DalqD9peOiqOR/Pme7CqA75shhwJgTroTKMowmizJCZGV2glqI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713944873; c=relaxed/simple;
	bh=aUlotTrNxrU0Ywmg7hPsLhO9C9H01/l5aIJwvotLHtg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=jvZyMxGYU3glVxhlIQoc2y387QWBMWmImKX05tPK/k3ceWOUbbFsop417R8jJmzdJYnu950ug/4G1oOc7N0KsJGLDpOyShuS+RvE4TJubevoc/nXBDu8GTeosqIL+36nW4YGl+fhlUq1JKLg4MfJ5LjfEiRohqZUnmsRPXtjle4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=alliedtelesis.co.nz; spf=pass smtp.mailfrom=alliedtelesis.co.nz; dkim=pass (2048-bit key) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b=2sa9ksyO; arc=none smtp.client-ip=202.36.163.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=alliedtelesis.co.nz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alliedtelesis.co.nz
Received: from svr-chch-seg1.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id CA43A2C02A8;
	Wed, 24 Apr 2024 19:42:17 +1200 (NZST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
	s=mail181024; t=1713944537;
	bh=aUlotTrNxrU0Ywmg7hPsLhO9C9H01/l5aIJwvotLHtg=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:From;
	b=2sa9ksyOrBHVmvPI5YsJqxP+dPEBhWFw60RnOS1Z1D4GaK+fgq06JC9fUwUt5Hjd3
	 lZo1rbavIp8BbauJ5Rv4DBoif3uVjfezR9M0YnkiD2dZu+Gs19Z9eSZ3YyLTbVjG0G
	 Qu/l/Iqr9lBESgbMfNMdFUGdcpwuUEhB9qprEfOiQJ6m3YGBk4k/iTKavWd07uS2xJ
	 QQ1ZqHGaxsKcubouvlSK0kmGjBwxSYhS17Yqrci8P9T7BSwuEP/y/uebmoWUY4mBbx
	 Fbr1H72uO8jPnf5WUzfziLBbnsTZc15nM2hIFE6e73cNxEkwG/a28429NfT1zOOWq0
	 z5TxbJXw5fcBA==
Received: from svr-chch-ex2.atlnz.lc (Not Verified[2001:df5:b000:bc8::76]) by svr-chch-seg1.atlnz.lc with Trustwave SEG (v8,2,6,11305)
	id <B6628b7d90001>; Wed, 24 Apr 2024 19:42:17 +1200
Received: from svr-chch-ex2.atlnz.lc (2001:df5:b000:bc8::76) by
 svr-chch-ex2.atlnz.lc (2001:df5:b000:bc8::76) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Wed, 24 Apr 2024 19:42:17 +1200
Received: from svr-chch-ex2.atlnz.lc ([fe80::a9eb:c9b7:8b52:9567]) by
 svr-chch-ex2.atlnz.lc ([fe80::a9eb:c9b7:8b52:9567%15]) with mapi id
 15.02.1544.009; Wed, 24 Apr 2024 19:42:17 +1200
From: Chris Packham <Chris.Packham@alliedtelesis.co.nz>
To: Jeff Layton <jlayton@kernel.org>, Chuck Lever <chuck.lever@oracle.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "neilb@suse.de"
	<neilb@suse.de>
CC: "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>, netdev
	<netdev@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "stable@vger.kernel.org"
	<stable@vger.kernel.org>
Subject: Re: kernel BUG at net/sunrpc/svc.c:570 after updating from v5.15.153
 to v5.15.155
Thread-Topic: kernel BUG at net/sunrpc/svc.c:570 after updating from v5.15.153
 to v5.15.155
Thread-Index: AQHaleHzc3oveYbGkkq3WWVD/cih7bF12zkAgABlswA=
Date: Wed, 24 Apr 2024 07:42:17 +0000
Message-ID: <06de0002-c3c6-4f13-9618-066cb9658240@alliedtelesis.co.nz>
References: <b363e394-7549-4b9e-b71b-d97cd13f9607@alliedtelesis.co.nz>
 <0d2c2123-e782-4712-8876-c9b65d2c9a65@alliedtelesis.co.nz>
In-Reply-To: <0d2c2123-e782-4712-8876-c9b65d2c9a65@alliedtelesis.co.nz>
Accept-Language: en-NZ, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
Content-Type: text/plain; charset="utf-8"
Content-ID: <AFA88EA46A28404EBD871B9D3DFC4262@atlnz.lc>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-SEG-SpamProfiler-Analysis: v=2.4 cv=dY4j3mXe c=1 sm=1 tr=0 ts=6628b7d9 a=Xf/6aR1Nyvzi7BryhOrcLQ==:117 a=xqWC_Br6kY4A:10 a=oKJsc7D3gJEA:10 a=IkcTkHD0fZMA:10 a=raytVjVEu-sA:10 a=Oxyqa-lKnlMAWl67uNQA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-SEG-SpamProfiler-Score: 0

DQpPbiAyNC8wNC8yNCAxMzozOCwgQ2hyaXMgUGFja2hhbSB3cm90ZToNCj4NCj4gT24gMjQvMDQv
MjQgMTI6NTQsIENocmlzIFBhY2toYW0gd3JvdGU6DQo+PiBIaSBKZWZmLCBDaHVjaywgR3JlZywN
Cj4+DQo+PiBBZnRlciB1cGRhdGluZyBvbmUgb2Ygb3VyIGJ1aWxkcyBhbG9uZyB0aGUgNS4xNS55
IExUUyBicmFuY2ggb3VyIA0KPj4gdGVzdGluZyBjYXVnaHQgYSBuZXcga2VybmVsIGJ1Zy4gT3V0
cHV0IGJlbG93Lg0KPj4NCj4+IEkgaGF2ZW4ndCBkdWcgaW50byBpdCB5ZXQgYnV0IHdvbmRlcmVk
IGlmIGl0IHJhbmcgYW55IGJlbGxzLg0KPg0KPiBBIGJpdCBtb3JlIGluZm8uIFRoaXMgaXMgaGFw
cGVuaW5nIGF0ICJyZWJvb3QiIGZvciB1cy4gT3VyIGVtYmVkZGVkIA0KPiBkZXZpY2VzIHVzZSBh
IGJpdCBvZiBhIGhhY2tlZCB1cCByZWJvb3QgcHJvY2VzcyBzbyB0aGF0IHRoZXkgY29tZSBiYWNr
IA0KPiBmYXN0ZXIgaW4gdGhlIGNhc2Ugb2YgYSBmYWlsdXJlLg0KPg0KPiBJdCBkb2Vzbid0IGhh
cHBlbiB3aXRoIGEgcHJvcGVyIGBzeXN0ZW1jdGwgcmVib290YCBvciB3aXRoIGEgU1lTUlErQg0K
Pg0KPiBJIGNhbiB0cmlnZ2VyIGl0IHdpdGggYGtpbGxhbGwgLTkgbmZzZGAgd2hpY2ggSSdtIG5v
dCBzdXJlIGlzIGEgDQo+IGNvbXBsZXRlbHkgbGVnaXQgdGhpbmcgdG8gZG8gdG8ga2VybmVsIHRo
cmVhZHMgYnV0IGl0J3MgcHJvYmFibHkgY2xvc2UgDQo+IHRvIHdoYXQgb3VyIGN1c3RvbWl6ZWQg
cmVib290IGRvZXMuDQoNCkkndmUgYmlzZWN0ZWQgYmV0d2VlbiB2NS4xNS4xNTMgYW5kIHY1LjE1
LjE1NSBhbmQgaWRlbnRpZmllZCBjb21taXQgDQpkZWM2YjhiY2FjNzMgKCJuZnNkOiBTaW1wbGlm
eSBjb2RlIGFyb3VuZCBzdmNfZXhpdF90aHJlYWQoKSBjYWxsIGluIA0KbmZzZCgpIikgYXMgdGhl
IGZpcnN0IGJhZCBjb21taXQuIEJhc2VkIG9uIHRoZSBjb250ZXh0IHRoYXQgc2VlbXMgdG8gDQps
aW5lIHVwIHdpdGggbXkgcmVwcm9kdWN0aW9uLiBJJ20gd29uZGVyaW5nIGlmIHBlcmhhcHMgc29t
ZXRoaW5nIGdvdCANCm1pc3NlZCBvdXQgb2YgdGhlIHN0YWJsZSB0cmFjaz8gVW5mb3J0dW5hdGVs
eSBJJ20gbm90IGFibGUgdG8gcnVuIGEgbW9yZSANCnJlY2VudCBrZXJuZWwgd2l0aCBhbGwgb2Yg
dGhlIG5mcyByZWxhdGVkIHNldHVwIHRoYXQgaXMgYmVpbmcgdXNlZCBvbsKgIA0KdGhlIHN5c3Rl
bSBpbiBxdWVzdGlvbi4NCg0KPg0KPj4NCj4+IFRoYW5rcywNCj4+IENocmlzDQo+Pg0KPj4gW8Kg
wqAgOTEuNjA1MTA5XSAtLS0tLS0tLS0tLS1bIGN1dCBoZXJlIF0tLS0tLS0tLS0tLS0NCj4+IFvC
oMKgIDkxLjYwNTEyMl0ga2VybmVsIEJVRyBhdCBuZXQvc3VucnBjL3N2Yy5jOjU3MCENCj4+IFvC
oMKgIDkxLjYwNTEyOV0gSW50ZXJuYWwgZXJyb3I6IE9vcHMgLSBCVUc6IDAwMDAwMDAwZjIwMDA4
MDAgWyMxXSANCj4+IFBSRUVNUFQgU01QDQo+PiBbwqDCoCA5MS42MTA2NDNdIE1vZHVsZXMgbGlu
a2VkIGluOiBtdmNwc3MoTykgcGxhdGZvcm1fZHJpdmVyKE8pIA0KPj4gaXBpZndkKE8pIHh0X2wy
dHAgeHRfaGFzaGxpbWl0IHh0X2Nvbm50cmFjayB4dF9hZGRydHlwZSB4dF9MT0cgDQo+PiB4dF9D
SEVDS1NVTSB3cDUxMiB2eGxhbiB2ZXRoIHR3b2Zpc2hfZ2VuZXJpYyB0d29maXNoX2NvbW1vbiBz
cjk4MDAgDQo+PiBzbXNjOTV4eCBzbXNjNzV4eCBzbXNjIHNtM19nZW5lcmljIHNoYTUxMl9hcm02
NCBzaGEzX2dlbmVyaWMgDQo+PiBzZXJwZW50X2dlbmVyaWMgcnRsODE1MCBycGNzZWNfZ3NzX2ty
YjUgcm1kMTYwIHBvbHkxMzA1X2dlbmVyaWMgcGx1c2IgDQo+PiBwZWdhc3VzIG9wdGVlX3JuZyBu
YmQgbWljcm9jaGlwIG1kNCBtZF9tb2QgbWNzNzgzMCBscncgbGlicG9seTEzMDUgDQo+PiBsYW43
OHh4IGwydHBfaXA2IGwydHBfaXAgbDJ0cF9ldGggbDJ0cF9uZXRsaW5rIGwydHBfY29yZSB1ZHBf
dHVubmVsIA0KPj4gaXB0X1JFSkVDVCBuZl9yZWplY3RfaXB2NCBpcDZ0YWJsZV9uYXQgaXA2dGFi
bGVfbWFuZ2xlIA0KPj4gaXA2dGFibGVfZmlsdGVyIGlwNnRfaXB2NmhlYWRlciBpcDZ0X1JFSkVD
VCBpcDZfdWRwX3R1bm5lbCBpcDZfdGFibGVzIA0KPj4gZG05NjAxIGRtX3plcm8gZG1fbWlycm9y
IGRtX3JlZ2lvbl9oYXNoIGRtX2xvZyBkbV9tb2QgZGlhZyB0aXBjIGN1c2UgDQo+PiBjdHMgY3B1
ZnJlcV9wb3dlcnNhdmUgY3B1ZnJlcV9jb25zZXJ2YXRpdmUgY2hhY2hhX2dlbmVyaWMgDQo+PiBj
aGFjaGEyMHBvbHkxMzA1IGNoYWNoYV9uZW9uIGxpYmNoYWNoYSBjYXN0Nl9nZW5lcmljIGNhc3Q1
X2dlbmVyaWMgDQo+PiBjYXN0X2NvbW1vbiBjYW1lbGxpYV9nZW5lcmljIGJsb3dmaXNoX2dlbmVy
aWMgYmxvd2Zpc2hfY29tbW9uIA0KPj4gYXV0aF9ycGNnc3Mgb2lkX3JlZ2lzdHJ5IGF0MjUgYXJt
X3NtY2NjX3RybmcgYWVzX25lb25fYmxrIA0KPj4gaWRwcm9tX210ZChPKSBpZHByb21faTJjKE8p
IGVwaTNfYm9hcmRpbmZvX2kyYyhPKSB4MjUwKE8pIA0KPj4gcHN1c2xvdF9lcGkzX3JlZ2lzdGVy
KE8pIHBzdXNsb3RfZ3Bpb19ncm91cChPKQ0KPj4gW8KgwqAgOTEuNjEwODA5XcKgIHBzdXNsb3Qo
TykNCj4+IFvCoMKgIDkxLjYxMTgyMl0gd2F0Y2hkb2c6IHdhdGNoZG9nMTogd2F0Y2hkb2cgZGlk
IG5vdCBzdG9wIQ0KPj4gW8KgwqAgOTEuNjk3MDY1XcKgIGdwaW9waW5zX2JvYXJkaW5mbyhPKSBp
ZHByb20oTykgZXBpM19ib2FyZGluZm8oTykgDQo+PiBib2FyZGluZm8oTykgaTJjX2dwaW8gaTJj
X2FsZ29fYml0IGkyY19tdjY0eHh4IHBsdWdnYWJsZShPKSANCj4+IGxlZF9lbmFibGUoTykgb21h
cF9ybmcgcm5nX2NvcmUgYXRsX3Jlc2V0KE8pIHNic2FfZ3dkdCB1aW9fcGRydl9nZW5pcnENCj4+
IFvCoMKgIDkxLjY5NzA5Nl0gQ1BVOiAyIFBJRDogMTc3MCBDb21tOiBuZnNkIEtkdW1wOiBsb2Fk
ZWQgVGFpbnRlZDogDQo+PiBHwqDCoMKgwqDCoMKgwqDCoMKgwqAgT8KgwqDCoMKgwqAgNS4xNS4x
NTUgIzENCj4+IFvCoMKgIDkxLjY5NzEwM10gSGFyZHdhcmUgbmFtZTogQWxsaWVkIFRlbGVzaXMg
eDI1MC0yOFhUbSAoRFQpDQo+PiBbwqDCoCA5MS42OTcxMDddIHBzdGF0ZTogODAwMDAwMDUgKE56
Y3YgZGFpZiAtUEFOIC1VQU8gLVRDTyAtRElUIC1TU0JTIA0KPj4gQlRZUEU9LS0pDQo+PiBbwqDC
oCA5MS42OTcxMTJdIHBjIDogc3ZjX2Rlc3Ryb3krMHg4NC8weGFjDQo+PiBbwqDCoCA5MS43MDEy
MDJdIHdhdGNoZG9nOiB3YXRjaGRvZzA6IHdhdGNoZG9nIGRpZCBub3Qgc3RvcCENCj4+IFvCoMKg
IDkxLjcwMjIxNV0gbHIgOiBzdmNfZGVzdHJveSsweDJjLzB4YWMNCj4+IFvCoMKgIDkxLjcwMjIy
MF0gc3AgOiBmZmZmODAwMDBiYjNiZGUwDQo+PiBbwqDCoCA5MS43MDIyMjNdIHgyOTogZmZmZjgw
MDAwYmIzYmRlMCB4Mjg6IDAwMDAwMDAwMDAwMDAwMDAgeDI3OiANCj4+IDAwMDAwMDAwMDAwMDAw
MDANCj4+IFvCoMKgIDkxLjc0NjA5NV0geDI2OiAwMDAwMDAwMDAwMDAwMDAwIHgyNTogZmZmZjAw
MDAwZGJmYWE0MCB4MjQ6IA0KPj4gZmZmZjAwMDAxNmMxNDAwMA0KPj4gW8KgwqAgOTEuNzQ2MTAx
XSB4MjM6IGZmZmY4MDAwMDgzOTVjMDAgeDIyOiBmZmZmMDAwMDBlZTlmMjg0IHgyMTogDQo+PiBm
ZmZmMDAwMDBlZWE5ZTEwDQo+PiBbwqDCoCA5MS43NDYxMDhdIHgyMDogZmZmZjAwMDAwZWVhOWUw
MCB4MTk6IGZmZmYwMDAwMGVlYTllMTQgeDE4OiANCj4+IGZmZmY4MDAwMDhlOTkwMDANCj4+IFvC
oMKgIDkxLjc2OTUyNl0geDE3OiAwMDAwMDAwMDAwMDAwMDA2IHgxNjogMDAwMDAwMDAwMDAwMDAw
MCB4MTU6IA0KPj4gMDAwMDAwMDAwMDAwMDAwMQ0KPj4gW8KgwqAgOTEuNzc2NzgyXSB4MTQ6IDAw
MDAwMDAwZmZmZmZmZmQgeDEzOiBmZmZmZmMwMDAwMDAwMDAwIHgxMjogDQo+PiBmZmZmODAwMDc2
YmMyMDAwDQo+PiBbwqDCoCA5MS43ODQwMzFdIHgxMTogZmZmZjAwMDA3ZmJhNWMxMCB4MTA6IGZm
ZmY4MDAwNzZiYzIwMDAgeDkgOiANCj4+IGZmZmY4MDAwMDkyMjA3YzANCj4+IFvCoMKgIDkxLjc4
NDAzOF0geDggOiBmZmZmZmMwMDAwNTVlYjA4IHg3IDogZmZmZjAwMDAwZWY2YzRjMCB4NiA6IA0K
Pj4gZmZmZmZjMDAwMWY4NzJjOA0KPj4gW8KgwqAgOTEuNzk1ODIzXSB4NSA6IDAwMDAwMDAwMDAw
MDAxMDAgeDQgOiBmZmZmMDAwMDdmYmFlZGE4IHgzIDogDQo+PiAwMDAwMDAwMDAwMDAwMDAwDQo+
PiBbwqDCoCA5MS44MDE2ODRdIHgyIDogMDAwMDAwMDAwMDAwMDAwMCB4MSA6IGZmZmYwMDAwMGQ4
ZjgwMTggeDAgOiANCj4+IGZmZmYwMDAwMGVlYTllMzANCj4+IFvCoMKgIDkxLjgwNzU0NV0gQ2Fs
bCB0cmFjZToNCj4+IFvCoMKgIDkxLjgxMDA4OF3CoCBzdmNfZGVzdHJveSsweDg0LzB4YWMNCj4+
IFvCoMKgIDkxLjgxMzU4Nl3CoCBzdmNfZXhpdF90aHJlYWQrMHgxMDgvMHgxNWMNCj4+IFvCoMKg
IDkxLjgxNjk5OF3CoCBuZnNkKzB4MTc4LzB4MWEwDQo+PiBbwqDCoCA5MS44MTg2NzNdwqAga3Ro
cmVhZCsweDE1MC8weDE2MA0KPj4gW8KgwqAgOTEuODIwNjEwXcKgIHJldF9mcm9tX2ZvcmsrMHgx
MC8weDIwDQo+PiBbwqDCoCA5MS44MjA2MjBdIENvZGU6IGE5NDE1M2YzIGE4YzI3YmZkIGQ1MDMy
M2JmIGQ2NWYwM2MwIChkNDIxMDAwMCkNCj4+IFvCoMKgIDkxLjgyMDYyOV0gU01QOiBzdG9wcGlu
ZyBzZWNvbmRhcnkgQ1BVcw0KPj4gW8KgwqAgOTEuODMwNDMzXSBTdGFydGluZyBjcmFzaGR1bXAg
a2VybmVsLi4uDQo+PiBbwqDCoCA5MS44MzMwNjRdIEJ5ZSE=


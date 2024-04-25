Return-Path: <linux-nfs+bounces-3010-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A14B88B2A25
	for <lists+linux-nfs@lfdr.de>; Thu, 25 Apr 2024 22:51:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B572DB219D9
	for <lists+linux-nfs@lfdr.de>; Thu, 25 Apr 2024 20:51:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADEC339ADD;
	Thu, 25 Apr 2024 20:51:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b="W41FFbrH"
X-Original-To: linux-nfs@vger.kernel.org
Received: from gate2.alliedtelesis.co.nz (gate2.alliedtelesis.co.nz [202.36.163.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A278153814
	for <linux-nfs@vger.kernel.org>; Thu, 25 Apr 2024 20:51:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.36.163.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714078280; cv=none; b=PaiUE+3A1aDBHzgbVy6N8Jpf7smti5SU196WhxClTWKSJZELVaVJlNvlDdL7Z1bNRgxr8ElI4TTjlKvOL2UtLUzSEou+/WlC0uuarCuTvIijGQqz7OFLdalahKexE77h+6GzusNhkgLsY9zQNWt3z+WQ18qzMATVV7dIkt5GT+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714078280; c=relaxed/simple;
	bh=lkRX1fG6qdg/TKVVEzeKQwdo6ddodtAmROeCQW1k9Po=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=OvbwYNItUCZjZNyYuQ3Xs4Uyr6wERmumc0Ezof0CCW8XtFm6oiTFjzakH/ojlPnfzL9E+X7lFjgnaqgZXkF+o6LEf5pDZ8rcf5Cptp9yNbgp55b3YECeSSolFNJxICAnFNSWfeHNoW3uAP0sZZ+Qh7oUeny0SA1uPgPfKGF2+3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=alliedtelesis.co.nz; spf=pass smtp.mailfrom=alliedtelesis.co.nz; dkim=pass (2048-bit key) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b=W41FFbrH; arc=none smtp.client-ip=202.36.163.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=alliedtelesis.co.nz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alliedtelesis.co.nz
Received: from svr-chch-seg1.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id DC67A2C03E9;
	Fri, 26 Apr 2024 08:51:09 +1200 (NZST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
	s=mail181024; t=1714078269;
	bh=lkRX1fG6qdg/TKVVEzeKQwdo6ddodtAmROeCQW1k9Po=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:From;
	b=W41FFbrH3N97H2ifsa3iVT5aoZY9y4a0ok1YVb9hJoxTCuXMBzXt756e3P8cDPvh8
	 VeJyJqUx4c/ORaVNiEZA3mOhrNptlMncVR6SUVN+2qbqg5meKyGrEfAq7VkxZYSUAG
	 TxnSB4UJrieTiAYaNdGqWi2r9mrHNCv2lhI0DYVBdFbIGz68j33nhGNZ7RT85RqKVa
	 v4jGCh/1tzEAD5M6diuuP9R0pE9hoSHEe1Y4q/hE/moT0fcD32py0+oSuJlNVp8q3s
	 n8/pX9p9dTtEgh4KKtFqJRIe4QMR/vODz3ZgBXIbKbz/+/8OJ3kkXPQT5mihiRvjhL
	 qF95uCjQji0Ow==
Received: from svr-chch-ex2.atlnz.lc (Not Verified[2001:df5:b000:bc8::76]) by svr-chch-seg1.atlnz.lc with Trustwave SEG (v8,2,6,11305)
	id <B662ac23d0001>; Fri, 26 Apr 2024 08:51:09 +1200
Received: from svr-chch-ex2.atlnz.lc (2001:df5:b000:bc8::76) by
 svr-chch-ex2.atlnz.lc (2001:df5:b000:bc8::76) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Fri, 26 Apr 2024 08:51:09 +1200
Received: from svr-chch-ex2.atlnz.lc ([fe80::a9eb:c9b7:8b52:9567]) by
 svr-chch-ex2.atlnz.lc ([fe80::a9eb:c9b7:8b52:9567%15]) with mapi id
 15.02.1544.009; Fri, 26 Apr 2024 08:51:09 +1200
From: Chris Packham <Chris.Packham@alliedtelesis.co.nz>
To: NeilBrown <neilb@suse.de>, Chuck Lever III <chuck.lever@oracle.com>
CC: Jeff Layton <jlayton@kernel.org>, Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>, Linux NFS Mailing List
	<linux-nfs@vger.kernel.org>, netdev <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: kernel BUG at net/sunrpc/svc.c:570 after updating from v5.15.153
 to v5.15.155
Thread-Topic: kernel BUG at net/sunrpc/svc.c:570 after updating from v5.15.153
 to v5.15.155
Thread-Index: AQHaleHzc3oveYbGkkq3WWVD/cih7bF12zkAgABlswCAAStOgIAACEqA///XTYCAAWPYAA==
Date: Thu, 25 Apr 2024 20:51:09 +0000
Message-ID: <141fbaa0-f8fa-4bfe-8c2d-7749fcf78ab3@alliedtelesis.co.nz>
References: <> <5D19EAF8-0F65-4CD6-9378-67234D407B96@oracle.com>
 <171400185158.7600.16163546434537681088@noble.neil.brown.name>
In-Reply-To: <171400185158.7600.16163546434537681088@noble.neil.brown.name>
Accept-Language: en-NZ, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
Content-Type: text/plain; charset="utf-8"
Content-ID: <E621C99F46B2FA4E83FFBC84D758A5C2@atlnz.lc>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-SEG-SpamProfiler-Analysis: v=2.4 cv=dY4j3mXe c=1 sm=1 tr=0 ts=662ac23d a=Xf/6aR1Nyvzi7BryhOrcLQ==:117 a=xqWC_Br6kY4A:10 a=75chYTbOgJ0A:10 a=IkcTkHD0fZMA:10 a=raytVjVEu-sA:10 a=yPCof4ZbAAAA:8 a=VwQbUJbxAAAA:8 a=VJ8-JLLbby-0TyR3JjMA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=AjGcO6oz07-iQ99wixmX:22
X-SEG-SpamProfiler-Score: 0

DQpPbiAyNS8wNC8yNCAxMTozNywgTmVpbEJyb3duIHdyb3RlOg0KPiBPbiBUaHUsIDI1IEFwciAy
MDI0LCBDaHVjayBMZXZlciBJSUkgd3JvdGU6DQo+Pj4gT24gQXByIDI0LCAyMDI0LCBhdCA5OjMz
4oCvQU0sIENodWNrIExldmVyIElJSSA8Y2h1Y2subGV2ZXJAb3JhY2xlLmNvbT4gd3JvdGU6DQo+
Pj4NCj4+Pj4gT24gQXByIDI0LCAyMDI0LCBhdCAzOjQy4oCvQU0sIENocmlzIFBhY2toYW0gPENo
cmlzLlBhY2toYW1AYWxsaWVkdGVsZXNpcy5jby5uej4gd3JvdGU6DQo+Pj4+DQo+Pj4+IE9uIDI0
LzA0LzI0IDEzOjM4LCBDaHJpcyBQYWNraGFtIHdyb3RlOg0KPj4+Pj4gT24gMjQvMDQvMjQgMTI6
NTQsIENocmlzIFBhY2toYW0gd3JvdGU6DQo+Pj4+Pj4gSGkgSmVmZiwgQ2h1Y2ssIEdyZWcsDQo+
Pj4+Pj4NCj4+Pj4+PiBBZnRlciB1cGRhdGluZyBvbmUgb2Ygb3VyIGJ1aWxkcyBhbG9uZyB0aGUg
NS4xNS55IExUUyBicmFuY2ggb3VyDQo+Pj4+Pj4gdGVzdGluZyBjYXVnaHQgYSBuZXcga2VybmVs
IGJ1Zy4gT3V0cHV0IGJlbG93Lg0KPj4+Pj4+DQo+Pj4+Pj4gSSBoYXZlbid0IGR1ZyBpbnRvIGl0
IHlldCBidXQgd29uZGVyZWQgaWYgaXQgcmFuZyBhbnkgYmVsbHMuDQo+Pj4+PiBBIGJpdCBtb3Jl
IGluZm8uIFRoaXMgaXMgaGFwcGVuaW5nIGF0ICJyZWJvb3QiIGZvciB1cy4gT3VyIGVtYmVkZGVk
DQo+Pj4+PiBkZXZpY2VzIHVzZSBhIGJpdCBvZiBhIGhhY2tlZCB1cCByZWJvb3QgcHJvY2VzcyBz
byB0aGF0IHRoZXkgY29tZSBiYWNrDQo+Pj4+PiBmYXN0ZXIgaW4gdGhlIGNhc2Ugb2YgYSBmYWls
dXJlLg0KPj4+Pj4NCj4+Pj4+IEl0IGRvZXNuJ3QgaGFwcGVuIHdpdGggYSBwcm9wZXIgYHN5c3Rl
bWN0bCByZWJvb3RgIG9yIHdpdGggYSBTWVNSUStCDQo+Pj4+Pg0KPj4+Pj4gSSBjYW4gdHJpZ2dl
ciBpdCB3aXRoIGBraWxsYWxsIC05IG5mc2RgIHdoaWNoIEknbSBub3Qgc3VyZSBpcyBhDQo+Pj4+
PiBjb21wbGV0ZWx5IGxlZ2l0IHRoaW5nIHRvIGRvIHRvIGtlcm5lbCB0aHJlYWRzIGJ1dCBpdCdz
IHByb2JhYmx5IGNsb3NlDQo+Pj4+PiB0byB3aGF0IG91ciBjdXN0b21pemVkIHJlYm9vdCBkb2Vz
Lg0KPj4+PiBJJ3ZlIGJpc2VjdGVkIGJldHdlZW4gdjUuMTUuMTUzIGFuZCB2NS4xNS4xNTUgYW5k
IGlkZW50aWZpZWQgY29tbWl0DQo+Pj4+IGRlYzZiOGJjYWM3MyAoIm5mc2Q6IFNpbXBsaWZ5IGNv
ZGUgYXJvdW5kIHN2Y19leGl0X3RocmVhZCgpIGNhbGwgaW4NCj4+Pj4gbmZzZCgpIikgYXMgdGhl
IGZpcnN0IGJhZCBjb21taXQuIEJhc2VkIG9uIHRoZSBjb250ZXh0IHRoYXQgc2VlbXMgdG8NCj4+
Pj4gbGluZSB1cCB3aXRoIG15IHJlcHJvZHVjdGlvbi4gSSdtIHdvbmRlcmluZyBpZiBwZXJoYXBz
IHNvbWV0aGluZyBnb3QNCj4+Pj4gbWlzc2VkIG91dCBvZiB0aGUgc3RhYmxlIHRyYWNrPyBVbmZv
cnR1bmF0ZWx5IEknbSBub3QgYWJsZSB0byBydW4gYSBtb3JlDQo+Pj4+IHJlY2VudCBrZXJuZWwg
d2l0aCBhbGwgb2YgdGhlIG5mcyByZWxhdGVkIHNldHVwIHRoYXQgaXMgYmVpbmcgdXNlZCBvbg0K
Pj4+PiB0aGUgc3lzdGVtIGluIHF1ZXN0aW9uLg0KPj4+IFRoYW5rcyBmb3IgYmlzZWN0aW5nLCB0
aGF0IHdvdWxkIGhhdmUgYmVlbiBteSBmaXJzdCBzdWdnZXN0aW9uLg0KPj4+DQo+Pj4gVGhlIGJh
Y2twb3J0IGluY2x1ZGVkIGFsbCBvZiB0aGUgTkZTRCBwYXRjaGVzIHVwIHRvIHY2LjIsIGJ1dA0K
Pj4+IHRoZXJlIG1pZ2h0IGJlIGEgbWlzc2luZyBzZXJ2ZXItc2lkZSBTdW5SUEMgcGF0Y2guDQo+
PiBTbyBkZWM2YjhiY2FjNzMgKCJuZnNkOiBTaW1wbGlmeSBjb2RlIGFyb3VuZCBzdmNfZXhpdF90
aHJlYWQoKQ0KPj4gY2FsbCBpbiAgbmZzZCgpIikgaXMgZnJvbSB2Ni42LCBzbyBpdCB3YXMgYXBw
bGllZCB0byB2NS4xNS55DQo+PiBvbmx5IHRvIGdldCBhIHN1YnNlcXVlbnQgTkZTRCBmaXggdG8g
YXBwbHkuDQo+Pg0KPj4gVGhlIGltbWVkaWF0ZWx5IHByZXZpb3VzIHVwc3RyZWFtIGNvbW1pdCBp
cyBtaXNzaW5nOg0KPj4NCj4+ICAgIDM5MDM5MDI0MDE0NSAoIm5mc2Q6IGRvbid0IGFsbG93IG5m
c2QgdGhyZWFkcyB0byBiZSBzaWduYWxsZWQuIikNCj4+DQo+PiBGb3IgdGVzdGluZywgSSd2ZSBh
cHBsaWVkIHRoaXMgdG8gbXkgbmZzZC01LjE1LnkgYnJhbmNoIGhlcmU6DQo+Pg0KPj4gICAgaHR0
cHM6Ly9naXQua2VybmVsLm9yZy9wdWIvc2NtL2xpbnV4L2tlcm5lbC9naXQvY2VsL2xpbnV4Lmdp
dA0KPj4NCj4+IEhvd2V2ZXIgZXZlbiBpZiB0aGF0IGZpeGVzIHRoZSByZXBvcnRlZCBjcmFzaCwg
dGhpcyBzdWdnZXN0cw0KPj4gdGhhdCBhZnRlciB2Ni42LCBuZnNkIHRocmVhZHMgYXJlIG5vdCBn
b2luZyB0byByZXNwb25kIHRvDQo+PiAia2lsbGFsbCAtOSBuZnNkIi4NCj4gSSB0aGluayB0aGlz
IGxpa2VseSBpcyB0aGUgcHJvYmxlbS4gIFRoZSBuZnNkIHRocmVhZHMgbXVzdCBiZSBiZWluZw0K
PiBraWxsZWQgYnkgYSBzaWduYWwuDQo+IE9uZSBvbmx5IG90aGVyIGNhdXNlIGZvciBhbiBuZnNk
IHRocmVhZCB0byBleGl0IGlzIGlmDQo+IHN2Y19zZXRfbnVtX3RocmVhZHMoKSBpcyBjYWxsZWQs
IGFuZCBhbGwgcGxhY2VzIHRoYXQgY2FsbCB0aGF0IGhvbGQgYQ0KPiByZWYgb24gdGhlIHNlcnYg
c3RydWN0dXJlIHNvIHRoZSBmaW5hbCBwdXQgd29uJ3QgaGFwcGVuIHdoZW4gdGhlIHRocmVhZA0K
PiBleGl0cy4NCj4NCj4gQmVmb3JlIHRoZSBwYXRjaCB0aGF0IGJpc2VjdCBmb3VuZCwgdGhlIG5m
c2QgdGhyZWFkIHdvdWxkIGV4aXQgd2l0aA0KPg0KPiAgIHN2Y19nZXQoKTsNCj4gICBzdmNfZXhp
dF90aHJlYWQoKTsNCj4gICBuZnNkX3B1dCgpOw0KPg0KPiBUaGlzIGFsc28gaG9sZHMgYSByZWYg
YWNyb3NzIHRoZSBzdmNfZXhpdF90aHJlYWQoKSwgYW5kIGVuc3VyZXMgdGhlDQo+IGZpbmFsICdw
dXQnIGhhcHBlbnMgZnJvbSBuZnNEX3B1dCgpLCBub3Qgc3ZjX3B1dCgpIChpbg0KPiBzdmNfZXhp
dF90aHJlYWQoKSkuDQo+DQo+IENocmlzOiB3aGF0IHdhcyB0aGUgY29udGV4dCB3aGVuIHRoZSBj
cmFzaCBoYXBwZW5lZD8gIENvdWxkIHRoZSBuZnNkDQo+IHRocmVhZHMgaGF2ZSBiZWVuIHNpZ25h
bGxlZD8gIFRoYXQgaGFzbid0IGJlZW4gdGhlIHN0YW5kYXJkIHdheSB0byBzdG9wDQo+IG5mc2Qg
dGhyZWFkcyBmb3IgYSBsb25nIHRpbWUsIHNvIEknbSBhIGxpdHRsZSBzdXJwcmlzZWQgdGhhdCBp
dCBpcw0KPiBoYXBwZW5pbmcuDQoNCldlIHVzZSBhIGhhY2tlZCB1cCB2ZXJzaW9uIG9mIHNodXRk
b3duIGZyb20gdXRpbC1saW51eCBhbmQgd2hpY2ggZG9lcyBhIA0KYGtpbGwgKC0xLCBTSUdURVJN
KTtgIHRoZW4gYGtpbGwgKC0xLCBTSUdLSUxMKTtgIChJIGRvbid0IHRoaW5rIHRoYXQgDQpwYXJ0
aWN1bGFyIGJlaGF2aW91ciBpcyB0aGUgaGFja2VyeSkuIEknbSBub3Qgc3VyZSBpZiAtMSB3aWxs
IHBpY2sgdXAgDQprZXJuZWwgdGhyZWFkcyBidXQgYmFzZWQgb24gdGhlIHN5bXB0b21zIGl0IGFw
cGVhcnMgdG8gYmUgZG9pbmcgc28gKG9yIA0KbWF5YmUgc29tZXRoaW5nIGVsc2UgaXMgaW4gaXQn
cyBTSUdURVJNIGhhbmRsZXIpLiBJIGRvbid0IHRoaW5rIHdlIHdlcmUgDQpldmVyIHJlYWxseSBp
bnRlbmRpbmcgdG8gc2VuZCB0aGUgc2lnbmFscyB0byBuZnNkIHNvIHdoZXRoZXIgaXQgYWN0dWFs
bHkgDQp0ZXJtaW5hdGVzIG9yIG5vdCBJIGRvbid0IHRoaW5rIGlzIGFuIGlzc3VlIGZvciB1cy4g
SSBjYW4gY29uZmlybSB0aGF0IA0KYXBwbHlpbmcgMzkwMzkwMjQwMTQ1IHJlc29sdmVzIHRoZSBz
eW1wdG9tIHdlIHdlcmUgc2VlaW5nLg0KDQo=


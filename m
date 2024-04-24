Return-Path: <linux-nfs+bounces-2974-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E6CC8AFDE5
	for <lists+linux-nfs@lfdr.de>; Wed, 24 Apr 2024 03:38:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E0947285C64
	for <lists+linux-nfs@lfdr.de>; Wed, 24 Apr 2024 01:38:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34400749A;
	Wed, 24 Apr 2024 01:38:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b="0TqBFOqR"
X-Original-To: linux-nfs@vger.kernel.org
Received: from gate2.alliedtelesis.co.nz (gate2.alliedtelesis.co.nz [202.36.163.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C0306FB8
	for <linux-nfs@vger.kernel.org>; Wed, 24 Apr 2024 01:38:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.36.163.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713922703; cv=none; b=Yqw2249wd7bXqadgquWw+DQoSWUk+t5KCP01kB/uOh9xSW/R7tTrbDBn172nMdoyJ2bfDJ6H0LIq2e+Dexu8ykLplyOx/vohDnWWylMlgaoIltx2FTYD7dkOtuFCc19GGtZNhdEPFxwSOimZ1DXW6k3aOXxs2GQhOEjsDxOEo0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713922703; c=relaxed/simple;
	bh=iopcgr3rm1GlCkZxTneL83WpCXee/HP4dS8CuULl/go=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=UzVQJRL3UcPhLqQpyuurjCxz963DA4Q30mCK8s/Hheh0eE2gn3FDdRvZC6caHOA6CN7OjV4luX3xidOTFeSvqdYXWO/Mz9XRIyND3who4aHNx33oUtcPj/vcVgxH+H/AsUgSb+9AGG/xONqSVdxsQyQF8WsKeeginSfuYITYC40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=alliedtelesis.co.nz; spf=pass smtp.mailfrom=alliedtelesis.co.nz; dkim=pass (2048-bit key) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b=0TqBFOqR; arc=none smtp.client-ip=202.36.163.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=alliedtelesis.co.nz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alliedtelesis.co.nz
Received: from svr-chch-seg1.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id CEAF82C02AE;
	Wed, 24 Apr 2024 13:38:17 +1200 (NZST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
	s=mail181024; t=1713922697;
	bh=iopcgr3rm1GlCkZxTneL83WpCXee/HP4dS8CuULl/go=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:From;
	b=0TqBFOqRHxDY6YM38FvQdFMDHVEItdwJHTXZeNpGT55AoDMM3TP5w4Iz3N+X+nwe/
	 J6jv/XxwlIdtKDN2c19NU/pFwER0CUAkdCkVJbYpFJOddU08AwA0NG60fU3ldWTNn6
	 IZW7xWHuEN18BTTRyk2Qp/hM27ttLLTRfGNzwDhpCS0NJ0Kj4HLvjCLRGnKwishbWE
	 fuvOmEXQIl02GXb5wl3MF1RnHO+AifambdikNS6kYqwS1Ve1Sd6LjwKRrAPQY+7npM
	 HBY/L49+5XSKv+mbnDqTG4ontQH8Qk2WTXUMyflf/YOdaFfLIB57s3eKwgf3va6QMM
	 w6Rg1o26Y8duA==
Received: from svr-chch-ex2.atlnz.lc (Not Verified[2001:df5:b000:bc8::76]) by svr-chch-seg1.atlnz.lc with Trustwave SEG (v8,2,6,11305)
	id <B662862890001>; Wed, 24 Apr 2024 13:38:17 +1200
Received: from svr-chch-ex1.atlnz.lc (2001:df5:b000:bc8::77) by
 svr-chch-ex2.atlnz.lc (2001:df5:b000:bc8:f753:6de:11c0:a008) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.2.1544.9; Wed, 24 Apr 2024 13:38:17 +1200
Received: from svr-chch-ex2.atlnz.lc (2001:df5:b000:bc8::76) by
 svr-chch-ex1.atlnz.lc (2001:df5:b000:bc8::77) with Microsoft SMTP Server
 (TLS) id 15.0.1497.48; Wed, 24 Apr 2024 13:38:17 +1200
Received: from svr-chch-ex2.atlnz.lc ([fe80::a9eb:c9b7:8b52:9567]) by
 svr-chch-ex2.atlnz.lc ([fe80::a9eb:c9b7:8b52:9567%15]) with mapi id
 15.02.1544.009; Wed, 24 Apr 2024 13:38:17 +1200
From: Chris Packham <Chris.Packham@alliedtelesis.co.nz>
To: Jeff Layton <jlayton@kernel.org>, Chuck Lever <chuck.lever@oracle.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC: "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>, netdev
	<netdev@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "stable@vger.kernel.org"
	<stable@vger.kernel.org>
Subject: Re: kernel BUG at net/sunrpc/svc.c:570 after updating from v5.15.153
 to v5.15.155
Thread-Topic: kernel BUG at net/sunrpc/svc.c:570 after updating from v5.15.153
 to v5.15.155
Thread-Index: AQHaleHzc3oveYbGkkq3WWVD/cih7bF12zkA
Date: Wed, 24 Apr 2024 01:38:17 +0000
Message-ID: <0d2c2123-e782-4712-8876-c9b65d2c9a65@alliedtelesis.co.nz>
References: <b363e394-7549-4b9e-b71b-d97cd13f9607@alliedtelesis.co.nz>
In-Reply-To: <b363e394-7549-4b9e-b71b-d97cd13f9607@alliedtelesis.co.nz>
Accept-Language: en-NZ, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
Content-Type: text/plain; charset="utf-8"
Content-ID: <36B91780D8124341AE1E686FAD1428B8@atlnz.lc>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-SEG-SpamProfiler-Analysis: v=2.4 cv=dY4j3mXe c=1 sm=1 tr=0 ts=66286289 a=Xf/6aR1Nyvzi7BryhOrcLQ==:117 a=xqWC_Br6kY4A:10 a=75chYTbOgJ0A:10 a=IkcTkHD0fZMA:10 a=raytVjVEu-sA:10 a=VaKPTF99bPf2uOp7nPkA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-SEG-SpamProfiler-Score: 0

DQpPbiAyNC8wNC8yNCAxMjo1NCwgQ2hyaXMgUGFja2hhbSB3cm90ZToNCj4gSGkgSmVmZiwgQ2h1
Y2ssIEdyZWcsDQo+DQo+IEFmdGVyIHVwZGF0aW5nIG9uZSBvZiBvdXIgYnVpbGRzIGFsb25nIHRo
ZSA1LjE1LnkgTFRTIGJyYW5jaCBvdXIgDQo+IHRlc3RpbmcgY2F1Z2h0IGEgbmV3IGtlcm5lbCBi
dWcuIE91dHB1dCBiZWxvdy4NCj4NCj4gSSBoYXZlbid0IGR1ZyBpbnRvIGl0IHlldCBidXQgd29u
ZGVyZWQgaWYgaXQgcmFuZyBhbnkgYmVsbHMuDQoNCkEgYml0IG1vcmUgaW5mby4gVGhpcyBpcyBo
YXBwZW5pbmcgYXQgInJlYm9vdCIgZm9yIHVzLiBPdXIgZW1iZWRkZWQgDQpkZXZpY2VzIHVzZSBh
IGJpdCBvZiBhIGhhY2tlZCB1cCByZWJvb3QgcHJvY2VzcyBzbyB0aGF0IHRoZXkgY29tZSBiYWNr
IA0KZmFzdGVyIGluIHRoZSBjYXNlIG9mIGEgZmFpbHVyZS4NCg0KSXQgZG9lc24ndCBoYXBwZW4g
d2l0aCBhIHByb3BlciBgc3lzdGVtY3RsIHJlYm9vdGAgb3Igd2l0aCBhIFNZU1JRK0INCg0KSSBj
YW4gdHJpZ2dlciBpdCB3aXRoIGBraWxsYWxsIC05IG5mc2RgIHdoaWNoIEknbSBub3Qgc3VyZSBp
cyBhIA0KY29tcGxldGVseSBsZWdpdCB0aGluZyB0byBkbyB0byBrZXJuZWwgdGhyZWFkcyBidXQg
aXQncyBwcm9iYWJseSBjbG9zZSANCnRvIHdoYXQgb3VyIGN1c3RvbWl6ZWQgcmVib290IGRvZXMu
DQoNCj4NCj4gVGhhbmtzLA0KPiBDaHJpcw0KPg0KPiBbwqDCoCA5MS42MDUxMDldIC0tLS0tLS0t
LS0tLVsgY3V0IGhlcmUgXS0tLS0tLS0tLS0tLQ0KPiBbwqDCoCA5MS42MDUxMjJdIGtlcm5lbCBC
VUcgYXQgbmV0L3N1bnJwYy9zdmMuYzo1NzAhDQo+IFvCoMKgIDkxLjYwNTEyOV0gSW50ZXJuYWwg
ZXJyb3I6IE9vcHMgLSBCVUc6IDAwMDAwMDAwZjIwMDA4MDAgWyMxXSANCj4gUFJFRU1QVCBTTVAN
Cj4gW8KgwqAgOTEuNjEwNjQzXSBNb2R1bGVzIGxpbmtlZCBpbjogbXZjcHNzKE8pIHBsYXRmb3Jt
X2RyaXZlcihPKSANCj4gaXBpZndkKE8pIHh0X2wydHAgeHRfaGFzaGxpbWl0IHh0X2Nvbm50cmFj
ayB4dF9hZGRydHlwZSB4dF9MT0cgDQo+IHh0X0NIRUNLU1VNIHdwNTEyIHZ4bGFuIHZldGggdHdv
ZmlzaF9nZW5lcmljIHR3b2Zpc2hfY29tbW9uIHNyOTgwMCANCj4gc21zYzk1eHggc21zYzc1eHgg
c21zYyBzbTNfZ2VuZXJpYyBzaGE1MTJfYXJtNjQgc2hhM19nZW5lcmljIA0KPiBzZXJwZW50X2dl
bmVyaWMgcnRsODE1MCBycGNzZWNfZ3NzX2tyYjUgcm1kMTYwIHBvbHkxMzA1X2dlbmVyaWMgcGx1
c2IgDQo+IHBlZ2FzdXMgb3B0ZWVfcm5nIG5iZCBtaWNyb2NoaXAgbWQ0IG1kX21vZCBtY3M3ODMw
IGxydyBsaWJwb2x5MTMwNSANCj4gbGFuNzh4eCBsMnRwX2lwNiBsMnRwX2lwIGwydHBfZXRoIGwy
dHBfbmV0bGluayBsMnRwX2NvcmUgdWRwX3R1bm5lbCANCj4gaXB0X1JFSkVDVCBuZl9yZWplY3Rf
aXB2NCBpcDZ0YWJsZV9uYXQgaXA2dGFibGVfbWFuZ2xlIGlwNnRhYmxlX2ZpbHRlciANCj4gaXA2
dF9pcHY2aGVhZGVyIGlwNnRfUkVKRUNUIGlwNl91ZHBfdHVubmVsIGlwNl90YWJsZXMgZG05NjAx
IGRtX3plcm8gDQo+IGRtX21pcnJvciBkbV9yZWdpb25faGFzaCBkbV9sb2cgZG1fbW9kIGRpYWcg
dGlwYyBjdXNlIGN0cyANCj4gY3B1ZnJlcV9wb3dlcnNhdmUgY3B1ZnJlcV9jb25zZXJ2YXRpdmUg
Y2hhY2hhX2dlbmVyaWMgY2hhY2hhMjBwb2x5MTMwNSANCj4gY2hhY2hhX25lb24gbGliY2hhY2hh
IGNhc3Q2X2dlbmVyaWMgY2FzdDVfZ2VuZXJpYyBjYXN0X2NvbW1vbiANCj4gY2FtZWxsaWFfZ2Vu
ZXJpYyBibG93ZmlzaF9nZW5lcmljIGJsb3dmaXNoX2NvbW1vbiBhdXRoX3JwY2dzcyANCj4gb2lk
X3JlZ2lzdHJ5IGF0MjUgYXJtX3NtY2NjX3RybmcgYWVzX25lb25fYmxrIGlkcHJvbV9tdGQoTykg
DQo+IGlkcHJvbV9pMmMoTykgZXBpM19ib2FyZGluZm9faTJjKE8pIHgyNTAoTykgcHN1c2xvdF9l
cGkzX3JlZ2lzdGVyKE8pIA0KPiBwc3VzbG90X2dwaW9fZ3JvdXAoTykNCj4gW8KgwqAgOTEuNjEw
ODA5XcKgIHBzdXNsb3QoTykNCj4gW8KgwqAgOTEuNjExODIyXSB3YXRjaGRvZzogd2F0Y2hkb2cx
OiB3YXRjaGRvZyBkaWQgbm90IHN0b3AhDQo+IFvCoMKgIDkxLjY5NzA2NV3CoCBncGlvcGluc19i
b2FyZGluZm8oTykgaWRwcm9tKE8pIGVwaTNfYm9hcmRpbmZvKE8pIA0KPiBib2FyZGluZm8oTykg
aTJjX2dwaW8gaTJjX2FsZ29fYml0IGkyY19tdjY0eHh4IHBsdWdnYWJsZShPKSANCj4gbGVkX2Vu
YWJsZShPKSBvbWFwX3JuZyBybmdfY29yZSBhdGxfcmVzZXQoTykgc2JzYV9nd2R0IHVpb19wZHJ2
X2dlbmlycQ0KPiBbwqDCoCA5MS42OTcwOTZdIENQVTogMiBQSUQ6IDE3NzAgQ29tbTogbmZzZCBL
ZHVtcDogbG9hZGVkIFRhaW50ZWQ6IA0KPiBHwqDCoMKgwqDCoMKgwqDCoMKgwqAgT8KgwqDCoMKg
wqAgNS4xNS4xNTUgIzENCj4gW8KgwqAgOTEuNjk3MTAzXSBIYXJkd2FyZSBuYW1lOiBBbGxpZWQg
VGVsZXNpcyB4MjUwLTI4WFRtIChEVCkNCj4gW8KgwqAgOTEuNjk3MTA3XSBwc3RhdGU6IDgwMDAw
MDA1IChOemN2IGRhaWYgLVBBTiAtVUFPIC1UQ08gLURJVCAtU1NCUyANCj4gQlRZUEU9LS0pDQo+
IFvCoMKgIDkxLjY5NzExMl0gcGMgOiBzdmNfZGVzdHJveSsweDg0LzB4YWMNCj4gW8KgwqAgOTEu
NzAxMjAyXSB3YXRjaGRvZzogd2F0Y2hkb2cwOiB3YXRjaGRvZyBkaWQgbm90IHN0b3AhDQo+IFvC
oMKgIDkxLjcwMjIxNV0gbHIgOiBzdmNfZGVzdHJveSsweDJjLzB4YWMNCj4gW8KgwqAgOTEuNzAy
MjIwXSBzcCA6IGZmZmY4MDAwMGJiM2JkZTANCj4gW8KgwqAgOTEuNzAyMjIzXSB4Mjk6IGZmZmY4
MDAwMGJiM2JkZTAgeDI4OiAwMDAwMDAwMDAwMDAwMDAwIHgyNzogDQo+IDAwMDAwMDAwMDAwMDAw
MDANCj4gW8KgwqAgOTEuNzQ2MDk1XSB4MjY6IDAwMDAwMDAwMDAwMDAwMDAgeDI1OiBmZmZmMDAw
MDBkYmZhYTQwIHgyNDogDQo+IGZmZmYwMDAwMTZjMTQwMDANCj4gW8KgwqAgOTEuNzQ2MTAxXSB4
MjM6IGZmZmY4MDAwMDgzOTVjMDAgeDIyOiBmZmZmMDAwMDBlZTlmMjg0IHgyMTogDQo+IGZmZmYw
MDAwMGVlYTllMTANCj4gW8KgwqAgOTEuNzQ2MTA4XSB4MjA6IGZmZmYwMDAwMGVlYTllMDAgeDE5
OiBmZmZmMDAwMDBlZWE5ZTE0IHgxODogDQo+IGZmZmY4MDAwMDhlOTkwMDANCj4gW8KgwqAgOTEu
NzY5NTI2XSB4MTc6IDAwMDAwMDAwMDAwMDAwMDYgeDE2OiAwMDAwMDAwMDAwMDAwMDAwIHgxNTog
DQo+IDAwMDAwMDAwMDAwMDAwMDENCj4gW8KgwqAgOTEuNzc2NzgyXSB4MTQ6IDAwMDAwMDAwZmZm
ZmZmZmQgeDEzOiBmZmZmZmMwMDAwMDAwMDAwIHgxMjogDQo+IGZmZmY4MDAwNzZiYzIwMDANCj4g
W8KgwqAgOTEuNzg0MDMxXSB4MTE6IGZmZmYwMDAwN2ZiYTVjMTAgeDEwOiBmZmZmODAwMDc2YmMy
MDAwIHg5IDogDQo+IGZmZmY4MDAwMDkyMjA3YzANCj4gW8KgwqAgOTEuNzg0MDM4XSB4OCA6IGZm
ZmZmYzAwMDA1NWViMDggeDcgOiBmZmZmMDAwMDBlZjZjNGMwIHg2IDogDQo+IGZmZmZmYzAwMDFm
ODcyYzgNCj4gW8KgwqAgOTEuNzk1ODIzXSB4NSA6IDAwMDAwMDAwMDAwMDAxMDAgeDQgOiBmZmZm
MDAwMDdmYmFlZGE4IHgzIDogDQo+IDAwMDAwMDAwMDAwMDAwMDANCj4gW8KgwqAgOTEuODAxNjg0
XSB4MiA6IDAwMDAwMDAwMDAwMDAwMDAgeDEgOiBmZmZmMDAwMDBkOGY4MDE4IHgwIDogDQo+IGZm
ZmYwMDAwMGVlYTllMzANCj4gW8KgwqAgOTEuODA3NTQ1XSBDYWxsIHRyYWNlOg0KPiBbwqDCoCA5
MS44MTAwODhdwqAgc3ZjX2Rlc3Ryb3krMHg4NC8weGFjDQo+IFvCoMKgIDkxLjgxMzU4Nl3CoCBz
dmNfZXhpdF90aHJlYWQrMHgxMDgvMHgxNWMNCj4gW8KgwqAgOTEuODE2OTk4XcKgIG5mc2QrMHgx
NzgvMHgxYTANCj4gW8KgwqAgOTEuODE4NjczXcKgIGt0aHJlYWQrMHgxNTAvMHgxNjANCj4gW8Kg
wqAgOTEuODIwNjEwXcKgIHJldF9mcm9tX2ZvcmsrMHgxMC8weDIwDQo+IFvCoMKgIDkxLjgyMDYy
MF0gQ29kZTogYTk0MTUzZjMgYThjMjdiZmQgZDUwMzIzYmYgZDY1ZjAzYzAgKGQ0MjEwMDAwKQ0K
PiBbwqDCoCA5MS44MjA2MjldIFNNUDogc3RvcHBpbmcgc2Vjb25kYXJ5IENQVXMNCj4gW8KgwqAg
OTEuODMwNDMzXSBTdGFydGluZyBjcmFzaGR1bXAga2VybmVsLi4uDQo+IFvCoMKgIDkxLjgzMzA2
NF0gQnllIQ==


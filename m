Return-Path: <linux-nfs+bounces-2973-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 89C4E8AFD75
	for <lists+linux-nfs@lfdr.de>; Wed, 24 Apr 2024 02:54:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 416D42830E9
	for <lists+linux-nfs@lfdr.de>; Wed, 24 Apr 2024 00:54:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F5594C6D;
	Wed, 24 Apr 2024 00:54:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b="hg7ObPe5"
X-Original-To: linux-nfs@vger.kernel.org
Received: from gate2.alliedtelesis.co.nz (gate2.alliedtelesis.co.nz [202.36.163.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F254A4A24
	for <linux-nfs@vger.kernel.org>; Wed, 24 Apr 2024 00:54:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.36.163.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713920070; cv=none; b=kGjNLNIfU/sBQBVQA+uWS6Gb0JjyVVoOUm+bh8CUwh1JcH+JH+xhQ60BATAYM1HXDXH4XcIlpBnR/DgWePdc8wuyAOMeIENO9jp4hmHihzaFM+EluaL0QFQG/cWl6r0BSFgTB13KHItsG0m8BJhj0cCfEqMQy8SzbiPZeLyNSXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713920070; c=relaxed/simple;
	bh=qFf1rylk6rgoSVVwEkblic/+4NdkoIUgW8cN12Zq53w=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=sKjq5djffCTmhnwpSn5+INd/2G2/S6KBE+BpjiLMfdQMbg+4SIuJXss5THRH8Wsv7C6oG0+ji2MAAjTVsrpQde9chWxR7J/b65oGSZT3qzsk0eNmKgQd19F2OCyU2gHQanYtsLPhAV4i2b1C5I4IuarSEqXAy1iMR6lAqc2oyeY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=alliedtelesis.co.nz; spf=pass smtp.mailfrom=alliedtelesis.co.nz; dkim=pass (2048-bit key) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b=hg7ObPe5; arc=none smtp.client-ip=202.36.163.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=alliedtelesis.co.nz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alliedtelesis.co.nz
Received: from svr-chch-seg1.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id 61B032C02AE;
	Wed, 24 Apr 2024 12:54:25 +1200 (NZST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
	s=mail181024; t=1713920065;
	bh=qFf1rylk6rgoSVVwEkblic/+4NdkoIUgW8cN12Zq53w=;
	h=From:To:CC:Subject:Date:From;
	b=hg7ObPe5Eo1uKHXE4WJMnZ1fKIbAUMDiqoHK9k+OOaJHBzcxn53LpO7dEKvniuQYh
	 KTFiYvY2JLD9uTn95TjXjU83Z0Lhcb2UHTPg+bxmxlTVeP7CTx8Er2Ms5HlmgevAgt
	 ZPsWAK1d8vRf55saaW5X6fOLC02vO2f7ZKzdL1EXf+s3cfOwSwHlVZF21eN4sQB29j
	 Qq2Jp56DzpgnX37d+JJBY7N5LKxCnreTKl/frQkN2hG7zX1lbDPsKTndvCE0yXxnMI
	 /8VuGm+B83szEQWGJ3C+rmdKPJENQ/wklwYrH57AL5h41+FqUHFb/pkYxABffBeQQY
	 1PWGI/BmFF8nw==
Received: from svr-chch-ex2.atlnz.lc (Not Verified[2001:df5:b000:bc8::76]) by svr-chch-seg1.atlnz.lc with Trustwave SEG (v8,2,6,11305)
	id <B662858410001>; Wed, 24 Apr 2024 12:54:25 +1200
Received: from svr-chch-ex2.atlnz.lc (2001:df5:b000:bc8:f753:6de:11c0:a008) by
 svr-chch-ex2.atlnz.lc (2001:df5:b000:bc8:f753:6de:11c0:a008) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Wed, 24 Apr 2024 12:54:25 +1200
Received: from svr-chch-ex2.atlnz.lc ([fe80::a9eb:c9b7:8b52:9567]) by
 svr-chch-ex2.atlnz.lc ([fe80::a9eb:c9b7:8b52:9567%15]) with mapi id
 15.02.1544.009; Wed, 24 Apr 2024 12:54:25 +1200
From: Chris Packham <Chris.Packham@alliedtelesis.co.nz>
To: Jeff Layton <jlayton@kernel.org>, Chuck Lever <chuck.lever@oracle.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC: "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>, netdev
	<netdev@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "stable@vger.kernel.org"
	<stable@vger.kernel.org>
Subject: kernel BUG at net/sunrpc/svc.c:570 after updating from v5.15.153 to
 v5.15.155
Thread-Topic: kernel BUG at net/sunrpc/svc.c:570 after updating from v5.15.153
 to v5.15.155
Thread-Index: AQHaleHzc3oveYbGkkq3WWVD/cih7Q==
Date: Wed, 24 Apr 2024 00:54:24 +0000
Message-ID: <b363e394-7549-4b9e-b71b-d97cd13f9607@alliedtelesis.co.nz>
Accept-Language: en-NZ, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
Content-Type: text/plain; charset="utf-8"
Content-ID: <7B90A518B1F71247981914D163068641@atlnz.lc>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-SEG-SpamProfiler-Analysis: v=2.4 cv=dY4j3mXe c=1 sm=1 tr=0 ts=66285841 a=Xf/6aR1Nyvzi7BryhOrcLQ==:117 a=xqWC_Br6kY4A:10 a=75chYTbOgJ0A:10 a=IkcTkHD0fZMA:10 a=raytVjVEu-sA:10 a=K1bbpvpp5pGVv9oevD4A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-SEG-SpamProfiler-Score: 0

SGkgSmVmZiwgQ2h1Y2ssIEdyZWcsDQoNCkFmdGVyIHVwZGF0aW5nIG9uZSBvZiBvdXIgYnVpbGRz
IGFsb25nIHRoZSA1LjE1LnkgTFRTIGJyYW5jaCBvdXIgdGVzdGluZyANCmNhdWdodCBhIG5ldyBr
ZXJuZWwgYnVnLiBPdXRwdXQgYmVsb3cuDQoNCkkgaGF2ZW4ndCBkdWcgaW50byBpdCB5ZXQgYnV0
IHdvbmRlcmVkIGlmIGl0IHJhbmcgYW55IGJlbGxzLg0KDQpUaGFua3MsDQpDaHJpcw0KDQpbwqDC
oCA5MS42MDUxMDldIC0tLS0tLS0tLS0tLVsgY3V0IGhlcmUgXS0tLS0tLS0tLS0tLQ0KW8KgwqAg
OTEuNjA1MTIyXSBrZXJuZWwgQlVHIGF0IG5ldC9zdW5ycGMvc3ZjLmM6NTcwIQ0KW8KgwqAgOTEu
NjA1MTI5XSBJbnRlcm5hbCBlcnJvcjogT29wcyAtIEJVRzogMDAwMDAwMDBmMjAwMDgwMCBbIzFd
IFBSRUVNUFQgU01QDQpbwqDCoCA5MS42MTA2NDNdIE1vZHVsZXMgbGlua2VkIGluOiBtdmNwc3Mo
TykgcGxhdGZvcm1fZHJpdmVyKE8pIGlwaWZ3ZChPKSANCnh0X2wydHAgeHRfaGFzaGxpbWl0IHh0
X2Nvbm50cmFjayB4dF9hZGRydHlwZSB4dF9MT0cgeHRfQ0hFQ0tTVU0gd3A1MTIgDQp2eGxhbiB2
ZXRoIHR3b2Zpc2hfZ2VuZXJpYyB0d29maXNoX2NvbW1vbiBzcjk4MDAgc21zYzk1eHggc21zYzc1
eHggc21zYyANCnNtM19nZW5lcmljIHNoYTUxMl9hcm02NCBzaGEzX2dlbmVyaWMgc2VycGVudF9n
ZW5lcmljIHJ0bDgxNTAgDQpycGNzZWNfZ3NzX2tyYjUgcm1kMTYwIHBvbHkxMzA1X2dlbmVyaWMg
cGx1c2IgcGVnYXN1cyBvcHRlZV9ybmcgbmJkIA0KbWljcm9jaGlwIG1kNCBtZF9tb2QgbWNzNzgz
MCBscncgbGlicG9seTEzMDUgbGFuNzh4eCBsMnRwX2lwNiBsMnRwX2lwIA0KbDJ0cF9ldGggbDJ0
cF9uZXRsaW5rIGwydHBfY29yZSB1ZHBfdHVubmVsIGlwdF9SRUpFQ1QgbmZfcmVqZWN0X2lwdjQg
DQppcDZ0YWJsZV9uYXQgaXA2dGFibGVfbWFuZ2xlIGlwNnRhYmxlX2ZpbHRlciBpcDZ0X2lwdjZo
ZWFkZXIgaXA2dF9SRUpFQ1QgDQppcDZfdWRwX3R1bm5lbCBpcDZfdGFibGVzIGRtOTYwMSBkbV96
ZXJvIGRtX21pcnJvciBkbV9yZWdpb25faGFzaCBkbV9sb2cgDQpkbV9tb2QgZGlhZyB0aXBjIGN1
c2UgY3RzIGNwdWZyZXFfcG93ZXJzYXZlIGNwdWZyZXFfY29uc2VydmF0aXZlIA0KY2hhY2hhX2dl
bmVyaWMgY2hhY2hhMjBwb2x5MTMwNSBjaGFjaGFfbmVvbiBsaWJjaGFjaGEgY2FzdDZfZ2VuZXJp
YyANCmNhc3Q1X2dlbmVyaWMgY2FzdF9jb21tb24gY2FtZWxsaWFfZ2VuZXJpYyBibG93ZmlzaF9n
ZW5lcmljIA0KYmxvd2Zpc2hfY29tbW9uIGF1dGhfcnBjZ3NzIG9pZF9yZWdpc3RyeSBhdDI1IGFy
bV9zbWNjY190cm5nIA0KYWVzX25lb25fYmxrIGlkcHJvbV9tdGQoTykgaWRwcm9tX2kyYyhPKSBl
cGkzX2JvYXJkaW5mb19pMmMoTykgeDI1MChPKSANCnBzdXNsb3RfZXBpM19yZWdpc3RlcihPKSBw
c3VzbG90X2dwaW9fZ3JvdXAoTykNClvCoMKgIDkxLjYxMDgwOV3CoCBwc3VzbG90KE8pDQpbwqDC
oCA5MS42MTE4MjJdIHdhdGNoZG9nOiB3YXRjaGRvZzE6IHdhdGNoZG9nIGRpZCBub3Qgc3RvcCEN
ClvCoMKgIDkxLjY5NzA2NV3CoCBncGlvcGluc19ib2FyZGluZm8oTykgaWRwcm9tKE8pIGVwaTNf
Ym9hcmRpbmZvKE8pIA0KYm9hcmRpbmZvKE8pIGkyY19ncGlvIGkyY19hbGdvX2JpdCBpMmNfbXY2
NHh4eCBwbHVnZ2FibGUoTykgDQpsZWRfZW5hYmxlKE8pIG9tYXBfcm5nIHJuZ19jb3JlIGF0bF9y
ZXNldChPKSBzYnNhX2d3ZHQgdWlvX3BkcnZfZ2VuaXJxDQpbwqDCoCA5MS42OTcwOTZdIENQVTog
MiBQSUQ6IDE3NzAgQ29tbTogbmZzZCBLZHVtcDogbG9hZGVkIFRhaW50ZWQ6IA0KR8KgwqDCoMKg
wqDCoMKgwqDCoMKgIE/CoMKgwqDCoMKgIDUuMTUuMTU1ICMxDQpbwqDCoCA5MS42OTcxMDNdIEhh
cmR3YXJlIG5hbWU6IEFsbGllZCBUZWxlc2lzIHgyNTAtMjhYVG0gKERUKQ0KW8KgwqAgOTEuNjk3
MTA3XSBwc3RhdGU6IDgwMDAwMDA1IChOemN2IGRhaWYgLVBBTiAtVUFPIC1UQ08gLURJVCAtU1NC
UyANCkJUWVBFPS0tKQ0KW8KgwqAgOTEuNjk3MTEyXSBwYyA6IHN2Y19kZXN0cm95KzB4ODQvMHhh
Yw0KW8KgwqAgOTEuNzAxMjAyXSB3YXRjaGRvZzogd2F0Y2hkb2cwOiB3YXRjaGRvZyBkaWQgbm90
IHN0b3AhDQpbwqDCoCA5MS43MDIyMTVdIGxyIDogc3ZjX2Rlc3Ryb3krMHgyYy8weGFjDQpbwqDC
oCA5MS43MDIyMjBdIHNwIDogZmZmZjgwMDAwYmIzYmRlMA0KW8KgwqAgOTEuNzAyMjIzXSB4Mjk6
IGZmZmY4MDAwMGJiM2JkZTAgeDI4OiAwMDAwMDAwMDAwMDAwMDAwIHgyNzogDQowMDAwMDAwMDAw
MDAwMDAwDQpbwqDCoCA5MS43NDYwOTVdIHgyNjogMDAwMDAwMDAwMDAwMDAwMCB4MjU6IGZmZmYw
MDAwMGRiZmFhNDAgeDI0OiANCmZmZmYwMDAwMTZjMTQwMDANClvCoMKgIDkxLjc0NjEwMV0geDIz
OiBmZmZmODAwMDA4Mzk1YzAwIHgyMjogZmZmZjAwMDAwZWU5ZjI4NCB4MjE6IA0KZmZmZjAwMDAw
ZWVhOWUxMA0KW8KgwqAgOTEuNzQ2MTA4XSB4MjA6IGZmZmYwMDAwMGVlYTllMDAgeDE5OiBmZmZm
MDAwMDBlZWE5ZTE0IHgxODogDQpmZmZmODAwMDA4ZTk5MDAwDQpbwqDCoCA5MS43Njk1MjZdIHgx
NzogMDAwMDAwMDAwMDAwMDAwNiB4MTY6IDAwMDAwMDAwMDAwMDAwMDAgeDE1OiANCjAwMDAwMDAw
MDAwMDAwMDENClvCoMKgIDkxLjc3Njc4Ml0geDE0OiAwMDAwMDAwMGZmZmZmZmZkIHgxMzogZmZm
ZmZjMDAwMDAwMDAwMCB4MTI6IA0KZmZmZjgwMDA3NmJjMjAwMA0KW8KgwqAgOTEuNzg0MDMxXSB4
MTE6IGZmZmYwMDAwN2ZiYTVjMTAgeDEwOiBmZmZmODAwMDc2YmMyMDAwIHg5IDogDQpmZmZmODAw
MDA5MjIwN2MwDQpbwqDCoCA5MS43ODQwMzhdIHg4IDogZmZmZmZjMDAwMDU1ZWIwOCB4NyA6IGZm
ZmYwMDAwMGVmNmM0YzAgeDYgOiANCmZmZmZmYzAwMDFmODcyYzgNClvCoMKgIDkxLjc5NTgyM10g
eDUgOiAwMDAwMDAwMDAwMDAwMTAwIHg0IDogZmZmZjAwMDA3ZmJhZWRhOCB4MyA6IA0KMDAwMDAw
MDAwMDAwMDAwMA0KW8KgwqAgOTEuODAxNjg0XSB4MiA6IDAwMDAwMDAwMDAwMDAwMDAgeDEgOiBm
ZmZmMDAwMDBkOGY4MDE4IHgwIDogDQpmZmZmMDAwMDBlZWE5ZTMwDQpbwqDCoCA5MS44MDc1NDVd
IENhbGwgdHJhY2U6DQpbwqDCoCA5MS44MTAwODhdwqAgc3ZjX2Rlc3Ryb3krMHg4NC8weGFjDQpb
wqDCoCA5MS44MTM1ODZdwqAgc3ZjX2V4aXRfdGhyZWFkKzB4MTA4LzB4MTVjDQpbwqDCoCA5MS44
MTY5OThdwqAgbmZzZCsweDE3OC8weDFhMA0KW8KgwqAgOTEuODE4NjczXcKgIGt0aHJlYWQrMHgx
NTAvMHgxNjANClvCoMKgIDkxLjgyMDYxMF3CoCByZXRfZnJvbV9mb3JrKzB4MTAvMHgyMA0KW8Kg
wqAgOTEuODIwNjIwXSBDb2RlOiBhOTQxNTNmMyBhOGMyN2JmZCBkNTAzMjNiZiBkNjVmMDNjMCAo
ZDQyMTAwMDApDQpbwqDCoCA5MS44MjA2MjldIFNNUDogc3RvcHBpbmcgc2Vjb25kYXJ5IENQVXMN
ClvCoMKgIDkxLjgzMDQzM10gU3RhcnRpbmcgY3Jhc2hkdW1wIGtlcm5lbC4uLg0KW8KgwqAgOTEu
ODMzMDY0XSBCeWUhDQo=


Return-Path: <linux-nfs+bounces-6876-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D239991436
	for <lists+linux-nfs@lfdr.de>; Sat,  5 Oct 2024 06:00:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9FD61B23099
	for <lists+linux-nfs@lfdr.de>; Sat,  5 Oct 2024 04:00:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F32C22EE4;
	Sat,  5 Oct 2024 04:00:13 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from SHSQR01.spreadtrum.com (mx1.unisoc.com [222.66.158.135])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D4071CF96;
	Sat,  5 Oct 2024 04:00:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=222.66.158.135
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728100813; cv=none; b=mr2JJABt37sO4L6RSdknEDhkLIhMVzoiH//zGybwyhdK5j+M4QmcRDBVy0LK+K8WLdsIRiA/KUEgLh7TuitOqFAnVwhn9xy4vpYxyWsL0+QR+azZ3iicGDXjaWWLfgDE0LzpW6Z+bmitP2D8Uoszo2ONxSHH4E5ItrTVo//KYyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728100813; c=relaxed/simple;
	bh=PG0XHGI5wFfTGkP+YR+0JHpic7dT3FF/ZeQno6JDSJc=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=uTqobHzlJMhQnE5fZTCaQAb4ulKc0iM6lQRP+ez6aNwmZ/7vRMHqx8Qe6VmznaVH4jcLwqoCbYoC4jEz+F4SMbBrEN6e+XYkgpXRjADwctKCIdggQL8Mj2tZ/hSGYN7nGyyuz3PBpz1EcV7wPoYKT3eB+2hJpxITqUc/arAR+yc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=unisoc.com; spf=pass smtp.mailfrom=unisoc.com; arc=none smtp.client-ip=222.66.158.135
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=unisoc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=unisoc.com
Received: from dlp.unisoc.com ([10.29.3.86])
	by SHSQR01.spreadtrum.com with ESMTP id 4953xbrx076252;
	Sat, 5 Oct 2024 11:59:37 +0800 (+08)
	(envelope-from zhaoyang.huang@unisoc.com)
Received: from SHDLP.spreadtrum.com (bjmbx01.spreadtrum.com [10.0.64.7])
	by dlp.unisoc.com (SkyGuard) with ESMTPS id 4XLBKx1l11z2QKSM0;
	Sat,  5 Oct 2024 11:51:33 +0800 (CST)
Received: from BJMBX01.spreadtrum.com (10.0.64.7) by BJMBX01.spreadtrum.com
 (10.0.64.7) with Microsoft SMTP Server (TLS) id 15.0.1497.23; Sat, 5 Oct 2024
 11:59:35 +0800
Received: from BJMBX01.spreadtrum.com ([fe80::54e:9a:129d:fac7]) by
 BJMBX01.spreadtrum.com ([fe80::54e:9a:129d:fac7%16]) with mapi id
 15.00.1497.023; Sat, 5 Oct 2024 11:59:35 +0800
From: =?utf-8?B?6buE5pyd6ZizIChaaGFveWFuZyBIdWFuZyk=?=
	<zhaoyang.huang@unisoc.com>
To: Sasha Levin <sashal@kernel.org>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org"
	<stable@vger.kernel.org>,
        =?utf-8?B?5bq357qq5ruoIChTdGV2ZSBLYW5nKQ==?=
	<Steve.Kang@unisoc.com>
CC: Anna Schumaker <anna.schumaker@oracle.com>,
        "trondmy@kernel.org"
	<trondmy@kernel.org>,
        "anna@kernel.org" <anna@kernel.org>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
Subject: reply: [PATCH AUTOSEL 6.11 47/76] fs: nfs: fix missing refcnt by
 replacing folio_set_private by folio_attach_private
Thread-Topic: reply: [PATCH AUTOSEL 6.11 47/76] fs: nfs: fix missing refcnt by
 replacing folio_set_private by folio_attach_private
Thread-Index: AdsW2vyx/M4PP0tDSQ+IiAM+c/Yjug==
Date: Sat, 5 Oct 2024 03:59:34 +0000
Message-ID: <0120b0d030c14601ba3a19f016615eff@BJMBX01.spreadtrum.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-exchange-transport-fromentityheader: Hosted
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MAIL:SHSQR01.spreadtrum.com 4953xbrx076252

PkZyb206IFpoYW95YW5nIEh1YW5nIDx6aGFveWFuZy5odWFuZ0B1bmlzb2MuY29tPg0KPg0KPlsg
VXBzdHJlYW0gY29tbWl0IDAzZTAyYjk0MTcxYjE5ODVkZDBhYTE4NDI5NmZlOTQ0MjViODU1YTMg
XQ0KPg0KPlRoaXMgcGF0Y2ggaXMgaW5zcGlyZWQgYnkgYSBjb2RlIHJldmlldyBvZiBmcyBjb2Rl
cyB3aGljaCBhaW1zIGF0IGZvbGlvJ3MgZXh0cmENCj5yZWZjbnQgdGhhdCBjb3VsZCBpbnRyb2R1
Y2UgdW53YW50ZWQgYmVoYXZpb3VzIHdoZW4ganVkZ2luZyByZWZjbnQsIHN1Y2gNCj5hc1sxXS5U
aGF0IGlzLCB0aGUgZm9saW8gcGFzc2VkIHRvIG1hcHBpbmdfZXZpY3RfZm9saW8gY2FycmllcyB0
aGUgcmVmY250cyBmcm9tDQo+ZmluZF9sb2NrX2VudHJpZXMsIHBhZ2VfY2FjaGUsIGNvcnJlc3Bv
bmRpbmcgdG8gUFRFcyBhbmQgZm9saW8ncyBwcml2YXRlIGlmIGhhcy4NCj5Ib3dldmVyLCBjdXJy
ZW50IGNvZGUgZG9lc24ndCB0YWtlIHRoZSByZWZjbnQgZm9yIGZvbGlvJ3MgcHJpdmF0ZSB3aGlj
aCBjb3VsZA0KPmhhdmUgbWFwcGluZ19ldmljdF9mb2xpbyBtaXNzIHRoZSBvbmUgdG8gb25seSBQ
VEUgYW5kIGxlYWQgdG8gY2FsbA0KPmZpbGVtYXBfcmVsZWFzZV9mb2xpbyB3cm9uZ2x5Lg0KPg0K
PlsxXQ0KPmxvbmcgbWFwcGluZ19ldmljdF9mb2xpbyhzdHJ1Y3QgYWRkcmVzc19zcGFjZSAqbWFw
cGluZywgc3RydWN0IGZvbGlvICpmb2xpbykNCj57IC4uLg0KPi8vY3VycmVudCBjb2RlIHdpbGwg
bWlzanVkZ2UgaGVyZSBpZiB0aGVyZSBpcyBvbmUgcHRlIG9uIHRoZSBmb2xpbyB3aGljaCBpcyBi
ZQ0KPmRlZW1lZCBhcyB0aGUgb25lIGFzIGZvbGlvJ3MgcHJpdmF0ZQ0KPiAgICAgICAgaWYgKGZv
bGlvX3JlZl9jb3VudChmb2xpbykgPg0KPiAgICAgICAgICAgICAgICAgICAgICAgIGZvbGlvX25y
X3BhZ2VzKGZvbGlvKSArIGZvbGlvX2hhc19wcml2YXRlKGZvbGlvKSArDQo+MSkNCj4gICAgICAg
ICAgICAgICAgcmV0dXJuIDA7DQo+ICAgICAgICBpZiAoIWZpbGVtYXBfcmVsZWFzZV9mb2xpbyhm
b2xpbywgMCkpDQo+ICAgICAgICAgICAgICAgIHJldHVybiAwOw0KPg0KPiAgICAgICAgcmV0dXJu
IHJlbW92ZV9tYXBwaW5nKG1hcHBpbmcsIGZvbGlvKTsgfQ0KPg0KPlNpZ25lZC1vZmYtYnk6IFpo
YW95YW5nIEh1YW5nIDx6aGFveWFuZy5odWFuZ0B1bmlzb2MuY29tPg0KPlNpZ25lZC1vZmYtYnk6
IEFubmEgU2NodW1ha2VyIDxhbm5hLnNjaHVtYWtlckBvcmFjbGUuY29tPg0KPlNpZ25lZC1vZmYt
Ynk6IFNhc2hhIExldmluIDxzYXNoYWxAa2VybmVsLm9yZz4NClNvcnJ5LCB0aGlzIHBhdGNoIHNo
b3VsZCBiZSBkcm9wcGVkIHNpbmNlIFRyb25kIGhhcyBleHBsYWluZWQgdGhhdCB0aGVyZSBpcyBu
byBuZWVkIHRvIGdyYWIgcmVmY250IGhlcmUgYXMgbmZzX3BhZ2UgaGFzIGhvbGQgdGhlIHJlZmNv
dW50IG9uIHRoaXMgZm9saW8uDQo+LS0tDQo+IGZzL25mcy93cml0ZS5jIHwgNiArKy0tLS0NCj4g
MSBmaWxlIGNoYW5nZWQsIDIgaW5zZXJ0aW9ucygrKSwgNCBkZWxldGlvbnMoLSkNCj4NCj5kaWZm
IC0tZ2l0IGEvZnMvbmZzL3dyaXRlLmMgYi9mcy9uZnMvd3JpdGUuYyBpbmRleA0KPmQwNzRkMGNl
YjRmMDEuLjgwYzZkZWQ1Zjc0YzYgMTAwNjQ0DQo+LS0tIGEvZnMvbmZzL3dyaXRlLmMNCj4rKysg
Yi9mcy9uZnMvd3JpdGUuYw0KPkBAIC03NzIsOCArNzcyLDcgQEAgc3RhdGljIHZvaWQgbmZzX2lu
b2RlX2FkZF9yZXF1ZXN0KHN0cnVjdCBuZnNfcGFnZQ0KPipyZXEpDQo+ICAgICAgICBuZnNfbG9j
a19yZXF1ZXN0KHJlcSk7DQo+ICAgICAgICBzcGluX2xvY2soJm1hcHBpbmctPmlfcHJpdmF0ZV9s
b2NrKTsNCj4gICAgICAgIHNldF9iaXQoUEdfTUFQUEVELCAmcmVxLT53Yl9mbGFncyk7DQo+LSAg
ICAgICBmb2xpb19zZXRfcHJpdmF0ZShmb2xpbyk7DQo+LSAgICAgICBmb2xpby0+cHJpdmF0ZSA9
IHJlcTsNCj4rICAgICAgIGZvbGlvX2F0dGFjaF9wcml2YXRlKGZvbGlvLCByZXEpOw0KPiAgICAg
ICAgc3Bpbl91bmxvY2soJm1hcHBpbmctPmlfcHJpdmF0ZV9sb2NrKTsNCj4gICAgICAgIGF0b21p
Y19sb25nX2luYygmbmZzaS0+bnJlcXVlc3RzKTsNCj4gICAgICAgIC8qIHRoaXMgYSBoZWFkIHJl
cXVlc3QgZm9yIGEgcGFnZSBncm91cCAtIG1hcmsgaXQgYXMgaGF2aW5nIGFuIEBADQo+LTc5Nyw4
ICs3OTYsNyBAQCBzdGF0aWMgdm9pZCBuZnNfaW5vZGVfcmVtb3ZlX3JlcXVlc3Qoc3RydWN0IG5m
c19wYWdlDQo+KnJlcSkNCj4NCj4gICAgICAgICAgICAgICAgc3Bpbl9sb2NrKCZtYXBwaW5nLT5p
X3ByaXZhdGVfbG9jayk7DQo+ICAgICAgICAgICAgICAgIGlmIChsaWtlbHkoZm9saW8pKSB7DQo+
LSAgICAgICAgICAgICAgICAgICAgICAgZm9saW8tPnByaXZhdGUgPSBOVUxMOw0KPi0gICAgICAg
ICAgICAgICAgICAgICAgIGZvbGlvX2NsZWFyX3ByaXZhdGUoZm9saW8pOw0KPisgICAgICAgICAg
ICAgICAgICAgICAgIGZvbGlvX2RldGFjaF9wcml2YXRlKGZvbGlvKTsNCj4gICAgICAgICAgICAg
ICAgICAgICAgICBjbGVhcl9iaXQoUEdfTUFQUEVELA0KPiZyZXEtPndiX2hlYWQtPndiX2ZsYWdz
KTsNCj4gICAgICAgICAgICAgICAgfQ0KPiAgICAgICAgICAgICAgICBzcGluX3VubG9jaygmbWFw
cGluZy0+aV9wcml2YXRlX2xvY2spOw0KPi0tDQo+Mi40My4wDQoNCg==


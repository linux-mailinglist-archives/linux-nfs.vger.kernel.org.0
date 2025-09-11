Return-Path: <linux-nfs+bounces-14269-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 38B64B52678
	for <lists+linux-nfs@lfdr.de>; Thu, 11 Sep 2025 04:30:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 67C021C27944
	for <lists+linux-nfs@lfdr.de>; Thu, 11 Sep 2025 02:30:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFC7E2940D;
	Thu, 11 Sep 2025 02:30:30 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from bg1.exmail.qq.com (bg1.exmail.qq.com [114.132.67.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1563F33D8
	for <linux-nfs@vger.kernel.org>; Thu, 11 Sep 2025 02:30:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.132.67.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757557830; cv=none; b=rhG4npa/GyQFwpNCUH1U8DDD4CxguZootzj8ib29mNAJO8UfjIWyc80zpx6Akl1Q5zhlfKiLI1QpbYk/x1oCQIELtCWqMd7sV3p1ZaLgKGVXCx0OrMmeqkhoVTtpYXAyyv6s3IH0RXRS/sUBWI8ozTQ/RR/1T+gNZZ0gkTiAq6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757557830; c=relaxed/simple;
	bh=UFC2Re50m1ANGP34952odKp8nRLRRTJ8RnDl71LkSmU=;
	h=From:To:Subject:Mime-Version:Content-Type:Date:Message-ID; b=X0uO2sakp5mNsv/JSJXfU3s3nyuqhw/ZcsV1asisGY/Lpr2UuGPgJMPrmvCrY2Aw7idyIJBIMiGZOnj8trTiFVZzU7P8KEqJ/nEz8gJPAbnKVL/OxFiJh0RxlUmtTT+zhSCRtr3XyBY8hOJC4vq+P9JTB87zLQTVbSlZImaIP/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinsec.com.cn; spf=pass smtp.mailfrom=kylinsec.com.cn; arc=none smtp.client-ip=114.132.67.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinsec.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinsec.com.cn
EX-QQ-RecipientCnt: 1
X-QQ-GoodBg: 2
X-QQ-SSF: 00400000000000F0
X-QQ-FEAT: D4aqtcRDiqT0lIevWKG+BWOIYOYYzrVdtBspb4IB9XY=
X-QQ-BUSINESS-ORIGIN: 2
X-QQ-Originating-IP: rXElhl60/8THmCcKXtoFHbwQfS75qOoUqb1grc+j3IM=
X-QQ-STYLE: 
X-QQ-mid: lv3sz3a-2t1757557802tb2d32d35
From: "=?utf-8?B?WmhvdSBKaWZlbmc=?=" <zhoujifeng@kylinsec.com.cn>
To: "=?utf-8?B?bGludXgtbmZz?=" <linux-nfs@vger.kernel.org>
Subject: Where Is Dirty Data Flushed During NFSv4 Delegation Recall?
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: base64
Date: Thu, 11 Sep 2025 10:30:02 +0800
X-Priority: 3
Message-ID: <tencent_6A84D2E177043C91217A1CF6@qq.com>
X-QQ-MIME: TCMime 1.0 by Tencent
X-Mailer: QQMail 2.x
X-QQ-Mailer: QQMail 2.x
X-BIZMAIL-ID: 5251748727380581884
X-QQ-SENDSIZE: 520
Received: from qq.com (unknown [127.0.0.1])
	by smtp.qq.com (ESMTP) with SMTP
	id ; Thu, 11 Sep 2025 10:30:03 +0800 (CST)
Feedback-ID: lv:kylinsec.com.cn:qybglogicsvrgz:qybglogicsvrgz5a-0
X-QQ-XMAILINFO: M/NR0wiIuy70vfWZUUG3KWIaloiYrvUFFz6w0JRfVK2P9HoIWGg3luyl
	+CC/ot0uq4Ja/73WlyBUz7Q9+0qlbJNqVgX76GEN1alpTbmx3ml2QInB0MeTzN1U1805O62
	umUXchddwzHucVmu2mpo6WYJknin0a8Rch0MT/DRzyvxnTwgN0+SVUokMVJ3lMGh59Aeksr
	DzYqAMlnVyOWIU5OV6Wv+KszhSncWJdr1lsSKEPkL5SHkAGYPF5R84ZnvfIS0c///ShtSLA
	1raVmiq2jR2fc5UCBmQYxRinlzrYlN20Ml4AaUZ0t6BY347bpTj7Nr9MjZOMf7UHgBa9fX3
	V0gLRBFAVGJZnOLLrDankh+5VZ0aVfSqhkMk92FczhIxLyeqQw1RkSBV/GNkKV8nDPbC9og
	ejDcmTaE71z/MBfhpi6s3+kOMjFhGJLwbGsMpOb1EYhNXJqT3UW97QfXRBSwON81VOFEcSA
	h38wVvjo+HZRNujZ78fmqcQlJB6NBglwHvBdhJ2GsO9oUlzWhqk2zMLRuMEZtlR52d/Yzgx
	FY5YJW92g63gEwSMkXblKuKBzui5GGyGQZ11ShnANNBxSZvs/L+d6yrtjHb+msN9hw7AG/o
	DQzvpjinXUarbTJks2pSO2IrpziajzS92jtsw/MTzAuIZO9qg3/LOl8jC4WLmnt6PcVBEGF
	hNp23SH7R1E8pZF60RpdVWwzGH6O5g0nIfQWZganRc4YWIjMt2C0qy4bCsdw1wrrq7j5ugu
	CxOInYuBn4fTKHGdOjw91QrrY3LvJ0TQ6U2Y1pMJ+8qjyIfFnIuln7M1Zgtle5Ebb1iSNgA
	0749wjg/btaI88F9ep/9tod0bImAxlX+99dDxcs6Ggv5z8Xy6fH8K7vere3e1jNS86a+xkB
	iv2FQd3FECvb287LE2aV0MAQyGE7goVz6G9NCMHuypJK9XF7D8wie2eBxj3AHzDzwRnUXDv
	Z1MiWhMSzERHszEaEDberg6B674rz473pHODQX/K87h/TQtJLEKmA2cDxSP39Kjf+KVg9R+
	fXRBVWbA==
X-QQ-XMRINFO: OWPUhxQsoeAVDbp3OJHYyFg=
X-QQ-RECHKSPAM: 0

SGVsbG8gZXZlcnlvbmUsIEkgaGF2ZSBhIHF1ZXN0aW9uIHRoYXQgaGFzIGJlZW4gYm90aGVy
aW5nIG1lIGZvciBhIGxvbmcNCiB0aW1lLiBJIHdvdWxkIGxpa2UgdG8gYXNrIGEgZmFtaWxp
YXIgZnJpZW5kIHRvIGhlbHAgZXhwbGFpbiBpdC4gSW4gdGhlIE5GU3Y0DQogcHJvdG9jb2ws
IGl0IGlzIGNsZWFybHkgZGVmaW5lZCB0aGF0IGR1cmluZyB0aGUgZGVsZWdhdGlvbiBSRUNB
TEwgDQpwcm9jZXNzaW5nLCB0aGUgY2xpZW50IG5lZWRzIHRvIHdyaXRlIHRoZSBtb2RpZmll
ZCBjYWNoZSB0byB0aGUgc2VydmVyDQpzaWRlLiBIb3dldmVyLCB0aHJvdWdob3V0IHRoZSBw
cm9jZXNzLCBJIGhhdmUgbm90IGZvdW5kIHRoZSBjb2RlIGZvcg0KZmx1c2hpbmcgZGlydHkg
ZGF0YSBpbiB0aGUga2VybmVsIE5GUyBjbGllbnQuIEkgaGF2ZSByZXBlYXRlZGx5IHJldmll
d2VkDQp0aGUgY29kZSBsb2dpYyBvZiBuZnM0X2NhbGxiYWNrX3JlY2FsbCBhbmQgbmZzNF9z
dGF0ZV9tYW5hZ2VyLCBidXQgc3RpbGwNCmNhbm5vdCB1bmRlcnN0YW5kIHdoZXJlIHRoZSBk
aXJ0eSBkYXRhIGlzIGZsdXNoZWQuDQoNCk15IHF1ZXN0aW9uIGlzOiBXaGVuIHRoZSBjbGll
bnQgaXMgaGFuZGxpbmcgdGhlIFJFQ0FMTCBvcGVyYXRpb24sIHdoZXJlDQpkb2VzIHRoZSBw
cm9jZXNzIG9mIGZsdXNoaW5nIHRoZSBkaXJ0eSBkYXRhIHRha2UgcGxhY2U/DQoNCkJlc3Qg
cmVnYXJkcw==



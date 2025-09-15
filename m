Return-Path: <linux-nfs+bounces-14414-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EA7A5B57800
	for <lists+linux-nfs@lfdr.de>; Mon, 15 Sep 2025 13:24:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 70CA81A24A9E
	for <lists+linux-nfs@lfdr.de>; Mon, 15 Sep 2025 11:24:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 696DC2727F5;
	Mon, 15 Sep 2025 11:24:02 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtpbguseast1.qq.com (smtpbguseast1.qq.com [54.204.34.129])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BE672309B2
	for <linux-nfs@vger.kernel.org>; Mon, 15 Sep 2025 11:23:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.204.34.129
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757935442; cv=none; b=SmaNHTvVSMGxgzmDD3j7aYhopW7oQNcmSgs7wZqQvWb1z4BcX9NTFmmuO5mAE5W2bShpDzVf2EDYD6FztHHhn0mggrhYmEEB8NN+647tkLoql5QSgxRQG6qracnePOMSXO/RIbx0LDtlnIKCzn63rdTzDNTLTSF0zqREXrSeHvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757935442; c=relaxed/simple;
	bh=BcINFPRy603dJTm2E3pz5Gn4YM9OqnpLRT8nDKRJvbU=;
	h=From:To:Subject:Mime-Version:Content-Type:Date:Message-ID:
	 References:In-Reply-To; b=knSI3RphsKrbICvoTIvIyomnk5s+BOhBjpa5ZfaqG33ndNTXIV+P/OPQ+V0qhtUXCvUp0YD8JBQiN0Clqw7m5zzRXNjspocYoOkSvs4m0OOf9IfrtZFYpp0e2fkrc45AfUwTogjfocp9DUDK3iZb8eumjjnk8swmpeKqXw6eqdQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinsec.com.cn; spf=pass smtp.mailfrom=kylinsec.com.cn; arc=none smtp.client-ip=54.204.34.129
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinsec.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinsec.com.cn
EX-QQ-RecipientCnt: 2
X-QQ-GoodBg: 2
X-QQ-SSF: 00400000000000F0
X-QQ-FEAT: D4aqtcRDiqT0lIevWKG+BVnbhYYmM7POEhOP+T0DEcs=
X-QQ-BUSINESS-ORIGIN: 2
X-QQ-Originating-IP: f/E7t24yPFWFi23BRFFzZXVhY9pdZ1ROFvbqHx1/gQY=
X-QQ-STYLE: 
X-QQ-mid: lv3sz3a-2t1757935417t9b3709db
From: "=?utf-8?B?WmhvdSBKaWZlbmc=?=" <zhoujifeng@kylinsec.com.cn>
To: "=?utf-8?B?VHJvbmQgTXlrbGVidXN0?=" <trondmy@kernel.org>, "=?utf-8?B?bGludXgtbmZz?=" <linux-nfs@vger.kernel.org>
Subject: Re: Where Is Dirty Data Flushed During NFSv4 Delegation Recall?
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: base64
Date: Mon, 15 Sep 2025 19:23:37 +0800
X-Priority: 3
Message-ID: <tencent_5E75DDE36B411AAC6D6C761D@qq.com>
X-QQ-MIME: TCMime 1.0 by Tencent
X-Mailer: QQMail 2.x
X-QQ-Mailer: QQMail 2.x
References: <tencent_6A84D2E177043C91217A1CF6@qq.com>
	<3729660588543ff1d8c0b3c014948559b158cdad.camel@kernel.org>
In-Reply-To: <3729660588543ff1d8c0b3c014948559b158cdad.camel@kernel.org>
X-QQ-ReplyHash: 1121162023
X-BIZMAIL-ID: 6278790173318563069
X-QQ-SENDSIZE: 520
Received: from qq.com (unknown [127.0.0.1])
	by smtp.qq.com (ESMTP) with SMTP
	id ; Mon, 15 Sep 2025 19:23:38 +0800 (CST)
Feedback-ID: lv:kylinsec.com.cn:qybglogicsvrgz:qybglogicsvrgz5a-0
X-QQ-XMAILINFO: M9MQJ5rX40WKfUSZ44A/r6r4ZTQDbg8OuT+nQeOuwVGpjcFLnS7e4yRz
	NFJPmGnI5H5JNFfvIEzFtAirwao+fRSThY0+p+fScjub/NgLOXFRYpENNSpxPTMuwdSjZrb
	/5UibiYPjGJ0mI8Mu/sG6Y5ZbX6TdLymNoxRLbUjuJf8Q2awSIQP6pnxRjzKrMPfNxzv6Oi
	cMYq9DN1lPlnscj9ALurqeRFXF+JpS6mdKuqd4bbWIosW3ExaVdLYEdRRA4H3wnePnIQbzB
	WKIyYEjnpVFYELFaywrwV3z5IY5CRmngz1DYX5wWwVlqzprFVZBm4v/uuqu9zc4ZRCd8BMK
	goIH5A3xYbXsAuNxbdZIox6NXt9z4NpVkaq7wjAGWn3V+m0L0uLdvewGqJXcsLchvykJWrS
	w83bRvGxrSwQYB1Ly6bgiY+s/QzZq2+8VUZQHeaZhd4WwnLwe2AGBG6GSFSWu/Ya6Gb1v+G
	6xMeBedLhO0/3A783TY03F2f0aS6taby8Mqhyc8iQROUrdFLBCBjdfGr9saejbqseoGLnWQ
	fjw8YyrLhQPU+F2gfTTB+vlwsYuWjcnGxEYepcvO18ctadusd0FgY5FJ6dUvADseqyeUo5e
	CQgJ4j3EJyYxQIMGEOhJCtwL6nHuaqMwnKOXa3wqO9N03bN3aI9EhWaBfLomY1DGOIgnHIQ
	mt9bXVWtYxJKPdAMJL95F6xMdBsQMPytwhbf2ANMlCQIoQgI5lKu7Y0ShNqfHbdfzMkyGNO
	T3qMbvdF09UiV4MGwg6KWdxlVYEb5/N0LezJEYjwFxeLoQ6OzE/Qq7ILAdlkNhkQ7eYiAI0
	wF0drMZo+nbkqnVKEkew+jqopjPGTgE5jU1E/txcBYCTXIqKniXE30/revw6An131UUJ1dY
	4okJv0nCls80pzNzvwSQYBCYar77oY2tbsUECqv6BC+IcWDjTqm2bI53Bkj3e38uOR7iQ3L
	R3gfYwH/qWmCJZX+gZQdt54+/MkdDDKhyPP0iCiSGm6vKtqbrO3eqnm8EgUmniuvnFXz93p
	+mLU8gFW5zEEEIke4BK8DAWGHaQ85s5iy/lvQ/zQ==
X-QQ-XMRINFO: OWPUhxQsoeAVDbp3OJHYyFg=
X-QQ-RECHKSPAM: 0

PiA+IE9uIFRodSwgMjAyNS0wOS0xMSBhdCAxMDozMCArMDgwMCwgWmhvdSBKaWZlbmcgd3Jv
dGU6DQo+ID4gSGVsbG8gZXZlcnlvbmUsIEkgaGF2ZSBhIHF1ZXN0aW9uIHRoYXQgaGFzIGJl
ZW4gYm90aGVyaW5nIG1lIGZvciBhDQo+ID4gbG9uZw0KPiA+ICB0aW1lLiBJIHdvdWxkIGxp
a2UgdG8gYXNrIGEgZmFtaWxpYXIgZnJpZW5kIHRvIGhlbHAgZXhwbGFpbiBpdC4gSW4NCj4g
PiB0aGUgTkZTdjQNCj4gPiAgcHJvdG9jb2wsIGl0IGlzIGNsZWFybHkgZGVmaW5lZCB0aGF0
IGR1cmluZyB0aGUgZGVsZWdhdGlvbiBSRUNBTEwNCj4gPiBwcm9jZXNzaW5nLCB0aGUgY2xp
ZW50IG5lZWRzIHRvIHdyaXRlIHRoZSBtb2RpZmllZCBjYWNoZSB0byB0aGUNCj4gPiBzZXJ2
ZXINCj4gPiBzaWRlLiBIb3dldmVyLCB0aHJvdWdob3V0IHRoZSBwcm9jZXNzLCBJIGhhdmUg
bm90IGZvdW5kIHRoZSBjb2RlIGZvcg0KPiA+IGZsdXNoaW5nIGRpcnR5IGRhdGEgaW4gdGhl
IGtlcm5lbCBORlMgY2xpZW50LiBJIGhhdmUgcmVwZWF0ZWRseQ0KPiA+IHJldmlld2VkDQo+
ID4gdGhlIGNvZGUgbG9naWMgb2YgbmZzNF9jYWxsYmFja19yZWNhbGwgYW5kIG5mczRfc3Rh
dGVfbWFuYWdlciwgYnV0DQo+ID4gc3RpbGwNCj4gPiBjYW5ub3QgdW5kZXJzdGFuZCB3aGVy
ZSB0aGUgZGlydHkgZGF0YSBpcyBmbHVzaGVkLg0KPiA+DQo+ID4gTXkgcXVlc3Rpb24gaXM6
IFdoZW4gdGhlIGNsaWVudCBpcyBoYW5kbGluZyB0aGUgUkVDQUxMIG9wZXJhdGlvbiwNCj4g
PiB3aGVyZQ0KPiA+IGRvZXMgdGhlIHByb2Nlc3Mgb2YgZmx1c2hpbmcgdGhlIGRpcnR5IGRh
dGEgdGFrZSBwbGFjZT8NCj4gPg0KPiANCj4gVGhlIHF1ZXN0aW9uIG9mIHdoZW4gdG8gZmx1
c2ggZGlydHkgZGF0YSBpc24ndCBkZXRlcm1pbmVkIGJ5IHRoZSBORlN2NA0KPiBSRUNBTEwg
b3BlcmF0aW9uIHNwZWMuIEl0IGlzIGRlY2lkZWQgYnkgdGhlIGNsaWVudCBjYWNoaW5nIG1v
ZGVsIGFuZCBieQ0KPiBQT1NJWC4NCj4gUGxlYXNlIHJlYWQgdGhlICJuZnMoNSkiIG1hbnBh
Z2UgYW5kIHRoZSBzZWN0aW9uIG9uIGNsb3NlLXRvLW9wZW4gY2FjaGUNCj4gY29uc2lzdGVu
Y3kuDQo+IA0KLT4gLQ0KPiBUcm9uZCBNeWtsZWJ1c3QNCj4gTGludXggTkZTIGNsaWVudCBt
YWludGFpbmVyLCBIYW1tZXJzcGFjZQ0KPiB0cm9uZG15QGtlcm5lbC5vcmcsIHRyb25kLm15
a2xlYnVzdEBoYW1tZXJzcGFjZS5jb20NCg0KSGkgVHJvbmQsDQoNClRoZSBuZnMoNSkgbWFu
dWFsIHBhZ2UgYW5kIHRoZSBjbG9zZS10by1vcGVuIGNvbnNpc3RlbmN5IHlvdSBtZW50aW9u
ZWQNCmhhdmUgYmVlbiBvZiBncmVhdCBoZWxwIHRvIG15IHVuZGVyc3RhbmRpbmcuIFRoYW5r
IHlvdSB2ZXJ5IG11Y2guDQoNCkJlc3QgcmVnYXJkcw0KWmhvdSBKaWZlbmc=



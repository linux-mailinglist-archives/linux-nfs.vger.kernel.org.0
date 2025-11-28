Return-Path: <linux-nfs+bounces-16774-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id BFDB7C911DA
	for <lists+linux-nfs@lfdr.de>; Fri, 28 Nov 2025 09:13:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 40AFA4E4398
	for <lists+linux-nfs@lfdr.de>; Fri, 28 Nov 2025 08:12:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 958CA299A81;
	Fri, 28 Nov 2025 08:12:44 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtpbguseast2.qq.com (smtpbguseast2.qq.com [54.204.34.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62DA42D47E4
	for <linux-nfs@vger.kernel.org>; Fri, 28 Nov 2025 08:12:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.204.34.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764317564; cv=none; b=FLEO3u8aNgHoJrgusD4RMd02U8XQiXh8zj2anEE1tYRbbM0eH31/ng8Qk/ux/C/hhDZjnmzIHepv0GH/VHB6UotumUI9WBtmj9o/etJDQMjvY96Tdwmzmv3aDXK3eabaKsu5PuNOTAq0etLivQn1yiLnKzS999iBp5RbM7nfrbs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764317564; c=relaxed/simple;
	bh=G8m7O8/IUufW3w1oIFn8unvm1l/4QBQERveNY4blHso=;
	h=From:To:Subject:Mime-Version:Content-Type:Date:Message-ID:
	 References:In-Reply-To; b=iHm/kfPowANcyJsidPx9Z+Hpo703C6pAw5olhGL/2eWE82axXhIitmGjGVQcq1PhEF6xe2QRDY/KgqPoGOnY3O74wFIUP0PkNcFOsNonN9K3HoCpLM57k2pMQ5RbhwiuKLpD10bdXUaPsSMeh/X8ubJkjmGjSziDPZTg+Rqvgxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinsec.com.cn; spf=pass smtp.mailfrom=kylinsec.com.cn; arc=none smtp.client-ip=54.204.34.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinsec.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinsec.com.cn
EX-QQ-RecipientCnt: 2
X-QQ-GoodBg: 2
X-QQ-SSF: 00400000000000F0
X-QQ-FEAT: D4aqtcRDiqSYbfq2fqToiGQ640EZkclUqGZucf6tfws=
X-QQ-BUSINESS-ORIGIN: 2
X-QQ-Originating-IP: qOys83KXoJtR+nyPeyT48TOHwxhbnmsYqaM04L34kuY=
X-QQ-STYLE: 
X-QQ-mid: v3gz7b-10t1764317534t9bc0f44a
From: "=?utf-8?B?WmhvdSBKaWZlbmc=?=" <zhoujifeng@kylinsec.com.cn>
To: "=?utf-8?B?Q2h1Y2sgTGV2ZXI=?=" <cel@kernel.org>, "=?utf-8?B?bGludXgtbmZz?=" <linux-nfs@vger.kernel.org>
Subject: Re: Can the PNFS blocklayout of the Linux nfsd server be used in a production environment?
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: base64
Date: Fri, 28 Nov 2025 16:12:14 +0800
X-Priority: 3
Message-ID: <tencent_013D77524EB6303F7D357E60@qq.com>
X-QQ-MIME: TCMime 1.0 by Tencent
X-Mailer: QQMail 2.x
X-QQ-Mailer: QQMail 2.x
References: <tencent_780E66F24A209F467917744D@qq.com>
	<5e1b3d07-fd80-47d0-bbf8-726d1f01ba54@app.fastmail.com>
In-Reply-To: <5e1b3d07-fd80-47d0-bbf8-726d1f01ba54@app.fastmail.com>
X-QQ-ReplyHash: 91489951
X-BIZMAIL-ID: 2953687902439926476
X-Address-Ticket:version=;type=;ticket_id=;id_list=;display_name=;session_id=;
X-QQ-SENDSIZE: 520
Received: from qq.com (unknown [127.0.0.1])
	by smtp.qq.com (ESMTP) with SMTP
	id ; Fri, 28 Nov 2025 16:12:15 +0800 (CST)
Feedback-ID: v:kylinsec.com.cn:qybglogicsvrsz:qybglogicsvrsz3b-0
X-QQ-XMAILINFO: NSEFX6u+4l+KSJqwchIsjSSmCzwt6qK930ehJakvMFkE+WJaEO7URQZM
	ZYGCIARV6P2HCvMaWfP9oh5L2K7Ars9t85D7Vl625uP6O3HsW9hGH1YJewezuC/vz18iX2Z
	5f+Q7XOurSMHqtF3Aflwy6Sw+0hlsuvCyVKrR1QeQwIybLfxL3Jcsw8z2sGVwOkKCsZnVrP
	yaaOHfvNBP6EBH2lIc2zjo0HL5zvizibSGaJVei86T6yWp/j+vVY/zHRUErtmXT21g2mKyM
	oUeZcPq/ox1qUezfT6EvBzxevzTKw5CNnpn8IxNojsmNWG7hsxW8jiq3Q05Bcg/OqE4XxnZ
	Vdn9S9dOEDHKDUF+Dj6p2MlA2JhIDdCctXBaHq9fVynEaUhRPhF9SFOnSstSXOPw5gm439t
	DFMbQN4a1uBstI/lpFpVYU1US57r+wl0faeMfqMXXfbiF6uodL5uFoJ7NRGI0aEYitdws6l
	Kn3Ibd71on0azU6KBMOeQITj+qZb0ILF7PlWKzEnx/H5KV4ZZsR9sIrF1H4WJjpC9VJSK+K
	g3yUG9kl6ri95mF36LmbQzROLLlZCkexPBltMb9Zt+RRRFZzON7oLAcRjxxE08j2t0jevWY
	Tnw0FDV1BLIt6zIO6dGtItNJ3cK4voo4hBRxCdhOrOzwVjowZR6gA6FI/gZOgxERj3yLy8L
	2irS0Sqgiqg3zbO0XSuoAq/DFeBd4KVo84/oxpd8tU7rNP3K5HsYCLZqKLetpIQvUqhUw/h
	2rr8WtsECfEBH3hSbJOEMmDgOuXF3r5Znbs3twUpIqcMD5cdXtsWFRMBrCah7jSUlVHRASp
	n/ozk8BrDlueGdG3NqLgOgsMgtyIvDYQaw/OppV5Y0iPThyP2RFXCljwI8u9TbcdbYr6noh
	fXcidrKPhb7b2LzUyYCnyf2pdggS5dExVQfTC5Zx2b5DxDGgVJhfO16qYU7dzrF6ZkhAzYN
	99zNRmWpfbjACZPcZg4k5p3GZYqQD4IWMSgRc1A61+ruUe2H6NBNozMXqf1zfRfvBE22kQF
	cbbMKZMp0uVwZXRk0t
X-QQ-XMRINFO: Mp0Kj//9VHAxr69bL5MkOOs=
X-QQ-RECHKSPAM: 0

Pj5PbiBXZWQsIE5vdiAyNiwgMjAyNSwgYXQgOToxNCBQTSwgWmhvdSBKaWZlbmcgd3JvdGU6
DQo+PiBIZWxsbyBldmVyeW9uZSwgSSBsZWFybmVkIHRocm91Z2ggQ2hhdEdQVCB0aGF0IHRo
ZSBQTkZTIGJsb2NrbGF5b3V0IG9mIExpbnV4DQo+PiBuZnNkIGNhbm5vdCBiZSB1c2VkIGZv
ciBwcm9kdWN0aW9uIGVudmlyb25tZW50IGRlcGxveW1lbnQuIEhvd2V2ZXIsIEkgc2F3DQo+
PiBhIHRlY2huaWNhbCBzaGFyaW5nIGNvbmZlcmVuY2UgdmlkZW8gb24gWW91VHViZSB0aXRs
ZWQgIlNOSUEgU0RDIDIwMjQgLSBUaGUNCj4+IExpbnV4IE5GUyBTZXJ2ZXIgaW4gMjAyNCIg
d2hlcmUgaXQgd2FzIG1lbnRpb25lZCB0aGF0IHRoZSBQTkZTIGJsb2NrbGF5b3V0DQo+PiBv
ZiBuZnNkIGhhcyBiZWVuIGZ1bGx5IG1haW50YWluZWQsIHdoaWNoIGlzIGNvbnRyYXJ5IHRv
IHRoZSByZXN1bHQgZ2l2ZW4gYnkNCj4+IENoYXRHUFQuDQo+Pg0KPj4gTXkgcXVlc3Rpb24g
aXM6IENhbiB0aGUgUE5GUyBibG9ja2xheW91dCBvZiBuZnNkIGJlIHVzZWQgZm9yDQo+PiBw
cm9kdWN0aW9uIGVudmlyb25tZW50IGRlcGxveW1lbnQ/IElmIHllcywgZnJvbSB3aGljaCBr
ZXJuZWwgdmVyc2lvbiBjYW4gaXQNCj4+IGJlIHVzZWQgaW4gdGhlIHByb2R1Y3Rpb24gZW52
aXJvbm1lbnQ/DQo+DQo+IFJlc3BvbmRpbmcgYXMgdGhlIHByZXNlbnRlciBvZiB0aGUgU05J
QSBTREMgdGFsazoNCj4gDQo+IFRoZXJlJ3MgYSBkaWZmZXJlbmNlIGJldHdlZW4gIm1haW50
YWluZWQiIGFuZCAiY2FuIGJlIGRlcGxveWVkIGluIGENCj4gcHJvZHVjdGlvbiBlbnZpcm9u
bWVudCIuICJNYWludGFpbmVkIiBtZWFucyB0aGVyZSBhcmUgZGV2ZWxvcGVycw0KPiB3aG8g
YXJlIGFjdGl2ZSBhbmQgY2FuIGhlbHAgd2l0aCBidWdzIGFuZCBuZXcgZmVhdHVyZXMuICJQ
cm9kdWN0aW9uDQo+IHJlYWR5IiBtZWFucyB5b3UgY2FuIHRydXN0IGl0IHdpdGggc2lnbmlm
aWNhbnQgd29ya2xvYWRzLg0KPiANCj4gVGhlIHBORlMgYmxvY2sgbGF5b3V0IHR5cGUgaGFz
IHNldmVyYWwgc3VidHlwZXMuIFB1cmUgYmxvY2ssIGlTQ1NJLA0KPiBTQ1NJLCBhbmQgTlZN
ZS4NCj4gDQo+IFB1cmUgYmxvY2sgaGFzIHNvbWUgcHJvdG9jb2wgZGVmaWNpZW5jaWVzIHRo
YXQgcHJldmVudCB0aGUgYWJpbGl0eQ0KPiBvZiB0aGUgTURTIHRvIGZlbmNlIHBORlMgY2xp
ZW50cywgc28gaXQgbWlnaHQgbmV2ZXIgYmUgcHJvZHVjdGlvbg0KPiByZWFkeS4NCj4gDQo+
IE5GU0QncyBwTkZTIGJsb2NrIGxheW91dCB3aXRoIGlTQ1NJIG9yIFNDU0kgd29ya3Mgd2Vs
bCBpbiByZWNlbnQNCj4ga2VybmVscywgYnV0IGhhcyBzb21lIHF1aXJrcyB0aGF0IHN0aWxs
IG5lZWQgdG8gYmUgYWRkcmVzc2VkLiBZb3UNCj4gd2lsbCBoYXZlIHRvIHRlc3QgaXQgd2l0
aCB5b3VyIGZhdm9yaXRlIHdvcmtsb2FkcyB0byBzZWUgd2hldGhlcg0KPiBpdCB3aWxsIHdv
cmsgZm9yIHlvdS4NCj4gDQo+IE5GU0QncyBwTkZTIGJsb2NrIGxheW91dCB3aXRoIE5WTWUg
aW1wbGVtZW50YXRpb24gaXMgZnJlc2ggZnJvbSB0aGUNCj4gZmFjdG9yeSAoSSB0aGluayB0
aGUgaW1wbGVtZW50YXRpb24gd2VudCBpbnRvIHY2LjEyPykuIEFzIHdpdGgNCj4gaVNDU0kv
U0NTSSwgdHJ5IGl0IGFuZCBzZWUgaWYgaXQgd29ya3Mgd2VsbCBlbm91Z2ggZm9yIHlvdS4N
Cj4gDQo+IA0KPiAtLQ0KPiBDaHVjayBMZXZlcg0KDQpIaSBDaHVjaywNCg0KSSdtIHRydWx5
IGhvbm9yZWQgdG8gcmVjZWl2ZSB5b3VyIHBlcnNvbmFsIHJlc3BvbnNlLCB3aGljaCBoYXMg
YmVlbiANCmV4dHJlbWVseSBoZWxwZnVsIHRvIG1lLiBJJ3ZlIHNlYXJjaGVkIGV4dGVuc2l2
ZWx5IG9ubGluZSBmb3IgbWV0aG9kcyANCnRvIGRlcGxveSBwTkZTIGNsdXN0ZXJzIHdpdGgg
bmZzZCwgYnV0IG1vc3QgcmVzb3VyY2VzIGFyZSBpbmNvbXBsZXRlLiANClRoZSBkb2N1bWVu
dGF0aW9uIGF0IA0KImh0dHBzOi8vZG9jcy5rZXJuZWwub3JnL2FkbWluLWd1aWRlL25mcy9w
bmZzLWJsb2NrLXNlcnZlci5odG1sIiBhbHNvIA0KcHJvdmlkZXMgdmVyeSBsaW1pdGVkIGlu
Zm9ybWF0aW9uLiBBcmUgdGhlcmUgYW55IG9mZmljaWFsLCBtb3JlIA0KY29tcHJlaGVuc2l2
ZSBkZXBsb3ltZW50IGd1aWRlcyBmb3IgcE5GUyBhdmFpbGFibGUuDQoNCkJlc3QgcmVnYXJk
cywNClpob3VKaWZlbmc=



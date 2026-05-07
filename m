Return-Path: <linux-nfs+bounces-21415-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ODerJtrh+2lGGwAAu9opvQ
	(envelope-from <linux-nfs+bounces-21415-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Thu, 07 May 2026 02:50:34 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EAF614E1C4E
	for <lists+linux-nfs@lfdr.de>; Thu, 07 May 2026 02:50:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 60F2C301EB7C
	for <lists+linux-nfs@lfdr.de>; Thu,  7 May 2026 00:50:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 476CC17A309;
	Thu,  7 May 2026 00:50:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=supcon.com header.i=@supcon.com header.b="E+GrwHh7"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail.supcon.com (mail.supcon.com [218.75.124.151])
	by smtp.subspace.kernel.org (Postfix) with SMTP id 8547A14A4CC;
	Thu,  7 May 2026 00:50:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=218.75.124.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778115031; cv=none; b=si/rdBI7sg0tG/xgwAGKadzOM67C09MqAlpoXxs8yL6UgeQqtWalF/AX38ob/pldEG8ENPesTJFmvumgmKiIQplu5SEyPkpmaPkoM9Ayg/+rgCSYOSOaJLDp1V+0DHCIsGr9w6EJLapsl+Z4j+zZJAAfsmMaMRENQJga9myziZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778115031; c=relaxed/simple;
	bh=NEBTtLliGL2ISJBIPAkF4wJHArMuubYdfzl7zEUK/X8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:Content-Type:MIME-Version:
	 Message-ID; b=sMvqc4G28vp9AgpjA/4J6i/g+8rhH94agaHdFmWt/lHwCVEJ/jVAqImACHQWSYhmiAYexOyJY3ocZ5hVy3CAZUj/9ICjSd99vVlX6LLp9hUKBEjA/Jl90DFHFSxDI5NpHkSXYL7lQOeOsPul/BVrKGNcokX0Wy1DKTgu/2UVHp8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=supcon.com; spf=pass smtp.mailfrom=supcon.com; dkim=pass (1024-bit key) header.d=supcon.com header.i=@supcon.com header.b=E+GrwHh7; arc=none smtp.client-ip=218.75.124.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=supcon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=supcon.com
Received: from maildata.cn (unknown [10.32.1.145])
	by mail.supcon.com (MailData Gateway V2.8.8) with SMTP id 4CBAD6A74BA;
	Thu,  7 May 2026 08:50:25 +0800 (CST)
Received: from supcon.com (unknown [10.32.1.229])
	by mdau02 (MailData Audit V3.4.6) with ESMTP id 41996217142B4;
	Thu,  7 May 2026 08:50:24 +0800 (CST)
XMD-OLD-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=supcon.com; s=dkim; h=Received:Date:From:To:Cc:Subject:
	In-Reply-To:References:Content-Transfer-Encoding:Content-Type:
	MIME-Version:Message-ID; bh=A8x5+S1JqGQgiZIC0m1R/cGH43J0hJYunSOt
	i5NL/Tw=; b=i28Y8JBfXmWUc0BBgI6UxqTJ5iFBVBYEuKNT6fPgU+WjCJc8f+YS
	a9KuUWT9vl9IBTvn/A5vMZs9cn9/rEVDvwZ16QQE6ZBx7iLq4Fm+cjxYxi3EtaET
	FiRB5oPn1tO4WBoel5gtSrfLrXVaEAISi74gvnh7vXPOccLLRtLMdTQ=
Received: from guolingxing$supcon.com ( [10.30.28.7] ) by ajax-webmail-app1
 (Coremail) ; Thu, 7 May 2026 08:50:23 +0800 (GMT+08:00)
Date: Thu, 7 May 2026 08:50:23 +0800 (GMT+08:00)
X-CM-HeaderCharset: UTF-8
X-MD-FileKey: 1a4c8919f9d4cb385dd5d662beb22673[#]a074b8acf31a918fc85c238de2117422
X-MD-Sfrom: guolingxing@supcon.com
X-MD-SrcIP: 10.32.1.145
From: =?UTF-8?B?6YOt546y5YW0?= <guolingxing@supcon.com>
To: "Lionel Cons" <lionelcons1972@gmail.com>
Cc: linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: Re: [BUG] NFSv4.1 client hang in nfs4_drain_slot_tbl under
 concurrent workload against Windows NFS server
X-Priority: 3
X-Mailer: Coremail Webmail Server Version 2024.3-cmXT6 build
 20250609(354f7833) Copyright (c) 2002-2026 www.mailtech.cn
 mispb-27421bd6-c70e-4259-88e7-36dce31e831d-supcon.com
In-Reply-To: <CAPJSo4Xu8ZRmL8dbhW7PQVV0tpADKLOpfzUL-TgTCR1bgg2fEQ@mail.gmail.com>
Content-Transfer-Encoding: base64
X-CM-CTRLDATA: fue5JmZvb3Rlcl90eHQ9MTUwNToxMA==
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <19b5fe04.1a5ac.19dffea136b.Coremail.guolingxing@supcon.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID:5QEgCgAH9zfP4ftp88_KAQ--.5418W
X-CM-SenderInfo: xjxrzxpqj0x0nj6v31xfrqhudrp/1tbiAQETBmn6BvmMZwABsT
X-Coremail-Antispam: 1Ur529EdanIXcx71UUUUU7IcSsGvfJ3iIAIbVAYjsxI4VWxJw
	CS07vEb4IE77IF4wCS07vE1I0E4x80FVAKz4kxMIAIbVAFxVCaYxvI4VCIwcAKzIAtYxBI
	daVFxhVjvjDU=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=supcon.com; s=default;
	t=1778115026; bh=NEBTtLliGL2ISJBIPAkF4wJHArMuubYdfzl7zEUK/X8=;
	h=Date:From:To:Cc:Subject:Content-Type:Message-ID;
	b=E+GrwHh70uPxposokeOmqxcGOM73ATu8Vl9Ec3T/Vp/S5PI3Wx/7ERd++HWGbvnTg
	 xkeCWWUV+m/H4U3lpTzGkA2oUcj2hI/Z9qgiINaWXScDRxCYeu481Qwx/h2VIiGIp9
	 DhWMKjV5PPPvNZxDkFCIHomcoyLONBsjia2gNO78=
X-Rspamd-Queue-Id: EAF614E1C4E
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.56 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64];
	R_DKIM_ALLOW(-0.20)[supcon.com:s=default];
	MAILLIST(-0.15)[generic];
	MIME_BASE64_TEXT(0.10)[];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-21415-lists,linux-nfs=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[supcon.com];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[supcon.com:+];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[guolingxing@supcon.com,linux-nfs@vger.kernel.org];
	HAS_X_PRIO_THREE(0.00)[3];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-nfs];
	RCPT_COUNT_THREE(0.00)[3];
	TO_DN_SOME(0.00)[]
X-Rspamd-Action: no action

SGkgTGlvbmVsLAoKVGhhbmtzIGZvciB5b3VyIHJlc3BvbnNlLgoKSGVyZSBhcmUgdGhlIGRldGFp
bHM6CgoxLiBXaW5kb3dzIFNlcnZlciB2ZXJzaW9uOgpNaWNyb3NvZnQgV2luZG93cyBTZXJ2ZXIg
MjAyMgpWZXJzaW9uIDEwLjAuMjAzNDguNTg3CgoyLiBVc2VyIGFjY291bnRzOgpObyBtYXBwaW5n
IG1lY2hhbmlzbSBpcyBjb25maWd1cmVkLgpObyBBRCwgTERBUCwgb3IgcGFzc3dkIG1hcHBpbmcg
aXMgdXNlZC4KClVubWFwcGVkIHVzZXJzIGFyZSBoYW5kbGVkIGJ5IHRoZSBkZWZhdWx0ICJFdmVy
eW9uZSIgYWNjb3VudC4KCjMuIEF1dGhlbnRpY2F0aW9uOgpzZWM9c3lzIChBVVRIX1NZUyksIGFz
IHJlcG9ydGVkIGJ5IG5mc3N0YXQgLW0KCjQuIENQVSBhcmNoaXRlY3R1cmU6Ci0gTGludXggY2xp
ZW50czogeDg2XzY0Ci0gV2luZG93cyBzZXJ2ZXI6IHg4Nl82NCAoNjQtYml0IE9TKQoKNS4gTWVt
b3J5OgpFYWNoIExpbnV4IGNsaWVudCBWTSBoYXMgMTZHQiBSQU0KClRoYW5rcy4KCgo+IC0tLS0t
5Y6f5aeL6YKu5Lu2LS0tLS0KPiDlj5Hku7bkuro6ICJMaW9uZWwgQ29ucyIgPGxpb25lbGNvbnMx
OTcyQGdtYWlsLmNvbT4KPiDlj5HpgIHml7bpl7Q6MjAyNi0wNS0wNiAyMToyODozMyAo5pif5pyf
5LiJKQo+IOaUtuS7tuS6ujog6YOt546y5YW0IDxndW9saW5neGluZ0BzdXBjb24uY29tPiwgbGlu
dXgtbmZzQHZnZXIua2VybmVsLm9yZywgbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZwo+IOS4
u+mimDogUmU6IFtCVUddIE5GU3Y0LjEgY2xpZW50IGhhbmcgaW4gbmZzNF9kcmFpbl9zbG90X3Ri
bCB1bmRlciBjb25jdXJyZW50IHdvcmtsb2FkIGFnYWluc3QgV2luZG93cyBORlMgc2VydmVyCj4g
Cj4gT24gV2VkLCA2IE1heSAyMDI2IGF0IDA5OjQ5LCDpg63njrLlhbQgPGd1b2xpbmd4aW5nQHN1
cGNvbi5jb20+IHdyb3RlOgo+ID4KPiA+IEhpLAo+ID4KPiA+Cj4gPiBXZSBlbmNvdW50ZXJlZCBh
IHJlcHJvZHVjaWJsZSBORlN2NC4xIGNsaWVudCBoYW5nIGlzc3VlIHVuZGVyIGNvbmN1cnJlbnQg
d29ya2xvYWQuCj4gPgo+ID4KPiA+IEVudmlyb25tZW50Ogo+ID4gLSBUd28gaW5kZXBlbmRlbnQg
TGludXggY2xpZW50cyAoVk1zKQo+ID4gLSBCb3RoIG1vdW50IHRoZSBzYW1lIFdpbmRvd3MgTkZT
IHNlcnZlciAoTkZTdjQuMSkKPiA+IC0gS2VybmVsIHZlcnNpb246IDYuMS43OAo+ID4gLSBNb3Vu
dCBvcHRpb25zOiB2ZXJzPTQuMSxzb2Z0LHByb3RvPXRjcCx0aW1lbz02MCxyZXRyYW5zPTEwCj4g
Cj4gV2hpY2ggdmVyc2lvbiBvZiBXaW5kb3dzU2VydmVyIGRvIHlvdSB1c2UsIGUuZyB3aGF0IGRv
ZXMgdGhlICJ2ZXIiCj4gY29tbWFuZCBpbiBjbWQuZXhlIG91dHB1dD8gSG93IGRpZCB5b3Ugc2V0
IHVwIHRoZSB1c2VyIGFjY291bnRzLCBhbmQKPiB3aGljaCBhdXRoZW50aWNhdGlvbiAoQVVUSF9T
WVMsIEdTUywgLi4uKSBkbyB5b3UgdXNlPwo+IFdoaWNoIENQVSBhcmNoaXRlY3R1cmUgZG8geW91
IHVzZT8gSG93IG11Y2ggbWVtb3J5IGRvIHlvdSBoYXZlIG9uIHRoZQo+IExpbnV4IE5GUyBjbGll
bnQ/Cj4gCj4gTGlvbmVsCg0KDQoNCg0KDQo=


Return-Path: <linux-nfs+bounces-21416-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gMLWLHTp+2nEHwAAu9opvQ
	(envelope-from <linux-nfs+bounces-21416-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Thu, 07 May 2026 03:23:00 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 56B294E1ECB
	for <lists+linux-nfs@lfdr.de>; Thu, 07 May 2026 03:23:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5F99A302E7E1
	for <lists+linux-nfs@lfdr.de>; Thu,  7 May 2026 01:22:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E83C26ED3D;
	Thu,  7 May 2026 01:22:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=supcon.com header.i=@supcon.com header.b="HUyDNyOf"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail.supcon.com (mail.supcon.com [218.75.124.151])
	by smtp.subspace.kernel.org (Postfix) with SMTP id 055D026B755;
	Thu,  7 May 2026 01:22:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=218.75.124.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778116950; cv=none; b=nJwx/UqmvpUndydEn04Wha7veE2CMmpsLDM9W7M1FOjfYAR12LGWtbjWrzDWL+YUlCzqWS9fXGnfHvt9EOUzJwgB4bJxGMpcUdGSiokC/Xo1+scMHllUq6U8PYdieWpYTylz9IoFi+oh4hqVu1fCH/Rh66LUodjFoqxr36P5fts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778116950; c=relaxed/simple;
	bh=yk9p/4Mh0EDjhjLUPKPCAH197Je1GAeojVSWMQ4bFxU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:Content-Type:MIME-Version:
	 Message-ID; b=SMKPJ2zc2KMTJf0Vll3xFTVThMjHSgupTbu5CccJX+bcvOaIB8a74Uerg7S9qwjqdFwZ3TICvqqhRMqtNGMf2z4Ld/Eg5EdsaNGDg4fsOVDZa52ZoaDqlnSocxxGL76f8n3lDxZQhpU/acUVVyoPeNjBQw18m2XbuZpEUpke45Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=supcon.com; spf=pass smtp.mailfrom=supcon.com; dkim=pass (1024-bit key) header.d=supcon.com header.i=@supcon.com header.b=HUyDNyOf; arc=none smtp.client-ip=218.75.124.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=supcon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=supcon.com
Received: from maildata.cn (unknown [10.32.1.145])
	by mail.supcon.com (MailData Gateway V2.8.8) with SMTP id 3E844760057;
	Thu,  7 May 2026 09:22:24 +0800 (CST)
Received: from supcon.com (unknown [10.32.1.229])
	by mdau02 (MailData Audit V3.4.6) with ESMTP id 2E8B1217ED72F;
	Thu,  7 May 2026 09:22:21 +0800 (CST)
XMD-OLD-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=supcon.com; s=dkim; h=Received:Date:From:To:Cc:Subject:
	In-Reply-To:References:Content-Transfer-Encoding:Content-Type:
	MIME-Version:Message-ID; bh=sI8dFnxTrfEJBTPDJ+dQtC5wVfaTBEcbKTs1
	bsQPor0=; b=VrW231Qe7FvxY7kiIlutSasDpcQ5oRtjWVsqFskxgAfwV1M/8e8K
	W9KggfN5wWJqIvwa44tHFx55gKLNu6akQGat1W5XnjPTasKLx5XJ+iHH8Eq4PPy9
	rHHv7te9GsyofJqwXb2rfJEHvE/Z2WQvfD82/Rpxh4c3jaLauWIfl34=
Received: from guolingxing$supcon.com ( [10.30.28.7] ) by ajax-webmail-app1
 (Coremail) ; Thu, 7 May 2026 09:22:20 +0800 (GMT+08:00)
Date: Thu, 7 May 2026 09:22:20 +0800 (GMT+08:00)
X-CM-HeaderCharset: UTF-8
X-MD-FileKey: 6cbb582174f2b0e8913ff763e3840074[#]6d00fcf34c22a5239358616006e12ff5
X-MD-Sfrom: guolingxing@supcon.com
X-MD-SrcIP: 10.32.1.145
From: =?UTF-8?B?6YOt546y5YW0?= <guolingxing@supcon.com>
To: "Lionel Cons" <lionelcons1972@gmail.com>
Cc: linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: Re: Re: [BUG] NFSv4.1 client hang in nfs4_drain_slot_tbl under
 concurrent workload against Windows NFS server
X-Priority: 3
X-Mailer: Coremail Webmail Server Version 2024.3-cmXT6 build
 20250609(354f7833) Copyright (c) 2002-2026 www.mailtech.cn
 mispb-27421bd6-c70e-4259-88e7-36dce31e831d-supcon.com
In-Reply-To: <19b5fe04.1a5ac.19dffea136b.Coremail.guolingxing@supcon.com>
Content-Transfer-Encoding: base64
X-CM-CTRLDATA: q8gsEmZvb3Rlcl90eHQ9MzI2NDoxMA==
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <66cea4e7.1a5d5.19e00075416.Coremail.guolingxing@supcon.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID:5QEgCgAH9zdM6ftpOvvKAQ--.5427W
X-CM-SenderInfo: xjxrzxpqj0x0nj6v31xfrqhudrp/1tbiAQETBmn6BvmMZwACsQ
X-Coremail-Antispam: 1Ur529EdanIXcx71UUUUU7IcSsGvfJ3iIAIbVAYjsxI4VWxJw
	CS07vEb4IE77IF4wCS07vE1I0E4x80FVAKz4kxMIAIbVAFxVCaYxvI4VCIwcAKzIAtYxBI
	daVFxhVjvjDU=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=supcon.com; s=default;
	t=1778116945; bh=yk9p/4Mh0EDjhjLUPKPCAH197Je1GAeojVSWMQ4bFxU=;
	h=Date:From:To:Cc:Subject:Content-Type:Message-ID;
	b=HUyDNyOfsHFDg+H4MohfKB6gGuOxPFTRGN7PJoVRCh0vy6iGRQyF4AcIhXyJlRF+I
	 IMGnXyFuIKfFKmtY5XrK/6ulOKTiUULdRs92y6eylaBM+c6oq1brfoefQnk9tisg7v
	 qFAmipgvY18l84qN+OQLJ+SdLHjuTZ2Q9uD23MWQ=
X-Rspamd-Queue-Id: 56B294E1ECB
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.56 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[supcon.com:s=default];
	MAILLIST(-0.15)[generic];
	MIME_BASE64_TEXT(0.10)[];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-21416-lists,linux-nfs=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[supcon.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[supcon.com:+];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[guolingxing@supcon.com,linux-nfs@vger.kernel.org];
	HAS_X_PRIO_THREE(0.00)[3];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[linux-nfs];
	RCPT_COUNT_THREE(0.00)[3];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Action: no action

SGkgTGlvbmVsLAoKVGhhbmtzIGZvciB5b3VyIHJlc3BvbnNlLgoKSGVyZSBhcmUgdGhlIGRldGFp
bHMgeW91IHJlcXVlc3RlZDoKCjEuIFdpbmRvd3MgU2VydmVyIHZlcnNpb246Ck1pY3Jvc29mdCBX
aW5kb3dzIFNlcnZlciAyMDIyClZlcnNpb24gMTAuMC4yMDM0OC41ODcKCjIuIFVzZXIgYWNjb3Vu
dHM6Ck5vIG1hcHBpbmcgbWVjaGFuaXNtIGlzIGNvbmZpZ3VyZWQuCk5vIEFELCBMREFQLCBvciBw
YXNzd2QgbWFwcGluZyBpcyB1c2VkLgoKVW5tYXBwZWQgdXNlcnMgYXJlIGhhbmRsZWQgYnkgdGhl
IGRlZmF1bHQgIkV2ZXJ5b25lIiBhY2NvdW50LgoKMy4gQXV0aGVudGljYXRpb246CnNlYz1zeXMg
KEFVVEhfU1lTKSwgYXMgcmVwb3J0ZWQgYnkgbmZzc3RhdCAtbQoKNC4gQ1BVIGFyY2hpdGVjdHVy
ZToKLSBMaW51eCBjbGllbnRzOiB4ODZfNjQKLSBXaW5kb3dzIHNlcnZlcjogeDg2XzY0ICg2NC1i
aXQgT1MpCgo1LiBNZW1vcnk6CkVhY2ggTGludXggY2xpZW50IFZNIGhhcyAxNkdCIFJBTQoKLS0t
CgpBZGRpdGlvbmFsIG9ic2VydmF0aW9ucyBmcm9tIHR3byBpbmRlcGVuZGVudCBjbGllbnRzOgoK
Q2xpZW50IEE6CmFnZTogNDk4MDYxCmxlYXNlX3RpbWU6IDEyMApsZWFzZV9leHBpcmVkOiA0OTc5
NDEKCkNsaWVudCBCOgphZ2U6IDY5NTk4CmxlYXNlX3RpbWU6IDEyMApsZWFzZV9leHBpcmVkOiA2
OTQ3OAoKSW4gYm90aCBjYXNlcywgbGVhc2VfZXhwaXJlZCBpcyBhcHByb3hpbWF0ZWx5IGVxdWFs
IHRvIChhZ2UgLSBsZWFzZV90aW1lKSwKd2hpY2ggc3VnZ2VzdHMgdGhhdCB0aGUgbGVhc2UgZXhw
aXJlZCBzaG9ydGx5IGFmdGVyIG1vdW50IGFuZCBoYXMgbm90CmJlZW4gc3VjY2Vzc2Z1bGx5IHJl
bmV3ZWQgc2luY2UuCgpBdCB0aGUgc2FtZSB0aW1lOgoKLSBCb3RoIGNsaWVudHMgaGFuZyBzaW11
bHRhbmVvdXNseSB1bmRlciBjb25jdXJyZW50IHdvcmtsb2FkCi0gQ2xpZW50cyBhcmUgc3R1Y2sg
aW4gbmZzNF9kcmFpbl9zbG90X3RibAotIE5vIE5GUyBSUEMgdHJhZmZpYyBpcyBvYnNlcnZlZCBh
dCBoYW5nIHRpbWUgKG9ubHkgVENQIEFDSykKLSBuZnNzdGF0IHNob3dzIHJldHJhbnM9MAotIE9u
IHRoZSBXaW5kb3dzIHNlcnZlciBzaWRlLCB0aGUgTkZTIHNlc3Npb24gc3RhdGUgaXMgcmVwb3J0
ZWQgYXMgIkluaXRpYWxpemVkIgoKV2UgYXJlIGN1cnJlbnRseSB0cmFjaW5nIHRoZSBSUEMgbGlm
ZWN5Y2xlIHRvIGlkZW50aWZ5IHdoaWNoIFJQQyBkb2VzIG5vdCBjb21wbGV0ZS4KClBsZWFzZSBs
ZXQgdXMga25vdyBpZiBmdXJ0aGVyIGluZm9ybWF0aW9uIHdvdWxkIGJlIGhlbHBmdWwuCgpUaGFu
a3MuCgoKPiAtLS0tLeWOn+Wni+mCruS7ti0tLS0tCj4g5Y+R5Lu25Lq6OiDpg63njrLlhbQgPGd1
b2xpbmd4aW5nQHN1cGNvbi5jb20+Cj4g5Y+R6YCB5pe26Ze0OjIwMjYtMDUtMDcgMDg6NTA6MjMg
KOaYn+acn+WbmykKPiDmlLbku7bkuro6ICJMaW9uZWwgQ29ucyIgPGxpb25lbGNvbnMxOTcyQGdt
YWlsLmNvbT4KPiDmioTpgIE6IGxpbnV4LW5mc0B2Z2VyLmtlcm5lbC5vcmcsIGxpbnV4LWtlcm5l
bEB2Z2VyLmtlcm5lbC5vcmcKPiDkuLvpopg6IFJlOiBSZTogW0JVR10gTkZTdjQuMSBjbGllbnQg
aGFuZyBpbiBuZnM0X2RyYWluX3Nsb3RfdGJsIHVuZGVyIGNvbmN1cnJlbnQgd29ya2xvYWQgYWdh
aW5zdCBXaW5kb3dzIE5GUyBzZXJ2ZXIKPiAKPiBIaSBMaW9uZWwsCj4gCj4gVGhhbmtzIGZvciB5
b3VyIHJlc3BvbnNlLgo+IAo+IEhlcmUgYXJlIHRoZSBkZXRhaWxzOgo+IAo+IDEuIFdpbmRvd3Mg
U2VydmVyIHZlcnNpb246Cj4gTWljcm9zb2Z0IFdpbmRvd3MgU2VydmVyIDIwMjIKPiBWZXJzaW9u
IDEwLjAuMjAzNDguNTg3Cj4gCj4gMi4gVXNlciBhY2NvdW50czoKPiBObyBtYXBwaW5nIG1lY2hh
bmlzbSBpcyBjb25maWd1cmVkLgo+IE5vIEFELCBMREFQLCBvciBwYXNzd2QgbWFwcGluZyBpcyB1
c2VkLgo+IAo+IFVubWFwcGVkIHVzZXJzIGFyZSBoYW5kbGVkIGJ5IHRoZSBkZWZhdWx0ICJFdmVy
eW9uZSIgYWNjb3VudC4KPiAKPiAzLiBBdXRoZW50aWNhdGlvbjoKPiBzZWM9c3lzIChBVVRIX1NZ
UyksIGFzIHJlcG9ydGVkIGJ5IG5mc3N0YXQgLW0KPiAKPiA0LiBDUFUgYXJjaGl0ZWN0dXJlOgo+
IC0gTGludXggY2xpZW50czogeDg2XzY0Cj4gLSBXaW5kb3dzIHNlcnZlcjogeDg2XzY0ICg2NC1i
aXQgT1MpCj4gCj4gNS4gTWVtb3J5Ogo+IEVhY2ggTGludXggY2xpZW50IFZNIGhhcyAxNkdCIFJB
TQo+IAo+IFRoYW5rcy4KPiAKPiAKPiA+IC0tLS0t5Y6f5aeL6YKu5Lu2LS0tLS0KPiA+IOWPkeS7
tuS6ujogIkxpb25lbCBDb25zIiA8bGlvbmVsY29uczE5NzJAZ21haWwuY29tPgo+ID4g5Y+R6YCB
5pe26Ze0OjIwMjYtMDUtMDYgMjE6Mjg6MzMgKOaYn+acn+S4iSkKPiA+IOaUtuS7tuS6ujog6YOt
546y5YW0IDxndW9saW5neGluZ0BzdXBjb24uY29tPiwgbGludXgtbmZzQHZnZXIua2VybmVsLm9y
ZywgbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZwo+ID4g5Li76aKYOiBSZTogW0JVR10gTkZT
djQuMSBjbGllbnQgaGFuZyBpbiBuZnM0X2RyYWluX3Nsb3RfdGJsIHVuZGVyIGNvbmN1cnJlbnQg
d29ya2xvYWQgYWdhaW5zdCBXaW5kb3dzIE5GUyBzZXJ2ZXIKPiA+IAo+ID4gT24gV2VkLCA2IE1h
eSAyMDI2IGF0IDA5OjQ5LCDpg63njrLlhbQgPGd1b2xpbmd4aW5nQHN1cGNvbi5jb20+IHdyb3Rl
Ogo+ID4gPgo+ID4gPiBIaSwKPiA+ID4KPiA+ID4KPiA+ID4gV2UgZW5jb3VudGVyZWQgYSByZXBy
b2R1Y2libGUgTkZTdjQuMSBjbGllbnQgaGFuZyBpc3N1ZSB1bmRlciBjb25jdXJyZW50IHdvcmts
b2FkLgo+ID4gPgo+ID4gPgo+ID4gPiBFbnZpcm9ubWVudDoKPiA+ID4gLSBUd28gaW5kZXBlbmRl
bnQgTGludXggY2xpZW50cyAoVk1zKQo+ID4gPiAtIEJvdGggbW91bnQgdGhlIHNhbWUgV2luZG93
cyBORlMgc2VydmVyIChORlN2NC4xKQo+ID4gPiAtIEtlcm5lbCB2ZXJzaW9uOiA2LjEuNzgKPiA+
ID4gLSBNb3VudCBvcHRpb25zOiB2ZXJzPTQuMSxzb2Z0LHByb3RvPXRjcCx0aW1lbz02MCxyZXRy
YW5zPTEwCj4gPiAKPiA+IFdoaWNoIHZlcnNpb24gb2YgV2luZG93c1NlcnZlciBkbyB5b3UgdXNl
LCBlLmcgd2hhdCBkb2VzIHRoZSAidmVyIgo+ID4gY29tbWFuZCBpbiBjbWQuZXhlIG91dHB1dD8g
SG93IGRpZCB5b3Ugc2V0IHVwIHRoZSB1c2VyIGFjY291bnRzLCBhbmQKPiA+IHdoaWNoIGF1dGhl
bnRpY2F0aW9uIChBVVRIX1NZUywgR1NTLCAuLi4pIGRvIHlvdSB1c2U/Cj4gPiBXaGljaCBDUFUg
YXJjaGl0ZWN0dXJlIGRvIHlvdSB1c2U/IEhvdyBtdWNoIG1lbW9yeSBkbyB5b3UgaGF2ZSBvbiB0
aGUKPiA+IExpbnV4IE5GUyBjbGllbnQ/Cj4gPiAKPiA+IExpb25lbAo+IAo+IAo+IAo+IAo+IAoN
Cg0KDQoNCg0K


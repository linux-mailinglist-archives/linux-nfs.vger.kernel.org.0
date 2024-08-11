Return-Path: <linux-nfs+bounces-5304-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E83394E2D3
	for <lists+linux-nfs@lfdr.de>; Sun, 11 Aug 2024 21:48:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E3EAB1F2105E
	for <lists+linux-nfs@lfdr.de>; Sun, 11 Aug 2024 19:48:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 631F41547E4;
	Sun, 11 Aug 2024 19:48:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=desy.de header.i=@desy.de header.b="r6eQ5XrK"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp-o-3.desy.de (smtp-o-3.desy.de [131.169.56.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84BCC26ACB
	for <linux-nfs@vger.kernel.org>; Sun, 11 Aug 2024 19:48:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=131.169.56.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723405732; cv=none; b=jYllax9AL6bei4y5IHxdocJUY82e3z258PNyNLJF/cfIXWjElA6Q0Dr9aYarjMFNwwD74fK2/cUPQi9nfyjEwkW7ie2+q/1CrRQiusrQn6DTKXO30ALQnNlLCUpz3vvf9RFcm3RaCyAU1U/qsDIwMZJV3fn199l7cg4oVZqUsrA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723405732; c=relaxed/simple;
	bh=Cmel/lAs9eyiAXusVfb9rftfnr9+f62tkPO3PAOvlCs=;
	h=Content-Type:From:Mime-Version:Subject:Date:Message-Id:References:
	 Cc:In-Reply-To:To; b=EIwODN7Dc0KBGxoI7lCxd3Q8yjjj8G1aMC/Gj+absIlVyVuFUlY097rgDMJ6CYFA6sNrCi0EmygfprKVrJnhUVoOIfuhaeMsZghGzpFwxm/a7SUmyrcwZr/sd/yREkalVwNfKeeUbacPimYtlYAECn2oBzPnPgJ2z89ESWnRGPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=desy.de; spf=pass smtp.mailfrom=desy.de; dkim=pass (1024-bit key) header.d=desy.de header.i=@desy.de header.b=r6eQ5XrK; arc=none smtp.client-ip=131.169.56.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=desy.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=desy.de
Received: from smtp-o-2.desy.de (smtp-o-2.desy.de [131.169.56.155])
	by smtp-o-3.desy.de (Postfix) with ESMTP id A516E11F8A4
	for <linux-nfs@vger.kernel.org>; Sun, 11 Aug 2024 21:41:24 +0200 (CEST)
Received: from smtp-buf-2.desy.de (smtp-buf-2.desy.de [IPv6:2001:638:700:1038::1:a5])
	by smtp-o-2.desy.de (Postfix) with ESMTP id 4B5EA13F64F
	for <linux-nfs@vger.kernel.org>; Sun, 11 Aug 2024 21:41:17 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp-o-2.desy.de 4B5EA13F64F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=desy.de; s=default;
	t=1723405277; bh=Cmel/lAs9eyiAXusVfb9rftfnr9+f62tkPO3PAOvlCs=;
	h=From:Subject:Date:References:Cc:In-Reply-To:To:From;
	b=r6eQ5XrKkAI+SUrTeeOUodkBhFMRMawNhTKVsUYIX/t22TYcvQHAYwMVgLY6DO3YO
	 hxoDVjjZPFUmHaKr74VbuZfleBah9JFZgZpbXkCAEJZJWCEfvCL1J/Sm+nnGf0io9u
	 C1Wbaqoq0G0WFShtMxMvAVT1p5+z6aMwDO4+sSXs=
Received: from smtp-m-2.desy.de (smtp-m-2.desy.de [IPv6:2001:638:700:1038::1:82])
	by smtp-buf-2.desy.de (Postfix) with ESMTP id 30099120038;
	Sun, 11 Aug 2024 21:41:17 +0200 (CEST)
Received: from c1722.mx.srv.dfn.de (c1722.mx.srv.dfn.de [IPv6:2001:638:d:c303:acdc:1979:2:e7])
	by smtp-m-2.desy.de (Postfix) with ESMTP id 1B0AE16003F;
	Sun, 11 Aug 2024 21:41:17 +0200 (CEST)
Received: from smtp-intra-2.desy.de (smtp-intra-2.desy.de [IPv6:2001:638:700:1038::1:53])
	by c1722.mx.srv.dfn.de (Postfix) with ESMTP id D869AA0038;
	Sun, 11 Aug 2024 21:41:13 +0200 (CEST)
Received: from z-mbx-2.desy.de (z-mbx-2.desy.de [131.169.55.140])
	by smtp-intra-2.desy.de (Postfix) with ESMTP id 6919520044;
	Sun, 11 Aug 2024 21:41:13 +0200 (CEST)
Content-Type: text/plain;
	charset=utf-8
Content-Transfer-Encoding: base64
From: "Mkrtchyan, Tigran" <tigran.mkrtchyan@desy.de>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Subject: Re: NFS client to pNFS DS
Date: Sun, 11 Aug 2024 21:41:11 +0200 (CEST)
Message-Id: <685478263.45656552.1723405271880.JavaMail.zimbra@z-mbx-2>
References: <CAN-5tyHXg8=Sv8MS7vJUwG+=Av8oL6Bk_ZDDfwjEf3-R0KT=dg@mail.gmail.com>
Cc: marc eshel <eshel.marc@gmail.com>, Anna Schumaker <schumaker.anna@gmail.com>, 
	linux-nfs@vger.kernel.org, Trond Myklebust <trondmy@hammerspace.com>
In-Reply-To: <CAN-5tyHXg8=Sv8MS7vJUwG+=Av8oL6Bk_ZDDfwjEf3-R0KT=dg@mail.gmail.com>
To: Olga Kornievskaia <aglo@umich.edu>
X-ZxMobile-Command: SmartReply
X-ZxMobile-Version: 3.19.0
X-Mailer: Zimbra 9.0.0_GA_4612
Thread-Topic: NFS client to pNFS DS
Thread-Index: i1OOmUHN+18EER2+kriqNNOefZPFSg==

DQo+IA0KPiBPbiAxMC4gQXVnIDIwMjQsIGF0IDIzOjIwLCBPbGdhIEtvcm5pZXZza2FpYSA8YWds
b0B1bWljaC5lZHU+IHdyb3RlOg0KPiANCj4g77u/T24gRnJpLCBBdWcgOSwgMjAyNCBhdCAxMjoy
N+KAr1BNIG1hcmMgZXNoZWwgPGVzaGVsLm1hcmNAZ21haWwuY29tPiB3cm90ZToNCj4gPg0KPiA+
DQo+ID4gT24gOC85LzI0IDg6MTUgQU0sIE9sZ2EgS29ybmlldnNrYWlhIHdyb3RlOg0KPiA+ID4g
T24gRnJpLCBBdWcgOSwgMjAyNCBhdCAxMDowOeKAr0FNIG1hcmMgZXNoZWwgPGVzaGVsLm1hcmNA
Z21haWwuY29tPiB3cm90ZToNCj4gPiA+PiBUaGFua3MgZm9yIHRoZSByZXBsaWVzLCBJIGFtIGEg
bGl0dGxlIHJ1c3R5IHdpdGggZGVidWdnaW5nIE5GUyBidXQgdGhpcyB3aGF0IEkgc2VlIHdoZW4g
dGhlIE5GUyBjbGllbnQgdHJpZWQgdG8gY3JlYXRlIGEgc2Vzc2lvbiB3aXRoIHRoZSBEUy4NCj4g
PiA+Pg0KPiA+ID4+IEdhbmVzaGEgd2FzIGNvbmZpZ3VyZWQgZm9yIHNlYz1zeXMgYW5kIHRoZSBj
bGllbnQgbW91bnQgaGFkIHRoZSBvcHRpb24gc2VjPXN5cywgSSBhc3N1bWUgZmxhdm9yIDM5MDAw
NCBtZWFucyBpdCB3YXMgdHJ5aW5nIHRvIHVzZSBrcmI1aS4NCj4gPiA+IEZvciA0LjEsIHRoZSBj
bGllbnQgd2lsbCBhbHdheXMgdHJ5IHRvIGRvIHN0YXRlIG9wZXJhdGlvbnMgd2l0aCBrcmI1aQ0K
PiA+ID4gZXZlbiB3aGVuIHNlYz1zeXMgd2hlbiB0aGUgY2xpZW50IGRldGVjdHMgdGhhdCBpdCdz
IGNvbmZpZ3VyZWQgdG8gZG8NCj4gPiA+IEtlcmJlcm9zIChpZS4sIGdzc2QgaXMgcnVubmluZyku
IFRoaXMgY29udGV4dCBjcmVhdGlvbiBpcyB0cmlnZ2VyZWQNCj4gPiA+IHJlZ2FyZGxlc3Mgb2Yg
d2hldGhlciB0aGUgcnBjIGNsaWVudCBpcyB1c2VkIGZvciBNRFMgb3IgRFMuDQo+ID4gPg0KPiA+
ID4gTXkgcXVlc3Rpb24gdG8geW91OiBpcyB0aGUgTURTIGNvbmZpZ3VyZWQgd2l0aCBLZXJiZXJv
cyBidXQgdGhlIERTDQo+ID4gPiBpc24ndD8gQW5kIGFsc28sIGRvZXMgdGhpcyBsZWFkIHRvIGEg
ZmFpbHVyZT8NCj4gPiBCb3RoIE1EUyBEUyBhcmUgY29uZmlndXJlZCBmb3Igc2VjPXN5cyBhbmQg
aXQgaXMgbGVhZGluZyB0byBjbGllbnQNCj4gPiBzd2l0Y2hpbmcgZnJvbSBEUyB0byBNRFMgc28g
eWVzLCBpdCBpcyBwTkZTIGZhaWx1cmUuIFdoYXQgSSBzZWUgb24gdGhlDQo+ID4gRFMgaXMgdGhl
IGNsaWVudCBjcmVhdGluZyBhIHNlc3Npb24gYW5kIHRoYW4gaW1taW5lbnRseSBkZXN0cm95aW5n
IGl0DQo+ID4gYmVmb3JlIGNvbW1pdHRpbmcgaXQuIElmIHRoZSBpcyBzb21ldGhpbmcgZWxzZSB0
aGF0IEkgY2FuIGRlYnVnIEkgd2lsbA0KPiA+IGJlIGhhcHB5IHRvLg0KPiANCj4gcG5mcyBmYWls
dXJlIGlzIHVuZXhwZWN0ZWQuIEknbSBwcmV0dHkgY29uZmlkZW50IHRoYXQgYSBub24ta2VyYmVy
b3MNCj4gY29uZmlndXJlZCBjbGllbnQgY2FuIGRvIG5vcm1hbCBwbmZzIHdpdGggc2VjPXN5cy4g
SSBjYW4gaGVscCBkZWJ1ZywNCg0KWWVzLCBJIGNhbiBjb25maXJtIHRoYXQuIEFsbCBSSEVMIGtl
cm5lbHMgYW5kIHdlZWtseSAtcmMga2VybmVscyBmcm9tIExpbnVzIHdvcmtzIGFzIGV4cGVjdGVk
LiBXZSBtb3VudCBhbHdheXMgd2l0aCBzZWM9c3lzLCBhbmQgZGVzcGl0ZSB0aGUgZmFjdCwgdGhh
dCBob3N0cyBjb25maWd1cmVkIHRvIHN1cHBvcnQga2VyYmVyb3MgZHVlIHRvIEFGUyBhbmQgR1BG
UywgdGhlIGFjY2VzcyB0byBEU2VzIGlzIG5ldmVyIGFuIGlzc3VlIGFuZCBuZXZlciB0cmllcyB0
byB1c2Uga2VyYmVyb3MuDQoNClRpZ3Jhbi4NCg0KPiBpZiB5b3Ugd2FudCB0byBzZW5kIG1lIGEg
bmV0d29yayB0cmFjZSBhbmQgdHJhY2Vwb2ludCBvdXRwdXQuIEJ0dyB3aGF0DQo+IGtlcm5lbC9k
aXN0cm8gYXJlIHlvdSB1c2luZz8NCj4gDQo+ID4NCj4gPiBNYXJjLg0KPiA+DQo+ID4gPg0KPiA+
ID4+IEp1bCAzMCAxMToxMDo1OCBzdmwtbWFyY3JoLW5vZGUtMSBrZXJuZWw6IFJQQzogQ291bGRu
J3QgY3JlYXRlDQo+ID4gPj4gYXV0aCBoYW5kbGUgKGZsYXZvciAzOTAwMDQpDQo+ID4gPj4NCj4g
PiA+PiBNYXJjLg0KPiA+ID4+DQo+ID4gPj4gT24gOC85LzI0IDY6MDYgQU0sIEFubmEgU2NodW1h
a2VyIHdyb3RlOg0KPiA+ID4+DQo+ID4gPj4gT24gVGh1LCBBdWcgOCwgMjAyNCBhdCA2OjA34oCv
UE0gT2xnYSBLb3JuaWV2c2thaWEgPGFnbG9AdW1pY2guZWR1PiB3cm90ZToNCj4gPiA+Pg0KPiA+
ID4+IE9uIE1vbiwgQXVnIDUsIDIwMjQgYXQgNTo1MeKAr1BNIG1hcmMgZXNoZWwgPGVzaGVsLm1h
cmNAZ21haWwuY29tPiB3cm90ZToNCj4gPiA+Pg0KPiA+ID4+IEhpIFRyb25kLA0KPiA+ID4+DQo+
ID4gPj4gV2lsbCB0aGUgTGludXggTkZTIGNsaWVudCB0cnkgdG8gdXMga3JiNWkgcmVnYXJkbGVz
cyBvZiB0aGUgTURTDQo+ID4gPj4gY29uZmlndXJhdGlvbj8NCj4gPiA+Pg0KPiA+ID4+IElzIHRo
ZXJlIGFueSBvcHRpb24gdG8gYXZvaWQgaXQ/DQo+ID4gPj4NCj4gPiA+PiBJIHdhcyB1bmRlciB0
aGUgaW1wcmVzc2lvbiB0aGUgbGludXggY2xpZW50IGhhcyBubyB3YXkgb2YgY2hvb3NpbmcgYQ0K
PiA+ID4+IGRpZmZlcmVudCBhdXRoX2dzcyBzZWN1cml0eSBmbGF2b3IgZm9yIHRoZSBEUyB0aGFu
IHRoZSBNRFMuIE1lYW5pbmcNCj4gPiA+Pg0KPiA+ID4+IFRoYXQncyBhIGdvb2QgcG9pbnQsIEkg
Y29tcGxldGVseSBtaXNzZWQgdGhhdCB0aGlzIGlzIHNwZWNpZmljYWxseSBmb3IgdGhlIERTLg0K
PiA+ID4+DQo+ID4gPj4gdGhhdCBpZiBtb3VudCBjb21tYW5kIGhhcyBzYXkgc2VjPWtyYjVpIHRo
ZW4gYm90aCBNRFMgYW5kIERTDQo+ID4gPj4gY29ubmVjdGlvbnMgaGF2ZSB0byBkbyBrcmI1aSBh
bmQgaWYgc2F5IHRoZSBEUyBpc24ndCBjb25maWd1cmVkIGZvcg0KPiA+ID4+IEtlcmJlcm9zLCB0
aGVuIElPIHdvdWxkIGZhbGxiYWNrIHRvIE1EUy4gSSBubyBsb25nZXIgaGF2ZSBhIHBuZnMNCj4g
PiA+Pg0KPiA+ID4+IFRoYXQncyB3aGF0IEkgd291bGQgZXhwZWN0LCB0b28uDQo+ID4gPj4NCj4g
PiA+PiBzZXJ2ZXIgdG8gdmVyaWZ5IHdoZXRoZXIgb3Igbm90IHdoYXQgSSBzYXkgaXMgdHJ1ZSBi
dXQgdGhhdCBpcyB3aGF0IG15DQo+ID4gPj4gbWVtb3J5IHRlbGxzIG1lIGlzIHRoZSBjYXNlLg0K
PiA+ID4+DQo+ID4gPj4NCj4gPiA+PiBUaGFua3MsIE1hcmMuDQo+ID4gPj4NCj4gPiA+PiB1bCAz
MCAxMToxMDo1OCBzdmwtbWFyY3JoLW5vZGUtMSBrZXJuZWw6IG5mczRfZmxfYWxsb2NfZGV2aWNl
aWRfbm9kZQ0KPiA+ID4+IHN0cmlwZSBjb3VudCAxDQo+ID4gPj4gSnVsIDMwIDExOjEwOjU4IHN2
bC1tYXJjcmgtbm9kZS0xIGtlcm5lbDogbmZzNF9mbF9hbGxvY19kZXZpY2VpZF9ub2RlDQo+ID4g
Pj4gZHNfbnVtIDENCj4gPiA+PiBKdWwgMzAgMTE6MTA6NTggc3ZsLW1hcmNyaC1ub2RlLTEga2Vy
bmVsOiBSUEM6IENvdWxkbid0IGNyZWF0ZQ0KPiA+ID4+IGF1dGggaGFuZGxlIChmbGF2b3IgMzkw
MDA0KQ0KPiA+ID4+DQo+ID4gPj4NCj4gPg0KPiANCg==


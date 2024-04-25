Return-Path: <linux-nfs+bounces-3012-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 990B48B2A69
	for <lists+linux-nfs@lfdr.de>; Thu, 25 Apr 2024 23:08:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 524B72811FA
	for <lists+linux-nfs@lfdr.de>; Thu, 25 Apr 2024 21:08:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83696155739;
	Thu, 25 Apr 2024 21:07:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b="dBARPjUJ"
X-Original-To: linux-nfs@vger.kernel.org
Received: from gate2.alliedtelesis.co.nz (gate2.alliedtelesis.co.nz [202.36.163.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F01A61553BD
	for <linux-nfs@vger.kernel.org>; Thu, 25 Apr 2024 21:07:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.36.163.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714079275; cv=none; b=PouH+lctxPh3zYLcgFAtDaIL75H4RkBlzy8um5vx+9qU8PhYN2hr6QqPcI28CuJKKcZ3jcEsnhe0S7mttMn7OjW4xZHrm7a+5pYUpuCfHrwNBDfqd0vHmdEnErKZGhXRLIxpVvZQs8/ItBtgDFW78HThRiUA7Tc6DF1+f4As1Is=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714079275; c=relaxed/simple;
	bh=JOPgLUe8I9YipPlrMgvXOgvept9vfI3FxbS5jEZ5FxU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=oued7xM2hNICcSp6Ce+oxzlsPy9APiDDq7wjLrSx47V2/TwzReu++GCnEwFcqR7hbqcPB3G3BAn0Zaczr7gK7VtrNcO1mrypAPVF5RF8fjo247xt0SWb5KQIOwdOCIlNxOFsu6cytIkB4CBMpEwii7ZKEQrKeJscXr1q6T8vmSo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=alliedtelesis.co.nz; spf=pass smtp.mailfrom=alliedtelesis.co.nz; dkim=pass (2048-bit key) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b=dBARPjUJ; arc=none smtp.client-ip=202.36.163.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=alliedtelesis.co.nz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alliedtelesis.co.nz
Received: from svr-chch-seg1.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id CF8142C03E9;
	Fri, 26 Apr 2024 09:07:49 +1200 (NZST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
	s=mail181024; t=1714079269;
	bh=JOPgLUe8I9YipPlrMgvXOgvept9vfI3FxbS5jEZ5FxU=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:From;
	b=dBARPjUJ7LXDkYLsqPLfN1vMVnEfK7FKOZAnV0tLJ8HYKeUxaqH8hK4Zu4G0DGvMk
	 FfWZMmLl7XdttC571G7lmfC0Udifq0tztQpBCZqOHh3Uk/dPaomF6W6/YJy6TarxZc
	 BNQ2zfCUH1ryTgrNjR7j/xUyA4Bff3sGgc9PfYZrTQzOa0lWgtpXo7lpO1OLiIP3rF
	 gP+nPuk9aX1+yuVrnaualLP1xHw7LJSGi0DrpQAFI0FduEA4BhGVM4AZoqqIN11FV4
	 kG7eXi3XMlYpJ4enFysDlHvHTaNWm+OO2PKNd4yS7i3LiSek0HcjLeE4jjVHzrdR4O
	 Jjf55VHeXvd7Q==
Received: from svr-chch-ex2.atlnz.lc (Not Verified[2001:df5:b000:bc8::76]) by svr-chch-seg1.atlnz.lc with Trustwave SEG (v8,2,6,11305)
	id <B662ac6250001>; Fri, 26 Apr 2024 09:07:49 +1200
Received: from svr-chch-ex2.atlnz.lc (2001:df5:b000:bc8::76) by
 svr-chch-ex2.atlnz.lc (2001:df5:b000:bc8::76) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Fri, 26 Apr 2024 09:07:49 +1200
Received: from svr-chch-ex2.atlnz.lc ([fe80::a9eb:c9b7:8b52:9567]) by
 svr-chch-ex2.atlnz.lc ([fe80::a9eb:c9b7:8b52:9567%15]) with mapi id
 15.02.1544.009; Fri, 26 Apr 2024 09:07:49 +1200
From: Chris Packham <Chris.Packham@alliedtelesis.co.nz>
To: Chuck Lever III <chuck.lever@oracle.com>
CC: Neil Brown <neilb@suse.de>, Jeff Layton <jlayton@kernel.org>, "Greg
 Kroah-Hartman" <gregkh@linuxfoundation.org>, Linux NFS Mailing List
	<linux-nfs@vger.kernel.org>, netdev <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: kernel BUG at net/sunrpc/svc.c:570 after updating from v5.15.153
 to v5.15.155
Thread-Topic: kernel BUG at net/sunrpc/svc.c:570 after updating from v5.15.153
 to v5.15.155
Thread-Index: AQHaleHzc3oveYbGkkq3WWVD/cih7bF12zkAgABlswCAAStOgIAACEqA///XTYCAAWPYAIAAA+uAgAAAv4A=
Date: Thu, 25 Apr 2024 21:07:49 +0000
Message-ID: <dc96f7d9-ffd9-487a-be44-9c30c6662d52@alliedtelesis.co.nz>
References: <5D19EAF8-0F65-4CD6-9378-67234D407B96@oracle.com>
 <171400185158.7600.16163546434537681088@noble.neil.brown.name>
 <141fbaa0-f8fa-4bfe-8c2d-7749fcf78ab3@alliedtelesis.co.nz>
 <6F1A5E20-1A0E-479C-AD5B-886D10739702@oracle.com>
In-Reply-To: <6F1A5E20-1A0E-479C-AD5B-886D10739702@oracle.com>
Accept-Language: en-NZ, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
Content-Type: text/plain; charset="utf-8"
Content-ID: <AC58CAD9C8A21E469637C4B8E843D402@atlnz.lc>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-SEG-SpamProfiler-Analysis: v=2.4 cv=dY4j3mXe c=1 sm=1 tr=0 ts=662ac625 a=Xf/6aR1Nyvzi7BryhOrcLQ==:117 a=xqWC_Br6kY4A:10 a=75chYTbOgJ0A:10 a=IkcTkHD0fZMA:10 a=raytVjVEu-sA:10 a=yPCof4ZbAAAA:8 a=VwQbUJbxAAAA:8 a=g6u_1-914C6Wr_cfHq0A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=AjGcO6oz07-iQ99wixmX:22 a=eNOiNizBAFBy3Wy_Y4PN:22
X-SEG-SpamProfiler-Score: 0

DQpPbiAyNi8wNC8yNCAwOTowNSwgQ2h1Y2sgTGV2ZXIgSUlJIHdyb3RlOg0KPg0KPj4gT24gQXBy
IDI1LCAyMDI0LCBhdCA0OjUx4oCvUE0sIENocmlzIFBhY2toYW0gPENocmlzLlBhY2toYW1AYWxs
aWVkdGVsZXNpcy5jby5uej4gd3JvdGU6DQo+Pg0KPj4NCj4+IE9uIDI1LzA0LzI0IDExOjM3LCBO
ZWlsQnJvd24gd3JvdGU6DQo+Pj4gT24gVGh1LCAyNSBBcHIgMjAyNCwgQ2h1Y2sgTGV2ZXIgSUlJ
IHdyb3RlOg0KPj4+Pj4gT24gQXByIDI0LCAyMDI0LCBhdCA5OjMz4oCvQU0sIENodWNrIExldmVy
IElJSSA8Y2h1Y2subGV2ZXJAb3JhY2xlLmNvbT4gd3JvdGU6DQo+Pj4+Pg0KPj4+Pj4+IE9uIEFw
ciAyNCwgMjAyNCwgYXQgMzo0MuKAr0FNLCBDaHJpcyBQYWNraGFtIDxDaHJpcy5QYWNraGFtQGFs
bGllZHRlbGVzaXMuY28ubno+IHdyb3RlOg0KPj4+Pj4+DQo+Pj4+Pj4gT24gMjQvMDQvMjQgMTM6
MzgsIENocmlzIFBhY2toYW0gd3JvdGU6DQo+Pj4+Pj4+IE9uIDI0LzA0LzI0IDEyOjU0LCBDaHJp
cyBQYWNraGFtIHdyb3RlOg0KPj4+Pj4+Pj4gSGkgSmVmZiwgQ2h1Y2ssIEdyZWcsDQo+Pj4+Pj4+
Pg0KPj4+Pj4+Pj4gQWZ0ZXIgdXBkYXRpbmcgb25lIG9mIG91ciBidWlsZHMgYWxvbmcgdGhlIDUu
MTUueSBMVFMgYnJhbmNoIG91cg0KPj4+Pj4+Pj4gdGVzdGluZyBjYXVnaHQgYSBuZXcga2VybmVs
IGJ1Zy4gT3V0cHV0IGJlbG93Lg0KPj4+Pj4+Pj4NCj4+Pj4+Pj4+IEkgaGF2ZW4ndCBkdWcgaW50
byBpdCB5ZXQgYnV0IHdvbmRlcmVkIGlmIGl0IHJhbmcgYW55IGJlbGxzLg0KPj4+Pj4+PiBBIGJp
dCBtb3JlIGluZm8uIFRoaXMgaXMgaGFwcGVuaW5nIGF0ICJyZWJvb3QiIGZvciB1cy4gT3VyIGVt
YmVkZGVkDQo+Pj4+Pj4+IGRldmljZXMgdXNlIGEgYml0IG9mIGEgaGFja2VkIHVwIHJlYm9vdCBw
cm9jZXNzIHNvIHRoYXQgdGhleSBjb21lIGJhY2sNCj4+Pj4+Pj4gZmFzdGVyIGluIHRoZSBjYXNl
IG9mIGEgZmFpbHVyZS4NCj4+Pj4+Pj4NCj4+Pj4+Pj4gSXQgZG9lc24ndCBoYXBwZW4gd2l0aCBh
IHByb3BlciBgc3lzdGVtY3RsIHJlYm9vdGAgb3Igd2l0aCBhIFNZU1JRK0INCj4+Pj4+Pj4NCj4+
Pj4+Pj4gSSBjYW4gdHJpZ2dlciBpdCB3aXRoIGBraWxsYWxsIC05IG5mc2RgIHdoaWNoIEknbSBu
b3Qgc3VyZSBpcyBhDQo+Pj4+Pj4+IGNvbXBsZXRlbHkgbGVnaXQgdGhpbmcgdG8gZG8gdG8ga2Vy
bmVsIHRocmVhZHMgYnV0IGl0J3MgcHJvYmFibHkgY2xvc2UNCj4+Pj4+Pj4gdG8gd2hhdCBvdXIg
Y3VzdG9taXplZCByZWJvb3QgZG9lcy4NCj4+Pj4+PiBJJ3ZlIGJpc2VjdGVkIGJldHdlZW4gdjUu
MTUuMTUzIGFuZCB2NS4xNS4xNTUgYW5kIGlkZW50aWZpZWQgY29tbWl0DQo+Pj4+Pj4gZGVjNmI4
YmNhYzczICgibmZzZDogU2ltcGxpZnkgY29kZSBhcm91bmQgc3ZjX2V4aXRfdGhyZWFkKCkgY2Fs
bCBpbg0KPj4+Pj4+IG5mc2QoKSIpIGFzIHRoZSBmaXJzdCBiYWQgY29tbWl0LiBCYXNlZCBvbiB0
aGUgY29udGV4dCB0aGF0IHNlZW1zIHRvDQo+Pj4+Pj4gbGluZSB1cCB3aXRoIG15IHJlcHJvZHVj
dGlvbi4gSSdtIHdvbmRlcmluZyBpZiBwZXJoYXBzIHNvbWV0aGluZyBnb3QNCj4+Pj4+PiBtaXNz
ZWQgb3V0IG9mIHRoZSBzdGFibGUgdHJhY2s/IFVuZm9ydHVuYXRlbHkgSSdtIG5vdCBhYmxlIHRv
IHJ1biBhIG1vcmUNCj4+Pj4+PiByZWNlbnQga2VybmVsIHdpdGggYWxsIG9mIHRoZSBuZnMgcmVs
YXRlZCBzZXR1cCB0aGF0IGlzIGJlaW5nIHVzZWQgb24NCj4+Pj4+PiB0aGUgc3lzdGVtIGluIHF1
ZXN0aW9uLg0KPj4+Pj4gVGhhbmtzIGZvciBiaXNlY3RpbmcsIHRoYXQgd291bGQgaGF2ZSBiZWVu
IG15IGZpcnN0IHN1Z2dlc3Rpb24uDQo+Pj4+Pg0KPj4+Pj4gVGhlIGJhY2twb3J0IGluY2x1ZGVk
IGFsbCBvZiB0aGUgTkZTRCBwYXRjaGVzIHVwIHRvIHY2LjIsIGJ1dA0KPj4+Pj4gdGhlcmUgbWln
aHQgYmUgYSBtaXNzaW5nIHNlcnZlci1zaWRlIFN1blJQQyBwYXRjaC4NCj4+Pj4gU28gZGVjNmI4
YmNhYzczICgibmZzZDogU2ltcGxpZnkgY29kZSBhcm91bmQgc3ZjX2V4aXRfdGhyZWFkKCkNCj4+
Pj4gY2FsbCBpbiAgbmZzZCgpIikgaXMgZnJvbSB2Ni42LCBzbyBpdCB3YXMgYXBwbGllZCB0byB2
NS4xNS55DQo+Pj4+IG9ubHkgdG8gZ2V0IGEgc3Vic2VxdWVudCBORlNEIGZpeCB0byBhcHBseS4N
Cj4+Pj4NCj4+Pj4gVGhlIGltbWVkaWF0ZWx5IHByZXZpb3VzIHVwc3RyZWFtIGNvbW1pdCBpcyBt
aXNzaW5nOg0KPj4+Pg0KPj4+PiAgICAzOTAzOTAyNDAxNDUgKCJuZnNkOiBkb24ndCBhbGxvdyBu
ZnNkIHRocmVhZHMgdG8gYmUgc2lnbmFsbGVkLiIpDQo+Pj4+DQo+Pj4+IEZvciB0ZXN0aW5nLCBJ
J3ZlIGFwcGxpZWQgdGhpcyB0byBteSBuZnNkLTUuMTUueSBicmFuY2ggaGVyZToNCj4+Pj4NCj4+
Pj4gICAgaHR0cHM6Ly9naXQua2VybmVsLm9yZy9wdWIvc2NtL2xpbnV4L2tlcm5lbC9naXQvY2Vs
L2xpbnV4LmdpdA0KPj4+Pg0KPj4+PiBIb3dldmVyIGV2ZW4gaWYgdGhhdCBmaXhlcyB0aGUgcmVw
b3J0ZWQgY3Jhc2gsIHRoaXMgc3VnZ2VzdHMNCj4+Pj4gdGhhdCBhZnRlciB2Ni42LCBuZnNkIHRo
cmVhZHMgYXJlIG5vdCBnb2luZyB0byByZXNwb25kIHRvDQo+Pj4+ICJraWxsYWxsIC05IG5mc2Qi
Lg0KPj4+IEkgdGhpbmsgdGhpcyBsaWtlbHkgaXMgdGhlIHByb2JsZW0uICBUaGUgbmZzZCB0aHJl
YWRzIG11c3QgYmUgYmVpbmcNCj4+PiBraWxsZWQgYnkgYSBzaWduYWwuDQo+Pj4gT25lIG9ubHkg
b3RoZXIgY2F1c2UgZm9yIGFuIG5mc2QgdGhyZWFkIHRvIGV4aXQgaXMgaWYNCj4+PiBzdmNfc2V0
X251bV90aHJlYWRzKCkgaXMgY2FsbGVkLCBhbmQgYWxsIHBsYWNlcyB0aGF0IGNhbGwgdGhhdCBo
b2xkIGENCj4+PiByZWYgb24gdGhlIHNlcnYgc3RydWN0dXJlIHNvIHRoZSBmaW5hbCBwdXQgd29u
J3QgaGFwcGVuIHdoZW4gdGhlIHRocmVhZA0KPj4+IGV4aXRzLg0KPj4+DQo+Pj4gQmVmb3JlIHRo
ZSBwYXRjaCB0aGF0IGJpc2VjdCBmb3VuZCwgdGhlIG5mc2QgdGhyZWFkIHdvdWxkIGV4aXQgd2l0
aA0KPj4+DQo+Pj4gICBzdmNfZ2V0KCk7DQo+Pj4gICBzdmNfZXhpdF90aHJlYWQoKTsNCj4+PiAg
IG5mc2RfcHV0KCk7DQo+Pj4NCj4+PiBUaGlzIGFsc28gaG9sZHMgYSByZWYgYWNyb3NzIHRoZSBz
dmNfZXhpdF90aHJlYWQoKSwgYW5kIGVuc3VyZXMgdGhlDQo+Pj4gZmluYWwgJ3B1dCcgaGFwcGVu
cyBmcm9tIG5mc0RfcHV0KCksIG5vdCBzdmNfcHV0KCkgKGluDQo+Pj4gc3ZjX2V4aXRfdGhyZWFk
KCkpLg0KPj4+DQo+Pj4gQ2hyaXM6IHdoYXQgd2FzIHRoZSBjb250ZXh0IHdoZW4gdGhlIGNyYXNo
IGhhcHBlbmVkPyAgQ291bGQgdGhlIG5mc2QNCj4+PiB0aHJlYWRzIGhhdmUgYmVlbiBzaWduYWxs
ZWQ/ICBUaGF0IGhhc24ndCBiZWVuIHRoZSBzdGFuZGFyZCB3YXkgdG8gc3RvcA0KPj4+IG5mc2Qg
dGhyZWFkcyBmb3IgYSBsb25nIHRpbWUsIHNvIEknbSBhIGxpdHRsZSBzdXJwcmlzZWQgdGhhdCBp
dCBpcw0KPj4+IGhhcHBlbmluZy4NCj4+IFdlIHVzZSBhIGhhY2tlZCB1cCB2ZXJzaW9uIG9mIHNo
dXRkb3duIGZyb20gdXRpbC1saW51eCBhbmQgd2hpY2ggZG9lcyBhDQo+PiBga2lsbCAoLTEsIFNJ
R1RFUk0pO2AgdGhlbiBga2lsbCAoLTEsIFNJR0tJTEwpO2AgKEkgZG9uJ3QgdGhpbmsgdGhhdA0K
Pj4gcGFydGljdWxhciBiZWhhdmlvdXIgaXMgdGhlIGhhY2tlcnkpLiBJJ20gbm90IHN1cmUgaWYg
LTEgd2lsbCBwaWNrIHVwDQo+PiBrZXJuZWwgdGhyZWFkcyBidXQgYmFzZWQgb24gdGhlIHN5bXB0
b21zIGl0IGFwcGVhcnMgdG8gYmUgZG9pbmcgc28gKG9yDQo+PiBtYXliZSBzb21ldGhpbmcgZWxz
ZSBpcyBpbiBpdCdzIFNJR1RFUk0gaGFuZGxlcikuIEkgZG9uJ3QgdGhpbmsgd2Ugd2VyZQ0KPj4g
ZXZlciByZWFsbHkgaW50ZW5kaW5nIHRvIHNlbmQgdGhlIHNpZ25hbHMgdG8gbmZzZCBzbyB3aGV0
aGVyIGl0IGFjdHVhbGx5DQo+PiB0ZXJtaW5hdGVzIG9yIG5vdCBJIGRvbid0IHRoaW5rIGlzIGFu
IGlzc3VlIGZvciB1cy4gSSBjYW4gY29uZmlybSB0aGF0DQo+PiBhcHBseWluZyAzOTAzOTAyNDAx
NDUgcmVzb2x2ZXMgdGhlIHN5bXB0b20gd2Ugd2VyZSBzZWVpbmcuDQo+IEknbSAyLzMgb2YgdGhl
IHdheSB0aHJvdWdoIHRlc3RpbmcgNS4xNS4xNTYgd2l0aCAzOTAzOTAyNDAxNDUNCj4gYXBwbGll
ZCwgc28gaXQgd291bGQgYmUganVzdCBhbm90aGVyIGRheSBiZWZvcmUgSSBjYW4gc2VuZCBhDQo+
IHBhdGNoIHRvIHN0YWJsZUAuDQo+DQo+IE1heSBJIGFkZCBUZXN0ZWQtYnk6IENocmlzIFBhY2to
YW0gPENocmlzLlBhY2toYW1AYWxsaWVkdGVsZXNpcy5jby5uej4gPw0KDQpTdXJlIGdvIGFoZWFk
Lg0K


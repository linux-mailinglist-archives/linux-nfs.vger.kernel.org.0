Return-Path: <linux-nfs+bounces-15341-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id C8F92BE9820
	for <lists+linux-nfs@lfdr.de>; Fri, 17 Oct 2025 17:09:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id DEED55821BC
	for <lists+linux-nfs@lfdr.de>; Fri, 17 Oct 2025 15:04:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 227552F12DB;
	Fri, 17 Oct 2025 15:02:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eNlQy1mE"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED3622F12D2;
	Fri, 17 Oct 2025 15:02:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760713375; cv=none; b=D1jdVoQZQV8KpZB5P716Hvqxte66qOlx2LVUieIBRtGLqyrctOUxQVgMFEOU2EZ7Ezx75/33GoX4+HS4t/R4O3VUd7o6K3pzrhlO5CVH80ZsyvEHx/OqqPiRi/hiNJ7NEBRuq/zGOCqNcwiWRkkISJwr1yPLAzsLr3s+qEnFbcw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760713375; c=relaxed/simple;
	bh=bAZ0BT5xZHOO/NsmoKd/KzC0AdyxPMWSSpt44hrFE+Y=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Bl0u0qU0uMl4HhpupRXBSxLxhFjaXPr6pEfrB16SRoGjsIDQl1hjcCTkEIwTkx9je795dmUN0giPfzcAu+SLnBw3f3ow8FLfCvCiZPRZ/4hdaqyag3T8a/lcO0FCTk4K1WGiOXKBpC7U1TvQZPNDZZHGld8ZfdAqOCraNmfIgqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eNlQy1mE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0DAE7C4CEF9;
	Fri, 17 Oct 2025 15:02:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760713374;
	bh=bAZ0BT5xZHOO/NsmoKd/KzC0AdyxPMWSSpt44hrFE+Y=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=eNlQy1mEhvMOzguI/PVpsWwDoodRrNMmDFypdO7YygFNE+048Ej0AUZaRRUKT0lZL
	 B/71aqKRIDHI+eVEA7nza/JCHECATBOoSZ4ENSbTlVIoRb67rqLrbvZGwBzpm6gzUs
	 PWFe5sVpYIORYXbFlc91BGHSD1sdzr1w3JBzoJduw8vZ0MWhjrjXxsiu9xfGeCE+SN
	 DGEOna0Y56eihEYjfheglQozuHYECePY23PrAzH9OSL3uZL1zz0OVdrrXbhLFt6e22
	 7Iki7kG6tBmrrNTe6Ymu9i4X2iGmZNnt4NGN49ZNscp4s6iWv538NTkqJ8ii9m75mW
	 xle3Yn7TJ6+5g==
Message-ID: <a0accbb0e4ea7ad101dcaecf6ded576fc0c43a56.camel@kernel.org>
Subject: Re: [PATCH v1] NFS: Fix possible NULL pointer dereference in
 nfs_inode_remove_request()
From: Trond Myklebust <trondmy@kernel.org>
To: liubaolin <liubaolin12138@163.com>, anna@kernel.org
Cc: linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org, Baolin Liu
	 <liubaolin@kylinos.cn>
Date: Fri, 17 Oct 2025 11:02:52 -0400
In-Reply-To: <9243fe19-8e38-43e4-8ea4-077fa4512395@163.com>
References: <20251012083957.532330-1-liubaolin12138@163.com>
	 <5f1eb044728420769c5482ea95240717c0748f46.camel@kernel.org>
	 <9243fe19-8e38-43e4-8ea4-077fa4512395@163.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
User-Agent: Evolution 3.56.2 (3.56.2-2.fc42) 
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

T24gRnJpLCAyMDI1LTEwLTE3IGF0IDE0OjU3ICswODAwLCBsaXViYW9saW4gd3JvdGU6Cj4gW1lv
dSBkb24ndCBvZnRlbiBnZXQgZW1haWwgZnJvbSBsaXViYW9saW4xMjEzOEAxNjMuY29tLiBMZWFy
biB3aHkKPiB0aGlzIGlzIGltcG9ydGFudCBhdCBodHRwczovL2FrYS5tcy9MZWFybkFib3V0U2Vu
ZGVySWRlbnRpZmljYXRpb27CoF0KPiAKPiA+IFRoaXMgbW9kaWZpY2F0aW9uIGFkZHJlc3NlcyBh
IHBvdGVudGlhbCBpc3N1ZSBkZXRlY3RlZCBieSBTbWF0Y2gKPiA+IGR1cmluZyBhIHNjYW4gb2Yg
dGhlIE5GUyBjb2RlLiBBZnRlciByZXZpZXdpbmcgdGhlIHJlbGV2YW50IGNvZGUsIEkKPiA+IGNv
bmZpcm1lZCB0aGF0IHRoZSBjaGFuZ2UgaXMgcmVxdWlyZWQgdG8gcmVtb3ZlIHRoZSBwb3RlbnRp
YWwgcmlzay4KPiAKPiAKCkknbSBzb3JyeSwgYnV0IEknbSBzdGlsbCBub3Qgc2VlaW5nIHdoeSB3
ZSBjYW4ndCBqdXN0IHJlbW92ZSB0aGUgY2hlY2sKZm9yIGEgTlVMTCBmb2xpby4KClVuZGVyIHdo
YXQgY2lyY3Vtc3RhbmNlcyBkbyB5b3Ugc2VlIHVzIGNhbGxpbmcKbmZzX2lub2RlX3JlbW92ZV9y
ZXF1ZXN0KCkgd2l0aCBhIHJlcXVlc3QgdGhhdCBoYXMgcmVxLT53Yl9oZWFkID09Ck5VTEw/IEkn
bSBhc2tpbmcgZm9yIGEgY29uY3JldGUgZXhhbXBsZS4KCj4gCj4g5ZyoIDIwMjUvMTAvMTMgMTI6
NDcsIFRyb25kIE15a2xlYnVzdCDlhpnpgZM6Cj4gPiBPbiBTdW4sIDIwMjUtMTAtMTIgYXQgMTY6
MzkgKzA4MDAsIEJhb2xpbiBMaXUgd3JvdGU6Cj4gPiA+IFtZb3UgZG9uJ3Qgb2Z0ZW4gZ2V0IGVt
YWlsIGZyb20gbGl1YmFvbGluMTIxMzhAMTYzLmNvbS4gTGVhcm4gd2h5Cj4gPiA+IHRoaXMgaXMg
aW1wb3J0YW50IGF0Cj4gPiA+IGh0dHBzOi8vYWthLm1zL0xlYXJuQWJvdXRTZW5kZXJJZGVudGlm
aWNhdGlvbsKgXQo+ID4gPiAKPiA+ID4gRnJvbTogQmFvbGluIExpdSA8bGl1YmFvbGluQGt5bGlu
b3MuY24+Cj4gPiA+IAo+ID4gPiBuZnNfcGFnZV90b19mb2xpbyhyZXEtPndiX2hlYWQpIG1heSBy
ZXR1cm4gTlVMTCBpbiBjZXJ0YWluCj4gPiA+IGNvbmRpdGlvbnMsCj4gPiA+IGJ1dCB0aGUgZnVu
Y3Rpb24gZGVyZWZlcmVuY2VzIGZvbGlvLT5tYXBwaW5nIGFuZCBjYWxscwo+ID4gPiBmb2xpb19l
bmRfZHJvcGJlaGluZChmb2xpbykgdW5jb25kaXRpb25hbGx5LiBUaGlzIG1heSBjYXVzZSBhCj4g
PiA+IE5VTEwKPiA+ID4gcG9pbnRlciBkZXJlZmVyZW5jZSBjcmFzaC4KPiA+ID4gCj4gPiA+IEZp
eCB0aGlzIGJ5IGNoZWNraW5nIGZvbGlvIGJlZm9yZSB1c2luZyBpdCBvciBjYWxsaW5nCj4gPiA+
IGZvbGlvX2VuZF9kcm9wYmVoaW5kKCkuCj4gPiA+IAo+ID4gPiBTaWduZWQtb2ZmLWJ5OiBCYW9s
aW4gTGl1IDxsaXViYW9saW5Aa3lsaW5vcy5jbj4KPiA+ID4gLS0tCj4gPiA+IMKgIGZzL25mcy93
cml0ZS5jIHwgMTEgKysrKysrLS0tLS0KPiA+ID4gwqAgMSBmaWxlIGNoYW5nZWQsIDYgaW5zZXJ0
aW9ucygrKSwgNSBkZWxldGlvbnMoLSkKPiA+ID4gCj4gPiA+IGRpZmYgLS1naXQgYS9mcy9uZnMv
d3JpdGUuYyBiL2ZzL25mcy93cml0ZS5jCj4gPiA+IGluZGV4IDBmYjY5MDU3MzZkNS4uZTE0ODMw
OGMxOTIzIDEwMDY0NAo+ID4gPiAtLS0gYS9mcy9uZnMvd3JpdGUuYwo+ID4gPiArKysgYi9mcy9u
ZnMvd3JpdGUuYwo+ID4gPiBAQCAtNzM5LDE3ICs3MzksMTggQEAgc3RhdGljIHZvaWQgbmZzX2lu
b2RlX3JlbW92ZV9yZXF1ZXN0KHN0cnVjdAo+ID4gPiBuZnNfcGFnZSAqcmVxKQo+ID4gPiDCoMKg
wqDCoMKgwqDCoMKgIG5mc19wYWdlX2dyb3VwX2xvY2socmVxKTsKPiA+ID4gwqDCoMKgwqDCoMKg
wqDCoCBpZiAobmZzX3BhZ2VfZ3JvdXBfc3luY19vbl9iaXRfbG9ja2VkKHJlcSwgUEdfUkVNT1ZF
KSkgewo+ID4gPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBzdHJ1Y3QgZm9saW8g
KmZvbGlvID0gbmZzX3BhZ2VfdG9fZm9saW8ocmVxLQo+ID4gPiA+IHdiX2hlYWQpOwo+ID4gPiAt
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBzdHJ1Y3QgYWRkcmVzc19zcGFjZSAqbWFwcGlu
ZyA9IGZvbGlvLT5tYXBwaW5nOwo+ID4gPiAKPiA+ID4gLcKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqAgc3Bpbl9sb2NrKCZtYXBwaW5nLT5pX3ByaXZhdGVfbG9jayk7Cj4gPiA+IMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGlmIChsaWtlbHkoZm9saW8pKSB7Cj4gPiA+ICvCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBzdHJ1Y3QgYWRkcmVzc19z
cGFjZSAqbWFwcGluZyA9IGZvbGlvLQo+ID4gPiA+IG1hcHBpbmc7Cj4gPiA+ICsKPiA+ID4gK8Kg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHNwaW5fbG9jaygmbWFw
cGluZy0+aV9wcml2YXRlX2xvY2spOwo+ID4gPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqAgZm9saW8tPnByaXZhdGUgPSBOVUxMOwo+ID4gPiDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgZm9saW9fY2xlYXJfcHJp
dmF0ZShmb2xpbyk7Cj4gPiA+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoCBjbGVhcl9iaXQoUEdfTUFQUEVELCAmcmVxLT53Yl9oZWFkLQo+ID4gPiA+IHdi
X2ZsYWdzKTsKPiA+ID4gLcKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgfQo+ID4gPiAtwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBzcGluX3VubG9jaygmbWFwcGluZy0+aV9wcml2YXRl
X2xvY2spOwo+ID4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqAgc3Bpbl91bmxvY2soJm1hcHBpbmctPmlfcHJpdmF0ZV9sb2NrKTsKPiA+ID4gCj4gPiA+IC3C
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGZvbGlvX2VuZF9kcm9wYmVoaW5kKGZvbGlvKTsK
PiA+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGZvbGlv
X2VuZF9kcm9wYmVoaW5kKGZvbGlvKTsKPiA+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqAgfQo+ID4gPiDCoMKgwqDCoMKgwqDCoMKgIH0KPiA+ID4gwqDCoMKgwqDCoMKgwqDCoCBuZnNf
cGFnZV9ncm91cF91bmxvY2socmVxKTsKPiA+ID4gCj4gPiA+IC0tCj4gPiA+IDIuMzkuMgo+ID4g
PiAKPiA+IAo+ID4gV2hhdCByZWFzb24gaXMgdGhlcmUgdG8gYmVsaWV2ZSB0aGF0IHdlIGNhbiBl
dmVyIGNhbGwKPiA+IG5mc19pbm9kZV9yZW1vdmVfcmVxdWVzdCgpIHdpdGggYSBOVUxMIHZhbHVl
IGZvciByZXEtPndiX2hlYWQtCj4gPiA+IHdiX2ZvbGlvLCBvciBldmVuIHdpdGggYSBOVUxMIHZh
bHVlIGZvciByZXEtPndiX2hlYWQtPndiX2ZvbGlvLQo+ID4gPiBtYXBwaW5nPwo+ID4gCj4gPiAK
PiAKCi0tIApUcm9uZCBNeWtsZWJ1c3QKTGludXggTkZTIGNsaWVudCBtYWludGFpbmVyLCBIYW1t
ZXJzcGFjZQp0cm9uZG15QGtlcm5lbC5vcmcsIHRyb25kLm15a2xlYnVzdEBoYW1tZXJzcGFjZS5j
b20K



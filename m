Return-Path: <linux-nfs+bounces-15171-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 105D9BD1647
	for <lists+linux-nfs@lfdr.de>; Mon, 13 Oct 2025 06:48:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D07534E461D
	for <lists+linux-nfs@lfdr.de>; Mon, 13 Oct 2025 04:48:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 677AB2BE7B6;
	Mon, 13 Oct 2025 04:48:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R669l89S"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A97923AB8D;
	Mon, 13 Oct 2025 04:48:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760330903; cv=none; b=OslAzPMtZLc6NCe7mLoiqvjQjAT+G3iSf5GgkZy3XWACr5Rx8k16SlzsoirnvINaikUX37ZSKyjopT1OgrOAbpFnae4/4PWRUJUg9jvdOkd+dUuBRbb1HZf99WNjEiu/Hg7p0Bn6wZ6+GWLOh2Cl75nrvlEdIvQVwRveU87bKdE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760330903; c=relaxed/simple;
	bh=68weAbINkre/gflG8W+Yo864+useY00FA5wzAqe5OUs=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ZbMYadvS3UkXixifreT9u1kBlZGuQ1zDaBfFQxQ8j3jRqfqWqN8m6zye8xXI4vJxO0L1P6oNlJa7Zs8dzAO42SadTvi/VEJ/XiTWarWVGgFbM7X3bIci9TxQT7hGkBwFEezuejLSSfogYgqNT4D+wnbioXfZBN7CG3q5HfFERaE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R669l89S; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 274ECC4CEE7;
	Mon, 13 Oct 2025 04:48:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760330902;
	bh=68weAbINkre/gflG8W+Yo864+useY00FA5wzAqe5OUs=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=R669l89S0KcR8LtD6yUXy9YsELcoNpL4mmJZhw/n9RRI6/fiG3zdu+/2ZgSSEIkgY
	 1hyj1Zr42otTUnWQsTSmpov7ZLgFXT6LGC7xuI2M3+1S5VV1g8+p3FJNZmakqH/Krv
	 0M4TpLnsKiyX66JuQYNw0ojzVyvUo6km1YoY/75VQVzVbdJL7mShSE9zvf1dsaikCW
	 88xHpO1zAUz7Ro0j6NDo9GAwAC/f2C76QRZv5PkGIWVSl3bu7NaZpLXRD3XDaKEws3
	 JHtPo5+yAXoaWjPJ3QojeRHl0aOAmMSnrW8qSgSzhT9/KQ1au/JcOQdATAfjFLIKuo
	 fAMo+hHpS28zA==
Message-ID: <5f1eb044728420769c5482ea95240717c0748f46.camel@kernel.org>
Subject: Re: [PATCH v1] NFS: Fix possible NULL pointer dereference in
 nfs_inode_remove_request()
From: Trond Myklebust <trondmy@kernel.org>
To: Baolin Liu <liubaolin12138@163.com>, anna@kernel.org
Cc: linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org, Baolin Liu
	 <liubaolin@kylinos.cn>
Date: Mon, 13 Oct 2025 00:47:54 -0400
In-Reply-To: <20251012083957.532330-1-liubaolin12138@163.com>
References: <20251012083957.532330-1-liubaolin12138@163.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
User-Agent: Evolution 3.56.2 (3.56.2-2.fc42) 
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

T24gU3VuLCAyMDI1LTEwLTEyIGF0IDE2OjM5ICswODAwLCBCYW9saW4gTGl1IHdyb3RlOgo+IFtZ
b3UgZG9uJ3Qgb2Z0ZW4gZ2V0IGVtYWlsIGZyb20gbGl1YmFvbGluMTIxMzhAMTYzLmNvbS4gTGVh
cm4gd2h5Cj4gdGhpcyBpcyBpbXBvcnRhbnQgYXQgaHR0cHM6Ly9ha2EubXMvTGVhcm5BYm91dFNl
bmRlcklkZW50aWZpY2F0aW9uwqBdCj4gCj4gRnJvbTogQmFvbGluIExpdSA8bGl1YmFvbGluQGt5
bGlub3MuY24+Cj4gCj4gbmZzX3BhZ2VfdG9fZm9saW8ocmVxLT53Yl9oZWFkKSBtYXkgcmV0dXJu
IE5VTEwgaW4gY2VydGFpbgo+IGNvbmRpdGlvbnMsCj4gYnV0IHRoZSBmdW5jdGlvbiBkZXJlZmVy
ZW5jZXMgZm9saW8tPm1hcHBpbmcgYW5kIGNhbGxzCj4gZm9saW9fZW5kX2Ryb3BiZWhpbmQoZm9s
aW8pIHVuY29uZGl0aW9uYWxseS4gVGhpcyBtYXkgY2F1c2UgYSBOVUxMCj4gcG9pbnRlciBkZXJl
ZmVyZW5jZSBjcmFzaC4KPiAKPiBGaXggdGhpcyBieSBjaGVja2luZyBmb2xpbyBiZWZvcmUgdXNp
bmcgaXQgb3IgY2FsbGluZwo+IGZvbGlvX2VuZF9kcm9wYmVoaW5kKCkuCj4gCj4gU2lnbmVkLW9m
Zi1ieTogQmFvbGluIExpdSA8bGl1YmFvbGluQGt5bGlub3MuY24+Cj4gLS0tCj4gwqBmcy9uZnMv
d3JpdGUuYyB8IDExICsrKysrKy0tLS0tCj4gwqAxIGZpbGUgY2hhbmdlZCwgNiBpbnNlcnRpb25z
KCspLCA1IGRlbGV0aW9ucygtKQo+IAo+IGRpZmYgLS1naXQgYS9mcy9uZnMvd3JpdGUuYyBiL2Zz
L25mcy93cml0ZS5jCj4gaW5kZXggMGZiNjkwNTczNmQ1Li5lMTQ4MzA4YzE5MjMgMTAwNjQ0Cj4g
LS0tIGEvZnMvbmZzL3dyaXRlLmMKPiArKysgYi9mcy9uZnMvd3JpdGUuYwo+IEBAIC03MzksMTcg
KzczOSwxOCBAQCBzdGF0aWMgdm9pZCBuZnNfaW5vZGVfcmVtb3ZlX3JlcXVlc3Qoc3RydWN0Cj4g
bmZzX3BhZ2UgKnJlcSkKPiDCoMKgwqDCoMKgwqDCoCBuZnNfcGFnZV9ncm91cF9sb2NrKHJlcSk7
Cj4gwqDCoMKgwqDCoMKgwqAgaWYgKG5mc19wYWdlX2dyb3VwX3N5bmNfb25fYml0X2xvY2tlZChy
ZXEsIFBHX1JFTU9WRSkpIHsKPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgc3RydWN0
IGZvbGlvICpmb2xpbyA9IG5mc19wYWdlX3RvX2ZvbGlvKHJlcS0KPiA+d2JfaGVhZCk7Cj4gLcKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgc3RydWN0IGFkZHJlc3Nfc3BhY2UgKm1hcHBpbmcg
PSBmb2xpby0+bWFwcGluZzsKPiAKPiAtwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBzcGlu
X2xvY2soJm1hcHBpbmctPmlfcHJpdmF0ZV9sb2NrKTsKPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqAgaWYgKGxpa2VseShmb2xpbykpIHsKPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqAgc3RydWN0IGFkZHJlc3Nfc3BhY2UgKm1hcHBpbmcgPSBmb2xp
by0KPiA+bWFwcGluZzsKPiArCj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgIHNwaW5fbG9jaygmbWFwcGluZy0+aV9wcml2YXRlX2xvY2spOwo+IMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgZm9saW8tPnByaXZhdGUgPSBO
VUxMOwo+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgZm9s
aW9fY2xlYXJfcHJpdmF0ZShmb2xpbyk7Cj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoCBjbGVhcl9iaXQoUEdfTUFQUEVELCAmcmVxLT53Yl9oZWFkLQo+ID53
Yl9mbGFncyk7Cj4gLcKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgfQo+IC3CoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgIHNwaW5fdW5sb2NrKCZtYXBwaW5nLT5pX3ByaXZhdGVfbG9jayk7
Cj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHNwaW5fdW5s
b2NrKCZtYXBwaW5nLT5pX3ByaXZhdGVfbG9jayk7Cj4gCj4gLcKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqAgZm9saW9fZW5kX2Ryb3BiZWhpbmQoZm9saW8pOwo+ICvCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBmb2xpb19lbmRfZHJvcGJlaGluZChmb2xpbyk7
Cj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgfQo+IMKgwqDCoMKgwqDCoMKgIH0KPiDC
oMKgwqDCoMKgwqDCoCBuZnNfcGFnZV9ncm91cF91bmxvY2socmVxKTsKPiAKPiAtLQo+IDIuMzku
Mgo+IAoKV2hhdCByZWFzb24gaXMgdGhlcmUgdG8gYmVsaWV2ZSB0aGF0IHdlIGNhbiBldmVyIGNh
bGwKbmZzX2lub2RlX3JlbW92ZV9yZXF1ZXN0KCkgd2l0aCBhIE5VTEwgdmFsdWUgZm9yIHJlcS0+
d2JfaGVhZC0KPndiX2ZvbGlvLCBvciBldmVuIHdpdGggYSBOVUxMIHZhbHVlIGZvciByZXEtPndi
X2hlYWQtPndiX2ZvbGlvLQo+bWFwcGluZz8KCgotLSAKVHJvbmQgTXlrbGVidXN0CkxpbnV4IE5G
UyBjbGllbnQgbWFpbnRhaW5lciwgSGFtbWVyc3BhY2UKdHJvbmRteUBrZXJuZWwub3JnLCB0cm9u
ZC5teWtsZWJ1c3RAaGFtbWVyc3BhY2UuY29tCg==



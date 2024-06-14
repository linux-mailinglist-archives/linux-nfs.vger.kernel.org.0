Return-Path: <linux-nfs+bounces-3825-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 433C9908B0A
	for <lists+linux-nfs@lfdr.de>; Fri, 14 Jun 2024 13:47:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E16331F21293
	for <lists+linux-nfs@lfdr.de>; Fri, 14 Jun 2024 11:47:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6D86190487;
	Fri, 14 Jun 2024 11:47:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eSksQ3DW"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9284B13BAC8
	for <linux-nfs@vger.kernel.org>; Fri, 14 Jun 2024 11:47:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718365662; cv=none; b=UxSIRlN+RzxfqZ7CKmif7TdWHl/FaHR9LoXHvjsSteabu4XdGhKa6nEX28U97KbxK2aM6ZzWiddO5kjJlxCjLobfE2DYr9lpAuMNVdmbsVjmAr5NAWF5ATm1gqmzw4mQ8ra0gHft5PiOeJ1EdqD6lBxuaJNEbn0dZ4JGsKI2aNM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718365662; c=relaxed/simple;
	bh=Uk34oud87tfuY142ndlP3wWay8kJCjtucaevDD+bdwg=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ngMHy5RztTvPQVv8h6Xp4jLrNmbF0sHv7IhkIKXn63+yvH8BlKEpXQYBo89t6bkG7uX53Act325M4TNwLQAKv9VEelOApQ9WxzBFku03aYFk8kV4bZFIBh7LHwu91NsGS7H3rPs/enSr1vIVLs7w2BcsjwOctsR0S78yl+4vFx4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eSksQ3DW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B325C2BD10;
	Fri, 14 Jun 2024 11:47:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718365662;
	bh=Uk34oud87tfuY142ndlP3wWay8kJCjtucaevDD+bdwg=;
	h=Subject:From:To:Date:In-Reply-To:References:From;
	b=eSksQ3DWDgsBK3mS7qKAwkZwnPag9KFR7e85e6PdugcQ41Zj2JRbDjQaBPXEEKH6p
	 sCeRnJW6YYWMc6c6/7SO5oaot25S8C5qGQm/W2ueUMWJe1Uo1iSHz4hh16Fn212RRL
	 HuYrbVJK2e/fnGySWIIpYMClnOrt+sF8xKHHk9r/sJ9V/h2zJssb+fSaC/2gNci/k8
	 QS8E030LrP+ICeS43V0CKT1Ouj6MINCFFgfGNe0xuHtsc1N2qz/iHiEoWOkAkA2y3P
	 FZDu2XemX7WYGU7S8Qui3zA+xA97H0RwUbsz69IZAIxOWOX5Sa4G/eUPB47V/vOCsF
	 gqZUCnoTAKpqA==
Message-ID: <c6caff32f8d9620e82a37d0fbd1a641da819c104.camel@kernel.org>
Subject: Re: [PATCH 00/11] LAYOUTRETURN on reboot
From: Jeff Layton <jlayton@kernel.org>
To: trondmy@gmail.com, linux-nfs@vger.kernel.org
Date: Fri, 14 Jun 2024 07:47:40 -0400
In-Reply-To: <20240613050055.854323-1-trond.myklebust@hammerspace.com>
References: <20240613050055.854323-1-trond.myklebust@hammerspace.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
User-Agent: Evolution 3.50.4 (3.50.4-1.fc39) 
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

T24gVGh1LCAyMDI0LTA2LTEzIGF0IDAxOjAwIC0wNDAwLCB0cm9uZG15QGdtYWlsLmNvbSB3cm90
ZToKPiBGcm9tOiBUcm9uZCBNeWtsZWJ1c3QgPHRyb25kLm15a2xlYnVzdEBoYW1tZXJzcGFjZS5j
b20+Cj4gCj4gTm93IHRoYXQgaHR0cHM6Ly9kYXRhdHJhY2tlci5pZXRmLm9yZy9kb2MvZHJhZnQt
aWV0Zi1uZnN2NC1sYXlyZWMvwqBpcwo+IG1vc3RseSBkb25lIHdpdGggdGhlIHJldmlldyBwcm9j
ZXNzLCBJJ2QgbGlrZSB0byBtb3ZlIHRoZSBmaW5hbCBwYXRjaGVzCj4gZm9yIHRoZSBjbGllbnQg
aW1wbGVtZW50YXRpb24gdXBzdHJlYW0uCj4gCj4gVGhlIGZvbGxvd2luZyBwYXRjaCBzZXJpZXMg
dGhlcmVmb3JlIGFkZHMgc3VwcG9ydCB0byB0aGUgZmxleGZpbGVzIHBORlMKPiBkcml2ZXIgc28g
dGhhdCBpZiBhIG1ldGFkYXRhIHNlcnZlciByZWJvb3Qgb2NjdXJzIHdoaWxlIGEgY2xpZW50IGhh
cwo+IGxheW91dHMgb3V0c3RhbmRpbmcsIGFuZCBpcyBwZXJmb3JtaW5nIEkvTywgdGhlbiB0aGUg
Y2xpZW50IHdpbGwgcmVwb3J0Cj4gbGF5b3V0c3RhdHMgYW5kIGxheW91dCBlcnJvcnMgdGhyb3Vn
aCBhIExBWU9VVFJFVFVSTiBkdXJpbmcgdGhlIGdyYWNlCj4gcGVyaW9kLCBhZnRlciB0aGUgbWV0
YWRhdGEgc2VydmVyIGNvbWVzIGJhY2sgdXAuCj4gVGhpcyBoYXMgaW1wbGljYXRpb25zIGZvciBt
aXJyb3JlZCB3b3JrbG9hZHMsIHNpbmNlIGl0IGFsbG93cyB0aGUgY2xpZW50Cj4gdG8gcmVwb3J0
IGV4YWN0bHkgd2hpY2ggbWlycm9yIGRhdGEgaW5zdGFuY2VzIG1heSBoYXZlIGJlZW4gY29ycnVw
dGVkCj4gZHVlIHRvIHRoZSBwcmVzZW5jZSBvZiBlcnJvcnMgZHVyaW5nIFdSSVRFcyBvciBDT01N
SVRzLgo+IAo+IFRyb25kIE15a2xlYnVzdCAoMTEpOgo+IMKgIE5GU3Y0L3BuZnM6IFJlbW92ZSBy
ZWR1bmRhbnQgbGlzdCBjaGVjawo+IMKgIE5GU3Y0LjE6IGNvbnN0aWZ5IHRoZSBzdGF0ZWlkIGFy
Z3VtZW50IGluIG5mczQxX3Rlc3Rfc3RhdGVpZCgpCj4gwqAgTkZTdjQ6IENsZWFuIHVwIGVuY29k
ZV9uZnM0X3N0YXRlaWQoKQo+IMKgIHBORlM6IEFkZCBhIGZsYWcgYXJndW1lbnQgdG8gcG5mc19k
ZXN0cm95X2xheW91dHNfYnljbGlkKCkKPiDCoCBORlN2NC9wbmZzOiBBZGQgc3VwcG9ydCBmb3Ig
dGhlIFBORlNfTEFZT1VUX0ZJTEVfQlVMS19SRVRVUk4gZmxhZwo+IMKgIE5GU3Y0L3BORlM6IEFk
ZCBhIGhlbHBlciB0byBkZWZlciBmYWlsZWQgbGF5b3V0cmV0dXJuIGNhbGxzCj4gwqAgTkZTdjQv
cE5GUzogSGFuZGxlIHNlcnZlciByZWJvb3RzIGluIHBuZnNfcG9jX3JlbGVhc2UoKQo+IMKgIE5G
U3Y0L3BORlM6IFJldHJ5IHRoZSBsYXlvdXQgcmV0dXJuIGxhdGVyIGluIGNhc2Ugb2YgYSB0aW1l
b3V0IG9yCj4gwqDCoMKgIHJlYm9vdAo+IMKgIE5GU3Y0L3BuZnM6IEdpdmUgbmZzNF9wcm9jX2xh
eW91dHJldHVybigpIGEgZmxhZ3MgYXJndW1lbnQKPiDCoCBORlN2NC9wTkZTOiBSZW1vdmUgcmVk
dW5kYW50IGNhbGwgdG8gdW5oYXNoIHRoZSBsYXlvdXQKPiDCoCBORlN2NC9wTkZTOiBEbyBsYXlv
dXQgc3RhdGUgcmVjb3ZlcnkgdXBvbiByZWJvb3QKPiAKPiDCoGZzL25mcy9jYWxsYmFja19wcm9j
LmPCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB8wqDCoCA1ICstCj4gwqBmcy9uZnMv
ZmxleGZpbGVsYXlvdXQvZmxleGZpbGVsYXlvdXQuYyB8wqDCoCAyICstCj4gwqBmcy9uZnMvbmZz
NF9mcy5owqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgfMKgwqAg
MyArLQo+IMKgZnMvbmZzL25mczRwcm9jLmPCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqAgfMKgIDUzICsrKystLQo+IMKgZnMvbmZzL25mczRzdGF0ZS5jwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB8wqDCoCA0ICstCj4gwqBmcy9uZnMvbmZz
NHhkci5jwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgfMKgwqAg
NyArLQo+IMKgZnMvbmZzL3BuZnMuY8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgIHwgMjIzICsrKysrKysrKysrKysrKysrKystLS0tLS0KPiDCoGZzL25m
cy9wbmZzLmjCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oCB8wqAgMzAgKysrLQo+IMKgaW5jbHVkZS9saW51eC9uZnNfZnNfc2IuaMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgIHzCoMKgIDEgKwo+IMKgaW5jbHVkZS9saW51eC9uZnNfeGRyLmjCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgfMKgwqAgMiArLQo+IMKgMTAgZmlsZXMgY2hhbmdlZCwg
MjQ5IGluc2VydGlvbnMoKyksIDgxIGRlbGV0aW9ucygtKQo+IAoKVGhlc2UgaGF2ZSBiZWVuIHVz
ZWQgZm9yIGEgd2hpbGUgaW5zaWRlIG9mIE1ldGEgdnMuIEhhbW1lcnNwYWNlJ3MKc2VydmVycyBh
bmQgaGF2ZSBiZWVuIGJlaGF2aW5nLgoKUmV2aWV3ZWQtYnk6IEplZmYgTGF5dG9uIDxqbGF5dG9u
QGtlcm5lbC5vcmc+Cg==



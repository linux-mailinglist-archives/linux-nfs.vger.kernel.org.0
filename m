Return-Path: <linux-nfs+bounces-14118-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F4B2B48025
	for <lists+linux-nfs@lfdr.de>; Sun,  7 Sep 2025 23:08:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E14747A173F
	for <lists+linux-nfs@lfdr.de>; Sun,  7 Sep 2025 21:07:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 157EB202C30;
	Sun,  7 Sep 2025 21:08:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KzXZ7kzP"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E37471ACEDA
	for <linux-nfs@vger.kernel.org>; Sun,  7 Sep 2025 21:08:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757279329; cv=none; b=M2FUk/3kPf3G3orA7deXG7uzlF8Fg6hBjEOBgKbftJPlGXf3qEBVdYwvtUadUcX5ZOwtX4/olSXUJoaf4/1Djw5V8Tw3wmICg4czQZm0FK1YbufmK3aagcBLMVyj3osKeIScjPK/g0777NTMW3zdJL8FuS8XXp/PtnDjok3IpX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757279329; c=relaxed/simple;
	bh=LkjHkIWUPtUTJnQbekz0Hp5C+u59MzGmK+o46Tlef+k=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=BZ9Q+tFpKRd3JxYgfUufsr/nCpbaHbmgO/ju1K3/FbCOln4uSkv3IFWn7ohu7tYTpdq3QToNHFOpOy/4r1m3j+KZOjzp0mtiXDlYg6eF1GIdG8NEAknX81jBSQd0WUqH03tcshHuMcxQgDcRihkY5uCs/0EZcOos9JGV2h+4CaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KzXZ7kzP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0529FC4CEF0;
	Sun,  7 Sep 2025 21:08:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757279327;
	bh=LkjHkIWUPtUTJnQbekz0Hp5C+u59MzGmK+o46Tlef+k=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=KzXZ7kzPF+C0h5w+6ojiksSLNq4Aux/s80OKlgTQmclf/Jt2gvd38hsWAFH5d8d7x
	 cNuNZBH58CXtC37ZNqiLdJr3lAMLi1BUlkpHcTKYMkx7B0EN2FgP95PQH+khYXB+el
	 u3qi4nO+iQulOq0j7f7wQnTtV/cAibbj8AjzAGdv1k5n4dRUL1eUkE+EvxirdbCQDq
	 bIOc1Difch9Hj+Ty0lyXvvf9owy4s4TxuZ66ayWHZMZA/v3mX3PWpW5uy/9uDD9CXK
	 Q246ugRrOgKwXAUsIAK4AOJDAPMSLrZsSUyZO2bkCxAZbO437HchBQYQcMYGmelyjQ
	 SXpJub/QLl26A==
Message-ID: <8fcebbadae40f048802c3725a231667b8ac25550.camel@kernel.org>
Subject: Re: _nfs4_open_and_get_state() should check d_splice_alias() return
 for error
From: Trond Myklebust <trondmy@kernel.org>
To: rtm@csail.mit.edu, Anna Schumaker <anna@kernel.org>
Cc: linux-nfs@vger.kernel.org
Date: Sun, 07 Sep 2025 17:08:45 -0400
In-Reply-To: <23296.1757267766@localhost>
References: <23296.1757267766@localhost>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
User-Agent: Evolution 3.56.2 (3.56.2-2.fc42) 
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

T24gU3VuLCAyMDI1LTA5LTA3IGF0IDEzOjU2IC0wNDAwLCBydG1AY3NhaWwubWl0LmVkdSB3cm90
ZToKPiBbWW91IGRvbid0IG9mdGVuIGdldCBlbWFpbCBmcm9tIHJ0bUBjc2FpbC5taXQuZWR1LiBM
ZWFybiB3aHkgdGhpcyBpcwo+IGltcG9ydGFudCBhdCBodHRwczovL2FrYS5tcy9MZWFybkFib3V0
U2VuZGVySWRlbnRpZmljYXRpb27CoF0KPiAKPiBJbiB0aGlzIGNvZGUgaW4gZnMvbmZzL25mczRw
cm9jLmMgX25mc19vcGVuX2FuZF9nZXRfc3RhdGUoKToKPiAKPiDCoMKgwqDCoMKgwqDCoCBkZW50
cnkgPSBvcGVuZGF0YS0+ZGVudHJ5Owo+IMKgwqDCoMKgwqDCoMKgIGlmIChkX3JlYWxseV9pc19u
ZWdhdGl2ZShkZW50cnkpKSB7Cj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHN0cnVj
dCBkZW50cnkgKmFsaWFzOwo+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBkX2Ryb3Ao
ZGVudHJ5KTsKPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgYWxpYXMgPSBkX3NwbGlj
ZV9hbGlhcyhpZ3JhYihzdGF0ZS0+aW5vZGUpLCBkZW50cnkpOwo+IMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoCAvKiBkX3NwbGljZV9hbGlhcygpIGNhbid0IGZhaWwgaGVyZSAtIGl0J3Mg
YSBub24tCj4gZGlyZWN0b3J5ICovCj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGlm
IChhbGlhcykgewo+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqAgZHB1dChjdHgtPmRlbnRyeSk7Cj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoCBjdHgtPmRlbnRyeSA9IGRlbnRyeSA9IGFsaWFzOwo+IMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoCB9Cj4gCj4gZF9zcGxpY2VfYWxpYXMoKSBjYW4gZmFpbCwgcmV0
dXJuaW5nIEVSUl9QVFIoLUVMT09QKS4gVGhlbiB0aGlzIGNhbGwKPiBsYXRlciBvbiBjYXVzZXMg
YSBjcmFzaDoKCk5vLiBJdCBjYW4ndCByZXR1cm4gRUxPT1AuCgpUaGUgcmVhc29uIHdoeSBpdCBj
YW4ndCBpcyB0aGF0IE9QX09QRU4gaXMgbm90IGFsbG93ZWQgdG8gcmV0dXJuCk5GUzRfT0sgZm9y
IGFueXRoaW5nIG90aGVyIHRoYW4gYSByZWd1bGFyIGZpbGUuIEhlbmNlIHRoZSBzZXJ2ZXIgY2Fu
bm90CnJldHVybiBhIGRpcmVjdG9yeSwgb3IgYW55dGhpbmcgd2hpY2ggY291bGQgb3RoZXJ3aXNl
IGJlIGFuIGFuY2VzdG9yIHRvCidkZW50cnknLiBIZW5jZSB0aGUgY29tbWVudCBhYm92ZS4uLgoK
CklPVzogWW91ciBpbXBsZW1lbnRhdGlvbiBvZiBPUF9PUEVOIGlzIGJyb2tlbiBiZWNhdXNlIGl0
IG9ubHkgcmV0dXJucwplaXRoZXIgTkZTNEVSUl9OT0VOVCBvciBORlM0X09LLCB3aGVyZWFzIGlu
IHRoaXMgY2FzZSBpdCBzaG91bGQgY2xlYXJseQpoYXZlIHJldHVybiBORlM0RVJSX0lTRElSLgoK
LS0gClRyb25kIE15a2xlYnVzdApMaW51eCBORlMgY2xpZW50IG1haW50YWluZXIsIEhhbW1lcnNw
YWNlCnRyb25kbXlAa2VybmVsLm9yZywgdHJvbmQubXlrbGVidXN0QGhhbW1lcnNwYWNlLmNvbQo=



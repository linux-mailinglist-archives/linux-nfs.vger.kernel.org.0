Return-Path: <linux-nfs+bounces-13188-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E76FAB0E39E
	for <lists+linux-nfs@lfdr.de>; Tue, 22 Jul 2025 20:43:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 215FF1651AB
	for <lists+linux-nfs@lfdr.de>; Tue, 22 Jul 2025 18:43:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7E481E5B70;
	Tue, 22 Jul 2025 18:43:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pEn6x90k"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9386F1B808
	for <linux-nfs@vger.kernel.org>; Tue, 22 Jul 2025 18:43:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753209818; cv=none; b=STh3nis2iHMG1CItutPFFPZCk+W3L4QfBD2jqBo93iUDwCrcqPBvvPmOGdwQdGJ9klVoh3dQ8ksXDd0/PVlOKhsV//gXLCwbu9+N5bspNhmhQyqbirzfhqLtbMUDJXhWgFJ4KFhUg9lS4uktCuhUokHBe0GF489p3LN61V5IHrA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753209818; c=relaxed/simple;
	bh=ODfS0MriTe2BkDH3/8ZqCheu41IF2WEZjajJtc/1ijA=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=j1/Xb3fBisC32iAWWQqAyQ+ft5c+Mr7/9BbipuPkAKhIMiUHsERvKnn2WPjNBYTGuNEy52w+aD32r1eOmBwAww17j4QwSTX5+cJxBH8wOv883d1ElDCQEGqV31LGS2lZrhIWDpcWp7tjLWtYiSDYP0bXta7uyKbTnxwbJsOUXug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pEn6x90k; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7DE5C4CEEB;
	Tue, 22 Jul 2025 18:43:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753209816;
	bh=ODfS0MriTe2BkDH3/8ZqCheu41IF2WEZjajJtc/1ijA=;
	h=Subject:From:To:Date:In-Reply-To:References:From;
	b=pEn6x90kpm4jfLj79Ydq2Ri2YVwlXSK5/juSPuM5j8BaR79ke+1rr/ekMg7PzeR0O
	 9cw1j/BHvOXijSIribUYbVUpT8VTQxgFc6kImKC5DCYpWQY/LerB8IYlu0hl0n1uSP
	 6fvpwk8j5GWN7S1mPQ94GveV8DlOCghMjezdNf3g5IAXHVtPk1eUNz/GesDQZZARHY
	 P0VdCEfQgi5uEeT/wINItZgLFsyk7VF7eLxnhRelDINUrLw/o2J2ZXZFfz4iaMCAMc
	 Frl/ELMkH6jdzV/aGW4ZaakiIdbtee76dtY5J/JtGI9PDXgW/QMX++Jk0WOCURCbUC
	 vun2rc6rgX2kw==
Message-ID: <76c35f2fc9386f3e77defe87375c4ad110618aaf.camel@kernel.org>
Subject: Re: nfs client and io_uring zero copy receive
From: Trond Myklebust <trondmy@kernel.org>
To: Anton Gavriliuk <antosha20xx@gmail.com>, linux-nfs@vger.kernel.org
Date: Tue, 22 Jul 2025 14:43:34 -0400
In-Reply-To: <CAAiJnjqvKAE_dUiCTr8D5UShNK5fxJuUHpP=nDFadF-OYhYbfw@mail.gmail.com>
References: 
	<CAAiJnjqvKAE_dUiCTr8D5UShNK5fxJuUHpP=nDFadF-OYhYbfw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

T24gVHVlLCAyMDI1LTA3LTIyIGF0IDIxOjEwICswMzAwLCBBbnRvbiBHYXZyaWxpdWsgd3JvdGU6
Cj4gSGkKPiAKPiBJIGFtIHRyeWluZyB0byBleGNlZWQgMjAgR0IvcyBkb2luZyBzZXF1ZW50aWFs
IHJlYWQgZnJvbSBhIHNpbmdsZQo+IGZpbGUKPiBvbiB0aGUgbmZzIGNsaWVudC4KPiAKPiBwZXJm
IHRvcCBzaG93cyBleGNlc3NpdmUgbWVtY3B5IHVzYWdlOgo+IAo+IFNhbXBsZXM6IDIzN0sgb2Yg
ZXZlbnQgJ2N5Y2xlczpQJywgNDAwMCBIeiwgRXZlbnQgY291bnQgKGFwcHJveC4pOgo+IDEyMDg3
MjczOTExMiBsb3N0OiAwLzAgZHJvcDogMC8wCj4gT3ZlcmhlYWTCoCBTaGFyZWQgT2JqZWN0wqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIFN5bWJvbAo+IMKgIDIwLDU0
JcKgIFtrZXJuZWxdwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoCBba10gbWVtY3B5Cj4gwqDCoCA2LDUyJcKgIFtuZnNdwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBba10gbmZzX2dlbmVyaWNf
cGdfdGVzdAo+IMKgwqAgNSwxMiXCoCBbbmZzXcKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgW2tdIG5mc19wYWdlX2dyb3VwX2xvY2sKPiDC
oMKgIDQsOTIlwqAgW2tlcm5lbF3CoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgIFtrXSBfY29weV90b19pdGVyCj4gwqDCoCA0LDc5JcKgIFtrZXJuZWxd
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBba10g
Z3JvX2xpc3RfcHJlcGFyZQo+IMKgwqAgMiw3NyXCoCBbbmZzXcKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgW2tdIG5mc19jbGVhcl9yZXF1
ZXN0Cj4gwqDCoCAyLDEwJcKgIFtuZnNdwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBba10KPiBfX25mc19wYWdlaW9fYWRkX3JlcXVlc3QK
PiDCoMKgIDIsMDclwqAgW2tlcm5lbF3CoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgIFtrXSBjaGVja19oZWFwX29iamVjdAo+IMKgwqAgMiwwMCXCoCBb
a2VybmVsXcKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqAgW2tdIF9fc2xhYl9mcmVlCj4gCj4gQ2FuIG5mcyBjbGllbnQgYmUgYWRvcHRlZCB0byB1c2Ug
emVybyBjb3B5ID8sIGZvciBleGFtcGxlIGJ5IHVzaW5nCj4gaW9fdXJpbmcgemVybyBjb3B5IHJ4
Lgo+IAoKVGhlIGNsaWVudCBoYXMgbm8gaWRlYSBpbiB3aGljaCBvcmRlciB0aGUgc2VydmVyIHdp
bGwgcmV0dXJuIHJlcGxpZXMgdG8KdGhlIFJQQyBjYWxscyBpdCBzZW5kcy4gU28gbm8sIGl0IGNh
bid0IHF1ZXVlIHVwIHRob3NlIHJlcGx5IGJ1ZmZlcnMgaW4KYWR2YW5jZS4KClRoZSBvbmx5IHdh
eSB5b3UgY2FuIGF2b2lkIG1lbW9yeSBjb3BpZXMgaGVyZSBpcyB0byB1c2UgUkRNQSB0byBhbGxv
dwp0aGUgc2VydmVyIHRvIHdyaXRlIGl0cyByZXBsaWVzIGRpcmVjdGx5IGludG8gdGhlIGNvcnJl
Y3QgY2xpZW50IHJlYWQKYnVmZmVycy4KCi0tIApUcm9uZCBNeWtsZWJ1c3QKTGludXggTkZTIGNs
aWVudCBtYWludGFpbmVyLCBIYW1tZXJzcGFjZQp0cm9uZG15QGtlcm5lbC5vcmcsIHRyb25kLm15
a2xlYnVzdEBoYW1tZXJzcGFjZS5jb20K



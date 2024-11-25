Return-Path: <linux-nfs+bounces-8216-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 962B49D8D11
	for <lists+linux-nfs@lfdr.de>; Mon, 25 Nov 2024 20:54:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5AA6728E02E
	for <lists+linux-nfs@lfdr.de>; Mon, 25 Nov 2024 19:54:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 325A417E00F;
	Mon, 25 Nov 2024 19:54:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=desy.de header.i=@desy.de header.b="uWGXAE3M"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp-o-3.desy.de (smtp-o-3.desy.de [131.169.56.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82354161328
	for <linux-nfs@vger.kernel.org>; Mon, 25 Nov 2024 19:54:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=131.169.56.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732564478; cv=none; b=BFlRFELmM8E59fuWQMRbJt2QGGBAuQ/wIQ96CqTlvdEzaHU6OJEDa+Tt9zxYBQkiUGeVi2+WGuR99kbO6fnquJJgwxvA/RvUaFpVEtt+Xh1Jbu+eRPjNbPgjiZSzJRhQ69we3ZTsW8ez7d1hGXAtuY5KrvRXFGgesTeHxtxqM6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732564478; c=relaxed/simple;
	bh=c22KSRdUcMipVl67LtNGXIHd3NwcU0ONrh0v6VSOlqw=;
	h=Content-Type:From:Mime-Version:Subject:Message-Id:Date:Cc:To; b=bQjK2fmI7JCrqg8ugA1Z3pqThIVFDyE0dHwyb7GRogUbsJjWCGj7ipHGnUAGHSSis1Q4LsLXmCJo1xl6FqMaojymmyDLH1iQHHrdGgDzAI7tMjtwSryraA6eNe1VQor2hQnWu0kO1K8QuJzLT76emfnaX9mGyPvqV/WOcpBUhB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=desy.de; spf=pass smtp.mailfrom=desy.de; dkim=pass (1024-bit key) header.d=desy.de header.i=@desy.de header.b=uWGXAE3M; arc=none smtp.client-ip=131.169.56.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=desy.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=desy.de
Received: from smtp-o-2.desy.de (smtp-o-2.desy.de [IPv6:2001:638:700:1038::1:9b])
	by smtp-o-3.desy.de (Postfix) with ESMTP id AB04211F81D
	for <linux-nfs@vger.kernel.org>; Mon, 25 Nov 2024 20:54:24 +0100 (CET)
Received: from smtp-buf-2.desy.de (smtp-buf-2.desy.de [IPv6:2001:638:700:1038::1:a5])
	by smtp-o-2.desy.de (Postfix) with ESMTP id B585713F641
	for <linux-nfs@vger.kernel.org>; Mon, 25 Nov 2024 20:54:16 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp-o-2.desy.de B585713F641
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=desy.de; s=default;
	t=1732564456; bh=c22KSRdUcMipVl67LtNGXIHd3NwcU0ONrh0v6VSOlqw=;
	h=From:Subject:Date:Cc:To:From;
	b=uWGXAE3Mmie1gBkyngC+Xw/TwKfhLjkMMT6hukQxSkhIfRpp3GUzhtBGa1EufzZvB
	 yNr74iECibPp/HbJji6c9f8ZvdGPf6k0o+oWKjHvKNf9q+i7Z5CUPlT/fzi5Fj3T4h
	 J97dJRuLxJSeGgNw/cte/c89tZEzo0aQPeV/Oahc=
Received: from smtp-m-1.desy.de (smtp-m-1.desy.de [131.169.56.129])
	by smtp-buf-2.desy.de (Postfix) with ESMTP id A6DC2120038;
	Mon, 25 Nov 2024 20:54:16 +0100 (CET)
Received: from a1722.mx.srv.dfn.de (a1722.mx.srv.dfn.de [IPv6:2001:638:d:c301:acdc:1979:2:e7])
	by smtp-m-1.desy.de (Postfix) with ESMTP id 9D2DB40044;
	Mon, 25 Nov 2024 20:54:16 +0100 (CET)
Received: from smtp-intra-1.desy.de (smtp-intra-1.desy.de [131.169.56.82])
	by a1722.mx.srv.dfn.de (Postfix) with ESMTP id D3168320031;
	Mon, 25 Nov 2024 20:54:15 +0100 (CET)
Received: from z-mbx-2.desy.de (z-mbx-2.desy.de [131.169.55.140])
	by smtp-intra-1.desy.de (Postfix) with ESMTP id BC7078003F;
	Mon, 25 Nov 2024 20:54:15 +0100 (CET)
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
Subject: Re: Any NFSv4+TLS support outside Linux?
Message-Id: <1520828958.41735385.1732564451856.JavaMail.zimbra@z-mbx-2>
Date: Mon, 25 Nov 2024 20:54:11 +0100 (CET)
Cc: Sebastian Feld <sebastian.n.feld@gmail.com>, linux-nfs@vger.kernel.org, 
	linux-nfs@vger.kernel.org
To: Olga Kornievskaia <aglo@umich.edu>
X-ZxMobile-Command: SendMail
X-ZxMobile-Version: 3.19.0
X-Mailer: Zimbra 9.0.0_GA_4612
Thread-Index: RWeJtrAHCMh/SC1e+QmTemiy4Ul/IQ==
Thread-Topic: Any NFSv4+TLS support outside Linux?

77u/U3RhcnRpbmcgdmVyc2lvbiAxMC4wIGRDYWNoZSBORlMgc2VydmVyIGluY2x1ZGluZyBwTkZT
IGhhcyBUTFMgc3VwcG9ydC4NCg0K4oCUIFRpZ3Jhbg0KDQo+IE9uIDUuIE5vdiAyMDI0LCBhdCAx
OToyNywgT2xnYSBLb3JuaWV2c2thaWEgPGFnbG9AdW1pY2guZWR1PiB3cm90ZToNCj4g77u/RnJl
ZUJTRCBjbGllbnQgYW5kIHNlcnZlciBoYXMgTkZTIHdpdGggVExTIHN1cHBvcnQuIE9OVEFQIHNl
cnZlciBoYXMNCj4gTkZTIHdpdGggVExTIHN1cHBvcnQuDQo+IA0KPiBPbiBUdWUsIE5vdiA1LCAy
MDI0IGF0IDEyOjIz4oCvUE0gU2ViYXN0aWFuIEZlbGQNCj4gPHNlYmFzdGlhbi5uLmZlbGRAZ21h
aWwuY29tPiB3cm90ZToNCj4gPg0KPiA+IERvZXMgYW55IG90aGVyIE5GU3Y0IGNsaWVudCBvciBz
ZXJ2ZXIgaW1wbGVtZW50YXRpb24gc3VwcG9ydCBUTFMgYXQgdGhlIG1vbWVudD8NCj4gPg0KPiA+
IFNlYmkNCj4gPiAtLQ0KPiA+IFNlYmFzdGlhbiBGZWxkIC0gSVQgc2VjcnVpdHkgZXhwZXJ0DQo+
ID4NCg==


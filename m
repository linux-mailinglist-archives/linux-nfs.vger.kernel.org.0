Return-Path: <linux-nfs+bounces-11818-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E14C6ABC789
	for <lists+linux-nfs@lfdr.de>; Mon, 19 May 2025 21:00:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7B1177AA06B
	for <lists+linux-nfs@lfdr.de>; Mon, 19 May 2025 18:58:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C208520E338;
	Mon, 19 May 2025 18:59:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=earthlink.net header.i=@earthlink.net header.b="OHr9ONBc"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mta-102a.earthlink-vadesecure.net (mta-102b.earthlink-vadesecure.net [51.81.61.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E3E51DEFE0
	for <linux-nfs@vger.kernel.org>; Mon, 19 May 2025 18:59:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=51.81.61.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747681197; cv=none; b=OU0mnXk0R5cD6vHfHF2zKUshsmC2oUvR+C5tuOqAD4PdmTJCjLwF7nlH2UQf2r7NeBPDLTtNXoVV7SnuKwTJqF7CqNgSJZOccpCZRRQMU8yUnNywL6kCBNqK+BSTVAbKTTCmsMoNFSmsml1QZZsLwHBI7ZneQlRRh/oQqyevS0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747681197; c=relaxed/simple;
	bh=5ZUBCGiCB5by9zu1+zMG7mFV08wlqop2o+XIb7v+Gnc=;
	h=From:To:References:In-Reply-To:Subject:Date:Message-ID:
	 MIME-Version:Content-Type; b=TD9ecWYH/CVAZvLTs8IiB/ffXjN8nentv0P8tpoqfFQxp8tMCDOOZVwnKqB7e5Q8GsE7Gjcg5IzNcxX5BWqSIzm0vuCxUqIY1XR57AFIJz2pNPoTYxdY8Fn8zMiupswlPcOCfDa2YovWg9QOJS/R1k9IuRaJqq8Pc5GouhMx/JA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mindspring.com; spf=pass smtp.mailfrom=mindspring.com; dkim=pass (2048-bit key) header.d=earthlink.net header.i=@earthlink.net header.b=OHr9ONBc; arc=none smtp.client-ip=51.81.61.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mindspring.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mindspring.com
Authentication-Results: earthlink-vadesecure.net;
 auth=pass smtp.auth=ffilzlnx@mindspring.com smtp.mailfrom=ffilzlnx@mindspring.com;
DKIM-Signature: v=1; a=rsa-sha256; bh=5ZUBCGiCB5by9zu1+zMG7mFV08wlqop2o+XIb7
 v+Gnc=; c=relaxed/relaxed; d=earthlink.net; h=from:reply-to:subject:
 date:to:cc:resent-date:resent-from:resent-to:resent-cc:in-reply-to:
 references:list-id:list-help:list-unsubscribe:list-unsubscribe-post:
 list-subscribe:list-post:list-owner:list-archive; q=dns/txt;
 s=dk12062016; t=1747680260; x=1748285060; b=OHr9ONBcvpyESkt65TOWLDOOD+r
 PG/nX1aCr9qNj66s7qaPylMr6Uvx/C/5F2pcwyHLgEi3FhI+XmQAQdQ14Xj6PAqhCA0AV6Q
 RG23mTJLfHBbhkr4/Fcabr7ZWJqXZ40z0+2k3URGUdjMAOqrPNXZjA9POi85h3DMCNXwPMr
 JPdrsHFp3AaqD5JUT8PxKYNEU7tnKE/E3+9HC6PIhB6RlH+mD4UlT72/qognHyn0AialFlr
 2hehIdYhYW6Vtg6SljtNVABp/0o8RcuHSRbQdj9yb6U+bZs8DQPQqvsWQKNYnPEwTaabGc+
 YKAJvwZO0gA5n8iZYxPJo8nFvttN19A==
Received: from FRANKSTHINKPAD ([71.237.148.155])
 by vsel1nmtao02p.internal.vadesecure.com with ngmta
 id 45859d1e-184101efd0208ad0; Mon, 19 May 2025 18:44:20 +0000
From: "Frank Filz" <ffilzlnx@mindspring.com>
To: "'Dan Shelton'" <dan.f.shelton@gmail.com>,
	"'Linux NFS Mailing List'" <linux-nfs@vger.kernel.org>,
	<libtirpc-devel@lists.sourceforge.net>
References: <CANH4o6Pvc7wuB0Yh8sEQDRg59_=rUNtnpgJizZ5mmmGNgY5Qrg@mail.gmail.com> <CAAvCNcBPac+uDC6x_V_jW1q_JCG3yEeCMjvpc869AmBAhti3Xw@mail.gmail.com>
In-Reply-To: <CAAvCNcBPac+uDC6x_V_jW1q_JCG3yEeCMjvpc869AmBAhti3Xw@mail.gmail.com>
Subject: RE: Why TLS and Kerberos are not useful for NFS security Re: [PATCH nfs-utils] exportfs: make "insecure" the default for all exports
Date: Mon, 19 May 2025 11:44:17 -0700
Message-ID: <001201dbc8ee$07bb7920$17326b60$@mindspring.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 15.0
Thread-Index: AQJyGkw7aS4sW1HL42+Ykv9WfTt9zgH8L/wzsp3EnsA=
Content-Language: en-us



> -----Original Message-----
> From: Dan Shelton [mailto:dan.f.shelton@gmail.com]
> Sent: Sunday, May 18, 2025 7:14 PM
> To: Linux NFS Mailing List <linux-nfs@vger.kernel.org>; libtirpc-
> devel@lists.sourceforge.net
> Subject: Re: Why TLS and Kerberos are not useful for NFS security Re: =
[PATCH
> nfs-utils] exportfs: make "insecure" the default for all exports
>=20
> On Wed, 14 May 2025 at 23:51, Martin Wege <martin.l.wege@gmail.com>
> wrote:
> > Interoperability is also a big problem (nay, it's ZERO
> > interoperability), as this is basically a Linux kernel client/kernel
> > server only solution.
> > libtirpc doesn't support TLS, Ganesha doesn't support TLS, so yeah,
> > this is an issue, and not a solution.
> >
> > Fazit: Supporting your argumentation with Kerberos5 or TLS is not =
gonna fly.
>=20
> I tried to add TLS support to libtirpc, but I think it's simply not =
possible. The APIs
> are just not compatible.
> Ganesha folks also tried the same, and failed - their ntirpc would =
require a major
> redesign to support TLS.

For what it's worth, we (Ganesha) are still working on offering TLS. =
There are options (including kTLS) that seem like they would work =
(mostly) for us, the issue is if there needs to be a rekeying =
negotiation.

I can see how once a TLS session is started, we could integrate a ktls =
socket into our ntirpc epoll loop and send and receive packets on the =
TLS session. But when rekeying is necessary, I don't quite see how to =
get back into a library to do that, particularly in a way that still =
uses our epoll loop. That is the same for user space libraries. We have =
looked at OpenSSL and s2n.

We do see a demand for protected RPC sessions for NFS and TLS seems to =
be the best option at the moment.

Frank



Return-Path: <linux-nfs+bounces-5104-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B47593E361
	for <lists+linux-nfs@lfdr.de>; Sun, 28 Jul 2024 03:31:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9CBB11C21218
	for <lists+linux-nfs@lfdr.de>; Sun, 28 Jul 2024 01:31:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E2A93C24;
	Sun, 28 Jul 2024 01:31:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=venev.name header.i=@venev.name header.b="jYnFlMw7"
X-Original-To: linux-nfs@vger.kernel.org
Received: from a1-bg02.venev.name (a1-bg02.venev.name [213.240.239.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5A8C23A0
	for <linux-nfs@vger.kernel.org>; Sun, 28 Jul 2024 01:31:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.240.239.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722130268; cv=none; b=DHoGGYlRqncp6HwcOewkZo83DKqvMqvhxwAw1//GXHPJZcNBl69HbWdQITf9XARrmMieJbbssbsrTpO8Xyj+MHZ6jr52v/thBCTEsdDwTftBvVxd61wbiQStb010DZNXB+Ozr9JuDmB4O6HKnLijoc8n6VqksRaC1nsUo9tmRx4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722130268; c=relaxed/simple;
	bh=JqLJzLHsaxfyz3QqGm1HvJIMN3P/7UP8LdR1OwrSUeM=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=KmkIsOtKjzgHDmMWURP1Crsb33vuDrcUz1xxeTzm3oRyaJNfQG+f7g7RFp/frCTXqiNpieLDGR/EAiOMByITp6yyJp5OwbxtkOlSOCG0gaE2Fyh/8YXo+f0Ze5IoHrVvr/9ZeaZccH8mI8+j0Egp4moGtbqIsqWmaV6DKbRf/dI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=venev.name; spf=pass smtp.mailfrom=venev.name; dkim=pass (4096-bit key) header.d=venev.name header.i=@venev.name header.b=jYnFlMw7; arc=none smtp.client-ip=213.240.239.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=venev.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=venev.name
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=venev.name;
	s=default; h=Content-Transfer-Encoding:Content-Type:Date:To:From:Subject:
	Message-ID:Reply-To:Sender; bh=+bWeS2HQjQd+iTakxuqE4Qz+H2F2//P65ipVcAyX66I=; 
	b=jYnFlMw7gYe7vO6IceZjBsw4YI6uBV798ce9RU3lRyUWyih/tzI7Sv6GP+z54wLh2/oBfgmYAKV
	111gzj7B6v0v7/kc9yYNQeanAG7EW1enEb0NjZ8iJwfspsLK6z1AotnEFS7PPLdBVxvz97owfEgB5
	WNXdjrg2VPP2YWnuDgnLNh9MXdTzWVR8MV9Ghiww4rldoInLf0CVHc70kSaL238NSZgzL1/ihWlv6
	9NCJpUGA0LhK5qkFTh0jmcFZ4ngviZA+35MzzfV1A5NYg//x9UB9xNq6YNrI3Z8PVfasxJDohSupt
	zs/AmfaoTfe/tt6YNkqKq7eaHeBSKWzKKyRJY1PZ15GRF99GmvT8N5/gQRz30Q5wju9B6Gh8tfz2D
	xchdOXcu9kGghuDmuKsuH7/aes/cMH4x5HVZ8kmpDiWboMMwvv91vussiIDzQfi9QuydywJLXtDEn
	rkymCSL3TkEdBsYO1eJOd9NfnzzLpI3ev5ijfTvOB8IFHqfZjifD9FIec/PATluOrnam8DVgNmzHB
	VlooyvZD6+pppmBNC0bbrn+Akns3r4rASxcw4RTCWCfUeUQAXvY5wvFXMt6bq8L5gX/ogvEi3xGcs
	eTHoTInwQWQq8TBX4qF0fhR0m64mWKaxOFl/K+GfPuyJvIOzTBKRSQVylCSAN91+OI0jg=;
Received: from a1-bg02.venev.name ([213.240.239.49] helo=pmx1.venev.name)
	by a1-bg02.venev.name with esmtps
	id 1sXrrZ-000000008Ay-1UAV
	(TLS1.3:TLS_AES_256_GCM_SHA384:256)
	(envelope-from <hristo@venev.name>);
	Sun, 28 Jul 2024 00:34:13 +0000
Received: from plank.m.venev.name ([213.240.239.48])
	by pmx1.venev.name with ESMTPSA
	id PULbEgSSpWbFegAAT9YxdQ
	(envelope-from <hristo@venev.name>); Sun, 28 Jul 2024 00:34:13 +0000
Message-ID: <47219e1df5edbfaf7e8a64ebf543a908511ace85.camel@venev.name>
Subject: Re: kernel 6.10
From: Hristo Venev <hristo@venev.name>
To: Trond Myklebust <trondmy@hammerspace.com>, "dan.aloni@vastdata.com"
	 <dan.aloni@vastdata.com>
Cc: "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
 "blokos@free.fr" <blokos@free.fr>
Date: Sun, 28 Jul 2024 02:34:12 +0200
In-Reply-To: <3bd0bfc1fced855902c8963d03e8041f4452b291.camel@hammerspace.com>
References: <b78c88db-8b3a-4008-94cb-82ae08f0e37b@free.fr>
	 <3feb741cb32edd8c48a458be53d6e3915e6c18ed.camel@hammerspace.com>
	 <zyclq4jtvvtz6vamljvfiw6cgnr763yvycl3ibydybducivhqh@lj2hgweowpsa>
	 <3bd0bfc1fced855902c8963d03e8041f4452b291.camel@hammerspace.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.2 (3.52.2-1.fc40) 
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Sun, 2024-07-21 at 16:40 +0000, Trond Myklebust wrote:
> On Sun, 2024-07-21 at 14:03 +0300, Dan Aloni wrote:
> > On 2024-07-16 16:09:54, Trond Myklebust wrote:
> > > [..]
> > > 	gdb -batch -quiet -ex 'list
> > > *(nfs_folio_find_private_request+0x3c)' -ex quit nfs.ko
> > >=20
> > >=20
> > > I suspect this will show that the problem is occurring inside the
> > > function folio_get_private(), but I'd like to be sure that is the
> > > case.
> >=20
> > I would suspect that `->private_data` gets corrupted somehow. Maybe
> > the folio_test_private() call needs to be protected by either the
> > &mapping->i_private_lock, or folio lock?
> >=20
>=20
> If the problem is indeed happening in "folio_get_private()", then the
> dereferenced address value of 00000000000003a6 would seem to indicate
> that the pointer value of 'folio' itself is screwed up, doesn't it?

The NULL dereference appears to be at the `WARN_ON_ONCE(req->wb_head !=3D
req);` check.

On my kernel the offset inside `nfs_folio_find_private_request` is
+0x3f, but the address is again 0x3a6, meaning that `req` is for some
reason set to 0x356 (the crash is on `cmp %rbp,0x50(%rbp)`).

>=20
> Since the value of 'folio' is being passed directly from
> write_cache_pages() as an argument to all the subsequent functions in
> the stack trace, then I'm somewhat confused.
>=20
> --=20
> Trond Myklebust
> Linux NFS client maintainer, Hammerspace
> trond.myklebust@hammerspace.com
>=20
>=20



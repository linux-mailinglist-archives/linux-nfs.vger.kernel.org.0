Return-Path: <linux-nfs+bounces-5103-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A15493E362
	for <lists+linux-nfs@lfdr.de>; Sun, 28 Jul 2024 03:31:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CBA411C2096D
	for <lists+linux-nfs@lfdr.de>; Sun, 28 Jul 2024 01:31:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51EE424211;
	Sun, 28 Jul 2024 00:57:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=venev.name header.i=@venev.name header.b="kdJykzti"
X-Original-To: linux-nfs@vger.kernel.org
Received: from a1-bg02.venev.name (a1-bg02.venev.name [213.240.239.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 948D21F937
	for <linux-nfs@vger.kernel.org>; Sun, 28 Jul 2024 00:57:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.240.239.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722128273; cv=none; b=aLTTk6WUW63fG8Scd4OnTNZZvO4bcGKreD4gj6xbFn+d9WHJZomu25T4R6MhFNgh2upsAIBQwC/SCSuPqc+bibhLIo1QnbtAq8QLiGMEXbjHBdvs9JzNP0FL65LBGeFT8S1kBY1X1QiLRBmQe/Htr0sqxX4T+Nh8pDewlH2eI4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722128273; c=relaxed/simple;
	bh=Sz/Ne8sFLms1vJ2ItXzoGjLNcJxH9TQzUXvpDbJI4NQ=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=deHmVrPw1B6nswNF6xHQNfav3THgpE3DLhVVzH/ImCyFtwmvzxbBiOwo7YpqkdKb01h54PQQKPHkngXVqxrG7qBXnJUI1Qp5gGORm9pPuBo5zrbPqT73ggNMCPFceYehQuUL26NFodjFKIYZ2C6Gn8dUGsgx9TrbgvhHChceJ40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=venev.name; spf=pass smtp.mailfrom=venev.name; dkim=pass (4096-bit key) header.d=venev.name header.i=@venev.name header.b=kdJykzti; arc=none smtp.client-ip=213.240.239.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=venev.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=venev.name
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=venev.name;
	s=default; h=Content-Transfer-Encoding:Content-Type:Date:To:From:Subject:
	Message-ID:Reply-To:Sender; bh=Iogpad6RkGdJHbgo+vxfT5I91XW3jp+azhrqnFFy1as=; 
	b=kdJykztiC45T5brvEwi1cIGV1fOSYx124DsiagmB//jZzrjXfy3oN29grLZVJU4ukvEyBoJOpcH
	QExcCcpyGX1bMqn9i1zhfBGHqALL56QtUf/mcRwAYC45soqusH82UVTm4MOQSAjs9uARk+eAKkNRu
	wGeMV9tcKHffOOIIvvYqV5ciH+OscXDgLF5IPTIwIwx7p8Yn10mi5J0jFQii97jCrocs0InzwzjR/
	qo0qi0oU5vL4FbJV6zVzVMSF6ZNhWw8kL2tH4804F0HXQxdqhNWvEd09umic/o5QIIms8EPltOnGa
	3S5v87WoKxupGjmtEFjK4QatDTvod1JOAXMsneFopqcUF8BVsPiuPaSI9pI3BF90agyu2vAargpdD
	09P7TaNSr/CckgcxpqVb6GoXoAfr5/l45exYyfoatR/2DOTg+nmjMbMZoo+lK1An09Nm1C8bsf9xR
	5ex0Thpvdqf4KolLauBFHXzRu1+RZAbb0hzEEfOHB7+lyOQahbESlAKW2PdtVJJamhwYE8EBr/Nh2
	0IuuOMi91YiahLGH6l6bH+sB/tE8fpV8futwSKnu7pR7GXwGO6RZLLxhOgjRh+lVKHTL4eAyiqOx3
	/QkDEhxjQovFGHWYiE6KyCfQgpt/fHVWq2cIuDr6CidoEiMXleHZ0lQCCHRL1I8JyRZ+Y=;
Received: from a1-bg02.venev.name ([213.240.239.49] helo=pmx1.venev.name)
	by a1-bg02.venev.name with esmtps
	id 1sXsEJ-000000008bF-0Don
	(TLS1.3:TLS_AES_256_GCM_SHA384:256)
	(envelope-from <hristo@venev.name>);
	Sun, 28 Jul 2024 00:57:43 +0000
Received: from plank.m.venev.name ([213.240.239.48])
	by pmx1.venev.name with ESMTPSA
	id zrMgAoeXpWYigQAAT9YxdQ
	(envelope-from <hristo@venev.name>); Sun, 28 Jul 2024 00:57:43 +0000
Message-ID: <5412f22e497b11c1cd3fc8b8d8f30d372b68cd03.camel@venev.name>
Subject: Re: kernel 6.10
From: Hristo Venev <hristo@venev.name>
To: Trond Myklebust <trondmy@hammerspace.com>, "dan.aloni@vastdata.com"
	 <dan.aloni@vastdata.com>, David Howells <dhowells@redhat.com>
Cc: "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
 "blokos@free.fr" <blokos@free.fr>
Date: Sun, 28 Jul 2024 02:57:42 +0200
In-Reply-To: <47219e1df5edbfaf7e8a64ebf543a908511ace85.camel@venev.name>
References: <b78c88db-8b3a-4008-94cb-82ae08f0e37b@free.fr>
	 <3feb741cb32edd8c48a458be53d6e3915e6c18ed.camel@hammerspace.com>
	 <zyclq4jtvvtz6vamljvfiw6cgnr763yvycl3ibydybducivhqh@lj2hgweowpsa>
	 <3bd0bfc1fced855902c8963d03e8041f4452b291.camel@hammerspace.com>
	 <47219e1df5edbfaf7e8a64ebf543a908511ace85.camel@venev.name>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.2 (3.52.2-1.fc40) 
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Sun, 2024-07-28 at 02:34 +0200, Hristo Venev wrote:
> On Sun, 2024-07-21 at 16:40 +0000, Trond Myklebust wrote:
> > On Sun, 2024-07-21 at 14:03 +0300, Dan Aloni wrote:
> > > On 2024-07-16 16:09:54, Trond Myklebust wrote:
> > > > [..]
> > > > 	gdb -batch -quiet -ex 'list
> > > > *(nfs_folio_find_private_request+0x3c)' -ex quit nfs.ko
> > > >=20
> > > >=20
> > > > I suspect this will show that the problem is occurring inside
> > > > the
> > > > function folio_get_private(), but I'd like to be sure that is
> > > > the
> > > > case.
> > >=20
> > > I would suspect that `->private_data` gets corrupted somehow.
> > > Maybe
> > > the folio_test_private() call needs to be protected by either the
> > > &mapping->i_private_lock, or folio lock?
> > >=20
> >=20
> > If the problem is indeed happening in "folio_get_private()", then
> > the
> > dereferenced address value of 00000000000003a6 would seem to
> > indicate
> > that the pointer value of 'folio' itself is screwed up, doesn't it?
>=20
> The NULL dereference appears to be at the `WARN_ON_ONCE(req->wb_head
> !=3D
> req);` check.
>=20
> On my kernel the offset inside `nfs_folio_find_private_request` is
> +0x3f, but the address is again 0x3a6, meaning that `req` is for some
> reason set to 0x356 (the crash is on `cmp %rbp,0x50(%rbp)`).

... and 0x356 happens to be NETFS_FOLIO_COPY_TO_CACHE. Maybe the
NETFS_RREQ_USE_PGPRIV2 flag is lost somehow?

> >=20
> > Since the value of 'folio' is being passed directly from
> > write_cache_pages() as an argument to all the subsequent functions
> > in
> > the stack trace, then I'm somewhat confused.
> >=20
> > --=20
> > Trond Myklebust
> > Linux NFS client maintainer, Hammerspace
> > trond.myklebust@hammerspace.com
> >=20
> >=20
>=20



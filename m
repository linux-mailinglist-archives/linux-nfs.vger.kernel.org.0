Return-Path: <linux-nfs+bounces-5200-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ECC5E9430FB
	for <lists+linux-nfs@lfdr.de>; Wed, 31 Jul 2024 15:34:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A7B3E2834CA
	for <lists+linux-nfs@lfdr.de>; Wed, 31 Jul 2024 13:34:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62F651B1519;
	Wed, 31 Jul 2024 13:33:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=venev.name header.i=@venev.name header.b="kR6JzRAs"
X-Original-To: linux-nfs@vger.kernel.org
Received: from a1-bg02.venev.name (a1-bg02.venev.name [213.240.239.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E6671B1505
	for <linux-nfs@vger.kernel.org>; Wed, 31 Jul 2024 13:33:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.240.239.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722432831; cv=none; b=TZ22dxJ4GMvHvptxiygPWSdherOpJ4JnzBMhX7+4Ars1rQgq0Q+45c5i6BfoU+Rug4D53dEeHw213FLiCfIFDVnrHka6MV/FegbCFPSjQqgszysPtlTAWPQMw2ez50+TZmGB014yZ7nGFrGGUGjDYi5sBVMioGUOBzauB7xeS+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722432831; c=relaxed/simple;
	bh=6NPU+dqs4Y1NhpRq0CZksz5dVBsK0wDLqfrDEEsfpoY=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Pxn/ybT3uI4Lm2BfG0IXJNFPR0qfuPwGLXnHiSBPl8txT1RhrKt7tCrTD4ACi/zQzQd7ikkSeBQagtVEq6bfa2yMtnMoSOAMw07pD6Qm8uG8/BXqBzzqBbm/OfDIrCxCZp4D9q4kNHKQYEoElAZrgYRuMruF/CWZUE01d/P02ZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=venev.name; spf=pass smtp.mailfrom=venev.name; dkim=pass (4096-bit key) header.d=venev.name header.i=@venev.name header.b=kR6JzRAs; arc=none smtp.client-ip=213.240.239.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=venev.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=venev.name
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=venev.name;
	s=default; h=Content-Transfer-Encoding:Content-Type:Date:To:From:Subject:
	Message-ID:Reply-To:Sender; bh=9RQbIJDp3ePYZ5FrvHKDzcSSI06YKTjK1cHZumUBJyI=; 
	b=kR6JzRAsYm0u1ibIS3xvOWD8gteYzQAYjQgMTU8GAMca05pnspd7l03xHedwhad4/dr+ZEicWKJ
	ICappycZGcrCqy4uWkvnEkYnHEB39IVkRPVVX4cfWgSoPPfV8YkY7YjLkuZojRDrSCPY1Fe3JiozH
	Q31M632k+4exIJbJzQ+maK0wFyv2KJ++eHP0dQR1NJsIFjMfqIDvOKYhFt5du53jW/Tff2hlo+bmp
	5yLrgdhThXefDOOc0MEUTcjpq5qfzymcVds7GzvTwdzdNsW3NvixW5r5VIABhK2fcU/GkrJR2xZGk
	z9XAsHCrk2Pp+eLyZKZG9JHeeVJFpEeHfobd0M9YsphRh4jRhExRBLPa95W4qklVDYKGJzL4Con5P
	EnZubjAgVejQXzbBVmFxgifqtraIIgsCeD0iY9ykvWy4Ec1olEWr2JiD4rWw4ciRGlps1oimXgRya
	tk1ky4RuP+zknfO29NTEFQdvQLjz0ncRw2J60iToUdZQql62f6+dw9v9vH7SPhQL4zTF+dMcuP9S+
	kY3/qakffHyvYO6AtU+CP0ES2gxnESSJoLSOYvk+/pBgB4HwefYi5boadZARFjOESgMJuP86ONMh4
	DmxDXP3Gcdn3PrWnGlL2oN4YbpvDqwYfdr+meVQlWsZF2BQHHOJ17cqwMacV78Y5JVUMM=;
Received: from a1-bg02.venev.name ([213.240.239.49] helo=pmx1.venev.name)
	by a1-bg02.venev.name with esmtps
	id 1sZ9SO-00000000yRL-3MVu
	(TLS1.3:TLS_AES_256_GCM_SHA384:256)
	(envelope-from <hristo@venev.name>);
	Wed, 31 Jul 2024 13:33:32 +0000
Received: from plank.m.venev.name ([212.39.89.14])
	by pmx1.venev.name with ESMTPSA
	id et4PJSs9qmaMiwMAT9YxdQ
	(envelope-from <hristo@venev.name>); Wed, 31 Jul 2024 13:33:32 +0000
Message-ID: <637700fc5d1cb1e16860c1ccb122b4135d8250c4.camel@venev.name>
Subject: Re: kernel 6.10
From: Hristo Venev <hristo@venev.name>
To: blokos <blokos@free.fr>, Dan Aloni <dan.aloni@vastdata.com>
Cc: Trond Myklebust <trondmy@hammerspace.com>, David Howells
 <dhowells@redhat.com>, "linux-nfs@vger.kernel.org"
 <linux-nfs@vger.kernel.org>
Date: Wed, 31 Jul 2024 15:33:31 +0200
In-Reply-To: <72597ba7-2950-4c61-bb77-8c82e573710c@free.fr>
References: <b78c88db-8b3a-4008-94cb-82ae08f0e37b@free.fr>
	 <3feb741cb32edd8c48a458be53d6e3915e6c18ed.camel@hammerspace.com>
	 <zyclq4jtvvtz6vamljvfiw6cgnr763yvycl3ibydybducivhqh@lj2hgweowpsa>
	 <3bd0bfc1fced855902c8963d03e8041f4452b291.camel@hammerspace.com>
	 <47219e1df5edbfaf7e8a64ebf543a908511ace85.camel@venev.name>
	 <5412f22e497b11c1cd3fc8b8d8f30d372b68cd03.camel@venev.name>
	 <sl7cfmykqthhjss3qxeg2aweykff2gurcjqczfry62ne6edrfa@oocwcci6im3o>
	 <72597ba7-2950-4c61-bb77-8c82e573710c@free.fr>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.2 (3.52.2-1.fc40) 
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Sun, 2024-07-28 at 03:39 -0700, blokos wrote:
>=20
> On 7/28/2024 1:33 AM, Dan Aloni wrote:
> > On 2024-07-28 02:57:42, Hristo Venev wrote:
> > > On Sun, 2024-07-28 at 02:34 +0200, Hristo Venev wrote:
> > > > On Sun, 2024-07-21 at 16:40 +0000, Trond Myklebust wrote:
> > > > > On Sun, 2024-07-21 at 14:03 +0300, Dan Aloni wrote:
> > > > > > On 2024-07-16 16:09:54, Trond Myklebust wrote:
> > > > > > > [..]
> > > > > > > 	gdb -batch -quiet -ex 'list
> > > > > > > *(nfs_folio_find_private_request+0x3c)' -ex quit nfs.ko
> > > > > > >=20
> > > > > > >=20
> > > > > > > I suspect this will show that the problem is occurring
> > > > > > > inside
> > > > > > > the
> > > > > > > function folio_get_private(), but I'd like to be sure
> > > > > > > that is
> > > > > > > the
> > > > > > > case.
> > > > > > I would suspect that `->private_data` gets corrupted
> > > > > > somehow.
> > > > > > Maybe
> > > > > > the folio_test_private() call needs to be protected by
> > > > > > either the
> > > > > > &mapping->i_private_lock, or folio lock?
> > > > > >=20
> > > > > If the problem is indeed happening in "folio_get_private()",
> > > > > then
> > > > > the
> > > > > dereferenced address value of 00000000000003a6 would seem to
> > > > > indicate
> > > > > that the pointer value of 'folio' itself is screwed up,
> > > > > doesn't it?
> > > > The NULL dereference appears to be at the `WARN_ON_ONCE(req-
> > > > >wb_head
> > > > !=3D
> > > > req);` check.
> > > >=20
> > > > On my kernel the offset inside `nfs_folio_find_private_request`
> > > > is
> > > > +0x3f, but the address is again 0x3a6, meaning that `req` is
> > > > for some
> > > > reason set to 0x356 (the crash is on `cmp %rbp,0x50(%rbp)`).
> > > ... and 0x356 happens to be NETFS_FOLIO_COPY_TO_CACHE. Maybe the
> > > NETFS_RREQ_USE_PGPRIV2 flag is lost somehow?
> > Seems NETFS_FOLIO_COPY_TO_CACHE relates to fscache use, you are
> > activating that, right?
> >=20
> > Also in addition to my suggestion earlier, I think perhaps we need
> > to
> > use `folio_attach_private` and `folio_detach_private` instead of
> > directly using `folio_set_private`, for which the NFS client seems
> > to be
> > the only direct user.
> On my side Yes, fscache is used

Same here. Disabling caching (by not running cachefilesd; the fsc mount
option is still specified) seems to mitigate the issue. However, we'd
ideally like to keep caching on.


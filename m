Return-Path: <linux-nfs+bounces-11650-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B279AB20FD
	for <lists+linux-nfs@lfdr.de>; Sat, 10 May 2025 04:45:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C71814A791D
	for <lists+linux-nfs@lfdr.de>; Sat, 10 May 2025 02:45:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C84477E9;
	Sat, 10 May 2025 02:44:59 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from neil.brown.name (neil.brown.name [103.29.64.221])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 456CB38B
	for <linux-nfs@vger.kernel.org>; Sat, 10 May 2025 02:44:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.29.64.221
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746845099; cv=none; b=f+wBlWKS2qQEyKOcduAzQHwxOVXeSAQovlZ87m7Jva012B5lt1TWfGxmxUuBer9AGA2uxYfdSNDwoafkSULXZl26VCZJTAJGr+J2YO7wJ98XoUxCu80jQdBVq6e5nmGXg1mzztG4/Cp13qfbd2pooMz3FyuBC1HnkOZMvNoLM1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746845099; c=relaxed/simple;
	bh=6s+YJ321P1+I/HAQhFH0xZY3cKaFqEJPZJo33xgROXE=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=ZLcfiu6zbhnhhWWPcUZK0f1qgsBL/J8YzGCffBHgYkvaeu+LwPagMBWCDnjKx0HhjPEofn8hxdsig096rhwmeRuouBWBDUr/ckjG6fqUsI3wAas9+9T2+53sIzkg/9u7jwMdFFt22MRujOCO6gw0LTUrH6zQrvDAfuCOOV4ziHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brown.name; spf=pass smtp.mailfrom=neil.brown.name; arc=none smtp.client-ip=103.29.64.221
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brown.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=neil.brown.name
Received: from 196.186.233.220.static.exetel.com.au ([220.233.186.196] helo=home.neil.brown.name)
	by neil.brown.name with esmtp (Exim 4.95)
	(envelope-from <mr@neil.brown.name>)
	id 1uDaCk-000c6t-P6;
	Sat, 10 May 2025 02:44:46 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "NeilBrown" <neil@brown.name>
To: paulmck@kernel.org
Cc: "Mike Snitzer" <snitzer@kernel.org>,
 "Chuck Lever" <chuck.lever@oracle.com>,
 "Trond Myklebust" <trondmy@kernel.org>, "Anna Schumaker" <anna@kernel.org>,
 Pali =?utf-8?q?Roh=C3=A1r?= <pali@kernel.org>,
 "Vincent Mailhol" <mailhol.vincent@wanadoo.fr>,
 "Jeff Layton" <jlayton@kernel.org>, linux-nfs@vger.kernel.org
Subject: Re: [PATCH 0/6 v2] nfs_localio: fixes for races and errors from older
 compilers
In-reply-to: <b2e7698b-55e7-485a-84ad-fc81c3af7652@paulmck-laptop>
References: <aB5tZY9ucJigXGFp@kernel.org>,
 <b2e7698b-55e7-485a-84ad-fc81c3af7652@paulmck-laptop>
Date: Sat, 10 May 2025 12:44:46 +1000
Message-id: <174684508631.78981.10657279855545420085@noble.neil.brown.name>

On Sat, 10 May 2025, paulmck@kernel.org wrote:
> On Fri, May 09, 2025 at 05:02:29PM -0400, Mike Snitzer wrote:
> > On Fri, May 09, 2025 at 12:01:19PM -0400, Chuck Lever wrote:
> > > [ adding Paul McK ]
> > >=20
> > > On 5/8/25 8:46 PM, NeilBrown wrote:
> > > > This is a revised version a the earlier series.  I've actually tested
> > > > this time and fixed a few issues including the one that Mike found.
> > >=20
> > > As Mike mentioned in a previous thread, at this point, any fix for this
> > > issue will need to be applied to recent stable kernels as well. This
> > > series looks a bit too complicated for that.
> > >=20
> > > I expect that other subsystems will encounter this issue eventually,
> > > so it would be beneficial to address the root cause. For that purpose, I
> > > think I like Vincent's proposal the best:
> > >=20
> > > https://lore.kernel.org/linux-nfs/8c67a295-8caa-4e53-a764-f691657bbe62@=
wanadoo.fr/raw
> > >=20
> > > None of this is to say that Neil's patches shouldn't be applied. But
> > > perhaps these are not a broad solution to the RCU compilation issue.
> >=20
> > I agree with your suggested approach.  Hopefully Paul agrees and
> > Vincent can polish a patch for near-term inclusion.
>=20
> The main issue that I see with Vincent's patch is that we need the
> asterisks ("*") to remain in order to mesh with the definition of __rcu
> and to work correctly with the "sparse" tool.  The __rcu address space
> applies to the pointed-to data, not the pointer.  So removing the
> asterisks from __rcu_access_pointer() and friends would require the
> various uses of __rcu to move to the other side of the asterisk,
> right?  For example, this:
>=20
> 	struct pci_dev __rcu *pdev;
>=20
> would need to become this:
>=20
> 	struct pci_dev *__rcu pdev
>=20
> And the same for the more than 1,000 other uses of __rcu.
>=20
> Or am I missing something here?  In particular, did it turn out that
> sparse and the other tools were all happy with this change?

Sparse isn't happy with the change.  I think it appears to sparse as:


   __force __kernel struct foo __rcu *

rather than

   struct foo __rcu __force __kernel *

and the last one wins - so sparse sees __kernel last in the upstream
code but sees __rcu last with the patch applied.
Certainly I see messages like:
../include/net/netns/generic.h:46:12: warning: incorrect type in assignment (=
different address spaces)
../include/net/netns/generic.h:46:12:    expected struct net_generic *ng
../include/net/netns/generic.h:46:12:    got struct net_generic [noderef] __r=
cu *

so the __rcu it still seen.

NeilBrown


Return-Path: <linux-nfs+bounces-4776-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D7EB92D45F
	for <lists+linux-nfs@lfdr.de>; Wed, 10 Jul 2024 16:39:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E12B1B2358F
	for <lists+linux-nfs@lfdr.de>; Wed, 10 Jul 2024 14:39:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FF3F193472;
	Wed, 10 Jul 2024 14:39:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MvhXTMjk"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58408192B83;
	Wed, 10 Jul 2024 14:39:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720622351; cv=none; b=sSTynxoiZGLBweqpo7MxqgqcuoK5HQ1yX78/i91sfmRis62RanMLGTF4AtVTzsru2bgyNgMwu7xiXOz1MpQIVLaT+h5liBraqu0jJVhJNnEJYEl/WWaVrOf37j25kqZZ53h5cSL7EcZL8Vpj2xeNeSl1JWGu0GdXsX3UNvzkkuU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720622351; c=relaxed/simple;
	bh=HDNxwvbszF6Dx5LZdBu4NQl7uio3J4IsN1yfmddSyfc=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=s2VtpoTbxC9P7lsLR8xTCzedrQB9oZVwlJLxRx6a/8EpzKOHhWalUv/S8oNZfkubRQhlDnaPgc9OOqv/WLnm9mkzsFEThH18b+EBqsl+tGdSiCImovjJm/Hy9ZtkFTDhKUOS1E096iTjSUqlCru8GQn5X5CcaFS1X9d46WDVDM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MvhXTMjk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B303C32781;
	Wed, 10 Jul 2024 14:39:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720622350;
	bh=HDNxwvbszF6Dx5LZdBu4NQl7uio3J4IsN1yfmddSyfc=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=MvhXTMjklDZrbOss3dkY/T15ejrBo5hebIXpw4POs9E+Op5Zo3Si8UbqI11NPApUE
	 XhOdM01AjibTPQl16tvjGCoYCRRKHTa9a36vh/9lIPBCcM9b704fNy4C+4M6v7vS8P
	 Q1vhSHvpLo/hOG73O9mbHD8Gt5V7Kdu9OmeIsSpsW7lB1ivPfZineKz7Z8G7HKu8qm
	 AytXKfroT8OSaJKxji9XGXM4GLMiXXaHQkqrXNW7ysb4D16spNEOUa7LtHy2LEe8NM
	 y1m9NE/mAK0x4H2cqRF0vK+l0QSCiKldVEY9C/orpL2R+Q764lZ0wG0qtbhfawD/ZU
	 5YuYALoUgtINg==
Message-ID: <dba5e87299d90d3dce0c055046c304196b0941b0.camel@kernel.org>
Subject: Re: [PATCH 0/3] nfsd: plug some filecache refcount leaks
From: Jeff Layton <jlayton@kernel.org>
To: Chuck Lever <chuck.lever@oracle.com>
Cc: Neil Brown <neilb@suse.de>, Olga Kornievskaia <kolga@netapp.com>, Dai
 Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>, Youzhong Yang
 <youzhong@gmail.com>, linux-nfs@vger.kernel.org,
 linux-kernel@vger.kernel.org
Date: Wed, 10 Jul 2024 10:39:08 -0400
In-Reply-To: <Zo6cQ874llzn/Flw@tissot.1015granger.net>
References: <20240710-nfsd-next-v1-0-21fca616ac53@kernel.org>
	 <Zo6cQ874llzn/Flw@tissot.1015granger.net>
Autocrypt: addr=jlayton@kernel.org; prefer-encrypt=mutual;
 keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.4 (3.50.4-1.fc39) 
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2024-07-10 at 10:35 -0400, Chuck Lever wrote:
> On Wed, Jul 10, 2024 at 09:05:30AM -0400, Jeff Layton wrote:
> > Youzhong Yang sent an email to the list (along with some draft
> > patches)
> > that indicated some nfsd_file refcount leaks. I went crawling over
> > the
> > filecache code (again) and found a couple of places where we didn't
> > put
> > references when we should. I'm not sure if it'll fix the problem
> > they
> > reported, but they are bugs.
> >=20
> > Plus, let's start counting nfsd_file allocations. The last patch
> > adds
> > support for this.
> >=20
> > Signed-off-by: Jeff Layton <jlayton@kernel.org>
> > ---
> > Jeff Layton (3):
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 nfsd: fix refcount leak when failing to =
hash nfsd_file
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 nfsd: fix refcount leak when file is unh=
ashed after being
> > found
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 nfsd: count nfsd_file allocations
> >=20
> > =C2=A0fs/nfsd/filecache.c | 14 +++++++++++---
> > =C2=A01 file changed, 11 insertions(+), 3 deletions(-)
> > ---
> > base-commit: 24decb225ed20a5ba46a79f4609e109cb0e4a359
> > change-id: 20240710-nfsd-next-01e2afdebb31
> >=20
> > Best regards,
> > --=20
> > Jeff Layton <jlayton@kernel.org>
> >=20
>=20
> I've browsed these, they seem straightforward.
>=20
> Since this is the week before a merge window, I would like to save
> these and Youzhong's patch for v6.12. The Fixes: tags will get them
> pulled back into the stable kernels once they are merged.
>=20
> 'Salright?
>=20

Agreed. Leaks suck, but they (usually) aren't fatal, and interactions
in the filecache can be...subtle. I wouldn't mind a bit more testing
before we send this on.

Thanks!
--=20
Jeff Layton <jlayton@kernel.org>


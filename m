Return-Path: <linux-nfs+bounces-16982-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id CE47ECAB1BF
	for <lists+linux-nfs@lfdr.de>; Sun, 07 Dec 2025 06:23:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6AD6330900BB
	for <lists+linux-nfs@lfdr.de>; Sun,  7 Dec 2025 05:23:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96A2A2E0418;
	Sun,  7 Dec 2025 05:23:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OwT5MXT9"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BFA12E03F0;
	Sun,  7 Dec 2025 05:23:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765085029; cv=none; b=LZdFuDym9Uid0jev27bvlrM0qkpiUmXUxOt22cVGG4SBifWnXFHE5PF/bUOpuODyPk27TXCHW8X+HJcBlZF/ss4SqTtsX+v1BflmKSC/z8zSMLnsX8WWTrIxBWy1Kn3PdMr/ecCa5DFXtB7ZtwCH1nBXar69cy2R5kJHlImZXyM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765085029; c=relaxed/simple;
	bh=h0u3ccSp7RgQuIj96S6xEAYHUUQSKllyQ70WaTCES2Q=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=aY5zazXSPkSNAu4sv6Ix9jeW3ERqyFV5plzt07R9j3UnaPnFfnbClNnIcTqw/wp51z2pYHaAqbhijuTSqEjvonEd6RwGVGkr8y2VA7X5I3Cwflu+0SgYPWfUZvqS+qcdT9KaxQkdkQtXrzwK4KAinux1a0IJn4qLzz6ReiWeBrY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OwT5MXT9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6DF99C4CEFB;
	Sun,  7 Dec 2025 05:23:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765085028;
	bh=h0u3ccSp7RgQuIj96S6xEAYHUUQSKllyQ70WaTCES2Q=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=OwT5MXT9IdqUL6qZ10/vYecnl/BmGJ53qjmSYzAt6l1Pu5Sd3vx4pcF0GfW2342dH
	 qWQIG2lTgFEtiIgsuFlvteys5VtavNejm7GZcWAW2XKB4iyx7D5C7R2M39bE0mHOtv
	 4exV8OOtoff5XtW9DmncneX68IYEj3AumdaFI5yY8iLqdAdB5J50YlfA/qg4DVgibz
	 SC7C7gTWDC5qWnJ5QaQ1a8tgbuzxawjaLydmdRncfEEq+5qPeuBJ2fQ20PFwlSwhod
	 OcPxygC2BLVH3pZuBvQXs0WcHAshxxU6OTtjYHm3FuQdsD2p8PnP6i2b7EZvHb5LaR
	 /XsZVt3Tj33Xw==
Message-ID: <96a0e826081846120d98e3ca5ec5c001b50ed989.camel@kernel.org>
Subject: Re: [PATCH] nfs/localio: fix regression due to out-of-order
 __put_cred
From: Trond Myklebust <trondmy@kernel.org>
To: Greg KH <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, Mike Snitzer <snitzer@kernel.org>, Zorro Lang
	 <zlang@redhat.com>, linux-nfs@vger.kernel.org
Date: Sun, 07 Dec 2025 00:23:47 -0500
In-Reply-To: <2025120753-cycling-shifty-4967@gregkh>
References: 
	<30a4385509b4daa55512058c02685314adda85d7.1765066510.git.trond.myklebust@hammerspace.com>
	 <2025120753-cycling-shifty-4967@gregkh>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.2 (3.58.2-1.fc43) 
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Sun, 2025-12-07 at 09:42 +0900, Greg KH wrote:
> On Sat, Dec 06, 2025 at 07:24:14PM -0500, Trond Myklebust wrote:
> > From: Mike Snitzer <snitzer@kernel.org>
> >=20
> > commit 3af870aedbff10bfed220e280b57a405e972229f upstream.
> >=20
> > Commit f2060bdc21d7 ("nfs/localio: add refcounting for each iocb IO
> > associated with NFS pgio header") inadvertantly reintroduced the
> > same
> > potential for __put_cred() triggering BUG_ON(cred =3D=3D current->cred)
> > that commit 992203a1fba5 ("nfs/localio: restore creds before
> > releasing
> > pageio data") fixed.
> >=20
> > Fix this by saving and restoring the cred around each
> > {read,write}_iter
> > call within the respective for loop of nfs_local_call_{read,write}.
> >=20
> > Reported-by: Zorro Lang <zlang@redhat.com>
> > Fixes: f2060bdc21d7 ("nfs/localio: add refcounting for each iocb IO
> > associated with NFS pgio header")
> > Cc: <stable@vger.kernel.org> # 6.18.x
> > Signed-off-by: Mike Snitzer <snitzer@kernel.org>
> > Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
> > ---
>=20
> What kernel is this for, just 6.18.y?=C2=A0 And why was the changelog
> rewritten/formatted from the original?
>=20

The patch is just for 6.18.y. It is actually the original patch that
was submitted in the last week of the 6.18-rc series. That patch didn't
make it in before 6.18 was released due to the Thanksgiving holiday,
etc.

When commits 94afb627dfc2 and bff3c841f7bd were merged early in the
6.19 merge window, a port was required in order to match up the fix to
the new "scoped_with_creds()" paradigm. While that port could be
backported as is, it would require pulling in the full framework for
"scoped_with_creds()", hence the preference for just submitting the
original patch.


--=20
Trond Myklebust
Linux NFS client maintainer, Hammerspace
trondmy@kernel.org, trond.myklebust@hammerspace.com


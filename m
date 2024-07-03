Return-Path: <linux-nfs+bounces-4603-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 53EFD9266BB
	for <lists+linux-nfs@lfdr.de>; Wed,  3 Jul 2024 19:07:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 771F01C217C5
	for <lists+linux-nfs@lfdr.de>; Wed,  3 Jul 2024 17:07:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2F3418412F;
	Wed,  3 Jul 2024 17:06:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cY7uyqy5"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E82A183097
	for <linux-nfs@vger.kernel.org>; Wed,  3 Jul 2024 17:06:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720026413; cv=none; b=d1T9f1gNlLd/sknbSmj8+J6f7SEEE3A6k3U+peTRiSfpYDsGxoSS8nHMGxhrdXFgJYqWJrdA/9NDMNPzBzxrlMEoea950g7/7OX/LaZm6yedTe3RZU6c5ZovETE4bZh8+K4EovCPhmCQBNEXkK22rrYc4tkxzpDU0grzBkd3Big=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720026413; c=relaxed/simple;
	bh=ftauPL1KwNs015TxIwpqBwJWyhnEMg7ldYj9ERJpkaM=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ICsNGf+K2gl7NcvEKdSAxASPMdf24HWK+3edQsWMos+IKert97yv8hruG80ABC5q91Dxq25aiL/ouKqkGQmXao+qqBUezneyzRQi4eqmCQGg9nBQ9reuQ9bb5Ed6SGpTyKLFgHjGtnErIZORKma8IIpDDy4txtUI3ijbodKwD00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cY7uyqy5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BDBC6C2BD10;
	Wed,  3 Jul 2024 17:06:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720026413;
	bh=ftauPL1KwNs015TxIwpqBwJWyhnEMg7ldYj9ERJpkaM=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=cY7uyqy5KMp1OeEoHTvEWdcQ/ZNIpkczRo6nfFoeDf0qvUDNlEhBt2uEeggViV5dE
	 RMbwnkb4VMry9IA+4lfok8HkP8A83u9plXyns5fSowqG4yOrEPaN8iPmZi7g2Z40DS
	 S9pdfwbxfDOOny3jxLIDfopiURQAqhFcyd0ohAAs5cO4ExC9+9gSgRVkbhcVbVoZCm
	 R+aU6YwHpPdNkVim0KJy77Woq8aNC/Kbyt3n9d4B779EBGt8Ny9LKvam1rrutsGMBV
	 wzjU9qeuqQ5PjgSSvTSAf/gev9tPYiPYvFItEoMfY3kR1RPfPdyA+T1xJ9QmmCG2Js
	 yi8hlzNDBWK1A==
Message-ID: <4486ee80a487c174ec88c7e12705d99e22ae812a.camel@kernel.org>
Subject: Re: [PATCH v11 00/20] nfs/nfsd: add support for localio
From: Jeff Layton <jlayton@kernel.org>
To: Mike Snitzer <snitzer@kernel.org>, Chuck Lever III
 <chuck.lever@oracle.com>
Cc: Christoph Hellwig <hch@infradead.org>, Linux NFS Mailing List
 <linux-nfs@vger.kernel.org>, Anna Schumaker <anna@kernel.org>, Trond
 Myklebust <trondmy@hammerspace.com>, Neil Brown <neilb@suse.de>, Dave
 Chinner <david@fromorbit.com>
Date: Wed, 03 Jul 2024 13:06:51 -0400
In-Reply-To: <ZoVv4IVNC2dP1EaM@kernel.org>
References: <20240702162831.91604-1-snitzer@kernel.org>
	 <3A583EDC-519C-4820-87E9-F4DC164656DB@oracle.com>
	 <ZoTb-OiUB5z4N8Jy@infradead.org> <ZoURUoz1ZBTZ2sr_@kernel.org>
	 <ZoVdP-S01NOyZqlQ@infradead.org> <ZoVqN7J6vbl0BzIl@kernel.org>
	 <ZoVrqp-EpkPAhTGs@infradead.org>
	 <F1585F6E-8C41-4361-B4FA-F9BD6E26F3A9@oracle.com>
	 <ZoVv4IVNC2dP1EaM@kernel.org>
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

On Wed, 2024-07-03 at 11:36 -0400, Mike Snitzer wrote:
> On Wed, Jul 03, 2024 at 03:24:18PM +0000, Chuck Lever III wrote:
> >=20
> >=20
> > > On Jul 3, 2024, at 11:18=E2=80=AFAM, Christoph Hellwig
> > > <hch@infradead.org> wrote:
> > > The actual way
> > > to find the file struct still would be nasty, but I'll try to
> > > think of
> > > something good for that.
> >=20
> > It is that very code that I've asked to be replaced before this
> > series can be merged. We have a set of patches for improving
> > that aspect that Neil is working on now.
> >=20
> > When Mike presented LOCALIO to me at LSF, my initial suggestion
> > was to use pNFS. I think Jeff had the same reaction.
>=20
> No, Jeff suggested using a O_TMPFILE based thing for localio
> handshake.=C2=A0 But he had the benefit of knowing NFSv3 important for th=
e
> intended localio usecase, so I'm not aware of him having pNFS design
> ideas.
>=20

The other problem with doing this is that if a server is running in a
container, how is it to know that the client is in different container
on the same host, and hence that it can give out a localio layout? We'd
still need some way to detect that anyway, which would probably look a
lot like the localio protocol.

> > IMO the design document should, as part of the problem statement,
> > explain why a pNFS-only solution is not workable.
>=20
> Sure, I can add that.
>=20
> I explained the NFSv3 requirement when we discussed at LSF.
>
> > I'm also concerned about applications in one container being
> > able to reach around existing mount namespace silos into the
> > NFS server container's file systems. Obviously the NFS protocol
> > has its own authorization that would grant permission for that
> > access, but via the network.
>=20
> Jeff also had concerns there (as did I) but we arrived at NFS having
> the ability to do it over network, so doing it with localio
> ultimately
> "OK".=C2=A0 That said, localio isn't taking special action to escape moun=
t
> namespaces (that I'm aware of) and in practice there are no
> requirements to do so.

The one thing I think we need to ensure is that an unauthorized NFS
client on the same kernel can't use this to bypass export permission
checks.

IOW, suppose we have a client and server on the same host. The server
allows the client to access some of its exports, but not all. The rest
are restricted to only certain IP addresses.

Can the client use its localio access to bypass that since it's not
going across the network anymore? Maybe by using open_by_handle_at on
the NFS share on a guessed filehandle? I think we need to ensure that
that isn't possible.

I wonder if it's also worthwhile to gate localio access on an export
option, just out of an abundance of caution.
--=20
Jeff Layton <jlayton@kernel.org>


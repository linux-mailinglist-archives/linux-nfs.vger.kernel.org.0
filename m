Return-Path: <linux-nfs+bounces-4112-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A5EA790F8F0
	for <lists+linux-nfs@lfdr.de>; Thu, 20 Jun 2024 00:28:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 29A4C1F22394
	for <lists+linux-nfs@lfdr.de>; Wed, 19 Jun 2024 22:28:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2EAD15B0FE;
	Wed, 19 Jun 2024 22:28:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aHkXxgAB"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BE4615ADA6
	for <linux-nfs@vger.kernel.org>; Wed, 19 Jun 2024 22:28:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718836122; cv=none; b=BDeTlGb2hhyQjiyg2YgvzmwMbGEtExvrA3PbZH40ByOQyK2folfSngSuq5Hip2+v1y4ZHr/dEjVuye8tvj51fG5OAP+KIipT/BI5s2xbmyvCEKvH7zvkEfLkmVBlp7OfSrhMmdtbOhXejRRzzbrPsUyfWyd8MS+GZq5+oXbvEbo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718836122; c=relaxed/simple;
	bh=ojfMpJE4KauHzSfg54H9KPB1dGRVG6tvraqnQkwpv4w=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=dC4AxE4n7zO/OMWwWBiybz68BN/KPluuO9XMhJEFnfeG16zVcBQHWgOMwlaHwutDgSLki4LjnrUk2lrL0kc4RVgpezf5hWtzzssddj1fqKckUICJ1vLFf1PQdOnyrF3Pk1u3pxEApI6vhHqLx69jJs7RFw6qWaWdKrGaVu0N774=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aHkXxgAB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8518DC2BBFC;
	Wed, 19 Jun 2024 22:28:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718836122;
	bh=ojfMpJE4KauHzSfg54H9KPB1dGRVG6tvraqnQkwpv4w=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=aHkXxgABO9+MJM7CLwqcHXNgx/Lb9gjqI2NLJjcNo4NlUmyOA/ohoLuL3b0ig9DDN
	 bwSjoVioMJAZ2Y9RkNLDYVAAYW8vI84lKIktsTLAHACRFx4K2uSmC4pCgpGC7ynpUy
	 VLNOuhe5DfJ7pLAH3FbyjW37rqULqPxM41niLEI/GPi8TRlqy68kr3AYf0dqad8QpD
	 5HE98XAYLG9shOJbML1a3qgjWn/yw/plHGLBhbNMkWSB+pRJqlPv9RsaQgJgu6Tl/l
	 6m8EaaJX4MhWM8xWSq2H56R511lpe1g8hN3ygCwKS+eL873F0SPF4I/RhpKiwDuvYC
	 e2hqB+AL+dJbQ==
Message-ID: <b16dff668cfcba044bd5992dac9af876e00bba18.camel@kernel.org>
Subject: Re: [PATCH v5 00/19] nfs/nfsd: add support for localio
From: Jeff Layton <jlayton@kernel.org>
To: NeilBrown <neilb@suse.de>
Cc: Christoph Hellwig <hch@infradead.org>, Mike Snitzer
 <snitzer@kernel.org>,  linux-nfs@vger.kernel.org, Chuck Lever
 <chuck.lever@oracle.com>, Trond Myklebust <trondmy@hammerspace.com>,
 snitzer@hammerspace.com
Date: Wed, 19 Jun 2024 18:28:40 -0400
In-Reply-To: <171883136311.14261.10658469664795186377@noble.neil.brown.name>
References: <>, <23aa79999595e0ec5af04795be315de73ec5cfe0.camel@kernel.org>
	 <171883136311.14261.10658469664795186377@noble.neil.brown.name>
Autocrypt: addr=jlayton@kernel.org; prefer-encrypt=mutual;
 keydata=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
 QZIQXVeAA+smfTT0tDrisj1U5x6ZB9b3nBg65kc=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.2 (3.52.2-1.fc40app2) 
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2024-06-20 at 07:09 +1000, NeilBrown wrote:
> On Wed, 19 Jun 2024, Jeff Layton wrote:
> > On Wed, 2024-06-19 at 17:10 +1000, NeilBrown wrote:
> > > On Wed, 19 Jun 2024, Christoph Hellwig wrote:
> > > > What happened to the requirement that all protocol extensions added
> > > > to Linux need to be standardized in IETF RFCs?
> > > >=20
> > > >=20
> > >=20
> > > Is that requirement documented somewhere?  Not that I doubt it, but i=
t
> > > would be nice to know where it is explicit.  I couldn't quickly find
> > > anything in Documentation/
> > >=20
> > > Can we get by without the LOCALIO protocol?
> > >=20
> > > For NFSv4.1 we could use the server_owner4 returned by EXCHANGE_ID.  =
It
> > > is explicitly documented as being usable to determine if two servers =
are
> > > the same.
> > >=20
> > > For NFSv4.0 ... I don't think we should encourage that to be used.
> > >=20
> > > For NFSv3 it is harder.  I'm not as ready to deprecate it as I am for
> > > 4.0.  There is nothing in NFSv3 or MOUNT or NLM that is comparable to
> > > server_owner4.  If krb5 was used there would probably be a server
> > > identity in there that could be used.
> > > I think the server could theoretically return an AUTH_SYS verifier in
> > > each RPC reply and that could be used to identify the server.  I'm no=
t
> > > sure that is a good idea though.
> > >=20
> >=20
> > My idea for v3 was that the localio client could do an O_TMPFILE create
> > on the exported fs and write some random junk to it (a uuid or
> > something). Construct the filehandle for that=C2=A0and then the client =
could
> > try to issue a READ for that filehandle via the NFS server. If it finds
> > that filehandle and the contents are correct then you're on the same
> > host. Then you just close the file and it should clean itself up.
>=20
> I can't see how this would work, but maybe I don't have a good enough
> imagination.
>=20

Maybe I didn't explain it well:

Basically the idea was to create a "unique" file in a filesystem
exported by the local nfsd, and then see if it's accessible at the
expected filehandle via a v3 READ and has the expected contents. If it
is then you can assume localio is possible. O_TMPFILE would just make
it simple to clean up the file after you were done, and would avoid
adding spurious entries to the exported directory tree.

The problem with that method is that it's hard to make it work well
with containers. You'd need to be able to predict which net namespace's
server you were talking to, or somehow make the file be exported by all
of them. That alone makes it difficult to implement.


> The high-level view of the proposed protocol is:
>   - client asks remote server to identify itself.
>   - server returns an identity
>   - client uses local-sideband to ask each local server if it has the
>     given identity.
>=20
> I don't see where an O_TMPFILE could fit into this, or how a different
> high-level approach would be any better.
>
> For NFSv3 the client could ask with a new Program or Version or
> Procedure, or all three.  Or it could ask with a new file-handle or path
> name.  I imagine using a webnfs (rfc2054) multi-component lookup on the
> public filehandle for "/linux/config/server-id" and getting back a
> filehandle which encodes the server ID somehow.  All these seem credible
> options and it is not clear than any one is better than any other.
>=20
> For NFSv4.1 I think that LOCALIO looks a lot like trunking and so using
> exactly the same mechanism to determine if two servers are the same is a
> good idea.
> But then LOCALIO also looks a lot like a new pNFS/DS protocol so maybe
> we should specify that protocol and use GETDEVICELIST or GETDEVICEINFO
> to find the identity of the server.
>
> >=20
> > This is a little less straightforward and efficient than the localio
> > protocol that Mike is proposing, but requires no protocol extensions.
>=20
> I think that if we use anything other than the server-id in the
> EXCHANGE_ID response, then we are defining a new protocol as it is a new
> request which we expect existing servers to ignore or fail, even though
> they have never been tested to ignore/fail that particular request.
>=20
> Of all the options I would guess that a new version for an existing
> protocol would be safest as that is the most likely to have been tested.
> A new RPC program is probably conceptually simplest.  A little hack in
> LOOKUPv3 to detect the public filehandle etc is probably the easiest to
> code, and a new pnfs/ds protocol is probably the cleanest overall
> except that it doesn't support NFSv3.
>=20
> My purpose in all this is not to replace Mike's LOCALIO protocol, but to
> explore the solution space to ensure there is nothing that is obviously
> better.  As yet, I don't think there is.
>=20
>=20

Agreed. Thanks for laying out some alternatives! It's good to consider
other possibilities.

> > =20
> > > Going through the IETF process for something that is entirely private=
 to
> > > Linux seems a bit more than should be necessary..
> > >=20
> >=20
> > Agreed. Given that this our own protocol extension and we don't have
> > any expectation of other clients or servers implementing this, I don't
> > see the point. I do agree that trying to avoid program number conflicts
> > is a good thing though.
> > --=20
> > Jeff Layton <jlayton@kernel.org>
> >=20
>=20

--=20
Jeff Layton <jlayton@kernel.org>


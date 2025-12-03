Return-Path: <linux-nfs+bounces-16866-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 925D3C9EFC2
	for <lists+linux-nfs@lfdr.de>; Wed, 03 Dec 2025 13:26:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EB87A3A7268
	for <lists+linux-nfs@lfdr.de>; Wed,  3 Dec 2025 12:26:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 247762DA763;
	Wed,  3 Dec 2025 12:26:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H/zqGIK1"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F21702D8DB7
	for <linux-nfs@vger.kernel.org>; Wed,  3 Dec 2025 12:26:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764764779; cv=none; b=NeT37qvZH9l714rC12qACScDZkjQ7wduEW/CgwZZmP5OBXzOpxVhrlxIbsN8hoLb8YV3ag1C2bbFmnTgpPz2tTA1gLSLX4SLmFIWEyg8u72y4XxQ81GemqC97K8uLmQ6isvNVzI602KeS01yNbcnvyxB7qBaHGKKBvB8hiHj0DM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764764779; c=relaxed/simple;
	bh=RzOO0t8NS9yCiB5WJt+5PGVRlXgLAzZk5byIPBg65Xk=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=CXQocwk1uxaAnRE/JVfsO0DyHWDAHAgWqiHaamPWcIg7wbTH59VKhvl3cB6uldGFXj6uapOUs4YMV1+Piss8ZeZ98+FbKiMSeho7Zvf8TED0O1kfhtsQoh1qyuH3GIdJSD3anYhV4I4fzoPZkIDzDMWaqFABxK5U59o74gMikbw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H/zqGIK1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0C6BC4CEFB;
	Wed,  3 Dec 2025 12:26:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764764778;
	bh=RzOO0t8NS9yCiB5WJt+5PGVRlXgLAzZk5byIPBg65Xk=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=H/zqGIK1iczMM/QtATl1nezS2NjSQySxUviylni2fMqY6yatNJa4uZRvdFw83Hq2O
	 my+JjnjuJu53WavTtQR4+rMaNEU+X720QxTbc3KSqlbzwpESOW2h9qel1+b81xvXGR
	 DixwHJUWxSeojBR8Ap9AIA0Ra9B7XLauJ1TEBgsbFkZBAT0mYxIgh4fKDDVBVs7OMl
	 36vTgVeZp5OYQFWjLr9l2GOJeC9vgYdZfyEntUEm+eE13YT6PvsKApm9tBbu/1ASdW
	 D+hWeJLRJmWR+iCT83tCxMBgGmvauBQzYNaI8GLhklxiqEXk7ZpGGvyow+lai7YsVV
	 IIWWcVZBeJUAQ==
Message-ID: <eaaa46486ec7b1273adfc1a3bdbf11cb1f557e40.camel@kernel.org>
Subject: Re: [PATCH v2 1/2] nfsd: prevent write delegations when client has
 existing opens
From: Jeff Layton <jlayton@kernel.org>
To: NeilBrown <neil@brown.name>, Chuck Lever <cel@kernel.org>
Cc: Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <dai.ngo@oracle.com>, 
 Tom Talpey <tom@talpey.com>, linux-nfs@vger.kernel.org, Chuck Lever
 <chuck.lever@oracle.com>
Date: Wed, 03 Dec 2025 07:26:16 -0500
In-Reply-To: <176472909957.16766.8691035364646019081@noble.neil.brown.name>
References: <20251202224208.4449-1-cel@kernel.org>
	, <176471811359.16766.18131279195615642514@noble.neil.brown.name>
	, <dc25626e-fae0-401b-93ed-1c4fdf34186c@app.fastmail.com>
	 <176472909957.16766.8691035364646019081@noble.neil.brown.name>
Autocrypt: addr=jlayton@kernel.org; prefer-encrypt=mutual;
 keydata=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
 QZIQXVeAA+smfTT0tDrisj1U5x6ZB9b3nBg65kc=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.2 (3.58.2-1.fc43) 
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2025-12-03 at 13:31 +1100, NeilBrown wrote:
> On Wed, 03 Dec 2025, Chuck Lever wrote:
> >=20
> > On Tue, Dec 2, 2025, at 6:28 PM, NeilBrown wrote:
> > > On Wed, 03 Dec 2025, Chuck Lever wrote:
> > > > From: Chuck Lever <chuck.lever@oracle.com>
> > > >=20
> > > > When a client holds an existing OPEN stateid for a file and then
> > > > requests a new OPEN that could receive a write delegation, the
> > > > server must not grant that delegation. A write delegation promises
> > > > the client it can handle "all opens" locally, but this promise is
> > > > violated when the server is already tracking open state for that
> > > > same client.
> > >=20
> > > Can you please spell out how the promise is violated?
> > > Where RFC 8881, section 10.4 says
> > >=20
> > >    An OPEN_DELEGATE_WRITE delegation allows the client to handle, on =
its
> > >    own, all opens.=20
> > >=20
> > > I interpret that to mean that all open *requests* from the applicatio=
n can
> > > now be handled without reference to the server.
> > > I don't think that "all opens" can reasonably refer to "all existing =
or
> > > future open state for the file".  Is that how you interpret it?
> >=20
> > It is: as long as a client holds a write delegation stateid, that=E2=80=
=99s a
> > promise that the server will inform that client when any other client
> > wants to open that file. In other words, an NFS server can=E2=80=99t of=
fer a
> > write delegation to a client if there is another OPEN on that file.
>=20
> Agreed: "other" client and "another" OPEN.
>=20
> >=20
> > The issue here is about an OPEN that occurred in the past and is still
> > active, not a future OPEN. NFSD was checking for OPENs that other
> > clients had for a file before offering a write delegation, but it does =
not
> > currently check if the /requesting client/ itself has an OPEN stateid f=
or
> > that file.
> >=20
>=20
> I don't see a problem with offering a write delegation when the client
> previously had the same file open.
> Note that a client only ever has one stateid for any given file.  If it
> opens the same file again, it will get the same stateid - with seqid
> incremented.  If it closes the stateid, then it will not have that file
> open at all any more.
>=20
> If the client has the file open for READ, then opens again for WRITE,
> then it does not get "another" open, it gets "the same" open, but with
> different access.  When the client hold a write delegation, then it can
> be sure there is only one open stateid for that file - the one that it
> holds (it cannot hold two for the same file).
>=20
> > The scenario I observed is that the requesting client held an OPEN
> > for SHARED_ACCESS_READ on the file. The code in
> > nfsd4_add_rdaccess_to_wrdeleg() assumes that if NFSD is about
> > to set up a write delegation, the pointer in fi_fds[O_RDONLY] is NULL.
> > That assumption isn=E2=80=99t true if that client still holds the S_A_R=
 OPEN
> > state id, and fi_fds[O_RDONLY] for that file then gets overwritten and
> > the nfsd_file it previously referenced is orphaned.
>=20
> I agree that the current code is flawed.  It needs to allow for the
> possibility that the client already had the file open.  I just don't see
> the justification for withholding a delegation when an open is upgraded
> from read-only to read-write.
>=20
> If the client already holds a READ delegation, then I see that there
> might be a problem.  I don't think there *should* be a problem, but I
> cannot see in the RFC how it would be handled.  Would the existing
> delegation get upgraded the same way that the OPEN stateid is upgraded?=
=20
> Or would a new delegation be issued?  The RFC isn't clear so I don't
> think it can happen (safely).
>=20
> I note that section 10.4 says:
>=20
>     The following is a typical set of conditions that servers might use
>     in deciding whether an OPEN should be delegated:=20
>      ....
>     - There must be no current OPEN conflicting with the requested delega=
tion.
>=20
> That text seems advisory rather than normative.  Does an OPEN from the
> same client conflict with a delegation?  Maybe it depends on your
> perspective.
>=20
> I also note 18.16.3 says:
>=20
>      If another client has a delegation of the file being opened that
>      conflicts with open being done (...), the delegation(s) MUST be
>      recalled,
>=20
> So if the SAME client has a delegation - it doesn't need to be recalled?
>=20
> and
>        In the case of an OPEN_DELEGATE_WRITE delegation, any open by a
>        different client will conflict,
>=20
> Again "different client" - any open by the same client, it would seem,
> does not conflict.
>=20

I agree with Neil here (despite my questioning this on our call
yesterday).

Conceptually, granting a write delegation to a client that already
holds an open stateid for the file doesn't seem problematic. Before
returning that delegation, the client would need to establish open
stateids for any opens that it had granted locally. If it already holds
an open stateid though, then that isn't a problem IMO -- it just has a
head start on establishing them before a DELEGRETURN.
--=20
Jeff Layton <jlayton@kernel.org>


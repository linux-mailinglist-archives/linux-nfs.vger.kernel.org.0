Return-Path: <linux-nfs+bounces-12242-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A8CEAD3556
	for <lists+linux-nfs@lfdr.de>; Tue, 10 Jun 2025 13:51:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2D2C61750EB
	for <lists+linux-nfs@lfdr.de>; Tue, 10 Jun 2025 11:51:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76ACD155322;
	Tue, 10 Jun 2025 11:51:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UT4l85iE"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 509F0262BE
	for <linux-nfs@vger.kernel.org>; Tue, 10 Jun 2025 11:51:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749556270; cv=none; b=b4sNLCoZ/+Ynsz7QD+CSGDyunnU7XTnhVNXeBd6de+cVNiG+KVH7Q2uupWq2DthKmrlEqQ0fQckLx2wHiikI4M9dNk6ir6sPPLNHJ6V99MIKWeJ+jhD3hYAHwiZzFQkRHjhpIE6Cd/QCpYy626feDnoxYAt3Ak6RiovsVsMONTk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749556270; c=relaxed/simple;
	bh=w6cs3iycb97AIzgE4CRKjYDelGJDugRsyKw+GMMgp5M=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=mRk0OCZK9/m08odgjF1qusXZxRra5+yjgkHYaSNcq1Y9tprBoOd48sFF2dkWQiGeo74kFanE9cgxRcsEu78TNILlDeA0DdZzl2YzAZWF/sOnogCegfvK08Tsbx4PmucHqrRkjSViG2GZNSyy6Ycr5jtrvu7/KEC3T4KEimsbUjc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UT4l85iE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83771C4CEED;
	Tue, 10 Jun 2025 11:51:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749556269;
	bh=w6cs3iycb97AIzgE4CRKjYDelGJDugRsyKw+GMMgp5M=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=UT4l85iE/UtubUjbg3PZs5eUQTI3OV8/CKJHmyPKSpblh0GZvojgRNrDjkhYsNmwl
	 O/dFQNKk9DbSxn6A25lJzxFDtTN3bOBfo5HXbFsdROnHX5UYZgWmbcCvx2q5VaMt1k
	 F27P1GX2fn6T0TqcAUGkymfUVCxdDVAO5bsI7YYSd/MpMsE/8LxRSxEzq0MZYGaqGI
	 nFrWzsb6DQu0e0zEfRceXZWbow2xIeG8dwxc6zGIXVdFur0mxO9sARPh/gPCJoGM3y
	 L2haZv4cmbasyul9PiYgDtycAud+WwdZvyYlvde+422VqkzCMHhRoatDTr4TzAnXFo
	 8OyDKlcytNqpw==
Message-ID: <d36eac4fe863a3aafc107b2375d415b091044c46.camel@kernel.org>
Subject: Re: [nfsv4] Re: simple NFSv4.1/4.2 test of remove while holding a
 delegation
From: Jeff Layton <jlayton@kernel.org>
To: Rick Macklem <rick.macklem@gmail.com>, Dai Ngo <dai.ngo@oracle.com>
Cc: NFSv4 <nfsv4@ietf.org>, Linux NFS Mailing List
 <linux-nfs@vger.kernel.org>
Date: Tue, 10 Jun 2025 07:51:08 -0400
In-Reply-To: <CAM5tNy5rBMrqfQ7S6fZNciWovkf8K9tc+cuV7q0MALocyzYV7A@mail.gmail.com>
References: 
	<CAM5tNy7kfqToA8p4-=LOnhvZuk36vocy32U6kgT+561uOWR_iQ@mail.gmail.com>
	 <f84bed7e-e96c-4a7e-95e6-2a28a574947c@oracle.com>
	 <CAM5tNy5rBMrqfQ7S6fZNciWovkf8K9tc+cuV7q0MALocyzYV7A@mail.gmail.com>
Autocrypt: addr=jlayton@kernel.org; prefer-encrypt=mutual;
 keydata=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
 QZIQXVeAA+smfTT0tDrisj1U5x6ZB9b3nBg65kc=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2025-06-09 at 18:06 -0700, Rick Macklem wrote:
> On Mon, Jun 9, 2025 at 5:17=E2=80=AFPM Dai Ngo <dai.ngo@oracle.com> wrote=
:
> >=20
> > On 6/9/25 4:35 PM, Rick Macklem wrote:
> > > Hi,
> > >=20
> > > I hope you don't mind a cross-post, but I thought both groups
> > > might find this interesting...
> > >=20
> > > I have been creating a compound RPC that does REMOVE and
> > > then tries to determine if the file object has been removed and
> > > I was surprised to see quite different results from the Linux knfsd
> > > and Solaris 11.4 NFSv4.1/4.2 servers. I think both these servers
> > > provide FH4_PERSISTENT file handles, although I suppose I
> > > should check that?
> > >=20
> > > First, the test OPEN/CREATEs a regular file called "foo" (only one
> > > hard link) and acquires a write delegation for it.
> > > Then a compound does the following:
> > > ...
> > > REMOVE foo
> > > PUTFH fh for foo
> > > GETATTR
> > >=20
> > > For the Solaris 11.4 server, the server CB_RECALLs the
> > > delegation and then replies NFS4ERR_STALE for the PUTFH above.
> > > (The FreeBSD server currently does the same.)
> > >=20
> > > For a fairly recent Linux (6.12) knfsd, the above replies NFS_OK
> > > with nlinks =3D=3D 0 in the GETATTR reply.
> > >=20
> > > Hmm. So I've looked in RFC8881 (I'm terrible at reading it so I
> > > probably missed something) and I cannot find anything that states
> > > either of the above behaviours is incorrect.

This seems outside the scope of the spec. What you're probably seeing
is just differences in the implementation details of the two servers.

> > > (NFS4ERR_STALE is listed as an error code for PUTFH, but the
> > > description of PUTFH only says that it sets the CFH to the fh arg.
> > > It does not say anything w.r.t. the fh arg. needing to be for a file
> > > that still exists.) Neither of these servers sets
> > > OPEN4_RESULT_PRESERVE_UNLINKED in the OPEN reply.
> > >=20
> > > So, it looks like "file object no longer exists" is indicated either
> > > by a NFS4ERR_STALE reply to either PUTFH or GETATTR
> > > OR
> > > by a successful reply, but with nlinks =3D=3D 0 for the GETATTR reply=
.
> > >=20
> > > To be honest, I kinda like the Linux knfsd version, but I am wonderin=
g
> > > if others think that both of these replies is correct?
> > >=20
> > > Also, is the CB_RECALL needed when the delegation is held by
> > > the same client as the one doing the REMOVE?
> >=20
> > The Linux NFSD detects the delegation belongs to the same client that
> > causes the conflict (due to REMOVE) and skips the CB_RECALL. This is
> > an optimization based on the assumption that the client would handle
> > the conflict locally.
> And then what does the server do with the delegation?
> - Does it just discard it, since the file object has been deleted?
> OR
> - Does it guarantee that a DELEGRETURN done after the REMOVE will
>   still work (which seems to be the case for the 6.12 server I am using f=
or
>   testing).
>=20

The latter. The file on the server is still being held open by virtue
of the fact that the client holds a delegation stateid on it.

The inode will still exist in core (with nlinks =3D=3D 0) until its last
reference is released (here, when the client does the final
DELEGRETURN). Aside from the fact that it's now disconnected from the
filesystem namespace, it's still "alive", and reachable via filehandle.

> >=20
> > If the REMOVE was done by another client, the REMOVE will not complete
> > until the delegation is returned. If the PUTFH comes after the REMOVE
> > was completed, it'll  fail with NFS4ERR_STALE since the file, specified
> > by the file handle, no longer exists.
> Assuming the statement w.r.t. "fail with NFS4ERR_STALE" only applies to
> "REMOVE done by another client" then that sounds fine.
> However if the "fail with NFS4ERR_STALE is supposed for happen after
> REMOVE for same client" then that is not what I am seeing.
> If you are curious, the packet trace is here. (Look at packet#58).
> https://people.freebsd.org/~rmacklem/linux-remove.pcap
>=20
> Btw, in case you are curious why I am doing this testing, I am trying
> to figure out a good way for the FreeBSD client to handle temporary
> files. Typically on POSIX they are done via the syscalls:
>=20
> fd =3D open("foo", O_CREATE ...);
> unlink("foo");
> write(fd,..), write(fd,..)...
> read(fd,...), read(fd,...)...
> close(fd);
>=20
> If this happens quickly and is not too much writing, the writes
> copy data into buffers/pages, the reads read the data out of
> the pages and then it all gets deleted.
>=20

Yep, common pattern.

> Unfortunately, the CB_RECALL forces the NFSv4.n client
> to do WRITE, WRITE,..COMMIT and then DELEGRETURN.
> Then the REMOVE throws all the data away on the NFSv4.n
> server.
> --> As such, I really like not doing the CB_RECALL for "same client".
> My concern is "what happens to the delegation after the file object ("foo=
")
> gets deleted?
> It either needs to be thrown away by the NFSv4.n server or the
> PUTFH, DELEGRETURN needs to work after the REMOVE.

I think the latter. A REMOVE just removes the filename from the
namespace. What happens to the underlying inode/vnode/whathaveyou is
undefined by the protocol. The delegation is effectively holding the
file open, so it needs to continue to exist on the server, just as the
file "foo" in your example above must exist after the unlink().

> Otherwise, the NFSv4.n server may get constipated by the delegations,
> which might be called stale, since the file object has been deleted.
>=20
> --> I can do PUTFH, GETATTR after REMOVE in the same compound,
>      to find out if the file object has been deleted. But then, if a
>      PUTFH, DELEGRETURN fails with NFS4ERR_STALE, can I get
>      away with saying "the server should just discard the delegation as
>      the client already has done so??.
>=20
> Thanks for your comments, rick
>=20

If you still have an outstanding delegation after a REMOVE, then
returning ESTALE on the filehandle at that point seems wrong. The
delegation still exists, so the underlying filehandle should still
exist.

Linux doesn't generally throw back an NFS4ERR_STALE until it just can't
find the inode at all anymore. A dentry holds a reference to the inode,
and open files hold a reference to the dentry. The remove just
disconnects the dentry from the namespace and drops its refcount. When
the DELEGRETURN issues the last close, the inode gets cleaned up and at
that point you can't find it by filehandle anymore.

You probably want to aim for similar behavior in FreeBSD?

> >=20
> > -Dai
> >=20
> > > (I don't think it is, but there is a discussion in 18.25.4 which says
> > > "When the determination above cannot be made definitively because
> > > delegations are being held, they MUST be recalled.." but everything
> > > above that is a may/MAY, so it is not obvious to me if a server reall=
y
> > > needs to case?)
> > >=20
> > > Any comments? Thanks, rick
> > > ps: I am amazed when I learn these things about NFSv4.n after all
> > >        these years.
> > >=20


--=20
Jeff Layton <jlayton@kernel.org>


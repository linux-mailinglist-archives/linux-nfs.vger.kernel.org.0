Return-Path: <linux-nfs+bounces-3827-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A4450908BC7
	for <lists+linux-nfs@lfdr.de>; Fri, 14 Jun 2024 14:34:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B97551C20EAF
	for <lists+linux-nfs@lfdr.de>; Fri, 14 Jun 2024 12:34:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EBAC196C7B;
	Fri, 14 Jun 2024 12:34:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UZDaF0ie"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B7C814D29B
	for <linux-nfs@vger.kernel.org>; Fri, 14 Jun 2024 12:34:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718368474; cv=none; b=WglbvlPySD+wUHyaZCWvB9rYwNwqdyXy6FUJvdnjdAyAhu2lCdo3fxZzGOYrANuq0XwLm9Uj5imhs9J9kr9MiOkW4O2JKG+uLSG5EdUkcvBZ5W22+mjlduI1OGZaimuEw7Q3tmXUwURi/HuCYbQ+WsWaAAoweGMSUACHS40mazE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718368474; c=relaxed/simple;
	bh=LdqkwonQuHSkpD225LJUUHuctdcXwS62rjOBK/WuDMQ=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=iBqSGu3jmINc/6LW0yRWIkB/2g4cvaLCxuQB/0uVwPZpFDb+h9dcZacPaEB+JrRKSnvreAsJpf2h5DgjB0kxdJuaVFyf1xBEOUnknuDNTmtp1LPcZYcQy6JyDbO+0npMUHJC4aomO2hLRvwNtBzSGXmh303K8xOyoT8cB6n1A5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UZDaF0ie; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 787E9C2BD10;
	Fri, 14 Jun 2024 12:34:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718368473;
	bh=LdqkwonQuHSkpD225LJUUHuctdcXwS62rjOBK/WuDMQ=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=UZDaF0ieT5O3ZjJMAY+/wGkyWcJQDpfTKQBQcO68eIlowde0lganQqzLRg5xEDCuX
	 xTt8D9qFM03Ovn8zd+4gfB4l16GyFyqlOUs3V+RpCbV9CMAe6YVFMzfP+qOvXXwgoX
	 Z+9NL711PBVENvDhIvH6klIGE0omJ5Mpe7nM7KoQbe+XGi/5ahjEOH0bwDsFt5KSap
	 cnr+xaThaDzywVkk1quEPTzpxBzne3oualC63HbBtyNmG5mTjLcQxxgH0dfgp/hLNa
	 /RFtDPc/z3EzC9gwlWiUf8mV4O77ThfG6hfYyPyRIUKybMgMc3Lpj/SwsB3QwpjvZX
	 6K3SiZjzN+EIw==
Message-ID: <b9f5ae349c6ff90b90aff43b86bc3de8b8a9f863.camel@kernel.org>
Subject: Re: [PATCH 00/19] OPEN optimisations and Attribute delegations
From: Jeff Layton <jlayton@kernel.org>
To: trondmy@gmail.com, linux-nfs@vger.kernel.org
Cc: chuck.lever@oracle.com
Date: Fri, 14 Jun 2024 08:34:32 -0400
In-Reply-To: <20240613041136.506908-1-trond.myklebust@hammerspace.com>
References: <20240613041136.506908-1-trond.myklebust@hammerspace.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.4 (3.50.4-1.fc39) 
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2024-06-13 at 00:11 -0400, trondmy@gmail.com wrote:
> From: Trond Myklebust <trond.myklebust@hammerspace.com>
>=20
> Now that https://datatracker.ietf.org/doc/draft-ietf-nfsv4-delstid/=C2=A0=
is
> mostly done with the review process, it is time to look at pushing the
> client implementation that we've been working on upstream.
>=20
> The following patch series therefore adds support for the NFSv4.2
> extension to OP_OPEN to allow the client to request that the server
> return either an open stateid or a delegation instead of always sending
> the open stateid whether or not a delegation is returned.
> This allows us to optimise away CLOSE, and hence makes small or cached
> file access significantly more efficient.
>=20
> It also adds support for attribute delegations, which allow the client
> to manage the atime and mtime, and simply inform the server at file
> close time what the values should be. This means that most GETATTR
> operations to retrieve the atime/mtime values while the file is under
> I/O can be optimised away.
>=20
> Finally, we also add support for the detection mechanism that allows the
> client to determine whether or not the server supports the above
> functionality.
>=20
> Lance Shelton (1):
> =C2=A0 NFS: Add a generic callback to return the delegation
>=20
> Trond Myklebust (18):
> =C2=A0 NFSv4: Clean up open delegation return structure
> =C2=A0 NFSv4: Refactor nfs4_opendata_check_deleg()
> =C2=A0 NFSv4: Add new attribute delegation definitions
> =C2=A0 NFSv4: Plumb in XDR support for the new delegation-only setattr op
> =C2=A0 NFSv4: Add CB_GETATTR support for delegated attributes
> =C2=A0 NFSv4: Add a flags argument to the 'have_delegation' callback
> =C2=A0 NFSv4: Add support for delegated atime and mtime attributes
> =C2=A0 NFSv4: Add recovery of attribute delegations
> =C2=A0 NFSv4: Add a capability for delegated attributes
> =C2=A0 NFSv4: Enable attribute delegations
> =C2=A0 NFSv4: Delegreturn must set m/atime when they are delegated
> =C2=A0 NFSv4: Fix up delegated attributes in nfs_setattr
> =C2=A0 NFSv4: Don't request atime/mtime/size if they are delegated to us
> =C2=A0 NFSv4: Add support for the FATTR4_OPEN_ARGUMENTS attribute
> =C2=A0 NFSv4: Detect support for OPEN4_SHARE_ACCESS_WANT_OPEN_XOR_DELEGAT=
ION
> =C2=A0 NFSv4: Add support for OPEN4_RESULT_NO_OPEN_STATEID
> =C2=A0 NFSv4: Ask for a delegation or an open stateid in OPEN
> =C2=A0 Return the delegation when deleting the sillyrenamed file
>=20
> =C2=A0fs/nfs/callback.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=
=C2=A0=C2=A0 5 +-
> =C2=A0fs/nfs/callback_proc.c=C2=A0=C2=A0=C2=A0 |=C2=A0 14 ++-
> =C2=A0fs/nfs/callback_xdr.c=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 39 ++++++-
> =C2=A0fs/nfs/delegation.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 59 =
++++++----
> =C2=A0fs/nfs/delegation.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 45 =
+++++++-
> =C2=A0fs/nfs/dir.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 2 +-
> =C2=A0fs/nfs/file.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 4 +-
> =C2=A0fs/nfs/inode.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 | 104 +++++++++++++++--
> =C2=A0fs/nfs/nfs3proc.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=
=C2=A0 10 +-
> =C2=A0fs/nfs/nfs4proc.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=
 230 ++++++++++++++++++++++++++++----------
> =C2=A0fs/nfs/nfs4xdr.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 | 131 +++++++++++++++++-----
> =C2=A0fs/nfs/proc.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 |=C2=A0 10 +-
> =C2=A0fs/nfs/read.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 3 +
> =C2=A0fs/nfs/unlink.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 |=C2=A0=C2=A0 2 +
> =C2=A0fs/nfs/write.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 |=C2=A0 11 +-
> =C2=A0include/linux/nfs4.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 11 ++
> =C2=A0include/linux/nfs_fs_sb.h |=C2=A0=C2=A0 2 +
> =C2=A0include/linux/nfs_xdr.h=C2=A0=C2=A0 |=C2=A0 45 +++++++-
> =C2=A0include/uapi/linux/nfs4.h |=C2=A0=C2=A0 4 +
> =C2=A019 files changed, 586 insertions(+), 145 deletions(-)
>=20

This all looks pretty reasonable except for the last two patches.
Probably, they should be squashed together since there is no caller of
->return_delegation until the last one. There is also nothing
describing the changes there, and I think it could use some explanation
(though I think I get what you're doing).

Finally, I suppose we need to look at implementing support delstid in
knfsd as well. I'll open a new feature request for that the linux-nfs
project on github.

In any case, you can add:

Reviewed-by: Jeff Layton <jlayton@kernel.org>


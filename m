Return-Path: <linux-nfs+bounces-22071-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wF3KCHadGWq7xwgAu9opvQ
	(envelope-from <linux-nfs+bounces-22071-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Fri, 29 May 2026 16:06:46 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6958F60343D
	for <lists+linux-nfs@lfdr.de>; Fri, 29 May 2026 16:06:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 641333044BA8
	for <lists+linux-nfs@lfdr.de>; Fri, 29 May 2026 14:00:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E39433E0087;
	Fri, 29 May 2026 14:00:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GvK3H1Z5"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8395334EF07;
	Fri, 29 May 2026 14:00:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780063223; cv=none; b=rW+9sFqi52CEmWaVxBwpoPyfqWXk7TdARYJpmoCWP2fkG/GS9dnxNrBhFJMVfizZsniTaPnoCEW7f4yja+sbPbXJ4CnuZbUp/7paKKr/HEwPHQsFyqBQpV0UW6+ID9jf8OZyiRuRJOgarjkUDXGUbGqnjh9HO9j9hkUVbumqCu8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780063223; c=relaxed/simple;
	bh=aln5WV6IWVWGj8D2t3T2xhgEnsATZeGPmThfuIQFq68=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Y14gf18f23eDv2+HK+Hh7qBdaAAa+GncgQAGBro8/dM5GLO1wi/i53J+XJRwtchsWVj9s0cosdVApq8QL2fv7Oe9JSjmFG1VOTbfZrAPEr0R+27mgBHOfEJhSQmhZMDO9IxUq8ZRbcdph67TRld3+EALc3OHLwCp7ZFpXg0E2a8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GvK3H1Z5; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F0061F00898;
	Fri, 29 May 2026 14:00:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780063222;
	bh=riEQWFIhLKz8K/Sm5EuGdjz4nlvYe2b+lj9OUadoe/g=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=GvK3H1Z573iEjL9y3vrn1/y4+jcra6FOHRv9ML46jlM1dy5HykIdDSZl0b4Xsy08r
	 rCVa2NxFFvDQj6m1D/5BiEEUt2+lAWhMbRUhDQGstxDBKS/EnbCAxrjYDteq4Kj4Mm
	 dr/nNKnMuYr+CSkaAFXDTMq9opPbfMss2EcX3HLIaPSRT4m2dhniWgBpl7Ui3tVmoW
	 5PgKmbwd6s/p8a7NfGejLWq49vQKwKaTmU1eds8yakjdNHjdUXgQxYknMBJvqx6583
	 Qa6Oa1ukLaO0cPvxEiLmGE3Y4SCHRzFDZ0/p/Sho6iTiJOydfNMiWqsjOXgu3XB2G/
	 A9jdsWPGkhIfA==
Message-ID: <461703b49f85216f6f6b18656e290287b0f701a0.camel@kernel.org>
Subject: Re: [PATCH 1/1] nfs: return a write delegation when a SETATTR drops
 our write access
From: Trond Myklebust <trondmy@kernel.org>
To: Benjamin Coddington <ben.coddington@hammerspace.com>, Anna Schumaker
	 <anna@kernel.org>
Cc: linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Fri, 29 May 2026 16:00:19 +0200
In-Reply-To: <64a9c99c387432399b4c4d9ce6dd4836b0170c15.1779995818.git.bcodding@hammerspace.com>
References: <cover.1779995818.git.bcodding@hammerspace.com>
	 <64a9c99c387432399b4c4d9ce6dd4836b0170c15.1779995818.git.bcodding@hammerspace.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.1 (3.60.1-1.fc44) 
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-22071-lists,linux-nfs=lfdr.de];
	DKIM_TRACE(0.00)[kernel.org:+];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[trondmy@kernel.org,linux-nfs@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-nfs];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,hammerspace.com:email]
X-Rspamd-Queue-Id: 6958F60343D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, 2026-05-28 at 15:22 -0400, Benjamin Coddington wrote:
> A client holding an OPEN_DELEGATE_WRITE delegation can satisfy a
> later
> open(O_WRONLY) from the cached delegation (can_open_delegated())
> without
> sending an OPEN to the server. That cached "open for write" assertion
> is
> only valid while the delegation holder still has write access. A
> SETATTR
> that changes mode, owner, or group can revoke that access -- after
> which an
> open served from the delegation would bypass an access check the
> server
> would now fail, and, against a server that recalls the delegation on
> such a
> change, the SETATTR draws a CB_RECALL/NFS4ERR_DELAY/DELEGRETURN/retry
> round
> trip.
>=20
> Before issuing such a SETATTR, check whether the proposed
> mode/owner/group
> would remove write access for the delegation's owning credential,
> judged by
> the resulting POSIX mode bits. If so, return the delegation first:
> the
> return is synchronous and flushes modified data, so the SETATTR
> proceeds on
> an open or special stateid and the next open revalidates access with
> the
> server. Permission changes that keep the holder's write access leave
> the
> delegation in place.
>=20
> Only the mode bits and the holder's fsuid/fsgid are consulted. An
> NFSv4 ACL
> cannot be evaluated by the client, a privileged caller may retain
> access the
> bits deny, and supplementary group membership is not checked, so the
> test is
> necessarily approximate -- but an inexact answer costs at most an
> unnecessary delegation return or a fall back to the server's recall,
> never
> incorrect access.
>=20
> RFC 8881 Section 10.4.4 permits a client to return a delegation
> voluntarily,
> performing the same pre-return state updates (data flush, pending
> truncation, CLOSE/OPEN/LOCK) it would on a recall. Commit
> c01d36457dcc
> ("NFSv4: Don't return the delegation when not needed by NFSv4.x
> (x>0)")
> stopped returning write delegations on SETATTR for NFSv4.1+, since
> the
> server can identify the delegation holder from the SEQUENCE clientid
> and
> need not recall. That holds for changes that do not affect the
> holder's
> access; restore a return only for the narrow case where the holder's
> own
> write access is removed.

Hmmm... I'd argue that while recalling the delegation in this case is
mandatory for NFSv4.0, that is certainly not true for NFSv4.1.

Furthermore, I'd argue that if the holder of a write delegation is just
changing the mode, then that should never result in a delegation recall
for a well written NFSv4.1 server. The reason is this does not impact
the client's ability to cache data, metadata or lock state. It only
impacts its ability to rely on previously cached access data when
handling new opens.

One can argue whether or not it's needed for a uid or gid change by
said holder of the delegation, but there too I'd say the right
behaviour is to err on the side of not recalling.
The exception might be if this is an attribute delegation, and the
result will be that the cred attached to the delegation will no longer
be able to issue a SETATTR to update the atime/mtime on delegation
return.

So yes to pre-emptive invalidation of the access cache, but I'm very
sceptical to actually pre-emptively returning the delegation or even
the layouts.

>=20
> Signed-off-by: Benjamin Coddington <bcodding@hammerspace.com>
> ---
> =C2=A0fs/nfs/nfs4proc.c | 66 ++++++++++++++++++++++++++++++++++++++++++++=
-
> --
> =C2=A01 file changed, 62 insertions(+), 4 deletions(-)
>=20
> diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
> index a9b8d482d289..e4b7322bf75c 100644
> --- a/fs/nfs/nfs4proc.c
> +++ b/fs/nfs/nfs4proc.c
> @@ -4506,7 +4506,55 @@ int nfs4_proc_getattr(struct nfs_server
> *server, struct nfs_fh *fhandle,
> =C2=A0	return err;
> =C2=A0}
> =C2=A0
> -/*=20
> +/*
> + * Would applying @sattr (which changes mode, owner, and/or group)
> remove the
> + * write access of a held write delegation's owning credential, as
> judged by
> + * the resulting file mode bits?
> + *
> + * Such a change makes the delegation's cached "open for write"
> assertion
> + * stale: a later open(O_WRONLY) could be served from the delegation
> without
> + * the server getting a chance to deny it.=C2=A0 Only the mode bits and
> the
> + * holder's fsuid/fsgid are consulted; an NFSv4 ACL (which the
> client cannot
> + * evaluate locally), a privileged caller, or supplementary group
> membership
> + * may make the answer imprecise, but the cost is at most an
> unnecessary
> + * delegation return or a fall back to the server's recall -- never
> incorrect
> + * access.
> + */
> +static bool nfs4_setattr_removes_write(struct inode *inode, struct
> iattr *sattr)
> +{
> +	struct nfs_delegation *delegation;
> +	const struct cred *cred;
> +	umode_t mode =3D inode->i_mode;
> +	kuid_t uid =3D inode->i_uid;
> +	kgid_t gid =3D inode->i_gid;
> +	bool ret =3D false;
> +
> +	delegation =3D nfs4_get_valid_delegation(inode);
> +	if (!delegation)
> +		return false;
> +	if (!(delegation->type & FMODE_WRITE))
> +		goto out;
> +	cred =3D delegation->cred;
> +
> +	if (sattr->ia_valid & ATTR_MODE)
> +		mode =3D sattr->ia_mode;
> +	if (sattr->ia_valid & ATTR_UID)
> +		uid =3D sattr->ia_uid;
> +	if (sattr->ia_valid & ATTR_GID)
> +		gid =3D sattr->ia_gid;
> +
> +	if (uid_eq(uid, cred->fsuid))
> +		ret =3D !(mode & S_IWUSR);
> +	else if (gid_eq(gid, cred->fsgid))
> +		ret =3D !(mode & S_IWGRP);
> +	else
> +		ret =3D !(mode & S_IWOTH);
> +out:
> +	nfs_put_delegation(delegation);
> +	return ret;
> +}
> +
> +/*
> =C2=A0 * The file is not closed if it is opened due to the a request to
> change
> =C2=A0 * the size of the file. The open call will not be needed once the
> =C2=A0 * VFS layer lookup-intents are implemented.
> @@ -4555,9 +4603,19 @@ nfs4_proc_setattr(struct dentry *dentry,
> struct nfs_fattr *fattr,
> =C2=A0			cred =3D ctx->cred;
> =C2=A0	}
> =C2=A0
> -	/* Return any delegations if we're going to change ACLs */
> -	if ((sattr->ia_valid & (ATTR_MODE|ATTR_UID|ATTR_GID)) !=3D 0)
> -		nfs4_inode_make_writeable(inode);
> +	/*
> +	 * A change to mode, owner, or group that removes the write
> +	 * delegation holder's own write access makes the
> delegation's cached
> +	 * "open for write" stale; return it so a later open()
> revalidates
> +	 * access with the server.=C2=A0 A change that keeps write access
> leaves
> +	 * the delegation in place.
> +	 */
> +	if (sattr->ia_valid & (ATTR_MODE | ATTR_UID | ATTR_GID)) {
> +		if (nfs4_setattr_removes_write(inode, sattr))
> +			nfs4_inode_return_delegation(inode);
> +		else
> +			nfs4_inode_make_writeable(inode);
> +	}
> =C2=A0
> =C2=A0	status =3D nfs4_do_setattr(inode, cred, fattr, sattr, ctx,
> NULL);
> =C2=A0	if (status =3D=3D 0) {

--=20
Trond Myklebust
Linux NFS client maintainer, Hammerspace
trondmy@kernel.org, trond.myklebust@hammerspace.com


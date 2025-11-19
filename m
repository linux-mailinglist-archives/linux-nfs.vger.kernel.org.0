Return-Path: <linux-nfs+bounces-16564-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 50A4CC70612
	for <lists+linux-nfs@lfdr.de>; Wed, 19 Nov 2025 18:15:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 396874FE6D5
	for <lists+linux-nfs@lfdr.de>; Wed, 19 Nov 2025 16:51:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43CA12FC003;
	Wed, 19 Nov 2025 16:50:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uFkbKXXi"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E6DE1E5714
	for <linux-nfs@vger.kernel.org>; Wed, 19 Nov 2025 16:50:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763571003; cv=none; b=OxmTjDRwTREMoD1yv2XMENLbh3BTYRb4PUmfn5bF19bmee/nToMC8Ym0zTYZuh0vcDYct7bUUHz68tRTojz6LiYsFxusbEUZ3kjY0Z9SZRWyDL+UKhJN1Ra53LcV1x0r/LoAPPwlYmq2zZVeLtB7bdmfVFmEeqmc0moygaZWiXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763571003; c=relaxed/simple;
	bh=4c0BFjlarKt9KoIhgPe+fKhOx6rX4ahLwcf1qklfdpo=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=H44U5EXMea7uJOnZ8QLdxVtLVv1r2iZM9USMilsSKGw/4ln5P6oCqlDB7c7JPT8AeE3TpftEBogRdHH2MzsIlwSpF+8bT7Crt3tzLWjOrkltDqhwNBplEiYkJYEULkGMdiDOrg9Z4fSUN8QkYxvVCKt2l3rY9X0t4LGob8tqBWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uFkbKXXi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A06F8C4CEF5;
	Wed, 19 Nov 2025 16:50:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763571002;
	bh=4c0BFjlarKt9KoIhgPe+fKhOx6rX4ahLwcf1qklfdpo=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=uFkbKXXiHI3NQDhrq+6okjkHPsnYrDvauTme7GmVGQ6I//TbK3cDbryiNpoo3qv0a
	 TL22VBNHuCQywOHExZgcgRC2ZnMiogqq5yBEbWcBljKrFYs/XZNOsRG50rXixkWCed
	 z2VWzkOA52jWFfffdFjI2wa3ctTSr5w7EDJ6rjnoa3XpmZgfC18xwtJx4Hgc2L5U/F
	 wCehpKhC5MqTux2zDUU2yb7ka5lsvqR5hsBIX+PPQBlnznbqtVgDOBfjDVyUVRn6Hs
	 xJHn9OlxTNAWJUjdKCyTn7Zbp/AVqlcdsEHN1Ee3VIRJ5Ywmc3sg/rXqW3sCTpifms
	 vCh3MjL17FSWw==
Message-ID: <2191ab425f19bd96354054af342f9ecbbd3dedd3.camel@kernel.org>
Subject: Re: [PATCH 3/3] NFS: Initialise verifiers for visible dentries in
 _nfs4_open_and_get_state
From: Trond Myklebust <trondmy@kernel.org>
To: Anna Schumaker <anna.schumaker@oracle.com>, Michael Stoler
	 <michael.stoler@vastdata.com>
Cc: linux-nfs@vger.kernel.org
Date: Wed, 19 Nov 2025 11:50:01 -0500
In-Reply-To: <39bca1e3-340d-4908-95d7-030507fb7b7b@oracle.com>
References: <53bc46637bdc4b267a318c74fb4c97cb382f29d1.camel@kernel.org>
	 <cover.1763560328.git.trond.myklebust@hammerspace.com>
	 <4c4b51c67f7b38e4df4cb389007058e37ade0d14.1763560328.git.trond.myklebust@hammerspace.com>
	 <39bca1e3-340d-4908-95d7-030507fb7b7b@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.1 (3.58.1-1.fc43) 
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2025-11-19 at 11:14 -0500, Anna Schumaker wrote:
> Hi Trond,
>=20
> On 11/19/25 8:58 AM, Trond Myklebust wrote:
> > From: Trond Myklebust <trond.myklebust@hammerspace.com>
> >=20
> > Ensure that the verifiers are initialised before calling
> > d_splice_alias() in _nfs4_open_and_get_state().
> >=20
> > Reported-by: Michael Stoler <michael.stoler@vastdata.com>
> > Fixes: cf5b4059ba71 ("NFSv4: Fix races between open and dentry
> > revalidation")
> > Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
> > ---
> > =C2=A0fs/nfs/nfs4proc.c | 27 ++++++++++++++-------------
> > =C2=A01 file changed, 14 insertions(+), 13 deletions(-)
> >=20
> > diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
> > index 93c6ce04332b..54595983525d 100644
> > --- a/fs/nfs/nfs4proc.c
> > +++ b/fs/nfs/nfs4proc.c
> > @@ -3174,18 +3174,6 @@ static int _nfs4_open_and_get_state(struct
> > nfs4_opendata *opendata,
> > =C2=A0	if (opendata->o_res.rflags &
> > NFS4_OPEN_RESULT_PRESERVE_UNLINKED)
> > =C2=A0		set_bit(NFS_INO_PRESERVE_UNLINKED, &NFS_I(state-
> > >inode)->flags);
> > =C2=A0
> > -	dentry =3D opendata->dentry;
> > -	if (d_really_is_negative(dentry)) {
> > -		struct dentry *alias;
> > -		d_drop(dentry);
> > -		alias =3D d_splice_alias(igrab(state->inode),
> > dentry);
> > -		/* d_splice_alias() can't fail here - it's a non-
> > directory */
> > -		if (alias) {
> > -			dput(ctx->dentry);
> > -			ctx->dentry =3D dentry =3D alias;
> > -		}
> > -	}
> > -
> > =C2=A0	switch(opendata->o_arg.claim) {
> > =C2=A0	default:
> > =C2=A0		break;
> > @@ -3196,7 +3184,20 @@ static int _nfs4_open_and_get_state(struct
> > nfs4_opendata *opendata,
> > =C2=A0			break;
> > =C2=A0		if (opendata->o_res.delegation.type !=3D 0)
> > =C2=A0			dir_verifier =3D
> > nfs_save_change_attribute(dir);
> > -		nfs_set_verifier(dentry, dir_verifier);
> > +	}
> > +	nfs_set_verifier(dentry, dir_verifier);
>=20
> Isn't 'dentry' uninitialized here? As far as I can tell, it gets set
> for the first time
> in the very next statement.

D'oh! I wonder why the compiler let that pass?
Anyhow, yes, the nfs_set_verifier() call needs to be moved one line
down.

>=20
> Thanks,
> Anna
>=20
> > +
> > +	dentry =3D opendata->dentry;
> > +	if (d_really_is_negative(dentry)) {
> > +		struct dentry *alias;
> > +		d_drop(dentry);
> > +		alias =3D d_splice_alias(igrab(state->inode),
> > dentry);
> > +		/* d_splice_alias() can't fail here - it's a non-
> > directory */
> > +		if (alias) {
> > +			dput(ctx->dentry);
> > +			nfs_set_verifier(alias, dir_verifier);
> > +			ctx->dentry =3D dentry =3D alias;
> > +		}
> > =C2=A0	}
> > =C2=A0
> > =C2=A0	/* Parse layoutget results before we check for access */

--=20
Trond Myklebust
Linux NFS client maintainer, Hammerspace
trondmy@kernel.org, trond.myklebust@hammerspace.com


Return-Path: <linux-nfs+bounces-11198-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B76BFA95082
	for <lists+linux-nfs@lfdr.de>; Mon, 21 Apr 2025 14:00:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5C6F23B3241
	for <lists+linux-nfs@lfdr.de>; Mon, 21 Apr 2025 12:00:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51FAC2620F5;
	Mon, 21 Apr 2025 12:00:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rdxgVY7u"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 270BF1DB122;
	Mon, 21 Apr 2025 12:00:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745236821; cv=none; b=aIJJ+HQrqokyLQcGP3h+TtdTgO0j3PsL86o1wh3nmMpU+c2rDEGsD2PkUe0sUeRehnPhvUYk8yR6EscZEEowqcBRAGxahrP/I8Ltp4/7QVCjZ4MTuT2dvWut2cmjn3jcfwU2Lu/epQhi8WYLQZ0NnirGaMuB8dQPVkY+KY5dnT8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745236821; c=relaxed/simple;
	bh=W9NOrm9S/k4sk/Uv/kYF+L5FLMLUi7wpa+sanI+asWI=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=B77crgVcbxWw6bfv16mZOCCanuTwjR2NLL63dlG7Zkf0EfgpDkQToNKykVsoWjQWIuiAD4cjW8taVcX6eiYmswM/8MYnYo0aCG3FC0R39UPPv9IHFfzEKwkysNPmhu/tOTiNxU1g4GHnLYOe8T2Euzc4RKSIyqmQo3Z6edku3H4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rdxgVY7u; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC295C4CEE4;
	Mon, 21 Apr 2025 12:00:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745236820;
	bh=W9NOrm9S/k4sk/Uv/kYF+L5FLMLUi7wpa+sanI+asWI=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=rdxgVY7u4Wr/0ynkCmkzMWC9eIclSz+fmcOILcMHqoAMnCEfqOWaWloopBHaHq7YY
	 d+up9T280tE01YvHzaXZGcCSl8CjWIruElG3ZXlTN4Yz1pa53kle/oBv6DX2CcuHLl
	 s564wE1au2JwXnH/k9yO2xETnaafhY0EXazkxCsKsXmHC3ciAjwTNhFJCfmS+dWW5k
	 MicdH8ClN+qVhwCKYOftTkl/cSYdWJqIL+ypylMJdyaFlGqJXELTpJz1Ckf/agdujW
	 Yo8RVgoGapErDwSow91+gdmDTwyhfNid5YSmOPom1ZleID+gvzW8j11ZVY+OP182vh
	 S4zgDub2bkTUw==
Message-ID: <3452e3fea7c250fc0816aa1b55f579849e056283.camel@kernel.org>
Subject: Re: [PATCH 2/2] nfs: handle failure of get_nfs_open_context
From: Jeff Layton <jlayton@kernel.org>
To: Li Lingfeng <lilingfeng3@huawei.com>, trondmy@kernel.org,
 anna@kernel.org, 	bcodding@redhat.com
Cc: linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
	yukuai1@huaweicloud.com, houtao1@huawei.com, yi.zhang@huawei.com, 
	yangerkun@huawei.com, lilingfeng@huaweicloud.com
Date: Mon, 21 Apr 2025 08:00:18 -0400
In-Reply-To: <40d40603-f9a9-4eaa-aaa6-d5ce31445aa4@huawei.com>
References: <20250419085355.1451457-1-lilingfeng3@huawei.com>
	 <20250419085355.1451457-3-lilingfeng3@huawei.com>
	 <828b70d9f1c0a34966aeda8198d80046dcd2bba2.camel@kernel.org>
	 <40d40603-f9a9-4eaa-aaa6-d5ce31445aa4@huawei.com>
Autocrypt: addr=jlayton@kernel.org; prefer-encrypt=mutual;
 keydata=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
 QZIQXVeAA+smfTT0tDrisj1U5x6ZB9b3nBg65kc=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.3 (3.54.3-1.fc41) 
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2025-04-21 at 09:56 +0800, Li Lingfeng wrote:
> =E5=9C=A8 2025/4/19 20:34, Jeff Layton =E5=86=99=E9=81=93:
> > On Sat, 2025-04-19 at 16:53 +0800, Li Lingfeng wrote:
> > > During initialization of unlockdata or lockdata structures, if acquir=
ing
> > > the nfs_open_context fails, the current operation must be aborted to
> > > ensure the nfs_open_context remains valid after initialization comple=
tes.
> > > This is critical because both lock and unlock release callbacks
> > > dereference the nfs_open_context - an invalid context could lead to n=
ull
> > > pointer dereference.
> > >=20
> > > Fixes: faf5f49c2d9c ("NFSv4: Make NFS clean up byte range locks async=
hronously")
> > > Fixes: a5d16a4d090b ("NFSv4: Convert LOCK rpc call into an asynchrono=
us RPC call")
> > > Signed-off-by: Li Lingfeng <lilingfeng3@huawei.com>
> > > ---
> > >   fs/nfs/nfs4proc.c | 22 +++++++++++++++-------
> > >   1 file changed, 15 insertions(+), 7 deletions(-)
> > >=20
> > > diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
> > > index 9f5689c43a50..d76cf0f79f9c 100644
> > > --- a/fs/nfs/nfs4proc.c
> > > +++ b/fs/nfs/nfs4proc.c
> > > @@ -7075,24 +7075,27 @@ static struct nfs4_unlockdata *nfs4_alloc_unl=
ockdata(struct file_lock *fl,
> > >   	struct nfs4_state *state =3D lsp->ls_state;
> > >   	struct inode *inode =3D state->inode;
> > >   	struct nfs_lock_context *l_ctx;
> > > +	struct nfs_open_context *open_ctx;
> > >  =20
> > >   	p =3D kzalloc(sizeof(*p), GFP_KERNEL);
> > >   	if (p =3D=3D NULL)
> > >   		return NULL;
> > >   	l_ctx =3D nfs_get_lock_context(ctx);
> > > -	if (!IS_ERR(l_ctx)) {
> > > +	if (!IS_ERR(l_ctx))
> > >   		p->l_ctx =3D l_ctx;
> > > -	} else {
> > > -		kfree(p);
> > > -		return NULL;
> > > -	}
> > > +	else
> > > +		goto out_free;
> > > +	/* Ensure we don't close file until we're done freeing locks! */
> > > +	open_ctx =3D get_nfs_open_context(ctx);
> > >=20
> > >=20
> > Sorry for the confusion. Now that I look more closely, I think I was
> > wrong before.
> >=20
> > This can't fail, because the caller holds a reference to ctx, so the
> > refcount must be non-zero. Instead of this patch, could you add a
> > comment in there to that effect to make this clear in the future?
> Hi Jeff,
>=20
> Thank you for the feedback.
> Adding a comment instead of this patch may be better.
>=20
> However, I=E2=80=99d like to seek your guidance on a broader question: Fo=
r
> scenarios where an error condition =E2=80=8Bcurrently cannot occur but wo=
uld lead
> to severe consequences (e.g., NULL pointer dereference, data corruption)
> if it ever did happen (e.g., due to future code changes or bugs), do you
> recommend proactively adding error handling as a defensive measure?
>=20
> My rationale:
> =E2=80=8BCurrent code: No code path triggers this condition today --> Han=
dling
> code would be "dead" for now.
> =E2=80=8BFuture risks: If a bug introduced later allows the condition to =
occur,
> silent failure or crashes could result.
> Is there a kernel/dev policy on such preemptive safeguards? Or should we
> address these only when the triggering scenarios materialize?
>=20
> Your insight would help me align with the project=E2=80=99s practices.
> Thanks in advance!
>=20

There is no firm policy here. We just have to make a judgment call in
these situations.

In general, we don't want to litter the code with a lot of conditionals
or BUG_ONs/WARN_ONs for cases that can really never happen, as that
might slow things down for little benefit, and it makes the code less
readable. OTOH, being proactive about catching errors is a good thing,
so if there is any chance that things could change in the future, it's
good to have a warning about it.

In this particular case, given that we have to hold a reference in
order to pass a pointer to the ctx in the first place, there is little
value in doing (e.g.) WARN_ON(!open_ctx), as that should really never
happen.



> Best regards,
> Lingfeng
> >=20
> >=20
> > > +	if (open_ctx)
> > > +		p->ctx =3D open_ctx;
> > > +	else
> > > +		goto out_free;
> > If we did decide to keep the error handling however, this would leak
> > l_ctx. That reference would also need to be put if open_ctx was NULL
> > here.
> >=20
> > >   	p->arg.fh =3D NFS_FH(inode);
> > >   	p->arg.fl =3D &p->fl;
> > >   	p->arg.seqid =3D seqid;
> > >   	p->res.seqid =3D seqid;
> > >   	p->lsp =3D lsp;
> > > -	/* Ensure we don't close file until we're done freeing locks! */
> > > -	p->ctx =3D get_nfs_open_context(ctx);
> > >   	locks_init_lock(&p->fl);
> > >   	locks_copy_lock(&p->fl, fl);
> > >   	p->server =3D NFS_SERVER(inode);
> > > @@ -7100,6 +7103,9 @@ static struct nfs4_unlockdata *nfs4_alloc_unloc=
kdata(struct file_lock *fl,
> > >   	nfs4_stateid_copy(&p->arg.stateid, &lsp->ls_stateid);
> > >   	spin_unlock(&state->state_lock);
> > >   	return p;
> > > +out_free:
> > > +	kfree(p);
> > > +	return NULL;
> > >   }
> > >  =20
> > >   static void nfs4_locku_release_calldata(void *data)
> > > @@ -7327,6 +7333,8 @@ static struct nfs4_lockdata *nfs4_alloc_lockdat=
a(struct file_lock *fl,
> > >   	p->lsp =3D lsp;
> > >   	p->server =3D server;
> > >   	p->ctx =3D get_nfs_open_context(ctx);
> > > +	if (!p->ctx)
> > > +		goto out_free_seqid;
> > >   	locks_init_lock(&p->fl);
> > >   	locks_copy_lock(&p->fl, fl);
> > >   	return p;

--=20
Jeff Layton <jlayton@kernel.org>


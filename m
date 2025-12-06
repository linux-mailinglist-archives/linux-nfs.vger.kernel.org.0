Return-Path: <linux-nfs+bounces-16965-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 194E1CA9AAF
	for <lists+linux-nfs@lfdr.de>; Sat, 06 Dec 2025 01:01:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 513D53016278
	for <lists+linux-nfs@lfdr.de>; Sat,  6 Dec 2025 00:01:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 923AD231A55;
	Sat,  6 Dec 2025 00:01:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j93jmNFG"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E431023875D;
	Sat,  6 Dec 2025 00:01:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764979276; cv=none; b=vCCc6PL91gjyYjD1uUnpArb4VSDIQqCWZI08e7jEkkNrdLwnkN6Cc/4yT5JfJ3B64t/OQ7EIoQpLv5Kf/RmOQCCzSxJdyLAqwVWT7Uo36JkHHN4pYEe4K4uTk3gqWmqisTFXqUEmTTuNKzeYVwNyqoYIlqC/qhd6CFQWr/ZUm5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764979276; c=relaxed/simple;
	bh=UqsW1c26EFpknQwzR3n28tLkMyYW0y7WTz3XPv/8kv8=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=KvZkYLdoEoVhvi9JVhdGXqNocAefdOkjq801Y4tHDEdrE7ZdjJiCsRk2uu2sRUxjfVGnzxKrW+QJ81FlT/ea+Ucz0YqojbjdkKaqaoHCv4QTtUZbqc6JMNgh/jgY7TrOZGDp3cGQMb2YoRbe0Rl1+LvBKjRc+GOSPistIQJAUww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j93jmNFG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70E9AC4CEF1;
	Sat,  6 Dec 2025 00:01:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764979275;
	bh=UqsW1c26EFpknQwzR3n28tLkMyYW0y7WTz3XPv/8kv8=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=j93jmNFG7+X6+mlwlQSg2a5mXiM9FpCiZotZGmmceySTt+g4C7014bNIcvBXbDpeb
	 YWOYBAzleeVrBKn5fGJpFV4pxbZUgel+0YSJGlZFMtHGZImDEzcRVxVkNpdgftEYLf
	 yzsE9nTImyXLpnF5jpWZbq4n4NdGbgB2ON9KswkoHqvChoMJqXWcLFuknN5bmHEnPF
	 AMu0W/HRZRajr2Y1BJG/L9nBZ5XVQM8DqWWylrkXsjlf3UQv8U2qd2K4RPC7+BZLvp
	 wSGOUPbxpyvdNjtz8sbJqwI1wh+p9kQ2wUdRBZVZH9VfDsOPi96ahs2MwnENfYJWpt
	 Npq4dzwNlMZcQ==
Message-ID: <64034c4b052649773272c6fa9c3c929e28ecd40d.camel@kernel.org>
Subject: Re: [6.19 PATCH] nfs/localio: fix regression due to out-of-order
 __put_cred [was: Re: linux-next: manual merge of the nfs tree with Linus'
 tree]
From: Trond Myklebust <trondmy@kernel.org>
To: Mike Snitzer <snitzer@kernel.org>, Stephen Rothwell
 <sfr@canb.auug.org.au>,  Linus Torvalds <torvalds@linux-foundation.org>
Cc: Christian Brauner <brauner@kernel.org>, Linux Kernel Mailing List
	 <linux-kernel@vger.kernel.org>, Linux Next Mailing List
	 <linux-next@vger.kernel.org>, linux-nfs@vger.kernel.org, 
	linux-stable@vger.kernel.org
Date: Fri, 05 Dec 2025 19:01:13 -0500
In-Reply-To: <aTIwhhOF847CcQGl@kernel.org>
References: <20251205111942.4150b06f@canb.auug.org.au>
	 <aTIwhhOF847CcQGl@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.2 (3.58.2-1.fc43) 
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2025-12-04 at 20:08 -0500, Mike Snitzer wrote:
> Hi Stephen,
>=20
> On Fri, Dec 05, 2025 at 11:19:42AM +1100, Stephen Rothwell wrote:
> > Hi all,
> >=20
> > Today's linux-next merge of the nfs tree got a conflict in:
> >=20
> > =C2=A0 fs/nfs/localio.c
> >=20
> > between commits:
> >=20
> > =C2=A0 94afb627dfc2 ("nfs: use credential guards in
> > nfs_local_call_read()")
> > =C2=A0 bff3c841f7bd ("nfs: use credential guards in
> > nfs_local_call_write()")
> > =C2=A0 1d18101a644e ("Merge tag 'kernel-6.19-rc1.cred' of
> > git://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs")
> >=20
> > from Linus' tree and commit:
> >=20
> > =C2=A0 30a4385509b4 ("nfs/localio: fix regression due to out-of-order
> > __put_cred")
> >=20
> > from the nfs tree.
>=20
> The NFS tree's commit 30a4385509b4 needed to be rebased (taken care
> of
> below), which complicates the 6.18-stable backport (equivalent of the
> nfs tree's commit 30a4385509b4 must be sent to linux-stable@ rather
> than it being cherry-picked once the below updated fix applied to
> Linus' tree).
>=20
> > I fixed it up (I just dropped the nfs tree commit) and can carry
> > the
> > fix as necessary. This is now fixed as far as linux-next is
> > concerned,
> > but any non trivial conflicts should be mentioned to your upstream
> > maintainer when your tree is submitted for merging.=C2=A0 You may also
> > want
> > to consider cooperating with the maintainer of the conflicting tree
> > to
> > minimise any particularly complex conflicts.
>=20
> Trond and Linus,
>=20
> Here is the fix for 6.19 rebased ontop of Linus' tree:
>=20
> From: Mike Snitzer <snitzer@kernel.org>
> Date: Wed, 26 Nov 2025 01:01:25 -0500
> Subject: [PATCH] nfs/localio: fix regression due to out-of-order
> __put_cred
>=20
> Commit f2060bdc21d7 ("nfs/localio: add refcounting for each iocb IO
> associated with NFS pgio header") inadvertantly reintroduced the same
> potential for __put_cred() triggering BUG_ON(cred =3D=3D current->cred)
> that commit 992203a1fba5 ("nfs/localio: restore creds before
> releasing
> pageio data") fixed.
>=20
> Fix this by saving and restoring the cred around each
> {read,write}_iter
> call within the respective for loop of nfs_local_call_{read,write}
> using scoped_with_creds().
>=20
> NOTE: this fix started by first reverting the following commits:
>=20
> =C2=A094afb627dfc2 ("nfs: use credential guards in nfs_local_call_read()"=
)
> =C2=A0bff3c841f7bd ("nfs: use credential guards in
> nfs_local_call_write()")
> =C2=A01d18101a644e ("Merge tag 'kernel-6.19-rc1.cred' of
> git://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs")
>=20
> followed by narrowly fixing the cred lifetime issue by using
> scoped_with_creds(). In doing so, this commit's changes appear more
> extensive than they really are (as evidenced by comparing to v6.18's
> fs/nfs/localio.c).
>=20
> Reported-by: Zorro Lang <zlang@redhat.com>
> Fixes: f2060bdc21d7 ("nfs/localio: add refcounting for each iocb IO
> associated with NFS pgio header")
> Cc: linux-stable@vger.kernel.org=C2=A0# a custom 6.18-stable backport is
> required
> Signed-off-by: Mike Snitzer <snitzer@kernel.org>
> Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
>=20
> diff --git a/fs/nfs/localio.c b/fs/nfs/localio.c
> index 49ed90c6b9f2..f33bfa7b58e6 100644
> --- a/fs/nfs/localio.c
> +++ b/fs/nfs/localio.c
> @@ -615,8 +615,11 @@ static void nfs_local_read_aio_complete(struct
> kiocb *kiocb, long ret)
> =C2=A0	nfs_local_pgio_aio_complete(iocb); /* Calls
> nfs_local_read_aio_complete_work */
> =C2=A0}
> =C2=A0
> -static void do_nfs_local_call_read(struct nfs_local_kiocb *iocb,
> struct file *filp)
> +static void nfs_local_call_read(struct work_struct *work)
> =C2=A0{
> +	struct nfs_local_kiocb *iocb =3D
> +		container_of(work, struct nfs_local_kiocb, work);
> +	struct file *filp =3D iocb->kiocb.ki_filp;
> =C2=A0	bool force_done =3D false;
> =C2=A0	ssize_t status;
> =C2=A0	int n_iters;
> @@ -633,7 +636,9 @@ static void do_nfs_local_call_read(struct
> nfs_local_kiocb *iocb, struct file *fi
> =C2=A0		} else
> =C2=A0			iocb->kiocb.ki_flags &=3D ~IOCB_DIRECT;
> =C2=A0
> -		status =3D filp->f_op->read_iter(&iocb->kiocb, &iocb-
> >iters[i]);
> +		scoped_with_creds(filp->f_cred)
> +			status =3D filp->f_op->read_iter(&iocb->kiocb,
> &iocb->iters[i]);
> +
> =C2=A0		if (status !=3D -EIOCBQUEUED) {
> =C2=A0			if (unlikely(status >=3D 0 && status < iocb-
> >iters[i].count))
> =C2=A0				force_done =3D true; /* Partial read
> */
> @@ -645,16 +650,6 @@ static void do_nfs_local_call_read(struct
> nfs_local_kiocb *iocb, struct file *fi
> =C2=A0	}
> =C2=A0}
> =C2=A0
> -static void nfs_local_call_read(struct work_struct *work)
> -{
> -	struct nfs_local_kiocb *iocb =3D
> -		container_of(work, struct nfs_local_kiocb, work);
> -	struct file *filp =3D iocb->kiocb.ki_filp;
> -
> -	scoped_with_creds(filp->f_cred)
> -		do_nfs_local_call_read(iocb, filp);
> -}
> -
> =C2=A0static int
> =C2=A0nfs_local_do_read(struct nfs_local_kiocb *iocb,
> =C2=A0		=C2=A0 const struct rpc_call_ops *call_ops)
> @@ -822,13 +817,18 @@ static void nfs_local_write_aio_complete(struct
> kiocb *kiocb, long ret)
> =C2=A0	nfs_local_pgio_aio_complete(iocb); /* Calls
> nfs_local_write_aio_complete_work */
> =C2=A0}
> =C2=A0
> -static ssize_t do_nfs_local_call_write(struct nfs_local_kiocb *iocb,
> -				=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct file *filp)
> +static void nfs_local_call_write(struct work_struct *work)
> =C2=A0{
> +	struct nfs_local_kiocb *iocb =3D
> +		container_of(work, struct nfs_local_kiocb, work);
> +	struct file *filp =3D iocb->kiocb.ki_filp;
> +	unsigned long old_flags =3D current->flags;
> =C2=A0	bool force_done =3D false;
> =C2=A0	ssize_t status;
> =C2=A0	int n_iters;
> =C2=A0
> +	current->flags |=3D PF_LOCAL_THROTTLE | PF_MEMALLOC_NOIO;
> +
> =C2=A0	file_start_write(filp);
> =C2=A0	n_iters =3D atomic_read(&iocb->n_iters);
> =C2=A0	for (int i =3D 0; i < n_iters ; i++) {
> @@ -842,7 +842,9 @@ static ssize_t do_nfs_local_call_write(struct
> nfs_local_kiocb *iocb,
> =C2=A0		} else
> =C2=A0			iocb->kiocb.ki_flags &=3D ~IOCB_DIRECT;
> =C2=A0
> -		status =3D filp->f_op->write_iter(&iocb->kiocb, &iocb-
> >iters[i]);
> +		scoped_with_creds(filp->f_cred)
> +			status =3D filp->f_op->write_iter(&iocb-
> >kiocb, &iocb->iters[i]);
> +
> =C2=A0		if (status !=3D -EIOCBQUEUED) {
> =C2=A0			if (unlikely(status >=3D 0 && status < iocb-
> >iters[i].count))
> =C2=A0				force_done =3D true; /* Partial write
> */
> @@ -854,22 +856,6 @@ static ssize_t do_nfs_local_call_write(struct
> nfs_local_kiocb *iocb,
> =C2=A0	}
> =C2=A0	file_end_write(filp);
> =C2=A0
> -	return status;
> -}
> -
> -static void nfs_local_call_write(struct work_struct *work)
> -{
> -	struct nfs_local_kiocb *iocb =3D
> -		container_of(work, struct nfs_local_kiocb, work);
> -	struct file *filp =3D iocb->kiocb.ki_filp;
> -	unsigned long old_flags =3D current->flags;
> -	ssize_t status;
> -
> -	current->flags |=3D PF_LOCAL_THROTTLE | PF_MEMALLOC_NOIO;
> -
> -	scoped_with_creds(filp->f_cred)
> -		status =3D do_nfs_local_call_write(iocb, filp);
> -
> =C2=A0	current->flags =3D old_flags;
> =C2=A0}
> =C2=A0

OK, so what is the easiest way to merge this?

Should I just remove the "old" patch from my tree, and submit that
patch directly to stable@vger.kernel.org as a fix for 6.18? That would
allow Christian to pick up this (after perhaps removing the stable and
Fixes tags above), and submit it as part of his merge, thus fixing the
6.19 kernel.

Thoughts? Preferences?

--=20
Trond Myklebust
Linux NFS client maintainer, Hammerspace
trondmy@kernel.org, trond.myklebust@hammerspace.com


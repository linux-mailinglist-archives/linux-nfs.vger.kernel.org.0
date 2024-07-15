Return-Path: <linux-nfs+bounces-4927-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DEB859316F4
	for <lists+linux-nfs@lfdr.de>; Mon, 15 Jul 2024 16:40:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9620E282091
	for <lists+linux-nfs@lfdr.de>; Mon, 15 Jul 2024 14:40:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7924B13D531;
	Mon, 15 Jul 2024 14:39:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CbqTi/2b"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53DE5433B3
	for <linux-nfs@vger.kernel.org>; Mon, 15 Jul 2024 14:39:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721054399; cv=none; b=KvUFOmwZK6m7+Sth59aTntnOPc+7ljahgmgk3JQG6HFoZtnCvWs/K4Tk1RjUz3xLEhSGuHo/jJLQISCXlXBAkGwuC8YdDZ+iQ5q6/bcuQ4GUP9g3YVbGSEn45i7obXTWoeCsZJLni4ZBrq3yQCGFyy3/3hnS2ODnI4jOz3kIgVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721054399; c=relaxed/simple;
	bh=jmGPcUF7ZSIOA2YSY0sfqR37pwNwyuzyemk2ERvLqok=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=YxIszy5IgoPRSLEBToh1RZdkubkd8IWzIlyO6jgO7NStbj4ugLtDryqy983cgXAOXM0ip8dJIVjDi6sC2+Q9Omdk2dA9Do3wovzXm9/lFHloRshalHYu1aQ+voThyBnJl1vX2XrxnmJyZA0d68MiRpiHanPsF38x8IILJcBxY1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CbqTi/2b; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48C11C32782;
	Mon, 15 Jul 2024 14:39:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721054399;
	bh=jmGPcUF7ZSIOA2YSY0sfqR37pwNwyuzyemk2ERvLqok=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=CbqTi/2bpQ5tOlEgCs9GzRGoAlCsTvk8mEl03h3kGlJF+OKYRaUJF5mNN33HRPZRb
	 IwgdXwORs6QW0YWUIR/UBY9qB5Y0/D6oVaFqx8MmSmtPd+ntl7HafulTX29GiXKnBB
	 sTJz4fU2oGucR0XXGN3cdAC2y/SyA9y3KIuCKmjiPcLWRiuCoXoQwjQCO0WVcAjc8n
	 odINz/k4kEAwmeqcnzwYQ4KNS5GlG54taUoCZwqLPUW12hWHGE43KEqv5fD8GABYbj
	 ChLq2t1m9T4b7YINDkG4hKgPuBXfPs9xBE7EGehl+YrO4C8YjX2e/SfOlGU2/Ggv7p
	 +O9uNz0L+Nd2g==
Message-ID: <d48f18e8205ce046f17a3db3591314bf3cc851ea.camel@kernel.org>
Subject: Re: [PATCH 07/14] Change unshare_fs_struct() to never fail.
From: Jeff Layton <jlayton@kernel.org>
To: NeilBrown <neilb@suse.de>, Chuck Lever <chuck.lever@oracle.com>
Cc: linux-nfs@vger.kernel.org, Olga Kornievskaia <kolga@netapp.com>, Dai Ngo
	 <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>, Steve Dickson
	 <steved@redhat.com>
Date: Mon, 15 Jul 2024 10:39:57 -0400
In-Reply-To: <20240715074657.18174-8-neilb@suse.de>
References: <20240715074657.18174-1-neilb@suse.de>
	 <20240715074657.18174-8-neilb@suse.de>
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

On Mon, 2024-07-15 at 17:14 +1000, NeilBrown wrote:
> nfsd threads need to not share the init fs_struct as they need to
> manipulate umask independently.=C2=A0 So they call unshare_fs_struct() an=
d
> are the only user of that function.
>=20
> In the unlikely event that unshare_fs_struct() fails, the thread will
> exit calling svc_exit_thread() BEFORE svc_thread_should_stop() reports
> 'true'.
>=20
> This is a problem because svc_exit_thread() assumes that
> svc_stop_threads() is running and consequently (in the nfsd case)
> nfsd_mutex is held.=C2=A0 This ensures that the list_del_rcu() call in
> svc_exit_thread() cannot race with any other manipulation of
> ->sp_all_threads.
>=20
> While it would be possible to add some other exclusion, doing so would
> introduce unnecessary complexity.=C2=A0 unshare_fs_struct() does not fail=
 in
> practice.=C2=A0 So the simplest solution is to make this explicit.=C2=A0 =
i.e.=C2=A0 use
> __GFP_NOFAIL which is safe on such a small allocation - about 64 bytes.
>=20

I know some folks are trying hard to get rid of (or minimize the use
of) __GFP_NOFAIL. This might not be a long term solution.

> Change unshare_fs_struct() to not return any error, and remove the error
> handling from nfsd().
>=20
> An alternate approach would be to create a variant of
> kthread_create_on_node() which didn't set CLONE_FS.
>=20

This sounds like it might be the better approach. I guess you could
just add a set of CLONE_* flags to struct kthread_create_info and fix
up the callers to set that appropriately?

> Signed-off-by: NeilBrown <neilb@suse.de>
> ---
> =C2=A0fs/fs_struct.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 | 42 ++++++++++++++++++++-------------------
> =C2=A0fs/nfsd/nfssvc.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 |=C2=A0 9 +++------
> =C2=A0include/linux/fs_struct.h |=C2=A0 2 +-
> =C2=A03 files changed, 26 insertions(+), 27 deletions(-)
>=20
> diff --git a/fs/fs_struct.c b/fs/fs_struct.c
> index 64c2d0814ed6..49fba862e408 100644
> --- a/fs/fs_struct.c
> +++ b/fs/fs_struct.c
> @@ -109,35 +109,39 @@ void exit_fs(struct task_struct *tsk)
> =C2=A0	}
> =C2=A0}
> =C2=A0
> +static void init_fs_struct(struct fs_struct *fs, struct fs_struct *old)
> +{
> +	fs->users =3D 1;
> +	fs->in_exec =3D 0;
> +	spin_lock_init(&fs->lock);
> +	seqcount_spinlock_init(&fs->seq, &fs->lock);
> +	fs->umask =3D old->umask;
> +
> +	spin_lock(&old->lock);
> +	fs->root =3D old->root;
> +	path_get(&fs->root);
> +	fs->pwd =3D old->pwd;
> +	path_get(&fs->pwd);
> +	spin_unlock(&old->lock);
> +}
> +
> =C2=A0struct fs_struct *copy_fs_struct(struct fs_struct *old)
> =C2=A0{
> =C2=A0	struct fs_struct *fs =3D kmem_cache_alloc(fs_cachep, GFP_KERNEL);
> =C2=A0	/* We don't need to lock fs - think why ;-) */
> -	if (fs) {
> -		fs->users =3D 1;
> -		fs->in_exec =3D 0;
> -		spin_lock_init(&fs->lock);
> -		seqcount_spinlock_init(&fs->seq, &fs->lock);
> -		fs->umask =3D old->umask;
> -
> -		spin_lock(&old->lock);
> -		fs->root =3D old->root;
> -		path_get(&fs->root);
> -		fs->pwd =3D old->pwd;
> -		path_get(&fs->pwd);
> -		spin_unlock(&old->lock);
> -	}
> +	if (fs)
> +		init_fs_struct(fs, old);
> =C2=A0	return fs;
> =C2=A0}
> =C2=A0
> -int unshare_fs_struct(void)
> +void unshare_fs_struct(void)
> =C2=A0{
> =C2=A0	struct fs_struct *fs =3D current->fs;
> -	struct fs_struct *new_fs =3D copy_fs_struct(fs);
> +	struct fs_struct *new_fs =3D kmem_cache_alloc(fs_cachep,
> +						=C2=A0=C2=A0=C2=A0 GFP_KERNEL| __GFP_NOFAIL);
> =C2=A0	int kill;
> =C2=A0
> -	if (!new_fs)
> -		return -ENOMEM;
> +	init_fs_struct(new_fs, fs);
> =C2=A0
> =C2=A0	task_lock(current);
> =C2=A0	spin_lock(&fs->lock);
> @@ -148,8 +152,6 @@ int unshare_fs_struct(void)
> =C2=A0
> =C2=A0	if (kill)
> =C2=A0		free_fs_struct(fs);
> -
> -	return 0;
> =C2=A0}
> =C2=A0EXPORT_SYMBOL_GPL(unshare_fs_struct);
> =C2=A0
> diff --git a/fs/nfsd/nfssvc.c b/fs/nfsd/nfssvc.c
> index 7377422a34df..f5de04a63c6f 100644
> --- a/fs/nfsd/nfssvc.c
> +++ b/fs/nfsd/nfssvc.c
> @@ -873,11 +873,9 @@ nfsd(void *vrqstp)
> =C2=A0
> =C2=A0	/* At this point, the thread shares current->fs
> =C2=A0	 * with the init process. We need to create files with the
> -	 * umask as defined by the client instead of init's umask. */
> -	if (unshare_fs_struct() < 0) {
> -		printk("Unable to start nfsd thread: out of memory\n");
> -		goto out;
> -	}
> +	 * umask as defined by the client instead of init's umask.
> +	 */
> +	unshare_fs_struct();
> =C2=A0
> =C2=A0	current->fs->umask =3D 0;
> =C2=A0
> @@ -899,7 +897,6 @@ nfsd(void *vrqstp)
> =C2=A0
> =C2=A0	atomic_dec(&nfsd_th_cnt);
> =C2=A0
> -out:
> =C2=A0	/* Release the thread */
> =C2=A0	svc_exit_thread(rqstp);
> =C2=A0	return 0;
> diff --git a/include/linux/fs_struct.h b/include/linux/fs_struct.h
> index 783b48dedb72..8282e6c7ff29 100644
> --- a/include/linux/fs_struct.h
> +++ b/include/linux/fs_struct.h
> @@ -22,7 +22,7 @@ extern void set_fs_root(struct fs_struct *, const struc=
t path *);
> =C2=A0extern void set_fs_pwd(struct fs_struct *, const struct path *);
> =C2=A0extern struct fs_struct *copy_fs_struct(struct fs_struct *);
> =C2=A0extern void free_fs_struct(struct fs_struct *);
> -extern int unshare_fs_struct(void);
> +extern void unshare_fs_struct(void);
> =C2=A0
> =C2=A0static inline void get_fs_root(struct fs_struct *fs, struct path *r=
oot)
> =C2=A0{

--=20
Jeff Layton <jlayton@kernel.org>


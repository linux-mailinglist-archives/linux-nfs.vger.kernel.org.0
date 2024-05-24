Return-Path: <linux-nfs+bounces-3364-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ADBD68CE09A
	for <lists+linux-nfs@lfdr.de>; Fri, 24 May 2024 07:29:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 63C96282F96
	for <lists+linux-nfs@lfdr.de>; Fri, 24 May 2024 05:29:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE2596E612;
	Fri, 24 May 2024 05:29:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kojedz.in header.i=@kojedz.in header.b="lmDWMbf+";
	dkim=pass (3072-bit key) header.d=kojedz.in header.i=@kojedz.in header.b="e7788cxT"
X-Original-To: linux-nfs@vger.kernel.org
Received: from fw.sz-a.kwebs.cloud (fw.sz-a.kwebs.cloud [109.61.102.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83C341EEE3
	for <linux-nfs@vger.kernel.org>; Fri, 24 May 2024 05:29:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=109.61.102.40
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716528579; cv=none; b=ZmdsvpNKhWtHt2PTxqMZfmizbAf03KN2Z1eoxRlsWu5JGVfxHMGZbTvQtT1J0g6ENTuoZcgE3stidCz9Typ22eF+4gdB84tt0mnotV6e1fonJ/O/QUv600v0a3Te6kQkKhZ5z1ovMaRUFxgGwabJYn8M6C2Dzecq5wxLwdpJ3Qs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716528579; c=relaxed/simple;
	bh=UEbqYjSejbugXogHIMp1tgxhzLaLl+myi4WNYRkACHw=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=tkelyIsMK939GwaQz02rBICOI1mRM2Wl/TuB7hXFvVMU9WPefz2LPYJ1gbokPukIhh6H+nNp8w0YXkjkdXEyLhZfJCu5LG/GlnKb3VSJ9ppwKug11J2jH3oCR/cF7kcmXQJDGPTvK7QHpB1lO+Z7TfFfryTDv4I1rtLx41uUBJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kojedz.in; spf=pass smtp.mailfrom=kojedz.in; dkim=pass (2048-bit key) header.d=kojedz.in header.i=@kojedz.in header.b=lmDWMbf+; dkim=pass (3072-bit key) header.d=kojedz.in header.i=@kojedz.in header.b=e7788cxT; arc=none smtp.client-ip=109.61.102.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kojedz.in
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kojedz.in
Received: from webmail.srv.kwebs.cloud (172-16-36-105.prometheus-node-exporter.monitoring.svc.cluster.local [172.16.36.105])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
	(No client certificate requested)
	(Authenticated sender: richard@kojedz.in)
	by mx.kwebs.cloud (Postfix) with ESMTPSA id 2A3863334;
	Fri, 24 May 2024 05:29:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kojedz.in; s=s02;
	t=1716528572; bh=Ps+ANyr/B7q465UoT9kO3MHg2c/pLzqDVcKQhTfqIQU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=lmDWMbf+3J8BZMHYll+FtDfpmB6qFEO/lyURqU/t6s+6Bxaqs6pI05QR6ZTjd0kvf
	 PbaGs42vDIR2ikflRwBt0Yj/JTXWrEbVJoZD7FgnaC7ANxQe1POTL5tuy/D6WA08V9
	 Ao3Na68NVajN2z43Mfn6rF9mHjiX4weAaudE/YCHDxOPdJpPJ0VsuzyFDuLvVdzAC9
	 y0h4nGQ8opCcXgdqRm8k7VOMjWmsWFAQAmYkO5A3fZilRgGx2R7/qvmPNeI2L2Drsa
	 ZxckxGDmKx4dszQ4tbPL9iD9ls5BZCz8JX4E0G9fUSJoym9DewDe9B3rnXXUPDa25A
	 u90bGFkEHGeHQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kojedz.in; s=s01;
	t=1716528572; bh=Ps+ANyr/B7q465UoT9kO3MHg2c/pLzqDVcKQhTfqIQU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=e7788cxThA0gWW2Zl7HhfWE2YK1F/KH0tYTSX6PWTr8a7kK6V49GE2my/pqmuPSl3
	 xoP0wwpF75iX2rX/hY2/Sq50YQ/yVZpC2LCyrqiEd7l/F1bMCsu+VzDosvmRWShEBa
	 HdclU6rnCgZYV69ND4KE03OsE2fYj265MIdGxsYc7ZoCWZCpuQk4jsFQyIvpY0/ekT
	 Ttt6tDquGE8Qw0hY50f+qAUhDesX7PivPOFEzqWZNXwPfnk0ihSJCA/xRk8uYXFCTW
	 aqZ1nuXNrX1zPTqEUaLtwUJ5ShoSI9q25EXedCZgmVcRS81DuYd/wy51re0eggW2fw
	 3kbxVRBC84w7kPF0ArGzOzc/VATSZL7Hg08vNvY1nGgs3HWptiP8SfrbC9w/Ch0lz6
	 FoJqkkc7Tts1saUGL8/Wy2APVqm22MThoLFE3bysXRmDVkRm7VLvJaAXz/FA1bFbfR
	 gYo9/fac4esA+iOmUbAS9EAmIZC/iy2N7yCBpamePuR8DJysQnH
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Fri, 24 May 2024 07:29:31 +0200
From: Richard Kojedzinszky <richard+debian+bugreport@kojedz.in>
To: NeilBrown <neilb@suse.de>
Cc: linux-nfs@vger.kernel.org, 1071501@bugs.debian.org
Subject: Re: Linux NFS client hangs in nfs4_lookup_revalidate
In-Reply-To: <171650710476.27191.9102106000258626652@noble.neil.brown.name>
References: <>, <162d12087ba8374a57e2263d7ea762b5@kojedz.in>
 <171650710476.27191.9102106000258626652@noble.neil.brown.name>
Message-ID: <bc1e45465347162c0a386cff40ec0cf7@kojedz.in>
X-Sender: richard+debian+bugreport@kojedz.in
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit

Dear Neil,

I've applied your patch, and since then there are no lockups. Before 
that my application reported a lockup in a minute or two, now it has 
been running for half an hour, and still running.

Thanks,
Richard

2024-05-24 01:31 időpontban NeilBrown ezt írta:
> On Fri, 24 May 2024, Richard Kojedzinszky wrote:
>> Dear devs,
>> 
>> I am attaching a stripped down version of the little program which
>> triggers the bug very quickly, in a few minutes in my test lab. It
>> turned out that a single NFS mountpoint is enough. Just start the
>> program giving it the NFS mount as first argument. It will chdir 
>> there,
>> and do file operations, which will trigger a lockup in a few minutes.
> 
> I couldn't get the go code to run.  But then it is a long time since I
> played with go and I didn't try very hard.
> If you could provide simple instructions and a list of package
> dependencies that I need to install (on Debian), I can give it a try.
> 
> Or you could try this patch.  It might help, but I don't have high
> hopes.  It adds some memory barriers and fixes a bug which would cause 
> a
> problem if memory allocation failed (but memory allocation never 
> fails).
> 
> NeilBrown
> 
> diff --git a/fs/nfs/dir.c b/fs/nfs/dir.c
> index ac505671efbd..5bcc0d14d519 100644
> --- a/fs/nfs/dir.c
> +++ b/fs/nfs/dir.c
> @@ -1804,7 +1804,7 @@ __nfs_lookup_revalidate(struct dentry *dentry, 
> unsigned int flags,
>  	} else {
>  		/* Wait for unlink to complete */
>  		wait_var_event(&dentry->d_fsdata,
> -			       dentry->d_fsdata != NFS_FSDATA_BLOCKED);
> +			       smp_load_acquire(&dentry->d_fsdata) != NFS_FSDATA_BLOCKED);
>  		parent = dget_parent(dentry);
>  		ret = reval(d_inode(parent), dentry, flags);
>  		dput(parent);
> @@ -2508,7 +2508,7 @@ int nfs_unlink(struct inode *dir, struct dentry 
> *dentry)
>  	spin_unlock(&dentry->d_lock);
>  	error = nfs_safe_remove(dentry);
>  	nfs_dentry_remove_handle_error(dir, dentry, error);
> -	dentry->d_fsdata = NULL;
> +	smp_store_release(&dentry->d_fsdata, NULL);
>  	wake_up_var(&dentry->d_fsdata);
>  out:
>  	trace_nfs_unlink_exit(dir, dentry, error);
> @@ -2616,7 +2616,7 @@ nfs_unblock_rename(struct rpc_task *task, struct 
> nfs_renamedata *data)
>  {
>  	struct dentry *new_dentry = data->new_dentry;
> 
> -	new_dentry->d_fsdata = NULL;
> +	smp_store_release(&new_dentry->d_fsdata, NULL);
>  	wake_up_var(&new_dentry->d_fsdata);
>  }
> 
> @@ -2717,6 +2717,10 @@ int nfs_rename(struct mnt_idmap *idmap, struct 
> inode *old_dir,
>  	task = nfs_async_rename(old_dir, new_dir, old_dentry, new_dentry,
>  				must_unblock ? nfs_unblock_rename : NULL);
>  	if (IS_ERR(task)) {
> +		if (must_unlock) {
> +			smp_store_release(&new_dentry->d_fsdata, NULL);
> +			wake_up_var(&new_dentry->d_fsdata);
> +		}
>  		error = PTR_ERR(task);
>  		goto out;
>  	}


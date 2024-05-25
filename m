Return-Path: <linux-nfs+bounces-3380-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 72CB78CEFFF
	for <lists+linux-nfs@lfdr.de>; Sat, 25 May 2024 18:02:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1C4EE1F211B1
	for <lists+linux-nfs@lfdr.de>; Sat, 25 May 2024 16:02:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 909D384FB3;
	Sat, 25 May 2024 16:02:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kojedz.in header.i=@kojedz.in header.b="b7PaIDhb";
	dkim=pass (3072-bit key) header.d=kojedz.in header.i=@kojedz.in header.b="bR0KKioW"
X-Original-To: linux-nfs@vger.kernel.org
Received: from fw.sz-a.kwebs.cloud (fw.sz-a.kwebs.cloud [109.61.102.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E2AE84DFD
	for <linux-nfs@vger.kernel.org>; Sat, 25 May 2024 16:02:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=109.61.102.40
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716652969; cv=none; b=TNXaXZ0UioP/LuAjWuoYvY5r769kZ3tpWJqhr+T7v4KIMa+k5Z8Rols0Jl+zCM0T5Q4kqteR+pSzuTNIGKQH0VoNuhKnJVMK3Dedp/0tmlCXG8T7Y0xZ0W120RiRywBnl8C5071t0hqWkmwWRaik5d7VSscDrrcy5FB8AGKp+cs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716652969; c=relaxed/simple;
	bh=B4K+DDqHEOzCh/jANv3NNQwT9xDTi/7Vn4SBevUN/U4=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=NXi0JJMPzVlAungFXv9Ee3oAdC4XBgeWIvysIH2Mw8d4YI/NOMe+0OmaFMzb+3IoXlK9SBwkE4RQSdFV14w+7bv47nExmQcyQNyD7LqkicehNcOiwxI+gYfwd1dZ/k8RtsjXnDsaLb1uS6hVPg7AZomZrX3o+yWHzxFQsQwc+KU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kojedz.in; spf=pass smtp.mailfrom=kojedz.in; dkim=pass (2048-bit key) header.d=kojedz.in header.i=@kojedz.in header.b=b7PaIDhb; dkim=pass (3072-bit key) header.d=kojedz.in header.i=@kojedz.in header.b=bR0KKioW; arc=none smtp.client-ip=109.61.102.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kojedz.in
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kojedz.in
Received: from webmail.srv.kwebs.cloud (172-16-36-105.prometheus-node-exporter.monitoring.svc.cluster.local [172.16.36.105])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
	(No client certificate requested)
	(Authenticated sender: richard@kojedz.in)
	by mx.kwebs.cloud (Postfix) with ESMTPSA id 87B5B6774;
	Sat, 25 May 2024 16:02:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kojedz.in; s=s02;
	t=1716652953; bh=lwCWU1LD36g1fDA5vlm3Q6e/tdWdEnBw5dY4/Pkpf48=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=b7PaIDhboIJo3CzDh/viKZpE1G2rqV09ErH8c/s5KStn6rbv1dbDQC38jNxIA9WC/
	 7zMXpSEvkrwfyjfPETrdIOBvxC/xHrKzhR/D03AFfLgFMVADVLCKyR2ub73srQol5L
	 gtIlXtlQv/yZ1ICT9vE2cCjXYhoQgPuVH3pXVd+M5Q8FvQUR2z0pF+rU7+wN3ald6D
	 hW5DnbWvI4YfpchoJGSTyb7JmVcLmpHPM/ePPCMATyGJ493yIJW+6cbqzdritiHdtG
	 MC5Lc2BPlBjQ/BWWBdvWTluTm06vg6wgJkloPYNWzTeCL2S05Kas3mC4rApJ+CdTh0
	 Mo/fB0K9D8QXw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kojedz.in; s=s01;
	t=1716652953; bh=lwCWU1LD36g1fDA5vlm3Q6e/tdWdEnBw5dY4/Pkpf48=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=bR0KKioWep/N4jLJdbqXiIRvJBdEh1O3d+tYj45K5Vz5xwTjf+AJGBSTeZD3xnQdZ
	 lybT2igu7LfsWwsIvAeTh8vmZRZfYp+4zS9wi3DhWjZg1QUFZrji8ncdFVw1rkB7qe
	 RoVcALfxQOsyiBoWThyYMh5LyM504Y70b7SsosA8sab5IqdzH4h4xwAyPceswQBQQU
	 rwXWEkCSuJ2zeHomjliu1bd3Cy3bjB/X2R8edHHBVKmh6RfF2inFi3AMf9KAiJMs9x
	 STPd/pqmhuxidK40ACg/lxzZRc/zTwBUluLZjTMDAr4ehU3WQVGKUkpQ3RINDyMm0k
	 lWrYGN54stqY36Oi3cPApVNYN21TSTEfvAy6TYkUC1CDM7OUu/N4NijHlZn5g0lmAy
	 az4bZ9XX5b09ZHX6wG+8U919XOwuv8lYXoMIEQEKWp8j9N/4k3bayyxz+fgkKsZocV
	 2+bEJMzEQMAf03CLjqtKzUCx1L8cZgNw2TX3WL/17BSjq3UXv0S
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Sat, 25 May 2024 18:02:32 +0200
From: Richard Kojedzinszky <richard+debian+bugreport@kojedz.in>
To: NeilBrown <neilb@suse.de>
Cc: linux-nfs@vger.kernel.org, 1071501@bugs.debian.org
Subject: Re: Linux NFS client hangs in nfs4_lookup_revalidate
In-Reply-To: <bc1e45465347162c0a386cff40ec0cf7@kojedz.in>
References: <>, <162d12087ba8374a57e2263d7ea762b5@kojedz.in>
 <171650710476.27191.9102106000258626652@noble.neil.brown.name>
 <bc1e45465347162c0a386cff40ec0cf7@kojedz.in>
Message-ID: <b5b3662159163172218262620ca18fb2@kojedz.in>
X-Sender: richard+debian+bugreport@kojedz.in
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit

Dear Neil,

According to my quick tests, your patch seems to fix this bug. Could you 
also manage to try my attached code, could you also reproduce the bug?

Thanks,
Richard

2024-05-24 07:29 időpontban Richard Kojedzinszky ezt írta:
> Dear Neil,
> 
> I've applied your patch, and since then there are no lockups. Before 
> that my application reported a lockup in a minute or two, now it has 
> been running for half an hour, and still running.
> 
> Thanks,
> Richard
> 
> 2024-05-24 01:31 időpontban NeilBrown ezt írta:
>> On Fri, 24 May 2024, Richard Kojedzinszky wrote:
>>> Dear devs,
>>> 
>>> I am attaching a stripped down version of the little program which
>>> triggers the bug very quickly, in a few minutes in my test lab. It
>>> turned out that a single NFS mountpoint is enough. Just start the
>>> program giving it the NFS mount as first argument. It will chdir 
>>> there,
>>> and do file operations, which will trigger a lockup in a few minutes.
>> 
>> I couldn't get the go code to run.  But then it is a long time since I
>> played with go and I didn't try very hard.
>> If you could provide simple instructions and a list of package
>> dependencies that I need to install (on Debian), I can give it a try.
>> 
>> Or you could try this patch.  It might help, but I don't have high
>> hopes.  It adds some memory barriers and fixes a bug which would cause 
>> a
>> problem if memory allocation failed (but memory allocation never 
>> fails).
>> 
>> NeilBrown
>> 
>> diff --git a/fs/nfs/dir.c b/fs/nfs/dir.c
>> index ac505671efbd..5bcc0d14d519 100644
>> --- a/fs/nfs/dir.c
>> +++ b/fs/nfs/dir.c
>> @@ -1804,7 +1804,7 @@ __nfs_lookup_revalidate(struct dentry *dentry, 
>> unsigned int flags,
>>  	} else {
>>  		/* Wait for unlink to complete */
>>  		wait_var_event(&dentry->d_fsdata,
>> -			       dentry->d_fsdata != NFS_FSDATA_BLOCKED);
>> +			       smp_load_acquire(&dentry->d_fsdata) != NFS_FSDATA_BLOCKED);
>>  		parent = dget_parent(dentry);
>>  		ret = reval(d_inode(parent), dentry, flags);
>>  		dput(parent);
>> @@ -2508,7 +2508,7 @@ int nfs_unlink(struct inode *dir, struct dentry 
>> *dentry)
>>  	spin_unlock(&dentry->d_lock);
>>  	error = nfs_safe_remove(dentry);
>>  	nfs_dentry_remove_handle_error(dir, dentry, error);
>> -	dentry->d_fsdata = NULL;
>> +	smp_store_release(&dentry->d_fsdata, NULL);
>>  	wake_up_var(&dentry->d_fsdata);
>>  out:
>>  	trace_nfs_unlink_exit(dir, dentry, error);
>> @@ -2616,7 +2616,7 @@ nfs_unblock_rename(struct rpc_task *task, struct 
>> nfs_renamedata *data)
>>  {
>>  	struct dentry *new_dentry = data->new_dentry;
>> 
>> -	new_dentry->d_fsdata = NULL;
>> +	smp_store_release(&new_dentry->d_fsdata, NULL);
>>  	wake_up_var(&new_dentry->d_fsdata);
>>  }
>> 
>> @@ -2717,6 +2717,10 @@ int nfs_rename(struct mnt_idmap *idmap, struct 
>> inode *old_dir,
>>  	task = nfs_async_rename(old_dir, new_dir, old_dentry, new_dentry,
>>  				must_unblock ? nfs_unblock_rename : NULL);
>>  	if (IS_ERR(task)) {
>> +		if (must_unlock) {
>> +			smp_store_release(&new_dentry->d_fsdata, NULL);
>> +			wake_up_var(&new_dentry->d_fsdata);
>> +		}
>>  		error = PTR_ERR(task);
>>  		goto out;
>>  	}


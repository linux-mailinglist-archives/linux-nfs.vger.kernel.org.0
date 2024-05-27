Return-Path: <linux-nfs+bounces-3392-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F212E8CF763
	for <lists+linux-nfs@lfdr.de>; Mon, 27 May 2024 04:03:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 506071F21976
	for <lists+linux-nfs@lfdr.de>; Mon, 27 May 2024 02:03:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FDAC79DE;
	Mon, 27 May 2024 02:02:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="tya3rdTU";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="wpVeC++L";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="17fNd08e";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="9lTxsK7h"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1238179CC
	for <linux-nfs@vger.kernel.org>; Mon, 27 May 2024 02:02:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716775377; cv=none; b=kQJoNCjNlGeh4DTxr3uXIWqKj/JNmddjhvQbqxODpFKd1rZDCJijPTCpce0QyQzKJYOph0nA2ufHa7tmJwxZUCiQrBYa7aZwkwS0vagsch72kWWgGHNp8zvd8nUOQt0O9igSKG7mTVwH+cFbuROLDdB4WLDlJlTRoet/1xWjJPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716775377; c=relaxed/simple;
	bh=8/6rtgbxnOE7rk/ns5zl5SLv1P+cDyNEiJ1sggOoqcA=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=DmELMS4nc45HCStS2bSm09/PbxzU99xoDFpQT0prQf7ulEpAK/mBf08OUZg29fxY7CiNhBou+QBo/Wj2Nv95v6SyseO5P9b6PKRcjm+Lh8AvqvqjyIWszHz3lcSUmGa13IvUn0WgLtMuXw0T8OpldF1w6ajrLKOmGPqYAJMRwxg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=tya3rdTU; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=wpVeC++L; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=17fNd08e; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=9lTxsK7h; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id E683221B69;
	Mon, 27 May 2024 02:02:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1716775367; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OXSZpUguzfrMexFfgLODOk7/iuNMqg/SqyM/n8WfpV0=;
	b=tya3rdTUcCCRT5TPQ5sjFsy5wmrSpMe0PoyBCYhxl1G32xZ2glI7kDcXUaiVoKMon45AdE
	5NY9EqyQSqbAra7ql7dxzjexIY4ZTSDSOVoQlhb9dhvCU2SAsFcWE7WaKh75+4b1/0k3cF
	yu265WjPm4AhTirHJrY8kI2Pyt7vjp0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1716775367;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OXSZpUguzfrMexFfgLODOk7/iuNMqg/SqyM/n8WfpV0=;
	b=wpVeC++LAUBVNtogzqPmRX/3+ZCePeX5y5CBB8T088BWM5GsXce+2XkIo8lJszBRsqKdA7
	eKcoWWqCgZbeN5DQ==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=17fNd08e;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=9lTxsK7h
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1716775366; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OXSZpUguzfrMexFfgLODOk7/iuNMqg/SqyM/n8WfpV0=;
	b=17fNd08eF+0DcRe+70BXVr+KRFHLwKqsoSmIFX2X5VnYP7aV1Xrl2Ro82QgsWjslFubgJI
	hk2bIqAs71mIjU+/gfDiJdx8y1Q+F/+/igGqavTONevX3J/JlbkqAEP+A2hwVVWJUYEsZB
	XyYMOV87kpIL3sLMtLnWKOTBmi/XhzQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1716775366;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OXSZpUguzfrMexFfgLODOk7/iuNMqg/SqyM/n8WfpV0=;
	b=9lTxsK7hy0YNOY1/OqSE+MUFp7TJN+CAo894oRxml33ngJLLDlrdncFU2migBqE8jLtQfF
	21VS4e+Ca9sXTRAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 68D75137DF;
	Mon, 27 May 2024 02:02:45 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 1HN3A8XpU2Y8aQAAD6G6ig
	(envelope-from <neilb@suse.de>); Mon, 27 May 2024 02:02:45 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "NeilBrown" <neilb@suse.de>
To: "Richard Kojedzinszky" <richard+debian+bugreport@kojedz.in>
Cc: linux-nfs@vger.kernel.org, 1071501@bugs.debian.org
Subject: Re: Linux NFS client hangs in nfs4_lookup_revalidate
In-reply-to: <b5b3662159163172218262620ca18fb2@kojedz.in>
References: <>, <b5b3662159163172218262620ca18fb2@kojedz.in>
Date: Mon, 27 May 2024 12:02:32 +1000
Message-id: <171677535275.27191.4944066644833910892@noble.neil.brown.name>
X-Spam-Flag: NO
X-Spam-Score: -6.51
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: E683221B69
X-Spam-Level: 
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-6.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	DWL_DNSWL_MED(-2.00)[suse.de:dkim];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	ARC_NA(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[debian,bugreport];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns]

On Sun, 26 May 2024, Richard Kojedzinszky wrote:
> Dear Neil,
> 
> According to my quick tests, your patch seems to fix this bug. Could you 
> also manage to try my attached code, could you also reproduce the bug?

Thanks for testing.

I can run your test code but it isn't triggering the bug (90 minutes so
far).  Possibly a different compiler used for the kernel, possibly
hardware differences (I'm running under qemu).  Bugs related to barriers
(which this one seems to be) need just the right circumstances to
trigger so they can be hard to reproduce on a different system.

I've made some cosmetic improvements to the patch and will post it to
the NFS maintainers.

Thanks again,
NeilBrown


> 
> Thanks,
> Richard
> 
> 2024-05-24 07:29 időpontban Richard Kojedzinszky ezt írta:
> > Dear Neil,
> > 
> > I've applied your patch, and since then there are no lockups. Before 
> > that my application reported a lockup in a minute or two, now it has 
> > been running for half an hour, and still running.
> > 
> > Thanks,
> > Richard
> > 
> > 2024-05-24 01:31 időpontban NeilBrown ezt írta:
> >> On Fri, 24 May 2024, Richard Kojedzinszky wrote:
> >>> Dear devs,
> >>> 
> >>> I am attaching a stripped down version of the little program which
> >>> triggers the bug very quickly, in a few minutes in my test lab. It
> >>> turned out that a single NFS mountpoint is enough. Just start the
> >>> program giving it the NFS mount as first argument. It will chdir 
> >>> there,
> >>> and do file operations, which will trigger a lockup in a few minutes.
> >> 
> >> I couldn't get the go code to run.  But then it is a long time since I
> >> played with go and I didn't try very hard.
> >> If you could provide simple instructions and a list of package
> >> dependencies that I need to install (on Debian), I can give it a try.
> >> 
> >> Or you could try this patch.  It might help, but I don't have high
> >> hopes.  It adds some memory barriers and fixes a bug which would cause 
> >> a
> >> problem if memory allocation failed (but memory allocation never 
> >> fails).
> >> 
> >> NeilBrown
> >> 
> >> diff --git a/fs/nfs/dir.c b/fs/nfs/dir.c
> >> index ac505671efbd..5bcc0d14d519 100644
> >> --- a/fs/nfs/dir.c
> >> +++ b/fs/nfs/dir.c
> >> @@ -1804,7 +1804,7 @@ __nfs_lookup_revalidate(struct dentry *dentry, 
> >> unsigned int flags,
> >>  	} else {
> >>  		/* Wait for unlink to complete */
> >>  		wait_var_event(&dentry->d_fsdata,
> >> -			       dentry->d_fsdata != NFS_FSDATA_BLOCKED);
> >> +			       smp_load_acquire(&dentry->d_fsdata) != NFS_FSDATA_BLOCKED);
> >>  		parent = dget_parent(dentry);
> >>  		ret = reval(d_inode(parent), dentry, flags);
> >>  		dput(parent);
> >> @@ -2508,7 +2508,7 @@ int nfs_unlink(struct inode *dir, struct dentry 
> >> *dentry)
> >>  	spin_unlock(&dentry->d_lock);
> >>  	error = nfs_safe_remove(dentry);
> >>  	nfs_dentry_remove_handle_error(dir, dentry, error);
> >> -	dentry->d_fsdata = NULL;
> >> +	smp_store_release(&dentry->d_fsdata, NULL);
> >>  	wake_up_var(&dentry->d_fsdata);
> >>  out:
> >>  	trace_nfs_unlink_exit(dir, dentry, error);
> >> @@ -2616,7 +2616,7 @@ nfs_unblock_rename(struct rpc_task *task, struct 
> >> nfs_renamedata *data)
> >>  {
> >>  	struct dentry *new_dentry = data->new_dentry;
> >> 
> >> -	new_dentry->d_fsdata = NULL;
> >> +	smp_store_release(&new_dentry->d_fsdata, NULL);
> >>  	wake_up_var(&new_dentry->d_fsdata);
> >>  }
> >> 
> >> @@ -2717,6 +2717,10 @@ int nfs_rename(struct mnt_idmap *idmap, struct 
> >> inode *old_dir,
> >>  	task = nfs_async_rename(old_dir, new_dir, old_dentry, new_dentry,
> >>  				must_unblock ? nfs_unblock_rename : NULL);
> >>  	if (IS_ERR(task)) {
> >> +		if (must_unlock) {
> >> +			smp_store_release(&new_dentry->d_fsdata, NULL);
> >> +			wake_up_var(&new_dentry->d_fsdata);
> >> +		}
> >>  		error = PTR_ERR(task);
> >>  		goto out;
> >>  	}
> 



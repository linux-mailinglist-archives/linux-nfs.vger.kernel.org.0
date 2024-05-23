Return-Path: <linux-nfs+bounces-3361-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B6918CDDBA
	for <lists+linux-nfs@lfdr.de>; Fri, 24 May 2024 01:32:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B03711F229C0
	for <lists+linux-nfs@lfdr.de>; Thu, 23 May 2024 23:32:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F22633997;
	Thu, 23 May 2024 23:31:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="JwtWdJqi";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="9X2p04ew";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="JwtWdJqi";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="9X2p04ew"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47132B662
	for <linux-nfs@vger.kernel.org>; Thu, 23 May 2024 23:31:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716507116; cv=none; b=tqumdU9ve65eYwBlimUqhBZ7c6Vi7ehe3qnbAzxjNlQ57VhJO9Y3+L40QVYmi3tEzBC34aMihAFdG6RMF3kHxAJyvD8nnlobKKYtvmZsVHnyRTINKt4JN5Ge/Ur9tWePE7V1ADzOUESxOMjXrQleciENd0F3vfOMIw6YZUU++RY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716507116; c=relaxed/simple;
	bh=ZNFOMp9dM2bn74zYfPu32hlb2QK8T6M5sHJKcjBu0mY=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=bKJbf8PYAWPwEIiKw57KkvKkPkxghxazrQmPHvecu1e3yimNIsN1zjxNJlT7UQF2HSWB7rvzHGk2tkdzbZ8QrHrHGfSRYxqou1iuC6f6a55ZZ2JOhMr3RYIbzRfy1D/ng4ZVEcNJLeQJYrnWz1HQMCXSufB7tQSPpxOcJ5ETWwQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=JwtWdJqi; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=9X2p04ew; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=JwtWdJqi; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=9X2p04ew; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 4B8C6205EA;
	Thu, 23 May 2024 23:31:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1716507111; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=j+TBmHaxqyZj1eH259RL6/GqV+y39TfbfjNQU6biugc=;
	b=JwtWdJqi0uppjCU09mu8HHi3r4hWSniHnkxvSptEbm7Kr8MYzSx1fuPHB+gXPUAlPJl9kQ
	/xtq3OR3GqBGUZceO4+ea6GBsmbWKNAKZrzW2AJqqyQZAp+EJHOMShQg/w+W+PHD7gKOgN
	LXiZhQfTETR7BLr1Pu02qhW3GuM68Og=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1716507111;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=j+TBmHaxqyZj1eH259RL6/GqV+y39TfbfjNQU6biugc=;
	b=9X2p04ewsdtWNMn+xVtD3zYGgearFASXNy3Br7C9C7Y/nRATJLnjIo4JMDLFeqJ8gmw/cq
	gY9H63bNERHSftBw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1716507111; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=j+TBmHaxqyZj1eH259RL6/GqV+y39TfbfjNQU6biugc=;
	b=JwtWdJqi0uppjCU09mu8HHi3r4hWSniHnkxvSptEbm7Kr8MYzSx1fuPHB+gXPUAlPJl9kQ
	/xtq3OR3GqBGUZceO4+ea6GBsmbWKNAKZrzW2AJqqyQZAp+EJHOMShQg/w+W+PHD7gKOgN
	LXiZhQfTETR7BLr1Pu02qhW3GuM68Og=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1716507111;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=j+TBmHaxqyZj1eH259RL6/GqV+y39TfbfjNQU6biugc=;
	b=9X2p04ewsdtWNMn+xVtD3zYGgearFASXNy3Br7C9C7Y/nRATJLnjIo4JMDLFeqJ8gmw/cq
	gY9H63bNERHSftBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C5BAE13A6B;
	Thu, 23 May 2024 23:31:49 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id TFdVGuXRT2bOBwAAD6G6ig
	(envelope-from <neilb@suse.de>); Thu, 23 May 2024 23:31:49 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
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
In-reply-to: <162d12087ba8374a57e2263d7ea762b5@kojedz.in>
References: <>, <162d12087ba8374a57e2263d7ea762b5@kojedz.in>
Date: Fri, 24 May 2024 09:31:44 +1000
Message-id: <171650710476.27191.9102106000258626652@noble.neil.brown.name>
X-Spam-Flag: NO
X-Spam-Score: -4.30
X-Spam-Level: 
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[debian,bugreport];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	RCVD_COUNT_TWO(0.00)[2];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo]

On Fri, 24 May 2024, Richard Kojedzinszky wrote:
> Dear devs,
>=20
> I am attaching a stripped down version of the little program which=20
> triggers the bug very quickly, in a few minutes in my test lab. It=20
> turned out that a single NFS mountpoint is enough. Just start the=20
> program giving it the NFS mount as first argument. It will chdir there,=20
> and do file operations, which will trigger a lockup in a few minutes.

I couldn't get the go code to run.  But then it is a long time since I
played with go and I didn't try very hard.
If you could provide simple instructions and a list of package
dependencies that I need to install (on Debian), I can give it a try.

Or you could try this patch.  It might help, but I don't have high
hopes.  It adds some memory barriers and fixes a bug which would cause a
problem if memory allocation failed (but memory allocation never fails).

NeilBrown

diff --git a/fs/nfs/dir.c b/fs/nfs/dir.c
index ac505671efbd..5bcc0d14d519 100644
--- a/fs/nfs/dir.c
+++ b/fs/nfs/dir.c
@@ -1804,7 +1804,7 @@ __nfs_lookup_revalidate(struct dentry *dentry, unsigned=
 int flags,
 	} else {
 		/* Wait for unlink to complete */
 		wait_var_event(&dentry->d_fsdata,
-			       dentry->d_fsdata !=3D NFS_FSDATA_BLOCKED);
+			       smp_load_acquire(&dentry->d_fsdata) !=3D NFS_FSDATA_BLOCKED);
 		parent =3D dget_parent(dentry);
 		ret =3D reval(d_inode(parent), dentry, flags);
 		dput(parent);
@@ -2508,7 +2508,7 @@ int nfs_unlink(struct inode *dir, struct dentry *dentry)
 	spin_unlock(&dentry->d_lock);
 	error =3D nfs_safe_remove(dentry);
 	nfs_dentry_remove_handle_error(dir, dentry, error);
-	dentry->d_fsdata =3D NULL;
+	smp_store_release(&dentry->d_fsdata, NULL);
 	wake_up_var(&dentry->d_fsdata);
 out:
 	trace_nfs_unlink_exit(dir, dentry, error);
@@ -2616,7 +2616,7 @@ nfs_unblock_rename(struct rpc_task *task, struct nfs_re=
namedata *data)
 {
 	struct dentry *new_dentry =3D data->new_dentry;
=20
-	new_dentry->d_fsdata =3D NULL;
+	smp_store_release(&new_dentry->d_fsdata, NULL);
 	wake_up_var(&new_dentry->d_fsdata);
 }
=20
@@ -2717,6 +2717,10 @@ int nfs_rename(struct mnt_idmap *idmap, struct inode *=
old_dir,
 	task =3D nfs_async_rename(old_dir, new_dir, old_dentry, new_dentry,
 				must_unblock ? nfs_unblock_rename : NULL);
 	if (IS_ERR(task)) {
+		if (must_unlock) {
+			smp_store_release(&new_dentry->d_fsdata, NULL);
+			wake_up_var(&new_dentry->d_fsdata);
+		}
 		error =3D PTR_ERR(task);
 		goto out;
 	}


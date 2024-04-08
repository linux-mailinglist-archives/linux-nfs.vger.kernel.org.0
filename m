Return-Path: <linux-nfs+bounces-2710-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1008789B5DA
	for <lists+linux-nfs@lfdr.de>; Mon,  8 Apr 2024 04:14:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 864631F213CC
	for <lists+linux-nfs@lfdr.de>; Mon,  8 Apr 2024 02:14:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 996291366;
	Mon,  8 Apr 2024 02:14:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="1F+bgRvI";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="kM+aAb9M";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="1F+bgRvI";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="kM+aAb9M"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4D3C63A
	for <linux-nfs@vger.kernel.org>; Mon,  8 Apr 2024 02:14:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712542467; cv=none; b=aPN2GgIPEhtoEctowBZne9kwQX+wfw3t2LDxL7FiQZud6U0NlTl/GH0YeX09M/lYjWujcYzYdi/Os0REngqMKUH80lLtD90GR+2kQKjd+RPFBc6S0Ottt1ZTHY/kJYm5iSw83edX6TjEM5JYUsETr3bMEsdegD8IWyu+jtv46WI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712542467; c=relaxed/simple;
	bh=ZngJMLydGsyb1xXRL6WFPeZ46G1XaSPmGKurIwyi+Lw=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=PZPOgqLULYtaiWpLpI2l3stKTd7+HexTDz4y83xcDukWUyb2gsbQGSbtd7ICR5VY6ezlBv6/1mB0V7ul23cYdJw7KuZczbUKqz3+77FhuajLEUu6kiDAcCb4HE9pmanY/JWWcxFcMVwx4p2ZO0TLmfD+lp4UhMbGLI//0j3nsSA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=1F+bgRvI; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=kM+aAb9M; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=1F+bgRvI; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=kM+aAb9M; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 05309218A4;
	Mon,  8 Apr 2024 02:14:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1712542464; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fz4QYuyTp1Zee/EOyo+1Pv6e/e5hQ3SrAm75J97+1Es=;
	b=1F+bgRvIWQoxqrKX9SsiKboc7YNpZCJz5dGhUCOv1MQm2qeJ9zEVaCxIa1JLblU+hgySyz
	7TUqTgq+xxNiy2GcW76oRvJ1CN1bu0lRmEXv2P7PQLg2/DF5NWJmG6pjwq5ZKN+bWo3ZA3
	ck4oUmKY7lIOzQ9LHfVI3mlfG1ZuuVM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1712542464;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fz4QYuyTp1Zee/EOyo+1Pv6e/e5hQ3SrAm75J97+1Es=;
	b=kM+aAb9M0hncIgQHf4j0lewaXkNP8evH18SBRYvLixobpq/Gs8OnXoyTKQ8YE4PzovHNlP
	2ADq3lO9ddmrNEDw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1712542464; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fz4QYuyTp1Zee/EOyo+1Pv6e/e5hQ3SrAm75J97+1Es=;
	b=1F+bgRvIWQoxqrKX9SsiKboc7YNpZCJz5dGhUCOv1MQm2qeJ9zEVaCxIa1JLblU+hgySyz
	7TUqTgq+xxNiy2GcW76oRvJ1CN1bu0lRmEXv2P7PQLg2/DF5NWJmG6pjwq5ZKN+bWo3ZA3
	ck4oUmKY7lIOzQ9LHfVI3mlfG1ZuuVM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1712542464;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fz4QYuyTp1Zee/EOyo+1Pv6e/e5hQ3SrAm75J97+1Es=;
	b=kM+aAb9M0hncIgQHf4j0lewaXkNP8evH18SBRYvLixobpq/Gs8OnXoyTKQ8YE4PzovHNlP
	2ADq3lO9ddmrNEDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 76BB313796;
	Mon,  8 Apr 2024 02:14:22 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 6j5dBv5SE2ZkEgAAD6G6ig
	(envelope-from <neilb@suse.de>); Mon, 08 Apr 2024 02:14:22 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "NeilBrown" <neilb@suse.de>
To: "Trond Myklebust" <trond.myklebust@hammerspace.com>,
 "Anna Schumaker" <anna@kernel.org>
Cc: linux-nfs@vger.kernel.org
Subject:
 Re: [PATCH] NFS: add atomic_open for NFSv3 to handle O_TRUNC correctly.
In-reply-to: <171134496555.13576.1334297096866165638@noble.neil.brown.name>
References: <171134496555.13576.1334297096866165638@noble.neil.brown.name>
Date: Mon, 08 Apr 2024 12:14:14 +1000
Message-id: <171254245463.17212.13457550623404727123@noble.neil.brown.name>
X-Spam-Level: 
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-0.983];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns]
X-Spam-Score: -4.30
X-Spam-Flag: NO


Hi,
 any thoughts about this patch and/or the problem it addresses?

Thanks,
NeilBrown

On Mon, 25 Mar 2024, NeilBrown wrote:
> With two clients, each with NFSv3 mounts of the same directory, the sequenc=
e:
>=20
>    client1            client2
>   ls -l afile
>                       echo hello there > afile
>   echo HELLO > afile
>   cat afile
>=20
> will show
>    HELLO
>    there
>=20
> because the O_TRUNC requested in the final 'echo' doesn't take effect.
> This is because the "Negative dentry, just create a file" section in
> lookup_open() assumes that the file *does* get created since the dentry
> was negative, so it sets FMODE_CREATED, and this causes do_open() to
> clear O_TRUNC and so the file doesn't get truncated.
>=20
> Even mounting with -o lookupcache=3Dnone does not help as
> nfs_neg_need_reval() always returns false if LOOKUP_CREATE is set.
>=20
> This patch fixes the problem by providing an atomic_open inode operation
> for NFSv3 (and v2).  The code is largely the code from the branch in
> lookup_open() when atomic_open is not provided.  The significant change
> is that the O_TRUNC flag is passed a new nfs_do_create() which add
> 'trunc' handling to nfs_create().
>=20
> With this change we also optimise away an unnecessary LOOKUP before the
> file is created.
>=20
> Signed-off-by: NeilBrown <neilb@suse.de>
> ---
>  fs/nfs/dir.c           | 54 +++++++++++++++++++++++++++++++++++++++---
>  fs/nfs/nfs3proc.c      |  1 +
>  fs/nfs/proc.c          |  1 +
>  include/linux/nfs_fs.h |  3 +++
>  4 files changed, 56 insertions(+), 3 deletions(-)
>=20
> diff --git a/fs/nfs/dir.c b/fs/nfs/dir.c
> index ac505671efbd..342930996226 100644
> --- a/fs/nfs/dir.c
> +++ b/fs/nfs/dir.c
> @@ -56,6 +56,8 @@ static int nfs_readdir(struct file *, struct dir_context =
*);
>  static int nfs_fsync_dir(struct file *, loff_t, loff_t, int);
>  static loff_t nfs_llseek_dir(struct file *, loff_t, int);
>  static void nfs_readdir_clear_array(struct folio *);
> +static int nfs_do_create(struct inode *dir, struct dentry *dentry,
> +			 umode_t mode, int open_flags);
> =20
>  const struct file_operations nfs_dir_operations =3D {
>  	.llseek		=3D nfs_llseek_dir,
> @@ -2243,6 +2245,41 @@ static int nfs4_lookup_revalidate(struct dentry *den=
try, unsigned int flags)
> =20
>  #endif /* CONFIG_NFSV4 */
> =20
> +int nfs_atomic_open_v23(struct inode *dir, struct dentry *dentry,
> +			struct file *file, unsigned int open_flags,
> +			umode_t mode)
> +{
> +
> +	/* Same as look+open from lookup_open(), but with different O_TRUNC
> +	 * handling.
> +	 */
> +	int error =3D 0;
> +
> +	if (open_flags & O_CREAT) {
> +		file->f_mode |=3D FMODE_CREATED;
> +		error =3D nfs_do_create(dir, dentry, mode, open_flags);
> +		if (error)
> +			return error;
> +		return finish_open(file, dentry, NULL);
> +	} else if (d_in_lookup(dentry)) {
> +		/* The only flags nfs_lookup considers are
> +		 * LOOKUP_EXCL and LOOKUP_RENAME_TARGET, and
> +		 * we want those to be zero so the lookup isn't skipped.
> +		 */
> +		struct dentry *res =3D nfs_lookup(dir, dentry, 0);
> +
> +		d_lookup_done(dentry);
> +		if (unlikely(res)) {
> +			if (IS_ERR(res))
> +				return PTR_ERR(res);
> +			return finish_no_open(file, res);
> +		}
> +	}
> +	return finish_no_open(file, NULL);
> +
> +}
> +EXPORT_SYMBOL_GPL(nfs_atomic_open_v23);
> +
>  struct dentry *
>  nfs_add_or_obtain(struct dentry *dentry, struct nfs_fh *fhandle,
>  				struct nfs_fattr *fattr)
> @@ -2303,18 +2340,23 @@ EXPORT_SYMBOL_GPL(nfs_instantiate);
>   * that the operation succeeded on the server, but an error in the
>   * reply path made it appear to have failed.
>   */
> -int nfs_create(struct mnt_idmap *idmap, struct inode *dir,
> -	       struct dentry *dentry, umode_t mode, bool excl)
> +static int nfs_do_create(struct inode *dir, struct dentry *dentry,
> +			 umode_t mode, int open_flags)
>  {
>  	struct iattr attr;
> -	int open_flags =3D excl ? O_CREAT | O_EXCL : O_CREAT;
>  	int error;
> =20
> +	open_flags |=3D O_CREAT;
> +
>  	dfprintk(VFS, "NFS: create(%s/%lu), %pd\n",
>  			dir->i_sb->s_id, dir->i_ino, dentry);
> =20
>  	attr.ia_mode =3D mode;
>  	attr.ia_valid =3D ATTR_MODE;
> +	if (open_flags & O_TRUNC) {
> +		attr.ia_size =3D 0;
> +		attr.ia_valid |=3D ATTR_SIZE;
> +	}
> =20
>  	trace_nfs_create_enter(dir, dentry, open_flags);
>  	error =3D NFS_PROTO(dir)->create(dir, dentry, &attr, open_flags);
> @@ -2326,6 +2368,12 @@ int nfs_create(struct mnt_idmap *idmap, struct inode=
 *dir,
>  	d_drop(dentry);
>  	return error;
>  }
> +
> +int nfs_create(struct mnt_idmap *idmap, struct inode *dir,
> +	       struct dentry *dentry, umode_t mode, bool excl)
> +{
> +	return nfs_do_create(dir, dentry, mode, excl ? O_EXCL : 0);
> +}
>  EXPORT_SYMBOL_GPL(nfs_create);
> =20
>  /*
> diff --git a/fs/nfs/nfs3proc.c b/fs/nfs/nfs3proc.c
> index cbbe3f0193b8..74bda639a7cf 100644
> --- a/fs/nfs/nfs3proc.c
> +++ b/fs/nfs/nfs3proc.c
> @@ -986,6 +986,7 @@ static int nfs3_have_delegation(struct inode *inode, fm=
ode_t flags)
> =20
>  static const struct inode_operations nfs3_dir_inode_operations =3D {
>  	.create		=3D nfs_create,
> +	.atomic_open	=3D nfs_atomic_open_v23,
>  	.lookup		=3D nfs_lookup,
>  	.link		=3D nfs_link,
>  	.unlink		=3D nfs_unlink,
> diff --git a/fs/nfs/proc.c b/fs/nfs/proc.c
> index ad3a321ae997..d105e5b2659d 100644
> --- a/fs/nfs/proc.c
> +++ b/fs/nfs/proc.c
> @@ -695,6 +695,7 @@ static int nfs_have_delegation(struct inode *inode, fmo=
de_t flags)
>  static const struct inode_operations nfs_dir_inode_operations =3D {
>  	.create		=3D nfs_create,
>  	.lookup		=3D nfs_lookup,
> +	.atomic_open	=3D nfs_atomic_open_v23,
>  	.link		=3D nfs_link,
>  	.unlink		=3D nfs_unlink,
>  	.symlink	=3D nfs_symlink,
> diff --git a/include/linux/nfs_fs.h b/include/linux/nfs_fs.h
> index d59116ac8209..039898d70954 100644
> --- a/include/linux/nfs_fs.h
> +++ b/include/linux/nfs_fs.h
> @@ -561,6 +561,9 @@ extern int nfs_may_open(struct inode *inode, const stru=
ct cred *cred, int openfl
>  extern void nfs_access_zap_cache(struct inode *inode);
>  extern int nfs_access_get_cached(struct inode *inode, const struct cred *c=
red,
>  				 u32 *mask, bool may_block);
> +extern int nfs_atomic_open_v23(struct inode *dir, struct dentry *dentry,
> +			       struct file *file, unsigned int open_flags,
> +			       umode_t mode);
> =20
>  /*
>   * linux/fs/nfs/symlink.c
> --=20
> 2.44.0
>=20
>=20
>=20



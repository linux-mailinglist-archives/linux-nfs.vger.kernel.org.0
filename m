Return-Path: <linux-nfs+bounces-1609-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 41BB4842F71
	for <lists+linux-nfs@lfdr.de>; Tue, 30 Jan 2024 23:13:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 64BAF1C20B21
	for <lists+linux-nfs@lfdr.de>; Tue, 30 Jan 2024 22:13:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD1027D403;
	Tue, 30 Jan 2024 22:13:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="UqZWqPlD";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="BA4OwUT+";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="UqZWqPlD";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="BA4OwUT+"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D50127D402
	for <linux-nfs@vger.kernel.org>; Tue, 30 Jan 2024 22:13:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706652819; cv=none; b=n59TXYlOzr1yUaP5tjOPva0bDKiJ7/tPZHM7chu8ij36DOdaCADndz9aOI3Fin+hAwQzdKa0bOaRnCM4DbGXXxviPkRzFIPyBGSln/+2Cjzo07ZnpOh+MSbS1YcfjA3HypGLRwu732WOtj9JwJeVZfZO6xDcfVIWkgIzPZYghGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706652819; c=relaxed/simple;
	bh=M6u11KhnctgXQqaQM3ghn1zsNFBuL/CvZ6kCQrudfAg=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=HdWzytQ32hi7r6/H4IngFvnpKpXcf0PD8FHvAf4fl01LUSrRlkFrBE3LnfRU450NdmtBkloTgpXOxRcp+yQe6W+3xkNLzcp+RXX7asRC8zEeZH3AD3BYo+ZBvHdXjWD+5QcyUPce6kZVnP6841CGKVCclq3mOktp+iGhy6WtM0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=UqZWqPlD; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=BA4OwUT+; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=UqZWqPlD; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=BA4OwUT+; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 5D3A1220E7;
	Tue, 30 Jan 2024 22:13:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1706652815; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5rHKOAhOX/S8/oRrSOOmHOrqmxYHSJaQT4f/VwVa7FI=;
	b=UqZWqPlDauAoEQnSJwAtXxIO6yuX+bu4sM5dPq6AqbqnuKUZ2KJ8S5TdbGxRx4SooKokZn
	IMhIXKPfXMjOaPfT8PCmVXar4i/6j9FKhHHiA0xa/k9cc6G/0Jm32wNWnQB1/V/JZfxKjp
	AILr0ZzJPJBeCUH5zy9zMdkVFta2b+Y=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1706652815;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5rHKOAhOX/S8/oRrSOOmHOrqmxYHSJaQT4f/VwVa7FI=;
	b=BA4OwUT+zvzR1LsTFLcFNghmbGCqFwpUNy/q14FC8oRSdrOa/zDppndsFMa7vxi6zgjKU9
	as4MNUG8TnUkxhDw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1706652815; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5rHKOAhOX/S8/oRrSOOmHOrqmxYHSJaQT4f/VwVa7FI=;
	b=UqZWqPlDauAoEQnSJwAtXxIO6yuX+bu4sM5dPq6AqbqnuKUZ2KJ8S5TdbGxRx4SooKokZn
	IMhIXKPfXMjOaPfT8PCmVXar4i/6j9FKhHHiA0xa/k9cc6G/0Jm32wNWnQB1/V/JZfxKjp
	AILr0ZzJPJBeCUH5zy9zMdkVFta2b+Y=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1706652815;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5rHKOAhOX/S8/oRrSOOmHOrqmxYHSJaQT4f/VwVa7FI=;
	b=BA4OwUT+zvzR1LsTFLcFNghmbGCqFwpUNy/q14FC8oRSdrOa/zDppndsFMa7vxi6zgjKU9
	as4MNUG8TnUkxhDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 43A4913A27;
	Tue, 30 Jan 2024 22:13:31 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id TcbnOYt0uWWFUgAAD6G6ig
	(envelope-from <neilb@suse.de>); Tue, 30 Jan 2024 22:13:31 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "NeilBrown" <neilb@suse.de>
To: "Jeff Layton" <jlayton@kernel.org>
Cc: "Chuck Lever" <chuck.lever@oracle.com>, linux-nfs@vger.kernel.org,
 "Olga Kornievskaia" <kolga@netapp.com>, "Dai Ngo" <Dai.Ngo@oracle.com>,
 "Tom Talpey" <tom@talpey.com>, "Christoph Hellwig" <hch@lst.de>,
 "Tom Haynes" <loghyr@gmail.com>
Subject: Re: [PATCH 13/13] nfsd: allow layout state to be admin-revoked.
In-reply-to: <a9f76a1fa6362ad92e37c22d28940896d378890a.camel@kernel.org>
References: <20240130011102.8623-1-neilb@suse.de>,
 <20240130011102.8623-14-neilb@suse.de>,
 <a9f76a1fa6362ad92e37c22d28940896d378890a.camel@kernel.org>
Date: Wed, 31 Jan 2024 09:13:29 +1100
Message-id: <170665280921.21664.13517860700673336994@noble.neil.brown.name>
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=UqZWqPlD;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=BA4OwUT+
X-Spamd-Result: default: False [-3.31 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 FREEMAIL_ENVRCPT(0.00)[gmail.com];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 DKIM_TRACE(0.00)[suse.de:+];
	 MX_GOOD(-0.01)[];
	 RCPT_COUNT_SEVEN(0.00)[8];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 FREEMAIL_CC(0.00)[oracle.com,vger.kernel.org,netapp.com,talpey.com,lst.de,gmail.com];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-3.00)[100.00%]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 5D3A1220E7
X-Spam-Level: 
X-Spam-Score: -3.31
X-Spam-Flag: NO

On Tue, 30 Jan 2024, Jeff Layton wrote:
> On Tue, 2024-01-30 at 12:08 +1100, NeilBrown wrote:
> > When there is layout state on a filesystem that is being "unlocked" that
> > is now revoked, which involves closing the nfsd_file and releasing the
> > vfs lease.
> >=20
> > To avoid races, ->ls_file can now be accessed either:
> >  - under ->fi_lock for the state's sc_file or
> >  - under rcu_read_lock() if nfsd_file_get() is used.
> > To support this, ->fence_client and nfsd4_cb_layout_fail() now take a
> > second argument being the nfsd_file.
> >=20
> > Signed-off-by: NeilBrown <neilb@suse.de>
> > ---
> >  fs/nfsd/blocklayout.c |  4 ++--
> >  fs/nfsd/nfs4layouts.c | 43 ++++++++++++++++++++++++++++++++-----------
> >  fs/nfsd/nfs4state.c   | 11 +++++++++--
> >  fs/nfsd/pnfs.h        |  8 +++++++-
> >  4 files changed, 50 insertions(+), 16 deletions(-)
> >=20
> > diff --git a/fs/nfsd/blocklayout.c b/fs/nfsd/blocklayout.c
> > index 46fd74d91ea9..3c040c81c77d 100644
> > --- a/fs/nfsd/blocklayout.c
> > +++ b/fs/nfsd/blocklayout.c
> > @@ -328,10 +328,10 @@ nfsd4_scsi_proc_layoutcommit(struct inode *inode,
> >  }
> > =20
> >  static void
> > -nfsd4_scsi_fence_client(struct nfs4_layout_stateid *ls)
> > +nfsd4_scsi_fence_client(struct nfs4_layout_stateid *ls, struct nfsd_file=
 *file)
> >  {
> >  	struct nfs4_client *clp =3D ls->ls_stid.sc_client;
> > -	struct block_device *bdev =3D ls->ls_file->nf_file->f_path.mnt->mnt_sb-=
>s_bdev;
> > +	struct block_device *bdev =3D file->nf_file->f_path.mnt->mnt_sb->s_bdev;
> > =20
> >  	bdev->bd_disk->fops->pr_ops->pr_preempt(bdev, NFSD_MDS_PR_KEY,
> >  			nfsd4_scsi_pr_key(clp), 0, true);
> > diff --git a/fs/nfsd/nfs4layouts.c b/fs/nfsd/nfs4layouts.c
> > index 857b822450b4..1cfd61db2472 100644
> > --- a/fs/nfsd/nfs4layouts.c
> > +++ b/fs/nfsd/nfs4layouts.c
> > @@ -152,6 +152,23 @@ void nfsd4_setup_layout_type(struct svc_export *exp)
> >  #endif
> >  }
> > =20
> > +void nfsd4_close_layout(struct nfs4_layout_stateid *ls)
> > +{
> > +	struct nfsd_file *fl;
> > +
> > +	spin_lock(&ls->ls_stid.sc_file->fi_lock);
> > +	fl =3D ls->ls_file;
> > +	ls->ls_file =3D NULL;
> > +	spin_unlock(&ls->ls_stid.sc_file->fi_lock);
> > +
> > +	if (fl) {
> > +		if (!nfsd4_layout_ops[ls->ls_layout_type]->disable_recalls)
> > +			vfs_setlease(fl->nf_file, F_UNLCK, NULL,
> > +				     (void **)&ls);
> > +		nfsd_file_put(fl);
> > +	}
> > +}
> > +
> >  static void
> >  nfsd4_free_layout_stateid(struct nfs4_stid *stid)
> >  {
> > @@ -169,9 +186,7 @@ nfsd4_free_layout_stateid(struct nfs4_stid *stid)
> >  	list_del_init(&ls->ls_perfile);
> >  	spin_unlock(&fp->fi_lock);
> > =20
> > -	if (!nfsd4_layout_ops[ls->ls_layout_type]->disable_recalls)
> > -		vfs_setlease(ls->ls_file->nf_file, F_UNLCK, NULL, (void **)&ls);
> > -	nfsd_file_put(ls->ls_file);
> > +	nfsd4_close_layout(ls);
> > =20
> >  	if (ls->ls_recalled)
> >  		atomic_dec(&ls->ls_stid.sc_file->fi_lo_recalls);
> > @@ -605,7 +620,7 @@ nfsd4_return_all_file_layouts(struct nfs4_client *clp=
, struct nfs4_file *fp)
> >  }
> > =20
> >  static void
> > -nfsd4_cb_layout_fail(struct nfs4_layout_stateid *ls)
> > +nfsd4_cb_layout_fail(struct nfs4_layout_stateid *ls, struct nfsd_file *f=
ile)
> >  {
> >  	struct nfs4_client *clp =3D ls->ls_stid.sc_client;
> >  	char addr_str[INET6_ADDRSTRLEN];
> > @@ -627,7 +642,7 @@ nfsd4_cb_layout_fail(struct nfs4_layout_stateid *ls)
> > =20
> >  	argv[0] =3D (char *)nfsd_recall_failed;
> >  	argv[1] =3D addr_str;
> > -	argv[2] =3D ls->ls_file->nf_file->f_path.mnt->mnt_sb->s_id;
> > +	argv[2] =3D file->nf_file->f_path.mnt->mnt_sb->s_id;
> >  	argv[3] =3D NULL;
> > =20
> >  	error =3D call_usermodehelper(nfsd_recall_failed, argv, envp,
> > @@ -657,6 +672,7 @@ nfsd4_cb_layout_done(struct nfsd4_callback *cb, struc=
t rpc_task *task)
> >  	struct nfsd_net *nn;
> >  	ktime_t now, cutoff;
> >  	const struct nfsd4_layout_ops *ops;
> > +	struct nfsd_file *fl;
> > =20
> >  	trace_nfsd_cb_layout_done(&ls->ls_stid.sc_stateid, task);
> >  	switch (task->tk_status) {
> > @@ -688,12 +704,17 @@ nfsd4_cb_layout_done(struct nfsd4_callback *cb, str=
uct rpc_task *task)
> >  		 * Unknown error or non-responding client, we'll need to fence.
> >  		 */
> >  		trace_nfsd_layout_recall_fail(&ls->ls_stid.sc_stateid);
> > -
> > -		ops =3D nfsd4_layout_ops[ls->ls_layout_type];
> > -		if (ops->fence_client)
> > -			ops->fence_client(ls);
> > -		else
> > -			nfsd4_cb_layout_fail(ls);
> > +		rcu_read_lock();
> > +		fl =3D nfsd_file_get(ls->ls_file);
> > +		rcu_read_unlock();
>=20
> I'm still wondering about the rcu_read_lock above. It's probably
> harmless, but it seems unnecessary since you already hold a reference to
> "ls". Is there a reason for it?

I replied !

https://lore.kernel.org/linux-nfs/170657686307.21664.13889535187781187364@nob=
le.neil.brown.name/

See nfsd4_close_layout().  A ref on ls doesn't guarantee a ref on
ls->ls_file any more.

NeilBrown

>=20
> > +		if (fl) {
> > +			ops =3D nfsd4_layout_ops[ls->ls_layout_type];
> > +			if (ops->fence_client)
> > +				ops->fence_client(ls, fl);
> > +			else
> > +				nfsd4_cb_layout_fail(ls, fl);
> > +			nfsd_file_put(fl);
> > +		}
> >  		return 1;
> >  	case -NFS4ERR_NOMATCHING_LAYOUT:
> >  		trace_nfsd_layout_recall_done(&ls->ls_stid.sc_stateid);
> > diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
> > index fe21af8dfc68..a66d66b9f769 100644
> > --- a/fs/nfsd/nfs4state.c
> > +++ b/fs/nfsd/nfs4state.c
> > @@ -1721,7 +1721,7 @@ void nfsd4_revoke_states(struct net *net, struct su=
per_block *sb)
> >  	unsigned int idhashval;
> >  	unsigned int sc_types;
> > =20
> > -	sc_types =3D SC_TYPE_OPEN | SC_TYPE_LOCK | SC_TYPE_DELEG;
> > +	sc_types =3D SC_TYPE_OPEN | SC_TYPE_LOCK | SC_TYPE_DELEG | SC_TYPE_LAYO=
UT;
> > =20
> >  	spin_lock(&nn->client_lock);
> >  	for (idhashval =3D 0; idhashval < CLIENT_HASH_MASK; idhashval++) {
> > @@ -1734,6 +1734,7 @@ void nfsd4_revoke_states(struct net *net, struct su=
per_block *sb)
> >  			if (stid) {
> >  				struct nfs4_ol_stateid *stp;
> >  				struct nfs4_delegation *dp;
> > +				struct nfs4_layout_stateid *ls;
> > =20
> >  				spin_unlock(&nn->client_lock);
> >  				switch (stid->sc_type) {
> > @@ -1789,6 +1790,10 @@ void nfsd4_revoke_states(struct net *net, struct s=
uper_block *sb)
> >  					if (dp)
> >  						revoke_delegation(dp);
> >  					break;
> > +				case SC_TYPE_LAYOUT:
> > +					ls =3D layoutstateid(stid);
> > +					nfsd4_close_layout(ls);
> > +					break;
> >  				}
> >  				nfs4_put_stid(stid);
> >  				spin_lock(&nn->client_lock);
> > @@ -2868,7 +2873,6 @@ static int nfs4_show_layout(struct seq_file *s, str=
uct nfs4_stid *st)
> >  	struct nfsd_file *file;
> > =20
> >  	ls =3D container_of(st, struct nfs4_layout_stateid, ls_stid);
> > -	file =3D ls->ls_file;
> > =20
> >  	seq_puts(s, "- ");
> >  	nfs4_show_stateid(s, &st->sc_stateid);
> > @@ -2876,12 +2880,15 @@ static int nfs4_show_layout(struct seq_file *s, s=
truct nfs4_stid *st)
> > =20
> >  	/* XXX: What else would be useful? */
> > =20
> > +	spin_lock(&ls->ls_stid.sc_file->fi_lock);
> > +	file =3D ls->ls_file;
> >  	if (file) {
> >  		seq_puts(s, ", ");
> >  		nfs4_show_superblock(s, file);
> >  		seq_puts(s, ", ");
> >  		nfs4_show_fname(s, file);
> >  	}
> > +	spin_unlock(&ls->ls_stid.sc_file->fi_lock);
> >  	if (st->sc_status & SC_STATUS_ADMIN_REVOKED)
> >  		seq_puts(s, ", admin-revoked");
> >  	seq_puts(s, " }\n");
> > diff --git a/fs/nfsd/pnfs.h b/fs/nfsd/pnfs.h
> > index de1e0dfed06a..925817f66917 100644
> > --- a/fs/nfsd/pnfs.h
> > +++ b/fs/nfsd/pnfs.h
> > @@ -37,7 +37,8 @@ struct nfsd4_layout_ops {
> >  	__be32 (*proc_layoutcommit)(struct inode *inode,
> >  			struct nfsd4_layoutcommit *lcp);
> > =20
> > -	void (*fence_client)(struct nfs4_layout_stateid *ls);
> > +	void (*fence_client)(struct nfs4_layout_stateid *ls,
> > +			     struct nfsd_file *file);
> >  };
> > =20
> >  extern const struct nfsd4_layout_ops *nfsd4_layout_ops[];
> > @@ -72,11 +73,13 @@ void nfsd4_setup_layout_type(struct svc_export *exp);
> >  void nfsd4_return_all_client_layouts(struct nfs4_client *);
> >  void nfsd4_return_all_file_layouts(struct nfs4_client *clp,
> >  		struct nfs4_file *fp);
> > +void nfsd4_close_layout(struct nfs4_layout_stateid *ls);
> >  int nfsd4_init_pnfs(void);
> >  void nfsd4_exit_pnfs(void);
> >  #else
> >  struct nfs4_client;
> >  struct nfs4_file;
> > +struct nfs4_layout_stateid;
> > =20
> >  static inline void nfsd4_setup_layout_type(struct svc_export *exp)
> >  {
> > @@ -89,6 +92,9 @@ static inline void nfsd4_return_all_file_layouts(struct=
 nfs4_client *clp,
> >  		struct nfs4_file *fp)
> >  {
> >  }
> > +static inline void nfsd4_close_layout(struct nfs4_layout_stateid *ls)
> > +{
> > +}
> >  static inline void nfsd4_exit_pnfs(void)
> >  {
> >  }
>=20
> --=20
> Jeff Layton <jlayton@kernel.org>
>=20
>=20



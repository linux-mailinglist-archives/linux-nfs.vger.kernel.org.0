Return-Path: <linux-nfs+bounces-781-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8696C81D04C
	for <lists+linux-nfs@lfdr.de>; Sat, 23 Dec 2023 00:03:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 97C921C22CF9
	for <lists+linux-nfs@lfdr.de>; Fri, 22 Dec 2023 23:03:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80D0E2E84F;
	Fri, 22 Dec 2023 23:03:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Yc2lKSJv";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="yFwZSODP";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Yc2lKSJv";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="yFwZSODP"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EF7731726
	for <linux-nfs@vger.kernel.org>; Fri, 22 Dec 2023 23:02:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 4902C1FB6D;
	Fri, 22 Dec 2023 23:02:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1703286178; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aOO9xjzq5TP4SFISWXa3z1DKC1PJvImyuojLxxo5g2A=;
	b=Yc2lKSJvs4VPtAPTXYnjHcMGkeRKTsene/OKAiW1SCLv2qY3XcnLt9U0mqfFxbbSqPKmrg
	HM0IXpsd6IZUqqNSWvbWOjxcgFdU/DNHRuWEcIphtjKBkBQ35Td6h16UU3AqgY99bEd9D4
	DU3btdlN88Fx2monH6mqdy5xjhpjPTE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1703286178;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aOO9xjzq5TP4SFISWXa3z1DKC1PJvImyuojLxxo5g2A=;
	b=yFwZSODPI1UDW8iZsMVzirV6X0ovP6ZhM6kdU85wlwxxLZfyyoYb09bMKiwkY98/Zraiod
	8Ue79brIkq11kVDQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1703286178; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aOO9xjzq5TP4SFISWXa3z1DKC1PJvImyuojLxxo5g2A=;
	b=Yc2lKSJvs4VPtAPTXYnjHcMGkeRKTsene/OKAiW1SCLv2qY3XcnLt9U0mqfFxbbSqPKmrg
	HM0IXpsd6IZUqqNSWvbWOjxcgFdU/DNHRuWEcIphtjKBkBQ35Td6h16UU3AqgY99bEd9D4
	DU3btdlN88Fx2monH6mqdy5xjhpjPTE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1703286178;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aOO9xjzq5TP4SFISWXa3z1DKC1PJvImyuojLxxo5g2A=;
	b=yFwZSODPI1UDW8iZsMVzirV6X0ovP6ZhM6kdU85wlwxxLZfyyoYb09bMKiwkY98/Zraiod
	8Ue79brIkq11kVDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E3C2613997;
	Fri, 22 Dec 2023 23:02:55 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id VFj1JZ8VhmUiCwAAD6G6ig
	(envelope-from <neilb@suse.de>); Fri, 22 Dec 2023 23:02:55 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "NeilBrown" <neilb@suse.de>
To: "Chuck Lever" <chuck.lever@oracle.com>
Cc: "Jeff Layton" <jlayton@kernel.org>, linux-nfs@vger.kernel.org,
 "Olga Kornievskaia" <kolga@netapp.com>, "Dai Ngo" <Dai.Ngo@oracle.com>,
 "Tom Talpey" <tom@talpey.com>
Subject: Re: [PATCH 11/11] nfsd: allow layout state to be admin-revoked.
In-reply-to: <ZYWk3KBmZs28QQKY@tissot.1015granger.net>
References: <20231124002925.1816-1-neilb@suse.de>,
 <20231124002925.1816-12-neilb@suse.de>,
 <ZWS1B2qGiu2SqARc@tissot.1015granger.net>,
 <ZYWk3KBmZs28QQKY@tissot.1015granger.net>
Date: Sat, 23 Dec 2023 10:02:49 +1100
Message-id: <170328616900.11005.13303547664849585599@noble.neil.brown.name>
X-Spam-Level: ***
X-Spam-Level: 
X-Spamd-Result: default: False [-3.10 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 RCPT_COUNT_FIVE(0.00)[6];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-3.00)[100.00%]
Authentication-Results: smtp-out2.suse.de;
	none
X-Spam-Score: -3.10
X-Spam-Flag: NO

On Sat, 23 Dec 2023, Chuck Lever wrote:
> On Mon, Nov 27, 2023 at 10:25:59AM -0500, Chuck Lever wrote:
> > On Fri, Nov 24, 2023 at 11:28:46AM +1100, NeilBrown wrote:
> > > When there is layout state on a filesystem that is being "unlocked" that
> > > is now revoked, which involves closing the nfsd_file and releasing the
> > > vfs lease.
> > >=20
> > > To avoid races, all users of ->ls_file - after the layout state has been
> > > successfully created - now need to take a counted reference under
> > > rcu_read_lock().  To support this, ->fence_client and
> > > nfsd4_cb_layout_fail() now take a second argument being the nfsd_file.
> > >=20
> > > Signed-off-by: NeilBrown <neilb@suse.de>
> >=20
> > Hi Neil, would you Cc: Christoph Hellwig <hch@lst.de> and Tom Haynes
> > <loghyr@gmail.com> to this patch next time you post this series?
>=20
> Re-visiting. Did you send out a v5 of this series and I missed it?

No you didn't miss anything.  I think I got caught up with other
priorities.  I'll hopefully repost early in the new year.

NeilBrown


>=20
>=20
> > > ---
> > >  fs/nfsd/blocklayout.c |  4 ++--
> > >  fs/nfsd/nfs4layouts.c | 38 +++++++++++++++++++++++++++-----------
> > >  fs/nfsd/nfs4state.c   | 28 +++++++++++++++++++++-------
> > >  fs/nfsd/pnfs.h        |  7 ++++++-
> > >  4 files changed, 56 insertions(+), 21 deletions(-)
> > >=20
> > > diff --git a/fs/nfsd/blocklayout.c b/fs/nfsd/blocklayout.c
> > > index 46fd74d91ea9..3c040c81c77d 100644
> > > --- a/fs/nfsd/blocklayout.c
> > > +++ b/fs/nfsd/blocklayout.c
> > > @@ -328,10 +328,10 @@ nfsd4_scsi_proc_layoutcommit(struct inode *inode,
> > >  }
> > > =20
> > >  static void
> > > -nfsd4_scsi_fence_client(struct nfs4_layout_stateid *ls)
> > > +nfsd4_scsi_fence_client(struct nfs4_layout_stateid *ls, struct nfsd_fi=
le *file)
> > >  {
> > >  	struct nfs4_client *clp =3D ls->ls_stid.sc_client;
> > > -	struct block_device *bdev =3D ls->ls_file->nf_file->f_path.mnt->mnt_s=
b->s_bdev;
> > > +	struct block_device *bdev =3D file->nf_file->f_path.mnt->mnt_sb->s_bd=
ev;
> > > =20
> > >  	bdev->bd_disk->fops->pr_ops->pr_preempt(bdev, NFSD_MDS_PR_KEY,
> > >  			nfsd4_scsi_pr_key(clp), 0, true);
> > > diff --git a/fs/nfsd/nfs4layouts.c b/fs/nfsd/nfs4layouts.c
> > > index 77656126ad2a..dbc52413ce57 100644
> > > --- a/fs/nfsd/nfs4layouts.c
> > > +++ b/fs/nfsd/nfs4layouts.c
> > > @@ -152,6 +152,18 @@ void nfsd4_setup_layout_type(struct svc_export *ex=
p)
> > >  #endif
> > >  }
> > > =20
> > > +void nfsd4_close_layout(struct nfs4_layout_stateid *ls)
> > > +{
> > > +	struct nfsd_file *fl =3D xchg(&ls->ls_file, NULL);
> > > +
> > > +	if (fl) {
> > > +		if (!nfsd4_layout_ops[ls->ls_layout_type]->disable_recalls)
> > > +			vfs_setlease(fl->nf_file, F_UNLCK, NULL,
> > > +				     (void **)&ls);
> > > +		nfsd_file_put(fl);
> > > +	}
> > > +}
> > > +
> > >  static void
> > >  nfsd4_free_layout_stateid(struct nfs4_stid *stid)
> > >  {
> > > @@ -169,9 +181,7 @@ nfsd4_free_layout_stateid(struct nfs4_stid *stid)
> > >  	list_del_init(&ls->ls_perfile);
> > >  	spin_unlock(&fp->fi_lock);
> > > =20
> > > -	if (!nfsd4_layout_ops[ls->ls_layout_type]->disable_recalls)
> > > -		vfs_setlease(ls->ls_file->nf_file, F_UNLCK, NULL, (void **)&ls);
> > > -	nfsd_file_put(ls->ls_file);
> > > +	nfsd4_close_layout(ls);
> > > =20
> > >  	if (ls->ls_recalled)
> > >  		atomic_dec(&ls->ls_stid.sc_file->fi_lo_recalls);
> > > @@ -605,7 +615,7 @@ nfsd4_return_all_file_layouts(struct nfs4_client *c=
lp, struct nfs4_file *fp)
> > >  }
> > > =20
> > >  static void
> > > -nfsd4_cb_layout_fail(struct nfs4_layout_stateid *ls)
> > > +nfsd4_cb_layout_fail(struct nfs4_layout_stateid *ls, struct nfsd_file =
*file)
> > >  {
> > >  	struct nfs4_client *clp =3D ls->ls_stid.sc_client;
> > >  	char addr_str[INET6_ADDRSTRLEN];
> > > @@ -627,7 +637,7 @@ nfsd4_cb_layout_fail(struct nfs4_layout_stateid *ls)
> > > =20
> > >  	argv[0] =3D (char *)nfsd_recall_failed;
> > >  	argv[1] =3D addr_str;
> > > -	argv[2] =3D ls->ls_file->nf_file->f_path.mnt->mnt_sb->s_id;
> > > +	argv[2] =3D file->nf_file->f_path.mnt->mnt_sb->s_id;
> > >  	argv[3] =3D NULL;
> > > =20
> > >  	error =3D call_usermodehelper(nfsd_recall_failed, argv, envp,
> > > @@ -657,6 +667,7 @@ nfsd4_cb_layout_done(struct nfsd4_callback *cb, str=
uct rpc_task *task)
> > >  	struct nfsd_net *nn;
> > >  	ktime_t now, cutoff;
> > >  	const struct nfsd4_layout_ops *ops;
> > > +	struct nfsd_file *fl;
> > > =20
> > >  	trace_nfsd_cb_layout_done(&ls->ls_stid.sc_stateid, task);
> > >  	switch (task->tk_status) {
> > > @@ -688,12 +699,17 @@ nfsd4_cb_layout_done(struct nfsd4_callback *cb, s=
truct rpc_task *task)
> > >  		 * Unknown error or non-responding client, we'll need to fence.
> > >  		 */
> > >  		trace_nfsd_layout_recall_fail(&ls->ls_stid.sc_stateid);
> > > -
> > > -		ops =3D nfsd4_layout_ops[ls->ls_layout_type];
> > > -		if (ops->fence_client)
> > > -			ops->fence_client(ls);
> > > -		else
> > > -			nfsd4_cb_layout_fail(ls);
> > > +		rcu_read_lock();
> > > +		fl =3D nfsd_file_get(ls->ls_file);
> > > +		rcu_read_unlock();
> > > +		if (fl) {
> > > +			ops =3D nfsd4_layout_ops[ls->ls_layout_type];
> > > +			if (ops->fence_client)
> > > +				ops->fence_client(ls, fl);
> > > +			else
> > > +				nfsd4_cb_layout_fail(ls, fl);
> > > +			nfsd_file_put(fl);
> > > +		}
> > >  		return 1;
> > >  	case -NFS4ERR_NOMATCHING_LAYOUT:
> > >  		trace_nfsd_layout_recall_done(&ls->ls_stid.sc_stateid);
> > > diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
> > > index 3d85c88ec4d7..d82ca209eb96 100644
> > > --- a/fs/nfsd/nfs4state.c
> > > +++ b/fs/nfsd/nfs4state.c
> > > @@ -1712,7 +1712,8 @@ void nfsd4_revoke_states(struct net *net, struct =
super_block *sb)
> > >  	unsigned int idhashval;
> > >  	unsigned int sc_types;
> > > =20
> > > -	sc_types =3D NFS4_OPEN_STID | NFS4_LOCK_STID | NFS4_DELEG_STID;
> > > +	sc_types =3D (NFS4_OPEN_STID | NFS4_LOCK_STID |
> > > +		    NFS4_DELEG_STID | NFS4_LAYOUT_STID);
> > > =20
> > >  	spin_lock(&nn->client_lock);
> > >  	for (idhashval =3D 0; idhashval < CLIENT_HASH_MASK; idhashval++) {
> > > @@ -1725,6 +1726,7 @@ void nfsd4_revoke_states(struct net *net, struct =
super_block *sb)
> > >  			if (stid) {
> > >  				struct nfs4_ol_stateid *stp;
> > >  				struct nfs4_delegation *dp;
> > > +				struct nfs4_layout_stateid *ls;
> > > =20
> > >  				spin_unlock(&nn->client_lock);
> > >  				switch (stid->sc_type) {
> > > @@ -1780,6 +1782,10 @@ void nfsd4_revoke_states(struct net *net, struct=
 super_block *sb)
> > >  					if (dp)
> > >  						revoke_delegation(dp);
> > >  					break;
> > > +				case NFS4_LAYOUT_STID:
> > > +					ls =3D layoutstateid(stid);
> > > +					nfsd4_close_layout(ls);
> > > +					break;
> > >  				}
> > >  				nfs4_put_stid(stid);
> > >  				spin_lock(&nn->client_lock);
> > > @@ -2859,17 +2865,25 @@ static int nfs4_show_layout(struct seq_file *s,=
 struct nfs4_stid *st)
> > >  	struct nfsd_file *file;
> > > =20
> > >  	ls =3D container_of(st, struct nfs4_layout_stateid, ls_stid);
> > > -	file =3D ls->ls_file;
> > > +	rcu_read_lock();
> > > +	file =3D nfsd_file_get(ls->ls_file);
> > > +	rcu_read_unlock();
> > > =20
> > > -	seq_printf(s, "- ");
> > > +	seq_puts(s, "- ");
> > >  	nfs4_show_stateid(s, &st->sc_stateid);
> > > -	seq_printf(s, ": { type: layout, ");
> > > +	seq_puts(s, ": { type: layout");
> > > =20
> > >  	/* XXX: What else would be useful? */
> > > =20
> > > -	nfs4_show_superblock(s, file);
> > > -	seq_printf(s, ", ");
> > > -	nfs4_show_fname(s, file);
> > > +	if (file) {
> > > +		seq_puts(s, ", ");
> > > +		nfs4_show_superblock(s, file);
> > > +		seq_puts(s, ", ");
> > > +		nfs4_show_fname(s, file);
> > > +		nfsd_file_put(file);
> > > +	}
> > > +	if (st->sc_status & NFS4_STID_ADMIN_REVOKED)
> > > +		seq_puts(s, ", admin-revoked");
> > >  	seq_printf(s, " }\n");
> > > =20
> > >  	return 0;
> > > diff --git a/fs/nfsd/pnfs.h b/fs/nfsd/pnfs.h
> > > index de1e0dfed06a..f2777577865e 100644
> > > --- a/fs/nfsd/pnfs.h
> > > +++ b/fs/nfsd/pnfs.h
> > > @@ -37,7 +37,8 @@ struct nfsd4_layout_ops {
> > >  	__be32 (*proc_layoutcommit)(struct inode *inode,
> > >  			struct nfsd4_layoutcommit *lcp);
> > > =20
> > > -	void (*fence_client)(struct nfs4_layout_stateid *ls);
> > > +	void (*fence_client)(struct nfs4_layout_stateid *ls,
> > > +			     struct nfsd_file *file);
> > >  };
> > > =20
> > >  extern const struct nfsd4_layout_ops *nfsd4_layout_ops[];
> > > @@ -72,6 +73,7 @@ void nfsd4_setup_layout_type(struct svc_export *exp);
> > >  void nfsd4_return_all_client_layouts(struct nfs4_client *);
> > >  void nfsd4_return_all_file_layouts(struct nfs4_client *clp,
> > >  		struct nfs4_file *fp);
> > > +void nfsd4_close_layout(struct nfs4_layout_stateid *ls);
> > >  int nfsd4_init_pnfs(void);
> > >  void nfsd4_exit_pnfs(void);
> > >  #else
> > > @@ -89,6 +91,9 @@ static inline void nfsd4_return_all_file_layouts(stru=
ct nfs4_client *clp,
> > >  		struct nfs4_file *fp)
> > >  {
> > >  }
> > > +static inline void nfsd4_close_layout(struct nfs4_layout_stateid *ls)
> > > +{
> > > +}
> > >  static inline void nfsd4_exit_pnfs(void)
> > >  {
> > >  }
> > > --=20
> > > 2.42.1
> > >=20
> >=20
> > --=20
> > Chuck Lever
> >=20
>=20
> --=20
> Chuck Lever
>=20



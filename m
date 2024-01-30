Return-Path: <linux-nfs+bounces-1610-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D466842F9D
	for <lists+linux-nfs@lfdr.de>; Tue, 30 Jan 2024 23:24:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 22714288898
	for <lists+linux-nfs@lfdr.de>; Tue, 30 Jan 2024 22:23:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 539EA7BAF0;
	Tue, 30 Jan 2024 22:23:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tZ5ohxFm"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EBB0125D5
	for <linux-nfs@vger.kernel.org>; Tue, 30 Jan 2024 22:23:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706653425; cv=none; b=ho6yczSOV/4F8qTzX+lY4JkBLAGqqkzX5am87EtCoIOgopVG3ph7YK+OTHFZ5DGixOf+8V5Yr88sI9qKoNsOQZ87xPDP8lwlGvc5t2vtfqjLe79LxrJanUjYTw0c5zvVQjzBKcTPujBrQA2aCJBWd8EIFpxy7VqK8rSIBKarfas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706653425; c=relaxed/simple;
	bh=QAWwTtQGrIeFzswGKlOX5ba07WnF1wa8UqHBM9A8oCM=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=YJvG1f69Yx8obeWQvUs2vJdgc6ykgVQ/sF8W3SQQoFavW2y7Zx+jSv+sDc8kqrziBuDCEpo57Aedk5568EZZ01D7sRC04OGgN1Fqq3Vh4nkyiDaBmvEBOE0AOssTN/sxha9fwTOOoW+I3IsWjVeQPun+8gfk7H5Po/+lIk0FXJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tZ5ohxFm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1345C433F1;
	Tue, 30 Jan 2024 22:23:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706653424;
	bh=QAWwTtQGrIeFzswGKlOX5ba07WnF1wa8UqHBM9A8oCM=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=tZ5ohxFmLKvrgjQYN6Xt+tFL4hB/HJzjOpbInXlif7MHWwtWiEwWl/3Rlbre23o04
	 02H8OLexwejbPyrfnrHXH86pj7av6QAiiGHyhtxYlZnfB0WrB+btvI58HQHuzowrpd
	 fkQmM6NBVf9jlJeal61IBCt+c16jH+FYZJqthzIi3J/tg3PyXgw3ejKVeD9CLZEfSS
	 YNeRY58y7OlxD6NSPZVXoaiLR3bloJ5+uYfoZylxA2eQVomC4aF+f0dQz2KUCA2FJV
	 D7vlv9DjPcIZj6yHCNbKEfw6NCNOJ4AYyP1QRVkaikkc5pFWEkhCHHPsaL06qgsA/k
	 QY26gXJmGOPyA==
Message-ID: <2311c66895788f4cb611996b024642689e561e43.camel@kernel.org>
Subject: Re: [PATCH 13/13] nfsd: allow layout state to be admin-revoked.
From: Jeff Layton <jlayton@kernel.org>
To: NeilBrown <neilb@suse.de>
Cc: Chuck Lever <chuck.lever@oracle.com>, linux-nfs@vger.kernel.org, Olga
 Kornievskaia <kolga@netapp.com>, Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey
 <tom@talpey.com>, Christoph Hellwig <hch@lst.de>, Tom Haynes
 <loghyr@gmail.com>
Date: Tue, 30 Jan 2024 17:23:42 -0500
In-Reply-To: <170665280921.21664.13517860700673336994@noble.neil.brown.name>
References: <20240130011102.8623-1-neilb@suse.de>
	, <20240130011102.8623-14-neilb@suse.de>
	, <a9f76a1fa6362ad92e37c22d28940896d378890a.camel@kernel.org>
	 <170665280921.21664.13517860700673336994@noble.neil.brown.name>
Autocrypt: addr=jlayton@kernel.org; prefer-encrypt=mutual;
 keydata=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
	kZWuOsJdJQdmwlWC5L5ln9xgfr/4mOY38B0U=
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.3 (3.50.3-1.fc39) 
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2024-01-31 at 09:13 +1100, NeilBrown wrote:
> On Tue, 30 Jan 2024, Jeff Layton wrote:
> > On Tue, 2024-01-30 at 12:08 +1100, NeilBrown wrote:
> > > When there is layout state on a filesystem that is being "unlocked" t=
hat
> > > is now revoked, which involves closing the nfsd_file and releasing th=
e
> > > vfs lease.
> > >=20
> > > To avoid races, ->ls_file can now be accessed either:
> > >  - under ->fi_lock for the state's sc_file or
> > >  - under rcu_read_lock() if nfsd_file_get() is used.
> > > To support this, ->fence_client and nfsd4_cb_layout_fail() now take a
> > > second argument being the nfsd_file.
> > >=20
> > > Signed-off-by: NeilBrown <neilb@suse.de>
> > > ---
> > >  fs/nfsd/blocklayout.c |  4 ++--
> > >  fs/nfsd/nfs4layouts.c | 43 ++++++++++++++++++++++++++++++++---------=
--
> > >  fs/nfsd/nfs4state.c   | 11 +++++++++--
> > >  fs/nfsd/pnfs.h        |  8 +++++++-
> > >  4 files changed, 50 insertions(+), 16 deletions(-)
> > >=20
> > > diff --git a/fs/nfsd/blocklayout.c b/fs/nfsd/blocklayout.c
> > > index 46fd74d91ea9..3c040c81c77d 100644
> > > --- a/fs/nfsd/blocklayout.c
> > > +++ b/fs/nfsd/blocklayout.c
> > > @@ -328,10 +328,10 @@ nfsd4_scsi_proc_layoutcommit(struct inode *inod=
e,
> > >  }
> > > =20
> > >  static void
> > > -nfsd4_scsi_fence_client(struct nfs4_layout_stateid *ls)
> > > +nfsd4_scsi_fence_client(struct nfs4_layout_stateid *ls, struct nfsd_=
file *file)
> > >  {
> > >  	struct nfs4_client *clp =3D ls->ls_stid.sc_client;
> > > -	struct block_device *bdev =3D ls->ls_file->nf_file->f_path.mnt->mnt=
_sb->s_bdev;
> > > +	struct block_device *bdev =3D file->nf_file->f_path.mnt->mnt_sb->s_=
bdev;
> > > =20
> > >  	bdev->bd_disk->fops->pr_ops->pr_preempt(bdev, NFSD_MDS_PR_KEY,
> > >  			nfsd4_scsi_pr_key(clp), 0, true);
> > > diff --git a/fs/nfsd/nfs4layouts.c b/fs/nfsd/nfs4layouts.c
> > > index 857b822450b4..1cfd61db2472 100644
> > > --- a/fs/nfsd/nfs4layouts.c
> > > +++ b/fs/nfsd/nfs4layouts.c
> > > @@ -152,6 +152,23 @@ void nfsd4_setup_layout_type(struct svc_export *=
exp)
> > >  #endif
> > >  }
> > > =20
> > > +void nfsd4_close_layout(struct nfs4_layout_stateid *ls)
> > > +{
> > > +	struct nfsd_file *fl;
> > > +
> > > +	spin_lock(&ls->ls_stid.sc_file->fi_lock);
> > > +	fl =3D ls->ls_file;
> > > +	ls->ls_file =3D NULL;
> > > +	spin_unlock(&ls->ls_stid.sc_file->fi_lock);
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
> > > @@ -169,9 +186,7 @@ nfsd4_free_layout_stateid(struct nfs4_stid *stid)
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
> > > @@ -605,7 +620,7 @@ nfsd4_return_all_file_layouts(struct nfs4_client =
*clp, struct nfs4_file *fp)
> > >  }
> > > =20
> > >  static void
> > > -nfsd4_cb_layout_fail(struct nfs4_layout_stateid *ls)
> > > +nfsd4_cb_layout_fail(struct nfs4_layout_stateid *ls, struct nfsd_fil=
e *file)
> > >  {
> > >  	struct nfs4_client *clp =3D ls->ls_stid.sc_client;
> > >  	char addr_str[INET6_ADDRSTRLEN];
> > > @@ -627,7 +642,7 @@ nfsd4_cb_layout_fail(struct nfs4_layout_stateid *=
ls)
> > > =20
> > >  	argv[0] =3D (char *)nfsd_recall_failed;
> > >  	argv[1] =3D addr_str;
> > > -	argv[2] =3D ls->ls_file->nf_file->f_path.mnt->mnt_sb->s_id;
> > > +	argv[2] =3D file->nf_file->f_path.mnt->mnt_sb->s_id;
> > >  	argv[3] =3D NULL;
> > > =20
> > >  	error =3D call_usermodehelper(nfsd_recall_failed, argv, envp,
> > > @@ -657,6 +672,7 @@ nfsd4_cb_layout_done(struct nfsd4_callback *cb, s=
truct rpc_task *task)
> > >  	struct nfsd_net *nn;
> > >  	ktime_t now, cutoff;
> > >  	const struct nfsd4_layout_ops *ops;
> > > +	struct nfsd_file *fl;
> > > =20
> > >  	trace_nfsd_cb_layout_done(&ls->ls_stid.sc_stateid, task);
> > >  	switch (task->tk_status) {
> > > @@ -688,12 +704,17 @@ nfsd4_cb_layout_done(struct nfsd4_callback *cb,=
 struct rpc_task *task)
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
> >=20
> > I'm still wondering about the rcu_read_lock above. It's probably
> > harmless, but it seems unnecessary since you already hold a reference t=
o
> > "ls". Is there a reason for it?
>=20
> I replied !
>=20
> https://lore.kernel.org/linux-nfs/170657686307.21664.13889535187781187364=
@noble.neil.brown.name/
>=20
> See nfsd4_close_layout().  A ref on ls doesn't guarantee a ref on
> ls->ls_file any more.
>=20
>=20

Hmmm... I never received that reply.

The answer makes sense though, thanks. You can add my Reviewed-by to
13/13 as well.

Cheers,

> >=20
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
> > > index fe21af8dfc68..a66d66b9f769 100644
> > > --- a/fs/nfsd/nfs4state.c
> > > +++ b/fs/nfsd/nfs4state.c
> > > @@ -1721,7 +1721,7 @@ void nfsd4_revoke_states(struct net *net, struc=
t super_block *sb)
> > >  	unsigned int idhashval;
> > >  	unsigned int sc_types;
> > > =20
> > > -	sc_types =3D SC_TYPE_OPEN | SC_TYPE_LOCK | SC_TYPE_DELEG;
> > > +	sc_types =3D SC_TYPE_OPEN | SC_TYPE_LOCK | SC_TYPE_DELEG | SC_TYPE_=
LAYOUT;
> > > =20
> > >  	spin_lock(&nn->client_lock);
> > >  	for (idhashval =3D 0; idhashval < CLIENT_HASH_MASK; idhashval++) {
> > > @@ -1734,6 +1734,7 @@ void nfsd4_revoke_states(struct net *net, struc=
t super_block *sb)
> > >  			if (stid) {
> > >  				struct nfs4_ol_stateid *stp;
> > >  				struct nfs4_delegation *dp;
> > > +				struct nfs4_layout_stateid *ls;
> > > =20
> > >  				spin_unlock(&nn->client_lock);
> > >  				switch (stid->sc_type) {
> > > @@ -1789,6 +1790,10 @@ void nfsd4_revoke_states(struct net *net, stru=
ct super_block *sb)
> > >  					if (dp)
> > >  						revoke_delegation(dp);
> > >  					break;
> > > +				case SC_TYPE_LAYOUT:
> > > +					ls =3D layoutstateid(stid);
> > > +					nfsd4_close_layout(ls);
> > > +					break;
> > >  				}
> > >  				nfs4_put_stid(stid);
> > >  				spin_lock(&nn->client_lock);
> > > @@ -2868,7 +2873,6 @@ static int nfs4_show_layout(struct seq_file *s,=
 struct nfs4_stid *st)
> > >  	struct nfsd_file *file;
> > > =20
> > >  	ls =3D container_of(st, struct nfs4_layout_stateid, ls_stid);
> > > -	file =3D ls->ls_file;
> > > =20
> > >  	seq_puts(s, "- ");
> > >  	nfs4_show_stateid(s, &st->sc_stateid);
> > > @@ -2876,12 +2880,15 @@ static int nfs4_show_layout(struct seq_file *=
s, struct nfs4_stid *st)
> > > =20
> > >  	/* XXX: What else would be useful? */
> > > =20
> > > +	spin_lock(&ls->ls_stid.sc_file->fi_lock);
> > > +	file =3D ls->ls_file;
> > >  	if (file) {
> > >  		seq_puts(s, ", ");
> > >  		nfs4_show_superblock(s, file);
> > >  		seq_puts(s, ", ");
> > >  		nfs4_show_fname(s, file);
> > >  	}
> > > +	spin_unlock(&ls->ls_stid.sc_file->fi_lock);
> > >  	if (st->sc_status & SC_STATUS_ADMIN_REVOKED)
> > >  		seq_puts(s, ", admin-revoked");
> > >  	seq_puts(s, " }\n");
> > > diff --git a/fs/nfsd/pnfs.h b/fs/nfsd/pnfs.h
> > > index de1e0dfed06a..925817f66917 100644
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
> > > @@ -72,11 +73,13 @@ void nfsd4_setup_layout_type(struct svc_export *e=
xp);
> > >  void nfsd4_return_all_client_layouts(struct nfs4_client *);
> > >  void nfsd4_return_all_file_layouts(struct nfs4_client *clp,
> > >  		struct nfs4_file *fp);
> > > +void nfsd4_close_layout(struct nfs4_layout_stateid *ls);
> > >  int nfsd4_init_pnfs(void);
> > >  void nfsd4_exit_pnfs(void);
> > >  #else
> > >  struct nfs4_client;
> > >  struct nfs4_file;
> > > +struct nfs4_layout_stateid;
> > > =20
> > >  static inline void nfsd4_setup_layout_type(struct svc_export *exp)
> > >  {
> > > @@ -89,6 +92,9 @@ static inline void nfsd4_return_all_file_layouts(st=
ruct nfs4_client *clp,
> > >  		struct nfs4_file *fp)
> > >  {
> > >  }
> > > +static inline void nfsd4_close_layout(struct nfs4_layout_stateid *ls=
)
> > > +{
> > > +}
> > >  static inline void nfsd4_exit_pnfs(void)
> > >  {
> > >  }
> >=20
> > --=20
> > Jeff Layton <jlayton@kernel.org>
> >=20
> >=20
>=20

--=20
Jeff Layton <jlayton@kernel.org>


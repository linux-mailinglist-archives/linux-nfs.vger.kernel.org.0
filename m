Return-Path: <linux-nfs+bounces-20257-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OLG0L0O8ummqbQIAu9opvQ
	(envelope-from <linux-nfs+bounces-20257-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Wed, 18 Mar 2026 15:52:51 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FE522BD8E3
	for <lists+linux-nfs@lfdr.de>; Wed, 18 Mar 2026 15:52:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id BB0A33071575
	for <lists+linux-nfs@lfdr.de>; Wed, 18 Mar 2026 14:49:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 992433DFC61;
	Wed, 18 Mar 2026 14:47:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fiaSkfQJ"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E901A3DEAD8;
	Wed, 18 Mar 2026 14:47:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773845272; cv=none; b=b0Aw1Ac4/0NRaissDWzw1yWWpiSzd/iywS/1YDPvt+uWmnJOEqR0/bBEhV/yKngwOHrl18X+zYErxX8FVinNdwOCdvAcQyoSuMu8yWEpxOBVtZQUQatfyZ0HfYcRt3DBOau5KyLv+8sMgeo3F0bjTHWUnqA22u8oiOaTHI5k6dI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773845272; c=relaxed/simple;
	bh=74Q4VHckHSAUOxHvsfxndvn8kMRop3KAJb9kRj+AMlk=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=iWnJcGtIKm78J6C1XLC02tfyCWhYZpgRF+tUcpbcmzjulRvOR8K6Dh4pX4bmv5NV0qnVuhSYRg4gBlDEtC5YFtYOMAhPDENLYS6XC28WDLBtUdh7s0gnDH4/xi5JfQTfF3tA8eV/7TRC8Hf2MNfB/6fDsM+BnM0ldbDM7k9nwHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fiaSkfQJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C544C19421;
	Wed, 18 Mar 2026 14:47:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773845271;
	bh=74Q4VHckHSAUOxHvsfxndvn8kMRop3KAJb9kRj+AMlk=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=fiaSkfQJSzdewPoobEPuNeM98sjgiXdkTUMhULWKPO2vPi2zTQWYprKXVgpIhnoLi
	 tazObmAw1cFXxdt9teN2MNzZWBK1KjTsZVDTLT7IrqOP4l1NU9e1jA5JJLsDuocpcE
	 Inh0jEzb6LCE43xk1JTRrbqG6hEEcpcvEN/xkQx8s0EBDaOxdIptqA+yyQKMqNPYuL
	 dR4dVeHe6s23DUoA0pjmUDi/Q0NHMagALhnkdKp4YsX8F2iq3X7dbyNGk/RGIaw2nm
	 VQD/cOGMGVgsEw7qJtAXdbn3qrLjYEsbjh/taOqtoqHsSIIBbk4INQhc7ZszN2BTni
	 boKR9MnvynC5g==
Message-ID: <f582806fcf3c6d6f7416c24c55462fc502cb0ab0.camel@kernel.org>
Subject: Re: [PATCH v4 5/6] NFSD: Add export-scoped state revocation
From: Jeff Layton <jlayton@kernel.org>
To: Chuck Lever <cel@kernel.org>, NeilBrown <neil@brown.name>, Olga
 Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, Tom
 Talpey <tom@talpey.com>
Cc: linux-nfs@vger.kernel.org, linux-fsdevel@vger.kernel.org, Chuck Lever
	 <chuck.lever@oracle.com>
Date: Wed, 18 Mar 2026 10:47:48 -0400
In-Reply-To: <20260318-umount-kills-nfsv4-state-v4-5-56aad44ab982@oracle.com>
References: <20260318-umount-kills-nfsv4-state-v4-0-56aad44ab982@oracle.com>
	 <20260318-umount-kills-nfsv4-state-v4-5-56aad44ab982@oracle.com>
Autocrypt: addr=jlayton@kernel.org; prefer-encrypt=mutual;
 keydata=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
 QZIQXVeAA+smfTT0tDrisj1U5x6ZB9b3nBg65kc=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43) 
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-20257-lists,linux-nfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jlayton@kernel.org,linux-nfs@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,oracle.com:email]
X-Rspamd-Queue-Id: 5FE522BD8E3
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, 2026-03-18 at 10:15 -0400, Chuck Lever wrote:
> From: Chuck Lever <chuck.lever@oracle.com>
>=20
> nfsd4_revoke_states() revokes all NFSv4 state on an entire
> superblock, which is too coarse when multiple exports share a
> filesystem. Add nfsd4_revoke_export_states() to revoke only
> state associated with files under a specific export root, then
> convert nfsd4_revoke_states() to a thin wrapper that passes
> sb->s_root.
>=20
> nfsd4_revoke_export_states() uses find_next_sb_stid() to locate
> candidate stids, then verifies each against the export root via
> nfsd_file_inode_is_in_subtree(). That helper is placed in the
> file cache layer (filecache.c) because it operates on VFS types
> with no NFSv4 state dependency. It walks all of an inode's
> dentry aliases rather than calling d_find_any_alias(), because
> for hard-linked files an arbitrary alias may fall outside the
> export subtree even when another alias is inside it.
>=20
> When the export root is the filesystem root, the subtree check
> is elided and every stid matching the superblock is revoked
> directly.
>=20
> The NFSD_UNLOCK_TYPE_FILESYSTEM handler now calls
> nfsd4_revoke_export_states() with the resolved path dentry,
> enabling subtree-scoped revocation through the netlink
> interface.
>=20
> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
> ---
>  fs/nfsd/filecache.c | 32 +++++++++++++++++++
>  fs/nfsd/filecache.h |  1 +
>  fs/nfsd/nfs4state.c | 92 +++++++++++++++++++++++++++++++++++++----------=
------
>  fs/nfsd/nfsctl.c    |  3 +-
>  fs/nfsd/state.h     |  7 ++++
>  5 files changed, 107 insertions(+), 28 deletions(-)
>=20
> diff --git a/fs/nfsd/filecache.c b/fs/nfsd/filecache.c
> index 1e2b38ed1d35..cd09be0c5465 100644
> --- a/fs/nfsd/filecache.c
> +++ b/fs/nfsd/filecache.c
> @@ -894,6 +894,38 @@ __nfsd_file_cache_purge(struct net *net)
>  	nfsd_file_dispose_list(&dispose);
>  }
> =20
> +/**
> + * nfsd_file_inode_is_in_subtree - check whether an inode is under a sub=
tree
> + * @inode:        inode to test
> + * @root_dentry:  dentry of the subtree root
> + *
> + * Check whether @inode has any dentry alias that falls within the
> + * subtree rooted at @root_dentry.  Hard-linked files can have aliases
> + * in multiple directories, so all aliases must be tested.
> + *
> + * Return: %true if any dentry alias of @inode is at or below
> + * @root_dentry, %false otherwise.
> + */
> +bool nfsd_file_inode_is_in_subtree(struct inode *inode,
> +				   struct dentry *root_dentry)
> +{
> +	struct dentry *alias;
> +	bool found =3D false;
> +
> +	/* i_lock stabilizes the alias list; is_subdir() nests
> +	 * rename_lock (a seqlock) beneath it but does not sleep.
> +	 */
> +	spin_lock(&inode->i_lock);
> +	hlist_for_each_entry(alias, &inode->i_dentry, d_u.d_alias) {
> +		if (is_subdir(alias, root_dentry)) {
> +			found =3D true;
> +			break;
> +		}
> +	}
> +	spin_unlock(&inode->i_lock);
> +	return found;
> +}
> +
>  static struct nfsd_fcache_disposal *
>  nfsd_alloc_fcache_disposal(void)
>  {
> diff --git a/fs/nfsd/filecache.h b/fs/nfsd/filecache.h
> index b383dbc5b921..36c9a8e388d2 100644
> --- a/fs/nfsd/filecache.h
> +++ b/fs/nfsd/filecache.h
> @@ -70,6 +70,7 @@ struct net *nfsd_file_put_local(struct nfsd_file __rcu =
**nf);
>  struct nfsd_file *nfsd_file_get(struct nfsd_file *nf);
>  struct file *nfsd_file_file(struct nfsd_file *nf);
>  void nfsd_file_close_inode_sync(struct inode *inode);
> +bool nfsd_file_inode_is_in_subtree(struct inode *inode, struct dentry *r=
oot_dentry);
>  void nfsd_file_net_dispose(struct nfsd_net *nn);
>  bool nfsd_file_is_cached(struct inode *inode);
>  __be32 nfsd_file_acquire_gc(struct svc_rqst *rqstp, struct svc_fh *fhp,
> diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
> index 891669b32804..581f38395c42 100644
> --- a/fs/nfsd/nfs4state.c
> +++ b/fs/nfsd/nfs4state.c
> @@ -1763,15 +1763,6 @@ static struct nfs4_stid *find_next_sb_stid(struct =
nfs4_client *clp,
>  	return stid;
>  }
> =20
> -static struct nfs4_stid *find_one_sb_stid(struct nfs4_client *clp,
> -					  struct super_block *sb,
> -					  unsigned int sc_types)
> -{
> -	unsigned long id =3D 0;
> -
> -	return find_next_sb_stid(clp, sb, sc_types, &id);
> -}
> -
>  static void revoke_ol_stid(struct nfs4_client *clp,
>  			   struct nfs4_ol_stateid *stp)
>  {
> @@ -1835,20 +1826,19 @@ static void revoke_one_stid(struct nfs4_client *c=
lp, struct nfs4_stid *stid)
>  }
> =20
>  /**
> - * nfsd4_revoke_states - revoke all nfsv4 states associated with given f=
ilesystem
> - * @nn:   used to identify instance of nfsd (there is one per net namesp=
ace)
> - * @sb:   super_block used to identify target filesystem
> + * nfsd4_revoke_export_states - revoke states associated with a given ex=
port
> + * @nn:           nfsd_net identifying the nfsd instance (one per net na=
mespace)
> + * @sb:           super_block of the export's filesystem
> + * @root_dentry:  dentry of the export root directory
>   *
>   * All nfs4 states (open, lock, delegation, layout) held by the server i=
nstance
> - * and associated with a file on the given filesystem will be revoked re=
sulting
> - * in any files being closed and so all references from nfsd to the file=
system
> - * being released.  Thus nfsd will no longer prevent the filesystem from=
 being
> - * unmounted.
> - *
> - * The clients which own the states will subsequently being notified tha=
t the
> - * states have been "admin-revoked".
> + * and associated with files under the given export will be revoked.  Wh=
en
> + * @root_dentry is the filesystem root, all state on @sb is revoked (equ=
ivalent
> + * to nfsd4_revoke_states).  When @root_dentry is a subdirectory, only s=
tate on
> + * files within that subtree is revoked.
>   */
> -void nfsd4_revoke_states(struct nfsd_net *nn, struct super_block *sb)
> +void nfsd4_revoke_export_states(struct nfsd_net *nn, struct super_block =
*sb,
> +				struct dentry *root_dentry)
>  {
>  	unsigned int idhashval;
>  	unsigned int sc_types;
> @@ -1861,18 +1851,53 @@ void nfsd4_revoke_states(struct nfsd_net *nn, str=
uct super_block *sb)
>  		struct nfs4_client *clp;
>  	retry:
>  		list_for_each_entry(clp, head, cl_idhash) {
> -			struct nfs4_stid *stid =3D find_one_sb_stid(clp, sb,
> -								  sc_types);
> -			if (stid) {
> -				spin_unlock(&nn->client_lock);
> +			struct nfs4_stid *stid;
> +			/* Resets to zero on each retry; revocation may
> +			 * alter the IDR, so a stale cursor is unsafe.
> +			 */
> +			unsigned long id =3D 0;
> +
> +			while ((stid =3D find_next_sb_stid(clp, sb,
> +						sc_types, &id)) !=3D NULL) {
> +				if (root_dentry !=3D sb->s_root) {
> +					bool match;
> +
> +					/* Bare inc to pin clp; get_client_locked() is
> +					 * not used because its courtesy-to-active
> +					 * transition is unwanted during revocation.
> +					 */
> +					atomic_inc(&clp->cl_rpc_users);
> +					spin_unlock(&nn->client_lock);
> +					match =3D nfsd_file_inode_is_in_subtree(
> +							stid->sc_file->fi_inode,
> +							root_dentry);

Ouch the hardlinked thing makes this hard to reason about.

Ok, so suppose we have two exports on the same superblock.

/export/foo
/export/bar

One is exported to one client foo and one to another to client bar.
There is a file hardlinked across those directories:

$ touch /export/foo/baz
$ ln /export/bar/baz /export/foo/baz

Now, client foo opens /export/foo/baz, and client bar opens
/export/bar/baz.

/export/bar is unexported and state under it revoked. Won't client
foo's state end up being revoked too in that case?

Note that the different hardlinks should end up with different
filehandles since they are exposed to the clients via different
exports.

I wonder... do we need keep track of the export under which a stateid
was acquired so we can properly revoke the right ones in this
situation?

> +					if (!match) {
> +						nfs4_put_stid(stid);
> +						spin_lock(&nn->client_lock);
> +						put_client_renew_locked(clp);
> +						id++;
> +						continue;
> +					}
> +				} else {
> +					/* Whole-sb: goto retry restarts the
> +					 * client list immediately after
> +					 * revocation, so clp needs no pin.
> +					 */
> +					spin_unlock(&nn->client_lock);
> +				}
> +
>  				revoke_one_stid(clp, stid);
>  				nfs4_put_stid(stid);
>  				spin_lock(&nn->client_lock);
> +				if (root_dentry !=3D sb->s_root)
> +					put_client_renew_locked(clp);
>  				if (clp->cl_minorversion =3D=3D 0)
>  					/* Allow cleanup after a lease period.
> -					 * store_release ensures cleanup will
> -					 * see any newly revoked states if it
> -					 * sees the time updated.
> +					 * The lock/unlock pair orders this
> +					 * store after revoke_one_stid(), so
> +					 * nfs40_clean_admin_revoked() sees
> +					 * newly revoked states if it sees
> +					 * the updated time.
>  					 */
>  					nn->nfs40_last_revoke =3D
>  						ktime_get_boottime_seconds();
> @@ -1883,6 +1908,19 @@ void nfsd4_revoke_states(struct nfsd_net *nn, stru=
ct super_block *sb)
>  	spin_unlock(&nn->client_lock);
>  }
> =20
> +/**
> + * nfsd4_revoke_states - revoke all nfsv4 states associated with given f=
ilesystem
> + * @nn:   nfsd_net identifying the nfsd instance
> + * @sb:   super_block used to identify target filesystem
> + *
> + * Convenience wrapper around nfsd4_revoke_export_states() that revokes
> + * all state on @sb by passing sb->s_root as the export root.
> + */
> +void nfsd4_revoke_states(struct nfsd_net *nn, struct super_block *sb)
> +{
> +	nfsd4_revoke_export_states(nn, sb, sb->s_root);
> +}
> +
>  static inline int
>  hash_sessionid(struct nfs4_sessionid *sessionid)
>  {
> diff --git a/fs/nfsd/nfsctl.c b/fs/nfsd/nfsctl.c
> index d3ed343699bd..d9c61c939059 100644
> --- a/fs/nfsd/nfsctl.c
> +++ b/fs/nfsd/nfsctl.c
> @@ -2207,7 +2207,8 @@ static int nfsd_nl_unlock_by_filesystem(struct genl=
_info *info)
> =20
>  	mutex_lock(&nfsd_mutex);
>  	if (nn->nfsd_serv)
> -		nfsd4_revoke_states(nn, path.dentry->d_sb);
> +		nfsd4_revoke_export_states(nn, path.dentry->d_sb,
> +					   path.dentry);
>  	else
>  		error =3D -EINVAL;
>  	mutex_unlock(&nfsd_mutex);
> diff --git a/fs/nfsd/state.h b/fs/nfsd/state.h
> index 6fcbf1e427d4..9e7c7884831c 100644
> --- a/fs/nfsd/state.h
> +++ b/fs/nfsd/state.h
> @@ -843,11 +843,18 @@ struct nfsd_file *find_any_file(struct nfs4_file *f=
);
> =20
>  #ifdef CONFIG_NFSD_V4
>  void nfsd4_revoke_states(struct nfsd_net *nn, struct super_block *sb);
> +void nfsd4_revoke_export_states(struct nfsd_net *nn, struct super_block =
*sb,
> +				struct dentry *root_dentry);
>  void nfsd4_cancel_copy_by_sb(struct net *net, struct super_block *sb);
>  #else
>  static inline void nfsd4_revoke_states(struct nfsd_net *nn, struct super=
_block *sb)
>  {
>  }
> +static inline void nfsd4_revoke_export_states(struct nfsd_net *nn,
> +					      struct super_block *sb,
> +					      struct dentry *root_dentry)
> +{
> +}
>  static inline void nfsd4_cancel_copy_by_sb(struct net *net, struct super=
_block *sb)
>  {
>  }

--=20
Jeff Layton <jlayton@kernel.org>


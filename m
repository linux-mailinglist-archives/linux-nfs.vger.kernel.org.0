Return-Path: <linux-nfs+bounces-1537-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BB018404DC
	for <lists+linux-nfs@lfdr.de>; Mon, 29 Jan 2024 13:22:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 411931C20CB8
	for <lists+linux-nfs@lfdr.de>; Mon, 29 Jan 2024 12:22:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C791D604BB;
	Mon, 29 Jan 2024 12:22:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RjvKYqWP"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A303F604AA
	for <linux-nfs@vger.kernel.org>; Mon, 29 Jan 2024 12:22:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706530957; cv=none; b=tqbImkHLarDWs4gT5GGoqexIb38wG2h4a0zlecCNuk4UI4kN7zMkiSTDU1zZrq5kz2E3zpWe2ugcIHQjfqMuqrDhkekNghHQopQG5HHo7vAvej8hSTMf1kweIncNlaB6QU+gVpWEFqmjEuMMBFVLd2qcHx/IJxKERGvxLR2+uxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706530957; c=relaxed/simple;
	bh=+ZlH8FyhRd8ktSsLGB5sxsDFUjm30iB9xmfmJi5+cSg=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ZWGEKQtgwoo9VB43UvWmqEGcShSZ2Ea7gRUG5PC1jyx9hYF+o8Ojm+CthynJCxupBMKNp0g0GWB4QfJKxJxCUazoRYKhOTpVllWe1C3k+z4b7Idp1d8QIQ6Mb1Icx+JSGrBaej1A8ge+8GkB35HkNbCzwAEI0rbsP5g8h6+pSCQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RjvKYqWP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 641E7C433F1;
	Mon, 29 Jan 2024 12:22:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706530957;
	bh=+ZlH8FyhRd8ktSsLGB5sxsDFUjm30iB9xmfmJi5+cSg=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=RjvKYqWPXtCVZ4S6UXMz9szp/4ZuxOcaXdcT+re0TTl8ZTKfIm4felXm44hKZ9pT9
	 PqOa9u+zrJcI207yQRxhR6isOpPaT6qIQS+hOZ5YdxMJHWU8tOjPk4Nxq3cpTg+JX1
	 Irq8DzjSbbVRIKvLYm7dEWdMjY+0+J37vm52wyqBGFV+sS5NbMlWpl/Q8aUNmWemNa
	 hc2DvRcQA8xC1NSISxmN1o0h5bTTr9i0oG7l60ZPcy9rFy7S+2moGYH9ma2U404d/S
	 0VMOM6XAJNNXd3DbuT65xomyBioQRT7l/oXrbLA6RICkj9z4XGhc4a7nwh+r9WZZJ+
	 GPYZ2bVXRq3qw==
Message-ID: <22191c08a554d7570bd389e66a356dfe0e58b528.camel@kernel.org>
Subject: Re: [PATCH 06/13] nfsd: prepare for supporting admin-revocation of
 state
From: Jeff Layton <jlayton@kernel.org>
To: NeilBrown <neilb@suse.de>, Chuck Lever <chuck.lever@oracle.com>
Cc: linux-nfs@vger.kernel.org, Olga Kornievskaia <kolga@netapp.com>, Dai Ngo
 <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>, Christoph Hellwig
 <hch@lst.de>,  Tom Haynes <loghyr@gmail.com>
Date: Mon, 29 Jan 2024 07:22:35 -0500
In-Reply-To: <20240129033637.2133-7-neilb@suse.de>
References: <20240129033637.2133-1-neilb@suse.de>
	 <20240129033637.2133-7-neilb@suse.de>
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

On Mon, 2024-01-29 at 14:29 +1100, NeilBrown wrote:
> The NFSv4 protocol allows state to be revoked by the admin and has error
> codes which allow this to be communicated to the client.
>=20
> This patch
>  - introduces a new state-id status SC_STATUS_ADMIN_REVOKED
>    which can be set on open, lock, or delegation state.
>  - reports NFS4ERR_ADMIN_REVOKED when these are accessed
>  - introduces a per-client counter of these states and returns
>    SEQ4_STATUS_ADMIN_STATE_REVOKED when the counter is not zero.
>    Decrements this when freeing any admin-revoked state.
>  - introduces stub code to find all interesting states for a given
>    superblock so they can be revoked via the 'unlock_filesystem'
>    file in /proc/fs/nfsd/
>    No actual states are handled yet.
>=20
> Signed-off-by: NeilBrown <neilb@suse.de>
> ---
>  fs/nfsd/nfs4state.c | 85 ++++++++++++++++++++++++++++++++++++++++++++-
>  fs/nfsd/nfsctl.c    |  1 +
>  fs/nfsd/nfsd.h      |  1 +
>  fs/nfsd/state.h     | 10 ++++++
>  fs/nfsd/trace.h     |  3 +-
>  5 files changed, 98 insertions(+), 2 deletions(-)
>=20
> diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
> index 6bccdd0af814..8db224906864 100644
> --- a/fs/nfsd/nfs4state.c
> +++ b/fs/nfsd/nfs4state.c
> @@ -1210,6 +1210,8 @@ nfs4_put_stid(struct nfs4_stid *s)
>  		return;
>  	}
>  	idr_remove(&clp->cl_stateids, s->sc_stateid.si_opaque.so_id);
> +	if (s->sc_status & SC_STATUS_ADMIN_REVOKED)
> +		atomic_dec(&s->sc_client->cl_admin_revoked);
>  	nfs4_free_cpntf_statelist(clp->net, s);
>  	spin_unlock(&clp->cl_lock);
>  	s->sc_free(s);
> @@ -1529,6 +1531,8 @@ static void put_ol_stateid_locked(struct nfs4_ol_st=
ateid *stp,
>  	}
> =20
>  	idr_remove(&clp->cl_stateids, s->sc_stateid.si_opaque.so_id);
> +	if (s->sc_status & SC_STATUS_ADMIN_REVOKED)
> +		atomic_dec(&s->sc_client->cl_admin_revoked);
>  	list_add(&stp->st_locks, reaplist);
>  }
> =20
> @@ -1674,6 +1678,68 @@ static void release_openowner(struct nfs4_openowne=
r *oo)
>  	nfs4_put_stateowner(&oo->oo_owner);
>  }
> =20
> +static struct nfs4_stid *find_one_sb_stid(struct nfs4_client *clp,
> +					  struct super_block *sb,
> +					  unsigned int sc_types)
> +{
> +	unsigned long id, tmp;
> +	struct nfs4_stid *stid;
> +
> +	spin_lock(&clp->cl_lock);
> +	idr_for_each_entry_ul(&clp->cl_stateids, stid, tmp, id)
> +		if ((stid->sc_type & sc_types) &&
> +		    stid->sc_status =3D=3D 0 &&
> +		    stid->sc_file->fi_inode->i_sb =3D=3D sb) {
> +			refcount_inc(&stid->sc_count);
> +			break;
> +		}
> +	spin_unlock(&clp->cl_lock);
> +	return stid;
> +}
> +
> +/**
> + * nfsd4_revoke_states - revoke all nfsv4 states associated with given f=
ilesystem
> + * @net - used to identify instance of nfsd (there is one per net namesp=
ace)
> + * @sb - super_block used to identify target filesystem
> + *
> + * All nfs4 states (open, lock, delegation, layout) held by the server i=
nstance
> + * and associated with a file on the given filesystem will be revoked re=
sulting
> + * in any files being closed and so all references from nfsd to the file=
system
> + * being released.  Thus nfsd will no longer prevent the filesystem from=
 being
> + * unmounted.
> + *
> + * The clients which own the states will subsequently being notified tha=
t the
> + * states have been "admin-revoked".
> + */
> +void nfsd4_revoke_states(struct net *net, struct super_block *sb)
> +{
> +	struct nfsd_net *nn =3D net_generic(net, nfsd_net_id);
> +	unsigned int idhashval;
> +	unsigned int sc_types;
> +
> +	sc_types =3D 0;
> +
> +	spin_lock(&nn->client_lock);
> +	for (idhashval =3D 0; idhashval < CLIENT_HASH_MASK; idhashval++) {
> +		struct list_head *head =3D &nn->conf_id_hashtbl[idhashval];
> +		struct nfs4_client *clp;
> +	retry:
> +		list_for_each_entry(clp, head, cl_idhash) {
> +			struct nfs4_stid *stid =3D find_one_sb_stid(clp, sb,
> +								  sc_types);
> +			if (stid) {
> +				spin_unlock(&nn->client_lock);
> +				switch (stid->sc_type) {
> +				}
> +				nfs4_put_stid(stid);
> +				spin_lock(&nn->client_lock);
> +				goto retry;
> +			}
> +		}
> +	}
> +	spin_unlock(&nn->client_lock);
> +}
> +
>  static inline int
>  hash_sessionid(struct nfs4_sessionid *sessionid)
>  {
> @@ -2545,6 +2611,8 @@ static int client_info_show(struct seq_file *m, voi=
d *v)
>  	}
>  	seq_printf(m, "callback state: %s\n", cb_state2str(clp->cl_cb_state));
>  	seq_printf(m, "callback address: %pISpc\n", &clp->cl_cb_conn.cb_addr);
> +	seq_printf(m, "admin-revoked states: %d\n",
> +		   atomic_read(&clp->cl_admin_revoked));
>  	drop_client(clp);
> =20
>  	return 0;
> @@ -4058,6 +4126,8 @@ nfsd4_sequence(struct svc_rqst *rqstp, struct nfsd4=
_compound_state *cstate,
>  	}
>  	if (!list_empty(&clp->cl_revoked))
>  		seq->status_flags |=3D SEQ4_STATUS_RECALLABLE_STATE_REVOKED;
> +	if (atomic_read(&clp->cl_admin_revoked))
> +		seq->status_flags |=3D SEQ4_STATUS_ADMIN_STATE_REVOKED;
>  out_no_session:
>  	if (conn)
>  		free_conn(conn);
> @@ -4546,7 +4616,9 @@ nfsd4_verify_open_stid(struct nfs4_stid *s)
>  {
>  	__be32 ret =3D nfs_ok;
> =20
> -	if (s->sc_status & SC_STATUS_REVOKED)
> +	if (s->sc_status & SC_STATUS_ADMIN_REVOKED)
> +		ret =3D nfserr_admin_revoked;
> +	else if (s->sc_status & SC_STATUS_REVOKED)
>  		ret =3D nfserr_deleg_revoked;
>  	else if (s->sc_status & SC_STATUS_CLOSED)
>  		ret =3D nfserr_bad_stateid;
> @@ -5137,6 +5209,11 @@ nfs4_check_deleg(struct nfs4_client *cl, struct nf=
sd4_open *open,
>  	deleg =3D find_deleg_stateid(cl, &open->op_delegate_stateid);
>  	if (deleg =3D=3D NULL)
>  		goto out;
> +	if (deleg->dl_stid.sc_status & SC_STATUS_ADMIN_REVOKED) {
> +		nfs4_put_stid(&deleg->dl_stid);
> +		status =3D nfserr_admin_revoked;
> +		goto out;
> +	}
>  	if (deleg->dl_stid.sc_status & SC_STATUS_REVOKED) {
>  		nfs4_put_stid(&deleg->dl_stid);
>  		status =3D nfserr_deleg_revoked;
> @@ -6443,6 +6520,8 @@ nfsd4_lookup_stateid(struct nfsd4_compound_state *c=
state,
>  		 */
>  		statusmask |=3D SC_STATUS_REVOKED;
> =20
> +	statusmask |=3D SC_STATUS_ADMIN_REVOKED;
> +
>  	if (ZERO_STATEID(stateid) || ONE_STATEID(stateid) ||
>  		CLOSE_STATEID(stateid))
>  		return nfserr_bad_stateid;
> @@ -6461,6 +6540,10 @@ nfsd4_lookup_stateid(struct nfsd4_compound_state *=
cstate,
>  		nfs4_put_stid(stid);
>  		return nfserr_deleg_revoked;
>  	}
> +	if (stid->sc_status & SC_STATUS_ADMIN_REVOKED) {
> +		nfs4_put_stid(stid);
> +		return nfserr_admin_revoked;
> +	}
>  	*s =3D stid;
>  	return nfs_ok;
>  }
> diff --git a/fs/nfsd/nfsctl.c b/fs/nfsd/nfsctl.c
> index f206ca32e7f5..4bae65e8d28a 100644
> --- a/fs/nfsd/nfsctl.c
> +++ b/fs/nfsd/nfsctl.c
> @@ -281,6 +281,7 @@ static ssize_t write_unlock_fs(struct file *file, cha=
r *buf, size_t size)
>  	 * 3.  Is that directory the root of an exported file system?
>  	 */
>  	error =3D nlmsvc_unlock_all_by_sb(path.dentry->d_sb);
> +	nfsd4_revoke_states(netns(file), path.dentry->d_sb);
> =20
>  	path_put(&path);
>  	return error;
> diff --git a/fs/nfsd/nfsd.h b/fs/nfsd/nfsd.h
> index 304e9728b929..9a86fe8a39ef 100644
> --- a/fs/nfsd/nfsd.h
> +++ b/fs/nfsd/nfsd.h
> @@ -274,6 +274,7 @@ void		nfsd_lockd_shutdown(void);
>  #define	nfserr_no_grace		cpu_to_be32(NFSERR_NO_GRACE)
>  #define	nfserr_reclaim_bad	cpu_to_be32(NFSERR_RECLAIM_BAD)
>  #define	nfserr_badname		cpu_to_be32(NFSERR_BADNAME)
> +#define	nfserr_admin_revoked	cpu_to_be32(NFS4ERR_ADMIN_REVOKED)
>  #define	nfserr_cb_path_down	cpu_to_be32(NFSERR_CB_PATH_DOWN)
>  #define	nfserr_locked		cpu_to_be32(NFSERR_LOCKED)
>  #define	nfserr_wrongsec		cpu_to_be32(NFSERR_WRONGSEC)
> diff --git a/fs/nfsd/state.h b/fs/nfsd/state.h
> index ffc8920d0558..7fa83265ad9a 100644
> --- a/fs/nfsd/state.h
> +++ b/fs/nfsd/state.h
> @@ -112,6 +112,7 @@ struct nfs4_stid {
>  #define SC_STATUS_CLOSED	BIT(0)
>  /* For a deleg stateid kept around only to process free_stateid's: */
>  #define SC_STATUS_REVOKED	BIT(1)
> +#define SC_STATUS_ADMIN_REVOKED	BIT(2)
>  	unsigned short		sc_status;
> =20
>  	struct list_head	sc_cp_list;
> @@ -367,6 +368,7 @@ struct nfs4_client {
>  	clientid_t		cl_clientid;	/* generated by server */
>  	nfs4_verifier		cl_confirm;	/* generated by server */
>  	u32			cl_minorversion;
> +	atomic_t		cl_admin_revoked; /* count of admin-revoked states */
>  	/* NFSv4.1 client implementation id: */
>  	struct xdr_netobj	cl_nii_domain;
>  	struct xdr_netobj	cl_nii_name;
> @@ -730,6 +732,14 @@ static inline void get_nfs4_file(struct nfs4_file *f=
i)
>  }
>  struct nfsd_file *find_any_file(struct nfs4_file *f);
> =20
> +#ifdef CONFIG_NFSD_V4
> +void nfsd4_revoke_states(struct net *net, struct super_block *sb);
> +#else
> +static inline void nfsd4_revoke_states(struct net *net, struct super_blo=
ck *sb)
> +{
> +}
> +#endif
> +
>  /* grace period management */
>  void nfsd4_end_grace(struct nfsd_net *nn);
> =20
> diff --git a/fs/nfsd/trace.h b/fs/nfsd/trace.h
> index fe08ca18b647..5c58da9f86b7 100644
> --- a/fs/nfsd/trace.h
> +++ b/fs/nfsd/trace.h
> @@ -651,7 +651,8 @@ DEFINE_STATESEQID_EVENT(open_confirm);
>  #define show_stid_status(x)						\
>  	__print_flags(x, "|",						\
>  		{ SC_STATUS_CLOSED,		"CLOSED" },		\
> -		{ SC_STATUS_REVOKED,		"REVOKED" })		\
> +		{ SC_STATUS_REVOKED,		"REVOKED" },		\
> +		{ SC_STATUS_ADMIN_REVOKED,	"ADMIN_REVOKED" })
> =20
>  DECLARE_EVENT_CLASS(nfsd_stid_class,
>  	TP_PROTO(

Reviewed-by: Jeff Layton <jlayton@kernel.org>


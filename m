Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1AA937DF11A
	for <lists+linux-nfs@lfdr.de>; Thu,  2 Nov 2023 12:26:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347360AbjKBL0A (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 2 Nov 2023 07:26:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347339AbjKBLZ7 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 2 Nov 2023 07:25:59 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 576E0137
        for <linux-nfs@vger.kernel.org>; Thu,  2 Nov 2023 04:25:56 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64F6DC433C7;
        Thu,  2 Nov 2023 11:25:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698924356;
        bh=zjnfkjvm+MhA640KFMpUCjD/ixLHzL/dfZNjEllMP40=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=B5CznCPetxzQTmLjC4plTWGB26g/6zP+hy18BG+2H/DtZP0Zki+DMG7JD0H/urDZx
         WSE2g55Hgjc1yAL6cPheEn4qyjcBN+tWOs08pJEIqBT/gimZtzzzD65pWG8IRUQQSM
         6bE4suB09GnqitZtdw1ob34+e2IjOfQDaTGdlWnGYWznZ5O0f62fQrLyttPD+cnEFc
         suugUJo4Mvpq+ZR87Ee0YbiS3dqm9OX/jVm2TrYwcUBcpUqg87JUGJg4bihDqoMWJn
         7arkMJ4IVJA6snd/JBSsIO3dWwjr/uXHQlnA0c2ZnoqXT7dicbu/v9gdXvKdmQ+ciE
         UNT2Fy2qaT5kw==
Message-ID: <3b5d0e59d3889339c263b284a5663c6264c47da8.camel@kernel.org>
Subject: Re: [PATCH 1/6] nfsd: prepare for supporting admin-revocation of
 state
From:   Jeff Layton <jlayton@kernel.org>
To:     NeilBrown <neilb@suse.de>, Chuck Lever <chuck.lever@oracle.com>
Cc:     linux-nfs@vger.kernel.org, Olga Kornievskaia <kolga@netapp.com>,
        Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>
Date:   Thu, 02 Nov 2023 07:25:54 -0400
In-Reply-To: <20231101010049.27315-2-neilb@suse.de>
References: <20231101010049.27315-1-neilb@suse.de>
         <20231101010049.27315-2-neilb@suse.de>
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
MIME-Version: 1.0
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Wed, 2023-11-01 at 11:57 +1100, NeilBrown wrote:
> The NFSv4 protocol allows state to be revoked by the admin and has error
> codes which allow this to be communicated to the client.
>=20
> This patch
>  - introduces 3 new state-id types for revoked open, lock, and
>    delegation state.  This requires the bitmask to be 'short',
>    not 'char'
>  - reports NFS4ERR_ADMIN_REVOKED when these are accessed
>  - introduces a per-client counter of these states and returns
>    SEQ4_STATUS_ADMIN_STATE_REVOKED when the counter is not zero.
>    Decrement this when freeing any admin-revoked state.
>  - introduces stub code to find all interesting states for a given
>    superblock so they can be revoked via the 'unlock_filesystem'
>    file in /proc/fs/nfsd/
>    No actual states are handled yet.
>=20
> Signed-off-by: NeilBrown <neilb@suse.de>
> ---
>  fs/nfsd/nfs4layouts.c |  2 +-
>  fs/nfsd/nfs4state.c   | 93 +++++++++++++++++++++++++++++++++++++++----
>  fs/nfsd/nfsctl.c      |  1 +
>  fs/nfsd/nfsd.h        |  1 +
>  fs/nfsd/state.h       | 35 +++++++++++-----
>  fs/nfsd/trace.h       |  8 +++-
>  6 files changed, 120 insertions(+), 20 deletions(-)
>=20
> diff --git a/fs/nfsd/nfs4layouts.c b/fs/nfsd/nfs4layouts.c
> index 5e8096bc5eaa..09d0363bfbc4 100644
> --- a/fs/nfsd/nfs4layouts.c
> +++ b/fs/nfsd/nfs4layouts.c
> @@ -269,7 +269,7 @@ nfsd4_preprocess_layout_stateid(struct svc_rqst *rqst=
p,
>  {
>  	struct nfs4_layout_stateid *ls;
>  	struct nfs4_stid *stid;
> -	unsigned char typemask =3D NFS4_LAYOUT_STID;
> +	unsigned short typemask =3D NFS4_LAYOUT_STID;
>  	__be32 status;
> =20
>  	if (create)
> diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
> index 65fd5510323a..f3ba53a16105 100644
> --- a/fs/nfsd/nfs4state.c
> +++ b/fs/nfsd/nfs4state.c
> @@ -1202,6 +1202,13 @@ alloc_init_deleg(struct nfs4_client *clp, struct n=
fs4_file *fp,
>  	return NULL;
>  }
> =20
> +void nfs4_unhash_stid(struct nfs4_stid *s)
> +{
> +	if (s->sc_type & NFS4_ALL_ADMIN_REVOKED_STIDS)
> +		atomic_dec(&s->sc_client->cl_admin_revoked);
> +	s->sc_type =3D 0;
> +}
> +

Another thing that would be helpful to clarify here is the locking (if
any) around sc_type. Currently, it's just a bare non-atomic variable,
but we do change it occasionally and it has never been clear whether and
how it should be protected.

Any thoughts?

>  void
>  nfs4_put_stid(struct nfs4_stid *s)
>  {
> @@ -1215,6 +1222,7 @@ nfs4_put_stid(struct nfs4_stid *s)
>  		return;
>  	}
>  	idr_remove(&clp->cl_stateids, s->sc_stateid.si_opaque.so_id);
> +	nfs4_unhash_stid(s);
>  	nfs4_free_cpntf_statelist(clp->net, s);
>  	spin_unlock(&clp->cl_lock);
>  	s->sc_free(s);
> @@ -1265,11 +1273,6 @@ static void destroy_unhashed_deleg(struct nfs4_del=
egation *dp)
>  	nfs4_put_stid(&dp->dl_stid);
>  }
> =20
> -void nfs4_unhash_stid(struct nfs4_stid *s)
> -{
> -	s->sc_type =3D 0;
> -}
> -
>  /**
>   * nfs4_delegation_exists - Discover if this delegation already exists
>   * @clp:     a pointer to the nfs4_client we're granting a delegation to
> @@ -1536,6 +1539,7 @@ static void put_ol_stateid_locked(struct nfs4_ol_st=
ateid *stp,
>  	}
> =20
>  	idr_remove(&clp->cl_stateids, s->sc_stateid.si_opaque.so_id);
> +	nfs4_unhash_stid(s);
>  	list_add(&stp->st_locks, reaplist);
>  }
> =20
> @@ -1680,6 +1684,53 @@ static void release_openowner(struct nfs4_openowne=
r *oo)
>  	nfs4_put_stateowner(&oo->oo_owner);
>  }
> =20
> +static struct nfs4_stid *find_one_sb_stid(struct nfs4_client *clp,
> +					  struct super_block *sb,
> +					  unsigned short sc_types)
> +{
> +	unsigned long id, tmp;
> +	struct nfs4_stid *stid;
> +
> +	spin_lock(&clp->cl_lock);
> +	idr_for_each_entry_ul(&clp->cl_stateids, stid, tmp, id)
> +		if ((stid->sc_type & sc_types) &&
> +		    stid->sc_file->fi_inode->i_sb =3D=3D sb) {
> +			refcount_inc(&stid->sc_count);
> +			break;
> +		}
> +	spin_unlock(&clp->cl_lock);
> +	return stid;
> +}
> +
> +void nfsd4_revoke_states(struct net *net, struct super_block *sb)
> +{
> +	struct nfsd_net *nn =3D net_generic(net, nfsd_net_id);
> +	unsigned int idhashval;
> +	unsigned short sc_types;
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
> @@ -2465,7 +2516,8 @@ find_stateid_locked(struct nfs4_client *cl, stateid=
_t *t)
>  }
> =20
>  static struct nfs4_stid *
> -find_stateid_by_type(struct nfs4_client *cl, stateid_t *t, char typemask=
)
> +find_stateid_by_type(struct nfs4_client *cl, stateid_t *t,
> +		     unsigned short typemask)
>  {
>  	struct nfs4_stid *s;
> =20
> @@ -2549,6 +2601,8 @@ static int client_info_show(struct seq_file *m, voi=
d *v)
>  	}
>  	seq_printf(m, "callback state: %s\n", cb_state2str(clp->cl_cb_state));
>  	seq_printf(m, "callback address: %pISpc\n", &clp->cl_cb_conn.cb_addr);
> +	seq_printf(m, "admin-revoked states: %d\n",
> +		   atomic_read(&clp->cl_admin_revoked));
>  	drop_client(clp);
> =20
>  	return 0;
> @@ -4108,6 +4162,8 @@ nfsd4_sequence(struct svc_rqst *rqstp, struct nfsd4=
_compound_state *cstate,
>  	}
>  	if (!list_empty(&clp->cl_revoked))
>  		seq->status_flags |=3D SEQ4_STATUS_RECALLABLE_STATE_REVOKED;
> +	if (atomic_read(&clp->cl_admin_revoked))
> +		seq->status_flags |=3D SEQ4_STATUS_ADMIN_STATE_REVOKED;
>  out_no_session:
>  	if (conn)
>  		free_conn(conn);
> @@ -5200,6 +5256,11 @@ nfs4_check_deleg(struct nfs4_client *cl, struct nf=
sd4_open *open,
>  			status =3D nfserr_deleg_revoked;
>  		goto out;
>  	}
> +	if (deleg->dl_stid.sc_type =3D=3D NFS4_ADMIN_REVOKED_DELEG_STID) {
> +		nfs4_put_stid(&deleg->dl_stid);
> +		status =3D nfserr_admin_revoked;
> +		goto out;
> +	}
>  	flags =3D share_access_to_flags(open->op_share_access);
>  	status =3D nfs4_check_delegmode(deleg, flags);
>  	if (status) {
> @@ -6478,6 +6539,11 @@ static __be32 nfsd4_validate_stateid(struct nfs4_c=
lient *cl, stateid_t *stateid)
>  	case NFS4_REVOKED_DELEG_STID:
>  		status =3D nfserr_deleg_revoked;
>  		break;
> +	case NFS4_ADMIN_REVOKED_STID:
> +	case NFS4_ADMIN_REVOKED_LOCK_STID:
> +	case NFS4_ADMIN_REVOKED_DELEG_STID:
> +		status =3D nfserr_admin_revoked;
> +		break;
>  	case NFS4_OPEN_STID:
>  	case NFS4_LOCK_STID:
>  		status =3D nfsd4_check_openowner_confirmed(openlockstateid(s));
> @@ -6496,7 +6562,7 @@ static __be32 nfsd4_validate_stateid(struct nfs4_cl=
ient *cl, stateid_t *stateid)
> =20
>  __be32
>  nfsd4_lookup_stateid(struct nfsd4_compound_state *cstate,
> -		     stateid_t *stateid, unsigned char typemask,
> +		     stateid_t *stateid, unsigned short typemask,
>  		     struct nfs4_stid **s, struct nfsd_net *nn)
>  {
>  	__be32 status;
> @@ -6512,6 +6578,13 @@ nfsd4_lookup_stateid(struct nfsd4_compound_state *=
cstate,
>  	else if (typemask & NFS4_DELEG_STID)
>  		typemask |=3D NFS4_REVOKED_DELEG_STID;
> =20
> +	if (typemask & NFS4_OPEN_STID)
> +		typemask |=3D NFS4_ADMIN_REVOKED_STID;
> +	if (typemask & NFS4_LOCK_STID)
> +		typemask |=3D NFS4_ADMIN_REVOKED_LOCK_STID;
> +	if (typemask & NFS4_DELEG_STID)
> +		typemask |=3D NFS4_ADMIN_REVOKED_DELEG_STID;
> +
>  	if (ZERO_STATEID(stateid) || ONE_STATEID(stateid) ||
>  		CLOSE_STATEID(stateid))
>  		return nfserr_bad_stateid;
> @@ -6532,6 +6605,10 @@ nfsd4_lookup_stateid(struct nfsd4_compound_state *=
cstate,
>  			return nfserr_deleg_revoked;
>  		return nfserr_bad_stateid;
>  	}
> +	if (stid->sc_type & NFS4_ALL_ADMIN_REVOKED_STIDS) {
> +		nfs4_put_stid(stid);
> +		return nfserr_admin_revoked;
> +	}
>  	*s =3D stid;
>  	return nfs_ok;
>  }
> @@ -6899,7 +6976,7 @@ static __be32 nfs4_seqid_op_checks(struct nfsd4_com=
pound_state *cstate, stateid_
>   */
>  static __be32
>  nfs4_preprocess_seqid_op(struct nfsd4_compound_state *cstate, u32 seqid,
> -			 stateid_t *stateid, char typemask,
> +			 stateid_t *stateid, unsigned short typemask,
>  			 struct nfs4_ol_stateid **stpp,
>  			 struct nfsd_net *nn)
>  {
> diff --git a/fs/nfsd/nfsctl.c b/fs/nfsd/nfsctl.c
> index 739ed5bf71cd..50368eec86b0 100644
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
> index f5ff42f41ee7..d46203eac3c8 100644
> --- a/fs/nfsd/nfsd.h
> +++ b/fs/nfsd/nfsd.h
> @@ -280,6 +280,7 @@ void		nfsd_lockd_shutdown(void);
>  #define	nfserr_no_grace		cpu_to_be32(NFSERR_NO_GRACE)
>  #define	nfserr_reclaim_bad	cpu_to_be32(NFSERR_RECLAIM_BAD)
>  #define	nfserr_badname		cpu_to_be32(NFSERR_BADNAME)
> +#define	nfserr_admin_revoked	cpu_to_be32(NFS4ERR_ADMIN_REVOKED)
>  #define	nfserr_cb_path_down	cpu_to_be32(NFSERR_CB_PATH_DOWN)
>  #define	nfserr_locked		cpu_to_be32(NFSERR_LOCKED)
>  #define	nfserr_wrongsec		cpu_to_be32(NFSERR_WRONGSEC)
> diff --git a/fs/nfsd/state.h b/fs/nfsd/state.h
> index f96eaa8e9413..3af5ab55c978 100644
> --- a/fs/nfsd/state.h
> +++ b/fs/nfsd/state.h
> @@ -88,17 +88,23 @@ struct nfsd4_callback_ops {
>   */
>  struct nfs4_stid {
>  	refcount_t		sc_count;
> -#define NFS4_OPEN_STID 1
> -#define NFS4_LOCK_STID 2
> -#define NFS4_DELEG_STID 4
> +	struct list_head	sc_cp_list;
> +	unsigned short		sc_type;
> +#define NFS4_OPEN_STID			BIT(0)
> +#define NFS4_LOCK_STID			BIT(1)
> +#define NFS4_DELEG_STID			BIT(2)
>  /* For an open stateid kept around *only* to process close replays: */
> -#define NFS4_CLOSED_STID 8
> +#define NFS4_CLOSED_STID		BIT(3)
>  /* For a deleg stateid kept around only to process free_stateid's: */
> -#define NFS4_REVOKED_DELEG_STID 16
> -#define NFS4_CLOSED_DELEG_STID 32
> -#define NFS4_LAYOUT_STID 64
> -	struct list_head	sc_cp_list;
> -	unsigned char		sc_type;
> +#define NFS4_REVOKED_DELEG_STID		BIT(4)
> +#define NFS4_CLOSED_DELEG_STID		BIT(5)
> +#define NFS4_LAYOUT_STID		BIT(6)
> +#define NFS4_ADMIN_REVOKED_STID		BIT(7)
> +#define NFS4_ADMIN_REVOKED_LOCK_STID	BIT(8)
> +#define NFS4_ADMIN_REVOKED_DELEG_STID	BIT(9)
> +#define NFS4_ALL_ADMIN_REVOKED_STIDS (NFS4_ADMIN_REVOKED_STID |		\
> +				     NFS4_ADMIN_REVOKED_LOCK_STID |	\
> +				     NFS4_ADMIN_REVOKED_DELEG_STID)
>  	stateid_t		sc_stateid;
>  	spinlock_t		sc_lock;
>  	struct nfs4_client	*sc_client;
> @@ -372,6 +378,7 @@ struct nfs4_client {
>  	clientid_t		cl_clientid;	/* generated by server */
>  	nfs4_verifier		cl_confirm;	/* generated by server */
>  	u32			cl_minorversion;
> +	atomic_t		cl_admin_revoked; /* count of admin-revoked states */
>  	/* NFSv4.1 client implementation id: */
>  	struct xdr_netobj	cl_nii_domain;
>  	struct xdr_netobj	cl_nii_name;
> @@ -694,7 +701,7 @@ extern __be32 nfs4_preprocess_stateid_op(struct svc_r=
qst *rqstp,
>  		stateid_t *stateid, int flags, struct nfsd_file **filp,
>  		struct nfs4_stid **cstid);
>  __be32 nfsd4_lookup_stateid(struct nfsd4_compound_state *cstate,
> -		     stateid_t *stateid, unsigned char typemask,
> +		     stateid_t *stateid, unsigned short typemask,
>  		     struct nfs4_stid **s, struct nfsd_net *nn);
>  struct nfs4_stid *nfs4_alloc_stid(struct nfs4_client *cl, struct kmem_ca=
che *slab,
>  				  void (*sc_free)(struct nfs4_stid *));
> @@ -736,6 +743,14 @@ static inline void get_nfs4_file(struct nfs4_file *f=
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
> index fbc0ccb40424..e359d531402c 100644
> --- a/fs/nfsd/trace.h
> +++ b/fs/nfsd/trace.h
> @@ -648,6 +648,9 @@ TRACE_DEFINE_ENUM(NFS4_CLOSED_STID);
>  TRACE_DEFINE_ENUM(NFS4_REVOKED_DELEG_STID);
>  TRACE_DEFINE_ENUM(NFS4_CLOSED_DELEG_STID);
>  TRACE_DEFINE_ENUM(NFS4_LAYOUT_STID);
> +TRACE_DEFINE_ENUM(NFS4_ADMIN_REVOKED_STID);
> +TRACE_DEFINE_ENUM(NFS4_ADMIN_REVOKED_LOCK_STID);
> +TRACE_DEFINE_ENUM(NFS4_ADMIN_REVOKED_DELEG_STID);
> =20
>  #define show_stid_type(x)						\
>  	__print_flags(x, "|",						\
> @@ -657,7 +660,10 @@ TRACE_DEFINE_ENUM(NFS4_LAYOUT_STID);
>  		{ NFS4_CLOSED_STID,		"CLOSED" },		\
>  		{ NFS4_REVOKED_DELEG_STID,	"REVOKED" },		\
>  		{ NFS4_CLOSED_DELEG_STID,	"CLOSED_DELEG" },	\
> -		{ NFS4_LAYOUT_STID,		"LAYOUT" })
> +		{ NFS4_LAYOUT_STID,		"LAYOUT" },		\
> +		{ NFS4_ADMIN_REVOKED_STID,	"ADMIN_REVOKED" },	\
> +		{ NFS4_ADMIN_REVOKED_LOCK_STID,	"ADMIN_REVOKED_LOCK" },	\
> +		{ NFS4_ADMIN_REVOKED_DELEG_STID,"ADMIN_REVOKED_DELEG" })
> =20
>  DECLARE_EVENT_CLASS(nfsd_stid_class,
>  	TP_PROTO(

--=20
Jeff Layton <jlayton@kernel.org>

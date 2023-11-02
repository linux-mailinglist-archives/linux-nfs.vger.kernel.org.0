Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A67227DFB79
	for <lists+linux-nfs@lfdr.de>; Thu,  2 Nov 2023 21:24:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229619AbjKBUYz (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 2 Nov 2023 16:24:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229511AbjKBUYz (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 2 Nov 2023 16:24:55 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C67D181
        for <linux-nfs@vger.kernel.org>; Thu,  2 Nov 2023 13:24:51 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7DC18C433C8;
        Thu,  2 Nov 2023 20:24:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698956691;
        bh=6DMMZ7DfWHbEjI1cZ1yYBDEXB26aqnZnK/bJER5gWno=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=X7pPweD/mi0ZKzrRnbTVfsP8VnLlxCqiUO359qXa6tAXIedftJy8U9yEuo/cN+opK
         kxp5mqcFg5+/jIW1YVJEwvQpXRwtFn+HzNo5ikqD1SGJnR7W9epqeMAMfUrxRd/iEs
         o9IVslbsWjtE0dMXqntPQkmofnaf7RnXU0n6lFm5JgyuY82CnymqgwFZEXh+GV5kG9
         yz+B/MZK6iN5hxcd8m9iMBH2hTahoopfSE2I68rJ8vAGFq/RMxXNPpSiF1Q8q+aR/X
         fZqER0ry6u9sd8vitVZuGmKX+woZNhN2KTZdGdmo4mNzAqN9WrEFxdYoOEhUsg3jtD
         50vbF1MBSxkOw==
Message-ID: <83c7ff4f3166c5780ce803e43eaa65e9d9e2f6bb.camel@kernel.org>
Subject: Re: [PATCH 1/6] nfsd: prepare for supporting admin-revocation of
 state
From:   Jeff Layton <jlayton@kernel.org>
To:     NeilBrown <neilb@suse.de>
Cc:     Chuck Lever <chuck.lever@oracle.com>, linux-nfs@vger.kernel.org,
        Olga Kornievskaia <kolga@netapp.com>,
        Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>
Date:   Thu, 02 Nov 2023 16:24:49 -0400
In-Reply-To: <169895539002.24305.2542985743958570903@noble.neil.brown.name>
References: <20231101010049.27315-1-neilb@suse.de>
        , <20231101010049.27315-2-neilb@suse.de>
        , <171568f8371932f66429b4557bce7aaf959215ec.camel@kernel.org>
         <169895539002.24305.2542985743958570903@noble.neil.brown.name>
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

On Fri, 2023-11-03 at 07:03 +1100, NeilBrown wrote:
> On Thu, 02 Nov 2023, Jeff Layton wrote:
> > On Wed, 2023-11-01 at 11:57 +1100, NeilBrown wrote:
> > > The NFSv4 protocol allows state to be revoked by the admin and has er=
ror
> > > codes which allow this to be communicated to the client.
> > >=20
> > > This patch
> > >  - introduces 3 new state-id types for revoked open, lock, and
> > >    delegation state.  This requires the bitmask to be 'short',
> > >    not 'char'
> > >  - reports NFS4ERR_ADMIN_REVOKED when these are accessed
> > >  - introduces a per-client counter of these states and returns
> > >    SEQ4_STATUS_ADMIN_STATE_REVOKED when the counter is not zero.
> > >    Decrement this when freeing any admin-revoked state.
> > >  - introduces stub code to find all interesting states for a given
> > >    superblock so they can be revoked via the 'unlock_filesystem'
> > >    file in /proc/fs/nfsd/
> > >    No actual states are handled yet.
> > >=20
> > > Signed-off-by: NeilBrown <neilb@suse.de>
> > > ---
> > >  fs/nfsd/nfs4layouts.c |  2 +-
> > >  fs/nfsd/nfs4state.c   | 93 +++++++++++++++++++++++++++++++++++++++--=
--
> > >  fs/nfsd/nfsctl.c      |  1 +
> > >  fs/nfsd/nfsd.h        |  1 +
> > >  fs/nfsd/state.h       | 35 +++++++++++-----
> > >  fs/nfsd/trace.h       |  8 +++-
> > >  6 files changed, 120 insertions(+), 20 deletions(-)
> > >=20
> > > diff --git a/fs/nfsd/nfs4layouts.c b/fs/nfsd/nfs4layouts.c
> > > index 5e8096bc5eaa..09d0363bfbc4 100644
> > > --- a/fs/nfsd/nfs4layouts.c
> > > +++ b/fs/nfsd/nfs4layouts.c
> > > @@ -269,7 +269,7 @@ nfsd4_preprocess_layout_stateid(struct svc_rqst *=
rqstp,
> > >  {
> > >  	struct nfs4_layout_stateid *ls;
> > >  	struct nfs4_stid *stid;
> > > -	unsigned char typemask =3D NFS4_LAYOUT_STID;
> > > +	unsigned short typemask =3D NFS4_LAYOUT_STID;
> > >  	__be32 status;
> > > =20
> > >  	if (create)
> > > diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
> > > index 65fd5510323a..f3ba53a16105 100644
> > > --- a/fs/nfsd/nfs4state.c
> > > +++ b/fs/nfsd/nfs4state.c
> > > @@ -1202,6 +1202,13 @@ alloc_init_deleg(struct nfs4_client *clp, stru=
ct nfs4_file *fp,
> > >  	return NULL;
> > >  }
> > > =20
> > > +void nfs4_unhash_stid(struct nfs4_stid *s)
> > > +{
> > > +	if (s->sc_type & NFS4_ALL_ADMIN_REVOKED_STIDS)
> > > +		atomic_dec(&s->sc_client->cl_admin_revoked);
> > > +	s->sc_type =3D 0;
> > > +}
> > > +
> > >  void
> > >  nfs4_put_stid(struct nfs4_stid *s)
> > >  {
> > > @@ -1215,6 +1222,7 @@ nfs4_put_stid(struct nfs4_stid *s)
> > >  		return;
> > >  	}
> > >  	idr_remove(&clp->cl_stateids, s->sc_stateid.si_opaque.so_id);
> > > +	nfs4_unhash_stid(s);
> > >  	nfs4_free_cpntf_statelist(clp->net, s);
> > >  	spin_unlock(&clp->cl_lock);
> > >  	s->sc_free(s);
> > > @@ -1265,11 +1273,6 @@ static void destroy_unhashed_deleg(struct nfs4=
_delegation *dp)
> > >  	nfs4_put_stid(&dp->dl_stid);
> > >  }
> > > =20
> > > -void nfs4_unhash_stid(struct nfs4_stid *s)
> > > -{
> > > -	s->sc_type =3D 0;
> > > -}
> > > -
> > >  /**
> > >   * nfs4_delegation_exists - Discover if this delegation already exis=
ts
> > >   * @clp:     a pointer to the nfs4_client we're granting a delegatio=
n to
> > > @@ -1536,6 +1539,7 @@ static void put_ol_stateid_locked(struct nfs4_o=
l_stateid *stp,
> > >  	}
> > > =20
> > >  	idr_remove(&clp->cl_stateids, s->sc_stateid.si_opaque.so_id);
> > > +	nfs4_unhash_stid(s);
> > >  	list_add(&stp->st_locks, reaplist);
> > >  }
> > > =20
> > > @@ -1680,6 +1684,53 @@ static void release_openowner(struct nfs4_open=
owner *oo)
> > >  	nfs4_put_stateowner(&oo->oo_owner);
> > >  }
> > > =20
> > > +static struct nfs4_stid *find_one_sb_stid(struct nfs4_client *clp,
> > > +					  struct super_block *sb,
> > > +					  unsigned short sc_types)
> > > +{
> > > +	unsigned long id, tmp;
> > > +	struct nfs4_stid *stid;
> > > +
> > > +	spin_lock(&clp->cl_lock);
> > > +	idr_for_each_entry_ul(&clp->cl_stateids, stid, tmp, id)
> > > +		if ((stid->sc_type & sc_types) &&
> > > +		    stid->sc_file->fi_inode->i_sb =3D=3D sb) {
> > > +			refcount_inc(&stid->sc_count);
> > > +			break;
> > > +		}
> > > +	spin_unlock(&clp->cl_lock);
> > > +	return stid;
> > > +}
> > > +
> > > +void nfsd4_revoke_states(struct net *net, struct super_block *sb)
> > > +{
> > > +	struct nfsd_net *nn =3D net_generic(net, nfsd_net_id);
> > > +	unsigned int idhashval;
> > > +	unsigned short sc_types;
> > > +
> > > +	sc_types =3D 0;
> > > +
> > > +	spin_lock(&nn->client_lock);
> > > +	for (idhashval =3D 0; idhashval < CLIENT_HASH_MASK; idhashval++) {
> > > +		struct list_head *head =3D &nn->conf_id_hashtbl[idhashval];
> > > +		struct nfs4_client *clp;
> > > +	retry:
> > > +		list_for_each_entry(clp, head, cl_idhash) {
> > > +			struct nfs4_stid *stid =3D find_one_sb_stid(clp, sb,
> > > +								  sc_types);
> > > +			if (stid) {
> > > +				spin_unlock(&nn->client_lock);
> > > +				switch (stid->sc_type) {
> > > +				}
> > > +				nfs4_put_stid(stid);
> > > +				spin_lock(&nn->client_lock);
> > > +				goto retry;
> > > +			}
> > > +		}
> > > +	}
> > > +	spin_unlock(&nn->client_lock);
> > > +}
> > > +
> > >  static inline int
> > >  hash_sessionid(struct nfs4_sessionid *sessionid)
> > >  {
> > > @@ -2465,7 +2516,8 @@ find_stateid_locked(struct nfs4_client *cl, sta=
teid_t *t)
> > >  }
> > > =20
> > >  static struct nfs4_stid *
> > > -find_stateid_by_type(struct nfs4_client *cl, stateid_t *t, char type=
mask)
> > > +find_stateid_by_type(struct nfs4_client *cl, stateid_t *t,
> > > +		     unsigned short typemask)
> > >  {
> > >  	struct nfs4_stid *s;
> > > =20
> > > @@ -2549,6 +2601,8 @@ static int client_info_show(struct seq_file *m,=
 void *v)
> > >  	}
> > >  	seq_printf(m, "callback state: %s\n", cb_state2str(clp->cl_cb_state=
));
> > >  	seq_printf(m, "callback address: %pISpc\n", &clp->cl_cb_conn.cb_add=
r);
> > > +	seq_printf(m, "admin-revoked states: %d\n",
> > > +		   atomic_read(&clp->cl_admin_revoked));
> > >  	drop_client(clp);
> > > =20
> > >  	return 0;
> > > @@ -4108,6 +4162,8 @@ nfsd4_sequence(struct svc_rqst *rqstp, struct n=
fsd4_compound_state *cstate,
> > >  	}
> > >  	if (!list_empty(&clp->cl_revoked))
> > >  		seq->status_flags |=3D SEQ4_STATUS_RECALLABLE_STATE_REVOKED;
> > > +	if (atomic_read(&clp->cl_admin_revoked))
> > > +		seq->status_flags |=3D SEQ4_STATUS_ADMIN_STATE_REVOKED;
> > >  out_no_session:
> > >  	if (conn)
> > >  		free_conn(conn);
> > > @@ -5200,6 +5256,11 @@ nfs4_check_deleg(struct nfs4_client *cl, struc=
t nfsd4_open *open,
> > >  			status =3D nfserr_deleg_revoked;
> > >  		goto out;
> > >  	}
> > > +	if (deleg->dl_stid.sc_type =3D=3D NFS4_ADMIN_REVOKED_DELEG_STID) {
> > > +		nfs4_put_stid(&deleg->dl_stid);
> > > +		status =3D nfserr_admin_revoked;
> > > +		goto out;
> > > +	}
> > >  	flags =3D share_access_to_flags(open->op_share_access);
> > >  	status =3D nfs4_check_delegmode(deleg, flags);
> > >  	if (status) {
> > > @@ -6478,6 +6539,11 @@ static __be32 nfsd4_validate_stateid(struct nf=
s4_client *cl, stateid_t *stateid)
> > >  	case NFS4_REVOKED_DELEG_STID:
> > >  		status =3D nfserr_deleg_revoked;
> > >  		break;
> > > +	case NFS4_ADMIN_REVOKED_STID:
> > > +	case NFS4_ADMIN_REVOKED_LOCK_STID:
> > > +	case NFS4_ADMIN_REVOKED_DELEG_STID:
> > > +		status =3D nfserr_admin_revoked;
> > > +		break;
> > >  	case NFS4_OPEN_STID:
> > >  	case NFS4_LOCK_STID:
> > >  		status =3D nfsd4_check_openowner_confirmed(openlockstateid(s));
> > > @@ -6496,7 +6562,7 @@ static __be32 nfsd4_validate_stateid(struct nfs=
4_client *cl, stateid_t *stateid)
> > > =20
> > >  __be32
> > >  nfsd4_lookup_stateid(struct nfsd4_compound_state *cstate,
> > > -		     stateid_t *stateid, unsigned char typemask,
> > > +		     stateid_t *stateid, unsigned short typemask,
> > >  		     struct nfs4_stid **s, struct nfsd_net *nn)
> > >  {
> > >  	__be32 status;
> > > @@ -6512,6 +6578,13 @@ nfsd4_lookup_stateid(struct nfsd4_compound_sta=
te *cstate,
> > >  	else if (typemask & NFS4_DELEG_STID)
> > >  		typemask |=3D NFS4_REVOKED_DELEG_STID;
> > > =20
> > > +	if (typemask & NFS4_OPEN_STID)
> > > +		typemask |=3D NFS4_ADMIN_REVOKED_STID;
> > > +	if (typemask & NFS4_LOCK_STID)
> > > +		typemask |=3D NFS4_ADMIN_REVOKED_LOCK_STID;
> > > +	if (typemask & NFS4_DELEG_STID)
> > > +		typemask |=3D NFS4_ADMIN_REVOKED_DELEG_STID;
> > > +
> > >  	if (ZERO_STATEID(stateid) || ONE_STATEID(stateid) ||
> > >  		CLOSE_STATEID(stateid))
> > >  		return nfserr_bad_stateid;
> > > @@ -6532,6 +6605,10 @@ nfsd4_lookup_stateid(struct nfsd4_compound_sta=
te *cstate,
> > >  			return nfserr_deleg_revoked;
> > >  		return nfserr_bad_stateid;
> > >  	}
> > > +	if (stid->sc_type & NFS4_ALL_ADMIN_REVOKED_STIDS) {
> > > +		nfs4_put_stid(stid);
> > > +		return nfserr_admin_revoked;
> > > +	}
> > >  	*s =3D stid;
> > >  	return nfs_ok;
> > >  }
> > > @@ -6899,7 +6976,7 @@ static __be32 nfs4_seqid_op_checks(struct nfsd4=
_compound_state *cstate, stateid_
> > >   */
> > >  static __be32
> > >  nfs4_preprocess_seqid_op(struct nfsd4_compound_state *cstate, u32 se=
qid,
> > > -			 stateid_t *stateid, char typemask,
> > > +			 stateid_t *stateid, unsigned short typemask,
> > >  			 struct nfs4_ol_stateid **stpp,
> > >  			 struct nfsd_net *nn)
> > >  {
> > > diff --git a/fs/nfsd/nfsctl.c b/fs/nfsd/nfsctl.c
> > > index 739ed5bf71cd..50368eec86b0 100644
> > > --- a/fs/nfsd/nfsctl.c
> > > +++ b/fs/nfsd/nfsctl.c
> > > @@ -281,6 +281,7 @@ static ssize_t write_unlock_fs(struct file *file,=
 char *buf, size_t size)
> > >  	 * 3.  Is that directory the root of an exported file system?
> > >  	 */
> > >  	error =3D nlmsvc_unlock_all_by_sb(path.dentry->d_sb);
> > > +	nfsd4_revoke_states(netns(file), path.dentry->d_sb);
> > > =20
> > >  	path_put(&path);
> > >  	return error;
> > > diff --git a/fs/nfsd/nfsd.h b/fs/nfsd/nfsd.h
> > > index f5ff42f41ee7..d46203eac3c8 100644
> > > --- a/fs/nfsd/nfsd.h
> > > +++ b/fs/nfsd/nfsd.h
> > > @@ -280,6 +280,7 @@ void		nfsd_lockd_shutdown(void);
> > >  #define	nfserr_no_grace		cpu_to_be32(NFSERR_NO_GRACE)
> > >  #define	nfserr_reclaim_bad	cpu_to_be32(NFSERR_RECLAIM_BAD)
> > >  #define	nfserr_badname		cpu_to_be32(NFSERR_BADNAME)
> > > +#define	nfserr_admin_revoked	cpu_to_be32(NFS4ERR_ADMIN_REVOKED)
> > >  #define	nfserr_cb_path_down	cpu_to_be32(NFSERR_CB_PATH_DOWN)
> > >  #define	nfserr_locked		cpu_to_be32(NFSERR_LOCKED)
> > >  #define	nfserr_wrongsec		cpu_to_be32(NFSERR_WRONGSEC)
> > > diff --git a/fs/nfsd/state.h b/fs/nfsd/state.h
> > > index f96eaa8e9413..3af5ab55c978 100644
> > > --- a/fs/nfsd/state.h
> > > +++ b/fs/nfsd/state.h
> > > @@ -88,17 +88,23 @@ struct nfsd4_callback_ops {
> > >   */
> > >  struct nfs4_stid {
> > >  	refcount_t		sc_count;
> > > -#define NFS4_OPEN_STID 1
> > > -#define NFS4_LOCK_STID 2
> > > -#define NFS4_DELEG_STID 4
> > > +	struct list_head	sc_cp_list;
> > > +	unsigned short		sc_type;
> >=20
> > Should we just go ahead and make this a full 32-bit word? We seem to
> > keep adding flags to this field, and I doubt we're saving anything by
> > making this a short.
> >=20
> > > +#define NFS4_OPEN_STID			BIT(0)
> > > +#define NFS4_LOCK_STID			BIT(1)
> > > +#define NFS4_DELEG_STID			BIT(2)
> > >  /* For an open stateid kept around *only* to process close replays: =
*/
> > > -#define NFS4_CLOSED_STID 8
> > > +#define NFS4_CLOSED_STID		BIT(3)
> > >  /* For a deleg stateid kept around only to process free_stateid's: *=
/
> > > -#define NFS4_REVOKED_DELEG_STID 16
> > > -#define NFS4_CLOSED_DELEG_STID 32
> > > -#define NFS4_LAYOUT_STID 64
> > > -	struct list_head	sc_cp_list;
> > > -	unsigned char		sc_type;
> > > +#define NFS4_REVOKED_DELEG_STID		BIT(4)
> > > +#define NFS4_CLOSED_DELEG_STID		BIT(5)
> > > +#define NFS4_LAYOUT_STID		BIT(6)
> > > +#define NFS4_ADMIN_REVOKED_STID		BIT(7)
> > > +#define NFS4_ADMIN_REVOKED_LOCK_STID	BIT(8)
> > > +#define NFS4_ADMIN_REVOKED_DELEG_STID	BIT(9)
> > > +#define NFS4_ALL_ADMIN_REVOKED_STIDS (NFS4_ADMIN_REVOKED_STID |		\
> > > +				     NFS4_ADMIN_REVOKED_LOCK_STID |	\
> > > +				     NFS4_ADMIN_REVOKED_DELEG_STID)
> >=20
> > Not a specific criticism of these patches, since this problem preexists
> > them, but I really dislike the way that sc_type is used as a bitmask,
> > but also sort of like an enum. In some cases, we test for specific flag=
s
> > in the mask, and in other cases (e.g. states_show), we treat them as
> > discrete values to feed it to a switch().
> >=20
> > Personally, I'd find this less confusing if we just treat this as a set
> > of flags full-stop. We could leave the low-order bits to show the real
> > type (open, lock, deleg, etc.) and just mask off the high-order bits
> > when we need to feed it to a switch statement.
> >=20
> > For instance above, we're adding 3 new NFS4_ADMIN_REVOKED values, but w=
e
> > could (in theory) just have a flag in there that says NFS4_ADMIN_REVOKE=
D
> > and leave the old type bit in place instead of changing it to a new
> > discrete sc_type value.
>=20
> I agree.
> Bits might be:
>     OPEN
>     LOCK
>     DELEG
>     LAYOUT
>     CLOSED (combines with OPEN or DELEG)
>     REVOKED (combines with DELEG)
>     ADMIN_REVOKED (combined with OPEN, LOCK, DELEG.  Sets REVOKED when
>                    with DELEG)
>=20
> so we could go back to a char :-)  Probably sensible to use unsigned int
> though.
>=20

Yeah, a u32 would be best I think. It'll just fill an existing hole on
my box (x86_64), according to pahole:

	unsigned char              sc_type;              /*    24     1 */

	/* XXX 3 bytes hole, try to pack */

> For updates the rule would be that bits can be set but never cleared so
> you don't need locking to read unless you care about a bit that can be
> changed.
>=20

Probably for the low order OPEN/LOCK/DELEG bits, the rule should be that
they never change. We can never convert from one to another since they
come out of different slabcaches. It's probably worthwhile to leave a
few low order bits carved out for new types in the future too. e.g.
directory delegations...

Maybe we should rename the field too? How about "sc_mode" since this is
starting to resemble the i_mode field in some ways (type and permissions
squashed together).

> cl_lock is held most often for updates, but not always.  We should see
> if we can make that more consistent.  Maybe we could use sc_lock
> instead.
> I'll have a look.
>=20

Awesome.

> Thanks,
> NeilBrown
>=20
>=20
> >=20
> > >  	stateid_t		sc_stateid;
> > >  	spinlock_t		sc_lock;
> > >  	struct nfs4_client	*sc_client;
> > > @@ -372,6 +378,7 @@ struct nfs4_client {
> > >  	clientid_t		cl_clientid;	/* generated by server */
> > >  	nfs4_verifier		cl_confirm;	/* generated by server */
> > >  	u32			cl_minorversion;
> > > +	atomic_t		cl_admin_revoked; /* count of admin-revoked states */
> > >  	/* NFSv4.1 client implementation id: */
> > >  	struct xdr_netobj	cl_nii_domain;
> > >  	struct xdr_netobj	cl_nii_name;
> > > @@ -694,7 +701,7 @@ extern __be32 nfs4_preprocess_stateid_op(struct s=
vc_rqst *rqstp,
> > >  		stateid_t *stateid, int flags, struct nfsd_file **filp,
> > >  		struct nfs4_stid **cstid);
> > >  __be32 nfsd4_lookup_stateid(struct nfsd4_compound_state *cstate,
> > > -		     stateid_t *stateid, unsigned char typemask,
> > > +		     stateid_t *stateid, unsigned short typemask,
> > >  		     struct nfs4_stid **s, struct nfsd_net *nn);
> > >  struct nfs4_stid *nfs4_alloc_stid(struct nfs4_client *cl, struct kme=
m_cache *slab,
> > >  				  void (*sc_free)(struct nfs4_stid *));
> > > @@ -736,6 +743,14 @@ static inline void get_nfs4_file(struct nfs4_fil=
e *fi)
> > >  }
> > >  struct nfsd_file *find_any_file(struct nfs4_file *f);
> > > =20
> > > +#ifdef CONFIG_NFSD_V4
> > > +void nfsd4_revoke_states(struct net *net, struct super_block *sb);
> > > +#else
> > > +static inline void nfsd4_revoke_states(struct net *net, struct super=
_block *sb)
> > > +{
> > > +}
> > > +#endif
> > > +
> > >  /* grace period management */
> > >  void nfsd4_end_grace(struct nfsd_net *nn);
> > > =20
> > > diff --git a/fs/nfsd/trace.h b/fs/nfsd/trace.h
> > > index fbc0ccb40424..e359d531402c 100644
> > > --- a/fs/nfsd/trace.h
> > > +++ b/fs/nfsd/trace.h
> > > @@ -648,6 +648,9 @@ TRACE_DEFINE_ENUM(NFS4_CLOSED_STID);
> > >  TRACE_DEFINE_ENUM(NFS4_REVOKED_DELEG_STID);
> > >  TRACE_DEFINE_ENUM(NFS4_CLOSED_DELEG_STID);
> > >  TRACE_DEFINE_ENUM(NFS4_LAYOUT_STID);
> > > +TRACE_DEFINE_ENUM(NFS4_ADMIN_REVOKED_STID);
> > > +TRACE_DEFINE_ENUM(NFS4_ADMIN_REVOKED_LOCK_STID);
> > > +TRACE_DEFINE_ENUM(NFS4_ADMIN_REVOKED_DELEG_STID);
> > > =20
> > >  #define show_stid_type(x)						\
> > >  	__print_flags(x, "|",						\
> > > @@ -657,7 +660,10 @@ TRACE_DEFINE_ENUM(NFS4_LAYOUT_STID);
> > >  		{ NFS4_CLOSED_STID,		"CLOSED" },		\
> > >  		{ NFS4_REVOKED_DELEG_STID,	"REVOKED" },		\
> > >  		{ NFS4_CLOSED_DELEG_STID,	"CLOSED_DELEG" },	\
> > > -		{ NFS4_LAYOUT_STID,		"LAYOUT" })
> > > +		{ NFS4_LAYOUT_STID,		"LAYOUT" },		\
> > > +		{ NFS4_ADMIN_REVOKED_STID,	"ADMIN_REVOKED" },	\
> > > +		{ NFS4_ADMIN_REVOKED_LOCK_STID,	"ADMIN_REVOKED_LOCK" },	\
> > > +		{ NFS4_ADMIN_REVOKED_DELEG_STID,"ADMIN_REVOKED_DELEG" })
> > > =20
> > >  DECLARE_EVENT_CLASS(nfsd_stid_class,
> > >  	TP_PROTO(
> >=20
> > --=20
> > Jeff Layton <jlayton@kernel.org>
> >=20
>=20

--=20
Jeff Layton <jlayton@kernel.org>

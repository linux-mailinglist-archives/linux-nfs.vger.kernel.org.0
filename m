Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B660C7E0756
	for <lists+linux-nfs@lfdr.de>; Fri,  3 Nov 2023 18:25:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230202AbjKCRZa (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 3 Nov 2023 13:25:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230215AbjKCRZa (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 3 Nov 2023 13:25:30 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53279136
        for <linux-nfs@vger.kernel.org>; Fri,  3 Nov 2023 10:25:24 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21F49C433C8;
        Fri,  3 Nov 2023 17:25:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699032322;
        bh=83uJhuepejfU/s2aKvRkaX/mRZYzIt3ltceDxhK+kcM=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=n3F2Ao/YQaQ+jhCf+0PRPvl0ZluzOzZGlC8s3RbHLTNLhbf+IKsnldPCn3kTLmuKE
         CVllxhutVzVKkoNdX/ngk3sKpRWAGhZowHTHlCoyXYhGGpi2a1ts59G0P5MZnNcdxI
         QR2gSW4phG7yLTNZC1KBFMaVNWaiXsBmRoEt2eEyPi0did3yrvUuE9rZfQVS3Lhi33
         O6WdIYZvHD/b+vJ21Lduf3UGP8L9lNHRD2QxEQ4LV9AuckIJjDXKNhxij/Sx+wCvm2
         nkcj5nRm7THAPNtQ24WtsOw6KrorVGHUg2o7VATDahA4+AO4ZGxvfuFGeStUpgqLUn
         jAOyGsRA3zV7w==
Message-ID: <12267b8d96e2fc404cf7d2f62eddf511b403cbaf.camel@kernel.org>
Subject: Re: [PATCH 1/6] nfsd: prepare for supporting admin-revocation of
 state
From:   Jeff Layton <jlayton@kernel.org>
To:     NeilBrown <neilb@suse.de>, Chuck Lever III <chuck.lever@oracle.com>
Cc:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        Olga Kornievskaia <kolga@netapp.com>,
        Dai Ngo <dai.ngo@oracle.com>, Tom Talpey <tom@talpey.com>
Date:   Fri, 03 Nov 2023 13:25:20 -0400
In-Reply-To: <169897368475.24305.2294425791696451143@noble.neil.brown.name>
References: <20231101010049.27315-1-neilb@suse.de>
        , <20231101010049.27315-2-neilb@suse.de>
        , <171568f8371932f66429b4557bce7aaf959215ec.camel@kernel.org>
        , <169895539002.24305.2542985743958570903@noble.neil.brown.name>
        , <83c7ff4f3166c5780ce803e43eaa65e9d9e2f6bb.camel@kernel.org>
        , <E792C97F-BB0F-46DD-828F-113F95270464@oracle.com>
         <169897368475.24305.2294425791696451143@noble.neil.brown.name>
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Fri, 2023-11-03 at 12:08 +1100, NeilBrown wrote:
> On Fri, 03 Nov 2023, Chuck Lever III wrote:
> >=20
> > > On Nov 2, 2023, at 1:24 PM, Jeff Layton <jlayton@kernel.org> wrote:
> > >=20
> > > On Fri, 2023-11-03 at 07:03 +1100, NeilBrown wrote:
> > > > On Thu, 02 Nov 2023, Jeff Layton wrote:
> > > > > On Wed, 2023-11-01 at 11:57 +1100, NeilBrown wrote:
> > > > > > The NFSv4 protocol allows state to be revoked by the admin and =
has error
> > > > > > codes which allow this to be communicated to the client.
> > > > > >=20
> > > > > > This patch
> > > > > > - introduces 3 new state-id types for revoked open, lock, and
> > > > > >   delegation state.  This requires the bitmask to be 'short',
> > > > > >   not 'char'
> > > > > > - reports NFS4ERR_ADMIN_REVOKED when these are accessed
> > > > > > - introduces a per-client counter of these states and returns
> > > > > >   SEQ4_STATUS_ADMIN_STATE_REVOKED when the counter is not zero.
> > > > > >   Decrement this when freeing any admin-revoked state.
> > > > > > - introduces stub code to find all interesting states for a giv=
en
> > > > > >   superblock so they can be revoked via the 'unlock_filesystem'
> > > > > >   file in /proc/fs/nfsd/
> > > > > >   No actual states are handled yet.
> > > > > >=20
> > > > > > Signed-off-by: NeilBrown <neilb@suse.de>
> > > > > > ---
> > > > > > fs/nfsd/nfs4layouts.c |  2 +-
> > > > > > fs/nfsd/nfs4state.c   | 93 ++++++++++++++++++++++++++++++++++++=
+++----
> > > > > > fs/nfsd/nfsctl.c      |  1 +
> > > > > > fs/nfsd/nfsd.h        |  1 +
> > > > > > fs/nfsd/state.h       | 35 +++++++++++-----
> > > > > > fs/nfsd/trace.h       |  8 +++-
> > > > > > 6 files changed, 120 insertions(+), 20 deletions(-)
> > > > > >=20
> > > > > > diff --git a/fs/nfsd/nfs4layouts.c b/fs/nfsd/nfs4layouts.c
> > > > > > index 5e8096bc5eaa..09d0363bfbc4 100644
> > > > > > --- a/fs/nfsd/nfs4layouts.c
> > > > > > +++ b/fs/nfsd/nfs4layouts.c
> > > > > > @@ -269,7 +269,7 @@ nfsd4_preprocess_layout_stateid(struct svc_=
rqst *rqstp,
> > > > > > {
> > > > > > struct nfs4_layout_stateid *ls;
> > > > > > struct nfs4_stid *stid;
> > > > > > - unsigned char typemask =3D NFS4_LAYOUT_STID;
> > > > > > + unsigned short typemask =3D NFS4_LAYOUT_STID;
> > > > > > __be32 status;
> > > > > >=20
> > > > > > if (create)
> > > > > > diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
> > > > > > index 65fd5510323a..f3ba53a16105 100644
> > > > > > --- a/fs/nfsd/nfs4state.c
> > > > > > +++ b/fs/nfsd/nfs4state.c
> > > > > > @@ -1202,6 +1202,13 @@ alloc_init_deleg(struct nfs4_client *clp=
, struct nfs4_file *fp,
> > > > > > return NULL;
> > > > > > }
> > > > > >=20
> > > > > > +void nfs4_unhash_stid(struct nfs4_stid *s)
> > > > > > +{
> > > > > > + if (s->sc_type & NFS4_ALL_ADMIN_REVOKED_STIDS)
> > > > > > + atomic_dec(&s->sc_client->cl_admin_revoked);
> > > > > > + s->sc_type =3D 0;
> > > > > > +}
> > > > > > +
> > > > > > void
> > > > > > nfs4_put_stid(struct nfs4_stid *s)
> > > > > > {
> > > > > > @@ -1215,6 +1222,7 @@ nfs4_put_stid(struct nfs4_stid *s)
> > > > > > return;
> > > > > > }
> > > > > > idr_remove(&clp->cl_stateids, s->sc_stateid.si_opaque.so_id);
> > > > > > + nfs4_unhash_stid(s);
> > > > > > nfs4_free_cpntf_statelist(clp->net, s);
> > > > > > spin_unlock(&clp->cl_lock);
> > > > > > s->sc_free(s);
> > > > > > @@ -1265,11 +1273,6 @@ static void destroy_unhashed_deleg(struc=
t nfs4_delegation *dp)
> > > > > > nfs4_put_stid(&dp->dl_stid);
> > > > > > }
> > > > > >=20
> > > > > > -void nfs4_unhash_stid(struct nfs4_stid *s)
> > > > > > -{
> > > > > > - s->sc_type =3D 0;
> > > > > > -}
> > > > > > -
> > > > > > /**
> > > > > >  * nfs4_delegation_exists - Discover if this delegation already=
 exists
> > > > > >  * @clp:     a pointer to the nfs4_client we're granting a dele=
gation to
> > > > > > @@ -1536,6 +1539,7 @@ static void put_ol_stateid_locked(struct =
nfs4_ol_stateid *stp,
> > > > > > }
> > > > > >=20
> > > > > > idr_remove(&clp->cl_stateids, s->sc_stateid.si_opaque.so_id);
> > > > > > + nfs4_unhash_stid(s);
> > > > > > list_add(&stp->st_locks, reaplist);
> > > > > > }
> > > > > >=20
> > > > > > @@ -1680,6 +1684,53 @@ static void release_openowner(struct nfs=
4_openowner *oo)
> > > > > > nfs4_put_stateowner(&oo->oo_owner);
> > > > > > }
> > > > > >=20
> > > > > > +static struct nfs4_stid *find_one_sb_stid(struct nfs4_client *=
clp,
> > > > > > +   struct super_block *sb,
> > > > > > +   unsigned short sc_types)
> > > > > > +{
> > > > > > + unsigned long id, tmp;
> > > > > > + struct nfs4_stid *stid;
> > > > > > +
> > > > > > + spin_lock(&clp->cl_lock);
> > > > > > + idr_for_each_entry_ul(&clp->cl_stateids, stid, tmp, id)
> > > > > > + if ((stid->sc_type & sc_types) &&
> > > > > > +     stid->sc_file->fi_inode->i_sb =3D=3D sb) {
> > > > > > + refcount_inc(&stid->sc_count);
> > > > > > + break;
> > > > > > + }
> > > > > > + spin_unlock(&clp->cl_lock);
> > > > > > + return stid;
> > > > > > +}
> > > > > > +
> > > > > > +void nfsd4_revoke_states(struct net *net, struct super_block *=
sb)
> > > > > > +{
> > > > > > + struct nfsd_net *nn =3D net_generic(net, nfsd_net_id);
> > > > > > + unsigned int idhashval;
> > > > > > + unsigned short sc_types;
> > > > > > +
> > > > > > + sc_types =3D 0;
> > > > > > +
> > > > > > + spin_lock(&nn->client_lock);
> > > > > > + for (idhashval =3D 0; idhashval < CLIENT_HASH_MASK; idhashval=
++) {
> > > > > > + struct list_head *head =3D &nn->conf_id_hashtbl[idhashval];
> > > > > > + struct nfs4_client *clp;
> > > > > > + retry:
> > > > > > + list_for_each_entry(clp, head, cl_idhash) {
> > > > > > + struct nfs4_stid *stid =3D find_one_sb_stid(clp, sb,
> > > > > > +   sc_types);
> > > > > > + if (stid) {
> > > > > > + spin_unlock(&nn->client_lock);
> > > > > > + switch (stid->sc_type) {
> > > > > > + }
> > > > > > + nfs4_put_stid(stid);
> > > > > > + spin_lock(&nn->client_lock);
> > > > > > + goto retry;
> > > > > > + }
> > > > > > + }
> > > > > > + }
> > > > > > + spin_unlock(&nn->client_lock);
> > > > > > +}
> > > > > > +
> > > > > > static inline int
> > > > > > hash_sessionid(struct nfs4_sessionid *sessionid)
> > > > > > {
> > > > > > @@ -2465,7 +2516,8 @@ find_stateid_locked(struct nfs4_client *c=
l, stateid_t *t)
> > > > > > }
> > > > > >=20
> > > > > > static struct nfs4_stid *
> > > > > > -find_stateid_by_type(struct nfs4_client *cl, stateid_t *t, cha=
r typemask)
> > > > > > +find_stateid_by_type(struct nfs4_client *cl, stateid_t *t,
> > > > > > +      unsigned short typemask)
> > > > > > {
> > > > > > struct nfs4_stid *s;
> > > > > >=20
> > > > > > @@ -2549,6 +2601,8 @@ static int client_info_show(struct seq_fi=
le *m, void *v)
> > > > > > }
> > > > > > seq_printf(m, "callback state: %s\n", cb_state2str(clp->cl_cb_s=
tate));
> > > > > > seq_printf(m, "callback address: %pISpc\n", &clp->cl_cb_conn.cb=
_addr);
> > > > > > + seq_printf(m, "admin-revoked states: %d\n",
> > > > > > +    atomic_read(&clp->cl_admin_revoked));
> > > > > > drop_client(clp);
> > > > > >=20
> > > > > > return 0;
> > > > > > @@ -4108,6 +4162,8 @@ nfsd4_sequence(struct svc_rqst *rqstp, st=
ruct nfsd4_compound_state *cstate,
> > > > > > }
> > > > > > if (!list_empty(&clp->cl_revoked))
> > > > > > seq->status_flags |=3D SEQ4_STATUS_RECALLABLE_STATE_REVOKED;
> > > > > > + if (atomic_read(&clp->cl_admin_revoked))
> > > > > > + seq->status_flags |=3D SEQ4_STATUS_ADMIN_STATE_REVOKED;
> > > > > > out_no_session:
> > > > > > if (conn)
> > > > > > free_conn(conn);
> > > > > > @@ -5200,6 +5256,11 @@ nfs4_check_deleg(struct nfs4_client *cl,=
 struct nfsd4_open *open,
> > > > > > status =3D nfserr_deleg_revoked;
> > > > > > goto out;
> > > > > > }
> > > > > > + if (deleg->dl_stid.sc_type =3D=3D NFS4_ADMIN_REVOKED_DELEG_ST=
ID) {
> > > > > > + nfs4_put_stid(&deleg->dl_stid);
> > > > > > + status =3D nfserr_admin_revoked;
> > > > > > + goto out;
> > > > > > + }
> > > > > > flags =3D share_access_to_flags(open->op_share_access);
> > > > > > status =3D nfs4_check_delegmode(deleg, flags);
> > > > > > if (status) {
> > > > > > @@ -6478,6 +6539,11 @@ static __be32 nfsd4_validate_stateid(str=
uct nfs4_client *cl, stateid_t *stateid)
> > > > > > case NFS4_REVOKED_DELEG_STID:
> > > > > > status =3D nfserr_deleg_revoked;
> > > > > > break;
> > > > > > + case NFS4_ADMIN_REVOKED_STID:
> > > > > > + case NFS4_ADMIN_REVOKED_LOCK_STID:
> > > > > > + case NFS4_ADMIN_REVOKED_DELEG_STID:
> > > > > > + status =3D nfserr_admin_revoked;
> > > > > > + break;
> > > > > > case NFS4_OPEN_STID:
> > > > > > case NFS4_LOCK_STID:
> > > > > > status =3D nfsd4_check_openowner_confirmed(openlockstateid(s));
> > > > > > @@ -6496,7 +6562,7 @@ static __be32 nfsd4_validate_stateid(stru=
ct nfs4_client *cl, stateid_t *stateid)
> > > > > >=20
> > > > > > __be32
> > > > > > nfsd4_lookup_stateid(struct nfsd4_compound_state *cstate,
> > > > > > -      stateid_t *stateid, unsigned char typemask,
> > > > > > +      stateid_t *stateid, unsigned short typemask,
> > > > > >      struct nfs4_stid **s, struct nfsd_net *nn)
> > > > > > {
> > > > > > __be32 status;
> > > > > > @@ -6512,6 +6578,13 @@ nfsd4_lookup_stateid(struct nfsd4_compou=
nd_state *cstate,
> > > > > > else if (typemask & NFS4_DELEG_STID)
> > > > > > typemask |=3D NFS4_REVOKED_DELEG_STID;
> > > > > >=20
> > > > > > + if (typemask & NFS4_OPEN_STID)
> > > > > > + typemask |=3D NFS4_ADMIN_REVOKED_STID;
> > > > > > + if (typemask & NFS4_LOCK_STID)
> > > > > > + typemask |=3D NFS4_ADMIN_REVOKED_LOCK_STID;
> > > > > > + if (typemask & NFS4_DELEG_STID)
> > > > > > + typemask |=3D NFS4_ADMIN_REVOKED_DELEG_STID;
> > > > > > +
> > > > > > if (ZERO_STATEID(stateid) || ONE_STATEID(stateid) ||
> > > > > > CLOSE_STATEID(stateid))
> > > > > > return nfserr_bad_stateid;
> > > > > > @@ -6532,6 +6605,10 @@ nfsd4_lookup_stateid(struct nfsd4_compou=
nd_state *cstate,
> > > > > > return nfserr_deleg_revoked;
> > > > > > return nfserr_bad_stateid;
> > > > > > }
> > > > > > + if (stid->sc_type & NFS4_ALL_ADMIN_REVOKED_STIDS) {
> > > > > > + nfs4_put_stid(stid);
> > > > > > + return nfserr_admin_revoked;
> > > > > > + }
> > > > > > *s =3D stid;
> > > > > > return nfs_ok;
> > > > > > }
> > > > > > @@ -6899,7 +6976,7 @@ static __be32 nfs4_seqid_op_checks(struct=
 nfsd4_compound_state *cstate, stateid_
> > > > > >  */
> > > > > > static __be32
> > > > > > nfs4_preprocess_seqid_op(struct nfsd4_compound_state *cstate, u=
32 seqid,
> > > > > > -  stateid_t *stateid, char typemask,
> > > > > > +  stateid_t *stateid, unsigned short typemask,
> > > > > >  struct nfs4_ol_stateid **stpp,
> > > > > >  struct nfsd_net *nn)
> > > > > > {
> > > > > > diff --git a/fs/nfsd/nfsctl.c b/fs/nfsd/nfsctl.c
> > > > > > index 739ed5bf71cd..50368eec86b0 100644
> > > > > > --- a/fs/nfsd/nfsctl.c
> > > > > > +++ b/fs/nfsd/nfsctl.c
> > > > > > @@ -281,6 +281,7 @@ static ssize_t write_unlock_fs(struct file =
*file, char *buf, size_t size)
> > > > > >  * 3.  Is that directory the root of an exported file system?
> > > > > >  */
> > > > > > error =3D nlmsvc_unlock_all_by_sb(path.dentry->d_sb);
> > > > > > + nfsd4_revoke_states(netns(file), path.dentry->d_sb);
> > > > > >=20
> > > > > > path_put(&path);
> > > > > > return error;
> > > > > > diff --git a/fs/nfsd/nfsd.h b/fs/nfsd/nfsd.h
> > > > > > index f5ff42f41ee7..d46203eac3c8 100644
> > > > > > --- a/fs/nfsd/nfsd.h
> > > > > > +++ b/fs/nfsd/nfsd.h
> > > > > > @@ -280,6 +280,7 @@ void nfsd_lockd_shutdown(void);
> > > > > > #define nfserr_no_grace cpu_to_be32(NFSERR_NO_GRACE)
> > > > > > #define nfserr_reclaim_bad cpu_to_be32(NFSERR_RECLAIM_BAD)
> > > > > > #define nfserr_badname cpu_to_be32(NFSERR_BADNAME)
> > > > > > +#define nfserr_admin_revoked cpu_to_be32(NFS4ERR_ADMIN_REVOKED=
)
> > > > > > #define nfserr_cb_path_down cpu_to_be32(NFSERR_CB_PATH_DOWN)
> > > > > > #define nfserr_locked cpu_to_be32(NFSERR_LOCKED)
> > > > > > #define nfserr_wrongsec cpu_to_be32(NFSERR_WRONGSEC)
> > > > > > diff --git a/fs/nfsd/state.h b/fs/nfsd/state.h
> > > > > > index f96eaa8e9413..3af5ab55c978 100644
> > > > > > --- a/fs/nfsd/state.h
> > > > > > +++ b/fs/nfsd/state.h
> > > > > > @@ -88,17 +88,23 @@ struct nfsd4_callback_ops {
> > > > > >  */
> > > > > > struct nfs4_stid {
> > > > > > refcount_t sc_count;
> > > > > > -#define NFS4_OPEN_STID 1
> > > > > > -#define NFS4_LOCK_STID 2
> > > > > > -#define NFS4_DELEG_STID 4
> > > > > > + struct list_head sc_cp_list;
> > > > > > + unsigned short sc_type;
> > > > >=20
> > > > > Should we just go ahead and make this a full 32-bit word? We seem=
 to
> > > > > keep adding flags to this field, and I doubt we're saving anythin=
g by
> > > > > making this a short.
> > > > >=20
> > > > > > +#define NFS4_OPEN_STID BIT(0)
> > > > > > +#define NFS4_LOCK_STID BIT(1)
> > > > > > +#define NFS4_DELEG_STID BIT(2)
> > > > > > /* For an open stateid kept around *only* to process close repl=
ays: */
> > > > > > -#define NFS4_CLOSED_STID 8
> > > > > > +#define NFS4_CLOSED_STID BIT(3)
> > > > > > /* For a deleg stateid kept around only to process free_stateid=
's: */
> > > > > > -#define NFS4_REVOKED_DELEG_STID 16
> > > > > > -#define NFS4_CLOSED_DELEG_STID 32
> > > > > > -#define NFS4_LAYOUT_STID 64
> > > > > > - struct list_head sc_cp_list;
> > > > > > - unsigned char sc_type;
> > > > > > +#define NFS4_REVOKED_DELEG_STID BIT(4)
> > > > > > +#define NFS4_CLOSED_DELEG_STID BIT(5)
> > > > > > +#define NFS4_LAYOUT_STID BIT(6)
> > > > > > +#define NFS4_ADMIN_REVOKED_STID BIT(7)
> > > > > > +#define NFS4_ADMIN_REVOKED_LOCK_STID BIT(8)
> > > > > > +#define NFS4_ADMIN_REVOKED_DELEG_STID BIT(9)
> > > > > > +#define NFS4_ALL_ADMIN_REVOKED_STIDS (NFS4_ADMIN_REVOKED_STID =
| \
> > > > > > +      NFS4_ADMIN_REVOKED_LOCK_STID | \
> > > > > > +      NFS4_ADMIN_REVOKED_DELEG_STID)
> > > > >=20
> > > > > Not a specific criticism of these patches, since this problem pre=
exists
> > > > > them, but I really dislike the way that sc_type is used as a bitm=
ask,
> > > > > but also sort of like an enum. In some cases, we test for specifi=
c flags
> > > > > in the mask, and in other cases (e.g. states_show), we treat them=
 as
> > > > > discrete values to feed it to a switch().
> > > > >=20
> > > > > Personally, I'd find this less confusing if we just treat this as=
 a set
> > > > > of flags full-stop. We could leave the low-order bits to show the=
 real
> > > > > type (open, lock, deleg, etc.) and just mask off the high-order b=
its
> > > > > when we need to feed it to a switch statement.
> > > > >=20
> > > > > For instance above, we're adding 3 new NFS4_ADMIN_REVOKED values,=
 but we
> > > > > could (in theory) just have a flag in there that says NFS4_ADMIN_=
REVOKED
> > > > > and leave the old type bit in place instead of changing it to a n=
ew
> > > > > discrete sc_type value.
> > > >=20
> > > > I agree.
> > > > Bits might be:
> > > >    OPEN
> > > >    LOCK
> > > >    DELEG
> > > >    LAYOUT
> > > >    CLOSED (combines with OPEN or DELEG)
> > > >    REVOKED (combines with DELEG)
> > > >    ADMIN_REVOKED (combined with OPEN, LOCK, DELEG.  Sets REVOKED wh=
en
> > > >                   with DELEG)
> > > >=20
> > > > so we could go back to a char :-)  Probably sensible to use unsigne=
d int
> > > > though.
> > > >=20
> > >=20
> > > Yeah, a u32 would be best I think. It'll just fill an existing hole o=
n
> > > my box (x86_64), according to pahole:
> > >=20
> > > unsigned char              sc_type;              /*    24     1 */
> > >=20
> > > /* XXX 3 bytes hole, try to pack */
> > >=20
> > > > For updates the rule would be that bits can be set but never cleare=
d so
> > > > you don't need locking to read unless you care about a bit that can=
 be
> > > > changed.
> > > >=20
> > >=20
> > > Probably for the low order OPEN/LOCK/DELEG bits, the rule should be t=
hat
> > > they never change. We can never convert from one to another since the=
y
> > > come out of different slabcaches. It's probably worthwhile to leave a
> > > few low order bits carved out for new types in the future too. e.g.
> > > directory delegations...
> > >=20
> > > Maybe we should rename the field too? How about "sc_mode" since this =
is
> > > starting to resemble the i_mode field in some ways (type and permissi=
ons
> > > squashed together).
> >=20
> > In that case, two separate u16 fields might be better.
> >=20
>=20
> Here is a first attempt.  It compiles but I haven't tried running or
> thought about what testing would be appropriate.
> I'll be working on other things next week but I hope to pick this up
> again the following week and process any feedback, then see how my
> admin-revoke patch set fits on this new code.
>=20
> All comments most welcome.
>=20
> Thanks,
> NeilBrown
>=20
>=20
> From: NeilBrown <neilb@suse.de>
> Date: Fri, 3 Nov 2023 11:43:55 +1100
> Subject: [PATCH] nfsd: tidy up sc_type
>=20
> sc_type identifies the type of a state - open, lock, deleg, layout - and
> also the status of a state - closed or revoked.
>=20
> This is a bit untidy and could get worse when "admin-revoked" states are
> added.  So try to clean it up.
>=20
> The type is now all that is stored in sc_type.  This is zero when the
> state is first added to the idr (causing it to be ignored), and if then
> set appropriately once it is fully initialised.  It is set under
> ->cl_lock to ensure atomicity w.r.t lookup.  It is (now) never cleared.
>=20
> This is still a bit-set even though at most one bit is set.  This allows
> lookup functions to be given a bitmap of acceptable types.
>=20
> cl_type is now an unsigned short rather than char.  There is no value in
> restricting to just 8 bits.
>=20
> The status is stored in a separate short named "cl_status".  It has two
> flags: NFS4_STID_CLOSED and NFS4_STID_REVOKED.
> CLOSED combines NFS4_CLOSED_STID, NFS4_CLOSED_DELEG_STID, and is used
> for LOCK_STID instead of setting the sc_type to zero.
> These flags are only ever set, never cleared.
> For deleg stateids they are set under the global state_lock.
> For open and lock stateids they are set under ->cl_lock.
>=20
> Other changes here - some of which could be split out...
>=20
> - When a delegation is revoked, the type was previously set to
>    NFS4_CLOSED_DELEG_STID and then NFS4_REVOKED_DELEG_STID.
>   This might open a race window.  That window no longer exists.
>=20
> - NFS4_STID_REVOKED (previously NFS4_REVOKED_DELEG_STID) is only set
>   for ->minorversion>0, so I removed all the tests on minorversion when
>   that status has been detected.
>=20
> - nfs4_unhash_stid() has been removed, and we never set sc_type =3D 0.
>   This was only used for LOCK stids and they now use NFS4_STID_CLOSED
>=20
> - ->cl_lock is now hel when hash_delegation_locked() is called, so
>   that the locking rules for setting ->sc_type are followed.
>=20
> Signed-off-by: NeilBrown <neilb@suse.de>
> ---
>  fs/nfsd/nfs4layouts.c |   4 +-
>  fs/nfsd/nfs4state.c   | 165 ++++++++++++++++++++----------------------
>  fs/nfsd/state.h       |  37 +++++++---
>  fs/nfsd/trace.h       |  25 +++----
>  4 files changed, 119 insertions(+), 112 deletions(-)
>=20
> diff --git a/fs/nfsd/nfs4layouts.c b/fs/nfsd/nfs4layouts.c
> index 5e8096bc5eaa..678bef3a7f15 100644
> --- a/fs/nfsd/nfs4layouts.c
> +++ b/fs/nfsd/nfs4layouts.c
> @@ -269,13 +269,13 @@ nfsd4_preprocess_layout_stateid(struct svc_rqst *rq=
stp,
>  {
>  	struct nfs4_layout_stateid *ls;
>  	struct nfs4_stid *stid;
> -	unsigned char typemask =3D NFS4_LAYOUT_STID;
> +	unsigned short typemask =3D NFS4_LAYOUT_STID;
>  	__be32 status;
> =20
>  	if (create)
>  		typemask |=3D (NFS4_OPEN_STID | NFS4_LOCK_STID | NFS4_DELEG_STID);
> =20
> -	status =3D nfsd4_lookup_stateid(cstate, stateid, typemask, &stid,
> +	status =3D nfsd4_lookup_stateid(cstate, stateid, typemask, 0, &stid,
>  			net_generic(SVC_NET(rqstp), nfsd_net_id));
>  	if (status)
>  		goto out;
> diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
> index 65fd5510323a..551a86a796ed 100644
> --- a/fs/nfsd/nfs4state.c
> +++ b/fs/nfsd/nfs4state.c
> @@ -1265,11 +1265,6 @@ static void destroy_unhashed_deleg(struct nfs4_del=
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
> @@ -1317,6 +1312,7 @@ hash_delegation_locked(struct nfs4_delegation *dp, =
struct nfs4_file *fp)
> =20
>  	lockdep_assert_held(&state_lock);
>  	lockdep_assert_held(&fp->fi_lock);
> +	lockdep_assert_held(&clp->cl_lock);
> =20
>  	if (nfs4_delegation_exists(clp, fp))
>  		return -EAGAIN;
> @@ -1333,7 +1329,7 @@ static bool delegation_hashed(struct nfs4_delegatio=
n *dp)
>  }
> =20
>  static bool
> -unhash_delegation_locked(struct nfs4_delegation *dp)
> +unhash_delegation_locked(struct nfs4_delegation *dp, unsigned short stat=
e)
>  {
>  	struct nfs4_file *fp =3D dp->dl_stid.sc_file;
> =20
> @@ -1342,7 +1338,10 @@ unhash_delegation_locked(struct nfs4_delegation *d=
p)
>  	if (!delegation_hashed(dp))
>  		return false;
> =20
> -	dp->dl_stid.sc_type =3D NFS4_CLOSED_DELEG_STID;
> +	if (dp->dl_stid.sc_client->cl_minorversion =3D=3D 0)
> +		state =3D NFS4_STID_CLOSED;
> +	dp->dl_stid.sc_status |=3D state | NFS4_STID_CLOSED;
> +
>  	/* Ensure that deleg break won't try to requeue it */
>  	++dp->dl_time;
>  	spin_lock(&fp->fi_lock);
> @@ -1358,7 +1357,7 @@ static void destroy_delegation(struct nfs4_delegati=
on *dp)
>  	bool unhashed;
> =20
>  	spin_lock(&state_lock);
> -	unhashed =3D unhash_delegation_locked(dp);
> +	unhashed =3D unhash_delegation_locked(dp, NFS4_STID_CLOSED);
>  	spin_unlock(&state_lock);
>  	if (unhashed)
>  		destroy_unhashed_deleg(dp);
> @@ -1372,9 +1371,8 @@ static void revoke_delegation(struct nfs4_delegatio=
n *dp)
> =20
>  	trace_nfsd_stid_revoke(&dp->dl_stid);
> =20
> -	if (clp->cl_minorversion) {
> +	if (dp->dl_stid.sc_status & NFS4_STID_REVOKED) {
>  		spin_lock(&clp->cl_lock);
> -		dp->dl_stid.sc_type =3D NFS4_REVOKED_DELEG_STID;
>  		refcount_inc(&dp->dl_stid.sc_count);
>  		list_add(&dp->dl_recall_lru, &clp->cl_revoked);
>  		spin_unlock(&clp->cl_lock);
> @@ -1382,8 +1380,8 @@ static void revoke_delegation(struct nfs4_delegatio=
n *dp)
>  	destroy_unhashed_deleg(dp);
>  }
> =20
> -/*=20
> - * SETCLIENTID state=20
> +/*
> + * SETCLIENTID state
>   */
> =20
>  static unsigned int clientid_hashval(u32 id)
> @@ -1546,7 +1544,6 @@ static bool unhash_lock_stateid(struct nfs4_ol_stat=
eid *stp)
>  	if (!unhash_ol_stateid(stp))
>  		return false;
>  	list_del_init(&stp->st_locks);
> -	nfs4_unhash_stid(&stp->st_stid);
>  	return true;
>  }
> =20
> @@ -1557,6 +1554,7 @@ static void release_lock_stateid(struct nfs4_ol_sta=
teid *stp)
> =20
>  	spin_lock(&clp->cl_lock);
>  	unhashed =3D unhash_lock_stateid(stp);
> +	stp->st_stid.sc_status |=3D NFS4_STID_CLOSED;
>  	spin_unlock(&clp->cl_lock);
>  	if (unhashed)
>  		nfs4_put_stid(&stp->st_stid);
> @@ -1625,6 +1623,7 @@ static void release_open_stateid(struct nfs4_ol_sta=
teid *stp)
>  	LIST_HEAD(reaplist);
> =20
>  	spin_lock(&stp->st_stid.sc_client->cl_lock);
> +	stp->st_stid.sc_status |=3D NFS4_STID_CLOSED;
>  	if (unhash_open_stateid(stp, &reaplist))
>  		put_ol_stateid_locked(stp, &reaplist);
>  	spin_unlock(&stp->st_stid.sc_client->cl_lock);
> @@ -2233,7 +2232,7 @@ __destroy_client(struct nfs4_client *clp)
>  	spin_lock(&state_lock);
>  	while (!list_empty(&clp->cl_delegations)) {
>  		dp =3D list_entry(clp->cl_delegations.next, struct nfs4_delegation, dl=
_perclnt);
> -		WARN_ON(!unhash_delegation_locked(dp));
> +		WARN_ON(!unhash_delegation_locked(dp, NFS4_STID_CLOSED));
>  		list_add(&dp->dl_recall_lru, &reaplist);
>  	}
>  	spin_unlock(&state_lock);
> @@ -2465,14 +2464,16 @@ find_stateid_locked(struct nfs4_client *cl, state=
id_t *t)
>  }
> =20
>  static struct nfs4_stid *
> -find_stateid_by_type(struct nfs4_client *cl, stateid_t *t, char typemask=
)
> +find_stateid_by_type(struct nfs4_client *cl, stateid_t *t,
> +		     unsigned short typemask, unsigned short ok_states)
>  {
>  	struct nfs4_stid *s;
> =20
>  	spin_lock(&cl->cl_lock);
>  	s =3D find_stateid_locked(cl, t);
>  	if (s !=3D NULL) {
> -		if (typemask & s->sc_type)
> +		if ((s->sc_status & ~ok_states) =3D=3D 0 &&
> +		    (typemask & s->sc_type))
>  			refcount_inc(&s->sc_count);
>  		else
>  			s =3D NULL;
> @@ -4582,7 +4583,8 @@ nfsd4_find_existing_open(struct nfs4_file *fp, stru=
ct nfsd4_open *open)
>  			continue;
>  		if (local->st_stateowner !=3D &oo->oo_owner)
>  			continue;
> -		if (local->st_stid.sc_type =3D=3D NFS4_OPEN_STID) {
> +		if (local->st_stid.sc_type =3D=3D NFS4_OPEN_STID &&
> +		    !(local->st_stid.sc_status & NFS4_STID_CLOSED)) {
>  			ret =3D local;
>  			refcount_inc(&ret->st_stid.sc_count);
>  			break;
> @@ -4596,17 +4598,10 @@ nfsd4_verify_open_stid(struct nfs4_stid *s)
>  {
>  	__be32 ret =3D nfs_ok;
> =20
> -	switch (s->sc_type) {
> -	default:
> -		break;
> -	case 0:
> -	case NFS4_CLOSED_STID:
> -	case NFS4_CLOSED_DELEG_STID:
> -		ret =3D nfserr_bad_stateid;
> -		break;
> -	case NFS4_REVOKED_DELEG_STID:
> +	if (s->sc_status & NFS4_STID_REVOKED)
>  		ret =3D nfserr_deleg_revoked;
> -	}
> +	else if (s->sc_status & NFS4_STID_CLOSED)
> +		ret =3D nfserr_bad_stateid;
>  	return ret;
>  }
> =20
> @@ -4919,9 +4914,9 @@ static int nfsd4_cb_recall_done(struct nfsd4_callba=
ck *cb,
> =20
>  	trace_nfsd_cb_recall_done(&dp->dl_stid.sc_stateid, task);
> =20
> -	if (dp->dl_stid.sc_type =3D=3D NFS4_CLOSED_DELEG_STID ||
> -	    dp->dl_stid.sc_type =3D=3D NFS4_REVOKED_DELEG_STID)
> -	        return 1;
> +	if (dp->dl_stid.sc_status)
> +		/* CLOSED or REVOKED */
> +		return 1;
> =20
>  	switch (task->tk_status) {
>  	case 0:
> @@ -5170,8 +5165,7 @@ static struct nfs4_delegation *find_deleg_stateid(s=
truct nfs4_client *cl, statei
>  {
>  	struct nfs4_stid *ret;
> =20
> -	ret =3D find_stateid_by_type(cl, s,
> -				NFS4_DELEG_STID|NFS4_REVOKED_DELEG_STID);
> +	ret =3D find_stateid_by_type(cl, s, NFS4_DELEG_STID, 0);
>  	if (!ret)
>  		return NULL;
>  	return delegstateid(ret);
> @@ -5194,10 +5188,9 @@ nfs4_check_deleg(struct nfs4_client *cl, struct nf=
sd4_open *open,
>  	deleg =3D find_deleg_stateid(cl, &open->op_delegate_stateid);
>  	if (deleg =3D=3D NULL)
>  		goto out;
> -	if (deleg->dl_stid.sc_type =3D=3D NFS4_REVOKED_DELEG_STID) {
> +	if (deleg->dl_stid.sc_status & NFS4_STID_REVOKED) {
>  		nfs4_put_stid(&deleg->dl_stid);
> -		if (cl->cl_minorversion)
> -			status =3D nfserr_deleg_revoked;
> +		status =3D nfserr_deleg_revoked;
>  		goto out;
>  	}
>  	flags =3D share_access_to_flags(open->op_share_access);
> @@ -5609,12 +5602,14 @@ nfs4_set_delegation(struct nfsd4_open *open, stru=
ct nfs4_ol_stateid *stp,
>  		goto out_unlock;
> =20
>  	spin_lock(&state_lock);
> +	spin_lock(&clp->cl_lock);
>  	spin_lock(&fp->fi_lock);
>  	if (fp->fi_had_conflict)
>  		status =3D -EAGAIN;
>  	else
>  		status =3D hash_delegation_locked(dp, fp);
>  	spin_unlock(&fp->fi_lock);
> +	spin_unlock(&clp->cl_lock);
>  	spin_unlock(&state_lock);
> =20
>  	if (status)
> @@ -5840,7 +5835,6 @@ nfsd4_process_open2(struct svc_rqst *rqstp, struct =
svc_fh *current_fh, struct nf
>  	} else {
>  		status =3D nfs4_get_vfs_file(rqstp, fp, current_fh, stp, open, true);
>  		if (status) {
> -			stp->st_stid.sc_type =3D NFS4_CLOSED_STID;
>  			release_open_stateid(stp);
>  			mutex_unlock(&stp->st_mutex);
>  			goto out;
> @@ -6232,7 +6226,7 @@ nfs4_laundromat(struct nfsd_net *nn)
>  		dp =3D list_entry (pos, struct nfs4_delegation, dl_recall_lru);
>  		if (!state_expired(&lt, dp->dl_time))
>  			break;
> -		WARN_ON(!unhash_delegation_locked(dp));
> +		WARN_ON(!unhash_delegation_locked(dp, NFS4_STID_REVOKED));
>  		list_add(&dp->dl_recall_lru, &reaplist);
>  	}
>  	spin_unlock(&state_lock);
> @@ -6471,22 +6465,20 @@ static __be32 nfsd4_validate_stateid(struct nfs4_=
client *cl, stateid_t *stateid)
>  	status =3D nfsd4_stid_check_stateid_generation(stateid, s, 1);
>  	if (status)
>  		goto out_unlock;
> +	status =3D nfsd4_verify_open_stid(s);
> +	if (status)
> +		goto out_unlock;
> +
>  	switch (s->sc_type) {
>  	case NFS4_DELEG_STID:
>  		status =3D nfs_ok;
>  		break;
> -	case NFS4_REVOKED_DELEG_STID:
> -		status =3D nfserr_deleg_revoked;
> -		break;
>  	case NFS4_OPEN_STID:
>  	case NFS4_LOCK_STID:
>  		status =3D nfsd4_check_openowner_confirmed(openlockstateid(s));
>  		break;
>  	default:
>  		printk("unknown stateid type %x\n", s->sc_type);
> -		fallthrough;
> -	case NFS4_CLOSED_STID:
> -	case NFS4_CLOSED_DELEG_STID:
>  		status =3D nfserr_bad_stateid;
>  	}
>  out_unlock:
> @@ -6496,7 +6488,8 @@ static __be32 nfsd4_validate_stateid(struct nfs4_cl=
ient *cl, stateid_t *stateid)
> =20
>  __be32
>  nfsd4_lookup_stateid(struct nfsd4_compound_state *cstate,
> -		     stateid_t *stateid, unsigned char typemask,
> +		     stateid_t *stateid,
> +		     unsigned short typemask, unsigned short statemask,
>  		     struct nfs4_stid **s, struct nfsd_net *nn)
>  {
>  	__be32 status;
> @@ -6507,10 +6500,8 @@ nfsd4_lookup_stateid(struct nfsd4_compound_state *=
cstate,
>  	 *  only return revoked delegations if explicitly asked.
>  	 *  otherwise we report revoked or bad_stateid status.
>  	 */
> -	if (typemask & NFS4_REVOKED_DELEG_STID)
> +	if (statemask & NFS4_STID_REVOKED)
>  		return_revoked =3D true;
> -	else if (typemask & NFS4_DELEG_STID)
> -		typemask |=3D NFS4_REVOKED_DELEG_STID;
> =20
>  	if (ZERO_STATEID(stateid) || ONE_STATEID(stateid) ||
>  		CLOSE_STATEID(stateid))
> @@ -6523,14 +6514,13 @@ nfsd4_lookup_stateid(struct nfsd4_compound_state =
*cstate,
>  	}
>  	if (status)
>  		return status;
> -	stid =3D find_stateid_by_type(cstate->clp, stateid, typemask);
> +	stid =3D find_stateid_by_type(cstate->clp, stateid,
> +				    typemask, statemask & NFS4_STID_CLOSED);
>  	if (!stid)
>  		return nfserr_bad_stateid;
> -	if ((stid->sc_type =3D=3D NFS4_REVOKED_DELEG_STID) && !return_revoked) =
{
> +	if ((stid->sc_status & NFS4_STID_REVOKED) && !return_revoked) {
>  		nfs4_put_stid(stid);
> -		if (cstate->minorversion)
> -			return nfserr_deleg_revoked;
> -		return nfserr_bad_stateid;
> +		return nfserr_deleg_revoked;
>  	}
>  	*s =3D stid;
>  	return nfs_ok;
> @@ -6541,7 +6531,7 @@ nfs4_find_file(struct nfs4_stid *s, int flags)
>  {
>  	struct nfsd_file *ret =3D NULL;
> =20
> -	if (!s)
> +	if (!s || s->sc_status)
>  		return NULL;
> =20
>  	switch (s->sc_type) {
> @@ -6664,7 +6654,8 @@ static __be32 find_cpntf_state(struct nfsd_net *nn,=
 stateid_t *st,
>  		goto out;
> =20
>  	*stid =3D find_stateid_by_type(found, &cps->cp_p_stateid,
> -			NFS4_DELEG_STID|NFS4_OPEN_STID|NFS4_LOCK_STID);
> +				     NFS4_DELEG_STID|NFS4_OPEN_STID|NFS4_LOCK_STID,
> +				     0);
>  	if (*stid)
>  		status =3D nfs_ok;
>  	else
> @@ -6722,7 +6713,7 @@ nfs4_preprocess_stateid_op(struct svc_rqst *rqstp,
> =20
>  	status =3D nfsd4_lookup_stateid(cstate, stateid,
>  				NFS4_DELEG_STID|NFS4_OPEN_STID|NFS4_LOCK_STID,
> -				&s, nn);
> +				0, &s, nn);
>  	if (status =3D=3D nfserr_bad_stateid)
>  		status =3D find_cpntf_state(nn, stateid, &s);
>  	if (status)
> @@ -6740,9 +6731,6 @@ nfs4_preprocess_stateid_op(struct svc_rqst *rqstp,
>  	case NFS4_LOCK_STID:
>  		status =3D nfs4_check_olstateid(openlockstateid(s), flags);
>  		break;
> -	default:
> -		status =3D nfserr_bad_stateid;
> -		break;
>  	}
>  	if (status)
>  		goto out;
> @@ -6821,11 +6809,20 @@ nfsd4_free_stateid(struct svc_rqst *rqstp, struct=
 nfsd4_compound_state *cstate,
> =20
>  	spin_lock(&cl->cl_lock);
>  	s =3D find_stateid_locked(cl, stateid);
> -	if (!s)
> +	if (!s || s->sc_status & NFS4_STID_CLOSED)
>  		goto out_unlock;
>  	spin_lock(&s->sc_lock);
>  	switch (s->sc_type) {
>  	case NFS4_DELEG_STID:
> +		if (s->sc_status & NFS4_STID_REVOKED) {
> +			spin_unlock(&s->sc_lock);
> +			dp =3D delegstateid(s);
> +			list_del_init(&dp->dl_recall_lru);
> +			spin_unlock(&cl->cl_lock);
> +			nfs4_put_stid(s);
> +			ret =3D nfs_ok;
> +			goto out;
> +		}
>  		ret =3D nfserr_locks_held;
>  		break;
>  	case NFS4_OPEN_STID:
> @@ -6840,14 +6837,6 @@ nfsd4_free_stateid(struct svc_rqst *rqstp, struct =
nfsd4_compound_state *cstate,
>  		spin_unlock(&cl->cl_lock);
>  		ret =3D nfsd4_free_lock_stateid(stateid, s);
>  		goto out;
> -	case NFS4_REVOKED_DELEG_STID:
> -		spin_unlock(&s->sc_lock);
> -		dp =3D delegstateid(s);
> -		list_del_init(&dp->dl_recall_lru);
> -		spin_unlock(&cl->cl_lock);
> -		nfs4_put_stid(s);
> -		ret =3D nfs_ok;
> -		goto out;
>  	/* Default falls through and returns nfserr_bad_stateid */
>  	}
>  	spin_unlock(&s->sc_lock);
> @@ -6890,6 +6879,7 @@ static __be32 nfs4_seqid_op_checks(struct nfsd4_com=
pound_state *cstate, stateid_
>   * @seqid: seqid (provided by client)
>   * @stateid: stateid (provided by client)
>   * @typemask: mask of allowable types for this operation
> + * @statemask: mask of allowed states: 0 or STID_CLOSED
>   * @stpp: return pointer for the stateid found
>   * @nn: net namespace for request
>   *
> @@ -6899,7 +6889,8 @@ static __be32 nfs4_seqid_op_checks(struct nfsd4_com=
pound_state *cstate, stateid_
>   */
>  static __be32
>  nfs4_preprocess_seqid_op(struct nfsd4_compound_state *cstate, u32 seqid,
> -			 stateid_t *stateid, char typemask,
> +			 stateid_t *stateid,
> +			 unsigned short typemask, unsigned short statemask,
>  			 struct nfs4_ol_stateid **stpp,
>  			 struct nfsd_net *nn)
>  {
> @@ -6910,7 +6901,8 @@ nfs4_preprocess_seqid_op(struct nfsd4_compound_stat=
e *cstate, u32 seqid,
>  	trace_nfsd_preprocess(seqid, stateid);
> =20
>  	*stpp =3D NULL;
> -	status =3D nfsd4_lookup_stateid(cstate, stateid, typemask, &s, nn);
> +	status =3D nfsd4_lookup_stateid(cstate, stateid,
> +				      typemask, statemask, &s, nn);
>  	if (status)
>  		return status;
>  	stp =3D openlockstateid(s);
> @@ -6932,7 +6924,7 @@ static __be32 nfs4_preprocess_confirmed_seqid_op(st=
ruct nfsd4_compound_state *cs
>  	struct nfs4_ol_stateid *stp;
> =20
>  	status =3D nfs4_preprocess_seqid_op(cstate, seqid, stateid,
> -						NFS4_OPEN_STID, &stp, nn);
> +					  NFS4_OPEN_STID, 0, &stp, nn);
>  	if (status)
>  		return status;
>  	oo =3D openowner(stp->st_stateowner);
> @@ -6963,8 +6955,8 @@ nfsd4_open_confirm(struct svc_rqst *rqstp, struct n=
fsd4_compound_state *cstate,
>  		return status;
> =20
>  	status =3D nfs4_preprocess_seqid_op(cstate,
> -					oc->oc_seqid, &oc->oc_req_stateid,
> -					NFS4_OPEN_STID, &stp, nn);
> +					  oc->oc_seqid, &oc->oc_req_stateid,
> +					  NFS4_OPEN_STID, 0, &stp, nn);
>  	if (status)
>  		goto out;
>  	oo =3D openowner(stp->st_stateowner);
> @@ -7094,18 +7086,20 @@ nfsd4_close(struct svc_rqst *rqstp, struct nfsd4_=
compound_state *cstate,
>  	struct net *net =3D SVC_NET(rqstp);
>  	struct nfsd_net *nn =3D net_generic(net, nfsd_net_id);
> =20
> -	dprintk("NFSD: nfsd4_close on file %pd\n",=20
> +	dprintk("NFSD: nfsd4_close on file %pd\n",
>  			cstate->current_fh.fh_dentry);
> =20
>  	status =3D nfs4_preprocess_seqid_op(cstate, close->cl_seqid,
> -					&close->cl_stateid,
> -					NFS4_OPEN_STID|NFS4_CLOSED_STID,
> -					&stp, nn);
> +					  &close->cl_stateid,
> +					  NFS4_OPEN_STID, NFS4_STID_CLOSED,
> +					  &stp, nn);
>  	nfsd4_bump_seqid(cstate, status);
>  	if (status)
> -		goto out;=20
> +		goto out;
> =20
> -	stp->st_stid.sc_type =3D NFS4_CLOSED_STID;
> +	spin_lock(&stp->st_stid.sc_client->cl_lock);
> +	stp->st_stid.sc_status |=3D NFS4_STID_CLOSED;
> +	spin_unlock(&stp->st_stid.sc_client->cl_lock);
> =20
>  	/*
>  	 * Technically we don't _really_ have to increment or copy it, since
> @@ -7147,7 +7141,7 @@ nfsd4_delegreturn(struct svc_rqst *rqstp, struct nf=
sd4_compound_state *cstate,
>  	if ((status =3D fh_verify(rqstp, &cstate->current_fh, S_IFREG, 0)))
>  		return status;
> =20
> -	status =3D nfsd4_lookup_stateid(cstate, stateid, NFS4_DELEG_STID, &s, n=
n);
> +	status =3D nfsd4_lookup_stateid(cstate, stateid, NFS4_DELEG_STID, 0, &s=
, nn);
>  	if (status)
>  		goto out;
>  	dp =3D delegstateid(s);
> @@ -7601,9 +7595,10 @@ nfsd4_lock(struct svc_rqst *rqstp, struct nfsd4_co=
mpound_state *cstate,
>  							&lock_stp, &new);
>  	} else {
>  		status =3D nfs4_preprocess_seqid_op(cstate,
> -				       lock->lk_old_lock_seqid,
> -				       &lock->lk_old_lock_stateid,
> -				       NFS4_LOCK_STID, &lock_stp, nn);
> +						  lock->lk_old_lock_seqid,
> +						  &lock->lk_old_lock_stateid,
> +						  NFS4_LOCK_STID, 0, &lock_stp,
> +						  nn);
>  	}
>  	if (status)
>  		goto out;
> @@ -7916,8 +7911,8 @@ nfsd4_locku(struct svc_rqst *rqstp, struct nfsd4_co=
mpound_state *cstate,
>  		 return nfserr_inval;
> =20
>  	status =3D nfs4_preprocess_seqid_op(cstate, locku->lu_seqid,
> -					&locku->lu_stateid, NFS4_LOCK_STID,
> -					&stp, nn);
> +					  &locku->lu_stateid, NFS4_LOCK_STID, 0,
> +					  &stp, nn);
>  	if (status)
>  		goto out;
>  	nf =3D find_any_file(stp->st_stid.sc_file);
> @@ -8347,7 +8342,7 @@ nfs4_state_shutdown_net(struct net *net)
>  	spin_lock(&state_lock);
>  	list_for_each_safe(pos, next, &nn->del_recall_lru) {
>  		dp =3D list_entry (pos, struct nfs4_delegation, dl_recall_lru);
> -		WARN_ON(!unhash_delegation_locked(dp));
> +		WARN_ON(!unhash_delegation_locked(dp, NFS4_STID_CLOSED));
>  		list_add(&dp->dl_recall_lru, &reaplist);
>  	}
>  	spin_unlock(&state_lock);
> diff --git a/fs/nfsd/state.h b/fs/nfsd/state.h
> index f96eaa8e9413..cf89fb6be9e1 100644
> --- a/fs/nfsd/state.h
> +++ b/fs/nfsd/state.h
> @@ -88,17 +88,31 @@ struct nfsd4_callback_ops {
>   */
>  struct nfs4_stid {
>  	refcount_t		sc_count;
> -#define NFS4_OPEN_STID 1
> -#define NFS4_LOCK_STID 2
> -#define NFS4_DELEG_STID 4
> -/* For an open stateid kept around *only* to process close replays: */
> -#define NFS4_CLOSED_STID 8
> +
> +	/* A new stateid is added to the idr early before it is
> +	 * fully initialised.  Its sc_type is then zero.
> +	 * After initialisation the sc_type it set under cl_lock,
> +	 * and then never changes.
> +	 */
> +#define NFS4_OPEN_STID		BIT(0)
> +#define NFS4_LOCK_STID		BIT(1)
> +#define NFS4_DELEG_STID		BIT(2)
> +#define NFS4_LAYOUT_STID	BIT(3)
> +	unsigned short		sc_type;
> +/* state_lock protects sc_status for delegation stateids.
> + * ->cl_lock protects sc_status for open and lock stateids.
> + * ->st_mutex also protect sc_status for open stateids.
> + */
> +/*
> + * For an open stateid kept around *only* to process close replays.
> + * For deleg stateid, kept in idr until last reference is dropped.
> + */
> +#define NFS4_STID_CLOSED	BIT(0)
>  /* For a deleg stateid kept around only to process free_stateid's: */
> -#define NFS4_REVOKED_DELEG_STID 16
> -#define NFS4_CLOSED_DELEG_STID 32
> -#define NFS4_LAYOUT_STID 64
> +#define NFS4_STID_REVOKED	BIT(1)
> +	unsigned short		sc_status;
> +
>  	struct list_head	sc_cp_list;
> -	unsigned char		sc_type;
>  	stateid_t		sc_stateid;
>  	spinlock_t		sc_lock;
>  	struct nfs4_client	*sc_client;
> @@ -694,8 +708,9 @@ extern __be32 nfs4_preprocess_stateid_op(struct svc_r=
qst *rqstp,
>  		stateid_t *stateid, int flags, struct nfsd_file **filp,
>  		struct nfs4_stid **cstid);
>  __be32 nfsd4_lookup_stateid(struct nfsd4_compound_state *cstate,
> -		     stateid_t *stateid, unsigned char typemask,
> -		     struct nfs4_stid **s, struct nfsd_net *nn);
> +			    stateid_t *stateid, unsigned short typemask,
> +			    unsigned short statemask,
> +			    struct nfs4_stid **s, struct nfsd_net *nn);
>  struct nfs4_stid *nfs4_alloc_stid(struct nfs4_client *cl, struct kmem_ca=
che *slab,
>  				  void (*sc_free)(struct nfs4_stid *));
>  int nfs4_init_copy_state(struct nfsd_net *nn, struct nfsd4_copy *copy);
> diff --git a/fs/nfsd/trace.h b/fs/nfsd/trace.h
> index fbc0ccb40424..668b352faaea 100644
> --- a/fs/nfsd/trace.h
> +++ b/fs/nfsd/trace.h
> @@ -641,31 +641,26 @@ DEFINE_EVENT(nfsd_stateseqid_class, nfsd_##name, \
>  DEFINE_STATESEQID_EVENT(preprocess);
>  DEFINE_STATESEQID_EVENT(open_confirm);
> =20
> -TRACE_DEFINE_ENUM(NFS4_OPEN_STID);
> -TRACE_DEFINE_ENUM(NFS4_LOCK_STID);
> -TRACE_DEFINE_ENUM(NFS4_DELEG_STID);
> -TRACE_DEFINE_ENUM(NFS4_CLOSED_STID);
> -TRACE_DEFINE_ENUM(NFS4_REVOKED_DELEG_STID);
> -TRACE_DEFINE_ENUM(NFS4_CLOSED_DELEG_STID);
> -TRACE_DEFINE_ENUM(NFS4_LAYOUT_STID);
> -
>  #define show_stid_type(x)						\
>  	__print_flags(x, "|",						\
>  		{ NFS4_OPEN_STID,		"OPEN" },		\
>  		{ NFS4_LOCK_STID,		"LOCK" },		\
>  		{ NFS4_DELEG_STID,		"DELEG" },		\
> -		{ NFS4_CLOSED_STID,		"CLOSED" },		\
> -		{ NFS4_REVOKED_DELEG_STID,	"REVOKED" },		\
> -		{ NFS4_CLOSED_DELEG_STID,	"CLOSED_DELEG" },	\
>  		{ NFS4_LAYOUT_STID,		"LAYOUT" })
> =20
> +#define show_stid_status(x)						\
> +	__print_flags(x, "|",						\
> +		{ NFS4_STID_CLOSED,		"CLOSED" },		\
> +		{ NFS4_STID_REVOKED,		"REVOKED" })		\
> +
>  DECLARE_EVENT_CLASS(nfsd_stid_class,
>  	TP_PROTO(
>  		const struct nfs4_stid *stid
>  	),
>  	TP_ARGS(stid),
>  	TP_STRUCT__entry(
> -		__field(unsigned long, sc_type)
> +		__field(unsigned short, sc_type)
> +		__field(unsigned short, sc_status)
>  		__field(int, sc_count)
>  		__field(u32, cl_boot)
>  		__field(u32, cl_id)
> @@ -676,16 +671,18 @@ DECLARE_EVENT_CLASS(nfsd_stid_class,
>  		const stateid_t *stp =3D &stid->sc_stateid;
> =20
>  		__entry->sc_type =3D stid->sc_type;
> +		__entry->sc_status =3D stid->sc_status;
>  		__entry->sc_count =3D refcount_read(&stid->sc_count);
>  		__entry->cl_boot =3D stp->si_opaque.so_clid.cl_boot;
>  		__entry->cl_id =3D stp->si_opaque.so_clid.cl_id;
>  		__entry->si_id =3D stp->si_opaque.so_id;
>  		__entry->si_generation =3D stp->si_generation;
>  	),
> -	TP_printk("client %08x:%08x stateid %08x:%08x ref=3D%d type=3D%s",
> +	TP_printk("client %08x:%08x stateid %08x:%08x ref=3D%d type=3D%s state=
=3D%s",
>  		__entry->cl_boot, __entry->cl_id,
>  		__entry->si_id, __entry->si_generation,
> -		__entry->sc_count, show_stid_type(__entry->sc_type)
> +		__entry->sc_count, show_stid_type(__entry->sc_type),
> +		show_stid_status(__entry->sc_status)
>  	)
>  );
> =20

I like it, overall! This fixes several ugly warts in the sc_type
handling.

I needed the patch below to get it to compile, but it seems to be
working OK so far. The patch may not be quite right, but I'm not testing
pnfs at the moment.
--=20
Jeff Layton <jlayton@kernel.org>

-----------------8<-----------------------

[PATCH] SQUASH: nfs4_unhash_stid

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/nfsd/nfs4layouts.c | 1 -
 fs/nfsd/state.h       | 1 -
 2 files changed, 2 deletions(-)

diff --git a/fs/nfsd/nfs4layouts.c b/fs/nfsd/nfs4layouts.c
index 678bef3a7f15..6c8263741e01 100644
--- a/fs/nfsd/nfs4layouts.c
+++ b/fs/nfsd/nfs4layouts.c
@@ -518,7 +518,6 @@ nfsd4_return_file_layouts(struct svc_rqst *rqstp,
 		lrp->lrs_present =3D true;
 	} else {
 		trace_nfsd_layoutstate_unhash(&ls->ls_stid.sc_stateid);
-		nfs4_unhash_stid(&ls->ls_stid);
 		lrp->lrs_present =3D false;
 	}
 	spin_unlock(&ls->ls_lock);
diff --git a/fs/nfsd/state.h b/fs/nfsd/state.h
index cf89fb6be9e1..d81314a9b33a 100644
--- a/fs/nfsd/state.h
+++ b/fs/nfsd/state.h
@@ -717,7 +717,6 @@ int nfs4_init_copy_state(struct nfsd_net *nn, struct
nfsd4_copy *copy);
 void nfs4_free_copy_state(struct nfsd4_copy *copy);
 struct nfs4_cpntf_state *nfs4_alloc_init_cpntf_state(struct nfsd_net
*nn,
 			struct nfs4_stid *p_stid);
-void nfs4_unhash_stid(struct nfs4_stid *s);
 void nfs4_put_stid(struct nfs4_stid *s);
 void nfs4_inc_and_copy_stateid(stateid_t *dst, struct nfs4_stid *stid);
 void nfs4_remove_reclaim_record(struct nfs4_client_reclaim *, struct
nfsd_net *);
--=20
2.41.0



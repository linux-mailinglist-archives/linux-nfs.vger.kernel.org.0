Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B214D625EDA
	for <lists+linux-nfs@lfdr.de>; Fri, 11 Nov 2022 16:58:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233932AbiKKP6v (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 11 Nov 2022 10:58:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233187AbiKKP6v (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 11 Nov 2022 10:58:51 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71B066348
        for <linux-nfs@vger.kernel.org>; Fri, 11 Nov 2022 07:58:48 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0BC796203A
        for <linux-nfs@vger.kernel.org>; Fri, 11 Nov 2022 15:58:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11BF2C433C1;
        Fri, 11 Nov 2022 15:58:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668182327;
        bh=jHflsJVu+XueIMubOIbUEQKRwVz+C1/ftBMObEr6BuA=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=IRuEmhTZySlvDejL5rSS0ZLC3MMz7ElZqUtA4+kkOAZkZHSu90UykoFzkai5T89jO
         wgxeRREJ0r2dHHI2iF1BMPGqqdYdDveE6hffPxV0d8Rjy9hfcK3XlGd9X/K6DEd21M
         BK2kMkdaEeaEhCEYeBlF4iqVZqB9gJ3GrtipqCfPR1AXEvPwxurwm2DXAS56+dvBut
         O+/VOXOrYJ26mkEEMZ54fMfqidNbk04QhyT2ukfSIfQk5R7uG5U98+yzUHORAwc0sr
         B6HXttf6r7espADk4rkz4CYMTD+LTERGDpzcTrXzokyUja8QhJPw1UVrIjbu3Dk5N7
         a8etZUkzxivVQ==
Message-ID: <e1c6e855f20801944c4cfea19c459e513c9e39b0.camel@kernel.org>
Subject: Re: [PATCH v4 2/3] NFSD: add delegation shrinker to react to low
 memory condition
From:   Jeff Layton <jlayton@kernel.org>
To:     Chuck Lever III <chuck.lever@oracle.com>,
        Dai Ngo <dai.ngo@oracle.com>
Cc:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Date:   Fri, 11 Nov 2022 10:58:45 -0500
In-Reply-To: <B311BC62-A485-47EE-86F3-0C17AF119C12@oracle.com>
References: <1668053831-7662-1-git-send-email-dai.ngo@oracle.com>
         <1668053831-7662-3-git-send-email-dai.ngo@oracle.com>
         <B311BC62-A485-47EE-86F3-0C17AF119C12@oracle.com>
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4 (3.44.4-2.fc36) 
MIME-Version: 1.0
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Fri, 2022-11-11 at 15:25 +0000, Chuck Lever III wrote:
>=20
> > On Nov 9, 2022, at 11:17 PM, Dai Ngo <dai.ngo@oracle.com> wrote:
> >=20
> > The delegation shrinker is scheduled to run on every shrinker's
> > 'count' callback. It scans the client list and sends the
> > courtesy CB_RECALL_ANY to the clients that hold delegations.
> >=20
> > To avoid flooding the clients with CB_RECALL_ANY requests, the
> > delegation shrinker is scheduled to run after a 5 seconds delay.
> >=20
> > Signed-off-by: Dai Ngo <dai.ngo@oracle.com>
> > ---
> > fs/nfsd/netns.h     |   3 ++
> > fs/nfsd/nfs4state.c | 115 +++++++++++++++++++++++++++++++++++++++++++++=
++++++-
> > fs/nfsd/state.h     |   8 ++++
> > 3 files changed, 125 insertions(+), 1 deletion(-)
> >=20
> > diff --git a/fs/nfsd/netns.h b/fs/nfsd/netns.h
> > index 8c854ba3285b..394a05fb46d8 100644
> > --- a/fs/nfsd/netns.h
> > +++ b/fs/nfsd/netns.h
> > @@ -196,6 +196,9 @@ struct nfsd_net {
> > 	atomic_t		nfsd_courtesy_clients;
> > 	struct shrinker		nfsd_client_shrinker;
> > 	struct delayed_work	nfsd_shrinker_work;
> > +
> > +	struct shrinker		nfsd_deleg_shrinker;
> > +	struct delayed_work	nfsd_deleg_shrinker_work;
> > };
> >=20
> > /* Simple check to find out if a given net was properly initialized */
> > diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
> > index 4e718500a00c..813cdb67b370 100644
> > --- a/fs/nfsd/nfs4state.c
> > +++ b/fs/nfsd/nfs4state.c
> > @@ -2131,6 +2131,7 @@ static void __free_client(struct kref *k)
> > 	kfree(clp->cl_nii_domain.data);
> > 	kfree(clp->cl_nii_name.data);
> > 	idr_destroy(&clp->cl_stateids);
> > +	kfree(clp->cl_ra);
> > 	kmem_cache_free(client_slab, clp);
> > }
> >=20
> > @@ -2854,6 +2855,36 @@ static const struct tree_descr client_files[] =
=3D {
> > 	[3] =3D {""},
> > };
> >=20
> > +static int
> > +nfsd4_cb_recall_any_done(struct nfsd4_callback *cb,
> > +				struct rpc_task *task)
> > +{
> > +	switch (task->tk_status) {
> > +	case -NFS4ERR_DELAY:
> > +		rpc_delay(task, 2 * HZ);
> > +		return 0;
> > +	default:
> > +		return 1;
> > +	}
> > +}
> > +
> > +static void
> > +nfsd4_cb_recall_any_release(struct nfsd4_callback *cb)
> > +{
> > +	struct nfs4_client *clp =3D cb->cb_clp;
> > +	struct nfsd_net *nn =3D net_generic(clp->net, nfsd_net_id);
> > +
> > +	spin_lock(&nn->client_lock);
> > +	clear_bit(NFSD4_CLIENT_CB_RECALL_ANY, &clp->cl_flags);
> > +	put_client_renew_locked(clp);
> > +	spin_unlock(&nn->client_lock);
> > +}
> > +
> > +static const struct nfsd4_callback_ops nfsd4_cb_recall_any_ops =3D {
> > +	.done		=3D nfsd4_cb_recall_any_done,
> > +	.release	=3D nfsd4_cb_recall_any_release,
> > +};
> > +
> > static struct nfs4_client *create_client(struct xdr_netobj name,
> > 		struct svc_rqst *rqstp, nfs4_verifier *verf)
> > {
> > @@ -2891,6 +2922,14 @@ static struct nfs4_client *create_client(struct =
xdr_netobj name,
> > 		free_client(clp);
> > 		return NULL;
> > 	}
> > +	clp->cl_ra =3D kzalloc(sizeof(*clp->cl_ra), GFP_KERNEL);
> > +	if (!clp->cl_ra) {
> > +		free_client(clp);
> > +		return NULL;
> > +	}
> > +	clp->cl_ra_time =3D 0;
> > +	nfsd4_init_cb(&clp->cl_ra->ra_cb, clp, &nfsd4_cb_recall_any_ops,
> > +			NFSPROC4_CLNT_CB_RECALL_ANY);
> > 	return clp;
> > }
> >=20
> > @@ -4365,11 +4404,32 @@ nfsd_courtesy_client_scan(struct shrinker *shri=
nk, struct shrink_control *sc)
> > 	return SHRINK_STOP;
> > }
> >=20
> > +static unsigned long
> > +nfsd_deleg_shrinker_count(struct shrinker *shrink, struct shrink_contr=
ol *sc)
> > +{
> > +	unsigned long cnt;
>=20
> No reason not to spell out "count".
>=20
> > +	struct nfsd_net *nn =3D container_of(shrink,
> > +				struct nfsd_net, nfsd_deleg_shrinker);
> > +
> > +	cnt =3D atomic_long_read(&num_delegations);
> > +	if (cnt)
> > +		mod_delayed_work(laundry_wq,
> > +			&nn->nfsd_deleg_shrinker_work, 0);
> > +	return cnt;
> > +}
> > +
> > +static unsigned long
> > +nfsd_deleg_shrinker_scan(struct shrinker *shrink, struct shrink_contro=
l *sc)
> > +{
> > +	return SHRINK_STOP;
> > +}
> > +
> > int
> > nfsd4_init_leases_net(struct nfsd_net *nn)
> > {
> > 	struct sysinfo si;
> > 	u64 max_clients;
> > +	int retval;
> >=20
> > 	nn->nfsd4_lease =3D 90;	/* default lease time */
> > 	nn->nfsd4_grace =3D 90;
> > @@ -4390,13 +4450,24 @@ nfsd4_init_leases_net(struct nfsd_net *nn)
> > 	nn->nfsd_client_shrinker.scan_objects =3D nfsd_courtesy_client_scan;
> > 	nn->nfsd_client_shrinker.count_objects =3D nfsd_courtesy_client_count;
> > 	nn->nfsd_client_shrinker.seeks =3D DEFAULT_SEEKS;
> > -	return register_shrinker(&nn->nfsd_client_shrinker, "nfsd-client");
> > +	retval =3D register_shrinker(&nn->nfsd_client_shrinker, "nfsd-client"=
);
> > +	if (retval)
> > +		return retval;
> > +	nn->nfsd_deleg_shrinker.scan_objects =3D nfsd_deleg_shrinker_scan;
> > +	nn->nfsd_deleg_shrinker.count_objects =3D nfsd_deleg_shrinker_count;
> > +	nn->nfsd_deleg_shrinker.seeks =3D DEFAULT_SEEKS;
> > +	retval =3D register_shrinker(&nn->nfsd_deleg_shrinker, "nfsd-delegati=
on");
> > +	if (retval)
> > +		unregister_shrinker(&nn->nfsd_client_shrinker);
> > +	return retval;
> > +
> > }
> >=20
> > void
> > nfsd4_leases_net_shutdown(struct nfsd_net *nn)
> > {
> > 	unregister_shrinker(&nn->nfsd_client_shrinker);
> > +	unregister_shrinker(&nn->nfsd_deleg_shrinker);
> > }
> >=20
> > static void init_nfs4_replay(struct nfs4_replay *rp)
> > @@ -6135,6 +6206,47 @@ courtesy_client_reaper(struct work_struct *reape=
r)
> > 	nfs4_process_client_reaplist(&reaplist);
> > }
> >=20
> > +static void
> > +deleg_reaper(struct work_struct *deleg_work)
> > +{
> > +	struct list_head *pos, *next;
> > +	struct nfs4_client *clp;
> > +	struct list_head cblist;
> > +	struct delayed_work *dwork =3D to_delayed_work(deleg_work);
> > +	struct nfsd_net *nn =3D container_of(dwork, struct nfsd_net,
> > +					nfsd_deleg_shrinker_work);
> > +
> > +	INIT_LIST_HEAD(&cblist);
> > +	spin_lock(&nn->client_lock);
> > +	list_for_each_safe(pos, next, &nn->client_lru) {
> > +		clp =3D list_entry(pos, struct nfs4_client, cl_lru);
> > +		if (clp->cl_state !=3D NFSD4_ACTIVE ||
> > +			list_empty(&clp->cl_delegations) ||
> > +			atomic_read(&clp->cl_delegs_in_recall) ||
> > +			test_bit(NFSD4_CLIENT_CB_RECALL_ANY, &clp->cl_flags) ||
> > +			(ktime_get_boottime_seconds() -
> > +				clp->cl_ra_time < 5)) {
> > +			continue;
> > +		}
> > +		list_add(&clp->cl_ra_cblist, &cblist);
> > +
> > +		/* release in nfsd4_cb_recall_any_release */
> > +		atomic_inc(&clp->cl_rpc_users);
> > +		set_bit(NFSD4_CLIENT_CB_RECALL_ANY, &clp->cl_flags);
> > +		clp->cl_ra_time =3D ktime_get_boottime_seconds();
> > +	}
> > +	spin_unlock(&nn->client_lock);
> > +	list_for_each_safe(pos, next, &cblist) {
>=20
> The usual idiom for draining a list like this is
>=20
> 	while (!list_empty(&cblist)) {
> 		clp =3D list_first_entry( ... );
>=20

Agreed. Note that it's also slightly more efficient to do it that way,
since you don't require a "next" pointer.

>=20
> > +		clp =3D list_entry(pos, struct nfs4_client, cl_ra_cblist);
> > +		list_del_init(&clp->cl_ra_cblist);
> > +		clp->cl_ra->ra_keep =3D 0;
> > +		clp->cl_ra->ra_bmval[0] =3D BIT(RCA4_TYPE_MASK_RDATA_DLG) |
> > +						BIT(RCA4_TYPE_MASK_WDATA_DLG);
> > +		nfsd4_run_cb(&clp->cl_ra->ra_cb);
> > +	}
> > +
> > +}
> > +
> > static inline __be32 nfs4_check_fh(struct svc_fh *fhp, struct nfs4_stid=
 *stp)
> > {
> > 	if (!fh_match(&fhp->fh_handle, &stp->sc_file->fi_fhandle))
> > @@ -7958,6 +8070,7 @@ static int nfs4_state_create_net(struct net *net)
> >=20
> > 	INIT_DELAYED_WORK(&nn->laundromat_work, laundromat_main);
> > 	INIT_DELAYED_WORK(&nn->nfsd_shrinker_work, courtesy_client_reaper);
> > +	INIT_DELAYED_WORK(&nn->nfsd_deleg_shrinker_work, deleg_reaper);
> > 	get_net(net);
> >=20
> > 	return 0;
> > diff --git a/fs/nfsd/state.h b/fs/nfsd/state.h
> > index 6b33cbbe76d3..12ce9792c5b6 100644
> > --- a/fs/nfsd/state.h
> > +++ b/fs/nfsd/state.h
> > @@ -368,6 +368,7 @@ struct nfs4_client {
> > #define NFSD4_CLIENT_UPCALL_LOCK	(5)	/* upcall serialization */
> > #define NFSD4_CLIENT_CB_FLAG_MASK	(1 << NFSD4_CLIENT_CB_UPDATE | \
> > 					 1 << NFSD4_CLIENT_CB_KILL)
> > +#define	NFSD4_CLIENT_CB_RECALL_ANY	(6)
> > 	unsigned long		cl_flags;
> > 	const struct cred	*cl_cb_cred;
> > 	struct rpc_clnt		*cl_cb_client;
> > @@ -411,6 +412,10 @@ struct nfs4_client {
> >=20
> > 	unsigned int		cl_state;
> > 	atomic_t		cl_delegs_in_recall;
> > +
> > +	struct nfsd4_cb_recall_any	*cl_ra;
> > +	time64_t		cl_ra_time;
> > +	struct list_head	cl_ra_cblist;
> > };
> >=20
> > /* struct nfs4_client_reset
> > @@ -642,6 +647,9 @@ enum nfsd4_cb_op {
> > 	NFSPROC4_CLNT_CB_RECALL_ANY,
> > };
> >=20
> > +#define	RCA4_TYPE_MASK_RDATA_DLG	0
> > +#define	RCA4_TYPE_MASK_WDATA_DLG	1
> > +
> > /* Returns true iff a is later than b: */
> > static inline bool nfsd4_stateid_generation_after(stateid_t *a, stateid=
_t *b)
> > {
> > --=20
> > 2.9.5
> >=20
>=20
> --
> Chuck Lever
>=20
>=20
>=20

--=20
Jeff Layton <jlayton@kernel.org>

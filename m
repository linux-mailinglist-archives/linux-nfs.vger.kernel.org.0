Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F043C5753C5
	for <lists+linux-nfs@lfdr.de>; Thu, 14 Jul 2022 19:11:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240242AbiGNRLb (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 14 Jul 2022 13:11:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240090AbiGNRL3 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 14 Jul 2022 13:11:29 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E84204BD28
        for <linux-nfs@vger.kernel.org>; Thu, 14 Jul 2022 10:11:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 73E15620C9
        for <linux-nfs@vger.kernel.org>; Thu, 14 Jul 2022 17:11:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77C26C34114;
        Thu, 14 Jul 2022 17:11:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657818687;
        bh=XMOq9NUjdV605kBHsdhtExuRpJZNGO903l8i2pnkx7I=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=ikmmdfc16Q1gkIVq3QI4lCievt+ykMVakhzmjMBst6MLirkBZbKQEbEb1dp/OiZmG
         Qof+VpbtBQ+v5hLPOxWFqQagGE+UGpDimwTVf6CFHnnkOmheISNQqUiATwto67CVJq
         WDTBcDBgHlS6R3fA/mUd2faVYCNCzAb7W3c/a9tkknrDhtrJ5m+I01LTPJirmjgNas
         fO5J85sLfzKX27n3AcWVY+xYDH3YBV8+mBZyKNQ24IqquuYqi0ykxDTRvJBKdnCqW0
         V4No3iGssiMYofyVm6x3kW98FyEYGaUQGkZnmGMepMj7JrcvZT/zhLCjAE8B+oCyTL
         fo5fSR5qqGfeA==
Message-ID: <fc9e2f339e9a84912e9e4644292bec44b5e49137.camel@kernel.org>
Subject: Re: [RFC PATCH 3/3] nfsd: vet the opened dentry after setting a
 delegation
From:   Jeff Layton <jlayton@kernel.org>
To:     Chuck Lever III <chuck.lever@oracle.com>
Cc:     Neil Brown <neilb@suse.de>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Date:   Thu, 14 Jul 2022 13:11:25 -0400
In-Reply-To: <F7B94422-F889-49DA-AA38-0D8AA1F9B682@oracle.com>
References: <20220714152819.128276-1-jlayton@kernel.org>
         <20220714152819.128276-4-jlayton@kernel.org>
         <F7B94422-F889-49DA-AA38-0D8AA1F9B682@oracle.com>
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.3 (3.44.3-1.fc36) 
MIME-Version: 1.0
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Thu, 2022-07-14 at 16:53 +0000, Chuck Lever III wrote:
>=20
> > On Jul 14, 2022, at 11:28 AM, Jeff Layton <jlayton@kernel.org> wrote:
> >=20
> > Between opening a file and setting a delegation on it, someone could
> > rename or unlink the dentry. If this happens, we do not want to grant a
> > delegation on the open.
> >=20
> > Take the i_rwsem before setting the delegation. If we're granted a
> > lease, redo the lookup of the file being opened and validate that the
> > resulting dentry matches the one in the open file description. We only
> > need to do this for the CLAIM_NULL open case however.
> >=20
> > Signed-off-by: Jeff Layton <jlayton@kernel.org>
> > ---
> > fs/nfsd/nfs4state.c | 55 ++++++++++++++++++++++++++++++++++++++++-----
> > 1 file changed, 50 insertions(+), 5 deletions(-)
> >=20
> > diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
> > index 347794028c98..e5c7f6690d2d 100644
> > --- a/fs/nfsd/nfs4state.c
> > +++ b/fs/nfsd/nfs4state.c
> > @@ -1172,6 +1172,7 @@ alloc_init_deleg(struct nfs4_client *clp, struct =
nfs4_file *fp,
> >=20
> > void
> > nfs4_put_stid(struct nfs4_stid *s)
> > +	__releases(&clp->cl_lock)
> > {
> > 	struct nfs4_file *fp =3D s->sc_file;
> > 	struct nfs4_client *clp =3D s->sc_client;
>=20
> This hunk causes a bunch of new sparse warnings:
>=20
> /home/cel/src/linux/klimt/include/linux/list.h:137:19: warning: context i=
mbalance in 'put_clnt_odstate' - unexpected unlock
> /home/cel/src/linux/klimt/fs/nfsd/nfs4state.c:1174:1: warning: context im=
balance in 'nfs4_put_stid' - different lock contexts for basic block
> /home/cel/src/linux/klimt/fs/nfsd/nfs4state.c:1230:13: warning: context i=
mbalance in 'destroy_unhashed_deleg' - unexpected unlock
> /home/cel/src/linux/klimt/fs/nfsd/nfs4state.c:1528:17: warning: context i=
mbalance in 'release_lock_stateid' - unexpected unlock
> /home/cel/src/linux/klimt/fs/nfsd/nfs4state.c:1624:17: warning: context i=
mbalance in 'release_last_closed_stateid' - unexpected unlock
> /home/cel/src/linux/klimt/fs/nfsd/nfs4state.c:2212:22: warning: context i=
mbalance in '__destroy_client' - unexpected unlock
> /home/cel/src/linux/klimt/fs/nfsd/nfs4state.c:4481:17: warning: context i=
mbalance in 'nfsd4_find_and_lock_existing_open' - unexpected unlock
> /home/cel/src/linux/klimt/fs/nfsd/nfs4state.c:4557:25: warning: context i=
mbalance in 'init_open_stateid' - unexpected unlock
> /home/cel/src/linux/klimt/fs/nfsd/nfs4state.c:4606:17: warning: context i=
mbalance in 'move_to_close_lru' - unexpected unlock
> /home/cel/src/linux/klimt/fs/nfsd/nfs4state.c:4752:13: warning: context i=
mbalance in 'nfsd4_cb_recall_release' - unexpected unlock
> /home/cel/src/linux/klimt/fs/nfsd/nfs4state.c:5003:17: warning: context i=
mbalance in 'nfs4_check_deleg' - unexpected unlock
> /home/cel/src/linux/klimt/fs/nfsd/nfs4state.c:5392:9: warning: context im=
balance in 'nfs4_set_delegation' - unexpected unlock
> /home/cel/src/linux/klimt/fs/nfsd/nfs4state.c:5467:9: warning: context im=
balance in 'nfs4_open_delegation' - unexpected unlock
> /home/cel/src/linux/klimt/fs/nfsd/nfs4state.c:5619:17: warning: context i=
mbalance in 'nfsd4_process_open2' - unexpected unlock
> /home/cel/src/linux/klimt/fs/nfsd/nfs4state.c:5638:17: warning: context i=
mbalance in 'nfsd4_cleanup_open_state' - unexpected unlock
> /home/cel/src/linux/klimt/fs/nfsd/nfs4state.c:5934:27: warning: context i=
mbalance in 'nfs4_laundromat' - different lock contexts for basic block
> /home/cel/src/linux/klimt/fs/nfsd/nfs4state.c:6160:17: warning: context i=
mbalance in 'nfsd4_lookup_stateid' - unexpected unlock
> /home/cel/src/linux/klimt/fs/nfsd/nfs4state.c:6374:25: warning: context i=
mbalance in 'nfs4_preprocess_stateid_op' - unexpected unlock
> /home/cel/src/linux/klimt/fs/nfsd/nfs4state.c:6422:9: warning: context im=
balance in 'nfsd4_free_lock_stateid' - unexpected unlock
> /home/cel/src/linux/klimt/fs/nfsd/nfs4state.c:6459:28: warning: context i=
mbalance in 'nfsd4_free_stateid' - unexpected unlock
> /home/cel/src/linux/klimt/fs/nfsd/nfs4state.c:6528:17: warning: context i=
mbalance in 'nfs4_preprocess_seqid_op' - unexpected unlock
> /home/cel/src/linux/klimt/fs/nfsd/nfs4state.c:6545:17: warning: context i=
mbalance in 'nfs4_preprocess_confirmed_seqid_op' - unexpected unlock
> /home/cel/src/linux/klimt/fs/nfsd/nfs4state.c:6588:9: warning: context im=
balance in 'nfsd4_open_confirm' - unexpected unlock
> /home/cel/src/linux/klimt/fs/nfsd/nfs4state.c:6657:9: warning: context im=
balance in 'nfsd4_open_downgrade' - unexpected unlock
> /home/cel/src/linux/klimt/fs/nfsd/nfs4state.c:6730:9: warning: context im=
balance in 'nfsd4_close' - unexpected unlock
> /home/cel/src/linux/klimt/fs/nfsd/nfs4state.c:6762:9: warning: context im=
balance in 'nfsd4_delegreturn' - unexpected unlock
> /home/cel/src/linux/klimt/fs/nfsd/nfs4state.c:7034:17: warning: context i=
mbalance in 'init_lock_stateid' - unexpected unlock
> /home/cel/src/linux/klimt/fs/nfsd/nfs4state.c:7063:17: warning: context i=
mbalance in 'find_or_create_lock_stateid' - unexpected unlock
> /home/cel/src/linux/klimt/fs/nfsd/nfs4state.c:7362:17: warning: context i=
mbalance in 'nfsd4_lock' - unexpected unlock
> /home/cel/src/linux/klimt/fs/nfsd/nfs4state.c:7535:9: warning: context im=
balance in 'nfsd4_locku' - unexpected unlock
>=20
> Let's repair the "/home/cel/src/linux/klimt/fs/nfsd/nfs4state.c:1185:9:
> warning: context imbalance in 'nfs4_put_stid' - unexpected unlock" messag=
e
> in a separate patch.
>=20


Yeah, I saw that too after I sent this. That hunk doesn't belong in
here. I'll drop it from my local copy.


> Otherwise, this seems reasonable and the surgery is not invasive.
> Do you have a sense of the overhead of this new check?
>=20
>=20

Not really...

It's an extra (shared) rwsem acquisition, and a lookup (though that
should be in cache in most cases). Neither of those sound too awful on
their own, but the open codepath can be sensitive. It's probably heavily
workload dependent as well (as is commonly the case). I think we'd need
to take it in and do some testing to see if it harms anything.

> > @@ -5259,13 +5260,41 @@ static int nfsd4_check_conflicting_opens(struct=
 nfs4_client *clp,
> > 	return 0;
> > }
> >=20
> > +/*
> > + * It's possible that between opening the dentry and setting the deleg=
ation,
> > + * that it has been renamed or unlinked. Redo the lookup to validate t=
hat this
> > + * hasn't happened.
> > + */
> > +static int
> > +nfsd4_vet_deleg_parent(struct nfsd4_open *open, struct nfs4_file *fp, =
struct dentry *parent)
> > +{
> > +	struct dentry *child;
> > +
> > +	/* Only need to do this if this is an open-by-name */
> > +	if (!parent)
> > +		return 0;
> > +
> > +	child =3D lookup_one_len(open->op_fname, parent, open->op_fnamelen);
> > +	if (IS_ERR(child))
> > +		return PTR_ERR(child);
> > +	dput(child);
> > +
> > +	/* Uh-oh, there has been a rename or unlink of the file. No deleg! */
> > +	if (child !=3D file_dentry(fp->fi_deleg_file->nf_file))
> > +		return -EAGAIN;
> > +
> > +	return 0;
> > +}
> > +
> > static struct nfs4_delegation *
> > -nfs4_set_delegation(struct nfsd4_open *open, struct nfs4_ol_stateid *s=
tp)
> > +nfs4_set_delegation(struct nfsd4_open *open, struct nfs4_ol_stateid *s=
tp,
> > +		    struct svc_fh *parent_fh)
> > {
> > 	int status =3D 0;
> > 	struct nfs4_client *clp =3D stp->st_stid.sc_client;
> > 	struct nfs4_file *fp =3D stp->st_stid.sc_file;
> > 	struct nfs4_clnt_odstate *odstate =3D stp->st_clnt_odstate;
> > +	struct dentry *parent =3D parent_fh ? parent_fh->fh_dentry : NULL;
> > 	struct nfs4_delegation *dp;
> > 	struct nfsd_file *nf;
> > 	struct file_lock *fl;
> > @@ -5315,11 +5344,23 @@ nfs4_set_delegation(struct nfsd4_open *open, st=
ruct nfs4_ol_stateid *stp)
> > 	if (!fl)
> > 		goto out_clnt_odstate;
> >=20
> > +	if (parent)
> > +		inode_lock_shared_nested(d_inode(parent), I_MUTEX_PARENT);
> > 	status =3D vfs_setlease(fp->fi_deleg_file->nf_file, fl->fl_type, &fl, =
NULL);
> > 	if (fl)
> > 		locks_free_lock(fl);
> > -	if (status)
> > +	if (status) {
> > +		if (parent)
> > +			inode_unlock_shared(d_inode(parent));
> > 		goto out_clnt_odstate;
> > +	}
> > +
> > +	status =3D nfsd4_vet_deleg_parent(open, fp, parent);
> > +	if (parent)
> > +		inode_unlock_shared(d_inode(parent));
> > +	if (status)
> > +		goto out_unlock;
> > +
> > 	status =3D nfsd4_check_conflicting_opens(clp, fp);
> > 	if (status)
> > 		goto out_unlock;
> > @@ -5375,11 +5416,13 @@ static void nfsd4_open_deleg_none_ext(struct nf=
sd4_open *open, int status)
> >  * proper support for them.
> >  */
> > static void
> > -nfs4_open_delegation(struct nfsd4_open *open, struct nfs4_ol_stateid *=
stp)
> > +nfs4_open_delegation(struct nfsd4_open *open, struct nfs4_ol_stateid *=
stp,
> > +		     struct svc_fh *current_fh)
> > {
> > 	struct nfs4_delegation *dp;
> > 	struct nfs4_openowner *oo =3D openowner(stp->st_stateowner);
> > 	struct nfs4_client *clp =3D stp->st_stid.sc_client;
> > +	struct svc_fh *parent_fh =3D NULL;
> > 	int cb_up;
> > 	int status =3D 0;
> >=20
> > @@ -5393,6 +5436,8 @@ nfs4_open_delegation(struct nfsd4_open *open, str=
uct nfs4_ol_stateid *stp)
> > 				goto out_no_deleg;
> > 			break;
> > 		case NFS4_OPEN_CLAIM_NULL:
> > +			parent_fh =3D current_fh;
> > +			fallthrough;
> > 		case NFS4_OPEN_CLAIM_FH:
> > 			/*
> > 			 * Let's not give out any delegations till everyone's
> > @@ -5407,7 +5452,7 @@ nfs4_open_delegation(struct nfsd4_open *open, str=
uct nfs4_ol_stateid *stp)
> > 		default:
> > 			goto out_no_deleg;
> > 	}
> > -	dp =3D nfs4_set_delegation(open, stp);
> > +	dp =3D nfs4_set_delegation(open, stp, parent_fh);
> > 	if (IS_ERR(dp))
> > 		goto out_no_deleg;
> >=20
> > @@ -5539,7 +5584,7 @@ nfsd4_process_open2(struct svc_rqst *rqstp, struc=
t svc_fh *current_fh, struct nf
> > 	* Attempt to hand out a delegation. No error return, because the
> > 	* OPEN succeeds even if we fail.
> > 	*/
> > -	nfs4_open_delegation(open, stp);
> > +	nfs4_open_delegation(open, stp, &resp->cstate.current_fh);
> > nodeleg:
> > 	status =3D nfs_ok;
> > 	trace_nfsd_open(&stp->st_stid.sc_stateid);
> > --=20
> > 2.36.1
> >=20
>=20
> --
> Chuck Lever
>=20
>=20
>=20

--=20
Jeff Layton <jlayton@kernel.org>

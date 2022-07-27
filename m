Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E70205829E2
	for <lists+linux-nfs@lfdr.de>; Wed, 27 Jul 2022 17:44:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233988AbiG0PoV (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 27 Jul 2022 11:44:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233157AbiG0PoR (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 27 Jul 2022 11:44:17 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD593481FB
        for <linux-nfs@vger.kernel.org>; Wed, 27 Jul 2022 08:44:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 64DF061957
        for <linux-nfs@vger.kernel.org>; Wed, 27 Jul 2022 15:44:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E99BC433C1;
        Wed, 27 Jul 2022 15:44:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658936655;
        bh=kOgYYY16TS+sq0DQ1xGCujZtebveQYfperj7hFnfazg=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=L+6d2i0YnDEWLx+gz/BlZAbbFgZ8qJ8pFADXITQd8rug7gyiu7l6hLzvyYCfiOJMf
         Ayp+yoqsLvWTrAxxP6jbLWb2iJIOan96M01Tw21bdzw7NeXW10a4CCagB1QFVP86CP
         /OftieQ1WMAmrPyc8BpyYP+E32uLpsSQh0v1aughsoDs00aL+bFCpKepzJS9CgxLib
         TMB3gPxvKuNkzsam9uMMojWTPUvwQ7U61U6opoIlXQ8FAN7EEKp/XCNc69whftZmDF
         tAw/vuguMTXCiy7kVTRpetemUfTIQqA2rP3hGCt6e4jcLF2iu9LEThF44t6A58DaxH
         s5GlKq+wHvodg==
Message-ID: <fb0bded1bb43404be5c577968894e637216d313e.camel@kernel.org>
Subject: Re: [PATCH 02/13] NFSD: verify the opened dentry after setting a
 delegation
From:   Jeff Layton <jlayton@kernel.org>
To:     NeilBrown <neilb@suse.de>, Chuck Lever III <chuck.lever@oracle.com>
Cc:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Date:   Wed, 27 Jul 2022 11:44:13 -0400
In-Reply-To: <165881793054.21666.4968784719648129759.stgit@noble.brown>
References: <165881740958.21666.5904057696047278505.stgit@noble.brown>
         <165881793054.21666.4968784719648129759.stgit@noble.brown>
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.3 (3.44.3-1.fc36) 
MIME-Version: 1.0
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Tue, 2022-07-26 at 16:45 +1000, NeilBrown wrote:
> From: Jeff Layton <jlayton@kernel.org>
>=20
> Between opening a file and setting a delegation on it, someone could
> rename or unlink the dentry. If this happens, we do not want to grant a
> delegation on the open.
>=20
> On a CLAIM_NULL open, we're opening by filename, and we may (in the
> non-create case) or may not (in the create case) be holding i_rwsem
> when attempting to set a delegation.  The latter case allows a
> race.
>=20
> After getting a lease, redo the lookup of the file being opened and
> validate that the resulting dentry matches the one in the open file
> description.
>=20
> To properly redo the lookup we need an rqst pointer to pass to
> nfsd_lookup_dentry(), so make sure that is available.
>=20
> Signed-off-by: Jeff Layton <jlayton@kernel.org>
> Signed-off-by: NeilBrown <neilb@suse.de>
> ---
>  fs/nfsd/nfs4proc.c  |    1 +
>  fs/nfsd/nfs4state.c |   54 +++++++++++++++++++++++++++++++++++++++++++++=
+-----
>  fs/nfsd/xdr4.h      |    1 +
>  3 files changed, 51 insertions(+), 5 deletions(-)
>=20
> diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
> index 5af9f8d1feb6..d57f91fa9f70 100644
> --- a/fs/nfsd/nfs4proc.c
> +++ b/fs/nfsd/nfs4proc.c
> @@ -547,6 +547,7 @@ nfsd4_open(struct svc_rqst *rqstp, struct nfsd4_compo=
und_state *cstate,
>  		open->op_openowner);
> =20
>  	open->op_filp =3D NULL;
> +	open->op_rqstp =3D rqstp;
> =20
>  	/* This check required by spec. */
>  	if (open->op_create && open->op_claim_type !=3D NFS4_OPEN_CLAIM_NULL)
> diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
> index 279c7a1502c9..8f64af3e38d8 100644
> --- a/fs/nfsd/nfs4state.c
> +++ b/fs/nfsd/nfs4state.c
> @@ -5288,11 +5288,44 @@ static int nfsd4_check_conflicting_opens(struct n=
fs4_client *clp,
>  	return 0;
>  }
> =20
> +/*
> + * It's possible that between opening the dentry and setting the delegat=
ion,
> + * that it has been renamed or unlinked. Redo the lookup to verify that =
this
> + * hasn't happened.
> + */
> +static int
> +nfsd4_verify_deleg_dentry(struct nfsd4_open *open, struct nfs4_file *fp,
> +			  struct svc_fh *parent)
> +{
> +	struct svc_export *exp;
> +	struct dentry *child;
> +	__be32 err;
> +
> +	/* parent may already be locked, and it may get unlocked by
> +	 * this call, but that is safe.
> +	 */
> +	err =3D nfsd_lookup_dentry(open->op_rqstp, parent,
> +				 open->op_fname, open->op_fnamelen,
> +				 &exp, &child);
> +

Note that in the middle of this series, you may end up triggering the
printk in fh_lock_nested if you call nfsd_lookup_dentry and the fh is
already locked. I assume that gets resolved by the end of the series
however.

> +	if (err)
> +		return -EAGAIN;
> +
> +	dput(child);
> +	if (child !=3D file_dentry(fp->fi_deleg_file->nf_file))
> +		return -EAGAIN;
> +
> +	return 0;
> +}
> +
>  static struct nfs4_delegation *
> -nfs4_set_delegation(struct nfs4_client *clp,
> -		    struct nfs4_file *fp, struct nfs4_clnt_odstate *odstate)
> +nfs4_set_delegation(struct nfsd4_open *open, struct nfs4_ol_stateid *stp=
,
> +		    struct svc_fh *parent)
>  {
>  	int status =3D 0;
> +	struct nfs4_client *clp =3D stp->st_stid.sc_client;
> +	struct nfs4_file *fp =3D stp->st_stid.sc_file;
> +	struct nfs4_clnt_odstate *odstate =3D stp->st_clnt_odstate;
>  	struct nfs4_delegation *dp;
>  	struct nfsd_file *nf;
>  	struct file_lock *fl;
> @@ -5347,6 +5380,13 @@ nfs4_set_delegation(struct nfs4_client *clp,
>  		locks_free_lock(fl);
>  	if (status)
>  		goto out_clnt_odstate;
> +
> +	if (parent) {
> +		status =3D nfsd4_verify_deleg_dentry(open, fp, parent);
> +		if (status)
> +			goto out_unlock;
> +	}
> +
>  	status =3D nfsd4_check_conflicting_opens(clp, fp);
>  	if (status)
>  		goto out_unlock;
> @@ -5402,11 +5442,13 @@ static void nfsd4_open_deleg_none_ext(struct nfsd=
4_open *open, int status)
>   * proper support for them.
>   */
>  static void
> -nfs4_open_delegation(struct nfsd4_open *open, struct nfs4_ol_stateid *st=
p)
> +nfs4_open_delegation(struct nfsd4_open *open, struct nfs4_ol_stateid *st=
p,
> +		     struct svc_fh *currentfh)
>  {
>  	struct nfs4_delegation *dp;
>  	struct nfs4_openowner *oo =3D openowner(stp->st_stateowner);
>  	struct nfs4_client *clp =3D stp->st_stid.sc_client;
> +	struct svc_fh *parent =3D NULL;
>  	int cb_up;
>  	int status =3D 0;
> =20
> @@ -5420,6 +5462,8 @@ nfs4_open_delegation(struct nfsd4_open *open, struc=
t nfs4_ol_stateid *stp)
>  				goto out_no_deleg;
>  			break;
>  		case NFS4_OPEN_CLAIM_NULL:
> +			parent =3D currentfh;
> +			fallthrough;
>  		case NFS4_OPEN_CLAIM_FH:
>  			/*
>  			 * Let's not give out any delegations till everyone's
> @@ -5434,7 +5478,7 @@ nfs4_open_delegation(struct nfsd4_open *open, struc=
t nfs4_ol_stateid *stp)
>  		default:
>  			goto out_no_deleg;
>  	}
> -	dp =3D nfs4_set_delegation(clp, stp->st_stid.sc_file, stp->st_clnt_odst=
ate);
> +	dp =3D nfs4_set_delegation(open, stp, parent);
>  	if (IS_ERR(dp))
>  		goto out_no_deleg;
> =20
> @@ -5566,7 +5610,7 @@ nfsd4_process_open2(struct svc_rqst *rqstp, struct =
svc_fh *current_fh, struct nf
>  	* Attempt to hand out a delegation. No error return, because the
>  	* OPEN succeeds even if we fail.
>  	*/
> -	nfs4_open_delegation(open, stp);
> +	nfs4_open_delegation(open, stp, &resp->cstate.current_fh);
>  nodeleg:
>  	status =3D nfs_ok;
>  	trace_nfsd_open(&stp->st_stid.sc_stateid);
> diff --git a/fs/nfsd/xdr4.h b/fs/nfsd/xdr4.h
> index 7b744011f2d3..189f0600dbe8 100644
> --- a/fs/nfsd/xdr4.h
> +++ b/fs/nfsd/xdr4.h
> @@ -279,6 +279,7 @@ struct nfsd4_open {
>  	struct nfs4_clnt_odstate *op_odstate; /* used during processing */
>  	struct nfs4_acl *op_acl;
>  	struct xdr_netobj op_label;
> +	struct svc_rqst *op_rqstp;
>  };
> =20
>  struct nfsd4_open_confirm {
>=20
>=20

--=20
Jeff Layton <jlayton@kernel.org>

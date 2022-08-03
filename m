Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09DBF5892E0
	for <lists+linux-nfs@lfdr.de>; Wed,  3 Aug 2022 21:47:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237012AbiHCTry (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 3 Aug 2022 15:47:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233409AbiHCTrx (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 3 Aug 2022 15:47:53 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E661A20BD9
        for <linux-nfs@vger.kernel.org>; Wed,  3 Aug 2022 12:47:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 98DC8B823AC
        for <linux-nfs@vger.kernel.org>; Wed,  3 Aug 2022 19:47:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C708DC433C1;
        Wed,  3 Aug 2022 19:47:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659556069;
        bh=w/+LEBHQ7Sm4Fc9f7gWQOP5LY+qSH+U5pEsSfNCBzC0=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=WYV/OhRW9tmIT75svBBXApkRnYBqvtfyMQJQpojPqSnNAsp+14tyY5jInmC7gJoLc
         qUgEGGDPn2vgcrwDYbTsoIi9LKJ5KsOjHGr6Sty6JRlytj8yNkQLWawGJ/umUfuHry
         okcP1EKkOnf2j8QdGwtfAiJwmWL29MwzGF8wnfFuBHFaZlpCr4ThC+CS5cPC+O2BBi
         9B9ZIB3n3lqKwb/F2/jcvpBbCFrFfnP9Yg0tpTuTixhbkkqnoHxjeGf2MzjgXKaITw
         DXeV3KIrrGm11Jhp/HXMCu+H1WtY79d0x8OT8qXjrn5CetFmwYvuZ6Xxfe3gL/Z+3p
         EmRXsPJzijU4g==
Message-ID: <7307aa68bdadd97ecbc51b40a2d3d4e92736062a.camel@kernel.org>
Subject: Re: [PATCH v2 2/3] NFSD: Make nfsd4_setattr() wait before returning
 NFS4ERR_DELAY
From:   Jeff Layton <jlayton@kernel.org>
To:     Chuck Lever <chuck.lever@oracle.com>, linux-nfs@vger.kernel.org
Cc:     imammedo@redhat.com
Date:   Wed, 03 Aug 2022 15:47:47 -0400
In-Reply-To: <165953745991.1658.5781306176717145818.stgit@manet.1015granger.net>
References: <165953688893.1658.15242150042289528147.stgit@manet.1015granger.net>
         <165953745991.1658.5781306176717145818.stgit@manet.1015granger.net>
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

On Wed, 2022-08-03 at 10:37 -0400, Chuck Lever wrote:
> nfsd_setattr() can kick off a CB_RECALL (via
> notify_change() -> break_lease()) if a delegation is present. Before
> returning NFS4ERR_DELAY, give the client holding that delegation a
> chance to return it and then retry the nfsd_setattr() again, once.
>=20
> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
> ---
>  fs/nfsd/nfs4proc.c  |   18 +++++++++++++++---
>  fs/nfsd/nfs4state.c |   17 +++++++++++++++++
>  fs/nfsd/nfsd.h      |    1 +
>  fs/nfsd/trace.h     |   19 +++++++++++++++++++
>  fs/nfsd/xdr4.h      |    2 ++
>  5 files changed, 54 insertions(+), 3 deletions(-)
>=20
> diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
> index 42bfe0d769ec..62a267bb2ce5 100644
> --- a/fs/nfsd/nfs4proc.c
> +++ b/fs/nfsd/nfs4proc.c
> @@ -1142,7 +1142,7 @@ nfsd4_setattr(struct svc_rqst *rqstp, struct nfsd4_=
compound_state *cstate,
>  {
>  	struct nfsd4_setattr *setattr =3D &u->setattr;
>  	__be32 status =3D nfs_ok;
> -	int err;
> +	int err, retries;
> =20
>  	if (setattr->sa_iattr.ia_valid & ATTR_SIZE) {
>  		status =3D nfs4_preprocess_stateid_op(rqstp, cstate,
> @@ -1173,8 +1173,20 @@ nfsd4_setattr(struct svc_rqst *rqstp, struct nfsd4=
_compound_state *cstate,
>  				&setattr->sa_label);
>  	if (status)
>  		goto out;
> -	status =3D nfsd_setattr(rqstp, &cstate->current_fh, &setattr->sa_iattr,
> -				0, (time64_t)0);
> +
> +	retries =3D 1;
> +	do {
> +		status =3D nfsd_setattr(rqstp, &cstate->current_fh,
> +				      &setattr->sa_iattr, 0, (time64_t)0);
> +		if (status !=3D nfserr_jukebox)
> +			break;
> +		if (!retries--)
> +			break;
> +
> +		fh_clear_pre_post_attrs(&cstate->current_fh);
> +		nfsd4_wait_for_delegreturn(rqstp, &cstate->current_fh);
> +	} while (1);
> +
>  out:
>  	fh_drop_write(&cstate->current_fh);
>  	return status;
> diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
> index 0cf5a4bb36df..e3ac89d4a859 100644
> --- a/fs/nfsd/nfs4state.c
> +++ b/fs/nfsd/nfs4state.c
> @@ -4689,6 +4689,23 @@ nfs4_share_conflict(struct svc_fh *current_fh, uns=
igned int deny_type)
>  	return ret;
>  }
> =20
> +/**
> + * nfsd4_wait_for_delegreturn - wait for delegations to be returned
> + * @rqstp: the RPC transaction being executed
> + * @fhp: filehandle of file being waited for
> + *
> + * A better approach would wait for the DELEGRETURN operation, and
> + * retry just as soon as it was done.
> + *
> + * The timeout prevents deadlock if all nfsd threads happen to be
> + * tied up waiting for returning delegations.
> + */
> +void nfsd4_wait_for_delegreturn(struct svc_rqst *rqstp, struct svc_fh *f=
hp)
> +{
> +	trace_nfsd_delegreturn_wait(rqstp, fhp);
> +	msleep(NFSD_DELEGRETURN_TIMEOUT);

Like you mentioned in the cover letter, this is pretty nasty.

You could use wait_var_event_timeout here on the inode, paired with a
wake_up_var when a delegation is returned.

For the condition, you could use something like this:

    !inode->i_flctx || list_empty(&inode->i_flctx->flc_lease)

Maybe even a similar lockless check as the one in break_deleg?

> +}
> +
>  static void nfsd4_cb_recall_prepare(struct nfsd4_callback *cb)
>  {
>  	struct nfs4_delegation *dp =3D cb_to_delegation(cb);
> diff --git a/fs/nfsd/nfsd.h b/fs/nfsd/nfsd.h
> index 9a8b09afc173..0b800a154828 100644
> --- a/fs/nfsd/nfsd.h
> +++ b/fs/nfsd/nfsd.h
> @@ -341,6 +341,7 @@ void		nfsd_lockd_shutdown(void);
> =20
>  #define NFSD_LAUNDROMAT_MINTIMEOUT      1   /* seconds */
>  #define	NFSD_COURTESY_CLIENT_TIMEOUT	(24 * 60 * 60)	/* seconds */
> +#define NFSD_DELEGRETURN_TIMEOUT	(30)	/* milliseconds */
> =20
>  /*
>   * The following attributes are currently not supported by the NFSv4 ser=
ver:
> diff --git a/fs/nfsd/trace.h b/fs/nfsd/trace.h
> index 8c3d5f88072f..dd2654cac132 100644
> --- a/fs/nfsd/trace.h
> +++ b/fs/nfsd/trace.h
> @@ -443,6 +443,25 @@ DEFINE_NFSD_COPY_ERR_EVENT(clone_file_range_err);
>  #include "filecache.h"
>  #include "vfs.h"
> =20
> +TRACE_EVENT(nfsd_delegreturn_wait,
> +	TP_PROTO(
> +		const struct svc_rqst *rqstp,
> +		const struct svc_fh *fhp
> +	),
> +	TP_ARGS(rqstp, fhp),
> +	TP_STRUCT__entry(
> +		__field(u32, xid)
> +		__field(u32, fh_hash)
> +	),
> +	TP_fast_assign(
> +		__entry->xid =3D be32_to_cpu(rqstp->rq_xid);
> +		__entry->fh_hash =3D knfsd_fh_hash(&fhp->fh_handle);
> +	),
> +	TP_printk("xid=3D0x%08x fh_hash=3D0x%08x",
> +		  __entry->xid, __entry->fh_hash
> +	)
> +);
> +
>  DECLARE_EVENT_CLASS(nfsd_stateid_class,
>  	TP_PROTO(stateid_t *stp),
>  	TP_ARGS(stp),
> diff --git a/fs/nfsd/xdr4.h b/fs/nfsd/xdr4.h
> index 7b744011f2d3..5b9213076e95 100644
> --- a/fs/nfsd/xdr4.h
> +++ b/fs/nfsd/xdr4.h
> @@ -788,6 +788,8 @@ extern __be32 nfsd4_destroy_clientid(struct svc_rqst =
*, struct nfsd4_compound_st
>  		union nfsd4_op_u *u);
>  __be32 nfsd4_reclaim_complete(struct svc_rqst *, struct nfsd4_compound_s=
tate *,
>  		union nfsd4_op_u *u);
> +extern void nfsd4_wait_for_delegreturn(struct svc_rqst *rqstp,
> +		struct svc_fh *fhp);
>  extern __be32 nfsd4_process_open1(struct nfsd4_compound_state *,
>  		struct nfsd4_open *open, struct nfsd_net *nn);
>  extern __be32 nfsd4_process_open2(struct svc_rqst *rqstp,
>=20
>=20

--=20
Jeff Layton <jlayton@kernel.org>

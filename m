Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B71B47C868E
	for <lists+linux-nfs@lfdr.de>; Fri, 13 Oct 2023 15:16:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231761AbjJMNQU (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 13 Oct 2023 09:16:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231814AbjJMNQT (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 13 Oct 2023 09:16:19 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65CD3CC
        for <linux-nfs@vger.kernel.org>; Fri, 13 Oct 2023 06:16:17 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC1AEC433C8;
        Fri, 13 Oct 2023 13:16:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697202977;
        bh=bV8tRAolrfHsXel+BhSu7lHkZwKpUdLNwgiqc84doNo=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=IKhr6t+39P9AbQQIxUubgmxcXxLb1w/SMgm9tNfC9V4YZEXspeE+Gtc7q5dodSdFV
         mM7GG+mtmXsv84bAZP0qTkQ4c+jhyQn8Es1dL1SKNwTx6eCyeCVa2dvrxlcqH6wc4v
         OCYq2AKAWusLnaIyiuwkCRI3+4DBOcExSj3DX5hgmid7Zny8dIqTKsFpk7/0+mkkpA
         kEmNPWQ8UBemq8PWK7fpI/UVuyrHeeXdDABbdeRkL141+gpiFhT41M1RkyJVSahAN1
         p1Zstq1WU9SdOUNSP/oE40MzFUKf0UzdRhTWh00J7+nq/+zcIw8y+QqSBr1wAOReYJ
         Zhy85sC3oqtkQ==
Message-ID: <16190543c0a9d11ae8e23db069be0ce72e9763ba.camel@kernel.org>
Subject: Re: [PATCH] NFSD: Remove a layering violation when encoding
 lock_denied
From:   Jeff Layton <jlayton@kernel.org>
To:     Chuck Lever <cel@kernel.org>, linux-nfs@vger.kernel.org
Cc:     Chuck Lever <chuck.lever@oracle.com>
Date:   Fri, 13 Oct 2023 09:16:13 -0400
In-Reply-To: <169720169786.5129.10628552146876100129.stgit@oracle-102.nfsv4bat.org>
References: <169720169786.5129.10628552146876100129.stgit@oracle-102.nfsv4bat.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.module_f38+17164+63eeee4a) 
MIME-Version: 1.0
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Fri, 2023-10-13 at 08:56 -0400, Chuck Lever wrote:
> From: Chuck Lever <chuck.lever@oracle.com>
>=20
> An XDR encoder is responsible for marshaling results, not releasing
> memory that was allocated by the upper layer. We have .op_release
> for that purpose.
>=20
> Move the release of the ld_owner.data string to op_release functions
> for LOCK and LOCKT.
>=20
> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
> ---
>  fs/nfsd/nfs4proc.c  |    2 ++
>  fs/nfsd/nfs4state.c |   16 ++++++++++++++++
>  fs/nfsd/nfs4xdr.c   |   16 ++--------------
>  fs/nfsd/xdr4.h      |   17 +++++------------
>  4 files changed, 25 insertions(+), 26 deletions(-)
>=20
> Fix for kmemleak found during Bake-a-thon.
>=20
> I'm planning to insert this fix into nfsd-next just before the
> patches that clean up the lock_denied encoder.
>=20
> diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
> index 60262fd27b15..f288039545e3 100644
> --- a/fs/nfsd/nfs4proc.c
> +++ b/fs/nfsd/nfs4proc.c
> @@ -3210,6 +3210,7 @@ static const struct nfsd4_operation nfsd4_ops[] =3D=
 {
>  	},
>  	[OP_LOCK] =3D {
>  		.op_func =3D nfsd4_lock,
> +		.op_release =3D nfsd4_lock_release,
>  		.op_flags =3D OP_MODIFIES_SOMETHING |
>  				OP_NONTRIVIAL_ERROR_ENCODE,
>  		.op_name =3D "OP_LOCK",
> @@ -3218,6 +3219,7 @@ static const struct nfsd4_operation nfsd4_ops[] =3D=
 {
>  	},
>  	[OP_LOCKT] =3D {
>  		.op_func =3D nfsd4_lockt,
> +		.op_release =3D nfsd4_lockt_release,
>  		.op_flags =3D OP_NONTRIVIAL_ERROR_ENCODE,
>  		.op_name =3D "OP_LOCKT",
>  		.op_rsize_bop =3D nfsd4_lock_rsize,
> diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
> index 07840ee721ef..305c353a416c 100644
> --- a/fs/nfsd/nfs4state.c
> +++ b/fs/nfsd/nfs4state.c
> @@ -7773,6 +7773,14 @@ nfsd4_lock(struct svc_rqst *rqstp, struct nfsd4_co=
mpound_state *cstate,
>  	return status;
>  }
> =20
> +void nfsd4_lock_release(union nfsd4_op_u *u)
> +{
> +	struct nfsd4_lock *lock =3D &u->lock;
> +	struct nfsd4_lock_denied *deny =3D &lock->lk_denied;
> +
> +	kfree(deny->ld_owner.data);
> +}
> +
>  /*
>   * The NFSv4 spec allows a client to do a LOCKT without holding an OPEN,
>   * so we do a temporary open here just to get an open file to pass to
> @@ -7878,6 +7886,14 @@ nfsd4_lockt(struct svc_rqst *rqstp, struct nfsd4_c=
ompound_state *cstate,
>  	return status;
>  }
> =20
> +void nfsd4_lockt_release(union nfsd4_op_u *u)
> +{
> +	struct nfsd4_lockt *lockt =3D &u->lockt;
> +	struct nfsd4_lock_denied *deny =3D &lockt->lt_denied;
> +
> +	kfree(deny->ld_owner.data);
> +}
> +
>  __be32
>  nfsd4_locku(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
>  	    union nfsd4_op_u *u)
> diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
> index dafb3a91235e..26e7bb6d32ab 100644
> --- a/fs/nfsd/nfs4xdr.c
> +++ b/fs/nfsd/nfs4xdr.c
> @@ -3990,28 +3990,16 @@ nfsd4_encode_lock_denied(struct xdr_stream *xdr, =
struct nfsd4_lock_denied *ld)
>  	struct xdr_netobj *conf =3D &ld->ld_owner;
>  	__be32 *p;
> =20
> -again:
>  	p =3D xdr_reserve_space(xdr, 32 + XDR_LEN(conf->len));
> -	if (!p) {
> -		/*
> -		 * Don't fail to return the result just because we can't
> -		 * return the conflicting open:
> -		 */
> -		if (conf->len) {
> -			kfree(conf->data);
> -			conf->len =3D 0;
> -			conf->data =3D NULL;
> -			goto again;
> -		}
> +	if (!p)
>  		return nfserr_resource;
> -	}
> +
>  	p =3D xdr_encode_hyper(p, ld->ld_start);
>  	p =3D xdr_encode_hyper(p, ld->ld_length);
>  	*p++ =3D cpu_to_be32(ld->ld_type);
>  	if (conf->len) {
>  		p =3D xdr_encode_opaque_fixed(p, &ld->ld_clientid, 8);
>  		p =3D xdr_encode_opaque(p, conf->data, conf->len);
> -		kfree(conf->data);
>  	}  else {  /* non - nfsv4 lock in conflict, no clientid nor owner */
>  		p =3D xdr_encode_hyper(p, (u64)0); /* clientid */
>  		*p++ =3D cpu_to_be32(0); /* length of owner name */
> diff --git a/fs/nfsd/xdr4.h b/fs/nfsd/xdr4.h
> index aba07d5378fc..e6c9daae196e 100644
> --- a/fs/nfsd/xdr4.h
> +++ b/fs/nfsd/xdr4.h
> @@ -292,12 +292,8 @@ struct nfsd4_lock {
>  	} v;
> =20
>  	/* response */
> -	union {
> -		struct {
> -			stateid_t               stateid;
> -		} ok;
> -		struct nfsd4_lock_denied        denied;
> -	} u;
> +	stateid_t			lk_resp_stateid;
> +	struct nfsd4_lock_denied        lk_denied;
>  };
>  #define lk_new_open_seqid       v.new.open_seqid
>  #define lk_new_open_stateid     v.new.open_stateid
> @@ -307,20 +303,15 @@ struct nfsd4_lock {
>  #define lk_old_lock_stateid     v.old.lock_stateid
>  #define lk_old_lock_seqid       v.old.lock_seqid
> =20
> -#define lk_resp_stateid u.ok.stateid
> -#define lk_denied       u.denied
> -
> -
>  struct nfsd4_lockt {
>  	u32				lt_type;
>  	clientid_t			lt_clientid;
>  	struct xdr_netobj		lt_owner;
>  	u64				lt_offset;
>  	u64				lt_length;
> -	struct nfsd4_lock_denied  	lt_denied;
> +	struct nfsd4_lock_denied	lt_denied;
>  };
> =20
> -=20
>  struct nfsd4_locku {
>  	u32             lu_type;
>  	u32             lu_seqid;
> @@ -942,8 +933,10 @@ extern __be32 nfsd4_open_downgrade(struct svc_rqst *=
rqstp,
>  		struct nfsd4_compound_state *, union nfsd4_op_u *u);
>  extern __be32 nfsd4_lock(struct svc_rqst *rqstp, struct nfsd4_compound_s=
tate *,
>  		union nfsd4_op_u *u);
> +extern void nfsd4_lock_release(union nfsd4_op_u *u);
>  extern __be32 nfsd4_lockt(struct svc_rqst *rqstp, struct nfsd4_compound_=
state *,
>  		union nfsd4_op_u *u);
> +extern void nfsd4_lockt_release(union nfsd4_op_u *u);
>  extern __be32 nfsd4_locku(struct svc_rqst *rqstp, struct nfsd4_compound_=
state *,
>  		union nfsd4_op_u *u);
>  extern __be32
>=20
>=20

Reviewed-by: Jeff Layton <jlayton@kernel.org>

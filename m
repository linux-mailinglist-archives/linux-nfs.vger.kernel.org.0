Return-Path: <linux-nfs+bounces-5070-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B860893D4A4
	for <lists+linux-nfs@lfdr.de>; Fri, 26 Jul 2024 15:54:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DC2D11C2108B
	for <lists+linux-nfs@lfdr.de>; Fri, 26 Jul 2024 13:54:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E33391E526;
	Fri, 26 Jul 2024 13:54:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EjA9/ICh"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE64A1E521
	for <linux-nfs@vger.kernel.org>; Fri, 26 Jul 2024 13:54:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722002050; cv=none; b=jOpSOt6u53pWC37xDtBhbm9KxX0czwJ5+L/B04J6PvXoDVbMIqJiad70RI/IHDnGVZtA/p8RGvr/0eGtD3WNgQdMHoNDp6ENdhAt2UiitSS3nu4b6W74YbYet2ttT8SrwSbWda7CX2pE2OBTH/3Izou2NJ+JjbZe/HjyU7A/VAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722002050; c=relaxed/simple;
	bh=UFgNUcpYgW4o7ZGGS3qHZ2uA3ZR6dmN7bRSfyKBELwI=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=NgWtv8przL0BKxwDxj7YmpyzUzyars5JS1cBDkghFVvbw20lx2aJBunlzkNAS1jUH6zuggEQo0yh+vzK6hBMy3P5Xt59CypQK1rXtZcmh8w8NuOPvI30RuWC0CQXOwTGisUNdaD2UNZ5kWTFDQiF69UWXSUsR0ih8JwkPIDpSJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EjA9/ICh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE9FBC32782;
	Fri, 26 Jul 2024 13:54:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722002050;
	bh=UFgNUcpYgW4o7ZGGS3qHZ2uA3ZR6dmN7bRSfyKBELwI=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=EjA9/IChVbgv6Y30SlmfzA6Gb+5E3ZEVI5Y1RPpg5/EFpOZ2YjSxEuZsOgBZL1zb8
	 P7JW4IIIzluCbZi96xhJinmarrBXxihKCX7DSWcTK1DrEkxEF32jzmbZJVZuGGMsDa
	 8wDV1TcwUEqhPmqAs++zmzQYRBYb5FF/rjDKWiQ2lZBEFtKmgTOVj/vYxYRvxiZJsZ
	 HJIBAv8DugwU7kRYz/rXBNcBtCC/CeA0erNB297o8HWzAQRLLonjIt6Hm/722/R2HL
	 vnaN4TwNVGYHRTXkr9iBCk4UQByyysmehCA1r5tq2Var01CCfYqCR52f8DqcdpNoAj
	 jRzohiVvtimNw==
Message-ID: <5d5df6d434189a19ca0be3d37cf1a2f4b7e60008.camel@kernel.org>
Subject: Re: [PATCH rfc 2/2] NFSD: allow client to use write delegation
 stateid for READ
From: Jeff Layton <jlayton@kernel.org>
To: Sagi Grimberg <sagi@grimberg.me>, Chuck Lever <chuck.lever@oracle.com>
Cc: Dai Ngo <dai.ngo@oracle.com>, linux-nfs@vger.kernel.org
Date: Fri, 26 Jul 2024 09:54:08 -0400
In-Reply-To: <20240724170138.1942307-2-sagi@grimberg.me>
References: <20240724170138.1942307-1-sagi@grimberg.me>
	 <20240724170138.1942307-2-sagi@grimberg.me>
Autocrypt: addr=jlayton@kernel.org; prefer-encrypt=mutual;
 keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.4 (3.50.4-1.fc39) 
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2024-07-24 at 10:01 -0700, Sagi Grimberg wrote:
> Based on a patch fom Dai Ngo, allow NFSv4 client to use write delegation
> stateid for READ operation. Per RFC 8881 section 9.1.2. Use of the
> Stateid and Locking.
>=20
> In addition, for anonymous stateids, check for pending delegations by
> the filehandle and client_id, and if a conflict found, recall the delegat=
ion
> before allowing the read to take place.
>=20
> Suggested-by: Dai Ngo <dai.ngo@oracle.com>
> Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
> ---
> =C2=A0fs/nfsd/nfs4proc.c=C2=A0 | 22 +++++++++++++++++++--
> =C2=A0fs/nfsd/nfs4state.c | 47 ++++++++++++++++++++++++++++++++++++++++++=
+++
> =C2=A0fs/nfsd/nfs4xdr.c=C2=A0=C2=A0 |=C2=A0 9 +++++++++
> =C2=A0fs/nfsd/state.h=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 2 ++
> =C2=A0fs/nfsd/xdr4.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 2 ++
> =C2=A05 files changed, 80 insertions(+), 2 deletions(-)
>=20
> diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
> index 7b70309ad8fb..324984ec70c6 100644
> --- a/fs/nfsd/nfs4proc.c
> +++ b/fs/nfsd/nfs4proc.c
> @@ -979,8 +979,24 @@ nfsd4_read(struct svc_rqst *rqstp, struct nfsd4_comp=
ound_state *cstate,
> =C2=A0	/* check stateid */
> =C2=A0	status =3D nfs4_preprocess_stateid_op(rqstp, cstate, &cstate->curr=
ent_fh,
> =C2=A0					&read->rd_stateid, RD_STATE,
> -					&read->rd_nf, NULL);
> -
> +					&read->rd_nf, &read->rd_wd_stid);

In the case where we have multiple stateids for this client, are we
guaranteed to get back the delegation stateid here? What if we get back
the open stateid for the O_WRONLY open instead?


> +	/*
> +	 * rd_wd_stid is needed for nfsd4_encode_read to allow write
> +	 * delegation stateid used for read. Its refcount is decremented
> +	 * by nfsd4_read_release when read is done.
> +	 */
> +	if (!status) {
> +		if (!read->rd_wd_stid) {
> +			/* special stateid? */
> +			status =3D nfsd4_deleg_read_conflict(rqstp, cstate->clp,
> +				&cstate->current_fh);
> +		} else if (read->rd_wd_stid->sc_type !=3D SC_TYPE_DELEG ||
> +			=C2=A0=C2=A0 delegstateid(read->rd_wd_stid)->dl_type !=3D
> +						NFS4_OPEN_DELEGATE_WRITE) {
> +			nfs4_put_stid(read->rd_wd_stid);
> +			read->rd_wd_stid =3D NULL;
> +		}
> +	}
> =C2=A0	read->rd_rqstp =3D rqstp;
> =C2=A0	read->rd_fhp =3D &cstate->current_fh;
> =C2=A0	return status;
> @@ -990,6 +1006,8 @@ nfsd4_read(struct svc_rqst *rqstp, struct nfsd4_comp=
ound_state *cstate,
> =C2=A0static void
> =C2=A0nfsd4_read_release(union nfsd4_op_u *u)
> =C2=A0{
> +	if (u->read.rd_wd_stid)
> +		nfs4_put_stid(u->read.rd_wd_stid);
> =C2=A0	if (u->read.rd_nf)
> =C2=A0		nfsd_file_put(u->read.rd_nf);
> =C2=A0	trace_nfsd_read_done(u->read.rd_rqstp, u->read.rd_fhp,
> diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
> index dc61a8adfcd4..7e6b9fb31a4c 100644
> --- a/fs/nfsd/nfs4state.c
> +++ b/fs/nfsd/nfs4state.c
> @@ -8805,6 +8805,53 @@ nfsd4_get_writestateid(struct nfsd4_compound_state=
 *cstate,
> =C2=A0	get_stateid(cstate, &u->write.wr_stateid);
> =C2=A0}
> =C2=A0
> +/**
> + * nfsd4_deleg_read_conflict - Recall if read causes conflict
> + * @rqstp: RPC transaction context
> + * @clp: nfs client
> + * @fhp: nfs file handle
> + * @inode: file to be checked for a conflict
> + * @modified: return true if file was modified
> + * @size: new size of file if modified is true
> + *
> + * This function is called when there is a conflict between a write
> + * delegation and a read that is using a special stateid where the
> + * we cannot derive the client stateid exsistence. The server
> + * must recall a conflicting delegation before allowing the read
> + * to continue.
> + *
> + * Returns 0 if there is no conflict; otherwise an nfs_stat
> + * code is returned.
> + */
> +__be32 nfsd4_deleg_read_conflict(struct svc_rqst *rqstp,
> +		struct nfs4_client *clp, struct svc_fh *fhp)
> +{
> +	struct nfs4_file *fp;
> +	__be32 status =3D 0;
> +
> +	fp =3D nfsd4_file_hash_lookup(fhp);
> +	if (!fp)
> +		return nfs_ok;
> +
> +	spin_lock(&state_lock);
> +	spin_lock(&fp->fi_lock);
> +	if (!list_empty(&fp->fi_delegations) &&
> +	=C2=A0=C2=A0=C2=A0 !nfs4_delegation_exists(clp, fp)) {
> +		/* conflict, recall deleg */
> +		status =3D nfserrno(nfsd_open_break_lease(fp->fi_inode,
> +					NFSD_MAY_READ));
> +		if (status)
> +			goto out;
> +		if (!nfsd_wait_for_delegreturn(rqstp, fp->fi_inode))
> +			status =3D nfserr_jukebox;
> +	}
> +out:
> +	spin_unlock(&fp->fi_lock);
> +	spin_unlock(&state_lock);
> +	return status;
> +}
> +
> +
> =C2=A0/**
> =C2=A0 * nfsd4_deleg_getattr_conflict - Recall if GETATTR causes conflict
> =C2=A0 * @rqstp: RPC transaction context
> diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
> index c7bfd2180e3f..f0fe526fac3c 100644
> --- a/fs/nfsd/nfs4xdr.c
> +++ b/fs/nfsd/nfs4xdr.c
> @@ -4418,6 +4418,7 @@ nfsd4_encode_read(struct nfsd4_compoundres *resp, _=
_be32 nfserr,
> =C2=A0	unsigned long maxcount;
> =C2=A0	struct file *file;
> =C2=A0	__be32 *p;
> +	fmode_t o_fmode =3D 0;
> =C2=A0
> =C2=A0	if (nfserr)
> =C2=A0		return nfserr;
> @@ -4437,10 +4438,18 @@ nfsd4_encode_read(struct nfsd4_compoundres *resp,=
 __be32 nfserr,
> =C2=A0	maxcount =3D min_t(unsigned long, read->rd_length,
> =C2=A0			 (xdr->buf->buflen - xdr->buf->len));
> =C2=A0
> +	if (read->rd_wd_stid) {
> +		/* allow READ using write delegation stateid */
> +		o_fmode =3D file->f_mode;
> +		file->f_mode |=3D FMODE_READ;
> +	}
> =C2=A0	if (file->f_op->splice_read && splice_ok)
> =C2=A0		nfserr =3D nfsd4_encode_splice_read(resp, read, file, maxcount);
> =C2=A0	else
> =C2=A0		nfserr =3D nfsd4_encode_readv(resp, read, file, maxcount);
> +	if (o_fmode)
> +		file->f_mode =3D o_fmode;
> +
> =C2=A0	if (nfserr) {
> =C2=A0		xdr_truncate_encode(xdr, starting_len);
> =C2=A0		return nfserr;
> diff --git a/fs/nfsd/state.h b/fs/nfsd/state.h
> index ffc217099d19..c1f13b5877c6 100644
> --- a/fs/nfsd/state.h
> +++ b/fs/nfsd/state.h
> @@ -780,6 +780,8 @@ static inline bool try_to_expire_client(struct nfs4_c=
lient *clp)
> =C2=A0	return clp->cl_state =3D=3D NFSD4_EXPIRABLE;
> =C2=A0}
> =C2=A0
> +extern __be32 nfsd4_deleg_read_conflict(struct svc_rqst *rqstp,
> +		struct nfs4_client *clp, struct svc_fh *fhp);
> =C2=A0extern __be32 nfsd4_deleg_getattr_conflict(struct svc_rqst *rqstp,
> =C2=A0		struct inode *inode, bool *file_modified, u64 *size);
> =C2=A0#endif=C2=A0=C2=A0 /* NFSD4_STATE_H */
> diff --git a/fs/nfsd/xdr4.h b/fs/nfsd/xdr4.h
> index fbdd42cde1fa..434973a6a8b1 100644
> --- a/fs/nfsd/xdr4.h
> +++ b/fs/nfsd/xdr4.h
> @@ -426,6 +426,8 @@ struct nfsd4_read {
> =C2=A0	struct svc_rqst		*rd_rqstp;=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 /* response */
> =C2=A0	struct svc_fh		*rd_fhp;=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 /* response */
> =C2=A0	u32			rd_eof;=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 /* response */
> +
> +	struct nfs4_stid	*rd_wd_stid;		/* internal */
> =C2=A0};
> =C2=A0
> =C2=A0struct nfsd4_readdir {

--=20
Jeff Layton <jlayton@kernel.org>


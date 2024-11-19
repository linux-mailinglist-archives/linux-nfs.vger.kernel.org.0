Return-Path: <linux-nfs+bounces-8106-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BB949D1CF4
	for <lists+linux-nfs@lfdr.de>; Tue, 19 Nov 2024 02:10:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A51EFB22D6F
	for <lists+linux-nfs@lfdr.de>; Tue, 19 Nov 2024 01:10:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59D2E4E1CA;
	Tue, 19 Nov 2024 01:09:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MbQ4ItBJ"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25F2E4436E;
	Tue, 19 Nov 2024 01:09:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731978578; cv=none; b=JgG0exqEWJtCbVbCaSpBwcXX+vb6wW4jebRQuejv0KcarhF7ombvOF1gq2psKSgaGbM7+v4spY53bxu8OBPqW5tn67W3yhMmBh5jeceAxUiSetIJpNgQ0c+UO+zyGmym31sF0b/gVtn/cp9tTUtj6CBPn2xRiloQ0D8/hf6uKUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731978578; c=relaxed/simple;
	bh=ZgkmGU0eJUJXLc6hXE922i2xkeo4oKBAlHGGE9Ta0Yo=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=H0EFn434Ko5pB2MVFPzBYCBW6mpaxsqOBOBnY0EPSPKUln2cZqDdgNUeGZSNSLbbesQN/iKSlYpMMtnkmniUELwnwfqvkBBBuoMn8FUkIPO6Yf/aYntjEjyi1liXH2EYEmLHG3Ms2ilV3S5ir1S5RQQrwZAa21S9RbusuhRArsY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MbQ4ItBJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D34DC4CECC;
	Tue, 19 Nov 2024 01:09:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731978577;
	bh=ZgkmGU0eJUJXLc6hXE922i2xkeo4oKBAlHGGE9Ta0Yo=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=MbQ4ItBJQlkQNm5vCdObRg70rQIW71QNNSMLhFcd7QscuswdbsHssLpQb8wlisaBb
	 7Uz6dalpQmapznweibJWWwLMVK7hpbQZB9Y2cd7v+61C+YyoAqTymulTnmTAXD9VaW
	 rS0GEKrUTLUhWQenuX5aNFhIVlcBgLymo0nws7LgtqaqiH6Jic5Ak0uXWaL0VCxRWs
	 ZXchalHSGMmyRZkwvqXa5yknQ6jMnvXIVBVL6j0yvDMYLVv8TajmrBv5C3DEQ8+ZIQ
	 mtqtwGqNt94lO9Mwfp12O/apAxYXqKYVoDfVbtdsvDcnRmEQZST0lANzRMvjQQr9Td
	 3/8QDZ4SalG9A==
Message-ID: <b68d500c1199888a98d2cafbcefb50a7aa031fbd.camel@kernel.org>
Subject: Re: [PATCH 5/6] nfsd: add support for delegated timestamps
From: Jeff Layton <jlayton@kernel.org>
To: Chuck Lever <chuck.lever@oracle.com>, NeilBrown <neilb@suse.de>
Cc: Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, 
 Tom Talpey <tom@talpey.com>, Jonathan Corbet <corbet@lwn.net>, Trond
 Myklebust <trondmy@kernel.org>,  Anna Schumaker	 <anna@kernel.org>, Thomas
 Haynes <loghyr@gmail.com>, linux-nfs@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
Date: Mon, 18 Nov 2024 20:09:35 -0500
In-Reply-To: <Zzvj3BdZg2sxB+SF@tissot.1015granger.net>
References: <20241014-delstid-v1-0-7ce8a2f4dd24@kernel.org>
	 <20241014-delstid-v1-5-7ce8a2f4dd24@kernel.org>
	 <173197809388.1734440.12511559535515038071@noble.neil.brown.name>
	 <Zzvj3BdZg2sxB+SF@tissot.1015granger.net>
Autocrypt: addr=jlayton@kernel.org; prefer-encrypt=mutual;
 keydata=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
 QZIQXVeAA+smfTT0tDrisj1U5x6ZB9b3nBg65kc=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.1 (3.54.1-1.fc41app1) 
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2024-11-18 at 20:03 -0500, Chuck Lever wrote:
> On Tue, Nov 19, 2024 at 12:01:33PM +1100, NeilBrown wrote:
> > On Tue, 15 Oct 2024, Jeff Layton wrote:
> > > Add support for the delegated timestamps on write delegations. This
> > > allows the server to proxy timestamps from the delegation holder to
> > > other clients that are doing GETATTRs vs. the same inode.
> > >=20
> > > When OPEN4_SHARE_ACCESS_WANT_DELEG_TIMESTAMPS bit is set in the OPEN
> > > call, set the dl_type to the *_ATTRS_DELEG flavor of delegation.
> > >=20
> > > Add timespec64 fields to nfs4_cb_fattr and decode the timestamps into
> > > those. Vet those timestamps according to the delstid spec and update
> > > the inode attrs if necessary.
> > >=20
> > > Signed-off-by: Jeff Layton <jlayton@kernel.org>
> > > Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
> > > ---
> > >  fs/nfsd/nfs4callback.c | 42 +++++++++++++++++++--
> > >  fs/nfsd/nfs4state.c    | 99 ++++++++++++++++++++++++++++++++++++++++=
+++-------
> > >  fs/nfsd/nfs4xdr.c      | 13 ++++++-
> > >  fs/nfsd/nfsd.h         |  2 +
> > >  fs/nfsd/state.h        |  2 +
> > >  fs/nfsd/xdr4cb.h       | 10 +++--
> > >  include/linux/time64.h |  5 +++
> > >  7 files changed, 151 insertions(+), 22 deletions(-)
> > >=20
> > > diff --git a/fs/nfsd/nfs4callback.c b/fs/nfsd/nfs4callback.c
> > > index 776838bb83e6b707a4df76326cdc68f32daf1755..08245596289a960eb8b2e=
78df276544e7d3f4ff8 100644
> > > --- a/fs/nfsd/nfs4callback.c
> > > +++ b/fs/nfsd/nfs4callback.c
> > > @@ -42,6 +42,7 @@
> > >  #include "trace.h"
> > >  #include "xdr4cb.h"
> > >  #include "xdr4.h"
> > > +#include "nfs4xdr_gen.h"
> > > =20
> > >  #define NFSDDBG_FACILITY                NFSDDBG_PROC
> > > =20
> > > @@ -93,12 +94,35 @@ static int decode_cb_fattr4(struct xdr_stream *xd=
r, uint32_t *bitmap,
> > >  {
> > >  	fattr->ncf_cb_change =3D 0;
> > >  	fattr->ncf_cb_fsize =3D 0;
> > > +	fattr->ncf_cb_atime.tv_sec =3D 0;
> > > +	fattr->ncf_cb_atime.tv_nsec =3D 0;
> > > +	fattr->ncf_cb_mtime.tv_sec =3D 0;
> > > +	fattr->ncf_cb_mtime.tv_nsec =3D 0;
> > > +
> > >  	if (bitmap[0] & FATTR4_WORD0_CHANGE)
> > >  		if (xdr_stream_decode_u64(xdr, &fattr->ncf_cb_change) < 0)
> > >  			return -NFSERR_BAD_XDR;
> > >  	if (bitmap[0] & FATTR4_WORD0_SIZE)
> > >  		if (xdr_stream_decode_u64(xdr, &fattr->ncf_cb_fsize) < 0)
> > >  			return -NFSERR_BAD_XDR;
> > > +	if (bitmap[2] & FATTR4_WORD2_TIME_DELEG_ACCESS) {
> > > +		fattr4_time_deleg_access access;
> > > +
> > > +		if (!xdrgen_decode_fattr4_time_deleg_access(xdr, &access))
> > > +			return -NFSERR_BAD_XDR;
> > > +		fattr->ncf_cb_atime.tv_sec =3D access.seconds;
> > > +		fattr->ncf_cb_atime.tv_nsec =3D access.nseconds;
> > > +
> > > +	}
> > > +	if (bitmap[2] & FATTR4_WORD2_TIME_DELEG_MODIFY) {
> > > +		fattr4_time_deleg_modify modify;
> > > +
> > > +		if (!xdrgen_decode_fattr4_time_deleg_modify(xdr, &modify))
> > > +			return -NFSERR_BAD_XDR;
> > > +		fattr->ncf_cb_mtime.tv_sec =3D modify.seconds;
> > > +		fattr->ncf_cb_mtime.tv_nsec =3D modify.nseconds;
> > > +
> > > +	}
> > >  	return 0;
> > >  }
> > > =20
> > > @@ -364,15 +388,21 @@ encode_cb_getattr4args(struct xdr_stream *xdr, =
struct nfs4_cb_compound_hdr *hdr,
> > >  	struct nfs4_delegation *dp =3D container_of(fattr, struct nfs4_dele=
gation, dl_cb_fattr);
> > >  	struct knfsd_fh *fh =3D &dp->dl_stid.sc_file->fi_fhandle;
> > >  	struct nfs4_cb_fattr *ncf =3D &dp->dl_cb_fattr;
> > > -	u32 bmap[1];
> > > +	u32 bmap_size =3D 1;
> > > +	u32 bmap[3];
> > > =20
> > >  	bmap[0] =3D FATTR4_WORD0_SIZE;
> > >  	if (!ncf->ncf_file_modified)
> > >  		bmap[0] |=3D FATTR4_WORD0_CHANGE;
> > > =20
> > > +	if (deleg_attrs_deleg(dp->dl_type)) {
> > > +		bmap[1] =3D 0;
> > > +		bmap[2] =3D FATTR4_WORD2_TIME_DELEG_ACCESS | FATTR4_WORD2_TIME_DEL=
EG_MODIFY;
> > > +		bmap_size =3D 3;
> > > +	}
> > >  	encode_nfs_cb_opnum4(xdr, OP_CB_GETATTR);
> > >  	encode_nfs_fh4(xdr, fh);
> > > -	encode_bitmap4(xdr, bmap, ARRAY_SIZE(bmap));
> > > +	encode_bitmap4(xdr, bmap, bmap_size);
> > >  	hdr->nops++;
> > >  }
> > > =20
> > > @@ -597,7 +627,7 @@ static int nfs4_xdr_dec_cb_getattr(struct rpc_rqs=
t *rqstp,
> > >  	struct nfs4_cb_compound_hdr hdr;
> > >  	int status;
> > >  	u32 bitmap[3] =3D {0};
> > > -	u32 attrlen;
> > > +	u32 attrlen, maxlen;
> > >  	struct nfs4_cb_fattr *ncf =3D
> > >  		container_of(cb, struct nfs4_cb_fattr, ncf_getattr);
> > > =20
> > > @@ -616,7 +646,11 @@ static int nfs4_xdr_dec_cb_getattr(struct rpc_rq=
st *rqstp,
> > >  		return -NFSERR_BAD_XDR;
> > >  	if (xdr_stream_decode_u32(xdr, &attrlen) < 0)
> > >  		return -NFSERR_BAD_XDR;
> > > -	if (attrlen > (sizeof(ncf->ncf_cb_change) + sizeof(ncf->ncf_cb_fsiz=
e)))
> > > +	maxlen =3D sizeof(ncf->ncf_cb_change) + sizeof(ncf->ncf_cb_fsize);
> > > +	if (bitmap[2] !=3D 0)
> > > +		maxlen +=3D (sizeof(ncf->ncf_cb_mtime.tv_sec) +
> > > +			   sizeof(ncf->ncf_cb_mtime.tv_nsec)) * 2;
> > > +	if (attrlen > maxlen)
> > >  		return -NFSERR_BAD_XDR;
> > >  	status =3D decode_cb_fattr4(xdr, bitmap, ncf);
> > >  	return status;
> > > diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
> > > index 62f9aeb159d0f2ab4d293bf5c0c56ad7b86eb9d6..2c8d2bb5261ad189c6dfb=
1c4050c23d8cf061325 100644
> > > --- a/fs/nfsd/nfs4state.c
> > > +++ b/fs/nfsd/nfs4state.c
> > > @@ -5803,13 +5803,14 @@ static struct nfs4_delegation *
> > >  nfs4_set_delegation(struct nfsd4_open *open, struct nfs4_ol_stateid =
*stp,
> > >  		    struct svc_fh *parent)
> > >  {
> > > -	int status =3D 0;
> > > +	bool deleg_ts =3D open->op_deleg_want & OPEN4_SHARE_ACCESS_WANT_DEL=
EG_TIMESTAMPS;
> > >  	struct nfs4_client *clp =3D stp->st_stid.sc_client;
> > >  	struct nfs4_file *fp =3D stp->st_stid.sc_file;
> > >  	struct nfs4_clnt_odstate *odstate =3D stp->st_clnt_odstate;
> > >  	struct nfs4_delegation *dp;
> > >  	struct nfsd_file *nf =3D NULL;
> > >  	struct file_lease *fl;
> > > +	int status =3D 0;
> > >  	u32 dl_type;
> > > =20
> > >  	/*
> > > @@ -5834,7 +5835,7 @@ nfs4_set_delegation(struct nfsd4_open *open, st=
ruct nfs4_ol_stateid *stp,
> > >  	 */
> > >  	if ((open->op_share_access & NFS4_SHARE_ACCESS_BOTH) =3D=3D NFS4_SH=
ARE_ACCESS_BOTH) {
> > >  		nf =3D find_rw_file(fp);
> > > -		dl_type =3D OPEN_DELEGATE_WRITE;
> > > +		dl_type =3D deleg_ts ? OPEN_DELEGATE_WRITE_ATTRS_DELEG : OPEN_DELE=
GATE_WRITE;
> > >  	}
> > > =20
> > >  	/*
> > > @@ -5843,7 +5844,7 @@ nfs4_set_delegation(struct nfsd4_open *open, st=
ruct nfs4_ol_stateid *stp,
> > >  	 */
> > >  	if (!nf && (open->op_share_access & NFS4_SHARE_ACCESS_READ)) {
> > >  		nf =3D find_readable_file(fp);
> > > -		dl_type =3D OPEN_DELEGATE_READ;
> > > +		dl_type =3D deleg_ts ? OPEN_DELEGATE_READ_ATTRS_DELEG : OPEN_DELEG=
ATE_READ;
> > >  	}
> > > =20
> > >  	if (!nf)
> > > @@ -6001,13 +6002,14 @@ static void
> > >  nfs4_open_delegation(struct nfsd4_open *open, struct nfs4_ol_stateid=
 *stp,
> > >  		     struct svc_fh *currentfh)
> > >  {
> > > -	struct nfs4_delegation *dp;
> > > +	bool deleg_ts =3D open->op_deleg_want & OPEN4_SHARE_ACCESS_WANT_DEL=
EG_TIMESTAMPS;
> > >  	struct nfs4_openowner *oo =3D openowner(stp->st_stateowner);
> > >  	struct nfs4_client *clp =3D stp->st_stid.sc_client;
> > >  	struct svc_fh *parent =3D NULL;
> > > -	int cb_up;
> > > -	int status =3D 0;
> > > +	struct nfs4_delegation *dp;
> > >  	struct kstat stat;
> > > +	int status =3D 0;
> > > +	int cb_up;
> > > =20
> > >  	cb_up =3D nfsd4_cb_channel_good(oo->oo_owner.so_client);
> > >  	open->op_recall =3D false;
> > > @@ -6048,12 +6050,14 @@ nfs4_open_delegation(struct nfsd4_open *open,=
 struct nfs4_ol_stateid *stp,
> > >  			destroy_delegation(dp);
> > >  			goto out_no_deleg;
> > >  		}
> > > -		open->op_delegate_type =3D OPEN_DELEGATE_WRITE;
> > > +		open->op_delegate_type =3D deleg_ts ? OPEN_DELEGATE_WRITE_ATTRS_DE=
LEG :
> > > +						    OPEN_DELEGATE_WRITE;
> > >  		dp->dl_cb_fattr.ncf_cur_fsize =3D stat.size;
> > >  		dp->dl_cb_fattr.ncf_initial_cinfo =3D nfsd4_change_attribute(&stat=
);
> > >  		trace_nfsd_deleg_write(&dp->dl_stid.sc_stateid);
> > >  	} else {
> > > -		open->op_delegate_type =3D OPEN_DELEGATE_READ;
> > > +		open->op_delegate_type =3D deleg_ts ? OPEN_DELEGATE_READ_ATTRS_DEL=
EG :
> > > +						    OPEN_DELEGATE_READ;
> > >  		trace_nfsd_deleg_read(&dp->dl_stid.sc_stateid);
> > >  	}
> > >  	nfs4_put_stid(&dp->dl_stid);
> > > @@ -8887,6 +8891,78 @@ nfsd4_get_writestateid(struct nfsd4_compound_s=
tate *cstate,
> > >  	get_stateid(cstate, &u->write.wr_stateid);
> > >  }
> > > =20
> > > +/**
> > > + * set_cb_time - vet and set the timespec for a cb_getattr update
> > > + * @cb: timestamp from the CB_GETATTR response
> > > + * @orig: original timestamp in the inode
> > > + * @now: current time
> > > + *
> > > + * Given a timestamp in a CB_GETATTR response, check it against the
> > > + * current timestamp in the inode and the current time. Returns true
> > > + * if the inode's timestamp needs to be updated, and false otherwise=
.
> > > + * @cb may also be changed if the timestamp needs to be clamped.
> > > + */
> > > +static bool set_cb_time(struct timespec64 *cb, const struct timespec=
64 *orig,
> > > +			const struct timespec64 *now)
> > > +{
> > > +
> > > +	/*
> > > +	 * "When the time presented is before the original time, then the
> > > +	 *  update is ignored." Also no need to update if there is no chang=
e.
> > > +	 */
> > > +	if (timespec64_compare(cb, orig) <=3D 0)
> > > +		return false;
> > > +
> > > +	/*
> > > +	 * "When the time presented is in the future, the server can either
> > > +	 *  clamp the new time to the current time, or it may
> > > +	 *  return NFS4ERR_DELAY to the client, allowing it to retry."
> > > +	 */
> > > +	if (timespec64_compare(cb, now) > 0) {
> > > +		/* clamp it */
> > > +		*cb =3D *now;
> > > +	}
> > > +
> > > +	return true;
> > > +}
> > > +
> > > +static int cb_getattr_update_times(struct dentry *dentry, struct nfs=
4_delegation *dp)
> > > +{
> > > +	struct inode *inode =3D d_inode(dentry);
> > > +	struct timespec64 now =3D current_time(inode);
> > > +	struct nfs4_cb_fattr *ncf =3D &dp->dl_cb_fattr;
> > > +	struct iattr attrs =3D { };
> > > +	int ret;
> > > +
> > > +	if (deleg_attrs_deleg(dp->dl_type)) {
> > > +		struct timespec64 atime =3D inode_get_atime(inode);
> > > +		struct timespec64 mtime =3D inode_get_mtime(inode);
> > > +
> > > +		attrs.ia_atime =3D ncf->ncf_cb_atime;
> > > +		attrs.ia_mtime =3D ncf->ncf_cb_mtime;
> > > +
> > > +		if (set_cb_time(&attrs.ia_atime, &atime, &now))
> > > +			attrs.ia_valid |=3D ATTR_ATIME | ATTR_ATIME_SET;
> > > +
> > > +		if (set_cb_time(&attrs.ia_mtime, &mtime, &now)) {
> > > +			attrs.ia_valid |=3D ATTR_CTIME | ATTR_MTIME | ATTR_MTIME_SET;
> > > +			attrs.ia_ctime =3D attrs.ia_mtime;
> > > +		}
> > > +	} else {
> > > +		attrs.ia_valid |=3D ATTR_MTIME | ATTR_CTIME;
> > > +		attrs.ia_mtime =3D attrs.ia_ctime =3D now;
> > > +	}
> > > +
> > > +	if (!attrs.ia_valid)
> > > +		return 0;
> > > +
> > > +	attrs.ia_valid |=3D ATTR_DELEG;
> > > +	inode_lock(inode);
> > > +	ret =3D notify_change(&nop_mnt_idmap, dentry, &attrs, NULL);
> > > +	inode_unlock(inode);
> > > +	return ret;
> > > +}
> > > +
> > >  /**
> > >   * nfsd4_deleg_getattr_conflict - Recall if GETATTR causes conflict
> > >   * @rqstp: RPC transaction context
> > > @@ -8913,7 +8989,6 @@ nfsd4_deleg_getattr_conflict(struct svc_rqst *r=
qstp, struct dentry *dentry,
> > >  	struct file_lock_context *ctx;
> > >  	struct nfs4_delegation *dp =3D NULL;
> > >  	struct file_lease *fl;
> > > -	struct iattr attrs;
> > >  	struct nfs4_cb_fattr *ncf;
> > >  	struct inode *inode =3D d_inode(dentry);
> > > =20
> > > @@ -8975,11 +9050,7 @@ nfsd4_deleg_getattr_conflict(struct svc_rqst *=
rqstp, struct dentry *dentry,
> > >  		 * not update the file's metadata with the client's
> > >  		 * modified size
> > >  		 */
> > > -		attrs.ia_mtime =3D attrs.ia_ctime =3D current_time(inode);
> > > -		attrs.ia_valid =3D ATTR_MTIME | ATTR_CTIME | ATTR_DELEG;
> > > -		inode_lock(inode);
> > > -		err =3D notify_change(&nop_mnt_idmap, dentry, &attrs, NULL);
> > > -		inode_unlock(inode);
> > > +		err =3D cb_getattr_update_times(dentry, dp);
> > >  		if (err) {
> > >  			status =3D nfserrno(err);
> > >  			goto out_status;
> > > diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
> > > index 1c9d9349e4447c0078c7de0d533cf6278941679d..0e9f59f6be015bfa37893=
973f38fec880ff4c0b1 100644
> > > --- a/fs/nfsd/nfs4xdr.c
> > > +++ b/fs/nfsd/nfs4xdr.c
> > > @@ -3409,6 +3409,7 @@ static __be32 nfsd4_encode_fattr4_xattr_support=
(struct xdr_stream *xdr,
> > >  #define NFSD_OA_SHARE_ACCESS_WANT	(BIT(OPEN_ARGS_SHARE_ACCESS_WANT_A=
NY_DELEG)		| \
> > >  					 BIT(OPEN_ARGS_SHARE_ACCESS_WANT_NO_DELEG)		| \
> > >  					 BIT(OPEN_ARGS_SHARE_ACCESS_WANT_CANCEL)		| \
> > > +					 BIT(OPEN_ARGS_SHARE_ACCESS_WANT_DELEG_TIMESTAMPS)	| \
> > >  					 BIT(OPEN_ARGS_SHARE_ACCESS_WANT_OPEN_XOR_DELEGATION))
> > > =20
> > >  #define NFSD_OA_OPEN_CLAIM	(BIT(OPEN_ARGS_OPEN_CLAIM_NULL)		| \
> > > @@ -3602,7 +3603,11 @@ nfsd4_encode_fattr4(struct svc_rqst *rqstp, st=
ruct xdr_stream *xdr,
> > >  		if (status)
> > >  			goto out;
> > >  	}
> > > -	if (attrmask[0] & (FATTR4_WORD0_CHANGE | FATTR4_WORD0_SIZE)) {
> > > +	if ((attrmask[0] & (FATTR4_WORD0_CHANGE |
> > > +			    FATTR4_WORD0_SIZE)) ||
> > > +	    (attrmask[1] & (FATTR4_WORD1_TIME_ACCESS |
> > > +			    FATTR4_WORD1_TIME_MODIFY |
> > > +			    FATTR4_WORD1_TIME_METADATA))) {
> > >  		status =3D nfsd4_deleg_getattr_conflict(rqstp, dentry, &dp);
> > >  		if (status)
> > >  			goto out;
> > > @@ -3617,8 +3622,14 @@ nfsd4_encode_fattr4(struct svc_rqst *rqstp, st=
ruct xdr_stream *xdr,
> > >  		if (ncf->ncf_file_modified) {
> > >  			++ncf->ncf_initial_cinfo;
> > >  			args.stat.size =3D ncf->ncf_cur_fsize;
> > > +			if (!timespec64_is_epoch(&ncf->ncf_cb_mtime))
> > > +				args.stat.mtime =3D ncf->ncf_cb_mtime;
> > >  		}
> > >  		args.change_attr =3D ncf->ncf_initial_cinfo;
> > > +
> > > +		if (!timespec64_is_epoch(&ncf->ncf_cb_atime))
> > > +			args.stat.atime =3D ncf->ncf_cb_atime;
> > > +
> > >  		nfs4_put_stid(&dp->dl_stid);
> > >  	} else {
> > >  		args.change_attr =3D nfsd4_change_attribute(&args.stat);
> > > diff --git a/fs/nfsd/nfsd.h b/fs/nfsd/nfsd.h
> > > index 1955c8e9c4c793728fa75dd136cadc735245483f..004415651295891b3440f=
52a4c986e3a668a48cb 100644
> > > --- a/fs/nfsd/nfsd.h
> > > +++ b/fs/nfsd/nfsd.h
> > > @@ -459,6 +459,8 @@ enum {
> > >  	FATTR4_WORD2_MODE_UMASK | \
> > >  	NFSD4_2_SECURITY_ATTRS | \
> > >  	FATTR4_WORD2_XATTR_SUPPORT | \
> > > +	FATTR4_WORD2_TIME_DELEG_ACCESS | \
> > > +	FATTR4_WORD2_TIME_DELEG_MODIFY | \
> >=20
> > This breaks 4.2 mounts for me (in latest nfsd-nexT).  OPEN fails.
>=20
> Yep, we're on it.
>=20

I see the problem. The OPEN_XOR_DELEGATION patch reworked some of the
NFS4_SHARE_WANT_* handling, and this patch relied on those changes.
When that patch was dropped, it broke this patch.

What we should probably do is split out the flag rework from that patch
into a separate patch that this can rely on. Not sure if you want to
embark upon all of that during the merge window though. It may be
better to just drop these patches as well.

=20
>=20
> > By setting these bits we tell the client that we support timestamp
> > delegation, but you haven't updated nfsd4_decode_share_access() to
> > understand NFS4_SHARE_WANT_DELEG_TIMESTAMPS in the 'share' flags for an
> > OPEN request.  So the server responds with BADXDR to OPEN requests now.
> >=20
> > Mounting with v4.1 still works.
> >=20
> > NeilBrown
> >=20
> >=20
> > >  	FATTR4_WORD2_OPEN_ARGUMENTS)
> > > =20
> > >  extern const u32 nfsd_suppattrs[3][3];
> > > diff --git a/fs/nfsd/state.h b/fs/nfsd/state.h
> > > index 9d0e844515aa6ea0ec62f2b538ecc2c6a5e34652..6351e6eca7cc63ccf82a3=
a081cef39042d52f4e9 100644
> > > --- a/fs/nfsd/state.h
> > > +++ b/fs/nfsd/state.h
> > > @@ -142,6 +142,8 @@ struct nfs4_cb_fattr {
> > >  	/* from CB_GETATTR reply */
> > >  	u64 ncf_cb_change;
> > >  	u64 ncf_cb_fsize;
> > > +	struct timespec64 ncf_cb_mtime;
> > > +	struct timespec64 ncf_cb_atime;
> > > =20
> > >  	unsigned long ncf_cb_flags;
> > >  	bool ncf_file_modified;
> > > diff --git a/fs/nfsd/xdr4cb.h b/fs/nfsd/xdr4cb.h
> > > index e8b00309c449fe2667f7d48cda88ec0cff924f93..f1a315cd31b74f73f1d52=
702ae7b5c93d51ddf82 100644
> > > --- a/fs/nfsd/xdr4cb.h
> > > +++ b/fs/nfsd/xdr4cb.h
> > > @@ -59,16 +59,20 @@
> > >   * 1: CB_GETATTR opcode (32-bit)
> > >   * N: file_handle
> > >   * 1: number of entry in attribute array (32-bit)
> > > - * 1: entry 0 in attribute array (32-bit)
> > > + * 3: entry 0-2 in attribute array (32-bit * 3)
> > >   */
> > >  #define NFS4_enc_cb_getattr_sz		(cb_compound_enc_hdr_sz +       \
> > >  					cb_sequence_enc_sz +            \
> > > -					1 + enc_nfs4_fh_sz + 1 + 1)
> > > +					1 + enc_nfs4_fh_sz + 1 + 3)
> > >  /*
> > >   * 4: fattr_bitmap_maxsz
> > >   * 1: attribute array len
> > >   * 2: change attr (64-bit)
> > >   * 2: size (64-bit)
> > > + * 2: atime.seconds (64-bit)
> > > + * 1: atime.nanoseconds (32-bit)
> > > + * 2: mtime.seconds (64-bit)
> > > + * 1: mtime.nanoseconds (32-bit)
> > >   */
> > >  #define NFS4_dec_cb_getattr_sz		(cb_compound_dec_hdr_sz  +      \
> > > -			cb_sequence_dec_sz + 4 + 1 + 2 + 2 + op_dec_sz)
> > > +			cb_sequence_dec_sz + 4 + 1 + 2 + 2 + 2 + 1 + 2 + 1 + op_dec_sz)
> > > diff --git a/include/linux/time64.h b/include/linux/time64.h
> > > index f1bcea8c124a361b6c1e3c98ef915840c22a8413..9934331c7b86b7fb981c7=
aec0494ac2f5e72977e 100644
> > > --- a/include/linux/time64.h
> > > +++ b/include/linux/time64.h
> > > @@ -49,6 +49,11 @@ static inline int timespec64_equal(const struct ti=
mespec64 *a,
> > >  	return (a->tv_sec =3D=3D b->tv_sec) && (a->tv_nsec =3D=3D b->tv_nse=
c);
> > >  }
> > > =20
> > > +static inline bool timespec64_is_epoch(const struct timespec64 *ts)
> > > +{
> > > +	return ts->tv_sec =3D=3D 0 && ts->tv_nsec =3D=3D 0;
> > > +}
> > > +
> > >  /*
> > >   * lhs < rhs:  return <0
> > >   * lhs =3D=3D rhs: return 0
> > >=20
> > > --=20
> > > 2.47.0
> > >=20
> > >=20
> > >=20
> >=20
>=20

--=20
Jeff Layton <jlayton@kernel.org>


Return-Path: <linux-nfs+bounces-10434-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BB13A4CAB2
	for <lists+linux-nfs@lfdr.de>; Mon,  3 Mar 2025 19:05:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0267C161867
	for <lists+linux-nfs@lfdr.de>; Mon,  3 Mar 2025 18:05:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FF9021771E;
	Mon,  3 Mar 2025 18:05:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gTFfC2pL"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED6901E32BE
	for <linux-nfs@vger.kernel.org>; Mon,  3 Mar 2025 18:05:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741025112; cv=none; b=f3vlbEN11v8UO4lciquOIYMsSRSUEk/rZ+ZUrdcbVPH1WyheheXzYA5fM/T1nxnKUx+kjCDUoO/0yvdyuVM+bzRk64aixqIa1G3S+bh8OsGQzdVWS+fC7nN0rbXuhFpoXFgHaC4Qd8i/v/2YKjrJJ3J4r4Tx4H5PvR0L7GCaqdw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741025112; c=relaxed/simple;
	bh=v46zj0TJVhOMNVTlZ9QLwIVuhS27jOz3eIqrvnGcHRY=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Gyw+QnWCxvWICz+isvFV4gh4ZX2sX9WOunIFMD2AsTrqSTTNReCrqH0udE0lcogR4coRAjQwL7+M8kwx5M8DKyHiHJuLRl8TX5+YreFiEYlaqC+oh5t0uMCHNBaFqH44BIhOQQqL5eMGu3aCPg8drQvpRP8lyrCXBFFBK6gJRZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gTFfC2pL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A092EC4CED6;
	Mon,  3 Mar 2025 18:05:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741025111;
	bh=v46zj0TJVhOMNVTlZ9QLwIVuhS27jOz3eIqrvnGcHRY=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=gTFfC2pLJMl/4ddhhijQNyvUN8ZMssf0nGK0eEgknLpJLIc1UyGZ0Rj2tlGTOGVS9
	 8zWlbjn+PDgvjcq1NpHtvdSRv1PucnU83SnT37dnPTWImKhLSaOMJSHrLT8jT0xB5+
	 lwXwGLgGlW5aw3jGGYaSQX2KYf7fWN1P/Kf2PVyduyX4QZ2L0oWUw6J7AaROfmRDak
	 Tw55db6XN5FpzWMB2yz7wHCRKbLZ2lxdP9XKBHyG6vfZJG3bOUH0MlxZQ4JAmDTu5G
	 FYRvBGi0nDpgEXQOFHQ3vVZkNwDO01kJe3Hs/0LP/iEMQ8wkjsQWMJEKkhAugCPp0C
	 KpKTSqze+EivA==
Message-ID: <c6707203ccf07646e62db9d5e806629f2d3c9d5b.camel@kernel.org>
Subject: Re: [PATCH v2 3/5] NFSD: Implement CB_SEQUENCE referring call lists
From: Jeff Layton <jlayton@kernel.org>
To: cel@kernel.org, Neil Brown <neilb@suse.de>, Olga Kornievskaia	
 <okorniev@redhat.com>, Dai Ngo <dai.ngo@oracle.com>, Tom Talpey
 <tom@talpey.com>
Cc: linux-nfs@vger.kernel.org, Chuck Lever <chuck.lever@oracle.com>
Date: Mon, 03 Mar 2025 13:05:09 -0500
In-Reply-To: <20250301183151.11362-4-cel@kernel.org>
References: <20250301183151.11362-1-cel@kernel.org>
	 <20250301183151.11362-4-cel@kernel.org>
Autocrypt: addr=jlayton@kernel.org; prefer-encrypt=mutual;
 keydata=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
 QZIQXVeAA+smfTT0tDrisj1U5x6ZB9b3nBg65kc=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.3 (3.54.3-1.fc41) 
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Sat, 2025-03-01 at 13:31 -0500, cel@kernel.org wrote:
> From: Chuck Lever <chuck.lever@oracle.com>
>=20
> We have yet to implement a mechanism in NFSD for resolving races
> between a server's reply and a related callback operation. For
> example, a CB_OFFLOAD callback can race with the matching COPY
> response. The client will not recognize the copy state ID in the
> CB_OFFLOAD callback until the COPY response arrives.
>=20
> Trond adds:
> > It is also needed for the same kind of race with delegation
> > recalls, layout recalls, CB_NOTIFY_DEVICEID and would also be
> > helpful (although not as strongly required) for CB_NOTIFY_LOCK.
>=20
> RFC 8881 Section 20.9.3 describes referring call lists this way:
> > The csa_referring_call_lists array is the list of COMPOUND
> > requests, identified by session ID, slot ID, and sequence ID.
> > These are requests that the client previously sent to the server.
> > These previous requests created state that some operation(s) in
> > the same CB_COMPOUND as the csa_referring_call_lists are
> > identifying. A session ID is included because leased state is tied
> > to a client ID, and a client ID can have multiple sessions. See
> > Section 2.10.6.3.
>=20
> Introduce the XDR infrastructure for populating the
> csa_referring_call_lists argument of CB_SEQUENCE. Subsequent patches
> will put the referring call list to use.
>=20
> Note that cb_sequence_enc_sz estimates that only zero or one rcl is
> included in each CB_SEQUENCE, but the new infrastructure can
> manage any number of referring calls.
>=20
> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
> ---
>  fs/nfsd/nfs4callback.c | 132 +++++++++++++++++++++++++++++++++++++++--
>  fs/nfsd/state.h        |  22 +++++++
>  fs/nfsd/xdr4cb.h       |   5 +-
>  3 files changed, 153 insertions(+), 6 deletions(-)
>=20
> diff --git a/fs/nfsd/nfs4callback.c b/fs/nfsd/nfs4callback.c
> index 484077200c5d..f1fffff69330 100644
> --- a/fs/nfsd/nfs4callback.c
> +++ b/fs/nfsd/nfs4callback.c
> @@ -419,6 +419,29 @@ static u32 highest_slotid(struct nfsd4_session *ses)
>  	return idx;
>  }
> =20
> +static void
> +encode_referring_call4(struct xdr_stream *xdr,
> +		       const struct nfsd4_referring_call *rc)
> +{
> +	encode_uint32(xdr, rc->rc_sequenceid);
> +	encode_uint32(xdr, rc->rc_slotid);
> +}
> +
> +static void
> +encode_referring_call_list4(struct xdr_stream *xdr,
> +			    const struct nfsd4_referring_call_list *rcl)
> +{
> +	struct nfsd4_referring_call *rc;
> +	__be32 *p;
> +
> +	p =3D xdr_reserve_space(xdr, NFS4_MAX_SESSIONID_LEN);
> +	xdr_encode_opaque_fixed(p, rcl->rcl_sessionid.data,
> +					NFS4_MAX_SESSIONID_LEN);
> +	encode_uint32(xdr, rcl->__nr_referring_calls);
> +	list_for_each_entry(rc, &rcl->rcl_referring_calls, __list)
> +		encode_referring_call4(xdr, rc);
> +}
> +
>  /*
>   * CB_SEQUENCE4args
>   *
> @@ -436,6 +459,7 @@ static void encode_cb_sequence4args(struct xdr_stream=
 *xdr,
>  				    struct nfs4_cb_compound_hdr *hdr)
>  {
>  	struct nfsd4_session *session =3D cb->cb_clp->cl_cb_session;
> +	struct nfsd4_referring_call_list *rcl;
>  	__be32 *p;
> =20
>  	if (hdr->minorversion =3D=3D 0)
> @@ -444,12 +468,16 @@ static void encode_cb_sequence4args(struct xdr_stre=
am *xdr,
>  	encode_nfs_cb_opnum4(xdr, OP_CB_SEQUENCE);
>  	encode_sessionid4(xdr, session);
> =20
> -	p =3D xdr_reserve_space(xdr, 4 + 4 + 4 + 4 + 4);
> +	p =3D xdr_reserve_space(xdr, XDR_UNIT * 4);
>  	*p++ =3D cpu_to_be32(session->se_cb_seq_nr[cb->cb_held_slot]);	/* csa_s=
equenceid */
>  	*p++ =3D cpu_to_be32(cb->cb_held_slot);		/* csa_slotid */
>  	*p++ =3D cpu_to_be32(highest_slotid(session)); /* csa_highest_slotid */
>  	*p++ =3D xdr_zero;			/* csa_cachethis */
> -	xdr_encode_empty_array(p);		/* csa_referring_call_lists */
> +
> +	/* csa_referring_call_lists */
> +	encode_uint32(xdr, cb->cb_nr_referring_call_list);
> +	list_for_each_entry(rcl, &cb->cb_referring_call_list, __list)
> +		encode_referring_call_list4(xdr, rcl);
> =20
>  	hdr->nops++;
>  }
> @@ -1306,10 +1334,102 @@ static void nfsd41_destroy_cb(struct nfsd4_callb=
ack *cb)
>  	nfsd41_cb_inflight_end(clp);
>  }
> =20
> -/*
> - * TODO: cb_sequence should support referring call lists, cachethis,
> - * and mark callback channel down on communication errors.
> +/**
> + * nfsd41_cb_referring_call - add a referring call to a callback operati=
on
> + * @cb: context of callback to add the rc to
> + * @sessionid: referring call's session ID
> + * @slotid: referring call's session slot index
> + * @seqno: referring call's slot sequence number
> + *
> + * Caller serializes access to @cb.
> + *
> + * NB: If memory allocation fails, the referring call is not added.
>   */
> +void nfsd41_cb_referring_call(struct nfsd4_callback *cb,
> +			      struct nfs4_sessionid *sessionid,
> +			      u32 slotid, u32 seqno)
> +{
> +	struct nfsd4_referring_call_list *rcl;
> +	struct nfsd4_referring_call *rc;
> +	bool found;
> +
> +	might_sleep();
> +
> +	found =3D false;
> +	list_for_each_entry(rcl, &cb->cb_referring_call_list, __list) {
> +		if (!memcmp(rcl->rcl_sessionid.data, sessionid->data,
> +			   NFS4_MAX_SESSIONID_LEN)) {
> +			found =3D true;
> +			break;
> +		}
> +	}
> +	if (!found) {
> +		rcl =3D kmalloc(sizeof(*rcl), GFP_KERNEL);
> +		if (!rcl)
> +			return;
> +		memcpy(rcl->rcl_sessionid.data, sessionid->data,
> +		       NFS4_MAX_SESSIONID_LEN);
> +		rcl->__nr_referring_calls =3D 0;
> +		INIT_LIST_HEAD(&rcl->rcl_referring_calls);
> +		list_add(&rcl->__list, &cb->cb_referring_call_list);
> +		cb->cb_nr_referring_call_list++;
> +	}
> +
> +	found =3D false;
> +	list_for_each_entry(rc, &rcl->rcl_referring_calls, __list) {
> +		if (rc->rc_sequenceid =3D=3D seqno && rc->rc_slotid =3D=3D slotid) {
> +			found =3D true;
> +			break;
> +		}
> +	}
> +	if (!found) {
> +		rc =3D kmalloc(sizeof(*rc), GFP_KERNEL);
> +		if (!rc)
> +			goto out;
> +		rc->rc_sequenceid =3D seqno;
> +		rc->rc_slotid =3D slotid;
> +		rcl->__nr_referring_calls++;
> +		list_add(&rc->__list, &rcl->rcl_referring_calls);
> +	}
> +
> +out:
> +	if (!rcl->__nr_referring_calls) {
> +		cb->cb_nr_referring_call_list--;
> +		kfree(rcl);
> +	}
> +}
> +
> +/**
> + * nfsd41_cb_destroy_referring_call_list - release referring call info
> + * @cb: context of a callback that has completed
> + *
> + * Callers who allocate referring calls using nfsd41_cb_referring_call()=
 must
> + * release those resources by calling nfsd41_cb_destroy_referring_call_l=
ist.
> + *
> + * Caller serializes access to @cb.
> + */
> +void nfsd41_cb_destroy_referring_call_list(struct nfsd4_callback *cb)
> +{
> +	struct nfsd4_referring_call_list *rcl;
> +	struct nfsd4_referring_call *rc;
> +
> +	while (!list_empty(&cb->cb_referring_call_list)) {
> +		rcl =3D list_first_entry(&cb->cb_referring_call_list,
> +				       struct nfsd4_referring_call_list,
> +				       __list);
> +
> +		while (!list_empty(&rcl->rcl_referring_calls)) {
> +			rc =3D list_first_entry(&rcl->rcl_referring_calls,
> +					      struct nfsd4_referring_call,
> +					      __list);
> +			list_del(&rc->__list);
> +			kfree(rc);
> +		}
> +		list_del(&rcl->__list);
> +		kfree(rcl);
> +	}
> +}
> +
>  static void nfsd4_cb_prepare(struct rpc_task *task, void *calldata)
>  {
>  	struct nfsd4_callback *cb =3D calldata;
> @@ -1625,6 +1745,8 @@ void nfsd4_init_cb(struct nfsd4_callback *cb, struc=
t nfs4_client *clp,
>  	cb->cb_status =3D 0;
>  	cb->cb_need_restart =3D false;
>  	cb->cb_held_slot =3D -1;
> +	cb->cb_nr_referring_call_list =3D 0;
> +	INIT_LIST_HEAD(&cb->cb_referring_call_list);
>  }
> =20
>  /**
> diff --git a/fs/nfsd/state.h b/fs/nfsd/state.h
> index 74d2d7b42676..b4af840fc4f9 100644
> --- a/fs/nfsd/state.h
> +++ b/fs/nfsd/state.h
> @@ -64,6 +64,21 @@ typedef struct {
>  	refcount_t		cs_count;
>  } copy_stateid_t;
> =20
> +struct nfsd4_referring_call {
> +	struct list_head	__list;
> +
> +	u32			rc_sequenceid;
> +	u32			rc_slotid;
> +};
> +
> +struct nfsd4_referring_call_list {
> +	struct list_head	__list;
> +
> +	struct nfs4_sessionid	rcl_sessionid;
> +	int			__nr_referring_calls;
> +	struct list_head	rcl_referring_calls;
> +};
> +

This set of nested lists is rather complex. Did you consider keeping a
single list and just adding the sessionid to nfsd4_referring_call? I
suppose that might mean you'd have to do more sessionid comparisons but
in general, I'd expect these lists to be short.


>  struct nfsd4_callback {
>  	struct nfs4_client *cb_clp;
>  	struct rpc_message cb_msg;
> @@ -73,6 +88,9 @@ struct nfsd4_callback {
>  	int cb_status;
>  	int cb_held_slot;
>  	bool cb_need_restart;
> +
> +	int cb_nr_referring_call_list;
> +	struct list_head cb_referring_call_list;
>  };
> =20
>  struct nfsd4_callback_ops {
> @@ -777,6 +795,10 @@ extern __be32 nfs4_check_open_reclaim(struct nfs4_cl=
ient *);
>  extern void nfsd4_probe_callback(struct nfs4_client *clp);
>  extern void nfsd4_probe_callback_sync(struct nfs4_client *clp);
>  extern void nfsd4_change_callback(struct nfs4_client *clp, struct nfs4_c=
b_conn *);
> +extern void nfsd41_cb_referring_call(struct nfsd4_callback *cb,
> +				     struct nfs4_sessionid *sessionid,
> +				     u32 slotid, u32 seqno);
> +extern void nfsd41_cb_destroy_referring_call_list(struct nfsd4_callback =
*cb);
>  extern void nfsd4_init_cb(struct nfsd4_callback *cb, struct nfs4_client =
*clp,
>  		const struct nfsd4_callback_ops *ops, enum nfsd4_cb_op op);
>  extern bool nfsd4_run_cb(struct nfsd4_callback *cb);
> diff --git a/fs/nfsd/xdr4cb.h b/fs/nfsd/xdr4cb.h
> index f1a315cd31b7..f4e29c0c701c 100644
> --- a/fs/nfsd/xdr4cb.h
> +++ b/fs/nfsd/xdr4cb.h
> @@ -6,8 +6,11 @@
>  #define cb_compound_enc_hdr_sz		4
>  #define cb_compound_dec_hdr_sz		(3 + (NFS4_MAXTAGLEN >> 2))
>  #define sessionid_sz			(NFS4_MAX_SESSIONID_LEN >> 2)
> +#define enc_referring_call4_sz		(1 + 1)
> +#define enc_referring_call_list4_sz	(sessionid_sz + 1 + \
> +					enc_referring_call4_sz)
>  #define cb_sequence_enc_sz		(sessionid_sz + 4 +             \
> -					1 /* no referring calls list yet */)
> +					enc_referring_call_list4_sz)
>  #define cb_sequence_dec_sz		(op_dec_sz + sessionid_sz + 4)
> =20
>  #define op_enc_sz			1

--=20
Jeff Layton <jlayton@kernel.org>


Return-Path: <linux-nfs+bounces-8104-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 08F219D1CDD
	for <lists+linux-nfs@lfdr.de>; Tue, 19 Nov 2024 02:01:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 830021F21F87
	for <lists+linux-nfs@lfdr.de>; Tue, 19 Nov 2024 01:01:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25E7B1DDEA;
	Tue, 19 Nov 2024 01:01:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="QopLtcNJ";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="T1dA7OW8";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="QopLtcNJ";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="T1dA7OW8"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5E6F847B;
	Tue, 19 Nov 2024 01:01:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731978109; cv=none; b=RrGSyyn7aa0RdxHTYtoHhbjFk8EDogcY13c60t/nt+vvD/S7HSFh1EgHe7Oju5X0BL4kuGB+0US767TcSmcK7BbcKcDfibix/KVSZ/3SwAdBXrllimtFYfxM1qP6ZNHYm2xZr9iUvzegu5U2rISyyZqAflDD1jdUNV0wydxmr6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731978109; c=relaxed/simple;
	bh=wHvAZvFmlPuBEYNa2paEUxZMr2K4FHwMSAflHklb7AE=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=IB+HYMVMk6UYAhAOBoGe3Mmsnx1GYWJjSboCZubQLcu1AjZ5Qq0Wrcy7O9Uv1H6NQv5VOhpCGZXxROH79/q5i5w6eLVedSVmI+ycamVCurBL8UdvLhU1VgskMLWY7Q3iWa3q1choMZDEapnTsE/V/4beolmoAwy63AjO0dqzbT4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=QopLtcNJ; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=T1dA7OW8; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=QopLtcNJ; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=T1dA7OW8; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 1CECF2115D;
	Tue, 19 Nov 2024 01:01:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1731978105; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gB1LGGE6XTQ4PZFgHCmSOLOV4WshWIibeyo4e3gI9sA=;
	b=QopLtcNJAAnHaaEgnCNB9Iau5/L+hvX4iqyUxRDkVkylQ/3PVeU6kgBag8il2XU+J2+LWb
	9NAq721YrQ5zU26szuZuLTj4dZdgHlB3NubcYccUJzvZIDZDevwTHotNabmgwlryT9lJJi
	ZdcnO+UqZoKVuVmlF2ZGq1wlansGSxA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1731978105;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gB1LGGE6XTQ4PZFgHCmSOLOV4WshWIibeyo4e3gI9sA=;
	b=T1dA7OW8xapZJrJVA/shlDJHZD+7JCHQ/98beXw6b+yFPRI0Odx1AbQtAXg8dBpDiemRSr
	NfSP7kemKyfLduBA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1731978105; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gB1LGGE6XTQ4PZFgHCmSOLOV4WshWIibeyo4e3gI9sA=;
	b=QopLtcNJAAnHaaEgnCNB9Iau5/L+hvX4iqyUxRDkVkylQ/3PVeU6kgBag8il2XU+J2+LWb
	9NAq721YrQ5zU26szuZuLTj4dZdgHlB3NubcYccUJzvZIDZDevwTHotNabmgwlryT9lJJi
	ZdcnO+UqZoKVuVmlF2ZGq1wlansGSxA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1731978105;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gB1LGGE6XTQ4PZFgHCmSOLOV4WshWIibeyo4e3gI9sA=;
	b=T1dA7OW8xapZJrJVA/shlDJHZD+7JCHQ/98beXw6b+yFPRI0Odx1AbQtAXg8dBpDiemRSr
	NfSP7kemKyfLduBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0B5A11376E;
	Tue, 19 Nov 2024 01:01:40 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id eV01LXTjO2ebKQAAD6G6ig
	(envelope-from <neilb@suse.de>); Tue, 19 Nov 2024 01:01:40 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "NeilBrown" <neilb@suse.de>
To: "Jeff Layton" <jlayton@kernel.org>
Cc: "Chuck Lever" <chuck.lever@oracle.com>,
 "Olga Kornievskaia" <okorniev@redhat.com>, "Dai Ngo" <Dai.Ngo@oracle.com>,
 "Tom Talpey" <tom@talpey.com>, "Jonathan Corbet" <corbet@lwn.net>,
 "Trond Myklebust" <trondmy@kernel.org>, "Anna Schumaker" <anna@kernel.org>,
 "Thomas Haynes" <loghyr@gmail.com>, linux-nfs@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
 "Jeff Layton" <jlayton@kernel.org>
Subject: Re: [PATCH 5/6] nfsd: add support for delegated timestamps
In-reply-to: <20241014-delstid-v1-5-7ce8a2f4dd24@kernel.org>
References: <20241014-delstid-v1-0-7ce8a2f4dd24@kernel.org>,
 <20241014-delstid-v1-5-7ce8a2f4dd24@kernel.org>
Date: Tue, 19 Nov 2024 12:01:33 +1100
Message-id: <173197809388.1734440.12511559535515038071@noble.neil.brown.name>
X-Spam-Level: 
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCPT_COUNT_TWELVE(0.00)[13];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[oracle.com,redhat.com,talpey.com,lwn.net,kernel.org,gmail.com,vger.kernel.org];
	R_RATELIMIT(0.00)[from(RLewrxuus8mos16izbn)];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oracle.com:email]
X-Spam-Score: -4.30
X-Spam-Flag: NO

On Tue, 15 Oct 2024, Jeff Layton wrote:
> Add support for the delegated timestamps on write delegations. This
> allows the server to proxy timestamps from the delegation holder to
> other clients that are doing GETATTRs vs. the same inode.
>=20
> When OPEN4_SHARE_ACCESS_WANT_DELEG_TIMESTAMPS bit is set in the OPEN
> call, set the dl_type to the *_ATTRS_DELEG flavor of delegation.
>=20
> Add timespec64 fields to nfs4_cb_fattr and decode the timestamps into
> those. Vet those timestamps according to the delstid spec and update
> the inode attrs if necessary.
>=20
> Signed-off-by: Jeff Layton <jlayton@kernel.org>
> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
> ---
>  fs/nfsd/nfs4callback.c | 42 +++++++++++++++++++--
>  fs/nfsd/nfs4state.c    | 99 +++++++++++++++++++++++++++++++++++++++++++---=
----
>  fs/nfsd/nfs4xdr.c      | 13 ++++++-
>  fs/nfsd/nfsd.h         |  2 +
>  fs/nfsd/state.h        |  2 +
>  fs/nfsd/xdr4cb.h       | 10 +++--
>  include/linux/time64.h |  5 +++
>  7 files changed, 151 insertions(+), 22 deletions(-)
>=20
> diff --git a/fs/nfsd/nfs4callback.c b/fs/nfsd/nfs4callback.c
> index 776838bb83e6b707a4df76326cdc68f32daf1755..08245596289a960eb8b2e78df27=
6544e7d3f4ff8 100644
> --- a/fs/nfsd/nfs4callback.c
> +++ b/fs/nfsd/nfs4callback.c
> @@ -42,6 +42,7 @@
>  #include "trace.h"
>  #include "xdr4cb.h"
>  #include "xdr4.h"
> +#include "nfs4xdr_gen.h"
> =20
>  #define NFSDDBG_FACILITY                NFSDDBG_PROC
> =20
> @@ -93,12 +94,35 @@ static int decode_cb_fattr4(struct xdr_stream *xdr, uin=
t32_t *bitmap,
>  {
>  	fattr->ncf_cb_change =3D 0;
>  	fattr->ncf_cb_fsize =3D 0;
> +	fattr->ncf_cb_atime.tv_sec =3D 0;
> +	fattr->ncf_cb_atime.tv_nsec =3D 0;
> +	fattr->ncf_cb_mtime.tv_sec =3D 0;
> +	fattr->ncf_cb_mtime.tv_nsec =3D 0;
> +
>  	if (bitmap[0] & FATTR4_WORD0_CHANGE)
>  		if (xdr_stream_decode_u64(xdr, &fattr->ncf_cb_change) < 0)
>  			return -NFSERR_BAD_XDR;
>  	if (bitmap[0] & FATTR4_WORD0_SIZE)
>  		if (xdr_stream_decode_u64(xdr, &fattr->ncf_cb_fsize) < 0)
>  			return -NFSERR_BAD_XDR;
> +	if (bitmap[2] & FATTR4_WORD2_TIME_DELEG_ACCESS) {
> +		fattr4_time_deleg_access access;
> +
> +		if (!xdrgen_decode_fattr4_time_deleg_access(xdr, &access))
> +			return -NFSERR_BAD_XDR;
> +		fattr->ncf_cb_atime.tv_sec =3D access.seconds;
> +		fattr->ncf_cb_atime.tv_nsec =3D access.nseconds;
> +
> +	}
> +	if (bitmap[2] & FATTR4_WORD2_TIME_DELEG_MODIFY) {
> +		fattr4_time_deleg_modify modify;
> +
> +		if (!xdrgen_decode_fattr4_time_deleg_modify(xdr, &modify))
> +			return -NFSERR_BAD_XDR;
> +		fattr->ncf_cb_mtime.tv_sec =3D modify.seconds;
> +		fattr->ncf_cb_mtime.tv_nsec =3D modify.nseconds;
> +
> +	}
>  	return 0;
>  }
> =20
> @@ -364,15 +388,21 @@ encode_cb_getattr4args(struct xdr_stream *xdr, struct=
 nfs4_cb_compound_hdr *hdr,
>  	struct nfs4_delegation *dp =3D container_of(fattr, struct nfs4_delegation=
, dl_cb_fattr);
>  	struct knfsd_fh *fh =3D &dp->dl_stid.sc_file->fi_fhandle;
>  	struct nfs4_cb_fattr *ncf =3D &dp->dl_cb_fattr;
> -	u32 bmap[1];
> +	u32 bmap_size =3D 1;
> +	u32 bmap[3];
> =20
>  	bmap[0] =3D FATTR4_WORD0_SIZE;
>  	if (!ncf->ncf_file_modified)
>  		bmap[0] |=3D FATTR4_WORD0_CHANGE;
> =20
> +	if (deleg_attrs_deleg(dp->dl_type)) {
> +		bmap[1] =3D 0;
> +		bmap[2] =3D FATTR4_WORD2_TIME_DELEG_ACCESS | FATTR4_WORD2_TIME_DELEG_MOD=
IFY;
> +		bmap_size =3D 3;
> +	}
>  	encode_nfs_cb_opnum4(xdr, OP_CB_GETATTR);
>  	encode_nfs_fh4(xdr, fh);
> -	encode_bitmap4(xdr, bmap, ARRAY_SIZE(bmap));
> +	encode_bitmap4(xdr, bmap, bmap_size);
>  	hdr->nops++;
>  }
> =20
> @@ -597,7 +627,7 @@ static int nfs4_xdr_dec_cb_getattr(struct rpc_rqst *rqs=
tp,
>  	struct nfs4_cb_compound_hdr hdr;
>  	int status;
>  	u32 bitmap[3] =3D {0};
> -	u32 attrlen;
> +	u32 attrlen, maxlen;
>  	struct nfs4_cb_fattr *ncf =3D
>  		container_of(cb, struct nfs4_cb_fattr, ncf_getattr);
> =20
> @@ -616,7 +646,11 @@ static int nfs4_xdr_dec_cb_getattr(struct rpc_rqst *rq=
stp,
>  		return -NFSERR_BAD_XDR;
>  	if (xdr_stream_decode_u32(xdr, &attrlen) < 0)
>  		return -NFSERR_BAD_XDR;
> -	if (attrlen > (sizeof(ncf->ncf_cb_change) + sizeof(ncf->ncf_cb_fsize)))
> +	maxlen =3D sizeof(ncf->ncf_cb_change) + sizeof(ncf->ncf_cb_fsize);
> +	if (bitmap[2] !=3D 0)
> +		maxlen +=3D (sizeof(ncf->ncf_cb_mtime.tv_sec) +
> +			   sizeof(ncf->ncf_cb_mtime.tv_nsec)) * 2;
> +	if (attrlen > maxlen)
>  		return -NFSERR_BAD_XDR;
>  	status =3D decode_cb_fattr4(xdr, bitmap, ncf);
>  	return status;
> diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
> index 62f9aeb159d0f2ab4d293bf5c0c56ad7b86eb9d6..2c8d2bb5261ad189c6dfb1c4050=
c23d8cf061325 100644
> --- a/fs/nfsd/nfs4state.c
> +++ b/fs/nfsd/nfs4state.c
> @@ -5803,13 +5803,14 @@ static struct nfs4_delegation *
>  nfs4_set_delegation(struct nfsd4_open *open, struct nfs4_ol_stateid *stp,
>  		    struct svc_fh *parent)
>  {
> -	int status =3D 0;
> +	bool deleg_ts =3D open->op_deleg_want & OPEN4_SHARE_ACCESS_WANT_DELEG_TIM=
ESTAMPS;
>  	struct nfs4_client *clp =3D stp->st_stid.sc_client;
>  	struct nfs4_file *fp =3D stp->st_stid.sc_file;
>  	struct nfs4_clnt_odstate *odstate =3D stp->st_clnt_odstate;
>  	struct nfs4_delegation *dp;
>  	struct nfsd_file *nf =3D NULL;
>  	struct file_lease *fl;
> +	int status =3D 0;
>  	u32 dl_type;
> =20
>  	/*
> @@ -5834,7 +5835,7 @@ nfs4_set_delegation(struct nfsd4_open *open, struct n=
fs4_ol_stateid *stp,
>  	 */
>  	if ((open->op_share_access & NFS4_SHARE_ACCESS_BOTH) =3D=3D NFS4_SHARE_AC=
CESS_BOTH) {
>  		nf =3D find_rw_file(fp);
> -		dl_type =3D OPEN_DELEGATE_WRITE;
> +		dl_type =3D deleg_ts ? OPEN_DELEGATE_WRITE_ATTRS_DELEG : OPEN_DELEGATE_W=
RITE;
>  	}
> =20
>  	/*
> @@ -5843,7 +5844,7 @@ nfs4_set_delegation(struct nfsd4_open *open, struct n=
fs4_ol_stateid *stp,
>  	 */
>  	if (!nf && (open->op_share_access & NFS4_SHARE_ACCESS_READ)) {
>  		nf =3D find_readable_file(fp);
> -		dl_type =3D OPEN_DELEGATE_READ;
> +		dl_type =3D deleg_ts ? OPEN_DELEGATE_READ_ATTRS_DELEG : OPEN_DELEGATE_RE=
AD;
>  	}
> =20
>  	if (!nf)
> @@ -6001,13 +6002,14 @@ static void
>  nfs4_open_delegation(struct nfsd4_open *open, struct nfs4_ol_stateid *stp,
>  		     struct svc_fh *currentfh)
>  {
> -	struct nfs4_delegation *dp;
> +	bool deleg_ts =3D open->op_deleg_want & OPEN4_SHARE_ACCESS_WANT_DELEG_TIM=
ESTAMPS;
>  	struct nfs4_openowner *oo =3D openowner(stp->st_stateowner);
>  	struct nfs4_client *clp =3D stp->st_stid.sc_client;
>  	struct svc_fh *parent =3D NULL;
> -	int cb_up;
> -	int status =3D 0;
> +	struct nfs4_delegation *dp;
>  	struct kstat stat;
> +	int status =3D 0;
> +	int cb_up;
> =20
>  	cb_up =3D nfsd4_cb_channel_good(oo->oo_owner.so_client);
>  	open->op_recall =3D false;
> @@ -6048,12 +6050,14 @@ nfs4_open_delegation(struct nfsd4_open *open, struc=
t nfs4_ol_stateid *stp,
>  			destroy_delegation(dp);
>  			goto out_no_deleg;
>  		}
> -		open->op_delegate_type =3D OPEN_DELEGATE_WRITE;
> +		open->op_delegate_type =3D deleg_ts ? OPEN_DELEGATE_WRITE_ATTRS_DELEG :
> +						    OPEN_DELEGATE_WRITE;
>  		dp->dl_cb_fattr.ncf_cur_fsize =3D stat.size;
>  		dp->dl_cb_fattr.ncf_initial_cinfo =3D nfsd4_change_attribute(&stat);
>  		trace_nfsd_deleg_write(&dp->dl_stid.sc_stateid);
>  	} else {
> -		open->op_delegate_type =3D OPEN_DELEGATE_READ;
> +		open->op_delegate_type =3D deleg_ts ? OPEN_DELEGATE_READ_ATTRS_DELEG :
> +						    OPEN_DELEGATE_READ;
>  		trace_nfsd_deleg_read(&dp->dl_stid.sc_stateid);
>  	}
>  	nfs4_put_stid(&dp->dl_stid);
> @@ -8887,6 +8891,78 @@ nfsd4_get_writestateid(struct nfsd4_compound_state *=
cstate,
>  	get_stateid(cstate, &u->write.wr_stateid);
>  }
> =20
> +/**
> + * set_cb_time - vet and set the timespec for a cb_getattr update
> + * @cb: timestamp from the CB_GETATTR response
> + * @orig: original timestamp in the inode
> + * @now: current time
> + *
> + * Given a timestamp in a CB_GETATTR response, check it against the
> + * current timestamp in the inode and the current time. Returns true
> + * if the inode's timestamp needs to be updated, and false otherwise.
> + * @cb may also be changed if the timestamp needs to be clamped.
> + */
> +static bool set_cb_time(struct timespec64 *cb, const struct timespec64 *or=
ig,
> +			const struct timespec64 *now)
> +{
> +
> +	/*
> +	 * "When the time presented is before the original time, then the
> +	 *  update is ignored." Also no need to update if there is no change.
> +	 */
> +	if (timespec64_compare(cb, orig) <=3D 0)
> +		return false;
> +
> +	/*
> +	 * "When the time presented is in the future, the server can either
> +	 *  clamp the new time to the current time, or it may
> +	 *  return NFS4ERR_DELAY to the client, allowing it to retry."
> +	 */
> +	if (timespec64_compare(cb, now) > 0) {
> +		/* clamp it */
> +		*cb =3D *now;
> +	}
> +
> +	return true;
> +}
> +
> +static int cb_getattr_update_times(struct dentry *dentry, struct nfs4_dele=
gation *dp)
> +{
> +	struct inode *inode =3D d_inode(dentry);
> +	struct timespec64 now =3D current_time(inode);
> +	struct nfs4_cb_fattr *ncf =3D &dp->dl_cb_fattr;
> +	struct iattr attrs =3D { };
> +	int ret;
> +
> +	if (deleg_attrs_deleg(dp->dl_type)) {
> +		struct timespec64 atime =3D inode_get_atime(inode);
> +		struct timespec64 mtime =3D inode_get_mtime(inode);
> +
> +		attrs.ia_atime =3D ncf->ncf_cb_atime;
> +		attrs.ia_mtime =3D ncf->ncf_cb_mtime;
> +
> +		if (set_cb_time(&attrs.ia_atime, &atime, &now))
> +			attrs.ia_valid |=3D ATTR_ATIME | ATTR_ATIME_SET;
> +
> +		if (set_cb_time(&attrs.ia_mtime, &mtime, &now)) {
> +			attrs.ia_valid |=3D ATTR_CTIME | ATTR_MTIME | ATTR_MTIME_SET;
> +			attrs.ia_ctime =3D attrs.ia_mtime;
> +		}
> +	} else {
> +		attrs.ia_valid |=3D ATTR_MTIME | ATTR_CTIME;
> +		attrs.ia_mtime =3D attrs.ia_ctime =3D now;
> +	}
> +
> +	if (!attrs.ia_valid)
> +		return 0;
> +
> +	attrs.ia_valid |=3D ATTR_DELEG;
> +	inode_lock(inode);
> +	ret =3D notify_change(&nop_mnt_idmap, dentry, &attrs, NULL);
> +	inode_unlock(inode);
> +	return ret;
> +}
> +
>  /**
>   * nfsd4_deleg_getattr_conflict - Recall if GETATTR causes conflict
>   * @rqstp: RPC transaction context
> @@ -8913,7 +8989,6 @@ nfsd4_deleg_getattr_conflict(struct svc_rqst *rqstp, =
struct dentry *dentry,
>  	struct file_lock_context *ctx;
>  	struct nfs4_delegation *dp =3D NULL;
>  	struct file_lease *fl;
> -	struct iattr attrs;
>  	struct nfs4_cb_fattr *ncf;
>  	struct inode *inode =3D d_inode(dentry);
> =20
> @@ -8975,11 +9050,7 @@ nfsd4_deleg_getattr_conflict(struct svc_rqst *rqstp,=
 struct dentry *dentry,
>  		 * not update the file's metadata with the client's
>  		 * modified size
>  		 */
> -		attrs.ia_mtime =3D attrs.ia_ctime =3D current_time(inode);
> -		attrs.ia_valid =3D ATTR_MTIME | ATTR_CTIME | ATTR_DELEG;
> -		inode_lock(inode);
> -		err =3D notify_change(&nop_mnt_idmap, dentry, &attrs, NULL);
> -		inode_unlock(inode);
> +		err =3D cb_getattr_update_times(dentry, dp);
>  		if (err) {
>  			status =3D nfserrno(err);
>  			goto out_status;
> diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
> index 1c9d9349e4447c0078c7de0d533cf6278941679d..0e9f59f6be015bfa37893973f38=
fec880ff4c0b1 100644
> --- a/fs/nfsd/nfs4xdr.c
> +++ b/fs/nfsd/nfs4xdr.c
> @@ -3409,6 +3409,7 @@ static __be32 nfsd4_encode_fattr4_xattr_support(struc=
t xdr_stream *xdr,
>  #define NFSD_OA_SHARE_ACCESS_WANT	(BIT(OPEN_ARGS_SHARE_ACCESS_WANT_ANY_DEL=
EG)		| \
>  					 BIT(OPEN_ARGS_SHARE_ACCESS_WANT_NO_DELEG)		| \
>  					 BIT(OPEN_ARGS_SHARE_ACCESS_WANT_CANCEL)		| \
> +					 BIT(OPEN_ARGS_SHARE_ACCESS_WANT_DELEG_TIMESTAMPS)	| \
>  					 BIT(OPEN_ARGS_SHARE_ACCESS_WANT_OPEN_XOR_DELEGATION))
> =20
>  #define NFSD_OA_OPEN_CLAIM	(BIT(OPEN_ARGS_OPEN_CLAIM_NULL)		| \
> @@ -3602,7 +3603,11 @@ nfsd4_encode_fattr4(struct svc_rqst *rqstp, struct x=
dr_stream *xdr,
>  		if (status)
>  			goto out;
>  	}
> -	if (attrmask[0] & (FATTR4_WORD0_CHANGE | FATTR4_WORD0_SIZE)) {
> +	if ((attrmask[0] & (FATTR4_WORD0_CHANGE |
> +			    FATTR4_WORD0_SIZE)) ||
> +	    (attrmask[1] & (FATTR4_WORD1_TIME_ACCESS |
> +			    FATTR4_WORD1_TIME_MODIFY |
> +			    FATTR4_WORD1_TIME_METADATA))) {
>  		status =3D nfsd4_deleg_getattr_conflict(rqstp, dentry, &dp);
>  		if (status)
>  			goto out;
> @@ -3617,8 +3622,14 @@ nfsd4_encode_fattr4(struct svc_rqst *rqstp, struct x=
dr_stream *xdr,
>  		if (ncf->ncf_file_modified) {
>  			++ncf->ncf_initial_cinfo;
>  			args.stat.size =3D ncf->ncf_cur_fsize;
> +			if (!timespec64_is_epoch(&ncf->ncf_cb_mtime))
> +				args.stat.mtime =3D ncf->ncf_cb_mtime;
>  		}
>  		args.change_attr =3D ncf->ncf_initial_cinfo;
> +
> +		if (!timespec64_is_epoch(&ncf->ncf_cb_atime))
> +			args.stat.atime =3D ncf->ncf_cb_atime;
> +
>  		nfs4_put_stid(&dp->dl_stid);
>  	} else {
>  		args.change_attr =3D nfsd4_change_attribute(&args.stat);
> diff --git a/fs/nfsd/nfsd.h b/fs/nfsd/nfsd.h
> index 1955c8e9c4c793728fa75dd136cadc735245483f..004415651295891b3440f52a4c9=
86e3a668a48cb 100644
> --- a/fs/nfsd/nfsd.h
> +++ b/fs/nfsd/nfsd.h
> @@ -459,6 +459,8 @@ enum {
>  	FATTR4_WORD2_MODE_UMASK | \
>  	NFSD4_2_SECURITY_ATTRS | \
>  	FATTR4_WORD2_XATTR_SUPPORT | \
> +	FATTR4_WORD2_TIME_DELEG_ACCESS | \
> +	FATTR4_WORD2_TIME_DELEG_MODIFY | \

This breaks 4.2 mounts for me (in latest nfsd-nexT).  OPEN fails.

By setting these bits we tell the client that we support timestamp
delegation, but you haven't updated nfsd4_decode_share_access() to
understand NFS4_SHARE_WANT_DELEG_TIMESTAMPS in the 'share' flags for an
OPEN request.  So the server responds with BADXDR to OPEN requests now.

Mounting with v4.1 still works.

NeilBrown


>  	FATTR4_WORD2_OPEN_ARGUMENTS)
> =20
>  extern const u32 nfsd_suppattrs[3][3];
> diff --git a/fs/nfsd/state.h b/fs/nfsd/state.h
> index 9d0e844515aa6ea0ec62f2b538ecc2c6a5e34652..6351e6eca7cc63ccf82a3a081ce=
f39042d52f4e9 100644
> --- a/fs/nfsd/state.h
> +++ b/fs/nfsd/state.h
> @@ -142,6 +142,8 @@ struct nfs4_cb_fattr {
>  	/* from CB_GETATTR reply */
>  	u64 ncf_cb_change;
>  	u64 ncf_cb_fsize;
> +	struct timespec64 ncf_cb_mtime;
> +	struct timespec64 ncf_cb_atime;
> =20
>  	unsigned long ncf_cb_flags;
>  	bool ncf_file_modified;
> diff --git a/fs/nfsd/xdr4cb.h b/fs/nfsd/xdr4cb.h
> index e8b00309c449fe2667f7d48cda88ec0cff924f93..f1a315cd31b74f73f1d52702ae7=
b5c93d51ddf82 100644
> --- a/fs/nfsd/xdr4cb.h
> +++ b/fs/nfsd/xdr4cb.h
> @@ -59,16 +59,20 @@
>   * 1: CB_GETATTR opcode (32-bit)
>   * N: file_handle
>   * 1: number of entry in attribute array (32-bit)
> - * 1: entry 0 in attribute array (32-bit)
> + * 3: entry 0-2 in attribute array (32-bit * 3)
>   */
>  #define NFS4_enc_cb_getattr_sz		(cb_compound_enc_hdr_sz +       \
>  					cb_sequence_enc_sz +            \
> -					1 + enc_nfs4_fh_sz + 1 + 1)
> +					1 + enc_nfs4_fh_sz + 1 + 3)
>  /*
>   * 4: fattr_bitmap_maxsz
>   * 1: attribute array len
>   * 2: change attr (64-bit)
>   * 2: size (64-bit)
> + * 2: atime.seconds (64-bit)
> + * 1: atime.nanoseconds (32-bit)
> + * 2: mtime.seconds (64-bit)
> + * 1: mtime.nanoseconds (32-bit)
>   */
>  #define NFS4_dec_cb_getattr_sz		(cb_compound_dec_hdr_sz  +      \
> -			cb_sequence_dec_sz + 4 + 1 + 2 + 2 + op_dec_sz)
> +			cb_sequence_dec_sz + 4 + 1 + 2 + 2 + 2 + 1 + 2 + 1 + op_dec_sz)
> diff --git a/include/linux/time64.h b/include/linux/time64.h
> index f1bcea8c124a361b6c1e3c98ef915840c22a8413..9934331c7b86b7fb981c7aec049=
4ac2f5e72977e 100644
> --- a/include/linux/time64.h
> +++ b/include/linux/time64.h
> @@ -49,6 +49,11 @@ static inline int timespec64_equal(const struct timespec=
64 *a,
>  	return (a->tv_sec =3D=3D b->tv_sec) && (a->tv_nsec =3D=3D b->tv_nsec);
>  }
> =20
> +static inline bool timespec64_is_epoch(const struct timespec64 *ts)
> +{
> +	return ts->tv_sec =3D=3D 0 && ts->tv_nsec =3D=3D 0;
> +}
> +
>  /*
>   * lhs < rhs:  return <0
>   * lhs =3D=3D rhs: return 0
>=20
> --=20
> 2.47.0
>=20
>=20
>=20



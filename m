Return-Path: <linux-nfs+bounces-19200-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oN5iHov+nWkETAQAu9opvQ
	(envelope-from <linux-nfs+bounces-19200-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Tue, 24 Feb 2026 20:39:55 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id BE2B718C250
	for <lists+linux-nfs@lfdr.de>; Tue, 24 Feb 2026 20:39:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4404A3072A1A
	for <lists+linux-nfs@lfdr.de>; Tue, 24 Feb 2026 19:39:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9311A30E851;
	Tue, 24 Feb 2026 19:39:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BpPRF5yG"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EDB030DEB8
	for <linux-nfs@vger.kernel.org>; Tue, 24 Feb 2026 19:39:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771961992; cv=none; b=ga0LM1YEmEEln+poMl2yEryB/MOrodIGadxM3HX56SNRo58zTgiSMtXXx4rQSNapp4uxIrQf2OkBkT/rH3hhFgbTrbT6gPWkwBC06cAHRiYFWDI8v6pU1lc5bE89gUVswARLytGMhwC0Fzq4OLI7LeWc+CDUmIduodx+xwdgVMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771961992; c=relaxed/simple;
	bh=tBdEPlIif6gKTkdYVy0GUsL0Hn+EpZenDifff/vFc3A=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=YH4Z/TmM3BSS+iTG0fx2bzKHr0jKo5cAecOFqaDpOhoCAX1XCC5i+w3Q7o3C814u1n/AC+u48IoGQM8C+K8x6m9VoBcSpfg1aiTxByGPBc+C+c0BfX/RCTIhzZBBnSVFlqzUCiVHe8WU+dcp68asxqk31Uueg4H+97om3Fb05IE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BpPRF5yG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54190C116D0;
	Tue, 24 Feb 2026 19:39:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771961992;
	bh=tBdEPlIif6gKTkdYVy0GUsL0Hn+EpZenDifff/vFc3A=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=BpPRF5yGRECtBLPYFYUc/z9yYMF+DKZmjQR5EIJCE697jbcoWbjiz242Ox1KU5+bK
	 JvE7ijDKWOfrYu/TjNaekfeo7yKEIRBHiQZoNN0fRYHSQfJ1D0+Sfq9JjQmJqoEWR4
	 Yy+TuOD+2Q9Rn4b1W8+9SJJbtzhOs3CKoRXOHKrZOkK1KiOKVnf8N03ZZfQyoYbyXA
	 T5ZSoaEkc+mTc9UN2OvOxpqL8W7kQ7hIx9QfUnpoKp2VBrsG0wtfjohpTXafHAo8Ts
	 nGS6u+70qfoUmcD6a/oh6TeoQJGfv3BIFk3kQ1OmzeBdv1ynuwLEY6QvcYqnp1BXHS
	 lm/bxUG9aVLSg==
Message-ID: <887c1ca78b34974160dee3ce7f25d6d077da93ab.camel@kernel.org>
Subject: Re: [PATCH] nfsd: use dynamic allocation for oversized NFSv4.0
 replay cache
From: Jeff Layton <jlayton@kernel.org>
To: Chuck Lever <cel@kernel.org>
Cc: NeilBrown <neilb@ownmail.net>, Olga Kornievskaia <okorniev@redhat.com>, 
 Dai Ngo <dai.ngo@oracle.com>, Tom Talpey <tom@talpey.com>,
 linux-nfs@vger.kernel.org, Chuck Lever	 <chuck.lever@oracle.com>
Date: Tue, 24 Feb 2026 14:39:50 -0500
In-Reply-To: <20260224193354.57849-1-cel@kernel.org>
References: <20260224193354.57849-1-cel@kernel.org>
Autocrypt: addr=jlayton@kernel.org; prefer-encrypt=mutual;
 keydata=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
 QZIQXVeAA+smfTT0tDrisj1U5x6ZB9b3nBg65kc=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43) 
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[ownmail.net,redhat.com,oracle.com,talpey.com,vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-19200-lists,linux-nfs=lfdr.de];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jlayton@kernel.org,linux-nfs@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,oracle.com:email]
X-Rspamd-Queue-Id: BE2B718C250
X-Rspamd-Action: no action

On Tue, 2026-02-24 at 14:33 -0500, Chuck Lever wrote:
> From: Chuck Lever <chuck.lever@oracle.com>
>=20
> Commit 1e8e9913672a ("nfsd: fix heap overflow in NFSv4.0 LOCK
> replay cache") capped the replay cache copy at NFSD4_REPLAY_ISIZE
> to prevent a heap overflow, but set rp_buflen to zero when the
> encoded response exceeded the inline buffer. A retransmitted LOCK
> reaching the replay path then produced only a status code with no
> operation body, resulting in a malformed XDR response.
>=20
> When the encoded response exceeds the 112-byte inline rp_ibuf, a
> buffer is kmalloc'd to hold it. If the allocation fails, rp_buflen
> remains zero, preserving the behavior from the capped-copy fix.
> The buffer is freed when the stateowner is released or when a
> subsequent operation's response fits in the inline buffer.
>=20
> Fixes: 1e8e9913672a ("nfsd: fix heap overflow in NFSv4.0 LOCK replay cach=
e")
> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
> ---
>  fs/nfsd/nfs4state.c | 16 ++++++++++++++++
>  fs/nfsd/nfs4xdr.c   | 23 ++++++++++++++++-------
>  fs/nfsd/state.h     | 12 +++++++-----
>  3 files changed, 39 insertions(+), 12 deletions(-)
>=20
> diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
> index ba49f49bb93b..b4d0e82b2690 100644
> --- a/fs/nfsd/nfs4state.c
> +++ b/fs/nfsd/nfs4state.c
> @@ -1496,8 +1496,24 @@ release_all_access(struct nfs4_ol_stateid *stp)
>  	}
>  }
> =20
> +/**
> + * nfs4_replay_free_cache - release dynamically allocated replay buffer
> + * @rp: replay cache to reset
> + *
> + * If @rp->rp_buf points to a kmalloc'd buffer, free it and reset
> + * rp_buf to the inline rp_ibuf. Always zeroes rp_buflen.
> + */
> +void nfs4_replay_free_cache(struct nfs4_replay *rp)
> +{
> +	if (rp->rp_buf !=3D rp->rp_ibuf)
> +		kfree(rp->rp_buf);
> +	rp->rp_buf =3D rp->rp_ibuf;
> +	rp->rp_buflen =3D 0;
> +}
> +
>  static inline void nfs4_free_stateowner(struct nfs4_stateowner *sop)
>  {
> +	nfs4_replay_free_cache(&sop->so_replay);
>  	kfree(sop->so_owner.data);
>  	sop->so_ops->so_free(sop);
>  }
> diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
> index 690f7a3122ec..2a0946c630e1 100644
> --- a/fs/nfsd/nfs4xdr.c
> +++ b/fs/nfsd/nfs4xdr.c
> @@ -6282,14 +6282,23 @@ nfsd4_encode_operation(struct nfsd4_compoundres *=
resp, struct nfsd4_op *op)
>  		int len =3D xdr->buf->len - (op_status_offset + XDR_UNIT);
> =20
>  		so->so_replay.rp_status =3D op->status;
> -		if (len <=3D NFSD4_REPLAY_ISIZE) {
> -			so->so_replay.rp_buflen =3D len;
> -			read_bytes_from_xdr_buf(xdr->buf,
> -						op_status_offset + XDR_UNIT,
> -						so->so_replay.rp_buf, len);
> -		} else {
> -			so->so_replay.rp_buflen =3D 0;
> +		if (len > NFSD4_REPLAY_ISIZE) {
> +			char *buf =3D kmalloc(len, GFP_KERNEL);
> +
> +			nfs4_replay_free_cache(&so->so_replay);
> +			if (buf) {
> +				so->so_replay.rp_buf =3D buf;
> +			} else {
> +				/* rp_buflen already zeroed; skip caching */
> +				goto status;
> +			}
> +		} else if (so->so_replay.rp_buf !=3D so->so_replay.rp_ibuf) {
> +			nfs4_replay_free_cache(&so->so_replay);
>  		}
> +		so->so_replay.rp_buflen =3D len;
> +		read_bytes_from_xdr_buf(xdr->buf,
> +					op_status_offset + XDR_UNIT,
> +					so->so_replay.rp_buf, len);
>  	}
>  status:
>  	op->status =3D nfsd4_map_status(op->status,
> diff --git a/fs/nfsd/state.h b/fs/nfsd/state.h
> index 3159c7b67f50..9b05462da4cc 100644
> --- a/fs/nfsd/state.h
> +++ b/fs/nfsd/state.h
> @@ -554,10 +554,10 @@ struct nfs4_client_reclaim {
>   *   ~32(deleg. ace) =3D 112 bytes
>   *
>   * Some responses can exceed this. A LOCK denial includes the conflictin=
g
> - * lock owner, which can be up to 1024 bytes (NFS4_OPAQUE_LIMIT). Respon=
ses
> - * larger than REPLAY_ISIZE are not cached in rp_ibuf; only rp_status is
> - * saved. Enlarging this constant increases the size of every
> - * nfs4_stateowner.
> + * lock owner, which can be up to 1024 bytes (NFS4_OPAQUE_LIMIT). When a
> + * response exceeds REPLAY_ISIZE, a buffer is dynamically allocated. If
> + * that allocation fails, only rp_status is saved. Enlarging this consta=
nt
> + * increases the size of every nfs4_stateowner.
>   */
> =20
>  #define NFSD4_REPLAY_ISIZE       112=20
> @@ -569,12 +569,14 @@ struct nfs4_client_reclaim {
>  struct nfs4_replay {
>  	__be32			rp_status;
>  	unsigned int		rp_buflen;
> -	char			*rp_buf;
> +	char			*rp_buf; /* rp_ibuf or kmalloc'd */
>  	struct knfsd_fh		rp_openfh;
>  	int			rp_locked;
>  	char			rp_ibuf[NFSD4_REPLAY_ISIZE];
>  };
> =20
> +extern void nfs4_replay_free_cache(struct nfs4_replay *rp);
> +
>  struct nfs4_stateowner;
> =20
>  struct nfs4_stateowner_operations {


Certainly a reasonable approach if we care about full correctness when
dealing with a large lockowner on NFSv4.0. Do we?
--=20
Jeff Layton <jlayton@kernel.org>


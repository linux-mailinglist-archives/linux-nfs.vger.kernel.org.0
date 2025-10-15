Return-Path: <linux-nfs+bounces-15266-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 520D9BDE23B
	for <lists+linux-nfs@lfdr.de>; Wed, 15 Oct 2025 13:00:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 5118E503E64
	for <lists+linux-nfs@lfdr.de>; Wed, 15 Oct 2025 10:59:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3E2831D362;
	Wed, 15 Oct 2025 10:57:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b="i2fBRdsQ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="gVSSR3rf"
X-Original-To: linux-nfs@vger.kernel.org
Received: from fhigh-b5-smtp.messagingengine.com (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25CFB320CC0
	for <linux-nfs@vger.kernel.org>; Wed, 15 Oct 2025 10:57:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760525852; cv=none; b=Uqst3MVwX7XUHuwM3ZL03RUC0Qo44tz1nb8rHzby17jX/lC6ZeL1cYDtg67CcDEuYN5LSrOCcmiKv0GD/D2dtJCvts5QpgUCwfnJR76viaxXbSqOeNgcAMsyzEJzn3ev6/8enaTVA21Tgi7dC0lJ7Yp9KxbfI8QjiJ+EWQAPqkQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760525852; c=relaxed/simple;
	bh=C90Lni+QufxtMRUXrcBLPORo0Pb8qYzVxHIqKfgoFNk=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=HKUFaawlUTNSSB87HBFyc12KJ1FRGM3lM4dYPbS8opkShuM5ZX+cAHMDyRs1bT+absSQ4bxOOIf9zCirp+cyfu8q8DBWI/lzxopUOaIGNLtsDDkp2GegaIMDlZRMa2llnTkgGoDOdDoL9sXiejr7xImRxtCLhSkrgE/rMsVUF5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=i2fBRdsQ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=gVSSR3rf; arc=none smtp.client-ip=202.12.124.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 0DCB77A01B5;
	Wed, 15 Oct 2025 06:57:29 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Wed, 15 Oct 2025 06:57:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to; s=fm2; t=
	1760525848; x=1760612248; bh=MCOmpG74g8iUmSry/rNdFaS5ctHVaeyb7s5
	tE9TJV+A=; b=i2fBRdsQh1XTNOpkGGw1j3ZBs2Jeys2BCNdJAKNV76jX7EhMqtJ
	xGNbHarBC0aUZsgPgELnPfQf6PGzaeGMJR76q125EXK29C7XkbmhO+iGghoIsVTI
	U7aWyMg6PB1E9SZdmEKagh5OjeYFM2Qh6gJTWF65raNiW8TyYeHrTHCAi88T4xeB
	bXTHZOpoke+lT2A3q49oYIGDo7gm28oOfIdAnXrgJfMvQ2SYStx1PnsUnxIOXRHG
	GZJlXkcE9gVmUCCEr//AnQR/UTFV7WD6gux+J/EnUHfxEDkBZfe5BsHw9xeHA11u
	s9wmAqnanPPsYFsYAOPpzPSuosnjWTcxQYw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1760525848; x=
	1760612248; bh=MCOmpG74g8iUmSry/rNdFaS5ctHVaeyb7s5tE9TJV+A=; b=g
	VSSR3rfHaRvAv+ckrrocMibmJtnSWh2HBO0VsNz10BQE/9bKfRS/g+lsSN0vIc3i
	DBxswxVDvMP8zNr8siejS4GmAMULMs76MXhl+nym22/O6wZ7Dlsd24xhNT0XI0vv
	hiitPgVdTPfwSRzWpE2dDHwBd6V8if3eyAOECNIa2lr6TRqxqSLdGy1s09wNt54J
	HQy6I92HLjOTqEYD6E7xU0y6kxipw2P90K06IPz7WYHpSbWYRr//wZNSNdFPj48Z
	g8cOXxUiZiyEkOIqMBPKJDQQHXeSL2Cqg+XSt8hFqj8Ys4dsj6704fzDEeKRgMCZ
	Lb0BitJ4pW4rh9ARvxaWQ==
X-ME-Sender: <xms:GH7vaGEfDcmlOOovrVR-_0KEfXGRxPgkM8rXzbG_0z_wfAOobgcPLw>
    <xme:GH7vaLDDpGfG0jb7LzkdPANApD6sHyD3YBq5g32G-3_HHA6tmv5vReFF1rDDp76H4
    _L1f9r55Ps5QhkMMNYU-fOnVDOLJxgNI2NN0mS1QMalT7dfa0c>
X-ME-Received: <xmr:GH7vaJ_M-nf4mtAepNwLyFtnZTOdNZU463ihZWQZ27cyWvEZCNIiONpOyXt84SG_QHlyvUdjWVD9EqgzXh0oyZ5cCJEuT2T9e-2aeg1wrmiy>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduvdefvdefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurheptgfgggfhvfevufgjfhffkfhrsehtqhertddttdejnecuhfhrohhmpefpvghilheu
    rhhofihnuceonhgvihhlsgesohifnhhmrghilhdrnhgvtheqnecuggftrfgrthhtvghrnh
    epvdeuteelkeejkeevteetvedtkeegleduieeftdeftefgtddtleejgfelgfevffeinecu
    ffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpedtnecurf
    grrhgrmhepmhgrihhlfhhrohhmpehnvghilhgssehofihnmhgrihhlrdhnvghtpdhnsggp
    rhgtphhtthhopeeipdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehlihhnuhigqd
    hnfhhssehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepthhomhesthgrlhhp
    vgihrdgtohhmpdhrtghpthhtohepohhkohhrnhhivghvsehrvgguhhgrthdrtghomhdprh
    gtphhtthhopegthhhutghkrdhlvghvvghrsehorhgrtghlvgdrtghomhdprhgtphhtthho
    pegurghirdhnghhosehorhgrtghlvgdrtghomhdprhgtphhtthhopehjlhgrhihtohhnse
    hkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:GH7vaHBpIdIBTik_F2qxba7aDbCsjQBgL7rTguPCrHA2mf06U57Bww>
    <xmx:GH7vaORTqjbEYFasw2bru6x2Q08equZEmDD3mP86OPTs5inGEme_Gw>
    <xmx:GH7vaOuuROv_nwmx8gsFG5ryRgydc27vXsKI6s7DTBn2UFFk-DBeCg>
    <xmx:GH7vaK0SEvqNmoGaFE8gVdsIa5cNK2foEm6WrlwXCc7orCu4MU5H9A>
    <xmx:GH7vaLmTUFLRWHA2kDeZdH4S5hzf3wqxCFhbFwpKs3TG3NLAsao0SRhN>
Feedback-ID: iab3e480c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 15 Oct 2025 06:57:26 -0400 (EDT)
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: NeilBrown <neilb@ownmail.net>
To: "Chuck Lever" <chuck.lever@oracle.com>, "Jeff Layton" <jlayton@kernel.org>
Cc: "Olga Kornievskaia" <okorniev@redhat.com>, "Dai Ngo" <Dai.Ngo@oracle.com>,
 "Tom Talpey" <tom@talpey.com>, linux-nfs@vger.kernel.org
Subject: Re: [PATCH v2 1/2] nfsd: ensure SEQUENCE replay sends a valid reply.
In-reply-to: <20251014233659.1980566-2-neilb@ownmail.net>
References: <20251014233659.1980566-1-neilb@ownmail.net>,
 <20251014233659.1980566-2-neilb@ownmail.net>
Date: Wed, 15 Oct 2025 21:57:16 +1100
Message-id: <176052583604.1793333.11667202487074445027@noble.neil.brown.name>
Reply-To: NeilBrown <neil@brown.name>

On Wed, 15 Oct 2025, NeilBrown wrote:
> From: NeilBrown <neil@brown.name>
>=20
> nfsd4_enc_sequence_replay() uses nfsd4_encode_operation() to encode a
> new SEQUENCE reply when replaying a request from the slot cache - only
> ops after the SEQUENCE are replayed from the cache in ->sl_data.
>=20
> However it does this in nfsd4_replay_cache_entry() which is called
> *before* nfsd4_sequence() has filled in reply fields.
>=20
> This means that in the replayed SEQUENCE reply:
>  maxslots will be whatever the client sent
>  target_maxslots will be -1 (assuming init to zero, and
>       nfsd4_encode_sequence() subtracts 1)
>  status_flags will be zero
>=20
> The incorrect maxslots value, in particular, can cause the client to
> think the slot table has been reduced in size so it can discard its
> knowledge of current sequence number of the later slots, though the
> server has not discarded those slots.  When the client later wants to
> use a later slot, it can get NFS4ERR_SEQ_MISORDERED from the server.
>=20
> This patch moves the setup of the reply into a new helper function and
> call it *before* nfsd4_replay_cache_entry() is called.  Only one of the
> updated fields was used after this point - maxslots.  So the
> nfsd4_sequence struct has been extended to have separate maxslots for
> the request and the response.
>=20
> Closes: https://lore.kernel.org/linux-nfs/20251010194449.10281-1-okorniev@r=
edhat.com/
> Reported-and-tested-by: Olga Kornievskaia <okorniev@redhat.com>
> Signed-off-by: NeilBrown <neil@brown.name>
> ---

I missed this change

diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
index 230bf53e39f7..6135b896b3fe 100644
--- a/fs/nfsd/nfs4xdr.c
+++ b/fs/nfsd/nfs4xdr.c
@@ -5085,7 +5085,7 @@ nfsd4_encode_sequence(struct nfsd4_compoundres *resp, _=
_be32 nfserr,
 		return nfserr;
 	/* Note slotid's are numbered from zero: */
 	/* sr_highest_slotid */
-	nfserr =3D nfsd4_encode_slotid4(xdr, seq->maxslots - 1);
+	nfserr =3D nfsd4_encode_slotid4(xdr, seq->maxslots_response - 1);
 	if (nfserr !=3D nfs_ok)
 		return nfserr;
 	/* sr_target_highest_slotid */


NeilBrown

>  fs/nfsd/nfs4state.c | 51 ++++++++++++++++++++++++++++++---------------
>  fs/nfsd/xdr4.h      |  3 ++-
>  2 files changed, 36 insertions(+), 18 deletions(-)
>=20
> diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
> index c9053ef4d79f..631147790d5e 100644
> --- a/fs/nfsd/nfs4state.c
> +++ b/fs/nfsd/nfs4state.c
> @@ -4349,6 +4349,37 @@ static bool replay_matches_cache(struct svc_rqst *rq=
stp,
>  	return true;
>  }
> =20
> +static void nfsd4_construct_sequence_response(struct nfsd4_session *sessio=
n,
> +					      struct nfsd4_sequence *seq)
> +{
> +	/*
> +	 * Note that the response is constructed here both for the case
> +	 * of a new SEQUENCE request and for a replayed SEQUENCE request.
> +	 * We do not cache SEQUENCE responses as SEQUENCE is idempotent.
> +	 */
> +
> +	struct nfs4_client *clp =3D session->se_client;
> +
> +	seq->maxslots_response =3D max(session->se_target_maxslots,
> +				     seq->maxslots);
> +	seq->target_maxslots =3D session->se_target_maxslots;
> +
> +	switch (clp->cl_cb_state) {
> +	case NFSD4_CB_DOWN:
> +		seq->status_flags =3D SEQ4_STATUS_CB_PATH_DOWN;
> +		break;
> +	case NFSD4_CB_FAULT:
> +		seq->status_flags =3D SEQ4_STATUS_BACKCHANNEL_FAULT;
> +		break;
> +	default:
> +		seq->status_flags =3D 0;
> +	}
> +	if (!list_empty(&clp->cl_revoked))
> +		seq->status_flags |=3D SEQ4_STATUS_RECALLABLE_STATE_REVOKED;
> +	if (atomic_read(&clp->cl_admin_revoked))
> +		seq->status_flags |=3D SEQ4_STATUS_ADMIN_STATE_REVOKED;
> +}
> +
>  __be32
>  nfsd4_sequence(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
>  		union nfsd4_op_u *u)
> @@ -4398,6 +4429,9 @@ nfsd4_sequence(struct svc_rqst *rqstp, struct nfsd4_c=
ompound_state *cstate,
>  	dprintk("%s: slotid %d\n", __func__, seq->slotid);
> =20
>  	trace_nfsd_slot_seqid_sequence(clp, seq, slot);
> +
> +	nfsd4_construct_sequence_response(session, seq);
> +
>  	status =3D check_slot_seqid(seq->seqid, slot->sl_seqid, slot->sl_flags);
>  	if (status =3D=3D nfserr_replay_cache) {
>  		status =3D nfserr_seq_misordered;
> @@ -4495,23 +4529,6 @@ nfsd4_sequence(struct svc_rqst *rqstp, struct nfsd4_=
compound_state *cstate,
>  	}
> =20
>  out:
> -	seq->maxslots =3D max(session->se_target_maxslots, seq->maxslots);
> -	seq->target_maxslots =3D session->se_target_maxslots;
> -
> -	switch (clp->cl_cb_state) {
> -	case NFSD4_CB_DOWN:
> -		seq->status_flags =3D SEQ4_STATUS_CB_PATH_DOWN;
> -		break;
> -	case NFSD4_CB_FAULT:
> -		seq->status_flags =3D SEQ4_STATUS_BACKCHANNEL_FAULT;
> -		break;
> -	default:
> -		seq->status_flags =3D 0;
> -	}
> -	if (!list_empty(&clp->cl_revoked))
> -		seq->status_flags |=3D SEQ4_STATUS_RECALLABLE_STATE_REVOKED;
> -	if (atomic_read(&clp->cl_admin_revoked))
> -		seq->status_flags |=3D SEQ4_STATUS_ADMIN_STATE_REVOKED;
>  	trace_nfsd_seq4_status(rqstp, seq);
>  out_no_session:
>  	if (conn)
> diff --git a/fs/nfsd/xdr4.h b/fs/nfsd/xdr4.h
> index ee0570cbdd9e..1ce8e12ae335 100644
> --- a/fs/nfsd/xdr4.h
> +++ b/fs/nfsd/xdr4.h
> @@ -574,8 +574,9 @@ struct nfsd4_sequence {
>  	struct nfs4_sessionid	sessionid;		/* request/response */
>  	u32			seqid;			/* request/response */
>  	u32			slotid;			/* request/response */
> -	u32			maxslots;		/* request/response */
> +	u32			maxslots;		/* request */
>  	u32			cachethis;		/* request */
> +	u32			maxslots_response;	/* response */
>  	u32			target_maxslots;	/* response */
>  	u32			status_flags;		/* response */
>  };
> --=20
> 2.50.0.107.gf914562f5916.dirty
>=20
>=20
>=20



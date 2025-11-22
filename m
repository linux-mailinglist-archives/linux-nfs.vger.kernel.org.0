Return-Path: <linux-nfs+bounces-16672-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id EB980C7D79E
	for <lists+linux-nfs@lfdr.de>; Sat, 22 Nov 2025 21:41:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 44A75352B43
	for <lists+linux-nfs@lfdr.de>; Sat, 22 Nov 2025 20:41:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82DC82C159A;
	Sat, 22 Nov 2025 20:40:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F6cIDdxY"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C94F2253A0
	for <linux-nfs@vger.kernel.org>; Sat, 22 Nov 2025 20:40:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763844055; cv=none; b=EnevBn559dFCSPg678p1Joh1thfDSXTAWJahtggaKgmV0sYl5S0hwcJsqFrP66zq7a7f8qR+TNLqbRgCmgPT6K84RrrVq6GMIY2eMpNXt+dvh/d5CB9fSqKlDSos/DZ9Q7y2tPwY3yx2SD7z5A9GUmCKpOT83mOBTaccvd0I1qU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763844055; c=relaxed/simple;
	bh=wOp4Dwep4xn+sU/GJTpOjB2769dHudYkHxcG0advo84=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WyhkpVRjSXWtbFNbqAXi1PRkzG0p656ljfnJZRt0WE1jA/GnzVbBElsGReh/93faH3c2l8YnadAxDtcbnZScLyx6npEo7jZxj1JPe07192AC+RxrpXTu63nf9Bnl1Y47RVc1GFQb8RjM3VHMCHWUtbmDPH9iCOIahb/7nOPt6Es=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F6cIDdxY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9579CC4AF0B;
	Sat, 22 Nov 2025 20:40:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763844054;
	bh=wOp4Dwep4xn+sU/GJTpOjB2769dHudYkHxcG0advo84=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=F6cIDdxYvw6+/Q/wkY0DJ7zBBNSGHr8ILAb6bGGn0Qhu+EddJghkJjCO4hTlIPKha
	 52WkCBGTryHUhn8gwRYpt35MuESAq1/sz5RxzrLqTdY202vEl6Vx9eqV3Q+D6M380r
	 MEkLOE6C3q7u5nFws6MqZzlOmcg/jPOu5wqpPvMYgJjfNotVXZ6Z3n01Edk0PYdoFp
	 GYd/h7keKXGsf3GP4PRIEWyCZh7SWHBbxg3ubXJrKv0nrvgGK9wTQ7/Z0M6gW6C/Cf
	 3mOOYy2Bnu+kvQPF7TmdzNl0PtqQnin4Zmk9OAokBQT8B0EFyso2jLrQzv295jx4oU
	 masZCn6iCYr/A==
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfauth.phl.internal (Postfix) with ESMTP id 9EA6BF4007E;
	Sat, 22 Nov 2025 15:40:53 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Sat, 22 Nov 2025 15:40:53 -0500
X-ME-Sender: <xms:1R8iaT350N4ZY4T5HaDZ__txIagnWDxhWgpU6fzW_A6YGT-_dV30iw>
    <xme:1R8iaUXx8Edfrekqfv5g1SjKnN6aEozouvjtHsgW-gVJ7-lkqj5Aduutn8ViMLvVt
    zuUHYjd3VF2BIT_E5WvnoHngpKJLZV5F1yh9psYBZZruGTA6lElQnQ>
X-ME-Received: <xmr:1R8iaWKUOkdD-Y8Ey-h3_rw2bNDd3JZG5a3by-q6lSfwz4MfKsAEfINZiY6Nn0QUC1FZ9feK8ucWyA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvfeefkeefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepvehhuhgtkhcu
    nfgvvhgvrhcuoegtvghlsehkvghrnhgvlhdrohhrgheqnecuggftrfgrthhtvghrnhepvd
    eigfejjeehvdehteelieegudeuieeljefhkeeuheeujefhgefhveelfefhtdelnecuffho
    mhgrihhnpehfhhgpshhiiigvrdhimhenucevlhhushhtvghrufhiiigvpedtnecurfgrrh
    grmhepmhgrihhlfhhrohhmpegthhhutghklhgvvhgvrhdomhgvshhmthhprghuthhhphgv
    rhhsohhnrghlihhthidqudeifeegleelleehledqfedvleekgeegvdefqdgtvghlpeepkh
    gvrhhnvghlrdhorhhgsehfrghsthhmrghilhdrtghomhdpnhgspghrtghpthhtohepjedp
    mhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepnhgvihhlsegsrhhofihnrdhnrghmvg
    dprhgtphhtthhopegthhhutghkrdhlvghvvghrsehorhgrtghlvgdrtghomhdprhgtphht
    thhopehjlhgrhihtohhnsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehokhhorhhnih
    gvvhesrhgvughhrghtrdgtohhmpdhrtghpthhtohepuggrihdrnhhgohesohhrrggtlhgv
    rdgtohhmpdhrtghpthhtohepthhomhesthgrlhhpvgihrdgtohhmpdhrtghpthhtoheplh
    hinhhugidqnhhfshesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:1R8iae2nSEqpIqVKJuKph17m0EXTcMZbnU6HlhQkn-mP4_yTFZN7eg>
    <xmx:1R8iaU5C_4PZaW9zkScGAWeHESqILFS0W-DvEwUmgq-m6L7PmJn5PA>
    <xmx:1R8iaf-udp83cfB9qqNThNmk5iE49cmthI1xpxeRbQGAtlW1Ynl3UA>
    <xmx:1R8iaTX4r2-25ySldpgl2UBA3lz4wCMbwd6or5y_pyts1-Ym4FtYHA>
    <xmx:1R8iaapHMfxMqEFltTCbJwYiUR4bfCXkTBBoF0_C-dzzSdkBij4VeI0F>
Feedback-ID: ifa6e4810:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 22 Nov 2025 15:40:52 -0500 (EST)
Date: Sat, 22 Nov 2025 15:40:51 -0500
From: Chuck Lever <cel@kernel.org>
To: NeilBrown <neil@brown.name>
Cc: Chuck Lever <chuck.lever@oracle.com>, Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>,
	linux-nfs@vger.kernel.org
Subject: Re: [PATCH v6 01/14] nfsd: rename ALLOWED_WITHOUT_FH to
 ALLOWED_WITHOUT_LOCAL_FH and revise use
Message-ID: <aSIf04NC8gB5qDKd@morisot.1015granger.net>
References: <20251122005236.3440177-1-neilb@ownmail.net>
 <20251122005236.3440177-2-neilb@ownmail.net>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251122005236.3440177-2-neilb@ownmail.net>

On Sat, Nov 22, 2025 at 11:46:59AM +1100, NeilBrown wrote:
> From: NeilBrown <neil@brown.name>
> 
> nfsdv4 OPs which do not have ALLOWED_WITHOUT_FH can assume that a PUTFH
> has been called and may actually assume that current_fh->fh_dentry is
> non-NULL.  nfsd4_setattr(), for example, assumes fh_dentry != NULL.
> 
> However the possibility of foreign filehandles (needed for v4.2 COPY)
> means that there may be a filehandle present while fh_dentry is NULL.
> 
> Sending a COMPOUND containing:
>    SEQUENCE
>    PUTFH - foreign filehandle
>    SETATTR - new mode
>    SAVEFH
>    COPY - with non-empty server list
> 
> to an NFS server with inter-server copy enabled will cause a NULL
> pointer dereference when nfsd4_setattr() calls fh_want_write().

The short description for 1/14 is:

  nfsd: rename ALLOWED_WITHOUT_FH to ALLOWED_WITHOUT_LOCAL_FH and
    revise use

But here the description claims to be fixing a NULL pointer
dereference. Let's help out our sustaining engineers and make
this "fixes" statement the main subject. That also makes it
clear why there is a Fixes: tag on this patch.


> Most NFSv4 OPs actually want a "local" filehandle, not just any
> filehandle.  So this patch renames ALLOWED_WITHOUT_FH to
> ALLOWED_WITHOUT_LOCAL_FH and sets it on all the other which DON'T

s/the other/operations/


> require a local filehandle.  That is: all that don't require any
> filehandle together with SAVEFH, which is the only OP which needs to
> handle a foreign current_fh.  (COPY must handle a foreign save_fh, but
> all OPs which access save_fh already do any required validity tests
> themselves).

This arrangement strikes me as a little confusing. Why not leave
ALLOWED_WITHOUT_FH but add ALLOWED_WITH_ANY_FH just for SAVE_FH?


> nfsd4_savefh() is changed to validate the filehandle itself as the
> caller no longer validates it.

"the caller" is... nfsd4_proc_compound ? Since this lone caller uses
an indirect function call, it would be friendlier (grep-wise) for
the patch description to refer to nfsd4_proc_compound by name.


> nfsd4_proc_compound no longer allows ops without
> ALLOWED_WITHOUT_LOCAL_FH to be called with a foreign fh - current_fh
> must be local and ->fh_dentry must be non-NULL.  This protects
> nfsd4_setattr() and any others that might use ->fh_dentry without
> checking.
> 
> The
>        current_fh->fh_export &&
> test is removed from an "else if" because that condition is now only
> tested when current_fh->fh_dentry is not NULL, and in that case
> current_fh->fh_export is also guaranteed to not be NULL.
> 
> Fixes: b9e8638e3d9e ("NFSD: allow inter server COPY to have a STALE source server fh")

Since this patch addresses an NPD, we want to consider it for LTS
backport (ie, add "Cc: stable").

However, looking at 2/14:

> In NFSv4.1, SECINFO and similar OPs can consume current_fh, but don't
> currently set fh_size to zero.  So the above rule for filehandle type
> determination isn't currently accurate.  This is fixed by enhancing
> fh_put() to clear fhp->fh_handle.fh_size.

I'm getting tripped up by "the above rule ... isn't currently
accurate." Is this an existing behavior upstream, or is it a
behavior that is introduced by 1/14 ? If the latter, then maybe
hunks 1, 2, and 3 of 2/14 need to be squashed into 1/14.


> Reviewed-by: Jeff Layton <jlayton@kernel.org>
> Signed-off-by: NeilBrown <neil@brown.name>
> 
> ---
> changes since v5
>  - fix compile failure: need cstate->current_fh
>  - comment for ALLOWED_WITHOUT_LOCAL_FH improved
> ---
>  fs/nfsd/nfs4proc.c | 59 ++++++++++++++++++++++++++--------------------
>  fs/nfsd/xdr4.h     |  2 +-
>  2 files changed, 35 insertions(+), 26 deletions(-)
> 
> diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
> index dcad50846a97..947b1b6d2282 100644
> --- a/fs/nfsd/nfs4proc.c
> +++ b/fs/nfsd/nfs4proc.c
> @@ -729,6 +729,16 @@ static __be32
>  nfsd4_savefh(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
>  	     union nfsd4_op_u *u)
>  {
> +	/*
> +	 * SAVEFH is "ALLOWED_WITHOUT_LOCAL_FH" in that
> +	 * current_fh.fh_dentry is not required, those some fh_handle

s/those/though


> +	 * *is* required so that a foreign fh can be saved as needed for
> +	 * inter-server COPY.
> +	 */
> +	if (!cstate->current_fh.fh_dentry &&
> +	    !HAS_FH_FLAG(&cstate->current_fh, NFSD4_FH_FOREIGN))
> +		return nfserr_nofilehandle;
> +
>  	fh_dup2(&cstate->save_fh, &cstate->current_fh);
>  	if (HAS_CSTATE_FLAG(cstate, CURRENT_STATE_ID_FLAG)) {
>  		memcpy(&cstate->save_stateid, &cstate->current_stateid, sizeof(stateid_t));
> @@ -2919,14 +2929,12 @@ nfsd4_proc_compound(struct svc_rqst *rqstp)
>  				op->status = nfsd4_open_omfg(rqstp, cstate, op);
>  			goto encode_op;
>  		}
> -		if (!current_fh->fh_dentry &&
> -				!HAS_FH_FLAG(current_fh, NFSD4_FH_FOREIGN)) {
> -			if (!(op->opdesc->op_flags & ALLOWED_WITHOUT_FH)) {
> +		if (!current_fh->fh_dentry) {
> +			if (!(op->opdesc->op_flags & ALLOWED_WITHOUT_LOCAL_FH)) {
>  				op->status = nfserr_nofilehandle;
>  				goto encode_op;
>  			}
> -		} else if (current_fh->fh_export &&
> -			   current_fh->fh_export->ex_fslocs.migrated &&
> +		} else if (current_fh->fh_export->ex_fslocs.migrated &&
>  			  !(op->opdesc->op_flags & ALLOWED_ON_ABSENT_FS)) {
>  			op->status = nfserr_moved;
>  			goto encode_op;
> @@ -3507,21 +3515,21 @@ static const struct nfsd4_operation nfsd4_ops[] = {
>  	},
>  	[OP_PUTFH] = {
>  		.op_func = nfsd4_putfh,
> -		.op_flags = ALLOWED_WITHOUT_FH | ALLOWED_ON_ABSENT_FS
> +		.op_flags = ALLOWED_WITHOUT_LOCAL_FH | ALLOWED_ON_ABSENT_FS
>  				| OP_IS_PUTFH_LIKE | OP_CLEAR_STATEID,
>  		.op_name = "OP_PUTFH",
>  		.op_rsize_bop = nfsd4_only_status_rsize,
>  	},
>  	[OP_PUTPUBFH] = {
>  		.op_func = nfsd4_putrootfh,
> -		.op_flags = ALLOWED_WITHOUT_FH | ALLOWED_ON_ABSENT_FS
> +		.op_flags = ALLOWED_WITHOUT_LOCAL_FH | ALLOWED_ON_ABSENT_FS
>  				| OP_IS_PUTFH_LIKE | OP_CLEAR_STATEID,
>  		.op_name = "OP_PUTPUBFH",
>  		.op_rsize_bop = nfsd4_only_status_rsize,
>  	},
>  	[OP_PUTROOTFH] = {
>  		.op_func = nfsd4_putrootfh,
> -		.op_flags = ALLOWED_WITHOUT_FH | ALLOWED_ON_ABSENT_FS
> +		.op_flags = ALLOWED_WITHOUT_LOCAL_FH | ALLOWED_ON_ABSENT_FS
>  				| OP_IS_PUTFH_LIKE | OP_CLEAR_STATEID,
>  		.op_name = "OP_PUTROOTFH",
>  		.op_rsize_bop = nfsd4_only_status_rsize,
> @@ -3557,7 +3565,7 @@ static const struct nfsd4_operation nfsd4_ops[] = {
>  	},
>  	[OP_RENEW] = {
>  		.op_func = nfsd4_renew,
> -		.op_flags = ALLOWED_WITHOUT_FH | ALLOWED_ON_ABSENT_FS
> +		.op_flags = ALLOWED_WITHOUT_LOCAL_FH | ALLOWED_ON_ABSENT_FS
>  				| OP_MODIFIES_SOMETHING,
>  		.op_name = "OP_RENEW",
>  		.op_rsize_bop = nfsd4_only_status_rsize,
> @@ -3565,14 +3573,15 @@ static const struct nfsd4_operation nfsd4_ops[] = {
>  	},
>  	[OP_RESTOREFH] = {
>  		.op_func = nfsd4_restorefh,
> -		.op_flags = ALLOWED_WITHOUT_FH | ALLOWED_ON_ABSENT_FS
> +		.op_flags = ALLOWED_WITHOUT_LOCAL_FH | ALLOWED_ON_ABSENT_FS
>  				| OP_IS_PUTFH_LIKE | OP_MODIFIES_SOMETHING,
>  		.op_name = "OP_RESTOREFH",
>  		.op_rsize_bop = nfsd4_only_status_rsize,
>  	},
>  	[OP_SAVEFH] = {
>  		.op_func = nfsd4_savefh,
> -		.op_flags = OP_HANDLES_WRONGSEC | OP_MODIFIES_SOMETHING,
> +		.op_flags = ALLOWED_WITHOUT_LOCAL_FH
> +				| OP_HANDLES_WRONGSEC | OP_MODIFIES_SOMETHING,
>  		.op_name = "OP_SAVEFH",
>  		.op_rsize_bop = nfsd4_only_status_rsize,
>  	},
> @@ -3593,7 +3602,7 @@ static const struct nfsd4_operation nfsd4_ops[] = {
>  	},
>  	[OP_SETCLIENTID] = {
>  		.op_func = nfsd4_setclientid,
> -		.op_flags = ALLOWED_WITHOUT_FH | ALLOWED_ON_ABSENT_FS
> +		.op_flags = ALLOWED_WITHOUT_LOCAL_FH | ALLOWED_ON_ABSENT_FS
>  				| OP_MODIFIES_SOMETHING | OP_CACHEME
>  				| OP_NONTRIVIAL_ERROR_ENCODE,
>  		.op_name = "OP_SETCLIENTID",
> @@ -3601,7 +3610,7 @@ static const struct nfsd4_operation nfsd4_ops[] = {
>  	},
>  	[OP_SETCLIENTID_CONFIRM] = {
>  		.op_func = nfsd4_setclientid_confirm,
> -		.op_flags = ALLOWED_WITHOUT_FH | ALLOWED_ON_ABSENT_FS
> +		.op_flags = ALLOWED_WITHOUT_LOCAL_FH | ALLOWED_ON_ABSENT_FS
>  				| OP_MODIFIES_SOMETHING | OP_CACHEME,
>  		.op_name = "OP_SETCLIENTID_CONFIRM",
>  		.op_rsize_bop = nfsd4_only_status_rsize,
> @@ -3620,7 +3629,7 @@ static const struct nfsd4_operation nfsd4_ops[] = {
>  	},
>  	[OP_RELEASE_LOCKOWNER] = {
>  		.op_func = nfsd4_release_lockowner,
> -		.op_flags = ALLOWED_WITHOUT_FH | ALLOWED_ON_ABSENT_FS
> +		.op_flags = ALLOWED_WITHOUT_LOCAL_FH | ALLOWED_ON_ABSENT_FS
>  				| OP_MODIFIES_SOMETHING,
>  		.op_name = "OP_RELEASE_LOCKOWNER",
>  		.op_rsize_bop = nfsd4_only_status_rsize,
> @@ -3630,54 +3639,54 @@ static const struct nfsd4_operation nfsd4_ops[] = {
>  	[OP_EXCHANGE_ID] = {
>  		.op_func = nfsd4_exchange_id,
>  		.op_release = nfsd4_exchange_id_release,
> -		.op_flags = ALLOWED_WITHOUT_FH | ALLOWED_AS_FIRST_OP
> +		.op_flags = ALLOWED_WITHOUT_LOCAL_FH | ALLOWED_AS_FIRST_OP
>  				| OP_MODIFIES_SOMETHING,
>  		.op_name = "OP_EXCHANGE_ID",
>  		.op_rsize_bop = nfsd4_exchange_id_rsize,
>  	},
>  	[OP_BACKCHANNEL_CTL] = {
>  		.op_func = nfsd4_backchannel_ctl,
> -		.op_flags = ALLOWED_WITHOUT_FH | OP_MODIFIES_SOMETHING,
> +		.op_flags = ALLOWED_WITHOUT_LOCAL_FH | OP_MODIFIES_SOMETHING,
>  		.op_name = "OP_BACKCHANNEL_CTL",
>  		.op_rsize_bop = nfsd4_only_status_rsize,
>  	},
>  	[OP_BIND_CONN_TO_SESSION] = {
>  		.op_func = nfsd4_bind_conn_to_session,
> -		.op_flags = ALLOWED_WITHOUT_FH | ALLOWED_AS_FIRST_OP
> +		.op_flags = ALLOWED_WITHOUT_LOCAL_FH | ALLOWED_AS_FIRST_OP
>  				| OP_MODIFIES_SOMETHING,
>  		.op_name = "OP_BIND_CONN_TO_SESSION",
>  		.op_rsize_bop = nfsd4_bind_conn_to_session_rsize,
>  	},
>  	[OP_CREATE_SESSION] = {
>  		.op_func = nfsd4_create_session,
> -		.op_flags = ALLOWED_WITHOUT_FH | ALLOWED_AS_FIRST_OP
> +		.op_flags = ALLOWED_WITHOUT_LOCAL_FH | ALLOWED_AS_FIRST_OP
>  				| OP_MODIFIES_SOMETHING,
>  		.op_name = "OP_CREATE_SESSION",
>  		.op_rsize_bop = nfsd4_create_session_rsize,
>  	},
>  	[OP_DESTROY_SESSION] = {
>  		.op_func = nfsd4_destroy_session,
> -		.op_flags = ALLOWED_WITHOUT_FH | ALLOWED_AS_FIRST_OP
> +		.op_flags = ALLOWED_WITHOUT_LOCAL_FH | ALLOWED_AS_FIRST_OP
>  				| OP_MODIFIES_SOMETHING,
>  		.op_name = "OP_DESTROY_SESSION",
>  		.op_rsize_bop = nfsd4_only_status_rsize,
>  	},
>  	[OP_SEQUENCE] = {
>  		.op_func = nfsd4_sequence,
> -		.op_flags = ALLOWED_WITHOUT_FH | ALLOWED_AS_FIRST_OP,
> +		.op_flags = ALLOWED_WITHOUT_LOCAL_FH | ALLOWED_AS_FIRST_OP,
>  		.op_name = "OP_SEQUENCE",
>  		.op_rsize_bop = nfsd4_sequence_rsize,
>  	},
>  	[OP_DESTROY_CLIENTID] = {
>  		.op_func = nfsd4_destroy_clientid,
> -		.op_flags = ALLOWED_WITHOUT_FH | ALLOWED_AS_FIRST_OP
> +		.op_flags = ALLOWED_WITHOUT_LOCAL_FH | ALLOWED_AS_FIRST_OP
>  				| OP_MODIFIES_SOMETHING,
>  		.op_name = "OP_DESTROY_CLIENTID",
>  		.op_rsize_bop = nfsd4_only_status_rsize,
>  	},
>  	[OP_RECLAIM_COMPLETE] = {
>  		.op_func = nfsd4_reclaim_complete,
> -		.op_flags = ALLOWED_WITHOUT_FH | OP_MODIFIES_SOMETHING,
> +		.op_flags = ALLOWED_WITHOUT_LOCAL_FH | OP_MODIFIES_SOMETHING,
>  		.op_name = "OP_RECLAIM_COMPLETE",
>  		.op_rsize_bop = nfsd4_only_status_rsize,
>  	},
> @@ -3690,13 +3699,13 @@ static const struct nfsd4_operation nfsd4_ops[] = {
>  	},
>  	[OP_TEST_STATEID] = {
>  		.op_func = nfsd4_test_stateid,
> -		.op_flags = ALLOWED_WITHOUT_FH,
> +		.op_flags = ALLOWED_WITHOUT_LOCAL_FH,
>  		.op_name = "OP_TEST_STATEID",
>  		.op_rsize_bop = nfsd4_test_stateid_rsize,
>  	},
>  	[OP_FREE_STATEID] = {
>  		.op_func = nfsd4_free_stateid,
> -		.op_flags = ALLOWED_WITHOUT_FH | OP_MODIFIES_SOMETHING,
> +		.op_flags = ALLOWED_WITHOUT_LOCAL_FH | OP_MODIFIES_SOMETHING,
>  		.op_name = "OP_FREE_STATEID",
>  		.op_get_currentstateid = nfsd4_get_freestateid,
>  		.op_rsize_bop = nfsd4_only_status_rsize,
> @@ -3711,7 +3720,7 @@ static const struct nfsd4_operation nfsd4_ops[] = {
>  	[OP_GETDEVICEINFO] = {
>  		.op_func = nfsd4_getdeviceinfo,
>  		.op_release = nfsd4_getdeviceinfo_release,
> -		.op_flags = ALLOWED_WITHOUT_FH,
> +		.op_flags = ALLOWED_WITHOUT_LOCAL_FH,
>  		.op_name = "OP_GETDEVICEINFO",
>  		.op_rsize_bop = nfsd4_getdeviceinfo_rsize,
>  	},
> diff --git a/fs/nfsd/xdr4.h b/fs/nfsd/xdr4.h
> index ae75846b3cd7..e27258e694a9 100644
> --- a/fs/nfsd/xdr4.h
> +++ b/fs/nfsd/xdr4.h
> @@ -1006,7 +1006,7 @@ extern __be32 nfsd4_free_stateid(struct svc_rqst *rqstp,
>  extern void nfsd4_bump_seqid(struct nfsd4_compound_state *, __be32 nfserr);
>  
>  enum nfsd4_op_flags {
> -	ALLOWED_WITHOUT_FH = 1 << 0,    /* No current filehandle required */
> +	ALLOWED_WITHOUT_LOCAL_FH = 1 << 0,    /* No fh_dentry needed in current filehandle */
>  	ALLOWED_ON_ABSENT_FS = 1 << 1,  /* ops processed on absent fs */
>  	ALLOWED_AS_FIRST_OP = 1 << 2,   /* ops reqired first in compound */
>  	/* For rfc 5661 section 2.6.3.1.1: */
> -- 
> 2.50.0.107.gf914562f5916.dirty
> 
> 

-- 
Chuck Lever


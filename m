Return-Path: <linux-nfs+bounces-8129-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 34D749D2EE0
	for <lists+linux-nfs@lfdr.de>; Tue, 19 Nov 2024 20:34:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 78B2028277A
	for <lists+linux-nfs@lfdr.de>; Tue, 19 Nov 2024 19:34:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC7F71547E9;
	Tue, 19 Nov 2024 19:34:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ReDcpF7V"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7B6F53363
	for <linux-nfs@vger.kernel.org>; Tue, 19 Nov 2024 19:34:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732044852; cv=none; b=HBdr63dlIh7qV/9/swvdabWq+MB3B2GExrGkvOKAsD5Bd23dAGk0y9L5h0/QLa1zx5rqRCqWAugAEE+WX7D5dKOpTb/gcdIVd9O7nZOivyBmvqJZ9otrz2yt8rpVgCNkH0/h263haI6/kNx46uMuTDH2uC8t+F/15qRVyywoD6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732044852; c=relaxed/simple;
	bh=nws4d3pph5YQXpiizhsSVr5du2iDKRpjyohdpvTcekE=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=fAOujMFczUJadF/2RtSx5ElOviIlsen2A/mL33eupZTpJv5BJYnwcmiJrwzY4sPOYc/IAnoNKhuLe1CHEk/BvMvUUufxrpi6V615eLqcDOUCAr/yngwTFRMkTVLNs1MkVv0aOvpEb6GeXW2P9xtnEQhMHcVVkVlQAifivlsE3Mw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ReDcpF7V; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2C69C4CECF;
	Tue, 19 Nov 2024 19:34:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732044852;
	bh=nws4d3pph5YQXpiizhsSVr5du2iDKRpjyohdpvTcekE=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=ReDcpF7VCa3E+Yq86nNHSXSoauvyu3HdfEzYldPreFzZZMZYdiCs5IpkAqhBN6k/k
	 AGH4RZVGkHK4cCgSTk7d6BtcfwS0KkD1VTAmRqrOnHvZc/OpRQJxOfgEfq0XGbmidy
	 bn2WRcM0MYmgyqu55cqer/LgZqtD5DwIWlHdQO4IWtPx6XOjuYlNiQQLjHBT097GqP
	 GOwUH0q0PDjeN8A3C77RoHE42JSQzzWO8QFo3XaVbdZpxn1sxeNTUm8M44Xk1n7o5y
	 5GRQ0rotP7+tZ8Tdsb6Rrpoe6I1jruUui/a2ooiIK9LflfAD0HILpoEBvq5HxsMcvy
	 SDedZqNSUCOrQ==
Message-ID: <e7e95f71c9e58e23a61080af512ea58cbf02f8a1.camel@kernel.org>
Subject: Re: [PATCH 4/6] nfsd: allocate new session-based DRC slots on
 demand.
From: Jeff Layton <jlayton@kernel.org>
To: NeilBrown <neilb@suse.de>, Chuck Lever <chuck.lever@oracle.com>
Cc: linux-nfs@vger.kernel.org, Olga Kornievskaia <okorniev@redhat.com>, Dai
 Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>
Date: Tue, 19 Nov 2024 14:34:10 -0500
In-Reply-To: <20241119004928.3245873-5-neilb@suse.de>
References: <20241119004928.3245873-1-neilb@suse.de>
	 <20241119004928.3245873-5-neilb@suse.de>
Autocrypt: addr=jlayton@kernel.org; prefer-encrypt=mutual;
 keydata=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
 QZIQXVeAA+smfTT0tDrisj1U5x6ZB9b3nBg65kc=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-2.fc40) 
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2024-11-19 at 11:41 +1100, NeilBrown wrote:
> If a client ever uses the highest available slot for a given session,
> attempt to allocate another slot so there is room for the client to use
> more slots if wanted.  GFP_NOWAIT is used so if there is not plenty of
> free memory, failure is expected - which is what we want.  It also
> allows the allocation while holding a spinlock.
>=20
> We would expect to stablise with one more slot available than the client
> actually uses.
>=20
> Now that we grow the slot table on demand we can start with a smaller
> allocation.  Define NFSD_MAX_INITIAL_SLOTS and allocate at most that
> many when session is created.
>=20
> Signed-off-by: NeilBrown <neilb@suse.de>
> ---
>  fs/nfsd/nfs4state.c | 32 ++++++++++++++++++++++++++------
>  fs/nfsd/state.h     |  2 ++
>  2 files changed, 28 insertions(+), 6 deletions(-)
>=20
> diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
> index 31ff9f92a895..fb522165b376 100644
> --- a/fs/nfsd/nfs4state.c
> +++ b/fs/nfsd/nfs4state.c
> @@ -1956,7 +1956,7 @@ static struct nfsd4_session *alloc_session(struct n=
fsd4_channel_attrs *fattrs,
>  	if (!slot || xa_is_err(xa_store(&new->se_slots, 0, slot, GFP_KERNEL)))
>  		goto out_free;
> =20
> -	for (i =3D 1; i < numslots; i++) {
> +	for (i =3D 1; i < numslots && i < NFSD_MAX_INITIAL_SLOTS; i++) {

nit: maybe just clamp numslots at NFSD_MAX_INITIAL_SLOTS?

>  		slot =3D kzalloc(slotsize, GFP_KERNEL | __GFP_NORETRY);
>  		if (!slot)
>  			break;
> @@ -4248,11 +4248,6 @@ nfsd4_sequence(struct svc_rqst *rqstp, struct nfsd=
4_compound_state *cstate,
>  	slot =3D xa_load(&session->se_slots, seq->slotid);
>  	dprintk("%s: slotid %d\n", __func__, seq->slotid);
> =20
> -	/* We do not negotiate the number of slots yet, so set the
> -	 * maxslots to the session maxreqs which is used to encode
> -	 * sr_highest_slotid and the sr_target_slot id to maxslots */
> -	seq->maxslots =3D session->se_fchannel.maxreqs;
> -
>  	trace_nfsd_slot_seqid_sequence(clp, seq, slot);
>  	status =3D check_slot_seqid(seq->seqid, slot->sl_seqid,
>  					slot->sl_flags & NFSD4_SLOT_INUSE);
> @@ -4302,6 +4297,31 @@ nfsd4_sequence(struct svc_rqst *rqstp, struct nfsd=
4_compound_state *cstate,
>  	cstate->session =3D session;
>  	cstate->clp =3D clp;
> =20
> +	/*
> +	 * If the client ever uses the highest available slot,
> +	 * gently try to allocate another one.
> +	 */
> +	if (seq->slotid =3D=3D session->se_fchannel.maxreqs - 1 &&
> +	    session->se_fchannel.maxreqs < NFSD_MAX_SLOTS_PER_SESSION) {
> +		int s =3D session->se_fchannel.maxreqs;
> +
> +		/*
> +		 * GFP_NOWAIT is a low-priority non-blocking allocation
> +		 * which can be used under client_lock and only succeeds
> +		 * if there is plenty of memory.
> +		 * Use GFP_ATOMIC which is higher priority for xa_store()
> +		 * so we are less likely to waste the effort of the first
> +		 * allocation.
> +		 */
> +		slot =3D kzalloc(slot_bytes(&session->se_fchannel), GFP_NOWAIT);
> +		if (slot && !xa_is_err(xa_store(&session->se_slots, s, slot,
> +						GFP_ATOMIC)))
> +			session->se_fchannel.maxreqs +=3D 1;
> +		else
> +			kfree(slot);
> +	}
> +	seq->maxslots =3D session->se_fchannel.maxreqs;
> +
>  out:
>  	switch (clp->cl_cb_state) {
>  	case NFSD4_CB_DOWN:
> diff --git a/fs/nfsd/state.h b/fs/nfsd/state.h
> index e97626916a68..a14a823670e9 100644
> --- a/fs/nfsd/state.h
> +++ b/fs/nfsd/state.h
> @@ -249,6 +249,8 @@ static inline struct nfs4_delegation *delegstateid(st=
ruct nfs4_stid *s)
>   * get good throughput on high-latency servers.
>   */
>  #define NFSD_MAX_SLOTS_PER_SESSION	2048
> +/* Maximum number of slots per session to allocate for CREATE_SESSION */
> +#define NFSD_MAX_INITIAL_SLOTS		32
>  /* Maximum  session per slot cache size */
>  #define NFSD_SLOT_CACHE_SIZE		2048
>  /* Maximum number of NFSD_SLOT_CACHE_SIZE slots per session */

--=20
Jeff Layton <jlayton@kernel.org>


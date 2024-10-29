Return-Path: <linux-nfs+bounces-7547-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F1AD9B46D3
	for <lists+linux-nfs@lfdr.de>; Tue, 29 Oct 2024 11:28:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5E049283DF0
	for <lists+linux-nfs@lfdr.de>; Tue, 29 Oct 2024 10:28:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6383F204924;
	Tue, 29 Oct 2024 10:28:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="adwV9O77"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39EC3839E4;
	Tue, 29 Oct 2024 10:28:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730197715; cv=none; b=GnwP1tAAqcXtHNtB9kLy6Tye/ObqyEC6lBJJYsQ7QwGYVMGerRMWbAThxPZoiCrLFTEA8gYlMq8bIpZ3x0HtNU/wwtUrJK/ntg1p9Yk+RctHtqG7mPeF1wTruinuVLrFq8urovBRKooAXYiOgAQLJ8SR7wlbfQjzcGFUzvRQ51o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730197715; c=relaxed/simple;
	bh=QtYHIjyhmIhI945OulwDRbZKEnb/dQ6si5qiw+PKbik=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=s8PqQ/IjSV2MGadUlvGYQRC+oIZtTU1vvduB44kg0OUJcgk3BJwYVjKz7UOIRi/q9cjtMdFskAV8GcnhefgH4hwS45DHMRw8i/FRrtN+m5M4kLrAzONMCVxZSHwnARDad9X+T8YXM1jvDZwi/PIyMXKcF+1vWaQ2kGAnXHmWZyc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=adwV9O77; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25B80C4CEE5;
	Tue, 29 Oct 2024 10:28:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730197714;
	bh=QtYHIjyhmIhI945OulwDRbZKEnb/dQ6si5qiw+PKbik=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=adwV9O77rGjm5DjFdblIZ89SgFMYi90LRVvnVLKJjQ1mKeJTeq8D5bhGimCr5jJCt
	 jx9048c2UoG58v6MwkUXGBghP1/fP9t5gexWdoUQYP6i62FiDA1rVyrEympIv1e/Jp
	 MQNNCoXf1yPbtKsXkE0DtSZQtvebTV/bHg0vBYKmxnU/4a4BFL4Xx27Uxs2Say2b0D
	 a2dp0klIc6mHZrrvqjA3zDVmn3JnS5xcPVSnZUy15rmJU9mrX6BA2CMhCHnCh1LbxU
	 NPxW8ZtWss2R7nRCnbfmXzFlUxGQqY12X0hrvktTsR+lxxtH+UB4cWWSvTSEalte54
	 x/htNmw3MJxrA==
Message-ID: <a674c6091a2f510b103bbbacb6ef4a7f497289a0.camel@kernel.org>
Subject: Re: [PATCH 2/2] nfsd: allow for more callback session slots
From: Jeff Layton <jlayton@kernel.org>
To: Chuck Lever <chuck.lever@oracle.com>
Cc: Neil Brown <neilb@suse.de>, Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey
	 <tom@talpey.com>, Olga Kornievskaia <okorniev@redhat.com>, 
	linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Tue, 29 Oct 2024 06:28:32 -0400
In-Reply-To: <Zx/gbQmNS1vXw2Jq@tissot.1015granger.net>
References: <20241028-bcwide-v1-0-0e75a8219dc0@kernel.org>
	 <20241028-bcwide-v1-2-0e75a8219dc0@kernel.org>
	 <Zx/gbQmNS1vXw2Jq@tissot.1015granger.net>
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

On Mon, 2024-10-28 at 15:05 -0400, Chuck Lever wrote:
> On Mon, Oct 28, 2024 at 10:26:27AM -0400, Jeff Layton wrote:
> > nfsd currently only uses a single slot in the callback channel, which i=
s
> > proving to be a bottleneck in some cases. Widen the callback channel to
> > a max of 32 slots (subject to the client's target_maxreqs value).
> >=20
> > Change the cb_holds_slot boolean to an integer that tracks the current
> > slot number (with -1 meaning "unassigned").  Move the callback slot
> > tracking info into the session. Add a new u32 that acts as a bitmap to
> > track which slots are in use, and a u32 to track the latest callback
> > target_slotid that the client reports. While they are part of the
> > session, the fields are protected by the cl_lock.
> >=20
> > Fix nfsd41_cb_get_slot to always search for the lowest slotid (using
> > ffs()), and change it to continually retry until there is a slot
> > available.
> >=20
> > Finally, convert the session->se_cb_seq_nr field into an array of
> > counters and add the necessary handling to ensure that the seqids get
> > reset at the appropriate times.
> >=20
> > Signed-off-by: Jeff Layton <jlayton@kernel.org>
> > ---
> >  fs/nfsd/nfs4callback.c | 107 +++++++++++++++++++++++++++++++++++------=
--------
> >  fs/nfsd/nfs4state.c    |   7 +++-
> >  fs/nfsd/state.h        |  12 +++---
> >  fs/nfsd/trace.h        |   2 +-
> >  4 files changed, 89 insertions(+), 39 deletions(-)
> >=20
> > diff --git a/fs/nfsd/nfs4callback.c b/fs/nfsd/nfs4callback.c
> > index e38fa834b3d91333acf1425eb14c644e5d5f2601..64b85b164125b244494f980=
5840a0d8a1ccb4c1b 100644
> > --- a/fs/nfsd/nfs4callback.c
> > +++ b/fs/nfsd/nfs4callback.c
> > @@ -406,6 +406,16 @@ encode_cb_getattr4args(struct xdr_stream *xdr, str=
uct nfs4_cb_compound_hdr *hdr,
> >  	hdr->nops++;
> >  }
> > =20
> > +static u32 highest_unset_index(u32 word)
> > +{
> > +	int i;
> > +
> > +	for (i =3D sizeof(word) * 8 - 1; i > 0; --i)
> > +		if (!(word & BIT(i)))
> > +			return i;
> > +	return 0;
> > +}
> > +
>=20
> Isn't this the same as ffz() or "ffs(~(x))" ?
>=20

No. I need the _last_ cleared bit in the word. It looks though like
there is a fls() function that might be usable, so I could maybe do
fls(~(x)). I'll experiment with that.

>=20
> >  /*
> >   * CB_SEQUENCE4args
> >   *
> > @@ -432,15 +442,38 @@ static void encode_cb_sequence4args(struct xdr_st=
ream *xdr,
> >  	encode_sessionid4(xdr, session);
> > =20
> >  	p =3D xdr_reserve_space(xdr, 4 + 4 + 4 + 4 + 4);
> > -	*p++ =3D cpu_to_be32(session->se_cb_seq_nr);	/* csa_sequenceid */
> > -	*p++ =3D xdr_zero;			/* csa_slotid */
> > -	*p++ =3D xdr_zero;			/* csa_highest_slotid */
> > +	*p++ =3D cpu_to_be32(session->se_cb_seq_nr[cb->cb_held_slot]);	/* csa=
_sequenceid */
> > +	*p++ =3D cpu_to_be32(cb->cb_held_slot);		/* csa_slotid */
> > +	*p++ =3D cpu_to_be32(max(highest_unset_index(session->se_cb_slot_avai=
l),
> > +			       session->se_cb_highest_slot)); /* csa_highest_slotid */
>=20
> This encoder doesn't hold the client's cl_lock, but does reference
> fields that are updated while that lock is held.
>=20
> Also, should a per-session spin lock be used instead of cl_lock?
>=20
> Is locking even necessary? All of these calls are prepared in a
> single-threaded workqueue. Reply processing can only free slots, so
> it doesn't need to exclude session slot selection.
>=20

NFSv4 callbacks use async RPCs. The encoding and transmit is done in
the context of the (single-threaded) workqueue, but the reply is
handled by rpciod. Since we release the slot after the reply in rpciod
context, I think we do require locking here. I also worry a bit that
relying on the single-threaded workqueue may end up being a bottleneck
at some point in the future, so I see having clear locking here as a
benefit.

I'm open to switching to a per-session lock of some sort, but I don't
see a real need here. Only one session will be used as the backchannel
at a time, so there shouldn't be competing access between different
sessions for the cl_lock. We are competing with the other uses of the
cl_lock, but this one should be pretty quick. My preference would be to
add extra locking only once it becomes clear that it's necessary.

>=20
> >  	*p++ =3D xdr_zero;			/* csa_cachethis */
> >  	xdr_encode_empty_array(p);		/* csa_referring_call_lists */
> > =20
> >  	hdr->nops++;
> >  }
> > =20
> > +static void update_cb_slot_table(struct nfsd4_session *ses, u32 highes=
t)
>=20
> Nit: Can you use the name "target" instead of "highest" ?
>=20

Will do.

>=20
> > +{
> > +	/* No need to do anything if nothing changed */
> > +	if (likely(highest =3D=3D READ_ONCE(ses->se_cb_highest_slot)))
> > +		return;
> > +
> > +	spin_lock(&ses->se_client->cl_lock);
> > +	/* If growing the slot table, reset any new sequences to 1 */
> > +	if (highest > ses->se_cb_highest_slot) {
> > +		int i;
> > +
> > +		for (i =3D ses->se_cb_highest_slot; i <=3D highest; ++i) {
> > +			/* beyond the end of the array? */
> > +			if (i >=3D NFSD_BC_SLOT_TABLE_MAX)
> > +				break;
>=20
> Nit: why not cap "highest" at NFSD_BC_SLOT_TABLE_MAX before starting
> this for loop?
>=20

Duh -- of course. Will fix.

>=20
> > +			ses->se_cb_seq_nr[i] =3D 1;
> > +		}
> > +	}
> > +	ses->se_cb_highest_slot =3D highest;
> > +	spin_unlock(&ses->se_client->cl_lock);
> > +}
> > +
> >  /*
> >   * CB_SEQUENCE4resok
> >   *
> > @@ -485,7 +518,7 @@ static int decode_cb_sequence4resok(struct xdr_stre=
am *xdr,
> >  	p +=3D XDR_QUADLEN(NFS4_MAX_SESSIONID_LEN);
> > =20
> >  	dummy =3D be32_to_cpup(p++);
> > -	if (dummy !=3D session->se_cb_seq_nr) {
> > +	if (dummy !=3D session->se_cb_seq_nr[cb->cb_held_slot]) {
>=20
> Nit: Let's rename "dummy" as "seqid", and add a "highest" variable
> for the next XDR field (not shown here).
>=20

Ok.

>=20
> >  		dprintk("NFS: %s Invalid sequence number\n", __func__);
> >  		goto out;
> >  	}
> > @@ -496,9 +529,15 @@ static int decode_cb_sequence4resok(struct xdr_str=
eam *xdr,
> >  		goto out;
> >  	}
> > =20
> > -	/*
> > -	 * FIXME: process highest slotid and target highest slotid
> > -	 */
> > +	p++; // ignore current highest slot value
> > +
> > +	dummy =3D be32_to_cpup(p++);
>=20
> Nit: I prefer a name for this argument variable like "target".
>=20
> The compiler should be able to combine the usage of these variables
> into a single memory location.
>=20

Ok.

>=20
> > +	if (dummy =3D=3D 0) {
> > +		dprintk("NFS: %s Invalid target highest slotid\n", __func__);
> > +		goto out;
> > +	}
> > +
> > +	update_cb_slot_table(session, dummy);
> >  	status =3D 0;
> >  out:
> >  	cb->cb_seq_status =3D status;
> > @@ -1208,31 +1247,38 @@ void nfsd4_change_callback(struct nfs4_client *=
clp, struct nfs4_cb_conn *conn)
> >   * If the slot is available, then mark it busy.  Otherwise, set the
> >   * thread for sleeping on the callback RPC wait queue.
> >   */
> > -static bool nfsd41_cb_get_slot(struct nfsd4_callback *cb, struct rpc_t=
ask *task)
> > +static void nfsd41_cb_get_slot(struct nfsd4_callback *cb, struct rpc_t=
ask *task)
> >  {
> >  	struct nfs4_client *clp =3D cb->cb_clp;
> > +	struct nfsd4_session *ses =3D clp->cl_cb_session;
> > +	int idx;
> > =20
> > -	if (!cb->cb_holds_slot &&
> > -	    test_and_set_bit(0, &clp->cl_cb_slot_busy) !=3D 0) {
> > +	if (cb->cb_held_slot >=3D 0)
> > +		return;
> > +retry:
> > +	spin_lock(&clp->cl_lock);
> > +	idx =3D ffs(ses->se_cb_slot_avail) - 1;
> > +	if (idx < 0 || idx > ses->se_cb_highest_slot) {
> > +		spin_unlock(&clp->cl_lock);
> >  		rpc_sleep_on(&clp->cl_cb_waitq, task, NULL);
> > -		/* Race breaker */
> > -		if (test_and_set_bit(0, &clp->cl_cb_slot_busy) !=3D 0) {
> > -			dprintk("%s slot is busy\n", __func__);
> > -			return false;
> > -		}
> > -		rpc_wake_up_queued_task(&clp->cl_cb_waitq, task);
> > +		goto retry;
> >  	}
> > -	cb->cb_holds_slot =3D true;
> > -	return true;
> > +	/* clear the bit for the slot */
> > +	ses->se_cb_slot_avail &=3D ~BIT(idx);
> > +	spin_unlock(&clp->cl_lock);
> > +	cb->cb_held_slot =3D idx;
> >  }
> > =20
> >  static void nfsd41_cb_release_slot(struct nfsd4_callback *cb)
> >  {
> >  	struct nfs4_client *clp =3D cb->cb_clp;
> > +	struct nfsd4_session *ses =3D clp->cl_cb_session;
> > =20
> > -	if (cb->cb_holds_slot) {
> > -		cb->cb_holds_slot =3D false;
> > -		clear_bit(0, &clp->cl_cb_slot_busy);
> > +	if (cb->cb_held_slot >=3D 0) {
> > +		spin_lock(&clp->cl_lock);
> > +		ses->se_cb_slot_avail |=3D BIT(cb->cb_held_slot);
> > +		spin_unlock(&clp->cl_lock);
> > +		cb->cb_held_slot =3D -1;
> >  		rpc_wake_up_next(&clp->cl_cb_waitq);
> >  	}
> >  }
> > @@ -1265,8 +1311,8 @@ static void nfsd4_cb_prepare(struct rpc_task *tas=
k, void *calldata)
>=20
> Nit: This patch should update the documenting comment before
> nfsd4_cb_prepare() -- the patch implements "multiple slots".
>=20

+1

>=20
> >  	trace_nfsd_cb_rpc_prepare(clp);
> >  	cb->cb_seq_status =3D 1;
> >  	cb->cb_status =3D 0;
> > -	if (minorversion && !nfsd41_cb_get_slot(cb, task))
> > -		return;
> > +	if (minorversion)
> > +		nfsd41_cb_get_slot(cb, task);
> >  	rpc_call_start(task);
> >  }
> > =20
> > @@ -1292,7 +1338,7 @@ static bool nfsd4_cb_sequence_done(struct rpc_tas=
k *task, struct nfsd4_callback
> >  		return true;
> >  	}
> > =20
> > -	if (!cb->cb_holds_slot)
> > +	if (cb->cb_held_slot < 0)
> >  		goto need_restart;
> > =20
> >  	/* This is the operation status code for CB_SEQUENCE */
> > @@ -1306,10 +1352,10 @@ static bool nfsd4_cb_sequence_done(struct rpc_t=
ask *task, struct nfsd4_callback
> >  		 * If CB_SEQUENCE returns an error, then the state of the slot
> >  		 * (sequence ID, cached reply) MUST NOT change.
> >  		 */
> > -		++session->se_cb_seq_nr;
> > +		++session->se_cb_seq_nr[cb->cb_held_slot];
> >  		break;
> >  	case -ESERVERFAULT:
> > -		++session->se_cb_seq_nr;
> > +		++session->se_cb_seq_nr[cb->cb_held_slot];
> >  		nfsd4_mark_cb_fault(cb->cb_clp);
> >  		ret =3D false;
> >  		break;
> > @@ -1335,17 +1381,16 @@ static bool nfsd4_cb_sequence_done(struct rpc_t=
ask *task, struct nfsd4_callback
> >  	case -NFS4ERR_BADSLOT:
> >  		goto retry_nowait;
> >  	case -NFS4ERR_SEQ_MISORDERED:
> > -		if (session->se_cb_seq_nr !=3D 1) {
> > -			session->se_cb_seq_nr =3D 1;
> > +		if (session->se_cb_seq_nr[cb->cb_held_slot] !=3D 1) {
> > +			session->se_cb_seq_nr[cb->cb_held_slot] =3D 1;
> >  			goto retry_nowait;
> >  		}
> >  		break;
> >  	default:
> >  		nfsd4_mark_cb_fault(cb->cb_clp);
> >  	}
> > -	nfsd41_cb_release_slot(cb);
> > -
> >  	trace_nfsd_cb_free_slot(task, cb);
> > +	nfsd41_cb_release_slot(cb);
> > =20
> >  	if (RPC_SIGNALLED(task))
> >  		goto need_restart;
> > @@ -1565,7 +1610,7 @@ void nfsd4_init_cb(struct nfsd4_callback *cb, str=
uct nfs4_client *clp,
> >  	INIT_WORK(&cb->cb_work, nfsd4_run_cb_work);
> >  	cb->cb_status =3D 0;
> >  	cb->cb_need_restart =3D false;
> > -	cb->cb_holds_slot =3D false;
> > +	cb->cb_held_slot =3D -1;
> >  }
> > =20
> >  /**
> > diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
> > index 5b718b349396f1aecd0ad4c63b2f43342841bbd4..20a0d40202e40eed1c84d5d=
6c0a85b908804a6ba 100644
> > --- a/fs/nfsd/nfs4state.c
> > +++ b/fs/nfsd/nfs4state.c
> > @@ -2002,6 +2002,8 @@ static struct nfsd4_session *alloc_session(struct=
 nfsd4_channel_attrs *fattrs,
> >  	}
> > =20
> >  	memcpy(&new->se_fchannel, fattrs, sizeof(struct nfsd4_channel_attrs))=
;
> > +	new->se_cb_slot_avail =3D ~0U;
> > +	new->se_cb_highest_slot =3D battrs->maxreqs - 1;
> >  	return new;
> >  out_free:
> >  	while (i--)
> > @@ -2132,7 +2134,9 @@ static void init_session(struct svc_rqst *rqstp, =
struct nfsd4_session *new, stru
> > =20
> >  	INIT_LIST_HEAD(&new->se_conns);
> > =20
> > -	new->se_cb_seq_nr =3D 1;
> > +	for (idx =3D 0; idx < NFSD_BC_SLOT_TABLE_MAX; ++idx)
> > +		new->se_cb_seq_nr[idx] =3D 1;
> > +
> >  	new->se_flags =3D cses->flags;
> >  	new->se_cb_prog =3D cses->callback_prog;
> >  	new->se_cb_sec =3D cses->cb_sec;
> > @@ -3159,7 +3163,6 @@ static struct nfs4_client *create_client(struct x=
dr_netobj name,
> >  	kref_init(&clp->cl_nfsdfs.cl_ref);
> >  	nfsd4_init_cb(&clp->cl_cb_null, clp, NULL, NFSPROC4_CLNT_CB_NULL);
> >  	clp->cl_time =3D ktime_get_boottime_seconds();
> > -	clear_bit(0, &clp->cl_cb_slot_busy);
> >  	copy_verf(clp, verf);
> >  	memcpy(&clp->cl_addr, sa, sizeof(struct sockaddr_storage));
> >  	clp->cl_cb_session =3D NULL;
> > diff --git a/fs/nfsd/state.h b/fs/nfsd/state.h
> > index 41cda86fea1f6166a0fd0215d3d458c93ced3e6a..2987c362bdd56251e736879=
dc89302ada2259be8 100644
> > --- a/fs/nfsd/state.h
> > +++ b/fs/nfsd/state.h
> > @@ -71,8 +71,8 @@ struct nfsd4_callback {
> >  	struct work_struct cb_work;
> >  	int cb_seq_status;
> >  	int cb_status;
> > +	int cb_held_slot;
> >  	bool cb_need_restart;
> > -	bool cb_holds_slot;
> >  };
> > =20
> >  struct nfsd4_callback_ops {
> > @@ -307,6 +307,9 @@ struct nfsd4_conn {
> >  	unsigned char cn_flags;
> >  };
> > =20
> > +/* Max number of slots that the server will use in the backchannel */
> > +#define NFSD_BC_SLOT_TABLE_MAX	32
> > +
>=20
> The new comment is unclear about whether this is an implementation
> limit or a protocol limit. I suggest:
>=20
> /* Maximum number of slots that NFSD implements for NFSv4.1+ backchannel =
*/
>=20
> And make this "sizeof(u32) * 8" or something similar that documents
> where the value of this limit comes from.
>=20

Ok.

> >  /*
> >   * Representation of a v4.1+ session. These are refcounted in a simila=
r fashion
> >   * to the nfs4_client. References are only taken when the server is ac=
tively
> > @@ -325,7 +328,9 @@ struct nfsd4_session {
> >  	struct nfsd4_cb_sec	se_cb_sec;
> >  	struct list_head	se_conns;
> >  	u32			se_cb_prog;
> > -	u32			se_cb_seq_nr;
> > +	u32			se_cb_slot_avail; /* bitmap of available slots */
> > +	u32			se_cb_highest_slot;	/* highest slot client wants */
> > +	u32			se_cb_seq_nr[NFSD_BC_SLOT_TABLE_MAX];
> >  	struct nfsd4_slot	*se_slots[];	/* forward channel slots */
> >  };
> > =20
> > @@ -459,9 +464,6 @@ struct nfs4_client {
> >  	 */
> >  	struct dentry		*cl_nfsd_info_dentry;
> > =20
> > -	/* for nfs41 callbacks */
> > -	/* We currently support a single back channel with a single slot */
> > -	unsigned long		cl_cb_slot_busy;
> >  	struct rpc_wait_queue	cl_cb_waitq;	/* backchannel callers may */
> >  						/* wait here for slots */
> >  	struct net		*net;
> > diff --git a/fs/nfsd/trace.h b/fs/nfsd/trace.h
> > index f318898cfc31614b5a84a4867e18c2b3a07122c9..a9c17186b6892f1df8d7f7b=
90e250c2913ab23fe 100644
> > --- a/fs/nfsd/trace.h
> > +++ b/fs/nfsd/trace.h
> > @@ -1697,7 +1697,7 @@ TRACE_EVENT(nfsd_cb_free_slot,
> >  		__entry->cl_id =3D sid->clientid.cl_id;
> >  		__entry->seqno =3D sid->sequence;
> >  		__entry->reserved =3D sid->reserved;
> > -		__entry->slot_seqno =3D session->se_cb_seq_nr;
> > +		__entry->slot_seqno =3D session->se_cb_seq_nr[cb->cb_held_slot];
> >  	),
> >  	TP_printk(SUNRPC_TRACE_TASK_SPECIFIER
> >  		" sessionid=3D%08x:%08x:%08x:%08x new slot seqno=3D%u",
> >=20
> > --=20
> > 2.47.0
> >=20
>=20

--=20
Jeff Layton <jlayton@kernel.org>


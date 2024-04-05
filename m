Return-Path: <linux-nfs+bounces-2684-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DDD6689A4AD
	for <lists+linux-nfs@lfdr.de>; Fri,  5 Apr 2024 21:08:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 930B42820E0
	for <lists+linux-nfs@lfdr.de>; Fri,  5 Apr 2024 19:08:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FE45172BBB;
	Fri,  5 Apr 2024 19:08:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Oui7mLSr"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24D3F172BB3;
	Fri,  5 Apr 2024 19:08:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712344125; cv=none; b=UlQpa5GxhqF8yfGvgU0muVmohxMsosJduO9n2erpbac1RkxopnFHPIT6ML8m7GYHOXs+N5k26LfdDA1QrWEmtgKqzS6Tc0QX7Jv/7QJeCzL5yhwgqVkORCZ3/DR4tM77J/81xY7G4OtXctLfPcgibuS+cR5paLdVmTgEtl8t3t0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712344125; c=relaxed/simple;
	bh=laVEdmCP7XZgqMZ/q4DNr2uOITGzjkWJUo1XdR2vryU=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=NlsvyWo71b2lbWt8EpNXzJW0ssCHVYbY9CTipLTtlHmxEv1mZpNnj+yiEnI9ejdBxeXogTKs+4HzGLwj1r9Ttu7cPLFEE35onSCkuh0FLZv3FU6Q6pbyWX68Xf6/a4f5rrVD7HyZ0UXcM/VzhTwEfeQ6A+Ih8AcqSHG6f4WcqLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Oui7mLSr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 022AAC433C7;
	Fri,  5 Apr 2024 19:08:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712344124;
	bh=laVEdmCP7XZgqMZ/q4DNr2uOITGzjkWJUo1XdR2vryU=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=Oui7mLSrIto4sjwATqhZ71T0WSlQk6mB4d2TRFXLR8FBRiL1/upSQrQpnVIesQnjZ
	 7ljmc1b+kvjtnpQHU8n+nGRt3lhams9zZDEb/VQ52vZU79AqElKyhsHCgQ3hHmZ+Rp
	 9YZzPdOHZE2eG2VsJOkvUv8y1sdNmngQeE4Bo23IMQTGzWGaRlHroRFZEXYHU9GumQ
	 SPpmHbsZxuz6jcKIP+P9zor3PhUHHoDIdhW34SnuqSFJkMSdfWn2prDhhNxSEfpwGk
	 sPZD/WoTWXMo6qNwBPRAPDkFM0lEvPzE4aPc6a9VBgYH4mu28OPRkgCb+PdrC0aCuX
	 N/084awUJKa1A==
Message-ID: <93bc191abd148cbc64d2a5a6d7fd2752b21e0512.camel@kernel.org>
Subject: Re: [PATCH 2/3] nfsd: new tracepoint for check_slot_seqid
From: Jeff Layton <jlayton@kernel.org>
To: Chuck Lever <chuck.lever@oracle.com>
Cc: Neil Brown <neilb@suse.de>, Olga Kornievskaia <kolga@netapp.com>, Dai
 Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>,
 linux-nfs@vger.kernel.org,  linux-kernel@vger.kernel.org
Date: Fri, 05 Apr 2024 15:08:42 -0400
In-Reply-To: <ZhBLBEIgKxChNBAY@tissot.1015granger.net>
References: <20240405-nfsd-fixes-v1-0-e017bfe9a783@kernel.org>
	 <20240405-nfsd-fixes-v1-2-e017bfe9a783@kernel.org>
	 <ZhBLBEIgKxChNBAY@tissot.1015granger.net>
Autocrypt: addr=jlayton@kernel.org; prefer-encrypt=mutual;
 keydata=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
	kZWuOsJdJQdmwlWC5L5ln9xgfr/4mOY38B0U=
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.4 (3.50.4-1.fc39) 
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2024-04-05 at 15:03 -0400, Chuck Lever wrote:
> On Fri, Apr 05, 2024 at 02:40:50PM -0400, Jeff Layton wrote:
> > Replace a dprintk in check_slot_seqid with a new tracepoint.  Add a
> > nfs4_client argument to check_slot_seqid so that we can pass the
> > appropriate info to the tracepoint.
> >=20
> > Signed-off-by: Jeffrey Layton <jlayton@redhat.com>
> > ---
> >  fs/nfsd/nfs4state.c | 12 ++++++------
> >  fs/nfsd/trace.h     | 34 ++++++++++++++++++++++++++++++++++
> >  2 files changed, 40 insertions(+), 6 deletions(-)
> >=20
> > diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
> > index 3cef81e196c6..5891bc3e2b0b 100644
> > --- a/fs/nfsd/nfs4state.c
> > +++ b/fs/nfsd/nfs4state.c
> > @@ -3642,10 +3642,9 @@ nfsd4_exchange_id(struct svc_rqst *rqstp, struct=
 nfsd4_compound_state *cstate,
> >  }
> > =20
> >  static __be32
> > -check_slot_seqid(u32 seqid, u32 slot_seqid, int slot_inuse)
> > +check_slot_seqid(struct nfs4_client *clp, u32 seqid, u32 slot_seqid, b=
ool slot_inuse)
> >  {
> > -	dprintk("%s enter. seqid %d slot_seqid %d\n", __func__, seqid,
> > -		slot_seqid);
> > +	trace_check_slot_seqid(clp, seqid, slot_seqid, slot_inuse);
>=20
> Getting rid of the dprintk: +1
>=20
> Tracing slot seqid checks: +1
>=20
> But I'd like something a little different for the tracepoint
> itself. I can make these changes if you like to just hand this off.
>=20
> Let's make this trace point into three separate trace events, one
> at the nfsd4_sequence check_slot_seqid() call site, and two in
> nfsd4_create_session(), like below.
>=20
> Two reasons for this change:
>=20
> 1. Separate tracepoints in nfsd4_create_session will show whether
>    the client is confirmed or not
>=20
> 2. The tracepoint in nfsd4_sequence will normally be noisy, so
>    having a separate tracepoint for that case makes it easy to
>    disable that one while leaving the create_session tracepoints
>    enabled.
>=20
> And, bonus: you won't have to change the synopsis of
> check_slot_seqid().
>=20
>=20
> >  	/* The slot is in use, and no response has been sent. */
> >  	if (slot_inuse) {
> > @@ -3827,7 +3826,8 @@ nfsd4_create_session(struct svc_rqst *rqstp,
> >  		cs_slot =3D &conf->cl_cs_slot;
> 		trace_nfsd_slot_seqid_confirmed
> >  	else
> >  		cs_slot =3D &unconf->cl_cs_slot;
> 		trace_nfsd_slot_seqid_unconfirmed
> > -	status =3D check_slot_seqid(cr_ses->seqid, cs_slot->sl_seqid, 0);
> > +	status =3D check_slot_seqid(conf ? conf : unconf, cr_ses->seqid,
> > +				  cs_slot->sl_seqid, false);
> >  	switch (status) {
> >  	case nfs_ok:
> >  		cs_slot->sl_seqid++;
> > @@ -4221,8 +4221,8 @@ nfsd4_sequence(struct svc_rqst *rqstp, struct nfs=
d4_compound_state *cstate,
> >  	 * sr_highest_slotid and the sr_target_slot id to maxslots */
> >  	seq->maxslots =3D session->se_fchannel.maxreqs;
> > =20
> 	trace_nfsd_slot_seqid_sequence
> > -	status =3D check_slot_seqid(seq->seqid, slot->sl_seqid,
> > -					slot->sl_flags & NFSD4_SLOT_INUSE);
> > +	status =3D check_slot_seqid(clp, seq->seqid, slot->sl_seqid,
> > +				  slot->sl_flags & NFSD4_SLOT_INUSE);
> >  	if (status =3D=3D nfserr_replay_cache) {
> >  		status =3D nfserr_seq_misordered;
> >  		if (!(slot->sl_flags & NFSD4_SLOT_INITIALIZED))
> > diff --git a/fs/nfsd/trace.h b/fs/nfsd/trace.h
> > index 7f1a6d568bdb..ec00ca7ecfc8 100644
> > --- a/fs/nfsd/trace.h
> > +++ b/fs/nfsd/trace.h
> > @@ -1542,6 +1542,40 @@ TRACE_EVENT(nfsd_cb_seq_status,
> >  	)
> >  );
> > =20
> > +TRACE_EVENT(check_slot_seqid,
>=20
> Nit: NFSD tracepoint names should start with "nfsd_".
>=20
>=20
> > +	TP_PROTO(
> > +		const struct nfs4_client *clp,
> > +		u32 seqid,
> > +		u32 slot_seqid,
> > +		bool inuse
> > +	),
> > +	TP_ARGS(clp, seqid, slot_seqid, inuse),
> > +	TP_STRUCT__entry(
> > +		__field(u32, seqid)
> > +		__field(u32, slot_seqid)
> > +		__field(u32, cl_boot)
> > +		__field(u32, cl_id)
> > +		__sockaddr(addr, clp->cl_cb_conn.cb_addrlen)
> > +		__field(bool, conf)
> > +		__field(bool, inuse)
> > +	),
> > +	TP_fast_assign(
> > +		__entry->cl_boot =3D clp->cl_clientid.cl_boot;
> > +		__entry->cl_id =3D clp->cl_clientid.cl_id;
> > +		__assign_sockaddr(addr, &clp->cl_cb_conn.cb_addr,
> > +				  clp->cl_cb_conn.cb_addrlen);
> > +		__entry->seqid =3D seqid;
> > +		__entry->slot_seqid =3D slot_seqid;
> > +		__entry->conf =3D test_bit(NFSD4_CLIENT_CONFIRMED, &clp->cl_flags);
> > +		__entry->inuse =3D inuse;
> > +	),
> > +	TP_printk("addr=3D%pISpc %s client %08x:%08x seqid=3D%u slot_seqid=3D=
%u inuse=3D%d",
> > +		__get_sockaddr(addr), __entry->conf ? "conf" : "unconf",
> > +		__entry->cl_boot, __entry->cl_id,
> > +		__entry->seqid, __entry->slot_seqid, __entry->inuse
>=20
> Nit: How about: __entry->in_use ? "(in use)" : "(not in use)"
>=20
> Since TP_printk is for human readers.
>=20
>=20
> > +	)
> > +);
> > +
> >  TRACE_EVENT(nfsd_cb_free_slot,
> >  	TP_PROTO(
> >  		const struct rpc_task *task,
> >=20
> > --=20
> > 2.44.0
> >=20
>=20

Sure, those all sound like fine changes. If you're fine making them,
thats good with me too. I mostly posted these since I used these to help
track down the CB_RECALL_ANY issue.
--=20
Jeff Layton <jlayton@kernel.org>


Return-Path: <linux-nfs+bounces-7519-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 557359B2111
	for <lists+linux-nfs@lfdr.de>; Sun, 27 Oct 2024 23:29:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 46DBF1C2084C
	for <lists+linux-nfs@lfdr.de>; Sun, 27 Oct 2024 22:29:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 282271714A0;
	Sun, 27 Oct 2024 22:29:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="IGtvCf/p";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="dooMqoVy";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="IGtvCf/p";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="dooMqoVy"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09A2A14BF86
	for <linux-nfs@vger.kernel.org>; Sun, 27 Oct 2024 22:29:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730068156; cv=none; b=Ih4ukIT8uup16fwpw9Rqr+VxlxnQHwGOqGrkjSdGcL4BLEYFTG1CRL4UPMpkM8t3dlc8EG5wAaZPF8PaXdBvy3VLqEDVvJgxqDPNZcJSyum7QGJfgDU7B2ugBEQBP6IR1AJM/xMFYyrBgTPcmfaf0oDyyqcSUA4zlAVaOKZ4Bu8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730068156; c=relaxed/simple;
	bh=fVlnwttccjQXXHiZcgJooM2d4iEKE+xdZSIl2eccjUI=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=g5eYyj0qCTP3kVsRFhwSNppn/5hwOfH4T1ZP3JPprNPR7Gl0s3WCU8YXEJEeoiaZ9H9dm4+newLUIArpP/tmMrtjMDo/TwVhuP3rW8UtkCELNXlD8aCawezuxIQke/4zbENsTBA46+/YQVR+9eHmt0vvl7HpDR2SDQqQ98XFjEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=IGtvCf/p; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=dooMqoVy; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=IGtvCf/p; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=dooMqoVy; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 0507721B38;
	Sun, 27 Oct 2024 22:29:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1730068151; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rGO0fMwK2G5BPPmIAR9iZ4PEg/CUWZBiXaAPrVTcCnE=;
	b=IGtvCf/p/bp2tLkYtqoCCh/HxqOfZrHhD/ZuG6opaBr5KZBUb+swKCEf6z+xY/CrG3QGdF
	/UeJjbHy1xXoXjBLkGkf+t5JkAuj3Dk2o+BPzYlwtraF21CopsiD6MN83/dXpB8BXJ2Wdy
	TdbMK6AW7Yo2RIA76PVJdHUdAhnKBxI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1730068151;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rGO0fMwK2G5BPPmIAR9iZ4PEg/CUWZBiXaAPrVTcCnE=;
	b=dooMqoVyEhdNiu6OUj3EawwYNu7ghWQ4v6bnpht4abvpStQQ9e16J27fQDSJhDi3z8mX3E
	fHwBzzIzn0MG29AA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1730068151; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rGO0fMwK2G5BPPmIAR9iZ4PEg/CUWZBiXaAPrVTcCnE=;
	b=IGtvCf/p/bp2tLkYtqoCCh/HxqOfZrHhD/ZuG6opaBr5KZBUb+swKCEf6z+xY/CrG3QGdF
	/UeJjbHy1xXoXjBLkGkf+t5JkAuj3Dk2o+BPzYlwtraF21CopsiD6MN83/dXpB8BXJ2Wdy
	TdbMK6AW7Yo2RIA76PVJdHUdAhnKBxI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1730068151;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rGO0fMwK2G5BPPmIAR9iZ4PEg/CUWZBiXaAPrVTcCnE=;
	b=dooMqoVyEhdNiu6OUj3EawwYNu7ghWQ4v6bnpht4abvpStQQ9e16J27fQDSJhDi3z8mX3E
	fHwBzzIzn0MG29AA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 97106136C7;
	Sun, 27 Oct 2024 22:29:08 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id VXD/ErS+HmdoCgAAD6G6ig
	(envelope-from <neilb@suse.de>); Sun, 27 Oct 2024 22:29:08 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "NeilBrown" <neilb@suse.de>
To: "Chuck Lever" <chuck.lever@oracle.com>
Cc: "Jeff Layton" <jlayton@kernel.org>, linux-nfs@vger.kernel.org,
 okorniev@redhat.com, "Dai Ngo" <Dai.Ngo@oracle.com>,
 "Tom Talpey" <tom@talpey.com>
Subject: Re: [PATCH - for -next V2] nfsd: dynamically adjust per-client DRC
 slot limits.
In-reply-to: <Zx5jbrm5D9rPorhs@tissot.1015granger.net>
References: <>, <Zx5jbrm5D9rPorhs@tissot.1015granger.net>
Date: Mon, 28 Oct 2024 09:28:50 +1100
Message-id: <173006813027.81717.10037619177174746588@noble.neil.brown.name>
X-Spam-Level: 
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-0.995];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,imap1.dmz-prg2.suse.org:helo]
X-Spam-Score: -4.30
X-Spam-Flag: NO

On Mon, 28 Oct 2024, Chuck Lever wrote:
> On Thu, Oct 24, 2024 at 09:01:26AM +1100, NeilBrown wrote:
> >=20
> > From 6e071e346134e5b21db01f042039ab0159bb23a3 Mon Sep 17 00:00:00 2001
> > From: NeilBrown <neilb@suse.de>
> > Date: Wed, 17 Apr 2024 11:50:53 +1000
> > Subject: [PATCH] nfsd: dynamically adjust per-client DRC slot limits.
> >=20
> > Currently per-client DRC slot limits (for v4.1+) are calculated when the
> > client connects, and they are left unchanged.  So earlier clients can
> > get a larger share when memory is tight.
> >=20
> > The heuristic for choosing a number includes the number of configured
> > server threads.  This is problematic for 2 reasons.
> > 1/ sv_nrthreads is different in different net namespaces, but the
> >    memory allocation is global across all namespaces.  So different
> >    namespaces get treated differently without good reason.
> > 2/ a future patch will auto-configure number of threads based on
> >    load so that there will be no need to preconfigure a number.  This will
> >    make the current heuristic even more arbitrary.
> >=20
> > NFSv4.1 allows the number of slots to be varied dynamically - in the
> > reply to each SEQUENCE op.  With this patch we provide a provisional
> > upper limit in the EXCHANGE_ID reply which might end up being too big,
> > and adjust it with each SEQUENCE reply.
> >=20
> > The goal for when memory is tight is to allow each client to have a
> > similar number of slots.  So clients that ask for larger slots get more
> > memory.   This may not be ideal.  It could be changed later.
> >=20
> > So we track the sum of the slot sizes of all active clients, and share
> > memory out based on the ratio of the slot size for a given client with
> > the sum of slot sizes.  We never allow more in a SEQUENCE reply than we
> > did in the EXCHANGE_ID reply.
>=20
> IIUC:
>=20
> s/EXCHANGE_ID/CREATE_SESSION=20

Yes, thanks.

>=20
>=20
> It would be great if nfsd4_create_session() could report the
> negotiated session parameters. dprintk would be fine since
> CREATE_SESSION is an infrequent operation, and administrators might
> want this information if they notice unexplained slowness.

Maybe.  But as the setting can change in response to SEQUENCE replies,
maybe it would be better in /proc/fs/nfsd/clients/*/info, or a new file
there?
=20

>=20
> It might be nicer if these heuristics were eventually replaced by a
> shrinker. Maybe for another day.

I don't think so.  A shrinker is for freeing things that have already
been allocated.  Here we want to predict whether future allocations will
succeed easily.  If we pre-allocated space for all slots in the reply
cache, then a shrinker would be appropriate to reduce the
pre-allocation, but we don't do that and I don't think we want to.

>=20
> One or two more thoughts below.
>=20
>=20
> > Signed-off-by: NeilBrown <neilb@suse.de>
> > ---
> >=20
> > This time actually with the comment change.
> >=20
> >=20
> >  fs/nfsd/nfs4state.c | 82 +++++++++++++++++++++++++--------------------
> >  fs/nfsd/nfs4xdr.c   |  2 +-
> >  fs/nfsd/nfsd.h      |  6 +++-
> >  fs/nfsd/nfssvc.c    |  7 ++--
> >  fs/nfsd/state.h     |  2 +-
> >  fs/nfsd/xdr4.h      |  2 --
> >  6 files changed, 57 insertions(+), 44 deletions(-)
> >=20
> > diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
> > index 56b261608af4..d585c267731b 100644
> > --- a/fs/nfsd/nfs4state.c
> > +++ b/fs/nfsd/nfs4state.c
> > @@ -1909,44 +1909,26 @@ static inline u32 slot_bytes(struct nfsd4_channel=
_attrs *ca)
> >  }
> > =20
> >  /*
> > - * XXX: If we run out of reserved DRC memory we could (up to a point)
> > - * re-negotiate active sessions and reduce their slot usage to make
> > - * room for new connections. For now we just fail the create session.
> > + * When a client connects it gets a max_requests number that would allow
> > + * it to use 1/8 of the memory we think can reasonably be used for the D=
RC.
> > + * Later in response to SEQUENCE operations we further limit that when t=
here
> > + * are more than 8 concurrent clients.
>=20
> Eight is a bit of a magic number. Other constants appear to get nice
> symbolic names.

I wonder what name would make sense.... "min_clients" ??? Not ideal.

Maybe we should just use "1" - then we wouldn't need a name.

>=20
>=20
> >   */
> > -static u32 nfsd4_get_drc_mem(struct nfsd4_channel_attrs *ca, struct nfsd=
_net *nn)
> > +static u32 nfsd4_get_drc_mem(struct nfsd4_channel_attrs *ca)
> >  {
> >  	u32 slotsize =3D slot_bytes(ca);
> >  	u32 num =3D ca->maxreqs;
> > -	unsigned long avail, total_avail;
> > -	unsigned int scale_factor;
> > +	unsigned long avail;
> > =20
> >  	spin_lock(&nfsd_drc_lock);
> > -	if (nfsd_drc_max_mem > nfsd_drc_mem_used)
> > -		total_avail =3D nfsd_drc_max_mem - nfsd_drc_mem_used;
> > -	else
> > -		/* We have handed out more space than we chose in
> > -		 * set_max_drc() to allow.  That isn't really a
> > -		 * problem as long as that doesn't make us think we
> > -		 * have lots more due to integer overflow.
> > -		 */
> > -		total_avail =3D 0;
> > -	avail =3D min((unsigned long)NFSD_MAX_MEM_PER_SESSION, total_avail);
> > -	/*
> > -	 * Never use more than a fraction of the remaining memory,
> > -	 * unless it's the only way to give this client a slot.
> > -	 * The chosen fraction is either 1/8 or 1/number of threads,
> > -	 * whichever is smaller.  This ensures there are adequate
> > -	 * slots to support multiple clients per thread.
> > -	 * Give the client one slot even if that would require
> > -	 * over-allocation--it is better than failure.
> > -	 */
> > -	scale_factor =3D max_t(unsigned int, 8, nn->nfsd_serv->sv_nrthreads);
> > =20
> > -	avail =3D clamp_t(unsigned long, avail, slotsize,
> > -			total_avail/scale_factor);
> > -	num =3D min_t(int, num, avail / slotsize);
> > -	num =3D max_t(int, num, 1);
> > -	nfsd_drc_mem_used +=3D num * slotsize;
> > +	avail =3D min(NFSD_MAX_MEM_PER_SESSION,
> > +		    nfsd_drc_max_mem / 8);
> > +
> > +	num =3D clamp_t(int, num, 1, avail / slotsize);
>=20
> The variables involved in this computation are all unsigned. Why is
> clamp_t called with an "int" first argument?

The code being replaced has a "unsigned" for max_t and clamp_t, then
"int" for min_t and max_t.  I guess I copied the wrong one :-(

Do you want to make some tweeks to the patch, or should I resend it?

Thanks,
NeilBrown



>=20
>=20
> > +
> > +	nfsd_drc_slotsize_sum +=3D slotsize;
> > +
> >  	spin_unlock(&nfsd_drc_lock);
> > =20
> >  	return num;
> > @@ -1957,10 +1939,34 @@ static void nfsd4_put_drc_mem(struct nfsd4_channe=
l_attrs *ca)
> >  	int slotsize =3D slot_bytes(ca);
> > =20
> >  	spin_lock(&nfsd_drc_lock);
> > -	nfsd_drc_mem_used -=3D slotsize * ca->maxreqs;
> > +	nfsd_drc_slotsize_sum -=3D slotsize;
> >  	spin_unlock(&nfsd_drc_lock);
> >  }
> > =20
> > +/*
> > + * Report the number of slots that we would like the client to limit
> > + * itself to.
> > + */
> > +static unsigned int nfsd4_get_drc_slots(struct nfsd4_session *session)
> > +{
> > +	u32 slotsize =3D slot_bytes(&session->se_fchannel);
> > +	unsigned long avail;
> > +	unsigned long slotsize_sum =3D READ_ONCE(nfsd_drc_slotsize_sum);
> > +
> > +	if (slotsize_sum < slotsize)
> > +		slotsize_sum =3D slotsize;
> > +
> > +	/*
> > +	 * We share memory so all clients get the same number of slots.
> > +	 * Find our share of avail mem across all active clients,
> > +	 * then limit to 1/8 of total, and configured max
> > +	 */
> > +	avail =3D min3(nfsd_drc_max_mem * slotsize / slotsize_sum,
> > +		     nfsd_drc_max_mem / 8,
> > +		     NFSD_MAX_MEM_PER_SESSION);
> > +	return max3(1UL, avail / slotsize, session->se_fchannel.maxreqs);
> > +}
> > +
> >  static struct nfsd4_session *alloc_session(struct nfsd4_channel_attrs *f=
attrs,
> >  					   struct nfsd4_channel_attrs *battrs)
> >  {
> > @@ -3731,7 +3737,7 @@ static __be32 check_forechannel_attrs(struct nfsd4_=
channel_attrs *ca, struct nfs
> >  	 * Note that we always allow at least one slot, because our
> >  	 * accounting is soft and provides no guarantees either way.
> >  	 */
> > -	ca->maxreqs =3D nfsd4_get_drc_mem(ca, nn);
> > +	ca->maxreqs =3D nfsd4_get_drc_mem(ca);
> > =20
> >  	return nfs_ok;
> >  }
> > @@ -4225,10 +4231,12 @@ nfsd4_sequence(struct svc_rqst *rqstp, struct nfs=
d4_compound_state *cstate,
> >  	slot =3D session->se_slots[seq->slotid];
> >  	dprintk("%s: slotid %d\n", __func__, seq->slotid);
> > =20
> > -	/* We do not negotiate the number of slots yet, so set the
> > -	 * maxslots to the session maxreqs which is used to encode
> > -	 * sr_highest_slotid and the sr_target_slot id to maxslots */
> > -	seq->maxslots =3D session->se_fchannel.maxreqs;
> > +	/* Negotiate number of slots: set the target, and use the
> > +	 * same for max as long as it doesn't decrease the max
> > +	 * (that isn't allowed).
> > +	 */
> > +	seq->target_maxslots =3D nfsd4_get_drc_slots(session);
> > +	seq->maxslots =3D max(seq->maxslots, seq->target_maxslots);
> > =20
> >  	trace_nfsd_slot_seqid_sequence(clp, seq, slot);
> >  	status =3D check_slot_seqid(seq->seqid, slot->sl_seqid,
> > diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
> > index f118921250c3..e4e706872e54 100644
> > --- a/fs/nfsd/nfs4xdr.c
> > +++ b/fs/nfsd/nfs4xdr.c
> > @@ -4955,7 +4955,7 @@ nfsd4_encode_sequence(struct nfsd4_compoundres *res=
p, __be32 nfserr,
> >  	if (nfserr !=3D nfs_ok)
> >  		return nfserr;
> >  	/* sr_target_highest_slotid */
> > -	nfserr =3D nfsd4_encode_slotid4(xdr, seq->maxslots - 1);
> > +	nfserr =3D nfsd4_encode_slotid4(xdr, seq->target_maxslots - 1);
> >  	if (nfserr !=3D nfs_ok)
> >  		return nfserr;
> >  	/* sr_status_flags */
> > diff --git a/fs/nfsd/nfsd.h b/fs/nfsd/nfsd.h
> > index 4b56ba1e8e48..33c9db3ee8b6 100644
> > --- a/fs/nfsd/nfsd.h
> > +++ b/fs/nfsd/nfsd.h
> > @@ -90,7 +90,11 @@ extern const struct svc_version	nfsd_version2, nfsd_ve=
rsion3, nfsd_version4;
> >  extern struct mutex		nfsd_mutex;
> >  extern spinlock_t		nfsd_drc_lock;
> >  extern unsigned long		nfsd_drc_max_mem;
> > -extern unsigned long		nfsd_drc_mem_used;
> > +/* Storing the sum of the slot sizes for all active clients (across
> > + * all net-namespaces) allows a share of total available memory to
> > + * be allocaed to each client based on its slot size.
> > + */
> > +extern unsigned long		nfsd_drc_slotsize_sum;
> >  extern atomic_t			nfsd_th_cnt;		/* number of available threads */
> > =20
> >  extern const struct seq_operations nfs_exports_op;
> > diff --git a/fs/nfsd/nfssvc.c b/fs/nfsd/nfssvc.c
> > index 49e2f32102ab..e596eb5d10db 100644
> > --- a/fs/nfsd/nfssvc.c
> > +++ b/fs/nfsd/nfssvc.c
> > @@ -78,7 +78,7 @@ DEFINE_MUTEX(nfsd_mutex);
> >   */
> >  DEFINE_SPINLOCK(nfsd_drc_lock);
> >  unsigned long	nfsd_drc_max_mem;
> > -unsigned long	nfsd_drc_mem_used;
> > +unsigned long	nfsd_drc_slotsize_sum;
> > =20
> >  #if IS_ENABLED(CONFIG_NFS_LOCALIO)
> >  static const struct svc_version *localio_versions[] =3D {
> > @@ -589,10 +589,13 @@ void nfsd_reset_versions(struct nfsd_net *nn)
> >   */
> >  static void set_max_drc(void)
> >  {
> > +	if (nfsd_drc_max_mem)
> > +		return;
> > +
> >  	#define NFSD_DRC_SIZE_SHIFT	7
> >  	nfsd_drc_max_mem =3D (nr_free_buffer_pages()
> >  					>> NFSD_DRC_SIZE_SHIFT) * PAGE_SIZE;
> > -	nfsd_drc_mem_used =3D 0;
> > +	nfsd_drc_slotsize_sum =3D 0;
> >  	dprintk("%s nfsd_drc_max_mem %lu \n", __func__, nfsd_drc_max_mem);
> >  }
> > =20
> > diff --git a/fs/nfsd/state.h b/fs/nfsd/state.h
> > index 79c743c01a47..fe71ae3c577b 100644
> > --- a/fs/nfsd/state.h
> > +++ b/fs/nfsd/state.h
> > @@ -214,7 +214,7 @@ static inline struct nfs4_delegation *delegstateid(st=
ruct nfs4_stid *s)
> >  /* Maximum number of slots per session. 160 is useful for long haul TCP =
*/
> >  #define NFSD_MAX_SLOTS_PER_SESSION     160
> >  /* Maximum  session per slot cache size */
> > -#define NFSD_SLOT_CACHE_SIZE		2048
> > +#define NFSD_SLOT_CACHE_SIZE		2048UL
> >  /* Maximum number of NFSD_SLOT_CACHE_SIZE slots per session */
> >  #define NFSD_CACHE_SIZE_SLOTS_PER_SESSION	32
> >  #define NFSD_MAX_MEM_PER_SESSION  \
> > diff --git a/fs/nfsd/xdr4.h b/fs/nfsd/xdr4.h
> > index 2a21a7662e03..71b87190a4a6 100644
> > --- a/fs/nfsd/xdr4.h
> > +++ b/fs/nfsd/xdr4.h
> > @@ -575,9 +575,7 @@ struct nfsd4_sequence {
> >  	u32			slotid;			/* request/response */
> >  	u32			maxslots;		/* request/response */
> >  	u32			cachethis;		/* request */
> > -#if 0
> >  	u32			target_maxslots;	/* response */
> > -#endif /* not yet */
> >  	u32			status_flags;		/* response */
> >  };
> > =20
> > --=20
> > 2.46.0
> >=20
>=20
> --=20
> Chuck Lever
>=20



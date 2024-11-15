Return-Path: <linux-nfs+bounces-7994-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 00B1A9CD617
	for <lists+linux-nfs@lfdr.de>; Fri, 15 Nov 2024 05:02:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6487EB21772
	for <lists+linux-nfs@lfdr.de>; Fri, 15 Nov 2024 04:02:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B346A156F5D;
	Fri, 15 Nov 2024 04:01:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="PX7iH5cN";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="e8ihf0Mv";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="PX7iH5cN";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="e8ihf0Mv"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EDAD156243
	for <linux-nfs@vger.kernel.org>; Fri, 15 Nov 2024 04:01:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731643316; cv=none; b=NceV+8qkiR15B9RipDHGRSMGrnd/6snSuKzoagDZ559VNDUAyOmc+4wIyxAVzWpafG/hy/yqI6ixHnwNYFzcSOupG4kwTo0jJDPzkEDG1MazZ9I9K3nrZam/1s4f7E4QfBNE+Pk9TjDXPH3Ny5LnA307dYJoRIZBABar0sIW64Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731643316; c=relaxed/simple;
	bh=ofuYqePHA9DsLsc7hWcpCH4q5Y5P9Czz6TUNYPgAcsY=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=cR1F+E7cG8cdVd6f6viKlGSU/U8hdcquQSuqXDivWFbjOGthGa/cDkn3a7OrkTsX2m5T/KJRUgH0TpOx6zzid3uYL9pnBA0wrQ1bS3dweUcGk4BJJYIvejYQk4RCuBj82mybMEii/szUyXWYDfuK0FLZSgpCwAmZwMy1BOqBNBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=PX7iH5cN; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=e8ihf0Mv; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=PX7iH5cN; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=e8ihf0Mv; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 424ED1F854;
	Fri, 15 Nov 2024 04:01:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1731643312; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2UNeLrBuRxN/2gVR8R5sHwwCUCaT2UkqrI1Wph8plNg=;
	b=PX7iH5cNEUqIxJ3Ah0Gd1fAY3mLRTZ21obmihHF/0TNHgO4zqRGlFX9MTNJIecK+0EKVEU
	QNtvMhVqO18ExzYXI2/3oroiCgSgcBJEwyVJi3CFiVXBN8F4JQFEVKOqvIt0YIT7b8BI77
	SWM18dTt93zUCy+FXCO7OqQUvmc86wU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1731643312;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2UNeLrBuRxN/2gVR8R5sHwwCUCaT2UkqrI1Wph8plNg=;
	b=e8ihf0MvzK/P7i8nBtqmtlbBbp86W7Nv+PG2wXn/+TJ0DT2gfquk5dsihJGkNJ8H6zBR2K
	AqYtnqvmsF4M6EBg==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=PX7iH5cN;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=e8ihf0Mv
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1731643312; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2UNeLrBuRxN/2gVR8R5sHwwCUCaT2UkqrI1Wph8plNg=;
	b=PX7iH5cNEUqIxJ3Ah0Gd1fAY3mLRTZ21obmihHF/0TNHgO4zqRGlFX9MTNJIecK+0EKVEU
	QNtvMhVqO18ExzYXI2/3oroiCgSgcBJEwyVJi3CFiVXBN8F4JQFEVKOqvIt0YIT7b8BI77
	SWM18dTt93zUCy+FXCO7OqQUvmc86wU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1731643312;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2UNeLrBuRxN/2gVR8R5sHwwCUCaT2UkqrI1Wph8plNg=;
	b=e8ihf0MvzK/P7i8nBtqmtlbBbp86W7Nv+PG2wXn/+TJ0DT2gfquk5dsihJGkNJ8H6zBR2K
	AqYtnqvmsF4M6EBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 2A1B01347F;
	Fri, 15 Nov 2024 04:01:49 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id +MpINK3HNmeyZAAAD6G6ig
	(envelope-from <neilb@suse.de>); Fri, 15 Nov 2024 04:01:49 +0000
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
Cc: "Chuck Lever" <chuck.lever@oracle.com>, linux-nfs@vger.kernel.org,
 "Olga Kornievskaia" <okorniev@redhat.com>, "Dai Ngo" <Dai.Ngo@oracle.com>,
 "Tom Talpey" <tom@talpey.com>
Subject:
 Re: [PATCH 1/4] nfsd: remove artificial limits on the session-based DRC
In-reply-to: <1db227ccb347c7877998ab20a609bc3a9896c7db.camel@kernel.org>
References: <>, <1db227ccb347c7877998ab20a609bc3a9896c7db.camel@kernel.org>
Date: Fri, 15 Nov 2024 15:01:47 +1100
Message-id: <173164330712.1734440.9600685611411294618@noble.neil.brown.name>
X-Rspamd-Queue-Id: 424ED1F854
X-Spam-Level: 
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[noble.neil.brown.name:mid,suse.de:dkim,suse.de:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -4.51
X-Spam-Flag: NO

On Thu, 14 Nov 2024, Jeff Layton wrote:
> On Wed, 2024-11-13 at 16:38 +1100, NeilBrown wrote:
> > Rather than guessing how much space it might be safe to use for the DRC,
> > simply try allocating slots and be prepared to accept failure.
> >=20
> > The first slot for each session is allocated with GFP_KERNEL which is
> > unlikely to fail.  Subsequent slots are allocated with the addition of
> > __GFP_NORETRY which is expected to fail if there isn't much free memory.
> >=20
> > This is probably too aggressive but clears the way for adding a
> > shrinker interface to free extra slots when memory is tight.
> >=20
> > Also *always* allow NFSD_MAX_SLOTS_PER_SESSION slot pointers per
> > session.  This allows the session to be allocated before we know how
> > many slots we will successfully allocate, and will be useful when we
> > starting dynamically increasing the number of allocated slots.
> >=20
> > Signed-off-by: NeilBrown <neilb@suse.de>
> > ---
> >  fs/nfsd/nfs4state.c | 91 +++++++--------------------------------------
> >  fs/nfsd/nfsd.h      |  3 --
> >  fs/nfsd/nfssvc.c    | 32 ----------------
> >  fs/nfsd/state.h     |  2 +-
> >  4 files changed, 14 insertions(+), 114 deletions(-)
> >=20
> > diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
> > index 551d2958ec29..2dcba0c83c10 100644
> > --- a/fs/nfsd/nfs4state.c
> > +++ b/fs/nfsd/nfs4state.c
> > @@ -1935,59 +1935,6 @@ static inline u32 slot_bytes(struct nfsd4_channel_=
attrs *ca)
> >  	return size + sizeof(struct nfsd4_slot);
> >  }
> > =20
> > -/*
> > - * XXX: If we run out of reserved DRC memory we could (up to a point)
> > - * re-negotiate active sessions and reduce their slot usage to make
> > - * room for new connections. For now we just fail the create session.
> > - */
> > -static u32 nfsd4_get_drc_mem(struct nfsd4_channel_attrs *ca, struct nfsd=
_net *nn)
> > -{
> > -	u32 slotsize =3D slot_bytes(ca);
> > -	u32 num =3D ca->maxreqs;
> > -	unsigned long avail, total_avail;
> > -	unsigned int scale_factor;
> > -
> > -	spin_lock(&nfsd_drc_lock);
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
> > -
> > -	avail =3D clamp_t(unsigned long, avail, slotsize,
> > -			total_avail/scale_factor);
> > -	num =3D min_t(int, num, avail / slotsize);
> > -	num =3D max_t(int, num, 1);
> > -	nfsd_drc_mem_used +=3D num * slotsize;
> > -	spin_unlock(&nfsd_drc_lock);
> > -
> > -	return num;
> > -}
> > -
> > -static void nfsd4_put_drc_mem(struct nfsd4_channel_attrs *ca)
> > -{
> > -	int slotsize =3D slot_bytes(ca);
> > -
> > -	spin_lock(&nfsd_drc_lock);
> > -	nfsd_drc_mem_used -=3D slotsize * ca->maxreqs;
> > -	spin_unlock(&nfsd_drc_lock);
> > -}
> > -
> >  static struct nfsd4_session *alloc_session(struct nfsd4_channel_attrs *f=
attrs,
> >  					   struct nfsd4_channel_attrs *battrs)
> >  {
> > @@ -1996,26 +1943,27 @@ static struct nfsd4_session *alloc_session(struct=
 nfsd4_channel_attrs *fattrs,
> >  	struct nfsd4_session *new;
> >  	int i;
> > =20
> > -	BUILD_BUG_ON(struct_size(new, se_slots, NFSD_MAX_SLOTS_PER_SESSION)
> > -		     > PAGE_SIZE);
> > +	BUILD_BUG_ON(sizeof(new) > PAGE_SIZE);
> > =20
> > -	new =3D kzalloc(struct_size(new, se_slots, numslots), GFP_KERNEL);
> > +	new =3D kzalloc(sizeof(*new), GFP_KERNEL);
> >  	if (!new)
> >  		return NULL;
> >  	/* allocate each struct nfsd4_slot and data cache in one piece */
> > -	for (i =3D 0; i < numslots; i++) {
> > -		new->se_slots[i] =3D kzalloc(slotsize, GFP_KERNEL);
> > +	new->se_slots[0] =3D kzalloc(slotsize, GFP_KERNEL);
> > +	if (!new->se_slots[0])
> > +		goto out_free;
> > +
> > +	for (i =3D 1; i < numslots; i++) {
> > +		new->se_slots[i] =3D kzalloc(slotsize, GFP_KERNEL | __GFP_NORETRY);
> >  		if (!new->se_slots[i])
> > -			goto out_free;
> > +			break;
> >  	}
> > -
> > +	fattrs->maxreqs =3D i;
> >  	memcpy(&new->se_fchannel, fattrs, sizeof(struct nfsd4_channel_attrs));
> >  	memcpy(&new->se_bchannel, battrs, sizeof(struct nfsd4_channel_attrs));
> > =20
> >  	return new;
> >  out_free:
> > -	while (i--)
> > -		kfree(new->se_slots[i]);
> >  	kfree(new);
> >  	return NULL;
> >  }
> > @@ -2128,7 +2076,6 @@ static void __free_session(struct nfsd4_session *se=
s)
> >  static void free_session(struct nfsd4_session *ses)
> >  {
> >  	nfsd4_del_conns(ses);
> > -	nfsd4_put_drc_mem(&ses->se_fchannel);
> >  	__free_session(ses);
> >  }
> > =20
> > @@ -3748,17 +3695,6 @@ static __be32 check_forechannel_attrs(struct nfsd4=
_channel_attrs *ca, struct nfs
> >  	ca->maxresp_cached =3D min_t(u32, ca->maxresp_cached,
> >  			NFSD_SLOT_CACHE_SIZE + NFSD_MIN_HDR_SEQ_SZ);
> >  	ca->maxreqs =3D min_t(u32, ca->maxreqs, NFSD_MAX_SLOTS_PER_SESSION);
> > -	/*
> > -	 * Note decreasing slot size below client's request may make it
> > -	 * difficult for client to function correctly, whereas
> > -	 * decreasing the number of slots will (just?) affect
> > -	 * performance.  When short on memory we therefore prefer to
> > -	 * decrease number of slots instead of their size.  Clients that
> > -	 * request larger slots than they need will get poor results:
> > -	 * Note that we always allow at least one slot, because our
> > -	 * accounting is soft and provides no guarantees either way.
> > -	 */
> > -	ca->maxreqs =3D nfsd4_get_drc_mem(ca, nn);
> > =20
> >  	return nfs_ok;
> >  }
> > @@ -3836,11 +3772,11 @@ nfsd4_create_session(struct svc_rqst *rqstp,
> >  		return status;
> >  	status =3D check_backchannel_attrs(&cr_ses->back_channel);
> >  	if (status)
> > -		goto out_release_drc_mem;
> > +		goto out_err;
> >  	status =3D nfserr_jukebox;
> >  	new =3D alloc_session(&cr_ses->fore_channel, &cr_ses->back_channel);
> >  	if (!new)
> > -		goto out_release_drc_mem;
> > +		goto out_err;
> >  	conn =3D alloc_conn_from_crses(rqstp, cr_ses);
> >  	if (!conn)
> >  		goto out_free_session;
> > @@ -3950,8 +3886,7 @@ nfsd4_create_session(struct svc_rqst *rqstp,
> >  		expire_client(old);
> >  out_free_session:
> >  	__free_session(new);
> > -out_release_drc_mem:
> > -	nfsd4_put_drc_mem(&cr_ses->fore_channel);
> > +out_err:
> >  	return status;
> >  }
> > =20
> > diff --git a/fs/nfsd/nfsd.h b/fs/nfsd/nfsd.h
> > index 4b56ba1e8e48..3eb21e63b921 100644
> > --- a/fs/nfsd/nfsd.h
> > +++ b/fs/nfsd/nfsd.h
> > @@ -88,9 +88,6 @@ struct nfsd_genl_rqstp {
> >  extern struct svc_program	nfsd_programs[];
> >  extern const struct svc_version	nfsd_version2, nfsd_version3, nfsd_versi=
on4;
> >  extern struct mutex		nfsd_mutex;
> > -extern spinlock_t		nfsd_drc_lock;
> > -extern unsigned long		nfsd_drc_max_mem;
> > -extern unsigned long		nfsd_drc_mem_used;
> >  extern atomic_t			nfsd_th_cnt;		/* number of available threads */
> > =20
> >  extern const struct seq_operations nfs_exports_op;
> > diff --git a/fs/nfsd/nfssvc.c b/fs/nfsd/nfssvc.c
> > index 49e2f32102ab..3dbaefc96608 100644
> > --- a/fs/nfsd/nfssvc.c
> > +++ b/fs/nfsd/nfssvc.c
> > @@ -70,16 +70,6 @@ static __be32			nfsd_init_request(struct svc_rqst *,
> >   */
> >  DEFINE_MUTEX(nfsd_mutex);
> > =20
> > -/*
> > - * nfsd_drc_lock protects nfsd_drc_max_pages and nfsd_drc_pages_used.
> > - * nfsd_drc_max_pages limits the total amount of memory available for
> > - * version 4.1 DRC caches.
> > - * nfsd_drc_pages_used tracks the current version 4.1 DRC memory usage.
> > - */
> > -DEFINE_SPINLOCK(nfsd_drc_lock);
> > -unsigned long	nfsd_drc_max_mem;
> > -unsigned long	nfsd_drc_mem_used;
> > -
> >  #if IS_ENABLED(CONFIG_NFS_LOCALIO)
> >  static const struct svc_version *localio_versions[] =3D {
> >  	[1] =3D &localio_version1,
> > @@ -575,27 +565,6 @@ void nfsd_reset_versions(struct nfsd_net *nn)
> >  		}
> >  }
> > =20
> > -/*
> > - * Each session guarantees a negotiated per slot memory cache for replies
> > - * which in turn consumes memory beyond the v2/v3/v4.0 server. A dedicat=
ed
> > - * NFSv4.1 server might want to use more memory for a DRC than a machine
> > - * with mutiple services.
> > - *
> > - * Impose a hard limit on the number of pages for the DRC which varies
> > - * according to the machines free pages. This is of course only a defaul=
t.
> > - *
> > - * For now this is a #defined shift which could be under admin control
> > - * in the future.
> > - */
> > -static void set_max_drc(void)
> > -{
> > -	#define NFSD_DRC_SIZE_SHIFT	7
> > -	nfsd_drc_max_mem =3D (nr_free_buffer_pages()
> > -					>> NFSD_DRC_SIZE_SHIFT) * PAGE_SIZE;
> > -	nfsd_drc_mem_used =3D 0;
> > -	dprintk("%s nfsd_drc_max_mem %lu \n", __func__, nfsd_drc_max_mem);
> > -}
> > -
> >  static int nfsd_get_default_max_blksize(void)
> >  {
> >  	struct sysinfo i;
> > @@ -678,7 +647,6 @@ int nfsd_create_serv(struct net *net)
> >  	nn->nfsd_serv =3D serv;
> >  	spin_unlock(&nfsd_notifier_lock);
> > =20
> > -	set_max_drc();
> >  	/* check if the notifier is already set */
> >  	if (atomic_inc_return(&nfsd_notifier_refcount) =3D=3D 1) {
> >  		register_inetaddr_notifier(&nfsd_inetaddr_notifier);
> > diff --git a/fs/nfsd/state.h b/fs/nfsd/state.h
> > index 35b3564c065f..c052e9eea81b 100644
> > --- a/fs/nfsd/state.h
> > +++ b/fs/nfsd/state.h
> > @@ -310,7 +310,7 @@ struct nfsd4_session {
> >  	struct list_head	se_conns;
> >  	u32			se_cb_prog;
> >  	u32			se_cb_seq_nr;
> > -	struct nfsd4_slot	*se_slots[];	/* forward channel slots */
> > +	struct nfsd4_slot	*se_slots[NFSD_MAX_SLOTS_PER_SESSION];	/* forward cha=
nnel slots */
> >  };
> > =20
> >  /* formatted contents of nfs4_sessionid */
>=20
> I like this patch overall. One thing we could consider is allocating
> slots aggressively with GFP_KERNEL up to a particular threshold, and
> then switch to GFP_NOWAIT, but this seems like a reasonable place to
> start.

At this point (when creating the session) it is __GFP_NORETRY , not
GET_NOWAIT.  So it makes a decent effort but does give up earlier than
GFP_KERNEL.=20

What threshold should we use?  "1" seemed good to me as 1 is essential
but more is just for improved performance: wait for the client to
actually use them.

I'd rather allocate JIT than ASAP.

Thanks,
NeilBrown


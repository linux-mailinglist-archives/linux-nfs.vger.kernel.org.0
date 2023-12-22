Return-Path: <linux-nfs+bounces-780-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4349881D04B
	for <lists+linux-nfs@lfdr.de>; Sat, 23 Dec 2023 00:01:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E9CB32844AA
	for <lists+linux-nfs@lfdr.de>; Fri, 22 Dec 2023 23:01:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CABB2E853;
	Fri, 22 Dec 2023 23:01:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="wVRBnXHM";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="XirS/Gcu";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="wVRBnXHM";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="XirS/Gcu"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FB8D2E84F
	for <linux-nfs@vger.kernel.org>; Fri, 22 Dec 2023 23:01:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 705421FB9E;
	Fri, 22 Dec 2023 23:01:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1703286073; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vaBuhzaUFwW1f5syw4ZIlx0nYp4cUMHVncvG5D/cNnY=;
	b=wVRBnXHMQ8nAVF3lrSWCKmaAbVA28ib+WZj5/tQrWeaS7SqTU5pL6T6HZJ7nzKQ+dv79w4
	7b4VrcAWIskpNOYudvGWbfZkow7TzbNDzHNVI6CJ58kc4ukCjQlRgQ5j6jY55+kOORhNbY
	9wT4dWbL4QdzudO9FRzQ85e+NsLqbwI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1703286073;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vaBuhzaUFwW1f5syw4ZIlx0nYp4cUMHVncvG5D/cNnY=;
	b=XirS/Gcu2tFq2SJYVHLTllan0mYzfJTvB1DO09NU94qj17q5HJJjZJViAD/w5dSTRqCdxf
	tc6KLrVuxQi9NZCg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1703286073; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vaBuhzaUFwW1f5syw4ZIlx0nYp4cUMHVncvG5D/cNnY=;
	b=wVRBnXHMQ8nAVF3lrSWCKmaAbVA28ib+WZj5/tQrWeaS7SqTU5pL6T6HZJ7nzKQ+dv79w4
	7b4VrcAWIskpNOYudvGWbfZkow7TzbNDzHNVI6CJ58kc4ukCjQlRgQ5j6jY55+kOORhNbY
	9wT4dWbL4QdzudO9FRzQ85e+NsLqbwI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1703286073;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vaBuhzaUFwW1f5syw4ZIlx0nYp4cUMHVncvG5D/cNnY=;
	b=XirS/Gcu2tFq2SJYVHLTllan0mYzfJTvB1DO09NU94qj17q5HJJjZJViAD/w5dSTRqCdxf
	tc6KLrVuxQi9NZCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 1E79613997;
	Fri, 22 Dec 2023 23:01:10 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id Xs7iMTYVhmXUCQAAD6G6ig
	(envelope-from <neilb@suse.de>); Fri, 22 Dec 2023 23:01:10 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "NeilBrown" <neilb@suse.de>
To: dai.ngo@oracle.com
Cc: "Chuck Lever" <chuck.lever@oracle.com>, "Jeff Layton" <jlayton@kernel.org>,
 "J. Bruce Fields" <bfields@fieldses.org>,
 "Olga Kornievskaia" <kolga@netapp.com>, "Tom Talpey" <tom@talpey.com>,
 linux-nfs@vger.kernel.org
Subject: Re: [PATCH v2] nfsd: drop st_mutex and rp_mutex before calling
 move_to_close_lru()
In-reply-to: <eab63c76-6425-40c9-a078-ab6c4bdf10f8@oracle.com>
References: <170320926037.11005.9834662167645370066@noble.neil.brown.name>,
 <170321113026.11005.17173312563294650530@noble.neil.brown.name>,
 <eab63c76-6425-40c9-a078-ab6c4bdf10f8@oracle.com>
Date: Sat, 23 Dec 2023 10:01:08 +1100
Message-id: <170328606817.11005.12343520715219354379@noble.neil.brown.name>
X-Spam-Level: *****
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Level: 
X-Spam-Flag: NO
X-Spamd-Result: default: False [-5.31 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 DWL_DNSWL_MED(-2.00)[suse.de:dkim];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 DKIM_TRACE(0.00)[suse.de:+];
	 MX_GOOD(-0.01)[];
	 RCPT_COUNT_SEVEN(0.00)[7];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-3.00)[100.00%]
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=wVRBnXHM;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b="XirS/Gcu"
X-Spam-Score: -5.31
X-Rspamd-Queue-Id: 705421FB9E

On Sat, 23 Dec 2023, dai.ngo@oracle.com wrote:
> On 12/21/23 6:12 PM, NeilBrown wrote:
> > move_to_close_lru() is currently called with ->st_mutex and .rp_mutex hel=
d.
> > This can lead to a deadlock as move_to_close_lru() waits for sc_count to
> > drop to 2, and some threads holding a reference might be waiting for eith=
er
> > mutex.  These references will never be dropped so sc_count will never
> > reach 2.
>=20
> Yes, I think there is potential deadlock here since both nfs4_preprocess_se=
qid_op
> and nfsd4_find_and_lock_existing_open can increment the sc_count but then
> have to wait for the st_mutex which being held by move_to_close_lru.
>=20
> >
> > There can be no harm in dropping ->st_mutex to before
> > move_to_close_lru() because the only place that takes the mutex is
> > nfsd4_lock_ol_stateid(), and it quickly aborts if sc_type is
> > NFS4_CLOSED_STID, which it will be before move_to_close_lru() is called.
> >
> > Similarly dropping .rp_mutex is safe after the state is closed and so
> > no longer usable.  Another way to look at this is that nothing
> > significant happens between when nfsd4_close() now calls
> > nfsd4_cstate_clear_replay(), and where nfsd4_proc_compound calls
> > nfsd4_cstate_clear_replay() a little later.
> >
> > See also
> >   https://lore.kernel.org/lkml/4dd1fe21e11344e5969bb112e954affb@jd.com/T/
> > where this problem was raised but not successfully resolved.
> >
> > Signed-off-by: NeilBrown <neilb@suse.de>
> > ---
> >
> > Sorry - I posted v1 a little hastily.  I need to drop rp_mutex as well
> > to avoid the deadlock.  This also is safe.
> >
> >   fs/nfsd/nfs4state.c | 12 ++++++++----
> >   1 file changed, 8 insertions(+), 4 deletions(-)
> >
> > diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
> > index 40415929e2ae..453714fbcd66 100644
> > --- a/fs/nfsd/nfs4state.c
> > +++ b/fs/nfsd/nfs4state.c
> > @@ -7055,7 +7055,7 @@ nfsd4_open_downgrade(struct svc_rqst *rqstp,
> >   	return status;
> >   }
> >  =20
> > -static void nfsd4_close_open_stateid(struct nfs4_ol_stateid *s)
> > +static bool nfsd4_close_open_stateid(struct nfs4_ol_stateid *s)
> >   {
> >   	struct nfs4_client *clp =3D s->st_stid.sc_client;
> >   	bool unhashed;
> > @@ -7072,11 +7072,11 @@ static void nfsd4_close_open_stateid(struct nfs4_=
ol_stateid *s)
> >   		list_for_each_entry(stp, &reaplist, st_locks)
> >   			nfs4_free_cpntf_statelist(clp->net, &stp->st_stid);
> >   		free_ol_stateid_reaplist(&reaplist);
> > +		return false;
> >   	} else {
> >   		spin_unlock(&clp->cl_lock);
> >   		free_ol_stateid_reaplist(&reaplist);
> > -		if (unhashed)
> > -			move_to_close_lru(s, clp->net);
> > +		return unhashed;
> >   	}
> >   }
> >  =20
> > @@ -7092,6 +7092,7 @@ nfsd4_close(struct svc_rqst *rqstp, struct nfsd4_co=
mpound_state *cstate,
> >   	struct nfs4_ol_stateid *stp;
> >   	struct net *net =3D SVC_NET(rqstp);
> >   	struct nfsd_net *nn =3D net_generic(net, nfsd_net_id);
> > +	bool need_move_to_close_list;
> >  =20
> >   	dprintk("NFSD: nfsd4_close on file %pd\n",
> >   			cstate->current_fh.fh_dentry);
> > @@ -7114,8 +7115,11 @@ nfsd4_close(struct svc_rqst *rqstp, struct nfsd4_c=
ompound_state *cstate,
> >   	 */
> >   	nfs4_inc_and_copy_stateid(&close->cl_stateid, &stp->st_stid);
> >  =20
> > -	nfsd4_close_open_stateid(stp);
> > +	need_move_to_close_list =3D nfsd4_close_open_stateid(stp);
> >   	mutex_unlock(&stp->st_mutex);
> > +	nfsd4_cstate_clear_replay(cstate);
>=20
> should nfsd4_cstate_clear_replay be called only if need_move_to_close_list
> is true?

It certain could be done like that.

   if (need_move_to_close_list) {
         nfsd4_cstate_clear_replay(cstate);
         move_to_close_lru(stp, net);
   }

It would make almost no behavioural difference as
need_to_move_close_list is never true for v4.1 and later and almost
always true for v4.0, and nfsd4_cstate_clear_replay() does nothing for
v4.1 and later.
The only time behaviour would interrestingly different is when
nfsd4_close_open_stateid() found the state was already unlocked.  Then
need_move_to_close_list would be false, but nfsd4_cstate_clear_replay()
wouldn't be a no-op.

I thought the code was a little simpler the way I wrote it.  We don't
need the need_move_to_close_list guard on nfsd4_cstate_clear_replay(),
so I left it unguarded.
But I'm happy to change it if you can give a good reason - or even if
you just think it is clearer the other way.

Thanks,
NeilBrown

>=20
> -Dai
>=20
> > +	if (need_move_to_close_list)
> > +		move_to_close_lru(stp, net);
> >  =20
> >   	/* v4.1+ suggests that we send a special stateid in here, since the
> >   	 * clients should just ignore this anyway. Since this is not useful
>=20



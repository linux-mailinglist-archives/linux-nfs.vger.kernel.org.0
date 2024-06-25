Return-Path: <linux-nfs+bounces-4311-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B7E4E9174B0
	for <lists+linux-nfs@lfdr.de>; Wed, 26 Jun 2024 01:29:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DC1E21C21402
	for <lists+linux-nfs@lfdr.de>; Tue, 25 Jun 2024 23:29:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 839F517D88C;
	Tue, 25 Jun 2024 23:29:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="LxKjhVLW";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="ke35Ku7X";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="LxKjhVLW";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="ke35Ku7X"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5702E17CA0E
	for <linux-nfs@vger.kernel.org>; Tue, 25 Jun 2024 23:29:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719358164; cv=none; b=vAii3/rVZgOoplb1U1OtDDIXrN7ryrGWCfh3kHkZ9ZTYGL2Uso4+UF0tIHbInttGJQ2dME3P7kyKAiadtzD9zpjH/2HT3ofAxA5n0VZv+sIr4mBI0ZBSdNbIH0zaK+JXene20AaiWocw9V2CVDYWoMh7Wb7w15uUgBFqni1GlEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719358164; c=relaxed/simple;
	bh=/OEakSZtCFeJ67WztRya8ORX7/wQ0JPiDImI99ZnsKE=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=H/d7YRLVSPdeMgPhPLqbrhEhI5exsfcGznN3YA9F8IUGCpvubURgrjkwsRBhvwkw8iOm7t/2Z3zsgDZOJ2LeC494G6QGpxq7FznyNdrotkUoRP9o1Vvoz3RgpmG/HDVTkr0yxITO3ABBNh8orh+35UzOP5Ls3LpiohW2lSczctY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=LxKjhVLW; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=ke35Ku7X; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=LxKjhVLW; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=ke35Ku7X; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 5664D21A78;
	Tue, 25 Jun 2024 23:29:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1719358160; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qEnQYvw6ohdJOT9+emCgyN30HIeFHLLZvz6ygiV1SVo=;
	b=LxKjhVLWgzZebvqUa+yza7j0xlP6xreOCfQ8TuUCzR2YUXGiTqEMX48eUqp/HEig5Cd92E
	nkNToDegzgEqe2MMF8w/SJcFU5kIcYaDis1IeGNDYUuaSM50+6tshzEle6yQhsfMPtIsf6
	qv/w9TNnb4G8hcgJM+TfQWoC/XHWJ5I=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1719358160;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qEnQYvw6ohdJOT9+emCgyN30HIeFHLLZvz6ygiV1SVo=;
	b=ke35Ku7XwmcKnIjk+iIzYxTs4DG/aw8FMUly4yf2i/GwqQhyw18MDEYGmEChd3KhWkM4O4
	Qh8L0Z+qrTfoi6CQ==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=LxKjhVLW;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=ke35Ku7X
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1719358160; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qEnQYvw6ohdJOT9+emCgyN30HIeFHLLZvz6ygiV1SVo=;
	b=LxKjhVLWgzZebvqUa+yza7j0xlP6xreOCfQ8TuUCzR2YUXGiTqEMX48eUqp/HEig5Cd92E
	nkNToDegzgEqe2MMF8w/SJcFU5kIcYaDis1IeGNDYUuaSM50+6tshzEle6yQhsfMPtIsf6
	qv/w9TNnb4G8hcgJM+TfQWoC/XHWJ5I=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1719358160;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qEnQYvw6ohdJOT9+emCgyN30HIeFHLLZvz6ygiV1SVo=;
	b=ke35Ku7XwmcKnIjk+iIzYxTs4DG/aw8FMUly4yf2i/GwqQhyw18MDEYGmEChd3KhWkM4O4
	Qh8L0Z+qrTfoi6CQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 533EC1384C;
	Tue, 25 Jun 2024 23:29:16 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id nDU/OcxSe2b6SQAAD6G6ig
	(envelope-from <neilb@suse.de>); Tue, 25 Jun 2024 23:29:16 +0000
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
Cc: "Mike Snitzer" <snitzer@kernel.org>, linux-nfs@vger.kernel.org,
 "Chuck Lever" <chuck.lever@oracle.com>,
 "Trond Myklebust" <trondmy@hammerspace.com>, snitzer@hammerspace.com
Subject: Re: [PATCH v7 17/20] nfsd: use SRCU to dereference nn->nfsd_serv
In-reply-to: <9473de7704c599192a91b12465e3f6aba278d10e.camel@kernel.org>
References: <>, <9473de7704c599192a91b12465e3f6aba278d10e.camel@kernel.org>
Date: Wed, 26 Jun 2024 09:29:13 +1000
Message-id: <171935815356.14261.943840832291192923@noble.neil.brown.name>
X-Spamd-Result: default: False [-6.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	DWL_DNSWL_MED(-2.00)[suse.de:dkim];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	TO_DN_SOME(0.00)[];
	MISSING_XM_UA(0.00)[];
	ARC_NA(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.de:email,suse.de:dkim];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 5664D21A78
X-Spam-Flag: NO
X-Spam-Score: -6.51
X-Spam-Level: 

On Tue, 25 Jun 2024, Jeff Layton wrote:
> On Mon, 2024-06-24 at 12:27 -0400, Mike Snitzer wrote:
> > Introduce nfsd_serv_get, nfsd_serv_put and nfsd_serv_sync and update
> > the nfsd code to prevent nfsd_destroy_serv from destroying
> > nn->nfsd_serv until all nfsd code is done with it (particularly the
> > localio code that doesn't run in the context of nfsd's svc threads,
> > nor does it take the nfsd_mutex).
> >=20
> > Commit 83d5e5b0af90 ("dm: optimize use SRCU and RCU") provided a
> > familiar well-worn pattern for how implement.
> >=20
> > Suggested-by: NeilBrown <neilb@suse.de>
> > Signed-off-by: Mike Snitzer <snitzer@kernel.org>
> > ---
> > =C2=A0fs/nfsd/filecache.c | 13 ++++++++---
> > =C2=A0fs/nfsd/netns.h=C2=A0=C2=A0=C2=A0=C2=A0 | 14 ++++++++++--
> > =C2=A0fs/nfsd/nfs4state.c | 25 ++++++++++++++-------
> > =C2=A0fs/nfsd/nfsctl.c=C2=A0=C2=A0=C2=A0 |=C2=A0 7 ++++--
> > =C2=A0fs/nfsd/nfssvc.c=C2=A0=C2=A0=C2=A0 | 54 +++++++++++++++++++++++++++=
+++++++++---------
> > =C2=A05 files changed, 88 insertions(+), 25 deletions(-)
> >=20
> > diff --git a/fs/nfsd/filecache.c b/fs/nfsd/filecache.c
> > index 99631fa56662..474b3a3af3fb 100644
> > --- a/fs/nfsd/filecache.c
> > +++ b/fs/nfsd/filecache.c
> > @@ -413,12 +413,15 @@ nfsd_file_dispose_list_delayed(struct list_head *di=
spose)
> > =C2=A0		struct nfsd_file *nf =3D list_first_entry(dispose,
> > =C2=A0						struct nfsd_file, nf_lru);
> > =C2=A0		struct nfsd_net *nn =3D net_generic(nf->nf_net, nfsd_net_id);
> > +		int srcu_idx;
> > +		struct svc_serv *serv =3D nfsd_serv_get(nn, &srcu_idx);
> > =C2=A0		struct nfsd_fcache_disposal *l =3D nn->fcache_disposal;
> > =C2=A0
> > =C2=A0		spin_lock(&l->lock);
> > =C2=A0		list_move_tail(&nf->nf_lru, &l->freeme);
> > =C2=A0		spin_unlock(&l->lock);
> > -		svc_wake_up(nn->nfsd_serv);
> > +		svc_wake_up(serv);
> > +		nfsd_serv_put(nn, srcu_idx);
> > =C2=A0	}
> > =C2=A0}
> > =C2=A0
> > @@ -443,11 +446,15 @@ void nfsd_file_net_dispose(struct nfsd_net *nn)
> > =C2=A0		for (i =3D 0; i < 8 && !list_empty(&l->freeme); i++)
> > =C2=A0			list_move(l->freeme.next, &dispose);
> > =C2=A0		spin_unlock(&l->lock);
> > -		if (!list_empty(&l->freeme))
> > +		if (!list_empty(&l->freeme)) {
> > +			int srcu_idx;
> > +			struct svc_serv *serv =3D nfsd_serv_get(nn, &srcu_idx);
> > =C2=A0			/* Wake up another thread to share the work
> > =C2=A0			 * *before* doing any actual disposing.
> > =C2=A0			 */
> > -			svc_wake_up(nn->nfsd_serv);
> > +			svc_wake_up(serv);
> > +			nfsd_serv_put(nn, srcu_idx);
> > +		}
> > =C2=A0		nfsd_file_dispose_list(&dispose);
> > =C2=A0	}
> > =C2=A0}
> > diff --git a/fs/nfsd/netns.h b/fs/nfsd/netns.h
> > index 0c5a1d97e4ac..92d0d0883f17 100644
> > --- a/fs/nfsd/netns.h
> > +++ b/fs/nfsd/netns.h
> > @@ -139,8 +139,14 @@ struct nfsd_net {
> > =C2=A0	u32 clverifier_counter;
> > =C2=A0
> > =C2=A0	struct svc_info nfsd_info;
> > -#define nfsd_serv nfsd_info.serv
> > -
> > +	/*
> > +	 * The current 'nfsd_serv' at nfsd_info.serv.=C2=A0 Using 'void' rather=
 than
> > +	 * 'struct svc_serv' to guard against new code dereferencing nfsd_serv
> > +	 * without using proper synchronization.
> > +	 * Use nfsd_serv_get() or take nfsd_mutex to dereference.
> > +	 */
> > +	void __rcu *nfsd_serv;
> > +	struct srcu_struct nfsd_serv_srcu;
>=20
> I'm still not sold on the use of a void pointer here. It might protect
> you from using nn->nfsd_serv directly, but if you do:
>=20
>     struct svc_serv *serv =3D nn->nfsd_serv;
>=20
> ...that will still work. If you really want to guard against direct
> dereferencing, maybe it should be an unsigned long? Then you really
> will have to cast to use it.

I agree.  The point of the "__rcu" attribute is that sparse will
complain if you use the pointer without using srcu_dereference().
And CONFIG_PROVE_RCU gives you run-time splats.
We should use the tools we already have.

Thanks,
NeilBrown


>=20
> > =C2=A0
> > =C2=A0	/*
> > =C2=A0	 * clientid and stateid data for construction of net unique COPY
> > @@ -225,6 +231,10 @@ struct nfsd_net {
> > =C2=A0extern bool nfsd_support_version(int vers);
> > =C2=A0extern void nfsd_netns_free_versions(struct nfsd_net *nn);
> > =C2=A0
> > +extern struct svc_serv *nfsd_serv_get(struct nfsd_net *nn, int *srcu_idx=
);
> > +extern void nfsd_serv_put(struct nfsd_net *nn, int srcu_idx);
> > +extern void nfsd_serv_sync(struct nfsd_net *nn);
> > +
> > =C2=A0extern unsigned int nfsd_net_id;
> > =C2=A0
> > =C2=A0void nfsd_copy_write_verifier(__be32 verf[2], struct nfsd_net *nn);
> > diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
> > index a20c2c9d7d45..8876810e569d 100644
> > --- a/fs/nfsd/nfs4state.c
> > +++ b/fs/nfsd/nfs4state.c
> > @@ -1919,6 +1919,8 @@ static u32 nfsd4_get_drc_mem(struct nfsd4_channel_a=
ttrs *ca, struct nfsd_net *nn
> > =C2=A0	u32 num =3D ca->maxreqs;
> > =C2=A0	unsigned long avail, total_avail;
> > =C2=A0	unsigned int scale_factor;
> > +	int srcu_idx;
> > +	struct svc_serv *serv =3D nfsd_serv_get(nn, &srcu_idx);
> > =C2=A0
> > =C2=A0	spin_lock(&nfsd_drc_lock);
> > =C2=A0	if (nfsd_drc_max_mem > nfsd_drc_mem_used)
> > @@ -1940,7 +1942,7 @@ static u32 nfsd4_get_drc_mem(struct nfsd4_channel_a=
ttrs *ca, struct nfsd_net *nn
> > =C2=A0	 * Give the client one slot even if that would require
> > =C2=A0	 * over-allocation--it is better than failure.
> > =C2=A0	 */
> > -	scale_factor =3D max_t(unsigned int, 8, nn->nfsd_serv->sv_nrthreads);
> > +	scale_factor =3D max_t(unsigned int, 8, serv->sv_nrthreads);
> > =C2=A0
> > =C2=A0	avail =3D clamp_t(unsigned long, avail, slotsize,
> > =C2=A0			total_avail/scale_factor);
> > @@ -1949,6 +1951,8 @@ static u32 nfsd4_get_drc_mem(struct nfsd4_channel_a=
ttrs *ca, struct nfsd_net *nn
> > =C2=A0	nfsd_drc_mem_used +=3D num * slotsize;
> > =C2=A0	spin_unlock(&nfsd_drc_lock);
> > =C2=A0
> > +	nfsd_serv_put(nn, srcu_idx);
> > +
> > =C2=A0	return num;
> > =C2=A0}
> > =C2=A0
> > @@ -3702,12 +3706,16 @@ nfsd4_replay_create_session(struct nfsd4_create_s=
ession *cr_ses,
> > =C2=A0
> > =C2=A0static __be32 check_forechannel_attrs(struct nfsd4_channel_attrs *c=
a, struct nfsd_net *nn)
> > =C2=A0{
> > -	u32 maxrpc =3D nn->nfsd_serv->sv_max_mesg;
> > +	int srcu_idx;
> > +	struct svc_serv *serv =3D nfsd_serv_get(nn, &srcu_idx);
> > +	u32 maxrpc =3D serv->sv_max_mesg;
> > +	__be32 status =3D nfs_ok;
> > =C2=A0
> > -	if (ca->maxreq_sz < NFSD_MIN_REQ_HDR_SEQ_SZ)
> > -		return nfserr_toosmall;
> > -	if (ca->maxresp_sz < NFSD_MIN_RESP_HDR_SEQ_SZ)
> > -		return nfserr_toosmall;
> > +	if (ca->maxreq_sz < NFSD_MIN_REQ_HDR_SEQ_SZ ||
> > +	=C2=A0=C2=A0=C2=A0 ca->maxresp_sz < NFSD_MIN_RESP_HDR_SEQ_SZ) {
> > +		status =3D nfserr_toosmall;
> > +		goto out;
> > +	}
> > =C2=A0	ca->headerpadsz =3D 0;
> > =C2=A0	ca->maxreq_sz =3D min_t(u32, ca->maxreq_sz, maxrpc);
> > =C2=A0	ca->maxresp_sz =3D min_t(u32, ca->maxresp_sz, maxrpc);
> > @@ -3726,8 +3734,9 @@ static __be32 check_forechannel_attrs(struct nfsd4_=
channel_attrs *ca, struct nfs
> > =C2=A0	 * accounting is soft and provides no guarantees either way.
> > =C2=A0	 */
> > =C2=A0	ca->maxreqs =3D nfsd4_get_drc_mem(ca, nn);
> > -
> > -	return nfs_ok;
> > +out:
> > +	nfsd_serv_put(nn, srcu_idx);
> > +	return status;
> > =C2=A0}
> > =C2=A0
> > =C2=A0/*
> > diff --git a/fs/nfsd/nfsctl.c b/fs/nfsd/nfsctl.c
> > index 075ada559e18..d3eeb829bc9b 100644
> > --- a/fs/nfsd/nfsctl.c
> > +++ b/fs/nfsd/nfsctl.c
> > @@ -1569,10 +1569,12 @@ int nfsd_nl_rpc_status_get_dumpit(struct sk_buff =
*skb,
> > =C2=A0{
> > =C2=A0	struct nfsd_net *nn =3D net_generic(sock_net(skb->sk), nfsd_net_id=
);
> > =C2=A0	int i, ret, rqstp_index =3D 0;
> > +	int srcu_idx;
> > +	struct svc_serv *serv =3D nfsd_serv_get(nn, &srcu_idx);
> > =C2=A0
> > =C2=A0	rcu_read_lock();
> > =C2=A0
> > -	for (i =3D 0; i < nn->nfsd_serv->sv_nrpools; i++) {
> > +	for (i =3D 0; i < serv->sv_nrpools; i++) {
> > =C2=A0		struct svc_rqst *rqstp;
> > =C2=A0
> > =C2=A0		if (i < cb->args[0]) /* already consumed */
> > @@ -1580,7 +1582,7 @@ int nfsd_nl_rpc_status_get_dumpit(struct sk_buff *s=
kb,
> > =C2=A0
> > =C2=A0		rqstp_index =3D 0;
> > =C2=A0		list_for_each_entry_rcu(rqstp,
> > -				&nn->nfsd_serv->sv_pools[i].sp_all_threads,
> > +				&serv->sv_pools[i].sp_all_threads,
> > =C2=A0				rq_all) {
> > =C2=A0			struct nfsd_genl_rqstp genl_rqstp;
> > =C2=A0			unsigned int status_counter;
> > @@ -1645,6 +1647,7 @@ int nfsd_nl_rpc_status_get_dumpit(struct sk_buff *s=
kb,
> > =C2=A0	ret =3D skb->len;
> > =C2=A0out:
> > =C2=A0	rcu_read_unlock();
> > +	nfsd_serv_put(nn, srcu_idx);
> > =C2=A0
> > =C2=A0	return ret;
> > =C2=A0}
> > diff --git a/fs/nfsd/nfssvc.c b/fs/nfsd/nfssvc.c
> > index c16c7d630859..6f41fb832484 100644
> > --- a/fs/nfsd/nfssvc.c
> > +++ b/fs/nfsd/nfssvc.c
> > @@ -279,6 +279,26 @@ int nfsd_minorversion(struct nfsd_net *nn, u32 minor=
version, enum vers_op change
> > =C2=A0	return 0;
> > =C2=A0}
> > =C2=A0
> > +struct svc_serv *nfsd_serv_get(struct nfsd_net *nn, int *srcu_idx)
> > +	__acquires(nn->nfsd_serv_srcu)
> > +{
> > +	*srcu_idx =3D srcu_read_lock(&nn->nfsd_serv_srcu);
> > +
> > +	return srcu_dereference(nn->nfsd_serv, &nn->nfsd_serv_srcu);
> > +}
> > +
> > +void nfsd_serv_put(struct nfsd_net *nn, int srcu_idx)
> > +	__releases(nn->nfsd_serv_srcu)
> > +{
> > +	srcu_read_unlock(&nn->nfsd_serv_srcu, srcu_idx);
> > +}
> > +
> > +void nfsd_serv_sync(struct nfsd_net *nn)
> > +{
> > +	synchronize_srcu(&nn->nfsd_serv_srcu);
> > +	synchronize_rcu_expedited();
> > +}
> > +
> > =C2=A0/*
> > =C2=A0 * Maximum number of nfsd processes
> > =C2=A0 */
> > @@ -486,6 +506,7 @@ static void nfsd_shutdown_net(struct net *net)
> > =C2=A0		lockd_down(net);
> > =C2=A0		nn->lockd_up =3D false;
> > =C2=A0	}
> > +	cleanup_srcu_struct(&nn->nfsd_serv_srcu);
> > =C2=A0#if IS_ENABLED(CONFIG_NFSD_LOCALIO)
> > =C2=A0	list_del_rcu(&nn->nfsd_uuid.list);
> > =C2=A0#endif
> > @@ -493,6 +514,7 @@ static void nfsd_shutdown_net(struct net *net)
> > =C2=A0	nfsd_shutdown_generic();
> > =C2=A0}
> > =C2=A0
> > +// FIXME: nfsd_serv_{get,put} should make it safe to eliminate nfsd_noti=
fier_lock
> > =C2=A0static DEFINE_SPINLOCK(nfsd_notifier_lock);
> > =C2=A0static int nfsd_inetaddr_event(struct notifier_block *this, unsigne=
d long event,
> > =C2=A0	void *ptr)
> > @@ -502,20 +524,22 @@ static int nfsd_inetaddr_event(struct notifier_bloc=
k *this, unsigned long event,
> > =C2=A0	struct net *net =3D dev_net(dev);
> > =C2=A0	struct nfsd_net *nn =3D net_generic(net, nfsd_net_id);
> > =C2=A0	struct sockaddr_in sin;
> > +	int srcu_idx;
> > +	struct svc_serv *serv =3D nfsd_serv_get(nn, &srcu_idx);
> > =C2=A0
> > -	if (event !=3D NETDEV_DOWN || !nn->nfsd_serv)
> > +	if (event !=3D NETDEV_DOWN || !serv)
> > =C2=A0		goto out;
> > =C2=A0
> > =C2=A0	spin_lock(&nfsd_notifier_lock);
> > -	if (nn->nfsd_serv) {
> > +	if (serv) {
> > =C2=A0		dprintk("nfsd_inetaddr_event: removed %pI4\n", &ifa->ifa_local);
> > =C2=A0		sin.sin_family =3D AF_INET;
> > =C2=A0		sin.sin_addr.s_addr =3D ifa->ifa_local;
> > -		svc_age_temp_xprts_now(nn->nfsd_serv, (struct sockaddr *)&sin);
> > +		svc_age_temp_xprts_now(serv, (struct sockaddr *)&sin);
> > =C2=A0	}
> > =C2=A0	spin_unlock(&nfsd_notifier_lock);
> > -
> > =C2=A0out:
> > +	nfsd_serv_put(nn, srcu_idx);
> > =C2=A0	return NOTIFY_DONE;
> > =C2=A0}
> > =C2=A0
> > @@ -532,22 +556,24 @@ static int nfsd_inet6addr_event(struct notifier_blo=
ck *this,
> > =C2=A0	struct net *net =3D dev_net(dev);
> > =C2=A0	struct nfsd_net *nn =3D net_generic(net, nfsd_net_id);
> > =C2=A0	struct sockaddr_in6 sin6;
> > +	int srcu_idx;
> > +	struct svc_serv *serv =3D nfsd_serv_get(nn, &srcu_idx);
> > =C2=A0
> > -	if (event !=3D NETDEV_DOWN || !nn->nfsd_serv)
> > +	if (event !=3D NETDEV_DOWN || !serv)
> > =C2=A0		goto out;
> > =C2=A0
> > =C2=A0	spin_lock(&nfsd_notifier_lock);
> > -	if (nn->nfsd_serv) {
> > +	if (serv) {
> > =C2=A0		dprintk("nfsd_inet6addr_event: removed %pI6\n", &ifa->addr);
> > =C2=A0		sin6.sin6_family =3D AF_INET6;
> > =C2=A0		sin6.sin6_addr =3D ifa->addr;
> > =C2=A0		if (ipv6_addr_type(&sin6.sin6_addr) & IPV6_ADDR_LINKLOCAL)
> > =C2=A0			sin6.sin6_scope_id =3D ifa->idev->dev->ifindex;
> > -		svc_age_temp_xprts_now(nn->nfsd_serv, (struct sockaddr *)&sin6);
> > +		svc_age_temp_xprts_now(serv, (struct sockaddr *)&sin6);
> > =C2=A0	}
> > =C2=A0	spin_unlock(&nfsd_notifier_lock);
> > -
> > =C2=A0out:
> > +	nfsd_serv_put(nn, srcu_idx);
> > =C2=A0	return NOTIFY_DONE;
> > =C2=A0}
> > =C2=A0
> > @@ -568,9 +594,12 @@ void nfsd_destroy_serv(struct net *net)
> > =C2=A0	struct nfsd_net *nn =3D net_generic(net, nfsd_net_id);
> > =C2=A0	struct svc_serv *serv =3D nn->nfsd_serv;
> > =C2=A0
> > +	lockdep_assert_held(&nfsd_mutex);
> > +
> > =C2=A0	spin_lock(&nfsd_notifier_lock);
> > -	nn->nfsd_serv =3D NULL;
> > +	rcu_assign_pointer(nn->nfsd_serv, NULL);
> > =C2=A0	spin_unlock(&nfsd_notifier_lock);
> > +	nfsd_serv_sync(nn);
> > =C2=A0
> > =C2=A0	/* check if the notifier still has clients */
> > =C2=A0	if (atomic_dec_return(&nfsd_notifier_refcount) =3D=3D 0) {
> > @@ -690,6 +719,10 @@ int nfsd_create_serv(struct net *net)
> > =C2=A0	if (nn->nfsd_serv)
> > =C2=A0		return 0;
> > =C2=A0
> > +	error =3D init_srcu_struct(&nn->nfsd_serv_srcu);
> > +	if (error)
> > +		return error;
> > +
> > =C2=A0	if (nfsd_max_blksize =3D=3D 0)
> > =C2=A0		nfsd_max_blksize =3D nfsd_get_default_max_blksize();
> > =C2=A0	nfsd_reset_versions(nn);
> > @@ -707,7 +740,8 @@ int nfsd_create_serv(struct net *net)
> > =C2=A0	}
> > =C2=A0	spin_lock(&nfsd_notifier_lock);
> > =C2=A0	nn->nfsd_info.mutex =3D &nfsd_mutex;
> > -	nn->nfsd_serv =3D serv;
> > +	nn->nfsd_info.serv =3D serv;
> > +	rcu_assign_pointer(nn->nfsd_serv, nn->nfsd_info.serv);
> > =C2=A0	spin_unlock(&nfsd_notifier_lock);
> > =C2=A0
> > =C2=A0	set_max_drc();
>=20
> --=20
> Jeff Layton <jlayton@kernel.org>
>=20


